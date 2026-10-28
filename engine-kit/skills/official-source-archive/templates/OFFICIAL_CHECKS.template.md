# Template: Official checks

**Scope**: method
**Used by**: [official-source-archive](../SKILL.md) steps 1, 5 and 6.
**Produces**: `CHECKS.md` beside an archive's README: one row per claim that a decision
rests on, each closed against the archived official text. Copy the skeleton below, fill
every `<...>`, and set the copy's own Scope line.

Rows are numbered once and never renumbered; a row that turns out to be two gets a
suffix (`12a`, `12b`). The status column is empty until the row is read; it is never
closed without file, page and lines.

## Skeleton

````markdown
# <Issuing party> - checks against the official text

**Scope**: <method|case|mixed>
**Opened on**: <YYYY-MM-DD> - inventory of <what was swept: plans, assessment, decisions>
**Archive**: [README.md](README.md)
**How to close a row**: the Status column takes `CONFIRMS` | `ADJUSTS` (write the data) |
`OVERTURNS` (becomes a numbered question) | `NOT OFFICIAL` (becomes a hypothesis to prove in
the issuing party's test environment) | `out of scope`, always with the source: archived file,
page, lines of the text copy (and the section or rule id). `preview` = read on the web,
not archived yet: it closes when the document is archived and the page is checked.
**State (<YYYY-MM-DD>)**: <n> closed - <n> CONFIRMS, <n> ADJUSTS, <n> OVERTURNS (-> <question ids>),
<n> NOT OFFICIAL (-> <hypothesis ids>), <n> out of scope. Readers: <groups per reader>.

## A. <subject group - for example: format and schema>

| # | Item | What to check in the official text | Supports | Wave | Claim from | Status |
|---|---|---|---|---|---|---|
| 1 | <short name> | <the question, in words a reader can search for> | <KEY#N> | <wave> | <file:line> | <STATUS - the data; source: file p.<page> l.<lines>, <rule id>> |

## B. <subject group>

| # | Item | What to check in the official text | Supports | Wave | Claim from | Status |
|---|---|---|---|---|---|---|

## Out of scope (recorded only)

| # | Item | Why not now | Supports | Status |
|---|---|---|---|---|

## Local hints from secondary sources (they close no row)

<a third-party component's bundled copy of the schemas, an article, a forum answer: what it
suggested and which rows it pointed to - never a source for a status>
````
