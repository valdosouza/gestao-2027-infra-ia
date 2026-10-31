# Template: Front prompt

**Scope**: method
**Used by**: [front-protocol](../skills/front-protocol/SKILL.md) - "Lifecycle of a front", step 1 (open), and
every round, wave and save after it. Worked examples of every section:
[references/prompt-sections.md](../skills/front-protocol/references/prompt-sections.md).
**Produces**: `prompts/prompt_<front>.md` in the knowledge base (placement:
[kb-setup](../skills/kb-setup/SKILL.md)). Copy the skeleton below, fill every `<...>`, and
set the copy's own Scope line (`mixed` when the front holds portable method, else `case`).

Rules the skeleton assumes:

- **One writer**: the session named in `**Writer**` is the only one that edits the file.
  A parallel session writes `prompt_<front>-<wave>.md` from this same skeleton, with its
  own namespace or a reserved range ([decision-rounds](../skills/decision-rounds/SKILL.md)).
- **60 KB budget**: closed wave blocks move verbatim to `prompt_<front>-execution.md`, the
  inventory to `prompt_<front>-inventory.md`, answered rounds (each question's text with its
  status line) to `prompt_<front>-rounds.md`; a stub with a pointer stays. The recorded
  decisions and the open questions never move.
- **Stable section numbers**: other documents cite them; nothing is renumbered. Wave blocks
  start at 13 and take the next number.
- **Ids** (`Q-<NS>n`, `R-<NS>n`, `A-<NS>n`, `<NS>#n`) and the release word are
  [decision-rounds](../skills/decision-rounds/SKILL.md); this skeleton only gives them a place. The first set of
  questions is **Round 0** (later rounds 1, 2...); a question whose answer the owner keeps - a limit, a fee, a deadline -
  ends its title with **Reserved - never assumed** and is never taken as an assumption.
- **The closing round** - the one that closes the prompt, or settles the pilot's first change - carries the move to
  level 2 and the first plan, whose go is asked on a line of its own
  ([decision-rounds](../skills/decision-rounds/SKILL.md#the-closing-round-carries-the-first-plan-ek26)); its section
  links that plan, and its questions were walked against the go-live list before it went out.
- Optional sections may be deleted; the header, Negative knowledge, Out of scope, Success
  criteria and Resume never are.

## Skeleton

````markdown
# Front - <name the owner recognizes>

**Scope**: <mixed (<what is portable>) | case>
**Origin**: <the owner's request, quoted, with date and channel | Q-<NS>n of `<other prompt>`, <date>>
**Opened**: <YYYY-MM-DD>. **State**: <at most five lines, replaced at every save: the round; what is executed and
where; what waits for the owner, by id; which item blocks the release>. Resume from section <N>.
**Writer**: <session name> (since <YYYY-MM-DD>). Parallel sessions: <none | <name> -> `<its file>`, namespace <NS2> or
range <...>>
**Namespace**: `<NS>` - home register: <this file, "Recorded decisions" | `<path of the register>`>. Reserved: <none | ranges>
**Ownership**: <the groups whose code was read by name only, and which names | none>
**Cross-cutting**: <repositories and sibling fronts this one touches> - say it at every resume.
**Data access**: <read-only sessions; <why: the development database holds real data | ...>>
**Live checkouts**: <paths that a watch or dev server runs from - never edited>
**Inventory base**: <repo> `main` <hash> · <repo> `main` <hash>
**Annexes**: <none | `prompt_<front>-inventory.md` · `prompt_<front>-execution.md` · `prompt_<front>-rounds.md`>

---

## 1. The ask and what is already decided (inherited - not re-discussed here)

**Owner, literally (<date>, <channel>)**: "<...>"
Inherited: <KEY#n> (<one line>) · <KEY#n> (<one line>).

## 2. Facts (evidence file:line or a read-only query)

| # | Fact | Evidence |
|---|---|---|
| F1 | <...> | `<file>:<line>` |

### 2.1 Objective defects (fixing is not deciding)

- **C1 - <the defect, in one line>.** <why it is an error with one correct fix>. Correction: <...>. Not a question.

### 2.2 Impact today (read-only)

- <who or what is affected now; what the change will and will not alter>

### 2.3 Facts requested from the owner (only the owner has them - not decisions)

- **R-<NS>1** - <the fact asked: a date, a machine, a file not handed over>. Weighs on: <Q-<NS>n, section>.
  <after the answer, a fact about the world (volumes, hours, where it runs and whose machine, people): **-> F<n>**
  (owner, <date>: "<literal>") | what the code or system does, an environment the code constrains (a server or
  runtime version, a profile, the database it selects) included: **-> H-<NNN>** (owner, <date>: "<literal>") - a
  hypothesis until the code, a probe or a run confirms it | a read the round asked a person to make: **-> probe
  result** (<F<n> when recorded before - the id kept>; <who>, <date>, what was copied - never a secret's value),
  settling H-<NNN>
  ([decision-rounds](../skills/decision-rounds/SKILL.md#recording-the-owners-answer))>

## 3. <Inventory | Facts that decide (summary - detail in `prompt_<front>-inventory.md`)>

| # | <Item | Fact> | <What it does today | Consequence for the design> | Evidence |
|---|---|---|---|

## 4. Guardian opinion (<date> - integrated)

**Concept**: <one sentence, no "and">. **Piece or composition**: <...>. **Reused**: <...>.
**Left out**: <... and why>. **Names**: <...>.

## 5. Design and waves (provisional - valid after round <n>)

<the design in a few lines or a short list>

| Wave | Content | Depends on |
|---|---|---|
| 0 | <...> | <decisions, questions, requests, other fronts> |

## 6. Negative knowledge (what NOT to do - holds whatever is decided)

1. **<the trap>** - <reason: evidence, probe or id>. <what to do instead, or what would lift it>.

## 7. Questions - round 0 (<open | answered in part | closed>)

- **Q-<NS>1 - <the question>?< Reserved - never assumed.>** Problem: <...>. Evidence: <F#, R-<NS>n, file:line>.
  (a) <...> (Rec.); (b) <...>; (c) <...>.
  **Rec.: (a)** - <why>.
  <after the answer: **-> <NS>#n = (x)** (<"as recommended" | "DIVERGED from the Rec.">) (owner, <date>: "<literal>") |
  **-> no answer; restated as Q-<NS>m in round 1**>

### 7.1 Workspace questions - namespace `<WS>` (optional; delete when none)

<Only what binds the whole knowledge base and no workspace round has asked yet - who owns the decisions, the release
word, and the Day-1 assumptions to ratify (`A-<WS>n`, INSTALLATION step 4). Same format; the answers go to the root
register.>

- **Q-<WS>1 - <the question>?** Problem: <...>. Evidence: <...>. (a) <...> (Rec.); (b) <...>. **Rec.: (a)** - <why>.

### 7.<n> Questions - round <N> (<open | answered in part | closed>)

<One subsection per later round, the next free number (7.2, 7.3...), never renumbered; its workspace questions in the
next subsection, as in 7.1. Same format and status lines as round 0. A round that a wave raised goes in the wave's
block (13.4). Answered rounds move to the `-rounds.md` annex when the budget asks for it. A question added while the
round is out and unanswered - a kit move's ratification, what the new rules ask of the round - is appended, dated and
marked "added after the round went out"; the questions already asked are never reworded (INSTALLATION, "Moving to a
newer kit version").>

- **Q-<NS>m - <the question>?** Problem: <...>. Evidence: <...>. (a) <...> (Rec.); (b) <...>. **Rec.: (a)** - <why>.

<Only in the round that closes the prompt (greenfield) or settles the pilot's first change (legacy) - delete otherwise:>
**Carried by this round** (kit decision EK#26): the move to level 2 - Q-<WS>n in the workspace block (when the case is
at level 1) | <WS>#n - decided, in effect when this round closes the prompt. The first plan, awaiting its go:
`TICKETS/<NS>-W1/PLAN.md` - Premises: Q-<NS>m: Rec (a); Q-<WS>n: Rec (a); fact premises: <R-<NS>n | none>; written on
the recommendations - rewritten if any answer differs. Confirmations its gate needs: <R-<NS>n - the settings patterns
proposed in `_REGISTRY/SETTINGS.md` section 2 | none>. Who applies and rehearses it (a prepared change): <R-<NS>n ->
a row of `_REGISTRY/PEOPLE.md` | not prepared>.
**Go-live list** (walked before this round went out): recovery of access <Q-<NS>n | covered by <NS>#n>; data at rest
and backups <...>; open items carried over from the old practice <...>; who operates it <...>.
**Go on that plan?** <a line of its own; answering the questions above is not a go; the reds of its test-first steps
are shown with it and covered by this one go (EK#30)>
<after the answer - the go is a sentence of its own naming the plan, in any paragraph of the message: **-> go** (owner,
<date>: "<literal>"), WORKLOG row <n> | **-> no go** | **-> premise Q-<NS>m diverged: plan rewritten, go asked again**>

## 8. Assumptions - to ratify

- **A-<NS>1** - answers Q-<NS>n with its Rec. (<x>): <...>. Applied: <files, tests>. Undo: <...>.

## 9. Deliverables - only after the decision AND the release word

1. <WRITTEN | PROVEN | APPLIED> <date>: <deliverable> - <where; how it was proven>.

## 10. Out of scope (moves, never disappears)

- <item> -> <its new home: another front, wave n, a request to <group> (R-n), a decision>.

## 11. Success criteria

1. <testable statement> (<decision ids>; proven by <test, probe or walk-through>).

## 12. Resume

<the resume block - templates/RESUME_BLOCK.template.md - replaced at every save>

## 13. Wave <name> - <date>, worktree `<dir>`, branch `<branch>` - <NOTHING committed | committed <hashes> | released>

**Where**: <worktree per repository, base commit each>; outside git: <links -> targets>. Data: <access>.
<Groups not read>. **Precondition checked**: <...>.

### 13.1 New facts (they correct premises of earlier rounds)

- **F<n> - <the premise of <NS>#n was false | ...>**: <evidence>. <what was done about it: assumption, question>.
- <after the go: the plan's premises and risks re-read - <hold; new risk, noted "After the go" in the plan and as a stop
  in APPLY.md | premise broken: plan void | revision>, WORKLOG "After the go" row <n> (change-gate step 4 item 7)>

### 13.2 What was done

- <repository>: <pieces, files> (<decision ids>).

### 13.3 Assumptions executed - to ratify

- **A-<NS>n** - <option taken>. Applied: <...>. Undo: <...>.

### 13.4 Questions - round <M> (<which one, if any, blocks the release>)

<When the round's answers change approved behaviour (the delivery gates' questions after the go), it carries the plan's
revision ([decision-rounds](../skills/decision-rounds/SKILL.md#a-round-raised-after-the-go-the-ek26-pattern)):>
**Carried by this round**: `TICKETS/<NS>-W<n>/PLAN.md` revision <r> - Premises: Q-<NS>m: Rec (a); <...>; written on the
recommendations - rewritten if any answer differs. **Go on that revision?** <a line of its own>

### 13.5 Tests

- <repository>: <suites, tests, skipped and why>; new: `<test file>` (<count>: <what it pins>).

### 13.6 Gates

- <gate>: <score> <PASSED | FAILED> -> <rework> -> <re-score>; findings: <severity, one line each, what became a probe>.

### 13.7 Known limits (negative knowledge)

- <limit accepted> - <reason or the id that accepted it>; <what would lift it>. <or: none found - checked <...>>

### 13.8 Release plan (only with the release word)

1. <data before the code that needs it> 2. <merge order and why> 3. <expected conflicts: file -> resolution>
4. <checks after the release> 5. <clean-up>

### 13.9 Resume here

<the wave's resume block, while the wave is unfinished>

## Recorded decisions

<When the home register is elsewhere: one line per decision with its id and a pointer - never a second full copy.>

### Round 0 - <answered | answered in part | closed> (<owner>, <date>, <channel>: "<literal answer>")

- **<NS>#1** (Q-<NS>1 = (<x>)<, DIVERGED from the Rec.>) - <the decision>. <why, in the owner's words when given>.

### Round <N> - <answered | answered in part | closed> (<owner>, <date>, <channel>: "<literal answer>")

- **<NS>#n** (Q-<NS>m = (<x>)) - <the decision>. One block per round, in order. <A kit change between the question
  and the answer that removed the recommendation's stated reason: "stands as answered; its reason (<...>) was removed by
  <kit version or decision>" - the owner told in Pending, no new question.>
- <closing round only> Go on `TICKETS/<NS>-W1/PLAN.md`: <"<literal>" -> WORKLOG row <n> | not given | void - premise
  Q-<NS>m diverged>. A go, not a decision: no `<NS>#n`.

## Pending

- Owner, first: <ids that block the release>. Then: <questions to answer>; <facts requested, R-<NS>n>; <assumptions to
  ratify>.
- Requests out: <group R-n (open)> | none.
- Told, no question: <<NS>#n - a kit change removed its recommendation's stated reason; <option> is now allowed> | none.
````
