# Apply, validate, prepare the commits

**Scope**: method

Companion of [the backport skill](../SKILL.md), steps 3, 4, 6 and 7. Same fictional
values as [the comparison folder](comparison-folder.md). Writes happen only in the target
working copy, after the owner's go; the base working copy is never written.

## Comparing files

| Check | Plain files (svn, or any tool) | Working files of a git repository |
|---|---|---|
| Two files byte-identical | `cmp a b` (bash), `fc /b a b` (cmd), or equal `Get-FileHash` values (PowerShell) | `git hash-object --path=<path> <file>` equals `git rev-parse <commit>:<path>` - both sides pass through the repository's own line-ending rules |
| Same content, line endings aside (diagnosis only) | `diff --strip-trailing-cr a b` | `git diff --no-index --ignore-cr-at-eol a b` |

The line-ending-insensitive comparison is a diagnosis, never a pass: a file that differs
only in line endings is redone, not accepted.

## Apply, by kind

| Kind | svn working copy | git worktree |
|---|---|---|
| new file | copy `after/<path>` to the target path; the add is prepared (`svn add`) | copy `after/<path>`; the add is prepared (`git add`) |
| revert | nothing to apply: confirm that the target file equals `after` | same, through the blob ids |
| advance | copy `after/<path>` over the target file | same, then check through the blob ids |
| isolated diff | `svn patch --dry-run diff/<path>.diff <the file's folder in the target working copy>` (a diff of one file's URL names the file alone), then without `--dry-run` | `git apply --check diff/<path>.diff` then `git apply diff/<path>.diff`, run at the worktree root (`-p` / `--directory` when the layouts differ) |

- **No fuzzy or three-way apply**: no `--3way`, no fuzz factor, no `--reject` left behind.
  A hunk that does not apply exactly is a **stop** - the owner decides, with the hunk shown.
- The apply runs file by file, from that file's own diff, so an excluded file can never
  ride along with the others.
- After a validated apply, copy the target file to `<revision>/result/<path>`.

## The hunk check (isolated diff)

When the target diverged, compare the change made with the change wanted:

1. Diff `source` -> target with zero context: `git diff --no-index -U0 <source> <target>`
   (any tool that prints `-`/`+` lines works the same way).
2. Diff `before` -> `after` of the revision the same way: `git diff --no-index -U0 before/<path> after/<path>`.
3. Drop the file headers (`diff --git`, `index`, `---`, `+++`) and the hunk headers (`@@ ... @@`)
   from both.
4. **Pass** when what remains is identical: the same removed and added lines, in the same
   order. Then the line endings and the encoding of the target equal those of `source`.

Anything else fails: a missing hunk (partial apply), an extra line (a hunk landed twice or
at the wrong place), a line in a different section with the same text (the same count of
lines, different bytes - the classic partial-apply smell).

## End-of-backport check

For each file of the final-revision map:

| The file | Check | Pass |
|---|---|---|
| never diverged from the matching line | target against `after` of its last revision | byte-identical |
| diverged | the diff base -> target, headers dropped, against the revisions' isolated diffs on it, concatenated in order, reverts applied | identical lines |
| reverted in the end | target against the base | byte-identical |

Then the change set itself: `svn status` / `git status --short` of the target working
copy lists only manifest paths (and the prepared adds); no excluded path appears.

## Pitfalls (real)

| Pitfall | Symptom | Do |
|---|---|---|
| A whole file copied from the trunk or main | a one-line fix shows dozens of differences against the base | the matching line's isolated diff |
| A patch tool normalised line endings | the byte check fails; the line-ending-insensitive diff is clean | advance when `source` = `before`; otherwise redo the apply with a tool that keeps them, and check again |
| A hunk applied partially or at the wrong place | an import or declaration left in the wrong section; same line count, other bytes | the hunk check; redo |
| A non-ASCII character in a hunk (a typographic dash in a comment) | the patch tool refuses the hunk | advance when `source` = `before`; otherwise a tool that reads the file's encoding - never retype the characters |
| A later revision applied from the base | an earlier revision's change on the same file disappears | the file registry: cumulative from the target working copy |
| A revert flagged as wrong | `before` and `after` differ a lot, the target does not change | correct: the target already equals `after` |
| Files copied from the base that no revision lists | the change set holds untested files | only manifest paths; the end check |
| Redirected output re-encoded by the shell | exported files differ from the repository in every byte | export commands, or a byte-exact redirect ([comparison folder](comparison-folder.md#byte-exact-export)) |

## Prepared commits

The agent prints these; a human runs them, after the build and the suite on the target
line and after the owner's release word. Default: **one commit per carried revision, in
order**, with an explicit file list and a message that names the source revision.

**Files that more than one revision touched.** The working copy holds their final state,
so a per-revision commit has to restore each revision's state first: before the commit of
revision N, copy `<N>/result/<path>` over the target file for every registry file of N. At
the last commit the working copy is back to the final, validated state. When the owner
prefers, the backport goes as **one commit** whose message lists every revision it carries.

svn:

```
svn status <target-wc>
svn diff <target-wc>/src/orders/Totals.src <target-wc>/src/orders/Lines.src
svn add <target-wc>/src/orders/Rounding.src
svn commit <target-wc>/src/orders/Totals.src <target-wc>/src/orders/Lines.src <target-wc>/src/orders/Rounding.src -m "Backport r4120 from branches/2.x: <first line of its message>"
```

git (in the target worktree):

```
git status --short
git diff -- src/orders/Totals.src src/orders/Lines.src
git add -- src/orders/Rounding.src
git commit -m "Backport a1b2c3d from release/2.x: <first line of its message>" -m "(backported from commit a1b2c3d)" -- src/orders/Totals.src src/orders/Lines.src src/orders/Rounding.src
```

Never prepared: a commit of the whole working copy, a VCS merge of the source line, a
push or a tag - those belong to the owner's release process. A prepared deletion or move
is listed with its own command and runs with the commit of its revision.
