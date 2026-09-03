# 📚 Índice Central — D:\Gestao2027\Infra-IA

**Versão**: 7.6 (acompanha a tabela "Histórico de Atualizações")  
**Última atualização**: 2026-08-16  
**Propósito**: Mapa completo de documentação, agentes e skills por projeto
**Escopo**: misto

---

## 🎯 Mapa Rápido por Projeto

| Projeto | Docs | Skills | Agentes | Status |
|---------|------|--------|---------|--------|
| **setes-api** | 11 | 4 | 1 | ✅ Ativo (Fase 2 concluída no backend) |
| **setes-sync** | 6 | 3 | — | ✅ Ativo |
| **setes-app** | 5 | 4 | 1 | 🔨 Fase 1 em construção (fundação pronta, cadastros em evolução) |
| **sincronizador** | 2 | 0 | 1 | ✅ Legado |
| **database** | 1 | 3 | — | ✅ Suporte (espelho de D:\Gestao2027\sql) |
| **skills-genericas** | — | 6 | — | ✅ Qualquer projeto |
| **git-github** | 6 | 1 script | — | ✅ Suporte |
| **codigo-aprendizado** | — | — | — | ✅ POCs/estudo + código legado (Gestao2016) |
| **Gestao2016** | 2 | — | — | 📖 Aprendizado do legado sob instrução do AUTOR (em construção) |
| **integration** | 0 | 1 | — | ✅ Suporte |
| **Central** | 7 | 0 | — | ✅ Referência |
| **engine-kit** | 3 | 5 | — | 📦 Kit de portabilidade da engine (v0.1 — só `metodo`; ver README do kit) |

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
│   ├── Agent_Analise_Inicial_Migration.md
│   ├── SISTEMA-TESTES.md                  ⭐ 2026-07-31: Sistema de testes incremental
│   ├── plano-testes-sincronizador.md      (Arquitetura, BD, endpoints, fluxo)
│   ├── GUIA-USO-TESTES.md                 (Manual, troubleshooting, referência rápida)
│   ├── CHECKLIST-IMPLEMENTACAO.md         (Integração API, smoke tests, matriz)
│   ├── DESCOBERTAS-MAPA-DEPENDENCIAS.md   (10 achados críticos, 32 tabelas, 7 níveis)
│   └── test-sync-orchestrator.pas         (Template TTestSyncOrchestrator — Delphi)
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
  (migration 005 dropou cópias locais). Onda 2 (salesman/carrier) CONCLUÍDA em 2026-08-03
  (ver prompt_onda2_salesman_carrier.md); pendente: revisão do sync (reindexação
  Firebird por cpf/cnpj/tb_no_doc.external_id — já implementada no lado setes-sync).
- `prompt_onda2_salesman_carrier.md` — ⭐ 2026-08-03 FECHADO e EXECUTADO (D1–D5):
  cadastros de Vendedor e Transportadora. D1: salesman = PROMOÇÃO de colaborador
  (novo nasce do collaborator-lookup — precedência Collaborator→Salesman por
  construção; 409 DUP_ROLE devolve id); D2: carrier = cadeia fiscal completa + aba
  Tributação (peça entity-tax PROMOVIDA a shared no app — 2º consumidor); D3: refino
  "vendedor ATIVO" (isSalesman e lookups de atribuição exigem active='S'); D4:
  desativar/excluir livres (somente soft-delete; carteira vira histórico); D5:
  módulo `salesmen`. Seed sql/23 (interfaces 22/23); 153/153 testes; analyze limpo.
- `prompt_modulo_menus.md` — ⭐ 2026-08-04 FECHADO e EXECUTADO (D1–D4): CRUD dos
  MÓDULOS DE MENU do cliente (camada 2 — tb_module/tb_module_has_interface com
  position; migration 023; adminGuard; vínculo ordenável; exclusão graciosa;
  assertSchema centralizado; icon do menu virou nome Material string). Origem:
  06-SUGESTAO-CRUD-MODULOS-MENU.md (VGR). Pendem Q5/Q6 na rodada.
- `prompt_onda3_provider.md` — ⭐ 2026-08-03 FECHADO e EXECUTADO (D1–D3): cadastro de
  Fornecedor. Papel SEM campo próprio no legado (tblProvider.pas = active) → clone do
  carrier: cadeia fiscal completa + aba Tributação (D1). Achado estrutural corrigido:
  tb_provider estava só no baseline (fora da migration 005) — bloco canônico no sql/03 +
  migration 022 (FKs cross-schema + active default 'S' — D2/D3). Convive com linhas do
  sync (/provider/sincronize): papel soft-deletado REVIVE pelo cadastro. Seed sql/24
  (interface 24); 160/160 testes; analyze limpo. Papel bank RESOLVIDO em 2026-08-04
  (não é papel — ver baixa da decisão 8 no prompt_fase3_entidade_unica.md): cadastro
  geral do catálogo central = módulo `banks` (Super, interface 25, seed sql/25).

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
- `prompt_revisao_sincronizador_setes_sync.md` — ⭐ 2026-07-19 Prompt FECHADO (3 rodadas, 24 decisões D1–D24):
  revisão completa Sincronizador × setes-sync. Regra canônica dos dois grupos (D1), indexação por
  CPF/CNPJ/UUID — nunca emp_codigo (D3/D4), cadeia SEMPRE em setes_central + papel no schema do cliente (D13),
  contrato JSON alinhado pelo Delphi ("quem aposenta se adapta" — D15/D22), soft delete DELETED (D2),
  Brand/Package/Measure centralizados com tb_institution_has_* (D5/D17), auth tb_sync_api_key (D12),
  rest-* aposentados (D23). Plano em 7 ondas + frente Delphi paralela. LER antes de mexer na setes-sync.
- `MAPA_INDEXACAO.md` — ⭐ 2026-07-19 (D18): indexador por entidade (DOCUMENTO/UUID/
  DESCRIÇÃO/ID LOCAL), casos onde o id do Firebird É aceito, pendências da Rodada 4.
  Leitura OBRIGATÓRIA antes de criar/alterar endpoint de sync.
- `CONTRATOS_SYNC.md` — ⭐ 2026-07-19 (D22): contrato JSON de TODOS os endpoints
  revisados (fonte da verdade para o Delphi; par do Swagger /docs).
- `01-SWAGGER.md` — Interface Swagger/OpenAPI 3.0 (globs agora escaneiam os endpoints)
- `02-SETUP.md` — Instalação e configuração (⚠️ auth mudou: tb_sync_api_key, sem chave global)
- `03-INSTRUCOES_TESTE.md` — Testes e validação
- `04-MULTI_TENANT_SETUP.md` — Multi-tenancy (⚠️ pré-revisão)
- ✅ 2026-07-19: revisão IMPLEMENTADA (Ondas 1–6) — camada de gravação reescrita no
  padrão Fases 2/3; achados A1–A10 resolvidos. Patches Delphi: `sincronizador/patches-revisao-2026-07/`
- `verificacao-setes-sync.md` — ✅ EXECUTADA 2026-07-25 (handoff claude.ai celular): verificação
  local × GitHub — 28 endpoints, contrato D14, auth D12, rest* removidos, 14/14 testes; revisão
  Ondas 1–6 commitada e publicada (`583ab6d` em origin/feature/fase2-gerenciamento-central;
  merge para main em aberto)
- `prompt_notas_mercadoria_servico.md` — ⭐ FECHADO e EXECUTADO 2026-07-26 (7 decisões D1–D7):
  notas de MERCADORIA × SERVIÇO. D1: pedido conjugado = 1 nota MISTA no legado → 1 tb_order
  (id = NFL_CODIGO, que vincula TODO o processo — pendência "coluna de pedido na tb_invoice"
  MORTA por construção); D2: tb_product.kind P|M|S (migration 019 + /service novo; /merchandise
  422 p/ 'S'); D3: natureza da nota = RAMO (tb_invoice_merchandise agora gravada ×
  tb_invoice_service NOVA — migration 020; nota conjugada = 2 ramos no mesmo id); D4: RPS/lote
  não sincronizam (retorno cobre; tb_provisional_receipt_service dropada); D5: tb_order_item_detail*
  + flex dropadas (migration 021); D6: /order-service novo (snapshot escopado por kind);
  D7: bugs de catch-up do ControllerSincronia corrigidos. **Rodada 2 (D8–D11, 2026-07-27)**:
  SINCRONIA POR PROCESSO — TB_PEDIDO fora da fila (a NOTA dirige tudo); /order-* recebem o
  objeto COMPLETO (bloco `invoice` na mesma transação); hierarquia Delphi TInvoice* substitui
  as TOrder*; catálogo 33 linhas. Smoke 12/12 + 23/23 testes; patches 06/07.
- `prompt_revisao_processo_atualiza_entidade.md` — ⭐ FECHADO e EXECUTADO 2026-07-25 (5 decisões):
  revisão do processo de entidades (Cliente/Fornecedor/Transportadora/Colaborador). Decisões:
  (1) colaborador fecha ciclo externalCode em TB_COLABORADOR (bootstrap + write-back por classe);
  (2) documento inválido = sem documento (DerivePersonType em general_web — validação reativada);
  (3) sentinela 12345677654321 mantida como dupla proteção; (4) frente carrier completa
  (TCarrierSendWeb + /carrier/sincronize + seed Seq 38 + 409 do customer verifica PAPEL);
  (5) 404 EXTERNAL_CODE_NOT_FOUND mantido explícito. Seed agora tem 38 linhas.
- `prompt_correcao_documento_entidade.md` — ⭐ FECHADO e EXECUTADO 2026-07-25 (4 decisões):
  GRADUAÇÃO do sem-doc — correção de CPF/CNPJ mantém o MESMO tb_entity.id (toggle soft-deleta
  tb_no_doc). Decisões: (1) envelope `clearExternalCode:true` → Delphi limpa o EXTERNALCODE
  da tabela da classe; (2) conflitos (doc de outra entity) em `setes_central.tb_sync_conflict`
  — NUNCA mescla, ação manual; (3) órfão segue por documento SÓ se o doc estiver livre
  (ocupado → 409 EXTERNAL_CODE_ORPHAN); (4) verificação governamental (BrasilAPI/Serpro) =
  fase futura. 19/19 testes.
- `prompt_indexacao_usuario_firebird.md` — ⭐ FECHADO e EXECUTADO 2026-07-26 (8 decisões):
  indexação de USUÁRIOS do Firebird (autor das operações — resolve a pendência 1 da Rodada 4).
  Decisões: (1) autor legado = tb_user SEM credencial (password NULL/active 'N') via
  /user/sincronize; (2) cascata CPF do colaborador → TB_COLABORADOR.EXTERNALCODE →
  TB_USUARIO.EXTERNALCODE (DM.GetUserSyncRef); (3) contrato mínimo + vínculo kind='SYNC';
  (4) não-invasão da credencial de usuário web real; (5) fallback só na transição (bloco
  `user` ausente) e nunca sobrescreve autor real; (6) bloco `user` também em cashier e
  financial-statement; (7) ex-funcionário sincroniza (active/deleted no VÍNCULO);
  (8) PDV só resolve por documento (EXTERNALCODE não replica — memória
  retaguarda-replicacao-externalcode). TUserSendWeb + seed Seq 39; 20/20 testes. Ajuste
  2026-07-26 (Valdo): 7 linhas TB_REST_* REMOVIDAS do seed + DELETE idempotente no bootstrap
  (catálogo = 32 linhas; Seqs 31–37 reservados).

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
- `prompt_paginacao_telas_pesquisa.md` — ⭐ FECHADO e EXECUTADO 2026-08-03 (10 decisões
  D1–D10 + notas N1–N11): paginação de TODAS as telas de pesquisa (app × api).
  Envelope `{ ok, data, page, pageSize, total }` via `setes-api/src/shared/list`
  (COUNT com a MESMA where — carteira incluída); `PagedResult<T>` em packages/core;
  barra « X de Y » + seletor 10/25/50/100 no `RegisterPagingBar`
  (shared/register — fábrica e telas de processo); escolha do usuário persistida na
  config `page_size` (scope U, seed sql/22, PUT por chave de módulo); default
  resolvido pela API. Árvores, lookups e extrato NÃO paginam. Lista/endpoint novo
  nasce paginado — receitas nas skills criar-formulario-cadastro.md (app) e
  novo-modulo.md (api).

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
- `prompt_construcao_banco_cliente.md` — ✅ IMPLEMENTADO (2026-07-24, 10 decisões): bootstrap
  100% automático do Firebird do cliente (TB_SINCRONIA+generator+trigger, TB_LISTA_SINCRONIA
  com checkpoint LAST_UPDATE, DELETED universal, EXTERNALCODE, triggers TG_SRC_* multi-evento
  geradas do catálogo); TB_SYNC_TABLE REMOVIDA do projeto; DDL compatível Firebird 2.5↔5.0
- `prompt_indexador_terminal_pdv.md` — ⭐ FECHADO e EXECUTADO 2026-07-26 (4 decisões):
  indexador TERMINAL (PDVs com Firebird próprio → mesmo schema): fonte SISWEB\TERMINAL,
  convenção 0=Servidor Local/1..N=PDVs, mesma API key por estabelecimento, perfil PDV
  (seed só movimento), e **TB_SYNC_TABLE MANTIDA** (reversão do drop do bootstrap — ela é
  checkpoint da RETAGUARDA do Gestao2016). Web já estava pronta (terminal nas PKs de
  movimento); Delphi ligou o fio (DM.GbTerminal → LcSendWeb.Terminal). Aguarda compilação.
- `prompt_conversao_grupo_subgrupo_categoria.md` — ⭐ NOVO, ✅ IMPLEMENTADO 2026-08-01
  (7 decisões; limpeza prévia 2026-08-04): conversão TB_GRUPOS/TB_SUBGRUPOS → TB_CATEGORY no BOOTSTRAP (dois níveis:
  grupo=raiz, subgrupo=filha; ids novos via GN_CATEGORY; PRO_CODCAT SUBSTITUÍDO livremente
  — campo não estava em uso; PDV não converte); DDL TB_CATEGORY+GN+PRO_CODCAT no EnsureCategoryTable;
  category_send_web passou a derivar parentId do POSIT_LEVEL (hierarquia chega à web);
  Fc_GrupoToCategoria delega ao motor. Passo 0 (D7, 2026-08-04): LIMPEZA PRÉVIA condicionada
  a sujeira — linha que a conversão não produziria zera TB_CATEGORY+PRO_CODCAT+generator e
  reconverte do zero; tabela conforme passa ilesa (limpar a cada start trocaria ids e
  reencheria a fila). Aguarda compilação.
- `roteiro-implantacao-cliente.md` — ⭐ 2026-07-25 (handoff claude.ai celular): implantação de
  campo por cliente em 6 fases (chave tb_sync_api_key → DDL Firebird → registro SISWEB →
  primeiro start/bootstrap → sincronização inicial na ordem D8 com validações → encerramento);
  NFS-e/CC-e fora até o patch 04. Repo saneado 2026-07-25: .gitignore Delphi criado, `config`
  (payload real de cliente) e __history/ removidos do versionamento e EXPURGADOS de todo o
  histórico (git filter-repo + force push — HEAD `4a47628`)

**Notas:**
- POST para `http://localhost:3001/<recurso>/sincronize`
- Autenticação: `X-Api-Key`
- Estrutura Delphi bem documentada
- Checkpoint de último envio = `TB_LISTA_SINCRONIA.LAST_UPDATE` (nunca TB_SYNC_TABLE, que não existe mais)

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

**Skills (6):**
1. `skills-genericas/refinar-prompt-arquitetura.md` — Transformar rascunho de ideias em prompt executável via rodadas de decisão numeradas
2. `skills-genericas/atualizar-infra-ia.md` — COMO reter conhecimento: o que salvar, onde cada tipo entra, cadeia INDICE→CLAUDE.md→memória. ⭐ 2026-07-19: regra do **Escopo obrigatório** (`metodo | setes | misto` no cabeçalho de todo arquivo novo/tocado da Infra-IA — produtização da engine de modernização, ver `prompts/rascunho_engine_modernizacao.md`)
3. `skills-genericas/guardiao-conceitual.md` — OBRIGATÓRIA antes de criar/alterar objetos de domínio: peças de lego, não maquetes (teste do fato gerador; agente par `setes-conceito`)
4. `skills-genericas/mensagem-e-validacao.md` — OBRIGATÓRIA em tela/endpoint com feedback ao usuário: ponte única, uma pendência por vez, envelope `{error, code, ref, fields}`, catálogo-primeiro
5. `skills-genericas/revisar-riscos-sistemicos.md` — ⭐ NOVO 2026-08-03: GATE socrático pós-testes-verdes (adaptado do harness-kit `the-grumpy-tech-lead`): checklist de riscos da casa (N+1/paginação, multi-tenant, transação, idempotência), parecer JSON com score (limiar 0.70), pontos abertos como PERGUNTAS; decisão de arquitetura NUNCA é do revisor — vira questão para rodada do Valdo
6. `skills-genericas/testar-adversarial.md` — ⭐ NOVO 2026-08-03: GATE adversarial par da anterior (adaptado do harness-kit `adversarial-qa`): vetores de ataque por projeto (injeção, tenant cruzado, 409s do sync, idempotência de envelope, bordas de paginação), verdito com severidade — HIGH/CRITICAL reprova independente do score; achado confirmado VIRA teste jest permanente

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

### "Terminei uma entrega (testes verdes) e quero dar por pronta"
```
1. Rode: skills-genericas/revisar-riscos-sistemicos.md (revisão socrática — score ≥ 0.70)
2. Rode: skills-genericas/testar-adversarial.md (ataque de bordas/segurança — sem HIGH/CRITICAL)
3. Reprovou em qualquer um → retrabalhar antes de entregar; achado confirmado vira teste jest
4. Ponto que exige decisão do Valdo → questão numerada para rodada (nunca decidir por ele)
```
**Tempo**: ~30-50 min por entrega (setes-api e setes-sync; app/sincronizador = revisão estática)

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
| 2026-07-19 | **Framework de Mensagens, Alertas e Validação — prompt FECHADO** (`setes-app/prompt_framework_mensagens_validacao.md`; 8 decisões R1–R8 em 3 rodadas no dia): diagnóstico Explore (49 SnackBars default; 40+ ifs manuais nas telas novas; fields[] da API descartado; 500 irrastreável) + parecer do agente setes-conceito (ESTREIA — 3 conceitos: Validação/Mensagem/Decisão; severidade→canal por construção; 6 peças, 4 existentes). Decisões: sucesso=SnackBar e resto=dialog (R1); tb_crashlytics REFORMADA p/ setes_central com ref/code/status_code (R2, AI = exceção documentada); UMA pendência por vez com foco no campo (R3); showSetesDecision Sim/Não/Cancelar tipado (R4); adoção nas 6 telas artesanais em ONDA ÚNICA sem débito (R5); garantia = catálogo-primeiro + skill mensagem-e-validacao + setes-form-builder atualizado (R6); sem severidade no JSON (R7); catálogo de erros HÍBRIDO — error-codes.ts fonte + tb_error_catalog gerada por errors:gen, padrão fields:gen (R8). Implementação em 3 ondas AGUARDA "vamos implementar" | 5.6 |
| 2026-07-19 | **Framework de Mensagens/Validação IMPLEMENTADO (Ondas A–C no dia; R5 ampliada: TODAS as telas-UI)**. API: envelope `{error, code?, ref?, fields[]}`; tb_crashlytics CENTRAL (migration 017; fire-and-safe; ref exibido ao usuário) + error-codes.ts (20) + errors:gen → tb_error_catalog; codes nos erros conhecidos; assertClientRequired 14/14 módulos. App: apresentador showSetesMessage/showSetesDecision (setes_widgets), ponte app/shared/feedback (ÚNICO canal — zero ScaffoldMessenger vivo, verificado por grep), fábrica com uma-pendência-por-vez + showServerFieldError, peças form_pendency (com beforeFocus p/ troca de aba) e field_config_of; Failure.code/supportRef + defaults i18n. Onda B em 6 grupos de agentes paralelos — MATRIZ DE CONFORMIDADE completa no prompt fechado (canônicas, artesanais, processos, compostas com troca-de-aba no foco e DUP_ROLE por code→askDecision, árvores, painéis, auth/home/shared). Governança: skill mensagem-e-validacao OBRIGATÓRIA + setes-form-builder com catálogo-primeiro. Smoke: 409+code ✓, ref→crashlytics→JOIN catálogo ✓; 134/134; analyze 0 | 5.7 |
| 2026-07-19 | **Frente de produto aberta: Engine de Modernização de Legado** (visão do Valdo: "tudo vira produto vendável" — engine portável que avalia repositório legado e reescreve o software; Gestão 2027 = caso zero/dogfooding; natureza = agentes+RAG, não modelo treinado). Estratégia: NÃO separar método × conteúdo Setes agora (regra dos 3 casos; método em mutação) — **marcar em vez de separar**: regra do `Escopo: metodo\|setes\|misto` em todo arquivo da Infra-IA (skill atualizar-infra-ia.md) + diário de produto `prompts/rascunho_engine_modernizacao.md` (visão, inventário método/misto/setes, questões futuras, diário de insights append-only). Revisão do sincronizador promovida a **caso nº 2** do método (testa generalização além de telas ERP); gatilho da separação real = sync concluído OU 1ª empresa candidata → rascunho entra na refinar-prompt-arquitetura | 5.8 |
| 2026-07-19 | **Censo retroativo de Escopo COMPLETO** (decisão do Valdo: deixar o acervo sem avaliação = débito para a engine; classificar o próprio repositório = dogfooding da Fase 1): 4 agentes paralelos marcaram **88 documentos** — 16 `metodo` (skills genéricas + git-github + secrets), 20 `misto` (fila de destilação futura: arquiteturas de simetria, Delphi→TS, análise de legado, padrões de banco, skills de formulário), 52 `setes` (caso zero). Fora do censo: `codigo-aprendizado/` (código de estudo, não doc). Colisão corrigida: linha `Escopo` antiga do prompt_fase2_campos_configuraveis virou `Projetos`. Censo consolidado na seção 3.1 do `prompts/rascunho_engine_modernizacao.md`; verificação por grep | 5.9 |
| 2026-07-19 | **Caso nº 2 real da engine: Softworks** (Valdo é dev lá; ~2M LOC/30 anos — testa ESCALA; já iniciada com indexação em grafo + memória + Obsidian). Registrado na seção 2.1 do rascunho da engine + regra de higiene multi-caso (conteúdo de caso NUNCA cruza empresas; só o método viaja; `misto` destilado sob demanda) + questão de PI na fila das rodadas. Sincronizador segue como caso interno (natureza serviço×telas) | 6.0 |
| 2026-07-19 | **Kit de Portabilidade da engine v0.1 — `engine-kit/`** (1ª destilação real, a pedido do Valdo): README (manifesto+higiene multi-caso+versionamento), ESTRUTURA_BASE_CONHECIMENTO (Fase 0: o "vaso" — esqueleto+templates+tripla de memória), skills/ (guardiao-conceitual, rodadas-de-decisao, reter-conhecimento, censo-de-escopo, avaliar-repositorio-legado — este último = 1º `misto` destilado, do Agent_Analise + Fase 1.0 de dimensionamento/indexação p/ repos grandes) e seguranca-git/ (11 docs copiados e NEUTRALIZADOS por agente — placeholders `<conta-github>`/`<repo-*>`/`<responsável>`; varredura final zero resíduos de instância; originais intocados). Achado do agente: string em formato de chave Google/Firebase como "exemplo" em SETUP_PROTECAO_SECRETS.md — Valdo confirmou ser exemplo e encurtou o texto no original (resolvido no dia). Casa canônica do kit fica p/ a rodada de PI | 6.1 |
| 2026-07-19 | **Revisão Sincronizador × setes-sync — prompt FECHADO** (3 rodadas no dia, 24 decisões; método refinar-prompt-arquitetura; caso nº 2 da engine): rascunho do Valdo (HISTORICO) virou `setes-sync/prompt_revisao_sincronizador_setes_sync.md`. Achados A1–A10: código atual é pré-Fases 2/3 (grava cadeia no schema do cliente, usa id Firebird como entity id, sem reindexação por documento). Decisões-chave: dois grupos canônicos (D1), documento/UUID como indexador com tb_empresa.externalCode (D3/D4/D14), cadeia em setes_central + papel no cliente (D13), Delphi se adapta ao formato novo (D15/D22), DELETED no Firebird (D2), Brand/Package/Measure centrais com vínculo (D5/D17/D24), auth por tb_sync_api_key (D12), fila e rest-* removidos (D19/D23), XMLs em disco por CNPJ (D20). Plano: ondas 0–6 + frente Delphi (C1–C12). Sentido inverso = fase própria (D16) | 6.3 |
| 2026-07-19 | **Revisão do Sincronizador IMPLEMENTADA — Ondas 1–6 no dia** ("vamos implementar" com autonomia; frente Delphi = kit de patches). **O1** fundação: auth por tb_sync_api_key (JOIN tb_institution; chave global aposentada), envelope D14 com HTTP<>200 nos erros (antes erro voltava 200 e o Delphi marcava sincronizado!), fila/service mortos e rest-* removidos (HISTORICO). **O2** peças da cadeia copiadas da setes-api + motor de reindexação sync.entity (CPF/CNPJ→entity única; UUID tb_no_doc devolvido como externalCode; 14 testes no banco real) + MAPA_INDEXACAO/CONTRATOS_SYNC. **O3** catálogos centrais tb_brand/package/measure (sql/01 + migration 018 cross-schema; dedupe D17 na aplicação — UNIQUE fundiria acentos) + 12 endpoints de cadastro (measure era GAP; smoke ciclo completo 15/15; 3 agentes paralelos acharam código antigo quebrado contra o DDL real). **O4** papéis: customer (entityTax ganhou casa p/ CLI_ENVEMAILAUT/ENVSOMENTEXML), provider, salesman (precedência Collaborator→Salesman na transação), bank-account (FEBRABAN; fix C1); smoke provou MESMO CNPJ cliente+fornecedor = 1 entity/2 papéis. **O5** movimento: orders/invoices (2 endpoints NOVOS)/stock/cashier/financial — financeiro no formato 5.5 com **semântica de ESPELHO** (baixa legado = evento 1 'N'; estornos não viajam); Swagger corrigido (globs não liam endpoints). **O6** retornos NF-e 55/65/NFS-e (tb_invoice_return_* já existiam; C3 vira patch) + filexml em disco `<cnpj>/<ano>/<mes>` (D20; path traversal bloqueado). **Rodada 4 aberta** (3 achados DDL no MAPA): tb_order.tb_user_id NOT NULL, vínculo nota×pedido, PK tb_stock_statement. Kit Delphi C1–C12 em `sincronizador/patches-revisao-2026-07/` | 6.4 |
| 2026-07-19 | **Kit v0.2 — `engine-kit/INSTALACAO.md`** (feedback do Valdo: instalação não estava executável): passo a passo Dia 1 (montar o vaso: pastas via PowerShell, regras da raiz, índice, conexão com ferramentas existentes — indexador/memória/Obsidian se registram e se governam —, censo do acervo) e Dia 2+ (dimensionar volumetria, unidades de análise, UMA unidade piloto ponta a ponta, 1º ciclo completo avaliar→conceituar→decidir→reter com dono das decisões NOMEADO) + seção "o que nunca fazer" (higiene multi-caso e fronteira método×empresa). README aponta p/ o guia; versionamento do kit atualizado | 6.2 |
| 2026-08-01 | **Conversão Grupo/Subgrupo → Categoria no BOOTSTRAP** (`Sincronizador/prompt_conversao_grupo_subgrupo_categoria.md`, 6 decisões): TB_GRUPOS/TB_SUBGRUPOS viram TB_CATEGORY em dois níveis na preparação do banco (EnsureCategoryTable = DDL TB_CATEGORY+GN_CATEGORY+PRO_CODCAT antes das triggers; MigraGruposParaCategoria = conversão DEPOIS das triggers para cair na fila); ids novos via GN_CATEGORY; PRO_CODCAT SUBSTITUÍDO livremente (campo não estava em uso; subgrupo=nível 2 > grupo-somente=raiz); PDV não converte (colisão com replicação da retaguarda — Q8); `category_send_web` derivou parentId do POSIT_LEVEL (TODO fechado — hierarquia agora chega à web); Fc_GrupoToCategoria delega ao motor. Aguarda compilação Delphi | 6.5 |
| 2026-08-03 | **Gate de qualidade adaptado do harness-kit (análise D:\harness-kit)**: 2 skills genéricas novas — `revisar-riscos-sistemicos.md` (revisão socrática de tech lead: score-gate 0.70, pontos abertos como perguntas, decisões continuam do Valdo) e `testar-adversarial.md` (QA adversarial: vetores da casa, severidade, achado vira teste) — piloto em setes-api/setes-sync. Veredito da análise: NÃO adotar project-memory/scope-refinement (colidem com simetria Infra-IA e rodadas de decisão); orquestrador autônomo só p/ ondas já decididas (avaliação futura); loop tracer→evaluator→meta-harness e SDK multi-runner = candidatos a destilar p/ engine-kit (registrado no diário da engine). engine-kit v0.3 já consome harness-kit como plugin (regra: nunca fundir código) | 6.6 |
| 2026-08-03 | **Engrenagem condicional (ajuste da decisão 11 do Framework de Configurações)**: o ícone de configuração só aparece se o módulo TEM configs no catálogo — peça única `RegisterConfigButton` (app/shared/register; GET resolvido na montagem + cache de sessão) usada pela fábrica (configModuleKey) e direto no AppBar das telas de processo/árvore (service_orders, settlements, categories, financial_plans — réplicas manuais removidas). Efeito: árvores perdem a engrenagem vazia; listas paginadas mantêm (page_size). Skill criar-formulario-cadastro e prompt do framework atualizados. Publicado no GitHub (setes-app 930137c; setes-api com paginação/zod-pt/migrations 019–021 em 4 commits) | 6.7 |
| 2026-08-03 | **Entidade Única Onda 2 — Vendedor + Transportadora FECHADA e EXECUTADA no dia** (Rodada 1 D1–D5 do Valdo; prompt em setes-api/prompt_onda2_salesman_carrier.md): salesman = PROMOÇÃO de colaborador (D1 — o "novo" abre lookup de colaboradores; precedência Collaborator→Salesman morre POR CONSTRUÇÃO; módulo NÃO importa @shared/entity), carrier = molde collaborators + aba Tributação (D2 — EntityTaxData/EntityTaxTab PROMOVIDAS de customers p/ app/shared/entity, i18n forms.entityTax.*), refino "vendedor ATIVO" (D3 — existsSalesman e roleLookup exigem active='S'; fecha pendência da decisão 15), soft-delete livre (D4), módulo `salesmen` (D5). API: módulos salesmen/carriers (6 arquivos cada), collaborator-lookup, flags no insertDefaultFlags, seed sql/23 (interfaces 22/23 Registers + gates + page_size) aplicado em dev, 10 testes novos (153/153). App: módulos salesmen (14 arquivos — form da fábrica com draft no bloc) e carriers (15 arquivos — 6 abas) via agente setes-form-builder; analyze limpo. Onda 2 da Fase 3 SAI das pendências | 6.8 |
| 2026-08-04 | **Módulo de Menus do cliente FECHADO e EXECUTADO no dia** (sugestão 06 do VGR → prompt `setes-api/prompt_modulo_menus.md`; Rodada 1 D1–D4 em bloco pelo Valdo): a camada 2 do menu ganhou escrita — D1 módulos gêmeos `modules` (/api/modules ↔ /home/modules, chave i18n existente), D2 adminGuard + flag 'modules' (defaults + seed retroativo), D3 vínculo ORDENÁVEL (position por linha; a ordem do array do PUT é a ordem do menu; sync transacional revoga+upsert; getMenus ordena por position), D4 legado fora (migration 023: drop link_name, image_icon INT→VARCHAR(50) nome Material — valor numérico anulado; contrato /api/core/menus icon virou string com parse tolerante no app). Extras da entrega: assertSchema CENTRALIZADO em @shared/db/schema (fim da quadruplicação core/users/admin/field-config), lookup /api/modules/interface-lookup (elegíveis = contratadas kind T fora do Super; 422 com ids em fields[]), exclusão graciosa (telas voltam ao group_default), fábrica do app ganhou hint/trailingBuilder/deleteConfirmMessage + util materialIconByName (skill criar-formulario-cadastro atualizada), seed sql/26 (interface 26 Sistema, id dinâmico). GATES: socrático 0.78 ✅ (correções: 404 transacional no PUT×DELETE, ungrouped ignora módulo morto, migration anula ícone numérico) + adversarial 0.84 ✅ sem HIGH (fechos: teto INT no position, interfaceIds.max(200), ordem de locks unificada). API 193/193 + tsc; app analyze limpo + testes verdes. Pendem Q5 (vínculo que ficou inelegível: 422 × drop silencioso × 422 só p/ novos) e Q6 (sincronia de deploy do contrato do menu) p/ rodada. Achado colateral: flag 'users' nunca semeada (403 p/ admin de cliente) — chip de sessão própria aberto | 7.2 |
| 2026-08-04 | **Rodada pós-gate do banks — 3 decisões do Valdo executadas**: Q1 soft delete restaurável (recriar number excluído REVIVE a mesma linha, id/FKs preservados; 409 só p/ number vivo — padrão revive do provider); Q2 MAX+1 transacional FOR UPDATE padronizado em privileges e interfaces (banks já tinha); Q3 peça `escapeLike` no @shared/list aplicada aos 20 repositories com filtro LIKE (%/_/\\ deixam de ser coringa; REGRA: filtro novo usa a peça). Lembrete registrado: banco é cadastro EXCLUSIVO do Super — cliente só consome. 179/179 testes, tsc limpo. Incidente corrigido no dia: script PowerShell de aplicação em lote corrompeu acentuação (ANSI×UTF-8) dos 20 arquivos — revertido por re-encode cp1252→UTF-8, verificação de integridade ok | 7.1 |
| 2026-08-04 | **Decisão 8 da Fase 3 ENCERRADA — Bank não é papel; cadastro de Bancos entregue**: decisão do Valdo (2026-08-04, coerente com a DP2 do Software House): banco = cadastro GERAL do catálogo central (setes_central.tb_bank FEBRABAN), SEM cadeia fiscal, liberado a todos os schemas via lookup de conta corrente (/api/bank-accounts/banks). Manutenção = módulos gêmeos `banks` (Super): API 6 arquivos molde countries (id interno MAX+1; number 3 dígitos digitado, único mesmo contra excluído → 409; number editável no PUT — não é a PK; lista paginada) + superGuard no gateway; app molde countries; seed sql/25 (interface 25 'banks' grupo Super + campos + page_size; 'banks' na lista canônica do seed 22) aplicado em dev. App: módulo banks (agente setes-form-builder, molde countries; analyze limpo). GATES (estreia dupla nas skills 2026-08-03): socrático 0.78 ✅; adversarial reprovou a 1ª rodada (HIGH: DELETE de banco em uso) → correções na entrega: DELETE 409 BANK_IN_USE + listBankUsage cross-schema, insertBank MAX+1 transacional FOR UPDATE, clamp MAX_PAGE no shared/list (blindou as 17 listas contra page=1e21 → 500), seed 25 id dinâmico por i18n_key, DTO trim/'000', fields[] no 409 de corrida; achados fixados em teste (banks.test.ts 17 casos; 177/177, tsc limpo). Questões p/ rodada: reversão de exclusão, MAX+1 transacional em privileges/interfaces, escape de %/_ nos LIKE. Baixa registrada em prompt_fase3_entidade_unica.md e prompt_onda3_provider.md — NENHUM papel pendente na decisão 8 | 7.0 |
| 2026-08-03 | **Entidade Única Onda 3 — Fornecedor FECHADA e EXECUTADA no dia** (Rodada 1 D1–D3 do Valdo; prompt em setes-api/prompt_onda3_provider.md): papel sem campo próprio no legado (tblProvider.pas = active) → clone do carrier com aba Tributação (D1). Achado estrutural: tb_provider estava SÓ no baseline (fora do realinhamento da migration 005) — bloco canônico no sql/03 + migration 022 (FK id→tb_entity + FK institution cross-schema + active default 'S' — D2/D3), aplicada em dev. API: módulo providers (6 arquivos), gateway, flag no insertDefaultFlags, seed sql/24 (interface 24 Registers + page_size) aplicado, providers.test.ts 7 casos (160/160, tsc limpo). App (agente setes-form-builder): módulo providers 15 arquivos espelho do carriers (6 abas, DUP_ROLE → decisão tipada, prefill by-document), rotas, i18n pt/en; analyze limpo. Convivência com o sync validada por teste (papel soft-deletado do /provider/sincronize REVIVE pelo cadastro). Da decisão 8 da Fase 3 resta só o papel bank | 6.9 |
| 2026-08-16 | **Gates da Onda 1 (tax-rules) EXECUTADOS — entrega reprovaria e foi corrigida em sessão**: adversarial contra o banco REAL achou 2 HIGH invisíveis aos 212 testes mockados (lista 500 por `st.description`×`name`; 8 catálogos fiscais centrais VAZIOS → seed `sql/28_catalogos_fiscais_seed.sql` com listas verificadas no legado un_Conversao.pas) + 2 MEDIUM na API (RegraDireta sem escopo de institution; CFOP sem validação da decisão 33) + 2 MEDIUM no app (ST travada ligada ao desligar ICMS; fields[] `pisCofins.0.*` do Zod nunca ancorava nos paths por kind). Tudo corrigido e fixado em teste (216/216 api; analyze/testes app ok); socrático 0.82 ✅. Caso novo de calibração na skill testar-adversarial (ciclo E2E real por módulo novo + "quem povoa o catálogo?"). Questões p/ rodada: Q-G1 sentido no match (NAT_SENTIDO do legado × Q14), Q-G2 NCM parcial, Q-G4 códigos pós-legado do seed | 7.6 |
| 2026-08-16 | **Fase Faturamento Fiscal e Financeiro — prompt FECHADO (34 decisões) + DDL APLICADO + Onda 1 API ENTREGUE**: `Infra-IA/prompts/prompt_fase_faturamento_financeiro.md` (Rodadas 1–2 zeradas + rodada de achados do DDL; parecer setes-conceito APROVADO — tb_tax_ruler era maquete morta no baseline). **DDL** (migrations 025–028 aplicadas em dev + canônicos sql/01/03): família `tb_tax_rule` + 5 peças (presença=incidência; FK física SÓ em INT — D33), `tb_order_installment` (D25 materialização única), `kind` na tb_payment_types (D32 — mapa determinístico id_nfce→kind; backfill expôs dado sujo de DEV que o Valdo corrige pela tela), `tb_tax_ruler` DROPADA (D30, 0 linhas), **rename coordenado tb_cashier.tb_user_id** (D34 — contrato HTTP não carrega nome de coluna; 2 endpoints /cashier + docs vivos + FieldName Delphi). **Onda 1 API**: peça `@shared/tax-rule` (motor com as 6 sutilezas + desempate B9-corrigido + validação de CST nos catálogos) + módulo `tax-rules` (6 arquivos, lista paginada com flags has*, /catalogs lookup, cascata transacional, Swagger) + seed sql/27 (interface 27 Registers, campos, page_size) + flag default/retroativa. **212/212 testes api + 32/32 sync**; smoke ok. PENDE: módulo gêmeo do app (setes-form-builder em execução), gates socrático+adversarial da onda, ondas seguintes (cálculo por item, faturamento, financeiro) | 7.5 |
- `prompts/prompt_modulo_services.md` — Cadastro de Serviços + Tabelas de Preço (D1–D7, EXECUTADO 2026-09-02; escopo setes)
- `prompts/prompt_regra_tributacao_servico.md` — Regra de Tributação de Serviço/ISS (D1–D14, Ondas 1–3 CONCLUÍDAS 2026-09-03; escopo setes)
| 2026-08-16 | **Tributação do Gestao2016 MAPEADA POR COMPLETO + 2 planos derivados** (`Infra-IA/Gestao2016/`): `tributacao.md` = fonte-da-verdade — Regra de Tributação (seletor×resultado), motor com 6 sutilezas, **14 pipelines P1–P14** (ICMS/ST/IPI/PIS/COFINS/ISSQN/FCP/diferimento/importação/IBS-CBS/obs/validações/montagem/geração) + **8 análises transversais T1–T8** (ordem = grafo de dependências, IBS/CBS por último; rateio com resíduo; pilha de bases; persistir antes de observar). 36 questões Q13–Q36 TODAS fechadas (autor decide, IA verifica; Q25 com fonte oficial RIPI/STF). **Redesenho §6.5**: `tb_tax_rule` + peças 1:1 (presença=incidência; PIS/COFINS kind P\|C; sem peça ISS; II completa; isomórfico à tb_taxes). **Planos**: `tributacao-plano-web.md` (processo preservado + fórmulas conforme legislação) e `tributacao-plano-legado.md` (B1–B9 bugs de cálculo — destaque B2/B3 base IBS/CBS e B9 desempate estado×produto; L1–L7; O1–O3). **Frente autorização ABERTA**: `geracao-nfe-hierarquia.md` (12 classes/9.950 linhas; diagnóstico: fronteira por PROCESSO certa, por MODELO duplicada, barramento global Fr_Principal.Nfe; web = pipeline + strategy + hooks). Decisões de produto: MVA/FCP no schema do cliente (dado interpretável NÃO se compartilha); ISS do prestador; LC116 por produto; regra 5 (sugestão de IA) formalizada no INDEX | 7.4 |
| 2026-08-15 | **Aprendizado do legado Gestao2016 ABERTO — espelho `Infra-IA/Gestao2016/`** (INDEX.md + processo-pedido-nota.md): corpus construído sob INSTRUÇÃO DO AUTOR com verificação linha a linha no código; lacuna vira QUESTÃO rastreada, nunca suposição (regra do artigo do dia). Ferramenta: **graphify** (pip `graphifyy`) indexou o repo — 36.540 nós / 49.181 arestas / 99% AST real, `graphify-out/` com explain/query/affected/god-nodes; rotulagem via `--backend claude-cli` (assinatura, não API key). ⚠️ REGRA APRENDIDA: as **comunidades do graphify NÃO definem módulos** (clusteriza por imports; no Delphi tudo importa env.pas/STQuery → coesão 0,01-0,02; `UN_Pedido_Vda` caiu em "NFe XML Generation") — grafo serve p/ NAVEGAR, módulo vem do AUTOR. Conteúdo já retido (frente Pedido→Nota): tb_pedido único com PED_TIPO 1 venda/2 compra/3 ajuste/**4 venda internet** (0 ignorar, 5 consignação descontinuado); elo pedido×nota pela própria TB_ITENS_NFL (ITF_CODPED + ITF_CODNFL); `componentes/tributacao.pas` (5.847 linhas) = coração (impostos emitente×destinatário, gera nota, estoque); **estoque = movimento em TB_CTRL_ESTOQUE + trigger TG_ESTOQUE_INSERT no Firebird** (tb_estoque é saldo DERIVADO; operação E/S vem de `substring(NFL_TIPO,1,1)`); numeração assimétrica mercadoria (NFL_NUMERO, nós geramos) × serviço (RPS → **TB_RETORNO_NFS.NFS_NUMERO**, prefeitura numera) = raiz do "origens diferentes"; hierarquia TControllerPedido{Venda,Compra,Ajuste} = técnica a PRESERVAR no order-backbone; financeiro CONDICIONAL a FIN_G_ATIVAR. Descontinuados: UN_Fatura_Srv, Un_Fatura_Web. Abertas Q9 (2ª letra de NFL_TIPO) e Q10 (ControllerPedidoVda × ...Venda) | 7.3 |

---

**Gestão 2027 — Infra-IA Centralizado e Organizado! 🎯**
