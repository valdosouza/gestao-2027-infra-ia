---
last_updated: <YYYY-MM-DD>
tags:
  - registry
  - graphs
---
# Graph Registry - <project>

**Scope**: <method|case|mixed>
**Profile**: <solo|team>
**Designated builder**: <machine name of the one builder (team profile); - for solo>

> Template from the engine-kit (`templates/REGISTRY_GRAPHS.template.md`). Save the filled
> copy as `REGISTRY_GRAPHS.md`, fill every `<placeholder>`, delete the layers the case
> does not need and this note.

All code knowledge graphs of this project. Graphs are built by the case's code indexer
(a CLI with query / path / explain commands and hash-based incremental rebuild) and
queried by agents before any source file is read. This registry DRIVES the rebuild job
(`runtime/graph/rebuild-graphs.ps1`): a graph that is not registered here is not built,
and the job keeps no list of its own.

**Profile** (EK#5): `solo` keeps the graphs outside the versioned knowledge base - beside it,
or in a folder inside it that version control ignores (EK#27) - rebuildable by
their one user, and nothing is committed; `team` versions them, and only the
**Designated builder** (a machine name) rebuilds and commits them - everyone else
receives them with a version-control update.

## Architecture

Optional graph layers (e.g. base / overlay / merged). A single codebase needs one
graph. A product customised per variant (e.g. per client) can keep a base layer, one
overlay layer per variant, and a merged layer per variant: base + overlay, which is
what actually runs for that variant.

| Graph | Kind | Location | Source | Pairs | Flags | Purpose |
|---|---|---|---|---|---|---|
| `base.graph` | base | `<graphs-location>\base\<tool>-out` | `<base-source>` | - | `--code-only` | Behaviour shared by every variant |
| `<variant>.overlay.graph` | overlay | `<graphs-location>\<variant>\<tool>-out` | `<variant-source>` | - | `--code-only` | Units the variant added or overrode |
| `<variant>.merged.graph` | merged | `<graphs-location>\<variant>\merged\<tool>-out` | - | `base.graph` + `<variant>.overlay.graph` | `--code-only` | What actually runs for the variant |

- **Graph**: the id, in backticks; the same id names its Build Status row.
- **Kind**: `base`, `overlay` or `merged`.
- **Location**: the folder that holds the graph file, in backticks - absolute, or relative
  to the knowledge-base root (the root given to the validator and to the job). Its last
  folder is the one the tool creates under its output folder (`<tool>-out`); the job
  passes the parent folder as the tool's output.
- **Source**: the code tree scanned - absolute, or relative to the code root
  (`CODE_ROOT`); `-` for a merged graph.
- **Pairs**: merged graphs only - the base and the overlay graph it combines. The job
  builds it from their two sources through a hardlink overlay tree (the overlay wins on
  the same path; zero data copied).
- **Flags**: passed to the tool as written; `-` takes the job's default (code only:
  local parsing, no model key - a document or image extraction must never block a code
  graph rebuild).

## Build Status

Stamped by `runtime/graph/rebuild-graphs.ps1 -StampRegistry` after each successful build
(Last Built = the build date; counts read from the graph file), not by hand: a
hand-filled date goes stale while every freshness check keeps reading it. Checked by
`runtime/validate-registry.ps1`: a dated row without the graph file (`graph.json` by
default, `-GraphFile` to change) at its location fails validation, and so does an
undated row with one, or a location that does not exist.

| Graph | Last Built | Nodes | Edges | Communities | Notes |
|---|---|---|---|---|---|
| `base.graph` | - | - | - | - | Not yet built |
| `<variant>.overlay.graph` | - | - | - | - | Not yet built |
| `<variant>.merged.graph` | - | - | - | - | Not yet built |

## Freshness

The graph is the reading instrument, not the source of truth - the code is. Before
mapping behaviour from a graph, compare its Last Built with the code's last change in
version control (`rebuild-graphs.ps1 -CheckRegistry` does it for every row). Code newer
than the graph: rebuild first, or mark the graph-derived evidence `graph-stale`.

## When to Rebuild

- The designated builder's scheduled job rebuilds every registered graph (daily); a
  manual rebuild runs the same script
- A version-control update touched source files in the scanned folder
- A unit was added or renamed
- A new variant version was deployed
- A merged layer is rebuilt whenever its base OR its overlay changes
