# Prompt — Módulo de Cadastro de Produtos (mercadoria)

**Escopo**: setes (o roteiro "inventário → guardião → questões" é o da `refinar-prompt-arquitetura.md`; o conteúdo é do Gestão 2027)
**Origem**: Valdo, 2026-10-17 — "enquanto outra sessão está trabalhando na nfe-api podemos iniciar o processo de cadastro de produto
na setes-app". Irmã declarada do cadastro de serviços (`prompt_modulo_services.md`, D6: "Serviços hoje e Produtos no futuro como
interfaces separadas, cada uma vendável").
**Aberto em**: 2026-10-17. **Estado**: Rodada 0 ORGANIZADA (inventário em anexo + parecer do guardião integrado §3 + desenho provisório
§4 + Q-PR1…Q-PR14 §6). **Rodada 1 PARCIAL (2026-10-17)**: D-PR1 (unidade de venda NA onda 1), D-PR2 (peças técnicas compartilhadas;
services não está em produção), D-PR3 (`merchandise`); Q-PR12 virou desenho (§11); análise aba a aba (anexo 2
`prompt_modulo_products-legado-abas.md`) + reorganização da tela em ficha de 3 abas + telas vinculadas (§10); casa da unidade de venda
(§12); achados do legado (§13 — ⚠️ inversão comissão × margem para o grupo do sync); mapa das ondas revisto (§15).
**Rodadas 1 e 2 FECHADAS (2026-10-17, "siga as recomendações")**: D-PR1…D-PR27; **escopo executável da onda 1 no §16**. **Rodada 3
FECHADA (2026-10-18)**: A-PR1 confirmada + D-PR28…D-PR31. D-PR13 EXECUTADA em worktree (`taxrules-ncm`, sem commit).
**ONDA 1 — LADO DA API EXECUTADO em WORKTREE (2026-10-18, §16.8)**: `merchandise/{setes-api,sql}` (branch `merchandise`), migration 071 +
peças + módulo + serviços migrados; gates 0,62/0,55 → corrigidos → re-gates **0,74/0,80 ✅**; NADA commitado nem aplicado ao banco.
**Rodada 4 DECIDIDA (2026-10-18)**: A-PR2/A-PR3 confirmadas; D-PR32 (guarda do sincronizador), D-PR33 (CATALOGAR), D-PR40 (base
travada) EXECUTADAS com gates 0,74/0,80; **D-PR37 = regra do sistema: nada se apaga fisicamente** (PADROES §3.1); D-PR35/D-PR39 →
pedido ao grupo do sync (respondido). **Rodada 5 DECIDIDA em parte (§19.1)**: D-PR41 (serviço em qualquer cliente — lookup pelo
modo), D-PR43 (interruptor da chave do sync), D-PR44 (dados de produto do sincronizado vêm do sync; NF-e web dele em série própria) —
executadas, gates 0,72/0,78. ⚠️ **Fato do grupo do sync (§19.2): produto/serviço criado na web num cliente com sincronizador é
SOBRESCRITO sem aviso quando o legado alcança o mesmo id** (Q-SY12). Seed = **66**.
App desbloqueado (`densidade`/`shell` no `main` do app — a450909).
**Rodada 6 DECIDIDA e EXECUTADA (2026-10-18, seções "Rodada 6 — execução" e "Rodada 6 — gates" no fim)**: a guarda do sincronizador
vira MÉTODO (merchandise, services, price-lists, categories), migration 072 (categorias padrão), religar recusa linha nascida na web,
D-PR42 pela recomendação (a confirmar). Gates 0,74 ✅ / 0,80 — o adversarial só reprova por DECISÃO. **Abertas (Rodada 7)**: **Q-PR52
TRAVA a publicação**, Q-PR53 (antes do 1º cliente com legado), Q-PR54…Q-PR56, Q-PR50, Q-PR51 + confirmar a D-PR42. Retomar pelo §9.
**Anexo**: `prompt_modulo_products-inventario.md` (código atual × legado Gestao2016 × o que as frentes fiscais esperam/proíbem —
com arquivo:linha).
**Regra dos dois grupos**: setes-sync/sincronizador NÃO foram lidos (só os nomes dos endpoints que gravam produto — anexo §1.6). Eles
gravam `tb_product`/`tb_merchandise`/`tb_stock`/`tb_price` dos clientes que usam o legado ⇒ toda mudança de FORMA nessas tabelas é
contrato com aquele grupo (coluna nova só aditiva com default; nunca renomear; nunca NOT NULL sem default).
**Sessão paralela (nfe-api, 2026-10-17)**: a NE-1b mexe SÓ em `ne1b/fiscal-api` (`src/pdf/**`) — sem sobreposição de arquivo com esta
frente. Mas: (1) a **NE-4 vai LER as colunas de produto** que esta frente definir (contrato de leitura); (2) a **NE-6** decide o
congelamento de GTIN/unidade/cProd por item e mexe em `billing.*`, `@shared/invoice`, order-returns; (3) ao publicar a NE-1b o
`npm run build` do núcleo vivo reescreve o `dist` que o `tsx watch` do setes-api lê. Esta frente **não toca o núcleo `fiscal-api`**.

---

## 1. Contexto (verificado no código e no banco de dev, 2026-10-17)

1. **Mercadoria não tem produtor na web.** O único INSERT em `tb_product` é o do módulo `services` com `kind='S'`
   (`setes-api/src/modules/services/services.repository.ts:366`). Mercadoria (P acabado · M matéria-prima) só nasce pelo setes-sync
   ou por SQL. Não existe `products` em lugar nenhum (API, app, rotas, seeds, flags, i18n).
2. **Já existe quem LÊ a mercadoria**: pedidos e devoluções (lookup P/M), **faturamento** (NCM, CEST, origem, finalidade → motor
   `@shared/tax-rule`, 422 `MISSING_NCM`, IBPT pelo `setes_central.tb_ncm`), comissão (`tb_price.aliq_kickback`), regras de tributação
   (seletor por produto/NCM/origem/finalidade).
3. **A ficha da mercadoria está espalhada em 3 tabelas do baseline** (dump do legado; o canônico `sql/03` nem as cria):
   `tb_product` (backbone, kind P/M/S) · `tb_merchandise` (NCM, CEST, origem = `source`, finalidade = `kind_tributary`, indEscala =
   `manuf_sign_ind_scale`, marca `tb_brand_id` NOT NULL sem default) · `tb_stock` (1 linha por mercadoria — embalagem, medida,
   `codebar`, dimensões, 3 custos, mínimo, `st`, saldo agregado; o saldo por depósito é `tb_stock_balance`, por trigger).
4. **Dev**: `setes_setes` tem 1 mercadoria e 45 serviços; **`setes_central.tb_ncm` e `tb_cest` estão VAZIOS** (0 linhas); marca 1 ·
   embalagem 1 · medida 3.
5. **Legado** (`TFr_Produtos`, `Un_Produtos.pas` 3.608 linhas): nenhum módulo do vault cobre o cadastro — 15 abas, gravação NÃO atômica,
   saldo 0 criado para todos os estoques e preço 0 para todas as tabelas, custo editável à mão sem histórico, excluir = inativar. Anexo §2.
6. ⚠️ **Produção = árvore viva**: o setes-api de produção roda `tsx watch` em `D:\Gestao2027\setes-api` (salvar = deploy) e o app roda
   `flutter run` na :5051 a partir de `D:\Gestao2027\setes-app`. A execução desta frente acontece em **worktree própria** dos dois repos
   (molde `cnpj/`, `ib3/`), com DDL provado antes em schema descartável.

## 2. Fatos que decidem (resumo — detalhe e evidência no anexo)

| # | Fato | Consequência para o desenho |
|---|---|---|
| F1 | O cadastro é MUTÁVEL; a nota vale pelo SNAPSHOT (itens congelados no faturamento; XML congela NCM/CEST/EAN/unidade) | o cadastro GUARDA o fato presumido; nunca decide o snapshot (NE-6) |
| F2 | NCM por IGUALDADE EXATA (D36) e 8 dígitos (rejeição 777) | gravar só os 8 dígitos; NCM parcial no dto de tax-rules contradiz a D36 (Q-PR13) |
| F3 | ST = presença do CEST (R5-Q5) | nenhuma flag ST no cadastro; `tb_stock.st` não é escrito |
| F4 | IBS/CBS da mercadoria mora na REGRA (`tb_tax_rule_ibscbs`, IB-N), assimétrico de propósito com `tb_service_ibscbs` | o cadastro de produto NÃO tem aba IBS/CBS |
| F5 | MVA/FCP por UF × NCM (D9 — módulo `state-tax-rates`) | fora do cadastro |
| F6 | D38: o produto do seletor da regra NASCE do cadastro de origem | a ação "criar regra de tributação deste produto" é deste módulo (§4.5) |
| F7 | GTIN informado = 8/12/13/14 + DV GS1 + prefixo (NT 2021.003 v1.50 — D-NE116); ausente = "SEM GTIN" no XML | peça de validação pura; o literal "SEM GTIN" nunca é gravado |
| F8 | `indEscala='N'` exige CNPJFab (879/489) — CNPJ alfanumérico pela `FederalId`, nunca `replace(/\D/g…)` (cerca D-CJ12) | os dois entram JUNTOS, com o consumidor (Q-PR10) |
| F9 | D3 do serviço: sem guarda de colisão de id com o sync — a tela só é LIBERADA a cliente que não usa mais o legado | vale igual para produtos (Q-PR14 torna a condição verificável) |
| F10 | D4 do serviço já decidiu "peça de preço COMPARTILHADA produto × serviço" — e ela nunca nasceu (`syncPrices` dentro de `services.repository.ts:310-337`) | esta frente é o 2º consumidor (Q-PR2) |
| F11 | D5 do serviço (Valdo): caminhos INDIVIDUAIS — sem `@shared/product` unificando os dois | o módulo de produtos tem o SEU repository; só peças técnicas são compartilháveis (Q-PR2) |
| F12 | O catálogo inteiro é por institution na web (PK `(id, tb_institution_id)`); no legado o produto é compartilhado entre estabelecimentos | divergência conhecida (Q-PR12) |

## 3. Parecer do guardião (`setes-conceito`, 2026-10-17 — integrado)

**Conceito**: a mercadoria é um item do catálogo do cliente cuja natureza é um BEM (P ou M), com a sua classificação fiscal presumida.
Fato gerador: a decisão do cliente de negociar aquele bem — hoje pela tela; amanhã também pela COMPRA (produto que nasce do XML do
fornecedor). Esse produtor irmão AGREGA: quando nascer, a escrita da mercadoria vira peça própria, sem reabrir a D5.
**Forma**: composição (catálogo + especialização fiscal + grade de preço). **Onda 1 sem tabela nova** (como o serviço) — só um índice,
se a pesquisa pedir (§4.4).

**Repartição**:
- `tb_product` = identidade no catálogo (código, descrição, categoria de kind P, plano, flags da D2 do serviço). `kind ∈ {P,M}` escolhido
  pelo usuário; P↔M permitido; S nunca — `WHERE kind IN ('P','M')` nos três verbos (espelho do "mercadoria invisível via /services").
- `tb_merchandise` = o que o bem é perante o fisco + a marca: `ncm`, `cest`, `source` (origem), `kind_tributary` (finalidade — é uma
  PRESUNÇÃO do cadastro; a regra rotula "Finalidade da Operação", `pt.json:156`, mas o motor lê o valor do produto — registro, sem
  mudança), `tb_brand_id`. `tb_merchandise.kind` (PRO_TIPO do legado) a web não escreve — a natureza duplicada morre do lado web.
- **`tb_stock` é MAQUETE (confirmada)**: 5 conceitos de 4 produtores — unidade de venda (embalagem, medida, `codebar`, divisor,
  peso/dimensões) · política de estoque (`negative`, `location`, `minimum` — este duplicado em `tb_stock_balance.minimum`) · saldo
  (`quantity`) · custo (3 colunas, nascem da COMPRA — M13) · resíduos (`st` derivada do CEST, `link_url`, `outline`, `tb_color_id` =
  atributo de variação). O cadastro só seria dono do 1º grupo; **nunca escreve saldo, custo, `st` nem mínimo**.
- **GTIN, unidade e embalagem são fatos da UNIDADE DE VENDA** (produto × nível de embalagem × fator × GTIN — o GTIN-13 da unidade e o
  GTIN-14 da caixa são do MESMO produto). Em `tb_merchandise`, o produto com várias embalagens REFORMA a peça; em `tb_stock` (1:1) vira
  "unidade-base" e o irmão agrega só as adicionais, mas o conceito fica com duas casas e a unicidade do GTIN entre tabelas vira regra de
  aplicação (sintoma de maquete). **Achado**: `codebar` tem DOIS significados — GTIN (`cEAN`) × código de barras PRÓPRIO (balança,
  prefixo 2, vai no `cBarra` e não vale como GTIN).
- **Saída que não quebra o sync**: a onda 1 NÃO toca `tb_stock` (não há consumidor web hoje — `tb_order_item` não tem unidade; o
  billing não lê `codebar`). O conceito "unidade de venda" fica DEFINIDO agora como contrato da NE-4; a casa física se decide com o grupo
  do sync (Q-PR1).

**Peças técnicas compartilhadas com o serviço** (critério: *o espaço de chaves é da TABELA; o conteúdo é do CAMINHO* — D5 intacta):
- `@shared/product-id` — SÓ aloca o id em `tb_product` (e, se a Q-PR7 aprovar, confere a unicidade do `identifier` entre P/M/S); nunca
  faz INSERT/UPDATE da linha. Evidência: o protocolo atual (`services.repository.ts:355-361`) não segue a regra 7 do PADROES §9
  (`lockInstitutionCounters` como 1º lock de quem cunha MAX+1) nem usa `withDeadlockRetry` — **risco latente apontado pelo guardião
  (NÃO provado ao vivo)**: numa institution sem produtos, dois cunhadores passam do MAX pelo gap e deadlockam no INSERT → 500; aplicar a
  regra 7 forma (a) aqui fecha ciclo com o faturamento, que trava `tb_product` e depois chama `nextSettledCode` ⇒ o protocolo precisa ser
  UM, provado por script (molde `scripts/prove-ibscbs-presumption-lock.ts`).
- `@shared/price` — executa a D4 (a grade `tb_price` × `tb_price_list` sai de dentro do services).
- `@shared/brand` — molde `@shared/payment-types` (catálogo central iniciado pelo cliente): garante a marca na central com dedupe por
  descrição DENTRO da transação + `upsertLink` no `tb_institution_has_brand`; lookup das vinculadas e ativas + "criar na hora".
- `@shared/validation` — forma de NCM (8) e CEST (7): canonizar removendo SÓ o separador da máscara ('.'), recusar letra; nunca
  `replace(/\D/g…)`. GTIN (8/12/13/14 + DV GS1) nasce junto com a unidade de venda (Q-PR1), no setes-api com espelho Dart lendo o MESMO
  vetor de casos (molde `federal-id`) — **não no núcleo `fiscal-api`** (pela D-NE43 o conteúdo é camada 2 do ERP: um consumidor TS só;
  3º subpath mexe na cerca `f2a-fiscal-api-fence.test.ts:19`; a NE-1b mexe no núcleo agora). Prefixos GS1 = dado versionado (D-NE116),
  entram com o consumidor (NE-6).

**NCM/CEST**: onda 1 = só a FORMA. A carga do catálogo é peça própria (ato com plano, PADROES §5) e NÃO é pré-requisito: existência e
vigência decidem na DATA da operação (camada 2 do validate, NE-6); o cadastro só AVISA quando a carga existir. **Achado — `setes_central.
tb_ncm` é MAQUETE**: junta a NOMENCLATURA NCM (tabela vigente do Portal Único Siscomex, com vigência) e a CARGA APROXIMADA do IBPT (outra
fonte, semestral, POR UF — uma `aliq_est` única não cabe; `exc`/`tabela` têm a forma do arquivo do IBPT — é a parte que o billing lê,
`billing.repository.ts:357-375`). CEST = Convênio ICMS 142/2018. Separar as fontes antes de qualquer carga (Q-PR6); quem alimenta `tb_ncm`
hoje se confere com o grupo do sync.

**Preço e custo**: grade igual à do serviço pela `@shared/price`; `aliq_kickback` ENTRA (consumidor existe: `@shared/commission` quando o
vendedor tem `kickback_product='S'` — e o serviço deveria ganhar o mesmo, Q-PR9); `aliq_profit`/`quantity` FORA (margem sem custo é
maquete; sem consumidor); **custo nem editável nem exibido** (nasce da compra, M13 — a web não tem compra).

**Fatos fiscais**: entram NCM, CEST, origem, finalidade (+ kind P/M). indEscala + CNPJFab = UM fato ("escala não relevante ⇒ fabricante
identificado") — juntos, com o consumidor (Q-PR10); até lá vale o default 'S' do baseline e a tela não expõe. uTrib/cEANTrib = unidade de
venda (Q-PR1). Fora: IBS/CBS, MVA/FCP, ST como campo (a tela MOSTRA "ST: sim" derivado do CEST), cBenef, EXTIPI (nasce com a NE-4),
grupos med/rastro/comb. Os domínios de origem e finalidade (`tax-rules.dto.ts:4-5`) sobem para `@shared/tax-rule`.

**Pontos que o guardião não decide**: a D4 não materializada (a `@shared/price` a executa) · o dto de tax-rules aceita NCM 2–8 × D36 ·
a D3 é condição comercial sem item de verificação na entrega (lição da rodada "contrato": decisão com condição embutida vira item de
verificação — Q-PR14).

**Glossário (entradas novas propostas para a skill do guardião)**: **unidade de venda** (produto × nível de embalagem × fator × GTIN —
não é "unidade de medida" nem "embalagem" sozinhas) · **GTIN × código de barras** (`cEAN` GS1 × código próprio/balança do `cBarra`) ·
"depósito" (`tb_stock_list`) ≠ "tabela de preço" (`tb_price_list`) — as duas se chamam `_list`. Entram na skill quando a Rodada 1 fechar.

## 4. Desenho provisório da onda 1 (vale só depois da Rodada 1)

> ⚠️ **SUPERADO pelo §16 (escopo executável fechado pelas Rodadas 1–2).** Histórico: revisto em 2026-10-17 pelos §10–§12 (D-PR1 trouxe a unidade de venda para a onda 1; o padrão de tela passou a ser ficha de 3
> abas + painel de vínculos; a Q-PR27 propõe tirar publicado/promoção/destaque da ficha). Onde este §4 e os §10–§12 divergirem, valem os
> §10–§12 até a Rodada 2 fechar.

### 4.1 API — módulo de mercadoria (nome: Q-PR3; abaixo `<m>`)
- 6 arquivos no padrão `ARQUITETURA_MODULOS_API.md`; `/api/<m>` montado no `gateway/router.ts` com o guard de interface do cliente.
- Lista PAGINADA (`@shared/list`) + pesquisa avançada (§4.4); `GET /:id` com a ficha completa; POST/PUT/DELETE.
- POST/PUT em UMA transação, na ordem de travas provada (`tb_product` primeiro): `assertRefs` (categoria kind P, plano, marca vinculada,
  tabelas de preço vivas) → id pela `@shared/product-id` (Q-PR2) → `tb_product` (kind P/M, identifier em branco = id — D1 do serviço) →
  `tb_merchandise` (ncm, cest, source, kind_tributary, tb_brand_id; demais colunas intactas) → grade `@shared/price` (presença =
  sincroniza; com `aliq_kickback` se Q-PR9) — dentro de `withDeadlockRetry`.
- `WHERE kind IN ('P','M')` em GET/PUT/DELETE (mercadoria nunca enxerga serviço e vice-versa — o services já tem o espelho).
- Lookups do PRÓPRIO módulo: categorias `kind='P'`, planos financeiros, marcas (+ criar), tabelas de preço vivas, catálogos de origem e
  finalidade (pela peça promovida para `@shared/tax-rule`).
- DELETE = soft delete (Q-PR11). Swagger em todas as rotas; códigos de erro novos no `error-codes.ts` + `npm run errors:gen`; `TEMPO`
  conforme PADROES §10 (nenhuma data de negócio nova prevista).
- Campos configuráveis (`tb_interface_has_field` + `<M>_FIELD_PATHS` + `assertClientRequired`) — seed do catálogo via `npm run fields:gen`.

### 4.2 App — módulo gêmeo (agente `setes-form-builder`, verificado no disco ao final)
- Fábrica Register* (lista + form), molde `services`. Abas: **Principal** (código, descrição, tipo P/M, categoria, plano, marca, flags
  ativo/publicado/promoção/destaque, observação) · **Fiscal** (NCM, CEST, origem, finalidade; selo "ST: sim/não" DERIVADO do CEST,
  somente leitura) · **Preços** (grade por tabela de preço; comissão se Q-PR9).
- Lookup datasource DEDICADO para os lookups (regra da revisão estrutural do serviço); módulo fala só com o seu `/api/<m>`.
- i18n pt/en (`forms.<m>.*`, `search.<m>.*`); rota `/home/<m>` com hífen se composta; `interface_routes.dart` + `home_module.dart`.

### 4.3 Banco / seeds (repo `sql`)
- Seed da interface (grupo Cadastros, `kind 'T'`, **id DINÂMICO** — lição do seed 40v1), contrato da Setes, `page_size` (seed 22), flags
  retroativas, catálogo de campos. Rótulo da tela: **"Produtos" / "Products"** (D6 nomeou a tela).
- DDL só se a pesquisa pedir índice (`tb_merchandise(tb_institution_id, ncm)` — D-BA11): migration aditiva, número conferido entre as
  frentes no momento (próxima no `main` = 071 em 2026-10-17 — PADROES §11 regra 14), provada em schema descartável.

### 4.4 Pesquisa avançada (D-BA9/D-BA21)
Critérios candidatos: descrição (sempre) · código (`identifier`) · tipo P/M · categoria (lookup) · marca (lookup) · NCM (texto, prefixo) ·
CEST · origem · finalidade · ativo · publicado. Lista branca no repository, `GET /<m>/search-criteria`, índice revisado por critério, entra
no `scripts/explain-pesquisa-avancada.ts` e na matriz de testes.

### 4.5 Ação D38 — "Criar regra de tributação deste produto"
Botão no detalhe do produto JÁ salvo, visível só se o usuário tem a interface tax-rules. Navega para `/home/tax-rules/…` com o produto
no endereço (`?productId=N` — precedente pedidos → devoluções, `order_page.dart:534`); o módulo tax_rules abre a regra nova com o
produto preenchido e somente leitura e grava pelo SEU `/api/tax-rules`. O módulo de produtos nunca chama `/api/tax-rules`.

### 4.6 Correções vizinhas que entram (o MESMO invariante "natureza pelo kind")
- lookup de categoria do services sem `kind='S'` (`services.repository.ts:453-472`) — e o de produtos nasce com `kind='P'`;
- `GET /api/tax-rules/products` sem filtro de kind;
- `findInvalidSelectorRefs` (`@shared/tax-rule/pieces.ts:153-175`) sem conferir kind P/M.

### 4.7 Gates e prova
Testes jest (molde services: mercadoria invisível pelo /services e serviço invisível pelo /<m> nos 3 verbos; FK 400 fields; grade
duplicada; 401) · prova do protocolo de id/travas por script (se Q-PR2 (a)) · smoke E2E · passeio logado · gates socrático (≥ 0,70) +
adversarial (sem HIGH/CRITICAL) · `tsc`/`flutter analyze` limpos · Swagger conferido.

## 5. Mapa das ondas (provisório)

| Onda | Conteúdo | Depende de |
|---|---|---|
| **1** | cadastro: catálogo + fiscal (NCM/CEST/origem/finalidade) + marca + grade de preço + D38 + pesquisa + correções de kind | Rodada 1 |
| 2 | **unidade de venda**: GTIN (peça + espelho Dart), embalagem, medida, fator, unidade tributável/`cEANTrib`, código próprio × GTIN | Q-PR1 + acordo com o grupo do sync; ANTES da NE-4 |
| — | **carga NCM/CEST** (peça própria, separando nomenclatura × IBPT por UF × CEST) | Q-PR6; pode correr em paralelo |
| — | indEscala + CNPJFab | NE-4/NE-6 (Q-PR10) |
| futuras | estoque (depósitos, saldo, mínimo, negativo — nasce do MOVIMENTO e exige a venda gravar `tb_order_item_merchandise`) · compra/custo (M13) · fornecedor do produto (nasce da compra, CPA-06) · kit · séries/lote (M08) · variação/grade (irmã da unidade de venda) · imagens · promoção · similar · base de troca (M14) · cópia de produto | frentes próprias |

## 6. Questões — Rodada 1 (TODAS DECIDIDAS em 2026-10-17 — D-PR1…D-PR14; ver "Decisões arquiteturais registradas")

**Q-PR1 — Unidade de venda (GTIN, embalagem, medida, unidade tributável) na onda 1?** → **DECIDIDA: D-PR1 — ENTRA na onda 1** (Valdo
divergiu da recomendação; a casa física vira a Q-PR15).
Problema: são fatos da UNIDADE DE VENDA; hoje moram na maquete `tb_stock` (1:1, gravada pelo sync). Opções: **(a)** fora da onda 1 — o
conceito fica definido agora e a casa física se decide com o grupo do sync antes da NE-4 e do estoque **(Recomendado)** · (b) a onda 1
grava só o subconjunto da unidade em `tb_stock` (embalagem, medida, GTIN, divisor), sem DDL · (c) peça nova aditiva
`tb_merchandise_unit` já, e o sync passa a gravar nela (pedido ao grupo do sync).

**Q-PR2 — Peças técnicas compartilhadas com o serviço (sem reabrir a D5)?**
Problema: id em `tb_product` é um espaço de chaves só (MAX+1 do services sem regra 7 nem retry — risco latente §3) e a D4 já pediu a peça
de preço comum. Opções: **(a)** `@shared/product-id` + `@shared/price`; o `services` migra para as duas e o protocolo de trava é provado
por script **(Recomendado)** · (b) só `@shared/price` (executa a D4) · (c) tudo duplicado no módulo novo.
~~Nota: (a)/(b) tocam o módulo `services` vivo~~ — **CORRIGIDO (Valdo, 2026-10-17): o cadastro de serviços NÃO está em produção**
(nenhum cliente usa a tela — D3). Migrar o `services` para as peças não tem risco de uso; a worktree continua valendo só porque o PROCESSO
do setes-api de produção roda `tsx watch` na árvore viva (salvar qualquer arquivo reinicia o servidor que emite a NFS-e da Setes).
→ **DECIDIDA: D-PR2.**

**Q-PR3 — Nome do módulo/URL/pasta?** → **DECIDIDA: D-PR3 — `merchandise`** (o nome da tabela no banco).
Problema: `tb_product` contém o S; "products" precisaria de comentário ("não inclui serviço"). Opções: **(a)** `merchandise`
(`/api/merchandise` ↔ `/home/merchandise`, i18n `forms.merchandise.*`), rótulo da tela "Produtos" **(Recomendado pelo guardião)** ·
(b) `products` (rótulo "Produtos").

**Q-PR4 — Tipos expostos no form?**
Problema: a web tem P (acabado) e M (matéria-prima); o legado tinha também C (consumo) e A (automático/pizzaria) e a regra P07 (matéria-
prima não fatura, por config). Opções: **(a)** P e M selecionáveis; P07 e os tipos C/A ficam para a frente de produção **(Recomendado)** ·
(b) só P.

**Q-PR5 — Marca?**
Problema: `tb_merchandise.tb_brand_id` é NOT NULL sem default (omitir grava 0 = sentinela); marca é catálogo CENTRAL sem módulo web.
Opções: **(a)** obrigatória, com "criar na hora" pelo molde payment-types (dedupe por descrição, vínculo `tb_institution_has_brand`)
**(Recomendado)** · (b) opcional, relaxando o NOT NULL (contrato com o sync) · (c) só lookup, sem criar.

**Q-PR6 — Catálogo NCM/CEST?**
Problema: `tb_ncm`/`tb_cest` vazios no dev; `tb_ncm` mistura nomenclatura e IBPT. Opções: **(a)** onda 1 valida só a FORMA; a carga vira
peça própria separando nomenclatura NCM × IBPT por UF × CEST **(Recomendado)** · (b) carga ANTES da onda 1 e o cadastro recusa NCM fora do
catálogo.

**Q-PR7 — Unicidade do `identifier` (código do produto, candidato a `cProd`)?**
Problema: hoje é livre (services não confere); o legado só exigia com `PRO_G_VAL_CODIGOFAB='S'`. Opções: **(a)** único por institution
entre P/M/S; 409 devolve o id existente (modelo customers) **(Recomendado)** · (b) livre, como hoje.

**Q-PR8 — De onde sai o `cProd` da NF-e?**
Problema: a devolução confere o `cProd` do procNFe da origem (D-NE103); se vier do `identifier` vivo, editar o código depois da venda vira
422 `FISCAL_RETURN_REFERENCE_MISMATCH`. Opções: **(a)** o `identifier` segue editável e a NE-6 CONGELA o cProd por item **(Recomendado)** ·
(b) cProd = id · (c) `identifier` imutável depois de usado (regra que só existe para a estrutura não se contradizer — maquete).
Nota: decisão de contrato com a NE-6 — fica registrada aqui e vai como item da NE-6.

**Q-PR9 — Comissão (`aliq_kickback`) na grade de preço?**
Opções: **(a)** em produtos E em serviços (o consumidor já existe para os dois) **(Recomendado)** · (b) só em produtos · (c) em nenhum.

**Q-PR10 — indEscala + CNPJFab?**
Opções: **(a)** juntos, na NE-4/NE-6 (com o consumidor); a onda 1 não expõe **(Recomendado)** · (b) já na onda 1 (CNPJFab = coluna
aditiva em `tb_merchandise`, contrato com o sync).

**Q-PR11 — Excluir produto?**
Problema: o legado só INATIVA (`PRO_ATIVO='N'`, checagem de movimento comentada "pensando na sincronia"); o serviço faz soft delete livre
(`deleted='S'`) e `tb_order_item.tb_product_id` não tem FK. Opções: **(a)** igual ao serviço — soft delete livre; o item já vendido segue
pelo id e pelos snapshots **(Recomendado)** · (b) recusar excluir produto com movimento (409) e oferecer inativar.

**Q-PR12 — Catálogo por institution × compartilhado entre filiais?** → **Valdo: "consegue me ajudar a criar uma estrutura em que matriz
e filiais possam compartilhar produtos?"** — virou desenho próprio (§11).
Problema: na web o catálogo é por institution (PK `(id, tb_institution_id)` em tudo); no legado o produto é ÚNICO entre estabelecimentos
(`GN_PRODUTO`) com estoque por estabelecimento. Um cliente com filiais cadastraria o produto em cada uma. Opções: **(a)** manter o modelo
vigente (igual ao serviço) e registrar "catálogo compartilhado entre institutions do mesmo cliente" como frente futura **(Recomendado)** ·
(b) abrir essa discussão antes da onda 1.

**Q-PR13 — NCM parcial no dto de tax-rules (2–8 dígitos) × D36 (igualdade exata)?**
Opções: **(a)** tarefa própria que fecha o dto em 8 dígitos (fora desta frente) **(Recomendado)** · (b) manter os prefixos (então a D36
precisa de casamento por prefixo — decisão nova).

**Q-PR14 — Como tornar a D3 (liberação só sem legado) verificável?**
Opções: **(a)** item no roteiro de implantação por cliente: "sem chave de sync ativa" antes de contratar a interface **(Recomendado)** ·
(b) guarda na API (409 quando a institution tem `tb_sync_api_key` ativa) · (c) deixar como está.

## 7. Fora de escopo desta frente (mudam de lugar, não somem)

Estoque/depósitos/saldo/mínimo/negativo · custo e compra (M13) · fornecedor do produto · kit/composição · produção/ficha técnica ·
séries/lote · variação/grade · imagens · promoção · similar · base de troca · cópia de produto · instalação · IBS/CBS da mercadoria (IB-N) ·
MVA/FCP · cBenef · EXTIPI · grupos med/rastro/comb/arma/veicProd · qualquer mudança no setes-sync/sincronizador · o `published` do
merchandise-lookup de pedidos (→ D-PR29: o lookup NUNCA filtra por ele; só o comentário se corrige, na onda 1) · telas próprias
de marca/embalagem/medida · NCM parcial no dto de tax-rules (tarefa própria, D-PR13) · a frente do grupo matriz × filiais (D-PR20) · a
carga do catálogo NCM/CEST (D-PR6).

## 8. Critérios de sucesso (onda 1)

1. Mercadoria P/M nasce, muda e é excluída pela web numa transação única, sem tocar `tb_stock`, custo nem saldo.
2. Mercadoria é invisível pelo `/api/services` e serviço é invisível pelo `/api/<m>` nos três verbos (teste).
3. O faturamento de um pedido com a mercadoria criada pela web passa no motor (NCM/origem/finalidade lidos da ficha nova) — smoke.
4. NCM/CEST gravados só nos dígitos canônicos; letra recusada; a cerca D-CJ12 continua verde.
5. Ação D38 abre a regra nova com o produto preenchido e somente leitura.
6. Lista paginada + pesquisa avançada com o critério de descrição; `explain-pesquisa-avancada` sem varredura nova.
7. (D-PR2) O protocolo de id/travas é UM nos dois módulos e provado por script (zero 500 em cunhadores concorrentes); o `services`
   segue verde depois de migrado para `@shared/product-id` + `@shared/price`.
8. (D-PR15/D-PR16/D-PR19) O produto nasce com o nível base; níveis adicionais com fator e GTIN pela sub-rota; GTIN inválido ou
   duplicado recusado (TS e Dart pelo mesmo vetor); a designação tributável aponta um nível do MESMO produto.
9. (D-PR25) O cartão "Regras de tributação" abre a lista de `tax-rules` filtrada pelo produto e volta para a ficha pelo `returnTo`;
   a ficha com edição pendente não abre vinculada.
10. (D-PR7/D-PR11) `identifier` duplicado → 409 com o id do outro produto; excluir = soft delete.
11. Gates socrático ≥ 0,70 e adversarial sem HIGH/CRITICAL; passeio logado; nada publicado sem o "vai" do Valdo.

## 9. Retomada

> **2026-10-18 (noite) — Fase 1 do plano de retomada (`prompts/plano_retomada_2026-10-18.md`, Valdo: "Commita")**: o trabalho da worktree
> `merchandise` está COMMITADO na branch `merchandise` — setes-api **2171f20** (66 arquivos) · sql **8b8cedf** (03 + seed 66) — e a D-PR13
> na branch `taxrules-ncm` — setes-api **b651354** · setes-app **ef99e60**. Sem push, sem merge, NADA aplicado ao banco. O "NADA commitado"
> do bloco abaixo está SUPERADO só nesse ponto; o resto (Rodada 7, Q-PR52 trava a janela, publicar só com o "vai") segue valendo.

```
Retome a frente do cadastro de produtos (mercadoria) pelo Infra-IA/prompts/prompt_modulo_products.md.
Estado (2026-10-18, fim da sessão): onda 1 da API + Rodadas 4, 5 e 6 implementadas na WORKTREE
D:\Gestao2027\merchandise\{setes-api,sql} (branch merchandise) — NADA commitado nem aplicado ao banco (a 071, a 072 de
categorias padrão e o seed 66 só rodaram em schema descartável). Decisões: D-PR1…D-PR44 (fim do arquivo: "Rodada 6 —
DECIDIDA" = a última). A execução da Rodada 6 foi feita na sessão "Executar Rodada 6 de produtos" — seções "Rodada 6 —
execução" e "Rodada 6 — gates" no fim do arquivo (suíte 138/141, 2.112 testes, 0 falhando — as 3 da F2a por falta de .env).
Pendente: (1) gates da Rodada 6 FECHADOS (0,74 / 0,80 — o adversarial só reprova por DECISÃO pendente; os 3 achados de decisão
estão como it.failing em src/__tests__/adversarial-r6-gate.test.ts); (2) Rodada 7 com o Valdo (questões em "Rodada 6 — gates" e
"Rodada 6 — execução"): **Q-PR52 TRAVA A JANELA** (com a guarda no módulo inteiro a Setes perde o único escritor da
regra de ISS e da classificação IBS/CBS dos serviços do legado — a resposta dele dizia "bloqueamos o INSERT"), Q-PR53 (antes do
1º cliente com legado), Q-PR54, Q-PR55, Q-PR56, Q-PR50, Q-PR51, confirmar a D-PR42; e ⚠️ **Q-SY14 (grupo do sync)**: todos os pedidos da Setes estão no terminal 0 — o mesmo do
servidor local do sincronizador —, então o próximo NFL_CODIGO do legado cai em cima de um pedido da web (a premissa "o terminal
distingue a origem" não vale hoje); (3) janela com o "vai": conferir o número da migration e do seed contra o main E as
worktrees, merge na árvore viva (= deploy; a 071/072 rodam no boot em TODOS os schemas), errors:gen, seed 66, merge com
taxrules-ncm e reconciliação com os branches privilegios-crud (D-PV2) e privilegios-catalogo (D-PV9) pelo checklist do
§18.2; (4) onda 1 do APP (densidade/shell já no main do app) — inclui o interruptor do sincronizador na tela de
Institutions (D-PR43) e o "só consulta" para cliente sincronizado. Em 2026-10-18 ainda NÃO existe worktree do setes-app para
produtos (sair do main a450909); ela não toca a worktree da API e pode correr em paralelo à Rodada 7 — o risco é só a Q-PR52
mudar o contrato do PUT de serviços.
```

## 10. A tela reorganizada — 14 abas → ficha de 3 abas + painel de vínculos (pedido do Valdo; parecer do guardião 2026-10-17)

Base: `prompt_modulo_products-legado-abas.md` (a tela legada aba a aba e a TB_PRODUTO coluna a coluna). Critério de corte: **quem é o
DONO do fato**. O fato que é do catálogo e só o cadastro escreve fica no módulo; o fato que outro PROCESSO produz (compra, estoque,
produção, loja) abre a tela DAQUELE processo, já filtrada pelo produto — o cadastro nunca o escreve.

### 10.1 (A) Ficha — 3 abas (molde do `services`)
| Aba | Conteúdo | Origem no legado |
|---|---|---|
| **Principal** | código (`identifier`), descrição, tipo P/M, categoria (2 níveis = grupo/subgrupo), marca, plano financeiro, **unidade-base** (nível 1: unidade, embalagem, GTIN), ativo, observação/detalhes | cabeçalho + parte de Estoque + Observações |
| **Fiscal** | NCM, CEST, origem, finalidade; selo "ST" DERIVADO do CEST (somente leitura); resumo da unidade tributável; indEscala + CNPJFab quando a Q-PR10 trouxer | cabeçalho + Tributação |
| **Preços** | grade por tabela de preço viva + comissão (Q-PR9) | Tabelas de Preços |
| **Painel de vínculos** (não é aba) | abaixo das abas, SÓ com o produto já salvo: cartões com ícone, título, contagem e "Abrir" | substitui as abas satélite e o menu Tarefas |

### 10.2 (B) Telas vinculadas DENTRO do módulo `merchandise` (sub-rota com o produto)
| Tela | Recebe do legado | Onda |
|---|---|---|
| **Unidades e GTIN** | código de barras, embalagem + divisor, unidade comercial (cabeçalho/Estoque) + unidade/qtde tributável (Tributação) | **1** (D-PR1 — §12) |
| Kit / Composição (+ modo de baixa `PRO_COMPOSICAO`) | aba Composição | futura — depende do Estoque |
| Similares | aba Produto Similar | futura — consumidor: sugestão no pedido |
| Imagens | menu Tarefas → Imagens | futura — consumidores: apps de venda (S1) e loja virtual |
| Serviços associados | aba Instalação | futura — consumidor: venda casada no pedido |

### 10.3 (C) Telas de OUTRA interface, abertas com o produto pré-selecionado
| Item do legado | Destino (interface) | Vendável | Onda |
|---|---|---|---|
| grade de regras da aba Tributação + botão Impostos | `tax-rules` (existente) | sim | **1** (D38) |
| saldo por depósito, localização, mínimo, negativo, estoque por composição, reposição automática (= desmembrar um nível) | **Estoque** (nova) | sim | futura — exige a venda gravar `tb_order_item_merchandise` |
| fornecedores, código do fornecedor, preço fixo/recálculo pós-compra | **Compras** (nova) | sim | futura — o vínculo nasce da compra (CPA-06) |
| custo, último custo | Compras / M13 | — | futura |
| base de troca | M14 | sim | futura |
| ficha técnica + tipos C/A + regra P07 | **Produção** (nova) | sim | futura |
| séries/lotes, validade, "controla série" | M08 dentro do Estoque | não sozinha | futura |
| Internet/Tray, enviar p/ internet, variação Tray, disponibilidade | **Loja virtual** (nova) | sim | futura |
| cadastro de tabela de preço, ajuste por escala | `price-lists` (existente) | sim | quando houver consumidor |
| cBenef por UF | mora na REGRA (interpretável, por institution) | — | NE-4/NE-6 |

### 10.4 (E) Derivado / configuração · (D) Morre
- **Só exibição**: ST (pelo CEST), última compra/venda, preço de instalação, saldo, custo.
- **Os 9 `PRO_G_ABA_*` MORREM**: o cartão só aparece se a interface de destino está contratada e o usuário tem o privilégio — o contrato
  esconde por construção. `PRO_G_VAL_CODIGOFAB` → Q-PR7; `PRO_G_NAO_VALIDA_EAN` morre (GTIN é válido ou ausente); `PRO_G_COMPARTILHA` → §11.
- **Nascem com o consumidor (fora da ficha da onda 1)**: aplicação (texto puro — o Base64 é do legado), exclusivo de revenda (pedido), fora
  de linha (compra), não imprimir em tabela (relatório), publicado/promoção/destaque (Q-PR27), Cópia (ato explícito que LISTA o que copia —
  nunca o GTIN).
- **Morre**: aba Botão · `PRO_VENDA`, `PRO_SEQUENCIA`, `PRO_FABRICADO`, `PRO_IAT`, `PRO_MAISVENDIDO` · custos `*ANT` (o vault recusa
  histórico de 1 nível) · revestimento · "Qtde. tributável" como campo (vira o fator do nível) · árvore de categorias "Versão 2013" e a
  categoria fixa 2 · `PRO_CODMHA` · margem sem custo e os recálculos ao sair do campo · colunas reaproveitadas para veículo (chassi/placa/
  Renavan) · exclusão física de série · `tb_merchandise.id_internal`, `.kind`, `.id_provider` (a web não escreve).

### 10.5 O padrão "tela vinculada" no app (Q-PR25) — muda o `setes-app/ARQUITETURA_MODULOS.md`
1. **Tipo B**: `ChildRoute('/:id/<x>')` no PRÓPRIO módulo (mesmos binds); na API `/api/merchandise/:id/<x>` (simetria).
2. **Tipo C**: navega pela ROTA da interface de destino (nenhum import), levando um critério inicial no vocabulário da **Pesquisa
   Avançada do destino** (`?criteria=` — a lista branca dele recusa o resto) + `returnTo`; o destino abre a lista filtrada e o "Novo"
   pré-seleciona o produto em somente leitura (D38). Nenhum parâmetro novo por módulo.
3. **Volta**: `returnTo` só aceito se for rota `/home/…`; a ficha ganha deep link `/home/merchandise/?id=N` (resolve também o F5).
4. **Contagens dos cartões**: `GET /api/merchandise/:id/links`, lido pelas peças shared de cada dono — o app nunca chama o módulo vizinho.
5. **Ficha salva e limpa**: vinculada só abre com a ficha SALVA e sem edição pendente (mata por construção o achado 0.6 — edição perdida
   ao abrir "Impostos"); a vinculada mostra o cabeçalho do produto em somente leitura.
6. **Peça** `app/shared/linked/`: o cartão + `openLinkedInterface(i18nKey, criteria, returnTo)` resolvendo a rota pela
   `interface_routes.dart`; a `RegisterFormPage` ganha o espaço do painel.
- No `ARQUITETURA_MODULOS.md`: seção nova "Telas vinculadas" (1–6); módulo pode ter sub-rotas além de `ChildRoute('/')`; deep link `?id=N`
  e o contrato `criteria` + `returnTo`; na "Rota de escape", módulo com sub-rotas declara o próprio escape (volta à lista) e ganha o teste de
  laço `route_fallback_*`.

## 11. Matriz × filiais compartilhando produtos (Q-PR12 — desenho; frente PRÓPRIA, transversal)

> ➡️ **A frente própria ABRIU em 2026-10-17**: `prompts/prompt_frente_grupo_estabelecimentos.md` (Rodada 1 FECHADA em 2026-10-18 —
> D-GE1…D-GE17). **5ª regra de alocação da onda 1 daqui (D-GE2, `PADROES_BANCO.md` §12)**: uma tabela é do GRUPO ou do ESTABELECIMENTO,
> nunca das duas — `tb_merchandise_trade_unit` e as designações em `tb_merchandise` cumprem (chave do `tb_product` = do grupo); nada da
> onda 1 grava fato de estabelecimento em tabela do bem. Também decidido lá: papéis de entidade do GRUPO (D-GE9) e plano financeiro
> compartilhado (D-GE6).

**Fatos** (anexo 1 §4): hoje 1 institution = 1 schema = 1 CNPJ (`UNIQUE schema_name`); nada liga institutions; JWT com uma institution
só; as PKs `(id, tb_institution_id)` do schema do cliente vieram do `gestao_setes`, que guardava N estabelecimentos por schema. No legado o
produto é ÚNICO entre estabelecimentos; estoque e regra fiscal do produto são por estabelecimento; preço e satélites são compartilhados.

**Conceito (guardião)**: o grupo que compartilha o catálogo é o **CLIENTE da Setes, por decisão comercial** (o contrato com N
estabelecimentos). NÃO é a raiz do CNPJ (grupo econômico pode ter várias raízes, e no CNPJ alfanumérico "0001" deixa de identificar a matriz —
FAQ 25 da RFB) nem "a matriz é dona" (isso é o `PRO_CODMHA` reescrito do legado).

**Saída recomendada: (ii) o grupo É o schema** — `setes_<cliente>` já nomeia o cliente e as PKs já suportam N estabelecimentos; o grupo
não precisa de tabela. Descartadas: (i) catálogo na central (copia a FORMA do molde da marca sem o conceito — a marca se reusa ENTRE clientes,
o produto é privado do cliente); (iii) leitura cross-schema (quebra o schema como unidade de isolamento — GRANT, backup, FK — e exige dono);
réplica do produto em cada institution (dual-write = maquete).

**Chave do catálogo**: as tabelas do catálogo seguem com `tb_institution_id`, que passa a significar "a chave do catálogo do schema" = a
institution FUNDADORA — fato gravado UMA vez (molde do `cutover_at`): filial que fecha ou matriz que muda não reescreve nada. Com 1
institution por schema é exatamente o que existe hoje (nenhum dado muda).

| Compartilhado (catálogo do grupo) | Por institution (estabelecimento) |
|---|---|
| produto · fiscal do bem (NCM, CEST, origem, finalidade — Q-PR22) · marca · níveis/GTIN e designações · categoria · plano financeiro · tabelas de preço + grade | estoque (depósito, saldo, mínimo, negativo, localização) · regra tributária/MVA/FCP/ISS (Q22 + `TRB_CODMHA`) · emissor/série · caixa · financeiro · custo (a Compra/M13 decide) · QUAIS tabelas de preço a filial usa (vínculo N:N — Q-PR23) |

**Impacto (por isso é frente própria)**: central/onboarding (tirar o `UNIQUE schema_name` e o 1:1 implícito — `core.repository.ts:4-13`,
migration 043:18, scripts; abrir filial = institution nova num schema existente) · auth (JWT intacto; `session-context` ganha a chave do
catálogo; o app passa a usar o `switch-institution`; "admin do grupo" a decidir) · **o grosso do custo**: todo leitor que junta por
`p.tb_institution_id = x.tb_institution_id` passa a juntar pela chave do catálogo · ids (a `@shared/product-id` trava a linha dos contadores
da fundadora — medir a fila) · APIs fiscais intactas (já são por institution) · sync: o Firebird multi-estabelecimento É este modelo (pedido
ao grupo).

**Ponto de costura na onda 1 (Q-PR24)**: a peça "chave do catálogo" é LEGÍTIMA (responde UMA pergunta), mas criada hoje sempre devolveria
a própria institution — parâmetro sem consumidor. Na onda 1 bastam 4 regras de alocação: (1) toda tabela nova do produto usa a MESMA chave
do `tb_product`; (2) fato da RELAÇÃO estabelecimento × bem nunca entra em tabela do bem (a onda 1 já não toca `tb_stock`); (3) o repository
do merchandise resolve o escopo num ÚNICO ponto; (4) a `@shared/product-id` recebe a chave por nome explícito. Da frente do grupo, só a
Q-PR22 precisa ser decidida antes da onda 1.

**Divergências apontadas (o Valdo decide)**: Decisão 16 da Fase 2 ("todo tenant é tratado como institution") e D-F14 ("licenciado =
institution") seguem valendo se a licença continuar por estabelecimento; viram divergência se o GRUPO passar a ser o licenciado. **Q22**
("dado fiscal interpretável não se compartilha entre institutions") foi decidida pensando em CLIENTES diferentes, com contadores diferentes —
no grupo, NCM/CEST/origem/finalidade passam a valer para todas as filiais (Q-PR22).

## 12. Unidade de venda na onda 1 (D-PR1) — a casa (Q-PR15…Q-PR19)

**Conceito (guardião)**: a unidade comercial é um NÍVEL da mercadoria — a unidade em que ela é contada × um FATOR em unidades-base × um GTIN
próprio. Nasce do cadastro; amanhã também do XML do fornecedor (a caixa de 12 com GTIN-14 é outro nível do MESMO produto).

**Recomendação: peça nova `tb_merchandise_trade_unit`** ("trade" = uCom da NF-e e "trade item" da GS1; "unit" sozinho leria como unidade de
medida). Rótulo da tela: "Unidades e GTIN". Schema do cliente, mesma chave do `tb_merchandise` (vai junto com o catálogo — §11). Gravar no
`tb_stock` (opção b) não atende a própria D-PR1 (sem lugar para unidade tributável nem fator; DDL DENTRO da maquete; 2º escritor; a NE-4
selaria o contrato de leitura no lugar errado; a caixa com GTIN-14 não cabe em linha 1:1).

**Colunas conceituais** (não é DDL): mercadoria · **nível** (o 1 é a unidade-BASE, nasce com o produto, fator 1 por definição) · **unidade**
(`tb_measure` central, validada pelo vínculo `tb_institution_has_measure` — vai em uCom/uTrib) · **embalagem** (`tb_package`, opcional — ⚠️
sem consumidor fiscal: a NF-e do legado só lê a medida, `un_geranfe3X.pas:752-766,1180`) · **fator** (quantas unidades-base o nível contém,
decimal > 0; a tela orienta escolher a MENOR unidade como base) · **GTIN** (opcional; forma + DV GS1 pela peça de validação com espelho Dart no
MESMO vetor; único entre os níveis vivos do catálogo — Q-PR19; ausente = NULL, "SEM GTIN" nunca gravado). O par "embalagem + divisor" do
legado deixa de ser coluna — ele É um nível (CX × 12); o `escale` da `tb_measure` NÃO é o fator (CX de 12 e de 24 são a mesma medida).

**Unidade tributável (Q-PR16)**: o FATOR é da unidade (de cada nível); QUAL nível é o tributável é fato fiscal do PRODUTO — uma designação em
`tb_merchandise` apontando um nível (NULL = o próprio nível vendido, fallback do legado `un_geranfe3X.pas:1191-1207`) + uma 2ª designação: o
nível vendido quando o item não diz qual (NULL = a base; hoje `tb_order_item` não tem unidade). Duas colunas aditivas NULL, únicas POR
CONSTRUÇÃO (FK, nunca flag "só um"). `PRO_QTDE_TRIB` vira o fator do nível — o achado 0.1 (campo que nunca grava) morre junto.

**Contrato com a NE-4/NE-6**: do nível VENDIDO (hoje a designação do produto; amanhã o nível do ITEM, congelado pela NE-6) → uCom = abreviação
da unidade, cEAN = GTIN ou "SEM GTIN"; do nível TRIBUTÁVEL → uTrib e cEANTrib; `qTrib = qCom × fator(vendido) ÷ fator(tributável)`,
`vUnTrib = vProd ÷ qTrib`. O cadastro nunca calcula qTrib nem congela nada (F1). GLP (vende botijão, tributa kg) e caixa/unidade cabem sem
coluna nova.

**Correção da consequência registrada na D-PR1**: "a onda 1 passa a depender da resposta do grupo do sync" **não procede** com a peça nova —
pela D3/F9 o cadastro web só é liberado a cliente SEM legado, então nenhum cliente terá os dois escritores. O pedido ao grupo do sync (não
bloqueia a onda 1; obrigatório antes de um cliente SINCRONIZADO emitir pela nfe-api): (1) a unidade mora nesta peça — unidade/GTIN/divisor do
`tb_stock` viram resíduo do legado e a NE-4 não lê `tb_stock`; (2) o mapa legado → níveis/designações (PRO_CODMED, PRO_CODIGOBAR,
PRO_CODEMB+DIVISOR, PRO_CODMED_TRIB+QTDE_TRIB — ambiguidade: o legado tem UM GTIN usado como cEAN E cEANTrib); (3) `codebar` só vira GTIN se
passar no DV GS1 e não tiver prefixo 2 (circulação restrita); (4) as colunas novas de `tb_merchandise` exigem gravação por lista de colunas,
nunca REPLACE.

**Fica fora (nasce com o consumidor)**: código de barras PRÓPRIO (cBarra) e código de BALANÇA/PLU (dois fatos distintos do GTIN — Q-PR17);
peso e dimensões POR NÍVEL (transporte da NE-4 ou frete).

### 12.1 A tela vinculada "Unidades e GTIN" — detalhe (pedido do Valdo, 2026-10-17; desenho, nada executado)

- **Endereço**: vinculada tipo B — `/home/merchandise/?id=N` → cartão "Unidades e GTIN" → sub-rota `/home/merchandise/:id/trade-units`;
  API `GET/PUT /api/merchandise/:id/trade-units`. Só abre com a ficha SALVA e sem edição pendente (§10.5 item 5); a volta é para a ficha.
- **Cabeçalho**: código + descrição do produto, somente leitura.
- **Grade de níveis** (uma linha por nível vivo): **nível 1 = base** (selo "Base", fator 1 fixo, não excluível — nasce com o produto na
  aba Principal, que mostra o mesmo nível) · **unidade** (lookup das medidas vinculadas — a abreviação vai no uCom/uTrib; criação na hora = D-PR28) ·
  **embalagem** (opcional, descritiva — D-PR18) · **fator** ("contém N unidades-base", decimal > 0 — GLP 13 kg cabe) · **GTIN** (opcional;
  forma + DV GS1 validados ao digitar pela peça + espelho Dart; ausente = vazio, nunca "SEM GTIN"; duplicado → 409 com o produto que já o
  tem — D-PR19).
- **Designações do produto** (abaixo da grade; gravam em `tb_merchandise` — D-PR16): "Unidade de venda padrão" (escolhe um nível; vazio =
  a base) e "Unidade tributável" (escolhe um nível; vazio = a própria unidade vendida).
- **Prévia fiscal** (somente leitura, calculada na tela — o cadastro nunca congela, F1): por nível, como sairia na NF-e — ex.: vender 2
  CX12 com a tributável UN → `uCom CX · qCom 2 · uTrib UN · qTrib 24` (qTrib = qCom × fator(vendido) ÷ fator(tributável)).
- **Gravação**: a grade inteira + as 2 designações num PUT só, numa transação (presença = sincroniza, molde da grade de preços); nível que
  some da grade = soft delete.
- **Regras que nasceram do detalhe**: D-PR30 (nível DESIGNADO não se exclui — 409 apontando a designação) e D-PR31 (mesma unidade E mesmo
  fator = 409 no nível repetido).

## 13. Achados do legado que viram regra ou pedido (anexo 2 §0)

- **0.1** → regra: todo campo exposto na tela tem teste de ida e volta; o fator mora no nível (§12).
- **0.2** → ⚠️ **pedido URGENTE ao grupo do sync (Q-PR26)**: o mapeamento de 2013 grava COMISSÃO em `aliq_profit` e MARGEM em
  `aliq_kickback`; o setes-api lê `aliq_kickback` como comissão (`@shared/commission/commission.ts:64`) ⇒ a comissão por produto de cliente
  SINCRONIZADO pode estar sendo calculada pela MARGEM. **CONFERIDO pelo grupo do sync em 2026-10-17
  (`Infra-IA/setes-sync/verificacao-comissao-margem-mercadoria.md`): NÃO procede** — a inversão vive só no envio de 2013, aposentado; o
  sincronizador e o setes-sync sempre gravaram a comissão em `aliq_kickback`. O defeito REAL achado é outro: o flag
  `tb_salesman.kickback_product` recebe `CLB_CALC_COM_VDA` em vez de `CLB_COM_VDA` (Q-SY1…Q-SY7 daquele arquivo, com o Valdo). A D-PR9
  (comissão na grade) não muda.
  ✅ **VEREDITO do grupo do sync (2026-10-17, só leitura — `Infra-IA/setes-sync/verificacao-comissao-margem-mercadoria.md`)**: **NÃO
  procede no sync atual** — sincronizador (`classes/price_send_web.pas:54-55`) e setes-sync (`price.ts:97-105`) gravam a comissão em
  `aliq_kickback` desde o 1º commit; dev: 0 linhas de `tb_price` com `aliq_kickback` ≠ 0 e 0 vendedores com `kickback_product='S'`. A
  inversão de 2013 sobrevivia só DORMENTE em `destiny/controller/ControllerPrice.pas:139-140` (sem chamador — removido, D-SY2). **Achado real**: o flag do
  vendedor recebe `CLB_CALC_COM_VDA` (modo do cálculo) no lugar de `CLB_COM_VDA` ⇒ a comissão por produto NUNCA liga para vendedor
  sincronizado; e o legado combina vendedor + item onde o setes-api substitui (pesa na D-PR9). Respostas do anexo 2 §4 e do §12 no §4 do
  registro (indEscala vai `'N'` FIXO; `PRO_CODMED_TRIB`/`PRO_QTDE_TRIB` não são enviados; `PRO_APLICACAO` chega em Base64; 1 chave = 1
  institution, `*_CODMHA` não viaja). **Rodada do sync DECIDIDA em 2026-10-17** (Valdo: "pode seguir com as recomendações" →
  D-SY1…D-SY7, §7 do registro): **D-PR26 ENCERRADA sem script de reparo** (D-SY1; a conferência entrou no roteiro de implantação);
  indEscala real e aplicação em texto (D-SY5/D-SY6 — patch 10 do sincronizador aguarda compilação + reenvio dos produtos; setes-sync
  grava indEscala vazio como NULL); o flag do vendedor só se corrige DEPOIS que a frente de comissão decidir a fórmula (D-SY3 travada
  pela D-SY4 — é o que pesa na D-PR9); 1 Firebird = 1 estabelecimento é limite do sync até a frente matriz × filiais (D-SY7).
- **0.3** → regra para a frente Compras: a PK do vínculo produto × fornecedor nunca deixa apagar vínculo de outro produto.
- **0.4** → a grade só aceita tabela VIVA e, no grupo, LIGADA à filial (Q-PR23).
- **0.5 / 0.11** → morrem. **0.6** → resolvido pelo §10.5 item 5. **0.7** → resolvido pela chave do catálogo gravada uma vez (§11).
- **0.9** → "Novo" sempre nasce vazio. **0.10** → o id nunca é editável; Base64 → texto vira pedido ao sync.
- **0.12** → o CNPJFab é do fabricante da MERCADORIA; a `tb_brand` é compartilhada ENTRE clientes, então pôr o fabricante nela faria o fato
  de um cliente valer para todos → vai para a Q-PR10.

## 14. Questões — Rodada 2 (TODAS DECIDIDAS em 2026-10-17 pela recomendação — D-PR15…D-PR27)

**Q-PR15 — Casa da unidade de venda** (o `tb_stock` não tem lugar para unidade tributável, fator nem caixa). **(a)** peça
`tb_merchandise_trade_unit` (níveis) + 2 designações em `tb_merchandise` **(Recomendado)** · (b) o subconjunto em `tb_stock`, com DDL nela ·
(c) colunas em `tb_merchandise` (um nível só; a caixa obriga a reformar depois).

**Q-PR16 — Unidade tributável.** **(a)** designação de NÍVEL no produto + fator no nível; NULL = a unidade vendida **(Recomendado)** ·
(b) unidade + fator como colunas do produto (forma do legado; o cEANTrib fica sem casa).

**Q-PR17 — Código de barras próprio e código de balança na onda 1?** **(a)** só GTIN; os outros dois nascem com PDV/balança ou com o
cBarra da NE-4 **(Recomendado)** · (b) coluna de código próprio por nível já na onda 1.

**Q-PR18 — Embalagem no nível** (sem consumidor fiscal). **(a)** opcional e descritiva **(Recomendado)** · (b) obrigatória, como no legado.

**Q-PR19 — Unicidade do GTIN.** **(a)** único entre os níveis vivos do catálogo; 409 devolve o produto que já tem o GTIN **(Recomendado)** ·
(b) só aviso.

**Q-PR20 — Estrutura do grupo (matriz × filiais).** **(a)** frente PRÓPRIA transversal com a saída (ii): grupo = schema, chave do catálogo
gravada uma vez **(Recomendado)** · (b) catálogo na central · (c) leitura cross-schema · (d) não fazer (cada filial cadastra os seus).

**Q-PR21 — O que define o grupo.** **(a)** decisão comercial (o contrato = o schema) **(Recomendado)** · (b) mesma raiz de CNPJ ·
(c) grupo econômico declarado.

**Q-PR22 — Finalidade e origem no grupo (pesa a Q22).** **(a)** são do BEM, compartilhadas como no legado; a divergência de uma filial vive
na REGRA dela — antes, confirmar com o contador as origens 1×2 e 6×7 (dependem de quem importou) **(Recomendado)** · (b) são da RELAÇÃO
estabelecimento × bem (peça por institution). ⚠️ Única questão da frente do grupo que precisa fechar ANTES da onda 1.

**Q-PR23 — Preço no grupo.** **(a)** tabelas do catálogo + vínculo da filial com as tabelas que usa **(Recomendado)** · (b) grade por
estabelecimento · (c) compartilhado sem vínculo (como no legado).

**Q-PR24 — Ponto de costura na onda 1.** **(a)** só as 4 regras de alocação do §11; a peça "chave do catálogo" nasce com a frente do grupo
**(Recomendado)** · (b) criar a peça já no `session-context`.

**Q-PR25 — Padrão de tela.** **(a)** ficha de 3 abas + painel de cartões; (B) por sub-rota; (C) por rota com o critério da Pesquisa Avançada
do destino + `returnTo` (§10.5) **(Recomendado)** · (b) mais abas na ficha · (c) diálogos abertos sobre a ficha.

**Q-PR26 — Inversão comissão × margem do mapeamento de 2013.** **(a)** tarefa URGENTE do grupo do sync + script de conferência e reparo, antes
de algum cliente sincronizado depender da comissão por produto **(Recomendado)** · (b) esperar a frente de comissão.

**Q-PR27 — publicado/promoção/destaque** (flags do site de 2013, sem leitor hoje; a opção (a) revê o §4.2 e diverge da D2 do serviço, que os
expôs). **(a)** só "ativo" fica na ficha; as outras três nascem com o consumidor (lookup de pedidos com `published`, apps S1, loja virtual)
**(Recomendado)** · (b) as quatro na Principal, como a D2 do serviço.

## 15. Mapa das ondas — revisto (2026-10-17)

| Onda / frente | Conteúdo | Depende de |
|---|---|---|
| **Onda 1 — cadastro** | ficha (Principal/Fiscal/Preços) + **Unidades e GTIN** (sub-rota B, `tb_merchandise_trade_unit` + designações) + D38 (vinculada C para `tax-rules`) + painel de vínculos (só os cartões com destino existente) + pesquisa + correções de kind + peças `@shared/product-id`/`@shared/price`/`@shared/brand`/validação (NCM, CEST, GTIN + espelho Dart) + `services` migrado para as peças | Rodadas 1–2 FECHADAS (D-PR1…D-PR27) → escopo no §16; falta a Rodada 3 (§17) |
| Padrão "telas vinculadas" no app | `app/shared/linked/`, sub-rotas, deep link `?id=N`, `criteria` + `returnTo`, escape por módulo | nasce DENTRO da onda 1 (1º consumidor) |
| **Frente do grupo (matriz × filiais)** | grupo = schema, chave do catálogo, onboarding de filial, `switch-institution` no app, leitores pela chave, vínculo filial × tabela de preço | D-PR20…D-PR23 decididas; abre em prompt próprio (Rodada 0); condição da D-PR22 (contador); pedido ao grupo do sync |
| Carga NCM/CEST | peça própria separando nomenclatura × IBPT por UF × CEST | Q-PR6 |
| indEscala + CNPJFab | fabricante da mercadoria | NE-4/NE-6 (Q-PR10) |
| **Pedido urgente ao grupo do sync** | inversão comissão × margem (Q-PR26) + mapa da unidade de venda (§12) | tarefa do grupo do sync |
| Estoque · Compras (custo M13, fornecedor) · Produção · Loja virtual · M08 séries/lote · M14 base de troca | frentes próprias — cada uma vira um cartão do painel quando nascer | cada frente |
| Vinculadas futuras do próprio módulo | Kit/Composição · Similares · Imagens · Serviços associados | consumidor de cada uma |

## 16. Escopo executável da onda 1 (fechado pelas Rodadas 1–2; substitui o §4)

### 16.1 Preparação
- **Worktrees** dos três repos (`setes-api`, `setes-app`, `sql`) em `D:\Gestao2027\merchandise\…`, branch `merchandise` a partir do `main`
  vivo — o processo do setes-api de produção roda `tsx watch` na árvore viva e o app roda `flutter run` na :5051.
- **Número da migration** conferido entre as frentes NO MOMENTO (próxima no `main` = 071 em 2026-10-17; worktrees `cnpj`, `ib3`, `ne1b`,
  `f2a`, `ib2` — PADROES §11 regra 14).
- **DDL** pela `database/PADROES_BANCO.md` + skill `database/skills/revisar-ddl.md`, provado em schema descartável antes de tocar o dev.
- Conferir no `prompt_onda_nfe_sefaz.md` se a NE-4/NE-6 mudou o contrato de leitura do produto desde 2026-10-17.
- ⚠️ **Sessão paralela "densidade e layout das telas web"** (`prompts/prompt_densidade_layout_web.md`, D-DL1…D-DL5; branch `densidade`
  LOCAL no setes-app em 2026-10-17): mexe na fábrica `RegisterFormPage` (`SetesFormGrid` de 12 colunas, `RegisterField.size`), no
  `entity_main_tab` e na skill `criar-formulario-cadastro.md` item 3 (grade obrigatória). O módulo `merchandise` e o painel de vínculos
  (§10.5) usam a MESMA fábrica ⇒ a onda 1 do app nasce sobre o `densidade` já mergeado no `main` (ou rebaseia nele antes de começar) —
  nunca em paralelo nos mesmos arquivos. **Atualização 2026-10-18**: a mesma frente abriu a onda D (shell) noutra worktree, branch
  `shell` (D-DL6/D-DL7) — conferir os DOIS branches no `main` antes de começar o app.

### 16.2 Banco (migration aditiva + espelho no repo `sql`)
- **`tb_merchandise_trade_unit`** (schema do cliente, mesma chave do `tb_merchandise` — D-PR15/D-PR24): mercadoria · nível (1 = base,
  fator 1) · unidade (`setes_central.tb_measure`, vinculada pela `tb_institution_has_measure`) · embalagem NULL (`tb_package`; nunca a
  sentinela — D-PR18) · fator > 0 · GTIN NULL (forma + DV na peça; único entre os níveis vivos do catálogo — D-PR19) · datas · deleted.
  Regras do nível: (unidade, fator) único entre os níveis vivos do MESMO produto (D-PR31); nível designado não se exclui (D-PR30, 409
  apontando a designação); unicidade conferida só quando o valor nasce ou muda (A-PR1).
- **`tb_merchandise`**: 2 designações NULL com FK para o nível — tributável (D-PR16; NULL = o vendido) e vendido quando o item não diz
  (NULL = a base). Aditivas: o sync segue gravando a tabela sem conhecê-las (pedido §12 item 4).
- Índice de pesquisa revisado por critério (D-BA11 — ex.: NCM, GTIN).
- Seeds: interface `merchandise` (grupo Cadastros, `kind 'T'`, **id dinâmico**), contrato da Setes, `page_size` (seed 22), flags
  retroativas + `insertDefaultFlags`, catálogo de campos (`npm run fields:gen`).

### 16.3 API (setes-api)
- **Peças**: `@shared/product-id` (id de `tb_product` com `lockInstitutionCounters` como 1º lock + `withDeadlockRetry`; unicidade do
  `identifier` — D-PR2/D-PR7) · `@shared/price` (grade `tb_price`, executa a D4; com `aliq_kickback` — D-PR9) · `@shared/brand` (D-PR5) ·
  `@shared/validation` (NCM 8, CEST 7, GTIN 8/12/13/14 + DV GS1, sem `replace(/\D/g…)` — cerca D-CJ12) · domínios de origem/finalidade
  promovidos para `@shared/tax-rule`.
- **Módulo `merchandise`** (6 arquivos; `/api/merchandise`): lista paginada + Pesquisa Avançada (descrição sempre, código, tipo,
  categoria, marca, NCM, CEST, origem, finalidade, GTIN por EXISTS, ativo) · `GET/POST/PUT/DELETE` com `WHERE kind IN ('P','M')` e UMA
  transação (product-id → `tb_product` → `tb_merchandise` → nível base → grade) · sub-rota B `/:id/trade-units` · `GET /:id/links`
  (contagens dos cartões pelas peças dos donos) · lookups do PRÓPRIO módulo (categorias `kind='P'`, planos, marcas + criar, medidas e
  embalagens + criar na hora — D-PR28, tabelas de preço vivas, origem/finalidade) · soft delete (D-PR11) · códigos de erro + `errors:gen` · Swagger.
- **`services` migrado** para `@shared/product-id` + `@shared/price` e com a comissão na grade (D-PR2/D-PR9).
- **Correções de kind** (§4.6): categorias do services com `kind='S'`; `/api/tax-rules/products` e `findInvalidSelectorRefs` com kind.
- **`published` (D-PR29)**: o produto nasce com `published='N'` (flag de e-commerce, oculto na ficha — D-PR27); o comentário de
  `orders.repository.ts:171` passa a dizer "itens ativos" — o lookup de pedidos nunca filtra por `published`.
- **Medida e embalagem (D-PR28)**: peças no molde da `@shared/brand` (dedupe na central dentro da transação — medida pela abreviação,
  embalagem pela descrição — + vínculo `tb_institution_has_*`, que é tabela do GRUPO pelo `PADROES_BANCO.md` §12).

### 16.4 App (setes-app)
- **Módulo `merchandise`** (agente `setes-form-builder`, verificado no disco): ficha de 3 abas (Principal/Fiscal/Preços) + painel de
  cartões (só cartões com destino EXISTENTE na onda 1: "Unidades e GTIN" e "Regras de tributação") · sub-rota "Unidades e GTIN" · deep
  link `/home/merchandise/?id=N` · escape próprio por ter sub-rotas + teste de laço `route_fallback_*`.
- **Peça `app/shared/linked/`**: cartão + `openLinkedInterface(i18nKey, criteria, returnTo)`; `returnTo` só aceito com `/home/…`.
- **`tax_rules`** aceita `criteria` + `returnTo` na entrada e o "Novo" com o produto pré-selecionado em somente leitura (D38).
- **Espelho Dart da validação do GTIN** lendo o MESMO vetor de casos da peça TS (molde `federal-id`).
- `services`: comissão na grade. i18n pt/en (`forms.merchandise.*`, `search.merchandise.*`), `interface_routes.dart`, `home_module.dart`.

### 16.5 Documentação na entrega
`setes-app/ARQUITETURA_MODULOS.md` (seção "Telas vinculadas" já registrada como decidida — confirmar contra o código entregue) · skills
`novo-modulo.md` / `criar-formulario-cadastro.md` (painel de vínculos e sub-rota) · `PADROES_BANCO.md` se nascer regra · cadeia da
`atualizar-infra-ia.md`.

### 16.6 Contratos com outras frentes (não executados aqui)
- **NE-4** (nfe-api) LÊ o nível vendido/tributável e as designações (§12: uCom, cEAN, uTrib, cEANTrib, qTrib = qCom × fator(vendido) ÷
  fator(tributável)).
- **NE-6** congela por item o cProd (D-PR8), o GTIN e a unidade; o cadastro nunca congela (F1).
- **Grupo do sync**: §12 itens 1–4 (unidade de venda) + D-PR26 (inversão comissão × margem — cartão próprio) + as perguntas do anexo 2 §4.
- **Tarefa própria** D-PR13 (NCM 8 dígitos no dto de tax-rules) · **frente do grupo** D-PR20…D-PR23 · **carga NCM/CEST** D-PR6.
- Os prompts das outras frentes NÃO foram editados por esta sessão (a da nfe-api está com o `prompt_onda_nfe_sefaz.md` aberto) — os
  itens acima entram neles pela sessão de cada frente.

### 16.7 Prova e gates
Testes jest (molde services: mercadoria invisível pelo `/services` e serviço invisível pelo `/merchandise` nos 3 verbos; FK 400 com
`fields`; grade duplicada; 401; identifier e GTIN duplicados → 409 com o id) · vetor de GTIN (TS e Dart) · prova do protocolo de id/travas
por script com cunhadores concorrentes (zero 500) · smoke E2E (cadastrar → pedido → faturar no motor) · passeio logado · gates socrático
(≥ 0,70) + adversarial (sem HIGH/CRITICAL) · `tsc` / `flutter analyze` limpos · Swagger conferido. Nada publicado sem o "vai" do Valdo.

### 16.8 Execução da onda 1 — lado da API (2026-10-18, WORKTREE; NADA commitado nem aplicado ao banco)

Pedido do Valdo: "comece a onda 1 de produtos pela API numa worktree; o app espera os branches densidade e shell".

**Onde**: `D:\Gestao2027\merchandise\setes-api` e `D:\Gestao2027\merchandise\sql` (branch `merchandise` a partir do `main` vivo —
setes-api `f53a618`). A produção (o `tsx watch` da árvore viva) NÃO foi tocada; a migration 071 e o seed 66 NÃO rodaram no banco do dev
(= produção) — só em schemas descartáveis criados e apagados pelas provas.

**Entregue (código)**:
- **Migration `071_merchandise_trade_unit.sql`** (+ bloco canônico em `sql/03`): `tb_merchandise_trade_unit` (PK instituição × mercadoria ×
  nível; `live_gtin` = `LPAD(gtin, 14, '0')` só nas vivas → `uq_mtu_live_gtin` pela IDENTIDADE GS1 — A-PR3; `live_marker` →
  `uq_mtu_live_unit_factor` — D-PR31; CHECKs de nível/fator/base/forma do GTIN) + 2 designações em `tb_merchandise` com FK para o nível
  (D-PR16). Prova `scripts/prove-071-merchandise-trade-unit.ts`: **23/23** (re-executável, aditiva sobre linhas existentes).
- **Peças**: `@shared/product-id` (id pela regra 7 — institution 1º, MAX sem FOR UPDATE; código único entre P/M/S; frase própria quando o
  código AUTOMÁTICO colide com um digitado) · `@shared/price` (grade + `aliq_kickback` — D-PR9; `productPriceInputDto` = UMA forma do DTO
  para serviço e mercadoria) · `@shared/central-catalog` (marca/medida/embalagem "na hora" — D-PR5/D-PR28; dedupe pela identidade da D17 —
  UPPER(TRIM) binário; criação SERIALIZADA por trava nomeada, espera curta) · `@shared/validation` (`isNcm` idêntico ao do branch
  `taxrules-ncm`, `isCest`, `isGtin` + vetor `gtin.vector.json`, `gtinIdentity`, `decimalField`) · domínios de origem/finalidade em
  `@shared/tax-rule` (+ `findInvalidSelectorRefs` e o lookup de produtos do tax-rules com kind P/M; `countTaxRulesForProduct`).
- **Módulo `merchandise`** (6 arquivos, `/api/merchandise`, flag `merchandise` no `insertDefaultFlags`): lista paginada + Pesquisa Avançada
  (10 critérios; o GTIN entra no FILTRO RÁPIDO pela identidade GS1 — a peça de critérios só aceita 1:N como `shape:'set'` de lookup → Q-PR36)
  · ficha GET/POST/PUT/DELETE (kind P/M em todo WHERE) · sub-rota `/:id/trade-units` · `/:id/links` · lookups do próprio módulo + criar
  marca/medida/embalagem · Swagger · 8 códigos de erro novos (`PRODUCT_IDENTIFIER_TAKEN`, `GTIN_TAKEN`, `TRADE_UNIT_DUPLICATE`,
  `TRADE_UNIT_DESIGNATED`, `TRADE_UNIT_BASE_REQUIRED`, `TRADE_UNIT_NOT_FOUND`, `CATALOG_ITEM_NOT_LINKED`, `MERCHANDISE_FACTS_MISSING`).
- **`services` migrado** para `@shared/product-id` + `@shared/price` (comissão na grade), `withDeadlockRetry` no POST/PUT, lookup de
  categorias só `kind 'S'` (§4.6 — ⚠️ Q-PR38). Comentário de `orders.repository.ts:171` corrigido (D-PR29).
- **Seed `sql/66`** (nasceu 64 na worktree; o 64 do repo `sql` é o dos PRIVILÉGIOS — `3672ee2` — e o 65 o da tela `institution-interfaces`,
  ambos de outras sessões — renumerado duas vezes ao conferir): interface `merchandise` (id dinâmico), **privilégios V/I/A/E** (D-GE19/D-PV1 — molde de `services`), `page_size`, flag
  retroativa, catálogo de campos. **SEM contrato** — a Setes tem `tb_sync_api_key` ATIVA (conferido no banco, só leitura) e a D-PR14 não a
  libera (o 1º rascunho do seed a contratava — achado do gate). Provado numa cópia descartável das tabelas centrais, rodado 2× (8/8).
- **Cerca M5** (`scripts/explain-pesquisa-avancada.ts`): a lista `merchandise` entrou nos TARGETS; medida numa cópia descartável com a 071 —
  APROVADO (0 falha).

**Gates** (skills `revisar-riscos-sistemicos` + `testar-adversarial`):
- 1ª rodada REPROVOU — socrático **0,62**, adversarial **0,55** com **2 HIGH provados em schema descartável**: o
  `INSERT … ON DUPLICATE KEY UPDATE` numa tabela com UNIQUE além da PK ATUALIZA a linha que colidiu (o nível novo de um produto reescrevia o
  nível de OUTRO produto na corrida de GTIN; o nível novo sumia com 200/201 quando colidia com o vizinho). Os 27 testes simulados não
  enxergavam: o mock afirmava um ER_DUP_ENTRY que o banco real não lança. MEDIUMs: fator/preço fora da coluna DECIMAL (o servidor roda sem
  modo estrito — grampeia/arredonda calado), GTIN 13 × 14 dígitos, criação na central deadlockando (7/8), seed contratando a Setes,
  serviço sem retry.
- **Correção** (todas com teste): gravação do nível em DUAS FASES (linha minha = UPDATE pela PK; linha nova = INSERT puro; troca entre
  níveis = estacionar `deleted = 'S'` e regravar) → **regra 10 do PADROES §9**; dono do GTIN relido por leitura TRAVANTE para o 409;
  `decimalField` nos DTOs (+ `02-VALIDACAO.md`); identidade GS1 (A-PR3); criação na central por `GET_LOCK` + espera curta da sessão +
  conexão descartada se a trava não sair → **regra 11**; leitura travante uma por tabela na edição da ficha (regra 9); A-PR1 também nas
  referências (marca/categoria gravadas e inalteradas não são reconferidas); designação AUSENTE = a gravada (A-PR2); produto sem ficha
  fiscal → 409. Conhecimento negativo da prova do protocolo do id → **regra 12** (trava de registro só serializa linha que EXISTE).
- Re-prova no banco (roteiro do gate, funções REAIS em schema descartável): V1 preço → 400 · V2/V3 fator → 400 · V4 3 níveis preservados ·
  V5 troca de (unidade, fator) ok · **V6/V7 corridas → 409 GTIN_TAKEN com o id do dono, nenhum nível alheio tocado** · V8 13×14 → 409 · V9
  frase do código automático · V10 serviço invisível · V12 8 criações concorrentes na central → 8 ok, 0 deadlock, 0 duplicata.
- Re-gate do delta: socrático **0,74 ✅** (sem HIGH; M1–M4 viraram questão ou correção — dedupe pela identidade da D17 (UPPER/TRIM binário,
  sem `FOR UPDATE` na tabela central), espera curta da sessão enquanto a trava global é segurada, filtro rápido do GTIN pela identidade,
  conexão descartada se a trava não sair) · adversarial **0,80 ✅** (sem HIGH; S1–S14 com as funções reais em schema descartável: 6 PUTs
  simultâneos no mesmo produto em série, troca cruzada de GTIN entre dois produtos = 409 nos dois sem perda, regravação que falha no meio
  volta inteira pelo rollback, identidade GS1 UPC-A = EAN-13 = GTIN-14). O MEDIUM do re-gate (ADV2-01 — preço removido e devolvido sem
  `aliqKickback` revivia a comissão da linha MORTA) foi CORRIGIDO ("a revivida nunca herda"; a ordem das atribuições do `ON DUPLICATE` provada
  no banco) e os LOW também: `level: null` = nível novo, GTIN todo zero recusado (vetor atualizado), base excluída e designação inexistente
  com a saída dita, tolerância do `decimalField` por ULP, Swagger com os códigos novos. Ficam como LIMITE: última gravação vence entre a ficha
  e a sub-rota no nível 1 (padrão da casa, sem versão otimista); serviços passaram a recusar preço com mais de 6 casas ou acima do teto (o app
  de serviços só confere ≥ 0 — o erro vem do servidor no campo `prices.N.priceTag`).
- Suíte da API na worktree: **131/134 suítes verdes — 2.029 testes passando, 0 falhando** (as 3 que não sobem são os gates ao vivo da F2a
  que leem o `.env` da árvore — ambiente, não regressão); `tsc` limpo; 6 arquivos de teste adversarial novos (rodadas 1 e 2 dos gates). Dois testes antigos ajustados por causa da mudança (o `service-tax-rules` — nova ordem
  das consultas; o `adversarial-f2a-r6` usava "071" como número FICTÍCIO de renumeração e passou a calcular o próximo livre).

**Para o merge (JANELA, só com o "vai")**: (1) Q-PR37 respondida pelo grupo do sync ANTES — o runner aplica a 071 em TODOS os schemas no
boot, inclusive os sincronizados (ALTER com ADD FK = cópia da `tb_merchandise` por schema); (2) Q-PR38 resolvida antes (senão a Setes
perde o "Novo serviço"); (3) `npm run errors:gen` (escreve no catálogo de erros da central); (4) seed 66 depois do 64/65 e da 071 (conferir o número de novo); (5) merge com o
branch `taxrules-ncm` (D-PR13): conflito trivial no import do `tax-rules.dto.ts`; o `isNcm` é idêntico.

**Limites conhecidos**: designar um nível NOVO na mesma requisição exige conhecer o número que a API dará (o app grava os níveis e depois
designa); a medida do sync sem abreviação deixaria o uCom vazio (contrato da NE-4 — o consumidor barra); a trava nomeada só ordena os
escritores do setes-api (o sync cria itens centrais pelo protocolo dele).

**App (onda 1)**: espera os branches `densidade` e `shell` no `main` (§16.1). Consome: 409 com `fields[1]` = id do outro, A-PR2
(designação ausente = mantém), espelho Dart do GTIN lendo `gtin.vector.json`.

## 17. Questões — Rodada 3 (TODAS DECIDIDAS em 2026-10-18 pela recomendação — A-PR1 confirmada, D-PR28…D-PR31)

**A-PR1 (assunção — confirmar)**: a unicidade do `identifier` (D-PR7) e do GTIN (D-PR19) é conferida só quando o valor NASCE ou MUDA
(precedente D-G34 do cancelamento: "o contrato revalida só item NOVO/ALTERADO") — produto vindo do legado com duplicidade continua
editável nos outros campos; a duplicidade aparece só quando alguém mexe no código/GTIN.

**Q-PR28 — Quem cria unidade de medida e embalagem?** Com a D-PR1 elas entraram na onda 1; são catálogos CENTRAIS (como a marca) sem tela
web, e o dev tem 3 medidas (uma com descrição errada, "KILOGRAA") e 1 embalagem (a sentinela). A abreviação da medida é o que vai no uCom
da NF-e (1 a 6 caracteres). **(a)** mesmo molde da marca: "criar na hora" na central com dedupe pela ABREVIAÇÃO (medida) e pela descrição
(embalagem) + vínculo `tb_institution_has_*`; descrição imutável **(Recomendado)** · (b) só lookup das vinculadas; criar fica para tela
própria do Super · (c) seed central de unidades padrão + lookup.

**Q-PR30 — Excluir um nível que está designado (tributável ou venda padrão)?** (detalhe da tela, §12.1) **(a)** recusar com 409
apontando a designação — o usuário troca a designação primeiro **(Recomendado)** · (b) excluir e limpar a designação (volta ao padrão em
silêncio — a NF-e mudaria sem ninguém decidir).

**Q-PR31 — Dois níveis com a mesma unidade E o mesmo fator?** (ex.: duas "CX × 12") **(a)** recusar (409 no nível repetido) — CX12 e CX24
convivem porque o fator difere **(Recomendado)** · (b) permitir (distinguem-se só pela embalagem/GTIN).

**Q-PR29 — O que `published` significa e qual o default no produto da web?** O mapeamento de 2013 grava `PRO_INTERNET` (publicar na
internet) em `published` (WS13:1262), mas o lookup de pedidos se descreve como "itens ativos e publicados" (`orders.repository.ts:171`) e a
Rodada 0 listou "filtrar `published` no lookup de pedidos" como tarefa própria. Se o lookup passar a filtrar, todo produto criado pela web
com o flag oculto (D-PR27) sumiria do pedido. **(a)** `published` = publicar na INTERNET (e-commerce); default 'N' no cadastro; o lookup de
pedidos NUNCA filtra por ele e o comentário é corrigido — a "tarefa própria" do §7 morre **(Recomendado)** · (b) `published` = disponível
para venda; default 'S'; o lookup filtra.

## 18. Questões — Rodada 4 (abertas em 2026-10-18 pelos gates da onda 1 da API — DECIDIDAS em 2026-10-18, menos a Q-PR38 → Q-PR38', §18.1)

**A-PR2 (assunção EXECUTADA — confirmar)**: no `PUT /:id/trade-units`, designação AUSENTE no corpo = mantém a gravada; `null` = volta ao
padrão (tributável = a vendida; venda = a base). Molde do `aliqKickback` (D-PR9) — a NF-e nunca muda sem alguém decidir (espírito da D-PR30).

**A-PR3 (assunção EXECUTADA — confirmar)**: a unicidade do GTIN (D-PR19) é pela IDENTIDADE GS1 — a forma de 14 dígitos com zeros à
esquerda (o GTIN-13 7891234567895 e o GTIN-14 07891234567895 são o mesmo código); o GTIN é GRAVADO como digitado (é o cEAN impresso —
a NE-6 congela o que está gravado). O filtro rápido também acha pela identidade.

**Q-PR32 — Gate TÉCNICO da D-PR14?** Hoje a D-PR14 é só processo: a flag `merchandise` liga para TODA institution (seed 66 +
`insertDefaultFlags`) e a API confere só a flag. Um token da Setes (sincronizador ativo) consegue criar mercadoria — id MAX+1 no espaço do
PRO_CODIGO do legado, dois escritores na mesma tabela. **(a)** a guarda do módulo recusa (409 legível) institution com `tb_sync_api_key`
ativa nas ESCRITAS de `/api/merchandise` (leitura liberada) **(Recomendado)** · (b) a flag não nasce para institution com sync · (c) fica
no processo (menu/contrato).

**Q-PR33 — Quem pode criar item no catálogo CENTRAL (marca/unidade/embalagem)?** É compartilhado entre clientes e o 1º criador fixa a
descrição para todos (imutável). Hoje: qualquer usuário com a interface. **(a)** privilégio de ação próprio na interface `merchandise`
(admin passa — D32; molde D-GE19 "toda tela nasce com interface + privilégios") **(Recomendado)** · (b) qualquer um com a interface.

**Q-PR35 — Abreviação da unidade: 5 ou 6 caracteres?** A D-PR28 diz 1 a 6 (o uCom da NF-e aceita 6), mas
`setes_central.tb_measure.abbreviation` é `varchar(5)` e o DTO corta em 5. **(a)** fica 5 por ora; alargar é DDL na central compartilhada
→ pedido ao grupo do sync **(Recomendado)** · (b) alargar para 6 já (migration central + aviso ao sync).

**Q-PR36 — GTIN na Pesquisa Avançada?** O §16.3 pedia "GTIN por EXISTS"; a peça de critérios só aceita 1:N como `shape:'set'` de LOOKUP. A
entrega pôs o GTIN no FILTRO RÁPIDO (igualdade pela identidade GS1). **(a)** confirmar o filtro rápido **(Recomendado)** · (b) estender a
peça com texto 1:N (frente da Pesquisa Avançada).

**Q-PR37 — Contrato com o grupo do sync ANTES da 071 rodar em schema sincronizado.** O runner aplica a 071 em TODOS os schemas no boot
(inclusive `setes_setes`): 2 colunas NULL + FK circular `tb_merchandise` ↔ `tb_merchandise_trade_unit` (o baseline tem ON DELETE CASCADE
`tb_product` → `tb_merchandise`; a 071 é NO ACTION). Se o sync faz `REPLACE`/`DELETE` físico num produto que ganhou nível, recebe 1451.
**(a)** pedir ao grupo do sync a confirmação (INSERT com lista de colunas, nunca REPLACE/DELETE físico em `tb_product`/`tb_merchandise`;
o que ele responde a um 1451) e só então fazer a janela **(Recomendado)** · (b) a 071 sem a FK `fk_mtu_merchandise` (a peça garante).

**Q-PR38 — A Setes perde o "Novo serviço" com o merge.** `setes_setes` tem só 2 categorias, ambas de PRODUTO, e os 45 serviços vivos
estão nelas; a interface `services` está contratada. O lookup de categorias do serviço passou a filtrar `kind 'S'` (§4.6) → lista vazia;
a validação do serviço ainda aceita qualquer categoria (os 45 seguem editáveis; pela API dá para gravar serviço em categoria de produto).
**(a)** tarefa de implantação ANTES da janela: criar a(s) categoria(s) de serviço pela tela Categorias + pergunta ao grupo do sync sobre a
categoria dos serviços que o legado envia; depois alinhar a validação ao lookup respeitando a A-PR1 (só categoria que MUDA é conferida)
**(Recomendado)** · (b) o lookup oferece também a categoria ATUAL do serviço · (c) adiar o filtro.

**Q-PR39 — UMA identidade para o catálogo central nos dois grupos.** O sync (D17) deduplica por UPPER(TRIM(descrição)) sem colapsar acento
— inclusive a MEDIDA pela descrição; o setes-api (D-PR28) deduplica a medida pela ABREVIAÇÃO. A entrega já segue a D17 no
UPPER/TRIM/acento (comparação binária). **(a)** medida pela abreviação nos DOIS grupos (é o uCom) → pedido ao grupo do sync
**(Recomendado)** · (b) medida pela descrição (D17) também no setes-api.

**Q-PR40 — Trocar a unidade-BASE de produto que tem níveis adicionais?** O fator dos outros níveis é em unidades-base: trocar "UN" por
"KG" muda em silêncio o significado de "CX × 12" e o qTrib. **(a)** recusar (409) enquanto houver nível adicional vivo — remove/ajusta os
níveis antes **(Recomendado)** · (b) aceitar · (c) aceitar com confirmação explícita no corpo.

### 18.1 Q-PR38' — a categoria de serviço (reformulada, 2026-10-18 — aguarda o Valdo)

O Valdo perguntou: *"eu preciso criar ou cria-se no seed e aplica um padrão?"*. Fatos levantados para responder:
- `tb_category` vive no schema de CADA cliente — um seed do repo `sql` roda à mão num schema só; quem roda em TODOS os schemas (e no
  onboarding do cliente novo) é a MIGRATION do setes-api.
- Na Setes as categorias vêm do LEGADO (sincronizador ativo — os grupos/subgrupos viram `tb_category` no bootstrap do sincronizador), e o
  legado não separa produto de serviço: as 2 categorias da Setes são kind 'P' e os 45 serviços estão nelas. Criar categoria pela web
  num schema que o legado alimenta põe dois escritores na mesma tabela (o id MAX+1 da web cai no espaço do próximo grupo do legado).
- A trilha do primeiro cliente (`scripts/trilha-primeiro-cliente.ts`, P1) cria serviço NA SETES pela API — a régua da fase usa o
  cadastro web de serviços num estabelecimento com sincronizador (a D-PR14 diz o contrário para clientes novos; a Setes é o dogfooding).

- **Confirmado pelo grupo do sync (2026-10-18, só leitura — `setes-sync/verificacao-comissao-margem-mercadoria.md` §8)**: toda categoria
  sincronizada nasce kind 'P', o legado não marca categoria de serviço e o sync REGRAVA o `tb_category_id` do produto/serviço a cada
  envio — num estabelecimento sincronizado a categoria escolhida na web não sobrevive ao próximo envio.

**(a)** padrão AUTOMÁTICO por migration: cria "Produtos" (P) e "Serviços" (S) em cada estabelecimento SEM sincronizador que não tenha
categoria daquele tipo (vale também para o cliente novo, no onboarding); no estabelecimento COM sincronizador a categoria é do legado —
lá o lookup do serviço mostra todas as categorias (como era antes do §4.6); a validação do serviço confere o kind S só na categoria que
MUDA e só sem sincronizador (A-PR1) **(Recomendado)** · (b) o mesmo padrão automático, mas o lookup do serviço volta a mostrar TODAS as
categorias para todos (desfaz a correção de kind do §4.6 só no serviço) · (c) manual: alguém cria a categoria de serviço pela tela
Categorias e o lookup fica só kind S (na Setes, dois escritores em `tb_category`).

### 18.2 Execução da Rodada 4 (2026-10-18, mesma worktree — NADA commitado nem aplicado)

- **D-PR32**: `src/gateway/sync-write.guard.ts` montado em `/api/merchandise` (router.ts) — escrita com chave do sync ativa = 409
  `SYNC_MANAGED_CATALOG`; teste `sync-write-guard.test.ts`.
- **D-PR33**: privilégio **10 CATALOGAR** (`PRIVILEGE_CATALOGAR`) exigido nas 3 rotas de criação na central; seed 66 cria o privilégio + os
  5 pares da tela (V/I/A/E + CATALOGAR) com conferência que FALHA ALTO se o id 10 não for o CATALOGAR (a tela Privilégios do Super cunha
  por MAX+1) — prova `scripts/prove-seed-66-merchandise.ts` (10/10, inclusive o caso que falha).
- **D-PR40**: a ficha lê TODOS os níveis do produto numa leitura travante e recusa trocar a unidade da base com outro nível vivo; a sub-rota
  recusa se algum nível EXISTENTE fica (409 `TRADE_UNIT_BASE_LOCKED`). Limite registrado: a ficha agora trava a faixa dos níveis do
  produto (antes o registro do nível 1) — sem ciclo novo com o faturamento.
- **D-PR37**: `PADROES_BANCO.md` §3.1 (v2.0) + itens no checklist da `revisar-ddl`; varredura do setes-api = 1 exceção registrada.
- **Pedido ao grupo do sync — RESPONDIDO** (`setes-sync/verificacao-comissao-margem-mercadoria.md` §8; Q-SY8…Q-SY11 com o Valdo lá):
  D-PR37 — o setes-sync de produção não apaga fisicamente e grava `tb_merchandise` por LISTA de colunas (a 071 sem risco de 1451); o
  sincronizador não escreve no MySQL; ⚠️ um script de reset e os smokes do sync apagam fisicamente (decisão do grupo dele). D-PR39 — hoje a
  medida é deduplicada pela DESCRIÇÃO no sync; seguir a abreviação exige mudança lá (inclusive adotar a MESMA trava nomeada da regra 11).
  D-PR35 — o legado manda ≤ 5; alargar para 6 não quebra o sync. Q-PR38' — ver §18.1.
- Gates do delta: socrático **0,74 ✅** (o achado HIGH é DECISÃO → Q-PR41; corrigidos: conferência que falha alto no seed, Swagger da
  ficha sem a saída que a D-PR40 tornou impossível, teste que prova CATALOGAR em `merchandise`) · adversarial **0,80 ✅** (sem HIGH;
  guarda provada pelo app real com supertest — admin/super barrados, URL com caixa/barra final, PATCH/PURGE, sem override de método;
  CATALOGAR de outra interface não vale; o MEDIUM ADV3-01 — a ficha revivia/criava a base em OUTRA unidade quando a linha do nível 1
  estava excluída ou ausente com nível vivo — CORRIGIDO: compara com a unidade gravada, viva ou não; sem base + nível vivo = 409; provado
  no banco descartável). Limites: a sub-rota com a tela velha desfaz a troca de base da ficha (estado coerente; última gravação vence);
  deadlock sub-rota × ficha de produto vizinho SEM base absorvido pelo retry; o app só sabe do "só consulta" ao salvar (sinal no GET/sessão
  → onda do app).
- **Seed renumerado de novo: 66** (o 65 do repo `sql` é o da tela `institution-interfaces` — D-PV11, outra sessão). Conferir o número de
  NOVO antes da janela.

**Checklist do MERGE com as frentes de privilégios** (os dois branches estão em worktrees de outras sessões; quem mergear por último
reconcilia):
- `privilegios-crud` (D-PV2 — `gatedModule`): `router.ts` conflita (linhas vizinhas); a montagem vira
  `router.use('/merchandise', syncWriteGuard, ...gatedModule('merchandise', merchandiseRoutes))` (decidir a ordem: hoje o 409 do sync sai
  antes do 403 do privilégio e conta a quem não tem privilégio que o estabelecimento tem sincronizador); as 3 rotas de criação trocam o
  `requirePrivilege` por `privilegeAct(PRIVILEGE_CATALOGAR)` (os dois juntos exigiriam INSERIR **e** CATALOGAR); os testes dela que mudam:
  `strays`, "as 25 telas" → 26, a lista fechada dos POST que valem INSERIR (+ `merchandise /`) e "todo privilégio 1..9" → 1..10.
- `privilegios-catalogo` (D-PV9 — lista única dos pares): `'CATALOGAR'` em `PrivilegeName`/`PRIVILEGE_ID`, a entrada
  `{ interface: 'merchandise', privilege: 'CATALOGAR', consumers: ['api'] }` (+ `'app'` quando a tela usar `can('CATALOGAR')`), o par CRUD
  de `merchandise` quando a D-PV2 entrar, e o boot test lendo os seeds 64 **e** 66.

## 19. Questões — Rodada 5 (abertas em 2026-10-18 pelo gate socrático do delta da Rodada 4 — aguardam o Valdo)

**Q-PR38'** — a categoria de serviço: ver §18.1 (padrão automático por migration nos estabelecimentos SEM sincronizador; na Setes a
categoria é do legado) **(Rec. (a))**.

**Q-PR41 — A guarda do sincronizador (D-PR32) vale também para `/api/services`?** O serviço cunha o id no MESMO espaço de `tb_product`
(`@shared/product-id`) e a D-PR14 cobre os dois; hoje a Setes (sync ativo, `services` contratada) segue com dois escritores em
`tb_product` — o id MAX+1 da web pode cair no próximo código do legado. Mas a trilha do primeiro cliente (P1) cria serviço na Setes pela
API. **(a)** estender a guarda ao `services`; a trilha P1 roda num estabelecimento sem sincronizador (ou vira PENDENTE na Setes) — junto
com a Q-PR38' **(Recomendado)** · (b) manter só no `merchandise` e registrar o limite (serviço criado na web da Setes cunha id no espaço do
legado) · (c) faixa de id própria da web (desenho novo).

**Q-PR42 — A trava da D-PR40 olha também preço, estoque e pedido aberto?** Sem outro nível, trocar a unidade-base ainda muda em silêncio
o sentido de "R$ 10 por UN" (preço da grade), do saldo e dos itens de pedido aberto — todos medidos na base. **(a)** recusar também quando
há preço vivo, saldo ou item de pedido ABERTO (o histórico faturado guarda o congelado da NE-6) **(Recomendado)** · (b) aceitar com
confirmação explícita no corpo (a opção (c) da Q-PR40) · (c) manter só os níveis.

**Q-PR43 — Como o estabelecimento SAI do sincronizador?** A guarda da D-PR32 só tem ida: o setes-api emite a chave mas não a desativa.
**(a)** ato do Super no cadastro de Institutions ("desligar o sincronizador", com motivo e item no roteiro de implantação) **(Recomendado)**
· (b) segue por SQL documentado.

**Q-PR44 — Quem escreve nível, GTIN e unidade tributável de um cliente SINCRONIZADO que vai emitir NF-e pela nfe-api?** A web está
bloqueada para ele (D-PR32) e o legado não conhece `tb_merchandise_trade_unit`. **(a)** o grupo do sync passa a enviar os níveis
(contrato §12 itens 1–4, já pedido) e a web segue só consulta **(Recomendado)** · (b) liberar na web SÓ a sub-rota de unidades para
cliente sincronizado (o legado não escreve ali) · (c) o cliente sincronizado só emite NF-e depois de sair do legado.

### 19.1 Respostas do Valdo à Rodada 5 (2026-10-18) — o que entrou e o que ficou

Respostas literais: *"Q-PR41 - Cria serviço na Setes ou em qualquer outro cliente que possua serviço · Q-PR42 - de que trava está falando,
elabore melhor · Q-PR43 - só criar uma opção para desativar · Q-PR44 - de que níveis está falando — O GTIN com qualquer outro campo ou vem
do sincronizador ou será digitado no cadastro de mercadoria. Cliente sincronizado com NF-e emitida pelo legado desktop, que ainda estará
ativo. Esse mesmo cliente poderá emitir nota pela web desde que seja uma série diferente, para não ter problemas com numeração. Se a web
estiver bloqueada para um cliente, por que a preocupação com o que quer que seja? Reanalise e pergunte se precisar."*

- **D-PR41** (= Q-PR41 (b)) — EXECUTADA: o cadastro web de serviços cria serviço em QUALQUER cliente, inclusive o sincronizado; a guarda
  da D-PR32 fica só no `merchandise`. Consequência executada: o lookup de categorias do serviço segue o MODO do estabelecimento (com
  sincronizador → categorias kind S **e** P — as do legado são todas 'P'; sem → só S) pela peça nova `@shared/sync-key`
  (`hasActiveSyncKey`, também usada pela guarda). Conferência pedida ao grupo do sync: como o `tb_product.id` do legado é atribuído e se
  um serviço criado na web (id MAX+1, mesmo espaço da mercadoria) pode colidir com um produto do legado.
- **D-PR43** (= Q-PR43 (a), "só uma opção") — EXECUTADA na API: `PUT /api/institutions/:id/sync-api-key/active` `{ active: 'S' | 'N' }`
  (só o super — o roteador de institutions tem `superGuard`): desliga a chave VIVA (nunca apaga — §3.1), religar devolve a MESMA chave, o ato
  vai ao log com o autor. O botão na tela de Institutions do app entra com a onda do app. Conferência pedida ao grupo do sync: o setes-sync
  recusa a chave com `active = 'N'`?
- **D-PR44** (= Q-PR44 (a), pela resposta): "níveis" = as UNIDADES DE VENDA do produto (`tb_merchandise_trade_unit` — nível 1 = a unidade
  base, ex. UN; nível 2 = "CX com 12" com GTIN-14 próprio; daí saem uCom/cEAN, uTrib/cEANTrib e qTrib da NF-e). Regra do Valdo: o GTIN e
  qualquer outro campo do produto **ou vêm do sincronizador ou são digitados no cadastro de mercadoria** — no cliente sincronizado a web é
  só consulta (D-PR32), então o que a NF-e da web precisar (níveis, GTIN da caixa, unidade tributável) chega pelo SYNC (contrato §12 itens
  1–4, já pedido ao grupo do sync). **Fato novo para a nfe-api** (registrado aqui; o prompt da nfe-api é da outra sessão): o cliente
  sincronizado continua emitindo NF-e pelo legado desktop E pode emitir pela web numa **SÉRIE DIFERENTE** (a numeração não se cruza — D-F21:
  série/número do 55/65 no ERP). A "preocupação" da Q-PR44 era exatamente esse caso: a web do cliente sincronizado é só consulta, mas a
  emissão pela web LÊ os dados de produto dela — que, então, só podem vir do sincronizador.
- **Q-PR42 → Q-PR42'** (reformulada, aguarda): ver abaixo.
- **Q-PR38'** (aguarda a parte que sobrou): o lookup por modo foi executado (D-PR41); falta decidir o padrão automático "Produtos"/"Serviços"
  para o estabelecimento SEM sincronizador.

**Q-PR42' — a trava da unidade-base (explicação).** A "trava" é a regra D-PR40, executada hoje: a API **recusa trocar a unidade-BASE**
de um produto quando ele tem OUTRO nível vivo. Exemplo: Parafuso com base **UN** e o nível "CX com 12" — o 12 da caixa é contado em UN;
se alguém trocasse a base para **KG**, a caixa passaria a significar "12 KG" sem ninguém decidir, e a NF-e mandaria quantidade e unidade
erradas. A pergunta é se a mesma recusa vale quando o produto **NÃO** tem outro nível mas já tem **preço** ou **item em pedido aberto**
(estoque web ainda não existe): o Parafuso com base UN, preço R$ 0,50 e um pedido aberto de 200 — trocar a base para CX deixa os
números iguais e o SENTIDO trocado (R$ 0,50 **por CX**, pedido de 200 **CX**). **(a)** recusar a troca também com preço vivo ou item de
pedido ABERTO (o faturado guarda o congelado da NE-6) **(Recomendado)** · (b) aceitar com uma confirmação explícita no corpo da requisição
· (c) manter a trava só com outros níveis (como está).

### 19.2 Fatos do grupo do sync e gates do delta da Rodada 5 (2026-10-18) — questões novas

**Respostas do grupo do sync** (`setes-sync/verificacao-comissao-margem-mercadoria.md` §9, só leitura):
- **O `tb_product.id` do que vem do legado é o PRÓPRIO `PRO_CODIGO`** (sem remapeamento) e o setes-sync faz upsert pela PK. Um produto ou
  serviço criado na web num cliente com sincronizador ocupa um id que o gerador do legado (`GN_PRODUTO`) ainda vai alcançar — quando
  alcançar, o envio SOBRESCREVE a linha da web (kind, código, descrição, categoria, preço) **sem erro e sem aviso**. Na Setes: ids 1–15
  vieram do legado; 16–79 nasceram na web e nos ensaios — o risco já existe HOJE no `main` (o cadastro de serviços cria assim), não nasce
  nesta worktree; a D-PR41 o mantém e a tela volta a oferecer o "Novo serviço" na Setes. O grupo do sync abriu a **Q-SY12** (recomendado:
  FAIXA de id própria para o que nasce na web em cliente com sincronizador — a peça `@shared/product-id` calcula o MAX+1 dentro da faixa — e
  o setes-sync recusa, sem sobrescrever, produto do legado com id dessa faixa).
- **Chave desligada**: o setes-sync recusa com 401 (em até 5 min — cache dele), mas o sincronizador ESTACIONA cada registro do ciclo e
  religar não reenvia sozinho (UPDATE do roteiro no Firebird) → **Q-SY13** (recomendado: código próprio de chave inativa e o sincronizador
  PARA o ciclo sem marcar os registros).

**Gates do delta** (D-PR41/D-PR43 + `@shared/sync-key`): socrático **0,72 ✅** · adversarial **0,78 ✅** (16 ataques pelo app real —
`adversarial-sync-switch-gate.test.ts`: só o super chega; corpo só S/N; nunca apaga nem revive; religar devolve a MESMA chave; desligar
libera a guarda do merchandise NA HORA). O HIGH dos dois é o fato acima (decisão). Corrigido na sessão: os comentários que prometiam mais
do que acontece (5 min, reenvio manual) e o 404 "sem chave" com código de catálogo (`SYNC_KEY_MISSING`).

**Q-PR45 — Até a Q-SY12 ser decidida, o "Novo serviço" na Setes?** **(a)** não usar o "Novo serviço" na Setes nem rodar a trilha P1
nela (o que a web criar ali pode ser engolido pelo legado) **(Recomendado)** · (b) aceitar o risco (dev = ensaio).

**Q-PR46 — Os 5 min do cache do setes-sync ao desligar.** **(a)** procedimento: parar o sincronizador do cliente ANTES de desligar a chave
(a resposta do PUT avisa) **(Recomendado)** · (b) a guarda do merchandise segue travada até 5 min depois do desligamento · (c) limite
conhecido.

**Q-PR47 — Religar depois que a web escreveu no período.** **(a)** religar recusa (409) quando nasceu linha na web desde o desligamento
(o legado sobrescreveria — mesma causa da Q-SY12) **(Recomendado)** · (b) permitir com item no roteiro (inclui limpar o SRC_LOG — Q-SY13)
· (c) permitir.

**Q-PR48 — Registro do ato de ligar/desligar.** **(a)** basta a linha do log com o autor (a decisão foi "só uma opção") **(Recomendado)**
· (b) fato próprio no banco com autor, data e motivo.

**Q-PR49 — A regra do lookup do serviço: pelo MODO (tem chave) ou pelo FATO (existe categoria S viva)?** Pelo modo (executado), o
sincronizado continua vendo categoria P mesmo quando o legado passar a separar S (D-SY11 do grupo do sync), e desligar a chave esvazia a
lista. **(a)** pelo FATO: o lookup mostra só as categorias S quando existe pelo menos uma S viva; senão mostra todas — e o padrão
automático da Q-PR38' cria "Serviços" também no ATO de desligar a chave **(Recomendado)** · (b) manter pelo modo.

## Decisões arquiteturais registradas

### Rodada 1 — parcial (Valdo, 2026-10-17)

- **D-PR1 (Q-PR1 — DIVERGIU da recomendação)**: a **unidade de venda** (GTIN, embalagem, medida, unidade tributável) **ENTRA na onda 1**.
  Consequência: a casa física da unidade de venda precisa ser decidida AGORA (Q-PR15). ~~A onda 1 passa a depender da resposta do grupo
  do sync se a casa for peça nova~~ — **corrigido pelo guardião (§12)**: pela D3 o cadastro web só é liberado a cliente SEM legado, então
  não há dois escritores; o pedido ao grupo do sync só é obrigatório antes de um cliente SINCRONIZADO emitir pela nfe-api.
- **D-PR2 (Q-PR2 = (a))**: usar as MESMAS técnicas — peças `@shared/product-id` (id de `tb_product` pela regra 7 do PADROES §9 +
  `withDeadlockRetry`, provado por script) e `@shared/price` (executa a D4 do serviço); o módulo `services` migra para as duas. Fato
  corrigido pelo Valdo: **o cadastro de serviços não está em produção** (o registro anterior desta frente dizia "módulo services vivo").
- **D-PR3 (Q-PR3 = (a))**: módulo/URL/pasta **`merchandise`** — o nome da tabela no banco (`/api/merchandise` ↔ `/home/merchandise`,
  i18n `forms.merchandise.*`); rótulo da tela "Produtos" / "Products" (D6 do serviço).
- **Q-PR12 → frente de desenho**: o Valdo pediu ajuda para criar uma estrutura em que **matriz e filiais compartilhem produtos** (§11).
- **Pedido do Valdo (mesma rodada)**: analisar o `Un_Produtos.pas` aba a aba, comparar com a quebra da `TB_PRODUTO` do Firebird em
  `tb_product` × `tb_merchandise` × `tb_stock`, e **reorganizar as 14 abas** — poucas abas na ficha e as demais como TELAS VINCULADAS ao
  produto, mais fáceis de trabalhar; todas no plano, mesmo as que não forem feitas agora (§10).

### Rodada 2 — FECHADA (Valdo, 2026-10-17: "siga as recomendações nas Q-PR15 a Q-PR27 e nas abertas da Rodada 1")

Numeração: **D-PRn = Q-PRn** (a opção recomendada de cada questão).

*Abertas da Rodada 1:*
- **D-PR4**: tipos P (acabado) e M (matéria-prima) selecionáveis no form; os tipos C/A do legado e a regra P07 (matéria-prima não fatura)
  ficam para a frente de Produção.
- **D-PR5**: marca OBRIGATÓRIA, com "criar na hora" pelo molde `@shared/payment-types` (peça `@shared/brand`: dedupe por descrição dentro
  da transação na central + vínculo `tb_institution_has_brand`; descrição imutável).
- **D-PR6**: a onda 1 valida só a FORMA do NCM (8 dígitos) e do CEST (7); a carga do catálogo vira peça própria que SEPARA nomenclatura NCM
  (Siscomex, com vigência) × carga aproximada do IBPT (por UF) × CEST (Convênio ICMS 142/2018) — não é pré-requisito da onda 1.
- **D-PR7**: `identifier` ÚNICO por institution entre P/M/S (vivos); o 409 devolve o id do produto que já o tem (modelo customers). Dev
  conferido em 2026-10-17: zero duplicidade viva. Aplicação: ver A-PR1 (§17).
- **D-PR8**: o `identifier` segue editável; a **NE-6 congela o cProd por item** — item de contrato para a NE-6 (§16.6).
- **D-PR9**: comissão (`tb_price.aliq_kickback`) na grade de preço de PRODUTOS **e** de SERVIÇOS (o consumidor `@shared/commission` já
  existe para os dois). Depende do veredito da D-PR26 sobre o que o sync grava na mesma coluna. → Veredito (D-SY1, 2026-10-17): o sync
  grava a comissão na mesma coluna, sem inversão. Pendência que fica: a FÓRMULA (o legado combina vendedor + item; o `@shared/commission`
  substitui pela alíquota do produto) é da frente de comissão (D-SY4) e trava a correção do flag do vendedor sincronizado (D-SY3).
- **D-PR10**: indEscala + CNPJFab entram JUNTOS, com o consumidor (NE-4/NE-6); a onda 1 não expõe. O CNPJFab é do fabricante da
  MERCADORIA, nunca da `tb_brand` (catálogo compartilhado ENTRE clientes — achado 0.12).
- **D-PR11**: excluir = soft delete livre (`deleted='S'`), igual ao serviço; o item já vendido segue pelo id e pelos snapshots.
- **D-PR13**: o NCM parcial aceito no dto de tax-rules (2–8 dígitos × D36) vira TAREFA PRÓPRIA, fora desta frente.
  **EXECUTADA 2026-10-17 nesta sessão (Valdo: "faça esta tarefa aqui") em worktrees `D:\Gestao2027\taxrules-ncm\{setes-api,setes-app}`
  (branch `taxrules-ncm`, a partir de `main` f53a618 / 2f621c1) — NADA commitado.** Medição antes (só SELECT, 2026-10-17): `setes_setes`
  = 2 regras vivas + 7 excluídas, TODAS com NCM vazio (coringa) — zero NCM parcial, nenhuma decisão de dado pendente. Mudança: peça
  `isNcm` (exatamente 8 dígitos ASCII, sem canonizar) em `@shared/validation` + espelho `SetesValidators.isNcm`/`.ncm()` no
  `setes_validators` — 1º consumidor o seletor da regra, o cadastro de produtos reusa na onda 1 (D-PR6); DTO `selector.ncm` = coringa
  (null) OU `isNcm` (400 `VALIDATION_FAILED` com `fields[{field:'selector.ncm'}]`); Swagger do POST; app: as DUAS validações da tela
  (campo + pendência) pela peça, mensagens pt/en "8 dígitos" + chave `forms.validation.ncm`. **Fora de propósito**: o critério `ncm` da
  Pesquisa Avançada de tax-rules segue "contém" — é CONSULTA, não fato gravado (achar regras por pedaço do NCM é legítimo). Prova: API
  tax-rules 32/32 (casos: 2/6/7/9 dígitos, máscara, letra, vazio recusados; null/omitido aceitos; o campo do 400) · suíte completa
  124/127 suítes, **0 teste falhando** (as 3 que não sobem são gates ao vivo da F2a que leem o `.env` da raiz — ambiente da worktree,
  sem relação) · cerca D-CJ12 verde · `tsc` limpo · `setes_validators` 93/93 · app 631/631 (+28 pulados) · `flutter analyze` limpo.
  **Gates (proporcionais ao delta)**: socrático **0,86** — multi-tenant/transação/concorrência sem objeto; ponto aberto: regra antiga com
  NCM parcial (se um dia vier por outro escritor) passa a receber 400 no PUT até completar o NCM — comportamento desejado (o parcial nunca
  casou), âncora no campo existe · adversarial **0,88**, sem HIGH/CRITICAL — bordas executadas nos dois lados (espaço nas pontas, dígito de
  largura total, `\n`), o app manda `null` quando vazio (não muda). Ambiente: a worktree precisou de junções só-leitura para
  `nfse-api`/`fiscal-api` (cercas que leem o irmão) e `FISCAL_API_DIR` para o vetor da `federal-id`. ⚠️ No commit, NÃO incluir os
  `.dart_tool/*` que o `flutter pub get` da worktree alterou (rastreados por engano — memória "setes-app build/ versionado").
- **D-PR14**: a D3 (cadastro web só para cliente sem legado) vira ITEM VERIFICÁVEL no roteiro de implantação web: contratar `services` e
  `merchandise` só para institution sem `tb_sync_api_key` ativa (item 7 do §10.3 do `prompt_cancelamento_nota.md`).

*Rodada 2:*
- **D-PR15**: unidade de venda na peça nova **`tb_merchandise_trade_unit`** (níveis) + 2 designações em `tb_merchandise` (§12).
- **D-PR16**: unidade tributável = designação de NÍVEL no produto + fator no nível; NULL = a unidade vendida (fallback do legado).
- **D-PR17**: só GTIN na onda 1; código de barras próprio (cBarra) e código de balança/PLU nascem com PDV/balança ou com a NE-4.
- **D-PR18**: embalagem no nível OPCIONAL e descritiva (sem consumidor fiscal); ausente = NULL — **nunca** a sentinela "NÃO INFORMADO"
  do catálogo central (dev: `tb_package` id 1, que existe só pelo NOT NULL da `tb_stock`).
- **D-PR19**: GTIN ÚNICO entre os níveis vivos do catálogo; 409 devolve o produto que já o tem.
- **D-PR20** (= desenho da Q-PR12): matriz × filiais = **frente PRÓPRIA transversal** com a saída (ii) — o grupo É o schema; chave do
  catálogo = institution fundadora, gravada uma vez (§11).
- **D-PR21**: o grupo é definido por DECISÃO COMERCIAL (o contrato = o schema) — nunca pela raiz do CNPJ.
- **D-PR22**: origem e finalidade são do BEM (compartilhadas no grupo, como no legado); a divergência de uma filial vive na REGRA dela.
  ⚠️ **Condição embutida (vira item de verificação da frente do grupo, não da onda 1)**: confirmar com o contador as origens 1×2 e 6×7
  (dependem de quem importou) ANTES de a 1ª filial compartilhar o catálogo.
- **D-PR23**: preço no grupo = tabelas do catálogo + vínculo da filial com as tabelas que usa (frente do grupo).
- **D-PR24**: ponto de costura da onda 1 = só as 4 regras de alocação do §11; a peça "chave do catálogo" nasce com a frente do grupo.
  **+ 5ª regra (D-GE2 da frente do grupo, 2026-10-18)**: a tabela é do GRUPO ou do ESTABELECIMENTO, nunca das duas (`PADROES_BANCO.md` §12);
  a peça do grupo se chama `@shared/group` (`groupInstitutionId`).
- **D-PR25**: padrão de tela = ficha de 3 abas + painel de cartões; vinculada B por sub-rota do módulo; vinculada C por rota da interface
  de destino com `?criteria=` (Pesquisa Avançada do destino) + `returnTo` (§10.5) — entra no `setes-app/ARQUITETURA_MODULOS.md`.
- **D-PR26**: a inversão comissão × margem do mapeamento de 2013 é TAREFA URGENTE do grupo do sync (conferência + script de reparo) —
  cartão de sessão própria "Conferir inversão comissão × margem no setes-sync" (só leitura; correção com o Valdo). **EXECUTADA 2026-10-17**:
  não procede no sync atual; o defeito real é o flag `kickback_product` (§13, item 0.2). **ENCERRADA sem script de reparo** (D-SY1 do
  grupo do sync, Valdo 2026-10-17 — `Infra-IA/setes-sync/verificacao-comissao-margem-mercadoria.md` §7).
- **D-PR27**: na ficha só "ativo"; publicado/promoção/destaque NASCEM COM O CONSUMIDOR. Assimetria registrada: o cadastro de serviços
  continua expondo os quatro (D2 dele não foi reaberta). Semântica e default de `published` → Q-PR29 (§17) → **D-PR29**.

### Rodada 3 — FECHADA (Valdo, 2026-10-18: "siga as recomendações … A-PR1, Q-PR28 a Q-PR31 de produtos")

- **A-PR1 CONFIRMADA**: a unicidade do `identifier` (D-PR7) e do GTIN (D-PR19) é conferida só quando o valor NASCE ou MUDA (precedente
  D-G34) — produto vindo do legado com duplicidade segue editável nos outros campos.
- **D-PR28**: unidade de medida e embalagem nascem "na hora" pelo MESMO molde da marca (D-PR5): dedupe dentro da transação na central —
  medida pela ABREVIAÇÃO (é o uCom/uTrib da NF-e, 1 a 6 caracteres), embalagem pela descrição — + vínculo `tb_institution_has_measure` /
  `tb_institution_has_package`; descrição imutável. O vínculo é tabela do GRUPO (chave do grupo — `PADROES_BANCO.md` §12). Dado do dev a
  corrigir à parte (fora desta frente): a medida "KILOGRAA" e a sentinela de embalagem "NÃO INFORMADO" (que a D-PR18 proíbe de usar).
- **D-PR29**: `published` = publicar na INTERNET (e-commerce, `PRO_INTERNET` do legado); default 'N' no cadastro; o lookup de pedidos NUNCA
  filtra por ele — o comentário de `orders.repository.ts:171` ("itens ativos e publicados") é corrigido na onda 1 e a "tarefa própria" do
  §7 morre.
- **D-PR30**: excluir um nível DESIGNADO (tributável ou venda padrão) é recusado com 409 apontando a designação — o usuário troca a
  designação primeiro (a NF-e nunca muda sem alguém decidir).
- **D-PR31**: dois níveis vivos do mesmo produto com a mesma unidade E o mesmo fator são recusados (409 no nível repetido); CX12 e CX24
  convivem porque o fator difere.
- **Questões pendentes da frente: NENHUMA.** A onda 1 está pronta para executar pelo §16 (pré-condições do §16.1: branch `densidade`
  mergeado no `main` do app, número da migration conferido, NE-4/NE-6 conferidas).

### Rodada 4 — DECIDIDA em parte (Valdo, 2026-10-18: "Q-PR37 - nada sera apagado fisicamente no sistema, somente sofdelete, exclusoes fisicas devem ser devidamente explicitas nas documentacoes com motivos · Q-PR38 - eu preciso criar ou cria-se no seed e aplica um padrao? · o resto segue recomendacao")

- **A-PR2 CONFIRMADA**: designação AUSENTE no `PUT /:id/trade-units` = mantém a gravada; `null` = volta ao padrão.
- **A-PR3 CONFIRMADA**: GTIN único pela identidade GS1 (forma de 14 dígitos); gravado como digitado; filtro rápido pela identidade.
- **D-PR32** (= Q-PR32 (a)) — EXECUTADA: `syncWriteGuard` no gateway (`src/gateway/sync-write.guard.ts`) — institution com
  `tb_sync_api_key` ATIVA só CONSULTA `/api/merchandise`; toda escrita (inclusive criar item na central) = 409 `SYNC_MANAGED_CATALOG`; sem
  exceção de perfil (o problema é o 2º escritor). Só no `merchandise` — o `services` da Setes segue aberto (a trilha P1 o usa; §18.1).
- **D-PR33** (= Q-PR33 (a)) — EXECUTADA: ato próprio **CATALOGAR** (privilégio **10**, `PRIVILEGE_CATALOGAR`) na interface `merchandise`
  para `POST /brands|/measures|/packages`; admin passa (D32); seed 66 cria o privilégio e o par. Na onda da D-PV2 (guarda por roteador,
  branch `privilegios-crud`) as três rotas viram `privilegeAct('merchandise', CATALOGAR)` e o par entra na lista da D-PV9 (branch
  `privilegios-catalogo`) — quem mergear por último reconcilia.
- **D-PR35** (= Q-PR35 (a)): a abreviação fica em 5 por ora; alargar para 6 (uCom) é DDL na central compartilhada → pedido ao grupo do sync.
- **D-PR36** (= Q-PR36 (a)): GTIN no filtro rápido (pela identidade GS1), fora da Pesquisa Avançada.
- **D-PR37** (Valdo — regra do SISTEMA, além da pergunta): **nada se apaga fisicamente; exclusão = soft delete; exclusão física só
  EXPLÍCITA na documentação, com o motivo** → `database/PADROES_BANCO.md` §3.1 (v2.0) + checklist da `revisar-ddl`. Varredura do
  setes-api: 1 exceção (o FCP do item no faturamento — tabela do baseline sem PK), registrada com o motivo. A FK circular da 071 FICA
  (ninguém apaga o pai fisicamente). Pedido ao grupo do sync: conferir/alinhar setes-sync e sincronizador à regra.
- **D-PR39** (= Q-PR39 (a)): medida pela ABREVIAÇÃO nos dois grupos → pedido ao grupo do sync; o setes-api já compara pela forma da D17
  (UPPER/TRIM, binário — sem colapsar acento).
- **D-PR40** (= Q-PR40 (a)) — EXECUTADA: trocar a unidade da BASE com outro nível vivo = 409 `TRADE_UNIT_BASE_LOCKED` (na ficha e na
  sub-rota; na sub-rota a troca passa se nenhum nível EXISTENTE fica — nível novo da mesma grade nasce na base nova); trocar só a
  embalagem/GTIN da base segue livre.
- **Q-PR38 → Q-PR38'** (§18.1): reformulada com os fatos (categorias da Setes vêm do legado; a trilha P1 cria serviço na Setes) — aguarda.

### Rodada 5 — DECIDIDA em parte (Valdo, 2026-10-18 — respostas no §19.1)

- **D-PR41** (Q-PR41 (b)): serviço se cria na web em QUALQUER cliente, inclusive o sincronizado; a guarda da D-PR32 só no `merchandise`;
  lookup de categorias do serviço pelo modo (`@shared/sync-key`). Risco do espaço de id em conferência com o grupo do sync.
- **D-PR43** (Q-PR43 (a)): interruptor da chave do sincronizador (`PUT /api/institutions/:id/sync-api-key/active`, super) — nunca apaga;
  botão no app com a onda do app.
- **D-PR44** (Q-PR44 (a)): no cliente sincronizado os dados de produto (GTIN, níveis, unidade tributável) vêm do SINCRONIZADOR; no cliente
  web, do cadastro. O sincronizado pode emitir NF-e pela web numa SÉRIE diferente da do legado (fato para a nfe-api).
- **Abertas**: Q-PR42' (trava da base com preço/pedido aberto) e o resto da Q-PR38' (padrão automático de categorias sem sincronizador).
- **Gates do delta da Rodada 5**: 0,72/0,78 ✅. **Abertas**: Q-PR42', o resto da Q-PR38', Q-PR45…Q-PR49 (§19.2) + Q-SY12/Q-SY13 do grupo
  do sync (que decidem a identidade do produto nascido na web e o comportamento do sincronizador com a chave desligada).

### Rodada 6 — DECIDIDA (Valdo, 2026-10-18: "Q-PR41 - aplicar mesma regra do mercadoria para o serviço... já que compartilham a mesma base de dados · Q-PR43 - ok · Q-PR44 - ok · Q-PR42 - não haverá colisão quando bloqueamos o insert de produtos e serviços, tabela de preço para chaves de sincronia ativas; criar método para utilizarmos em outros cadastros conforme apareçam outros casos; sobre pedidos temos um campo terminal para determinar se o pedido veio do sincronizador ou da internet; também teremos a sincronização de PDV, cada um recebendo um número de terminal · restante segue recomendação")

- **D-PR41 REVISTA (supera a D-PR41 da Rodada 5)**: a guarda do sincronizador (D-PR32) vale TAMBÉM para `services` e para a **tabela de
  preço** (`price-lists`) — compartilham o espaço de id de `tb_product`/o catálogo que o legado alimenta. Cliente com chave ativa só
  CONSULTA esses cadastros na web. **Método reutilizável** (`syncWriteGuard` + `@shared/sync-key`) para os próximos cadastros que o legado
  alimenta, conforme os casos aparecerem — regra na skill `setes-api/skills/novo-modulo.md`. Caso que já apareceu (gate ADV3-05): o
  cadastro de **categorias** (`tb_category` com MAX+1, mesmo problema) — entra junto pela recomendação.
- **Q-SY12 RESPONDIDA pelo Valdo** (o grupo do sync abriu): sem faixa de id — **não há colisão porque a web não INSERE produto, serviço nem
  tabela de preço em cliente com sincronizador**. Residual a confirmar: as linhas que JÁ nasceram na web na Setes (ids 16–79 de
  `tb_product`, ensaios inclusive) seguem no espaço do legado.
- **Pedidos**: sem guarda — o campo `terminal` da chave do pedido distingue a origem (sincronizador × internet) e a sincronização de PDV
  terá um número de terminal por PDV (fato registrado; não há colisão de id de pedido).
- **D-PR43 / D-PR44**: confirmadas ("ok").
- **D-PR42 (Q-PR42')**: a resposta do Valdo tratou de colisão (acima); a pergunta da trava da unidade-base com preço/pedido aberto segue
  pela recomendação **(a)** — recusar trocar a base também com preço vivo ou item de pedido ABERTO — a confirmar no relatório.
- **Pela recomendação**: Q-PR38' (a) padrão automático "Produtos"/"Serviços" (migration, só estabelecimento SEM sincronizador) · Q-PR45
  sem objeto (a guarda bloqueia o "Novo serviço" na Setes; a trilha P1 lê um serviço do legado) · Q-PR46 (a) procedimento: parar o
  sincronizador antes de desligar a chave — a resposta do PUT avisa · Q-PR47 (a) religar recusa (409) se nasceu linha na web desde o
  desligamento · Q-PR48 (a) basta o log com o autor · Q-PR49 (a) lookup do serviço pelo FATO (só S quando existe categoria S viva) +
  "Serviços" criada também no ATO de desligar a chave · Q-SY13 (a) é do grupo do sync (em execução lá).
- Execução: sessão própria (contexto desta sessão alto — pedido do Valdo).


### Rodada 6 — execução (2026-10-18, mesma worktree `merchandise/{setes-api,sql}` — NADA commitado nem aplicado ao banco)

Sessão própria (pedido do Valdo). O que entrou, item a item:

1. **D-PR41 revista — o MÉTODO da guarda**: `syncWriteGuard` montado também em `/api/services`, `/api/price-lists` e `/api/categories`
   (`src/gateway/router.ts` — os quatro cadastros cujas tabelas são **ID LOCAL** no `setes-sync/MAPA_INDEXACAO.md`: `tb_product`,
   `tb_price_list`, `tb_category`). Leitura passa; toda escrita com chave ativa = 409 `SYNC_MANAGED_CATALOG` (admin e super). A tabela de
   cada cadastro guardado entra em `SYNC_FED_TABLES` (`@shared/sync-key`) — é a lista que o religar confere. Regra reutilizável na skill
   `setes-api/skills/novo-modulo.md` (Passo 3 + checklist). Swagger dos três módulos com o 409.
2. **Lookup/validação do serviço pelo FATO** (Q-PR49 (a)): peça NOVA `@shared/category-kind` — `serviceCategorySql` = predicado ÚNICO
   "kind S, ou kind P quando o estabelecimento não tem S viva"; o lookup `GET /api/services/categories` e o save do serviço (categoria que
   NASCE ou MUDA — A-PR1; 400 `fields[categoryId]`) usam o MESMO texto (catálogo servido = catálogo aceito). `hasActiveSyncKey` saiu do
   `services` (o modo não decide mais nada ali).
3. **Categorias padrão** (Q-PR38' (a)): migration **072** `072_default_categories.sql` (número livre no `main` e em TODAS as worktrees em
   2026-10-18; a 071 é desta frente) — "Produtos" (P) e "Serviços" (S), raiz, `posit_level` = id em 3 dígitos (acima de 999 inteiro — o
   `LPAD` truncaria), id MAX+1 contando excluídas, em cada estabelecimento do schema (`tb_institution.schema_name = DATABASE()`) SEM chave
   ativa que não tenha categoria viva daquele kind; idempotente. **No dev não cria nada** (só a Setes existe, com chave ativa). Espelho no
   repo `sql`: comentário no `03_schema_cliente_ddl.sql` (o canônico não carrega dado). No ATO de desligar a chave, `ensureDefaultCategory`
   cria "Serviços" se não houver S viva (mesmas descrições — `DEFAULT_CATEGORY_DESCRIPTION`).
4. **Ligar/desligar a chave** (`switchSyncApiKeyTx`, UMA transação: trava da institution 1º → chaves `FOR UPDATE`; estado igual = nada
   muda — repetir o 'N' não empurra o instante do desligamento): **desligar** (Q-PR46 (a)) responde `notice` ("pare o sincronizador ANTES;
   o setes-sync aceita a chave por até 5 min") + `defaultServiceCategoryId`; o instante T é um `NOW()` lido uma vez — a categoria do ato
   nasce em T−1 s e a chave grava `updated_at` = T. **Religar** (Q-PR47 (a)) recusa 409 **`SYNC_KEY_WEB_ROWS`** (código novo) quando nasceu
   linha (inclusive excluída — o id fica ocupado) em `tb_product`/`tb_price_list`/`tb_category` com `created_at >= T` (inclusivo: DATETIME
   de segundo); a resposta diz contagem e até 20 ids por tabela; o log leva autor e contagens (Q-PR48 (a)).
5. **Trilha** (`scripts/trilha-primeiro-cliente.ts`, P1): com chave ativa a régua NÃO cria — usa um serviço vivo e ativo com regra de ISS
   ativa (prefere a regra da régua; menor id = os do legado) e reporta OK "serviço do legado (D-PR41)"; sem nenhum = PENDENTE. Conferido
   só por leitura no dev: escolheria o serviço **1** (legado, regra 2 — a MESMA regra que a P6 já fatura; sem NBS/IBS/CBS) — P3…P8 seguem
   iguais. Sem chave, o ramo web prefere a categoria kind S (o save novo recusaria a P quando houver S). A trilha NÃO foi rodada (cria dados
   em `setes_setes` e exigiria subir a API da worktree, que aplicaria 071/072 no banco de dev).
6. **D-PR42** (= Q-PR42' (a), confirmar no relatório): `assertBaseUnitFree` — trocar a unidade-base também = 409 `TRADE_UNIT_BASE_LOCKED`
   com PREÇO gravado vivo em `tb_price` ou item vivo em pedido ABERTO (`tb_order.status = 'A'`, vivo, terminal casado) — na ficha e na
   sub-rota; a D-PR40 (outro nível vivo) decide antes; trocar só embalagem/GTIN segue livre (nem consulta).
7. **Provas**: `scripts/prove-072-default-categories.ts` **20/20** em schema descartável (a 072 tal como está contra o `setes_central` REAL
   — sintaxe/collation do `DATABASE()` — sem criar nada; depois com as tabelas da central trocadas por cópias: 8 estabelecimentos fictícios,
   cada caso da regra, duas passadas; `ensureDefaultCategory`, `serviceCategorySql` e `webBornSince` com as funções reais). Testes:
   `adversarial-sync-guard-r6` (7, app real), `sync-key-switch` reescrito (9), `adversarial-sync-switch-gate` (modelo da transação; o ACHADO
   MEDIUM do lookup esvaziado virou CORRIGIDO), `services` (+3), `adversarial-merchandise-r3-dpr40` (+5 D-PR42), `sync-write-guard` (+2:
   o roteador monta a guarda em exatamente 4 cadastros). tsc limpo. Suíte completa (depois das correções dos gates): **138/141 suítes,
   2.112 testes, 0 falhando** (as 3 que não sobem são gates ao vivo da F2a sem `.env` na worktree — ambiente; suítes antigas de serviço com
   mock sequencial foram ajustadas à consulta nova da categoria e à reconferência da chave). Gates: ver "Rodada 6 — gates" logo abaixo.

**Limites registrados (Rodada 6)**:
- ~~A guarda lê a chave FORA da transação do escritor: uma escrita que passou pela guarda com a chave desligada e comita DEPOIS do religar
  escapa da conferência (milissegundos; ato raro, do super).~~ — o gate socrático mostrou que a janela é o ato inteiro; FECHADO pela
  reconferência `assertNoActiveSyncKey` depois da trava da institution nos três cunhadores (ver "Rodada 6 — gates"). Edição de linha
  existente não é reconferida (não cunha id).
- Falso positivo do religar: o que o setes-sync gravar nos ~5 min de cache depois do desligamento conta como "nascido na web" e impede
  religar — por isso o aviso (parar o sincronizador ANTES). Não há como distinguir a linha do sync da linha da web (nenhuma marca de origem).
- Edição feita na web, no período desligado, numa linha QUE VEIO do legado não bloqueia o religar — o próximo envio do legado a sobrescreve
  (a origem manda — D-SY11).
- D-PR42 lê o preço GRAVADO (o da própria requisição não conta) e o item de pedido não trava o produto (um item que nasce no mesmo instante
  escapa). Produto SEM linha de base (do legado, antes da 071) não tem base a "trocar": a ficha cria a base sem a D-PR42.
- A 072 olha todos os estabelecimentos do schema (hoje `schema_name` é UNIQUE = 1 por schema); na frente do GRUPO a categoria é tabela do
  grupo (PADROES §12) e a regra passa a olhar só a fundadora.

**Riscos residuais e questões para o Valdo** (Rodada 7 — aguardam):
- **As linhas que JÁ nasceram na web na Setes seguem no espaço de id do legado**: `tb_product` ids **16–79** (64 linhas — serviços da trilha
  e ensaios) e `tb_price_list` ids **3–4** (excluídas). A guarda impede NOVAS; quando o gerador do legado (`GN_PRODUTO`/da tabela de preço)
  alcançar esses números, o envio sobrescreve a linha da web sem aviso (inclusive revivendo a excluída). → **Q-PR50**: (a) aceitar e
  registrar (dev = ensaio; nada em produção) **(Recomendado)** · (b) soft-deletar os ensaios antes da janela (não libera o id) · (c) pedir ao
  grupo do sync para o legado pular essa faixa.
- **Pedidos — a premissa do terminal não vale hoje** (grupo do sync, nota de 2026-10-18 — Q-SY14): os 7.949 pedidos do `setes_setes` estão
  todos no terminal 0 e o setes-api grava/lê pedido com terminal 0 fixo (`src/shared/order/order.ts`), o mesmo do servidor local do
  sincronizador; legado até ~6.531, web 6.532–8.013 ⇒ o próximo NFL_CODIGO do legado cai em cima de um pedido da web (pedido, nota e
  itens). O mesmo vale para os outros cunhadores por MAX+1 de `tb_order` (OS, devolução, cheque/baixa) e para o caixa. → Q-SY14 (com o grupo
  do sync) — fora desta frente.
- **Outros cadastros ID LOCAL que a web cunha por MAX+1**: `tb_financial_plans` (módulo `financial-plans`) e `tb_bank_account` (módulo
  `bank-accounts`) — mesmo problema dos quatro guardados. → **Q-PR51**: (a) montar o `syncWriteGuard` nos dois (o método) **(Recomendado)** · (b)
  deixar para quando aparecerem como caso.
- **Confirmar a D-PR42** (a resposta do Valdo à Q-PR42' tratou de colisão; a trava com preço/pedido aberto entrou pela recomendação (a)).

### Rodada 6 — gates (2026-10-18)

- **Socrático, 1ª passada: 0,62 ✗** (abaixo de 0,70 → retrabalho). Corrigido NA SESSÃO (sem decisão do Valdo):
  1. **MEDIUM — corrida religar × escrita**: a janela não era de milissegundos — quem cria produto passa pela guarda e ESPERA a trava da
     institution que o ato de religar segura (o ato inteiro), inserindo depois com a chave já ativa numa linha que nenhuma conferência futura
     vê. Peça nova `assertNoActiveSyncKey` (`@shared/sync-key`, leitura TRAVANTE compartilhada — lê o último comitado; ordem institution →
     chaves = a do ato, sem ciclo) chamada LOGO DEPOIS da trava da institution nos três cunhadores: `allocateProductId` (serviço e
     mercadoria), `insertCategory` e `insertPriceList` — os dois últimos passaram a cumprir a regra 7 do PADROES §9 (trava da institution
     1º; antes só `MAX … FOR UPDATE`). Regra (4) na skill `novo-modulo`.
  2. LOW — a D-PR42 contava preço de tabela EXCLUÍDA (grade vazia na tela e 409 "tem preço") → só tabela viva.
  3. LOW — a trilha mandava "enquadrar pelo legado" (o legado NÃO escreve `tb_service`) → frase verdadeira, aponta a Q-PR52.
  4. LOW — o ato de ligar/desligar cunha id de categoria sem retry de deadlock → `withDeadlockRetry` (3; o ato é idempotente).
  5. LOW — 400 da categoria do serviço sem código → `CATEGORY_NOT_FOR_SERVICE` no catálogo.
  Testes das correções: `sync-write-guard` (reconferência nos 3 cunhadores), `services` (price-list 409 com chave religada),
  `sync-key-switch` (retry), `adversarial-merchandise-r3-dpr40` (tabela viva).
  **Re-score socrático: 0,74 ✅** ("nada objetivamente quebrado"; a reconferência segue a ordem do ato — institution → chaves — sem ciclo).
- **Adversarial, 1ª passada: 0,62 ✗** — 1 HIGH + 2 MEDIUM que são DECISÃO (= Q-PR52, Q-PR53, Q-PR54 abaixo; fixados como `it.failing` em
  `src/__tests__/adversarial-r6-gate.test.ts`) + 4 LOW. Corrigidos na sessão: preço de tabela excluída (o mesmo do socrático); predicado do
  serviço — sem S VIVA mostra TODAS (inclusive `kind` NULL; a decisão dizia "todas", o código mostrava só P) e "viva" = não excluída E
  ATIVA (`LIVE_SERVICE_CATEGORY_SQL`; uma S só inativa escondia as outras e impedia o ato de criar "Serviços") — a mesma condição no
  `ensureDefaultCategory` e na 072 (prova 21/21, casos K e I novos); o aviso do desligar prometia mais do que o fuso garante (o fuso global
  do banco é America/Sao_Paulo — um escritor que não faça o `SET time_zone` data `created_at` 3 h antes) → "pode contar". Resistiram (6
  `[RESISTIU]`): cerca por varredura (só os 4 módulos guardados e as peças deles escrevem nas tabelas do catálogo), falha ao criar
  "Serviços" desfaz o desligamento, falha ao conferir mantém a chave desligada, duas chaves vivas = desde o desligamento mais antigo, chave
  sem instante = época, instante do `NOW()` do banco; a D-PR42 resistiu em todas as bordas no schema descartável.
  **Re-check adversarial: 0,80** — as correções resistiram (+3 `[RESISTIU]`; arquivo com 12 testes: 9 resistiu + 3 failing), nenhum achado
  novo de implementação; `passou: false` SÓ pelas decisões pendentes Q-PR52…Q-PR54. **Veredito: a implementação está pronta; a publicação
  espera a Q-PR52 (trava a janela) e a Q-PR53 (antes do 1º cliente com legado).**
- Limites registrados pelo adversarial: `syncProductPrices` soft-deleta o preço de tabela EXCLUÍDA a cada gravação da ficha (`NOT IN` sem
  filtrar tabela viva) — ANTERIOR à Rodada 6 (o services antigo fazia igual; o price-lists promete "preços ficam como histórico"); pedido
  com `status` NULL não conta como aberto na D-PR42; a D-PR42 pressupõe o congelado da NE-6 (uma devolução aberta depois da troca, sobre
  venda faturada do legado, mede na base nova); deadlock real de duas conexões no ato só foi provado no modelo (o retry, sim).

**Questões novas do gate socrático (Rodada 7 — aguardam o Valdo; as duas primeiras TRAVAM a janela de publicação)**:

**Q-PR52 — Com a chave ativa, a web enquadra o serviço do legado (regra de ISS em `tb_service`) e o classifica para o IBS/CBS
(`tb_service_ibscbs`)?** O `PUT /api/services/:id` é o ÚNICO escritor desses dois fatos — o legado não os produz (dev: as 65 linhas de
`tb_service` nasceram na web desde 2026-09-02; os serviços do legado 2, 3 e 7–15 não têm vínculo; `tb_service_ibscbs` vazia). Com a guarda
no módulo inteiro, a Setes perde a forma de vincular regra (o faturamento da OS bloqueia serviço sem regra) e de classificar antes de
01/01/2027. **(a)** tirar esses dois fatos da guarda com rota própria (o legado não os escreve) **(Recomendado)** · (b) a guarda bloqueia só
o INSERT (POST) — leitura literal do "bloqueamos o insert" da resposta do Valdo · (c) manter só consulta e o enquadramento passa a vir do
sync (pedido ao grupo do sync; o legado não conhece `tb_service_tax_rule`).

**Q-PR53 — Onboarding de cliente COM legado.** A institution nasce ANTES das migrations e a chave do sincronizador só depois
(`generateSyncApiKey`) — a 072 cria "Produtos"/"Serviços" (ids 1 e 2, tipicamente) em TODO cliente novo, inclusive o que virá do legado, e o
1º "ligar" não confere nada. Quando o bootstrap do legado mandar as categorias 1 e 2, o upsert pela PK as sobrescreve (e, se não regravar o
`kind`, um grupo do legado fica 'S' e some das telas de mercadoria). **(a)** o cadastro da institution diz "com legado" antes das migrations,
a 072 não cria nada para ele e o 1º `generateSyncApiKey` aplica a mesma conferência do religar **(Recomendado)** · (b) aceitar a sobrescrita
se o grupo do sync confirmar que o upsert de `tb_category` regrava `kind` e `posit_level` · (c) gerar a chave sempre antes das migrations.

**Q-PR54 — A "Serviços" do ato de desligar ocupa o próximo id do legado** (Setes: categorias 8 e 9 do legado → ela seria a 10); depois de
religar, a próxima categoria do legado a sobrescreve, e os serviços movidos para ela no período caem num grupo alheio (edição não conta no
religar). **(a)** o religar também conta essa categoria se algum produto aponta para ela; senão, o roteiro avança o gerador de categorias do
legado além dela **(Recomendado)** · (b) só criar "Serviços" quando a saída do legado for definitiva · (c) aceitar e registrar o limite.

**Q-PR55 — Saída do 409 `SYNC_KEY_WEB_ROWS`.** O soft delete não libera o id, a D-PR37 proíbe apagar fisicamente e não há ato para
forçar — uma linha nascida no período (ou gravada pelo setes-sync nos 5 min de cache: ele grava `created_at` = NOW() ao inserir) prende o
estabelecimento fora do sincronizador. E o aviso de "parar antes" só chega na resposta do desligar. **(a)** procedimento documentado
(avançar os geradores do legado — GN_PRODUTO, categoria, tabela de preço — além do maior id da web) + ato do super "religar assim mesmo"
com confirmação e motivo no log **(Recomendado)** · (b) sem saída · (c) exceção física documentada (PADROES §3.1).

**Q-PR56 — O instante do desligamento é fato próprio?** Hoje mora no `tb_sync_api_key.updated_at` (coluna de uso geral — o SQL do roteiro,
uma futura troca de chave ou o setes-sync podem empurrá-lo e esconder linhas). **(a)** coluna própria `deactivated_at` (DDL na central
compartilhada — com o grupo do sync) **(Recomendado — ele decide uma guarda, o que a Q-PR48 (a) não previa)** · (b) seguir no `updated_at`
com a regra "só o interruptor escreve `updated_at`".

Notas do parecer (sem ação agora): (d) nenhum ciclo de trava achado entre o ato e os escritores do setes-api (a ordem do setes-sync não foi
conferida — fronteira dos grupos); em escala, os 3 `COUNT(*)` do religar rodam sob a trava da institution (sem índice em `created_at`) e
podem estourar o WAIT 10 de pedidos/faturamento durante o ato. (g) onda do app: com S viva, o lookup não lista a categoria P gravada no
serviço do legado — o formulário mostra o rótulo do GET e não manda null.

### Rodada 7 — decisões (2026-10-20, rodada "uma pergunta por vez" com o Valdo)

- **D-PR45** (fecha a **Q-PR52 = (a)**, literal: *"(a), siga a recomendação"* — DESTRAVA a janela) — **o enquadramento fiscal do serviço
  sai da guarda do sincronizador por ROTA PRÓPRIA**: `PUT /api/services/:id/tax-rule` (vínculo serviço → regra de ISS, `tb_service`) e
  `PUT /api/services/:id/ibscbs` (classificação IBS/CBS, `tb_service_ibscbs`) NÃO passam pelo `syncWriteGuard` — o legado não produz
  esses dois fatos, a web é a única escritora deles; o `PUT /api/services/:id` (dados do cadastro) continua guardado. Princípio: o dono
  do CADASTRO é o legado (chave ativa), o dono do ENQUADRAMENTO FISCAL é a web — cada fato com o seu escritor. Privilégio das duas rotas
  = ALTERAR em `services` (`privilegeAct`); o app mostra os dois blocos editáveis mesmo em cliente "só consulta" (D-PR32), com o resto do
  formulário travado. Testes: as duas rotas gravam com chave ativa; o PUT do cadastro segue 409 `SYNC_KEY_ACTIVE`; cerca de que
  nenhum outro escritor de `tb_service_tax_rule`/`tb_service_ibscbs` nasce fora dessas rotas (varredura).
- **D-PR46** (fecha a **Q-PR53 = (b)**, DIVERGIU da recomendação (a)) — **onboarding de cliente com legado: aceitar a sobrescrita das
  categorias padrão pelo bootstrap do legado**, SOB CONDIÇÃO do grupo do sync confirmar que o upsert de `tb_category` pelo
  `/category/sincronize` regrava `kind` E `posit_level` (senão um grupo do legado ficaria 'S' e sumiria das telas de mercadoria). A
  condição vira pergunta ao grupo do sync — **Q-SY24** (levar ao `setes-sync/verificacao-comissao-margem-mercadoria.md` na próxima sessão
  daquele grupo; fronteira dos grupos: esta frente não lê o código do setes-sync). Enquanto a Q-SY24 não volta: a 072 segue criando
  "Produtos"/"Serviços" em todo cliente novo; nenhum flag "com legado" nasce na institution; o 1º ligar da chave não confere nada. Se a
  resposta for "não regrava", a Q-PR53 reabre com (a) como saída.

#### Rodada 7 — RE-ELABORAÇÃO do modelo da chave do sincronizador (Valdo, 2026-10-20, na Q-PR54)

Literal do Valdo: *"nao havera ligar e desligar a chave de forma aleatoria. Quando o cliente for cadastrado ja saberei se vira via
sincronizador ou nao. Se vier pelo sincronizador ele sera usado ate o dia que nao usara mais, nao tem idas e vindas. O sincronizador é
apenas uma etapa de transicao entre o sistema desktop e web. Ou receber dados do pdv e neste caso o cadastro de produtos sera feito pela
web, entao a sincronia do pdv quebra a logica do uso da chave bloqueia ou desbloqueia o sincronizador... Vamos re-elaborar"*.

**O que cai**: a premissa "chave ATIVA = legado dono dos cadastros, chave INATIVA = web dona" (D-PR32/D-PR41/D-PR43 e a Rodada 6: 072
"Serviços" no ato de desligar, religar com 409 `SYNC_KEY_WEB_ROWS`, `assertNoActiveSyncKey`). Ela confunde DUAS coisas: a chave
(autenticação do sincronizador — a D-SY13 "chave inativa = sincronizador INATIVO" segue como interruptor de emergência) e o DONO dos
cadastros, que é um fato do ESTABELECIMENTO conhecido no cadastro dele.

**Modelo reelaborado (proposta do condutor — forma final com o guardião antes de qualquer DDL)**:
1. **Origem dos cadastros** = fato da institution, definido no cadastro: **W** (nativo web), **L** (transição do desktop legado: o legado
   é o dono de produtos/serviços/categorias/listas de preço, a web só consulta — enquadramento fiscal à parte, D-PR45), **P** (PDV: a WEB
   é a dona dos cadastros; os PDVs recebem o catálogo e mandam movimento).
2. A guarda de escrita da web pergunta "quem é o dono?" (W/P = web escreve; L = web só consulta), nunca "a chave está ativa?".
3. **L → W é um ato ÚNICO e irreversível, "encerrar a transição"** (data gravada; cria as categorias padrão que faltarem; o sincronizador
   do legado é recusado a partir daí). Não existe religar. P e W não mudam.
4. O modo PDV (o que o PDV recebe, numeração por terminal, chave por estabelecimento) é da frente `tb_terminal` (Q-TG8/Q-TG12) e do grupo
   do sync; esta frente fixa só "no modo P a web é dona dos cadastros".

**Efeitos na fila**: Q-PR53 reabre — o fato no cadastro da institution é exatamente a (a) (a D-PR46 fica A REVER após o modelo);
**Q-PR54, Q-PR55 e Q-PR56 perdem o objeto** (não há religar; o "instante do desligamento" vira a data do ato de encerrar); D-PR43 (interruptor
da chave) vira o ato de encerrar a transição ou fica só como interruptor de emergência da D-SY13; o código da Rodada 6 na branch
`merchandise` é retrabalho sobre commit. ⚠️ TRANSVERSAL: produtos, frente `tb_terminal`, grupo do sync (contrato da chave), onboarding.
- **D-PR47** (fecha a **Q-PR57 = (a)**, literal: *"(a), siga a recomendação"*) — **a ORIGEM DOS CADASTROS é fato da institution**
  (`tb_institution`, central; nome da coluna com o guardião — proposta `catalog_source` CHAR(1) W/L/P, CHECK binário, NOT NULL, definido no
  cadastro do cliente pelo Super): **W** nativo web · **L** transição do desktop legado (legado dono de produtos/serviços/categorias/listas
  de preço; web só consulta, salvo o enquadramento fiscal — D-PR45) · **P** PDV (web dona; PDVs recebem o catálogo e mandam movimento).
  Imutável, exceto **L → W pelo ato "encerrar a transição"** (ato do Super, uma vez, irreversível; grava `legacy_ended_at`; cria as
  categorias padrão que faltarem; o sincronizador do legado passa a ser recusado com código próprio). A chave do sincronizador só é
  gerada para L e P e NÃO carrega modo. A guarda da web (`syncWriteGuard` → renomear para `catalogOwnerGuard`) lê este fato, nunca a
  chave; a migration 072 cria "Produtos"/"Serviços" só para W e P (a D-PR46 fica SUPERADA: a Q-PR53 se resolve pelo fato — a Q-SY24 ao
  grupo do sync perde a urgência, fica como conferência). Antes do DDL: parecer do guardião (`setes-conceito`) sobre a forma + `PADROES_BANCO`
  + `revisar-ddl` + prova em descartável; a coluna nasce com backfill (dev: `setes_setes` = L enquanto a chave estiver ativa; demais = W).
- **D-PR48** (fecha a **Q-PR58 = (a)**, literal: *"(a), siga a recomendação"*) — **dois atos distintos**: (1) o interruptor da chave
  (`PUT /api/institutions/:id/sync-api-key/active`, D-PR43) fica SÓ como PAUSA de emergência, reversível (D-SY13: sincronizador INATIVO
  até reativar) — não muda dono, não cria categoria, não confere linhas (o 409 `SYNC_KEY_WEB_ROWS` e a "Serviços" do ato de desligar
  SAEM do código da Rodada 6); (2) **"encerrar a transição"** = ato NOVO do Super, `POST /api/institutions/:id/end-legacy-transition`,
  só para `catalog_source = 'L'`, irreversível: confirma com motivo, grava `legacy_ended_at`, muda L → W, cria as categorias padrão que
  faltarem (a 072 vira peça chamada aqui e no onboarding W/P), inativa a chave em definitivo (chave de L encerrado nunca reativa — 403
  `SYNC_TRANSITION_ENDED` no sincronizador, código novo a combinar com o grupo do sync). Privilégio: ato do Super (tela Institutions);
  trilha no log com autor. A branch `merchandise` refaz a Rodada 6 sobre isto (retrabalho sobre commit).
- **D-PR49** (Valdo, 2026-10-20 — refina D-PR47/D-PR48; literal: *"1 caminho - produto vem do desktop · 2 caminho - produto vem do
  desktop, servidor desktop é desativado e ficam somente os pdv · 3 caminho - produto vem da web abastece pdv que sincronizam somente
  vendas · 4 caminho - só temos web sem desktop"*) — **os QUATRO caminhos do cliente** sobre os três modos da D-PR47: caminho 1 = **L**
  (desktop dono dos cadastros); caminho 4 = **W**; caminho 3 = **P** (web dona; os PDVs recebem o catálogo da web e sincronizam SÓ
  vendas/movimento); **caminho 2 = a transição L → P**: o servidor desktop é desativado, os PDVs ficam, e a partir daí a WEB é a dona dos
  cadastros e abastece os PDVs. Logo o ato "encerrar a transição" (D-PR48) tem DESTINO: **L → W** (cliente sem PDV) ou **L → P** (cliente
  com PDV) — o Super escolhe o destino no ato (a frente `tb_terminal` acrescenta depois a conferência "P exige terminal kind P
  registrado"); nos dois casos a chave do LEGADO (servidor desktop) é encerrada em definitivo; no destino P, os PDVs seguem com a
  sincronia de movimento (chave por estabelecimento, D-TM) e passam a RECEBER o catálogo da web — a direção web → Firebird (D16 do sync,
  fase própria) e a projeção do que o PDV recebe (Q-TG8) são do grupo do sync + frente `tb_terminal`, não desta. P e W não mudam de modo.
- **D-PR50** (fecha a **Q-PR50 = (a)**, literal: *"(a), siga a recomendação"*) — **aceitar e registrar**: `tb_product` ids 16–79 e
  `tb_price_list` 3–4 do `setes_setes` nasceram na web no espaço do legado (ensaios; nada em produção); se o gerador do legado alcançar
  esses ids antes de a Setes encerrar a transição (D-PR48), o envio sobrescreve sem aviso — limite conhecido, anotado no roteiro de
  implantação da Setes como "encerrar a transição antes de o GN_PRODUTO passar de 15". A guarda da D-PR47 impede linhas NOVAS em L.
- **D-PR51** (fecha a **Q-PR51 = (a)**, literal: *"(a), siga a recomendação"*) — **a guarda do dono dos cadastros (`catalogOwnerGuard`,
  D-PR47) entra também em `financial-plans` e `bank-accounts`** (cadastros que o legado envia no caminho 1 e que a web cunha por MAX+1 no
  mesmo espaço de id): em `catalog_source = 'L'` a web só consulta nos dois; a lista `SYNC_FED_TABLES` (D-PR41) passa a ter 6 tabelas, e a
  cerca da skill `novo-modulo` confere que todo módulo cujo cadastro o legado envia monta a guarda.
- **D-PR52** (Valdo, 2026-10-20, literal: *"unidade/medida/embalagem/categorias/produtos/servicos/tabela de preco/preco, Lista de
  Estoque, saldo de estoque....sao os cadastros de base"*) — **definição do CATÁLOGO DE BASE** que o dono dos cadastros (D-PR47) escreve e a
  web só consulta no modo L: **unidade de venda** (`tb_merchandise_trade_unit`), **medida** (`tb_measure` + vínculo da institution),
  **embalagem** (`tb_package` + vínculo), **categorias**, **produtos**, **serviços** (cadastro — o enquadramento fiscal fica com a web,
  D-PR45), **tabela de preço** (`tb_price_list`), **preço** (`tb_price`), **lista de estoque** e **saldo de estoque**. A lista
  `SYNC_FED_TABLES` da guarda (`catalogOwnerGuard`) passa a ser ESTA, mais plano de contas e contas bancárias (D-PR51 — cadastros que o
  legado também envia, fora do catálogo de base). Medida e embalagem são catálogos CENTRAIS (D5 do sync): em L a web não cria nem vincula
  medida/embalagem para a institution (o sincronizador traz — D-SY10); nos modos W/P cria normalmente (D-PR28). Estoque: em L o saldo vem
  do legado (`/stock-balance`); em P o movimento dos PDVs alimenta o saldo que a web mantém; em W a web é a única escritora.
- **D-PR42 CONFIRMADA** (Valdo, 2026-10-20: *"confirmo"*) — `assertBaseUnitFree`: trocar a unidade-base = 409 `TRADE_UNIT_BASE_LOCKED`
  também com preço vivo ou item de pedido ABERTO na unidade (além do movimento faturado).

**Rodada 7 FECHADA (2026-10-20)**: Q-PR52 → D-PR45 (DESTRAVA a janela) · Q-PR53 → D-PR46 (SUPERADA pela D-PR47) · re-elaboração do modelo
da chave → D-PR47 (origem dos cadastros W/L/P na institution) · D-PR48 (pausa reversível × encerrar a transição) · D-PR49 (4 caminhos; L → W
ou L → P) · Q-PR50 → D-PR50 · Q-PR51 → D-PR51 · D-PR52 (catálogo de base) · D-PR42 confirmada · **Q-PR54/Q-PR55/Q-PR56 SEM OBJETO** (não há
religar). Pendente ao grupo do sync: Q-SY24 (upsert de categoria regrava `kind`/`posit_level`?) — conferência, não trava; o código novo
de `SYNC_TRANSITION_ENDED` e a chave por estabelecimento dos PDVs (destino P) são contrato com o grupo do sync. ⚠️ Reconciliar com a frente
do terminal (Q-TG3/Q-TG4: o guardião propôs o "ponteiro na linha do grupo" para o mesmo fato — decidir UM lugar quando o bloco do terminal
for revisto). Próximo número: **D-PR53**. Execução: a branch `merchandise` refaz a Rodada 6 sobre D-PR47/D-PR48 (retrabalho sobre commit),
rebase sobre o `main` pós-privilégios, DDL da coluna com o guardião; depois a janela (§9) e a onda 1 do app.

### Rodada 7 — execução (2026-10-20, worktree `merchandise/{setes-api,sql}` — retrabalho sobre o commit 2171f20/8b8cedf; NADA commitado nem aplicado ao banco)

Sessão própria (pedido do Valdo; a sessão-mãe coordena). A Rodada 6 foi REFEITA sobre D-PR45/D-PR47/D-PR48/D-PR49/D-PR51/D-PR52. Parecer do
guardião (`setes-conceito`) ANTES do DDL — integrado, com DOIS nomes corrigidos: **`catalog_source` → `source_kind`** ("origem do catálogo"
mentiria no modo P, em que a web é a dona: o valor é o TIPO DA FONTE EXTERNA que alimenta o estabelecimento — as mesmas letras do
`tb_terminal.kind`, D-TM9) e **`legacy_ended_at` → `transition_ended_at`** (no destino P os PDVs do legado continuam; o que acabou foi a
TRANSIÇÃO). ⚠️ A D-TM10 do prompt do terminal cita `catalog_source` — é o MESMO fato com o nome final `source_kind` (ajustar lá quando o bloco
do terminal for revisto; não editado aqui). O que entrou, item a item:

1. **O FATO (D-PR47) — migration `072_institution_source_kind.sql`** (CENTRAL, `setes_central.tb_institution`; o runner roda por schema, por
   isso cada passo é guardado por `information_schema` — precedente da 027 — ou re-executável): `source_kind` CHAR(1) **NOT NULL SEM DEFAULT**
   (fato declarado, nunca presumido — guardião) + `transition_ended_at` DATETIME NULL (write-once), logo depois de `schema_name`; backfill
   UMA vez nas linhas NULL (chave do sincronizador VIVA — ativa OU pausada, `deleted = 'N'`: a pausa não muda o dono — = 'L' — dev:
   `setes_setes`; demais = 'W'; 'P' não nasce de backfill); CHECK BINÁRIO
   nomeado `ck_institution_source_kind` (`COLLATE utf8mb4_bin IN ('W','L','P')`) + `ck_institution_transition_ended` ("L com data" não existe
   por construção). TODO DDL da 072 é guardado por `information_schema` (ADD COLUMN ×2, `MODIFY NOT NULL` por `is_nullable`, CHECKs por
   `CHECK_CONSTRAINTS` — 4 blocos `SET/PREPARE/EXECUTE`): o re-run por schema, inclusive AO VIVO no onboarding, não emite ALTER nenhum (gate
   socrático: um ALTER em `tb_institution` pede o MDL da linha que todo cunhador trava). **Renumeração**: a 072 da Rodada 6 (categorias
   padrão) virou **073** — ela passa a ler `source_kind` e tem de rodar DEPOIS da coluna (nenhum banco tinha a 072 antiga registrada;
   `_migrations` nunca a viu — se algum dia um schema a tiver, o remédio é apagar a linha 072 do `_migrations` dele, não renumerar). Espelho no
   repo `sql`: `01_setes_central_ddl.sql` (tabela com as colunas e os CHECKs) + `02` (a Setes nasce `'L'` — ADV-R7-02) + nota no `03` (a 073).
   **Boot** (`server.ts`, DEPOIS das migrations): `assertInstitutionSourceKindSchema` (`@shared/catalog-owner`) confere coluna NOT NULL sem
   default, os dois CHECKs pelo NOME em `information_schema.CHECK_CONSTRAINTS` e SONDA o motor (PADROES §11 regra 11) com linhas de prova de
   PK PRÓPRIA (`id = -1`, entity + institution) numa transação sempre desfeita — 'X', a minúscula 'l' e "L com data", cada um recusado pela
   constraint ESPERADA; nunca toca a linha da Setes (a que todo cunhador trava — gate socrático). **Provas em schema descartável**
   (`scripts/prove-072-institution-source-kind.ts` — cópias `LIKE` da central real, a migration com `setes_central` trocado): 20/20 —
   ADD/backfill/NOT NULL/CHECKs, re-execução idempotente (zero ALTER; a pausa da chave não reescreve o backfill), 'X'/'l'/'p' recusados pelo
   CHECK certo, "L com data" recusado, o ato com a condição no comando afeta 0 linhas na 2ª vez, **o INSERT sem `source_kind` (o `sql_mode` do
   dev NÃO é estrito: gravaria '') é recusado pelo CHECK** — o fato é declarado por construção —, e a 073 sobre a cópia cria só para W/P;
   `scripts/prove-073-default-categories.ts` (reescrito da prova da antiga 072): 19/19 — casos W/L/P, idempotência, `ensureDefaultCategories`.
   Conhecimento negativo (MariaDB 10.4.20): (a) `information_schema.COLUMNS.COLUMN_DEFAULT` da coluna nullable com `DEFAULT NULL` vem como a
   STRING `'NULL'` (a sem default vem `null`); (b) no INSERT que viola FK E CHECK ao mesmo tempo o motor acusa o CHECK primeiro (4025);
   (c) `ADD CONSTRAINT IF NOT EXISTS` é só MariaDB (a ida ao MySQL 8 — F3 — revê a cadeia; o boot já aceita o errno 3819 do MySQL).
2. **A guarda (D-PR47/D-PR51/D-PR52) — `syncWriteGuard` → `catalogOwnerGuard`** (`src/gateway/catalog-owner.guard.ts`) e **`@shared/sync-key`
   → `@shared/catalog-owner`** (`sourceKindOf(institutionId)` — hoje a própria institution; quando `@shared/group` nascer resolve a FUNDADORA
   pelo `groupInstitutionId`, D-TM10; `catalogOwnerOf(kind)` puro: L → legado, W/P → web; `sourceKindHasSync`; duas listas: **`BASE_CATALOG_TABLES`**
   = a lista literal da D-PR52 (unidade de venda, medida/embalagem + vínculos, categorias, produtos, serviços — só o cadastro —, tabela de
   preço, preço, lista e saldo de estoque) e **`LEGACY_OWNED_TABLES`** = base + plano de contas + contas bancárias (D-PR51); `LEGACY_OWNED_MODULES`
   = merchandise, services, price-lists, categories, financial-plans, bank-accounts). Escrita em L = 409 **`CATALOG_LEGACY_OWNED`** (código novo;
   `SYNC_MANAGED_CATALOG` e `SYNC_KEY_WEB_ROWS` SAÍRAM do catálogo — nunca publicados); leitura passa sem banco; falha fechado (fato ilegível =
   409; erro do banco nunca libera). **A reconferência transacional morreu** (`assertNoActiveSyncKey` fora de `allocateProductId`, `insertCategory`,
   `insertPriceList`): o fato é MONOTÔNICO (L → W/P, nunca de volta) — quem passou pela guarda nunca é alcançado por um fechamento. **O canal
   API da conta bancária** (Inter — `tb_bank_account_channel`, segredos, webhook) é fato só da web: as rotas `/:id/channel…` saíram de
   `bank-accounts.routes.ts` para **`bank-accounts.channel.routes.ts`, montado ANTES da guarda** (mesmo princípio da D-PR45 — senão a Setes,
   que é L, perderia o canal do Inter); o cadastro da conta (`tb_bank_account`) fica guardado.
3. **Interruptor da chave (D-PR48 item 1)** — `PUT /api/institutions/:id/sync-api-key/active` = só PAUSA/RETOMADA (`switchSyncApiKeyTx`:
   trava da institution → fato → chaves `FOR UPDATE` → UPDATE do `active`); saíram o aviso, a "Serviços" do desligar, o `webBornSince` e o
   409 `SYNC_KEY_WEB_ROWS`. Retomar em W = 409 **`SYNC_KEY_NOT_FOR_SOURCE`** (nativo web, ou L encerrado para W — a chave nunca reativa);
   `POST /sync-api-key` recusa em W pelo mesmo código (a chave só existe para L e P — D-PR47).
4. **O ato (D-PR48/D-PR49) — `POST /api/institutions/:id/end-legacy-transition`** (Super; corpo `{ destination: 'W' | 'P', reason ≥ 5 }` —
   "destination" é a palavra da D-PR49): `endLegacyTransitionTx` numa transação — trava da institution (a MESMA que todo cunhador de id e o
   interruptor travam) → fato `FOR UPDATE` → só L passa (não-L = 409 **`LEGACY_TRANSITION_NOT_APPLICABLE`**, inclusive "já foi encerrada": o
   ato é único, sem 2º código) → `UPDATE … SET source_kind = destino, transition_ended_at = NOW() WHERE id = ? AND source_kind = 'L' AND
   transition_ended_at IS NULL` (condição NO COMANDO — PADROES §11 regra 10; 0 linhas = falha alta) → destino W: chaves vivas → `active = 'N'`
   em definitivo; destino P: a chave FICA (é a dos PDVs — **A-PR4**, ver Q-PR60) → `ensureDefaultCategories` ("Produtos"/"Serviços" que
   faltarem — a 073 virou peça TS em `@shared/category-kind`, chamada pelo ato; no onboarding W/P é a própria 073 rodando no schema novo que
   as cria, porque a linha da institution já existe com o fato). `withDeadlockRetry` 3 (o ato cunha id de categoria). Resposta `{ sourceKind,
   transitionEndedAt, defaultCategories: { P, S }, syncKeysInactivated }`; trilha no log com autor, destino e MOTIVO (só log — Q-PR59); o
   instante do "já foi encerrada" vai em `fields[transitionEndedAt]`, nunca na prosa (PADROES §10). **BARREIRA INTERINA (A-PR5 / Q-PR61)**: o
   destino **P** responde 409 **`LEGACY_TRANSITION_DESTINATION_PENDING`** antes de qualquer transação (`OPEN_TRANSITION_DESTINATIONS = {W}` no
   service) — com a chave viva para os PDVs (A-PR4) e sem o setes-sync honrar o fato, L → P abriria DOIS escritores no catálogo (o desktop
   pela chave + a web, agora dona) num ato irreversível; cai quando o contrato `SYNC_TRANSITION_ENDED` existir. **Cadastro**:
   `POST /api/institutions` exige `sourceKind` (DTO sem default — ⚠️ o app da tela Institutions precisa mandar o campo: CONDIÇÃO DA JANELA,
   Q-PR62; cerca `institutions-contract-fence.test.ts`); `PUT` aceita `sourceKind` só como conferência — diferente do gravado = 409
   **`SOURCE_KIND_IMMUTABLE`** (nunca descarte silencioso); `GET /:id` devolve `sourceKind`/`transitionEndedAt`; a lista devolve `sourceKind`;
   `POST /sync-api-key` decide DENTRO da transação (trava → fato `FOR UPDATE` → chave viva — ADV-R7-03: o ato podia comitar entre a leitura e o
   INSERT e nascer chave ativa numa institution W). **Contexto de sessão** (`/api/core/me`, login/select/switch — bloco `context`): `sourceKind`
   e `catalogOwner` (`@shared/session-context` — o app trava o cadastro em L e libera só os blocos da D-PR45; invalidação por institution no
   ato; a guarda lê o fato ao vivo).
5. **D-PR45 — rotas próprias do enquadramento fiscal** `PUT /api/services/:id/tax-rule` (`{ serviceTaxRuleId | null }`) e `PUT /api/services/
   :id/ibscbs` (`{ nbs?, ibscbs? }` — ao menos um; mesma semântica do PUT: ausente não mexe, null remove) em **`services.fiscal.routes.ts`,
   montado ANTES do roteador guardado** (`router.use('/services', servicesFiscalRoutes)` e só depois `router.use('/services', catalogOwnerGuard,
   servicesRoutes)` — só PUT vive lá; outro método cai na guarda), privilégio **ALTERAR em `services`** (`requirePrivilege` — a guarda por
   roteador do `privilegios-crud` não existe nesta branch; na fusão vira `privilegeAct`), `assertClientRequired(..., only)` (parâmetro novo da
   peça `field-config`: a obrigatoriedade do cliente vale só sobre os campos da rota). Escritores: `updateServiceTaxRule` e
   `updateServiceFiscalClassification` em `services.repository.ts`, reusando os MESMOS escritores únicos do PUT (`upsertServiceRule`,
   `syncServiceClassification` — 4 pontos de chamada; `assertServiceTaxRuleRef`/`assertClassificationIfChanged` extraídos do `assertRefs`),
   trava do produto (kind S) 1º. Cerca por varredura em `adversarial-r7-gate.test.ts`.
6. **Trilha** (`scripts/trilha-primeiro-cliente.ts`, P1): lê `source_kind` (nunca a chave); em L usa um serviço vivo do legado e, se ele não tem
   regra de ISS ativa, a VINCULA pela rota própria da D-PR45 (prova viva do ato); sem serviço nenhum = PENDENTE. NÃO rodada (cria dados em
   `setes_setes` e exigiria subir a API da worktree, que aplicaria 072/073 no dev).
7. **Documentos**: skill `setes-api/skills/novo-modulo.md` (seção "Cadastro que o LEGADO alimenta → `catalogOwnerGuard`" + checklist); Swagger
   das 6 rotas guardadas (409 `CATALOG_LEGACY_OWNED`), do interruptor, do ato e das 2 rotas fiscais. `CLAUDE.md`/`INDICE_CENTRAL` NÃO editados
   (sessão-mãe).
8. **Testes** (tsc limpo): `catalog-owner-guard` (guarda, regras puras, as 2 listas, cerca de MONTAGEM — a guarda em exatamente os 6 módulos,
   os roteadores fiscal e do canal ANTES dela —, cunhadores sem reconferência, CATALOGAR), `sync-key-switch` (pausa; ato L→W/L→P; 409 fora de L;
   affectedRows 0 = falha alta; falha na categoria desfaz tudo; deadlock reexecuta; DTOs; `SOURCE_KIND_IMMUTABLE`; chave em W),
   `adversarial-catalog-owner-r7` (app real: 15 escritas × admin/super em L = 409; URL/método; leitura sem banco; JWT; L→W libera na hora; falha
   fechada; D-PR45 passa em L, 403 sem ALTERAR/sem interface; canal do Inter passa em L), `adversarial-sync-switch-gate` (app real: quem alcança
   os dois atos; bordas; pausa não libera o catálogo; ato com rollback REAL no modelo em memória; irreversível; deadlock; ordem das travas;
   lookup pelo fato), `adversarial-r7-gate` (cercas estáticas: escritores das `LEGACY_OWNED_TABLES`, central-catalog, peças, os 2 escritores
   fiscais e seus 4 chamadores, UM UPDATE de `source_kind` que comita, a 072/073 re-executáveis, o boot), `services` (+4 das rotas próprias),
   `adversarial-merchandise-r3-guard` adaptado (fato em vez de chave). Removidos: `sync-write-guard`, `adversarial-sync-guard-r6`,
   `adversarial-r6-gate` (os 3 `it.failing` da R6: o HIGH virou `it` resolvido por D-PR45; os 2 MEDIUM ficaram sem objeto).
   Suíte completa: **139/142 suítes · 2.141 testes · 0 falhando** (as 3 suítes que não sobem são os gates ao vivo da F2a sem `.env` na worktree — ambiente, a mesma linha de base da Rodada 6); tsc limpo. Cercas novas: `institutions-contract-fence` (payload do app × DTO; seed 02 × DDL 01). Gates: ver "Rodada 7 — gates" abaixo.

**Contratos pendentes (fora desta frente)**:
- **Grupo do sync** (fronteira dos grupos — nada lido nem escrito lá): (1) o setes-sync passa a LER `tb_institution.source_kind` e recusa
  CADASTRO quando `≠ 'L'` com código **`SYNC_TRANSITION_ENDED`** (D-PR48 diz 403, D-TM10 diz 409 simétrico à guarda — reconciliar lá; é
  transporte); a chave INATIVA segue sendo só a pausa (`SYNC_KEY_INACTIVE`, D-SY13) — no destino W a chave fica inativa e o setes-sync a
  recusa já pela pausa; no destino P a chave segue viva para os PDVs (movimento) e o cadastro é recusado pelo FATO; (2) **Q-SY24** (o upsert
  de `tb_category` pelo `/category/sincronize` regrava `kind` e `posit_level`?) — conferência, não trava (D-PR47 superou a D-PR46).
- **Frente do terminal** (D-TM9/D-TM10): o ato inativa o terminal L e, no destino P, confere "P exige terminal kind P registrado"; o nome do
  fato é `source_kind`.
- **App** (onda 1 de produtos / tela Institutions): o POST manda `sourceKind` (W/L/P, obrigatório); o Super vê `sourceKind`/`transitionEndedAt`
  e tem o botão "Encerrar a transição" (destino + motivo); em L o formulário do serviço mostra só os blocos regra de ISS/IBS-CBS editáveis
  (D-PR45) e o resto travado; códigos novos no app: `CATALOG_LEGACY_OWNED`, `SYNC_KEY_NOT_FOR_SOURCE`, `SOURCE_KIND_IMMUTABLE`,
  `LEGACY_TRANSITION_NOT_APPLICABLE`.
- **Publicação** (janela, com "vai"): 072 e 073 rodam no boot do setes-api (072 na central UMA vez — dev: `setes_setes` = L); `npm run errors:gen`
  (catálogo derivado); a D-PR50 (ids 16–79/3–4 da Setes no espaço do legado) segue como limite até a Setes encerrar a transição.

**Questões novas (aguardam o Valdo)** — numeração continua de Q-PR59; assunções executadas: **A-PR4** (chave fica em L → P) e **A-PR5**
(barreira interina do destino P):
- **Q-PR59 — motivo e autor do ato: só log ou colunas?** (guardião) O Valdo disse "trilha no log com autor" — executado assim (log com autor,
  destino e motivo). O log é operação (gira, não aparece na tela Institutions); a casa guarda decisão humana irreversível como fato do objeto
  (`tb_invoice_cancel_waiver`: `reason` + `tb_user_id`). **(a) Recomendado**: `transition_ended_by` INT NULL + `transition_end_reason`
  VARCHAR(255) NULL, write-once na mesma linha (três colunas de UM ato — não é maquete; viram `_event` só se nascer um 2º ato), E o log —
  migration aditiva pequena · (b) só log (como está).
- **Q-PR60 — a chave no destino P** (guardião; executado como **A-PR4 = (a)**): D-PR48 manda "inativar a chave em definitivo", mas
  D-PR49/D-TM11 mantêm os PDVs sincronizando com a chave POR ESTABELECIMENTO — hoje a MESMA linha que o servidor desktop usava. Matá-la em
  L → P reinstalaria todos os PDVs (Pipoteca: 7). **(a) Recomendado — executado**: o ato NÃO toca a chave em L → P (o servidor desktop é
  excluído pelo FATO lido no setes-sync e, com a frente do terminal, pelo terminal L inativado); em L → W a chave é inativada e nunca reativa
  (`SYNC_KEY_NOT_FOR_SOURCE`) · (b) manter o literal: emitir chave nova para os PDVs no ato (contrato novo + reinstalação).
- **Q-PR61 — destino P enquanto o setes-sync não lê o fato** (gates socrático e adversarial; executado como **A-PR5 = (a)**): o ato L → P
  deixa a chave viva para os PDVs e conta com o setes-sync recusar o servidor desktop por `SYNC_TRANSITION_ENDED` — contrato que ainda não
  existe; até lá, L → P = dois escritores no catálogo, num ato irreversível. **(a) Recomendado — executado**: destino P recusado (409
  `LEGACY_TRANSITION_DESTINATION_PENDING`) até o grupo do sync publicar a recusa pelo fato; nenhum cliente P hoje · (b) liberar como limite
  conhecido de implantação (roteiro: parar o servidor desktop ANTES do ato).
- **Q-PR62 — o POST do app sem `sourceKind`** (ADV-R7-01): o DTO exige o campo sem default (guardião: "fato declarado, nunca presumido" — um
  cliente de legado cadastrado como W nunca conseguiria a chave e W não volta). Até a tela Institutions mandar o campo, o cadastro de
  estabelecimento pelo app atual responde 400 `fields[sourceKind]` (cerca `institutions-contract-fence.test.ts` documenta o payload do app).
  **(a) Recomendado**: manter e fazer do form de Institutions (seletor W/L/P obrigatório na inclusão, só leitura na edição) CONDIÇÃO DA
  JANELA desta branch (nenhum cadastro novo de cliente pelo app antes disso) · (b) default 'W' no DTO até a onda do app (abre a armadilha).
- **Q-SY25 (grupo do sync — conferência, como a Q-SY24)**: o upsert de `tb_service` pelo `/service/sincronize` PRESERVA `tb_service_tax_rule_id`
  e `nbs` (não lista as colunas nem as zera)? Se regravar a linha, o enquadramento feito pela web em L (D-PR45) é apagado no próximo envio do
  legado e o faturamento volta a bloquear sem aviso — a D-PR45 precisaria de forma própria (coluna/tabela que o sync não toca). Hoje, no
  dev, o setes-sync não escreve `tb_service` (as 65 linhas nasceram na web) — pergunta de contrato, não de código desta frente.

**Limites registrados (Rodada 7)**:
- A monotonia L → W/P vale na APLICAÇÃO e no ato (condição no comando); os CHECKs recusam "L com data", mas um `UPDATE … SET source_kind =
  'L', transition_ended_at = NULL` por SQL é aceito (ADV-R7-09). Reparo de um W/P declarado errado = SQL com motivo registrado no roteiro de
  implantação, ANTES de qualquer cunhagem de id na web naquele estabelecimento; gatilho de monotonia (PADROES §11 regra 15) só se virar caso.
- `SessionContext` tem cache de 60 s por usuário: o ato invalida a institution inteira no processo que o executou; outro processo (ou outra
  instância na Onda 4) vê o dono novo em até 60 s — UX apenas, a guarda lê ao vivo.
- Merge: a fixture `src/test-setup/two-institutions.ts` da branch `grupo-leitores` (entra ANTES de `merchandise`) insere `tb_institution` sem
  `source_kind` — ajustar no merge seguinte; e a cerca da D-PV9/`listGatedRoutes()` do `privilegios-crud` precisa aceitar os dois roteadores
  montados FORA do módulo guardado (`servicesFiscalRoutes`, `bankAccountsChannelRoutes`) ou eles entram no `gatedModule` com `privilegeAct`
  ALTERAR — item do rebase, com o `catalog-owner-guard.test.ts` de montagem como régua.
- A frente do terminal acrescenta ao ato "inativar o terminal L" e, no destino P, "exige terminal kind P" (D-TM9/D-TM10 item 4) — o lugar é
  `endLegacyTransitionTx`, depois do UPDATE do fato.

### Rodada 7 — gates (2026-10-20/21)

- **Socrático: 0,73 ✅** (parecer: transação do ato na ordem certa — trava → fato `FOR UPDATE` → UPDATE condicionado → affectedRows → chave →
  categorias —, rollback total, monotonia sustenta a ausência de reconferência, CHECK binário + boot + prova; "nada CRITICAL"). Pontos
  abertos corrigidos NA SESSÃO: (1) a 072 emitia `MODIFY`/`ADD CONSTRAINT` em TODO schema (MDL exclusivo em `tb_institution` ao vivo no
  onboarding) → TODO DDL guardado por `information_schema`, zero ALTER no re-run (prova: as guardas resolvem para "nada a fazer"); (2) a sonda
  do boot fazia UPDATE na linha da Setes (a que todo cunhador trava — sem `WAIT`, derrubaria o boot por contenção) → linhas de prova com PK
  própria, sempre desfeitas; (3) nenhum endpoint do cliente expunha o fato → `sourceKind`/`catalogOwner` no `SessionContext`, invalidado por
  institution no ato; (4) `only` conferia obrigatoriedade de campo AUSENTE ("ausente = não mexe") → o par só é conferido quando vem no corpo;
  (5) destino P sem o contrato do sync → barreira interina (A-PR5/Q-PR61); (7) instante ISO na prosa do 409 → `fields[transitionEndedAt]`.
  Registrados: (6) nota de rebase (`listGatedRoutes()` × os 2 roteadores fora do `gatedModule`) e o passo do terminal no ato (acima, em
  "Limites"). Dica arquitetural retida: *migration central no runner por schema só é segura quando CADA statement é idempotente por
  `information_schema`, não só re-executável; e todo fato que o app precisa para travar tela entra no bloco `context` da sessão*.
- **Adversarial, 1ª passada: 0,64 ✗** — 2 HIGH + 4 MEDIUM + 4 LOW, quase todos na BORDA da entrega: **ADV-R7-01 HIGH** o app publicado não
  manda `sourceKind` (POST = 400) → condição da janela + cerca `institutions-contract-fence` (Q-PR62); **ADV-R7-02 HIGH** `sql/02` inseria a
  Setes sem `source_kind` (instalação limpa quebraria: estrito = 1364, não estrito = '' recusado pelo CHECK) → `'L'` no seed + cerca
  permanente derivada do CREATE; **ADV-R7-03 MEDIUM provado** TOCTOU do `POST /sync-api-key` (o ato comitava entre a leitura e o INSERT →
  chave VIVA numa institution W) → decisão dentro da transação (trava → fato `FOR UPDATE` → chave viva); **ADV-R7-04** Swagger do
  POST/PUT/GET/lista → atualizado; **ADV-R7-05** destino P = dois escritores → barreira interina; **ADV-R7-06** backfill tratava chave PAUSADA
  como W (irreversível) → chave VIVA = L; **ADV-R7-07 LOW** cerca cega a UPDATE multi-tabela/DELETE alias → regex `multi` sobre o texto sem
  prefixo de schema + 4 casos de controle positivo (autoteste da cerca); **ADV-R7-08 LOW** `only` × ausente → corrigido; **ADV-R7-09 LOW**
  monotonia só na aplicação (reparo por SQL) e **ADV-R7-10 LOW** `IF NOT EXISTS` só MariaDB → registrados em "Limites"/conhecimento negativo.
  **Re-check: 0,82 ✅ passou** — 7 corrigidos e provados, a ADV-R7-01 virou condição registrada da janela, sobrou **ADV-R7-11 LOW** (a sonda
  com `id = -1` segura um next-key lock no gap abaixo do menor id por milissegundos, antes do `listen` — inofensivo; se a sonda um dia rodar
  com o servidor servindo, usar id alto fora da faixa viva). Casos não testados retidos: autoteste da cerca (feito), Q-SY25, a fixture
  `two-institutions` no merge, "depois do ato `/api/core/me` diz W sem esperar o TTL" (sem teste), renumeração 072→073 em schema que tenha a
  antiga (nenhum hoje), concorrência real do ato (só em mock — `prove-merchandise-races.ts` não cobre o ato).
- **Veredito**: implementação pronta para a janela da branch (§9) SOB DUAS CONDIÇÕES já registradas: o form de Institutions mandando
  `sourceKind` (Q-PR62) e a resposta do Valdo à Q-PR61 (o destino P fica barrado até o contrato do sync — hoje nenhum cliente P).
  Próximo número: **D-PR53** · questões: **Q-PR63** · assunções: **A-PR6**.

