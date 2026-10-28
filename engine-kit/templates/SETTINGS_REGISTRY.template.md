---
project: <KEY>                    # the projects-registry key of this project
layer: <base|overlay>             # overlay = only the delta against base_registry
base_registry: "<link to the base project's _REGISTRY/SETTINGS, or ->"
last_scan: <YYYY-MM-DD>           # the last full or area scan (section 2 says which)
last_updated: <YYYY-MM-DD>
tags:
  - registry
  - settings
---
# Settings Registry - <project>

**Scope**: <method|case|mixed>

> Template from the engine-kit (`templates/SETTINGS_REGISTRY.template.md`) - technique T67,
> *operating*. Save the filled copy as `<project>/_REGISTRY/SETTINGS.md`, one per project
> (a base, a version line, a client overlay). Written by the settings-mapper agent only;
> everyone else reads it. A client overlay's copy lists only its delta (section 4) and
> points to the base registry for the rest. The **setting document** at the end of this
> file is a separate document: copy it to `SUBJECT/<AREA>/SETTINGS/<setting>.md` when a
> setting needs one, and delete it from the registry copy. Replace every `<placeholder>`,
> delete the parts that do not apply and this note. Method: the `settings-mapper` agent of
> the kit.

Every setting that can change which code runs, or what a step produces, in this project's
code - read before any pipeline of the project is mapped. The owner confirms every
demotion to `inactive` or `unreachable`. **Which value an environment holds is not
recorded here**: the pipeline builder asks for it and records it, dated, where it is used.
**Which pipelines a setting forks is not listed here either**: search the trigger tables
under `PIPELINES/` for the setting's name - a list here would go stale with every new
pipeline.

## 1. Kinds

| Kind | What it is |
|---|---|
| `property` | a property of the configuration object the code reads at run time |
| `file-key` | a key of a configuration file - INI, JSON, YAML, XML, a scheme file |
| `env` | an environment variable |
| `db` | a flag or value read from the database at run time - a settings table, a feature switch, a stored preference or configuration document |
| `code` | a flag fixed in the code: frozen at compile time, the same wherever the binary runs - status `frozen`, never asked of an environment |
| `build` | a conditional-compilation symbol or build-profile switch: whether the code exists in a binary at all |

Business data that forks a path (an order's type) is not a setting: it is a data condition
in the pipeline's trigger table.

## 2. How this registry is scanned (the case's stack)

The search patterns are this project's, confirmed by the owner - the agent assumes no
language. One row per kind the stack uses; a kind the stack does not have says `n/a`.

| Kind | Pattern (regular expression) | Searched in | Excluded | Confirmed |
|---|---|---|---|---|
| property | `<how the code reads the configuration object>` | `<code tree or folders>` | `<tests, vendored, generated>` | <owner, YYYY-MM-DD> \| proposed YYYY-MM-DD - asked in R-<NS>n (closing round) |
| file-key | `<the read-key call of the configuration-file API>` | <...> | <...> | <...> |
| env | `<the environment-variable read of the stack>` | <...> | <...> | <...> |
| db | `<the settings-table query or feature-switch call>` | <...> | <...> | <...> |
| code | `<a flag assigned a literal at declaration>` | <...> | <...> | <...> |
| build | `<the conditional-compilation directive>` | <...> | <...> | <...> |

| Build profile (entry point or binary) | Conditional symbols defined | Declared in |
|---|---|---|
| <the server binary> | <SYMBOL, SYMBOL> | <the build registration or project file> |

| Code tree | Revision | Scan date | Scope (full / areas) | State (clean / local changes) |
|---|---|---|---|---|
| <tree, relative to the code root> | <revision or commit> | <YYYY-MM-DD> | <full / AREA, AREA> | <clean> |

## 3. Status

| Status | Meaning |
|---|---|
| `active` | read on a reachable path of at least one shipped build profile (Notes names the profiles when not all) |
| `frozen` | kind `code` on a reachable path: in force, but its value changes only with a build |
| `unreachable` | still read, but only in dead code, under a symbol no shipped profile defines, behind a constant guard, or with its result discarded |
| `inactive` | no longer read anywhere in the scanned trees |
| `unverified` | found; reachability not checked yet - never treated as `active` |

## 4. Settings

| Setting | Kind | Read at | Default | Level | Status | Areas | Cross-area | Verified | Notes |
|---|---|---|---|---|---|---|---|---|---|
| `<name exactly as the code or the file writes it>` | <kind> | <file>:<line>; <file>:<line> | <value when absent / none - the read fails> | <system / tenant / user / client> | <status> | <OWNING_AREA>, <AREA> | <yes / no> | <YYYY-MM-DD at revision> | <what it forks; what it does NOT decide; [[SUBJECT/<AREA>/SETTINGS/<setting>]]> |

- **Level**: where the value is set - one per installation (`system`), per tenant or site,
  per user, per client overlay.
- **Areas**: the owning area first, then every other area a read site belongs to. A row
  with two or more areas is **Cross-area `yes`** and is listed in the Settings table of each
  of those areas' INDEX.
- **Overlay copy**: add an `Against base` column after Setting - `added` (overlay only),
  `forced` (the overlay fixes the value in its code), `read-differently` (another default
  or another read site), `ignored` (the overlay's path skips the base read) - and list only
  those rows. An overlay with no delta says so in one line, with the date and revision.

## 5. Status history (append-only)

| Date | Setting | From -> To | Evidence | Confirmed by |
|---|---|---|---|---|
| <YYYY-MM-DD> | `<setting>` | <new -> active / active -> unreachable / ...> | <the search or the build profile that showed it> | <owner, for every demotion> |

---

## Companion template - a setting document

For a setting with more than two values, a cross-area setting, or one that was misread,
saved as `<project>/SUBJECT/<OWNING_AREA>/SETTINGS/<setting>.md`. Copy the block below,
fill it, delete its note.

```markdown
---
project: <KEY>
subject: <OWNING_AREA>
setting: <name as the registry writes it>
last_updated: <YYYY-MM-DD>
tickets: []
tags:
  - settings
  - <area in lowercase>
---
# <setting> - "<the one question it answers>"

**Scope**: <method|case|mixed>

> Written by the settings mapper; the registry row is the index, this document the
> detail. Every statement cites file:line at a revision. Delete this note.

<One paragraph: the single question this setting answers.>

## Values

| Value | Name in the code | Wording users see | Effect |
|---|---|---|---|
| <value> | `<constant>` (<file>:<line>) | "<label>" | <what runs or what changes> |

## Where it gates

- `<unit>.<routine>` (<file>:<line>): `<the condition, quoted>` -> <effect>

## What it does not decide

- <the neighbouring behaviour people attribute to it> - decided by `<other setting>` or
  <the data condition>, (<file>:<line>)

## Evidence and open points

- <card ids, logs, work items; what is still unverified>
```
