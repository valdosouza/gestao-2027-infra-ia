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

- a deny-list do caso Setes (desde 2026-10-28 fora do repo, que é público: `C:\RAG\case-denylists\setes.txt`).
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

## 20. Fechamento da Onda 2 (2026-10-21, kit `55a271e`)

Pedido do Valdo: "Retomar `prompts/prompt_engine_kit_unificacao.md` pelo §13: no kit `C:\RAG\engine-kit-canonical`, completar a Onda 2 a partir do branch `wip/wave2-remaining` (grupos C2, E e F), registrar no `docs/techniques.csv`, deixar o `kit_lint` verde e fazer merge na `main`."

O commit WIP (`f86c8fe`) saía da Onda 1 (`5c91565`) e só adicionava arquivos. Por isso foi reaplicado sobre a `main` (`b9b9960`) num branch de trabalho. Três agentes em paralelo, cada um com seus arquivos; o condutor ficou com o registro, os READMEs, o CHANGELOG, os links entre skills e a integração.

| Grupo | Técnicas | O que entrou | Verificação |
|---|---|---|---|
| C2 | T75 (+ a ferramenta de T38 e T76) | `runtime/testing/`: README com o contrato, `testing.example.json`, `baseline.py` reescrito pelo `baseline-diff.md`, partes da suíte sob um lock, porta `precommit` só de aviso, correções no vigia (a suíte roda antes do claim; ocupado ou ausente = tentar de novo) | 141 testes ok, git e svn; todos os comandos da CLI rodados à mão nos fakes, em git e em svn |
| E | T41, T42, T43, T80 | skill nova `browser-verification` (+ formato da spec, os três motores, template de relatório); `result-review` revisada; `runtime/browser/README.md`; 2 defeitos do runner corrigidos | `node --check`, dry-run, specs quebradas, guardas de argumento, execuções headless reais |
| F | T69, T93, T70, T73, T79 | agente novo `build-analyst`; skills novas `mold-factory` e `backport`; links de exemplo do `docs-writer` corrigidos; `runtime/build/tests/` | 45/45 contra um compilador falso; 8 resumos válidos contra o schema |

**Integração do condutor**:
- Registro: 68 técnicas no kit, 8 parciais, 20 planejadas (71% feito, 79% iniciado). Nenhuma linha da Onda 2 sobrou.
- Links no lugar das menções em texto puro entre as skills da Onda 2 (passo 3 do roteiro anterior).
- `change-gate` entrega na ordem: build, testes, browser, gates de entrega, revisão e fechamento.
- Correção objetiva no `baseline-diff.md`: o texto dizia que, sem baseline, a porta bloqueante recusa. Isso contrariava o próprio §3 e a evidência do caso. Agora: "sem baseline, toda falha conta como nova".
- O `build-analyst` e o `backport` ficaram com `**Maturity**: candidate`, pelo precedente do kit para técnicas de tier candidato.

**Evidência**:
- `kit-lint` 0/0: 912 links, 93 docs, 29 skills e agentes.
- `plugin validate --strict` ok em `.`, `skills` e `agents`.
- Instalação isolada: 23 skills, 6 agentes, 2 hooks, ~2.975 tokens fixos (antes ~2.297).

**Não provado**:
- O runner de browser foi rodado com o patchright, um fork compatível com o Playwright que já estava no disco; o Playwright não está instalado aqui. Ficaram sem execução real: o Playwright em si, Firefox, WebKit, a captura do `console.error` da página e um login humano de verdade.
- A Onda 1 já registrava como não testado o caminho svn do registro carimbado (EK#12).

**Abertos** (as questões estão no §13):
- Os agentes de E e F sugeriram um agente `browser-tester`.
- A política para um aviso arriscado novo é mais estrita que a do caso de origem.
- A ligação da porta `precommit` aos hooks do plugin.
- O custo fixo do plugin subiu cerca de 30%.

## 21. Onda 3, "Reter" (2026-10-21, branch `wave3-retain` do kit, não commitada)

Pedido do Valdo: "Do this task here", no card "Engine-kit: Onda 3 (Reter, M6 + M8)". O brief do card pedia commit no kit só a pedido do dono e nenhum commit neste repo. Quatro agentes em paralelo, cada um com seus arquivos; o condutor ficou com o registro, os READMEs, o CHANGELOG, o alinhamento entre arquivos e o ponteiro no diário do caso zero.

| Grupo | Técnicas | O que entrou | Verificação |
|---|---|---|---|
| G | T45, T46, T78, T88, T92 | skill nova `close-and-retain` (+ `CLOSE` e `DELIVERABLE`); `retain-knowledge` reescrita; `runtime/close/`: oito checagens, só de aviso por padrão, git e svn. As grafias UNC e com barra normal são derivadas de uma só entrada, o que corrige o defeito do caso de origem | 40 testes ok (14 de grafias, 22 em git, 4 em svn) |
| H | T48, T49 (+ resíduo do T58) | skill nova `archive-card` + `CARD`; consolidação completa no `memory-engineering`; claims tipados no lugar dos marcadores; `feedback-analyst` sem repetir a governança; `memory_index.py` com supersessão e `--claim-type` | base de rascunho com 7 logs e 8 cards; mesmas contagens da versão anterior; 1 bug corrigido (comentário YAML virava a regra) |
| I | T51, T61, T62, T89 | `runtime/migration/` (migração por manifesto e portão de aposentadoria), `docs/MIGRATION.md`, `docs/AUTHORING.md`, check 8 `sections` do lint, `JOURNAL.md` com 37 linhas iniciais | 36 testes ok; o check 8 pegou 5 violações plantadas numa cópia |
| J | T59, T96 | `evaluate-harness` (desenho, nunca executada); `weekly-report` + `runtime/weekly/` | 18 testes ok; 3 mutações pegas |

**Integração do condutor**:
- Registro: 81 técnicas no kit, 3 parciais, 12 planejadas (84% feito, 88% iniciado); nenhuma linha da Onda 3 sobrou.
- O bloco de governança de todos os agentes e do template termina a regra de retenção com o script de fechamento. O check 8 confere que ele é idêntico em todos.
- `change-gate`, `test-gate`, `kb-setup`, `scope-census` e `INSTALLATION` passaram a apontar o fechamento.
- O formato de card e os claims tipados foram alinhados em `kb-setup`, `AGENTS`, `SUBJECT_INDEX`, `KNOWLEDGE-BASE-STRUCTURE` e no README do runtime (premissa A-EK6).
- "O diário do produto" virou link para o `JOURNAL.md`.
- O `rascunho_engine_modernizacao.md` §5 ganhou o ponteiro SUPERSEDED (X8).

**Evidência**:
- `kit-lint` 0/0: 1.217 links, 111 docs, 33 skills e agentes, check 8 ok.
- Testes: `testing` 141, `close` 40, `migration` 36, `weekly` 18, `build` 45/45.
- `plugin validate --strict` ok em `.`, `skills` e `agents`.
- Instalação isolada: 27 skills, 6 agentes, 2 hooks, ~3.283 tokens fixos.

**Não provado**:
- A decisão por item do portão de aposentadoria e a comparação por hash nunca rodaram num caso.
- O `close.py` não foi rodado em Python 3.8, PowerShell 7, Linux nem macOS.
- O `evaluate-harness` é desenho. A pasta da origem (`D:\harness-kit`) não existe nesta máquina, então o laço saiu só do diário.

**Abertos**:
- Q-EK15 a Q-EK17 (§13).
- O cliente svn com `global-ignores` cegando as checagens (Q-EK16).
- A cópia do `memory_index.py` que vive no caso dois não recebeu a melhoria; é decisão daquele caso.

## 22. Onda 4, "Entradas" (2026-10-21/22, branch `wave3-retain` do kit, não commitada)

Pedido do Valdo, literal: "pode continaur sem commit nem merge, faremos apenas no final". Seis agentes em paralelo, com um brief comum (nomes e caminhos combinados, para os links cruzados baterem) e arquivos disjuntos. O condutor ficou com o registro, os READMEs, o CHANGELOG, o `JOURNAL`, os ajustes nas skills dos outros e a mudança da ferramenta de arquivo para o `runtime/`.

| Grupo | Técnicas | O que entrou | Verificação |
|---|---|---|---|
| K1 | T09, T10, T11, T94 | `assess-legacy-repo` reescrita (doc legado = hipótese, registro validado uma por turno, releitura determinística); `legacy-analyst` no template; `HYPOTHESES`; `runtime/data-probe/`: guarda pura de escrita e DDL, sessão provada somente leitura, limite de linhas, sem credencial guardada, driver plugável | 55 testes; nenhum banco real rodado |
| K2 | T13, T14 | `official-source-archive` (hash + cópia em texto, CONFIRMA / AJUSTA / DERRUBA / NÃO OFICIAL; o formato do documento é fonte de erro) com o manifesto em `runtime/sources/`; `migration-direction` | 7 testes; rodado em modo leitura no arquivo do caso zero, achou uma cópia em texto com fim de linha convertido pelo git |
| L | T17, T18, T19, T20 | `frame-greenfield` (rascunho como está, Rodada 0, requisitos compartilhados com o `review-pack`, prompt fechado); `conceptual-guardian` reescrito; `REQUIREMENTS`, `OCCUPIED_WORDS` | lint e validate |
| M1 | T67, T68, T83, T84 | `settings-mapper`, `pipeline-builder` (escritor único de `PIPELINES/`, satisfaz o Pipeline Gate); `SETTINGS_REGISTRY`, `PIPELINE` | lint e validate |
| M2 | T35, T71 | `version-diff` (lê documentos, para quando falta um); `folder-importer` (portão de backup, a primeira pasta supervisionada); `VERSION_DIFF` | lint e validate |
| N | - | `profiles/` (legacy, greenfield, solo, team), `docs/ADOPTION-LEVELS.md` (87 peças em 3 níveis), `INSTALLATION.md` com duas trilhas, `AGENTS.md` do kit; protótipos medidos de plugin por nível | instalações isoladas: tudo ~3.782 tokens, nível 1 ~1.904, níveis 1+2 ~3.244 |

**Integração do condutor**:
- Registro: **96 de 96 técnicas no kit**.
- O `review-pack` passou a apontar para o pipeline de requisitos compartilhado; a página antiga dele ficou SUPERSEDED, como ponteiro.
- A ferramenta de manifesto saiu da pasta da skill para `runtime/sources/`, pela regra do `AUTHORING.md`.
- `projects_check.py` passou a tratar `SETTINGS/` como pasta de projeto.
- O `docs-writer` entrega os fluxos ao `pipeline-builder`.
- A linha "Adoption" entrou no `AGENTS.template` e no Dia 1 do `kb-setup`.
- Duas linhas novas no `JOURNAL` (a guarda que lê literais e comentários juntos; os níveis que o formato do plugin aplica).

**Evidência**:
- `kit-lint` 0/0: 1.927 links, 138 docs, 40 skills e agentes; descrições ~3.689 tokens.
- Suítes: testing 141, close 40, migration 36, weekly 18, data-probe 55, sources 7, build 45/45.
- `plugin validate --strict` ok em `.`, `skills` e `agents`.
- Instalação isolada: 30 skills, 10 agentes, 2 hooks, ~3.782 tokens fixos.

**Não provado**:
- A sonda de dados contra um banco real.
- O Python 3.8 em si (só o 3.14 existe nesta máquina).
- Qualquer agente da Onda 4 num caso real depois da destilação.
- O detector de texto riscado: ficou descrito, não entregue.

**Abertos**: Q-EK18 a Q-EK20 (§13); os protótipos de plugin por nível ficaram só no scratchpad.

## 23. Fase 3 - decisões aplicadas e teste 3a, etapa 1 (2026-10-22, branch `wave3-retain`, sem commit)

Pedido do Valdo, literal: "Siga as recomendações de Q-EK12 a Q-EK20: registre como decisões (D-EK13 em diante, EK#13 em diante no DECISIONS.md do kit) e depois comece a Fase 3 (testes de saída), ainda sem commit nem merge."

**Decisões**: EK#13 a EK#21 no `DECISIONS.md` do kit e o espelho no §14. Quatro delas pediam código, aplicado em paralelo:

| Decisão | O que entrou | Verificação |
|---|---|---|
| EK#14 | `commitDoor` em `.engine-kit/guards.json`; `hook.ps1` chama `suite.py precommit --warn-only` (flag nova); dois defeitos antigos do `launch.sh` corrigidos | 14 testes novos em `runtime/guards/tests/` (git e svn) |
| EK#17 | `--svn-client-ignored` nos argumentos comuns do `vcs.py` (todas as ferramentas do registro); `svnClientIgnored` no close, repassado às ferramentas | registry 6, close 46 |
| EK#18 | o check 8 do lint conta as descrições fora do padrão (17) | lint |
| EK#21 | `sync-skills.ps1 -Level 1/2/3` e `-Borrow`; `runtime/levels.py` gera o `levels.json` a partir do `ADOPTION-LEVELS.md`; check 9 do lint | 19 testes em `runtime/tests-levels/` |

**Teste 3a, etapa 1**:
- O projeto vazio fica em `C:\RAG\exit-tests\3a-greenfield`. O rascunho do dono é uma fixture fictícia (biblioteca comunitária) escrita pelo condutor.
- Um agente seguiu só o kit, nos níveis 1 e 2, perfil solo, do Dia 1 até a Rodada 0, e parou ali.
- Resultado: 10 de 13 passos, 16 questões (WS e BIB), 6 fatos pedidos ao dono (R1-R6) e 30 achados no `EXIT-TEST-LOG.md`.
- Limites do teste: rodou num subagente com instruções, não numa instalação limpa do plugin; o kit estava sendo editado durante a execução (achado X1).

**Correções a partir dos achados** (3 agentes, arquivos disjuntos):
- F1, instalação e vaso:
  - o Dia 1 foi reordenado; o dono só entra no Dia 1 por documento assinado, senão é a primeira questão da Rodada 0;
  - nenhuma área antes da Rodada 0 na trilha nova;
  - o rascunho é copiado byte a byte, com hash;
  - a checagem de vazamento virou checagem do autor do kit; checagem de skills homônimas;
  - outbox `JOURNAL-for-kit.md`; regra de língua no nível 1; fatia `borrowed:`;
  - chaves solo no template de projetos; `git-*` sem `git add .`.
- F2, rodadas e enquadramento: "Round 0" como nome único; bloco de questões do workspace; pedidos de fato `R-n`; marca "Reserved - never assumed"; próximos ids no formato `XY: 18`.
- F3, ferramentas: classe "frozen source" (censo, close e validador); close ciente do nível (`level` 1-3); a checagem de citações pula a linha de próximos ids. Close 57 testes, registry 12; reproduzido contra o projeto do 3a (os 2 FIX impossíveis sumiram).
- O `JOURNAL.md` ganhou 6 linhas com origem "exit test 3a".

**Evidência**: lint 0/0 (2.007 links, checks 1 a 9). Suítes verdes, 404 testes: testing 141, close 57, migration 36, weekly 18, data-probe 55, sources 7, registry 12, guards 14, levels 19, build 45. `plugin validate --strict` ok em `.`, `skills` e `agents`. Uma falha do `runtime/testing` era limite de caminho do Windows com o TMP longo, não regressão; ficou documentada no README.

**Abertos**:
- A Rodada 0 do 3a (o Valdo responde como dono da biblioteca fictícia).
- Q-EK21 (o legado do 3b), Q-EK22 (X2) e Q-EK23 (fixar a versão).
- Notas sem questão:
  - o `review-pack` mantém a numeração própria das rodadas com o solicitante;
  - o `-Track` do `sync-skills.ps1` espera evidência de disparo;
  - os agentes não se dividem por nível em outras ferramentas (links por arquivo exigem elevação no Windows);
  - a área de runtime do perfil solo é relativa à raiz da base.

## 24. Fase 3 - etapas 3a-2 e 3b-1 (2026-10-27, tags `exit-test-3a-stage2` e `exit-test-stage3`)

Pedido do Valdo, literal: "Siga as recomendações da Rodada 0 do teste 3a (Q-WS1, Q-WS2 e Q-BIB1 a Q-BIB14) e de Q-EK21 a Q-EK23. Para os fatos R1 a R6, invente valores plausíveis e marque-os como fixture do teste. Depois continue o 3a até a entrega e comece o 3b."

**Decisões**: EK#22 a EK#24 no kit; o espelho está no §14.
- EK#23 aplicada: guardião (passo das palavras ocupadas), `FRONT_PROMPT` e `OCCUPIED_WORDS` no nível 1 da trilha nova.
- EK#24 aplicada: commit local `f7078de` com a tag `exit-test-3a-stage2`, sem merge e sem push.

**Fixtures do condutor**: a resposta literal do dono e os fatos R1-R6 inventados, marcados FIXTURE (`3a-greenfield/resposta-do-dono-rodada-0.md`); uma amostra fictícia da planilha, 40 linhas com duplicados (`fixtures/socios-amostra.csv`); o pedido do dono do 3b (`3b-legacy/pedido-do-dono.md`).

**3b, legado**: `spring-petclinic/spring-framework-petclinic`, commit `cf39292`, clone raso, 138 arquivos e 1,6 MB, nunca compilado.

| Etapa | Até onde | Achados | Versão |
|---|---|---|---|
| 3a-2 | Rodada 0 registrada, requisitos escritos, Rodada 1 preparada (12 questões e 2 fatos) | Y1-Y17; 24 dos 29 achados da etapa 1 confirmados na prática | `f7078de` do início ao fim |
| 3b-1 | Dia 1, censo, dimensionamento, piloto proposto, análise (25 hipóteses: 10 confirmadas, 5 rejeitadas, 10 abertas), Rodada 0 (10 questões e 8 fatos) | F1-F22; o pior dano achado é de configuração: scripts que apagam ou semeiam o banco a cada partida | `f7078de` do início ao fim |

**Correções** (3 agentes, arquivos disjuntos):
- G1, instalação, níveis e trilhas: gatilho do nível 1 para o 2 sem a palavra de liberação; escolhas do Dia 1 sem dono viram premissas; checagem de homônimos com agentes e fallback; raiz da base nos dois layouts; pedido do legado copiado com hash; Rodada 0 do legado no prompt; piloto proposto em L2; `-Track`.
- G2, ciclo de mudança na trilha nova: caminho greenfield no `change-gate`; vermelho de unidade nova no `test-gate`; marcas de nível nas skills de retenção; checagem cruzada das Rec. de uma rodada; anexo `-rounds.md`.
- G3, legado e ferramentas: status das hipóteses; evidência de terceiros como `inference`; colocação da análise; contagem só de texto; classe "documento legado ligado"; o ledger com os arquivos da raiz da área (defeito); o original do dono reconhecido pelo close; a citação pula só o item de próximos ids.
- Condutor:
  - integração e o item 4 da governança marcado nível 2 em todos os agentes;
  - o vazamento de uma linguagem ligada a um caso nos exemplos das skills git e no comando de dimensionamento, achado na revisão e trocado por exemplos neutros;
  - 18 lições no `JOURNAL`.

**Evidência**:
- lint 0/0 (checks 1-9; 15 descrições fora do padrão, eram 17);
- 428 testes verdes: testing 141, close 59, migration 36, weekly 18, data-probe 55, sources 7, registry 21, guards 14, levels 32, build 45;
- `plugin validate --strict` ok com o CLI 2.1.308, que mudou de pasta numa atualização do app;
- commit `dc9800a` com a tag `exit-test-stage3`.

**Abertos**: a Rodada 1 do 3a e a Rodada 0 do 3b, que o Valdo responde como dono fictício; Q-EK24 a Q-EK27.

## 25. Fase 3 - decisões EK#25 a EK#28 e etapas 3a-3 e 3b-2 (2026-10-27, tags `exit-test-stage4` e `exit-test-stage5`)

Pedido do Valdo, literal, como chegou (cortado depois da última palavra): "Siga as recomendações da Rodada 1 do 3a (Q-WS3, Q-WS4, Q-BIB15 a Q-BIB24), da Rodada 0 do 3b (Q-WS1 a Q-WS4, Q-LEGADO1 a Q-LEGADO6) e de Q-EK24 a Q-EK27. Para os fatos pedidos (R-WS1, R-BIB7, R-LEGADO1 a R-LEGADO8), invente valores plausíveis marcados como fixture. A palavra de liberação é "liberado"

**Decisões**: EK#25 a EK#28 no kit; o espelho está no §14. Foram aplicadas por dois agentes:
- A, níveis e instalação: guardião e esqueleto no nível 1 nas duas trilhas; `.runtime/` ignorada para o perfil solo; a parte de instalação da EK#26.
- B, método: a rodada que fecha leva o plano, com o "vai" em linha própria; o stub no vermelho.
- O condutor ajustou o aviso do `rebuild-graphs.ps1` (só avisa quando a pasta não é ignorada pelo VCS), o padrão de exclusão do validador e um teste de níveis que tinha virado skip.
- Commit `7cc659f`, tag `exit-test-stage4`.

**Fixtures**: `resposta-do-dono-rodada-1.md` (3a: R-WS1, R-BIB7) e `resposta-do-dono-rodada-0.md` (3b: R-LEGADO1-8), marcadas FIXTURE.

| Etapa | Até onde | Achados | Versão |
|---|---|---|---|
| 3a-3 | Rodada 1 registrada (BIB#15-24, WS#10-12), nível 2, área EMPRESTIMO, plano W1, vermelho provado (26 testes e 26 falhas), Rodada 2 aberta | Z1-Z11; Y1-Y13, Y16 e Y17 confirmados na prática | `7cc659f` do início ao fim |
| 3b-2 | Rodada 0 registrada (LEGADO#1-6, WS#5-8), hipóteses relidas (nenhuma resolvida só pela palavra do dono; 3 novas), retenção (log com claims), nível 2, settings e mapa da partida, plano LEGADO-W1 | S2-F1-F14; F1-F22 confirmados | `7cc659f` do início ao fim |

**Correções** (3 agentes):
- H1, instalação e adoção: nada de comportamento de produção antes do "vai"; "Moving to a newer kit version"; rascunho congelado; língua do outbox.
- H2, skills de método: dizer × definir a palavra de liberação; consequências combinadas e lista de entrada em produção; fato do mundo × hipótese do sistema; mudança preparada (`PATCH/`); stub sentinela; o `settings-mapper` com padrões propostos.
- H3, ferramentas e legado: Scope depois do front matter; base sem o primeiro commit vira uma nota (`vcs.has_commit`); duas lições do legado assentadas.
- Condutor:
  - `AGENTS.md` do kit: a coluna "Landed in" e a lista "Adopters: re-check";
  - auditoria das 22 linhas do `JOURNAL`, com 4 lições que faltavam assentadas;
  - Scope depois do front matter também no `validate-registry.ps1`;
  - commit `431d11a`, tag `exit-test-stage5`.

**Evidência**: lint 0/0 (checks 1-9; 14 descrições fora do padrão); 437 testes verdes (testing 141, close 66, migration 36, weekly 18, data-probe 55, sources 7, registry 23, guards 14, levels 32, build 45); `plugin validate --strict` ok.

**Abertos**:
- Os "vai" e as rodadas dos dois testes (§13).
- Q-EK28 a Q-EK30.

## 26. Fase 3 - decisões EK#29 a EK#31 e etapas 3a-4 e 3b-3 (2026-10-28, tags `exit-test-stage6` e `exit-test-stage7`)

Pedido do Valdo, literal: "Siga as Rec. da Rodada 2 do 3a, do 3b (Q-LEGADO7, Q-WS5, padrões) e de Q-EK28 a Q-EK30; fatos R-BIB8 e R-LEGADO9-11 como fixture. Vai no plano W1 do 3a. Vai no vermelho W1.1 do 3a. Vai no plano LEGADO-W1 do 3b."

**Decisões**: EK#29 a EK#31 no kit, todas na Rec.; o espelho está no §14. O condutor aplicou as três (instalação, `kb-setup`, `scope-census`, script de fechamento; `change-gate`, `modes`, `decision-rounds`, modelos `PLAN`, `FRONT_PROMPT` e `AGENTS`). Commit `9d3d6f0`, tag `exit-test-stage6`.

**Fixtures**: `3a-greenfield/resposta-do-dono-rodada-2.md` (R-BIB8) e `3b-legacy/resposta-do-dono-rodada-1.md` (R-LEGADO9-11), marcadas FIXTURE. Dois fatos foram escolhidos para testar o kit: a leitura da produção mostra Tomcat 11 (o dono tinha dito 10), e a senha do banco é trocada à mão depois de cada WAR.

| Etapa | Até onde | Achados | Versão |
|---|---|---|---|
| 3a-4 | Rodada 2 registrada (BIB#25-27, WS#13-14); prompt fechado; nível 2; os dois "vai" lidos como um só (EK#30); código movido para `3a-greenfield-app` (WS#13 = Q-WS5 (a), ainda permitido pela EK#29); onda 1 em passada única, 138 testes (133 + 5 falhas esperadas); G1 0,86 e G2 0,84 depois de duas correções; parou no percurso da dona, na Rodada 3 e na palavra | W1-W13; Z1-Z10 confirmados | `9d3d6f0` do início ao fim |
| 3b-3 | Rodada 1 lida pelos ids (LEGADO#7, WS#9-10); H-026 confirmada e H-027 rejeitada pela leitura; 4 hipóteses novas (H-032: o filtro do build); "vai" válido; plano mantido; patches e roteiro em `PATCH/`, `apply --check` numa cópia; `CLOSE.md` rascunho; parou no ensaio e no dono | S3-F1-S3-F14; 12 dos 14 da etapa 2 confirmados (S2-F11 e S2-F14 abertos) | `9d3d6f0` do início ao fim |

O condutor conferiu o que pôde: o `source/` continua em `cf39292` e limpo, o kit continuou limpo, e a suíte do 3a foi rodada de novo (138, OK, 5 falhas esperadas).

**Correções** (3 agentes, cada um com seus arquivos):
- J1, rodadas, gate e fechamento: leitura pelos ids e pelo caso; o "vai" é uma frase própria que nomeia o artefato; leitura feita por uma pessoa = resultado de sonda; ambiente que o código restringe = hipótese; mudança do kit entre pergunta e resposta; rodada levantada pelos portões leva a revisão do plano com o seu "vai"; fatos que chegam com o "vai"; rascunhos enquanto um portão espera; prosa não é mapa.
- J2, testes e mudança preparada: `Browser cases:` no plano; sonda FINDING afirma a Rec. e falha na asserção; sentinela de classe e de aplicação web; logs em `.txt`; ler o que o build faz antes dos patches; `* -text` e nenhuma credencial no contexto; `APPLY.md` com o percurso; um aviso por arquivo de evidência no `close.py` (testes de fechamento 66 -> 67).
- J3, instalação, legado e guardião: varredura com exceções (S2-F11); quem recebe uma configuração sem linha no registro (S2-F14); uma afirmação por linha de hipótese; a sonda `.log`; mudança de versão do kit antes da decisão = suposição; o prompt fechado fica em `prompts/` até o fim da frente.
- Condutor: menções pendentes em 9 arquivos; 25 linhas dos outboxes no `JOURNAL` com o lugar e a versão; a regra "puxar é escrever no `JOURNAL`" (`retain-knowledge`, regra 4 do `JOURNAL`); a entrada do `CHANGELOG` com "Adopters: re-check"; commit `dd0b9ee`, tag `exit-test-stage7`.

**Evidência**: lint 0/0 (checks 1-9); 438 testes verdes (testing 141, close 67, migration 36, weekly 18, data-probe 55, sources 7, registry 23, guards 14, levels 32, build 45) e mais 65 do install-journal; `plugin validate --strict` ok em `.`, `skills` e `agents`.

**Abertos**:
- 3a: o percurso da dona, a Rodada 3 (Q-BIB28-32) e a palavra para os três commits.
- 3b: o ensaio por uma pessoa, Q-LEGADO8, Q-WS6, R-LEGADO12 e a palavra para o primeiro commit da base.
- Duas lições ficaram `open` no `JOURNAL` (uma só evidência): listar, para cada ação que grava, a repetição e a origem; ler as chaves de um esquema contra as regras de histórico.

## 27. Fase 3 - etapas curtas 3a-5 e 3b-4 (2026-10-28, tags `exit-test-stage7` e `exit-test-stage8`)

Pergunta do condutor: "Como sigo com o percurso da dona e o ensaio do legado?". Resposta do Valdo, literal: "Ficam devidos". O botão oferecido também seguia as Rec. da Rodada 3 do 3a e de Q-LEGADO8 e Q-WS6 do 3b, mas a mensagem que chegou trouxe só as duas palavras: nada além delas foi lido, e as rodadas seguem abertas. Gravada em `3a-greenfield/resposta-do-dono-2026-10-28-percurso.md` e `3b-legacy/resposta-do-dono-2026-10-28-ensaio.md`.

| Etapa | O que fez | Achados | Versão |
|---|---|---|---|
| 3a-5 | Registrou a resposta (o percurso fica devido; a Rodada 3 e a palavra seguem pedidas); mudou para o kit novo como suposição A-WS1; ajustou `AGENTS.md`, `CLOSE.md` (`[DRAFT - pending the owner's walk]`), o `WORKLOG`, a evidência e o plano (revisão 1 escrita sobre a Rodada 3, com o seu "vai" pedido); delta 3 só de testes (as sondas FINDING passaram a afirmar a opção inteira; G2 falhou 0,55 e passou 0,76); 139 testes; escreveu o resultado do teste | V1-V10; W1-W13 confirmados | `dd0b9ee` do início ao fim |
| 3b-4 | Registrou a resposta (o ensaio fica devido, sem nome de quem roda); mudou para o kit novo como A-WS4; `PATCH/.gitattributes`, `APPLY.md` (logs `.txt`, o percurso depois dos portões), o roteiro, a evidência, `CLOSE.md`, o `WORKLOG`; hipóteses com uma afirmação por linha (F11 virou H-033); patches iguais, `apply --check` de novo numa cópia; escreveu o resultado do teste | S4-F1-S4-F9; S3-F1-S3-F14, S2-F11 e S2-F14 confirmados | `dd0b9ee` do início ao fim |

O condutor conferiu: kit e `source/` limpos; a suíte do 3a de novo (139, OK, 5 falhas esperadas).

**Correções** (2 agentes):
- K1, rodadas, instalação e modelos: uma rodada aberta e sem resposta é a "próxima rodada" de uma mudança de versão do kit; uma mudança sobre outra ainda não ratificada; mudanças antigas registradas como decisões; fatos relidos contra a tabela de respostas nova; um artefato aprovado guarda a forma até a próxima revisão; mensagem que só adia ("ficam devidos"); quem aplica a mudança preparada; um lugar só para a lista de liberação; marcas de rascunho e rótulos de sonda na lista de palavras em inglês.
- K2, portões, legado e registro: a sonda FINDING afirma a opção recomendada inteira, longe das bordas de tempo; delta só de testes passa pelos portões (G2 muta o código numa cópia); um teste da suíte prende as sondas onde não há `raises=`; `Browser cases:` num plano aprovado antes; linhas de hipótese antigas divididas no próximo turno; a varredura cobre as flexões; "decisions 17" deixa de ser lido como citação (registro 23 -> 24); duas descrições passaram a começar com "Use when" (12 restantes).
- Condutor: menções pendentes em 3 arquivos; 8 linhas no `JOURNAL`; a regra **Case files to reshape** no `AGENTS.md` do kit e no `CHANGELOG`; commit `c3401de`, tag `exit-test-stage8`.

**Evidência**: lint 0/0; 439 testes verdes (testing 141, close 67, migration 36, weekly 18, data-probe 55, sources 7, registry 24, guards 14, levels 32, build 45) e mais 65 do install-journal; `plugin validate --strict` ok em `.`, `skills` e `agents`.

**Abertos**: os devidos dos dois testes (§13); se a Fase 3 termina aqui ou segue com as rodadas abertas.

## 28. A casa do kit muda para `engine-kit/` deste repo (2026-10-28, D-EK32)

Pergunta do Valdo antes de seguir: "antes de continuar, estou em duvida sobre o que extamente estamos fazendo neste chat. era para ser apenas um merge de tecnicas usadas no vault e no C:\temp\gestao-2027-infra-ia\engine-kit atualizando tudo em C:\temp\gestao-2027-infra-ia\engine-kit". O condutor explicou que o merge estava feito no repositório separado da D-EK1 e que a Fase 3 vinha das D-EK8 e D-EK9. Decisão, literal: "tudo deve ficar em C:\temp\gestao-2027-infra-ia\engine-kit, se caso for substituindo o que tiver dentro dela, para que o kit seja atualizado com o melhor dos dois mundos".

**Feito:**
1. EK#32 no `DECISIONS.md` do kit (revê a EK#1), mais o README (casa canônica), a `INSTALLATION.md` (de onde pegar o kit; o marketplace é adicionado pela pasta) e a `docs/ARCHITECTURE.md`; entrada no `CHANGELOG`. Commit `7fdf06a` no repositório antigo.
2. Conferido antes de apagar: os 20 arquivos de `engine-kit/` (v0.4) estavam todos versionados aqui, sem nada só local, e cada um tem destino no `docs/history/consolidation-0.7.0-manifest.csv`.
3. `engine-kit/` substituída pela exportação (`git archive`) do `7fdf06a`: 270 arquivos (20 modificados e 250 novos para o git daqui).
4. `.gitignore` deste repo: 4 exceções com o caminho exato, porque `*auth*`, `*secret*` e `**/build/` escondiam 10 arquivos do kit (`docs/AUTHORING.md`, `runtime/build/`, `runtime/ladder/extend_handauthored.py`, o guia `SECRETS_PROTECTION_SETUP.md`). Depois disso, nenhum arquivo do kit fica ignorado.
5. No lugar novo: lint 0/0 com as duas deny-lists; `plugin validate --strict` ok em `.`, `skills` e `agents`; 439 testes verdes (testing 141, close 67, migration 36, weekly 18, data-probe 55, sources 7, registry 24, guards 14, levels 32, build 45) e mais 65 do install-journal; os testes rodaram sem gerar arquivos soltos na pasta.
6. Repositório antigo: README marcado SUPERSEDED, commit `7c54e51`. Os testes de saída (`C:\RAG\exit-tests\`) citam o caminho antigo e as tags `exit-test-*`: é histórico e fica como está.

**Nada foi commitado neste repo nem enviado.** O commit de `engine-kit/`, do `.gitignore` e dos documentos da frente espera o "vai" do Valdo.

## 29. Higiene do kit e envio para a `main` do GitHub (2026-10-28)

Valdo, literal: "o commit pode ser direto na main do git hub" e, depois de saber que o repo é público e que a deny-list iria junto, "A ideia do kit eh ser generico, nao pode ter nada relacionado a Softworks ou a setes em si".

**Auditoria além das deny-lists** (o lint só conhece os nomes das listas): nenhum nome dos dois casos no kit; dois rastros tirados:
- `docs/history/consolidation-0.7.0-manifest.csv` tinha caminhos desta máquina e a estrutura de pastas de um dos casos: saiu do kit e ficou como história da frente em `prompts/engine-kit-consolidacao-0.7.0-manifest.csv`; `MIGRATION.md`, README, T61 e EK#32 deixaram de apontar para ele.
- Os apelidos `VAULT_ROOT`, `--vault` e `--vault-root` existiam só para o ambiente de um dos casos: saíram dos adaptadores, do índice de memória e das ferramentas de registro (`KB_ROOT`, `--kb-root` e `--root` continuam).
- Ficam, por serem anônimas e serem a evidência da maturidade de cada técnica: as descrições "case zero" e "case two" (o tipo de caso, nunca o nome).

**Deny-list**: estava no commit local de 2026-10-21, nunca enviado; 6 dos 33 termos não apareciam em nenhum outro arquivo. O commit foi refeito sem ela (`4a44fa3` -> `1cef895`), e o arquivo foi para `C:\RAG\case-denylists\setes.txt`, ao lado de `softworks.txt`.

**Verificação**: lint 0/0 com as duas listas; `plugin validate --strict` ok; 439 testes e mais 65 do install-journal verdes; varredura de segredos sem achados (só um token de exemplo `ghp_xxx...` num guia e uma classe `Token`).

**Envio**: commit na `main`, junção com os 3 commits que estavam só no GitHub (salvamentos de 18, 20 e 21/10 de outras frentes; único arquivo dos dois lados: `INDICE_CENTRAL.md`, reconciliado - as linhas do GitHub ficam com 10.32-10.36 e as desta frente passam a 10.37-10.46), push para `origin/main`.

**Pendente do Valdo**: C1 - as 3 chaves de API do Google de `RELATORIO_DADOS_SENSIVEIS.md` seguem públicas nesse repo até serem giradas ou restringidas no console.
