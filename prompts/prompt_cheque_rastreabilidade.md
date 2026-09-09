# Prompt — Cheque como portador de dívida (rastreabilidade)

**Escopo**: setes
**Status**: ENTREGUE (2026-09-04) — D1–D10 + D7a–c implementadas, gates 0.90/passou
após 3 rodadas, D11 (reuso pós-estorno) decidida e executada. Ver §7. Visual do app
VALIDADO em passeio logado (2026-09-08, §9); Q-CH1 e Q-CH2 DECIDIDAS e EXECUTADAS (§10, §11).
**Origem**: `TratamentoRastreabilidade de cheques.txt` (resposta do Valdo à Q18 de
`prompt_contrato_financeiro_baixa_automatica.md`)
**Fase**: Faturamento Fiscal e Financeiro — onda do cheque (decisões 17, 19, 27)
**Parecer conceitual**: agente setes-conceito (2026-09-03) — resumido abaixo

## 1. O que o Valdo pediu

Criar a tabela de cheques (cabeçalho: institution, data, nº banco, conta, agência,
número, emitente, valor, tipo P próprio / T terceiro — "não existe no legado,
separei campos da TB_CHEQUE") + tabela de rastreio (cheque, institution, dt_record,
entity NULL, financeiro NULL, settled_code NULL, status Devolvido/Descontado/Quitado).

Fluxo descrito: registra o cheque → origem = financeiro que recebeu (cliente que
pagou; pode ser cheque de TERCEIRO) → devolvido (gera contas a receber do CHEQUE;
cliente deve o cheque; a baixa desse título registra no rastreio) → usado no contas
a PAGAR (mesmo processo do tb_financial modo pagar) → descontado (entity da
factoring) → o descontado pode voltar (pré-datado chega ao dia e a factoring o usa
como "cheque bom" para trocar outros pré-datados).

Premissa fixada em D18 do contrato: cheque = baixa automática no faturamento, valor
para o CAIXA (exige caixa aberto); o cliente deixa de dever a nota e passa a dever o
cheque.

## 2. Parecer conceitual (resumo)

**Conceito**: cheque = título ao PORTADOR que substitui a dívida do cliente a partir
da baixa do faturamento. Fato gerador = a baixa do título com o cheque; o cheque
não nasce "por cadastrar". Tudo depois (depósito, desconto, uso em pagamento,
devolução, retorno) são fatos posteriores sobre o mesmo portador, cada um com seu
próprio fato financeiro.

**Duas peças** (o Valdo já separou): o CHEQUE (papel, imutável) × a HISTÓRIA
(eventos, só cresce). Estado atual = último evento vigente; NUNCA coluna mutável.

**Maquete do legado que NÃO se herda**: TB_CHEQUE tinha 7 colunas mutáveis
(CHQ_ESTADO, DEVOLVIDO, RETORNO, VL_AMORT, DT_QUITACAO, CODFOR, QT_PAG) reescritas a
cada destino — cheque descontado que retorna e é usado em pagamento PERDE a
factoring; `Descontar` era literalmente `Deposito`. Os 2 elos (CHQ_QT_REC origem /
CHQ_QT_PAG destino) viram 2 EVENTOS com `settled_code` cada — e suportam N destinos.

**Vocabulário de eventos** (kind do evento; o Valdo listou 3, o fluxo tem mais):

| kind | Evento | Compõe no financeiro | Elo |
|---|---|---|---|
| R RECEBIDO | entrou em custódia na baixa do faturamento | settleOneTitle conta 0 | settled_code origem; entity = cliente que ENTREGOU |
| B DEPOSITADO | cofre → banco | transferência conta 0 → conta corrente (legado dpt_ctrl_cheque) | settled_code; tb_bank_account_id |
| D DESCONTADO | factoring adiantou com ágio | débito caixa valor de face + crédito líquido + débito taxa (3 linhas, 1 código — legado dct_ctrl_cheque) | settled_code; entity = factoring |
| P USADO EM PAGAMENTO | quitou título a pagar | settleOneTitle do PA (Q2) | settled_code destino; entity = fornecedor; título pago |
| T RETORNADO | voltou da factoring | (a) reuso: sem dinheiro; (b) sem fundos: reembolso | settled_code se reembolso |
| V DEVOLVIDO | sem fundos | NOVO título contra o cliente de ORIGEM (nota avulsa → tb_order + tb_order_financial + tb_financial — 2º produtor do ramo financial; trilha tb_order_id_origin/origin_parcel/origin_event) | título novo |
| Q QUITADO | título do devolvido pago | baixa normal | derivável (Q4) |
| X ESTORNADO | inverte um evento | reverseOnePayment do settled_code | origin_event |

R é obrigatório e único (nasce NA transação da baixa do faturamento). Ordem entre os
demais = regra de aplicação da composição, não do DDL. Estado derivado: em custódia
= último ∈ {R, T-reuso}; no banco = B; na factoring = D; com fornecedor = P;
devolvido em cobrança = V sem Q.

**Peças**: `tb_check` (peça) + `tb_check_event` (peça append-only, elos por VALOR sem
FK ao título — decisão 33) + composições em `@shared/check` (transaction-aware)
que combinam settleOneTitle / writeManualCashierMovement / estorno + INSERT do
evento. Nenhuma operação escreve movimento por conta própria.

**Reusos**: tb_order/tb_order_financial/tb_financial (título do devolvido e PA);
tb_financial_statement (todo movimento); findOpenCashierId (decisão 19);
reverseOnePayment (executor confirma que inverte TODAS as linhas do settled_code —
hoje há LIMIT 1 no SELECT do statement, settlements.repository l.67-73);
setes_central.tb_bank (FK em vez de nº do banco solto); tb_entity por evento;
tb_payment_types.kind='Q'.

**Cheque de terceiro**: quem deve na devolução é quem ENTREGOU (entity do evento R),
nunca o emitente. Emitente = texto no legado (Q3).

**Estorno (decisão 15)**: evento é imutável — estornar = evento X + inversão do
settled_code. Estorno da baixa de origem só se o cheque não tem evento posterior
(409 CHECK_ALREADY_MOVED — estorna o passo seguinte primeiro; coerente com D7).

**Nomes propostos**: `tb_check` (PK id+institution; tb_bank_id FK central, agency,
account, number, issuer, value, dt_check [bom-para; pré-datado = dt_check > hoje,
derivado], kind P|T) + `tb_check_event` (PK institution+tb_check_id+event; kind
R|B|D|P|T|V|Q|X, dt_record, tb_entity_id NULL, settled_code NULL, tb_order_id/parcel
NULL, tb_bank_account_id NULL, origin_event NULL, note, tb_user_id). Sem status,
sem estado atual. `tb_bank_cheks` tem grafia errada e "bank" no nome de objeto que
é do cliente/emitente. Módulo espelhado `checks` (/api/checks ↔ /home/checks) —
tela de PROCESSO (lista por estado derivado + ações); "usar em pagamento" nasce na
baixa do contas a pagar, não na tela do cheque.

**Fora**: flags de estado do legado; ágio como coluna (é linha de movimento); baixa
em lote (loop de tela); conciliação; PDV; "receber descontada" (§5.5); conta
sentinela de custódia (rejeitada como o §5.4b); regra "1 cheque por título" (N
eventos R no mesmo settled_code).

## 3. Rodada 1 — questões para o Valdo (recomendação entre parênteses)

- **Q1 Onde fica o valor entre custódia e depósito?** (a) conta 0 recebe o valor de
  face no faturamento (legado) e o saldo "em espécie" do fechamento exclui
  movimentos de forma kind='Q' ainda sem B/D/P — separação na LEITURA por forma
  (statement já grava tb_payment_types_id); (b) custódia sem statement, só o
  evento R, movimento só no depósito/desconto/uso — 2 fontes para "quanto entrou";
  (c) conta sentinela. (rec.: a)
- **Q2 Cheque usado no contas a pagar move o caixa?** (i) evento P = settleOneTitle
  do PA com conta 0 (débito no caixa, exige caixa aberto); (ii) só o elo, sem
  movimento. (rec.: i — senão o caixa fica inflado para sempre)
- **Q3 Emitente**: (a) texto livre; (b) entity opcional + texto; (c) sempre entity.
  (rec.: a; b agrega depois sem reforma)
- **Q4 QUITADO**: (a) derivado do stage do título novo pela trilha do evento V;
  (b) evento Q gravado por gancho no settlements. (rec.: a)
- **Q5 Unicidade** banco+agência+conta+número por institution: (a) UNIQUE — cheque
  devolvido que volta é o MESMO registro com novo evento R; (b) sem UNIQUE. (rec.: a)
- **Q6 Devolução parcial** (CHQ_VL_AMORT do legado): saldo do cheque devolvido = saldo
  do TÍTULO novo (baixa parcial pela peça de settlements), nunca coluna no cheque.
  Confirmar. (rec.: sim)
- **Q7 Retorno do descontado**: (a) um kind T — settled_code NULL = reuso, preenchido
  = reembolso; (b) dois kinds. E no reuso o cheque volta à custódia ou vira MOEDA de
  um novo desconto (T seguido de D com outros cheques no mesmo settled_code)?
  (rec.: a + confirmar a leitura do reuso)
- **Q8 Escopo**: (a) onda própria "cheque" logo após o contrato — tb_check + evento R
  gravados NA BAIXA do faturamento (payload do billing leva os dados do cheque por
  parcela; legado Pc_LancaDetalheCheque abria o form por parcela na esteira do
  faturamento); até lá kind='Q' segue sem baixa automática; (b) na onda do
  contrato só a baixa no caixa, cheque registrado depois (intervalo sem portador).
  (rec.: a)
- **Q9 Cheques no faturamento**: (a) 1 cheque por parcela com valor = parcela
  (legado); (b) N por parcela / 1 para N parcelas. (rec.: a agora; b agrega)
- **Q10 Estorno da origem com cheque já movimentado**: 409 CHECK_ALREADY_MOVED
  (estornar o passo seguinte antes) × cadeia automática. (rec.: 409 — cadeia
  atravessaria terceiros)

## 4. Decisões — Rodada 1 (Valdo, 2026-09-03)

- **D1 (Q1=a) Valor de face entra na conta 0 na baixa do faturamento** (legado);
  separação dinheiro × cheque na LEITURA pela forma de pagamento do movimento
  (kind='Q' sem evento B/D/P = cheque em custódia). Peça financeira intacta.
- **D2 (Q2=i) Cheque no contas a pagar MOVE o caixa**: evento P = settleOneTitle do
  título PA com conta 0 (débito; exige caixa aberto).
- **D3 (Q3) Emitente = texto livre** (`issuer varchar(100)`); entity opcional pode
  agregar depois sem reforma.
- **D4 (Q4) QUITADO derivado** do stage do título novo pela trilha do evento V —
  sem evento Q, sem gancho no settlements. Domínio do kind fica R|B|D|P|T|V|X.
- **D5 (Q5) UNIQUE** (institution, banco, agência, conta, número): cheque que volta
  é o MESMO registro com novo evento R.
- **D6 (Q6) Devolução parcial = saldo do TÍTULO novo**; nada no cheque.
- **D7 (Q7) — aguarda explicação** (Rodada 2, abaixo).
- **D8 (Q8=a) Onda própria "cheque" logo após o contrato**: tb_check + evento R
  nascem NA transação da baixa do faturamento (payload do billing leva os cheques);
  até lá kind='Q' segue sem baixa automática. O contrato (D18) NÃO implementa o cheque.
- **D9 (Q9) N cheques por parcela**: soma dos cheques = valor da parcela (1 baixa,
  N eventos R no mesmo settled_code). Validação: soma ≠ parcela → 422.
- **D10 (Q10) Estorno recusa** (409 CHECK_ALREADY_MOVED) se o cheque tem evento
  posterior ao estornado; nunca cadeia automática.

## 5. Rodada 2 — Q7 explicada (2026-09-03)

Quando o cheque está na factoring (evento D: ela adiantou o dinheiro com ágio),
o legado registra dois retornos diferentes na mesma tela "Retorno de Cheque Descontado":

- **Sem fundos**: a factoring devolve o cheque e exige REEMBOLSO. Sai dinheiro do
  caixa/banco para a factoring (movimento). Depois disso o cheque está devolvido e
  vira cobrança contra o cliente (evento V → título novo).
- **Reuso ("cheque bom")**: o pré-datado chegou ao dia e compensou. A factoring não
  devolve dinheiro nem cobra: ela usa esse cheque, agora bom, como MOEDA para
  adiantar OUTROS pré-datados seus. Não há movimento de dinheiro: a história do
  cheque só precisa registrar que ele encerrou na factoring.

Perguntas:

- **Q7a Um kind ou dois?** (a) um kind T "retornado" — com `settled_code` = houve
  reembolso (sem fundos); sem settled_code = encerrou na factoring (reuso);
  (b) dois kinds explícitos: T retorno com reembolso × F "liquidado na factoring".
  (rec.: b — dois fatos diferentes com nomes diferentes; ler pela presença do
  settled_code é regra escondida)
- **Q7b No reuso o cheque volta à custódia?** Pela sua frase ("o factoring usa o
  mesmo cheque bom para trocar outros pré-datados") entendi que o cheque FICA com a
  factoring e ENCERRA — o que entra no sistema é um NOVO desconto (evento D) de
  outros cheques, cujo líquido pode ser abatido por esse cheque bom. Confirme: (a)
  encerra na factoring, sem voltar à custódia; o novo desconto é outra operação;
  (b) volta à custódia e pode ser depositado/pago.
- **Q7c Sem fundos vindo da factoring**: o reembolso e a devolução são 2 eventos
  (T com movimento + V com título novo) ou 1 só? (rec.: 2 — o reembolso é dinheiro
  para a factoring, a devolução é cobrança do cliente; fatos distintos)

## 6. Decisões — Rodada 2 (Valdo, 2026-09-03) — RODADAS FECHADAS

- **D7a (Q7a=b) Dois kinds explícitos**: `T` = retornado da factoring COM reembolso
  (movimento: débito caixa/banco para a factoring; settled_code obrigatório) ×
  `F` = retornado BOM (o pré-datado compensou; sem movimento).
- **D7b (Q7b=b) O cheque bom VOLTA à custódia**: após `F` o cheque pode ser
  depositado, usado em pagamento ou entrar como moeda de um NOVO desconto (outra
  operação `D`). Estado derivado "em custódia" = último evento ∈ {R, F}.
- **D7c (Q7c=a) Sem fundos vindo da factoring = 2 eventos**: `T` (reembolso à
  factoring) e depois `V` (devolução → título novo contra o cliente de origem).

**Domínio final do kind**: R recebido · B depositado · D descontado · P usado em
pagamento · T retornado com reembolso · F retornado bom · V devolvido · X estornado.
Estado derivado: custódia = último ∈ {R, F}; banco = B; factoring = D; fornecedor
= P; em cobrança = V com título novo aberto; encerrado = B / P / V quitado.

Ordem de execução cumprida: contrato (onda 1) → boleto (onda 2) → cheque (onda 3).

## 7. Execução — Onda do cheque ENTREGUE (2026-09-04; retenção fechada 2026-09-06)

**DDL** (`setes-api/src/migrations/sql/040_check.sql`, blocos canônicos no `sql/03`,
seed `sql/50_checks_seed.sql` — interface `checks` grupo Financeiro, page_size, flag
retroativa; aplicados em dev): `tb_check` (PK id+institution; UNIQUE identidade D5;
kind P/T) + `tb_check_event` (PK institution+cheque+event; kind R|B|D|P|T|F|V|X;
`payment_event` = evento do tb_financial_payment por trás de R/P, para o estorno chamar
`reverseOnePayment` com precisão; elos por VALOR — decisão 33).

**API**: peça `@shared/check` (`receiveChecksOnBilling` R · `depositCheck` B ·
`discountCheck` D 3 linhas/1 código · `returnCheckWithRefund` T · `returnCheckGood` F
sem movimento · `useCheckInPayment` P via `settleOneTitle` conta 0 · `returnCheck` V =
tb_order + tb_order_financial + tb_financial + bills kind 'CH' · `reverseCheckEvent` X
por kind). `@shared/financial-settlement` passou a exportar `insertStatement`/
`StatementLine` e ganhou `nextSettledCode` (fonte ÚNICA — ver achado do smoke). Módulo
`checks` (6 arquivos, tela de PROCESSO: GET / por estado derivado, GET /:id com a
história, lookups banks/bank-accounts/providers/open-payables, POST /:id/deposit |
discount | return-refund | return-good | pay | return | reverse); router + defaultModules.
Billing: bloco `checks[{parcel, items[]}]` no invoice — parcela de forma kind='Q' exige
cheques cuja soma = valor da parcela (422 CHECK_REQUIRED / CHECK_SUM_MISMATCH com os
dois valores na mensagem). Recebimento SEM savepoint — decisão de engenharia: diferente
do contrato/boleto (opcionais, nunca bloqueiam), cheque DIGITADO pelo usuário sem caixa
aberto derruba a nota (409 NO_OPEN_CASHIER), porque R só nasce nessa transação. Sem
endpoint de preview de parcelas (extrair a base financeira duplicaria o motor fiscal; o
422 devolve o valor esperado). Catálogo de erros: +NO_OPEN_CASHIER e
BANK_ACCOUNT_REQUIRED (faltavam desde o contrato) + 14 CHECK_*.

**Legado verificado** (`reg_ctrl_cheque.pas` / `ControllerCheque.pas`): o legado NÃO
distingue retorno com reembolso de cheque bom — um `Retornar` só, com UpdateEstado antes
da confirmação e crédito/débito assimétrico caixa × banco. D7a/b/c é decisão nova, não
maquete. Desconto: 3 lançamentos sob 1 quitação, ágio DIGITADO (nunca %) — igual ao
implementado.

**App** (setes-form-builder; VERIFICADO no disco 2026-09-06 — o agente encerrou 2×
"esperando o dev server", sem relatório): módulo `checks` tela de processo, 22 arquivos
(lista por estado + filtro + paginação; detalhe dirigido pelo estado com linha do tempo
e 7 dialogs de ação), rota `/checks` no home_module, i18n pt/en 87 chaves, `flutter
analyze` limpo. Validação visual no browser PENDENTE. ⚠️ Achado de escopo: o app NÃO
tem tela de negociação do pedido (forma de pagamento/parcelas — `tb_order_billing` só
entra por SQL nos smokes); sem ela a coleta dos cheques no "Validar e Faturar" não tem
onde nascer (a chamada manda só `{orderId}`) → Q-C1 em §8.

**Smoke E2E real** (dev): invoice sem cheques 422; soma errada 422; 2 cheques (100+50)
→ 2 R no MESMO settled_code; reemissão de identidade ativa 409; ciclo R→D→F→D→T→V no
mesmo cheque; P sobre título PA; B→X; D10 409. ACHADO: `nextSettledCode` lia
`MAX(settled_code)` de tb_financial_payment — movimento SEM título (B/D/T) nunca grava
lá, dois descontos seguidos ganhavam o MESMO código (50/50), colidindo o agrupamento
do estorno. Corrigido: fonte única = tb_financial_statement (superset) e as 3 cópias
inline da conta (`settleOneTitle`, `settleBatchTx`, `reverseOnePayment`) passaram a
chamar o helper; teste fixa a fonte. Reprovado: 52/53.

**Gates** (2026-09-04) — 3 rodadas:
- 1ª: socrático 0.68 ✗ · adversarial 0.42 ✗. CRITICAL provados: P pagava pelo valor de
  FACE sem teto (cheque 500 quitou saldo 30 — 550 pagos sobre dívida de 80); estorno de
  R em grupo (D9) forçava X nos irmãos que JÁ tinham avançado (depósito nunca revertido
  + título reaberto inteiro). MEDIUM: factoringEntityId órfão aceito; reuso D5 com
  valor/emitente/data divergentes gravava cabeçalho stale; 3 casas decimais furavam a
  soma exata (33.334×3 = 100.00 no round2, 99.99 gravado). LOW: 409 antes do 404; 404
  sem `code`. Socrático somou: V a partir de 'bank' NÃO revertia o depósito (conta
  inflada para sempre); corrida em `findOrCreateCheck` (FOR UPDATE em linha inexistente).
  Correções em sessão: 422 CHECK_EXCEEDS_BALANCE (saldo pela mesma fórmula de
  listOpenPayables, FOR UPDATE); D10 estendido ao GRUPO (`lockCheck` em CADA irmão ANTES
  de `reverseOnePayment`, 409 se algum avançou — nada gravado); V de B chama
  `reverseStatementOnly` do depósito; CHECK_FACTORING_NOT_FOUND (tb_entity);
  CHECK_IDENTITY_MISMATCH; refine 2 casas (padrão do feeRate); 404→409 na ordem certa;
  ER_DUP_ENTRY → 409 CHECK_ALREADY_ACTIVE.
- 2ª: socrático **0.79 ✅** (sobras: `bankId` do cabeçalho também sem validação →
  BANK_NOT_FOUND com deleted='N'; ORDER BY tb_check_id nos irmãos; 3 testes que faltavam)
  · adversarial 0.58 ✗ — CRITICAL NOVO provado: `stateFromLastEvent` mapeava X no
  `default` 'custody' → cheque com R ESTORNADO voltava a "custódia" e aceitava
  deposit/discount/pay sem nenhum R por trás (crédito bancário, factoring e PA fabricados
  ao vivo). Corrigido: X é META-evento, não estado — `effectiveState()` resolve pela
  PRECONDIÇÃO do evento revertido (B/D/P → custody, T/F → factoring, R → 'voided', que
  não é CheckState e nenhum assert aceita); `lockCheck` traz o kind da origem no MESMO
  FOR UPDATE; `LAST_CHECK_STATE_SQL` replica para lista/detalhe.
- 3ª (final): **0.90 ✅ passou, 0 vulnerabilidades** — cheque voided atacado em TODOS os
  8 caminhos de escrita (409 em todos); P e D estornados voltam a custódia DE VERDADE.
- As correções foram re-verificadas ao vivo (scripts `smoke_gate_fixes*.sh`). Suíte:
  583 → **602/602** (+19 testes de regressão, incl. os que fixam cada achado).

## 8. Rodada 3 — decisão dos gates (Valdo, 2026-09-04) + pendência de produto

- **D11 Reuso pós-estorno**: cheque com R estornado (voided) LIBERA a identidade para
  um novo R — e, como o cabeçalho gravado é o ENGANO que motivou o estorno, a correção
  ATUALIZA issuer/value/dt_check/kind (única exceção à imutabilidade do cabeçalho; para
  reuso após P/V a checagem CHECK_IDENTITY_MISMATCH continua valendo). Provado ao vivo:
  999 errado → estorno → 55 certo sob a mesma identidade, detalhe mostra 55.
- Pontos abertos registrados SEM decisão (todos fail-closed, nenhum fabrica movimento):
  `assertReturnable` compara lastKind cru (X nunca devolve — convergir para
  `effectiveState` quando o arquivo for tocado); `LAST_CHECK_STATE_SQL` devolve NULL se
  `origin_event` não resolver (teórico — COALESCE quando revisitar); deadlock entre
  estornos concorrentes do MESMO grupo é absorvido pelo `withDeadlockRetry` (ORDER BY
  reduz, não elimina); cheque voided aparece como 'custody' na LISTA (o bloqueio real é
  em memória) — 7º estado de exibição só se o Valdo quiser.
- **Q-C1 (produto — aguarda o Valdo)**: tela de NEGOCIAÇÃO do pedido (forma de pagamento
  + parcelas = `tb_order_billing`) não existe no app; é pré-requisito para coletar os
  cheques no "Validar e Faturar". Frente própria, fora desta onda — o backend já aceita
  o bloco `checks`.

**Status**: onda do cheque ENTREGUE (API + app; visual do app validado em 2026-09-08 —
§9). Código commitado e publicado em 2026-09-08 (api af4d83a · app 3dbfa2d).

## 9. Passeio logado do módulo Cheques (2026-09-08) — visual VALIDADO + Q-CH1

Valdo: "passeio curto o modulo de cheques". Claude in Chrome com o login do Valdo, app web
recompilado (build debug). Roteiro no cheque 42 (PASSEIO2-40, R$ 40,00, recebido na fatura
6190 do passeio nº 2 da negociação):
1. `/home/checks/` — lista com abas por ESTADO (Em Custódia · No Banco · Na Factoring ·
   Usado em Pagamento · Devolvido c/ Reembolso · Em Cobrança), busca por número/emitente,
   24 cheques em custódia (cliente, nº, emitente, valor, data do cheque), paginação.
2. Detalhe — cabeçalho imutável (emitente, banco, ag/cc, nº, data, tipo, "entregue por"),
   chip de estado, Linha do Tempo (1 Recebido · código da baixa 106 · título 6632/1) e as
   ações Depositar / Descontar / Usar em Pagamento / Devolver / Estornar.
3. Depositar — dialog com data do movimento e lookup de contas (`/api/checks/bank-accounts`:
   "Banco do Brasil — 1234/56789") → chip "No banco", evento 2 "Depositado · código 107";
   no estado banco só "Estornar" fica disponível.
4. Estornar — dialog "Estornar Último Evento" exige o MOTIVO → evento 3 "Estornado · código
   108 · Origem: evento 2 · Obs.: <motivo>", chip volta a "Em custódia" e as cinco ações
   reaparecem.

Evidência (setes_setes): `tb_check_event` 42 = R (106, payment_event 1) · B (107, conta 1)
· X (108). `tb_financial_statement`: 106 = caixa +45,00 "Cheque(s) recebido(s) | Pedido
6632 parcela 1"; 107 = caixa −40,00 e conta 1 +40,00 "Depósito cheque PASSEIO2-40";
108 = caixa +40,00 e conta 1 −40,00 "Estorno: <motivo>" (espelho exato; originais
marcados status 'E').

**Q-CH1 (achado do passeio — aguarda o Valdo)**: o estorno de B/D/T do cheque
(`reverseStatementOnly` em `@shared/check`, "mesmo padrão dos satélites do boleto") grava
as linhas-espelho SEM `tb_financial_statement_id_origin`, com status padrão (não 'R') e
`dt_record` = data do estorno; o núcleo `settlement-batch` (D-G3 do contrato) grava o
inverso com status 'R', origem apontando para a linha original e `dt_record` HERDADO do
original (dt_original = hoje). São duas convenções de estorno no mesmo extrato.
Recomendação: extrair do núcleo um `reverseStatementLines(conn, settledCode, note)` e
usá-lo no cheque e nos satélites do boleto (origem + 'R' + herança de dt_record) — tarefa
pequena, sem DDL, após o "vai".

Lições de condução (memória `passeio-logado-browser`): a janela que a extensão cria pode
nascer oculta/minimizada — sem `requestAnimationFrame` o Flutter não sobe (checar
`document.visibilityState` e um rAF de 2 s antes de esperar); o Valdo NEGOU acesso de área
de trabalho ao Chrome (não pedir de novo — pedir a ele que traga a janela para a frente);
numa aba nova o app abriu em `/login` (o Valdo faz o login; o agente nunca digita senha).

**Status**: visual do app VALIDADO; Q-CH1 → D-CH1 EXECUTADA (§10, 650/650, smoke no dev).
Q-CH2 → D-CH2 EXECUTADA (§11, saldo do caixa soma todas as linhas não deletadas; 650/650;
`GET /api/cashier/5` = 278,00). Código do passeio commitado e publicado em 2026-09-08 (api
af4d83a · app 3dbfa2d); `statement-reversal` e a correção do caixa ainda NÃO commitadas.

## 10. D-CH1 — convenção única de estorno do extrato (Valdo 2026-09-08: "Q-CH1 vai") — EXECUTADA

Peça nova `@shared/financial-settlement/statement-reversal.ts`:
- `reverseStatementLines(conn, s, inst, userId, settledCode, note, dtOriginal?)` — para um
  `settled_code` SEM título (B/D/T do cheque): lê as linhas vivas (`status NOT IN ('R','E')`,
  FOR UPDATE), minta o código novo (sempre — é o identificador do evento X) e, para cada
  linha, chama `mirrorStatementLine`: espelho com **status 'R'**, **`tb_financial_statement_
  id_origin` = a linha**, **`dt_record` HERDADO** da original (D-G3: anula na mesma data de
  disponibilidade), `dt_original` = fato gerador (data informada ou hoje), histórico
  "Estorno: <motivo>" (100 chars); a original vira 'E'.
- `insertStatement` (financial-settlement.ts) ganhou os campos opcionais `status` e
  `originId` — compatível com todos os produtores existentes (default 'N' / NULL).
- `@shared/check`: `reverseStatementOnly` (privada, divergente) REMOVIDA; os dois pontos
  (X de B/D/T e a devolução V a partir do banco) usam a peça única. O núcleo
  `reverseOnePayment` (baixas de título + satélites) já seguia a convenção e não mudou.
- Testes: `statement-reversal.test.ts` (+4: espelho/origem/herança, sem linha viva, data
  omitida, corte do histórico) e asserções novas no `check.test.ts` (status 'R', origem,
  histórico) → **650/650**.
- Smoke no dev: depósito do cheque 42 com `dt_record` RETROATIVA 2026-09-01 (código 109)
  e estorno hoje (código 110): linhas 149/150 com status 'R', origem 147/148, `dt_record`
  2026-09-01 herdado e `dt_original` 2026-09-08; originais 147/148 viraram 'E'.
- Verificação sistêmica: a única leitura de saldo hoje é a do CAIXA (`cashier`), e ela
  revelou a Q-CH2 abaixo — a peça nova segue a convenção do núcleo, mas o leitor do
  núcleo exclui as originais 'E'.

**Q-CH2 (achado sistêmico ao executar a D-CH1 — aguarda o Valdo)**: `getCashierBalance` e
`getRegisteredByPaymentType` (módulo `cashier`) somam `status IN ('N','R')` e EXCLUEM as
originais 'E'. Com o desenho de espelhos (original vira 'E' + espelho 'R' que a compensa),
o estorno TOTAL entra no saldo uma vez só — o saldo fica errado exatamente pelo valor
estornado; no estorno PARCIAL (original segue 'N' + espelho 'R') a conta fecha. Medido no
caixa 5 do dev: filtro atual **−871,00** (30 linhas) × todas as linhas **278,00** (37);
só as 'E' somam +1.149,00 (7 linhas: 4 com espelho 'R' vinculado pela origem, 3 do padrão
antigo do cheque com espelho 'N'). Bug PRÉ-EXISTENTE do núcleo (afeta estornos do
contrato, do boleto e do cheque), não introduzido pela D-CH1. Recomendação: saldo e
conferência do fechamento somam TODAS as linhas não deletadas — o status é informativo
(N vigente · E estornada · R estorno) e o razão é append-only; 2 queries + teste, sem DDL.
A alternativa (somar só 'N') quebra o estorno parcial. Conferir também qualquer outra
leitura de saldo que venha a nascer (extrato de conta bancária ainda não soma).

## 11. D-CH2 — saldo do caixa soma todas as linhas não deletadas (Valdo 2026-09-08: "Q-CH2 vai") — EXECUTADA

Antes do "vai" o Valdo perguntou se "excluem as originais" considerava o soft-delete: NÃO —
são dois filtros independentes; `deleted = 'N'` fica, o que saiu foi `status IN ('N','R')`.
Nenhum código do setes-api marca `deleted = 'S'` em linha do extrato; o estorno nunca
apaga, grava o espelho e muda o status da original para 'E'.

- `getCashierBalance` e `getRegisteredByPaymentType` (`modules/cashier`): filtro de status
  REMOVIDO; comentário com a regra e a medição. REGRA: o razão do extrato é append-only;
  saldo = Σ(crédito − débito) de TODAS as linhas com `deleted = 'N'`; o status é
  informativo (N vigente · E estornada · R estorno) — o espelho 'R' compensa a original 'E'
  no total e convive com a original 'N' no parcial.
- Teste `cashier.test.ts` (saldo derivado) passou a exigir `deleted = 'N'` e a proibir
  qualquer filtro de status nas duas consultas → suíte **650/650**.
- Smoke no dev: `GET /api/cashier/5` → balance **278,00** (era −871,00 pelo filtro
  antigo); por forma: sem forma −855,00 · 1 −30,00 · 3 (cheque) 1.163,00.
- Alcance: única leitura de saldo hoje (extrato de conta bancária ainda não soma); quando
  nascer, segue a mesma regra.
