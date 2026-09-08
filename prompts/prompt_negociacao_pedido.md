# Prompt — Negociação do pedido (prazo × parcelamento elaborado)

**Escopo**: setes
**Status**: ENTREGUE (2026-09-06) — API + app, gates 0.72/0.80 ✅; D1–D7 executadas;
RODADA 2 DECIDIDA e EXECUTADA (2026-09-07, "siga as recomendações" — §9); passeio
logado no browser FEITO (2026-09-07, §10); tela consumindo `expected`/`deadlineValid`
ENTREGUE (2026-09-07, §11); aviso de vencimento no passado D-N6 na tela ENTREGUE
(2026-09-07, §12); passeio logado nº 2 desses caminhos FEITO (2026-09-08, §13). Ver §7.
**Origem**: Q-C1 da onda do cheque (`prompt_cheque_rastreabilidade.md` §8) + direção
do Valdo em 2026-09-06: "a tela de negociação deve ser feita utilizando a
`tb_order_installment`; essa tela fica na regra entre o string prazo e a negociação"
**Fase**: Faturamento Fiscal e Financeiro — decisões 25, 28, 29, 31 vigentes
(`prompt_fase_faturamento_financeiro.md`)
**Parecer conceitual**: setes-conceito 2026-09-06 — APROVADO com refinamentos (§6)

## 1. O que o Valdo pediu

Uma tela de NEGOCIAÇÃO do pedido de venda, construída sobre `tb_order_installment`,
posicionada exatamente na regra já decidida: o cliente simples usa o PRAZO (string
`028/056/084` em `tb_order_billing.deadline`) e o cliente que negocia usa o
PARCELAMENTO elaborado (linhas em `tb_order_installment`). Motivação imediata: sem
essa tela não há onde coletar os cheques no faturamento (a onda do cheque entregou o
backend — bloco `checks` do `POST /api/billing/invoice` — mas o app não sabe quais
parcelas são cheque porque não conhece a negociação).

## 2. Fatos verificados no código (2026-09-06)

- **Regra vigente (decisão 25)**: o financeiro consome SEMPRE o parcelamento; se não
  existir, o prazo GERA as parcelas no faturamento. Implementada em
  `billing.service.ts:589-631`: `getInstallments()` → se houver linhas, usa-as e exige
  soma = `financialBase` (422 `INSTALLMENT_MISMATCH`, R5-Q2, evidência
  `ControllerPedido.ValidaParcelamento`); senão `parseDeadline(billing.deadline)` +
  `parcelQuotas` (422 `INVALID_DEADLINE` se o prazo não parseia).
- **Via simples** = `tb_order_billing` (id = pedido; `tb_payment_types_id` NOT NULL,
  `plots` varchar(3), `deadline` varchar(255) — string livre, decisão 31). **Via
  elaborada** = `tb_order_installment` (PK inst+order+terminal+parcel; `due_date`,
  `amount`, `tb_payment_types_id` NULL = herda a forma do billing; migration 026).
- **Ninguém grava a via simples para VENDA**: só `service-orders` insere
  `tb_order_billing` (passo 5 da OS, forma + plots do contrato, sem deadline). O módulo
  `orders` não expõe forma/prazo; o app não tem entidade nem tela para isso; TODOS os
  smokes de faturamento inseriram `tb_order_billing` por SQL. Consequência: um pedido
  criado pelo app hoje NÃO fatura (422 `ORDER_NO_BILLING`, `billing.service.ts:599`).
- **Ninguém grava a via elaborada** em lugar nenhum (só leitura no billing).
- **`financialBase` só nasce dentro de `invoiceOrder`** (`billing.service.ts:591`):
  itens com `set_financial ≠ 'N'` + ST + IPI + frete/despesas. `validateOrder` não a
  calcula nem devolve. Não existe endpoint de preview (na onda do cheque, extrair esse
  cálculo foi avaliado como duplicar o motor fiscal — o 422 devolve o valor esperado).
- **Moldes no app**: lookup de forma de pagamento já existe na OS
  (`service_order_page.dart:896-1009`, datasource `paymentTypes()`); OS negocia só
  forma + nº de parcelas + vencimento (sem grade). Tela do pedido (`order_page.dart`)
  tem abas Abertos/Faturados e o botão "Validar e Faturar" que manda só `{orderId}`
  (`order_datasource.dart:167`).
- **Cheque**: o backend exige, para parcela de forma kind='Q', `checks[{parcel,
  items[]}]` com soma = parcela (422 `CHECK_REQUIRED` / `CHECK_SUM_MISMATCH`); R só
  nasce na transação do faturamento (D8 do cheque). Legado: `Pc_LancaDetalheCheque`
  abria o form do cheque POR PARCELA na esteira do faturamento.
- Decisão 28: telas de PROCESSO (faturar/baixar) ficaram para a onda seguinte à dos
  cadastros — esta é uma delas.

## 3. Rodada 1 — questões para o Valdo (recomendação entre parênteses)

- **Q1 Onde a tela vive**: (a) seção "Negociação" DENTRO da tela do pedido (módulo
  `orders`, aba Abertos), editável só com status A; (b) tela de processo própria
  (`/home/order-negotiations`), lista de pedidos abertos → negociar. (rec.: a — a
  negociação é atributo do pedido e o módulo já fala com `/api/orders`; b só se a
  tela do pedido estiver saturada)
- **Q2 Peça e endpoints**: hoje billing e service-orders leem/escrevem
  `tb_order_billing` cada um com o seu SQL. (a) peça `@shared/order-negotiation`
  (transaction-aware: `getNegotiation`, `saveNegotiation` — billing + installments na
  MESMA transação, `parseDeadline` movido para ela) consumida por `orders` (GET/PUT
  `/api/orders/:id/negotiation`), `billing` (leitura, substitui `getOrderBillingInfo`/
  `getInstallments`) e `service-orders` (passo 5); (b) SQL só no módulo `orders`, os
  outros seguem como estão. (rec.: a — 3 consumidores da mesma regra e "módulo nunca
  importa módulo"; guardião conceitual antes)
- **Q3 A regra na tela (prazo × elaborado)**: (a) UMA tela, duas vias: cabeçalho =
  forma + prazo (string, template `028/056/084`); grade de parcelas nasce GERADA do
  prazo (somente leitura) e vira ELABORADA quando o usuário edita qualquer parcela
  (grava `tb_order_installment`); "Voltar ao prazo" apaga o elaborado — PRESENÇA
  decide, como hoje; (b) prazo e parcelamento em telas/abas separadas. (rec.: a — é
  literalmente "a regra entre o string prazo e a negociação"; a grade mostra ao
  usuário o que o faturamento vai gerar)
- **Q4 Base de valor da grade** (ponto mais sensível): o 422 compara com
  `financialBase` (com ST/IPI/frete), que só existe no faturamento. (a) endpoint de
  preview `GET /api/orders/:id/financial-base` extraindo do `invoiceOrder` o cálculo
  em peça própria ("orçamento fiscal do pedido") consumida pela tela e pelo invoice —
  mesma fonte, custo alto; (b) a grade negocia sobre o TOTAL dos itens e o faturamento
  joga a diferença de impostos na ÚLTIMA parcela — regra NOVA que relaxa R5-Q2;
  (c) a grade negocia sobre o total dos itens e o 422 devolve a base certa — loop
  corretivo (é o comportamento atual). Antes de decidir: no legado, `ValidaParcelamento`
  compara `valorPedido` × `valorParcelado` — esse valorPedido inclui ST/IPI? (eu
  verifico no `ControllerPedido.pas` se você quiser a resposta antes de decidir).
  (rec.: se o legado compara com o total COM impostos, a — a peça de orçamento fiscal
  paga a extração porque a tela de cheques e a de boleto também vão querer a base;
  senão, c)
- **Q5 Onde os cheques são digitados**: (a) dialog no "Validar e Faturar" quando
  alguma parcela (gerada ou elaborada) é kind='Q' — N cheques por parcela, soma =
  parcela, enviados no bloco `checks` (backend pronto; D8; legado idêntico); (b) na
  tela de negociação, persistidos antes do faturamento (tabela nova
  `tb_order_installment_check` → guardião conceitual). (rec.: a — nada novo no banco;
  o cheque só existe quando o faturamento acontece)
- **Q6 Forma POR PARCELA** na grade elaborada (`tb_order_installment.tb_payment_types_id`,
  NULL = herda): (a) editável por parcela, default = forma do cabeçalho — é o que
  permite "parcela 1 cheque, parcela 2 boleto"; (b) só a forma do cabeçalho. (rec.: a —
  a coluna existe para isso e o cheque por parcela depende dela)
- **Q7 Travas**: pedido faturado (F) → negociação somente leitura; item editado depois
  de elaborar → o 422 `INSTALLMENT_MISMATCH` já cobre (R5-Q2), a tela só mostra o
  aviso; OS continua gravando forma + plots pelo contrato, agora pela peça de Q2, sem
  mudar comportamento. Confirmar. (rec.: sim aos três)
- **Q8 Prazo**: continua string livre (decisão 31), mas validado ao GRAVAR pelo mesmo
  `parseDeadline` do billing (`INVALID_DEADLINE` aparece na negociação, não no
  faturamento). Confirmar. (rec.: sim)

**Fora desta onda**: catálogo de templates de prazo (decisão 31 declinou); boleto por
parcela na negociação (já é automático pelo contrato/config); PDV.

## 4. Decisões — Rodada 1 (Valdo, 2026-09-06)

- **D1 (Q1) A NEGOCIAÇÃO vive em `tb_order_installment`** — "negociação" é a via
  elaborada; a via simples é o registro de cobrança do pedido. Posição da tela NÃO
  foi decidida: segue a recomendação (seção "Negociação" na tela do pedido, aba
  Abertos, editável só em status A) como recomendação, não como decisão.
- **D2 (Q2) DUAS peças, uma por tabela**:
  - `@shared/order-billing` → `tb_order_billing`: negociação SIMPLES = registro
    OBRIGATÓRIO da cobrança, para VENDAS e COMPRAS; relação 1:1 com `tb_order`.
  - `@shared/order-negotiation` → `tb_order_installment`: parcelamento negociado
    ANTES do faturamento; OPCIONAL — só existe quando o cliente quer uma negociação
    mais elaborada; relação N:1 com `tb_order`.
  - Consumidores: `orders` (escrita das duas via GET/PUT `/api/orders/:id/negotiation`),
    `billing` (leitura das duas — substitui `getOrderBillingInfo`/`getInstallments`),
    `service-orders` (escrita do billing no passo 5, comportamento inalterado).
- **D3 (Q3) UMA tela, duas vias**: cabeçalho = `tb_order_billing` (1:1); grade =
  `tb_order_installment` (N:1). A grade nasce GERADA do prazo (somente leitura) e vira
  ELABORADA ao editar; "voltar ao prazo" apaga o elaborado; PRESENÇA decide (decisão
  25 intacta).
- **D4 (Q4) Base de valor conforme o LEGADO** (aceita a recomendação condicional):
  verificar `ValidaParcelamento` (`ControllerPedido.pas`) — se compara com o total COM
  impostos → (a) peça "orçamento fiscal do pedido" extraída do `invoiceOrder` +
  endpoint de preview, mesma fonte para tela e faturamento; se compara só os itens →
  (c) grade sobre o total dos itens, 422 `INSTALLMENT_MISMATCH` como loop corretivo.
  Resultado da verificação: ver §5.
- **D5 (Q5) Cheques no "Validar e Faturar"**: dialog quando alguma parcela (gerada ou
  elaborada) é kind='Q' — N cheques por parcela, soma = parcela — enviados no bloco
  `checks` do invoice. Nada novo no banco.
- **D6 (Q6) Forma POR PARCELA** editável na grade elaborada; default = forma do
  cabeçalho (`tb_payment_types_id` NULL = herda).
- Q7/Q8 sem resposta → recomendações mantidas COMO recomendação: pedido F = negociação
  somente leitura; item editado após elaborar = o 422 já cobre; OS inalterada; prazo
  string validado ao GRAVAR com o mesmo `parseDeadline` do billing.

## 5. Verificação do legado para D4 (2026-09-06) — resultado e questão nova

Lido linha a linha em `D:\Gestao2016`:

- **No PEDIDO** (`ControllerPedido.pas:1486 ValidaParcelamento`): compara Σ do
  parcelamento com `valorFinanceiro − crédito`, onde `TControllerPedido.valorFinanceiro`
  (:1540) = Σ itens (`unit × qtd − desconto`, só `set_financial` S/NULL, filtrados pela
  operação do tipo do pedido) **+ frete do pedido**, arredondado. **SEM impostos.**
- **Na NOTA** (`ControllerNotaFiscal.pas:721 valorFinanceiro`): = base do pedido
  **+ ICMS-ST + seguro + outras despesas + IPI** (+ frete da nota se o pedido não tinha).
  É exatamente o `financialBase` da web (`billing.service.ts:591`).
- **No faturamento** (`Un_Fatura_Fin.pas:411 Pc_MontaParcelamento`): se há parcelamento
  gravado, usa CADA parcela como negociada (forma, valor, vencimento); só o frete da
  nota entra na 1ª parcela quando o pedido não tinha frete (FIN-02). O total a parcelar
  é FIN-01 = max(parcelamento, Nota.valorFinanceiro) e a diferença de IPI/ST/despesas
  era acertada **à mão** no form interativo (`Fc_ValorInformado`/`Pc_Recalcular`,
  `It_Confirma=False`) antes de gerar os títulos; FIN-05: o parcelamento do pedido é
  REESCRITO pelo faturamento.

**Consequências**:
- **D4 = (c)**, pela regra que o Valdo aceitou: a grade negocia sobre a base do PEDIDO
  (itens `set_financial` + frete), calculável sem o motor fiscal — nasce a função
  "base financeira do pedido" (peça/função a definir no parecer conceitual), usada pela
  tela e pela validação ao gravar (espelho de `ValidaParcelamento`, erro na negociação
  e não no faturamento).
- **Achado na web**: o `INSTALLMENT_MISMATCH` (R5-Q2) hoje compara a negociação (base
  do pedido) contra o `financialBase` (base da NOTA, com impostos) — mais estrito que a
  evidência que o justificou (`ValidaParcelamento` compara SEM impostos). Com ST/IPI ≠ 0
  toda negociação elaborada falharia sem que o usuário tenha como acertar.
- **Q9 (nova — aguarda o Valdo)**: no faturamento de um pedido com parcelamento
  ELABORADO, onde entra a diferença de impostos (ST + IPI + seguro + despesas — a
  distância entre a base do pedido e a da nota), já que a API não tem o form
  interativo do legado? (a) na 1ª parcela — o reflexo do próprio legado para "extras"
  (FIN-02 frete → 1ª, FIN-04 ST → 1ª); (b) na ÚLTIMA parcela (FIN-03, resíduo → última);
  (c) rateio proporcional entre as parcelas; (d) manter o 422 exigindo negociação
  exata contra a base da nota (só viável com preview fiscal — D4(a), que foi
  descartada). A regra vale igual para a via GERADA (hoje `parcelQuotas` já rateia a
  base da nota — nada muda ali). (rec.: a — fiel ao reflexo do legado e o cliente vê a
  diferença na parcela mais próxima; a comparação do 422 passa a ser contra a base do
  PEDIDO, como o legado)

- **D7 (Q9 = a, Valdo 2026-09-06) — diferença de impostos na 1ª PARCELA**: no
  faturamento de pedido com parcelamento ELABORADO, o que separa a base do pedido
  (itens + frete) da base da nota (ST + IPI + seguro + despesas) entra INTEIRO na 1ª
  parcela — reflexo do legado para "extras" (FIN-02 frete → 1ª, FIN-04 ST → 1ª). A
  comparação do `INSTALLMENT_MISMATCH` passa a ser contra a base do PEDIDO (como
  `ValidaParcelamento`); a via GERADA continua rateando a base da nota (`parcelQuotas`,
  resíduo na última — inalterada).

## 6. Parecer conceitual (setes-conceito, 2026-09-06) — aplicado

- **Emenda do Valdo à D2 (2026-09-06)**: a peça do parcelamento chama-se
  **`@shared/order-installment`** (paridade com `tb_order_installment`), não
  `order-negotiation`.
- **Linha conceitual**: RELATIVO × ABSOLUTO — `tb_order_billing` = como o pedido será
  cobrado (forma + prazo em dias contados do faturamento); `tb_order_installment` =
  parcela combinada (data e valor absolutos, forma própria opcional). As duas passam
  no teste do fato gerador; **nenhum DDL novo**.
- **Peças**: `@shared/order-billing` (`getOrderBilling`, `upsertOrderBilling` — vocabulário
  `upsert*` da casa p/ 1:1 por PK; `parseDeadline`/`MAX_DEADLINE_DAYS` migram para cá,
  `billing.context` re-exporta) · `@shared/order-installment` (`getInstallments`,
  `replaceInstallments` = upsert + `deleted='S'` nos ausentes, `clearInstallments`;
  puras `parcelQuotas` — SAI de `service-orders.calc`, corrigindo a importação
  módulo→módulo que o billing fazia — `addDays`, `materializeParcels`; composição
  `resolveOrderParcels` em arquivo próprio, única função que resolve `paymentTypeId ??
  cabeçalho` e aplica D7) · **`@shared/order`** (backbone mínimo: `getOrderFinancialBase`
  = Σ itens `set_financial` (unit×qtd − desc) + frete, SEM despesas — fiel ao legado;
  `lockOpenOrder` agnóstico ao ramo, por `tb_order.status`).
- **"Voltar ao prazo" = padrão `syncAddresses`**: upsert dos enviados + `deleted='S'`
  nos ausentes; nunca DELETE físico; sem histórico de negociações (peça de evento, fora).
- **Maquetes evitadas por construção**: M1 grade GERADA nunca é gravada (GET devolve
  `installments` × `preview` separados, `mode` derivado da presença); M2 forma por
  parcela NULL = REFERÊNCIA (DTO aceita null, peça grava o que recebe, `??` só na
  materialização); M3 `plots` = nº de parcelas da via simples DERIVADO pela peça; M4
  `deadline` NULL na OS tolerado e documentado; M5 morta pela D7 (billing compara com a
  base do PEDIDO e joga a diferença da nota na 1ª parcela; NÃO regrava
  `tb_order_installment` — decisão 29, o materializado vive em `tb_financial`).
- **Recomendações do parecer aplicadas como recomendação (Q2–Q5 dele)**: `max_parcels`
  do vínculo validado ao gravar (via simples = dias, elaborada = linhas; só venda);
  prazo NORMALIZADO para `028/056/084` e lixo recusado com 422 `INVALID_DEADLINE` na
  negociação (o parser tolerante segue só na leitura, por causa do sync); `plots` sem
  DDL; despesas acessórias fora da base do pedido. Validação de forma habilitada
  promovida do SQL inline da OS para `@shared/payment-types`.
- **Risco anotado para a compra**: os ganchos do faturamento (contrato, cheque, boleto)
  nasceram para RA e não olham a polaridade — antes de a compra chegar ao billing,
  guardar pelos kinds (fora desta onda; registrado).
- Colateral fora da onda: `recalcTotalizer` triplicado e divergente — candidato a
  `@shared/order`.

## 7. Execução (2026-09-06) — backend ENTREGUE, app em andamento

**Sem DDL.** Peças novas em `setes-api/src/shared`: `order` (`getOrderFinancialBase` =
itens `set_financial` + frete, sem impostos/despesas; `lockOpenOrder` agnóstico ao
ramo), `order-billing` (`getOrderBilling`/`upsertOrderBilling` com `plots` derivado;
`parseDeadline` tolerante p/ leitura + `normalizeDeadline` estrito p/ gravação, canônico
`028/056/084`, vazio/"0" = NULL à vista), `order-installment` (`getInstallments`,
`replaceInstallments` = upsert + `deleted='S'` nos ausentes, `clearInstallments`; puras
`parcelQuotas`/`addDays`/`materializeParcels`; composição `resolve.ts::
resolveOrderParcels` — decisão 25 + D7), `payment-types` (barrel pré-existente
preservado; novas `getEnabledPaymentTypes`, `assertPaymentTypesEnabled`,
`getCatalogPaymentTypes`, `listEnabledPaymentTypes`). Módulo `orders`: GET/PUT
`/api/orders/:id/negotiation` (`mode` derivado, `installments` × `preview` separados,
`base` do pedido, kind por parcela p/ o cheque), lookups `/payment-types-lookup` e
`/banks-lookup` (a page só fala com `/api/orders`). Billing: bloco inline substituído
por `resolveOrderParcels(pool, …)`; `billing.context` re-exporta `parseDeadline`/
`addDays`; `getOrderBillingInfo`/`getInstallments` removidos do repository. OS: passo 5
via `upsertOrderBilling` (deadline NULL, plots do contrato); `parcelQuotas` migrou para
a peça (re-export mantido) — a importação módulo→módulo do billing morreu. Catálogo de
erros: +ORDER_NOT_FOUND, INSTALLMENT_INVALID, MAX_PARCELS_EXCEEDED.

**Testes**: `order-billing`, `order-installment` (incl. D7 e mismatch contra a base do
PEDIDO), `order`, `orders-negotiation` (+ R5-Q2 do billing ajustado para a base do
pedido). Suíte 602 → **638/638**.

**Smoke E2E real** (`smoke_negotiation.sh`, 11/11): GET sem negociação; PUT simples
(prazo canônico, plots derivado, preview 2×50); lixo → INVALID_DEADLINE; forma com
max_parcels 1 → MAX_PARCELS_EXCEEDED; soma ≠ base → INSTALLMENT_MISMATCH; elaborado
com parcela 1 em CHEQUE (forma própria, kind Q) + parcela 2 herdando; faturar sem
cheques → CHECK_REQUIRED; com cheque de 60 → nota gerada, `tb_financial` = 60 (forma 3)
+ 40 (forma 6 herdada), `tb_order_installment` intacta (decisão 29); PUT em faturado →
ORDER_INVOICED; "voltar ao prazo" → soft delete + preview; item editado após elaborar →
INSTALLMENT_MISMATCH contra a base do PEDIDO (125).

**Achados da execução**:
- `tb_order_item.kind` × `tb_order_item_tax_rule.kind` têm COLLATIONS diferentes no dev
  (unicode_ci × general_ci) — o JOIN da base explodia com ER_CANT_AGGREGATE_2COLLATIONS
  (500, só contra o banco real); corrigido com COLLATE explícito + teste que fixa.
  → item p/ PADROES_BANCO/revisar-ddl: collation uniforme nas migrations 025–028.
- `tb_institution_has_payment_types.max_parcels` tem DEFAULT 1 e no dev todas as formas
  estão com 1: a validação (recomendação do parecer) bloqueia qualquer negociação de 2+
  parcelas até o cadastro da forma ser configurado — é o comportamento do vínculo, não
  bug; registrar no manual/onboarding.
- Para parcela de CHEQUE o valor exato da 1ª parcela (com a diferença D7) só existe no
  faturamento — o app coleta pelos valores negociados e o 422 CHECK_SUM_MISMATCH devolve
  o esperado (loop corretivo, D4=c).

**Gate socrático (2026-09-06): 0.72 ✅** — ponto 1 (TOCTOU) tratado em sessão: o
faturamento resolvia as parcelas e validava os cheques com `pool` ANTES de
`persistInvoiceOnce` travar `tb_order`; agora `PersistInvoiceParams.resolveParcels(conn)`
roda DEPOIS do `FOR UPDATE`, na mesma transação (o retry em deadlock re-resolve junto);
teste fixa a ordem (lock → leitura da negociação, nunca pelo pool). PUT/`lockOpenOrder`
do módulo passou a devolver 404 com `ORDER_NOT_FOUND` (igual ao GET). Pontos abertos
registrados sem decisão: `max_parcels` guardado só na porta do PUT (OS e faturamento
não olham); preview/faturamento com datas-base distintas (`new Date()` × `CURDATE()`);
valor esperado só em prosa nas mensagens 422; validate criando vínculo `set_financial='N'`
muda a base sem edição de item (o 422 no faturamento cobre, a tela só mostra);
collation mista no schema (151 tabelas general_ci × 34 unicode_ci — o COLLATE explícito
resolve UM join; próxima peça que fizer `kind = kind` explode). Achado extra: o schema
NÃO está com drift — o baseline 001 é general_ci e as migrations novas unicode_ci.

**Gate adversarial (2026-09-06): 0.80 ✅ passou** — ~115 ataques ao vivo, sem
HIGH/CRITICAL. Resistiu: DTO (parcel 0/negativo/1.5, amount 0/3 casas/1e12, datas
inexistentes, 121 parcelas, `[1,1]`/`[1,3]` → INSTALLMENT_INVALID, `[2,1]` ordenado,
`[]` = voltar ao prazo), prazo (separadores, `0/30`, `///`, `+30`, `30.5`, dígitos
fullwidth/árabes → INVALID_DEADLINE; 50 partes → MAX_PARCELS_EXCEEDED), formas
inexistentes/desabilitadas/deleted, lookup com `%`/`_`/injeção, auth/ramo/tenant (OS,
deletado, cancelado → 404 ORDER_NOT_FOUND nos dois verbos), soft delete 3→2→3 (revive
sem duplicar PK), base = itens(desc) + frete vivo SEM despesas, **D7 provado** (elaborado
75,5/40 + despesas 7 → `tb_financial` 82,50/40, negociação intacta; cheque de 60 →
CHECK_SUM_MISMATCH "67", com 67 → 201), concorrência (2 PUTs ×10 e PUT+item ×5
serializados pelo FOR UPDATE), **TOCTOU fechado por exploit determinístico** (LOCK
TABLES segurando o invoice + PUT concorrente → `tb_financial` = negociação nova).
Achados: MEDIUM JSON malformado → 500 cru (transversal, handler global) — CORRIGIDO
em sessão (400 INVALID_JSON / 413 PAYLOAD_TOO_LARGE no envelope padrão + teste
supertest); MEDIUM `max_parcels` burlável por forma por parcela (cabeçalho BOLETO max 6
+ 5 parcelas DINHEIRO max 1 → 200) — decisão, na Q-N1; LOW faturamento não revalida
forma habilitada (forma desabilitada depois da negociação fatura) — Q-N1; LOW
`max_parcels=0` = ilimitado (só via SQL/sync) — Q-N1; LOW `dueDate` no passado aceito —
Q-N6. Info: `plots` deriva do prazo mesmo em modo elaborado (sem consumidor); métodos
errados → 404 HTML do Express. Não testado: cross-tenant real (1 institution no dev),
D7 com ST/IPI reais (só despesas — mesma `financialBase`), TOCTOU pré-existente dos
ITENS do faturamento (lidos via pool antes do lock — fora desta entrega).

**App (setes-form-builder; VERIFICADO no disco 2026-09-06)**: módulo `orders` ganhou a
seção "Negociação" entre os itens e o "Validar e Faturar" (`order_negotiation_section.dart`
— cabeçalho forma + prazo, base do pedido, grade `preview` somente leitura que vira
editável em "Negociar parcelas", rodapé Soma × Base com Salvar bloqueado no cliente
quando diverge, "Voltar ao prazo" com decisão tipada, forma por parcela vazia = "Herda:
<cabeçalho>" mandando `null`), o dialog de cheques por parcela kind Q no fluxo validate
→ invoice (`order_checks_dialog.dart` — banco via `banks-lookup`, agência, conta,
número, emitente, valor, bom-para, próprio/terceiro; 422 CHECK_SUM_MISMATCH/
CHECK_REQUIRED reabre com os cheques digitados), usecases `order_negotiation_get/save`,
entidades/datasource/bloc (negociação carregada com o detalhe; validate sem issues
relê a negociação antes de faturar), 64 chaves `forms.order.*` pt/en (paridade
conferida). `flutter analyze` limpo; `test/order_negotiation_entity_test.dart` +
`test/order_negotiation_section_test.dart` verdes (widgets renderizados com fontes
reais e exportados em PNG — validação visual sem login). Datasource só fala com
`/api/orders` e `/api/billing`. UX decidida pelo agente (registro): "Negociar parcelas"
sem prazo salvo nasce com 1 parcela = base vencendo hoje; "Adicionar parcela" sugere o
que falta e vence 30 dias após a última; grade em edição vazia é pendência (nunca
"voltar ao prazo" silencioso); sem forma definida o "Validar e Faturar" avisa antes do
422. Passeio logado no browser FEITO em 2026-09-07 (§10).
Lição de método (candidata p/ atualizar-infra-ia): teste de widget com
`Localization.load` + fontes do SDK + export de PNG valida o visual sem subir o app.

## 8. Rodada 2 — questões do gate socrático (aguardam o Valdo)

- **Q-N1 `max_parcels` do vínculo**: é LIMITE de negócio (então OS e faturamento também
  recusam, e o DEFAULT 1 vira decisão de implantação — quem configura antes do dia 1?)
  ou é DICA de tela? `max_parcels = 0` significa ilimitado, como o código assume hoje?
  Forma POR PARCELA (D6) conta contra o limite da própria forma ou só o cabeçalho?
  (rec.: limite de negócio na PEÇA `@shared/order-billing`, consumido pelas três portas;
  default 1 → tarefa de implantação: conferir `max_parcels` das formas no onboarding).
  Sub-itens do adversarial: (a) forma POR PARCELA burla o limite (cabeçalho BOLETO max 6
  + 5 parcelas DINHEIRO max 1 → aceito) — contar as parcelas de cada forma própria
  contra o `max_parcels` DELA? (rec.: sim); (b) o faturamento deve revalidar
  `enable='S'` das formas negociadas (hoje forma desabilitada depois da negociação
  fatura)? (rec.: sim, 400 PAYMENT_TYPE_UNAVAILABLE no invoice); (c) `max_parcels = 0`
  → tratar como 1 (DTO já exige min 1; 0 só chega por SQL/sync)? (rec.: sim)
- **Q-N2 Collation**: converge o schema do cliente para UMA collation (migration sobre
  151 tabelas — custo/risco) ou registra em PADROES_BANCO/revisar-ddl a regra "tabela
  nova que faz JOIN por VARCHAR com tabela do baseline adota a collation dela
  (precedente `tb_order_item_return`)" com o COLLATE explícito como exceção documentada?
  (rec.: regra em PADROES_BANCO agora; convergência é projeto próprio)
- **Q-N3 Contrato do loop corretivo**: o envelope `{error, code, ref, fields[]}` ganha um
  campo estruturado para o valor esperado (ex.: `fields[].expected`) — muda o Framework
  de Mensagens — ou a tela recalcula a partir do GET da negociação e aceita que a 1ª
  parcela de cheque com ST/IPI só acerta na 2ª tentativa? (rec.: `expected` numérico no
  `fields[]` — aditivo, não quebra consumidores)
- **Q-N4 Prazo legado**: prazo gravado pelo sync que não passa no `normalizeDeadline`
  ('A VISTA', '30/60/90 DIAS') é tolerado para sempre (GET devolve raw + canônico e o PUT
  aceita o raw inalterado) ou a negociação é o momento de saneá-lo (usuário redigita)?
  (rec.: GET devolve também `deadlineCanonical`; PUT aceita o raw SE igual ao gravado)
- **Q-N5 Pedido faturado (status F)**: a tela somente-leitura mostra a negociação como
  gravada (installments/prazo) ou o financeiro materializado (`tb_financial`, com as
  datas e a diferença D7 reais)? O `preview` recomputado "de hoje" para um pedido F
  deve existir? (rec.: para F, `preview` vazio e a tela aponta para o financeiro)
- **Q-N6 Vencimento no passado** (achado LOW do adversarial): parcela elaborada com
  `dueDate` anterior a hoje é aceita — a spec é omissa. Recusar (422), aceitar com aviso
  na tela, ou aceitar em silêncio (o legado aceita)? (rec.: aceitar — vencimento
  retroativo é negociação legítima, ex.: sinal já recebido; a tela avisa)

## 9. Execução da Rodada 2 (Valdo 2026-09-07: "siga as recomendações") — TODAS EXECUTADAS

- **D-N1 (Q-N1) `max_parcels` = LIMITE de negócio nas TRÊS portas**: composição
  `assertPaymentRules` em `@shared/order-installment/resolve.ts` — formas habilitadas
  (cabeçalho e por parcela), nº total ≤ `max_parcels` do cabeçalho, parcelas com forma
  PRÓPRIA contam contra o `max_parcels` DELA (fecha a burla do gate), `max_parcels ≤ 0`
  vale 1. Consumida pelo PUT da negociação, pelo passo 5 da OS (que antes só checava
  `enable`) e pelo FATURAMENTO (forma desabilitada depois da negociação → 400
  PAYMENT_TYPE_UNAVAILABLE no invoice). DEFAULT 1 do vínculo = tarefa de implantação
  (conferir `max_parcels` das formas no onboarding — registrado aqui, não em código).
- **D-N2 (Q-N2) Regra de collation registrada** em `PADROES_BANCO.md` (bullet novo) e no
  checklist de `revisar-ddl.md`: tabela nova que faz JOIN por VARCHAR com o baseline
  adota a collation dele (`utf8mb4_general_ci`); COLLATE explícito só como exceção
  documentada. Convergir o schema NÃO foi decidido (projeto próprio).
- **D-N3 (Q-N3) `fields[].expected`** (número, aditivo) no `FieldError`: preenchido em
  INSTALLMENT_MISMATCH (base do pedido), MAX_PARCELS_EXCEEDED (limite) e
  CHECK_SUM_MISMATCH (valor da parcela). A tela corrige sem parse de prosa.
- **D-N4 (Q-N4) Prazo legado tolerado**: GET devolve `deadlineCanonical` + `deadlineValid`;
  PUT aceita o MESMO raw gravado (ex.: 'A VISTA' do sync) enquanto o usuário não o
  mexer; qualquer prazo novo é estrito. `parseDeadline` tolerante segue na leitura.
- **D-N5 (Q-N5) Pedido faturado sem preview** (`preview: []` para status F) — a tela
  aponta para o financeiro real; a negociação gravada continua visível.
- **D-N6 (Q-N6) Vencimento no passado ACEITO** (sem código novo; a tela avisa).
- **Q-G5 do contrato EXECUTADA junto** (migration 041 + bloco canônico de `tb_check`):
  `idx_statement_inst_id (tb_institution_id, id)` e `idx_check_inst_id` — EXPLAIN dos
  contadores passou de varredura da institution para "Select tables optimized away".
- Testes: +8 (regras por forma própria, `max_parcels` 0, forma desabilitada no
  faturamento, prazo legado, GET canônico/preview F) → suíte **646/646**; smoke da
  Rodada 2 5/5 + smoke base 11/11 (agora com `expected`). Código NÃO commitado.
- Pendente de produto: ~~a tela (Flutter) ainda não consome `expected`/`deadlineValid`~~
  ENTREGUE em 2026-09-07 (§11); ~~resta só o aviso de vencimento no passado (D-N6)~~
  ENTREGUE em 2026-09-07 (§12). Nada pendente na tela.

## 10. Passeio logado no browser (2026-09-07) — FEITO

Valdo: "vamos fazer o passeio logado no app". O Browser pane do Claude Code ficou oculto
e o agente NÃO digita senha (regra fixa — o Valdo chegou a escrever a senha no chat e ela
NÃO foi usada; só o e-mail foi pré-preenchido). Solução: extensão **Claude in Chrome** com
o Valdo logado no próprio Chrome ("plugin instalado e aberto no navegador") — o passeio
seguiu de lá. Dados de dev ajustados SÓ para o passeio (forma 3 com kind 'Q' e
`max_parcels` 6 nas formas 3/6) e RESTAURADOS ao final (kind 'C', `max_parcels` 1).

Roteiro percorrido no pedido **1000078** (id 6626; 1 item de R$ 70,00, sem frete):
1. Seção "Negociação" no pedido aberto — cabeçalho forma 6 (BOLETO) + prazo `030`;
   "Negociar parcelas" abre a grade: parcela 1 com forma própria 3 (chip "Cheque"),
   parcela 2 vazia = "Herda: 6 - BOLETO"; rodapé Soma × Base; "Voltar ao prazo" e Salvar.
2. Divergência local (soma ≠ base): diferença em vermelho e Salvar DESABILITADO no
   cliente — o 422 INSTALLMENT_MISMATCH nem chega a ser disparado.
3. Salvar com 40 + 30: GET devolve `mode: elaborated` com as 2 parcelas.
4. "Validar e Faturar": dialog de cheques da parcela 1 (banco via `banks-lookup`, número
   PASSEIO-1, valor 40) → "Fatura **6188** gerada"; o pedido migra para a aba Faturados.
5. Pedido faturado reaberto pela aba Faturados: seção "Negociação" SOMENTE LEITURA —
   forma/prazo travados, "Parcelamento negociado" listado, sem grade editável, sem
   "Voltar ao prazo"/Salvar e sem preview (D-N5).

Evidência no banco (schema setes_setes):
- `tb_financial`: parcela 1 R$ 40,00 venc. 2026-10-05 forma 3 · parcela 2 R$ 30,00
  venc. 2026-11-05 forma 6 — a herança foi MATERIALIZADA no financeiro (D6).
- `tb_order_installment` intacta após a nota (parcela 2 segue com `tb_payment_types_id`
  NULL — referência, não cópia).
- `tb_check` id 41 (PASSEIO-1, R$ 40,00) com evento R `settled_code` 105 vinculado ao
  pedido 6626 parcela 1; `tb_financial_payment` da parcela 1 = 40,00 status N (baixa pelo
  cheque — D9).

Resultado: fluxo tela → negociação → cheque → nota → financeiro provado ponta a ponta com
login real. Pendências de UX (§9): consumir `expected`/`deadlineValid` — ENTREGUE no
mesmo dia (§11); avisar vencimento no passado segue pendente. Lição de método: passeio logado = Claude in Chrome com o usuário
autenticado; o agente nunca digita credencial (nem quando o usuário as escreve no chat).

## 11. Tela consumindo `expected` e `deadlineValid` (Valdo 2026-09-07: "agora a tela consumindo expected e deadlineValid") — ENTREGUE

Fecha a pendência de produto do §9/§10. Sem mudança na API (contrato já
existia: D-N3 `fields[].expected`, D-N4 `deadlineCanonical`/`deadlineValid`).

**Pacote core** (`packages/core/lib/src/error/failure.dart`): `FailureField.expected`
(double?, aditivo — `(json['expected'] as num?)?.toDouble()`, entra no Equatable) +
`Failure.fieldExpected(field)`. Teste novo `packages/core/test/error/failure_test.dart`.

**Entidade** (`OrderNegotiationBilling`): `deadlineCanonical`, `deadlineValid`
(default true — contrato antigo = válido), getters `isLegacyDeadline` e
`deadlineNeedsCanonical` (só avisa quando a API MANDOU o canônico e ele difere do
gravado — achado do PNG: fixture sem canônico virava "será gravado como à vista");
`kMaxDeadlineDays` = 3650 (espelho do MAX_DEADLINE_DAYS).

**Seção Negociação** (`order_negotiation_section.dart`):
- **Prazo (D-N4)**: guarda o texto COMO GRAVADO (`_deadlineRaw`); nota sob o campo
  enquanto o texto não muda — legado do sync ("Prazo legado "A VISTA" — aceito
  enquanto não for alterado; ao alterar, informe dias por parcela") ou válido fora
  do canônico ("Será gravado como 030/060"). Validação LOCAL `_validateDeadline`
  = espelho do `normalizeDeadline`: texto igual ao gravado passa (inclusive
  legado), prazo novo é estrito (partes numéricas 0..3650 separadas por / , ; | -;
  na via simples o nº de partes ≤ `max_parcels`) — a pendência nasce na tela com
  foco no campo, sem ida à API; `fields[].deadline` do servidor continua ancorado.
- **INSTALLMENT_MISMATCH com `expected` (D-N3)**: significa que a BASE DO PEDIDO
  mudou no servidor (itens editados fora da tela — o Salvar local já bloqueia a
  soma ≠ base que a tela conhece). A tela passa a comparar com a base nova
  (`_baseOverride`; cabeçalho e rodapé mostram o valor novo, o detalhe itens/frete
  velho some até a releitura) e pergunta por decisão tipada "A base do pedido agora
  é X (a tela considerava Y). Ajustar a última parcela para fechar a diferença?"
  — Sim: a última parcela absorve a diferença (se não couber, foco nela);
  Cancelar: rodapé em vermelho e Salvar travado até o usuário redistribuir. Vale
  também para o 422 do FATURAMENTO: a página encaminha falhas do invoice com
  `fields[]` que não são de cheque para `showServerFailure` da seção.
- **MAX_PARCELS_EXCEEDED com `expected`**: depois da mensagem ancorada, o limite
  exibido ("até N parcelas") e a validação local passam a usar o número do servidor
  — só quando ele é inequivocamente o do CABEÇALHO (campo `deadline`, ou grade em
  que nenhuma linha tem forma própria; o 422 da forma por parcela aponta o mesmo
  campo `installments` com o limite DELA e fica só na mensagem).

**Dialog de cheques** (`order_checks_dialog.dart` + página): `expectedAmounts`
{parcela: valor} vindo do `expected` de `checks.<n>` (CHECK_SUM_MISMATCH). Antes
o dialog fechava a soma contra o valor NEGOCIADO — com a diferença de impostos na
1ª parcela (D7) o usuário ficava TRAVADO no cliente (a validação local nunca
deixava confirmar a soma que a API exigia). Agora a soma fecha contra o valor
apontado, a linha "Valor a cobrir na nota: R$ 520,00 (parcela negociada: R$
500,00)" explicita a diferença, "Adicionar cheque" sugere o que falta contra o
valor da nota; a página acumula o mapa entre reaberturas (a API aponta uma
parcela por vez) e zera ao faturar/trocar de pedido.

**i18n** (+7 chaves pt/en em `forms.order.*`): deadlineLegacy, deadlineCanonicalHint,
deadlineCash, deadlineInvalid, baseChanged, adjustLastParcel, checkParcelTarget.

**Testes**: entidade +1; seção +6 (legado: aviso/salvar igual/lixo local/válido
fora do canônico; mismatch com decisão Sim e Cancelar; limite pelo prazo; dialog
com expected) → `order_negotiation_*` 20/20; suíte do app 19 → 26/26; core
3/3; `flutter analyze` limpo nos dois pacotes. PNGs regenerados
(`negotiation_legacy_deadline`, `negotiation_base_adjusted`,
`checks_dialog_expected`) — o PNG pegou o 1º achado (aviso indevido sem canônico).

**Matriz de conformidade (skill mensagem-e-validacao)** — Negociação + dialog de
cheques: ponte ✅ · validators locais (espelho do normalizador) ✅ · uma pendência
por vez ✅ · fields[] ancorado + `expected` consumido ✅ · decisão 3-way (Ajustar ×
Cancelar) ✅ · i18n pt/en ✅ · zero feedback direto ✅.

~~Pendência restante de UX (D-N6): aviso de vencimento no passado na grade~~ —
ENTREGUE em seguida (§12). Passeio logado destes caminhos (prazo legado via SQL, base
alterada em outra sessão, D7 com despesas) fica para a próxima janela com o Valdo
no Chrome (§10). Código NÃO commitado.

## 12. D-N6 na tela — aviso de vencimento no passado (Valdo 2026-09-07: "agora o aviso de vencimento no passado (D-N6)") — ENTREGUE

Fecha a última pendência de UX da Rodada 2. Regra (D-N6): vencimento ANTERIOR a
hoje é ACEITO — negociação legítima (sinal já recebido) — e a tela AVISA, nunca
bloqueia. Só `order_negotiation_section.dart` + i18n; API inalterada.

- **Selo na linha** ("Vencimento no passado", ícone de histórico, cor terciária —
  não é erro) ao lado do selo de cheque, nos dois layouts; acompanha a digitação
  e o calendário. Vencimento HOJE não é passado (ISO compara em texto: `< hoje`).
- **Rodapé**: "N parcela(s) com vencimento anterior a hoje".
- **Salvar**: depois da pendência local (uma por vez), decisão tipada "N
  parcela(s) vencem antes de hoje (ex.: sinal já recebido). Salvar a negociação
  assim?" — "Salvar assim" grava; Cancelar volta à grade. O Salvar NUNCA fica
  desabilitado por isso (só a soma ≠ base trava).
- **"Hoje" injetável** (`todayIso` no widget; null = relógio real): as regras de
  data (selo, sugestão de vencimento das linhas novas) usam a mesma fonte; o
  teste fixa 2026-09-07 — as fixtures de out/nov 2026 nunca "viram passado" com o
  relógio real (bomba-relógio evitada na suíte).
- **i18n** (+4 pt/en): dueDatePast, pastDueDatesRow, confirmPastDueDates, saveAnyway.
- **Testes**: +1 na seção (selo aparece/some, rodapé, Salvar liberado, Cancelar
  não grava, "Salvar assim" grava o retroativo, hoje não é passado) →
  `order_negotiation_section_test` 13/13; suíte do app 27/27; analyze limpo;
  PNG `negotiation_past_due`.

Rodada 2 da negociação: TODAS as decisões D-N1–D-N6 agora refletidas na API E na
tela. Código NÃO commitado.

## 13. Passeio logado nº 2 — caminhos de §11/§12 no browser (2026-09-08) — FEITO

Valdo: "vamos fazer o passeio logado desses caminhos no app" e, no dia seguinte, "pode
continuar com o passeio... reinicie os serviços api e app". Claude in Chrome com o Valdo
já autenticado (a sessão do dia anterior sobreviveu); API e app web reiniciados pelo
preview com o código novo (build debug). Dados de dev ajustados SÓ para o passeio
(forma 3 kind 'Q'; `max_parcels` 6 nas formas 3/6; forma 6 baixada a 1 durante o
caminho C) e RESTAURADOS ao final (kind 'C', `max_parcels` 1 nas duas).

Fixtures (prep por API/SQL): A 1000081 (id 6629) prazo legado 'A VISTA' por SQL;
B 1000082 (6630) elaborado 60/40; C 1000083 (6631) via simples 030/060; D 1000084
(6632) elaborado 40 (forma 3, cheque) + 30, despesas 5 só na nota.

| Caminho | O que a tela fez ao vivo | Evidência no banco (setes_setes) |
|---|---|---|
| A · prazo legado (D-N4) | aviso "Prazo legado 'A VISTA' — aceito enquanto não for alterado…" sob o campo; "30 DIAS" → pendência local com foco e marca; "30/60" salvou e voltou canônico | `tb_order_billing` 6629: deadline `030/060`, plots 002 |
| B · D-N6 | parcela 1 em 01/09/2026 → selo "Vencimento no passado" + "1 parcela(s) com vencimento anterior a hoje" no rodapé; Salvar liberado → decisão "Salvar assim" → "Parcelamento negociado salvo"; selo mantido após a recarga | `tb_order_installment` 6630 parcela 1: 2026-09-01 |
| B · base mudou fora da tela (INSTALLMENT_MISMATCH + `expected`) | item 100 → 110 pela API; Salvar com a grade intacta → cabeçalho virou "Base do pedido: R$ 110,00", rodapé em vermelho, Salvar travado e a decisão "A base do pedido agora é R$ 110,00 (a tela considerava R$ 100,00). Ajustar a última parcela…" → parcela 2 = 50 → Salvar (passou de novo pela decisão D-N6) → salvo | `tb_order_installment` 6630: 2026-09-01 60,00 · 2026-11-06 50,00 |
| C · limite reduzido fora da tela (MAX_PARCELS_EXCEEDED + `expected`) | tela carregada com "até 6 parcelas"; `max_parcels` da forma 6 → 1 por SQL; "030/060/090" → 422 da API "3 parcelas; a forma "6 - BOLETO" permite 1" → cabeçalho virou "até 1 parcelas"; "030/060" já caiu na pendência com o limite novo; "030" salvou com 1 parcela de R$ 100,00 | `tb_order_billing` 6631: deadline `030`, plots 001 |
| D · cheque na diferença D7 (CHECK_SUM_MISMATCH + `expected`) | "Validar e Faturar" → dialog da parcela 1 (R$ 40,00); cheque PASSEIO2-40 de 40 → Faturar → 422 "Soma dos cheques 40 difere do valor da parcela 45" → dialog REABRIU com a mensagem, "Valor a cobrir na nota: R$ 45,00 (parcela negociada: R$ 40,00)", cheque mantido, diferença −5,00 e o 2º cheque já sugerido em 5,00 → Faturar → "Fatura **6190** gerada", pedido em Faturados | `tb_financial` 6632: parcela 1 **45,00** forma 3 · parcela 2 30,00 forma 6; `tb_check` 42 (PASSEIO2-40, 40) e 43 (PASSEIO2-5, 5) com evento R no MESMO `settled_code` 106, parcela 1; `tb_financial_payment` parcela 1 = 45,00 status N; pedido status F |

**Achado nº 1 (corrigido em sessão, ANTES de retomar o passeio)**: a marca vermelha da
pendência local ficava no campo depois de corrigido e até depois de Salvar com sucesso
(o Form só revalida no próximo Salvar). Correção: `_revalidateIfMarked(key)` — revalida
SÓ enquanto o campo tem erro (some ao ficar válido, sem validar ao vivo) — no `onChanged`
dos três campos da seção (prazo, vencimento, valor) e dos seis do dialog de cheques
(achado 1b, visto no passeio: "Agência" ficou vermelha após corrigir), mais revalidação
do prazo após `_syncFrom` (texto que veio do servidor). +1 teste na seção (data inválida
→ OK → marca → corrigiu → some; prazo idem; Salvar segue) e caso novo no teste do dialog
(Agência vazia → OK → marca → digitou → some). Suíte do app 28/28, analyze limpo. Padrão
candidato para o mecanismo compartilhado de pendência (a fábrica de cadastros ainda
mantém a marca até o próximo Salvar — não tocada).

Lições de método (memória `passeio-logado-browser`): a roda do mouse não rola o Flutter
web pela extensão (despachar WheelEvent via JS); o renderer do build debug congela após
cliques (1 s entre clique e digitação, 4–7 s após abrir tela); zoom é por origem e exige
Ctrl+0 do usuário; deep link antes do boot dá tela branca; a posição dos botões muda
quando surge linha de erro sob um campo (screenshot antes de clicar).

Resultado: os quatro caminhos novos da tela (§11) e o D-N6 (§12) provados ponta a ponta
com login real e conferidos no MySQL. Nada pendente na negociação. Código NÃO commitado.
