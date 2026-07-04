# Skill: Adicionar Novo Endpoint de Sincronização

**Objetivo**: Criar novo endpoint de sync em setes-sync  
**Tempo**: ~15 minutos  
**Exemplo**: Criando endpoint `/new-entity/sincronize`

---

## 📋 Template de Novo Endpoint

### Estrutura de Arquivos

```
src/modules/sync/new-entity/
├── new-entity.routes.ts        (rotas HTTP)
├── new-entity.service.ts       (lógica de negócio)
├── new-entity.repository.ts    (acesso a dados)
└── new-entity.types.ts         (tipos TypeScript)
```

---

## 🔧 Passo 1: Criar Tipos TypeScript

**Arquivo**: `src/modules/sync/new-entity/new-entity.types.ts`

```typescript
export interface NewEntity {
  id: number
  name: string
  description?: string
  active: boolean
  created_at?: Date
  updated_at?: Date
}

export interface SyncNewEntityRequest {
  newEntities: NewEntity[]
}

export interface SyncResponse {
  ok: boolean
  inserted: number
  updated: number
  errors: number
  message: string
}
```

---

## 📦 Passo 2: Criar Repository

**Arquivo**: `src/modules/sync/new-entity/new-entity.repository.ts`

```typescript
import { getConnection } from '@shared/db/connection'
import { NewEntity } from './new-entity.types'

export async function insertNewEntity(
  schemaName: string,
  entity: NewEntity
): Promise<{ inserted: number; updated: number }> {
  const conn = await getConnection(schemaName)
  
  try {
    await conn.beginTransaction()
    
    const [result] = await conn.query(
      `INSERT INTO tb_new_entity (id, name, description, active, created_at)
       VALUES (?, ?, ?, ?, NOW())
       ON DUPLICATE KEY UPDATE
         name = ?, description = ?, active = ?, updated_at = NOW()`,
      [entity.id, entity.name, entity.description, entity.active || 1,
       entity.name, entity.description, entity.active || 1]
    )
    
    await conn.commit()
    
    return {
      inserted: (result as any).affectedRows || 0,
      updated: 0
    }
  } catch (err) {
    await conn.rollback()
    throw err
  } finally {
    conn.release()
  }
}

export async function syncNewEntities(
  schemaName: string,
  entities: NewEntity[]
): Promise<{ inserted: number; updated: number; errors: number }> {
  let inserted = 0
  let updated = 0
  let errors = 0

  for (const entity of entities) {
    try {
      const result = await insertNewEntity(schemaName, entity)
      inserted += result.inserted
      updated += result.updated
    } catch (err) {
      errors++
    }
  }

  return { inserted, updated, errors }
}
```

---

## 🎯 Passo 3: Criar Service

**Arquivo**: `src/modules/sync/new-entity/new-entity.service.ts`

```typescript
import { syncNewEntities } from './new-entity.repository'
import { NewEntity, SyncResponse } from './new-entity.types'
import logger from '@shared/logger/logger'

export async function handleNewEntitySync(
  schemaName: string,
  entities: NewEntity[]
): Promise<SyncResponse> {
  try {
    logger.info(`[NewEntity] Sincronizando ${entities.length} registros`, {
      schema: schemaName
    })

    const result = await syncNewEntities(schemaName, entities)

    logger.info(`[NewEntity] Sincronização concluída`, result)

    return {
      ok: result.errors === 0,
      inserted: result.inserted,
      updated: result.updated,
      errors: result.errors,
      message: `${result.inserted} inserido(s), ${result.updated} atualizado(s), ${result.errors} erro(s)`
    }
  } catch (err) {
    logger.error(`[NewEntity] Erro na sincronização`, { err })
    return {
      ok: false,
      inserted: 0,
      updated: 0,
      errors: entities.length,
      message: `Erro: ${(err as Error).message}`
    }
  }
}
```

---

## 🚀 Passo 4: Criar Routes

**Arquivo**: `src/modules/sync/new-entity/new-entity.routes.ts`

```typescript
import { Router, Request, Response } from 'express'
import { handleNewEntitySync } from './new-entity.service'
import { SyncNewEntityRequest } from './new-entity.types'
import logger from '@shared/logger/logger'

const router = Router()

/**
 * @swagger
 * /new-entity/sincronize:
 *   post:
 *     summary: Sincronizar Entidades Novas
 *     tags: [Sync]
 *     security:
 *       - ApiKeyAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               newEntities:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     id: { type: number }
 *                     name: { type: string }
 *                     description: { type: string }
 *                     active: { type: boolean }
 *     responses:
 *       200:
 *         description: Sincronização bem-sucedida
 *       401:
 *         description: API Key inválida
 */
router.post('/sincronize', async (req: Request, res: Response) => {
  try {
    const { tenantId, schemaName } = req.syncClient
    const { newEntities } = req.body as SyncNewEntityRequest

    if (!newEntities || !Array.isArray(newEntities)) {
      return res.status(400).json({
        error: 'Campo "newEntities" é obrigatório e deve ser um array'
      })
    }

    const result = await handleNewEntitySync(schemaName, newEntities)
    res.json(result)
  } catch (err) {
    logger.error('[NewEntity] Erro não tratado', { err })
    res.status(500).json({ error: 'Erro interno do servidor' })
  }
})

export default router
```

---

## 🔌 Passo 5: Registrar Nova Rota

**Arquivo**: `src/modules/sync/sync.specific.routes.ts`

Adicionar ao final:

```typescript
import newEntityRoutes from './new-entity/new-entity.routes'

// ... existing routes ...

router.use('/new-entity', newEntityRoutes)
```

---

## 🗄️ Passo 6: Criar Tabela no Banco

```sql
-- Executar em cada schema (schema_cliente_a, etc)
USE schema_cliente_a;

CREATE TABLE IF NOT EXISTS tb_new_entity (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_active (active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## ✅ Passo 7: Testar Novo Endpoint

```bash
# Teste com Cliente A
curl -X POST http://localhost:3001/new-entity/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-a-key-12345" \
  -d '{
    "newEntities": [
      {
        "id": 1,
        "name": "Entidade Teste",
        "description": "Descrição de teste",
        "active": true
      }
    ]
  }'
```

**Resposta esperada**:
```json
{
  "ok": true,
  "inserted": 1,
  "updated": 0,
  "errors": 0,
  "message": "1 inserido(s), 0 atualizado(s), 0 erro(s)"
}
```

---

## 📊 Passo 8: Verificar em MySQL

```sql
USE schema_cliente_a;
SELECT * FROM tb_new_entity;
```

---

## 🎉 Endpoint Completo!

Verificação final:

- ✅ Tipos TypeScript definidos
- ✅ Repository criado com lógica de BD
- ✅ Service com tratamento de erros
- ✅ Routes com Swagger documentado
- ✅ Rota registrada em sync.specific.routes.ts
- ✅ Tabela criada no banco
- ✅ Teste manual passando
- ✅ Swagger UI atualizado (recarregar `/docs`)

---

## 📝 Checklist Rápido

```bash
# 1. Criar pastas
mkdir -p src/modules/sync/new-entity

# 2. Criar 4 arquivos: .types.ts, .repository.ts, .service.ts, .routes.ts

# 3. Registrar em sync.specific.routes.ts

# 4. Criar tabela no MySQL (3 clientes)

# 5. Testar com curl

# 6. Recarregar Swagger: http://localhost:3001/docs
```

---

*Skill atualizada: 2026-07-01*

