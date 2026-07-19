# Swagger Documentation — setes-api

**Status**: Vigente — cobertura COMPLETA desde 2026-07-12 (61 paths / 83 operações)
**Regra inegociável**: TODO endpoint criado ou alterado ganha bloco `@swagger` JSDoc
no arquivo de rotas, na MESMA entrega. Endpoint sem Swagger = tarefa incompleta.

---

## 🚀 Acessar

```bash
cd D:\Gestao2027\setes-api
npm run dev
```

- **Swagger UI**: http://localhost:3000/docs
- **OpenAPI JSON**: http://localhost:3000/docs.json (importável no Postman/Insomnia)

---

## ⚠️ Como o swagger-jsdoc encontra a documentação (lição de 2026-07-12)

O spec é gerado APENAS dos arquivos que casam com os globs `apis` em
`src/shared/swagger/swagger-config.ts`:

```ts
apis: [
  './src/app.ts',                          // /health
  './src/shared/swagger/swagger-endpoints.ts',
  './src/modules/**/*.routes.ts',          // todos os módulos
  './src/modules/sync/endpoints/*.ts',     // endpoints do Sincronizador
]
```

**Bloco `@swagger` em arquivo fora desses padrões NÃO aparece no /docs** — foi
exatamente o que aconteceu quando 43 rotas foram documentadas mas o config só
escaneava app.ts. Regras derivadas:

1. Doc da rota vive no `<modulo>.routes.ts` (ou `sync/endpoints/<recurso>.ts`)
2. Criou arquivo de rotas com outro padrão de nome? Adicione o glob no config
3. Validação final SEMPRE inclui recarregar /docs e conferir a rota nova

---

## 🔐 Security schemes (definidos no swagger-config.ts)

| Scheme | Uso | Header |
|---|---|---|
| `BearerAuth` | rotas `/api/*` | `Authorization: Bearer <jwt>` |
| `ApiKeyAuth` | rotas `/sync/*` (Sincronizador) | `X-Api-Key: <SYNC_API_KEY>` |
| `security: []` | públicas: /health, /auth/login, /auth/recovery-password, /auth/change-password | — |

`/auth/select-institution` usa Bearer com o selectionToken; `/auth/switch-institution` usa JWT normal.

---

## 📝 Template do bloco @swagger

```typescript
/**
 * @swagger
 * /api/<modulo>:
 *   get:
 *     summary: Listar <coisas>
 *     tags: [<Modulo>]            # tag = nome do módulo (agrupa no UI)
 *     security:
 *       - BearerAuth: []          # ou ApiKeyAuth (sync) ou [] (pública)
 *     responses:
 *       200: { description: 'Envelope { ok, data }' }
 *       400: { description: Validação }
 *       401: { description: Não autenticado }
 *       403: { description: Sem autorização }
 *       500: { description: Erro interno }
 */
```

Padrões: responses 200/201 + 400/401/403/500; requestBody nos POST/PUT com o
shape do DTO Zod; parameters nos GET com query/path params; envelope documentado
(`{ ok, data }`, `{ ok, token }`, `{ error }`).

---

## 📊 Cobertura atual (2026-07-12)

| Grupo | Rotas | Auth |
|---|---|---|
| Health | 1 | pública |
| Auth | 5 (login, select-institution, recovery-password, change-password, switch-institution) | públicas + tokens |
| Cadastros simétricos | 30 (countries, states, cities, interfaces, privileges, institutions × 5) | BearerAuth + superGuard |
| Admin | 3 | BearerAuth + super |
| Core | 5 | BearerAuth |
| ERP | 1 | BearerAuth |
| Sync | 34 (push, pull, status, log + 30 `/<recurso>/sincronize`) | ApiKeyAuth |

Total: 61 paths / 83 operações. Componentes reutilizáveis no config:
`SuccessResponse`, `ErrorResponse`, `HealthResponse`.

---

*Documentação atualizada: 2026-07-12*
