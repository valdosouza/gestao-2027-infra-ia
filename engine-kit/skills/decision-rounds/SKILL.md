---
name: decision-rounds
description: Use when a draft must become a plan through the owner's decisions, an architecture or business choice appears mid-task, someone asks to register a decision or a business rule, or before shipping what a round produced - numbered questions with one recommendation, permanent KEY#N decisions, assumptions to ratify, the release word.
---

# Skill: Decision Rounds (draft → executable prompt)

**Scope**: method
**Maturity**: proven
**When to use**: whenever there is a draft of ideas (loose text, notes, pasted DDL,
the business owner's master prompt) that needs to become an executable phase/project
plan, and whenever a business or architecture choice appears in the middle of a task.
It is Phase 3 of the engine: the business owner DECIDES; nothing is decided for them.
**Origin of the method**: case zero — a draft of hundreds of lines became a closed
prompt with dozens of numbered decisions, validated DDL, and code with tests. Case two - a
multi-developer product team - organises its drafts and records its decisions with the same
rounds.
**Parts**: organising a whole draft before Round 0 - warning marks, the disposition of every
draft item, decision ids cited in the code (T17, `proven`) - is
[`frame-greenfield`](../frame-greenfield/SKILL.md) sections 1, 2 and 6; this skill keeps the
rounds and their convergence check. The rounds (T21) and the ids and registers (T22) are
`proven`; the assumption ledger and the release word (T23) are `operating` (one case); the
business-rule files and
their gate (T24) are `candidate` — optional, a project opts in. Worked examples:
[references/ids-and-registers.md](references/ids-and-registers.md) and
[references/assumptions-and-release.md](references/assumptions-and-release.md); the rule
file starts from [`templates/RULE.template.md`](../../templates/RULE.template.md).
**Changelog**: 2026-09-04 — question format rule added (evidence + options + explicit recommendation: in a real round, the only
answer that diverged was the one question asked without a recommendation); Round 0 gains step 0 (check the decisions already recorded; split pending items into
fact × intent) — from a large legacy business-application case where a redundant decision and half of the "questions to the owner" were avoided.
2026-10-21 — namespaced ids, one home register, the front-prefix alias, reserved ranges and the
reconciliation table (T22); the assumption ledger, the release word and literal answers (T23);
the optional rule gate (T24) — from case zero's parallel sessions on one product and case
two's per-project registers and rule files.
2026-10-21 (wave 4) - T17: a whole draft is organised by `frame-greenfield` before Round 0
(Round 0 note); convergence also requires every draft item to have a destination; the
description rewritten to the kit's "Use when" form.
2026-10-22 - from a greenfield exit test: Round 0 is the name of the first question set
(later rounds 1, 2...); facts requested from the owner (`R-XY2`) join the fact-vs-intent
split; the **Reserved - never assumed** marker; workspace questions in a block of their own;
a number not taken yet is written without `#`.
2026-10-27 - from the same exit test, stage 2: the recommendations are cross-checked before a
round goes out (Round 0 step 4); a blanket answer and a reserved question; ids issued in an
older form keep it. Then ([EK#26](../../DECISIONS.md)): the round that closes the prompt
carries the move to level 2 and the first plan, its go asked on a line of its own.
2026-10-27 - from the greenfield exit test's stage 3 and the legacy one's stage 2: saying the
release word vs defining or quoting it; the cross-check reads combined consequences and,
before the closing round, a go-live list; an answer to a fact request is a fact about the
world or a hypothesis about the system; the confirmations a plan's gate needs ride in the
closing round; accepted premises re-read against new facts; the frozen draft goes to
`HISTORY/` at the front's close.
2026-10-28 - from the greenfield exit test's stage 4 and the legacy one's stage 3: a kit
change between the question and the answer; a round the delivery gates raise after the go
carries the plan's revision (the EK#26 pattern); a go is a sentence of its own, not a line;
an answer is read by the ids it names and the case they are attached to; a read a person
made on request is a probe result; an environment the code constrains is a claim about the
system; a release word asked with the owner's walk.
2026-10-28 (2) - from the greenfield exit test's stage 5 and the legacy one's stage 4: a kit
move while a round is out is appended to that round; a message that only defers an owed
gate is quoted where the item lives and closes nothing; the round that carries a prepared
change's go asks who applies and rehearses it; the release list has one home, the closing
record.

---

## The method

The draft is not silently corrected. It is **organized as-is** and the problems become
**numbered questions** that the project owner decides. Every decision is recorded
permanently. Repeat until pending items reach zero.

### Round 0 — Organize and ask
Round 0 is the **first set of questions** the owner answers; the rounds after it are 1, 2...
A whole draft - a new product, module or phase - is organised first with
[`frame-greenfield`](../frame-greenfield/SKILL.md): frozen as received, its items numbered,
moved into the structure below with the warning marks, every item given a destination in a
disposition table. Round 0 then runs on the organised draft; the steps below hold for any
draft.

0. **Name the namespace** the round belongs to (`Namespace: ACME-2.1`, or front `XY`) — it
   decides the home register and the next free number ([Ids](#ids-namespaces-and-registers-t22)).
   **Check the decisions already recorded** in that register (search for the
   table/concept the draft touches): a draft often re-raises something already decided —
   answer it with the decision id instead of opening a redundant one. Where the project
   keeps rule files, read the ones the draft touches too ([Rule gate](#business-rules-and-the-rule-gate-t24--candidate-optional)).
   Then split every problem into **fact** and **intent**. A fact the evidence answers -
   code, a file, a read-only query - is resolved and cited (`file:line`). A fact that
   exists only in the owner's head (a date, the machine it runs on, a spreadsheet not
   handed over) is a **fact requested from the owner**, `R-XY2`: a plain request, no
   options; the answer is recorded quoted, never as a decision - a fact about the world, or
   a hypothesis when it says what the code or system does
   ([Recording](#recording-the-owners-answer)). Only intent - a choice only the owner can
   make - becomes a numbered question.
1. Restructure the draft into the standard phase-prompt format:
   `Context → Objectives → Workflow → Grouped specifications → Success criteria`
2. Keep the content faithful; mark problems with ⚠️ (`(!)` where the files are ASCII-only)
   at the exact spot + a reference to the question
3. Create the section **"⚠️ Pending questions (round 0)"** — each item has its own id
   (`Q-XY5`) and reads **problem → evidence → options → recommendation** (objective
   questions, closed options when possible). A question whose answer the owner keeps for
   themselves - a value such as a limit, a fee, a deadline - carries the marker
   **Reserved - never assumed** after its title ([T23](#when-the-owner-has-not-answered))
4. **Cross-check the recommendations before the round goes out.** Read all of the round's
   recommendations together, and against the decisions already recorded (step 0). Two
   that cannot both hold (Q-XY3 recommends charging at each delivery, Q-XY7 one invoice at
   subscription), or one that contradicts a recorded decision without saying it revises
   it, are fixed before the owner sees them: one recommendation changes, the conflict
   becomes its own question, or the recommendation names the decision it revises. A
   blanket "follow the recommendations" turns every recommendation into a decision at once:
   a contradiction left in costs a decision and a later round to undo it. Then read their
   **combined consequences**, not only their contradictions: two recommendations that each
   hold can together leave a result nobody chose (an off-site copy recommended for safety,
   a stack recommended for simplicity that cannot encrypt it - personal data at rest in
   clear). Each such result is a question of the same round. The round expected to close
   the prompt also walks the **go-live list** first
   ([closing round](#the-closing-round-carries-the-first-plan-ek26))

### Every round (0, 1, 2...) — Decide and apply
1. The owner answers the round's questions (in chat or by editing the file directly — always
   **re-read the file before editing**, it changes between rounds). Record each answer
   **literally** ([Recording the answer](#recording-the-owners-answer))
2. Apply each decision to the document; sweep for residues with textual search (old
   names, removed columns, orphaned references). Re-read the premise of each accepted
   recommendation against the facts that arrived with the answer: a premise a new fact
   breaks becomes a question that cites the decision it may revise - never a silent edit.
   A change of the kit's own rules between the question and the answer is read apart
   ([Recording](#recording-the-owners-answer)); on its own it never reopens the round
3. Move decisions to the permanent section **"Recorded decisions"** of the namespace's
   home register (numbering is continuous across rounds — it becomes the project's
   logbook); the question points to what it became: `Q-XY5 → XY#9`. **Regenerate the
   index** and run the citation check after every round
4. New problems discovered while applying → a new round of questions, cross-checked like
   Round 0 (step 4) before it goes out; after a go, a round whose answers change approved
   behaviour carries the plan's revision ([below](#a-round-raised-after-the-go-the-ek26-pattern)).
   A question the work cannot wait for (never a reserved one) → proceed on its
   recommendation as an
   **assumption** (`A-XY3`), never silently ([Assumption ledger](#the-assumption-ledger-and-the-release-word-t23))
5. Convergence: **"Pending questions: None"**, no assumption left to ratify, no fact
   requested from the owner left unanswered, and a list of what was explicitly left for
   future phases. When the round started from a draft, also
   **no draft item without a destination** - a decision, the closed prompt, a requirement,
   out of scope with its new home - nothing of the draft is lost
   ([`frame-greenfield`](../frame-greenfield/SKILL.md), section 6). When the check shows
   that the **next** round closes the prompt, that round carries the first plan
   ([below](#the-closing-round-carries-the-first-plan-ek26))

### The closing round carries the first plan (EK#26)

The closing round is the one whose answers, taken as recommended, leave nothing waiting:
everything still open is in it. It goes out in **one batch** with what would otherwise stop
the owner again, one item at a time, before any code ([EK#26](../../DECISIONS.md)):

- **its questions**, cross-checked as in every round - combined consequences included - and
  walked first against the **go-live list**, so that the closing round does not reopen. For
  each wave the round settles, ask what happens on its first day of use: **recovery of
  access** (a forgotten password or a lost key, with nobody to call); **data at rest and its
  backups** (every copy and export, where it lives, who can read it); **open items carried
  over from the old practice** (records still on paper, balances or loans in flight on the
  switch day); **who operates it** day to day. Each gap is a question of this round;
- **the confirmations the plan's gate needs** - a prerequisite only the owner can confirm,
  such as the search patterns the [settings mapper](../../agents/settings-mapper.md)
  proposed for the scan the pipeline gate needs - asked as fact requests (`R-XY8`) with the
  proposed rows linked, and listed among the plan's fact premises;
- **who applies and rehearses a prepared change** - when the plan's change will be prepared
  as patches rather than written and run here
  ([`change-gate`](../change-gate/SKILL.md#a-change-the-agent-cannot-write-or-run---prepared)):
  a fact request (`R-XY9`) for the person who applies the patches in a disposable instance
  and returns the logs. The answer is a row of the people registry (`_REGISTRY/PEOPLE.md`,
  confirmed by the owner); the plan's `Runs on:` line, the test evidence and the closing
  draft name that person. A go that came without it: the next round asks it;
- **the move to level 2**, when the case is still below the level of the code gate - a
  workspace question ([adoption levels](../../docs/ADOPTION-LEVELS.md#moving-up)). A move
  already decided, whose trigger is this round closing the prompt, is not asked again: the
  plan writes it `Level: WS#4 - level 2 decided, in effect when round N closes the prompt`;
- **the first wave's plan** - the code gate's plan artifact
  ([`change-gate`](../change-gate/SKILL.md), step 3) - written on the round's recommended
  answers. It lists the open questions it rests on as **premises**, the move among them
  (`Premises: Q-XY7: Rec (a); Q-XY9: Rec (b); Q-WS5: Rec (a)`), and says "written on the
  recommendations of round N - rewritten if any answer differs";
- **the go on that plan, asked on a line of its own** after the numbered questions ("Go on
  the W1 plan?") - an approval, not a decision: it takes no `Q-` id, and no answer to the
  questions covers it. One go per wave ([EK#30](../../DECISIONS.md)): the reds of the
  plan's test-first steps are shown with it and covered by the same go, never asked apart.
  The owner's go needs no line of its own: it is **a sentence of its own that names the
  artifact by id** ("Go on the W1 plan."), and it may share a message or a paragraph with
  the answers and with gos for other artifacts - each covers only what it names.

Reading the owner's answer:

| The answer | The questions | The plan |
|---|---|---|
| "Follow the recommendations" and an explicit go on the plan | each one the recommended option | approved - the go is logged with the round's answer quoted ([`change-gate`](../change-gate/SKILL.md), step 4) |
| "Follow the recommendations", nothing said of the plan | decided | no go - ask for it alone; answering is not approving |
| An answer that differs from a premise | recorded as a divergence | rewritten on the decision and its go asked again; a go in the same message lapses with the premise it stood on |
| A premise left open (a Reserved question the answer does not name, a partial answer) | still open | waits, go or not |
| A divergence on a question that is not a premise | recorded as a divergence | stands - unless the answer changes something the plan says: then its premise list was short; rewrite it and ask again |

The legacy track works the same way: the round that settles the pilot's first change
([legacy profile](../../profiles/legacy.md)) carries the move and that change's plan. When
no round is left to ask - the answers that closed the prompt came with the round before -
the move and the plan go out together, one stop.

### A round raised after the go (the EK#26 pattern)

Questions the delivery gates raise on a wave already approved and built - a point that
needs the owner, a `FINDING` probe ([`delivery-gates`](../delivery-gates/SKILL.md)) -
change approved behaviour once answered: a revision of the plan and a new gate
([`change-gate`](../change-gate/SKILL.md), step 4 item 6). So that the owner stops once,
not twice, the round carries that revision the way the closing round carries the first
plan:

- **its questions**, cross-checked as in every round (Round 0, step 4);
- **the plan's revision, written on their recommendations** - what changes in the code
  for each, its premises listed (`Premises: Q-XY28: Rec (a); Q-XY30: Rec (b)`), "rewritten
  if any answer differs". A question whose recommendation changes no code (a known limit
  recorded as such) is not a premise;
- **the go on that revision, asked on a line of its own** after the questions.

The answer is read with the closing round's table above: the recommendations followed and
an explicit go approve the revision - one WORKLOG row; an answer that differs from a
premise rewrites the revision and asks for its go again. The revision's code is a delta:
the gates run again on it.

### Closing — Execute
1. Generate the deliverables (scripts, code, docs) **citing the qualified decision ids in
   comments** (`-- ACME-2.1#14`, `// XY#2`) — full traceability
2. Validate programmatically (SQL parser, compiler, tests) before delivering
3. **Wait for the owner's release word** before anything leaves the working copy:
   commit, push or merge, publish, seed or apply to a shared database, deploy
4. Copy the final prompt to the project's folder in the knowledge base and distill new
   patterns into the reference docs. The frozen copy of the draft goes to `HISTORY/` at the
   front's close ([`frame-greenfield`](../frame-greenfield/SKILL.md), section 7) - a phase
   with no front: when its deliverables close - never when the prompt closes; the owner's
   original is theirs to move whenever they choose

## Rules that make it work

- **Never decide for the owner** on architecture/business items — suggest with
  "(Recommended)" and wait
- **Every question carries evidence (`file:line`), closed options and ONE explicit
  recommendation** — even when the agent is neutral, say which reading it would take.
  Closed questions with a recommendation are answered in minutes; the question asked
  without one is the one most likely to diverge or stall
- **Never lose a decision**: once decided, it enters the permanent section with a
  number — and numbers are NEVER reused/renumbered
- **Record the owner's words, not your summary of them**; a divergence from the
  recommendation is written as a divergence
- **Always sweep for residues** after every naming change (search for the old names)
- **Distinguish** "correcting" (an objective error) from "deciding" (a choice between
  valid alternatives) — only the second becomes a question
- Deferred items go to "Out of scope / future phases" — they do not disappear, they
  change place
- A decision can be REVISED in a future round: it gains the note "REVISED by XY#N", it
  is never deleted
- **Deciding is not releasing**: "follow the recommendations" closes questions; only the
  release word, **said as the act**, lets the result leave the working copy - a sentence
  that defines or quotes it releases nothing ([The release word](#the-release-word))
- **Deciding is not approving either**: a plan carried by the round - the first plan, or a
  revision after the go - has its go asked on a line of its own and given in a sentence
  that names it, never implied by the answers ([closing round](#the-closing-round-carries-the-first-plan-ek26))

## Ids, namespaces and registers (T22)

- **A decision id is `KEY#N`**: the namespace `KEY` and the number `N` in that namespace's
  home register, counted from 1. Examples: `ACME-2.1#7`, `XY#2`.
- **A namespace is a project or a front** (an epic, a workstream with its own prompt).
  Decisions that bind the whole knowledge base live in the workspace's root register.
  Pick the narrowest namespace that owns the choice.
- **Workspace questions ride in a block of their own.** A question that binds the whole
  knowledge base - who owns the decisions, the release word - asked while no workspace
  round is open goes in the front's question sheet of the same round, in a second block
  under the workspace key (`Q-WS1`); its answer becomes a row of the root register. Advice,
  not a check: an owner who answers several cases in one message is better served by a
  workspace key unique to each case - two cases keyed `WS` make `Q-WS5` name two questions,
  read then by the case each is attached to ([Recording](#recording-the-owners-answer)).
- **One home register per decision.** A decision that also binds other namespaces stays
  in its home register and lists their keys in the **Applies to** column; it is never
  copied into a second register — the others cite it.
- **The front-prefix alias.** Inside a front's prompt, ids are often written with a type
  prefix and no `#`. The prefix says what the id is:

  | Written | Means | A decision? |
  |---|---|---|
  | `XY#2` | decision 2 of namespace `XY` | yes |
  | `D-XY2` | the same decision, front-prefix form | yes — the same id as `XY#2` |
  | `Q-XY5` | question 5 of `XY` | no — answered, it points to its decision: `Q-XY5 → XY#9` |
  | `A-XY3` | assumption 3 of `XY` | no — until ratified ([T23](#the-assumption-ledger-and-the-release-word-t23)) |
  | `R-XY2` | fact 2 requested from the owner ([Round 0](#round-0--organize-and-ask), step 0) | no — answered, it becomes a fact (`F7`), or a hypothesis when it says what the system does ([Recording](#recording-the-owners-answer)) |

  Questions, requests, assumptions and decisions are four sequences; none is ever reused.
  A request to another group is that group's number, cited with its name (`sync R-7`).
  Prefer `XY#2` in new text; the alias stays valid wherever it was written. An id issued
  in an older form (a fact request `R1`, written before the `R-XY` form) keeps it and is
  never renumbered; where the new form is needed, write the alias once beside it
  (`R1 = R-XY1`).
- **Parallel sessions never share a free number.** Before a parallel session starts,
  give it **its own namespace** (a sub-front key `XW`: questions `Q-XW1…`, assumptions
  `A-XW1…`, decisions `XW#1…`) or **reserve a range** in the shared one, written in the
  home register *before* the work starts ("Q-XY: 40-44 reserved for session S; after
  Q-XY39, skip to Q-XY45"). Unused reserved numbers stay unused — a gap is cheaper than a
  collision.
- **A number not taken yet** - a reserved range, the next free id - is written
  `<sequence>: <number>` (`XY: 40-44`, `Q-XY: 45`), never `XY#40` or `D-XY40`: the
  citation check reads those as a decision that must exist.
- **When ids collide anyway** (two sessions took the same number without a reservation),
  the **conductor** — the session that merges the work — resolves it once, at
  reconciliation, with an **equivalence table** kept in the home register: original id
  (per session) → unified id → status (*stands*, *same decision as XY#n*, *revoked by
  XY#n*, *still open*). Numbers already in the home register never change; only the
  late session's ids are mapped, its text is converted to the unified ids, and its
  history (old commits, its branch) keeps the original ids and resolves through the table.
- **Never renumber** a number that has reached its home register; a gap is information,
  not an error.
- **Regenerate the index after every round**, and check the citations of the documents
  the round touched — [`runtime/registry/decisions_index.py`](../../runtime/registry/README.md):
  the index is generated, never edited by hand; `--check-touched` fails on a cited
  `KEY#N` (or `D-KEYN`) that is not in its register.
- **Code comments cite the qualified id** — `-- ACME-2.1#14`, `// XY#2` — never a bare
  "decision 14": a bare number is ambiguous as soon as a second register exists.

## The assumption ledger and the release word (T23)

**Part maturity**: operating — one case, chosen as core because autonomous and parallel
sessions need it.

### When the owner has not answered

The work does not stall and does not decide silently. It proceeds on the **recommended
option, recorded as an assumption** `A-<NS><n>` in the front's prompt (section
"Assumptions — to ratify"), each one with:

- the question it answers (`Q-XY12`) and the option taken (the recommendation);
- **where it was applied** (files, rows, tests) — so it can be found again;
- **how to undo it** if the owner overturns it.

The owner then **ratifies** it (it becomes a decision row that cites it: `A-XY3 → XY#12`)
or **overturns** it (the overturning decision cites it, and the undo is done in the
same round). Limits:

- An assumption only covers **reversible work inside the working copy** (or a disposable
  worktree / database copy); anything behind the release word waits for the owner.
- A choice the owner **reserved** for themselves (a business value, a threshold, a price)
  is never assumed: the question carries **Reserved - never assumed**, it stays a
  question, and the work that depends on it waits.
- Every hand-off and resume block lists what awaits the owner: assumptions to ratify,
  questions to answer and facts requested, by id.
- **A kit move made while a round is with the owner and unanswered**
  ([INSTALLATION](../../INSTALLATION.md#moving-to-a-newer-kit-version)) is ratified in that
  round: its question, and what the new rules ask of the round, are appended before any
  answer - dated, marked "added after the round went out", cross-checked with the rest
  (Round 0, step 4), the questions already asked never reworded - and the hand-off names
  the additions. A move over one not yet ratified revises that assumption, and one block
  ratifies both.

### The release word

The owner fixes one **release word** (for example "go"). Without it, nothing produced by
a round leaves the working copy: **no commit, no push or merge, no publication, no seed
or script applied to a shared database, no deployment.**

- Deciding and releasing are two acts: an answer to the questions is not a release.
- **The release is the word said as the act**: the word alone, or the word with the list it
  releases ("go", "go for items 1-3"), in the owner's message as an instruction. A sentence
  that names or defines the word ("the release word is go"), quotes it ("when I say go,
  ship it"), or comes in a message cut at that point releases nothing - the message that
  fixes the word is never its first use. When in doubt the agent asks, on a line of its own
  ("Release items 1-3 of the list?"), and never completes the release itself. Readings:
  [references/assumptions-and-release.md](references/assumptions-and-release.md), section 6.
- The release covers **what was listed when it was given** (the commits, paths, seeds,
  targets); something added afterwards needs a new word.
- Until then, the prompt says so plainly: "NOTHING committed - waits for the release
  word", and points at the exact list (what, where, in which order). The list has one home,
  the closing record (`TICKETS/<ID>/CLOSE.md`, section 4), prepared as a draft while the
  owner's walk (G4) or a prepared change's returned logs still wait
  ([`close-and-retain`](../close-and-retain/SKILL.md#drafts-while-a-gate-waits)); the
  prompt's Release section and the resume block point at it, never copy it.
- **Asked in the same message as the owner's walk**, the word keeps the order of the gates:
  it releases the list only once the walk passed. A walk observation fixed in the code is a
  delta - the gates run on it, the list is read again and the word is asked again.
- The word is recorded in the work log with its date and the list it released.

### Recording the owner's answer

- **Quote the answer literally**, with date and channel (and a translation when the
  answer is in another language than the register). The decision row says which option
  it took.
- **A divergence is recorded as such**: "XY#1 = (b), DIVERGED from the recommendation
  (a)", with the owner's words. Divergences measure the recommendations and show where the
  evidence was read wrong; never smooth one into "as recommended".
- "Follow the recommendations" is a valid answer: quote it once for the round; every
  decision of that round is then the recommended option - except a **Reserved** question:
  an answer that names it, even by range ("Q-XY1 to Q-XY14"), answers it; one that does
  not name it leaves it open. Nor does it give the go on a plan the round carries: that
  takes its own explicit sentence, naming the plan ([closing round](#the-closing-round-carries-the-first-plan-ek26)).
- An ambiguous or partial answer is not completed by the agent: what is still open stays
  a question.
- **An answer is read by the ids it names.** A round number that matches no open round
  (the answer says round 2 while round 1 is the open one) is noted beside the quote -
  never a reason to reopen, nor to ask again when the ids leave nothing open. One owner
  answering several cases in one message: an id is read by the case it is attached to (a
  parenthesis, a case name); an id attached to another case is that case's, whatever its
  key.
- **A message that names no open id and only defers what a person must end** - the
  owner's walk, a prepared change's rehearsal: "they stay owed" - answers no question,
  gives no go and releases nothing. It is quoted once where the item lives - the work
  log's "After the go" section, outcome `gate owed by <person>`, when a go stands; else
  the test evidence's "Waits and reruns" - and cited, not quoted again, elsewhere. The
  closing draft keeps its marker and every open id stays open: it closes, opens and
  releases nothing. A person it leaves unnamed is asked for in the next round
  ([closing round](#the-closing-round-carries-the-first-plan-ek26)).
- **The kit changed between the question and the answer** (a new kit version adopted, a
  kit decision taken in the same message): record the answer as given. A decision that now
  contradicts the new rule stands, and the next round asks the owner, citing the decision
  and the new rule ([INSTALLATION](../../INSTALLATION.md#moving-to-a-newer-kit-version),
  item 3). A change that only removes the recommendation's stated reason - the option it
  ruled out is now allowed - is said in the decision row and told to the owner on a line of
  the hand-off: no new question, and the round still closes.
- **An answer to a fact request** (`R-XY2`) is read by what it is about:

  | The answer states | Recorded as | Settled by |
  |---|---|---|
  | a fact about the world - volumes, opening hours, where it runs and whose machine it is, the people and who does what | a fact, `F7`, owner-provided: the quote and its date are the evidence | the answer itself |
  | what the code or the system **does** - "production runs the second profile", "nobody ever fills the e-mail field" - and an environment fact the code constrains: a server or runtime version, a profile, the database the code selects ("it runs on server version 10") | a **hypothesis**, quoted with its source (`owner R-XY2`): a row of the hypothesis register on the legacy track (priority high), an open fact elsewhere; a plan that rests on it lists it as a fact premise | the code, a read-only probe or a run - never the owner's word alone |
  | the result of a read or probe the round asked a person to make - lines copied from an installation's configuration, a yes or no about a secret | a **probe result**: who read, when, what was copied - never a secret's value (whether it is set, or matches, is enough) | the read itself: it settles the hypothesis it was asked for; what it did not cover stays open |

  The line between the first two rows is what the code can contradict: an environment the
  code declares or selects (the server interface it is built against, the profiles it
  defines) is checked against the code like any claim about the system; where it runs and
  who runs it stay facts about the world.

  Where this and the legacy track's rule meet - the owner's memory is a hypothesis until
  the code confirms it ([`assess-legacy-repo`](../assess-legacy-repo/SKILL.md),
  [legacy profile](../../profiles/legacy.md) rule 2) - the split above decides: a fact
  about the world is a fact on every track; for what the system does, the hypothesis rule
  wins.

## Business rules and the rule gate (T24 — candidate, optional)

**Part maturity**: candidate — one case, optional. A project adopts it by a decision in its
own register; without that decision this section is advice.

**What becomes a rule**: any decision that changes what a user sees, what a screen,
report or import does, or what is charged or paid — whatever started it (a bug, a change
request, a task, a chat). Also a technical decision that binds more than one work item.
Only a choice that matters to one work item stays in that item's notes, and a process
choice stays in the work log.

**One rule per file** (`RULES/RULE-<slug>.md` in the area the rule belongs to), started
from [`templates/RULE.template.md`](../../templates/RULE.template.md): the current rule;
an **append-only history** (date, who decided — the name as the source writes it, never an
inferred role —, the decision, **Authorised** or **Denied**, the evidence); a regression
guard; and the **open questions, registered when they are asked**, not when they are
answered. A change is a new row; old rows are never edited; a denied alternative is a row
too — that is what lets a regression be caught. Each history row takes the next number
of the project's register, which keeps a one-line row for it pointing to the rule file:
the number is cited like any decision (`ACME-2.1#31`), and the history is read in the
rule file.

**The gate, at three points**:

| Point | Stops when | Then |
|---|---|---|
| Plan, spec or test — before it is written | the change brings back a behaviour of a **Denied** row and no newer **Authorised** row allows it, or it implements the open point of a rule question | quote the row (number, date, who decided, evidence) and wait for a new Authorised row from the person who can decide it — for a user-visible rule, whoever owns that behaviour |
| Review | the result regresses to a **Denied** row | block the approval, quote the row |
| Closing | a visible behaviour the change alters has **no covering row**, the change implements an **open question**, or it matches a **Denied** row | refuse to close; register the question or the row first. The closing note names the rule rows it relies on |

## Section structure of the final prompt

```markdown
# Prompt — Phase N: <name>
**Namespace**: <KEY> (home register: <path>) · reserved ranges, if any
## Context
## Objectives (numbered)
## Workflow (step-by-step flows, with decision tables)
## <Specifications grouped by domain>
## Deliverables (table: item → what it does → when)
## Recorded decisions (KEY#1..N, permanent; the owner's words quoted)
## Pending questions (Q-<NS>n, and the facts requested R-<NS>n; zeroed at closing)
## Assumptions — to ratify (A-<NS>n: option taken, where applied, how to undo)
## Release (what waits for the owner's release word - a pointer to the list in TICKETS/<ID>/CLOSE.md, section 4)
## Out of scope for this phase
## Success criteria (numbered, testable)
```

## Why this is the engine's differentiator

Anyone can plug an AI into a legacy repository. What cannot be copied is the
human-in-command process: the AI organizes, evidences, and suggests; the business
owner decides; the decision becomes a permanent record traceable down to the line of
code. In systems with decades of history, this is what keeps the rewrite from
repeating the mistakes the legacy already made — and from losing the right calls it
accumulated.
