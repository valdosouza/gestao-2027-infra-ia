#!/usr/bin/env python3
"""ladder_common.py - shared pieces of the abstraction-ladder tools (engine-kit runtime).

One definition of everything the two renderers must agree on - generator.py
(mode A, one manifest -> many audience tiers) and extend_handauthored.py (mode B,
extend an approved hand-authored page or build a blank canvas) - so the two modes
cannot drift apart:

  - the fixed status vocabulary, its colours and meanings, and the legend built from it
  - the three placeholder bodies (a box never points at nothing)
  - the markdown-subset renderer for leaf pages
  - box auto-fit: text wraps and the box grows; nobody hand-tunes pixels
  - row layout and edge drawing for flowcharts
  - the base stylesheet, the back-link, the badges and the page shell
  - the same-real-scale rule: every diagram <svg> carries width/height equal to its
    viewBox and the stylesheet only lets it shrink (max-width:100%), never stretch

Not a command: imported by the scripts next to it. Python 3.8+, standard library only.
"""

import html
import json
import os
import re
import sys
import textwrap

KIT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# ---------------------------------------------------------------------------
# Status vocabulary - FIXED. Adding a word is a decision for the method's owner
# (a decision round), not a bug fix. The legend, the badges, the box dots and the
# validators all read this one table.
# (name, dot colour, badge text colour, meaning shown as the legend hover hint)
STATUSES = [
    ("available", "#1a7f37", "#ffffff",
     "Operating or validated reality: the content passed its per-node validation round. "
     "A box only turns green through that sign-off, never silently."),
    ("draft", "#d4a72c", "#3b2d00",
     "Real content, validation pending - or partly still design; the page's pending notes "
     "say exactly which part."),
    ("pending", "#e16f24", "#ffffff",
     "Designed, not built yet: the box exists in the plan, its content does not."),
    ("pointer", "#0969da", "#ffffff",
     "Documented outside this pack (a wiki, another tool): cited, not rewritten; depth deferred."),
    ("redirect", "#6e7fbd", "#ffffff",
     "The content lives at another box or page; this one forwards the reader there."),
    ("pdf", "#8250df", "#ffffff",
     "The source exists only as a PDF: linked with its location, not reproduced."),
    ("deferred", "#57606f", "#ffffff",
     "Consciously postponed or out of scope for this tier: a placeholder by design."),
    ("missing", "#cf222e", "#ffffff",
     "The gap to fill: known and tracked, not documented yet."),
    ("stale", "#bf3989", "#ffffff",
     "Was valid, but its source changed since the last validation: revalidate before trusting it."),
]
STATUS_NAMES = [s[0] for s in STATUSES]
STATUS_COLOR = dict((s[0], s[1]) for s in STATUSES)
STATUS_TEXT = dict((s[0], s[2]) for s in STATUSES)
STATUS_MEANING = dict((s[0], s[3]) for s in STATUSES)
NEUTRAL_COLOR = "#57606f"

# Every box resolves to a real document or to one of these placeholders.
PLACEHOLDERS = {
    "not_available": "<p><em>Information not available.</em> This box exists and is tracked, "
                     "but no content has been written for this audience tier yet.</p>",
    "confidential": "<p><em>Confidential information.</em> This box's content exists but is "
                    "restricted for this audience tier - ask the pack owner for access.</p>",
    "diagram_only": "<p><em>Flow representation only.</em> This box is intentionally "
                    "diagram-only for this audience tier - no deeper prose is planned.</p>",
}
DEFAULT_PLACEHOLDER = "not_available"

ID_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")

# ---------------------------------------------------------------------------
# Box auto-fit and layout constants. A box's declared width/height are MINIMUMS.
BOX_MIN_W, BOX_MIN_H = 200, 56
BOX_PAD_X = 14
TITLE_FONT, SUB_FONT = 13, 11
TITLE_LINE_H, SUB_LINE_H = 16, 14
BOX_TOP_PAD, BOX_TITLE_SUB_GAP, BOX_BOTTOM_PAD = 24, 8, 12
MAX_WIDTH_GROWTH = 100   # hard cap; manual-x layouts also cap by the gap to the row neighbour
ROW_GAP = 28             # vertical gap between rows
COL_GAP = 40             # horizontal gap between boxes in auto-x layouts
MARGIN = 24
MAX_TITLE_LINES, MAX_SUB_LINES = 6, 4


class Report(object):
    """Collects warnings and errors; the scripts exit 1 when there is any error."""

    def __init__(self):
        self.errors = []
        self.warnings = []

    def error(self, msg):
        self.errors.append(msg)
        print("ERROR: " + msg)

    def warn(self, msg):
        self.warnings.append(msg)
        print("WARNING: " + msg)

    def summary(self):
        return "%d error(s), %d warning(s)" % (len(self.errors), len(self.warnings))


def setup_console():
    for stream in (sys.stdout, sys.stderr):
        try:
            stream.reconfigure(errors="replace")
        except AttributeError:
            pass


# ---------------------------------------------------------------------------
# files and paths

def load_json(path):
    with open(path, "r", encoding="utf-8-sig") as handle:
        return json.load(handle)


def read_text(path):
    with open(path, "r", encoding="utf-8-sig", errors="replace") as handle:
        return handle.read()


def write_text(path, text):
    """UTF-8, LF line endings, parent folders created."""
    folder = os.path.dirname(os.path.abspath(path))
    if not os.path.isdir(folder):
        os.makedirs(folder)
    with open(path, "w", encoding="utf-8", newline="\n") as handle:
        handle.write(text)


def inside(path, folder):
    path = os.path.normcase(os.path.abspath(path))
    folder = os.path.normcase(os.path.abspath(folder))
    try:
        return os.path.commonpath([path, folder]) == folder
    except ValueError:  # different drives
        return False


def refuse_inside_kit(path, what):
    """Generated packs and indexes are case artifacts: never written inside the kit."""
    if inside(path, KIT_ROOT):
        print("error: %s is a case artifact - write it outside the kit folder (%s): %s"
              % (what, KIT_ROOT, path), file=sys.stderr)
        return True
    return False


def href_between(target, from_dir):
    """Relative href (forward slashes) from a page's folder to a target file."""
    return os.path.relpath(os.path.abspath(target), os.path.abspath(from_dir)).replace(os.sep, "/")


def is_external(href):
    return bool(re.match(r"^[a-zA-Z][a-zA-Z0-9+.-]*:", href)) or href.startswith("#") or href.startswith("//")


def resolve_href(href, from_dir):
    """Local file an href points to (query/fragment dropped), or None for external links."""
    if not href or is_external(href):
        return None
    target = href.split("#", 1)[0].split("?", 1)[0]
    if not target:
        return None
    return os.path.normpath(os.path.join(from_dir, target.replace("/", os.sep)))


# ---------------------------------------------------------------------------
# markdown subset (headings, lists, tables, quotes, fenced code, paragraphs)

def strip_meta(md):
    """Drop YAML front matter and the Scope/Maturity metadata lines of a source doc."""
    lines = md.splitlines()
    if lines and lines[0].strip() == "---":
        for index in range(1, len(lines)):
            if lines[index].strip() == "---":
                lines = lines[index + 1:]
                break
    return "\n".join(l for l in lines if not re.match(r"^\*\*(Scope|Maturity)\*\*:", l.strip()))


def inline(text):
    text = html.escape(text, quote=False)
    text = re.sub(r"\[\[([^\]|]+)\|([^\]]+)\]\]", r"\2", text)
    text = re.sub(r"\[\[([^\]]+)\]\]", r"\1", text)
    text = re.sub(r"!\[([^\]]*)\]\(([^)\s]+)\)", r'<a href="\2">\1</a>', text)  # images become links
    text = re.sub(r"\[([^\]]+)\]\(([^)\s]+)\)", r'<a href="\2">\1</a>', text)
    text = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", text)
    text = re.sub(r"`([^`]+)`", r"<code>\1</code>", text)
    return text


_BLOCK_START = re.compile(r"^(#{1,4}\s+|\s*\||\s*\d+[.)]\s+|\s*[-*]\s+|>|\s*```)")


def md_to_html(md):
    out, lines, i = [], md.splitlines(), 0
    state = {"ul": False, "ol": False, "bq": False}

    def close(*kinds):
        for kind in kinds or ("ul", "ol", "bq"):
            if state[kind]:
                out.append({"ul": "</ul>", "ol": "</ol>", "bq": "</blockquote>"}[kind])
                state[kind] = False

    while i < len(lines):
        line = lines[i]
        heading = re.match(r"^(#{1,4})\s+(.*)", line)
        if line.lstrip().startswith("```"):
            close()
            code = []
            i += 1
            while i < len(lines) and not lines[i].lstrip().startswith("```"):
                code.append(lines[i])
                i += 1
            out.append("<pre><code>" + html.escape("\n".join(code), quote=False) + "</code></pre>")
        elif heading:
            close()
            level = len(heading.group(1))
            out.append("<h%d>%s</h%d>" % (level, inline(heading.group(2)), level))
        elif re.match(r"^\s*\|", line):
            close()
            rows = []
            while i < len(lines) and re.match(r"^\s*\|", lines[i]):
                rows.append(lines[i])
                i += 1
            i -= 1
            out.append("<table>")
            header_done = False
            for row in rows:
                cells = [c.strip() for c in re.split(r"(?<!\\)\|", row.strip().strip("|"))]
                if all(re.fullmatch(r":?-{2,}:?", c) for c in cells if c):
                    header_done = True
                    continue
                tag = "td" if header_done else "th"
                out.append("<tr>" + "".join("<%s>%s</%s>" % (tag, inline(c.replace("\\|", "|")), tag)
                                            for c in cells) + "</tr>")
            out.append("</table>")
        elif re.match(r"^\s*\d+[.)]\s+", line):
            close("ul", "bq")
            if not state["ol"]:
                out.append("<ol>")
                state["ol"] = True
            out.append("<li>" + inline(re.sub(r"^\s*\d+[.)]\s+", "", line)) + "</li>")
        elif re.match(r"^\s*[-*]\s+", line):
            close("ol", "bq")
            if not state["ul"]:
                out.append("<ul>")
                state["ul"] = True
            out.append("<li>" + inline(re.sub(r"^\s*[-*]\s+", "", line)) + "</li>")
        elif line.startswith(">"):
            close("ul", "ol")
            if not state["bq"]:
                out.append("<blockquote>")
                state["bq"] = True
            out.append(inline(line.lstrip("> ")) + " ")
        elif line.strip() == "":
            close()
        elif state["bq"]:
            out.append(inline(line) + " ")
        else:
            close("ul", "ol")
            # consecutive plain lines form one paragraph, so a **bold** span that was
            # hard-wrapped across lines still resolves
            para = [line]
            while i + 1 < len(lines) and lines[i + 1].strip() and not _BLOCK_START.match(lines[i + 1]):
                i += 1
                para.append(lines[i])
            out.append("<p>" + inline(" ".join(para)) + "</p>")
        i += 1
    close()
    return "\n".join(out)


# ---------------------------------------------------------------------------
# status rendering

def check_status(status, where, report):
    if status not in STATUS_NAMES:
        report.error("%s: status '%s' is not in the fixed vocabulary (%s)"
                     % (where, status, " | ".join(STATUS_NAMES)))
        return False
    return True


def badges_html(status, pending=None):
    """Status badge plus one badge per pending note. Inline styles: never depends on a pack's CSS."""
    color = STATUS_COLOR.get(status, NEUTRAL_COLOR)
    text = STATUS_TEXT.get(status, "#ffffff")
    base = "display:inline-block;padding:2px 10px;border-radius:999px;font-size:12px;font-weight:600;"
    out = ['<span class="badge" title="%s" style="%sbackground:%s;color:%s">%s</span>'
           % (html.escape(STATUS_MEANING.get(status, ""), quote=True), base, color, text, html.escape(status))]
    for note in pending or []:
        out.append('<span class="badge pending" style="%sbackground:#fff8c5;color:#3b2d00;'
                   'border:1px solid #d4a72c">pending: %s</span>' % (base, html.escape(note)))
    return '<div class="badges" style="margin:0 0 18px;display:flex;gap:8px;flex-wrap:wrap">%s</div>' % "".join(out)


def leaf_html(title, badges, content):
    """Leaf page heading: the content's own leading <h1> when it has one (no duplicate title),
    else the box label; the status badges sit right under it."""
    m = re.match(r"\s*(<h1\b[^>]*>.*?</h1>)", content, flags=re.S)
    if m:
        return m.group(1) + badges + content[m.end():]
    return "<h1>%s</h1>" % html.escape(title) + badges + content


def legend_html():
    """THE legend: built from STATUSES, inline-styled, hover hints via native title (no JS)."""
    items = []
    for name, color, _, meaning in STATUSES:
        items.append('<span title="%s" style="cursor:help;white-space:nowrap">'
                     '<span style="color:%s;margin-right:5px">&#9679;</span>%s</span>'
                     % (html.escape(meaning, quote=True), color, name))
    return ('<div class="ladder-legend" style="display:flex;gap:6px 18px;flex-wrap:wrap;'
            'margin:14px 0 6px;font-size:13px;color:#57606f">%s</div>' % "\n".join(items))


def back_link_html(back_link):
    """Explicit, prominent way back to the abstraction a page drilled down from."""
    if not back_link or not back_link.get("href"):
        return ""
    return ('<p class="ladder-back" style="margin:0 0 18px"><a href="%s" style="display:inline-flex;'
            'align-items:center;gap:6px;font-weight:600;color:#0969da;text-decoration:none;font-size:14px">'
            '&larr; Back to %s</a></p>'
            % (html.escape(back_link["href"], quote=True), html.escape(back_link.get("label") or "the parent abstraction")))


# ---------------------------------------------------------------------------
# box auto-fit

def _wrap(text, width_px, font_size, max_lines):
    avg_char_w = font_size * 0.56
    per_line = max(6, int((width_px - 2 * BOX_PAD_X) / avg_char_w))
    lines = textwrap.wrap(text, width=per_line, break_long_words=False) or [text]
    truncated = len(lines) > max_lines
    if truncated:
        lines = lines[:max_lines]
        lines[-1] = lines[-1].rstrip() + "..."
    needed_w = max(len(l) for l in lines) * avg_char_w + 2 * BOX_PAD_X
    return lines, needed_w, truncated


def fit_box(label, sublabel, min_w, min_h, width_cap):
    """Wrap the text to the declared (minimum) width; grow the width up to width_cap extra
    pixels only when an unbreakable token still does not fit; then grow the height to fit
    every line. Returns dict(w, h, title, sub, problem)."""
    title, title_w, cut1 = _wrap(label, min_w, TITLE_FONT, MAX_TITLE_LINES)
    sub, sub_w, cut2 = ([], 0, False)
    if sublabel:
        sub, sub_w, cut2 = _wrap(sublabel, min_w, SUB_FONT, MAX_SUB_LINES)
    width = float(min_w)
    problem = None
    needed = max(title_w, sub_w)
    if needed > min_w:
        width = min(needed, min_w + max(0, width_cap))
        title, title_w, cut1 = _wrap(label, width, TITLE_FONT, MAX_TITLE_LINES)
        if sublabel:
            sub, sub_w, cut2 = _wrap(sublabel, width, SUB_FONT, MAX_SUB_LINES)
        if max(title_w, sub_w) > width + 1:
            problem = "text does not fit even at %dpx - shorten the label or break the long token" % width
    if cut1 or cut2:
        problem = "text truncated after %d lines - shorten the label" % (MAX_TITLE_LINES if cut1 else MAX_SUB_LINES)
    height = BOX_TOP_PAD + (len(title) - 1) * TITLE_LINE_H
    height += (BOX_TITLE_SUB_GAP + len(sub) * SUB_LINE_H) if sub else 6
    height += BOX_BOTTOM_PAD
    return {"w": width, "h": max(float(min_h), height), "title": title, "sub": sub, "problem": problem}


def _neighbour_cap(box, same_row):
    """Width growth a manual-x box may take without touching its nearest same-row neighbour."""
    x0, x1 = box["x"], box["x"] + box.get("width", BOX_MIN_W)
    gaps = []
    for other in same_row:
        if other is box:
            continue
        ox0, ox1 = other["x"], other["x"] + other.get("width", BOX_MIN_W)
        if ox0 >= x1:
            gaps.append(ox0 - x1)
        elif ox1 <= x0:
            gaps.append(x0 - ox1)
    if not gaps:
        return MAX_WIDTH_GROWTH
    return max(0, min(MAX_WIDTH_GROWTH, (min(gaps) - 10) * 2))


def layout(boxes, report, auto_x=False):
    """Fit and place boxes. Each box: id, label, optional sublabel, width/height minimums,
    and either `row` (preferred: the row's Y comes from its tallest fitted box) or `y`.
    auto_x=True (mode A) also computes x: boxes of a row left to right in list order,
    every row centred on the widest one. Otherwise x is manual and a box keeps its centre
    while it grows. Returns ({id: {x, y, w, h, title, sub}}, canvas_w, canvas_h)."""
    if not boxes:
        return {}, 2 * MARGIN, 2 * MARGIN
    with_row = [b for b in boxes if "row" in b]
    if with_row and len(with_row) != len(boxes):
        report.error("some boxes declare `row` and others `y` - pick one per diagram (prefer row)")
        return {}, 0, 0
    use_rows = bool(with_row)
    if not use_rows and any("y" not in b for b in boxes):
        report.error("every box needs `row` (preferred) or an explicit `y`")
        return {}, 0, 0
    by_row = {}
    for b in boxes:
        by_row.setdefault(b.get("row"), []).append(b)

    fitted = {}
    for b in boxes:
        min_w, min_h = b.get("width", BOX_MIN_W), b.get("height", BOX_MIN_H)
        if auto_x:
            cap = MAX_WIDTH_GROWTH
        elif b.get("width_cap") is not None:
            cap = b["width_cap"]
        elif use_rows:
            cap = _neighbour_cap(b, by_row[b.get("row")])
        else:
            cap = MAX_WIDTH_GROWTH
        fit = fit_box(b["label"], b.get("sublabel"), min_w, min_h, cap)
        if fit["problem"]:
            report.warn("box '%s': %s" % (b["id"], fit["problem"]))
        if not auto_x:
            fit["x"] = b["x"] + min_w / 2.0 - fit["w"] / 2.0
        fitted[b["id"]] = fit

    if auto_x:
        row_width = {}
        for r, members in by_row.items():
            cursor = 0.0
            for b in members:
                fitted[b["id"]]["x"] = cursor
                cursor += fitted[b["id"]]["w"] + COL_GAP
            row_width[r] = cursor - COL_GAP
        widest = max(row_width.values())
        for r, members in by_row.items():
            shift = MARGIN + (widest - row_width[r]) / 2.0
            for b in members:
                fitted[b["id"]]["x"] += shift

    if use_rows:
        y_cursor = MARGIN
        for r in sorted(by_row):
            for b in by_row[r]:
                fitted[b["id"]]["y"] = y_cursor
            y_cursor += max(fitted[b["id"]]["h"] for b in by_row[r]) + ROW_GAP
    else:
        for b in boxes:
            fitted[b["id"]]["y"] = b["y"]

    for f in fitted.values():
        for key in ("x", "y", "w", "h"):
            f[key] = int(round(f[key]))
    canvas_w = max(f["x"] + f["w"] for f in fitted.values()) + MARGIN
    canvas_h = max(f["y"] + f["h"] for f in fitted.values()) + MARGIN

    ids = list(fitted)
    for i, a_id in enumerate(ids):
        a = fitted[a_id]
        for o_id in ids[i + 1:]:
            o = fitted[o_id]
            if a["x"] < o["x"] + o["w"] and o["x"] < a["x"] + a["w"] and \
                    a["y"] < o["y"] + o["h"] and o["y"] < a["y"] + a["h"]:
                report.warn("boxes '%s' and '%s' overlap after auto-fit - move an x or a row in the spec"
                            % (a_id, o_id))
    return fitted, canvas_w, canvas_h


def edge_svg(f, t):
    """Connector between two fitted boxes. Same row: horizontal, edge to edge, level, in the
    declared direction (a snake's return row points left). Otherwise vertical-ish, from the
    facing sides (bottom to top going down, top to bottom going up)."""
    if f["y"] == t["y"]:
        y = f["y"] + min(f["h"], t["h"]) / 2.0
        if f["x"] < t["x"]:
            x1, x2 = f["x"] + f["w"], t["x"]
        else:
            x1, x2 = f["x"], t["x"] + t["w"]
        y1 = y2 = y
    elif t["y"] > f["y"]:
        x1, y1 = f["x"] + f["w"] / 2.0, f["y"] + f["h"]
        x2, y2 = t["x"] + t["w"] / 2.0, t["y"]
    else:
        x1, y1 = f["x"] + f["w"] / 2.0, f["y"]
        x2, y2 = t["x"] + t["w"] / 2.0, t["y"] + t["h"]
    return ('<line class="flow" x1="%g" y1="%g" x2="%g" y2="%g" stroke="#8b949e" stroke-width="1.5" '
            'marker-end="url(#ar)"/>' % (x1, y1, x2, y2))


def box_svg(href, css_class, f, dot_color, tooltip):
    """One clickable box. Text styling is inline so a host page's CSS cannot resize it."""
    cx = f["x"] + f["w"] / 2.0
    y0 = f["y"] + BOX_TOP_PAD
    parts = ['<a href="%s"><title>%s</title><rect class="%s" x="%d" y="%d" width="%d" height="%d" rx="8"/>'
             % (html.escape(href, quote=True), html.escape(tooltip), html.escape(css_class, quote=True),
                f["x"], f["y"], f["w"], f["h"])]
    for i, line in enumerate(f["title"]):
        parts.append('<text x="%g" y="%g" text-anchor="middle" class="title" style="font-weight:600">%s</text>'
                     % (cx, y0 + i * TITLE_LINE_H, html.escape(line)))
    if f["sub"]:
        y1 = y0 + (len(f["title"]) - 1) * TITLE_LINE_H + BOX_TITLE_SUB_GAP + SUB_LINE_H
        for i, line in enumerate(f["sub"]):
            parts.append('<text x="%g" y="%g" text-anchor="middle" class="small" '
                         'style="font-size:11px;fill:#57606f">%s</text>' % (cx, y1 + i * SUB_LINE_H, html.escape(line)))
    if dot_color:
        parts.append('<circle cx="%d" cy="%d" r="6" fill="%s"/>' % (f["x"] + f["w"] - 12, f["y"] + 12, dot_color))
    parts.append("</a>")
    return "".join(parts)


ARROW_DEFS = ('<defs><marker id="ar" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" '
              'orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#8b949e"/></marker></defs>')


def svg_open(width, height):
    """Same real scale: width/height equal the viewBox; CSS may only shrink it."""
    return ('<svg class="ladder" viewBox="0 0 %d %d" width="%d" height="%d" xmlns="http://www.w3.org/2000/svg">'
            % (width, height, width, height))


# ---------------------------------------------------------------------------
# stylesheet and page shell

BASE_CSS = """
:root{--ink:#1f2328;--muted:#57606f;--line:#d8dee4;--bg:#ffffff;--soft:#f6f8fa;--accent:#0969da;}
*{box-sizing:border-box}body{margin:0;font:15px/1.55 "Segoe UI",system-ui,sans-serif;color:var(--ink);background:var(--bg);display:flex;min-height:100vh}
nav{width:250px;flex:none;background:var(--soft);border-right:1px solid var(--line);padding:18px 14px;position:sticky;top:0;height:100vh;overflow-y:auto}
nav:empty{display:none}
nav h2{font-size:11px;text-transform:uppercase;letter-spacing:.08em;color:var(--muted);margin:16px 0 4px}
nav a{display:block;padding:3px 8px;border-radius:6px;color:var(--ink);text-decoration:none;font-size:13.5px}
nav a:hover{background:#eaeef2}nav a.current{background:#ddf;color:var(--accent);font-weight:600}
main{flex:1;min-width:0;max-width:1320px;padding:28px 40px 60px}
h1{font-size:24px;border-bottom:1px solid var(--line);padding-bottom:8px}
svg{display:block;max-width:100%;height:auto;border:1px solid var(--line);border-radius:10px;background:#fcfdfe}
svg a{cursor:pointer}svg a:hover rect{stroke:var(--accent);stroke-width:2.5}
rect.box{fill:#fff;stroke:#8b949e;stroke-width:1.4}
rect.actor{fill:#f0f4ff;stroke:#6e7fbd}rect.band{fill:#fbf7ff;stroke:#a884d8}
rect.core{fill:#fff4e5;stroke:#c07a12;stroke-width:2}rect.support{fill:#f6f8fa;stroke:#8b949e;stroke-dasharray:5 3}
text{font:13px "Segoe UI",system-ui,sans-serif;fill:#1f2328}
table{border-collapse:collapse;margin:12px 0;width:100%;font-size:14px}
th,td{border:1px solid var(--line);padding:6px 10px;text-align:left;vertical-align:top}
th{background:var(--soft)}code{background:var(--soft);padding:1px 5px;border-radius:4px;font-size:.9em}
pre{background:var(--soft);padding:10px 14px;border-radius:8px;overflow-x:auto}pre code{background:none;padding:0}
blockquote{border-left:4px solid #d4a72c;background:#fff8c5;margin:12px 0;padding:8px 14px;border-radius:0 8px 8px 0}
.srcline{color:var(--muted);font-size:12.5px;margin-top:40px;border-top:1px solid var(--line);padding-top:8px}
@media (max-width:760px){body{display:block}nav{width:auto;height:auto;position:static;border-right:0;border-bottom:1px solid var(--line)}main{padding:20px 16px 40px}}
"""

# Appended last, so a parent pack's own `svg{width:100%}` can never stretch a diagram.
SCALE_PIN_CSS = "svg.ladder{display:block;max-width:100%;height:auto}"

_SVG_WIDTH_100 = re.compile(r"(svg\s*\{[^}]*?)(?<![-\w])width\s*:\s*100%")


def pin_svg_scale(css):
    """Turn a stylesheet's `svg{width:100%}` into `max-width:100%` (shrink only, never stretch)."""
    return _SVG_WIDTH_100.sub(r"\1max-width:100%", css)


def css_from_file(path):
    """A parent's stylesheet: a .css file as is, or every <style> block of an .html page."""
    text = read_text(path)
    if path.lower().endswith((".html", ".htm")):
        return "\n".join(re.findall(r"<style[^>]*>(.*?)</style>", text, flags=re.S | re.I))
    return text


def page(title, nav, body, css, footer):
    return ("<!DOCTYPE html>\n<html lang=\"en\"><head><meta charset=\"utf-8\">\n"
            "<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">\n"
            "<title>%s</title>\n<style>%s\n%s</style></head><body>\n%s\n<main>\n%s\n"
            "<p class=\"srcline\">%s</p>\n</main></body></html>\n"
            % (html.escape(title), css, SCALE_PIN_CSS, nav or "<nav></nav>", body, footer))
