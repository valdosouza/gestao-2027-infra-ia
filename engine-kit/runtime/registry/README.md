# Registry tools - decision registers, project inventory, ledgers

**Scope**: method

Three scripts that keep a multi-project knowledge base (KB) honest, plus the small VCS
adapter they share. Python 3.8+, standard library only. Every path and name comes in as
configuration; nothing here knows a case. Towards version control they are read-only:
they run `git status` / `svn status` and never commit, add, update or revert. Generated
files are case files: the scripts refuse to write them inside the kit folder.

## Scripts

| Script | Job | Inputs | Example | Technique |
|---|---|---|---|---|
| [`decisions_index.py`](decisions_index.py) | One home register per namespace (`KEY#N`) -> generated cross-project index. Fails on a duplicate number, a row without an ISO date, an unknown key in "Applies to". `--check-touched`: a cited `KEY#N` must exist (failure), and so must its front-prefixed alias `D-KEYN` ([below](#ids-and-the-front-alias)); `Q-`/`A-` ids are not decisions, nor is a "next free ids" item ([below](#ids-and-the-front-alias)); a bare "decision N" not in the document's own register warns (the plural "decisions N" is a count, as in a copied tool summary, and is not read). `--init KEY` creates a register from the template | `--root` / `KB_ROOT`, `--projects`, `--out`, `--register`, `--root-register`, `--dry-run`, `--init KEY`, `--template`, `--check-touched`, `--vcs` | `python runtime/registry/decisions_index.py --root <kb-root> --check-touched` | T22 |
| [`projects_check.py`](projects_check.py) | Project inventory, both ways: every folder matched by the root globs has a registry row, every row has a folder; no duplicate key or folder. `--check-touched`: a touched log/card/pipeline/ticket doc declares `project:` matching its folder (missing key: warning, failure from `--enforce-from`). `--check-scope --project KEY`: fails when the change set touches another tenant's project. Also the library the other two import | `--root`, `--projects`, `--root-glob` (repeatable), `--paths-base`, `--write`, `--check-touched`, `--enforce-from YYYY-MM-DD`, `--check-scope`, `--project KEY`, `--vcs` | `python runtime/registry/projects_check.py --root <kb-root> --check-scope --project ACME-2.1` | T87, T86 |
| [`ledger_gen.py`](ledger_gen.py) | Generated "what was archived when" ledger per project + a cross-project view - logs, cards, pipelines, rules, plans, ticket documents, and an area's analysis document and hypothesis register ([kinds map](#the-kinds-map-of-the-ledger)); row date from front matter, else file name, else mtime (marked `~`); `--changed` regenerates only the projects with pending changes under their subject folder | `--root`, `--projects`, `--root-glob`, `--kinds FILE`, `--ledger PATTERN`, `--ledger-all FILE`, `--project` (repeatable), `--changed`, `--cross-index`, `--index-only`, `--dry-run`, `--vcs` | `python runtime/registry/ledger_gen.py --root <kb-root> --changed` | T04 |
| [`vcs.py`](vcs.py) | Adapter: detects git or svn (nearest `.git` / `.svn` above the root, or `--vcs`), lists changed files as `A` added, `M` modified, `?` unversioned (folders expanded), `D` deleted/missing; ignored files are never listed ([below](#ignored-files-repository-and-client)). `has_commit(root)`: false while nothing under the root was ever committed (git: no `HEAD`, or no file under the root in `HEAD`; svn: no node under it with a commit revision above 0) - the close script's "first commit waits for the release word" note ([close README](../close/README.md#adoption-levels)). Its CLI shows what the tools see | `--root`, `--vcs auto\|git\|svn`, `--md-only`, `--deleted`, `--svn-client-ignored` | `python runtime/registry/vcs.py --root <kb-root> --md-only --svn-client-ignored` | - |

Exit codes of all four: `0` clean, `1` drift or failure, `2` usage, configuration or VCS
error. `--root` falls back to `KB_ROOT`.

## The layout the tools expect

```
<kb-root>/
  _REGISTRY/PROJECTS.md       projects registry: rows + configuration (front matter)
  _REGISTRY/DECISIONS-INDEX.md  generated (decisions_index.py)
  _REGISTRY/LEDGER-ALL.md     generated (ledger_gen.py)
  DECISIONS.md                root register of the workspace row (Path ".")
  <any folder>/<project>/     a project: found by root_globs, named by its row
    _REGISTRY/DECISIONS.md    the project's register
    _REGISTRY/LEDGER.md       generated ledger
    SUBJECT/<NAME>/MEMORY | KNOWLEDGE | PIPELINES | RULES | PLANS | TICKETS/<ID>/...
```

Every name above is a default that the configuration below can change. Start the two
hand-kept files from [`REGISTRY_PROJECTS.template.md`](../../templates/REGISTRY_PROJECTS.template.md)
and [`DECISIONS.template.md`](../../templates/DECISIONS.template.md) (`--init KEY` fills the
second one).

## The projects registry

The first table whose header has a `Key` column and a `Path...` column is the
inventory (optional columns: `Type`, `Name`, `Code tree`, any others). The key is in
backticks; Path is relative to `paths_base` (default: the KB root). The row whose Path
is `.` is the **workspace**: its register is the root register. Keep Path the last
backticked cell, so [`memory_index.py`](../memory_index.py) `--projects` reads the same
file. A **tenant** is a row whose Type is listed in `tenant_types`: tenants are isolated
from each other; any other type (shared code, a core product) may be touched by any change.

Configuration lives in the registry's front matter; a command-line option wins. Relative
values are relative to the KB root; patterns take `{path}` (the project folder, KB-root
relative) and `{key}`.

| Key | Default | Used by | Meaning |
|---|---|---|---|
| `root_globs` | none | inventory, ledger | Globs of project-root folders (`projects/*`, `tenants/*/*`). Without them the folder -> row direction is not checked (warning) |
| `paths_base` | `.` | all | Folder the Path cells are relative to |
| `subject_dir` | `SUBJECT` | touched, ledger, `--write` | Folder of a project that holds `<NAME>/MEMORY`, `KNOWLEDGE`, ... |
| `project_scoped` | `MEMORY, KNOWLEDGE, PIPELINES, SETTINGS, TICKETS` | `--check-touched` | Folders whose documents must declare `project:` |
| `enforce_from` | empty (warn-only) | `--check-touched` | From this day a missing or unknown `project:` fails |
| `tenant_types` | `tenant, customer` | `--check-scope` | Types that are isolated tenants |
| `scope_exempt` | `*/_REGISTRY/*`, `*/_INDEX/*`, `*/graphs/*`, `*/~$*`, `*.db` | `--check-scope` | Files that never count as touching a project (generated registers, graphs, lock files) |
| `decision_register` | `{path}/_REGISTRY/DECISIONS.md` | decisions | Register of a project |
| `root_register` | `DECISIONS.md` | decisions | Register of the workspace row |
| `decisions_index` | `DECISIONS-INDEX.md` next to the registry | decisions | Generated index |
| `ledger` | `{path}/_REGISTRY/LEDGER.md` | ledger | Per-project ledger (may be absolute, e.g. `<runtime-area>/{key}/LEDGER.md`) |
| `ledger_all` | `LEDGER-ALL.md` next to the registry | ledger | Cross-project view |
| `ledger_kinds` | built in | ledger | JSON kinds map (below) |
| `registers` | `_REGISTRY/LEDGER.md, REGISTRY_SUBJECTS.md, REGISTRY_GRAPHS.md` | `--write` | Extra register files shown in the generated "registers present" block |
| `scope_value` | `case` | decisions, ledger | Scope written into generated files and new registers |

Profile ([EK#5](../../DECISIONS.md)): a `team` profile versions the generated index and
ledgers inside the KB (the defaults); a `solo` profile points `decisions_index`,
`ledger` and `ledger_all` at a runtime area outside the versioned KB, written relative to
the KB root, never an absolute path: a folder inside the KB that version control ignores
(`.runtime/...`, ignored by `.gitignore` or by `svn:ignore` on the KB root,
[EK#27](../../DECISIONS.md)) or a folder beside it (`../<runtime-folder>/...`). An ignored
folder never reaches the change set the tools read (`--check-touched`, `--changed`), and a
dot-named one is never matched by `root_globs` as a project folder; how to set the ignore
rule: [profiles/solo.md](../../profiles/solo.md#a-runtime-folder-inside-the-base).

## Ids and the front alias

A decision id is `KEY#N` ([EK#4](../../DECISIONS.md)): `KEY` is a row of the projects
registry and `N` a number of that row's register. A namespace is a project or a front, so
a **front that keeps its own register is a row too** (any Type, for example `front`, its
Path the front's folder, its register at `decision_register`); a front known only by its
prompt is still a namespace for people, but the tools cannot check its ids.

What `--check-touched` reads in a touched markdown document:

| Written | Read as | Checked |
|---|---|---|
| `XY#2` | decision 2 of `XY` | yes, for every registered key: not in the register = failure; `XY` without a register yet = warning |
| `D-XY2` | the same id as `XY#2` (front-prefix alias) | the same way, when `XY` is a registered key that does not end in a digit (`D-ACME-2.17` cannot tell key from number: write `ACME-2.1#7`); an unregistered prefix is ignored |
| `Q-XY5`, `A-XY3` | a question, an assumption | never: they are not decisions |
| `decision 14`, `decision 14 (ACME)` | the document's own register, or the only key whose first segment is the tag | warning only |
| `**Next free ids**: XY: 18 · Q-XY: 40 · A-XY: 15` (an older block: `XY#18, A-XY15`) | the ids a session takes next ([`RESUME_BLOCK`](../../templates/RESUME_BLOCK.template.md)): they do not exist yet | never - that item only; the rest of its line is read (below) |

**Next free ids.** The resume block writes the next numbers as `XY: 18`, which the check
never reads; an older block that still writes `XY#18` names a decision that is by definition
not in the register, so the check also leaves that item out - the item only, never the rest
of its line:

- **Where it starts**: at a `Next free ids` label at the start of a line (any case, after
  `>` quote markers, a list marker and `**` / `__` bold; the line's start is left out with
  it), or at a mid-line `Next free ids:` label (the paste-ready prompt's form).
- **Where it ends**: at the end of its sentence (`.`, `!` or `?` followed by a space or the
  end of the line; the point inside `ACME-2.1#7` is not one), plus a `Reserved:` sentence
  right after it (the resume block's reserved ranges). When the label sits inside a code
  span or a table cell, the item also ends where the span or the cell ends. When the
  sentence wraps, the following lines are left out until it ends, a blank line, or a new
  block (a list item, a heading, a table row, a `**Label**:` line).
- **Everything else is read**, the rest of the item's own line included: in
  `Next free ids: XY#18. The refund rule follows XY#7.` the second sentence is checked, and
  so is a quoted label's neighbour in ``| `Next free ids: XY#18` passed, but XY#19 failed |``.

The label is matched in English only, like the column names the tools read: a case that
writes its documents in another language keeps this label in English.

The alias is case-sensitive and must stand alone (`AD-XY2`, `#D-XY2`, `D-XY2a` are not
citations); in a range such as `D-XY5…D-XY8` the two ends are checked. Register rows
keep plain numbers (`2`); the alias is a way of citing, not of numbering. Reserved
ranges and reconciliation tables for parallel sessions are written in the register by
people ([`decision-rounds`](../../skills/decision-rounds/SKILL.md)); the tool does not read
them, and the numbers they leave unused show as gaps (informational) in the index.

## The kinds map of the ledger

A JSON object; every key is optional and replaces the built-in value:

```json
{
  "folders": {"MEMORY": "log", "KNOWLEDGE": "card", "PIPELINES": "pipeline",
              "RULES": "rule", "PLANS": "plan", "PLAN": "plan"},
  "ticket_folder": "TICKETS",
  "ticket_subfolders": {"REVIEW": "ticket-review", "TESTS": "ticket-test"},
  "ticket_files": [["*analysis*", "ticket-analysis"], ["*worklog*", "ticket-worklog"]],
  "ticket_default": "ticket-doc",
  "area_files": [["hypotheses.md", "hypotheses"], ["*analysis*", "analysis"]],
  "area_links": {"analysis_document": "analysis"},
  "date_keys": ["date", "last_updated", "review_date", "generated", "migrated"],
  "skip_dirs": ["attachments", "evidence", ".obsidian"],
  "skip_files": ["INDEX.md"]
}
```

`folders` maps the first folder under `SUBJECT/<NAME>/` to a kind; a document under
`<ticket_folder>/<ID>/` carries the ticket id and takes the kind of its sub-folder, else
of the first matching file-name glob, else `ticket_default`. A case adds its own
document types here (for example `["*dev_tab*", "ticket-devtab"]`).

A document **at the root of an area** (`SUBJECT/<NAME>/<file>.md`) takes the kind of the
first `area_files` glob its name matches, else the kind of an `area_links` key: a front
matter key of another area-root document whose value (a relative path or a markdown link)
names it. By default that is the legacy assessment: the hypothesis register `HYPOTHESES.md`
and the analysis document beside it - found by a name containing `analysis`, or named by the
register's `analysis_document` key whatever its language
([`assess-legacy-repo`](../../skills/assess-legacy-repo/SKILL.md)). Any other area-root file
(the area's `INDEX.md`, loose notes) is not ledgered.

## Gates

The scripts report and exit `1`; whether that blocks is the caller's choice. Hooks and
gates ship warn-only ([EK#6](../../DECISIONS.md)): a project makes one blocking by its own
numbered decision. `enforce_from` is the dated switch for the front-matter rule: warn
while the convention is being adopted, fail from the announced day.

A typical task close, in this order - or in one call,
[`../close/close.py`](../close/README.md), which runs these:

```
python runtime/registry/projects_check.py --root <kb-root> --check-scope --project <KEY>
python runtime/registry/projects_check.py --root <kb-root> --check-touched
python runtime/registry/decisions_index.py --root <kb-root> --check-touched
python runtime/registry/decisions_index.py --root <kb-root>
python runtime/registry/ledger_gen.py --root <kb-root> --changed
```

## Ignored files: repository and client

`vcs.py` lists what `git status` / `svn status` list, so an ignored file is never a change.
Two owners can ignore a file, and only one of them is the repository's:

| | Repository (versioned, the same for everyone) | Client (this machine's configuration) |
|---|---|---|
| svn | the `svn:ignore` property (one folder) and the inherited `svn:global-ignores` property | `global-ignores` in the user's svn `config` file - or svn's built-in list (object files, `*.pyc`, editor backups) when the file sets none |
| git | `.gitignore` files | `.git/info/exclude` and the global excludes file (`core.excludesFile`) |

**The limit.** A client ignore list hides files the knowledge base needs: in case two a
client's `global-ignores` hid every `.md`, so the touched-document checks (Scope line,
`project:`, decision citations) and the unversioned-file check were blind to every new
document, and nothing said so. Only an unversioned file can be hidden: a versioned file is
listed when it changes whatever the ignore lists say, and an unversioned folder is listed
whole (its files are read from disk, no ignore list applies).

**The option, svn only** ([EK#17](../../DECISIONS.md), opt-in, off by default):
`changed_files(..., svn_client_ignored=True)` or `vcs.py --svn-client-ignored` runs
`svn status --config-option config:miscellany:global-ignores=` - the client's list is emptied
for that one call, nothing is written to any configuration. A file only the client hides is
then listed as `?` (unversioned); a file the repository ignores stays hidden, so the two
owners are told apart in one call, at the same cost as before. What the option shows, then,
is every unversioned file the repository does not ignore - svn's built-in list included, so
object files and `*.pyc` appear too unless the repository ignores them (`svn:global-ignores`
is the place for a list that everyone shares). It does not mark which of the `?` files the
client hid: compare with a run without the option. Off by default because the client's list
is the user's own choice and most cases rely on it; the case turns it on in its
configuration ([`../close/close.py`](../close/README.md): `"svnClientIgnored": true`). Every
registry tool takes the same flag through the shared `--vcs` arguments (`projects_check.py
--check-touched`, `decisions_index.py --check-touched`, `ledger_gen.py --changed`), and the
close script passes it when the option is on.

An explicit `svn add --parents <file>` adds a file the client ignores; a recursive
`svn add --force <folder>` skips it.

**Git: no option.** `git status --ignored` lists every ignored file without saying whose
rule hid it - the repository's `.gitignore` (build output, dependencies) as much as the
client's - so it would flood the checks rather than tell the two apart; neutralising only the
client half would need a configuration override for `core.excludesFile` and cannot reach
`.git/info/exclude`. No case has been hit on git. To see why a file is hidden there,
`git check-ignore -v <file>` names the file and line of the rule.

## Tests

```text
cd runtime/registry
python -m unittest discover -s tests
```

[`tests/test_vcs.py`](tests/test_vcs.py) builds a throwaway `file://` svn repository whose
client configuration (`--config-dir` at a scratch folder) hides `*.md` and whose repository
ignores `*.tmp`, `draft-*.md` (`svn:ignore`) and `*.bak` (`svn:global-ignores`), and a git
repository whose global excludes file hides `*.md`; the machine's own svn and git
configuration is never read. Covered: by default the client-hidden files stay hidden (the
command is unchanged); with the option they are listed as `?` while every repository-ignored
file stays hidden; a modified versioned file and a new folder are listed either way;
`--md-only` with the option; the CLI and its summary note; git unchanged by the option;
`has_commit` on git (no `HEAD`, a `HEAD` with nothing under the folder, an added folder, the
folder committed, a folder outside any repository refused) and on svn (a checkout of an
empty repository at revision 0, an unversioned and an added folder, a commit read before
any update, the folder committed). Set
`TMP` / `TMPDIR` to choose where the scratch folders go; skipped with the reason when `svn`
and `svnadmin` (or `git`) are not on PATH.

[`tests/test_decisions_index.py`](tests/test_decisions_index.py) covers the "next free ids"
rule of `--check-touched`: the label at the start of a line (bold, `__` bold, a list item, a
quote, any case), the mid-line label, a wrapped item left out to the end of its sentence, a
blank line or a new block ending it, lines that only mention free ids still read; the rest
of the item's line read after its sentence, a `Reserved:` sentence left out with the item, a
code span or a table cell ending it, a decimal point in an id not ending it; then the
command on a throwaway git knowledge base: a resume block passes, a real missing citation in
the same document still fails, and so does one on the label's own line (after the item, and
beside a label quoted in a code span in a table row).

[`tests/test_ledger_gen.py`](tests/test_ledger_gen.py) covers the area-root documents of
the ledger: the analysis document found by its name and by the register's
`analysis_document` key, the register itself, the area index and an unknown area-root file
left out, a case's own `area_files` and `area_links`, and the generated ledger's rows.

Last run: 23 tests (8 vcs, 11 decisions, 4 ledger), all passing, on Windows 11 with Python
3.14, svn 1.14 and git 2.53. The other scripts are exercised through the close script's
tests ([`../close/README.md`](../close/README.md#tests)).

## Dropped as case-only

- The case's layout formula for project roots (fixed product and client folder shapes),
  replaced by `root_globs`; the fixed `source/` base and the hard-coded root path,
  replaced by `paths_base` and `KB_ROOT`.
- The fixed workspace key name: any row with Path `.` is the workspace.
- The business-rules section of the register skeleton (a case's rule-history workflow
  and the decisions that defined it).
- The case's ticket-document kinds (work-item tab, review brief, implementer context,
  ticket index files): now entries a case may add to the kinds map.
- The fixed list of registers in the inventory block (people, planning sheets,
  environments, settings): now `registers`.
- The hard-coded enforcement date: now `enforce_from` / `--enforce-from`, empty by default.
- References to the case's close script, nightly job and planning documents.

## Lineage

Ported in kit 0.7 from one case, a team knowledge base of about thirty projects. On that
base the port reproduces the source's inventory, decision counts (same rows parsed),
ledger row totals and touched-file results exactly. Changes against the source:
VCS-neutral (git and svn behind `vcs.py`, which also fails loudly where the source
silently treated an svn error as "nothing changed"); a `project:` key resolves to the
longest matching project folder (the source took the last table row that matched); a
cited `KEY#N` is matched only for registered keys, so keys of any shape work; a
deletion in another tenant's project now counts for `--check-scope`; `--init` can also
create the root register; the ledger reads block-list front matter and a scalar
`tickets:`; a register's fenced code is ignored. Wave 1 added the front-prefixed alias
`D-KEYN` to the citation check, from case zero's front prompts.
