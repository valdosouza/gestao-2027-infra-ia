# Abstraction ladder runtime

**Scope**: method

Scripts behind the [`abstraction-ladder`](../../skills/abstraction-ladder/SKILL.md) skill and
the [`ecosystem-curator`](../../agents/ecosystem-curator.md) agent: a navigable map of
documentation - clickable flowcharts whose boxes carry a documentation status and drill
down to real documents - built from a manifest or a spec, never drawn by hand page by page.
The manifest/spec is the source of record; every HTML page is disposable build output.
Python 3.8+, standard library only; every root and output path is a parameter; generated
packs and the tree graph are case artifacts and the scripts refuse to write them inside
the kit.

## Scripts

| Script | Technique | What it does | Example |
|---|---|---|---|
| [`generator.py`](generator.py) | T63 ladder, mode A | One manifest -> one flowchart per audience tier + one leaf page per box per tier + tier picker + coverage matrix. Every box resolves to a real document or a placeholder (`not_available`, `confidential`, `diagram_only`); fixed status vocabulary (unknown word = error); boxes auto-fit their text, rows are computed and centred; `drills_into` makes a box open a child diagram; `--check` validates only | `python runtime/ladder/generator.py <pack>/manifest.json` |
| [`extend_handauthored.py`](extend_handauthored.py) | T64 curator, mode B | One spec per diagram. Extend shape: reads an approved hand-authored page (never modified, hash-checked), adds boxes in its style, grows the viewBox, back-link, shared legend, real scale. Blank canvas: a new drill-down reusing the parent's CSS (`css_from` or `build_py`), boxes by `row`, auto-sized. Leaf pages rendered locally from the raw source; warns on missing back-links, unbuilt box targets, overflow | `python runtime/ladder/extend_handauthored.py <pack>/<box-id>/extend-spec.json` |
| [`tree_index.py`](tree_index.py) | T65 tree graph | One JSON graph of the whole tree from every spec and manifest under a root: diagrams, boxes, leaves, sources of record, keywords, statuses; flags pages promised but not on disk (`unresolved`) and pages claimed by two sources of record (`conflicts`); lists the `roots`. Never hand-edited | `python runtime/ladder/tree_index.py --root <map-root> --out <index-area>/abstraction-tree.json` |
| [`catalog_gen.py`](catalog_gen.py) | T66 catalog | Agents and skills catalog generated from the real files, any layout (this kit: `--root <kit>`; a case: `--agents <dir> --skills <dir>`); whole-word cross-reference of which agents name which skills; flags skills present in a local tool folder but absent from the source of record, and front-matter issues. Markdown, JSON and/or a mode B spec for a catalog drill-down; `--strict` exits 1 on a gap | `python runtime/ladder/catalog_gen.py --root <kit-or-kb> --local-skills <tool-skills-folder> --md-out <file>.md` |
| [`ladder_common.py`](ladder_common.py) | shared | Not a command: the ONE definition both modes import - status vocabulary and legend, placeholders, markdown renderer, box auto-fit, layout, edges, base CSS, back-link, page shell | - |

| File | Role |
|---|---|
| [`manifest.example.json`](manifest.example.json) | Mode A schema by example (a fictional "Acme Orders" product, six tiers, every status and placeholder kind, a `drills_into`), with `_schema_notes` field by field |
| [`extend.example.json`](extend.example.json) | Mode B schema by example: the blank-canvas drill-down of the example's Fulfilment box (a snake layout), the extend shape under `_extend_shape_example`, `_field_notes` |
| [`template.md`](template.md) | The raw source document a box renders from (`source_md`): evidence, validation pending until the round signs off |

## Try the examples

```
mkdir <scratch>/acme/sources <scratch>/acme/fulfilment-flow
copy runtime/ladder/manifest.example.json  <scratch>/acme/manifest.json
copy runtime/ladder/extend.example.json    <scratch>/acme/fulfilment-flow/extend-spec.json
python runtime/ladder/generator.py <scratch>/acme/manifest.json
python runtime/ladder/extend_handauthored.py <scratch>/acme/fulfilment-flow/extend-spec.json
python runtime/ladder/generator.py <scratch>/acme/manifest.json      # the drill-down now resolves
python runtime/ladder/tree_index.py --root <scratch> --out <scratch>/tree/abstraction-tree.json
```

Missing `sources/*.md` files are reported and rendered as placeholders - write a few
lines in them to see real leaf pages.

## The cycle after every change

1. Edit the manifest or spec - never the generated HTML, not even for one line.
2. Re-run `generator.py` (mode A) or `extend_handauthored.py` (mode B) for it; treat every
   `WARNING` as a defect of the spec (overlap, truncated label, missing back-link, box
   target not built).
3. Re-run `tree_index.py`; read `unresolved`, `conflicts` and `roots` (one root expected).
4. When an agent or skill changed: `catalog_gen.py`, then `extend_handauthored.py` on the
   catalog spec, then `tree_index.py` again.
5. Compare the regenerated page with the last approved version before saying it matches.

## What changed from the case's tools

- **One shared module** (`ladder_common.py`). The two modes had drifted: different colours
  for `draft` and `stale`, `pending` known to one mode only, `redirect`/`deferred` to the
  other. Now one vocabulary of nine statuses with distinct colours, one legend built from
  it, one renderer; an unknown status is an error instead of a grey dot.
- **Mode A** got the mode B layout rules: auto-fit boxes (no truncation at three lines),
  rows from the tallest box, centred rows, the same-real-scale SVG, the legend, back-links,
  `sublabel`, `drills_into` (diagram before prose), a node x tier coverage grid, `out_dir`,
  `--check`, orphan-page warnings; the duplicated page title is gone; front matter and
  Scope lines of a source are stripped; fenced code renders.
- **Mode B** no longer requires a parent build script: the kit renderer is the default,
  the parent's CSS comes from `css_from` (a .css or the parent .html; for the extend
  shape, the approved page itself) and a `svg{width:100%}` in it is pinned to
  `max-width`. Labels are escaped; only the diagram's own `<svg>` is touched; the source
  is hash-checked and may not be the output; the legend is inline-styled so it works on
  any host page, and is added when the page had none; missing back-links, unbuilt box
  targets, captions under a grown box and boxes below the viewBox are warned.
- **Tree graph**: root, base, output and file names are parameters; every manifest is
  scanned (not one, not one fixed tier); a box `drills_into` a page only when that page
  is a known diagram; leaves carry back edges; `exists`, `unresolved`, `conflicts`;
  ids relative with `/`.
- **Catalog**: any layout; whole-word cross-reference (a substring match let a skill name
  match inside a longer name); front-matter issues; three output formats; no machine
  path in any output.
- Every output is UTF-8 with LF line endings.

## Dropped as case-only

- Hard-coded roots: the knowledge-base root, the map folder, the central index folder,
  the agent and skill folders, the local tool folder, the catalog output folder.
- The approved pack's own build script path and its client-specific "internal - not for
  client export" badge flag; the optional `build_py` keeps the useful contract
  (`CSS`, `md_to_html`, `nav_html`).
- `repoint_files` / `repoint_prefix` (send a box back into the pack being extended):
  superseded in the case itself by "render every leaf locally".
- The case's decision numbers and local decision ids, roadmap phase references, product,
  client and folder names, the catalog drill-down's hard-coded navigation and overview
  text (now `--spec-back-href`, `--spec-back-label`, `--spec-css-from`).

## Limits

Text width is estimated (0.56 x font size), not measured: a wide font can still overflow
a box although the layout is collision-free. Extending a page cannot see the host's
artwork, so a new box there grows only in height and its position stays the author's
call. Tree keywords are deterministic tokens, not semantic vectors.
