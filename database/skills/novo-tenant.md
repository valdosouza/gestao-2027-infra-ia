# Skill: Adicionar Novo Cliente/Tenant

**Objetivo**: Onboard novo cliente no sistema multi-tenant  
**Tempo**: ~5 minutos  
**Exemplo**: Adicionando "Empresa Delta"
**Escopo**: setes

---

## 🚀 Passo 1: Gerar ID e Schema

```bash
# ID do tenant (UUID ou slug)
TENANT_ID="cliente-d"
TENANT_NAME="Empresa Delta"
SCHEMA_NAME="schema_cliente_d"
API_KEY="cliente-d-key-$(date +%s)"
ESTABLISHMENT="EST-D-001"
```

---

## 📝 Passo 2: Adicionar ao Banco

```sql
USE setes_central;

-- 1. Inserir tenant
INSERT INTO tenants (id, name, schema_name, active) VALUES
('$TENANT_ID', '$TENANT_NAME', '$SCHEMA_NAME', TRUE);

-- 2. Inserir API Key
INSERT INTO sync_api_keys (api_key, tenant_id, establishment_code, description, active) VALUES
('$API_KEY', '$TENANT_ID', '$ESTABLISHMENT', 'Sincronizador $TENANT_NAME', TRUE);

-- 3. Criar schema
CREATE DATABASE IF NOT EXISTS $SCHEMA_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 4. Criar tabelas básicas
USE $SCHEMA_NAME;

CREATE TABLE IF NOT EXISTS tb_customer (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tb_brand (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## ✅ Passo 3: Validar

```sql
USE setes_central;

-- Verificar tenant
SELECT * FROM tenants WHERE id = 'cliente-d';

-- Verificar API Key
SELECT api_key, tenant_id, active FROM sync_api_keys WHERE tenant_id = 'cliente-d';

-- Verificar schema
SHOW DATABASES LIKE 'schema_cliente_d';
```

---

## 🧪 Passo 4: Testar Sincronização

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-d-key-xxxxx" \
  -d '{
    "customers": [
      {"id": 1, "name": "Cliente Delta - Test"}
    ]
  }'
```

---

## 📊 Passo 5: Gerar JWT para Cliente

```bash
npx ts-node -e "
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET || 'sua_chave_secreta';

const token = jwt.sign({
  tenantId: 'cliente-d',
  userId: 'user-d-001',
  role: 'client_user',
  schemaName: 'schema_cliente_d'
}, secret, { expiresIn: '24h' });

console.log('Token para Cliente D:');
console.log(token);
"
```

---

## ✨ Pronto!

Novo tenant adicionado e operacional! 🎉

---

*Skill atualizada: 2026-07-01*

