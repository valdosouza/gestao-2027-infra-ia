# Contratos JSON — Sincronizador → setes-sync

**Escopo**: setes
**Origem**: decisões D14/D15/D22 do `prompt_revisao_sincronizador_setes_sync.md`
**Princípio (D15/D22)**: o Delphi monta o JSON já ALINHADO a estes contratos —
"o sistema que será aposentado se adapta ao formato novo, nunca o contrário".
Referência de shape: peças da Fase 3 copiadas da setes-api (`EntityFiscalInput`).

Cada endpoint revisado ganha sua seção AQUI, na mesma entrega (par do Swagger).

---

## Envelope de resposta (TODOS os endpoints — D14)

```jsonc
// HTTP 200 — sucesso (o Delphi marca sincronizado pelo status 200)
{ "ok": true, "id": 123, "externalCode": "uuid-..." }  // externalCode SÓ p/ personType N
{ "ok": true, "id": 123, "clearExternalCode": true }   // graduação: LIMPAR o vínculo no Firebird

// HTTP 4xx/5xx — erro (o Delphi grava `error` em TB_SINCRONIA.SRC_LOG)
{ "ok": false, "error": "mensagem", "fields": [{"field": "cpf", "message": "..."}], "code": "..." }
```

- `id`: id do registro na web (entity.id para entidades; id da tabela para os demais).
- `externalCode`: UUID a gravar em `tb_empresa.externalCode` no Firebird (D4) —
  devolvido SEMPRE que `personType='N'`.
- `clearExternalCode`: graduação do sem-doc (decisão 1 de
  `prompt_correcao_documento_entidade.md`, 2026-07-25) — o documento corrigido virou o
  índice; o Delphi faz `UPDATE <tabela-da-classe> SET EXTERNALCODE = NULL`.

## Graduação do sem-doc (correção de documento — 4 decisões, 2026-07-25)

Payload F/J **com** `externalCode` = sem-doc corrigido no Gestão. O motor (`sync.entity.ts`):

| Caso | Doc existe? | externalCode resolve? | Ação |
|---|---|---|---|
| A graduação | não | sim | entity do UUID GANHA o doc (MESMO id; toggle soft-deleta tb_no_doc) + `clearExternalCode` |
| B regravação | sim, mesma entity | (soft-deletado) | idempotente + `clearExternalCode` de novo |
| C conflito | sim, OUTRA entity | sim | NUNCA mescla: segue como sem-doc, doc não grava; conflito em `setes_central.tb_sync_conflict` (ação manual) |
| D1 órfão, doc livre | não | não | segue por documento + `clearExternalCode` + warning |
| D2 órfão, doc ocupado | sim | não | 409 `EXTERNAL_CODE_ORPHAN` + conflito registrado — nada gravado |

Verificação governamental (CNPJ via BrasilAPI; CPF só Serpro pago) = fase futura (decisão 4).

## Autenticação (D12)

Header `X-Api-Key: <chave da instalação>` — cadastrada em `setes_central.tb_sync_api_key`.
A chave resolve `institutionId` + `schemaName` no servidor: **o payload NÃO envia
tb_institution_id** (era injetado pelo Delphi; agora é derivado da chave).

## Soft delete (D2)

Todo payload aceita `"deleted": "S" | "N"` (default `"N"`). `"S"` = soft delete no destino.

---

## Bloco `entity` (padrão dos endpoints de entidade — Customer/Provider/SalesMan)

Shape = `EntityFiscalInput` da cadeia + extensões do sync (validado por
`syncEntityBody` em `src/modules/sync/sync.entity.ts`):

```jsonc
{
  "entity": {
    "nameCompany": "RAZAO SOCIAL / NOME",     // obrigatório
    "nickTrade":   "FANTASIA / APELIDO",      // obrigatório
    "aniversary":  "1990-05-20"               // opcional, YYYY-MM-DD
  },
  "personType": "F" | "J" | "N",
  "person":  { "cpf": "52998224725", "rg": "...", "birthday": "YYYY-MM-DD" },   // só F (sem máscara)
  "company": { "cnpj": "11222333000181", "ie": "...", "im": "...", "dtFoundation": "YYYY-MM-DD" }, // só J
  "externalCode": "uuid-...",                 // só N em REENVIO (1º envio omite; a web gera)
  "addresses": [ { "kind": "RESIDENCIAL", "street": "...", "nmbr": "123", "complement": null,
                   "neighborhood": "...", "zipCode": "74000000",
                   "tbCountryId": 1058, "tbStateId": 52, "tbCityId": 5208707, "main": "S" } ],
  "phones":    [ { "kind": "CELULAR", "contact": null, "number": "62999990000" } ],
  "mailings":  [ { "email": "contato@x.com.br", "groupId": 1 } ],   // 1=principal, 3=nfe
  "socialMedia": [ { "kind": "INSTAGRAM", "link": "https://instagram.com/x" } ]
}
```

Regras:
- `personType='F'` exige `person` (sem `company`); `'J'` o inverso; `'N'` nenhum dos dois.
- CPF/CNPJ **sem máscara** e com dígito verificador válido (o motor tira máscara defensivamente).
- Listas: campo AUSENTE = não tocar; `[]` explícito = limpar (proteção last-write-wins).
- `kind` único por lista (PK composta id+kind).
- Reindexação: documento (F/J) ou externalCode (N) → entity.id; o id devolvido no
  envelope é o entity.id da central. `emp_codigo` NUNCA viaja no bloco entity.

> Endereço: `tbStateId`/`tbCityId` são os códigos IBGE já usados na web (o Delphi
> converte UF/cidade via lookup local ANTES de enviar — TControllerUf/TControllerCidade);
> `tbCountryId` = BACEN (1058 Brasil). CEP e fones sem máscara (somente dígitos).
> **Fallback geográfico (decisão Valdo 2026-08-01)**: país/estado/cidade são migrados do
> Firebird — id do trio que NÃO exista na central (dado sujo do legado) não derruba o
> cadastro: o endereço cai para o trio COMPLETO do endereço do PRÓPRIO institution
> (`applyGeoFallback` no motor sync.entity; troca parcial criaria cidade fora do estado).
> Institution sem endereço → segue o 409 legível/cidade placeholder do ensureAddressRefs.

---

## Endpoints por entidade

### POST /brand/sincronize (Onda 3 — catálogo central)
```jsonc
{ "description": "NIKE", "deleted": "N" }
// → { ok: true, id }  (id do catálogo setes_central.tb_brand)
```
Dedupe por descrição (D17); `deleted:'S'` desativa o VÍNCULO (`tb_institution_has_brand.active='N'`)
— a linha central permanece. Id local MRC_CODIGO descartado.

### POST /package/sincronize (Onda 3 — catálogo central)
```jsonc
{ "description": "CAIXA", "abbreviation": "CX", "deleted": "N" }
```
Mesmo padrão do brand; `abbreviation` só entra na CRIAÇÃO da linha central.

### POST /measure/sincronize (Onda 3 — catálogo central; endpoint NOVO)
```jsonc
{ "description": "UNIDADE", "abbreviation": "UND", "escale": 1, "deleted": "N" }
```
Mesmo padrão do brand; atributos só na criação. (Não existia na setes-sync — gap fechado.)

### POST /category/sincronize (Onda 3 — id local + árvore)
```jsonc
{ "id": 12, "description": "BEBIDAS", "kind": "P", "parentId": 0, "active": "S", "deleted": "N" }
// → { ok: true, id: 12 }
```
`id` = CAT_CODIGO ✅; `parentId` 0 = raiz; `posit_level` SEMPRE recalculado no servidor
(@shared/tree-path) — o CAT_NIVEL legado NÃO viaja. Mover de pai move a subárvore.
Pai ainda não sincronizado → **409 `PARENT_NOT_SYNCED`** (reenviar no próximo ciclo).
`kind` do filho deve = `kind` do pai (árvores P/S independentes).
`kind` vazio/ausente = **'P'** (decisão Valdo 2026-08-01 — categorias migradas do legado
vêm sem tipo; 164 barradas na rodada de 2026-07-31).

### POST /merchandise/sincronize (Onda 3 — produto: 3 tabelas em transação)
```jsonc
{
  "id": 501,                       // PRO_CODIGO ✅
  "deleted": "N",
  "product":     { "description": "...", "categoryId": 12, "identifier": "...", "financialPlansId": null,
                   "promotion": "N", "highlights": "N", "active": "S", "published": "N", "note": "..." },
  "merchandise": { "nameBrand": "COCA-COLA", "internalId": "...", "ncm": "22021000", "cest": "...",
                   "kindTributary": "T", "source": "0", "kind": "00", "print": "S", "controlSeries": "N",
                   "exclusiveDealer": "N", "application": "...", "composition": "N", "manufSignIndScale": "S" },
  "stock":       { "namePackage": "GARRAFA", "nameMeasure": "UND", "codebar": "789...", "st": "N",
                   "divisor": null, "location": "...", "weight": 0, "width": 0, "length": 0, "height": 0,
                   "costManufactures": 0, "actualCost": 0, "costPrice": 0, "negative": "N", "outline": "N" }
}
```
`nameBrand`/`namePackage`/`nameMeasure` = DESCRIÇÕES → resolvidas no catálogo central + vínculo
(fallbacks legados: 'NÃO INFORMADA' / 'UND'). Categoria ausente → **409 `CATEGORY_NOT_SYNCED`**.
`quantity`/`minimum` NÃO viajam aqui (domínio do /stock-balance). `id_provider` fica NULL (Onda 4).
**Natureza (D2 — notas M×S, 2026-07-26)**: `product.kind` 'P'/'M' (gravado em `tb_product.kind`;
fallback de transição: `merchandise.kind` legado); 'S'/'A' → **422 `KIND_NOT_ALLOWED`**
(serviço usa o /service; 'A' aposentado). `product.kind` vazio conta como ausente e o
default final é 'P' (PRO_TIPO null → 'P' — decisão Valdo 2026-08-01).
**Campos-ESPELHO (decisão Valdo 2026-08-01, rodada real de 2026-07-31)**:
`merchandise.composition` = PRO_COMPOSICAO **como está** (domínio legado '1'/'2'/'3'/'5' —
não é S/N; a web não consome, só espelha) e `stock.divisor` = PRO_DIVISOR **como está**
(0 é valor legítimo). O snFlag S/N em composition barrava o catálogo inteiro (8.588 itens).

### POST /service/sincronize (notas M×S, 2026-07-26 — produto de SERVIÇO, D2)
```jsonc
{ "id": 501, "deleted": "N",             // PRO_CODIGO ✅ (mesmo espaço de id do /merchandise)
  "product": { "description": "TROCA DE OLEO", "categoryId": 12, "identifier": "...",
               "promotion": "N", "highlights": "N", "active": "S", "published": "N", "note": null } }
// grava SÓ tb_product com kind='S' (serviço não tem tb_merchandise/tb_stock)
// 409 CATEGORY_NOT_SYNCED
```

### POST /price-list/sincronize (Onda 3 — id local)
```jsonc
{ "id": 3, "description": "VAREJO", "validity": "2026-12-31", "modality": "V",
  "aliqProfit": 30, "published": "S", "deleted": "N" }
```

### POST /price/sincronize (Onda 3 — chave composta)
```jsonc
{ "priceListId": 3, "productId": 501, "priceTag": 9.9, "aliqProfit": 30,
  "aliqKickback": 2.5, "quantity": 1, "deleted": "N" }
// 409: PRICE_LIST_NOT_SYNCED / PRODUCT_NOT_SYNCED (reenvio no próximo ciclo)
```

### POST /stock-list/sincronize (Onda 3 — id local)
```jsonc
{ "id": 1, "description": "PRINCIPAL", "main": "S", "active": "S", "kind": null, "terminal": 0, "deleted": "N" }
```

### POST /stock-balance/sincronize (Onda 3 — tb_stock_balance própria)
```jsonc
{ "stockListId": 1, "merchandiseId": 501, "quantity": 42, "minimum": 5, "deleted": "N" }
// 409: STOCK_LIST_NOT_SYNCED / MERCHANDISE_NOT_SYNCED
```

### POST /promotion/sincronize (Onda 3 — id local + itens snapshot)
```jsonc
{ "id": 7, "description": "QUEIMA", "priceTag": 5.5, "quantity": 10, "active": "S",
  "oper": "V", "deleted": "N", "items": [{ "productId": 501, "oper": "V", "deleted": "N" }] }
// items presente = SNAPSHOT (itens fora da lista viram deleted='S'); 409 PRODUCT_NOT_SYNCED
```

### POST /financial-plans/sincronize (Onda 3 — id local + árvore ÚNICA)
```jsonc
{ "id": 12, "description": "DESPESAS", "parentId": 0, "source": "C", "kind": "C",
  "cluster": "S", "active": "S", "deleted": "N" }
// source=Natureza C/D · kind=Tipo C(usto)/R(esultado) · cluster=Nível S(intética)/A(nalítica)
// posit_level recalculado no servidor; 409 PARENT_NOT_SYNCED; mover pai move a subárvore
```

### POST /payment-type/sincronize (Onda 3 — catálogo central + attrs do vínculo)
```jsonc
{ "description": "CARTAO CREDITO", "idNfce": "03", "enable": "S", "appMobile": "N",
  "blockForCustomerBlocked": "N", "blockForCustomerNoLimit": "N", "maxParcels": 12,
  "tef": "N", "deleted": "N" }
```
`idNfce` só entra na CRIAÇÃO da linha central. Atributo AUSENTE não sobrescreve a
configuração web do vínculo. `deleted:'S'` → `enable='N'` no vínculo.
Tolerância ao legado (decisão Valdo 2026-08-01): flags e `idNfce` vazios ('') contam
como AUSENTES; `maxParcels` 0 → **fallback 1** (a web consome parcelas — espelho de 0
quebraria o uso).

### POST /customer/sincronize (Onda 4 — cadeia + papel + fiscal)
```jsonc
{
  // ... bloco entity padrão (ver acima) ...
  "customer": {
    "salesmanDocument": "52998224725",     // CPF/CNPJ do vendedor → 409 SALESMAN_NOT_SYNCED se ausente
    "carrierDocument": "11222333000181",   // idem transportador → 409 CARRIER_NOT_SYNCED
    "creditStatus": "L", "creditValue": 1000,
    "paymentTypeDescription": "CARTEIRA",  // → catálogo central (wallet do legado)
    "multiplier": 1, "active": "S"
  },
  "entityTax": {                           // opcional — tb_entity_tax (fiscal por relação comercial)
    "consumer": "S", "taxRegime": null, "byPassSt": "N", "indIeDest": "1",
    "issExigibilidade": null, "issProcessNr": null, "issRetido": "N", "issIndIncFiscal": "N",
    "autoSendInvoice": "N", "autoSendInvoiceJustXml": "N"   // CLI_ENVEMAILAUT/CLI_ENVSOMENTEXML ganham casa
  },
  "deleted": "N"
}
// → { ok, id (entity.id), externalCode? }
```
**Revisão de entidades (decisão 4, 2026-07-25)**: os 409 `SALESMAN_NOT_SYNCED`/
`CARRIER_NOT_SYNCED` verificam o PAPEL no schema do cliente (`tb_salesman`/
`tb_carrier` com deleted='N'), não só a existência da entity na central.

### POST /provider/sincronize (Onda 4)
```jsonc
{ /* bloco entity padrão */ "provider": { "active": "S" }, "deleted": "N" }
```

### POST /carrier/sincronize (Revisão de entidades — decisão 4, 2026-07-25)
```jsonc
{ /* bloco entity padrão */ "carrier": { "active": "S" }, "deleted": "N" }
```
Transportadora — mesmo padrão do provider (cadeia central + papel `tb_carrier`).
Sincronizar ANTES do customer: sem ela o `carrierDocument` do cliente ficava em
409 `CARRIER_NOT_SYNCED` eterno (a classe Delphi `TCarrierSendWeb` não existia).
Delphi: `TB_TRANSPORTADORA` (TRP_CODEMP = EMP_CODIGO), seed Seq 38.

### POST /user/sincronize (Indexação de usuários — 8 decisões, 2026-07-26)
```jsonc
{ /* bloco entity padrão */ "user": { "active": "S" }, "deleted": "N" }
// → { ok: true, id, externalCode?, clearExternalCode? }  (id = entity.id = tb_user.id)
```
Usuário do legado (TB_USUARIO) = AUTOR das operações. Grava na CENTRAL: cadeia
pelo motor + `tb_user` **SEM credencial** (`password NULL`, `active='N'` — nunca
loga; criado só se não existe, credencial de usuário web real NUNCA é tocada) +
`tb_institution_has_user` com `kind='SYNC'` (`active` = USU_ATIVO; deleted vai no
VÍNCULO, nunca na entity — ex-funcionário sincroniza). Cascata no Delphi
(`TUserSendWeb`, seed Seq 39 — perfil PDV desliga): CPF/CNPJ válido do colaborador
vinculado → documento; sem doc → reusa `TB_COLABORADOR.EXTERNALCODE` (vazio =
segura o ciclo); sem colaborador → `TB_USUARIO.EXTERNALCODE` próprio (write-back).
Deve sincronizar antes dos movimentos — eles referenciam o autor no bloco `user`:
```jsonc
"user": { "userDocument": "52998224725" }      // OU
"user": { "userExternalCode": "uuid-v4" }      // exatamente UM dos dois
// 409 USER_NOT_SYNCED quando a referência não resolve (auto-heal no próximo ciclo)
// bloco AUSENTE = fallback de transição (pedidos: menor usuário; caixa: NULL; extrato: 0)
```

### POST /salesman/sincronize (Onda 4 — precedência Collaborator→Salesman)
```jsonc
{
  // ... bloco entity padrão ...
  "collaborator": { "active": "S", "dtAdmission": "2020-01-01", "dtResignation": null,
    "salary": 3000, "fathersName": "...", "mothersName": "...", "voteNumber": "...",
    "voteZone": "...", "voteSection": "...", "militaryCertificate": "...", "pis": "..." },
  "salesman": { "active": "S", "aliqKickback": 2.5, "kickbackProduct": "S", "flexValue": 0 },
  "deleted": "N"
}
```
Grava `tb_collaborator` SEMPRE + `tb_salesman` quando o bloco vem (precedência obrigatória).
E-mail deixou de ser obrigatório (o legado descartava colaborador sem e-mail).
Fix do bug C5: o contrato novo traz fones na lista `phones` (kinds distintos FONE/CELULAR).

### POST /bank-account/sincronize (Onda 4 — id local + banco FEBRABAN)
```jsonc
{ "id": 3, "bankNumber": "001", "dtOpening": "2020-01-15", "agency": "1234", "agencyDv": "5",
  "number": "98765", "numberDv": "0", "phone": "6233330000", "manager": "FULANO",
  "limitValue": 50000, "dtContract": "2025-01-01", "deleted": "N" }
// 409 BANK_NOT_FOUND se o número FEBRABAN não estiver na central (seed sql/17)
// Substitui o fluxo do bug C1 (payload vazio) — data object novo envia tudo
```

### POST /invoice/sincronize (Onda 5 — nota avulsa, id local)
```jsonc
{ "id": 77, "terminal": 1, "issuer": "S", "kindEmis": "EM", "finality": "1",
  "number": "000123", "serie": "1", "cfopId": "5102",
  "entityDocument": "11222333000181", "dtEmission": "2026-07-19",
  "value": 150.5, "model": "55", "note": null, "status": "A", "deleted": "N" }
// → { ok: true, id: 77 }  (PK tb_invoice: id+institution+terminal)
```
`id` = NFL_CODIGO ✅. `entityDocument` (destinatário — ou EMITENTE quando
`issuer:'N'`, obrigatório nesse caso) → entity.id da central; ausente =
**409 `ENTITY_NOT_SYNCED`**. `issuer:'S'` = a própria institution emite (coluna
int grava institutionId — padrão service-orders); `'N'` grava o entity.id do
terceiro. `cfopId` = o próprio código CFOP (id varchar de setes_central.tb_cfop)
— **desconhecido = AUTO-CRIADO com descrição placeholder** (1ª rodada real 2026-07-27:
a referência estava vazia e o 409 CFOP_NOT_FOUND barrou 1.384 notas; CFOP virou catálogo
iniciado pelo cliente — a tela de CFOPs do Super enriquece; descrição vinda do legado =
Rodada 4). `number` aceita VAZIO/ausente → NULL (nota ainda não autorizada; reenvio
atualiza). Sem entityDocument → tb_entity_id = 0 (NFC-e consumidor). `status` default
'A'. **Nota avulsa fica SEM ramo** (notas M×S/D3: NFL_TIPO 'EM' = entrada manual sem
itens — a nota genérica não tem natureza).

### POST /invoice-merchandise/sincronize (Onda 5; reescrito nas notas M×S 2026-07-26 — D1/D3)
```jsonc
{ /* payload do /invoice */
  "merchandise": { "dtExit": "2026-07-26", "tmExit": "14:30:00", "baseIcmsValue": 0, "icmsValue": 0,
                   "baseIcmsStValue": 0, "icmsStValue": 0, "totalValue": 19.8, "freightValue": 0,
                   "insuranceValue": 0, "expensesValue": 0, "ipiValue": 0, "discountValue": 0,
                   "totalQtty": 3, "indPres": 1 } }
// 409: ORDER_NOT_SYNCED + os do /invoice
```
**Vínculo nota×pedido = a PRÓPRIA PK (D1)**: id = NFL_CODIGO = tb_order.id — o pedido precisa
existir com o MESMO id. A antiga pendência "coluna tb_order_id" MORREU por construção.
`orderId` legado (PED_CODIGO) é aceito e IGNORADO (transição). Grava tb_invoice **E o ramo
`tb_invoice_merchandise`** — a natureza da nota é a PRESENÇA do ramo (D3); nota CONJUGADA =
os dois ramos no mesmo id.
**RODADA 2 (D10)**: FORA do catálogo do Delphi — o processo completo viaja pelos /order-*
(bloco `invoice`). Este endpoint permanece na web como canal de NOTA ISOLADA (reenvio avulso).

### POST /invoice-service/sincronize (notas M×S, 2026-07-26 — nota de SERVIÇO, D1/D3)
```jsonc
{ /* payload do /invoice (sem model — NFS-e não tem modelo SEFAZ) */
  "service": { "totalValue": 80 } }    // NFL_VL_TL_SRV
// 409: ORDER_NOT_SYNCED + os do /invoice
```
Grava tb_invoice + ramo `tb_invoice_service` (mínimo: total_value). RPS/lote/protocolo NÃO
passam aqui — vivem no /invoice-return-service (D4). Mesmo vínculo pela PK (D1).
**RODADA 2 (D10)**: FORA do catálogo do Delphi — o processo completo de serviço viaja pelo
/order-service (bloco `invoice`). Permanece na web como canal de NOTA ISOLADA.

### POST /stock-statement/sincronize (Onda 5 — id local)
```jsonc
{ "id": 4501, "terminal": 1, "orderId": 3021, "orderItemId": 2, "stockListId": 1,
  "merchandiseId": 501, "local": "DEPOSITO", "kind": "VENDA",
  "dtRecord": "2026-07-19", "direction": "S", "quantity": 3.5,
  "operation": "SAIDA POR VENDA", "note": null, "deleted": "N" }
// 409: MERCHANDISE_NOT_SYNCED · ORDER_NOT_SYNCED (orderId > 0 informado)
```
`id` = CET_CODIGO ✅. Trigger `after_stock_statement_insert` mantém
tb_stock_balance (só no INSERT — reenvio cai no UPDATE, não redispara).
⚠️ ACHADO: PK física é só `id` (auto_increment) — upsert manual confere
id+institution+terminal para não colidir entre institutions.

### POST /cashier/sincronize (Onda 5 — id local)
```jsonc
{ "id": 91, "terminal": 1, "dtRecord": "2026-07-19",
  "hrBegin": "2026-07-19 08:00:00", "hrEnd": "2026-07-19 18:12:00", "deleted": "N",
  "user": { "userDocument": "52998224725" } }
// → { ok: true, id: 91 }  (PK id+institution+terminal)
// 409 USER_NOT_SYNCED (bloco user presente e não resolvido)
```
Bloco `user` opcional resolve o autor (2026-07-26, decisão 6); AUSENTE →
`tb_user_id` NULL (comportamento anterior). O contrato antigo com `items`
(tb_cashier_items) foi REMOVIDO — fechamento por forma de pagamento entra em
endpoint próprio na onda de movimento financeiro.

### POST /order-sale/sincronize (Onda 5 — pedido de venda completo)
```jsonc
{
  "id": 1001, "terminal": 0, "deleted": "N",          // id = PED_CODIGO ✅
  "order": { "dtRecord": "2026-07-19", "note": "...", "status": "A", "origin": "D" },
  "sale":  { "number": 55, "customerDocument": "11222333000181", "salesmanDocument": "52998224725" },
  "items": [ { "id": 1, "productId": 501, "quantity": 2, "unitValue": 9.9,
               "discountAliquot": 0, "discountValue": 0, "stockListId": 1, "priceListId": 3 } ],
  "totalizer": { "itemsQtde": 1, "productQtde": 2, "productValue": 19.8, "ipiValue": 0,
                 "discountAliquot": 0, "discountValue": 0, "expensesValue": 0, "totalValue": 19.8 },
  "billing": { "paymentTypeDescription": "DINHEIRO", "plots": "1", "deadline": "30" },
  "user": { "userDocument": "52998224725" },         // AUTOR (PED_CODUSU reindexado)
  "invoice": {                                       // RODADA 2 (D9/D10): objeto COMPLETO —
    "kindEmis": "SE", "number": "000124", "serie": "1", "cfopId": "5102",   // a nota do
    "entityDocument": "11222333000181", "dtEmission": "2026-07-26",         // processo na
    "value": 19.8, "model": "55", "status": "A", "issuer": "S",             // MESMA transação
    "merchandise": { "totalValue": 19.8, "discountValue": 0, "indPres": 1, "totalQtty": 2 } }
}
// 409: CUSTOMER_NOT_SYNCED · SALESMAN_NOT_SYNCED · PRODUCT_NOT_SYNCED ·
//      USER_NOT_SYNCED · INSTITUTION_USER_NOT_FOUND (fallback sem usuário)
```
Transação única: tb_order + sale + itens kind 'Sale' (+ item_merchandise quando o item
traz stockListId) + totalizer + billing. `items` = snapshot **ESCOPADO por kind='Sale'**
(notas M×S: nunca toca itens 'Service'). Cliente/vendedor por DOCUMENTO com papel
verificado no schema (D3/D13).
**Papéis-SENTINELA (opção b — decisão Valdo 2026-08-03)**: `customerDocument`/
`salesmanDocument` AUSENTES, zerados ou inválidos (venda balcão do legado — a Pipoteca
tinha ~69k vendas assim, travando TODO o financeiro em cascata) resolvem para papéis
autocriados por institution: cliente **CONSUMIDOR FINAL** e vendedor **VENDEDOR PADRAO**
(entity 'N' sem doc + papel no schema; `resolveSentinelRole` no sync.entity, idempotente
por NOME + entity sem-documento — homônimo real COM documento nunca é confundido).
Precedente: forma "Carteira" autocreate. Complemento futuro (opção a): referência por
externalCode para cliente sem-doc IDENTIFICADO — exige contrato + Delphi.
**Id (D1 — notas M×S, 2026-07-26)**: o id enviado é o **NFL_CODIGO** da nota do pedido
(a projeção `nfl_codigo AS PED_CODIGO` do legado já fazia isso) — a nota mista vincula
todo o processo: tb_order.id = tb_invoice.id = orderId do financeiro.
**D13 (2026-07-27)**: este endpoint recebe vendas PURAS (nota sem itens de serviço);
o pedido CONJUGADO entra INTEIRO pelo /order-service (blocos sale+saleItems lá).
Autor (2026-07-26): bloco `user` → tb_user_id real; AUSENTE → fallback de transição
(menor usuário do institution). No reenvio, tb_user_id só é atualizado quando o
bloco veio — o fallback nunca sobrescreve um autor real.

### POST /order-service/sincronize (notas M×S — ORDEM DE SERVIÇO COMPLETA, D1/D6/D13)
```jsonc
{
  "id": 1001, "terminal": 0, "deleted": "N",          // id = NFL_CODIGO (D1)
  "order": { "dtRecord": "2026-07-26", "note": null, "status": "A", "origin": "D" },
  "service": { "number": 55, "customerDocument": "11222333000181" },   // ramo serviço (sem vendedor)
  "items": [ { "id": 2, "productId": 501, "quantity": 1, "unitValue": 80,
               "discountAliquot": 0, "discountValue": 0 } ],           // itens SERVIÇO (sem stockList)
  "sale":      { "number": 55, "salesmanDocument": "52998224725" },    // D13: CONJUGADA — ramo venda
  "saleItems": [ { "id": 1, "productId": 502, "quantity": 2, "unitValue": 9.9,
                   "stockListId": 1, "priceListId": 3 } ],             // D13: itens MERCADORIA (kind Sale)
  "totalizer": { ... }, "billing": { ... }, "user": { ... }            // idênticos ao /order-sale
}
// 409: CUSTOMER_NOT_SYNCED · SALESMAN_NOT_SYNCED · PRODUCT_NOT_SYNCED · USER_NOT_SYNCED
```
**D13 (2026-07-27): a ordem CONJUGADA entra INTEIRA por aqui** — `sale`+`saleItems`
presentes = grava também tb_order_sale + itens kind 'Sale' (+item_merchandise); o
/order-sale fica para vendas PURAS (nota sem itens de serviço — filtros DISJUNTOS no
Delphi). Ramo `tb_order_service` (number, tb_customer_id, open_lock NULL) + itens kind
'Service'. Snapshots ESCOPADOS por kind (Service × Sale independentes). Totalizer/billing
ÚNICOS do pedido. deleted='S' derruba TODOS os ramos e itens (a conjugada é deste endpoint).
**RODADA 2 (D9/D10)**: aceita bloco `invoice` (campos do /invoice sem id/terminal/deleted +
sub-bloco `service: { totalValue }` = NFL_VL_TL_SRV; **na conjugada, sub-bloco
`merchandise` junto — presença = a nota também é de mercadoria**) — nota gravada na MESMA
transação. Os /order-purchase e /order-stock-adjust também têm o bloco `invoice` (com
sub-bloco `merchandise`; na compra, issuer='N' e entityDocument = fornecedor).
**invoice.number da nota de SERVIÇO (decisão Valdo 2026-08-01/02)**: NFL_NUMERO é número
de nota de MERCADORIA — para serviço é SEMPRE vazio. O número da NFS-e vem DIRETO do
retorno: `TB_RETORNO_NFS.NFS_NUMERO` via `NFS_CODNFL = NFL_CODIGO` (Delphi
`DM.GetNfsNumero` em TInvoiceServiceSendWeb, semântica de LEFT JOIN — achou usa; na
conjugada, NFL_NUMERO preenchido pela NF-e da parte mercadoria é preservado quando não há
retorno). **Sem retorno, number fica EM BRANCO e a web grava NULL** (invoiceBody.number
nullish + '' → NULL no upsert — o reenvio pós-autorização atualiza; nada de 400).
Bancos sem NFS-e (ex.: Pipoteca, sem serviço) nunca acionam a classe.

### POST /order-purchase/sincronize (Onda 5)
```jsonc
{ "id": 2001, "terminal": 0, "deleted": "N", "order": { },
  "purchase": { "number": 12, "providerDocument": "11222333000181", "approved": "S" },
  "items": [ { "id": 1, "productId": 501, "quantity": 10, "unitValue": 5.5 } ],
  "totalizer": { }, "user": { "userExternalCode": "uuid-v4" } }
// itens kind 'Purchase'; 409 PROVIDER_NOT_SYNCED · PRODUCT_NOT_SYNCED · USER_NOT_SYNCED
```

### POST /order-stock-adjust/sincronize (Onda 5)
```jsonc
{ "id": 3001, "terminal": 0, "deleted": "N", "order": { },
  "adjust": { "number": 3, "entityDocument": "52998224725", "direction": "E" },
  "items": [ { "id": 1, "productId": 501, "quantity": 3, "unitValue": 0 } ],
  "user": { "userDocument": "52998224725" } }
// itens kind 'Adjust'; entityDocument OPCIONAL (ausente → tb_entity_id = 0 sentinela)
// bloco user opcional (409 USER_NOT_SYNCED quando presente e não resolvido)
```

### POST /financial/sincronize (Onda 5 — formato NOVO 5.5, semântica de ESPELHO)
```jsonc
{
  "orderId": 1001, "terminal": 0, "parcel": 1,        // PK NATURAL — FIN_CODIGO não viaja
  "dtExpiration": "2026-08-19", "tagValue": 19.8,
  "paymentTypeDescription": "DINHEIRO", "deleted": "N",
  "kind": "R",                                        // FIN_TIPO cru (D1 2026-08-03): 1ª letra R/P
  "number": "DUP-1001/1",                             // FIN_NUMERO (D3) — nº do documento da bill
  "payment": {                                        // presente = baixa espelhada
    "paidValue": 19.8, "dtPayment": "2026-07-19", "dtRealPayment": null,
    "interestValue": 0, "lateValue": 0, "discountAliquot": 0,
    "settledCode": 7, "financialPlansId": 12
  }
}
// 409: ORDER_NOT_SYNCED · FINANCIAL_PLAN_NOT_SYNCED
```
**SEMÂNTICA DE ESPELHO** (decisão da revisão): o financeiro novo é imutável por
eventos (N/E/R), mas o Firebird só conhece o ESTADO ATUAL — a baixa entra como
evento 1 status 'N' via upsert; histórico de estornos do legado NÃO viaja.
A imutabilidade plena vale para eventos nascidos na web.
**BILL 1:1 no espelho (decisões do Valdo 2026-08-03, revisadas no mesmo dia)**:
sem a `tb_financial_bills` o título é INVISÍVEL ao módulo de baixas da web
(INNER JOIN na listagem e na baixa). O /financial grava a bill na MESMA
transação, mesma PK natural. **ESPELHO FIEL: kind = FIN_TIPO COMO ESTÁ**
(RA/RM/PA/PM — a 1ª ideia RL/PL foi descartada pelo Valdo: a rotina de
parcerias do settlements que RA/RM dispara só roda em baixa FEITA PELA WEB e é
guiada por dados — sem parceria cadastrada é no-op; e kind inventado escaparia
dos filtros das telas). Direção (operation C receber × D pagar) pela 1ª letra;
payload sem kind (pré-patch Delphi) → fallback pelo pedido (tb_order_purchase =
P; senão R), gravado como RM/PM e corrigido no reenvio pós-compilação;
`number` = FIN_NUMERO, fallback `orderId-parcela`; situation/stage 'N' (estado
pago×aberto deriva dos payments, não da bill). Backfill = limpar SRC_LOG +
rebobinar LAST_UPDATE da TB_FINANCEIRO (upsert idempotente).

### POST /financial-statement/sincronize (Onda 5 — id local)
```jsonc
{ "id": 4501, "terminal": 0, "bankAccountId": 3, "dtRecord": "2026-07-19",
  "bankHistoricId": null, "creditValue": 19.8, "debitValue": 0, "manualHistory": "...",
  "kind": "C", "settledCode": 7, "future": "N", "dtOriginal": null, "docReference": "...",
  "conferred": "N", "paymentTypeDescription": "DINHEIRO",
  "financialPlansIdCre": 0, "financialPlansIdDeb": 0, "deleted": "N",
  "user": { "userDocument": "52998224725" } }
// 409 BANK_ACCOUNT_NOT_SYNCED (só se bankAccountId informado); ausente → 0 (sentinela)
// status 'N' e id_origin NULL (espelho); autor via bloco user (MVF_CODUSU) —
// ausente → tb_user_id = 0 · 409 USER_NOT_SYNCED quando presente e não resolvido
```

### POST /invoice-return-55/sincronize (Onda 6 — id local)
```jsonc
{ "id": 401, "terminal": 0, "number": "000123", "serie": "1", "statusCode": 100,
  "fileName": "chave-nfe.xml", "motive": "Autorizado o uso da NF-e", "deleted": "N" }
// statusCode INT (100 autorizada, 135 cancelada...); fileName = elo com o /filexml
```

### POST /invoice-return-65/sincronize (Onda 6 — NFC-e)
```jsonc
{ "id": 402, "terminal": 0, "number": "000200", "serie": "1", "nrLot": 7,
  "synchronous": "S", "emissiType": "1", "formatType": "1", "presenIndi": "1",
  "statusCode": 100, "fileName": "chave-nfce.xml", "motive": null, "deleted": "N" }
```

### POST /invoice-return-service/sincronize (Onda 6 — NFS-e; era o bug C3)
```jsonc
{ "id": 403, "terminal": 0, "number": "55", "nrRps": 55, "nrLot": 7,
  "protocol": "PROT...", "codeVerif": "ABC123", "kind": "H", "synchronous": "S",
  "statusCode": 200, "fileName": "rps.xml", "motive": null, "deleted": "N" }
// A TInvoiceReturnServiceSendWeb estava COMENTADA no Delphi — reativar (patch C3)
// nrRps/nrLot/statusCode são INT (0 = sem valor)
```

### POST /filexml/sincronize (Onda 6 — arquivo em DISCO, D9/D20)
```jsonc
{ "fileName": "35260711222333000181-nfe.xml",   // sem caminhos ([A-Za-z0-9._-])
  "contentBase64": "PD94bWwg...",                // conteúdo COMPLETO (fim do bug C7)
  "dtReference": "2026-07-19" }                  // define <ano>/<mes> da pasta
// Grava em SYNC_FILES_ROOT/<cnpj-da-institution>/<ano>/<mes>/<fileName>
// CNPJ resolvido pela API key (institution → tb_company.cnpj); id devolvido = 0
```
