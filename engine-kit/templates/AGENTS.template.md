# <Case> - AI Workspace Rules

**Scope**: <method|case|mixed>

> Template from the engine-kit (`templates/AGENTS.template.md`; procedure: the kit's
> `kb-setup` skill). Fill every `<placeholder>`, delete the rows and sections the case
> does not need, and delete this note. The filled copy belongs to the case (usually
> `**Scope**: <case-key>`, e.g. `**Scope**: acme`; `case` is equally valid). Sections and
> lines tagged *level 2* or *level 3* are practices of that level; untagged ones are
> level 1. Below that level, delete them or keep them tagged - a tagged practice is named
> and asked for, never run unasked (the adoption line); moving up removes the tag.
> Sections and rows tagged *situational* are kept only when their situation exists.
> **A solo case at level 1** keeps the adoption line, Core Rules, Tool Neutrality, Workspace
> Paths, Placement, Area Model, People are not roles, Governance and What to Never Do, and
> may leave out: Code Graphs (*level 3*), Memory Protocol (*level 2*), Client specifics
> behind pointers and the client-overlay rows (*situational*), and every row tagged
> *level 2* or *level 3*. Before an owner of the decisions is named, a Day-1 choice is cited
> by its assumption id (`A-<WORKSPACE-KEY>n`) wherever this template asks for
> `<WORKSPACE-KEY>#N`, until Round 0 ratifies it.

This file is the tool-agnostic source of truth for every AI assistant working in this
workspace. Tool-specific files (`CLAUDE.md`, `.cursorrules`, ...) are THIN ADAPTERS that
point to these rules - never duplicate content into them.

**Adoption**: level <1|2|3> (<WORKSPACE-KEY>#N | A-<WORKSPACE-KEY>n) - track <legacy|greenfield> - profile <solo|team> - borrowed: <piece (KEY#N | A-KEYn), ... | none>.
Use only the kit pieces of this level and below, plus the borrowed ones (the kit's
docs/ADOPTION-LEVELS.md). When a request matches another piece of a higher level, name
the piece and ask the owner: move up, borrow it (a decision), or do the work without it.

---

## Core Rules

- Do what has been asked; nothing more, nothing less
- NEVER create files unless necessary - prefer editing existing files
- ALWAYS read a file before editing it
- Keep files under 500 lines
- **Artifact language: <language>** (<WORKSPACE-KEY>#N) - every document, agent and skill
  of this workspace is written in it; the chat follows the user. Chosen once on Day 1: the
  language the owner writes in, unless the owner fixes another.
- **English whatever the artifact language**, because the kit's tools and skills read these words:
  the table headers of the registers (`Key`, `Path`, `Type`, `Code tree`, `#`, `Date`,
  `Decision`, `Applies to`, `Subject`, `Status`, ...), the status words of the area
  registry (`documented`, `skeleton`, ...), front-matter keys (`project`, `status`,
  `confidence`, `evidence`, ...), the Scope token and its values
  (`**Scope**: method | <case-key> | mixed`), the `**SUPERSEDED**` mark, the resume block's
  `**Next free ids**` label (the citation check finds that item by it), the ids
  (`KEY#N`, `Q-`, `A-`, `R-`, `K-...`, and on the legacy track `H-` and `G-`), the
  hypothesis statuses and tags of the hypothesis register (`open`, `confirmed`,
  `confirmed defect`, `confirmed - cause open`, `confirmed gap`, `confirmed limitation`,
  `by design`, `regression`, `rejected`; `contributing factor`, `amplifier`, `data gap`),
  the standard file names (`HYPOTHESES.md`, `INDEX.md`, `REGISTRY_SUBJECTS.md`,
  `DECISIONS.md`) and the standard folder names (`SUBJECT/`, `MEMORY/`,
  `KNOWLEDGE/`, `TICKETS/`, `_REGISTRY/`), the closing record's draft markers
  (`[DRAFT - pending implementation]`, `[DRAFT - pending the returned logs]`,
  `[DRAFT - pending the owner's walk]`) and its `status` values (`draft`, `ready`,
  `closed`), and the delivery gates' probe labels (`RESISTED`, `FIXED`, `FINDING`, with
  the severity `LOW`, `MEDIUM`, `HIGH`, `CRITICAL`). A gloss in the artifact language may
  follow a marker or a label, never replace it. The prose around them and the content of
  the rows follow the artifact language. A register a tool starts (`--init`) comes in English:
  translate its prose, never its headers. A generated file (index, ledger) stays as its
  tool writes it.

## Tool Neutrality

The content of this workspace never depends on a tool: skills, agents, docs and decisions
are plain markdown that any AI tool can read. Tool files are mount points - the tool looks
for them at the root, so they stay there, thin, each one pointing back to this file.

| Tool | Mount point (root) | Folder | What it loads |
|---|---|---|---|
| <tool> | `<CLAUDE.md / .cursorrules / .github/copilot-instructions.md>` | `<.claude/ / .cursor/ / .github/>` | pointer to `AGENTS.md`; <generated agent stubs; linked skills> |

- **Thin, always**: an adapter repeats at most the few rules that break most often and
  points here. Content never lives in an adapter.
- **Agents**: one tool-neutral file per agent in `<agents folder>`; the per-editor stubs
  are generated (`<kit>/runtime/adapters/gen-agent-stubs.py`), never written by hand.
  Skills are linked into each tool's discovery folder
  (`<kit>/runtime/sync-skills.ps1 -Level <n> -Track <legacy|greenfield>`, the level and the
  track of the adoption line).
- **Same-named skills and agents**: where another installation exposes a skill or an agent
  with a kit piece's name, this workspace uses `<skill or agent>` from <the kit plugin - OR -
  path> (<WORKSPACE-KEY>#N; names listed from <the tools' folders - OR - the session's own
  skill and agent listing>); the other copy is turned off by its owner, never deleted.
  <OR: none found on Day 1.>
- **A new tool joins in one task**: its mount point, its line in the root inventory
  (`<root inventory file, e.g. README.md>`), its column in the tool-support matrix
  (`<path of the matrix - by default a section of the root README.md>`).
- **Manual path**: a tool with no adapter is told at the start of every session "Read
  `AGENTS.md` and follow it"; a skill is used with "Follow the procedure in
  `<skills folder>/<name>/SKILL.md`"; an agent by pointing the tool at its file.
- **Roots are placeholders**: agents, skills and prompts write `{KB_ROOT}` and resolve it
  from the environment variable `KB_ROOT` before acting (fallback: `<default root>`).

## Workspace Paths

| Term | Path |
|---|---|
| Knowledge base (root) | `<knowledge-base root>` - also `{KB_ROOT}`; what `--root` and the base's version control see, in either layout |
| Layout | `<side by side: code projects next to the knowledge folder - OR - knowledge base as workspace: code trees elsewhere>` - never a code tree inside the knowledge base root, except a folder that is its own repository and that the base's version control ignores (EK#29): `<folder, its ignore rule, and its checks.scope.exclude entry>` or "none" |
| Project inventory | `<knowledge-base>/_REGISTRY/PROJECTS.md` - every project's key, folder and code tree |
| Workspace decisions | `<knowledge-base>/DECISIONS.md` (`<WORKSPACE-KEY>#N`) |
| Drafts being worked | `<knowledge-base>/prompts/` |
| Superseded material | `<in place, marked SUPERSEDED - OR - HISTORY/ with the mark>` |
| Kit (engine-kit) | `<the plugin - OR - the kit's path>` at `<tag or commit>` (<WORKSPACE-KEY>#N | A-<WORKSPACE-KEY>n while the owner has not decided the move) - the rules this file copied from the kit (this template, the profiles, the skills) are re-checked whenever it moves (the kit's `INSTALLATION.md`, "Moving to a newer kit version") |
| Derived artifacts (graphs, indexes) | `<runtime area outside the versioned base, written relative to its root (solo): a folder beside it, e.g. ../<kb-folder>-runtime/, or a folder inside it that version control ignores, e.g. .runtime/ (.gitignore or svn:ignore on the base root) - OR - versioned folder with one designated builder (team)>` |

## Placement (mechanical - do not ask)

Where a file goes is computed from the formula and the table below. When the project or
area folder is missing, **create it and register it in the same task**; do not ask. "Don't
invent" means no non-standard names and nothing dumped in the root - it does not mean
"leave the standard folder uncreated". A new file in the root is a file in the wrong place.

| Kind | Formula | Example | Key |
|---|---|---|---|
| <product version> | `<projects/<product>-<major.minor>/>` | `<projects/acme-orders-2.1/>` | `<ACME-2.1>` |
| *situational* - <client overlay> | `<clients/<client>/<product>-<major.minor>/>` | `<clients/acme-north/acme-orders-2.1/>` | `<ACME-NORTH-2.1>` |
| <new product, no version line yet> | `<projects/<product>/>` | `<projects/acme-orders/>` | `<ORDERS>` |

- Never mix versions: one project per version line; a new major line is a new row and key.
- The owner of the work owns the file: <a client's work item goes to the client overlay
  project even when the code change is in the shared product>.
- Reuse the area catalog of the project; create `SUBJECT/<NAME>/` there when it is missing.
- Work items are worked directly in `<project>/SUBJECT/<NAME>/TICKETS/<ID>/`, never in a
  personal folder copied in later.

| The new file is... | It goes to |
|---|---|
| Source code, build or database scripts | `<the code project>` - never the knowledge base, except a prepared change's patches in `TICKETS/<ID>/PATCH/` until a person applies them (change-gate) |
| A decision of one project | `<project>/_REGISTRY/DECISIONS.md` (`KEY#N`) |
| *level 2* - What one session found | `<project>/SUBJECT/<NAME>/MEMORY/YYYY-MM-DD-<topic>.md` |
| *level 3* - A rule that holds for the next ticket | `<project>/SUBJECT/<NAME>/KNOWLEDGE/<version>_<Entity>_<ShortRule>_<YYYY-MM-DD>.md` (id `K-YYYYMMDD-HHMM` in its front matter) |
| Anything made while working a work item | `<project>/SUBJECT/<NAME>/TICKETS/<ID>/` |
| *situational* - A client's specifics for an agent | `<client project>/<notes folder>/<topic>-notes.md` |
| <kind of file> | <destination> |

## Area Model

Every business domain of a project is an area. All work on it lives inside
`SUBJECT\<NAME>\`; the project's areas are listed in its `REGISTRY_SUBJECTS.md`.

```
SUBJECT\<NAME>\
+-- INDEX.md      <- read this first: what the area is; links the cards and the logs
+-- PIPELINES\    <- documented execution flows (no fix is designed on an unmapped flow)
+-- SETTINGS\     <- settings that affect this area
+-- MEMORY\       <- episodic session logs written by agents, with claims (level 2)
+-- KNOWLEDGE\    <- atomic cards: one reusable rule per file, the quotable tier (level 3)
+-- RULES\        <- business rules: current rule + append-only authorised/denied history
+-- TICKETS\<ID>\ <- one work item's folder: dossier, plan or spec, evidence, review
```

Three memory grains: a MEMORY log says *what one session found*; a KNOWLEDGE card says
*the rule that holds for the next ticket*; the INDEX says *what the area is* and links both.

Active areas: <NAME>, <NAME> - <OR: none yet; on the greenfield track none before Round 0
closes> (status per area: `<project>/REGISTRY_SUBJECTS.md`)

## Code Graphs (optional layers) - level 3

Query a code graph before reading source files. A case keeps one graph per layer it
needs - one graph for a single codebase, or layers such as:

| Layer | Location | Use when |
|---|---|---|
| base | `<graphs-location>\base\` | Understanding the behaviour shared by every variant |
| overlay | `<graphs-location>\<variant>\` | What one variant added or overrode |
| merged | `<graphs-location>\<variant>\merged\` | What actually runs for that variant (base + overlay) |

Always query the layer that matches the question. Keep graph binaries where the
derived-artifacts row of Workspace Paths says - never versioned in a solo case, built by
the designated builder only in a team case; register every graph in `REGISTRY_GRAPHS.md`.

## Memory Protocol - level 2

After analysis work, write a session log to
`SUBJECT\<NAME>\MEMORY\YYYY-MM-DD-<topic>.md` with front matter: `project: <KEY>`, the
area, and claims (each claim: text, `status` fact | inference | hypothesis, `confidence`,
`evidence`), plus what was verified and what still needs investigation.

*level 3*: before acting on an area, query the memory index
(`runtime/memory_index.py query`) for its entities and tickets. Record corrections,
misses, wrong outputs and collisions no map covered as typed claims
(`type: correction | missed | wrong | collision`, with `agent:`) so the feedback-analyst
can mine them. Every fact at 0.8 or more gets a card decision (archive-card): a fact
that will hold for the next task becomes a card in `KNOWLEDGE\`.

## People are not roles

Never infer a person's role from a tracker field (<assigned to, requester, created by>),
from comment activity or from query ownership. A role comes only from
`<knowledge-base>/_REGISTRY/PEOPLE.md` (each row confirmed by the owner) or from a signed
document. Otherwise write the role without a name ("the project manager", "QA", "the
requester") or "owner to be assigned at the review". A name may be quoted as a field value
("Assigned to: X"), never as "X, the project manager". This rule is stated here once;
skills and agents point to this section.

## Client specifics behind pointers - situational (client overlays)

Agents and skills are client-neutral: no client name, path or client-only value in them.
An agent that needs one client's facts resolves the client from the task and reads that
client's notes file - `<client project>/<notes folder>/<topic>-notes.md` - before
advising; when the file is missing, it creates it from the template section at the end of
the agent and links it from the client project's `INDEX.md`. Client list for the leak
check of this layer: `<file outside the AI layer>`.

## Governance (engine method - mandatory)

| Skill (engine-kit) | Mandatory when |
|---|---|
| `kb-setup` | A new tool, project, area or file whose destination is not obvious |
| `scope-census` | Every new or touched knowledge doc gets one `**Scope**:` line |
| `conceptual-guardian` | Before creating, altering or naming any domain object (table, shared piece, module, business concept, pipeline entity) |
| `decision-rounds` | Architecture or business choices - numbered questions, the owner decides |
| `retain-knowledge` | End of any task that produced knowledge (registry + rules + memory + SUPERSEDED chain) |

Every agent of this workspace ends with the standard governance block (Scope line,
guardian before a domain object, decision rounds for choices, retention chain in the same
task, prepare-only for the irreversible): the last section of the kit's
`templates/AGENT.template.md`, copied verbatim and never edited. New agents start from
`<the case's copy of the agent template>`.

Workspace decisions live in `DECISIONS.md` (numbered, permanent, never renumbered);
a project's decisions live in its own register (`KEY#N`).

**Prepare-only**: agents prepare <commit, merge, deploy, publish, tracker writes, database
writes>; a human executes them. Nothing is <committed, published, seeded or deployed>
without the owner's release word.

After touching any registry, run `python <kit>/runtime/registry/projects_check.py --root <knowledge-base>`;
*level 3*: also `<kit>\runtime\validate-registry.ps1 -Root <knowledge-base>`.

## What to Never Do

- Commit secrets, credentials, or `.env` files
- Add anything to the root without its line in the root inventory
- Put content in a tool adapter, or write an agent stub by hand
- Open or print graph binaries - use the indexer's query commands
- Assume an overlay behaves like the base without checking the merged layer
- Name a client in an agent or a skill, or write a role the people registry does not confirm
- Delete or renumber a registered decision, or delete superseded docs - mark them `SUPERSEDED`
