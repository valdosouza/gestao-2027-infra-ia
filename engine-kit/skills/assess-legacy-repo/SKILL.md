---
name: assess-legacy-repo
description: Use when first meeting a legacy system or a legacy document - photograph what the code does (file:line, no improvements), keep every claim from documents, owners or agents as a hypothesis validated one per turn ("validate H-003"), re-check agent readings with a script or the graph, and probe live data read-only.
---

# Skill: Assess a legacy repository (photography, not renovation)

**Scope**: method
**Maturity**: operating
**When to use**: first contact with a legacy system - before any concept, decision or new
line of code; whenever a legacy document, a document the owner verified, a ticket or an
agent's reading claims something about what the legacy does ("the manual says it
soft-deletes", "validate H-003", "next open hypothesis"); before a fix is designed from an
analysis document; when a reading by agents will weigh on a decision; when the question is
what a live database holds.
**Not for**: designing the replacement or judging the legacy - the following phases
([`conceptual-guardian`](../conceptual-guardian/SKILL.md),
[`decision-rounds`](../decision-rounds/SKILL.md)); the direction of a migration
([`migration-direction`](../migration-direction/SKILL.md)); archiving official norms
([`official-source-archive`](../official-source-archive/SKILL.md)); mapping the pipelines of
an area ([`pipeline-builder`](../../agents/pipeline-builder.md)); writing the fix
([`change-gate`](../change-gate/SKILL.md)).
**Real origin**: case zero - the modernization of a legacy business application: the
analysis script of a synchronization service migration, the photography of a large
application in sliced sessions (lessons 1-14), and a third-party component used by the
legacy, read by parallel agents and re-checked by a structural graph and a script. Case
two - a multi-developer product team: the scale lesson (about 2M lines, 30 years), a
legacy-process analysis chain whose validation agent took one hypothesis per turn in a
fixed status vocabulary into a new version of one analysis document, a decision of its
knowledge base that a claim from legacy documentation stays a hypothesis until code
confirms it, and a query runner that refused writes and capped rows.
**Parts**: faithful photograph and hypothesis register (T09) `operating`; legacy documents
are input, never truth (T10) `proven` - both cases; rules as data (T15) and inverse process
plus sibling difference table (T16) `operating`; agent reading with a deterministic re-check
(T11) `candidate` - one case, optional; read-only data probe (T94) `proven` as a rule, the
tool from one case ([maturity](../../docs/MATURITY.md)). Register:
[docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`conceptual-guardian`](../conceptual-guardian/SKILL.md) (suspected scale
models), [`decision-rounds`](../decision-rounds/SKILL.md) (intent questions, route choices),
[`front-protocol`](../front-protocol/SKILL.md) (negative knowledge, T12),
[`memory-engineering`](../memory-engineering/SKILL.md) (*level 2*) and
[`retain-knowledge`](../retain-knowledge/SKILL.md) (claims with status and evidence),
[`change-gate`](../change-gate/SKILL.md) (prepare-only; read-only database sessions).
**Agent**: [`legacy-analyst`](../../agents/legacy-analyst.md) holds the judgment (which status,
fact or intent, which point to re-check).
**Detail**: [hypothesis validation](references/hypothesis-validation.md),
[agent reading and re-check](references/agent-reading-recheck.md).
**Templates**: [`HYPOTHESES.template.md`](../../templates/HYPOTHESES.template.md).
**Tools**: [`runtime/data-probe/`](../../runtime/data-probe/README.md) (read-only queries),
[`runtime/graph/`](../../runtime/graph/README.md) (code graphs).
**Changelog**: 2026-09-04 - lessons 1-13 from a large legacy business application (sessions
1-3), then lesson 14 (owner-verified documents are hypotheses); 2026-10-21 - wave 4:
rewritten to the kit's skill shape with ASCII markers; T10 as a rule (section 5); the
hypothesis register and the validation turn (T09, section 6); agent reading with a
deterministic re-check (T11, section 7); the read-only data probe and its tool (T94,
section 8); sections 8-9 of the photograph; lesson 7 completed (T15); 2026-10-27 - an exit
test of the legacy track: the reading's doc x code table may settle `confirmed` /
`rejected` with primary evidence (section 5); library and engine semantics stay open until
a disposable run; a text-only sizing count; the legacy's own layers mapped when no target
is decided; the analysis document's place; the episodic log tagged level 2; then its
second stage: the startup path first in the reading order (section 2), the sibling
difference table inside the pilot's photograph (section 3, item 2), an owner's answer about
what the legacy runs entered as a register row (section 5); 2026-10-28 - its third stage:
a read a person made on request is a probe result (section 5); one claim per row, a
partly settled row narrowed and split (section 6); 2026-10-28 - its fourth stage: a row
entered bundled before that rule is split at its next turn, listed meanwhile (section 6).

---

## The principle

The assessment **photographs** the legacy: it reads the source and writes down faithfully
what is implemented - without inferring intentions, suggesting improvements or inventing
missing mappings. Improving is the job of the phases that follow.

Four kinds of source, never mixed:

| Source | Status in the assessment |
|---|---|
| The code (and its history, and the data read through a read-only probe) | **fact**, with `file:line`, revision or query |
| Documents, the owner's memory, tickets, an agent's inference | **hypothesis** until the code confirms it (section 5) |
| What a third-party library, framework or database engine does when the legacy runs (a validator, an ORM, a collation) | **hypothesis** until a disposable run shows it; the library's documentation at the version the legacy pins is evidence labelled `inference` (section 5) |
| The reader's view of what the next phase should do | **outside the photograph**, in its own section |

Words used here: the **analysis document** is the single versioned photograph of one
process or defect; a **hypothesis** is a claim that the code has not settled yet, with an id
`H-<NNN>` in the **register**; a **validation turn** settles one hypothesis; a **probe** is a
read-only query against a live database.

## 1. Size before reading (the scale lesson)

The first act is to measure: lines, files, languages, age, modules. **Count the lines of
text files only**: an extension list widened to "everything" counts "lines" of images,
fonts and archives. A file with a NUL byte in its first 8 KB is binary - listed by count
and extension, never by lines. Read-only: nothing in the tree is built or run.

```powershell
# from the root of the legacy tree
$text = @(); $binary = @()
Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notmatch '[\\/](\.git|\.svn|node_modules)[\\/]' } | ForEach-Object {
  $fs = [System.IO.File]::OpenRead($_.FullName); $buf = New-Object byte[] 8192
  $n = $fs.Read($buf, 0, $buf.Length); $fs.Close()
  if ([Array]::IndexOf($buf, [byte]0, 0, $n) -ge 0) { $binary += $_ } else { $text += $_ }
}
$text | Group-Object Extension | Select-Object Name, Count, @{n='Lines';e={@($_.Group | Get-Content).Count}} | Sort-Object Lines -Descending
$binary | Group-Object Extension | Select-Object Name, Count | Sort-Object Count -Descending
```

On a POSIX shell, `grep -rIc '' .` gives the lines of each text file (`-I` skips binary
files). Leave vendored and generated folders (dependencies, build output, minified bundles)
out of the count and say which were left out; a UTF-16 text file shows as binary - check the
binary list for source extensions.

- **Small repository** (readable within a few sessions): direct reading by agents, fanned
  out per folder or module with identical rules (the parallel-census pattern).
- **Large repository** (millions of lines): direct reading does NOT scale. Index first: a
  code graph (who calls whom, who uses which table) and/or semantic search over the source.
  The analysis then navigates the index and reads only what it points to. Without this
  step the assessment becomes sampling disguised as a census.
- In both: define the **units of analysis** (module, screen, entity, integration) and keep
  an inventory with a status - the assessment is incremental and resumable, never a big
  bang.

## 2. Parameters per case

| Parameter | Example |
|---|---|
| Source stack | <legacy language/framework> + <source database> |
| Target stack | <new language/framework> + <target database/API> - as a reader of the legacy only; `none decided` while the direction is the owner's open question (section 3, item 3) |
| Reading priority order | startup path (start scripts, run profiles, schema or seed scripts applied at start) -> source models -> target models -> controllers/rules -> other configs/utilities |
| Slice | the folders and file kinds read; what is out of scope |
| Discard warnings | abandoned plans in the code that must be IGNORED (e.g. an abandoned framework, old writers kept beside the live ones) |

**The startup path comes first in the reading order, before any business rule.** A legacy
that recreates or seeds its database at every start keeps its most dangerous behaviour in
the startup scripts and profiles: what runs at every boot (a schema dropped and recreated, a
seed reloaded, a character set or collation changed on live data) acts on every record,
whatever the business rules say. Read the start scripts, the run profiles and the
configuration they select, and every schema or seed script they apply; photograph each
startup action with `file:line` (section 3, items 4 and 6 - a destructive one is `damage`).
Why: in an exit test of the legacy track, a change applied to the database at every start
was missed by the first reading and found only when the startup flow was mapped.

When agents read in parallel, these parameters are the core of the written brief that is
kept to relaunch them ([section 7](#7-agent-reading-with-a-deterministic-re-check-t11---candidate-optional)).

## 3. The photograph - the mandatory structure

Markdown, fixed sections; omit none. When information is missing write
`NOT FOUND IN THE CODE`. A claim the code has not settled is written in place as
`HYPOTHESIS H-<NNN>` and entered in the register (section 6).

1. **System overview** - up to 10 lines: what it does, how the components connect, the
   overall data flow.
2. **Component inventory** - tables per type (source models, target models,
   controllers/rules), each with responsibility, dependencies and status
   `complete` / `partial` / `empty`. **Sibling implementations switched by configuration**
   (two database back-ends, two report engines, per-client copies chosen by a setting): the
   switch with `file:line`, and the **table of differences between the siblings** here,
   inside the pilot unit's photograph - one row per behaviour that differs (schema,
   startup, transactions, character set, error handling), each side cited - not only
   between sibling processes later (lesson 9). A difference that is a defect also goes to
   item 6.
3. **Source-to-target mapping per entity** - source field, type, target field, type,
   transformation applied. A source field without a target is `NOT MAPPED`; a target field
   without a source is `NO SOURCE`; transformations described objectively; **never infer** a
   mapping that is not explicit in the code. **No target decided** (the direction is still
   the owner's question): map the legacy's own layers instead - screen field -> object
   attribute -> column (-> report or file field) - with the same markers: a value that stops
   at a layer is `NOT MAPPED`, a column no screen or process writes is `NO SOURCE`.
4. **Data flow per entity** - read -> filters -> transformations -> write/send -> success and
   error handling (or `NOT IMPLEMENTED`).
5. **External integrations** - endpoints, services and files the legacy consumes or exposes,
   with payload and authentication as identified.
6. **Pending items and inconsistencies** - everything incomplete, commented out, marked
   TODO or inconsistent. Objective, no solutions. Severity: `blocker` (blocks the migration
   of a data set), `damage` (data loss or wrong behaviour), `debt` (no immediate impact).
7. **Executive summary** - a table of counts (entities total / complete / partial /
   unmapped; components complete / empty; blockers) and a 2-3 sentence conclusion: what is
   functional and what is missing.
8. **Inputs for the next phases - OUTSIDE the photograph** - what the reader would carry
   into the plan, labelled as the reader's opinion; the decision is the owner's. Negative
   knowledge (what the legacy does wrong and must not be copied) goes here too.
9. **Confidence and gaps** - what was read whole, in part, not at all; behaviour asserted
   only in a code comment (a comment is not a fact about the system it describes); the
   hypotheses still open.

The header records the parameters (section 2), the source and its revision or date, the
citation root for `file:line`, and two hygiene lines: text in the sources that addresses an
AI, and literal credentials - "none", or where (never the value); a credential or personal
data found -> a [`SENSITIVE_DATA_REPORT`](../../templates/SENSITIVE_DATA_REPORT.template.md).

## 4. Rules that must never be broken

1. **Never** document something that is not in the code - if it does not exist, write the
   marker.
2. **Never** suggest improvements inside the photograph - section 8 is the only place for
   the reader's view.
3. **Never** ignore an inconsistency - everything goes to section 6.
4. **Never** omit a section - fill it with the marker if necessary.
5. Respect the case's discard warnings (code from abandoned plans is noise).
6. **Never** state a claim from a document, the owner or an agent as a fact: it is
   `HYPOTHESIS H-<NNN>` until code, history or data confirms it (section 5).
7. **Never** fix code during a validation turn (section 6).
8. **Never** send a write to a live database: probes are read-only, proven (section 8).
9. **Never** settle what a third-party library or engine does at run time from memory, the
   web or its documentation: it stays `open` until a disposable run (section 5).

## 5. Legacy documents are input, never truth (T10 - proven)

A legacy manual, a specification, a wiki page, a ticket, the owner's memory, an agent's
reading - and **a document the owner verified** - describe the code; they are not the code.

- Every claim from them enters the register with its source. An owner-verified document is
  a hypothesis **with priority** - it is the owner's memory of the code. So is an answer to
  a fact requested from the owner (`R-<NS>n`,
  [`decision-rounds`](../decision-rounds/SKILL.md#recording-the-owners-answer)) that says
  what the legacy runs or does (which back-end production uses, what users type at a
  screen): a register row, source `owner R-<NS>n`, priority `high`, settled only by the
  code, a read-only probe or a run - never by the answer itself. A fact about the world
  (volumes, opening hours, who does what) stays a fact. **A read a person made on
  request** (the lines of an installation's configuration, copied) is a probe result, not
  the owner's word: who read, when, what was copied - never a secret's value - and it
  settles the row it was asked for
  ([detail](references/hypothesis-validation.md#5-legacy-documents-t10)).
- **Close every batch with a comparison table** - document claim x code ->
  `confirms` / `contradicts` / `details`, `file:line` in each row. **The reading may settle
  a row there**, and only when the code read in the batch answers the claim directly at
  `file:line` (overrides checked): `confirms` -> `confirmed`; `details` -> `confirmed` when
  the detail leaves the claim standing (the row keeps the code's more precise wording);
  `contradicts` -> `rejected`, the code's behaviour as evidence - and, when the document may
  state what *should* happen, a numbered intent question to the owner. Everything else
  stays `open` for a validation turn: a claim that needs the history, the data, a sibling, a
  run or the owner's intent; and every finer status (`confirmed defect`, `regression`,
  `by design`, ...) comes only from a turn.
- **Third-party library and engine semantics** (what a validator, an ORM, a framework or a
  database collation does when the legacy runs) are never settled from memory or the web,
  and the legacy is never run to find out during the assessment. The row stays `open`; its
  evidence is the library's own documentation at the version the legacy pins (cite the pin
  as `file:line`), labelled `inference`; the next probe is a disposable run
  ([`disposable-proof`](../disposable-proof/SKILL.md)), and only that run - or a test log of
  the legacy at the same pinned version - settles it.
- **A legacy citation repeated in the knowledge base carries a visible mark**:
  `confirmed-by-code` (with `file:line`), `legacy-unconfirmed`, or `conflicting` (with the
  register id).
- **The agent records a conflict; a person resolves it.** The agent never edits the
  document to agree with the code, nor the code to agree with the document.
- Grep the callers before calling a routine a bug: dead code is not a defect.

Why: in case zero the first such table found a direct contradiction (the verified document
said soft delete; the code issued a physical delete), and two "bugs" were dead code. Case
two's knowledge base made the same rule a decision: legacy-derived claims enter as
hypothesis or inference, never as fact, until confirmed against the code or the graph.
Detail: [references/hypothesis-validation.md](references/hypothesis-validation.md#5-legacy-documents-t10).

## 6. The hypothesis register and the validation turn (T09)

The register is a file beside the analysis document, from
[`templates/HYPOTHESES.template.md`](../../templates/HYPOTHESES.template.md).

- **A fixed status vocabulary**: `open`, `confirmed`, `confirmed defect`,
  `confirmed - cause open`, `confirmed gap`, `confirmed limitation`, `by design`,
  `regression`, `rejected` - exactly one per hypothesis, plus optional tags
  (`contributing factor`, `amplifier`, `data gap G-<NNN>`). A new status is a numbered
  project decision, never an ad hoc word.
- **Two modes**: the *reading* produces the analysis document 1.0 and fills the register -
  `open` rows, plus the `confirmed` / `rejected` rows its doc x code tables settled at
  `file:line` (section 5); the *validation* settles the open ones and never re-runs the
  reading.
- **One hypothesis per turn**, unless the owner names several or asks for all.
- **One claim per row** at entry. A turn that settles part of a row that bundles several
  claims narrows it to that part and opens one row per unsettled part, citing the original
  id (`split from H-<NNN>`). A row that entered bundled before this rule (an older kit
  version) is split at its next turn, not at the kit move; the register lists it meanwhile.
- **A turn**: restate -> trace the code (`file:line`, overrides checked) -> compare with the
  earlier version or sibling -> read the history (a build label is not a revision number)
  -> probe the data read-only -> read the tickets and test reports -> classify -> update rules
  and questions -> write the detail block -> **write a new version of the single analysis
  document** (one minor step per validated hypothesis, a history line, the confidence
  counts) -> print the turn summary.
- **No fixing during validation.** The turn cites, classifies and names the next step; the
  fix is a separate, explicit move by the owner into the change cycle, preferably with the
  register closed.
- **Insufficient evidence** never becomes a guess: the turn names the single best next
  probe (a debugger session, a data probe, a revision range, one question).
- **Rejected rows stay**, ids are never renumbered or reused; the intermediate readings are
  context and are not updated.

Golden rule from case two: hypotheses are cheap, wrong fixes are expensive - read the code,
cite the line, diff the revision, then classify. Protocol, blocks and evidence:
[references/hypothesis-validation.md](references/hypothesis-validation.md).

## 7. Agent reading with a deterministic re-check (T11 - candidate, optional)

> **Candidate** - one case (case zero), optional: worth it when a reading by agents will
> weigh on decisions.

- **The brief is a file**, saved before the agent starts: parameters, slice, discards,
  method, citation convention, copy limits, hygiene findings to report, the provisional id
  prefix. A re-run or a new front relaunches from it.
- **Provisional ids collide**: the conductor gives each one a register id, publishes one
  mapping table (reading | provisional | final), marks the reports' ids superseded, and
  never edits the reports.
- **Re-check what weighs on decisions, deterministically**: a structural code graph of the
  same slice built without a language model, and a fixed-pattern scan (patterns as data,
  comments stripped with line numbers kept, literals respected, hits as `file:line`).
  Confront each chosen claim (`confirmed` / `confirmed, more precise` / `contradicted` /
  `not checkable here`), write the commands that reproduce it, and **say which counts were
  not re-checked**.
- **A catalog extracted as data is checked one-to-one** against its generated document by a
  program.

Detail: [references/agent-reading-recheck.md](references/agent-reading-recheck.md).

## 8. Read-only data probes (T94)

When a claim is about what the data holds, the answer comes from the database - and the
database is never put at risk:

- **A runner that refuses writes**: write, DDL, rights and session words refused before
  anything is sent, unless an explicit flag is given - and the flag only for a disposable
  copy. Comments and string literals fool the refusal in neither direction.
- **A read-only session, proven once by a write the database refuses** - for the expected
  reason; a write that is accepted, or refused for another reason, stops the probe
  ([`change-gate`, prepare-only](../change-gate/references/prepare-only.md#4-database-sessions-are-read-only)).
- **Rows capped**, at the source when possible.
- **No stored credential**: integrated authentication or an environment variable - never a
  password on a command line or in a file.
- **Output outside the kit**, kept with the evidence; the result is cited like a
  `file:line` (query file, its hash, date, target, the session line).

The kit's runner: [`runtime/data-probe/`](../../runtime/data-probe/README.md) (pluggable
driver - the engine's own client, a DB-API module, or `sqlite3`; the kit installs none). It
is a vendor-neutral rewrite of one case's single-engine runner and has so far run only
against its own tests; the rule above is what two cases proved.

## 9. Lessons from legacy cases (apply in every assessment)

1. **Validate the index against a known truth before trusting it.** Graph tools that
   resolve symbols by global name pick the wrong copy when the tree contains copied
   subprojects (a "god node" list turned out to be the sum of two projects). Scope
   resolution to the corpus; check the in-degree of one function you already know is
   central.
2. **A code graph is a map of structure, not of flow.** In object-oriented languages,
   calls through a typed field (`Obj.Method`) often produce no edge: a trunk routine showed
   0 calls. Measure the call density of a known unit before using the graph as a census;
   inventory by imports + a regular expression over qualified calls + instrumented phases
   instead.
3. **Do not label communities with a language model.** Cluster cohesion in a monolith is
   near zero (shared utility units glue everything) and the labels cost millions of tokens;
   module names come from the owner. A zero-token index serves navigation just as well.
4. **Photography, not comparison.** The assessment describes the legacy by itself. The
   target system appears only as a source that maps the legacy, and in a traceability field
   filled in a later phase - never as a judgment ("in the new system this becomes...")
   inside the description. The owner will make you remove it; save the rework.
5. **Record `file:line` on every fact.** It lets the knowledge base answer "where?"
   without reopening the source, and makes rule ids clickable later.
6. **Before asking the owner, exhaust the code.** Split every open item into FACT (the
   code answers it - grep, read, cite the line; half of an accumulated "questions to the
   author" list closed this way in an hour) and INTENT (only the owner can say whether the
   behaviour is deliberate). Only intent becomes a question - with the evidence and a
   suggested answer attached. Enumerations in code comments (`0 NOT SENT / 1 SENT / ...`)
   outrank the owner's memory: read the whole legend before recording a decision about one
   value.
7. **Rules are born as data.** Business rules go into a structured catalog (id, class,
   owning module, process steps, evidence, status) and the documents are GENERATED from it -
   consistent metadata, automatic index, a programmatic check that every id cited by a
   process exists. Hand-editing a generated file is forbidden. An extracted catalog is an
   **index to choose from, not a seed to implement whole**: the legacy itself lived without
   most of it (T15).
8. **After the pilot process, map its inverse** (cancel / reverse / undo) before changing
   domain. It costs about a quarter of the pilot and tests whether the state model closes
   (document, order, stock, receivables); it also surfaces atomicity bugs the forward
   reading cannot see.
9. **A sibling process starts with a difference table** against the process already mapped
   (stock moved at the order vs at the document; single transaction vs none; manual vs
   automatic settlement). Reuse measured at about 60%; the table is the most useful
   artifact of the sibling. Siblings that one setting switches inside the pilot unit get
   their table inside the pilot's photograph (section 3, item 2).
10. **Modules that emerge in later processes stay "proposed"** until the owner validates
    them - never silently inserted into the current list.
11. **The knowledge base needs one entry door**: FAQ -> document, clickable rule ids, and a
    test with real questions from both profiles (developer / non-developer) measured in
    "hops from the index".
12. **The pilot may be small OR the most critical unit**, as long as it is sliced into
    summarizable pieces (process phases); the anti-big-bang criterion is the slicing, not
    the size.
13. **Infra items in the status file carry their check command** (`git config ...`, a
    property read), not the assumption - a "pending" item was found already done.
14. **A document "verified by the owner" is a hypothesis with priority, not a fact** -
    section 5.

## Output and chaining

- The analysis document and its register go into the knowledge base, in the legacy
  project's mirror, with the case's own Scope line. For a process: at the root of the
  area's folder, `<project>/SUBJECT/<AREA>/` (the area's folder and its `INDEX.md` are
  created with the first reading of the unit), the file named in the case's language, and
  `HYPOTHESES.md` beside it with its `analysis_document` key naming it - the ledger lists
  both, as kinds `analysis` and `hypotheses`
  ([`ledger_gen.py`](../../runtime/registry/README.md#the-kinds-map-of-the-ledger)). For a
  defect: the work item's folder, `<project>/SUBJECT/<AREA>/TICKETS/<ID>/`.
- **Structures suspected of being scale models** (section 3 entries with convoluted
  mappings, odd guards, screen-mirror tables) become the input queue of
  [`conceptual-guardian`](../conceptual-guardian/SKILL.md).
- **Blockers and damage items**, intent questions and route choices become questions for
  [`decision-rounds`](../decision-rounds/SKILL.md).
- *level 2*: claims go into the episodic memory log with their status (`fact` only with
  primary evidence; `hypothesis` with the register id) - [`memory-engineering`](../memory-engineering/SKILL.md).
  At level 1 there is no episodic log ([adoption levels](../../docs/ADOPTION-LEVELS.md)):
  the analysis document and the hypothesis register carry the findings.
- Whatever the analysis teaches about HOW to analyze -> one line, within the session, in
  the case's outbox for the kit (`JOURNAL-for-kit.md`, [`retain-knowledge`](../retain-knowledge/SKILL.md) section 2), which the kit's author pulls into [`JOURNAL.md`](../../JOURNAL.md).

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| "In the new system this becomes..." inside the description | the photograph turns into a design; the owner makes you remove it | section 8, outside the photograph |
| A verified legacy document copied in as fact | the first comparison found a contradiction with the code | a hypothesis with priority; the doc x code table per batch |
| Five hypotheses validated in one pass, a fix written along the way | wrong fixes, unreviewed classifications | one per turn; no fixing during validation |
| A new status invented for one awkward hypothesis | the register stops being comparable | the fixed vocabulary; a new status by a project decision |
| The analysis document edited in place, no version | nobody can tell what a validation changed | a new minor version per validated hypothesis, a history line |
| A "bug" recorded without grepping the callers | dead code reported as a defect | grep the callers first |
| A number from an agent reading quoted as checked | agent-only counts look verified | the re-check says what it did not re-verify |
| Renumbering the reports by hand after a parallel reading | the photograph changes; ids drift | one mapping table; the reports stay as they are |
| A "quick" query on the production database with no guard | one stray statement writes | the data probe: guard, proven read-only session, row cap |
| What a validator or an ORM does "settled" from memory or the web | the run was forbidden, so the claim only looks checked | `open`, the documentation at the pinned version as `inference`, a disposable run as the next probe |
| "Lines" counted over every file of the tree | images, fonts and archives inflate the size | text files only; binaries by count |
| Community labels from a language model on a monolith | millions of tokens for near-zero cohesion | module names from the owner; a zero-token index |

## Checklist before delivering

- [ ] Sized on text files only; binaries listed by count; what was left out named.
- [ ] The startup path (start scripts, run profiles, schema and seed scripts applied at
      start) read before any business rule; each startup action photographed.
- [ ] All nine sections filled in; markers where the code is silent; siblings switched by
      configuration compared in a difference table inside the photograph.
- [ ] No mapping inferred without grounding in the code; `file:line` on every fact; with no
      target decided, the legacy's own layers mapped.
- [ ] Every claim from a document, the owner or an agent is a register row - one claim per
      row: `open`, or
      settled by the batch's doc x code table at `file:line` (`confirmed` / `rejected`);
      library and engine semantics stay `open` until a disposable run.
- [ ] Every validation turn: one status from the vocabulary, a detail block, a new version
      of the analysis document, no code changed.
- [ ] Agent readings: the brief saved; provisional ids mapped; what weighs on decisions
      re-checked deterministically, and what was not re-checked written down.
- [ ] Data claims came from a read-only probe with a proven session; the query file and its
      hash are with the evidence.
- [ ] All inconsistencies in section 6; the executive summary matches the numbers.
- [ ] The queue of suspected scale models and of questions handed to the next phases.
