---
name: result-review
description: Use when someone asks to review the result of another person's change ("review this change", "check open reviews", "which revision broke it") or a process change must be proven on a real item - maps every revision of the work item, never one alone, writes a review file with file:line findings and an open/acknowledged/resolved handshake, names the culprit revision, and runs exit tests and dry runs.
---

# Skill: Result review (the result, every revision, a handshake)

**Scope**: method
**Maturity**: operating

**When to use**: someone asks for a review of a work item (a bug fix, a change request, a
task) that another person built; an author resumes a work item that has review files;
a regression must be traced to the revision that caused it; a process, gate or tool was
changed and must be proven on a real item before it is called done.
**Not for**: reviewing the problem or re-deciding the approach (the plan or spec gate of
[`change-gate`](../change-gate/SKILL.md) did that), testing the running application
(that is [`browser-verification`](../browser-verification/SKILL.md)), the scored and
adversarial delivery reviews ([`delivery-gates`](../delivery-gates/SKILL.md)), or fixing
the author's code.
**Real origin**: one case - a multi-developer product team (2026-07 to 2026-10) running a
two-person asynchronous review of committed work items, a bug analysis that names the
culprit revision, and the exit tests and dry runs that proved its own process changes. The
rules below are the corrections that case made. One case, core by choice: `operating`
([maturity](../../docs/MATURITY.md)).
**Parts**: T42 result review (this file); T80 revision forensics
([references/revision-forensics.md](references/revision-forensics.md)); T43 exit tests and
dry runs ([references/exit-tests-and-dry-runs.md](references/exit-tests-and-dry-runs.md)).
The review file starts from [templates/REVIEW.template.md](templates/REVIEW.template.md).
Register: [docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`change-gate`](../change-gate/SKILL.md) (the review is its third
hand-off, after the test gate and the delivery gates; `REVIEW/` in its folder canon),
[`decision-rounds`](../decision-rounds/SKILL.md) (a finding that needs an owner's choice
becomes a numbered question; the rule gate),
[`browser-verification`](../browser-verification/SKILL.md) (its report is evidence the
reviewer reads; a user-visible change is checked there, not in the review),
[`memory-engineering`](../memory-engineering/SKILL.md) (recall before reviewing, the
session log after) and [`retain-knowledge`](../retain-knowledge/SKILL.md) (the update
chain).
**Changelog**: 2026-10-21 - first version (wave 2): T42, T80 and T43 from one case's
two-person review workflow, its bug analysis and the dry runs of its own process changes.

---

## The principle

**Review the result, not the problem.** The object of the review is the code as it was
committed (or the change set under review). The author's notes - dossier, plan, work log -
are context that explains the result; they are not what is judged. The author owns the work
item, has more context than the reviewer, and decides what to do with every finding.

**Never judge one revision alone.** A requested revision is the review *target*, never the
review *context*: earlier revisions of the same work item may already have changed the same
files, functions or behaviour. A recommendation made on one diff can undo an earlier fix,
duplicate it, or reintroduce what was removed on purpose. Map every revision first
([T80](references/revision-forensics.md)); only then review.

Example used throughout (fictional): work item **ORD-42, "Acme Orders: a partial shipment
keeps the order open"**, three revisions `r101`, `r107`, `r112`; the reviewer is asked to
review `r112`.

## Vocabulary

| Term | Meaning |
|---|---|
| Author | the person who built the change and owns the work item; decides on every finding |
| Reviewer | a different person (or an agent working for one) who reviews the committed result |
| Work item | the unit of work in the tracker; its folder in the knowledge base is `<project>/SUBJECT/<NAME>/TICKETS/<ID>/` ([`kb-setup`](../kb-setup/SKILL.md)) |
| Revision | one commit, changeset or merge request in version control |
| Target | the revision(s) the reviewer was asked to review |
| Review file | `REVIEW/REVIEW_<yyyy-mm-dd>_<reviewer>.md` in the work item's folder, one per review round |
| Finding | `F-NN`: one defect, with a severity, `file:line` and a failure scenario |

## Hard rules

1. **Review the result.** The committed code is the object; the author's documents are
   context. Do not re-litigate the chosen approach unless it produces a defect.
2. **Never judge one revision alone.** Map every revision of the work item and read the
   evolution of every overlapping area before the first recommendation
   ([forensics](#revision-forensics-t80)).
3. **Every finding cites `file:line` and a failure scenario** (the input or state, and the
   wrong outcome) **or the rule it violates, quoted**. A finding that cannot be anchored is
   **dropped** before the file is written - not softened into "consider".
4. **The reviewer does not edit the author's code.** Proposed patches go into the review
   file as documentation. The only exception is [APPLIED-URGENT](#the-applied-urgent-exception).
5. **The status handshake**: `open -> acknowledged -> resolved | declined`. The reviewer
   writes `open`; only the author moves it on ([handshake](#the-status-handshake-and-author-mode)).
6. **Open reviews surface before new work.** Any session that touches a work item lists its
   `status: open` reviews first; new work waits until the author has seen them.
7. **Self-review never replaces an independent review** ([below](#self-review-is-not-a-review)).
8. **Prepare-only** (technique T29): the agent never commits, never writes to the tracker
   and never sends a message; it prepares the text and a human executes it
   ([harness ask-list](../../runtime/guards/HARNESS-PERMISSIONS.md)).

## Reviewer mode - steps

1. **Resolve the work item and the target.** The id, the revisions the reviewer was asked
   to look at, the version line (branch) they live on. Never invent an id, a revision or a
   date: write "not specified".
2. **Load the author's context** - read everything in the work item's folder (work log,
   dossier, plan or spec, the test evidence and the browser report in `TESTS/`) and
   recall the area's memory and pipelines for the units the change touches (the
   before-action loop of
   [`memory-engineering`](../memory-engineering/SKILL.md)).
3. **Map every revision** of the work item - mandatory even when one revision was named:
   the revision table and the overlap list ([forensics](references/revision-forensics.md)).
4. **Read the evolution, not the snapshot**: for every overlapping area,
   `original -> earlier revisions -> target`; classify each overlap (kept, undone,
   reintroduced, conflict, duplicate). Read the whole unit where the diff is ambiguous.
5. **Review the result** through the [lenses](#review-lenses-in-priority-order).
6. **Rule check** - where the project keeps rule files
   ([`decision-rounds`](../decision-rounds/SKILL.md), rule gate): a result that brings back a
   behaviour of a **Denied** row, with no newer **Authorised** row, is a `blocker`
   ("regression to a denied rule"); quote the row (number, date, who decided, evidence).
7. **Verify every finding** before writing it: `file:line` + failure scenario, or drop it.
   A doubt that is not a defect goes to *Questions to the author*, not to the findings.
8. **Write the review file** from [the template](templates/REVIEW.template.md) with
   `status: open`; `revisions_reviewed` lists **every** revision inspected, not only the
   target.
9. **Link and hand back**: link the review from the work item's index or work log, prepare
   the notification to the author for a human to send, and report in chat (see
   [Output](#output)).

## Review lenses (in priority order)

1. **History coherence** - does the target preserve, extend, undo, duplicate or contradict
   what earlier revisions of the same work item did?
2. **Correctness** against the stated contract: the acceptance criteria, the plan or spec.
3. **Resource and lifecycle safety** - creation and release on every branch, ownership,
   cleanup scopes, access after release, concurrency.
4. **Unintended behaviour changes** - contracts between tiers (a field name emitted on one
   side and read on the other), payload round trips, side effects on the pipelines the unit
   takes part in.
5. **Regression risk** in the adjacent callers of the changed units.
6. **Conventions** of the project.
7. **Reusable positives** - patterns worth retaining (they feed the area's memory).

Two checks run inside these lenses on every review:

- **Anti-silencing** (technique T34): a guard, an empty catch block or a compiler-warning
  switch added to make a crash or a warning disappear is a `major` finding, not a fix. Ask
  for the lifecycle trace and the cause.
- **Cross-version drift**: when the project keeps several active lines, check whether the
  change reintroduces in this line what another line already removed (the
  [`version-diff`](../../agents/version-diff.md) agent's DIFF, when one exists for the unit).

**The stack checklist belongs to the case.** The language's traps, the ownership rules of
its libraries, the warning classes that matter, the front-end library versions: the case
keeps them in its knowledge base and the lenses call them. Each item becomes a finding only
with `file:line` and a failure scenario.

## Findings, severities and the verdict

| Severity | Meaning |
|---|---|
| `blocker` | wrong result, data loss, a security hole, or a regression to a denied rule; must be fixed before release |
| `major` | a defect in a realistic scenario, or a silenced symptom |
| `minor` | a defect in an edge scenario, or a maintainability cost that will be paid |
| `nit` | style; never blocks |

One finding, one shape: **F-NN - severity - `file:line` - failure scenario - why it
matters (history, rule, contract) - proposal (documentation only)**. Recommendations rest on
the work item's full history, never on the target's diff alone.

| Verdict | When |
|---|---|
| `APPROVED` | no `blocker`, no `major` |
| `REQUIRES CHANGES` | at least one `blocker` or `major` the author can fix inside the approach |
| `REJECTED` | the approach itself produces the defect; the work goes back to the plan or spec gate |

## The APPLIED-URGENT exception

When **the person who asked for the review** states that a correction cannot wait for the
author (a production blocker, a release cut-off), the reviewer may apply it, on these
conditions - all of them:

1. The finding is recorded in the review file marked **`APPLIED-URGENT`**, with what was
   changed and the revision that carried it once a human committed it.
2. The review keeps **`status: open`** - the author must still acknowledge it.
3. The author is notified through the team's normal channel (the agent prepares the text).
4. The urgent fix is a revision of the work item like any other: the next review maps it.

The reviewer's own sense of urgency is not enough; without that statement the default
holds.

## The status handshake and author mode

| Status | Set by | Meaning |
|---|---|---|
| `open` | reviewer | written; the author has not decided yet |
| `acknowledged` | author | read; the decisions per finding are recorded and work is planned |
| `resolved` | author | every finding fixed or declined with a rationale |
| `declined` | author | the review as a whole is rejected, with a rationale |

The status is a front-matter line, so it is grep-able: a session-start check can list every
`status: open` under the work items of a project.

**Author mode - steps** (the author asks to "check reviews", or resumes a work item):

1. List the work item's `REVIEW/REVIEW_*.md`, parse the front matter, and show the
   `status: open` ones first, findings summarised by severity - **before any new work**.
2. For each finding, help the author decide: **fix** (then the fix is normal work on the
   author's own item), **decline** (with a rationale), or **defer** (with where it goes).
3. Record each decision in the work log and in the finding's *Author decision* line; move
   the status and append the transition to the review's status log.
4. Lessons that will hold for the next work item go to the area's memory
   ([`memory-engineering`](../memory-engineering/SKILL.md)).

A fix made after a review is a new revision: the next review round maps it with the rest.

## Self-review is not a review

The author - or the author's agent, in the session that produced the change - may run the
same steps on their own work before handing it over. It catches things, and it is recorded
the same way (`review_type: self`). It **never** satisfies the review step of the delivery:
an independent review is done by a different person, or by an agent working for a different
person, that did not produce the change. An agent reviewing the output of its own session
is a self-review, whatever it is called.

## Revision forensics (T80)

**Rule**: never judge one revision alone; classify the overlaps; name the culprit revision.
It runs inside every review (steps 3-4) and on its own when a regression must be traced.

1. **Collect every revision** of the work item: the tracker's links, a log search on the id
   in every spelling the team uses, the revisions cited in the discussion and the work log.
2. **Tabulate** `revision -> date -> author -> files (functions)` and **intersect**: every
   file or function touched by more than one revision is an overlap.
3. **Read each overlap as a sequence** (`original -> earlier -> target`) and **classify** it:
   `kept` (an earlier improvement preserved or improved further), `undone` (an earlier fix
   reverted), `reintroduced` (old behaviour back), `conflict` (contradicts an earlier
   decision), `duplicate` (a second solution for what is already solved).
4. **"We decided" sentences are design evidence.** "We decided", "we changed", "on
   purpose", "by design" in commit messages, the discussion or the work log are quoted with
   source and date; a result that contradicts one is a `conflict` - a question for the
   owner, not the reviewer's verdict.
5. **Name the culprit revision and the logical change** ("`r107` moved the release of the
   order buffer before its last read"), not just the changed lines.

Detail, the evidence sources, the forensic lens and a worked example:
[references/revision-forensics.md](references/revision-forensics.md).

## Exit tests and dry runs (T43)

**Rule**: prove a process on a real item before calling it done. A workflow, gate, tool or
merged mechanism is not finished when its document is written; it is finished when it ran
once on a real item and the result was read.

- **Exit test** - for adoption: each test replays one thing the adopter does every day, with
  steps, the artefacts expected and *where* they must appear, the evidence to collect and a
  "fails if" line; a results table with a **friction** column. A test that fails usefully
  is a result; friction worked around in silence is a lost one.
- **Dry run** - for a process change: walk the process's gates over a real work item,
  **read-only** (mechanical checks on a scratch copy), gate by gate: artefact found, `pass`,
  `gap` or `pending`. The findings are about the **process, not the item**; they go to the
  owner as numbered questions ([`decision-rounds`](../decision-rounds/SKILL.md)), are built
  tests-first, and the path the item did not exercise is tested separately.

Document shapes and the rules that came out of real runs:
[references/exit-tests-and-dry-runs.md](references/exit-tests-and-dry-runs.md).

## Anti-patterns

| Anti-pattern | What it costs |
|---|---|
| Reviewing the target's diff alone | a recommendation that re-breaks an earlier fix or duplicates it |
| A finding without `file:line` and a scenario ("this might be an issue") | noise; the author stops reading the real ones |
| The reviewer silently fixing the code | the author loses context; nothing is acknowledged; the next review cannot map it |
| A review left `open` while new work starts | the finding is built over instead of fixed |
| Counting a self-review as the review | the delivery gate passes with nobody independent having looked |
| "Process done" on a document that never ran | the first real item finds the gaps in production |
| Re-deciding the approach in the review | the review becomes a second plan; use the plan or spec gate |

## Output

Always end with: the review file's path; the verdict; finding counts by severity, `blocker`
and `major` first; the revisions inspected. In author mode: the status transitions made. In
a forensics run: the culprit revision and the logical change. In an exit test or dry run:
the results table and the findings on the process.
