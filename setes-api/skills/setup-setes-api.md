# Skill: Setup Completo de setes-api

**Objetivo**: Configurar setes-api do zero para produção  
**Tempo**: ~15 minutos  
**Prerequisitos**: Node.js 18+, npm 9+, MySQL rodando, JWT_SECRET gerada

---

## 🚀 Passo 1: Preparar Estrutura

```bash
cd D:\Gestao2027\setes-api
```

**Verificar estrutura**:
```
setes-api/
├── src/
│   ├── gateway/
│   ├── modules/
│   ├── shared/
│   ├── app.ts
│   └── server.ts
├── package.json
├── tsconfig.json
└── .env
```

---

## 🛠️ Passo 2: Instalar Dependências

```bash
npm install
```

**Verificar**: `npm list express jsonwebtoken mysql2`

---

## 📝 Passo 3: Configurar .env

```env
# Server
PORT=3000
NODE_ENV=development

# JWT
JWT_SECRET=sua_chave_secreta_super_segura_aqui

# MySQL
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=setes_central

# Feature Flags
FLAG_CACHE_TTL_MS=60000

# Rate Limit
RATE_LIMIT_WINDOW_MS=60000
RATE_LIMIT_MAX_REQUESTS=300

# Logging
LOG_LEVEL=info
```

⚠️ **Importante**: JWT_SECRET deve ser **igual** em setes-sync e setes-api!

---

## 🔌 Passo 4: Testar Conexão

```bash
npx ts-node -e "
const mysql = require('mysql2/promise');
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'sua_senha',
  database: 'setes_central'
});

pool.getConnection().then(conn => {
  console.log('✅ MySQL conectado!');
  conn.release();
}).catch(err => {
  console.error('❌ Erro:', err.message);
});
"
```

---

## 🎯 Passo 5: Gerar JWT de Teste

```bash
npx ts-node -e "
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET || 'sua_chave_secreta_aqui';

const token = jwt.sign({
  tenantId: 'cliente-a',
  userId: 'user-001',
  role: 'client_user',
  schemaName: 'schema_cliente_a'
}, secret, { expiresIn: '24h' });

console.log('Token gerado:');
console.log(token);
"
```

**Copiar token para testes**

---

## 🏗️ Passo 6: Iniciar Servidor

```bash
npm run dev
```

**Esperado**:
```
[INFO] Setes API rodando na porta 3000
```

---

## ✅ Passo 7: Validar Setup

### 7a. Health Check (sem autenticação)

```bash
curl http://localhost:3000/health
```

**Resposta**:
```json
{
  "status": "ok",
  "ts": "2026-07-01T10:30:00.000Z"
}
```

### 7b. Acessar Swagger

```
http://localhost:3000/docs
```

**Esperado**: 5 endpoints listados

### 7c. Teste com JWT

```bash
# Usar o token gerado no Passo 5
TOKEN="seu_token_aqui"

curl -X GET http://localhost:3000/api/core/info \
  -H "Authorization: Bearer $TOKEN"
```

**Resposta esperada**:
```json
{
  "ok": true,
  "data": {
    "id": "cliente-a",
    "name": "Empresa Alpha",
    "schema_name": "schema_cliente_a",
    "active": true
  }
}
```

### 7d. Teste ERP Status

```bash
curl -X GET http://localhost:3000/api/erp/status \
  -H "Authorization: Bearer $TOKEN"
```

**Resposta**:
```json
{
  "ok": true,
  "module": "erp",
  "tenantId": "cliente-a",
  "message": "Módulo ERP ativo"
}
```

---

## 🔧 Troubleshooting

### Erro: "Invalid token"

**Solução**: Regenerar JWT com JWT_SECRET correto

### Erro: "Tenant not found"

**Solução**: Verificar tenant em setes_central:
```sql
SELECT * FROM tenants WHERE id = 'cliente-a';
```

### Erro: "ECONNREFUSED"

**Solução**: MySQL não está rodando

---

## 🎉 Setup Completo!

Quando todos os passos passarem:

- ✅ setes-api rodando em `http://localhost:3000`
- ✅ Swagger acessível em `http://localhost:3000/docs`
- ✅ Health check passando
- ✅ JWT funcionando
- ✅ Endpoints ERP operacionais

---

## 📚 Scripts Úteis

```bash
# Desenvolvimento com auto-reload
npm run dev

# Build TypeScript
npm run build

# Produção (após build)
npm start

# Limpeza
npm run clean
```

---

*Skill atualizada: 2026-07-01*

