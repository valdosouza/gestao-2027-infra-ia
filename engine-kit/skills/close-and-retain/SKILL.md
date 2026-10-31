---
name: close-and-retain
description: Use when a bug, change request or task is done and must be closed ("close CR-123", "finalize", "write the closing text", "prepare the commits") - one closer writes the closing record and tracker text, runs the retention chain and card decisions, packages fix and tests, applies the deliverable gate, then the close script. Prepare-only.
---

# Skill: Close and retain (one closer, one task, one call)

**Scope**: method
**Maturity**: operating
**When to use**: the last step of a work item (a bug, a change request, a task) - after the
hand-offs of [`change-gate`](../change-gate/SKILL.md) (build, test gate, browser check,
delivery gates, result review), or when the owner says the work is done: "close CR-123",
"finalize", "write the closing text", "prepare the commits". Also for a closing draft
while something only a person can end still waits - a work item still in analysis, a
prepared change's returned logs, the owner's walk (G4) ([drafts](#drafts-while-a-gate-waits));
nothing leaves.
**Not for**: the end of a task that is not a work item - a session that only produced
knowledge runs [`retain-knowledge`](../retain-knowledge/SKILL.md) alone, which ends with the
same close script; executing the commits, the push or the tracker state change (the
human's, after the release word of [`decision-rounds`](../decision-rounds/SKILL.md));
writing a card (the [`archive-card`](../archive-card/SKILL.md) skill, which this one calls);
running the suite ([`test-gate`](../test-gate/SKILL.md)).
**Real origin**: case two - a multi-developer product team decided that one agent closes a
work item: it writes the tracker text, the commit message (two for a change with suite
tests, the fix first), the knowledge tail (episodic log, a card decision for every fact at
0.8 or more, provenance, SUPERSEDED marks) and then runs one close script. The packaging
rule came from new test files left unversioned (the commit dialog hides them by default)
that broke the other machines' build; the deliverable gate from an analysis delivered in
the wrong language, as binary files only, in the root folder of the knowledge base. Case
zero - the modernization of a legacy business application - supplied the retention chain
this skill runs.
**Parts**: single closing step (T45), change packaging (T78) and deliverable gate (T92) -
`operating`: one case, core by choice ([maturity](../../docs/MATURITY.md)). The close script
carries the retired-location guard (T88, `operating`):
[`runtime/close/`](../../runtime/close/README.md). The retention chain (T46, `proven`) is
[`retain-knowledge`](../retain-knowledge/SKILL.md)'s. Register:
[docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`change-gate`](../change-gate/SKILL.md) (the close is its last hand-off;
prepare-only and the tracker-write protocol), [`test-gate`](../test-gate/SKILL.md) (the
closing row: index row or exempt line, evidence file, two commits),
[`retain-knowledge`](../retain-knowledge/SKILL.md) (the chain),
[`archive-card`](../archive-card/SKILL.md) (the card decision),
[`memory-engineering`](../memory-engineering/SKILL.md) (claims, consolidation),
[`scope-census`](../scope-census/SKILL.md) (the Scope line). Templates:
[`CLOSE`](../../templates/CLOSE.template.md), [`DELIVERABLE`](../../templates/DELIVERABLE.template.md).
Detail: [closing texts](references/closing-texts.md), [packaging](references/packaging.md),
[deliverable gate](references/deliverable-gate.md).
**Levels**: the skill is a level-2 piece ([adoption levels](../../docs/ADOPTION-LEVELS.md)).
Its steps tagged *level 3* - the memory index, the card decisions, the consolidation flags -
are not run below level 3, and the closing answer says so in one line ("card decisions:
level 3, skipped"), as the close script does with the case's `level`.
**Changelog**: 2026-10-21 - first version (wave 3): T45, T78 and T92 from case two's
single closing agent, its close script, its packaging rule and its deliverable standard.
2026-10-27 - from a greenfield exit test: the level-3 steps tagged.
2026-10-28 - from the greenfield exit test's stage 4 and the legacy one's stage 3: drafts
while the owner's walk or a prepared change's returned logs wait; the walk and the release
word asked in one message, in the order of the gates.
2026-10-28 (2) - from the greenfield exit test's stage 5 and the legacy one's stage 4: the
draft names who ends the wait from the people registry (asked as a fact request while
nobody is named); a message that only says the wait goes on leaves the draft as it is.

---

## The principle

> **One closer per work item, one task, one call at the end.** What the work item taught
> is retained in the same task that closes it. What leaves the working copy - commits,
> pushes, tracker writes, messages - is prepared, and a human sends it.

Why one closer: when the tracker text, the commit message and the knowledge tail are
separate steps, each one assumes another did the rest, and the knowledge tail is the one
that gets skipped. In case two, the retention chain had been a separate habit; when it was
skipped, the registries drifted from what was on disk. The case made one agent the closer
of every work item, and a script the last thing it runs.

Example used throughout (fictional): **CR-123, "Acme Orders: allow a partial shipment of an
order"**, project `ORD`, area `SHIPPING`, an application working copy and a test-suite
working copy beside the knowledge base.

## Inputs

| Input | Example |
|---|---|
| Work item, type, title | CR-123, change request, "allow a partial shipment" |
| Ticket folder | `<project>/SUBJECT/SHIPPING/TICKETS/CR-123/` |
| Working copies the change touched | application (branch `cr-123`), test suite, knowledge base |
| Project key | `ORD` (for the tenant scope check) |
| What the case sanctions | the tracker fields the agent may write - usually none ([prepare-only](../change-gate/references/prepare-only.md#6-tracker-writes---when-the-case-sanctions-one)) |
| The artifact language | fixed once in the case's `AGENTS.md` ([deliverable gate](#7-the-deliverable-gate-t92)) |

## The sequence

| Step | What | Output | Stops when |
|---|---|---|---|
| 1 | [Read before writing](#1-read-before-writing) | context; the preconditions | a gate before the close is missing - the owner's walk or a prepared change's logs: a [draft](#drafts-while-a-gate-waits) |
| 2 | [The change, as version control sees it](#2-the-change-as-version-control-sees-it) | file list per working copy: fix, tests, knowledge | - |
| 3 | [The closing record](#3-the-closing-record) | `TICKETS/<ID>/CLOSE.md` | - |
| 4 | [The tracker](#4-the-tracker) | prepared text, or the sanctioned write | someone else's text would be replaced: ask |
| 5 | [The retention chain](#5-the-retention-chain) | log, card decisions (*level 3*), provenance, SUPERSEDED, rows | - |
| 6 | [Packaging](#6-packaging-t78) | every new file added; two groups; prepared commands | - |
| 7 | [The deliverable gate](#7-the-deliverable-gate-t92) | each artifact in its language, place and format | - |
| 8 | [The close script](#8-the-close-script) | its report, fixed and run again | - |
| 9 | [The closing answer](#9-the-closing-answer) | what is done, what is the human's | - |

### 1. Read before writing

- The ticket folder: the dossier, the plan or spec with its Test plan, `WORKLOG.md` (the
  go, deviations, approved test updates, release words), `TESTS/`, `PATCH/` (a prepared
  change: the two commits are prepared from its patches, fix first), `REVIEW/`, the build
  audit. The tracker is not read again when this week's dossier exists.
- The memory for the work item - the before-action loop of
  [`memory-engineering`](../memory-engineering/SKILL.md) (*level 3*: `memory_index.py query
  --ticket <ID>`; at level 2, the area's `MEMORY/` logs read directly), the area's
  `INDEX.md`, the cards the plan quoted.
- **Preconditions** - each one done, or a written line:
  - the test gate's evidence file for every line the change touched (green, only
    pre-existing failures, `not run here: <reason>`, or `skip: <reason>`), and the index
    row of the change or the Test plan's `exempt:` line. **Missing: stop and say which** -
    the change reached the close before the suite gate. A `not run here: prepared patch`
    line meets it for the [draft](#drafts-while-a-gate-waits) only;
  - the review: an `open` finding is named in the closing record, never closed by the
    closer;
  - where the project has rule files, the rule row that authorises the behaviour
    ([`decision-rounds`](../decision-rounds/SKILL.md)); a **Denied** row with no newer
    **Authorised** one, or an open question implemented on its open point: stop.

### 2. The change, as version control sees it

- Status and diff of **every** working copy the change touched, read-only (`git status`,
  `git diff <base>...`; `svn status`, `svn diff`). The file list comes from version
  control, never from memory or from another tool; without that output, ask for it.
- Each file is **fix** (product files), **tests** (the suite's files: tests, case tables,
  suite project files, coverage lists) or **knowledge** (the base). The tests never ride in
  the fix commit.
- Read the most relevant changed files (a handful) before describing them.

### 3. The closing record

`TICKETS/<ID>/CLOSE.md`, from [`templates/CLOSE.template.md`](../../templates/CLOSE.template.md),
in the case's artifact language: the tracker text, the tracker fields (when sanctioned),
the commit messages, the packaging, the knowledge tail, the close script's result and the
exit checklist. It is the single source of every text that leaves; its file is also what
marks the work item as being closed for the close script.

- **Tracker text by type**: a bug leads with **Root cause** (symptom, root cause, solution
  - its own section, never folded into the test focus); a change request takes the full
  shape; a task is short. Then the changed files, one line each, by tier; a **Rule** line
  when a business rule changed; **Test focus** for the testers, naming the automated tests
  that pin the change; the line and working copy.
- **Commit messages**: one line, `<Type> <ID>: <what was built or fixed> - <parts>`. A
  change with suite tests has **two, in commit order**: the fix, then the tests.
- **A draft** while a gate waits - no code change yet, a prepared change's logs, the
  owner's walk ([below](#drafts-while-a-gate-waits)) - nothing written anywhere else.

Shapes, field mapping and a worked example: [references/closing-texts.md](references/closing-texts.md).

#### Drafts while a gate waits

The close stops when a gate before it is missing - except while it waits for what only a
person can end. Then the record is prepared as `status: draft`, its marker under the title,
so that nothing waits on the agent once that person is done:

| Waiting for | Marker | Prepared now | Becomes `ready` when |
|---|---|---|---|
| the code (a work item still in analysis) | `[DRAFT - pending implementation]` | the record; nothing for a commit | the code exists - the real close |
| a prepared change's logs ([`change-gate`](../change-gate/SKILL.md#a-change-the-agent-cannot-write-or-run---prepared)) | `[DRAFT - pending the returned logs]` | written when the patches are: the commits (from the patches, fix first) and the release list | the logs came back, were read as runs, and the hand-offs after them passed |
| the owner's walk (G4, [`delivery-gates`](../delivery-gates/SKILL.md)) | `[DRAFT - pending the owner's walk]` | the record, the packaging, the release list | the walk passed; an observation fixed is a delta, and the record follows it |

- This is how the close waits among the hand-offs of a prepared change
  ([`change-gate`](../change-gate/SKILL.md), step 5): only its draft comes early, and
  `ready` needs the returned logs, never the `not run here` line.
- The walk and the release word may be asked in one message, each on a line of its own
  ("Walk the script in `TESTS/`?" - "Release items 1-4 of the list?"). The order of the
  gates holds: the word releases only the list, and only once the walk passed
  ([`decision-rounds`](../decision-rounds/SKILL.md#the-release-word)).
- **Who ends the wait** is named on the line under the marker and in the answer: the
  owner for the walk; for a prepared change, the person the people registry
  (`_REGISTRY/PEOPLE.md`) names to apply and rehearse it - asked as a fact request in the
  round that carries the go, or the next one
  ([`decision-rounds`](../decision-rounds/SKILL.md#the-closing-round-carries-the-first-plan-ek26)).
  While nobody is named, the draft says `not named yet - R-<NS>n` and the request stays
  open.
- A message that only says the wait goes on ("they stay owed") leaves the draft as it is,
  marker included: it is quoted once where the item lives and closes nothing
  ([`decision-rounds`](../decision-rounds/SKILL.md#recording-the-owners-answer)).
- Nothing of a draft leaves: no tracker write, no commit, no message.

### 4. The tracker

**By default the tracker text is prepared** in `CLOSE.md` and the developer pastes it. A
greenfield wave with no tracker (its work item is the wave, see
[`change-gate`](../change-gate/SKILL.md)) writes the same text into the front prompt's wave
block instead.
Where the case sanctions a field write (its numbered decision; the write tool on the
harness ask list), every write follows the five steps of
[prepare-only, section 6](../change-gate/references/prepare-only.md#6-tracker-writes---when-the-case-sanctions-one):

1. **read the item first** and take its revision;
2. send an **optimistic revision test** as the first operation of the same update;
3. **show and ask** before replacing text someone else wrote;
4. **never post a comment**;
5. **confirm that each field landed** - its name and first words - from the response.

And one more: **a comment is never a substitute.** When the field write is not sanctioned,
fails or is refused, the text stays in `CLOSE.md` and the answer says the field is the
developer's. State, dates, assignment and the committed revision stay with the human; the
revision is written only when the human gives it, never guessed.

### 5. The retention chain

Run [`retain-knowledge`](../retain-knowledge/SKILL.md) in full, with the work item as the
session. For a work item it means:

1. **The episodic log** - when the work item's sessions left none today,
   `MEMORY/<YYYY-MM-DD>-<ID>-closing.md` with claims from the dossier and the fix (root
   cause, what changed, what was verified); evidence = the revisions (or `pending`), the
   work item, the card ids. New claims are compared with the old ones: a confirmation
   raises the old confidence, a contradiction gets a temporal or scope note on both sides.
2. *level 3* - **The card decision** - every `fact` at 0.8 or more:
   **new card / strengthened card K-... / superseding card / no card (why)**, through
   [`archive-card`](../archive-card/SKILL.md); one line per claim in the answer. A card
   written before its commit carries a pending revision, listed for after the commit.
3. **Provenance** - every card or derived document the work item touched carries the
   revision of its source.
4. **SUPERSEDED marks** - a document, claim or card the change invalidates is marked, never
   deleted.
5. **Rows** - the area `INDEX.md` line of a new card; a registry row for a new area,
   setting, pipeline or graph state; the root rules only if the workspace state changed.
6. *level 3* - **The flags** - the area's unconsolidated logs (five or more), and a work
   item that leaves two or more sessions in one area: a consolidation cycle, now or named as
   the next task.

### 6. Packaging (T78)

1. **Every new file is added to version control when it is created** (a local, reversible
   step of the single pass). At the hand-over nothing of the change is unversioned in any
   working copy. A working copy with no first commit yet: its first commit waits for the
   release word, and the close script notes its files once.
2. **Fix and tests are two commits, the fix first**, grouped under the work item's name so
   that a file in the wrong group shows: svn changelists `<ID>-fix` and `<ID>-tests` (the
   same names on every line); in git, the work item's branch with two staged sets, one
   commit each. Knowledge-base files go in their own commit.
3. Where the suite's index records the fix revision, the index row is completed **between**
   the two commits.
4. The commands are **prepared** in `CLOSE.md`, in execution order; the human runs them
   after the release word.

Commands for git and svn, the changelist rules, the knowledge-base commit:
[references/packaging.md](references/packaging.md).

### 7. The deliverable gate (T92)

Before creating any artifact someone will keep or share - the closing record, a report, an
analysis, an export:

1. **Language** - the case fixes the artifact language once (its `AGENTS.md`); every
   artifact is in it, whatever language the chat is in. **The chat follows the user.** A
   translated copy only on request, and outside the knowledge base.
2. **Place** - the owning folder: the ticket folder for the work item's artifacts, the area
   for area knowledge, the method's own folder for method documents. **Never the root
   folder**, never a personal folder. A missing standard folder is created, not asked
   about and not invented.
3. **Format** - **the markdown is the record**: a title, the Scope line, status, origin and
   references. Binary files (documents, slides, spreadsheets, PDFs) are **exports generated
   from it, saved beside it** with the same base name.
4. **Retention** - linked from the owning index; the chain of step 5.

A deliverable found in the wrong language, place or format is regularised: moved with
version control (history kept), links fixed, a SUPERSEDED mark where a copy stays. Header:
[`templates/DELIVERABLE.template.md`](../../templates/DELIVERABLE.template.md). Detail:
[references/deliverable-gate.md](references/deliverable-gate.md).

### 8. The close script

```text
python <kit>/runtime/close/close.py --root <kb-root> --project <KEY> [--ticket <ticket folder>]
```

One call: registries, the Scope line of touched documents, the test evidence of the work
item, retired locations in normative files (every spelling), the decisions index and its
citation check, the ledger, the memory index with the consolidation flags (level 3), and
files left unversioned in every working copy - with the fix and test files listed apart.
Contract and configuration: [`runtime/close/README.md`](../../runtime/close/README.md).

- Fix what it lists and **run it again**, until it is clean or each remaining line has its
  written reason in the answer.
- It is **warn-only** ([EK#6](../../DECISIONS.md)): exit 0 does not mean clean - the lines
  do. A project makes it blocking (`--strict`, `"mode": "strict"`) by a numbered decision.
- `NOT RUN HERE` and `n/a` lines are copied into the answer; they are owed, not passed.

### 9. The closing answer

In the user's language; the prepared texts pasted verbatim in the artifact language.

```text
--- COMMITS (prepared - yours, after the release word) ---
1. fix    CR-123: Allow a partial shipment of an order - order service, shipping screen.
          files: <the fix group>
2. tests  CR-123: suite tests for partial shipments - shipping fixture (4 cases).
          files: <the tests group>      (between 1 and 2: the index row gets the fix revision)

--- TRACKER ---
Text ready in TICKETS/CR-123/CLOSE.md (Root cause, Changes, Test focus) | fields written: <name: first words>
Left to you: state, dates, the revision number after the commit

--- KNOWLEDGE ---
Log: SUBJECT/SHIPPING/MEMORY/2026-10-21-CR-123-closing.md (4 claims)
Card K-20261021-1412 new (fact 0.9) | K-20260930-0915 strengthened (0.85 -> 0.95) | no card: one-task detail
SUPERSEDED: <files or none>    Flags: SHIPPING 5 unconsolidated -> consolidation cycle next

--- CLOSE SCRIPT ---
clean | n to fix (listed) | not run here: <what, why>

--- EXIT CHECKLIST ---
[x] closing record  [x] log and card decisions  [x] every new file added  [ ] commits (yours)  [ ] tracker state (yours)
```

Below level 3 the card and flag lines of `KNOWLEDGE` read `level 3, skipped`. A draft's
answer opens with its marker and names who ends the wait (the person the people registry
names to apply and rehearse the patches - or `not named yet - R-<NS>n` -, the owner for
the walk).

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| The commit message written, the knowledge tail "later" | later never comes; the next task starts blind | one task: texts, chain, packaging, script |
| A comment posted because the field write failed | a comment notifies people: it is a message, and messages are the human's | the text stays in `CLOSE.md`; say the field is theirs |
| A field overwritten that someone else filled | their text is lost without a trace | show it, ask, then write |
| The revision number guessed before the commit | a wrong pointer in the tracker | written only when the human gives it |
| Fix and tests in one commit | the suite's history cannot tell a fix from its tests; a port takes both or neither | two groups, two commits, the fix first |
| A new file left unversioned | it stays out of the commit and breaks the other machines' build | add it when it is created; the script lists the rest |
| The closing record in the chat language, or in the root folder | the next reader cannot find or read it | the artifact language, the ticket folder |
| A binary report with no markdown beside it | no diff, no search, no link | the markdown is the record; the binary is its export |
| "Exit 0, so it is clean" | the script is warn-only | read the lines; fix and rerun |

## Checklist

- [ ] Preconditions met or written: evidence per line, index row or `exempt:`, review status, rule row.
- [ ] File lists from version control, per working copy, split into fix, tests and knowledge.
- [ ] `CLOSE.md` written in the artifact language (a draft while a gate waits: no code yet, the returned logs, the owner's walk).
- [ ] Tracker text prepared - or written by the five steps, each field confirmed; no comment posted.
- [ ] Episodic log; provenance; SUPERSEDED marks; rows. *level 3*: a card decision for every fact at 0.8 or more; the consolidation flags.
- [ ] Every new file added; fix and tests prepared as two commits, the fix first; commands in `CLOSE.md`.
- [ ] Every artifact passed the deliverable gate.
- [ ] The close script run until clean, or each remaining line has its reason in the answer.
- [ ] The answer lists what is done and what is the human's: commits, tracker state, revision number.
