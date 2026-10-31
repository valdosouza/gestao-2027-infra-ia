---
name: official-source-archive
description: Use when a system must obey an external norm - a law, a regulation, a technical specification, a vendor contract - and a claim needs the official text ("what does the norm say?", "is this date still in force?"). Archives each document with a hash and a text copy; closes every check with page and line.
---

# Skill: Official-source archive (the norm as a file, every check closed with page and line)

**Scope**: method
**Maturity**: candidate

Ran in one case; optional: only a system that must obey an external norm needs it.

**When to use**: before a decision, a plan or a production rule rests on what an external
norm says - a law, a regulation, a technical specification and its amendments, a schema
package, a portal notice, a vendor's contract or API specification; when a plan carries
lines marked "check against the official"; when someone asks "what does the norm say?",
"is this deadline still in force?", "which version is current?", "where is that written?".
Also when a new version or a notice of a norm already archived comes out.
**Not for**: the legacy system's own documents and code comments - they are input, never
truth, and the [`assess-legacy-repo`](../assess-legacy-repo/SKILL.md) skill reads them;
deciding what to do when the norm contradicts a decision - that is the owner's, through
[`decision-rounds`](../decision-rounds/SKILL.md); interpreting the norm for the business -
the archive says what the text says and where, the owner (and their counsel) says what it
means.
**Real origin**: case zero - the modernization of a legacy business application whose new
platform must issue electronic documents under a government specification and call a
bank's API. Three archives of official sources were built over a few weeks: the first kept
text copies only, the later ones added a table of sizes and hashes, then the checks file
with its closing words. In one day, 65
checks were closed against the archived text by three parallel readers and the conductor:
28 adjusted a decision with new data, 2 overturned one, 5 were not covered by the official
text. A production date that the official PDF had struck through was still in its text
extraction, unmarked - and a secondary source read as text had already stated it as in
force. Re-hashing that archive while this skill was written matched every published
document against its table but one small text file, whose line endings the checkout had
converted.
**Profile**: legacy track ([profiles/legacy.md](../../profiles/legacy.md)); any project
that must obey a regulator's or a vendor's text can opt in.
**Parts**: T13 `candidate` - one case, optional ([maturity](../../docs/MATURITY.md),
[register](../../docs/TECHNIQUES.md)). The manifest tool in [`runtime/sources/`](../../runtime/sources/README.md)
is standard-library Python with tests; the struck-through detector of the source case
needs a PDF library, so it is described, not shipped
([references/format-traps.md](references/format-traps.md#the-struck-through-detector)).
**Works with**: [`decision-rounds`](../decision-rounds/SKILL.md) (the go for the downloads;
an overturned decision becomes a numbered question),
[`assess-legacy-repo`](../assess-legacy-repo/SKILL.md) (legacy claims about the norm are
checks to close here), [`conceptual-guardian`](../conceptual-guardian/SKILL.md) (a domain
object a norm defines is validated against the archived text, not against a summary),
the hypotheses register ([`templates/HYPOTHESES.template.md`](../../templates/HYPOTHESES.template.md))
for what the norm does not cover, [`front-protocol`](../front-protocol/SKILL.md) (what the
archive taught is negative knowledge), [`archive-card`](../archive-card/SKILL.md) (a closed
check that will hold for the next ticket).
**Detail**: [references/archive-and-manifest.md](references/archive-and-manifest.md) (layout,
naming, retrieval, the manifest and its tool, version control) and
[references/format-traps.md](references/format-traps.md) (how the document format misleads,
and the struck-through detector).
**Templates**: [templates/ARCHIVE_README.template.md](templates/ARCHIVE_README.template.md)
(the archive's front page) and
[templates/OFFICIAL_CHECKS.template.md](templates/OFFICIAL_CHECKS.template.md) (the checks file).
**Changelog**: 2026-10-21 - first version (wave 4), from case zero's archives of official
sources and their checks file.

---

## The principle

A claim about a norm is worth the page and line it cites, in a file nobody can change
afterwards. So the document is kept **as published, with its hash**; a **text copy** beside
it is what agents read and what line numbers point into; and every claim a decision rests on
becomes a numbered **check**, closed with one of four words and its source. One more thing
is easy to miss: **the format of the document is itself an error source** - what a text
extraction shows is not always what the page says.

Example used throughout (fictional): **Acme Retail** must issue electronic receipts under a
regulator's specification - a base manual, amendment notes that change it (AN-2026.03
v1.20), schema bundles, notices on the regulator's portal, and a list of endpoints per
region published as a web page.

| Term | Meaning |
|---|---|
| Norm | any normative source the system must obey: a law, a regulation, a specification and its amendments, a schema bundle, a notice, a vendor's contract or API specification |
| Issuing party | whoever publishes the norm: a regulator, a standards body, a vendor |
| Archive | one folder per issuing party: the norms as published, their text copies, the manifest, the README, the checks file |
| Text copy | the text extraction beside the original, same name, `.txt`; every line citation points into it |
| Transcription | a web page with no file to download, copied as text with its address and the date read |
| Check | one claim to confirm against the official text: one row of the checks file |
| Secondary source `[SEC]` | anything the issuing party did not publish: articles, forums, a vendor library's bundled copy of the schemas, a consultant's summary |
| `preview` | read on the web, not yet archived; it closes only when the document is archived with its hash and the page is checked |

## The sequence

| Step | What | Output | Stops when |
|---|---|---|---|
| 1 | [Inventory the checks](#1-inventory-the-checks-read-only) (read-only) | the checks file, every status empty | - |
| 2 | [Survey the official sources](#2-survey-the-official-sources) | the documents to fetch, each with name, source and size; facts marked `preview` | - |
| 3 | [The go for the downloads](#3-the-go-for-the-downloads) | the go, logged | always: it waits for the owner |
| 4 | [Archive](#4-archive) | files, text copies, manifest, README | a hash the publisher printed does not match |
| 5 | [Read and close every check](#5-read-and-close-every-check) | a status, the data and page and line on every row | - |
| 6 | [Route the results](#6-route-the-results) | questions, hypotheses, data written into decisions | - |
| 7 | [Keep it alive](#7-keep-it-alive) | new versions as new files; verify; reopened checks | a recorded file changed |

### 1. Inventory the checks (read-only)

Sweep the knowledge base, the plans and the legacy assessment for every claim about the
norm: lines marked "check against the official", values taken from a secondary source,
decisions that assume a limit, a code, a date or a format. Each becomes one row of the
checks file ([template](templates/OFFICIAL_CHECKS.template.md)):

- **what to check** in the official text, in words a reader can search for;
- **the decision it supports** (`KEY#N`, [`decision-rounds`](../decision-rounds/SKILL.md)) -
  a check that supports nothing is a curiosity, not a check;
- **where the claim came from** (file and line), so the closing can correct it there;
- **the wave that needs it**, so reading can follow the plan's order.

Group the rows by subject (format and schema, endpoints and transport, responses and
codes, identifiers and dates, content rules, printed output, out of scope).

### 2. Survey the official sources

Find the current documents and their versions on the issuing party's own site. Write what
the survey learned as facts marked `preview`, each with its address; anything from
elsewhere is marked `[SEC]`; anything that could not be checked says "not confirmed". The
output is the download list: for each file, its name, its source address, its size and
type (read with a header-only request before asking - nothing is downloaded yet), the
checks it serves, and why it is needed.

### 3. The go for the downloads

Downloading is an action the owner approves: the list goes to them as a decision
([`decision-rounds`](../decision-rounds/SKILL.md)), with name, source and size per file.
The go is logged with its id; files outside the list wait for another go.

### 4. Archive

| Rule | Why |
|---|---|
| One folder per issuing party, in the knowledge mirror of the project that must obey it; the home is a placement decision like any other | the archive is found where the code that obeys it is documented |
| The file **as published**: never edited, named at download (`<issuer>-<document>-<version>.<ext>`) and never renamed after it is recorded | citations and hashes point at that name |
| A **text copy** beside each document: same name, `.txt`, the extraction command and mode recorded | agents read text; line numbers need one fixed copy |
| **Size and SHA-256** of every file in the manifest; the README shows the table for people | anyone can prove later which bytes were read |
| A hash the **publisher prints** is compared at download and recorded | a mismatch stops the archive: fetch again, never keep the file |
| A **bundle** (an archive file of schemas) is kept as downloaded and extracted beside it | the bundle's hash covers what it holds |
| A **web page** with no file: a transcription with its address and the date read | a notice can change the date in force; it must be citable |
| **Official data** published as a list or a page (endpoints per region, code tables): a dated raw data file, and the derived table beside it | code versions that data with its date; a change is a new reading plus a diff, never a hand edit |
| **TLS verification is never turned off** to get a file; an intermittent certificate failure is retried and recorded | a file fetched without verification proves nothing |
| What was **not archived**, and why: out of scope, not yet published, kept in another archive, possibly superseded | the next reader does not search again, or assume it was missed |
| In version control, **the archive is binary**: no line-ending or encoding conversion | a converting checkout changes the bytes, and the hashes stop matching |

The manifest is a CSV beside the files; the tool records new rows and verifies the rest
(paths from the kit's root):

```text
python runtime/sources/archive_manifest.py record <archive> --exclude "bundles/*/*"
python runtime/sources/archive_manifest.py verify <archive> --exclude "bundles/*/*"
```

`record` adds a row for each new file (kind, size, SHA-256, the text copy expected beside
it) and never re-hashes a file that changed; a person fills in `origin`, `retrieved` and,
for text copies, `method`. `verify` reports `changed`, `missing`, `unrecorded`,
`no-text-copy`, `incomplete` and `publisher-mismatch`. Layout, naming, retrieval notes,
the columns and what to do with each finding:
[references/archive-and-manifest.md](references/archive-and-manifest.md).

### 5. Read and close every check

Every row gets one closing word and its source:

| Status | Means | The row carries | Goes to |
|---|---|---|---|
| **CONFIRMS** | the official text says what the decision assumed | the source | the decision cites it |
| **ADJUSTS** | the decision holds, with data it did not have | the data (value, range, code, date) and the source | the decision or the plan gets the data |
| **OVERTURNS** | the official text contradicts the decision | the quoted rule and the source | a numbered question for the owner |
| **NOT OFFICIAL** | the official text does not cover it | what was searched, and where | a hypothesis, proved in the issuing party's test environment |
| `out of scope` | recorded, not checked in this pass | the reason | - |

The **source** is the archived file, the page, and the lines of its text copy - plus the
section or rule id when there is one: `an-2026-03-v1-20.txt l.1180-1204, p.22, rule R-12`;
for a schema, `receipt_v2.xsd:56`. A row closed without page and line is not closed.

- **Only archived official sources close a row.** A web reading stays `preview`; a
  secondary source orients the search and closes nothing; a third-party component's bundled
  copy of the norm is a local hint, never a source.
- **Any row about a date, a deadline, an obligation, a threshold or a table cell** goes
  through the format traps before it closes: the struck-through check on that page, the
  position of table cells, the notices read with the documents
  ([references/format-traps.md](references/format-traps.md)).
- **When official texts disagree**, record both: the newer and more specific text wins,
  with the date it was read (a current published list over an older annex); a difference
  the publisher itself carries (the same list differs between its test and production
  environments) is kept as it is, per environment.
- **Parallel readers** split the file by subject group, with the same rules and the same
  source format; each writes only its own rows; the conductor takes the rows that cross
  groups and writes the totals in the header (`40 closed: 17 CONFIRMS, 15 ADJUSTS, ...`).
- The reader **writes what the text says**; whether the decision changes is step 6.

### 6. Route the results

- **OVERTURNS** -> a numbered question in the next round of
  [`decision-rounds`](../decision-rounds/SKILL.md): the evidence (the quoted rule and its
  source), the options, one recommendation. The reader never re-decides on the owner's
  behalf; the old decision stands until the owner answers.
- **NOT OFFICIAL** -> a hypothesis in the register
  ([`templates/HYPOTHESES.template.md`](../../templates/HYPOTHESES.template.md)), proved in
  the issuing party's test environment, with the expected result written before the run.
- **ADJUSTS** -> the data goes into the decision or the plan; the row says where it went.
- **A production rule cites its archived source.** Nothing becomes a production rule from
  a `preview` or a secondary source.
- **What the archive taught** - a format trap, a stale published file, a retrieval quirk - goes
  to the archive README's negative knowledge ([`front-protocol`](../front-protocol/SKILL.md), T12).

### 7. Keep it alive

- A **new version or a notice** is archived as a new file next to the old one; search the
  checks file for rows citing the superseded file and reopen them. The old file stays:
  closed rows still point at it.
- Run `verify` before a wave that relies on the archive. `changed` means stop and find out
  who changed the file; a norm is never corrected in place.
- A **re-read of official data** is a new dated file and a diff against the last reading;
  the code that versions that data moves with the diff.

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| A date or an obligation read from the text copy alone | struck-through text and shifted table cells read as in force | the format traps on the page before closing |
| A secondary summary used to close a row | it inherited an extraction error and stated the opposite of the norm | only archived official sources close a row |
| A row closed "per the manual" with no page and line | nobody can check it, or find it when a new version comes | archived file, page, lines of the text copy |
| A new version downloaded over the old file | closed rows now cite text that is gone | a new version is a new file |
| TLS verification turned off to get past a certificate error | the file proves nothing about who published it | retry, record the failure, keep verification on |
| A converting checkout of the archive | the bytes change; every hash looks tampered with | the archive is binary in version control |
| "The norm does not say" closed as CONFIRMS | an untested assumption ships as a rule | NOT OFFICIAL, and a hypothesis to prove |
| The reader rewriting a decision the norm contradicts | the owner's decision is bypassed | OVERTURNS, and a numbered question |
| A published file trusted over the live system it describes | the publisher's copy can be older (a certificate chain, a sample) | a read-only probe of the live system, recorded like a document |

## Checklist before a decision or a rule rests on the archive

- [ ] Every claim the decision rests on is a row of the checks file, with the decision id and the claim's origin.
- [ ] The downloads had the owner's go; each file is archived as published, with its text copy and its extraction mode.
- [ ] `verify` reports nothing; every row has `origin` and `retrieved` (and `method` for text copies); publisher hashes match.
- [ ] Every row is closed with CONFIRMS, ADJUSTS, OVERTURNS, NOT OFFICIAL or `out of scope`, with file, page and lines.
- [ ] Rows with dates, deadlines, obligations or table cells passed the format traps; notices were read with the documents.
- [ ] Every OVERTURNS is a numbered question; every NOT OFFICIAL is a hypothesis; every ADJUSTS reached its decision.
- [ ] The README lists what was not archived and what the archive taught.
