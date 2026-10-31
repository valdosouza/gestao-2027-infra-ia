# Guards - encoding guard, revert guard, the commit door and their plugin hooks

**Scope**: method

Two small guards that catch, at the moment an agent edits a file and again before a
commit, two kinds of damage that a diff review tends to miss: **charset damage** in source
files and **silent removal of code that was committed a few days ago**. They ship as
scripts (usable from any editor or VCS hook) and as Claude Code plugin hooks
([`hooks/hooks.json`](../../hooks/hooks.json)). They are **inert until a project opts in**
with a `.engine-kit/guards.json` file, and they **warn by default** ([EK#6](../../DECISIONS.md)).
The same hook, from the same file, also runs the **commit door** of the testing tools
([`runtime/testing`](../testing/README.md)) at commit time - opt-in and always warn-only
([EK#14](../../DECISIONS.md), section [The commit door](#the-commit-door-ek14)).

## Files

| File | What it does |
|---|---|
| [`encoding-guard.ps1`](encoding-guard.ps1) | Three detections: (1) file is not valid UTF-8 (an ANSI / cp1252 save); (2) characters outside the project's allowed set (policy `ascii`: em dash, box lines, arrows, ellipsis...), with the ASCII stand-in to use; (3) at commit time, **charset-only lines**: changed lines that differ from the base revision only by non-ASCII characters or their ASCII stand-ins (lines are folded and compared). CLI: `-Paths f1,f2` or `-Gate [-WcRoot <dir>]`; exit 1 on a finding |
| [`revert-guard.ps1`](revert-guard.ps1) | Lines the local change removes whose origin revision is younger than the blame window (`recentDays`): diff against the base -> blame of the base -> revision, author, date, and the ticket id when the project gives a `ticketRegex`. CLI: `-Paths` or `-Gate [-WcRoot <dir>]`; exit 1 on a finding |
| [`hook.ps1`](hook.ps1) | Hook entry point: reads the hook JSON once, finds the project from the edited file or the commit folder (last `cd` / `Set-Location` / `git -C` before the commit verb, else the payload `cwd`), loads `.engine-kit/guards.json`, runs the enabled guards and, at commit time, the commit door, writes the hook answer. No config -> exit 0, no output. Always exits 0 |
| [`launch.sh`](launch.sh) | Cheap prefilter (POSIX sh, builtins plus one `cat`); these end here without starting PowerShell: a Bash/PowerShell command that is not a commit (the command string is read, not the rest of the payload); a commit with no folder move in its command (`cd`, `chdir`, `pushd`, `Set-Location`, `sl`, `git -C`) whose payload `cwd` is outside every opted-in project; an edit outside every opted-in project, or in one whose config names no edit guard (the commit door alone) |
| [`guard-common.ps1`](guard-common.ps1) | Shared helpers: config lookup, the git/svn adapter (read-only), a native-process runner that keeps raw bytes, an ASCII-only JSON writer |
| [`hooks/hooks.json`](../../hooks/hooks.json) | Plugin wiring: PostToolUse `Edit\|Write\|MultiEdit`; PreToolUse `Bash` and `PowerShell` with `if` filters `* commit*` / `* ci*`, so the harness itself skips every other command |
| [`templates/guards.example.json`](../../templates/guards.example.json) | Documented example of `.engine-kit/guards.json` |
| [`HARNESS-PERMISSIONS.md`](HARNESS-PERMISSIONS.md) | The "ask list": irreversible or outward operations set to `ask` in the harness permissions |
| [`tests/`](tests/) | `python -m unittest discover -s tests` from this folder: `launch.sh` fed the hook JSON of commits and edits in throwaway git and svn working copies (section [Tests](#tests)) |

All scripts are ASCII-only, LF, Windows PowerShell 5.1 compatible (and PowerShell 7).

## Turning the guards on in a project

Copy [`templates/guards.example.json`](../../templates/guards.example.json) to
`<repo-root>/.engine-kit/guards.json`, adjust it, version it. With the plugin installed,
nothing else is needed. Without the plugin, the CLI modes work from an editor task or a
VCS client-side pre-commit hook: `powershell -NoProfile -ExecutionPolicy Bypass -File
<kit>/runtime/guards/encoding-guard.ps1 -Gate -WcRoot <repo>`. The commit door is one more
section of the same file: set `commitDoor.enabled` to `true` once the suite's testing
config exists (by default `.engine-kit/testing.json`).

## Config contract (`.engine-kit/guards.json`)

Found by walking up from the edited file (or the commit folder); the first folder that has
`.engine-kit/guards.json` is the project. A guard runs when its section is present and
`enabled` is not `false`. Keys starting with `_` are notes and are ignored.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `commitGate` | `warn` \| `ask` | `warn` | At commit time: `warn` = findings shown to the user (`systemMessage`) and given to the agent (`additionalContext`), the commit goes ahead. `ask` = the harness asks the user to confirm (`permissionDecision: "ask"`). Applies to the guards' findings only: the commit door's warnings alone never ask |
| `encoding.extensions` | string[] | `.css .js .htm .html .json` | File types checked (case-insensitive) |
| `encoding.policy` | `ascii` \| `utf8` | `ascii` | `ascii`: only U+0000-U+007F plus `allow`. `utf8`: any character; only detections 1 and 3 run |
| `encoding.allow` | string[] | `[]` | Extra code points under `ascii`: `"U+00A0"`, `"U+00C0-U+00FF"` |
| `encoding.maxFindings` | int | `12` | Lines listed per file |
| `revert.recentDays` | int | `60` | Blame window in days |
| `revert.ticketRegex` | string | `""` (none) | .NET regex on the origin commit message; group 1 (or the whole match) is printed as the ticket |
| `commitDoor.enabled` | bool | `true` when the section is present | Runs the commit door at commit time ([below](#the-commit-door-ek14)); the template ships it `false` |
| `commitDoor.config` | string | `.engine-kit/testing.json` | The suite's testing config ([contract](../testing/README.md#configuration---testingjson)), relative to the project root (the folder that holds `.engine-kit/`) or absolute |

A config that is not valid JSON produces one `systemMessage` and no checks.

## Warn-only policy (EK#6)

| Moment | Default answer | With `"commitGate": "ask"` |
|---|---|---|
| After Edit / Write / MultiEdit | `additionalContext` (the agent fixes it now) + `systemMessage` | same |
| Before `git commit` / `svn commit` / `svn ci` | `systemMessage` + `additionalContext`; the commit runs | `permissionDecision: "ask"` with the findings as the reason |
| Commit door, same moment | its warnings join the same answer; the commit runs | the same: `ask` only when a guard found something |

The guards and the door never answer `deny` and never exit 2. Turning the commit gate to
`ask` is a project decision: record it, numbered, in the project's decision register. A
gate that must hold even in a bypass mode belongs in the harness permissions
([HARNESS-PERMISSIONS.md](HARNESS-PERMISSIONS.md)), not in these hooks.

## The commit door (EK#14)

The commit door of the testing tools (`suite.py precommit`,
[runtime/testing](../testing/README.md#the-commit-door)) rides on the guards' commit
hook: the same `hooks.json` entries, the same prefilter, the same commit detection (git
`commit`, svn `commit` / `ci`, the folder the commit runs in) and the same PowerShell
process, after the guards.

**Discovery: a `commitDoor` section in `.engine-kit/guards.json`**, not the mere presence
of a testing config. Chosen because:

- one opt-in file and one walk for every door: the prefilter looks for a single file
  name, and a project reads in one place what its hooks do (EK#14: the same discovery as
  the guards);
- a testing config is one file per suite and line and may live with the suite, anywhere
  in the working copy; presence-based discovery would need one fixed name and place;
- writing a testing config for the suite gate or the watcher must not switch on a
  commit-time hook as a side effect: turning the door on is its own act (one key), and
  `enabled: false` turns it off without touching the suite's config.

**What runs**: `python -I -X utf8` with a few lines that check the Python version and call
`suite.py precommit --warn-only` (the public flag that forces `gate.mode` to `warn`) with no
`--paths`, so
the paths are the local changes of the testing config's working copy (unversioned files
left out, as in the guards), and no `--for`: the warning on someone else's claim needs the
revision the tests cover, which a commit command does not say, so it comes only from a
door run by hand or by the agent's own pre-commit step. Python is the first of `python3`, `python`, `py -3` found on
PATH (never the current folder); a launcher stub without Python behind it (exit 9009) or
a Python older than 3.8 is skipped for the next one.

| Case | Hook answer (always exit 0, never `ask` or `deny` because of the door) |
|---|---|
| warnings | a `COMMIT-DOOR:` block (head, the `precommit:` line, each `warn:` / `note:` line) in `systemMessage` and `additionalContext`, the advice in `additionalContext` |
| no warning (a tests-only commit, say) | nothing |
| testing config with `gate.mode: block` (or a per-machine `local.json` that says so) | still warn-only, the suite is **not** run; one `note:` line says so |
| no Python 3.8+ on PATH | one line: `COMMIT-DOOR: not run here - no Python 3.8+ on PATH ...` |
| testing config missing or invalid, any other failure | one `COMMIT-DOOR:` block with the error; the commit goes ahead |
| `commitDoor` absent or `enabled: false`, or no `.engine-kit/guards.json` | nothing |

**A blocking door is not a plugin hook.** A case that wants commits refused on new
failures records it as its own numbered decision, sets `gate.mode: block` in its testing
config and installs `python <kit>/runtime/testing/suite.py --config <testing.json>
precommit` as its own VCS client hook (a git `pre-commit` hook, a desktop svn client's
pre-commit hook script). The plugin hook then keeps warning ahead of it, without running
the suite twice.

## VCS adapter

Detection walks up from the path for `.git` / `.svn` (nearest wins; the commit command
breaks a tie), then falls back to `git rev-parse --show-toplevel` / `svn info --show-item
wc-root`. Only read commands run: `git diff`, `git blame --line-porcelain`, `git log`,
`git show HEAD:<path>`; `svn status --xml`, `svn diff --internal-diff`, `svn blame --xml`,
`svn log --xml`, `svn cat -r BASE`. Base revision: git `HEAD`, svn `BASE`. At commit time
git checks every tracked file that differs from HEAD, staged or not (the same command often
stages them: `git add ... && git commit`), whole repository; svn checks `svn status` under
the commit folder. Untracked / unversioned files are not checked at commit time (the edit
hook already saw the files the agent wrote).

## Tests

```text
cd runtime/guards
python -m unittest discover -s tests
```

[`tests/test_hook.py`](tests/test_hook.py) feeds `launch.sh` the hook JSON that a
PreToolUse Bash / PowerShell commit or a PostToolUse edit sends, in throwaway git and svn
working copies, with the testing tools' fake suite: the door opted in (git, svn `commit`
and `ci`, the PowerShell tool, a `cd` into the project), a block testing config (warn-only,
suite not run), a missing or invalid testing config, a disabled door, not opted in, a
non-commit command, an edit in a door-only project, Python hidden from PATH; and the two
guards at edit and commit, with `commitGate` `warn` and `ask`. `ENGINEKIT_GUARDS_DEBUG=1`
makes `hook.ps1` trace on stderr, so an empty stderr proves that PowerShell never started.
Needs `sh`, PowerShell and git; the svn case needs `svn` and `svnadmin` and is skipped
without them.

## Techniques

| # | Technique | Maturity ([labels](../../docs/MATURITY.md)) | Here |
|---|---|---|---|
| T54 | Encoding guard: configurable charset policy, post-edit and pre-commit hooks, charset-only changes found by folding lines | candidate (one case) | `encoding-guard.ps1` |
| T55 | Revert guard: warn when the local change removes recently committed lines | candidate (one case) | `revert-guard.ps1` |
| T29 | Prepare-only for the irreversible: the agent prepares, the human executes; the harness "ask" list is the executable twin of the written rule | proven (two cases) | [HARNESS-PERMISSIONS.md](HARNESS-PERMISSIONS.md) |
| T38 | Baseline-diff gate, its commit door: wired warn-only into the commit hook (EK#14) | operating | `hook.ps1` -> [`runtime/testing`](../testing/README.md) |

Both guards and the door are opt-in per project, as `candidate` requires: the plugin
installs them everywhere, but they act only where `.engine-kit/guards.json` turns them on.

## Portability limits

- **Shell**: the plugin hooks are shell-form commands (`sh launch.sh ...`). On Windows
  Claude Code runs them with Git Bash; on a Windows machine **without Git Bash** hooks run
  in PowerShell, `sh` is not found and the hook reports a non-blocking error on every edit.
  Workaround there: wire `hook.ps1` directly in the project's `.claude/settings.json`
  (exec form, no prefilter; still a no-op without config, but PowerShell starts on every
  edit and commit):
  `{"type": "command", "command": "powershell.exe", "args": ["-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "<kit>/runtime/guards/hook.ps1"]}`.
- **macOS / Linux**: `launch.sh` runs with `sh`; the guards and the door need PowerShell 7
  (`pwsh`) on PATH. Without it, an opted-in project gets one `systemMessage` saying the
  guards and the door were skipped. Tested only on Windows PowerShell 5.1 (Git Bash); the
  pwsh path is untested.
- **Python** (the door only): 3.8+ as `python3`, `python` or `py -3` on PATH; anything
  else is the one "not run here" line. A Python that is on the machine but not on PATH is
  not looked for.
- **`if` filters** in `hooks.json` need a Claude Code version that knows the hook `if`
  field. They are best-effort: an unusual form (`git -c x=y commit` inside `sh -c`) may
  slip past the harness filter; `launch.sh` and `hook.ps1` re-check the command themselves.
- **Cost**: the prefilter no-op is one `sh` plus one `cat`. When a project opted in, each
  edit starts PowerShell once (both guards in one process); on Windows that start dominates.
  A commit in an opted-in project starts PowerShell once, plus one Python process when the
  door is on (2 to 5 seconds in all on the test machine, against 0.1 to 0.2 seconds for a
  prefilter no-op). A commit command with a folder move (`cd`, `git -C`...) always
  starts PowerShell, which resolves the folder and may find no config: the price of
  following the move.
- svn commit with explicit paths (`svn commit a.js -m x`) is checked for the whole commit
  folder, not only the named paths (over-inclusive, warn-only).

## Lineage and what stayed in the case

Ported from one case's editor guards (two scripts, each launched by its own hook, behind a
bash one-liner that grepped the payload for the case's code path). Kept: the three
encoding detections, the binary search for the first invalid byte, the stand-in table,
the blame-window logic, the commit folder order (explicit root, then payload `cwd`, then
current folder), the CLI modes. Changed: git support next to svn behind one adapter; one
entry point and one PowerShell process per event instead of one per guard; config file
instead of a hard-coded path filter and extension list; UTF-8 stdin and ASCII-escaped JSON
out (non-ASCII paths and messages survive any console code page); diff parsing ignores
headers only before the first hunk (a removed line starting with `--` no longer shifts
the numbering) and skips `\ No newline` and svn property sections; a charset-only line
now needs non-ASCII on one side (whitespace-only or `<`/`>` edits were counted before);
`ask` at commit time became opt-in. Added in the kit: the commit door of the testing tools
on the same hook (EK#14; the door's source case ran it from VCS client hooks). Dropped as
case-only: the code-path filter, the
tracker URL pattern that served as ticket extractor (now `ticketRegex`, default none),
the case's decision ids and incident references in messages, the advice to normalise a
whole file on first touch (a case decision; a project can make it its own rule).
