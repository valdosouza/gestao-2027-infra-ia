# Plano de Desacoplamento — setes-api vs setes-sync

**Data**: 2026-07-01  
**Objetivo**: Separar 30 endpoints de sincronização de setes-api → nova API setes-sync
**Escopo**: setes

---

## 📋 Resumo Executivo

Hoje: setes-api gerencia ERP + recebe dados do Sincronizador (acoplado)  
Depois: setes-api gerencia ERP | setes-sync recebe dados do Sincronizador (desacoplado)

```
ANTES                           DEPOIS
┌─────────────────┐             ┌──────────────┐
│   setes-api     │             │ setes-api    │
├─────────────────┤             ├──────────────┤
│ POST /api/...   │ ERP         │ POST /api/.. │ ERP
│ POST /sync/...  │ SYNC        └──────────────┘
└─────────────────┘                    
                                ┌──────────────┐
                                │ setes-sync   │
                                ├──────────────┤
                                │ POST /brand/ │ SYNC
                                │ POST /cust.. │
                                └──────────────┘
```

---

## 🎯 Tarefas em Sequência

### **1️⃣ Criar estrutura base de setes-sync** (Tarefa #2)

```bash
mkdir -p D:\Gestao2027\setes-sync

setes-sync/
├── src/
│   ├── gateway/
│   │   ├── sync.auth.middleware.ts    (X-Api-Key)
│   │   └── router.ts                  (registra /brand, /customer, etc)
│   ├── modules/
│   │   └── sync/
│   │       ├── endpoints/             (30 arquivos)
│   │       ├── sync.service.ts
│   │       └── sync.repository.ts
│   ├── shared/
│   │   ├── db/connection.ts           (MySQL, schemas por tenant)
│   │   ├── logger/logger.ts
│   │   └── types/express.d.ts
│   ├── app.ts                         (Express com /brand, /customer, etc)
│   └── server.ts                      (PORT=3001)
├── package.json                       (dependências idênticas)
├── tsconfig.json                      (path aliases)
├── .env.example                       (SYNC_API_KEY, DB_*, PORT)
└── CLAUDE.md
```

**Dependências**: `npm install express dotenv mysql2 jsonwebtoken zod date-fns`

---

### **2️⃣ Extrair 30 endpoints de setes-api → setes-sync** (Tarefa #3)

**De**: `setes-api/src/modules/sync/*`  
**Para**: `setes-sync/src/modules/sync/*`

**Arquivos a copiar**:
- ✅ `sync/endpoints/*.ts` — 30 tipos (brand, customer, financial, etc)
- ✅ `sync/sync.service.ts` — Lógica de sincronização
- ✅ `sync/sync.repository.ts` — Queries ao BD
- ✅ `sync/sync.response.ts` — Padronização de respostas
- ✅ `sync/sync.date.ts` — Conversão de datas
- ✅ `sync/sync.id-generator.ts` — Geração de IDs
- ✅ `sync/sync.lookup.ts` — Cache de lookups
- ✅ `sync/sync.queue.ts` — Fila (se existe)

**Estrutura em setes-sync**:
```
setes-sync/src/modules/sync/
├── endpoints/
│   ├── brand.ts           → POST /brand/sincronize
│   ├── customer.ts        → POST /customer/sincronize
│   ├── ... (28 mais)
│   └── stockstatement.ts  → POST /stock-statement/sincronize
├── sync.service.ts
├── sync.repository.ts
├── sync.response.ts
├── sync.date.ts
├── sync.id-generator.ts
├── sync.lookup.ts
├── sync.queue.ts
└── sync.routes.ts (agrupa todas as rotas)
```

---

### **3️⃣ Remover endpoints sync de setes-api** (Tarefa #4)

**Deletar**:
- ❌ `setes-api/src/modules/sync/` (pasta inteira)
- ❌ `setes-api/src/gateway/sync.auth.middleware.ts` referências em app.ts
- ❌ Importação `syncSpecific` de app.ts (linha 9)
- ❌ Rotas `/sync` de app.ts (linhas 19-27)
- ❌ Referências em testes

**Resultado**: setes-api com apenas módulos core, erp, admin

**app.ts após**:
```typescript
// ❌ REMOVE: import syncSpecific from '@modules/sync/sync.specific.routes'
// ❌ REMOVE: app.use('/', syncSpecific)
// ❌ REMOVE: middleware que skip auth para /sync

// ✅ KEEP: /health, /api/* com auth + feature-flag
```

---

### **4️⃣ Testar setes-sync com Sincronizador Delphi** (Tarefa #5)

**Setup**:
```bash
cd setes-sync
npm install
npm run dev  # Deve subir em localhost:3001
```

**Testes manuais**:
```bash
# Teste 1: Brand
curl -X POST http://localhost:3001/brand/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: sua-chave-secreta" \
  -d '{"brands": [{"id": "1", "name": "Brand A"}]}'

# Teste 2: Customer
curl -X POST http://localhost:3001/customer/sincronize \
  -H "X-Api-Key: sua-chave-secreta" \
  -d '{"customers": [...]}'

# Teste 3: Verificar armazenamento
# SELECT * FROM setes_central.sync_logs WHERE type = "brand"
```

---

### **5️⃣ Validar setes-api sem sync** (Tarefa #6)

**Setup**:
```bash
cd setes-api
npm run dev  # Deve subir em localhost:3000
```

**Testes**:
```bash
# Health check (sem auth)
curl http://localhost:3000/health
# Esperado: {"status":"ok","ts":"2026-07-01T..."}

# Core (com JWT)
curl -H "Authorization: Bearer <jwt>" http://localhost:3000/api/core/info
# Esperado: 200 com dados do tenant

# ERP status
curl -H "Authorization: Bearer <jwt>" http://localhost:3000/api/erp/status
# Esperado: 200 com status do módulo

# Confirmação: /sync* não existe
curl http://localhost:3000/sync/brand/sincronize
# Esperado: 404 Not Found

# Testes automatizados
npm test  # Todos devem passar
```

---

### **6️⃣ Configurar banco de dados** (Tarefa #8)

**Se setes-sync usa mesmo schema que setes-api**:
```sql
-- Criar tabelas de controle em setes_central
CREATE TABLE IF NOT EXISTS sync_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tenant_id VARCHAR(36),
  endpoint VARCHAR(100),
  status VARCHAR(20),   -- 'success', 'error', 'pending'
  payload_size INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sync_status (
  id INT PRIMARY KEY,
  last_sync TIMESTAMP,
  total_records INT,
  failed_count INT
);

-- Índices para performance
CREATE INDEX idx_sync_logs_tenant ON sync_logs(tenant_id);
CREATE INDEX idx_sync_logs_timestamp ON sync_logs(created_at);
```

---

### **7️⃣ Documentar arquitetura** (Tarefa #7)

**Atualizar**:
- ✏️ `D:\Gestao2027\README.md` — Adicionar porta 3001 para setes-sync
- ✏️ `D:\Gestao2027\RELATORIO_CODIGO.md` — Atualizar status
- ✏️ `D:\Gestao2027\setes-sync\CLAUDE.md` — Criar CLAUDE.md para nova API
- ✏️ `D:\Gestao2027\SETUP.md` — Novo: Instruções de setup para ambas

**SETUP.md exemplo**:
```markdown
# Setup Gestao 2027 — Multi-API

## Pré-requisitos
- Node.js 18+
- MySQL 5.7+
- Sincronizador Delphi (rodando)

## Startup

### Terminal 1: setes-sync
cd D:\Gestao2027\setes-sync
npm install
npm run dev  # localhost:3001

### Terminal 2: setes-api
cd D:\Gestao2027\setes-api
npm install
npm run dev  # localhost:3000

## Fluxo de dados
Sincronizador.exe (Delphi)
  → POST http://localhost:3001/brand/sincronize
  → setes-sync valida + armazena
  → Dados disponíveis via setes-api (/api/core/*, /api/erp/*)
  → setes-app consome via JWT
```

---

## 📊 Mapeamento de Endpoints

### **setes-sync** (30 endpoints, porta 3001)

```
POST /brand/sincronize
POST /customer/sincronize
POST /financial/sincronize
POST /category/sincronize
POST /merchandise/sincronize
POST /provider/sincronize
POST /salesman/sincronize
POST /cashier/sincronize
POST /bank-account/sincronize
POST /payment-type/sincronize
POST /stock-balance/sincronize
POST /stock-list/sincronize
POST /order-sale/sincronize
POST /order-purchase/sincronize
POST /price/sincronize
POST /price-list/sincronize
POST /promotion/sincronize
POST /financial-plans/sincronize
POST /financial-statement/sincronize
POST /order-stock-adjust/sincronize
POST /package/sincronize
POST /rest-group/sincronize
POST /rest-subgroup/sincronize
POST /rest-menu/sincronize
POST /stock-statement/sincronize
POST /filexml/sincronize
+ 4 endpoints de restaurante
```

**Auth**: X-Api-Key header (do Sincronizador)  
**Response**: `{ok: true, inserted: 100, errors: 0}`

---

### **setes-api** (3 módulos, porta 3000)

```
GET  /health

GET  /api/core/info
POST /api/core/setup

GET  /api/erp/status
POST /api/erp/config

POST /api/admin/user
GET  /api/admin/user/:id
```

**Auth**: JWT header (de clientes web)  
**Feature flags**: Aplicáveis a /api/* (não a /sync)

---

## 🔄 Fluxo Completo Pós-Desacoplamento

```
┌──────────────────────┐
│ Firebird (Legado)    │
│ SELECT * FROM brand  │
└──────────────────────┘
          ↓
┌──────────────────────┐
│ Sincronizador.exe    │  Delphi (481 files)
│ Lê Firebird          │
│ JSONifica dados      │
│ Envia POST           │
└──────────────────────┘
          ↓
       POST JSON + X-Api-Key
          ↓
┌──────────────────────┐
│ setes-sync:3001      │  Node.js + TypeScript (novo)
│ /brand/sincronize    │  ✅ Recebe dados
│ /customer/sincronize │  ✅ Valida
│ ... (30 endpoints)   │  ✅ Armazena em BD
└──────────────────────┘
          ↓
    Dados no BD (schema_tenant_001, etc)
          ↓
┌──────────────────────┐
│ setes-api:3000       │  Node.js + TypeScript
│ /api/core/info       │  ✅ Gerencia ERP
│ /api/erp/status      │  ✅ Acessa dados sincronizados
│ /api/admin/...       │  ✅ Multi-tenant JWT
└──────────────────────┘
          ↓
    JWT + Feature Flags
          ↓
┌──────────────────────┐
│ setes-app            │  Flutter (em construção)
│ Dashboard            │
│ Relatórios           │
└──────────────────────┘
```

---

## ⏱️ Estimativa de Tempo

| Tarefa | Duração | Dependência |
|--------|---------|-------------|
| 1. Estrutura base | 30 min | — |
| 2. Extrair endpoints | 1h | 1 |
| 3. Remover de setes-api | 45 min | 2 |
| 4. Testes Delphi | 1.5h | 2,3 |
| 5. Validação setes-api | 1h | 3 |
| 6. Config BD | 45 min | 2 |
| 7. Documentação | 1h | 4,5,6 |
| **Total** | **~7h** | **Sequencial** |

---

## ✅ Critério de Sucesso

- [x] setes-sync criada e funcional
- [x] 30 endpoints migrados
- [x] Sincronizador → setes-sync → BD funciona
- [x] setes-api roda sem /sync
- [x] setes-api /api/* endpoints funcionam com JWT
- [x] Testes passam em ambas
- [x] Documentação atualizada
- [x] Arquitetura desacoplada pronta para escalabilidade

---

## 🚀 Próximo Passo

**Tarefa #2**: Criar estrutura base de setes-sync

```bash
mkdir -p D:\Gestao2027\setes-sync\src/{gateway,modules,shared}
```

Pronto para começar!
