---
project: <KEY>
subject: <AREA>
work_item: <ID>
type: <bug | change request | task>
date: <YYYY-MM-DD>
status: <draft | ready | closed>
tags:
  - close
---
# Close - <ID>: <the change in one line a user would recognise>

**Scope**: <method|case|mixed>
**Closed by**: <the closer (agent or person)> for <the owner of the change, as the project writes the name>

> Template from the engine-kit (`templates/CLOSE.template.md`) - techniques T45, T78 and
> T92, *operating*. The closing record of one work item, written by the `close-and-retain`
> skill at `TICKETS/<ID>/CLOSE.md`, in the case's artifact language. It is the single source
> of every text that leaves (tracker text, commit messages, prepared commands); a touched
> `CLOSE.md` is also what tells the close script that this work item is being closed. While
> a gate waits for what only a person can end, the record keeps `status: draft` and one
> marker under the title: `[DRAFT - pending implementation]` (no code change yet; nothing
> prepared for a commit), `[DRAFT - pending the returned logs]` (a prepared change, drafted
> when its patches are written: commits and release list prepared) or
> `[DRAFT - pending the owner's walk]` (record, packaging and release list prepared). The
> line under the marker names who ends the wait: the owner for the walk; for the returned
> logs, the person the people registry (`_REGISTRY/PEOPLE.md`) names to apply and rehearse
> the patches, or `not named yet - R-<NS>n` while the fact request is open. The markers stay
> in English (the `AGENTS` template's English-words list); a gloss in the artifact language
> may follow them. It becomes `ready` when the code exists, when the logs came back and the
> gates after them passed, or when the walk passed. Replace every `<placeholder>`, delete
> the sections that do not apply, and delete this note.

## 1. Tracker text

**<Type> <ID> - <title>**

**Scope:** <one sentence: the parts the change touched; a constraint it honoured>

**Root cause** (bugs only)
- Symptom: <what the user saw, plain words>
- Root cause: <why it happened - the mechanism, explained>
- Solution: <what the fix does, one or two lines>

**Rule** (only when a business rule was implemented or changed)
- Rule <slug>: <the current rule> - row <KEY#N> (<decided by>, <date>); replaces row <KEY#M> (<the old behaviour, Denied>)

**Changes**
- `<tier>/<file>` - <what changed and why, one line>

**Not changed (on purpose)**
- `<file>` - <why it was left alone>

**Test focus**
- <scenario: how to reproduce, expected result, regression area to watch>
- Automated: <suite tests that pin the change - fixture, cases, line>

**Line / working copy:** <line> - <working copy, branch>

## 2. Tracker fields

Only when the case sanctions a field write (decision <KEY#N>). Otherwise: "Not written - the
text above is the developer's to paste."

| Field | Value (or first words) | Source | Written | Confirmed |
|---|---|---|---|---|
| <cause field> | <the Root cause bullet> | section 1 | <yes, revision <n> tested / no: why> | <name + first words read back> |
| <resolution field> | <Solution, Changes, Test focus> | section 1 | <...> | <...> |
| <picklist> | <value> | <the roots in the status: core / client / both> | <...> | <...> |
| <state, dates, assignment, committed revision> | - | - | left to the developer | - |

Text that someone else had written in a field: <none | quoted here, replaced after "<the owner's yes>">.
No comment was posted.

## 3. Commits (prepared)

```text
1. fix    <Type> <ID>: <what was built or fixed> - <parts>.
2. tests  <Type> <ID>: suite tests for <what they pin> - <fixture> (<n> cases).
```

| # | Group | Working copy | Files |
|---|---|---|---|
| 1 | fix (`<ID>-fix`) | <application, branch> | <files> |
| 2 | tests (`<ID>-tests`) | <test suite> | <files> |
| 3 | knowledge base | <knowledge base> | <CLOSE.md, the log, cards, index rows> |

Message files: `commit-fix.txt`, `commit-tests.txt`, `commit-kb.txt` in this folder.

## 4. Packaging - waits for the release word

This section is the release list's one home: the front prompt's Release section and its
resume block point here, never copy it.

- Draft: <none - ready | waits for <the returned logs | the owner's walk>, ended by <the owner | <the person, as `_REGISTRY/PEOPLE.md` names them> | not named yet - R-<NS>n>; the word may be asked with the walk, and releases this list only once the walk passed>
- Every new file added to version control: <yes - status read at <time>: no unversioned file of the change>
- Changelists or staged sets: <svn changelist <ID>-fix / <ID>-tests | git branch <id>, two staged sets>

| # | What | Where | Command | After |
|---|---|---|---|---|
| 1 | commit of the fix | <working copy> | `<command>` | - |
| 2 | index row: the fix revision | <the suite's index> | <fill the revision of 1> | 1 |
| 3 | commit of the tests | <working copy> | `<command>` | 2 |
| 4 | commit of the knowledge base | <working copy> | `<command>` | 3 |

## 5. Knowledge

- Episodic log: `<SUBJECT/<AREA>/MEMORY/<YYYY-MM-DD>-<ID>-closing.md>` (<n> claims) | <the session's log of today: path>

*level 3* - card decisions:

| Claim (fact, confidence >= 0.8) | Card decision | Card |
|---|---|---|
| <claim> | <new / strengthened / superseding / no card: why> | <K-<id> (<confidence before -> after>) / -> |

- Provenance filled: <documents and cards, with the revision of their source | revision pending until the commit: <cards>>
- SUPERSEDED marks: <documents, claims or cards | none>
- Rows: <INDEX line of a new card, registry rows | none>; root rules: <changed: why | unchanged>
- *level 3* - Flags: <AREA has <n> unconsolidated logs | <n> sessions of this work item in <AREA>> -> <consolidation cycle now | named as the next task> | none
- Method insight: <one line for the product journal | none>

## 6. Close script

```text
python <kit>/runtime/close/close.py --root <kb-root> --project <KEY> --ticket <this folder>
```

- Result: <clean | <n> to fix, <m> warnings - listed and fixed, run again at <time>>
- Not run here / not configured: <check: reason | none>
- Remaining lines and their reason: <line: reason | none>

## 7. Exit checklist

- [ ] Preconditions: evidence per line, index row or `exempt:`, review status, rule row
- [ ] Tracker text prepared (or written by the five steps, each field confirmed)
- [ ] Episodic log; provenance; SUPERSEDED marks; rows. *level 3*: card decision for every fact >= 0.8; flags
- [ ] Every new file added; fix and tests prepared as two commits, the fix first
- [ ] Every artifact passed the deliverable gate
- [ ] Close script clean, or each remaining line with its reason
- [ ] Commits (the developer's, after the release word)
- [ ] Committed revisions into the tracker and into pending cards (the developer gives them)
- [ ] Tracker state and dates (the developer's)
