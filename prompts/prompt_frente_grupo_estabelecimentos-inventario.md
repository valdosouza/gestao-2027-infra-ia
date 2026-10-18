# Anexo — Inventário da frente "Grupo de estabelecimentos (matriz × filiais)"

**Escopo**: misto (o método — varrer TODO SQL com schema e listar o que não filtra por `tb_institution_id` antes de juntar N
estabelecimentos num schema — é portável; os pontos são do Gestão 2027)
**Origem**: Rodada 0 da frente (2026-10-17; Valdo: "faça esta tarefa aqui: Rodada 0 da frente matriz × filiais (grupo = schema)").
Decisões de partida: D-PR20…D-PR23 do `prompt_modulo_products.md` §11. Levantamento SÓ LEITURA; setes-sync/sincronizador NÃO lidos.
**Prompt principal**: `prompt_frente_grupo_estabelecimentos.md`.

Prefixos: `API\` = `setes-api\src\` · `MIG\` = `setes-api\src\migrations\sql\` · `SCR\` = `setes-api\scripts\` · `SQL\` = `sql\` ·
`FIS\` = `fiscal-api\src\` · `NFSE\` = `nfse-api\` · `APP\` = `setes-app\`. [FATO] = conferido · [INF] = dedução.

**Como foi achado**: extração de todo template SQL com schema em `setes-api/src` (fora testes), listando os que não filtram por
`tb_institution_id` + JOINs/subqueries sem institution no ON/WHERE; depois as tabelas que existem UMA vez por schema.

---

## 1. O que já aguenta N institutions por schema [FATO]

JWT e auth (`institutionId` e `schemaName` saem do MESMO vínculo — `auth.service.ts:44-56`) · feature flags · todos os caches em memória
(chaveados por institution) · rate limit · `lockInstitutionCounters` + MAX+1 por institution (pedidos, OS, devolução, caixa, baixas) · nº
da nota e emissor/série · motor da regra tributária (`tb_tax_rule` com id MAX+1 por SCHEMA e leitura por institution — funciona) ·
MVA/FCP (UNIQUE com institution) · entity-tax · formas de pagamento (sob demanda, por institution) · `SCR\f2a-abort-before-cutover.ts`
(já trata N donas) · fiscal-api (`FIS\erp\facts.ts` — toda leitura por institution; `assertInstitutionSchema` aceita N:1) · nfse-api
(re-sincronia e virada por institution) · GRANTs por curinga `setes\_%` · storage fiscal por CNPJ.

## 2. O que QUEBRA com a 2ª institution no schema, por risco

**A. Vazamento entre estabelecimentos**
1. **Cofre do canal bancário** [FATO, conferido]: caminho `<SECRETS_PATH>/<schema>/bank-account/<bankAccountId>/<S|P>/<name>`
   (`API\shared\secret-store\secret-store.ts:19,58`; `API\shared\bank-channel\bank-channel.ts:40-41`), mas o id da conta é MAX+1 **por
   institution** (`API\modules\bank-accounts\bank-accounts.repository.ts:115-117`) ⇒ a conta 1 da filial lê/sobrescreve o certificado e o
   `client_secret` da conta 1 da matriz. (O A1 do emissor usa `establishment/<institutionId>` — sem colisão.)
2. **Privilégios por SCHEMA** [FATO, conferido]: `tb_user_has_privilege` sem `tb_institution_id` (PK user × interface × privilege —
   `MIG\003_setes_app_fase1.sql:64-78`); lido em `require-privilege.ts:42-55`, `core.repository.ts:142-146,177-181,213-225`,
   `users.repository.ts:260-264,307-345` e **no fisco** (`FIS\erp\facts.ts:138-147` → `NFSE\src\modules\guards.ts:19,65`: TRANSMITIR/
   CANCELAR) ⇒ privilégio dado na matriz vale na filial; o admin da filial altera o da matriz.
3. **Contrato de interfaces lido sem filtro** [FATO]: `admin.repository.ts:36-51` (a tela do Super mostra o "contratado" da outra e o salvar
   `:54-93` copia), `core.repository.ts:149-168,184-203` (menu = UNIÃO dos contratos), `modules.repository.ts:86-123`. Os guards de rota
   filtram por institution (`require-privilege.ts:141-151`) — alcance = tela + gravação pelo Super [INF].
4. **Observação fiscal da regra** [FATO, conferido]: `billing.repository.ts:338-355` junta `tb_observation` só por `o.id` (PK real
   `(id, tb_institution_id)` — `MIG\001_baseline.sql:1198-1208`) ⇒ a nota da filial pode sair com o texto da matriz.
5. **Menus por SCHEMA** [FATO]: `tb_module`/`tb_module_has_interface` (`MIG\003:38-62`; id MAX+1 do schema `modules.repository.ts:160`) — o
   admin de uma institution edita o menu de todas (pode ser o DESEJADO no grupo — decisão).
6. **Webhook do banco** [FATO]: `bank-channel-webhook.routes.ts:72-86` + `bank-channel.repository.ts:48-56` acham o canal pelo token sem
   conferir a institution da URL ⇒ processa sob a institution errada (exige conhecer o token).
7. **Impacto do catálogo IBS/CBS** [FATO]: `API\shared\ibscbs-catalog\apply.ts:634-672` percorre institutions e conta o schema inteiro —
   contagens duplicadas, ids misturados.

**B. Institution errada escolhida**
8. `core.repository.ts:4-18` — `WHERE i.schema_name = ?` + `rows[0]` sem ORDER BY → `/api/core/info` e o nome no `/api/core/me`.
9. `MIG\043_state_tax_rates_reshape.sql:18` — `… WHERE schema_name = DATABASE() LIMIT 1` (só legado multi-estabelecimento; já aplicada —
   depende do grupo do sync).
10. `establishment_code = schemaName.toUpperCase()` (`institutions.service.ts:169-171`) — igual para todas as filiais (sem UNIQUE em
    `SQL\05_sync_api_key.sql`; uso = grupo do sync).
11. Toda institution nova vira `tb_customer` da Setes (`institutions.repository.ts:135-146`) — cada filial seria um cliente faturável,
    contra a D-PR21 (o cliente é o GRUPO) [INF].

**C. Onboarding bloqueado**
12. `UNIQUE KEY schema_name` (`SQL\01_setes_central_ddl.sql:272`) + 409 "Schema já está em uso" (`institutions.service.ts:70-72`, teste
    `API\__tests__\onboarding.test.ts:98-102`) + DTO exige `schemaName` livre (`institutions.dto.ts:28-35`) + app só com schema livre
    (`APP\apps\web\lib\app\modules\institutions\domain\entity\object_institution.dart:144`).
13. Admin com e-mail NOVO obrigatório (`institutions.service.ts:73-76`); vínculo extra só pelo Super (`users.service.ts:134-154`); não
    existe "admin do grupo".
14. O app não chama `switch-institution` (`APP\packages\core\…\auth_remote_datasource.dart:11-39`) — trocar de filial = sair e entrar.

**D. Cosmético**
15. Laços sem DISTINCT por schema (`API\migrations\runner.ts:153-165`, `f2a-freeze-triggers.ts:130-145`, `SCR\reset-dev-data.ts:54-66`).
16. Rótulo "nome (schema)" igual para as filiais no app; super só na institution 1 (`roles.ts:3-14`).

**Outros fatos úteis**: `runMigrationsForSchema` é idempotente e não semeia por institution (só a 043 escolheu uma); `insertDefaultFlags` e
`grantStructuralInterfaces` são por institution e reaproveitáveis; gatilhos da F2a (`MIG\069`) são por SCHEMA — filial nova num schema já
congelado nasce sem caminho SE no ERP (coerente [INF]); ids do catálogo hoje MAX+1 por institution (services, categories, financial-plans,
price-lists) viram "por chave do catálogo" na frente.

## 3. Docs que afirmam 1:1 × N por schema [FATO]

- **1:1**: `setes-api/prompt_fase2_gerenciamento_central.md:54,440,650,701` (decisão 16 "todo tenant é uma institution"; UNIQUE
  `schema_name`) · `prompt_fase1_setes.md:9` · `Plano de Estruturacao.md:16,59` · `prompt_modulo_software_house.md:38` · `PADROES_BANCO.md:17`.
- **N por schema**: `setes-api/prompt_fase3_entidade_unica.md:49-51` ("um schema pode abrigar filiais") · `prompt_fase_faturamento_financeiro.md:854-856`
  ("regra de outro estabelecimento do mesmo schema") · `skills-genericas/guardiao-conceitual.md` (entrada "grupo (catálogo)") ·
  `PADROES_BANCO.md:400` (aborto da F2a em todas as donas).
- **A rever se o GRUPO virar o licenciado**: `prompt_apis_fiscais_isoladas.md:483` (D-F14 "licenciado = institution") ·
  `setes-sync/verificacao-comissao-margem-mercadoria.md:132,167` ("1 Firebird = 1 estabelecimento" — grupo do sync).

---

## 4. Catálogo do grupo × operação do estabelecimento — classificação das tabelas (2º levantamento, 2026-10-17)

Siglas: **D03** = `sql/03_schema_cliente_ddl.sql` · **B** = `MIG\001_baseline.sql` · **FB** = DDL Firebird do legado
`D:\Gestao2016\Scripts\Banco2022\CriarTodasAsTabelas.sql` · **L** = fonte `.pas` do Gestao2016 · **ANX** = `prompt_modulo_products-legado-abas.md`.
No legado, estabelecimento = `TB_EMPRESA` tipo 0 e `Gb_CodMha = EMP_CODIGO` (`Un_Regra_Negocio.pas:267-270`).

| Grupo de tabelas | Proposta | Legado (multi-estabelecimento num banco) |
|---|---|---|
| **Bem**: tb_product, tb_merchandise, tb_service, tb_service_ibscbs, tb_price_list + tb_price, tb_category, has_brand/package/measure/color, uf_benef, has_provider, has_self, imagens | **catálogo** (D-PR20) | produto ÚNICO (`GN_PRODUTO`), fiscal do bem nas colunas da TB_PRODUTO, marca/medida/embalagem/grupo/subgrupo sem estabelecimento; preço e tabela COMPARTILHADOS (`TPR_CODEMP` gravado e ignorado); `PRO_G_COMPARTILHA` = só VISIBILIDADE e lida POR estabelecimento; TB_CATEGORY (internet) por institution — categoria MISTA |
| **tb_service** | catálogo, MAS carrega `tb_service_tax_rule_id` com FK composta (D03:1237) — a regra de ISS é do estabelecimento | ISS dentro da TB_TRIBUTACAO por estabelecimento |
| **tb_financial_plans** | **decidido catálogo (D-PR20) — ⚠️ o legado era POR estabelecimento**: `TB_PLANOCONTAS` PK `(PLC_CODIGO, PLC_CODMHA)` (FB:2727-2736, conferido), listagens filtradas (`ControllerPlanoContas.pas:68,130`) | por estabelecimento; a forma de pagamento (global) apontava conta do plano (por estabelecimento) — inconsistência latente do legado |
| **Formas de pagamento** (`tb_institution_has_payment_types` — enable, TEF, parcelas, bloqueios, plano) | a decidir: vínculo do GRUPO ou da filial | TB_FORMAPAGTO GLOBAL com todos esses atributos (FB:1329-1343) |
| **Conta corrente**, canal, carteira de cobrança | operação/config do CNPJ | por estabelecimento (`CTB_CODMHA`) |
| **Regra tributária, regra de ISS, MVA, observação fiscal** | por estabelecimento (Q22 / D-PR20) | por estabelecimento (`TRB_CODMHA`, `MUN_CODMHA`, `OBS_CODMHA`) |
| **FCP** (`tb_state_fcp_ncm`) | hoje por institution (UNIQUE com inst) — ⚠️ o legado era COMPARTILHADO (PK `(TB_STATE_ID, NCM)`, FB:1161-1166) | compartilhado |
| **tb_entity_tax** | MISTO: com id = institution é o regime do EMITENTE (estabelecimento); com id = cliente é o fiscal do PAPEL | fiscal do cliente global (TB_EMPRESA/TB_CLIENTE) |
| **Papéis** (customer, provider, carrier, collaborator, salesman, parceria) | a decidir (§5) | cliente/fornecedor/transportadora COMPARTILHADOS (PK = id da empresa; termos comerciais na TB_EMPRESA global — crédito, vendedor, transportadora, forma, multiplicador); colaborador/vendedor compartilhados por padrão (`PES_G_COMPARTILHA='S'`); limite de crédito GLOBAL × saldo devedor POR estabelecimento (`RN_Financeiro.pas:64-71`) |
| **Operação** (pedidos e ramos, itens e impostos, notas e transmissões, financeiro, caixa, cheque, boleto, contratos, estoque e movimento, comissão) | por estabelecimento | por estabelecimento (`*_CODMHA`); ⚠️ `tb_order_cost` NÃO tem `tb_institution_id` (B:1225-1241) |
| **Configuração** (`tb_institution_has_interface/field/config`) | por estabelecimento (contrato/licença; campos e configs = candidatos a grupo) | TB_GERAL por estabelecimento (CFG-02) |
| **Privilégios** (`tb_user_has_privilege`) | **hoje do SCHEMA inteiro (vazamento — §2 A2)** | **POR estabelecimento**: `TB_PERMISSAO` PK `(PER_CODMHA, PER_CODUSU, PER_CODIIF)` (FB:2629-2634, conferido); o baseline web também tinha `tb_institution_id` na PK (B:2616-2625) e a **migration 003 tirou** ao recriar as tabelas de UI no formato canônico ("não há clientes em produção") |
| **Menus** (`tb_module`, `tb_module_has_interface`) | hoje do schema inteiro | TB_MODULO/TB_MENUS globais |
| **Promoção** | catálogo? | POR estabelecimento (PK com `TB_INSTITUTION_ID`, FB:2902-2918) |

## 5. O que quebra se o catálogo for chaveado pela FUNDADORA e a operação da filial apontar para ele

- **FKs físicas compostas**: `tb_stock.fk_stock_1 (tb_merchandise_id, tb_institution_id) → tb_merchandise` (B:2275 — o estoque é da filial);
  `tb_service.fk_service_tax_rule (tb_service_tax_rule_id, tb_institution_id)` (D03:1237 — a regra é da filial; o vínculo serviço × regra
  precisa sair da tabela do bem = regra 2 do §11 do prompt de produtos); `tb_price_ibfk_2 → tb_price_list(id)` só por id (B:1937 — ambígua
  com N institutions); parceria com FKs compostas cliente × colaborador (D03:1169-1175).
- **Joins operação × catálogo por `p.tb_institution_id = x.tb_institution_id`** (o grosso do custo): `orders.repository.ts:161-162` ·
  `billing.repository.ts:114-117,663` (o motor lê origem/finalidade por aqui) · `contracts.repository.ts:110-111` ·
  `service-orders.repository.ts:189-190,978,1134-1135` · `order-returns.repository.ts:142-143,185-186` · `@shared/order-return:343-344` ·
  `tax-rules.repository.ts:67-68` · `@shared/service-tax-rule/index.ts:76-77` · `services.repository.ts:127-128` ·
  `@shared/commission/commission.ts:62-66` (tb_price com a institution do PEDIDO) · `payment-types.repository.ts:46-51` (plano pela
  institution do vínculo).
- **Lookups/validações pela institution da sessão**: `orders.repository.ts:181,375` · `contracts.repository.ts:325` ·
  `service-orders.repository.ts:228` · `tax-rules.repository.ts:318` · `@shared/tax-rule/pieces.ts:166-170` · `@shared/service-product:18,39`
  · `@shared/service-ibscbs:53`.
- **Contadores** do catálogo MAX+1 por institution (produto, categoria, plano, tabela de preço) — viram "pela chave do catálogo".
- **Ids de catálogo gravados sem FK na operação**: tb_order_item, tb_contract_item(_competence), tb_tax_rule.tb_product_id,
  tb_promotion_items, tb_order_item_merchandise.tb_price_list_id, ids do plano no financeiro (`financial-settlement.ts`, `settlement-batch.ts`).
- **Não existe** casa para o vínculo filial × tabela de preço (D-PR23).

## 6. Papel de entidade: "do grupo" × "do estabelecimento"

Hoje: entidade central e única; papel com PK `(id, inst)` e termos comerciais POR institution (crédito, bloqueio, vendedor,
transportadora, forma, multiplicador, ativo — D03:24-37); fiscal do papel em `tb_entity_tax (id, inst)`; a Fase 3 PREVIU filiais no mesmo
schema ("o papel de cliente é POR INSTITUTION (um schema pode abrigar filiais)" — `setes-api/prompt_fase3_entidade_unica.md:48-50`); venda
na filial B falha se o papel não existe em B (`orders.repository.ts:307-312`). Legado: papel do GRUPO com exposição por estabelecimento
(limite global × dívida da filial ativa). Pontos que a decisão precisa cobrir [INF]: vendedor da filial (o cliente aponta a entidade central do
vendedor, mas comissão e sessão leem `tb_salesman` pela institution) · parceria (FKs compostas obrigam UMA chave para cliente e colaborador) ·
`tb_entity_tax` mistura fiscal do cliente (global no legado) com regime do emitente (critério "id = institution" separa).
