# Arquitetura — Gestao 2027

**Escopo**: setes

## 📋 Índice de Arquitetura

### 1. **Visão Geral**
Diagrama completo da arquitetura após desacoplamento

### 2. **Componentes Principais**
- Sincronizador (Delphi)
- setes-sync (sincronização)
- setes-api (negócio)
- setes-app (interface)
- MySQL (persistência)

### 3. **Fluxo de Dados**
Caminho completo: Firebird → Delphi → setes-sync → MySQL → setes-api → setes-app

### 4. **Autenticação**
- X-Api-Key: Sincronizador → setes-sync
- JWT: setes-app → setes-api

### 5. **Escalabilidade**
- Rate limiting por componente
- Multi-tenancy via schemas
- Stateless design

### 6. **Responsabilidades**
Quem faz o quê em cada camada

### 7. **Documentação por Componente**
Links para docs de setup, swagger, testes

### 8. **Deployment**
Como rodar em desenvolvimento e produção

---

## 🏗️ Diagrama Simplificado

```
┌─────────────────────────────────────────────────────┐
│              GESTAO 2027 - FLUXO COMPLETO            │
└─────────────────────────────────────────────────────┘

Firebird (Legado)
   ↓
Sincronizador.exe (Delphi, 481 files)
   ↓ POST /*/sincronize + X-Api-Key
setes-sync:3001 (23 endpoints sync)
   ↓ Armazena em MySQL
MySQL (setes_central + schema_tenant_*)
   ↓ Lê dados sincronizados
setes-api:3000 (5 endpoints ERP)
   ↓ GET /api/* com JWT
setes-app (Flutter)
   ↓
Usuário Final (Browser)
```

---

## 🎯 Camadas

### Legado
- Firebird (banco antigo)
- Sincronizador.exe (Delphi)

### Integração
- setes-sync:3001 (recebe dados)

### Negócio
- setes-api:3000 (gerencia ERP)

### Interface
- setes-app (Flutter web app)

### Persistência
- MySQL (central)

---

## 🔐 Autenticação

**Sincronizador → setes-sync**: X-Api-Key (header)
**setes-app → setes-api**: JWT (Bearer token)
**setes-api → MySQL**: TCP/IP (conexão pool)

---

## 📊 Endpoints

**setes-sync** (23):
- brand, customer, financial, category, merchandise, provider, salesman, cashier, bank-account, payment-type, stock-balance, stock-list, order-sale, order-purchase, price, price-list, promotion, financial-plans, financial-statement, order-stock-adjust, package, stock-statement, file-xml

**setes-api** (5):
- GET /health
- GET /api/core/info
- GET /api/erp/status
- GET /api/admin/tenants
- POST /api/admin/tenants

---

## 📚 Documentação

**Detalhada**: `D:\Gestao2027\ARQUITETURA_FINAL.md`
**setes-sync**: `Infra-IA\setes-sync\`
**setes-api**: `Infra-IA\setes-api\`

---

## ✅ Checklist de Setup

- [ ] MySQL rodando (setes_central + schemas)
- [ ] Sincronizador Delphi pronto
- [ ] setes-sync: `npm install` + `.env` + `npm run dev`
- [ ] setes-api: `npm install` + `.env` + `npm run dev`
- [ ] setes-app: estrutura pronta (features em progresso)
- [ ] Swagger acessíveis: /docs em ambas APIs

