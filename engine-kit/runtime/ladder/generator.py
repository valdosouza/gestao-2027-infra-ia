#!/usr/bin/env python3
"""generator.py - abstraction ladder, mode A: one manifest -> many audience-tier renderings.

The manifest (JSON) is the source of record; every HTML page this writes is disposable
build output - regenerate it, never hand-patch it. One manifest declares the pack's
audience tiers (by depth/purpose, never by job title), its nodes (boxes) and edges;
the same topology is rendered once per tier, each tier with its own statuses, depth
and links:

  <out>/index.html               tier picker (the pack's entry point)
  <out>/<tier>/index.html        one flowchart per tier, with the shared status legend
  <out>/<tier>/<node>.html       one leaf page per node per tier
  <out>/coverage.html            node x tier status matrix, generated

Every box resolves to a real document or to a standard placeholder (not_available |
confidential | diagram_only); a node with no entry for a tier is rendered as
`missing` + not_available - there is no escape hatch. Statuses come from one fixed
vocabulary (ladder_common.STATUSES, `stale` included); an unknown word is an error.
Layout is computed: boxes auto-fit their text, rows take the height of their tallest
box, rows are centred - the manifest declares rows, never pixels.

Usage:
  python generator.py <manifest.json> [--out DIR] [--check]

--out defaults to the manifest's `out_dir` (relative to the manifest), else the
manifest's own folder. Output is never written inside the kit. --check validates
without writing. Exit 1 on any error. Python 3.8+, standard library only.
"""

import argparse
import html
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ladder_common as lc  # noqa: E402


def tier_entry(node, tier_id):
    entry = (node.get("audience") or {}).get(tier_id)
    if entry is None:
        return {"status": "missing", "placeholder_kind": lc.DEFAULT_PLACEHOLDER, "_undeclared": True}
    return entry


def validate(manifest, manifest_dir, report):
    audiences = manifest.get("audiences") or []
    nodes = manifest.get("nodes") or []
    if not audiences:
        report.error("manifest declares no `audiences` (tiers)")
    if not nodes:
        report.error("manifest declares no `nodes`")
    tier_ids = [a.get("id", "") for a in audiences]
    node_ids = [n.get("id", "") for n in nodes]
    for kind, ids in (("tier", tier_ids), ("node", node_ids)):
        for value in ids:
            if not lc.ID_RE.match(value or ""):
                report.error("%s id '%s' must be lower-kebab-case (it becomes a file or folder name)" % (kind, value))
        for value in sorted(set(i for i in ids if ids.count(i) > 1)):
            report.error("%s id '%s' is declared twice" % (kind, value))
    for a in audiences:
        if not a.get("label"):
            report.error("tier '%s' has no label" % a.get("id"))
    for n in nodes:
        nid = n.get("id")
        if not n.get("label"):
            report.error("node '%s' has no label" % nid)
        for target in n.get("edges_to", []):
            if target not in node_ids:
                report.error("node '%s': edges_to '%s' is not a node of this manifest" % (nid, target))
        for tid, entry in (n.get("audience") or {}).items():
            where = "node '%s', tier '%s'" % (nid, tid)
            if tid not in tier_ids:
                report.warn("%s: tier not declared in `audiences` - ignored" % where)
                continue
            lc.check_status(entry.get("status", "missing"), where, report)
            kind = entry.get("placeholder_kind")
            if kind and kind not in lc.PLACEHOLDERS:
                report.error("%s: placeholder_kind '%s' is not one of %s" % (where, kind, " | ".join(lc.PLACEHOLDERS)))
            if entry.get("source_md") and entry.get("body"):
                report.warn("%s: both source_md and body given - body is ignored" % where)
            if entry.get("source_md") and not os.path.isfile(os.path.join(manifest_dir, entry["source_md"])):
                report.warn("%s: source_md not found (%s) - a placeholder is rendered until it exists"
                            % (where, entry["source_md"]))
            has_content = entry.get("body") or (entry.get("source_md") and
                                                os.path.isfile(os.path.join(manifest_dir, entry["source_md"])))
            if entry.get("status") == "available" and not has_content and not entry.get("drills_into"):
                report.warn("%s: status 'available' but nothing to show (placeholder only)" % where)
    return audiences, nodes


def resolve_content(manifest_dir, entry):
    """Real source of record > short body > standard placeholder. Never a broken link."""
    if entry.get("source_md"):
        src = os.path.join(manifest_dir, entry["source_md"])
        if os.path.isfile(src):
            return lc.md_to_html(lc.strip_meta(lc.read_text(src))), entry["source_md"]
        note = ("<p><strong>Source of record not found:</strong> <code>%s</code> - placeholder shown "
                "until it exists.</p>" % html.escape(entry["source_md"]))
        return note + lc.PLACEHOLDERS[entry.get("placeholder_kind") or lc.DEFAULT_PLACEHOLDER], None
    if entry.get("body"):
        return lc.md_to_html(entry["body"]), None
    return lc.PLACEHOLDERS.get(entry.get("placeholder_kind") or lc.DEFAULT_PLACEHOLDER,
                               lc.PLACEHOLDERS[lc.DEFAULT_PLACEHOLDER]), None


def side_nav(pack_title, audiences, nodes, tier_id, node_id):
    parts = ["<nav><h2>%s</h2>" % html.escape(pack_title)]
    parts.append('<a href="../index.html">All tiers</a><a href="../coverage.html">Coverage matrix</a>')
    parts.append("<h2>Tiers</h2>")
    for a in audiences:
        cls = ' class="current"' if a["id"] == tier_id else ""
        target = "../%s/%s" % (a["id"], (node_id + ".html") if node_id else "index.html")
        parts.append('<a href="%s"%s>%s</a>' % (target, cls, html.escape(a["label"])))
    parts.append("<h2>Boxes</h2>")
    parts.append('<a href="index.html"%s>Flowchart</a>' % ("" if node_id else ' class="current"'))
    for n in nodes:
        cls = ' class="current"' if n["id"] == node_id else ""
        parts.append('<a href="%s.html"%s>%s</a>' % (n["id"], cls, html.escape(n["label"])))
    parts.append("</nav>")
    return "".join(parts)


def pack_nav(pack_title, audiences, here_coverage):
    parts = ["<nav><h2>%s</h2>" % html.escape(pack_title)]
    parts.append('<a href="index.html"%s>All tiers</a>' % ("" if here_coverage else ' class="current"'))
    parts.append('<a href="coverage.html"%s>Coverage matrix</a><h2>Tiers</h2>'
                 % (' class="current"' if here_coverage else ""))
    for a in audiences:
        parts.append('<a href="%s/index.html">%s</a>' % (a["id"], html.escape(a["label"])))
    parts.append("</nav>")
    return "".join(parts)


def status_counts(statuses):
    counts = {}
    for s in statuses:
        counts[s] = counts.get(s, 0) + 1
    return ", ".join("%d %s" % (counts[s], s) for s in lc.STATUS_NAMES if s in counts)


def build(manifest_path, out_dir, check_only):
    report = lc.Report()
    manifest_path = os.path.abspath(manifest_path)
    manifest_dir = os.path.dirname(manifest_path)
    manifest = lc.load_json(manifest_path)
    if out_dir is None:
        out_dir = os.path.normpath(os.path.join(manifest_dir, manifest.get("out_dir", ".")))
    out_dir = os.path.abspath(out_dir)
    if not check_only and lc.refuse_inside_kit(out_dir, "the generated pack"):
        return 2
    audiences, nodes = validate(manifest, manifest_dir, report)
    if report.errors:
        print("manifest invalid: " + report.summary())
        return 1

    pack_title = manifest.get("pack_title") or manifest.get("pack_id") or "Pack"
    footer = ("Generated by the abstraction ladder (mode A) from <code>%s</code> - the manifest is the "
              "source of record; this page is build output. Do not hand-edit."
              % html.escape(os.path.basename(manifest_path)))
    boxes = [{"id": n["id"], "label": n["label"], "sublabel": n.get("sublabel"), "row": n.get("row", 0)}
             for n in nodes]
    fitted, canvas_w, canvas_h = lc.layout(boxes, report, auto_x=True)
    if report.errors:
        return 1

    pages = {}            # absolute path -> html
    coverage = []         # (node, tier, status, placeholder?)
    for tier in audiences:
        tid = tier["id"]
        tier_dir = os.path.join(out_dir, tid)
        svg = [lc.svg_open(canvas_w, canvas_h), lc.ARROW_DEFS]
        for n in nodes:
            for target in n.get("edges_to", []):
                svg.append(lc.edge_svg(fitted[n["id"]], fitted[target]))
        for n in nodes:
            entry = tier_entry(n, tid)
            status = entry.get("status", "missing")
            href = n["id"] + ".html"
            if entry.get("drills_into"):
                href = lc.href_between(os.path.join(out_dir, entry["drills_into"]), tier_dir)
                if not check_only and not os.path.isfile(os.path.join(out_dir, entry["drills_into"])):
                    report.warn("node '%s', tier '%s': drills_into '%s' does not exist (yet) in the output"
                                % (n["id"], tid, entry["drills_into"]))
            svg.append(lc.box_svg(href, n.get("css_class", "box"), fitted[n["id"]], lc.STATUS_COLOR[status],
                                  "%s - %s" % (n["label"], status)))
        svg.append("</svg>")
        intro = ('<p>%s</p>' % html.escape(tier["intro"])) if tier.get("intro") else ""
        body = (lc.back_link_html({"href": "../index.html", "label": "the tier picker of " + pack_title})
                + "<h1>%s - %s</h1>%s%s%s" % (html.escape(pack_title), html.escape(tier["label"]), intro,
                                              "\n".join(svg), lc.legend_html()))
        pages[os.path.join(tier_dir, "index.html")] = lc.page(
            "%s - %s" % (pack_title, tier["label"]), side_nav(pack_title, audiences, nodes, tid, None),
            body, lc.BASE_CSS, footer)

        for n in nodes:
            entry = tier_entry(n, tid)
            status = entry.get("status", "missing")
            content, source = resolve_content(manifest_dir, entry)
            placeholder = not entry.get("body") and source is None
            coverage.append((n, tier, status, placeholder))
            drill = ""
            if entry.get("drills_into"):
                drill = ('<p><strong>This box has its own diagram:</strong> <a href="%s">open the drill-down</a>.</p>'
                         % html.escape(lc.href_between(os.path.join(out_dir, entry["drills_into"]), tier_dir)))
            src_line = ("<p class=\"srcline\">Source of record: <code>%s</code> (rendered, never copied).</p>"
                        % html.escape(source)) if source else ""
            leaf = (lc.back_link_html({"href": "index.html", "label": "the %s flowchart" % tier["label"]})
                    + lc.leaf_html(n["label"], lc.badges_html(status, entry.get("pending")), drill + content)
                    + src_line)
            pages[os.path.join(tier_dir, n["id"] + ".html")] = lc.page(
                "%s - %s" % (n["label"], tier["label"]), side_nav(pack_title, audiences, nodes, tid, n["id"]),
                leaf, lc.BASE_CSS, footer)

    # tier picker
    items = []
    for tier in audiences:
        role = (" <em>(for example: %s)</em>" % html.escape(tier["example_role"])) if tier.get("example_role") else ""
        counts = status_counts([s for (_, t, s, _) in coverage if t is tier])
        items.append('<li><a href="%s/index.html">%s</a>%s<br><small>%s</small></li>'
                     % (tier["id"], html.escape(tier["label"]), role, html.escape(counts)))
    picker = (lc.back_link_html(manifest.get("back_link"))
              + "<h1>%s</h1>" % html.escape(pack_title)
              + ("<p>%s</p>" % html.escape(manifest["intro"]) if manifest.get("intro") else "")
              + "<p>Pick an audience tier - tiers differ by depth and purpose, not by job title.</p>"
              + "<ul>%s</ul><p><a href=\"coverage.html\">Coverage matrix</a></p>" % "".join(items))
    pages[os.path.join(out_dir, "index.html")] = lc.page(pack_title, pack_nav(pack_title, audiences, False),
                                                         picker, lc.BASE_CSS, footer)

    # coverage matrix
    rows = ["<tr><th>Box</th>%s</tr>" % "".join("<th>%s</th>" % html.escape(t["label"]) for t in audiences)]
    for n in nodes:
        cells = []
        for (cn, ct, status, placeholder) in coverage:
            if cn is n:
                mark = " <small>(placeholder)</small>" if placeholder else ""
                cells.append('<td><a href="%s/%s.html" style="text-decoration:none">%s</a>%s</td>'
                             % (ct["id"], n["id"], lc.badges_html(status).replace("margin:0 0 18px", "margin:0"), mark))
        rows.append("<tr><td>%s</td>%s</tr>" % (html.escape(n["label"]), "".join(cells)))
    all_statuses = [s for (_, _, s, _) in coverage]
    cov = (lc.back_link_html({"href": "index.html", "label": "the tier picker"})
           + "<h1>%s - coverage</h1><p>%s. %d of %d box/tier pairs show a placeholder.</p><table>%s</table>%s"
           % (html.escape(pack_title), html.escape(status_counts(all_statuses)),
              sum(1 for c in coverage if c[3]), len(coverage), "".join(rows), lc.legend_html()))
    pages[os.path.join(out_dir, "coverage.html")] = lc.page(pack_title + " - coverage",
                                                            pack_nav(pack_title, audiences, True), cov,
                                                            lc.BASE_CSS, footer)

    undeclared = sum(1 for n in nodes for t in audiences if tier_entry(n, t["id"]).get("_undeclared"))
    if check_only:
        print("check only: %d tiers x %d boxes; %d pair(s) undeclared (rendered as missing); %s"
              % (len(audiences), len(nodes), undeclared, report.summary()))
        return 1 if report.errors else 0

    for path, text in sorted(pages.items()):
        lc.write_text(path, text)
    written = set(os.path.normcase(p) for p in pages)
    for tier in audiences:
        tier_dir = os.path.join(out_dir, tier["id"])
        for name in sorted(os.listdir(tier_dir)):
            path = os.path.join(tier_dir, name)
            if name.endswith(".html") and os.path.normcase(path) not in written:
                report.warn("orphan page from an earlier build: %s/%s (box removed?) - delete it" % (tier["id"], name))
    print("built %d tiers x %d boxes = %d leaf pages + %d flowcharts + tier picker + coverage -> %s"
          % (len(audiences), len(nodes), len(audiences) * len(nodes), len(audiences), out_dir))
    print("statuses: %s; %d pair(s) undeclared (rendered as missing + placeholder); %s"
          % (status_counts(all_statuses), undeclared, report.summary()))
    return 1 if report.errors else 0


def main(argv=None):
    lc.setup_console()
    ap = argparse.ArgumentParser(description="Abstraction ladder, mode A: manifest -> one flowchart pack per audience tier")
    ap.add_argument("manifest", help="path to the pack's manifest.json (the source of record)")
    ap.add_argument("--out", help="output folder (default: the manifest's out_dir, else its own folder); never inside the kit")
    ap.add_argument("--check", action="store_true", help="validate the manifest only, write nothing")
    args = ap.parse_args(argv)
    if not os.path.isfile(args.manifest):
        print("error: manifest not found: %s" % args.manifest, file=sys.stderr)
        return 2
    return build(args.manifest, args.out, args.check)


if __name__ == "__main__":
    sys.exit(main())
