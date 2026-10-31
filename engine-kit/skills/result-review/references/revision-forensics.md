# Revision forensics (T80)

**Scope**: method

Part of [`result-review`](../SKILL.md). **Rule**: never judge one revision alone; classify the
overlaps; name the culprit revision.

Two uses, one procedure:

| Use | Starts from | Ends with |
|---|---|---|
| **Review** (result-review steps 3-4) | the target revision(s) of a work item | the evolution table of the review file; findings that rest on the whole history |
| **Regression trace** | a symptom ("it worked last month") | the culprit revision and the logical change that caused it, handed to whoever designs the fix |

## 1. Collect every revision

A revision belongs to the work item when any of these names it. Search **all** of them; the
first one alone is never complete.

| Source | How | Typical miss when skipped |
|---|---|---|
| The tracker's links | the revisions attached to the work item | the follow-up commit made without the link |
| The version-control log | a search on the id in every spelling the team uses (`ORD-42`, `#42`, `ORD#42`, the bare number) | a revision whose message used another spelling |
| The discussion and the work log | revision numbers cited in comments, the dossier, the worklog | a revision made on another branch and cited by hand |
| Merges and backports | the merge revisions that carried the item to other lines | the line where the fix was lost in a merge |
| The path's history (regression trace) | every revision that touched the failing path in the window, cited id or not | the culprit that belongs to another work item |

Output: one chronological table - `revision -> date -> author -> files (functions)`. Never
invent a revision, a date or an author: write "not specified".

## 2. Intersect

Intersect the file lists, then the functions inside the shared files. Every file or function
touched by **more than one** revision is an **overlap**: it carries history the review must
account for. A revision with no overlap is still read, but its changes are new work, not
evolution.

## 3. Read each overlap as a sequence

For each overlap, read `original -> earlier revision(s) -> target`, never only
`before -> target`. Read the whole unit when the diff alone is ambiguous (a moved block, a
changed scope). Then ask: does earlier context explain or justify the current code? A
recommendation is valid only after that question is answered.

## 4. Classify

| Class | The target... | Typical evidence | What follows |
|---|---|---|---|
| `kept` | preserves an earlier improvement, or improves it further | the earlier lines survive or are refined | nothing; a positive note when it is non-obvious |
| `undone` | reverts an earlier fix | lines an earlier revision added are removed or inverted | a finding (`major` or `blocker`), citing both revisions |
| `reintroduced` | brings back behaviour an earlier revision removed | the old shape returns, often from a stale copy or a merge | a finding, citing the revision that had removed it |
| `conflict` | contradicts a decision taken earlier | a quoted "we decided" sentence, a rule row, a decision id | a question for the owner (`decision-rounds`); the reviewer does not overrule a decision |
| `duplicate` | solves again what an earlier revision already solved | two guards, two conversions, two code paths for one case | a finding: keep one, say which |

A defect inside an overlap that fits none of the classes is an ordinary finding.

## 5. Design-decision evidence

Sentences such as **"we decided"**, **"we changed"**, **"on purpose"**, **"by design"**,
**"agreed with"** - in commit messages, the work item's discussion, the work log or the
dossier - are evidence of a design decision. Quote each one with its source and date in the
evolution table. A result that contradicts one is a `conflict`: the owner decides, through a
numbered question, whether the decision still stands. When the project keeps rule files, the
rule's history rows are the stronger evidence and the rule gate applies.

## 6. Name the culprit (regression trace)

The trace ends with **one revision and the logical change**, in one sentence:

> `r107` moved the release of the order buffer before its last read in `ship_partial`, so a
> partial shipment reads freed memory.

Not "lines 40-52 changed in `r107`". When two revisions remain possible, say which evidence
would split them (a build of each, a log line, a test that is red on one and green on the
other) instead of picking one.

**The forensic lens** - changes that look harmless in a diff and are classic culprits:

- a release, free or close call moved, or a cleanup scope widened or narrowed;
- a constructor or destructor whose visibility or call order changed;
- a field or key renamed on one side of a contract only (emitter vs consumer);
- lines duplicated by a merge;
- a guard or an empty catch block added to make a crash disappear (anti-silencing, T34):
  the symptom moved, the cause stayed - name the revision that introduced the cause;
- a default value or a configuration switch flipped in passing.

**Cross-version drift**: when the project keeps several active lines, compare the same unit
across them. A fix present in one line and missing in another, or removed in one and
reintroduced in another, is named with the line and the revision.

## 7. Worked example (fictional)

Work item `ORD-42` ("Acme Orders: a partial shipment keeps the order open"). The reviewer is
asked to review `r112`.

| Revision | Date | Author | Files (functions) | Overlaps with |
|---|---|---|---|---|
| `r101` | 2026-03-02 | author A | `orders/ship.py` (`ship_partial`, `close_order`) | `r112` |
| `r107` | 2026-03-04 | author A | `orders/ship.py` (`ship_partial`); `orders/api.py` (`to_json`) | `r112` |
| `r112` (target) | 2026-03-09 | author B | `orders/ship.py` (`ship_partial`, `close_order`) | `r101`, `r107` |

| Area | Sequence | Class | Evidence |
|---|---|---|---|
| `orders/ship.py:close_order` | original -> `r101` -> `r112` | `undone` | `r101` added the "remaining quantity > 0" check; `r112` removed it while refactoring |
| `orders/ship.py:ship_partial` | original -> `r107` -> `r112` | `conflict` | `r107` message: "we decided to keep backorders open until the customer cancels" (2026-03-04); `r112` closes them after 30 days |
| `orders/api.py:to_json` | original -> `r107` | (no overlap) | read; new work |

Findings that follow: `F-01 major` on `close_order` (the `undone` check: an order with a
remaining quantity is closed - failure scenario with the inputs); a **question** to the
owner for the `conflict`, quoting the `r107` sentence. Reviewing `r112` alone would have
approved the refactor and missed both.
