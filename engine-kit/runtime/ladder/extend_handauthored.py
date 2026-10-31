#!/usr/bin/env python3
"""extend_handauthored.py - abstraction ladder, mode B: extend an approved hand-authored page,
or build a blank canvas in its visual family.

Use mode B when a hand-authored diagram already exists and was approved (visual fidelity
to it matters more than auto-scaling across tiers), or for a brand-new drill-down that
must read as part of the same system. Driven by one extension spec (JSON) per diagram -
the spec is the source of record, the HTML is build output. See extend.example.json.

Two diagram shapes (one per spec):
  extend        `source_html` + `output_html`: read the approved page, add boxes in its own
                SVG style (explicit x/y: only the height auto-grows), grow its viewBox, apply
                text replacements, add a back-link, swap its legend for the shared one, pin
                the diagram to its real scale. The source page is NEVER modified (checked by
                hash) and the output may not overwrite it.
  blank canvas  `new_boxes` without `source_html`: a new diagram reusing the parent's CSS
                (`css_from`: a .css file or the parent's .html; or `build_py`'s CSS), boxes
                placed by `row` (preferred) or explicit `y`, auto-fit, auto-sized canvas.
Both may declare `leaf_pages`, each rendered LOCALLY from a real `source_md` (or a short
`body_md`) with its own back-link - never a link into the pack being extended, whose own
navigation would loop the reader back to the un-extended page.

Optional `build_py`: a parent pack's build script exposing CSS, md_to_html(md) and
nav_html(current); imported by path so leaf pages share its renderer and navigation.
Status badges, dots and the legend always come from ladder_common (one vocabulary).

Usage:
  python extend_handauthored.py <extend-spec.json> [--out-root DIR]

Input paths (source_html, css_from, build_py, source_md) resolve against the spec's
folder; output paths against --out-root (default: the spec's folder). Never writes
inside the kit. Exit 1 on any error. Python 3.8+, standard library only.
"""

import argparse
import hashlib
import html
import importlib.util
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ladder_common as lc  # noqa: E402


def sha256(path):
    with open(path, "rb") as handle:
        return hashlib.sha256(handle.read()).hexdigest()


def load_build_module(path):
    spec = importlib.util.spec_from_file_location("_parent_pack_build", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def box_dot(box, report, where):
    status = box.get("status")
    if status:
        lc.check_status(status, where, report)
    elif not box.get("status_color"):
        report.warn("%s: no status - every box shows one (status_color is a parity override only)" % where)
    return box.get("status_color") or lc.STATUS_COLOR.get(status or "")


def check_box_fields(boxes, report):
    seen = set()
    for b in boxes:
        for field in ("id", "label", "href"):
            if not b.get(field):
                report.error("box %s: `%s` is required (every box resolves to a real page)"
                             % (b.get("id", "?"), field))
        if b.get("id") in seen:
            report.error("box id '%s' declared twice" % b.get("id"))
        seen.add(b.get("id"))
    ids = set(b.get("id") for b in boxes)
    for b in boxes:
        for target in b.get("edges_to", []):
            if target not in ids:
                report.error("box '%s': edges_to '%s' is not a box of this spec" % (b.get("id"), target))


def compose_css(spec, spec_dir, build_mod, report):
    """Kit base + the parent's stylesheet (reused, never hand-copied) + the spec's addition.
    Computed once per spec."""
    if "_css" in spec:
        return spec["_css"]
    css = lc.BASE_CSS
    parent = None
    if build_mod is not None and getattr(build_mod, "CSS", None):
        parent = build_mod.CSS
    elif spec.get("css_from") or spec.get("source_html"):
        # extend shape: leaf pages reuse the approved page's own stylesheet by default
        rel = spec.get("css_from") or spec["source_html"]
        path = os.path.join(spec_dir, rel)
        if os.path.isfile(path):
            parent = lc.css_from_file(path)
        else:
            report.warn("css_from not found: %s - using the kit's base stylesheet" % rel)
    if parent:
        css += "\n/* parent pack stylesheet (reused, never hand-copied) */\n" + lc.pin_svg_scale(parent)
    spec["_css"] = css + "\n" + spec.get("css_addition", "")
    return spec["_css"]


# ---------------------------------------------------------------------------
# extend shape

def extend_diagram(spec, spec_dir, out_root, report):
    src = os.path.abspath(os.path.join(spec_dir, spec["source_html"]))
    out = os.path.abspath(os.path.join(out_root, spec["output_html"]))
    if os.path.normcase(src) == os.path.normcase(out):
        report.error("output_html resolves to the source page itself - mode B never edits the approved page")
        return None, None
    if not os.path.isfile(src):
        report.error("source_html not found: %s" % spec["source_html"])
        return None, None
    before = sha256(src)
    text = lc.read_text(src)

    # the diagram: first <svg> with a viewBox; pin it to its real scale, optionally grow it
    tag = re.search(r"<svg\b[^>]*\bviewBox=\"\s*0\s+0\s+([\d.]+)\s+([\d.]+)\s*\"[^>]*>", text)
    if not tag:
        report.error("source_html has no <svg viewBox=\"0 0 W H\"> diagram to extend")
        return None, None
    vb_w, vb_h = float(tag.group(1)), float(tag.group(2)) + float(spec.get("viewbox_grow_height", 0))
    attrs = re.sub(r"\s(width|height)=\"[^\"]*\"", "", tag.group(0))
    attrs = re.sub(r"\bviewBox=\"[^\"]*\"", 'viewBox="0 0 %g %g" width="%g" height="%g"' % (vb_w, vb_h, vb_w, vb_h), attrs)
    if re.search(r"\sclass=\"", attrs):
        attrs = re.sub(r"\sclass=\"([^\"]*)\"", r' class="\1 ladder"', attrs, count=1)
    else:
        attrs = attrs.replace("<svg", '<svg class="ladder"', 1)
    text = text[:tag.start()] + attrs + text[tag.end():]
    svg_start = tag.start()

    # stylesheet: pin the scale, add the spec's CSS
    text = re.sub(r"(<style[^>]*>)(.*?)(</style>)", lambda m: m.group(1) + lc.pin_svg_scale(m.group(2)) + m.group(3),
                  text, flags=re.S | re.I)
    addition = (spec.get("css_addition", "") + "\n" + lc.SCALE_PIN_CSS).strip()
    marker = spec.get("css_insert_after_marker")
    if marker and marker in text:
        text = text.replace(marker, marker + "\n" + addition, 1)
    else:
        if marker:
            report.warn("css_insert_after_marker not found - CSS added before </style>")
        if "</style>" in text:
            text = text.replace("</style>", addition + "\n</style>", 1)
        else:
            text = text.replace("</head>", "<style>%s</style>\n</head>" % addition, 1)

    # new boxes: explicit x/y, height grows, width never grows (we cannot see the artwork)
    boxes = spec.get("new_boxes", [])
    check_box_fields(boxes, report)
    for b in boxes:
        if "x" not in b or "y" not in b:
            report.error("box '%s': extending a page needs explicit x and y" % b.get("id"))
    if report.errors:
        return None, None
    placed = [dict(((k, v) for k, v in b.items() if k != "row"), width_cap=0) for b in boxes]
    fitted = {}
    if placed:
        fitted, _, _ = lc.layout(placed, report)
    insert = []
    for b in boxes:
        f = fitted[b["id"]]
        if f["y"] + f["h"] > vb_h:
            report.warn("box '%s' ends at y=%d, below the viewBox height %g - raise viewbox_grow_height"
                        % (b["id"], f["y"] + f["h"], vb_h))
        insert.append(lc.box_svg(b["href"], b.get("css_class", "box"), f, box_dot(b, report, "box '%s'" % b["id"]),
                                 "%s - %s" % (b["label"], b.get("status", ""))))
    if spec.get("caption"):
        c = spec["caption"]
        for b in boxes:
            f = fitted[b["id"]]
            if f["x"] <= float(c["x"]) <= f["x"] + f["w"] and f["y"] <= float(c["y"]) <= f["y"] + f["h"] + 4:
                report.warn("the caption at y=%s falls on box '%s' (now %d..%d after auto-fit) - move it"
                            % (c["y"], b["id"], f["y"], f["y"] + f["h"]))
        insert.append('<text x="%s" y="%s" text-anchor="middle" style="font-size:11px;fill:#57606f">%s</text>'
                      % (c["x"], c["y"], html.escape(c["text"])))
    svg_marker = spec.get("svg_insert_marker", "</svg>")
    pos = text.find(svg_marker, svg_start)
    if insert:
        if pos < 0:
            report.error("svg_insert_marker not found after the diagram's <svg> tag")
            return None, None
        text = text[:pos] + "\n".join(insert) + "\n" + text[pos:]

    for r in spec.get("text_replacements", []):
        if r["old"] not in text:
            report.warn("text replacement target not found, skipped: %s" % r["old"][:60])
            continue
        text = text.replace(r["old"], r["new"])

    if spec.get("back_link"):
        main = re.search(r"<main\b[^>]*>", text) or re.search(r"<body\b[^>]*>", text)
        if main:
            text = text[:main.end()] + "\n" + lc.back_link_html(spec["back_link"]) + text[main.end():]
    elif not spec.get("root"):
        report.warn("no back_link on the extended page - only the true root of a map may skip it (set \"root\": true)")

    # one legend: swap the page's own, or add it under the diagram
    if spec.get("legend", True):
        text, swapped = re.subn(r"<div class=\"legend\"[^>]*>.*?</div>", lc.legend_html(), text, count=1, flags=re.S)
        if not swapped:
            end = text.find("</svg>", svg_start)
            if end >= 0:
                text = text[:end + 6] + "\n" + lc.legend_html() + text[end + 6:]

    lc.write_text(out, text)
    if sha256(src) != before:
        report.error("the source page changed during the run - it must stay untouched")
    else:
        print("source page untouched: %s (sha256 %s)" % (spec["source_html"], before[:16]))
    print("extended diagram written: %s (%d new box(es))" % (out, len(boxes)))
    return out, boxes


# ---------------------------------------------------------------------------
# blank canvas shape

def blank_canvas(spec, spec_dir, out_root, build_mod, report):
    out = os.path.abspath(os.path.join(out_root, spec["output_html"]))
    boxes = spec.get("new_boxes", [])
    check_box_fields(boxes, report)
    if report.errors:
        return None, None
    fitted, auto_w, auto_h = lc.layout(boxes, report)
    if report.errors:
        return None, None
    floor = spec.get("viewbox") or [0, 0]
    vb_w, vb_h = max(int(floor[0]), auto_w), max(int(floor[1]), auto_h)
    svg = [lc.svg_open(vb_w, vb_h), lc.ARROW_DEFS]
    for b in boxes:
        for target in b.get("edges_to", []):
            svg.append(lc.edge_svg(fitted[b["id"]], fitted[target]))
    for b in boxes:
        svg.append(lc.box_svg(b["href"], b.get("css_class", "box"), fitted[b["id"]],
                              box_dot(b, report, "box '%s'" % b["id"]), "%s - %s" % (b["label"], b.get("status", ""))))
    svg.append("</svg>")
    if not spec.get("back_link") and not spec.get("root"):
        report.warn("no back_link on the diagram - only the true root of a map may skip it (set \"root\": true)")
    title = spec.get("title", "Diagram")
    body = (lc.back_link_html(spec.get("back_link")) + "<h1>%s</h1>" % html.escape(spec.get("h1", title))
            + ("<p>%s</p>" % spec["intro"] if spec.get("intro") else "") + "\n".join(svg)
            + (lc.legend_html() if spec.get("legend", True) else ""))
    footer = spec.get("srcline") or ("Generated by the abstraction ladder (mode B, blank canvas) from <code>%s</code> - "
                                     "the spec is the source of record. Do not hand-edit."
                                     % html.escape(spec.get("_spec_name", "the spec")))
    lc.write_text(out, lc.page(title, spec.get("nav_html", "<nav></nav>"), body,
                               compose_css(spec, spec_dir, build_mod, report), footer))
    print("blank-canvas diagram written: %s (%d boxes, %dx%d)" % (out, len(boxes), vb_w, vb_h))
    return out, boxes


# ---------------------------------------------------------------------------
# leaf pages

def render_leaves(spec, spec_dir, out_root, build_mod, report):
    css = compose_css(spec, spec_dir, build_mod, report)
    md_to_html = getattr(build_mod, "md_to_html", None) or lc.md_to_html
    written = []
    for leaf in spec.get("leaf_pages", []):
        if not leaf.get("output_html"):
            report.error("a leaf page has no output_html")
            continue
        where = "leaf '%s'" % leaf["output_html"]
        status = leaf.get("status", "draft")
        lc.check_status(status, where, report)
        source = None
        if leaf.get("body_md") is not None:
            md = leaf["body_md"]
        elif leaf.get("source_md"):
            path = os.path.join(spec_dir, leaf["source_md"])
            if not os.path.isfile(path):
                report.warn("%s: source_md not found (%s) - placeholder rendered" % (where, leaf["source_md"]))
                md = None
            else:
                md = lc.strip_meta(lc.read_text(path))
                source = leaf["source_md"]
        else:
            md = None
        if md is None:
            body = lc.PLACEHOLDERS.get(leaf.get("placeholder_kind") or lc.DEFAULT_PLACEHOLDER,
                                       lc.PLACEHOLDERS[lc.DEFAULT_PLACEHOLDER])
        else:
            for old, new in leaf.get("md_replace", []):
                md = md.replace(old, new)
            body = md_to_html(md)
        if "nav_current" in leaf and build_mod is not None and hasattr(build_mod, "nav_html"):
            nav = build_mod.nav_html(leaf["nav_current"])
            for old, new in spec.get("nav_postprocess", []):
                nav = nav.replace(old, new)
        else:
            if "nav_current" in leaf:
                report.warn("%s: nav_current needs a build_py with nav_html(current) - using leaf_nav_html" % where)
            nav = leaf.get("nav_html", spec.get("leaf_nav_html", "<nav></nav>"))
        back = leaf.get("back_link", spec.get("leaf_back_link"))
        if not back:
            report.warn("%s: no back_link (set leaf_back_link once for every leaf)" % where)
        src_line = (" Source of record: <code>%s</code> (rendered, never copied)." % html.escape(source)) if source else ""
        footer = (leaf.get("srcline") or "Generated by the abstraction ladder (mode B) from <code>%s</code>. Do not hand-edit."
                  % html.escape(spec.get("_spec_name", "the spec"))) + src_line
        out = os.path.abspath(os.path.join(out_root, leaf["output_html"]))
        title = leaf.get("title") or os.path.splitext(os.path.basename(leaf["output_html"]))[0]
        lc.write_text(out, lc.page(title, nav, lc.back_link_html(back)
                                   + lc.leaf_html(title, lc.badges_html(status, leaf.get("pending")), body), css, footer))
        written.append(out)
        print("leaf page written: %s" % out)
    return written


def check_box_targets(page_path, boxes, report):
    """Every box must resolve to a real page (a diagram, a leaf, or a placeholder leaf)."""
    for b in boxes or []:
        target = lc.resolve_href(b.get("href", ""), os.path.dirname(page_path))
        if target and not os.path.isfile(target):
            report.warn("box '%s' links to '%s', which does not exist yet - build it (diagram before prose) "
                        "or give the box a placeholder leaf" % (b["id"], b["href"]))


def main(argv=None):
    lc.setup_console()
    ap = argparse.ArgumentParser(description="Abstraction ladder, mode B: extend an approved hand-authored "
                                             "diagram or build a blank canvas in its visual family")
    ap.add_argument("spec", help="path to the extend-spec JSON (the source of record)")
    ap.add_argument("--out-root", help="folder output paths resolve against (default: the spec's folder); never inside the kit")
    args = ap.parse_args(argv)
    if not os.path.isfile(args.spec):
        print("error: spec not found: %s" % args.spec, file=sys.stderr)
        return 2
    spec_path = os.path.abspath(args.spec)
    spec_dir = os.path.dirname(spec_path)
    out_root = os.path.abspath(args.out_root) if args.out_root else spec_dir
    if lc.refuse_inside_kit(out_root, "the rendered diagram"):
        return 2
    spec = lc.load_json(spec_path)
    spec["_spec_name"] = os.path.basename(spec_path)
    report = lc.Report()

    build_mod = None
    if spec.get("build_py"):
        path = os.path.join(spec_dir, spec["build_py"])
        if os.path.isfile(path):
            build_mod = load_build_module(path)
        else:
            report.warn("build_py not found: %s - using the kit's renderer" % spec["build_py"])

    page_path, boxes = None, None
    if spec.get("source_html"):
        if not spec.get("output_html"):
            report.error("`output_html` is required")
        else:
            page_path, boxes = extend_diagram(spec, spec_dir, out_root, report)
    elif spec.get("new_boxes"):
        if not spec.get("output_html"):
            report.error("`output_html` is required")
        else:
            page_path, boxes = blank_canvas(spec, spec_dir, out_root, build_mod, report)
    elif not spec.get("leaf_pages"):
        report.error("the spec has neither source_html, new_boxes nor leaf_pages - nothing to build")
    if not report.errors and spec.get("leaf_pages"):
        render_leaves(spec, spec_dir, out_root, build_mod, report)
    if page_path:
        check_box_targets(page_path, boxes, report)
    print(report.summary())
    return 1 if report.errors else 0


if __name__ == "__main__":
    sys.exit(main())
