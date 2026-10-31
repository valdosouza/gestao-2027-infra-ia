# Assumptions, the release word and the owner's answers — worked examples

**Scope**: method

Companion of [the decision-rounds skill](../SKILL.md), section *The assumption ledger and
the release word* (T23). Every name is neutral: a front `XY`, an owner.

## 1. The ledger in a front prompt

```markdown
## Assumptions — to ratify

- **A-XY3** — answers Q-XY12 (how partial refunds round) with its Rec. (a): half-up per
  line. Applied: `billing/refund.ts` (`roundLine`), `refund.test.ts` cases 4-6.
  Undo: round on the total instead and drop cases 4-6.
- **A-XY4** — answers Q-XY13 (who may reopen a closed period) with its Rec. (b): the
  period's owner only. Applied: `periods/guard.ts:40`, route test `reopen.test.ts`.
  Undo: let any administrator reopen; keep the test, flip its expectation.
```

The entries change status; they are never deleted:

```markdown
- **A-XY3** — RATIFIED 2026-03-08 → XY#12 (owner, chat: "yes, per line").
- **A-XY4** — OVERTURNED 2026-03-08 by XY#13 (owner, chat: "any administrator, but log
  it"); undo done in round 4 (`periods/guard.ts`, `reopen.test.ts`).
```

## 2. A choice the owner reserved

```markdown
- **Q-XY14 — How many failed attempts lock an account? Reserved - never assumed.** The
  owner fixes this value. The code reads it from one constant, the tests take it as a
  parameter, and the release waits for the answer.
```

## 3. The resume block

```markdown
**Resume**: round 3 executed in the worktree — NOTHING committed. Awaiting the owner:
ratify A-XY3…A-XY6; answer Q-XY12 and Q-XY14 (reserved); the release word for the list
in `TICKETS/XY-W1/CLOSE.md`, section 4.
```

## 4. The release list

Its one home is the closing record, `TICKETS/XY-W1/CLOSE.md` section 4; the prompt's
Release section and the resume block point at it, never copy it.

```markdown
## 4. Packaging - waits for the release word

| # | What | Where | When |
|---|---|---|---|
| 1 | commit of the listed paths, branch `xy-round-3` | application repository | first |
| 2 | seed script 12 | shared database, after a dry run on a disposable copy | after 1 |
| 3 | deploy of the service | staging | last |
```

Recorded when the word comes: "2026-03-09 — release word for items 1-3 (owner, chat)".
An item added after that waits for a new word.

| Needs the release word | Does not |
|---|---|
| commit; push, merge or pull request | editing the working copy or a disposable worktree |
| publishing a document, a package or an image | running tests and builds |
| any script that writes to a shared database | writing to a disposable copy of a database |
| deploying to any environment | preparing the release list itself |

## 5. Literal answers and divergences

| # | Date | Decision | Why |
|---|---|---|---|
| 9 | 2026-03-04 | **The summary shows net and gross** (Q-XY5 = (c)). **DIVERGED** from the recommendation (a) | owner, chat, 2026-03-04: "both — the auditors read the gross". The recommendation had read the screen's users as operators only |
| 10 | 2026-03-06 | **Exports skip archived rows** (Q-XY7 = (a), the recommendation) | round 2 answer, quoted once at the head of the round: "follow the recommendations of round 2" |
| 11 | 2026-03-06 | **Generated indexes stay outside the base** (Q-XY8 = (a), the recommendation). Its stated reason ("the kit allows no derived folder inside the base") was removed by a kit change taken in the same message; the decision does not contradict the new rule (outside stays the default), so it stands as answered - no new question; the owner is told on a line of the hand-off that (b) is now allowed | round 2 answer, quoted once at the head of the round |

- One answer per question. "ok" to three questions is asked again — the agent does not
  pick the meaning.
- An answer in another language than the register is quoted as given, then translated.
- An answer is read by the ids it names: "follow the recommendations of round 4 (Q-XY21,
  Q-XY23)" while round 3 is the open one answers Q-XY21 and Q-XY23 - the round number is
  noted beside the quote, and nothing is reopened. In a message that answers two cases, "Q-WS5 of the other case" is that
  case's question, whatever this case's `Q-WS5` says.
- Several gos in one paragraph - "Go on the W1 plan. Go on the W1.1 red. Go on the W1
  plan of the other case." - are read one sentence at a time: each covers only the
  artifact it names.

## 6. Saying the word - what releases and what does not

The release is the word **said as the act**: the word alone, or the word with the list it
releases, in the owner's message as an instruction. The release word here is "go"; the
release list of section 4 is on the page.

| The owner's message | Reading |
|---|---|
| "go" | releases the list as it stands when the word is given |
| "go for items 1-2" | releases items 1 and 2; item 3 waits for a new word |
| "Q-XY5 (a), Q-XY6 (b). The release word is "go"." | answers two questions and **fixes** the word - releases nothing |
| "... when I say "go", ship the seed first" | **quotes** the word inside another instruction - releases nothing |
| "follow the recommendations. The release word is "go" (cut there) | a definition in a message cut at that point - releases nothing |
| "looks fine, go ahead with everything" | the word is not said as the act and the list is not named: **ask** |
| "walked the script, all fine. go for items 1-4" | the walk and the word in one message: items 1-4 are released once the walk's record shows it passed; an observation fixed in the code would be a delta - the gates run on it and the word is asked again |

- The message that fixes the word is never its first use; the first release is a later
  message that says it for the listed items.
- When in doubt, ask on a line of its own ("Release items 1-3 of the list?") and record the
  answer; never complete a release from a partial or ambiguous message.
- Recorded, when it comes: "2026-03-09 - release word for items 1-3 (owner, chat: "go")".
