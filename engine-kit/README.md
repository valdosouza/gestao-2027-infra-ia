# ⚙️ Engine Kit — portable method for AI-assisted software work

**Version**: 0.7.0 (2026-10-21) — consolidation: three divergent copies (method, runtime, Portuguese edition) merged into this single repository
**Scope**: method
**Canonical home**: the `engine-kit/` folder of the method author's workspace repository ([EK#32](DECISIONS.md), revising EK#1). The runtime lives inside it ([EK#3](DECISIONS.md)). Copies inside other case workspaces are never edited: improvements come back here, distilled.
**Origin**: distilled from two real cases — the modernization of a legacy business application (case zero) and a large multi-developer product team's knowledge base (case two)

---

## What this kit is

The minimal, **portable** core of a method for AI-assisted software work: the
documents, templates and scripts that can be installed in any new company/case WITHOUT
carrying content from any previous case. Everything here is `Scope: method` —
neutralized, with no domain names, tables, or stack from any client.

**The engine in one sentence**: assess the legacy repository (or frame the new one) →
distill the business concepts → guide the business owner through recorded decision
rounds → build in composable pieces behind gates → retain every lesson in the
knowledge base.

> The engine keeps a **human-in-command** loop: the AI organizes, evidences, and
> suggests; the business owner decides; every decision becomes a permanent, numbered
> record traceable down to the line of code.

Since wave 4 the kit covers both entry tracks - **legacy** and **greenfield**
([profiles/](profiles/legacy.md)) - the **change cycle** (front protocol, change and test
gates, browser check, delivery gates, result review, fences, session resume), the
**close and retain** tier, and three **adoption levels**
([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md)): a new project does not receive
every piece on day 1. What remains before 1.0 is the exit tests - see
[Road to 1.0](#road-to-10).

## Layout

```
engine-kit/
├── .claude-plugin/        plugin.json + marketplace.json (installable from this repo)
├── skills/<name>/SKILL.md Layer 1 — the method (auto-triggering skills)
├── agents/                Layer 1 — judgment personas
├── templates/             starting files a case copies and fills in
├── runtime/               Layer 2 — scripts (lint, validators, indexes, sync, registry,
│                          guards, editor adapters, code graph, abstraction ladder,
│                          testing, browser runner, build runner, close, migration,
│                          weekly, sources, data probe)
├── hooks/                 plugin hooks: the guards, opt-in per project, warn-only (EK#6)
├── profiles/              legacy, greenfield (the tracks); solo, team (derived artifacts)
├── docs/                  adoption levels, architecture, structure, authoring, migration,
│                          maturity, techniques, history
├── AGENTS.md              rules for whoever edits the kit
├── INSTALLATION.md        choose track, profile and level; Day 1; Day 2+ per track
├── DECISIONS.md           the kit's own numbered decisions (EK#N)
├── CHANGELOG.md           every version, both former lineages included
└── JOURNAL.md             the product journal: one method insight per line, append-only
```

Layer 3 — the case — never enters this repository ([docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)).

## 🛠️ Skills (`skills/`)

Each skill follows the Claude Code plugin format (`skills/<name>/SKILL.md` with
front matter), so it auto-triggers in Claude Code — and still works as a plain prompt
in any other tool. **Maturity** is defined in [docs/MATURITY.md](docs/MATURITY.md).

| Skill | Phase | Maturity | Core function |
|---|---|---|---|
| [`kb-setup`](skills/kb-setup/SKILL.md) | Phase 0 | proven | Build and keep the vessel: tool-neutral `AGENTS.md` + thin adapters, the domain-area model, mechanical placement, people are not roles, client specifics behind pointers, open-question onboarding |
| [`assess-legacy-repo`](skills/assess-legacy-repo/SKILL.md) | Phase 1 | operating | Faithful photograph of the legacy (file:line, nine sections, index first in large repos); claims from documents, owners and agents kept as hypotheses validated one per turn into a new version of one analysis document; deterministic re-check of agent readings; read-only data probes; 14 lessons |
| [`official-source-archive`](skills/official-source-archive/SKILL.md) | Phase 1 | candidate | Archive each external norm as published, with a hash and a text copy; close every check as CONFIRMS / ADJUSTS / OVERTURNS / NOT OFFICIAL with file, page and line; the document format is an error source |
| [`frame-greenfield`](skills/frame-greenfield/SKILL.md) | Phase 1 (greenfield) | operating | Frame a new product from a draft: organise it as it is with warning marks, Round 0, requirements from the document (FR/NFR/BR, Given-When-Then, TC-P/N/B/R), every draft item given a destination, the closed prompt a front starts from |
| [`conceptual-guardian`](skills/conceptual-guardian/SKILL.md) | Phase 2 | proven | Distill concepts: lego pieces, not scale models (scale-model test, triggering fact); occupied words; nature by presence vs process by act; third-party voice vs our own effect; transaction-aware piece; a decision with a condition becomes a delivery check |
| [`migration-direction`](skills/migration-direction/SKILL.md) | Phase 2 | candidate | The retiring system adapts, never the target: business keys re-index, else the target issues the id and the legacy keeps it; legacy state is one mirror event; a not-synced dependency error makes the send order heal itself |
| [`decision-rounds`](skills/decision-rounds/SKILL.md) | Phase 3 | proven | The business owner decides; decisions are `KEY#N` (project or front namespace), permanent, traceable in the code; the assumption ledger and the owner's release word; optional business-rule files with a rule gate |
| [`review-pack`](skills/review-pack/SKILL.md) | Phase 3 | operating | Prepare a change request for its review meeting so discovery happens before it: brief + implementer context, one owner file per content type, answers read back verbatim and registered as decisions |
| [`front-protocol`](skills/front-protocol/SKILL.md) | Change | operating | Run a front (epic) from one living prompt with a size budget and annexes per executed wave; negative knowledge; session save and resume; worktree per front; ownership partition |
| [`change-gate`](skills/change-gate/SKILL.md) | Change | operating | One change, three modes (plan / spec / test first): shared intake, pipeline gate, code gate with a literal STOP and the owner's go logged, single pass, anti-patch, divergence-point debugging, contract first, prepare-only |
| [`test-gate`](skills/test-gate/SKILL.md) | Verify | operating | Test plan mandatory with an exempt line, baseline-diff gate (warn-only first), test-evidence integrity, coverage completion; dependency-levelled tests as design |
| [`delivery-gates`](skills/delivery-gates/SKILL.md) | Verify | operating | After green tests: Socratic review score, adversarial review with no high or critical finding, every finding a permanent probe, the owner walks the real app |
| [`fences`](skills/fences/SKILL.md) | Verify | operating | Fence an invariant that drifts silently: one source list, static scan, read-only live test, boot alarm, publish script that stops, refusal at the API |
| [`disposable-proof`](skills/disposable-proof/SKILL.md) | Change | operating | Prove seeds and schema in a throwaway copy before the real one; cutover window with a rehearsed runbook, entry criterion and abort path |
| [`mold-factory`](skills/mold-factory/SKILL.md) | Change | operating | Two hand-written pieces become molds; parallel agents generate the family from the mold, the real schema and non-negotiable rules; the conductor verifies on disk and owns the shared files |
| [`backport`](skills/backport/SKILL.md) | Change | candidate | Carry selected revisions to another maintained line: a comparison folder per revision, the isolated diff from the matching line, fixed apply order, each file validated before the next; git or svn, commits prepared |
| [`browser-verification`](skills/browser-verification/SKILL.md) | Verify | operating | One engine-agnostic spec run in the built-in browser, the user's Chrome or a headless runner; PASS / FAIL / BLOCKED / MANUAL with literal read-back; login is always human |
| [`result-review`](skills/result-review/SKILL.md) | Verify | operating | Review the result, never one revision alone; file:line findings with a failure scenario; open / acknowledged / resolved handshake; revision forensics names the culprit; exit tests and dry runs prove a process on a real item |
| [`close-and-retain`](skills/close-and-retain/SKILL.md) | Close | operating | One closer per work item: closing record and tracker text (a sanctioned write follows a five-step protocol, never a comment), the retention chain with card decisions, fix and tests packaged as two commits (fix first), the deliverable gate, then the close script; prepare-only |
| [`retain-knowledge`](skills/retain-knowledge/SKILL.md) | Continuous | proven | What to retain and where (decisions, logs, cards, pipelines, settings), and the chain in the same task: index and registry, root rules only on a workspace change, claims compared, a card decision for every fact >= 0.8, the consolidation flag, SUPERSEDED marks; ends with the deliverable gate and the close script |
| [`memory-engineering`](skills/memory-engineering/SKILL.md) | Continuous | operating | Memory as an architectural capability: classes mapped to stores (cards are the semantic layer), episodic logs with typed claims, before/after-action loops, pipeline gate, the consolidation cycle (one area, evidence links to every log, flag flipped last) |
| [`archive-card`](skills/archive-card/SKILL.md) | Continuous | operating | One reusable rule per file from facts at 0.8 or more: the card decision at every closing and cycle (new / strengthen / no card), strengthen instead of duplicating, supersession without deletion, time-minted ids, VCS-neutral provenance |
| [`weekly-report`](skills/weekly-report/SKILL.md) | Continuous | candidate | One person's week for the planner, from evidence only: commits by the author field, tracker changes dated by the change date; done = worked and handed over, pending with the person's own time estimate; prepare-only (the person sends it) |
| [`evaluate-harness`](skills/evaluate-harness/SKILL.md) | Self-improvement | design | Judge a change to the harness by data: a minimal trace per session, a composite score with named components (cost kept apart), a Pareto front per task kind, a verdict the owner approves - never auto-promote; never run |
| [`scope-census`](skills/scope-census/SKILL.md) | Governance | proven | Classify the entire collection (`method × <case> × mixed`) in parallel, with verification |
| [`abstraction-ladder`](skills/abstraction-ladder/SKILL.md) | Documentation | candidate | Clickable map of the ecosystem by audience depth: the manifest is the source of record, the HTML is disposable; diagram before prose; tree graph and catalog regenerated after every change |
| [`git-security`](skills/git-security/SKILL.md) | Hygiene | operating | Versioning hygiene and secrets protection (assume a hardcoded credential until proven otherwise) — deep guides in [`references/`](skills/git-security/references/README.md) |
| [`git-setup`](skills/git-setup/SKILL.md) | Hygiene | operating | Safe initial git setup for a repository |
| [`git-commit-push`](skills/git-commit-push/SKILL.md) | Hygiene | operating | Commit + push with the security checklist |
| [`git-push`](skills/git-push/SKILL.md) | Hygiene | operating | Push with the pre-flight security check |

## 🤖 Agents (`agents/`)

| Agent | Role | Maturity | Focus |
|---|---|---|---|
| [`legacy-analyst`](agents/legacy-analyst.md) | Phase 1 analyst | operating | Photographs the legacy with file:line and settles hypotheses one per turn in a fixed status vocabulary - never infers intent, suggests improvements or fixes code while validating |
| [`feedback-analyst`](agents/feedback-analyst.md) | Self-improvement | design | Reads the typed claims of the episodic logs (corrections, misses, wrong outputs, collisions), finds patterns per agent or skill and proposes exact edits; a human approves |
| [`env-setup`](agents/env-setup.md) | Workspace setup | candidate | Sets up or repairs a person's AI workspace by profile: detects first, runs only what is missing, shows network commands before running, journals every machine change so it can be undone, ends with one real question the base must answer |
| [`ecosystem-curator`](agents/ecosystem-curator.md) | Ecosystem map | candidate | Keeps the abstraction-ladder map current: chooses mode A (generator) or mode B (extend an approved page), edits the spec never the HTML, verifies parity before claiming it |
| [`docs-writer`](agents/docs-writer.md) | Documentation | operating | The single writer of code-derived docs: template by unit type, required sections validated, one table per data document, provenance on every document, links only to markdown, never speculates; tester handoffs |
| [`build-analyst`](agents/build-analyst.md) | Build audit | candidate | Runs a registered build, audits every risky warning as a finding with file:line and a real fix (never a suppression), verdict CLEAN / SUFFICIENT / BROKEN, report archived with the work item |
| [`settings-mapper`](agents/settings-mapper.md) | Ecosystem build | operating | Finds and registers every setting that changes an execution path, before any pipeline is mapped: kinds incl. frozen code flags, reachability per build profile, areas and cross-area, patterns as the case's table; only writer of the settings registry |
| [`pipeline-builder`](agents/pipeline-builder.md) | Ecosystem build | operating | Maps one path per area and condition and satisfies the pipeline gate: asks which settings are active, reads the merged layer and checks graph freshness, collisions, client deltas, override parity (candidate), shared-state analysis |
| [`version-diff`](agents/version-diff.md) | Cross-version check | candidate | Compares a unit and its pipelines across the active maintained lines from each line's documents, never code; coverage first, a missing document stops it; DIFF with port candidates the owner decides |
| [`folder-importer`](agents/folder-importer.md) | Legacy intake | candidate | A person's local folders of past work items into the base's ticket folders, one at a time: backup gate, first folder supervised, dedup, curate (no secrets), only that folder versioned, commit and deletion prepared, deletion only after it landed |

## 🔧 Runtime (`runtime/`) and templates (`templates/`)

| Script | Job |
|---|---|
| [`kit_lint.py`](runtime/kit_lint.py) | The kit's own guard: version agreement, leak check against case deny-lists, links, Scope lines, skill size and maturity, technique coverage, required sections (T62), adoption levels |
| [`validate-registry.ps1`](runtime/validate-registry.ps1) | A case's registries against reality — fails loudly on drift |
| [`memory_index.py`](runtime/memory_index.py) | Derived, rebuildable SQLite/FTS5 index of the episodic memory and cards |
| [`build-memory-index.ps1`](runtime/build-memory-index.ps1) | No-Python fallback of the memory index |
| [`sync-skills.ps1`](runtime/sync-skills.ps1) | Exposes skills from kit, project and case to the local tool, with precedence; `-Level` limits the kit's skills to an adoption level |
| [`levels.py`](runtime/levels.py) | The adoption levels and tracks as data (`levels.json`), generated from docs/ADOPTION-LEVELS.md and checked for drift |

Wave 1 added five tool groups, each with its own README: [`registry/`](runtime/registry/README.md)
(decision registers, project inventory, ledger), [`guards/`](runtime/guards/README.md)
(encoding and revert guards behind the plugin hooks), [`adapters/`](runtime/adapters/README.md)
(per-editor agent stubs, MCP activation), [`graph/`](runtime/graph/README.md) (registry-driven
code graphs) and [`ladder/`](runtime/ladder/README.md) (abstraction-ladder documentation and
the generated catalog); closing wave 1 added [`install-journal/`](runtime/install-journal/README.md)
(every machine change recorded with its inverse, undone newest first). Wave 2 added
[`testing/`](runtime/testing/README.md) (baseline-diff gate and the commit watcher with its
proposal agent), [`browser/`](runtime/browser/README.md) (the headless engine of
`browser-verification`) and [`build/`](runtime/build/README.md) (registered builds with a
warnings audit). Details and example commands: [runtime/README.md](runtime/README.md);
the templates are listed in the same README.

## 📚 Docs

| File | Role |
|---|---|
| [`INSTALLATION.md`](INSTALLATION.md) | Executable installation: choose track, team profile and level first; Day 1 for both tracks; Day 2+ per track (legacy: size -> pilot -> first cycle; greenfield: frame -> Round 0 -> first front); moving up; what to never do |
| [`docs/ADOPTION-LEVELS.md`](docs/ADOPTION-LEVELS.md) | The three adoption levels: every piece placed once (core or situational), triggers to move up, how a case turns a level on today, what the plugin format can enforce (measured) |
| [`profiles/legacy.md`](profiles/legacy.md), [`profiles/greenfield.md`](profiles/greenfield.md) | The two tracks: Day 1, entry, success criterion, the track's candidates |
| [`profiles/solo.md`](profiles/solo.md), [`profiles/team.md`](profiles/team.md) | Where derived artifacts live and who builds them ([EK#5](DECISIONS.md)) |
| [`AGENTS.md`](AGENTS.md) | Rules for whoever (person or agent) edits the kit |
| [`docs/KNOWLEDGE-BASE-STRUCTURE.md`](docs/KNOWLEDGE-BASE-STRUCTURE.md) | Phase 0 — the vessel's layout: `AGENTS.md` + thin adapters, projects and areas, registers, what each file is and which tool checks it |
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | The three layers (method / runtime / case) and how material flows between them |
| [`docs/MATURITY.md`](docs/MATURITY.md) | The maturity labels and how a technique moves up |
| [`docs/TECHNIQUES.md`](docs/TECHNIQUES.md) | **The technique register and its coverage**: every technique the method knows (T01–T96), where it lives in the kit or which wave brings it, and how much of the register the kit already holds. Source of record: [`docs/techniques.csv`](docs/techniques.csv); `kit_lint.py` keeps it honest |
| [`docs/AUTHORING.md`](docs/AUTHORING.md) | How to write a skill or an agent: which one (judgment / fixed procedure / what a script can check), required sections, the "Use when" description rule and its always-on token cost, references/ and templates/, maturity, size, links, no case content |
| [`docs/MIGRATION.md`](docs/MIGRATION.md) | Adoption-first migration: counterparts before retirement, by script with a dry run, never fix content, SUPERSEDED never deleted, the frozen-source retirement gate; the 0.7.0 consolidation as worked example |
| [`JOURNAL.md`](JOURNAL.md) | The product journal: one method insight per line, append-only, the one-session deadline, how a line graduates into a technique row |
| [`DECISIONS.md`](DECISIONS.md) | The kit's numbered decisions |
| [`CHANGELOG.md`](CHANGELOG.md) | Version history |

## How to install in a new case

**Follow [`INSTALLATION.md`](INSTALLATION.md)**: choose the track, the team profile and
the level, then Day 1 builds the vessel (knowledge base + rules + index + connection to
existing tools + census of the collection; level 1). Legacy: size → pilot unit → first
full cycle assess→conceptualize→decide→retain; success is ONE full cycle on a pilot unit,
everything recorded in the base. Greenfield: draft → Round 0 → first front through the
gates; success is one front from draft to delivery with its decisions recorded.

In Claude Code the kit's folder is also a plugin marketplace:
`/plugin marketplace add <kit folder>` then `/plugin install engine-kit@engine-kit`.

## Complementary tooling

For the **build** phase (composable pieces → code), this kit pairs well with
[harness-kit](https://github.com/romabeckman/harness-kit): engine-kit defines *what to
build and who decides* (assessment, concepts, decision records); harness-kit supplies
the *execution discipline* (autonomous TDD loop, Socratic code review, feature state
machine). Consume it as an installed plugin — do not merge its code into this kit.

## Multi-case hygiene rules (inviolable)

- **Case content NEVER crosses companies.** Code, DDL, domain decisions, client names:
  none of it enters the kit or travels between cases. Only the METHOD travels.
- **The kit only receives `method` material** (or `mixed` already distilled —
  principle separated from instance). When in doubt, it stays out.
- **Every case keeps a deny-list of its own names OUTSIDE the kit** (the list itself is
  case content) - names, and also its stack's tell-tale terms (a language, file extensions,
  folder conventions), which the leak check cannot guess. Before every commit to the kit:
  `python runtime/kit_lint.py --denylist <case-a.txt> --denylist <case-b.txt>`.
- **Method improvements discovered in a case** come back to the kit DISTILLED (without
  the case's context) within one working session, as one line in [`JOURNAL.md`](JOURNAL.md)
  (an adopter who cannot write the kit keeps the case's outbox `JOURNAL-for-kit.md`, which the
  kit's author pulls); the next version distils it and its CHANGELOG entry names it.
- The product owner's decisions are never lost: recorded, numbered, with the why.

## Versioning

Every evolution: an entry at the top of [`CHANGELOG.md`](CHANGELOG.md) + the
**Version** line above + `version` in `.claude-plugin/plugin.json` and
`marketplace.json`. `kit_lint.py` fails when they disagree. 1.0.0 is reserved for the
release that passes the exit tests below ([EK#8](DECISIONS.md)).

## Road to 1.0

| Step | Content |
|---|---|
| 0.7.0 — consolidation | One repository; the three former copies merged; kit-lint; maturity labels (this version) |
| Wave 1 — foundation | Knowledge-base vessel (tool-neutral `AGENTS.md` + thin adapters, area model, generated indexes), decision registers with namespaces, hygiene and guards, environment setup; ecosystem map curator + abstraction ladder + abstraction-tree graph, generated agents/skills catalog, standard governance block for every agent ([EK#10](DECISIONS.md)) |
| Wave 2 — change cycle | Front protocol (living spec, session resume, worktree per front), change gate (plan / spec / test first), test gate, delivery gates, fences, disposable proof and cutover window; browser verification, result review and revision forensics, commit watcher; single docs writer, build analyst, mold factory, isolated-diff backport |
| Wave 3 — close and retain | Single closing step, episodic claims, consolidation, atomic cards, product journal, feedback loop |
| Wave 4 — entry tracks | Legacy and greenfield tracks, three adoption levels, conceptual guardian fusion; settings mapper, pipeline builder, cross-version pipeline diff, local working-folder importer |
| Exit tests | One greenfield project and one unrelated small legacy project run a full cycle with the kit alone |

Progress is measured, not claimed: [`docs/TECHNIQUES.md`](docs/TECHNIQUES.md) shows how many
registered techniques are in the kit, by tier, module and wave. A wave closes when its rows
are in the kit (or explicitly re-scheduled or rejected), and 1.0 needs every `core` row in.
