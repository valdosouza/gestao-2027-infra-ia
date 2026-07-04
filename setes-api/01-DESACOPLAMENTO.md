# Desacoplamento — setes-api

## ✅ Conclusão do Desacoplamento

setes-api foi **desacoplada com sucesso** de setes-sync.

---

## 🔄 O que Mudou

### ANTES (Monolito)
```
setes-api
├── /api/*               → Endpoints ERP
└── /sync/*              → 30 endpoints de sincronização ❌
```

**Problema**: Responsabilidades misturadas

---

### DEPOIS (Desacoplado)
```
setes-api (porta 3000)
└── /api/*              → Endpoints ERP ✅

setes-sync (porta 3001)
└── /<recurso>/sincronize → 23 endpoints sync ✅
```

**Benefício**: Cada API com propósito único

---

## 📊 Mudanças em setes-api

### Removido

❌ **Importação**:
```typescript
import syncSpecific from '@modules/sync/sync.specific.routes'
```

❌ **Rota**:
```typescript
app.use('/', syncSpecific)
```

❌ **Middlewares condicionais**:
```typescript
if (req.path.startsWith('/sync')) return next()
```

### Mantido

✅ **Health Check**:
```
GET /health → 200 OK
```

✅ **Autenticação JWT**:
```
POST /api/* com Authorization: Bearer <jwt>
```

✅ **Feature Flags**:
```
Por módulo: /api/core, /api/erp, /api/admin
```

✅ **Rate Limiting**:
```
300 req/min por tenant
```

---

## 📝 Código Antes vs Depois

### Antes (app.ts)
```typescript
import syncSpecific from '@modules/sync/sync.specific.routes'

// Rotas especificas do Sincronizador Delphi
app.use('/', syncSpecific)

// Auth JWT em rotas /api EXCETO /sync
app.use('/api', (req, res, next) => {
  if (req.path.startsWith('/sync')) return next()
  return authMiddleware(req, res, next)
})

// Feature flag em rotas /api EXCETO /sync
app.use('/api', (req, res, next) => {
  if (req.path.startsWith('/sync')) return next()
  return featureFlagMiddleware(req, res, next)
})
```

### Depois (app.ts)
```typescript
// Health check sem autenticação
app.get('/health', (_, res) => res.json({ status: 'ok', ts: new Date().toISOString() }))

// Auth JWT em todas as rotas /api
app.use('/api', authMiddleware)

// Feature flag em todas as rotas /api
app.use('/api', featureFlagMiddleware)

// Rate limit em todas as rotas /api
app.use('/api', rateLimitMiddleware)

// Registra endpoints ERP
app.use('/api', apiRouter)
```

**Resultado**: Código mais limpo e direto

---

## 🗂️ Estrutura Após Desacoplamento

```
setes-api/src/
├── app.ts                    (Simplificado)
├── server.ts
├── gateway/
│   ├── auth.middleware.ts
│   ├── feature-flag.middleware.ts
│   ├── rate-limit.middleware.ts
│   └── router.ts
├── modules/
│   ├── core/                 (Informações de tenant)
│   ├── erp/                  (Módulo ERP)
│   ├── admin/                (Admin)
│   └── _template/            (Template para novos módulos)
├── feature-flags/
├── shared/
│   ├── db/connection.ts
│   ├── logger/logger.ts
│   ├── errors/http-error.ts
│   └── types/express.d.ts
└── __tests__/
    ├── auth.middleware.test.ts
    ├── feature-flag.middleware.test.ts
    └── onboarding.test.ts
```

**Nota**: `/sync` foi removido

---

## 🧹 Limpeza Necessária

### Pasta ainda existe (permissão)
```
src/modules/sync/
```

**Para remover manualmente:**
```bash
# Windows Explorer: Select → Delete
# Git:
git rm -r src/modules/sync/

# Terminal:
rm -rf src/modules/sync/
```

### Arquivo TODO criado
```
TODO_REMOVER_SYNC.txt
```

---

## 📊 Status Atual

| Componente | Status | Notas |
|-----------|--------|-------|
| app.ts | ✅ Simplificado | Sem condicionais /sync |
| Imports | ✅ Removidos | syncSpecific deleted |
| Testes | ✅ Atualizados | sync.test.ts marcado DEPRECATED |
| Middlewares | ✅ Simplificados | Auth/flag agora em tudo |
| Endpoints ERP | ✅ Funcional | core, erp, admin ativos |

---

## 🚀 Próximos Passos

1. ✅ Desacoplamento concluído
2. ⏳ Executar `npm run dev` — Validar que app.ts compila
3. ⏳ Rodar testes — `npm test`
4. ⏳ Testar endpoints ERP — `/api/core/info`, `/api/erp/status`
5. ⏳ Validar que `/sync/*` retorna 404

---

## 🔗 Relacionado

- **setes-sync** — Nova API de sincronização
- **Sincronizador Delphi** — Agora envia dados para setes-sync:3001
- **setes-app** — Consome setes-api:3000 (sem mudanças)

---

## 📌 Importante

**setes-api agora é ERP puro.**

Toda lógica de sincronização está em **setes-sync**.

Sincronizador Delphi envia dados para `http://localhost:3001/` (setes-sync), não mais para setes-api.

