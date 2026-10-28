# Knowledge Base Structure (Phase 0 - the vessel)

**Scope**: method
**Role**: before assessing any code, build the place where the knowledge will live. A
memory tool without a process becomes a pile of notes; the vessel IS the process.
**Procedure**: the [`kb-setup`](../skills/kb-setup/SKILL.md) skill builds and keeps it.
This page is the reference: what each file and folder is, which template starts it and
which tool keeps it honest.

---

## Principles

1. **One tool-neutral rules file.** `AGENTS.md` is the single source of truth for every
   AI tool. `CLAUDE.md`, `.cursorrules` and `.github/copilot-instructions.md` are mount
   points that only point to it; agent stubs are generated (T01).
2. **Project <-> knowledge symmetry.** Code lives in the project, knowledge in its
   mirror: one knowledge folder per code project (per version, per client overlay). No
   document is born loose, and no code lives in the knowledge base (T02).
3. **Placement is mechanical.** A path formula and a decision table in `AGENTS.md`
   decide where every file goes; a missing standard folder is created and registered,
   not asked about. Nothing enters the root without an inventory line (T03).
4. **Every domain area has the same inside** - INDEX, PIPELINES, SETTINGS, MEMORY,
   KNOWLEDGE, RULES, TICKETS - and three memory grains: a log says what one session
   found, a card the rule for the next ticket, the INDEX what the area is (T02).
5. **An index is a map, history is a changelog.** Indexes and ledgers are generated,
   never hand-edited, and have a size budget; history goes to a changelog (T04).
6. **Registries match reality.** A registry row that contradicts the disk is a bug, and
   a validator fails loudly on it (T05, T87).
7. **Every document carries one Scope line** (`method | <case> | mixed`, see
   [`scope-census`](../skills/scope-census/SKILL.md)); nothing is deleted - a superseded
   document is marked SUPERSEDED with a pointer to what replaced it (T06).
8. **Decisions are numbered per namespace** (`KEY#N`), permanent, never renumbered; one
   home register per project and a generated index of all of them (T22,
   [EK#4](../DECISIONS.md)).
9. **Plain markdown.** The whole base opens in any editor or note-taking app; wiki-style
   links are welcome where the case's tools read them.

## Folder skeleton

```
<workspace-root>/
+-- AGENTS.md                      the rules (tool-neutral)
+-- CLAUDE.md  .cursorrules        mount points: thin pointers to AGENTS.md
+-- .claude/  .cursor/  .github/   one folder per tool: generated stubs, linked skills
+-- README.md                      root inventory (one line per root item) + short map
+-- DECISIONS.md                   the workspace's register (<WORKSPACE-KEY>#N)
+-- _REGISTRY/
|   +-- PROJECTS.md                project inventory + configuration of the registry tools
|   +-- PEOPLE.md                  confirmed people and roles (optional)
|   +-- DECISIONS-INDEX.md         generated
|   +-- LEDGER-ALL.md              generated
+-- agents/                        one tool-neutral file per agent, client-neutral
+-- skills/<name>/SKILL.md         the case's skills (the kit's are installed, not copied)
+-- prompts/                       drafts and plans being worked
+-- HISTORY/                       superseded material (when the case keeps it apart)
+-- <projects>/<project>/          one mirror per code project, version or client overlay
    +-- INDEX.md                   what the project is (skeleton: kb-setup, Day 1)
    +-- REGISTRY_SUBJECTS.md       its areas
    +-- REGISTRY_GRAPHS.md         its code graphs (optional)
    +-- _REGISTRY/DECISIONS.md     its register (KEY#N)
    +-- _REGISTRY/LEDGER.md        generated
    +-- _REGISTRY/SETTINGS.md      its settings registry (settings mapper)
    +-- NOTES/<topic>-notes.md     client specifics, reached by pointer (client overlays)
    +-- SUBJECT/<NAME>/
        +-- INDEX.md  PIPELINES/  SETTINGS/  MEMORY/  KNOWLEDGE/  RULES/  TICKETS/<ID>/
        +-- <analysis>.md  HYPOTHESES.md   a legacy unit's analysis and its hypothesis register
```

Every name above is a default; the registry tools take each one as configuration
([`runtime/registry/README.md`](../runtime/registry/README.md)). Two layouts work:
**side by side** (the workspace root holds the code projects and one knowledge folder
that mirrors them; the knowledge folder is the knowledge-base root: the root files above
sit in it, and `--root` and its version control name it; the workspace root holds only thin
mount points pointing into it) and **knowledge base as workspace** (the knowledge base is the root; the projects registry records where each
code tree lives). `AGENTS.md` names the one the case uses.

## What each file is

| File | Role | Started from | Kept honest by |
|---|---|---|---|
| `AGENTS.md` | Rules for every tool: placement formula and table, area model, people are not roles, client specifics behind pointers, governance, prepare-only | [`AGENTS.template.md`](../templates/AGENTS.template.md) | review at the close |
| Mount points | Point to `AGENTS.md`; repeat at most the rules that break most | the adapter below | root inventory |
| Agent stubs | Per-editor stub of one neutral agent | generated | [`gen-agent-stubs.py`](../runtime/adapters/gen-agent-stubs.py) `--check` |
| `README.md` (root) | Root inventory + the short map of the base | - | review at the close |
| `_REGISTRY/PROJECTS.md` | Every project: key, type, folder, code tree | [`REGISTRY_PROJECTS.template.md`](../templates/REGISTRY_PROJECTS.template.md) | [`projects_check.py`](../runtime/registry/projects_check.py) |
| `DECISIONS.md`, `_REGISTRY/DECISIONS.md` | A namespace's decisions | [`DECISIONS.template.md`](../templates/DECISIONS.template.md) | [`decisions_index.py`](../runtime/registry/decisions_index.py) |
| `REGISTRY_SUBJECTS.md` | A project's areas and their status | [`REGISTRY_SUBJECTS.template.md`](../templates/REGISTRY_SUBJECTS.template.md) | [`validate-registry.ps1`](../runtime/validate-registry.ps1) |
| `REGISTRY_GRAPHS.md` | A project's code graphs and build status | [`REGISTRY_GRAPHS.template.md`](../templates/REGISTRY_GRAPHS.template.md) | `validate-registry.ps1`, [`runtime/graph/`](../runtime/graph/README.md) |
| `SUBJECT/<NAME>/INDEX.md` | What the area is; links its cards and logs | [`SUBJECT_INDEX.template.md`](../templates/SUBJECT_INDEX.template.md) | `validate-registry.ps1` (`documented` vs a placeholder) |
| `MEMORY/*.md`, `KNOWLEDGE/*.md` | Logs with claims, atomic cards | [`memory-engineering`](../skills/memory-engineering/SKILL.md) (logs); [`CARD.template.md`](../templates/CARD.template.md) via [`archive-card`](../skills/archive-card/SKILL.md) (cards) | `projects_check.py --check-touched`, [`memory_index.py`](../runtime/memory_index.py) |
| `HYPOTHESES.md` (beside an analysis document) | The hypothesis register of a legacy assessment or a defect investigation | [`HYPOTHESES.template.md`](../templates/HYPOTHESES.template.md) | [`assess-legacy-repo`](../skills/assess-legacy-repo/SKILL.md): one per turn, a new analysis version per validation |
| `_REGISTRY/SETTINGS.md`, `SETTINGS/*.md` | A project's settings registry and setting documents | [`SETTINGS_REGISTRY.template.md`](../templates/SETTINGS_REGISTRY.template.md); only writer: [`settings-mapper`](../agents/settings-mapper.md) | `projects_check.py --check-touched` |
| `PIPELINES/PIPE_*.md`, `PIPELINES/TRANSVERSAL.md` | One execution path per area and condition; the shared-state analysis | [`PIPELINE.template.md`](../templates/PIPELINE.template.md); only writer: [`pipeline-builder`](../agents/pipeline-builder.md) | `projects_check.py --check-touched` |
| `<AREA>_KNOWLEDGE.md` | One-file onboarding of one area (optional) | [`AREA_KNOWLEDGE.template.md`](../templates/AREA_KNOWLEDGE.template.md) | its STATUS section, updated after each commit |
| Ledgers, decision index, catalog | Generated maps | - | their generators; never hand-edited |

## The root

The root holds only `AGENTS.md`, the tool mount points and their folders, the root
`README.md`, `DECISIONS.md`, a changelog if the case keeps one, and top-level folders.
Each item has one line in the root inventory. A new file in the root is a file in the
wrong place.

A minimal thin adapter (the same shape for every tool):

```markdown
# <Case> - rules for <tool>

**Scope**: acme

Read `AGENTS.md` at the workspace root and follow it: it is the single source of truth
for every AI tool here. This file only points to it.

Repeated on purpose because they break most often: <rule>; <rule>.
```

## The memory triple (tool x process)

| Layer | Tool (examples) | Process (this kit) |
|---|---|---|
| Code retrieval | code indexer or graph, semantic search | Phase 1 feeds the base with the result; graphs registered in `REGISTRY_GRAPHS.md` |
| Agent memory | logs and cards in the base; a derived index; the tool's own memory | [`memory-engineering`](../skills/memory-engineering/SKILL.md) defines it; [`retain-knowledge`](../skills/retain-knowledge/SKILL.md) decides WHAT goes in and where |
| Human reading | any markdown reader over the base | INDEX per area + generated ledgers + numbered decisions |

The tool stores; the process decides what deserves to be stored, where, and how it
will be found again. Without both layers together, you either lose knowledge or drown
in it.

## From the earlier Phase 0 layout

The first version of this page described one tool's rules file at the root and a hand-kept
central index that also accumulated the history. Both cases outgrew it: the rules file
tied the base to one tool, and the index grew too large to be read. To move a base over:

1. Move the rules into `AGENTS.md`; leave the old rules file as a thin mount point.
2. Split the central index: the map becomes the root `README.md` (with the root
   inventory), the history table moves to a changelog, and the per-project lists become
   the projects registry and the generated ledgers.
3. Register every project in `_REGISTRY/PROJECTS.md` and run the checks of the
   [`kb-setup`](../skills/kb-setup/SKILL.md) skill until they are clean.
