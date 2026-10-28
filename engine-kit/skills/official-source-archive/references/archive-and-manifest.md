# Archive layout, retrieval and the manifest

**Scope**: method

Companion of [the official-source archive skill](../SKILL.md), steps 3, 4 and 7. Fictional
values throughout: Acme Retail's archive of the regulator's e-receipt specification.

## Layout

One folder per issuing party, inside the knowledge mirror of the project that must obey
it. Sub-folders by kind of document keep a large archive readable; a small one can be flat.

```text
<project>/SOURCES/regulator-e-receipts/
  README.md                         the front page (templates/ARCHIVE_README.template.md)
  CHECKS.md                         the checks file (templates/OFFICIAL_CHECKS.template.md)
  MANIFEST.csv                      one row per archived file (the tool below)
  manual/
    manual-v7-00-overview.pdf       as published
    manual-v7-00-overview.txt       its text copy
  amendments/
    an-2026-03-v1-20.pdf
    an-2026-03-v1-20.txt
  bundles/
    schemas-v1-04.zip               as published (hashed)
    schemas-v1-04/                  extracted beside it (excluded from the manifest)
  notices/
    portal-notice-2026-11-02.txt    a transcription: address, date read, the text
  data/
    endpoints-2026-11-02.json       official data, one dated reading
```

`SOURCES/` is a default name; the case's `AGENTS.md` placement table decides the home, like
any other folder.

## Naming

- `<issuer>-<document>-<version>.<ext>`, lowercase, dashes, the version as the publisher
  writes it (`an-2026-03-v1-20.pdf`). A date in the name only when the document has no
  version (a notice, a page read on a given day).
- The name is fixed at download. A file renamed after it was recorded is a `missing` row and
  an `unrecorded` file: rename before `record`, never after.
- A new version is a new file. The old one stays, because closed checks cite it.

## Retrieval

- **The go first**: the download list (name, source address, size and type from a
  header-only request, the checks it serves) is approved by the owner before anything is
  fetched.
- **Verification on**: TLS certificate verification is never disabled. A server that fails
  verification intermittently is retried and the failure is written in the README ("first
  attempt refused an expired certificate; the second passed; the publisher's hash
  matches"). A trust store that lacks the issuing party's root is fixed by using a client
  that has it, not by skipping the check.
- **"Needs a browser" often means "needs a cookie jar"**: a portal that answers with
  endless redirects may only be testing for cookies. A client that keeps cookies between
  requests is enough; record how each source was fetched.
- **The publisher's hash**: when the publisher prints a hash for a file, compare it at
  download and record it in the manifest (`publisher_hash`, as `sha512:<hex>`).
- **A page with no file** is transcribed: the address, the date and time read, and the text
  of the parts the archive uses, word for word, with a line saying what was left out.
- **Official data** shown as a page (a table of endpoints per region, a code list): save the
  reading as a dated raw file (JSON or CSV) and derive the human table from it. The code
  that needs the data versions it with the date of the reading; a change is a new reading
  and a diff, never an edit by hand.

## Text copies

- Beside each document: same name, `.txt`, UTF-8. Record the extraction command and its
  mode in the manifest's `method` column: a layout-preserving mode and a reading-order
  ("raw") mode give different line numbers and fail in different ways
  ([format-traps.md](format-traps.md)).
- The archived text copy is the one line numbers point into. A copy in another mode,
  extracted to check one trap, is cited as such ("raw mode, p.75") and is not archived
  over the first.
- Spreadsheets and word-processor files get a text copy too (one sheet or section after
  another, with its name as a heading); a schema or a data file is already text and needs
  none.

## The manifest

`MANIFEST.csv`, UTF-8, LF, one header row:

| Column | Filled by | Meaning |
|---|---|---|
| `file` | tool | path inside the archive, forward slashes |
| `kind` | tool | `source` (a file as published), `text` (the text copy of a source beside it), `transcription` (a `.txt` with no document beside it: a transcribed page, or a text file as published) |
| `bytes`, `sha256` | tool | size and hash when recorded |
| `text_copy` | tool | the text copy expected beside a document (`.pdf`, `.docx`, `.xlsx`, `.html` and the like) |
| `title` | person | the document as people name it ("Amendment note 2026.03 v1.20 - receipt totals") |
| `origin` | person | the address it came from (required for sources and transcriptions) |
| `retrieved` | person | the date it was fetched or read (required for sources and transcriptions) |
| `method` | person | for a text copy: the extraction command and mode (required); for a source: how it was fetched, when it was unusual |
| `publisher_hash` | person | `<algorithm>:<hex>` as the publisher printed it; `verify` recomputes it |
| `recorded` | tool | the date the row was added |

The README's table (file, document, bytes, the first 16 characters of the hash, origin) is
for people; the manifest is what the tool checks. Keep both in step: write the README row
from the manifest row.

### The tool

[`runtime/sources/archive_manifest.py`](../../../runtime/sources/README.md) - Python 3.8+, standard
library only. It reads every file and writes only the manifest; it never deletes, renames
or edits an archived file. Paths below are from the kit's root.

```text
python runtime/sources/archive_manifest.py record <archive> [--manifest FILE]
       [--exclude GLOB ...] [--needs-text .pdf,.docx,...] [--date YYYY-MM-DD]
python runtime/sources/archive_manifest.py verify <archive> [--manifest FILE]
       [--exclude GLOB ...] [--needs-text .pdf,.docx,...]
```

- Markdown files (the README, the checks file) and the manifest itself are skipped: they
  are the archive's notes, not its content. `--exclude` skips the extracted copy of a bundle
  (`bundles/*/*`), whose bundle is hashed.
- Exit codes: `0` nothing to report; `1` findings (for `record`: a recorded file changed and
  its row was left as it was); `2` usage.
- Tests: `python -m unittest discover -s runtime/sources/tests`.

### Findings and what to do

| Finding | Means | Do |
|---|---|---|
| `changed` | the file's bytes differ from its row | find out who changed it and why; restore the published file, or archive the new one as a new version under a new name. Never re-hash in place |
| `changed ... line endings only` | the checkout converted line endings | mark the archive binary in version control (below), then check it out again |
| `changed` on a `text` row | the text copy was regenerated | line citations into it may have moved: re-extract with the recorded `method`, or re-check every row that cites it |
| `missing` | the row's file is not on disk | restore it; a superseded file stays in the archive |
| `unrecorded` | a file with no row | run `record`, then fill in its provenance |
| `no-text-copy` | a document with no `.txt` beside it | extract it, record the method |
| `incomplete` | provenance not filled in | fill in `origin` and `retrieved` (sources, transcriptions) or `method` (text copies) |
| `publisher-mismatch` | the file does not match the hash its publisher printed | do not use it; fetch it again; if it still differs, ask the publisher - and write it down |

## Version control

The archive's bytes must stay as published. A checkout that converts line endings or
encodings changes them, and every hash then looks tampered with - this happened in the
source case to a published hash list stored as text.

```text
# git: <archive>/.gitattributes
* -text
```

```text
# svn: no svn:eol-style on the archive's files; check the auto-props of the working copy
svn propget svn:eol-style -R <archive>
```

Large binaries the repository should not carry can live in a file store; the manifest stays
in the knowledge base, and its hashes still prove which bytes were read.
