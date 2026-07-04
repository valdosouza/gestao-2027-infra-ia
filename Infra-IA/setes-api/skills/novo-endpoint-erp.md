# Skill: Adicionar Novo Endpoint ERP

**Objetivo**: Criar novo endpoint de negócio em setes-api  
**Tempo**: ~15 minutos

---

## 🏗️ Estrutura

```
src/modules/erp/
├── new-feature.routes.ts
├── new-feature.service.ts
└── new-feature.repository.ts
```

---

## 📝 Passo 1: Repository

**Arquivo**: `src/modules/erp/new-feature.repository.ts`

```typescript
import { getConnection } from '@shared/db/connection'

export async function getFeatureData(schemaName: string, id: number) {
  const conn = await getConnection(schemaName)
  try {
    const [rows] = await conn.query(
      'SELECT * FROM tb_feature WHERE id = ?',
      [id]
    )
    return rows[0] || null
  } finally {
    conn.release()
  }
}
```

---

## 🎯 Passo 2: Service

**Arquivo**: `src/modules/erp/new-feature.service.ts`

```typescript
import { getFeatureData } from './new-feature.repository'

export async function handleGetFeature(schemaName: string, id: number) {
  const data = await getFeatureData(schemaName, id)
  if (!data) {
    throw new Error('Feature não encontrada')
  }
  return data
}
```

---

## 🚀 Passo 3: Routes

**Arquivo**: `src/modules/erp/new-feature.routes.ts`

```typescript
import { Router, Request, Response } from 'express'
import { handleGetFeature } from './new-feature.service'

const router = Router()

/**
 * @swagger
 * /api/erp/feature/{id}:
 *   get:
 *     summary: Obter Feature
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: number }
 *     responses:
 *       200: { description: OK }
 *       404: { description: Não encontrado }
 */
router.get('/feature/:id', async (req: Request, res: Response) => {
  try {
    const data = await handleGetFeature(
      req.tenant!.schemaName,
      Number(req.params.id)
    )
    res.json({ ok: true, data })
  } catch (err) {
    res.status(404).json({ error: (err as Error).message })
  }
})

export default router
```

---

## 🔌 Passo 4: Registrar

**Arquivo**: `src/gateway/router.ts`

```typescript
import newFeatureRoutes from '@modules/erp/new-feature.routes'

router.use('/erp', newFeatureRoutes)
```

---

## ✅ Passo 5: Testar

```bash
TOKEN="seu_jwt_aqui"

curl -X GET http://localhost:3000/api/erp/feature/1 \
  -H "Authorization: Bearer $TOKEN"
```

---

*Skill atualizada: 2026-07-01*

