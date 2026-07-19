# Prompt — Semana 4: Endpoints Reais de Sincronização
**Escopo**: setes

## Contexto do projeto

O projeto `setes-api` está rodando com Node.js + TypeScript + Express.
A infraestrutura de sync da Semana 3 já existe:
- `src/modules/sync/sync.auth.middleware.ts` — valida X-Api-Key, resolve schema
- `src/modules/sync/sync.queue.ts` — fila em memória para lotes grandes
- `src/modules/sync/sync.repository.ts` — upsert genérico e pull por updated_at
- `src/modules/sync/sync.routes.ts` — rotas genéricas /sync/push e /sync/pull
- `src/modules/sync/sync.service.ts` — lógica de push/pull genérica

Agora vamos criar os **endpoints reais e específicos** que o Sincronizador Delphi
vai consumir, dentro do mesmo módulo `sync`, sem alterar a infraestrutura existente.

---

## Regras globais obrigatórias para TODOS os endpoints

### 1. Resposta padrão (compatibilidade com o Sincronizador Delphi)

Todos os endpoints devem retornar HTTP 200 sempre, inclusive em erros.
O campo `id` no JSON indica sucesso ou falha:

```typescript
// Sucesso
{ "id": 200, "code": <tb_institution_id>, "message": "SAVED" }

// Erro
{ "id": 500, "code": 0, "message": "<mensagem do erro>" }
```

Crie um helper compartilhado para isso:

```typescript
// src/modules/sync/sync.response.ts

export function syncSuccess(institutionId: number, message = 'SAVED') {
  return { id: 200, code: institutionId, message }
}

export function syncError(message: string) {
  return { id: 500, code: 0, message }
}
```

### 2. Autenticação

Todos os endpoints usam `syncAuthMiddleware` (X-Api-Key).
O `req.syncClient.schemaName` identifica o schema MySQL do cliente.
O `tb_institution_id` vem sempre no body — é o ID do estabelecimento dentro do schema.

### 3. Sem DELETE físico

Nunca implementar delete físico. Registros são desativados via campo `active='N'`
ou `deleted='S'` conforme o padrão da tabela. Se o Delphi enviar uma operação
de remoção, apenas marcar como inativo.

### 4. Geração de ID

Usar `MAX(id) + 1 WHERE tb_institution_id = ?` em transação (SELECT FOR UPDATE)
para evitar race condition. Nunca usar AUTO_INCREMENT do MySQL para IDs de negócio.

Crie um helper:

```typescript
// src/modules/sync/sync.id-generator.ts
import { PoolConnection } from 'mysql2/promise'

export async function nextId(
  conn: PoolConnection,
  tableName: string,
  institutionId: number
): Promise<number> {
  const [rows] = await conn.query<any[]>(
    `SELECT COALESCE(MAX(id), 0) + 1 AS next_id
     FROM \`${tableName}\`
     WHERE tb_institution_id = ?
     FOR UPDATE`,
    [institutionId]
  )
  return rows[0].next_id
}

export async function nextGlobalId(
  conn: PoolConnection,
  tableName: string
): Promise<number> {
  const [rows] = await conn.query<any[]>(
    `SELECT COALESCE(MAX(id), 0) + 1 AS next_id FROM \`${tableName}\` FOR UPDATE`
  )
  return rows[0].next_id
}
```

### 5. Normalização de datas

O Delphi envia datas em `DD/MM/YYYY HH:MM:SS` ou `YYYY-MM-DD HH:MM:SS`.
Datas inválidas devem ser convertidas para `1900-01-01 01:00:00`.

Crie um helper:

```typescript
// src/modules/sync/sync.date.ts
import { parse, isValid, format } from 'date-fns'

const FALLBACK = '1900-01-01 01:00:00'
const OUTPUT   = 'yyyy-MM-dd HH:mm:ss'

export function normalizeDate(value: string | null | undefined): string {
  if (!value) return FALLBACK

  // Tenta formato brasileiro DD/MM/YYYY HH:MM:SS
  let d = parse(value, 'dd/MM/yyyy HH:mm:ss', new Date())
  if (isValid(d)) return format(d, OUTPUT)

  // Tenta formato MySQL YYYY-MM-DD HH:MM:SS
  d = parse(value, 'yyyy-MM-dd HH:mm:ss', new Date())
  if (isValid(d)) return format(d, OUTPUT)

  // Tenta só a data DD/MM/YYYY
  d = parse(value, 'dd/MM/yyyy', new Date())
  if (isValid(d)) return format(d, OUTPUT)

  return FALLBACK
}
```

Instale: `npm install date-fns`

### 6. Lookup por descrição (findOrCreate)

Vários endpoints precisam resolver IDs por descrição (marca, embalagem,
forma de pagamento, banco). Use sempre transação para evitar duplicatas:

```typescript
// src/modules/sync/sync.lookup.ts
import { PoolConnection } from 'mysql2/promise'
import { nextGlobalId, nextId } from './sync.id-generator'

export async function findOrCreateByDescription(
  conn: PoolConnection,
  tableName: string,
  description: string,
  institutionId?: number
): Promise<number> {
  const [rows] = await conn.query<any[]>(
    `SELECT id FROM \`${tableName}\` WHERE description = ? LIMIT 1`,
    [description]
  )
  if (rows.length) return rows[0].id

  const newId = institutionId
    ? await nextId(conn, tableName, institutionId)
    : await nextGlobalId(conn, tableName)

  await conn.query(
    `INSERT INTO \`${tableName}\` (id, description, created_at, updated_at)
     VALUES (?, ?, NOW(), NOW())`,
    [newId, description]
  )
  return newId
}

export async function findPaymentTypeByDescription(
  conn: PoolConnection,
  description: string,
  institutionId: number
): Promise<number> {
  // Busca na tabela global, fallback para 'CARTEIRA'
  const [rows] = await conn.query<any[]>(
    `SELECT id FROM tb_payment_types WHERE description = ? LIMIT 1`,
    [description || 'CARTEIRA']
  )
  if (rows.length) return rows[0].id

  // Cria se não existe
  return findOrCreateByDescription(conn, 'tb_payment_types', description || 'CARTEIRA')
}

export async function findBankByNumber(
  conn: PoolConnection,
  bankNumber: string
): Promise<number | null> {
  const [rows] = await conn.query<any[]>(
    `SELECT id FROM tb_bank WHERE number = ? LIMIT 1`,
    [bankNumber]
  )
  return rows.length ? rows[0].id : null
}
```

---

## Novos arquivos a criar

```
setes-api/
└── src/
    └── modules/
        └── sync/
            ├── sync.response.ts          (helper de resposta)
            ├── sync.id-generator.ts      (geração de ID sequencial)
            ├── sync.date.ts              (normalização de datas)
            ├── sync.lookup.ts            (findOrCreate por descrição)
            ├── endpoints/
            │   ├── bankaccount.ts
            │   ├── brand.ts
            │   ├── cashier.ts
            │   ├── category.ts
            │   ├── customer.ts
            │   ├── filexml.ts
            │   ├── financial.ts
            │   ├── financialplans.ts
            │   ├── financialstatement.ts
            │   ├── merchandise.ts
            │   ├── orderpurchase.ts
            │   ├── ordersale.ts
            │   ├── orderstockadjust.ts
            │   ├── package.ts
            │   ├── paymenttype.ts
            │   ├── price.ts
            │   ├── pricelist.ts
            │   ├── promotion.ts
            │   ├── provider.ts
            │   ├── restgroup.ts
            │   ├── restgrouphasattribute.ts
            │   ├── restgrouphasmeasure.ts
            │   ├── restgrouphasoptional.ts
            │   ├── restmenu.ts
            │   ├── restmenuhasingrediente.ts
            │   ├── restsubgroup.ts
            │   ├── salesman.ts
            │   ├── stockbalance.ts
            │   ├── stocklist.ts
            │   └── stockstatement.ts
            └── sync.specific.routes.ts   (registra todos os endpoints acima)
```

---

## Padrão de implementação de cada endpoint

Cada arquivo em `endpoints/` deve seguir este padrão:

```typescript
// endpoints/exemplo.ts
import { Router, Request, Response } from 'express'
import pool from '@shared/db/connection'
import { syncSuccess, syncError } from '../sync.response'
import { nextId } from '../sync.id-generator'
import { normalizeDate } from '../sync.date'
import logger from '@shared/logger/logger'

const router = Router()

router.post('/exemplo/sincronize', async (req: Request, res: Response) => {
  const conn = await pool.getConnection()
  try {
    await conn.beginTransaction()
    await conn.query(`USE \`${req.syncClient!.schemaName}\``)

    // lógica aqui

    await conn.commit()
    res.json(syncSuccess(req.body.tb_institution_id))
  } catch (err: any) {
    await conn.rollback()
    logger.error('Erro em /exemplo/sincronize', { err, client: req.syncClient })
    res.json(syncError(err.message))
  } finally {
    conn.release()
  }
})

export default router
```

**Regras do padrão:**
- Sempre `beginTransaction` + `commit` + `rollback` em catch
- Sempre `USE schema` no início da transação
- Sempre retornar `syncSuccess` ou `syncError` — nunca lançar exceção para fora
- Sempre liberar conexão no `finally`
- HTTP sempre 200

---

## Implementação de cada endpoint

### /bankaccount/sincronize

**Tabelas:** `tb_bank_account`, `tb_bank`, `tb_institution_has_bank`

Lógica:
1. Resolver `tb_bank_id` pelo número do banco via `findBankByNumber`
2. Verificar se conta existe: `SELECT id FROM tb_bank_account WHERE tb_bank_id=? AND agency=? AND number=?`
3. Se não existe: gerar próximo ID, inserir conta, inserir vínculo `tb_institution_has_bank`
4. Se existe: atualizar conta
5. Todos os campos DateTime: normalizar com `normalizeDate`

Campos de entrada:
```typescript
{
  id: number,
  tb_institution_id: number,
  NumeroBanco: string,        // lookup em tb_bank por number
  agency: string,
  agency_dv: string,
  number: string,
  number_dv: string,
  phone: string,
  manager: string,
  limit_value: number,
  dt_opening: string,         // normalizeDate
  dt_contract: string         // normalizeDate
}
```

---

### /brand/sincronize

**Tabelas:** `tb_brand`, `tb_institution_has_brand`

Lógica:
1. Se `Marca.id > 0`: buscar por id, fazer UPDATE
2. Se `Marca.id = 0`: buscar por description em `tb_brand`, criar se não existe (`nextGlobalId`)
3. Garantir registro ativo em `tb_institution_has_brand` (INSERT IGNORE ou UPDATE)

Campos de entrada:
```typescript
{
  tb_institution_id: number,
  Marca: {
    id: number,
    description: string
  }
}
```

---

### /cashier/sincronize

**Tabelas:** `tb_Cashier`, `tb_cashier_items`

Lógica:
1. Verificar existência: `SELECT id FROM tb_Cashier WHERE tb_institution_id=? AND terminal=? AND dt_record=?`
2. INSERT ou UPDATE em `tb_Cashier`
3. Para cada item em `items`: INSERT ou UPDATE em `tb_cashier_items`
4. Normalizar `dt_record`, `hr_begin`, `hr_end` com `normalizeDate`

Campos de entrada:
```typescript
{
  tb_institution_id: number,
  terminal: number,
  dt_record: string,
  tb_userid: number,
  hr_begin: string,
  hr_end: string,
  items: Array<{
    tb_payment_types_id: number,
    kind: string,
    tag_value: number
  }>
}
```

---

### /category/sincronize

**Tabelas:** `tb_category`

Lógica: upsert simples por `id` + `tb_institution_id`.
Se `id = 0`: gerar com `nextId`.

Campos de entrada:
```typescript
{
  id: number,
  tb_institution_id: number,
  description: string,
  posit_level: number,
  kind: string,
  Active: string              // 'S' ou 'N'
}
```

---

### /Customer/sincronize

**Tabelas:** `tb_entity`, `tb_person` ou `tb_company`, `tb_address[]`,
`tb_phone[]`, `tb_mailing`, `tb_social_media`, `tb_institution_has_entity`, `tb_customer`

Esta é a operação mais complexa. Implementar em cascata estrita:

1. **Salvar tb_entity**
   - Se `Cliente.id > 0`: verificar se existe em `tb_entity`, UPDATE ou INSERT
   - Se `Cliente.id = 0`: `nextGlobalId` para tb_entity, INSERT

2. **Salvar tb_person OU tb_company** (mesmo id de tb_entity)
   - Se CPF preenchido: salvar em `tb_person`
   - Se CNPJ preenchido: salvar em `tb_company`

3. **Salvar tb_address** (array — INSERT IGNORE por id + kind)

4. **Salvar tb_phone** (array — INSERT IGNORE por id + kind)

5. **Salvar tb_mailing** (email — INSERT IGNORE por id)

6. **Salvar tb_institution_has_entity** (INSERT IGNORE)

7. **Resolver vendedor por DocFiscalVendedor**
   - 11 dígitos = CPF → `SELECT tb_entity_id FROM tb_person WHERE cpf = ?`
   - 14 dígitos = CNPJ → `SELECT tb_entity_id FROM tb_company WHERE cnpj = ?`

8. **Salvar tb_customer** (upsert por id + tb_institution_id)

Campos de entrada:
```typescript
{
  tb_institution_id: number,
  Cliente: {
    id: number,
    tb_institution_id: number,
    tb_salesman_id: number,
    tb_carrier_id: number,
    credit_status: string,
    credit_value: number,
    wallet: number,
    consumer: string,
    active: string,
    multiplier: number,
    by_pass_st: string
  },
  Fiscal: {
    Entidade: {
      Registro: {
        id: number,
        name_company: string,
        nick_trade: string,
        aniversary: string,
        tb_line_business_id: number,
        note: string
      },
      Email: { email: string },
      ListaEndereco: Array<{
        street: string, nmbr: string, complement: string,
        neighborhood: string, region: string, kind: string,
        zip_code: string, tb_country_id: number,
        tb_state_id: number, tb_city_id: number, main: string
      }>,
      ListaFones: Array<{
        kind: string, contact: string, number: string, address_kind: string
      }>
    },
    Fisica: {
      cpf: string, rg: string, birthday: string,
      tb_profession_id: number
    },
    Juridica: {
      cnpj: string, ie: string, im: string, crt: number
    }
  },
  DocFiscalVendedor: string   // CPF (11 dígitos) ou CNPJ (14 dígitos)
}
```

---

### /filexml/sincronize

**Ação:** Salvar arquivo XML em disco no servidor

Lógica:
1. Criar pasta `FolderName` se não existir (dentro de um diretório base configurável via `.env`: `XML_STORAGE_PATH`)
2. Gravar `Content` (Base64 ou texto) no arquivo `FileName`
3. Se Base64: decodificar antes de salvar
4. Não salva no banco — apenas no sistema de arquivos

Adicione ao `.env`:
```
XML_STORAGE_PATH=./storage/xml
```

Campos de entrada:
```typescript
{
  FileName: string,
  FolderName: string,
  Content: string    // Base64 ou texto XML
}
```

---

### /financial/sincronize

**Tabelas:** `tb_financial`, `tb_financial_payment`

Lógica:
1. Resolver `tb_payment_types_id` via `findPaymentTypeByDescription(DescFormaPagamento)`
2. Upsert `tb_financial` por `id + tb_order_id + tb_institution_id + terminal`
3. Se `Pagamentos` presente: upsert `tb_financial_payment`
4. Normalizar todos os campos DateTime

Campos de entrada:
```typescript
{
  Financeiro: {
    id: number,
    tb_order_id: number,
    tb_institution_id: number,
    terminal: number,
    parcel: number,
    tag_value: number,
    dt_expiration: string,
    tb_payment_types_id: number,
    number: string,
    kind: string,          // 'R' = receber, 'P' = pagar
    situation: string,
    operation: string,
    stage: string,
    tb_financial_plans_id: number
  },
  Pagamentos: {
    interest_value: number,
    late_value: number,
    discount_value: number,
    discount_aliquot: number,
    paid_value: number,
    tb_payment_types_id: number,
    dt_payment: string,
    dt_real_payment: string,
    settled: string,
    tb_financial_plans_id: number,
    settled_code: number
  },
  DescFormaPagamento: string
}
```

---

### /financialplans/sincronize

**Tabelas:** `tb_financial_plans`

Lógica: upsert simples por `id + tb_institution_id`. Se `id = 0`: `nextId`.

---

### /financialStatement/sincronize

**Tabelas:** `tb_financial_statement`

Lógica:
1. Resolver `tb_payment_types_id` via `findPaymentTypeByDescription(DescFormaPagamento)`
2. Upsert por `id + tb_institution_id + terminal`
3. Se `id = 0`: `nextId`
4. Normalizar todos os campos DateTime

---

### /merchandise/sincronize

**Tabelas:** `tb_product`, `tb_merchandise`, `tb_stock`, `tb_brand`, `tb_package`,
`tb_institution_has_brand`, `tb_institution_has_package`

Lógica em cascata:
1. Resolver/criar marca via `findOrCreateByDescription('tb_brand', Marca.description)`
   e garantir vínculo em `tb_institution_has_brand`
2. Resolver/criar embalagem via `findOrCreateByDescription('tb_package', Embalagem.description)`
   e garantir vínculo em `tb_institution_has_package`
3. Upsert `tb_product` por `id` (global, sem institution_id)
4. Upsert `tb_merchandise` por `id + tb_institution_id` (mesmo id de tb_product)
5. Upsert `tb_stock` por `id + tb_institution_id + tb_stock_list_id`

Campos de entrada:
```typescript
{
  tb_institution_id: number,
  Produto: {
    id: number,
    description: string,
    tb_category_id: number,
    active: string
  },
  Mercadoria: {
    id: number,
    tb_institution_id: number,
    tb_product_id: number,
    tb_brand_id: number,
    tb_package_id: number,
    codebar: string,
    price_cost: number,
    active: string
  },
  Estoque: {
    tb_stock_list_id: number,
    codebar: string
  },
  Marca: { description: string },
  Embalagem: { description: string }
}
```

---

### /ordersale/sincronize

**Tabelas:** `tb_order`, `tb_order_sale`, `tb_order_item[]`,
`tb_order_totalizer`, `tb_order_billing`

Lógica em cascata (dentro de uma transação):
1. Se `DocFiscalVendedor` definido: resolver `tb_salesman_id` por CPF/CNPJ
2. Upsert `tb_order` por `id + tb_institution_id + terminal`
3. Upsert `tb_order_sale` por `id + tb_institution_id + terminal`
4. Para cada item em `Items`: upsert `tb_order_item` por `id + tb_order_id + tb_institution_id + terminal`
5. Upsert `tb_order_totalizer`
6. Upsert `tb_order_billing`
7. Resolver forma de pagamento por `FormaPagamento` (descrição)

**Nota:** Não implementar deleteAll — sem delete físico conforme regra global.

---

### /orderpurchase/sincronize

**Tabelas:** `tb_order`, `tb_order_purchase`, `tb_order_item[]`,
`tb_order_totalizer`, `tb_order_billing`

Mesma estrutura do ordersale, mas salva `tb_order_purchase` ao invés de `tb_order_sale`.

---

### /orderstockadjust/sincronize

**Tabelas:** `tb_order`, `tb_order_stock_adjust`, `tb_order_item[]`, `tb_order_totalizer`

Mesma estrutura, sem billing.

---

### /package/sincronize

**Tabelas:** `tb_package`, `tb_institution_has_package`

Igual ao brand — lookup por description, global, vínculo com institution.

---

### /paymentType/sincronize

**Tabelas:** `tb_payment_types`, `tb_institution_has_payment_types`

Lógica:
1. Upsert `tb_payment_types` por `id` (global)
2. Garantir vínculo em `tb_institution_has_payment_types` com campo `DisponivelApp`

---

### /price/sincronize

**Tabelas:** `tb_price`

Upsert por chave composta: `tb_institution_id + tb_price_list_id + tb_product_id`.

---

### /pricelist/sincronize

**Tabelas:** `tb_price_list`

Upsert por `id + tb_institution_id`. Normalizar `validity`.

---

### /Promotion/sincronize

**Tabelas:** `tb_promotion`, `tb_promotion_items`

Lógica:
1. Upsert `tb_promotion` por `id + tb_institution_id`
2. Para cada item: upsert `tb_promotion_items` por `tb_promotion_id + tb_institution_id + tb_product_id`

---

### /provider/sincronize

**Tabelas:** mesmas do Customer + `tb_provider`

Lógica igual ao Customer, mas salva `tb_provider` ao invés de `tb_customer`.
Não criar vínculo em `tb_institution_has_entity` (desativado no Delphi).

---

### /restgroup/sincronize

**Tabelas:** `tb_rest_group`

Upsert simples por `id + tb_institution_id`.

---

### /restgrouphasattribute/sincronize

**Tabelas:** `tb_rest_group_has_attribute`

Upsert por `id + tb_institution_id + tb_rest_group_id`.

---

### /restgrouphasmeasure/sincronize

**Tabelas:** `tb_rest_group_has_measure`

Upsert por chave composta: `tb_institution_id + tb_rest_group_id + tb_measure_id`.

---

### /restgrouphasoptional/sincronize

**Tabelas:** `tb_rest_group_has_optional`

Upsert por chave composta: `tb_institution_id + tb_rest_group_id + tb_product_id`.

---

### /restmenu/sincronize

**Tabelas:** `tb_rest_menu`

Upsert por `id + tb_institution_id`.

---

### /restmenuhasingrediente/sincronize

**Tabelas:** `tb_rest_menu_has_ingredient`

Upsert por chave composta: `tb_institution_id + tb_rest_menu_id + tb_product_id`.

---

### /restsubgroup/sincronize

**Tabelas:** `tb_rest_subgroup`

Upsert por `id + tb_institution_id + tb_rest_group_id`.

---

### /salesman/sincronize

**Tabelas:** `tb_entity`, `tb_person`/`tb_company`, `tb_address`, `tb_phone`,
`tb_collaborator`, `tb_salesman`

Lógica em cascata:
1. Salvar dados fiscais (entity + person/company + address + phone) — igual ao Customer
2. Upsert `tb_collaborator` por `id + tb_institution_id`
3. Upsert `tb_salesman` por `id + tb_institution_id`

---

### /stockbalance/sincronize

**Tabelas:** `tb_stock_balance`

Upsert por chave composta: `tb_institution_id + tb_stock_list_id + tb_merchandise_id`.

---

### /stocklist/sincronize

**Tabelas:** `tb_stock_list`

Upsert por `id + tb_institution_id`.

---

### /stockstatement/sincronize

**Tabelas:** `tb_stock_statement`

Upsert por `id + tb_institution_id + terminal`.
Normalizar `dt_record`.
O campo `direction`: 'E' = entrada, 'S' = saída.
**Atenção:** existe um trigger MySQL `after_stock_statement_insert` que atualiza
`tb_stock_balance` automaticamente. Não replicar essa lógica em código — o trigger cuida disso.

---

## src/modules/sync/sync.specific.routes.ts

Registra todos os endpoints específicos e exporta um Router:

```typescript
import { Router } from 'express'
import { syncAuthMiddleware } from './sync.auth.middleware'

import bankaccountRouter        from './endpoints/bankaccount'
import brandRouter              from './endpoints/brand'
import cashierRouter            from './endpoints/cashier'
import categoryRouter           from './endpoints/category'
import customerRouter           from './endpoints/customer'
import filexmlRouter            from './endpoints/filexml'
import financialRouter          from './endpoints/financial'
import financialplansRouter     from './endpoints/financialplans'
import financialstatementRouter from './endpoints/financialstatement'
import merchandiseRouter        from './endpoints/merchandise'
import orderpurchaseRouter      from './endpoints/orderpurchase'
import ordersaleRouter          from './endpoints/ordersale'
import orderstockadjustRouter   from './endpoints/orderstockadjust'
import packageRouter            from './endpoints/package'
import paymenttypeRouter        from './endpoints/paymenttype'
import priceRouter              from './endpoints/price'
import pricelistRouter          from './endpoints/pricelist'
import promotionRouter          from './endpoints/promotion'
import providerRouter           from './endpoints/provider'
import restgroupRouter          from './endpoints/restgroup'
import restgrouphasattributeRouter from './endpoints/restgrouphasattribute'
import restgrouphasmeasureRouter   from './endpoints/restgrouphasmeasure'
import restgrouphasoptionalRouter  from './endpoints/restgrouphasoptional'
import restmenuRouter           from './endpoints/restmenu'
import restmenuhasingredienteRouter from './endpoints/restmenuhasingrediente'
import restsubgroupRouter       from './endpoints/restsubgroup'
import salesmanRouter           from './endpoints/salesman'
import stockbalanceRouter       from './endpoints/stockbalance'
import stocklistRouter          from './endpoints/stocklist'
import stockstatementRouter     from './endpoints/stockstatement'

const router = Router()

// Auth para todos os endpoints específicos
router.use(syncAuthMiddleware)

router.use(bankaccountRouter)
router.use(brandRouter)
router.use(cashierRouter)
router.use(categoryRouter)
router.use(customerRouter)
router.use(filexmlRouter)
router.use(financialRouter)
router.use(financialplansRouter)
router.use(financialstatementRouter)
router.use(merchandiseRouter)
router.use(orderpurchaseRouter)
router.use(ordersaleRouter)
router.use(orderstockadjustRouter)
router.use(packageRouter)
router.use(paymenttypeRouter)
router.use(priceRouter)
router.use(pricelistRouter)
router.use(promotionRouter)
router.use(providerRouter)
router.use(restgroupRouter)
router.use(restgrouphasattributeRouter)
router.use(restgrouphasmeasureRouter)
router.use(restgrouphasoptionalRouter)
router.use(restmenuRouter)
router.use(restmenuhasingredienteRouter)
router.use(restsubgroupRouter)
router.use(salesmanRouter)
router.use(stockbalanceRouter)
router.use(stocklistRouter)
router.use(stockstatementRouter)

export default router
```

---

## Alterar src/gateway/router.ts

Adicione o novo router específico:

```typescript
import { Router } from 'express'
import coreRoutes     from '@modules/core/core.routes'
import erpRoutes      from '@modules/erp/erp.routes'
import adminRoutes    from '@modules/admin/admin.routes'
import syncRoutes     from '@modules/sync/sync.routes'
import syncSpecific   from '@modules/sync/sync.specific.routes'

const router = Router()

router.use('/core',  coreRoutes)
router.use('/erp',   erpRoutes)
router.use('/admin', adminRoutes)
router.use('/api',   syncRoutes)     // rotas genéricas: /api/sync/push, /pull, /status
router.use('/',      syncSpecific)   // rotas específicas: /bankaccount/sincronize etc.

export default router
```

**Atenção:** As rotas específicas ficam na raiz `/` sem prefixo — para manter
compatibilidade exata com o Sincronizador Delphi que chama `/brand/sincronize`,
`/Customer/sincronize`, etc.

---

## Instalar dependências necessárias

```bash
npm install date-fns
```

---

## Critérios de sucesso da Semana 4

### 1. Endpoint simples — categoria

```
POST /category/sincronize
X-Api-Key: sync-key-alpha-001
Content-Type: application/json

{ "id": 0, "tb_institution_id": 1, "description": "Bebidas", "posit_level": 1, "kind": "P", "Active": "S" }
```
Esperado: `{ "id": 200, "code": 1, "message": "SAVED" }`

Verificar no MySQL:
```sql
USE schema_alpha;
SELECT * FROM tb_category WHERE description = 'Bebidas';
-- deve existir com id gerado automaticamente
```

### 2. Endpoint com lookup — brand

```
POST /brand/sincronize
X-Api-Key: sync-key-alpha-001

{ "tb_institution_id": 1, "Marca": { "id": 0, "description": "Nike" } }
```
Esperado: `{ "id": 200, "code": 1, "message": "SAVED" }`

Verificar: `tb_brand` tem "Nike" e `tb_institution_has_brand` tem o vínculo.

Enviar o mesmo request novamente — deve retornar 200 sem criar duplicata.

### 3. Isolamento de cliente

Enviar o mesmo POST com `X-Api-Key: sync-key-beta-002`.
Verificar que o registro foi criado em `schema_beta`, não em `schema_alpha`.

### 4. Resposta de erro sempre HTTP 200

Enviar um request com `tb_institution_id` inválido ou tabela inexistente.
Esperado: HTTP 200 com `{ "id": 500, "code": 0, "message": "..." }`
Nunca deve retornar HTTP 4xx ou 5xx.

### 5. Normalização de data

```
POST /category/sincronize
{ "tb_institution_id": 1, "description": "Teste Data" }
```
Sem campos de data — não deve lançar erro.

```
POST /cashier/sincronize
{ "tb_institution_id": 1, "terminal": 1, "dt_record": "25/12/2024 08:00:00", "tb_userid": 1 }
```
Verificar no banco: `dt_record = '2024-12-25 08:00:00'` (formato convertido).

### 6. Operação complexa — customer

Enviar um POST completo para `/Customer/sincronize` com pessoa física
(CPF preenchido, CNPJ vazio). Verificar:
- `tb_entity` criada
- `tb_person` criada com mesmo id
- `tb_customer` criada
- `tb_institution_has_entity` criada

Enviar o mesmo request novamente — sem duplicatas.

### 7. Trigger de estoque funcionando

```
POST /stockstatement/sincronize
{ "id": 0, "tb_institution_id": 1, "terminal": 1, "tb_stock_list_id": 1,
  "tb_merchandise_id": 1, "direction": "E", "quantity": 10, "dt_record": "2024-01-01 00:00:00" }
```
Verificar que `tb_stock_balance` foi atualizado automaticamente pelo trigger.

### 8. Servidor não quebra

Reiniciar o servidor e confirmar que todos os 31 endpoints carregam sem erro no log.

---

## Resumo das alterações

| Arquivo/Pasta | Ação |
|---|---|
| `src/modules/sync/sync.response.ts` | CRIAR |
| `src/modules/sync/sync.id-generator.ts` | CRIAR |
| `src/modules/sync/sync.date.ts` | CRIAR |
| `src/modules/sync/sync.lookup.ts` | CRIAR |
| `src/modules/sync/endpoints/` (31 arquivos) | CRIAR |
| `src/modules/sync/sync.specific.routes.ts` | CRIAR |
| `src/gateway/router.ts` | ALTERAR |
| `package.json` | ALTERAR (adicionar date-fns) |

---

## Instrução final para o Claude Desktop

- Instale `date-fns` antes de criar qualquer arquivo
- Crie os 4 helpers primeiro (response, id-generator, date, lookup)
- Crie os 31 endpoints seguindo estritamente o padrão definido
- Crie o `sync.specific.routes.ts` registrando todos os endpoints
- Altere apenas o `router.ts` nos arquivos existentes
- Valide os 8 critérios de sucesso na ordem
- Endpoints com `/Customer/` e `/Promotion/` devem manter o C e P maiúsculos
  para compatibilidade com o Sincronizador Delphi
- Não remova nem altere nenhum arquivo das semanas anteriores além do router.ts
- `/invoicing` e `/invoicerectification` NÃO devem ser implementados nesta semana
  pois envolvem integração NF-e com ACBrNFe que requer decisão de arquitetura separada
