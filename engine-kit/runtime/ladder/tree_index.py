#!/usr/bin/env python3
"""tree_index.py - one machine-readable graph of a whole abstraction tree (engine-kit runtime).

Deterministic scan of every mode B extension spec (default name: extend-spec.json) and
every mode A manifest (default name: manifest.json) under --root, emitting ONE JSON
graph of the tree: diagrams, boxes, leaf pages and sources of record, with subject
keywords per node, so agents query the chaining instead of re-deriving it from hrefs.

  node types  diagram | box | leaf | source_md
  edge kinds  contains (diagram -> box)      flow (box -> box)
              drills_into (box -> diagram)   opens (box -> leaf/page)
              renders (diagram -> leaf)      rendered_from (leaf -> source_md)
              links_to (diagram -> diagram, via intro/nav/picker)
              back (page -> the page it drilled down from)

Every leaf and box carries its semantic `status` (a box without one inherits it from the
page it opens, else from its dot colour); `stats.by_status` is the honesty overview of the
whole map. Every page node carries `exists`; `unresolved` lists pages the tree promises
that are not on disk (rebuild the pack, or fix the box); `conflicts` lists pages claimed
by two specs/manifests (a re-run of one overwrites the other - e.g. an approved page
routed through the generic generator). `roots` are the diagrams with no way back -
normally exactly one.

Derived artifact: never hand-edited; rebuild after every spec or manifest change - a stale
graph is the same bug as a stale registry. Paths in the graph are relative to --base
(default: --root) with '/' separators, so the file is valid for every checkout. Keywords
are deterministic tokens; semantic vectors belong to a later retrieval layer.

Usage:
  python tree_index.py --root <map-root> --out <abstraction-tree.json>
                       [--base DIR] [--spec-name NAME] [--manifest-name NAME]

Never writes inside the kit. Python 3.8+, standard library only.
"""

import argparse
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ladder_common as lc  # noqa: E402

STOP = set(
    "the a an of and or to for in on with from is are was were it its this that these those very "
    "every how what when where who all one two out not no yes into over per via more than only ever "
    "never also same own new html index page box".split()
)
HEX_HINT = dict((color, name) for name, color, _, _ in reversed(lc.STATUSES))
# colour hints used by hand-authored pages before statuses were semantic
HEX_HINT.update({"#9a6700": "draft"})


def keywords(*texts):
    words = []
    for t in texts:
        if not t:
            continue
        t = re.sub(r"<[^>]+>", " ", t)
        for w in re.findall(r"[A-Za-z][A-Za-z0-9_-]{2,}", t.lower()):
            w = w.strip("-_")
            if w and w not in STOP and w not in words:
                words.append(w)
    return words[:12]


class Graph(object):
    def __init__(self, base):
        self.base = base
        self.nodes = {}
        self.edges = []
        self.conflicts = []

    def rel(self, path):
        try:
            return os.path.relpath(os.path.abspath(path), self.base).replace(os.sep, "/")
        except ValueError:      # another drive: keep it absolute, as the spec declared it
            return os.path.abspath(path).replace(os.sep, "/")

    def node(self, nid, **kw):
        n = self.nodes.setdefault(nid, {"id": nid})
        claimed = n.get("spec")
        if claimed and kw.get("spec") and kw["spec"] != claimed:
            # one page, two sources of record: a re-run of either overwrites the other
            self.conflicts.append({"page": nid, "sources": sorted([claimed, kw["spec"]])})
            for key, value in kw.items():
                if value not in (None, [], "") and key not in n:
                    n[key] = value
            return n
        for key, value in kw.items():
            if value not in (None, [], ""):
                n[key] = value
        return n

    def edge(self, src, dst, kind):
        self.edges.append({"from": src, "to": dst, "kind": kind})


def source_keywords(path):
    if not os.path.isfile(path):
        return []
    text = lc.strip_meta(lc.read_text(path))
    h1 = re.search(r"^#\s+(.+)$", text, flags=re.M)
    return keywords(h1.group(1) if h1 else "", text[:400])


def scan_spec(g, spec_path):
    d = os.path.dirname(spec_path)
    spec = lc.load_json(spec_path)
    page = os.path.join(d, spec.get("output_html", "index.html"))
    diag = g.rel(page)
    g.node(diag, type="diagram", mode="B-extend" if spec.get("source_html") else "B-canvas",
           label=spec.get("h1") or spec.get("title") or diag, spec=g.rel(spec_path),
           extends=g.rel(os.path.join(d, spec["source_html"])) if spec.get("source_html") else None,
           keywords=keywords(spec.get("title"), spec.get("intro")))
    back = (spec.get("back_link") or {}).get("href")
    if back:
        g.edge(diag, g.rel(os.path.join(os.path.dirname(page), back)), "back")
    for blob in (spec.get("intro", ""), spec.get("nav_html", "")):
        for href in re.findall(r'href="([^"]+)"', blob):
            target = lc.resolve_href(href, os.path.dirname(page))
            if target and target.lower().endswith("index.html") and g.rel(target) != diag:
                g.edge(diag, g.rel(target), "links_to")
    for b in spec.get("new_boxes", []):
        bid = "%s#%s" % (diag, b["id"])
        g.node(bid, type="box", label=b.get("label"), sublabel=b.get("sublabel"), status=b.get("status"),
               status_color=b.get("status_color"), keywords=keywords(b.get("label"), b.get("sublabel")))
        g.edge(diag, bid, "contains")
        target = lc.resolve_href(b.get("href", ""), os.path.dirname(page))
        if target:
            g.edge(bid, g.rel(target), "opens")      # promoted to drills_into once diagrams are known
        for e in b.get("edges_to", []):
            g.edge(bid, "%s#%s" % (diag, e), "flow")
    leaf_back = spec.get("leaf_back_link")
    for leaf in spec.get("leaf_pages", []):
        out = os.path.join(d, leaf["output_html"])
        lid = g.rel(out)
        g.node(lid, type="leaf", label=leaf.get("title") or os.path.basename(lid), status=leaf.get("status"),
               pending=leaf.get("pending") or [], spec=g.rel(spec_path),
               keywords=keywords(leaf.get("title"), (leaf.get("body_md") or "")[:400]))
        g.edge(diag, lid, "renders")
        back = (leaf.get("back_link") or leaf_back or {}).get("href")
        if back:
            g.edge(lid, g.rel(os.path.join(os.path.dirname(out), back)), "back")
        if leaf.get("source_md"):
            src = os.path.join(d, leaf["source_md"])
            sid = g.rel(src)
            g.node(sid, type="source_md", label=os.path.basename(src), keywords=source_keywords(src))
            g.edge(lid, sid, "rendered_from")


def scan_manifest(g, manifest_path):
    d = os.path.dirname(manifest_path)
    man = lc.load_json(manifest_path)
    out = os.path.normpath(os.path.join(d, man.get("out_dir", ".")))
    picker = g.rel(os.path.join(out, "index.html"))
    title = man.get("pack_title") or man.get("pack_id") or picker
    g.node(picker, type="diagram", mode="A-picker", label=title, spec=g.rel(manifest_path),
           keywords=keywords(title, man.get("intro")))
    back = (man.get("back_link") or {}).get("href")
    if back:
        g.edge(picker, g.rel(os.path.join(out, back)), "back")
    for tier in man.get("audiences", []):
        tid = tier["id"]
        tier_dir = os.path.join(out, tid)
        tpage = g.rel(os.path.join(tier_dir, "index.html"))
        g.node(tpage, type="diagram", mode="A-tier", tier=tid, label="%s - %s" % (title, tier.get("label", tid)),
               spec=g.rel(manifest_path), keywords=keywords(title, tier.get("label")))
        g.edge(picker, tpage, "links_to")
        g.edge(tpage, picker, "back")
        for n in man.get("nodes", []):
            entry = (n.get("audience") or {}).get(tid) or {"status": "missing"}
            bid = "%s#%s" % (tpage, n["id"])
            lid = g.rel(os.path.join(tier_dir, n["id"] + ".html"))
            g.node(bid, type="box", label=n.get("label"), sublabel=n.get("sublabel"),
                   status=entry.get("status", "missing"), keywords=keywords(n.get("label"), n.get("sublabel")))
            g.edge(tpage, bid, "contains")
            if entry.get("drills_into"):
                g.edge(bid, g.rel(os.path.join(out, entry["drills_into"])), "opens")
            g.edge(bid, lid, "opens")
            for e in n.get("edges_to", []):
                g.edge(bid, "%s#%s" % (tpage, e), "flow")
            g.node(lid, type="leaf", label="%s - %s" % (n.get("label"), tier.get("label", tid)),
                   status=entry.get("status", "missing"), pending=entry.get("pending") or [],
                   spec=g.rel(manifest_path), keywords=keywords(n.get("label"), (entry.get("body") or "")[:400]))
            g.edge(tpage, lid, "renders")
            g.edge(lid, tpage, "back")
            if entry.get("source_md"):
                src = os.path.join(d, entry["source_md"])
                sid = g.rel(src)
                g.node(sid, type="source_md", label=os.path.basename(src), keywords=source_keywords(src))
                g.edge(lid, sid, "rendered_from")


def finish(g):
    seen, edges = set(), []
    for e in g.edges:
        key = (e["from"], e["to"], e["kind"])
        if key not in seen:
            seen.add(key)
            edges.append(e)
    diagrams = set(nid for nid, n in g.nodes.items() if n.get("type") == "diagram")
    for e in edges:
        if e["kind"] == "opens" and e["to"] in diagrams:
            e["kind"] = "drills_into"
    # box status: declared > status of the page it opens > colour hint
    opens = {}
    for e in edges:
        if e["kind"] in ("opens", "drills_into"):
            opens.setdefault(e["from"], e["to"])
    for n in g.nodes.values():
        if n.get("type") != "box":
            continue
        if not n.get("status"):
            target = g.nodes.get(opens.get(n["id"], ""), {})
            if target.get("status"):
                n["status"] = target["status"]
            elif (n.get("status_color") or "").lower() in HEX_HINT:
                n["status"] = HEX_HINT[n["status_color"].lower()]
        n.pop("status_color", None)
    # pages the tree promises: do they exist?
    unresolved = []
    for n in g.nodes.values():
        if n.get("type") in ("diagram", "leaf", "source_md"):
            n["exists"] = os.path.isfile(os.path.join(g.base, n["id"].replace("/", os.sep)))
            if not n["exists"]:
                unresolved.append(n["id"])
    for e in edges:
        if e["kind"] in ("opens", "drills_into", "back", "links_to") and e["to"] not in g.nodes:
            path = os.path.join(g.base, e["to"].replace("/", os.sep))
            if not os.path.isfile(path) and e["to"] not in unresolved:
                unresolved.append(e["to"])
    backs = set(e["from"] for e in edges if e["kind"] == "back")
    roots = sorted(d for d in diagrams if d not in backs)
    nodes = sorted(g.nodes.values(), key=lambda n: n["id"])
    by_status = {}
    for n in nodes:
        if n.get("status"):
            by_status[n["status"]] = by_status.get(n["status"], 0) + 1
    stats = {
        "nodes": len(nodes),
        "edges": len(edges),
        "diagrams": len(diagrams),
        "boxes": sum(1 for n in nodes if n.get("type") == "box"),
        "leaves": sum(1 for n in nodes if n.get("type") == "leaf"),
        "sources_of_record": sum(1 for n in nodes if n.get("type") == "source_md"),
        "by_status": dict((s, by_status[s]) for s in sorted(by_status)),
        "unresolved": len(unresolved),
        "conflicts": len(g.conflicts),
    }
    unknown = sorted(s for s in by_status if s not in lc.STATUS_NAMES)
    return {
        "_comment": "Derived artifact - the abstraction-tree graph. Rebuild with runtime/ladder/tree_index.py "
                    "after every spec or manifest change; never hand-edit.",
        "roots": roots,
        "stats": stats,
        "unknown_statuses": unknown,
        "unresolved": sorted(unresolved),
        "conflicts": g.conflicts,
        "nodes": nodes,
        "edges": edges,
    }


def main(argv=None):
    lc.setup_console()
    ap = argparse.ArgumentParser(description="Build the abstraction-tree graph (derived, never hand-edited)")
    ap.add_argument("--root", required=True, help="folder holding the map's specs and manifests (scanned recursively)")
    ap.add_argument("--out", required=True, help="graph file to (re)write, outside the kit")
    ap.add_argument("--base", help="folder the node ids are relative to (default: --root)")
    ap.add_argument("--spec-name", default="extend-spec.json", help="file name of mode B specs (default: extend-spec.json)")
    ap.add_argument("--manifest-name", default="manifest.json", help="file name of mode A manifests (default: manifest.json)")
    args = ap.parse_args(argv)
    root = os.path.abspath(args.root)
    if not os.path.isdir(root):
        print("error: root not found: %s" % root, file=sys.stderr)
        return 2
    if lc.refuse_inside_kit(args.out, "the abstraction-tree graph"):
        return 2
    g = Graph(os.path.abspath(args.base) if args.base else root)
    specs, manifests = [], []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(x for x in dirnames if x not in (".git", ".svn", "node_modules", "__pycache__"))
        if args.spec_name in filenames:
            specs.append(os.path.join(dirpath, args.spec_name))
        if args.manifest_name in filenames:
            manifests.append(os.path.join(dirpath, args.manifest_name))
    for path in specs:
        scan_spec(g, path)
    for path in manifests:
        scan_manifest(g, path)
    graph = finish(g)
    graph["scanned"] = {"specs": [g.rel(p) for p in specs], "manifests": [g.rel(p) for p in manifests]}
    lc.write_text(os.path.abspath(args.out), json.dumps(graph, indent=2, ensure_ascii=False) + "\n")
    print("abstraction-tree graph written: %s (%d spec(s), %d manifest(s))" % (args.out, len(specs), len(manifests)))
    print(json.dumps(dict(graph["stats"], roots=graph["roots"]), indent=2))
    if graph["unknown_statuses"]:
        print("WARNING: statuses outside the fixed vocabulary: %s" % ", ".join(graph["unknown_statuses"]))
    for c in graph["conflicts"]:
        print("WARNING: %s is produced by two sources of record (%s) - keep one" % (c["page"], " and ".join(c["sources"])))
    if graph["unresolved"]:
        print("WARNING: %d page(s) promised by the tree are not on disk (first: %s)"
              % (len(graph["unresolved"]), graph["unresolved"][0]))
    return 0


if __name__ == "__main__":
    sys.exit(main())
