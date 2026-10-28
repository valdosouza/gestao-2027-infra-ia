# Graph tools - registry-driven code graphs

**Scope**: method
**Maturity**: operating - the chain ran nightly on a designated builder in one case; the technique it serves (T07) runs in two

Layer 2 tooling for technique **T07, graph as instrument**: agents query a code graph
before they read source files, and every graph carries a build date that is checked
against the code before its answers are trusted. The graph tool itself is an external
dependency (a CLI with query / path / explain commands and hash-based incremental
rebuild); these scripts install it pinned, build the graphs a case registers, and keep
the registry honest.

## Scripts

| File | What it does | Inputs | Example |
|---|---|---|---|
| [`merge_tree.py`](merge_tree.py) | Incremental hardlink overlay tree: BASE + OVERLAY -> WORK, overlay wins on the same path, zero data copied, VCS metadata and `--exclude` names kept out; only changed files are relinked, files gone from both sources are pruned. Refuses a WORK that overlaps a source or a non-empty folder it does not own (marker `WORK.merge_tree` next to it) | `BASE OVERLAY WORK`, `--exclude PATTERN` (repeatable), `--no-default-excludes` | `python runtime/graph/merge_tree.py <base-src> <overlay-src> <work-dir> --exclude "*.tmp"` |
| [`rebuild-graphs.ps1`](rebuild-graphs.ps1) | Rebuilds every graph registered in the base's `REGISTRY_GRAPHS.md` files (base / overlay straight from source, merged through `merge_tree.py`), in the order base -> overlay -> merged. Switches: `-DryRun` / `-WhatIf` (plan only), `-CheckRegistry` (cross-check only), `-UpdateCode` (update CLEAN code working copies first), `-StampRegistry` (write Last Built + counts), `-Commit` (team builder: commit ONLY the graph folders, plus each registry this run stamped - stamped only when it had no local modifications, EK#12), `-Register` (daily scheduled task). Logs to a per-user folder | `-KbRoot` or `KB_ROOT`, `-CodeRoot` or `CODE_ROOT`, `-RegistryPattern`, `-GraphTool`, `-ToolArgs`, `-ToolOutSubdir`, `-DefaultFlags`, `-MergeExclude`, `-WorkRoot`, `-LogDir`, `-BuilderName` | `powershell -NoProfile -File runtime\graph\rebuild-graphs.ps1 -KbRoot <kb-root> -CodeRoot <code-root> -DryRun` |
| [`install-graph-tool.ps1`](install-graph-tool.ps1) | Installs the graph tool at the exact pin, refuses any unpinned requirement, adds language extras with `-Extras`, verifies that the CLI first on PATH reports the pinned version; never runs the tool's own set-up commands | `-Requirements`, `-Extras`, `-Python`, `-ToolCommand`, `-AddToUserPath`, `-DryRun` | `powershell -NoProfile -File runtime\graph\install-graph-tool.ps1 -Extras <language>` |
| [`requirements.txt`](requirements.txt) | The pin (`name==version`, technique T90). Raising it is a decision of the case, followed by a rebuild of every registered graph | - | - |

Exit codes of `rebuild-graphs.ps1`: 0 done (warnings allowed - warn-only by default,
[EK#6](../../DECISIONS.md)), 1 a build, stamp or commit failed, 2 bad arguments.
`-CheckRegistry` always exits 0; a case that wants it blocking says so in its own
numbered decision.

## The registry drives the job

The job keeps no list of its own: what it builds is what the
[graph registry template](../../templates/REGISTRY_GRAPHS.template.md) rows say. A job
with its own hardcoded list and a registry that agents read drift apart - the job
rebuilds a folder nobody registered while a registered graph silently ages.

Architecture columns: `Graph` (id, in backticks), `Kind` (`base` | `overlay` |
`merged`), `Location` (folder holding the graph file; absolute or relative to the
knowledge-base root; its last folder is the one the tool creates under `--out`, default
`graphify-out` via `-ToolOutSubdir`), `Source` (absolute or relative to `-CodeRoot`),
`Pairs` (merged only: `base` + `overlay` ids, may sit in another registry), `Flags`
(passed through; `-` = `-DefaultFlags`, code-only by default so no model key is
needed and document extraction never blocks a code rebuild). The Build Status table
keeps its shape. [`validate-registry.ps1`](../validate-registry.ps1) reads both tables
unchanged: it needs only Graph in column 1 and a backticked Location in column 3.

Before every build the job checks the structure and logs WARN (never stops): unknown
kind, missing source, an unresolvable pair, a location the tool cannot write to, a graph
without a Build Status row, an older table without the Kind column.

## Freshness contract

The graph is the reading instrument, not the source of truth - the code is. Before a
behaviour is mapped from a graph, its **Last Built** is compared with the code's **last
change** in version control. Code newer than the graph: rebuild first, or mark every
graph-derived claim `graph-stale`. A stale graph looks authoritative and is wrong.

`rebuild-graphs.ps1 -CheckRegistry` applies the contract to every row and reports, as
WARN: code changed after Last Built (`graph-stale`); a Last Built that disagrees with the
graph file's own date (stamp stale - a hand-filled date, or a job that never stamped);
a dated row without a file or a file without a date; a graph file in the knowledge base
that no row points to; a profile rule broken (below). Last Built must be stamped by
the job (`-StampRegistry`), never by hand: in the case this came from, the column was
filled by hand once, the nightly job rebuilt for weeks without writing it, and every
freshness check kept reading the old date.

## Profiles and the designated builder (EK#5)

Each registry declares `**Profile**: solo | team` ([EK#5](../../DECISIONS.md)):

| Profile | Where graphs live | Who builds | Commit |
|---|---|---|---|
| `solo` | outside the versioned knowledge base, rebuildable: a folder beside it, or a folder inside it that version control ignores ([EK#27](../../DECISIONS.md), [profiles/solo.md](../../profiles/solo.md#a-runtime-folder-inside-the-base)). A WARN if a location is inside the base folder - the job does not read the ignore rule yet, so a location in an ignored runtime folder warns too | the one user | never |
| `team` | versioned with the knowledge base | ONE designated builder (`**Designated builder**: <machine>`, compared with `-BuilderName`) on a schedule; on any other machine the registry is skipped and graphs arrive with a VCS update | `-Commit`: only the registered graph folders, `cache` and dated backup folders excluded (`-CommitExclude`); svn commits explicit targets at depth empty, git commits a pathspec - other staged or modified files are never swept in. git commits locally; the push is the builder's own step |

The builder updates a code working copy (`-UpdateCode`) only when it is clean; a dirty
copy is scanned as it is and its changes are logged. `-StampRegistry` skips a registry
that has local modifications, with a WARN, so a human's unfinished edit never mixes with
the job's stamp. The stamp itself is not part of the job's commit (it commits graph
folders only): the stamped registry is committed by a person - until then the next
stamp is skipped with the same WARN.

## Prepare-only and safety rules

- No VCS write without `-UpdateCode` or `-Commit`; `-DryRun` runs neither the tool nor
  any write. The scheduled task (`-Register`) carries exactly the switches it was given.
- The tool runs with its output folder as the working directory: it never writes into a
  source tree, into the hardlinked merged tree (that would write into the real sources)
  or at the knowledge-base root. The merged work tree must live outside the base.
- Never run the tool's own `init` / `install` / `hook install` at the knowledge-base
  root (T90): they write agent rule sections and hooks wherever they run.
- Native tools run with stderr merged under `Continue`: under `Stop`, one benign
  warning line from the tool aborted a whole nightly run in the source case.
- Counts are read by parsing the graph file (Python, up to `-CountMaxMB`); a file that
  does not parse fails the build - a large graph written straight to a network share
  was once truncated silently.
- An app-execution-alias Python gets a WARN from the installer: a store-packaged Python
  killed the tool's worker pool on every file in a real case.

## What stayed in the case

Dropped as case-only while porting: the job's hardcoded list of working copies (two
product lines and one client overlay each) and their machine paths; the case's memory
index rebuild chained into the same nightly job (the kit runs
[`memory_index.py`](../memory_index.py) on its own); the vendored upstream source and
its editable install (the tool stays an external, pinned dependency); the language
extra of the case's stack; builder names, decision numbers and the case's task name.
