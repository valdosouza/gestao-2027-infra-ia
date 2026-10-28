# Installing the kit in a new case - executable step by step

**Scope**: method
**Example scenario used below**: installing at `<company>`, workspace `C:\<company>\`,
with the legacy repository (legacy track) at `C:\<company>\<legacy-repo>\`, where
code-indexing tools, AI memory and a note-taking vault may already exist. Adapt the paths.

---

## Choose first: track, profile, level (5 min)

Three independent choices, made before anything is installed and recorded on Day 1
(step 4):

| Choice | Options | Read |
|---|---|---|
| **Track** | **legacy** - a system already runs and is to be understood, changed or replaced; **greenfield** - the project starts from a draft or an idea | [profiles/legacy.md](profiles/legacy.md), [profiles/greenfield.md](profiles/greenfield.md) |
| **Team profile** | **solo** - one person writes in the knowledge base; **team** - several do (where derived artifacts live and who builds them, [EK#5](DECISIONS.md)) | [profiles/solo.md](profiles/solo.md), [profiles/team.md](profiles/team.md) |
| **Adoption level** | **1 Essential** on Day 1, always; **2 Governed** from the first front; **3 Scale** past ~50 documents, ~500 legacy files or a second person. A single piece of a higher level is borrowed by its own decision (an assumption to ratify while no owner is named, step 4) and listed in the adoption line (`borrowed:`); the level stays | [docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md) |

| | Legacy track | Greenfield track |
|---|---|---|
| **Day 1** (level 1) | The vessel + the census of the existing collection (steps 1-7) | The vessel (steps 1-7; the census only over documents that already exist) |
| **Entry** (level 1) | Assess: size -> index -> pilot unit (steps L1-L3), then conceptualize -> decide: the guardian and Round 0 on the front prompt's skeleton (step L4) | Frame: draft -> Round 0 on the front prompt's skeleton -> closed prompt (steps G1-G2) |
| **Then** (level 2) | The cycle per front (steps L5-L6) | The same cycle (steps G3-G4) |
| **Success** | One full cycle on a pilot unit, everything recorded | One front from draft to delivery through the gates, decisions recorded |

A new project starts at level 1 whatever its size: about ten skills, not thirty. A
higher level is turned on by a decision when its trigger is met, never by default.

## Before leaving home (5 min)

1. Get the kit from its canonical home (the `engine-kit/` folder of the method author's
   workspace repository - see [DECISIONS.md](DECISIONS.md), EK#32) at a release tag - or a
   commit when no tag fits - and note which: `git -C <kit> remote -v` names the
   repository that holds it (on a local clone without a remote it prints nothing and does
   not fail: record the kit's path instead), `git -C <kit> describe --tags --always` the tag or
   commit, and `git -C <kit> status --short` must print nothing (as a plugin: the version
   `/plugin` lists). Day 1 records it with the other choices (step 4). Never copy the kit
   out of another case's workspace: copies drift.
2. Nothing else goes along: no file from another case. Keeping case content out of the
   kit is its author's release check - the leak check against every earlier case's
   deny-list, run before a tag is cut ([AGENTS.md](AGENTS.md)). An adopter has none of
   those lists and runs no such check: the tag or commit of item 1 is the guarantee.

> **As a Claude Code plugin**: the kit's folder is also a plugin marketplace
> (`.claude-plugin/marketplace.json`). In Claude Code: `/plugin marketplace add <kit folder>`
> then `/plugin install engine-kit@engine-kit`, and the skills auto-trigger. The kit is
> one plugin ([EK#21](DECISIONS.md)) that installs the pieces of every level; the case's
> adoption line (step 5) keeps a higher-level piece from running unasked
> ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md)). Any other tool: link the skills of
> the case's level (step 2, `sync-skills.ps1 -Level`) or use each one by its path - the
> tool-agnostic path.

## Day 1 - both tracks: build the vessel (30-60 min, without touching code yet)

Level 1. Steps 1-5 follow the [`kb-setup`](skills/kb-setup/SKILL.md) skill, whose Day 1
runs in the same order; its full layout is
[docs/KNOWLEDGE-BASE-STRUCTURE.md](docs/KNOWLEDGE-BASE-STRUCTURE.md). The order matters:
each step writes what the next one cites - the projects registry, then the registers, then
the decisions, then the `AGENTS.md` line that cites them.

### Step 1 - Create the knowledge base

One versioned folder for the company's knowledge (the name is a suggestion), with one
project folder per code project - code stays in the project, knowledge in its mirror -
and the area model inside each project (`SUBJECT\<AREA>\` with INDEX, PIPELINES,
SETTINGS, MEMORY, KNOWLEDGE, RULES, TICKETS). An area is created when its first document
needs it, never in advance. On the greenfield track no area exists before Round 0 closes
(step G2): an area names a domain concept, and that waits for the owner's answers. Check
that the folder really is under version control: a global ignore pattern can silently keep
every `.md` out, and a common global `*.log` exclude keeps out the run logs the test gate's
evidence names by path - an ignored file is neither versioned nor reported as unversioned,
so the close script never sees it. Probe both before the first document lands:
`git -C <kb-root> check-ignore -v probe.md TICKETS/probe/TESTS/logs/probe.log` must print
nothing (it prints the rule that ignores a path; the paths need not exist; on another
version control, its own ignore listing over two probe files). If the log is ignored, keep
the run logs as `.txt` files (or inside the evidence file).

That folder is the **knowledge-base root** in both layouts of
[`kb-setup`](skills/kb-setup/SKILL.md): `AGENTS.md`, the registers and the mirrors live in
it, and it is what `--root`, `KB_ROOT` and its version control see. Code trees stay outside
it - beside it (side by side) or elsewhere (knowledge base as workspace) - never inside: a
code tree versioned on its own, or read-only like a legacy repository, would otherwise land
in the base's repository and in every check run with `--root`. One exception
([EK#29](DECISIONS.md)): a code tree in a folder inside the base that is **its own
repository and that the base's version control ignores** (`/app/` in the base's
`.gitignore`, or `svn:ignore` on the base root - read the property first, as for a solo
runtime folder: [profiles/solo.md](profiles/solo.md#a-runtime-folder-inside-the-base)).
The projects registry names it in its `Code tree` cell, and the checks that walk the base
folder exclude it: the close script's `checks.scope.exclude` and
`checks.retired.normative.exclude`, the validator's `-ExcludePattern`
([close script](runtime/close/README.md#a-code-tree-inside-the-base)). Check the ignore rule
before the first file lands there (`git -C <kb-root> check-ignore -v app/probe`).

### Step 2 - Install the kit for it

**First, same-named skills and agents.** Another installation may already expose skills or
agents with the kit's names (an older copy, another plugin). Both copies then load - a
plugin's skill or agent is namespaced (`engine-kit:<name>`), a folder's is not - and
nothing says which one triggers. Before installing, list them in the discovery folders of
every tool in use (user and project; adapt the folders below) and among the installed
plugins (`claude plugin list`):

```powershell
$kit = (Get-ChildItem '<kit>\skills' -Directory).Name
$kitAgents = (Get-ChildItem '<kit>\agents' -Filter *.md).BaseName
Get-ChildItem "$HOME\.claude\skills", '.claude\skills', "$HOME\.cursor\skills" -Directory -ErrorAction SilentlyContinue |
  Where-Object Name -in $kit | Select-Object FullName
Get-ChildItem "$HOME\.claude\agents", '.claude\agents' -Filter *.md -ErrorAction SilentlyContinue |
  Where-Object BaseName -in $kitAgents | Select-Object FullName
```

When the tool's configuration folders may not be read (a managed machine, privacy, the
boundary of the task), compare the kit's names with the list of skills and agents the AI
tool itself exposes in the session instead - its skill and agent listing - and say which
source was used. For each name found, decide which copy the case uses: step 4 records it,
with the source of the list, and `AGENTS.md` says it (section Tool Neutrality). The other
copy is turned off by whoever owns it; the installer never deletes it.

Then install the kit as a plugin (see "Before leaving home"), or link its skills with
[`runtime/sync-skills.ps1`](runtime/sync-skills.ps1) for other tools, with `-Level <n>` and
`-Track <legacy|greenfield>` of the case's adoption line
([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md)) - `-WhatIf` first: a real folder with a
kit skill's name is moved aside to `_pre-junction-backup\`.
Do not copy the kit into the knowledge base: copies drift. To set up a person's machine,
use the [`env-setup`](agents/env-setup.md) agent - it records every machine change in the
[install journal](runtime/install-journal/README.md) so it can be undone (a team case; a
solo case can do it by hand).

### Step 3 - Create the registers

In this order, from the templates:

1. The project inventory, `_REGISTRY/PROJECTS.md`
   ([`REGISTRY_PROJECTS`](templates/REGISTRY_PROJECTS.template.md)): the workspace row
   (`<WORKSPACE-KEY>`, Path `.`) and one row per project, with the front-matter keys of the
   case's profile (solo: the generated files in the runtime area, outside the versioned
   base - [profiles/solo.md](profiles/solo.md)). Every
   other register tool reads it, so it comes first.
2. The decision registers: `python runtime/registry/decisions_index.py --root <kb-root> --init <WORKSPACE-KEY>`
   writes the workspace's `DECISIONS.md`, and `--init <KEY>` each project's register
   ([`DECISIONS`](templates/DECISIONS.template.md)).
3. Per project, the area registry
   ([`REGISTRY_SUBJECTS`](templates/REGISTRY_SUBJECTS.template.md)) - an empty table until
   the first area - and, if code graphs are used (level 3),
   [`REGISTRY_GRAPHS`](templates/REGISTRY_GRAPHS.template.md).

Indexes are generated by the [`runtime/registry/`](runtime/registry/README.md) tools, never
edited by hand; [`runtime/validate-registry.ps1`](runtime/validate-registry.ps1) keeps the
registers honest once the base grows (level 3).

### Step 4 - Record the choices

The workspace gets its first choices:

1. The track, the team profile and **level 1**, with the trigger that will move it to
   level 2.
2. Each piece of a higher level borrowed now - one choice each: which piece, why now
   ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md), rule 4 of the placement).
3. The artifact language: the language the owner writes in, unless the owner fixes another;
   the chat follows the user. What stays in English because the kit's tools and skills read
   it is listed in the Core Rules of the [`AGENTS` template](templates/AGENTS.template.md).
4. The kit's source (the tag or commit of "Before leaving home", or its path) and, for each
   same-named skill or agent of step 2, the copy the case uses and the source of the list.
5. **Who owns the decisions - only when a signed document names them.** Otherwise Day 1
   records nothing about it: the owner is the first question of Round 0 (step G1 on the
   greenfield track, step L4 on the legacy track), so that nobody is named for the owner.

**Decisions or assumptions.** With a signed document naming the owner, items 1-4 are the
owner's decisions, `<WORKSPACE-KEY>#N` in the workspace register. Without one, nobody can
decide them yet: a recommendation followed before the owner answers is an assumption, never
a decision ([`decision-rounds`](skills/decision-rounds/SKILL.md), the assumption ledger). So
each choice of items 1-4 is an assumption `A-<WORKSPACE-KEY>n` - the option taken, where it
is applied, how to undo it - written in the "Assumptions - to ratify" section of the prompt
that will carry Round 0 (`prompts/prompt_<name>.md`, started now on the
[`FRONT_PROMPT`](templates/FRONT_PROMPT.template.md) skeleton, its section 8, on both
tracks - [EK#25](DECISIONS.md); step G1 or L4 fills the rest), cited by that id until
Round 0 asks the owner to ratify it; the ratifying decision
cites it (`A-<WORKSPACE-KEY>1` -> `<WORKSPACE-KEY>#1`). The workspace register is still
created on Day 1 (step 3); it stays empty until then. A case that registered its Day-1
choices as decisions before an owner was named (an earlier kit version allowed it) keeps
those rows - a decision is never renumbered or deleted - and asks the owner to ratify them
in the workspace block of the next round; the ratifying answer cites each row.

### Step 5 - Create the root rules and the thin adapters

Create `AGENTS.md` at the root of the knowledge base from
[`templates/AGENTS.template.md`](templates/AGENTS.template.md): placement formula,
area model, scope rule `method | <case-key> | mixed` (e.g. `method | acme | mixed`), the
artifact language, people are not roles, client specifics behind pointers, prepare-only.
The case's key is the Scope value of its documents; `case` is equally valid
([EK#2](DECISIONS.md)). A case key is written once in `caseValues` of the close
configuration (`.engine-kit/close.json`, [`runtime/close/`](runtime/close/README.md)) and in
`scope_value` of the projects registry, so that the checks accept it and the generated files
carry it. Near the top of `AGENTS.md`:

1. The adoption line, citing the decisions - or the assumptions - of step 4
   ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md#how-a-case-turns-a-level-on-today)):
   `**Adoption**: level 1 (<WORKSPACE-KEY>#N | A-<WORKSPACE-KEY>n) - track <legacy|greenfield> - profile <solo|team> - borrowed: <piece (KEY#N | A-KEYn), ... | none>`,
   with its rule: a piece of a higher level is named and asked for, never run unasked.
2. The derived-artifacts row, by profile: solo - a runtime area outside the versioned base,
   beside it or in a folder inside it that version control ignores (for example
   `.runtime/`, [EK#27](DECISIONS.md); how to ignore it: [profiles/solo.md](profiles/solo.md));
   team - the versioned folder and the designated builder.

The template is one for every case; a solo case at level 1 leaves out the sections and rows
it marks as later-level or situational (its note says which).

Each AI tool gets a thin adapter that only points to it (`CLAUDE.md`, `.cursorrules`, ...);
agent stubs come from [`runtime/adapters/gen-agent-stubs.py`](runtime/adapters/gen-agent-stubs.py).
No `.engine-kit/guards.json` yet: the hooks stay silent until level 3.

### Step 6 - Connect the tools that already exist

A tool is not thrown away - it is registered and governed:

| Already exists | What to do |
|---|---|
| Note-taking vault (e.g. Obsidian) | Open `knowledge-base\` as a vault (or include the folder in the current vault). `[[wiki-style]]` links work natively |
| Code indexer (graph/search) | Register it in the central index as a resource (name, where it runs, what it indexes). It is the engine of the sizing and reading of a large legacy (step L1) |
| AI tool memory | Register it in the index. Rule: the TOOL stores; the `retain-knowledge` skill decides WHAT and WHERE - memory without a process becomes noise |
| Documentation already generated (by the indexer or by hand) | Do NOT redo it: move/link it into the project's mirror in the base and run the **census** over it (step 7). A document inside a read-only code tree is linked, never moved; the census classifies it by path ([`scope-census`](skills/scope-census/SKILL.md), linked legacy documents) |

### Step 7 - Census of the existing collection

Run the [`scope-census`](skills/scope-census/SKILL.md) skill over every `.md` the company
already has in the base: values `method | <case-key> | mixed`. Output: a summary table in
the central index. (If the collection is large, use the parallel fan-out described in the
skill.) Legacy track: always. Greenfield track: over whatever already exists - the draft,
its notes, any earlier document; with nothing written yet, every new document is simply
born with its Scope line.

Day 1 ends with the close script at this level:
`python runtime/close/close.py --root <kb-root> --level 1` (or `"level": 1` in
`<kb-root>/.engine-kit/close.json`).

**End of Day 1**: registers and choices recorded, vessel built, tools connected, collection
classified. Not a single line of code read yet - and that is exactly right.

## Day 2+ - legacy track: plug the engine into the legacy system

### Step L1 - Size the repository

Count files and text lines per extension, binaries apart: the text-only command is in
[`assess-legacy-repo`](skills/assess-legacy-repo/SKILL.md) section 1 (a plain line count of a
binary file is noise).

Record in the project's mirror: total files/lines per language, apparent modules, age.
**Decision rule**: if it cannot be read within a few sessions (millions of lines), the
assessment runs ONLY on top of the code index - direct reading is sampling in disguise.
More than ~500 files is a level-3 trigger met before the first front: the code graph
([`runtime/graph/`](runtime/graph/README.md)) comes before any reading - borrow it by a
decision, or move up ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md#moving-up)).

### Step L2 - Define units of analysis and propose the pilot

List the units (module, screen, entity, integration) in a table with status
`pending | under analysis | documented` in the project's mirror. Propose **ONE** pilot
unit - small, but end-to-end (e.g., an entity that is born on a screen, is written to
the database, and comes out in a report). No big bang. Choosing the pilot is the owner's
call: the proposal is assessed in step L3 and decided in Round 0 (step L4), with the
assessment as its evidence; if the owner picks another unit, step L3 runs on that one.

### Step L3 - Assess the pilot

Use the [`assess-legacy-repo`](skills/assess-legacy-repo/SKILL.md) skill as the agent's
prompt (or the [`legacy-analyst`](agents/legacy-analyst.md) agent): fill in the
parameterization table (source/target stack, reading order, discard warnings) and have
it analyze ONLY the pilot unit. Output: a doc with the nine sections of the skill's
section 3 in the project's
mirror, `**Scope**: <case-key>`. A claim from a legacy document or comment goes to the
hypothesis register ([`HYPOTHESES`](templates/HYPOTHESES.template.md)) until the code
confirms it; a legacy database is read only through the read-only probe
([`runtime/data-probe/`](runtime/data-probe/README.md)). When the header's hygiene line
finds a credential or personal data, it names where (never the value) and the finding goes
to a [`SENSITIVE_DATA_REPORT`](templates/SENSITIVE_DATA_REPORT.template.md) (level 1,
situational).

### Step L4 - Conceptualize and decide

1. The pilot's domain objects - the structures suspected of being scale models, and every
   new name checked against the occupied words
   ([`OCCUPIED_WORDS`](templates/OCCUPIED_WORDS.template.md)) -> an opinion via the
   [`conceptual-guardian`](skills/conceptual-guardian/SKILL.md) skill, written in section 4
   of the prompt below. The guardian is a level-1 piece on both tracks
   ([EK#25](DECISIONS.md)): no borrowing decision.
2. The owner's request, when it is a document (a brief, a request, a master prompt): as on
   the greenfield track (step G1), copy it into `prompts/` byte-identical (copy the file,
   never its pasted text) and record its hash in the header of the prompt below; the census
   classifies the copy as a frozen source and never edits it, and the original stays the
   owner's. Do it when the document arrives - on Day 1 if it is there - so that its lines
   can be cited.
3. The route choices -> Round 0 via the
   [`decision-rounds`](skills/decision-rounds/SKILL.md) skill. Round 0 lives in the front's
   prompt, `prompts/prompt_<name>.md`, built on the
   [`FRONT_PROMPT`](templates/FRONT_PROMPT.template.md) skeleton - the same file and the
   same skeleton as on the greenfield track ([EK#25](DECISIONS.md)): the assessment's facts
   in its section 2, the guardian's opinion in section 4, the questions in section 7, the
   Day-1 assumptions in section 8 and the resume block
   ([`RESUME_BLOCK`](templates/RESUME_BLOCK.template.md),
   [`front-protocol`](skills/front-protocol/SKILL.md) section 3) in section 12. It goes on
   as the living front prompt when level 2 turns on (step L5). Unless Day 1 recorded the
   owner from a signed document (step 4), its first question is **who owns the decisions
   in this case** (you? the manager? the company's architect?) - without a named owner,
   the method does not work. Round 0 also ratifies the Day-1 assumptions (step 4) and
   decides the pilot proposed in step L2. A Round 0 prompt written before this skeleton
   (an earlier kit version) moves to it at its next save: its answered rounds go verbatim
   to the `-rounds.md` annex ([`front-protocol`](skills/front-protocol/SKILL.md) section
   1.4) and the rest is rebuilt on the skeleton, its ids kept.
4. The round that closes the prompt - Round 0, or the later round that answers what Round 0
   left open - carries in the same batch the move to level 2 and the first wave's plan (the
   pilot's first change - on legacy, the round that settles it), its questions first walked
   against the go-live list (recovery of access, data at rest and backups, open items carried
   over, who operates it) and with the confirmations its gate needs (the settings patterns),
   written on the recommended answers and marked "rewritten if any answer differs"; the code gate's go on that plan is asked there, on a line of its
   own (an approval, no `Q-` id) ([EK#26](DECISIONS.md); the procedure:
   [`decision-rounds`](skills/decision-rounds/SKILL.md),
   [`change-gate`](skills/change-gate/SKILL.md)).

### Step L5 - Run the cycle per front (level 2)

When a recorded decision calls for a change on the pilot, the first front opens - the 1 -> 2
trigger ([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md#moving-up)). Level 2 is not
automatic: the round that closes the prompt carried the question with the first wave's
plan (step L4, item 4), the owner's answer becomes `<WORKSPACE-KEY>#N`, and the adoption
line changes. When the go was given and every other answer followed its recommendation,
the plan stands as written; when an answer differs, the plan is rewritten and its go asked
again. The front runs from
one living prompt - Round 0's prompt, continued
([`FRONT_PROMPT`](templates/FRONT_PROMPT.template.md),
[`front-protocol`](skills/front-protocol/SKILL.md)); every change passes the
[`change-gate`](skills/change-gate/SKILL.md) (plan, spec or red test first, a literal
STOP, the owner's go logged; with no tracker, the wave is the work item, `<NS>-W<n>`, as on
the greenfield track), the [`test-gate`](skills/test-gate/SKILL.md) and the
[`delivery-gates`](skills/delivery-gates/SKILL.md). A new system that replaces the legacy
while it keeps running follows [`migration-direction`](skills/migration-direction/SKILL.md).

### Step L6 - Retain

1. When finishing: the [`retain-knowledge`](skills/retain-knowledge/SKILL.md) skill
   (index + root rules + memory); for a work item,
   [`close-and-retain`](skills/close-and-retain/SKILL.md). Both end with
   `runtime/close/close.py` (`"level": 2` in `.engine-kit/close.json`).
2. What you learned about the METHOD (not about the company) -> one line, within the
   session, in the case's outbox for the kit: `JOURNAL-for-kit.md` at the root of the
   base, with the columns of the kit's journal (date, insight, origin, landed in), in the
   case's artifact language. The kit's author pulls the open lines into the kit's
   `JOURNAL.md`, distilled into English, and says where each landed - the kit piece and the
   kit version that carries it; an adopter never writes in the kit ([EK#1](DECISIONS.md),
   [`retain-knowledge`](skills/retain-knowledge/SKILL.md) section 2).

**Installation success criterion (legacy)**: one full cycle (assess -> conceptualize ->
decide -> retain) run on a pilot unit, with everything recorded in the base. From there on
it is repetition at scale.

## Day 2+ - greenfield track: frame the project

### Step G1 - Frame the draft

Copy the draft - loose notes, a master prompt, a pasted schema - into `prompts/`
byte-identical (copy the file: pasting its text changes the encoding and the line endings)
and record its hash beside it, in the organised prompt's header (for example
`Get-FileHash -Algorithm SHA256 <file>`); the census classifies the copy as a frozen
source and never edits it (step 7, [`scope-census`](skills/scope-census/SKILL.md)). The original is the owner's
(the close script recognises it while it is byte-identical to the copy; a file the owner hands over to keep
as received goes into `checks.scope.frozen` by path):
where it stays and when it moves - to `HISTORY/` or anywhere else - is the owner's act. The
[`frame-greenfield`](skills/frame-greenfield/SKILL.md) skill organises the copy without
rewriting it: what is unclear gets a mark, not a guess. The first round, Round 0, follows
[`decision-rounds`](skills/decision-rounds/SKILL.md): every question with its evidence,
closed options and one recommendation. Unless Day 1 recorded the owner from a signed
document (step 4), Round 0 opens with **who owns the decisions in this case** - without a
named owner, the method does not work. Who owns the decisions and the release word are asked
in the workspace block of the front prompt (section 7.1) and become `<WORKSPACE-KEY>#N`.

### Step G2 - Close Round 0

The owner's answers become `KEY#N` in the project's register; a recommendation followed
before the owner answers is an assumption to ratify, never a decision. The result is a
closed prompt and its requirements ([`REQUIREMENTS`](templates/REQUIREMENTS.template.md)),
written from the document, not from code. The closed prompt stays in `prompts/` as the
living front prompt (step G3) and moves to the owning project's mirror only at the front's
close ([`front-protocol`](skills/front-protocol/SKILL.md), "Lifecycle of a front"). The
frozen copy of the draft goes to `HISTORY/` at the front's close too, with a
pointer to the closed prompt ([`frame-greenfield`](skills/frame-greenfield/SKILL.md)
section 7); the owner's original moves when the owner chooses (step G1). From here on an
area may be created, each when its first document needs it.

The round that closes the prompt - Round 0, or the later round that answers what Round 0
left open - carries in the same batch the move to level 2 and the first wave's plan, its
questions first walked against the go-live list (recovery of access, data at rest and
backups, open items carried over, who operates it), written on the recommended answers and marked "rewritten if any answer differs"; the code
gate's go on that plan is asked there, on a line of its own (an approval, no `Q-` id) ([EK#26](DECISIONS.md);
the procedure: [`decision-rounds`](skills/decision-rounds/SKILL.md),
[`change-gate`](skills/change-gate/SKILL.md)). No production behaviour before that go -
the failing tests of a test-first red and a new unit's stub may exist before it
([EK#28](DECISIONS.md)) - and nothing leaves the working copy before the owner's release
word.

### Step G3 - Run the first front through the gates (level 2)

The closed prompt is the 1 -> 2 trigger
([docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md#moving-up)), measured by the prompt's
State line, not by a release word. Level 2 is not automatic: the round that closed the
prompt carried the question with the first wave's plan (step G2), the owner's answer
becomes `<WORKSPACE-KEY>#N`, and the adoption line changes. The front runs from one living
prompt - the framing's prompt, continued
([`FRONT_PROMPT`](templates/FRONT_PROMPT.template.md),
[`front-protocol`](skills/front-protocol/SKILL.md)). Before any domain object - a table, a
shared piece, a business concept - the [`conceptual-guardian`](skills/conceptual-guardian/SKILL.md)
gives its opinion, as during the framing. Every change passes the
[`change-gate`](skills/change-gate/SKILL.md) (with no tracker, the wave is the work item;
the first wave's go was asked in step G2),
the [`test-gate`](skills/test-gate/SKILL.md) and the
[`delivery-gates`](skills/delivery-gates/SKILL.md); each work item closes with
[`close-and-retain`](skills/close-and-retain/SKILL.md).

### Step G4 - Retain

The same as step L6: [`retain-knowledge`](skills/retain-knowledge/SKILL.md) at the end of
every task that produced knowledge, the close script, and one line in the case's outbox
for the kit (`JOURNAL-for-kit.md`, step L6) for each lesson about the METHOD, within the
session.

**Installation success criterion (greenfield)**: one front taken from the draft to
delivery through the gates, with its decisions recorded in the base.

## Moving up a level

When a trigger is met - the first front (level 2); more than ~50 documents in the base, a
legacy of more than ~500 files or a second person (level 3) - the next decision round
carries the question (for level 2, the round that closes the prompt, with the first wave's
plan - [EK#26](DECISIONS.md)), the owner's answer becomes `<WORKSPACE-KEY>#N`, the adoption line
changes and the level's core pieces are turned on. At level 3 that means the memory index,
cards, the registry validator, the baseline diff, the hooks (`.engine-kit/guards.json`) and
the close script with every check; team cases name the designated builder of the derived
artifacts ([profiles/team.md](profiles/team.md)). The full list, piece by piece:
[docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md).

## Moving to a newer kit version

The case pinned a tag or commit on Day 1 (step 4, item 4). Moving it is a choice like that
one - recorded, citing the choice it revises - and comes with a re-check, because the case
copied some of the kit's rules into its own `AGENTS.md` (from the
[`AGENTS` template](templates/AGENTS.template.md) and the profiles) and the copy does not
follow the kit. A move made before the owner decides it (an instruction from a team or a
test, a fix the case needs now) is, like a Day-1 choice made with no owner, an assumption
`A-<WORKSPACE-KEY>n` - the version taken, the choice it revises, how to go back - ratified
in the workspace block of the next round; the ratifying decision cites it (step 4).

**The next round can be one already out.** A round sent to the owner and not yet answered
is that next round: the move's ratification, and what the new rules ask of a round of its
kind (a plan revision with its go line, a block it must carry), are appended to it before
any answer - dated, marked "added after the round went out", the questions already asked
never reworded - and the hand-off names the additions. A move made while an earlier move is
still unratified revises that assumption (the new one cites it as the choice it revises),
and one workspace block ratifies both. A case that recorded earlier moves as decisions with
no owner's answer (an earlier version of this section allowed it) keeps those rows, as the
Day-1 choices of step 4 do - a decision is never renumbered or deleted - and asks the owner
to ratify them in the workspace block of the next round; the ratifying answer cites each
row.

1. Read the kit's [CHANGELOG.md](CHANGELOG.md) entries between the two versions.
2. Compare with the new wording every rule the case's `AGENTS.md` copied from the kit -
   the template, a profile, a skill, this file - and align the copy, in the artifact
   language. The CHANGELOG's "Adopters: re-check" lists name the copied rules that
   changed; a rule the case copied on its own is compared too. The case's own files that
   follow a kit rule are re-checked the same way - among them the outbox for the kit
   (`JOURNAL-for-kit.md`, step L6), written in the case's artifact language whatever an
   older copy of the rule said.
3. A recorded decision of the case that a new kit rule contradicts stands: the next round
   asks the owner, citing the decision and the new rule, with closed options and one
   recommendation. Nothing is changed for the owner in the meantime. A kit change that
   lands between a question and its answer is read the same way: the answer is recorded as
   given; a decision that contradicts the new rule follows the sentence above; a new rule
   that only removes the recommendation's stated reason (the decision still holds under
   it) is no contradiction - the decision row says so, the owner is told in the hand-off,
   no new question opens and the round still closes
   ([`decision-rounds`](skills/decision-rounds/SKILL.md#recording-the-owners-answer)).
4. When the table that reads an answer to a fact request changed
   ([`decision-rounds`](skills/decision-rounds/SKILL.md#recording-the-owners-answer)), the
   facts recorded from the owner's answers are re-read against it. One that now falls in
   another row - a fact about the world that is now a claim about the system, a read a
   person made that is now a probe result - is recorded as that row says, its `F<n>` id
   kept beside the new one (`F7 -> H-012`): a claim about the system enters the hypothesis
   register on the legacy track (an open fact elsewhere), and a plan resting on it lists it
   as a fact premise, re-read like a fact after the go
   ([`change-gate`](skills/change-gate/SKILL.md), step 4 item 7).
5. A document the earlier version shaped differently (a prompt on an older structure, a
   register's columns) moves to the new shape at its next save, its ids kept - a round
   already out only by the dated additions above. An approved
   artifact - a plan or spec under a go, with the reds its go covers - keeps the shape it
   was approved in: a line the newer kit requires goes into its next revision, gated like
   any revision ([`change-gate`](skills/change-gate/SKILL.md), step 4 item 6), and until
   then the evidence says so (a missing `Browser cases:` line: the browser hand-off line of
   the test evidence). A frozen source is never reshaped.

## What to NEVER do

- Bring any content from another case (not even "just one example") - the kit already
  contains the anonymized examples the method needs
- Put the company's knowledge base in YOUR personal repo, or the kit (your method)
  mixed into the company's repo without clarity - case content belongs to the company;
  the method is yours; the boundary stays clean when each lives in its own home
- Edit the kit from a copy inside the case: improvements go to the case's outbox for the
  kit (step L6), and the kit's author brings them into its repository, distilled
  ([EK#1](DECISIONS.md))
- Skip the census "because the collection is small" - it is cheap and it is what keeps
  the boundary above auditable
- Turn every piece on at Day 1: a level is a decision, and a piece of a higher level is
  named and asked for, never run unasked
- Start rewriting code before the pilot's first full cycle (legacy), or write production
  behaviour before the owner's go on the first wave's plan (greenfield) - the red's tests
  and a new unit's stub may exist before it ([EK#28](DECISIONS.md)); let anything leave
  the working copy before the release word
- Turn a gate or a hook blocking without a numbered decision of the project
  ([EK#6](DECISIONS.md))
- Version derived artifacts with the base in a solo case - a runtime folder inside it is
  fine only while version control ignores it ([EK#27](DECISIONS.md)) - or let more than one
  machine build and commit them in a team case ([EK#5](DECISIONS.md))
