# Financeiro do Gestao2016 — frente ABERTA (mapeamento)

**Escopo**: setes
**Aberta em**: 2026-08-16 (após fechar tributação; autorização GUARDADA com pendências)
**Marco anterior**: nota fiscal pronta — mercadoria E serviço — com impostos calculados.
**Método**: o autor instrui → verificação no código → lacuna vira questão numerada.

## 1. Censo inicial (medido, 2026-08-16 — antes de qualquer leitura profunda)

### Núcleo (regra/persistência)

| Arquivo | Linhas | Papel aparente |
|---|---|---|
| `RegraNegocios/RN_Financeiro.pas` | 691 | regra de negócio |
| `Controller/ControllerFinanceiro.pas` | 671 | persistência de `tb_financeiro` |
| `Controller/ControllerMovimentoFinanceiro.pas` | 470 | persistência de `TB_MOVIM_FINANCEIRO` |

### As duas tabelas centrais (campos verificados nos models)

**`tb_financeiro`** (32 campos — o TÍTULO/parcela): `FIN_CODIGO`, `FIN_CODEMP`
(entidade), **`FIN_CODPED` + `FIN_CODNFL`** (elo pedido+nota — o processo inteiro),
`FIN_CODFPG`/`FIN_PRAZO` (forma/prazo), `FIN_DT_VENCIMENTO`, `FIN_NUMERO`,
`FIN_VL_PARCELA`/`FIN_NR_PARCELA`, juros/mora/desconto, `FIN_VL_PAGO`/`FIN_DT_PAGTO`/
`FIN_DT_BAIXA`/`FIN_BAIXA`, **`FIN_PLC_CREDITO`/`FIN_PLC_DEBITO`** (plano de contas),
`FIN_TIPO`, `FIN_SITUACAO`, `FIN_OPERACAO`, `FIN_ETAPA`, `FIN_CODMHA`
(estabelecimento), `FIN_CODCHQ` (cheque), desconto-limite (`FIN_DT_LIMIT_DESC`/
`FIN_ALIQ_DESC`), `FIN_COND_ESPECIAIS`, `FIN_DT_REPROGRAMADA`, `FIN_AUTORIZADO`.

**`TB_MOVIM_FINANCEIRO`** (o MOVIMENTO em conta): `MVF_CODCTB` (conta bancária),
`MVF_CODPLC_C`/`MVF_CODPLC_D` (plano de contas C/D), `MVF_VL_CREDITO`/`MVF_VL_DEBITO`,
`MVF_HISTORISCO`, `MVF_TIPO`, **`MVF_CODUSU`** (autor — a dimensão já tratada na
indexação de usuários do sync), `MVF_ESPECIE`, `MVF_VL_FUTURO`, `MVF_DT_ORIG`,
`MVF_NR_DOC`, `MVF_CONFERIDO`, `MVF_CODFPT`, `MVF_CODMHA`.

### Satélites (tabelas verificadas)

`tb_boleto` (+ `tblBoletoBancario`, `TblBoletoEletronico`), `tb_cheques`,
`tb_cartao` (+ `tblCartaoEletronico`, `tblTefMovimento`), `TB_CONTABANCARIA`,
`TB_PLANOCONTAS`, `tb_Fecha_Financeiro`.

### Telas (as maiores — superfície de processo)

| Tela | Linhas | Papel aparente |
|---|---|---|
| `Un_FrenteCaixa.pas` | 4.569 | PDV — deságua no financeiro |
| `UN_Receber_Multipla.pas` | 4.225 | contas a receber (baixa múltipla) |
| `Un_Pagar_Multipla.pas` | 3.397 | contas a pagar (baixa múltipla) |
| `Un_Receber_Descontada.pas` (+ task devolução) | 1.551 | recebível DESCONTADO (antecipação) |
| `Un_Caixa.PAS` + `Un_Caixa_Fechamento` | 1.166+ | caixa e fechamento |
| `Un_Fatura_Fin.pas` | 1.027 | financeiro MANUAL no meio do faturamento (instrução: usado quando o cliente NÃO escolhe o modo automático) |
| `un_receber_baixa_lote`, `un_receber_tef_avulso`, `Un_Baixa_Boleto`, `Un_Baixa_Cheques`, `Un_ContasReceberBoleto`, `Un_AlteraBoleto`, `Un_ContasCorrente`, `Un_Fecha_Financeiro`, `Un_DadosCheques`, `Un_DadosCartaoEletronica` | — | operações satélites |

### Quem GERA o financeiro (`Pc_Gera_Financeiro` — callers verificados)

`UN_Fatura_Vda`, `UN_Fatura_Cpa`, `UN_Fatura_Ajt`, `Un_Fatura_Fin`,
`Un_Cupom_Fiscal`, `Un_ImportaXMLNFe` (+ `Un_Fatura_Srv` descontinuado).
→ O financeiro NASCE no faturamento — mesma transação do processo pedido→nota.
O do SERVIÇO passa pelo MESMO `Pc_Gera_Financeiro` (já instruído, processo-pedido-nota).

## 2. Elos com o que a web JÁ decidiu (confrontar durante o mapeamento)

- **setes-sync**: financeiro trafega no formato 5.5 com **semântica de ESPELHO**
  (Ondas 1–6) — o sync não manda no desenho, mas o mapeamento explica o espelho
- **Software House/OS**: `settlements` = baixa/estorno IMUTÁVEL com movimento +
  compensação PA+C (DP1–DP12) — o financeiro web já tem filosofia definida:
  **financeiro imutável**; o legado (`FIN_VL_PAGO` na própria linha, boleto alterável)
  é mutável — a tradução mutável→imutável é decisão de desenho central da frente
- **tb_order_financial** (parcerias) e **bank-accounts** já existem na web
- **Autor real das operações**: `MVF_CODUSU`/caixa já resolvido na indexação de
  usuários do sync (memória retaguarda-replicacao-externalcode)
- **Decisão 8**: banco = catálogo central FEBRABAN (tb_bank); `TB_CONTABANCARIA`
  local terá que apontar para ele

## 3. O fluxo instruído pelo autor (2026-08-16 — verificado no código)

### 3.1 Conceito

**Financeiro SEPARADO do faturamento**: uma coisa é faturar; outra é QUANDO e COMO
vai receber. (Coerente com a arquitetura: `tb_financeiro` liga pedido+nota mas vive
ciclo próprio.)

### 3.2 Nascimento — duas vias, um ponto de confirmação

1. **Via Pedido/Ordem (forma AUTOMÁTICA)**: a negociação acontece na criação da
   venda — **`tb_parcelamento`** (✅ `model/tblParcelamento.pas` +
   `ControllerParcelamento`) define:
   - Forma de pagamento: DINHEIRO (PIX ou espécie) / CHEQUE / BOLETO /
     **CARTEIRA** (vulgo FIADO)
   - Prazo: nº de parcelas (1/2/3...) + prazo entre parcelas no formato
     `028/056/084` (o `FIN_PRAZO`/`tb_prazo` visto no pedido)
2. **Via MANUAL (confirmativa)**: cliente que ATIVAR esse modo confirma ou redefine
   a negociação numa tela que aparece NA ESTEIRA do faturamento — é a
   `Un_Fatura_Fin` (1.027 linhas, já instruída).

**Confirmado → o financeiro é GERADO** (`RN_Financeiro.Pc_GeraContasReceber`, com
transação e parâmetro `Pc_BAIXA` — a baixa-no-nascimento é decidida AQUI). **Depois
disso, qualquer manutenção SÓ pelo módulo financeiro.**

### 3.3 Meios de quitação — a EXPECTATIVA definida no nascimento

| Meio | À vista | A prazo |
|---|---|---|
| DINHEIRO espécie | baixa automática + registro no **CAIXA** | NÃO EXISTE — vira CARTEIRA/FIADO |
| DINHEIRO PIX | baixa automática + registro na **CONTA CORRENTE pré-cadastrada** | NÃO EXISTE — vira CARTEIRA/FIADO |
| CHEQUE | baixa automática + caixa | baixa automática + caixa (a dívida passa a ser o CHEQUE — §3.5) |
| BOLETO | ver **QF1** | ver **QF1** |
| CARTEIRA/FIADO | — | título fica em aberto; administração manual |

Cheque SEMPRE registrado (`tb_cheques` / tela `reg_ctrl_cheque` /
`TControllerCheque` ✅) para controle de vencimentos — transita entre fornecedores,
pode voltar sem fundos, pode ser descontado; o controle rastreia ORIGEM e DESTINO.
**Capítulo à parte** (§5).

### 3.4 Boleto — controle específico

**Processamento por LOTE (CNAB) — workflow do autor:**
1. Tela do financeiro → seleciona títulos (individual OU agrupa vários num boleto)
2. Carteiras de recebimento: **`TB_BOLETO_ELETRONICO`** / tela
   `reg_electronic_slip` / `TControllerBoletoEletronico` (✅ em
   `view/module/banking/register/`) — conta corrente + dados da carteira do banco
3. Vincula títulos a um boleto NUMERADO → cria LOTE → gera arquivo **CNAB**
4. Processo EXTERNO: envia o arquivo pelo portal do banco
5. Baixa os arquivos de RETORNO → sistema processa, registrando baixas (ou não)

**Processamento por API — NÃO implementado (desejo declarado)**: modelo do Banco
Inter (Setes tem conta). Hoje o CNAB passa por sistema de TERCEIRO que envia ao
Inter; **objetivo na web: cortar essa etapa** — envio de boleto e consulta de
baixas DIRETO pelo ERP. → requisito de produto para a web.

### 3.5 Vida — baixas, juros, reprogramação

- **Baixas por meio**: espécie → caixa; PIX → conta corrente informada; cheque →
  caixa com rastreio origem/destino; **boleto → manual (extrato do cliente) OU
  automática (arquivo de retorno) OU automática (API)**.
- **Juros/multa**: campos existem (`FIN_VL_JUROS`/`FIN_VL_MORA` ✅); definidos pelo
  CLIENTE, sem automatização — exceto boleto, onde cobrança/pagamento passam pelo
  sistema bancário.
- **Reprogramação por meio**:
  - CARTEIRA: administração manual; baixa só quando o cliente pagar
  - CHEQUE — **conceito novo do autor**: a baixa do título acontece COM o cheque;
    o cliente **não deve mais o TÍTULO, deve o CHEQUE**. O controle de cheque
    assume o risco (sem fundos, descontado)
  - BOLETO: engessado pelo banco — cancelamento de boleto pode gerar reemissão OU
    pagamento por outra forma, conforme determinado individualmente

### 3.6 Morte — baixa, cancelamento, estorno

- **Baixa** = título pago (`Pc_ProcessoBaixaFinanceiro` ✅).
- **Cancelamento de faturamento NÃO autorizado**: TODOS os registros do faturamento
  deletados em **soft-delete**; a ordem VOLTA à origem; processo reinicia.
  (`Pc_Excluir_Contas_Financeiro` ✅)
- **Cancelamento de nota AUTORIZADA**: a ordem **NÃO volta** ao estado original
  (existe documento oficial); o financeiro pode ser apagado (soft-delete); pode
  restar uma **cópia de ordem** para o cliente não relançar do zero.
- **Estorno de baixa errada**: cancelável — com CAIXA ABERTO obrigatório para o
  **lançamento INVERSO** no caixa (recebi dinheiro → estorno lança o contrário);
  na conta corrente, apenas soft-delete.

## 4. Questões

### Abertas

*(nenhuma no momento)*

### Respondidas

- ~~QF1~~ (2026-08-16) — CORRETO: **boleto NÃO baixa no nascimento**; a baixa vem
  por extrato/retorno/API (§3.5). A linha "baixa automática" do boleto na tabela de
  meios era engano de transcrição.
- ~~QF2~~ (2026-08-16) — **SIM**: cancelamento de nota autorizada com baixas já
  feitas exige **estorno em cadeia ANTES do soft-delete** (alinha com os settlements
  da web — estorno imutável em cadeia).
- ~~QF3~~ (2026-08-16) — o classificador do meio é **`TB_FORMAPAGTO.FPT_DESCRICAO`**
  (o TEXTO). Verificado: o código compara literais — `'BOLETO'` (10×), `'CARTEIRA'`
  (8×), `'CHEQUE'` (6×), `'CARTAO'` (5×) — via `Fc_PegaFormaPgto('...')` etc.
  **Sugestão p/ web (regra 5)**: classificar por texto é frágil (renomear a forma
  quebra o comportamento); a web deve ter um campo TIPADO de meio — a
  `tb_payment_types` já existe (Fase 3 Rodada 4, wallet/id_nfce) e é o lugar natural.

## 5. Sub-frentes (instruídas em 2026-08-16, verificadas no código)

### 5.1 CHEQUE — o capítulo à parte

**O elo de rastreio (instruído + verificado em `model/tblCheque.pas`)**: todo
registro de cheque é rastreado com o financeiro pelo CÓDIGO DE QUITAÇÃO —
- **`CHQ_QT_REC`** (ORIGEM — de onde o cheque veio) → `TB_FINANCEIRO.FIN_CODQTC`
- **`CHQ_QT_PAG`** (DESTINO — onde o cheque foi usado p/ pagar) → `TB_FINANCEIRO.FIN_CODQTC`

Campos de estado verificados: `CHQ_DEVOLVIDO`, `CHQ_RETORNO`, `CHQ_TIPO`,
`CHQ_ESTADO`, `CHQ_VL_AMORT`, `CHQ_CODFOR` (fornecedor), `CHQ_CONTA`.

**As QUATRO baixas do cheque** (instruídas; literais no `Un_Baixa_Cheques.dfm`):
1. **Efetuar Depósito** — cheque estava no cofre, chegou o dia, foi depositado
2. **Efetuar Desconto com Financeira** — factory adianta o dinheiro mediante ágio
3. **Efetuar Retorno de Cheque Descontado** — o cheque volta da factory:
   (a) a factory o usa na data para adiantar OUTROS cheques, ou
   (b) estava SEM FUNDOS e a factory exige reembolso
4. **Efetuar Registro de Devolução** — a devolução gera **NOVO TÍTULO** no
   financeiro para cobrar o cliente: o título ORIGINAL já foi quitado e não é mais
   devido (§3.5 — a dívida era o cheque); o lançamento entra como **nota avulsa
   que gera financeiro manual**, relacionado à devolução → volta ao ciclo de cobrança

### 5.2 CARTÃO — duas baixas

- **Simples**: o cliente baixa e o valor vai direto para banco ou caixa.
- **Complexa — com CONTRATO** (`reg_electronic_card` / `TControllerCartaoEletronico`
  / `TB_CARTAOELETRONICO` — verificados em `view/module/banking/register/`):
  o contrato vincula uma FORMA DE PAGAMENTO (`cte_codfpt`); quando a forma é usada,
  o sistema verifica o contrato e, existindo:
  - baixa no banco com **PRÉVIA de quando o dinheiro cai** (prazo do contrato:
    `cte_przo_cred`/`cte_przo_debi`) — lançamento FUTURO (o `MVF_VL_FUTURO` do
    movimento)
  - aplica a TAXA do cartão (`cte_aliq_cred`/`cte_aliq_debi`) e já faz os lançamentos
  - o usuário **CONCILIA no dia** com o extrato bancário (manual hoje — oportunidade
    de automação na web, junto com a API de boleto)

### 5.3 TEF — DESCARTADO desta frente

Decisão do autor: TEF só existirá no PDV. Não entra no desenho do financeiro web
da retaguarda.

### 5.4 CAIXA / fechamentos

- Caixa é aberto **POR DIA e POR USUÁRIO**; usuário NÃO pode abrir dois caixas no
  mesmo dia.
- Operações que EXIGEM caixa aberto: PDV, baixas em DINHEIRO e CHEQUE,
  cancelamentos de financeiro — sem caixa aberto, alerta. (Verificado:
  `Fc_VerificaCaixaAberto` guarda as operações em `Un_Caixa.PAS` e afins;
  coerente com a regra do estorno em §3.6.)

### 5.4b Modelagem do caixa web — parecer setes-conceito (2026-08-22)

Motivação: `billing` precisa de baixa automática à vista; DINHEIRO ESPÉCIE
(`kind='E'`) exige caixa aberto, PIX (`kind='X'`) não (vai pra conta
corrente pré-cadastrada — fora deste parecer). Caixa hoje só existe como
escrita do SYNC (`tb_cashier`/`tb_cashier_items`, baseline, dormentes pro
lado web — nenhum endpoint abre/fecha caixa na API).

**Achado no legado** (`Un_Caixa.PAS`+`Un_Caixa_Fechamento.pas`, lidos pelo
agente): `TB_MOVIM_FINANCEIRO.MVF_CODCTB=0` já é precedente real de "razão
único com marcador de natureza" — mas a hipótese anterior desta memória
(`bankAccountId=0` como conta bancária SENTINELA em `tb_bank_account`) foi
**REJEITADA** (teste da maqueta: exigiria 3 guardas de exceção — pular FK,
esconder do lookup, proteger de edição — sintoma de maquete forçada; o
legado marca a natureza do MOVIMENTO, nunca finge conta bancária zero).

**Modelagem aprovada**:
- `tb_cashier` (baseline) = a SESSÃO (abrir/fechar por dia+usuário+terminal)
  — reaproveitar como está; web ganha endpoints de abrir/fechar.
- `tb_cashier_items` (baseline, dormente) = NÃO é movimento — é a
  CONFERÊNCIA do fechamento (registrado × digitado por forma de
  pagamento), a mesma tela do legado nunca escrita pela web.
- Movimento em espécie = a peça financeira imutável JÁ existente
  (`tb_financial_payment`/`tb_financial_statement`, motor do módulo
  `settlements`), com `tb_cashier_id` como CONTEXTO/precondição — sem
  sentinela de conta bancária. Baixa em espécie sem caixa aberto = 409
  `CASHIER_NOT_OPEN` (equivalente ao `Fc_VerificaCaixaAberto` do legado).
- Saldo do caixa = DERIVADO (soma dos movimentos da sessão), nunca
  armazenado — mesmo princípio do financeiro imutável.
- Fora do conceito de caixa (não herdar): bloqueio de NFC-e pendente no
  fechamento (regra fiscal, domínio separado) e expiração de payback no
  fechamento (side job do legado).

**Questões para a rodada (Q-Caixa 1-6) — FECHADAS e EXECUTADAS (2026-08-22)**:
1. `tb_financial_statement.tb_cashier_id` — SIM, coluna nova (migration 033).
2. Caixa web × PDV — terminal FIXO 0 pra web (nunca colide com PDV 1..N).
3. Fechamento — replica o legado: conferência é auditoria, NÃO bloqueia
   diferença.
4/6. Escopo — COMPLETO: ciclo abrir→baixar→retirada avulsa→fechar com
   conferência+transferência, tudo nesta rodada.

**IMPLEMENTADO**: peça `@shared/financial-settlement` (`settleOneTitle` —
baixa de 1 título sem lote/parcerias; `writeManualCashierMovement` —
retirada/transferência, mesma operação com destino opcional;
`tryAutoSettleCash` — dispara em `billing` pra `kind='E'`, SEM bloquear o
faturamento se não há caixa aberto, decisão do Valdo) + módulo `cashier`
(open/current/:id balance/:id withdraw/:id close). Gate de "preferência de
uso" (`usage_preference` já existia em `tb_institution_has_payment_types`,
migration 012 — 'B' pula o caixa, sem conta pra escolher automaticamente).
23 testes novos (financial-settlement + cashier + wiring no billing);
352/352 api.

### 5.5 Adiadas para o futuro (decisão do autor, 2026-08-16)

- **Receber Descontada** (antecipação de recebíveis + devolução) — FICA PARA O
  FUTURO; relação com o desconto de cheque na factory (§5.1) a esclarecer quando
  reabrir
- **Fechamento financeiro** (`Un_Fecha_Financeiro`, `tb_Fecha_Financeiro`) ×
  fechamento de caixa — sem instrução ainda; não bloqueia o núcleo

## 6. Prontidão para código (análise 2026-08-16)

**Escopo-alvo declarado**: ordem → nota (mercadoria+serviço, impostos calculados) →
financeiro (nascimento/meios/vida/morte + caixa + cheque + cartão).

**Veredito: o MAPEAMENTO é suficiente para o escopo-alvo.** O que falta não é
conhecimento do legado — são DECISÕES DE DESENHO web e a cadeia de governança do
workspace. Antes do código:

1. **Rodada de decisões** (uma só, consolidada):
   - D-a..D-h do redesenho `tb_tax_rule` (§6.5 do tributacao.md — parcialmente decididos)
   - Tradução mutável→imutável do financeiro: o título web REUSA as peças
     settlements/movimento do Software House ou nasce peça própria?
   - Peça de NEGOCIAÇÃO no pedido (forma+prazo; formato `028/056/084` mantém?)
   - Meio de pagamento TIPADO (extensão da `tb_payment_types` — mata o
     `FPT_DESCRICAO` por texto)
   - Cheque como portador de dívida (2 elos de quitação) e caixa por dia/usuário —
     confirmar modelagem
2. **Cadeia obrigatória do workspace**: `guardiao-conceitual`/`setes-conceito` nos
   conceitos novos → `refinar-prompt-arquitetura` (transforma plano-web + este
   arquivo em prompt de fase) → `PADROES_BANCO.md` + `revisar-ddl` no DDL
3. **Restrições vivas**: contrato de ESPELHO do sync (formato 5.5,
   `CONTRATOS_SYNC.md`) não pode quebrar; autorização GUARDADA não bloqueia (o
   marco é nota PRONTA, não transmitida)

**Fora do escopo do primeiro código** (não bloqueiam): autorização/transmissão,
Receber Descontada, fechamento financeiro, TEF (PDV), boleto por API Inter
(requisito registrado p/ fase própria).
