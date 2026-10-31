# Worktree per front - setup, links, combinations, adapters, release and removal

**Scope**: method

Companion of [the front-protocol skill](../SKILL.md), section 4 (T31). Neutral names:
fronts `XY` and `GR` of product *Acme Orders*; repositories `api`, `app`, `core` (a shared
library the tests of `api` read by relative path) and `db-scripts`; the live checkouts
under `<live>/`, the fronts' work under `<work>/`.

## 1. The live tree is production

Signs that a checkout is live: a watch-mode server reloads from it, a development server
there serves real users, a scheduled job or a build reads it, migrations run from it at
boot. Then:

| In the live tree | Means |
|---|---|
| saving a file | a deploy - a half-written file is a crash in front of users |
| switching the branch, `stash`, `reset` | an outage, or another session's work gone |
| running a schema change from it | a migration in production |

Rule: **the live tree is read, never written.** Every change happens in a worktree; it
reaches the live tree only by a merge released with the owner's word. Say in the front's
header which checkouts are live.

## 2. Setup

```
git -C <live>/api worktree add <work>/xy/api -b xy-wave0 main
git -C <live>/app worktree add <work>/xy/app -b xy-wave0 main
git -C <work>/xy/api rev-parse --short HEAD        # the base - recorded in the wave block
```

- **Only the repositories the front changes get a worktree**; a repository it only reads
  is reached by link or by an environment variable (section 3).
- **The same branch name in every repository** of the front, so the release plan and the
  resume block name one branch.
- **One worktree per wave session.** A parallel session of the same front runs its own wave
  in its own folder and branch (`<work>/xy-catalog/api`, branch `xy-catalog`) - two
  sessions never share a working tree.
- **Record the base** of each repository; a resume compares the tip with the recorded hash.

## 3. Links to shared config

The worktree lacks what is not versioned: installed dependencies, sibling repositories
reached by relative path, gitignored configuration. Link them into the front's folder so
that the relative layout of the main checkouts holds (`../core` must resolve from
`<work>/xy/api` as it does from `<live>/api`).

| What | Link | Risk to record |
|---|---|---|
| Dependency folder | directory link inside the worktree | an install inside the worktree writes into the live folder - install fresh when the lockfile differs |
| Sibling repository read by tests | directory link in `<work>/xy/`, named like the sibling | it points at the sibling's live checkout: a green run certifies that tip (section 5) |
| Gitignored config (`.env`) | file link, or a copy | a linked file **is** the live file - editing it edits production config; a copy drifts and may hold secrets: delete it at the save |

Commands:

| Platform | Directory link | File link | Remove the link only |
|---|---|---|---|
| Windows | `cmd /c mklink /J <link> <target>` (junction) | `cmd /c mklink /H <link> <target>` (hard link) | `cmd /c rmdir <link>` (no `/s`); a hard link: `del <link>` |
| POSIX | `ln -s <target> <link>` | `ln <target> <link>` | `rm <link>` or `unlink <link>` (no `-r`, no trailing slash) |

Every link goes into the prompt's "Outside git" list as `link -> target (kind)`, because
`git status` never shows it and a clean-up that forgets it either leaves debris or, worse,
deletes through it.

## 4. Data

- **Read-only sessions** against shared databases; prove once per session that a write is
  refused (the read-only mode is the guard, not good intentions).
- **Schema and seed changes** are proven in a disposable copy first: the expected count, a
  rerun that adds nothing, an impossible variant that fails loudly - then dropped (the
  [`disposable-proof`](../../disposable-proof/SKILL.md) skill holds the full technique).
- **Migrations that run at boot** make a merge into the live branch a migration in
  production, in every schema: the release plan says so.

## 5. Green certifies a combination of checkouts

A suite that reads other repositories is green for one exact set of checkouts. Record it
with the result:

```markdown
**Verified** (2026-03-06): 96 suites, 1480 passed, 12 skipped (live), 0 failed.
Combination: `work/xy/api` (xy-wave0 @ 9a8b7c6) + `core` at `main` 2d4e6f8 (link `work/xy/core`)
+ `app` at `work/xy/app` (via APP_DIR) + `db-scripts` at `main` 5e6f7a8.
```

- When a sibling's main moves, re-run before the release: a red that appears with no change
  in this worktree is checked against the combination first.
- A single-repository CI needs the same environment variables (or fixtures) to rebuild the
  combination; without them it certifies something else.
- A scanner over "all repositories" scans a closed set: a new repository with relevant code
  is a limit to record until it joins the set.

## 6. Parallel fronts and the adapter

Before releasing, compare what both branches touch:

```
git -C <live>/api diff --name-only main...xy-wave0 > xy.txt
git -C <live>/api diff --name-only main...gr-catalog > gr.txt
```

| Overlap | Resolution | Where it is written |
|---|---|---|
| Both append to one list (error codes, a registry) | union of both lists at merge | the release plan of the front that merges second |
| Both build a piece of the same truth (a list derived from the routes and a hand-kept list of the same pairs) | **the last front to reach main writes the adapter** - the glue that makes one truth, with its tests | a decision in one home register, cited by the other front |
| Both change the same lines with different intent | decide the order first; the second rebases and re-runs its gates on the delta | both release plans |

Example of the adapter decision (front `GR`'s register; front `XY` cites it):

> **GR#14** - At the merge of `xy-wave0` and `gr-catalog`, the pairs of the guarded modules come from
> the list front XY derives from the routes - one truth; the hand-kept list keeps only what cannot be derived. Whichever branch
> reaches `main` second writes the adapter and its test. Agreed by message between the two sessions, 2026-03-06.

## 7. Release from a worktree (only with the release word)

1. Data scripts the new code needs at boot run **before** the merge; scripts that clean
   what the old code wrote in between run again **after** it.
2. Merge server before clients when old clients survive on the new server; together when
   they do not - the plan says which, and why.
3. A merge into the live branch is a deploy: name the window, the check after (a boot log
   line, a smoke walk), and the way back.
4. The next checkpoint records the merged hashes; the front branch stays until the release
   is verified.

## 8. Removing a worktree and its links

1. **List the links** from the prompt's "Outside git" list, and check the folder for any
   not listed (`dir /AL <work>\xy` on Windows, `find <work>/xy -maxdepth 2 -type l` on POSIX).
2. **Remove each link by its pointer, never its target** (commands in section 3). Do not
   use a recursive delete on a folder that holds links: on Windows a recursive delete can
   follow a junction and empty the real directory behind it.
3. **Check every target is intact**: the live dependency folder, the sibling repositories,
   the live config file.
4. **Remove the worktree**: `git -C <live>/api worktree remove <work>/xy/api`, then
   `git -C <live>/api worktree prune`. It refuses when there are uncommitted changes; use
   `--force` only when the save says nothing there matters.
5. **Delete the branch** only after it was merged or dropped by decision.
6. **Record the clean-up** in the next save; remove the entries from "Outside git".
