# Frente — Registro de terminais (`tb_terminal`): a web é o terminal 0; o servidor local e os PDVs recebem o número da web

**Escopo**: misto (portável: "cada fonte que cunha numeração de movimento é um TERMINAL com número próprio, estável e nunca
reaproveitado", "o número sai da fonte central e é conferido na porta", "recusa da INSTALAÇÃO ≠ recusa do REGISTRO"; do Gestão 2027: as
tabelas, os endpoints, as telas e as decisões)
**Origem**: D-SY14 (= Q-SY14 do grupo do sync) — `setes-sync/verificacao-comissao-margem-mercadoria.md` §9.5–§9.6 ("Respostas do Valdo aos
pontos em aberto", 2026-10-18). Motivo: hoje a web e o servidor local do sincronizador gravam pedido no MESMO terminal 0; o próximo
`NFL_CODIGO` do legado cai em cima de um pedido nascido na web e o `/order-*` do setes-sync o REGRAVA (upsert pela PK — nota e itens juntos).
**Aberto em**: 2026-10-18. **Estado**: Rodada 0 ORGANIZADA — decisões de partida (§1, D-TM1…D-TM7), inventário com arquivo:linha (§2),
parecer do guardião integrado (§3 — duas peças: `tb_terminal` + o vínculo `tb_terminal_holder`, e um `kind` W/L/P; as duas somas divergem
das 3 colunas da D-TM1 e viram questão), desenho (§4), ondas 0–4 (§5), questões **Q-TM1…Q-TM7** + assunções **A-TM1…A-TM5** (§6, todas com
recomendação), conhecimento negativo (§7) e prompt de retomada (§8). **Nada de código, DDL aplicado, seed ou commit** nesta sessão — o DDL é
RASCUNHO (`prompt_frente_terminal-ddl-rascunho.sql`, §4.1). **Pronto para o Valdo decidir a Rodada 1 e dizer "pode executar".**
**Transversal**: setes-api + setes-app (grupo 1) e setes-sync + sincronizador (grupo 2) — a frente toca os DOIS grupos por decisão do Valdo
("não cabe só no grupo do sync", §9.6); a EXECUÇÃO separa as ondas por grupo, cada uma em sessão própria (regra dos dois grupos). nfse-api,
fiscal-api e nfe-api só foram LIDAS (já são parametrizadas pelo terminal — §2.6). Dizer isso de saída ao retomar.
**Fora daqui** (D-TM7): matriz × filiais e o PDV recebendo o cadastro da web (D-SY12, direção web → Firebird) — frente própria, em sessão
própria.
**Consultas ao banco**: só leitura (`START TRANSACTION READ ONLY`) no dev — que é ENSAIO (`nada-em-producao`).
**Base do inventário**: `main` do setes-api/setes-app/nfse-api/fiscal-api; setes-sync e sincronizador na ÁRVORE DE TRABALHO como estava em
2026-10-18 (com o patch 11 / D-SY10·D-SY11·D-SY13 da sessão do grupo do sync ainda NÃO commitado — a onda 2/3 desta frente começa DEPOIS dele).

---

## 1. Decisões de partida (Valdo, 2026-10-18 — não se rediscutem aqui)

- **D-TM1** (= D-SY14): a peça `tb_terminal` (`tb_institution_id`, `id`, `description`) é o REGISTRO dos terminais de cada
  estabelecimento. Cada terminal tem o seu pedido nº 1 — a PK `(id, tb_institution_id, terminal)` das tabelas de movimento já separa os
  espaços. Caso da Pipoteca: 1 servidor + 7 PDVs, cada um registrado.
- **D-TM2**: **a WEB é SEMPRE o terminal 0.** O servidor local do sincronizador e os PDVs vêm depois (≥ 1). Revê a decisão 1 do
  `Sincronizador/prompt_indexador_terminal_pdv.md` (0 = servidor local — fica SUPERADA nesse ponto) e coincide com o que o núcleo fiscal já
  tinha escrito (`WEB_TERMINAL = 0`, "o legado e o PDV usam 1..N" — D-NE12).
- **D-TM3**: o terminal é registrado NA WEB e DISTRIBUÍDO ao sincronizador e ao PDV — o número sai da web, não da configuração local
  (hoje o `TERMINAL` é digitado no `CONFIG.INI`).
- **D-TM4**: terminal não registrado → o setes-sync RECUSA com a mensagem **"Terminal não registrado, verifique"**.
- **D-TM5**: sem migração do que está hoje no terminal 0 — tudo é teste; quando subir em produção, a sincronia de cada cliente é refeita do
  zero; a base central segue o padrão (a tabela nasce pela migration e pelo onboarding como qualquer outra).
- **D-TM6**: sem chave estrangeira das 55 tabelas para a `tb_terminal` — o terminal é só identificação; a conferência é na PORTA (setes-sync).
- **D-TM7**: matriz × filiais e o PDV recebendo o cadastro da web = frente própria (fora desta).

---

## 2. Inventário (só leitura, 2026-10-18)

### 2.1 Banco (dev `setes_setes`, READ ONLY)

- `terminal int(11)` (quase sempre `DEFAULT 0`) na PK de **55 tabelas**: `tb_order` e ramos (`_sale`, `_service`, `_purchase`,
  `_stock_adjust`, `_stock_adjust_return`, `_stock_transfer`, `_production*`, `_shipping`, `_billing`, `_bonus`, `_cost`, `_financial`,
  `_installment`, `_totalizer`), itens e tributos do item (`tb_order_item*`, 15 tabelas), nota e ramos (`tb_invoice`, `_merchandise`,
  `_service`, `_event`, `_obs`, `_rectification`, `_return_55/65/service`, `_has_purchase`, `_cancel_waiver`), voz da NFS-e
  (`tb_invoice_service_transmission`, `_event`), financeiro (`tb_financial`, `_bills`, `_payment`, `_statement`, `tb_bank_slip_title`),
  caixa (`tb_cashier`, `_items`), comissão (`tb_commission`), OS (`tb_service_order`), NF-e (`tb_nfe_series`, `tb_nfe_sequences`,
  `tb_nfe_events_sent`).
- `terminal` FORA da PK: `tb_check_event`, `tb_contract_item_competence`, `tb_devices`, `tb_invoice_shipping`, `tb_order_item_icms_fcp`,
  `tb_order_item_ipi_back`, `tb_stock_list`, `tb_stock_statement` (PK física só `id` — exceção já registrada na Rodada 4 do sync) + as
  views `vw_invoice_life` e `vw_order_interface` (065/068 — expõem e juntam pelo terminal, sem literal).
- `tb_order`: 7.949 linhas, TODAS no terminal 0 (legado ~até 6.531; web 6.532–8.013 — §9.5 do registro).
- `tb_terminal` não existe em nenhum schema (`setes_central`, `setes_setes`, `setes_ws`).
- `setes_central.tb_institution` = `id, schema_name, active, created_at, updated_at, deleted` (é por `schema_name` que a migration acha as
  institutions do schema).
- `tb_devices` (baseline, SEM consumidor): `id, tb_institution_id, identification, description, tb_user_id, terminal, serie_nf, active,
  shelf_life, app_name, download…` — o dispositivo do app antigo tinha terminal próprio (ver §3, "o que NÃO entra").
- Collation: `tb_order` (baseline) `utf8mb4_general_ci`; tabelas de migration nova `utf8mb4_unicode_ci`. A `tb_terminal` não faz JOIN por
  VARCHAR (o JOIN é por `int`) — nasce `unicode_ci` (PADROES §5).
- Numeração livre (conferir de novo ao executar — há sessões paralelas): migrations do `main` vão até **070**; a worktree `merchandise` usa
  **071** e **072** → esta frente = **073**. Seeds: 64/65 no `main`, 66 (`merchandise`) → esta frente = **67** (o 67 da `recuperacao-senha`
  morreu com a D-PV18, 2026-10-18 — a branch foi apagada; reconferir ao executar).

### 2.2 setes-api (`main` f53a618)

- **O terminal nunca vem da requisição, do JWT nem da sessão** (payload `express.d.ts:6-11` = institutionId, userId, role, schemaName;
  zero `terminal` em `shared/auth`, `session-context`, `request-actor`, gateway, DTOs).
- **Escrita**: TODA gravação usa `0` literal — **59 INSERTs em 15 arquivos** (dois também gravam `terminal_ori = 0`) + **3** literais
  `terminal: 0` (`shared/check/check.ts:366,653,772`). Constante só em dois lugares, nenhum central: `const WEB_TERMINAL = 0` LOCAL de
  `modules/cashier/cashier.repository.ts:18` (o mesmo arquivo mistura a constante e o literal em :171,207,220,225,244,249) e o
  `WEB_TERMINAL` do núcleo fiscal importado de `fiscal-api/reading` em `shared/fiscal-voice/fiscal-voice.ts:3,112,120`. Único valor lido do
  banco: `service-orders.repository.ts:153` → `service-orders.service.ts:80-96` → `shared/invoice/invoice.ts:371-379` (`readFrozenIbscbs` —
  o comentário diz "nunca `terminal = 0` fixo").
- **Filtro de caminho de edição**: **137 `terminal = 0`** em 25 arquivos (66 em `shared/`, 71 em `modules/`). Mais densos:
  `service-orders.repository.ts` (20), `billing.repository.ts` (18), `orders.repository.ts` (12), `invoice-cancel.ts` (12),
  `settlement-batch.ts` (11), `order-returns.repository.ts` (11); a peça `shared/order/order.ts:48,57,91` (este com `FOR UPDATE`).
- ⚠️ **Leituras de LISTA e DETALHE NÃO filtram o terminal** — só juntam `x.terminal = y.terminal` e filtram pela institution:
  `orders.repository.ts:92` (lista) e `:146` (detalhe), `service-orders.repository.ts:112,175`, `order-returns.repository.ts:77,130`,
  `settlements.repository.ts:106,250`, `bank-slips.repository.ts:81,183`. Ou seja: hoje a tela MOSTRA o movimento de qualquer terminal, mas
  a rota o endereça SÓ pelo id (`/api/orders/:id`, `PUT /settlements/bills/:orderId/:parcel/charge`…) e a ação sobre ele filtra
  `terminal = 0`.
- ⚠️ **Id novo da web = `MAX(id)+1 … WHERE tb_institution_id = ?` sobre TODOS os terminais** (`orders.repository.ts:323`,
  `service-orders.repository.ts:307`, `order-returns.repository.ts:322`): o id da web pula os ids já sincronizados de qualquer terminal,
  mas um PDV que gere DEPOIS um id que a web já usou cria um segundo pedido com o mesmo id em outro terminal — o detalhe por id fica ambíguo.
- **Onboarding** (`modules/institutions/institutions.service.ts:66-118`): `insertInstitutionCascade` (institution `active='N'`) →
  `insertDefaultFlags` (`institutions.repository.ts:204-261`, 29 módulos) → `runMigrationsForSchema` (`migrations/runner.ts:103-151`, roda
  001…070 no schema novo) → `grantStructuralInterfaces` (`repository :273-296`; `STRUCTURAL_INTERFACE_KEYS = users, modules,
  interface-configs, establishment`) + 1º admin → `active='S'`. Nada toca terminal. Uma linha por estabelecimento nasce em dois lugares
  possíveis: (a) na migration (roda também no onboarding — precedente ainda não commitado: `merchandise/…/072_default_categories.sql`);
  (b) num passo do `createInstitution` ao lado do `grantStructuralInterfaces` (:100). ⚠️ O 2º ato da frente do grupo ("estabelecimento no
  grupo", D-GE14) **não roda migrations** — só (b) cobre a filial.
- **Chave do sincronizador**: só o Super a emite (`institutions.routes.ts:158-194`, aba "Chave de Sincronização" do cadastro de
  Estabelecimento — `setes-app/…/institutions/presentation/widget/institution_tab.dart`); o interruptor `active` (D-PR43) está na worktree
  `merchandise` (não commitado).
- Worktrees: `privilegios` e `merchandise` não mexem em `terminal` (a `merchandise` junta `o.terminal = i.terminal` no repository novo).
- Montagem no gateway (`main`): telas do admin com `adminGuard` (`/users`, `/modules`, `/establishment` — `gateway/router.ts:79-87`);
  telas de cadastro do cliente sem guarda própria no `main` (a guarda por roteador `gatedModule` é da D-PV2, worktree `privilegios-crud`).
  Grupo de menu "Sistema" = interface-fields, users, interface-configs, general-configs, modules, establishment.

### 2.3 setes-app

- Nenhum campo nem chave JSON `terminal` — 5 ocorrências, todas em comentário (`modules/cashier/…/cashier_datasource.dart:13`,
  `cashier_entity.dart:6`, `cashier_open.dart:7` "terminal 0"; `orders/…/order_page.dart:607,823` = "ação terminal", outro sentido).
- Pastas dos módulos com sublinhado (`bank_accounts`) e rota com hífen; molde de tela do admin = `modules/establishment/`.

### 2.4 setes-sync (árvore de trabalho com a D-SY13 não commitada)

- **Onde o terminal chega**: na RAIZ do corpo, `z.number().int().min(0)` OBRIGATÓRIO, em 12 endpoints de movimento —
  `/order-sale` (`endpoints/ordersale.ts:69`), `/order-service` (`orderservice.ts:52`), `/order-purchase` (`orderpurchase.ts:39`),
  `/order-stock-adjust` (`orderstockadjust.ts:38`), `/invoice` (`invoice.ts:27`) e os que herdam o `invoiceBody` (`/invoice-merchandise`
  `invoicemerchandise.ts:44`, `/invoice-service` `invoiceservice.ts:30`), `/invoice-return-55|65|service` (`invoicereturn.ts:25`),
  `/financial` (`financial.ts:26`), `/financial-statement` (`financialstatement.ts:26`), `/stock-statement` (`stockstatement.ts:23`),
  `/cashier` (`cashier.ts:26`). Exceção: `/stock-list` (cadastro) aceita OPCIONAL, sem `min(0)`, e grava `terminal ?? 0` (`stocklist.ts:22,80`).
- **1 requisição = 1 registro = 1 terminal**: o bloco `invoice` aninhado é `invoiceBody.omit({ id, terminal, deleted })` (`invoice.ts:64`) e
  recebe o terminal da raiz (`ordersale.ts:238/430` e irmãos); itens não levam terminal; o financeiro vem uma parcela por requisição.
  Nenhum schema usa `.strict()` — terminal mandado a um cadastro é descartado em silêncio.
- **Sem terminal**: bank-account, brand, carrier, category, customer, financial-plans, measure, merchandise, package, payment-type, price,
  price-list, promotion, provider, salesman, service, stock-balance, user e `filexml` (movimento — Seq 32 — mas só `fileName/
  contentBase64/dtReference`, `filexml.ts:22-37`).
- **Autenticação**: `sync.auth.middleware.ts` — `lookupApiKey` (:51-71) resolve `req.syncClient = { institutionId, establishmentCode,
  schemaName }` (:8-20, :115); cache de 5 min SÓ da chave válida (:47-48); recusas da D-SY13 em `sendKeyRefusal` (:88-99): 401
  `SYNC_KEY_MISSING` / 401 `SYNC_KEY_INVALID` / 403 `SYNC_KEY_INACTIVE`. `GET /sync-key/status` (`endpoints/synckey.ts:40-57`) montada
  ANTES do guard (`sync.specific.routes.ts:43`); o guard só vale para caminho com `sincronize` (:46-49) — **é o ponto único** onde uma
  segunda conferência (terminal) entra logo depois da chave, antes de todos os roteadores. Precedente de leitura crua do corpo no
  middleware: `gateway/sync-error-log.middleware.ts:47`; a ordem `rateLimit → syncErrorLog → syncSpecificRoutes` (`app.ts:52-56`) faz a
  recusa nova cair no log de erro sozinha.
- **Envelope**: `HttpError(status, message, fields?, code?)` (`shared/errors/http-error.ts:7-19`), serializado por endpoint como
  `{ ok:false, error, fields, code }` (ex.: `ordersale.ts:456-458`). Sem catálogo de códigos no setes-sync (strings inline). ⚠️ Perdem o
  `code` no catch: `invoicereturn.ts:99` (leva terminal), `filexml.ts:124`, `paymenttype.ts:115`; o handler global (`app.ts:59-64`) e o
  rate limit respondem sem `ok:false`.
- ⚠️ **Defeito latente achado**: `financial.ts:96-99` procura o PEDIDO do título por `id + institution` SEM terminal (o fallback :106 e a
  compra :155 filtram) — com dois terminais com o mesmo id, o título se pendura no pedido errado. Corrigir na onda do setes-sync (§5).
- **Testes**: jest em `src/__tests__/` (molde da recusa: `sync.auth.test.ts`, da D-SY13, ainda não commitado); smokes em `scripts/`
  (`smoke-onda5.ts:44` `TERM = 0`, `smoke-notas-servico.ts`, `smoke-onda6.ts` — TODOS mandam terminal 0, que passa a ser recusado).

### 2.5 Sincronizador (Delphi — árvore de trabalho com o patch 11 não commitado)

- **De onde vem o número**: `DM.GbTerminal` (`un_dm.pas:110`), lido UMA vez no `DataModuleCreate` (`un_dm.pas:204`):
  `StrToIntDef(Fc_Aq_Geral('L','SISWEB','TERMINAL','0'), 0)`. `Fc_Aq_Geral` (`function/un_sistema.pas:53-84`) é `TIniFile` no
  `CONFIG.INI` ao lado do executável — NÃO é o registro do Windows (comentários antigos dizem "registro": `un_dm.pas:202`,
  `uMain.pas:821`, `general_web.pas:152`). Chave ausente = `''` → **0** pelo `StrToIntDef`. Trocar o número exige reiniciar o programa
  (salvar a tela não recarrega — `uMain.pas:826-841`). `Gb_Terminal` de `un_sistema.pas:20` é OUTRA variável (sempre 0, só do legado
  `origen\controller\ControllerCtrlEstoque.pas`).
- **Tela**: `Task/tas_config.pas:1124` (lê) e `:1214` (grava, sem validação); campo `E_Terminal` (`tas_config.dfm:323-330`, só números,
  `Text = '0'`).
- **Envio**: `LcSendWeb.Terminal := DM.GbTerminal` (`function/un_send_to_web_server.pas:77`); o receive não atribui (inerte — sem linhas
  `WAY='R'`). Classes que põem `terminal` na raiz do JSON: `invoice_send_web.pas:295` (Seq 20), `invoice_service_send_web.pas:114` (21),
  `invoice_merchandise_send_web.pas:149` (22–24), `stock_statement_send_web.pas:68` (25), `financial_send_web.pas:55` (26),
  `financial_statement_send_web.pas:62` (27), `cashier_send_web.pas:56` (28), `invoice_return_55/65/service_send_web.pas` (29–31).
  `stock_list_send_web.pas:58-59` manda **0 FIXO**.
- **Recusa da instalação (D-SY13)**: regra ÚNICA `IsRecusaDaChave` (`function/un_sync_key_state.pas`, ~:113-116 — arquivo ainda em edição
  pela sessão do grupo do sync; citar pelo NOME) — 401 por status OU 403 com `code = 'SYNC_KEY_INACTIVE'`; `general_web.pas:255-268` lê o `code` e seta `AuthRefused`; o laço não grava `SRC_LOG` nem checkpoint
  (`un_send_to_web_server.pas:94-99,111,145,187`), grava "sincronia inativa" no `CONFIG.INI` (`SincroniaInativa`, `…Desde`, `…Motivo` —
  `MarcarSincroniaInativa`/`LimparSincroniaInativa`) e desliga os timers (`AplicaSincroniaInativa`, `uMain.pas`). O botão "Ativar sincronia"
  (`MnuAtivarSincroniaClick`) chama `GET /sync-key/status` (`ConsultarChaveSincronia`) — **só conhece a chave**. ⚠️ Hoje um 403 com OUTRO `code` (ex.: o do terminal) NÃO é
  recusa: vira erro comum gravado no `SRC_LOG` de cada registro — que ESTACIONA para sempre (§9.2 do registro).
- **Regras que supõem 0 = servidor local** (morrem com a D-TM2):
  - seed do perfil PDV: `if GbTerminal <> 0` desliga os cadastros (`SEQ NOT BETWEEN 20 AND 33`) — `un_dm.pas:479-483` (só no 1º seed);
  - conversão grupo/subgrupo → categoria só no servidor: `if GbTerminal <> 0 then Exit` — `un_dm.pas:916`;
  - autor só por documento no PDV: `if GbTerminal <> 0 then Exit(False)` — `un_dm.pas:1302,1314` (`GetUserSyncRef`);
  - `stock_statement_send_web.pas:50-53`: `FTerminal = 0` → "SERVER", senão "Terminal N";
  - comentário da convenção: `uMain.pas:817-822`; `un_dm.pas:106-109`.

### 2.6 nfse-api / fiscal-api / nfe-api (só leitura — nada a mudar nesta frente)

- `fiscal-api/src/ref/invoice-ref.ts:13` — `InvoiceRef { institutionId, id, terminal }`; `:26-27` `export const WEB_TERMINAL = 0`
  ("o legado e o PDV usam 1..N — D-NE12"); `:3-5`: o terminal existe só na BORDA, nunca literal no SQL do núcleo. Fatos do ERP pelo
  terminal como PARÂMETRO (`src/erp/facts.ts:75-76,100-118,334-340`); terminal inteiro ≥ 0 conferido (`voice/reading.ts:144-146`,
  `voice/view-query.ts:49`).
- nfse-api: `WEB_TERMINAL` SÓ na borda HTTP (`src/modules/nfse/nfse.routes.ts:29,41,107`); o resto recebe o terminal (`nfse/transmission.ts:
  92-106,1017`; `facts/service-facts.ts:80-85,168,417-432`); tabelas próprias com terminal na PK desde a `001_nfse_baseline.sql`.
- nfe-api: sem código; `openapi/nfe-api.v1.yaml:576` — "id da nota = id do pedido no ERP (terminal 0 até a F5 — D-NE12)".
- **Conclusão**: a família fiscal JÁ trata a web como 0 e o terminal como parte da IDENTIDADE da nota. Quando o PDV emitir pela web (F5 /
  frente do PDV), basta a borda passar o terminal certo.

### 2.7 Legado Gestao2016 (só leitura)

- O Gestão desktop já tem um `TB_TERMINAL (ID, DESCRIPTION, PATH_SERVER, PATH_DATABASE)` (`Scripts/Banco2022/CriarTodasAsTabelas.sql:3291`;
  `model/tblTerminal.pas`, `Controller/ControllerTerminal.pas` — `GN_TERMINAL`) para a RETAGUARDA achar a base de cada PDV (`tas_conecta_terminal`);
  um script antigo (`Scripts/Terminal_E_Retaguarda.sql`) tinha `MAC_ADDRESS UNIQUE`. O número de terminal do desktop é OUTRO —
  `GRL_G_TERMINAL`, default **1** (`Ajuda/Un_Configuracao.pas:635,683`; `Tarefas/UN_Principal.pas:3559`) — e segue independente (decisão 1
  do indexador). Nada disso é lido pelo sincronizador.

### 2.8 Documentos que mudam com a frente

- `Sincronizador/prompt_indexador_terminal_pdv.md` — decisão 1 (0 = servidor local) e decisão 3 (perfil PDV por `terminal ≠ 0`) SUPERADAS
  pela D-TM2 (marcar, não apagar).
- `Sincronizador/roteiro-implantacao-cliente.md:47-64` — "registro do Windows" (é o `CONFIG.INI`), `TERMINAL` digitado, "servidor
  (`TERMINAL=0`)", e os Seq do perfil PDV desatualizados (doc diz "Seq 1–16, 38 e 39 / movimento 17–29"; o código usa `SEQ NOT BETWEEN 20 AND 33`).
- `setes-sync/CONTRATOS_SYNC.md:50-80` (recusas da instalação — entra a do terminal) e `setes-sync/MAPA_INDEXACAO.md` (nada sobre registro).
- `setes-api/skills/novo-modulo.md` Passo 3 — "Pedido (`tb_order`) NÃO entra: a origem é separada pelo `terminal`… conferir a Q-SY14" →
  passa a apontar para esta frente.
- `database/PADROES_BANCO.md` e `skills-genericas/guardiao-conceitual.md` (palavra "terminal") — §3.

---

## 3. Parecer do guardião conceitual (agente `setes-conceito`, 2026-10-18 — integrado)

**Conceito (uma frase)**: um terminal é um **ESPAÇO DE NUMERAÇÃO do movimento de um estabelecimento** — quem cunha os ids de pedido,
nota e título. Fato gerador: uma fonte nova de movimento passa a operar (a web nasce com o estabelecimento; cada base, no ato de registro).
- **Não é a máquina** (o PDV troca de hardware e a numeração continua — o `MAC_ADDRESS` do script antigo do legado modelava a máquina: era
  maquete), **não é a instalação do sincronizador** (reinstalar não muda os geradores), **não é a base Firebird** (se fosse, a web — que não
  é base — viraria exceção protegida por regra). A base e a web são os **DETENTORES** do espaço — e o detentor é um fato à parte.
- **Sai da estrutura, sem regra de aplicação**: como nada se apaga (PADROES §3.1), `MAX(id)+1` sobre todas as linhas nunca reaproveita
  número; com a linha 0 presente, o MAX+1 começa em 1; base nova = terminal novo; e o espaço diz **quem grava nele** — a web só no 0, cada
  base só no próprio terminal. É isso que mata a Q-SY14 por construção (dois escritores no mesmo pedido deixam de existir).

**Peças**:
- `tb_terminal` — o REGISTRO dos espaços (escritor: setes-api).
- `tb_terminal_holder` — o VÍNCULO "esta base responde por este terminal" (escritor: setes-sync, no ato de vincular). Produtores diferentes
  ⇒ tabelas diferentes; uma coluna write-once na `tb_terminal` misturaria os dois escritores. ⚠️ diverge da D-TM1 (3 colunas) — Q-TM2.
- Composições: a linha 0 nasce DENTRO da criação do estabelecimento (`createInstitution`, ao lado do `grantStructuralInterfaces` — cobre os
  dois atos da D-GE14; a migration só faz o backfill das institutions que já existem); o middleware do setes-sync que RESOLVE o terminal.
- Reusadas: tabela do ESTABELECIMENTO (§12); `lockInstitutionCounters` (§9 regras 7/12); CHECK de domínio conferido no boot
  (`assertCheckConstraintsEnforced`); INSERT puro com UNIQUE de negócio que recusa alto (§9 regra 10); reexportar a constante do núcleo
  (como o `federal-id` em `@shared/validation`); a recusa da INSTALAÇÃO no molde da D-SY13.

**Por ponto**:
1. **Linha 0 "Web" é peça legítima** — se o registro lista os espaços, a web é um deles ("nuvem é nuvem"); os leitores juntam por igual,
   sem `CASE 0 → 'Web'`. Proteção no BANCO, não em regra: `CHECK ((id = 0) = (kind = 'W'))`, `CHECK (id <> 0 OR deleted = 'N')` e, no
   vínculo, `CHECK (tb_terminal_id > 0)` (a linha 0 nunca é detida por uma base).
2. **Distribuição — a forma mais forte da opção (c)**: o bootstrap gera `UUID_TO_CHAR(GEN_UUID())` (existe no FB 2.5 e no 5.0) e o guarda
   numa linha única DENTRO da base; o instalador lista os terminais livres (setes-sync, autenticado pela chave) e VINCULA uma vez; daí em
   diante a base manda só `X-Sync-Base: <uuid>` e **o setes-sync deduz o terminal pelo vínculo** — a base nunca envia o número, então não
   pode enviar o errado. O número não fica guardado em lugar nenhum da instalação (o `CONFIG.INI` é a pior opção: é copiado entre
   instalações); a cada start a base pergunta o status e o guarda só em memória. PK `(institution, terminal)` + `UNIQUE (institution,
   holder_uuid)` = "uma base, um terminal, pela vida toda" nos dois sentidos; a corrida de dois vínculos perde com 409. Terminal excluído por
   engano revive a MESMA linha e o vínculo continua valendo. **Limite conhecido**: `.FDB` CLONADO leva o uuid junto (Q-TM6).
3. **Servidor local × PDV é atributo do terminal** (`kind` W/L/P): há 4 consumidores reais hoje (perfil do seed, conversão de categorias,
   autor só por documento, rótulo do `stock_statement`); quem registra sabe que aquilo é o "PDV 3" e a base herda pelo vínculo — nada
   diverge. O seed e a conversão de categorias passam a rodar DEPOIS do vínculo (com o `kind` conhecido), não no bootstrap às cegas. A
   D-SY12 encontra a lista de destinos pronta (`kind = 'P'`) sem reformar a peça. ⚠️ diverge da D-TM1 — Q-TM1.
4. **Recusa no setes-sync — o terminal é identidade da INSTALAÇÃO**: um ponto só, logo depois do guard da chave, para TODO `/sincronize`
   (cadastros inclusive — recusar só o movimento deixaria o ciclo andar pela metade); o `terminal` SAI do corpo dos 12 endpoints e entra
   `req.syncClient.terminal` (duas fontes exigiriam a regra "corpo = header" — maquete). Código: **403 `SYNC_TERMINAL_UNREGISTERED`**,
   "Terminal não registrado, verifique" — header ausente, base sem vínculo ou terminal excluído. O terminal 0 nunca chega (a base não manda
   número); toda instalação de hoje cai nessa recusa até ser vinculada. No vínculo: 409 `SYNC_TERMINAL_TAKEN` e 409 `SYNC_BASE_ALREADY_BOUND`.
   Efeito no sincronizador = o da D-SY13 (não marca `SRC_LOG`, sincronia inativa, "Ativar sincronia" confere chave E terminal); a regra única
   do Delphi passa a ser `IsRecusaDaInstalacao`. Junto: `financial.ts:96-99` e TODA consulta do setes-sync a tabela com terminal na PK
   passam a filtrar pelo terminal da requisição — com cerca.
5. **Lado da web**: hoje a tela MOSTRA o movimento de todos os terminais, a rota endereça só por id e a AÇÃO só acha o terminal 0 — quando os
   ids se repetirem entre terminais (vão: cada um tem o seu nº 1), o detalhe fica ambíguo e uma ação pode cair no pedido errado (latente
   hoje). **Desta frente**: peça `@shared/terminal` com `WEB_TERMINAL` reexportado do núcleo (UMA definição); cerca "zero literal fora da
   peça" (espelho da D-NE12) cobrindo os 137 filtros e os 59 INSERTs; **listas e detalhes também filtram `WEB_TERMINAL`**; o MAX+1 da web
   conta DENTRO do terminal 0, com índice de prefixo (institution, terminal) — §9 regra 5. **Frente própria**: consultar na web o movimento
   sincronizado (identidade id + terminal nas rotas, somente leitura nas linhas de outro terminal) — é a razão de ser do sync na Pipoteca,
   mas é outro recorte. ⚠️ Consequência ainda não aceita pelo Valdo: o movimento sincronizado SAI das telas operacionais da web — Q-TM4.

**O que NÃO mora na `tb_terminal`**: caminho de base/servidor (topologia da retaguarda — o `TB_TERMINAL` do legado é o MAPA DE REDE, outro
conceito); MAC (o vínculo cobre o que ele queria proteger); série da NF-e/NFC-e (fato terminal × modelo — `tb_nfe_series`; a F5 trata no
`fiscal_api`); usuário (é da operação — o caixa tem `tb_user_id`); a chave do sincronizador (autentica o ESTABELECIMENTO; o vínculo
identifica a BASE); o estado "sincronia inativa" (local, no `CONFIG.INI`); `tb_devices` (segue sem consumidor — um futuro app offline seria
só mais um DETENTOR no mesmo vínculo: a peça agrega, não muda de forma); descritores da base (caminho, máquina) até uma tela pedir.

**Nomes**: `tb_terminal`, `tb_terminal_holder`, módulo `terminals` (`/api/terminals` ↔ `/home/terminals`, pasta `terminals`), peça
`@shared/terminal`. A palavra JÁ é ocupada — entra na tabela "Palavras já OCUPADAS" da skill do guardião (na onda 0) com este texto:
> **terminal**: espaço de numeração do movimento de um estabelecimento (0 = web; ≥ 1 = base que sincroniza), registrado em `tb_terminal`;
> quem o detém é o `tb_terminal_holder`. NÃO é a máquina, nem o caixa (`tb_cashier`), nem terminal de pagamento/TEF, nem o `GRL_G_TERMINAL`
> do Gestão desktop, nem o mapa de bases da retaguarda (`TB_TERMINAL` do legado).

**Interações**: grupo — a tabela é do ESTABELECIMENTO (§12), cada filial tem os seus terminais e a sua linha 0; o vínculo é escopado pela
institution da chave (uma por estabelecimento). D-SY12 — usa `kind = 'P'` + o detentor como endereço; o controle dela vira peça própria,
nunca coluna aqui. NFC-e — a série por terminal se liga à `tb_terminal` (frente fiscal). `tb_stock_list.terminal` vai hoje com **0 fixo, que
passa a significar "web"** — deduzir do vínculo. **Referência ENTRE terminais**: devolução/troca feita no servidor de uma venda feita no PDV
mandaria a referência sem o terminal de origem — o grupo do sync confere no legado (processo DT00–DT04 do vault do Gestao2016) na onda 2.

**Divergências com as decisões do Valdo (só sinalizadas — viram questões)**: (1) D-TM1 tem 3 colunas; o parecer soma `kind` e a 2ª peça
(Q-TM1, Q-TM2). (2) "Distribuído ao sincronizador": na leitura recomendada a base RECEBE o número pelo vínculo, mas NÃO o envia — o
setes-sync deduz; ratificar se "distribuído" cabe nisso (Q-TM2). (3) "Terminal não registrado não recebe pedido": a recomendação estende a
recusa aos cadastros e ao estado inativo da D-SY13 (Q-TM3). (4) Decisões 1 e 3 do `prompt_indexador_terminal_pdv.md` SUPERADAS (marcar o
doc); a D-NE12 do núcleo fiscal CONVERGE. (5) Com a Q-TM4 (a), o movimento sincronizado sai das telas operacionais da web.

---

## 4. Desenho (o que cada onda executa — forma RECOMENDADA; cada item cita a questão de que depende)

### 4.1 DDL — `prompts/prompt_frente_terminal-ddl-rascunho.sql` (v2, NÃO aplicado)

`tb_terminal` (PK `(tb_institution_id, id)`, `description varchar(50)`, `kind` W/L/P com os CHECKs da linha 0, FK para
`setes_central.tb_institution`) + `tb_terminal_holder` (PK `(tb_institution_id, tb_terminal_id)`, `UNIQUE (tb_institution_id, holder_uuid)`,
CHECK de forma do uuid e "nunca o 0") + backfill da linha 0 por `schema_name = DATABASE()` + índice `idx_order_terminal_counter
(tb_institution_id, terminal, id)` em `tb_order`. Migration **073** (conferir), escopo setes.

**Relatório do revisar-ddl** (checklist item a item):
1. PK × colunas, FK composta × PK do destino, ordem de criação (terminal antes do holder) — OK.
2. **PK `(tb_institution_id, id)` diverge do costume `(id, tb_institution_id)`** — de propósito: o `MAX(id) … WHERE tb_institution_id = ?
   FOR UPDATE` usa o prefixo da PK (regra 5 do §9), sem índice secundário. Registrar no comentário do DDL (feito).
3. Padrões: `tb_`, inglês, singular; `created_at/updated_at/deleted`; flags `'S'/'N'`; sem AUTO_INCREMENT; `DEFAULT NULL` real; base certa
   (schema do cliente); FK cross-schema explícita (precedente 003/004/005) — OK.
4. Soft delete (§3.1): nenhuma rota apaga fisicamente; a linha 0 tem `CHECK` que impede até o soft delete; o holder nunca é soft-deletado por
   rota. ⚠️ Os smokes do setes-sync (exceção D-SY8 do §3.1) que criarem terminal + vínculo e os apagarem: holder ANTES do terminal (FK → 1451).
5. UNIQUE além da PK no holder ⇒ **INSERT puro, nunca `ON DUPLICATE KEY UPDATE`** (§9 regra 10) — a colisão vira 409, nunca UPDATE calado.
6. Domínio fechado = CHECK (`kind`, `deleted`, uuid, `id >= 0`) — o boot já confere que o motor aplica CHECK.
7. Collation: sem JOIN por VARCHAR com tabela do baseline (o JOIN é `int`; o uuid só compara com parâmetro) — `unicode_ci` OK.
8. Baseline não cria `tb_terminal` (conferido: zero ocorrência em `001_baseline.sql` e nos 3 schemas do dev) — OK.
9. Re-executável: `CREATE TABLE IF NOT EXISTS` com constraints no CREATE; backfill `INSERT … SELECT … WHERE NOT EXISTS` (nunca `INSERT
   IGNORE` — o dev não tem modo estrito); `ADD KEY IF NOT EXISTS` (sintaxe MariaDB, precedente 048 — o sqlglot não a conhece; o resto
   passa no parser).
10. Seed (§4.4) por `i18n_key`, id dinâmico, conferência no fim — molde do seed 65.

### 4.2 Linha 0 "Web" e a peça `@shared/terminal` (setes-api)

- `src/shared/terminal/` — `WEB_TERMINAL` **reexportado** de `fiscal-api/reading` (uma definição só; a constante local de
  `cashier.repository.ts:18` morre); `ensureWebTerminal(conn, schema, institutionId)` idempotente (`INSERT … SELECT … WHERE NOT EXISTS`);
  `nextTerminalId(conn, schema, institutionId)` = `lockInstitutionCounters` + `MAX(id)+1 … FOR UPDATE` sobre TODAS as linhas (excluídas
  inclusive); leitura do registro e do vínculo para a tela.
- `createInstitution` (`institutions.service.ts`, passo 5, ao lado do `grantStructuralInterfaces`) chama `ensureWebTerminal`. A frente do
  grupo (D-GE14) mantém a chamada nos DOIS atos — nota a deixar no `prompt_frente_grupo_estabelecimentos.md` na onda 0.
- **Cerca** `src/__tests__/terminal-literal-fence.test.ts` (Q-TM7): zero `terminal = 0`, `terminal: 0` e `0` na posição do terminal num
  INSERT fora da peça — a forma (a) da Q-TM7 refatora os ~200 literais de uma vez; a (b) congela a dívida e só a deixa diminuir.
- **Q-TM4 (a)**: listas e detalhes de `orders`, `service-orders`, `order-returns`, `settlements`, `bank-slips` (as 10 leituras do §2.2)
  filtram `WEB_TERMINAL`; o MAX+1 de `tb_order` (`orders.repository.ts:323`, `service-orders.repository.ts:307`,
  `order-returns.repository.ts:322`) e os `number` visíveis dos ramos (`tb_order_sale.number`, `tb_order_stock_adjust.number` — conferir na
  execução) contam DENTRO do terminal 0, pelo índice novo. Regra para código novo (PADROES, onda 0): **a identidade do movimento é
  `(id, institution, terminal)`; a web grava e lê pelo `WEB_TERMINAL` da peça, nunca por literal; id NÃO é único por institution.**

### 4.3 Cadastro de terminais na web — módulo `terminals` (API + app)

- **API** (`src/modules/terminals/`, 6 arquivos — skill `novo-modulo.md`): `GET /` paginado + pesquisa avançada (critério de descrição —
  D-BA21 — e `kind`), `GET /search-criteria`, `GET /:id` (com o vínculo: "vinculado em <data>" ou "aguardando vínculo" — só leitura),
  `POST /` (`description`, `kind` L|P; id por `nextTerminalId`), `PUT /:id` (`description`; `kind` só enquanto NÃO há vínculo — A-TM3),
  `DELETE /:id` (soft delete), `POST /:id/restore` (reativar = `UPDATE … deleted = 'N'` da MESMA linha — o número e o vínculo continuam;
  ato que não é CRUD = ALTERAR, `privilegeAct` na rota se a D-PV2 estiver no `main`). Terminal 0: `PUT`/`DELETE` →
  409 `TERMINAL_WEB_RESERVED` (e o CHECK no banco). Descrição viva repetida no estabelecimento → 409 `TERMINAL_DESCRIPTION_TAKEN` (A-TM2 —
  a lista do instalador não pode ter dois "Caixa 1"). Swagger em todas as rotas; erros no catálogo (`errors:gen`).
- **Guarda e licença (Q-TM5)**: interface `terminals` no grupo **Sistema** (vizinha de Meu Estabelecimento), `kind 'T'`, privilégios
  VISUALIZAR/INSERIR/ALTERAR/EXCLUIR (1, 2, 3, 6) no seed; o par entra na lista única `CONSUMED_PRIVILEGES` (D-PV9) quando a cerca estiver no
  `main`; montagem por `gatedModule('terminals', …)` se a D-PV2 já estiver no `main` na hora, senão `adminGuard` (molde `/establishment`) —
  conferir ao executar. Interface ESTRUTURAL (`STRUCTURAL_INTERFACE_KEYS` + flag em `insertDefaultFlags`): todo estabelecimento tem ao menos o
  terminal Web; sem a chave do sincronizador (que só o Super emite) registrar terminal não abre nada.
- **Seed 68** (conferir o número): interface + privilégios + `page_size` + flag `terminals` para todas as institutions + contrato estrutural
  retroativo; conferência no fim que falha alto (molde do seed 65).
- **App** (`setes-app/apps/web/lib/app/modules/terminals/`, agente `setes-form-builder`, fábrica Register* lista+form): código só leitura;
  `kind` como escolha "Servidor local / PDV" (o "Web" só aparece na linha 0, que abre SÓ LEITURA, sem excluir); seção "Vínculo" só leitura;
  i18n pt/en; sem palavra do legado na tela (`sem-legado-no-sistema`).

### 4.4 Distribuição e recusa no setes-sync (Q-TM2, Q-TM3)

- **Identidade da base**: header `X-Sync-Base: <uuid>` em TODA requisição (o sincronizador põe no mesmo ponto do `X-Api-Key` —
  `general_web.pas` ~:155).
- **Rotas FORA do guard `sincronize`** (como o `/sync-key/status` da D-SY13), autenticadas pela chave:
  - `GET /sync-key/terminals` → `{ ok:true, data:[{ id, description, kind }] }` — terminais VIVOS ≥ 1 SEM vínculo (lista do instalador);
  - `POST /sync-key/terminals/:id/bind` (corpo `{ holderUuid }`) → INSERT puro no `tb_terminal_holder`; 200 `{ ok:true, terminal:{ id,
    description, kind } }` · 409 `SYNC_TERMINAL_TAKEN` (o terminal já tem outra base) · 409 `SYNC_BASE_ALREADY_BOUND` (esta base já detém
    outro terminal) · 404 `SYNC_TERMINAL_NOT_FOUND` (inexistente, excluído ou 0);
  - `GET /sync-key/status` passa a ler também o `X-Sync-Base`: 200 `{ ok:true, active:true, terminal:{ id, description, kind } }` · 403
    `SYNC_TERMINAL_UNREGISTERED` (base sem vínculo ou terminal excluído) · as recusas da chave como hoje.
- **Middleware do terminal** (`sync.specific.routes.ts`, logo depois do `syncAuthMiddleware`, no mesmo `router.use` dos caminhos
  `sincronize`): resolve `X-Sync-Base` → vínculo vivo + terminal vivo → `req.syncClient.terminal`; falha → **403 `{ ok:false, error:"Terminal
  não registrado, verifique", code:"SYNC_TERMINAL_UNREGISTERED" }`**. Sem cache (uma leitura por PK — o terminal excluído para na hora; A-TM1).
- **Endpoints**: os 12 de movimento e o `/stock-list` deixam de ler `terminal` do corpo (sai do zod — o campo enviado é descartado como
  qualquer chave desconhecida) e usam `req.syncClient.terminal`; `financial.ts:96-99` passa a filtrar o terminal; cerca no setes-sync: toda
  consulta a tabela com terminal na PK usa o terminal da requisição. Junto: os catch que perdem o `code` (`invoicereturn.ts:99`, `filexml.ts:124`,
  `paymenttype.ts:115`).
- **Contrato**: `CONTRATOS_SYNC.md` ganha a recusa do terminal na tabela de recusas da instalação + as 3 rotas; `MAPA_INDEXACAO.md` registra
  que o terminal é DEDUZIDO do vínculo (nenhum payload o leva).

### 4.5 Sincronizador (patch 12 — Delphi; compila o Valdo)

- **Bootstrap**: `EnsureSincronia` cria a linha única com o uuid da base (`UUID_TO_CHAR(GEN_UUID())`) SÓ se ela não existir — nunca regera.
- **Configuração**: o campo `TERMINAL` some da tela e do `CONFIG.INI` (número nunca digitado — D-TM3); entra "Vincular terminal": lista
  `GET /sync-key/terminals` → o instalador escolhe → `POST …/bind`. Base já vinculada mostra "Terminal N — <descrição> (<servidor local|PDV>)".
- **Start e ciclo**: o start pergunta `GET /sync-key/status` → guarda terminal e `kind` SÓ em memória; sem vínculo = sincronia inativa com o
  motivo "Terminal não registrado, verifique" (nada é enviado — o default 0 MORRE).
- **Recusa**: `IsRecusaDaChave` vira `IsRecusaDaInstalacao` (401 · 403 `SYNC_KEY_INACTIVE` · 403 `SYNC_TERMINAL_UNREGISTERED`) — mesmo
  efeito da D-SY13; "Ativar sincronia" manda o `X-Sync-Base` e só reativa com chave E terminal válidos.
- **As 4 regras de `GbTerminal <> 0`** passam a ler o `kind` do vínculo (`P` = PDV): seed do perfil (`un_dm.pas:479-483` — roda DEPOIS do
  vínculo), conversão de categorias (`:916`), autor só por documento (`:1302,1314`), rótulo do `stock_statement_send_web.pas:50-53`;
  `stock_list_send_web.pas:58-59` deixa de mandar 0 fixo (o servidor deduz). Comentários "registro do Windows" corrigidos.
- `patches-revisao-2026-07/12_terminal_registrado.md` com o roteiro de teste manual.

### 4.6 Roteiro de implantação (`Sincronizador/roteiro-implantacao-cliente.md`)

- **Fase 0**: além da chave, REGISTRAR na web (tela Terminais) um terminal por base que vai sincronizar — o servidor local (`L`) e cada PDV
  (`P`); a web já aparece como terminal 0.
- **Fase 2**: some o `TERMINAL` do `CONFIG.INI`; entra "Vincular terminal" em cada instalação (uma por base); conferir "Terminal N" na tela.
- **Clonar PDV**: clonar a imagem ANTES do 1º start do sincronizador (o uuid nasce no 1º start); base JÁ vinculada nunca é clonada (Q-TM6);
  base nova = terminal novo; base restaurada de backup mantém o vínculo.
- **Ordem da janela**: o setes-sync novo recusa o sincronizador antigo (que estacionaria cada registro com a mensagem no `SRC_LOG` — o patch 11
  não conhece o código novo) ⇒ parar o sincronizador → subir o setes-sync → instalar o sincronizador novo → registrar e vincular → Ativar.
  (Não há cliente em produção — a sincronia de cada cliente é refeita do zero ao subir, D-TM5.)
- Corrigir os Seq do perfil PDV (o doc está desatualizado — §2.8).

### 4.7 Fora desta frente (registrado)

Consulta na web do movimento dos terminais ≥ 1 (identidade id + terminal nas rotas, somente leitura — frente própria, Q-TM4); matriz ×
filiais e a direção web → PDV (D-TM7/D-SY12); a série da NFC-e por terminal (frente fiscal / F5); `tb_devices`; o mapa de rede da retaguarda;
`tb_stock_statement` sem PK composta (Rodada 4 do sync).

---

## 5. Ondas de execução (cada onda = sessão própria; gates do CLAUDE.md item 7 em cada uma)

| Onda | Grupo / repos | Entrega | Gate de entrada |
|---|---|---|---|
| **0** | setes-api + sql | migration 073 (§4.1) provada em schema DESCARTÁVEL antes do dev (o dev roda `tsx watch` = deploy ao salvar); `@shared/terminal` + `ensureWebTerminal` no `createInstitution`; cerca do literal (Q-TM7); listas/detalhes/MAX+1 pelo `WEB_TERMINAL` (Q-TM4); módulo `terminals` da API + Swagger + erros; seed 68; testes jest + adversarial (MAX+1 concorrente, linha 0 intocável, reativação, descrição repetida); PADROES (regra da identidade do movimento + PK de prefixo) e palavra "terminal" na skill do guardião; nota na frente do grupo | Rodada 1 decidida; números 073/68 reconferidos; se Q-TM7 (a): as worktrees que tocam os 25 arquivos (`privilegios-crud`, `merchandise`) já mergeadas ou avisadas |
| **1** | setes-app | módulo `terminals` (setes-form-builder), linha 0 só leitura, i18n; passeio logado (cadastrar L e P, editar, excluir, reativar, 409 da linha 0) | onda 0 no dev |
| **2** | setes-sync (grupo do sync) | middleware do terminal + 3 rotas + endpoints sem `terminal` no corpo + `financial.ts:96-99` + catch com `code` + cerca de leitura com terminal; jest no molde `sync.auth.test.ts`; smokes registrando terminal/vínculo de teste (exceção D-SY8); `CONTRATOS_SYNC`/`MAPA_INDEXACAO`; conferir no legado a referência ENTRE terminais (devolução no servidor de venda do PDV — DT00–DT04) | onda 0 aplicada no dev (o setes-sync lê `tb_terminal`); a sessão do patch 11/D-SY13 COMMITADA (mesmo middleware e rotas) |
| **3** | sincronizador (grupo do sync) | patch 12 (§4.5) — o Valdo compila | onda 2 no dev |
| **4** | todos | roteiro de implantação reescrito (§4.6) + ensaio ponta a ponta no dev: servidor local (L) e um "PDV" (P) com o MESMO `PED_CODIGO` → duas linhas; base sem vínculo → sincronia inativa com a mensagem; vincular → Ativar → retoma; segunda base no mesmo terminal → 409; pedido da web no 0 intocado | ondas 1–3 |

Ondas 0→1 (grupo 1) e 2→3 (grupo 2) correm em paralelo depois que a 073 estiver no dev. Os docs superados (decisões 1 e 3 do
`prompt_indexador_terminal_pdv.md`, roteiro) são marcados na onda que muda o comportamento (3 e 4), nunca apagados.

---

## 6. Questões para o Valdo — Rodada 1 (recomendação marcada)

**Q-TM1 — Servidor local × PDV como atributo do terminal.** O perfil do sincronizador (o que ele envia), a conversão de categorias, o autor só
por documento e o rótulo do extrato de estoque decidem hoje por `terminal ≠ 0`, que morre com a D-TM2. **(a)** coluna `kind` na `tb_terminal`
(W web — só o 0 · L servidor local · P PDV), escolhida por quem registra e herdada pela base no vínculo; o perfil passa a ser semeado DEPOIS do
vínculo **(Recomendado — guardião; soma 1 coluna às 3 da D-TM1)** · (b) o perfil é escolhido localmente na tela do sincronizador (a web não
sabe quem é PDV; a D-SY12 terá de perguntar depois).

**Q-TM2 — Como o número chega à base ("distribuído", D-TM3).** **(a)** VÍNCULO: o bootstrap gera um uuid guardado DENTRO da base; o
instalador escolhe um terminal livre da lista do setes-sync e vincula UMA vez (`tb_terminal_holder`, escrito só pelo setes-sync); a base
nunca envia o número — manda o uuid e o setes-sync DEDUZ o terminal; uma base, um terminal, pela vida toda (409 nos dois sentidos)
**(Recomendado — guardião; soma a 2ª peça e muda o sentido de "distribuído": a base recebe o número, mas não o envia)** · (b) o instalador
escolhe da lista e o número fica no `CONFIG.INI`; a base manda o número (header) e o setes-sync confere se ele está registrado (duas bases
podem escolher o mesmo número — sobrescrita silenciosa de pedido; o `CONFIG.INI` copiado leva o número) · (c) o instalador DIGITA o número
que a tela da web mostra (o mesmo risco de (b) + erro de digitação).

**Q-TM3 — Alcance e efeito da recusa "Terminal não registrado, verifique" (D-TM4).** **(a)** vale para TODA requisição da instalação (cadastros
inclusive), num ponto só depois da chave: 403 `SYNC_TERMINAL_UNREGISTERED`; no sincronizador o MESMO efeito da D-SY13 (para o ciclo sem
marcar o `SRC_LOG`, sincronia inativa, "Ativar sincronia" confere chave E terminal); header ausente e base sem vínculo dão a mesma recusa
**(Recomendado)** · (b) só nos 12 endpoints de movimento, como erro do REGISTRO (gravado no `SRC_LOG` de cada pedido — que ESTACIONA para sempre,
§9.2 do registro).

**Q-TM4 — As telas da web e o movimento dos terminais ≥ 1.** Hoje as listas/detalhes mostram TODOS os terminais e endereçam só pelo id, e as
ações só acham o 0 — com vários terminais o detalhe fica ambíguo e uma ação pode cair no pedido errado. **(a)** listas, detalhes e ações da web
operam SÓ o terminal 0 (`WEB_TERMINAL`), o MAX+1 da web conta dentro do 0 (D-TM1: "cada terminal tem o seu pedido nº 1"); a CONSULTA do
movimento sincronizado (id + terminal, somente leitura) é frente própria — ⚠️ até ela, o movimento sincronizado SAI das telas operacionais da
web **(Recomendado — guardião)** · (b) já nesta frente a identidade id + terminal em todas as rotas e listas (a web mostra e distingue tudo;
toca as ~25 rotas de processo e o app) · (c) nada agora (o risco latente segue; a Pipoteca não pode subir assim).

**Q-TM5 — Quem registra o terminal.** **(a)** o ADMIN do estabelecimento (e quem ele delegar pelos privilégios da interface `terminals`), numa
tela do grupo Sistema vizinha de Meu Estabelecimento, estrutural para todos (todo estabelecimento tem o terminal Web; sem a chave do
sincronizador, que só o Super emite, registrar não abre nada); o Super passa sempre **(Recomendado — guardião)** · (b) só o Super, na aba da
chave do cadastro de Estabelecimento (implantação centralizada; o cliente que comprar um PDV depende do suporte).

**Q-TM6 — Base CLONADA (o uuid vai junto).** **(a)** limite conhecido: o roteiro manda clonar ANTES do 1º start do sincronizador e nunca clonar
base já vinculada **(Recomendado)** · (b) mitigar nesta frente (ex.: o vínculo guarda também o último `PED_CODIGO`/gerador visto e recusa
regressão — desenho próprio).

**Q-TM7 — Os ~200 literais `terminal = 0` do setes-api.** **(a)** refatorar TODOS para `WEB_TERMINAL` na onda 0, com a cerca "zero literal fora da
peça" (espelho da D-NE12) — mecânico, mas toca 25 arquivos que as worktrees `privilegios-crud` e `merchandise` também tocam: executar depois do
merge delas (condição que vira item do gate da onda 0) **(Recomendado — guardião)** · (b) a cerca CONGELA a dívida (lista dos arquivos com a
contagem — só pode diminuir) e cada arquivo é convertido quando for tocado; as leituras da Q-TM4 já nascem pela peça · (c) nada.

**Assunções a ratificar (seguem se o Valdo não divergir)**:
- **A-TM1 — RATIFICADA (Valdo, 2026-10-20)** — o setes-sync NÃO guarda o terminal em cache (uma leitura por PK por requisição): terminal excluído ou vínculo novo valem na hora.
- **A-TM2 — RATIFICADA SEM a linha 0 (Valdo, 2026-10-20; D-TM16: o 0 é constante sem linha)** — descrição VIVA repetida no mesmo estabelecimento = 409 (a lista do instalador não pode ter dois "Caixa 1"); a linha 0 nasce "Web".
- **A-TM3 — RATIFICADA (Valdo, 2026-10-20)** — o `kind` só muda enquanto o terminal NÃO tem vínculo (depois, o perfil já foi semeado na base); errou = terminal novo.
- **A-TM4 — RATIFICADA (Valdo, 2026-10-20)** — o número do terminal é cunhado pela web por MAX+1 (sem padrão externo — código só leitura na tela), contando os excluídos.
- **A-TM5 — RATIFICADA (Valdo, 2026-10-20)** — o `X-Sync-Base` e a linha do uuid dentro da base são nomes de trabalho; a onda 2/3 fixa os nomes (o da tabela Firebird segue o
  bootstrap: `TB_*` com DDL válida no FB 2.5 e no 5.0).

---

## 7. Conhecimento negativo (armadilhas achadas nesta Rodada 0)

- O "registro do Windows, seção SISWEB" dos docs é o **`CONFIG.INI`** ao lado do executável (`Fc_Aq_Geral` = `TIniFile`) — copiável entre
  instalações; por isso o número não pode morar nele.
- `TERMINAL` ausente vira **0** pelo `StrToIntDef` (o default `'0'` do `Fc_Aq_Geral` é ignorado na leitura) — toda instalação mal configurada
  grava hoje no espaço que passa a ser da web.
- As listas e detalhes da web **não filtram terminal** (só juntam) e as ações **filtram 0** — a tela mostra o que a ação não acha.
- O id novo da web é `MAX(id)+1` sobre **todos** os terminais — esconde a colisão hoje, não a impede amanhã.
- O 403 com `code` desconhecido NÃO é recusa para o sincronizador do patch 11 — vira erro do registro no `SRC_LOG` (estaciona para sempre):
  código novo de recusa da instalação sempre entra na regra única do Delphi ANTES de o setes-sync passar a devolvê-lo.
- `financial.ts:96-99` do setes-sync acha o pedido do título sem terminal.
- O legado tem DOIS "terminais" que não são este: `TB_TERMINAL` (mapa de bases da retaguarda) e `GRL_G_TERMINAL` (default 1, do desktop).
- `tb_order_cost` tem PK `(id, tb_order_id, tb_order_item_id, terminal)` SEM `tb_institution_id` (baseline :1238) — achado de passagem, fora
  do escopo.

---

## 8. Prompt de retomada

> Retomar a frente `tb_terminal` (`Infra-IA/prompts/prompt_frente_terminal.md`). Frente TRANSVERSAL (setes-api, setes-app, setes-sync,
> sincronizador) — dizer isso de saída. Ler o §1 (D-TM1…D-TM7), o §3 (parecer do guardião) e o §6. Se a Rodada 1 estiver decidida
> (Q-TM1…Q-TM7 + A-TM1…A-TM5), registrar as decisões como D-TM8… num §9 novo, ajustar o DDL rascunho (`…-ddl-rascunho.sql`) às respostas
> e executar a onda da vez (§5) numa sessão do GRUPO certo (0/1 = setes-api/app; 2/3 = grupo do sync), com os gates do CLAUDE.md item 7.
> Antes da onda 0: reconferir os números 073/68 e se a D-PV2 (`gatedModule`) e a cerca D-PV9 já estão no `main`. Antes da onda 2: o patch
> 11/D-SY13 commitado. Nada de DDL no dev sem prova em schema descartável.

## 9. Rodada 1 — decisões (Valdo, 2026-10-20, rodada "uma pergunta por vez"; reconcilia Q-TM1…Q-TM7/A-TM1…A-TM5 com Q-TG1…Q-TG14 do debate)

> Contexto que chegou ANTES deste bloco, no mesmo dia (frente de produtos, Rodada 7): **D-PR47** a origem dos cadastros é fato da
> institution (W nativo · L desktop dono · P PDV, web dona); **D-PR48** pausa da chave ≠ "encerrar a transição" (ato único, irreversível);
> **D-PR49** quatro caminhos — L → W ou L → P; **D-PR52** catálogo de base. As Q-TG3/Q-TG4/Q-TG5 do debate tratam do MESMO fato e são
> reconciliadas aqui.

- **D-TM8** (fecha **Q-TG1 = (a)** e **Q-TG2 = (a)**, literal: *"(a), siga a recomendação"*) — **o terminal é do ESTABELECIMENTO**
  (`tb_terminal.tb_institution_id` = a institution que opera; um servidor que atende N estabelecimentos = N registros) **e a numeração é por
  estabelecimento**: cada um tem o seu 0 (web) e os seus 1..N; dois estabelecimentos do grupo podem ter "terminal 1" — a PK das 55 tabelas
  `(…, tb_institution_id, terminal)` já separa. Vale a D-SY14 ("cada terminal tem o seu pedido nº 1").
- **D-TM9** (fecha **Q-TM1 = (a)**, literal: *"(a), siga a recomendação"*) — **coluna `kind` na `tb_terminal`**: W (só o 0), L (servidor
  local do desktop), P (PDV); escolhido por quem registra, herdado pela base no vínculo; o perfil do sincronizador (o que envia) é
  semeado DEPOIS do vínculo lendo o `kind` — os 4 pontos do `un_dm.pas` que deduzem "sou PDV" pelo número mudam junto (T8). **Coerência com
  a D-PR47** conferida no registro: institution L admite UM terminal L (o servidor do desktop) + N terminais P; institution P só terminais
  P; institution W não registra terminal ≥ 1 (409 `TERMINAL_KIND_NOT_ALLOWED`). O ato "encerrar a transição" (D-PR48) inativa o terminal L.
- **D-TM10** (fecha **Q-TG3 = (a) reconciliada**, **Q-TG4 = (a)** e **Q-TG5 = (a)**, literal: *"(a), siga a recomendação"*) — **UM fato,
  um lugar**: a origem dos cadastros (`catalog_source` W/L/P, D-PR47) gravada na linha da FUNDADORA é o fato do GRUPO (D-GE1: fundadora em
  linha única); as filiais leem pelo `groupInstitutionId` (`@shared/group`). O "ponteiro para quem escreve" é DERIVADO: o único terminal
  `kind = 'L'` ativo do grupo (D-TM9) — UNIQUE por construção (coluna gerada `CASE WHEN kind='L' AND active='S' THEN group_id END` + UNIQUE,
  forma com o guardião; PADROES §9 regra 10). Consequências: (1) a guarda `catalogOwnerGuard` resolve o grupo e lê o fato dele; cadastros
  do ESTABELECIMENTO (regra tributária, formas, FCP, configs — D-GE) não passam por ela; (2) o setes-sync aceita CADASTRO só do terminal L
  do grupo (os demais terminais só mandam movimento) — com `catalog_source ≠ 'L'`, todo cadastro é recusado (409, simétrico); (3) a chave
  volta a significar só AUTENTICAÇÃO (a pausa da D-PR48 item 1 segue como interruptor de emergência); (4) a saída do sistema antigo é o ato
  "encerrar a transição" (D-PR48/D-PR49), que inativa o terminal L; desativar o terminal L sem o ato = recusado. Hoje é neutro (grupo =
  institution); a onda 1 do grupo não muda o lugar do fato. O ponteiro explícito do parecer (Q-TG3 (b)) NÃO nasce.
- **D-TM11** (fecha **Q-TM2 = (a)** e **Q-TG7 = (b) ≡ Q-TM2 (a)**, literal: *"(a), siga a recomendação"*) — **PAREAMENTO**: o bootstrap da
  base Firebird gera um uuid guardado DENTRO da base (tabela `TB_*` do bootstrap, DDL válida no FB 2.5 e 5.0); o instalador escolhe um
  terminal LIVRE da lista registrada na web (lista servida pelo setes-sync) e vincula UMA vez — `tb_terminal_holder` (uuid × terminal),
  escrito SÓ pelo setes-sync; a base nunca envia o número: manda o uuid (header de trabalho `X-Sync-Base`, A-TM5) e o setes-sync DEDUZ
  `(institution, terminal)`; uma base, um terminal, pela vida toda — 409 nos dois sentidos (base já vinculada, terminal já tomado); uuid
  de outro estabelecimento = recusa. O número e o `kind` chegam à base NO vínculo (D-TM3 "distribuído" = a base recebe, não envia). Sem
  digitação, sem cópia de `CONFIG.INI`. Limite conhecido: base clonada (Q-TM6).
- **D-TM12** (fecha **Q-TM3 = (a)**, literal: *"(a), siga a recomendação"*) — **a recusa vale para TODA requisição da instalação** (cadastros
  inclusive), num ponto ÚNICO do setes-sync logo depois do guard da chave: 403 `SYNC_TERMINAL_UNREGISTERED` (header `X-Sync-Base` ausente,
  uuid sem vínculo, vínculo com terminal inativo/excluído, identidade de outro estabelecimento — mesma recusa). No sincronizador, o MESMO
  efeito da D-SY13: o ciclo para sem marcar o `SRC_LOG`, a sincronia fica INATIVA, e "Ativar sincronia" confere chave E terminal (mensagem
  "Terminal não registrado, verifique" — D-TM4). Nada estaciona na fila do cliente.
- **D-TM13** (fecha **Q-TM4 = (a)**, literal: *"(a), siga a recomendação"*) — **listas, detalhes e ações da web operam SÓ o terminal 0**
  (`WEB_TERMINAL`): as 10 leituras do §2.2 (`orders`, `service-orders`, `order-returns`, `settlements`, `bank-slips`…) ganham `terminal = 0`
  na query base e nos detalhes por id; o MAX+1 da web conta dentro do 0 (D-TM1). O movimento sincronizado (terminais ≥ 1) SAI das telas
  operacionais até a **frente própria "consulta do movimento sincronizado"** (identidade id + terminal, somente leitura, com o seu desenho
  de tela). Fecha o risco de ação no pedido errado (Q-SY14 do grupo do sync: a colisão de número deixa de alcançar a tela da web).
- **D-TM14** (fecha **Q-TM5 = (a)**, literal: *"(a), siga a recomendação"*) — **o ADMIN do estabelecimento registra o terminal** (e quem ele
  delegar pelos privilégios), na tela `terminals` do grupo Sistema, vizinha de Meu Estabelecimento, ESTRUTURAL para todos (entra na lista
  das estruturais da D-PV35 e no `grantStructuralInterfaces`; contrato da Setes pela D-PV20); catálogo da tela = VISUALIZAR, INSERIR,
  ALTERAR, EXCLUIR (D-PV1 — par novo entra na cerca E no seed antes do app, D-PV9). Sem a chave do sincronizador (só o Super emite),
  registrar não abre nada; o Super passa sempre (A-PV1). Coerência com a D-TM9 conferida no registro (kind × `catalog_source`).
- **D-TM15** (fecha **Q-TM6 = (a)**, literal: *"(a), siga a recomendação"*) — **base clonada = limite conhecido**, tratado pelo roteiro de
  implantação (`Sincronizador/roteiro-implantacao-cliente.md`): clonar só ANTES do 1º start do sincronizador; nunca clonar base já
  vinculada; clonou depois do vínculo = terminal NOVO (o instalador zera o uuid na base — ação do bootstrap "desparear", só local — e pareia
  de novo). Sem detecção de regressão nesta frente (Q-TM6 (b) não nasce); conhecimento negativo no §7.
- **D-TM16** (fecha **Q-TM7 = (a)** e **Q-TG9 = (a)**, literal: *"(a), siga a recomendação"*) — **o terminal 0 é CONSTANTE sem linha**
  (`tb_terminal` registra só instalações, `id ≥ 1`); a constante `WEB_TERMINAL` e o rótulo ("Internet") vivem na peça `@shared/terminal`
  (hoje espalhados: `cashier.repository.ts:18`, `fiscal-api/src/ref/invoice-ref.ts:27`, 154 literais — T3); o setes-sync recusa o 0 sempre.
  **Os ~200 literais `terminal = 0` do setes-api são TODOS trocados pela peça na onda 0**, com a cerca "zero literal fora da peça" (espelho
  da D-NE12) nascendo em ZERO; como os ~25 arquivos são tocados pelas branches `privilegios-crud` e `merchandise`, a troca executa DEPOIS
  do merge delas — condição que é item do gate da onda 0. Consequência: app de venda que cria pedido OFFLINE com id local = INSTALAÇÃO
  (terminal ≥ 1, como o PDV); app ONLINE pelo setes-api = web (0). A linha 0 "Web" do rascunho do DDL (A-TM2) NÃO nasce — ajustar o
  `…-ddl-rascunho.sql` e a A-TM2.
- **D-TM17** (fecha **Q-TG6 = (a)**, literal: *"(a), siga a recomendação"*) — **um grupo tem no máximo UMA fonte de cadastros** (consequência
  da D-TM10): o ato "estabelecimento entra no grupo" (D-GE14, frente do grupo) recusa o entrante com desktop vivo em OUTRO Firebird
  enquanto o grupo tiver `catalog_source = 'L'`; ele entra quando o desktop dele morrer, com os produtos IMPORTADOS como cadastro novo da
  web (ato próprio de importação, nunca upsert por `PRO_CODIGO`). Firebird MULTI-estabelecimento = a mesma fonte (um terminal L, N
  estabelecimentos — D-TM8), no limite da D-SY7 até um cliente real pedir. Vai para a frente do grupo (onda do onboarding da filial).
- **D-TM18** (fecha **Q-TG8 = (a)**, literal: *"(a), siga a recomendação"*) — **o PDV recebe uma PROJEÇÃO derivada**, composta no setes-sync
  (direção web → Firebird, D16 do sync): catálogo de base do GRUPO (D-PR52) × vínculos da filial (tabelas de preço — D-PR23; formas — D-GE7;
  `tb_institution_has_service`) + operação da filial (regras/MVA/FCP — D-GE8; operadores com privilégio nela — D-GE3; o registro do próprio
  terminal) + papéis do grupo; cursor NO PDV; exclusão desce como `deleted='S'` (D-PR37). Nenhuma tabela "catálogo do PDV". Tamanho/ritmo da
  carga = detalhe da D16 (grupo do sync).
- **D-TM19** (fecha **Q-TG10 = (a)**, literal: *"(a), siga a recomendação"*) — **o PDV recebe os OPERADORES com privilégio no
  estabelecimento (D-GE3) e uma credencial PRÓPRIA do PDV — PIN de operador mantido na web** (fato do vínculo usuário × estabelecimento;
  forma com o guardião — hash do PIN, nunca em claro; o PIN desce na projeção da D-TM18 só como hash); **nunca a senha da web num banco
  local**. O PDV não cadastra operador (sem 2º escritor do usuário). Vai para a frente do convidado/usuários (cadastro do PIN na tela de
  usuários, por estabelecimento) e para o grupo do sync (direção inversa).
- **D-TM20** (fecha **Q-TG11 = (a)**, literal: *"(a), siga a recomendação"*) — **o cliente criado no PDV sobe pelo DOCUMENTO** (entidade
  única da Fase 3, D3; papel do GRUPO — D-GE9); sem documento = UUID (D4 do sync) devolvido pela web ao PDV (que hoje não replica
  `EXTERNALCODE` — pendência registrada da retaguarda); e **desce como papel do grupo a todos os PDVs do grupo** pela projeção da D-TM18.
  O tamanho da carga inicial é detalhe da D16 (grupo do sync). Entidade existente não é reescrita pelo PDV (regra "entity existente é
  imutável no sync").
- **D-TM21** (fecha **Q-TG13 pelo DADO** e **Q-TG12**, literal: *"pipoteca esta correto como descreveu. clientes podem vir de qualquer
  diferenca dentro do plano que ja existe hoje cpf/cnpj e sem doc....nao ha clientes com filiais atualmente"*) — **dados**: a Pipoteca é UM
  estabelecimento (1 servidor + 7 PDVs) = cliente-piloto da direção inversa; **não há cliente com filiais hoje**; o plano de identificação
  (CPF/CNPJ/sem documento) já cobre todo cliente. **Ordem das frentes decidida pelo dado** (= Q-TG12 (b), aceitável sem filiais, com a
  mitigação que o (a) pedia): (1) `tb_terminal` — escopo, identidade/pareamento, recusa do 0, `kind`, peça `@shared/terminal` + os 4 pontos
  do `un_dm.pas` com o perfil distribuído; o fato do grupo (D-TM10) já na linha da fundadora, neutro → (2) **direção inversa do PDV (D16)
  na Pipoteca**, nascendo pelo fato e pela chave do GRUPO (`groupInstitutionId` — hoje = institution) para não refazer a leitura depois,
  com a projeção da D-TM18 → (3) grupo ondas 0/1 quando o 1º cliente com filiais aparecer (a D-TM17 entra no onboarding da filial) → (4)
  grupo ondas 2/3. Cada passo neutro para o anterior. Vai para o §9 do debate e para a frente do grupo (ordem revista).
- **D-TM22** (fecha **Q-TG14 = (a)**, literal: *"(a), siga a recomendação"*) — **DROP de `tb_devices`** na migration da frente `tb_terminal`
  (DDL só com o "vai"; registrado com motivo — PADROES §3.1: o DROP vem do TESTE DO CONCEITO do guardião — identidade → uuid do terminal
  (D-TM11), série → `tb_nfe_series`, validade → licença — não da falta de consumidor). App de venda offline = INSTALAÇÃO (terminal ≥ 1,
  D-TM16), não "dispositivo". Baseline `sql/03` ajustado no mesmo commit.

**Rodada 1 FECHADA (2026-10-20)**: D-TM8…D-TM22 + A-TM1…A-TM5 ratificadas (A-TM2 sem a linha 0). Reconciliação com o debate: Q-TG1/2 →
D-TM8 · Q-TG3/4/5 → D-TM10 (com D-PR47/D-PR48/D-PR49 de produtos) · Q-TG6 → D-TM17 · Q-TG7 → D-TM11 · Q-TG8 → D-TM18 · Q-TG9 → D-TM16 ·
Q-TG10 → D-TM19 · Q-TG11 → D-TM20 · Q-TG12/13 → D-TM21 · Q-TG14 → D-TM22. **Nenhuma questão aberta.** Próximo: ajustar o
`…-ddl-rascunho.sql` (kind; sem linha 0; UNIQUE do terminal L por grupo; `tb_terminal_holder`; DROP `tb_devices`) → guardião + `revisar-ddl`
→ prova em descartável → onda 0 (setes-api/app) DEPOIS do merge de `privilegios-crud` e `merchandise` (D-TM16) → ondas 2/3 no grupo do sync
(patch 12) → direção inversa na Pipoteca (D-TM21). Seed/migration: número a conferir na hora (69 reservado — D-PV47). Próximo número: **D-TM23**.
