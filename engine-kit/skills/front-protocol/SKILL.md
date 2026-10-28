---
name: front-protocol
description: Runs a front (epic) from one living prompt file - fixed sections, a 60 KB budget with closed waves in annexes, one writer per file, negative knowledge, save and resume, a worktree per front, ownership partition. Use when opening, running, saving or resuming a front, or beside parallel sessions.
---

# Skill: Front protocol (one living prompt per front)

**Scope**: method
**Maturity**: operating

**When to use**: a piece of work is too big for one session or one work item - an epic, a
workstream, a module, a change across several repositories - and will run over several
sessions and rounds of decisions. Open it as a **front**, then use this skill every time
the front is touched: a round is organized or answered, a wave is executed, a session ends
("save everything so we can pick it up later"), a new session picks it up, a parallel
session or another group gets involved.
**Not for**: numbering and recording questions, decisions, assumptions and the release
word - that is [`decision-rounds`](../decision-rounds/SKILL.md), which this skill uses and
never repeats; the concept check ([`conceptual-guardian`](../conceptual-guardian/SKILL.md));
where a file goes ([`kb-setup`](../kb-setup/SKILL.md)); the closing chain
([`retain-knowledge`](../retain-knowledge/SKILL.md)).
**Real origin**: case zero - one product modernized as about twenty-five parallel fronts,
each driven by AI sessions over weeks (2026-09 to 2026-10). The most mature front ran six
rounds and four executed waves in worktrees across four repositories; the knowledge
repository took about sixty checkpoint commits in one week (one per round, gate pass,
publication and save). The rules below are the corrections that case made - its largest
front prompts reached 330 and 720 KB, written by several sessions at once
([Anti-patterns](#anti-patterns)).
**Parts and maturity**: the living prompt (T26), session save and resume (T30), the worktree
per front (T31) and the ownership partition (T32) are `operating` - one case, core by
choice; negative knowledge (T12) is `proven`. See the [register](../../docs/TECHNIQUES.md)
and the [labels](../../docs/MATURITY.md).
**Detail**: [references/prompt-sections.md](references/prompt-sections.md) (every section
with a neutral example, the wave block, moving to an annex) ·
[references/save-and-resume.md](references/save-and-resume.md) ·
[references/worktrees.md](references/worktrees.md) ·
[references/ownership-partition.md](references/ownership-partition.md).
**Templates**: [`templates/FRONT_PROMPT.template.md`](../../templates/FRONT_PROMPT.template.md)
and [`templates/RESUME_BLOCK.template.md`](../../templates/RESUME_BLOCK.template.md).

---

## The front in one picture

```
<kb>/prompts/
+-- prompt_<front>.md               THE living prompt: one writer, at most 60 KB
+-- prompt_<front>-inventory.md     annex: item-by-item inventory, evidence file:line
+-- prompt_<front>-execution.md     annex: closed waves, moved verbatim
+-- prompt_<front>-rounds.md        annex: answered rounds, moved verbatim
+-- prompt_<front>-<wave>.md        a parallel session's own file (its writer, its namespace)
<work>/<front>/<repo-a>/  <repo-b>/ one worktree per touched repository, one branch name
<work>/<front>/<link>               links to shared config, listed in the prompt ("outside git")
```

The prompt is, at once, the front's spec, its decision log (or the mirror of its home
register), its execution log and its hand-over note: a session that reads the header and
the resume block can act without asking what happened.

## 1. The living prompt (T26)

### 1.1 Header lines - rewritten, never appended to

| Line | Holds |
|---|---|
| `# Front - <name>` | one name the owner recognizes |
| `**Scope**` | usually `mixed`: the method parts are portable, the ids and code are the case's |
| `**Origin**` | the owner's request, quoted; or the question of another front that opened this one |
| `**Opened**` · `**State**` | the date; the state in at most five lines - round, what is executed and where, what waits for the owner (by id), "resume from section N" |
| `**Writer**` | the one session that writes this file, since when ([1.5](#15-one-writer-per-prompt-file)) |
| `**Namespace**` | the key, its home register, reserved ranges ([`decision-rounds`](../decision-rounds/SKILL.md)) |
| `**Ownership**` | the other groups whose code was read by name only ([section 5](#5-ownership-partition-t32)) |
| `**Cross-cutting**` | the repositories and sibling fronts it touches - said out loud at every resume |
| `**Data access**` | for example "read-only sessions; the development database is production" |
| `**Inventory base**` | the commit of each repository the facts were read from |

The State line is the first thing every session reads and the one that rots fastest: it
is **replaced** at every save. Its history lives in the execution blocks and the commits.

### 1.2 Sections, in order

| # | Section | Holds | Rule |
|---|---|---|---|
| 1 | The ask and what is already decided | the owner's words, literally; inherited decisions by id | not re-discussed here |
| 2 | Facts | numbered (`F1`...), each with evidence (`file:line`, a read-only query); **objective defects** (`C1`...) with their correction; the impact today; the **facts requested from the owner** (`R-<NS>n`) - what only the owner knows | fixing is not deciding: an objective defect is corrected, never asked; a requested fact has no options, its answer becomes an `F` |
| 3 | Inventory | the item-by-item table, or a "facts that decide" summary (fact -> consequence for the design) with the detail in the `-inventory.md` annex | every row carries evidence |
| 4 | Guardian opinion | the [`conceptual-guardian`](../conceptual-guardian/SKILL.md) output, dated and integrated | a conceptual divergence stops the design |
| 5 | Design and waves | the provisional design; the wave map (wave -> content -> depends on) | valid only after the round that fixes it |
| 6 | Negative knowledge | what NOT to do, whatever is decided ([section 2](#2-negative-knowledge-t12)) | each entry with its reason |
| 7 | Questions - Round 0, then round N | `Q-<NS>n`: problem, evidence, options, one recommendation (**Reserved - never assumed** when the owner keeps the answer); under each, once answered, its status line; a second block under the workspace key for what binds the whole base - who owns the decisions, the release word - while no workspace round asked it | format and recording: [`decision-rounds`](../decision-rounds/SKILL.md) |
| 8 | Assumptions - to ratify | `A-<NS>n`: option taken, where applied, how to undo | [`decision-rounds`](../decision-rounds/SKILL.md) |
| 9 | Deliverables | numbered, each with its status (written, proven, applied) | produced only after the decision AND the release word |
| 10 | Out of scope | each item with its new home (another front, a later wave, a request to another group) | moves, never disappears: an item with no destination is lost, not out of scope |
| 11 | Success criteria | numbered, testable, each with how it is proven | cite the decision ids |
| 12 | Resume | the resume block ([section 3](#3-session-save-and-resume-t30)) | always current |
| 13+ | Wave execution blocks | one per executed wave ([1.3](#13-per-wave-execution-blocks)) | closed waves move to the annex ([1.4](#14-size-budget-and-annexes)) |
| last | Recorded decisions · Pending | per round, with the owner's words; a by-id list of what waits | one home register per decision |

Section numbers are stable: other fronts, commits and resume prompts cite them
("resume from section 13.9"). New material gets the next number; nothing is renumbered.

### 1.3 Per-wave execution blocks

Every executed wave gets one numbered section, written by the session that ran it. The
heading says where it ran and the commit status:
`## 13. Wave <name> - <date>, worktree <dir>, branch <b> - NOTHING committed`.

| Part | Holds |
|---|---|
| Where | worktrees, branch, base commit per repository, links outside git, data access, groups not read |
| New facts | what the wave found that corrects earlier premises ("the premise of `XY#2` was false: ...") |
| What was done | per repository: pieces, files, the decisions each one implements |
| Assumptions executed | `A-<NS>n`, to ratify |
| Questions - round M | what the wave raised; which one, if any, blocks the release |
| Tests | counts (suites, tests, skipped and why); each new test and what it pins |
| Gates | each pass with score and verdict, the rework, the re-score; findings with severity (the delivery gates are their own skill, planned) |
| Known limits | the wave's negative knowledge ([section 2](#2-negative-knowledge-t12)) |
| Release plan | ordered steps, executed only with the release word: data before the code that needs it, expected merge conflicts, what to check after |
| Resume here | the wave's resume block, when the wave stops unfinished |

### 1.4 Size budget and annexes

- **Budget: 60 KB per prompt file** - the same budget `kit_lint.py` applies to the kit's
  own documents. Check it at every save; over it, move material out before writing
  anything new.
- **What moves**: closed wave blocks to `<prompt>-execution.md`; the inventory to
  `-inventory.md`; answered rounds (question text and status lines) to `-rounds.md`; an
  audit or a long analysis to its own annex. Recorded decisions and open questions never
  move. A wave is **closed**
  when its release happened (or a decision dropped it) and its questions are answered or
  carried into a later round.
- **What never moves**: the header, open questions, assumptions to ratify, the resume
  block, negative knowledge that still holds, the decisions (or their mirror).
- **How**: move verbatim, keeping the section numbers; leave in place the heading, a summary
  of at most three lines and the pointer; lift still-valid negative knowledge into
  section 6; fix the resume pointers; one checkpoint commit for the move. Never fix
  content during a move. Procedure: [references/prompt-sections.md](references/prompt-sections.md).
- An annex has its own header (Scope, Front, why it exists) and the same budget; a
  second execution annex splits by wave.

### 1.5 One writer per prompt file

- **One session writes a given prompt file** - the writer named in its header. Every other
  session reads it and writes elsewhere.
- **A parallel session gets its own file** (`prompt_<front>-<wave>.md`, whose header names
  it as writer) **and its own namespace or a reserved range**, written in the home
  register before it starts - [`decision-rounds`](../decision-rounds/SKILL.md), "Ids,
  namespaces and registers", with [worked examples](../decision-rounds/references/ids-and-registers.md).
  When the wave closes, that file is its annex.
- **Coordination is by message, not by edit**: the parallel session tells the writer what
  binds both (a decision, a merge conflict to expect, an adapter to write); the writer adds
  a pointer and a summary to the main prompt. At merge, the writer is the conductor of
  decision-rounds.
- **One question sheet per round, from the writer.** An answer list that repeats an id or
  skips one is asked again for that id, never repaired by guessing
  ([`decision-rounds`](../decision-rounds/SKILL.md), "Recording the owner's answer").
- **A reformulated question takes a new number** that cites the old one ("`Q-XY12`
  restates `Q-XY5` with the corrected facts") - never a primed id such as `Q-XY5'`.

## 2. Negative knowledge (T12)

Every wave - and the front itself - records **what not to do** and **the limits it
accepted**. It is the most expensive knowledge to rediscover, and the first to be lost
when a wave closes.

| Kind | Where | Example (neutral) |
|---|---|---|
| Trap - holds whatever is decided | section 6 | "Deactivating the global account switches the person off in every tenant; removing a guest deactivates the link" |
| Limit accepted | wave, Known limits | "The guard depends on the router's internal shape; the proof test breaks loudly when the framework changes it" |
| Deliberate non-target | wave, Known limits | "Deliberate evasion (a computed property name) is not a target of the fence" |
| Proof caveat | the proof's own section | "The seed script is not transactional: on a failed final check the insert already wrote; it is idempotent, so fix the list and run it again" |
| Environment trap | wave, Known limits | "A timing test with tens of milliseconds of slack fails in the full suite on a busy machine" |

1. **Each entry carries its reason**: evidence, a probe, or the id of the decision or
   assumption that accepted it. A limit nobody accepted is not a limit: it is a question.
2. **A limit names what would lift it** (a later wave, a question, a request to another
   group) when something can.
3. **It survives the annex**: when a wave moves, its still-valid entries are lifted into
   section 6; a superseded entry is marked with what superseded it, never deleted.
4. **It is a retention candidate**: at the close of the front, the entries that will hold
   for the next front go through [`retain-knowledge`](../retain-knowledge/SKILL.md).
5. **A wave with no negative knowledge did not look**: write "none found" and what was
   checked.

## 3. Session save and resume (T30)

### 3.1 Save - at the end of every session

Triggered by the owner ("save everything, we continue later"), before a context limit,
before a hand-off, and at the end of every session that changed anything. The writer
rewrites the resume block from [`templates/RESUME_BLOCK.template.md`](../../templates/RESUME_BLOCK.template.md):

1. **Where the work is** - per repository: worktree, branch, base commit, commit hashes
   and whether they are pushed; what is **not** committed; scripts for shared data:
   proven where, applied or not.
2. **Outside git** - links, linked or copied config files, temporary copies: everything
   `git status` will not show.
3. **Verified state** - the checks that ran *in this session*, on the recorded tip, with
   their result (typecheck clean; N suites, N passed, N skipped and why), and which
   checkout of each sibling repository they used ([section 4](#4-worktree-per-front-t31)).
   A check not run is written "not run", never "should pass".
4. **What is left, in order** - the owner's decisions first (by id, each with a one-line
   reminder so the owner can answer without opening the file); then the commits (only
   with the release word, and which paths); the release steps; the clean-up.
5. **Next free ids** - per sequence, written `<sequence>: <number>` (`XY: 18 · Q-XY: 40 ·
   A-XY: 15 · R-XY: 3`), and the reserved ranges to skip, written the same way
   (`Q-XY: 50-53`). Never `XY#18`: the citation check reads it as a decision that does not
   exist yet ([`decision-rounds`](../decision-rounds/SKILL.md), "Ids").
6. **Sibling sessions** - where each one is and what it owns.
7. **The paste-ready prompt** - at most eight lines: the file and section; the
   cross-cutting warning; the first commands to run; slots for the owner's answers; the
   standing rules (nothing committed, pushed or applied without the release word; the
   live tree is not edited; data read-only; other groups' code by name only).

Then: replace the header's State; rewrite the front's line in the index of fronts (an
index is a map - [`kb-setup`](../kb-setup/SKILL.md)); write the session log where the case
keeps one ([`memory-engineering`](../memory-engineering/SKILL.md)); check the size budget;
make the checkpoint commit.

### 3.2 Checkpoint commits

- **Stage only the front's own hunks.** Shared files (an index, a skill, the rules file)
  carry other sessions' work in progress: stage by hunk, never `git add -A` or
  `git commit -a`; another front's file stays out even when it is untracked. Read
  `git diff --cached` before committing - what stays unstaged belongs to someone else.
- **Rhythm**: one checkpoint per round decided or executed, per gate pass, per
  publication (with the hashes of what was published) and per save. The message names
  the front, the ids and the resume section:
  `Front XY: round 3 decided and executed (XY#10-XY#13), gates 0.75/0.80; resume from section 13.9`.
- **A checkpoint commit is a commit**: it follows the release word of
  [`decision-rounds`](../decision-rounds/SKILL.md). A case may decide in its own register
  that the owner's save request releases the checkpoint of the front's own documents -
  never code, data or a push.
- The hashes of a wave's code commits reach the resume block in the *next* checkpoint (a
  commit cannot contain its own hash).

### 3.3 Resume - at the start of a session

1. Read the header and the resume block; state the cross-cutting warning before acting.
2. Run the listed verification commands and compare with the recorded state - branch tips
   against the recorded hashes, test counts, shared state such as a row count. A
   difference is a fact, recorded before anything else: someone else moved.
3. Apply the owner's answers literally, by id; take the next free ids from the block and
   check them against the home register.
4. Re-read the file before every edit: it changes between rounds.

Detail and a worked save: [references/save-and-resume.md](references/save-and-resume.md).

## 4. Worktree per front (T31)

- **The live tree is production.** Where a watch-mode or development server runs from the
  main checkout, saving a file there is a deploy and switching its branch is an outage.
  Nobody edits it; nobody checks out another branch in it.
- **One worktree per front, in every repository the front touches**, with the same branch
  name in each and the base commit recorded.
- **Shared config by link, and every link listed**: dependency folders, sibling
  repositories that tests reach by relative path, gitignored config. Link them so the
  relative layout matches the main checkouts; list each one under "Outside git".
- **Data**: read-only sessions against shared databases; a schema or seed change is proven
  in a disposable copy first ([`disposable-proof`](../disposable-proof/SKILL.md)).
- **Green certifies a combination of checkouts.** A suite that reads sibling repositories
  is green for that exact set - this worktree, sibling X at hash h, sibling Y at the tip of
  main. Record the set with the result; a merge in a sibling can turn it red without a
  change here.
- **The last front to reach main writes the adapter.** When two fronts build pieces that
  must fit together (a derived list and a hand-kept one), the order of arrival decides who
  writes the glue and its tests. Agree it by message and record it as a decision in one
  home register. Two fronts that both append to one list merge as a union, listed in the
  release plan.
- **Remove a link by its pointer, never its target**: links first, then check that each
  target is intact, then remove the worktree. A recursive delete through a link deletes
  the real repository behind it.

Commands, link kinds per platform, release order and removal: [references/worktrees.md](references/worktrees.md).

## 5. Ownership partition (T32)

- **Every code area has one owning group**, written once in the workspace rules
  (`AGENTS.md`); each front's header repeats which groups' code it did not open.
- **Another group's code is read by name only**: endpoint and table names, the contracts
  and documents the group publishes - never the implementation. A design built on another
  group's internals breaks when that group changes them, and nobody tells the front.
- **Shared data is a contract**: in a table the other group writes, a change of shape is
  additive and carries a default unless that group agreed otherwise - never a rename,
  never a new mandatory column without a default.
- **A need becomes a request in that group's document** - in the request inbox the group
  declares (append-only for others), never in the body of their prompt (one writer). It
  says what is needed, why, our evidence and what it blocks; our front lists it as
  pending, with the pointer.
- **The answer comes back as a fact** ("fact from group G, date"), quoted. When it changes
  the design it opens a question in our round; a release that depends on an unanswered
  request waits.

Request format and a worked example: [references/ownership-partition.md](references/ownership-partition.md).

## Lifecycle of a front

1. **Open** - copy the [front template](../../templates/FRONT_PROMPT.template.md) into
   `prompts/` ([`kb-setup`](../kb-setup/SKILL.md)); fill the header; name the namespace and
   check what is already decided (decision-rounds, Round 0 step 0); write the facts (and
   the facts requested from the owner), the inventory, the guardian opinion, the design,
   the negative knowledge and the Round 0 questions. Save.
2. **Every round** - the owner answers; [`decision-rounds`](../decision-rounds/SKILL.md)
   records it; a status line goes under each question; residues are swept. Save.
3. **Every wave** - worktrees; the execution block; tests and gates; known limits; the
   release plan. Save. With the release word: commits, then a checkpoint with their
   hashes. A closed wave moves to the annex when the budget asks for it.
4. **Close** - "Pending: none"; every out-of-scope item handed to its home; the negative
   knowledge through [`retain-knowledge`](../retain-knowledge/SKILL.md); links and
   worktrees removed; the prompt moves to the owning project's mirror
   ([`kb-setup`](../kb-setup/SKILL.md)); the index line says closed. This is the only move:
   a prompt that a framing or a round **closed** (its questions answered, its State line
   "framing closed") stays in `prompts/` as the living front prompt until the front itself
   closes.

## Which tool checks which rule

| Rule | Checked by |
|---|---|
| A cited `KEY#N` (or `D-KEYN`) exists | [`decisions_index.py`](../../runtime/registry/README.md) `--check-touched` |
| The kit's own documents stay under 60 KB | [`kit_lint.py`](../../runtime/kit_lint.py) (check 6); a case applies the same budget to `prompts/` - no tool yet |
| Only the front's hunks are staged | `git diff --cached`, read at every checkpoint - no tool yet |
| Worktree tips equal the recorded hashes | resume step 2, by hand - no tool yet |
| Header, sections, one writer, ownership line | review at every save - no tool yet |

## Anti-patterns

Real situations from case zero, distilled:

- **One prompt, several writers, no budget.** Front prompts of 330 and 720 KB, written by
  parallel sessions at once: three sessions each appended their own numbered section; one
  session collided on an assumption number and improvised a prefix of its own mid-file;
  the owner answered one id twice and skipped another, and the answer had to be
  confirmed later. The budget, the annex per closed wave, one writer per file and
  namespaces reserved before work starts are the remedy.
- **A State line that grew by append** to twenty lines of history in the header: the
  current state was the hardest thing in the file to find. It is replaced at every save.
- **Primed question ids** (`Q-XY5'`, `Q-XY8'`) for reformulated questions: two ids looked
  alike and answers referred to the wrong one. A new number that cites the old one.
- **A decision built on a premise nobody re-read**: a wave found that the premise written
  in the decision ("each module only calls its own API") was false - thirteen live cross
  calls. The "new facts" part of the wave block exists for this: the wave recorded the
  fact, applied the existing rule as an assumption to ratify, and went on.
- **Shared files at commit time**: the index and a shared skill carried three other
  sessions' hunks; staging by hunk kept them out, and another front's untracked prompt
  stayed out too.
- **A green suite that depended on sibling checkouts**: tests in one worktree read other
  repositories by relative path; the result was valid only for that combination, so the
  combination is part of the verified state.
- **A clean-up through junctions**: the worktree folder held junctions to real
  repositories; the resume block said "remove the junction, never delete recursively" -
  a recursive delete would have erased the repositories behind them.
