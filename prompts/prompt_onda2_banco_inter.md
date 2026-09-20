# Onda 2 — Boleto × Banco Inter (Cobrança v3)

**Escopo**: misto (canal API com banco, apresentação do boleto e voz do banco são método portável;
Inter, sandbox e credenciais da Setes são conteúdo `setes`)
**Fase-mãe**: `prompt_primeiro_cliente_setes.md` (D2 escopo completo · D15/D16 destinação e duas
referências · D33 ordem Inter → NFS-e → Produção)
**Aberto em**: 2026-09-19 (Rodada 0 = parecer do guardião conceitual, agente `setes-conceito`)
**Estado**: Rodada 0 ORGANIZADA · **Rodada 1 DECIDIDA (2026-09-19, "siga as recomendações" → D-I2…D-I18)** · contrato oficial em mãos (§1.1) · Q15 pende só das credenciais (client_id/secret + sandbox) · **EXECUÇÃO em andamento — ver §9 (checkpoint 2026-09-19/20)**

---

## 1. Contexto

Hoje o boleto nasce e vive só aqui: `tb_bank_slip` imutável + `tb_bank_slip_title` + história
`tb_bank_slip_event` (E emitido / L liquidado / C cancelado / X estornado; estado DERIVADO do último
evento), com a peça `@shared/bank-slip` (`issueBankSlip`, `settleBankSlip`, `cancelBankSlip`,
`reverseBankSlipSettlement`, `findOpenSlip`). O §6 do `prompt_boleto_emitido.md` deixou o CANAL
(CNAB/API) de fora de propósito: "o boleto nasce pronto sem reforma", com as letras S/G/A de evento
**reservadas ao canal** (D4 do boleto).

Os 9 passos do Valdo (§8 da fase): ordem a partir do contrato → faturar → financeiro → **do
financeiro saem os boletos** → transmitir ao Inter → Inter gera o boleto oficial e envia ao cliente →
vincular o registro do Inter ao sistema → webhook atualiza o status → pago, baixa conforme o retorno.
Na Setes `auto_bank_slip` fica DESLIGADA: o boleto sai da tela de Boletos, agrupável (P0.5).

**D33**: Inter vem ANTES da produção. Sem URL pública o **webhook só liga na Onda 4**; até lá a
**consulta ativa** ao banco (por `codigoSolicitacao`) faz o papel. O endpoint do webhook nasce agora e
fica testado.

### A API do Inter (Cobrança v3) — fatos que impõem o modelo

| Item | Fato |
|---|---|
| Ambientes | sandbox `cdpj-sandbox.partners.uatinter.co/cobranca/v3/` · produção `cdpj.partners.bancointer.com.br/cobranca/v3/` |
| Autenticação | OAuth2 `client_credentials` (`/oauth/v2/token`, escopos `boleto-cobranca.read/write`) **+ certificado mTLS** (`.crt/.key` da aplicação); conta no header `X_INTER_CONTA_CORRENTE` |
| Emissão | **assíncrona** — o POST devolve só `codigoSolicitacao`; `seuNumero` é o identificador NOSSO no payload |
| Dados do boleto | `nossoNumero`, `linhaDigitavel`, `codigoBarras`, `pixCopiaECola` só na CONSULTA posterior |
| Situações | `EM_PROCESSAMENTO`, `A_RECEBER`, `RECEBIDO`, `MARCADO_RECEBIDO`, `ATRASADO`, `CANCELADO`, `EXPIRADO`, **`FALHA_EMISSAO`** |
| Webhook | criar/consultar/excluir; payload `codigoSolicitacao`, `seuNumero`, `situacao`, `dataHoraSituacao`; reenvia em não-2xx |
| Outras | consulta detalhada, PDF, cancelamento/baixa com motivo |

### 1.1 Contrato oficial — CONFIRMADO (2026-09-19)

As specs OpenAPI foram extraídas do bundle do portal `developers.inter.co` e guardadas em
`Infra-IA/setes-api/integracoes/banco-inter/` (`cobranca-v3`, `oauth-token`, `banking-v2` + README com
os fatos). Não é preciso o Valdo fornecer manual. O que a spec CORRIGE/ACRESCENTA à tabela acima:

- Header é `x-conta-corrente` (minúsculo), opcional quando a aplicação tem uma conta só.
- `seuNumero` **max 15** (nosso `our_number` = `String(id)` cabe; a peça valida).
- `numDiasAgenda` (0..60) é OBRIGATÓRIO no emitir → Q18.
- Situações da consulta incluem **`PROTESTO`**; o **callback** só notifica `RECEBIDO`, `A_RECEBER`,
  `MARCADO_RECEBIDO`, `CANCELADO`, `EXPIRADO`, `FALHA_EMISSAO` (ATRASADO/PROTESTO só pela consulta).
- Cancelar responde **202** (assíncrono): o aceite não é o cancelamento — a confirmação vem pela consulta.
- PDF vem em **base64** no JSON. Editar vencimento/valor existe (`PATCH`, assíncrono com `codigoEdicao`).
- **Rate limits**: token 5/min (cachear 1 h) · consulta/emitir/PDF/cancelar 120/min produção e
  **10/min sandbox** · webhook 5/min. A consulta ao abrir a tela precisa de THROTTLE.
- Webhook: reenvio automático até 4× (20/30/60/120 min) em não-2xx; `GET /cobrancas/webhook/callbacks`
  lista disparos; `POST /webhook/callbacks/retry` reenvia até 50 códigos.
- `GET /cobrancas?dataInicial&dataFinal&seuNumero` é a porta da reconciliação de órfãos (Q12).
- Sandbox tem `POST /cobrancas/{codigoSolicitacao}/pagar {pagarCom}` para simular o pagamento — é o
  que prova o critério 2 sem dinheiro real.
- Pagador exige `cpfCnpj`, `tipoPessoa`, `nome ≤100`, `endereco ≤100`, `cidade ≤60`, `uf`, `cep 8`
  (`bairro` opcional) — confirma a Q16.

## 2. Objetivos (numerados)

1. Registrar no Inter um boleto emitido aqui, guardando as DUAS referências (D16) e a história da
   conversa com o banco.
2. Trazer linha digitável, código de barras, QR Pix e PDF para a tela de Boletos.
3. Liquidar automaticamente o boleto quando o banco disser `RECEBIDO` — pela peça `settleBankSlip`
   que já existe — sem nunca baixar duas vezes e sem nunca perder o fato quando a baixa for recusada.
4. Cancelar no banco quando cancelar aqui, e refletir aqui o que o banco cancelar/expirar.
5. Endpoint do webhook pronto e testado (liga na Onda 4); consulta ativa como ponte (D33).
6. Segredos (client_secret, certificado, chave) **nunca no repositório nem em tabela**.
7. Trilha: P7b vira OK (registro + consulta + baixa por consulta no sandbox).

## 3. Modelo (Rodada 0 — parecer do guardião, 2026-09-19)

"Integrar o boleto com o Inter" tem "e" escondido: são **três conceitos**, separados pelo fato gerador.

| # | Conceito (uma frase) | Fato gerador | Natureza |
|---|---|---|---|
| A | Esta conta corrente fala com o seu banco por API | habilitação da aplicação no portal do banco | peça — especialização da CONTA |
| B | Um boleto foi apresentado ao banco para registro | o envio (POST → `codigoSolicitacao`) | peça — 1 boleto × N apresentações |
| C | O banco disse algo sobre essa apresentação | cada situação informada (webhook ou consulta) | peça — história append-only da voz do banco |

O boleto interno **não muda de forma**: só recebe EFEITOS (L/C com `source='A'`) produzidos por uma
composição nova.

### A. `tb_bank_account_channel` — o canal API da conta (schema do cliente)

PK `(tb_bank_account_id, tb_institution_id)` — **1 canal por conta**, especialização por PK (como
`tb_settlement_rule` especializa o vínculo). Pendurado na CONTA, não na carteira nem na forma
(alerta do §7 da fase): N carteiras da mesma conta usam a MESMA credencial, e o mesmo canal servirá
amanhã ao extrato/saldo por API, que não tem carteira.

- **É dado**: `environment` char(1) S sandbox / P produção · `client_id` (identificador público da
  aplicação OAuth) · `active` · `inbound_token` UNIQUE (chave que NÓS emitimos para o banco nos
  chamar — precedente `tb_sync_api_key`) · colunas padrão.
- **Nunca é dado**: `client_secret`, `.crt`, `.key`, token OAuth (cache em memória). Anti-exemplo do
  legado: `tb_config_nfe.certificate_pass`. Peça genérica **`@shared/secret-store`**: `SECRETS_PATH`
  (irmã do `STORAGE_PATH`), caminho DERIVADO da identidade —
  `<SECRETS_PATH>/<schema>/bank-account/<id>/<S|P>/client.crt|client.key|client_secret` — upload
  write-only (adminGuard); leitura devolve só presença + validade do certificado (`notAfter` lido na
  hora — o do Inter expira em 1 ano). A mesma peça serve o A1 da NFS-e (Onda 3). Cofre na Onda 4
  ATRÁS da peça.
- **Derivado, sem coluna**: provider/adaptador = `tb_bank_account.tb_bank_id → tb_bank.number`
  ('077' Inter; banco sem adaptador → 422) · conta do header = `number + number_dv` · escopos =
  constante do adaptador · "webhook cadastrado" = estado REMOTO, consulta-se.

### B. `tb_bank_slip_registration` — a apresentação do boleto ao banco

PK `(tb_institution_id, tb_bank_slip_id, attempt)`; `attempt` 1..N (FALHA_EMISSAO + retentativa =
attempt 2 no MESMO boleto, mesmo `our_number` — D16). Imutável após nascer, com uma exceção
deliberada (write-once).

- `request_code` varchar(36) = `codigoSolicitacao`, **UNIQUE `(tb_institution_id, request_code)`**
  (toda notificação entra por ela); NULL só quando o POST foi recusado sem código.
- `environment` char(1) CONGELADO do canal no envio (o mesmo código em sandbox e produção são
  universos diferentes).
- `bank_our_number`, `digitable_line` (47), `barcode` (44), `pix_copy_paste` — **write-once**: a
  peça preenche uma vez, de NULL para valor, quando a consulta os trouxer. São atributos do
  instrumento registrado, imutáveis no banco também.
- `tb_user_id`, colunas padrão.
- Fora: PDF (sob demanda no banco; cache opcional em `STORAGE_PATH` por convenção), dados do pagador
  (cadeia da entidade na hora do envio), `seuNumero` (= `our_number`).

### C. `tb_bank_slip_registration_event` — a voz do banco (append-only)

PK `(tb_institution_id, tb_bank_slip_id, attempt, event)`.
- `kind` char(1), NOSSA leitura: **S** enviado · **G** registrado (A_RECEBER) · **R** recebido ·
  **M** marcado recebido · **A** atrasado · **C** cancelado no banco · **V** expirado · **F** falha.
- `bank_status` varchar(30) — a situação CRUA do banco; desconhecida → o adaptador falha alto.
- `dt_bank_status` datetime (`dataHoraSituacao`) · `source` char(1) **W** webhook / **Q** consulta /
  **P** resposta direta ao nosso POST-cancelamento · `paid_value` (no R) · `slip_event` int NULL =
  causa → efeito (o L ou C em `tb_bank_slip_event`; precedente `tb_check_event.payment_event`) ·
  `message` · colunas padrão.
- **Idempotência por construção**: grava só quando `(kind, dt_bank_status)` difere do último da
  apresentação; cinto UNIQUE `(…, attempt, kind, dt_bank_status)`. Lock: `lockSlip` (FOR UPDATE no
  boleto) ANTES de ler o último evento — dois webhooks simultâneos serializam no boleto.

### Composições

**`@shared/bank-channel`** (PEÇA): resolve o canal da conta, lê segredos pela `secret-store`, cache
do token, despacha para `adapters/inter.ts` pelo número do banco. Interface: `register(payload) →
requestCode` · `query(requestCode)` · `cancel(requestCode, reason)` · `pdf(requestCode)` ·
`webhook.create/get/delete`. Não conhece boleto; amanhã ganha `statement()`.

**`@shared/bank-slip-registration`** (COMPOSIÇÃO bank-slip + bank-channel + settlement):
1. `registerBankSlip` — trava o boleto (aberto, sem apresentação vigente), monta o payload da cadeia
   da entidade, chama o banco e DEPOIS grava apresentação + evento S (ou F) na mesma transação. A
   chamada externa fica fora da transação; órfão no banco (crash entre o "sim" e o commit) é
   reconciliado por `seuNumero` na rotina de consulta.
2. `refreshBankSlipRegistration` — `query`; se mudou, grava evento e chama `applyBankStatus`;
   preenche os write-once na primeira vez.
3. `applyBankStatus` — a ÚNICA porta de efeitos:

| Voz do banco | Evento C | Efeito no boleto |
|---|---|---|
| A_RECEBER | G | nenhum |
| ATRASADO | A | nenhum (nosso "vencido" já é derivado) |
| RECEBIDO | R (paid_value, dt) | **L** `source='A'` via `settleBankSlip` com valor/data do BANCO |
| MARCADO_RECEBIDO | M | nenhum — dinheiro entrou por outro meio; PENDÊNCIA na tela |
| CANCELADO (portal do banco) | C | **C** `source='A'` via `cancelBankSlip` |
| EXPIRADO | V | **C** `source='A'` (instrumento morto no banco; manter 'open' bloquearia a reemissão) |
| FALHA_EMISSAO | F | nenhum — boleto segue 'open', apto a `attempt+1` |

   O efeito roda em SAVEPOINT: se `settleBankSlip` recusar (abaixo do mínimo, boleto já cancelado),
   **o fato do banco fica gravado** (R com `slip_event` NULL) e vira pendência legível na tela. O
   mesmo webhook 2× não baixa 2× por construção.
4. `cancelRegisteredBankSlip` — **banco primeiro**: só com o aceite grava C na apresentação e o C do
   boleto; banco fora → fail-closed (409/503 "tente depois"). Boleto nunca enviado cancela local.

**Webhook = gatilho, consulta = verdade**: `POST /api/bank-channel-webhook/:inboundToken` (sem JWT —
exceção nomeada) identifica o canal pelo token, localiza a apresentação pelo `codigoSolicitacao` e
dispara `refreshBankSlipRegistration`; nunca liquida pelo payload. Ondas 2 e 4 = o MESMO caminho.
Gatilho da Onda 2: `POST /api/bank-slips/refresh` ao abrir a tela + botão "Atualizar com o banco".

### Peças reusadas sem alteração
`tb_bank_slip`/`_title`/`_event` e a peça `@shared/bank-slip` · `settleBatchTx` + `settled_code` ·
`tb_bank_account` (especializada por PK) · `tb_bank.number` · `tb_bank_charge_agreement` (intocada) ·
padrão de evento do cheque · `withDeadlockRetry` + `contention` · SAVEPOINT do billing · Framework
de Configurações (interface kind 'R') · `STORAGE_PATH` → `SECRETS_PATH` · `tb_sync_api_key` →
`inbound_token` · cadeia da entidade (pagador) · `error-codes.ts`.

### O que vira MAQUETE se modelar errado
Colunas de estado bancário no `tb_bank_slip` · credencial na carteira · secret em tabela · coluna
`provider` no canal · linha digitável como coluna nula do evento · liquidar pelo payload do webhook ·
flag `webhook_registered` · `slip.state = 'ATRASADO'` · `tb_integration_log(json)` · UNIQUE de
apresentação por boleto (recria o `BLT_CODQTC`).

## 4. Nomes

| Objeto | Nome |
|---|---|
| Canal API da conta | `tb_bank_account_channel` |
| Apresentação ao banco | `tb_bank_slip_registration` |
| Voz do banco | `tb_bank_slip_registration_event` |
| Peça de transporte | `@shared/bank-channel` + `adapters/inter.ts` |
| Composição | `@shared/bank-slip-registration` |
| Segredos | `@shared/secret-store` + `SECRETS_PATH` |
| Tela | aba **"Canal API"** em `bank-accounts` (interface kind 'R'); apresentação/voz na tela de processo `bank-slips` (linha do tempo + "Registrar no banco", "Atualizar", "PDF", "Cancelar") |
| Endpoints | `POST /api/bank-slips/:id/register` · `POST /api/bank-slips/refresh` · `GET /api/bank-slips/:id/pdf` · `POST /api/bank-channel-webhook/:inboundToken` |
| Códigos | `BANK_CHANNEL_MISSING` · `BANK_CHANNEL_NO_ADAPTER` · `BANK_CHANNEL_SECRET_MISSING` · `BANK_CHANNEL_CERT_EXPIRED` · `BANK_SLIP_ALREADY_REGISTERED` · `BANK_SLIP_REGISTRATION_FAILED` · `BANK_UNAVAILABLE` · `BANK_STATUS_UNKNOWN` |

Linhas para a tabela de palavras ocupadas (entram na skill ao executar): **registro** (apresentação
ao banco `_registration` × "registros ativos" × linha) · **canal** (`_channel` = porta API da CONTA;
CNAB é layout da CARTEIRA) · **integração** (palavra de formato — não nomeia tabela/peça) · **conta**
(a do header é derivada de `tb_bank_account.number`).

## 5. Fora de escopo desta onda
Cadastro do webhook no banco, cron de consulta, cofre/KMS, produção (Onda 4) · extrato/saldo por API
· boleto de contas a PAGAR · CNAB (layout/remessa) · Pix avulso · e-mail ao cliente ·
`tb_bank_charge_kind/_ticket` (seguem vazios).

## 6. Critérios de sucesso (testáveis)
1. Boleto emitido aqui → "Registrar no banco" → apresentação com `codigoSolicitacao` e evento S; consulta traz linha digitável/pix (write-once) e evento G.
2. Sandbox marcado RECEBIDO → consulta → evento R + L `source='A'` com o valor do banco; 2ª consulta igual não gera linha nem baixa.
3. FALHA_EMISSAO → F; nova apresentação `attempt 2` no mesmo boleto.
4. Cancelar aqui → banco aceita → C nos dois; banco fora → 409/503 e nada muda.
5. RECEBIDO recusado pelas nossas regras → fato gravado, `slip_event` NULL, pendência visível.
6. Webhook forjado (token errado / código desconhecido) → 404/401 sem efeito; token certo → dispara consulta (teste com o sandbox e com mock).
7. Nenhum segredo em tabela, log, JSON de resposta ou repositório (varredura).
8. Gates socrático ≥ 0.70 e adversarial sem HIGH; trilha P7b OK.

---

## 7. ⚠️ Rodada 1 — questões para o Valdo (recomendação entre parênteses)

**Modelo**
- **Q1** — Provider/adaptador DERIVADO do banco da conta (`tb_bank.number` '077'), sem coluna
  `provider`; gateway multi-banco seria peça irmã futura. *(Rec.: derivar.)*
- **Q2** — Segredos em arquivos sob `SECRETS_PATH` (fora do repo), caminho derivado da PK + ambiente,
  pela peça `@shared/secret-store` — a mesma que servirá o certificado A1 da NFS-e. `client_id` fica
  na tabela (é identificador, não senha). *(Rec.: sim; cofre só na Onda 4, atrás da peça.)*
- **Q3** — Canal como ABA vendável ("Canal API", interface kind 'R') dentro de `bank-accounts`, ×
  módulo próprio. *(Rec.: aba.)*
- **Q4** — **Liberar a reserva S/G/A da D4 do boleto**: a voz do banco vive em tabela própria;
  `tb_bank_slip_event` recebe do canal só L e C com `source='A'`. *(Rec.: liberar — a reserva foi
  feita antes de saber que o registro é 1 × N.)*
- **Q5** — Linha digitável, código de barras, pix e nossoNumero do banco: write-once na APRESENTAÇÃO ×
  atributos do evento G. *(Rec.: apresentação.)*

**Efeitos**
- **Q6** — Tabela de efeitos automáticos: RECEBIDO → L; CANCELADO e EXPIRADO → C; ATRASADO → nada;
  **MARCADO_RECEBIDO → só fato + pendência, sem L** (não sabemos por onde o dinheiro entrou).
  *(Rec.: como está.)*
- **Q7** — Cancelamento **banco primeiro**, fail-closed quando o banco está fora (sem "cancelar mesmo
  assim"). *(Rec.: sim.)*
- **Q8** — Webhook = gatilho, consulta = verdade; gatilho da Onda 2 = ao abrir a tela de Boletos +
  botão "Atualizar com o banco"; cron só na Onda 4. *(Rec.: sim.)*
- **Q9** — RECEBIDO que nossas regras recusam: fato gravado, efeito recusado em SAVEPOINT, pendência
  legível, operador resolve à mão. *(Rec.: sim — nunca baixar forçado, nunca perder o fato.)*
- **Q10** — Estorno (X) de um L vindo do banco: permitido; a apresentação segue R e a divergência fica
  visível. *(Rec.: permitir.)*

**Contrato com o banco (provar no sandbox antes do DDL final)**
- **Q11** — Retentativa após FALHA_EMISSAO reusa o mesmo `seuNumero`? Se o banco recusar, o adaptador
  sufixa o `attempt` e a apresentação ganha `sent_reference`. *(Rec.: provar; coluna só se exigido.)*
  Fato da spec: `seuNumero` é livre (max 15) e a listagem filtra por ele — nada indica unicidade
  imposta pelo banco; prova no sandbox decide a coluna.
- **Q12** — Órfão no banco (crash entre o "sim" do Inter e o nosso commit): reconciliação por
  `seuNumero` na rotina de consulta, criando a apresentação retroativa. *(Rec.: entra nesta onda.)*
- **Q13** — Conta do header `X_INTER_CONTA_CORRENTE` derivada de `number + number_dv`, sem coluna.
  *(Rec.: derivar.)*
- **Q14** — Autenticação de entrada do webhook: `inbound_token` por canal no path + payload nunca é
  verdade. *(Rec.: sim.)*

**Operacionais (minhas)**
- **Q15** — Credenciais do sandbox: quem fornece `client_id`/`secret`/certificado e para onde vão no
  dev (`SECRETS_PATH` local, fora do repo; eu nunca os vejo no chat). Há conta sandbox própria ou é
  a aplicação de produção? *(Rec.: você coloca os arquivos no caminho; eu só leio presença.)*
  **Parcialmente respondida (2026-09-19)**: o Valdo apontou `D:\Download\Inter_API-Chave_e_Certificado.zip`
  como modelo — ver "Fatos do certificado" abaixo. Falta: `client_id`/`client_secret` da aplicação e
  confirmar se a mesma aplicação/certificado vale no sandbox (o Inter emite o certificado por
  aplicação; o ambiente é escolhido pela URL). Os arquivos NÃO foram copiados para lugar nenhum:
  entram no `SECRETS_PATH` quando a Q2 estiver decidida.
- **Q16** — Pagador: o Inter exige CPF/CNPJ, nome, endereço, cidade, UF, CEP. Cliente sem endereço
  completo: recusar o registro com 422 legível (e o boleto fica emitido aqui) × registrar com o que
  há. *(Rec.: recusar com o campo apontado — dado cadastral se corrige no cliente.)*
- **Q17** — Escopo da tela nesta onda: linha do tempo da voz do banco + 4 ações no detalhe do boleto
  + aba Canal API na conta (upload write-only dos 3 arquivos + validade do certificado), sem lista
  própria de "pendências do banco" (a pendência aparece no boleto). *(Rec.: sim.)*
- **Q18** (da spec) — `numDiasAgenda` obrigatório (0..60 dias após o vencimento até o banco cancelar
  sozinho). 0 = expira no vencimento e nós cancelaríamos aqui em cascata (Q6) — ruim para quem paga
  atrasado; 60 = janela máxima, o cancelamento continua sendo ATO nosso. Fonte: constante do adaptador
  agora; se um dia virar escolha por carteira, entra como coluna da carteira. *(Rec.: 60, constante.)*

### Rodada 1 — DECIDIDA (Valdo 2026-09-19: "siga as recomendações")

Q1–Q18 pelas recomendações → **D-I2…D-I19** (numeração segue D-I1): D-I2 provider derivado do banco
da conta · D-I3 segredos em `SECRETS_PATH` pela `@shared/secret-store`, `client_id` na tabela ·
D-I4 canal como aba vendável de `bank-accounts` · **D-I5 reserva S/G/A da D4 do boleto LIBERADA** (voz
do banco em tabela própria; `tb_bank_slip_event` recebe só L/C `source='A'`) · D-I6 dados do banco
write-once na apresentação · D-I7 tabela de efeitos do §3 (MARCADO_RECEBIDO só pendência; PROTESTO
kind `P`, sem efeito) · D-I8 cancelamento banco primeiro, fail-closed · D-I9 webhook gatilho, consulta
verdade; gatilho da onda = abrir a tela + botão, com THROTTLE · D-I10 RECEBIDO recusado = fato gravado
+ pendência · D-I11 X de L do banco permitido · D-I12 `seuNumero` reusado até o sandbox dizer não ·
D-I13 reconciliação de órfãos por `seuNumero` nesta onda · D-I14 conta do header derivada ·
D-I15 `inbound_token` no path do webhook · D-I16 credenciais: o Valdo coloca os arquivos no
`SECRETS_PATH` (pendem `client_id`/`secret` e a confirmação do sandbox) · D-I17 pagador incompleto →
422 com o campo · D-I18 escopo da tela como proposto · D-I19 `numDiasAgenda` = 60, constante.

---

## 8. Decisões registradas

- **D-I1 (Valdo 2026-09-19)** — *"certificado digital para emissão de nota é outro documento que não
  tem relação com o boleto."* O certificado mTLS do Inter é da **aplicação da CONTA** (canal API:
  `.crt` PEM + `.key` PKCS#8 emitidos pelo próprio Inter, CA "API Intermediate Certificate Authority");
  o certificado digital A1 da NFS-e é do **estabelecimento emissor** (e-CNPJ, normalmente .pfx/.p12,
  emitido por AC do ICP-Brasil) e pertence à Onda 3. Consequências para a `@shared/secret-store`
  (Q2): identidade do segredo = DONO + finalidade — `bank-account/<id>/<S|P>/…` para o canal e
  `establishment/<id>/…` para o fiscal —, formatos distintos aceitos (PEM × PKCS#12 com senha), e
  a validade de cada um é lida do próprio arquivo; nenhum campo em comum, nenhuma tabela "de
  certificados". A peça é uma; os segredos nunca se misturam.

### Fatos do certificado modelo (público — sem chave nem segredo)

| Item | Valor |
|---|---|
| Arquivos no zip | `Inter API_Certificado.crt` (PEM, 1.654 bytes) · `Inter API_Chave.key` (PEM `PRIVATE KEY` PKCS#8, 1.704 bytes) |
| Subject | C=BR, ST=PR, L=CURITIBA, OU=`efda75af-…` (identificador da aplicação), CN=F D SOUZA DESENVOLVIMENTO E LICENCIAMENTO DE PROGRAMAS |
| Emissor | API Intermediate Certificate Authority (Banco Inter, BH/MG) |
| Validade | **2026-09-03 → 2027-09-03** — expira em 1 ano; a aba Canal API precisa avisar a partir de ~30 dias antes |
| Formato para o Node | `https.Agent({ cert, key })` direto do PEM — sem conversão |

⚠️ Higiene: o zip fica em `D:\Download` até entrar no `SECRETS_PATH`; depois disso, apagar a cópia
solta. Nunca versionar, nunca colar no chat.

---

## 9. Execução — CHECKPOINT (sessão de 2026-09-19 → 20, contexto estourou; retomar por aqui)

### Entregue e verificado (API — 948/948 jest, `tsc` limpo; app — analyze limpo, 67/67)

**Peças (setes-api)**
- `@shared/secret-store` — segredos por DONO + FINALIDADE em `SECRETS_PATH` (default `./secrets`,
  gitignored junto com `storage/`; `.env.example` ganhou a chave). Caminho DERIVADO
  `<schema>/<owner>/<id>/<S|P>/<name>`, componentes validados, leitura ausente = 409 com código,
  `certificateInfo` lê validade do PEM (D-I1/D-I3).
- **Migration 055** (aplicada no dev) + DDL canônico `sql/03`: `tb_bank_account_channel` (PK da conta,
  environment, client_id, inbound_token UNIQUE, active), `tb_bank_slip_registration` (attempt,
  environment congelado, request_code UNIQUE, write-once linha/barras/pix/nosso nº do banco),
  `tb_bank_slip_registration_event` (kind S/G/R/M/A/P/C/V/F/K, bank_status cru, source W/Q/P,
  paid_value/paid_by, `slip_event` causa→efeito, UNIQUE de idempotência).
- `@shared/bank-channel` — peça: repositório do canal (upsert/rotate/soft delete/token de entrada),
  `openBankChannel` (canal ativo + adaptador pelo `tb_bank.number` + segredos + certificado válido; opção
  `environment` para consultar apresentação congelada em S depois de o canal virar P),
  `channelSecretsStatus`, transporte `https-json.ts` (mTLS com `https.request`, timeout 15 s,
  tradução única de falhas: 503 BANK_UNAVAILABLE · 409 BANK_AUTH_FAILED · 404 · 503 BANK_RATE_LIMITED
  · 422 BANK_REJECTED com `violacoes`), `transport` injetável para testes. **Adaptador Inter**
  (`adapters/inter.ts`): token form-urlencoded cacheado por canal (renova 60 s antes; 401 invalida e
  refaz 1×), header `x-conta-corrente` derivado, emitir (`numDiasAgenda` 60 — D-I19, `seuNumero` ≤ 15,
  pagador, mensagem, multa/mora/desconto), consulta → situação neutra, cancelar (202), PDF base64,
  `findByReference`, webhook get/put/delete, `paySandbox`.
- `@shared/bank-slip-registration` — composição: `registerBankSlip` (pagador da cadeia da entidade
  com 422 BANK_PAYER_INCOMPLETE por campo — D-I17; **reserva** da tentativa sob `lockSlip` → banco FORA
  da transação → S ou F; em andamento < 10 min = 409 IN_PROGRESS, mais velha vira F),
  `refreshRegistration` (consulta fora, grava sob lock, write-once, **idempotente** por (kind, dt),
  `applyBankStatus` em SAVEPOINT: RECEBIDO → `settleBankSlip` source A com valor/data do banco;
  CANCELADO/EXPIRADO → `cancelBankSlip(..., 'A')`; M/A/P só fato; efeito recusado = fato gravado +
  `slip_event` NULL + mensagem "Efeito recusado" — D-I10; situação desconhecida → 502
  BANK_STATUS_UNKNOWN sem gravar), `cancelRegisteredBankSlip` (banco PRIMEIRO, fail-closed; aceite
  → C do boleto source M + evento K ligado), `refreshOpenRegistrations` (throttle 5 min, 8 por
  chamada, para cedo em BANK_UNAVAILABLE/RATE_LIMITED; antes reconcilia órfãos por seuNumero —
  D-I13), `handleWebhookItems` (gatilho → consulta, source W). `bank-slip.ts`: `lockSlip`/`LockedSlip`
  exportados; `cancelBankSlip` ganhou `source` opcional (default 'M').
- Módulos: `bank-accounts` sub-recurso **canal** (`GET/PUT/DELETE /:id/channel`,
  `PUT/DELETE /:id/channel/secrets` write-only, `POST /:id/channel/rotate-token`,
  `POST /:id/channel/test`, `GET/PUT/DELETE /:id/channel/webhook`; escritas com `adminGuard`);
  `bank-slips` (`POST /refresh` consulta ativa, `POST /:id/register`, `POST /:id/refresh`,
  `GET /:id/pdf` base64, `POST /:id/pay-sandbox`; `GET /:id` devolve `registrations` +
  `registrationEvents`; **`POST /:id/cancel` passou pela composição — banco primeiro**);
  rota PÚBLICA `POST /hooks/bank-channel/:institutionId/:token` (montada em `app.ts` antes do JWT,
  rate limit por IP; 404 indistinto; responde 200 e processa só os `codigoSolicitacao`). 18 códigos
  novos em `error-codes.ts` (rodar `npm run errors:gen` na implantação). Swagger completo.
- Testes novos: `secret-store`, `bank-channel-inter-adapter` (contrato com a spec), `bank-slip-registration`
  (orquestração, idempotência, efeitos, fail-closed, webhook), `bank-channel-webhook` (rota pública).
  Correção colateral: `bank-slip.test.ts` usava data UTC e quebrava depois das 21h (agora local).
- Scripts: `scripts/smoke-inter-sandbox.ts` (prova C1–C9 contra o sandbox pela API — só roda com
  credenciais); trilha **P7b** agora registra de verdade quando a conta da carteira tem canal ativo
  (prefere carteira de conta COM canal) e diz o motivo exato quando não tem (**20 OK · 4 PENDENTE**).

**App (setes-app)**
- `bank_slips`: entidades `BankSlipRegistration`/`BankSlipRegistrationEvent` (+ getters
  `lastRegistration`, `hasLiveRegistration`, `refusedEffects`), datasource/repositório/usecases
  `register`/`refresh`/`pdf`/`bankSync`, bloc (4 eventos + one-shot `BankSlipPdfReady`), tela: seção
  **"No banco"** no detalhe (apresentação, situação, código, linha digitável e Pix com copiar,
  PENDÊNCIAS em vermelho, botões Registrar/Atualizar/PDF, linha do tempo da voz do banco), botão
  "Atualizar com o banco" na AppBar da lista + consulta ativa silenciosa ao abrir; PDF abre em nova aba
  (`shared/web/open_data_url.dart`, `dart:html` só na web).
- `bank_accounts`: seção autônoma **"Canal API com o banco"** no form (só na edição; mesmo padrão da
  Chave de Sincronização do Institution): ambiente S/P, client_id, ativo, presença/validade dos
  segredos, upload write-only (colar PEMs + secret), "Testar conexão", caminho do webhook com copiar;
  banco sem adaptador mostra aviso. Datasource dedicado `BankAccountChannelDatasource`.
- i18n pt/en: ~37 chaves `forms.bankSlip.*` e ~30 `forms.bankAccount.channel*`.

### O que FALTA para fechar a Onda 2 (em ordem)
1. **Credenciais do sandbox (D-I16, Q15)**: `client_id` + `client_secret` da aplicação e confirmar se
   o certificado do zip vale no sandbox. Colocar em `setes-api/secrets/setes_setes/bank-account/<id>/S/`
   (`client.crt`, `client.key`, `client_secret`) OU enviar pela aba Canal API / pelo smoke com
   `INTER_CERT_PATH`/`INTER_KEY_PATH`/`INTER_CLIENT_SECRET`/`INTER_CLIENT_ID`. Precisa de uma conta
   bancária do banco **077** no schema (o smoke cria se faltar; o dev só tem a conta 1 = banco 001).
2. Rodar `npx tsx --require tsconfig-paths/register scripts/smoke-inter-sandbox.ts` → critérios 1, 2,
   4 (registro, RECEBIDO → L, PDF, idempotência). Provar Q11 (reuso do `seuNumero`) e Q12 (órfão).
3. Trilha: P7b deve virar OK (carteira numa conta com canal).
4. Testes do app para as entidades novas (fromJson/getters) — não escritos ainda.
5. **Gates** socrático + adversarial da onda (regra da casa) e correções em sessão.
6. Registrar D-I2…D-I19 no CLAUDE.md/INDICE/memória como EXECUTADAS; linhas de palavras ocupadas
   (registro/canal/integração/conta) na skill `guardiao-conceitual.md`; `npm run errors:gen` no dev.
7. Passeio logado (Claude in Chrome) na aba Canal API e no detalhe do boleto.

### Estado do ambiente (dev)
MySQL sobe só como administrador (o Valdo sobe à mão). API de dev pelo `preview_start` (launch.json
`setes-api`). Migration 055 aplicada em `setes_setes`. Resíduo: OS/boletos/contratos da trilha e dos
gates (contrato 50 excluído, 51 inativo; carteira e conta 1 = banco 001). Nada commitado até este
checkpoint — commit local feito ao fechar a sessão (sem push).

