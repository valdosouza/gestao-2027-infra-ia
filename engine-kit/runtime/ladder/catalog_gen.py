#!/usr/bin/env python3
"""catalog_gen.py - catalog of agents and skills, generated from the REAL files (engine-kit runtime).

Scans the agent definitions (one .md per agent) and the skills (one folder per skill
holding SKILL.md, at any depth), reads each one's front-matter description, and
cross-references which agents name which skills. The catalog is regenerated from the
files, never maintained by hand, so it cannot drift from reality.

It also flags gaps: a skill present in a local tool folder (--local-skills, e.g. the
folder a coding assistant loads skills from) but absent from the source of record is a
gap to resolve (distribute it properly or delete it), not noise to suppress. Other
issues flagged: a skill whose front-matter `name` differs from its folder, an agent or
skill without a description, a skill id defined twice.

Layouts: --root alone auto-detects `<root>/agents/*.md` and `<root>/skills/**/SKILL.md`
(this kit's own layout); any other layout passes --agents / --skills (repeatable,
relative to --root or absolute), e.g. a knowledge base keeping them under an AI folder.

Outputs (any combination; none = markdown on stdout):
  --md-out FILE    markdown catalog (tables + who-uses-what + gaps), with a Scope line
  --json-out FILE  machine-readable catalog
  --spec-out FILE  a mode B blank-canvas spec for a catalog drill-down; render it with
                   extend_handauthored.py and re-run tree_index.py afterwards

Usage:
  python catalog_gen.py --root <kit-or-kb> [--agents DIR] [--skills DIR] [--local-skills DIR]
                        [--md-out FILE] [--json-out FILE] [--spec-out FILE] [--strict]

--strict exits 1 when a gap or an issue is found. Paths written into the outputs are
relative (to the output file, or to --root); machine paths never enter them.
Python 3.8+, standard library only.
"""

import argparse
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ladder_common as lc  # noqa: E402

NOT_AGENTS = {"README", "INDEX", "CHANGELOG", "AGENTS", "CLAUDE"}
SKIP_DIRS = {".git", ".svn", "node_modules", "__pycache__", "references", "templates", "assets", "scripts"}


def front_matter(text):
    if not text.startswith("---"):
        return {}, text
    parts = text.split("---", 2)
    if len(parts) < 3:
        return {}, text
    keys, lines = {}, parts[1].splitlines()
    for index, line in enumerate(lines):
        m = re.match(r"^([A-Za-z_][\w-]*):\s*(.*)$", line)
        if not m:
            continue
        value = m.group(2).strip()
        if value in (">", ">-", "|", "|-", ""):
            block = []
            for nxt in lines[index + 1:]:
                if re.match(r"^\s+\S", nxt):
                    block.append(nxt.strip())
                elif block or nxt.strip():
                    break
            value = " ".join(block)
        elif value[:1] in ('"', "'") and value.endswith(value[0]) and len(value) > 1:
            value = value[1:-1].replace('\\"', '"')
        keys[m.group(1)] = value
    return keys, parts[2]


def describe(text, limit):
    keys, body = front_matter(text)
    desc = keys.get("description", "").strip()
    if not desc:
        for para in re.split(r"\n\s*\n", body):
            p = para.strip()
            if not p or p.startswith(("#", "**", ">", "|", "---", "<", "```")):
                continue
            desc = re.sub(r"\s+", " ", p)
            break
    desc = re.sub(r"\s+", " ", desc)
    if len(desc) > limit:
        desc = desc[:limit].rsplit(" ", 1)[0] + "..."
    return keys, desc


def find_skills(folder):
    found = []
    for dirpath, dirnames, filenames in os.walk(folder):
        dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
        if "SKILL.md" in filenames:
            found.append(os.path.join(dirpath, "SKILL.md"))
            dirnames[:] = []          # a skill's own subfolders are not skills
    return found


def collect(agent_dirs, skill_dirs, local_dirs, limit):
    agents, skills, issues = {}, {}, []
    for folder in agent_dirs:
        for name in sorted(os.listdir(folder)):
            path = os.path.join(folder, name)
            stem = os.path.splitext(name)[0]
            if not name.endswith(".md") or not os.path.isfile(path) or stem.upper() in NOT_AGENTS:
                continue
            text = lc.read_text(path)
            keys, desc = describe(text, limit)
            if stem in agents:
                issues.append("agent '%s' is defined twice" % stem)
            if not keys.get("description"):
                issues.append("agent '%s' has no front-matter description" % stem)
            agents[stem] = {"id": stem, "name": keys.get("name", stem), "description": desc or "(no description)",
                            "path": path, "text": text}
    for folder in skill_dirs:
        for path in find_skills(folder):
            sid = os.path.basename(os.path.dirname(path))
            keys, desc = describe(lc.read_text(path), limit)
            if sid in skills:
                issues.append("skill '%s' is defined twice" % sid)
            if keys.get("name") and keys["name"] != sid:
                issues.append("skill '%s': front-matter name '%s' differs from its folder" % (sid, keys["name"]))
            if not keys.get("description"):
                issues.append("skill '%s' has no front-matter description" % sid)
            skills[sid] = {"id": sid, "description": desc or "(no description)", "path": path}
    patterns = dict((sid, re.compile(r"(?<![A-Za-z0-9_-])%s(?![A-Za-z0-9_-])" % re.escape(sid))) for sid in skills)
    for a in agents.values():
        a["skills"] = sorted(sid for sid, rx in patterns.items() if rx.search(a["text"]))
    for s in skills.values():
        s["used_by"] = sorted(aid for aid, a in agents.items() if s["id"] in a["skills"])
    local_only = []
    for folder in local_dirs:
        for name in sorted(os.listdir(folder)):
            if os.path.isfile(os.path.join(folder, name, "SKILL.md")) and name not in skills and name not in local_only:
                local_only.append(name)
    return agents, skills, sorted(local_only), issues


def md_cell(text):
    return text.replace("|", "\\|").replace("\n", " ")


def render_md(agents, skills, local_only, issues, link_base, scope, title):
    def link(item):
        if link_base is None:
            return "`%s`" % item["id"]
        return "[`%s`](%s)" % (item["id"], lc.href_between(item["path"], link_base))

    out = ["# %s" % title, "", "**Scope**: %s" % scope, "",
           "Generated by `catalog_gen.py` from the real agent and skill files - never hand-edit; "
           "regenerate after any agent or skill change. %d agents, %d skills." % (len(agents), len(skills)), "",
           "## Agents (%d)" % len(agents), "", "| Agent | Description | Skills it names |", "|---|---|---|"]
    for a in agents.values():
        out.append("| %s | %s | %s |" % (link(a), md_cell(a["description"]),
                                         ", ".join("`%s`" % s for s in a["skills"]) or "-"))
    out += ["", "## Skills (%d)" % len(skills), "", "| Skill | Description | Named by |", "|---|---|---|"]
    for s in skills.values():
        out.append("| %s | %s | %s |" % (link(s), md_cell(s["description"]),
                                         ", ".join("`%s`" % a for a in s["used_by"]) or "-"))
    out += ["", "## Who uses what", "",
            "Text cross-reference over the real files (whole-word skill names). An agent with no entry "
            "works from its own instructions without naming a skill.", ""]
    for a in agents.values():
        out.append("- **%s** -> %s" % (a["id"], ", ".join("`%s`" % s for s in a["skills"]) or "(no skill named)"))
    unnamed = [s["id"] for s in skills.values() if not s["used_by"]]
    out += ["", "## Gaps and issues", ""]
    if local_only:
        out.append("Present in a local tool folder but absent from the source of record (%d) - a gap to "
                   "resolve, not noise:" % len(local_only))
        out.append("")
        out += ["- `%s`" % s for s in local_only]
        out.append("")
    else:
        out += ["No skill present locally is missing from the source of record.", ""]
    if issues:
        out += ["Issues (%d):" % len(issues), ""] + ["- %s" % i for i in issues] + [""]
    out.append("Skills no agent names (%d, informational - skills also trigger on their own): %s"
               % (len(unnamed), ", ".join("`%s`" % s for s in unnamed) or "none"))
    return "\n".join(out) + "\n"


def render_spec(agents, skills, local_only, issues, back_href, back_label, css_from):
    agents_md = ["# Agents", "", "%d agents - regenerated from the real files, never hand-maintained." % len(agents), ""]
    agents_md += ["- **%s** - %s" % (a["id"], a["description"]) for a in agents.values()]
    skills_md = ["# Skills", "", "%d skills - regenerated from the real SKILL.md files, never hand-maintained." % len(skills), ""]
    skills_md += ["- **%s** - %s" % (s["id"], s["description"]) for s in skills.values()]
    if local_only:
        skills_md += ["", "## Present locally, absent from the source of record", ""]
        skills_md += ["- **%s**" % s for s in local_only]
    matrix_md = ["# Who uses what", "", "Which skills each agent's definition names (whole-word match over the real files).", ""]
    matrix_md += ["- **%s** -> %s" % (a["id"], ", ".join("`%s`" % s for s in a["skills"]) or "(no skill named)")
                  for a in agents.values()]
    gap = bool(local_only or issues)
    spec = {
        "_comment": "GENERATED by catalog_gen.py from the real agent and skill files - do not hand-edit; "
                    "re-run catalog_gen.py, then extend_handauthored.py, then tree_index.py.",
        "output_html": "index.html",
        "title": "Agents and skills catalog",
        "h1": "Agents and skills catalog",
        "intro": "Who works here and with what: <strong>%d agents</strong> and <strong>%d skills</strong>, "
                 "generated from the real files so the catalog cannot drift." % (len(agents), len(skills)),
        "back_link": {"href": back_href, "label": back_label},
        "nav_html": "<nav><h2>Catalog</h2><a href=\"index.html\" class=\"current\">Catalog</a>"
                    "<a href=\"agents.html\">Agents</a><a href=\"skills.html\">Skills</a>"
                    "<a href=\"matrix.html\">Who uses what</a></nav>",
        "new_boxes": [
            {"id": "agents", "label": "Agents (%d)" % len(agents), "sublabel": "judgment - who does the work",
             "x": 24, "row": 0, "width": 260, "height": 60, "css_class": "box core", "status": "available",
             "href": "agents.html", "edges_to": ["matrix"]},
            {"id": "skills", "label": "Skills (%d)" % len(skills), "sublabel": "repeatable procedures - how it is done",
             "x": 324, "row": 0, "width": 260, "height": 60, "css_class": "box",
             "status": "draft" if gap else "available", "href": "skills.html", "edges_to": ["matrix"]},
            {"id": "matrix", "label": "Who uses what", "sublabel": "agent x skill cross-reference",
             "x": 174, "row": 1, "width": 260, "height": 60, "css_class": "box support", "status": "available",
             "href": "matrix.html"},
        ],
        "leaf_nav_html": "<nav><h2>Catalog</h2><a href=\"index.html\">Catalog</a><a href=\"agents.html\">Agents</a>"
                         "<a href=\"skills.html\">Skills</a><a href=\"matrix.html\">Who uses what</a></nav>",
        "leaf_back_link": {"href": "index.html", "label": "the catalog"},
        "leaf_pages": [
            {"output_html": "agents.html", "title": "Agents - catalog", "status": "available",
             "body_md": "\n".join(agents_md)},
            {"output_html": "skills.html", "title": "Skills - catalog", "status": "draft" if gap else "available",
             "pending": (["%d skill(s) present locally, absent from the source of record: %s"
                          % (len(local_only), ", ".join(local_only))] if local_only else [])
                        + (["%d issue(s) in the source files" % len(issues)] if issues else []),
             "body_md": "\n".join(skills_md)},
            {"output_html": "matrix.html", "title": "Who uses what - catalog", "status": "available",
             "body_md": "\n".join(matrix_md)},
        ],
    }
    if css_from:
        spec["css_from"] = css_from
    return spec


def main(argv=None):
    lc.setup_console()
    ap = argparse.ArgumentParser(description="Generate the agents and skills catalog from the real files")
    ap.add_argument("--root", help="kit or knowledge-base root; alone, auto-detects agents/ and skills/")
    ap.add_argument("--agents", action="append", default=[], help="folder of agent .md files (repeatable)")
    ap.add_argument("--skills", action="append", default=[], help="folder holding skill folders with SKILL.md (repeatable)")
    ap.add_argument("--local-skills", action="append", default=[],
                    help="local tool folder whose skills must also exist in the source of record (repeatable)")
    ap.add_argument("--md-out", help="markdown catalog to write")
    ap.add_argument("--json-out", help="JSON catalog to write")
    ap.add_argument("--spec-out", help="mode B blank-canvas spec to write (catalog drill-down)")
    ap.add_argument("--spec-back-href", default="../index.html", help="back-link of the catalog diagram (spec)")
    ap.add_argument("--spec-back-label", default="the parent abstraction", help="back-link label (spec)")
    ap.add_argument("--spec-css-from", help="css_from for the spec (the parent page or stylesheet, relative to the spec)")
    ap.add_argument("--scope", default="method", help="Scope value written in the markdown (default: method)")
    ap.add_argument("--title", default="Agents and skills catalog", help="H1 of the markdown catalog")
    ap.add_argument("--desc-limit", type=int, default=230, help="description length cap (default: 230)")
    ap.add_argument("--strict", action="store_true", help="exit 1 when a gap or an issue is found")
    args = ap.parse_args(argv)

    root = os.path.abspath(args.root) if args.root else None

    def resolve(paths, default):
        if not paths and root and os.path.isdir(os.path.join(root, default)):
            paths = [default]
        out = []
        for p in paths:
            full = p if os.path.isabs(p) or root is None else os.path.join(root, p)
            if not os.path.isdir(full):
                print("error: folder not found: %s" % full, file=sys.stderr)
                sys.exit(2)
            out.append(os.path.abspath(full))
        return out

    agent_dirs = resolve(args.agents, "agents")
    skill_dirs = resolve(args.skills, "skills")
    local_dirs = [os.path.abspath(p) for p in args.local_skills if os.path.isdir(p)]
    for p in args.local_skills:
        if not os.path.isdir(p):
            print("WARNING: local tool folder not found, skipped: %s" % p)
    if not agent_dirs and not skill_dirs:
        print("error: no agents or skills folder - pass --root and/or --agents / --skills", file=sys.stderr)
        return 2

    agents, skills, local_only, issues = collect(agent_dirs, skill_dirs, local_dirs, args.desc_limit)
    print("agents: %d | skills: %d | local-only skills flagged: %d | issues: %d"
          % (len(agents), len(skills), len(local_only), len(issues)))
    for s in local_only:
        print("  gap: %s (local tool folder only - absent from the source of record)" % s)
    for i in issues:
        print("  issue: %s" % i)

    rel_base = root or os.getcwd()
    if args.md_out:
        # links only when the catalog lives inside the scanned root (e.g. the kit's own docs);
        # elsewhere plain ids, so no machine path leaks into the artifact
        md_dir = os.path.dirname(os.path.abspath(args.md_out))
        link_base = md_dir if root and lc.inside(md_dir, root) else None
        lc.write_text(args.md_out, render_md(agents, skills, local_only, issues, link_base, args.scope, args.title))
        print("markdown catalog written: %s" % args.md_out)
    if args.json_out:
        data = {
            "_comment": "Generated by catalog_gen.py from the real files - never hand-edit.",
            "agents": [{"id": a["id"], "name": a["name"], "description": a["description"],
                        "path": lc.href_between(a["path"], rel_base), "skills": a["skills"]} for a in agents.values()],
            "skills": [{"id": s["id"], "description": s["description"], "path": lc.href_between(s["path"], rel_base),
                        "used_by": s["used_by"]} for s in skills.values()],
            "local_only": local_only,
            "issues": issues,
        }
        lc.write_text(args.json_out, json.dumps(data, indent=2, ensure_ascii=False) + "\n")
        print("JSON catalog written: %s" % args.json_out)
    if args.spec_out:
        spec = render_spec(agents, skills, local_only, issues, args.spec_back_href, args.spec_back_label,
                           args.spec_css_from)
        lc.write_text(args.spec_out, json.dumps(spec, indent=2, ensure_ascii=False) + "\n")
        print("catalog spec written: %s (render it with extend_handauthored.py)" % args.spec_out)
    if not (args.md_out or args.json_out or args.spec_out):
        sys.stdout.write(render_md(agents, skills, local_only, issues, None, args.scope, args.title))
    return 1 if args.strict and (local_only or issues) else 0


if __name__ == "__main__":
    sys.exit(main())
