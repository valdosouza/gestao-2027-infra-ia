# Prompt — Boleto emitido (instrumento de cobrança bancária)

**Escopo**: setes
**Status**: RODADA 1 ABERTA (2026-09-03) — aguarda respostas do Valdo às Q1–Q11
**Origem**: `prompt_estrutura_boleto.txt` (DDL do TB_BOLETO_BANCARIO do legado + dúvida
de nome tb_financial_doc_slip × tb_bank_doc_slip) — resposta do Valdo à Q19 de
`prompt_contrato_financeiro_baixa_automatica.md` (Q19 = modelar agora; Q20 = b, a
escolha da conta e a geração vivem na tela do financeiro; Q21 confirmado)
**Fase**: Faturamento Fiscal e Financeiro — decisões 14/QF1 (boleto NÃO baixa no
nascimento), 13, 15, 29, 33; D18 do contrato (fluxo 0/1/n no faturamento)
**Parecer conceitual**: agente setes-conceito (2026-09-03) — resumido abaixo
**Padrão herdado**: eventos append-only + estado derivado (`prompt_cheque_rastreabilidade.md`)

## 1. Conceito

**Boleto = instrumento de cobrança bancária que representa 1..N títulos perante um
banco.** Fato gerador = a EMISSÃO. Três conceitos → três peças: o instrumento · o
vínculo com os títulos · a história.

## 2. O que o legado ensina (verificado no código)

- **BLT_CODQTC = FIN_CODQTC**, gerado pelo MESMO contador da baixa (GN_COD_BAIXA) e
  reusado como BLT_NUMERO e BLT_NOSSONUMERO: vínculo, nosso número e código da baixa
  colapsados num inteiro. Reemissão sobrescreve FIN_CODQTC (perde história);
  numeração bancária acoplada a contador interno. → morre na web.
- **Cabeçalho mutável** (BLT_BAIXA, STATUS, MSG_RETORNO, NR_REMESSA, CODRET,
  DT_PROCESSAMENTO; Un_AlteraBoleto reescreve vencimento/valor do boleto E do
  título) → viram eventos.
- **Taxas/instruções copiadas da config na emissão** — legítimo (snapshot do que
  foi emitido; o banco cobra pelo registrado). Regra "não edite a carteira com
  boletos abertos" morre por construção.
- **Agrupamento**: N títulos do MESMO cliente → 1 boleto (valor = soma, vencimento
  escolhido); faturamento automático = sempre 1 por título.
- **Baixa manual**: localiza pelo nosso número → baixa título → crédito na conta do
  boleto (histórico "RECEBIMENTO BOLETO", doc_reference = nosso número).
- Config `FIN_FAT_GER_AUTO_BOLETO` + `Config.getFirst` (primeiro registro).

## 3. Achado: a família `tb_bank_charge_*` está lida ao contrário

| Web | Legado que casa | Conceito real |
|---|---|---|
| `tb_bank_charge_slip` | TB_BOLETO_ELETRONICO | CONTRATAÇÃO de cobrança (convênio/carteira configurada) — config viva |
| `tb_bank_charge_ticket` (number, emission_by) | tb_carteira_cobranca (ctr_numero, ctr_tipo_emissao) | CARTEIRA bancária (quem emite: banco × beneficiário) |
| `tb_bank_charge_kind` (abbreviation) | tb_especie_doc (EPD_SIGLA) | ESPÉCIE do documento (DM, DS, NP…) |

Nenhum código TS consome as três hoje (só o baseline). `tb_bank_charge_slip`
lê-se como "o boleto" e é a CONFIG → colisão de leitura com o boleto emitido (Q1).

## 4. Peças propostas (schema do cliente)

**`tb_bank_slip`** (instrumento, imutável após emissão): PK (id, tb_institution_id);
tb_bank_charge_slip_id (origem), tb_bank_account_id (CONGELADA), our_number,
document_number, dt_emission, dt_expiration, value (soma dos títulos), accept,
tb_bank_charge_kind_id congelado, aliq_discount, discount_value, dt_discount_until,
aliq_interest, aliq_late, value_late_min, aliq_fine, value_fine, value_rate,
instruction text, protest_days + protest_day_kind, negativation_days (datas de
protesto/negativação DERIVADAS de vencimento + dias — não gravar), tb_user_id,
created/updated/deleted. Sem status/baixa/remessa/msg_retorno.

**`tb_bank_slip_title`** (vínculo 1:N, imutável): PK (tb_institution_id,
tb_bank_slip_id, tb_order_id, terminal, parcel); value (parcela do título dentro do
boleto); created/deleted. Sem FK física ao título (decisão 33). Um título pode ter
N boletos ao longo do tempo (cancelado → reemitido); "só 1 vigente" = validação da
composição, não UNIQUE.

**`tb_bank_slip_event`** (história, append-only): PK (tb_institution_id,
tb_bank_slip_id, event); kind char(1), dt_record, source M manual / R retorno / A
API, settled_code NULL, tb_bank_account_id NULL, paid_value NULL, dt_expiration
NULL (evento A), bank_code + bank_message NULL (CODRET/MSG_RETORNO viram atributos
do evento), origin_event NULL (X), note, tb_user_id, created.

| kind | Evento | Compõe no financeiro | Nesta onda? |
|---|---|---|---|
| E emitido | nasce na transação da emissão (único) | nada — título aberto (QF1) | sim |
| S remessa gerada | lote CNAB | nada | não (canal) |
| G registrado | banco confirmou | nada | não (canal) |
| L liquidado | baixa dos N títulos sob UM settled_code na conta congelada | settleBatch/settleOneTitle | sim (source M) |
| A alterado | novo vencimento/valor | Q6 | Q6 |
| C cancelado | libera títulos para reemissão/outra forma | nada | sim |
| X estornado | inverte L (reverseOnePayment) ou desfaz C | origin_event | sim |

Estado derivado: aberto = E sem L/C; liquidado = L sem X; cancelado = C; vencido =
aberto e vencimento vigente < hoje. Título "destinado a boleto" (FIN_SITUACAO='D')
= existe vínculo com boleto aberto — derivado, sem coluna no título.

**Composição `@shared/bank-slip`** (transaction-aware): `issueBankSlip` (config
ativa, títulos abertos do mesmo cliente sem boleto vigente, congela taxas, reserva
our_number, slip + títulos + evento E — não toca tb_financial*), `settleBankSlip`
(1 baixa para N títulos sob UM settled_code + statement na conta congelada com
doc_reference = our_number + evento L — executor CONFIRMA que settleBatch
compartilha o settled_code; settleOneTitle gera um por chamada), `cancelBankSlip`
(C; 409 se L), `reverseBankSlipSettlement` (reverseOnePayment + X; 409 se evento
posterior — espelho D10 do cheque), `tryIssueBankSlipsOnBilling` (config
`auto_bank_slip` da interface billing; conta configs ativas: 0 nada / 1 emite 1
boleto por parcela kind='B' / 2..n nada — tela do financeiro emite depois, Q20=b;
chamada pelo billing após o financeiro no SAVEPOINT existente, nunca bloqueia,
motivo só em log — D14).

**Reusos sem alteração**: tb_financial*/statement + settled_code, settleBatch/
settleOneTitle/reverseOnePayment, tb_bank_charge_* (config/catálogos),
tb_bank_account (congelada), tb_bank_historic ("RECEBIMENTO BOLETO"),
tb_payment_types.kind='B', Framework de Configurações (getConfigContent já usado no
billing.service), SAVEPOINT do billing, padrão de eventos do cheque.

## 5. Nomes

- `tb_financial_doc_slip` × `tb_bank_doc_slip`: ambos nomeiam pelo MÓDULO e "doc" é
  formato. O boleto é instrumento BANCÁRIO ("bank slip" é o termo consagrado),
  independente de a tela morar no financeiro → **`tb_bank_slip`** →
  `tb_bank_slip_title` (vínculo) → `tb_bank_slip_event` (história).
- Colisão: `tb_bank_charge_slip` (config) contém "slip". Zero consumidores TS →
  renomear é barato agora (`tb_bank_charge_agreement` — a coluna `agreement` já
  existe — ou `_setup`). Q1.
- Módulo espelhado `bank-slips` (/api/bank-slips ↔ /home/bank-slips), tela de
  PROCESSO (lista por estado derivado + emitir individual/agrupado, baixar manual,
  cancelar, estornar). Config `auto_bank_slip` (bool, default N, scope I) na
  interface billing.

## 6. Fora (e por quê)

Canal CNAB/API Inter (peça de transporte que produz eventos S/G/L com source R/A —
o boleto nasce pronto sem reforma); protesto/negativação como processo (só
dias/instruções congelados); impressão/PDF/e-mail; boleto de contas a PAGAR
(instrumento RECEBIDO — peça irmã futura); datas de protesto/negativação gravadas
(derivadas); flags mutáveis do legado; FIN_SITUACAO='D'/FIN_CODQTC no título;
`statement.future` (D13); lote de remessa como entidade (canal).

## 7. Rodada 1 — questões para o Valdo (recomendação entre parênteses)

- **Q1 Renomear `tb_bank_charge_slip` (config)** para liberar "slip" ao boleto:
  (a) `tb_bank_charge_agreement` agora (migration trivial, zero consumidores);
  (b) manter e conviver. E confirmar a leitura do §3 (ticket = carteira, kind =
  espécie) para o comentário de DDL. (rec.: a)
- **Q2 Menu**: módulo bank-slips no grupo (a) Financeiro (quem emite/baixa) ou (b)
  Banco (config de carteira segue no Banco em ambos). (rec.: a)
- **Q3 Nosso número e nº do documento**: (a) our_number = sequência por
  config/carteira (banco exige unicidade por carteira/convênio; faixa/dígito por
  banco = atributo da CONFIG) e document_number = `order_id-parcel` (o legado tinha
  isso comentado e trocou pelo CODQTC); (b) ambos = id do boleto; (c) nosso número
  informado pelo usuário (carteira emitida pelo banco). (rec.: a, com b como
  fallback sem faixa)
- **Q4 Domínio dos eventos nesta onda**: E, L, C, X (S/G reservados ao canal; A na
  Q6). E como linha de evento (uniformiza com o R do cheque)? (rec.: sim)
- **Q5 Liquidação manual**: (a) statement só do valor recebido na conta congelada;
  diferença vira interest/late/discount no tb_financial_payment (colunas existem);
  tarifa NÃO entra (é conciliação do extrato); (b) tarifa como DÉBITO no mesmo
  settled_code (espelho da taxa do cartão). Conta diferente da congelada no evento?
  (rec.: a; sem conta alternativa nesta onda)
- **Q6 Alteração de vencimento/valor** (Un_AlteraBoleto): (a) fora — cancela e
  reemite; (b) evento A que NÃO toca o título; (c) evento A que altera o título
  (legado — contradiz a decisão 13). (rec.: a agora; b agrega)
- **Q7 Escopo da onda**: peças 1–3 + @shared/bank-slip + módulo bank-slips + config
  auto_bank_slip + gancho 0/1/n no billing — SEM canal (boleto nasce e é baixado
  manualmente, um dos 3 caminhos do legado §3.5). (rec.: sim)
- **Q8 "Registros ATIVOS" da config (D18)**: a tabela só tem `deleted`. (a) ativo =
  deleted='N'; (b) adicionar `active` S/N (carteira pausada sem perder histórico,
  coerente com `enable` do vínculo de formas). (rec.: b)
- **Q9 Agrupamento**: faturamento automático = 1 boleto POR TÍTULO; agrupar só na
  tela do financeiro (mesmo cliente, vencimento único informado). Confirmar.
- **Q10 Estorno/cancelamento**: X + reverseOnePayment; 409 se evento posterior.
  Cancelamento de nota com boleto LIQUIDADO segue D7 do contrato (estorna antes);
  com boleto ABERTO exige C antes. Confirmar.
- **Q11 Ordem de execução**: (a) contrato → boleto (fecha o gancho D18) → cheque;
  (b) contrato → cheque → boleto. Os três exigem settled_code compartilhado em lote
  — executor confirma UMA vez em settleBatch antes de qualquer um. (rec.: a)

## 8. Decisões — Rodada 1 (Valdo, 2026-09-03)

- **D1 (Q1=a)** `tb_bank_charge_slip` (config) RENOMEADA para `tb_bank_charge_agreement`
  (migration; zero consumidores TS). Comentário de DDL fixa: ticket = carteira
  bancária (number + emission_by), kind = espécie do documento.
- **D2 (Q2)** Módulo `bank-slips` no grupo FINANCEIRO do menu; config de carteira
  segue no Banco.
- **D3 (Q3=a, b fallback)** `our_number` = sequência por config/carteira (faixa e
  dígito por banco = atributo da CONFIG); `document_number` = `order_id-parcel`.
  Sem faixa definida na config → ambos = id do boleto.
- **D4 (Q4)** Eventos desta onda: E emitido (linha de evento, único), L liquidado,
  C cancelado, X estornado. S/G reservados ao canal; A não existe (D6).
- **D5 (Q5=a)** Liquidação manual = statement só do valor recebido na conta
  congelada; diferença vira interest/late/discount no tb_financial_payment; tarifa
  fica para a conciliação. Sem conta alternativa nesta onda.
- **D6 (Q6=a)** Alteração de vencimento/valor FORA: cancela (C) e reemite.
- **D7 (Q7)** Escopo SEM canal: boleto nasce e é baixado manualmente.
- **D8 (Q8=b)** Config ganha coluna `active` S/N; "registros ativos" de D18 =
  active='S' AND deleted='N'.
- **D9 (Q9)** Automático = 1 boleto POR TÍTULO; agrupar só na tela do financeiro
  (mesmo cliente, vencimento único informado).
- **D10 (Q10)** X + reverseOnePayment; 409 se evento posterior. Nota com boleto
  liquidado → estorna antes (D7 do contrato); com boleto aberto → C antes.
- **D11 (Q11=a)** Ordem: contrato → boleto → cheque.

## 9. Investigação BLT_CODQTC (pedido do Valdo, 2026-09-03)

Papel no legado (verificado em Un_GeraBoleto.pas 237–285, ControllerFinanceiro
Destinar l.321, RN_Financeiro Pc_ProcessoBaixaFinanceiro l.494, Un_Baixa_Boleto
l.78–91, RN_BoletoEletronico NotasReferenciadas/PedidosReferenciados l.817–873):

1. **Amarra ANTES da baixa (vínculo)**: `Fc_GeraCod_BAixa` reserva um código;
   `Destinar` grava FIN_CODQTC + FIN_SITUACAO='D' + forma BOLETO em cada título;
   o boleto nasce com BLT_CODQTC = o mesmo código. Individual = 1 código por título
   (1:1); agrupado = 1 código para N títulos (1:N) — a tabela de boleto NÃO precisa
   de N linhas porque o JOIN `FIN_CODQTC = BLT_CODQTC` resolve. É exatamente a ideia
   que o Valdo descreve.
2. **Amarra DEPOIS da baixa (quitação)**: `Pc_ProcessoBaixaFinanceiro(valor, data,
   CODQTC)` faz `UPDATE TB_FINANCEIRO SET FIN_VL_PAGO=:valor … WHERE FIN_CODQTC=:x`
   — baixa os N títulos de uma vez pelo mesmo código; o movimento de caixa/banco
   também leva o código.
3. **Leitura**: NotasReferenciadas/PedidosReferenciados montam as referências
   impressas no boleto pelo CODQTC; Un_ContasReceberBoleto lista por JOIN no CODQTC.

Fraquezas confirmadas no código:
- **Defeito do agrupado na baixa**: o UPDATE do item 2 grava FIN_VL_PAGO = valor
  TOTAL recebido em CADA um dos N títulos (não rateia) — num boleto de 3 títulos de
  100, cada título fica com pago = 300.
- **Reemissão apaga a história**: `Destinar` sobrescreve FIN_CODQTC; o boleto antigo
  perde o elo (fica órfão) — não há como saber que o título já teve outro boleto.
- **Numeração acoplada**: o mesmo contador serve de nosso número, nº do documento e
  código de quitação; o nosso número deveria ser da carteira (banco exige).
- **Estado no título**: FIN_SITUACAO='D' é flag mutável que precisa ser desfeita
  no cancelamento.

Como o modelo da web preserva a IDEIA (uma amarra que serve para 1:1 e 1:N) sem
as fraquezas:
- **Antes da baixa**: `tb_bank_slip_title` é a amarra — 1 linha (1:1) ou N linhas
  (1:N), com o `value` de cada título dentro do boleto (rateio nasce aqui). O
  boleto tem um só `id`; consultar "quais títulos este boleto cobra" = JOIN na
  tabela de vínculo, igual ao JOIN por CODQTC do legado. Reemissão = novo boleto com
  novas linhas; o antigo (cancelado) mantém as suas → história completa.
- **Depois da baixa**: `settleBatch` já gera UM `settled_code` para N títulos
  (confirmado em settlements.repository.ts l.106–138: "settled_code N:1") e grava
  1 payment por título com o valor de cada um + 1 statement do total. O evento L
  do boleto guarda esse `settled_code` — a amarra pós-baixa é a mesma do legado,
  só que nasce NA baixa (não é reservada antes) e rateia por título.
- **Estado do título** ("destinado a boleto") = existe linha em tb_bank_slip_title
  de boleto aberto — derivado, nada de FIN_SITUACAO.
- **Nosso número** = da carteira (D3), desacoplado do contador de baixa.

Resumo: o CODQTC do legado tinha DOIS papéis (vínculo antes + quitação depois) num
só número. Na web cada papel tem sua peça — vínculo = `tb_bank_slip_title`,
quitação = `settled_code` do settleBatch — e as duas continuam servindo para 1:1 e
1:N por construção.

**Status**: RODADAS FECHADAS — pronto para refinar-prompt-arquitetura → DDL →
revisar-ddl (ordem D11: contrato → boleto → cheque).

## 10. Execução — Onda 2 ENTREGUE (2026-09-04)

**DDL** (revisar-ddl: sqlglot OK, baseline sem as tabelas, sem BOM):
- `setes-api/src/migrations/sql/039_bank_slip.sql` — RENAME tb_bank_charge_slip →
  `tb_bank_charge_agreement` (D1) + `active` (D8) + `our_number_next` (D3: faixa é
  atributo da carteira; NULL = nosso número = id); CREATE `tb_bank_slip` (cabeçalho
  imutável, taxas congeladas), `tb_bank_slip_title` (vínculo, sem FK ao título —
  decisão 33), `tb_bank_slip_event` (E/L/C/X; S/G/A reservados ao canal).
- `sql/03` blocos canônicos; `sql/48_bank_slips_seed.sql` (interface `bank-slips`
  Financial id dinâmico, contrato inst. 1, page_size, flag retroativa, config
  `auto_bank_slip` Boolean/N/I na interface `billing`). Aplicados em dev.

**API** (`setes-api`):
- REFATORAÇÃO: núcleo do lote (`settleBatchTx`), parcerias (`generatePartnershipOrders`,
  `createPaCompensation`) e `reverseOnePayment` EXTRAÍDOS de settlements.repository para
  `@shared/financial-settlement/settlement-batch.ts` (módulo nunca importa módulo — o
  boleto liquida/estorna pelo mesmo núcleo); settlements ficou com wrappers; lote ganhou
  `history`/`docReference` no statement. Tipos do lote re-exportados pela interface do módulo.
- `@shared/bank-slip`: `issueBankSlip` (carteira ativa FOR UPDATE, títulos a receber
  abertos do MESMO cliente sem boleto vigente — `hasOpenSlip` leitura TRAVANTE —, nosso
  número da faixa ou id, doc = pedido-parcela ou id, taxas/instruções congeladas, evento
  E), `settleBankSlip` (valor RECEBIDO rateado por título na proporção do vínculo,
  resíduo no último, sobra sobre a face informada como juros; 1 settled_code; statement
  com doc_reference = nosso número; evento L), `cancelBankSlip` (C, só aberto),
  `reverseBankSlipSettlement` (só último = L; recusa se título já reemitido; inverte
  todos os payments do código — 1 código de estorno por payment, X guarda o último;
  reabre), `tryIssueBankSlipsOnBilling` (0/1/n carteiras; só parcelas kind='B').
- Módulo `bank-slips` (6 arquivos): GET / (paginado por estado derivado — HAVING +
  COUNT em subquery), GET /:id (cabeçalho + títulos + eventos), POST / (emitir), POST
  /:id/settle|cancel|reverse, lookups /agreements e /open-titles. Router + defaultModules.
- Billing: `auto_bank_slip` lido pelo Framework de Configurações no service e aplicado
  no repository DEPOIS da baixa automática, em SAVEPOINT próprio (nunca bloqueia a nota).
- Testes: `bank-slip.test.ts` (16) + suíte 532/532.

**App** (agente setes-form-builder, verificado no disco — 19 arquivos + teste): módulo
`bank_slips` tela de PROCESSO (3 abas por estado, emissão com carteira + multi-seleção
de títulos filtrada pelo cliente do 1º marcado + vencimento, detalhe dirigido pelo
estado com linha do tempo e ações Baixar/Cancelar/Estornar), rotas home/interface_routes,
i18n pt/en (75 chaves); analyze limpo, flutter test 6/6.

**Smoke E2E real** (dev): faturamento com forma boleto + config ligada → 1 boleto por
parcela (nosso nº 5000 da faixa, doc 6539-1, taxas congeladas); agrupado de 2 títulos
do cliente 209 (sem vencimento → 400; com → boleto 5001 valor 200); reemitir título
vigente → 409; liquidação 203 → 1 código, juros no último, statement "RECEBIMENTO
BOLETO 5001" doc 5001; cancelar liquidado → 409; estorno → payments R, X com origem,
boleto reaberto; estorno de novo → 409; cancelamento → títulos voltam ao lookup.

**Gates** (2026-09-04): 1ª rodada REPROVOU (socrático 0.68, adversarial 0.58 com 3
HIGH). Corrigidos em sessão: juros ficavam FORA do statement (rateio passou a ser do
valor recebido, líquido); paidValue 0.004 liquidava com zero e 1e12 era truncado (DTO
min 0.01 / max 99.999.999,99 + guarda na peça); `hasOpenSlip` lia sob snapshot (→ FOR
UPDATE — corrida real 3 POSTs = 1×201 + 2×409); estorno com título reemitido deixava
2 vigentes (→ 409 BANK_SLIP_TITLE_REISSUED). RE-SCORE: **socrático 0.80 ✅ ·
adversarial 0.82 ✅ passou** (3 HIGH provados corrigidos no dev).

## 11. Rodada 2 — questões dos gates (aguardam o Valdo)

- **Q-B1 Título com boleto VIGENTE baixado por outro meio na tela de Baixas**: (a)
  bloqueia 409 até cancelar o boleto (equivale ao FIN_SITUACAO='D' do legado); (b)
  permite e a liquidação do boleto rebaixa pelo SALDO atual (ignora o rateio congelado);
  (c) permite e o excedente vira crédito do cliente. Hoje: permite e o boleto liquidado
  paga o título duas vezes. (rec.: a)
- **Q-B2 Liquidação com valor MENOR que a face**: (a) diferença = desconto no payment
  (D5 literal — título quita); (b) parcial: título fica com resíduo e o boleto encerra
  'settled' (atual); (c) 409 abaixo de face − desconto congelado. (rec.: c)
- **Q-B3 Após o X o boleto volta a 'open'** e conta como vigente/vencido, e C é permitido
  após X — é o desejado, ou X deveria levar a estado próprio ("liquidação estornada")?
  (rec.: manter open — o banco ainda o tem registrado; só C encerra)
- **Q-B4 Emissão automática**: evento E com `source` próprio ('A' = automático) para
  distinguir da tela? E a tela de Boletos ganha o mesmo retry em deadlock (D-G4) do
  billing? (rec.: sim aos dois — 'A' redefinido como "automático/API")
- **Q-B5 D10 sem ponto de aplicação**: cancelamento de nota (Process C00–C05) ainda não
  existe na web — registrar "nota com boleto aberto exige C; liquidado exige X" como
  pré-requisito daquela fase. (rec.: sim)
- LOWs registrados (sem decisão): dtExpiration no passado e dtPayment no futuro aceitos;
  `our_number` sem UNIQUE (faixa editada para trás pode colidir); config `auto_bank_slip`
  só é editável pela tela se a interface `billing` (kind R) estiver contratada pela
  institution (hoje 403 — mesma situação de invoice_serie); JSON malformado → 500
  genérico (handler global); códigos BANK_SLIP_*/AGREEMENT_* fora do catálogo
  error-codes.ts; listas com subqueries correlacionadas de estado (escala — junto com
  Q-G5 do contrato); rateio patológico (N ≥ 4 títulos com valor ínfimo) — coberto por Q-B2.
- Pendências de produto: **cadastro da CARTEIRA de cobrança** (tb_bank_charge_agreement
  não tem módulo/tela — o smoke inseriu por SQL); canal CNAB/API (S/G/A); dado dev
  `tb_payment_types 6 "BOLETO"` corrigido para kind 'B' pelo smoke.

## 12. Execução da Rodada 2 (2026-09-04) — TODAS as decisões EXECUTADAS

- **D-B1 (Q-B1=a)**: guarda movida para `settleBatchTx` (`@shared/financial-
  settlement/settlement-batch.ts`) — antes de baixar CADA título do lote, leitura
  TRAVANTE (FOR UPDATE) em tb_bank_slip_title/tb_bank_slip_event; se houver boleto
  com último evento ∉ {L, C} e diferente do `allowedBankSlipId`, 409
  TITLE_HAS_OPEN_SLIP. `settleBankSlip` passa `allowedBankSlipId: slip.id` (a
  liquidação do PRÓPRIO boleto é a única exceção autorizada). Consulta direta às
  tabelas do boleto (sem importar o módulo bank-slip — evita ciclo, já que
  bank-slip importa `settleBatchTx`). Provado no dev: POST /api/settlements com
  título 6540/1 (boleto 13 vigente) → 409 TITLE_HAS_OPEN_SLIP.
- **D-B2 (Q-B2=c)**: `settleBankSlip` recusa (409 BANK_SLIP_BELOW_MINIMUM) pagamento
  abaixo de `value − discount_value` — desconto só válido se `dtPayment ≤
  dt_discount_until` (congelados na emissão). Checagem ANTES da consulta de
  vínculos (falha mais cedo, sem depender deles). Provado: boleto de 100 sem
  desconto → 50 recusado, 100 aceito.
  D-B3 (Q-B3=manter): confirmado sem mudança de código — X reabre o boleto (open),
  C permitido depois. Provado: reverse → state 'open' → cancel → 200.
- **D-B4 (Q-B4=ok)**: `source` da emissão AUTOMÁTICA (gancho do faturamento) passou
  de 'M' para **'A'** (redefinição do domínio: M manual / R retorno canal /
  A automático — faturamento ou futura API). Retry em deadlock (ER_LOCK_DEADLOCK,
  até 3 tentativas) extraído para peça nova `@shared/db/deadlock-retry.ts`
  (`withDeadlockRetry`) e aplicado nos DOIS lados: `billing.repository.persistInvoice`
  (refatorado, mesmo comportamento) e no módulo `bank-slips` (issue/settle/cancel/
  reverse — `inTx` da rodada anterior ganhou o wrapper). Provado: faturamento com
  auto_bank_slip ligado → evento E do boleto com source 'A'.
- **D-B5 (Q-B5=sim)**: registrado como PRÉ-REQUISITO da futura fase de cancelamento
  de nota (Process C00–C05 do legado) — "nota com boleto ABERTO exige C antes; com
  boleto LIQUIDADO exige X antes" (espelha D7 do contrato financeiro). Sem código
  hoje: cancelamento de faturamento não existe na web (verificado).
- Catálogo de erros: os códigos do contrato financeiro e do boleto (18 códigos —
  FINANCIAL_CONTRACT_*, AGREEMENT_*, TITLE_*, BANK_SLIP_*) entraram em
  `shared/errors/error-codes.ts` (achado LOW do gate adversarial, corrigido).
- Testes novos: `settlement-batch.test.ts` (5 — guarda D-B1), `deadlock-retry.test.ts`
  (4), `bank-slip.test.ts` +6 (D-B2 mínimo, D-B4 source A). Suíte final: **546/546**.

**Status**: Rodada 2 FECHADA. Onda 2 do boleto (emissão/liquidação/cancelamento/
estorno + as 5 decisões da rodada) está completa. Código NÃO commitado.

## 13. Cadastro da CARTEIRA de cobrança — ENTREGUE (2026-09-04)

Pendência de produto apontada em §11 fechada: `tb_bank_charge_agreement`
(a "carteira de cobrança" — contratação com o banco que o boleto congela na
emissão) não tinha tela; o smoke a alimentava por SQL direto.

**Módulo**: `bank-charge-agreements` (cadastro comum lista+form, NÃO tela de
processo — molde `bank-accounts`). 6 arquivos API + 14 arquivos app + seed 49
(interface grupo Financial, page_size, flag retroativa, catálogo de campos —
molde seed 47). Sem migration nova (a tabela já existia desde a 039).

**Campos expostos** (só os que `@shared/bank-slip` realmente consome — teste do
fato gerador): convênio, conta corrente (FK), ativa (D8), aceite, encargos
(desconto/juros/mora/mora mínima/multa %/multa fixa/tarifa), instrução,
protesto + dias (obrigatório junto — `.refine` no DTO), próxima sequência do
nosso número (D3). `tb_bank_charge_kind_id`/`tb_bank_charge_ticket_id` ficam de
FORA do formulário — catálogos vazios sem consumidor hoje (kind = espécie do
documento, ticket = carteira bancária); nascem 0 e a frente do canal CNAB os
expõe quando tiver conteúdo. Campos de remessa (layout, transmission_code,
path_files...) também ficam fora — D7, canal fora desta onda.

**Smoke E2E real** (dev + browser): lista, lookup de contas, GET do registro
existente (taxas congeladas visíveis), POST com conta inexistente → 400,
POST válido, aparece no lookup `/bank-slips/agreements` (ativa por padrão),
PUT desativando → some do lookup, PUT com protesto sem dias → 400 com o campo
certo, DELETE → 404 em seguida. Validado visualmente: toggle de protesto
mostra/esconde o campo de dias, mensagem "Informe os dias para protesto" pela
ponte do Framework de Mensagens, criação e exclusão completas na tela.

Testes: `bank-charge-agreements.test.ts` (9). Suíte final: **556/556**.
