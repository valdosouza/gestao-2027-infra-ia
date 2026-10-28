# Engine Kit — Decisions

**Scope**: method
**Format**: the `decision-rounds` skill — numbered, permanent, never renumbered; a revision
references the revising decision and nothing is deleted. Namespace **`EK`** (cite as `EK#N`).
This register is the home of every decision about the kit itself.

---

## Round 0 of the 0.7 consolidation (2026-10-21)

The round was organized with evidence, closed options and one recommendation per
question. The owner's answer, literally: "Siga as recomendações da Rodada 0 (Q-EK1 a
Q-EK9) e comece a Fase 1." ("Follow the recommendations of Round 0 and start Phase 1.")
Every decision below is therefore the recommended option.

| # | Date | Decision | Why |
|---|---|---|---|
| 1 | 2026-10-21 | **Canonical home**: a private, neutral git repository owned by the method's author. Every case consumes it as a plugin or a pinned clone; copies inside case workspaces are never edited | Three copies drifted for two months, two of them outside version control; no employer hosts the method, which keeps the "method is the author's × code is the employer's" boundary clean |
| 2 | 2026-10-21 | **Language** is English. The grep-able token is `**Scope**: method \| case \| mixed` (a case may write its own key instead of `case`). Linters and validators accept the aliases `Escopo`, `metodo` and `misto`. Inside the kit the value is always `method` | The plugin ecosystem and the larger case already work in English; one token keeps every census grep-able; aliases keep older case material valid |
| 3 | 2026-10-21 | **The runtime lives inside the kit** (`runtime/`, `templates/`, later `hooks/`): one version, one installation. The three layers stay separate as folders | The pair of repositories without a common version is exactly what drifted |
| 4 | 2026-10-21 | **Decision ids are namespace + number** (`KEY#N`). A namespace is a project or a front/epic, so a front-prefixed id such as `D-XY2` is the same as `XY#2`. One home register per decision; the index of all registers is generated; parallel sessions get their own namespace or a reserved range; never renumber | Keeps every id that already exists in both cases valid and resolves the collisions of parallel sessions |
| 5 | 2026-10-21 | **Derived artifacts** (code graphs, memory databases) follow the profile: `solo` keeps them outside the knowledge base, rebuildable; `team` versions them with one designated builder | Each case made the right choice for its size; the kit offers both instead of imposing one |
| 6 | 2026-10-21 | **Hooks and gates ship warn-only.** A project turns a gate blocking by its own numbered decision | A gate that blocked from the first day of a rollout had to be relaxed in a real case |
| 7 | 2026-10-21 | **Techniques proven in only one case enter labelled**: `proven` (2+ cases), `operating` (1 case, core by choice), `candidate` (1 case, optional), `design` (never run). See [docs/MATURITY.md](docs/MATURITY.md) | The rule of three cases without losing what one case already learned; no silent upgrades |
| 8 | 2026-10-21 | **Versioning**: 0.7.0 for the consolidation; 1.0.0 only after the exit tests (one greenfield project and one unrelated legacy project complete a full cycle with the kit alone) | 1.0 promises portability, and portability is only proven outside the cases that produced the kit |
| 9 | 2026-10-21 | **The legacy-track proof project** is a small open-source legacy repository unrelated to any case; the third real case confirms it later | Proves portability now, without contamination and without waiting |

## Direct instructions after Round 0

| # | Date | Decision | Why |
|---|---|---|---|
| 11 | 2026-10-21 | **MCP merge: only secrets stay local.** `runtime/adapters/merge-mcp-config.js` keeps a local value only when it is a secret (the model carries `<CONFIGURE>` there); for every other value the canonical model wins over the local activation file | The model is the source of record; the local file holds only what belongs to the machine. Owner: "seguindo as Rec. de Q-EK10 e Q-EK11" (recommendation (a)) |
| 12 | 2026-10-21 | **Team-mode graph builds commit the stamped registry.** `runtime/graph/rebuild-graphs.ps1 -Commit -StampRegistry` includes in the automated commit each graph registry it stamped, but only when that registry had no local modifications before the stamp; a registry that was already modified is left out and logged | The registry's Build Status is part of the build's product, and a stale stamp misleads every freshness check; widening the commit only for a file that was clean keeps human edits out of the automated commit. Same owner answer (recommendation (b)) |
| 10 | 2026-10-21 | **The agents that BUILD the knowledge ecosystem enter the plan** as their own module (M9). Wave 1: ecosystem-map curator with the abstraction ladder, the abstraction-tree graph, the generated agents/skills catalog, and the standard governance block for every agent. Wave 2: single docs writer, build analyst, mold factory. Wave 4: settings mapper, pipeline builder, cross-version pipeline diff, local working-folder importer. Owner, literally: "Sim, inclua os agentes de construção do ecossistema no mapa (T64+) e no plano das ondas." | The first inventory listed rules (the pipeline gate, the ladder) but not the agents that produce the material those rules depend on; a kit without its builders is paper again |

## Questions of waves 2 to 4 (2026-10-22)

Raised by the wave agents, organized with evidence, closed options and one recommendation
each (Q-EK12 to Q-EK20 in the front's prompt). The owner's answer, literally: "Siga as
recomendações de Q-EK12 a Q-EK20: registre como decisões (D-EK13 em diante, EK#13 em
diante no DECISIONS.md do kit) e depois comece a Fase 3 (testes de saída), ainda sem commit
nem merge." Every decision below is the recommended option; EK#16, EK#19 and EK#20 were
already applied as assumptions and are now ratified.

| # | Date | Decision | Why |
|---|---|---|---|
| 13 | 2026-10-22 | **A new risky compiler warning sends the change back** to implementation, unless the owner accepts it as a numbered decision ([`build-analyst`](agents/build-analyst.md), [`change-gate`](skills/change-gate/SKILL.md) hand-off 1). Pre-existing risky warnings are listed, never blocking | The same rule the test gate applies to a new failure; the source case only listed findings, and a listed finding nobody owns comes back as a defect |
| 14 | 2026-10-22 | **The commit door of `runtime/testing` is wired into the plugin hooks** with the same opt-in discovery as the guards (no project configuration = silent no-op) and warn-only (EK#6) | One entry point for every door keeps the rollout uniform; a door a case must install by hand is a door most cases never install |
| 15 | 2026-10-22 | **No browser-tester agent** wraps `browser-verification` until a second case asks for one | The skill already carries the procedure; an agent adds always-on cost and a second place to keep in step |
| 16 | 2026-10-22 | **Card ids are `K-YYYYMMDD-HHMM`**, minted at write time ([`archive-card`](skills/archive-card/SKILL.md)) | About 210 cards in case two used it; it does not collide across parallel branches, and a card keeps its id when its rule moves to another project |
| 17 | 2026-10-22 | **svn status may ignore the client's `global-ignores`, opt-in and off by default** ([`runtime/registry/vcs.py`](runtime/registry/vcs.py), used by the close script) | In case two a client setting hid every markdown file from the Scope and unversioned checks; a repository-wide default change would surprise other users |
| 18 | 2026-10-22 | **Descriptions that do not start with "Use when" are rewritten when their file is next touched**, not in a sweep; `kit_lint.py` prints how many are left and the rule becomes a lint error when the count reaches zero ([docs/AUTHORING.md](docs/AUTHORING.md)) | A new description changes when a piece triggers; rewriting it with the file keeps every change reviewable |
| 19 | 2026-10-22 | **The shared-state (transversal) analysis lives in `SUBJECT/<AREA>/PIPELINES/TRANSVERSAL.md`** ([`pipeline-builder`](agents/pipeline-builder.md)) | Keeps the area's fixed folders, and the `project:` check covers it |
| 20 | 2026-10-22 | **The data probe runs without a configured read-only proof, warns and marks the result NOT PROVEN**; a case requires the proof with `"require_proof": true` ([`runtime/data-probe`](runtime/data-probe/README.md)) | EK#6 (warn first, block by decision); a configured proof that fails always stops the run |
| 21 | 2026-10-22 | **Adoption levels are applied by one plugin plus the case's adoption line** in its `AGENTS.md`, and by a per-level list in `runtime/sync-skills.ps1` for other tools. Two plugins (essential and complete) stay ready and become a decision when an exit test shows a higher-level piece firing at level 1 ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md)) | Measured: the plugin format limits skills per level but not agents or hooks, and a manifest change that `validate --strict` cannot check would carry the install on loader behaviour |

## Questions of the exit tests (2026-10-27)

Raised by exit test 3a (Q-EK21 to Q-EK23 in the front's prompt). The owner's answer,
literally: "Siga as recomendações da Rodada 0 do teste 3a (Q-WS1, Q-WS2 e Q-BIB1 a
Q-BIB14) e de Q-EK21 a Q-EK23. Para os fatos R1 a R6, invente valores plausíveis e
marque-os como fixture do teste. Depois continue o 3a até a entrega e comece o 3b."
Every decision below is the recommended option.

| # | Date | Decision | Why |
|---|---|---|---|
| 22 | 2026-10-27 | **The legacy exit test (3b) runs on `spring-petclinic/spring-framework-petclinic`** (Java, JSP and Spring MVC, about 2.3 MB, Apache-2.0, a veterinary clinic): cloned shallow into the exit-test folder, read only, never built, no dependency downloaded | Small, classic layered legacy style, a real schema, and a domain unrelated to any case (EK#9) |
| 23 | 2026-10-27 | **The greenfield entry's pieces sit in level 1**: `conceptual-guardian` (its occupied-words step while framing), `FRONT_PROMPT` and `OCCUPIED_WORDS` are situational level-1 pieces of the greenfield track; the guardian's full practice (before every domain object) stays a level-2 practice ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md)) | Exit test 3a: the level-1 entry skill called three level-2 pieces, so every greenfield project had to record a borrowing decision on day 1 |
| 24 | 2026-10-27 | **Each exit-test stage runs on a pinned kit version**: a local commit on the working branch and a local tag (first: `exit-test-3a-stage2`) before the stage; no merge into `main` and no push until the owner calls the end of the front | Exit test 3a: the kit changed while the test ran, so no version could be named as the one it proved |

## Questions of exit-test stages 3a-2 and 3b-1 (2026-10-27)

Raised by the two stages (Q-EK24 to Q-EK27 in the front's prompt). The owner's answer,
literally, as it arrived (the message was cut after the last word):
"Siga as recomendações da Rodada 1 do 3a (Q-WS3, Q-WS4, Q-BIB15 a Q-BIB24), da Rodada 0 do 3b (Q-WS1 a Q-WS4, Q-LEGADO1 a Q-LEGADO6) e de Q-EK24 a Q-EK27. Para os fatos pedidos (R-WS1, R-BIB7, R-LEGADO1 a R-LEGADO8), invente valores plausíveis marcados como fixture. A palavra de liberação é "liberado"
Every decision below is the recommended option.

| # | Date | Decision | Why |
|---|---|---|---|
| 25 | 2026-10-27 | **Revises EK#23. The whole `conceptual-guardian`, `FRONT_PROMPT` and `OCCUPIED_WORDS` sit in level 1 on both tracks**; Round 0 of the legacy track uses the `FRONT_PROMPT` skeleton, as on greenfield ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md)) | Exit test 3b: the legacy concept step (L4.1) calls the guardian too; exit test 3a: framing needs full guardian opinions, not only the occupied-words step |
| 26 | 2026-10-27 | **The round that closes the prompt carries, in the same batch, the move to level 2 and the first wave's plan**, written on the recommended answers and marked "rewritten if any answer differs"; the code gate's go on that plan is asked there, explicitly ([`decision-rounds`](skills/decision-rounds/SKILL.md), [`frame-greenfield`](skills/frame-greenfield/SKILL.md), [`change-gate`](skills/change-gate/SKILL.md)) | Exit test 3a: a solo owner met at least three stops before any code; the owner answers rounds in batch |
| 27 | 2026-10-27 | **Refines EK#5 for `solo`: the runtime area may be a folder inside the knowledge-base folder that version control ignores** (for example `.runtime/`); it stays outside the versioned base ([profiles/solo.md](profiles/solo.md)) | Exit tests 3a and 3b: a sibling folder is impossible when only the base folder may be written |
| 28 | 2026-10-27 | **In test-first mode for a new unit, the stub is part of the red artifact**: shown at the code gate with the failing test; the unit is written once, after the go ([`test-gate`](skills/test-gate/SKILL.md), [`change-gate`](skills/change-gate/SKILL.md) step 4) | A red needs something to fail against; the single pass still holds because the stub carries no behaviour |

## Questions of exit-test stages 3a-3 and 3b-2 (2026-10-28)

Raised by the two stages (Q-EK28 to Q-EK30 in the front's prompt). The owner's answer,
literally (the same message answered both exit tests and gave their gos):
"Siga as Rec. da Rodada 2 do 3a, do 3b (Q-LEGADO7, Q-WS5, padrões) e de Q-EK28 a Q-EK30; fatos R-BIB8 e R-LEGADO9-11 como fixture. Vai no plano W1 do 3a. Vai no vermelho W1.1 do 3a. Vai no plano LEGADO-W1 do 3b."
Every decision below is the recommended option.

| # | Date | Decision | Why |
|---|---|---|---|
| 29 | 2026-10-28 | **Refines the layout rule: a code tree may sit in a folder inside the knowledge-base folder when it is its own repository and the base's version control ignores it** (`/app/` in the base's `.gitignore`, or `svn:ignore` on the base root). The projects registry names it in its `Code tree` cell; the checks that walk the base folder exclude it (the close script's `checks.scope.exclude` and `checks.retired.normative.exclude`, the validator's `-ExcludePattern`); the census never marks it. Outside the base stays the default ([INSTALLATION.md](INSTALLATION.md) step 1, [`kb-setup`](skills/kb-setup/SKILL.md)) | Exit test 3a: the kit forbade what EK#27 allows the runtime area for the same reason (only the base folder may be written); an ignored nested repository never lands in the base's repository, and the folder walks are the only checks that would see it |
| 30 | 2026-10-28 | **One go per wave: a plan may carry test-first steps.** Each step's red - its failing tests and, for a new unit, its stub (EK#28) - is written and proven before the gate, listed in the plan's Test plan with its `TEST_PLAN.md` and red log, and shown with the plan; one go covers the plan and the reds it lists, in that state. A step whose red is not ready at the gate is gated on its own later ([`change-gate`](skills/change-gate/SKILL.md) step 4, [modes](skills/change-gate/references/modes.md) section 4) | Exit test 3a: a wave that mixed a plan and pure rules asked a solo owner for two artifacts and two gos |
| 31 | 2026-10-28 | **Ratifies assumption A-EK9: the settings mapper scans on patterns marked `proposed`** while their confirmation rides in the closing round (EK#26); a pattern the answer changes means a rescan of what it covers ([agents/settings-mapper.md](agents/settings-mapper.md)) | Exit test 3b: "confirm, then scan" added a stop for the owner before the closing round could carry the plan |

## The kit's home (2026-10-28)

The owner's answer, literally (the workspace path elided - a case's path is case content):
"tudo deve ficar em <workspace>\engine-kit, se caso for substituindo o que tiver dentro dela, para que o kit seja atualizado com o melhor dos dois mundos"

| # | Date | Decision | Why |
|---|---|---|---|
| 32 | 2026-10-28 | **Revises EK#1. The kit's home is the `engine-kit/` folder of the owner's workspace repository**, its earlier contents replaced by this version (every file of the older copy has a destination in the consolidation manifest, kept by the kit's author, outside the kit: it names the source machines and cases). The separate repository of EK#1 becomes history: its commits and its `exit-test-*` tags stay there, marked SUPERSEDED, and nothing is edited there again. Unchanged: no case content in the kit (the leak check against every case's deny-list before each commit), copies inside other case workspaces are never edited, and the kit is consumed as a plugin from its folder | The owner wants one place, inside the workspace the method grew in, updated with the best of both cases. Accepted consequences: the kit is versioned and published with that repository (its remote's visibility applies to the kit), and the clean "no employer hosts the method" boundary of EK#1 is now the owner's call, not the kit's |
