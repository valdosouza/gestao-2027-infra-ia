# Migration tools - a manifest-driven merge and the retirement gate

**Scope**: method

The tool half of [docs/MIGRATION.md](../../docs/MIGRATION.md): a migration that moves an
old store into a knowledge base by manifest, with a dry run and without fixing content
(T61), and the gate that decides when the frozen old store may be retired (T89). Python
3.8+, standard library only. Every path and name comes in as an argument or through the
configuration; nothing here knows a case. Not for business data: a legacy system's
records moving into a new platform follow
[`migration-direction`](../../skills/migration-direction/SKILL.md).

Three promises hold for both tools, and the tests check them:

- **They never delete or rename anything** - not in the old store, not in the target.
  Retiring the old store is a separate, human step after the gate.
- **They run no command at all**: no version-control call, so they work the same under git,
  svn or no VCS. Adding and committing the migrated files is a human step.
- **They never write inside the old store or inside the kit folder.** A dry run does not
  write inside the target either.

## Files

| File | Job | Inputs | Example | Technique |
|---|---|---|---|---|
| [`migrate.py`](migrate.py) | One manifest row per file of the old store -> its place in the target. Markdown keeps its body byte for byte (line endings and BOM included) except links to other rows, configured address rewrites, provenance keys and a missing Scope line; other files are copied as they are; a target that already exists keeps its body and gains only missing keys. Dry run by default into a fresh staging folder; `--apply` writes into the target, `--batch` one batch at a time. Writes a migration log (markdown + CSV) with blocking problems, notes, unresolved links, collisions and a stratified spot-check sample | `--source`, `--target`, `--manifest`, `--config`, `--staging`, `--report-dir`, `--date`, `--batch` (repeatable), `--apply` | `python runtime/migration/migrate.py --source <old-root> --target <kb-root> --manifest <manifest.csv> --config <migration.json>` | T61 |
| [`retire_gate.py`](retire_gate.py) | `snapshot` records the frozen old store (size, time, SHA-256 per file); `check` reports drift since then (added, modified, deleted - by content, not by time), each item with its new location and its ruling; `rule` records one human ruling (import or discard, who, why) for the item's current bytes. Green at zero drift or when every item carries a current ruling | `--old`, `--config`, `--manifest`; `snapshot`: `--out`, `--freeze-date`, `--force`; `check`: `--snapshot`, `--rulings`, `--report`, `--json`; `rule`: `--snapshot`, `--rulings`, `--path`, `--ruling`, `--by`, `--reason`, `--date` | `python runtime/migration/retire_gate.py check --old <old-root> --snapshot <snapshot.json> --rulings <rulings.json>` | T89 |
| [`migration_common.py`](migration_common.py) | Shared: configuration defaults, the manifest reader, safe relative paths, the write guards | - | - | - |
| [`migration.example.json`](migration.example.json) | The configuration of a fictional base: an order-handling product's old notes folder moving into a team knowledge base | - | copy it next to the case's manifest | - |
| [`manifest.example.csv`](manifest.example.csv) | The manifest of the same fictional base; one row has no target on purpose, so its dry run shows a blocked row | - | - | - |
| [`tests/`](tests/test_migrate.py) | 36 unittest tests on the fictional base (24 for the migration, 12 for the gate) | - | `python -m unittest discover -s tests` | - |

Exit codes of both tools: `0` done (every selected row migrated or staged; the gate is
green; the snapshot or the ruling recorded), `1` something needs a person (a selected row
is blocked, a leftover survived; drift without a current ruling), `2` usage, configuration,
or a location the tool refuses to write.

## The manifest

A CSV file with a header row, one row per file of the old store. It is the case's file:
keep it next to the case's plan, outside the kit.

| Column | Required | Meaning |
|---|---|---|
| `source` | yes | Path relative to the old store's root (`/` or `\`); never absolute, never above the root |
| `target` | yes, may be empty | Path relative to the target's root. **Empty means the owner has not decided**: the row is blocked and listed, never guessed |
| `batch` | no | Group applied together (`--batch`); the run order comes from `batch_order` |
| `kind` | no | Selects a profile in `kinds` (what to add, whether to copy) |
| `note` | no | Free text, for people |
| any other | no | Ignored by the tool, kept in the file |

`columns` in the configuration renames them. A row is **blocked** - listed under
*Blocking problems*, not migrated, exit `1` - when it has no source or no target, a
source that is not a file, an unsafe path (absolute, `..`, a character the file system
refuses), the same source or target as an earlier row (targets compared without case), or
a target inside the old store. A blocked row is fixed in the manifest or answered by the
owner (a decision round), never by editing the content.

## The configuration

One JSON file per migration (start from [`migration.example.json`](migration.example.json));
keys starting with `_` are notes. Every key is optional.

| Key | Default | Meaning |
|---|---|---|
| `name` | `migration` | Names the log files and the default staging folder |
| `source_name` | `old` | Used by the `{source_name}` placeholder (the origin key) |
| `scope_value` | `case` | Scope line written into the generated log and drift report |
| `columns` | `source, target, batch, kind, note` | Column names of the manifest |
| `batch_order` | none | Batches in run order; others follow alphabetically |
| `markdown_extensions` | `.md, .markdown` | Files transformed as markdown; every other file is copied as it is |
| `scope_line` | none | Value of the `**Scope**:` line added right after the title when the file has none; none = never added |
| `provenance` | `origin: "{source_name}:{source}"`, `migrated: {date}` | Front-matter keys added to every markdown row when absent (also to a collision's target). Add `author` for who wrote the knowledge; set a key to `""` to drop it |
| `kinds` | none | Per kind: `transform` (`markdown` or `copy`), `scope_line` (overrides the global one), `front_matter` (extra keys added when absent) |
| `merge_keys` | none | Glob patterns (`vcs_*`): front-matter keys of the source that a collision's target gains when it lacks them |
| `rewrites` | none | `{"find", "replace", "regex"}`, applied line by line to markdown (front matter included): **addresses only** - the old store's machine root, an old prefix. A rewrite that changes meaning is a content fix |
| `leftovers` | none | Strings (case-insensitive) or `re:` patterns that must not survive in migrated markdown, such as the old root in any spelling; each hit blocks the row |
| `dedupe_identical` | `false` | Byte-identical sources migrate once (the first manifest row); the others are listed as `duplicate`, and links to them go to the first copy |
| `spot_check` | `20` | Rows in the log's spot-check sample |
| `retirement.freeze_date` | none | `snapshot` lists once the files changed after this date |
| `retirement.map` | none | Old-to-new prefixes, `{"from": "notes/orders/", "to": "projects/shop/SUBJECT/ORDERS/MEMORY/"}`; the longest matching `from` wins; `"to": null` marks a part of the old store that has no counterpart on purpose; `"from": ""` is the fallback |
| `retirement.exclude_dirs` / `exclude_files` | VCS, editor and runtime folders; OS thumbnail files | Never snapshotted. Keep the list to runtime state, so no knowledge can hide in the blind spot |

Placeholders in `provenance` and `front_matter` values: `{source}`, `{target}`, `{date}`,
`{batch}`, `{kind}`, `{source_name}`, `{name}`. Values are written as given (YAML text):
quote them when they contain a colon.

## What the migration changes, and what it does not

| Changed (mechanical) | Never changed |
|---|---|
| A relative link or wikilink to another manifest row -> that row's new place (relative links stay relative; wikilinks become target-root paths without `.md`) | Any other text: wording, headings, lists, code, ids, file names inside the text |
| A configured address rewrite | A link to a file outside the manifest, a dead link, a link inside fenced code - listed, left as written |
| Provenance keys and kind keys the front matter lacks; the block is created when the file has none | An existing front-matter key, even when the configuration would set it differently |
| A `**Scope**:` line when the file has none and `scope_line` is set | The line endings, the BOM, a file that is not UTF-8 (copied byte for byte, with a note) |
| - | A target that already exists: its body and keys win; only missing provenance and `merge_keys` keys are added |

Row statuses in the log: `migrated` (written or staged), `merged` (a collision gained
keys), `unchanged` (the target already holds the result - a second `--apply` writes
nothing), `kept` (a collision whose target differs and cannot be merged, such as a
binary: the target stays, the log says so), `duplicate`, `blocked`, `not selected`
(another batch).

## The retirement gate

The old store stays visible after the freeze, so people may still edit it. The gate
turns "is it safe to retire?" into a list a person can close.

1. **`snapshot`** at the freeze, once (`--force` to take it again on purpose). With a
   freeze date, it lists once the files that changed between the freeze and the snapshot.
2. **`check`** whenever needed: added, modified and deleted files since the snapshot,
   compared by SHA-256 (a file touched without a change is not drift). Each item gets its
   new location - the manifest row first, then the longest prefix of `retirement.map`,
   else *no mapping - decide manually* - and its ruling. `--report` writes markdown,
   `--json` the full report.
3. **`rule`** records a person's decision on one item: `import` (the change was carried
   into the new store; say where in `--reason`) or `discard` (say why). `--by` names the
   person. The ruling holds for the bytes it saw: if the file changes again, the item is
   open again.
4. **Green** at zero drift, or when every item carries a current ruling. Then a person
   retires the old store - read-only, a SUPERSEDED pointer to the new one - and the
   retired-location guard (T88) keeps normative files from pointing back at it.

The rulings file is append-only JSON; a later ruling on the same path supersedes the
earlier one:

```json
{"rulings": [
  {"path": "notes/orders/refund-rule.md", "change": "modified", "sha256": "<of the ruled bytes>",
   "ruling": "import", "by": "owner-a", "date": "2026-04-20",
   "reason": "imported into projects/shop/SUBJECT/ORDERS/KNOWLEDGE/refund-rule.md"}
]}
```

Snapshot, report and rulings are case files: keep them in the case's runtime area, never
inside the old store (the tool refuses) and never inside the kit.

## A typical run

```
# 1. dry run: staged outside both stores; the owner spot-checks the log's sample
python runtime/migration/migrate.py --source <old-root> --target <kb-root> --manifest <manifest.csv> --config <migration.json>
# 2. open rows answered in a decision round; the manifest updated; dry run again until no row is blocked
# 3. freeze the old store and snapshot it
python runtime/migration/retire_gate.py snapshot --old <old-root> --out <runtime-area>/old-store-snapshot.json --config <migration.json> --freeze-date <YYYY-MM-DD>
# 4. a last dry run on the live old store, then apply batch by batch; after each batch the
#    case's registry checks run and a person adds and commits the files
python runtime/migration/migrate.py ... --apply --batch <BATCH> --report-dir <runtime-area>/migration
# 5. until green: check, then a ruling per item
python runtime/migration/retire_gate.py check --old <old-root> --snapshot <runtime-area>/old-store-snapshot.json --manifest <manifest.csv> --rulings <runtime-area>/rulings.json --report <runtime-area>/drift.md
python runtime/migration/retire_gate.py rule --old <old-root> --snapshot <...> --rulings <...> --path <item> --ruling import --by <name> --reason "<where it went>"
```

## Dropped as case-only

From the migration of the source case:

- The old store's own layout (its folder names, its file classes, its version folders),
  the batch order of its subjects and its machine roots and drive letters: now the
  manifest, `batch_order`, `rewrites` and `leftovers`.
- The knowledge-tier front matter it generated (episodic-log claims, outcome and
  consolidation flags; card status and confidence; a ledger summary as the first body
  line): now a kind's `front_matter`, filled by the case.
- Card-id minting and the suffixing of reused ids, work-item ids read from names and
  front matter, unit names extracted as entities, the routing of attachments by work-item
  id: case transforms, kept in the case if it needs them.
- The registrations the apply wrote (area index lines, area and project registry rows):
  the case's registry tools and its closing step do that after each batch.
- The author, the new project keys and the per-file target fixes it read from an
  overrides file: now the configuration and the manifest itself.
- The fixed report location inside the knowledge base: now `--report-dir`.

From the drift check of the source case: the fixed old-store path, output folder,
old-to-new mapping and freeze date (now arguments and configuration), and the comparison
by size and modification time (now content: a checkout that only touches files is not
drift).

## Lineage

Ported in wave 3 from case two - a multi-developer product team that merged a second
developer's parallel agent runtime (about 420 knowledge files and 15 agent personas) into
its team knowledge base. Mechanisms came first; the content followed by script: the dry
run staged every row with no old-root string left and three collisions merged, and the
eight questions it raised were answered as numbered decisions before any apply. The drift
check came from the same team's retired shared folder: the snapshot was taken, and the
gate was then closed by an owner ruling on the whole store (nobody edits it again) - a
human ruling the gate allows. Changes against the sources: one neutral manifest and
configuration instead of the case's layout; link rewriting for relative markdown links as
well as wikilinks; line endings, BOM and non-UTF-8 files kept exactly; byte-identical
de-duplication made optional; per-row write guards; drift decided by content; rulings
recorded per item with the bytes they ruled on; a map that can name parts with no
counterpart.

## Tests

```text
cd runtime/migration
python -m unittest discover -s tests
```

Everything runs in temporary folders built from the fictional base; nothing reads or
writes outside them, and a static test checks that the tools contain no delete, rename or
command call.
