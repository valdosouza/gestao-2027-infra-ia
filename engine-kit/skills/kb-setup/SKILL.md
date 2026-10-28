---
name: kb-setup
description: Use when setting up a knowledge base or AI workspace in a new case, a new AI tool joins, a file, project or area folder needs a place, an agent needs one client's facts, a document would name a person's role, or a developer is onboarded to one area - builds and keeps the vessel (AGENTS.md, thin adapters, the area model, placement).
---

# Skill: Knowledge-base setup (building and keeping the vessel)

**Scope**: method
**Maturity**: proven

**When to use**: Day 1 of a case (build the vessel before reading any code), and every
time the vessel is touched afterwards: a new AI tool, a new project or version, a new
area, a file whose destination is not obvious, an agent that needs one client's facts, a
document that would name who plays which role, a developer to onboard on one area.
**Not for**: classifying documents (the [`scope-census`](../scope-census/SKILL.md) skill),
the update chain at the end of a task ([`retain-knowledge`](../retain-knowledge/SKILL.md)),
what memory is and how logs carry claims ([`memory-engineering`](../memory-engineering/SKILL.md)),
code graphs ([`runtime/graph/`](../../runtime/graph/README.md)).
**Real origin**: both cases that produced the kit built a vessel - a solo modernization
workspace (about ten code projects side by side with one knowledge folder) and a
multi-developer team knowledge base (about thirty projects, one per product version and
one per client overlay). Each section below carries its own technique label
([maturity](../../docs/MATURITY.md)); the skill as a whole is `proven`.
**Structure reference**: [`docs/KNOWLEDGE-BASE-STRUCTURE.md`](../../docs/KNOWLEDGE-BASE-STRUCTURE.md).

---

## The vessel in one picture

```
<kb-root>/
+-- AGENTS.md                    the rules - the ONLY source of truth for every AI tool
+-- CLAUDE.md, .cursorrules,     mount points: thin, each one only points to AGENTS.md
|   .github/copilot-instructions.md
+-- README.md                    the root inventory: one line per root item (and the map)
+-- DECISIONS.md                 the workspace's own decisions (<WORKSPACE-KEY>#N)
+-- _REGISTRY/PROJECTS.md        the project inventory (keys, paths, code trees)
+-- agents/  skills/             the case's AI layer: tool-neutral, client-neutral
+-- prompts/  HISTORY/           drafts being worked / superseded material
+-- <projects>/<project>/        one mirror per code project (or per version, per client overlay)
    +-- INDEX.md  REGISTRY_SUBJECTS.md  _REGISTRY/DECISIONS.md
    +-- SUBJECT/<NAME>/          one folder per domain area (section 2)
```

Two layouts work and both cases used one of them: **side by side** (the workspace root
holds the code projects and one knowledge folder that mirrors each of them) and
**knowledge base as workspace** (the knowledge base is the root; the code trees live
elsewhere and the projects registry records each one in its `Code tree` column). Pick
one in AGENTS.md and never mix them. In both, **the knowledge-base root is the knowledge
folder** - the `<kb-root>` above: what `--root`, `KB_ROOT` and the base's version control
see. Side by side, the workspace root above it holds the code projects, the knowledge
folder and, when a tool is opened there, only thin mount points that point into it. A code
tree is never inside the knowledge-base root: one versioned on its own, or read-only like a
legacy repository, would land in the base's repository and in every check run with
`--root`. The one exception ([EK#29](../../DECISIONS.md)): a code tree in a folder inside
the base that is its own repository and that the base's version control ignores, named in
the projects registry's `Code tree` cell and excluded from the checks that walk the base
folder ([INSTALLATION.md](../../INSTALLATION.md) step 1).

## 1. Root rules and thin adapters (T01, operating)

1. **`AGENTS.md` is the single source of truth.** Start it from
   [`templates/AGENTS.template.md`](../../templates/AGENTS.template.md). Skills, agents,
   docs and decisions are plain markdown that any tool can read; nothing the case needs
   depends on one tool.
2. **Tool files are mount points, never content.** `CLAUDE.md`, `.cursorrules` (plus
   `.cursor/rules/`) and `.github/copilot-instructions.md` sit at the root because each
   tool looks there - the location is the vendor's convention, not the case's. Each one
   points to `AGENTS.md` and repeats at most the few rules that break most often. One
   folder per tool (`.claude/`, `.cursor/`, `.github/`); each is inert for anyone who
   does not use that tool.

   ```markdown
   # <Case> - rules for <tool>

   **Scope**: acme

   Read `AGENTS.md` at the knowledge-base root and follow it: it is the single source of truth
   for every AI tool here. This file only points to it.

   Repeated on purpose because they break most often: <rule>; <rule>.
   ```

   The Scope value of a case document is the case's key (here the fictional `acme`);
   `case` is equally valid ([EK#2](../../DECISIONS.md)). A case key is written once in
   `caseValues` of the close configuration (`.engine-kit/close.json`) and in `scope_value`
   of the projects registry, so that the checks accept it and the generated files carry it.

3. **Agents are one neutral file each; stubs are generated.** Every agent is one
   markdown file in `agents/` whose front matter lists its tools in a neutral vocabulary
   (`read`, `search`, `edit`, `terminal`, `memory`, ...). The per-editor stubs are written
   by [`gen-agent-stubs.py`](../../runtime/adapters/gen-agent-stubs.py) and never by hand;
   `--check` exits 1 when a stub is out of date. Skills are linked into each tool's
   discovery folder by [`sync-skills.ps1`](../../runtime/sync-skills.ps1) (`-Level` and
   `-Track` of the case's adoption line), not copied.
   MCP servers: one versioned, secret-free model and one machine-local activation per
   editor ([adapters README](../../runtime/adapters/README.md), T56).
4. **Write roots as placeholders.** Agents, skills and prompts write `{KB_ROOT}` and
   resolve it from the environment before acting, in the active shell's path style; a
   script reads the variable with a documented fallback. Nobody hard-codes another root.
5. **A new tool joins in one task**: its mount point (thin), its line in the root
   inventory, its column in the tool-support matrix. All three, or none.
6. **The manual path always works.** A tool with no adapter is told, at the start of
   every session: *"Read `AGENTS.md` and follow it."* A skill is used with *"Follow the
   procedure in `skills/<name>/SKILL.md`"*; an agent by pointing the tool at
   `agents/<name>.md`. When a step fails for one tool, that is a divergence to record,
   not something to work around in silence.
7. **Nothing in the root without an inventory line.** The root inventory (in the root
   `README.md`) says, for every file and folder at the root, what it is and who needs
   it. A new file in the root is a file in the wrong place, unless it is a mount point
   and arrives with its line.
8. **One artifact language; English where the tools read.** `AGENTS.md` fixes the case's
   artifact language once - the language the owner writes in, unless the owner fixes
   another; the chat follows the user - and lists what stays in English because the kit's
   tools and skills read it: register headers, front-matter keys, the Scope token, ids, the
   closing record's draft markers, the probe labels
   ([template](../../templates/AGENTS.template.md), Core Rules).

**The tool-support matrix** is one case document that says what is automatic and what
is manual in each tool, so nobody discovers it by frustration. Its default home is a
section of the root `README.md`, beside the root inventory; `AGENTS.md` names it (Tool
Neutrality):

| Capability | `<tool A>` | `<tool B>` | Any other AI tool |
|---|---|---|---|
| Rules loaded automatically | `<mount point>` | `<mount point>` | Manual: "Read `AGENTS.md` and follow it", every session |
| Skills auto-triggered | linked by `sync-skills.ps1` | `<how>` | Manual, by path |
| Skills usable at all | yes | yes | yes - a skill is a plain markdown procedure |
| Agents | generated stub | generated stub | point the tool at `agents/<name>.md` |
| MCP servers | `setup-editor.ps1 -Editor <tool>` | `<how>` | from the model, if the tool speaks MCP |
| Guided setup | `<setup agent or checklist>` | `<same>` | the manual checklist |

## 2. The domain-area model (T02, proven)

Every business domain of a project is an **area** (the templates call it a subject):
one folder, `SUBJECT/<NAME>/`, with a fixed inside. The project's areas are listed in
`REGISTRY_SUBJECTS.md` ([template](../../templates/REGISTRY_SUBJECTS.template.md));
names are UPPER_SNAKE.

| Part | What it holds |
|---|---|
| `INDEX.md` | **What the area is**: one paragraph, its source units, its pipelines, its settings, links to the cards and logs. Read it first. ([template](../../templates/SUBJECT_INDEX.template.md)) |
| `PIPELINES/` | Documented execution flows: trigger, steps, the settings that bifurcate them, collisions. No fix is designed on a flow that is not here. Written by the [`pipeline-builder`](../../agents/pipeline-builder.md); `TRANSVERSAL.md` when several paths write the same state |
| `SETTINGS/` | The configuration keys, flags and per-client overrides that change the area's behaviour: detail documents; the project's registry is `_REGISTRY/SETTINGS.md` ([`settings-mapper`](../../agents/settings-mapper.md)) |
| `MEMORY/` | Episodic logs, one per session: `YYYY-MM-DD-<topic>.md` with claims front matter (fact, inference or hypothesis, with confidence and evidence) |
| `KNOWLEDGE/` | Atomic cards: one reusable rule per file, cited by id (`K-YYYYMMDD-HHMM`), written only from facts at 0.8 or more that will hold for the next ticket ([`archive-card`](../archive-card/SKILL.md)) |
| `RULES/` | Business rules: the current rule, an append-only history of what was authorised and denied, open questions. An agent stops on a denied row |
| `TICKETS/<ID>/` | Everything produced while working one work item: dossier, plan or spec, build and test evidence, review, the text for the tracker. Worked here directly, never in a personal folder copied in later; folders from before the base: the [`folder-importer`](../../agents/folder-importer.md) agent |

**Three memory grains** - keep them apart, link them from the INDEX:

| Grain | Answers | Lifetime |
|---|---|---|
| Log (`MEMORY/`) | What did one session find? | Episodic; consolidated, never deleted |
| Card (`KNOWLEDGE/`) | Which rule holds for the next ticket? | Until a later fact supersedes it |
| INDEX | What is this area? | Rewritten as the area is understood |

**Project <-> knowledge symmetry**: code lives in the project, knowledge in its mirror.
Every code project has exactly one knowledge folder (one per version, one per client
overlay); no document is born outside a mirror, and no code lives in the knowledge base.
Graphs and other derived artifacts follow the solo/team profile of
[EK#5](../../DECISIONS.md): team - versioned in the base, one designated builder; solo - a
runtime area outside the versioned base, either beside it or a folder inside it that
version control ignores (`.runtime/`, by `.gitignore` or `svn:ignore` on the base root,
[EK#27](../../DECISIONS.md)), named in the derived-artifacts row of `AGENTS.md`
([solo profile](../../profiles/solo.md#a-runtime-folder-inside-the-base)).

## 3. Mechanical placement (T03, proven)

Where a file goes is computed, not asked. AGENTS.md carries two things: a **path
formula** for projects and a **decision table** for files.

**The path formula** (example: a product *Acme Orders* with a client overlay *acme-north*):

| Kind | Formula | Example | Key |
|---|---|---|---|
| Workspace | `.` | the knowledge base itself | `<WORKSPACE-KEY>` |
| Product version | `projects/<product>-<major.minor>/` | `projects/acme-orders-2.1/` | `ACME-2.1` |
| Client overlay | `clients/<client>/<product>-<major.minor>/` | `clients/acme-north/acme-orders-2.1/` | `ACME-NORTH-2.1` |
| Shared library or service | `projects/<name>/` | `projects/acme-billing/` | `BILLING` |
| New product, no version line yet | `projects/<product>/` | `projects/acme-orders/` | `ORDERS` |

Rules that come with it:

- **Create the standard folder; do not ask.** When the product, version and client are
  known and the project folder is missing, create it and add its row to
  `_REGISTRY/PROJECTS.md` ([template](../../templates/REGISTRY_PROJECTS.template.md)) in
  the same task. [`projects_check.py`](../../runtime/registry/projects_check.py) fails on
  a project folder without a row and on a row without a folder. An empty folder still
  gets its row.
- **"Don't invent" means no non-standard names** and nothing dumped in the root. It does
  **not** mean "leave the standard folder uncreated".
- **Never mix versions.** One project per version line; a patch release stays in its
  line's project; a new major line is a new row with a new key, and its old registers are
  linked, not copied. A new product starts unversioned (`projects/<product>/`); when its
  first version line is cut, that line is a new row the same way.
- **The owner of the work owns the file.** A client's work item belongs to the client
  overlay project even when the change lands in the shared product's code; product
  knowledge with no client belongs to the product project.
- **Reuse the area catalog.** Use the area of `REGISTRY_SUBJECTS.md` that fits; create
  `SUBJECT/<NAME>/` in that project (row `skeleton`) when it is missing there. Do not ask
  for a new name when the catalog fits; when nothing fits, propose one name in one line,
  with the closest existing areas.
- **Greenfield: no area before Round 0 closes.** An area names a domain concept, and on
  the [greenfield track](../../profiles/greenfield.md) that waits for the owner's answers;
  until then a document lives in `prompts/` or at the root of the project's mirror
  ([INSTALLATION.md](../../INSTALLATION.md), steps 1 and G2).

**The decision table** - "where does this new file go?":

| The new file is... | It goes to |
|---|---|
| Source code, build scripts, executable database scripts | The code project (or the shared scripts repository) - never the knowledge base, except a prepared change's patches in `TICKETS/<ID>/PATCH/` until a person applies them ([`change-gate`](../change-gate/SKILL.md)) |
| A rule for every AI tool | `AGENTS.md` - never a second rules file |
| A tool's mount point | The root, thin, with its inventory line |
| A decision about the whole workspace | Root `DECISIONS.md` (`<WORKSPACE-KEY>#N`) |
| A decision of one project | `<project>/_REGISTRY/DECISIONS.md` (`KEY#N`, [template](../../templates/DECISIONS.template.md)) |
| What one session found | `<project>/SUBJECT/<NAME>/MEMORY/YYYY-MM-DD-<topic>.md` |
| A rule that holds for the next ticket | `<project>/SUBJECT/<NAME>/KNOWLEDGE/<version>_<Entity>_<ShortRule>_<YYYY-MM-DD>.md` (id `K-YYYYMMDD-HHMM` in its front matter) |
| An execution flow / a setting / a business rule | `PIPELINES/` / `SETTINGS/` / `RULES/` of the area |
| Anything made while working one work item, deliverables included | `<project>/SUBJECT/<NAME>/TICKETS/<ID>/` |
| Client-specific facts an agent or skill needs | The client overlay project's notes file (section 5) |
| A prompt or plan being drafted | `prompts/` |
| A closed phase prompt (decisions recorded) | Stays in `prompts/` as the living front prompt; at the front's close it moves to the owning project's mirror and the frozen copy of its draft goes to `HISTORY/` |
| A legacy unit's assessment (the analysis document) and its hypothesis register | `<project>/SUBJECT/<NAME>/<analysis>.md` with `HYPOTHESES.md` beside it; for a defect, the work item's folder ([`assess-legacy-repo`](../assess-legacy-repo/SKILL.md)) |
| A permanent standard of one cross-project domain | `<domain>/STANDARDS.md` (for example `database/STANDARDS.md`) |
| A skill of one project | `<project>/skills/<verb-object>/SKILL.md` |
| A skill or agent for every project | The case's `skills/` or `agents/`, client-neutral; a method lesson goes back to the kit |
| A superseded document | Marked SUPERSEDED with a pointer to its replacement - in place or in `HISTORY/`, as AGENTS.md fixes once; never deleted |
| A generated index, ledger or graph | Wherever its generator writes it; never edited by hand |
| Study code or a proof of concept | A learning folder, excluded from the census as vendored |

Every file the table places carries `project: <KEY>` in its front matter when it sits
under an area (logs, cards, pipelines, ticket documents);
`projects_check.py --check-touched` checks that the key matches the folder.

## 4. People are not roles (T25, operating)

- Never infer a person's role from a tracker field (*assigned to*, *requester*,
  *created by*), from who comments most, or from who owns a query.
- A role comes only from the **people registry** (`_REGISTRY/PEOPLE.md`, each row
  confirmed by the owner) or from a **signed document** that names it.
- Otherwise write the role without a name ("the project manager", "QA", "the
  requester") or "owner to be assigned at the review".
- A name may be quoted as a field value ("Assigned to: X"), never as "X, the project
  manager".
- The rule is stated once, in AGENTS.md; skills and agents point to it. A skill whose
  output names roles records where each one came from (a `role_source` field).

## 5. Client specifics behind a pointer (T95, operating)

- **The AI layer is client-neutral.** No client name, client path or client-only value
  appears in an agent or a skill of the case. An agent written for "the client with the
  odd date format" is an agent for every client with a pointer.
- **The specifics live with the client.** Each client overlay project keeps a notes file
  per topic (for example `clients/acme-north/acme-orders-2.1/NOTES/custom-tables-notes.md`):
  where that client's files are, its canonical scripts, its validation commands, its
  hard-won lessons.
- **The agent reaches them through a pointer**: "resolve the client and version from the
  task; read `<client-project>/NOTES/<topic>-notes.md` before advising; if it does not
  exist, create it from the template section at the end of this agent and link it from
  the client project's `INDEX.md`."
- **The kit obeys the same rule.** [`kit_lint.py`](../../runtime/kit_lint.py) fails on
  any term of a case deny-list; the deny-lists stay outside the kit because each one
  names clients. A case applies the same idea to its own AI layer: its client list,
  searched over `agents/` and `skills/`, must return nothing.

## 6. Open-question onboarding (T08, candidate)

A light way to bring one developer into AI-assisted work on one area without installing
the full vessel on their machine. Proven in one case; optional.

1. **One knowledge file**, `<AREA>_KNOWLEDGE.md`, from
   [`templates/AREA_KNOWLEDGE.template.md`](../../templates/AREA_KNOWLEDGE.template.md):
   context, the proven recipe with pointers to reference files in the same workspace,
   a **STATUS** section (done / queue / skip / open issues), watch-outs, working
   agreements. The master copy lives in the knowledge base, linked from the area INDEX;
   the developer gets a plain, unversioned copy next to the code.
2. **One rules pointer** in that developer's tool rules file: *"For any broad question
   about `<AREA>`, read `<AREA>_KNOWLEDGE.md` first and answer from it; offer to update
   its STATUS after each commit."*
3. **The smoke test is a plain question** - no special syntax, no file mentions:
   *"What do you know about `<AREA>` that can help me?"* must return the context, the
   recipe, the queue and the watch-outs; *"What should I do next?"* must answer from the
   queue.
4. **The update habit closes the loop**: after each commit the developer asks the AI to
   update STATUS, so the file is also the progress tracker.

The same test proves a whole vessel: in a fresh session of each tool, a plain question
about a project must be answered from AGENTS.md and the project's INDEX, and "where does
a session log about `<area>` go?" must come back as a path, not a question.

## Day 1 - build it (in this order)

The order of [INSTALLATION.md](../../INSTALLATION.md) Day 1: each step writes what the next
one cites.

1. Choose the layout (side by side or knowledge base as workspace); create the knowledge
   folder - the knowledge-base root in either layout, with no code tree inside it (except
   an ignored repository of its own, EK#29) - and
   `_REGISTRY/PROJECTS.md` with the workspace row, one row per project and the
   front-matter keys of the case's profile
   ([template](../../templates/REGISTRY_PROJECTS.template.md)). `prompts/` and `HISTORY/`
   (if AGENTS.md chooses it) are created with their first document - git keeps no empty
   folder.
2. The registers: `decisions_index.py --init <WORKSPACE-KEY>` and `--init <KEY>` per
   project. Per project: its mirror folder, `INDEX.md` (skeleton below),
   `REGISTRY_SUBJECTS.md` - an empty table is valid until the first area. No area in
   advance: one is created when its first document needs it, and on the greenfield track
   not before Round 0 closes (section 3).
3. Record the choices: the track, the profile, level 1 (and each borrowed piece), the
   artifact language (section 1, item 8); the decision owner only when a signed document
   names them - otherwise it is the first question of Round 0 (section 4: nobody is named
   for the owner). With an owner named, they are the first workspace decisions; without
   one they are assumptions (`A-<WORKSPACE-KEY>n`) that Round 0 ratifies
   ([INSTALLATION.md](../../INSTALLATION.md), step 4).
4. Write `AGENTS.md` from the template: the placement formula and decision table, the
   area model, people are not roles, client specifics behind pointers, the governance
   block, the prepare-only line, and the adoption line citing the decisions of step 3
   ([adoption levels](../../docs/ADOPTION-LEVELS.md)). Delete every placeholder.
5. Add the mount points of the tools in use, each with its root-inventory line; write
   the tool-support matrix (a section of the root `README.md`, unless `AGENTS.md` names
   another home).
6. Put the agents in `agents/` (a new one starts from the kit's agent template, which
   ends with the standard governance block), generate their stubs, link the skills.
7. Run the [`scope-census`](../scope-census/SKILL.md) over everything already written.
8. Run the checks of the case's level below until they are clean, then the smoke test of
   section 6.

**The project's `INDEX.md`** - what the project is, read first by every session that
works on it (an area's INDEX has its own [template](../../templates/SUBJECT_INDEX.template.md)):

```markdown
# <Project name> - Project Index

**Scope**: acme

<One paragraph: what the project is, for whom, and where it stands.>

| Item | Value |
|---|---|
| Key | `<KEY>` (row of `_REGISTRY/PROJECTS.md`) |
| Code tree | `<path or repository URL>` - or "none yet" |
| Decisions | [_REGISTRY/DECISIONS.md](_REGISTRY/DECISIONS.md) (`<KEY>#N`) |
| Areas | [REGISTRY_SUBJECTS.md](REGISTRY_SUBJECTS.md) - none yet |
| Current prompt | `<prompts/prompt_<front>.md - drafted, closed, then the living front prompt until the front's close>` |

## State

<One line: the current phase or front, and what comes next. History goes to a changelog.>
```

## Every task - keep it

- A new file: the decision table; a missing standard folder is created and registered in
  the same task.
- A new or touched document: its Scope line.
- A new tool: mount point + inventory line + matrix column, in one task.
- A changed agent: regenerate the stubs; `--check` is clean.
- A document that names a role: section 4. An agent that needs a client's fact: section 5.
- At the close: the close script ([`runtime/close/`](../../runtime/close/README.md)) runs
  the checks below in one call, then the [`retain-knowledge`](../retain-knowledge/SKILL.md)
  chain.

## Which tool checks which rule

Paths are relative to the kit. All of them report and exit 1; whether that blocks is
the case's numbered decision ([EK#6](../../DECISIONS.md)).

| Rule | Checked by |
|---|---|
| Every project folder has a row, every row a folder | [`registry/projects_check.py`](../../runtime/registry/projects_check.py) `--root <kb-root>` |
| A touched log, card, pipeline or ticket doc declares the `project:` of its folder | `projects_check.py --check-touched` |
| A change stays inside its tenant | `projects_check.py --check-scope --project <KEY>` |
| A cited `KEY#N` exists | [`registry/decisions_index.py`](../../runtime/registry/decisions_index.py) `--check-touched` |
| Area rows vs `SUBJECT/` folders, `documented` vs a placeholder INDEX, one Scope line per doc (level 3) | [`validate-registry.ps1`](../../runtime/validate-registry.ps1) `-Root <kb-root>` |
| Agent stubs match their neutral agents | [`adapters/gen-agent-stubs.py`](../../runtime/adapters/gen-agent-stubs.py) `--check` |
| The agents and skills catalog matches the real files | [`ladder/catalog_gen.py`](../../runtime/ladder/catalog_gen.py) |
| No unversioned file at hand-over; no normative pointer to a retired location | [`close/close.py`](../../runtime/close/close.py) |
| The kit names no case - the kit author's release check, never run by a case ([AGENTS.md](../../AGENTS.md)) | [`kit_lint.py`](../../runtime/kit_lint.py) `--denylist <case-denylist>` |
| Root inventory, thin adapters, people are not roles | Review at the close - no tool yet |

## Recorded lessons (real situations)

- **A mount point moved into a tidy subfolder silently disabled every guardrail** on
  every checkout: the tool no longer found it. Mount points stay where the tool looks.
- **"Don't invent" was read as "don't create"**: agents asked on every task, or left work
  in the root, because the standard project folder did not exist yet. Making placement
  mechanical (formula, create, register) ended both.
- **Personal scratch folders mirrored into the base later** collided across developers
  and lost work; tickets are worked in the base from the first file.
- **A hand-kept central index that also carried the history** grew past 300 KB and
  stopped being read. The index is a map with a size budget; history goes to a
  changelog; the ledgers and indexes are generated.
- **Tracker fields record who touched an item, not who holds a role**; a role written
  from them reads as a fact and travels into briefs and meeting packs.
- **Knowledge in files beats prompts in heads**: with the open-question test, onboarding
  shrank to "open the folder, ask the question".
