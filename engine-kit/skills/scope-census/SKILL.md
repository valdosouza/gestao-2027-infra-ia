---
name: scope-census
description: Use when installing the kit on a base that already holds documents (a census of the whole collection), when a new or touched document needs its Scope line, when an interrupted census must be resumed or Scope coverage verified, or at a task close for the changed files - classifies every document as method, case or mixed.
---

# Skill: Scope Census (classifying the case's collection)

**Scope**: method
**Maturity**: proven
**When to use**: (a) when installing the engine in a case that ALREADY has accumulated
documentation - a retroactive census of the entire collection; (b) continuously -
every new/touched file in the knowledge base is born classified; (c) at every task
close - the changed files only. Classifying the repository itself is Phase 1 of the
engine applied to itself (dogfooding).
**Not for**: separating method from case content (the census marks; the separation waits
for a new case); judging what a legacy document claims - that is
[`assess-legacy-repo`](../assess-legacy-repo/SKILL.md).
**Real origin**: the retroactive census of case zero (2026-07-19) - 88 documents
classified by 4 parallel agents in minutes, with a single naming collision; it
revealed that ~40% of the collection was portable (prior estimate: 20-30%). A second
case, a team knowledge base (~290 documents, 5 parallel agents), added the placement
rule for front matter, the exclusion classes and the resumed run. Exit tests of the two
tracks added the frozen sources and the linked legacy documents.
**Works with**: [`kb-setup`](../kb-setup/SKILL.md) (Day 1, step 7 of the installation),
[`retain-knowledge`](../retain-knowledge/SKILL.md) (the continuous rule), the close script
([`runtime/close/`](../../runtime/close/README.md), check `scope`).
**Changelog**: 2026-10-27 - the linked legacy document class (a document inside a
read-only code tree); the owner's original of a frozen draft recognised by its bytes; the
description in the "Use when" form; ASCII punctuation.

---

## The principle: marking is not separating

- **Marking** is cheap, reversible (1 line per file), and pays off immediately: the
  future physical separation becomes a FILTER, not archaeology.
- **Separating** (extracting/moving/abstracting) is expensive and goes wrong when done
  too early (the rule of three cases: an abstraction extracted from 1 case is a
  guess). Postpone the separation; never the marking.
- Leaving an existing collection unassessed = debt that grows. The retroactive census
  is mandatory at installation.

## The three values

A line in the header of every document: `**Scope**: method | <case> | mixed`

| Value | Meaning | Future destination |
|---|---|---|
| `method` | Portable to any company/legacy system (process, generic practice) | The engine kit |
| `<case>` | Case content (domain, DDL, screens, business decisions, infra setups) | Stays in the case - NEVER crosses companies |
| `mixed` | A portable principle tied to the case's stack/domain | Distillation queue: separate the principle (-> method) from the instance (stays in the case), ON DEMAND from a new case |

## Placement rule (where the line goes)

- **The document starts with YAML front matter** -> the line goes right after the
  closing `---`, followed by a blank line. Never inside the front matter: a YAML key is
  not the grep-able token.
- **Otherwise** -> right after the H1 title; when bold `**Key**: value` metadata lines
  follow the title as one contiguous block, at the end of that block.
- A document written from a template already carries the line under its H1; both
  positions are valid (the validators look at the top of the document, outside fenced
  code). The census inserts; it never moves an existing line.
- Reformat nothing else. If a `**Scope**:` line already exists, do not add a second
  one: skip the file and REPORT it.

## What the census excludes (record each exclusion)

The census covers hand-written knowledge documents. Five classes are excluded by
folder or by pattern; the exclusion list is written down with the census result and
passed to the validator as its `-ExcludePattern`:

| Class | Examples |
|---|---|
| Generated output | code-graph files, derived indexes and ledgers, rendered catalogs |
| Vendored code | dependency folders, copied third-party source, study repositories |
| Runtime state | agent-orchestration state folders, trash and cache folders |
| Editor config | the settings folders of a note-taking app or an editor |
| Tool-owned state | folders an installed tool writes and reads for itself |

**Hand-written docs in the same folder stay included**: a README written by hand
inside a graphs folder, a hand-kept note inside an index folder, a thin adapter next
to an editor's config. Exclude the generated files, not the hand-written ones beside
them.

## Frozen sources (classified, never marked)

A frozen source is a knowledge document the method forbids editing: the owner's draft kept
byte-identical beside the prompt, whose line numbers are the item ids
([`frame-greenfield`](../frame-greenfield/SKILL.md): `prompts/prompt_<front>-draft.md`,
`-draft-2.md`); an official source archived as published, whose bytes are hashed
([`official-source-archive`](../official-source-archive/SKILL.md)); the owner's original of
such a draft, while the owner keeps it as it was; a file the owner handed over to be kept as
received (a written answer to a round); any file whose line numbers are cited as ids. A
Scope line would shift every line number and break the hash (and a draft often has no title
to put it under).

So a frozen source is **classified, never marked**: the census table records it with its
value and the class (`prompts/prompt_x-draft.md | case | frozen: the owner's draft, line
ids`), and no Scope line is ever added. The document that points at it (the prompt, the
archive README) carries the Scope line and the hash.

A case declares its frozen sources **by path** - never by a marker inside the file, since
writing the marker is the edit the class forbids:

| Where | How |
|---|---|
| The census result | the frozen list, written beside the exclusion list |
| The close script | `checks.scope.frozen` in `.engine-kit/close.json`: globs; default `**/prompt_*-draft.md` and `**/prompt_*-draft-*.md` (the frozen-draft names). The list replaces the default: keep both when adding the case's own - the owner's answer files, an archive folder, an original the owner has edited (`owner-answers/**`, `HISTORY/originals/**`) ([contract](../../runtime/close/README.md#configuration-contract-engine-kitclosejson)) |
| The validator's full sweep | `-FrozenPattern <regex>` over the root-relative path with `/`, the same default; the close script passes its globs when it runs the sweep |

**The owner's original needs no entry while it is byte-identical to its frozen copy**: the
close script treats a document whose bytes equal a frozen source's as that source's
original - frozen too, wherever it sits or moves (the root, `HISTORY/`). Once the owner edits
it, it is a document of its own: name it in the list if it must stay untouched, or it gets
its Scope line like any other.

The close script's `scope` check lists a new frozen source as a `note`; one that version
control shows as **modified** is a finding - it is never edited: compare it with its recorded
hash and restore the original.

## Linked legacy documents (classified, never marked)

A legacy document that lives **inside the legacy's code tree** - a readme, a manual, a
design note committed with the code - is not the base's to edit when that tree is read-only
for the case (the legacy track never writes in it). The base **links** it (from the
project's `INDEX.md` or the analysis document) instead of copying or moving it, and the
census classifies it by path, like a frozen source:

- The census table lists it by its path from the code tree's root (the tree named in the
  `Code tree` cell of the project's row in the projects registry), with its value and the
  class: `<code tree>/docs/manual.md | case | linked: legacy document, read-only code tree`.
- It is **never marked, moved or edited**: no Scope line, no fix. The base's document that
  links it carries the Scope line.
- What it claims about the system is a hypothesis until the code confirms it
  ([`assess-legacy-repo`](../assess-legacy-repo/SKILL.md), section 5); wherever the base
  repeats one of its claims, the claim carries its mark (`confirmed-by-code`,
  `legacy-unconfirmed`, `conflicting`).
- The close script does not see it when the code tree sits outside the base (the usual
  layout). When a case keeps the code tree inside the base's root - its own repository,
  ignored by the base's version control ([EK#29](../../DECISIONS.md)) - the tree goes to
  `checks.scope.exclude` and `checks.retired.normative.exclude` (and to the validator's
  `-ExcludePattern`): it is not knowledge to mark; the census table still lists its linked
  documents.

## Retroactive census workflow

1. **Inventory**: list every `.md` in the base, minus the five excluded classes above
   (record the exclusions). Frozen sources stay in the inventory, classified, never
   marked; linked legacy documents join it by path, classified, never marked.
2. **Rules written ONCE**: the definition of the 3 values + the placement rule above +
   the instruction "if a `**Scope**:` line already exists, skip it and REPORT".
3. **Parallel fan-out**: split the files into groups by folder and launch N agents
   with the SAME rules. Each agent reads only the header (~30 lines) - enough to
   classify; it reads more only when genuinely in doubt. Per-group classification
   hints help, but the agent judges by the content.
4. **Structured return**: each agent returns `file | scope | justification
   (<= 8 words)` + the skipped ones. Reported naming collisions become an explicit fix
   (e.g., rename the old line that used the same name with a different meaning).
5. **Programmatic verification**: search (grep) for `^\*\*Scope\*\*:` - check for 1
   occurrence per file (0 for a frozen source or a linked legacy document) and sum per
   value. Numbers that do not match = investigate.
6. **Consolidation**: a summary table (value x count x reading of what it means) and
   a dated line in the base's own changelog (the numbers are case content). Only a method
   insight the census teaches goes to the case's outbox for the kit (`JOURNAL-for-kit.md`,
   [`retain-knowledge`](../retain-knowledge/SKILL.md) section 2), which the kit's author pulls
   into [`JOURNAL.md`](../../JOURNAL.md). The
   `mixed` column is the named distillation queue.

## Resuming an interrupted run

A census that stops halfway (a session ends, an agent fails) needs no state file:
**re-inventory the unmarked files** - every document in the inventory without a
`**Scope**:` line, minus the frozen and linked ones - and that list IS the remaining work.
Fan it out again with the same rules; the "skip if already marked" instruction makes a
second pass over a marked file harmless. Then run the programmatic verification over the
whole inventory, not only over the resumed part.

## Continuous rule (post-census)

It enters the knowledge-retention skill and the root rules file: **every new or
touched file gains the Scope line**. No exception but a frozen source or a linked legacy
document (classified in the census, never marked) - it is what keeps the collection 100%
classified forever.

## Close check (changed files only)

At every task close, check only what the task changed: list the changed markdown
files with [`vcs.py`](../../runtime/registry/vcs.py)
(`python runtime/registry/vcs.py --root <kb-root> --md-only`; on svn add
`--svn-client-ignored` when a client's `global-ignores` may hide markdown files - EK#17), minus the
excluded classes and the frozen sources, and verify that each one has exactly one Scope
line with a known value. A missing line is added in the same task. The full sweep
([`validate-registry.ps1`](../../runtime/validate-registry.ps1) `-Root <kb-root>`) is
the periodic check, not the
per-task one: on a large base it reports the whole backlog, and the close must only
answer for the task's own files. The close script's `scope` check does exactly this
(`python runtime/close/close.py --only scope`, [README](../../runtime/close/README.md)).

## Recorded lessons (real situations)

- Parallel classification with identical rules is consistent: 4 agents, 88 docs,
  1 collision (and it was a real naming problem, not a divergence of judgment).
- The census changes the perception of the collection: the portable core tends to be
  LARGER than intuition estimates - without the census, product value stays invisible.
- Classic collision: "Scope" already used with a different meaning in old docs ->
  rename the old field (preserving its meaning) and apply the new one.
- An interrupted run was resumed by re-inventorying the unmarked files: the grep
  verification made the resume trivial.
- A Scope line added by hand to a generated file is lost at the next regeneration:
  exclude generated files, or let the generator write the line itself (the kit's
  registry tools do, through their `scope_value` setting).
- An exit test of the greenfield track met "census the draft" against "the draft is never
  edited; its line numbers are the item ids": the close script then reported two items to
  fix that could never be fixed (the frozen draft and the owner's original). Hence the
  frozen-source class: classified, never marked, declared by path. Its second stage needed
  the owner's original and the owner's answer listed by hand; the original is now
  recognised by its bytes.
- An exit test of the legacy track met a legacy readme inside the read-only code tree: it
  could be linked, not moved or marked. Hence the linked legacy document class.
