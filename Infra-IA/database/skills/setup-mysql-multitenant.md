# Skill: Setup MySQL Multi-Tenant

**Objetivo**: Configurar banco MySQL do zero com multi-tenant  
**Tempo**: ~10 minutos  
**Prerequisito**: MySQL Server instalado e rodando

---

## 🚀 Passo 1: Verificar MySQL

```bash
mysql --version
```

**Esperado**: `mysql Ver 8.0+`

---

## 🔌 Passo 2: Conectar no MySQL

```bash
mysql -u root -p
```

(Digite a senha)

---

## 📦 Passo 3: Executar SQL de Setup

**Opção A: Executar arquivo SQL**

```bash
mysql -u root -p < D:\Gestao2027\setes-sync\setup-multi-tenant.sql
```

**Opção B: Copiar e colar no MySQL CLI**

```sql
-- ============================================
-- SETUP MULTI-TENANT PARA SETES-SYNC
-- ============================================

USE setes_central;

-- 1. Tabela de tenants
CREATE TABLE IF NOT EXISTS tenants (
  id VARCHAR(36) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  schema_name VARCHAR(100) NOT NULL UNIQUE,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_schema (schema_name),
  INDEX idx_active (active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabela de API keys
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabela de logs de sincronização
CREATE TABLE IF NOT EXISTS sync_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tenant_id VARCHAR(36) NOT NULL,
  endpoint VARCHAR(100) NOT NULL,
  direction VARCHAR(10),
  table_name VARCHAR(100),
  records_count INT DEFAULT 0,
  status VARCHAR(20) DEFAULT 'pending',
  error_message TEXT,
  duration_ms INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
  INDEX idx_tenant (tenant_id),
  INDEX idx_endpoint (endpoint),
  INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Inserir clientes
INSERT INTO tenants (id, name, schema_name, active) VALUES
('cliente-a', 'Empresa Alpha', 'schema_cliente_a', TRUE),
('cliente-b', 'Empresa Beta', 'schema_cliente_b', TRUE),
('cliente-c', 'Empresa Gamma', 'schema_cliente_c', TRUE)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- 5. Inserir API keys
INSERT INTO sync_api_keys (api_key, tenant_id, establishment_code, description, active) VALUES
('cliente-a-key-12345', 'cliente-a', 'EST-A-001', 'Sincronizador Alpha', TRUE),
('cliente-b-key-12345', 'cliente-b', 'EST-B-001', 'Sincronizador Beta', TRUE),
('cliente-c-key-12345', 'cliente-c', 'EST-C-001', 'Sincronizador Gamma', TRUE)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- 6. Criar schemas por cliente
CREATE DATABASE IF NOT EXISTS schema_cliente_a CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS schema_cliente_b CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS schema_cliente_c CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 7. Criar tabelas básicas - Cliente A
USE schema_cliente_a;

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

-- 8. Criar tabelas básicas - Cliente B
USE schema_cliente_b;

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

-- 9. Criar tabelas básicas - Cliente C
USE schema_cliente_c;

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

-- 10. Dados de teste
USE schema_cliente_a;
INSERT INTO tb_customer (id, name, email) VALUES
(1, 'Cliente A - João Silva', 'joao@clientea.com'),
(2, 'Cliente A - Maria Santos', 'maria@clientea.com');

INSERT INTO tb_brand (id, name) VALUES
(1, 'Marca Alpha'),
(2, 'Marca Beta');

USE schema_cliente_b;
INSERT INTO tb_customer (id, name, email) VALUES
(1, 'Cliente B - Pedro Costa', 'pedro@clienteb.com'),
(2, 'Cliente B - Ana Silva', 'ana@clienteb.com');

INSERT INTO tb_brand (id, name) VALUES
(1, 'Marca Gamma'),
(2, 'Marca Delta');

USE schema_cliente_c;
INSERT INTO tb_customer (id, name, email) VALUES
(1, 'Cliente C - Roberto Lima', 'roberto@clientec.com'),
(2, 'Cliente C - Fernanda Gomes', 'fernanda@clientec.com');

INSERT INTO tb_brand (id, name) VALUES
(1, 'Marca Epsilon'),
(2, 'Marca Zeta');
```

---

## ✅ Passo 4: Validar Setup

### 4a. Verificar Banco Central

```sql
USE setes_central;
SHOW TABLES;
```

**Esperado**: `tenants`, `sync_api_keys`, `sync_log`

### 4b. Verificar Schemas

```sql
SHOW DATABASES LIKE 'schema_%';
```

**Esperado**: `schema_cliente_a`, `schema_cliente_b`, `schema_cliente_c`

### 4c. Verificar Tenants

```sql
USE setes_central;
SELECT * FROM tenants;
```

**Esperado**: 3 registros (cliente-a, b, c)

### 4d. Verificar API Keys

```sql
SELECT api_key, tenant_id, active FROM sync_api_keys;
```

**Esperado**: 3 API keys ativas

---

## 🧪 Passo 5: Testar Isolamento

```bash
# Cliente A
mysql -u root -p -e "USE schema_cliente_a; SELECT COUNT(*) FROM tb_customer;"
# Output: 2

# Cliente B
mysql -u root -p -e "USE schema_cliente_b; SELECT COUNT(*) FROM tb_customer;"
# Output: 2

# Cliente C
mysql -u root -p -e "USE schema_cliente_c; SELECT COUNT(*) FROM tb_customer;"
# Output: 2

# Todos isolados ✅
```

---

## 📊 Passo 6: Backup de Teste

```bash
# Backup completo
mysqldump -u root -p setes_central > setes_central_backup.sql

# Backup por schema
mysqldump -u root -p schema_cliente_a > cliente_a_backup.sql
```

---

## 🔧 Troubleshooting

### Erro: "Unknown database 'setes_central'"

```sql
CREATE DATABASE setes_central CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Erro: "Access denied"

Verificar credenciais MySQL em `.env`

### Erro: "Foreign key constraint fails"

Tentar executar SQL com `--default-character-set=utf8mb4`

---

## 🎉 Setup Completo!

Quando todos os passos passarem:

- ✅ Banco `setes_central` com tabelas de config
- ✅ 3 schemas de clientes criados
- ✅ Tabelas básicas em cada schema
- ✅ Dados de teste inseridos
- ✅ API keys cadastradas
- ✅ Pronto para setes-sync

---

*Skill atualizada: 2026-07-01*

