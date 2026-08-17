# Processo Pedido → Nota Fiscal (Venda / Compra / Ajuste)

**Escopo**: setes
**Fonte**: instrução do autor (Valdo, 2026-08-15) + verificação no código
**Código**: `Infra-IA/codigo-aprendizado/Gestao2016/`

## 1. O tronco

Três processos compartilham a MESMA tabela `tb_pedido` e o MESMO controller
`TControllerPedido`. O que os separa é UM campo: `PED_TIPO`.

| PED_TIPO | Processo | Direção do estoque |
|---|---|---|
| 1 | Venda | Saída |
| 2 | Compra | Entrada |
| 3 | Ajuste | Entrada e Saída |
| 4 | Venda pela internet | Saída |

`PED_TIPO = 4` é **venda pela internet** e segue os MESMOS padrões do tipo 1 — foi
diferenciado só para identificar a origem. Por isso as consultas de movimento filtram
1 e 4 juntos (`Un_Clta_Mov_Produtos.pas:265`, `Un_Pesq_NF_Pro.pas:189`): é o
comportamento correto, não um bug.

Valores mortos (autor, 2026-08-15): **`PED_TIPO = 0` pode ser ignorado**;
**`PED_TIPO = 5` (consignação, `ControllerDskConsignment.pas:190`) foi DESCONTINUADO** —
não modelar na web.

Cada processo tem a mesma tríade de units — pedido → faturamento → geração da NF-e:

| Processo | Pedido (tela) | Faturamento | Geração NF-e |
|---|---|---|---|
| Venda | `Tarefas/UN_Pedido_Vda.pas` | `Tarefas/UN_Fatura_Vda.pas` | `Ajuda/un_geranfe_vda.pas` |
| Compra | `Tarefas/UN_Pedido_Cpa.pas` | `Tarefas/UN_Fatura_Cpa.pas` | `Ajuda/un_geranfe_cpa.pas` |
| Ajuste | `Tarefas/UN_Pedido_Ajt.pas` | `Tarefas/UN_Fatura_Ajt.pas` | `Ajuda/un_geranfe_ajt.pas` |

As três classes de geração de NF-e herdam do MESMO molde — confirmado no código:

- `TFr_GeraNfe_vda = class(TTasGeraNfeAutorizacao)` — `un_geranfe_vda.pas:8`
- `TFr_GeraNfe_Ajt = class(TTasGeraNfeAutorizacao)` — `un_geranfe_ajt.pas:8`
- `TFr_geranfe_cpa = class(TTasGeraNfeAutorizacao)` — `un_geranfe_cpa.pas:9`

## 2. O elo pedido × nota

Faturado, o pedido vira nota em `tb_nota_fiscal`. A tabela de itens `TB_ITENS_NFL`
é COMPARTILHADA entre nota e pedido — ela carrega as duas chaves ao mesmo tempo:

```
TB_NOTA_FISCAL.NFL_CODIGO = TB_ITENS_NFL.ITF_CODNFL
TB_PEDIDO.PED_CODIGO      = TB_ITENS_NFL.ITF_CODPED
```

Confirmado em `model/tblItensnfl.pas`: `[TableName('tb_itens_nfl')]` com os campos
`ITF_CODIGO` (PK), `ITF_CODPED` e `ITF_CODNFL`.

**Consequência**: o item é o ponto onde pedido e nota se encontram — não existe tabela
de ligação separada. É o mesmo princípio que a web adotou depois (1 nota = 1 order,
a PK vinculando o processo inteiro — ver `Infra-IA/setes-sync/prompt_notas_mercadoria_servico.md`).

## 3. Modelo de dados do pedido

`model/tblPedido.pas` → `[TableName('tb_pedido')]`, 51 propriedades, campos `PED_*`.

Campos que sustentam a sincronia com a web: `CodigoWeb` (`PED_CODIGO_WEB`),
`NumeroWeb`, `Terminal` — a dimensão de PDV já existe no legado.

## 3.1 Controllers — a separação de responsabilidades já começou

**Instrução do autor (2026-08-15)**: o sistema vem passando por reformas modestas, e uma
delas foi começar a separar as responsabilidades por processo. Verificado no código:

```
TControllerPedidoVenda  = class(TControllerPedido)   ControllerPedidoVenda.pas:8   ← DESCONTINUADO (§5.8)
TControllerPedidoCompra = class(TControllerPedido)   ControllerPedidoCompra.pas:9
TControllerPedidoAjuste = class(TControllerPedido)   ControllerPedidoAjuste.pas:8
```

**Isto é técnica a PRESERVAR** na web quando se fala de *order como backbone*: um tronco
comum (`TControllerPedido` sobre `tb_pedido`) com especialização por processo — não três
implementações paralelas. (O PADRÃO é o que se preserva; a subclasse `Venda` em si está
descontinuada e será excluída — §5.8.)

Sobre a Q3: `TControllerPedidoVda` (o quarto, de nome parecido) também herda
`TControllerPedido` e é consumido pelo PDV/varejo (`Un_FrenteCaixa`, `Un_Pizzaria`,
`Un_Cupom_Fiscal`, `Un_Lanca_Command`, `sea_loja_tray_order`). Resolvido em §5.8:
`...Venda` morre; os membros de ponte web (`TObjOrderSale`, `saveObjWeb`,
`ValidasaveObjWeb`, `FillDataObjeto`) morrem junto, inclusive no `...Vda`.

## 4. Divergências entre a instrução e o código

Registradas como achados, não como erro — o código mudou de nome ao longo de 30 anos.

| # | Instrução | Código real | Severidade |
|---|---|---|---|
| D1 | `un_faturar_vda` / `_ajt` / `_cpa` | Os arquivos chamam-se `UN_Fatura_Vda.pas`, `UN_Fatura_Ajt.pas`, `UN_Fatura_Cpa.pas` (pasta `Tarefas/`) | 🟢 só nomenclatura |
| D2 | Três processos | Existem MAIS faturamentos: `UN_Fatura_Srv`, `UN_Fatura_cst`, `Un_Fatura_Dsp` (despacho), `Un_Fatura_Fin`, `Un_Fatura_Web` | ✅ CONFIRMADO pelo autor — os três eram recorte didático. **`UN_Fatura_Srv` está DESCONTINUADO** (ficou em desenvolvimento, ignorar); os demais ⚠️ ainda sem instrução |
| D3 | NF-e herda `TTasGeraNfeAutorizacao` | Vale para vda/ajt/cpa. **`un_geranfe_Srv.pas:18` é `class(TForm)`** — a NFS-e ficou FORA do molde | ✅ EXPLICADO — não é falha: nota de MERCADORIA e de SERVIÇO têm ORIGENS DIFERENTES, herdar seria forçar. Vira frente de trabalho (§6) |
| D4 | `PED_TIPO` = 1, 2, 3 | Também existem 0, 4 e 5 no código | ✅ RESOLVIDO — 4 = venda pela internet (mesmos padrões do 1); 0 = ignorar; 5 = descontinuado. Ver §1 |

### `PRO_TIPO` — os cinco tipos de produto (autor, Q5 respondida)

| Valor | Significado | Situação |
|---|---|---|
| `P` | **Produto acabado** — o mais usado | ativo |
| `S` | Serviço | ativo |
| `M` | Matéria-prima | módulo de **Produção** — tratar no futuro |
| `A` | Produto **automático** | módulo **Pizzaria** — tratar no futuro |
| `C` | Produto de consumo | pouco usado — tratar no futuro |

O código de autorização (§5.6) só distingue `P` e `S`. ⚠️ O que acontece com um item
`A`/`M`/`C` numa nota não foi instruído — fica com os módulos futuros.

### Os demais faturamentos (autor, 2026-08-15)

| Unit | Situação |
|---|---|
| `Un_Fatura_Fin` | **VIVO e no meio do processo**: quando o cliente NÃO escolhe o modo automático, esta tela aparece durante o faturamento para gerar o financeiro (é o par de `Pc_Gera_FinanceiroManual`, §5.2) |
| `UN_Fatura_cst` | registrado para tratar no futuro |
| `Un_Fatura_Dsp` | registrado para tratar no futuro |
| `Un_Fatura_Web` | **DESCONTINUADO** — tudo estará na web |
| `UN_Fatura_Srv` | **DESCONTINUADO** — ficou em desenvolvimento |

### Anotação guardada — notas conjugadas (Q8)

`OSR_G_NFSE_CONJ` trata de **notas conjugadas com mercadoria e serviço tratadas pelo
Estado dentro da NF-e**. Decisão do autor: **ignorar por ora**, anotação guardada para o
futuro. Não modelar na web agora.

### Questões em aberto

*(nenhuma no momento — frentes futuras listadas em §7)*

### Questões respondidas

- ~~Q1 (D4)~~ — tipos 0/4/5 esclarecidos (§1), 2026-08-15
- ~~Q2 (D2/D3)~~ — serviço não é caso particular da mercadoria: origem diferente (§6), 2026-08-15
- ~~Q3~~ — os dois estão vivos com papéis distintos; a hierarquia é intencional (§3.1), 2026-08-15
- ~~Q4~~ — `TB_RETORNO_NFS.NFS_NUMERO`; processos de numeração diferentes (§5.3), 2026-08-15
- ~~Q5~~ — cinco tipos de produto mapeados (§4), 2026-08-15
- ~~Q6~~ — movimento em `TB_CTRL_ESTOQUE` + trigger `TG_ESTOQUE_INSERT` (§5.5), 2026-08-15
- ~~Q9~~ — letra 2 = ORIGEM DE EMISSÃO (interna × externa); domínio completo incl.
  `SC`/`EC` complementar em §5.7, 2026-08-16
- ~~Q11~~ — regra FISCAL: complementar só pelo mesmo emitente (= interna); web mantém
  (§5.7), 2026-08-16
- ~~Q12~~ — complementar NÃO movimenta estoque; sem exceção — a peça não é encaixada
  (`Estoque := 'N'` por item; quem decide movimento é `ITF_ESTOQUE`, não o tipo da nota)
  (§5.7), 2026-08-16
- ~~Q10~~ — `ControllerPedidoVenda` DESCONTINUADO (será excluído), junto com
  `TObjOrderSale`/`saveObjWeb`/`ValidasaveObjWeb`/`FillDataObjeto` (§5.8), 2026-08-16
- ~~Q7~~ — confirmado: é o **Ajuste** (`un_fatura_ajt`) que faz entrada e saída no
  faturamento (§5.5), 2026-08-15
- ~~Q8~~ — notas conjugadas tratadas pelo Estado na NF-e; ignorar por ora (§4), 2026-08-15

## 5. A frente de Venda, passo a passo

**Fonte**: instrução do autor (2026-08-15), verificada linha a linha no código.

### 5.1 `UN_Pedido_Vda.pas` — UMA tela, DOIS pedidos

A tela trata **Pedido de Venda** e **Pedido de Serviço** no mesmo lugar. Os itens vivem
num `PageControl` (`PG_Itens`) com quatro abas — cada uma com listar / incluir /
alterar / excluir:

| Aba | Índice | Ativada por |
|---|---|---|
| Produto | `Pages[0]` | sempre visível |
| **Serviço** | `Pages[1]` | `OSR_G_ATIVAR` (default `'S'`) |
| Devolução | `Pages[2]` | `GRL_G_TAR_DEVOLUCAO` (default `'N'`) |
| Troca | `Pages[3]` | `GRL_G_TAR_TROCA` (default `'N'`) |

Confirmado em `UN_Pedido_Vda.pas:1097-1125`. A leitura é feita por
`Fc_Tb_Geral('L', <parâmetro>, <default>)` — **configuração do cliente**, exatamente como
o autor descreveu: ativada a aba de Serviço, o mesmo cliente faz as duas coisas.
Junto com a aba, `OSR_G_ATIVAR` também liga o campo `E_Vl_Servico` e a busca por placa.

⚠️ Nota de nomenclatura: o parâmetro chama-se `OSR_` (ordem de serviço), não `SRV_`.

### 5.2 `UN_Fatura_Vda.pas` — o faturamento (1.144 linhas)

Consome o pedido (de venda e/ou serviço) e executa, nesta ordem — `Pc_Faturar`:

1. **Verifica a tributação** — classe `ttributacao` (unit `tributacao`), instanciada como
   campo `Tributacao` da tela. `Tributacao.Fc_Valida` roda quando `It_Usa_Nfe`
2. **Gera a nota fiscal** — via `Tributacao.NotaFiscal` (`RN_NotaFiscal`);
   `Fc_Faturar_Normal` é o caminho principal (`Rg_Faturamento.ItemIndex = 0`)
3. Devolução (`GRL_G_TAR_DEVOLUCAO`), comissão (`Pc_Gera_Comissao`), despacho
   (`DSP_G_CTRL_DESPACHO`), cupom não fiscal, atualização de números de série
4. **Gera o financeiro** — `Pc_Gera_Financeiro`, que bifurca em
   `Pc_Gera_FinanceiroManual` × `Pc_Gera_FinanceiroAutomatico`, seguido do boleto
   automático quando `ValidaGeraroBoletoAutomatico`

⚠️ **O financeiro é CONDICIONAL**: só roda se `FIN_G_ATIVAR = 'S'`
(`UN_Fatura_Vda.pas:424`). Faturar sem gerar financeiro é estado possível no legado.

### 5.3 Autorização — os dois caminhos

| Nota | Unit | Quem chama |
|---|---|---|
| Mercadoria | `Ajuda/un_geranfe_vda.pas` | `UN_Fatura_Vda` direto (`uses` + `ChamaTelaAutorizacao`, linha 961) |
| Serviço | `Ajuda/un_geranfe_Srv.pas` | `RegraNegocios/RN_NotaFiscalServico.pas` |

### Dois processos de numeração DIFERENTES (autor, Q4 respondida)

| | Mercadoria | Serviço |
|---|---|---|
| Como nasce o número | **o sistema gera o número** e pede autorização | **o sistema gera um RPS** (Recibo Provisório de Serviço), envia, e **recebe a nota já numerada** |
| Onde fica | `TB_NOTA_FISCAL.NFL_NUMERO` | **`TB_RETORNO_NFS.NFS_NUMERO`** |

Verificado em `model/tblRetornoNFS.pas` — `TB_RETORNO_NFS` traz
`NFS_CODNFL` (**o elo com a nota**), `NFS_RPS`, `NFS_LOTE`, `NFS_NUMERO`,
`NFS_PROTOCOLO`, `NFS_COD_VERIF`, `NFS_CODSIT`, `NFS_MOTIVO`, `NFS_ARQUIVO`.

**A assimetria é do domínio, não do código**: na mercadoria o número é nosso e a
autorização confirma; no serviço o número é da prefeitura e chega depois. É a raiz
concreta do "origens diferentes" (D3). **Na web isto será redesenhado** (decisão do
autor) — ver §6.

**Achado que reforça o D3**: não é só a herança que difere — o *caminho de chamada*
também. A NF-e de mercadoria é acionada pela tela de faturamento; a NFS-e é acionada
pela regra de negócio. Duas origens, dois trajetos.

## 5.4 Superfície da tela de Venda (medida)

`UN_Pedido_Vda.pas`: 6.239 linhas + 5.092 de `.dfm`; classe `TFr_Pedido_Vda`;
consumida por **39 units**; mais de 120 métodos privados.

Verticais embutidos DENTRO da tela de pedido: `AbrirOrdemServico`, `...AutoCenter`,
`...Extintores`, `...Eletronicos`, `...PetShop`, `...Moveleiro`, `...PrintShop`.

Canais de saída: `Envia_impressao`, `Envia_email`, `Envia_whatsApp`, `EnvioPedidoParaDespacho`.

Tabelas tocadas pelo SQL da tela: `tb_pedido`, `tb_empresa`, `tb_prazo`, `tb_produto`,
`tb_preco`, `tb_estoque`, `tb_serie_produto`, `tb_colaborador`, `tb_sale_origen`,
`tb_customer_origen`, `tb_vehicle_so`.

## 5.5 `componentes/tributacao.pas` — o coração do faturamento

**Instrução do autor (2026-08-15)**: `UN_Fatura_Vda` / `UN_Fatura_Ajt` / `UN_Fatura_Cpa`
fazem um dos papéis mais importantes do sistema, e o fazem através de
`componentes/tributacao.pas` (**5.847 linhas**), que processa o pedido quanto à
tributação **entre emitente e destinatário em relação ao produto escolhido**:

1. Gera os impostos — ICMS / IPI / PIS / COFINS / ISSQN
2. Gera a nota fiscal
3. Atualiza o estoque

### Regra de estoque por processo (instrução do autor)

| Processo | Quando o estoque é atualizado | Por quê |
|---|---|---|
| Venda | **Ao inserir o item** no pedido | a reserva do produto precisa ser imediata |
| Compra | **Só no faturamento** | — |
| Ajuste | **Só no faturamento** — pode ser entrada OU saída | — |

### Como o saldo é escrito (respondido pelo autor — Q6)

O Delphi **nunca escreve o saldo**. Por isso a busca por `UPDATE tb_estoque` no código
não achava nada (só `RN_NovaEstruturaDados.pas`, que cria estrutura) e `RN_Estoque.pas`
só expõe leitura (`Fc_SaldoEstoque`, `Fc_SaldoAnteriorEstoque`).

A cadeia real é:

1. `Controller/ControllerCtrlEstoque.pas` registra o **movimento** em `TB_CTRL_ESTOQUE`
2. Uma **trigger no Firebird** aplica o movimento sobre o saldo de `tb_estoque`

```sql
CREATE OR ALTER TRIGGER TG_ESTOQUE_INSERT FOR TB_CTRL_ESTOQUE
ACTIVE AFTER INSERT POSITION 0
AS begin
  if (NEW.cet_operacao = 'E') then
    UPDATE tb_estoque SET EST_QTDE = EST_QTDE + NEW.cet_qtde
     WHERE EST_CODPRO = NEW.cet_codpro AND EST_CODETS = NEW.cet_codets;
  else
    UPDATE tb_estoque SET EST_QTDE = EST_QTDE - NEW.cet_qtde
     WHERE EST_CODPRO = NEW.cet_codpro AND EST_CODETS = NEW.cet_codets;
end
```

**Consequência para a web**: `tb_estoque` é SALDO DERIVADO; a verdade é o movimento em
`TB_CTRL_ESTOQUE`. Quem reescrever isso não deve replicar o saldo como fonte.

**Achado (verificado, não instruído)**: a operação não é escolhida no Delphi — ela é
**derivada do tipo da nota**. Em `ControllerCtrlEstoque.pas:753` e `:976`:

```sql
substring(NFL_TIPO FROM 1 FOR 1) AS CET_OPERACAO
```

A primeira letra de `NFL_TIPO` é o `E`/`S` do movimento — o que explica por construção
como o Ajuste faz entrada OU saída (§5.5, Q7). O domínio completo está em §5.7.

Outro elo: `ControllerCtrlEstoque.pas:593` liga o movimento ao item da nota —
`tb_ctrl_estoque.cet_item_ctrl = ITF_CODIGO`.

## 5.6 A decisão de autorizar: mercadoria × serviço

**Instrução do autor**: há uma verificação no pedido — se existe `tb_itens_nfl` ligado a
`tb_produto.PRO_TIPO = 'S'`.

**Verificado — com uma correção de local**: a decisão NÃO está em
`RN_NotaFiscalServico.pas` (essa unit é a fachada: abre tela, envia e-mail, valida
ativação/certificado). Ela está em **`UN_Fatura_Vda.ChamaTelaAutorizacao`
(linhas 961-1018)**, que varre `Tributacao.Qr_ItensPedido` e liga dois flags:

```
Lc_produto := existe item com PRO_TIPO = 'P'
Lc_Servico := existe item com PRO_TIPO = 'S'
Lc_Nf_Conjugada := (Fc_Tb_Geral('L','OSR_G_NFSE_CONJ','N') = 'S')
```

E então:

| Condição | Ação |
|---|---|
| `(Lc_produto OR Lc_Nf_Conjugada)` e checkbox NF-e marcado | abre `TFr_GeraNFe_vda` — NF-e de mercadoria |
| `Lc_Servico` e checkbox marcado **e NÃO conjugada** | `Fc_ChamarGeraNFSE('NFS-e', ...)` — NFS-e |

**Achado**: o parâmetro `OSR_G_NFSE_CONJ` (default `'N'`) é a chave do comportamento
conjugado — quando ligado, o serviço sai DENTRO da NF-e de mercadoria e a NFS-e
**não é emitida**. É configuração do cliente, e mais um caso do padrão "o comportamento
do processo depende de `Fc_Tb_Geral`". → **Q8**.
**Atualização (2026-08-16, Q29 da tributação)**: o autor confirmou que essa modalidade
(serviço dentro do XML da NF-e 55) está **em desuso e NÃO vai para a web** — na web
cada ramo autoriza no seu documento (NF-e × NFS-e). O pedido/nota MISTOS continuam.

## 5.7 `NFL_TIPO` — direção e origem de emissão (respondido — Q9)

**Instrução do autor (2026-08-15)**: `NFL_TIPO` informa **direção** (letra 1) e **origem
de emissão** (letra 2). Algumas operações fiscais dependem dessa informação.

| Valor | Significado |
|---|---|
| `SI` | Saída interna |
| `SE` | Saída externa |
| `EI` | Entrada interna |
| `EE` | Entrada externa |
| `SC` | Saída complementar — nota complementar, usada para complementar uma nota com falta de impostos |
| `EC` | Entrada complementar — ⚠️ **não instruído; encontrado no código** (ver abaixo) |

**Verificado**: os quatro primeiros aparecem em consultas por todo o sistema, e os filtros
combinam ora por letra 1 — `(SI ou SE)` × `(EI ou EE)` — ora por letra 2 —
`(SI ou EI)` × `(SE ou EE)`, coerente com serem dois eixos independentes.

**Achado (verificado, não instruído)** — `Ajuda/Un_Nfe_Complementar.pas:487-497`:

```pascal
if NFL_TIPO = 'SI' then lc_tipo := 'SC'   // saida complementar
else if NFL_TIPO = 'EI' then lc_tipo := 'EC'   // entrada complementar
else ShowMessage('Essa nota não pode ter uma complementar'); EXIT;
```

Dois fatos que a instrução não trouxe:

1. **`EC` existe** — a complementar espelha a direção da nota original, então há entrada
   complementar além da saída complementar.
2. **Só nota INTERNA aceita complementar.** `SE` e `EE` são recusadas com "Essa nota não
   pode ter uma complementar". A regra está codificada na tela, não no banco. → **Q11**

Complementar também grava `Registro.Finalidade := '2'` (finalidade da NF-e) e é disparada
de `Un_NF_55.pas:1212` sob a permissão `'GERAR COMPLEMENTAR'`.

### Por que só interna (respondido — Q11)

**Instrução do autor (2026-08-16)**: nota complementar **só pode ser emitida pelo mesmo
emitente** — por isso, só interna. É REGRA FISCAL, não limitação da tela: a segunda letra
de `NFL_TIPO` marca justamente quem emitiu (interna = emissão própria), e `SE`/`EE` são
notas de emissão de terceiros, que não se pode complementar. **A web mantém a regra.**

### Complementar não movimenta estoque (respondido — Q12)

**Instrução do autor (2026-08-16)**: NÃO movimenta — só há complemento de impostos, nenhum
outro dado da nota se altera. **Não existe exceção**: o processo de registro de estoque
simplesmente não acontece. Lego/nuvem: *nesta nota, essa peça não é encaixada*.

**Verificado — a peça desencaixada é visível no código**:

1. `Un_Nfe_Complementar.pas` **não referencia** `ControllerCtrlEstoque` (a lista de quem
   chama o controller não o inclui);
2. ao montar os itens da complementar, cada item nasce com **`Estoque := 'N'`**
   (`Un_Nfe_Complementar.pas:985`) — o mesmo flag por item que em `tributacao.pas`
   aparece como coluna `ITF_ESTOQUE`.

**Consequência para a web**: o movimento de estoque não é função do tipo da nota
(`substring(NFL_TIPO,1,1)` é só a DIREÇÃO quando há movimento); quem decide SE há
movimento é o **flag do item** (`ITF_ESTOQUE`). Duas peças independentes: direção ×
encaixe. O desenho web deve manter essa separação — nota complementar = ramo fiscal
sem ramo de estoque.

## 5.8 Ponte web do Delphi — DESCONTINUADA (respondido — Q10)

**Instrução do autor (2026-08-15)**:

- **`Controller/ControllerPedidoVenda.pas` está descontinuado — será excluído.**
- **`TObjOrderSale`, `FillDataObjeto`, `saveObjWeb`, `ValidasaveObjWeb` estão
  descontinuados** e serão removidos na revisão da versão. **Ignorar.**

Isso encerra a Q10 e é coerente com a regra canônica dos dois grupos: quem conversa com a
web é o **Sincronizador → setes-sync**, não o Gestao2016 direto
(ver `Infra-IA/setes-sync/prompt_revisao_sincronizador_setes_sync.md`, D1).

**Consequência para a leitura do código**: tudo que aparecer como `ObjOrderSale`/`saveObjWeb`
em qualquer controller é resíduo da ponte antiga — **não modelar na web, não usar como
referência de contrato**. O que sobra de vivo em `TControllerPedidoVda` é o uso pelo
PDV/varejo (`Un_FrenteCaixa`, `Un_Pizzaria`, `Un_Cupom_Fiscal`, `Un_Lanca_Command`,
`sea_loja_tray_order`).

O molde do *order backbone* é, portanto, a tríade viva:
`TControllerPedido` ← `{Venda*, Compra, Ajuste}` — com a ressalva de que a subclasse
`Venda` some na revisão (*seu único consumidor era a consignação, também descontinuada*).

## 6. Frente ABERTA — Mercadoria × Serviço (desktop → web)

**Decisão do autor (2026-08-15)**: `un_geranfe_Srv` não herda `TTasGeraNfeAutorizacao`
porque **nota fiscal de mercadoria e nota fiscal de serviço têm ORIGENS DIFERENTES**.
A ausência de herança é consequência do domínio, não dívida técnica.

**Objetivo da frente**: mapear COMO o desktop faz hoje, para desenhar bem na web.

### Respondido pelo autor (2026-08-15)

- **Onde grava**: mercadoria e serviço usam a MESMA `tb_nota_fiscal` — "o que evolui na
  web" — e ambos usam `TB_ITENS_NFL`. Não há tabela de nota separada para serviço.
- **Pedido conjugado gera UMA nota apenas**, com `TB_NOTA_FISCAL.NFL_NUMERO` para
  mercadoria. ⚠️ A instrução ficou interrompida aqui e o número do serviço não foi
  informado → **Q4** (não presumido).
- **`UN_Fatura_Srv` está DESCONTINUADO** — ficou em desenvolvimento. **Ignorar.**
  (Some da frente; não modelar na web.)
- **O financeiro do serviço passa pelo MESMO `Pc_Gera_Financeiro`.**
- **A decisão de autorizar** está mapeada em §5.6 (com correção: está no faturamento,
  não em `RN_NotaFiscalServico`).

**Elo com o que já foi decidido na web**: a Rodada de "Notas de Mercadoria × Serviço"
(`Infra-IA/setes-sync/prompt_notas_mercadoria_servico.md`, 2026-07-26) definiu natureza
por RAMO (nunca coluna) e `tb_product.kind P|M|S`. Este mapeamento do desktop precisa
ser confrontado com aquelas decisões — se divergir, a divergência é decisão do Valdo.

## 7. Pendente de instrução

- ⚠️ Fato gerador e ciclo de vida do pedido (o que o cria, o que o fecha)
- ⚠️ O que exatamente faz `PED_FATURADO` virar 'S' e em que transação
- ⚠️ Regras de estoque por tipo (quando baixa, quando devolve)
- ⚠️ Financeiro: como a nota gera o contas a receber/pagar
