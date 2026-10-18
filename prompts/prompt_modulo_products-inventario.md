# Anexo — Inventário da frente "Cadastro de Produtos (mercadoria)"

**Escopo**: setes (o método — levantar código atual × legado × frentes vizinhas antes do conceito — é o mesmo da
`refinar-prompt-arquitetura.md`; o conteúdo é todo do Gestão 2027)
**Origem**: Rodada 0 da frente (2026-10-17, Valdo: "enquanto outra sessão está trabalhando na nfe-api podemos iniciar o
processo de cadastro de produto na setes-app"). Três levantamentos SÓ LEITURA em paralelo + conferência direta no código e
no banco de dev. Prompt principal: `prompt_modulo_products.md`.
**Regra dos dois grupos**: o setes-sync e o sincronizador NÃO foram lidos além dos NOMES dos endpoints que gravam as
tabelas de produto (§1.6) — o lado deles é tarefa do grupo do sync.

Bases: `MIG` = `setes-api/src/migrations/sql` · `SQL` = `sql/` · `API` = `setes-api/src` ·
`APP` = `setes-app/apps/web/lib/app/modules` · `vault:` = `D:\Gestao2016\Infra-IA\Gestao\` · `src16:` = `D:\Gestao2016\` ·
`NFE` = `prompts/prompt_onda_nfe_sefaz.md` · `IB` = `prompts/prompt_fase_ibs_cbs.md` · `FAT` = `prompts/prompt_fase_faturamento_financeiro.md`

---

## 1. O que existe HOJE no código (2026-10-17)

### 1.1 Fatos conferidos à mão (não só pelo agente)

- O setes-api grava `tb_product` SÓ com `kind='S'`: o único INSERT é `API/modules/services/services.repository.ts:366`
  (UPDATE `:413-419` com `WHERE kind='S'`, soft delete `:440-445`). **Mercadoria (P/M) não tem produtor na web.**
- Não existe módulo `products` em lugar nenhum (API `src/modules/`, app, `interface_routes.dart`, seeds de interface,
  `insertDefaultFlags`, i18n — só a chave `lookup.products` em `pt.json:110`).
- **Banco de dev (2026-10-17)**: `setes_setes.tb_product` = 1 mercadoria P viva (com NCM, sem CEST, sem linha em
  `tb_stock`) · 45 serviços vivos + 32 excluídos; **`setes_central.tb_ncm` = 0 linhas · `setes_central.tb_cest` = 0 linhas**;
  `tb_brand` 1 · `tb_package` 1 · `tb_measure` 3. O schema `setes_ws` não tem `tb_product`.
- `tb_stock` (baseline `MIG/001_baseline.sql:2245-2277`): PK `(tb_institution_id, tb_merchandise_id)` — **UMA linha por
  mercadoria**, com embalagem, medida, cor, `codebar varchar(20)`, `st`, quantidade, mínimo, divisor, localização,
  peso/dimensões, 3 custos, negativo, link.

### 1.2 Tabelas (schema do cliente, salvo indicação)

Todas as tabelas centrais do produto vivem SÓ no `001_baseline.sql` (dump do legado) + migrations 013/014/018/019 — o
canônico `SQL/03` NÃO cria `tb_product`, `tb_merchandise`, `tb_price`, `tb_price_list`, `tb_stock*`, `tb_order_item`
(depende delas: `tb_service` → `tb_product`, `SQL/03:1236`) e não documenta `tb_product.kind` (019) nem a FK de institution (014).

| Tabela | Definição | Colunas relevantes | Chaves |
|---|---|---|---|
| **tb_product** | `MIG/001:1896-1919` · `014:11-14` · `019:13-15` | id int DEFAULT 0 · identifier varchar(50) NOT NULL DEFAULT '0' · description varchar(100) NOT NULL DEFAULT '0' · **kind char(1) DEFAULT 'P'** (P acabado · M matéria-prima · S serviço) · tb_category_id NOT NULL DEFAULT 0 · tb_financial_plans_id · promotion/highlights/active/published · note blob · deleted | PK (id, inst); FK institution central (014); **sem FK** para categoria/plano |
| **tb_merchandise** | `MIG/001:1940-1966` | id_internal · id_provider · **ncm varchar(8) · cest varchar(7)** · **kind_tributary char(1)** (= FINALIDADE 0–7; o nome legado engana) · **source char(1)** (= ORIGEM 0–8) · kind varchar(45) (legado, ninguém lê) · tb_brand_id NOT NULL (sem FK) · print · controlseries · exclusive_dealer · application blob · composition · **manuf_sign_ind_scale char(1) DEFAULT 'S'** (= indEscala) | PK (id, inst); **duas FKs idênticas** para tb_product (`:1964-1965`); a 019 soft-deletou as linhas de serviço |
| **tb_stock** | `MIG/001:2245-2277` · `018:23,77-78` | ver §1.1 — "ficha da unidade" + saldo agregado | PK (inst, merchandise); medida → `setes_central.tb_measure` (018); embalagem/cor **sem FK** |
| tb_stock_balance | `001:2279-2289` | saldo por (inst, lista de estoque, mercadoria) — mantido por TRIGGER (`MIG/002:8-26`) | PK triplo |
| tb_stock_list / _statement / _reserved | `001:2291` · `:2324` · `:2306` | depósitos · movimento · reserva (`_reserved` ainda com FK para a institution LOCAL `:2321`) | — |
| **tb_price_list** | `001:1850-1863` | description · validity · modality · aliq_profit **decimal(10,0)** · published | PK (id, inst) |
| **tb_price** | `001:1921-1938` | price_tag decimal(13,6) · aliq_profit · **aliq_kickback** (comissão — lida por `@shared/commission`) · quantity | PK (inst, list, product); FK produto CASCADE; FK lista **só por id** |
| tb_product_uf_benef | `001:1968-1978` | (produto × UF) → cst, cod_benefits (= cBenef) | sem FK; **ninguém lê** |
| tb_merchandise_has_provider / _has_self | `001:1053` · `:1064` | fornecedor × produto · composição (`_has_self` sem institution na PK) | — |
| tb_promotion(_items) · tb_images · tb_color(+has) | `001:2022/2037` · `:613` · `:249/673` | promoção · imagem genérica (sem chave de produto) · cor (continua LOCAL, não centralizada) | — |
| tb_institution_has_brand/package/measure | `SQL/03:582-622` = `MIG/018:35-74` | vínculo institution × catálogo central (`active`) | FKs cross-schema |
| tb_category | `SQL/03:628-645` = `MIG/009:20-34` | árvore 2 níveis, **kind P/S** | PK (id, inst) |
| tb_state_mva_ncm / tb_state_fcp_ncm | `SQL/03:1410-1441`; reforma `MIG/043` | MVA/FCP por UF × NCM (módulo `state-tax-rates` na API) | UNIQUE (inst, state, ncm) |
| tb_tax_rule (seletor) | `SQL/03:1285-1310` = `MIG/025` | tb_product_id NULL · ncm · origin · purpose | sem FK para produto |
| tb_ncm / tb_cest LOCAIS | `001:1127` · `:186` | resíduo do baseline — criadas em todo schema novo (só o script manual `SQL/04:57-58` derruba) | — |

**setes_central (`SQL/01`)**: `tb_brand` (456-465, sem UNIQUE — dedupe por descrição na aplicação, D17 do sync) ·
`tb_package` (467-477, + abbreviation(3)) · `tb_measure` (479-490, + abbreviation(5), `escale` decimal) · **`tb_ncm`**
(598-609: number varchar(10) PK, description, exc (ex-TIPI), alíquotas IBPT nac/imp/est/mun) · **`tb_cest`** (611-617: cest
PK, ncm, description) · família `tb_tax_ibscbs*` (753-830; o comentário da 802 diz que os modelos 55/65 "entram como DADO na F4").

**Campo fiscal × onde mora hoje**: origem = `tb_merchandise.source` · NCM = `.ncm` · CEST = `.cest` · finalidade =
`.kind_tributary` · indEscala = `.manuf_sign_ind_scale` · código de barras = SÓ `tb_stock.codebar` (sem GTIN tributável) ·
ex-TIPI = **não existe** no produto (só `tb_ncm.exc`) · cBenef = só a legada `tb_product_uf_benef` · CNPJFab = **não existe** ·
unidade tributável = **não existe** · imagem de produto = **não existe** · IBS/CBS de mercadoria = **não existe** (de propósito — §3).

### 1.3 Quem lê e quem escreve no setes-api

- **Escritas**: `tb_product` só kind S (services); `tb_price` pela grade do serviço (`services.repository.ts:318-336`);
  `tb_price_list` (`price-lists.repository.ts:87,108,124`); `tb_tax_rule.tb_product_id` (`tax-rules.repository.ts:152,188`;
  validação `API/shared/tax-rule/pieces.ts:153-175` **não confere o kind**). **Nada** em tb_merchandise, tb_stock*,
  brand/package/measure, `tb_order_item_merchandise`.
- **Leituras de mercadoria**: orders (`orders.repository.ts:150-189,371-380`), order-returns (`:135-147,174-190`;
  `@shared/order-return:173-180,340-348`), **billing** (`billing.repository.ts:101-139` lê `m.ncm`, `m.source`, `m.cest`,
  `kind_tributary AS purpose`; `:357-375` IBPT pelo `setes_central.tb_ncm`; `billing.service.ts:442-446` = 422 `MISSING_NCM`),
  motor `@shared/tax-rule/match.ts:118-135` (NCM por IGUALDADE EXATA `:125`, origem `:126`, finalidade `:130`), comissão
  (`@shared/commission/commission.ts:62-69` → `tb_price.aliq_kickback`), tax-rules (`:36-40,60-77,311-325`).
- **Lookups**: `GET /api/orders/merchandise-lookup` = o ÚNICO que filtra P/M (`orders.repository.ts:177`; diz "ativos e
  publicados" mas não filtra `published` — `:170` × `:178-185`); `GET /api/tax-rules/products` devolve TODOS os kinds.
- **ST = presença do CEST** (`billing.repository.ts:133`, R5-Q5) — `tb_stock.st` é ignorado.
- **Molde `services` (6 arquivos)**: interface 100 · dto 53 (`SERVICE_FIELD_PATHS :46-53`) · repository 517 · service 114 ·
  controller 152 (`assertClientRequired :53`) · routes 277 (montado em `router.ts:193-198`). Transação única: `assertRefs`
  (`:173-212`) → id por `MAX(id)+1 FOR UPDATE` em tb_product (`:355-361`; identifier em branco = id `:363`) → INSERT/UPDATE
  kind fixo → `syncPrices` (`:310-337`) → ramo do serviço. Critérios de pesquisa `:30-34`.
- **Ordem de travas provada** (deadlock 1213 da IB-2 — IB:1506-1510): `tb_product` → `tb_service` → `tb_service_ibscbs`; o
  faturamento trava `tb_product` (D-IB30); o POST /services trava os produtos da institution (IB:1542).

### 1.4 setes-app

Existem: `services` (17 arquivos, `service_page.dart` 1016 linhas, 3 abas), `price_lists`, `categories` (árvore P/S),
`tax_rules` (`selector_tab.dart:179-190` — produto SOMENTE LEITURA na regra, D38/RA-Q1), `orders`, `order_returns`,
`contracts`, `service_orders`. **Não existem**: products, brands, packages, measures, stock, state-tax-rates.
Seeds: `SQL/42_services_price_lists_seed.sql:5-7` já diz "Produtos no futuro" (D6/D3 do serviço); campos em `SQL/62`.

### 1.5 Pontos de atenção do código atual

1. Natureza duplicada: `tb_merchandise.kind` varchar(45) do legado × `tb_product.kind` char(1).
2. Colunas sem leitor web: em tb_merchandise (id_internal, id_provider, kind, tb_brand_id, print, controlseries,
   exclusive_dealer, application, composition, manuf_sign_ind_scale), tb_stock inteira, `tb_price.aliq_profit/quantity`,
   `tb_price_list.aliq_profit`, uf_benef, has_provider/has_self, promoção, imagens, cor.
3. **A web não grava `tb_order_item_merchandise`** (`orders.repository.ts:267-286`): item vendido pela web fica sem tabela de
   preço/depósito, a comissão por produto nunca acha o tb_price, a web não movimenta estoque, ninguém precifica por tb_price
   (o `unit_value` é digitado).
4. Filtros furados: `/tax-rules/products` e `findInvalidSelectorRefs` sem kind; lookup de categorias do services sem
   `kind='S'` (`services.repository.ts:453-472`) — o de produtos cairia na mesma armadilha com `kind='P'`.
5. NCM parcial nunca casa: o DTO de tax-rules aceita 2–8 dígitos (`tax-rules.dto.ts:18`) × match exato (`match.ts:125`).
6. FKs que faltam: `tb_merchandise.tb_brand_id`, `tb_stock.tb_package_id`, `tb_product.tb_category_id` (NOT NULL DEFAULT 0),
   `tb_product_id` em order_item/contract_item/tax_rule/promotion_items; tb_price → lista só por id.
7. Sinais de maquete: defaults '0' em id/identifier/description; identifier sem unicidade (services não checa duplicidade);
   timestamp × datetime; `aliq_profit decimal(10,0)`; `escale`; general_ci × unicode_ci; `tb_ncm.number varchar(10)` × ncm(8).
8. Espaço de ids compartilhado: services gera MAX+1, o sync grava o `PRO_CODIGO` do legado como id → colisão se os dois
   estiverem ativos no mesmo cliente (por isso a D3 do serviço: liberação SÓ para quem não usa mais o legado).
9. **`tb_stock` é a "ficha da unidade" e não um saldo**: guarda embalagem, medida, GTIN, dimensões, custos E um saldo
   agregado; o saldo por depósito vive em `tb_stock_balance` (trigger).

### 1.6 Endpoints do setes-sync que gravam tabelas de produto (só os nomes)

`setes-sync/src/modules/sync/endpoints/`: brand · package · measure · category · **merchandise** · service · price · pricelist ·
promotion · stocklist · stockbalance · stockstatement (+ helper `sync.catalog.ts`); `ordersale`/`orderservice` gravam
`tb_order_item_merchandise`. ⇒ **Toda mudança de FORMA em tb_product/tb_merchandise/tb_stock/tb_price é contrato com o
grupo do sync** (coluna nova = aditiva com default; nunca NOT NULL sem default; nunca renomear).

---

## 2. O legado (Gestao2016) — cadastro `TFr_Produtos`

**Nenhum módulo do vault (M01–M15) cobre o cadastro de produto** e nenhum dos 6 processos o descreve: as regras que tocam o
produto estão espalhadas (M01 pedido, M03 fiscal, M08 lote/série, M12 config, M13 custo, M14 base de troca) e quase todas
tratam o produto como dado LIDO pela venda/compra/nota. Tela, validações e gravação abaixo = leitura direta do fonte
(`src16:Arquivos/Un_Produtos.pas` 3.608 linhas + `.dfm` 4.158 · `Controller/ControllerProduto.pas` · `model/tblProduto.pas:133-310`).
Marcas: [VAULT] = está no vault · [CÓDIGO] = conferido no fonte · [INFERÊNCIA] = dedução não confirmada.

### 2.1 Regras do vault que tocam o produto [VAULT]

- **Tipo** `PRO_TIPO` P acabado · S serviço · M matéria-prima · A automático (pizzaria) · C consumo
  (`web27:processo-pedido-nota.md:99-110`); P07: com `PRO_P_DISTG_PA_MP='S'` matéria-prima não fatura (`P07.md` → `UN_Pedido_Vda.pas:3707`).
- **Compra reativa** produto inativo (CPA-05 → `RN_Compras.pas:541`) e vincula produto × fornecedor (CPA-06).
- **Estoque**: EST-01 (estoque negativo `PRO_EST_NEG='N'` bloqueia faturar) · EST-02/03 · CPA-01 · CAN-05 · INV-01 · DEV-02/TRO-01.
- **Série/lote**: P15 (`PRO_SERIE='S'` exige nº de séries = quantidade) · SER-01 · LOT-01/02 (FEFO) · CPA-C1.
- **Custo (M13)**: CPA-02 médio ponderado na entrada · CPA-03 `PRO_VL_CUSTO` só sobe + último custo · CPA-C2 · CUS-01 · CPA-P6.
  Decisões 27/28/29 do vault: o histórico `*ANT` de um nível NÃO é aceito; estorno recalcula por `TB_CUSTO_PEDIDO`.
- **Preço**: CPA-04 recálculo após a compra (`PRO_G_ATUAL_PRECO_COMPRA` A/M; preço FIXO respeitado) · P05 (a prazo não usa
  tabela à vista) · DSV-01/02 · COM-01 (alíquota de comissão do item).
- **Fiscal**: VAL-01 · CFG-NFE_SEM_CODIGO_BARRAS · P06/OBS-01/PDV-02 imposto aproximado por NCM × origem · OBS-02 · DEV-03 ·
  motor por `PRO_ORIGEM`, `PRO_SUB_TRIB`, `PRO_TRIBUTACAO` (finalidade), NCM e regra do produto (`web27:tributacao.md:22-81`).
- **Base de troca** BTR-01/02 (M14) · **PDV-01** (4 formas de entrada: barras, balança, avulso, sem registro).
- **Sem regra nenhuma no vault**: grade/variação, unidade/embalagem/conversão, marca, grupo/subgrupo/categoria, kit,
  imagem, internet, promoção, estoque mínimo, CEST, cBenef, GTIN no cadastro, unicidade do código de fábrica.

### 2.2 A tela [CÓDIGO]

**Cabeçalho** (dfm:2878-3314): código (`GN_PRODUTO`, único entre estabelecimentos) · código próprio/fábrica (vazio = o
próprio código, `ControllerProduto.pas:449-450`) · código do fornecedor · código de barras · descrição (100) · grupo/subgrupo ·
marca · NCM · CEST (7) · data de vencimento · último custo (RO). Revenda de veículos (`PRO_G_LABEL_PRO='S'`) REAPROVEITA as
colunas de fábrica/barras/fornecedor para chassi/placa/Renavan (`:2549-2556`) — maquete.

**Abas** (9 escondíveis por `PRO_G_ABA_*`): **Estoque** (unidade comercial, embalagem, divisor, tipo P/M/C/A, origem 0–8,
localização, mínimo, peso/dimensões, 3 custos, base de troca, disponibilidade, sequência, modo de composição 1–6) ·
**Observações** (estoque negativo, ativo, não imprimir na tabela, destaque, série, exclusivo de revenda, internet, enviar para
internet, fora de linha, escala industrial, promoção, detalhes HTML) · **Tabelas de preço** (por tabela: margem, valor,
comissão, quantidade mínima, PREÇO FIXO) · **Fornecedores** · **Tributação** (ST, finalidade 1–7, unidade tributável — vazia
usa a comercial, "Qtde. tributável" NUNCA gravada, regra específica, benefício por UF + CST) · Instalação · Composição (kit) ·
Aplicação · Botão (PDV — botões sem código) · Séries · Internet (árvore TB_CATEGORY + Tray) · Produção (ficha técnica) ·
Similar · Reposição automática. **Menu**: imagens (`TB_IMAGES` tipo 'product', normal/capa/banner) · variação
(`TB_PRODUCT_VARIANT(_SKU)` — tamanho/cor/preço/qtd, SÓ para a Tray, sem ligação com estoque) · ajuste de preço por escala.

**Obrigatórios ao gravar** (`Fc_Pre_ValidaGravacao :3111-3266`): descrição, embalagem, unidade comercial, grupo, subgrupo,
marca; GTIN com DV pelo `TACBrValidador` (salvo veículo ou `PRO_G_NAO_VALIDA_EAN='S'`); código de fábrica único só com
`PRO_G_VAL_CODIGOFAB='S'`; NCM obrigatório só com NF-e (a mensagem diz "8 dígitos" mas só testa vazio); **CEST preenchido
força ST = SIM; ST = SIM exige CEST de 7**. Ao sair do campo: código de barras duplicado oferece abrir o existente (ignora
'SEM GTIN'); localização duplicada só avisa. Alterar descrição de produto com movimento pede confirmação. **Excluir só marca
`PRO_ATIVO='N'`** (checagem de movimento comentada em 2021 "pensando na sincronia").

**Ao gravar** (`SB_GravarClick :1142-1174`, NÃO atômico — cada passo commita sozinho): TB_PRODUTO (força categoria 2 e
IAT 'A') → benefícios (apaga e reinsere) → **TB_ESTOQUE com saldo 0 para TODOS os estoques, sem filtrar estabelecimento** →
**TB_PRECO para CADA tabela da grade, mesmo com 0** → reposição → Tray. Composição, produção, instalação, fornecedor,
séries, similar e imagens gravam NA HORA (antes do Gravar). Cópia insere na hora e não copia os benefícios fiscais.

### 2.3 Preço e custo [CÓDIGO]

- Preço GUARDADO (não calculado na venda): `TB_PRECO` (tabela × produto: valor, margem, comissão, qtd mínima). Venda abaixo
  da tabela exige permissão (`VDA_G_PRECO_ACIMA`).
- Fórmula (`Un_Regra_Negocio.pas:1232-1287`): `PRO_G_CALC_MRG_LUCRO='1'` → custo / ((100 − margem)/100) (margem sobre a
  venda); senão custo × (1 + margem/100) (markup); tabela com 0 casas arredonda para cima. Base: custo (`'C'`) ou custo
  médio. Margem da tabela pode ter prioridade sobre a do produto. Recálculo automático margem ↔ preço na tela.
- **Preço por estabelecimento NÃO existe na prática** (`TB_PRECO` sem estabelecimento; `TPR_CODEMP` mapeado e ignorado).
- **Custo no cadastro = edição manual livre, sem histórico** (anti-padrão); composição/produção sobrescrevem o custo do pai.

### 2.4 Anti-padrões a NÃO reproduzir [CÓDIGO]

Validação de "comissão" que testa a margem · NCM "8 dígitos" não checado · a mesma chave (`PRO_G_CUSTO_ATUAL_PRECO`) com 3
defaults · baixa de kit que multiplica em cascata [INF] · composição '4'/'5'/vazia que não movimenta estoque [INF] · vincular
fornecedor com código vazio apaga vínculos de outros produtos [INF] · preço 0 criado em tabela de outro estabelecimento e
inativa · estoque criado para todos os estabelecimentos · valores fixos (categoria 2, IAT 'A') · coluna com dois significados
(veículos) · exclusão física que apaga movimento · campos/abas de enfeite ("Qtde. tributável", aba Botão) · GTIN só validado
no faturamento se `PRO_G_LABEL_PRO` for exatamente 'N' (default '') [INF] · CEST comentado no faturamento · cBenef ausente só
avisa (intencional — "a Receita é o validador final") · grade sem controle de estoque · estoque mínimo só informativo.

### 2.5 Perguntas do levantamento para o Valdo (entram na rodada)

Preço por estabelecimento? · tabela inativa recebe preço? · grade com estoque por SKU? · custo editado à mão gera
histórico? · default canônico da base de custo do preço?

---

## 3. O que as frentes fiscais esperam do produto (para não conflitar)

**Regra-mãe**: o cadastro é MUTÁVEL; quem vale na nota é o SNAPSHOT (`tb_order_item_icms.origem` etc., congelados no
faturamento — `billing.repository.ts:687`; NCM/CEST/EAN/unidade congelados no XML — NFE:132, NFE:75, DDL NE-2:11-21).
A nfe-api só LÊ o banco do produto (D-F10/D-F31): **as colunas que este cadastro definir viram o contrato de leitura da
NE-4** ("fonte de fatos da mercadoria", NFE:624).

**O cadastro DEVE carregar** (com decisão e evidência):

| Fato | Regra | Evidência |
|---|---|---|
| NCM 8 dígitos (mercadoria) | sem NCM o faturamento barra (422 `MISSING_NCM`, R5-Q3); rejeição 777 exige completo; D36 = igualdade exata → gravar só dígitos | FAT:214-220, :754; `match.ts:125` |
| Origem 0–8 · finalidade 0–7 | seletor da regra; domínios `TAX_RULE_ORIGINS`/`TAX_RULE_PURPOSES` vivem no dto de tax-rules → PROMOVER a `shared/` (módulo não importa módulo) | `tax-rules.dto.ts:4-5`; `match.ts:126,130` |
| CEST 7 (catálogo `tb_cest`) | a ST do produto é DERIVADA da presença do CEST — **R5-Q5: ST não vira coluna própria** | FAT:147-151, :224-227 |
| kind P/M | decide o ramo do item; services fixa S, products seria o espelho P/M | FAT:345, :361; D5 do serviço |
| GTIN (`cEAN`) e GTIN tributável (`cEANTrib`), opcionais | sem GTIN sai "SEM GTIN" (config `nfe_send_gtin`, D-NE15 (c)); informado = 8/12/13/14 dígitos + DV GS1 + prefixo válido (611/882/612/884); um sem o outro = 885/886; o tributável é o da MENOR unidade; **D-NE116**: NT 2021.003 v1.50 vigente (Grupo IV em produção desde 01/10/2025; Grupo V H 01/04/2027 · P 01/09/2027); indústria confere no CCG (889/890); prefixos GS1 = dado versionado | NFE:295, :1719; NTGTIN:209-220, 372-396 |
| Unidade comercial × tributável | `uCom`/`uTrib`/`qTrib` no XML; lacuna "unidade não congelada" (854: GLP exige kg) | R02:208-209; R04:1022-1027, :2458 |
| indEscala + CNPJFab | só com CEST; `indEscala='N'` exige CNPJFab (879/489); CNPJFab pela peça `fiscal-api/federal-id` (D-CJ2), **nunca `replace(/\D/g…)`** (cerca D-CJ12 — `API/__tests__/federal-id-fence.test.ts`) | R04:1000-1015, :1114-1123 |
| Produto como especialização da regra (D38) | o produto do seletor NASCE do cadastro de origem — a ação "criar regra deste produto" é do módulo de produtos; na regra o campo é somente leitura; a API valida a existência | FAT:756, :812-815 |

**O cadastro NÃO deve carregar**: classificação IBS/CBS (cClassTrib) da mercadoria — mora na REGRA, peça 1:1
`tb_tax_rule_ibscbs` (IB-N, dentro da F4), assimétrico de propósito em relação a `tb_service_ibscbs` (IB:164-165, :225,
:1393-1397) · alíquota/MVA/FCP (por UF × NCM em `tb_state_mva_ncm`/`_fcp_ncm`, D9) · flag "ST" própria (derivada do CEST —
cuidado com `tb_stock.st` do baseline) · totais/CST/valores (motor + snapshots; D-NE27, D-NE102) · grupos `med`, `rastro`,
`comb`/ANP, `arma`, `veicProd`, `DI`, `detExport` (fora do 1º release; flag/coluna só nasce com consumidor — IB:176-179,
NFE:348; lote/validade são do item/estoque) · GTIN em serviço (vai "SEM GTIN", regra U01-30).

**Em aberto em NENHUMA frente**: cBenef (baseline `tb_product_uf_benef` sem leitor; PR aplica N12-98 — pesa se o 1º cliente for
do PR) · EXTIPI (não existe coluna; R02:556 marca "✔ snapshots" sem conferência) · **onde congelar GTIN/unidade** (§3.11 da
NF-e manda ler na transmissão × lacunas/NE-6/D-NE15 apontam congelar por item no ERP — **decide a NE-6**; o cadastro GUARDA,
não decide o snapshot) · **de onde sai o `cProd`** (D-NE103: a devolução confere o `cProd` do procNFe da origem — se vier do
`identifier` vivo, editar o código depois da venda vira 422 `FISCAL_RETURN_REFERENCE_MISMATCH`).

**Pesquisa avançada**: lista nova nasce com critérios (D-BA9), nome/descrição sempre (D-BA21), índice revisado por critério
(D-BA11), lista branca entra no `scripts/explain-pesquisa-avancada.ts` (D-BA28). Moldes: `services.repository.ts:30-34`;
tax-rules já tem critérios de produto (`ncm T`, `origin O`, `purpose O`, `product L`).

### 3.1 Cruzamentos com a sessão da nfe-api (2026-10-17)

1. **NE-1b agora** (gate adversarial — NFE:1927): toca SÓ `ne1b/fiscal-api` (`src/pdf/**`, package.json). `ne1b/setes-api` é
   cópia irmã SEM mudança (cercas) — **não usar**. Ao publicar a NE-1b, o `npm run build` do núcleo vivo reescreve o `dist`
   que o `tsx watch` do setes-api lê → o dev pode reiniciar no meio do trabalho de produtos.
2. NE-2/NE-3: `nfe-api` + migration 001 do `fiscal_api` + views — nenhuma tabela de produto.
3. **NE-4**: vai LER as colunas de produto/estoque que esta frente definir — coordenar antes do DDL.
4. **NE-6 — maior sobreposição**: `billing.repository.ts` (`listBillingItems`, `persistItemTaxes`), `billing.service.ts`
   (camada 2 do validate: GTIN, unidade — D-NE43), `@shared/invoice` (totais), order-returns, migrations; decide o
   congelamento de GTIN/unidade por item.
5. IB-N: `tb_tax_rule_ibscbs` no módulo tax-rules (+ aba no app) e `tb_order_item_ibscbs`; encontra produtos só pela ação
   "criar regra deste produto" (D38).
6. Compartilhados: `federal-id-fence.test.ts` (lista `ALLOWED` — `replace(/\D/g…)` em NCM/GTIN/CEST reprova a cerca) ·
   **número da migration** (próxima no `main` = 071; conferido entre as frentes — PADROES §11 regra 14) · `error-codes.ts` +
   `npm run errors:gen` · `gateway/router.ts` · seeds de interface/campos no repo `sql`.

---

## 4. Matriz × filiais — como o modelo está HOJE (levantamento de 2026-10-17, para a Q-PR12)

[FATO] = conferido no arquivo · [INF] = dedução. setes-sync/sincronizador não lidos.

1. **Uma institution = um schema = um CNPJ** [FATO]: `setes_central.tb_institution` = `id, schema_name, active, datas, deleted`, PK `id`,
   **`UNIQUE KEY schema_name`** (`sql/01_setes_central_ddl.sql:264-274`, conferido); FK `id → tb_entity` (herança); CNPJ em `tb_company`
   (`UNIQUE cnpj`, `:106-120`). Nenhuma coluna liga institutions (sem matriz/filial/parent/grupo/raiz de CNPJ). Onboarding cria um schema
   NOVO por institution (`institutions.service.ts:70-72, 88, 116`); `schema_name` imutável. Código que supõe 1:1: `core.repository.ts:4-13`
   (`WHERE i.schema_name = ?`), migration `043:18` (`… WHERE schema_name = DATABASE() LIMIT 1`). Dev: 1 institution (`setes_setes`).
2. **Emissor = institution** [FATO]: `tb_establishment_issuer` PK `(tb_institution_id, model)` ⇒ filial com CNPJ próprio = institution
   própria = (hoje) schema próprio.
3. **Por que toda tabela do cliente tem `tb_institution_id` na PK** [FATO]: o baseline foi gerado do schema `gestao_setes`, onde um schema
   guardava N estabelecimentos (`tb_institution_id = Gb_CodMha` — vault `07-infra/suporte-emails-erro-2026-09.md:365`); a `tb_institution`
   LOCAL ainda existe nos schemas, pendente da reindexação do sync (`MIG/005:13-18`). Docs que ainda supõem N institutions por schema:
   `setes-api/prompt_fase3_entidade_unica.md:49-51`, `scripts/f2a-abort-before-cutover.ts:10,74-81`, `prompt_fase_faturamento_financeiro.md:854-856`.
4. **Usuário** [FATO]: vínculo `setes_central.tb_institution_has_user` (PK institution × user, `kind` = perfil); login com N vínculos →
   lista + `select-institution`; `switch-institution` existe na API e o app não usa; JWT = `{institutionId, userId, role, schemaName}` — UMA
   institution, sem escopo de grupo; só o Super liga um usuário a várias institutions; não existe "admin do grupo" (`users.service.ts:23-31,130-158`).
5. **Precedentes de compartilhamento** (todos na central) [FATO]: referência "fato do mundo" (cfop, ncm, bank, geografia) · catálogo central
   iniciado pelo cliente + vínculo `tb_institution_has_*` (payment types, brand, package, measure — dedupe por descrição, descrição imutável,
   o cliente desabilita, nunca exclui) · entidade única + papel por institution (last-write-wins na cadeia). **Contrário**: dado fiscal
   INTERPRETÁVEL (MVA/FCP, regra de ISS, regra de tributação) não se compartilha entre institutions (Q22 — `Infra-IA/Gestao2016/tributacao.md:859-864`).
   No schema do cliente não existe "uma institution é dona, as outras consomem".
6. **Raio de impacto de mudar a identidade `(id, tb_institution_id)` do produto** [FATO]: PK com institution em tb_product, tb_merchandise,
   tb_service, tb_service_ibscbs, tb_price, tb_price_list, tb_category, tb_financial_plans, tb_stock*, tb_merchandise_has_provider,
   tb_order_item(_merchandise), tb_contract_item(_competence); joins `p.id = x.tb_product_id AND p.tb_institution_id = x.tb_institution_id` em
   orders, billing, contracts, order-returns, service-orders, service-tax-rules, `@shared/service-product`, `@shared/tax-rule/pieces`,
   `@shared/ibscbs-catalog/apply`. nfse-api/nfe-api/fiscal-api não leem produto.
7. **Legado** [FATO]: estabelecimento = `TB_EMPRESA` tipo 0 (`Gb_CodMha`); produto ÚNICO (`GN_PRODUTO`) com `PRO_CODMHA` = dono (reescrito);
   `PRO_G_COMPARTILHA` = só visibilidade; depósitos/saldo e regra fiscal do produto POR estabelecimento; preço e todos os satélites
   COMPARTILHADOS; config por estabelecimento (`TB_GERAL.GRL_CODMHA`); com `GRL_G_MULTIEMP_ESCOLHENFE='S'` o emissor é escolhido na hora
   (vault `Lote6-autorizacao.md:31-41`, AUT-01).
8. **Saídas possíveis** [INF]: (i) catálogo sobe para a central (molde brand) com vínculo por institution · (ii) N institutions por schema
   (tirar o UNIQUE de `schema_name` — reativa o desenho original do `gestao_setes`, que as PKs já suportam) · (iii) grupo/dono explícito com a
   filial lendo o schema da matriz. Em todas: estoque, regra tributária, MVA e emissor seguem por institution.
