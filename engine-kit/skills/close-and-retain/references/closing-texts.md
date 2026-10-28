# Closing texts - the tracker text, the fields, the commit messages

**Scope**: method

Companion of [the close-and-retain skill](../SKILL.md), step 3 and step 4 - technique T45,
`operating` (one case: a multi-developer product team whose single closing agent wrote the
tracker's development fields and the commit messages of every work item). Every text here
is written into `TICKETS/<ID>/CLOSE.md` first ([template](../../../templates/CLOSE.template.md));
the tracker and the commits receive copies of it.

## 1. The tracker text

One shape, sections left out when they have nothing to say. In the case's artifact
language.

```markdown
**<Type> <ID> - <title>**

**Scope:** <one sentence: which parts the change touched; a constraint it honoured ("no change to the shared core")>

**Root cause** (bugs only)
- Symptom: <what the user saw, in plain words, no code>
- Root cause: <why it happened - name the mechanism and explain it>
- Solution: <what the fix does, one or two lines>

**Rule** (only when a business rule was implemented or changed)
- Rule <slug>: <the current rule, one sentence> - row <KEY#N> (<decided by>, <date>); replaces row <KEY#M> (<the old behaviour, Denied>)

**Changes**
- `<tier>/<file>` - what changed and why (one line per file; back end, logic, front end)

**Not changed (on purpose)** (when a reader would expect a change there)
- `<file>` - why it was left alone

**Test focus**
- <scenario: how to reproduce, expected result, the regression area to watch>
- Automated: <the suite tests that pin the change - fixture, number of cases, line>

**Line / working copy:** <the line and the working-copy path the change lives in>
```

Rules:

- **One line per bullet.** The text is read by testers and support, not by the reviewer.
- **Root cause is its own section** and leads the text of a bug. Folding symptom, cause and
  solution into the test focus made the cause hard to find at a glance in the source case,
  and the merged format was reverted.
- **Test focus is verification only**: how to check it and what to watch, never the root
  cause prose again. It names what is automated, so a tester knows what not to repeat by hand.
- **A file appears once**: when a per-client override and the shared core file both
  changed, the text says which one carries the behaviour.
- **By type**: a bug leads with Root cause; a change request takes every section that
  applies; a task keeps one line per file and little else.

## 2. Tracker fields

The case maps the sections onto its tracker's fields **once** (in its `AGENTS.md` or a note
the skill points to) and the closer follows the map. Principles that held:

| Kind of field | Filled with |
|---|---|
| A cause field | the text of the Root cause bullet only - no label (the field is the title), no symptom (the report already says it), no solution |
| A resolution or development-notes field | Solution first (with the Scope sentence), then Changes, Not changed, Test focus, the line - the same bold labels as the record |
| A picklist that follows from the evidence | derived from it: which roots the status listed (shared core, client part, both); a code defect, a configuration or data cause, or not a defect |
| A security or privacy flag | "no" / "not applicable" **only** when the change touches no authentication, permission or exposure of data; otherwise left unset, and the answer says so |
| A computed field | computed from the tracker's own dates, never from a revision date |
| State, dates, assignment, the committed revision, anything that moves the workflow | **left to the human**; the committed revision is written only when the human gives it, in a second single-field write |

The write itself, when the case sanctions it, follows the five steps of
[prepare-only, section 6](../../change-gate/references/prepare-only.md#6-tracker-writes---when-the-case-sanctions-one):
read first, optimistic revision test, show and ask before replacing someone else's text,
never post a comment, confirm each field landed. HTML fields take the plain markup the form
itself produces. When the write is not sanctioned, fails or is refused, **the text stays in
the closing record** and the answer says the field is the developer's - a comment is never
the fallback.

## 3. Commit messages

One line, at most about 150 characters, in the artifact language:

```text
<Type> <ID>: <verb phrase: what was built or fixed> - <the parts it touched, comma-separated>.
```

```text
CR 123: Allow a partial shipment of an order - order service, shipping screen.
Bug 77: Fix the shipped quantity rounding on split parcels - parcel calculator.
Task 81: Show the carrier name in the shipment tooltip - shipment view.
```

**A change with suite tests has two messages, in commit order**, each with its file list:

1. **fix** - the product files only, the format above;
2. **tests** - the suite's files only (tests, case tables, suite project files, coverage
   lists, a promoted proposal's drafts removed):

```text
CR 123: suite tests for partial shipments - shipping fixture (4 cases).
```

Each message goes to a file in the ticket folder (`commit-fix.txt`, `commit-tests.txt`) so
the prepared command is `git commit -F <file>` or `svn commit -F <file>` and nothing is
retyped. The packaging of the two groups: [packaging.md](packaging.md).

## 4. Language

- Every artifact that reaches the team is in the **artifact language** the case fixed:
  the closing record, the tracker text, the commit messages, the episodic log, the cards,
  the registry rows.
- **The chat follows the user**: the explanations, the knowledge summary and the exit
  checklist are in the language the user writes in; the prepared texts are pasted verbatim
  inside it, untranslated.
- Never translate an artifact into the chat language, and never switch the whole chat to
  the artifact language.

## 5. Drafts

A work item with no code change yet (still in analysis) gets its closing record marked
`[DRAFT - pending implementation]`; nothing is written to the tracker, nothing is prepared
for a commit. The draft becomes the record at the real close.

Two more drafts wait for what only a person can end, and carry more
([SKILL.md](../SKILL.md#drafts-while-a-gate-waits)):

- `[DRAFT - pending the returned logs]` - a prepared change, drafted when its patches are
  written: the tracker text, the two commit messages (from the patches, fix first) and the
  release list are prepared; it becomes `ready` once the logs came back and the hand-offs
  after them passed.
- `[DRAFT - pending the owner's walk]` - a delivery whose gates passed up to G3: the record,
  the packaging and the release list are prepared, so that the walk and the release word
  can be asked in one message; it becomes `ready` once the walk passed.

In each, nothing is sent: the texts wait in the record, and the line under the marker
names who ends the wait ([SKILL.md](../SKILL.md#drafts-while-a-gate-waits)). The markers
stay in English in every artifact language; a gloss may follow them.

## 6. Worked example (fictional)

```markdown
**Change request CR-123 - Allow a partial shipment of an order**

**Scope:** order service and shipping screen of the Acme Orders application; no change to the shared pricing module.

**Rule**
- Rule partial-shipment: an order may ship in parts; it stays open until every line is shipped - row ORD#2 (the owner, 2026-10-01); replaces row ORD#1 (Denied: one shipment per order)

**Changes**
- `service/orders/ship.py` - a shipment takes a subset of the order lines; the order closes when the last line ships
- `service/orders/model.py` - shipped quantity per line
- `web/shipping/ship-form.js` - quantity per line, defaulting to what is left

**Test focus**
- Ship 2 of 3 lines: the order stays open, the third line shows its open quantity
- Ship the rest: the order closes; a second shipment of a closed order is refused
- Automated: shipping fixture, 4 cases, line 2.1

**Line / working copy:** 2.1 - application working copy, branch cr-123
```
