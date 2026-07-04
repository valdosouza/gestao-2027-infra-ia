# Multi-Tenant Configuration — setes-sync

## 🎯 Objetivo

Configurar setes-sync para:
1. Receber dados de **múltiplos sincronizadores** Delphi
2. Cada um apontando para **mesma API** (http://localhost:3001)
3. API **identifica o cliente** pelo código de Tenant
4. Grava dados no **banco correto** para cada cliente

---

## 🏗️ Arquitetura Multi-Tenant

### Estratégia: Schema por Tenant

```
Sincronizador Cliente A         Sincronizador Cliente B
        ↓                               ↓
     (Firebird)                    (Firebird)
        ↓                               ↓
        └───────────────┬───────────────┘
                        │
            POST /customer/sincronize
            X-Api-Key: cliente-a-key
            {
              "tenantId": "cliente-a",    ← Identifica cliente
              "customers": [...]
            }
                        │
        ┌───────────────▼───────────────┐
        │    setes-sync:3001             │
        │  (API centralizada)            │
        └───────────────┬───────────────┘
                        │
        ┌───────────────▼───────────────┐
        │     MySQL (Central)            │
        ├────────────────────────────────┤
        │ setes_central/                 │
        │ ├─ tenants                     │
        │ ├─ sync_api_keys               │
        │ └─ ... (config)                │
        │                                │
        │ schema_cliente_a/              │
        │ ├─ tb_customer                 │ Cliente A
        │ ├─ tb_brand                    │
        │ └─ ...                         │
        │                                │
        │ schema_cliente_b/              │
        │ ├─ tb_customer                 │ Cliente B
        │ ├─ tb_brand                    │
        │ └─ ...                         │
        └────────────────────────────────┘
```

---

## 🔑 Identificação de Tenant

### Método: X-Api-Key → tenantId

**Fluxo**:

```
1. Sincronizador envia:
   POST /customer/sincronize
   X-Api-Key: cliente-a-key
   {
     "customers": [...]
   }

2. setes-sync processa:
   a) Extrai X-Api-Key do header
   b) Valida contra sync_api_keys
   c) Obtém tenantId associado
   d) Extrai schemaName do banco
   e) Conecta em schema_cliente_a
   f) Armazena dados

3. Resultado:
   Dados de Cliente A em schema_cliente_a
   Dados de Cliente B em schema_cliente_b
   (Completamente isolados)
```

---

## 📊 Tabelas de Configuração

### sync_api_keys (setes_central)

Mapeia API Key → Tenant

```sql
CREATE TABLE sync_api_keys (
  id INT AUTO_INCREMENT PRIMARY KEY,
  api_key VARCHAR(255) NOT NULL UNIQUE,
  tenant_id VARCHAR(36) NOT NULL,
  establishment_code VARCHAR(20) NOT NULL,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);
```

**Dados de Exemplo**:
```
| id | api_key         | tenant_id   | establishment_code | active |
|----|-----------------|-------------|-------------------|--------|
| 1  | cliente-a-key   | cliente-a   | EST-A-001         | 1      |
| 2  | cliente-b-key   | cliente-b   | EST-B-001         | 1      |
| 3  | cliente-c-key   | cliente-c   | EST-C-001         | 1      |
```

### tenants (setes_central)

Metadados de cada cliente

```sql
CREATE TABLE tenants (
  id VARCHAR(36) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  schema_name VARCHAR(100) NOT NULL UNIQUE,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

**Dados de Exemplo**:
```
| id        | name           | schema_name       | active |
|-----------|----------------|-------------------|--------|
| cliente-a | Empresa Alpha  | schema_cliente_a  | 1      |
| cliente-b | Empresa Beta   | schema_cliente_b  | 1      |
| cliente-c | Empresa Gamma  | schema_cliente_c  | 1      |
```

### sync_log (setes_central)

Log de sincronizações (auditoría)

```sql
CREATE TABLE sync_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tenant_id VARCHAR(36),
  endpoint VARCHAR(100),
  status VARCHAR(20),        -- 'success', 'error', 'pending'
  records_count INT,
  error_message TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (tenant_id) REFERENCES tenants(id),
  INDEX idx_tenant (tenant_id),
  INDEX idx_created (created_at)
);
```

---

## 🔄 Fluxo de Sincronização Multi-Tenant

### Step 1: Receber Payload

```typescript
POST /customer/sincronize
X-Api-Key: cliente-a-key
Content-Type: application/json

{
  "customers": [
    {"id": 1, "name": "Cliente João"},
    {"id": 2, "name": "Cliente Maria"}
  ]
}
```

### Step 2: Validar API Key

```typescript
const [rows] = await pool.query(
  `SELECT tenant_id, establishment_code, schema_name
   FROM setes_central.sync_api_keys
   WHERE api_key = ? AND active = TRUE`,
  [apiKey]
)

if (!rows.length) {
  return res.status(401).json({ error: 'API Key inválida' })
}

const { tenant_id, establishment_code, schema_name } = rows[0]
```

### Step 3: Conectar no Schema Correto

```typescript
const conn = await pool.getConnection()
await conn.query(`USE \`${schema_name}\``)
// Agora conectado em schema_cliente_a
```

### Step 4: Armazenar Dados

```typescript
await conn.beginTransaction()
try {
  // Inserir em tb_customer do schema_cliente_a
  await conn.query(
    `INSERT INTO tb_customer (id, name, created_at)
     VALUES (?, ?, NOW())`,
    [1, 'Cliente João']
  )
  
  await conn.commit()
  
  // Log de sucesso
  await pool.query(
    `INSERT INTO setes_central.sync_log (tenant_id, endpoint, status, records_count)
     VALUES (?, ?, 'success', ?)`,
    [tenant_id, 'customer', 2]
  )
} catch (err) {
  await conn.rollback()
  // Log de erro
}
```

### Step 5: Retornar Resposta

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

## 🗄️ SQL de Setup Completo

```sql
-- ============================================
-- SETUP MULTI-TENANT PARA SETES-SYNC
-- ============================================

-- 1. Usar banco central
USE setes_central;

-- 2. Criar tabela de tenants
CREATE TABLE IF NOT EXISTS tenants (
  id VARCHAR(36) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  schema_name VARCHAR(100) NOT NULL UNIQUE,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_schema (schema_name),
  INDEX idx_active (active)
);

-- 3. Criar tabela de API keys
CREATE TABLE IF NOT EXISTS sync_api_keys (
  id INT AUTO_INCREMENT PRIMARY KEY,
  api_key VARCHAR(255) NOT NULL UNIQUE,
  tenant_id VARCHAR(36) NOT NULL,
  establishment_code VARCHAR(20) NOT NULL,
  description VARCHAR(255),
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
  INDEX idx_api_key (api_key),
  INDEX idx_tenant (tenant_id)
);

-- 4. Criar tabela de logs
CREATE TABLE IF NOT EXISTS sync_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tenant_id VARCHAR(36) NOT NULL,
  endpoint VARCHAR(100) NOT NULL,
  direction VARCHAR(10),        -- 'push', 'pull'
  table_name VARCHAR(100),
  records_count INT DEFAULT 0,
  status VARCHAR(20) DEFAULT 'pending',  -- 'success', 'error', 'pending'
  error_message TEXT,
  duration_ms INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
  INDEX idx_tenant (tenant_id),
  INDEX idx_endpoint (endpoint),
  INDEX idx_created (created_at)
);

-- 5. Inserir clientes de teste
INSERT INTO tenants (id, name, schema_name, active) VALUES
('cliente-a', 'Empresa Alpha', 'schema_cliente_a', TRUE),
('cliente-b', 'Empresa Beta', 'schema_cliente_b', TRUE),
('cliente-c', 'Empresa Gamma', 'schema_cliente_c', TRUE);

-- 6. Inserir API keys
INSERT INTO sync_api_keys (api_key, tenant_id, establishment_code, description, active) VALUES
('cliente-a-key-12345', 'cliente-a', 'EST-A-001', 'Sincronizador Alpha', TRUE),
('cliente-b-key-12345', 'cliente-b', 'EST-B-001', 'Sincronizador Beta', TRUE),
('cliente-c-key-12345', 'cliente-c', 'EST-C-001', 'Sincronizador Gamma', TRUE);

-- 7. Criar schemas por cliente
CREATE DATABASE IF NOT EXISTS schema_cliente_a;
CREATE DATABASE IF NOT EXISTS schema_cliente_b;
CREATE DATABASE IF NOT EXISTS schema_cliente_c;

-- 8. Criar tabelas básicas em cada schema (Cliente A)
USE schema_cliente_a;

CREATE TABLE IF NOT EXISTS tb_customer (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tb_brand (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Repetir para Cliente B e C...
USE schema_cliente_b;
-- (mesmas tabelas)

USE schema_cliente_c;
-- (mesmas tabelas)

-- 9. Verificar setup
USE setes_central;
SELECT * FROM tenants;
SELECT * FROM sync_api_keys;
```

---

## 🔐 Segurança Multi-Tenant

### Isolamento de Dados

```typescript
// ✅ CORRETO - Dados isolados por schema
const conn = await pool.getConnection()
await conn.query(`USE \`${req.syncClient.schemaName}\``)
// Agora todas as queries vão para schema_cliente_a
```

### Prevenção de SQL Injection

```typescript
// ✅ CORRETO - Usar prepared statements
await conn.query(
  `INSERT INTO tb_customer (id, name) VALUES (?, ?)`,
  [req.body.id, req.body.name]
)

// ❌ ERRADO - Concatenação de strings
await conn.query(
  `INSERT INTO tb_customer (id, name) VALUES (${req.body.id}, '${req.body.name}')`
)
```

### Validação de API Key

```typescript
// ✅ CORRETO - Validar em banco antes de usar
const [rows] = await pool.query(
  `SELECT * FROM sync_api_keys WHERE api_key = ? AND active = TRUE`,
  [apiKey]
)

if (!rows.length) {
  return res.status(401).json({ error: 'API Key inválida' })
}
```

---

## 📈 Escalabilidade Multi-Tenant

### Índices para Performance

```sql
-- No setes_central
CREATE INDEX idx_sync_log_tenant ON sync_log(tenant_id);
CREATE INDEX idx_sync_log_created ON sync_log(created_at);
CREATE INDEX idx_sync_api_keys_tenant ON sync_api_keys(tenant_id);

-- Em cada schema_cliente_x
CREATE INDEX idx_customer_id ON tb_customer(id);
CREATE INDEX idx_brand_id ON tb_brand(id);
```

### Backup por Cliente

```bash
# Backup de Cliente A
mysqldump -u root -p schema_cliente_a > cliente_a_backup.sql

# Backup de todos os dados
mysqldump -u root -p setes_central sync_api_keys sync_log > config_backup.sql
```

---

## 🧪 Teste de Multi-Tenant

### Terminal 1: Iniciar setes-sync

```bash
cd D:\Gestao2027\setes-sync
npm run dev
```

### Terminal 2: Sincronizar Cliente A

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-a-key-12345" \
  -d '{
    "customers": [
      {"id": 1, "name": "Cliente A - João"},
      {"id": 2, "name": "Cliente A - Maria"}
    ]
  }'
```

### Terminal 3: Sincronizar Cliente B

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-b-key-12345" \
  -d '{
    "customers": [
      {"id": 1, "name": "Cliente B - Pedro"},
      {"id": 2, "name": "Cliente B - Ana"}
    ]
  }'
```

### Verificar no MySQL

```sql
-- Dados do Cliente A
USE schema_cliente_a;
SELECT * FROM tb_customer;
-- Output: João, Maria (IDs 1, 2)

-- Dados do Cliente B
USE schema_cliente_b;
SELECT * FROM tb_customer;
-- Output: Pedro, Ana (IDs 1, 2)

-- Logs centralizados
USE setes_central;
SELECT tenant_id, endpoint, records_count, status FROM sync_log;
```

---

## 📋 Checklist de Setup

- [ ] MySQL com setes_central + 3 schemas
- [ ] Tabelas: tenants, sync_api_keys, sync_log criadas
- [ ] 3 clientes inseridos (cliente-a, b, c)
- [ ] 3 API keys criadas
- [ ] Tabelas básicas em cada schema
- [ ] Índices criados
- [ ] setes-sync rodando
- [ ] Teste Cliente A: sucesso
- [ ] Teste Cliente B: sucesso
- [ ] Verificação de isolamento: OK

---

## 🚀 Próximas Etapas

1. ✅ Setup SQL completo
2. ✅ Identificação de Tenant via X-Api-Key
3. ✅ Roteamento automático de schema
4. ⏳ Implementar em sync.auth.middleware.ts
5. ⏳ Testes e2e multi-tenant
6. ⏳ Monitoramento por tenant
7. ⏳ Billing/Quotas por tenant

---

## 📞 Suporte

**Erro**: "API Key inválida"
**Solução**: Verificar sync_api_keys em setes_central

**Erro**: "Access denied for user"
**Solução**: Verificar credenciais MySQL em .env

**Erro**: "Unknown database 'schema_cliente_x'"
**Solução**: Rodar comando: `CREATE DATABASE schema_cliente_x;`

---

*Setup atualizado: 2026-07-01*
