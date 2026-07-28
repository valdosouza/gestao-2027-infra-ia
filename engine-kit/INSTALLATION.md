# Installing the Kit in a New Case — executable step-by-step

**Scope**: method
**Example scenario used below**: installing at `<company>` (e.g., Softworks),
workspace `C:\<company>\` with the legacy repository at `C:\<company>\<legacy-repo>\`,
where code-indexing tools, AI memory, and Obsidian already exist. Adapt the paths.

---

## Before leaving home (5 min)

1. Copy the entire `engine-kit/` folder to a medium of YOUR OWN (private personal repo
   or flash drive) — the kit is the method, and the method is yours.
2. Verify that NOTHING beyond the kit goes along: no file from another case. Quick
   test: search for the previous case's names inside the copy — it must return zero.

> **As a Claude Code plugin**: the kit follows the Claude Code plugin layout
> (`.claude-plugin/plugin.json` + `skills/*/SKILL.md` + `agents/`). If the case uses
> Claude Code, you can install it directly as a plugin from your private repo/
> marketplace so the skills auto-trigger — the manual copy below remains the
> tool-agnostic path.

## Day 1 — build the vessel (30–60 min, without touching code yet)

### Step 1 — Create the knowledge base

In the company's workspace:

```powershell
# workspace root (adjust)
cd C:\<company>
New-Item -ItemType Directory -Force knowledge-base
New-Item -ItemType Directory -Force knowledge-base\generic-skills
New-Item -ItemType Directory -Force knowledge-base\<legacy-repo>       # project mirror
New-Item -ItemType Directory -Force knowledge-base\prompts
New-Item -ItemType Directory -Force knowledge-base\HISTORY
```

The name `knowledge-base` is a suggestion — use whatever makes sense at the company.
What is NOT negotiable: a single folder, a mirror per project, and the process
subfolders (`prompts/`, `HISTORY/`).

### Step 2 — Install the kit inside it

```powershell
Copy-Item <kit-source>\skills\*                 knowledge-base\generic-skills\ -Recurse
Copy-Item <kit-source>\docs\KNOWLEDGE-BASE-STRUCTURE.md  knowledge-base\
Copy-Item <kit-source>\README.md                knowledge-base\ENGINE-README.md
```

(The git security package now lives at `skills/git-security/` and comes along with the
skills copy.)

### Step 3 — Create the rules file at the root

Create `C:\<company>\CLAUDE.md` (or the rules file of the AI tool used there) from the
template in `docs/KNOWLEDGE-BASE-STRUCTURE.md`, filling in:
- `<Case>` → the company's name
- scope rule → `method | <company> | mixed` (e.g., `method | softworks | mixed`)
- "Current state" section → one line per project, even if it is just "assessment not
  started"

### Step 4 — Create the central index

Create `knowledge-base\CENTRAL_INDEX.md` from the template. Version 1.0, first history
line: `<date> | Knowledge base created + engine kit installed | 1.0`. From here on,
EVERY change to the base goes through the index (the `retain-knowledge` skill).

### Step 5 — Connect the tools that already exist

A tool is not thrown away — it is registered and governed:

| Already exists | What to do |
|---|---|
| Obsidian | Open `knowledge-base\` as a vault (or include the folder in the current vault). `[[wiki-style]]` links work natively |
| Code indexer (graph/search) | Register it in the central index as a Phase 1 resource (name, where it runs, what it indexes). It is the engine of Phase 1.0 |
| AI tool memory | Register it in the index. Rule: the TOOL stores; the `retain-knowledge` skill decides WHAT and WHERE — memory without a process becomes noise |
| Documentation already generated (by the indexer or by hand) | Do NOT redo it: move/link it into the project's mirror in the base and run the **census** over it (step 6) |

### Step 6 — Census of the existing collection

Run the `scope-census` skill over every `.md` the company already has in the base:
values `method | <company> | mixed`. Output: a summary table in the central index.
(If the collection is large, use the parallel fan-out described in the skill.)

**End of Day 1**: vessel built, tools connected, collection classified. Not a single
line of code read yet — and that is exactly right.

## Day 2+ — plug the engine into the legacy system

### Step 7 — Size the repository (Phase 1.0)

```powershell
cd C:\<company>\<legacy-repo>
# volume per extension (adjust the extensions to the local stack)
Get-ChildItem -Recurse -Include *.pas,*.dfm,*.sql,*.cs,*.vb |
  Group-Object Extension |
  Select-Object Name, Count, @{n='Lines';e={($_.Group | Get-Content | Measure-Object -Line).Lines}}
```

Record in the project's mirror: total files/lines per language, apparent modules, age.
**Decision rule**: if it cannot be read within a few sessions (millions of lines),
Phase 1 runs ONLY on top of the code index — direct reading is sampling in disguise.

### Step 8 — Define units of analysis and pick the pilot

List the units (module, screen, entity, integration) in a table with status
`pending | under analysis | documented` in the project's mirror. Pick **ONE** pilot
unit — small, but end-to-end (e.g., an entity that is born on a screen, is written to
the database, and comes out in a report). No big bang.

### Step 9 — Run Phase 1 on the pilot

Use the `assess-legacy-repo` skill as the agent's prompt: fill in the
parameterization table (source/target stack, reading order, discard warnings) and have
it analyze ONLY the pilot unit. Output: a doc with the 7 sections in the project's
mirror, `**Scope**: <company>`.

### Step 10 — Close the first full cycle

1. The pilot's structures suspected of being scale models → an opinion via the
   `conceptual-guardian` skill
2. The route choices → the first round via the `decision-rounds` skill.
   **Explicitly define who owns the decisions in this case** (you? the manager? the
   company's architect?) — without a named owner, the method does not work.
3. When finishing: the `retain-knowledge` skill (index + root rules + memory)
4. What you learned about the METHOD (not about the company) → note it down to bring
   back, distilled, to the product journal and the kit

**Installation success criterion**: one full cycle (assess → conceptualize → decide →
retain) run on a pilot unit, with everything recorded in the base. From there on it is
repetition at scale.

## What to NEVER do

- Bring any content from another case (not even "just one example") — the kit already
  contains the anonymized examples the method needs
- Put the company's knowledge base in YOUR personal repo, or the kit (your method)
  mixed into the company's repo without clarity — case content belongs to the company;
  the method is yours; the boundary stays clean when each lives in its own home
- Skip the census "because the collection is small" — it is cheap and it is what keeps
  the boundary above auditable
- Start rewriting code before the pilot's first full cycle
