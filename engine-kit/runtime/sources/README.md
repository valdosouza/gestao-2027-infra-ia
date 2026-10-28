# Sources tools - the manifest of an official-source archive

**Scope**: method

The tool behind [`official-source-archive`](../../skills/official-source-archive/SKILL.md)
(technique T13): every norm the system must obey (a law, a regulation, a technical
specification, a vendor contract) is archived as the file that was published, with a text
copy beside it and one manifest row with its size and SHA-256. Line citations point into
the text copy, so the text copy is hashed too. Python 3.8+, standard library only. It reads
every file and writes only the manifest; it never deletes, renames or edits an archived
file.

## Files

| File | What it is |
|---|---|
| [`archive_manifest.py`](archive_manifest.py) | `record` adds a row for every archived file that has none and never re-hashes a file that changed; `verify` reports changed, missing, unrecorded, a document without its text copy, provenance not filled in, a publisher hash that does not match, and a file that differs only by line endings |
| [`tests/test_archive_manifest.py`](tests/test_archive_manifest.py) | unittest tests on a fictional archive |

There is no configuration file: everything is an argument. The manifest defaults to
`<archive-root>/MANIFEST.csv`.

## Run

Paths from the kit's root:

```text
python runtime/sources/archive_manifest.py record <archive-root> [--manifest FILE]
       [--exclude GLOB ...] [--needs-text .pdf,.docx,...] [--date YYYY-MM-DD]
python runtime/sources/archive_manifest.py verify <archive-root> [--manifest FILE]
       [--exclude GLOB ...] [--needs-text .pdf,.docx,...]
```

A person fills in `origin` and `retrieved` (sources and transcriptions) and `method` (text
copies) after `record`; `publisher_hash` is optional (`<algorithm>:<hex>` as the publisher
printed it). Column meanings, kinds and the archive layout:
[archive and manifest](../../skills/official-source-archive/references/archive-and-manifest.md).

## Exit codes

| Code | Meaning |
|---|---|
| 0 | nothing to report (`record`: manifest written) |
| 1 | findings (`record`: a recorded file changed and was left as it was) |
| 2 | usage error |

## Rules the tool enforces

- An archived norm is never replaced in place: a new version is a new file with a row of
  its own. A changed file is reported, not re-hashed.
- Store the archive as **binary** in version control (no line-ending conversion): in the
  source case a checkout converted one text copy's line endings and its hash stopped
  matching the published one.

## Tests

```text
python -m unittest discover -s runtime/sources/tests
```

## What stayed in the case

The archive itself, its README and checks file, and the struck-through text detector of the
source case: it needs a PDF library, and the kit's tools are standard library only, so the
method is described in [format traps](../../skills/official-source-archive/references/format-traps.md)
and not shipped.
