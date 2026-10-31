---
name: backport
description: Use when revisions already committed on one line (a development branch, trunk or main) must be carried to another maintained line (a release, a hotfix, a client line) and nothing else may come with them - one comparison folder per revision, the isolated diff taken from the line the target descends from, a fixed apply order (new files, reverts, advances, isolated diff), each file validated before the next, never a whole file copied across lines. git or svn; commits and merges are prepared for a human.
---

# Skill: Backport (an isolated diff per revision, validated file by file)

**Scope**: method
**Maturity**: candidate

Ran in one case, under svn, prepare-only from end to end; optional: only a project that
maintains more than one line of the same code needs it.

**When to use**: a hotfix line needs a fix that was committed on the development line; a
client line or an older release needs selected revisions; "port r4120 and r4135 to the
2.1 hotfix", "carry these two commits to release/2.1", "why does the backported file
differ from the source?". Also to check a backport someone else made.
**Not for**: merging a whole line (a VCS merge the owner decides and a human runs);
creating the target line or cutting the release (commands prepared inside the owner's
release process); choosing which revisions go in (the owner -
[`decision-rounds`](../decision-rounds/SKILL.md)); the build and the suite of the target
line, which this skill hands to the [`build-analyst`](../../agents/build-analyst.md) and to
[`test-gate`](../test-gate/SKILL.md).
**Real origin**: case two - a multi-developer product team shipping hotfix lines of a core
product with several maintained version lines, under svn. The rules below are the
corrections of its first hotfix runs: a file copied whole from the trunk instead of the
version line turned a one-line fix into dozens of false differences; a patch tool
normalised line endings and applied a hunk partially (an import left in the wrong
section); a later revision applied from the base dropped an earlier revision's change to
the same file; files that no revision listed were copied in from the base. Its end gate
checks every backported file against its source revision, with all of them as the target.
**Parts**: T79 `candidate` - one case, optional ([maturity](../../docs/MATURITY.md),
[register](../../docs/TECHNIQUES.md)).
**Works with**: [`change-gate`](../change-gate/SKILL.md) (the plan artifact, the go,
prepare-only), the [`build-analyst`](../../agents/build-analyst.md) agent,
[`test-gate`](../test-gate/SKILL.md), [`decision-rounds`](../decision-rounds/SKILL.md)
(the revision list and every blocker are the owner's),
[`retain-knowledge`](../retain-knowledge/SKILL.md).
**Detail**: [references/comparison-folder.md](references/comparison-folder.md) (layout,
git and svn commands, manifest, session file) and
[references/apply-and-validate.md](references/apply-and-validate.md) (the apply commands,
the per-file and end checks, pitfalls, prepared commits).
**Changelog**: 2026-10-21 - first version (wave 2), from case two's hotfix backports.

---

## The principle

The target line must receive exactly the selected revisions - nothing the source line
accumulated before them or between them. So each revision is reduced to its **isolated
diff** (its own change, N-1 -> N, on the line the target descends from), applied to the
target file's current state, and **each file is validated before the next one is
touched**. A file copied whole from another line brings every change that line has and
the target never received.

| Term | Meaning |
|---|---|
| Source line | where the revisions were committed: a version line, the trunk or main, a development branch |
| Matching line | of the lines a revision touched, the one the target descends from - where the isolated diff is taken |
| Target line | where the revisions land: a hotfix, a release, a client line |
| Base | the target line's state before this backport: a clean working copy that is never written, or a fixed revision of the target line |
| Target working copy | a separate working copy (or git worktree) of the target line where the files are written - never the base |
| Revision | an svn revision or a git commit |
| `before` / `after` | the file at N-1 and at N on the matching line |
| `source` of a file | what the next apply starts from: the target working copy's file when an earlier revision of this backport touched it, else the base file |

## Inputs

| Input | Example (fictional) | If missing |
|---|---|---|
| Revisions | r4120, r4135 (svn); `a1b2c3d`, `e4f5a6b` (git) | ask; never "everything since" |
| Target line and its base | `hotfix/2.1.7-1`, cut from release 2.1.7 | ask; creating the line is prepared for a human |
| Target working copy | a second working copy or worktree of the target line, clean | its checkout is prepared for a human |
| Comparison root | a folder outside every working copy | the case's notes; ask |
| Exclusions | project metadata the IDE regenerates, the line's version constant | the case's notes; ask - every exclusion is listed per revision |
| The owner of the backport | who approves the list and runs the commits | ask |

## The sequence

| Step | What | Output | Stops when |
|---|---|---|---|
| 0 | [Order the revisions](#0-order) | the order, in the session file | - |
| 1 | [Comparison folder per revision](#1-the-comparison-folder-read-only) (read-only) | `before/`, `after/`, `diff/`, log, manifest | a revision touched no matching line |
| 2 | [The plan and the go](#2-the-plan-and-the-go) | the plan artifact | always: it waits for the owner's go |
| 3 | [Apply, file by file, in the fixed order](#3-apply---the-fixed-order) | the target working copy | a hunk does not apply: a blocker |
| 4 | [Validate each file before the next](#4-validate-each-file-before-the-next) | the manifest's validation column | a file fails: diagnose before the next |
| 5 | [The file registry](#5-the-file-registry) | the session file | - |
| 6 | [End-of-backport validation](#6-end-of-backport-validation) | the pass count (target: all) | a file fails |
| 7 | [Hand-offs](#7-hand-offs) | build, suite, prepared commits | - |

### 0. Order

svn: ascending revision numbers. git: the order of the source line's history (oldest
first), never the order in which the commits were named. Record the order in the session
file; every later step follows it.

### 1. The comparison folder (read-only)

One folder per revision, outside every working copy, built with read-only VCS commands:

```
<comparison-root>/<revision>/
  manifest.md        the revision, its matching line, every file with its kind and its validation
  log.txt            the revision's log with its changed paths
  diff/<path>.diff   the isolated diff of each file, taken from the matching line
  before/<path>      each file at N-1 on the matching line (absent for a file the revision adds)
  after/<path>       each file at N on the matching line (absent for a file it deletes)
  result/<path>      the target file after this revision, once validated (written in step 4)
```

- **The matching line.** When a revision touched the same file on several lines (svn:
  several branch paths in one commit; git: the same fix as different commits on different
  branches), take the path - or the commit - of the line the target descends from. Never
  the trunk or main by default: their copy of the file has drifted away from an older
  line's, and a one-line fix turns into dozens of false differences.
- **Exclusions** are not exported, applied or committed; each is listed in the manifest
  with its reason, never silently dropped.
- `before` against `after` is the audit of the revision on its own line; it says nothing
  yet about the target.

Commands, the manifest template and the session file:
[references/comparison-folder.md](references/comparison-folder.md).

### 2. The plan and the go

The backport is a change, gated like one ([`change-gate`](../change-gate/SKILL.md), plan
mode). Before anything is written in the target working copy, the owner sees: the
revisions in order, the matching line of each, every file with its expected kind (new,
revert, advance, isolated diff), the exclusions, the files touched by more than one
revision, and the **Test plan** - which tests come with the revisions and where the suite
runs. The go is logged like any go. The base working copy is never written, before or
after the go.

### 3. Apply - the fixed order

For each file of the revision that is not excluded, the **first** condition that holds
decides:

| # | Condition | Action | Kind |
|---|---|---|---|
| 1 | `source` does not exist (the revision adds the file) | copy `after` -> target | new file |
| 2 | `source` already equals `after` | nothing to apply: the target keeps `source` | revert |
| 3 | `source` equals `before` | copy `after` -> target | advance |
| 4 | otherwise | apply the file's isolated diff to `source` | isolated diff |
| 5 | the diff does not apply cleanly | **stop**: a blocker for the owner, with the hunk that failed | stop |

- **Why this order.** New and revert are decided by identity, with nothing patched. An
  advance copies the exact bytes the revision produced - line endings and encoding
  included - and it is provably this revision's change alone, because the target held
  exactly `before`. The isolated diff is used only where the target diverged; it is the one
  place a tool can apply partially, so its validation is the strictest.
- **Revert** covers the common surprise: the source line reverted a change the target never
  received, so `before` and `after` differ while the target already equals `after`. The
  target keeps its file; a large `before`/`after` difference with no change in the target
  is correct. (A revision that undoes a change this backport carried earlier is not this
  case: the target then equals `before`, and the advance carries the undo.)
- A file the revision **deletes or renames**: the VCS delete or move is prepared for the
  human and listed in the manifest - never run.
- **Never**: copy `after` when `source` differs from `before` (it imports the matching
  line's drift); take `after` from a line other than the matching one; start a later
  revision from the base when an earlier revision of this backport already touched the
  file (it drops the earlier change); edit a failing hunk into place without the owner;
  run a VCS merge or a committing cherry-pick (they are the human's, and they write merge
  records the owner decides about).

### 4. Validate each file before the next

| Kind | Check | Pass |
|---|---|---|
| new file, advance, revert | target against `after` | byte-identical |
| isolated diff | the diff `source` -> target against the revision's diff of that file | the same removed and added lines in the same order (line offsets aside); no other line changed; line endings and encoding as in `source` |
| every kind, cumulative file | the earlier revisions' hunks on this file | still present |

When the target never diverged from the matching line on a file, every check reduces to
byte equality with `after` - the common case, and the one the source case's end gate was
written for. When it diverged, equality with `after` is impossible by design: it
would mean importing the divergence. A failing file stops the backport there: diagnose
(line endings, a partial hunk, the wrong matching line), redo it by the right method,
validate again, and only then the next file. A validated file is copied to the revision's
`result/` folder. Commands and the hunk comparison:
[references/apply-and-validate.md](references/apply-and-validate.md).

### 5. The file registry

A table in the session file, one row per file touched by more than one revision: its
revisions in order, its current state ("base + r4120 + r4135", or "base: r4135 reverted
r4120"), and notes. Read it **before each revision**: a file in the registry starts from
the target working copy (cumulative), never again from the base.

### 6. End-of-backport validation

After the last revision:

1. **Final-revision map**: each file -> the last revision that touched it.
2. **Each file in the target's change set**: never diverged -> byte-identical to `after`
   of its last revision; diverged -> the diff base -> target equals the revisions'
   isolated diffs on it, in order, reverts applied.
3. **Nothing spurious**: every changed path in the target working copy appears in some
   manifest, and no excluded file is in the change set.
4. **The pass count** in the session file - the target is all of them. A second run of the
   same backport can be compared with the first, file by file (identical, line endings
   only, content, only in one run).

### 7. Hand-offs

| To | What it receives | What comes back |
|---|---|---|
| The [`build-analyst`](../../agents/build-analyst.md) | the target line's registered build; before = the base revision, after = the target working copy | the verdict; new risky items attributed to the carried revisions |
| [`test-gate`](../test-gate/SKILL.md) | the target line, the revisions carried, the tests that came with them; a test that cannot come (the target has no suite, or lacks the fixture) is an `exempt:` or `not run here:` line | the suite gate on the target line, against that line's baseline; the evidence file |
| [`change-gate`](../change-gate/SKILL.md), prepare-only | after both gates: the exact commands - status, diff, add of new files, prepared deletions and moves, one commit per revision with an explicit file list and a message naming the source revision | a human runs them, after the release word |

One commit per carried revision is the default ("Backport r4120 from the 2.x line:
<first line of its message>"); one commit for the whole backport only when the owner asks.
A file that several revisions touched holds its final state in the working copy, so the
prepared per-revision commits first restore its state after each revision (from
`result/`); at the last commit the working copy is back to the validated final state.
Never a commit of the whole working copy. Prepared commands for git and svn:
[references/apply-and-validate.md](references/apply-and-validate.md#prepared-commits).

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| A whole file copied from the trunk or main | brings every change the target never got | the isolated diff from the matching line |
| `after` copied when the target had diverged | imports the matching line's drift | advance only when `source` equals `before` |
| A later revision applied from the base | the earlier revision's change on that file is lost | the file registry; cumulative from the target working copy |
| A patch tool trusted without checking | line endings normalised, hunks applied partially or in the wrong place | validate each file before the next |
| A revert "fixed" because `before` and `after` differ | the target was already right | revert = the target already equals `after`: nothing to apply |
| Files copied in that no revision lists | the hotfix carries untested content | only manifest paths; the end check for spurious files |
| A failing hunk edited into place by the agent | an untested hand merge in a release | stop; the owner decides |
| Committing or merging to save time | the irreversible step skipped the owner | prepared commands; a human runs them |

## Checklist before the hand-offs

- [ ] Revisions in source order; the order recorded.
- [ ] A comparison folder per revision, from the matching line; exclusions listed.
- [ ] The plan and its Test plan approved; the go logged.
- [ ] Every file applied by the first condition that held; no whole-file copy across lines.
- [ ] Every file validated before the next; the registry kept for multi-revision files.
- [ ] End validation: every file passes, nothing spurious, the count recorded.
- [ ] Build and suite handed off on the target line; the commits prepared, never run.
