# 📚 Índice Central — D:\Gestao2027\Infra-IA

**Versão**: 2.2  
**Última atualização**: 2026-07-10  
**Propósito**: Mapa completo de documentação, agentes e skills por projeto

---

## 🎯 Mapa Rápido por Projeto

| Projeto | Docs | Skills | Agentes | Status |
|---------|------|--------|---------|--------|
| **setes-api** | 11 | 4 | 1 | ✅ Ativo (Fase 2 concluída no backend) |
| **setes-sync** | 5 | 3 | — | ✅ Ativo |
| **setes-app** | 2 | 3 | 1 | 🔨 Fase 1 em construção (fundação pronta, cadastros em evolução) |
| **sincronizador** | 2 | 0 | 1 | ✅ Legado |
| **database** | 1 | 3 | — | ✅ Suporte (espelho de D:\Gestao2027\sql) |
| **skills-genericas** | — | 2 | — | ✅ Qualquer projeto |
| **git-github** | 6 | 1 script | — | ✅ Suporte |
| **codigo-aprendizado** | — | — | — | ✅ POCs/estudo |
| **integration** | 0 | 1 | — | ✅ Suporte |
| **Central** | 7 | 0 | — | ✅ Referência |

**Onde alocar arquivos novos**: `ORGANIZACAO_PASTAS.md` (tabela de decisão + regra de simetria). Prompts em otimização: `prompts/`.

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
├── setes-app/                            (Flutter — Web/Android/iOS)
│   ├── INDEX.md                          ← START HERE
│   ├── prompt_fase1_fundacao.md          ← Prompt Fase 1 fechado (23 decisões)
│   ├── temp/                             (Agent_Context_App.md = stack oficial; THEME_EXAMPLE.md)
│   └── skills/
│       ├── criar-formulario-cadastro.md  (Contrato visual + workflow CRUD) ⭐ NOVO
│       ├── campo-lookup-fk.md            (FK com lista de apoio filtrável) ⭐ NOVO
│       └── internacionalizar-form.md     (i18n pt/en obrigatório) ⭐ NOVO
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
- `04-AUTH-MULTI-INSTITUTION.md` — Login unificado, JWT institutionId, módulo auth ⭐ NOVO
- `prompt_fase2_gerenciamento_central.md` — Prompt Fase 2 fechado (21 decisões arquiteturais) ⭐ NOVO
- `ARQUITETURA_MODULOS_API.md` — ⭐ 2026-07-11: 1 cadastro = 1 módulo SIMÉTRICO com o
  setes-app (6 arquivos: interface/dto/repository/service/controller/routes); URL
  /api/<modulo> espelha /home/<modulo>; guard POR MÓDULO ("super" nunca vira pasta nem
  URL). LER antes de criar/alterar módulo de cadastro.

**Skills (4):**
1. `setup-setes-api.md` — Setup inicial (~15 min)
2. `novo-endpoint-erp.md` — Endpoint avulso em módulo legado (erp/core/admin/sync) (~15 min)
3. `delphi-to-typescript.md` — Converter Delphi → TS (~30-45 min); cadastros saem no padrão simétrico
4. `novo-modulo.md` — ⭐ 2026-07-11: Novo módulo de CADASTRO no padrão simétrico (6 arquivos, área no gateway) — par da criar-formulario-cadastro.md do app (~20-30 min)

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

### **setes-app** (Flutter — Web/Android/iOS)
**Função**: Aplicativo do usuário final (ERP)
**Status**: 🔨 Fase 1 em construção

**Documentação:**
- `INDEX.md` — Comece aqui
- `prompt_fase1_fundacao.md` — Prompt Fase 1 fechado (23 decisões)
- `ARQUITETURA_MODULOS.md` — ⭐ 2026-07-11: 1 interface = 1 módulo flutter_modular
  (camadas completas + bloc), app/shared (register + lookup), RouterOutlet no Home,
  regra de promoção (módulo nunca importa módulo). LER antes de criar qualquer tela.

**Skills (3):** ⭐ NOVO 2026-07-10
1. `criar-formulario-cadastro.md` — Contrato visual (AppBar voltar/check, abas, ícones Android) + workflow de CRUD (~30-60 min)
2. `campo-lookup-fk.md` — Campo FK readOnly + lista de apoio com filtro (SetesLookupField/showSetesLookup)
3. `internacionalizar-form.md` — i18n pt/en obrigatório em todo form (register.*, forms.*, lookup.*)

**Agentes (1):**
- **setes-form-builder** (`D:\Gestao2027\.claude\agents\setes-form-builder.md`)
  - Cria/reforma cadastros no padrão customer_register (código de referência em codigo-aprendizado/weberpsetes)
  - Lê as 3 skills acima antes de codar; entrega com flutter analyze limpo

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

**Documentação:**
- `PADROES_BANCO.md` — Padrões permanentes: herança por PK, tb_, setes_<schema>, IDs pela aplicação, central × schema ⭐ NOVO

**Skills (3):**
1. `setup-mysql-multitenant.md` — Setup inicial BD (~30 min)
2. `novo-tenant.md` — Adicionar novo cliente (~5 min)
3. `revisar-ddl.md` — Checklist antes de executar qualquer DDL (~15 min) ⭐ NOVO

**Scripts canônicos**: `D:\Gestao2027\sql\01..05_*.sql` (central, seed, schema cliente, cleanup, sync)

---

### **Skills Genéricas** (qualquer projeto)

**Skills (2):**
1. `skills-genericas/refinar-prompt-arquitetura.md` — Transformar rascunho de ideias em prompt executável via rodadas de decisão numeradas ⭐ NOVO
2. `skills-genericas/atualizar-infra-ia.md` — COMO reter conhecimento: o que salvar, onde cada tipo entra, cadeia INDICE→CLAUDE.md→memória ⭐ NOVO

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

### "Quero criar/alterar tabelas no banco"
```
1. Leia: database/PADROES_BANCO.md (padrões da casa)
2. Escreva o DDL seguindo os padrões
3. Rode: database/skills/revisar-ddl.md (checklist)
4. Valide com sqlglot antes de executar
```
**Tempo**: ~30 min

### "Quero criar/melhorar um formulário de cadastro no setes-app"
```
1. Use o agente: setes-form-builder (.claude/agents/setes-form-builder.md)
   OU leia manualmente, nesta ordem:
2. setes-app/skills/criar-formulario-cadastro.md (contrato visual + workflow)
3. setes-app/skills/campo-lookup-fk.md (toda FK vira lookup com lista de apoio)
4. setes-app/skills/internacionalizar-form.md (pt.json + en.json sempre juntos)
5. Referência de qualidade: codigo-aprendizado/weberpsetes/.../customer_register
```
**Tempo**: 30-60 min por cadastro

### "Tenho um rascunho de ideias e quero virar um prompt de fase"
```
1. Leia: skills-genericas/refinar-prompt-arquitetura.md
2. Rodadas: organizar → questões numeradas → decisões registradas
3. Fechamento: entregáveis citando o nº das decisões
```
**Tempo**: 2-5 rodadas (modelo: setes-api/prompt_fase2_gerenciamento_central.md)

---

## 🤖 Agentes Disponíveis

| Nome | ID | Especialidade | Quando usar |
|------|----|----|--------|
| **Delphi-to-TypeScript** | a81b1668737619946 | Converter Delphi → TS | Reescrever Models, DataObjects |
| **setes-form-builder** | `.claude/agents/setes-form-builder.md` | Formulários de cadastro no setes-app (padrão customer_register) | Tela CRUD nova ou reforma visual/lookup/i18n ⭐ NOVO |

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
4. ✅ **Siga o processo**: `skills-genericas/atualizar-infra-ia.md` (onde salvar + cadeia de atualização)

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
| 2026-07-04 | Fase 2 (Gerenciamento Central): prompt fechado, PADROES_BANCO, skills revisar-ddl e refinar-prompt-arquitetura, doc auth multi-institution | 1.1 |
| 2026-07-04 | Reorganização de pastas: ORGANIZACAO_PASTAS.md (regra de simetria), prompts/, codigo-aprendizado incorporado, README raiz fundido em ARQUITETURA.md, setes-app espelhado, publicar-fase2.ps1 → git-github/ | 1.2 |
| 2026-07-05 | setes-app Fase 1 (Fundação): prompt fechado em 3 rodadas (23 decisões), INDEX.md do projeto, rascunho no HISTORICO, GestaoERPApps/core em codigo-aprendizado | 1.3 |
| 2026-07-10 | setes-app: 3 skills de formulário (criar-formulario-cadastro, campo-lookup-fk, internacionalizar-form) + agente setes-form-builder, extraídos do customer_register (codigo-aprendizado/weberpsetes) | 1.4 |
| 2026-07-10 | Cadastro de País reformado (1º no contrato visual): SetesFormShell no setes_widgets, fábrica Register* evoluída (readOnly, avatarBuilder, confirmação+SnackBar), i18n register.*/forms.country completo. Decisão do Valdo: código do país = padrão BACEN informado pelo usuário (não sequencial, 409 se existir mesmo excluído) — registrada em setes-app/skills/criar-formulario-cadastro.md | 1.5 |
| 2026-07-11 | Estado e Cidade reformados (códigos IBGE digitados, lookup FK, tabulação); fix DECIMAL→string do mysql2 (decimalNumbers no pool + jsonDouble no core) | 1.6 |
| 2026-07-11 | Refatoração arquitetural do setes-app: ARQUITETURA_MODULOS.md (1 interface = 1 módulo com camadas completas + bloc, padrão weberpsetes), módulo super/ desmontado em countries/states/cities, app/shared criado (register + lookup), RouterOutlet + rotas no Home (InterfaceFrame removido), agente e skills atualizados | 1.7 |
| 2026-07-11 | Cadastro de Interfaces (tb_interface): 1ª tela nova na arquitetura de módulos — id MAX+1 gerado no backend (Código readOnly), checkboxes de privilégios (tb_interface_has_privilege sincronizada no PUT), fábrica ganhou extraChildren; endpoints /super/interfaces e /super/privileges na setes-api. Decisões do Valdo em setes-app/skills/criar-formulario-cadastro.md | 1.8 |
| 2026-07-11 | Cadastro de Privilégios (tb_privilege): módulo privileges/ no setes-app (padrão 100% repetido de countries/ + id MAX+1 do precedente de Interfaces); CRUD completo em /super/privileges na setes-api (GET /:id, POST, PUT, DELETE reaproveitando o GET de lista dos checkboxes). Nenhum padrão novo | 1.9 |
| 2026-07-11 | Refatoração arquitetural da setes-api: ARQUITETURA_MODULOS_API.md — módulo super/ desmontado em countries/states/cities/interfaces/privileges (6 arquivos cada: interface/dto/repository/service/controller/routes), "super" virou área no gateway (prefixo /super + super.guard.ts), controller-utils em shared/http. URLs preservadas — app intocado. Simetria total API ↔ app; CLAUDE.md do setes-api e agente setes-form-builder atualizados | 2.0 |
| 2026-07-11 | Skills da setes-api alinhadas ao padrão simétrico: novo-modulo.md criada (deixou de ser TBD — cadastro em 6 arquivos, par da criar-formulario-cadastro.md); novo-endpoint-erp.md e delphi-to-typescript.md ganharam aviso de escopo (3 camadas só para módulos legados) | 2.1 |
| 2026-07-11 | URLs alinhadas ao módulo (decisão do Valdo): /api/super/<m> → /api/<m>, espelhando /home/<m> do app; superGuard aplicado POR MÓDULO no gateway ("super" não vira pasta nem URL); Swagger, datasources do app (10 arquivos), docs, skills, agente e memória atualizados | 2.2 |
| — | — | — |

---

**Gestão 2027 — Infra-IA Centralizado e Organizado! 🎯**
