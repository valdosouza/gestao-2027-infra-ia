# Prompt — Semana 3: API de Sincronização Firebird ↔ MySQL
**Escopo**: setes

## Contexto do projeto

O projeto `setes-api` está rodando com Node.js + TypeScript + Express.
Fase 1, Semana 2 e migração do baseline real foram concluídas com sucesso.
O schema de cada cliente contém 185 tabelas do ERP Setes.

---

## Contexto da sincronização

Existe um **Sincronizador Delphi** instalado localmente em cada cliente.
Ele é responsável por toda a orquestração:

- **Push** — lê dados do Firebird local, transforma e envia para a API Node
- **Pull** — consulta dados na API Node e aplica de volta no Firebird local

A API Node que vamos criar é **passiva** — ela apenas recebe e responde.
Nunca inicia conexão com o Delphi.

Cada cliente possui um **código de estabelecimento** (`establishment_code`)
que identifica a qual schema MySQL ele pertence.

A autenticação é feita por **API Key fixa por cliente** — não usa JWT.

---

## Arquitetura da Semana 3

```
Sincronizador Delphi (cliente)
        │
        │  PUSH: POST /sync/push  (envia lotes de registros)
        │  PULL: GET  /sync/pull  (consulta registros atualizados)
        ▼
API Node — módulo sync
        │
        ├── sync.auth.middleware.ts  (valida API Key + resolve schema)
        ├── sync.routes.ts           (rotas de push e pull)
        ├── sync.service.ts          (lógica de upsert e resolução de conflitos)
        ├── sync.repository.ts       (queries MySQL por schema do cliente)
        └── sync.queue.ts            (fila em memória para processar em lote)
        │
        ▼
MySQL — schema do cliente (ex: schema_alpha)
```

---

## Novos arquivos a criar

```
setes-api/
├── src/
│   └── modules/
│       └── sync/
│           ├── sync.auth.middleware.ts
│           ├── sync.routes.ts
│           ├── sync.service.ts
│           ├── sync.repository.ts
│           └── sync.queue.ts
```

Também alterar:
- `src/gateway/router.ts` — registrar rotas de sync
- `setes_central` — nova tabela `sync_api_keys`
- `setes_central` — nova tabela `sync_log`

---

## SQL a executar no MySQL (setes_central) antes de iniciar

```sql
-- Tabela de API Keys por cliente
CREATE TABLE IF NOT EXISTS setes_central.sync_api_keys (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  establishment_code VARCHAR(50)  NOT NULL UNIQUE,
  tenant_id         VARCHAR(36)  NOT NULL,
  schema_name       VARCHAR(100) NOT NULL,
  api_key           VARCHAR(100) NOT NULL UNIQUE,
  active            BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at        DATETIME     DEFAULT CURRENT_TIMESTAMP,
  KEY idx_api_key (api_key),
  KEY idx_establishment (establishment_code)
);

-- Tabela de log de sincronizações
CREATE TABLE IF NOT EXISTS setes_central.sync_log (
  id                 BIGINT AUTO_INCREMENT PRIMARY KEY,
  establishment_code VARCHAR(50)  NOT NULL,
  schema_name        VARCHAR(100) NOT NULL,
  direction          ENUM('push','pull') NOT NULL,
  table_name         VARCHAR(100) NOT NULL,
  records_count      INT          NOT NULL DEFAULT 0,
  status             ENUM('success','error') NOT NULL,
  error_message      TEXT         DEFAULT NULL,
  duration_ms        INT          DEFAULT NULL,
  created_at         DATETIME     DEFAULT CURRENT_TIMESTAMP,
  KEY idx_establishment (establishment_code),
  KEY idx_created_at (created_at)
);

-- API Key de teste para schema_alpha
INSERT INTO setes_central.sync_api_keys
  (establishment_code, tenant_id, schema_name, api_key)
VALUES
  ('EST-001', 'tenant-001', 'schema_alpha', 'sync-key-alpha-001'),
  ('EST-002', 'tenant-002', 'schema_beta',  'sync-key-beta-002');
```

---

## src/modules/sync/sync.auth.middleware.ts

Valida a API Key enviada no header `X-Api-Key` e resolve o schema do cliente:

```typescript
import { Request, Response, NextFunction } from 'express'
import pool   from '@shared/db/connection'
import logger from '@shared/logger/logger'

export interface SyncClient {
  establishmentCode: string
  tenantId:          string
  schemaName:        string
}

declare global {
  namespace Express {
    interface Request {
      syncClient?: SyncClient
    }
  }
}

// Cache simples em memória com TTL de 5 minutos
const keyCache = new Map<string, { client: SyncClient; expiresAt: number }>()
const TTL = 5 * 60 * 1000

async function resolveApiKey(apiKey: string): Promise<SyncClient | null> {
  const now    = Date.now()
  const cached = keyCache.get(apiKey)
  if (cached && cached.expiresAt > now) return cached.client

  const [rows] = await pool.query<any[]>(
    `SELECT establishment_code, tenant_id, schema_name
     FROM setes_central.sync_api_keys
     WHERE api_key = ? AND active = TRUE`,
    [apiKey]
  )

  if (!rows.length) return null

  const client: SyncClient = {
    establishmentCode: rows[0].establishment_code,
    tenantId:          rows[0].tenant_id,
    schemaName:        rows[0].schema_name,
  }

  keyCache.set(apiKey, { client, expiresAt: now + TTL })
  return client
}

export function syncAuthMiddleware(req: Request, res: Response, next: NextFunction) {
  const apiKey = req.headers['x-api-key'] as string

  if (!apiKey) {
    res.status(401).json({ error: 'X-Api-Key header obrigatório' })
    return
  }

  resolveApiKey(apiKey)
    .then(client => {
      if (!client) {
        logger.warn('API Key inválida ou inativa', { apiKey: apiKey.slice(0, 8) + '...' })
        res.status(401).json({ error: 'API Key inválida' })
        return
      }
      req.syncClient = client
      next()
    })
    .catch(() => res.status(500).json({ error: 'Erro ao validar API Key' }))
}
```

---

## src/modules/sync/sync.repository.ts

Operações de leitura e escrita por schema de cliente:

```typescript
import pool from '@shared/db/connection'

export interface SyncRecord {
  id:         number | string
  table_name: string
  data:       Record<string, any>
  updated_at: string
}

// Upsert genérico por tabela e schema
export async function upsertRecords(
  schemaName: string,
  tableName:  string,
  records:    Record<string, any>[]
): Promise<{ inserted: number; updated: number }> {
  if (!records.length) return { inserted: 0, updated: 0 }

  // Validação de segurança: apenas letras, números e underscores
  if (!/^[a-z0-9_]+$/i.test(tableName)) {
    throw new Error(`Nome de tabela inválido: ${tableName}`)
  }

  const conn = await pool.getConnection()
  let inserted = 0
  let updated  = 0

  try {
    await conn.query(`USE \`${schemaName}\``)

    for (const record of records) {
      const columns = Object.keys(record)
      const values  = Object.values(record)
      const placeholders = columns.map(() => '?').join(', ')
      const updateSet    = columns
        .filter(c => c !== 'id')
        .map(c => `\`${c}\` = VALUES(\`${c}\`)`)
        .join(', ')

      const sql = `
        INSERT INTO \`${tableName}\` (${columns.map(c => `\`${c}\``).join(', ')})
        VALUES (${placeholders})
        ON DUPLICATE KEY UPDATE ${updateSet}
      `

      const [result] = await conn.query<any>(sql, values)
      if (result.affectedRows === 1) inserted++
      if (result.affectedRows === 2) updated++
    }
  } finally {
    conn.release()
  }

  return { inserted, updated }
}

// Busca registros atualizados após um timestamp
export async function getUpdatedRecords(
  schemaName: string,
  tableName:  string,
  since:      string,
  limit = 500
): Promise<Record<string, any>[]> {
  if (!/^[a-z0-9_]+$/i.test(tableName)) {
    throw new Error(`Nome de tabela inválido: ${tableName}`)
  }

  const conn = await pool.getConnection()
  try {
    await conn.query(`USE \`${schemaName}\``)
    const [rows] = await conn.query<any[]>(
      `SELECT * FROM \`${tableName}\`
       WHERE updated_at > ?
       ORDER BY updated_at ASC
       LIMIT ?`,
      [since, limit]
    )
    return rows
  } finally {
    conn.release()
  }
}

// Registra o log de sync no banco central
export async function writeSyncLog(entry: {
  establishmentCode: string
  schemaName:        string
  direction:         'push' | 'pull'
  tableName:         string
  recordsCount:      number
  status:            'success' | 'error'
  errorMessage?:     string
  durationMs?:       number
}): Promise<void> {
  await pool.query(
    `INSERT INTO setes_central.sync_log
      (establishment_code, schema_name, direction, table_name,
       records_count, status, error_message, duration_ms)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [
      entry.establishmentCode,
      entry.schemaName,
      entry.direction,
      entry.tableName,
      entry.recordsCount,
      entry.status,
      entry.errorMessage ?? null,
      entry.durationMs   ?? null,
    ]
  )
}
```

---

## src/modules/sync/sync.queue.ts

Fila em memória para processar lotes sem bloquear a resposta HTTP:

```typescript
import logger from '@shared/logger/logger'

interface QueueJob {
  schemaName:        string
  establishmentCode: string
  tableName:         string
  records:           Record<string, any>[]
  resolve:           (result: any) => void
  reject:            (err: Error)  => void
}

const queue: QueueJob[] = []
let processing = false

async function processNext() {
  if (processing || queue.length === 0) return
  processing = true

  const job = queue.shift()!

  try {
    const { upsertRecords } = await import('./sync.repository')
    const result = await upsertRecords(job.schemaName, job.tableName, job.records)
    job.resolve(result)
  } catch (err) {
    logger.error('Erro no processamento da fila de sync', { err, schemaName: job.schemaName })
    job.reject(err as Error)
  } finally {
    processing = false
    setImmediate(processNext)
  }
}

export function enqueue(job: Omit<QueueJob, 'resolve' | 'reject'>): Promise<any> {
  return new Promise((resolve, reject) => {
    queue.push({ ...job, resolve, reject })
    setImmediate(processNext)
  })
}

export function getQueueStatus() {
  return { pending: queue.length, processing }
}
```

---

## src/modules/sync/sync.service.ts

Lógica de negócio do push e pull:

```typescript
import { upsertRecords, getUpdatedRecords, writeSyncLog } from './sync.repository'
import { enqueue } from './sync.queue'
import logger from '@shared/logger/logger'

export interface PushPayload {
  table:   string
  records: Record<string, any>[]
}

export interface PullQuery {
  table: string
  since: string  // ISO datetime: "2024-01-01T00:00:00"
  limit?: number
}

export async function processPush(
  schemaName:        string,
  establishmentCode: string,
  payload:           PushPayload
): Promise<{ inserted: number; updated: number; queued: boolean }> {
  const start = Date.now()

  // Lotes pequenos (≤ 50): processa direto e responde imediato
  // Lotes grandes (> 50): enfileira e responde aceito
  const isLarge = payload.records.length > 50

  try {
    let result: { inserted: number; updated: number }

    if (isLarge) {
      enqueue({
        schemaName,
        establishmentCode,
        tableName: payload.table,
        records:   payload.records,
      }).then(r => {
        writeSyncLog({
          establishmentCode,
          schemaName,
          direction:    'push',
          tableName:    payload.table,
          recordsCount: payload.records.length,
          status:       'success',
          durationMs:   Date.now() - start,
        })
      }).catch(err => {
        writeSyncLog({
          establishmentCode,
          schemaName,
          direction:     'push',
          tableName:     payload.table,
          recordsCount:  payload.records.length,
          status:        'error',
          errorMessage:  err.message,
        })
      })

      return { inserted: 0, updated: 0, queued: true }
    }

    result = await upsertRecords(schemaName, payload.table, payload.records)

    await writeSyncLog({
      establishmentCode,
      schemaName,
      direction:    'push',
      tableName:    payload.table,
      recordsCount: payload.records.length,
      status:       'success',
      durationMs:   Date.now() - start,
    })

    logger.info('Push processado', {
      establishmentCode,
      table:    payload.table,
      ...result,
    })

    return { ...result, queued: false }

  } catch (err: any) {
    await writeSyncLog({
      establishmentCode,
      schemaName,
      direction:    'push',
      tableName:    payload.table,
      recordsCount: payload.records.length,
      status:       'error',
      errorMessage: err.message,
    })
    throw err
  }
}

export async function processPull(
  schemaName:        string,
  establishmentCode: string,
  query:             PullQuery
): Promise<{ records: Record<string, any>[]; count: number }> {
  const start = Date.now()

  try {
    const records = await getUpdatedRecords(
      schemaName,
      query.table,
      query.since,
      query.limit ?? 500
    )

    await writeSyncLog({
      establishmentCode,
      schemaName,
      direction:    'pull',
      tableName:    query.table,
      recordsCount: records.length,
      status:       'success',
      durationMs:   Date.now() - start,
    })

    logger.info('Pull processado', {
      establishmentCode,
      table: query.table,
      count: records.length,
    })

    return { records, count: records.length }

  } catch (err: any) {
    await writeSyncLog({
      establishmentCode,
      schemaName,
      direction:    'pull',
      tableName:    query.table,
      recordsCount: 0,
      status:       'error',
      errorMessage: err.message,
    })
    throw err
  }
}
```

---

## src/modules/sync/sync.routes.ts

```typescript
import { Router, Request, Response } from 'express'
import { syncAuthMiddleware } from './sync.auth.middleware'
import { processPush, processPull } from './sync.service'
import { getQueueStatus } from './sync.queue'
import logger from '@shared/logger/logger'

const router = Router()

// Todas as rotas de sync exigem API Key
router.use(syncAuthMiddleware)

// POST /sync/push
// Delphi envia registros do Firebird para o MySQL
router.post('/push', async (req: Request, res: Response) => {
  const { table, records } = req.body
  const client = req.syncClient!

  if (!table || typeof table !== 'string') {
    res.status(400).json({ error: 'Campo "table" obrigatório' })
    return
  }

  if (!Array.isArray(records) || records.length === 0) {
    res.status(400).json({ error: 'Campo "records" deve ser um array não vazio' })
    return
  }

  if (records.length > 5000) {
    res.status(400).json({ error: 'Máximo de 5.000 registros por requisição' })
    return
  }

  try {
    const result = await processPush(client.schemaName, client.establishmentCode, {
      table,
      records,
    })

    const status = result.queued ? 202 : 200
    res.status(status).json({
      ok:     true,
      queued: result.queued,
      data:   result.queued
        ? { message: 'Lote grande enfileirado para processamento' }
        : { inserted: result.inserted, updated: result.updated },
    })
  } catch (err: any) {
    logger.error('Erro no push', { err, establishment: client.establishmentCode })
    res.status(500).json({ error: err.message ?? 'Erro interno no push' })
  }
})

// GET /sync/pull?table=tb_product&since=2024-01-01T00:00:00&limit=500
// Delphi consulta registros atualizados no MySQL para aplicar no Firebird
router.get('/pull', async (req: Request, res: Response) => {
  const { table, since, limit } = req.query
  const client = req.syncClient!

  if (!table || typeof table !== 'string') {
    res.status(400).json({ error: 'Query param "table" obrigatório' })
    return
  }

  if (!since || typeof since !== 'string') {
    res.status(400).json({ error: 'Query param "since" obrigatório (ISO datetime)' })
    return
  }

  // Valida formato ISO básico
  if (isNaN(Date.parse(since))) {
    res.status(400).json({ error: '"since" deve ser um datetime válido (ex: 2024-01-01T00:00:00)' })
    return
  }

  try {
    const result = await processPull(client.schemaName, client.establishmentCode, {
      table,
      since,
      limit: limit ? Math.min(Number(limit), 500) : 500,
    })

    res.json({ ok: true, data: result })
  } catch (err: any) {
    logger.error('Erro no pull', { err, establishment: client.establishmentCode })
    res.status(500).json({ error: err.message ?? 'Erro interno no pull' })
  }
})

// GET /sync/status — saúde da fila e info do cliente autenticado
router.get('/status', (req: Request, res: Response) => {
  res.json({
    ok:     true,
    client: req.syncClient,
    queue:  getQueueStatus(),
  })
})

// GET /sync/log?limit=20 — últimas sincronizações do cliente
router.get('/log', async (req: Request, res: Response) => {
  const client = req.syncClient!
  const limit  = Math.min(Number(req.query.limit ?? 20), 100)

  try {
    const pool = (await import('@shared/db/connection')).default
    const [rows] = await pool.query<any[]>(
      `SELECT direction, table_name, records_count, status,
              error_message, duration_ms, created_at
       FROM setes_central.sync_log
       WHERE establishment_code = ?
       ORDER BY created_at DESC
       LIMIT ?`,
      [client.establishmentCode, limit]
    )
    res.json({ ok: true, data: rows })
  } catch (err) {
    res.status(500).json({ error: 'Erro ao buscar log' })
  }
})

export default router
```

---

## Alterar src/gateway/router.ts

Adicione o módulo sync. O sync usa autenticação própria (API Key),
por isso deve ser registrado **fora** do pipeline JWT.

Substitua o conteúdo por:

```typescript
import { Router } from 'express'
import coreRoutes  from '@modules/core/core.routes'
import erpRoutes   from '@modules/erp/erp.routes'
import adminRoutes from '@modules/admin/admin.routes'
import syncRoutes  from '@modules/sync/sync.routes'

const router = Router()

// Módulos autenticados via JWT (pipeline padrão do gateway)
router.use('/core',  coreRoutes)
router.use('/erp',   erpRoutes)
router.use('/admin', adminRoutes)

// Módulo de sync — autenticação própria via API Key (X-Api-Key)
// NÃO passa pelo auth.middleware nem feature-flag.middleware
router.use('/sync',  syncRoutes)

export default router
```

---

## Alterar src/app.ts

O endpoint `/api/sync` deve ser excluído do middleware de auth JWT.
Localize a linha:

```typescript
app.use('/api', authMiddleware)
```

Substitua por:

```typescript
// Auth JWT em todas as rotas EXCETO /sync (que usa API Key própria)
app.use('/api', (req, res, next) => {
  if (req.path.startsWith('/sync')) return next()
  return authMiddleware(req, res, next)
})

// Feature flag apenas em rotas não-sync
app.use('/api', (req, res, next) => {
  if (req.path.startsWith('/sync')) return next()
  return featureFlagMiddleware(req, res, next)
})
```

---

## Novos testes automatizados

Crie o arquivo:

```
src/__tests__/sync.test.ts
```

```typescript
import * as syncRepo from '../modules/sync/sync.repository'
import { processPush, processPull } from '../modules/sync/sync.service'

jest.mock('../modules/sync/sync.repository')
jest.mock('@shared/logger/logger', () => ({
  default: { info: jest.fn(), warn: jest.fn(), error: jest.fn() }
}))

const mockUpsert   = syncRepo.upsertRecords as jest.Mock
const mockGetRecs  = syncRepo.getUpdatedRecords as jest.Mock
const mockWriteLog = syncRepo.writeSyncLog as jest.Mock

describe('sync.service — push', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    mockWriteLog.mockResolvedValue(undefined)
  })

  it('processa push pequeno direto (≤ 50 registros)', async () => {
    mockUpsert.mockResolvedValue({ inserted: 2, updated: 1 })

    const result = await processPush('schema_alpha', 'EST-001', {
      table:   'tb_product',
      records: [{ id: 1, name: 'Produto A' }, { id: 2, name: 'Produto B' }],
    })

    expect(result.queued).toBe(false)
    expect(result.inserted).toBe(2)
    expect(result.updated).toBe(1)
    expect(mockUpsert).toHaveBeenCalledWith(
      'schema_alpha', 'tb_product',
      expect.any(Array)
    )
  })

  it('enfileira push grande (> 50 registros)', async () => {
    const records = Array.from({ length: 51 }, (_, i) => ({ id: i, name: `P${i}` }))

    const result = await processPush('schema_alpha', 'EST-001', {
      table: 'tb_product',
      records,
    })

    expect(result.queued).toBe(true)
  })

  it('registra log de erro quando upsert falha', async () => {
    mockUpsert.mockRejectedValue(new Error('Tabela não existe'))

    await expect(
      processPush('schema_alpha', 'EST-001', {
        table:   'tb_inexistente',
        records: [{ id: 1 }],
      })
    ).rejects.toThrow('Tabela não existe')

    expect(mockWriteLog).toHaveBeenCalledWith(
      expect.objectContaining({ status: 'error' })
    )
  })
})

describe('sync.service — pull', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    mockWriteLog.mockResolvedValue(undefined)
  })

  it('retorna registros atualizados após o timestamp', async () => {
    const fakeRecords = [{ id: 1, name: 'Produto', updated_at: '2024-06-01T10:00:00' }]
    mockGetRecs.mockResolvedValue(fakeRecords)

    const result = await processPull('schema_alpha', 'EST-001', {
      table: 'tb_product',
      since: '2024-01-01T00:00:00',
    })

    expect(result.records).toEqual(fakeRecords)
    expect(result.count).toBe(1)
    expect(mockGetRecs).toHaveBeenCalledWith(
      'schema_alpha', 'tb_product', '2024-01-01T00:00:00', 500
    )
  })

  it('registra log de erro quando consulta falha', async () => {
    mockGetRecs.mockRejectedValue(new Error('Erro de conexão'))

    await expect(
      processPull('schema_alpha', 'EST-001', {
        table: 'tb_product',
        since: '2024-01-01T00:00:00',
      })
    ).rejects.toThrow('Erro de conexão')

    expect(mockWriteLog).toHaveBeenCalledWith(
      expect.objectContaining({ status: 'error', direction: 'pull' })
    )
  })
})
```

---

## Critérios de sucesso da Semana 3

### 1. Autenticação por API Key

```
GET /api/sync/status
X-Api-Key: sync-key-alpha-001
```
Esperado `200`:
```json
{
  "ok": true,
  "client": {
    "establishmentCode": "EST-001",
    "tenantId": "tenant-001",
    "schemaName": "schema_alpha"
  },
  "queue": { "pending": 0, "processing": false }
}
```

```
GET /api/sync/status
(sem header)
```
Esperado: `401`

```
GET /api/sync/status
X-Api-Key: chave-invalida
```
Esperado: `401`

---

### 2. Push — inserção de registros

```
POST /api/sync/push
X-Api-Key: sync-key-alpha-001
Content-Type: application/json

{
  "table": "tb_product",
  "records": [
    { "id": 1, "tb_institution_id": 1, "description": "Produto Teste", "active": "S", "deleted": "N", "created_at": "2024-01-01 00:00:00", "updated_at": "2024-01-01 00:00:00" }
  ]
}
```
Esperado `200`:
```json
{ "ok": true, "queued": false, "data": { "inserted": 1, "updated": 0 } }
```

---

### 3. Push — atualização de registro existente

Repita o push anterior com `"description": "Produto Atualizado"`.
Esperado: `"inserted": 0, "updated": 1`

---

### 4. Pull — busca de registros atualizados

```
GET /api/sync/pull?table=tb_product&since=2000-01-01T00:00:00
X-Api-Key: sync-key-alpha-001
```
Esperado `200` com o registro inserido no passo 2.

---

### 5. Push de lote grande é enfileirado

Envie um push com 51+ registros.
Esperado: `202` com `"queued": true`.

---

### 6. Isolamento entre clientes

```
GET /api/sync/pull?table=tb_product&since=2000-01-01T00:00:00
X-Api-Key: sync-key-beta-002
```
Esperado: `200` com array vazio `[]`
(o registro foi inserido em `schema_alpha`, não em `schema_beta`)

---

### 7. Log de sincronizações

```
GET /api/sync/log
X-Api-Key: sync-key-alpha-001
```
Esperado: lista com os registros das operações feitas nos passos 2, 3 e 4.

---

### 8. Rotas JWT não são afetadas

```
GET /api/core/info
(sem token)
```
Esperado: `401` — confirma que o bypass de auth do sync não afetou as outras rotas.

---

### 9. Todos os testes passando

```bash
npm test
```
Todos em verde, incluindo os novos testes de sync.

---

## Resumo das alterações

| Arquivo | Ação |
|---|---|
| `src/modules/sync/sync.auth.middleware.ts` | CRIAR |
| `src/modules/sync/sync.routes.ts`          | CRIAR |
| `src/modules/sync/sync.service.ts`         | CRIAR |
| `src/modules/sync/sync.repository.ts`      | CRIAR |
| `src/modules/sync/sync.queue.ts`           | CRIAR |
| `src/__tests__/sync.test.ts`               | CRIAR |
| `src/gateway/router.ts`                    | ALTERAR |
| `src/app.ts`                               | ALTERAR |
| MySQL `setes_central`                      | SQL acima |

---

## Instrução final para o Claude Desktop

- Execute o SQL no MySQL antes de iniciar
- Crie todos os arquivos novos listados acima
- Aplique apenas as alterações indicadas em `router.ts` e `app.ts`
- Valide os 9 critérios de sucesso na ordem
- Não avance para a Semana 4 até que todos os 9 estejam verificados
- O código Delphi existente pode ser adaptado usando esta API:
  - Push: `POST /api/sync/push` com `{ table, records[] }`
  - Pull: `GET /api/sync/pull?table=X&since=YYYY-MM-DDTHH:MM:SS`
  - Auth: header `X-Api-Key: <chave_do_cliente>`
