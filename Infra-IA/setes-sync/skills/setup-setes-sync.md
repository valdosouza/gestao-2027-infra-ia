# Skill: Setup Completo de setes-sync

**Objetivo**: Configurar setes-sync do zero para produção  
**Tempo**: ~20 minutos  
**Prerequisitos**: Node.js 18+, npm 9+, MySQL rodando, X-Api-Key geradas

---

## 📋 Checklist Pré-Setup

- [ ] Node.js 18+ instalado: `node --version`
- [ ] npm 9+ instalado: `npm --version`
- [ ] MySQL rodando: `mysql -u root -p -e "SELECT 1"`
- [ ] Banco `setes_central` existe
- [ ] Arquivo `.env` preparado com credenciais

---

## 🚀 Passo 1: Clonar/Preparar Estrutura

```bash
cd D:\Gestao2027\setes-sync
```

**Verificar pasta existe com estrutura**:
```
setes-sync/
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

**Esperado**: ~150-200 pacotes instalados  
**Verificar**: `npm list express jsonwebtoken mysql2`

---

## 📝 Passo 3: Configurar .env

Copiar de `.env.example` e preencher:

```env
# Server
PORT=3001
NODE_ENV=development

# JWT (para sync log)
JWT_SECRET=sua_chave_secreta_aqui

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
RATE_LIMIT_MAX_REQUESTS=500

# Logging
LOG_LEVEL=info
```

---

## 🔌 Passo 4: Testar Conexão MySQL

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

**Esperado**: `✅ MySQL conectado!`

---

## 🏗️ Passo 5: Gerar Swagger Docs

Executar script de geração:

```bash
npm run build:swagger
```

**Esperado**: Arquivo `src/shared/swagger/swagger.json` gerado

---

## 🎯 Passo 6: Iniciar Servidor

```bash
npm run dev
```

**Esperado na saída**:
```
[INFO] Setes Sync API rodando na porta 3001
```

---

## ✅ Passo 7: Validar Setup

### 7a. Health Check

```bash
curl http://localhost:3001/health
```

**Resposta esperada**:
```json
{
  "status": "ok",
  "ts": "2026-07-01T10:30:00.000Z",
  "api": "setes-sync"
}
```

### 7b. Acessar Swagger UI

```
http://localhost:3001/docs
```

**Esperado**: Interface Swagger com 23 endpoints listados

### 7c. Testar com API Key

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-a-key-12345" \
  -d '{
    "customers": [
      {"id": 1, "name": "Test Customer"}
    ]
  }'
```

**Resposta esperada**:
```json
{
  "ok": true,
  "inserted": 1,
  "updated": 0,
  "message": "Sincronização concluída"
}
```

---

## 🔧 Troubleshooting

### Erro: "connect ECONNREFUSED 127.0.0.1:3306"

**Solução**:
1. Verificar MySQL rodando: `mysql -u root -p -e "SELECT 1"`
2. Verificar credenciais em `.env`
3. Reiniciar MySQL se necessário

### Erro: "Unknown database 'setes_central'"

**Solução**:
```bash
mysql -u root -p < setup-multi-tenant.sql
```

### Erro: "Invalid API Key"

**Solução**:
```sql
USE setes_central;
SELECT * FROM sync_api_keys WHERE active = TRUE;
```

Confirmar que a chave usada existe e está ativa.

---

## 📊 Passo 8: Verificar Logs

```bash
# Ver logs da sincronização
curl "http://localhost:3001/logs?tenant=cliente-a" \
  -H "X-Api-Key: cliente-a-key-12345"
```

---

## 🎉 Setup Completo!

Quando todos os passos passarem:

- ✅ setes-sync rodando em `http://localhost:3001`
- ✅ Swagger acessível em `http://localhost:3001/docs`
- ✅ Health check passando
- ✅ Multi-tenant operacional
- ✅ Pronto para sincronização

---

## 📝 Notas

- **Desenvolvimento**: Use `npm run dev` para auto-reload
- **Build**: Use `npm run build` para compilar TypeScript
- **Produção**: Use `npm start` após build

---

*Skill atualizada: 2026-07-01*

