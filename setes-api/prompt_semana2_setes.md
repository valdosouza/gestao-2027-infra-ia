# Prompt — Semana 2: Migrations, Onboarding e Testes
**Escopo**: setes

## Contexto

O projeto `setes-api` já existe e está rodando com a seguinte estrutura:

```
setes-api/
├── src/
│   ├── gateway/
│   │   ├── auth.middleware.ts
│   │   ├── feature-flag.middleware.ts
│   │   ├── rate-limit.middleware.ts
│   │   └── router.ts
│   ├── modules/
│   │   ├── core/
│   │   ├── erp/
│   │   └── _template/
│   ├── feature-flags/
│   │   ├── flag.service.ts
│   │   └── flag.repository.ts
│   ├── shared/
│   │   ├── types/express.d.ts
│   │   ├── db/connection.ts
│   │   ├── errors/http-error.ts
│   │   └── logger/logger.ts
│   ├── app.ts
│   └── server.ts
```

Banco MySQL rodando com `setes_central` contendo as tabelas `tenants` e `feature_flags`.
Os 6 cenários de validação da Fase 1 já foram confirmados como funcionando.

---

## O que você deve implementar nesta semana

### Entrega 1 — Sistema de migrations por schema de tenant
### Entrega 2 — Endpoint de onboarding de novo cliente
### Entrega 3 — Testes automatizados dos middlewares

Não altere nenhum arquivo existente a menos que seja explicitamente indicado abaixo.

---

## Entrega 1 — Sistema de migrations

### Conceito

Cada cliente tem seu próprio schema no MySQL (ex: `schema_alpha`).
Quando um novo cliente é criado, seu schema precisa receber as tabelas base.
Quando uma tabela nova é adicionada ao sistema, todos os schemas existentes precisam receber a alteração.

O sistema de migrations resolve isso: um conjunto de arquivos SQL numerados que são aplicados em ordem, e uma tabela de controle por schema que registra quais migrations já foram executadas.

### Novos arquivos a criar

```
setes-api/
├── src/
│   └── migrations/
│       ├── runner.ts
│       ├── repository.ts
│       └── sql/
│           ├── 001_create_migrations_table.sql
│           └── 002_create_base_tables.sql
```

---

### src/migrations/sql/001_create_migrations_table.sql

```sql
CREATE TABLE IF NOT EXISTS _migrations (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  version    VARCHAR(10)  NOT NULL UNIQUE,
  name       VARCHAR(255) NOT NULL,
  applied_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);
```

---

### src/migrations/sql/002_create_base_tables.sql

```sql
CREATE TABLE IF NOT EXISTS users (
  id         VARCHAR(36)  PRIMARY KEY DEFAULT (UUID()),
  name       VARCHAR(255) NOT NULL,
  email      VARCHAR(255) NOT NULL UNIQUE,
  active     BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_log (
  id         BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id    VARCHAR(36)  NOT NULL,
  action     VARCHAR(255) NOT NULL,
  entity     VARCHAR(100),
  entity_id  VARCHAR(36),
  created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);
```

---

### src/migrations/repository.ts

Responsável por ler e controlar quais migrations já foram aplicadas em um schema:

```typescript
import { PoolConnection } from 'mysql2/promise'

export async function getAppliedMigrations(conn: PoolConnection): Promise<string[]> {
  try {
    const [rows] = await conn.query<any[]>(
      'SELECT version FROM _migrations ORDER BY version ASC'
    )
    return rows.map(r => r.version)
  } catch {
    // Tabela ainda não existe — será criada pela migration 001
    return []
  }
}

export async function recordMigration(
  conn: PoolConnection,
  version: string,
  name: string
): Promise<void> {
  await conn.query(
    'INSERT INTO _migrations (version, name) VALUES (?, ?)',
    [version, name]
  )
}
```

---

### src/migrations/runner.ts

Lê os arquivos `.sql` da pasta `sql/`, compara com as migrations já aplicadas no schema, e executa apenas as pendentes:

```typescript
import fs   from 'fs'
import path from 'path'
import pool from '@shared/db/connection'
import logger from '@shared/logger/logger'
import { getAppliedMigrations, recordMigration } from './repository'

const SQL_DIR = path.resolve(__dirname, 'sql')

interface MigrationFile {
  version: string
  name:    string
  file:    string
}

function loadMigrationFiles(): MigrationFile[] {
  return fs
    .readdirSync(SQL_DIR)
    .filter(f => f.endsWith('.sql'))
    .sort()
    .map(file => {
      const [version, ...rest] = file.replace('.sql', '').split('_')
      return { version, name: rest.join('_'), file }
    })
}

export async function runMigrationsForSchema(schemaName: string): Promise<void> {
  const conn = await pool.getConnection()

  try {
    await conn.query(`CREATE SCHEMA IF NOT EXISTS \`${schemaName}\``)
    await conn.query(`USE \`${schemaName}\``)

    const files   = loadMigrationFiles()
    const applied = await getAppliedMigrations(conn)
    const pending = files.filter(f => !applied.includes(f.version))

    if (pending.length === 0) {
      logger.info(`Migrations: nenhuma pendente`, { schemaName })
      return
    }

    for (const migration of pending) {
      const sql = fs.readFileSync(path.join(SQL_DIR, migration.file), 'utf-8')

      // Executa cada statement separadamente
      const statements = sql
        .split(';')
        .map(s => s.trim())
        .filter(s => s.length > 0)

      for (const statement of statements) {
        await conn.query(statement)
      }

      await recordMigration(conn, migration.version, migration.name)
      logger.info(`Migration aplicada: ${migration.version} - ${migration.name}`, { schemaName })
    }

    logger.info(`Migrations concluídas`, { schemaName, total: pending.length })
  } finally {
    conn.release()
  }
}

export async function runMigrationsForAllTenants(): Promise<void> {
  const [tenants] = await pool.query<any[]>(
    'SELECT schema_name FROM setes_central.tenants WHERE active = TRUE'
  )

  logger.info(`Iniciando migrations para ${tenants.length} tenant(s)`)

  for (const tenant of tenants) {
    await runMigrationsForSchema(tenant.schema_name)
  }

  logger.info('Migrations finalizadas para todos os tenants')
}
```

---

### Alterar src/server.ts

Adicione a execução das migrations na inicialização do servidor.
Substitua o conteúdo atual por:

```typescript
import app from './app'
import logger from '@shared/logger/logger'
import { runMigrationsForAllTenants } from './migrations/runner'

const PORT = process.env.PORT ?? 3000

async function bootstrap() {
  try {
    logger.info('Iniciando migrations...')
    await runMigrationsForAllTenants()
    logger.info('Migrations concluídas. Subindo servidor...')

    app.listen(PORT, () => {
      logger.info(`Setes API rodando na porta ${PORT}`)
    })
  } catch (err) {
    logger.error('Falha na inicialização', { err })
    process.exit(1)
  }
}

bootstrap()
```

---

## Entrega 2 — Endpoint de onboarding de novo cliente

### Conceito

Quando a Setes cadastra um novo cliente, três coisas precisam acontecer de forma atômica:
1. Inserir o tenant na tabela `setes_central.tenants`
2. Habilitar os módulos padrão em `feature_flags`
3. Criar o schema do cliente e aplicar todas as migrations

Apenas usuários com `role: setes_admin` no JWT podem acessar este endpoint.

### Novos arquivos a criar

```
setes-api/
├── src/
│   └── modules/
│       └── admin/
│           ├── admin.routes.ts
│           ├── admin.service.ts
│           └── admin.repository.ts
```

---

### src/modules/admin/admin.repository.ts

```typescript
import pool from '@shared/db/connection'

export interface CreateTenantInput {
  id:         string
  name:       string
  schemaName: string
}

export async function insertTenant(input: CreateTenantInput): Promise<void> {
  await pool.query(
    'INSERT INTO setes_central.tenants (id, name, schema_name) VALUES (?, ?, ?)',
    [input.id, input.name, input.schemaName]
  )
}

export async function insertDefaultFlags(tenantId: string): Promise<void> {
  const defaultModules = ['core']

  const values = defaultModules.map(mod => [tenantId, mod, true])

  await pool.query(
    'INSERT INTO setes_central.feature_flags (tenant_id, module_key, enabled) VALUES ?',
    [values]
  )
}

export async function tenantSchemaExists(schemaName: string): Promise<boolean> {
  const [rows] = await pool.query<any[]>(
    'SELECT schema_name FROM setes_central.tenants WHERE schema_name = ?',
    [schemaName]
  )
  return rows.length > 0
}
```

---

### src/modules/admin/admin.service.ts

```typescript
import { randomUUID } from 'crypto'
import { insertTenant, insertDefaultFlags, tenantSchemaExists } from './admin.repository'
import { runMigrationsForSchema } from '../../migrations/runner'
import { HttpError } from '@shared/errors/http-error'

export interface OnboardInput {
  name:       string
  schemaName: string
}

export interface OnboardResult {
  tenantId:   string
  name:       string
  schemaName: string
}

export async function onboardTenant(input: OnboardInput): Promise<OnboardResult> {
  const { name, schemaName } = input

  // Valida formato do schemaName: apenas letras, números e underscores
  if (!/^[a-z0-9_]+$/.test(schemaName)) {
    throw new HttpError(400, 'schemaName deve conter apenas letras minúsculas, números e underscores')
  }

  const exists = await tenantSchemaExists(schemaName)
  if (exists) {
    throw new HttpError(409, `Schema "${schemaName}" já está em uso`)
  }

  const tenantId = randomUUID()

  // 1. Registra o tenant no banco central
  await insertTenant({ id: tenantId, name, schemaName })

  // 2. Habilita módulos padrão
  await insertDefaultFlags(tenantId)

  // 3. Cria o schema e aplica todas as migrations
  await runMigrationsForSchema(schemaName)

  return { tenantId, name, schemaName }
}
```

---

### src/modules/admin/admin.routes.ts

```typescript
import { Router, Request, Response } from 'express'
import { onboardTenant } from './admin.service'
import { HttpError } from '@shared/errors/http-error'
import logger from '@shared/logger/logger'

const router = Router()

// Middleware local: bloqueia quem não for setes_admin
router.use((req: Request, res: Response, next) => {
  if (req.tenant?.role !== 'setes_admin') {
    res.status(403).json({ error: 'Acesso restrito à equipe Setes' })
    return
  }
  next()
})

// POST /api/admin/tenants
router.post('/tenants', async (req: Request, res: Response) => {
  const { name, schemaName } = req.body

  if (!name || !schemaName) {
    res.status(400).json({ error: 'Os campos "name" e "schemaName" são obrigatórios' })
    return
  }

  try {
    const result = await onboardTenant({ name, schemaName })
    logger.info('Novo tenant criado', result)
    res.status(201).json({ ok: true, data: result })
  } catch (err) {
    if (err instanceof HttpError) {
      res.status(err.statusCode).json({ error: err.message })
      return
    }
    logger.error('Erro ao criar tenant', { err })
    res.status(500).json({ error: 'Erro interno ao criar tenant' })
  }
})

// GET /api/admin/tenants
router.get('/tenants', async (_req: Request, res: Response) => {
  const pool = (await import('@shared/db/connection')).default
  try {
    const [rows] = await pool.query<any[]>(
      'SELECT id, name, schema_name, active, created_at FROM setes_central.tenants ORDER BY created_at DESC'
    )
    res.json({ ok: true, data: rows })
  } catch (err) {
    res.status(500).json({ error: 'Erro ao listar tenants' })
  }
})

export default router
```

---

### Alterar src/gateway/router.ts

Adicione o módulo admin ao router. Substitua o conteúdo por:

```typescript
import { Router } from 'express'
import coreRoutes  from '@modules/core/core.routes'
import erpRoutes   from '@modules/erp/erp.routes'
import adminRoutes from '@modules/admin/admin.routes'

const router = Router()

router.use('/core',  coreRoutes)
router.use('/erp',   erpRoutes)
router.use('/admin', adminRoutes)

export default router
```

---

## Entrega 3 — Testes automatizados

### Novas dependências a instalar

```bash
npm install --save-dev jest ts-jest @types/jest supertest @types/supertest
```

### Adicionar ao package.json (seção scripts e jest config)

```json
{
  "scripts": {
    "dev":   "ts-node-dev --respawn --transpile-only src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "test":  "jest --runInBand"
  },
  "jest": {
    "preset": "ts-jest",
    "testEnvironment": "node",
    "moduleNameMapper": {
      "^@gateway/(.*)$":       "<rootDir>/src/gateway/$1",
      "^@modules/(.*)$":       "<rootDir>/src/modules/$1",
      "^@shared/(.*)$":        "<rootDir>/src/shared/$1",
      "^@feature-flags/(.*)$": "<rootDir>/src/feature-flags/$1"
    }
  }
}
```

### Novos arquivos de teste a criar

```
setes-api/
├── src/
│   └── __tests__/
│       ├── auth.middleware.test.ts
│       ├── feature-flag.middleware.test.ts
│       └── onboarding.test.ts
```

---

### src/__tests__/auth.middleware.test.ts

```typescript
import request from 'supertest'
import jwt     from 'jsonwebtoken'
import app     from '../app'

const SECRET = process.env.JWT_SECRET ?? 'sua_chave_secreta_aqui'

function makeToken(payload: object, secret = SECRET) {
  return jwt.sign(payload, secret, { expiresIn: '1h' })
}

describe('auth.middleware', () => {
  it('retorna 200 em /health sem token', async () => {
    const res = await request(app).get('/health')
    expect(res.status).toBe(200)
    expect(res.body.status).toBe('ok')
  })

  it('retorna 401 sem Authorization header', async () => {
    const res = await request(app).get('/api/core/info')
    expect(res.status).toBe(401)
  })

  it('retorna 401 com token malformado', async () => {
    const res = await request(app)
      .get('/api/core/info')
      .set('Authorization', 'Bearer token.invalido.aqui')
    expect(res.status).toBe(401)
  })

  it('retorna 401 com token assinado com secret errado', async () => {
    const token = makeToken(
      { tenantId: 'tenant-001', userId: 'u1', role: 'client_user', schemaName: 'schema_alpha' },
      'secret_errado'
    )
    const res = await request(app)
      .get('/api/core/info')
      .set('Authorization', `Bearer ${token}`)
    expect(res.status).toBe(401)
  })

  it('passa com token válido (não testa banco, apenas o middleware)', async () => {
    const token = makeToken({
      tenantId: 'tenant-001',
      userId:   'user-001',
      role:     'client_user',
      schemaName: 'schema_alpha',
    })
    // Pode retornar 500 se o banco não estiver acessível no CI,
    // mas não deve retornar 401 — o middleware de auth passou
    const res = await request(app)
      .get('/api/core/info')
      .set('Authorization', `Bearer ${token}`)
    expect(res.status).not.toBe(401)
  })
})
```

---

### src/__tests__/feature-flag.middleware.test.ts

```typescript
import { isModuleEnabled } from '../feature-flags/flag.service'

// Mock do repositório para não depender do banco nos testes unitários
jest.mock('../feature-flags/flag.repository', () => ({
  getFlagsForTenant: jest.fn(async (tenantId: string) => {
    if (tenantId === 'tenant-com-erp') {
      return [
        { tenantId: 'tenant-com-erp', moduleKey: 'core', enabled: true },
        { tenantId: 'tenant-com-erp', moduleKey: 'erp',  enabled: true },
      ]
    }
    return [
      { tenantId: 'tenant-sem-erp', moduleKey: 'core', enabled: true },
      { tenantId: 'tenant-sem-erp', moduleKey: 'erp',  enabled: false },
    ]
  }),
}))

describe('flag.service', () => {
  it('setes admin tem acesso a qualquer módulo', async () => {
    const result = await isModuleEnabled('setes', 'erp')
    expect(result).toBe(true)
  })

  it('tenant com erp habilitado retorna true', async () => {
    const result = await isModuleEnabled('tenant-com-erp', 'erp')
    expect(result).toBe(true)
  })

  it('tenant sem erp habilitado retorna false', async () => {
    const result = await isModuleEnabled('tenant-sem-erp', 'erp')
    expect(result).toBe(false)
  })

  it('módulo core está habilitado para ambos', async () => {
    expect(await isModuleEnabled('tenant-com-erp', 'core')).toBe(true)
    expect(await isModuleEnabled('tenant-sem-erp', 'core')).toBe(true)
  })
})
```

---

### src/__tests__/onboarding.test.ts

```typescript
import * as adminRepo from '../modules/admin/admin.repository'
import * as runner    from '../migrations/runner'
import { onboardTenant } from '../modules/admin/admin.service'

jest.mock('../modules/admin/admin.repository')
jest.mock('../migrations/runner')

const mockInsertTenant      = adminRepo.insertTenant      as jest.Mock
const mockInsertDefaultFlags = adminRepo.insertDefaultFlags as jest.Mock
const mockSchemaExists      = adminRepo.tenantSchemaExists as jest.Mock
const mockRunMigrations     = runner.runMigrationsForSchema as jest.Mock

describe('onboardTenant', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    mockSchemaExists.mockResolvedValue(false)
    mockInsertTenant.mockResolvedValue(undefined)
    mockInsertDefaultFlags.mockResolvedValue(undefined)
    mockRunMigrations.mockResolvedValue(undefined)
  })

  it('cria tenant com sucesso e retorna os dados', async () => {
    const result = await onboardTenant({ name: 'Empresa Gamma', schemaName: 'schema_gamma' })

    expect(result.name).toBe('Empresa Gamma')
    expect(result.schemaName).toBe('schema_gamma')
    expect(result.tenantId).toBeTruthy()
    expect(mockInsertTenant).toHaveBeenCalledTimes(1)
    expect(mockInsertDefaultFlags).toHaveBeenCalledTimes(1)
    expect(mockRunMigrations).toHaveBeenCalledWith('schema_gamma')
  })

  it('lança 409 se o schemaName já existe', async () => {
    mockSchemaExists.mockResolvedValue(true)

    await expect(
      onboardTenant({ name: 'Duplicado', schemaName: 'schema_alpha' })
    ).rejects.toMatchObject({ statusCode: 409 })
  })

  it('lança 400 se schemaName tem caracteres inválidos', async () => {
    await expect(
      onboardTenant({ name: 'Inválido', schemaName: 'Schema-Invalido!' })
    ).rejects.toMatchObject({ statusCode: 400 })
  })

  it('chama runMigrationsForSchema com o schemaName correto', async () => {
    await onboardTenant({ name: 'Empresa Delta', schemaName: 'schema_delta' })
    expect(mockRunMigrations).toHaveBeenCalledWith('schema_delta')
  })
})
```

---

## SQL adicional para rodar no MySQL

Execute este script para garantir que os schemas dos tenants de teste existam
e que as migrations possam ser aplicadas neles:

```sql
-- Garante que os schemas de teste existem
CREATE SCHEMA IF NOT EXISTS `schema_alpha`;
CREATE SCHEMA IF NOT EXISTS `schema_beta`;
```

---

## Critério de sucesso da Semana 2

Execute cada validação abaixo antes de encerrar:

### 1. Migrations na inicialização
Ao rodar `npm run dev`, o log deve mostrar:
```
[INFO] Iniciando migrations...
[INFO] Migration aplicada: 001 - create_migrations_table { schemaName: 'schema_alpha' }
[INFO] Migration aplicada: 002 - create_base_tables { schemaName: 'schema_alpha' }
[INFO] Migrations concluídas para todos os tenants
[INFO] Setes API rodando na porta 3000
```

### 2. Migrations idempotentes
Reinicie o servidor. O log deve mostrar:
```
[INFO] Migrations: nenhuma pendente { schemaName: 'schema_alpha' }
```
Nenhuma migration deve ser aplicada duas vezes.

### 3. Onboarding de novo tenant (use token setes_admin)
```
POST /api/admin/tenants
Authorization: Bearer <token_setes_admin>
Content-Type: application/json

{ "name": "Empresa Gamma", "schemaName": "schema_gamma" }
```
Resposta esperada `201`:
```json
{ "ok": true, "data": { "tenantId": "...", "name": "Empresa Gamma", "schemaName": "schema_gamma" } }
```

### 4. Schema criado e migrations aplicadas
No MySQL, confirme:
```sql
USE schema_gamma;
SHOW TABLES;
-- deve listar: _migrations, users, audit_log

SELECT * FROM _migrations;
-- deve listar as 2 migrations aplicadas
```

### 5. Onboarding bloqueado para client_user
```
POST /api/admin/tenants
Authorization: Bearer <token_client_user>
```
Resposta esperada: `403`

### 6. Onboarding bloqueado para schema duplicado
```
POST /api/admin/tenants
Authorization: Bearer <token_setes_admin>
{ "name": "Qualquer", "schemaName": "schema_alpha" }
```
Resposta esperada: `409`

### 7. Testes automatizados passando
```bash
npm test
```
Saída esperada: todos os testes em verde, sem falhas.

---

## Instruções finais para o Claude Desktop

- Instale as novas dependências com `npm install --save-dev jest ts-jest @types/jest supertest @types/supertest`
- Crie todos os arquivos novos listados acima
- Aplique apenas as alterações indicadas nos arquivos existentes (`server.ts` e `router.ts`)
- Rode o SQL adicional no MySQL antes de iniciar o servidor
- Valide todos os 7 critérios de sucesso antes de encerrar
- Não remova nem altere nenhum arquivo da Fase 1 que não esteja listado aqui
