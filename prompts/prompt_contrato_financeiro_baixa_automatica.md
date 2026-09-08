# Prompt — Contrato de Liquidação (baixa automática por forma de pagamento)

**Escopo**: setes
**Status**: RODADA 1 ABERTA (2026-09-03) — aguarda respostas do Valdo às Q1–Q10
**Origem**: `Prompt_tratamento_Contrato_Finaceiro_para baixa_automatica.txt` (rascunho do Valdo)
**Fase**: Faturamento Fiscal e Financeiro — W3 item 2 (meios de pagamento), decisão 27 (cartão com contrato = onda 2)
**Parecer conceitual**: agente setes-conceito (2026-09-03) — resumido abaixo

## 1. O que o Valdo pediu

Generalizar o TB_CARTAOELETRONICO do legado num "contrato financeiro" que diga
qual forma de pagamento tem baixa automática, para onde o dinheiro cai (conta
corrente; caixa se `tb_bank_account_id = 0`), com taxa (`fee_rate`) e prazo
(`payment_term`), planos de crédito/débito, validade e nota.

Regras dele:
1. Baixa automática em caixa só com caixa do usuário aberto.
2. Baixa automática em banco só se a conta corrente existir.
3. Faturamento NUNCA é proibido — sem condição, o financeiro nasce em aberto.
4. Forma sem contrato vai ao financeiro sem tratamento.

## 2. O que já existe na web (verificado)

- `tb_payment_types.kind` tipado (migration 027): E espécie, X PIX, Q cheque,
  B boleto, W carteira, C cartão, O outros.
- `tb_institution_has_payment_types`: enable, max_parcels, tef,
  tb_financial_plans_id_cre/deb (defaults usados por `settleBatch`), usage_preference A/C/B.
- `@shared/financial-settlement`: `settleOneTitle` (bankAccountId 0 = caixa no
  MOVIMENTO, cashierId), `tryAutoSettleCash` só kind E (NOT_CASH / BANK_PREFERRED /
  NO_OPEN_CASHIER — nunca bloqueia), billing chama por parcela dentro de SAVEPOINT.
- `tb_financial_statement` já tem `future`, `dt_original`, `conferred` — sem produtor.
- `tb_bank_account`, `tb_cashier`, `tb_order_installment` (decisão 25) existem.
- PIX declarado "frente própria, ainda não implementada".

## 3. Achados do legado que mudam a leitura do rascunho

1. **CTE_*_CRED × CTE_*_DEBI = À VISTA × PARCELADO**, não crédito × débito.
   O .dfm rotula "Pagamento à vista" / "Pagamento Parcelado"; o código usa o par
   "cred" quando parcelas = 1 e "debi" quando > 1. O tipo do cartão é CTE_TIPO
   (descartado pelo Valdo). Logo "ignorar debi" = colapsar taxa/prazo do parcelado
   na do à vista (→ Q3).
2. **A validade nunca é consultada**: `getbyFormaPagto` filtra só por forma e pega o
   PRIMEIRO registro. Na prática, 1 contrato por forma, sem vigência (→ Q2).
3. **"Lançamento futuro" do legado é só a DATA no futuro**: `Pc_LancaValorCartao`
   passa VL_FUTURO = 0, DT_ORIG = data prevista, CONFERIDO = 'N', data do
   movimento = hoje + prazo × i. A coluna `future` da web não herda semântica (→ Q6).
4. Por parcela: CRÉDITO do valor (plano crédito do contrato, centro de custo da
   forma) + DÉBITO da taxa "Taxa Desconto" (valor × aliq). TB_CARTAO condicionado a config.

## 4. Parecer conceitual (setes-conceito)

**Conceito**: contrato de liquidação = acordo desta institution com um terceiro
(adquirente/banco) que define em qual conta, com que prazo e a que custo o dinheiro
de uma forma de pagamento cai. Fato gerador = o acordo com a contraparte.

**Caixa não tem contraparte** → na leitura conceitual caixa NÃO é destino de
contrato; espécie cai no caixa por natureza (kind E, já implementado). O sentinela
0 é legítimo no MOVIMENTO (statement, precedente MVF_CODCTB=0); promovê-lo a
destino de contrato é maquete (mesma rejeitada no parecer do Caixa §5.4b).

**Teste da maquete no rascunho literal**: exigiria "só 1 contrato vigente por
forma", metade das colunas vazias para PIX/espécie, FK pulada para o 0.

**Refeito para a regra morrer por construção**: contrato SEMPRE aponta conta real
(FK física); caixa = ausência de contrato para kind E; 1 contrato por forma via PK
compartilhada com o vínculo (sem id, sem regra de vigência); presença do contrato =
baixa automática bancária (padrão "presença = incidência", decisão 1).

**Peça**: `tb_settlement_contract` (nome em Q8), PK (tb_institution_id,
tb_payment_types_id) = especialização do vínculo, no schema do cliente; colunas
tb_bank_account_id NOT NULL (FK), fee_rate DECIMAL(5,2), payment_term INT (dias),
expiration_date DATE NULL, note TEXT NULL, padrão created/updated/deleted.
Opcional (Q3): `tb_settlement_contract_tier (…, parcels_up_to, fee_rate, payment_term)`.

**Composição**: `tryAutoSettleByContract` em `@shared/financial-settlement` = lê
contrato → gates graciosos → `settleOneTitle` (com `dtRecord` futuro — parâmetro
opcional a AGREGAR) + DÉBITO da taxa no MESMO `settled_code` (estorno em cadeia da
decisão 15 inverte os dois; executor confirma que `reverseOnePayment` inverte
todas as linhas do settled_code). `tryAutoSettleCash` permanece; billing chama as
duas por parcela no SAVEPOINT existente.

**Regras 1–4 mapeadas**: (1) já vive em tryAutoSettleCash; (2) FK + gate
BANK_ACCOUNT_INACTIVE (soft-delete); (3) gates devolvem {settled:false, reason};
(4) NO_CONTRACT = título aberto — presença decide, sem flag.

**Fora**: TB_CARTAO (identificação/autorização — conciliação), conciliação
automática (`conferred`), TEF (decisão 18), cheque/boleto (decisões 14/17 — 422 no
cadastro por kind), W/O, CTE_DESCRICAO/TIPO/FONE, planos no contrato (Q5).

Motivos propostos: NO_CONTRACT | KIND_NOT_ELIGIBLE | CONTRACT_EXPIRED | BANK_ACCOUNT_INACTIVE.
Módulo espelhado: `settlement-contracts` → /api/settlement-contracts = /home/settlement-contracts.

## 5. Rodada 1 — questões para o Valdo (recomendação do parecer entre parênteses)

- **Q1 Caixa entra no contrato?** (a) rascunho: contrato universal, bank_account 0 =
  caixa — espécie passaria a EXIGIR contrato para baixar no caixa, invertendo o W3.2
  entregue. (b) contrato = só destino bancário; espécie continua no caixa por
  natureza; contrato em forma E = "esta espécie cai no banco X" (dá conteúdo ao
  usage_preference B, que hoje devolve BANK_PREFERRED sem conta). (rec.: b —
  e decidir se usage_preference se aposenta ou vira só preferência de tela)
- **Q2 Validade: histórico ou informação?** (a) como o legado: informativa, 1
  contrato por forma, troca de taxa = editar. (b) vigências com id + valid_from,
  N por forma. E contrato vencido: (i) baixa e alerta, (ii) NÃO baixa —
  CONTRACT_EXPIRED, título aberto, (iii) bloqueia a forma. (rec.: a + ii)
- **Q3 Taxa/prazo únicos ou por faixa de parcelas?** (a) únicos (rascunho) — faixa
  futura REFORMA. (b) `tb_settlement_contract_tier` desde já, 1 faixa = à vista.
  (rec.: b pelo teste "agrega ou reforma")
- **Q4 Data prevista do dinheiro.** (a) due_date da parcela + payment_term.
  (b) legado literal: hoje + payment_term × i. (c) com faixas: due_date + term da
  faixa. Ligado: tb_order_installment representa as parcelas do CARTÃO? (rec.: a se
  Q3=a, c se Q3=b; sim para installment)
- **Q5 Planos financeiros da taxa.** (a) contrato sem planos, tudo pelo cre/deb do
  vínculo. (b) contrato com UM plano só para a taxa. (rec.: b)
- **Q6 Movimento futuro.** (a) fidelidade: dt_record futuro, future='N'. (b)
  dt_record futuro, future='S', dt_original = data do faturamento, conferred='N';
  transição S→N só como EVENTO. (rec.: b)
- **Q7 Comunicação dos gates.** (a) envelope do faturamento lista por parcela
  {parcel, settled, reason} + 1 aviso no app. (b) além disso, estado novo no título.
  (rec.: a)
- **Q8 Nome.** tb_financial_contract colide em conceito com tb_contract (Software
  House, contraparte oposta). Alternativas: tb_settlement_contract /
  tb_payment_type_contract. (rec.: tb_settlement_contract, módulo settlement-contracts)
- **Q9 Formas elegíveis.** kind ∈ {X, C} (+ E se Q1=b); O fora pela 027; Q/B fora
  pelas decisões 14/17. Confirmar se O pode ter contrato (vale-alimentação).
- **Q10 Escopo da entrega.** API (peça + módulo + seed) + tela nesta onda; billing
  ganha tryAutoSettleByContract no laço existente; conciliação/TB_CARTAO/estorno de
  taxa = frente própria. Depois das respostas: refinar-prompt-arquitetura → DDL →
  revisar-ddl.

## 6. Decisões — Rodada 1 (Valdo, 2026-09-03)

- **D1 (Q1=a) Contrato UNIVERSAL**: `tb_bank_account_id = 0` = caixa. A presença do
  contrato é o ÚNICO gatilho de baixa automática, para qualquer forma — inclusive
  espécie (contrato conta 0, taxa 0, prazo 0 = cai na hora no caixa) e PIX (contrato
  com a conta, taxa 0, prazo 0 = cai na hora no banco). Consequência: `tryAutoSettleCash`
  (baixa por kind='E' sem contrato) é ABSORVIDO pelo caminho do contrato — espécie
  sem contrato passa a ir ao financeiro sem tratamento (regra 4). O gate "caixa do
  usuário aberto" continua valendo para conta 0 (regra 1).
- **D2 (Q2=a) Validade INFORMATIVA**: 1 contrato por forma (PK compartilhada com o
  vínculo institution × forma), sem vigência; troca de taxa = editar.
  Comportamento do contrato VENCIDO fica para a Rodada 2 (Q11).
- **D3 (Q3) Taxa e prazo ÚNICOS** (`fee_rate`, `payment_term`) — sem faixa de
  parcelas. Registrado: se faixa for exigida no futuro, REFORMA (taxa sai do cabeçalho).
- **D4 (Q4) Dois credores distintos**: `tb_order_installment` = NEGOCIAÇÃO com o
  cliente. A baixa via contrato QUITA o título do cliente (ele não deve mais nada);
  a partir daí quem deve é a operadora → o lançamento na conta corrente nasce com
  data futura (prazo do contrato) já líquido das taxas. Ponto de contagem do prazo
  na Rodada 2 (Q12).
- **D5 (Q5) Planos do VÍNCULO**: o contrato NÃO tem planos próprios — crédito da
  parcela usa `tb_institution_has_payment_types.tb_financial_plans_id_cre`, débito da
  taxa usa `tb_financial_plans_id_deb`.
- **D6 (Q6) Semântica do extrato**: `dt_record` = data em que o dinheiro estará
  DISPONÍVEL; `dt_original` = data do FATO GERADOR (faturamento). Marca `future`
  na Rodada 2 (Q13).
- **D7 (Q7) — regra de CANCELAMENTO registrada** (o Valdo respondeu ao cancelamento):
  NÃO se cancela faturamento com financeiro BAIXADO — primeiro estorna-se o
  financeiro, depois libera-se o cancelamento da nota. Hoje não existe cancelamento
  de faturamento no billing (verificado 2026-09-03); a regra vale para quando a frente
  nascer. O envelope de resposta do faturamento (Q7 original) fica para a Rodada 2 (Q14).
- **D8 (Q8) Nome**: aguarda explicação da colisão (Rodada 2, Q15).
- **D9 (Q9) Elegibilidade pela PRESENÇA do contrato**, não pelo kind: existe contrato
  vinculado à forma → baixa automática. Conflito com cheque/boleto na Rodada 2 (Q16).
- **D10 (Q10) Escopo confirmado**: API (peça + módulo + seed) + tela + billing nesta
  onda; TB_CARTAO e TEF FORA. Conciliação segue frente própria.

## 7. Rodada 2 — questões abertas (2026-09-03)

- **Q11 Contrato vencido** (`expiration_date < hoje`): (i) baixa e avisa, (ii) NÃO
  baixa — título nasce aberto com motivo CONTRACT_EXPIRED, (iii) bloqueia a forma no
  pedido. (rec.: ii — coerente com a regra 3)
- **Q12 De onde conta o prazo** para cartão parcelado (contrato único, D3): (a)
  vencimento de CADA parcela negociada + `payment_term` (3x 30/60/90 + prazo 30 =
  60/90/120); (b) legado literal: data do faturamento + `payment_term` × i, ignorando
  o vencimento negociado. (rec.: a — reaproveita a negociação da decisão 25)
- **Q13 Marca `future`**: (a) `future='S'` enquanto `dt_record > dt_original`, virando
  'N' por EVENTO de conciliação (frente própria); saldo "disponível hoje" exclui
  future='S'. (b) não marcar — só a data futura, como o legado. (rec.: a)
- **Q14 Resposta do faturamento** (não é cancelamento): hoje POST /api/billing/invoice
  devolve só `autoSettled` (contagem). (a) passa a listar por parcela
  `{parcel, settled, reason}` e o app mostra 1 aviso ("2 parcelas em aberto: sem
  caixa aberto"); (b) manter contagem. (rec.: a)
- **Q15 Nome** (ver explicação no chat): manter `tb_financial_contract` /
  `financial-contracts` ou `tb_settlement_contract` / `settlement-contracts`.
- **Q16 Cheque/boleto com contrato**: D9 diz "presença decide", mas as decisões 14
  (cheque = dívida própria, baixa na compensação) e 17 (boleto baixa por retorno)
  proíbem baixa no nascimento. (a) 422 ao cadastrar contrato para kind Q/B — regra
  morre por construção; (b) permitir e o usuário assume. (rec.: a)
- **Q17 usage_preference** (A/C/B do vínculo): com D1 o destino vem do contrato —
  (a) aposentar a coluna (migration); (b) manter só como preferência de tela. (rec.: a)

## 8. Decisões — Rodada 2 (Valdo, 2026-09-03)

- **D11 (Q11) Contrato vencido**: AVISA e gera o financeiro em ABERTO (motivo
  CONTRACT_EXPIRED; nunca bloqueia).
- **D12 (Q12) Prazo conta do FATURAMENTO**: data do faturamento + `payment_term` × i
  (legado literal); o vencimento negociado na tb_order_installment NÃO entra na conta.
- **D13 (Q13) Sem marca `future`**: a própria `dt_record` (data disponível) é o
  controle; `dt_original` = fato gerador (D6). A coluna `future` continua sem produtor.
- **D14 (Q7/Q14) Resposta do faturamento = só "pedido faturado com sucesso"**: o
  envelope NÃO lista parcelas nem motivos de não-baixa. Saber quem tem baixa
  automática é conhecimento de uso do sistema (D9 §Q9). O motivo fica só em log.
- **D15 (Q8/Q15) Nome**: `tb_financial_contract`, módulo `financial-contracts`
  (/api/financial-contracts ↔ /home/financial-contracts). Rótulo da tela deve
  distinguir do contrato comercial do Software House (`tb_contract`).
- **D16 (Q16) Cadastro NÃO recusa contrato por kind**: o usuário assume. Mas o
  comportamento por forma foi FIXADO pelo Valdo (D17), então contrato em cheque/
  boleto não muda o fluxo dessas formas.
- **D17 (Q17) `usage_preference` APOSENTADA** (migration + seed 15 + peça
  financial-settlement + payment-types).
- **D18 (Q9) Modelo de baixa por forma — o contrato define SÓ como acontece a baixa
  automática**; quem tem ou não baixa é conhecimento de uso do sistema:
  - **Cheque**: baixa automática no faturamento, valor vai para o CAIXA (exige caixa
    aberto — decisão 19). O cliente não deve mais o faturamento; passa a dever o
    CHEQUE, que segue fluxo próprio (custódia/compensação/devolução — onda do cheque,
    decisão 17). Regra por kind='Q', independente de contrato.
  - **Boleto**: só baixa na COMPENSAÇÃO (retorno). Ganha CONFIGURAÇÃO no financeiro
    "gerar boleto automaticamente no faturamento" (legado FIN_FAT_GER_AUTO_BOLETO →
    Framework de Configurações). Fluxo: conta registros ATIVOS em `tb_bank_charge_slip`
    da institution — 0: só financeiro; 1: financeiro + gera o boleto por aquele
    registro; 2..n: usuário escolhe a conta corrente para gerar. Referência:
    `un_fatura_vda.pas` ValidaGeraroBoletoAutomatico / GeraroBoletoAutomatico
    (legado usa o PRIMEIRO registro; a escolha 2..n é evolução).
  - **Demais formas** (espécie, PIX, cartão, carteira, outros): com contrato → baixa
    conforme o contrato (conta 0 = caixa, exige caixa aberto; conta real = banco, com
    taxa/prazo); sem contrato → só registra o financeiro.

## 9. Rodada 3 — gaps que sobraram (2026-09-03)

- **Q18 Cheque nesta onda ou na onda do cheque?** Não existe `tb_check` na web. Baixar
  o título no caixa SEM registrar o cheque deixa a dívida do cliente sem portador
  (o elo origem da decisão 17). (a) cheque fica FORA desta onda (como hoje: só
  financeiro), nasce inteiro na onda do cheque; (b) baixa no caixa já nesta onda e o
  registro do cheque vem depois. (rec.: a)
- **Q19 Boleto automático: mesma onda ou frente própria?** Não existe tabela de
  boleto emitido na web (só `tb_bank_charge_slip`/kind/ticket = configuração). Gerar
  o boleto exige modelar o boleto (número, nosso número, remessa/retorno) — é a
  frente da compensação. (a) nesta onda só a CONFIGURAÇÃO + o gate 0/1/n no
  faturamento é registrado no prompt; geração vira frente própria seguinte;
  (b) modelar o boleto agora. (rec.: a)
- **Q20 Onde vive a escolha da conta (2..n)?** Se Q19=b: (a) o payload do
  faturamento leva `chargeSlipId` e o validate devolve as opções; (b) tela do
  financeiro depois do faturamento. (só se Q19=b)
- **Q21 Espécie via contrato (D1) × legado**: no legado DINHEIRO ia ao caixa SEM
  contrato (como o cheque). Confirmar que na web a espécie EXIGE contrato com conta 0
  (sem contrato = só financeiro), diferente do cheque que é fixo por kind.

## 10. Decisões — Rodada 3 (Valdo, 2026-09-03) — CONTRATO FECHADO

- **D19 (Q18) Cheque = onda própria**: `prompt_cheque_rastreabilidade.md` (fechado).
- **D20 (Q19) Boleto emitido MODELADO agora** em frente própria:
  `prompt_boleto_emitido.md` (rodada 1 aberta). Nesta onda do contrato o billing
  só ganha o gancho 0/1/n via composição `tryIssueBankSlipsOnBilling` quando a onda
  do boleto entregar.
- **D21 (Q20=b) Escolha da conta (2..n) e geração vivem na TELA DO FINANCEIRO**
  depois do faturamento — não no payload do billing.
- **D22 (Q21) Espécie EXIGE contrato com conta 0**; sem contrato = só financeiro.
  Cheque é o único fixo por kind (D18).

**Status**: RODADAS FECHADAS — pronto para refinar-prompt-arquitetura → DDL →
revisar-ddl. Ordem de execução em decisão na Q11 do boleto.

## 11. Execução — Onda 1 ENTREGUE (2026-09-03/04)

**DDL** (revisar-ddl: sqlglot OK, baseline não tinha a tabela, sem BOM):
- `setes-api/src/migrations/sql/038_financial_contract.sql` — `tb_financial_contract`
  (PK institution+forma = especialização do vínculo, FK composta para
  tb_institution_has_payment_types; conta 0 sentinela sem FK; fee_rate DECIMAL(5,2);
  payment_term dias; expiration_date; note) + `DROP COLUMN usage_preference` (D17).
- `sql/03` bloco canônico + coluna removida; `sql/14`/`15` linha do campo removida;
  `sql/46_financial_contracts_seed.sql` (interface `financial-contracts` id DINÂMICO,
  grupo Financial, contrato institution 1, page_size, flag retroativa, remove o campo
  usage_preference do catálogo); `sql/47_financial_contracts_fields_seed.sql`
  (catálogo de campos, id por i18n_key). Tudo aplicado em dev.

**API** (`setes-api`):
- `@shared/financial-settlement`: `settleOneTitle` ganhou `dtRecord`/`history`/planos
  (retorna operation+paymentTypeId); `getFinancialContract`; `tryAutoSettleByContract`
  (gates graciosos NO_CONTRACT | KIND_FIXED (Q/B) | CONTRACT_EXPIRED | NO_OPEN_CASHIER |
  BANK_ACCOUNT_NOT_FOUND; crédito com dt_record = faturamento + prazo × parcela e
  dt_original = faturamento; DÉBITO da taxa no MESMO settled_code, só em títulos a
  receber); `findOpenCashierIdTx` (sessão lida NA transação com FOR UPDATE);
  `addDaysIso`. **`tryAutoSettleCash` REMOVIDA** (absorvida — D1/D22).
- `billing.repository`: laço por parcela chama o contrato (data LOCAL do faturamento);
  motivos só em log (D14); deadlock (1213) propaga — savepoint não sobrevive.
- `settlements.repository.reverseOnePayment`: inverte TODAS as linhas do settled_code
  (satélite da taxa) quando o código morre — estorno em cadeia (decisão 15) íntegro.
- Módulo `financial-contracts` (6 arquivos; :id = paymentTypeId; 409
  FINANCIAL_CONTRACT_EXISTS, revive de soft-deletado, 400 PAYMENT_TYPE_NOT_LINKED /
  BANK_NOT_FOUND, lookups /payment-types (hasContract) e /bank-accounts; DTO recusa
  data de calendário inexistente e taxa com 3 casas); router + defaultModules.
- `payment-types` + `@shared/payment-types`: usagePreference aposentada.
- Testes: 514/514 (financial-settlement 21, financial-contracts 12, billing patch).

**App** (`setes-app`, agente setes-form-builder, verificado no disco): módulo
`financial_contracts` (15 arquivos: lookup datasource DEDICADO, rádio Caixa × Conta,
forma somente-leitura na edição, helpers D11/D16/D18), rotas home/interface_routes,
i18n pt/en; `payment_types` sem usagePreference. `flutter analyze` limpo; validação
visual no browser (lista, edição, criação, lookup de formas) OK.

**Smoke E2E real** (dev): cartão (forma 2, conta 1, 2.5%, 45d) → invoice baixou com
crédito em hoje+45 e débito 2.50 no mesmo código, stage B; espécie (forma 1, conta 0,
caixa 3 aberto) → statement conta 0 com tb_cashier_id, sem taxa, stage C; estorno →
crédito E taxa invertidos (status E + 2 linhas R com origin), título reaberto.

**Gates** (2026-09-03): socrático **0.72 ✅**; adversarial **0.74 ✅ passou** (sem
HIGH/CRITICAL). Corrigidos EM SESSÃO: deadlock dentro do SAVEPOINT (propaga com log
claro), sessão de caixa lida pelo pool fora da transação (→ findOpenCashierIdTx FOR
UPDATE), expiration_date inexistente gravava 0000-00-00 (DTO refina data real),
arredondamento half-up da taxa (1.005 → 1.01) + taxa com 3 casas recusada, forma
aposentada no catálogo aceitava contrato (assertLink checa pt.deleted), comentário
estale do autoSettled, data do faturamento em UTC (→ local).

## 12. Rodada 4 — questões dos gates (aguardam o Valdo)

- **Q-G1 Conta 0 com prazo/taxa**: o cadastro deve RECUSAR (422) payment_term > 0 ou
  fee_rate > 0 quando a conta é 0 (D4/D22 "cai na hora" morre por construção), ou o
  caixa aceita dinheiro futuro e taxa? Hoje o fechamento de caixa soma a sessão sem
  olhar dt_record. (rec.: recusar)
- **Q-G2 Ciclo de vida contrato × vínculo/conta**: desvincular a forma ou excluir a
  conta com contrato vivo → (a) 409 FINANCIAL_CONTRACT_IN_USE; (b) cascata: contrato
  soft-deletado junto; (c) manter (órfão visível na lista, ignorado no faturamento —
  NO_CONTRACT/BANK_ACCOUNT_NOT_FOUND só em log —, revive no revínculo). (rec.: a)
- **Q-G3 Estorno de crédito FUTURO**: o inverso herda o dt_record do original (anula
  na data de disponibilidade) ou nasce em CURDATE() como hoje (saldo disponível fica
  negativo até a data)? E o inverso de espécie leva tb_cashier_id — da sessão original
  ou da aberta do usuário? (rec.: herdar dt_record; sessão aberta do usuário, 409 sem caixa)
- **Q-G4 Deadlock no laço de baixa**: aceitar que 1213 derruba a nota (cliente
  refaz) ou o billing reexecuta a transação N vezes antes do 5xx? (resiliência)
- **Q-G5 Escala do MAX+1**: settled_code/statement id são MAX+1 FOR UPDATE por
  institution (3× por parcela) — padrão da casa, sem índice dedicado em
  (tb_institution_id, settled_code). Medir/indexar agora ou aceitar até a conciliação?
### Decisões da Rodada 4 (Valdo, 2026-09-04) — EXECUTADAS

- **D-G1 (Q-G1) RECUSAR**: contrato com conta 0 e prazo > 0 ou taxa > 0 → 422
  `FINANCIAL_CONTRACT_CASH_NO_TERMS` com fields (service, antes do banco). Caixa
  "cai na hora" por construção.
- **D-G2 (Q-G2) SOFT DELETE em cascata**: desvincular a forma (payment-types DELETE)
  ou excluir a conta corrente (bank-accounts DELETE) soft-deleta o contrato na MESMA
  transação. Revincular a forma NÃO revive o contrato (recriar pelo cadastro — POST
  revive com os dados novos).
- **D-G3 (Q-G3) HERDA**: o statement inverso do estorno herda `dt_record` e
  `tb_cashier_id` do original (crédito futuro anula na data de disponibilidade;
  espécie estorna na sessão de origem); `dt_original` = hoje (fato gerador do estorno).
  Vale para a linha principal e para os satélites (taxa).
- **D-G4 (Q-G4) REEXECUTAR**: `persistInvoice` reexecuta a transação inteira até 3
  vezes em ER_LOCK_DEADLOCK (backoff 50 ms × tentativa); outros erros propagam.
- **Q-G5 — explicação REVISTA (2026-09-06, com `EXPLAIN` medido no dev)**: os
  "contadores" são os `SELECT COALESCE(MAX(x),0)+1 … FOR UPDATE` por institution que
  toda baixa/movimento executa. A nota anterior estava parcialmente ERRADA — havia
  índice em settled_code desde a migration 013 (Ordem de Serviço). O que o banco mostra:
  (1) `settled_code` — desde a onda do cheque lê `tb_financial_statement` (fonte única);
  `idx_statement_settled (tb_institution_id, settled_code)` EXISTE → plano "Select
  tables optimized away": o MAX sai do FIM do índice, custo constante, lock só no último
  registro. Nada a fazer (idem `idx_payment_settled`). (2) `event` por título em
  tb_financial_payment — PK cobre, constante. (3) **`id` de tb_financial_statement** —
  a PK (id, institution, terminal) começa por `id`; o filtro por institution cai em
  `idx_statement_settled` mas o MAX(id) exige LER TODAS as linhas da institution (hoje
  119 rows, "Using index") — e, sendo FOR UPDATE, TRAVA todas: com 500 mil lançamentos,
  cada baixa/estorno/depósito de cheque varre e trava meio milhão de entradas de índice,
  e qualquer outra baixa concorrente do mesmo cliente ESPERA. Não é lentidão, é
  serialização do financeiro inteiro. (4) NOVO com o cheque: `id` de tb_check por
  institution — mesmo desenho (PK começa por id; usa `uq_check_identity` e varre todos
  os cheques); tabela pequena, mesmo buraco. Os demais (tb_check_event por cheque,
  tb_order) já resolvem por índice. Proposta ATUALIZADA: migration com
  `KEY idx_statement_inst_id (tb_institution_id, id)` em tb_financial_statement e
  `KEY idx_check_inst_id (tb_institution_id, id)` em tb_check — índices puros, zero
  regra nova, DDL online; o índice em settled_code de tb_financial_payment da proposta
  antiga é DESNECESSÁRIO (já existe). **EXECUTADA (Valdo "vai", 2026-09-07)**: migration
  `041_counter_indexes.sql` + KEY no bloco canônico de `tb_check` (sql/03;
  tb_financial_statement é do baseline, como na 013), aplicada no dev — EXPLAIN dos dois
  contadores passou a "Select tables optimized away".

- Achados LOW registrados (sem decisão): dado dev `tb_payment_types 6 "BOLETO"` com
  kind 'O' (D18 depende do kind correto — corrigir pela tela); JSON malformado devolve
  500 sem code (handler global, pré-existente); parcela 0 gera statement vazio;
  `DROP COLUMN IF EXISTS` é sintaxe MariaDB (engine de produção a confirmar).
