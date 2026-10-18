# Anexo 2 — Cadastro de produtos do legado aba a aba × quebra da TB_PRODUTO na web

**Escopo**: setes (o método — inventariar a tela legada campo a campo e mapear cada coluna para o modelo novo ANTES de desenhar a
tela nova — é portável; o conteúdo é do Gestão 2027)
**Origem**: pedido do Valdo na Rodada 1 parcial (2026-10-17): "caso não tenha analisado o `Un_Produtos.pas`, faça; depois compare com a
montagem na web que quebrou a TB_PRODUTO do Firebird em 3 tabelas". Leitura SÓ do fonte do Gestao2016 + DDL do baseline web; o
setes-sync e as classes do sincronizador NÃO foram lidos (regra dos dois grupos).
**Prompt principal**: `prompt_modulo_products.md` (§10 usa este anexo para reorganizar a tela).
Marcas: [CÓDIGO] conferido no fonte · [INFERÊNCIA] dedução · [WS13] = mapeamento do envio legado para a web de 2013
(`D:\Gestao2016\Funcao\ws_gestao2013.pas` — é de onde vieram os nomes do baseline; mostra o mapeamento ORIGINAL sem ler o setes-sync).

Abreviações: **P** = `D:\Gestao2016\Arquivos\Un_Produtos.pas` · **D** = `Un_Produtos.dfm` · **C** = `Controller\ControllerProduto.pas` ·
**M** = `model\tblProduto.pas` · **DDL** = `Scripts\Banco2022\CriarTodasAsTabelas.sql` (TB_PRODUTO 2815-2875) · **NED** =
`RegraNegocios\RN_NovaEstruturaDados.pas` · **B** = `setes-api/src/migrations/sql/001_baseline.sql`.

---

## 0. Achados novos (corrigem ou ampliam o anexo 1, §2)

1. **"Qtde. tributável" nunca é gravada — e a NF-e USA esse fator** [CÓDIGO, conferido]: `E_Qtde_Trib` só é declarado (P:201);
   `PRO_QTDE_TRIB` existe no DDL e falta no model; a NF-e calcula `qTrib = qCom × PRO_QTDE_TRIB` e só usa `PRO_CODMED_TRIB` quando o fator
   é > 0 (`Ajuda/un_geranfe3X.pas:1191-1209`). ⇒ **a "Unidade Tributável" escolhida na tela não tem efeito na NF-e.**
2. **Comissão e margem INVERTIDAS no mapeamento de 2013** [CÓDIGO, conferido]: `ws_gestao2013.pas:1605-1606` grava `PRC_AQ_COM`
   (comissão) em `aliq_profit` e `PRC_MAR_LRC` (margem) em `aliq_kickback`. O setes-api lê `aliq_kickback` como COMISSÃO
   (`@shared/commission/commission.ts:64`). **Se o setes-sync herdou esse mapeamento, a comissão por produto é calculada pela MARGEM** —
   confirmar com o grupo do sync (tarefa separada).
3. Vincular fornecedor apaga vínculos de OUTROS produtos — confirmado (`RN_Produto.pas:64-69`; a tela sempre passa vazio, P:2617-2619).
4. Tabela de preço sem filtro de estabelecimento nem de ativa; o filtro de ativa é SQL inválido (`ControllerTabelaPreco.pas:172-211`).
5. Sair do "Custo Base Troca" recalcula todas as tabelas de preço usando o valor de troca como custo (OnExit errado, D:846).
6. O botão "Impostos" relê o produto do banco ao fechar — edição não gravada se perde (P:1580-1581) [efeito: INFERÊNCIA].
7. `PRO_CODMHA` é reescrito a cada Gravar: o "dono" do produto é o último estabelecimento que gravou (P:962).
8. Default de `PRO_G_COMPARTILHA` diverge: 'N' na tela (P:1659) × 'S' no flag global (`Un_Regra_Negocio.pas:276`).
9. A inclusão não limpa campos: `PRO_DT_VENCIMENTO` sempre recebe uma data (12/05/2008 do dfm ou a do produto anterior);
   `FIXED_RATE` nasce 'S'; sequência, mínimo de reposição, código Tray e grade de benefícios herdam o anterior (P:1279-1353).
10. `E_Codigo` só PARECE desabilitado (D:3190-3205) — digitar um código existente sobrescreveria outro produto [INFERÊNCIA];
    `PRO_APLICACAO` gravado em **Base64** (P:1018).
11. Código morto: aba Botão sem OnClick (D:1958-2008); coluna "Reserva" aponta campo inexistente; `Pc_Valor_Campanha`,
    `Fc_Verifica_Forn`, `Qr_Insere` nunca chamados. `PRO_VENDA` (estado de relatório), `PRO_SEQUENCIA` e `PRO_FABRICADO` sem leitor.
12. **CNPJFab vem do FABRICANTE DA MARCA** (`MRC_CODFAB`, `un_geranfe3X.pas:1220-1228`); a `tb_brand` central não tem fabricante (o
    baseline local tinha `tb_provider_id`, B:124-133).

## 1. As abas (ordem do dfm) — o que cada uma é

Estrutura: cabeçalho fixo + PageControl com **14 abas** em várias linhas + rodapé. 9 abas escondíveis por `PRO_G_ABA_*` (default 'S').
**Gravação**: no Gravar (sem transação única): TB_PRODUTO → benefícios UF → TB_ESTOQUE (saldo 0 em TODOS os depósitos de TODOS os
estabelecimentos) → TB_PRECO (toda linha, mesmo 0) → reposição → Tray. **Na hora** (antes do Gravar): fornecedor, instalação, composição,
produção, série, similar, imagens, regra de tributação.

| # | Aba | Esconde por | Campos (coluna) | Grava | Para que serve |
|---|---|---|---|---|---|
| 0 | **Cabeçalho** | — | código (PRO_CODIGO, GN_PRODUTO) · nº fabricação/montadora (PRO_CODIGOFAB; vazio = código; único só com `PRO_G_VAL_CODIGOFAB`) · código de barras (PRO_CODIGOBAR v20; GTIN pelo ACBr salvo `PRO_G_NAO_VALIDA_EAN`; duplicado oferece abrir o outro) · código do fornecedor (PRO_CODIGOFOR) · NCM (PRO_CODIGONCM v50; obrigatório só com NF-e; aceita vírgula; "8 dígitos" não checado) · **descrição** (100, obrigatória; alterar com movimento pede confirmação) · CEST (7; preenchido força ST; ST exige CEST) · **grupo · subgrupo · marca** (obrigatórios) · última compra (data/valor RO) · última venda (RO) · data de vencimento | Gravar | identidade + classificação fiscal + marca |
| 1 | **Estoque** | `PRO_G_ABA_ESTOQUE` | **embalagem** (obrig.) · divisor · **unidade comercial** (obrig.) · tipo P/M/C/(A) · sequência · revestimento · localização (duplicada só avisa) · peso · largura/comprimento/altura · custo fábrica / custo real (médio) / preço de custo (recalculam preços ao sair) · custo base troca · qtde mínima · disponibilidade (pronta entrega/encomenda) + dias · origem 0–8 · grade de saldo por depósito (RO) · estoque por composição 1–6 + mínimo de reposição | Gravar | unidade de venda + logística + custo + política de estoque + modo de baixa do kit (5 conceitos numa aba) |
| 2 | **Observações** | — | estoque negativo · ativo · não imprimir em tabela (invertido) · promoção · destaque · série · exclusivo de revenda · publicar na internet · fora de linha · escala industrial (indEscala, default S) · detalhes HTML · enviar para a internet | Gravar | flags de catálogo, de venda, de e-commerce e fiscais misturadas |
| 3 | **Tabelas de Preços** | `PRO_G_ABA_TABELA` | grade por tabela: margem · valor · comissão · qtde mínima; **preço fixo** (FIXED_RATE) | Gravar | preço de venda por tabela |
| 4 | **Fornecedores** | `PRO_G_ABA_FORNECEDOR` | grade fornecedor (o código do item no fornecedor, PFR_PRODUTO, nem aparece) | na hora | vínculo de compra (casa o XML do fornecedor) |
| 5 | **Tributação** | `PRO_G_ABA_IMPOSTO` | ST S/N · finalidade 1–7 · unidade tributável (vazia = comercial) · "Qtde. tributável" (NÃO grava) · grade de regras específicas do produto (TB_TRIBUTACAO por estabelecimento) + botão Impostos · benefício fiscal por UF + CST | Gravar / na hora | presunção fiscal + regra do produto + cBenef |
| 6 | **Instalação** | `PRO_G_ABA_INSTALACAO` | serviços de instalação (preço da tabela 1 FIXA) · preço de instalação (soma; grava o valor antigo) | na hora | venda casada produto + serviço |
| 7 | **Composição** | `PRO_G_ABA_COMPOSICAO` | itens do kit (qtde) · recalcula e GRAVA o custo do pai | na hora | kit/conjunto |
| 8 | **Aplicação** | `PRO_G_ABA_APLICACAO` | texto livre (Base64) | Gravar | descrição de uso (autopeças) |
| 9 | **Botão** | `PRO_G_ABA_BOTOES` | botão do PDV de toque — **sem código** | nada | enfeite (morto) |
| 10 | **Séries** | visível com PRO_SERIE='S' | números de série disponíveis · liberar série (admin) · excluir FÍSICO | na hora | rastreio por número de série |
| 11 | **Internet** | — | árvore de categorias "Versão 2013" (PRO_CODCAT; sem valor grava 2) · código do produto na Tray | Gravar | e-commerce |
| 12 | **Produção** | `PRO_G_ABA_INSUMO_PROD` | ficha técnica de insumos (tipo M) · recalcula e GRAVA o custo | na hora | produção/indústria |
| 13 | **Produto Similar** | — | lista de similares (mão única) | na hora | sugestão de venda |
| 14 | **Reposição automática** | visível com `EST_AUTO_REPOSICAO='S'` | pacote grande → menor · método | Gravar | desmembramento de embalagem |
| — | **Menu Tarefas** | — | Imagens (TB_IMAGES — normal/capa/banner; exclusão física) · Tabela de Preço (cadastro) · Variação (TB_PRODUCT_VARIANT/_SKU — tamanho/cor/preço/qtd, SÓ Tray, sem estoque) · Ajustar preço por escala | na hora | e-commerce + manutenção de preço |
| — | **Rodapé** | — | Inserir (Novo/**Cópia**) · Alterar · Excluir (= inativar) · Cancelar · Gravar | — | — |

## 2. TB_PRODUTO coluna a coluna → web

61 colunas (58 do DDL + `PRO_IAT`, `PRO_QTDE_MIN_AUTO_REPO`, `DELETED`). **[WS13]** = está no mapeamento de 2013; **[API]** = lido pelo
setes-api; **[NOME]** = dedução pelo nome.

| # | Coluna | Significado | Aba | Destino web | Nota |
|---|---|---|---|---|---|
| 1 | PRO_CODIGO | código interno (sequência única entre estabelecimentos) | Cab. | `tb_product.id` = `tb_merchandise.id` = `tb_stock.tb_merchandise_id` [WS13:1254] | PK web (id, institution); serviço no mesmo espaço |
| 2 | PRO_CODMHA | estabelecimento "dono" (último a gravar) | — | `tb_product.tb_institution_id` (conceito) | na web vira parte da PK |
| 3 | PRO_CODIGOFAB | código próprio/fábrica (ou chassi) | Cab. | `tb_product.identifier` [WS13:1255] **e** `tb_merchandise.id_internal` [WS13:1341] | mesmo fato em 2 colunas |
| 4 | PRO_CODIGOBAR | GTIN (ou placa) | Cab. | `tb_stock.codebar` [NOME] | identidade guardada no estoque |
| 5 | PRO_CODIGOFOR | código do item no fornecedor (ou Renavan) | Cab. | `tb_merchandise.id_provider` **int** [WS13:1342] | perde alfanumérico; duplica o vínculo produto×fornecedor |
| 6 | PRO_CODIGONCM | NCM | Cab. | `tb_merchandise.ncm` v8 [WS13:1343; API] | renomeado e encolhido |
| 7 | PRO_DESCRICAO | descrição | Cab. | `tb_product.description` [WS13:1257] | — |
| 8 | PRO_CODMED | unidade comercial | Est. | `tb_stock.tb_measure_id` [WS13:1692] | FK central (018) |
| 9 | PRO_CODEMB | embalagem | Est. | `tb_stock.tb_package_id` NOT NULL sem FK [WS13:1691] | — |
| 10–11 | PRO_CODGRP / PRO_CODSBG | grupo / subgrupo | Cab. | sem coluna — viram categoria raiz/filha pela conversão do bootstrap → `tb_category_id` | via TB_CATEGORY |
| 12 | PRO_DIVISOR | divisor | Est. | `tb_stock.divisor` [WS13:1696] | — |
| 13 | PRO_ORIGEM | origem 0–8 | Est. | `tb_merchandise.source` [WS13:1344; API] | — |
| 14 | PRO_TIPO | P/M/C/A (S = serviço) | Est. | `tb_product.kind` (019) + `tb_merchandise.kind` v45 [WS13:1345] | duplicado; C e A sem domínio na web |
| 15 | PRO_LOCAL | localização física | Est. | `tb_stock.location` [WS13:1697] | — |
| 16–19 | PRO_PESO / LARGURA / COMPRIMENTO / ALTURA | peso e dimensões | Est. | `tb_stock.weight/width/length/height` [WS13:1698-1701] | peso perde precisão (14,6 → 10,4) |
| 20 | PRO_VL_FABRICA | custo de fábrica | Est. | `tb_stock.cost_manufactures` [WS13:1702] | — |
| 21 | PRO_VL_CUSTOMED | custo médio ("Custo Real") | Est. | `tb_stock.actual_cost` [WS13:1703] | — |
| 22 | PRO_VL_CUSTOMEDANT | custo médio anterior | — | **SEM CASA** | histórico de 1 nível (o vault não aceita) |
| 23 | PRO_VL_CUSTO | "preço de custo" | Est. | `tb_stock.cost_price` [WS13:1704] | — |
| 24 | PRO_VL_CUSTOANT | custo anterior | — | **SEM CASA** | — |
| 25 | PRO_QTDE_MIN | estoque mínimo do produto | Est. | `tb_stock.minimum` [WS13:1695] | há outro mínimo por depósito em `tb_stock_balance` |
| 26 | PRO_DETALHES | observação/HTML | Obs. | `tb_product.note` [WS13:1263] | — |
| 27 | PRO_SUB_TRIB | ST S/N | Trib. | `tb_stock.st` [NOME] | a web deriva do CEST e ignora |
| 28–30 | PRO_CAMPANHA / DESTAQUE / ATIVO | promoção / destaque / ativo | Obs. | `tb_product.promotion/highlights/active` [WS13:1259-1261] | — |
| 31 | PRO_IMPRIME | imprime em tabela de preço | Obs. | `tb_merchandise.print` [WS13:1347] | caixa invertida |
| 32 | PRO_EST_NEG | permite estoque negativo | Obs. | `tb_stock.negative` [WS13:1705] | — |
| 33 | PRO_EXCLUSIVO | exclusivo de revenda | Obs. | `tb_merchandise.exclusive_dealer` [WS13:1349] | — |
| 34 | PRO_INTERNET | publicar na internet | Obs. | `tb_product.published` [WS13:1262] | — |
| 35 | PRO_MAISVENDIDO | "mais vendido" | — | **SEM CASA** | sem escritor |
| 36 | PRO_VL_INSTALA | soma da instalação | Inst. | **SEM CASA** | derivado |
| 37 | PRO_COMPOSICAO | modo de baixa do kit 1–6 | Est. | `tb_merchandise.composition` [NOME] | — |
| 38 | PRO_APLICACAO | aplicação | Aplic. | `tb_merchandise.application` [WS13:1350] | Base64 |
| 39 | PRO_CODMRC | marca | Cab. | `tb_merchandise.tb_brand_id` → `tb_brand` central [WS13:1346] | fabricante (CNPJFab) sem casa |
| 40 | PRO_TRIBUTACAO | finalidade 1–7 | Trib. | `tb_merchandise.kind_tributary` [API "purpose"] | web 0–7 × legado 1–7; 2013 não mandava |
| 41 | PRO_SERIE | controla série | Obs. | `tb_merchandise.controlseries` [WS13:1348] | — |
| 42 | PRO_VENDA | "vendido no período" | — | **SEM CASA** | estado de relatório |
| 43 | PRO_CODRVT | revestimento | Est. | **SEM CASA** | — |
| 44 | PRO_CODCAT | categoria (árvore da Internet; após o bootstrap, a de grupo/subgrupo) | Internet | `tb_product.tb_category_id` [WS13:1258] | 2 editores na tela + valor fixo 2 |
| 45 | PRO_FORA_LINHA | fora de linha | Obs. | `tb_stock.outline` [NOME] | status de catálogo guardado no estoque |
| 46 | PRO_CEST | CEST | Cab. | `tb_merchandise.cest` [NOME; API] | — |
| 47 | PRO_FABRICADO | ? | — | **SEM CASA** | morta |
| 48 | PRO_CODMED_TRIB | unidade tributável | Trib. | **SEM CASA** | — |
| 49 | PRO_QTDE_TRIB | fator comercial → tributável | Trib. (não grava) | **SEM CASA** | a NF-e consome (achado 0.1) |
| 50 | PRO_SEQUENCIA | sequência nas pesquisas | Est. | **SEM CASA** | sem leitor |
| 51 | INDESCALA | indEscala | Obs. | `tb_merchandise.manuf_sign_ind_scale` [NOME] | — |
| 52 | FIXED_RATE | preço fixo | Preços | **SEM CASA** | — |
| 53–54 | AVAILABLE / ADD_DAYS_AVAILABLE | disponibilidade + dias | Est. | **SEM CASA** | — |
| 55 | PRO_DT_VENCIMENTO | validade (etiqueta) | Cab. | **SEM CASA** | validade é do LOTE |
| 56 | PRO_VL_BASE_TROCA | custo base de troca | Est. | **SEM CASA** | — |
| 57 | PRO_SEND_WEB | enviar para a internet | Obs. | **SEM CASA** | — |
| 58 | PRO_VL_CUSTO_LAST | último custo sem impostos | Cab. (RO) | **SEM CASA** | — |
| 59 | PRO_IAT | arredonda/trunca (PAF-ECF) | — | **SEM CASA** | sempre 'A' |
| 60 | PRO_QTDE_MIN_AUTO_REPO | gatilho da reposição | Est. | **SEM CASA** | — |
| 61 | DELETED | exclusão lógica (bootstrap) | — | `tb_product.deleted` [INFERÊNCIA] | inativo ≠ excluído |

**Satélites**: TB_ESTOQUES → `tb_stock_list` (e `tb_stock.quantity` = `TB_ESTOQUE.EST_QTDE` [WS13:1694], duplicando `tb_stock_balance`) ·
TB_PRECO → `tb_price` (inversão comissão/margem — achado 0.2) · TB_TABELA_PRECO → `tb_price_list` (`aliq_profit` decimal(10,0) perde
casas; sem casa: TPR_CODEMP, TPR_PRINCIPAL, TPR_MOBILE, TPR_TIPO_CLIENTE, TPR_CASA_DECIMAL, TPR_LOJISTA, TPR_ATIVA, TPR_MAR_PRIORITARIA,
TPR_MAR_VIA_ESCALA) · TB_PROD_FORN → `tb_merchandise_has_provider` · TB_PROD_PROD → `tb_merchandise_has_self` (PPD_TIPO/METODO/QTDE_USED
sem casa — a reposição se perde; PK web sem institution) · TB_PRODUCT_UF_BENEF → `tb_product_uf_benef` (PK web exclui o CST) ·
TB_TRIBUTACAO do produto → `tb_tax_rule` com seletor de produto. **Sem casa**: TB_IMAGES por produto (a `tb_images` web não tem chave de
produto), TB_PROD_SERV, TB_FICHA_TECNICA, TB_SERIE_PRODUTO, TB_PRODUCT_SIMILAR, TB_PRODUCT_VARIANT(_SKU), TB_LOJA_TRAY, TB_BOTAO,
TB_REVESTIMENTO.

**Colunas web sem origem no legado**: `tb_product.tb_financial_plans_id`; `tb_stock.tb_color_id` (em 2013 era a constante 1) e `link_url`;
`tb_merchandise.id_internal` e `.kind` são DUPLICATAS.

## 3. Como a TB_PRODUTO foi quebrada — diagnóstico

- **`tb_product`** (catálogo comum P/M/S): correto em id, identifier, description, kind, categoria, note. Fora do lugar: `promotion`,
  `highlights`, `published` são flags do site de 2013, não do catálogo.
- **`tb_merchandise`** (mercadoria): fiscal correto (ncm, cest, source, kind_tributary, indEscala) e a marca (serviço não tem marca) — mas
  perdeu o FABRICANTE (CNPJFab). Fora do conceito: `id_internal` (cópia do identifier), `id_provider` (é do vínculo com o fornecedor),
  `kind` (cópia), `print` (preferência de impressão).
- **`tb_stock`** (1 linha por mercadoria) — guarda de tudo, quase nada de estoque: identidade da mercadoria (unidade comercial, embalagem,
  divisor, GTIN) · logística (peso/dimensões) · os 3 CUSTOS (valorização M13 — no legado por produto, não por depósito) · fiscal (`st`) ·
  status de catálogo (`outline`) · grade (`tb_color_id`) · saldo (`quantity`, duplica `tb_stock_balance`). Genuinamente estoque só
  `negative`, `minimum`, `location` — e mesmo esses existem por depósito no legado.
- **Conceitos perdidos na quebra**: unidade e fator tributáveis · CNPJFab do fabricante · preço fixo · disponibilidade · validade · base de
  troca · último custo · revestimento · instalação · ficha técnica · reposição · similar · séries · variantes · Tray · imagem por produto.

## 4. Compartilhado × por estabelecimento no legado

| Dado | Escopo no legado | Evidência |
|---|---|---|
| TB_PRODUTO (linha, código, custos, mínimo, localização, flags) | **compartilhado** — PK só PRO_CODIGO, sequência única | M:137-139 ("[KeyField('PRO_CODMHA')] retirado pois a sequencia é a mesma para todas os estabelecimentos"); C:335, :447 |
| PRO_CODMHA | marca o "dono", reescrita a cada Gravar | P:962 |
| `PRO_G_COMPARTILHA` | 'S' tira o filtro `PRO_CODMHA` de pesquisas/PDV/itens/relatórios — é só VISIBILIDADE; default divergente | `Un_Pesq_Produto.pas:408-412`; `sea_product.pas:236,381`; P:1659 × `Un_Regra_Negocio.pas:276` |
| Depósitos e saldos | **por estabelecimento** na exibição (ETS_CODMHA); criação para todos | `ControllerEstoques.pas:263-267`; `ControllerEstoque.pas:162-182` |
| Preço (TB_PRECO) | **compartilhado** (TPR_CODEMP ignorado) | `ControllerTabelaPreco.pas:183-191` |
| Regra fiscal do produto (TB_TRIBUTACAO) | **por estabelecimento** (TRB_CODMHA) | D:4026; `sea_taxation.pas:107,133` |
| Benefício UF, fornecedor, composição, ficha técnica, instalação, similar, série, reposição, variante, Tray | **compartilhados** (sem estabelecimento) | DDL |
| Imagens | gravadas com o estabelecimento, lidas sem ele (na prática compartilhadas) | `Un_Img_Site_Produto.pas:366-368` × `.dfm:314-317` |

**Para o grupo do sync (não lido)**: a inversão `aliq_profit`/`aliq_kickback` · origem real de `codebar`, `st`, `outline`, `composition`,
`manuf_sign_ind_scale`, `kind_tributary` · como fica um TB_PRODUTO compartilhado por N estabelecimentos · PRO_CODCAT da árvore da Internet
× conversão grupo/subgrupo do bootstrap · o Base64 de PRO_APLICACAO.
