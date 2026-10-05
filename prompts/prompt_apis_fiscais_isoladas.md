# APIs Fiscais Isoladas — `nfse-api` (NFS-e/ADN) e `nfe-api` (NF-e/NFC-e/SEFAZ)

**Status**: Rodada 2 DECIDIDA (2026-10-03) — §8 zerada; **Rodada 4 (gates da F1) DECIDIDA 2026-10-04 → D-F36…D-F40, execução no §16**: D-F1…D-F26 (§7). A Rodada 2 mudou o centro do desenho: setes-api PASSIVO (D-F4); a API fiscal LÊ o banco do produto por uma fonte de fatos isolada (D-F10); o efeito no ERP é do setes-api lendo a voz no `fiscal_api` (D-F11); **três pastas** — `fiscal-api` (núcleo, biblioteca), `nfse-api`, `nfe-api` (D-F12/D-F17); mesmo login com JWT assimétrico (D-F13); sem `tb_licensee` (D-F14); views + GRANT mínimo (D-F15); A1 cifrado no banco (D-F16). Plano vigente: **§12**. Em execução: **F0** — parecer do guardião sobre o modelo (§13) abriu a Rodada 3 — **ZERADA em 2026-10-04 (D-F27…D-F35)**; modelo final no **§14**. **F0 FECHADA; F1 EXECUTADA (2026-10-04, §15)** — núcleo `fiscal-api` (29 testes) + `nfse-api` (102 + 45 ao vivo), `fiscal_api` criado e dados da Setes migrados; **GATES FECHADOS** (socrático 0.75 · adversarial 0.80 — 3 rodadas, 3 retrabalhos, §15.4). **Rodada 6 (2026-10-04, 2ª sessão — §17)**: 4 falhas ao vivo resolvidas (promoção de trava → trava POR LINHA), gates do delta 0.80/0.78, D-F41…D-F45 decididas e executadas (aluguel com espera curta, migrate:setes só SE, porte ao setes-api, o ato da virada aposenta a SE do ERP, CHECK do domínio do modelo); fiscal-api 44 · nfse-api 143 + 130 ao vivo.
**Origem**: pedido do Valdo em 2026-10-03, ao fechar a fase de emissão de NFS-e: *"isolar as APIs do sistema porque o consumo pode ser feito por outras aplicações e eu posso dar escala para elas"*
**Referências**: `prompt_onda3_nfse_adn.md` (NFS-e — ENTREGUE, produção desde 2026-09-29) · `prompt_onda_nfe_sefaz.md` (NF-e — Rodadas 0/1 decididas, nada executado além das peças comuns do §10) · `prompt_primeiro_cliente_setes.md` (Onda 4 — produção na SaveInCloud, ainda INEXISTENTE) · `skills-genericas/guardiao-conceitual.md` · `setes-sync/prompt_revisao_sincronizador_setes_sync.md` D12 (API key por institution — precedente de API consumida por terceiro) · método: `skills-genericas/refinar-prompt-arquitetura.md`
**Escopo**: misto (o conceito "serviço de documento fiscal que não conhece o ERP" é método portável; tabelas, ADN, SEFAZ e dados da Setes são conteúdo do caso zero)

> Este documento NÃO decide. Organiza o que existe, mede o esforço e transforma cada escolha arquitetural em questão numerada (§8) com recomendação. Decisões do Valdo entram na §7 com numeração permanente (D-F1…).

> **⏯ RETOMAR POR AQUI (salvo 2026-10-04, 2ª sessão — §17)**: decisões D-F1…D-F49 (§7); as 4 falhas ao vivo do §16.4
> RESOLVIDAS; gates do delta FECHADOS (socrático 0.80 · adversarial r7 0.78); **Rodada 6 DECIDIDA e EXECUTADA** (D-F41 espera
> curta no aluguel · D-F42 migrate:setes só SE · D-F43 porte ao setes-api no dual-run · D-F44 o ato da virada aposenta a SE do
> ERP · D-F45 CHECK do domínio do modelo, migration 004). Gate do delta da Rodada 6 FEITO (§18); Q-F51…Q-F53
> (§8.R5): Q-F51 ADIADA pelo Valdo (renovação do A1 programada — o prazo de 08/10/2026 deixa de pressionar), Q-F52 DECIDIDA
> = **D-F46** (bloqueio total; executada — §17.5), Q-F53 aguarda; **gates do delta da Rodada 6 + D-F46 FECHADOS** (§18: socrático
> 0,76 · adversarial r8 0,80; 2 achados corrigidos); Q-F57/Q-F58 DECIDIDAS e executadas (D-F47/D-F48, §18.1); **Q-F59 em esclarecimento**, **Q-F60 aguarda** (gate §18.2); F2a (setes-api passivo + virada) → F2b (app). COMMITADO e PUBLICADO em 2026-10-04 (setes-api/sql/Infra-IA/setes-app
> + fiscal-api/nfse-api/nfe-api em repos GitHub PRIVADOS criados nesta data).

---

## 1. Contexto — fatos verificados no disco (2026-10-03)

### 1.1 O que a NFS-e já é hoje (dentro do setes-api)

A Onda 3 entregou a emissão de NFS-e pelo ADN nacional como peças `@shared/*` do **setes-api**, consumidas pelo módulo `billing` (rotas `/api/billing/fiscal*`) e pelo módulo `establishment` (habilitação do emissor). Está em **produção real**: NFS-e nº 704 autorizada em 2026-09-29, DANFSe e cancelamento provados no mesmo dia.

| Peça | Arquivos | Linhas | Lê tabela do ERP? | Natureza |
|---|---|---|---|---|
| `shared/tax-authority` | types · adapters/adn · dps-builder · https-json · xmldsig | 1.054 | **não** | transporte puro: assina XML, fala mTLS com o fisco, devolve fatos crus |
| `shared/invoice-transmission` | invoice-transmission (840) · branches/service (599) · transmission.repository (532) · kinds | 1.992 | **sim** — `tb_invoice`, `tb_invoice_service`, `tb_invoice_event`, `tb_entity_tax`, `tb_city`, cadeia da entity | composição: reserva de tentativa → fisco fora da transação → voz → efeito; estratégia por ramo |
| `shared/fiscal-issuer` | fiscal-issuer · repository | 416 | só `tb_establishment_issuer` + transmissões | habilitação do emissor: PKCS#12 → par PEM no cofre, abre o par, valida validade/CN |
| `shared/danfse` | danfse | 168 | não | render do PDF a partir do XML autorizado (pdfkit) |
| `shared/secret-store` | secret-store | 149 | não | cofre em arquivos `SECRETS_PATH/<schema>/<owner>/<id>/<S|P>/<name>` — **compartilhado com o canal do banco** (owner `bank-account`) |
| `modules/billing` (parte fiscal) | billing.fiscal.controller (113) · billing.fiscal.service (144) · 9 rotas em billing.routes | ~300 | sim (privilégio por ramo, autoria JWT) | fronteira HTTP ↔ composição; lote com orçamento de 60 s e trava `runningBatch` |
| `modules/establishment` (parte issuer) | issuer.controller (61) · dto (35) · service (169) · 5 rotas | ~265 | sim | upload do A1, linha por modelo |
| Testes | 7 arquivos (`tax-authority` 372 · `invoice-transmission` 502 · `fiscal-issuer` 317 · `secret-store` 75 · `danfse` 71 · adversarial 83 · fiscal-folder-zone 40) | 1.460 | mocks na fronteira (`pool`, repository, adapter) | portáveis — mockam o que a peça importa, não o banco |
| Migrations | 058 (ramo + emissor + transmissão + voz) · 059 (chave do DPS) · 060 (contador + kind N) · 061 (`invoice_event` = vida da nota) · 062/063 (`tb_entity_tax` Simples) | — | 062/063 são fatos do EMITENTE no ERP (ficam) | 058–061 criam as tabelas candidatas a migrar |
| Códigos de erro | 23 `FISCAL_*` / `INVOICE_SERVICE_*` (de 296 no catálogo) | — | — | contrato de erro já estável |
| Dependências npm | `node-forge` (PKCS#12) · `xml-crypto` (XMLDSig) · `pdfkit` (DANFSe) | — | — | migram junto |
| Arquivos em disco | `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mes>/` (`*-dps.xml`, `*-nfse.xml`, `*-evt101101.xml`) · `SECRETS_PATH/<schema>/establishment/<inst>/P/certificate.pem + private.key` | — | — | o A1 real da Setes já está no cofre do dev (vence 08/10/2026) |

**Consumidores no app** (setes-app): 17 arquivos Dart (2 do emissor em `establishment`, 15 do fiscal em `service_orders`) + 4 testes — todos falam SÓ com `/api/billing/fiscal*` e `/api/establishment/issuer*` do setes-api (regra "módulo do app fala só com o seu `/api/<m>`"). **Se o setes-api continuar sendo a porta do app, o app não muda.**

**O que a transmissão lê do ERP e o que é só do fisco** (fato que define a fronteira — §4):
- *Do ERP, no momento da transmissão*: a nota viva emitida pela institution (`readServiceInvoice` — `tb_invoice` + ramo `tb_invoice_service` congelado no faturamento), o emitente (cadeia + `tb_entity_tax`: CNPJ, IM, cMun IBGE, opSimpNac/regApTribSN/regEspTrib, pTotTribSN — `buildEmitter`), o tomador (cadeia — `buildRecipient`), a cidade de incidência (IBGE), o fuso do estabelecimento (`institutionZoneFor`), o último evento da nota (MEDIUM-3: "a nota mudou no intervalo?"), o lock da nota e o lock de contadores da institution.
- *Só do fisco*: habilitação (ambiente, série, contador nDPS), par PEM, tentativa (`attempt`, ambiente congelado, `dps_id`, chave 50, número, `dh_proc`, `last_queried_at`), voz (S/A/R/C/K/F/N com código cru, fonte P/Q), XML em disco, DANFSe, prazo do PAM (cache).
- *O efeito*: a voz C do fisco produz `cancelInvoice` local em SAVEPOINT (porta única `applyCancelEffect`); recusa local = fato gravado + pendência (`FISCAL_EFFECT_PENDING`, `countPendingEffects`) — **o padrão "voz do terceiro × efeito nosso" já existe e já tolera separação no tempo** (D-I10/D-I25/D-I28 da Onda 2).

### 1.2 Estado de produção e escala — fatos

- **Onda 4 (deploy) não existe**: o setes-api não tem Dockerfile, `ecosystem.config` nem script de deploy; só `.env` de dev. A "produção" fiscal de 2026-09-29 foi o ambiente P do FISCO (tpAmb 1) acionado do dev. Decisão D3 da fase Primeiro Cliente: SaveInCloud, `api-erp.setesgestao.com.br`.
- **Estado em memória que NÃO sobrevive a 2+ instâncias** (achado desta leitura): `runningRefresh` (`invoice-transmission.ts:708`, 1 rodízio por institution), `runningBatch` (`billing.fiscal.service.ts:58`, 1 lote por institution), `termsCache` (`branches/service.ts:498`, só cache — inofensivo). Quem escala horizontalmente precisa trocar os dois primeiros por trava no banco ou aceitar "1 por instância".
- **Cofre e XML em filesystem local** (`SECRETS_PATH`, `STORAGE_PATH`): 2+ instâncias exigem volume compartilhado ou backend de objeto/KMS — a peça já diz "cofre/KMS entra ATRÁS desta interface quando a produção pedir".
- **Volume da Setes**: cobrança mensal em lote (teto 50 ordens/requisição — D27), centenas de NFS-e/mês. A escala que justifica serviço próprio é a da **NFC-e (modelo 65, PDV)** — milhares/dia por cliente — e a de **outros consumidores**.
- **Precedente de API consumida por terceiro**: setes-sync autentica por `X-Api-Key` resolvida em `setes_central.tb_sync_api_key` (institution + schema por JOIN, cache 5 min) — D12 da revisão do sync.

### 1.3 Estado da NF-e — fatos

- Rodadas 0 e 1 DECIDIDAS (D-E1…D-E25, "siga as recomendações", 2026-09-21). **D-E20 (a)**: as peças comuns nasceram com a Onda 3 (feito — `tb_establishment_issuer` com PK por MODELO, `xmldsig` paramétrico `sha1|sha256`, UMA composição `@shared/invoice-transmission` com `branches/`, motor de PDF único); **a NF-e em si espera o 1º cliente de mercadoria**. Nada de `adapters/sefaz.ts`, `branches/merchandise.ts`, `tb_invoice_merchandise_transmission`, `tb_invoice_number_void`, DANFE.
- O ERP já congela no faturamento os fatos do ramo de mercadoria (6 snapshots por item: `tb_order_item_icms/_fcp/_ipi/_pis/_cofins/_issqn`; `tb_invoice_merchandise`) — o builder do XML consome RESULTADO da tributação, nunca recalcula (§3.11 da NF-e; §4.3 do diagnóstico do legado).
- **IBS/CBS (NT 2025.002)**: obrigatório na NF-e/NFC-e do regime regular desde **03/08/2026**; Simples Nacional em **01/01/2027** (Ato Conjunto RFB/CGIBS nº 4/2026 — premissa corrigida em 2026-09-30). O motor `@shared/tax-rule` (1.099 linhas) **não calcula IBS/CBS** — pré-requisito de qualquer NF-e real (Q-E17), que vive no ERP, não na API fiscal.
- Contrato oficial da SEFAZ (MOC 7.0, NTs, schemas PL, autorizadores por UF, cStat) **ainda não levantado** (`integracoes/nfe-sefaz/` não existe). O da NFS-e existe em `setes-api/integracoes/nfse-adn/`.

### 1.4 Calibração de esforço (ondas reais desta mesma stack)

| Onda | Calendário | Tamanho | Observação |
|---|---|---|---|
| Onda 2 — Banco Inter (conector REST + mTLS + webhook, 3 peças, migration 055/056/057, app) | 2026-09-19 → 21 (3 dias) + gates/smoke até 21 | 948 → 1.056 testes | fisco/banco com contrato JSON documentado |
| Onda 3 — NFS-e ADN (DDL + emissor + transporte + composição + DANFSe + app + 3 rodadas de gates + 1ª produção) | 2026-09-20 → 30 (10 dias) | ~6,5 k linhas (código + testes), 7 migrations, 23 códigos de erro, 9 rotas | fisco DESCONHECIDO: a 1ª sessão real cravou contrato, assinatura e 4 códigos E0xxx |
| Cancelamento autorizado D3/D4 + rodadas Q-CA/Q-ADV | 2026-09-29 → 30 (2 dias) | 1.387 → 1.429 testes | delta sobre peça existente |

Unidade usada abaixo: **sessão** = bloco de ~4 h de trabalho Valdo + agente, com testes verdes ao fim. Faixa com ±40 % — o que encurta é código já provado sendo MOVIDO; o que alonga é fisco novo (SEFAZ) e dependência externa (DNS, SaveInCloud, homologação).

### 1.5 Rodada 1 — o que o Valdo trouxe (2026-10-03, 2ª mensagem; texto fiel)

> "quero tratar fiscal-api como novo projeto seguindo as estruturas do setes-app incluindo a documentação de Gestao2027\Infra-IA... mas cada cliente incluindo a setes poderá fazer o uso da api, incluindo aplicativos de vendas que poderá criar orders e enviar para autorização, múltiplos apps, acessando o próprio ambiente do cliente através da web ou app android/iOS consumindo apis que devem ser publicadas de maneira que a escala de uso aguente o consumo de 1000 clientes emitindo e autorizando notas"

O que isso muda no desenho:

| Antes (Rodada 0) | Agora (Rodada 1) | Efeito |
|---|---|---|
| Consumidor principal = setes-api; terceiros "um dia" | **Todo cliente** (inclusive a Setes) consome a API diretamente, com **múltiplos aplicativos** (web, Android, iOS, apps de venda de terceiros) | licenciado = o CLIENTE (D-F2, fecha Q-F17); nasce a credencial POR APLICATIVO (§5.8); contrato, CORS, documentação e limites de nível público desde a F1 |
| Escala "nascer escalável" sem número | **1000 clientes emitindo e autorizando** | requisito não-funcional com número (D-F3): dimensionamento §5.9; F3 vira "produção escalável" (2+ instâncias, storage de objeto, cofre criptografado, worker, teste de carga) |
| `fiscal-api` como nome recomendado pelo guardião | **`fiscal-api` é novo PROJETO de 1º nível** com espelho `Infra-IA/fiscal-api/` | D-F1 fecha Q-F1 e Q-F6; estrutura §5.10 criada nesta sessão (sem código) |
| Pedido/nota só no ERP | "aplicativos de vendas que poderá criar orders e enviar para autorização" | ⚠️ **Q-F21**: onde vive o PEDIDO desses apps — no ambiente do cliente (setes-api, que então orquestra faturar + autorizar) ou a `fiscal-api` passa a aceitar pedidos? A leitura fiel ao parecer §3 é a primeira; a segunda recria o ERP dentro da API fiscal |

Leitura adotada para "seguindo as estruturas do setes-app": o mesmo TRATAMENTO que os projetos existentes têm — pasta própria na raiz, repositório git próprio, `CLAUDE.md` do repo, espelho `Infra-IA/<projeto>/` com `INDEX.md` + prompts fechados + skills, linha nas tabelas fixas (CLAUDE.md da raiz, `ORGANIZACAO_PASTAS.md`, `INDICE_CENTRAL.md`). O CÓDIGO segue o molde do setes-api (Node/TS: `gateway/ · modules/ · shared/ · migrations/`, módulo em 6 arquivos — `ARQUITETURA_MODULOS_API.md`), porque a fiscal-api é uma API, não um app Flutter. Se o Valdo quis algo diferente com "setes-app", é a Q-F26.

---

## 2. Objetivos (numerados)

1. **Isolar a emissão de NFS-e** num serviço próprio (pedido: `nfse-api`; parecer §3.E: `fiscal-api`, família `/nfse` — Q-F1) consumível por qualquer aplicação autenticada — sem conhecer pedido, nota ou cadeia do ERP.
2. **Transformar o setes-api em CONSUMIDOR** desse serviço, sem mudar o setes-app (a porta do app continua `/api/billing/fiscal*` e `/api/establishment/issuer*`).
3. **Nascer escalável**: instâncias sem estado em memória que precise ser único; travas no banco; cofre e XML em backend compartilhável; contrato versionado (`/v1`).
4. **Preparar a família NF-e** (pedido: `nfe-api`; parecer: família `/nfe` do mesmo serviço — NF-e 55, NFC-e 65 apontada) sobre o MESMO núcleo (emissor, cofre, transmissão/voz, assinatura, transporte, PDF) — a NF-e **nasce na API, nunca no ERP** (parecer §3.I-6), respeitando a D-E20 (execução com o 1º cliente de mercadoria) salvo decisão nova.
5. **Zero regressão** na Setes: as 704+ NFS-e já emitidas, o A1 no cofre, XMLs em disco e a trilha `trilha-primeiro-cliente.ts` (P8a/P8b) continuam OK após o corte.
6. Gates do método (socrático ≥ 0,70 · adversarial sem HIGH) em cada onda; a API fiscal entra em produção **antes** do ERP como piloto da Onda 4 — ou junto, conforme Q-F10.

---

## 3. Parecer do guardião conceitual (Rodada 0)

> Parecer do agente `setes-conceito` (2026-10-03), colado como veio. **Diverge do rascunho inicial (§4–§5) em quatro pontos, já refletidos abaixo e nas questões §8**: (1) o conceito é UMA API (`fiscal-api`), duas só como topologia; (2) o ERP não guarda ESTADO fiscal — só o VÍNCULO nota × documento; (3) a série do 55 é de quem NUMERA (ERP), a do DPS é de quem DECLARA (API) — D-E2 diverge; (4) o banco da API não pode casar com o prefixo `setes_<cliente>`.

Fatos conferidos no disco: `shared/tax-authority/*`, `shared/invoice-transmission/*` (composição + `branches/service.ts` + repositório), `fiscal-issuer`, `secret-store`, `danfse`, `billing.fiscal.service.ts`, `establishment.issuer.service.ts`, bloco `fiscal` de `invoice-cancel.ts`, DDL de `tb_establishment_issuer`/`tb_invoice_service_transmission(_event)`, `tb_sync_api_key` + `sync.auth.middleware.ts`. Nenhuma decisão do INDICE_CENTRAL trata de isolamento; as que o parecer TOCA (D-E2, D-N7) estão devolvidas nos pontos 2 e 3.

### 3.A Conceito

**Conceito único**: *um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele.* A hipótese do rascunho acerta no que NEGA (não calcula imposto; não conhece pedido/nota) e esconde um "e" no que afirma: "assina, fala, guarda voz e XML" é UM processo (a declaração), mas "recebe fatos do emitente" junta fatos geradores distintos:

| # | Conceito (uma frase) | Fato gerador | Hoje | Natureza |
|---|---|---|---|---|
| 1 | Este CNPJ fala com o fisco com o SEU A1, por modelo/ambiente | upload do A1 + linha por modelo | `tb_establishment_issuer` + cofre | peça (habilitação) |
| 2 | Este documento foi declarado ao fisco: N tentativas × voz × XML | o pedido de transmissão | `_transmission` + `_event` + disco | peça (apresentação × voz — a mesma peça de método do boleto) |
| 3 | Quem pode PEDIR ao serviço, por quais emitentes | licenciamento do consumidor | não existe (`tb_sync_api_key` é outro fato) | peça de fronteira — não é fiscal |

A API é a **composição** das três: a política "como tratamos a voz de um fisco" é o `invoice-transmission.ts` de hoje SEM o efeito local. O arquivo se parte em dois: política da voz (API) × montador do pedido + efeito (ERP). **Teste do terceiro cego**: o Gestao2016 não tem `tb_entity` — tudo que o contrato exigir e ele não puder MANDAR está do lado errado da cerca.

### 3.B Fronteira

Regra de corte: **o ERP responde pelo CONTEÚDO (o que foi vendido/prestado, por quem, a quem); a API, pelo FORMATO e pela CONVERSA (leiaute/Anexo I, assinatura, transporte, voz, arquivo).**

| MIGRA para a API | FICA no ERP | VIAJA no contrato |
|---|---|---|
| `tax-authority` inteira (adn, https-json mTLS, xmldsig paramétrico, dps-builder = forma do leiaute) | ramo `tb_invoice_service` congelado no faturamento (`dps_number` aposentado — é identidade do documento na API); `tb_invoice_event` E/C; `cancelInvoice`; `buildCancelPlan` (bloco `fiscal` lê o VÍNCULO local + a API) | fatos do emitente: CNPJ, IM, cMun IBGE, opSimpNac/regApTribSN/regEspTrib, pTotTribSN — lidos de `tb_entity*`/`tb_entity_tax` pelo ERP |
| `fiscal-issuer` (habilitação por modelo, PKCS#12→PEM, `openIssuer`, guardas de transmissão viva ao mudar ambiente) re-chaveada pelo emitente | `buildEmitter`/`buildRecipient`/`buildDpsBase` viram o MONTADOR do pedido (os 422 de cadastro incompleto são do ERP); L8 (base ISS ≠ valor); `assertTransmittable`; vida da nota (D-N27) | fatos do tomador (documento, nome, endereço) |
| `secret-store` owner do A1 (a peça é UMA; o owner `bank-account` fica no ERP — D-I1 preservada) | privilégios TRANSMITIR/CANCELAR por ramo e resolver de interface; telas "No fisco"/"Emissor fiscal" viram CLIENTES da API | fatos do serviço/itens congelados (cTribNac, cTribMun, vServ, retenção, exigibilidade, descrição, dCompet) |
| transmissão (attempt, ambiente congelado, write-once, `last_queried_at`, reconciliação por dps_id/chave, K→N, rodízio, órfã) + voz append-only | `tb_entity_tax` (o regime também alimenta a regra de ISS) | `dhEmi`/`dhEvento` com offset da zona (Q-TZ2); motivo do cancelamento; autoria opaca (`external_user`) |
| arquivo `STORAGE_PATH/<cnpj>/<ano>/<mes>` (já é por CNPJ), DANFSe/DANFE (função pura do XML), PAM, matriz do Anexo I (`emitterDpsFacts`: E0166/E0712 são conhecimento do fisco) | — | — |

Transmissão e voz são **da API**. O ERP guarda **(1) o vínculo** nota × documento, por VIDA e por MODELO (conjugada = 2 documentos) — fato do ERP ("entreguei esta vida à API como documento X", ato de quem tem TRANSMITIR) e âncora do plano de cancelamento com a API fora (sem vínculo = nunca declarada = cancela local sem perguntar a ninguém; com vínculo = pergunta à API antes, como a Q-ADV1b já faz) — e **(2) o efeito** (`tb_invoice_event` C). Nenhuma coluna de estado fiscal no ERP: estado é DERIVADO na API; lista e detalhe leem por lote de referências (ponto 4).

### 3.C Identidade

Três papéis, três peças: **licenciado** (quem chama, chave) → **emitente** (CNPJ em cujo nome falamos, dono do A1 — pela D-N29 o A1 É do CNPJ, logo o emitente pode NASCER do upload) → **habilitação** (emitente × modelo: ambiente, série/contador do SE). `tb_sync_api_key` NÃO serve: seu conceito é "esta instalação do legado escreve no schema desta institution" — amarra a `tb_institution`, o acoplamento que a isolação quer cortar. Peça nova, no banco próprio da API. UNIQUE `(licenciado, emitente, external_code)` dá POR CONSTRUÇÃO a idempotência que o Inter não dava (Q11: seuNumero não era único) — retry pós-timeout acha o documento em vez de criar o segundo.

### 3.D O efeito atravessa a fronteira

É **fiel** — é a forma pura do modelo. O SAVEPOINT era conveniência de banco compartilhado; o invariante sempre foi "só a voz muda estado; o efeito é aplicado pela composição; recusa = fato + pendência" (D-I10). Com dois serviços, TODA aplicação de efeito vira o que o webhook do Inter já é: voz chega (notificação ou consulta) → efeito na transação do ERP → ack à API com a referência do efeito; sem ack = pendente (espelho exato de `PENDING_EFFECT_WHERE` e da reaplicação D-I25). Guardas: at-least-once exige efeito idempotente (`recordCancelVoice` já é por KIND; `applyCancelEffect` já devolve o C existente); a API registra que o licenciado ACUSOU (`licensee_effect` no lugar de `invoice_event` na voz) sem saber o que o efeito é. Vira maquete se o ERP decidir por estado em cache em vez da voz, se a API conhecer `tb_invoice_event`, ou se um C local nascer sem voz.

### 3.E Uma API ou duas

Conceitualmente **UMA**: um emitente, um A1 (D-N31), uma habilitação por modelo (D-E1), uma política (D-E6 — "o legado errou nos gêmeos 55×65"), estratégia por documento. **(iii)** duas APIs com cofre próprio = o emitente sobe o MESMO A1 em dois cofres e tem duas habilitações para um CNPJ — "mesmo fato em dois lugares" + "composição gêmea por modelo", que o §3.11 da NF-e já lista como maquete. **(ii)** só é legítima como TOPOLOGIA de (i): um repo, um banco, um cofre, dois processos (`--family nfse|nfe`). **(i) Recomendado.** Nomear o serviço pelo DOCUMENTO (`nfse-api`/`nfe-api`) repete o erro de `tb_nfse` paralela: o nome é o conceito (emissão fiscal), o documento é o ramo.

### 3.F Nomes

| Objeto | Nome | Por quê / colisões evitadas |
|---|---|---|
| Serviço | `fiscal-api` (famílias `/nfse`, `/nfe`) | conceito, não documento |
| Quem chama | `tb_licensee` (Recomendado) · alt. `tb_client` | "licença" já é o sentido de `tb_institution.active` (PADROES §6); livre no acervo. `client` colide com "cliente" = tenant e com customer; `consumer` com consumidor final (indFinal); `credential` é como os comentários chamam o A1 |
| Emitente | `tb_emitter` (cnpj, `time_zone` — pasta do mês Q-TZ7; cofre `emitter/<id>/P/`) | "emitente" já é a palavra do `prest` do DPS |
| Habilitação | `tb_issuer` (PK `tb_emitter_id, model`) — sucessora de `tb_establishment_issuer` | "emissor" continua = habilitação |
| Documento no serviço | `tb_fiscal_document` (raiz: emitente, modelo, `external_code`, número) + transmissão/voz por FAMÍLIA de autoridade (ADN × SEFAZ — fatos diferem, D-E6) | "documento" sozinho = CPF/CNPJ no ERP (`by-document`); DF-e é o termo oficial |
| Referência do consumidor | `external_code` | palavra da casa para "id no outro sistema" (sync) |
| Vínculo no ERP | `tb_invoice_fiscal_document` (nota, vida, modelo, id na API) — sem FK, molde `tb_bank_slip_title` | vínculo ≠ estado |
| Notificação | colunas `notified_at` + `licensee_effect` na voz; URL do licenciado + `inbound_token` (molde do canal); receptor no ERP `/hooks/fiscal-document/:inst/:token` (molde `/hooks/bank-channel`) | sem `tb_notification`: "avisamos" é fato da voz, como `last_queried_at` é "olhamos" |

### 3.G O que NÃO entra (e por quê)
Reuso de `tb_sync_api_key` (fato gerador ≠) · estado fiscal em coluna do ERP (decidido fora = status) · schema-por-cliente dentro da API (um banco, escopo por linha `tb_licensee_id`) · cópia da cadeia de entidade na API (teste do terceiro cego) · cálculo de imposto na API · `tb_integration*`/`tb_nfe*`/`tb_nfse*` · usuário do ERP como FK na API (autoria é texto opaco) · segunda tabela de voz no ERP (duas verdades).

### 3.H Onde vira maquete
Cofre/emissor duplicado por API · API que conhece `tb_invoice`/`tb_order` · ERP que cancela local sem perguntar à API quando HÁ vínculo · "status" sincronizado por cron · série do 55 na API (quem numera é o ERP — ponto 2) · `external_code` sem UNIQUE · callback sem consulta (D33: polling faz a ponte; os dois convivem, uma porta de efeito só).

### 3.I Pontos que exigem decisão do Valdo (levados à §8 como Q-F16…Q-F20 e revisões de Q-F1/Q-F5/Q-F6/Q-F8)

1. **Granularidade do licenciado para o próprio ERP**: (a) um por institution — espelho da D12, cerca do emitente feita pela API, chave no cofre `establishment/<inst>` (Recomendado; custo: provisionamento no POST de institutions com uma credencial de serviço) · (b) um para o setes-api inteiro com N emitentes (mais simples; a cerca por CNPJ fica só no ERP).
2. **D-E2 diverge** ("série no emissor aposenta `invoice_serie`" pressupunha emissor e numeração no mesmo lugar): a série do 55 é fato de quem NUMERA (ERP); a do DPS, de quem DECLARA (API). (a) API guarda série/contador só do SE; 55/65 numeram no ERP e a série viaja no payload (Recomendado) · (b) API guarda as séries de todos e o ERP a lê antes de cunhar (ERP não numera com a API fora — maquete).
3. **D-N7 relaxa** ("voz C → C local na MESMA transação" é impossível entre serviços): confirmar o invariante como "C local SÓ da voz; efeito na transação do ERP; recusa ou falha = pendência visível e reaplicável" (Recomendado) — já é o que vale para o C vindo da consulta.
4. **Leitura de estado pelo ERP**: (a) sem espelho — lista e detalhe por lote de referências; API fora = selo "indisponível" e ações fiscais 503 (Recomendado: zero coluna de estado) · (b) espelho de exibição escrito SÓ pela notificação, nunca decisório — se a latência da lista doer.
5. **Banco da API**: nome fora do prefixo `setes_<cliente>` (`setes_fiscal` casaria com `SCHEMA_RE`) — ex.: `fiscal_api`; um banco, escopo por linha.
6. **Ordem**: (a) extrair AGORA com a NFS-e em produção como piloto, contrato já paramétrico por família — a NF-e nasce na API, nunca no ERP (Recomendado) · (b) NF-e no ERP primeiro e extrair as duas depois (paga a extração duas vezes).
7. **Palavra do licenciado**: `tb_licensee` × `tb_client` — palavra é decisão do Valdo (lição "contrato").

*Arquivos lidos pelo guardião (nenhum editado)*: guardiao-conceitual.md · PADROES_BANCO.md · INDICE_CENTRAL.md · os dois prompts fiscais (§3/§4/§8/§10) · `tax-authority/{types,xmldsig,dps-builder,https-json}.ts` + `adapters/adn.ts` · `invoice-transmission/*` · `fiscal-issuer/*` · `secret-store.ts` · `danfse.ts` · `invoice-cancel.ts` (bloco `fiscal`, 322–373) · `billing.fiscal.service.ts` · `establishment.issuer.service.ts` · `sync.auth.middleware.ts` · `sql/03_schema_cliente_ddl.sql` (479–525) · `sql/05_sync_api_key.sql`.

---

## 4. Fronteira proposta — o que migra, o que fica, o que nasce

> ⚠️ **SUPERADA onde conflitar com o §12** (Rodada 2: a API lê o ERP — D-F10; efeito no setes-api — D-F11; dois projetos + núcleo — D-F12/D-F17).

Hipótese organizadora, **confirmada pelo parecer §3.A/§3.B com duas correções**: *um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele* — a API responde pelo FORMATO e pela CONVERSA (leiaute, assinatura, transporte, voz, arquivo); o ERP responde pelo CONTEÚDO (o que foi vendido/prestado, por quem, a quem). Não calcula imposto. Não conhece pedido, nota, cliente ou cadeia do ERP. Correções do parecer sobre o rascunho: (1) a matriz do Anexo I (`emitterDpsFacts` — E0166/E0712) é conhecimento do FISCO e migra; (2) o ERP **não guarda estado fiscal** — guarda o VÍNCULO nota × documento (Q-F16).

| Peça hoje (setes-api) | Destino | Trabalho | Linhas |
|---|---|---|---|
| `tax-authority/*` (types, adn, dps-builder, https-json, xmldsig) | **`fiscal-api`** (núcleo comum às famílias) | MOVER sem mudança de contrato; `AuthorityContext` continua recebendo o par PEM | 1.054 |
| `secret-store` | **copiar** para o núcleo (owner `emitter`); o setes-api MANTÉM a sua para o canal do banco | COPIAR + renomear owner; o caminho deixa de ter `<schema>` (identidade = emitente) | 149 |
| `fiscal-issuer` | núcleo | MOVER + reindexar: PK `(institution, model)` → `(emitente CNPJ, model)`; validação do CN × CNPJ já existe (D-N29b) | 416 |
| `transmission.repository` + máquina de estados de `invoice-transmission.ts` (reserva → fisco → voz → reconciliação K/F → refresh/rodízio) | `fiscal-api` (política da voz, por família de autoridade) | MOVER + reindexar: `(institution, invoice, terminal, attempt)` → `(documento, attempt)`; a "nota mudou?" (MEDIUM-3) fica no ERP (vida da nota no `external_code`) | ~1.400 |
| `branches/service.ts` — leitura do ERP (`readServiceInvoice`, `buildEmitter`, `buildRecipient`, `buildDpsBase`, `assertTransmittable`, L8) | **FICA no setes-api** como *montador do pedido* (`@shared/fiscal-client/nfse-facts.ts`) — os 422 de cadastro incompleto são do ERP | ADAPTAR: o resultado deixa de virar XML aqui e vira o PAYLOAD da API (`DpsInput` sem série/nDPS — já é assim: `DpsBase`); **`emitterDpsFacts` (matriz do Anexo I) MIGRA**; **`dps_number`/`lockDpsNumber` morrem no ramo** (a identidade do documento é da API — §3.B) | ~350 ficam / ~250 migram |
| `applyCancelEffect` / `reconfirmBeforeLocalCancel` / bloco `fiscal` do `buildCancelPlan` | **FICA no setes-api** | ADAPTAR: o bloco lê o VÍNCULO (FOR UPDATE) e pergunta à API ANTES da transação (a Q-ADV1b já faz isso com o fisco); sem vínculo = nunca declarada = cancela local sem perguntar; efeito idempotente + ack à API (`licensee_effect`) | ~300 |
| `danfse` | `fiscal-api` — `GET /v1/nfse/documents/{id}/danfse` | MOVER (função pura do XML); o nome/município do emitente passam a vir de `tb_emitter` (hoje vêm da cadeia) | 168 |
| `billing.fiscal.*` + 9 rotas · `establishment.issuer.*` + 5 rotas | **FICAM** como porta do app | ADAPTAR: service chama o cliente HTTP em vez da composição; privilégios TRANSMITIR/CANCELAR continuam aqui (Q-F11) | ~565 |
| `tb_establishment_issuer` · `tb_invoice_service_transmission` · `_event` (058–061) | **nascem no banco do serviço** como `tb_licensee` · `tb_emitter` · `tb_issuer` (emitente × modelo) · `tb_fiscal_document` + transmissão/voz por FAMÍLIA de autoridade (§3.F) | DDL novo (`revisar-ddl`) + **migração única dos dados da Setes** (transmissões, vozes, XMLs, A1) | 6 tabelas + script |
| Vínculo no ERP: `tb_invoice_fiscal_document` (nota × vida × modelo × id do documento na API; sem FK, molde `tb_bank_slip_title`) | **novo no setes-api** | NOVO: **sem coluna de estado** (§3.B/§3.I-4 — estado é derivado na API e lido por lote de referências); alternativa (b) espelho de EXIBIÇÃO escrito só pela notificação = Q-F16 | 1 tabela |
| Testes (7 arquivos) | 5 migram (mocks na fronteira já isolam `pool`/adapter), 2 ficam/adaptam (cancel adversarial, folder-zone) | ADAPTAR nomes de módulo e chaves | 1.460 |
| `runningRefresh` / `runningBatch` em memória | morrem | trava no banco (linha do emitente `FOR UPDATE WAIT`) ou semântica "1 por instância" declarada | — |

**O que NÃO migra (e por quê)**: `tb_invoice_event` E/C e `cancelInvoice` (vida da nota é do ERP); `calcIssqn`, `@shared/service-tax-rule`, `@shared/tax-rule` (imposto é do ERP — a API declara, não calcula); `tb_entity_tax` 062/063 (fatos do emitente são CADASTRO do ERP e viajam no payload — Q-F15; o regime também alimenta a regra de ISS); privilégios de ação (autorização de USUÁRIO é do ERP; o serviço autentica o LICENCIADO); `lockInvoice`/`lockInstitutionCounters` (o contador nDPS migra para o serviço; o lock da nota e a numeração do 55/65 ficam — §3.I-2); a cadeia de entidade (teste do terceiro cego: o Gestao2016 não tem `tb_entity`).

---

## 5. Arquitetura proposta (Rodada 0 — tudo sujeito às Q-F)

> ⚠️ **SUPERADA onde conflitar com o §12** — em especial §5.1 (contrato por fatos), §5.2/§5.8 (licenciado/app — D-F13/D-F14), §5.3 (setes-api cliente — D-F4), §5.4 (cofre em arquivo — D-F16), §5.6/§5.10 (um projeto — D-F17). §5.5 e §5.9 seguem valendo.

### 5.1 Contrato externo da `fiscal-api` — família `/v1/nfse` (OpenAPI design-first)

Vocabulário: o do adaptador (`DpsInput`, `CancelEventInput`, `ParsedNfse`) — já é o vocabulário do XSD, não do ERP. Nomes conforme o parecer §3.F (`licensee` · `emitter` · `issuer` · `fiscal document` · `externalCode`).

| Recurso | Operação | Semântica |
|---|---|---|
| `POST /v1/emitters` · `GET /v1/emitters/{cnpj}` · `PUT /v1/emitters/{cnpj}/models/{SE}` | habilitação | emitente = CNPJ + identidade fiscal mínima (cMun IBGE, IM, nome, fuso IANA) + linha por modelo (ambiente H/P, série, contador) |
| `PUT /v1/emitters/{cnpj}/certificate` (.pfx + senha) · `GET` (só metadados) · `DELETE` | cofre | PKCS#12 → par PEM; senha nunca persiste (D-N5); UM A1 por emitente (D-N31) |
| `POST /v1/nfse/documents` | transmitir | corpo = fatos do DPS (competência, prestador: regTrib/pTotTribSN, tomador, serviço, valores, `dhEmi` com offset da zona) + `externalCode` (id do consumidor) + `externalUser` (autoria opaca); idempotência POR CONSTRUÇÃO pelo UNIQUE `(licensee, emitter, external_code)` — retry pós-timeout ACHA o documento (§3.C); **síncrono** com o ADN: 201 A (chave, número, dhProc) · 422 R (códigos E0xxx no `fields[]`) · **202 K/em voo** no desfecho ambíguo (nada fecha — D-I21) |
| `GET /v1/nfse/documents/{id}` · `GET /v1/nfse/documents?externalCode=a,b,c` (lote) | estado | linha do tempo (vozes), estado derivado da última voz da última tentativa, chave, número, pendências; o lote por referências é como a lista do ERP mostra o selo fiscal (Q-F16) |
| `POST /v1/nfse/documents/{id}/attempts` | reapresentar | `attempt + 1` só com a anterior resolvida (R/F); mesma vida = mesmo nDPS (D-N3/D-N18) |
| `POST /v1/nfse/documents/{id}/refresh` · `POST /v1/emitters/{cnpj}/refresh` | consulta | voz por consulta (source Q), rodízio por `last_queried_at`, orçamento de tempo |
| `POST /v1/nfse/documents/{id}/cancel` {motivo} | cancelar no fisco | e101101 síncrono; voz C; **o efeito no ERP é do consumidor** (§5.3) |
| `POST /v1/nfse/documents/{id}/events/{n}/ack` {effectRef} | acusar efeito | o licenciado diz "apliquei o efeito desta voz" (`licensee_effect` na voz — §3.D); voz sem ack = pendência visível dos dois lados |
| `GET …/xml` · `GET …/danfse` · `GET …/events` | arquivos | XML autorizado / evento de cancelamento / PDF nosso |
| `GET /v1/health` · `GET /v1/emitters/{cnpj}/authority-status` | operação | prazo do PAM (D-N15) e disponibilidade |
| Notificação (opcional, Q-F4) | callback | `POST` na URL do licenciado com `inbound_token` (molde do canal do banco) a cada voz nova — só GATILHO de consulta, nunca fonte de verdade (D-I9); `notified_at` na voz; receptor no ERP `/hooks/fiscal-document/:inst/:token` (molde `/hooks/bank-channel`) |

Regras herdadas que o contrato fixa: estado DERIVADO da última voz (nunca coluna `status`); 2xx ilegível = ambíguo (502/K), nunca aceite; recusa de REGRA ≠ transitório (`retryable`); erros com `{error, code, fields[{field, message, expected?}]}` (framework de mensagens).

### 5.2 Identidade e autenticação

- **Licenciado** (`tb_licensee` — parecer §3.C/§3.F; alternativa `tb_client`, Q-F20): quem chama, com chave (`X-Api-Key`, hash no banco, precedente D12 do sync) ou OAuth2 client-credentials (Q-F3). É dono de N emitentes. Autoriza o *acesso*, não a *ação*: TRANSMITIR/CANCELAR por usuário continuam no ERP (Q-F11). Para o próprio setes-api: um licenciado por institution (cerca feita pela API) × um para o ERP inteiro — Q-F17.
- **Emitente** (`tb_emitter`) = CNPJ em cujo nome falamos, dono do A1 (pela D-N29 o A1 É do CNPJ — o emitente pode NASCER do upload), com `time_zone` (pasta do mês, Q-TZ7). **Habilitação** (`tb_issuer`, PK emitente × modelo) = ambiente + série/contador **só do SE** (a série do 55/65 é de quem numera, o ERP — Q-F18). O setes-api mapeia `institution → CNPJ` (`tb_company.cnpj` da própria entity). Cofre: `SECRETS_PATH/emitter/<id>/P/` (um A1 por emitente — D-N31), sem `<schema>`.
- Rate limit por licenciado; idempotência pelo UNIQUE `(licensee, emitter, external_code)` (§3.C); auditoria por licenciado (quem pediu o quê, `externalUser` opaco).

### 5.3 O fluxo que atravessa a fronteira (NFS-e)

> ⚠️ Este fluxo (setes-api chamando a fiscal-api) está EM REVISÃO pela §11: o Valdo quer o setes-app como cliente direto e o setes-api passivo. A versão candidata do fluxo está em §11.3; esta fica como registro da Rodada 1 até a Q-F27 decidir.

```
setes-api (billing.fiscal.service)                 fiscal-api (família nfse)                ADN
  1. readServiceInvoice + buildDpsBase  ──► fatos  (FICA: ERP monta o PEDIDO; 422 de cadastro são do ERP)
  2. grava o VÍNCULO nota×vida×modelo → externalCode (ato de quem tem TRANSMITIR)
     ─ POST /v1/nfse/documents {externalCode, fatos} ──► UNIQUE(licensee, emitter, external_code): acha ou cria o documento
                                                       reserva attempt (lock emitente·série) → nDPS; assina; *-dps.xml ──► POST /nfse
                                                       voz A/R (source P) · ambíguo = K em voo  ◄──────────── 2xx / 4xx / timeout
  3. ◄── 201 {documentId, attempt, state A, chave, nº}   |  422 R (fields[])   |  202 K
  4. completa o vínculo com o documentId — transação do ERP, SEM o fisco dentro; NENHUMA coluna de estado (Q-F16)
  5. lista/detalhe/selo fiscal: GET /documents?externalCode=a,b,c (lote); API fora = selo "indisponível", ações fiscais 503;
     "Consultar" = POST /refresh
  6. cancelar nota: buildCancelPlan lê o VÍNCULO FOR UPDATE → sem vínculo = nunca declarada = cancela local; com vínculo =
     GET /documents/{id} ANTES da transação (como reconfirmBeforeLocalCancel já faz) → POST /cancel → voz C →
     cancelInvoice local na transação do ERP (idempotente) → POST .../events/{n}/ack; sem ack = pendência visível nos dois lados
     + "Reaplicar efeito" (D-I25)
```

O que muda de verdade: hoje voz e efeito moram na MESMA transação (SAVEPOINT). O parecer §3.D fixa que isso era conveniência de banco compartilhado — o invariante sempre foi "só a voz muda estado; o efeito é aplicado pela composição; recusa = fato + pendência" (D-I10). Com dois serviços, TODA aplicação de efeito vira o que o webhook do Inter já é; a D-N7 relaxa para "C local SÓ da voz; efeito na transação do ERP; falha = pendência reaplicável" (Q-F19). Vira maquete se o ERP decidir por estado em cache em vez da voz, se a API conhecer `tb_invoice_event`, ou se um C local nascer sem voz.

### 5.4 Persistência e arquivos

- Banco próprio **`fiscal_api`** (Q-F5 — NUNCA `setes_<algo>`: casaria com o `SCHEMA_RE` dos schemas de cliente, §3.I-5), um banco com escopo por linha `tb_licensee_id`: `tb_licensee` · `tb_emitter` (CNPJ, nome, cMun IBGE, IM, `time_zone`) · `tb_issuer` (emitente × modelo: ambiente, série/contador do SE) · `tb_fiscal_document` (emitente, modelo, `external_code` UNIQUE por licenciado×emitente, número) · transmissão (attempt, ambiente congelado, dps_id, chave, número, dh_proc, last_queried_at) e voz (append-only: kind + código cru + source + dh + `notified_at` + `licensee_effect`) **por FAMÍLIA de autoridade** (ADN × SEFAZ — fatos diferem, D-E6); amanhã inutilização (família NF-e). Mesma forma das 058–061 — só a chave muda.
- Migrations próprias do serviço (runner igual ao do setes-api); regra PADROES_BANCO (UTC na sessão, REPEATABLE READ, contadores por lock — §9/§10) herdada.
- XML em `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mes>/` (já é assim); cofre e storage atrás de interface com backend trocável (filesystem → objeto/KMS) — pré-requisito de 2+ instâncias.
- **Migração única dos dados da Setes**: `tb_establishment_issuer` → `tb_emitter` + `tb_issuer`; transmissões + vozes → documento/tentativa/voz com `external_code = <invoiceId>:<vida>`; XMLs copiados; A1 copiado para `emitter/<id>/P/`; o VÍNCULO do ERP (`tb_invoice_fiscal_document`) nasce do mesmo script; `dps_number` do ramo deixa de ser lido. Corte com homologação H antes de P (Q-F7).

### 5.5 Escala — o que o serviço precisa ter desde o 1º dia

1. Instância sem estado único: nenhum `Map/Set` de controle (lote/rodízio) — trava do emitente no banco (`FOR UPDATE WAIT n`, D-A23).
2. Serialização por construção: 1 tentativa viva por documento; contador por emitente×série sob lock (regra 7 do PADROES §9).
3. UNIQUE `(licensee, emitter, external_code)` por construção (replay = acha o documento e devolve o estado, nunca 2ª NFS-e — a chave repetida foi achado real da Q-N33; `seuNumero` não único foi o da Q11 do Inter).
4. Orçamento de tempo por requisição (o ADN leva segundos por DPS) e lote fora da API: quem lota é o consumidor (como hoje) ou uma fila interna com relatório consultável (candidata, não desta onda).
5. Logs estruturados com `documentId`/`externalCode`/`licensee`; `/health` que prova banco + cofre; métricas mínimas (documentos/dia por licenciado — contagem DERIVADA das tentativas, nada a modelar — Q-F12).

### 5.6 Repositórios, pastas e espelho de conhecimento (impacto na raiz fixa)

A raiz `D:\Gestao2027` tem tabela FIXA de pastas (CLAUDE.md / `ORGANIZACAO_PASTAS.md` §1). Qualquer opção abaixo exige atualizar as duas tabelas e criar o espelho `Infra-IA/<projeto>/` (regra de simetria).

| Opção | Pastas/repos | Prós | Contras |
|---|---|---|---|
| (a) duas pastas `nfse-api/` e `nfe-api/`, cada uma seu repo, cofre próprio | 2 repos + 2 espelhos | literal ao pedido | **maquete pelo parecer §3.E**: o emitente sobe o MESMO A1 em dois cofres e tem duas habilitações para um CNPJ; núcleo duplicado |
| (b) um repo `fiscal-api/` **com dois PROCESSOS por família** (`--family nfse` / `--family nfe`), um banco `fiscal_api`, um cofre | 1 repo + 1 espelho; 2 deployáveis | escala e deploy independentes por família; D-N31 por construção; código comum sem pacote publicado | legítima SÓ como topologia de (c) — mesma base de código, mesma verdade; disciplina de fronteira entre famílias |
| (c) **`fiscal-api/`** único — famílias `/v1/nfse` e `/v1/nfe` no mesmo processo **(Recomendado pelo guardião — conceito ÚNICO: um emitente, um A1, uma habilitação por modelo, uma política da voz)** | 1 repo, 1 espelho, 1 deployável | mais simples; nome pelo CONCEITO (emissão fiscal), não pelo documento (`tb_nfse` paralela foi o erro do legado) | escala uniforme — se a NFC-e pedir perfil próprio, vira (b) sem mudar modelo |

### 5.7 Deploy

Dockerfile (Node 20, `npm ci`, `tsc`, `node dist/server.js [--family nfse|nfe]`), `docker-compose` de dev (MySQL + setes-api + fiscal-api), variáveis (`DB_*`, `SECRETS_PATH`, `STORAGE_PATH`, `FISCAL_API_KEYS_PEPPER`), volumes para cofre/XML, HTTPS pelo LB da SaveInCloud, `pre-deploy` check (molde `scripts/pre-deploy-tz-check.ts`). A `fiscal-api` é candidata a **1º serviço publicado** (superfície pequena, contrato fechado, trilha P8 como régua) — Q-F10.

### 5.8 Multi-app por cliente (Rodada 1 — D-F2)

Três níveis, três fatos geradores — a estrutura do parecer §3.C ganha um nível abaixo do licenciado:

| Nível | Peça | Fato gerador | O que carrega |
|---|---|---|---|
| Cliente | `tb_licensee` | licenciamento (o cliente contrata a emissão) | identidade comercial, limites (req/min, documentos/dia), URL de notificação + `inbound_token`, `active` |
| Aplicativo | `tb_licensee_app` ⚠️ nome na Q-F20 | o cliente AUTORIZA um app a chamar em seu nome (setes-api, app Android de vendas, sistema de terceiro…) | `app_id` público + `secret` (só hash), **escopos** (`nfse:write`, `nfse:read`, `nfe:write`, `emitter:admin`), emitentes permitidos (todos do licenciado ou lista), `revoked_at`, `last_used_at` |
| Emitente | `tb_emitter` / `tb_issuer` | o A1 + a habilitação por modelo | como no §3.F |

Autenticação (revisa a Q-F3): o app troca `app_id + secret` por um **token curto** (`POST /v1/auth/token`, client-credentials simplificado, JWT de ~1 h assinado pela fiscal-api) e chama com `Authorization: Bearer`. A chave em si nunca viaja em cada requisição e a revogação é imediata na próxima troca. **Aplicativo móvel/web do usuário final NÃO guarda o secret**: ou opera através do backend do cliente (setes-api, que é um `tb_licensee_app` com escopo pleno), ou recebe do backend um token curto já trocado (token exchange) — Q-F22. Rate limit e auditoria por app (`externalUser` opaco continua sendo a autoria dentro do app). CORS liberado por lista de origens do licenciado (web direta); Swagger/OpenAPI público com exemplos por família é parte da entrega, não documentação interna.

Autorização de AÇÃO continua do ERP (Q-F11): a fiscal-api sabe que o app PODE emitir pelo emitente X; quem dentro do cliente pode apertar "transmitir" é regra do sistema que chama.

### 5.9 Dimensionamento para 1000 clientes (Rodada 1 — D-F3; premissas marcadas, número real = Q-F23)

| Premissa (a confirmar) | Valor assumido | Documentos/dia |
|---|---|---|
| 60 % dos clientes = serviços (NFS-e) | 600 × 30/mês ÷ 22 | ~800 |
| 40 % = mercadoria com NF-e | 400 × 20/dia útil | ~8.000 |
| metade dos de mercadoria tem PDV (NFC-e) | 200 lojas × 200/dia | ~40.000 |
| **Total** | | **~49.000/dia** (≈ 1,7/s média em 8 h; pico ≈ 5/s) |

Consequências de engenharia (o que a F3 precisa provar, não só declarar):

| Dimensão | Número derivado | Implicação |
|---|---|---|
| Concorrência com o fisco | 5/s × 1–3 s por autorização → 5–15 chamadas simultâneas | 2 instâncias Node bastam para a CPU; o gargalo é o fisco — orçamento por requisição, `keep-alive` por emitente, fail-closed quando a autoridade cai (regra D-I8) |
| Linhas no banco | ~5 por documento (documento, tentativa, 2 vozes, ack) → ~250 k/dia → **~60 M/ano** | índices por `(licensee, emitter, external_code)` e `(emitter, created_at)`; **particionamento por ano ou arquivamento** a partir do 1º ano; nunca `SELECT` sem escopo de licenciado |
| XML em disco | 8–15 KB × 49 k → **0,5–0,75 GB/dia → ~200 GB/ano** | filesystem local NÃO serve a 2+ instâncias nem a esse volume: **storage de objeto (S3-compatível)** atrás da interface que já existe (`storageRoot()`); retenção legal 5 anos |
| Certificados A1 | ≥ 1.000 pares PEM (N por cliente com filiais), renovação anual | cofre **criptografado em repouso** (KMS ou chave-mestra) atrás de `secret-store`; **alerta de vencimento por licenciado** (o A1 da Setes vence 08/10/2026 — caso zero do alerta) |
| Consultas ao fisco | rodízio por emitente; SEFAZ pune consulta repetida (cStat 656) | o `refresh` sai da requisição e vira **worker** com orçamento global e por emitente (mata `runningRefresh` por construção); NF-e assíncrona (recibo 103/105) exige o mesmo worker — Q-F25 |
| Lote do ERP | D27: 50 ordens/requisição, 60 s | continua no CONSUMIDOR; a fiscal-api é por documento. Fila interna só se um licenciado pedir "transmitir 5.000" — fora desta fase |
| Observabilidade | 1000 clientes = 1000 "ele disse que a nota não saiu" | log estruturado com `licensee/app/emitter/externalCode/documentId`, métricas por licenciado (documentos, rejeições por E0xxx, latência do fisco), `/health` que prova banco + cofre + storage |

Teste de carga como critério de aceite (§10.9): script `scripts/carga-fiscal.ts` contra um fisco FALSO (stub do ADN com latência e falhas configuráveis) simulando 1000 licenciados / 5 req/s por 30 min: p95 < 5 s fora do tempo do fisco, zero 500, zero documento duplicado, 2 instâncias.

### 5.10 Estrutura do projeto `fiscal-api` (Rodada 1 — D-F1; criada nesta sessão SEM código)

```
D:\Gestao2027\fiscal-api\                 ← repo próprio (valdosouza/gestao-2027-fiscal-api), porta 3002
├── CLAUDE.md                              regras para agentes (fronteira, nomes, teste do terceiro cego)
├── README.md                              estado: F0 — nada de código até D-F fechar F1
├── .env.example · package.json · tsconfig.json (paths @gateway/@modules/@shared — molde setes-api)
├── src/
│   ├── gateway/        auth por token de app (JWT curto) · rate limit por app · router /v1 · CORS por licenciado
│   ├── modules/        licensees · licensee-apps · emitters · issuers · nfse (documents/attempts/events/xml/danfse/ack) · nfe (F4) · auth (token) · hooks (notificação de saída)
│   ├── shared/         tax-authority (adn · sefaz) · xmldsig · secret-store (owner emitter) · storage (fs → objeto) · fiscal-document (máquina de estados por FAMÍLIA) · pdf (danfse · danfe) · db · errors · logger · swagger · time-zone
│   ├── migrations/sql/ banco `fiscal_api` (runner = molde do setes-api)
│   └── __tests__/
├── scripts/            migrate-from-setes-api.ts · smoke-adn-h.ts · carga-fiscal.ts · pre-deploy-check.ts
└── (contratos oficiais ficam no espelho: Infra-IA/fiscal-api/integracoes/ — hoje em Infra-IA/setes-api/integracoes/nfse-adn)

Infra-IA\fiscal-api\                      ← espelho de conhecimento (regra de simetria)
├── INDEX.md                               START HERE (criado 2026-10-03)
├── prompt_fase1_fiscal_api.md             (quando este prompt fechar — hoje em prompts/)
└── skills/                                (nascem com a F1: novo-modulo-fiscal, nova-familia-de-autoridade)
```

Entrou nas tabelas fixas da raiz (CLAUDE.md, `ORGANIZACAO_PASTAS.md`) e no `INDICE_CENTRAL.md` nesta sessão. Módulo de cadastro na fiscal-api segue `ARQUITETURA_MODULOS_API.md` (6 arquivos, `/v1/<modulo>`); o módulo `nfse` é tela de PROCESSO (molde `bank-slips`), não cadastro.

---

## 6. Plano em ondas e esforço

> ⚠️ **SUPERADO pelo §12.7** (ondas e esforço revistos na Rodada 2).

| Onda | Entrega | Tamanho | Esforço (sessões) | Calendário | Depende de |
|---|---|---|---|---|---|
| **F0 — Decisões + contrato** | Rodadas 1..N deste prompt (Q-F2…Q-F26); OpenAPI `v1` da `fiscal-api` (família nfse + auth de apps) escrito ANTES do código (design-first, nível PÚBLICO: exemplos, códigos de erro, limites), já paramétrico por família; DDL do `fiscal_api` revisado (`revisar-ddl`) | 1 OpenAPI (~800 linhas) + DDL (7 tabelas) | 3–4 | 2–3 dias | Valdo (decisões) |
| **F1 — `fiscal-api`, família nfse** | repo `fiscal-api/` (D-F1); mover tax-authority/xmldsig/secret-store/fiscal-issuer/danfse/máquina de estados + repository re-chaveado por emitente/documento; `emitterDpsFacts` (Anexo I); shell do serviço (**licenciado + apps + token curto + escopos + CORS por licenciado**, UNIQUE de idempotência, rate limit por app, OpenAPI servido, health, logger, migrations próprias); DTOs zod do payload; testes migrados + novos; script de migração dos dados da Setes; smoke contra o ADN H com o A1 real | ~3,7 k linhas movidas/adaptadas + ~2,4 k novas + ~2,3 k testes | 10–14 | 7–10 dias úteis (inclui 2 rodadas de gates) | F0 |
| **F2 — setes-api consumidor** | `@shared/fiscal-client` (HTTP, mapeamento de erros → `FISCAL_*`, retry só em `retryable`); `branches/service.ts` vira montador do pedido; VÍNCULO `tb_invoice_fiscal_document` + ack de efeito + pendências; `billing.fiscal.service` e `establishment.issuer.service` chamam o cliente; lista com selo por lote de referências (ou espelho de exibição — Q-F16); `buildCancelPlan.fiscal` lê vínculo + pergunta à API; `dps_number` aposentado no ramo; trilha P8a/P8b OK; app INALTERADO; corte H → P da Setes | ~2,1 k linhas alteradas + ~500 testes + 1 migration | 5–7 | 4–5 dias úteis (gates do delta) | F1 |
| **F3 — Produção ESCALÁVEL (piloto da Onda 4; D-F3)** | Dockerfile, compose, variáveis/segredos fora do repo, HTTPS/DNS (`fiscal.setesgestao.com.br`?), **2+ instâncias atrás do LB**, **storage de objeto para XML** atrás de `storageRoot()`, **cofre criptografado em repouso** atrás de `secret-store`, **worker de refresh/rodízio** (fim do `runningRefresh`), alerta de vencimento de A1 por licenciado, particionamento/arquivamento planejado, métricas por licenciado, backup, pre-deploy check, **teste de carga `carga-fiscal.ts`** (1000 licenciados × 5 req/s × 30 min contra fisco falso); `fiscal-api` publicada e o setes-api do dev apontando para ela | infra + ~1,2 k linhas (worker, storage/cofre adaptadores, carga) | 6–10 | 1–2 semanas + espera externa (DNS, SaveInCloud: oferta de objeto/KMS — Q-F25) | F2 + Q5/Q6 da fase Primeiro Cliente |
| **F4 — família nfe (NF-e 55) — nasce NA API, nunca no ERP (§3.I-6)** | levantamento oficial (`integracoes/nfe-sefaz/`: MOC 7.0, NT 2025.002, schemas PL, autorizadores, cStat); `adapters/sefaz.ts` (SOAP 1.2: autorização síncrona/assíncrona com recibo, consulta protocolo, status, evento 110111, inutilização) + `authorizers.ts`; builder NF-e 4.00 com grupos ICMS/CSOSN/IPI/PIS/COFINS/ICMSUFDest **+ IBS/CBS**; chave 44 (série e número vêm do ERP no payload — Q-F18) + cDV; validação XSD; voz com P e D; inutilização de faixa; DANFE A4 (motor pdfkit); ERP: `branches/merchandise.ts` como montador do pedido (6 snapshots + cadeia + NCM/CEST/EAN + transporte), vínculo por ramo, bloco fiscal por ramo, cópia de ordem #20, aba "Numeração"; app: seção "No fisco" no pedido faturado | ~8 k linhas novas no serviço + ~2 k no ERP + ~1,5 k Dart + ~3 k testes | 25–35 | 5–7 semanas (≥ 3 rodadas de gates; 1ª sessão real na SEFAZ-PR H crava cStat e assinatura) | **D-E20** (1º cliente de mercadoria) · fase IBS/CBS no motor (Q-F14) · e-CNPJ do cliente |
| **F5 — NFC-e 65 (PDV)** | QR Code v2 + CSC no cofre, contingência off-line (tpEmis 9) com transmissão posterior, prazo de cancelamento em minutos, série por terminal, DANFE NFC-e (bobina), fila assíncrona para volume | ~4 k serviço + PDV no app (onda própria do PDV) | 15–25 | 3–5 semanas | F4 + onda do PDV |

**Totais (Rodada 1)**: `fiscal-api` com NFS-e em produção ESCALÁVEL (F0–F3) = **24–35 sessões ≈ 5–6 semanas de calendário** com gates (era 18–27 na Rodada 0 — a diferença é multi-app, contrato público e produção para 1000); família NF-e (F4) = **+25–35 sessões ≈ 5–7 semanas**, só com fato gerador; NFC-e (F5) = +15–25. Comparação: a Onda 3 inteira (fisco desconhecido) levou 10 dias — F1+F2 movem código provado, por isso a faixa parecida apesar do volume maior. O parecer §3.I-6 pesa a favor de extrair AGORA: fazer a NF-e dentro do ERP e extrair depois paga a extração duas vezes.

**Frentes IRMÃS que a visão da Rodada 1 exige e que NÃO são da fiscal-api** (dimensionadas para o Valdo decidir se entram, quando e onde):

| Frente | Por quê a visão precisa dela | Tamanho | Onde vive |
|---|---|---|---|
| **S1 — setes-api como plataforma para apps de venda** (Q-F21 leitura (a)) | "aplicativos de vendas que criam orders e enviam para autorização" hoje só existem como setes-app com JWT de usuário; um app de terceiro precisa de credencial de APLICATIVO por institution, escopos, contrato `/v1` público de pedidos + faturamento + "faturar e autorizar" numa chamada (PDV não espera duas), documentação pública | 8–12 sessões | setes-api (prompt próprio — molde deste: licenciado/app vira `tb_institution_app`?) |
| **S2 — setes-api em escala de 1000 clientes** (Q-F24) | fatos do código hoje: `runMigrationsForAllInstitutions` roda as migrations dos N schemas a CADA boot (1000 schemas = minutos de boot e deploy serial); pool único `connectionLimit: 20`; rate limit 300/min por institution em memória; `interface-config` cache por processo | 3–5 sessões de DIAGNÓSTICO (medir com 1000 schemas sintéticos) antes de qualquer correção | setes-api (fase própria) |
| **S3 — IBS/CBS** (Q-F14) | pré-requisito da família NF-e e da própria NFS-e da Setes em 01/01/2027 | fase própria (motor + 2 builders) | setes-api motor + fiscal-api builders |

**Riscos que puxam para o teto**: (1) homologação do ADN só com o A1 real da Setes (vence **08/10/2026** — renovar antes de F1 terminar); (2) SaveInCloud/DNS fora do nosso controle (F3); (3) SEFAZ-PR em homologação exige e-CNPJ de empresa com IE — a Setes não emite NF-e (F4 precisa do cliente); (4) IBS/CBS é fase do motor do ERP, não da API — sem ela a NF-e de regime regular é rejeitada desde 03/08/2026; (5) XSD validation em Node não é nativa (libxmljs2 ou `xmllint` externo) — decidir na F4.

---

## 7. Decisões registradas (D-F — permanente; numeração contínua)

- **D-F1 (Valdo, 2026-10-03) — `fiscal-api` é UM novo projeto de primeiro nível**, com o mesmo tratamento dos projetos existentes: pasta `D:\Gestao2027\fiscal-api\` (repo próprio), espelho `Infra-IA/fiscal-api/` (INDEX + prompts fechados + skills), linha nas tabelas fixas da raiz. Fecha a **Q-F1** na opção (i) do guardião — uma API nomeada pelo CONCEITO, famílias `/v1/nfse` e `/v1/nfe` — e a **Q-F6** na opção (c). Topologia em dois processos por família (opção (ii)) continua disponível como decisão de deploy, sem mudar modelo. Leitura de "seguindo as estruturas do setes-app" registrada no §1.5 (estrutura de PROJETO; o código segue o molde do setes-api). *Por quê*: palavras do Valdo; coerente com o parecer §3.E (um emitente, um A1, uma política da voz).
- **D-F2 (Valdo, 2026-10-03) — todo cliente, inclusive a Setes, consome a API diretamente, com múltiplos aplicativos** (web, Android, iOS, apps de venda de terceiros), cada um acessando o PRÓPRIO ambiente do cliente. Consequências: licenciado = o CLIENTE (fecha a **Q-F17** em (a) — um `tb_licensee` por institution/cliente); nasce a credencial por APLICATIVO (`tb_licensee_app`, §5.8 — nome na Q-F20) com escopos e revogação; token curto por app (revisa a Q-F3, §5.8); CORS por licenciado; OpenAPI de nível público desde a F1. ~~O setes-api passa a ser UM dos apps do licenciado (escopo pleno), não o único consumidor.~~ ⚠️ **Esta frase está EM REVISÃO pela 3ª mensagem do Valdo (§11, Q-F27): ele não quer o setes-api como cliente da fiscal-api — o setes-app (e qualquer front-end) é o cliente.** As demais partes da D-F2 (licenciado = cliente, múltiplos apps, credencial por app, token curto) seguem valendo. *Por quê*: palavras do Valdo; a cerca por cliente é feita pela API (a D12 do sync já fazia por institution).
- **D-F3 (Valdo, 2026-10-03) — requisito não-funcional: a API publicada deve aguentar 1000 clientes emitindo e autorizando notas.** Vira dimensionamento (§5.9, premissas a confirmar na Q-F23), redefine a F3 como "produção ESCALÁVEL" (2+ instâncias, storage de objeto, cofre criptografado, worker, teste de carga como critério de aceite §10.9) e expõe as frentes irmãs S1/S2 (§6) que a fiscal-api não resolve sozinha. *Por quê*: número dado pelo Valdo; sem número, "escalável" não é testável.
- **D-F4 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F27 em (a)) — o setes-api é PASSIVO diante da fiscal-api: NUNCA a chama.** O setes-app (e qualquer front-end) é o cliente direto da fiscal-api. O setes-api (1) expõe os FATOS do documento (`GET /api/<ramo>/:orderId/fiscal-facts` — o `buildDpsBase` serializado + `externalCode` determinístico; os 422 de cadastro incompleto continuam do ERP), (2) emite o token FEDERADO que o app apresenta à fiscal-api, (3) VERIFICA offline o RECIBO assinado pela fiscal-api que o app porta (`POST /api/<ramo>/:orderId/fiscal-receipt`) e só então grava o vínculo e aplica o efeito, (4) recebe webhook de ENTRADA com o mesmo recibo (vozes sem humano). Os três mecanismos (federação, recibo assinado, webhook de entrada) são CONDIÇÃO da decisão — sem eles "o app é o cliente" vira "o ERP acredita no app" (maquete, §11.6). A frase "o setes-api é UM dos apps" da D-F2 MORRE; o resto da D-F2 vale. **A regra canônica "setes-app só fala com setes-api"** (D1 da revisão do sync; `ARQUITETURA_MODULOS.md` do app) passa a ser: *o app fala com as APIs DO PRODUTO por datasources DEDICADOS por API e por módulo; nunca cruza datasources; Sincronizador ↔ setes-sync segue intacto.* Consequências no plano (§11.4): F2 vira **F2a (setes-api passivo)** + **F2b (setes-app cliente — os 17 arquivos Dart do fiscal MUDAM)**; F1 ganha federação, recibos assinados com rotação de chave e CORS como caminho principal; a `trilha-primeiro-cliente.ts` vira um front-end que bate nas duas APIs; critério de aceite §10.12 passa a valer; F0–F3 = **30–43 sessões ≈ 6–8 semanas**. *Por quê*: palavras do Valdo ("não quero que setes-api vire cliente e sim o setes-app vire cliente de fiscal-api como qualquer outro front-end"); ERP sem dependência de saída (fiscal-api fora não derruba faturamento nem baixa); o A1 nunca transita pelo ERP; front-end de terceiro é cidadão de 1ª classe.
- **D-F5 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F28 em (a)) — emissão iniciada pelo SERVIDOR fica fora por construção, registrada como conhecimento negativo.** Sem chamada de saída, a rotina mensal não transmite sozinha e `fiscal_auto_transmit` (D-N9) só existe como "o app transmite logo após faturar" (dentro de uma tela, com humano). Hoje transmitir já é ato explícito do usuário — nada se perde hoje. **Não "consertar" depois** criando chamada de saída do setes-api à fiscal-api por conveniência: se um dia for preciso, nasce como decisão NOVA (a opção (b) — um único processo servidor-a-servidor como `tb_licensee_app` só para rotinas sem humano — fica registrada como caminho, não como autorização). *Por quê*: coerência com a D-F4; o modelo não impede a exceção futura.
- **D-F6 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F21 em (a)) — o PEDIDO dos aplicativos de venda vive no ambiente do cliente (setes-api).** Pedido e faturamento (impostos congelados) nascem no setes-api; a fiscal-api só recebe o documento PRONTO (fatos congelados) e nunca aceita pedido, item ou preço. Com a D-F4, "faturar e autorizar" é saga do FRONT-END: faturar no setes-api → `fiscal-facts` → fiscal-api → recibo de volta ao setes-api. O que a visão "apps de venda de terceiros criando orders" exige do setes-api é a frente irmã **S1** (setes-api como plataforma para apps: credencial de aplicativo por institution, contrato público de pedidos/faturamento), em prompt PRÓPRIO, fora desta fase. Atender quem NÃO usa o ERP ("motor de nota" que recebe pedido) é produto diferente — fora, sem prompt aberto. *Por quê*: a opção (b) recriaria o ERP dentro da API fiscal e contradiz o parecer §3 (conteúdo no ERP; formato e conversa na API).
- **D-F7 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F5 em (a)) — banco próprio `fiscal_api`, único, escopo por linha** (nunca `setes_<algo>` — casaria com o `SCHEMA_RE`). Vive na MESMA instância MySQL dos schemas do produto (topologia D-F9).
- **D-F8 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F13) — `/v1` na URL desde o 1º dia**; sem `Accept-Version`. O `/api` interno do setes-api segue acompanhando o app.
- **D-F9 (Valdo, 2026-10-03, Rodada 2 — topologia de produção na SaveInCloud, texto fiel)**: *"Instância MySQL — com todos os schemas e IP próprio · Instância node setes-api · Instância node setes-sync · Instância node nfe-api ou fiscal-api (prefiro projeto próprio) · Instância node nfse-api ou fiscal-api (prefiro projeto próprio) · Instância Plesk gerenciador de domínio — com o domínio que será o gate de acesso do cliente — com a publicação do build do Flutter apontando para setes-api, nfe-api, nfse-api."* Leitura: banco `fiscal_api` (D-F7) dentro da instância MySQL comum; **duas instâncias Node fiscais (uma por família)**; o build Flutter publicado no Plesk aponta para TRÊS bases de URL (coerente com a D-F4: o app é cliente direto). Consequência imediata: instâncias separadas NÃO compartilham filesystem → o cofre do A1 e o arquivo de XML não podem ficar em disco local de uma instância (as duas famílias usam o MESMO A1 — D-N31) — entra na Q-F25. Se "projeto próprio" significa UM repo com dois processos ou DOIS repos: Q-F31 → decidida na D-F12 (dois projetos).
- **D-F10 (Valdo, 2026-10-03, Rodada 2 — resposta à Q-F15 + Q-F29 (a)) — a API fiscal LÊ o banco do produto para montar o XML e controla o ciclo de comunicação inteiro.** Texto fiel: *"considere que o setes-app envia a informação de um order para autorização, a nfe-api/nfse-api deve coletar tudo o que precisa do banco para gerar o xml e controlar o ciclo de comunicação incluindo envio, autorização ou cancelamento"*. O app manda só a REFERÊNCIA (nota/pedido); a API lê `setes_central` + `setes_<cliente>` na mesma instância MySQL (molde do setes-sync: serviço Node separado operando sobre os bancos do produto). **Porta isolada (Q-F29 (a))**: toda leitura do ERP vive em UM módulo — a *fonte de fatos Gestão 2027* — atrás de uma interface que entrega os fatos do documento (o `DpsBase` de hoje); o NÚCLEO (assinatura, transporte, tentativa, voz, arquivo, PDF) não conhece `tb_*` do ERP — a cerca do §10.1 passa a ser "nenhum `tb_invoice`/`tb_order`/`tb_entity*` FORA da fonte de fatos". Fecha a **Q-F2 em (a)** (tentativa, voz, nDPS, XML, DANFSe na API) e ABSORVE a **Q-F15** (nada de fatos no contrato: emitente, tomador, serviço, regime e pTotTribSN são lidos de `tb_entity*`/`tb_entity_tax`/ramo congelado no momento da transmissão; o `fiscal_api` guarda só habilitação + A1 + documento/tentativa/voz). **Revisa o parecer §3**: "API cega ao ERP" vale para o NÚCLEO, não para o serviço — a API é serviço do PRODUTO Gestão 2027; o teste do terceiro cego passa a valer para o núcleo (outra fonte de fatos — ex.: payload de um ERP de terceiro — é um adaptador novo, nunca reescrita). *Por quê*: palavras do Valdo; extração muito mais barata (o código de hoje já lê o ERP); o setes-sync é precedente de serviço separado sobre os mesmos bancos.
- **D-F11 (Valdo, 2026-10-03, Rodada 2 — Q-F30 (a)) — o EFEITO no ERP é do setes-api, lendo a VOZ direto no banco `fiscal_api`.** O app pede "Cancelar nota" ao setes-api; ele confere a voz C no `fiscal_api` (mesma instância) antes de cancelar local — sem recibo assinado, sem webhook, sem federação. Voz C sem C local = pendência visível e reaplicável (padrão `FISCAL_EFFECT_PENDING`/`countPendingEffects` de hoje). O setes-api continua sem chamar a API fiscal por HTTP (essência da D-F4 mantida); a API fiscal NUNCA escreve no ERP (só lê — candidata a ser garantida por GRANT, Q-F34). ABSORVE a **Q-F4** (a voz chega ao ERP pelo banco), a **Q-F16 em (a)** (nenhuma coluna de estado no ERP; selo e plano de cancelamento leem o estado DERIVADO no `fiscal_api`) e a **Q-F19** (C local SÓ com voz C lida do banco fiscal; efeito idempotente na transação do ERP; recusa = pendência). **SUPERA os mecanismos da D-F4** (`fiscal-facts`, recibo assinado JWS, webhook de entrada, token federado): a condição que eles protegiam — "o ERP nunca acredita no app" — é satisfeita pelo banco compartilhado (o app nunca porta estado; o ERP lê a verdade). Critério §10.12 reescrito em §10. *Por quê*: decisão do Valdo; mesma instância MySQL (D-F9) torna a leitura direta possível e transacional.
- **D-F12 (Valdo, 2026-10-03, Rodada 2 — Q-F31 (b)) — DOIS projetos, `nfse-api` e `nfe-api`, com NÚCLEO COMUM; o mesmo banco `fiscal_api` e o mesmo cofre.** REVISA a **D-F1** (que fixava UM projeto `fiscal-api`): "fiscal" continua sendo o nome do CONCEITO, do banco (`fiscal_api`, D-F7) e do núcleo; os deployáveis são dois, um por família, com escala independente (D-F9). O núcleo comum (assinatura XMLDSig, transporte mTLS, cofre, storage, máquina de tentativa × voz, habilitação, PDF, porta da fonte de fatos) é UM só — o mesmo A1 serve as duas famílias (D-N31) e há UMA habilitação por modelo por emitente (D-E1); duplicar o núcleo seria a maquete do §3.E. Onde o núcleo vive e como é consumido: Q-F33. A pasta `D:\Gestao2027\fiscal-api\` criada na D-F1 (sem código, git local sem remoto) é reorganizada conforme a Q-F33.
- **D-F13 (Valdo, 2026-10-03, Rodada 2 — Q-F32 (a)) — mesmo login do produto, assinatura ASSIMÉTRICA.** O setes-api passa a assinar o JWT com par de chaves (hoje HS256 com `JWT_SECRET`, `auth.service.ts:63`); as APIs fiscais validam só com a chave PÚBLICA (nunca conseguem forjar token) e conferem TRANSMITIR/CANCELAR no schema do cliente pelo mesmo resolver do setes-api. ABSORVE a **Q-F3** (credencial de aplicativo sem humano — server-to-server, app de terceiro — é da frente S1, no setes-api, que emite o token), a **Q-F11** (a REGRA de privilégio continua do ERP; a porta fiscal a aplica lendo o ERP) e a **Q-F22** (o app usa o mesmo JWT curto; nenhum secret no dispositivo). A D-F2 segue valendo no "todo cliente, múltiplos apps" — mas a credencial por aplicativo (`tb_licensee_app`) sai da API fiscal e vai para a S1. O setes-sync (X-Api-Key) não muda.
- **D-F14 (Valdo, 2026-10-03, Rodada 2 — Q-F20 revista (a)) — NÃO existe `tb_licensee`: licenciado = institution do produto.** O JWT já traz `institutionId`; a licença fiscal = contrato de interface do produto (`tb_institution_has_interface` das telas fiscais), lido no schema do cliente pela porta fiscal. O emitente no `fiscal_api` é chaveado pela institution (+ CNPJ como atributo verificado contra o A1 — D-N29b), com habilitação por MODELO (D-E1); limites por config. REVISA a D-F2 (o "licenciado = cliente" fica, sem tabela própria) e os nomes do §3.F (`tb_licensee`/`tb_licensee_app` morrem nesta fase). *Por quê*: um fato a menos em dois lugares; coerente com D-F10/D-F13 (serviço do produto, mesmo login).
- **D-F15 (Valdo, 2026-10-03, Rodada 2 — Q-F34 (a)) — contrato de leitura por VIEWS publicadas + GRANT mínimo.** A API fiscal tem usuário MySQL com **só SELECT** em `setes_central`/`setes_*` (a D-F11 "a API fiscal nunca escreve no ERP" vira garantia de BANCO, não de disciplina) e controle total só no `fiscal_api`; o setes-api tem usuário com SELECT **só nas VIEWs publicadas** do `fiscal_api` (estado derivado por nota/vida/modelo, pendência de efeito). Tabela interna de um lado muda sem quebrar o outro; a view é o contrato e entra no versionamento como o OpenAPI. A **serialização transmitir × cancelar local** (hoje o mesmo `FOR UPDATE` na nota) é desenho da F0 — candidata: trava nomeada da instância (`GET_LOCK('fiscal:<schema>:<nota>', n)`), que não exige privilégio de escrita na tabela do outro lado. *Por quê*: decisão do Valdo; fronteira testável por GRANT.
- **D-F16 (Valdo, 2026-10-03, Rodada 2 — Q-F25 revista (a)) — A1 CRIPTOGRAFADO no banco `fiscal_api` desde a F1; XML atrás da interface de storage.** O cofre do A1 deixa de ser arquivo (`SECRETS_PATH`) e vira linha cifrada no `fiscal_api` (chave-mestra em variável de ambiente; KMS depois, atrás da mesma interface) — as duas instâncias fiscais (D-F9) leem o MESMO A1 sem disco compartilhado (D-N31 por construção). XML/DANFSe atrás de `storage`: filesystem no dev; backend de produção (objeto S3-compatível ou volume compartilhado) decidido na F3 com o que a SaveInCloud oferecer. Senha do PKCS#12 continua sem persistir (D-N5). *Por quê*: instâncias separadas não compartilham filesystem; o A1 é pequeno e precisa estar nas duas famílias; o XML é volumoso (§5.9).
- **D-F17 (Valdo, 2026-10-03, Rodada 2 — Q-F33 (b)) — `fiscal-api` é a BIBLIOTECA do núcleo comum (repo próprio, não roda sozinha); `nfse-api/` e `nfe-api/` são pastas/repos próprios que a consomem** — dependência `file:../fiscal-api` no dev, tag git no deploy. Três pastas na raiz (`fiscal-api` · `nfse-api` · `nfe-api`). A pasta `fiscal-api/` criada na D-F1 MUDA DE PAPEL (de serviço para biblioteca): sem porta, sem `server.ts`; o que roda (gateway, rotas `/v1`, health, OpenAPI servido) vive nos dois projetos de família, que compõem o núcleo. Fecha a Q-F31/D-F12 quanto ao "onde" e ABSORVE a **Q-F26** (a estrutura de projeto é esta; código no molde do setes-api; administração do emitente é tela do setes-app consumindo a API da família). *Por quê*: palavras do Valdo ("prefiro projeto próprio" para cada instância; "núcleo em fiscal-api"); custo aceito: mudança no núcleo = tag nova + atualização nos dois projetos.
- **D-F18 (Valdo, 2026-10-03, Rodada 2 — Q-F7 (a)) — corte dos dados da Setes por MIGRAÇÃO ÚNICA, homologação H antes de produção P, sem dual-write.** Script único copia emissor/habilitação, transmissões, vozes, XMLs e o A1 (agora cifrado no banco — D-F16) do setes-api para o `fiscal_api`; reconciliação por `dps_id` e trilha P8 são a prova; o DANFSe da nº 704 tem que renderizar igual.
- **D-F19 (Valdo, 2026-10-03, Rodada 2 — Q-F10 (a)) — extrair no DEV, depois a Onda 4.** F1 (núcleo `fiscal-api` + `nfse-api`) → F2 (setes-api passivo + setes-app cliente) no dev → **F3 = Onda 4 do produto inteiro já na topologia final da D-F9** (MySQL com todos os schemas, setes-api, setes-sync, nfse-api, Plesk com o build Flutter). A Onda 4 do `prompt_primeiro_cliente_setes.md` passa a herdar essa topologia. *Por quê*: não publicar uma topologia que muda logo depois.
- **D-F20 (Valdo, 2026-10-03, Rodada 2 — Q-F8 (a)) — `nfe-api` nasce AGORA como pasta + `CLAUDE.md` + espelho `Infra-IA/nfe-api/`, SEM código.** D-E20 mantida para o QUANDO: levantamento oficial da SEFAZ (`integracoes/nfe-sefaz/`) e código vêm com o 1º cliente de mercadoria (e depois do IBS/CBS — Q-F14). O núcleo `fiscal-api` já nasce paramétrico por família (estratégia por família de autoridade — D-E6).
- **D-F21 (Valdo, 2026-10-03, Rodada 2 — Q-F18 (a)) — série e número do 55/65 são cunhados pelo ERP no faturamento** (como hoje); a fonte de fatos os lê. A API guarda série/contador SÓ do DPS (modelo SE). Diverge da D-E2 (registrado no parecer §3.I-2): `tb_establishment_issuer.serie` do 55 fica no ERP; a linha SE migra.
- **D-F22 (Valdo, 2026-10-03, Rodada 2 — Q-F14 (a)) — IBS/CBS é FASE PRÓPRIA, com marco duro 01/01/2027** (Simples Nacional, inclusive a NFS-e da Setes). O MOTOR (cálculo + congelamento no setes-api) pode começar em PARALELO à extração; o BUILDER do grupo IBS/CBS do DPS entra na `nfse-api` depois da F1. Pré-requisito também da F4 (NF-e).
- **D-F23 (Valdo, 2026-10-03, Rodada 2 — Q-F23 (a)) — o §5.9 é PREMISSA de projeto até a F3**; o teste de carga da F3 (fisco falso, 2 instâncias) fixa o número real.
- **D-F24 (Valdo, 2026-10-03, Rodada 2 — Q-F24 (a)) — S2 (setes-api em escala 1000) começa por DIAGNÓSTICO**: fase própria mede boot, deploy e pool com 1000 schemas sintéticos — incluindo a leitura dos schemas pelas APIs fiscais (D-F10) — antes de qualquer correção.
- **D-F25 (Valdo, 2026-10-03, Rodada 2 — Q-F9 (a)) — legado Gestao2016 como consumidor = candidato FORA desta fase.** Exigiria uma 2ª fonte de fatos (payload) e decisão própria sobre a regra dos dois grupos.
- **D-F26 (Valdo, 2026-10-03, Rodada 2 — Q-F12) — cobrança/metering fora desta fase**; "documentos por institution/mês" é consulta DERIVADA das tentativas/vozes, nada a modelar.

- **D-F27 (Valdo, 2026-10-03, Rodada 3 — correção de premissa na resposta à Q-F35) — as APIs fiscais PODEM ESCREVER no ERP.** Texto fiel: *"na verdade a nfse-api e nfe-api podem escrever no ERP (schemas central e cliente)"*. REVISA a **D-F15** na parte "usuário MySQL só com SELECT em `setes_central`/`setes_*`" (a parte das VIEWs publicadas para o setes-api segue valendo). Consequências: (1) a garantia "a API fiscal nunca escreve no ERP" deixa de ser de BANCO — o que a API escreve no ERP passa a ser lista explícita com cerca por teste (escopo na Q-F44); (2) a serialização transmitir × cancelar local VOLTA a ser o `FOR UPDATE` na linha da nota (`tb_invoice`), provado pelos gates da Onda 3 — a trava nomeada `GET_LOCK` do §12.4 deixa de ser necessária (os três riscos que o guardião apontou nela, §13.1-5 (a)/(b), morrem com ela); a transação da nfse-api cruza `setes_<cliente>` e `fiscal_api` na MESMA conexão (mesma instância — D-F9); (3) a Q-F35 (onde mora o nDPS) é reaberta com a premissa corrigida.
- **D-F28 (Valdo, 2026-10-03, Rodada 3 — Q-F37 e Q-F38) — o cancelamento é uma OPERAÇÃO EM LINHA conduzida pelo app; nada de vínculo gravado nem job.** Texto fiel: *"considere uma operação em linha: app solicita o cancelamento da nfe/nfse via api própria (nfe/nfse); o retorno deve retornar para o App com a mensagem de ok ou não ok; conforme a mensagem o app avança com o envio do cancelamento para a setes-api"* e, na Q-F38, *"considere a resposta da pergunta anterior"*. Leitura: (1) `POST /v1/nfse/invoices/{id}/cancel` responde ok (voz C gravada) ou não ok (recusa/indisponível — o app NÃO avança); (2) com ok, o app envia o cancelamento ao setes-api (`POST /api/billing/cancel`), que confere a voz C e aplica o C local (D-F11); (3) **nenhuma tabela/coluna de vínculo do efeito** — pendência DERIVADA (voz C na vida vigente × nota ainda não-C), motivo recalculado pelo plano na hora (= Q-F37 (c)); (4) **nenhum job/worker de efeito** (= Q-F38 sem (a)): a voz C que chega sem humano (cancelada no portal, descoberta por consulta) fica como pendência VISÍVEL na lista/detalhe e é aplicada quando o app, num contato seguinte, recebe a voz e envia o cancelamento ao setes-api. **Conhecimento negativo**: não criar job de efeito no setes-api nem efeito aplicado pela API fiscal sem decisão nova.
- **D-F29 (Valdo, 2026-10-03, Rodada 3 — Q-F39 (a)) — pré-condições do cancelamento: o app CONSULTA o plano no setes-api antes de pedir o cancelamento à API fiscal (consultivo — mudou no meio = pendência, como a D-F11 aceita), e o setes-api EXIGE prova LIDA NO BANCO da reconfirmação**: para tentativa vigente com F por consulta em produção (Q-ADV1b), só cancela localmente se a view mostrar conferência no fisco (`last_queried_at`) POSTERIOR ao F — nunca a palavra do app. A nfse-api NÃO reimplementa o plano (bifurcaria a política).

- **D-F30 (Valdo, 2026-10-04, Rodada 3 — Q-F35 reaberta (b)) — o DPS de cada VIDA da nota mora no `fiscal_api`: peça `tb_invoice_service_dps`.** Uma linha por vida (nota × terminal × evento E que abriu a vida): série + nDPS + Id do DPS gravados UMA vez (write-once), UNIQUE `(tb_institution_id, dps_id)` de volta; o contador continua no emissor SE (D-N18). Tudo o que é da DECLARAÇÃO fica junto no `fiscal_api`; o ramo do ERP fica só com fatos comerciais — `tb_invoice_service.dps_number` deixa de ser lido e escrito (coluna APOSENTADA, sem DROP até decisão — "tabela sem consumidor não é morta"). Fecha por construção as duas armadilhas do guardião (§13.1-2): vida nova = linha nova (nunca herda o Id de vida cancelada) e a série fica congelada na vida (trocar a série no emissor não muda o Id de quem já tem DPS). A chave do fisco continua na TENTATIVA (D-N26 e R3-1 intactas); a opção (c) (chave também no DPS) fica registrada para rodada futura.
- **D-F31 (Valdo, 2026-10-04, Rodada 3 — Q-F44 (a)) — o que as APIs fiscais escrevem no ERP é LISTA FECHADA com cerca por teste.** Com a D-F30, a lista hoje é: **nenhuma escrita de dado** — só a trava de linha (`SELECT … FOR UPDATE` na `tb_invoice` da nota) que serializa transmitir × cancelar local (D-F27). O C local continua do setes-api (D-F11/D-F28). Escrever qualquer coisa nova no ERP a partir de uma API fiscal = decisão nova (entra na lista + no teste). Usuário MySQL das APIs fiscais: escrita permitida pelo GRANT (D-F27), disciplina garantida pelo teste.
- **D-F32 (Valdo, 2026-10-04, Rodada 3 — Q-F40 (b)) — POLÍTICAS do ERP que as APIs fiscais precisam são publicadas pelo setes-api como VIEWs no schema do cliente**, e o próprio setes-api passa a ler delas (uma verdade só): a **interface do RAMO por pedido** (hoje `resolveOrderInterface` — ciclo da OS × âncora da devolução × venda, D-A31) e a **VIDA vigente da nota** (último evento E/C — D-N27). "Admin passa" (D32), fuso por config e a matriz do Anexo I (Q-N36) ficam em código, com teste de contrato entre os dois lados. As views nascem por migration do setes-api (todas as institutions).
- **D-F33 (Valdo, 2026-10-04, Rodada 3 — Q-F41 (c)) — a biblioteca `fiscal-api` exporta o CONTRATO DE LEITURA da voz** (tipos das views do `fiscal_api`, regra da vigente `currentOf` — D-N26, `fiscalStateOf`, kinds, vida) e o **setes-api também depende dela** (dependência de código, sem HTTP — continua passivo, D-F4). As views ficam no molde do `TX_SELECT` (fundíveis; nada de `ROW_NUMBER` antes de EXPLAIN — frente S2).
- **D-F34 (Valdo, 2026-10-04, Rodada 3 — Q-F42 (b)) — nomes no `fiscal_api`: `tb_establishment_certificate`** (o A1 do estabelecimento: certificado público + chave privada cifrada + validade; o `cnpj` é o do CN, fato do certificado) e **`tb_establishment_issuer`** (habilitação por modelo — mesmo nome de hoje: "muda de casa, não de conceito"). `tb_emitter`/`tb_issuer` do §12.3 morrem; "emitente" continua sendo o `prest` do DPS, lido do ERP.
- **D-F35 (Valdo, 2026-10-04, Rodada 3 — Q-F43 (b)) — DDL por dono**: o núcleo `fiscal-api` cria `tb_establishment_certificate`, `tb_establishment_issuer` e o EXECUTOR de migrations (trava nomeada + namespace por projeto em `_migrations`); cada família cria as suas tabelas e views (`nfse-api`: DPS, transmissão, voz + views para o setes-api). A `nfe-api` AGREGA sem tocar o núcleo (D-F20).

**Rodada 3 ZERADA em 2026-10-04** (Q-F35, Q-F37…Q-F44 decididas; Q-F36 sem objeto). Modelo final da F0 no **§14**.

**Rodada 4 (aberta pelos gates da F1 — §15.4) — DECIDIDA em 2026-10-04 pelo Valdo: "siga as recomendações".** Execução no §16.
- **D-F36 (= Q-F45 (a)) — smoke no ADN de HOMOLOGAÇÃO pela nfse-api ANTES da virada**, numa habilitação de homologação com
  SÉRIE PRÓPRIA (900) e numa nota de TESTE, sem tocar a numeração de produção do setes-api; tudo o que o smoke grava no
  `fiscal_api` (DPS da vida, tentativas, vozes, contador, habilitação) é DESFEITO no fim e a cópia volta a ser a da origem
  (`migrate:setes`). Falar com o fisco continua exigindo o **"vai"** do Valdo na hora (o A1 vence em 08/10/2026).
- **D-F37 (= Q-F46 (b)) — a LICENÇA vale para TODOS**: admin passa só o PRIVILÉGIO (TRANSMITIR/CANCELAR), nunca a interface do
  ramo não contratada (D-F14). Antes de ligar a regra, o DADO é acertado: a institution 1 contrata `service-orders` (emitia
  344 OS sem a interface no contrato). O setes-api passa a fazer o mesmo na F2a (entra na lista da F2a).
- **D-F38 (= Q-F47 (a)) — teto de idade das AUTORIZADAS no rodízio = prazo de cancelamento do município (PAM) + 30 dias de
  margem** (contado do `dh_proc`; sem o PAM, 60 dias — o de Curitiba). Depois disso o fisco não aceita mais cancelamento pelo
  emitente e a voz não muda: a nota sai do rodízio (a consulta manual continua possível). Vivas (em voo/S/K) não têm teto.
- **D-F39 (= Q-F48 (a)) — a CERCA DA VIRADA é FATO no `fiscal_api`**, na habilitação: quem detém a emissão do modelo
  (o ERP ou o serviço), trocado pelo `migrate:setes` na re-sincronia FINAL (virada), na MESMA transação, e lido por todas as
  instâncias. A variável `FISCAL_LEGACY_INSTITUTIONS` sai. Modelagem pelo guardião + `revisar-ddl` (§16).
- **D-F40 (= Q-F49 (a)) — custo das leituras que crescem com o histórico é CRITÉRIO DE ACEITE**: teto p95 < 300 ms por
  chamada com 200 mil notas na página de pendentes e nas candidatas do rodízio, medido no teste de carga da F3 / diagnóstico
  da S2 (D-F23/D-F24), com `EXPLAIN` na cerca (script `nfse-api/scripts/explain-leituras.ts`).

**Rodada 6 (aberta pela retomada de 2026-10-04 — gate socrático do delta das 4 falhas + conferência "o que foi movido saiu
do setes-api?") — DECIDIDA em 2026-10-04 pelo Valdo: "siga as recomendações".** Execução no §17. Na mesma sessão o Valdo decidiu
Q-F50 ("manter" — refinada pelo guardião) e Q-F56 ("sim") → D-F44/D-F45; Q-F51…Q-F53 seguem abertas.
- **D-F41 (= Q-F54) — o comando do ALUGUEL do rodízio tem ESPERA CURTA**: quem não obtém a linha da habilitação em poucos
  segundos recebe 409 `RESOURCE_BUSY` (molde da D-A23 do setes-api) em vez de esperar o lock wait padrão do InnoDB (50 s) —
  alinha o comando ao texto "quem não obtém PULA, não espera" (PADROES §11). Deadlock continua reexecutando 1× (`leaseCommand`).
- **D-F42 (= Q-F55) — o `migrate:setes` copia e vira SÓ a habilitação SE**: as linhas 55/65 continuam no ERP (D-F21 — série e
  número do 55/65 são do ERP; D-F20 — nfe-api sem código até o 1º cliente de mercadoria). Modelagem pelo guardião (§17).
- **D-F43 (= pergunta (a) da conferência) — durante o dual-run, a correção que os gates fizeram na nfse-api e que vale também
  para o caminho do setes-api (ainda o de PRODUÇÃO) é PORTADA para o setes-api**: o setes-api é quem emite até a virada; nada
  foi removido dele (a remoção das 14 rotas e 6 peças é da F2a — §15.5-3). 1º porte: caracteres de controle no texto livre do
  DPS/evento. Assunção A14 (contestável): o inventário dos demais achados da F1 que valem para o setes-api é pendência própria.
- **D-F44 (= Q-F50 (a), refinada pelo guardião — Valdo: "manter") — o ATO da virada APOSENTA a habilitação SE do ERP**
  (`deleted='S'`) na MESMA transação que vira o `fiscal_api` — escrita UMA vez pelo SCRIPT (`nfse-api/scripts/cutover-erp.ts`,
  nunca pelo serviço), item novo da lista fechada da D-F31 (cerca por teste em `src/` e `scripts/`); o setes-api fica fechado por
  construção (lê e cunha com `deleted='N'` → 409 FISCAL_ISSUER_MISSING sem mudar código). CONFERÊNCIA embutida: a linha SE do ERP
  também é a SÉRIE DA NOTA — série efetiva ≠ '1' = falha alta antes de qualquer escrita. Credencial do ato = a do dono do ERP.
  Para a F2a: a tabela do ERP passa a significar só a série da nota; ambiente da SE e `dps_last_number` ficam sem consumidor e
  são aposentados SEM DROP. A linha 55/65 do ERP não é tocada.
- **D-F45 (= Q-F56 (a) — Valdo: "sim") — o domínio do `model` da habilitação é FATO DO BANCO**: `CHECK (model IN ('SE','55','65'))`
  na migration 004 do núcleo (1º CHECK da casa) + o boot confere que o motor APLICA CHECK (`assertIssuerModelDomainEnforced` —
  falha alto em MySQL < 8.0.16 ou CHECK NOT ENFORCED). Modelo novo = migration do núcleo que estende o domínio.
- **D-F46 (= Q-F52 (b) — Valdo, 2026-10-04: "bloqueio total, o cliente vai precisar arranjar outra maneira") — ramo que
  deixa de ser contratado = BLOQUEIO TOTAL na API fiscal, inclusive do que já foi emitido**: sem a interface do ramo em
  `tb_institution_has_interface`, transmitir, consultar, cancelar no fisco e ler XML/DANFSe devolvem 403
  `INTERFACE_NOT_ALLOWED` — para todos, admin incluído (fecha a D-F37 pelo lado do "depois"). A obrigação fiscal já assumida
  (cancelar no prazo do município, guardar o XML, reconciliar nota em voo/K) é do cliente fora do produto (portal do ADN,
  contador) — o contrato comercial manda. *Consequência para o código (coerência no sentido inverso)*: a passada do rodízio
  (`POST /v1/nfse/refresh`) hoje passa na guarda com UM ramo contratado e consulta as candidatas de TODOS os ramos — passa a
  filtrar as candidatas pelos ramos contratados em que quem pede tem o privilégio (ou é admin), no SQL antes do LIMIT (molde
  do `listPendingServiceInvoices`). *Por quê*: licença é o que se vendeu; o produto não presta serviço fiscal a ramo não
  contratado. ~~Risco aceito e registrado: nota em voo no momento do corte fica sem reconciliação pelo produto.~~ → REFINADA pela
  **D-F47** (a passada fecha as vivas do ramo cortado).
- **D-F47 (= Q-F57 (b) — Valdo, 2026-10-04) — a PASSADA do rodízio continua fechando a tentativa JÁ VIVA (sem voz/S/K) de
  ramo que saiu do contrato** (refina a D-F46): fechar o que estava em curso não é serviço novo. A autorizada (A/N) de ramo
  cortado NÃO volta ao rodízio; consultar, cancelar e ler a nota continuam 403 para todos. Admin com NADA contratado pode rodar
  a passada só sobre essas vivas (usuário comum sem ramo com privilégio: 403). *Por quê*: sem isso a nota órfã ficava viva para
  sempre e `countLiveTransmissions` travava o emitente inteiro (trocar ambiente, excluir habilitação/A1) — achado MEDIUM-1 do
  gate socrático (§18).
- **D-F48 (= Q-F58 (a) — Valdo, 2026-10-04: "recomendação") — a re-sincronia (`migrate:setes` sem `--cutover`) usa UMA
  TRANSAÇÃO POR INSTITUTION** (revisa o "tudo ou nada" global da D-F18 só na re-sincronia; a virada continua uma transação
  só). A institution que falha volta sozinha (nada dela gravado), as demais seguem, e o script sai ≠ 0 listando as que
  falharam. *Por quê*: o tudo-ou-nada global não protegia invariante entre institutions e segurava FOR UPDATE nas
  habilitações VIRADAS de todas até o commit final (§18, MEDIUM-2).
- **D-F49 (Valdo, 2026-10-04: "vamos manter") — a D-F7 (banco `fiscal_api` próprio) está CONFIRMADA, com o motivo VERDADEIRO
  registrado: NÃO é desempenho.** Na mesma instância MySQL (D-F9) um banco à parte não muda memória, disco nem CPU, e a consulta
  que cruza `fiscal_api` × `setes_*` custa o mesmo; nem prepara servidor próprio no futuro (as leituras da nfse-api JUNTAM os
  dois bancos — só funcionam na mesma instância). A ESCALA vem das instâncias Node separadas (D-F9/D-F12), independente de onde
  as tabelas vivem. O que o banco próprio dá: (1) as tabelas fiscais existem UMA vez (escopo por linha) — coluna nova = 1 ALTER,
  não 1 por schema de cliente; (2) segurança por construção — o MySQL não concede privilégio por TABELA num padrão `setes\_%`,
  então tabelas fiscais dentro dos schemas exigiriam escrita da API fiscal no ERP inteiro de todos os clientes (desfaz a D-F15)
  e poriam a chave privada do A1 ao alcance de tudo que mexe no ERP; (3) já feito e provado — voltar custaria semanas antes do
  marco do IBS/CBS (01/01/2027). Critério do Valdo para quando a dúvida voltar: "estratégia por estratégia, prefiro junto" —
  separar só com ganho concreto, como estes. O custo próprio (cópia/réplica/virada) é de TRANSIÇÃO e morre depois da virada.

**§8 ZERADA em 2026-10-03 (Rodada 2).** O plano consolidado que substitui §4–§6/§10/§11 onde houver conflito está no §12.

---

## 8. ⚠️ Questões pendentes — Rodada 1 (recomendação entre parênteses)

- ~~**Q-F1 Uma API, duas ou duas com núcleo comum?**~~ → **DECIDIDA = D-F1** (opção (i): `fiscal-api` única com famílias; (ii) fica como topologia de deploy).
- ~~**Q-F2 Transmissão e voz moram no serviço ou no ERP?**~~ → **DECIDIDA = D-F10** ((a), na API). Texto original: (a) **no serviço** (tentativa, voz, nDPS, XML, DANFSe); o ERP guarda só o VÍNCULO nota × documento (estado: Q-F16) · (b) no ERP; o serviço é só transporte (assina + mTLS + parse). *(Rec.: (a), confirmada pelo guardião §3.B — em (b) cada consumidor reimplementa a parte que os gates provaram ser a difícil: K em voo, reconciliação, ambíguo nunca fecha, 1 viva por documento; e o par PEM teria que viajar por chamada.)*
- ~~**Q-F3 Autenticação dos aplicativos**~~ → **ABSORVIDA pela D-F13** (mesmo login do produto; credencial de app sem humano = S1). Texto original: (revisada pela D-F2 — múltiplos apps por cliente desde o 1º dia): (a) API key fixa por app no header (`X-Api-Key`, precedente D12) · (b) **credencial por app (`app_id` + `secret` só em hash) trocada por TOKEN CURTO (`POST /v1/auth/token`, JWT ~1 h) — client-credentials simplificado, §5.8** · (c) OAuth2 completo (authorization server). *(Rec.: (b) — a chave nunca viaja por requisição, revogação é imediata na próxima troca, serve de base ao token exchange para apps móveis (Q-F22); (a) é frágil com N apps por cliente; (c) é peso sem consumidor que o exija.)*
- ~~**Q-F4 Como a voz nova chega ao ERP**~~ → **ABSORVIDA pela D-F11** (o setes-api lê a voz no `fiscal_api`). Texto original:: (a) **resposta síncrona do próprio pedido + `refresh` sob demanda/rotina** (como hoje) · (b) + callback HTTP assinado na URL da conta como GATILHO de consulta (regra do webhook do Inter). *(Rec.: (a) na F1/F2; (b) como opção da conta na F3, quando houver URL pública.)*
- ~~**Q-F5 Banco do serviço**~~ → **DECIDIDA = D-F7**. Texto original: (a) **`fiscal_api` único, escopo por linha `tb_licensee_id`** · (b) schema por cliente como o ERP. *(Rec.: (a) — o serviço não tem "cliente do ERP"; tem licenciado e emitente. O nome NÃO pode ser `setes_<algo>`: casaria com o `SCHEMA_RE` dos schemas de cliente — §3.I-5.)*
- ~~**Q-F6 Pastas e repos**~~ → **DECIDIDA = D-F1** (pasta `fiscal-api/` + espelho `Infra-IA/fiscal-api/`, criados em 2026-10-03; repo GitHub `valdosouza/gestao-2027-fiscal-api` a criar pelo Valdo).
- ~~**Q-F7 Corte dos dados da Setes**~~ → **DECIDIDA = D-F18**. Texto original: (a) **migração única (script) + corte com H antes de P**, sem dual-write · (b) dual-run (ERP grava nos dois) por N dias. *(Rec.: (a) — dual-write em transmissão fiscal cria duas verdades; a trilha P8 e a reconciliação por `dps_id` são a prova.)*
- ~~**Q-F8 D-E20 mantida?**~~ → **DECIDIDA = D-F20** (nfe-api pasta + espelho agora, sem código). Texto original: A NF-e em si espera o 1º cliente de mercadoria. O que antecipar da família nfe: (a) **só o contrato OpenAPI já paramétrico por família + levantamento oficial da SEFAZ (`integracoes/nfe-sefaz/`) + a estratégia por família prevista no código da F1** · (b) executar F4 agora porque a API é produto. *(Rec.: (a) — sem cliente não há homologação real nem e-CNPJ com IE; IBS/CBS (Q-F14) precede qualquer NF-e. Em qualquer caso, pelo §3.I-6 a NF-e **nasce na API, nunca no ERP** — a D-E20 segue valendo para o QUANDO, não para o ONDE.)*
- ~~**Q-F9 Legado Gestao2016 como 2º consumidor da `nfse-api`?**~~ → **DECIDIDA = D-F25**. Texto original: Curitiba exige NFS-e nacional desde 01/01/2026 — o webservice municipal do legado morreu. (a) registrar como candidato (fora desta fase) · (b) planejar `TNfseSendWeb` no sincronizador · (c) o legado chama a `nfse-api` direto. *(Rec.: (a) — a regra dos dois grupos (sincronizador ↔ setes-sync) precisaria de decisão própria antes de nascer um 3º grupo.)*
- ~~**Q-F10 Ordem**~~ → **DECIDIDA = D-F19** (extrair no dev; F3 = Onda 4 na topologia D-F9). Texto original: (a) **F1 → F2 no dev → F3 publica a `nfse-api` como piloto da Onda 4** · (b) Onda 4 do ERP inteiro primeiro, extrair depois. *(Rec.: (a) — a extração não depende de produção, e publicar primeiro o serviço pequeno ensina a SaveInCloud com menos superfície.)*
- ~~**Q-F11 Autorização de AÇÃO**~~ → **ABSORVIDA pela D-F13** (regra do ERP, aplicada pela porta fiscal lendo o schema do cliente). Texto original: (TRANSMITIR/CANCELAR por usuário) fica no ERP; o serviço só autentica a CONTA e registra o `requestedBy` opaco que o consumidor mandar. *(Rec.: sim — privilégio é do usuário do ERP; o serviço não tem usuário.)*
- ~~**Q-F12 Produto/cobrança do serviço**~~ → **DECIDIDA = D-F26**. Texto original: (metering por documento, planos): fora desta fase; só garantir que "documentos emitidos por conta/mês" seja consulta derivada das tentativas. *(Rec.: fora; nada a modelar.)*
- ~~**Q-F13 Versionamento**~~ → **DECIDIDA = D-F8**. Texto original: `/v1/` desde o 1º dia (contrato externo), `Accept-Version` não. *(Rec.: sim — diferente do `/api` interno, que acompanha o app.)*
- ~~**Q-F14 IBS/CBS**~~ → **DECIDIDA = D-F22**. Texto original: é pré-requisito da F4 (NF-e regime regular desde 03/08/2026; Simples 01/01/2027 — inclusive a NFS-e da Setes). Vive no motor do ERP (`tb_order_item_ibscbs` + regra) e no builder dos dois documentos. (a) **fase própria "IBS/CBS" antes da F4 e antes de 01/01/2027 para a NFS-e** · (b) dentro da F4. *(Rec.: (a) — toca os dois documentos e o motor; não é da API fiscal.)*
- ~~**Q-F15 O que do emitente é CADASTRO no serviço × o que viaja por documento**~~ → **ABSORVIDA pela D-F10** (nada viaja: a API lê do ERP). Texto original:: (a) **cadastro: CNPJ, nome, cMun IBGE do emitente, IM, fuso IANA, ambiente/série por modelo; por documento: regTrib (opSimpNac/regApTribSN/regEspTrib), pTotTribSN, tomador, serviço, valores** · (b) tudo no cadastro do emitente. *(Rec.: (a) — regime e alíquota efetiva mudam no tempo e são fatos da competência; o XML congela; o ERP já os valida (422 `FISCAL_EMITTER_INCOMPLETE`); a API aplica a matriz do Anexo I (`emitterDpsFacts`) e devolve o mesmo `fields[]`.)*

**Acrescentadas pelo parecer do guardião (§3.I):**

- ~~**Q-F16 Estado fiscal no ERP**~~ → **DECIDIDA = D-F11** ((a): nenhuma coluna de estado; o ERP lê o estado derivado no `fiscal_api`). Texto original:: (a) **sem espelho — lista e detalhe por lote de referências (`GET /documents?externalCode=…`); API fora = selo "indisponível" e ações fiscais 503** · (b) espelho de EXIBIÇÃO escrito só pela notificação, nunca decisório. *(Rec.: (a) — zero coluna de estado; "status sincronizado por cron" é maquete. (b) só se a latência da lista de OS doer de verdade — medir antes.)*
- ~~**Q-F17 Granularidade do licenciado**~~ → **DECIDIDA = D-F2** (um licenciado por CLIENTE; o setes-api é um `tb_licensee_app` de escopo pleno de cada licenciado, provisionado no onboarding da institution).
- ~~**Q-F18 D-E2 diverge — quem guarda a série**~~ → **DECIDIDA = D-F21**. Texto original: a série do 55/65 é fato de quem NUMERA (ERP); a do DPS, de quem DECLARA (API). (a) **API guarda série/contador só do SE; 55/65 numeram no ERP e série + número viajam no payload** · (b) API guarda as séries de todos e o ERP a lê antes de cunhar. *(Rec.: (a) — em (b) o ERP não numera com a API fora = maquete; `tb_establishment_issuer.serie` do 55 fica no ERP, a linha SE migra.)*
- ~~**Q-F19 D-N7 relaxa**~~ → **DECIDIDA = D-F11** (C local só com voz C lida do banco fiscal). Texto original:: "voz C → C local na MESMA transação" é impossível entre serviços. Confirmar o invariante como **"C local SÓ da voz; efeito na transação do ERP, idempotente; recusa ou falha = pendência visível e reaplicável; ack à API"**. *(Rec.: confirmar — já é o que vale para o C vindo da consulta.)*
- ~~**Q-F20 Palavras**~~ → **DECIDIDA = D-F14** (sem `tb_licensee`: licenciado = institution; credencial de app vai para a S1). Texto original: licenciado = `tb_licensee` × `tb_client`; credencial por aplicativo (D-F2) = `tb_licensee_app` × `tb_app` × `tb_app_credential`. *(Rec. do guardião: `tb_licensee` — "licença" já é o sentido de `tb_institution.active`; `client` colide com cliente/tenant/customer; `consumer` com consumidor final. Para o app: `tb_licensee_app` — diz de quem é e o que é; "app" está livre na tabela de ocupadas. Palavra é decisão do Valdo — lição "contrato".)*

**Acrescentadas pela Rodada 1 (2ª mensagem do Valdo, §1.5):**

- ~~**Q-F21 Onde vive o PEDIDO dos aplicativos de venda?**~~ → **DECIDIDA = D-F6** (no setes-api; S1 em prompt próprio). Texto original: "Apps de venda que criam orders e enviam para autorização": (a) **o pedido nasce no AMBIENTE DO CLIENTE (setes-api: `tb_order` + faturamento com os impostos congelados) e o setes-api orquestra "faturar e autorizar" numa chamada; a fiscal-api só recebe o documento pronto** · (b) a fiscal-api aceita PEDIDOS (itens, preços) e produz a nota — o que exige cálculo de imposto, catálogo de produtos/regras e cadastro de clientes dentro dela. *(Rec.: (a) — (b) recria o ERP dentro da API fiscal e contradiz o parecer §3 ("a API responde pelo FORMATO; o ERP pelo CONTEÚDO"); o que (a) exige é a frente irmã S1 (setes-api como plataforma para apps, com "faturar e autorizar" síncrono para PDV). Se a intenção for atender quem NÃO usa o ERP, isso é um produto diferente — "motor de nota" — e merece prompt próprio.)*
- ~~**Q-F22 Acesso DIRETO de app móvel/web do usuário final à fiscal-api**~~ → **ABSORVIDA pela D-F13** (mesmo JWT curto do produto). Texto original:: (a) **não guarda secret no dispositivo: o backend do cliente (setes-api) é o `tb_licensee_app` e repassa um token curto já trocado (token exchange) ou faz a chamada** · (b) o app móvel carrega a credencial do licenciado (secret extraível do APK/IPA) · (c) só via backend, nunca direto. *(Rec.: (a) — direto quando precisar (PDV offline-first consultando estado), seguro porque o token expira; (b) é vazamento por construção.)*
- ~~**Q-F23 Perfil de carga dos 1000 clientes**~~ → **DECIDIDA = D-F23**. Texto original: (as premissas do §5.9 são chute): quantos são serviço × mercadoria × PDV, documentos/dia típicos e pico (Black Friday, fechamento de mês), quantos estabelecimentos por cliente (A1 por CNPJ). *(Rec.: responder com a base do legado — o Gestao2016 tem a estatística real dos clientes atuais da Setes; sem isso, a F3 dimensiona pelo §5.9 e o teste de carga fixa o número.)*
- ~~**Q-F24 setes-api em escala de 1000 clientes (frente irmã S2)**~~ → **DECIDIDA = D-F24**. Texto original: hoje o boot roda migrations em TODOS os schemas (`runMigrationsForAllInstitutions`), o pool é único (`connectionLimit: 20`), o rate limit é em memória por processo. (a) **diagnóstico com 1000 schemas sintéticos ANTES de decidir** (medir boot, deploy, pool) · (b) decidir já: migrations sob demanda/por versão gravada, pool dimensionado, rate limit compartilhado. *(Rec.: (a) — fato antes de intenção; a fiscal-api não depende disso, mas a visão "1000 clientes criando pedidos" depende.)*
- ~~**Q-F25 Infra de produção para a escala**~~ → **DECIDIDA = D-F16** (A1 cifrado no banco desde a F1; XML trocável, backend na F3). Texto original: storage de objeto S3-compatível para XML (200 GB/ano) e cofre criptografado em repouso (KMS ou chave-mestra) — a SaveInCloud oferece? (a) **descobrir na F3 e adaptar atrás das interfaces que já existem (`storageRoot()`, `secret-store`)** · (b) exigir desde a F1 (atrasa a extração). *(Rec.: (a) — as interfaces já isolam o backend; o worker de refresh entra na F3 em qualquer caso.)*
- ~~**Q-F26 "Seguindo as estruturas do setes-app"**~~ → **ABSORVIDA pela D-F17** (três pastas; código no molde do setes-api). Texto original: a leitura adotada (§1.5) é "mesmo tratamento de projeto" com código no molde do setes-api. Se o Valdo quis dizer outra coisa (ex.: monorepo com `packages/` + `apps/` como o setes-app, ou um app Flutter de administração da fiscal-api), corrigir aqui. *(Rec.: manter a leitura; um app de administração dos licenciados/emitentes, se vier, é tela do setes-app (Super) consumindo a fiscal-api — não um app novo.)*

**Acrescentadas pela 3ª mensagem do Valdo (§11 — "setes-api não vira cliente; o setes-app vira cliente da fiscal-api como qualquer front-end"):**

- ~~**Q-F27 Papel do setes-api perante a fiscal-api**~~ → **DECIDIDA = D-F4** (setes-api PASSIVO). Texto original: (a) **PASSIVO — NUNCA chama a fiscal-api: expõe os FATOS do documento, emite o token federado para o app, VERIFICA recibos assinados que o front-end traz (vínculo + efeito), recebe webhook de entrada com o mesmo recibo** (§11.2) · (b) não orquestra, mas pode CONSULTAR (GET) a fiscal-api para listas e plano de cancelamento — cliente só de leitura · (c) manter a D-F2 como estava (setes-api orquestra, app inalterado). *(Rec.: (a) — é o que o Valdo pediu e fecha SEM hearsay (o ERP nunca acredita no app, só na assinatura da fiscal-api); (b) é meia-medida que cria exatamente a dependência de saída que ele quer evitar. Consequência registrável: a regra canônica "setes-app só fala com setes-api" (D1 da revisão do sync; `ARQUITETURA_MODULOS.md` do app) vira "o app fala com os datasources DEDICADOS das APIs do produto; nunca cruza datasources" — decisão explícita, com atualização de memória e CLAUDE.md.)*
- ~~**Q-F28 Emissão iniciada pelo SERVIDOR fica fora por construção**~~ → **DECIDIDA = D-F5** (aceitar; conhecimento negativo). Texto original (§11.2-4): sem chamada de saída, a rotina mensal não transmite sozinha e `fiscal_auto_transmit` (D-N9) só existe como "o app transmite logo após faturar". Hoje transmitir já é ato explícito do usuário — nada se perde HOJE; perde-se a opção futura. (a) **aceitar e registrar como conhecimento negativo** · (b) reservar exceção: um ÚNICO processo servidor-para-servidor do setes-api como `tb_licensee_app` só para rotinas sem humano. *(Rec.: (a); se um dia for preciso, (b) nasce como decisão nova — nada no modelo impede.)*


**Rodada 3 — acrescentadas pelo parecer do guardião sobre o modelo da F0 (§13, 2026-10-03):**

- ~~**Q-F35 Onde mora o nDPS (número do DPS da vida)**~~ → **DECIDIDA = D-F30** ((b) `tb_invoice_service_dps` no `fiscal_api`) — foi REABERTA pela D-F27 (as APIs fiscais podem escrever no ERP; nova opção (d) = manter no ramo do ERP como hoje). Texto original: (a) na tentativa, com regra de cópia (candidato §12.3) · (b) **`tb_invoice_service_dps` por VIDA (série + nDPS + `dps_id` write-once; UNIQUE `(inst, dps_id)` volta); a chave do fisco continua na tentativa** · (c) (b) + chave/número/`dhProc` também no DPS (a D-N26 e a órfã R3-1 morrem por construção, mas reabre código de três rodadas adversariais). *(Rec.: (b); (c) registrada para rodada futura.)*
- ~~**Q-F36 Tentativas sem vida na migração**~~ → **SEM OBJETO** (fato, §13.3): 19/19 tentativas da Setes têm vida; a coluna da vida nasce NOT NULL e o script de migração falha alto se achar NULL.
- ~~**Q-F37 Vínculo do efeito no ERP**~~ → **DECIDIDA = D-F28** (operação em linha; nada gravado — pendência derivada). Texto original: (a) tabela `tb_invoice_fiscal_effect` · (b) colunas de causa no `tb_invoice_event` · (c) **nada novo — pendência DERIVADA (voz C na vida vigente × nota ainda não-C) e motivo recalculado pelo plano na hora**. *(Rec.: (c); (a) se quiser trilha explícita; (b) não serve à conjugada.)*
- ~~**Q-F38 Aplicar o C local quando a voz C chega sem humano**~~ → **DECIDIDA = D-F28** (sem job; pendência visível até o próximo contato do app). Texto original: (cancelada no portal; A tardia): (a) job interno no setes-api (singleton por `GET_LOCK`, autor = usuário de SISTEMA a definir) · (b) só quando um humano abre a nota/lista · (c) GET com efeito colateral · (d) saga do app. *(Rec.: (d) + (a) — a saga cobre o caso com humano; o job é a rede de segurança; (c) nunca.)*
- ~~**Q-F39 Pré-condições do cancelamento que saem de casa**~~ → **DECIDIDA = D-F29** ((a)). Texto original: (plano local ANTES do fisco; reconfirmação Q-ADV1b): (a) **o app consulta o plano no setes-api antes de pedir o cancelamento à nfse-api (consultivo — mudou no meio = pendência, como a D-F11 aceita); e o setes-api EXIGE, para F por consulta em produção, `last_queried_at` posterior ao F na view (prova legível da reconfirmação)** · (b) a nfse-api reimplementa o plano. *(Rec.: (a); (b) bifurca a política.)*
- ~~**Q-F40 Políticas do ERP que a nfse-api precisa**~~ → **DECIDIDA = D-F32** ((b) views no schema do cliente). Texto original: (interface do ramo — `resolveOrderInterface`; vida; admin passa; fuso; matriz do Anexo I): (a) copiar para a nfse-api com teste de contrato · (b) **o setes-api publica as políticas como VIEWs no schema do cliente (simétrico à D-F15) e passa ele mesmo a ler delas**. *(Rec.: (b) para interface do ramo e vida; (a) para o resto.)*
- ~~**Q-F41 Onde vive a regra da vigente/vida**~~ → **DECIDIDA = D-F33** ((c) biblioteca). Texto original:: (a) cada serviço implementa a sua · (b) a view entrega a vigente por (nota, vida) com `ROW_NUMBER` · (c) **a biblioteca `fiscal-api` exporta o contrato de leitura (tipos das views, `currentOf`, `fiscalStateOf`, kinds) para a nfse-api E para o setes-api; a view fica no molde do `TX_SELECT`, fundível**. *(Rec.: (c); (b) só depois de EXPLAIN — frente S2.)*
- ~~**Q-F42 Nomes no `fiscal_api`**~~ → **DECIDIDA = D-F34** ((b)). Texto original: (a) `tb_emitter` / `tb_issuer` · (b) **`tb_establishment_certificate` + manter `tb_establishment_issuer`**. *(Rec.: (b).)*
- ~~**Q-F43 Quem cria o DDL das tabelas de família**~~ → **DECIDIDA = D-F35** ((b)). Texto original: (a) o núcleo cria todas · (b) **o núcleo cria certificado, habilitação e o executor de migrations (trava + namespace por projeto); cada família cria as suas**. *(Rec.: (b) — a nfe-api AGREGA sem tocar o núcleo, D-F20.)*
- ~~**Q-F44 O que as APIs fiscais escrevem no ERP**~~ (nova, aberta pela D-F27) → **DECIDIDA = D-F31** ((a) lista fechada + cerca por teste; hoje: nada além do `FOR UPDATE` da nota). Opções eram: (a) lista fechada com cerca por teste · (b) livre.

### 8.R4 Rodada 4 — abertas pelos gates da F1 (2026-10-04; contexto no §15.4) — DECIDIDA 2026-10-04 ("siga as recomendações" → D-F36…D-F40)

- ~~**Q-F45 Quando fazer o smoke no ADN de HOMOLOGAÇÃO pela nfse-api**~~ → **DECIDIDA = D-F36** (a recomendação). (critério §12.8-4; fala com o fisco — exige "vai"): (a) **ANTES da virada, numa habilitação SE própria de homologação com SÉRIE PRÓPRIA (ex.: 900), tirando a institution da cerca só durante o smoke** — prova mTLS/DPS/voz pela nova casa sem tocar a numeração de produção do setes-api · (b) DEPOIS da virada (F2a), já com a nfse-api dona da emissão · (c) não fazer em H (o caminho já foi provado em produção pelo setes-api; a nfse-api herdou o código). *(Rec.: (a) — o A1 vence em **08/10/2026**; renovado o A1, o smoke prova também o upload pelo `/v1/emitter`. ⚠️ (a) exige trocar o ambiente da habilitação da institution 1 de P para H no `fiscal_api` — que hoje é cópia da produção do setes-api — e devolvê-lo com o `migrate:setes` depois.)*
- ~~**Q-F46 "Admin passa" vale também para a LICENÇA?**~~ → **DECIDIDA = D-F37** (a recomendação). Hoje (igual ao setes-api, D32 da Onda 3) o ADMIN transmite/cancela nota de ramo NÃO contratado (a licença só é conferida para o usuário comum — gates da F1). (a) **manter** (admin passa privilégio E licença — a licença é contrato comercial, o admin do cliente não a contorna de propósito) · (b) licença vale para TODOS (admin passa só o privilégio) — e o setes-api passa a fazer o mesmo na F2a. *(Rec.: (b) — licença é o que se vendeu; hoje a institution 1 do dev emite OS sem `service-orders` contratada, o que mostra que o dado precisa ser acertado ANTES de ligar a regra. Teste `it.failing` "[Q-F46]" fixa o comportamento atual.)*
- ~~**Q-F47 Teto de idade para revisitar AUTORIZADAS no rodízio**~~ → **DECIDIDA = D-F38** (a recomendação). (hoje: a cada 24 h, para sempre — D-N21; a candidata autorizada nunca sai da lista enquanto a nota não for C): (a) **teto = prazo de cancelamento do município (PAM) + margem (ex.: 60 + 30 dias)** — depois disso o fisco não aceita mais cancelamento pelo emitente e a voz não muda · (b) teto fixo (ex.: 120 dias) · (c) manter sem teto. *(Rec.: (a); sem teto o rodízio cresce com o histórico — ver Q-F49.)*
- ~~**Q-F48 Onde mora a CERCA DA VIRADA (D-F18)**~~ → **DECIDIDA = D-F39** (a recomendação). — hoje variável de ambiente `FISCAL_LEGACY_INSTITUTIONS` por instância (estrita desde o retrabalho 2: item mal escrito impede o boot; ausente = nenhuma): (a) **fato no `fiscal_api`** — custódia da emissão na linha da habilitação (`'setes-api' | 'nfse-api'`), trocada pelo próprio `migrate:setes` na re-sincronia FINAL, na mesma transação, e lida por TODAS as instâncias (a virada vira um ato atômico; nenhuma instância diverge) · (b) continua na variável, mas FAIL-CLOSED: ausente = erro de boot; valor explícito para "nenhuma" (ex.: `none`) · (c) como está (ausente = nenhuma), aceito como risco só do dev até a F2a. *(Rec.: (a) — o socrático R2 mostrou que, com a cerca aberta por engano, dois contadores de nDPS cunham o MESMO Id de DPS para notas diferentes e a conferência R2-2 passa justamente porque os Ids são iguais; (b) é o mínimo se ficar na configuração. (a) é DDL no núcleo — passa pelo guardião + revisar-ddl.)*
- ~~**Q-F49 O custo das leituras que crescem com o histórico entra como critério de aceite?**~~ → **DECIDIDA = D-F40** (a recomendação). (página de pendentes = COUNT + página sobre todas as notas do cliente via 3 views com NOT EXISTS por linha; candidatas do rodízio = MAX correlacionado sobre todas as tentativas da institution com OR que não usa o índice de `last_queried_at`): (a) **sim — teto de tempo por chamada (ex.: p95 < 300 ms com 200 mil notas) no teste de carga da F3 / diagnóstico da S2 (D-F23/D-F24), com `EXPLAIN` na cerca** · (b) fica para quando doer. *(Rec.: (a); medido hoje no dev: 1ª página dos pendentes 119–206 ms com 386 notas — não diz nada sobre 200 mil.)*


### 8.R5 Rodada 5 — aberta pela execução da Rodada 4 (guardião + gates, §16) — Q-F50 DECIDIDA (D-F44) · Q-F51 ADIADA · Q-F52 DECIDIDA (D-F46) · ⚠️ Q-F53 AGUARDA O VALDO

- ~~**Q-F50 Como fechar o LADO DO ERP na virada?**~~ → **DECIDIDA = D-F44** ("manter" a (a) refinada — §17). (refinada pelos gates da Rodada 4 — §16.4). O ato `migrate:setes
  --cutover` grava `cutover_at` no `fiscal_api`, mas o contador do setes-api NUNCA lê esse fato: uma instância esquecida ou
  um ROLLBACK do deploy do setes-api depois da virada cunharia o MESMO nDPS na mesma série (cenário R2-2); e, até a F2a, o
  setes-api pode criar habilitação SE no ERP para institution que NASCEU na API (lacuna inversa). (a) **o ato da virada
  APOSENTA a habilitação SE do ERP (`deleted='S'`) na mesma transação** — escrita UMA vez pelo SCRIPT (nunca pelo serviço),
  item novo na lista fechada da D-F31; a reserva do setes-api que esperava a trava acorda e recebe 409
  `FISCAL_ISSUER_MISSING` sem mudar código do setes-api · (b) até perder as rotas fiscais, o setes-api LÊ o fato numa view do
  `fiscal_api` antes de cunhar (leitura passiva no molde da D-F11) — muda código do setes-api · (c) só a ordem de deploy: a F2a
  remove as rotas fiscais E a habilitação SE da tela "Emissor fiscal"; rollback do setes-api depois da virada proibido por
  procedimento; a re-sincronia periódica fica como detecção. *(Rec.: (a) — fecha por construção com uma escrita única e
  auditável; (b) é a alternativa se a D-F31 não admitir o item; a linha 55/65 do ERP — série do faturamento, D-F21 — não é
  tocada em nenhuma.)*
  **Refinamento do guardião (2026-10-04, parecer da D-F42 — §17):** a linha SE do ERP carrega DOIS conceitos — a SÉRIE DA
  NOTA interna (`tb_invoice.serie`, lida pelo faturamento e pela OS) e a habilitação para falar com o fisco. (a) com
  `deleted='S'` aposenta também a série da nota SE: faturamento e OS passam a usar o default '1'. Hoje NÃO muda nada (a série
  SE da Setes é '1'; as 903 notas SE do dev são série '1'). *(Rec. refinada: manter (a), com a condição virando CONFERÊNCIA do
  próprio ato — série SE do ERP ≠ '1' → falha alta; e registrar para a F2a que a tabela do ERP passa a significar só a série
  da nota — ambiente da SE e `dps_last_number` ficam sem consumidor e são aposentados SEM DROP.)*
- ⏸ **Q-F51 — ADIADA pelo Valdo (2026-10-04): "ignore, pois está programada a renovação" do A1** — o prazo de 08/10/2026 deixa
  de pressionar o smoke; a origem da nota de teste volta à mesa depois da renovação. Texto original: **De onde vem a NOTA DE
  TESTE do smoke da D-F36?** Hoje há ZERO notas elegíveis (300 conferidas: 294 sem código
  nacional — anteriores à D-N11a —, 6 com `cTribMun` "0102" — anteriores à D-N26b) e o A1 vence em 08/10/2026. (a) **faturar
  uma OS de TESTE no dev pelo setes-api** (regra de ISS atual — código nacional + código municipal vazio ou de 3 dígitos):
  consome a numeração e gera financeiro no ERP que guarda a produção da Setes — escolher cliente/serviço/valor e cancelar a
  nota localmente depois · (b) corrigir o código nacional de um serviço antigo e usar uma nota existente (escrita em cadastro
  fiscal de produção) · (c) fazer o smoke DEPOIS de renovar o A1 (a renovação entra pelo setes-api + `migrate:setes`, porque
  o `fiscal_api` é réplica) · (d) não fazer o smoke em H (Q-F45 (c)). *(Rec.: (a) com um cliente interno da própria Setes e
  valor simbólico — é o único caminho que prova o DPS montado pela regra atual; (c) se o prazo do A1 apertar.)*
- ~~**Q-F52 Licença (D-F37) × obrigação fiscal JÁ assumida**~~ → **DECIDIDA = D-F46** ((b) bloqueio total — Valdo,
  2026-10-04; a recomendação era (a)). Texto original: quando o ramo deixa de ser contratado, o que acontece com o que
  já foi emitido? Hoje, nada passa: NFS-e em voo ou em K deixa de ser reconciliada pela consulta/rodízio, o cancelamento
  dentro do prazo do município e o XML/DANFSe que o cliente tem de guardar ficam bloqueados — inclusive para o admin; e a
  passada de quem tem UM ramo contratado consulta notas de ramo NÃO contratado. (a) **a licença barra só a transmissão NOVA;
  consulta, cancelamento no fisco e leitura do já emitido continuam** (a obrigação nasceu quando o ramo era contratado) · (b)
  como está — bloqueio total · (c) leitura sobrevive, ações não. *(Rec.: (a) — o contrato comercial não pode impedir o
  cumprimento de obrigação fiscal já assumida; a passada filtra as candidatas pelos ramos contratados OU com NFS-e viva.)*
- **Q-F53 Os ataques ao vivo voltam a rodar com o usuário de SELECT MÍNIMO da D-F31?** O harness das cópias descartáveis
  usa o usuário do setes-api (ALL PRIVILEGES ON *.* — escreve no ERP que guarda a produção da Setes); hoje a defesa é
  DETECÇÃO (o `drop()` confere o CHECKSUM do `fiscal_api` real, da `_migrations` e de 8 tabelas do ERP). (a) **GRANT ALL em
  `fiscal\_api\_adv\_%`.* para o usuário `fiscal_api`** (só as cópias; o do setes-api só cria/apaga a cópia) — a defesa
  volta a ser por construção · (b) manter a detecção · (c) como estava. *(Rec.: (a) — é mudança de permissão no servidor de
  produção da Setes: só com o "vai" do Valdo; um `it.failing` "[Q-F53]" fixa o estado atual.)*

### 8.R6 Rodada 6 — aberta pelo gate socrático do delta das 4 falhas (2026-10-04, §17) — DECIDIDA 2026-10-04 ("siga as recomendações" → D-F41…D-F43; Q-F56 "sim" → D-F45)

- ~~**Q-F54 Espera no comando do ALUGUEL**~~ → **DECIDIDA = D-F41**. O UPDATE do aluguel esperava até 50 s (lock wait padrão)
  pela linha da habilitação; renovar estourando + devolver no `finally` = ~100 s presos na requisição de quem abriu a tela.
  (a) manter 50 s (nenhum detentor longo por desenho) · (b) **espera curta só no comando do aluguel → 409 `RESOURCE_BUSY`**
  (D-A23). *(Rec.: (b).)*
- ~~**Q-F55 O `migrate:setes` copia e vira TODOS os modelos da habilitação do ERP**~~ → **DECIDIDA = D-F42**. Hoje copia
  qualquer linha da institution (serie/contador só para SE) e o `--cutover` vira todas — uma linha 55 do ERP viraria
  "habilitação 55 virada" sem API que a emita e a série do 55 ficaria em dois lugares (no dev o ERP só tem SE: latente).
  (a) **copiar e virar só a SE** · (b) como está. *(Rec.: (a), com parecer do guardião — toca o "ato por institution" da D-F39.)*
- ~~**(a)/(b) da conferência "o que foi movido saiu do setes-api?"**~~ → **DECIDIDA = D-F43** (portar a correção do DPS).
- ~~**Q-F56 (nasceu do parecer do guardião sobre a D-F42)**~~ → **DECIDIDA = D-F45** ("sim"). **Domínio do `model` da habilitação como FATO DO BANCO?**
  A regra "travar todas as linhas da chave = PK por linha com a lista fechada" (PADROES §9 regra 8) só é verdadeira se o
  domínio for fechado no banco; hoje é VARCHAR(2) sem CHECK e o fechamento é só em código (`ISSUER_MODELS` — o retrabalho do
  delta fez a trava e a contagem enxergarem o mesmo domínio). (a) **`CHECK (model IN ('SE','55','65'))` na migration 004 do
  núcleo (dono da tabela — D-F35; 1º CHECK da casa) + o boot do núcleo confere que o motor APLICA CHECK** (MariaDB ≥ 10.2
  aplica; MySQL < 8.0.16 aceita e ignora em silêncio — o motor da SaveInCloud ainda não foi conferido, risco 3 do §13) · (b)
  só em código, como está. Modelo novo (57…) = migration do núcleo que estende o domínio. NÃO entra: CHECK "réplica ⇒ SE"
  (é história da migração, não fato do núcleo) nem tabela-catálogo de modelos (lê-la antes do FOR UPDATE recriaria o
  snapshot antes da trava). *(Rec.: (a), passando pelo `revisar-ddl`.)*

### 8.R7 Rodada 7 — aberta pelos gates do delta da Rodada 6 + D-F46 (2026-10-04, 3ª sessão — §18) — Q-F57/Q-F58 DECIDIDAS (D-F47/D-F48) · ⚠️ Q-F59 em esclarecimento · ⚠️ Q-F60 aguarda

- ~~**Q-F57 Nota VIVA de ramo descontratado trava o emitente inteiro (consequência da D-F46).**~~ → **DECIDIDA = D-F47** ((b)). Uma tentativa em voo / S / K de
  um ramo que saiu do contrato nunca mais reconcilia (a passada a filtra; a rota por nota dá 403 a todos), mas
  `countLiveTransmissions` conta TODOS os ramos — e a guarda do emitente (`emitter.service.ts`) passa a recusar PARA SEMPRE
  trocar o ambiente, excluir a habilitação e excluir o A1, também para o ramo que continua contratado. Mesmo resolvida no
  portal do ADN, o `fiscal_api` nunca fica sabendo. (a) `countLiveTransmissions` conta só os ramos contratados (o emitente fica
  livre; a nota órfã fica "viva" para sempre no `fiscal_api`) · (b) refinar a D-F46: a passada continua reconciliando nota JÁ
  VIVA de ramo cortado (não é serviço novo, é fechar o que estava em curso; consultar, cancelar e ler continuam 403) · (c) ato
  do admin "encerrar sem reconciliar" com motivo (voz nova, auditável) · (d) manter: o cliente recontrata o ramo para
  destravar. *(Rec.: (b) — é o mínimo que não deixa estado eterno no banco e não reabre nada da D-F46 para o usuário; (a)
  esconde o problema; (d) depende do comercial para destravar o fiscal.)*
- ~~**Q-F58 A re-sincronia trava as habilitações VIRADAS de todas as institutions até o fim.**~~ → **DECIDIDA = D-F48** ((a)). `resyncAll` usa UMA transação
  para todas (D-F18 "tudo ou nada"); com a trava por linha do §17.2, as linhas viradas ficam FOR UPDATE até o commit final —
  durante uma re-sincronia longa, transmitir/cancelar nelas esperam até 50 s e voltam 409, a passada volta 409 em 3 s.
  (a) transação POR institution (o tudo-ou-nada global não protege nenhum invariante ENTRE institutions) · (b) pular as viradas
  na passada geral e conferi-las (`assertFrozen`) numa transação curta própria · (c) manter e rodar só em janela de
  manutenção. *(Rec.: (a) — com 1 institution hoje é igual; com várias, é a única que não para quem já virou.)*
- **Q-F59 O ato da virada confere POR CONSTRUÇÃO que a F2a está no ar?** Até a F2a, o `upsertIssuer` do setes-api (tela
  "Emissor fiscal", `ON DUPLICATE KEY UPDATE … deleted='N'`) REVIVE a linha SE que a D-F44 aposentou — e a tela, mostrando "sem
  habilitação SE", convida o admin a recriá-la; o contador congelado do ERP volta a cunhar nDPS já usados (R2-2). Hoje só a
  re-sincronia seguinte detecta e a defesa é a flag `--confirmo-setes-api-parado`. (a) o ato confere um FATO do setes-api
  (ex.: a migration da F2a que tira a SE da tela aplicada no schema) e recusa sem ele · (b) manter procedimental + detecção.
  *(Rec.: (a) — a virada só acontece depois da F2a de qualquer jeito; conferir custa uma leitura.)*
  **Resposta do Valdo (2026-10-04), em esclarecimento:** "considere que o schema central e o schema de cliente permanecem o
  mesmo, estamos apenas usando APIs separadas para dar escala — serviços de autorização de NFS-e e NF-e precisam ser
  turbinados quando forem muito requisitados, e não uma API monobloco."
  Esclarecido na mesma sessão: o banco fiscal FICA (D-F49); a Q-F59 volta à pergunta original ((a) × (b)).
- **Q-F60 (gate do delta D-F47/D-F48, §18.2) A passada grava F "sem resposta" por CONSULTA?** A D-F47 não destrava o emitente
  num subcaso: tentativa EM VOO cujo DPS o fisco não conhece (envio que nunca chegou). A consulta só marca `last_queried_at`; o
  único escritor do F "sem resposta" é `reconcileInterrupted`, que roda só no TRANSMITIR — 403 para ramo cortado. A órfã fica
  viva para sempre, trava o emitente e volta ao topo do rodízio a cada 5 min com uma chamada ao ADN. (a) a passada grava o F
  por consulta depois de `IN_FLIGHT_MINUTES` com o fisco sem o DPS, como o transmitir já faz — para TODO ramo · (b) só para
  ramo cortado · (c) não; a D-F47 registra o subcaso como risco aceito. Mexe na regra herdada "F só conclusivo" (D-N) — o
  mesmo critério que o transmitir já usa. *(Rec.: (a) — um veredito conclusivo só, nos dois caminhos; (b) cria regra
  diferente por licença para o mesmo fato do fisco.)*
---

## 9. Fora de escopo desta fase

Cálculo de imposto (continua no ERP) · IBS/CBS (fase própria — Q-F14) · NFC-e/PDV (F5, onda própria) · carta de correção, contingência SVC/EPEC, manifestação do destinatário, DF-e distribuição (compra) · metering/cobrança do serviço · sentido web → legado · substituição de NFS-e, análise fiscal e101103 · webservice municipal (D1 da Onda 3 matou).

---

## 10. Critérios de sucesso (testáveis)

> ⚠️ **SUPERADOS onde conflitarem com o §12.8**; o item 12 (recibo assinado) morreu com a D-F11.

1. `fiscal-api` sobe sozinha (sem `setes_central`), com `fiscal_api` vazio + migrations próprias; `/v1/health` prova banco e cofre; OpenAPI servido em `/docs`; **nenhum import de `tb_invoice`/`tb_order`/`tb_entity`** (teste do terceiro cego — cerca por teste de lint/grep).
2. Licenciado + emitente (CNPJ da Setes) + A1 (.pfx + senha → PEM; senha em lugar nenhum) via `/v1`; par inválido/vencido/CN ≠ CNPJ → 4xx legível (D-N29b/D-N30b).
3. `POST /v1/nfse/documents` com os fatos da OS → 201 com chave 50 e número no ADN **H**; replay com o mesmo `externalCode` → mesma resposta, nenhuma 2ª tentativa (UNIQUE por construção); DPS rejeitado → 422 com E0xxx no `fields[]`; timeout simulado → 202 em voo e `refresh` reconcilia por `dps_id`.
4. setes-api: trilha `trilha-primeiro-cliente.ts` P8a/P8b OK contra a `fiscal-api`; lista de OS com selo fiscal por lote de referências (API parada → "indisponível", nunca 500); "Cancelar nota" com NFS-e autorizada → voz C no serviço + C local no ERP + ack; falha local simulada → pendência visível nos dois lados + "Reaplicar efeito" fecha; nota SEM vínculo cancela local sem chamar a API; **nenhum arquivo Dart alterado**.
5. Migração dos dados da Setes: as transmissões/vozes/XMLs existentes aparecem no serviço com `external_code` = nota:vida e o vínculo nasce no ERP; DANFSe da nº 704 renderiza igual; H depois P sem reemitir nada.
6. Escala: 2 instâncias da `fiscal-api` contra o mesmo banco, 6 pedidos concorrentes do mesmo `externalCode` → 1 documento, 1 tentativa viva, zero 500 (molde das provas de corrida das rodadas anteriores); nenhum `Map/Set` de controle em memória.
7. Gates por onda: socrático ≥ 0,70 · adversarial sem HIGH/CRITICAL; achado confirmado vira teste.
8. Família nfe (F4, quando houver fato gerador): NF-e autorizada em homologação da SEFAZ-PR com XML válido no XSD, DANFE renderizado, inutilização de faixa homologada, cancelamento 110111 e denegação tratada como D sem efeito automático.
9. **Carga (D-F3)**: `scripts/carga-fiscal.ts` com 1000 licenciados × 5 req/s × 30 min contra fisco FALSO, em 2 instâncias: p95 < 5 s fora do tempo do fisco, zero 500, zero documento duplicado, nenhum estado em memória de processo; relatório anexado ao prompt.
10. **Multi-app (D-F2)**: dois apps do mesmo licenciado com credenciais independentes emitem pelo mesmo emitente; revogar um não afeta o outro; token expirado → 401 legível; app sem escopo `nfse:write` → 403; app web direta só das origens do licenciado (CORS); nenhum secret em claro no banco, no log ou na resposta.
11. **Operação para 1000**: alerta de vencimento de A1 por licenciado (o da Setes em 08/10/2026 é o caso zero), métricas por licenciado visíveis, `/health` prova banco + cofre + storage.
12. **Se Q-F27 = (a)** — setes-api passivo: nenhuma chamada HTTP de saída do setes-api para a fiscal-api (cerca por grep em `src/`); recibo com assinatura inválida/expirada/de outro licenciado → 401/409 e NADA muda na nota; nota com "declaração solicitada" sem recibo → cancelamento local 409 `FISCAL_RECEIPT_REQUIRED`; app fechado entre o passo 2 e 3 da saga → ao reabrir, o app recupera pelo `externalCode` e completa, sem 2º documento; webhook de entrada com recibo C aplica o efeito sem humano; selo fiscal da lista = último recibo verificado.

---

## 11. Análise — setes-app como cliente DIRETO da fiscal-api (Valdo, 2026-10-03, 3ª mensagem)

> ⚠️ **Registro histórico.** A direção (app cliente direto, setes-api passivo) foi decidida na D-F4; os MECANISMOS desta análise (recibo assinado, federação, webhook de entrada) foram SUPERADOS pela D-F10/D-F11/D-F13 (leitura direta do banco na mesma instância + mesmo login).

> "não quero que setes-api vire cliente e sim o setes-app vire cliente de fiscal-api como qualquer outro front-end... analise isso"

### 11.1 O que a frase muda

| Antes (D-F2 como registrada) | Pedido |
|---|---|
| setes-api = `tb_licensee_app` de escopo pleno; orquestra "faturar → fatos → fiscal-api → vínculo → efeito"; app continua falando só com `/api`, **inalterado** | setes-app (e qualquer front-end) fala DIRETO com a fiscal-api; **o setes-api não chama a fiscal-api** |
| Regra canônica dos dois grupos: setes-app ↔ setes-api × Sincronizador ↔ setes-sync (D1 da revisão do sync); app: "módulo fala só com o seu `/api/<m>`" | nasce uma 3ª aresta: setes-app ↔ fiscal-api. Se confirmado, é decisão EXPLÍCITA: o app consome N APIs do produto, cada módulo com datasources dedicados por API, nunca cruzados |

Não muda o CONCEITO nem a fronteira do parecer §3 (conteúdo no ERP; formato e conversa na API). Muda o **PORTADOR** dos fatos e das vozes: em vez do servidor, o front-end.

### 11.2 As quatro perguntas que o desenho tem que responder — e como responde sem furar a fronteira

1. **Quem monta os FATOS do documento?** O conteúdo é do ERP (§3.B: emitente, tomador, serviço congelado, valores, zona). → O setes-api expõe `GET /api/<ramo>/:orderId/fiscal-facts` = o `buildDpsBase` de hoje SERIALIZADO (o payload do `POST /v1/nfse/documents`) + `externalCode` determinístico (`<schema>:<invoiceId>:<vida>`), e grava na nota a INTENÇÃO ("declaração solicitada"). O app REPASSA à fiscal-api. O ERP continua dono do conteúdo; o app é portador. Um front-end de terceiro produz os fatos do próprio sistema dele. Os 422 de cadastro incompleto continuam do ERP (nascem no `fiscal-facts`).
2. **Como o usuário do app se autentica na fiscal-api sem carregar o segredo do licenciado?** (Q-F22) → **federação de identidade**: a fiscal-api confia em tokens emitidos pelo backend do LICENCIADO — chave pública/JWKS registrada em `tb_licensee`. O setes-api já emite JWT para o app; passa a emitir também um token curto para a fiscal-api (claims: `licensee`, `emitters` permitidos, escopos, `externalUser`). O setes-api vira **emissor de identidade confiado**, não cliente. Front-end de terceiro com backend próprio faz o mesmo; sistema servidor usa `tb_licensee_app` + `POST /v1/auth/token`.
3. **Como o ERP sabe o que o fisco disse, sem perguntar à fiscal-api e sem acreditar no app?** → **RECIBO ASSINADO**: toda voz que a fiscal-api devolve (A, R, F, C, K, N) vem num JWS assinado pela fiscal-api (chave pública conhecida do setes-api, com rotação) contendo `documentId`, `externalCode`, `emitter`, `kind`, `dh`, chave/número. O app repassa o recibo (`POST /api/<ramo>/:orderId/fiscal-receipt`); o setes-api verifica a assinatura OFFLINE, grava o vínculo e aplica o efeito. **Hearsay morre por construção**: um app não consegue "contar" ao ERP que o fisco cancelou — só portar o recibo. A D-N7 relaxada (Q-F19) vira: *C local SÓ com recibo C verificado*; "nunca cancela no escuro" vira *nota com vínculo e sem recibo conclusivo → 409 `FISCAL_RECEIPT_REQUIRED` ("consulte na fiscal-api e traga o estado")*. Alternativa examinada: verificar a assinatura do PRÓPRIO fisco no XML da NFS-e/evento (ICP-Brasil) — mais pesado e não cobre F/K/R; fica como opção.
4. **E quando não há humano na tela?** (voz C descoberta pelo worker da fiscal-api — cancelada no portal; A tardia depois de K) → **webhook de ENTRADA** no setes-api (`/hooks/fiscal-document/:inst/:token`, molde do Inter — D-I9) carregando o MESMO recibo assinado. Receber webhook não é ser cliente: nenhuma chamada de saída. **O que fica impossível sem chamada de saída: EMISSÃO iniciada pelo servidor** (rotina mensal transmitindo sozinha; `fiscal_auto_transmit` da D-N9 fora de uma tela). Hoje transmitir é ato explícito do usuário — nada se perde hoje; perde-se a opção futura → Q-F28.

### 11.3 A saga no front-end (3 passos) e a recuperação

```
1. app → setes-api   GET  /api/<ramo>/:orderId/fiscal-facts        → fatos + externalCode; nota marcada "declaração solicitada"
2. app → fiscal-api  POST /v1/nfse/documents (token federado)       → 201 A · 422 R · 202 K  — sempre com RECIBO assinado
3. app → setes-api   POST /api/<ramo>/:orderId/fiscal-receipt {jws} → verifica assinatura, grava vínculo (documentId), aplica efeito
```

- App fecha/rede cai entre 2 e 3: a nota fica "declaração solicitada sem recibo"; ao reabrir, o app consulta `GET /v1/nfse/documents?externalCode=` (UNIQUE: acha o documento ou nada — §3.C) e completa o passo 3. Idempotente nos três passos; a fiscal-api nunca cria 2º documento para o mesmo `externalCode`.
- Lote "Transmitir pendentes": o app fatia e repete a saga por item (já faz isso na cobrança mensal — D27); o orçamento de 60 s do servidor e o `runningBatch` morrem por construção.
- Lista com selo fiscal: (i) o app consulta a fiscal-api por lote de `externalCode` (Q-F16 (a)) ou (ii) o ERP mostra o **último recibo verificado** — um espelho LEGÍTIMO, porque nasceu de assinatura, não de cache. Isso reabre a Q-F16 a favor de (ii) "espelho por recibo", que o guardião aceitaria (não é "status sincronizado por cron": é fato assinado portado).
- Cancelar nota: `buildCancelPlan.fiscal` lê vínculo + último recibo; recibo A vigente → o app precisa cancelar na fiscal-api PRIMEIRO e trazer o recibo C; recibo R/F conclusivo → cancela local; sem recibo conclusivo → 409.
- A1 e habilitação: o upload do `.pfx` vai do app DIRETO à fiscal-api — o certificado nunca passa pelo ERP (ganho). Telas Super de licenciado/app/emitente no setes-app consomem a fiscal-api.

### 11.4 O que muda no plano (F2 vira duas frentes; o app MUDA)

| Antes (Rodada 1) | Com o setes-api passivo (Q-F27 (a)) |
|---|---|
| F2 "setes-api consumidor": `@shared/fiscal-client`, 5–7 sessões, **app inalterado** | **F2a — setes-api PASSIVO** (`fiscal-facts`, `fiscal-receipt` com verificação JWS, vínculo + efeito, webhook de entrada, token federado, cerca "zero saída" por grep): 4–6 sessões · **F2b — setes-app CLIENTE** (módulo/datasource `fiscal` apontando para a fiscal-api, token, saga resumível, lote no cliente, DANFSe/XML direto, upload do A1 direto, telas Super de licenciado/app/emitente): 6–9 sessões — **17 arquivos Dart de hoje mudam + novos** |
| F1 shell: token por app | F1 ganha federação (JWKS por licenciado), recibos assinados (chave da fiscal-api + rotação), CORS por licenciado como caminho PRINCIPAL, endpoints de arquivo pensados para browser/mobile: +2–3 sessões |
| `trilha-primeiro-cliente.ts` bate só no setes-api | a trilha vira um FRONT-END: bate nas duas APIs e porta recibos (régua do corte) |
| Total F0–F3: 24–35 sessões | **30–43 sessões ≈ 6–8 semanas** |

### 11.5 Ganhos e custos (sem maquiar)

**Ganhos**: fiscal-api front-end-first de verdade (o PDV/NFC-e autoriza do dispositivo, um salto a menos — relevante para a F5); ERP menor e SEM dependência de saída (fiscal-api fora não derruba faturamento nem baixa); o A1 nunca transita pelo ERP; front-end de terceiro é cidadão de 1ª classe desde o 1º dia; `runningBatch` e o orçamento de lote do servidor morrem.

**Custos**: cada front-end reimplementa a saga de 3 passos (mitigar com receita publicada + SDK Dart/TS); o app muda (não mudava); sem emissão iniciada pelo servidor (Q-F28); o estado do ERP fica ATRÁS do fisco até um recibo chegar (webhook mitiga); mais superfície de segurança (CORS, token no browser, chaves de verificação e rotação); o lote passa a depender da sessão do usuário (fechar a aba = parar — Q-R5.2 já existia).

### 11.6 Leitura do guardião aplicada (sem nova rodada do agente)

O parecer §3 continua inteiro: conteúdo no ERP, formato/conversa na API, API cega ao ERP. O que ele proíbe continua proibido, com outro transporte: C local sem voz → *sem recibo*; estado em cache decisório → *só recibo verificado*; "ERP cancela sem perguntar quando há vínculo" → *sem recibo conclusivo, 409*. Palavra nova a ocupar se decidido: **recibo** (`receipt`) = a voz assinada pela fiscal-api para quem a porta — não colide com "voz" (fato cru do fisco), "registro" (boleto no banco) nem "protocolo" (número do fisco). Nome candidato da tabela do ERP: `tb_invoice_fiscal_receipt` (substitui `tb_invoice_fiscal_document` — o vínculo passa a ser o 1º recibo).

**Recomendação**: Q-F27 (a) — fazer exatamente o que o Valdo pediu, com os três mecanismos (federação, recibo assinado, webhook de entrada) como condição; sem eles, "o app é o cliente" vira "o ERP acredita no app", e isso o guardião chamaria de maquete.

---

## 12. Plano consolidado pós-Rodada 2 (2026-10-03) — VIGENTE

> Substitui §4, §5, §6, §10 e §11 **onde conflitarem** (essas seções ficam como registro das Rodadas 0/1). Toda linha cita a decisão que a sustenta. O que ainda é DESENHO (não decisão) está marcado *candidato F0* e passa pelo guardião + `revisar-ddl` antes de virar DDL.

### 12.1 Topologia e projetos (D-F9, D-F12, D-F17, D-F7)

```
                      Plesk (domínio = gate do cliente) — build Flutter (setes-app)
                         │ JWT do produto (RS256 — D-F13)      │                │
                         ▼                                      ▼                ▼
                 setes-api :3000                         nfse-api :3002     nfe-api :3003 (sem código — D-F20)
             (ERP; PASSIVO: nunca chama                  ├─ núcleo: fiscal-api (BIBLIOTECA — dependência local no dev, tag no deploy)
              as APIs fiscais — D-F4)                    └─ ADN · DPS · DANFSe · fonte de fatos do ramo de serviço
                         │                                      │
                         │ SELECT só nas VIEWs do fiscal_api    │ SELECT só em setes_central/setes_* (D-F15)
                         ▼                                      ▼ controle total só no fiscal_api
            ┌──────────────── Instância MySQL única (D-F9) ─────────────────┐
            │ setes_central · setes_<cliente>… · fiscal_api (D-F7) │ setes-sync :3001 (inalterado)
            └────────────────────────────────────────────────────────────────┘
```

| Pasta na raiz | Papel | Roda? | Repo |
|---|---|---|---|
| `fiscal-api/` | **núcleo comum** (D-F17): transporte mTLS, XMLDSig, cofre cifrado, storage de XML, habilitação/emitente, máquina tentativa × voz, motor de PDF, autenticação pelo JWT do produto, base da fonte de fatos Gestão 2027, migrations do `fiscal_api` | não (biblioteca) | `valdosouza/gestao-2027-fiscal-api` (a criar pelo Valdo) |
| `nfse-api/` | serviço da família NFS-e (ADN): gateway `/v1`, OpenAPI servido, health, ADN + DPS + DANFSe, fonte de fatos do ramo de serviço | sim, :3002 | `valdosouza/gestao-2027-nfse-api` (a criar) |
| `nfe-api/` | serviço da família NF-e/NFC-e (SEFAZ) | não nesta fase (D-F20) | `valdosouza/gestao-2027-nfe-api` (a criar quando houver código) |

### 12.2 Fronteira revisada (D-F10, D-F11, D-F14, D-F21)

| Peça hoje no setes-api | Destino | Observação |
|---|---|---|
| `tax-authority/{https-json, xmldsig, types}` | **núcleo** | transporte e assinatura paramétricos por família |
| `tax-authority/{adapters/adn, dps-builder}` | **nfse-api** | específicos do ADN/DPS |
| `secret-store` (owner `establishment`) | **núcleo**, reescrita: A1 CIFRADO no `fiscal_api` (D-F16) | o setes-api MANTÉM a sua para o canal do banco (owner `bank-account`, D-I1) |
| `fiscal-issuer` | **núcleo** | `tb_establishment_issuer` → `fiscal_api.tb_issuer`; PKCS#12 → par PEM igual |
| `invoice-transmission.ts` (política da voz) + `transmission.repository.ts` | **núcleo** (máquina) + **nfse-api** (estratégia do ramo) | tabelas passam para o `fiscal_api`; o EFEITO sai (D-F11) |
| `branches/service.ts` — leitura do ERP (`readServiceInvoice`, `buildEmitter`, `buildRecipient`, `buildDpsBase`, `emitterDpsFacts`, L8) | **nfse-api**, como FONTE DE FATOS (D-F10) | só-leitura no ERP (D-F15); os 422 de cadastro incompleto continuam com os mesmos códigos |
| `branches/service.ts` — `lockDpsNumber`/`setDpsNumber` (`tb_invoice_service.dps_number`) | **morre** no ERP | o nDPS da vida vive na tentativa do `fiscal_api` (a API não escreve no ERP) |
| `danfse` | **nfse-api** (motor pdfkit no núcleo) | nome/município do emitente lidos do ERP pela fonte de fatos |
| `applyCancelEffect` / `buildCancelPlan.fiscal` / `reconfirmBeforeLocalCancel` | **FICAM no setes-api** | leem a voz nas VIEWs do `fiscal_api` (D-F11); a reconfirmação no fisco (Q-ADV1b) passa a ser pedida pelo APP à nfse-api antes do cancelamento local |
| `billing.fiscal.*` (9 rotas) + `establishment.issuer.*` (5 rotas) | **morrem no setes-api** | o app chama a nfse-api direto (D-F4); o setes-api fica só com o efeito e o plano |
| privilégios TRANSMITIR/CANCELAR por ramo | REGRA no ERP; APLICADA pela nfse-api lendo o schema do cliente (D-F13) | o resolver de interface do ramo vira leitura da fonte de fatos |
| `runningBatch` / lote de 60 s | **morre** | o lote é do app (fatia e repete — molde D27) |
| `runningRefresh` (Map em memória) | **morre** | trava no banco ou worker (F3); nenhum `Map/Set` de controle |

### 12.3 Banco `fiscal_api` — modelo CANDIDATO F0 (guardião + `revisar-ddl` antes do DDL)

> ⚠️ **SUPERADO pelo §14** (Rodada 3: `tb_establishment_certificate`/`tb_establishment_issuer` — D-F34; DPS por vida — D-F30; sem vínculo de efeito — D-F28; DDL por dono — D-F35).

Princípio: as tabelas da Onda 3 MUDAM DE CASA, não de conceito — mesma forma, mesma chave natural (`tb_institution_id` é global em `setes_central`), sem FK para o ERP (outro banco). O que muda: o efeito sai da voz; o A1 entra no banco cifrado; o nDPS da vida passa para a tentativa.

| Tabela (candidata) | Origem | PK | Notas |
|---|---|---|---|
| `tb_emitter` | cofre em arquivo (`SECRETS_PATH/<schema>/establishment/<inst>/P/`) | `tb_institution_id` | A1 do estabelecimento (D-N31, D-F14): `cnpj` (do CN, conferido com o ERP no upload — D-N29b), certificado PEM (público), chave privada CIFRADA (AES-256-GCM: cifra + iv + tag + versão da chave-mestra — D-F16), metadados públicos (subject, notBefore, notAfter, fingerprint) gravados no upload para o alerta de vencimento sem decifrar |
| `tb_issuer` | `tb_establishment_issuer` (058/060) | `(tb_institution_id, model)` | ambiente H/P; série e `dps_last_number` só fazem sentido no SE (D-F21: 55/65 numeram no ERP) |
| `tb_invoice_service_transmission` | idem (058/059/061) | `(tb_institution_id, tb_invoice_id, terminal, attempt)` | + `dps_number` (o nDPS da tentativa, que hoje mora no ramo do ERP); `invoice_event` = VIDA da nota (D-N27) |
| `tb_invoice_service_transmission_event` | idem (058/060) | `(…, attempt, event)` | append-only; **sem `invoice_event`** (o efeito é fato do ERP — D-F11) |
| controle de migrations | — | — | migrations próprias do `fiscal_api`, aplicadas pelo núcleo sob trava nomeada (duas instâncias sobem juntas) |

VIEWs publicadas para o setes-api (D-F15): `vw_invoice_service_transmission` (tentativa + última voz — o `TX_SELECT` de hoje) e `vw_invoice_service_transmission_event` (vozes). A VIDA vigente (D-N27) e a vigente por chave (D-N26) são aplicadas pelo LEITOR do setes-api, que conhece o `tb_invoice_event` dele.

No ERP (setes-api, migration nova): o vínculo do EFEITO — *candidato* `tb_invoice_fiscal_effect` (nota × modelo × tentativa × evento da voz → evento C local produzido, ou motivo da recusa). Pendência = voz C (view) sem efeito aplicado. Substitui a coluna `invoice_event` da voz.

### 12.4 Serialização entre os dois serviços (D-F15) — candidato F0

> ⚠️ **SUPERADO pela D-F27**: com as APIs fiscais podendo escrever no ERP, a serialização volta a ser o `FOR UPDATE` na linha da nota (`tb_invoice`), como na Onda 3; a trava nomeada abaixo fica como registro.

Hoje transmitir × cancelar local se serializam pelo `FOR UPDATE` na mesma `tb_invoice`. Com GRANT só-leitura de cada lado, a trava comum vira **trava nomeada da instância**: `GET_LOCK('fiscal:<institutionId>:<invoiceId>', 10)` — sem privilégio de escrita na tabela do outro, mesma instância MySQL (D-F9). Regras: (1) toma-se a trava ANTES do `BEGIN` (sob REPEATABLE READ a 1ª leitura fixa o snapshot — regra 2 do PADROES §9) e solta-se DEPOIS do `COMMIT`/`ROLLBACK`; (2) a nfse-api a segura na RESERVA da tentativa (relê vida e último evento da nota no ERP); (3) o setes-api a segura no plano + cancelamento local (relê a vigente nas views); (4) timeout = 409 `RESOURCE_BUSY`, nunca reexecuta (D-A23). Conferir na F0 se o MySQL da SaveInCloud é MariaDB ou MySQL 8 (`GET_LOCK` múltiplo por sessão existe nos dois desde MariaDB 10.0.2 / MySQL 5.7).

### 12.5 Autenticação (D-F13) — candidato F0

setes-api assina o JWT em **RS256** com `kid` (par de chaves fora do repo: `JWT_PRIVATE_KEY_PATH`; a pública vai para a nfse-api por configuração `JWT_PUBLIC_KEY_PATH`, rotação por `kid`); payload inalterado (`institutionId`, `userId`, `role`, `schemaName`). Corte: tokens HS256 antigos deixam de valer (relogin — o app já reloga diário). A nfse-api: valida assinatura + expiração; confere `schemaName` × `setes_central.tb_institution`; licença = interface do ramo contratada (D-F14); privilégio TRANSMITIR/CANCELAR pelo mesmo resolver do setes-api (admin passa — D32). CORS: origens do domínio do Plesk (configuração).

### 12.6 Cofre e XML (D-F16)

Chave-mestra `FISCAL_MASTER_KEY` (32 bytes, base64) por ambiente, fora do repo; AES-256-GCM; `cipher_key_version` permite rotação (reabre com a antiga, regrava com a nova). Senha do PKCS#12 nunca persiste (D-N5). XML: interface `FiscalStorage` (fs no dev, `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mês>` — Q-N38a/Q-TZ7 mantidos); no dev a nfse-api aponta para o MESMO `STORAGE_PATH` do setes-api (os XMLs da Setes ficam onde estão); backend de produção na F3.

### 12.7 Ondas revisadas e esforço (D-F19, D-F20, D-F22, D-F24)

| Onda | Entrega | Esforço (sessões) |
|---|---|---|
| **F0 — desenho** | guardião sobre o modelo §12.3–12.5; DDL do `fiscal_api` + views + script de GRANT (`revisar-ddl`); OpenAPI `v1` da nfse-api (design-first); contrato da fonte de fatos (interface TS); migration do vínculo de efeito no ERP; esqueleto dos 3 projetos | 2–3 |
| **F1 — núcleo + nfse-api** | biblioteca `fiscal-api` (mover/adaptar transporte, assinatura, emissor, máquina tentativa × voz, cofre cifrado, storage, auth RS256, db/erros/log/fuso) + serviço `nfse-api` (rotas `/v1`, OpenAPI servido, health, ADN, DPS, DANFSe, fonte de fatos do serviço); testes migrados + novos; script de migração dos dados da Setes (D-F18); smoke no ADN **H** com o A1 real | 8–11 |
| **F2a — setes-api passivo** | remover as peças fiscais e as 14 rotas; leitor das views (selo da lista, plano de cancelamento, pendências); aplicador do efeito + vínculo; JWT RS256; cerca "zero chamada de saída para as APIs fiscais" (grep); trilha `trilha-primeiro-cliente.ts` como FRONT-END das duas APIs | 3–5 |
| **F2b — setes-app cliente** | datasource dedicado da nfse-api (base URL por `--dart-define`), os 17 arquivos Dart do fiscal + aba "Emissor fiscal" apontando para a nfse-api, lote no cliente, regra canônica nova em `ARQUITETURA_MODULOS.md` | 4–6 |
| **F3 = Onda 4 do produto (D-F19)** | topologia D-F9 na SaveInCloud (MySQL único com usuários/GRANTs por serviço, setes-api, setes-sync, nfse-api, Plesk com o build), HTTPS/DNS, chaves (JWT, mestra) fora do repo, backend do XML, teste de carga contra fisco falso (D-F23), alerta de vencimento de A1 | 6–10 + espera externa |
| **IBS/CBS (D-F22) — fase própria, em paralelo** | motor no setes-api pode começar já; builder do grupo IBS/CBS no DPS entra na nfse-api depois da F1; **marco duro 01/01/2027** | prompt próprio |
| **S2 (D-F24)** | diagnóstico com 1000 schemas sintéticos (setes-api + leitura da nfse-api) | 3–5 (fase própria) |
| **F4/F5** | NF-e / NFC-e na `nfe-api`, só com fato gerador (D-F20/D-E20) | 25–35 / 15–25 |

**Total F0–F3 ≈ 23–35 sessões (5–7 semanas)**. Mais barato que o §11.4 (30–43) porque a leitura direta do banco (D-F10/D-F11) dispensa recibo assinado, federação e webhook; mais caro que mover dentro do mesmo processo porque o app muda (F2b) e nascem três projetos.

**Riscos com data**: (1) o A1 real da Setes **vence em 08/10/2026** — sem renovação não há smoke em H na F1 nem emissão em produção; (2) **01/01/2027** — IBS/CBS na NFS-e da Setes: F0–F2 precisam terminar até meados de novembro para o builder entrar na nfse-api a tempo, ou o builder entra provisoriamente no setes-api (decidir se a F1 atrasar); (3) MySQL da SaveInCloud (MariaDB × MySQL 8) muda detalhes de GRANT/trava — conferir na F0.

### 12.8 Critérios de sucesso revistos (substituem §10 onde conflitarem)

1. `nfse-api` sobe com `fiscal_api` + migrations próprias; `/v1/health` prova banco, chave-mestra (decifra um vetor de teste) e storage; OpenAPI em `/docs`; **nenhum `tb_invoice`/`tb_order`/`tb_entity*` FORA da fonte de fatos** (cerca por teste).
2. Usuário MySQL da nfse-api só com SELECT em `setes_central`/`setes_*`: um `INSERT` no ERP pela conexão dela falha (prova de GRANT, D-F15); usuário do setes-api lê as views e não lê as tabelas internas.
3. Token do setes-api (RS256) aceito pela nfse-api; token adulterado/expirado/HS256 → 401; usuário sem TRANSMITIR → 403; institution sem a interface do ramo → 403.
4. `POST /v1/nfse/invoices/{id}/transmit` → 201 A no ADN H com a chave; replay → 409 "já autorizada" (nunca 2ª NFS-e); DPS rejeitado → 422 com E0xxx; timeout → em voo e o refresh reconcilia por `dps_id`.
5. Cancelamento: app → nfse-api `cancel` (voz C) → setes-api `POST /api/billing/cancel` lê a voz C na view e aplica o C local + vínculo do efeito; recusa local = pendência visível e reaplicável; nota sem tentativa cancela local sem tocar a nfse-api; transmitir × cancelar concorrentes (6 de cada) → zero 500, nenhum C local com tentativa viva.
6. Migração da Setes (D-F18): emissor, tentativas, vozes e A1 no `fiscal_api`; DANFSe da nº 704 igual; trilha P8 OK; nada reemitido.
7. setes-api sem nenhuma chamada HTTP para as APIs fiscais (cerca por grep em `src/`); setes-app fala com a nfse-api só pelo datasource dedicado.
8. Gates por onda: socrático ≥ 0,70 · adversarial sem HIGH/CRITICAL; achado confirmado vira teste.
9. Carga (F3, D-F23): 2 instâncias da nfse-api, fisco falso, p95 < 5 s fora do fisco, zero 500, zero documento duplicado.

---

## 13. Parecer do guardião sobre o modelo da F0 (setes-conceito, 2026-10-03) — Rodada 3

> Avaliou o §12.3–12.6 DENTRO das D-F1…D-F26. Fatos que ele citou foram conferidos no código e no banco do dev antes de entrar aqui (§13.3). Os pontos de decisão viraram Q-F35…Q-F43 no §8.

### 13.1 Veredito por item

| # | Item do candidato | Veredito | Por quê (resumo) |
|---|---|---|---|
| 1 | manter `tb_invoice_service_transmission(_event)` no `fiscal_api` | **fiel** | `tb_fiscal_document` só existia para consumidor estrangeiro com `external_code` — morreu com D-F10/F14/F25; seria uma 3ª identidade para (nota, vida, modelo). Conjugada = dois ramos = duas famílias de tabela (backbone `tb_invoice` no ERP × `tb_invoice_<ramo>_transmission` no `fiscal_api`). Ajuste: a máquina do núcleo recebe o REPOSITÓRIO da família (`transmission.repository.ts:13-15` já prevê) |
| 2 | nDPS na tentativa com regra de cópia | **maquete** | fato da VIDA repetido em N linhas + regra para não se contradizer; a 059 teve de derrubar a UNIQUE `(inst, dps_id)`. Armadilhas: `LIFE_WHERE` mostra tentativa sem vida em TODA vida (`transmission.repository.ts:98-102`) → herdaria o nDPS de vida cancelada (mesmo Id → fisco ecoa a NFS-e cancelada, Q-N33); a série é RELIDA a cada reserva (`invoice-transmission.ts:193/203`) → trocar a série no meio da vida muda o Id. Peça proposta: **`tb_invoice_service_dps`** — o DPS de UMA vida (PK nota × terminal × `life_event`; série + nDPS + `dps_id` write-once; UNIQUE `(inst, dps_id)` volta; contador segue no emissor) — D-N3/D-N18 por CONSTRUÇÃO |
| 3 | vínculo do efeito `tb_invoice_fiscal_effect` | **ajuste — provavelmente não entra** | no máximo UMA voz C por nota × vida × modelo (HIGH-3a + D-N26) → vínculo DERIVÁVEL: pendência = voz C na vida vigente com a nota ainda não-C; idempotência = "a nota já é C" (`applyCancelEffect` já faz). Motivo de recusa gravado é estado em cache (envelhece quando a baixa é estornada) — recalcular pelo plano. Colunas de causa no `tb_invoice_event` não servem à conjugada (duas vozes C → um C local) |
| 4 | efeito sem humano | decisão | hoje NÃO há worker: o refresh é `POST` de quem abre a tela e aplica o efeito na mesma requisição. Tradução fiel = saga do app (quem recebe a voz C da nfse-api pede ao setes-api) + job interno como rede de segurança (não é chamada de saída; produz FATO do ERP, não copia estado). GET com efeito colateral: nunca |
| 5 | trava nomeada `GET_LOCK` | **fiel com 3 ajustes** | (a) construção, não disciplina: `cancelInvoice` confere `IS_USED_LOCK(nome) = CONNECTION_ID()` (três produtores de C local: `billing.service.ts:864` + os dois caminhos fiscais); pedir a trava no MEIO de transação que já segura linhas = espera cruzada InnoDB × trava nomeada que nenhum detector vê; (b) a VOZ que vira final → autorizada (A por consulta depois de R/F) também toma a trava; (c) duas pré-condições que o ERP verificava sozinho saem de casa — plano local ANTES do pedido ao fisco (`:596-598`) e a reconfirmação Q-ADV1b (`:298-331`): se o setes-api só confiar que o app reconfirmou, é "o ERP acredita no app" (maquete do §11.6). Detalhes: `terminal` no nome da trava; virar regra 8 do PADROES §9 |
| 6 | views como contrato | **fiel — não é cache** | fonte lida na hora, no mesmo snapshot, sob a trava. Riscos: (i) POLÍTICA em dois códigos — a vigente (`currentOf`, `:236-240`) e a vida (D-N27) na nfse-api (decide transmitir) e no setes-api (decide cancelar); (ii) view com `ROW_NUMBER`/`GROUP BY` não funde e vira temporária — com 1000 clientes, varredura |
| 7 | fonte de fatos | **fiel para FATOS; ajuste para POLÍTICAS** | o núcleo fica cego se a cerca for teste; privilégio é leitura do ERP → adaptador Gestão 2027, mas como porta própria (núcleo define `facts` × `grants`). Problema é o CONTEÚDO: `resolveOrderInterface` (ciclo da OS, âncora da devolução, D-A31), "admin passa" (D32), vida, fuso por config e a matriz do Anexo I (Q-N36 também a aplica no save do estabelecimento) são POLÍTICAS que o setes-api segue usando — copiar = duas verdades |
| 8 | palavras | ajustes | `tb_emitter` → **`tb_establishment_certificate`** ("emitente" já é o `prest` ocupado e convida a guardar fatos do emitente que a D-F10 manda ler do ERP; o conceito é o A1 — D-N31; o `cnpj` é o do CN, fato do certificado) · `tb_issuer` → **manter `tb_establishment_issuer`** (renomear contraria "muda de casa, não de conceito" e piora a colisão com `tb_invoice.issuer`) · "efeito" = fato LOCAL que a voz do terceiro produz no ERP (registrar) · "fonte de fatos" ok em prosa; no código `erp-facts` (`source` já é a coluna P/Q da voz) · **"vida"** = intervalo entre um E e o C seguinte — coluna `life_event` (hoje `invoice_event` significa VIDA na tentativa (061) e EFEITO na voz (058)) |

### 13.2 O que NÃO entra / onde vira maquete (do parecer)

NÃO entra: `tb_fiscal_document`, `tb_licensee`, fatos do emitente no `fiscal_api`, `dps_number` na tentativa, motivo de recusa persistido, coluna de status/"última voz", FK entre bancos, DDL de família no núcleo, `tb_invoice_service.dps_number` depois da migração, `Map` de controle em memória.
Vira maquete: (1) nDPS copiado entre tentativas · (2) política do ERP copiada na nfse-api · (3) `currentOf` em dois códigos · (4) efeito com tabela/motivo gravado · (5) trava nomeada só por disciplina · (6) ERP aceitando cancelamento local sem prova legível da reconfirmação · (7) nfse-api reimplementando o plano de cancelamento · (8) certificado crescendo com fatos do emitente.

### 13.3 Conferência dos fatos citados (2026-10-03)

- `invoice.ts:251` — o revive zera `dps_number` (nova vida = novo nDPS) ✔ · `billing.service.ts:857` — `reconfirmBeforeLocalCancel` roda ANTES do `cancelInvoice` ✔ · `invoice-transmission.ts:193/203` — a série vem do emissor relido a cada reserva ✔.
- Banco do dev (`setes_setes`, MariaDB 10.4.20): 19 tentativas / 21 vozes / 3 notas — 7971 (1 tentativa, P, com chave), 8005 (1, H, sem chave), **8011 (17 tentativas, TODAS com o mesmo Id de DPS, 13 em H e 4 em P, chave na 17ª)** — a vida já atravessa o ambiente com o mesmo nDPS (prova viva do item 2). **19/19 tentativas têm vida (`invoice_event` = 1)** → a Q-F36 do guardião (tentativas sem vida na migração) **não tem objeto no dado real**: a coluna nasce NOT NULL e o script de migração FALHA ALTO se achar NULL. `setes_ws` não tem as tabelas fiscais (nada a migrar).

---

## 14. Modelo final da F0 (pós-Rodada 3, 2026-10-04) — VIGENTE

> Substitui §12.3–§12.5 onde conflitar. Decisões: D-F27…D-F35 sobre as D-F1…D-F26.

### 14.1 Quem é dono de quê

| Banco / schema | Dono (DDL) | O que tem | Quem lê | Quem escreve |
|---|---|---|---|---|
| `fiscal_api` — comum | núcleo `fiscal-api` (D-F35) | `_migrations` (com namespace), `tb_establishment_certificate`, `tb_establishment_issuer` | nfse-api, nfe-api | nfse-api, nfe-api |
| `fiscal_api` — família NFS-e | `nfse-api` (D-F35) | `tb_invoice_service_dps` (D-F30), `tb_invoice_service_transmission`, `tb_invoice_service_transmission_event` + VIEWs `vw_invoice_service_dps`, `vw_invoice_service_transmission`, `vw_invoice_service_transmission_event` | nfse-api; setes-api SÓ pelas VIEWs (D-F15) | nfse-api |
| `setes_<cliente>` — políticas | setes-api (D-F32) | VIEWs `vw_order_interface` (interface do ramo por pedido) e `vw_invoice_life` (vida vigente da nota) | setes-api E nfse-api | — (views) |
| `setes_<cliente>` / `setes_central` — fatos | setes-api / sync | nota, ramo congelado, cadeia, `tb_entity_tax`, configs, privilégios | nfse-api pela fonte de fatos `erp-facts` (D-F10) | setes-api; a nfse-api SÓ trava a linha da nota (D-F31) |

### 14.2 Serialização (D-F27)

Volta o protocolo da Onda 3: **`SELECT … FOR UPDATE` na linha da nota (`setes_<cliente>.tb_invoice`)** dentro da transação de quem decide — a nfse-api na reserva da tentativa (e nas vozes que gravam sob a nota, como hoje), o setes-api no plano + cancelamento local. A transação da nfse-api usa UMA conexão que cruza `setes_<cliente>` e `fiscal_api` (mesma instância — D-F9). Ordem de locks: institution (contador) → nota → emissor → DPS da vida → tentativa. A trava nomeada do §12.4 morreu.

### 14.3 Cancelamento (D-F28/D-F29/D-F11)

```
app → setes-api   GET  plano de cancelamento (consultivo)                 bloqueios locais? → para aqui
app → nfse-api    POST /v1/nfse/invoices/{id}/reconfirm   (só se a vigente é F por consulta em P — Q-ADV1b)
app → nfse-api    POST /v1/nfse/invoices/{id}/cancel      → ok (voz C gravada) | não ok (o app NÃO avança)
app → setes-api   POST /api/billing/cancel                → lê a voz C na view (FOR UPDATE na nota) → C local
```
Sem vínculo gravado: pendência = voz C na vida vigente × nota ainda não-C (derivada, nas duas telas). Sem job: voz C sem humano fica pendente e visível até o próximo contato do app. Nota sem tentativa / R / F conclusivo → o app vai direto ao setes-api.

### 14.4 O que muda na F1/F2 por causa da Rodada 3

- F1 (nfse-api): `tb_invoice_service_dps` substitui `lockDpsNumber`/`setDpsNumber` (ERP) e a cópia do nDPS; a fonte de fatos lê a vida e a interface do ramo pelas VIEWs do ERP (D-F32); a máquina da voz vem da biblioteca, com o repositório da família injetado (§13.1-1); a lista do que a nfse-api escreve no ERP é testada (D-F31 — hoje: nada, só `FOR UPDATE`).
- F2a (setes-api): migration das VIEWs de política (D-F32) + `resolveOrderInterface`/vida passam a ler delas; dependência da biblioteca `fiscal-api` para o contrato de leitura (D-F33); `buildCancelPlan.fiscal` lê a vigente pelas views do `fiscal_api` + exige a prova da reconfirmação (D-F29); `tb_invoice_service.dps_number` aposentado.

### 14.5 DDL da F0 — revisado (`revisar-ddl`) e provado (2026-10-04)

| Arquivo | Dono (D-F35) | Conteúdo | Estado |
|---|---|---|---|
| `fiscal-api/src/migrations/sql/001_core_baseline.sql` | núcleo | `tb_establishment_certificate`, `tb_establishment_issuer` | escrito; aplica na F1 (o executor do núcleo cria `fiscal_api` e `_migrations` com namespace) |
| `nfse-api/src/migrations/sql/001_nfse_baseline.sql` | família NFS-e | `tb_invoice_service_dps`, `tb_invoice_service_transmission`, `tb_invoice_service_transmission_event` + `vw_invoice_service_transmission`, `vw_invoice_service_transmission_event` | escrito; aplica na F1 |
| `setes-api/src/migrations/sql/065_fiscal_policy_views.sql` + espelho no `sql/03` | setes-api | `vw_order_interface`, `vw_invoice_life` (D-F32) | **APLICADA no dev** (`setes_setes`, 2026-10-04) |

Prova: (1) sqlglot OK nos três (o `sql/03` inteiro já falhava ANTES desta mudança — `ADD KEY IF NOT EXISTS` do MariaDB, fora do sqlglot); (2) banco DESCARTÁVEL `fiscal_api_f0probe` no MariaDB 10.4.20 do dev: duas passadas (re-executável), carga com o dado REAL da Setes (3 DPS · 19 tentativas · 21 vozes), última voz da view × `TX_SELECT` de hoje = **0 divergências**, `EXPLAIN` fundido (acesso por chave), UNIQUE `(institution, dps_id)` → `ER_DUP_ENTRY`, FK tentativa → DPS da vida → `ER_NO_REFERENCED_ROW_2`; banco apagado ao fim; (3) views de política contra a lógica de hoje: **0 divergências** em 7.947 pedidos (`resolveOrderInterface`) e 7.430 notas (`LAST_INVOICE_EVENT_KIND_SQL` / MAX(E)), sem linha duplicada, `EXPLAIN` fundido (const pela PK).

Checklist: PK/FK em colunas existentes ✔ · padrões `tb_`/inglês/singular ✔ · `created_at`/`updated_at`/`deleted` ✔ · sem AUTO_INCREMENT (chaves naturais) ✔ · `DEFAULT NULL` real ✔ · base certa (`fiscal_api` — D-F7; políticas no schema do cliente — D-F32) ✔ · sem FK entre bancos (decisão) ✔ · nenhum JOIN por VARCHAR entre collations ✔ · re-executável ✔ · ordem de dependência ✔ · sem seed com dado sensível ✔ · `dps_id` 45 posições (DPS + cMun 7 + tpInsc 1 + CNPJ 14 + série 5 + nDPS 15) ✔.
Para a F1: a conexão do núcleo fixa `time_zone '+00:00'` e REPEATABLE READ (PADROES §9/§10 — instantes UTC); ordem de locks institution → nota (ERP) → emissor → DPS → tentativa; na migração D-F18 a série sai do próprio Id (`SUBSTRING(dps_id, 26, 5)`) e o nDPS dos 15 finais.

---

## 15. Execução da F1 — núcleo `fiscal-api` + serviço `nfse-api` (2026-10-04)

> Código entregue nas pastas da D-F17; decisões citadas nos comentários do código. Gates em §15.4.

### 15.1 O que nasceu

| Onde | O quê | Origem / decisão |
|---|---|---|
| `fiscal-api/src/db/` | pool com REPEATABLE READ + UTC por conexão e conferência no boot; `withTransaction` com retry de deadlock; `assertSchema`; executor de migrations com namespace `(project, version)` + `GET_LOCK` | PADROES §9/§10; D-F35 |
| `fiscal-api/src/auth/product-jwt.ts` | verificação RS256 só com chave PÚBLICA (rotação por `kid`; HS256 recusado por construção); `isAdmin`/`isSuper` iguais ao setes-api; middleware com conferência da identidade no banco | D-F13 |
| `fiscal-api/src/secret/` | `MasterKeyRing` (AES-256-GCM, versão, AAD = linha); certificado A1 (PKCS#12 → folha, validação do par, e-CNPJ do PRÓPRIO emitente) | D-F16; D-N5/D-N29 |
| `fiscal-api/src/establishment/` | `tb_establishment_certificate` + `tb_establishment_issuer` no `fiscal_api`; `openIssuer` (409s na ordem; decifra só na chamada); `nextDpsNumber` | D-F34; D-N18/D-N31 |
| `fiscal-api/src/transport/` | `https-json` (mTLS, tradução de falhas, `afterHandshake`) e `xmldsig` — MOVIDOS sem mudança | Onda 3 |
| `fiscal-api/src/storage/` | `FiscalStorage` + `FsFiscalStorage` (layout `<cnpj>/<H|P>/<ano>/<mês>`, mês da zona, tmp+rename) | D-F16; Q-N38a/Q-TZ7 |
| `fiscal-api/src/voice/` | vocabulário da voz + CONTRATO DE LEITURA (tipos das views, `currentOf`, `fiscalStateOf`, `localCancelPending`, `reconfirmationCandidate`/`Proven`) — o mesmo que o setes-api vai importar | D-F33; D-F28/D-F29 |
| `fiscal-api/src/erp/facts.ts` | fonte de fatos BASE (D-F10): políticas pelas views da 065 (D-F32), privilégio/licença, fuso, cadeia de entidade, `tb_entity_tax`, IBGE, CNPJ do estabelecimento e a TRAVA da nota (`FOR UPDATE` + `LOCK IN SHARE MODE` no último evento + vida) | D-F10/D-F27/D-F31 |
| `nfse-api/src/authority/` | dialeto ADN + montagem do DPS/evento — MOVIDOS (só imports) | Onda 3 |
| `nfse-api/src/facts/service-facts.ts` | fonte de fatos do ramo de serviço (`readServiceInvoice`, `buildEmitter`, `buildRecipient`, `buildDpsBase`, `emitterDpsFacts`, pendentes) — sem `dps_number` do ERP | D-F10/D-F30 |
| `nfse-api/src/nfse/` | repositório da família (DPS da vida, tentativa, voz; nenhuma referência ao ERP — a vida chega por parâmetro) + COMPOSIÇÃO `transmission.ts` (transmitir, consultar, reconfirmar com PROVA, cancelar no fisco em linha com RESERVA K, rodízio por ALUGUEL na linha da habilitação — gates, §15.4 —, tela, XML, DANFSe) | D-F27…D-F30; Onda 3 |
| `nfse-api/src/modules/` + `app.ts` | `/v1/emitter` (admin) e `/v1/nfse` (privilégio do RAMO pela view `vw_order_interface`; leitura = interface contratada), `/v1/health`, `/docs` + `/v1/openapi.yaml` (design-first), CORS por lista, envelope de erro da casa | D-F8/D-F13/D-F14 |
| `nfse-api/scripts/` | `migrate.ts` · `migrate-from-setes-api.ts` (migração única + RE-SINCRONIA até a virada) · `mint-dev-token.ts` (só dev até a F2a) | D-F18 |
| `nfse-api/ops/grants.sql` | GRANTs de produção + nota MariaDB × MySQL 8 sobre leitura travante | D-F15/D-F31 |
| `setes-api` migration **065** + espelho no `sql/03` | `vw_order_interface`, `vw_invoice_life` — APLICADA no dev | D-F32 |

### 15.2 Provas

- **Testes**: `fiscal-api` 23 (cofre/AAD/rotação, PKCS#12 real, `openIssuer` sobre banco falso, contrato de leitura, JWT inclusive confusão RS256→HS256, storage, corte de migrations, CERCAS do núcleo cego e de `Map/Set`) · `nfse-api` 65 (23 de transporte/ADN PORTADOS sem mudança + 3 DANFSe + 28 da composição + 11 da borda HTTP com a cerca OpenAPI × rotas e a cerca "tabela do ERP só em `src/facts/`").
- **Banco real (MariaDB 10.4.20 do dev)**: usuário `fiscal_api` com SELECT no ERP — `FOR UPDATE` e `LOCK IN SHARE MODE` PASSAM, `INSERT` no ERP → `ER_TABLEACCESS_DENIED_ERROR` (critério §12.8-2 provado); migrations do `fiscal_api` aplicadas e idempotentes.
- **Migração D-F18** (`migrate:setes`, ensaio + real + 2ª passada sem efeito): 1 habilitação (SE em **P**), A1 cifrado (CNPJ 07742094000113, **vence 08/10/2026**), 3 DPS de vida, 19 tentativas, 21 vozes, todos os XMLs achados pelo storage da nfse-api (mesmo `STORAGE_PATH`).
- **Ao vivo (nfse-api :3002, sem tocar o fisco)**: `/v1/health` 200 (banco, chave-mestra, storage); emitente com o A1 decifrando; nota 8011 = **NFS-e 704** cancelada (17 tentativas, chave na 17ª — igual ao setes-api), 7971 = 705 cancelada, 8005 = falha em H; XML da 704 e DANFSe servidos; lista de pendentes; transmitir nota cancelada → 409 sem fisco; token HS256 atual do setes-api → 401 (esperado até a F2a); CORS só para a origem da lista.

### 15.3 Correções de rumo feitas na execução (sem decisão nova — "corrigir", não "decidir")

1. **Rodízio sem voz C**: a consulta ativa revisitava C a cada 15 min para retentar o efeito local; com a D-F28 o efeito é do setes-api — C saiu do rodízio.
2. **Pendentes do lote** só listam nota com evento E na web (`last_kind = 'E'`): a nota sincronizada da origem aparecia como pendente e sempre falhava com 409.
3. **Trava da nota = `FOR UPDATE` na `tb_invoice` + `LOCK IN SHARE MODE` no último evento** (leitura travante compartilhada, regra 2 do PADROES §9 — sem trava exclusiva em linha de evento do ERP); a vida vem na mesma leitura e todo `FOR UPDATE` do repositório da família recebe a vida por parâmetro (nunca junção com o ERP).
4. **Migração = re-sincronia até a virada**: enquanto o setes-api for o caminho de produção, a origem vence nos campos mutáveis (contador por GREATEST, chave/número por COALESCE, A1 renovado = fingerprint diferente → recifra), vozes só acrescentam, DPS da vida é write-once. ⚠️ Rodar de novo NA VIRADA (F2a), com o caminho antigo parado.
5. **Mensagem de erro sem nome de tabela** (`INVOICE_SERVICE_BRANCH_MISSING`).

### 15.4 Gates da F1 (2026-10-04)

**Rodada 1 (código como entregue no §15.1): socrático 0.62 ✗ · adversarial 0.58 ✗.**
- HIGH: (1) vida que atravessa H→P — o titular do Id do DPS e o "minter" da reconfirmação ignoravam o AMBIENTE: a chave de
  PRODUÇÃO pousava na tentativa de HOMOLOGAÇÃO (forma real da 704 e da 8005) e o cancelamento ia ao host de H; (2) rodízio
  filtrava a vida vigente em JS DEPOIS do LIMIT — linhas descartadas presas no topo, rodízio parava em silêncio; (3) o rodízio
  segurava a conexão do `GET_LOCK` e pedia outra ao pool — N passadas × pool de N = serviço travado para sempre; (4) nada
  impedia a nfse-api de emitir pela institution que o setes-api ainda emite (D-F18 "sem dual-write").
- MEDIUM: `FOR UPDATE` redundante sob a trava da nota (gap lock antes do contador → deadlock entre notas vizinhas, provado
  com 6 notas em paralelo); dois "Cancelar NFS-e" simultâneos = dois e101101 (o 2º voltava "recusado" com a NFS-e já
  cancelada); corrida resposta direta × rodízio pousando a mesma chave; licença (D-F14) não conferida nas AÇÕES do
  usuário comum; lote de pendentes sem paginação, preso na cabeça e listando voz C.
- LOW: 404 para nota inexistente; caractere de controle no motivo; CNPJ do estabelecimento inválido aceitava qualquer A1;
  DELETE do A1 com transmissão viva; health não via versão de chave-mestra faltando.

**Retrabalho 1 (todos corrigidos na sessão, cada achado virou teste):** titular/minter por ambiente + `findKeyHolder`;
candidatas filtradas inteiras no SQL (join com `vw_invoice_life`, vivas antes de autorizadas); ALUGUEL `refresh_lease_until`
(migration **002** do núcleo — UPDATE atômico, 60 s); cerca `FISCAL_LEGACY_INSTITUTIONS` (ações e escritas do emitente →
409 `FISCAL_CUTOVER_PENDING`; `migrate:setes` só para a cerca e FALHA ALTO em dual-write — tentativa/DPS/voz que a origem
não tem); leituras não travantes sob a trava da nota; RESERVA K antes do fisco (recusa/preparo local/credencial → N;
ambíguo → o K fica); reservada que perde a corrida fecha com F "envio reconciliado"; licença nas ações (admin → Q-F46);
pendentes paginados (`page`/`pageSize`, envelope da casa) só dos ramos visíveis e sem A/N/S/K/C; o resto dos LOW.
Achado NOVO do ataque ao vivo nesse retrabalho: K → N → K na mesma tentativa dentro do mesmo segundo colidia na UNIQUE
`(…, kind, dh)` → 500 — **K e o N de liberação são fatos NOSSOS e vão com `dh` NULL** (a UNIQUE é a idempotência da voz
do fisco). Contrato: o YAML dizia `localEffectPending` (o código devolve `localCancelPending`) e não tinha `atAuthority`.

**Rodada 2: socrático 0.75 ✅ · adversarial 0.60 ✗ (nenhum HIGH em nenhum dos dois).**
- Socrático: as 8 correções conferidas no código (arquivo:linha). MEDIUM: cerca por variável de ambiente libera tudo quando
  falta ou vem mal escrita → **Q-F48**; aluguel devolvido sem conferir o dono; custo das leituras que crescem com o
  histórico → **Q-F49**. LOW: `FOR UPDATE` restante na consulta/voz C; vigente em duas cópias (SQL × `currentOf`) sem teste;
  texto técnico na voz N; relatório da passada com ids de ramo não contratado; `skipped` enganoso.
- Adversarial (testes `adversarial-f1r2*.ts`): MEDIUM **DELETE do A1 × reserva em curso** — a 1ª leitura não travante da
  reserva criava o snapshot do REPEATABLE READ ANTES da trava da habilitação; a reserva que esperava o DELETE acordava,
  lia o A1 do snapshot e assinava com o certificado já apagado (provado: 1 tentativa e 1 envio ao fisco depois do DELETE);
  MEDIUM cerca mal escrita (`"1;7"`) virava conjunto vazio = cerca aberta, sem log; LOW aluguel sem dono (provado: A apaga o
  aluguel de B e C roda junto), passada sem habilitação respondia `skipped`, erro técnico cru no 200 sem `logger.error`, 6
  status devolvidos fora do YAML e `reconfirm` sem schema.

**Retrabalho 2 (corrigidos na sessão; os `it.failing` do QA viraram `it`):** na reserva, emissor `FOR UPDATE` + A1 `LOCK IN
SHARE MODE` logo depois da trava da nota e ANTES de qualquer leitura não travante (`openIssuer` com `forUpdate` lê o A1
ATUAL); `legacyFromEnv` ESTRITO (item mal escrito impede o boot) + cerca no log de boot; aluguel com TOKEN do dono
(`acquireRefreshLease` devolve o `refresh_lease_until` gravado; `releaseRefreshLease(…, token)` só apaga o próprio); passada
sem habilitação → 409 `FISCAL_ISSUER_MISSING`; erro técnico da passada → `Erro interno (ref X)` + `logger.error` com o mesmo
ref; voz N sem texto técnico; YAML com os status reais + `ReconfirmResult`; `FOR UPDATE` restante sob a trava da nota
removido; teste ao vivo de equivalência "vigente do SQL = `currentOf`" (9 vidas reais, inclusive a 704 — zero divergência).

**Re-prova adversarial (Rodada 3 — delta do retrabalho 2): 0.80 ✅ — nenhum HIGH/CRITICAL/MEDIUM.** Provado ao vivo
(`adversarial-f1r3.live.test.ts`): troca do A1 × reserva em curso → a reserva assina com o A1 NOVO; troca P→H × reserva → tudo
em H; exclusão da habilitação × reserva → 409 sem reservar; cancelamento LOCAL do setes-api segurando a nota não prende o
emitente (PUT habilitação 40 ms, aluguel 10 ms); lote de 12 notas já autorizadas em 299 ms (todas 409, contador intacto);
estresse misto (5 notas + escritores do emitente + aluguel) com zero 500/RESOURCE_BUSY/deadlock e nDPS contíguos; nenhum
ciclo na ordem nota → emissor → A1 (S) → DPS → tentativa. 4 LOW, **corrigidos na sessão** (viraram `it`): cerca feita só de
separadores (`","`) abria — agora falha o boot; status reais da CONSULTA (reconfirm 422/502, refresh 422) + 413/415 + teto do
`page` no YAML; corpo com charset/encoding não suportado virava 500 com ref sem token — agora 415 `UNSUPPORTED_MEDIA_TYPE` no
envelope (e qualquer 4xx do parser com o status dele); contenção numa nota da passada vira `RESOURCE_BUSY` (warn), não
"erro interno".
**Fechamento dos gates da F1: socrático 0.75 ✅ · adversarial 0.80 ✅** (o único `it.failing` restante é a Q-F46).

**Provas finais:** `fiscal-api` 29/29 · `nfse-api` 102 + 45 ao vivo (3 suítes: banco real do dev + fisco FALSO + transporte
bloqueado), zero 500 · `fiscal_api` IDÊNTICO à origem depois de cada ataque (19 tentativas, 21 vozes, A1 com o mesmo
fingerprint, aluguel nulo, nenhuma linha marcada pelos ataques; `migrate:setes` sem divergência). Nada falou com o fisco
real; nada commitado.

**Assunções tomadas nos retrabalhos ("corrigir, não decidir" — confirmar na Rodada 4 junto com as Q-F45…Q-F49):**
A1 reserva K antes do fisco, N na recusa/preparo/credencial, K/N com `dh` NULL · A2 cerca da virada por variável ESTRITA,
ausente = nenhuma (implementa a D-F18 até a Q-F48) · A3 re-sincronia: o A1 de `not_after` mais novo vence; dual-write = falha
alta · A4 pendentes paginados, sem C e só dos ramos visíveis (nenhum ramo = lista vazia, não 403) · A5 titular da chave
procurado no ambiente da tentativa · A6 passada sem habilitação = 409 · A7 `/v1/health` é READINESS (503 quando falta no anel
uma versão de chave que cifra A1 vivo) — não usar como liveness na SaveInCloud (derrubaria todos os tenants).

**Resíduo conhecido (não reprovou; registrado para a F2/F3):** a passada é manutenção da institution — consulta notas de ramo
não contratado e devolve os ids delas no relatório (LOW, D-F14 em leitura); K preso se o fisco responder 404 ao GET da chave
antes da carência (analisado); o cancelamento passa por `buildEmitter` (exige `opSimpNac`) — cadastro tributário limpo depois
da emissão bloqueia o cancelamento no fisco (422 + N); `migrate:setes` compara a voz só por kind e confere XML com zona fixa;
leitura de institution na cerca serve CÓPIA até o próximo `migrate:setes` (risco só se o app ler a nfse-api antes da F2b); a
reserva agora trava o emissor antes de responder 409 "já autorizada" (serializa a institution por milissegundos no lote);
Q-N28b da Onda 3 (recusa "já cancelada" grava N e devolve 409 até a consulta trazer o C). Da re-prova (analisados, não
provados): sessão sem `SET time_zone` numa conexão nova desloca o aluguel (o boot confere uma conexão só); a futura nfe-api
apagando o A1 compartilhado precisa da MESMA guarda de transmissão viva (D-N31 — guarda de todas as famílias); leitura travante
da `vw_invoice_life` pode segurar por milissegundos o evento E da próxima nota faturada (medir na F2a); prova da reconfirmação
no mesmo segundo do F é recusada pelo setes-api (fail-closed, só UX); habilitação migrada com série NULL × YAML `serie`
não-nullable.

### 15.5 Pendências para fechar a F1 e abrir a F2

1. **Smoke no ADN de HOMOLOGAÇÃO com o A1 real** (critério §12.8-4) — fala com o fisco (sandbox): QUANDO e COMO = **Q-F45**; depois da escolha, **"vai" do Valdo**; e o A1 vence em **08/10/2026**.
2. **Dual-run até a virada**: o setes-api continua transmitindo em produção; a nfse-api NÃO emite por estabelecimento cuja habilitação é RÉPLICA (`cutover_at` NULL — D-F39; 409 `FISCAL_CUTOVER_PENDING`, recusado também no núcleo). A virada (F2a) = parar o caminho antigo → `npm run migrate:setes -- --cutover <id> --confirmo-setes-api-parado` (re-sincronia final + `cutover_at` na MESMA transação; falha alto em dual-write ou transmissão viva na origem; Q-F50 decide se aposenta a habilitação SE do ERP no mesmo ato) → setes-api passa a ler as views e a assinar RS256 → app (F2b) aponta para a nfse-api.
3. **F2a (setes-api passivo)**: RS256 + par de chaves (o de dev já está em `setes-api/secrets/jwt/`, fora do git), leitor das views pela biblioteca (D-F33) com leitura travante, `buildCancelPlan.fiscal` + prova da reconfirmação (D-F29), selo da lista, `resolveOrderInterface`/vida lendo as views da 065 (D-F32), remoção das 14 rotas e peças fiscais, cerca "zero chamada às APIs fiscais".
4. **Repos GitHub** `valdosouza/gestao-2027-fiscal-api` e `-nfse-api` (e `-nfe-api`) — criar (Valdo); hoje git local.


## 16. Execução da Rodada 4 (D-F36…D-F40 — Valdo: "siga as recomendações", 2026-10-04)

### 16.1 O que foi feito

| Decisão | Execução | Prova |
|---|---|---|
| **D-F37** licença para todos | DADO acertado antes da regra: `setes_setes.tb_institution_has_interface` ganhou `service-orders` (interface 20) para a institution 1 — ela emitia 344 OS sem a interface no contrato. Guardas (`nfse-api/src/modules/guards.ts`): a licença é conferida antes do privilégio, para TODOS; o admin passa só o privilégio; pendentes do admin só dos ramos contratados. **F2a**: o setes-api passa a fazer o mesmo. | unit (admin sem ramo → 403 em ação e leitura; com ramo → 201) + ao vivo (o admin transmite a OS porque o ramo é contratado) |
| **D-F38** teto do rodízio | `listRefreshCandidates` com `COALESCE(dh_proc, created_at) >= NOW() - teto`; teto = `cancelDaysOf` (PAM do município do emitente, cache 1 h, no ambiente da habilitação) + 30; qualquer falha → 60 + 30 (nunca bloqueia a passada). A consulta manual da nota continua. | unit (PAM 45 → 75 dias; A1 vencido → 90) + ao vivo (SQL real) |
| **D-F39** cerca = fato | Parecer do guardião (§16.2) → migration **003** do núcleo `cutover_at` (aplicada no dev: institution 1 = RÉPLICA, o estado da cerca anterior; nenhum UPDATE); `openIssuer` recusa réplica (toda conversa com o fisco passa por ele); `nextDpsNumber` e `acquireRefreshLease` com a condição NO comando; habilitação criada pela API nasce virada (revive/ON DUPLICATE nunca toca); predicado `emissionStillInErp` (réplica viva ou excluída · ou, sem linha, habilitação SE do ERP viva ou excluída — `erp.erpServiceIssuerExists`, tolera a tabela ausente depois da F2a); `requireCutover` lê o fato; `FISCAL_LEGACY_INSTITUTIONS` APOSENTADA (definida = boot falha). `migrate:setes`: escopo pelo dado (toda institution com habilitação SE no ERP), virada = CONGELADA (`assertFrozen`: origem com tentativa nova ou contador além do da API → falha alta), ato `--cutover <id> --confirmo-setes-api-parado` (trava a habilitação do ERP como 1º comando, depois o `fiscal_api`; recusa transmissão viva na origem; re-sincroniza; vira TODAS as linhas da institution). | núcleo 32/32 (réplica não abre/cunha/aluga; predicado nos 5 casos) · ensaio `--cutover 1 … --dry-run` = 1 linha virada e desfeita · sem a flag → recusa · as 3 suítes ao vivo viram a habilitação só durante o ataque (CHECKSUM idêntico, institution 1 volta réplica) |
| **D-F40** custo como critério | Critério registrado (p95 < 300 ms com 200 mil notas, F3/S2) + `nfse-api/scripts/explain-leituras.ts` (`npm run explain:leituras`; EXPLAIN de view exige `SHOW VIEW` — usuário de diagnóstico em `EXPLAIN_DB_USER`, o do serviço NÃO ganha o privilégio). Hoje: nenhuma subconsulta dependente varre por linha; pendentes ~14 ms e rodízio ~2 ms no dev; a tabela que dirige a página de pendentes é a de EVENTOS da nota com `filesort` — o ponto a medir com volume. | script contra o dev |
| **D-F36** smoke H antes da virada | Por causa do write-once (D-F39), o smoke NÃO vira a habilitação real: `nfse-api/scripts/smoke-adn-homologacao.ts` (`npm run smoke:adn-h`) recria um banco DESCARTÁVEL `fiscal_api_smoke` pelas migrations, copia o A1, cria a habilitação H/série 900 já virada (contador por minuto → Id novo a cada execução), roda transmitir → consultar → XML/DANFSe → cancelar no fisco → consultar, e APAGA o banco no fim (`--manter` preserva); o ERP só é lido (nota travada por instantes); o `fiscal_api` real é intocado. Sem `--vai` só confere; `--candidatas` lista notas elegíveis. | sem fisco: pré-condições conferidas; **nenhuma nota elegível no dev hoje** (300 conferidas: 294 sem código nacional — anteriores à D-N11a —, 6 com `cTribMun` "0102" — anteriores à D-N26b) |

### 16.2 Parecer do guardião sobre a D-F39 (setes-conceito, 2026-10-04) — aplicado

Peça, não maquete: **coluna write-once monotônica** (`cutover_at`; NULL = réplica) — sem tabela de eventos (a reversão é
proibida pelo desenho; evento modelaria o que não pode acontecer). **Dado por linha (institution, model), ato por
institution** (o A1 é um por estabelecimento — virar por modelo prenderia o A1). **Condição no próprio comando que
cunha** (`nextDpsNumber`, aluguel), não só na borda. **Lacuna** (institution emitida pelo ERP e ainda não migrada) fechada
pelo predicado lendo a habilitação SE do ERP (viva ou excluída — o contador tem história); "copiar todas antes" seria
maquete (dependeria de alguém ter rodado o script). Nomes evitados: "custódia" (estado do cheque), "detém" (D-N26), "dono"
(token do aluguel), "origem" (re-sincronia); valores com nome de serviço (`'nfse-api'` numa linha 55 seria falso).

**Assunções tomadas na execução (forma, não conceito — contestáveis na próxima rodada):** A8 formato `cutover_at`
anulável no lugar dos valores `'setes-api'|'nfse-api'` do texto da Q-F48 · A9 smoke da D-F36 em banco DESCARTÁVEL (a
virada temporária que a D-F36 implicava é proibida pelo write-once) · A10 até a F2a, NÃO criar habilitação SE pela tela do
setes-api para institution que nasceu na API (conhecimento negativo; o `migrate:setes` detecta depois e falha alto) ·
A11 transmissão viva na origem durante a virada = falha alta (nunca reconciliar pelo `dps_id` no ato) · A12 os testes ao
vivo viram a habilitação real só durante o ataque e a devolvem réplica no `afterAll` (CHECKSUM conferido).

### 16.3 Pendências

1. **Smoke da D-F36**: falta uma **OS de TESTE faturada agora** pelo setes-api (regra de ISS com código nacional e código
   municipal vazio ou de 3 dígitos — a regra 2 do dev já está corrigida) — escrita no ERP da Setes, **decisão do Valdo**
   (qual cliente/serviço/valor) = **Q-F51**; depois, `npm run smoke:adn-h -- --nota <id>` (confere) e, com o **"vai"**,
   `… --nota <id> --vai`. O A1 vence em **08/10/2026**.
2. **Q-F50, Q-F51, Q-F52, Q-F53** (§8.R5) — aguardam o Valdo.
3. **F2a** (lista do §15.5 + D-F37): setes-api aplica a licença para todos; ato da virada com o setes-api parado.
4. Gates do delta da Rodada 4: §16.4.

### 16.4 Gates do delta da Rodada 4

**Rodada 1: socrático 0.65 ✗ · adversarial 0.70 (no limite, sem HIGH).**
- MEDIUM (os dois): o prazo do PAM (D-F38) entrou no CAMINHO CRÍTICO da passada — o deadline era fixado antes de
  `cancelDaysOf` (A1 + emitente + convênio com 30 s de transporte, falha sem cache): convênio lento = nenhuma candidata
  consultada, nem as vivas; e a leitura [INCERTO] do convênio, antes só AVISO (D-N15), passou a TIRAR notas do rodízio.
- MEDIUM (socrático): os ataques ao vivo viravam a habilitação REAL (P, A1 real) do `fiscal_api` e a devolviam no `afterAll`
  — jest morto no meio = réplica VIRADA (o cenário R2-2). E a virada fecha só um lado → **Q-F50 refinada** (§8.R5).
- LOW: rodízio direto na réplica respondia `skipped`; o cancelamento direto gravava K e N na tentativa copiada antes de
  recusar; `storeCertificate` do núcleo escrevia o A1 de uma réplica; `assertFrozen` não via VOZ nova da origem; o
  `NOT EXISTS` dos pendentes era MATERIALIZADO varrendo o histórico de TODAS as institutions (a cerca só avisava); prazo
  absurdo (data lida como dias) virava `DATE_SUB` NULL e tirava TODAS as autorizadas; guarda fraca antes do `DROP DATABASE`
  do smoke e Id de DPS repetido no mesmo minuto; a visão do emitente não mostrava a virada.
- Questões para o Valdo: **Q-F50** (refinada), **Q-F51** (nota de teste do smoke), **Q-F52** (licença × obrigação já emitida).

**Retrabalho (corrigido na sessão; os `it.failing` do QA viraram `it`):** prazo do PAM fora do caminho crítico — espera no
máximo 3 s, a falha também fica em cache (10 min), valor fora de 1–3650 dias é descartado, o teto NUNCA é menor que o padrão
(`max(PAM, 60) + 30` — assunção **A13**: leitura errada do convênio só ALARGA a revisita) e o orçamento da passada conta
DEPOIS do teto; o relatório diz `authorizedMaxDays` e `ceilingSource`; o repositório limita o teto ao domínio do SQL;
cancelamento confere a réplica ANTES de qualquer voz; passada na réplica = 409 `FISCAL_CUTOVER_PENDING`; o núcleo recusa
escrever/apagar o A1 de réplica; `assertFrozen` acusa voz nova da origem; os pendentes passam a institution como CONSTANTE
no `NOT EXISTS` (materialização por chave) e a cerca do EXPLAIN reprova materialização que varre; smoke só apaga
`fiscal_api_smoke[_sufixo]` ≠ banco da instância, Id por segundo e preserva o banco se a NFS-e de H ficar autorizada sem
cancelar; `cutoverAt` na visão do emitente (e `enabled` = virada + A1). **Ataques ao vivo em CÓPIA DESCARTÁVEL**
(`src/__tests__/live-harness.ts`: `fiscal_api_adv_r1…r4` = migrations + cópia das 5 tabelas + virada só na cópia; o
`afterAll` apaga a cópia e FALHA se o CHECKSUM do `fiscal_api` real mudou) — o banco real não é mais virado por teste.

**Provas:** `fiscal-api` 32/32 · `nfse-api` 115 unit + 71 ao vivo (4 suítes, cópias descartáveis), zero 500 · `fiscal_api`
real idêntico à origem (19 tentativas, 21 vozes; institution 1 réplica) · nenhum banco descartável sobrando · EXPLAIN sem
aviso nem falha.

**Re-prova (rodada 2 do delta): socrático 0.75 ✅ · adversarial 0.65 ✗ (sem HIGH).** O retrabalho abriu uma REGRESSÃO MEDIUM
(os dois gates): o `clearCertificate` passou a abrir a transação com a conferência da réplica por leitura NÃO travante —
o snapshot do REPEATABLE READ nascia antes da trava da habilitação e o DELETE do A1 contava 0 vivas com uma reserva
recém-comitada (provado pela rota: 200, A1 apagado, tentativa em voo sem certificado). LOW: cancelamento direto e
`storeCertificate` não viam réplica EXCLUÍDA nem a lacuna (b); cache do PAM sem "uma consulta por vez" e uma falha tardia
encolhia o teto (contra a A13); o aluguel de 60 s não cobria uma candidata de 2 × 30 s (consulta dobrada); o harness só
DETECTAVA (usuário com ALL — **Q-F53**) e não conferia `_migrations` nem o ERP; cópia que sobrava de jest morto ficava
virada; o smoke apagava a evidência da execução anterior e o envio ambíguo; o PAM do CANCELAMENTO seguia sem limite;
re-sincronia segurava trava compartilhada na origem durante a conferência de XML.

**Retrabalho 2 (corrigido na sessão; `it.failing` → `it`):** escrever/apagar o A1 começa por `assertEmitterWritable` —
`lockIssuerRows` (FOR UPDATE nas linhas da habilitação: a 1ª instrução é a TRAVA) + réplica viva/excluída + lacuna (b) pela
habilitação SE do ERP (a peça recebe `schemaName`); cancelamento direto usa o predicado COMPLETO `emissionStillInErp` antes de
qualquer voz; PAM com UMA consulta por vez (por município/ambiente e por institution), falha mantém o último prazo conhecido
(+10 min — A13), teto cacheado por institution (o A1 não é decifrado a cada passada); o cancelamento espera o PAM no
máximo 3 s e descarta valor implausível; aluguel de 90 s RENOVADO antes de cada candidata (`renewRefreshLease`; perdido =
a passada para); harness confere `_migrations` + ERP e apaga cópias `fiscal_api_adv_*` que sobraram; smoke recusa apagar
evidência anterior (sem `--descartar-evidencia`) e preserva envio sem voz; re-sincronia confere XML depois do commit.

**Provas:** `fiscal-api` 33/33 · `nfse-api` 127 unit + 96 ao vivo (5 suítes em cópias descartáveis), zero 500 · `fiscal_api`
real idêntico à origem; nenhuma cópia sobrando; `migrate:setes --dry-run` limpo.

**Re-prova FINAL do delta: socrático 0.80 ✅ · adversarial 0.70 ✅ (no limite; nenhum HIGH) — GATES DO DELTA DA RODADA 4
FECHADOS.** Pontos restantes (sem decisão de arquitetura), corrigidos DEPOIS dos gates, nesta mesma sessão:
- MEDIUM (adversarial): o DELETE do A1 ainda concluía com um CANCELAMENTO no fisco em curso — a reserva K não passava pela
  trava da habilitação → a decisão do cancelamento agora faz `getIssuer(..., FOR UPDATE)` depois da nota e antes do K
  (ordem nota → habilitação, a mesma da reserva da transmissão).
- LOW: consulta ao convênio pendurada para sempre → idade máxima de 60 s para a promessa pendente (`PENDING_MAX_AGE_MS`);
  `migrate:setes` dizia "FALHA (nada gravado)" sobre um commit já feito → a conferência de XML pós-commit vira AVISO no
  relatório; smoke com `--vai` apagava o banco em qualquer saída por erro → só o caminho feliz COMPLETO apaga; harness com
  varredura ≠ validador e vigilância com NULL silencioso → corrigidos (+ 3 tabelas do `setes_central`); a habilitação
  (`upsertIssuer`/`softDeleteIssuer`) ganhou a cerca NO NÚCLEO (`assertEmitterWritable` movido para o repositório; as
  peças recebem `schemaName`).

**⚠️ ESTADO AO SALVAR A SESSÃO (2026-10-04, pedido do Valdo "salve para iniciar uma nova seção"):** `fiscal-api` 33/33 ·
`nfse-api` 133/133 unit · ao vivo **104/108 — 4 FALHAS a resolver na próxima sessão** (todas depois das correções pós-gate):
1. `adversarial-f1r6.live.test.ts` §D — **DEADLOCK cru (1213 `ER_LOCK_DEADLOCK`) na PASSADA do rodízio** concorrente com
   reserva × PUT do A1 × PUT da habilitação (1ª de 4 rodadas). Provável causa: `lockIssuerRows` (FOR UPDATE por FAIXA da
   institution, agora também em `upsertIssuer`/`softDeleteIssuer`) × `renewRefreshLease`/`acquireRefreshLease` (UPDATE de
   linha fora de transação). Ações: (a) traduzir contenção do aluguel para `RESOURCE_BUSY`/parar a passada (nunca 1213
   cru); (b) avaliar trocar a faixa por linhas pontuais (PK) no `lockIssuerRows`.
2. `adversarial-f1r6.live.test.ts` §A (cenário + "[corrigido] DELETE do A1 NÃO conclui com a reserva K viva") — o
   CENÁRIO descrevia a ordem antiga (DELETE conta 0 e o K entra no intervalo); com o cancelamento travando a habilitação
   a sequência muda. Reescrever o cenário para a ordem nova e conferir que o DELETE recusa (409) ou que o cancelamento
   espera e vê o A1 apagado (FISCAL_CERT_MISSING + N).
3. `adversarial-f1r4.live.test.ts` §C "réplica EXCLUÍDA … upsertIssuer direto TAMBÉM recusa" — a expectativa
   `[deleted, cutover_at] = ['S', null]` divergiu (ver o Received na próxima execução; a cópia `fiscal_api_adv4` recebe
   `copyFrom` no `finally`).
Comando: `cd nfse-api && NFSE_ADV_LIVE=1 npx jest src/__tests__/adversarial-f1r6.live.test.ts src/__tests__/adversarial-f1r4.live.test.ts --runInBand`.
Banco ao salvar: `fiscal_api` real IDÊNTICO à origem (19 tentativas, 21 vozes, institution 1 RÉPLICA `cutover_at` NULL,
aluguel nulo); nenhuma cópia `fiscal_api_adv*` sobrando; `migrate:setes --dry-run` limpo. Nada falou com o fisco real;
**NADA COMMITADO** (fiscal-api, nfse-api, nfe-api, setes-api 065, sql, Infra-IA — commit/push só com o Valdo).

## 17. Retomada de 2026-10-04 (2ª sessão) — as 4 falhas ao vivo, gates do delta e Rodada 6 (D-F41…D-F45)

### 17.1 As 4 falhas do §16.4 — causa e correção (sem decisão nova)

| Falha | Causa (provada) | Correção |
|---|---|---|
| r6 §D — 1213 cru na passada do rodízio | **Promoção de trava**: `saveIssuer`/`removeIssuer` faziam `getIssuer(…FOR UPDATE)` (trava de REGISTRO na linha SE) e depois `lockIssuerRows` pedia a FAIXA da institution (next-key na mesma linha); com o UPDATE do aluguel em autocommit na FILA dessa linha, o InnoDB fechava um ciclo e matava o aluguel. Provado em banco descartável no MariaDB 10.4.20 (faixa → 1213; por linha → zero) — e a faixa ainda segurava o INSERT da institution vizinha | `lockIssuerRows` trava as LINHAS da PK (`model IN (ISSUER_MODELS)`) — PADROES §9 regra 8 (nova); teste DETERMINÍSTICO no r6 §D (falha com a faixa, passa por linha) |
| r6 §A (cenário + "[corrigido]") | o cenário era da ordem antiga; esperar o cancelamento com o bloqueador preso só produzia lock wait de 50 s nos dois (o detector de timeout do 10.4 varre a cada segundo) | cenário reescrito: o cancelamento ESPERA a trava da habilitação que o DELETE segura; depois do retrabalho do gate (abaixo) ele vê o A1 apagado SOB a trava e recusa ANTES do K — nenhuma voz, nenhum pedido ao fisco |
| r4 §C — `openIssuer` na réplica EXCLUÍDA | `getIssuer` só enxerga linha viva → "configure a habilitação" (FISCAL_ISSUER_MISSING) numa réplica | sem linha viva, `openIssuer` confere a cerca (com o schema: predicado COMPLETO `emissionStillInErp`) → 409 FISCAL_CUTOVER_PENDING |

### 17.2 Gates do delta (socrático 0.80 ✅ · adversarial r7 0.78 ✅, nenhum HIGH/MEDIUM) e retrabalho

Socrático: a trava por linha preserva as garantias da faixa (lacuna (b) inclusive); nenhum outro caminho promove trava. Adversarial
(`adversarial-f1r7.live.test.ts`, cópia `fiscal_api_adv_r7`): 8 rodadas concorrentes embaralhadas sem 1213/1205/500 cru, nDPS
estritamente crescente. LOWs corrigidos na sessão (sem decisão): peça direta com "configure a habilitação" na réplica excluída/lacuna
(b) → `openIssuer` recebe o schema e a passada confere a cerca antes (F1/F2); dois contadores da cerca → `issuerRowsState` no MESMO
domínio da trava (F3, depois fechado no banco pela D-F45); K gravado sem conferir o A1 → a decisão do cancelamento abre o emissor
TRAVANDO (habilitação FOR UPDATE + A1 travante) e recusa antes do K (fecha a janela "processo caído entre K e N = K vivo sem A1");
cerca como 1ª instrução no PUT/DELETE da habilitação (evita ABBA quando a nfe-api tiver o 55); a re-sincronia decide réplica ×
congelada pela leitura TRAVANTE (o COUNT sem trava deixava o ON DUPLICATE KEY reescrever uma linha virada em paralelo); comentários.
**Limitações ACEITAS (it.failing que as fixam no r7):** F4 — trava de INTERVALO de chave ausente alcança a institution vizinha na
CRIAÇÃO de habilitação (a faixa fazia o mesmo; criação concorrente é ato de implantação; deadlock reexecutado, esgotado = 409 sem
gravar); F6 — parada da passada por contenção: a devolução esbarra na mesma trava e o aluguel vence sozinho em ≤ 90 s (PADROES §11.7).
Achado de teste: no MariaDB 10.4 um UPDATE em AUTOCOMMIT que espera trava NÃO aparece no INNODB_TRX (provado) — detectar pelo
`SHOW FULL PROCESSLIST`.

### 17.3 Rodada 6 — execução (D-F41…D-F45)

| Decisão | Execução | Prova |
|---|---|---|
| **D-F41** espera curta no aluguel | peça `runShortCommand` do núcleo (`db/tx.ts`): conexão própria em AUTOCOMMIT só durante o comando, `innodb_lock_wait_timeout` = 3 s na SESSÃO, a anterior guardada numa variável da sessão e RESTAURADA (falhou = conexão descartada, nunca volta ao pool com a espera curta), deadlock reexecuta 1× com aviso, o resto = 409 RESOURCE_BUSY; tomar, renovar e DEVOLVER o aluguel passam por ela | núcleo `tx.test.ts` (6); r7 §E4: servidor com 50 s → a passada pela rota devolve 409 em ~4 s e as conexões voltam com 50 |
| **D-F42** migrate:setes só SE | parecer do guardião: **peça** com filtro POSITIVO (`model = SERVICE_MODEL`); a linha 55/65 do ERP é só a SÉRIE DA NOTA (fica no ERP); a SE carrega série da nota + habilitação ao fisco e só a 2ª muda de casa; não existe virada de 55/65 (nasce virada na nfe-api); réplica de outro modelo no `fiscal_api` = FALHA ALTA com a instrução de DELETE físico; escopo pelo MESMO predicado do núcleo (`erp.erpServiceIssuerExists`); `--cutover` trava a SE do ERP pela PK (a 55 do faturamento fica livre) e o `fiscal_api` por linha; pós-condição `emissionStillInErp` = falso na mesma transação | r6 §H (réplica 55 → resync e cutover falham alto; sem ela, passa) |
| **D-F43** portar correção ao setes-api durante o dual-run | caracteres de controle no texto livre do DPS/evento (achado LOW do gate da F1) portado para `setes-api/src/shared/tax-authority/dps-builder.ts` + teste. Conferido junto: **nada foi removido do setes-api** — as 14 rotas (9 `/api/billing` + 5 `/api/establishment/issuer`) e as 6 peças fiscais seguem lá e o app ainda chama só o setes-api (remoção = F2a; troca do app = F2b) | `tax-authority.test.ts` 24/24 + suíte do setes-api |
| **D-F44** (= Q-F50 (a) refinada, Valdo: "manter") o ato da virada APOSENTA a habilitação SE do ERP | `scripts/cutover-erp.ts` (só script — o serviço nunca o importa): conferência ANTES de qualquer escrita — série efetiva da NOTA SE (`serie ?? '1'`, espelho exato do setes-api) ≠ '1' = falha alta; `UPDATE … SET deleted='S'` na linha SE viva, na MESMA transação da virada; o setes-api lê/cunha sempre com `deleted='N'` → a reserva dele recebe 409 FISCAL_ISSUER_MISSING sem mudar código. Item novo da LISTA FECHADA da D-F31, com cerca por teste que varre `src/` E `scripts/` (`app.test.ts` "CERCA D-F31": a única escrita no ERP do projeto é essa). Credencial do ato = a do DONO do ERP (o usuário `fiscal_api` só lê o ERP → o UPDATE é negado e o ato inteiro volta). **Os testes ao vivo NUNCA rodam o ato real contra o ERP do dev** (é o que emite a produção da Setes): só `--dry-run` (executa a escrita e desfaz na mesma transação); a virada da CÓPIA é feita pelo teste | r6 §H "ensaio": `linhasViradas 1` + `habilitacaoErpAposentada 1` e o ERP idêntico depois; unit `cutover-erp.test.ts` (série); r4 §C reescrito |
| **D-F45** (= Q-F56 (a), Valdo: "sim") domínio do `model` como fato do banco | migration **004** do núcleo `CHECK (model IN ('SE','55','65'))` (1º CHECK da casa; aplicada no dev); boot da nfse-api chama `assertIssuerModelDomainEnforced` — um modelo fora do domínio, numa transação sempre desfeita, tem de ser RECUSADO pelo banco, senão o boot falha (MySQL < 8.0.16 ignora CHECK) | dev: CHECK registrado e aplicado (4025), zero resíduo; r7 §G: INSERT réplica/virada e UPDATE para 'XX' recusados; trava = contagem em 3 estados; núcleo `cofre.test.ts` (3) |

### 17.4 Provas ao fechar a sessão e pendências

`fiscal-api` 44/44 · `nfse-api` 143 unit + **130 ao vivo** (7 suítes em cópias descartáveis — r7 20/20), zero 500 · `setes-api`
tax-authority 24/24 · `fiscal_api` real: migration 004 aplicada, institution 1 RÉPLICA, 19 tentativas/21 vozes, nenhuma cópia sobrando.
**Gate do delta da Rodada 6 (D-F41…D-F45 + retrabalho) NÃO rodado** — próximo passo antes de "pronto".
Pendências: Q-F51 ADIADA (renovação do A1 programada), ~~Q-F52~~ DECIDIDA = D-F46 (bloqueio total — CÓDIGO FEITO, ver §17.5),
Q-F53 (GRANT dos ataques ao vivo); F2a (setes-api passivo: remover as 14 rotas e as 6 peças, licença para todos — D-F37, pré-condição do ato);
inventário dos demais achados da F1 que valem para o setes-api (A14 da D-F43). PUBLICADO 2026-10-04 nos repos PRIVADOS `valdosouza/gestao-2027-fiscal-api` · `-nfse-api` · `-nfe-api` (os demais do projeto são públicos — mudar a visibilidade é decisão do Valdo).

### 17.5 D-F46 executada (2026-10-04, 3ª sessão — nuvem)

| O quê | Onde | Prova |
|---|---|---|
| `requireAnyPrivilege` passa a DEVOLVER os ramos em que quem pede pode agir (contratado + TRANSMITIR; admin = todos os contratados); nenhum → 403 como antes | `nfse-api/src/modules/guards.ts` | `app.test.ts` "D-F46: a PASSADA só consulta…" |
| a passada usa o MESMO domínio da rota por nota (`service-orders`, `orders`, `order-returns` — `erp.orderInterface`); antes a guarda olhava só os 2 primeiros e a passada consultava TODAS as notas | `nfse.routes.ts` (`PASS_INTERFACES`) | idem (devolução contratada com privilégio entra) |
| filtro no SQL das candidatas, ANTES do LIMIT: `LEFT JOIN vw_order_interface` (D-F32) + `COALESCE(interface_key,'orders') IN (?)`; lista vazia = nenhuma consulta; sem a opção = SQL de antes (chamada interna) | `nfse/repository.ts` `listRefreshCandidates`, `transmission.ts` | `passada-ramos.test.ts` (3), `transmission.test.ts` (1) |
| `explain:leituras` captura o SQL da passada COM o filtro (D-F40) | `scripts/explain-leituras.ts` | — |
| contrato `/v1/nfse/refresh` descreve a regra | `openapi/nfse-api.v1.yaml` | cerca contrato × rotas verde |

`nfse-api` 148 unit (131 ao vivo pulados — sem banco na nuvem), `tsc` limpo. **Falta na máquina do Valdo**: rodar as suítes
ao vivo e `npm run explain:leituras` (o plano com o JOIN novo na view de política — D-F40).

## 18. Gates do delta da Rodada 6 + D-F46 (2026-10-04, 3ª sessão — nuvem; agentes que não fizeram a entrega)

**Socrático 0,76 ✅** (`revisar-riscos-sistemicos`; nenhum HIGH; 2 MEDIUM + 5 LOW) · **Adversarial r8 0,80 ✅** (`testar-adversarial`;
nenhum HIGH/CRITICAL; 2 MEDIUM + 5 LOW; `adversarial-f1r8.test.ts` no núcleo (8, todos resistidos) e na nfse-api (18)). Só
unitário: as suítes ao vivo pedem o banco do dev.

| Achado | Sev. | Destino |
|---|---|---|
| [r8-cancel-idem] o retrabalho do §17.2 pôs o `openIssuer` travante ANTES das saídas sem fisco: retry com voz C e A1 vencido/apagado = 409 FISCAL_CERT_* (contrato: 200 `atAuthority=false`); nota nunca transmitida = "envie o .pfx" (contrato: FISCAL_NOT_AUTHORIZED) | MEDIUM (provado) | **CORRIGIDO** (sem decisão): a conferência do A1 sob a trava foi para logo antes do K; o "nenhum K vivo sem A1" continua provado (`it` "resistiu") |
| [r8-resync-55] re-sincronia pulava institution sem SE no ERP antes de conferir réplica de outro modelo → institution travada sem saída | LOW (provado) | **CORRIGIDO**: leitura NÃO travante das linhas antes do `continue` (travar pegaria gap lock em institution sem linha) |
| nota viva de ramo descontratado trava o emitente para sempre | MEDIUM | Q-F57 → **D-F47 EXECUTADA** (§18.1) |
| re-sincronia segura a trava das viradas de todas as institutions | MEDIUM | Q-F58 → **D-F48 EXECUTADA** (§18.1) |
| setes-api revive a SE aposentada antes da F2a | MEDIUM/LOW | **Q-F59** |
| aluguel por institution: a passada de um conjunto de ramos dá `skipped` a quem tem outro | LOW | aceito (atraso, sem dado errado) |
| `interfaces` opcional = sem filtro em chamada interna; pendentes com 2 ramos × passada/rota com 3 | LOW | aceito; a rota sempre passa (teste); pendentes = transmissão NOVA (devolução não gera SE) |
| boot prova que o motor aplica CHECK, não que o domínio do CHECK = `ISSUER_MODELS` instalado; 004 não reexecutável | LOW | registrar para a F4 (nfe-api estende o domínio) |
| `runShortCommand` não encurta `lock_wait_timeout` (metadados — ALTER concorrente) | LOW | F3 (deploy rolante) |
| `requireCutover` antes das guardas: ramo não contratado em institution não virada vê 409 da cerca, não 403 | LOW | aceito (mesma empresa; o bloqueio vale) |
| `--cutover --dry-run` segura o FOR UPDATE da SE de produção do ERP e exige o `--confirmo` | LOW | ensaio curto; registrar no roteiro da virada |
| regex da CERCA D-F31 não pega `UPDATE IGNORE`/`DELETE t FROM`/multi-tabela | LOW | endurecer quando mexer na cerca |

Provas: `fiscal-api` 52/52 · `nfse-api` 166 unit (131 ao vivo pulados) · `tsc` limpo nos dois. **Na máquina do Valdo**: suítes
ao vivo + `npm run explain:leituras` (JOIN novo da D-F46). Próximo: Q-F53, Q-F57…Q-F59 → F2a.

### 18.1 D-F47 e D-F48 executadas (2026-10-04, 3ª sessão)

| Decisão | Onde | Prova |
|---|---|---|
| **D-F47** passada fecha as vivas do ramo cortado | `guards.ts` `passScope` (substitui `requireAnyPrivilege`: devolve `interfaces` = contratados com privilégio e `liveOnlyInterfaces` = cortados; admin com nada contratado passa só com os cortados); `listRefreshCandidates`: `AND (ramo IN (?) OR (ramo IN (?) AND (le.kind IS NULL OR le.kind IN ('S','K'))))`, antes do LIMIT | `passada-ramos.test.ts` (5), `app.test.ts`, `adversarial-f1r8.test.ts` (admin sem nada contratado → só vivas; usuário comum 403), `transmission.test.ts` |
| **D-F48** re-sincronia por institution | `scripts/migrate-from-setes-api.ts` `resyncAll` + `resyncInstitution` (begin/commit por institution; falha = rollback dela, segue, sai ≠ 0 com a lista; relatório JSON ganha `failures`); a mensagem final do script deixou de dizer "nada gravado" sempre | `adversarial-f1r8.test.ts` "[D-F48]" (2 institutions: a 1ª volta, a 2ª grava, exit 1) |

`nfse-api` 169 unit (131 ao vivo pulados), `tsc` limpo. `explain:leituras` captura o SQL mais largo (os dois grupos). **Na máquina do
Valdo**: suítes ao vivo (as de re-sincronia — r2/r4/r5/r6 — passam a ver uma transação por institution) + `explain:leituras`.

### 18.2 Gate do delta D-F47/D-F48 (socrático 0,74 ✅ · adversarial r9 0,78 ✅ — nenhum HIGH)

`adversarial-f1r9.test.ts` (19): precedência AND/OR do filtro novo provada por um oráculo que traduz o WHERE real (o filtro não
escapa da institution nem do bloco de idade); `passScope` com listas disjuntas; `--dry-run` com várias institutions desfaz todas;
o FOR UPDATE de cada institution vive só na transação dela. Achados: **[r9-inflight-never-closes] MEDIUM (provado)** — em voo
sem DPS no fisco nunca fecha pela passada → **Q-F60**; **[r9-resync-rollback-throws] LOW (provado) — CORRIGIDO**: o rollback
da institution é protegido (conexão que não desfaz é descartada; a próxima institution usa outra) e o relatório sai sempre;
LOWs aceitos: `countLiveTransmissions` sem filtro de vida/terminal × candidatas da vida vigente (anterior ao delta — depende do
setes-api recusar vida nova com tentativa viva); admin sem nada contratado ainda abre o A1 e consulta o prazo do município
antes de saber se há viva; commit gravado com confirmação perdida relatado como falha (re-sincronia idempotente).
`nfse-api` 187 unit (131 ao vivo pulados), `tsc` limpo.

