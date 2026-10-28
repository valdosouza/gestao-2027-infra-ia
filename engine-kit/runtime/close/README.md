# Close tools - the mechanical checks of a closing, in one call

**Scope**: method

The script behind the last step of the [`close-and-retain`](../../skills/close-and-retain/SKILL.md)
skill (and the end of [`retain-knowledge`](../../skills/retain-knowledge/SKILL.md)): after the
closer has written the closing texts, the memory log and the card decisions, one call runs
every check a machine can do and reports what is left to fix. It reuses the kit's tools -
it never copies them - and reads git or svn through the shared adapter
[`registry/vcs.py`](../registry/vcs.py). Python 3.8+, standard library only. Nothing here
knows a case: locations, folders, patterns and levels are configuration.

It writes nothing itself. The generated decisions index, ledgers and memory index are
written by the tools it calls (`--dry-run` asks them not to). It never commits, adds,
reverts or writes to a tracker. **Warn-only by default** ([EK#6](../../DECISIONS.md)):
findings are reported and the exit code stays 0; a blocking mode exists only as an explicit
option.

## Files

| File | What it is | Technique |
|---|---|---|
| [`close.py`](close.py) | The command line: configuration, the eight checks, the report (text or JSON), the exit code | T45, T78 |
| [`retired.py`](retired.py) | Retired locations as data: every written location expanded to its other spellings; the scan of a file, the allowed lines, the superseded-file rule | T88 |
| [`close.example.json`](close.example.json) | The configuration, filled with a fictional knowledge base | - |
| [`tests/`](tests/) | `python -m unittest discover -s tests` from this folder: throwaway git and svn working copies, the kit's real registry and memory tools | - |

## Run

```text
python <kit>/runtime/close/close.py --root <kb-root> [--project <KEY>] [--ticket <ticket folder>]...
       [--config <file>] [--strict] [--vcs auto|git|svn] [--level 1|2|3] [--only a,b] [--skip a,b]
       [--dry-run] [--json] [--verbose]
```

- `--root` falls back to `KB_ROOT`, then the current folder.
- `--level` is the case's adoption level; it falls back to the configuration's `level`, then
  3 - every check ([adoption levels](#adoption-levels)).
- `--config` falls back to `<kb-root>/.engine-kit/close.json` (next to the guards'
  `guards.json`); without a file every key keeps its default and the checks that need data
  say `not configured`.
- `--project` is the work item's project key: it turns on the tenant scope check.
- `--ticket` names a work-item folder being closed; without it, a folder is "being closed"
  when its closing record (`CLOSE.md` by default) is added, modified or unversioned.
- `--json` prints one object (every check with its status and lines, the counts, the exit
  code) for an agent to read; `--verbose` adds each tool's full output to the text report.

A typical close: `python <kit>/runtime/close/close.py --root <kb-root> --project ORD`, fix
what it lists, run it again until each remaining line is either fixed or a written reason in
the closing answer.

## The checks

In this order; each one prints `ok`, `FIX` (an item to fix), `WARN`, `note`, `NOT RUN HERE`
(this machine cannot run it - with the reason), `n/a` (not configured - with what is
missing) or `skip` (`--only` / `--skip`). What was not checked is always a written line,
never a silence.

| Check | What | Reuses | Default finding level | From adoption level |
|---|---|---|---|---|
| `registries` | Registries vs reality; then, when the base has a projects registry, the inventory, the `project:` front matter of touched documents and, with `--project`, the tenant scope | [`validate-registry.ps1`](../validate-registry.ps1) `-NoScope` when PowerShell is on PATH (otherwise `NOT RUN HERE`); [`projects_check.py`](../registry/projects_check.py), `--check-touched`, `--check-scope` | fix | 1 (the validator: 3) |
| `scope` | Every added, modified or unversioned markdown document under the root has exactly one Scope line with a known value - the contract of the validator's check 3 (first 50 lines, outside fenced code, `Scope`/`Escopo`, `method`/`case`/`mixed`, aliases `metodo`/`misto`, plus `caseValues`), applied to the touched documents only, so it needs no PowerShell. The 50 lines are counted **after a YAML front matter** ([below](#the-scope-line-after-the-front-matter)). A frozen source (below) gets no Scope line: a new one is a `note`, a modified one a finding; a document byte-identical to a frozen source (its original) is a `note` too | - | fix | 1 |
| `test-gate` | For each work item being closed: a test evidence file (or one with its `skip:` line); its `not run here:` lines named in one warning per evidence file (the run is owed - a verdict that repeats the line adds no second warning); where the case keeps an index of tested changes, a row for the work item or an `exempt:` line in its Test plan ([`test-gate`](../../skills/test-gate/SKILL.md)) | - | **warn** | 2 |
| `retired` | No normative file points at a retired location, in any spelling (below) | - | fix | 1 |
| `decisions` | Decision citations of the touched documents, then the generated index | [`decisions_index.py`](../registry/decisions_index.py) `--check-touched`, then without it | fix | 1 |
| `ledger` | The ledgers of the projects with pending changes, and the cross-project view | [`ledger_gen.py`](../registry/ledger_gen.py) `--changed --cross-index` | fix | 1 |
| `memory` | The memory index rebuilt (logs and cards); every subject at 5+ unconsolidated logs becomes a warning "run the consolidation cycle" | [`memory_index.py`](../memory_index.py) `build` | fix (the flag is always a warning) | 3 |
| `unversioned` | In every working copy of the change: no file left outside version control (T78), with the add command; when `testPaths` is set and both kinds are pending, the fix files and the test files listed as two groups - two commits, the fix first. Runs last, so the files the tools above generated are seen. At level 1, and at every level for a working copy with no first commit yet, one `note` per working copy instead of a warning per file (below) | - | **warn** | 1 |

A tool's own `FIX`, `DRIFT` and `ERROR` lines become findings at the check's level, its
`WARN` lines warnings; a non-zero exit with no such line is one finding with its last line.

### The Scope line after the front matter

The placement rule puts the Scope line right after a YAML front matter
([`scope-census`](../../skills/scope-census/SKILL.md#placement-rule-where-the-line-goes)),
and an episodic log carries its claims there
([`memory-engineering`](../../skills/memory-engineering/SKILL.md)): a log with a dozen
claims pushes its title past line 50. So when a document opens with `---` on its first line
and closes it with `---` or `...` within 500 lines, the `head` lines are counted after the
closing line; a `**Scope**:` line inside the front matter never counts (a YAML key is not the
token). A finding then names the span: `no Scope line in the first 50 lines after the front
matter (lines 1-64): <doc>`. A longer or unclosed front matter is read from the top, as a
document without one - the bound keeps a stray `---` from hiding a whole document; raise
`checks.scope.head` for such a file. The validator's full sweep (`scopeAll`, level 3) still
reads the first 50 lines of the file.

`scope` and `unversioned` read the change set through `vcs.py`, so on svn they see only what
`svn status` shows - and a client's `global-ignores` can hide a whole document type. With
`"svnClientIgnored": true` ([EK#17](../../DECISIONS.md), off by default) they read svn with
the client's list emptied: a file only the client hides becomes a touched document and an
unversioned file, while a file the repository ignores (`svn:ignore`, `svn:global-ignores`)
stays out; each of the two checks then prints a `note` saying so. The registry tools
(`projects_check.py --check-touched`, `decisions_index.py --check-touched`,
`ledger_gen.py --changed`) run as separate commands without the option: with it on, each
says so in a `note` ([limits](#portability-limits)). The repository / client distinction,
the git side and why git has no such option:
[registry README](../registry/README.md#ignored-files-repository-and-client).

**Test logs and a global exclude.** On git the same blind spot comes from the machine: a
common global exclude (`*.log` in the file `core.excludesfile` names) keeps every `.log` out
of version control silently, so a log the test evidence names by path is neither
unversioned nor seen - it never reaches the repository and no check says so. The evidence
template therefore keeps the logs of a work item as `.txt` (or inside the evidence file)
([`TEST_EVIDENCE`](../../templates/TEST_EVIDENCE.template.md), section 1);
`git ls-files <ticket>/TESTS` shows what will really travel.

**A solo runtime folder inside the base** ([EK#27](../../DECISIONS.md)): when the derived
artifacts live in a folder inside the knowledge base that version control ignores (for
example `.runtime/`, ignored by `.gitignore` or by `svn:ignore` on the base root -
[profiles/solo.md](../../profiles/solo.md#a-runtime-folder-inside-the-base)), `scope` and
`unversioned` never see it: it is ignored by the repository, so `svnClientIgnored` does not
bring it back either, and it needs no entry in `checks.unversioned.ignore`. When its files
are reported as unversioned, the ignore rule is missing - fix the rule, not the
configuration. `checks.memory.db` may point into it (`.runtime/memory-index.db`).

**A code tree inside the base** ([EK#29](../../DECISIONS.md)): a folder inside the base that
is its own repository and that the base's version control ignores (for example `app/`,
`/app/` in `.gitignore`). `scope` and `unversioned` read version control, so they never see
it; two checks walk the folder instead - the frozen-twin search of `scope` and the
normative files of `retired` - so the tree goes to `checks.scope.exclude` and to
`checks.retired.normative.exclude` (`"app/**"`). Its own commits are its own repository's
(the code's release list), never the base's.

## Adoption levels

The case's adoption level ([ADOPTION-LEVELS.md](../../docs/ADOPTION-LEVELS.md): 1 Essential,
2 Governed, 3 Scale) is the top-level `level` of the configuration, or `--level`. The
default is 3: every check, as before the key existed. Below 3 the script leaves out what
belongs to a higher level, each one a written `skip` line:

| | Level 1 | Level 2 | Level 3 |
|---|---|---|---|
| `test-gate` (the test gate is a level-2 piece) | `skip  level 2 check, skipped` | runs | runs |
| `memory` (the memory index and consolidation are level 3) | `skip  level 3 check, skipped` | `skip` | runs |
| `registries`: `validate-registry.ps1` (the registry validator is level 3) | `skip  validate-registry.ps1: level 3, skipped`; `projects_check.py` runs | the same | runs |
| `unversioned` | one `note` per working copy (below) | a warning per file; one `note` for a working copy with no first commit yet | the same as level 2 |
| exit checklist | the items without a level | + episodic log, closing record, new files and two commits | + card decision |

So the `--skip test-gate,memory` (level 1) and `--skip memory` (level 2) of earlier
instructions are no longer needed once `level` is set; they still work.

**Unversioned files at level 1.** Level 1 is prepare-only with no hand-over packaging yet:
the single closing that promises "nothing unversioned at hand-over, fix and tests apart"
(T78, [`close-and-retain`](../../skills/close-and-retain/SKILL.md)) is a level-2 piece, and
the new files of a level-1 base wait for the owner's release word. The script cannot see
whether that word was given (it is a sentence in a conversation, not a state of the working
copy), so at level 1 it never warns per file: it writes one `note` - how many files wait for
the release word, staged by path in the commit(s) prepared at the close - and puts the list
in the check's output (`--verbose`, `--json`); the summary says `ok - <n> new file(s) wait
for the release word`. A working copy that is not found is still a finding. From level 2
every unversioned file is a warning, as before - once the working copy has a first commit.

**A working copy with no first commit yet, at every level.** A new base's first commit is
tied to the owner's release word from Day 1, and so is a new code tree's (a red written
before its go waits there too); until it exists, every file of that working copy is new and
a warning per file would only repeat it. So when nothing under the working copy was ever
committed - git: no `HEAD`, or no file under the folder in `HEAD`; svn: no node under it
with a commit revision above 0 (a checkout of an empty repository at revision 0, every file
unversioned or added) - the check writes one `note` at any level:
`<label>: no first commit yet - its first commit waits for the owner's release word: <n>
file(s)` (with how many are already added) and the add command - by path, when each file
is created (adding is not releasing,
[`change-gate`](../../skills/change-gate/SKILL.md) step 5), or with that commit where the
case tied staging to the word - the list in the output, and the summary
`ok - <label>: first commit waits for the release word (<n> file(s))`. Once every file is
added, the line is the usual `ok ... nothing unversioned`. The fix and test groups
(`testPaths`) are still listed apart, for the two commits of the work item's close. A
modified file proves a commit, so the question is asked only when a working copy has new
files and none modified. Once the first commit exists - on svn even before an update - the
level's own rule applies again.

## Frozen sources

A frozen source is a document the method forbids editing - the owner's draft kept
byte-identical beside the prompt (its line numbers are the item ids), an official source
archived as published, any file whose line numbers are cited as ids
([`scope-census`](../../skills/scope-census/SKILL.md#frozen-sources-classified-never-marked)).
It is classified in the census and never gets a Scope line, so the `scope` check skips it
with a `note`. A frozen source that version control shows as modified is a finding at the
check's level: it is never edited - compare it with its recorded hash and restore the
original. `checks.scope.frozen` lists them as globs; the default is the frozen-draft name of
[`frame-greenfield`](../../skills/frame-greenfield/SKILL.md) (`prompts/prompt_<front>-draft.md`,
`-draft-2.md`): `**/prompt_*-draft.md`, `**/prompt_*-draft-*.md`.

**The owner's original needs no entry.** The frozen draft is a byte-identical copy of the
owner's file, and the original stays the owner's - at the root, in `HISTORY/`, wherever the
owner keeps it. So a markdown document whose bytes equal a frozen source's is treated as
that source's original: frozen too, a `note` naming its copy
(`byte-identical to the frozen source prompts/prompt_orders-draft.md (its original) ...`),
never a finding. The script finds such documents by size, then by bytes, walking the root
once (the excluded globs and the version-control folders left out), and only when a touched
document would otherwise be a finding. Once the owner edits the original it is a document of
its own: it gets a Scope line, or the case names it in the list.

**The case's own frozen files go in the list by path.** The list replaces the default, so
keep both default globs when adding them: a file the owner hands over to be kept as received
(a written answer to a round), an original the owner has edited but that must stay
untouched, an archive folder:

```json
"scope": {
  "frozen": ["**/prompt_*-draft.md", "**/prompt_*-draft-*.md", "owner-answers/**", "projects/orders/SOURCES/**"]
}
```

With `scopeAll` the validator's full sweep receives the same list as its `-FrozenPattern`,
plus the exact paths of the originals found by their bytes.

## Retired locations (T88)

A retired location is written **once** in the configuration; `retired.py` derives its other
spellings. The defect this answers: a list of patterns that caught the backslash spelling of
an old share and missed the UNC and forward-slash ones, so live pointers survived the check.

| Written as | Also matches |
|---|---|
| a drive path `R:\old-share\kb` (or `R:/old-share/kb`) | either separator in any mix, doubled (escaped in code and JSON), `/r/old-share/kb` and `/mnt/r/...` (POSIX shells), `file:///R:/...`; letters in any case |
| a UNC path `\\files01\old-share` | `//files01/old-share`, `\\\\files01\\old-share`, `file://files01/old-share` |
| any other path | either separator, doubled; a neighbour (`old-share2`, `xold-share`) never matches |
| a trailing separator (`C:\Users\`) | only what is inside it |
| a URL | itself and what is below it |

A drive letter and a UNC name of the same share cannot be derived from each other: list both
spellings in one entry. `patterns` takes raw regular expressions (an old host name, an old
tool name). A line that matches `allowLine` (by default it says retired, superseded, frozen,
formerly or archived) is history, not a pointer; a file that says SUPERSEDED in its first
`supersededHead` lines is kept for history and skipped; the configuration file itself is
never scanned.

**Normative files** are the ones an agent or a person follows: by default the root rules
files (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, `README.md`), every `INDEX.md`,
the registries (`_REGISTRY/*.md`, `REGISTRY_*.md`), skills, agents and the tool folders
(`.claude`, `.cursor`, `.github`, `.engine-kit`); generated and archived files are excluded.
Episodic logs, tickets and history are not normative: a log may say where something was.

## Configuration contract (`.engine-kit/close.json`)

JSON; keys starting with `_` are notes; a missing key keeps its default; an unknown key, a
wrong type, an invalid regular expression or an unknown check name is refused (exit 2).
Paths are relative to the knowledge-base root unless absolute; globs use `/`, `**` for any
depth and `*` for one name, and ignore case.

| Key | Default | Meaning |
|---|---|---|
| `mode` | `warn` | `warn` or `strict`. Strict exits 1 on a finding at level `fix`; set it only by a numbered project decision |
| `decision` | `""` | The `KEY#N` that made the door strict; printed with the mode (the report notes a strict mode without one) |
| `level` | `3` | The case's adoption level, 1, 2 or 3 (a whole number); `--level` wins. The checks, the validator and the checklist items of a higher level are left out ([above](#adoption-levels)). Not to be confused with `checks.<name>.level`, the level of a finding |
| `vcs` | `auto` | `auto`, `git` or `svn` for the root (`--vcs` wins) |
| `svnClientIgnored` | `false` | svn only ([EK#17](../../DECISIONS.md)): `true` lists, as unversioned, the files that only the client's `global-ignores` hides, for the `scope` check, the root's `unversioned` entry and the registry tools (passed as `--svn-client-ignored`); the repository's ignore properties still apply. No effect on git |
| `caseValues` | `[]` | Extra Scope values that mean `case` (a case key) - for the scope check and the validator |
| `projects` | `_REGISTRY/PROJECTS.md` | The projects registry; when it does not exist, the registry tools say `n/a` |
| `workingCopies` | `[{"path": ".", "label": "knowledge base"}]` | Every working copy of the change for the `unversioned` check: `path`, `label`, optional `vcs`, optional `svnClientIgnored` (default: the top-level value; `false` keeps the client list for a copy where it hides only build output) |
| `checks.<name>.level` | see the table above | `fix` (counts for strict) or `warn` (never changes the exit code) |
| `checks.registries` | `validateRegistry: true`, `scopeAll: false`, `args: []`, `powershell: ""`, `projectsCheck: true` | `scopeAll` drops `-NoScope` (the validator then checks every document - the periodic sweep, not the per-task one - and gets `checks.scope.frozen` as `-FrozenPattern`); `args` go to the validator as they are; `powershell` names the executable (default `powershell` then `pwsh` on Windows, `pwsh` elsewhere). The validator runs at level 3 only |
| `checks.scope` | `head: 50`, `exclude: [templates, attachments, node_modules]`, `frozen: ["**/prompt_*-draft.md", "**/prompt_*-draft-*.md"]` | Lines read per document, counted after a YAML front matter of up to 500 lines ([above](#the-scope-line-after-the-front-matter)); documents left out; frozen sources - never edited, never marked; a document byte-identical to one is its original, frozen without an entry ([above](#frozen-sources)) |
| `checks.test-gate` | `tickets: "**/TICKETS/*"`, `closingRecord: "CLOSE.md"`, `evidence: ["TESTS/SUITE_*.md"]`, `exemptIn: ["PLAN.md", "SPEC.md", "TESTS/TEST_PLAN.md"]`, `indexFiles: []` | Where work-item folders are, the file whose change means "being closed", the evidence globs and the files holding the Test plan (relative to the work-item folder), the indexes of tested changes (relative to the root; a row is a table line naming the work-item id) |
| `checks.retired` | `locations: []`, `patterns: []`, `caseSensitive: false`, `allowLine`, `supersededHead: 10`, `normative: {include, exclude}` | A location is a string or `{"spellings": [...], "why": "...", "instead": "..."}`; a pattern is a string or `{"regex": "...", "instead": "..."}` |
| `checks.memory` | `db: ""` | The index file, outside the kit (the tool refuses inside it); empty = `n/a` |
| `checks.unversioned` | `ignore: []`, `testPaths: []`, `maxListed: 40` | Globs never reported; regular expressions over working-copy paths that mark a test file; files listed per working copy |
| `checklist` | eight items: four at every level, episodic log, closing record and the new-files/two-commits line from level 2, card decision at level 3 | The by-hand exit checklist printed at the end (the closer ticks it in the closing answer). An item is a text (every level) or `{"text": "...", "level": n}` (printed from level `n` on) |

The fictional, complete example: [`close.example.json`](close.example.json).

## Exit codes

| Code | Meaning |
|---|---|
| 0 | Clean, or findings while warn-only (the summary line counts them) |
| 1 | `--strict` (or `"mode": "strict"`) and at least one finding at level `fix` |
| 2 | Usage or configuration error: unknown option or check, a configuration that is not valid, a root that does not exist |

`NOT RUN HERE`, `n/a` and `skip` never change the exit code: they are written lines, not
passes and not failures.

## Tests

```text
cd runtime/close
python -m unittest discover -s tests
```

Everything runs in temporary folders (set `TMP` / `TMPDIR` to choose where): a throwaway
git knowledge base with a workspace and one tenant project, a second working copy beside
it, and, when `svn` and `svnadmin` are on PATH, a `file://` svn repository with its
checkouts - otherwise the svn tests are skipped with the reason. The registry and memory
tools are the kit's own, run for real; `validate-registry.ps1` runs where PowerShell is on
PATH, otherwise that one test is skipped and the "not run here" path is tested with a
missing executable.

Covered: every spelling of a retired location and the neighbours that must not match; the
configuration entries and their refusals; Scope lines of touched documents only (aliases,
case values, a fenced line, two lines, an unknown value, an excluded template); the Scope
line read after a 60-line front matter of claims (closed by `---` or `...`, after a BOM), a
Scope line inside the front matter not counted, the 50 lines never more than 50 after it, an
unclosed or over-long front matter read from the top; warn-only,
`--strict`, strict by configuration and a check lowered to `warn`; unversioned files in two
working copies, ignored files (`.gitignore`, `svn:ignore`, the `ignore` globs), a new folder
expanded, files generated during the run; fix and tests listed apart (git and svn); the test
gate (no evidence, a `not run here:` line, one warning per evidence file however often its
line repeats - parts listed on it, a placeholder `exempt:` refused, an index row, an
explicit `--ticket`); retired pointers in normative files only, with history lines,
superseded files and the configuration itself left out; a missing decision cited (git and
svn), `--dry-run` writing no index; the ledger; the memory index with the consolidation
flag; validate-registry drift and its absence; a root outside version control; every
configuration refusal; the example configuration; `svnClientIgnored` (EK#17) with an svn
client configuration (`--config-dir` at a scratch folder) that hides every `.md` - off: the
hidden document is in neither check; on: a Scope finding and an unversioned file, a
repository-ignored document still out, the notes; a working copy's own value both ways; the
registry tools' notes; no effect on git. The adoption level
([`tests/test_close_levels.py`](tests/test_close_levels.py)): level 3 by default with every
check and the eight checklist items; level 1 leaving out the test gate, the memory index and
the validator (the projects check still runs), level 2 only the memory index and the
validator; the checklist items of each level (four, seven, eight) and a configured
checklist with levels; at level 1 one note for the unversioned files, their list in the
output and the summary, a warning per file again at level 2; a working copy with no first
commit yet - one note at levels 1, 2 and 3 with its list and summary, a file already added
counted, a base folder inside a repository whose commits are elsewhere, a new code tree
beside a committed base (its note, the fix and test groups, the base's own warning) - and a
warning per file once the first commit exists, on git and on svn (a checkout of an empty
repository; a commit read before any update); `--level` over the
configuration; a level or a checklist item that is not valid refused. The frozen sources:
the frozen draft and a second draft noted, never a finding; a case's own frozen file; the
default turned off; a changed frozen source a finding (`--strict` exits 1); the owner's
original recognised by its bytes at the root and in `HISTORY/` while the copy is committed,
an owner's answer listed by path, an edited original a finding again, no twin without a
frozen source; a document with its Scope line never read as a twin; the validator's full
sweep given the same list plus the original. Last run: 67 tests (14 retired-location rules,
42 on git, 11 on svn), all passing, none skipped, on Windows 11 with Python 3.14, git 2.53,
svn 1.14 and Windows PowerShell 5.1. Not run: Python 3.8 itself (the code keeps to its
standard library), PowerShell 7, Linux and macOS.

## Techniques

| # | Technique | Maturity ([labels](../../docs/MATURITY.md)) | Here |
|---|---|---|---|
| T45 | Single closing step + close script: the closer writes the texts, then one call runs the mechanical checks | operating | `close.py` (the closer: [`close-and-retain`](../../skills/close-and-retain/SKILL.md)) |
| T88 | Retired-location guard: normative files never point at a retired location, in any spelling; the locations are data | operating | `retired.py`, check `retired` |
| T78 | Change packaging: nothing unversioned at hand-over; fix and tests apart (the warning half; the method is the skill's) | operating | check `unversioned` |

## Portability limits

- svn: `svn status` hides what a client's `global-ignores` setting ignores (a knowledge
  base once hid every new `.md` that way), and by default the `scope` and `unversioned`
  checks see what it shows - nothing says a file was hidden. A case whose clients ignore a
  document type either removes that pattern from every client or sets
  `"svnClientIgnored": true` (EK#17). With the option on, svn's built-in ignore list is
  emptied too, so object files and `*.pyc` show as unversioned unless the repository
  ignores them (`svn:global-ignores`) or `checks.unversioned.ignore` lists them; a working
  copy can keep the client list with its own `"svnClientIgnored": false`. The registry
  tools run as separate commands; with the option on, the script passes them
  `--svn-client-ignored`, so their `project:` and decision-citation checks see the same files
  (each says so in a `note`); a new folder is listed whole either way (its files are read
  from disk).
- svn changelists and git staging are not read: the `unversioned` check lists the fix and
  test groups, and the closer prepares the changelists or the staged sets
  ([packaging](../../skills/close-and-retain/references/packaging.md)).
- `validate-registry.ps1` needs PowerShell; without it that part is `NOT RUN HERE` and the
  other checks still run. The Scope check does not need it.
- The tool output is read by its line prefixes (`FIX`, `DRIFT`, `ERROR`, `WARN`, the memory
  index's `<< FLAG`); a tool that changes them must change this reader too.
- Tested on Windows only; the POSIX branches use the standard library and are untested.

## Lineage and what stayed in the case

Distilled from case two's close script (one PowerShell script, svn only, called by the
single closing agent of a multi-developer product team) and the retention habit of case
zero. Kept: one call at the end of the close; registries, the Scope line of touched
documents, the test-gate evidence as a warning only, retired locations in normative files,
the ledger, the decisions index and its citation check, the memory index with the
consolidation flag; a superseded file and a history line are not pointers; the exit
checklist printed at the end.

Changed: git next to svn through the shared adapter; every check, folder, pattern and level
is configuration; the tools are called, never copied; retired locations are written once and
their spellings derived (the source missed the UNC and forward-slash spellings); the closing
record that marks a work item as being closed is a configurable file name; the index of
tested changes is a configured list; unversioned files of every working copy and the
fix/tests split were added (the source left T78 to the agent); **warn-only by default** (the
source exited 1 on any item to fix and kept only the test gate as a warning); not run here and
not configured are written lines; the source always emptied its clients' ignore list for its
listing, here the same override is an option, off by default (EK#17).

Left in the case: how its test suite's index was found from a core line's path, the rule that
its tests working copy holds no documents, its fixed knowledge-base path, its tool folder
layout, its own retired locations and the work-item tab file that marked a ticket as closing.
