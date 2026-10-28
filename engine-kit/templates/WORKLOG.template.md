---
project: <KEY>
subject: <AREA>
work_items: [<ID>]
last_updated: <YYYY-MM-DD>
tags:
  - worklog
---
# Work log - <ID>: <the change in one line a user would recognise>

**Scope**: <method|case|mixed>
**Owner of the change**: <the name as the source writes it | "the developer who owns the change">

> Template from the engine-kit (`templates/WORKLOG.template.md`) - the owner's log of one
> change, kept by the `change-gate` skill at `TICKETS/<ID>/WORKLOG.md`. Created at the first
> gate when missing, in every flow (bug, change request, task). **Append-only**: a row is
> never edited; a correction is a new row that cites the old one. The owner's words are
> quoted literally (a translation follows the quote when they are in another language).
> Delete this note.

## Gate approvals (the go)

A go opens the code working copy for one artifact in one state. It is not a release. The go
is the owner's sentence that names this artifact by id; it may share a message with answers
and with other artifacts' gos - quote the message once and say which sentence is this go.

| # | Date | Artifact and state approved | The owner's words (literal) | Channel |
|---|---|---|---|---|
| 1 | <YYYY-MM-DD> | <PLAN.md, draft of YYYY-MM-DD / SPEC.md revision N / red test TESTS/TEST_PLAN.md> | "<exact words>" | <chat / meeting / message> |

## After the go - facts that arrived

Facts that came with the go or after it (an answer, a read the round asked for): the
premises and the risks re-read. A broken premise voids the plan; a risk that changes what
the code will be is a revision (next section); any other stays here, with a dated
`After the go` note in the plan and, for a prepared change, a stop condition in
`PATCH/APPLY.md`. An owner's message that names no open id and only defers what a person
must end - the owner's walk, a prepared change's rehearsal: "they stay owed" - is quoted
here once, outcome `gate owed by <person>`: it closes, opens and releases nothing, and the
closing draft keeps its marker.

| Date | Fact (id, source) | Premises re-read | Risks re-read | Outcome |
|---|---|---|---|---|
| <YYYY-MM-DD> | <F<n> / H-<NNN>, owner R-<NS>n / the owner's message, literal> | <hold / Q-<NS>n broken -> plan void> | <new risk: ... / none> | <note in PLAN.md "After the go" + APPLY.md stop <n> / revision, row <n> / gate owed by <person>> |

## Revisions of the plan artifact

A revision raised by a round after the go (the delivery gates' questions) cites the round
and is written on its recommendations; its go is a row of the gate approvals above, citing
the round.

| Date | Artifact | State change | What changed and why | New gate (approval row) |
|---|---|---|---|---|
| <YYYY-MM-DD> | <SPEC.md> | <approved -> revised (revision N)> | <...> | <row n | pending> |

## Deviations and second passes

Anything implemented differently from the approved artifact, and every file changed after
its first run (edits before a file's first run are drafting), with the reason. A deviation
that changes behaviour is a revision, not a row here.

| Date | File or step | What happened | Why |
|---|---|---|---|
| <YYYY-MM-DD> | <path> | <second pass> | <reason> |

## Approved test updates

A test that pins an existing behaviour changes only when the owner says so (an intended
change of behaviour, never a test made to pass).

| Date | Test | Old expectation -> new | The owner's words (literal) |
|---|---|---|---|
| <YYYY-MM-DD> | <test name, path> | <...> | "<exact words>" |

## Release word (what left the working copy)

The list was prepared before the word; the word covers that list only. An item added later
waits for a new word.

| Date | The owner's words (literal) | Items released (from the prepared list) | Executed by | Confirmed by reading |
|---|---|---|---|---|
| <YYYY-MM-DD> | "<exact words>" | <1-3: commit of the fix, commit of the tests, script 12> | <the human> | <log / status checked> |

## Open items handed on

- <question or assumption id waiting for the owner>
- <a pre-existing failure met on the way, and who took it>
