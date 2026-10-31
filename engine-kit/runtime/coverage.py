#!/usr/bin/env python3
"""coverage - the technique register of the kit and how much of it the kit already holds.

Source of record: docs/techniques.csv, one row per technique:

  id,module,name,rule,maturity,tier,status,wave,location

  id        T01, T02, ... (never renumbered; a dropped technique becomes status "rejected")
  module    M0..M9 and M1g (see MODULES below)
  maturity  proven | operating | candidate | design  (docs/MATURITY.md)
  tier      core | candidate | design
  status    in-kit | partial | planned | rejected
  wave      0..4, or - when not scheduled
  location  ';'-separated kit paths. For in-kit and partial rows every path must exist;
            for planned rows it is the intended home and is not checked.

This script renders docs/TECHNIQUES.md from the CSV (never edit that page by hand) and
prints the coverage. runtime/kit_lint.py imports validate() and render() and fails when
a row is malformed, an in-kit/partial path is missing, a skill or agent of the kit is not
registered by any in-kit/partial row, or TECHNIQUES.md is stale.

Usage:
  python runtime/coverage.py            rewrite docs/TECHNIQUES.md and print the summary
  python runtime/coverage.py --check    exit 1 if the page is stale or the register invalid

Python 3.8+, standard library only.
"""

import argparse
import csv
import io
import os
import re
import sys

COLUMNS = ["id", "module", "name", "rule", "maturity", "tier", "status", "wave", "location"]
MODULES = [
    ("M0", "The vessel (knowledge base)"),
    ("M1", "Legacy assessment"),
    ("M1g", "Greenfield framing"),
    ("M2", "Conceptualize"),
    ("M3", "Decide"),
    ("M4", "Change"),
    ("M5", "Verify"),
    ("M6", "Close and retain"),
    ("M7", "Hygiene and guards"),
    ("M8", "Self-improvement and authoring"),
    ("M9", "Knowledge-ecosystem construction"),
]
MATURITY = ("proven", "operating", "candidate", "design")
TIERS = ("core", "candidate", "design")
STATUSES = ("in-kit", "partial", "planned", "rejected")
WAVES = ("0", "1", "2", "3", "4", "-")
REGISTER = "docs/techniques.csv"   # kit-relative, '/' in messages on every OS
PAGE = "docs/TECHNIQUES.md"
ID_RE = re.compile(r"^T(\d{2,})$")


def kit_root():
    return os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load(root):
    """Return (header, rows) from docs/techniques.csv; rows are dicts plus a 'line' key."""
    path = os.path.join(root, REGISTER)
    with open(path, "r", encoding="utf-8", newline="") as handle:
        reader = csv.reader(handle)
        header = next(reader, [])
        rows = []
        for number, values in enumerate(reader, 2):
            if not values or not any(v.strip() for v in values):
                continue
            row = {name: (values[i].strip() if i < len(values) else "") for i, name in enumerate(COLUMNS)}
            row["line"] = number
            row["extra"] = len(values) > len(COLUMNS)
            rows.append(row)
    return header, rows


def locations(row):
    return [p.strip().replace("\\", "/").rstrip("/") for p in row["location"].split(";") if p.strip()]


def kit_components(root):
    """Skills and agents the kit ships, as kit-relative paths."""
    found = []
    skills = os.path.join(root, "skills")
    if os.path.isdir(skills):
        for name in sorted(os.listdir(skills)):
            if os.path.isfile(os.path.join(skills, name, "SKILL.md")):
                found.append("skills/" + name)
    agents = os.path.join(root, "agents")
    if os.path.isdir(agents):
        for name in sorted(os.listdir(agents)):
            if name.endswith(".md"):
                found.append("agents/" + name)
    return found


def validate(root, header, rows):
    """Return (errors, warnings) as lists of strings."""
    errors, warnings = [], []
    if header != COLUMNS:
        errors.append("%s: header must be %s" % (REGISTER, ",".join(COLUMNS)))
        return errors, warnings
    known_modules = set(m for m, _ in MODULES)
    seen, numbers = {}, []
    for row in rows:
        where = "%s:%d %s" % (REGISTER, row["line"], row["id"] or "?")
        if row["extra"]:
            errors.append(where + ": more columns than the header (quote fields that contain commas)")
        match = ID_RE.match(row["id"])
        if not match:
            errors.append(where + ": id must look like T01")
        else:
            numbers.append(int(match.group(1)))
        if row["id"] in seen:
            errors.append(where + ": duplicate id (first at line %d)" % seen[row["id"]])
        seen.setdefault(row["id"], row["line"])
        for field, allowed in (("module", known_modules), ("maturity", MATURITY), ("tier", TIERS),
                               ("status", STATUSES), ("wave", WAVES)):
            if row[field] not in allowed:
                errors.append(where + ": %s '%s' is not one of %s" % (field, row[field], ", ".join(sorted(allowed))))
        for field in ("name", "rule"):
            if not row[field]:
                errors.append(where + ": empty " + field)
            if "|" in row[field]:
                errors.append(where + ": '|' in %s breaks the generated table" % field)
        if row["status"] in ("in-kit", "partial"):
            paths = locations(row)
            if not paths:
                errors.append(where + ": status %s needs a location" % row["status"])
            for rel in paths:
                if not os.path.exists(os.path.join(root, rel)):
                    errors.append(where + ": location '%s' does not exist" % rel)
        if row["status"] == "planned" and row["wave"] == "-":
            warnings.append(where + ": planned but no wave")
    if numbers:
        missing = sorted(set(range(1, max(numbers) + 1)) - set(numbers))
        if missing:
            warnings.append("%s: id gap(s): %s (a dropped technique stays as 'rejected')"
                            % (REGISTER, ", ".join("T%02d" % n for n in missing)))
    covered = set()
    for row in rows:
        if row["status"] in ("in-kit", "partial"):
            covered.update(locations(row))
    for component in kit_components(root):
        if not any(c == component or c.startswith(component + "/") for c in covered):
            errors.append("%s is not registered by any in-kit or partial row of %s" % (component, REGISTER))
    return errors, warnings


def counts(rows):
    out = {s: 0 for s in STATUSES}
    for row in rows:
        if row["status"] in out:
            out[row["status"]] += 1
    out["rows"] = len(rows)
    return out


def pct(part, whole):
    return "%d%%" % int(round(100.0 * part / whole)) if whole else "-"


def summary(rows):
    active = [r for r in rows if r["status"] != "rejected"]
    c = counts(active)
    return {"rows": c["rows"], "in-kit": c["in-kit"], "partial": c["partial"], "planned": c["planned"],
            "done": pct(c["in-kit"], c["rows"]), "started": pct(c["in-kit"] + c["partial"], c["rows"])}


def cell(text):
    return text.replace("|", "/").replace("\n", " ")


def where_cell(row):
    paths = locations(row)
    if row["status"] in ("in-kit", "partial"):
        return "; ".join("[`%s`](../%s)" % (p, p) for p in paths)
    if row["status"] == "planned" and paths:
        return "planned: " + "; ".join("`%s`" % p for p in paths)
    return "-"


def render(rows):
    active = [r for r in rows if r["status"] != "rejected"]
    out = io.StringIO()
    w = out.write
    w("# Technique coverage\n\n")
    w("**Scope**: method\n\n")
    w("Generated by `runtime/coverage.py` from [`techniques.csv`](techniques.csv): edit the CSV,\n")
    w("never this page. `runtime/kit_lint.py` fails when this page is stale, when a row marked\n")
    w("`in-kit` or `partial` points at a file that does not exist, or when a skill or an agent of\n")
    w("the kit is not registered by any such row. Maturity labels: [MATURITY.md](MATURITY.md).\n\n")
    w("*Done* = in kit / rows. *Started* = (in kit + partial) / rows. Rejected rows are left out.\n\n")

    w("## Summary\n\n")
    w("| Tier | Rows | In kit | Partial | Planned | Done | Started |\n|---|---|---|---|---|---|---|\n")
    for label, subset in [("All techniques", active)] + [(t, [r for r in active if r["tier"] == t]) for t in TIERS]:
        c = counts(subset)
        w("| %s | %d | %d | %d | %d | %s | %s |\n" % (label, c["rows"], c["in-kit"], c["partial"], c["planned"],
                                                     pct(c["in-kit"], c["rows"]), pct(c["in-kit"] + c["partial"], c["rows"])))
    w("\n## By module\n\n")
    w("| Module | Rows | In kit | Partial | Planned | Done |\n|---|---|---|---|---|---|\n")
    for module, title in MODULES:
        c = counts([r for r in active if r["module"] == module])
        if c["rows"]:
            w("| %s %s | %d | %d | %d | %d | %s |\n" % (module, title, c["rows"], c["in-kit"], c["partial"],
                                                        c["planned"], pct(c["in-kit"], c["rows"])))
    w("\n## What is left, by wave\n\n")
    w("| Wave | Planned | Partial | Techniques |\n|---|---|---|---|\n")
    for wave in WAVES:
        left = [r for r in active if r["wave"] == wave and r["status"] in ("planned", "partial")]
        if left:
            w("| %s | %d | %d | %s |\n" % (wave, sum(1 for r in left if r["status"] == "planned"),
                                          sum(1 for r in left if r["status"] == "partial"),
                                          ", ".join(r["id"] for r in left)))
    for module, title in MODULES:
        subset = [r for r in rows if r["module"] == module]
        if not subset:
            continue
        w("\n## %s - %s\n\n" % (module, title))
        w("| Id | Technique | Rule | Maturity | Tier | Status | Wave | Where |\n|---|---|---|---|---|---|---|---|\n")
        for r in subset:
            w("| %s | %s | %s | %s | %s | %s | %s | %s |\n" % (r["id"], cell(r["name"]), cell(r["rule"]), r["maturity"],
                                                             r["tier"], r["status"].replace("-", " "), r["wave"], where_cell(r)))
    return out.getvalue()


def page_is_current(root, rows):
    path = os.path.join(root, PAGE)
    if not os.path.isfile(path):
        return False
    with open(path, "r", encoding="utf-8", newline="") as handle:
        return handle.read().replace("\r\n", "\n") == render(rows)


def main(argv=None):
    parser = argparse.ArgumentParser(description="Render docs/TECHNIQUES.md from docs/techniques.csv and report coverage.")
    parser.add_argument("--root", default=kit_root(), help="kit root (default: the folder above runtime/)")
    parser.add_argument("--check", action="store_true", help="write nothing; exit 1 if the register is invalid or the page stale")
    args = parser.parse_args(argv)
    root = os.path.abspath(args.root)
    header, rows = load(root)
    errors, warnings = validate(root, header, rows)
    for message in warnings:
        print("WARN  " + message)
    for message in errors:
        print("ERROR " + message)
    s = summary(rows)
    print("coverage: %d techniques - %d in kit, %d partial, %d planned (done %s, started %s)"
          % (s["rows"], s["in-kit"], s["partial"], s["planned"], s["done"], s["started"]))
    if args.check:
        if not page_is_current(root, rows):
            print("ERROR %s is stale: run python runtime/coverage.py" % PAGE)
            return 1
        return 1 if errors else 0
    if errors:
        print("page not written: fix the register first")
        return 1
    with open(os.path.join(root, PAGE), "w", encoding="utf-8", newline="\n") as handle:
        handle.write(render(rows))
    print("wrote " + PAGE)
    return 0


if __name__ == "__main__":
    sys.exit(main())
