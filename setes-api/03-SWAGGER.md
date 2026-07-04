# Swagger Documentation — setes-api

## ✅ Integração Swagger Concluída

A API setes-api agora possui documentação completa com Swagger/OpenAPI 3.0.

---

## 🚀 Acessar Documentação

Após iniciar a API:

```bash
cd D:\Gestao2027\setes-api
npm run dev
```

**Abra no navegador:**

```
http://localhost:3000/docs
```

Você verá:
- ✅ Interface interativa Swagger UI
- ✅ Todos os 5 endpoints documentados
- ✅ Modelos de requisição/resposta
- ✅ Teste de endpoints direto do navegador
- ✅ Autenticação JWT integrada

---

## 📚 Arquivos Criados

```
setes-api/
├── src/shared/swagger/
│   ├── swagger-config.ts        (Definição OpenAPI 3.0)
│   └── swagger-endpoints.ts     (Documentação dos 5 endpoints)
└── src/app.ts                   (Atualizado com Swagger)
```

---

## 🔍 Exemplo: Testar endpoint no Swagger UI

### 1. Abra http://localhost:3000/docs

### 2. Clique em "Authorize" (cadeado)
Adicione seu JWT token:
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 3. Expanda endpoint "GET /api/core/info"

### 4. Clique em "Try it out"

### 5. Clique em "Execute"

### 6. Veja resposta:
```json
{
  "ok": true,
  "data": {
    "id": "tenant-001",
    "name": "Empresa Alpha",
    "schema_name": "schema_alpha",
    "active": true
  }
}
```

---

## 📋 5 Endpoints Documentados

### Health (sem autenticação)
- `GET /health` — Status da API

### Core (com JWT)
- `GET /api/core/info` — Informações do tenant

### ERP (com JWT)
- `GET /api/erp/status` — Status do módulo ERP

### Admin (com JWT + role setes_admin)
- `GET /api/admin/tenants` — Listar todos os tenants
- `POST /api/admin/tenants` — Criar novo tenant

---

## 🔐 Autenticação

### Health Check
```
GET /health
→ Sem autenticação
```

### Endpoints /api/*
```
Authorization: Bearer <jwt_token>
```

No Swagger UI:
1. Clique "Authorize" (cadeado no topo)
2. Digite seu token JWT
3. Todos os testes incluem a autenticação

---

## 📤 Exportar Especificação

### JSON Raw (OpenAPI 3.0)

```
http://localhost:3000/docs.json
```

### Usar em outras ferramentas:

**Postman**
1. Import → Paste raw text
2. Cole: `http://localhost:3000/docs.json`
3. Todos os endpoints importados

**Insomnia**
1. Design → Create → Paste OpenAPI URL
2. URL: `http://localhost:3000/docs.json`

---

## 🛠️ Estrutura Técnica

### swagger-config.ts

Define:
- Info da API (título, versão, descrição)
- Servidores (dev, prod)
- Security schemes (BearerAuth - JWT)
- Componentes reutilizáveis (SuccessResponse, ErrorResponse, HealthResponse)

### swagger-endpoints.ts

Documentação JSDoc de cada endpoint:
```typescript
/**
 * @swagger
 * /api/core/info:
 *   get:
 *     summary: Obter Informações do Tenant
 *     description: Retorna informações do tenant autenticado
 *     tags: [Core]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200: { description: Sucesso }
 *       401: { description: Token ausente }
 */
```

### app.ts

Registro das rotas Swagger:
```typescript
import { swaggerSpec } from '@shared/swagger/swagger-config'
import swaggerUi from 'swagger-ui-express'

app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec))
app.get('/docs.json', (_, res) => res.send(swaggerSpec))
```

---

## 📊 Endpoints por Tag

### Health
- GET /health (sem autenticação)

### Core
- GET /api/core/info (JWT)

### ERP
- GET /api/erp/status (JWT + feature flag)

### Admin
- GET /api/admin/tenants (JWT + setes_admin)
- POST /api/admin/tenants (JWT + setes_admin)

---

## ✨ Benefícios

✅ **Documentação sempre sincronizada** — JSDoc + código  
✅ **Teste interativo** — Sem precisar de Postman  
✅ **Especificação exportável** — OpenAPI 3.0 JSON  
✅ **Compatível** — Postman, Insomnia, ReDoc  
✅ **Autenticação integrada** — JWT no Swagger UI  

---

## 🔗 URLs Importantes

- **API Live**: `http://localhost:3000` (quando rodando)
- **Swagger UI**: `http://localhost:3000/docs`
- **OpenAPI JSON**: `http://localhost:3000/docs.json`
- **Projeto**: `D:\Gestao2027\setes-api`

---

## 🧪 Como Testar Localmente

### Terminal 1: Iniciar API
```bash
cd D:\Gestao2027\setes-api
npm install
npm run dev
```

### Terminal 2: Acessar Swagger
```
http://localhost:3000/docs
```

### Terminal 3: Gerar JWT (opcional)
```bash
# Usar script generate-token.ts ou JWT pré-gerado
node src/scripts/generate-token.ts
```

### Teste:
1. Abra http://localhost:3000/docs
2. Clique Authorize
3. Cole o JWT
4. Teste cada endpoint

---

## 📝 Notas

- **Porta**: 3000 (setes-api)
- **Swagger UI**: Habilitado em desenvolvimento
- **Endpoints**: 5 totais (1 health + 4 com JWT)
- **Autenticação**: JWT (Bearer token)
- **Feature Flags**: Aplicadas em /api/erp
- **Role-based**: Admin endpoints requerem setes_admin

---

*Documentação atualizada: 2026-07-01*
