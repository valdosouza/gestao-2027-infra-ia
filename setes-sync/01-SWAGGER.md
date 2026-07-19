# Swagger Documentation — setes-sync API
**Escopo**: setes

## ✅ Integração Concluída

A API setes-sync agora possui documentação completa com Swagger/OpenAPI 3.0.

---

## 🚀 Acessar Documentação

Após iniciar a API:

```bash
cd D:\Gestao2027\setes-sync
npm run dev
```

**Abra no navegador:**

```
http://localhost:3001/docs
```

Você verá:
- ✅ Interface interativa Swagger UI
- ✅ Todos os 23 endpoints documentados
- ✅ Modelos de requisição/resposta
- ✅ Teste de endpoints direto do navegador
- ✅ Autenticação via X-Api-Key

---

## 📚 Arquivos Criados

```
setes-sync/
├── SWAGGER.md                           (Guia completo de uso)
├── src/shared/swagger/
│   ├── swagger-config.ts                (Definição OpenAPI 3.0)
│   └── swagger-endpoints.ts             (Documentação dos 23 endpoints)
└── package.json                         (Atualizado com swagger-jsdoc e swagger-ui-express)
```

---

## 🔍 Exemplo: Testar endpoint no Swagger UI

### 1. Abra http://localhost:3001/docs

### 2. Clique em "Authorize" (cadeado)

Adicione sua X-Api-Key:
```
sua_chave_compartilhada_do_sincronizador
```

### 3. Expanda endpoint "POST /brand/sincronize"

### 4. Clique em "Try it out"

### 5. Edite o JSON:
```json
{
  "brands": [
    {"id": 1, "name": "Nike"},
    {"id": 2, "name": "Adidas"}
  ]
}
```

### 6. Clique "Execute"

### 7. Veja resposta:
```json
{
  "ok": true,
  "inserted": 2,
  "updated": 0,
  "errors": 0,
  "message": "Sincronização concluída"
}
```

---

## 📋 23 Endpoints Documentados

### Masteres
- `POST /brand/sincronize` — Marcas
- `POST /customer/sincronize` — Clientes
- `POST /category/sincronize` — Categorias
- `POST /merchandise/sincronize` — Mercadorias
- `POST /provider/sincronize` — Fornecedores
- `POST /salesman/sincronize` — Vendedores

### Financeiro
- `POST /financial/sincronize` — Dados Financeiros
- `POST /financial-plans/sincronize` — Planos Financeiros
- `POST /financial-statement/sincronize` — Extrato Financeiro

### Estoque
- `POST /stock-balance/sincronize` — Saldo de Estoque
- `POST /stock-list/sincronize` — Lista de Estoque
- `POST /stock-statement/sincronize` — Demonstrativo de Estoque
- `POST /order-stock-adjust/sincronize` — Ajustes de Estoque

### Vendas & Compras
- `POST /order-sale/sincronize` — Pedidos de Venda
- `POST /order-purchase/sincronize` — Pedidos de Compra

### Preços
- `POST /price/sincronize` — Preços
- `POST /price-list/sincronize` — Listas de Preço
- `POST /promotion/sincronize` — Promoções

### Operações
- `POST /cashier/sincronize` — Caixas
- `POST /bank-account/sincronize` — Contas Bancárias
- `POST /payment-type/sincronize` — Tipos de Pagamento
- `POST /package/sincronize` — Pacotes
- `POST /file-xml/sincronize` — Arquivos XML

---

## 🔐 Autenticação

Todos os endpoints requerem header:

```
X-Api-Key: sua_chave_compartilhada_do_sincronizador
```

No Swagger UI:
1. Clique "Authorize" (cadeado no topo)
2. Digite a chave
3. Todos os testes incluem a autenticação

---

## 📤 Exportar Especificação

### JSON Raw (OpenAPI 3.0)

```
http://localhost:3001/docs.json
```

### Usar em outras ferramentas:

**Postman**
1. Clique em "Import"
2. Cole URL: `http://localhost:3001/docs.json`
3. Todos os endpoints aparecem no Postman

**Insomnia**
1. Design → Create → Paste OpenAPI URL
2. URL: `http://localhost:3001/docs.json`

**Gerar SDK Python**
```bash
openapi-generator-cli generate \
  -i http://localhost:3001/docs.json \
  -g python \
  -o ./setes-sync-python-client
```

---

## 🛠️ Estrutura Técnica

### swagger-config.ts

Define:
- Info da API (título, versão, descrição)
- Servidores (dev, prod)
- Security schemes (X-Api-Key)
- Componentes reutilizáveis (SyncResponse, ErrorResponse)

### swagger-endpoints.ts

Documentação JSDoc de cada endpoint:
```typescript
/**
 * @swagger
 * /brand/sincronize:
 *   post:
 *     summary: Sincronizar Marcas
 *     tags: [Sincronização]
 *     ...
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

## 📱 Telas do Swagger UI

### Dashboard Principal
- Lista de endpoints organizados por tag
- Filtro de busca
- Botão "Authorize" para X-Api-Key

### Detalhe de Endpoint
- Descrição
- Parâmetros de entrada (Request Body)
- Modelos de resposta (200, 401, 500)
- Botão "Try it out"

### Teste Interativo
- Editor JSON para payload
- Executar requisição
- Ver status code + resposta
- Ver headers enviados

---

## ✨ Benefícios

✅ **Documentação sempre sincronizada** — JSDoc + código  
✅ **Teste interativo** — Sem precisar de Postman  
✅ **Especificação exportável** — OpenAPI 3.0 JSON  
✅ **Compatível** — Postman, Insomnia, ReDoc  
✅ **Geração de SDKs** — Python, Java, Go, etc  

