# Change packaging - every file versioned, fix and tests apart

**Scope**: method

Companion of [the close-and-retain skill](../SKILL.md), step 6 - technique T78, `operating`
(one case: a multi-developer product team with a shared characterisation suite beside its
core product, on several maintained lines). The agent **prepares** every command here and a
human runs them after the release word
([prepare-only](../../change-gate/references/prepare-only.md)); adding a new file to the
local working copy is the one reversible step the agent takes itself.

## 1. Add every new file when it is created

- **git**: `git add <file>` right after the file is written (`git add -N <file>` when the
  content is not final yet: the path is tracked, the content is staged later).
- **svn**: `svn add <file>`; a file in a new folder: `svn add --parents <file>`.
- Before the hand-over, the status of **every** working copy the change touched shows no
  unversioned file of the change: `git status --porcelain` has no `??` line for it,
  `svn status` no `?`. The close script's `unversioned` check lists what is left, per
  working copy ([runtime/close](../../../runtime/close/README.md)).
- An output, log or scratch file that must never be versioned goes to the ignore list (or
  outside the working copy), so that "nothing unversioned" stays a signal.

Why: a desktop svn client's commit dialog hides unversioned files by default. In the source
case a new test file stayed unversioned, left the commit unnoticed, never reached the other
machines, and broke their build as soon as the suite's project file named it.

## 2. Two groups under the work item's name

The fix and its tests leave as **two commits, the fix first**. Each group carries the work
item's name, so a file in the wrong group shows before the commit:

| | Fix group | Tests group |
|---|---|---|
| Holds | product files: code, forms, scripts, configuration of the product | the suite's files: tests, case tables, the suite's project files, coverage lists, a promoted proposal's drafts removed |
| svn | changelist `<ID>-fix` | changelist `<ID>-tests` |
| git | the first commit on the work item's branch (`<id>`), from its staged set | the second commit on the same branch |

The **same group names on every line** the change touches, so the commit dialog of each
working copy lists the files under the same heading.

### svn

```text
svn changelist CR-123-fix   service/orders/ship.py service/orders/model.py web/shipping/ship-form.js
svn changelist CR-123-tests tests/shipping/test_partial.py tests/shipping/partial_cases.csv
svn commit --changelist CR-123-fix   -F TICKETS/CR-123/commit-fix.txt   <working copy>
svn commit --changelist CR-123-tests -F TICKETS/CR-123/commit-tests.txt <working copy>
```

- Changelists hold **versioned files only**: `svn add` comes first.
- A file is in one changelist at a time (`svn changelist --remove <file>` takes it out).
- A new folder belongs to no changelist: it goes with the commit of the files inside it.
- A commit clears the changelists of the committed files unless it keeps them
  (`--keep-changelists`).
- When the tests live in their own working copy (a separate suite repository or folder),
  each group is committed from its own working copy.

### git

```text
git switch cr-123
git add service/orders/ship.py service/orders/model.py web/shipping/ship-form.js
git commit -F TICKETS/CR-123/commit-fix.txt
git add tests/shipping/test_partial.py tests/shipping/partial_cases.csv
git commit -F TICKETS/CR-123/commit-tests.txt
```

- Stage by explicit path, never `git add -A` at the end of a change: a stray file joins the
  fix.
- `git diff --cached --name-only` before each commit shows exactly the group.
- When the suite is its own repository, its commit is made there, on a branch of the same
  name.

## 3. The order

1. **The fix**, alone.
2. Where the suite's index of tested changes records the fix revision, the **index row is
   completed** with the revision the first commit produced.
3. **The tests**.
4. **The knowledge base**: the closing record, the episodic log, the cards, the index row
   when the index lives there - its own commit, in the knowledge base's working copy.
5. The committed revisions go back to the tracker (a single-field write when the case
   sanctions it, otherwise the developer's) and to any card whose revision was pending.

Several lines: the fix group of every line the change reaches goes first, then the tests of
every line. Where the lines are folders of one svn working copy, one revision can carry the
fix of all of them; in git each line's branch gets its own pair of commits - a port is the
[`backport`](../../backport/SKILL.md) skill's, never a copy of whole files.

## 4. The prepared block

In the closing record, in execution order, in the format of
[prepare-only, section 2](../../change-gate/references/prepare-only.md#2-how-a-prepared-operation-is-handed-over):

```markdown
## Prepared - waits for the release word

| # | What | Where | Command | After |
|---|---|---|---|---|
| 1 | commit of the fix | application working copy, branch `cr-123` | `git commit -F TICKETS/CR-123/commit-fix.txt` (staged: the 3 fix files) | - |
| 2 | index row: the fix revision | knowledge base, the suite's index | fill the revision of 1 | 1 |
| 3 | commit of the tests | test-suite working copy | `svn commit --changelist CR-123-tests -F TICKETS/CR-123/commit-tests.txt .` | 2 |
| 4 | commit of the knowledge base | knowledge-base working copy | `git commit -F TICKETS/CR-123/commit-kb.txt` (staged: CLOSE.md, the log, 1 card, INDEX.md) | 3 |
```

The release word covers this list as it stood when the word was given; an item added later
waits for a new word.
