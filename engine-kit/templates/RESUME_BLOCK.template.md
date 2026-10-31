# Template: Resume block

**Scope**: method
**Used by**: [front-protocol](../skills/front-protocol/SKILL.md), section 3 (session save and resume) - written at
the end of every session, by the prompt's writer. Procedure and a worked example:
[references/save-and-resume.md](../skills/front-protocol/references/save-and-resume.md).
**Produces**: section 12 of the front prompt (or the "Resume here" part of the wave in
progress), **replacing** the previous block - plus the checkpoint commit message below.

Rules for filling it:

- **Collected, not recalled**: hashes, statuses and test counts come from commands run
  during the save; a hash typed from memory is a fiction for the next session.
- **"Not run" beats "should pass"**: a check that did not run in this session is written as
  not run, with the reason.
- **The owner reads it too**: each pending id carries a one-line reminder, so the owner can
  answer from the block without opening the file.
- **The paste-ready prompt has at most eight lines** and leaves slots for the owner's
  answers by id.
- What waits for the owner (assumptions, questions, facts requested, the release word) is listed as
  [decision-rounds](../skills/decision-rounds/SKILL.md) defines it; this block only places it. The release list
  itself lives in the closing record ([decision-rounds](../skills/decision-rounds/SKILL.md#the-release-word)); item 2
  points at it.
- **Next free ids are written `<sequence>: <number>`** (`XY: 18`), never `XY#18`: the citation check
  reads `KEY#N` as a decision that must already exist.
- **Nothing but the ids on a next-free-ids item.** The citation check leaves out the item - from the
  `**Next free ids**` label to the end of its sentence, plus a `Reserved:` sentence right after it (wrapped
  lines included; a code span or table cell holding the label ends it) - and reads the rest of the line, so
  a real citation written inside the item (`XY#7`) is never checked: put it after the item's full stop or
  on another line.

## Skeleton

````markdown
## <12 | N.9> Resume here (saved <YYYY-MM-DD>, <end of session | before a hand-off | after the release> - <owner's words, if any>)

**Where the work is** (<NOTHING committed | committed, not pushed | pushed, not merged | merged and released>):
- `<worktree path>` - branch `<branch>`, base `main` <hash>, tip <hash> (<pushed | not pushed>).
  Changed: <paths>. New: <paths>.
- `<repository>`: `<script>` <PROVEN in <disposable copy> and dropped | APPLIED to <target> on <date> with the release
  word | NOT applied>.

**Outside git**: `<link>` -> `<target>` (<junction | symlink | hard link | copy>); <disposable copies still alive | none>.

**Verified state** (<date>, at the tips above):
- `<command>` = <result>; `<command>` = <suites, passed, skipped and why, failed>.
- Not run: <check> - <why>.
- Combination: `<this worktree>` @ <hash> + `<sibling>` @ <hash> (<link | environment variable>) + ...

**What is left, in order**:
1. Owner: ratify <A-<NS>n> (<one-line reminder>); answer <Q-<NS>n> (<one-line reminder><; reserved>); give the fact
   <R-<NS>n> (<one-line reminder>). Blocks the release: <id | none>.
2. Commit, only with the release word: the list in `TICKETS/<ID>/CLOSE.md`, section 4 (the closing record - its one
   home; a draft while a gate waits), pointed at, never copied here.
3. Release: <data before the code that needs it>; <merge order>; <checks after>.
4. Clean-up: remove <links> by the pointer, never the target; check the targets; then `git worktree remove`.

**Next free ids**: <NS>: <n> · Q-<NS>: <n> · A-<NS>: <n> · R-<NS>: <n>. Reserved: <<sequence>: <from>-<to> for <session> | none>.
**Requests out**: <group> R-<n> (<open | answered -> F<n>>) | none.
**Sibling sessions**: <session> -> `<worktree>`, branch `<branch>`, owns <files or ids> | none.

**Paste-ready prompt**:

> "Resume front <NS> from section <N> of `<prompt path>`. CROSS-CUTTING: <repositories and fronts>.
> Worktrees `<paths>`, branch `<branch>`, <commit status>. First run `<commands>` and compare with the verified state.
> My answers: <A-<NS>n> <...> · <Q-<NS>n> <...> · <R-<NS>n> <...>. Next free ids: <...>.
> Rules: no commit, push or script on shared data without my release word; never edit the live checkouts;
> data read-only; <group>'s code by name only."
````

## Checkpoint commit

Stage only the front's own hunks (`git add <the front's files>`, `git add -p <shared file>`,
then read `git diff --cached`), and use one line in this shape:

```
Front <NS>: <what happened> (<ids>)<, gates <a>/<b>>; resume from section <N>
```

A second checkpoint records the hashes of code commits made after this one - a commit
cannot carry its own hash.
