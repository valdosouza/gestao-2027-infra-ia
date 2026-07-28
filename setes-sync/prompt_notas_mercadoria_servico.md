# Prompt — Notas de Mercadoria × Serviço na sincronia (FECHADO)

**Escopo**: setes
**Status**: FECHADO em 2026-07-26 (decisões D1–D7 + rodada 2 D8–D11) — EM EXECUÇÃO
**Origem**: rascunho `Infra-IA/prompts/TratamentoNotasFiscalMercadoria_Servicos.txt` (superado → HISTORICO)
**Regras-mãe**: D1 canônica (setes-app↔setes-api × Sincronizador↔setes-sync), MAPA_INDEXACAO.md,
CONTRATOS_SYNC.md, PADROES_BANCO.md, guardião conceitual (peças de lego)

---

## Contexto

O Gestao2016 (Delphi/Firebird) trabalha com pedido e nota **conjugados**: uma ordem pode ser
de venda, de serviço ou os dois ao mesmo tempo. O faturamento gera **UMA TB_NOTA_FISCAL
mista** (o erro de design reconhecido: propriedades de mercadoria e serviço se misturam na
mesma linha), com **dois processos de autorização** sobre a mesma nota — NF-e (TB_RETORNO_NFE)
para a parte mercadoria e NFS-e (TB_RETORNO_NFS) para a parte serviço. O financeiro amarra
por FIN_CODNFL. Nada disso muda no legado ("não quero alterar a web nem o Delphi") — a
correção de desenho acontece **na camada de sincronia** (classes do sincronizador + setes-sync).

### Domínios do legado (fornecidos pelo Valdo, 2026-07-26 — fonte canônica)

| Campo | Domínio |
|---|---|
| `TB_PRODUTO.PRO_TIPO` | `P` Produto acabado · `M` Matéria-prima · `S` Serviço · (`A` cardápio — restaurante APOSENTADO, não sincroniza) |
| `TB_PEDIDO.PED_TIPO` | `1` Vendas · `2` Compras · `3` Ajustes (entrada×saída diferenciada por outra informação). **Não tem relação com tipo de produto** — pedido de serviço é PED_TIPO=1 |
| `TB_ITENS_NFL.ITF_OPER` | `V` Venda · `C` Compra · `A` Ajuste · `D` Devolução · `T` Troca |
| `TB_NOTA_FISCAL.NFL_TIPO` | `SI` Saída Interna · `SE` Saída Externa · `EI` Entrada Interna · `EE` Entrada Externa · `EM` Entrada Manual (**notas SEM itens** — por isso a nota avulsa não tem ramo) · `SC` Saída Complementar |
| `TB_NOTA_FISCAL.NFL_MODELO` | não contempla serviço — NUNCA usar como discriminador |

## O modelo (D1 — como o conjugado vive na web)

```
Delphi:  1 TB_PEDIDO ──► 1 TB_NOTA_FISCAL (mista)
                            ├─ autorização NF-e   → TB_RETORNO_NFE
                            ├─ autorização NFS-e  → TB_RETORNO_NFS
                            └─ financeiro (FIN_CODNFL)

Web:     1 tb_order (id = NFL_CODIGO)  ← o NFL_CODIGO vincula TODO o processo
            ├─ tb_order_sale     + itens kind 'Sale'    (PRO_TIPO P/M)
            ├─ tb_order_service  + itens kind 'Service' (PRO_TIPO S)
            └─ totalizer/billing ÚNICOS (listas separadas, totalizadas juntas)
         1 tb_invoice (mesmo id)
            ├─ tb_invoice_merchandise  (presente ⇔ tem parte mercadoria)
            └─ tb_invoice_service      (presente ⇔ tem parte serviço)
              → nota conjugada = os DOIS ramos presentes (D3)
         retornos 55/NFS-e e financeiro no MESMO id
```

Consequências estruturais:
- A pendência 2 da Rodada 4 ("tb_invoice sem coluna de pedido") **morre por construção**:
  o vínculo nota×operação é a própria PK compartilhada (mesma identidade do módulo nativo
  Software House: `tb_order.id = tb_order_service.id = tb_invoice.id = tb_financial.tb_order_id`).
- O financeiro JÁ estava certo (`TFinancialSendWeb` envia orderId = FIN_CODNFL).
- `TOrderSaleSendWeb` só envia pedido FATURADO (INNER JOIN com a nota) — pedido em aberto
  nunca viaja; a nota é o fato gerador da operação na web.

## Decisões arquiteturais registradas (permanentes)

| # | Decisão (Valdo, 2026-07-26) |
|---|---|
| D1 | Pedido conjugado MANTIDO como operação única na web: `tb_order.id = NFL_CODIGO` (nota mista = 1 order com os dois ramos). Nada muda no Gestao2016 nem na web; correção de desenho é da camada de sincronia. A UI web seguirá o mesmo rumo (peças e serviços em listas separadas, totalizadas juntas). |
| D2 | `tb_product.kind char(1)` com domínio **P\|M\|S** espelhando PRO_TIPO. SEM bifurcação de endpoint: `/merchandise/sincronize` só aceita kind≠'S'; novo `/service/sincronize` para kind='S'. PRO_TIPO='A' aposentado (não sincroniza). Separar `listMerchandiseProducts` × `listServiceProducts` na setes-api. |
| D3 | `tb_invoice` NÃO ganha coluna de tipo — a nota sozinha é objeto genérico; a natureza é o RAMO: `tb_invoice_merchandise` (mercadoria) × `tb_invoice_service` (serviço, TABELA NOVA). `/invoice-service/sincronize` espelha o `/invoice-merchandise`. "Trocar kind por model seria mágico por mágico." |
| D4 | TB_RPS_NFSE/TB_LOTE_NFSE NÃO sincronizam (retorno NFS-e + /filexml já cobrem RPS/lote/protocolo). `tb_provisional_receipt_service` (ociosa no baseline) é DROPADA — quando a web emitir NFS-e nativa, a peça nasce do fato gerador real. |
| D5 | Remoções: `tb_order_item_detail_observation`, `_optional`, `_remove`, `tb_order_item_flex` **+ a mãe `tb_order_item_detail`** (zero uso; resquício restaurante). |
| D6 | `TOrderSaleSendWeb` passa a enviar só itens PRO_TIPO≠'S' (kind 'Sale'); nova `TOrderServiceSendWeb` envia itens PRO_TIPO='S' (kind 'Service') gravando o ramo `tb_order_service` no MESMO order id. Conjugado = as duas classes alimentam o mesmo id, cada uma seu ramo (backbone sem constraint de exclusividade, por construção). |
| D7 | Bugs de catch-up corrigidos na mesma frente Delphi: `SqlTBPedidoAtualiza` compara PED_TIPO numérico com KIND textual (nunca casa — carga histórica de pedidos não sobe); `SqlTBNotaFiscalAtualiza` testa 'AVULSA' mas o seed grava 'NOTA_AVULSA'. Mapear KIND→valor real. |

### Rodada 2 — Sincronia por PROCESSO (decisões D8–D11, Valdo 2026-07-27)

| # | Decisão |
|---|---|
| D8 | **TB_PEDIDO SAI da fila de sincronia** (Seqs 17/18/19/41 removidas do catálogo; trigger TG_SRC_TB_PEDIDO morre; bootstrap limpa bancos já semeados). Com NFL_CODIGO como indexador, a NOTA é o único fato gerador: "controla a sincronia por tabela através dos triggers, mas sincroniza através de PROCESSOS definidos nas classes". Pedido editado após o faturamento sem tocar a nota NÃO reenvia — perda aceita (Q4). |
| D9 | **Objeto COMPLETO por processo (Q1-a)**: cada envio carrega pedido + nota + ramos numa transação única na web — mata o 409 ORDER_NOT_SYNCED por construção. Verificar/reusar o objeto completo que já existe no Delphi (TInvoiceDetachedSendWeb / FillDataObjetoDetached / FillDataObjeto do pedido). |
| D10 | **Nenhuma URL nova (Q2 — supera os nomes invoice-sale/purchase/adjust do rascunho)**: os endpoints atuais PERMANECEM e recebem o objeto completo — /order-sale, /order-purchase, /order-stock-adjust, /order-service ganham bloco `invoice` (base + ramo). /invoice-merchandise e /invoice-service permanecem na web como canal de NOTA ISOLADA (reenvio avulso), mas SAEM do catálogo do Delphi. /invoice (avulsa) intocado. |
| D11 | **Hierarquia de classes no Delphi (Q3)**: TInvoiceSendWeb (avulsa) ← TInvoiceMerchandiseSendWeb (intermediária SEM linha no catálogo) ← TInvoiceMerchandiseSaleSendWeb (PED_TIPO=1→/order-sale) · TInvoiceMerchandisePurchaseSendWeb (PED_TIPO=2→/order-purchase) · TInvoiceMerchandiseAdjustSendWeb (PED_TIPO=3→/order-stock-adjust); TInvoiceServiceSendWeb herda da avulsa e vira o processo completo de serviço (→/order-service). Os irmãos só variam o WHERE (INNER JOIN TB_PEDIDO por PED_TIPO) e o endpoint. As classes TOrder*SendWeb atuais são SUBSTITUÍDAS pela hierarquia. NOTA_MERCADORIA morre (intermediária não envia). Conjugado: NOTA_VENDA e NOTA_SERVICO disparam sobre o MESMO registro — mecânica [KIND] do patch 06 sustenta. |
| D12 | **Renumeração do catálogo (Valdo, 2026-07-27)**: bloco de processo logo após a avulsa — Seq 20 NOTA_AVULSA, **21 NOTA_SERVICO, 22 NOTA_VENDA, 23 NOTA_COMPRA, 24 NOTA_AJUSTE**; linhas antigas 22–30 empurradas para 25–33 (retornos 55/65/NFS-e = 29/30/31, arquivo 32, CC-e 33 'N' — corrige a ordem de dependência: retornos processavam ANTES das notas). Bootstrap ganhou `EnforceSeqCatalogo` (enforça SEQ por TABELA/KIND a cada start — bancos semeados se renumeram sozinhos; fase única, SEQ não tem UNIQUE) e os DELETEs de linhas mortas viraram por TABELA/KIND (o DELETE por SEQ literal mataria a NOTA_SERVICO no 21). |
| D14 | **USUÁRIO PRIMEIRO + cadastros antes das notas (Valdo, 2026-07-27)**: TB_USUARIO subiu da Seq 39 para a **Seq 1** (é a referência do bloco `user` de todos os movimentos — reduz 409 USER_NOT_SYNCED); cadastros antigos 1–16 → **2–17**; **transportadora (era 38) → 18 e produto-serviço (era 40) → 19** — são cadastros básicos, sem eles as notas não podem ser usadas, e estavam DEPOIS do movimento. Catálogo final = 33 linhas CONTÍGUAS (32 ativas): **Seqs 1–19 cadastros + 20–33 movimento**; reservados 34+. Perfil PDV robustecido junto: desliga `SEQ NOT BETWEEN 20 AND 33` (tudo que não é movimento), imune a renumerações. INSERT manual da Seq 39 (prompt do usuário) SUPERADO. |

### Rodada 3 — Correção da mecânica de fila (D13, Valdo 2026-07-27)

| # | Decisão |
|---|---|
| D13 | **A mecânica `[KIND]` no SRC_LOG estava ERRADA (erro de entendimento) — REMOVIDA.** O conceito correto: "guarda o registro alterado via tb_sincronia, mas efetua a sincronia através de PROCESSOS definidos nas classes executadas na factory". A marca no SRC_LOG é ÚNICA por registro e **só de quem ENVIA**: classe cujo filtro não casa com o registro "não tem nada pra enviar" e NÃO marca — o registro segue vivo para as próximas classes do ciclo. Isso funciona porque os filtros são **DISJUNTOS**: TB_PRODUTO → TMerchandiseSendWeb (PRO_TIPO P/M) × TServiceSendWeb (PRO_TIPO S); TB_NOTA_FISCAL → **TInvoiceServiceSendWeb (Seq 21): nota COM itens de serviço (VerificaServico), e envia a ORDEM DE SERVIÇO COMPLETA — payload com itens de mercadoria E de serviço; o /order-service registra o processo inteiro (ramo sale incluso quando houver itens de venda)** × TInvoiceMerchandiseSaleSendWeb (Seq 22): PED_TIPO=1 E SEM itens de serviço × Purchase (23): PED_TIPO=2 × Adjust (24): PED_TIPO=3. Catch-up alinhado aos mesmos filtros disjuntos. Limpeza da fila (revisão 2026-07-27): remove SÓ registro >48h COM envio OK (SRC_LOG='OK'); qualquer outra coisa — erro, pendente, órfão (ex.: PRO_TIPO='A') — PERMANECE para verificação. Consequência web: a nota conjugada agora entra INTEIRA por UM envio (/order-service com bloco `sale` + `saleItems` + `invoice.merchandise` opcional); o /order-sale fica para vendas puras. |

### Achados de varredura que fundamentam (2026-07-26)

- `tb_order_service` JÁ EXISTE (migration 013 — Software House): `number`, `tb_customer_id`,
  `open_lock` (UNIQUE permite N NULLs → pedidos do sync entram com open_lock NULL).
- `tb_order_item.kind` já está NA PK ('Sale'/'Purchase'/'Adjust'/'Service') — o sinalizador
  que o rascunho pedia já existe. Específico de mercadoria já vive em `tb_order_item_merchandise`.
- O retorno NFS-e JÁ sincroniza (Onda 6 + patch 04, Seq 28) — era o bug C3.
- PRO_TIPO já viaja hoje e está gravado em `tb_merchandise.kind` → é a fonte do backfill.
- Bug latente: `TInvoiceMerchandiseSendWeb` envia orderId=PED_CODIGO, mas a web valida contra
  `tb_order` cujo id é NFL_CODIGO → 409 eterno. Sob D1 o orderId morre (vínculo = próprio id).
- `/invoice-merchandise` NÃO gravava o ramo `tb_invoice_merchandise` — pela definição do D3,
  a nota sincronizada "não era nada". Corrigido nesta fase.
- `TControllerNotaFiscal.VerificaServico` (detecta itens S na nota) existe e NUNCA foi
  chamada — reusada agora.
- `TMerchandiseSendWeb` enviava PRO_TIPO='S' como mercadoria → serviços viravam
  mercadoria com estoque na web (migration 019 corrige os dados).

---

## Onda A — DDL (setes-api/src/migrations/sql, aplicado por schema de cliente)

### 019_product_kind.sql (D2)
1. `ALTER TABLE tb_product ADD COLUMN kind char(1) NOT NULL DEFAULT 'P'`
   (-- D2: 'P' produto acabado | 'M' matéria-prima | 'S' serviço) + KEY `idx_product_kind (kind)`.
2. Backfill: `UPDATE tb_product p JOIN tb_merchandise m USING(id, tb_institution_id)
   SET p.kind = m.kind WHERE m.kind IN ('P','M','S')`.
3. Produto SEM linha em tb_merchandise = serviço nato da web →
   `UPDATE tb_product p LEFT JOIN tb_merchandise m USING(...) SET p.kind='S' WHERE m.id IS NULL`.
4. Correção de dados (serviços sincronizados como mercadoria): soft-delete
   `tb_stock` e `tb_merchandise` onde `m.kind='S'` (deleted='S'; nunca DELETE físico — D2 do sync).

### 020_invoice_service.sql (D3)
```sql
CREATE TABLE IF NOT EXISTS tb_invoice_service (
  id int(11) NOT NULL,
  tb_institution_id int(11) NOT NULL,
  terminal int(11) NOT NULL DEFAULT 0,
  total_value decimal(10,2) DEFAULT NULL,   -- NFL_VL_TL_SRV
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  deleted char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (id, tb_institution_id, terminal),
  KEY updated_at (updated_at),
  CONSTRAINT fk_tb_invoice_service_invoice FOREIGN KEY (id, tb_institution_id, terminal)
    REFERENCES tb_invoice (id, tb_institution_id, terminal)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```
(ramo mínimo — cresce quando houver fato gerador; espelha o padrão tb_order_service)

### 021_drop_dead_tables.sql (D4/D5)
`DROP TABLE IF EXISTS` na ordem: `tb_order_item_detail_observation`,
`tb_order_item_detail_optional`, `tb_order_item_detail_remove`, `tb_order_item_detail`,
`tb_order_item_flex`, `tb_provisional_receipt_service`.

Validação: sqlglot (mysql) + checklist revisar-ddl. Aplicar com `npm run db:migrate`.

## Onda B — setes-sync (endpoints; molde = arquivos reais de `src/modules/sync/endpoints/`, envelope D14)

### POST /service/sincronize (NOVO — D2)
```jsonc
{ "id": 501, "deleted": "N",
  "product": { "description": "TROCA DE OLEO", "categoryId": 12, "identifier": "...",
               "promotion": "N", "highlights": "N", "active": "S", "published": "S", "note": null } }
// grava SÓ tb_product com kind='S' · 409 CATEGORY_NOT_SYNCED · id = PRO_CODIGO (ID LOCAL ✅)
```

### /merchandise/sincronize (ajuste — D2)
- payload `merchandise.kind` ('P'/'M') passa a gravar TAMBÉM `tb_product.kind`;
- `kind` ∉ {'P','M'} → **422 `KIND_NOT_ALLOWED`** (serviço usa /service; 'A' aposentado).

### POST /order-service/sincronize (NOVO — D1/D6)
```jsonc
{ "id": 1001, "terminal": 0, "deleted": "N",           // id = NFL_CODIGO (D1)
  "order":   { "dtRecord": "2026-07-26", "note": null, "status": "A", "origin": "D" },
  "service": { "number": 55, "customerDocument": "11222333000181" },
  "items":  [ { "id": 1, "productId": 501, "quantity": 1, "unitValue": 80,
                "discountAliquot": 0, "discountValue": 0 } ],
  "totalizer": { ... }, "billing": { ... }, "user": { "userDocument": "..." } }
// 409: CUSTOMER_NOT_SYNCED · PRODUCT_NOT_SYNCED · USER_NOT_SYNCED
```
- Transação: upsert tb_order + tb_order_service (number, tb_customer_id=entity.id,
  open_lock NULL) + itens kind 'Service' (SEM item_merchandise) + totalizer + billing.
- **Snapshot de itens ESCOPADO por kind='Service'** — nunca toca itens 'Sale'.
- Autor via bloco `user` (mesma regra 15c do MAPA).

### /order-sale/sincronize (ajuste — D6)
- Snapshot de itens ESCOPADO por kind='Sale' (hoje pode apagar itens de outros kinds do
  mesmo order — conferir e corrigir).
- Upserts de tb_order/totalizer/billing idempotentes (as duas classes enviam os mesmos
  valores do pedido; última escrita vence com valores idênticos).

### /invoice-merchandise/sincronize (ajuste — D3)
- payload ganha bloco `merchandise` → upsert do ramo `tb_invoice_merchandise`:
  `{ dtExit, tmExit, baseIcmsValue, icmsValue, baseIcmsStValue, icmsStValue, totalValue,
     freightValue, insuranceValue, expensesValue, ipiValue, discountValue, totalQtty, indPres }`
  (discountValue e indPres NOT NULL no DDL → default 0 quando ausentes).
- `orderId` REMOVIDO do contrato (aceito e IGNORADO se vier — transição). Vínculo/validação:
  `tb_order` com o MESMO id deve existir → 409 `ORDER_NOT_SYNCED`.

### POST /invoice-service/sincronize (NOVO — D3)
- payload = base do /invoice + bloco `service`: `{ totalValue }` (NFL_VL_TL_SRV).
- Upsert tb_invoice + ramo tb_invoice_service; `tb_order` mesmo id → 409 `ORDER_NOT_SYNCED`.
- Nota conjugada: os DOIS endpoints disparam para o mesmo id — upsert da tb_invoice
  idempotente, cada um grava seu ramo.

Swagger em todos os *.routes/arquivos de endpoint tocados (memória swagger-obrigatorio).
Testes jest cobrindo: service novo, merchandise 422, order-service (snapshot escopado,
conjugado sale+service no mesmo id), invoice-merchandise com ramo, invoice-service,
conjugada com os dois ramos.

## Onda C — sincronizador Delphi (patch 06 em `patches-revisao-2026-07/`; aguarda compilação do Valdo)

1. **TMerchandiseSendWeb**: query do controller ganha `AND PRO_TIPO IN ('P','M')`
   (mecânica de skip = molde TB_PEDIDO: sem linha → não envia). Continua em /merchandise.
2. **TServiceSendWeb (NOVA)** `classes/service_send_web.pas`: PRO_TIPO='S' → /service/sincronize
   (só bloco product; molde merchandise_send_web sem blocos merchandise/stock).
3. **TOrderSaleSendWeb**: itens com join TB_PRODUTO `AND PRO_TIPO <> 'S'`; se 0 itens
   (pedido só-serviço), não envia (a service manda totalizer/billing).
4. **TOrderServiceSendWeb (NOVA)** `classes/order_service_send_web.pas`: molde da sale;
   itens `AND PRO_TIPO='S'`; bloco `service` (number=PED número da venda? usar o MESMO
   number do pedido; customerDocument via DM.GetDocumentByEmpCodigo); se 0 itens, não envia.
5. **TInvoiceMerchandiseSendWeb**: volta a `FillDataObjetoMerchandise` (dados do ramo);
   remove orderId; envia bloco `merchandise`; só envia quando a nota tem parte mercadoria
   (`NFL_VL_TL_PROD > 0` OU existe item PRO_TIPO≠'S' — criar `VerificaProduto` no molde
   da `VerificaServico`).
6. **TInvoiceServiceSendWeb (NOVA)** `classes/invoice_service_send_web.pas`: envia quando
   `NFL_VL_TL_SRV > 0` OU `VerificaServico` = true; bloco `service.totalValue = NFL_VL_TL_SRV`.
7. **Seed** (`function/un_sincronia_seed.pas` + espelho `00b_seed_tb_lista_sincronia.sql`):
   - Seq 40 TB_PRODUTO KIND=SERVICO → TServiceSendWeb → /service/sincronize
   - Seq 41 TB_PEDIDO KIND=PEDIDO_SERVICO → TOrderServiceSendWeb → /order-service/sincronize
   - Seq 42 TB_NOTA_FISCAL KIND=NOTA_SERVICO → TInvoiceServiceSendWeb → /invoice-service/sincronize
   - registrar RegisterClass/UnRegisterClass no uMain; catálogo passa de 32 → 35 linhas.
8. **Catch-up (D7)** em `ControllerSincronia`:
   - `SqlTBPedidoAtualiza`: mapear KIND→PED_TIPO (PEDIDO_VENDA→1, PEDIDO_COMPRA→2,
     AJUSTE_ESTOQUE→3, PEDIDO_SERVICO→1).
   - `SqlTBNotaFiscalAtualiza`: comparar com 'NOTA_AVULSA' (nfl_tipo='EM');
     NOTA_MERCADORIA/NOTA_SERVICO → nfl_tipo≠'EM' (as classes filtram a natureza).

## Onda D — setes-api/app + docs

1. `service-orders.repository.listServiceProducts` e `contracts.repository.listContractProducts`:
   `AND p.kind = 'S'` (D2 — separar as listas; a lista de mercadorias nasce quando houver tela).
2. Ajustar testes que criam produtos de serviço (fixtures ganham kind='S').
3. Docs vivos: MAPA_INDEXACAO.md (linhas novas Service/OrderService/InvoiceService; nota na
   linha 20–21 sobre a morte da pendência 2), CONTRATOS_SYNC.md (contratos acima),
   CLAUDE.md raiz (estado), memória, rascunho → HISTORICO.

### 1ª rodada REAL do Sincronizador (2026-07-27) — correções de carga

Diagnóstico via `setes-sync/logs/sync-errors.log` (middleware novo em
`gateway/sync-error-log.middleware.ts` — toda resposta ≥400 com o campo exato; os 4xx
não eram logados em lugar nenhum e o SRC_LOG descartava o detalhe):
1. `invoice.number` VAZIO (2.112) → aceito, grava NULL (nota não autorizada; reenvio atualiza).
2. Rate limit 500/min (246) → 5.000/min (`SYNC_RATE_LIMIT_PER_MIN`).
3. **Referência central VAZIA**: tb_cfop tinha 1 linha (1.384 CFOP_NOT_FOUND), tb_state 1,
   tb_city 2 (500 de FK no endereço). Correções: seed 27 estados IBGE (`sql/06_seed_geo_estados.sql`,
   alíquota 12.00 placeholder — REVISAR); cidade AUTO-CRIADA na carga (nome placeholder,
   id do legado); CFOP AUTO-CRIADO (descrição placeholder); país/estado inexistentes =
   409 COUNTRY/STATE_NOT_FOUND legíveis (era 500).
4. `company.dtFoundation`/`person.birthday` vazios ('') → null (70 clientes barrados).
⚠️ Regra operacional: registro com ERRO não reenvia sozinho (pendência = SRC_LOG vazio) —
retry manual: `UPDATE TB_SINCRONIA SET SRC_LOG = NULL WHERE SRC_LOG <> 'OK'`.
**Referência REAL importada do legado (2026-07-27)**: Valdo exportou TB_PAIS/TB_STATE/
TB_CIDADE/TB_CFOP do Firebird (`D:\Gestao2027\seed\*_firebird.sql`) → conversor
`setes-sync/scripts/import-legado-referencia.ts` gerou o canônico
`sql/07_seed_referencia_legado.sql` e aplicou: **245 países (BACEN), 28 UFs (IBGE, com
alíquota interestadual real — mata o placeholder 12.00 do seed 06), 5.568 cidades (id
do legado + IBGE preenchido), 530 CFOPs com descrição real**. Placeholders auto-criados
foram todos enriquecidos (0 restantes); zero conflito de IBGE; Curitiba id 4004 confirma
o esquema de ids. O auto-create de cidade/CFOP na carga permanece como rede de segurança.
**Pendências para a Rodada 4**: indexação de cidade por IBGE no payload (ids de cidade
são os do legado — colidem entre clientes); retry automático de 409 de dependência.

## Fora de escopo desta fase (registrado, não some)

- ITF_OPER 'D' (Devolução) e 'T' (Troca) — operações próprias, fase futura.
- Emissão NATIVA de NFS-e pela web (aí nasce a especialização de serviço/tb_service e o RPS
  próprio — fato gerador).
- Tela web de OS conjugada (UI seguirá o rumo: listas separadas, totalizadas juntas).
- CC-e (Seq 30) e demais achados da Rodada 4 (PK do stock_statement).
- Limpeza do `tb_merchandise.kind` (redundante após 019) — só quando nada mais o ler.

## Notas da implementação (2026-07-26 — EXECUTADO)

- **Ondas A/B/D**: migrations 019–021 aplicadas em dev (backfill verificado: produtos da Setes
  viraram kind='S'); endpoints novos + ajustes com tsc limpo, 23/23 testes setes-sync,
  134/134 setes-api e smoke `scripts/smoke-notas-servico.ts` **13/13** (ciclo conjugado
  completo: produto S, 422 no merchandise, 1 order + 2 ramos, snapshot escopado provado,
  1 invoice + 2 ramos, 409 de vínculo).
- **Onda C (Delphi — patch `sincronizador/patches-revisao-2026-07/06_notas_mercadoria_servico.md`)**:
  3 classes novas + ajustes conforme a spec, com 2 desvios documentados:
  (1) `FillDataObjetoMerchandise` NÃO readotada — typo legado no model de destino
  (getter de ValorIcmsSt lê base_icms_st_value) corromperia o icmsStValue; bloco
  `merchandise` é lido direto do TNotaFiscal;
  (2) **ACHADO CRÍTICO**: a fila TB_SINCRONIA marcava SRC_LOG por (tabela, registro) — a
  2ª classe do conjugado nunca via o registro. Correção: fila DISJUNTA por PRO_TIPO no
  TB_PRODUTO + marca `[KIND]resultado` no SRC_LOG de TB_PEDIDO/TB_NOTA_FISCAL (pendência
  `NOT LIKE '%[KIND]%'`); D7 estendido aos SqlTB*Deleta (mesmo bug). ⚠️ Mecânica aguarda
  validação do Valdo (patch 06, pendência 3).
- **Rodada 2 (D8–D11 — patch `07_sincronia_por_processo.md`, 2026-07-27)**: web — os 4
  /order-* ganharam o bloco `invoice` opcional (nota + ramo na MESMA transação; helpers
  `invoiceProcessBlock`/`upsertMerchandiseRamo`/`upsertServiceRamo` reusados); smoke
  reescrito prova o processo completo (12/12). Delphi — hierarquia implementada
  (TInvoiceSendWeb base com helpers de processo; intermediária TInvoiceMerchandiseSendWeb
  sem catálogo; filhas Sale/Purchase/Adjust variam PedTipo/ramo/flags; TInvoiceServiceSendWeb
  herda da base); TOrder*SendWeb REMOVIDAS (precedente rest_*); getSincronia com filtro
  PED_TIPO opcional; catch-up sem TB_PEDIDO e com joins por ped_tipo; bootstrap deleta
  Seqs 17/18/19/21/41, dropa `TG_SRC_PEDIDO` (nome real, sem prefixo TB_) e limpa fila
  órfã. Catálogo final: 33 linhas (32 ativas). Bônus: bug das TOrder* passando PED_CODIGO
  a um filtro por código de NOTA morreu com a hierarquia.
- **Rodada 3 (D13 — patch `08_fila_marca_unica.md`)**: a mecânica [KIND] foi REMOVIDA
  (era erro de entendimento — o Valdo corrigiu em 2026-07-27); marca única só de quem
  envia + filtros disjuntos; /order-service virou o endpoint da ordem de serviço COMPLETA
  (blocos `sale`+`saleItems`+`invoice.merchandise` na conjugada — smoke 12/12 prova
  1 envio → 1 order com 2 ramos + itens dos 2 kinds + nota com 2 ramos).
- **Pendências do Valdo**: compilar o Sincronizador; rodar o SQL manual CONSOLIDADO do
  patch 07 em bancos já semeados (4 `UPDATE OR INSERT ... MATCHING (WAY, DESC_TABELA,
  KIND)` das Seqs 21–24 — deleções e renumeração o bootstrap faz sozinho; SQLs anteriores
  dos patches 06/07 ficam SUPERADOS; patch 08 NÃO tem SQL manual); teste ponta a ponta
  (conjugada = 1 envio pela NOTA_SERVICO; venda pura pela NOTA_VENDA).
  ~~Decidir a janela da limpeza~~ — **DECIDIDO (Valdo, 2026-07-27)**: a limpeza remove
  SÓ registro >48h COM envio OK (SRC_LOG='OK'); erro, pendente e órfão PERMANECEM na
  fila para verificação (aplicado em DeleteProcessadosAntigos; patch 08 atualizado).

## Critérios de sucesso

1. Migrations 019–021 aplicadas em dev sem erro; sqlglot OK.
2. Produto S sincronizado grava só tb_product (kind='S'); merchandise com kind='S' → 422.
3. Pedido conjugado (itens P+S) sincronizado = 1 tb_order com tb_order_sale + tb_order_service,
   itens 'Sale'+'Service' íntegros após reenvio de qualquer um dos lados (snapshot escopado).
4. Nota conjugada = 1 tb_invoice com os DOIS ramos; retornos 55/NFS-e e financeiro no mesmo id.
5. Suites setes-sync e setes-api verdes.
6. Delphi compila (Valdo) e smoke ponta a ponta por cliente segue o roteiro de implantação.
