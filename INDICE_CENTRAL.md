# 📚 Índice Central — D:\Gestao2027\Infra-IA

**Versão**: 2.6  
**Última atualização**: 2026-07-12  
**Propósito**: Mapa completo de documentação, agentes e skills por projeto

---

## 🎯 Mapa Rápido por Projeto

| Projeto | Docs | Skills | Agentes | Status |
|---------|------|--------|---------|--------|
| **setes-api** | 11 | 4 | 1 | ✅ Ativo (Fase 2 concluída no backend) |
| **setes-sync** | 5 | 3 | — | ✅ Ativo |
| **setes-app** | 5 | 4 | 1 | 🔨 Fase 1 em construção (fundação pronta, cadastros em evolução) |
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
│       ├── criar-formulario-cadastro.md  (Contrato visual + workflow CRUD)
│       ├── campo-lookup-fk.md            (FK com lista de apoio filtrável)
│       ├── internacionalizar-form.md     (i18n pt/en obrigatório)
│       └── cadastro-entidade-fiscal.md   (Cadeia ObjectEntity→Fiscal→Concreto) ⭐ NOVO
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
- `03-SWAGGER.md` — Swagger COMPLETO 2026-07-12 (83 operações). Regra: TODO endpoint
  novo/alterado ganha `@swagger` no `*.routes.ts` na mesma entrega — só os globs `apis`
  do swagger-config.ts são escaneados (doc fora deles não aparece no /docs)
- `04-AUTH-MULTI-INSTITUTION.md` — Login unificado, JWT institutionId, módulo auth ⭐ NOVO
- `prompt_fase2_gerenciamento_central.md` — Prompt Fase 2 fechado (22 decisões arquiteturais) ⭐ NOVO
- `ARQUITETURA_MODULOS_API.md` — ⭐ 2026-07-11: 1 cadastro = 1 módulo SIMÉTRICO com o
  setes-app (6 arquivos: interface/dto/repository/service/controller/routes); URL
  /api/<modulo> espelha /home/<modulo>; guard POR MÓDULO ("super" nunca vira pasta nem
  URL). LER antes de criar/alterar módulo de cadastro.
- `prompt_fase3_entidade_unica.md` — ⭐ 2026-07-15 CONCLUÍDA + Rodada 4 Tributação
  2026-07-17 (19 decisões): Entidade Única.
  Reuso por CPF/CNPJ (buscar-antes-de-criar; last-write-wins), personType 'N' (tb_no_doc
  + UUID), GET /api/entities/by-document (prefill aberto = feature), módulo customers
  (1º papel do cliente; 409 papel duplicado com id), schema cliente 100% modelo central
  (migration 005 dropou cópias locais). Pendente: cadastros salesman/carrier (onda 2) e
  revisão do sync (reindexação Firebird por cpf/cnpj/tb_no_doc.external_id).

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
- `prompt_fase2_campos_configuraveis.md` — ⭐ Prompt Fase 2 fechado (22 decisões, 2026-07-12):
  framework de campos configuráveis (tb_interface_has_field × tb_institution_has_field),
  painel Sistema/Admin, setes_validators × shared/validation, erro por campo, piloto nas 5 telas
- `prompt_framework_configuracoes_sistema.md` — ⭐ 2026-07-18 IMPLEMENTADO (17 decisões,
  4 rodadas): framework de configurações — nível COMPORTAMENTO da hierarquia
  (tb_interface_has_config central × tb_institution_has_config schema do cliente). Vendável =
  INTERFACE, não config (tb_interface.kind 'T'/'R' — menus filtram 'T'); scope I/U com resolução
  usuário → institution → default; painel interface_configs + engrenagem na tela de LISTA;
  padrão de estado de sessão (fim das GB_* do Delphi: JWT mínimo, shared/session-context na API,
  app/shared/session no app); piloto = 3 configs da tela Clientes (carteira do vendedor via
  tb_salesman + predominâncias PF/PJ e Consumidor/Revenda)
- `ARQUITETURA_MODULOS.md` — ⭐ 2026-07-11: 1 interface = 1 módulo flutter_modular
  (camadas completas + bloc), app/shared (register + lookup), RouterOutlet no Home,
  regra de promoção (módulo nunca importa módulo). LER antes de criar qualquer tela.

**Skills (4):**
1. `criar-formulario-cadastro.md` — Contrato visual (AppBar voltar/check, abas, ícones Android) + workflow de CRUD (~30-60 min)
2. `campo-lookup-fk.md` — Campo FK readOnly + lista de apoio com filtro (SetesLookupField/showSetesLookup)
3. `internacionalizar-form.md` — i18n pt/en obrigatório em todo form (register.*, forms.*, lookup.*)
4. `cadastro-entidade-fiscal.md` — ⭐ 2026-07-11: cadastros que herdam a cadeia fiscal (Institution/Customer/Provider/Collaborator/Bank): abas compartilhadas em app/shared/entity, draft no bloc, cascade em transação única na API. 1º caso real: Estabelecimento

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
| 2026-07-11 | Cadastro de Estabelecimento (institutions) — 1º da cadeia de entidade fiscal (skill cadastro-entidade-fiscal.md com caso real): app/shared/entity criado (ObjectEntity/ObjectEntityFiscal + 4 abas genéricas reutilizáveis por Customer/Provider/Collaborator/Bank), city_lookup dependente no shared/lookup, SetesTextField ganhou onChanged; API modules/institutions com cascade em transação única (toggle PF/PJ, diff por kind) e POST que absorveu o onboarding (cadeia → migração do schema → active='S'). POST /api/admin/institutions APOSENTADO (decisão do Valdo) | 2.3 |
| 2026-07-12 | Cadeia de entidade fiscal extraída para setes-api/src/shared/entity/ (espelho do app/shared/entity — decisão do Valdo: Customer/Provider/Collaborator/Bank vão reusar): entity.types (EntityFiscalInput/Full), entity.dto (entityFiscalBody componível + withFiscalRefinements por último), entity.repository (helpers transaction-aware + saveEntityFiscalChain; cadeia sempre em setes_central). institutions virou CONSUMIDOR (transação + tb_institution + flags — 628→240 linhas em dto/interface/repository). Refactor puro: 25 testes verdes sem mudar asserções. ARQUITETURA_MODULOS_API.md e skill cadastro-entidade-fiscal.md atualizadas | 2.4 |
| 2026-07-12 | shared/entity da setes-api desacoplada em peças SOLID (SRP/ISP — pedido do Valdo): address.*, phone.*, social-media.*, entity.* (só tb_entity), fiscal.* (só person/company) independentes (recebem conn + entityId; NUNCA importam entity) + entity-fiscal.ts (única composição) + barrel index.ts ('@shared/entity'). Refactor puro: 25 testes verdes | 2.5 |
| 2026-07-12 | Feedback do Valdo: shared/entity estava inchada (16 arquivos planos com objetos que não são da entity) — cada objeto foi para a SUA pasta sob src/shared/ (address/, phone/, social-media/, fiscal/, entity/ com entity-fiscal.ts + barrel da cadeia). Direção composição → peças mantida; imports ajustados (entity-fiscal.ts + index.ts); consumidores intactos via '@shared/entity'. tsc limpo, 25/25 verdes. Skill, ARQUITETURA_MODULOS_API e CLAUDE.md do setes-api atualizados | 2.6 |
| 2026-07-12 | Fix feature-flag.middleware (decisão 22 da Fase 2): moduleKey é `req.path.split('/')[1]` — o mount em app.use('/api') remove o prefixo do req.path (índice [2] lia 'status' em /api/erp/status; invisível porque super bypassa). Lista de isentos FLAG_EXEMPT_MODULES=['core'] (menu em /api/core/menus); cadastros do catálogo ficam fora (superGuard já bloqueia). Teste de regressão monta o middleware em /api como no app.ts; tsc limpo, 29/29 verdes | 2.7 |
| 2026-07-12 | Framework de campos configuráveis (validação + obrigatoriedade/caption/máscara por cliente): prompt em otimização `prompts/prompt_framework_campos_configuraveis.md` (11 decisões do Valdo registradas, Rodada 3 aberta) + tool `setes-api/scripts/gerar-interface-fields.ts` (`npm run fields:gen`) que gera seed de `tb_interface_has_field` a partir do information_schema | 2.8 |
| 2026-07-12 | Prompt FECHADO em 4 rodadas (22 decisões) e movido para `setes-app/prompt_fase2_campos_configuraveis.md`: DDL aprovado (catálogo central + config no schema do cliente, PK compostas, required baseline), kinds c/ Date, máscara `#`/`A`, sync isento, validação shared nas duas pontas (setes_validators × src/shared/validation), dados sem máscara, erro `{error, fields[]}`, duplicidade antecipada + 409, painel Sistema/Admin como vitrine | 2.9 |
| 2026-07-12 | **Fase 2 IMPLEMENTADA (1→6)**: DDL (sql/01 tb_interface_has_field, sql/03 + migration 004 tb_institution_has_field, seed sql/07 pilotos + interface 7); API: shared/validation (dígito verificador), parseBody `{error, fields[]}`, shared/field-config (cache TTL + assertClientRequired nos pilotos), módulo interface-fields (isento de flag) + fiscal-exists, 54 testes; app: package setes_validators (14 testes), fábrica com merge/máscara/unmask, FieldConfigLoader nos 5 pilotos, painel interface_fields, analyze limpo; skills criar-formulario-cadastro e novo-modulo ganharam seção obrigatória da Fase 2 | 3.0 |
| 2026-07-12 | Cadastro de Estabelecimento ganhou a aba **Interfaces** (contrato comercial): CRUD autônomo fora do draft (toggle = PUT imediato com rollback local no erro; só na edição — schema nasce no salvar), consumindo GET/PUT /api/admin/institutions/:id/interfaces já existentes; entidade InstitutionInterfaceGrant + 2 métodos no datasource; padrão registrado na skill cadastro-entidade-fiscal.md | 3.1 |
| 2026-07-12 | Aba Interfaces ganhou filtros LOCAIS por módulo (group_default) e nome (catálogo chegará a ~300 interfaces — lista já em memória, filtro não vai à API); design system ganhou **SetesDropdown** (encapsula DropdownButtonFormField — domínio pequeno; FK/domínio grande continua SetesLookupField) | 3.2 |
| 2026-07-12 | **Cadastro de Usuário** (interface 8, módulos users/ simétricos): grava a cadeia do LOGIN analisada no módulo auth — tb_entity (MAX+1 shared) + tb_user (MD5 UPPERCASE promovido para `@shared/auth/password`, usado por auth E users) + tb_mailing×tb_entity_has_mailing GRUPO 2 em transação única (email reusado pelo UNIQUE, 409 por campo se já é login de outro; senha opcional no PUT = mantém) + seção Estabelecimentos (tb_institution_has_user com kind/perfil — CRUD autônomo, padrão da aba Interfaces; sem vínculo ativo o login dá 403). Engine Fase 2 ligado (catálogo interface 8 no sql/07). 61 testes API verdes | 3.3 |
| 2026-07-12 | **Workflow de usuários Super × Admin** (decisões do Valdo): cadastro de usuário INDEPENDENTE de contexto — /api/users saiu do superGuard para **adminGuard** (novo; super OU admin); admin do cliente opera SÓ a própria institution (escopo FORÇADO no service, 404 sem vazar existência, perfil 'super' bloqueado); POST aceita institutionId+kind e cria o vínculo NA MESMA transação; vínculos multi-institution exclusivos do super. App: **aba Usuários no Estabelecimento** (lista filtrada + botão + com institution IMPLÍCITO → dialog de cadastro; facilita liberar o 1º admin do cliente); entities/datasource de usuário PROMOVIDOS para app/shared/users (regra de promoção — 2º consumidor); tela Usuários esconde a seção Estabelecimentos para não-super (institution implícito). 66 testes API verdes | 3.4 |
| 2026-07-12 | **ACL de usuário** (workflow do Valdo; modernização do tas_user_has_privilege do Delphi): menu por PERFIL — super=tudo, admin=contrato completo sem tb_user_has_privilege, regular=só interfaces com **VISUALIZAR** (opção 1; ids canônicos em `@shared/auth/privileges` — 1 INSERIR, 2 ALTERAR, 3 EXCLUIR, 4 IMPRIMIR, 5 FATURAR, 6 VISUALIZAR). GET/PUT /api/users/:id/privileges(/:interfaceId): interfaces CONTRATADAS × catálogo tb_interface_has_privilege × tb_user_has_privilege no schema alvo (super escolhe institution VINCULADO; admin forçado ao JWT; exige vínculo; valida privilégios contra o catálogo da interface). App: seção "Privilégios de Acesso" no cadastro de usuário — as 3 partes do Delphi viraram 2 níveis com filtro (dropdown módulo + nome → lista → dialog de checkboxes; marcar qualquer privilégio inclui Visualizar). 71 testes API verdes | 3.5 |
| 2026-07-12 | **Fix: admin via módulo Super no menu** (bug reportado pelo Valdo com contato@setes.com.br): o contrato do setes_setes incluía as interfaces 1–6 (grupo Super) e o ramo admin montava o agrupador pelo group_default. Correção: `group_default='Super'` é EXCLUSIVO do super — filtro `NOT_SUPER_GROUP` nas DUAS queries de menu do não-super (mesmo dentro de módulo do cliente); interface users (8) movida de 'Super' para **'Sistema'** (tela dual — seed com UPDATE idempotente) + contrato (1,8) para o admin da Setes. Verificado com getMenus real: admin = só Sistema; super = tudo; regular sem privilégio = menu vazio | 3.6 |
| 2026-07-12 | Aba Usuários do Estabelecimento — perfil visível e editável (feedback do Valdo): GET /api/users?institutionId= devolve o `kind` do vínculo (subselect); lista mostra "Perfil: admin/user"; dialog permite TROCAR o perfil na edição (sincroniza só o vínculo daquele institution via setInstitutions preservando os demais); perfil 'super' não é editável pela aba (exclusivo da tela de Usuários); dialog ganhou SingleChildScrollView (campo Perfil visível em janela baixa) | 3.7 |
| 2026-07-12 | Cadastro de Usuário em DUAS ABAS (Dados do Usuário × Permissões — pedido do Valdo): fábrica RegisterFormPage ganhou **extraTabs** (List<RegisterTab> + mainTabLabel; aba principal em keep-alive p/ o check validar o Form de qualquer aba; sem extraTabs = layout original). Aba Permissões reúne vínculos (super) + privilégios; na inclusão orienta salvar primeiro | 3.8 |
| 2026-07-17 | **Framework de Configurações do Sistema — prompt FECHADO** (17 decisões, 4 rodadas, método refinar-prompt-arquitetura): catálogo × valor por interface (nível COMPORTAMENTO), vendável = interface com tb_interface.kind 'T'/'R', scope I/U, padrão de estado de sessão (SessionContext × shared/session-context), piloto 3 configs da tela Clientes. Hierarquia de papéis registrada (Collaborator→Salesman, precedência obrigatória) em cadastro-entidade-fiscal.md e PADROES_BANCO.md. Movido para setes-app/prompt_framework_configuracoes_sistema.md | 3.9 |
| 2026-07-18 | **Framework de Configurações IMPLEMENTADO (peças 1–9)**: DDL tb_interface_has_config (sql/01) × tb_institution_has_config (sql/03 + migration 007), tb_interface.kind REAPROVEITADA (varchar legado → char(1) T/R via bootstrap; seeds 06/07/08 corrigidos), seed sql/09 (interfaces 10/11 + 3 configs do piloto na 9). API: @shared/interface-config (resolução usuário→institution→default + cache TTL), módulo interface-configs (painel/consumo, isento de flag), catálogo em /api/interfaces/:id/configs (superGuard), @shared/session-context (isSalesman) + bloco `context` no login/select/switch/me, filtro de carteira em customers (lista+GET :id, 404 fora da carteira), menus filtram kind='T' (3 queries), vitrine promovida p/ @shared/interface-vitrine. App: SetesSwitch, app/shared/session (SessionContext hidratado na Home), app/shared/interface_config (InterfaceConfigLoader), módulo interface_configs (renderização por kind), seção Configurações + dropdown T/R na tela de Interfaces, engrenagem na lista + banner de carteira + pré-seleções PF/PJ e Consumidor/Revenda em customers, i18n pt/en. 99/99 testes API, flutter analyze limpo | 4.0 |
| 2026-07-18 | **Cadastro de Colaborador (onda 2 da Entidade Única — 3º concreto da cadeia fiscal)**: tb_collaborator criada (sql/03 + migration 008 + seed sql/10 — interface 12 'collaborators' grupo Registers, flag técnica; campos do legado tblCollaborator.pas reescritos, typo fahters_name corrigido). Módulos gêmeos collaborators na API (cascade da cadeia em transação, 409 papel duplicado, DATE_FORMAT nas datas) e no app (5 abas — molde do customers SEM Tributação; CollaboratorTab com admissão/demissão/salário/filiação/título eleitor/cert. militar/PIS/ativo; prefill by-document; engrenagem padrão). Precedência Collaborator→Salesman fica p/ o cadastro de salesman (verificação na aplicação). Ajustes do dia: engrenagem virou padrão da fábrica (configModuleKey em TODAS as listas; voltar retorna à chamadora), painel sem nome técnico, texto explicativo no Ignorar ST, regra "sem legado no sistema" (descriptions/i18n limpos), clique em Configurações Gerais abre o painel filtrado. 99/99 testes API, flutter analyze limpo | 4.1 |
| 2026-07-18 | **Cadastro de Categorias de produtos/serviços** (grupo Cadastros; rascunho de DDL do Valdo): tb_category REALINHADA do baseline via migration 009 (FK cross-schema p/ setes_central.tb_institution — a legada apontava p/ a tb_institution local; active char(1) NOT NULL DEFAULT 'S'; KEY updated_at preservada p/ sync; kind 'P'=produto/'S'=serviço), sql/03 canônico + seed sql/11 (interface 13 'categories' + contrato + flag + catálogo de campos Fase 2). Módulos gêmeos categories: API (id MAX+1 POR INSTITUTION em transação, escopo do JWT, assertClientRequired, Swagger) e app (molde privileges; kind dropdown P/S + ativo checkbox via extraChildren; FieldConfigLoader; engrenagem configModuleKey). Fixes do dia herdados: guard superWriteGuard (geográficos leitura aberta), lookup sem loading infinito. Smoke E2E POST/PUT/GET/DELETE ok; 99/99 API; analyze limpo | 4.2 |
| 2026-07-18 | **Categorias viraram cadastro em ÁRVORE — 2º TIPO de cadastro do produto** (decisões do Valdo: abas Produtos×Serviços = árvores independentes por kind; excluir bloqueado com subníveis; mover de pai na edição): posit_level materializado calculado SEMPRE pela API (categories.path.ts — funções puras: segmento pad3, childPath, parentIdFromPath, isSelfOrDescendant; 11 testes), PUT com parentId move a subárvore em transação (CONCAT+SUBSTRING no prefixo; ciclo e kind cruzado = 400), DELETE 409 com filhos, GET ?kind= ordenado pelo caminho com parentId derivado. App: SetesTreeView novo no design system (expand/collapse, tap=edição, ação +=subnível), tela com abas + FAB=nível raiz, form com Nível Superior (lookup da própria árvore; limpar=raiz). Agente setes-form-builder e criar-formulario-cadastro.md ganharam a seção dos DOIS tipos (lista+form × árvore). Smoke E2E: criar 3 níveis, mover, ciclo 400, delete 409 ok | 4.3 |
| 2026-07-18 | **Plano de Contas (2º cadastro em ÁRVORE — valida o tipo)**: tb_financial_plans realinhada do baseline (migration 010: FK cross-schema, domínios CHAR(1), active DEFAULT 'S', KEY updated_at; nome legado source_ mantido) + seed sql/12 (interface 14 'financial-plans' grupo Registers + flag + catálogo). Semântica mapeada do ControllerPlanoContas.pas: source_=Natureza C/D, kind=Tipo C(usto)/R(esultado), cluster=Nível S(intética)/A(nalítica) — defaults Delphi C/C/S. Matemática do caminho PROMOVIDA p/ @shared/tree-path (2º consumidor). Módulos gêmeos financial-plans/financial_plans: árvore ÚNICA (sem abas — domínios são radios do form), FAB=raiz, +=subnível, mover com recálculo, delete 409 com filhos. Smoke E2E ok; 110/110 API; analyze limpo | 4.4 |
| 2026-07-18 | **Cadastro de CFOP (referência fiscal — módulo Super)**: setes_central.tb_cfop JÁ existia no sql/01 idêntica ao rascunho do Valdo (sem DDL novo); seed sql/13 (interface 15 'cfop' grupo Super + catálogo de campos; sem contrato/flag — menu do super lê o catálogo). Semântica do reg_cfop.pas/ControllerNatureza.pas: way=Sentido E/S, jurisdiction=Alçada E(stadual)/N(acional)/X(Exterior), register=inteiro livre, note=Aplicação (BLOB→CAST CHAR). id = o PRÓPRIO código CFOP digitado (padrão código externo: 409 mesmo excluído, imutável). Módulos gêmeos cfop (superGuard) e app (fábrica lista+form, radios Sentido/Alçada, Aplicação multiline — SetesTextField ganhou maxLines). Smoke E2E ok (201/409/GET/409 pós-delete); 110/110; analyze limpo | 4.5 |
| 2026-07-18 | **Formas de Pagamento (grupo NOVO Financeiro — 3º padrão de catálogo)**: tb_payment_types virou catálogo CENTRAL compartilhado (workflow do Valdo: o CLIENTE inicia — existe? só vincula; não existe? cria na central com dedupe por DESCRIÇÃO na transação, reuso entre clientes) + vínculo em setes_<schema>.tb_institution_has_payment_types (active/app_delivery). Migration 011 migrou as formas LOCAIS do baseline p/ a central (Carteira id 1), remapeou tb_customer e derrubou a local; seed sql/14 (interface 16 'payment-types', grupo Financial → menu.groups 'Financeiro'). Helpers promovidos p/ @shared/payment-types (ensureCatalogPaymentType/upsertLink) — o wallet/Carteira do customers foi REFORMADO para central+vínculo. App: form com lupa do catálogo no campo descrição (escolheu = só vincula, trava campos; digitou = cria/reusa com SnackBar), toggles Ativo/App Delivery no vínculo, excluir = desvincular. Smoke E2E ok (criar/reused/vincular/PUT/unlink); 110/110; analyze limpo | 4.6 |
| 2026-07-18 | **Formas de Pagamento v2 (atributos do vínculo)**: tb_institution_has_payment_types ganhou a configuração operacional (migration 012 + sql/03; seeds 14 atualizado / 15 novo p/ o catálogo de campos): renames `active`→`enable` (a linha do catálogo é compartilhada — o cliente desabilita por um tempo, não exclui) e `app_delivery`→`app_mobile`; novas colunas block_for_customer_blocked (não mostrar p/ cliente bloqueado), block_for_customer_no_limit (bloquear sem limite de crédito), max_parcels (default 1), tef, tb_financial_plans_id_cre (Plano de Contas Resultado, kind 'R') / _deb (Centro de Custo, kind 'C') — referência por coluna SEM FK, 0=não definido — e usage_preference 'C'aixa/'B'anco/'A'mbos (default A). API: PaymentTypeLinkAttrs em @shared/payment-types; upsertLink SEM attrs (wallet/Carteira) não sobrescreve mais a config existente — só ressuscita; lista faz LEFT JOIN nas descrições dos planos. App: campo Código para NF-e virou COMBOBOX da lista fiscal fixa (NfceCode.all, 01 Dinheiro…99 Outros; grava só os 2 dígitos; travado na edição/catálogo), novos toggles, nº máx. parcelas, radio Preferência de uso e 2 SetesLookupField de Plano de Contas (projeção local de /api/financial-plans filtrada por kind — módulo não importa módulo). **Ajuste do Valdo**: a combobox NF-e aparece TAMBÉM na edição — id_nfce deixou de ser imutável (só a descrição segue imutável, chave do reuso); PUT com idNfce atualiza a linha CENTRAL em transação (vale p/ todos os clientes vinculados); travada apenas quando a forma veio da lupa do catálogo na inclusão. 110/110 API; analyze limpo | 4.7 |
| 2026-07-18 | **Módulo Software House / Ordem de Serviço — Fases 2–7 MODELADAS (aguarda validação do Valdo)**: prompt mestre v4 do Valdo incorporado em `prompts/prompt_modulo_software_house.md` (v4.1 = + seção 11 de conformidade) e entregáveis em `setes-api/05-ORDEM-SERVICO-SOFTWARE-HOUSE.md`. Verificação contra o baseline: tb_order backbone, tb_financial* (PK natural de P7 JÁ existe — id vestigial), tb_partnership* (SEM PK — realinhar), tb_invoice e tb_bank* já existem; nascem tb_contract/tb_contract_item/tb_order_service. Entregas: ER Mermaid, rotina mensal (pró-rata 30d, 5º dia útil seg–sex DP1, estados A→F), parcerias (bills PA por baixa, estorno em cadeia), DDL validado sqlglot (event na PK do payment, status N/E/R, tb_entity_id nas bills DP10, tb_bank→central DP2), espec de baixa/settled_code N:1/estorno imutável, matriz 20 testes. ⚠️ 12 decisões provisórias (DP1–DP12) p/ o Valdo validar; NADA executado em banco/código; migration 013 só após revisão do sync (endpoints /sync/financial* gravam formato antigo) | 4.8 |
| 2026-07-18 | **Software House: DP1–DP12 TODAS validadas pelo Valdo → prompt FECHADO** (movido para `setes-api/prompt_modulo_software_house.md`): DP1 REVISADA (vencimento decidido pelo USUÁRIO na tela; 5º dia útil vira só default; P12 cancelada), DP6 REVISADA (tb_order_item universal enxuto; tb_stock/price_list saem p/ nova tb_order_item_merchandise), DP7 REVERTIDA (status na tb_order; open_lock vira coluna NORMAL mantida pela app — coluna gerada não cruza tabela), DP10 "sempre haverá uma ordem" + ramo novo tb_order_financial (entidade + trilha da baixa de origem; bills SEM entity), DP11 = NADA se apaga: PA aberta compensa com título PA+operation C (semântica invertida da seção 5.2; P10 automático segue futuro), DP12 = vencimento PA = baixa+12 dias; DP2/3/4/5/8/9 confirmadas. Entregáveis 05-ORDEM-SERVICO ajustados; DDL revalidado sqlglot 5/5. Implementação liberada p/ planejar (gate restante: revisão do sync) | 4.9 |
| 2026-07-18 | **Software House — implementação iniciada ("vamos implementar"; sync SEGUE o padrão depois, deixou de ser bloqueio)**. **Onda 1 (banco)**: migrations `013_ordem_servico` (financeiro P6/P7/P8+estorno 5.5, parcerias com PK, tb_bank→central com migração por number, item universal DP6 + tb_order_item_merchandise, tb_contract/tb_contract_item/tb_order_service/tb_order_financial) e `014_product_institution_fk` (FK legada do tb_product p/ tb_institution local VAZIA impedia criar produto — realinhada cross-schema, padrão 009/010); sql/01 ganhou tb_bank; sql/03 as 5 tabelas novas; seed sql/16 (interface 17 'contracts' grupo Registers + flag + campos). APLICADAS em dev e verificadas. Utilitários: `npm run db:migrate` + `scripts/apply-seed.ts`. **Onda 2 (Contratos)**: módulo contracts na API (itens sincronizados por productId em transação, mensalidade = SUM na leitura, lookup /api/contracts/products, cliente validado no papel local, Swagger, flag em defaultModules) + módulo contracts no app (lista+form, lookups, itens). Smoke E2E ok; 110/110. Próximas ondas: parcerias/bancos → OS+faturamento → baixa/estorno (criar skill "tela de processo") | 5.0 |
| 2026-07-19 | **Software House Onda 3 — Parcerias + Contas Bancárias**: seed sql/17 (23 bancos FEBRABAN em setes_central.tb_bank — DP2; interfaces 18 'partnerships' Registers / 19 'bank-accounts' Financial + flags + catálogo de campos). API: módulos partnerships (clientes N:N + parceiros com rate sincronizados em transação; soma ≤ 90% no DTO + service; REGRA NOVA derivada da 4.3: cliente só pode estar em UMA parceria viva → 409 — a baixa resolve "a parceria do cliente" sem ambiguidade) e bank-accounts (CRUD tb_bank_account + lookup /banks do catálogo central; banco validado na transação); flags em defaultModules. App: módulos partnerships e bank_accounts (dois agentes setes-form-builder em paralelo, molde contracts — edições cirúrgicas nos arquivos compartilhados). Smoke E2E: conta CRUD + parceria CRUD + 409 de unicidade + 400 soma>90 ok; 110/110; analyze limpo | 5.1 |
| 2026-07-19 | **Software House Onda 4 — OS/ciclo mensal + Gerar Faturamento (1ª TELA DE PROCESSO; skill nova `setes-app/skills/tela-de-processo.md` — 3º tipo de tela)**: seed sql/18 (interface 20 'service-orders', grupo NOVO 'Services'/menu Serviços) + migration 015 (FKs legadas da tb_order p/ tb_user/tb_institution locais vazias — realinhadas cross-schema, padrão 009/010/014). API service-orders: abrir OS (open_lock pela aplicação + UNIQUE = D5, 409 amigável), itens kind='Service' (DP6) com tb_order_totalizer SEMPRE recalculado no servidor, rotina mensal manual (D8) com transação POR CLIENTE + pró-rata 30d (D2/D3) + idempotência por produto/competência + RELATÓRIO, Gerar Faturamento em transação única (tb_order_billing → tb_invoice 'SE' MAX+1 [DP8] → tb_financial/bills 'RA' com quotas e resíduo na última → status 'F' na tb_order [DP7] + trava livre) com vencimento DECIDIDO PELO USUÁRIO (DP1; /expiration-suggestion = default 5º útil), cancelar aberta; funções PURAS em service-orders.calc com 12 testes jest (pró-rata/quotas/5º útil). App service_orders: abas Abertas×Faturadas, FAB abrir OS, dialog rotina com relatório, detalhe dirigido por estado, dialog faturar (forma enable='S' + parcelas + vencimento editável). Smoke E2E ciclo inteiro (pró-rata 160 + avulso 180 → fatura 340 em 2×170 RA) ok; 122/122 | 5.2 |
| 2026-07-19 | **Software House Onda 5 — Baixa/Estorno/Movimento (2ª tela de processo; financeiro IMUTÁVEL da 5.5 no ar)**: seed sql/19 (interface 21 'settlements' Financial). API settlements: carteira c/ saldo derivado (tag − Σ payments 'N'; entidade pela cadeia da ordem DP10), baixa em LOTE (settled_code MAX+1 DP9 → N payments 'N' + 1 statement; stage B/C; parcial ok; planos cre/deb do lote ou da forma de pagamento — convergência Formas v2), estorno imutável (payment inverso 'R' c/ origin_event+motivo+código próprio, statement inverso c/ id_origin, original 'E', statement original 'E' só com o código TODO estornado [P2], título reaberto stage 'N'), extrato c/ totais; **refinamento contábil**: saldo do movimento soma N/E/R (inverso compensa aritmeticamente — status é visualização; nos títulos vale só payments 'N') — registrado na Fase 6.2. Funções puras settlements.calc (7 testes). App settlements (3 abas: seleção múltipla + dialog de baixa c/ líquido sugerido; baixados c/ selos N/E/R + estorno c/ motivo; extrato c/ filtros). Ganchos Onda 6 comentados. Smoke: N:1 340 → estorno parcial reabre 170 → estorno total statement E → re-baixa parcial saldo 70 → 409 estorno de R → saldo real 100 ✓; 129/129 | 5.3 |
| 2026-07-19 | **Software House Onda 6 — Rotina de Parcerias na baixa: MÓDULO COMPLETO (fluxo fechado ponta a ponta: contrato → OS/rotina mensal → faturamento → título → baixa → movimento → parceria → estorno em cadeia)**. Baixa de recebimento RA/RM+C com parceria viva gera na MESMA transação 1 ordem PA por parceiro (tb_order 'F' + tb_order_financial: colaborador + trilha da baixa — DP10) e título PA operation D (% × pago; venc = baixa+12d — DP12). Estorno em cadeia (4.3.3+DP11): reverseOnePayment refatorado transaction-aware e reusado recursivamente; baixas vigentes do PA estornadas (E/R) + compensação PA+operation C por payable (saldo do parceiro ZERA; P10 automático futuro). PA não dispara parceria. paOrders/paReversed/paCompensated no envelope (Swagger). addDays/partnerShare puros (+5 testes → 134/134). Sem tela nova (carteira do settlements já resolve PA pela cadeia). Smoke: baixa 70 → PA 21 venc+12d → pago → estorno → cadeia 1+1 → parceiro 0, caixa 100 ✓. Resta FORA do módulo: revisão do sincronizador (segue o padrão novo — projeto próprio) | 5.4 |
| 2026-07-19 | **Parceria v2 (angariação) + GUARDIÃO CONCEITUAL** — prompt do Valdo refinado em 1 rodada (D1–D7) e implementado; fechado em `setes-api/prompt_parceria_v2.md` (rascunho no HISTORICO). O trio tb_partnership/_customer/_partner era MAQUETE (formato de sistema anterior); conceito real = ANGARIAÇÃO: colaborador trouxe o cliente → `tb_partnership` FLAT (PK inst+customer+collaborator, rate, active D7; FKs compostas p/ papéis locais; migration 016 converte e derruba o trio; sql/03 + seed sql/20). A guarda "cliente em 1 parceria viva" morreu POR CONSTRUÇÃO. Aba **Parceria** no cliente (GET/PUT /api/customers/:id/partnership; Σ ativos ≤ 90; vazia remove; interface 18 virou kind 'R' — recurso vendável; flag standalone desativada) e módulos partnerships (API+app) APOSENTADOS. settlements rateia só active='S'. **Novo na cadeia**: skill `skills-genericas/guardiao-conceitual.md` (OBRIGATÓRIA p/ objetos de domínio — princípio lego/nuvem, teste da maquete, inventário de peças, nomenclatura; CLAUDE.md item 2) + agente `setes-conceito`. Smoke: aba 40% → PA 28 venc+12d → estorno compensa → suspenso sem rateio; 134/134; analyze limpo | 5.5 |
| — | — | — |

---

**Gestão 2027 — Infra-IA Centralizado e Organizado! 🎯**
