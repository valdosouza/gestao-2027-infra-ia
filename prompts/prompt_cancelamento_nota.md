# Prompt — Cancelamento de nota fiscal de venda (desfazer o faturamento)

**Escopo**: setes
**Status**: RODADA 1 DECIDIDA (D1–D17, §6); parecer APLICADO (§7, Q-P1..Q-P8 aceitas);
ONDA 1 API + app ENTREGUES (§8, 2026-09-09) — gates em andamento; passeio pendente.
**Origem**: escolha do Valdo em 2026-09-08 ("cancelamento") entre os processos com regras
já extraídas do legado. Fonte de regras: `D:\Gestao2016\Infra-IA\Gestao\04-processos\
proc-cancelamento-nfe.md` (Process C00–C05) + `05-regras/CAN-V1..V7, CAN-H1, CAN-01..06`
+ `01-grafo/processo2-cancelamento.md` (Decisões 23, 24, 34, 36, 40 do legado).
**Fase**: Faturamento Fiscal e Financeiro — decisões 4, 13, 15, 19, 20 vigentes
(`prompt_fase_faturamento_financeiro.md`); pré-requisitos já anotados: D7 do contrato
financeiro, D-B5 do boleto, D10/D11 do cheque, R4 da comissão.
**Parecer conceitual**: setes-conceito — DEPOIS da Rodada 1 (antes de qualquer objeto).

## 1. O que o Valdo pediu

"cancelamento" — o próximo processo do faturamento a nascer na web é o Cancelamento de
NF-e de venda, o inverso do faturamento. Este prompt abre a Rodada 1 com os fatos
verificados nas duas fontes e as questões que só o Valdo decide.

## 2. Fatos verificados

### 2.1 Legado (Process C00–C05, 14 regras CAN-*)

- **Dois caminhos** pela situação do retorno SEFAZ: **pendente** (nunca autorizada) × **autorizada**.
  Pendente: a nota é APAGADA, impostos/retorno/observações apagados, itens desvinculados,
  pedido volta a aberto (`PED_FATURADO='N'`, número mantido), estoque inalterado (o pedido
  reaberto continua responsável), despacho e parcelamento apagados. Autorizada: evento de
  cancelamento na SEFAZ com **justificativa obrigatória**; só **cStat 135** prossegue; nota
  `NFL_STATUS='C'`, pedido `PED_FATURADO='C'` e `PED_NUMERO=NULL` (documento oficial não
  volta), estoque devolvido, despacho permanece (Decisão 34).
- **Validações** (C01): nota carregável (V1); permissão CANCELAR (V2); emissão não anterior
  ao último inventário dos produtos (V3); **nenhum título baixado** — "Financeiro acusa
  Pagamento(s) Baixado(s)" — inclusive a venda à vista que nasce baixada (V4, Decisão 24:
  o estorno da baixa vem ANTES, manual); NFS-e vinculada autorizada bloqueia a pendente
  (V5, Decisão 36); situação 0/1/3/4 bloqueiam o cancelamento na SEFAZ (V6); confirmação
  humana "Deseja realmente Cancelar este Documento?" (H1).
- **Desfazer** (C04): títulos apagados FISICAMENTE (CAN-04; Decisão 40 aceita o físico no
  legado), lançamentos de caixa das quitações do faturamento apagados na autorizada,
  comissão e "vendido" apagados por pedido, séries voltam a disponíveis, tudo em
  transação única (CAN-06; exceção conhecida `Pc_Retornodevolucao` commita no meio —
  item do plano legado).
- NFC-e fora (Decisão 23); nota complementar (SC/EC) é outro documento.

### 2.2 Web — o que o faturamento cria hoje (`POST /api/billing/invoice`, transação única)

| Efeito | Onde | Observação para o cancelamento |
|---|---|---|
| `tb_invoice` (id = pedido; `status='0'` = pronta, NÃO transmitida; número MAX+1 por modelo+série SEM filtro de deleted; `note` = observações) + `tb_invoice_merchandise` / `tb_invoice_service` (ramos por PRESENÇA) | billing.repository | **Toda nota da web é "pendente"**: a transmissão/autorização SEFAZ é fase guardada (`geracao-nfe-hierarquia §5`). Colunas: `status char(1)`, `deleted`, sem chave/protocolo/motivo. |
| Vínculos `tb_order_item_tax_rule` / `tb_order_item_service_tax_rule` + snapshots por item `tb_order_item_icms/_fcp/_ipi/_ii/pis-cofins/_issqn` | idem | espelho dos "impostos por item" do legado (apagados na pendente) |
| `tb_financial` + `tb_financial_bills` (uma por parcela; `situation 'N'`, `stage 'N'`) | idem (3º produtor das mesmas tabelas) | títulos ABERTOS; baixa = `tb_financial_payment` + `tb_financial_statement` |
| Comissão por item (`@shared/commission`, lançamentos IMUTÁVEIS) | idem | R4 da fase: reconciliação = SEMPRE lançamento novo de compensação, nunca UPDATE/soft-delete |
| Baixa automática por CONTRATO (`tryAutoSettleByContract`, SAVEPOINT, nunca bloqueia) | idem | título já nasce BAIXADO quando há contrato (espécie/PIX/cartão) → cai na regra D7 |
| CHEQUES recebidos (`receiveChecksOnBilling`, evento R, sem savepoint, exige caixa aberto) | idem | estorno de R = evento X (D10: recusa se o cheque avançou; D10 estendido ao grupo; D11 voided libera identidade) |
| BOLETOS automáticos (`tryIssueBankSlipsOnBilling`, SAVEPOINT) | idem | D-B5: boleto ABERTO exige C antes; LIQUIDADO exige X antes |
| Devolução (ramo adjust: `persistReturn`, âncora `returnedOrderId` exige original `'F'`) | idem | devoluções apontam para a venda faturada |
| `tb_order.status = 'F'` | idem | web só conhece 'A' (aberto) e 'F' (faturado); não existe 'C' |
| Estoque | — | a web NÃO tem razão de estoque (só `tb_order_stock_adjust` do ramo ajuste) — CAN-05/CAN-V3 sem objeto hoje |
| Séries de produto, despacho, pré-pago, conserto, e-commerce | — | não existem na web |

Decisões da web já tomadas que tocam o cancelamento:
- Fase (2026-08-16) **#4**: "cancelamento não-autorizado → soft-delete total + ordem volta
  à origem; nota autorizada cancelada → ordem NÃO volta (cópia de ordem) + financeiro
  soft-delete COM estorno em cadeia das baixas; estorno em dinheiro exige caixa aberto";
  **#15** "Cancelamento com baixas → ESTORNO EM CADEIA antes do soft-delete"; **#19** caixa
  aberto; **#20** nota autorizada cancelada: ordem não volta, oferece cópia.
- Contrato financeiro **D7** (2026-09-03, mais recente): "NÃO se cancela faturamento com
  financeiro BAIXADO — primeiro estorna-se o financeiro, depois libera-se o cancelamento".
  Boleto **D-B5** espelha D7. ⚠️ D7 e #15 apontam para lados opostos (recusar × estornar
  em cadeia) — Q2.
- Comissão **R4**: compensação por lançamento novo. Cheque **D10/D11**. Devolução exige
  original 'F' (2026-08-24).
- Verificado 2026-09-08: não existe nenhum código de cancelamento de faturamento na web
  (billing só tem `validate` e `invoice`); não existe módulo `invoices`.

## 3. Modelo proposto (peças de lego — para o parecer do setes-conceito depois da Rodada 1)

- **Estado da nota DERIVADO de eventos** (mesmo padrão do cheque e do boleto): tabela
  `tb_invoice_event` append-only — `E` emitida (nasce no faturamento), `C` cancelada
  (com MOTIVO obrigatório, usuário, data) e, na fase de transmissão, `T` transmitida /
  `A` autorizada / `R` rejeitada / `X` cancelada na SEFAZ (protocolo, cStat) /
  `I` inutilizada. `tb_invoice.status` vira espelho derivado (ou fica só para o sync).
- **Peça `@shared/invoice`** (ou `invoice-cancel`): `cancelInvoice(conn, ...)` =
  composição de peças EXISTENTES, nunca reimplementação — `financial-settlement`
  (assert "nenhum título baixado" — D7), `bank-slip` (cancelar abertos / recusar
  liquidados — D-B5), `check` (X de R via `reverseCheckEvent`, D10), `commission`
  (compensação — R4), `order-return` (devoluções apontando para a nota bloqueiam),
  `order` (status de volta), soft-delete de `tb_financial`/`_bills` e do vínculo/snapshot
  fiscal, evento `C`. Transação única com `withDeadlockRetry`.
- **Tela**: ação "Cancelar nota" na aba **Faturados** do módulo `orders` (a devolução já
  nasce dessa aba) → decisão tipada com o motivo obrigatório → `POST /api/billing/cancel`
  (ou `/api/orders/:id/cancel-invoice`); 409 com a LISTA do que impede (títulos baixados,
  boletos liquidados, cheques avançados, devoluções vigentes) — Framework de Mensagens.
- Ramo "autorizada" (SEFAZ) NÃO nasce agora, mas o modelo de eventos o comporta sem DDL
  novo além do que já vier para a transmissão.

## 4. Rodada 1 — questões para o Valdo (recomendação entre parênteses)

- **Q1 Escopo desta onda**: só a nota NÃO transmitida (todas as notas da web hoje), com o
  modelo pronto para a autorizada; o ramo SEFAZ (evento 135, inutilização) fica para a
  fase de transmissão? (rec.: sim)
- **Q2 Título baixado — D7 × decisão #15 da fase**: cancelar RECUSA (409 listando o que
  precisa ser estornado antes — D7, D-B5, legado CAN-V4/Decisão 24) ou dispara o ESTORNO
  EM CADEIA automático (#15/#4)? (rec.: D7 prevalece — é a mais recente e espelha o
  legado; o estorno em cadeia automático apagaria a trilha de quem baixou o quê)
- **Q3 Nota pendente cancelada — o que fica**: linha `tb_invoice` soft-deletada (espelho
  do "apaga" do legado) ou mantida com evento `C` e `deleted='N'` (auditoria: número,
  valor, motivo, quem)? (rec.: mantida com evento; nada se apaga)
- **Q4 Numeração**: o número da pendente cancelada é REAPROVEITADO (legado: a linha some e
  o MAX+1 reutiliza) ou vira BURACO (web: MAX+1 sem filtro)? Buraco em numeração fiscal
  exige inutilização na SEFAZ; reaproveitar exige que o MAX+1 e a futura UNIQUE ignorem
  as canceladas não transmitidas. (rec.: reaproveitar enquanto não transmitida — fiel ao
  legado e sem inutilização; a UNIQUE nasce filtrada quando a transmissão vier)
- **Q5 Pedido**: volta a `'A'` (aberto, número mantido, negociação/parcelamento
  intactos, editável e refaturável gerando nota nova)? (rec.: sim — é o "pendente" do
  legado; o 'C' de pedido só existe para a autorizada, fase futura)
- **Q6 Financeiro aberto**: `tb_financial` + `tb_financial_bills` soft-delete
  (`deleted='S'`) ou marcação de situação 'C' mantendo as linhas? (rec.: soft-delete —
  decisão #4 da fase; o legado apaga físico (Decisão 40), a web não apaga)
- **Q7 Comissão**: gerar lançamentos de COMPENSAÇÃO negativos na mesma transação (R4)?
  (rec.: sim)
- **Q8 Cheques recebidos na nota**: estornar o R automaticamente (evento X) quando o cheque
  ainda está em custódia; se algum avançou (depositado/descontado/usado) → 409 listando
  os cheques (estornar na tela de Cheques antes)? (rec.: sim; exige caixa aberto só
  nesse caso — o R nasceu no caixa)
- **Q9 Boletos**: aberto → cancelar (C) automaticamente na transação; liquidado → 409
  (estornar antes — D-B5)? (rec.: sim)
- **Q10 Devoluções contra a nota** (`returnedOrderId` = este pedido, vigentes): bloqueiam
  o cancelamento (409 — cancelar a devolução antes, espelho de "cancele a NFS-e antes")?
  (rec.: sim)
- **Q11 Inventário/estoque** (CAN-V3, CAN-05): sem objeto na web — registrar como regra
  futura da frente de estoque, sem código agora? (rec.: sim)
- **Q12 Permissão CANCELAR** (CAN-V2): privilégio próprio da interface (quem fatura não
  necessariamente cancela) ou a mesma permissão de faturar? (rec.: privilégio próprio —
  conferir como o catálogo de privilégios expressa "ações" hoje)
- **Q13 Motivo obrigatório + confirmação** (CAN-V6/H1) também na pendente? (rec.: sim —
  motivo gravado no evento `C`)
- **Q14 Onde nasce a tela**: ação na aba Faturados do pedido (rec.) × módulo `invoices`
  novo (a tela de notas nasce na fase de transmissão e ganha o ramo SEFAZ)
- **Q15 Nota conjugada** (mercadoria + serviço = uma nota com dois ramos): cancela os dois
  ramos juntos; a regra da NFS-e autorizada (CAN-V5) fica para a transmissão? (rec.: sim)
- **Q16 Caixa aberto** (decisão #19): exigir só quando houver dinheiro a estornar (cheque
  R); cancelamento sem movimento não exige caixa? (rec.: sim)
- **Q17 Auditoria**: `tb_invoice_event` append-only com estado derivado (rec.) × colunas
  `status`/`cancel_reason`/`canceled_at` na `tb_invoice`?

## 5. Plano após a Rodada 1

1. Parecer setes-conceito sobre §3 (peça, eventos, nomes).
2. Onda 1 — API: DDL (`tb_invoice_event` + seed do evento E retroativo?), peça
   `@shared/invoice`, endpoint, catálogo de erros (INVOICE_*), testes; gates socrático +
   adversarial; smoke real no dev (nota com contrato baixado, com cheque, com boleto, com
   devolução, limpa).
3. Onda 1 — app: ação na aba Faturados + decisão com motivo + tratamento do 409 com
   lista; passeio logado.
4. Onda 2 (fase de transmissão): ramo autorizada (SEFAZ), pedido 'C' + cópia de ordem
   (#20), inutilização.

## 6. Decisões — Rodada 1 (Valdo, 2026-09-08)

| # | Decisão | Origem |
|---|---|---|
| **D1** | Onda 1 = só nota NÃO transmitida (todas da web); ramo SEFAZ na fase de transmissão | rec. |
| **D2** | Título baixado → cancelamento RECUSA (409 com a lista do que estornar antes). D7 do contrato prevalece sobre a decisão #15 da fase; o estorno em cadeia automático MORREU | rec. |
| **D3** | Nota **autorizada** cancelada é MANTIDA (evento C, documento oficial). Nota **não autorizada** cancelada usa **soft-delete** (`deleted='S'`) — espelho do "apaga" do legado, sem apagar físico | Valdo (≠ rec.) |
| **D4** | Nota autorizada cancelada MANTÉM o número. Nota não autorizada cancelada LIBERA o número para reaproveitamento (o MAX+1 por modelo+série passa a ignorar `deleted='S'`) | Valdo |
| **D5** | Pedido volta a `'A'` (aberto), número e negociação intactos, editável e refaturável (gera nota nova) | rec. |
| **D6** | Financeiro ABERTO da nota: `tb_financial` + `tb_financial_bills` com `deleted='S'` | rec. |
| **D7** | Comissão: lançamentos de COMPENSAÇÃO negativos na mesma transação (R4 — nunca UPDATE) | rec. |
| **D8** | Cheque recebido na nota ainda em custódia → X automático do R na transação; cheque que avançou (depositado/descontado/usado) → 409 listando (estornar na tela de Cheques antes) | rec. |
| **D9** | Boleto aberto → C automático na transação; liquidado → 409 (estornar antes, D-B5) | rec. |
| **D10** | Devolução vigente apontando para a nota → 409 (cancelar a devolução antes) | rec. |
| **D11** | Inventário/estoque (CAN-V3, CAN-05): regra registrada para a frente de estoque; sem código | rec. |
| **D12** | Permissão CANCELAR = privilégio PRÓPRIO (quem fatura não necessariamente cancela) | rec. |
| **D13** | Motivo obrigatório + confirmação tipada também na nota pendente; motivo gravado no evento | rec. |
| **D14** | Tela = ação "Cancelar nota" na aba Faturados do pedido | rec. |
| **D15** | Nota conjugada: cancela os dois ramos juntos; NFS-e autorizada (CAN-V5) fica para a transmissão | rec. |
| **D16** | Caixa aberto é EXIGIDO quando o cancelamento envolver **cheque OU dinheiro em espécie** — qualquer linha de caixa que a peça venha a gravar (hoje, pela D2, só o X do cheque R; a regra fica como invariante da peça para o ramo autorizado e para o estorno em espécie que vier a existir) | Valdo (ampliou) |
| **D17** | Auditoria por `tb_invoice_event` append-only, estado DERIVADO do último evento | rec. |

Consequências de engenharia a levar ao parecer (não são decisões novas):
- **Refaturar o pedido depois da D3/D5**: `tb_invoice`, `tb_invoice_merchandise`,
  `tb_invoice_service` têm PK = id do pedido (1 nota por pedido); `tb_financial`/`_bills`
  têm PK (institution, pedido, terminal, parcela); os snapshots fiscais por item têm PK por
  item. Uma nota soft-deletada + o pedido refaturado colidem na PK → o faturamento precisa
  REVIVER a linha (padrão "recriar number excluído REVIVE a linha", decisão 8/Q1 dos
  bancos) ou os dados derivados (snapshots/vínculos) serem substituídos. A soft-deletada
  deixa de existir para o MAX+1 (D4) mas continua na trilha (evento C com motivo).
- Com a D3 a nota pendente cancelada some das listas; a auditoria vive em
  `tb_invoice_event` (E do faturamento + C do cancelamento, com motivo e usuário).

## 7. Parecer conceitual (setes-conceito, 2026-09-08) — aplicado ao desenho; Q-P1..Q-P8 aguardam o Valdo

**Conceito**: a nota é um DOCUMENTO com história — cada fato é evento append-only e o
estado é derivado do último. O cancelamento não é objeto: é a COMPOSIÇÃO "desfazer o
faturamento" sobre peças existentes. Nenhuma D1–D17 reaberta.

1. **`tb_invoice_event` é PEÇA** (irmã de `tb_check_event`/`tb_bank_slip_event`): PK
   `(tb_institution_id, tb_invoice_id, terminal, event)` + FK composta para `tb_invoice`
   (a nota tem `terminal` na PK). Colunas: `kind` (`E` emitida · `C` cancelada; RESERVADOS
   `T A R D I` para a transmissão — **`X` nunca**, na casa X é meta-evento de estorno),
   `dt_record`, `tb_user_id`, `note` (motivo; a peça exige no C), `origin_event` (C aponta
   o E), e o **snapshot do fato no E** (`number`, `serie`, `model`, `value`) — porque com
   D3+D5 o cabeçalho será REVIVIDO e sobrescrito no refaturamento; a memória de "nota 100
   cancelada por X" passa a ser o evento. Sem `settled_code` (o C não move dinheiro — D2);
   colunas SEFAZ agregam depois (`ADD COLUMN`).
   **E nasce no faturamento a partir de agora, dentro da peça** (`issueInvoice`: cabeçalho
   com revive + MAX+1 filtrando `deleted='N'` (D4) + ramos por presença + E) — o invariante
   "identidade da nota = pedido" vive num só código. **Backfill**: E retroativo para toda
   `tb_invoice` `status='0'`, `deleted='N'` sem evento (`tb_user_id NULL`, `note`
   'retroativo'). Nota sincronizada do legado (sem E) NÃO é cancelável na web (409 —
   "cancele na origem"). `tb_invoice.status` vira ESPELHO escrito pela peça, nunca lido
   para decidir; listagem usa `COALESCE(último evento, status)`.
2. **Pasta `@shared/invoice`** (precedente `@shared/entity`): `invoice.ts` (peça:
   `issueInvoice`, `insertInvoiceEvent`, `lockInvoice`, `stateFromLastEvent`,
   `LAST_INVOICE_EVENT_KIND_SQL`) + `invoice-cancel.ts` (composição `cancelInvoice(conn,
   schema, inst, userId, {orderId, reason})` → `{invoiceNumber, event, checksReversed[],
   bankSlipsCancelled[], commissionsCompensated}`). Três tempos sob a transação do
   chamador (`withDeadlockRetry` no módulo): (1) TRAVAR pedido + nota FOR UPDATE, exige
   último evento E; (2) PLANEJAR (`CancelPlan` tipado, só leitura com os locks): títulos
   com payment vivo → bloqueio `title`; boleto liquidado → `bankSlip`, aberto → cancelar;
   cheque R que `reverseCheckEvent` recusaria → `check`, senão estornar; devolução
   apontando para o pedido → `return`; qualquer bloqueio → **409 `INVOICE_CANCEL_BLOCKED`**
   com `fields[]` tipado; (3) EXECUTAR sem reimplementar nada: `cancelBankSlip`,
   `reverseCheckEvent` do R, `insertCommissions` com o saldo vivo NEGATIVO por item (R4),
   soft-delete de `tb_financial`/`_bills` (D6), dos SNAPSHOTS fiscais por item e dos ramos,
   evento C (origin = E), `tb_invoice.deleted='S'` (D3), `tb_order.status='A'` (D5).
   HTTP no módulo `billing` (`POST /api/billing/cancel {orderId, reason}` — o datasource
   de orders já fala com `/api/billing`). Catálogo: `INVOICE_NOT_FOUND` 404 ·
   `INVOICE_NOT_CANCELLABLE` 409 · `INVOICE_REASON_REQUIRED` 400 ·
   `INVOICE_CANCEL_BLOCKED` 409 + fields · reusa `NO_OPEN_CASHIER` · `PRIVILEGE_REQUIRED` 403.
3. **Refaturamento (D3/D4/D5)**: reviver IDENTIDADES (`tb_invoice`, ramos, `tb_financial`/
   `_bills` por upsert — padrão "recriar number excluído REVIVE"), substituir DERIVADOS
   (snapshots já fazem `ON DUPLICATE KEY UPDATE … deleted='N'`), NUNCA tocar RAZÕES
   (payments/statement/check_event/bank_slip_event/commission — só lançamentos novos; o
   contador `event` da nota continua E1, C2, E3…). **Correção ao §3**: o vínculo
   `tb_order_item_tax_rule` é do PEDIDO (escolha 'M' do cliente) e NÃO se toca — cancelar
   apaga só o snapshot. D4: MAX+1 filtrado reaproveita o número só se a cancelada era a
   última (igual ao legado); número no meio vira buraco para a inutilização da transmissão.
4. **D16 como invariante único**: do `CancelPlan` deriva `touchesCash` (hoje: todo R de
   cheque nasce na conta 0; amanhã: estorno em espécie / ramo autorizado). UMA asserção
   entre o plano e a primeira escrita: `touchesCash && sem caixa aberto → NO_OPEN_CASHIER`.
   Fato: `reverseOnePayment` e `reverseCheckEvent` NÃO exigem caixa (herdam a sessão do
   original, D-G3) — a D16 não vem de graça das peças de baixo.
5. **Riscos/nomes**: plano na peça, não no módulo (senão tela-que-grava-tudo); `X` nunca
   como evento SEFAZ; nomes `tb_invoice_event`, `@shared/invoice`, `cancelInvoice`,
   `issueInvoice`, `CancelPlan`. **Achado D12**: a API não aplica NENHUM privilégio de ação
   hoje (`FATURAR` é só botão no app) — `CANCELAR` = id 7 no catálogo central +
   `tb_interface_has_privilege` da interface de pedidos + guard transversal novo
   `requirePrivilege(interfaceId, privilegeId)` em `@shared/auth`.

### Questões do parecer (aguardam o Valdo — recomendação entre parênteses)
- **Q-P1** Backfill do E só para notas da web (`status='0'`, sem evento); nota sincronizada
  do legado NÃO cancelável na web; eventos escritos pelo setes-sync ficam para a Rodada 4
  do sync? (sim — outro grupo, não muda nesta tarefa)
- **Q-P2** `C` único para "cancelada" (pendente × autorizada derivado da presença de `A`)
  e `X` NUNCA como evento SEFAZ? (sim)
- **Q-P3** Colunas SEFAZ (protocolo/cStat/recibo) só na fase de transmissão; agora só os
  kinds reservados? (sim)
- **Q-P4** Bloqueios num ÚNICO código `INVOICE_CANCEL_BLOCKED` com `fields[]` tipado
  (`title|bankSlip|check|return`), não 4 códigos? (um código)
- **Q-P5** `CANCELAR` = privilégio 7 + guard transversal — e o MESMO guard passa a aplicar
  `FATURAR` em `POST /billing/invoice` nesta entrega? (sim; senão a D12 é botão, não regra)
- **Q-P6** Lacuna da D10 do cheque: `R → B → X(B)` deixa o cheque em custódia com
  `lastEvent ≠ R`, e `reverseCheckEvent` recusa para sempre → nota incancelável sem
  saída. Refinar D10 para "evento posterior VIGENTE" (pares neutralizados por X não
  contam)? (sim — agrega à peça do cheque; pode nascer junto com a Onda 1)
- **Q-P7** Devolução "vigente" = ordem de devolução viva em QUALQUER status ('A' ou 'F')?
  (sim — a aberta também aponta para esta vida da nota)
- **Q-P8** Compensação de comissão pelo SALDO vivo por item (net dos lançamentos), não só
  pelos positivos — nasce `getCommissionBalanceByItem` na peça `commission`? (sim)

## 8. Execução da Onda 1 (2026-09-08 → 09) — API + app ENTREGUES (gates em andamento)

**Valdo**: "Q-P1 a Q-P8 - Rec." (todas as questões do parecer aceitas).

**DDL** — migration `042_invoice_event.sql` (+ bloco canônico em `sql/03`): `tb_invoice_event`
PK `(institution, invoice, terminal, event)`, FK composta para `tb_invoice`, `kind` E/C
(reservados T A R D I; nunca X), `dt_record`, snapshot `number/serie/model/value`,
`origin_event`, `note` (motivo), `tb_user_id` (NULL = retroativo); backfill do E para toda
nota `status='0'` viva sem história (51 notas no dev; `note='retroativo'`). Seed central
`sql/51`: privilégio 7 CANCELAR + vínculo FATURAR/CANCELAR à interface `orders` (29).

**Peça `@shared/invoice`** (`invoice.ts` + `invoice-cancel.ts` + `index.ts`):
- `issueInvoice` — número MAX+1 por modelo+série **ignorando `deleted='S'`** (D4), cabeçalho
  por upsert com REVIVE (D3/D5), ramos por PRESENÇA (upsert; ramo ausente vira 'S'),
  evento E com snapshot. `persistInvoiceOnce` do billing passou a chamá-la (o INSERT inline
  da nota saiu do módulo); `tb_financial`/`_bills` viraram upsert com revive.
- `cancelInvoice` = `buildCancelPlan` (travar pedido 'F' + nota com último evento E → 409
  `INVOICE_NOT_CANCELLABLE` para não faturado / já cancelada / sincronizada sem E; planejar:
  cheques R do pedido via `isCheckEventCurrent` — reversível ou bloqueio `check`, 1 estorno
  por grupo de settled_code; payments vivos que NÃO são o R de cheque → bloqueio `title`;
  boletos dos títulos: liquidado → `bankSlip`, aberto → cancelar; `tb_order_stock_adjust_
  return` com ordem viva em qualquer status → `return`; comissão = saldo vivo por item) →
  qualquer bloqueio = **409 `INVOICE_CANCEL_BLOCKED` com `fields[]` tipado** (Q-P4) →
  D16 `touchesCash` (cheque a estornar) exige caixa aberto (`NO_OPEN_CASHIER`) → executar:
  `cancelBankSlip`, `reverseCheckEvent`, `insertCommissions(−saldo)`, soft-delete de
  `tb_financial`/`_bills`, dos 7 snapshots fiscais por item e dos ramos, evento C (motivo,
  origem = E, snapshot), `tb_invoice.deleted='S'`, `tb_order.status='A'`. O vínculo
  `tb_order_item_tax_rule` NÃO é tocado (parecer §3).
- Peças agregadas: `commission.getCommissionBalanceByItem` (Q-P8);
  `check.isCheckEventCurrent` + D10 refinada em `reverseCheckEvent` (Q-P6: pares
  neutralizados por X não contam, também nos irmãos do grupo).
- Guard `@shared/auth/require-privilege` (D12/Q-P5): super/admin passam; regular exige
  `tb_user_has_privilege` ativo para a interface (i18n_key, cache) × privilégio; 403
  `PRIVILEGE_REQUIRED`. Aplicado em `POST /billing/invoice` (FATURAR) e `POST /billing/
  cancel` (CANCELAR). Achado registrado: até aqui a API não aplicava NENHUM privilégio de
  ação — FATURAR era só botão.
- Módulo billing: `POST /api/billing/cancel {orderId, reason}` (Swagger), service com
  `withDeadlockRetry` + transação única. Catálogo: `INVOICE_NOT_FOUND`,
  `INVOICE_NOT_CANCELLABLE`, `INVOICE_REASON_REQUIRED`, `INVOICE_CANCEL_BLOCKED`,
  `PRIVILEGE_REQUIRED`.
- Testes: `invoice.test.ts` (+6), `invoice-cancel.test.ts` (+9: travar, bloqueios listados
  juntos, cheque livra a baixa do R e 1 estorno por grupo, D16, caminho completo com a
  ordem das escritas, sem cheque não consulta caixa), `require-privilege.test.ts` (+5),
  Q-P6 no `check.test.ts`; `billing.test.ts`/`service-tax-rule-billing.test.ts` passaram a
  mockar a peça. Suíte **671/671**.
- Smoke no dev (`smoke_cancel.sh`): limpo (nota 6191 → C → pedido 'A' → refaturamento
  reaproveitou o 6191 com evento E3 e títulos revividos); cheque em custódia (R→X, payment
  E/R, caixa 5); motivo vazio → 400 (DTO); já cancelada → 409.

**App (setes-form-builder dispensado — feito direto)**: `CurrentInterface` em
`app/shared/session` (privilégios da interface escolhida no menu; `navigateToInterface`
alimenta; 1º consumidor) · entidade `OrderBillingCancel` · datasource/repository/usecase
`OrderBillingCancelUsecase` (POST /api/billing/cancel) · bloc `OrderInvoiceCancelRequested`
→ `OrderInvoiceCancelled` (lista volta a ABERTOS, página 1) / `OrderInvoiceCancelFailure`
(409 `INVOICE_CANCEL_BLOCKED` → dialog listando os `fields[]`; demais → ponte padrão) ·
botão "Cancelar nota" ao lado de "Devolver" no pedido faturado, visível só com o privilégio
CANCELAR (D12/D14) · `OrderCancelInvoiceDialog` (título com o nº do pedido, explicação,
motivo obrigatório ≤ 255 com pendência ancorada — D13) · 9 chaves i18n pt/en · testes:
entidade (+2) e dialog (+1, PNG `cancel_invoice_dialog`) → app **31/31**, analyze limpo.

Pendente nesta onda: gates socrático + adversarial (rodando), passeio logado.

## 9. Gates da Onda 1 (2026-09-09)

### 9.1 Socrático — 1ª rodada: **0.58 REPROVOU** (3 falhas de concorrência/ciclo de vida que
`fakeConn` e o smoke não enxergam) → correções em sessão (§9.3)

- **C1 TOCTOU cancelar × baixar/emitir boleto**: o plano lia payments e boletos com SELECT
  simples; os escritores (`settleBatchTx`, `settleOneTitle`, `issueBankSlip`) travam
  `tb_financial FOR UPDATE`. Cenário: baixa manual commita entre o plano e o soft-delete →
  título 'S' com payment 'N' vivo; no refaturamento o upsert revive a MESMA parcela e o
  payment da vida anterior conta no `PAID_SUM` — a nota nova nasce paga com dinheiro da
  vida 1. Correção: o plano trava `tb_financial` do pedido (mesma ordem da baixa: pedido →
  título → payment → statement) e lê payments/boletos com `FOR UPDATE` — elimina também o
  deadlock latente cancel × baixa (M6).
- **C2 `isCheckEventCurrent` tratava como VIGENTE um evento que já tinha X apontando para
  ele** (o X entrava em `neutralized` e passava no `every`). Consequências: (A) mesmo cheque
  redigitado na 2ª vida → R antigo tem `X(R)` + R novo depois → bloqueio `check` sem
  saída; (B) cheque diferente na 2ª vida → R antigo "vigente" entra no estorno →
  `reverseOnePayment` acha payment 'E' → 409 REVERSAL_NOT_CURRENT e o cancelamento cai;
  regressão: estornar B/D/T/F já estornado deixou de ser recusado. Correção: alvo com X
  apontando para ele NÃO é vigente (409 próprio "evento já estornado"); o passo 2a do plano
  exclui R já neutralizado (só as vidas vivas contam).
- **H1 Nota de DEVOLUÇÃO faturada**: a composição era cega ao ramo — elos
  `tb_order_item_return` (INSERT simples, PK por item) não eram desfeitos; refaturar a
  devolução daria ER_DUP_ENTRY (500) e a venda de origem seguia com saldo consumido e
  bloqueada. → Q-G1 (rec.: Onda 1 RECUSA com 409 — implementado como assunção; ramo
  adjust na Onda 2).
- MEDIUM: M1 `MAX(CAST(number))` sem índice trava a institution inteira por faturamento
  (→ Q-G4); M2 `service-orders.generateInvoice` é 2º produtor de `tb_invoice` fora da
  peça (sem E/D4 — "cancele na origem" mentiria; → Q-G3); M3 D16 é permissão, não
  destino — o X do R herda a sessão do original (D-G3; → Q-G2); M4 TOCTOU cancel × abrir
  devolução (recuperável, janela pequena — registrado); M5 rollout do guard FATURAR (→
  Q-G5); M6 deadlock latente (cai com C1). LOW: cache do id da interface sem expiração
  (fail-closed), terminal 0 fixo, tag do Swagger (`Billing` × `billing` — corrigida), `MAX
  (aliq)` entre vidas, sync pode reviver nota cancelada (→ Q-G6, Rodada 4 do sync).
- Verificado OK: D2 sem payment não-cheque escapando; D16 só o X do R grava caixa;
  snapshots 7/7 revivem; E/C com snapshot (E1/C2/E3); listagens filtram `deleted`;
  cancel × faturar e cancel × cancel serializados pelo lock do pedido; D4 sem colisão.

### Questões do gate (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-G1**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Devolução faturada: Onda 1 RECUSA o cancelamento (409 — "cancele pela tela de
  devoluções"; implementado como assunção) ou a composição conhece o ramo adjust (elos
  soft-delete + `persistReturn` revive)? (rec.: recusar agora; ramo adjust na Onda 2)
- ~~**Q-G2**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) D16 × D-G3: o X do R herda a sessão de caixa ORIGINAL mesmo exigindo caixa
  aberto de quem cancela — mantém D-G3 como regra única de estorno (D16 = permissão)?
  (rec.: manter D-G3)
- ~~**Q-G3**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) `service-orders.generateInvoice` (Software House) migra para `issueInvoice`
  nesta onda (E + D4 + identidade num só código)? (rec.: migrar — é uma chamada)
- ~~**Q-G4**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Índice `(tb_institution_id, model, serie)` + coluna numérica para o MAX+1 de
  `tb_invoice` — migration 043, mesma família do Q-G5? (rec.: sim)
- ~~**Q-G5**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Rollout do guard FATURAR: usuários regulares sem `tb_user_has_privilege
  (orders, 5)` passam a receber 403 — tarefa de implantação (como `max_parcels`) ou seed
  que concede FATURAR a quem tem ALTERAR? (rec.: implantação)
- ~~**Q-G6**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Sync (outro grupo): `upsertInvoice` pode reviver nota cancelada na web e
  legado × web compartilham o MAX+1 do mesmo modelo/série — registrar na Rodada 4 do
  sync sem código agora? (rec.: sim)

### 9.2 Adversarial — 1ª rodada: **0.45 REPROVOU** (9 vetores executados ao vivo, 44 pedidos,
ids 6636–6680) — provou o que o socrático apontou e mais três

- **CRITICAL** cancel × baixa manual (`POST /settlements`): plano lia payments sem lock →
  pedido 6666 ficou com título 'S' e payment 'N' (20,00); refaturado, `GET /settlements/
  bills` mostrou a nota nova nascendo com 20 pagos da vida anterior.
- **CRITICAL** cancel × depósito do cheque (`POST /checks/:id/deposit`): `isCheckEventCurrent`
  lia sem lock (snapshot REPEATABLE READ nascia na query dos receipts) → R estornado com B
  vivo; depois do X(B) o cheque voltava a 'custody' e aceitava NOVO depósito (2º crédito
  bancário) — pedidos 6675/6677, cheques 56/58.
- **HIGH** 2ª vida incancelável com cheque (= C2): 409 REVERSAL_NOT_CURRENT vazando de
  outra peça (pedido 6662) e 409 INVOICE_CANCEL_BLOCKED falso com o mesmo cheque
  redigitado (6663); `POST /checks/45/reverse` do R já estornado passava pela D10.
- **HIGH** cancel × emissão de boleto (`POST /bank-slips`): boleto ABERTO sobre título
  'S'; refaturado, a 2ª vida travava (TITLE_HAS_OPEN_SLIP) — pedido 6674.
- **MEDIUM** boleto AGRUPADO com título de outro pedido: cancelar um pedido cancelava (C)
  o boleto inteiro em silêncio — o vizinho ficava 'F' sem cobrança (boleto 19, pedidos
  6660/6661). **MEDIUM** nota de devolução (= H1). **MEDIUM** cancel × abrir devolução
  (`openReturn` lê o status da venda fora da transação — M4). **LOW** lock wait (1205)
  virava 500; D4 gera linhas com o mesmo (modelo, série, número) morta × viva (sem
  UNIQUE — pré-requisito da transmissão/sync inverso); `LAST_INVOICE_EVENT_KIND_SQL` sem
  consumidor; cheque voided listado como 'custody'.
- Causa raiz comum: plano montado com leituras NÃO travantes depois de travar pedido/nota
  — a mesma invariante do billing de 2026-08-24 ("leitura que decide gravação vive na
  transação e SOB LOCK").
- Passou limpo: payloads (400 por campo, 404 sem vazar, 401, INVALID_JSON, injeção
  literal), cancel×cancel×cancel e cancel×faturar (1 vence, 409 nos demais), numeração D4
  (buraco quando não é a última, reuso quando é; E1,C2,E3,C4,E5), D2/D9/D8/Q-P6/Q-P1 e
  leituras pós-cancel.
- **Achado COLATERAL (pré-existente, fora do alvo)**: `POST /billing/invoice` de
  MERCADORIA devolvia **500** — `Unknown column 'f.id'` em `resolveFcpAliq`: o baseline
  (001) já criava `tb_state_mva_ncm`/`tb_state_fcp_ncm` na forma do LEGADO e a migration
  030 era `CREATE TABLE IF NOT EXISTS` (no-op). O dev NUNCA emitiu nota de mercadoria (0
  linhas em tb_order_item_icms) — os gates da Onda 1 de tax-rules rodaram com mocks.

### 9.3 Correções em sessão (2026-09-09) — antes da 2ª rodada

- **C1/CRITICAL 1/HIGH 4**: `buildCancelPlan` trava `tb_financial` do pedido `FOR UPDATE`
  ANTES de qualquer leitura de decisão (mesma ordem da baixa: pedido → título → payment →
  statement) e lê receipts (JOIN tb_check), payments, boletos e devoluções `FOR UPDATE`.
  Smoke: 3 rodadas de cancel × baixa concorrente → sempre 1 vence, o outro 409, nunca
  título 'S' com payment 'N'.
- **C2/HIGH 3/CRITICAL 2**: `isCheckEventCurrent` lê `FOR UPDATE` e devolve `false` quando
  existe X com `origin_event` = alvo; `reverseCheckEvent` usa isso para o alvo e para os
  irmãos (mensagem "já foi estornado ou tem posterior vigente"); o passo 2a do plano
  exclui R já neutralizado (`NOT EXISTS X`). Smoke: mesmo cheque redigitado na 2ª vida e
  cheque diferente → as duas vidas cancelam (nota E1,C2,E3,C4; cheque 1R,2X>1,3R,4X>3);
  estornar o R já estornado → 409 CHECK_ALREADY_MOVED.
- **H1/MEDIUM 6**: nota de DEVOLUÇÃO faturada → 409 INVOICE_NOT_CANCELLABLE (assunção da
  Q-G1; a âncora é lida FOR UPDATE).
- **MEDIUM 5**: boleto aberto AGRUPADO com título de outro pedido → bloqueio `bankSlip`
  (coluna `otherOrders` na consulta; boleto só deste pedido segue cancelado).
- **LOW 8**: `ER_LOCK_WAIT_TIMEOUT` → 409 `RESOURCE_BUSY` (catálogo). **L3**: Swagger.
- **Colateral**: migration `043_state_tax_rates_reshape.sql` — reforma CONDICIONAL
  (MariaDB 10.4, prepared statements, uma instrução por linha) das duas tabelas para a
  forma da 030, preservando linhas (institution = dona do schema, `aliquota`→`aliq`/
  `internal_aliq`, `mva`→`mva_original`); aplicada no dev. LIÇÃO: migration que cria
  tabela que o baseline já tinha em outra forma precisa reformar, não `IF NOT EXISTS`.
  Pendência registrada: smoke real de faturamento de MERCADORIA (W2) — nunca feito.
- Testes: +ordem dos locks, +âncora, +NOT EXISTS, +boleto agrupado, +`isCheckEventCurrent`
  travante/X duas vezes → suíte **675/675**. Docs: M4 e L (voided como 'custody', D4 sem
  UNIQUE, `LAST_INVOICE_EVENT_KIND_SQL` reservado para a listagem de notas) registrados.

### 9.4 Socrático — 2ª rodada: **0.72 APROVOU com pendência** (leitura + EXPLAIN read-only no dev)

- Verificado OK: ordem pedido → nota → âncora → `tb_financial` → receipts → payments →
  boletos → devoluções é a da baixa; `EXPLAIN` confirma `ref/range` pela PK em
  `tb_financial`, `tb_financial_payment`, `tb_order_stock_adjust_return` e o next-key lock
  de `isCheckEventCurrent` (bloqueia INSERT de B/D/P/V no cheque até o commit); cancel ×
  baixa/depósito/P/V/liquidação → quem chega segundo espera e relê o estado real; `NOT
  EXISTS X` cobre cheque redigitado, cheque diferente, grupo com irmão que avançou e
  R→B→X(B); boleto agrupado bloqueia; migration 043 idempotente e correta no runner.
- **H2 (→ Q-G7)**: "payment 'N' ⇔ R vigente" NÃO é invariante — a tela de Baixas estorna
  QUALQUER baixa sem olhar o razão do cheque (`reverseSettlement` → `reverseOnePayment`,
  sem guarda). Operador estorna em Baixas a parcela recebida em cheque → payment 'E',
  cheque com R "vigente" (sem X) → cancelar a nota: nada bloqueia, executa,
  `reverseOnePayment` acha 'E' → 409 REVERSAL_NOT_CURRENT genérico e a nota fica
  INCANCELÁVEL (a tela de Cheques cai no mesmo caminho). Raiz pré-existente (o cheque não
  tem o espelho da D-B1 "título com cheque vigente não baixa/estorna por outro meio"); é
  o cancelamento que a transforma em beco sem saída.
- **M7 (→ Q-G8)**: a leitura dos cheques filtra `tb_check_event` por `tb_order_id` SEM
  índice → o otimizador varre todos os `tb_check` da institution sob FOR UPDATE — um
  cancelamento trava TODO movimento de cheque da institution até o commit.
- **M8 (→ Q-G10)**: duas inversões de lock reais hoje resolvidas por detecção +
  `withDeadlockRetry`: `settleBatchTx` minta `nextSettledCode` (lock institution-wide)
  ANTES de travar `tb_financial`, e o faturamento da devolução trava ajuste → original
  enquanto o cancel trava original → ajuste. Sem teste real que prove o 409 após o
  retry. M4 (cancel × abrir devolução) mantido como registrado. LOW: L6 plano do
  otimizador nos boletos em volume; L7 043 com `@inst` NULL grava 0 em silêncio (sem
  STRICT) e falha entre RENAME e CREATE deixa `_legacy` órfã (nota operacional); L8
  `innodb_lock_wait_timeout` 50 s antes do RESOURCE_BUSY; L9 `getPostedItemCommissions`
  mistura vidas sem ORDER BY.

### Questões da 2ª rodada (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-G7**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Baixa de parcela em cheque: o estorno manual em Baixas passa a RECUSAR o
  payment que é o R vigente de um cheque (409 PAYMENT_HAS_CHECK — "estorne pela tela de
  Cheques", espelho da D-B1) e o plano do cancelamento ganha um 409 legível quando achar
  R vigente cuja baixa já morreu por outro meio (estado herdado)? (rec.: sim aos dois —
  implementado como assunção)
- ~~**Q-G8**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Índices `(tb_institution_id, tb_order_id)` e `(tb_institution_id, settled_code)`
  em `tb_check_event` — migration 044, família do Q-G5? (rec.: sim — é o que faz o lock
  ser do pedido, não da institution; implementado como assunção)
- ~~**Q-G9**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Boleto aberto AGRUPADO com outro pedido bloqueia o cancelamento — exceção à D9
  ("aberto → C automático") — ratificar como decisão? (rec.: manter o bloqueio)
- ~~**Q-G10**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Inversões de lock (baixa/`nextSettledCode`; devolução/original): aceitar
  "retry resolve" agora, com teste real de cobertura, e reordenar `settleBatchTx` (travar
  `tb_financial` antes de mintar o código) na próxima janela do financeiro? (rec.: sim)

### 9.5 Adversarial — 2ª rodada: **0.82 PASSOU** (9 vetores da 1ª rodada reexecutados ao vivo +
vetores novos; 101 pedidos 6686–6786; scripts `s3_new_a`…`s99_cleanup.js` no scratchpad)

- **Vetores 1–9 FECHADOS no dev**: cancel × baixa manual (lock em `tb_financial`, 4×) → baixa
  201 + cancel 409 `title`, nunca título S com payment N; cancel × depósito (lock `tb_check`
  4×, `tb_cashier` 6×, corrida natural 12×) → sempre exclusivo (X(R) com B vivo nunca mais;
  redepósito impossível); 2ª vida com o MESMO cheque (R,X<1,R,X<3) e com cheque diferente
  cancelam; `POST /checks/:id/reverse` do R já estornado → 409 CHECK_ALREADY_MOVED; cancel ×
  emissão de boleto → boleto sai E,C na transação do cancel; boleto agrupado com OUTRO
  pedido → 409 `bankSlip`; cancel×3 / cancel×faturar / refaturar×2 → 1 vence; **mercadoria
  (migration 043)**: fatura 55/6139 com snapshot ICMS + ramo → cancel → refatura reaproveita
  o nº e revive snapshot/ramo, `tb_order_item_tax_rule` intocado; conjugada S+M cancela e
  revive os 2 ramos; payloads (reason 255 com `ç` grava 255, 256 → 400); lock wait → **409
  RESOURCE_BUSY em 50,7 s**.
- **Novos OK**: D16 com caixa fechado → 409 NO_OPEN_CASHIER sem efeito colateral; contrato
  auto-baixa (taxa 2,5 %) → 409 `title`, estorno desfaz crédito + débito da taxa, cancel ok;
  comissão 5 % → +5/−5/+5/−5, saldo por item 0 (Q-P8); nº de parcelas entre vidas 2→1→3
  (parcela 2 fica S e revive; carteira só a viva); 2 parcelas Q → 2 estornos; cancel ×
  liquidar boleto e cancel × estorno manual do R exclusivos sem 500; numeração D4 sob
  concorrência nunca 2 vivas com o mesmo nº; boleto C da vida 1 não bloqueia boleto novo
  na vida 2 (D-B1 mantida); nota de devolução → 409 INVOICE_NOT_CANCELLABLE (Q-G1) e a
  venda → 409 `return`.
- **MEDIUM M4 PROVADO (→ Q-A1)**: cancel × abrir devolução — `openReturn` lê o status 'F' da
  venda FORA da transação e sem lock; segurando o MAX+1 de `tb_order`, devolução 6763 nasceu
  ancorada na venda 6761 já cancelada (order 'A', nota S), itens pré-carregados da vida
  cancelada; a venda refaturada fica bloqueada (`return`) até o DELETE da devolução.
- **MEDIUM (→ Q-A2)**: `buildCancelPlan` decide só pelo último evento e ignora
  `tb_invoice.status` — status 'A' escrito fora da peça (hoje só o sync, Q-G6) é cancelado
  como pendente (linha fica deleted S com status A). Coerente com "status é espelho", sem
  cinto até existirem os eventos T/A.
- **LOW (→ Q-A3)**: `ER_LOCK_WAIT_TIMEOUT` só virou 409 no billing.cancel; `inTx` do módulo
  checks e demais módulos devolvem 500 (provado: depósito sob lock → 500 em 51,0 s).
  **LOW** Q-G3 segue (nota da OS inline: não cancelável e a mensagem mente — "sincronizada").
  **LOW** `requirePrivilege` não checa `tb_institution_has_interface` (usuário regular mantém
  CANCELAR/FATURAR pela API depois de a interface sair do contrato; o app só esconde o botão).
- **COLATERAL HIGH — módulo `order-returns` (fora do alvo, → Q-A4)**: ordem de DEVOLUÇÃO não
  tem quem grave `tb_order_billing` (`PUT /orders/:id/negotiation` → 404 para ordem de ajuste;
  order-returns não expõe negociação) e o billing exige desde a negociação de 2026-09-06 →
  `POST /billing/invoice {adjustment}` → **422 ORDER_NO_BILLING**. Faturar devolução pela
  API está quebrado; passou no gate só com INSERT manual (nota 55/6141). A tela de devoluções
  vai bater nisso — decisão antes do passeio.
- Não testados: 403 PRIVILEGE_REQUIRED com usuário regular real (nenhum no dev); sync
  revivendo nota cancelada (outro grupo, Q-G6); ramo autorizado/SEFAZ; terminal ≠ 0; tela.
  Resíduo de dev: pedidos 6686–6786, devolução 6775 faturada, regras 3/4 soft-deletadas
  referenciadas por `tb_order_item_tax_rule`; fixtures restaurados (forma 3 'C', max_parcels
  1, caixa 5 aberto, aliq_kickback NULL, tb_merchandise 16 removida).

### 9.6 Q-G7 e Q-G8 EXECUTADAS como assunção (2026-09-09) — antes da apresentação ao Valdo

- **Q-G7 (a)**: `reverseSettlement` (Baixas) recusa estornar payment que é o R VIGENTE de um
  cheque — leitura `tb_check_event` FOR UPDATE com `NOT EXISTS X(origin_event = R)` → **409
  PAYMENT_HAS_CHECK** ("estorne pela tela de Cheques"), espelho da D-B1; catálogo de erros.
  **Q-G7 (b)**: o plano lê payments ANTES dos cheques e, para R vigente cuja baixa já morreu
  por outro meio (estado herdado), gera bloqueio `check` legível ("já foi estornada fora da
  tela de Cheques — regularize (suporte)") em vez do REVERSAL_NOT_CURRENT vazando no meio da
  execução. Smoke real: estorno manual → 409 PAYMENT_HAS_CHECK e payment segue 'N'; X pelo
  cheque → estorno manual do payment já 'E' → 409 REVERSAL_NOT_CURRENT; cancel ok. Estado
  herdado forjado (UPDATE status='E') → 409 INVOICE_CANCEL_BLOCKED com a mensagem; após
  regularizar → cancel ok.
- ~~**Q-G8**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4): migration `044_check_event_indexes.sql` (`idx_check_event_order`
  (institution, order) + `idx_check_event_code` (institution, settled_code); `ADD KEY IF NOT
  EXISTS`) aplicada no dev; bloco canônico em `sql/03`.
- Testes: `settlements-reversal-guard.test.ts` (2) + Q-G7 (b) no `invoice-cancel.test.ts`
  (ordem payments→cheques) → suíte **678/678**; tsc limpo.

### Questões da 2ª rodada adversarial (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-A1**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) M4: `openReturn` relê a venda `FOR UPDATE` dentro da transação e recusa
  `status ≠ 'F'` (mesma receita C1)? (rec.: sim — 1 leitura + teste jest proposto)
- ~~**Q-A2**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Cinto do `status`: `buildCancelPlan` recusa `tb_invoice.status ≠ '0'` com 409
  INVOICE_NOT_CANCELLABLE até existirem os eventos T/A? (rec.: sim, 1 linha — o purismo
  "espelho nunca decide" fica para quando o evento A existir)
- ~~**Q-A3**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) `ER_LOCK_WAIT_TIMEOUT → 409 RESOURCE_BUSY` transversal (checks, settlements,
  bank-slips, order-returns) numa peça única em `@shared/db`? (rec.: sim — mesma família do
  `withDeadlockRetry`; lock wait NÃO reexecuta)
- ~~**Q-A4**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Colateral: ordem de devolução sem condições de cobrança — `openReturn` HERDA
  `tb_order_billing` (forma + prazo) da venda original × endpoint próprio de negociação no
  `order-returns`? (rec.: herdar — a devolução é espelho da venda e o valor volta pela mesma
  forma; negociação própria só se um caso real pedir)

## 10. Rodada 2 — DECIDIDA pelo Valdo e EXECUTADA (2026-09-09)

Respostas do Valdo, literais: Q-G1 rec. · Q-G2 rec. · Q-G3 "deve ser cancelável" · Q-G4 rec. ·
Q-G5 rec. · Q-G6 rec. · **Q-G7**: "Contexto: alguém baixa algo que foi pago com cheque. Objetivo:
deixar a baixa acontecer deixando o cheque registrado; o cheque deve ter uma lista de eventos e
uma delas será o cancelamento. Conceito do módulo cheque: rastreabilidade do cheque — quando o
cliente paga com cheque, ele não deve mais a duplicata e sim o cheque. Se precisar conversamos
mais" · **Q-G8** "não deve travar" · **Q-G9** "Sim… neste caso o boleto deve ser cancelado e
desvinculado dos pedidos para torná-los independentes" · Q-G10 sim · Q-A1 sim · Q-A2 sim ·
Q-A3 sim · Q-A4 herdar.

### 10.1 Decisões e execução (698/698 testes, tsc limpo; +20 testes)

- **D-G1** Devolução faturada continua RECUSANDO o cancelamento na Onda 1 (ramo adjust = Onda 2).
- **D-G2** D-G3 do contrato é a regra única de estorno (o X do R herda a sessão de caixa do
  original); D16 é só permissão de quem cancela. Sem código.
- **D-G3 — nota da OS CANCELÁVEL**: `service-orders.generateInvoice` fatura pela MESMA peça da
  venda (`issueInvoice`: model 'SE', série '1', sem ramos → evento E, numeração D4 por
  modelo/série, cabeçalho revivido; ganhou `userId`); financeiro da OS com ON DUPLICATE KEY
  (revive da parcela soft-deletada). Migration **046** põe as notas de OS já existentes no
  mesmo modelo (status 'A' placeholder → '0' + E retroativo "retroativo (OS)"). Cancelar reabre
  a OS: peça NOVA `@shared/service-order` — `findServiceOrderForReopen` (tb_order_service FOR
  UPDATE + trava D5 `open_lock` conferida FOR UPDATE: cliente com OUTRA OS aberta → bloco
  `serviceOrder` no 409 único) e `reopenServiceOrder` (restaura `open_lock`; ER_DUP_ENTRY na
  execução → 409 SERVICE_ORDER_CUSTOMER_OPEN, nunca 500). Ordem de locks do plano: pedido →
  nota → âncora → **tb_order_service** → tb_financial → … (a mesma do faturamento da OS).
- **D-G4** Migration **045**: coluna GERADA `tb_invoice.number_seq` (number numérico; não
  numérico → 0) + índice `(tb_institution_id, model, serie, deleted, number_seq)`;
  `nextInvoiceNumber` faz MAX(number_seq) pelo índice (lock no intervalo modelo/série, não na
  institution). Bloco espelho em `sql/03`.
- **D-G5** Rollout do guard FATURAR/CANCELAR = **tarefa de implantação** (lista em 10.3).
- **D-G6** Registrado como item 6 da Rodada 4 do sync (`Infra-IA/setes-sync/MAPA_INDEXACAO.md`).
- **D-G7 — Baixas estorna baixa com cheque em CASCATA (Valdo divergiu da recomendação)**: a
  guarda de bloqueio PAYMENT_HAS_CHECK da 9.6 MORREU. `reverseSettlement` descobre o R vigente
  do payment por leitura SIMPLES (sem lock — quem trava, na ordem canônica cheque → eventos →
  título, é a peça) e chama `reverseCheckEvent` de `@shared/check`: a baixa é desfeita pela
  própria peça, o cheque ganha X ("cancelamento" na linha do tempo; grupo D9 inteiro; D10 por
  membro) e a resposta da Baixas ganha `checksReversed[]` (`ReverseCheckEventResult.core`
  devolve o núcleo do estorno). Princípio registrado: **portador substitui a dívida** — pagar
  com cheque transfere a dívida do título para o cheque; desfazer a baixa devolve a dívida ao
  título e cancela o R do cheque. O bloco legível do estado herdado (9.6 b) fica no plano.
  **Assunção Q-G7a (aguarda o Valdo)**: cheque que já AVANÇOU (B/D/P vigente) continua
  recusando o estorno pela Baixas — 409 PAYMENT_HAS_CHECK "estorne o movimento do cheque na
  tela de Cheques antes" — porque o depósito/desconto/pagamento é fato do mundo que só a tela
  de Cheques desfaz (D10). Se o Valdo quiser a cascata também aí (X do B + X do R), é uma
  decisão de negócio, não de código.
- **D-G8** "Não deve travar": índices da 044 = lock do pedido, não da institution; EXPLAIN no
  dev fica pendente (banco parado na sessão).
- **D-G9 — boleto agrupado CANCELA e libera os vizinhos**: o bloqueio do gate MORREU; boleto
  aberto agrupado com título de OUTRO pedido recebe C e os títulos vizinhos ficam
  INDEPENDENTES; a resposta lista `releasedTitles[{bankSlipId, orderId, parcel}]` (lidos FOR
  UPDATE) — nada em silêncio. **Assunção Q-G9a**: "desvinculado" = sem boleto VIGENTE (o
  evento C basta — D-B1 só olha boleto vigente); o vínculo `tb_bank_slip_title` fica como
  história do boleto imutável. Soft-deletar o vínculo físico é uma linha, se o Valdo preferir.
- **D-G10** "Retry resolve" aceito com teste de cobertura (`billing-cancel-retry.test.ts`:
  deadlock reexecuta até 3× e comita; lock wait NÃO reexecuta). Reordenar `settleBatchTx`
  (travar tb_financial antes de mintar o código) = pendência da próxima janela do financeiro.
- **D-A1** `openReturn` relê a venda `FOR UPDATE` como PRIMEIRA leitura da transação e recusa
  status ≠ 'F' (422 ORIGIN_NOT_INVOICED) — M4 fechado.
- **D-A2** Cinto do status no plano: `tb_invoice.status ≠ '0'` → 409 INVOICE_NOT_CANCELLABLE
  (3 leituras e para).
- **D-A3** Peça `@shared/db/contention` (`isLockWaitTimeout`, `contentionToHttpError`) aplicada
  no `handleError` e no handler global do app → 409 RESOURCE_BUSY em TODOS os módulos; o
  mapeamento local do billing saiu. Deadlock segue técnico (o retry já reexecutou).
- **D-A4** `openReturn` HERDA `tb_order_billing` da venda (forma + prazo + plots) — faturar
  devolução volta a funcionar pela API; venda legada sem condições → devolução sem (o billing
  avisa ORDER_NO_BILLING).

### 10.2 Pendente desta rodada (banco de dev PARADO na sessão — sem permissão para iniciar)
- `npm run db:migrate` (045, 046) · EXPLAIN do plano dos cheques (D-G8) · smoke: D-G7 cascata
  (custódia → X; depositado → 409), D-G9 (boleto agrupado → C + releasedTitles; vizinho recebe
  boleto novo), D-G3 (OS: faturar → cancelar → OS reaberta → refaturar; 2ª OS aberta do cliente
  → bloco), D-A1/D-A4 (devolução herda cobrança e FATURA pela API), D-A2, D-A3 (depósito sob
  lock → 409) · gate adversarial 3ª rodada (alvo: as peças desta rodada) · passeio logado.

### 10.3 Tarefas de implantação (web) acumuladas
1. `max_parcels` das formas (negociação, D-N1): DEFAULT 1 bloqueia 2+ parcelas até configurar.
2. Privilégios FATURAR (5) e CANCELAR (7) na interface `orders` — e CANCELAR (7) na interface
   `service-orders` (seed 52, D-G16) — para os usuários REGULARES que faturam/cancelam (D-G5):
   sem o vínculo em `tb_user_has_privilege` recebem 403 PRIVILEGE_REQUIRED; admin/super passam.
3. Conferências ANTES das migrations 046 e 047 em cada schema de produção (Q-G14): os SELECTs
   dos cabeçalhos das migrations — 046 só notas 'SE' status 'A' de OS (sem tb_order_sale, sem
   evento); 047 só pedidos da web (origin NULL) sem ramo de venda, e NENHUMA outra linha com
   `open_lock`; conferir também as duplicidades vivas legadas em 55/1 (número × série) antes de
   confiar no MAX(number_seq)+1.
4. **Política do desconto (D-G32, Rodada 6)**: aplicar o **seed 55** em cada base central
   (privilégio DESCONTO id 8 + vínculo com a interface `settlements` + config
   `max_discount_aliquot`). ⚠️ O default é **0 = nenhum desconto sem o privilégio** (fiel ao
   BX-15): no 1º dia, operador REGULAR que hoje dá desconto recebe 403 até a empresa configurar o
   teto OU receber o privilégio 8 em `tb_user_has_privilege` — decidir por cliente ANTES do
   deploy (Q-G37). Sem o seed, a TELA fica mais restritiva que a API até para o admin (o catálogo
   não tem o privilégio → `can('DESCONTO')` false + teto 0), então o seed é pré-requisito do app.
5. **Competência da rotina mensal (D-A29, Rodada 6)**: migration **051** cria
   `tb_contract_item_competence` e faz backfill dos itens de serviço já injetados — o backfill
   carimba o mês em que o item NASCEU, não a competência faturada (Q-A32): em clientes que já
   reexecutaram a rotina retroativamente, conferir/corrigir antes de rodar o próximo mês.
6. **Boleto com desconto (D-G30, Rodada 6)**: a alíquota de desconto da CARTEIRA
   (`tb_bank_charge_agreement.aliq_discount`) passa a QUITAR título — revisar quem pode editar a
   carteira em cada cliente (Q-G36 decide se entra sob o privilégio DESCONTO).

### 10.4 Socrático da Rodada 2 — 1ª passada: **0.58 REPROVOU** (leitura; banco parado)

- **C-1 (→ Q-G11)**: `tb_order_service` é ramo COMPARTILHADO por natureza — a VENDA com item
  de serviço também o cria por presença (`orders.ensureServiceBranch`, open_lock NULL) e o sync
  idem. A peça `findServiceOrderForReopen` tratava QUALQUER pedido com o ramo como OS: cancelar
  a nota de uma venda com serviço (a) bloqueava falsamente se o cliente tinha OS aberta e (b)
  senão gravava `open_lock` na VENDA — a rotina mensal passaria a injetar itens de contrato
  nela. Mocks não enxergam (identidade de domínio).
- **H-1 (→ Q-G12)**: D-G7 cobria só o R; cheque de terceiro USADO no pagamento (P) reabria o
  beco sem saída (payment 'E' com P vigente → cheque preso em 'supplier').
- **M-1 (→ Q-G13)**: inversão REAL de lock entre o plano (tb_financial → payment → cheque, ordem
  imposta pela 9.6 b) e a peça do cheque (cheque → eventos → payment); a porta SEM
  `withDeadlockRetry` era justamente Baixas (vítima → 500 + crashlytics). Mesma classe em D-G9
  (cancel: boleto → títulos vizinhos × settleBatchTx do vizinho: título → boleto).
- **M-2 (→ Q-G14)**: a 046 herdava a premissa de C-1 ('SE' + tb_order_service = nota da OS).
- LOW: L-1 mensagem única do PAYMENT_HAS_CHECK para 3 situações; L-2 `?? '0'` morto; L-3
  herança copia prazo legado não canônico (→ 422 INVALID_DEADLINE sem tela para corrigir) e
  não herda elaborado (→ Q-G15); L-4 caminhos fora do handleError (core/auth/admin, monthlyRun);
  L-5 nível de isolamento nunca fixado na conexão (→ Q-G17); L-6 045 = rebuild COPY da
  tb_invoice no boot; L-7 swagger da OS mentia e OS × venda pura de serviço dividem a sequência
  'SE'/'1' (→ transmissão/RPS). Passou: D-G9 (todo leitor de "título tem boleto" deriva do
  último evento), gap lock da trava D5 em UNIQUE (procede em REPEATABLE READ; openOrder/
  monthlyRun serializam e caem em 409, nunca 500), D-G4 (sintaxe MariaDB 10.4, MAX pelo índice,
  D4 sob concorrência nas duas ordens), D-A1 sem inversão, D-A3/D-G10 coerentes, cadeia PA
  depois do core.

### 10.5 Correções em sessão (2026-09-09) → 704/704

- **C-1**: identidade da OS = `tb_order_service` SEM `tb_order_sale` (NOT EXISTS na peça, sob
  o mesmo FOR UPDATE) — venda com serviço e pedido sincronizado → null; documentado na peça.
- **M-2**: 046 com o mesmo NOT EXISTS nos dois comandos + SELECT de conferência no cabeçalho
  (Q-G14: roda antes de aplicar em produção).
- **H-1**: descoberta em Baixas `kind IN ('R','P')`; mensagem por kind ("feita com" / "paga com").
- **M-1**: `withDeadlockRetry` (3×) em `settleBatch` e `reverseSettlement`; plano do
  cancelamento lê CHEQUES antes das BAIXAS (ordem canônica cheque → baixa = peça do cheque =
  Baixas); o "estado herdado" é decidido por conjunto depois das duas leituras.
- **L-1**: após CHECK_ALREADY_MOVED a Baixas confere se existe X do alvo → "acabou de ser
  estornado pela tela de Cheques — atualize" × "avançou ou irmão avançou". **L-2** removido.
  **L-3/Q-G15 (assunção)**: prazo herdado passa por `normalizeDeadline`; inválido → NÃO herda
  (billing avisa ORDER_NO_BILLING); elaborado não herdado. **L-7**: swagger da OS corrigido.
- Testes: +6 (P em cascata, X do alvo, retry em settleBatch/reverseSettlement, NOT EXISTS
  tb_order_sale, prazo inválido) → **704/704**; tsc limpo.

### Questões da 2ª passada socrática (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-G11**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Identidade da OS no ramo compartilhado: (a) "tb_order_service SEM tb_order_sale"
  (executado como assunção) e (b) o CICLO da OS (open_lock, número) ganha ramo próprio —
  parecer setes-conceito antes da fase de transmissão? (rec.: (a) agora; (b) ao setes-conceito)
- ~~**Q-G12**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Cascata da Baixas também para o P (cheque usado no pagamento)? (rec.: sim —
  executado como assunção)
- ~~**Q-G13**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Retry em settlements agora + ordem canônica cheque → baixa no plano (executados
  como assunção); reordenar `settleBatchTx` (tb_financial antes de mintar o código) fica com
  o Q-G10? (rec.: sim)
- ~~**Q-G14**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) 046 só depois da conferência (SELECT do cabeçalho) em cada schema de produção —
  entra no roteiro de implantação? (rec.: sim)
- ~~**Q-G15**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Herança da devolução: prazo inválido não herda; elaborado não herdado (executado
  como assunção)? (rec.: sim; elaborado fica fora até caso real)
- ~~**Q-G16**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Onde vive o "Cancelar nota" da OS no app e sob qual interface o CANCELAR (hoje
  `POST /billing/cancel` exige `orders`/7 — operador de OS pode não ter a interface orders)?
  (rec.: ação na OS faturada chamando o mesmo POST; guard aceita `service-orders` quando o
  pedido é OS)
- ~~**Q-G17**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Fixar/assertar REPEATABLE READ na conexão do pool e registrar em PADROES_BANCO
  como invariante de todos os gap locks? (rec.: sim — uma linha no boot + regra)
- **Q-G2 reafirmada**: D-G7 abre a terceira porta que grava o X do R sem exigir caixa aberto
  (Baixas, como a tela de Cheques — D-G3), enquanto o cancelamento exige (D16). Coerente com a
  resposta "Q-G2 rec." (D-G3 regra única; D16 = permissão de quem cancela) — confirmar.

### 10.6 Migrations 045/046 aplicadas + smoke da Rodada 2 no dev: **13/13 OK** (2026-09-09)

Banco voltou (MariaDB 10.4.20, REPEATABLE-READ, lock wait 50 s); API e app reiniciados;
`s_rodada2.js` (scratchpad) — pedidos 6791–6802, cheques 105/106, boletos 42/43, OS 6797/6798.
- **045/D-G8**: `number_seq` STORED GENERATED + `idx_invoice_number_seq`; `EXPLAIN` do MAX →
  "Select tables optimized away"; plano dos cheques → `idx_check_event_order` (1 linha — lock
  do pedido, não da institution). **046**: 102 notas de OS vivas → status '0' + E; as 2 notas
  'SE' status 'A' COM `tb_order_sale` (6533/6628 — vendas antigas do dev com ramo de serviço,
  anteriores à 042) ficaram FORA de propósito (identidade C-1) — seguem "cancele na origem".
- **D-G7**: reversal com cheque em custódia → 201 `checksReversed:[105]`, cheque R1,X2>1,
  payment 1E/2R; nota cancela depois sem cheque a estornar. Cheque DEPOSITADO → 409
  PAYMENT_HAS_CHECK (mensagem aponta a tela de Cheques); após o X do depósito a Baixas estorna
  em cascata (R1,B2,X3>2,X4>1).
- **D-G9**: boleto 42 agrupado (P1+P2) → cancel P1 → 200 `bankSlipsCancelled:[42]`,
  `releasedTitles:[{42, P2, 1}]`, eventos E,C; boleto NOVO só do vizinho → 201 (43). Achado do
  smoke: boleto agrupado exige `dtExpiration` (regra do boleto, corpo do script corrigido).
- **D-G3**: OS 6797 → nota SE 6250 status '0' + E → cancel → open_lock '1-209' de volta,
  pedido A, nota S, evento C → refatura (nº 6250 reaproveitado, parcela 2 fica S) → OS2 aberta
  → cancel da OS1 → 409 bloco `serviceOrder` ref 6798 → DELETE OS2 → cancel 200. **C-1**:
  venda com item de serviço (6799) cancelou com OS do cliente aberta e NÃO recebeu open_lock.
  Observado (L-7): a venda pura de serviço reaproveitou o nº 6250 da OS cancelada — OS e venda
  de serviço dividem a sequência 'SE'/'1' (→ transmissão/RPS).
- **D-A4/D-A1**: devolução 6801 nasceu com `tb_order_billing` (6, '030') herdado e FATUROU
  pela API (nota 55/6143) sem fixture; corrida com lock na venda: cancel 200 → abrir devolução
  422 ORIGIN_NOT_INVOICED. **D-A2**: status 'A' → 409 "só nota pendente cancela".
- **D-A3 (transversal)**: depósito de cheque com lock segurado em `tb_check` → **409 RESOURCE_BUSY em
  50,7 s** (módulo checks — antes era 500 + crashlytics).
- Resíduo: OS 6797 reaberta pelo cancel foi FECHADA no fim (DELETE); fixtures restauradas
  (forma 3 'C', max_parcels 1, regra 2, mercadoria 16 removida, regra de entrada 5 excluída).

### 10.7 Socrático da Rodada 2 — re-score: **0.76 PASSOU** (2026-09-09)

- FECHADOS no código e cobertos por teste: C-1 (identidade da OS: venda web sempre nasce com
  `tb_order_sale`; o módulo service-orders nunca o grava), M-2 (046), H-1 (P: nasce com
  orderId/parcel/payment_event/terminal 0 → a descoberta o encontra), M-1 (inversão plano ×
  peça do cheque sumiu; inversões residuais boleto × baixa × cancel cobertas por retry nos DOIS
  lados — cura real = Q-G13 reordenar `settleBatchTx`), L-3, L-2, L-7.
- FICOU e foi corrigido em sessão: **L-1** a conferência do X era leitura NÃO travante — sob
  REPEATABLE READ o snapshot da descoberta não veria o X recém-commitado (mensagem "acabou de
  ser estornado" nunca sairia) → agora `FOR UPDATE` (o cheque já está travado pela peça, mesma
  ordem); comentário defasado da ordem de locks no plano corrigido.
- **N-1 (LOW hoje, MEDIUM latente → Q-G18)**: a premissa "pedido SINCRONIZADO tem
  `tb_order_sale`" é FALSA para o pedido de serviço PURO (o Delphi só manda o bloco `sale` com
  mercadoria). Hoje seguram dois guardas reais: no plano, nota sem evento E → 409 ANTES da
  leitura da OS; na 046, `model = 'SE'` (a NFS-e sincronizada viaja sem model). No dia em que
  D-G6 (sync grava tb_invoice_event) entrar, o pedido sincronizado passa o gate e o
  cancelamento gravaria `open_lock` nele. Docs da peça e da 046 passaram a citar os guardas
  reais.
- Dica arquitetural registrada: identidade de domínio ancorada em AUSÊNCIA de ramo é frágil
  por construção — o CICLO da OS precisa de ramo próprio (Q-G11 b).
- ~~**Q-G18**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Antes de D-G6, a identidade da OS precisa de âncora que o sync NUNCA produz —
  acelerar Q-G11 b (ramo próprio do ciclo da OS via setes-conceito)? (rec.: sim, antes da fase
  de transmissão; paliativo = teste que simule pedido sincronizado sem `tb_order_sale`)

### 10.8 Adversarial — 3ª rodada (alvo = Rodada 2): **0.62 REPROVOU** → HIGH e MEDIUM corrigidos em sessão e re-provados (2026-09-09)

- **HIGH (→ Q-A5, EXECUTADA)**: o módulo `service-orders` NÃO tinha `withDeadlockRetry` e os
  locks novos da rodada (gap lock da trava D5 no plano; MAX(number_seq) FOR UPDATE na
  sequência 'SE'/'1') deadlockavam com ele → **500** (cancel da nota da OS × abrir OS: 1/3;
  cancel da ÚLTIMA nota SE × faturar OS: 4/4 — refs L5RFVXJN, DLBXTG2F, XABN9WNB, R2STXMK6,
  J9YC2JEM). A afirmação "openOrder/monthlyRun serializam e caem em 409" (10.4) era FALSA: o
  UPDATE do reopen entra na fila atrás do INSERT que espera o gap → ciclo. Correção: retry nas
  três portas (`openOrder`, `generateInvoice`, transação por cliente do `monthlyRun` — com
  contadores só depois do commit) + ER_DUP_ENTRY em `createOpenOrder` → 409 ORDER_OPEN_EXISTS.
  **Re-prova** (`s_races.js`): 4 corridas cancel × abrir OS (200/409 alternando, ≤ 1 OS aberta)
  + 4 corridas cancel da última SE × faturar OS (nº 6265 sempre único) → **8/8, zero 500, zero
  linha no crashlytics**.
- **MEDIUM (→ Q-A6, EXECUTADA)**: cancel × Baixas no MESMO cheque — quando a Baixas vencia, o
  plano respondia 409 "cheque já avançou" (o NOT EXISTS X da leitura dos recibos é CONSISTENTE,
  snapshot de antes de esperar o lock; `isCheckEventCurrent` travante via o X). Correção: em
  `!current` o plano confere o X do alvo com leitura TRAVANTE — existe → nada a estornar (pula;
  o título segue pelo passo 2b); senão avançou de verdade. Mensagem da Baixas (L-1) passou a
  "estornado por outra operação (tela de Cheques ou cancelamento da nota)".
- Passou: D-G7 3 corridas cancel × Baixas (1 vence, nunca 500, cheque R,X + payment E);
  Baixas × tela de Cheques no mesmo R; grupo de 2 cheques (ambos revertidos; irmão depositado →
  409 e NADA gravado); **cascata do P** (cheque de terceiro no título a pagar 6801/1: R,P,X>P;
  depois X do R); D-G9 3 corridas cancel × liquidar × baixa manual (C xor L, nunca 500) + vizinho
  baixa/boleto novo; D-G3 C-1 (venda com serviço 2× sem open_lock com OS aberta), refaturar
  3→1→2 parcelas (E,C,E,C,E); D-A1/D-A4 (prazo '30 DDL' → devolução sem cobrança; elaborado não
  herdado; corrida com lock → nunca âncora em venda 'A'); D-A3 settlements 50,8 s e order-returns
  51,7 s → 409; 045 (3 vendas + 1 OS simultâneas → 6262–6265 sem colisão; `number='ABC'` →
  number_seq 0); 046 (6533/6628 intocadas); payloads (404/400 corretos); **Q-G2 confirmada**:
  caixa fechado → cancel com cheque 409 NO_OPEN_CASHIER, Baixas em cascata 201 herdando a
  sessão original (3ª porta, coerente com D-G3).
- **Fora do alvo (pré-existentes, → Q-A7/Q-A8)**: baixa manual SEM teto de saldo (título
  quitado aceita 2ª baixa: 6874 com 200 pagos em 100; vizinho 6822 boleto L + manual = 200/100);
  `POST /billing/validate` devolve 200 limpo para ordem SEM tb_order_billing e o invoice dá 422.
- Observações: OS e venda pura de serviço dividem a sequência 'SE'/'1' (6262/6263 consecutivos
  → Q-A9); dev tem ~200 duplicidades VIVAS legadas em 55/1 (ids ≤ 6531) — entra na conferência
  do Q-G14 antes de produção.
- Resíduo: pedidos 6805–6883; 6822/6874 com 2 baixas vivas (evidência Q-A7); boletos 44–48;
  **caixa 5 FECHADO pelo teste e caixa 6 aberto**; refs de crash listadas (todas anteriores à
  correção). Fixtures restauradas (forma 3 'C', max_parcels 1, regra 2, regras de entrada
  6/7/8 excluídas, nenhuma OS aberta do 209). Testes: +5 → **709/709**.

### Questões da 3ª rodada adversarial (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-A5**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Retry + ER_DUP_ENTRY → 409 no módulo service-orders (executado como assunção — fecha
  o HIGH)? (rec.: sim)
- ~~**Q-A6**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Leitura que DECIDE mensagem/bloqueio vira travante (executado no plano e na Baixas);
  registrar em PADROES_BANCO junto ao Q-G17? (rec.: sim)
- ~~**Q-A7**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) (fora do alvo) Baixa manual acima do saldo é aceita hoje — nasce teto = saldo +
  juros/multa informados (409 TITLE_EXCEEDS_BALANCE)? (rec.: teto)
- ~~**Q-A8**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) (fora do alvo) `POST /billing/validate` passa a acusar ORDER_NO_BILLING como issue
  para venda e devolução? (rec.: sim)
- ~~**Q-A9**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Sequência 'SE'/'1' compartilhada entre OS e venda pura de serviço: fica até a
  transmissão/RPS ou a OS ganha série própria já? (rec.: decidir antes da fase de transmissão,
  junto com Q-G11 b)

## 10.9 Rodada 3 — DECIDIDA pelo Valdo e EXECUTADA (2026-09-09)

Respostas literais: Q-G7a "considere: cheque que já transitou não pode interferir no
cancelamento — em geral não pode interferir em momento algum" · Q-G9a "preciso de mais
explicações" · Q-G11/Q-G18 "concordo... ramo próprio" · Q-G12, Q-G13, Q-G15, Q-A5, Q-A6 ok ·
Q-G14 ok · Q-G16 "no documento faturado" · Q-G17 ok · Q-A7 ok · Q-A8 ok · Q-A9 ok.

### 10.9.1 Decisões e execução (715/715 api · 31/31 app, analyze limpo)

- **D-G7a — cheque que TRANSITOU não interfere em momento algum.** Baixas: `reverseSettlement`
  usa a peça NOVA `reversePaymentWithChecks` (`@shared/check`): desfaz a baixa UMA vez; cada
  cheque do grupo em custódia ganha X do seu R/P (`checksReversed`); o que já transitou fica
  como está (`checksKept`) — nunca 409 por cheque. PAYMENT_HAS_CHECK saiu do catálogo. Plano do
  cancelamento: só estorna o R cujo GRUPO está inteiro em custódia e cuja baixa está viva; grupo
  com membro que transitou → a BAIXA é que bloqueia (D2), pelo título, com a causa ("está baixado
  com cheque que já transitou (N) — estorne a baixa na tela de Baixas antes"); R em custódia com
  baixa morta (legado) → nada a estornar, sem bloqueio. `reverseCheckEvent` (tela de Cheques)
  continua exigindo o grupo em custódia (D10 — estorna um EVENTO do cheque, regra do módulo).
  Smoke: custódia → cascata; depositado → baixa estornada e cheque mantido.
- **D-G9a — explicação (sem código)**: ver 10.9.2.
- **D-G11 — ramo próprio do CICLO da OS (parecer setes-conceito, migration 047)**: tabela
  `tb_service_order` (id/institution/terminal = PK compartilhada; `number` nº da OS com UNIQUE
  (institution, number) = índice do MAX+1; `open_lock` trava D5 UNIQUE; FK → `tb_order_service`
  — herança Order → OrderService → ServiceOrder). `tb_order_service` volta a ser NATUREZA por
  presença (tomador; `number` = nº de origem só do sync). Carga: `tb_order.origin IS NULL ∧ sem
  tb_order_sale` (a web nunca grava origin; o sync sempre) — no dev moveu as 39 OS canceladas
  (não há OS viva no dev; as 117 notas 'SE' vivas são vendas de serviço — a 046 não moveu nada);
  `number`/`open_lock` das movidas e o nº cunhado das vendas web → NULL; UNIQUE antiga
  `uk_open_per_customer` dropada. Consumidores: `service-orders.repository` (lista/detalhe
  partem do ciclo; `lockOpenOrder` exige o ciclo — fecha o VAZAMENTO apontado pelo parecer:
  venda aberta com item de serviço era alcançada por DELETE/itens/faturar do módulo de OS;
  abrir OS = 3 INSERTs; OS aberta do cliente = `open_lock = ?` no UNIQUE do ciclo; cancelar
  soft-deleta os três), `@shared/service-order` (identidade = existência do ciclo; morreu o
  "NOT EXISTS tb_order_sale"; N-1/Q-G18 fechado por construção — o sync NUNCA grava o ciclo),
  `orders.ensureServiceBranch` (só o tomador). Assunções do parecer executadas: **Q-C1** nome
  `tb_service_order`; **Q-C2** FK ao `tb_order_service`; **Q-C3** identidade da carga com
  conferência no cabeçalho da 047; **Q-C4** a COLUNA `open_lock` FICA na natureza (o setes-sync
  ainda a grava — regra dos dois grupos: nada do sync se toca daqui) — migration futura dropa
  depois do deploy do sync (item da Rodada 4 do sync). Smoke 12/12: vazamento fechado (venda →
  404 no módulo de OS), OS nasce com ciclo + natureza só com o tomador, trava D5 no ciclo,
  faturar solta, lista/detalhe do ciclo, cancelar a nota devolve a trava, refatura, DELETE.
- **D-G16 — "Cancelar nota" da OS no DOCUMENTO FATURADO**: app: ação no AppBar da OS faturada
  (`CurrentInterface.can('CANCELAR')`), dialog PROMOVIDO a `app/shared/billing/cancel_invoice_dialog`
  (venda e OS usam o mesmo; chaves `forms.billing.*`), usecase/datasource/bloc no módulo
  service_orders (`POST /api/billing/cancel` — endpoint de processo compartilhado), 409
  INVOICE_CANCEL_BLOCKED lista as pendências; sucesso → aba Abertas. API: guard aceita LISTA de
  interfaces — `requirePrivilege(['orders', 'service-orders'], CANCELAR)`; seed `sql/52` (CANCELAR
  na interface service-orders, id 20) aplicado no dev.
- **D-G17 — REPEATABLE READ fixado**: `pool.on('connection')` → `SET SESSION TRANSACTION
  ISOLATION LEVEL REPEATABLE READ`; `assertIsolationLevel()` no boot (server.ts) — derruba a
  subida se o nível não for RR. PADROES_BANCO §9 (Q-A6 + Q-G17 + ordem canônica de locks +
  retry + MAX+1 pelo índice + contadores pós-commit).
- **D-A7 — teto da baixa manual**: `settleBatchTx` recusa `paidValue` > saldo em aberto do
  título (principal das baixas vivas) + juros/multa INFORMADOS → 409 TITLE_EXCEEDS_BALANCE
  (leitura travante das baixas vivas). **D-A8**: `POST /billing/validate` acusa ordem sem
  `tb_order_billing` como issue `order/billing` (venda e devolução). **D-A9**: sequência 'SE'/'1'
  compartilhada entre OS e venda pura de serviço fica até a fase de transmissão/RPS
  (decidir série própria junto com a numeração da NFS-e).
- **Q-G12/Q-G13/Q-G15/Q-A5/Q-A6** ratificadas (já executadas). **Q-G14** conferência da 046 e
  da 047 no roteiro de implantação (10.3).
- Testes: +3 → **715/715**; app **31/31**. Docs: PADROES_BANCO §9, guardiao-conceitual
  (inventário: natureza por presença × processo por ato), MAPA_INDEXACAO (invariante "sync
  nunca grava tb_service_order" + coluna open_lock a dropar), prompt do Software House (§6.1
  superada pela 047).

### 10.9.2 Q-G9a — o que "desvinculado" significa no modelo (para o Valdo decidir)

O boleto AGRUPADO cobre N títulos; a composição vive em `tb_bank_slip_title` (1 linha por
título) e o boleto é IMUTÁVEL — o estado dele deriva do ÚLTIMO evento (E emitido, L liquidado,
C cancelado, X estorno). Cancelar a nota do pedido A cancela o boleto (evento C). A partir daí
NENHUM leitor considera o título do vizinho B "com boleto": a D-B1 (título com boleto VIGENTE
não baixa por outro meio) só olha boleto cujo último evento não é L/C; o lookup de títulos
abertos para boleto novo exclui L/C; o próprio plano do cancelamento ignora boleto cancelado.
Provado no smoke e no adversarial: depois do C, o vizinho recebeu boleto novo (201) e baixa
manual (201). Ou seja, o vizinho está INDEPENDENTE sem apagar nada — o vínculo
`tb_bank_slip_title` permanece como HISTÓRIA do boleto cancelado ("o boleto 42 cobria os títulos
A/1 e B/1"), e a resposta do cancel lista os títulos liberados (`releasedTitles`). A alternativa
"desvincular fisicamente" (soft-delete das linhas de `tb_bank_slip_title` dos outros pedidos)
deixaria o boleto cancelado com composição incompleta (valor 200 com um título de 100) e não
muda nada no comportamento do vizinho. Recomendação: manter como está. Se o Valdo quiser o
vínculo físico soft-deletado, é uma linha na execução do plano.

### 10.9.3 Pendente
- Gates da Rodada 3 (socrático + adversarial) sobre as peças novas: `reversePaymentWithChecks`,
  plano D-G7a, teto da baixa, validate/billing, guard por lista, isolamento, migration 047 +
  módulo service-orders/ciclo, app OS "Cancelar nota".
- Passeio logado: "Cancelar nota" na venda e na OS faturada (Valdo logado, Chrome visível).
- Sync (projeto próprio): parar de gravar `tb_order_service.open_lock`; depois migration que
  dropa a coluna (Q-C4).

### 10.10 Socrático da Rodada 3 — 1ª passada: **0.66 REPROVOU** → H1/H2/L1/L4 corrigidos em sessão (718/718)

- **H1 (corrigido)**: o teto D-A7 quebrava a liquidação de boleto AGRUPADO acima da face — o
  rateio (`bank-slip.ts`) espalhava o valor recebido proporcionalmente e mandava a sobra como
  juros só no ÚLTIMO título; o 1º recebia 105 com juros 0 contra saldo 100 → 409 e a liquidação
  inteira caía. Agora: principal = FACE de cada título, sobra rateada como juros na mesma
  proporção (resíduo no último) — cada título passa no teto. Live: boleto agrupado (100+100)
  liquidado por 210 → 201, payments 105/105 com juros 5/5; 2ª baixa no título quitado → 409.
- **H2 (corrigido)**: a cadeia PA do estorno (`reverseSettlement` → baixas vivas dos títulos a
  pagar dos parceiros) chamava `reverseOnePayment` direto — PA pago com cheque de terceiro
  (evento P) ficava com P vigente sobre baixa morta (sem saída na tela de Cheques). Agora a
  cadeia usa `reversePaymentWithChecks` (D-G7a em TODAS as portas); `checksReversed`/`checksKept`
  da resposta somam os da cadeia. Teste unitário.
- **L1 (corrigido)**: teto sem cobertura → testes (2ª baixa em quitado → 409 e nada gravado;
  parcial 60 + 45 com juros 5 passa, 46 não; boleto agrupado com juros rateados).
- **L4 (corrigido)**: deadlock que CHEGA à borda (retry esgotado ou porta sem retry) agora é
  409 RESOURCE_BUSY como o lock wait (`@shared/db/contention` — 1213 e 1205); erro técnico de
  verdade segue 500 com ref.
- **M2 (mensagem corrigida)**: irmão do grupo que transitou → a tela de Cheques diz que o
  estorno de EVENTO exige o grupo em custódia e aponta a tela de Baixas para desfazer a BAIXA.
- **L5 (doc)**: conferência da 047 ganhou `number IS NULL` e duplicidade (institution, number);
  o dev moveu 39 ciclos (não 27 — os smokes criaram OS entre a contagem e a migration).
- Passou: peça D-G7a (ordem cheque → eventos → payment nas três portas; EXPLAIN pelo
  `idx_check_event_order`), plano (4 casos), D-A8, D-G16 (super/admin, cache, seed 52, dialog
  promovido, anti-duplo-clique, `CurrentInterface` = 'service-orders' vindo do menu), D-G17
  (mysql2 emite 'connection' de forma síncrona antes de entregar a conexão → o SET entra na fila
  antes da 1ª query; erro no SET derruba a conexão do pool, não some), 047 (runner, ordem,
  idempotência, EXPLAIN do `open_lock = const` e do MAX pelo `uk_service_order_number`,
  nenhum leitor de `tb_order_service.number/open_lock` sobrou na api/app; sync continua
  gravando `open_lock` NULL sem a UNIQUE — funciona).
- Pontos socráticos abertos (viram Q-G19…Q-G24): cheque mantido que VOLTA sem fundos depois
  da nota cancelada; R/P vigente com baixa morta preso na identidade; TRÊS fórmulas de saldo
  em aberto e nenhuma subtrai desconto; guard por lista mais frouxa que "interface do RAMO";
  FATURAR/DELETE da OS sem privilégio; `/api/billing/*` como exceção nomeada da arquitetura.

### Questões da Rodada 3 socrática (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-G19**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Cheque MANTIDO (transitou) de nota cancelada que VOLTA sem fundos (V): hoje `returnCheck`
  lê o título de origem com `deleted='N'` → 409 CHECK_NO_ORIGIN. (a) V lê o título mesmo
  `deleted='S'` (só precisa da forma de pagamento; o título novo nasce contra o cliente de
  origem) ou (b) cancelamento bloqueia quando há cheque mantido? (rec.: (a) — "não interfere em
  momento algum" nos dois sentidos)
- ~~**Q-G20**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) R/P vigente cuja baixa já morreu (cheque voltou à custódia por X do depósito depois
  de a Baixas ter estornado): permitir o X pela tela de Cheques SEM tocar a baixa (a peça
  detecta payment ≠ 'N' e grava só o X, liberando a identidade)? (rec.: sim)
- ~~**Q-G21**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) UM saldo em aberto do título como peça única (lista, teto, cheque em pagamento,
  boleto): `tag − Σ(principal pago) − Σ(desconto)` — baixa com desconto QUITA o título (hoje
  três fórmulas e nenhuma subtrai o desconto; título "quitado com desconto" segue em Abertos)?
  (rec.: sim, peça única com leitura travante)
- ~~**Q-G22**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) CANCELAR "em qualquer das duas interfaces" (como está) ou resolver o RAMO do pedido
  no serviço (OS → `service-orders`, senão `orders`) e exigir o privilégio da interface certa?
  (rec.: resolver o ramo — fiel à decisão "interface do RAMO")
- ~~**Q-G23**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) FATURAR em `POST /service-orders/:id/invoice` (e privilégio no DELETE da OS aberta)?
  (rec.: FATURAR na rota de faturar — seed companheiro do 52)
- ~~**Q-G24**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) Ratificar `/api/billing/validate|invoice|cancel` como EXCEÇÃO nomeada ("endpoint de
  PROCESSO compartilhado") à regra "módulo fala só com /api/<m>" em ARQUITETURA_MODULOS.md —
  orders, order_returns e service_orders já dependem disso? (rec.: sim)
- Observação (L2, UX): `CurrentInterface.can()` devolve true sem valor — F5/deep link em
  /home/service-orders mostra "Cancelar nota" a quem não tem; a API responde 403.

### 10.11 Adversarial da Rodada 3 — 1ª rodada: **0.55 REPROVOU** (3 HIGH no alvo) → corrigidos e re-provados (722/722)

- **HIGH 1 — boleto agrupado acima da face** (= H1 socrático, Q-A10): já corrigido em 10.10
  (sobra rateada como juros proporcional). Re-prova ao vivo: 210 em face 200 → 201, 105/105
  com juros 5/5.
- **HIGH 2 — OS alcançada pelo billing de VENDA (Q-A11, corrigido)**: OS faturada pelo módulo →
  cancel (a `tb_order_billing` fica, por decisão D5) → `POST /billing/validate` 200 (branch
  'service', gravava vínculo de regra nos itens) → `POST /billing/invoice` 201 → OS 'F' com a
  trava D5 PRESA (o billing não conhece o ciclo) e o cliente sem poder abrir OS nova.
  Correção: `hasServiceOrderCycle` (`@shared/service-order`) — ordem com CICLO vivo → **409
  SERVICE_ORDER_OWN_ENDPOINT** no validate e no invoice; a OS fatura só por
  `/service-orders/:id/invoice`. Live: 409 nos dois.
- **HIGH 3 — deadlock estrutural do MAX+1 (Q-A12, corrigido como (b) + orders)**: 6 aberturas de
  OS de clientes DIFERENTES em paralelo → 47 % de 500 (refs RN69TN2J, DQJBTYXL…); `POST /orders`
  (venda, FORA do alvo) → 50 % com 2 concorrentes. Causa: `SELECT MAX(...) FOR UPDATE` em índice
  secundário deixa gap lock no supremum e gap locks são COMPATÍVEIS entre si → N transações
  passam do MAX juntas e deadlockam no INSERT; o retry de 3× não segura. Correção: peça
  `@shared/db/counters.lockInstitutionCounters` (X de UMA linha — `setes_central.tb_institution`
  — como PRIMEIRO lock da transação de quem cunha), usada em `service-orders.openOrder`,
  na transação por cliente do `monthlyRun` e em `orders.openOrder` (que também ganhou
  `withDeadlockRetry`). Regra 7 do PADROES_BANCO §9. Live: 3 rodadas × 6 OS concorrentes de
  clientes diferentes → 6×201 e números únicos; 3 rodadas × 6 vendas → 6×201; crashlytics 0.
- **MEDIUM item da OS (Q-A17, kind corrigido)**: `POST /service-orders/:id/items` aceitava
  mercadoria (kind M) → nota 'SE' com mercadoria. Agora 422 SERVICE_ORDER_ITEM_NOT_SERVICE
  (o lookup só oferece kind 'S'). `unitValue = 0` fica para o Valdo (cortesia existe?).
- **LOW juros > pago (Q-A16, corrigido)**: `settleBatchDto` recusa `interestValue + lateValue >
  paidValue` (400) — antes o principal ficava NEGATIVO e inflava o teto (110 recebidos em 100).
- MEDIUM que dependem de decisão (já abertas no 10.10): desconto no teto/saldo (Q-A13 = Q-G21),
  cheque depositado de nota cancelada órfão — V exige título de origem vivo e X do R cai na
  mensagem da Baixas (Q-A14 = Q-G19/Q-G20), guard por lista mais frouxa que "interface do
  RAMO" (Q-A15 = Q-G22).
- Passou: D-G7a (cheque depositado: baixa estornada + kept, nada mais gravado; grupo misto;
  cancel com baixa viva → 409 `title` citando o cheque; corridas Baixas × Cheques × cancel sem
  500), teto (quitado → 409 e NADA gravado; parcial; juros/multa; lote com 2º estourando → rollback
  total; corrida 2 baixas → 1), D-A8 (venda e devolução), D-G16 (admin), D-G17 (RR global e
  sessão), 047 (abrir × abrir mesmo cliente; nº único; listas só do ciclo; DELETE some;
  sincronizado 6531 fora do módulo e 409 "sincronizada" no cancel; venda com serviço → natureza
  sem nº/trava e 404 no módulo; monthly-run × abrir → 200/409, idempotente), payloads.
- Não testado: 403 do guard por lista com usuário regular (dev só tem admin/super); isolamento
  das conexões do pool (só global/sessão observáveis); monthly-run com 2+ contratos; cheque
  descontado/pago a terceiro de nota cancelada; 047 sobre base com OS ABERTA legada; app.
- Resíduo: pedidos 6913–7031; 6925 (5+105) e 6926 (90+10) = evidência Q-A13; cheque 123 órfão em
  'bank' (+70 na conta 1 sem título) = evidência Q-A14; boletos 49/50/51 L; crashlytics 30–47 +
  ≈19 linhas das corridas (todas anteriores à correção). Fixtures restauradas (forma 3 'C',
  max_parcels 1, regra 2, regras de entrada excluídas, contrato 1 soft-deletado, nenhuma OS
  aberta; mercadoria 16 mantida como fixture permanente; caixa 6 aberto).

### Questões consolidadas da Rodada 3 (socrático + adversarial — aguardam o Valdo)
- **Q-G19 / Q-A14** cheque MANTIDO (transitou) de nota cancelada: V (volta sem fundos) lê o título
  de origem mesmo soft-deletado e gera o título CH contra o cliente de origem; X do R órfão com
  mensagem do cheque (não da Baixas)? (rec.: sim aos dois — "a dívida é do cheque")
- ~~**Q-G20**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) R/P vigente cuja baixa já morreu: X pela tela de Cheques SEM tocar a baixa? (rec.: sim)
- **Q-G21 / Q-A13** UM saldo em aberto do título (peça única, leitura travante) que SUBTRAI o
  desconto — baixa com desconto QUITA; teto = saldo + juros/multa informados? (rec.: sim)
- **Q-G22 / Q-A15** CANCELAR pelo RAMO do pedido (ciclo → `service-orders`, senão `orders`) em vez
  de "qualquer das duas interfaces"? (rec.: pelo ramo)
- ~~**Q-G23**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) FATURAR em `POST /service-orders/:id/invoice` (+ privilégio no DELETE da OS aberta)?
  (rec.: FATURAR na rota de faturar, seed companheiro do 52)
- ~~**Q-G24**~~ (DECIDIDA e EXECUTADA nas Rodadas 1–4) `/api/billing/validate|invoice|cancel` = exceção nomeada "endpoint de PROCESSO
  compartilhado" em ARQUITETURA_MODULOS.md? (rec.: sim)
- ~~**Q-A17b**~~ (DECIDIDA e EXECUTADA na Rodada 4) `unitValue = 0` em item de OS: cortesia permitida ou 422? (rec.: 422 — sem caso real)
- Executadas como assunção (só ratificar): Q-A10 (rateio proporcional), Q-A11 (409 próprio),
  Q-A12 (lock da institution + retry em orders), Q-A16 (DTO), Q-A17 (kind 'S').

## 10.12 Rodada 4 — Q-G19 a Q-G24 e Q-A17b "Rec." (Valdo 2026-09-09) — EXECUTADA; re-score socrático da Rodada 3: **0.77 PASSOU**

### 10.12.1 Re-score socrático (0.77) — o que fechou e o que trouxe
- H1/H2/L1/L4/M2/L5 + HIGH 2/3 da adversarial conferidos no código, testes e banco (crashlytics 0
  depois da correção; 18 vendas no mesmo segundo com 18 números; EXPLAIN dos contadores
  "optimized away"; custo do lock da institution aceitável — X de 1 linha na transação mais curta).
- **N1 (→ Q-G25, executada)**: MAX(number) de `tb_order_sale` e MAX(id) de `tb_bank_slip` sem
  índice com o prefixo do WHERE — sob o lock da institution viravam scan-sob-lock-global. Migration
  **048** (`idx_order_sale_number`, `idx_bank_slip_counter`); EXPLAIN "optimized away" nos dois.
- **N2 (executada)**: `order-returns.openReturn` cunhava 2 MAX+1 sem `lockInstitutionCounters` nem
  retry — irmão do HIGH 3. Agora lock da institution como 1º lock + `withDeadlockRetry`.
- N3 (aceito): cunhadores de `tb_order.id` fora da abertura (ordem PA, título CH) ficam no retry —
  não podem tomar o lock da institution no meio (inversão, regra 7).

### 10.12.2 Decisões e execução (728/728 api · app analyze limpo)
- **D-G19** cheque MANTIDO (transitou) de nota cancelada que volta sem fundos: `returnCheck` lê o
  título de origem mesmo soft-deletado (só precisa da forma de pagamento) — o título CH nasce
  contra o cliente de origem ("a dívida é do cheque").
- **D-G20** R/P vigente cuja baixa já morreu (Baixas D-G7a → X do depósito → custódia): a tela de
  Cheques grava o X SEM tocar a baixa (leitura travante do payment; `settled_code` NULL e nota
  "baixa já estornada por outra porta") — identidade liberada.
- **D-G21** saldo em aberto = PEÇA ÚNICA `@shared/financial-settlement/title-balance`
  (`PRINCIPAL_PAID_SQL`/`OPEN_BALANCE_SQL` p/ lista e cheque em pagamento; `getPrincipalPaidTx` +
  `settlementCeiling` p/ o teto): principal coberto = paid − juros − multa + desconto (tag ×
  aliq/100); baixa com desconto QUITA; teto = saldo − desconto DESTA baixa + juros/multa.
- **D-G22** CANCELAR pelo RAMO: `requirePrivilegeFor(privilégio, resolver)` — `POST /billing/cancel`
  resolve a interface por requisição (ciclo de OS vivo → `service-orders`, senão `orders`).
- **D-G23** FATURAR em `POST /service-orders/:id/invoice` (seed **53**: FATURAR na interface
  `service-orders`); app: botão "Gerar faturamento" da OS gated por `CurrentInterface.can('FATURAR')`.
- **D-G24** exceção nomeada em `Infra-IA/setes-app/ARQUITETURA_MODULOS.md`: `/api/billing/validate|
  invoice|cancel` = endpoint de PROCESSO compartilhado (orders, order_returns, service_orders).
- **D-A17b** item de OS com `unitValue` 0 → 422 SERVICE_ORDER_ITEM_VALUE_REQUIRED (add e update).
- Testes: +6 → **728/728** (title-balance, desconto quita, Q-G20, guard por ramo, valor 0, N2).

### 10.12.3 Tarefas de implantação (acréscimo à 10.3)
4. Seed 53 (FATURAR na interface `service-orders`) junto com o 52; migration 048 (índices) é
   automática no boot.

### 10.13 Re-prova adversarial da Rodada 3: **0.62** (2 HIGH novos) → corrigidos e re-provados (731/731 api · app 31/31)

- Passou na re-prova: boleto agrupado acima da face 38/38 (2 e 3 títulos, valores desiguais,
  statement = recebido); OS pelo billing 24/24 (409 nos dois caminhos; OS morta por DELETE → 404 —
  tb_order vai junto; vazamento INVERSO orders → OS também fechado); concorrência 24/24 nas
  aberturas (3×6 e 3×10 OS de clientes diferentes, 3×6 e 3×10 vendas, mistura OS + vendas +
  faturamentos; 4–6 faturamentos SE deadlockam no índice da numeração e o retry segura 10/10);
  lock da institution: 10 sequenciais 35 ms, 10 paralelas serializam em 328 ms, KILL do detentor
  não deixa transação presa; lock wait à borda → 409; DTO (juros > pago 400; lote com 2º
  violando → 400 e nada gravado).
- **HIGH (Q-A20, corrigido)**: `PUT /service-orders/:id/items/:itemId` aceitava QUALQUER
  productId (inexistente, soft-deletado, inativo, mercadoria) e a OS faturava nota 'SE' com
  item de mercadoria/fantasma. Correção: guarda ÚNICA `assertServiceProduct` (existe + ativo +
  kind 'S') no POST e no PUT; **cinto no faturamento** (item com produto inexistente/inativo/
  mercadoria → 422 antes da nota). LOW "serviço inativo por id" fechado junto.
- **HIGH (Q-A18, corrigido)**: regra 7 não aplicada ao contador `settled_code` — 6/18 baixas
  concorrentes de títulos DIFERENTES viravam 409 RESOURCE_BUSY (deadlock de gap locks do
  MAX+1; retry não segura). Correção: `lockInstitutionCounters` DENTRO de `nextSettledCode`
  (fonte única de todo movimento — baixa, estorno, cheque, boleto, auto-baixa do faturamento):
  forma (b) da regra 7 no PADROES §9 — o X da institution é tomado no cunhador, e quem já
  travou título/cheque/pedido aceita o retry contra as portas que travam a institution
  primeiro. Live: 3×6 baixas concorrentes de títulos diferentes → 6×201 com códigos únicos; mistura 3 baixas + 2 faturamentos + abrir OS → 6×201; Rodada 4 8/8 (V de cheque mantido gera CH, X do R órfão, desconto quita + 2ª baixa 409, valor 0 → 422, FATURAR na OS, 6 devoluções concorrentes sem 500); crashlytics 0.
- **LOW (Q-A19 + arredondamento, corrigidos)**: DTO da baixa compara em 2 casas e exige
  principal > 0 (juros + multa < pago) — "recebimento só de encargos" não existe na casa.
- Não testado: PUT/DELETE de item de OS FATURADA (só lockOpenOrder); monthly-run com 2+
  contratos concorrentes (rate limit 300/min); cadeia PA com cheque de terceiro ao vivo (só
  unitário); 403 do guard com usuário regular.
- Resíduo: pedidos 7059–7275 e boletos 52–59 do gate; crashlytics 67/68 (KILLs intencionais).
  Fixtures restauradas.
- Executadas como assunção (só ratificar): **Q-A18** (regra 7 no cunhador do settled_code),
  **Q-A19** (principal > 0), **Q-A20** (guarda única POST/PUT + cinto no faturamento).

### 10.14 Re-score socrático final (Rodada 4 + Q-A18/19/20): **0.79 PASSOU** → A1/L1/L2/L3/L5 baixados em sessão (732/732)

- Passou: regra 7 forma (b) conferida nos 13 pontos de chamada do cunhador (todos embrulhados em
  retry); ordens reais de lock documentadas (baixa em lote = X ANTES do laço → forma (a));
  ciclo estrutural porta-(a) × faturamento/cancel resolvido pelo retry (vítima = a porta curta);
  048 "optimized away"; guarda única + cinto da OS; DTO em 2 casas; Q-G19/Q-G20 (X com
  `settled_code` NULL — nenhum leitor exige valor); title-balance = fórmula do app; privilégio
  pelo ramo; seeds efetivos (orders {5,7}, service-orders {5,7}, order-returns {}).
- **A1 (baixado)**: MAX(number) de `tb_order_stock_adjust` rodava SOB o X da institution sem
  índice (type ALL) → migration **049** (`idx_stock_adjust_number`), espelho em sql/03.
- **L1 (baixado)**: "principal > 0" vivia só no DTO da porta manual → agora na PEÇA
  (`settleBatchTx` → 409 SETTLEMENT_NO_PRINCIPAL para qualquer porta).
- **L2 (baixado)**: caixa (abrir, retirar) cunhava MAX+1 fora do protocolo → lock da institution
  como 1º lock + `withDeadlockRetry`.
- **L3 (baixado)**: produto inexistente/inativo no item da OS → PRODUCT_NOT_FOUND (era
  ROLE_MISSING, "entidade sem papel"). **L5 (baixado)**: texto da regra 7 fiel (formas (a)/(b),
  ciclo estrutural e quem fica só no retry).
- **A2 → Q-G27**, **A3 → Q-G26** (design aceito por retry; medir convoy), L4 (cinto da OS já
  tem jest — `service-orders-invoice.test`), INFO resíduo registrado abaixo.
- Resíduo do dev que viola invariantes hoje garantidas (sondas anteriores às correções):
  baixas com principal ≤ 0 em 6925, 7077, 7078 (×2) e títulos com principal coberto > tag em
  6822, 6874 (2×100) e 6926 (90 @10 % + 10) — aparecem em "Abertos" com saldo cheio; são
  evidência de gate, não dado de negócio.

### Questões do re-score final (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-G26**~~ (DECIDIDA: manter e medir (Rodada 5)) Contador de `tb_order.id` por MAX+1 sob o X da institution trava a LINHA do pedido
  mais novo (que faturamento/cancel seguram em transações longas): manter (ciclo resolvido
  pelo retry; medir o convoy em produção) ou migrar para contador dedicado por institution
  (linha de contadores, sem MAX)? (rec.: manter agora e medir; contador dedicado quando o
  convoy aparecer — família da Q-A12 (c))
- ~~**Q-G27**~~ (DECIDIDA: ambos (Rodada 5)) Rotina mensal × produto inválido no contrato (inativo, mercadoria, inexistente —
  contrato não valida nem tem FK): (a) injetar e deixar o cinto do faturamento recusar (hoje),
  (b) `assertServiceProduct` no POST/PUT do contrato + rotina pula e reporta em `errors`,
  (c) ambos? (rec.: (c))
- ~~**Q-G28 (= Q-A21)**~~ (DECIDIDA: D-G28 na Rodada 5 + D-A28 "manter" na Rodada 7) Desconto em baixa PARCIAL: `tag × aliq/100` inteiro em CADA baixa — duas parciais
  com 10 % = 20 %. Semântica do legado (desconto só quando quita?) ou desconto proporcional ao
  principal pago / permitido só na quitação? (rec.: desconto só na baixa que QUITA — fiel ao
  `liquidValue` do app, que calcula sobre o título inteiro)
- ~~**Q-G29**~~ (DECIDIDA: privilégio do RAMO (Rodada 5)) Devolução: `POST /billing/invoice` exige FATURAR em `orders` (fixo) e o resolver do
  `/cancel` só distingue OS × orders — operador só de `order-returns` (interface 31, sem 5/7)
  não fatura nem cancela devolução. Intencional, ou estender o privilégio do RAMO com resolver
  + seed para `order-returns`? (rec.: estender — resolver por âncora de devolução, seed 54)

### 10.15 Re-prova adversarial FINAL (Rodadas 3/4, 56 ações, 22 min): **0.62 — REPROVOU por 1 HIGH** → corrigido em sessão com jest + prova ao vivo (740/740 · 12/12)

- **Passou** (ids reais no relatório do agente): Q-A18 baixas concorrentes 6/6/6/10 = 28×201 sem
  409 (sc únicos); estornos/depósitos/boletos/auto-baixa por contrato em paralelo 201; lock da
  institution segurado 10 s → escritas esperam e concluem, leitura 149 ms; Q-A20 nos dois verbos
  (400/400/400/422) + produto trocado no banco → 422 e OS segue aberta; Q-A19 (10 = 10 → 400;
  9,99 → 201); D-G19 V com cliente e vínculo da forma soft-deletados → CH 7382 nasce; D-G20 X do R
  órfão 2× (2ª → 409); teto/desconto (40,01 → 409; 95 = 90 + 5 quita; 95,01 → 409); CANCELAR
  pelo ramo / FATURAR na OS; 16 devoluções concorrentes sem 409; cascata do cancel com cheque em
  custódia; 7 corridas cancel × Baixas × depósito e 6 corridas boleto agrupado × liquidar × baixar
  — zero 500, nunca L e C juntos; crashlytics 0 (conferido direto — o `crashSince` do harness
  antigo consultava coluna inexistente e engolia o erro: toda asserção "crashlytics = 0" das
  re-provas anteriores era VAZIA; corrigido no harness `ra.js`).
- **HIGH (Q-A24, corrigido)**: `POST /checks/:id/pay` aceitava título a RECEBER — cheque em custódia
  (R do pedido A, crédito no caixa) "pagou" a venda de outro cliente: 201, payment N e um SEGUNDO
  crédito do mesmo papel no caixa (3,00 virou 6,00). Causa: `useCheckInPayment` lia só
  `tb_financial`; `settleOneTitle` herda a operação do título ('C' = crédito). O lookup filtrava
  'D', a peça não. Correção: leitura do título com JOIN em `tb_financial_bills` (FOR UPDATE) e
  `operation ≠ 'D'` → **422 CHECK_TITLE_NOT_PAYABLE** antes de qualquer gravação (jest em
  `check.test`; swagger do `/pay`).
- **MEDIUM (Q-A26, corrigido)**: `listOpenPayables` tinha a 3ª fórmula de saldo (tag − Σ pago, sem
  juros/multa/desconto) — a tela oferecia PA que o `pay` recusava com 422. Agora é o 4º consumidor
  de `OPEN_BALANCE_SQL` (jest em `checks-module.test`).
- **LOW (Q-A27, corrigido)**: validação em float × gravação em DECIMAL — juros 9,995 sobre 10 pagos
  passava no DTO (`Math.round(9.995×100)` = 999) e o banco gravava 10,00 → principal ZERO gravado
  (o L1 da peça usava o mesmo `r2` e não fechava). Correção: peça **`@shared/money`**
  (`toCents`/`round2` = half-up sobre o decimal ESCRITO, via `toPrecision(15)` — 9,995 → 10,00 como
  o DECIMAL); DTO compara em CENTAVOS; `settleBatchTx` normaliza os 4 valores ANTES de comparar e
  o INSERT recebe os normalizados; `title-balance` usa a mesma regra. **REGRA: o que a API valida é
  o que ela grava.** Pendência de método: 9 cópias inline de `round2` (billing, orders, cashier,
  bank-slip, check, order, installment, tax-rule, commission) podem adotar a peça — fora do alvo,
  cada uma tem teste próprio sensível a bordas .xx5; migrar por frente, não em bloco.
- Achados que são DECISÃO (abaixo): desconto empilhado em baixa parcial (MEDIUM), pool preso
  pelo lock da institution (MEDIUM), devoluções paralelas da mesma venda (LOW), desconto 100 %.
- Registrado sem correção: 1 deadlock em `idx_invoice_number_seq` (3 faturamentos paralelos,
  MAX(number_seq)) absorvido pelo retry — família "só no retry" da regra 7; nenhum deadlock
  envolvendo `tb_institution`.
- Não testado: 403 do guard com usuário REGULAR (dev só tem admin/super); V de cheque cuja forma
  CENTRAL foi excluída; corrida onde o estorno vence o depósito; monthly-run com 2+ contratos.
- Resíduo (dev): pedidos 7317–7489, cheques 137–158, boletos 52–70; **CH 7382** (70, cliente 209 —
  evidência D-G19); 7386/7387 (desconto empilhado) e 7375/7470 (principal zero gravado antes do
  Q-A27) = evidências; fixtures restauradas (forma 3 kind 'C', max_parcels 1, PA 6569 saldo 60,
  caixa 6 aberto). Scripts `ra*.js` e `s_rodada4e.js` no scratchpad.
- Executadas como assunção (só ratificar): **Q-A24**, **Q-A26**, **Q-A27**.

### Questões da re-prova final (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-A21 (= Q-G28)**~~ (DECIDIDA: D-G28 na Rodada 5 + D-A28 "manter" na Rodada 7) Desconto em baixa PARCIAL: hoje `tag × aliq/100` inteiro em CADA baixa viva —
  9 baixas de 0,01 a 10 % + 9,91 quitaram um título de 100 com 10,00 recebidos (7386). (a) desconto
  só na baixa que QUITA (fiel ao `liquidValue` do app, que calcula sobre o título inteiro);
  (b) desconto limitado a `saldo − principal informado` (nunca cobre mais do que resta);
  (c) % sobre o saldo em aberto no momento. (rec.: (a) — e o app já pensa assim)
- ~~**Q-A22**~~ (DECIDIDA: não existe desconto 100 % → D-A22 (Rodada 5)) Desconto 100 % é impossível (pago > 0 e teto 0): existe "baixa por abono/perda"
  (quitar sem receber)? (rec.: ato PRÓPRIO, evento distinto — não é baixa)
- ~~**Q-A23**~~ (DECIDIDA: sim, WAIT 10 → D-A23 (Rodada 5)) `lockInstitutionCounters` sem `WAIT n`: 1 detentor lento (55 s) + 22 baixas → as 20
  conexões do pool presas no lock wait, leitura `GET /orders` levou 47,9 s, 409 só aos 50,7 s
  (`innodb_lock_wait_timeout` 50). `SELECT … FOR UPDATE WAIT 5` (MariaDB ≥ 10.3) → 409
  RESOURCE_BUSY em 5 s e o pool respira? (rec.: sim, WAIT 5–10 s só nesse lock; leituras nunca
  esperam cunhador)
- ~~**Q-A25**~~ (DECIDIDA: aceitar → D-A25 (Rodada 5)) 6 devoluções da MESMA venda abertas em paralelo, cada uma pré-carregada com a
  quantidade CHEIA (pré-carga fora da transação; o gate real é o faturar — R2 aceito). Aceitar
  ou UNIQUE de devolução ABERTA por venda de origem? (rec.: aceitar e registrar — o faturar fecha)

### 10.16 Rodada 5 — DECIDIDA (Valdo 2026-09-10) e EXECUTADA (2026-09-11): 753/753 api · app analyze limpo 31/31 · ao vivo 16/16

Respostas: Q-G26 "manter e medir" · Q-G27 "ambos" · Q-G28 "leia BX-10 e proc-baixa-financeira antes de
implementar a baixa parcial" · Q-G29 "qualquer privilégio deve existir na tabela específica, depois
referenciado como opção na tela, e o código alinhado com o privilégio atribuído à interface" · Q-A22 "não
existe desconto de 100 %, podemos desativar a cobrança" · Q-A23 "sim" · Q-A25 "aceitar".

- **D-G26** MAX+1 de `tb_order.id` sob o X da institution FICA; medição = o `logger.warn("Deadlock em …
  — reexecutando")` do `withDeadlockRetry` (contar por rótulo em produção); contador dedicado só se o
  convoy aparecer.
- **D-G27 ("ambos")** — guarda única virou PEÇA `@shared/service-product` (`assertServiceProduct` lança;
  `serviceProductIssue` devolve o motivo): (b) o CONTRATO valida cada item no POST/PUT (`syncItems` —
  400 PRODUCT_NOT_FOUND / 422 SERVICE_ORDER_ITEM_NOT_SERVICE, nada gravado); (c) a ROTINA MENSAL pula o
  item cujo produto ficou inválido depois e reporta em `errors[{customerId, contractId, productId,
  message}]` (antes injetava e o cinto do faturamento derrubava a OS inteira). Prova ao vivo: 09/2026
  injeta 1; produto inativado → 10/2026 `skipped 1, injected 0, errors[1]`.
- **D-G28 (= Q-A21)** — lidos `BX-10` ("baixa parcial gera título residual" com face = (parcela − pago)
  + juros + mora − desconto, mantendo nº/parcela/vencimento/pedido/nota) e `proc-baixa-financeira`
  (B04). Leitura para a web: a 1ª parcial da fórmula vigente JÁ batia com o residual do legado; o
  empilhamento nascia na 2ª, porque o legado aplica o % sobre a FACE do residual (= o que resta) e a
  web aplicava sobre o tag de novo. Decisão: **desconto de cada baixa = % sobre o SALDO EM ABERTO no
  ato**, e o **VALOR concedido é fato do ato, gravado na baixa** (`tb_financial_payment.discount_value`,
  migration **050**, backfill `tag × aliq` para as baixas antigas — semântica que elas tiveram; espelho
  'R' copia o valor). Peça `title-balance`: principal coberto = pago − juros − multa + discount_value
  (`PRINCIPAL_PAID_SQL` sem `tag_value`; `getPrincipalPaidTx` sem tagValue; `settlementCeiling` devolve
  `discount`); `settleBatchTx` grava o valor; `settleOneTitle` grava 0; API `settlements.calc.liquidValue`
  e a tela de Baixas calculam o líquido sobre o SALDO. Prova ao vivo: 50 @ 10 % → discount_value 10,
  saldo 40; 40 @ 10 % → 409 (teto 36); 36 @ 10 % → discount_value 4 e quita; estorno devolve 40 e o
  espelho carrega 4. **Boleto**: `settleBankSlip` segue com aliquot 0 — pagamento pela face menos o
  desconto congelado deixa resíduo no título (Q-B2 do boleto) → **Q-G30** abaixo.
- **D-G29** — na ordem que o Valdo definiu: (1) o privilégio EXISTE na tabela (`tb_privilege` 5 FATURAR);
  (2) é REFERENCIADO como opção na tela da devolução (`tb_interface_has_privilege`, **seed 54**
  `order-returns` × 5); (3) o código VALIDA pelo RAMO: resolver único `modules/billing/
  billing.interface-resolver.ts` (ciclo de OS → `service-orders`; âncora `tb_order_stock_adjust_return`
  → `order-returns`; senão `orders`) em `POST /billing/invoice` (antes FATURAR fixo em `orders`) e em
  `POST /billing/cancel`; (4) as telas ALINHADAS ao privilégio da interface: "Validar e Faturar" gated
  por `CurrentInterface.can('FATURAR')` na devolução E no pedido (o pedido não gateava, embora o seed 51
  já desse FATURAR à interface). CANCELAR em `order-returns` entra com a Onda 2 (devolução faturada não
  cancela — §10.1 do plano).
- **D-A22** — não existe desconto de 100 %; o caminho para "não cobrar" é DESATIVAR a cobrança: ato
  PRÓPRIO, ainda não modelado (no legado é B09 / BX-04: `FIN_BAIXA='I'` — título inativo sai dos
  saldos). Pendência de modelagem (guardião conceitual antes de criar o evento/estado).
- **D-A23** — `lockInstitutionCounters` usa `FOR UPDATE WAIT 10` (`INSTITUTION_LOCK_WAIT_SECONDS`;
  MariaDB ≥ 10.3 detectado no boot — `detectLockWaitSupport`; sem suporte cai no timeout global com
  aviso no log); 1205 → 409 RESOURCE_BUSY pela fronteira; o retry de deadlock NÃO reexecuta lock wait
  (falhar cedo é o objetivo). Prova ao vivo: detentor externo segurando o X → baixa 409 em 11,2 s (era
  50,7); liberado → 201. PADROES_BANCO §9 regra 7 atualizada.
- **D-A25** — aceito: N devoluções abertas da mesma venda com pré-carga cheia; o faturar fecha
  (`assertReturnableInTx` sob lock). Registrado, sem código.
- Q-A24/Q-A26/Q-A27 (assunções da re-prova final) não foram contestadas — vigentes.
- Migration 050 e seed 54 APLICADOS no dev (backfill: 18 baixas, R$ 253,00 de desconto gravado).
- Gates da Rodada 5 e passeio logado: ver §10.17.

### Questões da Rodada 5 (aguardam o Valdo)
- ~~**Q-G30**~~ (DECIDIDA: sim → D-G30 (Rodada 6)) Boleto pago pela face menos o desconto CONGELADO (D-B2): hoje a liquidação grava
  `paid_value` = recebido com aliquot 0 e o título fica com resíduo = desconto (Q-B2 do boleto, "pagamento
  menor que a face deixa resíduo"). Com a D-G28 (desconto concedido é fato do ato, gravado na baixa) o
  desconto do boleto deve ser gravado como `discount_value` rateado e o título QUITAR? (rec.: sim — o
  desconto concedido pelo banco dentro do prazo é ato da casa; resíduo fantasma fica em "Abertos" para
  sempre; fora do prazo o banco não concede e nada muda)

### 10.17 Gates da Rodada 5 — socrático **0.74 PASSA** (M2 corrigido em sessão; M1/M3/L1–L4 viram Q-G31…Q-G35); adversarial: ver §10.18

- Passou (conferido no código pelo revisor): fórmula única do saldo em TODOS os consumidores (ninguém
  recalcula desconto sobre o tag — o único `tag × aliq` é o backfill da 050); gravação = validação
  (`settleBatchTx` normaliza e grava o `discount`; `settleOneTitle` grava 0); espelho R copia o valor;
  quinhão PA sobre o caixa pago e compensação sobre o tag do PA (desconto não contamina parcerias);
  duas parciais com desconto no mesmo título serializam pelo FOR UPDATE do título antes da leitura
  travante; migration 050 idempotente, por schema, payment órfão nunca somado; D-A23 detectado antes do
  listen, 1205 não reexecuta, jest nos 3 ramos; resolver imutável após a abertura (sem TOCTOU); seed 54
  idempotente pela PK; app tolera os campos novos do relatório da rotina.
- **M2 (corrigido)**: a tela de Baixas arredondava o desconto com `roundToDouble` e a API pela regra do
  DECIMAL (half-up sobre o decimal escrito) — 3.641 divergências em 600.000 (saldo 5,80 a 2,5 % → API
  0,15 / tela 0,14) e a PRÓPRIA sugestão da tela caía em `TITLE_EXCEEDS_BALANCE` por 1 centavo. Espelho
  da peça `money` no app: `toCents`/`roundMoney` em `app/shared/format/money.dart` (o `setesMoney`
  também usa), `_round2` da tela delega; teste `money_round_test.dart`. REGRA (dica do revisor): um
  arredondador de dinheiro por ponta — a tela só sugere o que a API aceitaria. 33/33 app.
- **M1 → Q-G31**: com WAIT 10, contenção no X da institution DURANTE o faturamento com contrato
  (forma (b), `nextSettledCode` no meio) estoura em 10 s e o `ROLLBACK TO SAVEPOINT auto_settle`
  emite a nota com título aberto e sem a taxa — silencioso (D14), 5× mais provável sob carga; e
  `innodb_rollback_on_timeout` ligado transformaria o mesmo 1205 em transação perdida.
- **M3 → Q-G32**: 99,99 % de desconto quita qualquer título com 0,01 — pré-existente, mas D-G28
  formalizou o desconto como fato gravado e o legado exigia SENHA (BX-14/BX-15, B03).
- **L1 → Q-G33** OS vazia quando todos os itens do contrato ficaram inválidos (abre antes do laço);
  **L2 → Q-G34** PUT do contrato com item herdado inválido → 400 (não dá para encerrar sem remover o
  item); **L4 → Q-G35** 100 % ainda passa no DTO com mensagem enganosa (Q-A22 sem caminho de código).
- **L3 (UX, pendência registrada)**: `CurrentInterface` só hidrata pelo clique do menu — vindo de
  "Devolver" no pedido, a tela da devolução avalia o privilégio de `orders` (a persona só-devolução não
  vê o botão; a inversa vê e recebe 403). Junta-se à pendência "can() true no deep link": hidratar a
  interface pela ROTA (`/home/<interface>`), não pelo clique.
- INFO: backfill preserva o desconto empilhado das evidências 7386/7387 (histórico não se reescreve);
  `listBills` tem uma 2ª forma textual do saldo (sem ROUND) — trocar por `OPEN_BALANCE_SQL` na próxima
  passada; runner só migra institutions ativas; `serviceProductIssue` é N+1 por item (lote por cliente,
  aceitável); `/cancel` de devolução para regular → 403 até a Onda 2 (coerente).

### Questões dos gates da Rodada 5 (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-G31**~~ (DECIDIDA: (a) manter → D-G31 (Rodada 6)) Contenção de 10 s no X da institution DURANTE o faturamento com contrato: (a) manter —
  auto-baixa pulada em silêncio, título aberto para baixa manual; (b) retentar a auto-baixa uma vez;
  (c) derrubar o faturamento com 409 RESOURCE_BUSY para reexecutar com a política íntegra — e conferir
  `innodb_rollback_on_timeout=OFF` no boot ao lado do isolamento. (rec.: (c) + assert no boot — D14 diz
  que faturamento não bloqueia por MOTIVO DE NEGÓCIO; contenção é falha técnica transitória, família do
  deadlock, e o silêncio esconde título aberto e taxa que nunca nasceu)
- ~~**Q-G32**~~ (DECIDIDA: teto por config + privilégio DESCONTO → D-G32 (Rodada 6)) Autoridade do desconto na baixa: (a) privilégio DESCONTO na interface `settlements`
  (tabela → opção na tela → guard, regra Q-G29); (b) config `max_discount_aliquot` por institution
  (Framework de Configurações), 0 = livre; (c) ambos. (rec.: (c) — a config dá o teto sem senha e o
  privilégio libera acima dele)
- ~~**Q-G33**~~ (DECIDIDA: sim → D-G33 (Rodada 6)) Rotina mensal com todos os itens inválidos: (a) manter a OS vazia (reportada); (b) abrir a
  OS só quando há ao menos um item injetável. (rec.: (b) — OS sem item não fatura e ocupa a trava D5)
- ~~**Q-G34**~~ (DECIDIDA: sim → D-G34 (Rodada 6)) PUT do contrato com item que ficou inválido: (a) manter 400; (b) validar só itens
  NOVOS/alterados (encerrar com `dt_end`/`active='N'` passa); (c) validar só quando `active='S'`.
  (rec.: (b) — padrão da Q5 dos Menus: "422 só para ids novos, vínculo herdado sobrevive")
- ~~**Q-G35**~~ (DECIDIDA: sim aos dois → D-G35 (Rodada 6)) Q-A22 na prática: (a) DTO `max(99.99)` + mensagem própria ("desconto não pode cobrir o
  saldo inteiro"); (b) "inativar título" (B09/BX-04 do legado) como ato PRÓPRIO de onda futura.
  (rec.: (a) agora e (b) no plano)

### 10.18 Adversarial da Rodada 5 (141 ações ao vivo, 23 min): **0.58 — REPROVOU por 1 HIGH** → HIGH + 1 MEDIUM corrigidos em sessão (757/757 · ao vivo 11/11); 2 MEDIUM e 1 LOW viram decisão

- **Passou**: D-A23 integral (detentor 15/30/70 s × baixa/pedido/OS/faturar → 409 em 10,3–11,1 s,
  nunca 50; solta aos 8 s → 201; 25 cunhadores > pool 20 → 409 em até 22,8 s, zero 500, nada gravado);
  D-G29 integral com usuário REGULAR criado para a prova (403 PRIVILEGE_REQUIRED em cada ramo sem o
  vínculo; FATURAR só em `orders` fatura venda e recebe 403 na OS/devolução; FATURAR só em
  `order-returns` fatura a devolução 7554 → nota 6181 e recebe 403 na venda; CANCELAR em
  `order-returns` fora do catálogo → 400); D-G28 em todos os vetores menos a decaída geométrica
  (juros+multa+desconto; estorno da 1ª parcial não-última reabre e o espelho carrega o valor;
  arredondamentos 0,03 @ 33 % / 0,05 @ 10 % / 1,00 @ 0,4 %; 6 parciais simultâneas no mesmo título →
  2×201 + 4×409, principal 76 ≤ 100; lote com 2 títulos, cada desconto sobre o próprio saldo; cadeia PA
  com desconto: quinhão sobre o PAGO, lookup a pagar e cheque em pagamento pela peça, estorno da origem
  reverte PA + X do P); D-G27 validação (inexistente/deletado → 400, kind P → 422, repetido/vazio →
  400, PUT inválido faz rollback) e pular/reportar (inativo, deletado, virou 'P'); regressão §10.15
  (Q-A24 422, Q-A27 400/201, 18 baixas concorrentes sem 409). Crashlytics 0.
- **HIGH (corrigido)**: o BOLETO tinha a 5ª/6ª fórmula de saldo fora da peça (`tag − Σ paid_value`, sem
  juros/multa/desconto) no lock do título (`lockTitle`) e no lookup `open-titles`. Título 100 com
  parcial 50 @ 10 % (saldo real 40): lookup mostrava 50, boleto 71 nascia com face 50 e ficava SEM SAÍDA
  (liquidar 50 → 409 TITLE_EXCEEDS_BALANCE pelo teto da peça; 40 → 409 BANK_SLIP_BELOW_MINIMUM). Parcial
  60 com juros 10 (saldo 50): boleto 72 nascia com 40, liquidava e deixava 10 em Abertos para sempre.
  Correção: `lockTitle` lê `PRINCIPAL_PAID_SQL` e `listOpenTitles` lê `OPEN_BALANCE_SQL` (7º e 8º
  consumidores da peça; `grep "SUM(p.paid_value)"` zerado). Jest `bank-slip.test` (face 40 com principal
  60) e `bank-slips-lookup.test`; ao vivo: lookup 40 → boleto face 40 → liquida por 40 → quita; parcial
  com juros → lookup 50.
- **MEDIUM (corrigido)**: rotina mensal sob lock da institution segurado por terceiro devolvia **200**
  com `errors[{message: 'Lock wait timeout exceeded…'}]` (texto cru do driver; N clientes = N × 10 s
  serializados) — o catch por cliente engolia o 1205. Correção: contenção (1205 / 1213 esgotado) PROPAGA
  para a fronteira → 409 RESOURCE_BUSY; erro de negócio de um cliente continua isolado em `errors[]`.
  Jest em `contracts-service-product.test`; ao vivo 409 em 11,1 s, liberado → injeta.
- **MEDIUM → Q-A28**: decaída GEOMÉTRICA — D-G28 literal (% do saldo em cada ato) deixa 30 parciais de
  0,01 @ 10 % + 4,13 quitarem 100 com 4,43 recebidos (Σ discount_value 95,57). É a semântica decidida
  (BX-10) e o legado faz igual; o revisor pede decisão.
- **MEDIUM → Q-A29** (pré-existente, Fase 4.5 §3.4): rotina mensal para competência PASSADA reinjeta a
  cada corrida (08/2026 3× → 6 itens na mesma OS) — a idempotência usa `DATE(created_at)` no mês da
  competência, mas o item nasce na data da CORRIDA; só a competência corrente é idempotente.
- **LOW → Q-A31** (estado só por SQL): devolução com âncora soft-deletada e ordem viva → resolver cai
  em `orders`, regular com FATURAR em `orders` fatura como AJUSTE solto (nota 6179, sem plano de
  devolução; não cancelável; a venda 7543 fica bloqueada pela âncora restaurada). A API não produz
  esse estado (`cancelReturn` cascateia âncora + ajuste + ordem).
- Não testado: boleto AGRUPADO com parcial descontada em um título (mesma causa raiz, corrigida);
  contrato com produto de outra institution; V de cheque que pagou PA com desconto; DELETE do contrato
  não cascateia `tb_contract_item` (rotina filtra `c.deleted='N'` — INFO); regular sem privilégio roda
  monthly-run/DELETE /orders (rotas sem guard de ação — decisão 21, privilégio na tela).
- Resíduo (dev): pedidos 7495–7558; cheques 160–161; boletos 71 (E,C), 72 (E,L,X,C) e o da re-prova
  (7556: E,L — estornado; pedido bloqueado pelo boleto liquidado); PA 7508; usuários regulares 265–268
  soft-deletados; evidências mantidas 7495 (decaída), 7505/71 e 7506/72 (boleto), OS 7538 (6 itens
  duplicados), 7543/7544 (nota 6179 sem âncora), 7553/7554 (devolução 6181 faturada pelo regular).
  Fixtures restauradas (forma 3, max_parcels, produtos 5/7, regras 2/4, âncora 7544, 0 contratos, 0 OS).
- Executadas como assunção (só ratificar): boleto pela peça (HIGH) e contenção da rotina → 409 (MEDIUM).

### Questões da adversarial da Rodada 5 (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-A28**~~ (DECIDIDA: opção 1 MANTER → D-A28 (Rodada 7)) Decaída geométrica do desconto em parciais (30 × 0,01 @ 10 % quitam 100 com 4,43): manter
  D-G28 literal (fiel ao BX-10, `discount_value` dá auditoria) ou limitar — (a) desconto só na baixa que
  QUITA; (b) desconto proporcional ao principal pago (`desconto = pago × aliq / (100 − aliq)`, cada baixa
  é um ato); (c) teto de % por privilégio (junta com Q-G32)? (rec.: (b) — mata a decaída sem tirar o
  "cada baixa é um ato"; 99,99 % numa baixa única continua sendo ato consciente, gate da Q-G32)
- ~~**Q-A29**~~ (DECIDIDA: sim → D-A29 (Rodada 6)) Idempotência da rotina mensal para competência passada: gravar a COMPETÊNCIA no item
  injetado (vínculo contrato × produto × ano-mês) em vez de `created_at`? (rec.: sim — reexecução
  retroativa hoje fatura em dobro)
- ~~**Q-A30**~~ (DECIDIDA: sim, aceitar → D-A30 (Rodada 6)) Leituras com pool saturado (25 cunhadores > 20 conexões → `GET /orders` esperou 9,7 s):
  aceitar (o WAIT 10 já limita o pior caso) ou pool/limite separado para leituras? (rec.: aceitar e
  medir; limite conhecido do D-A23)
- ~~**Q-A31**~~ (DECIDIDA: sim → D-A31 (Rodada 6)) Ordem de ajuste com âncora de devolução soft-deletada e ordem viva (só por SQL): billing
  recusa (409) ou basta a integridade do `cancelReturn`? (rec.: cinto barato — resolver e billing
  ignoram `deleted` ao decidir o RAMO; só o `cancelReturn` decide vida)

## 11. Rodada 6 — DECIDIDA e EXECUTADA (Valdo, 2026-09-13): Q-G30…Q-G35 + Q-A29/A30/A31

Respostas: **Q-G30 sim · Q-G31 (a) · Q-G32 "por config determina o teto, o privilégio DESCONTO
autoriza e bypassa a validação" · Q-G33 sim · Q-G34 sim · Q-G35 sim aos dois · Q-A29 sim ·
Q-A30 sim · Q-A31 sim**. Q-A28 (decaída geométrica do desconto) FICOU ABERTA a pedido do Valdo —
"vamos tratar individualmente isso me explicando novamente incluindo D-G28" (§11.1).

### D-G30 — boleto pago com desconto congelado QUITA (o desconto vira fato da baixa)
O boleto congela o desconto na emissão (`tb_bank_slip.discount_value`, válido até
`dt_discount_until` — D-B2 da Rodada 2 do boleto). Pagar a face MENOS esse desconto não é baixa
parcial: `settleBankSlip` calcula `discountGranted = min(desconto congelado, face − pago)`, rateia
pelos vínculos na mesma proporção do principal e manda em `SettleTitleInput.discountValue`; a peça
grava em `tb_financial_payment.discount_value` (D-G28) e o título QUITA. Fora do prazo do desconto
nada é honrado (o 409 `BANK_SLIP_BELOW_MINIMUM` continua barrando antes de qualquer gravação).
`settlementCeiling` passou a aceitar `discountValue`, que PREVALECE sobre o % — quem já tem o
desconto em valor não recalcula. Fecha a Q-G30 (resíduo eterno no título pago com desconto).

### D-G31 (a) — contenção no meio do faturamento continua pulando a auto-baixa em silêncio
Nada mudou no código: o savepoint `auto_settle` isola a falha, a nota sai e o título fica ABERTO
para baixa manual (D14 do contrato financeiro — "faturamento NUNCA bloqueia"). Registrado como
LIMITE CONHECIDO: sob carga, contenção de 10 s no lock da institution durante o faturamento com
contrato deixa título aberto e taxa não lançada, com motivo só em log.

### D-G32 — autoridade do desconto: teto por CONFIG, privilégio DESCONTO bypassa
Fiel ao BX-15 do legado (desconto na baixa a receber exigia autorização), no formato da casa e na
regra da Q-G29 ("o privilégio existe na TABELA, é opção na TELA e o código valida"):
1. **tabela**: privilégio **DESCONTO id 8** (`tb_privilege`, seed sql/55);
2. **tela**: vínculo `tb_interface_has_privilege` com a interface `settlements` (opção no cadastro
   de privilégios do usuário) + a tela de Baixas valida localmente (`discountAboveLimit`);
3. **código**: `assertDiscountPolicy` (peça `modules/settlements/settlements.discount-policy.ts`)
   no `POST /api/settlements` → **403 `DISCOUNT_REQUIRES_PRIVILEGE`** com `fields[].expected` = teto;
4. **teto**: config `max_discount_aliquot` (Framework de Configurações, interface `settlements`,
   scope I, kind Float, **default 0** = nenhum desconto sem o privilégio — fiel ao legado).
Admin/super passam (regra dos guards). Só a porta MANUAL passa pela política: o boleto honra o
desconto CONGELADO na emissão (contrato com o banco) e o cheque não concede desconto.

### D-G33 — rotina mensal não abre OS vazia
`monthlyRun` monta a lista de injetáveis ANTES de tocar na ordem; sem nenhum item, commita sem
abrir nada (antes a OS nascia e ficava ocupando a trava D5 do cliente sem poder faturar).

### D-G34 — contrato revalida só item NOVO ou ALTERADO
`syncItems` lê os itens vivos e só chama `assertServiceProduct` para produto novo ou com `value`
diferente. Encerrar/inativar contrato cujo item ficou inválido passa; trocar o produto ou mexer no
valor revalida. Mesmo padrão da Q5 dos Menus ("422 só para ids novos, vínculo herdado sobrevive").

### D-G35 — não existe desconto de 100 %
DTO recusa acima de **99,99 %** com mensagem própria; e a PEÇA limita o desconto a **saldo − 0,01**
(99,99 % de 10,00 dá 9,999 → 10,00 no DECIMAL e "quitaria" sem receber nada). Sempre sobra pelo
menos 1 centavo a receber. "Desativar a cobrança" (B09/BX-04 do legado: `FIN_BAIXA='I'`, título sai
dos saldos sem estar pago) fica como ATO PRÓPRIO de onda futura — item do plano, não é baixa.

### D-A29 — idempotência da rotina mensal pela COMPETÊNCIA (peça nova)
A chave era `DATE(created_at)` do item dentro do mês da competência, mas o item nasce na data da
CORRIDA: reexecutar 08/2026 em setembro injetava tudo de novo (a adversarial provou 3× → 6 itens).
O fato gerador é "a rotina faturou o item do contrato na competência" — peça própria
**`tb_contract_item_competence`** (migration 051 + espelho no sql/03 + backfill do que já existe):
chave contrato × produto × `YYYY-MM`, guardando a ordem e o item gerados. Cancelar a OS devolve a
competência (soft delete) e a rotina REVIVE a linha; item removido à mão da OS viva NÃO devolve
(ato do operador). Não virou coluna no item universal da ordem (DP6 — item de serviço é enxuto).

### D-A30 — limite conhecido, aceito
Com o pool saturado (mais cunhadores concorrentes que conexões), uma LEITURA pode esperar até os
10 s do `WAIT` do lock da institution. Aceito e registrado; medir em produção antes de separar pool.

### D-A31 — âncora morta ainda decide o RAMO
`getAnchor` ganhou `{ includeDeleted }` e devolve `deleted`. O resolver do privilégio e o billing
leem a âncora mesmo soft-deletada: devolução com âncora cancelada e ordem viva (estado que só o SQL
produz) vira ISSUE no validate e **409 `RETURN_ANCHOR_INCONSISTENT`** no invoice — nunca "ajuste
solto" sem plano de devolução. Só `cancelReturn` decide vida (cascateia âncora + ajuste + ordem).

### Colateral (M2 do socrático da Rodada 5)
App arredonda dinheiro pela MESMA regra do DECIMAL da API: `toCents`/`roundMoney` em
`app/shared/format/money.dart` (o `setesMoney` também usa), consumidos pela tela de Baixas.

### Provas
`tsc` limpo · **773/773** jest (novos: `settlements-discount-policy.test.ts` + casos D-G30/D-G34/
D-G35/D-A29/D-A31 em bank-slip, settlement-batch, contracts-service-product, billing e
billing-interface-resolver) · app `analyze` limpo + 33/33 · migration 051 e seed 55 APLICADOS no dev.
Ao vivo (`s_rodada6.js` 20/23 — as 3 falhas eram do próprio script — e `s_rodada6_a31.js` 6/6):
boleto 100 com desconto congelado 10 pago por 90 → `discount_value` 10 e saldo 0; 2ª baixa 409;
100 % → 400 e 99,99 % (admin) → 201; regular sem privilégio → 403 com `expected` 0; teto 5 %
configurado → 5 % passa e 10 % → 403; privilégio DESCONTO → passa; contrato só com item inválido →
zero OS aberta; 08/2026 injeta 1 e a 2ª corrida pula (antes duplicava); 09/2026 injeta na mesma OS;
cancelar a OS devolve as competências e a rotina revive; PUT encerrando contrato com item herdado
inválido → 200 e com valor alterado → 400; âncora soft-deletada → issue no validate e 409 no
invoice com a ordem ainda 'A'. Crashlytics zero.

### 11.1 D-A28 — desconto em baixa PARCIAL: **DECIDIDA (Valdo, 2026-09-13: opção 1 — MANTER)**
**O que a D-G28 decidiu (Rodada 5)**: o desconto de uma baixa incide sobre o **saldo em aberto no
momento do ato** (não sobre o valor original do título) e o valor concedido é **gravado na baixa**
(`discount_value`). Veio da BX-10 do legado — baixa parcial gera um "título residual" cuja FACE é o
que resta, então o desconto seguinte naturalmente se aplica sobre essa face nova.
**O que a adversarial provou (Q-A28)**: como CADA baixa concede % do saldo daquele momento, muitas
baixas pequenas cobram pouco e descontam muito. Título de 100: 30 baixas de **0,01** com 10 % cada
(10,00 → 8,99 → 8,08 → …) mais uma final de 4,13 QUITARAM o título com **4,43 recebidos** e 95,57
em desconto. Não é bug de implementação: é a regra decidida levada ao extremo (o legado faz igual).
Opções (a decisão é do Valdo):
- **(a) manter** — cada baixa é um ato do operador, o `discount_value` dá auditoria e a D-G32 agora
  põe teto de % e exige privilégio. Risco: quem tem o privilégio zera qualquer carteira em parcelas.
- **(b) proporcional ao principal pago** — `desconto = pago × aliq / (100 − aliq)`: com 10 %, pagar
  0,01 concede 0,0011 (não 1,00); pagar o saldo inteiro concede o mesmo desconto de hoje. Mata a
  decaída geométrica sem tirar o "cada baixa é um ato"; muda o número que a tela sugere hoje.
- **(c) desconto só na baixa que QUITA** — o mais simples de explicar ("desconto é para quem
  liquida"); tira o desconto de quem paga parcelado.
**DECIDIDA: (a) manter.** O desconto continua incidindo sobre o saldo de CADA ato — é a semântica da
D-G28/BX-10 e cada baixa é um ATO do operador, com o valor concedido gravado (`discount_value`) para
auditoria. Quem contém o risco NÃO é a aritmética e sim a AUTORIDADE: teto por config
`max_discount_aliquot` + privilégio DESCONTO nas duas portas (D-G32 e D-G36).

Nada mudou no código — o que entrou foi **conhecimento negativo**, para ninguém "consertar" isso no
futuro achando que é bug: comentário na peça `title-balance` e um teste que FIXA a semântica
(`settlement-batch.test`, "D-A28": 1ª parcial de 0,01 a 10 % concede 10,00; a 2ª, no mesmo título,
concede 10 % do saldo NOVO = 9,00). 784/784.

### 11.2 Socrático da Rodada 6: **0.75 PASSA com pendências** (nenhum CRITICAL; H1/H2 viram decisão, M/L para sessão)

- **Passou** (conferido no código pelo revisor): D-G30 fecha a aritmética — `principal + desconto`
  de cada vínculo = a face do título, inclusive no agrupado com dízima; `discountValue: 0` é
  `!= null` e por isso a alíquota congelada NUNCA é reaplicada sobre o saldo (senão todo boleto
  pago pela face ganharia desconto fantasma); pagamento entre a face−desconto e a face honra só a
  parte concedida; fora do prazo o 409 barra antes de gravar. ESTORNO: o espelho R copia
  `discount_value`, as duas linhas saem da soma (`status='N'`) e o saldo volta inteiro — o
  statement compensa só o caixa (o desconto nunca foi dinheiro). `grep "SUM(p.paid_value)"` fora
  da peça segue **zero**. D-G32: `userHasPrivilege` consulta o banco por request (revogação
  imediata), config com TTL 60 s mas invalidação no save, scope I sem override de usuário, sem
  config = 0 (fail-closed). D-G33/D-A29: `lockInstitutionCounters` continua sendo o 1º lock
  (regra 7 intacta), FK composta na ordem da PK, PK barra a corrida, `ON DUPLICATE KEY` revive,
  e `DELETE /api/orders/:id` não alcança OS — a única porta que mata a OS é a que devolve a
  competência. D-A31 fecha nos DOIS sentidos. D-G31 "manter" é defensável: dev com
  `innodb_rollback_on_timeout=OFF` e, mesmo com ON, a falha do savepoint é rethrow (a nota não
  sai — falha alta, não nota corrompida).
- **H1 → Q-G36**: a autoridade do desconto tem uma SEGUNDA porta sem dono — a carteira
  (`bank-charge-agreements`) aceita `aliq_discount` 0..100 sem privilégio nem teto, e a
  liquidação honra um `dtPayment` DIGITADO sem limite de data. Antes da D-G30 isso deixava
  resíduo; agora QUITA. Quem não pode dar 1 % na baixa manual dá 100 % emitindo boleto.
- **H2 → Q-G37**: `max_discount_aliquot` default 0 = "nada" (fail-closed) inverte o texto da
  Q-G32 e, no deploy, todo operador regular perde o desconto de uma vez; sem o seed 55 a TELA
  fica mais restritiva que a API para o próprio admin. (→ §10.3 itens 4–6.)
- **Para corrigir em sessão** (M1, L2–L7 + doc): linha do agrupado cujo caixa rateado arredonda
  a 0,00 com desconto > 0 cai em SETTLEMENT_NO_PRINCIPAL e o boleto fica sem saída (a guarda mede
  dinheiro que entrou, não principal coberto); `bank-slip.ts` e as peças de dinheiro tocadas
  passam a usar `round2` de `@shared/money` (12 arredondadores locais convivem com a peça);
  `settlements.calc.liquidValue/openBalance` é 2ª implementação da regra SEM consumidor (só
  testes) e sem o teto da D-G35; `listBills` ainda tem a forma textual do saldo (base do desconto
  sugerido na tela); backfill da 050 pode INVENTAR desconto em replay (a marca
  `discount_value = 0 AND aliquot > 0` deixou de ser confiável); app não consome `expected` do 403
  nem aplica o teto saldo−0,01 na sugestão, e não tem teste de widget da D-G32; falta o assert de
  `innodb_rollback_on_timeout` no boot ao lado do `assertIsolationLevel`.
- **Nota de padrão**: FATURAR/CANCELAR são aplicados na ROTA (`requirePrivilege*`) e DESCONTO no
  CONTROLLER (política condicional, depende do corpo) — coerente, mas virou linha em
  `ARQUITETURA_MODULOS_API.md` para o próximo módulo não inventar um terceiro lugar.
- **Dica arquitetural do revisor**: toda regra que virou LEI (saldo, arredondamento, autoridade do
  desconto) precisa de peça única **E de inventário de portas** — a peça sozinha não impede que
  uma segunda porta (carteira do boleto, calc morto, `round2` local) conceda o que a primeira nega.

### Questões do socrático da Rodada 6 (aguardam o Valdo — recomendação entre parênteses)
- ~~**Q-G36**~~ (DECIDIDA 2026-09-13: "concordo" → D-G36, §11.4) Autoridade do desconto na porta do BOLETO: a carteira aceita `aliq_discount` até 100 %
  sem privilégio e o `dtPayment` da liquidação é digitado sem limite de data — com a D-G30 isso
  QUITA o título. A alíquota da carteira deve exigir o privilégio DESCONTO, o `dtPayment` deve ser
  limitado (≤ hoje) e/ou a liquidação deve passar pela política? (rec.: privilégio na alíquota da
  carteira + `dtPayment` ≤ hoje; a liquidação em si segue livre — o desconto já foi autorizado na
  emissão, é contrato com o banco)
- ~~**Q-G37**~~ (DECIDIDA 2026-09-13: "concordo" → D-G37, §11.4) Semântica do `max_discount_aliquot = 0`: hoje "nenhum desconto sem o privilégio"
  (fiel ao BX-15) e, no deploy, todo operador regular perde o desconto de uma vez. Manter
  fail-closed com tarefa de implantação explícita, ou o default sai "livre" e cada empresa aperta?
  (rec.: manter 0 = nada + §10.3 — a surpresa é de 1 dia, o desconto sem dono é permanente)
- ~~**Q-A32**~~ (DECIDIDA: não → D-A32 (Rodada 7)) Backfill da 051 carimba o mês da CORRIDA: nos itens que motivaram a D-A29 a
  competência faturada fica LIVRE e a do mês da corrida fica CONSUMIDA. Aceitar (história não se
  reescreve) ou gerar relatório de correção por cliente antes de produção? (rec.: relatório — o
  dado para corrigir só existe antes de alguém rodar de novo)
- ~~**Q-A33**~~ (DECIDIDA: intencional → D-A33 (Rodada 7)) Dois contratos do mesmo cliente com o MESMO produto passam a injetar DOIS itens no mês
  (a regra antiga, por `created_at`, injetava um). Intencional (cada contrato é um fato) ou
  deduplica por produto? (rec.: manter dois — o contrato é quem cobra; a tela é que precisa
  mostrar de qual contrato veio cada item)
- ~~**Q-A34**~~ (DECIDIDA: sim → D-A34 (Rodada 7)) Item removido à mão da OS viva consome a competência para sempre (só cancelar a OS
  inteira devolve). Existe o ato "liberar a competência"? (rec.: ato próprio na tela da OS — hoje
  o operador fica sem saída e o cliente sem cobrança)
- ~~**Q-A35**~~ (DECIDIDA: sim → D-A35 (Rodada 7)) A rotina mensal toma o X da institution por cliente MESMO quando nada será injetado
  (caso comum depois da D-G33): quem fatura/baixa no mesmo instante espera até 10 s. Aceitar e
  medir (D-A30) ou travar só quando houver injetável? (rec.: travar só quando houver — o lock vira
  consequência do ato, não da varredura)

### 11.3 Adversarial da Rodada 6 (69 ações ao vivo, 20 min): **0.61 — REPROVOU por 2 HIGH** → ambos corrigidos em sessão (774/774 · app 41/41 · ao vivo 12/12)

- **Passou** (ids reais no relatório do agente): D-G30 no caminho feliz (agrupado 60+40 quita com
  desconto 6+4; estorno devolve o saldo e o espelho R carrega o `discount_value`; pagar entre a
  face−desconto e a face não deixa resíduo — Q-B2 morta; acima da face vira juros; fora do prazo
  barra; título com parcial descontada + boleto fecha); D-G32 (teto 0/5/100, lote recusado inteiro,
  privilégio concedido e REVOGADO com efeito imediato, admin passa, `discountValue` injetado no
  payload manual é removido pelo zod); D-A29 completo (2ª corrida pula, competência passada 3×,
  competências diferentes na mesma OS, item removido à mão não reinjeta, cancelar devolve, faturar
  não reabre, rotinas CONCORRENTES serializam sem duplicata, mês inválido 400); D-G33 (nenhuma OS,
  trava D5 livre); D-G34 (item herdado inalterado passa; 50,000/50,004 passam e 50,005 revalida —
  a comparação em centavos aguenta); D-G35 no DTO; D-A31 nos dois sentidos; regressões Q-A24,
  Q-A27, D-G28, boleto pela peça do saldo, D-A23 (409 em ~11 s), liquidações concorrentes do mesmo
  boleto, D-B1, cancelar nota de título quitado por boleto. Crashlytics zero.
- **HIGH-1 (corrigido)**: boleto AGRUPADO com desconto congelado era **impossível de liquidar**.
  Os três baldes (principal, juros, desconto) eram rateados com `round2` INDEPENDENTES e só o
  último recebia o resíduo de cada um: num título do meio em que as duas metades arredondavam para
  cima, `principal + desconto` passava da face do vínculo em 0,01 e o teto D-A7 derrubava o lote
  (33,35 + 66,65 não liquidava por 90,00 nem por 89,99 — travado exatamente no valor que o banco
  informa). Correção: o invariante que faz o título QUITAR é `principal_i + desconto_i = face_i`,
  então rateia-se só o DINHEIRO (por soma ACUMULADA, que garante total exato e nunca ultrapassa a
  face acumulada) e o **desconto é DERIVADO da face**. Jest com caso fixo + **teste de propriedade**
  sobre 1.428 pares de centavos; ao vivo: boleto 89 (33,35/66,65) liquidou por 90,00 e os dois
  títulos zeraram (30,02+3,33 e 59,98+6,67).
- **HIGH-2 (corrigido)**: a D-A31 converteu 2 dos 3 leitores da âncora — o TERCEIRO, a guarda
  "nota de devolução não cancela nesta onda" em `buildCancelPlan`, continuava com `deleted = 'N'`.
  No estado que a própria D-A31 nomeia (âncora morta + ordem viva) a guarda sumia, o cancelamento
  passava e, como nada desfaz `tb_order_item_return`, a venda de origem perdia o saldo devolvível
  PARA SEMPRE. Correção: a guarda lê a âncora **viva ou não** (é devolução do mesmo jeito). Jest +
  ao vivo (409 com a âncora morta, elos íntegros, mesma recusa com a âncora viva).
- **MEDIUM/LOW corrigidos junto**: desconto que não cabe no saldo é **RECUSADO** com
  `409 DISCOUNT_EXCEEDS_BALANCE` no campo `discountAliquot` e `expected` = maior alíquota possível
  (antes era clampado em silêncio: a recusa culpava o saldo e o recibo gravava uma alíquota que não
  foi concedida); política do desconto compara em **centavos da alíquota** (a folga de 1e-9 deixava
  5.000000001 passar num teto de 5) e teto negativo na config vale 0; a tela usa a MESMA regra
  (peça nova `settlement_discount_rules.dart`, com o teto e o líquido sugerido — antes sugeria
  0,00 para 99,99 % e a API recusava); `liquidValue` do módulo (3ª fórmula do desconto, sem
  consumidor) REMOVIDA; `round2` do boleto e do financial-settlement passam pela peça
  `@shared/money`; `listBills` pela `OPEN_BALANCE_SQL`; backfill da 050 não reexecuta em replay;
  aviso no boot se `innodb_rollback_on_timeout` ≠ OFF (pré-requisito técnico da D-G31 (a)).
- **Assunção de engenharia (ratificar)**: o teto "o desconto nunca cobre o saldo inteiro" (D-G35)
  vale para desconto por **ALÍQUOTA** (porta manual — o operador pede %); desconto em **VALOR**
  (boleto, D-G30) é ato ANTERIOR acordado na emissão e vale até o saldo inteiro. Sem essa distinção
  a D-G35 quebraria a D-G30 (linha do agrupado cuja face é toda coberta pelo desconto). A autoridade
  dessa porta é a Q-G36.
- **Resíduo (dev)**: pedidos 7584–7646, boletos 77–89, notas 6183/6184/6515, usuários 272/273
  soft-deletados, contratos 9–17 soft-deletados, competências 2026-07 a 2027-06. O agente corrigiu
  à mão o dano que provocou com o HIGH-2 (elos do 7622 e saldo do 7621 devolvidos). Fixtures
  restauradas e conferidas nas duas passadas (carteira sem desconto, regras 2/4, produtos, formas,
  `max_discount_aliquot` = 0, nenhuma OS aberta, nenhum contrato vivo).

### Questões consolidadas da Rodada 6 (numeração unificada — aguardam o Valdo)
Os dois gates acharam a MESMA porta do boleto (Q-G36) e a mesma dúvida da competência (Q-A33);
as demais do adversarial entram como Q-A36/Q-A37. Continuam abertas: **Q-A28** (§11.1),
**Q-G36**, **Q-G37**, **Q-A32**, **Q-A33**, **Q-A34**, **Q-A35** (§11.2) e:
- ~~**Q-A36**~~ (DECIDIDA: contar pelo último evento → D-A36 (Rodada 7)) Quando a Onda 2 liberar o cancelamento do ramo adjust: cancelar a nota da devolução
  deve DESFAZER os elos `tb_order_item_return` (devolvendo o saldo à venda de origem) ou manter os
  elos e exigir que o operador cancele a devolução inteira? Hoje a guarda recusa (Onda 1), então
  não há estado ruim — mas o código da Onda 2 precisa da resposta. (rec.: desfazer os elos no mesmo
  plano — o cancelamento da nota já é o ato que devolve tudo o que ela produziu)
- ~~**Q-A37**~~ (DECIDIDA: só percentual → D-A37 (Rodada 7)) Teto do desconto por ALÍQUOTA deixa 5 % de R$ 1.000.000 passar sem privilégio. Faz
  sentido um teto em VALOR por institution (ex.: desconto máximo R$ 500 sem o privilégio), somado
  ao teto em %? (rec.: sim, no mesmo Framework de Configurações — `max_discount_value`, 0 = sem
  teto em valor; a regra passa a ser "os dois tetos valem, o menor manda")

## 12. Passeio logado do "Cancelar nota" — FEITO (2026-09-13, Valdo logado no Chrome)

Conduzido pela extensão Claude in Chrome com o Valdo autenticado (o agente nunca digita senha).
Três casos, cada um conferido no banco logo depois.

| Caso | Documento | O que a tela fez | O que o banco mostra |
|---|---|---|---|
| Venda faturada SEM baixa | pedido 1000777 (id 7649), nota 6540 | botão "Cancelar nota" visível (gate `CANCELAR`), dialog pediu o motivo, ação devolveu **"Nota 6540 cancelada — o pedido voltou a aberto"** e o pedido saiu de Faturados | evento **C** com o motivo digitado apontando o E (`origin_event` 1), nota soft-deletada (nº reaproveitável — D3/D4), pedido 'A', **zero** linhas vivas em `tb_financial` |
| Venda faturada COM baixa | pedido 1000778 (id 7650), nota 6541 | o mesmo dialog, e a ação abriu o aviso **"A nota ainda não pode ser cancelada. Resolva antes: • Título 7650/1 tem baixa de 80.00 — estorne a baixa antes"** | nada mudou: pedido segue 'F' e o último evento da nota segue 'E' (o 409 tipado virou lista legível na tela) |
| OS faturada | OS nº 7017 (id 7651), nota 6542 | ícone de cancelar no AppBar do documento faturado (D-G16), mesmo dialog compartilhado dizendo "documento 7017"; depois de confirmar, a OS reapareceu em **Abertas** com o item | evento C com o motivo, nota soft-deletada, **`open_lock` restaurado para '1-209'** (a trava D5 volta — peça `@shared/service-order`), item vivo preservado, financeiro zerado |

- O dialog é o MESMO componente nos dois módulos (`app/shared/billing/cancel_invoice_dialog.dart`)
  e o texto de apoio já avisa o que precisa ser resolvido antes ("Baixas, boletos liquidados e
  devoluções precisam ser resolvidos antes").
- Dados do passeio criados e REMOVIDOS ao final (OS cancelada, baixa estornada, notas canceladas,
  pedido aberto excluído); nenhuma OS aberta ficou com a trava presa; crashlytics zero.
- Lições de condução (somam-se às de 2026-09-07/08, memória `passeio-logado-browser`):
  1. A aba da extensão nasce numa janela que pode ficar **oculta** (`visibilityState: hidden`) e
     nesse estado o Flutter **não sobe** (carrega os 1.200 scripts e para). O Valdo precisa trazer
     a janela para a frente; depois disso um reload resolve.
  2. O filtro das listas de pedido busca pelo CLIENTE, não por id/nº da nota — para achar um
     documento específico, ou paginar, ou (mais rápido) criar o caso novo, que nasce no topo.
  3. Deep link para o detalhe (`#/home/orders/<id>`) não abre o documento: cai na lista. Registrar
     como pendência de UX junto com o `CurrentInterface` por rota (L3 do socrático da Rodada 6).
  4. Confirma a lição do build debug: 3 s entre clicar no campo e digitar, senão o texto se perde.

### 11.4 D-G36 e D-G37 (Valdo, 2026-09-13: "concordo") — EXECUTADAS

- **D-G36 — a autoridade do desconto vale em TODAS as portas**. A política da D-G32 guardava só a
  baixa manual; a carteira de cobrança aceitava `aliq_discount` até 100 % sem privilégio e, com a
  D-G30, esse desconto QUITA o título (o gate adversarial provou: usuário regular quitou 100,00
  recebendo 50,00). Agora:
  - a peça virou `assertDiscountAliquot(inst, aliquota, interfaceKey)` — mesma regra (teto por
    config + privilégio DESCONTO que bypassa + admin passa), conferindo o privilégio **na interface
    de quem faz o ato**: `bank-charge-agreements` no POST/PUT da carteira, `settlements` na baixa;
  - o **seed 55** vincula o privilégio 8 às DUAS interfaces;
  - a **liquidação não acontece no futuro**: `dtPayment > hoje` → 422 `BANK_SLIP_FUTURE_PAYMENT`
    (sem isso, pós-datar ressuscitava um desconto já vencido em `dt_discount_until`). A liquidação
    em si segue livre — o desconto foi autorizado na emissão, é contrato com o banco.
- **D-G37 — `max_discount_aliquot` default 0 = "nenhum desconto sem o privilégio"** (fail-closed,
  fiel ao BX-15). A surpresa do 1º dia é tarefa de implantação: §10.3 item 4 (o seed 55 é
  pré-requisito do app — sem ele a TELA fica mais restritiva que a API até para o admin).
- Provas: 776/776 jest (novos casos na política e no boleto) · ao vivo 8/8 — regular sem privilégio
  criando carteira com 50 % → 403; carteira sem desconto passa; com o privilégio na interface da
  carteira → 200; liquidar com data futura → 422; com a data de hoje → 201 e quita.

## 13. Rodada 7 — DECIDIDA e EXECUTADA (Valdo, 2026-09-13): Q-A32…Q-A37

Respostas: **Q-A32 não · Q-A33 intencional · Q-A34 sim · Q-A35 sim · Q-A37 teto por percentual
independente de valor**. **Q-A36 FICOU ABERTA** — o Valdo questionou a premissa ("de que saldo
está falando, e por que devolver saldo à venda… tudo acontece em tempos diferentes e não podem
ter alterações"); explicação e opções em §13.1.

- **D-A32 (não)**: o backfill da migration 051 carimba o mês em que o item NASCEU, não a
  competência faturada. Fica como está — história não se reescreve; nenhum relatório de correção.
  Consequência registrada: em cliente que já reexecutou a rotina retroativamente, a competência
  realmente faturada pode aparecer livre (e ser injetada de novo, com o operador removendo o item
  extra — que agora devolve a competência, D-A34) e a do mês da corrida aparece consumida.
- **D-A33 (intencional)**: dois contratos do mesmo cliente com o MESMO produto injetam DUAS linhas
  na competência. Cada contrato cobra por si; a chave é contrato × produto × competência. Fica
  pendente de UX mostrar de qual contrato veio cada item da OS (não é decisão de modelo).
- **D-A34 (sim) — liberar a competência**: o fato gravado é "a rotina faturou o item X do contrato
  na competência Y **gerando ESTE item da OS**". Removendo o item, o fato perde o objeto: o
  `removeItem` solta a competência (soft delete) na MESMA transação e a rotina volta a injetar
  aquele mês. Não virou botão novo — é o ato que o operador já faz (remover o item); antes a
  competência ficava consumida para sempre e o cliente sem cobrança, com saída só cancelando a OS.
- **D-A35 (sim) — a varredura não trava a institution**: `monthlyRun` decide o que há para injetar
  com leituras NÃO travantes e só toma o X quando existe item a cunhar; sob o X, cada competência é
  **RE-LIDA travante** antes de injetar (o snapshot REPEATABLE READ pode ter envelhecido entre a
  varredura e o lock). A regra 7 continua honrada: o lock da institution é o 1º lock EXCLUSIVO da
  transação. Antes, a rotina tomava o X por cliente mesmo sem nada a fazer — caso comum depois da
  D-G33 — e empurrava faturamento/baixa concorrentes para 10 s.
- **D-A37 (teto por percentual, independente de valor)**: NÃO existe teto em R$ — a autoridade do
  desconto é só o percentual (config `max_discount_aliquot`) e o privilégio DESCONTO. Registrado
  como decisão consciente: 5 % de um valor grande passa sem privilégio, e a empresa aperta o
  percentual se quiser.
- Provas: **779/779** jest (novos casos: lock só quando há injetável, competência ocupada entre a
  varredura e o X, remover item libera a competência) · ao vivo **9/9** — a rotina injeta e grava o
  fato, a 2ª corrida pula, remover o item libera e a rotina reinjeta com item NOVO, e com o lock
  preso por terceiro a rotina sem trabalho responde em 0,0 s enquanto a com trabalho espera e dá
  409 em 11,6 s.

### 13.1 D-A36 — DECIDIDA (Valdo, 2026-09-13: "contar pelo último evento") e EXECUTADA

**Nada na venda é alterado por uma devolução.** A venda faturada é fato consumado e imutável: seus
itens, quantidades e a nota continuam exatamente como foram emitidos. O "saldo devolvível" NÃO é um
campo gravado na venda — é **derivado**, como o saldo do título: `quantidade vendida − Σ quantidades
das devoluções que apontam para ela`. O elo vive na devolução (`tb_order_item_return`: item devolvido
→ item vendido), nunca na venda.

**Por que a pergunta apareceu**: o gate adversarial provou um estado em que a nota de uma devolução
FATURADA era cancelada e os elos continuavam vivos — a venda de origem passava a ter saldo devolvível
ZERO para sempre, sem que nenhuma devolução válida existisse. A correção da sessão fechou a porta
(a devolução não cancela nesta onda, viva ou não a âncora), então **hoje não há estado ruim**.

**O que fica em aberto é só para a Onda 2**, quando o cancelamento do ramo de devolução for liberado:
quando a nota da devolução é cancelada, aquela devolução ainda conta como devolvida?
- **(a) Conta pelo ÚLTIMO EVENTO** — a devolução cancelada deixa de contar, do mesmo jeito que uma
  baixa estornada deixa de contar no saldo do título e uma nota cancelada deixa de existir para o
  faturamento. Nada é reescrito: os elos e os eventos ficam como história, e quem SOMA passa a somar
  só as devoluções vigentes. É o padrão da casa ("estado derivado do último evento").
- **(b) Conta para sempre** — cancelar a nota da devolução não muda o quanto já foi devolvido; para
  devolver de novo seria preciso um ato novo e explícito.
**DECIDIDA: (a) — contar pelo último evento.** Executado agora (não espera a Onda 2, porque é regra
de CÁLCULO e já protege contra resíduo): peça `CURRENT_RETURN_SQL` em `@shared/order-return` —
devolução VIGENTE = ordem de ajuste viva **E** (sem nota **OU** nota cujo último evento ≠ 'C'). Os
dois leitores do "já devolvido" passam por ela: a leitura de tela (`getReturnedQuantityByProduct`) e
o gate TRAVANTE do faturamento (`assertReturnableInTx`). Devolução ABERTA (ainda sem nota) continua
contando — o `COALESCE` cai em 'E'.

Provas: 783/783 jest (a peça tem teste próprio; o arquivo do módulo mocka a peça) · ao vivo **7/7** —
venda de 2 un faturada, devolução de 2 un faturada, 2ª devolução recusada por saldo zero; gravado o
evento **C** na nota da devolução (só o evento: os elos seguem vivos e a venda segue com 2 un, NADA
reescrito) e o saldo voltou a 2 un.

**A regra da casa que isso reafirma**: saldo é sempre DERIVADO do que está vigente — baixa estornada
sai do saldo do título, nota cancelada sai do faturamento, devolução cancelada sai do devolvido. O
passado não é alterado; muda só o que o cálculo enxerga.
