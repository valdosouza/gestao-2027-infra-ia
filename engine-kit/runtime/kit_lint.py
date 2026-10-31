#!/usr/bin/env python3
"""kit-lint - the executable guard that keeps the engine-kit from drifting again.

Checks (each one is a section of the report; any ERROR makes the exit code 1):

  1. version   - .claude-plugin/plugin.json, marketplace.json, README "**Version**:"
                 and the first CHANGELOG entry all carry the same version.
  2. leaks     - no term from any case deny-list appears in a file name or file body.
                 Deny-lists live OUTSIDE the kit (the list itself names clients); pass
                 them with --denylist (repeatable) or KIT_DENYLISTS (os.pathsep list).
  3. links     - every relative markdown link resolves to a file in the kit.
  4. scope     - every knowledge .md declares "**Scope**: method" near the top.
  5. skills    - every skills/<name>/SKILL.md has front matter (name = folder,
                 description), at most 500 lines and a "**Maturity**:" line;
                 every agents/*.md has a "**Maturity**:" line.
  6. size      - no .md over the size budget (an index is a map, not a changelog).
  7. coverage  - the technique register (docs/techniques.csv, rendered by
                 runtime/coverage.py into docs/TECHNIQUES.md) is well-formed, every
                 in-kit/partial row points at files that exist, every skill and agent of
                 the kit is registered, and the rendered page is current.
  8. sections  - the required shape of docs/AUTHORING.md: a skill's first heading is
                 "# Skill: ..."; an agent has front matter (name = file name, a
                 description), at most 500 lines, an H1 first, and ends with the
                 governance block of templates/AGENT.template.md, word for word (T72);
                 in both, the Scope and Maturity lines sit in the header block (between
                 the title and the first "## " section). The note reports the always-on
                 cost of all descriptions (characters / 4) and how many descriptions
                 do not start with "Use when" yet (EK#18).
  9. levels    - every skill and agent placed once in docs/ADOPTION-LEVELS.md, its
                 Count line agrees, runtime/levels.json current (runtime/levels.py).

Deny-list format (UTF-8, one entry per line, '#' starts a comment):
  term         case-insensitive, whole word
  cs:term      case-sensitive, whole word
  re:pattern   Python regular expression, case-sensitive

Usage:
  python runtime/kit_lint.py [--root DIR] [--denylist FILE ...] [--require-denylist]

Python 3.8+, standard library only.
"""

import argparse
import json
import os
import re
import sys

MATURITY_VALUES = ("proven", "operating", "candidate", "design")
SKILL_MAX_LINES = 500
MD_SIZE_BUDGET = 60 * 1024
TEXT_EXTENSIONS = {".md", ".json", ".py", ".ps1", ".psm1", ".sh", ".txt", ".csv", ".yml", ".yaml", ".toml",
                   ".js", ".mjs", ".cjs", ".ts", ".html", ".css"}
SKIP_DIRS = {".git", "node_modules", "__pycache__"}
# Placeholders that are filled in by the case, so a Scope line there is not the kit's own.
SCOPE_EXEMPT_PREFIXES = ("templates/", "docs/history/")

LINK_RE = re.compile(r"\[[^\]]*\]\(([^)\s]+)(?:\s+\"[^\"]*\")?\)")
SCOPE_RE = re.compile(r"^\*\*Scope\*\*:\s*(\S+)")
MATURITY_RE = re.compile(r"^\*\*Maturity\*\*:\s*(\S+)")
README_VERSION_RE = re.compile(r"^\*\*Version\*\*:\s*([0-9]+\.[0-9]+\.[0-9]+)")
CHANGELOG_VERSION_RE = re.compile(r"^##\s*\[?([0-9]+\.[0-9]+\.[0-9]+)\]?")


class Report:
    def __init__(self):
        self.errors = []
        self.warnings = []
        self.notes = []

    def error(self, check, msg):
        self.errors.append((check, msg))

    def warn(self, check, msg):
        self.warnings.append((check, msg))

    def note(self, check, msg):
        self.notes.append((check, msg))


def rel(root, path):
    return os.path.relpath(path, root).replace(os.sep, "/")


def walk_files(root):
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in SKIP_DIRS]
        for name in filenames:
            yield os.path.join(dirpath, name)


def read_text(path):
    with open(path, "r", encoding="utf-8", errors="replace") as handle:
        return handle.read()


def strip_front_matter(lines):
    if lines and lines[0].strip() == "---":
        for index in range(1, len(lines)):
            if lines[index].strip() == "---":
                return lines[:index + 1], lines[index + 1:]
    return [], lines


# 1. version -----------------------------------------------------------------

def check_version(root, report):
    found = {}
    plugin = os.path.join(root, ".claude-plugin", "plugin.json")
    if os.path.isfile(plugin):
        try:
            found["plugin.json"] = json.loads(read_text(plugin)).get("version")
        except ValueError as exc:
            report.error("version", "plugin.json is not valid JSON: %s" % exc)
    else:
        report.error("version", "missing .claude-plugin/plugin.json")

    market = os.path.join(root, ".claude-plugin", "marketplace.json")
    if os.path.isfile(market):
        try:
            data = json.loads(read_text(market))
            for entry in data.get("plugins", []):
                if entry.get("version"):
                    found["marketplace.json (%s)" % entry.get("name")] = entry["version"]
        except ValueError as exc:
            report.error("version", "marketplace.json is not valid JSON: %s" % exc)

    for name, pattern in (("README.md", README_VERSION_RE), ("CHANGELOG.md", CHANGELOG_VERSION_RE)):
        path = os.path.join(root, name)
        if not os.path.isfile(path):
            report.error("version", "missing %s" % name)
            continue
        for line in read_text(path).splitlines():
            match = pattern.match(line.strip())
            if match:
                found[name] = match.group(1)
                break
        else:
            report.error("version", "%s has no version line" % name)

    values = set(v for v in found.values() if v)
    if len(values) > 1:
        report.error("version", "versions disagree: " + ", ".join("%s=%s" % kv for kv in sorted(found.items())))
    elif values:
        report.note("version", "all sources agree on %s" % values.pop())


# 2. leaks -------------------------------------------------------------------

def load_denylist(path):
    rules = []
    for number, raw in enumerate(read_text(path).splitlines(), 1):
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("re:"):
            pattern, label = line[3:], line
            flags = 0
        elif line.startswith("cs:"):
            pattern, label = r"(?<!\w)" + re.escape(line[3:]) + r"(?!\w)", line[3:]
            flags = 0
        else:
            pattern, label = r"(?<!\w)" + re.escape(line) + r"(?!\w)", line
            flags = re.IGNORECASE
        try:
            rules.append((re.compile(pattern, flags), label, "%s:%d" % (os.path.basename(path), number)))
        except re.error as exc:
            raise SystemExit("bad pattern in %s line %d: %s" % (path, number, exc))
    return rules


def check_leaks(root, denylists, require, report):
    if not denylists:
        message = "no deny-list given (--denylist or KIT_DENYLISTS); leak check skipped"
        if require:
            report.error("leaks", message)
        else:
            report.warn("leaks", message)
        return
    rules = []
    for path in denylists:
        if not os.path.isfile(path):
            report.error("leaks", "deny-list not found: %s" % path)
            continue
        rules.extend(load_denylist(path))
    hits = 0
    for path in walk_files(root):
        name = rel(root, path)
        for regex, label, origin in rules:
            if regex.search(name):
                report.error("leaks", "%s: file name matches '%s' (%s)" % (name, label, origin))
                hits += 1
        if os.path.splitext(path)[1].lower() not in TEXT_EXTENSIONS:
            continue
        for number, line in enumerate(read_text(path).splitlines(), 1):
            for regex, label, origin in rules:
                if regex.search(line):
                    report.error("leaks", "%s:%d matches '%s' (%s)" % (name, number, label, origin))
                    hits += 1
    if not hits:
        report.note("leaks", "0 matches against %d rule(s) from %d deny-list(s)" % (len(rules), len(denylists)))


# 3. links -------------------------------------------------------------------

def check_links(root, report):
    count = 0
    for path in walk_files(root):
        if not path.endswith(".md"):
            continue
        in_fence = False
        for number, line in enumerate(read_text(path).splitlines(), 1):
            if line.lstrip().startswith("```"):
                in_fence = not in_fence
                continue
            if in_fence:
                continue
            for target in LINK_RE.findall(line):
                if re.match(r"^[a-zA-Z][a-zA-Z0-9+.-]*:", target) or target.startswith("#"):
                    continue
                target_path = target.split("#", 1)[0]
                if not target_path:
                    continue
                count += 1
                resolved = os.path.normpath(os.path.join(os.path.dirname(path), target_path))
                if not os.path.exists(resolved):
                    report.error("links", "%s:%d broken link -> %s" % (rel(root, path), number, target))
    report.note("links", "%d relative link(s) checked" % count)


# 4. scope -------------------------------------------------------------------

def check_scope(root, report):
    count = 0
    for path in walk_files(root):
        name = rel(root, path)
        if not name.endswith(".md") or name.startswith(SCOPE_EXEMPT_PREFIXES):
            continue
        count += 1
        _, body = strip_front_matter(read_text(path).splitlines())
        values = [SCOPE_RE.match(l.strip()).group(1) for l in body[:40] if SCOPE_RE.match(l.strip())]
        if not values:
            report.error("scope", "%s: no '**Scope**:' line in the first 40 lines" % name)
        elif values[0] != "method":
            report.error("scope", "%s: Scope is '%s'; everything in the kit must be 'method'" % (name, values[0]))
    report.note("scope", "%d knowledge doc(s) checked" % count)


# 5. skills and agents ------------------------------------------------------

def maturity_of(lines):
    for line in lines[:60]:
        match = MATURITY_RE.match(line.strip())
        if match:
            return match.group(1).strip("`*.,")
    return None


def check_skills(root, report):
    skills_dir = os.path.join(root, "skills")
    count = 0
    if os.path.isdir(skills_dir):
        for folder in sorted(os.listdir(skills_dir)):
            skill = os.path.join(skills_dir, folder, "SKILL.md")
            if not os.path.isfile(skill):
                if os.path.isdir(os.path.join(skills_dir, folder)):
                    report.error("skills", "skills/%s has no SKILL.md" % folder)
                continue
            count += 1
            lines = read_text(skill).splitlines()
            front, body = strip_front_matter(lines)
            keys = dict(l.split(":", 1) for l in front[1:-1] if ":" in l and not l.startswith(" "))
            name = keys.get("name", "").strip()
            if not front:
                report.error("skills", "skills/%s/SKILL.md has no front matter" % folder)
            elif name != folder:
                report.error("skills", "skills/%s/SKILL.md: name '%s' differs from the folder" % (folder, name))
            if front and not keys.get("description", "").strip():
                report.error("skills", "skills/%s/SKILL.md: empty description" % folder)
            if len(lines) > SKILL_MAX_LINES:
                report.error("skills", "skills/%s/SKILL.md: %d lines (max %d) - move detail to references/" % (folder, len(lines), SKILL_MAX_LINES))
            check_maturity(report, "skills/%s/SKILL.md" % folder, body)
    agents_dir = os.path.join(root, "agents")
    if os.path.isdir(agents_dir):
        for name in sorted(os.listdir(agents_dir)):
            if name.endswith(".md"):
                count += 1
                _, body = strip_front_matter(read_text(os.path.join(agents_dir, name)).splitlines())
                check_maturity(report, "agents/" + name, body)
    report.note("skills", "%d skill/agent file(s) checked" % count)


def check_maturity(report, name, body):
    value = maturity_of(body)
    if value is None:
        report.error("skills", "%s: no '**Maturity**:' line (one of %s)" % (name, ", ".join(MATURITY_VALUES)))
    elif value not in MATURITY_VALUES:
        report.error("skills", "%s: Maturity '%s' is not one of %s" % (name, value, ", ".join(MATURITY_VALUES)))


# 6. size --------------------------------------------------------------------

def check_size(root, report):
    for path in walk_files(root):
        if path.endswith(".md") and os.path.getsize(path) > MD_SIZE_BUDGET:
            report.warn("size", "%s is %d KB (budget %d KB): split it or move history to the CHANGELOG"
                        % (rel(root, path), os.path.getsize(path) // 1024, MD_SIZE_BUDGET // 1024))


# 7. coverage ----------------------------------------------------------------

def check_coverage(root, report):
    module_path = os.path.join(root, "runtime", "coverage.py")
    if not os.path.isfile(os.path.join(root, "docs", "techniques.csv")):
        report.error("coverage", "missing docs/techniques.csv (the technique register)")
        return
    if not os.path.isfile(module_path):
        report.error("coverage", "missing runtime/coverage.py")
        return
    # loaded by path: a PyPI package called 'coverage' may be installed
    import importlib.util
    spec = importlib.util.spec_from_file_location("kit_coverage", module_path)
    cov = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(cov)
    header, rows = cov.load(root)
    errors, warnings = cov.validate(root, header, rows)
    for message in errors:
        report.error("coverage", message)
    for message in warnings:
        report.warn("coverage", message)
    if not cov.page_is_current(root, rows):
        report.error("coverage", "docs/TECHNIQUES.md is stale: run python runtime/coverage.py")
    s = cov.summary(rows)
    report.note("coverage", "%d techniques - %d in kit, %d partial, %d planned (done %s, started %s)"
                % (s["rows"], s["in-kit"], s["partial"], s["planned"], s["done"], s["started"]))


# 8. sections ----------------------------------------------------------------

GOVERNANCE_HEADING = "## Governance (mandatory, every task)"
AGENT_TEMPLATE = "templates/AGENT.template.md"
HEADING_RE = re.compile(r"^(#{1,6})\s")


def outline(lines):
    """[(index, level)] of the markdown headings outside fenced code."""
    found, in_fence = [], False
    for index, line in enumerate(lines):
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
            continue
        match = None if in_fence else HEADING_RE.match(line)
        if match:
            found.append((index, len(match.group(1))))
    return found


def governance_block(lines):
    """The governance section to the end of the file, whitespace collapsed; None if absent."""
    starts = [i for i, level in outline(lines) if level == 2 and lines[i].strip() == GOVERNANCE_HEADING]
    return " ".join(" ".join(lines[starts[-1]:]).split()) if starts else None


def check_header_block(report, name, body, heads):
    """Scope and Maturity sit between the title and the first '## ' section (when present)."""
    start = heads[0][0] if heads else 0
    end = next((i for i, level in heads if level == 2), len(body))
    for label, pattern in (("Scope", SCOPE_RE), ("Maturity", MATURITY_RE)):
        inside = any(pattern.match(l.strip()) for l in body[start:end])
        elsewhere = any(pattern.match(l.strip()) for l in body)
        if elsewhere and not inside:  # a missing line is reported by checks 4 and 5
            report.error("sections", "%s: the '**%s**:' line is outside the header block (between the title "
                                     "and the first '## ' section)" % (name, label))


def check_sections(root, report):
    count, chars = 0, 0
    not_use_when = 0  # EK#18: rewritten when touched; becomes an error once it reaches zero
    skills_dir = os.path.join(root, "skills")
    if os.path.isdir(skills_dir):
        for folder in sorted(os.listdir(skills_dir)):
            path = os.path.join(skills_dir, folder, "SKILL.md")
            if not os.path.isfile(path):
                continue
            count += 1
            name = "skills/%s/SKILL.md" % folder
            front, body = strip_front_matter(read_text(path).splitlines())
            keys = dict(l.split(":", 1) for l in front[1:-1] if ":" in l and not l.startswith(" "))
            chars += len(keys.get("name", "").strip()) + len(keys.get("description", "").strip())
            if not keys.get("description", "").strip().strip("\"'").startswith("Use when"):
                not_use_when += 1
            heads = outline(body)
            if not heads or heads[0][1] != 1 or not body[heads[0][0]].startswith("# Skill: "):
                found = body[heads[0][0]].strip() if heads else "no heading"
                report.error("sections", "%s: the first heading must be '# Skill: <name> (<the idea>)' (found '%s')"
                             % (name, found[:60]))
            check_header_block(report, name, body, heads)
    agents_dir = os.path.join(root, "agents")
    template = os.path.join(root, *AGENT_TEMPLATE.split("/"))
    expected = governance_block(read_text(template).splitlines()) if os.path.isfile(template) else None
    if os.path.isdir(agents_dir):
        if expected is None:
            report.error("sections", "%s has no '%s' block: the agents have no source to match"
                         % (AGENT_TEMPLATE, GOVERNANCE_HEADING))
        for file_name in sorted(os.listdir(agents_dir)):
            if not file_name.endswith(".md"):
                continue
            count += 1
            name = "agents/" + file_name
            lines = read_text(os.path.join(agents_dir, file_name)).splitlines()
            front, body = strip_front_matter(lines)
            keys = dict(l.split(":", 1) for l in front[1:-1] if ":" in l and not l.startswith(" "))
            chars += len(keys.get("name", "").strip()) + len(keys.get("description", "").strip())
            if not keys.get("description", "").strip().strip("\"'").startswith("Use when"):
                not_use_when += 1
            if not front:
                report.error("sections", "%s has no front matter (name, description, tools)" % name)
            else:
                if keys.get("name", "").strip() != file_name[:-3]:
                    report.error("sections", "%s: name '%s' differs from the file name" % (name, keys.get("name", "").strip()))
                if not keys.get("description", "").strip():
                    report.error("sections", "%s: empty description" % name)
            if len(lines) > SKILL_MAX_LINES:
                report.error("sections", "%s: %d lines (max %d) - move the fixed procedure to a skill"
                             % (name, len(lines), SKILL_MAX_LINES))
            heads = outline(body)
            if not heads or heads[0][1] != 1:
                report.error("sections", "%s: the first heading must be the H1 title" % name)
            check_header_block(report, name, body, heads)
            last_h2 = [i for i, level in heads if level == 2][-1:]
            if not last_h2 or body[last_h2[0]].strip() != GOVERNANCE_HEADING:
                report.error("sections", "%s: the last section must be '%s' (T72)" % (name, GOVERNANCE_HEADING))
            elif expected is not None and governance_block(body) != expected:
                report.error("sections", "%s: the governance block differs from %s - it is copied word for word "
                                         "(T72); agent rules go in a section above it" % (name, AGENT_TEMPLATE))
    report.note("sections", "%d skill/agent file(s) checked; descriptions cost ~%d tokens in every session "
                            "(characters / 4); %d description(s) do not start with 'Use when' yet (EK#18)"
                % (count, chars // 4, not_use_when))


def check_levels(root, report):
    module_path = os.path.join(root, "runtime", "levels.py")
    if not os.path.isfile(module_path):
        report.error("levels", "missing runtime/levels.py")
        return
    import importlib.util
    spec = importlib.util.spec_from_file_location("kit_levels", module_path)
    lv = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(lv)
    errors, note = lv.check(root)
    for message in errors:
        report.error("levels", message)
    if note:
        report.note("levels", note)


# main -----------------------------------------------------------------------

def main(argv=None):
    parser = argparse.ArgumentParser(description="Lint the engine-kit (version, leaks, links, scope, skills, size, coverage, sections).")
    parser.add_argument("--root", default=os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                        help="kit root (default: the folder above runtime/)")
    parser.add_argument("--denylist", action="append", default=[],
                        help="case deny-list file (repeatable); also read from KIT_DENYLISTS")
    parser.add_argument("--require-denylist", action="store_true",
                        help="fail when no deny-list is given (use before every release)")
    args = parser.parse_args(argv)

    root = os.path.abspath(args.root)
    denylists = list(args.denylist)
    env = os.environ.get("KIT_DENYLISTS", "")
    denylists.extend(p for p in env.split(os.pathsep) if p)

    report = Report()
    check_version(root, report)
    check_leaks(root, denylists, args.require_denylist, report)
    check_links(root, report)
    check_scope(root, report)
    check_skills(root, report)
    check_size(root, report)
    check_coverage(root, report)
    check_sections(root, report)
    check_levels(root, report)

    for check, msg in report.notes:
        print("ok    [%s] %s" % (check, msg))
    for check, msg in report.warnings:
        print("WARN  [%s] %s" % (check, msg))
    for check, msg in report.errors:
        print("ERROR [%s] %s" % (check, msg))
    print("kit-lint: %d error(s), %d warning(s)" % (len(report.errors), len(report.warnings)))
    return 1 if report.errors else 0


if __name__ == "__main__":
    sys.exit(main())
