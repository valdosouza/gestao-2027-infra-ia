# Adoption levels

**Scope**: method
**Status**: design - the three levels are the kit's target design and have not yet run in
a case as levels; every piece below keeps its own maturity label ([MATURITY.md](MATURITY.md)).

The kit holds 30 skills, 10 agents, 14 runtime groups and 28 templates. A new
project that receives all of them on its first day makes the owner the bottleneck: every
piece triggers, asks and waits for a decision the project is not ready to take. The levels
say which pieces a project turns on, when, and what makes it move up.

Levels are one of three independent choices, made before anything is installed
([INSTALLATION.md](../INSTALLATION.md)):

| Choice | Options | Says |
|---|---|---|
| Track | [legacy](../profiles/legacy.md), [greenfield](../profiles/greenfield.md) | how the project enters: Day 1, the entry step, the success criterion |
| Team profile | [solo](../profiles/solo.md), [team](../profiles/team.md) | where derived artifacts live and who builds them ([EK#5](../DECISIONS.md)) |
| Level | 1 Essential, 2 Governed, 3 Scale (this page) | which pieces are on, and the trigger to move up |

## The three levels

| Level | When | What it turns on | Move up when |
|---|---|---|---|
| **1 Essential** | Day 1, any project | the vessel (`AGENTS.md` + thin adapters), the Scope line, decision rounds in the front prompt's skeleton, the conceptual guardian, the retention chain, git security, save and resume, prepare-only - plus the entry step of the project's track | the first front opens |
| **2 Governed** | from the first front | the living front prompt, the code gate, the test gate, the delivery gates, the single closing, episodic logs with claims | any one level-3 trigger is met |
| **3 Scale** | the base holds more than ~50 documents, the legacy more than ~500 files, or more than one person works in the base | code graph and retrieval, the memory index, consolidation, cards, fences, the registry validator, the baseline diff, the hooks, the feedback loop | - |

Levels add up: level 2 keeps everything of level 1, level 3 everything of both.

## How a piece is placed

1. **Each piece sits in exactly one level: the earliest level whose practice needs it.** A
   skill that serves two levels sits in the lower one, and the table says which of its parts
   start later (for example `front-protocol`: its save-and-resume section is a level-1
   practice; its living-prompt sections start with the first front).
2. **Core or situational.** A core piece is on as soon as its level is. A situational piece
   waits for its own situation (a change a user can see, a seed, a family of similar pieces),
   named in the tables. A `candidate` or `design` piece is never core: it is opt-in or a
   proposal ([MATURITY.md](MATURITY.md)), so it is situational at its level.
3. **A one-line practice needs no skill.** Prepare-only at level 1 is the governance line of
   the case's `AGENTS.md` ([template](../templates/AGENTS.template.md)) plus the harness ask
   list ([HARNESS-PERMISSIONS.md](../runtime/guards/HARNESS-PERMISSIONS.md), a settings
   change, not a hook); its full procedure comes with `change-gate` at level 2.
4. **Borrowing is not moving up.** A situational piece of a higher level may be used alone,
   by a numbered decision of the case (`KEY#N`: which piece, why now). The level stays; the
   decision is the record. Before an owner of the decisions is named, a borrowing is an
   assumption `A-<KEY>n` that Round 0 ratifies ([INSTALLATION.md](../INSTALLATION.md),
   step 4).
5. **Track entry pieces sit in level 1, by track: only the entry pieces of the project's
   track are on.** The Track column says which track a piece serves: `legacy` or
   `greenfield` alone - the entry pieces, and a few situational ones - only that track;
   `<track> (both from level N)` that track below level N and both from N; `both`,
   `both (<note>)` and `<track>, mostly` both tracks. The column is data:
   `runtime/levels.json` carries it (`tracks`) and `sync-skills.ps1 -Track` applies it.

## Level 1 - Essential

| Practice | Pieces |
|---|---|
| The vessel: `AGENTS.md` + thin adapters | [`kb-setup`](../skills/kb-setup/SKILL.md), [`runtime/adapters/`](../runtime/adapters/README.md), the registers |
| The Scope line | [`scope-census`](../skills/scope-census/SKILL.md) |
| Decision rounds | [`decision-rounds`](../skills/decision-rounds/SKILL.md), [`runtime/registry/`](../runtime/registry/README.md) |
| The front prompt's skeleton | [`FRONT_PROMPT`](../templates/FRONT_PROMPT.template.md) - Round 0 of either track is written in `prompts/prompt_<name>.md` on this skeleton ([EK#25](../DECISIONS.md)); the same file goes on as the living front prompt at level 2 |
| The conceptual guardian | [`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md) + [`OCCUPIED_WORDS`](../templates/OCCUPIED_WORDS.template.md) - before every domain object and every new name, on both tracks: the framing of a greenfield draft, the concept step of a legacy pilot ([EK#25](../DECISIONS.md)) |
| The retention chain | [`retain-knowledge`](../skills/retain-knowledge/SKILL.md) - at this level its chain stops at the index, the registers, the root rules, the Scope line and the SUPERSEDED marks; the episodic log with claims comes at level 2, the card decision and the consolidation flag at level 3 |
| Git security | the git pack |
| Save and resume | [`front-protocol`](../skills/front-protocol/SKILL.md) section 3 + [`RESUME_BLOCK`](../templates/RESUME_BLOCK.template.md) |
| Prepare-only | the `AGENTS.md` governance line + the harness ask list (rule 3 above) |

| Piece | Kind | Core / situational - trigger | Track |
|---|---|---|---|
| [`kb-setup`](../skills/kb-setup/SKILL.md) | skill | core | both |
| [`scope-census`](../skills/scope-census/SKILL.md) | skill | core | both (legacy: the census of the existing collection on Day 1) |
| [`decision-rounds`](../skills/decision-rounds/SKILL.md) | skill | core | both |
| [`retain-knowledge`](../skills/retain-knowledge/SKILL.md) | skill | core | both |
| [`front-protocol`](../skills/front-protocol/SKILL.md) | skill | core - section 3 now; sections 1, 2, 4 and 5 from the first front | both |
| [`git-security`](../skills/git-security/SKILL.md), [`git-setup`](../skills/git-setup/SKILL.md), [`git-commit-push`](../skills/git-commit-push/SKILL.md), [`git-push`](../skills/git-push/SKILL.md) | skills | core | both |
| [`assess-legacy-repo`](../skills/assess-legacy-repo/SKILL.md) | skill | core (track entry) | legacy |
| [`legacy-analyst`](../agents/legacy-analyst.md) | agent | core (track entry) | legacy |
| [`frame-greenfield`](../skills/frame-greenfield/SKILL.md) | skill | core (track entry) | greenfield |
| [`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md) | skill | core - the whole skill, before every domain object and every new name ([EK#25](../DECISIONS.md), revising EK#23) | both |
| [`AGENTS`](../templates/AGENTS.template.md), [`AGENT`](../templates/AGENT.template.md), [`DECISIONS`](../templates/DECISIONS.template.md), [`REGISTRY_PROJECTS`](../templates/REGISTRY_PROJECTS.template.md), [`REGISTRY_SUBJECTS`](../templates/REGISTRY_SUBJECTS.template.md), [`SUBJECT_INDEX`](../templates/SUBJECT_INDEX.template.md), [`RESUME_BLOCK`](../templates/RESUME_BLOCK.template.md), [`DELIVERABLE`](../templates/DELIVERABLE.template.md) | templates | core | both |
| [`SENSITIVE_DATA_REPORT`](../templates/SENSITIVE_DATA_REPORT.template.md) | template | situational - a scan, or the hygiene line of a legacy assessment, found a secret or personal data | both |
| [`mcp.model.template.json`](../templates/mcp.model.template.json) | template | situational - the case uses MCP servers | both |
| [`HYPOTHESES`](../templates/HYPOTHESES.template.md) | template | core (track entry) | legacy |
| [`REQUIREMENTS`](../templates/REQUIREMENTS.template.md) | template | core (track entry) | greenfield |
| [`FRONT_PROMPT`](../templates/FRONT_PROMPT.template.md), [`OCCUPIED_WORDS`](../templates/OCCUPIED_WORDS.template.md) | templates | core - the skeleton of Round 0's prompt and the occupied words the guardian checks ([EK#25](../DECISIONS.md)) | both |
| [`runtime/registry/`](../runtime/registry/README.md) | runtime | core - decision registers, project inventory, ledger | both |
| [`runtime/adapters/`](../runtime/adapters/README.md) | runtime | core - agent stubs; MCP activation when the case uses MCP | both |
| [`runtime/sync-skills.ps1`](../runtime/sync-skills.ps1) | runtime | situational - a tool that is not a plugin, or a project / case skill layer | both |
| [`runtime/close/`](../runtime/close/README.md) | runtime | core - the close script that ends the retention chain; at this level `"level": 1` in `.engine-kit/close.json` (or `--level 1`) leaves out the test gate, the memory index and the registry validator | both |
| [`runtime/data-probe/`](../runtime/data-probe/README.md) | runtime | situational (track entry) - a legacy database to read, read-only | legacy |

## Level 2 - Governed

| Practice | Pieces |
|---|---|
| The living front prompt | `front-protocol` sections 1, 2, 4, 5 (the skill is on since level 1), on the prompt Round 0 started from the [`FRONT_PROMPT`](../templates/FRONT_PROMPT.template.md) skeleton (level 1, [EK#25](../DECISIONS.md)). The conceptual guardian keeps running as at level 1 |
| The code gate | [`change-gate`](../skills/change-gate/SKILL.md) + [`PLAN`](../templates/PLAN.template.md), [`SPEC`](../templates/SPEC.template.md), [`WORKLOG`](../templates/WORKLOG.template.md) |
| The test gate | [`test-gate`](../skills/test-gate/SKILL.md) + [`TEST_EVIDENCE`](../templates/TEST_EVIDENCE.template.md), with the project's own suite command (the kit's suite runner and baseline diff are level 3) |
| The delivery gates | [`delivery-gates`](../skills/delivery-gates/SKILL.md) |
| The single closing | [`close-and-retain`](../skills/close-and-retain/SKILL.md) + [`CLOSE`](../templates/CLOSE.template.md); the close script at `"level": 2` |
| Episodic logs with claims | [`memory-engineering`](../skills/memory-engineering/SKILL.md) sections 1 to 4 (its consolidation cycle, section 5, is level 3) |

| Piece | Kind | Core / situational - trigger | Track |
|---|---|---|---|
| [`change-gate`](../skills/change-gate/SKILL.md), [`test-gate`](../skills/test-gate/SKILL.md), [`delivery-gates`](../skills/delivery-gates/SKILL.md), [`close-and-retain`](../skills/close-and-retain/SKILL.md), [`memory-engineering`](../skills/memory-engineering/SKILL.md) | skills | core | both |
| [`review-pack`](../skills/review-pack/SKILL.md) | skill | situational - a change request reviewed with its requester before work starts | both |
| [`browser-verification`](../skills/browser-verification/SKILL.md) | skill | situational - a change a user can see | both |
| [`disposable-proof`](../skills/disposable-proof/SKILL.md) | skill | situational - a seed, a migration or a one-way act; a cutover window | both |
| [`mold-factory`](../skills/mold-factory/SKILL.md) | skill | situational - a family of similar pieces to build or rebuild | both |
| [`result-review`](../skills/result-review/SKILL.md) | skill | situational - another person's change to review, a revision that broke something, a process to prove on a real item | both |
| [`official-source-archive`](../skills/official-source-archive/SKILL.md) | skill | situational - an official norm governs a rule being assessed or decided | both |
| [`migration-direction`](../skills/migration-direction/SKILL.md) | skill | situational - a new system replaces a legacy that keeps running for a while | legacy |
| [`docs-writer`](../agents/docs-writer.md) | agent | situational - code-derived documents: unit references, data tables, tester handoffs | both |
| [`build-analyst`](../agents/build-analyst.md) | agent | situational - a compiled stack: prove it builds, audit the warnings | both |
| [`settings-mapper`](../agents/settings-mapper.md) | agent | situational - behaviour steered by configuration; before the first pipeline map | legacy, mostly |
| [`pipeline-builder`](../agents/pipeline-builder.md) | agent | situational - a fix on a flow nobody mapped (the pipeline gate of `change-gate`) | legacy, mostly |
| [`PLAN`](../templates/PLAN.template.md), [`SPEC`](../templates/SPEC.template.md), [`WORKLOG`](../templates/WORKLOG.template.md), [`TEST_EVIDENCE`](../templates/TEST_EVIDENCE.template.md), [`CLOSE`](../templates/CLOSE.template.md) | templates | core | both |
| [`CUTOVER_RUNBOOK`](../templates/CUTOVER_RUNBOOK.template.md) | template | situational - with `disposable-proof` | both |
| [`RULE`](../templates/RULE.template.md) | template | situational - a business rule that keeps being asked again (rule files with an authorised / denied history) | both |
| [`PIPELINE`](../templates/PIPELINE.template.md), [`SETTINGS_REGISTRY`](../templates/SETTINGS_REGISTRY.template.md) | templates | situational - with `pipeline-builder` / `settings-mapper` | legacy, mostly |
| [`runtime/browser/`](../runtime/browser/README.md) | runtime | situational - with `browser-verification` | both |
| [`runtime/build/`](../runtime/build/README.md) | runtime | situational - with `build-analyst` | both |
| [`runtime/sources/`](../runtime/sources/README.md) | runtime | situational - with `official-source-archive` | both |

## Level 3 - Scale

| Practice | Pieces |
|---|---|
| Code graph and retrieval | [`runtime/graph/`](../runtime/graph/README.md) + [`REGISTRY_GRAPHS`](../templates/REGISTRY_GRAPHS.template.md) |
| The memory index | [`memory_index.py`](../runtime/memory_index.py) (no-Python fallback: [`build-memory-index.ps1`](../runtime/build-memory-index.ps1)) |
| Consolidation | `memory-engineering` section 5 (the skill is on since level 2) |
| Cards | [`archive-card`](../skills/archive-card/SKILL.md) + [`CARD`](../templates/CARD.template.md) |
| Fences | [`fences`](../skills/fences/SKILL.md) |
| The registry validator | [`validate-registry.ps1`](../runtime/validate-registry.ps1) |
| The baseline diff | [`runtime/testing/`](../runtime/testing/README.md) (suite runs with evidence checks, the baseline-diff gate, the commit door and watcher) |
| The hooks | [`hooks/hooks.json`](../hooks/hooks.json) + [`runtime/guards/`](../runtime/guards/README.md) + [`guards.example.json`](../templates/guards.example.json) |
| The feedback loop | [`feedback-analyst`](../agents/feedback-analyst.md); [`evaluate-harness`](../skills/evaluate-harness/SKILL.md) - both `design`, proposals until a case runs them |

| Piece | Kind | Core / situational - trigger | Track |
|---|---|---|---|
| [`archive-card`](../skills/archive-card/SKILL.md) | skill | core | both |
| [`fences`](../skills/fences/SKILL.md) | skill | situational - an invariant that drifts silently (catalog rows the code depends on, a closed list of writers) | both |
| [`abstraction-ladder`](../skills/abstraction-ladder/SKILL.md) | skill | situational - the base or the ecosystem needs a visual entry point | both |
| [`backport`](../skills/backport/SKILL.md) | skill | situational - more than one maintained line | both |
| [`weekly-report`](../skills/weekly-report/SKILL.md) | skill | situational - a person reports the week to whoever plans the work | both (team) |
| [`evaluate-harness`](../skills/evaluate-harness/SKILL.md) | skill | situational - a change to a skill, agent, prompt or hook to promote by data (design) | both |
| [`feedback-analyst`](../agents/feedback-analyst.md) | agent | situational - the logs carry typed claims and the case tries the feedback loop (design: a proposal) | both |
| [`ecosystem-curator`](../agents/ecosystem-curator.md) | agent | situational - with `abstraction-ladder` | both |
| [`env-setup`](../agents/env-setup.md) | agent | situational - a person joins the case or changes machine | both (team) |
| [`version-diff`](../agents/version-diff.md) | agent | situational - several active versions of the same product | legacy, mostly |
| [`folder-importer`](../agents/folder-importer.md) | agent | situational - scattered local working folders to bring into the base | legacy, mostly |
| [`CARD`](../templates/CARD.template.md), [`guards.example.json`](../templates/guards.example.json) | templates | core | both |
| [`REGISTRY_GRAPHS`](../templates/REGISTRY_GRAPHS.template.md) | template | situational - with the code graph | both |
| [`VERSION_DIFF`](../templates/VERSION_DIFF.template.md) | template | situational - with `version-diff` | legacy, mostly |
| [`AREA_KNOWLEDGE`](../templates/AREA_KNOWLEDGE.template.md) | template | situational - one more developer to onboard on one area (the open-question onboarding of `kb-setup`) | both (team) |
| [`memory_index.py`](../runtime/memory_index.py), [`build-memory-index.ps1`](../runtime/build-memory-index.ps1) | runtime | core | both |
| [`validate-registry.ps1`](../runtime/validate-registry.ps1) | runtime | core | both |
| [`runtime/guards/`](../runtime/guards/README.md) + [`hooks/hooks.json`](../hooks/hooks.json) | runtime | core - opt-in per project, warn-only ([EK#6](../DECISIONS.md)) | both |
| [`runtime/testing/`](../runtime/testing/README.md) | runtime | core when the project has a test suite | both |
| [`runtime/graph/`](../runtime/graph/README.md) | runtime | situational - a code base over ~500 files, or one that direct reading cannot cover in a few sessions | both (legacy first) |
| [`runtime/ladder/`](../runtime/ladder/README.md) | runtime | situational - with `abstraction-ladder` / `ecosystem-curator` | both |
| [`runtime/install-journal/`](../runtime/install-journal/README.md) | runtime | situational - with `env-setup` | both (team) |
| [`runtime/weekly/`](../runtime/weekly/README.md) | runtime | situational - with `weekly-report` | both (team) |
| [`runtime/migration/`](../runtime/migration/README.md) | runtime | situational - an old store to move into the base ([MIGRATION.md](MIGRATION.md)) or an old runtime to retire | both |

**Not in a level**: [`kit_lint.py`](../runtime/kit_lint.py), [`coverage.py`](../runtime/coverage.py)
and [`levels.py`](../runtime/levels.py) guard the kit itself; they are run by whoever edits
the kit ([AGENTS.md](../AGENTS.md)), never adopted by a case. The docs are reading material at every level.

**Count**: 30 skills (12 / 12 / 6), 10 agents (1 / 4 / 5), 28 templates (14 / 9 / 5), 14
runtime groups (4 / 3 / 7) and 4 top-level case scripts (1 / 0 / 3) plus the hooks - each
placed once above.

**Read by a program**: the skills and agents linked in the first cell of each piece table
above, with the Track cell of their row (rule 5), are the source of record of
[`runtime/levels.json`](../runtime/levels.json), the list `sync-skills.ps1 -Level` and
`-Track` read. After placing, moving or removing a piece, or changing its track, run
`python runtime/levels.py --write`; `python runtime/levels.py --check` (run by the kit lint)
fails while the tables, the data file, the kit's `skills/` and `agents/` folders and the
Count line above disagree.

## Moving up

| From - to | Trigger | Measured by |
|---|---|---|
| 1 -> 2 | The first front opens: Round 0 closed into a closed prompt (greenfield), or the pilot unit's assessment written and its first change about to be planned (legacy) | greenfield: the prompt is closed - its State line says so ([`frame-greenfield`](../skills/frame-greenfield/SKILL.md) section 7); legacy: a recorded decision calls for a change on the pilot unit. Both are on record before any level-2 gate passes - the answer that closes the prompt records them first ([EK#26](../DECISIONS.md), below); the release word comes after those gates and never measures this trigger |
| 2 -> 3 | More than ~50 documents in the base | the census count, or the markdown files under the base |
| 2 -> 3 | A legacy of more than ~500 files | the sizing step of the legacy track ([INSTALLATION.md](../INSTALLATION.md)) |
| 2 -> 3 | More than one person works in the base | the people registry, or more than one author in the base's history over the last 90 days |

1. The retention chain or the census notices a trigger and says it in the task's final
   answer; the next decision round carries the question (closed options, one
   recommendation) - for 1 -> 2, the round that closes the prompt (below).
2. The owner's answer is recorded as `KEY#N` in the workspace register, with the trigger
   that was met.
3. The case's `AGENTS.md` adoption line changes (below), and the new level's core pieces are
   turned on - situational ones wait for their situation.

**1 -> 2 rides on the round that closes the prompt** ([EK#26](../DECISIONS.md)). The 1 -> 2
question is not left for a later round: on greenfield the round that closes the prompt (a
round after Round 0, because the plan rests on the requirements, which wait for Round 0's
answers); on legacy the round that settles the pilot's first change - carries in the same
batch the move to level 2 and the
first wave's plan. The plan is written on the recommended answers and marked "rewritten if
any answer differs"; the code gate's go on it is asked there, on a line of its own (an
approval, no `Q-` id), never implied by the other answers. One batch answer can then close the prompt, move the
level and give the go; when an answer differs from its recommendation, the plan is
rewritten and its go asked again. The procedure:
[`decision-rounds`](../skills/decision-rounds/SKILL.md) (the round) and
[`change-gate`](../skills/change-gate/SKILL.md) (the plan and its go).

A legacy over ~500 files meets a level-3 trigger at its sizing step, before the first front:
the code graph comes before any reading - borrow it (rule 4 of the placement) or move up. A
level never goes down by drift; turning a piece off is a decision too.

## How a case turns a level on today

1. **Record the choice.** In the workspace register: `<WORKSPACE-KEY>#N - adoption level 1;
   track legacy | greenfield; profile solo | team; next trigger: <...>`. Each piece
   borrowed from a higher level is a decision of its own (`KEY#N`: which piece, why now).
   Before an owner of the decisions is named, each of these is an assumption
   `A-<WORKSPACE-KEY>n` that Round 0 ratifies ([INSTALLATION.md](../INSTALLATION.md),
   step 4); the adoption line cites the assumption until then.
2. **Say it where every tool reads it.** One line near the top of the case's `AGENTS.md`:

   ```markdown
   **Adoption**: level <1|2|3> (<WORKSPACE-KEY>#N | A-<WORKSPACE-KEY>n) - track <legacy|greenfield> - profile <solo|team> - borrowed: <piece (KEY#N | A-KEYn), ... | none>.
   Use only the kit pieces of this level and below, plus the borrowed ones (the kit's
   docs/ADOPTION-LEVELS.md). When a request matches another piece of a higher level, name
   the piece and ask the owner: move up, borrow it (a decision), or do the work without it.
   ```

   The `borrowed:` slot is how a case says "level 1 with some level-2 pieces": the level
   stays, and each borrowed piece is named with the decision that borrowed it - never
   "level 1.5" or "level 1 plus level-2 pieces". A piece leaves the slot when the case moves
   up to its level, or by a decision that returns it.

3. **Install.** In Claude Code the kit is one plugin that installs every piece of every
   level (about 3,800 tokens of descriptions in every session); the line above is what
   keeps a higher-level piece from running unasked ([EK#21](../DECISIONS.md)). Other tools,
   and project or case skill layers: [`runtime/sync-skills.ps1`](../runtime/sync-skills.ps1)
   with `-Level` links only the kit skills of the case's level and below, and with `-Track`
   only those of the case's track (rule 5 of the placement), with the usual precedence
   (kit < project < case):

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File <kit>\runtime\sync-skills.ps1 -Source '<kit>\skills;<project>\skills;<case>\skills' -Target '<home>\.cursor\skills' -Level 1 -Track legacy -WhatIf
   ```

   Then the same command without `-WhatIf`. Moving up or down is the same command with the
   new level: the junctions of the skills above it are removed, pointers only (a real
   folder, or a link that points outside the sources, is never touched). Without `-Track`
   the entry pieces of both tracks are linked, with a warning. A borrowed piece (rule 4 of
   the placement), of a higher level or of the other track, is added with
   `-Borrow '<skill>'`, each one a `KEY#N` of the case. Selection is by name: a case skill
   that overrides a kit skill keeps that skill's level and track, and a project or case
   skill this page does not place is linked at every level.
   Agents are not split by level - `-AgentsSource` still links the whole folder (a link to
   one file needs elevation or Developer Mode on Windows) - so the adoption line governs
   them, as in the plugin.
4. **Runtime: only the level's tools.** The hooks stay silent until the project creates
   `.engine-kit/guards.json` - create it at level 3 only. Set `"level"` in
   `.engine-kit/close.json` (or pass `--level`): the close script leaves out the checks, the
   validator and the checklist items of a higher level - default 3, every check
   ([`runtime/close/`](../runtime/close/README.md)).
5. **Templates: only the level's.** A template is copied into the base when its first
   document is needed, never in advance.
6. **Gates stay warn-only** until a numbered decision of the project turns one blocking
   ([EK#6](../DECISIONS.md)).

## What the plugin format can enforce (measured)

Measured on 2026-10-22 with Claude Code 2.1 (`claude plugin validate --strict`, an isolated
install with `CLAUDE_CONFIG_DIR` in a scratch folder, `claude plugin details`), on copies of
the kit outside the repository. Always-on = the descriptions every session loads, as the CLI
estimates it (`kit_lint.py` prints its own estimate, characters / 4: ~3,689 with wave 4).

| Install | Skills | Agents | Before wave 4 (27 skills, 6 agents) | With wave 4 (30 skills, 10 agents) |
|---|---|---|---|---|
| One plugin, every level (the current layout) | all | all | ~3,283 tokens | ~3,782 tokens |
| A level-1 plugin | level 1 | all | ~1,577 tokens (10 skills) | ~1,904 tokens (11 skills) |
| A level-1+2 plugin | levels 1 and 2 | all | ~2,739 tokens (21 skills) | ~3,244 tokens (24 skills) |

With wave 4 the skills cost ~900 / ~1,290 / ~590 tokens by level and the agents ~990 (90 /
370 / 530) - but agents cannot be split by level (below).

What the loader does:

- One repository can host several plugins: entries of `.claude-plugin/marketplace.json` with
  `"source": "./"`, `"strict": false` and a `skills` list. The list **replaces** the default
  `skills/` folder - only the listed skills load.
- The `agents` list of such an entry passes validation but loads no agent; agents come only
  from the default `agents/` folder, all of them, in every entry.
- The default `hooks/hooks.json` loads in every entry; `"hooks": {}` does not turn it off; a
  file path is refused in an entry. Hooks for one entry only means moving `hooks.json` off its
  default path and inlining its content in that entry.
- A `.claude-plugin/plugin.json` beside such entries makes each of them fail to load
  ("conflicting manifests"), and `plugin validate --strict` still passes: only
  `claude plugin list` shows the failure. Level plugins therefore mean no `plugin.json`.
- Paths in an entry must start with `./`: a plugin in a subfolder cannot list the kit's
  skills.
- For tools that are not plugins, `sync-skills.ps1 -Level 1` (in the kit since EK#21), run
  from the kit's real `skills/` plus a scratch case layer into a scratch target, linked the
  11 level-1 skills of 30 (one of them the case's override) and the case's own skill;
  `-Level 2` added the 13 of level 2; going back to level 1 removed those 13 junctions, and
  from every skill the 19 above level 1, pointers only. A hand-made folder and a link
  pointing outside the sources were left alone, and the kit's skills were intact.

**Decided ([EK#21](../DECISIONS.md))**: the kit ships one plugin with every piece. A case
applies its level with the adoption line of its `AGENTS.md` and, for other tools, with
`sync-skills.ps1 -Level`. Two plugins - essential (level 1) and complete (every level) -
stay ready in the layout measured above: marketplace entries with a `skills` list each and
no `plugin.json`, the essential list being level 1 of `runtime/levels.json`. They are
adopted by a new decision of the kit when an exit test shows a higher-level piece firing
at level 1 - that is, when the adoption line alone did not hold. Until then a level is a
recorded discipline and the plugin installs every piece.
