# Skill: Adicionar Novo Endpoint ERP

**Objetivo**: Criar novo endpoint de negócio em setes-api  
**Tempo**: ~15 minutos

---

## ⚠️ ESCOPO desta skill (atualizado 2026-07-11)

Esta skill cobre endpoints AVULSOS em módulos legados (erp, core, admin, sync),
que ainda usam Repository → Service → Routes.

**Módulo de CADASTRO (CRUD que vira tela no setes-app) NÃO usa esta skill**: use
`novo-modulo.md` + `Infra-IA/setes-api/ARQUITETURA_MODULOS_API.md` — padrão
simétrico de 6 arquivos (interface/dto/repository/service/controller/routes),
1 módulo por cadastro com o mesmo nome do módulo do app. Módulos legados migram
para o padrão novo quando forem tocados.

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

## 📖 Passo 6: Swagger (OBRIGATÓRIO — nunca pular)

Todo endpoint criado/alterado DEVE ter o bloco `@swagger` no arquivo de rotas
(como no exemplo do Passo 3), com: tag do módulo, `security` correto
(`BearerAuth` para /api/*, `ApiKeyAuth` para /sync/*, `[]` para públicas) e
responses 200/201/400/401/403/500.

⚠️ O swagger-jsdoc SÓ lê arquivos que casam com os globs `apis` de
`src/shared/swagger/swagger-config.ts` (hoje: `src/modules/**/*.routes.ts` e
`src/modules/sync/endpoints/*.ts`). Rota documentada em arquivo fora desses
padrões NÃO aparece no /docs — nomeie o arquivo `*.routes.ts` ou adicione o glob.

Validar: recarregar http://localhost:3000/docs e conferir a rota nova.

---

*Skill atualizada: 2026-07-12*

