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
— desconhecido = **409 `CFOP_NOT_FOUND`**. Sem entityDocument → tb_entity_id = 0
(NFC-e consumidor). `status` default 'A'.

### POST /invoice-merchandise/sincronize (Onda 5 — nota vinculada a pedido)
```jsonc
{ /* payload idêntico ao /invoice */ "orderId": 3021 }
// 409: ORDER_NOT_SYNCED (tb_order id+institution+terminal) + os do /invoice
```
⚠️ ACHADO Onda 5: **tb_invoice NÃO tem coluna de pedido** — `orderId` é apenas
VALIDADO (pedido precisa existir) e a nota gravada SEM vínculo persistido.
Persistir nota×pedido = decisão de DDL futura.

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
  "hrBegin": "2026-07-19 08:00:00", "hrEnd": "2026-07-19 18:12:00", "deleted": "N" }
// → { ok: true, id: 91 }  (PK id+institution+terminal)
```
`tb_userid` fica NULL (usuário local do Firebird não viaja — D3). O contrato
antigo com `items` (tb_cashier_items) foi REMOVIDO — fechamento por forma de
pagamento entra em endpoint próprio na onda de movimento financeiro.

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
  "billing": { "paymentTypeDescription": "DINHEIRO", "plots": "1", "deadline": "30" }
}
// 409: CUSTOMER_NOT_SYNCED · SALESMAN_NOT_SYNCED · PRODUCT_NOT_SYNCED · INSTITUTION_USER_NOT_FOUND
```
Transação única: tb_order + sale + itens kind 'Sale' (+ item_merchandise quando o item
traz stockListId) + totalizer + billing. `items` = snapshot. Cliente/vendedor por
DOCUMENTO com papel verificado no schema (D3/D13).
⚠️ `tb_order.tb_user_id` é NOT NULL (FK central) — fallback: menor usuário vinculado
ao institution; sem usuário → 409 (decisão definitiva na Rodada 4).

### POST /order-purchase/sincronize (Onda 5)
```jsonc
{ "id": 2001, "terminal": 0, "deleted": "N", "order": { },
  "purchase": { "number": 12, "providerDocument": "11222333000181", "approved": "S" },
  "items": [ { "id": 1, "productId": 501, "quantity": 10, "unitValue": 5.5 } ],
  "totalizer": { } }
// itens kind 'Purchase'; 409 PROVIDER_NOT_SYNCED · PRODUCT_NOT_SYNCED
```

### POST /order-stock-adjust/sincronize (Onda 5)
```jsonc
{ "id": 3001, "terminal": 0, "deleted": "N", "order": { },
  "adjust": { "number": 3, "entityDocument": "52998224725", "direction": "E" },
  "items": [ { "id": 1, "productId": 501, "quantity": 3, "unitValue": 0 } ] }
// itens kind 'Adjust'; entityDocument OPCIONAL (ausente → tb_entity_id = 0 sentinela)
```

### POST /financial/sincronize (Onda 5 — formato NOVO 5.5, semântica de ESPELHO)
```jsonc
{
  "orderId": 1001, "terminal": 0, "parcel": 1,        // PK NATURAL — FIN_CODIGO não viaja
  "dtExpiration": "2026-08-19", "tagValue": 19.8,
  "paymentTypeDescription": "DINHEIRO", "deleted": "N",
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

### POST /financial-statement/sincronize (Onda 5 — id local)
```jsonc
{ "id": 4501, "terminal": 0, "bankAccountId": 3, "dtRecord": "2026-07-19",
  "bankHistoricId": null, "creditValue": 19.8, "debitValue": 0, "manualHistory": "...",
  "kind": "C", "settledCode": 7, "future": "N", "dtOriginal": null, "docReference": "...",
  "conferred": "N", "paymentTypeDescription": "DINHEIRO",
  "financialPlansIdCre": 0, "financialPlansIdDeb": 0, "deleted": "N" }
// 409 BANK_ACCOUNT_NOT_SYNCED (só se bankAccountId informado); ausente → 0 (sentinela)
// status 'N' e id_origin NULL (espelho); tb_user_id = 0
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
