# Gestao 2027 — Infra-IA (Documentação)

**Escopo**: misto

## 📚 Índice Central de Documentação

Documentação de todos os componentes do projeto Gestao 2027.

---

## 🗂️ Estrutura por Módulo

### **📦 setes-api** (Node.js + TypeScript)
**API principal para gestão ERP**

```
Infra-IA/setes-api/
├── INDEX.md                 ← Comece aqui
├── 01-DESACOPLAMENTO.md     (Status do desacoplamento)
├── CLAUDE.md                (Guia técnico — em setes-api/)
├── DOCUMENTACAO.md
├── Lista de Tabelas.txt
├── Plano de Estruturacao.md
├── diagrama da arquitetura geral.png
└── prompt_*.md              (Histórico de sprints)
```

**Responsabilidades**:
- ✅ Autenticação JWT (multi-tenant)
- ✅ Feature flags por módulo
- ✅ Endpoints ERP (core, erp, admin)
- ✅ Rate limiting por tenant
- ✅ Integração com setes-app

**Porta**: `3000`

---

### **🔄 setes-sync** (Node.js + TypeScript)
**API de sincronização de dados**

```
Infra-IA/setes-sync/
├── INDEX.md                 ← Comece aqui
├── 01-SWAGGER.md            (Documentação Swagger/OpenAPI)
├── 02-SETUP.md              (Instalação e configuração)
├── 03-INSTRUCOES_TESTE.md   (Testes e validação)
├── SWAGGER.md               (Guia detalhado — em setes-sync/)
└── SETUP.md                 (Setup completo — em setes-sync/)
```

**Responsabilidades**:
- ✅ Receber dados do Sincronizador Delphi
- ✅ Autenticação X-Api-Key
- ✅ 23 endpoints de sincronização
- ✅ Documentação Swagger/OpenAPI 3.0
- ✅ Teste interativo de endpoints

**Porta**: `3001`

**23 Endpoints**: brand, customer, financial, category, merchandise, provider, salesman, cashier, bank-account, payment-type, stock-balance, stock-list, order-sale, order-purchase, price, price-list, promotion, financial-plans, financial-statement, order-stock-adjust, package, stock-statement, file-xml

---

### **📱 setes-app** (Flutter)
**Interface web moderna**

```
Infra-IA/setes-app/
├── (em desenvolvimento)
```

**Status**: Estrutura pronta, features em progresso

**Responsabilidades**:
- 🔄 Interface web (Flutter)
- 🔄 Consome endpoints de setes-api
- 🔄 Autenticação JWT

---

### **🔧 Sincronizador** (Delphi)
**Sistema legado de sincronização**

```
Infra-IA/Sincronizador/
├── Documentacao.md
├── Agent_Analise_Inicial_Migration.md
```

**Responsabilidades**:
- ✅ Lê dados de Firebird
- ✅ Encapsula em JSON
- ✅ Envia para setes-sync via X-Api-Key
- ✅ 481 arquivos Delphi em produção

**Comunicação**: POST para `http://localhost:3001/<recurso>/sincronize`

---

## 🚀 Quick Start

### Iniciar Todas as APIs

**Terminal 1 — setes-sync**:
```bash
cd D:\Gestao2027\setes-sync
npm install
npm run dev  # porta 3001
```

**Terminal 2 — setes-api**:
```bash
cd D:\Gestao2027\setes-api
npm install
npm run dev  # porta 3000
```

### Acessar Documentação

- **Swagger setes-sync**: `http://localhost:3001/docs`
- **Health setes-api**: `http://localhost:3000/health`
- **Health setes-sync**: `http://localhost:3001/health`

---

## 📊 Fluxo de Dados

```
Firebird (Legado)
    ↓ [Sincronizador Delphi lê]
Sincronizador (Delphi, 481 files)
    ↓ POST JSON + X-Api-Key
setes-sync:3001
    ↓ [Armazena em BD]
MySQL (setes_central + schema_tenant_*)
    ↓ [setes-api lê]
setes-api:3000
    ↓ [Serve via JWT]
setes-app (Flutter)
    ↑ [Usuário acessa]
```

---

## 🔐 Autenticação

### setes-sync (Sincronizador Delphi)
```
POST /<recurso>/sincronize
X-Api-Key: sua_chave_compartilhada_do_sincronizador
```

### setes-api (Cliente Web)
```
GET /api/<modulo>/<endpoint>
Authorization: Bearer <jwt_token>
```

---

## 📋 23 Endpoints Sync

**Masteres** (6)
- brand, customer, category, merchandise, provider, salesman

**Financeiro** (3)
- financial, financial-plans, financial-statement

**Estoque** (4)
- stock-balance, stock-list, stock-statement, order-stock-adjust

**Vendas & Compras** (2)
- order-sale, order-purchase

**Preços** (3)
- price, price-list, promotion

**Operações** (5)
- cashier, bank-account, payment-type, package, file-xml

---

## 📁 Estrutura Geral

```
D:\Gestao2027\
├── setes-api/              (70 arquivos TypeScript — ERP)
├── setes-sync/             (49 arquivos TypeScript — Sincronização)
├── setes-app/              (vazio — Flutter em desenvolvimento)
├── Sincronizador/          (481 arquivos Delphi — Legado)
├── Infra-IA/               (Documentação)
│   ├── README.md           (Você está aqui)
│   ├── setes-api/
│   │   ├── INDEX.md
│   │   ├── 01-DESACOPLAMENTO.md
│   │   └── ... (mais docs)
│   ├── setes-sync/
│   │   ├── INDEX.md
│   │   ├── 01-SWAGGER.md
│   │   ├── 02-SETUP.md
│   │   ├── 03-INSTRUCOES_TESTE.md
│   │   └── ... (mais docs)
│   ├── Sincronizador/
│   └── setes-app/
├── README.md               (Visão geral do projeto)
├── RELATORIO_CODIGO.md     (Levantamento de código)
├── PLANO_DESACOPLAMENTO.md (Plano de refator)
└── ... (mais documentos)
```

---

## 🔗 Como Navegar

### Estou começando
1. Leia `D:\Gestao2027\README.md`
2. Leia `D:\Gestao2027\RELATORIO_CODIGO.md`
3. Leia `D:\Gestao2027\PLANO_DESACOPLAMENTO.md`

### Vou trabalhar em setes-api
1. Leia `Infra-IA\setes-api\INDEX.md`
2. Leia `Infra-IA\setes-api\01-DESACOPLAMENTO.md`
3. Consulte `setes-api\CLAUDE.md`

### Vou trabalhar em setes-sync
1. Leia `Infra-IA\setes-sync\INDEX.md`
2. Leia `Infra-IA\setes-sync\02-SETUP.md`
3. Acesse Swagger: `http://localhost:3001/docs`

### Vou testar integração
1. Leia `Infra-IA\setes-sync\03-INSTRUCOES_TESTE.md`
2. Siga os passos para validar

---

## ✅ Checklist Geral

- [ ] setes-api rodando na porta 3000
- [ ] setes-sync rodando na porta 3001
- [ ] Swagger acessível em /docs
- [ ] MySQL conectado (setes_central)
- [ ] Sincronizador comunicando com setes-sync
- [ ] setes-app em desenvolvimento
- [ ] Documentação centralizada em Infra-IA/

---

## 🎯 Status Atual

| Componente | Linguagem | Arquivos | Status |
|-----------|-----------|----------|--------|
| setes-api | TypeScript | 70 | ✅ Ativo (ERP) |
| setes-sync | TypeScript | 49 | ✅ Ativo (Sync) |
| setes-app | Flutter | 0 | ⏳ Em desenvolvimento |
| Sincronizador | Delphi | 481 | ✅ Produção |

**Completude Geral**: ~45% do projeto

---

## 📞 Contato

- **Email**: valdo@setes.com.br
- **Site**: https://www.setes.com.br

---

## 📌 Notas Importantes

1. **setes-api e setes-sync estão desacopladas** — Rodam em portas diferentes
2. **Documentação está centralizada** — Tudo em Infra-IA/ agora
3. **Swagger está disponível** — Interface interativa em http://localhost:3001/docs
4. **23 endpoints sincronizados** — (7 de restaurante removidos)
5. **Multi-tenant por design** — Cada cliente tem seu schema MySQL

---

*Documentação atualizada: 2026-07-01*
