# Hypothesis validation - the register, the turn, the new version

**Scope**: method

Companion of the [`assess-legacy-repo`](../SKILL.md) skill, sections 5 and 6 (techniques
T09 and T10). The register itself is
[`templates/HYPOTHESES.template.md`](../../../templates/HYPOTHESES.template.md).

## 1. Two modes

| Mode | Asked as | Runs | Produces |
|---|---|---|---|
| **Reading** | "assess this legacy", "photograph process X" | the photograph (skill section 3), on the case's parameters | the analysis document **1.0**; every claim the code did not settle, marked `HYPOTHESIS H-<NNN>` in place and entered in the register as `open`; the claims a doc x code table settled at `file:line`, entered as `confirmed` or `rejected` (section 5) |
| **Validation** | "validate H-003", "next open hypothesis", "validate all" | one validation turn (section 3 below) per hypothesis | the register row and its detail block, and a **new version** of the analysis document |

A validation never re-runs the reading. The owner asks for a new reading explicitly - then
it is a new major version of the analysis document, and the register carries over.

## 2. Where things live

- **One analysis document** per assessed process or investigated defect - the single source
  of truth, versioned `X.Y` in its header, its footer and a history section. It lives in
  the folder of the work it serves: the root of the area's folder for a process
  (`<project>/SUBJECT/<AREA>/`), the work item's folder for a defect.
- **One register** (`HYPOTHESES.md`) beside it; its `analysis_document` key names the
  analysis document, which is how the ledger finds it.
- **The intermediate readings** (each agent's report, each front of a parallel reading) are
  context. They are not updated during validation, and where they disagree with the
  analysis document, the analysis document wins.

## 3. A validation turn

Execute every step that applies; a step that cannot run because a resource is missing is a
data gap (`G-<NNN>`), written, never skipped in silence.

1. **Restate** the hypothesis: id, wording, source, where (unit, process step), current
   status - and, when the row bundles several claims, each part (section 4, rule 9).
2. **Trace the code** - mandatory wherever a code path exists. Find the entry points from
   the process step, read the implementation, and check whether the unit is overridden
   (a per-client copy, a sibling project that shadows it) before concluding anything about
   the base behaviour. Every statement cites `file:line`; a statement without one stays
   unverified. Grep the callers before calling a routine a defect: dead code is not a bug.
3. **Compare with the earlier version or the sibling**, when the case names one: the same
   routine where it worked. Classify the difference as intentional, regression or an
   incomplete migration (a property set and never read, a cross-day rule that was lost).
4. **Read the history**, when the claim involves changes, builds or a fix attempt: the log
   filtered by the work-item id, the diff between the revision before and the fix. A build
   or package label is **not** a revision number: map it by date and message, never by
   reading the label's digits.
5. **Probe the data**, when the claim is about what the database holds - through a
   read-only probe ([`runtime/data-probe/`](../../../runtime/data-probe/README.md)); the query
   file and the result's hash are the evidence. A read only a person can make (an
   installation's configuration, a production screen) is asked for in a round, and its
   answer is a probe result too (section 5).
6. **Read the tickets and test reports**: reproduction steps, what testers observed, which
   build they tested. They align with the code findings or contradict them - say which.
7. **Classify**: exactly one status from the fixed vocabulary of the template, plus any
   secondary tags. When the evidence is not enough, the status stays `open` (or becomes
   `confirmed - cause open`) and the turn names **the single best next probe** - a debugger
   session, a data probe, a revision range, one question - never a guess.
8. **Rules**: an implicit rule the turn confirmed is promoted to a numbered rule; a rejected
   one is kept with its resolution; a new contradiction between sources gets its own id.
   Where the project keeps rules as data, the change goes to the catalog and the documents
   are regenerated (lesson 7 of the skill).
9. **Questions**: an answered question moves to the resolved list with its resolution
   text. Only **intent** goes to the owner - with the evidence and a suggested answer
   ([`decision-rounds`](../../decision-rounds/SKILL.md)); a fact the code can settle is
   never a question.
10. **Write the detail block** in the register and update its row (status, evidence,
    version).
11. **Write the new version of the analysis document**: the paragraph that carried the
    `HYPOTHESIS H-<NNN>` marker now carries the status and the evidence; the version goes
    up one minor step; the history gains one line; the confidence counts are updated
    (hypotheses still open, inferred findings left, open questions).
12. **Print the turn summary** (section 6) and stop.

## 4. Rules of the turn

1. **One hypothesis per turn**, unless the owner names several or asks for all; a turn
   that runs out of context ends cleanly and the next one resumes at the next id.
2. **Never promote a hypothesis to a fact** without primary evidence: `file:line`, a
   revision, a probe result (a query file and its hash, or a read a person made on
   request, recorded as section 5 says), a test log.
3. **A rejected hypothesis stays in the register**, status `rejected`, with the reason.
   Rows are never deleted, ids never reused or renumbered.
4. **No fixing during validation.** The turn cites, classifies, updates the documents and
   names the next step. Writing the fix is a separate, explicit move by the owner into the
   change cycle ([`change-gate`](../../change-gate/SKILL.md)) - and the register should be
   closed, or its open rows named as accepted risks, before the fix is designed. They are
   named in the plan, on its line `Open hypotheses accepted as risks: H-<NNN> - why the
   change can go on with it open; what would settle it`
   ([PLAN template](../../../templates/PLAN.template.md)); a row the fix does depend on is
   validated first, or becomes one of the plan's fact premises, rewritten if a later turn
   contradicts it.
5. **A debugger step is a valid outcome**, recorded as the next step, not as a failure.
6. **A regression hypothesis always gets the diff**, and the detail block warns against
   the fix pattern that broke the other path.
7. **The intermediate readings stay as they are**: the validation writes only the register
   and the analysis document.
8. **Library and engine semantics need a run.** A claim about what a third-party library,
   framework or database engine does when the legacy runs (a validator, an ORM, a
   collation) is never settled from memory, the web or the documentation, and the legacy
   is never run to find out during the assessment. The row stays `open`; the library's own
   documentation at the version the legacy pins (the pin cited as `file:line`) is recorded
   as evidence labelled `inference`; the turn names a disposable run as the next probe
   ([`disposable-proof`](../../disposable-proof/SKILL.md)). Only that run - or a test log of
   the legacy at the same pinned version - settles it.
9. **One claim per row.** A row enters with a single claim, one that one probe can
   settle: an answer or a document that states several things (a revision, a run
   profile, a server version, how a secret reaches the server) is one row per claim at
   entry, each with the same source.
   A turn that settles part of a row that still bundles several claims **narrows** it - the
   row keeps the settled part, with its status and evidence, and its claim is cut to that
   part (the detail block keeps the original wording) - and opens **one new row per
   unsettled part**, `open`, source `split from H-<NNN>` plus the original source, the
   same priority. The turn summary names the split; the original id never takes another
   claim.
   **A row that entered bundled before this rule** (under an older kit version) is not
   split when the kit moves: it is split at its **next validation turn**, the same way
   (narrowed, one new row per unsettled part). Until that turn the register lists it under
   "Bundled rows - split at their next turn", with the claims it bundles.

## 5. Legacy documents (T10)

- **Everything that does not come from the code enters as a hypothesis**: a legacy manual,
  a specification, a wiki page, a ticket's description, the owner's memory, an agent's
  inference - and **a document the owner verified**. That last one is a hypothesis with
  priority: it is the owner's memory of the code, and the first comparison in the source
  case found a direct contradiction (the document said soft delete; the code issued a
  physical delete).
- **An owner's answer about what the legacy runs or does** - an answer to a fact requested
  in a round (`R-<NS>n`), such as which back-end production uses or what users type at a
  screen - is a register row, source `owner R-<NS>n`, priority `high`
  ([`decision-rounds`](../../decision-rounds/SKILL.md#recording-the-owners-answer)). Only
  the code, a read-only probe or a disposable run settles it; the answer never does, and
  the owner's confirmation of it does not promote it. A row about what an installation
  runs is not `rejected` by the code's defaults alone - the running configuration may
  differ - so the turn names the probe (a read of the installation's configuration, a
  query). A fact about the world (volumes, opening hours, who does what) stays a fact; an
  environment the code constrains (a server or runtime version, a profile, the database it
  selects) is a claim about the system - a hypothesis.
- **A read a person made on request is a probe result**, not an owner's claim. When the
  probe is a read only a person can make (the lines of an installation's configuration, a
  production screen, whether a secret is set), the round asks for it as a fact request,
  and the answer that carries it settles the row it was asked for - and only that row.
  Its evidence names who read, when, what was read (the file, the screen, the command)
  and what was copied, quoted as copied; never a secret's value - for a secret, only
  whether it is set and where. An answer that states the result without the read ("it is
  the second profile") is still the owner's claim, above.
- **Close every batch with a comparison table** - document claim x code ->
  `confirms` / `contradicts` / `details` - with `file:line` in each row. Each row is a
  register row, and **the reading may settle it** when the code read in the batch answers
  the claim directly at `file:line` (overrides checked):

  | Table | Register status at the reading |
  |---|---|
  | `confirms` | `confirmed`, the `file:line` as evidence |
  | `details` | `confirmed` when the detail leaves the claim standing (the row keeps the code's more precise wording); otherwise `open` |
  | `contradicts` | `rejected` for the claim, the code's behaviour as evidence; when the document may describe what *should* happen, also a numbered intent question to the owner |
  | any of them, when the answer needs the history, the data, a sibling, a run or the owner's intent | `open`, for a validation turn |

  Every finer status (`confirmed defect`, `confirmed - cause open`, `regression`,
  `by design`, ...) comes only from a validation turn.
- **A legacy citation carries a visible mark** wherever the knowledge base repeats it:
  `confirmed-by-code` (with the `file:line`), `legacy-unconfirmed`, or `conflicting` (with
  the register id). The mark changes only when the register does.
- **A conflict is recorded by the agent and resolved by a person.** The agent never edits
  the legacy document to agree with the code, nor the code to agree with the document.

## 6. The written blocks

Turn summary, printed at the end of every turn:

```text
HYPOTHESIS VALIDATION - H-<NNN>
Status      : <status>
Evidence    : <file:line / revision / probe / a read on request (who, when) / test - one line each>
Split       : <none | narrowed to <the settled part>; opened H-<NNN>, H-<NNN>>
Rules       : <promoted / rejected / unchanged>
Questions   : <resolved / opened / none>
Document    : <analysis document> -> <X.Y>
Next        : <H-<NNN+1> | the single best next probe | the action id>
```

Register closed, printed when no hypothesis is open:

```text
HYPOTHESIS REGISTER CLOSED
Process        : <name>
Document       : <analysis document> <X.Y>
Defects        : <ids with status confirmed defect>
Gaps / limits  : <ids>
By design      : <ids>
Ready for fix  : <yes - the action ids> | <no - the blockers>
```

## 7. Evidence

- **Case two** (a multi-developer product team, a legacy-process analysis chain): five
  reading agents and a consolidator produced one analysis document at 1.0; a validation
  agent then took one hypothesis per turn, classified it in a fixed vocabulary of eight
  statuses with code, history and ticket evidence, and bumped the document a minor version
  per turn until the register closed. The golden rule there: hypotheses are cheap, wrong
  fixes are expensive. The same base adopted a decision that legacy-derived claims enter as
  hypothesis or inference until confirmed against code or graph, with the three citation
  marks above.
- **Case zero** (the modernization of a legacy business application): the owner-verified
  document compared against the code per batch; the first table found the contradiction
  quoted in section 5, and two "bugs" turned out to be dead code once the callers were
  searched.
