# Prompt — Fase: Faturamento Fiscal e Financeiro (web)

**Escopo**: setes
**Estado**: Onda 1 ENTREGUE nos dois lados + GATES EXECUTADOS (2026-08-16 —
6 achados corrigidos, seed 28 dos catálogos fiscais criado/aplicado; ver seção
"Gates da Onda 1"). 2026-08-19: pontos abertos dos gates baixados (cache
/catalogs + LOWs do app) e DECISÕES 35/36/37 executadas (Q-G1+RA-Q3 sentido
obrigatório E/S — migration 029; Q-G2 NCM fiel; Q-G4 catálogos completos —
seed sql/30; D38 RA-Q1 produto/cliente = especialização do cadastro de
origem, somente-leitura na tela + validação de existência). 2026-08-20:
RODADA FECHADA — D39 RA-Q2 chips visuais viram REGRA GERAL do app (uso
seletivo em telas com muita informação, ERP mantém tom sério; fábrica
rowBuilder ganha suporte a chips) e D40 RA-Q4 ordem das abas do legado
mantida sem alteração. LIBERADO seguir para as ondas (W2 cálculo por item →
faturamento → W3 financeiro); RA-Q2 ainda pede implementação dos chips na
lista de regras. 2026-08-20: W2 Onda 1 (motor de cálculo por item, puro, sem
persistência) ENTREGUE — ver seção W2 abaixo.
**Fontes** (mapeamento do legado, fonte-da-verdade): `Infra-IA/Gestao2016/tributacao.md`
(P1–P14, T1–T8), `tributacao-plano-web.md`, `processo-pedido-nota.md`, `financeiro.md`,
`geracao-nfe-hierarquia.md`. Decisões numeradas abaixo citam as questões de origem (Qn).

---

## Contexto

O aprendizado do legado Gestao2016 fechou três frentes: processo pedido→nota
(Q1–Q12), tributação (P1–P14 + T1–T8, Q13–Q36) e financeiro (§1–§6 + QF1–QF3 +
sub-frentes cheque/cartão/caixa). A web JÁ possui: order-backbone (1 nota = 1 order,
ramos sale/service), `tb_invoice` com ramos merchandise/service, `tb_product.kind
P|M|S`, settlements IMUTÁVEIS (Software House DP1–DP12), `tb_payment_types`,
bank-accounts, Framework de Configurações, Entidade Única. A autorização/transmissão
está GUARDADA (modelo definido em geracao-nfe-hierarquia.md §4; miolo não mapeado) —
**o marco desta fase é nota PRONTA com impostos calculados + financeiro completo, não
nota transmitida**.

## Objetivos

1. Regra de Tributação na web: `tb_tax_rule` (seletor) + peças por tributo
   (presença = incidência), motor de busca com as 6 sutilezas preservadas
2. Cálculo por item conforme legislação (pilha de bases T3, ordem T1), para
   mercadoria E serviço, gravado por item na nota
3. Financeiro nascendo do faturamento (2 vias: automática pela negociação do
   pedido; manual/confirmativa na esteira), com meios, baixas, estorno em cadeia,
   caixa, cheque e cartão
4. Nenhuma regressão nos contratos vivos: espelho 5.5 do sync (`CONTRATOS_SYNC.md`),
   endpoints /order-*/invoice-* existentes

## Workflow (preservado do legado, corrigido por decisão)

### W1 — Pedido → Nota (já implementado na web; esta fase CONSOME)
Ordem com ramos + negociação (forma+prazo) → faturamento.

### W2 — Faturamento fiscal (novo)

**Onda 1 ENTREGUE (2026-08-20)**: motor de CÁLCULO por item, puro e sem
persistência — `setes-api/src/shared/tax-rule/calc.ts` (extensão da peça
`@shared/tax-rule`, exportado no barrel). Cobre IPI (P4/decisão 5), ICMS
regime normal por CST 00/10/20/30/40/41/50/51/60/70/90 + bases `Fn_CalcBaseICMS`/
`Fn_CalcBaseICMSST` (P2.4/P2.5), FCP próprio + FCP-ST unificado (P7.3/decisão 7),
PIS/COFINS numa única fórmula (P5/decisão 2 — bug de assimetria do legado NÃO
reproduzido), II completo (P9/decisão 11), ISSQN (P6.1, alíquota da CIDADE) e
o orquestrador `calculateItemTaxes` na ordem T1 (rateio externo → IPI → ICMS
com FCP → II → PIS/COFINS → ISSQN se kind S). Rateio T2 em `prorateWithResidue`
(proporção truncada 4 casas, resíduo no último item). IBS/CBS FORA desta onda
(P10 é stub no próprio legado — aguarda regulamento). 36 testes novos
(`tax-calc.test.ts`) validam cada fórmula contra os números de tributacao.md;
257/257 testes api + `tsc --noEmit` limpo, sem regressão.
**CSOSN (Simples Nacional) NÃO entrou nesta onda** — P2.9 do tributacao.md
está "mapeado em largura", sem detalhamento validado; implementar quando essa
seção for aprofundada com o autor, para não fabricar fórmula sem lastro.
**Onda 2 ENTREGUE (2026-08-20)**: catálogo MVA/FCP por UF×NCM —
`tb_state_mva_ncm`/`tb_state_fcp_ncm` (migration
`setes-api/migrations/030_state_tax_rates.sql`, aplicada em dev; bloco
canônico em `sql/03_schema_cliente_ddl.sql`), dado do CLIENTE (schema do
institution, decisão Q22 — sem tela no app ainda). Módulo de API completo
`state-tax-rates` (interface/dto/repository/service/controller/routes, CRUD
`/mva` e `/fcp`, flag retroativa `sql/31`) + as funções que a orquestração
vai consumir: `resolveMvaAliq` (igualdade exata de NCM) e `resolveFcpAliq`
(prefixo — mais específico vence, P7.1). 10 testes novos; 267/267 api,
`tsc --noEmit` limpo.

**Onda 3 ENTREGUE (2026-08-20, rodada R4 do Valdo)**: endpoints de
faturamento — módulo `billing` (7 arquivos + billing.context.ts).
Decisões R4: (Q1) DOIS endpoints — POST /api/billing/validate (valida TUDO
em lote, lista COMPLETA de issues, grava a regra achada por item em
`tb_order_item_tax_rule` origin 'A'; origin 'M' = escolha manual do cliente,
NUNCA sobrescrita — mata a dupla checagem do legado) e POST
/api/billing/invoice (fatura consumindo as regras GRAVADAS, sem rebuscar —
item sem regra = 422 REQUIRES_VALIDATION); (Q2) FINANCEIRO JÁ NESTA ONDA
(tb_financial/tb_financial_bills — 3º produtor, decisões 25/29; installment
elaborado vence, senão o prazo string gera as parcelas via parseDeadline +
parcelQuotas; set_financial='N' exclui o item); (Q3) nota MAX+1 por
MODELO+SÉRIE, série na config `invoice_serie` do Framework (interface
'billing' kind R, seed sql/32); (Q4) payload {orderId, useMvaOriginal?,
adjustment?{direction,cfopId}} — autoria SÓ do JWT. Migration 031
(`tb_order_item_tax_rule` — port da TB_ITENS_NFL_TRIBUTACAO com PK
incluindo kind + campo origin M|A; set_financial portado — verificado no
legado: flag "gera financeiro?"/TEMFINANCEIRO). Impostos gravados nas 7
tabelas do baseline (primeiro produtor — Rodada 3); nota nasce NÃO
transmitida (status '0'); ordem → 'F'; tudo em UMA transação
(persistInvoice, molde generateInvoice). Emitente Simples (CRT 1) = issue
na validação (CSOSN aguarda P2.9). MVA ajustada pela fórmula P2.7
(adjustMva) quando useMvaOriginal=false. ⚠️ Gap registrado: PRO_SUB_TRIB
(ST do produto) não tem coluna no formato novo — derivado da PRESENÇA de
CEST (deriveProductSt; lastro: CEST só existe p/ produto ST); confirmar na
próxima rodada se vira coluna própria + sync. 19 testes novos; 286/286 api,
tsc limpo; migration 031 + seeds 31/32 aplicados em dev.

**GATES da Onda 3 EXECUTADOS (2026-08-20)**: a entrega como estava
REPROVARIA (socrático 0.63; adversarial 2 HIGH) — corrigida na sessão:
1. **HIGH (nota sem imposto silenciosa)**: regra soft-deletada entre
   /validate e /invoice fazia loadPieces devolver {} e a nota sair SEM
   imposto com 201 — `findDeadRuleIds` no /invoice agora exige regra VIVA
   (422 REQUIRES_VALIDATION). "Sem rebuscar ≠ confiar cegamente na
   referência" (dica arquitetural do gate).
2. **HIGH (link 'A' órfão)**: validação cujo match FALHA agora LIMPA o link
   automático antigo (`clearAutoRuleLink` — 'M' intocável); antes, issue e
   fatura passavam JUNTAS com a regra velha.
3. **P1 (natureza por presença)**: tb_invoice_merchandise era incondicional
   e tb_invoice_service nunca nascia — agora cada ramo só nasce se há itens
   dele (conjugada = os dois); model por presença (mercadoria→55, só
   serviço→SE).
4. MEDIUMs: deadline absurdo → 422 INVALID_DEADLINE (teto 3650 dias — campo
   é texto livre do sync); item negativo → 422 NEGATIVE_ITEM_VALUE;
   destinatário sem entity_tax → issue (defaults silenciosos casavam regra
   errada); `aliq_st` gravada ERRADA (persistia a alíquota da regra, não a
   interna do destino usada no value_st) — corrigida; addDays em data LOCAL
   (UTC pulava o vencimento à noite); códigos novos no error-codes.ts;
   serie truncada ao varchar(10); dedupe de loadPieces por regra (N+1).
Todos os achados fixados em teste (24 no billing.test.ts); 291/291 api.

**Pontos abertos registrados (sem retrabalho obrigatório)**: leitura
otimista fora da transação (item editado entre cálculo e persist grava
snapshot morto — mitigado pelo FOR UPDATE do status; recomputar dentro da
transação é arquitetural, avaliar na onda das telas); MAX+1 da nota com
CAST sem índice (avaliar UNIQUE (institution, model, serie, number) +
número em coluna INT quando o fluxo de transmissão nascer); frete "some"
se todos os itens têm valor zero; sutileza 5 (presencial) nunca dispara
pelo billing (premissa: ordem web não é presencial — registrada);
refaturamento não existe (cancelamento/reemissão = fluxo futuro).

### Rodada 5 — FECHADA e EXECUTADA (2026-08-21, evidência real no legado)

Todas as 5 decisões confirmadas com leitura de código-fonte do Gestao2016
(não suposição) antes de implementar — Valdo pediu a verificação
explicitamente para R5-Q1/Q2/Q3.

- **R5-Q1 — FECHADA**: ajuste PODE gerar financeiro, e o par
  `(kind RA|PA, operation C|D)` NÃO é fixo por ramo — é calculado pela
  DIREÇÃO escolhida na tela de faturamento (evidência `Pc_Gera_Financeiro`
  em `UN_Fatura_Vda/Cpa/Srv/Ajt.pas`): venda e serviço = RA+C; compra =
  PA+D; ajuste INVERTE — Saída (devolução ao fornecedor) = PA+C (crédito
  nosso), Entrada (cliente devolve pra nós) = RA+D (débito nosso). Sem DDL
  nova: `tb_financial_bills.kind`/`.operation` já existiam no baseline sem
  produtor (mesmo padrão de [[tabela-sem-consumidor-nao-e-morta]]).
  Implementado: `resolveFinancialPolarity` em `billing.context.ts`, usado
  por `invoiceOrder` com `input.adjustment.direction` (mesmo campo já usado
  no match da regra — não é campo novo). **Pendente, fora desta rodada**:
  o legado também exige VENDEDOR obrigatório quando ajuste Entrada gera
  crédito (`UN_Fatura_Ajt.pas:754-782`) — `tb_order_stock_adjust` não tem
  `tb_salesman_id` no schema novo; decisão de modelagem (nova coluna?
  opcional só quando há financeiro?) fica para quando essa trava for
  implementada — não bloqueou a Rodada 5 porque não é uma das 5 perguntas.
- **R5-Q2 — FECHADA**: elaborado que diverge do valor atual da ordem
  **BLOQUEIA (422)** — evidência `TControllerPedido.ValidaParcelamento`
  (`ControllerPedido.pas:1490`): `IF (valorPedido <> valorParcelado) AND
  (valorParcelado > 0) THEN BLOCK`. Implementado em `invoiceOrder`:
  soma do elaborado ≠ `financialBase` → 422 `INSTALLMENT_MISMATCH`.
- **R5-Q3 — FECHADA**: NCM ausente/inválido é gate DURO no legado,
  revalidado no momento de faturar — evidência `Fc_Valida_Itens_Nota`
  (`tributacao.pas:1138-1417`): regra ausente e NCM inválido BLOQUEIAM;
  só "Código de Benefício Fiscal" ausente é aviso (`Result:=False`
  comentado no código-fonte). Implementado: `invoiceOrder` agora bloqueia
  com 422 `MISSING_NCM` quando item de mercadoria não tem NCM — não confia
  só no `/validate` anterior (itens podem mudar entre as duas chamadas).
- **R5-Q4 — FECHADA**: ISS zero sem aviso é aceitável — decisão do Valdo:
  "temos que aguardar recusa no momento da autorização" (SEFAZ/prefeitura
  são o gate real). Nenhuma mudança de código necessária.
- **R5-Q5 — FECHADA**: derivação por CEST permanece (não vira coluna
  própria agora) — reforçada pelo achado de que a checagem de CEST no
  legado está MORTA/comentada (`tributacao.pas:1372-1397`), confirmando
  que o próprio legado abandonou esse caminho.

### Observações fiscais (T6/P11) — IMPLEMENTADO (2026-08-22)

Motor `billing.observations.ts` (funções puras) + wiring em `billing.service.ts`/
`billing.repository.ts`. Evidência linha a linha das ~20 rotinas
`Pc_Obs_CSTxx`/`Pc_Obs_CSOSNxxx` extraída de `tributacao.pas:4185-5432`
(agente dedicado — ver achados completos no `tributacao.md` §P11, não
repetidos aqui). "Regra 5" do mapeamento (colapsar em UMA tabela
declarativa) aplicada: `REGIME_GROUPS` cobre CST 00/10/20/30/40/41/50/51/90
+ CSOSN 101/102/103/201/202/203/300/400/500/900.

**3 bugs comprovados do legado CORRIGIDOS (decisão do Valdo — "corrigir os
3")**: CST 80 (procedimento vazio no legado; nem existe no nosso domínio,
nada a fazer); CSOSN 400 (bind de OBS_CODMHA ausente no legado — nunca
disparava; aqui filtra certo); CSOSN 201 (placeholder trocado no legado —
base/valor ST calculados mas nunca chegavam ao texto; aqui usa os 4 campos
que o próprio comentário do código-fonte sugeria: base ST, valor ST,
alíquota crédito, valor crédito).

**Decisão mantida (paridade)**: quando há mais de uma observação distinta
cadastrada pro mesmo grupo, usa só a 1ª (replica o "lê só a 1ª linha" do
legado, presente em ~10 das ~19 rotinas mesmo com agregação — `GROUP BY
OBS_DETALHES` + `First` sem loop).

**Gap registrado (fora desta rodada)**: CST 60/70 dependem do rastreio de
ST retido (P2.8, `Pc_ControleRastreioICMSST`) — explicitamente fora do
`calc.ts` desde a Onda 1 do W2. Sem esse rastreio não há campo confiável
pra alimentar o texto; esses 2 grupos ficam sem observação regime-específica
até a frente do rastreio nascer (nota fatura normal, só sem essa observação).

**Imposto Aproximado (Lei 12.741/2012) — escopo AMPLIADO pelo Valdo** (a
sugestão inicial de deixar fora foi corrigida por ele): usa
`setes_central.tb_ncm` (aliq_nac/aliq_imp/aliq_est/aliq_mun — catálogo
IBPT já existia no baseline central, sem produtor até aqui, mesmo padrão
de [[tabela-sem-consumidor-nao-e-morta]]). Percentual TOTAL por item
(`ITF_IMP_APROX` do legado) persistido SEMPRE (independente de config) em
`tb_order_item_tax_rule.approx_tax_aliq` — coluna nova, migration 032,
local escolhido porque é a tabela que a Onda 3 já criou pra registrar como
cada item foi tributado (decisão do Valdo, sem lembrar o nome exato — a
tabela era a candidata natural). A OBSERVAÇÃO agregada na nota (média
ponderada por esfera Nacional/Estadual/Municipal, texto literal do legado)
é gated por config nova `billing/approx_tax_enabled` (seed sql/34, default
'N') + só ordem de venda (`branch==='sale'`, equivalente ao "natureza
contém VENDA" do legado).

Persistência: `tb_invoice.note` (coluna do baseline já existente, sem
produtor) recebe o texto concatenado (general + regime + ISSQN + imposto
aproximado, um por linha) — sem tabela nova de observações; XML final
(`infCpl`) só tem UM campo de texto mesmo, a concatenação já reflete isso.

20 testes novos em `billing-observations.test.ts` + mocks atualizados em
`billing.test.ts`; 328/328 api, `tsc --noEmit` limpo. Migrations/seeds
aplicados em dev: 032 (approx_tax_aliq) + sql/34 (approx_tax_enabled).

### CSOSN (P2.9) — IMPLEMENTADO (2026-08-21)

`calcIcmsCsosn` (`calc.ts`) + `CSOSN_GROUPS` (101/102/103/300/400/201/202/
203/500/900) — detalhe completo em `Infra-IA/Gestao2016/tributacao.md`
§P2.9. Crédito SN via config nova `billing/sn_credit_aliq` (seed sql/33,
aplicado em dev). Bloqueio de emitente Simples REMOVIDO de
`loadContext` — faturamento por CSOSN liberado. 12+2 testes novos;
308/308 api.

### Caixa (W3.2) — IMPLEMENTADO (2026-08-22, parecer setes-conceito)

Objeto de domínio NOVO pro lado web: abertura/fechamento de caixa por
dia+usuário (terminal fixo 0), passou pelo guardiao-conceitual ANTES do
DDL. Achado do parecer: a hipótese registrada em memória de sessão
anterior (`bankAccountId=0` como conta bancária SENTINELA) era maquete —
`bankAccountId=0` já é usado corretamente em
`settlements.repository.settleBatch` como marca de NATUREZA do movimento
(stage 'B'/'C'), não como linha fake em `tb_bank_account`; precedente real
no legado (`MVF_CODCTB=0`). `tb_cashier`/`tb_cashier_items` (baseline,
dormentes pro lado web) eram a fundação certa — sem DDL novo, só
`tb_financial_statement.tb_cashier_id` (migration 033) pra amarrar o
movimento à sessão.

Detalhe completo em `Infra-IA/Gestao2016/financeiro.md` §5.4b (parecer +
6 questões fechadas). Peça `@shared/financial-settlement` (settleOneTitle/
writeManualCashierMovement/tryAutoSettleCash — módulo NUNCA importa
módulo, billing e cashier consomem a peça, não um ao outro) + módulo
`cashier` (open/current/:id balance/:id withdraw/:id close). Gate de
faturamento em espécie SEM caixa aberto: NÃO bloqueia (decisão do Valdo)
— título fica aberto pra baixa manual depois. 23 testes novos; 352/352 api.

**Retomar por**: (1) telas de processo
no app (validar/faturar/caixa — EM ANDAMENTO, ver módulo `orders` abaixo);
(2) smoke E2E validate→invoice contra banco dev (gate adversarial pediu —
mock verde ≠ banco real, lição da Onda 1); (3) decisão pendente do
vendedor obrigatório no ajuste com crédito (R5-Q1); (4) baixa automática
de PIX (kind='X', conta corrente pré-cadastrada, sem gate de caixa —
deixada de fora desta rodada); (5) rastreio de ST retido (P2.8, gap do
motor de observações CST 60/70).

### Pendência registrada (fora de escopo, NÃO investigar sem pedido explícito)

`setes-api/src/modules/sync/` (prefixo `/sync/*` DENTRO do próprio
setes-api — distinto do projeto `setes-sync`, ver
[[arquitetura-dois-grupos-boundary]]) tem 3 endpoints registrados e ativos
(`ordersale.ts`/`orderpurchase.ts`/`orderstockadjust.ts`) referenciando
colunas que NÃO existem mais no schema atual (`tb_order.situation` em vez
de `status`, `tb_order_sale.tb_payment_types_id` inexistente,
`tb_order_item.tb_merchandise_id`/`price` em vez de `tb_product_id`/
`unit_value`) — qualquer chamada real quebraria. Achado ao mapear
dependências pro módulo `orders` (2026-08-22); investigação PAUSADA a
pedido do Valdo (não é escopo desta sessão). Fica registrado pra quando
ele quiser retomar.

### Módulo `orders` (pedido de venda/conjugado) — EM DESENHO (2026-08-22)

Motivação: não existe NENHUM jeito de criar pedido de venda pelo app hoje
(só `service-orders`, que é Ordem de Serviço — fluxo diferente); billing
só CONSOME um orderId já existente. Levantamento de dependências (agente
Explore) mapeou fundação pronta × gap real:

- **Fundação pronta**: `tb_order_service`+`tb_order_sale` coexistem sem
  impedimento estrutural na mesma `tb_order` (conjugada é possível);
  `tb_product.kind` (P/M/S, migration 019) já resolve a natureza do item;
  `tb_order_totalizer` tem padrão pronto de escrita via API
  (`service-orders.repository.recalcTotalizer`); `service-orders` é o
  molde estrutural mais próximo (openOrderDto→createOpenOrder MAX+1→
  sub-recurso de itens→lockOpenOrder por status).
- **Gap real**: NÃO existia endpoint de consulta de mercadoria (só serviço,
  via `service-orders` lookup `kind='S'`); resolução de `tb_stock_list`/
  `tb_price_list` pro item novo não tem nenhum precedente (dado existe via
  sync, mas nada LÊ hoje); vendedor é SEMPRE escolha explícita (sem
  vínculo user→salesman; `tb_customer.tb_salesman_id` sugere default).

**IMPLEMENTADO (2026-08-22)**: módulo `orders` (backbone tb_order + ramo
tb_order_sale SEMPRE presente; tb_order_service nasce por PRESENÇA — 1º
item de serviço adicionado cria o ramo, `open_lock` SEMPRE NULL, backbone
DISTINTO do "1 OS aberta por cliente" de service-orders, mesma tabela por
natureza do ramo, sem colisão de unique key). SEM DDL nova — só peças
prontas usadas: `tb_product.kind` (P/M/S, migration 019) decide o ramo do
item automaticamente; `recalcTotalizer` no molde de
`service-orders.repository`; preço sempre DIGITADO (sem
`tb_price`/`tb_stock_list` — mesmo padrão de service-orders, decisão
implícita por paridade). Faturamento NÃO é ação deste módulo — a tela
chama `/api/billing/validate` + `/api/billing/invoice` (já prontos).
Endpoints: `POST /api/orders` (abre, 400 SALESMAN_REQUIRED se não houver
vendedor explícito nem default), `GET /api/orders` (lista paginada,
`hasService` indica conjugada), `GET /api/orders/:id`, `GET /api/orders/
merchandise-lookup` (P/M, NOVO), `GET /api/orders/service-lookup` (S,
espelha service-orders sem importar — módulo nunca importa módulo),
`POST/PUT/DELETE /api/orders/:id/items[/:itemId]`, `DELETE /api/orders/:id`
(cancela). `getOrderBranch` do billing NÃO precisou de ajuste — sale
sempre existe pra ordem deste módulo, itens mistos (Sale+Service) já
eram separados por `productKind` na hora de faturar (P1 já testado).
14 testes novos; 366/366 api. Flag `orders` (seed sql/36, aplicada em dev).

**Tela Flutter IMPLEMENTADA (2026-08-22, agente setes-form-builder)**:
`apps/web/lib/app/modules/orders/` completo (domain/data/presentation+
bloc, molde `service_orders`); lista com abas Abertos/Faturados; detalhe
com dialog de item usando `SegmentedButton` Mercadoria×Serviço (dois
lookups, uma lista única de itens com indicador visual do ramo); botão
"Validar e Faturar" chama `/api/billing/validate` (mostra issues se
houver) → `/api/billing/invoice` em cadeia. Não existia módulo Flutter
`billing` — chamadas HTTP direto no datasource do `orders`, sem importar
módulo. `flutter analyze` limpo. Seed que faltava (interface não aparecia
no menu — módulo pronto mas invisível) criada e aplicada em dev: `sql/37`
(`tb_interface` id 29 'orders', grupo 'Vendas' — chave i18n nova, pt
"Vendas"/en "Sales" — + `tb_institution_has_interface` + page_size).

**Smoke E2E EXECUTADO (2026-08-22) contra banco dev real** — via curl
direto na API (validação visual do Flutter bloqueada: screenshot exige o
painel do Browser aberto no cliente, fora do controle da sessão):
1. `POST /api/orders` sem vendedor nem default → 400 `SALESMAN_REQUIRED` ✅
2. `POST /api/orders` cliente com vendedor padrão na carteira → abre ✅
3. Lookups mercadoria/serviço → dados reais devolvidos ✅
4. Item mercadoria + item serviço no MESMO pedido → conjugada: `kind`
   Sale/Service corretos, `tb_order_service` criado por presença,
   totalizer somou os dois (100+100=200) ✅
5. `GET /api/orders` lista `hasService:true` corretamente ✅
6. `POST /api/billing/validate` → `branch:'sale'` detectado certo mesmo
   sendo conjugada; issues reais (emitente sem tributação + item sem
   regra fiscal — produto de teste sem regra cadastrada, esperado); item
   de SERVIÇO não exigiu regra fiscal (correto — só mercadoria) ✅
7. `DELETE /api/orders/:id` cancela e some da lista Abertos ✅
Produto de teste (id 16, mercadoria fictícia) criado e REMOVIDO ao final;
pedido de teste ficou soft-deleted (cancelado), sem lixo residual visível.

**Tela Flutter do `cashier` IMPLEMENTADA (2026-08-22)**:
`apps/web/lib/app/modules/cashier/` completo (14 arquivos, camadas
completas) — tela de SESSÃO/STATUS (não lista): `/current` decide estado
vazio ("Abrir Caixa") × painel ativo (saldo derivado + formas de
pagamento com registrado + Retirar/Transferir + Fechar Caixa); dialog de
fechamento com relatório registrado×contado×diferença (nunca só "ok").
Lookup de conta bancária via `/api/bank-accounts` direto (sem importar
módulo). Grupo de menu **Financial** reaproveitado de settlements/
bank-accounts (sem i18n novo). `flutter analyze` limpo (verificado 2x,
pelo agente e independentemente). Seed `sql/38` (interface id 30
'cashier') aplicada em dev. Bug pego durante a construção: campo do bloc
chamado `close` colidia com `Bloc.close()` — corrigido pra
`closeCashier`.

**Achado de processo (2026-08-22)**: o agente `setes-form-builder`, ao
ser chamado via `Agent()` direto, respondeu 2x com um PLANO em vez de
executar (relatório de "completed" sem nenhum arquivo no disco) — só
funcionou quando o brief completo foi reenviado E ele mesmo disparou um
sub-agente `general-purpose` que de fato escreveu os arquivos. Para
próximas chamadas a este agente: sempre VERIFICAR o filesystem antes de
aceitar um relatório de conclusão como real (ver
[[feedback-verificar-codigo-antes-doc]] — mesmo princípio, agora
aplicado a "verificar arquivo antes de aceitar relatório de agente").

### Gate de entrega EXECUTADO (2026-08-22) — revisar-riscos-sistemicos + testar-adversarial

Rodados sobre toda a entrega de 2026-08-21/22 (R5, CSOSN, observações,
cashier+financial-settlement, orders). **Revisão socrática: score 0.68
(abaixo do limiar 0.70)** — 2 achados:
1. **CORRIGIDO em sessão**: `tryAutoSettleCash` rodava dentro da MESMA
   transação da nota sem isolamento — qualquer falha TÉCNICA inesperada
   ali (não só os 3 motivos de negócio já tratados) derrubava a nota
   inteira, contradizendo a decisão "faturar sem baixar". Corrigido com
   `SAVEPOINT`/`ROLLBACK TO SAVEPOINT` isolando só a baixa; teste novo
   prova (`gate socrático 2026-08-22` em billing.test.ts). 367/367 api.
2. **Questão para o Valdo (Q-Caixa 7)**: `openCashier`
   (`cashier.repository.ts`) trava com `SELECT...FOR UPDATE` sem índice
   de apoio em `tb_cashier` — a checagem "1 caixa aberto por
   usuário/dia" pode ter janela de corrida quando NÃO existe linha
   nenhuma pra travar (SELECT que devolve 0 linhas não garante gap lock
   sem índice líder cobrindo o predicado). Abrir índice novo
   `(tb_institution_id, terminal, tb_userid, hr_end)` — mesmo padrão de
   migration usado no resto da fase — ou aceitar o risco (abertura de
   caixa é ação rara, manual, baixo volume de cliques simultâneos)?

Achados descartados (verificados, sem risco): atomicidade de `orders`
addItem OK (tudo numa transação); institutionId/userId sempre do JWT nos
3 módulos novos; sem vazamento cross-schema; registro nos módulos segue
o padrão simétrico.

**QA adversarial: score 0.30, REPROVADO** (1 CRITICAL + 1 HIGH + 1 MEDIUM
+ 1 LOW) — TODOS corrigidos em sessão, verificados contra o banco dev
REAL (não só mock, lição da Onda 1 repetida — "verde no mock, 500 no
banco real"):
1. **CRITICAL**: migration 028 renomeou `tb_cashier.tb_userid` →
   `tb_user_id`, mas `cashier.repository.ts` (5 pontos) e
   `financial-settlement.ts` (`findOpenCashierId`, usado pela baixa
   automática do billing) continuavam lendo o nome VELHO — `GET /api/
   cashier/current`, `POST /open`, `GET /:id` sempre 500; nenhum usuário
   conseguia abrir caixa. Corrigido (rename); confirmado com curl real:
   open→current→close funcionando ponta a ponta.
2. **HIGH**: `POST /api/cashier/:id/withdraw` e `/close` filtravam só por
   institution — qualquer usuário da MESMA institution sacava/fechava
   caixa de OUTRO usuário sem checagem de posse. Corrigido:
   `AND tb_user_id = ?` na trava (404 sem vazar existência, mesmo padrão
   multi-tenant da casa); confirmado com curl (userId 2 tentando caixa do
   userId 1 → 404). 2 testes novos em cashier.test.ts.
3. **MEDIUM**: `POST /api/orders/:id/items` aceitava produto INATIVO por
   ID direto (só os lookups filtravam `active='S'`, a inclusão não).
   Corrigido; confirmado com curl. 2 testes novos em orders.test.ts.
4. **LOW**: lookups de `orders` (`merchandise-lookup`/`service-lookup`)
   não usavam `escapeLike` no filtro (regra da casa — memória `banks`).
   Corrigido.

**Q-Caixa 7 FECHADA (2026-08-22)**: Valdo escolheu criar o índice.
Migration `034_cashier_open_lock_index.sql` — `idx_cashier_open_lock
(tb_institution_id, terminal, tb_user_id)` em `tb_cashier`, aplicada em
dev e confirmada via `SHOW INDEX`. Fecha a janela de corrida do
`SELECT...FOR UPDATE` de `openCashier` (antes só a PK cobria a tabela,
sem índice de apoio pro predicado da trava).

**Retomar por**: baixa automática de PIX; rastreio de ST retido (P2.8);
validação VISUAL do Flutter (pede o painel do Browser aberto no cliente).
(R5-Q1 vendedor no ajuste: RESOLVIDA pela rodada Comissão/Devolução abaixo.)

### Comissão por item + Devolução de mercadoria — IMPLEMENTADO (2026-08-24, rodada Q1–Q5 + D1–D4)

Fecha a pendência R5-Q1 (vendedor no ajuste). Correção de entendimento do
Valdo: ajuste em si NÃO exige vendedor — a exigência real é a DEVOLUÇÃO
com crédito, que presume venda anterior comissionada e gera comissão
NEGATIVA. Legado verificado linha a linha (`UN_Fatura_Ajt.pas`:
Chbx_Financeiro/ChBx_DevolucaoMercadoria, `Fc_VerificaItemDevolvido`,
`VerificaExistenciaDevolvido`, `Pc_GeraComissaoNegativaDevolucao` →
`Pc_Comissao`/TB_COMISSAO, elo TB_ITENS_DEV).

**Decisões do Valdo (2026-08-24)**:
- Q1: peça mínima de comissão nasce AGORA; cálculo POR ITEM (≠ legado,
  que era por pedido). Rascunho dele adaptado ao padrão da casa.
- Q2: devolução POR ITEM; estorno = lançamento com value NEGATIVO, nunca
  apagar/alterar (filosofia do financeiro imutável). Corrige o achado
  literal do legado (devolução parcial estornava a comissão INTEIRA do
  pedido original).
- Q3: equivalente web da TB_ITENS_DEV criado (`tb_order_item_return`).
- Q4: dois controles no ajuste Entrada — Financeiro (pedido+vendedor →
  crédito + comissão negativa) × Devolução (controle por item via elo).
- Q5: `kind` da comissão 'F' (faturamento) | 'R' (recebimento); modo por
  CONFIG (`commission_mode`, registrada SEM seed/engine — entra quando a
  peça completa nascer). Nesta versão só 'F' tem produtor.
- D1: `tb_kickback` do baseline (mesmo conceito, nome errado — kickback =
  propina; dormente, zero consumidores) DROPADA; renasce `tb_commission`.
- D2: `tb_entity_id` do rascunho → `tb_customer_id` (papel ≠ entidade).
- D3: vendedor da devolução DERIVADO do `tb_order_sale` do pedido
  original ("do jeito que falei fica ambíguo") — o diálogo só pede o
  pedido; a validação de igualdade do legado morre por construção.
- D4: `doc_value`/`ali_value` → `base_value`/`aliq`/`value` (snapshot
  imutável do valor calculado).
- Terminal: `tb_commission.terminal` na PK e amarrado à ordem pela FK
  composta (pedido explícito do Valdo — já nasceu assim).

**Entregue**: migration 035 (DROP tb_kickback + `tb_commission` PK
(id,institution,terminal) + `tb_order_item_return` PK = PK do item
devolvido, colunas `*_ori` + `tb_order_stock_adjust_return` âncora PK =
PK do ajuste) — aplicada em dev; blocos canônicos no sql/03 (lição:
FK composta com `kind` varchar exige COLLATE igual ao do tb_order_item
do baseline, general_ci — errno 150). Peças `@shared/commission`
(resolveCommissionAliq com clamp 0..100 — kickback_product='S' →
tb_price.aliq_kickback senão tb_salesman.aliq_kickback; insertCommissions
em LOTE, MAX+1 único por nota) e `@shared/order-return` (buildReturnPlan
com validações do legado + acúmulo intra-plano + QTY_EPSILON;
assertReturnableInTx = revalidação DENTRO da transação sob FOR UPDATE do
pedido ORIGINAL; persistReturn; elo aponta o item MAIS RECENTE do produto
— paridade ITF_CODIGO DESC). Billing: `adjustment.returnedOrderId` nos
dois endpoints (issues em lote no /validate; gates duros
RETURN_REQUIRES_ENTRY/RETURN_INVALID no /invoice, revalidado padrão
R5-Q3); venda gera comissão POSITIVA por item (kind 'F', base = valor
líquido do item, aliq 0 = sem linha, cache por produto×lista) e devolução
gera NEGATIVA espelhando a alíquota POSTADA da venda (fallback fonte
atual p/ vendas pré-peça) — tudo na transação da nota. Swagger atualizado.

**Gates (2026-08-24)**: socrático 0.66 REPROVOU como estava (R1 saldo não
acumulava itens irmãos do plano; R2 TOCTOU — plano validado fora da
transação com lock só no ajuste) + adversarial 0.30 REPROVOU (CRITICAL:
`tb_price_list_id` foi dropada de tb_order_item pela migration 013 — o
BASELINE mente; a seleção nova quebrava TODO /validate//invoice com 500
no banco real, mock verde não pegou — MESMO padrão da calibração
2026-08-16; + HIGH TOCTOU; MEDIUM clamp; LOW serviço no plano). TODOS
corrigidos em sessão e fixados em teste; queries reformadas provadas
contra o banco dev real (smoke venda 6533). 399/399 testes.
RE-SCORE socrático 0.80 ✅ (R1/R2/R5/R6 verificados mortos; invariante
nas duas camadas; ordem de locks sem deadlock) + adversarial 0.85 ✅
passou=true (4/4 achados provados corrigidos contra o banco real, zero
vulnerabilidade remanescente). LOWs REGISTRADOS sem retrabalho:
assertReturnableInTx revalida só QUANTIDADE sob lock (cliente/valor
unitário da origem editados na janela mínima passam); comentário-
sentinela adicionado no persistInvoice (SUMs do recomputo devem ser as
1ªs leituras não-locking da transação — SELECT simples antes congelaria
o snapshot antes do lock). Caso não testado registrado: E2E HTTP
/validate→/invoice de devolução completa (§4.6 — teste jest permanente
quando a rodada fechar as questões).

### Questões da rodada Comissão/Devolução — FECHADAS (2026-08-24, mesma sessão)

1. (R3/Q-C) **SIM — origem precisa estar FATURADA** (status 'F').
   EXECUTADO: issue no buildReturnPlan + recheck sob lock no
   assertReturnableInTx ("origem deixou de estar faturada sob lock →
   422"); 401/401 testes.
2. (R4) **Reconciliação = SEMPRE lançamento novo de compensação** —
   nunca soft delete/UPDATE em tb_commission. Hoje não existe caminho
   que solte devolução faturada (status 'F' → 409); a regra fica
   registrada no cabeçalho da peça @shared/commission para as frentes
   futuras (cancelamento de nota, estorno).
3. (R7/Q-A) **NÃO — ignorar PDV**: devolução contra venda de terminal≠0
   fora do escopo; o terminal=0 fixo nas queries da peça é o desenho
   decidido, não pendência.
4. (Q-B) **Item com valor LÍQUIDO comissiona** — inclusive serviço na
   conjugada; comportamento atual confirmado (paridade com o legado, que
   somava TB_ITENS_NFL sem filtrar).

### Módulo order-returns (Devolução no app) — IMPLEMENTADO nos DOIS lados (2026-08-24)

Parecer setes-conceito APROVOU: módulo novo `order-returns` = 1º PRODUTOR
do ramo tb_order_stock_adjust (o billing sabia faturar ajuste mas ninguém
o criava); lista filtra por EXISTÊNCIA da âncora (módulo irmão futuro de
ajuste avulso lista os SEM âncora — disjuntos por construção). Decisões
do Valdo: devolução NASCE na aba Faturados do orders (ação "Devolver",
itens pré-carregados); contrato do billing ENCOLHIDO — adjustment =
{cfopId}, direction DERIVADA do ramo e pedido original DERIVADO da âncora
(fonte única por construção; supersede a parte da R5-Q1 "direção escolhida
no faturamento"); âncora nasce na ABERTURA (fato gerador = decidir
devolver; persistReturn só VALIDA e grava elos — sem insert-se-ausente);
devoluções abertas CONCORRENTES permitidas com pré-carga descontando as
irmãs; pré-carga POR PRODUTO (um item por produto, saldo agregado, unit do
item mais recente); sem re-adicionar item (cancela e reabre).

API: modules/order-returns (6 arquivos, shape de AÇÕES da tela-de-processo
— POST abre da venda 'F' com pré-carga em 1 transação, GET lista/detalhe
com maxQuantity, PUT quantidade com teto-cortesia, DELETE item/cancelar);
peça order-return ganhou getAnchor + getOpenReturnQuantityByProduct.
APP: modules/order_returns (17 arquivos — abas, detalhe dirigido pelo
estado, dialog de faturar com lookup CFOP, encadeamento validate→invoice)
+ ação Devolver no detalhe faturado do orders; rotas + i18n pt/en.
Seeds 39 (flag, + insertDefaultFlags) e 40 v2 (interface id DINÂMICO=31,
grupo Vendas). 414/414 api; flutter analyze limpo; smoke E2E real (abrir→
detalhe→PUT→validate com âncora derivada→cancelar→limpeza hard).

**GATES (2026-08-24)**: socrático 0.78 ✅ + adversarial: código resistiu a
51 ataques reais SEM falha, mas REPROVOU por 1 HIGH de SEED — o sql/40 v1
fixava id 30 JÁ ocupado pelo cashier (seed 38) e o INSERT IGNORE silenciou
(interface nunca nasceu). LIÇÃO: seed de interface NUNCA fixa id — id
DINÂMICO MAX+1 + vínculos keyed por i18n_key (padrão seed 27). Corrigido
(v2, id 31, verificado no banco). Achados socráticos BAIXADOS em sessão:
R1 assertReturnableInTx compara plano × itens VIVOS sob o lock (PUT no
meio → 422 REQUIRES_VALIDATION); R2 cortesia do PUT fora da transação
(pool não se auto-estrangula); R3 códigos novos no error-codes.ts +
ADJUST_PARAMS_REQUIRED atualizado; R4 falha de billing recarrega o
detalhe (teto fresco); R5 guard de duplo-clique no Devolver.
PENDÊNCIAS registradas: teste jest E2E HTTP permanente da devolução
completa (§4.6 — quando houver emitente com tributação no dev); Q-R6 do
fluxo (pós-abertura aterrissa na LISTA; detalhe direto = decisão do
Valdo se incomodar).

## Parecer conceitual (setes-conceito, 2026-08-20) — persistência do cálculo por item

**Primeira leitura (CORRIGIDA pelo Valdo)**: o parecer inicial leu "nenhum
endpoint do sync lê/escreve nas 8 tabelas `tb_order_item_icms/_icms_fcp/_ipi/
_ipi_back/_ii/_pis/_cofins/_issqn` + `tb_observation`" como sinal de tabela
MORTA (mesmo perfil da decisão 30) e recomendou aposentar + nascer família
canônica nova. **Está ERRADO**: essas tabelas nunca tiveram produtor porque
o cálculo por item é NOVO NO ERP WEB — o Delphi legado nunca mandou esse
nível de detalhe pro sync (só agregados). O ERP (W2) é o PRIMEIRO produtor
delas, não um substituto — mesmo padrão da decisão 29 (financeiro reusa
`tb_financial`/`tb_financial_bills` existentes). A analogia com a decisão 30
foi aplicada errada (aquela tabela FOI SUBSTITUÍDA por desenho novo; estas
estão esperando o primeiro produtor).

**Decisão corrigida (2026-08-20)**: **REUSAR as tabelas do baseline**, sem
DDL nenhum nesta onda — elas já existem com a estrutura certa:
`tb_order_item_icms` (:1373), `tb_order_item_icms_fcp` (:1413, sem PK — nota
abaixo), `tb_order_item_ipi` (:1448), `tb_order_item_ii` (:1433),
`tb_order_item_pis` (:1509), `tb_order_item_cofins` (:1270),
`tb_order_item_issqn` (:1481) — todas em `setes-api/src/migrations/sql/
001_baseline.sql`. `tb_order_item_ipi_back` (:1469, sem PK, colunas mínimas
`p_ipi/v_ipi`) fica de fora do W2 — parece artefato de rotina de backup do
Delphi, não uma peça do domínio; não é dropada, só não é usada.

**`tb_observation`** (:1198) é o CATÁLOGO de textos de observação (id,
institution, description, note, general) — já referenciado por
`tb_tax_rule.tb_observation_id` desde a Onda 1. NÃO precisa de tabela nova
por item: o "nível do item" (resposta do Valdo à R3-Q3) já existe
NATURALMENTE, porque cada item carrega a regra que casou (com seu
`observationId`) — gerar o texto da nota é **DISTINCT dos `observationId`
dos itens da nota**, sem tabela de ligação nova.

**Achado de estrutura relevante para o mapeamento (P9/decisão 11)**:
`tb_order_item_ii` só tem `base_value/customs_expense/tag_value/iof_value` —
bate exatamente com `Pc_DefineII` (P9: `vBC/vDespAdu/vII/vIOF`, só ad
valorem). AFRMM/IRPJ/CSLL (decisão 11, peça `IiPiece` completa) NÃO têm
coluna aqui — Q32 já registrava que esses campos "agem FORA da
tributacao.pas... pertence à frente da Compra/importação (futura)". Ou seja:
`tb_order_item_ii` recebe só o resultado simples do motor; a peça completa
da REGRA (`IiPiece`) segue existindo para quando a frente de Compra nascer.

## ⚠️ Questões pendentes (Rodada 3 — decisões do Valdo)

- ~~R3-Q1~~ — ✅ RESPONDIDA: `tb_order_item_icms_fcp` já existe, reusar.
- ~~R3-Q2~~ — ✅ CORRIGIDA (a pergunta partia de premissa errada — ver acima):
  NENHUMA tabela é dropada; todas as 9 (+ `_ipi_back`, sem uso) permanecem.
- ~~R3-Q3~~ — ✅ RESPONDIDA: nível do item — já resolvido naturalmente via
  `tb_tax_rule.tb_observation_id` de cada item + DISTINCT na geração da nota.

**Rodada 3 FECHADA. Sem DDL nesta onda — as 7 tabelas de persistência por
item já existem e só precisam de um escritor (o motor de orquestração da
próxima onda).**

**Nota do Valdo (2026-08-20)**: essas 7 tabelas NÃO precisam de endpoint de
sync — são cálculo INTERNO do momento do faturamento (o sync nunca as toca,
e está certo que não toque). O que precisam é de repository/service internos
(controller/model, no sentido do padrão da casa) para OPERAR o cálculo e o
salvamento — ou seja: módulo de orquestração do faturamento com
repository próprio escrevendo nelas, sem rota `/sync/*` correspondente.

1. Para cada item: buscar regra (motor §2 do tributacao.md — coringas, precedência
   NCM, estado exato×coringa, finalidade 0 no ajuste, presencial, escolha por item)
2. Regra não encontrada → INTERROMPE com alerta descritivo (produto a produto +
   critérios do destinatário) — mesmo conteúdo do legado (§3)
3. Calcular na ordem T1: rateio (resíduo no último) → IPI → ICMS (FCP antes do
   regime) → II → PIS/COFINS → ISSQN (kind S) → IBS/CBS (último, base subtrativa)
4. Persistir itens+impostos → gerar observações fiscais (catálogo, T6) → cabeçalho
5. Nota mercadoria+serviço = ramos; cada ramo autorizará no seu documento (fase futura)

### W3 — Financeiro (novo)
1. Nascimento na confirmação do faturamento (automático pela negociação OU tela
   confirmativa) — depois disso, manutenção SÓ no módulo financeiro.
   **Materialização (decisão 25)**: se o pedido tem parcelamento elaborado, usa-o;
   senão, o PRAZO gera o parcelamento neste momento — o financeiro nunca lê o
   prazo diretamente
2. Meios: espécie (à vista→caixa; a prazo→CARTEIRA), PIX (à vista→conta corrente),
   CHEQUE (baixa com o cheque; dívida vira o cheque), BOLETO (baixa por
   extrato/retorno/API — nunca no nascimento), CARTEIRA (manual)
3. Vida: juros/mora do cliente (sem automação, exceto boleto), reprogramação por meio
4. Morte: cancelamento não-autorizado → soft-delete total + ordem volta à origem;
   nota autorizada cancelada → ordem NÃO volta (cópia de ordem) + financeiro
   soft-delete COM estorno em cadeia das baixas; estorno em dinheiro exige caixa aberto
5. Caixa por dia/usuário; cheque com 2 elos de quitação; cartão com contrato
   (taxa+prazo → lançamento futuro + conciliação)

## Decisões arquiteturais registradas (herdadas do mapeamento — permanentes)

| # | Decisão | Origem |
|---|---|---|
| 1 | Regra de Tributação decomposta: `tb_tax_rule` (seletor) + peças 1:1 por tributo; **presença = incidência** | §6.5 tributacao.md |
| 2 | PIS e COFINS = UMA peça/implementação (`kind P\|C`) — "PIS igual a COFINS" | Q24 |
| 3 | ISS do município do PRESTADOR (cMunFG + alíquota) | Q27 |
| 4 | Item LC 116 POR produto-serviço (config global morre) | Q28 |
| 5 | Base IPI = mercadoria líquida de desconto incondicional + frete + seguro + acessórias (RIPI 190 + STF RE 567.935) | Q25 |
| 6 | Base IBS/CBS pela fórmula oficial (frete somado; ICMS 1×) | Q33 |
| 7 | FCP-ST usa a MESMA função de base do ICMS-ST | Q30 |
| 8 | Via manual segue a REGRA GERAL (só troca a fonte da alíquota) | Q19/Q21 |
| 9 | `TB_MVA_UF_NCM`/FCP no SCHEMA DO CLIENTE — dado fiscal interpretável NÃO se compartilha; tela vinculada ao Estado (imutável) | Q22 |
| 10 | SEM peça ISS na regra (ISS vem de prestador/produto/cliente) | Q27/Q28 + §6.5c |
| 11 | Peça II completa (II+AFRMM+SISCOMEX+IRPJ+CSLL — código vivo) | Q32 |
| 12 | Nota conjugada (serviço no XML da 55) MORTA; ramos autorizam separado | Q29/Q8 |
| 13 | Financeiro SEPARADO do faturamento; após confirmação, manutenção só no módulo | financeiro §3.1/§3.2 |
| 14 | Boleto NÃO baixa no nascimento (baixa por extrato/retorno/API) | QF1 |
| 15 | Cancelamento com baixas → ESTORNO EM CADEIA antes do soft-delete | QF2 |
| 16 | Meio de pagamento por classificação TIPADA (fim do match por descrição) | QF3 |
| 17 | Cheque = PORTADOR DE DÍVIDA: baixa do título COM o cheque; 2 elos de quitação (origem/destino → FIN_CODQTC); devolução gera título NOVO via nota avulsa | financeiro §5.1 |
| 18 | TEF fora da retaguarda (só PDV) | financeiro §5.3 |
| 19 | Caixa por DIA e USUÁRIO (nunca 2 no dia); dinheiro/cheque/cancelamento exigem caixa aberto | financeiro §5.4 |
| 20 | Nota autorizada cancelada: ordem NÃO volta (documento oficial); oferece cópia de ordem | financeiro §3.6 |
| 21 | Validação local mínima; Receita é o validador final (códigos dela sustentam o suporte) | Q17 |
| 22 | Ordem de cálculo é GRAFO (IBS/CBS por último); rateio com resíduo; persistir antes de observar; configs no Framework | T1/T2/T6/T7 |
| 23 | Peças da regra RATIFICADAS em bloco (a–h da §6.5): `tb_tax_rule` (seletor, incl. ST e `tb_taxes_id`) + `tb_tax_rule_icms` (próprio, com diferimento/destaque) + `tb_tax_rule_icms_st` + `tb_tax_rule_ipi` + `tb_tax_rule_pis_cofins` (kind P\|C) + `tb_tax_rule_ii`; CSTs por FK aos catálogos | R1-Q1 |
| 24 | Financeiro do ERP usa as MESMAS PEÇAS de settlement/estorno/movimento do Software House; o TÍTULO é tabela própria ligada ao order (reusar peça ≠ reusar tabela) | R1-Q2 |
| 25 | Negociação em DUAS vias com materialização ÚNICA: cliente simples usa o PRAZO (template `003 - 028/056/084`, datas predefinidas); cliente que negocia usa o PARCELAMENTO elaborado. **Regra: o financeiro consome SEMPRE o parcelamento; se não existir, o prazo GERA o parcelamento no faturamento** (um único caminho de consumo) | R1-Q3 |
| 26 | Meio de pagamento TIPADO via `kind` na `tb_payment_types`, **mantendo a descrição** (kind classifica, descrição continua livre); **PIX = kind próprio** (baixa em conta corrente × caixa) | R1-Q4 |
| 27 | Escopo da fase no financeiro: TÍTULO + baixas + estorno em cadeia + CAIXA; **cheque e cartão-contrato = onda 2** | R1-Q5 |
| 28 | Entrega: API + telas de CADASTRO nesta fase; telas de PROCESSO (faturar/baixar) na onda seguinte | R1-Q6 |
| 29 | O faturamento do ERP é o TERCEIRO PRODUTOR das MESMAS `tb_financial` + `tb_financial_bills` (junto do espelho 5.5 do sync e do Software House) — NENHUMA tabela de título nova; settlements/estorno/espelho funcionam sem alteração. Esclarecimento da 24: "reusar peça ≠ reusar tabela" significa que título, baixa e movimento são TRÊS conceitos/peças — não que o título ganhe tabela paralela | R2-Q1 |
| 30 | `tb_tax_ruler` do baseline (espelho largo da TB_TRIBUTACAO, sem endpoint de sync que a alimente) é APOSENTADA — drop na migration com checagem de dados por schema antes; a regra de tributação nasce na web já decomposta (família `tb_tax_rule*`), sem migração de linhas | R2-Q2 |
| 31 | Template de prazo segue **STRING LIVRE** na `deadline` do `tb_order_billing` (formato `028/056/084`) — SEM catálogo `tb_payment_term` nesta fase (recomendação de catálogo DECLINADA pelo autor; se a repetição justificar no futuro, o catálogo agrega sem reforma — a coluna já seria o snapshot) | R2-Q3 |
| 32 | `kind` na `tb_payment_types` com domínio COMPLETO desde já (espécie/PIX/cheque/boleto/carteira/cartão/outros — classificar ≠ implementar); backfill das linhas centrais por **MAPA DETERMINÍSTICO `id_nfce` → kind** (01→espécie, 02→cheque, 03/04→cartão, 05→carteira, 15→boleto, 17→PIX; sem id_nfce → outros p/ revisão) — id_nfce é o FPT_TIPO_NFCE no formato novo, já predefinido; NENHUMA heurística de texto. Cadastro de forma pelo CLIENTE mantém o padrão do catálogo: dedupe por DESCRIÇÃO na central (nunca duplica) + preenchimento privado de `tb_institution_has_payment_types`; forma nova define o kind no cadastro (sugerido pelo id_nfce) | R2-Q4 |
| 33 | FKs físicas SÓ em colunas INT (collation dos catálogos centrais sem normalização); integridade de CST/modBC/CFOP pela peça `@shared/tax-rule` | achado 1 do DDL |
| 34 | `tb_cashier.tb_user_id` — padrão da casa mantido JÁ (não adiado): rename coordenado executado nos dois endpoints /cashier web + docs vivos + FieldName do model destiny Delphi (contrato HTTP intacto — o nome da coluna não viaja no payload) | achado 3 do DDL |
| 35 | Sentido SEM coringa em toda a cadeia (2026-08-19): "não deve existir CFOP sem way" — `tb_cfop.way` normalizado pelo 1º dígito (1-3=E, 5-7=S; corrigiu 6411) e OBRIGATÓRIO no cadastro; `tb_tax_rule.direction` OBRIGATÓRIA E/S ("Ambos" morreu — o legado era assim por construção: toda regra tinha natureza, natureza sempre tem sentido); o motor SEMPRE filtra `r.direction = :sentido` (paridade NAT_SENTIDO, sem branch NULL); sentido da OPERAÇÃO = way da natureza no faturamento (W2); CFOP na regra com way divergente do direction = 422 (regra morta por construção). Migration 029 + cfop.dto way obrigatório | Q-G1 + RA-Q3 |
| 36 | NCM no match por IGUALDADE EXATA, fiel ao legado — "é exigência do governo" (Valdo, 2026-08-19); cadastro segue aceitando 2–8 dígitos e prefixo continua regra SÓ do FCP (P7.1). Sem mudança de código | Q-G2 |
| 37 | Catálogos fiscais COMPLETOS com os códigos oficiais que o legado não tinha (seed sql/30, aplicado em dev 2026-08-19): CST ICMS monofasia 02/15/53/61 (NT 2023.001) + PIS/COFINS crédito/entrada 05/49/50–56/60–67/70–75/98 (tabelas 4.3.3/4.3.4 SPED) — ICMS NR com a Tabela B completa (15), PIS/COFINS completos (33 cada); CSOSN já estava completo no seed 28. CST × CSOSN seguem catálogos SEPARADOS (espelho TB_TRIB_ICMS_NR × TB_TRIB_ICMS_SN): a peça ICMS carrega os DOIS FKs e o DESPACHO é pelo CRT do emitente (§P2.3: 3/2 → CST, 1 → CSOSN; CRT = 1º caractere do tb_entity_tax.tax_regime, decisão 15 da Fase 3). Nota p/ W2: emitente Simples com regra SEM csosn (ou Normal sem cstNr) = regra incompleta para o regime → mesmo alerta descritivo da regra ausente | Q-G4 |
| 38 | Produto/Cliente do seletor = ESPECIALIZAÇÃO que nasce do cadastro de ORIGEM (2026-08-19): os dois campos podem ficar nulos (coringa) e NUNCA são digitados na tela da regra — serão preenchidos quando a regra for criada A PARTIR do cadastro do produto ou do cliente (ações futuras nesses cadastros: produto quando o módulo nascer; cliente é candidata). Na tela da regra ficam SOMENTE LEITURA (hint "preenchido pelo cadastro de origem"); pendências locais removidas; a API valida a EXISTÊNCIA quando presentes (peça findInvalidSelectorRefs — produto escopado pela institution/PK composta, cliente na tb_entity central; 422 fields[] — mata regra morta e o 500 de FK). Papel no motor confirmado: são critérios de DESEMPATE (pickRule: cliente > estado+produto > estado > produto — já implementado, paridade Fc_DefineTributacao com B9 corrigido) | RA-Q1 |

## Parecer conceitual (setes-conceito, 2026-08-16) — síntese

Todas as peças auditadas passaram no teste do fato gerador. Constraints de desenho
que o parecer FIXOU (não são decisões novas — derivam das já registradas):

- As 6 sutilezas do motor viram **UMA peça transaction-aware** (`shared/tax-rule`)
  — nunca espalhadas por endpoint (a paridade do critério 1 depende disso)
- **Presença = "a regra DEFINE o tributo"**: CST de isenção (ICMS 40/41, PIS 07/08)
  é PRESENÇA com alíquota nula — o XML exige o grupo com CST mesmo sem imposto.
  Ausência ≠ isenção. Registrar no DDL e no motor
- O título financeiro **JÁ EXISTE** no baseline (`tb_financial` +
  `tb_financial_bills`, kinds R*/P*, PK inst+order+terminal+parcel) — settlements,
  estorno em cadeia e espelho 5.5 funcionam sem alteração se o ERP usar as mesmas
- Via simples da negociação já vive em `tb_order_billing` (payment_type + plots +
  deadline); a peça NOVA é só `tb_order_installment` (parcelamento elaborado;
  presença = elaborado, ausência = prazo gera)
- Caixa REUSA `tb_cashier` (existente, alimentada pelo sync); o que nasce é o GATE
  (`shared/cashier.requireOpenCashSession`) + trava "1/dia/usuário" no padrão
  `open_lock`; **saldo do caixa DERIVADO** de `tb_financial_statement` conta 0
  (nunca duas fontes; `tb_cashier_items` fica p/ conferência futura)
- Cheque (onda 2): elos pela QUITAÇÃO (`origin/destination_settled_code` — espelho
  do CHQ_QT_REC/PAG); devolução = composição pura (nota avulsa→título novo);
  levar à onda 2 o confronto flags mutáveis × baixas como EVENTOS
- Nomes validados; comentário de DDL deve distinguir catálogo CST (`tb_tax_*`) ×
  regra (`tb_tax_rule_*`)

## ⚠️ Questões pendentes (Rodada 2 — do parecer conceitual)

- ~~R2-Q1~~ — RESPONDIDA (Opção A → decisão 29)
- ~~R2-Q2~~ — RESPONDIDA (aposentar → decisão 30)
- ~~R2-Q3~~ — RESPONDIDA (string livre → decisão 31; catálogo declinado)
- ~~R2-Q4~~ — RESPONDIDA (domínio completo + mapa id_nfce→kind → decisão 32)

**Rodada 2: ZERADA (2026-08-16). 34 decisões registradas (32 + achados do DDL).**

## Onda 1 — ENTREGUE nos dois lados (2026-08-16)

**API**: peça `@shared/tax-rule` (motor com as 6 sutilezas + desempate
B9-corrigido + validação de CST nos catálogos) + módulo `tax-rules` (6 arquivos,
lista paginada com flags has*, /catalogs, cascata transacional, Swagger) + seed
sql/27 (interface 27 Registers, campos, page_size) + flag default/retroativa.
212/212 testes api + 32/32 sync; smoke ok (health/401/Swagger).

**APP** (setes-form-builder, 18 arquivos em `modules/tax_rules` + rotas + i18n
pt/en ~95 chaves): form artesanal molde carriers com 6 abas (Seletor + uma por
tributo com TOGGLE = presença; ICMS-ST desabilitado sem ICMS ligado), pendency
ancorada no PATH do payload (`icms.cstNr`, `pisCofins.P.cst`...) casando o
fields[] dos 400/422 da API com troca de aba no foco, draft preserva
observationId/taxesId (PUT não os zera), números como texto até o toJson.
`flutter analyze`: No issues found.

## ⚠️ Questões pendentes (rodada do APP — decisões do Valdo)

- ~~RA-Q1~~ — ✅ FECHADA em 2026-08-19 (decisão 38): lookup NENHUM — os campos
  são especialização que nasce do CADASTRO DE ORIGEM (produto/cliente) e
  viraram somente-leitura na tela da regra; API valida existência (422).
  A ação "criar regra deste produto/cliente" nasce nos cadastros de origem
  (produto = onda do módulo products; cliente = candidata).
- ~~RA-Q2~~ — ✅ FECHADA em 2026-08-20 (decisão 39): chips visuais SIM, mas
  como REGRA GERAL do app (não só nesta tela) — ERP mantém tom sério, chips
  entram como recurso de legibilidade especificamente em telas com MUITA
  informação condensada (ex.: presença de peças na lista de regras de
  tributação). Fábrica (rowBuilder) ganha suporte a chips widget além de
  texto puro; usar com critério, não em toda lista.
- ~~RA-Q3~~ — ✅ FECHADA em 2026-08-19 junto com a Q-G1 (decisão 35): "Ambos"
  NÃO existe — direction obrigatória E/S, dropdown só Entrada/Saída (default
  'S' na criação).
- ~~RA-Q4~~ — ✅ FECHADA em 2026-08-20 (decisão 40): mantida a ordem do legado
  Seletor → ICMS → ICMS-ST → IPI → PIS/COFINS → Importação, sem reordenar.

**Rodada FECHADA (RA-Q1..Q4 + Q-G1/Q-G2/Q-G4)**: LIBERADO seguir para as ondas
seguintes (W2 cálculo por item → faturamento → W3 financeiro). RA-Q2 ainda
pede implementação (chips na lista de regras); as demais são só confirmação/
registro, sem código pendente.

## Gates da Onda 1 — EXECUTADOS (2026-08-16; correções sem decisão aplicadas)

**Resultado: a entrega como estava REPROVARIA (socrático ~0.66) — corrigida na
própria sessão de gate → APROVADA: socrático 0.82 ✅, adversarial sem
HIGH/CRITICAL remanescente.** 216/216 testes api (4 novos fixam os achados);
`flutter analyze`/testes do app limpos. E2E REAL provado contra o banco dev:
POST 201 → GET com peças → PUT ressincroniza presença → flags has* na lista →
DELETE → 404; clamp de paginação ok; sem flag = 403.

Achados corrigidos (nenhum exigia decisão):

1. **HIGH provado (API)**: `GET /api/tax-rules` devolvia **500 no banco real** —
   a lista selecionava `st.description`, mas `tb_state` usa `name`. Os 212
   testes (mockados) não viam. Corrigido no repository + assert no teste.
2. **HIGH provado (operacional)**: os **8 catálogos fiscais centrais estavam
   VAZIOS** (nenhum seed os alimentava) — nenhuma regra podia ser criada (todo
   CST caía no 422 da decisão 33) e `/catalogs` vinha vazio. Criado e aplicado
   `sql/28_catalogos_fiscais_seed.sql` com as listas VERIFICADAS no legado
   (`Funcao/un_Conversao.pas` — CST ICMS/IPI/PIS/COFINS, modBC NR/ST), CSOSN
   oficial (grupos 101/102/500/900 confirmados no tributacao.pas) e desoneração
   do layout NF-e (legado fixa 0 — não constrange).
3. **MEDIUM (motor)**: a via RegraDireta (sutileza 6) buscava a regra **sem
   `tb_institution_id`** — regra de outro estabelecimento do mesmo schema
   tributaria a nota. Corrigido em `match.ts` + teste.
4. **MEDIUM (decisão 33)**: a peça prometia validar CST/modBC/**CFOP**, mas só
   cobria CST/modBC. `findInvalidCatalogCodes` agora valida `selector.cfopId`
   contra `tb_cfop` (422 com fields[] provado por smoke).
5. **MEDIUM (app, M1)**: desligar o ICMS deixava a ST **ligada e travada**
   (toggle desabilitado + pendência apontando para controle inacessível).
   Desligar o ICMS agora derruba a ST junto (P3.3).
6. **MEDIUM (app, M2)**: o `fields[]` de PIS/COFINS chega do Zod como
   `pisCofins.0.cst` e o form declarava `pisCofins.P.cst` — **nunca ancorava**
   (caía no dialog cru, sem trocar de aba). Tradução índice→kind pela ordem do
   toJson do draft.

Pontos abertos registrados (sem retrabalho obrigatório): validação de catálogo
fora da transação (catálogo é do Super, baixa rotatividade); teto 100 nas
alíquotas do DTO; `tb_observation` ainda não existe (observationId aguarda W2).
**Baixados em 2026-08-19 (manutenção sem decisão)**: `/catalogs` ganhou cache
TTL no molde do field-config (env `TAX_CATALOG_CACHE_TTL_MS`, 8 queries em
paralelo, teste fixa o comportamento — 217/217); LOWs do app corrigidos —
L1 `deferredAliq` oculto não viaja nem gera pendência (par do M1), L3 memória
das fatias subiu para o `_TaxRuleFormViewState` (religar toggle restaura o
digitado mesmo após trocar de aba; zera na troca de registro), L5 fromJson
com kind duplicado fica com a PRIMEIRA ocorrência (determinístico). Também
em 2026-08-19: seed `sql/29_users_flag_retroativo_seed.sql` criado e aplicado
em dev — flag 'users' retroativa (chip do módulo de menus baixado; novas
institutions já ganhavam pelo insertDefaultFlags/A2).

### Questões para rodada (dos gates — decisões do Valdo)

- ~~Q-G1~~ — ✅ FECHADA em 2026-08-19 (decisão 35, resposta do Valdo: "não
  deve existir CFOP sem way; o parâmetro deve existir e sempre ter um valor
  E/S" + confirmação de que vale para a REGRA): variação da (a) SEM coringa —
  direction obrigatória na regra, way obrigatório no CFOP, motor sempre
  filtra. Executada nos dois lados; ver decisão 35.
- ~~Q-G2~~ — ✅ FECHADA em 2026-08-19 (decisão 36): fiel ao legado, igualdade
  exata — "é exigência do governo". Sem mudança de código.
- ~~Q-G4~~ — ✅ FECHADA em 2026-08-19 (decisão 37): SIM, códigos oficiais
  incluídos já (seed sql/30 aplicado em dev). A dúvida CST × CSOSN do Valdo
  foi verificada e está mapeada — ver decisão 37 (catálogos separados, peça
  com os dois FKs, despacho pelo CRT do emitente §P2.3).

## Scripts/Entregáveis do DDL (aplicados em dev 2026-08-16; 199/199 testes verdes)

| Script | O que faz | Decisões |
|---|---|---|
| `setes-api/migrations/025_tax_rule_family.sql` | `tb_tax_rule` (seletor) + 5 peças + DROP `tb_tax_ruler` (checagem D30 executada: 0 linhas em setes_setes; inexistente em setes_ws) | 1/23/30 |
| `setes-api/migrations/026_order_installment.sql` | `tb_order_installment` (parcelamento elaborado; PK espelha tb_financial) | 25/29/31 |
| `setes-api/migrations/027_payment_types_kind_central.sql` | `kind` na central + backfill por mapa id_nfce→kind (idempotente por information_schema — a migration roda por schema) | 16/26/32 |
| `sql/03_schema_cliente_ddl.sql` | blocos canônicos das 7 tabelas novas | — |
| `sql/01_setes_central_ddl.sql` | `kind` no canônico da tb_payment_types + domínio documentado | — |
| `setes-api/migrations/029_tax_rule_direction.sql` | way do tb_cfop normalizado pelo 1º dígito (central, idempotente; corrigiu 6411) + backfill e NOT NULL do `direction` (COLLATE explícito no JOIN cross-schema) — aplicada em dev 2026-08-19 | 35 |

### Relatório revisar-ddl (executado)

1. **FK string cross-schema × collation** — catálogos centrais criados SEM COLLATE
   explícito; FK física de string quebraria (caso real PADROES §5). Resolução:
   FKs físicas SÓ em colunas INT (entity/state/discharge/order/payment_types);
   CSTs/modBC/cfop validados pela peça `@shared/tax-rule`. FK física pode voltar
   após auditoria de collation dos catálogos.
2. **`cst` da pis_cofins sem FK física** — catálogos distintos por kind
   (tb_tax_pis × tb_tax_cofins); validação por kind na aplicação.
3. **`tb_taxes_id` sem FK** — `tb_taxes` (reforma) ainda não existe na web;
   criar FK quando nascer.
4. **Baseline sem colisão** — nenhuma das 7 tabelas existe no 001_baseline
   (checklist do caso tb_collaborator: ok).
5. **Resíduos varridos** — nenhum `.ts` referencia `tb_tax_ruler`.
6. **⚠️ Dados de DEV expostos pelo backfill**: linhas com `id_nfce` errado/nulo
   herdaram kind fiel ao erro ("3 - CARTAO DE DEBITO" com id_nfce '01' → 'E';
   "1 - DINHEIRO" sem id_nfce → 'O'). O MAPA é fiel; o dado de dev está sujo —
   é exatamente o caso da revisão pela tela do Super previsto na D32. Em
   produção o id_nfce vem do FPT_TIPO_NFCE (confiável).
7. ~~`tb_cashier.tb_userid` adiado~~ → **EXECUTADO na mesma rodada (decisão 34)**:
   Valdo decidiu manter o padrão `tb_user_id` JÁ. Verificado que o contrato HTTP
   não carrega o nome da coluna (payload Delphi montado à mão em
   cashier_send_web.pas) → ajuste contido no lado web: migration 028 (CHANGE
   COLUMN guardado por information_schema), endpoints /cashier dos DOIS lados
   (setes-sync e sync legado do setes-api), docs vivos (CONTRATOS_SYNC,
   MAPA_INDEXACAO, prompt_indexacao_usuario) e `FieldName` do model destiny
   Delphi (cosmético — sem recompilação urgente). Aplicado em dev; 199/199
   (api) + 32/32 (sync) verdes; varredura de resíduos zerada.
8. **Decisão 33 (ratificação do achado 1)**: FKs físicas SÓ em colunas INT —
   confirmado pelo Valdo ("use colunas int para ficarem sem risco"); strings
   validadas pela peça @shared/tax-rule.
9. **Dados de dev do backfill (achado 2)**: o PRÓPRIO Valdo corrige as linhas
   pela tela, garantindo o cadastro — sem ação de código.

## Fora de escopo desta fase

Autorização/transmissão (guardada — pipeline+strategy definidos), **cheque e
cartão-contrato (onda 2 do financeiro — decisão 27)**, **telas de processo (onda
seguinte — decisão 28)**, Receber Descontada, fechamento financeiro × caixa, TEF,
boleto por API Inter (requisito registrado), reforma IBS/CBS crédito
presumido/monofásico/seletivo (estruturas modeladas, implementação quando o
regulamento fechar), correções do LEGADO (plano próprio:
tributacao-plano-legado.md B1–B9/L1–L7/O1–O3).

## Critérios de sucesso

1. Regra criada na web casa os MESMOS itens que o legado casaria (paridade do motor,
   incluindo coringas/precedência/estado)
2. Nota de venda mercadoria+serviço calculada na web bate com o legado campo a campo
   nos CSTs cobertos — EXCETO onde há decisão de correção (5/6/7/8: divergência
   esperada e documentada)
3. Regra ausente → 422 com o conteúdo do alerta do legado (produto + critérios)
4. Financeiro nasce na MESMA transação do faturamento; baixa à vista automática
   por meio (caixa × conta) conforme W3
5. Cancelamento com baixas dispara estorno em cadeia; sem caixa aberto, operação
   em dinheiro é bloqueada
6. Espelho 5.5 do sync continua íntegro (testes de contrato verdes)
7. Gates do workspace: revisar-riscos-sistemicos ≥ 0.70 + testar-adversarial sem
   HIGH/CRITICAL
