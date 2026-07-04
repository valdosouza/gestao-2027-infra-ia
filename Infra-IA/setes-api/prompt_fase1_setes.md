# Prompt — Fase 1: Criação do projeto Setes API

## Contexto

Você vai criar do zero um projeto Node.js + TypeScript chamado `setes-api`.
É um monolito modular multi-tenant para atender entre 200 e 1.000 clientes empresariais.
Cada cliente é identificado por um `tenantId` contido no JWT de autenticação.
O banco de dados é MySQL com um schema por cliente (ex: `schema_cliente_001`).

---

## O que você deve criar

### 1. Estrutura de pastas

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
│   │   │   ├── core.routes.ts
│   │   │   ├── core.service.ts
│   │   │   └── core.repository.ts
│   │   ├── erp/
│   │   │   ├── erp.routes.ts
│   │   │   ├── erp.service.ts
│   │   │   └── erp.repository.ts
│   │   └── _template/
│   │       ├── template.routes.ts
│   │       ├── template.service.ts
│   │       └── template.repository.ts
│   ├── feature-flags/
│   │   ├── flag.service.ts
│   │   └── flag.repository.ts
│   ├── shared/
│   │   ├── types/
│   │   │   └── express.d.ts
│   │   ├── db/
│   │   │   └── connection.ts
│   │   ├── errors/
│   │   │   └── http-error.ts
│   │   └── logger/
│   │       └── logger.ts
│   ├── app.ts
│   └── server.ts
├── .env.example
├── .gitignore
├── package.json
└── tsconfig.json
```

---

### 2. Dependências (package.json)

```json
{
  "name": "setes-api",
  "version": "1.0.0",
  "scripts": {
    "dev": "ts-node-dev --respawn --transpile-only src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "jsonwebtoken": "^9.0.2",
    "express-rate-limit": "^7.1.5",
    "mysql2": "^3.6.5",
    "dotenv": "^16.3.1",
    "zod": "^3.22.4"
  },
  "devDependencies": {
    "@types/express": "^4.17.21",
    "@types/jsonwebtoken": "^9.0.5",
    "@types/node": "^20.10.0",
    "typescript": "^5.3.2",
    "ts-node-dev": "^2.0.0"
  }
}
```

---

### 3. tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "baseUrl": "./src",
    "paths": {
      "@gateway/*": ["gateway/*"],
      "@modules/*": ["modules/*"],
      "@shared/*": ["shared/*"],
      "@feature-flags/*": ["feature-flags/*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

---

### 4. .env.example

```
PORT=3000
JWT_SECRET=sua_chave_secreta_aqui
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=senha
DB_NAME=setes_central
FLAG_CACHE_TTL_MS=60000
```

---

### 5. src/shared/types/express.d.ts

Estenda o `Request` do Express para incluir os dados do tenant autenticado:

```typescript
import { Request } from 'express'

export interface TenantPayload {
  tenantId: string
  userId: string
  role: 'setes_admin' | 'client_user'
  schemaName: string
}

declare global {
  namespace Express {
    interface Request {
      tenant?: TenantPayload
    }
  }
}
```

---

### 6. src/shared/errors/http-error.ts

```typescript
export class HttpError extends Error {
  constructor(
    public statusCode: number,
    message: string
  ) {
    super(message)
    this.name = 'HttpError'
  }
}
```

---

### 7. src/shared/logger/logger.ts

Logger simples com prefixo de timestamp e nível:

```typescript
const logger = {
  info:  (msg: string, meta?: object) => console.log(`[INFO]  ${new Date().toISOString()} ${msg}`, meta ?? ''),
  warn:  (msg: string, meta?: object) => console.warn(`[WARN]  ${new Date().toISOString()} ${msg}`, meta ?? ''),
  error: (msg: string, meta?: object) => console.error(`[ERROR] ${new Date().toISOString()} ${msg}`, meta ?? ''),
}

export default logger
```

---

### 8. src/shared/db/connection.ts

Conexão MySQL com suporte a schemas por tenant:

```typescript
import mysql from 'mysql2/promise'
import dotenv from 'dotenv'
dotenv.config()

const pool = mysql.createPool({
  host:     process.env.DB_HOST,
  port:     Number(process.env.DB_PORT),
  user:     process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 20,
})

export async function getConnection(schemaName: string) {
  const conn = await pool.getConnection()
  await conn.query(`USE \`${schemaName}\``)
  return conn
}

export default pool
```

---

### 9. src/feature-flags/flag.repository.ts

```typescript
import pool from '@shared/db/connection'

export interface FeatureFlag {
  tenantId: string
  moduleKey: string
  enabled:  boolean
}

export async function getFlagsForTenant(tenantId: string): Promise<FeatureFlag[]> {
  const [rows] = await pool.query<any[]>(
    'SELECT tenant_id as tenantId, module_key as moduleKey, enabled FROM feature_flags WHERE tenant_id = ?',
    [tenantId]
  )
  return rows
}
```

---

### 10. src/feature-flags/flag.service.ts

Cache em memória com TTL configurável via `FLAG_CACHE_TTL_MS`:

```typescript
import { getFlagsForTenant, FeatureFlag } from './flag.repository'

interface CacheEntry {
  flags:     FeatureFlag[]
  expiresAt: number
}

const cache = new Map<string, CacheEntry>()
const TTL   = Number(process.env.FLAG_CACHE_TTL_MS ?? 60_000)

export async function isModuleEnabled(tenantId: string, moduleKey: string): Promise<boolean> {
  // Setes admin tem acesso a tudo
  if (tenantId === 'setes') return true

  const now    = Date.now()
  const cached = cache.get(tenantId)

  if (cached && cached.expiresAt > now) {
    return cached.flags.some(f => f.moduleKey === moduleKey && f.enabled)
  }

  const flags = await getFlagsForTenant(tenantId)
  cache.set(tenantId, { flags, expiresAt: now + TTL })
  return flags.some(f => f.moduleKey === moduleKey && f.enabled)
}

export function invalidateCache(tenantId: string) {
  cache.delete(tenantId)
}
```

---

### 11. src/gateway/auth.middleware.ts

Valida JWT e popula `req.tenant`:

```typescript
import { Request, Response, NextFunction } from 'express'
import jwt from 'jsonwebtoken'
import { TenantPayload } from '@shared/types/express'
import { HttpError } from '@shared/errors/http-error'
import logger from '@shared/logger/logger'

export function authMiddleware(req: Request, res: Response, next: NextFunction) {
  try {
    const header = req.headers.authorization
    if (!header?.startsWith('Bearer ')) throw new HttpError(401, 'Token ausente')

    const token   = header.split(' ')[1]
    const secret  = process.env.JWT_SECRET!
    const payload = jwt.verify(token, secret) as TenantPayload

    if (!payload.tenantId || !payload.role) throw new HttpError(401, 'Token inválido')

    req.tenant = payload
    logger.info('Auth OK', { tenantId: payload.tenantId, path: req.path })
    next()
  } catch (err) {
    if (err instanceof HttpError) {
      res.status(err.statusCode).json({ error: err.message })
    } else {
      res.status(401).json({ error: 'Token inválido ou expirado' })
    }
  }
}
```

---

### 12. src/gateway/feature-flag.middleware.ts

Extrai o `moduleKey` da URL e verifica permissão:

```typescript
import { Request, Response, NextFunction } from 'express'
import { isModuleEnabled } from '@feature-flags/flag.service'
import logger from '@shared/logger/logger'

export function featureFlagMiddleware(req: Request, res: Response, next: NextFunction) {
  // Formato esperado: /api/<moduleKey>/...
  const moduleKey = req.path.split('/')[2]

  if (!moduleKey) return next()

  // Setes admin passa direto
  if (req.tenant?.role === 'setes_admin') return next()

  const tenantId = req.tenant!.tenantId

  isModuleEnabled(tenantId, moduleKey)
    .then(enabled => {
      if (!enabled) {
        logger.warn('Módulo bloqueado', { tenantId, moduleKey })
        res.status(403).json({ error: `Módulo "${moduleKey}" não habilitado para este cliente` })
        return
      }
      next()
    })
    .catch(() => res.status(500).json({ error: 'Erro ao verificar permissões' }))
}
```

---

### 13. src/gateway/rate-limit.middleware.ts

Rate limit individual por tenant:

```typescript
import rateLimit from 'express-rate-limit'
import { Request } from 'express'

export const rateLimitMiddleware = rateLimit({
  windowMs:        60 * 1000,
  max:             300,
  standardHeaders: true,
  legacyHeaders:   false,
  keyGenerator:    (req: Request) => req.tenant?.tenantId ?? req.ip ?? 'anonymous',
  message:         { error: 'Limite de requisições excedido. Tente novamente em 1 minuto.' },
})
```

---

### 14. src/modules/core/core.repository.ts

```typescript
import pool from '@shared/db/connection'

export async function getTenantInfo(schemaName: string) {
  const conn = await pool.getConnection()
  try {
    const [rows] = await conn.query<any[]>(
      'SELECT id, name, active FROM setes_central.tenants WHERE schema_name = ?',
      [schemaName]
    )
    return rows[0] ?? null
  } finally {
    conn.release()
  }
}
```

---

### 15. src/modules/core/core.service.ts

```typescript
import { getTenantInfo } from './core.repository'

export async function getTenantData(schemaName: string) {
  const tenant = await getTenantInfo(schemaName)
  if (!tenant) throw new Error('Tenant não encontrado')
  return tenant
}
```

---

### 16. src/modules/core/core.routes.ts

```typescript
import { Router, Request, Response } from 'express'
import { getTenantData } from './core.service'
import logger from '@shared/logger/logger'

const router = Router()

router.get('/info', async (req: Request, res: Response) => {
  try {
    const data = await getTenantData(req.tenant!.schemaName)
    res.json({ ok: true, data })
  } catch (err) {
    logger.error('Erro em core/info', { err })
    res.status(500).json({ error: 'Erro interno' })
  }
})

export default router
```

---

### 17. src/modules/erp/erp.routes.ts

```typescript
import { Router, Request, Response } from 'express'

const router = Router()

router.get('/status', (req: Request, res: Response) => {
  res.json({
    ok:       true,
    module:   'erp',
    tenantId: req.tenant?.tenantId,
    message:  'Módulo ERP ativo',
  })
})

export default router
```

---

### 18. src/gateway/router.ts

Registra todos os módulos sob `/api`:

```typescript
import { Router } from 'express'
import coreRoutes from '@modules/core/core.routes'
import erpRoutes  from '@modules/erp/erp.routes'

const router = Router()

router.use('/core', coreRoutes)
router.use('/erp',  erpRoutes)

export default router
```

---

### 19. src/app.ts

Monta o Express com os middlewares na ordem correta:

```typescript
import express from 'express'
import dotenv from 'dotenv'
dotenv.config()

import { authMiddleware }        from '@gateway/auth.middleware'
import { featureFlagMiddleware } from '@gateway/feature-flag.middleware'
import { rateLimitMiddleware }   from '@gateway/rate-limit.middleware'
import apiRouter                 from '@gateway/router'
import logger                    from '@shared/logger/logger'

const app = express()

app.use(express.json())

// Health check — sem autenticação
app.get('/health', (_, res) => res.json({ status: 'ok', ts: new Date().toISOString() }))

// Pipeline de middlewares (ordem obrigatória)
app.use('/api', authMiddleware)
app.use('/api', featureFlagMiddleware)
app.use('/api', rateLimitMiddleware)
app.use('/api', apiRouter)

// Handler global de erros
app.use((err: Error, _req: express.Request, res: express.Response, _next: express.NextFunction) => {
  logger.error('Erro não tratado', { message: err.message })
  res.status(500).json({ error: 'Erro interno do servidor' })
})

export default app
```

---

### 20. src/server.ts

```typescript
import app from './app'
import logger from '@shared/logger/logger'

const PORT = process.env.PORT ?? 3000

app.listen(PORT, () => {
  logger.info(`Setes API rodando na porta ${PORT}`)
})
```

---

### 21. SQL de setup inicial (rode no MySQL antes de iniciar)

```sql
CREATE DATABASE IF NOT EXISTS setes_central;
USE setes_central;

CREATE TABLE IF NOT EXISTS tenants (
  id          VARCHAR(36)  PRIMARY KEY DEFAULT (UUID()),
  name        VARCHAR(255) NOT NULL,
  schema_name VARCHAR(100) NOT NULL UNIQUE,
  active      BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS feature_flags (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  tenant_id  VARCHAR(36)  NOT NULL,
  module_key VARCHAR(100) NOT NULL,
  enabled    BOOLEAN      NOT NULL DEFAULT FALSE,
  UNIQUE KEY uq_tenant_module (tenant_id, module_key)
);

-- Dados de teste
INSERT INTO tenants (id, name, schema_name) VALUES
  ('tenant-001', 'Empresa Alpha', 'schema_alpha'),
  ('tenant-002', 'Empresa Beta',  'schema_beta');

-- Alpha tem ERP habilitado, Beta não
INSERT INTO feature_flags (tenant_id, module_key, enabled) VALUES
  ('tenant-001', 'core', TRUE),
  ('tenant-001', 'erp',  TRUE),
  ('tenant-002', 'core', TRUE),
  ('tenant-002', 'erp',  FALSE);
```

---

### 22. Como gerar tokens JWT para teste

Rode este script avulso para gerar tokens de teste (não commite no repositório):

```typescript
// scripts/generate-token.ts
import jwt from 'jsonwebtoken'

const secret = 'sua_chave_secreta_aqui'

const tokenAlpha = jwt.sign(
  { tenantId: 'tenant-001', userId: 'user-001', role: 'client_user', schemaName: 'schema_alpha' },
  secret,
  { expiresIn: '24h' }
)

const tokenSetes = jwt.sign(
  { tenantId: 'setes', userId: 'admin-001', role: 'setes_admin', schemaName: 'setes_central' },
  secret,
  { expiresIn: '24h' }
)

console.log('Token Alpha (ERP habilitado):\n', tokenAlpha)
console.log('\nToken Setes Admin:\n', tokenSetes)
```

---

## Critério de sucesso

O projeto está correto quando este fluxo funcionar:

1. `GET /health` → `200 { status: 'ok' }` sem token
2. `GET /api/core/info` sem token → `401`
3. `GET /api/core/info` com token Alpha → `200` com dados do tenant
4. `GET /api/erp/status` com token Alpha → `200` (ERP habilitado)
5. `GET /api/erp/status` com token Beta → `403` (ERP bloqueado)
6. `GET /api/erp/status` com token Setes Admin → `200` (admin passa em tudo)

---

## Instruções finais para o Claude Desktop

- Crie todos os arquivos acima exatamente nessa estrutura
- Rode `npm install` após criar o `package.json`
- Configure o `.env` com as credenciais do banco local
- Rode o SQL de setup no MySQL
- Inicie com `npm run dev`
- Confirme que os 6 cenários de sucesso acima funcionam antes de encerrar
