# Format traps - when the document's format misleads

**Scope**: method

Companion of [the official-source archive skill](../SKILL.md), step 5. Each trap below
happened in the source case; the rule is the correction it needed. They apply to any norm
published as PDF, and most apply to any format: a text extraction, a summary or a sample
is a reading of the document, not the document.

## The traps

| # | Trap | Seen in the source case | Rule |
|---|---|---|---|
| 1 | **Struck-through text survives the text extraction** | a validation rule's production dates were struck through in the PDF and replaced by "future implementation"; the text copy printed the old and the new text side by side, with no mark; a secondary source read as text stated the struck date as in force, and the web survey repeated it | a row about a date, a deadline or an obligation closes only after the struck-through check of its page ([detector](#the-struck-through-detector)) |
| 2 | **Layout mode moves table cells** | in a schedule table, one rule's dates landed on the line of other rules in the layout-mode text | a value read from a table is confirmed by its position on the page, never by the text copy alone |
| 3 | **Layout mode swaps identifiers between lines** | in a long annex of validation rules, rule ids were printed next to other rules' text | take rule ids from a reading-order ("raw") extraction; cite the text from the archived copy |
| 4 | **The date in force is in no document** | a portal notice postponed the test and production dates of three amendment notes; the PDFs kept the old dates | read the issuing party's notices with the documents; transcribe the notice; the row cites both ("the note says X; the notice of <date> moves it to Y") |
| 5 | **Packages are layers, not versions** | each newer schema bundle held only what changed; validating a message needed the base bundle and two layers, in order | the README records the overlay order; a schema check cites the layer it came from |
| 6 | **A published file older than what it describes** | an authority's published server-certificate bundle had expired; the live servers used newer certificates under the same root | where the live system can be probed read-only (a handshake, a status call), record the probe - command, date, result - like a document and prefer it for what is live |
| 7 | **Lengths and codes grow** | a new version widened a result code and a protocol number by a digit or two; the examples did not change, the type patterns did | read the schema's type patterns, not the examples; every field, column or parser sized from an example is a check of its own |
| 8 | **The publisher contradicts itself** | one section of the manual said a header element was gone; two other sections still asked for it | quote both with page and line, close on the section specific to the case, note the inconsistency so the code tolerates both where it can |
| 9 | **The checkout changes the bytes** | a published hash list stored as text came back from a converting checkout one byte longer, and its hash no longer matched | the archive is binary in version control ([archive-and-manifest.md](archive-and-manifest.md#version-control)); the manifest tool names "line endings only" |

A secondary source carries every trap of the format it was read from, plus its own: that
is why it orients and never closes a row.

## When to run which check

| The row is about | Before it closes |
|---|---|
| a date, a deadline, an obligation, "mandatory", "optional", "from version N" | trap 1 on its page; trap 4 (notices since the document's date) |
| a value inside a table (a schedule, a limit per region) | trap 2: the position on the page |
| a rule id, an error code, a field id | trap 3: reading-order extraction |
| a schema element, a type, a length | traps 5 and 7: the layer, the type pattern |
| a certificate, an address, a live behaviour | trap 6: a read-only probe, recorded |

## The struck-through detector

A word processor that exports to PDF does not mark struck text as such: it writes the
text unchanged and draws a **thin horizontal mark across the middle of the line** - usually
a filled rectangle less than about 1.6 points high. A text extraction reads only the text,
so the struck words come out as if they were in force. A detector looks for the marks.

### How it works

1. For each page, collect every **text run** with its position (the baseline's x and y,
   after the current transformation) and its font size, and every **thin horizontal mark**:
   a filled rectangle under about 1.6 points high and between about 3 and 400 points wide
   (and, if the producer draws them that way, a stroked horizontal line).
2. A run is **struck** when a mark's vertical middle lies between 0.15 and 0.55 of the font
   size above the run's baseline, and the mark covers the run's start horizontally.
3. That band excludes **table borders** (at or below the baseline, or above the capitals)
   and **underlines** (below the baseline).
4. Print page, vertical position and text of every struck run, then **look at those places
   on the page** before writing the row.

### Limits

- It is a heuristic. It misses strikes drawn as stroked paths when it collects only
  rectangles (the source case's detector did), strikes that begin after the run's first
  character, and scanned pages (there is no text to cross). It can hit a thin shaded band
  that happens to cross the middle of a line.
- **Prove it on a known strike first**: run it on a page where a strike is visible before
  trusting "no struck text found" on another. A detector that never found anything has not
  shown that it can.

### Why the kit does not ship it

It needs a PDF parser - content streams, fonts and text positions - and the kit's tools are
standard-library Python. Any PDF library that reports drawing operations and text
positions per page can implement the four steps above in a few dozen lines; the case keeps
that script with its own tools, with a header that says what it detects, how, and its
limits, and the archive README names it.
