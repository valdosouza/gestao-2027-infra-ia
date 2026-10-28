# Template: Review file

**Scope**: method
**Used by**: [result-review](../SKILL.md) - reviewer mode step 8 (written) and author mode
(acknowledged, resolved or declined).
**Produces**: `<project>/SUBJECT/<NAME>/TICKETS/<ID>/REVIEW/REVIEW_<yyyy-mm-dd>_<reviewer>.md`,
one file per review round. Copy the skeleton below, fill every `<...>`, delete the hints in
parentheses, and set the copy's own Scope line (`case` for a real work item).

The front matter is the handshake: the reviewer writes `status: open`, only the author moves
it on, and every move is appended to `status_history` and to section 8. A finding without
`file:line` and a failure scenario (or a quoted rule) is dropped before the file is written.

## Skeleton

````markdown
---
work_item: <ID>
title: "<work item title>"
reviewer: <name as the team writes it>
review_type: independent        # independent | self (a self-review never replaces an independent one)
review_date: <YYYY-MM-DD>
target: [<revision>]            # what the reviewer was asked to review
revisions_reviewed: [<rev>, <rev>, <rev>]   # EVERY revision inspected, the target included
branch: <version line the revisions live on>
verdict: <APPROVED | REQUIRES CHANGES | REJECTED>
status: open                    # open -> acknowledged -> resolved | declined (the author moves it)
status_history:
  - "<YYYY-MM-DD> open (<reviewer>)"
---
# <ID> - Review <YYYY-MM-DD> (<reviewer>)

**Scope**: <method|case|mixed>

## 1. Scope reviewed

- Revisions and files actually read: <list>.
- Context read: <work log, dossier, plan or spec, test evidence, area memory, pipelines>.
- Out of scope, stated explicitly: <what was not reviewed and why>.

## 2. Related revisions

Sources searched: <tracker links>, <log search on "<ID>" and its other spellings>,
<revisions cited in the discussion and the work log>.

| Revision | Date | Author | Files (functions) | Overlaps with |
|---|---|---|---|---|
| <r101> | <date> | <author> | `<file>` (`<function>`) | <r112> |
| <r107> | <date> | <author> | `<file>` (`<function>`) | - |
| <r112> (target) | <date> | <author> | `<file>` (`<function>`) | <r101> |

## 3. Evolution analysis

| Area (`file:function`) | Sequence | Class | Evidence |
|---|---|---|---|
| `<file>:<function>` | original -> <r101> -> <r112> | <kept / undone / reintroduced / conflict / duplicate> | <diff lines, a quoted "we decided" sentence with source and date> |

Design-decision sentences found: <quote, source, date> (or "none").

## 4. Findings

### F-01 - <blocker | major | minor | nit> - <one-line statement>

- **Where**: `<file>:<line>` (revision <rev>)
- **Failure scenario**: <input or state> -> <wrong outcome>
- **Why it matters**: <history, rule row, contract or convention, quoted>
- **Proposal** (documentation only): <approach or patch>
- **Author decision**: <fix | decline: rationale | defer: where> (<date>)   (filled by the author)

### F-02 - <severity> - APPLIED-URGENT - <one-line statement>

- **Where**: `<file>:<line>`
- **Failure scenario**: <...>
- **Urgency stated by**: <who asked, when, why it could not wait>
- **Applied**: <what was changed>; committed by a human as <revision>
- **Author decision**: <acknowledged | reworked> (<date>)

(No findings: write "None" and keep the section.)

## 5. Questions to the author (not findings)

- <a doubt that is not a defect; the author answers in the work log>

## 6. Proposed solution (optional, documentation only)

<a patch or an approach; the reviewer does not apply it>

## 7. Positive notes (optional)

- <a pattern worth reusing; candidate for the area's memory>

## 8. Status log

| Date | Status | By | Note |
|---|---|---|---|
| <YYYY-MM-DD> | open | <reviewer> | written; verdict <verdict> |
````

## Filling rules

- **One file per round.** A second round after fixes is a new file with a new date; it maps
  the new revisions with the old ones and cites the previous review.
- **Verdict from the findings**: any `blocker` or `major` -> `REQUIRES CHANGES` (or
  `REJECTED` when the approach itself produces the defect); otherwise `APPROVED`.
- **The author fills** the *Author decision* lines, moves `status`, appends to
  `status_history` and section 8, and records the same decisions in the work log.
- **Never invent** a revision, a date or an id: write "not specified".
- **Names as the team writes them**; never a role inferred from a name.
