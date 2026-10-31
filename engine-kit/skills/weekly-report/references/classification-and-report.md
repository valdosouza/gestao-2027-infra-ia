# Classification and the report - a worked example

**Scope**: method

Companion of [the weekly-report skill](../SKILL.md), sections 3 and 4. Everything below is
fictional: a person `ann` on a team whose items look like `ORD-123`, a week from Thursday
2026-09-10 to Wednesday 2026-09-16 at UTC-03:00, hand-over states `In review`,
`Ready for test` and `Done`.

## The evidence and the classes

| Item | Evidence in the window | Class | Why |
|---|---|---|---|
| ORD-101 Bug: refund rounding | 2 commits; ann moved it `Active -> Ready for test` and assigned it to the tester on 09-11 | **Y** | real work, handed over by ann |
| ORD-102 Change: reason codes | 2 commits (one in the tools repository) and the NO-ID "tidy imports" that ann placed here; still `Active`, assigned to ann | **N**, 2d | work without a hand-over; ann gave the estimate |
| ORD-103 Change: refund button | 1 commit; ann's comment "button done, screenshots attached" to the requester, who holds the item now; state unchanged | **Y** | the result delivered in a comment to the holder |
| ORD-109 Task: slow export | no commit; ann's comment with the analysis and its conclusion; ann assigned it to the lead | **Y** | an analysis with a conclusion, assigned away |
| ORD-107 Bug: invoice total | no commit; the tester moved it `Ready for test -> Reverted to developer` and assigned it to ann on 09-15 | **N**, blank | landed on ann (net 4): a revert counts with nothing done yet; ann has no estimate yet - the reply says so |
| ORD-095 Bug: old import | ann's only action: the comment "thanks, all good" | out | acknowledgement only |
| ORD-090 Change: export headers | reported Y last week; no change this week | out | not repeated |
| ORD-112 Task: assemble release 2.1.4 | 3 commits; finished and handed to the release manager | excluded (case rule) | release assembly; its 3 commits are listed as excluded work |
| ORD-100 (named by a link) | ann's commit for ORD-102 carries a pasted link to ORD-100, whose title is about another screen; ann never touched ORD-100 | out, related | a link anomaly, shown in the reply |
| ORD-115 Task: data fix for a colleague | ann closed it on a colleague's behalf after their fix | borderline | the person decides |

## The reply (before anything is written)

```markdown
Week 2026-09-10 .. 2026-09-16 (UTC-03:00). Sources: orders (git) 7 commits, tools (svn)
1 commit, tracker read. Not read: none.

| Item | State, holder now | ann's commits | ann's part | Class | Time |
|---|---|---|---|---|---|
| ORD-101 refund rounding | Ready for test, the tester | 332ae482f8, 44b0685798 | fixed the rounding, added the case | Y | |
| ORD-103 refund button | In review, the requester | 9f4cf444bd | built the button, sent screenshots | Y | |
| ORD-109 slow export | Active, the lead | - | analysed the export, conclusion in a comment | Y | |
| ORD-102 reason codes | Active, ann | 44b0685798, r412, 1ed3296044 | codes and seed; screen pending | N | 2d |
| ORD-107 invoice total | Reverted to developer, ann | - | reverted to ann by the tester on 09-15 | N | ? |

Worked without commits: ORD-109, ORD-107.
Link anomalies: 44b0685798 links ORD-100 ("export headers screen"), never touched - related only.
NO-ID: 1ed3296044 "tidy imports" (same day as ORD-102, ORD-101) - placed under ORD-102 by ann.
Borderline: ORD-115 (closed for a colleague) - in or out?
Excluded: ORD-112 release assembly (3 commits), by the team rule.
Waiting for you: ORD-107 - the tester asked "can you check the rounding on credit notes?".
Missing estimates: ORD-107.
```

The person answers ("ORD-115 out; ORD-107 is 1d") and only then the rows are written.

## The agreed rows

```text
ORD-102;N;2d
ORD-101;Y;
ORD-103;Y;
ORD-109;Y;
ORD-107;N;1d
```

ORD-102 comes first because it was carried over as pending from the previous report and
keeps its place; new items follow. One row per item.

## The writer contract

The output belongs to the case: a spreadsheet the planner collects, a message, a page.
Whatever it is, its writer:

1. **Writes values into the case's template** and keeps its formatting; finds its place by
   a marker in the template (a header text), not by a fixed row number.
2. **Writes a binary format with a library** (a spreadsheet library, for example) - never
   with text tools or a plain file copy, which can corrupt it.
3. **Archives the previous version** beside it before writing, and **asks** before
   replacing a file of the same week; never overwrites silently.
4. **Checks before writing**: a column it would fill that already holds unrelated content
   stops it; a row without a valid item id stops it.
5. **Reads back** what it wrote, prints the rows and their count, and compares them with
   the agreed rows.
6. Offers a **dry run** on a copy when the template changed.

The evidence of each step (the commit list, the tracker answers, the agreed rows) is kept
in a working folder outside every repository until the person confirms the report was
sent; then it may go.

## When the evidence and the person disagree

The person knows things no source shows (work done in a meeting, a hand-over by phone).
Their word goes in the report **as theirs**: the row's note says "per <person>, no record
in the window". The agent never adds evidence that does not exist, and never removes a row
the person wants; it only says which rows have no record.
