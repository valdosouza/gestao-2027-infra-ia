# Anexo — Execução da frente da unificação do engine-kit

**Escopo**: misto (o registro de execução é do caso; o kit e as técnicas são método)
**Frente**: `prompts/prompt_engine_kit_unificacao.md` (os §15 e §17 apontam para cá)
**Por quê**: o prompt da frente passou de 59 KB; pela regra da própria frente (T26: onda executada vai para anexo), os logs de execução moram aqui.

---

## 15. Fase 1 — execução (2026-10-21)

### 15.1 O que foi feito

| Passo | Resultado |
|---|---|
| 1.1 Repo canônico | `C:\RAG\engine-kit-canonical`, criado por `git subtree split` de `engine-kit/`. Os 4 commits históricos vieram juntos, com as mensagens neutralizadas (uma citava assunto do caso). O branch temporário foi apagado daqui |
| 1.2 Trazer de A | `skills/memory-engineering/` (traduzida e neutralizada; evidência anônima "~300 logs, 6 ciclos"), `docs/ARCHITECTURE.md` (3 camadas, já no estado decidido) e `skills/git-security/references/SECRETS_PROTECTION_SETUP.md`. Este último corrige C2: "girar primeiro" virou o passo 0, a regra zero é "relatório de segredo nunca traz o valor", e a pegadinha do `*secret*` virou aviso. A conferência mostrou que os demais arquivos de A são idênticos ao histórico PT de B (manifesto: `already-carried, verified`) |
| 1.3 Trazer C (com a lógica de W) | `runtime/validate-registry.ps1`, `memory_index.py`, `build-memory-index.ps1`, `sync-skills.ps1`, `runtime/README.md`, 4 templates e `agents/feedback-analyst.md` (`design`). Foram testados numa base sintética no scratchpad: índice, consultas, validador limpo × com deriva, layout antigo, `-WhatIf` e junções de teste (removidas) |
| 1.4 Manifesto | `docs/history/consolidation-0.7.0-manifest.csv`: 55 linhas, 100% mapeado (37 `done`, 17 `verified`); os caminhos do caso W viraram `<case-W>` |
| 1.5 `kit-lint` + 0.7.0 | `runtime/kit_lint.py` (versão, deny-lists, links, Scope, tamanho/maturidade das skills, orçamento de .md). Também: `DECISIONS.md` (EK#1–9), `CHANGELOG.md` (as duas linhagens), `docs/MATURITY.md`, `marketplace.json` e um `.gitignore` sem padrão largo. Os vazamentos de B foram limpos e todas as skills e agentes ganharam rótulo de maturidade |
| 1.6 SUPERSEDED | Banner com ponteiro em `C:\RAG\engine-kit\README.md`, `C:\RAG\engine-runtime\README.md` e `engine-kit/README.md` daqui; nada apagado. Ponteiros atualizados: `INDICE_CENTRAL.md` linha 28 (C4) e `prompts/PROMPT-GESTAO2016-KNOWLEDGE.md` (as lições de método vão ao canônico) |

### 15.2 Evidência de saída da Fase 1

- `kit-lint --require-denylist` com as deny-lists dos dois casos: **0 erros, 0 avisos** (59 regras, 76 links, 27 docs com Scope, 12 skills/agentes).
- `claude plugin validate --strict` (Claude Code 2.1.304): o marketplace, o `plugin.json`, `skills/` e `agents/` **passaram**.
- **Instalação real** num projeto vazio, com `CLAUDE_CONFIG_DIR` isolado no scratchpad (a configuração do Valdo não foi tocada): `engine-kit@engine-kit` 0.7.0 habilitado, 10 skills + 2 agentes, **~843 tokens fixos por sessão**.
- Scripts do runtime só em ASCII; os JSON são válidos.

### 15.3 Arquivos fora do kit (de propósito)

- `prompts/prompt_engine_kit_unificacao-denylist.txt` (deny-list do caso Setes, anexo desta frente).
- `C:\RAG\case-denylists\softworks.txt` (deny-list do caso Softworks). A casa provisória vai para o Vault na Fase 4b, porque o Vault é só leitura para esta frente (A-EK3).

### 15.4 Resíduo conhecido (entra na Onda 1)

- Os exemplos do git-security ainda seguem um layout multi-repo (placeholders api / sync / legacy / docs / learning) e têm seções de gitignore de uma stack de legado.
- O `INSTALLATION.md` ainda cobre só a trilha legado (há uma nota no topo).
- Falta um `.gitattributes` (`eol=lf` para hooks shell); o commit mostrou avisos de CRLF.
- O `feedback-analyst` ainda lê marcadores prefixados, e não claims (Onda 3).
- `skills-genericas/` daqui ainda não aponta para o kit (Fase 4a).

### 15.5 Conhecimento negativo da execução

- **Remoto no GitHub**: não foi criado. Exige o "vai" (A-EK4), e o `gh` não está instalado.
- **Deny-list mais larga que a lista do diff**: pega o vazamento por PALAVRA. Descrições como "ERP, ~2,4 mil arquivos" passam, e por isso a revisão humana do vazamento continua necessária.
- **Custo fixo de tokens**: medido em ~843 tokens por sessão com 10 skills. É o número a vigiar nos níveis de adoção (§5.3): 22 skills, sem níveis, custariam o dobro em todo projeto.

## 17. Onda 1 — tools portadas (2026-10-21, kit `267883b`)

Pedido do Valdo: "comece a Onda 1 portando para o runtime do kit as tools do Vault previstas para ela". Cinco agentes em paralelo, cada um numa pasta; a integração, a revisão e o commit ficaram com o condutor.

| Grupo | Origem (W) | Técnicas | Testes (dados sintéticos) |
|---|---|---|---|
| `runtime/registry/` (3 scripts + `vcs.py`) + templates `DECISIONS`, `REGISTRY_PROJECTS` | `decisions_index`, `projects_check`, `ledger_gen` | T22, T87, T86, T04 | 39/39 em git e svn. Contra a base real (só leitura), mesmo resultado do original: 253 decisões, 1.320 linhas de ledger, 30 projetos |
| `runtime/guards/` + `hooks/hooks.json` + `guards.example.json` | `encoding-guard`, `revert-guard`, fiação dos hooks, lista "ask" | T54, T55, T29 | Casos (a)–(g) em git e svn. Sem `.engine-kit/guards.json`, sai em silêncio |
| `runtime/adapters/` + `mcp.model.template.json` | geradores de stub, merge e smoke test de MCP, `setup-*` | T01, T56, T91 | Stubs idempotentes, `--check`, stub feito à mão preservado; merge com segredo local, backup e dry-run |
| `runtime/graph/` + template de grafos ampliado | `merge_tree`, `rebuild-merged`, `nightly-rebuild`, `install-graphify` | T07, T90 | Árvore incremental (contagens de relink exatas), dry-run, `-CheckRegistry` com 7 tipos de deriva, carimbo, `-Commit` em git e svn só nas pastas de grafos |
| `runtime/ladder/` + skill `abstraction-ladder` + agente `ecosystem-curator` | `abstraction-ladder-docs`, `ecosystem-map-curator` | T63–T66 | Modo A (36 folhas), modo B (hash da fonte intacto), árvore e catálogo iguais aos do original, mais 17 nós |

**Evidência da integração**:
- O `kit-lint` dá 0/0: 161 links, 36 docs, 14 skills e agentes.
- O `claude plugin validate --strict` passa no marketplace, no manifesto, em `skills/` e em `agents/`.
- Numa instalação isolada, o plugin carrega 11 skills, 3 agentes e 2 hooks, com ~1.106 tokens fixos.
- O hook rodou exatamente como o harness o chama: projeto sem config, 0,26 s em silêncio; edição com a guarda ligada, achado no contexto em 2,6 s; commit, só aviso.
- Também nesta integração: o `kit_lint` passou a varrer `.js`/`.ts`/`.html`/`.css`, e o `.gitattributes` fixou LF.

**Limites conhecidos**:
- Os hooks precisam de `sh` (Git Bash, no Windows) e de PowerShell; no macOS e no Linux, de `pwsh`, sem teste.
- Com a guarda ligada, cada evento custa de 2 a 4 s, por causa do arranque do PowerShell.
- Os nomes de ferramenta `ToolSearch`/`PowerShell` nos stubs do Claude e os ids do Copilot não foram verificados na documentação.
- Não foi testado em Python 3.8 (só a gramática foi conferida).
- O frescor do grafo compara só datas.
- O svn recebe os alvos do commit pela linha de comando.

**Ficaram no caso**: layouts, raízes e nomes de projeto; servidores e agentes do caso; a cadeia de índice de memória dentro do job noturno; a fonte vendorizada da ferramenta de grafo; os tipos de documento de ticket do caso.

## 18. Fechamento da Onda 1 (2026-10-21, kit `5c91565`)

Pedido do Valdo: "Feche a Onda 1: trate as 14 técnicas pendentes dela (…), seguindo as Rec. de Q-EK10 e Q-EK11." Cinco agentes em paralelo, cada um com arquivos próprios; o condutor ficou com as decisões, a EK#12, o T53 e a integração.

| Técnicas | Onde ficaram no kit | Verificação |
|---|---|---|
| T01, T02, T03, T08, T25, T95 | skill `kb-setup`; `docs/KNOWLEDGE-BASE-STRUCTURE.md` reescrito; `AGENTS.template.md` ampliado; `AREA_KNOWLEDGE.template.md`; `scope-census` com colocação após front matter, classes de exclusão, retomada e checagem dos alterados | Lint 0 nos arquivos, links resolvidos |
| T22, T23, T24 | `decision-rounds` (ids e registros, premissas e palavra de liberação, regras e portão), `RULE.template.md`; `decisions_index.py` reconhece `D-XY2` ≡ `XY#2` | 15/15 testes novos do alias e 39/39 da suíte anterior (git e svn) |
| T85 | skill `review-pack` + templates de brief e de contexto do implementador | Lint 0 |
| T57, T72 | agente `env-setup`; `AGENT.template.md`; bloco de governança idêntico byte a byte em todos os agentes | Lint 0 |
| T74 | `runtime/install-journal/` (módulo PowerShell) | 65 ok, 0 falhas, 1 ignorado; corrigiu um bug de backup somente leitura |
| T53 | `SENSITIVE_DATA_REPORT.template.md` ("nunca o valor"), ligado às referências do git-security | Lint 0 |
| EK#11 / EK#12 | merge de MCP documentado; `rebuild-graphs.ps1` commita o registro carimbado | Em git: limpo → entra no commit; com edição humana → fica de fora, não é carimbado e a edição é preservada; arquivos alheios nunca entram |

**Integração**:
- O `DECISIONS.template.md` passou a citar `KEY#N` também no código.
- Os passos 1–4 do Dia 1 do `INSTALLATION.md` agora seguem o `kb-setup`.
- O `env-setup` aponta para o diário de instalação.
- Registro atualizado: 38 técnicas no kit, 9 parciais, 49 planejadas.
- `kit-lint` 0/0 (431 links, 48 docs, 17 skills e agentes) e `plugin validate --strict` ok.
- Na instalação isolada: 13 skills, 4 agentes, 2 hooks, ~1.826 tokens fixos.

**Não testado**:
- o caminho svn do registro carimbado na EK#12;
- no diário de instalação: tarefas agendadas, registro do Windows, variáveis de ambiente em escopo User/Machine e links simbólicos (falta privilégio nesta máquina).

**Abertos**:
- O `env-setup` e o template de agente trazem uma linha `tools:` que os agentes antigos não têm.
- As regras 2–4 do `feedback-analyst` repetem o bloco de governança.
- Um nome de área sem par no catálogo ainda não tem regra em nenhum dos casos.

## 19. Onda 2, parte 1, e salvamento da sessão (2026-10-21, kit `b9b9960` + branch `wip/wave2-remaining` `f86c8fe`)

Pedido do Valdo: "Comece a Onda 2 (ciclo de mudança: M4 + M5 + T69, T70, T73), guiada pelo registro de cobertura." Sete agentes em paralelo. Antes que todos terminassem, o Valdo pediu: "salve tudo com o que foi feito até agora … vamos iniciar outra seção". Os 4 grupos completos foram para a `main`; os 3 interrompidos, para um branch WIP, porque o parcial não passava no lint.

| Grupo | Técnicas | Estado | Onde |
|---|---|---|---|
| A | T12, T26, T30, T31, T32 | completo, registrado | `skills/front-protocol` + `FRONT_PROMPT`, `RESUME_BLOCK` |
| B | T27, T28, T29, T34, T36, T81, T82 | completo, registrado | `skills/change-gate` (3 modos) + `PLAN`, `SPEC`, `WORKLOG` |
| C1 | T37, T38, T44 (desenho), T76, T77 | completo, registrado | `skills/test-gate` + `TEST_EVIDENCE` |
| D | T33, T39, T40 | completo, registrado | `skills/delivery-gates`, `skills/fences`, `skills/disposable-proof` + `CUTOVER_RUNBOOK` |
| C2 | T75 (+ a ferramenta do T38) | interrompido no módulo de baseline | `wip/wave2-remaining`: `runtime/testing/` (12 arquivos; `decide.py` pronto) |
| E | T41, T42, T43, T80 | interrompido antes dos docs | `wip/wave2-remaining`: `skills/result-review/` (parcial), `runtime/browser/` (runner + exemplo; faltava rodar as checagens) |
| F | T69, T93, T70, T73, T79 | interrompido depois do runner | `wip/wave2-remaining`: `runtime/build/` (runner 37/37, 8 resumos válidos), `agents/docs-writer.md`; faltam `build-analyst`, `mold-factory` e `backport` |

**Evidência (main)**:
- `kit-lint` 0/0: 649 links, 73 docs, 23 skills e agentes.
- Cobertura: 58 técnicas no kit, 8 parciais, 30 planejadas.
- `plugin validate --strict` ok.
- Instalação isolada: 19 skills, 4 agentes, ~2.297 tokens fixos.

**Abertos dos agentes**:
- As faixas de nota do gate socrático (0,85 / 0,75 / 0,70) foram calibração do agente.
- O commit de checkpoint × a palavra de liberação (candidato a decisão EK).
- A leitura da EK#6 no `test-gate`.
- A redação literal das frases de gate.
- Três regras do `front-protocol` ainda não têm ferramenta: orçamento de 60 KB, stage só dos hunks da frente, pontas das worktrees × hashes registrados (candidato a `front_check.py`).
- O aviso de que uma remoção recursiva pode seguir uma junção no Windows precisa de verificação.
- As menções entre as skills da Onda 2 estão em texto puro e devem virar links.
