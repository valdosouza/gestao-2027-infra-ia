# Mapa de Indexação — Sincronizador → setes-sync → Gestão 2027

**Escopo**: setes
**Origem**: decisões D3/D4/D11/D18 do `prompt_revisao_sincronizador_setes_sync.md`
**Regra de ouro (D3)**: `emp_codigo`/códigos locais do Firebird NUNCA indexam entidades.
**Leitura obrigatória** da skill `skills/novo-endpoint-sync.md` antes de criar/alterar endpoint.

Este arquivo é o LOCAL PERMANENTE (D18) que memoriza, entidade a entidade:
qual é o indexador na web, o que acontece com o id local do Firebird, e as
transformações aplicadas. Atualizar SEMPRE que um endpoint for revisado.

---

## Legenda dos indexadores

| Indexador | Como funciona |
|---|---|
| **DOCUMENTO** | CPF/CNPJ → `tb_person`/`tb_company` → entity.id em setes_central (motor `sync.entity.ts`) |
| **UUID** | Sem documento → `tb_no_doc.external_id`, devolvido como `externalCode` e gravado em `tb_empresa.externalCode` no Firebird (D4) |
| **DESCRIÇÃO** | Dedupe central por `UPPER(TRIM(descricao))`, acentos preservados (D17) + vínculo `tb_institution_has_*` (D5) |
| **ID LOCAL** ✅ | Id do Firebird ACEITO como id na web (D11) — só quando a tabela vive no schema do cliente com PK por institution e não há chave de negócio melhor |

---

## Tabela por entidade (ordem de prioridade D8)

| # | Entidade (classe Delphi) | Tabela destino | Indexador | Id local Firebird | Observações |
|---|---|---|---|---|---|
| 1 | Brand | setes_central.tb_brand + tb_institution_has_brand | DESCRIÇÃO | ❌ descartado | Onda 3 |
| 2 | Category | setes_<cli>.tb_category | **ID LOCAL** ✅ | ✅ CAT_CODIGO = id (PK id+institution) | árvore: posit_level SEMPRE recalculado pela API (@shared/tree-path) — Onda 3 |
| 3 | Measure | setes_central.tb_measure + tb_institution_has_measure | DESCRIÇÃO | ❌ descartado | Onda 3 |
| 4 | Package | setes_central.tb_package + tb_institution_has_package | DESCRIÇÃO | ❌ descartado | Onda 3 |
| 5 | Merchandise (Produto) | setes_<cli>.tb_product/tb_merchandise/tb_stock | **ID LOCAL** ✅ | ✅ PRO_CODIGO = id | ✔ Onda 3: brand/package/measure por DESCRIÇÃO (fallbacks 'NÃO INFORMADA'/'UND'); categoria por id local (409 CATEGORY_NOT_SYNCED); `id_provider` fica NULL até a Onda 4 (fornecedor é por DOCUMENTO — id local violaria D3); quantity/minimum são domínio do stock-balance |
| 6 | PriceList | setes_<cli>.tb_price_list | **ID LOCAL** ✅ | ✅ TPR_CODIGO = id | ✔ Onda 3: coluna de ativo real é `published`; margem = `aliq_profit` |
| 7 | Price | setes_<cli>.tb_price | composto (institution+priceList+product) | ✅ via PriceList+Produto | ✔ Onda 3: FK real → tb_product; 409 PRICE_LIST/PRODUCT_NOT_SYNCED |
| 8 | StockList | setes_<cli>.tb_stock_list | **ID LOCAL** ✅ | ✅ ETS_CODIGO = id | ✔ Onda 3: ETS_PRINCIPAL → coluna `main` |
| 9 | StockBalance | setes_<cli>.**tb_stock_balance** | composto (institution+stockList+merchandise) | ✅ | ✔ Onda 3: tabela PRÓPRIA com a dimensão da lista (corrigido — não é tb_stock); 409 STOCK_LIST/MERCHANDISE_NOT_SYNCED |
| 10 | Promotion | setes_<cli>.tb_promotion + tb_promotion_items | **ID LOCAL** ✅ | ✅ | ✔ Onda 3: DDL real é price_tag/quantity/reg_active/oper (sem dt_begin/dt_end); items = snapshot (ausente no payload → deleted='S') |
| 11 | FinancialPlans | setes_<cli>.tb_financial_plans | **ID LOCAL** ✅ | ✅ PLC_CODIGO = id | ✔ Onda 3: árvore ÚNICA (posit_level recalculado; 409 PARENT_NOT_SYNCED); source_/kind/cluster |
| 12 | PaymentType | setes_central.tb_payment_types + tb_institution_has_payment_types | DESCRIÇÃO | ❌ descartado | ✔ Onda 3: id_nfce só na criação; attrs do vínculo só os presentes no payload; deleted='S' → `enable='N'` (coluna do vínculo é enable) |
| 13 | Customer | central (cadeia) + setes_<cli>.tb_customer | **DOCUMENTO/UUID** | ❌ NUNCA (calcanhar de aquiles) | papel: id = entity.id — Onda 4 |
| 14 | Provider | central (cadeia) + setes_<cli>.tb_provider | **DOCUMENTO/UUID** | ❌ NUNCA | Onda 4 |
| 15 | SalesMan | central (cadeia) + setes_<cli>.tb_collaborator/tb_salesman | **DOCUMENTO/UUID** | ❌ NUNCA | precedência Collaborator→Salesman — Onda 4; ✔ revisão de entidades 2026-07-25: sem CPF → UUID em `TB_COLABORADOR.EXTERNALCODE` (bootstrap cria; write-back por classe) |
| 15b | Carrier (Transportadora) | central (cadeia) + setes_<cli>.tb_carrier | **DOCUMENTO/UUID** | ❌ NUNCA | ✔ revisão de entidades 2026-07-25 (decisão 4): `TCarrierSendWeb` + `/carrier/sincronize` + seed Seq 38 — fecha o 409 CARRIER_NOT_SYNCED eterno; sincroniza ANTES do customer |
| 16 | BankAccount | setes_<cli>.tb_bank_account | **ID LOCAL** ✅ | ✅ CTB_CODIGO = id | banco por NÚMERO FEBRABAN → setes_central.tb_bank (D2 da Onda 3 SH) — Onda 4 |
| 17–19 | OrderSale/Purchase/StockAdjust | setes_<cli>.tb_order + satélites | **ID LOCAL** ✅ | ✅ PED_CODIGO = id | ✔ Onda 5: cliente/vendedor/fornecedor por DOCUMENTO c/ papel verificado (409 *_NOT_SYNCED); itens snapshot; ⚠️ tb_user_id NOT NULL → fallback menor usuário do institution (Rodada 4) |
| 20–21 | Invoice / InvoiceMerchandise | setes_<cli>.tb_invoice | **ID LOCAL** ✅ | ✅ NFL_CODIGO = id | ✔ Onda 5: destinatário por DOCUMENTO; CFOP = id da central (409 CFOP_NOT_FOUND); ⚠️ tb_invoice NÃO tem coluna de pedido — orderId só validado (vínculo persistido = DDL da Rodada 4) |
| 22 | StockStatement | setes_<cli>.tb_stock_statement | **ID LOCAL** ✅ | ✅ CET_CODIGO = id | ✔ Onda 5; ⚠️ PK física só `id` AUTO_INCREMENT — colisão entre institutions possível (DDL da Rodada 4); trigger de saldo só dispara no INSERT |
| 23 | Financial | setes_<cli>.tb_financial | **PK NATURAL** (inst+order+terminal+parcel) | ❌ FIN_CODIGO NÃO viaja (id vestigial no modelo 5.5) | ✔ Onda 5: **SEMÂNTICA DE ESPELHO** — baixa do legado = evento 1 status 'N' via upsert; estornos do legado não viajam; imutabilidade plena p/ eventos nascidos na web |
| 24 | FinancialStatement | setes_<cli>.tb_financial_statement | **ID LOCAL** ✅ | ✅ MVF_CODIGO = id | ✔ Onda 5: status 'N'/id_origin NULL (espelho); bank_account/historic ausentes → 0 sentinela |
| 25 | Cashier | setes_<cli>.tb_cashier | **ID LOCAL** ✅ | ✅ | ✔ Onda 5: tb_userid NULL; items do caixa REMOVIDOS do contrato (endpoint próprio futuro) |
| — | Retornos NF-e 55/65 / NFS-e / FileXml | tb_invoice (retorno) + disco | chave da NF-e / ID LOCAL | ✅ | arquivos: `SYNC_FILES_ROOT/<cnpj>/<ano>/<mes>/` (D20) — Onda 6 |

> ⚠️ As linhas marcadas com a onda futura são o PLANO — cada onda confirma/ajusta
> a linha ao revisar o endpoint (se mudar, atualizar AQUI no mesmo commit).

## Onda 0 — Inventário real do Sincronizador (2026-07-19)

`TB_LISTA_SINCRONIA` estava VAZIA em produção/teste — sem query oficial possível.
Reconstruído a partir do CÓDIGO REAL: `uMain.pas` (RegisterClass, 34 classes) +
`controller/ControllerTrigger.pas` (tabelas/campos-chave confirmados — fonte
mais confiável que a Documentacao.md). Script de seed:
`sincronizador/patches-revisao-2026-07/00b_seed_tb_lista_sincronia.sql`.

**37 classes reais** (não 36 como a análise de 2026-05-31 estimava): 28 cobertas
pelas Ondas 1–6 (SET_ON='S'), 9 ficam SET_ON='N' (7 do módulo restaurante
aposentado D23 + 2 gaps abaixo).

**NOVO GAP encontrado**: `TInvoiceRectificationSendWeb` (Carta de Correção
Eletrônica — CC-e, tabela `TB_CARTA_CORRECAO`/`CCE_CODIGO`) está registrada no
Delphi mas **não tinha endpoint em nenhuma das 6 ondas** — não estava na ordem
de prioridade D8. Fica para a Rodada 4 — precisa de endpoint `/invoice-rectification/sincronize`
novo (DDL: confirmar se `tb_invoice` aceita retificação como sub-registro ou
tabela própria).

## ⚠️ Pendências para a Rodada 4 do prompt (decisões do Valdo — NÃO bloqueiam)

Achadas durante a implementação das Ondas 3–5; os endpoints funcionam com os
fallbacks descritos, mas a decisão definitiva é arquitetural:

1. **tb_order.tb_user_id NOT NULL** (FK → setes_central.tb_user): pedidos do sync não
   têm usuário web. Fallback atual: menor usuário vinculado ao institution (409
   `INSTITUTION_USER_NOT_FOUND` se não houver). Opções: usuário-sentinela "sync" na
   central × coluna nullable × manter fallback.
2. **tb_invoice sem coluna de pedido**: o /invoice-merchandise valida o orderId mas
   não persiste o vínculo nota×pedido. Persistir = DDL nova (coluna tb_order_id).
3. **tb_stock_statement com PK só `id` AUTO_INCREMENT**: ids locais de institutions
   diferentes podem colidir fisicamente. Correção = PK composta (id, institution,
   terminal) — DDL.

## Precedente do padrão "código externo"

CFOP na setes-api (2026-07-18): id = o próprio código digitado, imutável, 409 mesmo
excluído. É o mesmo princípio do ID LOCAL ✅ — quando o código É a chave de negócio.
