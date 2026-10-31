# Engine Kit Runtime - Layer 2 (portable tooling)

**Scope**: method

The kit has three layers: the **method** (skills, agents, docs), the **runtime**
(executable scripts in `runtime/` and fill-in templates in `templates/`) and the
**case** (each company's own knowledge base). The runtime lives inside the kit, so one
version and one installation carry both the method and the tools that the method
assumes. Nothing here carries content from any case: paths, names and keys always come
in as parameters.

## Scripts

| Script | What it does | Inputs | Example |
|---|---|---|---|
| [`kit_lint.py`](kit_lint.py) | Guards the kit itself: one version everywhere, no case term leaked (deny-lists kept outside the kit), links resolve, every doc is `**Scope**: method`, skills and agents well-formed (required sections; an agent ends with the governance block word for word; prints the always-on cost of all descriptions), size budget. Exit 1 on any error | `--root` (default: the kit), `--denylist FILE` (repeatable) or `KIT_DENYLISTS`, `--require-denylist` | `python runtime/kit_lint.py --denylist <case-denylist.txt>` |
| [`coverage.py`](coverage.py) | The technique register: renders [`docs/TECHNIQUES.md`](../docs/TECHNIQUES.md) from [`docs/techniques.csv`](../docs/techniques.csv) (one row per technique: module, maturity, tier, status, wave, location) and prints the coverage; `kit_lint.py` runs its checks | `--root`, `--check` (writes nothing, exit 1 if invalid or stale) | `python runtime/coverage.py` after editing the CSV |
| [`validate-registry.ps1`](validate-registry.ps1) | Registry vs reality: subjects registry vs `SUBJECT\` folders (and `documented` vs a placeholder INDEX), graphs registry vs graph files on disk, one valid Scope line per knowledge doc. Exit 1 on drift | `-Root` (mandatory), `-CaseValues`, `-SubjectsRegistry` / `-GraphsRegistry` (default `REGISTRY_SUBJECTS.md` / `REGISTRY_GRAPHS.md`), `-ExcludePattern`, `-NoScope` | `powershell -NoProfile -File runtime\validate-registry.ps1 -Root <kb-root> -CaseValues <case-key>` |
| [`memory_index.py`](memory_index.py) | **Canonical** memory index: SQLite (+ FTS5) rebuilt from the episodic logs (`MEMORY/`) and the cards (`KNOWLEDGE/`); `build`, `query` (cards listed first), `stats` (flags a subject at 5+ unconsolidated logs); project dimension; superseded cards listed after live ones and supersession gaps reported; typed claims (`--claim-type`). Python 3.8+, stdlib only | `--root` or `KB_ROOT`, `--db`, `--projects`; query filters `--entity --ticket --subject --project --text --status --min-confidence --unconsolidated --cards-only --claim-type` | `python runtime/memory_index.py build --root <kb-root> --db <runtime-area>/memory-index.db` then `python runtime/memory_index.py query --db <runtime-area>/memory-index.db --entity <unit>` |
| [`build-memory-index.ps1`](build-memory-index.ps1) | No-Python fallback: JSON index of the episodic logs only (no cards, no project dimension, no full-text); query by entity, ticket, subject, unconsolidated | `-Root` or `KB_ROOT`, `-OutFile`, `-Entity`, `-Ticket`, `-Subject`, `-UnconsolidatedOnly` | `powershell -NoProfile -File runtime\build-memory-index.ps1 -Root <kb-root> -OutFile <runtime-area>\memory-index.json` |
| [`sync-skills.ps1`](sync-skills.ps1) | Links skills into local discovery folders with one junction per skill; precedence kit < project < case (a later source overrides by skill name); never deletes, moves old copies aside; optional adoption level (`-Level`: only the kit skills of that level and below, from [`levels.json`](levels.json); moving down removes junctions only; `-Borrow` names a higher-level skill, EK#21; `-Track legacy|greenfield` leaves out the other track's entry pieces); agents folder linked whole, not by level. Windows only | `-Source` (ordered, low to high), `-Target`, `-Level 1\|2\|3`, `-Track legacy\|greenfield`, `-Borrow`, `-AgentsSource` / `-AgentsTarget`, `-BackupRoot`, `-WhatIf` | `powershell -NoProfile -File runtime\sync-skills.ps1 -Source '<kit>\skills;<case>\skills' -Target '<home>\.claude\skills' -Level 1 -WhatIf` |
| [`levels.py`](levels.py) | The adoption levels as data: writes [`levels.json`](levels.json) (read by `sync-skills.ps1 -Level`) from the piece tables and their Track column (`tracks`) of [`docs/ADOPTION-LEVELS.md`](../docs/ADOPTION-LEVELS.md); `--check` exits 1 on any drift; `kit_lint.py` runs it (check 9); tests in `tests-levels/` | `--root`, `--write`, `--check` | `python runtime/levels.py --write` after editing the page |

`<runtime-area>` is a folder of the case outside the kit (for example next to the code
graphs). The indexes are case artifacts: both memory scripts refuse to write inside the
kit folder.

## Tool groups

Each group has its own README with one row per script, its configuration contract and
what was left in the case it came from.

| Folder | What it gives a case | Techniques |
|---|---|---|
| [`registry/`](registry/README.md) | Per-project decision registers with a generated index and a citation check; the project inventory validator (roots vs registry, `project:` front matter, tenant-isolation check, dated enforcement); the generated "what was archived when" ledger; the shared git/svn adapter `vcs.py` (opt-in for the svn client's ignore list, EK#17). git and svn | T22, T87, T86, T04 |
| [`guards/`](guards/README.md) + [`../hooks/hooks.json`](../hooks/hooks.json) | Encoding guard and revert guard behind one hook entry point, plus the commit door of [`testing/`](testing/README.md) on the same commit hook (EK#14), **opt-in per project** (`.engine-kit/guards.json`; no file or no section = silent no-op) and **warn-only by default** (EK#6; the door is always warn-only from the hook); the harness "ask list" pattern for irreversible operations; 14 tests. git and svn | T54, T55, T29, T38 |
| [`adapters/`](adapters/README.md) | One generator of thin per-editor agent stubs from tool-neutral agents (neutral tool vocabulary, per-persona allow-list, `--check`); MCP activation from one secret-free model (merge rules, per-OS profile, the activation file never versioned); MCP smoke test | T01, T56, T91 |
| [`graph/`](graph/README.md) | Registry-driven code-graph rebuild (base / overlay / merged via an incremental hardlink tree), designated-builder and solo/team profiles (EK#5), freshness and registry cross-check, optional Build Status stamp, pinned install of the external graph tool | T07, T90 |
| [`install-journal/`](install-journal/README.md) | A PowerShell module that records every machine change of a setup (files, folders, links, environment variables, scheduled tasks, list entries) as one JSON line with its inverse; `Undo-Journal` reverses newest first and never deletes what changed after we created it; `Get-JournalStatus`; `-WhatIf` everywhere | T74 |
| [`ladder/`](ladder/README.md) | Abstraction-ladder documentation: manifest generator (mode A), extension of an approved hand-made page (mode B), the machine-readable abstraction-tree graph, and the agents/skills catalog generated from the real files (it also runs on this kit) | T63, T64, T65, T66 |
| [`testing/`](testing/README.md) | A line's suite run with evidence checks (tests found, counts, reconcile, red by an assertion), one or several parts under one lock; the per-machine baseline and the baseline-diff gate of [`test-gate`](../skills/test-gate/SKILL.md) (new vs pre-existing with red since; busy, missing-here and not-run-here never a failure); the warn-only commit door (wired into the plugin's commit hook by a `commitDoor` section in `.engine-kit/guards.json`, EK#14); the commit watcher (classify by path, grace period, first claim wins by a VCS conflict, a headless agent's proposal checked and staged for a human). git and svn | T38, T75, T76 |
| [`browser/`](browser/README.md) | The headless engine of [`browser-verification`](../skills/browser-verification/SKILL.md): runs one engine-agnostic JSON spec with Playwright (an optional peer the runner never installs) and records PASS / FAIL / BLOCKED / MANUAL with literal read-backs, per-case console and network, a screenshot per FAIL and an optional markdown report; `--dry-run` validates a spec without a browser; `--login` lets a person log in and saves the session outside every repository; localhost or a named test host only; nothing written inside the kit. Node 18+ | T41 |
| [`build/`](build/README.md) | One runner for builds registered as data (project -> command, per line; a per-client overlay first on the search path), the machine's roots in one unversioned env file, output always outside the source trees; diagnostics parsed by configured regular expressions into `summary.json` with file:line, risky codes flagged, silencer arguments and unparsed diagnostic lines recorded, verdict CLEAN / SUFFICIENT / BROKEN; plain PowerShell tests against a fake compiler. Read by the [`build-analyst`](../agents/build-analyst.md) agent | T70 |
| [`weekly/`](weekly/README.md) | One author's commits in a week window from git or svn, grouped by a work-item id pattern given as a parameter; the author field matched exactly, each commit kept by its own date (svn's date lookup brings one revision too many), commits with no id listed with a same-day hint; read-only; JSON refused inside the kit. Used by [`weekly-report`](../skills/weekly-report/SKILL.md) | T96 |
| [`close/`](close/README.md) | The close script: one call runs the mechanical checks of a closing - registries (`validate-registry.ps1` where PowerShell is present, else "not run here"; `projects_check.py`), the Scope line of touched documents, test evidence or an `exempt:` line (warning), retired locations in normative files in every spelling (written once, spellings derived), decision citations and index, ledger, memory index with consolidation flags, files left unversioned in every working copy with fix and tests listed apart; level-aware (`level` 1-3 or `--level`: the checks, validator and checklist items of a higher level are left out; at level 1, and at every level for a working copy with no first commit yet, the unversioned files are one note; the Scope line is read after a YAML front matter); frozen sources skipped by the Scope check; on svn, `svnClientIgnored` (EK#17, off by default) lets the checks see files the client's global-ignores hides. Reuses the kit's tools; checks as data in `.engine-kit/close.json`; **warn-only by default** (EK#6), `--strict` by a project decision; `--json` for agents. git and svn. Run by [`close-and-retain`](../skills/close-and-retain/SKILL.md) | T45, T78, T88 |
| [`migration/`](migration/README.md) | Manifest-driven migration of an old store into a knowledge base ([`docs/MIGRATION.md`](../docs/MIGRATION.md)): dry run into a fresh staging folder outside both stores, `--apply` by batch; markdown kept byte for byte except links to other rows, address rewrites, provenance keys and a missing Scope line; collisions keep the target's body; every problem a log line, never a content fix. The frozen-source retirement gate: snapshot by content hash, drift with an old-to-new map (manifest, then prefixes), a human ruling per item, green at zero drift or all ruled. Never deletes or renames; runs no command (VCS-neutral) | T61, T89 |
| [`sources/`](sources/README.md) | The manifest of an official-source archive ([`official-source-archive`](../skills/official-source-archive/SKILL.md)): record size and SHA-256 per file, never re-hash a changed one; verify changed / missing / unrecorded / no text copy / provenance / publisher hash / line-ending-only differences | T13 |
| [`data-probe/`](data-probe/README.md) | Read-only queries against a live database: a pure guard refuses write, DDL, rights and session words before anything is sent (comments and literals fool it in neither direction; engine lexical options declared or checked both ways); the session proven read-only by a test write the database must refuse for the expected reason; rows capped; credentials only from the environment or integrated authentication; output refused inside the kit; pluggable driver (the engine's own client, a DB-API module, sqlite3) - the kit installs none; `--allow-write` only on a disposable target. Used by [`assess-legacy-repo`](../skills/assess-legacy-repo/SKILL.md) | T94 |

## Templates and agent

| File | Becomes, in the case |
|---|---|
| [`AGENTS.template.md`](../templates/AGENTS.template.md) | `AGENTS.md`: tool-agnostic root rules; `CLAUDE.md`, `.cursorrules` and the like are thin adapters pointing to it |
| [`REGISTRY_SUBJECTS.template.md`](../templates/REGISTRY_SUBJECTS.template.md) | `REGISTRY_SUBJECTS.md` per project: the subjects table the validator checks |
| [`REGISTRY_GRAPHS.template.md`](../templates/REGISTRY_GRAPHS.template.md) | `REGISTRY_GRAPHS.md` per project: optional graph layers (e.g. base / overlay / merged) and their build status |
| [`SUBJECT_INDEX.template.md`](../templates/SUBJECT_INDEX.template.md) | `SUBJECT\<NAME>\INDEX.md`: the subject's map (units, pipelines, settings, knowledge, memory) |
| [`DECISIONS.template.md`](../templates/DECISIONS.template.md) | A project's decision register (`KEY#N`, with an "Applies to" column) - `registry/decisions_index.py --init` fills it |
| [`REGISTRY_PROJECTS.template.md`](../templates/REGISTRY_PROJECTS.template.md) | The project inventory and the registry tools' configuration (front matter) |
| [`RULE.template.md`](../templates/RULE.template.md) | One business rule per file: the current rule, an append-only Authorised / Denied history, open questions registered when asked (optional rule gate, `decision-rounds`) |
| [`AGENT.template.md`](../templates/AGENT.template.md) | A kit-style agent, ending with the standard governance block |
| [`AREA_KNOWLEDGE.template.md`](../templates/AREA_KNOWLEDGE.template.md) | One area's knowledge file with a STATUS section - the open-question onboarding (`kb-setup`) |
| [`SENSITIVE_DATA_REPORT.template.md`](../templates/SENSITIVE_DATA_REPORT.template.md) | Secrets and personal data found by a scan: type, location, line, risk, action plan (rotate first) - never the value |
| [`CARD.template.md`](../templates/CARD.template.md) | One atomic card: one reusable rule, front matter with id, project, provenance and `supersedes` ([`archive-card`](../skills/archive-card/SKILL.md)) |
| [`CLOSE.template.md`](../templates/CLOSE.template.md) | `TICKETS/<ID>/CLOSE.md`: the closing record - tracker text, commit messages, prepared commands, knowledge tail ([`close-and-retain`](../skills/close-and-retain/SKILL.md)) |
| [`DELIVERABLE.template.md`](../templates/DELIVERABLE.template.md) | A deliverable that passed the deliverable gate: fixed language, never at the root, the markdown is the record ([`close-and-retain`](../skills/close-and-retain/SKILL.md)) |
| [`REQUIREMENTS.template.md`](../templates/REQUIREMENTS.template.md) | Requirements of a product draft or a change request (FR/NFR/BR, Given-When-Then, TC-P/N/B/R, open items), sections by profile ([`frame-greenfield`](../skills/frame-greenfield/SKILL.md), [`review-pack`](../skills/review-pack/SKILL.md)) |
| [`OCCUPIED_WORDS.template.md`](../templates/OCCUPIED_WORDS.template.md) | A product's occupied words: every sense, where it lives, what a similar new concept is called instead, the deciding decision ([`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md)) |
| [`HYPOTHESES.template.md`](../templates/HYPOTHESES.template.md) | `HYPOTHESES.md` beside an analysis document: the hypothesis register (fixed status vocabulary, detail blocks, validation turns, data gaps, provisional-id mapping) ([`assess-legacy-repo`](../skills/assess-legacy-repo/SKILL.md)) |
| [`SETTINGS_REGISTRY.template.md`](../templates/SETTINGS_REGISTRY.template.md) | A project's settings registry and a setting document ([`settings-mapper`](../agents/settings-mapper.md)) |
| [`PIPELINE.template.md`](../templates/PIPELINE.template.md) | A pipeline document (base steps or client delta, override parity, collisions, shared state) and the transversal analysis ([`pipeline-builder`](../agents/pipeline-builder.md)) |
| [`VERSION_DIFF.template.md`](../templates/VERSION_DIFF.template.md) | The cross-version DIFF: coverage, missing documents, pipelines, units, settings, port candidates ([`version-diff`](../agents/version-diff.md)) |
| [`guards.example.json`](../templates/guards.example.json) | `.engine-kit/guards.json` at a repository root: turns the guards on for that project |
| [`mcp.model.template.json`](../templates/mcp.model.template.json) | The case's secret-free MCP model, merged into each machine's local activation file |
| [`feedback-analyst`](../agents/feedback-analyst.md) | The self-improvement loop over the MEMORY logs (maturity: design) |

Every template carries `**Scope**: <method|case|mixed>` for the case to fill; the
validator rejects the placeholder value in a filled copy (`*.template.md` files are
excluded by default).

## What the memory index reads

```yaml
# SUBJECT/<NAME>/MEMORY/2026-01-15-<topic>.md - episodic log
---
subject: <NAME>
project: <project-key>        # optional; otherwise derived from the path
tickets: [<id>]
entities: [<unit>, <table>]
outcome: <one line>
consolidated: false           # true once memory consolidation has folded it in
claims:
  - claim: <one verifiable statement>
    status: fact              # fact | inference | hypothesis
    confidence: 0.9
    evidence: <file:line, commit, ticket comment>
    type: correction          # optional: finding (default) | correction | missed | wrong | collision
    agent: <agent or skill>   # optional: who produced what the claim is about
---
```

```yaml
# SUBJECT/<NAME>/KNOWLEDGE/<version>_<Entity>_<ShortRule>_<YYYY-MM-DD>.md - card
---
id: K-20260115-1432
project: <project-key>
subject: <NAME>
version: <line>                      # optional
supersedes: [<older card id>]        # optional
status: fact
confidence: 0.9
tickets: [<id>]
entities: [<unit>]
vcs_revision: <revision or commit>   # optional; svn_revision is accepted as an alias
---
```

The first H1 after a card's front matter is its rule; the file starts from
[`templates/CARD.template.md`](../templates/CARD.template.md)
([`archive-card`](../skills/archive-card/SKILL.md)).

A card is superseded when another card lists its id under `supersedes:` or its body has
a `**SUPERSEDED**` line (`: none` is not a mark). Queries list live cards, then superseded
ones, then logs; the build lists marks without links, links without marks, dangling ids
and duplicate ids. `query --claim-type <type>` filters typed claims. An index built by an
older version still answers queries; rebuild it for these.

A log without front matter is indexed as pre-schema (counted, no claims).

## External dependency: code indexer

Phase 1 of the engine on a large repository needs a code graph. The runtime assumes a
CLI indexer with `query` / `path` / `explain` commands and hash-based incremental
rebuild. Its binary is NOT shipped here: install it per case and register its graphs in
the case's `REGISTRY_GRAPHS.md`.

## Installing in a case

1. Follow the kit's `INSTALLATION.md` first (Day 1: the vessel): choose the track,
   profile and level ([docs/ADOPTION-LEVELS.md](../docs/ADOPTION-LEVELS.md)).
2. Fill the templates into the case's knowledge base (`AGENTS.md` at its root, one
   `REGISTRY_SUBJECTS.md` / `REGISTRY_GRAPHS.md` per project, one `INDEX.md` per subject).
3. Run the scripts from the installed kit (do not copy them into the case). Run
   `validate-registry.ps1` after every registry change and as a recurring check, and
   run `close/close.py` at task close (it rebuilds the memory index).
4. Instantiate `agents/feedback-analyst.md` in the case's orchestration.

## Hygiene rules (the same as the kit's)

- Only `method` material enters the runtime - never a client's content or name.
- Improvements found in a case come back DISTILLED: one line in the kit's
  [`JOURNAL.md`](../JOURNAL.md) within the session, then the next version's CHANGELOG.
- Scripts are ASCII-only (Windows PowerShell 5.1 misreads BOM-less UTF-8) and take
  every path as a parameter; generated artifacts are written outside the kit.

## Lineage

The runtime started as a sibling repository of the kit: 0.1 extracted the registry
validator, the skill sync, the four templates and the feedback-analyst from a reference
case; 0.2 added the PowerShell memory index; 0.3 promoted the Python index to canonical
(SQLite + FTS5, stdlib only; same counts as the PowerShell index, validated on a team
knowledge base). In kit 0.7.0 it moved inside the kit and took the newer logic that had
evolved in a case: cards and the project dimension in the index, first-word status and
fence-aware Scope lines in the validator, junctions in the skill sync. History: the
kit's `CHANGELOG.md`.
