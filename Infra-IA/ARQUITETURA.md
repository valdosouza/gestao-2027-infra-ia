# Arquitetura Final — Gestao 2027

**Versão**: 1.0  
**Data**: 2026-07-01  
**Status**: Desacoplamento Completo ✅

---

## 🏗️ Visão Geral da Arquitetura

```
┌─────────────────────────────────────────────────────────────────┐
│                     GESTAO 2027 — ARQUITETURA FINAL              │
└─────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────┐
│                        CAMADA LEGADA                              │
├───────────────────────────────────────────────────────────────────┤
│                                                                   │
│  Firebird Database (Legado)        Sincronizador.exe (Delphi)    │
│         │                                    │                    │
│         │  Lê dados                          │                    │
│         └────────→ 481 arquivos Delphi ←────┘                   │
│                          │                                        │
│                          │ Encapsula JSON                         │
└──────────────────────────┼───────────────────────────────────────┘
                           │
                           │ POST /*/sincronize
                           │ X-Api-Key: chave_compartilhada
                           │
        ┌──────────────────▼───────────────────┐
        │      CAMADA DE SINCRONIZAÇÃO         │
        ├──────────────────────────────────────┤
        │                                      │
        │    setes-sync:3001 (Node.js)        │
        │    ├─ 23 endpoints de sync          │
        │    ├─ Auth: X-Api-Key               │
        │    ├─ Rate: 500 req/min             │
        │    └─ Swagger UI: /docs             │
        │           │                         │
        │           │ Armazena dados          │
        │           │ nos schemas por tenant  │
        │           ▼                         │
        └──────────────────────────────────────┘
                   │
        ┌──────────▼───────────────┐
        │    MySQL (Central)       │
        ├──────────────────────────┤
        │                          │
        │ setes_central/           │
        │ ├─ tenants               │
        │ ├─ feature_flags         │
        │ ├─ sync_api_keys         │
        │ ├─ sync_log              │
        │ └─ ...                   │
        │                          │
        │ schema_tenant_001/       │
        │ ├─ tb_brand              │
        │ ├─ tb_customer           │
        │ ├─ tb_financial          │
        │ └─ ... (23 tabelas)      │
        │                          │
        │ schema_tenant_002/       │
        │ └─ (idem, isolado)       │
        │                          │
        └──────────────────────────┘
                   △
                   │ Lê dados
                   │ sincronizados
        ┌──────────┴───────────────┐
        │   CAMADA DE NEGÓCIO      │
        ├──────────────────────────┤
        │                          │
        │  setes-api:3000          │
        │  (Node.js + TypeScript)  │
        │  ├─ 5 endpoints ERP      │
        │  ├─ Auth: JWT            │
        │  ├─ Feature Flags        │
        │  ├─ Multi-tenant         │
        │  ├─ Rate: 300 req/min    │
        │  └─ Swagger UI: /docs    │
        │           △              │
        │           │ Consome      │
        │           │ dados        │
        │           │ sincronizados│
        └───────────┬──────────────┘
                    │
        ┌───────────▼──────────────┐
        │   CAMADA DE INTERFACE    │
        ├──────────────────────────┤
        │                          │
        │  setes-app (Flutter)     │
        │  ├─ Web App              │
        │  ├─ Auth: JWT            │
        │  └─ Consome /api/*       │
        │           △              │
        │           │ Usuário      │
        │           │ acessa       │
        │           │              │
        └───────────┴──────────────┘
                    │
                    ▼
            ┌──────────────┐
            │  Browser     │
            │  Usuário Final│
            └──────────────┘
```

---

## 📊 Componentes Principais

### 1️⃣ Sincronizador (Delphi) — Legado
**Responsabilidade**: Ler dados de Firebird e sincronizar

- 481 arquivos Delphi
- Lê banco Firebird (legado)
- Encapsula dados em JSON
- Envia via HTTP POST + X-Api-Key
- Agendamento automático

**Comunicação**: 
```
POST http://localhost:3001/<recurso>/sincronize
X-Api-Key: chave_compartilhada
```

---

### 2️⃣ setes-sync (Node.js + TypeScript) — Sincronização
**Responsabilidade**: Receber e armazenar dados sincronizados

**Porta**: 3001

**Endpoints**: 23 tipos de sincronização
```
/brand/sincronize
/customer/sincronize
/financial/sincronize
/category/sincronize
/merchandise/sincronize
/provider/sincronize
/salesman/sincronize
/cashier/sincronize
/bank-account/sincronize
/payment-type/sincronize
/stock-balance/sincronize
/stock-list/sincronize
/order-sale/sincronize
/order-purchase/sincronize
/price/sincronize
/price-list/sincronize
/promotion/sincronize
/financial-plans/sincronize
/financial-statement/sincronize
/order-stock-adjust/sincronize
/package/sincronize
/stock-statement/sincronize
/file-xml/sincronize
```

**Autenticação**: X-Api-Key (compartilhada com Sincronizador)

**Recursos**:
- ✅ 23 endpoints de sincronização
- ✅ Autenticação X-Api-Key
- ✅ Rate limiting (500 req/min)
- ✅ Swagger UI em /docs
- ✅ Integração com MySQL (multi-schema)

**Arquivos**: 49 TypeScript + configuração

---

### 3️⃣ setes-api (Node.js + TypeScript) — Negócio
**Responsabilidade**: Gerenciar APIs ERP para clientes web

**Porta**: 3000

**Endpoints**: 5 APIs
```
GET /health                    (sem auth)
GET /api/core/info            (JWT)
GET /api/erp/status           (JWT + feature flag)
GET /api/admin/tenants        (JWT + setes_admin)
POST /api/admin/tenants       (JWT + setes_admin)
```

**Autenticação**: JWT (Bearer token)

**Recursos**:
- ✅ Multi-tenant via JWT
- ✅ Feature flags por módulo
- ✅ Rate limiting (300 req/min por tenant)
- ✅ Swagger UI em /docs
- ✅ 3 módulos: Core, ERP, Admin

**Arquivos**: 70 TypeScript + configuração

---

### 4️⃣ setes-app (Flutter) — Interface
**Responsabilidade**: Interface web para usuários finais

**Status**: Estrutura pronta, features em desenvolvimento

**Comunicação**:
```
GET/POST /api/* (com JWT de setes-api)
```

---

### 5️⃣ MySQL (Central)
**Responsabilidade**: Armazenar dados

**Bases**:
- `setes_central` — Metadados, tenants, feature flags, logs
- `schema_tenant_XXX` — Dados de cada cliente (isolado)

---

## 🔄 Fluxo de Dados Completo

### Scenario: Sincronizar dados de Clientes

```
1. Sincronizador.exe (Delphi)
   └─ Lê clientes de Firebird

2. Encapsula em JSON
   {
     "customers": [
       {"id": 1, "name": "Cliente A", ...},
       {"id": 2, "name": "Cliente B", ...}
     ]
   }

3. Envia POST para setes-sync
   POST http://localhost:3001/customer/sincronize
   X-Api-Key: chave_compartilhada
   Content-Type: application/json

4. setes-sync recebe
   ├─ Valida X-Api-Key
   ├─ Valida payload JSON
   ├─ Extrai tenant_id (do payload ou header)
   ├─ Processa dados
   └─ Armazena em schema_tenant_001

5. Dados agora estão em MySQL
   USE schema_tenant_001;
   SELECT * FROM tb_customer;

6. setes-api acessa dados
   GET /api/core/info (com JWT)
   └─ Conecta em schema_alpha (do JWT)
   └─ Lê dados sincronizados
   └─ Retorna para cliente

7. setes-app consome
   GET /api/core/info (com JWT)
   └─ Renderiza dados
   └─ Usuário vê clientes sincronizados
```

---

## 🔐 Autenticação por Camada

### Sincronizador → setes-sync
```
Tipo: X-Api-Key
Header: X-Api-Key: sua_chave_compartilhada
Compartilhada entre Sincronizador Delphi e setes-sync
Armazenada em: setes_central.sync_api_keys
```

### setes-app → setes-api
```
Tipo: JWT (Bearer Token)
Header: Authorization: Bearer <jwt>
Payload: {
  tenantId: "tenant-001",
  userId: "user-001",
  role: "client_user",
  schemaName: "schema_alpha"
}
Assinado com: JWT_SECRET
```

### setes-api → MySQL
```
Tipo: Conexão TCP/IP
Usa pool de conexões mysql2
Schema selection: USE `schema_name`
Multi-tenant: cada conexão isolada por tenant
```

---

## 🎯 Responsabilidades por Módulo

| Componente | Responsabilidade | Tech | Porta |
|-----------|------------------|------|-------|
| Sincronizador | Lê Firebird, envia dados | Delphi | N/A |
| setes-sync | Recebe sync, armazena | Node.js | 3001 |
| setes-api | Gerencia negócio | Node.js | 3000 |
| setes-app | Interface usuário | Flutter | N/A |
| MySQL | Persistência | MySQL | 3306 |

---

## 📈 Escalabilidade

### setes-sync
- **Rate**: 500 req/min (ajustável)
- **Escalabilidade**: Horizontal (múltiplas instâncias)
- **Database**: Compartilhado com setes-api
- **Stateless**: Sem cache local (shared MySQL)

### setes-api
- **Rate**: 300 req/min por tenant (ajustável)
- **Escalabilidade**: Horizontal (múltiplas instâncias)
- **Database**: Compartilhado com setes-sync
- **Caching**: Feature flags com TTL (in-memory)

### Multi-tenancy
- **Isolamento**: Schema per tenant
- **Performance**: Índices por schema
- **Segurança**: Dados não vazam entre clientes

---

## 🔧 Configuração Necessária

### Sincronizador (Delphi)
```
Endpoint: http://localhost:3001
X-Api-Key: sua_chave_compartilhada
Method: POST
Content-Type: application/json
```

### setes-sync (.env)
```
PORT=3001
SYNC_API_KEY=sua_chave_compartilhada
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=senha
DB_NAME=setes_central
```

### setes-api (.env)
```
PORT=3000
JWT_SECRET=sua_chave_secreta
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=senha
DB_NAME=setes_central
FLAG_CACHE_TTL_MS=60000
```

### MySQL
```
- Database: setes_central (metadados)
- Schemas: schema_tenant_001, schema_tenant_002, ... (dados)
- Tabelas: sync_api_keys, feature_flags, sync_log, tenants
```

---

## 📚 Documentação por Componente

| Componente | Documentação | Local |
|-----------|--------------|-------|
| setes-sync | Swagger | http://localhost:3001/docs |
| setes-sync | Setup | Infra-IA/setes-sync/02-SETUP.md |
| setes-sync | Testes | Infra-IA/setes-sync/03-INSTRUCOES_TESTE.md |
| setes-api | Swagger | http://localhost:3000/docs |
| setes-api | Desacoplamento | Infra-IA/setes-api/01-DESACOPLAMENTO.md |
| setes-api | Validação | Infra-IA/setes-api/02-VALIDACAO.md |
| setes-api | Swagger Doc | Infra-IA/setes-api/03-SWAGGER.md |

---

## 🚀 Deployment

### Desenvolvimento
```bash
Terminal 1: cd setes-sync && npm run dev   # :3001
Terminal 2: cd setes-api && npm run dev    # :3000
```

### Produção
```bash
# setes-sync
npm run build
npm start  # PORT=3001

# setes-api
npm run build
npm start  # PORT=3000
```

### Docker (futuro)
```
docker run -p 3001:3001 setes-sync:latest
docker run -p 3000:3000 setes-api:latest
```

---

## ✅ Benefícios do Desacoplamento

1. **Responsabilidade Única**
   - setes-sync: Sincronização
   - setes-api: Negócio/ERP

2. **Escalabilidade**
   - Cada API escala independentemente
   - Diferentes limites de taxa

3. **Manutenibilidade**
   - Código mais limpo
   - Testes mais isolados
   - Deploys independentes

4. **Resiliência**
   - Falha de sync não derruba ERP
   - APIs podem rodar em máquinas diferentes

5. **Documentação**
   - Swagger em ambas APIs
   - Responsabilidades claras
   - Fluxo bem definido

---

## 📊 Estatísticas

| Métrica | Valor |
|---------|-------|
| Arquivos Sincronizador | 481 (Delphi) |
| Arquivos setes-sync | 49 (TypeScript) |
| Arquivos setes-api | 70 (TypeScript) |
| Endpoints Sincronização | 23 |
| Endpoints ERP | 5 |
| Rate Limit setes-sync | 500 req/min |
| Rate Limit setes-api | 300 req/min/tenant |
| Multi-tenancy | ✅ Sim |
| Swagger Documentation | ✅ Ambas APIs |
| Feature Flags | ✅ Sim |

---

## 🔗 Relações Entre Componentes

```
Sincronizador.exe
     │ (POST /sync)
     ▼
setes-sync:3001
     │ (Armazena em MySQL)
     ▼
MySQL (setes_central + schemas)
     △
     │ (Lê dados)
     │
setes-api:3000
     △
     │ (Consome /api/*)
     │
setes-app (Flutter)
     △
     │ (Usuário acessa)
     │
Browser/Usuário
```

---

## 🎯 Próximos Passos

1. ✅ Desacoplamento completo
2. ✅ Documentação centralizada
3. ✅ Swagger em ambas APIs
4. ⏳ Testes e2e
5. ⏳ CI/CD pipeline
6. ⏳ Monitoramento/Observabilidade
7. ⏳ Load testing
8. ⏳ Deploy para produção

---

*Arquitetura finalizada: 2026-07-01*
