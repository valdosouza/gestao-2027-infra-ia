# Session save, checkpoint commits and resume - procedure and a worked example

**Scope**: method

Companion of [the front-protocol skill](../SKILL.md), section 3 (T30). Neutral names: a
front `XY` of product *Acme Orders*, repositories `api`, `app` and `db-scripts`, the
knowledge repository `kb`. The block to fill is
[`templates/RESUME_BLOCK.template.md`](../../../templates/RESUME_BLOCK.template.md). What
waits for the owner and the release word are [`decision-rounds`](../../decision-rounds/SKILL.md)
([worked examples](../../decision-rounds/references/assumptions-and-release.md)); this
page only says where they appear in a save.

## 1. When to save

| Trigger | Why |
|---|---|
| The owner says so ("save everything, we continue later") | the session ends on purpose |
| The context is near its limit, or the session is about to compact | what is not on disk is lost |
| Before handing the front to another session or person | the next reader has only the file |
| A wave stops unfinished, or a gate fails and the rework waits | the next session must know where to start |
| After a release (commits, merge, a script applied) | the hashes and the new state must be recorded |
| At the end of every session that changed anything | default - a session that did not save did not happen |

## 2. The save, step by step

1. **Collect the facts, do not recall them.** For each repository the front touches:
   `git -C <worktree> rev-parse --short HEAD`, `git -C <worktree> status --short`,
   `git -C <worktree> log --oneline <base>..HEAD`; whether the branch is pushed
   (`git -C <worktree> status -sb`). For shared data: which scripts were proven (where)
   and which were applied (where, by whom, with which release word).
2. **List what git does not show**: links in the worktree folder, linked or copied config
   files, disposable schemas still alive, temporary copies of secrets-bearing files (they
   are deleted before the save, and the save says so).
3. **Run the cheap checks now** and record their output (typecheck; the suites the wave
   touched; the full suite when it is affordable). Record the combination of checkouts the
   run used (worktree + each sibling at its hash). "Not run" is a valid entry; "should
   pass" is not.
4. **Write what is left, in order**: owner decisions first, each with a one-line reminder;
   then commits (only with the word; a pointer to the list in `TICKETS/<ID>/CLOSE.md`,
   section 4 - never a copy); release steps (data before
   code, merge order, what to check after); clean-up (links first, then worktrees).
5. **Write the next free ids** of every sequence of the namespace, and the reserved ranges
   to skip, as `<sequence>: <number>` (`XY: 18`, `Q-XY: 50-53`) - never `XY#18`, which the
   citation check reads as a decision that does not exist yet. Check them against the home
   register, not against memory.
6. **Write the paste-ready prompt** (section 4).
7. **Replace the header's State** (at most five lines) and rewrite the front's line in the
   index of fronts.
8. **Check the size** of the prompt (60 KB); over it, move a closed wave to the annex
   first ([prompt-sections.md](prompt-sections.md), section 11).
9. **Checkpoint commit** of the front's own documents (section 3).

## 3. Checkpoint commits that stage only the front's own hunks

Shared files collect other sessions' work in progress: the index of fronts, a skill both
fronts improved, the workspace rules file. A checkpoint commits the front's lines and
nothing else.

```
git -C <kb> status --short                     # what changed, by everyone
git -C <kb> add prompts/prompt_xy.md prompts/prompt_xy-execution.md   # files that are the front's alone
git -C <kb> add -p INDEX.md                    # shared file: accept only the front's hunks
git -C <kb> diff --cached --stat               # exactly the expected files?
git -C <kb> diff --cached                      # read it: nothing from another front
git -C <kb> commit -m "Front XY: round 3 decided and executed (XY#10-XY#13), gates 0.75/0.80; resume from section 13.9"
git -C <kb> diff --stat                        # what remains is someone else's - leave it
```

- When a hunk mixes the front's line with another session's line, do not split by hand
  in the editor of the live file: write a patch with only the front's lines and stage it
  with `git apply --cached <patch>`.
- Never `git add -A`, `git add .` or `git commit -a` in a repository that more than one
  session writes.
- Another front's file stays out even when it is untracked and "obviously ready" - its
  writer commits it.
- **Rhythm** (from a case's log): one checkpoint per round decided or executed, per gate
  pass, per publication - with the hashes of what was published - and per save. A day of
  work on one front is typically three to six checkpoints; each one is a resumable point.
- **Message**: the front, what happened, the ids, the resume section. Examples:
  - `Front XY: Round 0 organized and asked (inventory, guardian opinion, waves 0-2; Q-XY1...Q-XY13)`
  - `Front XY: wave 0 executed in worktree with gates 0.75/0.80; resume from section 13.9`
  - `Front XY: wave 0 PUBLISHED - hashes recorded (api 4e5f6a7, app 8b9c0d1); next: wave 1`
  - `Save 2026-03-06: resume blocks of fronts XY and GR`
- The checkpoint follows the release word: a case that wants saves to commit without a
  separate word records that in its own register, limited to the front's documents.

## 4. The paste-ready prompt

At most eight lines, written for a session that knows nothing:

```markdown
> "Resume front XY from section 13.9 of `prompts/prompt_xy.md`. CROSS-CUTTING: api, app and front GR.
> Worktrees `work/xy/{api,app}`, branch `xy-wave0`, NOTHING committed. First run `npm run typecheck` and
> `npm test -- module-gate` in `work/xy/api` and compare with the verified state.
> My answers: A-XY5 ..., Q-XY10 ..., Q-XY11 .... Next free ids: XY: 18, A-XY: 15, Q-XY: 40 (Q-XY: 50-53 reserved
> for session GR - after Q-XY49 skip to Q-XY54).
> Rules: no commit, push or script on shared data without my release word; never edit the live checkouts;
> data read-only; the sync group's code by name only."
```

The slots "My answers: ..." let the owner answer in the same paste that resumes the
session - the answers then arrive by id, which keeps them unambiguous.

## 5. Resume, step by step

1. **Read** the header and the resume block, then the open questions. State the
   cross-cutting warning in the first message.
2. **Verify before acting**:
   - each worktree's `HEAD` equals the recorded hash, and `status` shows the recorded
     uncommitted set;
   - the listed checks give the recorded result on the recorded combination of checkouts;
   - shared state the next step depends on is unchanged (a row count, a script number not
     taken by someone else since).
   A difference is recorded as a fact in the wave block before anything else, and the
   plan is re-read in its light.
3. **Apply the owner's answers** literally, by id (decision-rounds records them; an
   answer list that repeats or skips an id is asked again for that id).
4. **Take ids** from the block's "next free ids", checked against the home register.
5. **Re-read the file before every edit**; it changes between rounds and other sessions
   may have added pointers.

## 6. A worked save

```markdown
## 13.9 Resume here (saved 2026-03-06, end of session - owner: "save everything")

**Where the work is** (NOTHING committed; both worktrees stay on disk until the release word):
- `work/xy/api` - branch `xy-wave0`, base `main` 3c1d2e0. Changed: `src/server.ts`, `src/shared/errors/codes.ts`
  (3 codes), `src/modules/users/*`. New: `src/shared/auth/module-gate.ts`, `src/__tests__/module-gate.test.ts`.
- `work/xy/app` - branch `xy-wave0`, base `main` 7b9a415. Changed: `src/forms/form-page.ts` only.
- `db-scripts`: `013_tenant_links.sql` PROVEN in a disposable schema (dropped after); NOT applied anywhere.

**Outside git**: in `work/xy/` the links `node_modules` and `shared-core` (to the sibling repositories); inside
`work/xy/api` the `.env`, a linked file of the live one (read-only use).

**Verified state** (2026-03-06, at the tips above): typecheck clean; `npm test` = 96 suites, 1480 passed, 12 skipped
(the live ones), 0 failed. Combination: `work/xy/api` + `shared-core` at `main` 2d4e6f8 + `app` at `work/xy/app`.

**What is left, in order**:
1. Owner: ratify A-XY5 (each screen reads its own lookup list - reproduces today's rows) and A-XY6; answer Q-XY10
   (item edits on an open order = UPDATE?) and Q-XY11 (blocks the release: the licence check in CRUD hides two
   screens from the operator's admins).
2. Commit, only with the release word: the list in `TICKETS/XY-W0/CLOSE.md`, section 4 (both worktrees, its paths only) - pointed at, never copied here.
3. Release: script 013 before the app; api and app together; regenerate the error catalog.
4. Clean-up: remove the links `work/xy/node_modules`, `work/xy/shared-core` and `work/xy/api/.env` (pointer, never
   the target), check the targets, then `git worktree remove`.

**Next free ids**: XY: 18 · A-XY: 15 · Q-XY: 40. Reserved: Q-XY: 50-53 for session GR.
**Sibling sessions**: front GR in `work/gr/api` (branch `gr-catalog`) - owns `catalog.ts`; adapter rule XY#14.

**Paste-ready prompt**: (section 4 above)
```

## 7. What a save is not

- **Not a diary.** The block says where things are and what is next; what happened is in
  the wave block and the commits.
- **Not appended to.** A new save replaces the resume block of the wave (an older block of
  a closed wave moves to the annex with it).
- **Not optimistic.** "Tests pass" without the run, "nothing pending" with open
  assumptions, or a hash typed from memory make the next session start from a fiction.
