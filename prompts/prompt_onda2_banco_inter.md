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

---

## 10. Gates da onda — EXECUTADOS com retrabalho em sessão (2026-09-19 → 20)

Sem credenciais do sandbox ainda (item 1 do §9 continua do Valdo). Tudo abaixo foi feito com o que
não depende delas: testes do app, sondas ao vivo contra o dev, os dois gates, o retrabalho e a re-prova.

### 10.1 Sondas ao vivo (dev, conta 077 DESCARTÁVEL + par PEM autoassinado — tudo removido no fim)
18 sondas de contrato responderam com código e envelope certos (403 do adminGuard, 422 banco sem
adaptador, 409 sem canal/sem apresentação, 404 indistinto do webhook, 400 do DTO). Achados:
**A1** chave privada PEM com corpo lixo era ACEITA (só o cabeçalho era conferido) e sobrescrevia a boa;
**A2** handshake mTLS recusado (`EPROTO tlsv1 alert unknown ca`) virava 503 "banco indisponível, tente
de novo" — o operador repetiria e empilharia tentativas F; **A4** `clientId` aceitava `../../etc/x`;
rajada de 160 chamadas no webhook não disparou o rate limit (é o global de 300/min por IP, não um
limite do webhook). Fail-closed do registro PROVADO ao vivo: 2 tentativas F, nenhuma S, nova
tentativa liberada.

### 10.2 Gate socrático — 1ª rodada **0.64 ✗**
HIGH-1 efeito recusado por causa TRANSITÓRIA (lock wait, deadlock, erro de programa) virava pendência
permanente: `runIsolated` engolia tudo, o R ficava com `slip_event` NULL e a idempotência por (kind,
dt) nunca mais tentava a baixa. HIGH-2 o "throttle" filtrava pelo último EVENTO — consulta sem
novidade não deixava rastro: os 8 mais antigos eram reconsultados a cada abertura de tela e o 9º nunca
(starvation; sandbox 10/min). HIGH-3 tentativa interrompida > 10 min virava F SEM perguntar ao banco
e o mesmo `seuNumero` era reenviado — duas cobranças vivas no Inter, e a órfã paga sem porta de
entrada. MED-1 reconciliação adotava código de tentativa antiga (ER_DUP_ENTRY em loop); MED-2 cancelar
não consultava antes e gravava C no 202; MED-3 rotina sem orçamento de tempo nem exclusão mútua;
MED-4 pendência só no detalhe; MED-5 webhook sem teto de códigos, processadores ilimitados, sem
trust proxy; LOW-1 401 do próprio token retentava; LOW-2 `res.on('error')` ausente; LOW-3 GET do canal
e test sem adminGuard; LOW-4 `SECRETS_PATH` default no cwd; LOW-5 UNIQUE com NULL não é cinto.

### 10.3 Gate adversarial — 1ª rodada **0.62 ✗** (64 testes em `onda2-adversarial.test.ts`, 11 = achados)
**A1 HIGH** desfecho AMBÍGUO do POST (timeout/5xx, ou 2xx sem JSON) fechava em F e liberava a
tentativa 2 sem reconciliar (= HIGH-3 pelo outro lado); A2 registrar × cancelar (reserva em voo
cancelada "às cegas"; passo 3b sem reconferir o estado); A3 voz atrasada regredia apresentação
encerrada (UNIQUE → 500); A4 cancelar pedia ao banco antes de validar o estado local; A5 voz da
tentativa N gravada na N+1 (TOCTOU reg0 × reg); A6 `inbound_token` a usuário comum; A7 chave ilegível
aceita; LOWs: throttle na mão do cliente (`minMinutes` 0), `expires_in` não numérico nunca cacheava,
cache do token não invalidava ao trocar `client_id`, DELETE do canal deixa segredos no disco,
`bank_our_number` sem corte para 11.

### 10.4 Retrabalho (tudo em sessão; `onda2-gate-rework.test.ts` 24 testes fixa cada item)
- **Migration 056** `tb_bank_slip_registration.last_queried_at` + índice `(institution, last_queried_at)`
  (DDL canônico `sql/03` alinhado; aplicada no dev). É o fato "NÓS olhamos o banco" — distinto da voz
  dele; `touchQueriedAt` em toda consulta; `listLiveRegistrationsToRefresh` filtra e rodiziona por ela
  (NULL primeiro). [HIGH-2]
- `refreshRegistration`: só recusa de REGRA (HttpError 4xx, exceto RESOURCE_BUSY/lock/deadlock) grava
  "Efeito recusado"; transitório/erro de programa desfaz a transação inteira e a próxima consulta tenta
  de novo (`isRuleRefusal`). [HIGH-1] Voz atrasada não regride apresentação encerrada; idempotência por
  (kind, dt) em TODOS os eventos (`hasRegistrationEvent`). [A3] Sob o lock, tentativa ≠ da consultada →
  nada gravado. [A5]
- `registerBankSlip`: última tentativa SEM código (interrompida > 10 min OU F) → `findByReference` por
  seuNumero ANTES de reservar (achou = S retroativo → 409 já registrado; nada = F source Q só na
  tentativa sem evento; banco fora = falha fechado). Desfecho ambíguo do POST não grava F — a reserva
  fica em voo para a reconciliação (`isAmbiguousBankOutcome`). Passo 3b grava código + S sempre e, se
  o boleto deixou de estar aberto no intervalo, pede cancelamento ao banco + K e devolve 409. [HIGH-3, A1, A2]
- `reconcileInFlightRegistration` (peça única, usada pelo registro e pela rotina): exclui códigos já
  conhecidos do boleto, prefere o de maior `statusAt`. [MED-1]
- `cancelRegisteredBankSlip`: reserva em voo → 409 IN_PROGRESS (interrompida reconcilia antes) →
  estado LOCAL sob lock (não aberto = 409 sem tocar o banco) → CONSULTA (RECEBIDO = efeito aplicado +
  409; C/V/F = só local) → pedido ao banco (202) → C + K. [MED-2, A2, A4]
- Rotina: `REFRESH_BUDGET_MS` 20 s total; órfãos param em BANK_UNAVAILABLE/RATE_LIMITED; coalescência
  por institution (2 telas = 1 varredura). DTO `minMinutes ≥ 1`. [MED-3, LOW]
- Webhook: `MAX_WEBHOOK_CODES` 50 por chamada; fila SERIAL por institution em memória. [MED-5]
- Canal: `validatePrivateKeyPem` (createPrivateKey) + `keyMatchesCertificate` no upload; GET do canal
  REDIGE `inboundToken`/`webhookPath` para não admin; `POST /channel/test` com adminGuard; `clientId`
  com alfabeto de id. [A7, A6, LOW-3, A4 da sonda]
- Transporte: falha de TLS/certificado no handshake → **409 BANK_AUTH_FAILED** "confira os segredos"
  (`isTlsCredentialError`); `res.on('error')`. [A2 da sonda, LOW-2]
- Adaptador: token pedido FORA da retentativa (401 do token não repete); `expires_in` inválido → 1 h;
  chave do cache inclui `clientId`; `bank_our_number` cortado em 11. [LOW-1, LOWs]
- Testes antigos alinhados ao contrato novo (3 em `bank-slip-registration.test.ts`; 5 "provas
  positivas" do adversarial que documentavam o comportamento antigo). **1036/1036** api · **92/92** app.
- Re-prova ao vivo V1–V8 (dev recarregado): chave lixo → 400; test com cert falso → 409
  BANK_AUTH_FAILED; registrar boleto com F sem código → GET por seuNumero primeiro (409 do TLS, nenhuma
  tentativa nova); GET canal como user sem token; test como user 403; clientId traversal 400; webhook
  150 códigos → received 100 (teto depois baixado para 50); `minMinutes` 0 → 400.

### 10.4.1 Re-score socrático pós-retrabalho — **0.76 ✅** (2026-09-20)
Todas as correções conferidas no código; nenhuma contradiz D-I8/D-I10/D-I13 (a consulta prévia do
cancelamento é adição, não inversão; deixar de gravar fato no transitório é MAIS fiel à D-I10). Achados
remanescentes e destino: **M1** cofre gravava o certificado ANTES de conferir o par com a chave (cert
novo × chave velha no disco quando o par não casava) → corrigido em sessão: as escritas só depois de
toda validação ("cofre = último par válido"); **M2** consulta que falha ANTES da voz do banco por causa
persistente (canal inativo, segredo do sandbox removido, situação desconhecida) não marcava
`last_queried_at` e monopolizaria a cabeça do rodízio → corrigido em sessão como assunção **Q-I10**
(marca em falha persistente 4xx/502; preserva em lock/deadlock/RESOURCE_BUSY/503); **L1** consulta
prévia dizendo C/V já cancelava o boleto (source A) e o cancel local repetido devolvia 409 → corrigido
(o C do efeito é a resposta); **L2** reconciliação decide por leitura antes do lock (só história
duplicada, sem cobrança dupla) → anotado; **L3** órfã do 3b com cancel falho no banco fica sem porta
de retentativa → **Q-I12**; **L4** fila do webhook sem teto de comprimento/dedupe e sem parada no 429 →
Q-I6. **E1 (só o sandbox prova)**: se o `GET /cobrancas?seuNumero` do Inter for eventualmente
consistente, a reconciliação pode dizer "não achou" cedo demais → entra como caso explícito do smoke
(Q11/Q12 do §9). Testes M2/L1 em `onda2-gate-rework.test.ts` (27); suíte 1039/1039.

### 10.5 Assunções EXECUTADAS (viram decisão com o "concordo" do Valdo; divergência = reverter)
- **D-I20 (assunção)** — apresentação ganha `last_queried_at` (write-many, família dos write-once da
  D-I6): sem o fato "nós vimos" não há throttle nem rodízio. Alternativas descartadas: tabela de
  consultas (cresce sem limite) e evento "sem mudança" (polui a voz do banco).
- **D-I21 (assunção, refina D-I13)** — F só por recusa EXPLÍCITA do banco (4xx); ambíguo fica em voo;
  toda tentativa sem código consulta o banco por seuNumero antes de uma nova apresentação.
- **D-I22 (assunção, refina D-I8)** — "banco primeiro" = estado local → consulta → pedido → gravação;
  reserva em voo bloqueia o cancelamento. O C local ainda nasce no 202 (Q-I4 decide se muda).
- **D-I23 (assunção)** — webhook com teto 50 e fila serial por institution; token do webhook só a
  admin (GET redigido; test admin).
- **D-I24 (assunção)** — falha de handshake mTLS é CREDENCIAL (409), nunca indisponibilidade.

### 10.6 Questões para o Valdo (rodada 2 da onda)
- **Q-I1** (HIGH-1 resolveu o transitório; sobra a recusa de REGRA): R com `slip_event` NULL deve ser
  REAPLICADO automaticamente na consulta seguinte enquanto o banco disser o mesmo, só por ato manual
  "Reaplicar" no detalhe, ou ambos? (Rec.: ato manual nesta onda — exige modelar "reaplicação" como
  evento próprio, a idempotência por (kind, dt) hoje impede um 2º R.)
- **Q-I2** confirmar D-I20 (coluna) ou pedir outra forma. (Rec.: manter.)
- **Q-I3** confirmar D-I21. (Rec.: manter — custo é 1 GET por reapresentação, rara.)
- **Q-I4** cancelamento: gravar C local no 202 (hoje) ou só quando a consulta confirmar CANCELADO
  (K = "pendente", boleto segue open e os títulos presos pela D-B1 até lá)? (Rec.: manter o 202 — a
  consulta ativa e o webhook trazem a confirmação; se o banco recusar depois, a voz C/V não chega e o
  RECEBIDO cai em pendência visível.)
- **Q-I5** (MED-4) sinal de "voz do banco pendente" na LISTA de boletos (badge/filtro) ou aceitar que só
  existe no detalhe? (Rec.: coluna/badge na lista na próxima passada de UX — hoje o operador não
  descobre dinheiro na conta sem título baixado sem abrir boleto por boleto.)
- **Q-I6** Onda 4: `trust proxy` + limitador próprio do webhook + fila compartilhada entre instâncias.
  (Rec.: sim, junto com a URL pública.)
- **Q-I7** confirmar D-I23 para o GET redigido (a seção Canal API do app já trata `webhookPath` nulo).
- **Q-I8** DELETE do canal: apagar os segredos junto (hoje ficam no disco e o PUT seguinte revive o
  canal com o MESMO token) ou recusar o DELETE com apresentações vivas? (Rec.: apagar segredos + rotacionar
  o token no revive; recusar com apresentações vivas.)
- **Q-I9** piso do throttle: `minMinutes ≥ 1` para todos (feito) ou admin pode 0? (Rec.: manter ≥ 1.)
- **Q-I10** (M2 do re-score, EXECUTADA como assunção) — consulta que falha antes da voz do banco por
  causa persistente conta como "tentamos olhar" (marca `last_queried_at`); transitório preserva. Confirmar
  ou pedir contador de falhas com backoff.
- **Q-I11** virada sandbox → produção: apresentações congeladas em 'S' seguem vivas e exigem os
  segredos do sandbox no cofre; recusar o PUT do canal com apresentações S vivas (rec.) ou criar ato
  administrativo "encerrar apresentação de teste"?
- **Q-I12** (L3) órfã do passo 3b com cancelamento falho no banco: K "pendente" reprocessado pela
  rotina (cruza com Q-I4) ou operação manual no portal do banco documentada em §10.7? (Rec.: manual
  nesta onda; o log já existe.)
- **Q-I13** (M1) confirmar a invariante "cofre = último par válido" (feito: escritas só após validar o
  par; falta atomicidade temp+rename se o Valdo quiser cinto extra).

### 10.7 Tarefas de implantação (somam às do §9)
`SECRETS_PATH` FORA do diretório do deploy (default `./secrets` some no redeploy da SaveInCloud —
LOW-4); migration 056; `npm run errors:gen` (feito no dev: 113 códigos, nenhum novo nesta rodada);
D-I3: colocar os segredos pela aba Canal API (o upload agora valida par cert × chave). Rodada 2: migration
057 + `npm run errors:gen`; **Q-I12 (operação manual)**: apresentação órfã cujo cancelamento falhou no banco
→ cancelar no portal do Inter pelo `codigoSolicitacao` do log e depois "Atualizar com o banco" no boleto.

### 10.8 O que FALTA para fechar a Onda 2 (atualizado)
1. Credenciais do sandbox (§9 item 1 — Valdo) e conta do banco 077 real da Setes no schema.
   **Cadastro em developers.inter.co FEITO (Valdo, 2026-09-20)**; ⚠️ o sandbox só atende **seg–sex,
   8h–20h** — smoke, trilha P7b e passeio logado só nessa janela (o smoke avisa quando está fora).
2. Smoke `scripts/smoke-inter-sandbox.ts` (C1–C9) + provar Q11/Q12 no sandbox.
3. Trilha P7b → OK.
4. ~~Re-score socrático~~ FEITO: **0.76 ✅** (§10.4.1; M1/M2/L1 corrigidos em sessão).
5. Passeio logado (Claude in Chrome) na aba Canal API e no detalhe do boleto.
6. Rodada 2 de decisões (Q-I1…Q-I13) e commit dos repos (api · sql · app · Infra-IA — nada commitado
   nesta sessão).

**Retomada 2026-09-21 (seg, 16h54 — dentro da janela do sandbox)**: ambiente reverificado antes de qualquer
passo — API 1039/1039 jest + `tsc` limpo, app 25/25 nos testes das entidades novas (item 4 do §9 FEITO:
`bank_account_channel_entity_test.dart` e `bank_slip_registration_entity_test.dart`), migration 056 espelhada
no `sql/03`, MySQL de pé; dev tem a conta 5 (banco 077, número placeholder `00000000`) com o canal 5 em S e
`client_id` NULL, cofre `secrets/setes_setes/bank-account/` VAZIO. Tudo o que resta (itens 1–3, 5, 6) parte
das credenciais e das decisões Q-I1…Q-I13 — só o Valdo.

**SDKs oficiais do Inter como referência (Valdo, 2026-09-21)**: repos `inter-co/pj-sdk-{python,java,csharp,php}`
(fev/2025) lidos como SEGUNDA opinião — a fonte primária segue a spec em `setes-api/integracoes/banco-inter/`.
Conferido no `pj-sdk-python`: mesmos endpoints, mesmo enum de situações (9), token cacheado, `x-conta-corrente`,
filtro por `seuNumero`. Divergências DELIBERADAS mantidas: (a) token único com os 2 escopos (o SDK pede 1 por
escopo — gasta o limite de 5/min); (b) 429 = 503 BANK_RATE_LIMITED e a passada para (o SDK dorme 60 s no
processo — inaceitável em API multi-tenant). Útil: `functional_tests/BillingFunctionalTests.py` = roteiro do que o
sandbox aceita (conferir contra o smoke); `/webhook/callbacks` (lista de callbacks) = candidato à Onda 4 para
reconciliar webhooks perdidos. Flutter: nenhum SDK se aplica (o app só fala com a nossa API).

### 10.9 Rodada 2 — DECIDIDA e EXECUTADA (Valdo 2026-09-21, "siga as recomendações da rodada 2")

**Confirmações (viram decisão, sem código)**: D-I20 (`last_queried_at`, Q-I2) · D-I21 (F só por recusa
explícita, Q-I3) · D-I22 (C local nasce no 202, Q-I4 — manter) · D-I23 (webhook teto 50 + token só admin,
Q-I7) · D-I24 (TLS = credencial) · Q-I9 piso `minMinutes ≥ 1` mantido · Q-I10 marca em falha persistente
confirmada · Q-I13 "cofre = último par válido" confirmada (sem temp+rename). Q-I6 (`trust proxy` +
limitador próprio + fila entre instâncias) e a lista de callbacks `/webhook/callbacks` do banco ficam
para a **Onda 4**. **Q-I12** (órfã do 3b com cancelamento falho no banco) = operação MANUAL nesta onda:
cancelar a cobrança no portal do Inter pelo `codigoSolicitacao` do log (`Apresentação aceita para boleto
que não está mais aberto — cancelamento no banco falhou`) e depois "Atualizar com o banco" no boleto — a
voz C chega e o K fica como história (entra em §10.7).

**Decisões novas com código (api + sql + app, tudo em sessão):**
- **D-I25 (Q-I1)** — R/C/V com `slip_event` NULL se resolve por ato MANUAL "Reaplicar efeito do evento N"
  (nunca automático). A idempotência por (kind, dt) impede um 2º R, então a reaplicação é EVENTO PRÓPRIO
  **`E`** (migration 057 — só o COMENTÁRIO do `kind`; `sql/03` espelhado), FINAL como a voz que reaplica
  (entra em `FINAL_REGISTRATION_KINDS` e sai da consulta ativa). Peça
  `reapplyRegistrationEffect(schema, inst, user, slip, attempt, event)`: `lockSlip` → apresentação e evento
  FOR UPDATE → a voz GRAVADA vira `ChargeStatus` (valor/data/meio do evento, SEM consultar o banco) → a
  MESMA porta `applyBankStatus` → E com `slip_event` + o R/C/V original recebe o mesmo `slip_event` (some da
  pendência). Recusa de novo = 409 com o motivo da regra e NADA gravado (sem SAVEPOINT de propósito).
  Boleto já no estado que o banco disse = link ao evento existente. `POST /api/bank-slips/:id/reapply`
  `{attempt, event}` → 201; 404 `BANK_SLIP_REGISTRATION_EVENT_NOT_FOUND`; 409 `BANK_SLIP_EFFECT_NOT_PENDING`
  (G/S/K… ou já aplicado). App: botão "Reaplicar efeito do evento N" em cada pendência do detalhe
  (usecase `BankSlipReapply`, evento `BankSlipReapplyRequested`, rótulo do kind E).
- **D-I26 (Q-I8)** — `DELETE /:id/channel` recusa com apresentação VIVA (em voo ou voz não final) em
  qualquer ambiente: 409 `BANK_CHANNEL_HAS_LIVE_REGISTRATIONS` (leitura sob lock do canal, peça
  `countLiveRegistrationsForAccount`). Sem viva: soft delete + segredos de **S e P** fora do cofre (DEPOIS
  do commit). O revive pelo PUT nasce com `inbound_token` NOVO (UPSERT: `inbound_token = IF(deleted='S',
  VALUES(inbound_token), inbound_token)` ANTES de `deleted='N'` — ordem de avaliação do ON DUPLICATE KEY).
- **D-I27 (Q-I11)** — `PUT /:id/channel` que muda o ambiente com apresentação viva no ambiente ATUAL →
  409 no campo `environment` (mesmo código), sob lock do canal na mesma transação do upsert. Mesmo ambiente
  ou canal novo não conta. "Encerrar apresentação de teste" NÃO virou ato próprio: liquidar (pay-sandbox) ou
  cancelar resolve.
- **D-I28 (Q-I5)** — a LISTA de boletos carrega `pendingBankEffects` (subquery pela regra ÚNICA
  `PENDING_EFFECT_WHERE` da peça: `kind IN ('R','C','V') AND slip_event IS NULL`) e aceita
  `?pending=true` (HAVING, na lista E na contagem). App: célula "Voz do banco pendente (n)" em cor de erro na
  linha + checkbox "Só boletos com voz do banco pendente" (estado no bloc; a volta do detalhe preserva).
  Regra do app alinhada à da API: **C e V sem `slipEvent` também são pendência** (antes só o R contava —
  teste da entidade atualizado com o motivo).

**Socrático da rodada (em sessão) — 1 achado, corrigido**: R recusado deixa o boleto `open` com apresentação
FINAL → "Registrar no banco" voltava a aparecer e `registerBankSlip` aceitava: **2ª cobrança viva no banco
para dinheiro JÁ recebido**. Guarda ANTES do pagador, do canal e da reserva: 409 `BANK_SLIP_EFFECT_PENDING`
enquanto houver pendência (peça `countPendingEffects`); app esconde o botão quando `refusedEffects` não está
vazio. Conferido sem achado: reaplicar concorrente (2º vê `slip_event` preenchido → 409); reaplicar de
evento de outro boleto/tentativa → 404; E com `dt_bank_status` NULL não colide no UNIQUE (NULLs distintos);
webhook simultâneo serializa no `lockSlip`; canal com viva em voo (sem evento) também prende o DELETE.

Testes: `onda2-rodada2.test.ts` (17) — 129/129 nas 4 suítes da onda; `errors:gen` 117 códigos; migration 057
APLICADA no dev; app `analyze` limpo + testes das entidades (E final, C/V pendentes, `pendingBankEffects`,
`BankSlipReapplyResult`). Tarefa de implantação: migration 057 + `npm run errors:gen` (somam ao §10.7).

**Credenciais do sandbox (2026-09-21)**: o Valdo entregou o zip do portal — certificado UAT (emissor "UAT
Partners CDPJ", válido 21/09→21/10/2026, 30 dias) + chave RSA 4096, par CONFERIDO; guardados no cofre
`secrets/setes_setes/bank-account/5/S/{client.crt,client.key}` (gitignored). **Ainda faltam `client_id` e
`client_secret`** (não vêm no zip; ficam na aplicação do portal) e o nº real da conta 077 (a conta 5 do dev
tem placeholder `00000000`). Smoke, P7b e passeio logado seguem presos nisso.

### 10.10 Smoke no SANDBOX real — FEITO (2026-09-21, 18h30–19h05, com as credenciais do Valdo)

**Credenciais**: `client_id` + `client_secret` informados pela aba Canal API (D-I3, write-only); conta 5 passou a
ter o número REAL da Setes no Inter (0001/<conta real> — `x-conta-corrente` derivado). Primeiro "Testar conexão"
deu 503: o **serviço Cobrança v3 do sandbox estava fora** ("no healthy upstream" — OAuth e gateway de pé;
curl direto confirmou), voltou em ~5 min; a tradução `BANK_UNAVAILABLE` estava certa.

**Resultado final do smoke `scripts/smoke-inter-sandbox.ts`: C1–C9 = 9/9 OK** (boleto 272: apresentação
real, A_RECEBER com linha digitável e Pix, pagamento simulado → RECEBIDO → L source A, 2ª consulta
`changed=false`, PDF oficial 68 KB). **Trilha P7b → OK** (21 OK · 3 PENDENTE = Ondas 3/4 · 0 FALHA).

**4 achados do smoke, corrigidos em sessão (o sandbox pagou o ingresso):**
1. **`Accept` do adaptador** — o `POST /cobrancas/{id}/pagar` (204) respondia **406** "Supported types:
   [application/problem+json]" a `Accept: application/json` puro (na 1ª corrida apareceu como 500). Curl não
   manda Accept e passava. Agora `Accept: application/json, application/problem+json` em toda chamada
   (teste de contrato no `bank-channel-inter-adapter.test.ts`). Sem isso o critério 2 era improvável no sandbox.
2. **Vencimento anterior a hoje** — o banco recusa `dataVencimento < hoje` (400) e o boleto do título do dev
   (2018) virou tentativa F só para ouvir o óbvio. Guarda NOSSA antes do pagador/canal/reserva: 422
   `BANK_SLIP_EXPIRATION_PAST` com o campo (`registerBankSlip`; teste em `onda2-rodada2.test.ts`; 118 códigos).
3. **Smoke desatualizado** — C4 mandava `description` para a carteira (o cadastro do §13 exige `agreement`) e
   procurava a carteira em `/bank-slips/agreements` (lookup sem `bankAccountId` → criava uma carteira por
   corrida; a 7 foi excluída). Emite com `dtExpiration` = hoje + 30.
4. **Smoke engolia a falha do pagamento** — C7 seguia para o poll mesmo com o `pay-sandbox` recusado; agora
   falha alto e o poll tem 8 × 6 s (o sandbox processa o pagamento de forma assíncrona; na prática veio na hora).

**Q11 PROVADA (contrato do banco)**: `seuNumero` NÃO é único no Inter — aceitou 2ª cobrança com o MESMO
`seuNumero` com a 1ª VIVA (A_RECEBER) e uma 3ª depois de cancelar a 1ª; a listagem por `seuNumero` devolveu as
3. Consequências: (a) **nenhuma coluna `sent_reference`** — a retentativa reusa o `our_number` (já é assim);
(b) a unicidade "1 viva por boleto" é NOSSA (reserva sob lock, D-I12) e a reconciliação só adota código
DESCONHECIDO (MED-1) — as duas guardas ficam confirmadas como necessárias, não redundantes.
**Q12 PROVADA (órfão)**: cobrança criada POR FORA com `seuNumero` 274 + reserva plantada sem código há 15 min →
`POST /bank-slips/refresh` reportou `reconciled: 1`, adotou o `codigoSolicitacao`, gravou S/Q "Reconciliado por
seuNumero" e G/Q com linha digitável. **E1**: no sandbox o `GET /cobrancas?seuNumero` enxergou a cobrança 4 s
depois da emissão (1 amostra — consistência imediata; a janela de 10 min da D-I13 segue como cinto).
**Cancelamento "banco primeiro" ao vivo (D-I22)**: 273 e 274 cancelados pela API → K/P, 202 no banco, consulta
seguinte trouxe C/Q CANCELADO; estado local `cancelled`.

**Resíduo no dev** (história, não sujeira): boletos 270–272 liquidados por pagamento simulado (baixas
837/838/…), 268/269/273/274 cancelados, carteira 6 "INTER-SANDBOX" (fica para as próximas corridas), 2
cobranças Q11 canceladas no banco. Token do sandbox usado nas sondas apagado do disco.

**Ficam para fechar a onda**: passeio logado (Claude in Chrome — precisa do Valdo logado) e commit dos 4 repos.

### 10.11 Passeio logado — FEITO (2026-09-21, 19h05–19h35, Claude in Chrome com o Valdo logado)

Roteiro percorrido pela tela (o agente nunca digitou senha; segredos foram pelo Valdo):
1. **Contas bancárias → conta 5 (077, 0001/<conta real>) → seção "Canal API com o banco"**: ambiente sandbox,
   client_id gravado, "Certificado: presente · Chave privada: presente · Client Secret: presente · válido até
   2026-10-21 (29 dias)", caminho do webhook com copiar. **"Testar conexão"** → "Conexão com o banco OK —
   webhook cadastrado: nenhum". (Na 1ª tentativa o sandbox devolveu 500 "Erro desconhecido" no GET webhook —
   log da API confirma 500 REAL do banco às 21:40 e 22:08 UTC, curl logo depois deu 404 normal; instabilidade
   do sandbox, não nossa.)
2. **Boletos → 275 (emitido pela API para o passeio) → "Registrar no banco"**: snackbar "Boleto apresentado ao
   banco — código 39eaa6a0…", seção passa a "Apresentação 1 · sandbox · Enviado ao banco (EM_PROCESSAMENTO)"
   com o código e os botões Atualizar/PDF; linha do tempo "Voz do banco" com o evento 1 (Resposta direta).
3. **"Atualizar com o banco"** → "Registrado no banco (A_RECEBER)", nosso número do banco, linha digitável e
   Pix copia e cola com copiar; evento 2 (Consulta). **"PDF do banco"** abriu em nova aba (blob, 68 KB).
4. **D-I10/D-I25/D-I28 na tela** — voz RECEBIDO com efeito recusado plantada por SQL (evento 3, R/W, R$ 85,00,
   slip_event NULL): a LISTA mostra "Voz do banco pendente (1)" em vermelho na linha do 275; o checkbox "Só
   boletos com voz do banco pendente" reduz os 185 abertos a 1; no detalhe a pendência aparece em vermelho com
   **"Reaplicar efeito do evento 3"** (e o botão "Registrar" some). Clique → snackbar "Efeito reaplicado —
   evento 2 do boleto"; evento 3 ganha "Efeito no boleto: evento 2 · Efeito reaplicado (evento 4)", nasce o
   evento 4 "Efeito reaplicado" (E, Resposta direta), selo do boleto vira **Liquidado**, "Baixar" vira
   "Estornar". Banco de dados: tb_bank_slip_event 2 = L source A baixa 840 R$ 85,00; pendências = 0.
5. **Achado de UX corrigido em sessão**: a frase da pendência dizia "Recebido pelo banco no banco em…" (o rótulo
   do kind já traz "pelo banco") → i18n `bankPendingRow` pt/en sem o "no banco".

Resíduo: boleto 275 liquidado aqui por reaplicação de uma voz SIMULADA — a cobrança correspondente foi
CANCELADA no banco por curl (202) para não ficar viva no sandbox. Token das sondas apagado.

**Onda 2: nada pendente além do commit** (api · sql · app · Infra-IA). Q-I6 e a lista de callbacks ficam
para a Onda 4; Q-I12 é operação manual (§10.7).
