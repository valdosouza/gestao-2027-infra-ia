# 📚 Índice Central — D:\Gestao2027\Infra-IA

**Versão**: 1.0  
**Última atualização**: 2026-07-04  
**Propósito**: Mapa completo de documentação, agentes e skills por projeto

---

## 🎯 Mapa Rápido por Projeto

| Projeto | Docs | Skills | Agentes | Status |
|---------|------|--------|---------|--------|
| **setes-api** | 9 | 4 | 1 | ✅ Ativo |
| **setes-sync** | 5 | 3 | — | ✅ Ativo |
| **setes-app** | 0 | 0 | — | ⏳ Futura |
| **sincronizador** | 2 | 0 | 1 | ✅ Legado |
| **database** | 0 | 2 | — | ✅ Suporte |
| **integration** | 0 | 1 | — | ✅ Suporte |
| **Central** | 5 | 0 | — | ✅ Referência |

---

## 📁 Estrutura Completa

```
D:\Gestao2027\Infra-IA/
├── INDICE_CENTRAL.md                    ← Você está aqui
├── README.md                             ← Visão geral do projeto
├── ARQUITETURA.md                        ← Design geral (Gestão 2027)
├── MAPA_SKILLS.md                        ← Índice de skills com workflows
├── SKILLS_DISPONIBLES.md                 ← Lista de skills (deprecated)
├── README_SKILLS.md                      ← Guia de skills
├── GUIA_RAPIDO_SKILLS.md                 ← Start quick
│
├── setes-api/                            (Node.js + TypeScript — ERP)
│   ├── INDEX.md                          ← START HERE
│   ├── AGENTE_ESPECIALIZADO.md           ← Agente Delphi→TS (ID: a81b168...)
│   ├── DOCUMENTACAO.md
│   ├── 01-DESACOPLAMENTO.md
│   ├── 02-VALIDACAO.md
│   ├── 03-SWAGGER.md
│   ├── Plano de Estruturacao.md
│   ├── Lista de Tabelas.txt
│   ├── diagrama da arquitetura geral.png
│   ├── prompt_fase1_setes.md
│   ├── prompt_semana2_setes.md
│   ├── prompt_semana3_setes.md
│   ├── prompt_semana4_setes.md
│   └── skills/
│       ├── setup-setes-api.md            (Setup inicial)
│       ├── novo-endpoint-erp.md          (Nova feature)
│       ├── delphi-to-typescript.md       (Converter Delphi) ← NOVO
│       └── novo-modulo.md                (TBD)
│
├── setes-sync/                           (Node.js + TypeScript — Sync)
│   ├── INDEX.md                          ← START HERE
│   ├── 01-SWAGGER.md
│   ├── 02-SETUP.md
│   ├── 03-INSTRUCOES_TESTE.md
│   ├── 04-MULTI_TENANT_SETUP.md
│   └── skills/
│       ├── setup-setes-sync.md           (Setup inicial)
│       ├── novo-endpoint-sync.md         (Nova feature)
│       ├── testar-sincronizacao.md       (QA)
│       └── swagger-endpoint.md           (TBD)
│
├── setes-app/                            (Flutter — Interface Web)
│   └── (documentação em desenvolvimento)
│
├── Sincronizador/                        (Delphi — Legado)
│   ├── Documentacao.md
│   └── Agent_Analise_Inicial_Migration.md
│
├── database/                             (MySQL Multi-tenant)
│   └── skills/
│       ├── setup-mysql-multitenant.md    (Setup BD)
│       └── novo-tenant.md                (Onboard cliente)
│
└── integration/                          (Testes E2E)
    └── skills/
        └── teste-e2e.md                  (Validação completa)
```

---

## 🚀 Projetos Detalhados

### **setes-api** (Node.js + TypeScript)
**Função**: API principal — ERP multi-tenant  
**Porta**: 3000  
**Status**: ✅ Ativo e Completo

**Documentação:**
- `INDEX.md` — Comece aqui
- `AGENTE_ESPECIALIZADO.md` — Como usar o agente Delphi→TS
- `01-DESACOPLAMENTO.md` — Status da arquitetura
- `02-VALIDACAO.md` — Testes de validação
- `03-SWAGGER.md` — Documentação de endpoints

**Skills (4):**
1. `setup-setes-api.md` — Setup inicial (~15 min)
2. `novo-endpoint-erp.md` — Adicionar novo endpoint (~15 min)
3. `delphi-to-typescript.md` — Converter Delphi → TS (~30-45 min) ⭐ NOVO
4. `novo-modulo.md` — Criar novo módulo (TBD)

**Agentes (1):**
- **Delphi-to-TypeScript** (ID: `a81b1668737619946`)
  - Especializado em converter código Delphi para TypeScript
  - Conhece padrões setes-api completamente
  - Gera Repository, Service, Routes
  - Documenta com Swagger
  - [Leia guia](./setes-api/AGENTE_ESPECIALIZADO.md)

**Fluxo de desenvolvimento:**
```
1. Lê código Delphi de D:\gestaoweb\model ou D:\gestaoweb\DataObjects
2. Mapeia tipos e estruturas
3. Gera interfaces/tipos TypeScript
4. Cria repository (queries MySQL) + service (lógica) + routes (endpoints)
5. Adiciona validação com Zod
6. Documenta com Swagger JSDoc
7. Você integra no projeto
```

---

### **setes-sync** (Node.js + TypeScript)
**Função**: API de sincronização — Delphi ↔ MySQL  
**Porta**: 3001  
**Status**: ✅ Ativo e Completo

**Documentação:**
- `INDEX.md` — Comece aqui
- `01-SWAGGER.md` — Interface Swagger/OpenAPI 3.0
- `02-SETUP.md` — Instalação e configuração
- `03-INSTRUCOES_TESTE.md` — Testes e validação
- `04-MULTI_TENANT_SETUP.md` — Multi-tenancy

**Skills (3):**
1. `setup-setes-sync.md` — Setup inicial (~20 min)
2. `novo-endpoint-sync.md` — Adicionar novo endpoint (~20 min)
3. `testar-sincronizacao.md` — Validar multi-tenant (~15 min)

**Endpoints**: 23 total (brand, customer, product, etc.)

---

### **Sincronizador** (Delphi — Legado)
**Função**: Lê Firebird, envia para setes-sync  
**Status**: ✅ Em Produção (481 arquivos)

**Documentação:**
- `Documentacao.md` — Overview
- `Agent_Analise_Inicial_Migration.md` — Análise para migração

**Notas:**
- POST para `http://localhost:3001/<recurso>/sincronize`
- Autenticação: `X-Api-Key`
- Estrutura Delphi bem documentada

---

### **Database** (MySQL Multi-tenant)
**Função**: Setup e gerenciamento de schemas por cliente

**Skills (2):**
1. `setup-mysql-multitenant.md` — Setup inicial BD (~30 min)
2. `novo-tenant.md` — Adicionar novo cliente (~5 min)

---

### **Integration** (Testes E2E)
**Função**: Validação completa de fluxos

**Skills (1):**
1. `teste-e2e.md` — Teste fluxo Sincronizador → setes-sync → setes-api (~20 min)

---

## 🎯 Fluxos de Trabalho Recomendados

### "Quero converter código Delphi para TypeScript"
```
1. Leia: setes-api/skills/delphi-to-typescript.md
2. Use agente: a81b1668737619946
3. Integre no projeto
4. Teste: npm run dev
```
**Tempo**: ~45 min

### "Quero adicionar novo endpoint ERP"
```
1. Leia: setes-api/skills/novo-endpoint-erp.md
2. Use: agente Delphi→TS OU escreva manualmente
3. Registre rota em gateway/router.ts
4. Teste com JWT
```
**Tempo**: ~30 min

### "Quero fazer setup completo do projeto"
```
1. database/skills/setup-mysql-multitenant.md
2. setes-sync/skills/setup-setes-sync.md
3. setes-api/skills/setup-setes-api.md
4. integration/skills/teste-e2e.md
```
**Tempo**: ~1h30min

### "Quero adicionar novo cliente"
```
1. database/skills/novo-tenant.md
2. (5 min, pronto!)
```

---

## 🤖 Agentes Disponíveis

| Nome | ID | Especialidade | Quando usar |
|------|----|----|--------|
| **Delphi-to-TypeScript** | a81b1668737619946 | Converter Delphi → TS | Reescrever Models, DataObjects |

**Criar novo agente:**
- Se um fluxo repetir em 3+ tarefas → vale a pena agente especializado
- Template: Basear em guia de [skill-creator](C:\Users\Valdo\AppData\Roaming\Claude\local-agent-mode-sessions\skills-plugin\8564a388-c814-4e92-9b49-329dbdf8ee8c\01409f39-efff-4d79-b164-25a2df4879ae\skills\skill-creator)

---

## 📊 Recursos Externos Referenciados

| Recurso | Localização | Uso |
|---------|-------------|-----|
| Código setes-api | D:\Gestao2027\setes-api | Fonte principal |
| Código setes-sync | D:\Gestao2027\setes-sync | Fonte principal |
| Sincronizador | D:\Gestao2027\Sincronizador | Referência legada |
| Código Delphi | D:\gestaoweb\model, D:\gestaoweb\DataObjects | Conversão |

---

## ✨ Boas Práticas

### Antes de Iniciar Tarefa
1. ✅ Consultei este índice?
2. ✅ Existe skill para isto?
3. ✅ Existe agente especializado?
4. ✅ Existe documentação relevante?

### Após Completar Tarefa
1. ✅ Gerou novo conhecimento?
2. ✅ Vale a pena documentar/criar skill?
3. ✅ Vale a pena criar agente reutilizável?

### Criando Novo Recurso
1. **Skill simples** (~30 min) → arquivo .md em `<projeto>/skills/`
2. **Agente especializado** (reúso alto) → seguir guia skill-creator
3. **Documentação** (referência) → arquivo .md em `<projeto>/`

---

## 🔗 Links Rápidos

**Comece por:**
- [README.md](./README.md) — Visão geral Gestão 2027
- [MAPA_SKILLS.md](./MAPA_SKILLS.md) — Índice de skills com workflows
- [setes-api/INDEX.md](./setes-api/INDEX.md) — Documentação setes-api

**Por projeto:**
- [setes-api](./setes-api/) — ERP principal
- [setes-sync](./setes-sync/) — Sincronização
- [Sincronizador](./Sincronizador/) — Legado Delphi

---

## 📝 Histórico de Atualizações

| Data | O quê | Versão |
|------|-------|--------|
| 2026-07-04 | Índice central criado | 1.0 |
| 2026-07-04 | Agente Delphi→TS documentado | 1.0 |
| — | — | — |

---

**Gestão 2027 — Infra-IA Centralizado e Organizado! 🎯**
