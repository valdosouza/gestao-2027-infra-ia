---
project: <KEY>
subject: <AREA>
work_items: [<id>]                 # optional: the work item a defect investigation serves
analysis_document: <relative link to the single analysis document>
analysis_version: "<X.Y>"          # the version the last validation turn produced
last_updated: <YYYY-MM-DD>
tags:
  - hypotheses
---
# Hypotheses - <what is being assessed, in one line a reader would recognise>

**Scope**: <method|case|mixed>
**Analysis document**: <link> - version <X.Y> (the single source of truth; this register feeds it)
**Open**: <n> of <total> | **Last turn**: <YYYY-MM-DD>, H-<NNN>

> Template from the engine-kit (`templates/HYPOTHESES.template.md`) - techniques T09
> (*operating*) and T10 (*proven*). The hypothesis register of one legacy assessment or
> one defect investigation, kept beside its single analysis document (the area's folder
> for a process, the work item's folder for a defect). Every claim that does not come
> from the code itself - a legacy document, a document the owner verified, the owner's
> memory, a ticket, an agent's inference - enters here with its source: `open`, unless the
> reading's document-vs-code table settled it at `file:line` (`confirmed` / `rejected`). Ids are `H-<NNN>`,
> permanent, never renumbered or reused; a rejected row stays. Replace every
> `<placeholder>`, delete the sections that do not apply, and delete this note. Method:
> the `assess-legacy-repo` skill, sections 5 and 6, and its reference
> `hypothesis-validation.md`.

## Status vocabulary (fixed)

Exactly one primary status per hypothesis. The case never invents a status in a row; a
new status is a numbered decision of the project, added here first.

| Status | Use when |
|---|---|
| `open` | not validated yet |
| `confirmed` | the code (`file:line`), its history or a read-only probe (a data probe, or a read a person made on request) shows the claim holds as stated |
| `confirmed defect` | it holds, and the code breaks an explicit business rule - cite the rule |
| `confirmed - cause open` | the behaviour is confirmed; its exact cause needs a run or a debugger - the next probe is named |
| `confirmed gap` | the claim points at something the code lacks (a step, a hook, a path), not a one-line fault |
| `confirmed limitation` | it works as coded, and that is not enough for the stated need |
| `by design` | intentional behaviour, not a defect (it may amplify another one) |
| `regression` | a later change broke a separate path - the revisions are cited |
| `rejected` | the evidence disproves the claim; the row stays, with the reason |

Secondary tags (optional, any number): `contributing factor`, `amplifier`, `data gap G-<NNN>`.

## Register

**Source** says where the claim came from: `legacy doc <document, section>`,
`owner-verified doc <document, section>`, `owner <date>`, `owner R-<NS>n` (an answer to a
fact requested in a round, about what the legacy runs or does - priority `high`, settled
only by the code, a read-only probe or a run), `ticket <id>`,
`reading <analysis section>`, `agent report <n>`, `split from H-<NNN>` (plus that row's
source). **Claim** is a single claim, one that one probe can settle: an answer or a
document that states several things is one row per claim at entry; a turn that settles
part of a bundled row narrows it to that part and opens one row per unsettled part, citing
the original id (`hypothesis-validation.md`, section 4, rule 9); a row that entered bundled
before that rule is split at its next turn and listed meanwhile (section "Bundled rows"
below). **Evidence** is primary only: `file:line`,
a revision, a probe result (query file and its hash; or a read a person made on request -
who read, when, what was read and what was copied, never a secret's value), a test or run
log - never "the document says". **Version** is the analysis-document version in which the
status was set.

| ID | Claim (one line) | Source | Where (unit, step) | Priority | Status | Evidence | Version |
|---|---|---|---|---|---|---|---|
| H-001 | <claim> | <source> | <unit or process step> | <high/medium/low> | `open` | - | <X.Y> |
| H-002 | <claim> | <source> | <...> | <...> | `rejected` | <file:line - what the code does instead> | <X.Y> |
| H-003 | <the part a turn settled - the row narrowed> | owner R-<NS>n | <...> | high | `confirmed` | <read on request: who, when, the lines copied> | <X.Y> |
| H-004 | <a part H-003 bundled, still unsettled> | split from H-003 (owner R-<NS>n) | <...> | high | `open` | - | <X.Y> |

## Bundled rows - split at their next turn

*(When rows entered with several claims before the one-claim rule, under an older kit
version.)* A kit move does not split them: each one is split by its next validation turn
(narrowed to the part it settles, one new row per unsettled part); that turn fills the
row's last cell.

| Hypothesis | Claims it bundles | Listed since | Split at |
|---|---|---|---|
| H-<NNN> | (1) <claim>; (2) <claim> | <YYYY-MM-DD> - the kit move that brought the rule | waiting \| turn <n>, <YYYY-MM-DD> - opened H-<NNN> |

## Validated hypotheses

One block per validated hypothesis, in the order treated. A later turn that changes a
status adds a new block that cites the earlier one; it never rewrites it.

### H-<NNN> - <the claim> (treated <ordinal>, analysis <X.Y>)

| Aspect | Finding |
|---|---|
| Claim | <the original one-line wording> |
| Source | <where it came from> |
| Code behaviour | <what the code actually does - `file:line` for every statement> |
| Earlier version or sibling | <the same routine in the version or the sibling that worked, `file:line` - or n/a> |
| History | <revisions, dates, authors; a build or package label is not a revision number - or n/a> |
| Data | <read-only probe: query file, hash, date, target, the rows that matter; or a read a person made on request: who, when, what was read, the lines copied (never a secret's value) - or n/a> |
| Split | <none, or: narrowed to <the settled part>; opened H-<NNN>, H-<NNN> for the unsettled parts> |
| Tickets and tests | <what the reports and the tests observed - or n/a> |
| Status | `<status from the vocabulary>` - <one sentence why> |
| Rules | <rule ids promoted, rejected or unchanged> |
| Questions | <resolved, or opened - only INTENT goes to the owner, with the evidence and a suggested answer> |
| Direction | <the action it points to, by id - no code> |
| Next | <the single best next probe, or the next H-<NNN>> |

## Validation turns (append only)

One row per turn. A turn validates one hypothesis unless the owner named several or asked
for all of them. A turn never fixes code.

| Turn | Date | Hypothesis | Status before -> after | Analysis version | Rules and questions touched | Next |
|---|---|---|---|---|---|---|
| 1 | <YYYY-MM-DD> | H-001 | `open` -> `<status>` | <X.Y> -> <X.Y+0.1> | <ids> | H-002 |

## Data gaps

What a validation could not obtain. A gap is a fact to fetch, not a question to the owner.

| ID | What is missing | Blocks | How to obtain |
|---|---|---|---|
| G-001 | <the data, file, log or access> | H-<NNN> | <the probe, the person, the request> |

## Provisional ids from parallel readings

*(When several agents read at once and each proposed its own ids.)* The conductor gives
every provisional id one register id; the readings' own ids are superseded by this table.

| Reading | Provisional id | Register id | Note |
|---|---|---|---|
| <report> | <its id> | H-<NNN> | <merged with H-<NNN> / new> |

## Register closed

*(When no hypothesis is `open`.)*

| Item | Value |
|---|---|
| Analysis document | <link> - version <X.Y> |
| Confirmed defects | H-<NNN>, ... |
| Gaps and limitations | H-<NNN>, ... |
| By design | H-<NNN>, ... |
| Rejected | H-<NNN>, ... |
| Ready for the change | <yes - the action ids it opens> / <no - the blockers> |

*(A fix designed while rows are still `open`: the plan names them on its line
`Open hypotheses accepted as risks: H-<NNN> - why the change can go on with it open; what
would settle it` - the `PLAN` template.)*
