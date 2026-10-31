# Template: Archive README

**Scope**: method
**Used by**: [official-source-archive](../SKILL.md) steps 4, 6 and 7.
**Produces**: `README.md` at the root of one archive (one per issuing party). Copy the
skeleton below, fill every `<...>`, delete the rows that do not apply, and set the copy's
own Scope line (the case's scope for a real archive; `mixed` when the norm is portable to
other cases and the archive also holds case specifics).

The README is the front page for people: what is archived, from where, how it was fetched,
what was left out, and what the archive taught. The manifest (`MANIFEST.csv`) is what the
tool checks; the README's table is written from it. The checks file is linked, never
copied here.

## Skeleton

````markdown
# <Issuing party> - <what the system must obey, in one line>

**Scope**: <method|case|mixed>
**Archived on**: <YYYY-MM-DD> - downloads approved by <KEY#N> (the owner's go)
**Checks**: [CHECKS.md](CHECKS.md) (<n> rows, <n> closed)
**Manifest**: `MANIFEST.csv` - `verify` clean on <YYYY-MM-DD>
**Marks**: `[SEC]` = secondary source; `preview` = read on the web, not archived yet;
"not confirmed" = could not be checked.

## Archive

Each document has its text copy beside it (`<extraction command and mode>`); line
citations point into the text copy. Hash = the first 16 characters of the SHA-256.

| File | Document | Bytes | SHA-256 (16) | Origin |
|---|---|---|---|---|
| `<folder>/<issuer>-<document>-<version>.pdf` | <title as people name it> (<pages> p.) - <date published> | <bytes> | <16 hex> | <address> |
| `<folder>/<bundle>.zip` (+ extracted folder) | <what the bundle holds; which layer it is> | <bytes> | <16 hex> | <address> |
| `notices/<page>-<YYYY-MM-DD>.txt` | transcription of <page>, read on <date> - <what it changes> | - | - | <address> |

**How it was fetched**: <client and options per source; certificate failures and retries;
publisher hashes compared (match / no hash published)>. TLS verification was not turned
off for any download.

**Overlay order** (bundles that are layers): <base> -> <layer 1> -> <layer 2>.

**Not archived**:
- <document> - <out of scope | not yet published on <date> | kept in <other archive> | check whether it supersedes <document>>

## What this archive taught (negative knowledge)

- <the trap, the page where it happened, the rule that follows - for example: "the text
  copy keeps struck-through text: run the struck-through check before closing a row with a
  date">

## Facts

Each fact cites its archived source (file, page, lines of the text copy) or is marked
`preview` / `[SEC]`. The closing of each check is in [CHECKS.md](CHECKS.md); this list is
the summary a reader needs first.

1. **<subject>**: <the fact> (<file> p.<page> l.<lines>).
````
