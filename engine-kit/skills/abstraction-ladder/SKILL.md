---
name: abstraction-ladder
description: Builds and maintains a navigable map of documentation - clickable flowcharts whose boxes carry a documentation status and drill down to real documents - generated from a manifest or spec and rendered per audience depth. Use when an area, product or knowledge base needs a visual entry point; when a box, a status or a drill-down of an existing map changes; when an approved hand-authored diagram must be extended; or when the abstraction-tree graph or the agents and skills catalog must be regenerated.
---

# Skill: Abstraction ladder (a map of the documentation, generated)

**Scope**: method
**Maturity**: candidate

**When to use**: a body of documentation needs an entry point a reader can climb up and
down - boxes and arrows showing how things relate, each box saying how trustworthy its
documentation is, each click going one level deeper until real prose. Also whenever an
existing map changes (new information for a box, a new box, a new drill-down, a status
change) and when the map's derived indexes must be rebuilt.
**Not for**: writing the raw documentation itself (an area's process docs, manuals, unit
docs). The ladder presents and links validated material; it does not author it.
**Real origin**: one case - a product team's knowledge base (2026-08 to 2026-10): an
approved hand-authored solution diagram extended into an ecosystem map, eight drill-down
diagrams, about 190 nodes and 370 edges in the tree graph, a generated catalog of 16
agents and 34 skills. Proven in one case, optional by nature: `candidate`
([maturity](../../docs/MATURITY.md)).
**Runtime**: [`runtime/ladder/`](../../runtime/ladder/README.md). **Judgment** (which
mode, which box, when it is a decision): the [`ecosystem-curator`](../../agents/ecosystem-curator.md) agent.

---

## The rules (do not work around them)

1. **The manifest or spec is the source of record; the HTML is disposable.** New
   information goes into the manifest/spec and the pages are regenerated. Nobody edits a
   generated page, not even for a one-line fix - the next run would silently undo it.
2. **Raw vs abstracted.** A box points at the raw, validated source (`source_md`) and
   renders it; it never copies it. Short tier-specific text (`body`) is fine for a depth
   the raw source does not have (an executive abstract), never as a second copy of it.
3. **One manifest, many renderings.** The same boxes and arrows render once per audience
   tier. Never hand-maintain a second flowchart of the same thing for another audience:
   add that tier's entry to the existing boxes.
4. **Tiers are depth and purpose, not job titles.** Baseline six: `technical-build`,
   `verification`, `internal-operational-usage`, `external-operational-usage`,
   `oversight`, `executive-summary`. A job title may appear as an illustration ("for
   example: a tester"), never as the tier's identity; a tier is never a client.
5. **Every box resolves to a real document or a placeholder.** A tier with no content
   gets a standard placeholder page - `not_available`, `confidential` or `diagram_only` -
   never a broken link and never an undeclared box. The generator enforces it.
6. **Statuses come from one fixed vocabulary** (below). A new word is a decision for the
   method's owner, not something a spec invents.
7. **Validation is a human loop, not a generator feature.** The tools print whatever
   status the manifest says. A box turns `available` only after its validation round
   (the people the content calls for - owner, tester, developer) signs off, recorded like
   any decision. A community score or an AI review is a secondary signal, never the gate.
8. **Diagram before prose.** While a box's subject still has distinct parts worth showing
   separately, its target is another diagram, not a page of prose - even when a full
   prose write-up exists (link that one level deeper, from the diagram). Prose is the
   target only at a genuinely terminal box. In doubt, it decomposes further.
9. **Every page below the top carries a visible back-link** to the abstraction it came
   from - not a link buried in a sidebar. Only the true root of a map skips it.
10. **Never send a box into the pack being extended.** That pack's pages carry their own
    navigation, which loops the reader back to the un-extended original and drops
    everything the extension added. Render the leaf locally from the same raw source.
11. **No hand-tuned pixels.** Boxes auto-fit their text (height first; width only as a
    capped last resort), rows take the height of their tallest box, the canvas sizes
    itself. Declare rows, not coordinates; treat every layout `WARNING` as a defect of the
    spec.
12. **Same real scale everywhere.** Every diagram carries width/height equal to its
    viewBox and may only shrink to fit, never stretch - otherwise the same 13px label
    looks bigger on a sparse diagram than on a dense one and "the boxes look
    inconsistent" with identical design values.
13. **Regenerate the derived indexes after every change**: the tree graph after any
    manifest or spec change; the catalog after any agent or skill change. A stale graph
    is the same bug as a stale registry.

## The status vocabulary

| Status | Means | Moves when |
|---|---|---|
| `available` | Operating or validated reality; the content passed its validation round | Only through the sign-off |
| `draft` | Real content, validation pending - or partly still design | Pending notes say which part |
| `pending` | Designed, not built yet | Content appears -> `draft` |
| `pointer` | Documented elsewhere (a wiki, another tool): cited, not rewritten | Depth brought in -> `draft` |
| `redirect` | The content lives at another box or page; this one forwards | - |
| `pdf` | The source exists only as a PDF: linked, not reproduced | Converted -> `draft` |
| `deferred` | Consciously postponed or out of scope for this tier | Scope changes |
| `missing` | The gap to fill: known and tracked | Written -> `draft` |
| `stale` | Was valid; its source changed since the last validation | Revalidated -> back up |

Changing a status is never silent: edit the box's status AND its leaf's `pending` notes
(they say exactly what is missing, or are emptied), regenerate the page, regenerate the
tree. Upgrades to `available` need the validation sign-off. Downgrades to `stale` happen
the moment the source is known to have changed - honesty first, regeneration after.
`pending` notes are concrete ("refund rules", "partner-feed cases"), never "TBD".

## Mode A or mode B

| Situation | Mode | Tool |
|---|---|---|
| A real, already-approved hand-authored page exists for this exact diagram | **B, extend it** - never route it through the generic generator | `extend_handauthored.py` (extend shape) |
| A brand-new drill-down with no hand-authored version, but it must read as part of the same system | **B, blank canvas** reusing the parent's CSS | `extend_handauthored.py` (blank canvas) |
| Tiers that will never have a hand-authored version; several boxes across several tiers | **A, the generator** | `generator.py` |

When unsure, look for an approved hand-authored page first: losing fidelity to something
already approved is the costlier mistake (in the origin case the first build of the map
went through the generator, lost the approved look, and had to be redone as an
extension). One page has one source of record: a page claimed by a manifest and by a
spec is a conflict (`tree_index.py` reports it) - a re-run of either overwrites the other.

## Building a mode A pack

1. **Place the manifest** next to its output: one `manifest.json` per pack, e.g. in an
   `ABSTRACTION/` folder of the area it maps. Schema by example:
   [`manifest.example.json`](../../runtime/ladder/manifest.example.json).
2. **Declare the tiers** (`audiences`): pick from the baseline six or add one; ids are
   lower-kebab-case (they become folders).
3. **Declare the boxes** (`nodes`): stable kebab ids (renaming one breaks every link into
   it), `label`, optional `sublabel`, `row`, `edges_to`. Put non-branching steps side by
   side on one row; give a row of its own only to a fan-out or fan-in point.
4. **Fill each box's `audience` map**, one entry per tier: `source_md` (preferred - the
   raw source, see [`template.md`](../../runtime/ladder/template.md)), or a short `body`
   for a different depth, or only a `placeholder_kind`. Status from the vocabulary;
   `draft` until validated; `pending` notes for what is missing; `drills_into` when the
   box has its own diagram.
5. **Generate**: `python runtime/ladder/generator.py <pack>/manifest.json` (`--check`
   validates only). Output: tier picker, one flowchart per tier, one leaf page per box
   per tier, a coverage matrix. A box missing from a tier still gets a page (`missing` +
   placeholder): there is no escape hatch.

## Extending a map or adding a drill-down (mode B)

1. **One spec per diagram, next to its output.** A drill-down hanging off a box gets its
   own `extend-spec.json` in a subfolder named after the parent box's id; the parent
   box's `href` (or `drills_into`) points at the drill-down's `index.html`. Schema by
   example: [`extend.example.json`](../../runtime/ladder/extend.example.json).
2. **Extend shape** (`source_html` + `output_html`): the approved page is read, never
   modified (the tool checks its hash and refuses an output that overwrites it). New
   boxes need explicit `x`/`y` - you are placing into someone else's artwork - and only
   their height grows. Grow the viewBox (`viewbox_grow_height`), add CSS for new box
   classes, replace titles/intros with `text_replacements`.
3. **Blank canvas** (`new_boxes`, no `source_html`): reuse the parent's stylesheet
   (`css_from`: the parent's .css or .html; or `build_py`) - never hand-copy CSS, that
   is how visual drift starts. Boxes declare `row` and a manual `x`; never mix `row`
   and `y` in one spec. A long chain may **snake**: row 0 left to right, row 1 right to
   left, the row change a vertical edge between two boxes with the same `x`; the arrow
   follows the declaring box.
4. **Leaf pages** (`leaf_pages`): rendered locally from `source_md` (with `md_replace` to
   re-base its relative links) or a short `body_md`; `leaf_back_link` once for all;
   status and `pending` per leaf.
5. **Generate**: `python runtime/ladder/extend_handauthored.py <spec>`.

## Density and scale

- The tell of a wasteful layout: a diagram with half the boxes of another occupying the
  same area. Pack sequential steps onto shared rows (same-row arrows are horizontal),
  reserve rows for branching and hubs, give the boxes of a snake the same minimum height.
- Compare diagrams only at real scale: the tools pin every SVG; if a template ever
  reintroduces `svg{width:100%}`, every diagram's boxes look different again.
- The legend is one definition (generated from the vocabulary), on every diagram, with a
  hover hint per status. Never write legend markup in a spec.

## After every change

1. Regenerate the page(s) from the manifest/spec; fix every `WARNING` in the spec.
2. `python runtime/ladder/tree_index.py --root <map-root> --out <index-area>/abstraction-tree.json`:
   check `roots` (one), `unresolved` (pages promised but absent), `conflicts` (one page,
   two sources of record), `stats.by_status` (the map's honesty overview). Agents query
   this graph to navigate the chaining instead of re-deriving it from hrefs.
3. Agents or skills changed: `python runtime/ladder/catalog_gen.py ...` (catalog
   regenerated from the real files; a skill present only in a local tool folder is a gap
   to resolve), render its spec, rebuild the tree.
4. **Verify before claiming parity**: open the regenerated page next to the last approved
   version (or diff them). A silent visual regression is exactly what the human approval
   was protecting.
5. Close with the retention chain ([`retain-knowledge`](../retain-knowledge/SKILL.md)):
   what changed in the map and why.

## Decisions, not content

Adding content to an already-decided shape (a new leaf, a status change, a new box inside
an existing drill-down) is maintenance. A **new top-level box** on the map, a **new kind
of drill-down**, a **new tier** or a **new status word** changes the shape everyone
navigates: present it as a decision round ([`decision-rounds`](../decision-rounds/SKILL.md))
and let the owner decide.

## Recorded lessons (origin case, anonymized)

- Routing an approved hand-authored diagram through the generic grid generator lost the
  look the owner had approved ("I want it the same"); redone as an extension. Mode B
  exists because of it.
- Boxes linked straight into the pack being extended: one click deeper, the reader landed
  on the original's navigation and the extension vanished. Leaves are now rendered
  locally from the same sources.
- A box opened a page of prose where the subject had nine parts: the reader got a wall of
  text instead of a map. Diagram before prose.
- Long sequential flows drawn one box per row took as much canvas as the main map with
  half its boxes. Pair non-branching steps; snake long chains.
- "The boxes look inconsistent across diagrams" with identical design values: diagrams of
  different sizes stretched to the page width. Pin the real scale.
- Hand-sizing boxes so labels would not overflow was endless; auto-fit made overflow and
  row overlap structurally impossible and turned the rest into warnings.
