# Testing tools - suite runs, baseline-diff gate, commit door and commit watcher

**Scope**: method

The kit's tools for the [`test-gate`](../../skills/test-gate/SKILL.md) skill: run a line's
suite and refuse evidence that does not add up (T76), split every failure against a
per-machine baseline into **new** and **pre-existing** (T38, contract:
[baseline-diff.md](../../skills/test-gate/references/baseline-diff.md)), warn at commit
time, and watch the line's revisions: a fix that lands without tests gets, after a grace
period, a headless agent's **proposal** - a report and draft tests - that a human then
promotes or rejects (T75). Python 3.8+, standard library only. The suite's command,
framework and result format are configuration; nothing here knows a language or a case.

What the tools write: per-machine state outside the working copy, and **one repository
write, the claim, only with `--claim`**. They never update, revert or commit the working
copy; publishing a proposal and promoting it are a human's commits. Every door ships
**warn-only** ([EK#6](../../DECISIONS.md)).

## Files

| File | What it is | Technique |
|---|---|---|
| [`suite.py`](suite.py) | The command line: configuration, `run`, `baseline`, `precommit`, `classify`, `decide`, `watch`, `claims`, `proposal`; the watcher itself (class `Watch`) and the index of tested changes | T38, T75 |
| [`runner.py`](runner.py) | Runs the suite's parts under one lock and reads their results (JUnit XML, or regular expressions over the output); evidence checks: tests found, counts that add up, a declared count, fresh results, exit code against counts, unnamed failures, reconcile, red by an assertion; statuses and exit codes | T76, T38 |
| [`baseline.py`](baseline.py) | The baseline record (refusals, red since, a part not run keeps its old failures), the comparison, its printed lines and the gate's exit code | T38 |
| [`decide.py`](decide.py) | Pure rules, no I/O: classify a revision by its paths, the grace deadline in working days, the decision table below | T75 |
| [`claims.py`](claims.py) | First claim wins through a VCS conflict: an orphan branch pushed without force (git), a commit into a claims folder (svn); reading, listing, staging, the publish commands | T75 |
| [`proposal.py`](proposal.py) | The proposal folder: the report's sections, what may be in the folder, the machine-path check of drafts, the brief, attempts moved aside, the agent's permission file | T75 |
| [`vcsops.py`](vcsops.py) | Read-only git and svn adapter: working-copy state (local changes, mixed revisions), revision facts and paths, revisions after / between, the diff, the head check | - |
| [`watch.prompt.md`](watch.prompt.md) | The proposal agent's brief, filled per revision (`{KEY}` placeholders) | T75 |
| [`testing.example.json`](testing.example.json) | The configuration, filled with a fictional product (two parts, line 2.1) | - |
| [`tests/`](tests/) | `python -m unittest discover -s tests` from this folder: fakes for the suite and the agent, throwaway git and svn repositories | - |

## Commands

```text
python suite.py --config <testing.json> [--me USER] [--state-dir DIR] <command> ...
  run [--out F] [--log F] [--expect-red TEST]... [--before N|PART=N] [--added ..] [--replaced ..]
  baseline record [--result suite.json] [--source NAME]
  baseline compare [--result suite.json] [--json]
  baseline show
  precommit [--paths P ...] [--for REV ...] [--warn-only]
  classify (--rev R | --paths P ...)
  decide --rev R [--now ISO] [--json]
  watch (--rev R | --poll) [--claim] [--dry-run] [--now ISO]
  claims [--now ISO]
  proposal check --rev R [--dir D]
```

| Command | What it does | Exit codes |
|---|---|---|
| `run` | The suite gate's run: every part under the line's lock, evidence checks, `suite.json` and the logs (default `<stateDir>/runs/<stamp>/`), then the split against the baseline and the `summary:` line last. **Never records the baseline** (its run includes the change). `--expect-red`: each named test must fail by an assertion (red first, T76). `--before/--added/--replaced`: reconcile, the total or per part (`back=1185`) | `0` passed; red: **the runner's own non-zero code** (`1` when it gave `0` or a reserved code); `75` busy, `76` missing here, `77` no suite, `78` not run here, `79` invalid run; with `--expect-red`: `0` every test red by an assertion, else `1` |
| `baseline record` | Records the result of a run now (or `--result`) when the record rules hold; `--source` names who records (`manual` by default; the watcher writes `watcher`) | `0` recorded, `1` refused (every reason printed) |
| `baseline compare` | The split of a run now (or `--result`) against the baseline, the verdict and the summary; `--json` prints the comparison only | warn: always `0`. block: `1` new failures or an invalid run, `75` busy, `76` missing here, else `0` |
| `baseline show` | The record: line, revision, status, source, each failing test with its red-since text | `0` |
| `precommit` | The commit door. Classifies the committed paths (default: the local changes) and warns: fix and tests in one commit; a fix without tests (or its tests still pending in the working copy); a fixture (`paths.fixtures`) without a row in the index of tested changes; a test that reads a fixed machine path; with `--for REV`, someone else's claim on that revision. In `block` mode it then runs the suite and gates like `compare` | warn: always `0`, the suite is not run. block: as `compare` |
| `classify` | A revision's (or the given paths') kind: `fix`, `tests`, `mixed`, `untestable` | `0`; `1` revision not in this working copy |
| `decide` | The watcher's decision for one revision, no action (`--now` judges the grace period) | `0`; `1` revision not here |
| `watch --rev R` / `--poll` | Acts on one revision, or on the revisions after the last poll plus the queue (`deferred` until the grace ends, `retry` after a failure, `needs-claim` until a run with `--claim`). The first poll only sets the cursor (no backfill). `--dry-run`: decides and writes the brief; no suite, claim, agent or state | `0`; `1` (poll) some revision failed and is queued for retry; `75` another watch of the line holds its lock |
| `claims` | Every claim of the claims area; `STALE` when a claim has no report after `staleClaimDays` | `0` |
| `proposal check` | Checks a proposal folder (default `<stateDir>/work/<key>/proposal`) as the watcher does | `0` accepted, `1` not |

Every command: `2` on a configuration or VCS error (`baseline show` also on an unreadable
baseline, which the other commands read as none, with a note). The reserved codes
`75`-`79` are never a suite result: a red runner that itself exits with one of them is
reported as `1`; a runner whose own "busy" or "cannot run here" codes differ maps them
with `exitCodes`.

## Configuration - `testing.json`

One file per suite and line, versioned by the case (start from
[`testing.example.json`](testing.example.json)). Relative paths are relative to the file,
except where the table says the working copy. Keys starting with `_` are notes.
`<stateDir>/local.json` (same shape) overrides it per machine; `--me` and `--state-dir`
win over both.

| Key | Default | Meaning |
|---|---|---|
| `line` | `suite.name` | The line (branch) this file covers. Recorded in the baseline; a baseline of another line is ignored |
| `workingCopy` | `.` | The line's working copy |
| `vcs` | `auto` | `git`, `svn`, or `auto` (the nearest `.git` / `.svn` above the working copy) |
| `me` | empty | This machine's VCS user: own revisions, own claims. Per machine (`local.json` or `--me`) |
| `machine` | host name | Written in claims; a claim is "mine" when claimer **and** machine match |
| `stateDir` | `~/.engine-kit/testing/<suite>-<line>` | Per-machine state of the line, **refused inside the working copy** |
| `suite.name` | `suite` | The suite's name |
| `suite.command` | - | A list of arguments (`{wc}` = the working copy), or one string with `shell: true` |
| `suite.cwd` / `env` / `timeoutSec` | `.` (working copy) / `{}` / `1800` | Where it runs, extra variables (`$VAR` / `%VAR%` expanded), the timeout (the whole process tree is stopped) |
| `suite.requires` | `[]` | Programs that must be on PATH; one missing: **not run here**, nothing started |
| `suite.results` | `{format: junit}` | `format` `junit` (`path`: a file or glob of JUnit XML, relative to `cwd`; test id `classname.name`) or `regex` (`regex`: patterns for `found`, `passed`, `failed`, `errors`, `skipped`, `failing`, `erroring` over the log, or over `path`); `checkDeclared` (true): the file's own `tests=` count must match |
| `suite.exitCodes` | `{busy: [], notRunHere: []}` | The runner's own codes for "another build holds it" and "cannot run on this machine" |
| `suite.parts` | `[]` (one part, the suite itself) | Several runners: each `{name, ...}` with any of `command`, `shell`, `cwd`, `env`, `timeoutSec`, `requires`, `results`, `exitCodes`; what a part omits comes from the suite level |
| `suite.busyWaitSec` | `300` | How long a run waits for the line's lock before answering busy |
| `suite.marker` | empty (no check) | A path in the working copy that proves the suite is here. Missing: the head of the line is asked (below) |
| `suite.headRef` | the branch's upstream | git: the ref that is the line's head for that check, as last fetched; svn always asks the server at HEAD |
| `paths.tests` / `untestable` / `fixtures` | `[]` | Regular expressions over paths relative to the working copy (forward slashes). A test path wins over an untestable one; everything else is code. `fixtures`: test files that need a row in the index |
| `index.file` | empty | The suite's **index of tested changes**, relative to the working copy: any line naming a revision (`r<N>`, or 7-40 hex characters of a commit) is a row; its other tokens with `/` or `.` are test files; markdown tables work; a line starting with `#` and a trailing ` # comment` are not rows. A revision with a row is covered (a rejected proposal gets a row too, with its reason) |
| `baseline.ignoreUnversioned` | `false` | Unversioned files make the copy dirty unless this is true (ignored files never count) |
| `gate.mode` | `warn` | `block` only after a numbered project decision ([EK#6](../../DECISIONS.md)) |
| `watch.ref` | `HEAD` | Where new revisions are read (git; for example `origin/main` with `fetchRemote`). svn reads the line URL |
| `watch.fetchRemote` | empty | git: fetch this remote before each poll |
| `watch.graceWorkingDays` / `weekendDays` | `1` / `[5, 6]` | Grace for another author's fix, in working days (`weekday()` numbers, Monday 0) |
| `watch.drafting` | `false` | This machine claims and runs the agent. Per machine; needs `agent.command` |
| `watch.maxDiffLines` | `3000` | Above it the brief says oversize: report only, no draft |
| `watch.retryMinutes` / `blockedRetryMinutes` | `30` / `60` | Retry after a failure / after the agent reported no access or quota |
| `watch.staleClaimDays` | `7` | `claims` flags an open claim older than this |
| `watch.suiteDocs` | `[]` | The suite's conventions and backlog, named in the brief |
| `watch.promptFile` | `watch.prompt.md` here | Another brief, same placeholders |
| `claim.git` | `{remote: origin, branch: test-claims}` | The claims branch on that remote (a URL or a remote name of the working copy) |
| `claim.svn.url` | empty | The claims folder URL; `^/` is resolved against the repository root |
| `agent.command` | `[]` | The headless agent; placeholders `{prompt}`, `{proposal}`, `{bundle}`, `{rev}`, `{agent_settings}`. It runs **in the proposal folder** |
| `agent.stdin` / `timeoutSec` | `false` / `2400` | The brief on stdin; the timeout |
| `agent.blockedPattern` | access and quota phrases | Its output matching this means "no access": retried after `blockedRetryMinutes` |
| `proposal.draftPattern` | `<name>.draft.<ext>` | File names a draft may have (never `.md`) |
| `proposal.forbidden` | a drive letter, a home folder | Patterns of fixed machine paths a draft or a test must not read |

## A run, its statuses and the stale check

| Status | A result? | When | `summary:` word, exit |
|---|---|---|---|
| `passed` | yes | tests found, none failed | `OK`, `0` |
| `failed` | yes | at least one failed or errored | `FAILED`, the runner's code |
| `error` | **no: an invalid run** | timeout, command not found, no or stale results, zero tests, counts that do not add up, declared count differs, reconcile mismatch, non-zero exit with no failing test | `ERROR`, `79` |
| `busy` | no | the line's lock stayed held for `busyWaitSec`, or the runner said busy | `BUSY`, `75` |
| `missing-here` | no | the marker is not here and the head of the line has it (or nothing can tell) | `MISSING-HERE`, `76` |
| `no-suite` | no | the marker is neither here nor at the head of the line | `NO-SUITE`, `77` (the gate writes `skip:`) |
| `not-run-here` | no, never a failure | a required program is missing, or the runner's "cannot run here" code | `NOT-RUN-HERE`, `78` |

With parts: busy wins, then an invalid part; all parts not run here -> not run here;
otherwise the parts that ran decide, the run is `partial` and each missing part prints
`<part> not run here: <reason>` with the other parts' counts in the summary. **One lock per
line** (`<stateDir>/suite.lock`, an OS lock released when the process dies): the suite
gate, the commit door and the watcher share it; a run started outside the tools (by hand,
from an IDE) can still collide - rerun before blaming the code.

**Stale check.** A working copy without the suite is never read as "no suite" on its own
word: git asks `suite.headRef` (fetch first, or let the watcher's `fetchRemote` do it),
svn asks the server. Only a head without the marker is `no-suite`.

## The baseline

Per machine and per line, `<stateDir>/baseline.json`, written atomically and under no lock
(the last complete snapshot wins):

```json
{
  "version": 2, "suite": "orders", "line": "2.1", "vcs": "svn",
  "revision": "120", "commit": {"id": "118", "author": "P"},
  "time": "2026-10-21T08:59:00+00:00", "recordedAt": "2026-10-21T09:00:02+00:00",
  "source": "watcher", "status": "FAILED", "found": 1186,
  "parts": {"back": {"status": "FAILED", "found": 1001}, "front": {"status": "OK", "found": 185}},
  "failing": {
    "Totals.TaxTest.rounding": {"part": "back", "since": {"revision": "97", "author": "P"},
                                "seen": {"revision": "100", "source": "watcher", "time": "..."}},
    "Cart.CartTest.empty": {"part": "front", "since": null, "notRedAt": "95",
                            "seen": {"revision": "100", "source": "watcher", "time": "..."}}
  }
}
```

`revision` is the tree the run used (svn `BASE`, git `HEAD`); `commit` is the newest
commit it reflects. `status` is `OK` or `FAILED`. **Recorded only** from a result (passed
or failed) of a clean working copy - no local change, unversioned files included unless
`ignoreUnversioned`, no svn mixed-revision or switched tree, a readable revision - that is
still clean and at that revision when the record is written; by the watcher, or by hand
with `baseline record`; never by `run` or `precommit`. **Red since**: a failure new against
the previous record gets `since` = this commit and its author only when the previous
record's commit is its direct predecessor on the line; otherwise `seen` names the baseline
run that first saw it and `notRedAt` the last record where it was not failing. A part that
did not run here keeps its failures from the previous record. Deleting the file only makes
every failure count as new until the next clean run.

**Compare** prints, before the summary:

```text
baseline: 2.1 at r120, FAILED, recorded by watcher (run ended 2026-10-21 08:59)
front not run here: node not on PATH (nothing run)
pre-existing: Totals.TaxTest.rounding (red since r97, P)
new: Totals.InvoiceTest.discount
WARN 1 new failure(s): stop - the owner decides (regression, or intended with the go recorded)
verdict: new-failures
summary: 2.1 FAILED 999/1001 (back FAILED 999/1001, front NOT-RUN-HERE 0/0) exit 1
```

No baseline: `baseline: none on this machine (every failure counts as new)`. Unnamed
failures: `new: <n> failure(s) without a name`. A pre-existing failure without a known
start: `(red in the baseline run at r100, watcher, 2026-10-21 08:59; not red at r95)`. A
baseline failure absent from this run is `no longer failing:` (the results list every test
and it passed, or they list failing tests only) or `not run in this run (not a failure):`
(its part did not run, or the results list every test and it is not among them).
Verdicts: `clean`, `pre-existing-only` (passes with `WARN already red, nothing new`),
`new-failures`, `invalid-run`, and the non-results `busy`, `missing-here`, `no-suite`,
`not-run-here`.

## The watcher

Run `watch --poll` from the case's scheduler (hourly, say) on a machine with a clean
working copy of the line, and `watch --rev R` from a post-commit hook if the case has one.
The watcher **never updates the working copy**: a job that runs `git pull --ff-only` or
`svn update` just before the poll keeps the suite run current; the brief tells the agent
the working-copy revision, so a run over other code is visible.

Each revision is classified by its paths, then decided (`decide.py`; rows are tried top to
bottom):

| Kind | Facts | Action | Suite | Claim |
|---|---|---|---|---|
| tests | - | `skip-tests-only` (never analysed: it may cover earlier fixes) | no | no |
| untestable | - | `skip-untestable` | no | no |
| mixed | - | `report-tests-present` | yes | no |
| fix | the index has a row, own revision | `report-tests-present` | yes | no |
| fix | the index has a row, another author's | `skip-covered` | yes | no |
| fix | this machine holds the claim, no report published | `continue-draft` (a staged proposal waits for its human) | yes | no |
| fix, own | its tests are pending in the working copy | `remind-author` | yes | no |
| fix, own | claimed by another, or published | `skip-claimed` | yes | no |
| fix, own | drafting on / off | `claim` / `report-uncovered` | yes | yes / no |
| fix, another author's | claimed | `skip-claimed` | yes | no |
| fix, another author's | inside the grace period | `wait-grace` (queued until the deadline) | no | no |
| fix, another author's | after the grace period, drafting on / off | `claim` / `report-uncovered` | yes | yes / no |

The suite runs at most once per watch process (the tree does not change between the
revisions of one poll) and **before** any claim: busy or missing here queues the revision
for retry and claims nothing; no suite closes it. A result from a clean copy records the
baseline (`source: watcher`).

**Claim** (only with `--claim`): `<key>/CLAIM.md` (`r<N>` for svn, the full commit id for
git) in the claims area, written from a private checkout in `<stateDir>/claims-wc`:

- git: an orphan branch (`claim.git.branch`) on the shared remote; the commit is built
  with plumbing on top of the tip just fetched and pushed **without force**. A rejected
  push means: fetch again; the revision's `CLAIM.md` is there -> lost; another revision was
  claimed -> build again on the new tip. Claims never enter the code lines' history.
- svn: `svn add` + `svn commit` of the folder; "already exists" / "out of date" -> lost.
  The claims folder is created on the first claim.
- Anything else (no network, no credentials, a server hook) is `failed` and retried: it is
  not someone else's claim. A claim already held by this claimer and machine is won again.

**Proposal**. Per revision, `<stateDir>/work/<key>/`: `bundle/` (written by the script,
read-only for the agent: `revision.json`, `diff.patch`, `suite.json`, `prompt.md`,
`agent.log`, `agent.settings.json` when asked) and `proposal/`, the agent's working folder
and its **only** writable place. What an earlier attempt left there moves to `attempts/`
first. After the agent, the proposal is refused when: the agent failed to start, timed out
or exited non-zero; **the working copy changed** while it ran; `REPORT.md` is missing, does
not name the revision in its title or lacks a section (`Changed code vs the suite`, `Suite
run`, `Testability`, `Draft`, `Case rows`, `Backlog candidates`, `Rule verdict`; an empty
one must say `none` and why); any other file or folder is there; a draft reads a fixed
machine path. Refused -> retried later (after `blockedRetryMinutes` when the agent's output
says it has no access or quota). Accepted -> `REPORT.md` and the drafts are **staged** next
to `CLAIM.md` in the private claims checkout, and the publish commands are printed.

**Containment of a headless agent**: its working folder is the proposal folder, and the
script checks the working copy afterwards. With Claude Code, `{agent_settings}` writes a
permission file that allows Read, Grep and Glob anywhere, Edit and Write only under the
proposal folder, and denies the shell. From the source case: in non-interactive mode a
"never ask" permission mode refused even the path-scoped write rules, so the working
command used the "accept edits" mode, whose writes stay inside the working folder and the
folders explicitly added - and the code working copy was deliberately **not** added
(reading needs no grant).

**Then a human** (T29: the script prepares, a person executes):

1. Publishes the staged proposal (the printed commands: `add`, `commit`, and for git
   `pull --rebase` + `push`). A published `REPORT.md` closes the claim for every watcher.
2. Promotes it as a change of its own, through the test gate: the draft into the suite,
   red first on the old code (or the mutation flip), green, `baseline compare` with no new
   failure, the coverage lists (T77), and a **row in the index** for the revision.
3. Or rejects it: a row in the index with the reason, so no watcher drafts it again.

`claims` lists open claims and flags the stale ones (no report after `staleClaimDays`).

## The commit door

`precommit` is meant for a client-side hook (a git `pre-commit` hook, a desktop svn
client's pre-commit hook script) or an agent's pre-commit step. While warn-only it never
runs the suite and always exits `0`: the suite runs at the suite gate (`run`, the change's
own loop) and in the watcher. After a project decision (`gate.mode: block`, recorded as a
numbered row in the project's register), it runs the suite and refuses new failures, an
invalid run, a busy suite and a missing suite; an already-red suite with nothing new
passes with the warning. It never records the baseline.

**In the plugin hooks** ([EK#14](../../DECISIONS.md)): with the plugin installed, a project
turns the door on at every agent commit (git `commit`, svn `commit` / `ci`) with one
section of its `.engine-kit/guards.json`, `"commitDoor": {"config":
".engine-kit/testing.json"}` - the guards' opt-in file and discovery; no section, no
file = silent no-op. From there the door is **always warn-only**: its warnings reach the
user and the agent, the commit goes ahead, the suite is not run even when this file says
`gate.mode: block`, and no Python 3.8+ on the machine is one "not run here" line. Contract,
the discovery choice and the hook answers: [runtime/guards](../guards/README.md#the-commit-door-ek14).
A **blocking** door stays the case's own VCS client hook above, installed by its own
numbered decision.

## Per machine (never versioned)

`<stateDir>/`: `local.json` (this machine's overrides), `baseline.json`, `state.json`
(the watch cursor and queue), `watch.log`, `suite.lock` and `watch.lock` (lock files stay;
the OS releases the lock), `runs/<stamp>/` (`suite.json` and the logs of each run - safe to
prune), `work/<key>/` (bundle, proposal, attempts - safe to delete once published),
`claims-wc/` (the private claims checkout - delete it only when nothing is staged).

## Tests

```text
cd runtime/testing
python -m unittest discover -s tests
```

`fake_suite.py` writes a JUnit file and exits as told; `fake_agent.py` writes a report and
a draft (or misbehaves on purpose). Everything runs in temporary folders: throwaway git
repositories (a bare "server" and two clones) and, when `svn`, `svnadmin` and `svnversion`
are on PATH, a `file://` svn repository - otherwise those tests are skipped with the reason.
No network, no real agent.

## Techniques

| # | Technique | Maturity ([labels](../../docs/MATURITY.md)) | Here |
|---|---|---|---|
| T38 | Baseline-diff gate: block only new failures; record pre-existing ones; not-run-here is not a failure; rollout starts warn-only | operating | `baseline.py`, `run`, `baseline`, `precommit` |
| T75 | Commit watcher + proposal agent: classify by path, grace period, first claim wins by a VCS conflict, the script runs the suite, the agent writes only its proposal folder and always closes a report, a human promotes | operating (candidate tier: opt-in; nothing runs until a case configures and schedules it) | `decide.py`, `claims.py`, `proposal.py`, `watch` |
| T76 | Evidence integrity: tests found, reconcile, red is an assertion | operating | `runner.py`, `run --expect-red`, `--before` |

## Portability limits

- Tested on Windows 11 with Python 3.14, git 2.53 and svn 1.14 (command-line client). The
  POSIX branches (`flock`, process groups) follow the standard library and are untested.
- The git head check reads the remote-tracking ref as last fetched; nothing here fetches
  except the watcher's `fetchRemote`.
- svn mixed-revision detection needs `svnversion`; without it the check is skipped.
- Windows path length: the claims working copy and its `<revision>/CLAIM.md` nest under the
  state folder, so a deep state folder (or a deep `TMP` for the tests) fails with git's
  "Filename too long". Keep the state folder short, or set `git config --global
  core.longpaths true` on that machine.
- Results and logs must land outside the working copy or in an ignored folder: an
  untracked results file makes the copy dirty and the baseline is refused.
- One baseline per machine and per line: with nothing blocking it only labels failures.
  Whether a shared baseline is needed once doors block is open in the source case too.
- The agent command is the case's: the kit checks what it left, not how it was sandboxed.

## Lineage and what stayed in the case

Distilled from case two's suite orchestrator (one script for several maintained lines of
a core product, a desktop svn client's hooks, an hourly scheduled poll). Kept:
the classification by path patterns, the decision table and the grace period in working
days, first claim wins by a commit conflict (`failed` is never `lost`; a lost claim is
discarded), one suite run per poll and before the claim, busy as a retry, the clean-copy
rule for the baseline, unnamed failures as new, every failing name (never a capped list),
the "busy" and "missing here" exit codes kept apart from any runner code, the report's
fixed sections, drafts that may not read a machine path, the stale-claim reminder, the
agent's write containment.

Changed: git next to svn (claims on an orphan branch pushed without force); any runner
through JUnit XML or patterns, in several parts, with `requires` for "not run here";
qualified names from the report's class and name; the record gained the line, the source,
per-test red-since from consecutive records (the source kept one "red since" per line,
taken from the revision being handled when the suite turned red) and the parts; a part not
run keeps its old failures; the stale check also on git; the proposal is staged and a
human publishes it (the source's script committed the report and the drafts itself);
attempts moved aside; the working copy checked after the agent; the claim behind
`--claim`; the commit door has a block mode for after the project decision.

Dropped as case-only: the case's build and test runner wrappers and their output parser,
the toolchain registry, the move of the suites out of the code branches and its migration,
the split of reports and drafts into two repositories, the rule against documents in the
tests tree, the work-item lookup in commit messages (the index uses revisions), two agent
providers with cooldowns and executable discovery (one configured command and a blocked
pattern remain), the coverage-tool download, the desktop notifications and queue file
(`watch.log` and `state.json` remain), the per-client suite variant, the installer of
hooks and the scheduled task (a case can record such a setup with
[`install-journal`](../install-journal/README.md)).
