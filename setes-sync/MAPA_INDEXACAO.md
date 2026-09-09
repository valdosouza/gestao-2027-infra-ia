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
| **DOCUMENTO** | CPF/CNPJ → `tb_person`/`tb_company` → entity.id em setes_central (motor `sync.entity.ts`). ⚠️ **2026-08-14 (Valdo)**: entity ACHADA é **IMUTÁVEL** — reusa o id e NÃO reescreve a cadeia (fim do last-write-wins DESTE lado; cadastro errado de um cliente sobrescrevia o correto de outro, pois o mesmo documento vive em N institutions). Só a CRIAÇÃO grava; graduação do sem-doc segue atualizando (corrige a própria entity). setes-api/app inalterados (D1). **Convergência de dado novo = decisão PENDENTE** (memória `entidade-existente-imutavel-sync`) |
| **UUID** | Sem documento → `tb_no_doc.external_id`, devolvido como `externalCode` e gravado em `tb_empresa.externalCode` no Firebird (D4) |
| **DESCRIÇÃO** | Dedupe central por `UPPER(TRIM(descricao))`, acentos preservados (D17) + vínculo `tb_institution_has_*` (D5) |
| **ID LOCAL** ✅ | Id do Firebird ACEITO como id na web (D11) — só quando a tabela vive no schema do cliente com PK por institution e não há chave de negócio melhor |

---

## Tabela por entidade (ordem de prioridade D8)

| # | Entidade (classe Delphi) | Tabela destino | Indexador | Id local Firebird | Observações |
|---|---|---|---|---|---|
| 1 | Brand | setes_central.tb_brand + tb_institution_has_brand | DESCRIÇÃO | ❌ descartado | Onda 3 |
| 2 | Category | setes_<cli>.tb_category | **ID LOCAL** ✅ | ✅ CAT_CODIGO = id (PK id+institution) | árvore: posit_level SEMPRE recalculado pela API (@shared/tree-path) — Onda 3; ✔ 2026-08-01: TB_CATEGORY local nasce no BOOTSTRAP (conversão TB_GRUPOS/TB_SUBGRUPOS em 2 níveis + PRO_CODCAT — `Sincronizador/prompt_conversao_grupo_subgrupo_categoria.md`) e o `parentId` viaja REAL, derivado do POSIT_LEVEL (era hardcoded 0); ✔ 2026-08-04: Passo 0 = LIMPEZA PRÉVIA condicionada a sujeira (linha que a conversão não produziria → zera tabela+PRO_CODCAT+generator e reconverte; tabela conforme passa ilesa) |
| 3 | Measure | setes_central.tb_measure + tb_institution_has_measure | DESCRIÇÃO | ❌ descartado | Onda 3 |
| 4 | Package | setes_central.tb_package + tb_institution_has_package | DESCRIÇÃO | ❌ descartado | Onda 3 |
| 5 | Merchandise (Produto P/M) | setes_<cli>.tb_product/tb_merchandise/tb_stock | **ID LOCAL** ✅ | ✅ PRO_CODIGO = id | ✔ Onda 3: brand/package/measure por DESCRIÇÃO (fallbacks 'NÃO INFORMADA'/'UND'); categoria por id local (409 CATEGORY_NOT_SYNCED); `id_provider` fica NULL até a Onda 4 (fornecedor é por DOCUMENTO — id local violaria D3); quantity/minimum são domínio do stock-balance; ✔ notas M×S 2026-07-26 (D2): `product.kind` P/M gravado em tb_product.kind; 'S'/'A' → 422 KIND_NOT_ALLOWED |
| 5b | Service (Produto S) | setes_<cli>.tb_product (SÓ ela — kind='S') | **ID LOCAL** ✅ | ✅ PRO_CODIGO = id (mesmo espaço do #5) | ✔ notas M×S 2026-07-26 (D2): `/service/sincronize` — serviço não tem tb_merchandise/tb_stock; migration 019 backfillou kind e soft-deletou especializações indevidas |
| 6 | PriceList | setes_<cli>.tb_price_list | **ID LOCAL** ✅ | ✅ TPR_CODIGO = id | ✔ Onda 3: coluna de ativo real é `published`; margem = `aliq_profit` |
| 7 | Price | setes_<cli>.tb_price | composto (institution+priceList+product) | ✅ via PriceList+Produto | ✔ Onda 3: FK real → tb_product; 409 PRICE_LIST/PRODUCT_NOT_SYNCED |
| 8 | StockList | setes_<cli>.tb_stock_list | **ID LOCAL** ✅ | ✅ ETS_CODIGO = id | ✔ Onda 3: ETS_PRINCIPAL → coluna `main` |
| 9 | StockBalance | setes_<cli>.**tb_stock_balance** | composto (institution+stockList+merchandise) | ✅ | ✔ Onda 3: tabela PRÓPRIA com a dimensão da lista (corrigido — não é tb_stock); 409 STOCK_LIST/MERCHANDISE_NOT_SYNCED; ✔ 2026-08-14 (implantação Setes, decisão Valdo): saldo de produto kind 'S' → **200 sem gravar** (serviço não tem estoque; o legado cria TB_ESTOQUE p/ todo produto — sem o desvio o 409 seria eterno) |
| 10 | Promotion | setes_<cli>.tb_promotion + tb_promotion_items | **ID LOCAL** ✅ | ✅ | ✔ Onda 3: DDL real é price_tag/quantity/reg_active/oper (sem dt_begin/dt_end); items = snapshot (ausente no payload → deleted='S') |
| 11 | FinancialPlans | setes_<cli>.tb_financial_plans | **ID LOCAL** ✅ | ✅ PLC_CODIGO = id | ✔ Onda 3: árvore ÚNICA (posit_level recalculado; 409 PARENT_NOT_SYNCED); source_/kind/cluster |
| 12 | PaymentType | setes_central.tb_payment_types + tb_institution_has_payment_types | DESCRIÇÃO | ❌ descartado | ✔ Onda 3: id_nfce só na criação; attrs do vínculo só os presentes no payload; deleted='S' → `enable='N'` (coluna do vínculo é enable) |
| 13 | Customer | central (cadeia) + setes_<cli>.tb_customer | **DOCUMENTO/UUID** | ❌ NUNCA (calcanhar de aquiles) | papel: id = entity.id — Onda 4 |
| 14 | Provider | central (cadeia) + setes_<cli>.tb_provider | **DOCUMENTO/UUID** | ❌ NUNCA | Onda 4 |
| 15 | SalesMan | central (cadeia) + setes_<cli>.tb_collaborator/tb_salesman | **DOCUMENTO/UUID** | ❌ NUNCA | precedência Collaborator→Salesman — Onda 4; ✔ revisão de entidades 2026-07-25: sem CPF → UUID em `TB_COLABORADOR.EXTERNALCODE` (bootstrap cria; write-back por classe) |
| 15b | Carrier (Transportadora) | central (cadeia) + setes_<cli>.tb_carrier | **DOCUMENTO/UUID** | ❌ NUNCA | ✔ revisão de entidades 2026-07-25 (decisão 4): `TCarrierSendWeb` + `/carrier/sincronize` + seed Seq 38 — fecha o 409 CARRIER_NOT_SYNCED eterno; sincroniza ANTES do customer |
| 15c | User (TB_USUARIO — autor das operações) | central: cadeia + tb_user SEM credencial (password NULL, active='N') + tb_institution_has_user kind='SYNC' | **DOCUMENTO/UUID** (cascata: CPF do colaborador → TB_COLABORADOR.EXTERNALCODE → TB_USUARIO.EXTERNALCODE) | ❌ NUNCA (USU_CODIGO não viaja) | ✔ `prompt_indexacao_usuario_firebird.md` 2026-07-26 (8 decisões): `TUserSendWeb` + `/user/sincronize` + seed Seq 39 (perfil PDV desliga — EXTERNALCODE não replica); movimentos mandam bloco `user` (409 USER_NOT_SYNCED) |
| 16 | BankAccount | setes_<cli>.tb_bank_account | **ID LOCAL** ✅ | ✅ CTB_CODIGO = id | banco por NÚMERO FEBRABAN → setes_central.tb_bank (D2 da Onda 3 SH) — Onda 4 |
| 17–19 | OrderSale/Purchase/StockAdjust | setes_<cli>.tb_order + satélites **+ tb_invoice + ramo** | **ID LOCAL** ✅ | ✅ **NFL_CODIGO** = id (D1 notas M×S — a projeção do legado `nfl_codigo AS PED_CODIGO` sempre enviou a nota; PED_CODIGO NÃO viaja) | ✔ Onda 5 + rodada 2 (D8–D11, 2026-07-27): **PROCESSO COMPLETO** — fila dirigida por TB_NOTA_FISCAL (TB_PEDIDO FORA da fila; trigger morto); bloco `invoice` grava a nota + ramo na MESMA transação (mata o 409 ORDER_NOT_SYNCED por construção); cliente/vendedor/fornecedor por DOCUMENTO; itens snapshot ESCOPADO por kind; autor via bloco `user` |
| 17b | OrderService (ordem de serviço COMPLETA) | setes_<cli>.tb_order + tb_order_service (+ tb_order_sale na conjugada) + itens 'Service'/'Sale' + tb_invoice + ramos | **ID LOCAL** ✅ | ✅ NFL_CODIGO = id | ✔ notas M×S (D1/D6/D13): `/order-service/sincronize` recebe a ordem INTEIRA — na conjugada, blocos `sale`+`saleItems`+`invoice.merchandise` viajam juntos (1 envio, 1 transação); /order-sale fica para vendas PURAS; snapshots escopados por kind; totalizer/billing únicos; open_lock NULL |
| 20–21 | Invoice / InvoiceMerchandise | setes_<cli>.tb_invoice (+ ramo tb_invoice_merchandise) | **ID LOCAL** ✅ | ✅ NFL_CODIGO = id | ✔ Onda 5: destinatário por DOCUMENTO; CFOP = id da central (409 CFOP_NOT_FOUND); ✔ notas M×S (D1/D3): vínculo nota×pedido = a PRÓPRIA PK; ✔ rodada 2 (D10): /invoice-merchandise SAIU do catálogo Delphi (canal de nota ISOLADA na web); só a NOTA_AVULSA (/invoice) segue no catálogo |
| 21b | InvoiceService (nota de serviço) | setes_<cli>.tb_invoice + ramo tb_invoice_service (migration 020) | **ID LOCAL** ✅ | ✅ NFL_CODIGO = id (MESMO id no conjugado) | ✔ notas M×S (D3) + rodada 2 (D10): /invoice-service SAIU do catálogo Delphi (canal isolado) — o processo de serviço viaja pelo /order-service; RPS/lote vivem no retorno (D4) |
| 22 | StockStatement | setes_<cli>.tb_stock_statement | **ID LOCAL** ✅ | ✅ CET_CODIGO = id | ✔ Onda 5; ⚠️ PK física só `id` AUTO_INCREMENT — colisão entre institutions possível (DDL da Rodada 4); trigger de saldo só dispara no INSERT |
| 23 | Financial | setes_<cli>.tb_financial | **PK NATURAL** (inst+order+terminal+parcel) | ❌ FIN_CODIGO NÃO viaja (id vestigial no modelo 5.5) | ✔ Onda 5: **SEMÂNTICA DE ESPELHO** — baixa do legado = evento 1 status 'N' via upsert; estornos do legado não viajam; imutabilidade plena p/ eventos nascidos na web |
| 24 | FinancialStatement | setes_<cli>.tb_financial_statement | **ID LOCAL** ✅ | ✅ MVF_CODIGO = id | ✔ Onda 5: status 'N'/id_origin NULL (espelho); bank_account/historic ausentes → 0 sentinela; ✔ 2026-07-26: MVF_CODUSU via bloco `user` (ausente → 0) |
| 25 | Cashier | setes_<cli>.tb_cashier | **ID LOCAL** ✅ | ✅ | ✔ Onda 5: items do caixa REMOVIDOS do contrato (endpoint próprio futuro); ✔ 2026-07-26: autor via bloco `user` (ausente → tb_user_id NULL) |
| — | Retornos NF-e 55/65 / NFS-e / FileXml | tb_invoice (retorno) + disco | chave da NF-e / ID LOCAL | ✅ | arquivos: `SYNC_FILES_ROOT/<cnpj>/<ano>/<mes>/` (D20) — Onda 6; ✔ 2026-08-14 (implantação Setes — 4 correções): (1) `code_verif` 15→**100** e `motive` 60→**255** (migration 024) — prefeitura devolve a CHAVE da nota como verificação, `NFS_COD_VERIF` é VARCHAR(100) no Firebird; (2) ano/mês da pasta agora vem da **emissão extraída do próprio XML** (`dhEmi`/`dEmi`/`DataEmissao`; `dtReference` só fallback) — o Delphi manda a data do ENVIO e jogava TUDO no mês corrente; (3) `fileName` com caminho completo do desktop → basename; (4) blob `ARQ_CONTEUDO` vazio → 200 sem gravar (fila limpa; 20 casos na Setes) e conteúdo sem nome derivável → `sem-nome-<hash>.xml` |

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

**Ajuste 2026-07-26 (Valdo)**: as 7 linhas TB_REST_* foram REMOVIDAS do catálogo —
saíram do seed e o bootstrap as DELETA de bancos já semeados (Seqs 31–37 ficam
reservados). **Notas M×S rodada 2 — SINCRONIA POR PROCESSO (D8–D11, 2026-07-27)**: **TB_PEDIDO SAIU
da fila** (Seqs 17/18/19/41 removidas; Seq 21 NOTA_MERCADORIA também — a intermediária
não envia; trigger real `TG_SRC_PEDIDO` dropado pelo bootstrap, que também limpa a fila
órfã). A NOTA dirige tudo, e a **renumeração do Valdo (2026-07-27)** pôs o bloco de
processo logo após a avulsa (corrigindo a ordem de dependência — retornos processavam
antes das notas): Seq 20 NOTA_AVULSA (/invoice), **Seq 21 NOTA_SERVICO** (→ /order-service),
**Seq 22 NOTA_VENDA** (→ /order-sale), **Seq 23 NOTA_COMPRA** (→ /order-purchase),
**Seq 24 NOTA_AJUSTE** (→ /order-stock-adjust); as linhas antigas 22–30 foram empurradas
para **25–33** (retornos 55/65/NFS-e = 29/30/31, arquivo 32, CC-e 33 'N'); Seq 40
TB_PRODUTO/SERVICO (→ /service) mantida. Hierarquia Delphi: TInvoiceSendWeb (base) ←
TInvoiceMerchandiseSendWeb (intermediária sem catálogo) ← Sale/Purchase/Adjust;
TInvoiceServiceSendWeb herda da base. **Usuário PRIMEIRO (Valdo, 2026-07-27)**:
TB_USUARIO subiu para a **Seq 1** (referência do bloco `user` dos movimentos);
cadastros antigos 1–16 → 2–17; **transportadora → 18 e produto-serviço → 19**
(cadastros básicos — sem eles as notas não podem ser usadas; estavam depois do
movimento). Catálogo atual = **33 linhas CONTÍGUAS (32 ativas)**: Seqs 1–19
cadastros + 20–33 movimento; reservados 34+. Perfil PDV desliga tudo que não é
movimento (`SEQ NOT BETWEEN 20 AND 33` — robusto a renumeração). O bootstrap agora **ENFORÇA o SEQ por (TABELA, KIND)** a cada start —
bancos já semeados se renumeram sozinhos; SQL manual do patch 07 = só os INSERTs das
linhas novas 21–24.
**Mecânica de fila (D13, 2026-07-27 — a marca [KIND] dos patches 06/07 foi REMOVIDA,
patch 08)**: marca ÚNICA no SRC_LOG e **só de quem ENVIA** — classe cujo filtro não casa
"não tem nada pra enviar" e NÃO marca (registro segue para as próximas do ciclo). Funciona
porque os filtros são **DISJUNTOS**: NOTA_SERVICO = ped_tipo 1 COM itens S (e envia a
ordem conjugada INTEIRA: sale+saleItems+invoice.merchandise juntos) × NOTA_VENDA =
ped_tipo 1 SEM itens S × COMPRA/AJUSTE = ped_tipo 2/3 × AVULSA = nfl_tipo 'EM';
TB_PRODUTO: P/M × S. **Limpeza da fila (revisão do Valdo 2026-07-27)**: só remove
registro >48h COM envio OK (SRC_LOG='OK'); erro, pendente e órfão (ex.: PRO_TIPO 'A')
PERMANECEM para verificação.
**Campo WAY**: 'E' = Enviar (local → web), 'R' = Receber (web → local, fase D16) —
convenção do motor (`ControllerListaSincronia`: getListaEnviar/getListaReceber).

**NOVO GAP encontrado**: `TInvoiceRectificationSendWeb` (Carta de Correção
Eletrônica — CC-e, tabela `TB_CARTA_CORRECAO`/`CCE_CODIGO`) está registrada no
Delphi mas **não tinha endpoint em nenhuma das 6 ondas** — não estava na ordem
de prioridade D8. Fica para a Rodada 4 — precisa de endpoint `/invoice-rectification/sincronize`
novo (DDL: confirmar se `tb_invoice` aceita retificação como sub-registro ou
tabela própria).

## ⚠️ Pendências para a Rodada 4 do prompt (decisões do Valdo — NÃO bloqueiam)

Achadas durante a implementação das Ondas 3–5; os endpoints funcionam com os
fallbacks descritos, mas a decisão definitiva é arquitetural:

1. ~~**tb_order.tb_user_id NOT NULL**: pedidos do sync não têm usuário web~~ —
   **RESOLVIDO 2026-07-26** (`prompt_indexacao_usuario_firebird.md`, 8 decisões):
   frente Usuário completa (linha 15c) — autor real via bloco `user`; o fallback
   (menor usuário do institution) ficou SÓ para payloads sem o bloco (transição —
   morte do fallback quando todos os clientes compilarem o executável novo).
2. ~~**tb_invoice sem coluna de pedido**~~ — **RESOLVIDO 2026-07-26**
   (`prompt_notas_mercadoria_servico.md`, D1): o vínculo nota×pedido é a PRÓPRIA PK
   compartilhada (id = NFL_CODIGO = tb_order.id — mesma identidade do módulo nativo
   Software House). Nenhuma coluna nova; o orderId legado foi aposentado do contrato.
3. **tb_stock_statement com PK só `id` AUTO_INCREMENT**: ids locais de institutions
   diferentes podem colidir fisicamente. Correção = PK composta (id, institution,
   terminal) — DDL.
4. ~~**order-stock-adjust sem `direction` (sentido Entrada/Saída)**~~ —
   **RESOLVIDO 2026-08-09** (Valdo): não precisava de DDL nova — a 1ª letra do
   `TB_NOTA_FISCAL.NFL_TIPO` da própria nota já dá o sentido (`EI`/`EX` =
   Entrada Interna/Externa, `SI`/`SE` = Saída Interna/Externa).
   `invoice_merchandise_adjust_send_web.pas` agora manda
   `Copy(FCtrl.Registro.Tipo, 1, 1)` como `adjust.direction`. Sem mudança no
   contrato do setes-sync (já exigia `direction` de 1 char).
5. ~~**financial ORDER_NOT_SYNCED em nota AVULSA (`NFL_TIPO='EM'`)**~~ —
   **RESOLVIDO 2026-08-09**: achado na investigação do "Pedido 217864 ainda
   não sincronizado" — nota avulsa passa só por `/invoice/sincronize`
   (`upsertInvoice`), que grava `tb_invoice` mas NUNCA `tb_order` (só as
   notas de PROCESSO criam os dois juntos, D9). `financial.ts` checava
   exclusivamente `tb_order`, então financeiro de nota avulsa 409ava pra
   sempre — não era problema de ordem de envio nem filtro disjunto. Fix:
   `financial.ts` agora aceita `tb_invoice` (id+institution+terminal) como
   alternativa válida a `tb_order` antes de lançar `ORDER_NOT_SYNCED`.

6. **Sync × cancelamento de nota na WEB (Q-G6 do cancelamento de nota, 2026-09-09 —
   decisão D-G6 do Valdo: registrar, sem código agora)**: a web agora tem nota com HISTÓRIA
   (`tb_invoice_event` E/C; nota pendente cancelada = `deleted='S'` + evento C; número
   reaproveitável) e numera por `number_seq` (migration 045) no MESMO (modelo, série) que o
   legado. Dois riscos: (a) `upsertInvoice` do `/invoice/sincronize` pode REVIVER/sobrescrever
   uma nota cancelada na web sem saber (id = pedido); (b) legado × web disputam o MAX+1 do
   mesmo modelo/série. Candidatos: o sync não toca nota que tem evento na web (respeita a
   história) e/ou série própria da web; no sentido inverso (D16) o evento C precisa viajar.
7. **`tb_order_service.open_lock` é LEGADO desde a migration 047 da setes-api (2026-09-09)**: o
   ciclo da Ordem de Serviço mora em `tb_service_order` (tabela que o sync NUNCA grava — é assim
   que o pedido de serviço PURO sincronizado nunca vira OS). O `/order-service/sincronize` ainda
   escreve `open_lock` (NULL) no INSERT — tarefa deste projeto: remover a coluna do INSERT; depois
   a setes-api dropa a coluna (deploy casado — precedente `tb_cashier.tb_user_id`).

## Precedente do padrão "código externo"

CFOP na setes-api (2026-07-18): id = o próprio código digitado, imutável, 409 mesmo
excluído. É o mesmo princípio do ID LOCAL ✅ — quando o código É a chave de negócio.
