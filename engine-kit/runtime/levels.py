#!/usr/bin/env python3
"""levels - the adoption levels of the kit as data that a tool can read.

Source of record: docs/ADOPTION-LEVELS.md. Each "## Level N - <Name>" section of that page
holds one piece table (its header row starts with "| Piece |"); the first cell of each row
links the pieces the row places, and its Track cell says which track they serve. This
script reads the skills (../skills/<name>/SKILL.md) and agents (../agents/<name>.md) linked
there, with their track, and writes runtime/levels.json, the list that
runtime/sync-skills.ps1 reads for -Level and -Track (Windows PowerShell has no markdown
parser, and a tool must not guess). Never edit levels.json by hand: edit the page, then run
--write.

Track cells (rule 5 of the page): "both", "both (<note>)" and "<track>, mostly" serve both
tracks; "legacy" or "greenfield" serves that track only; "<track> (both from level N)"
serves that track below level N and both from N. In levels.json each level lists, under
"tracks", the skills and agents it places that do not serve both tracks; a piece not listed
there serves both.

check() - called by runtime/kit_lint.py - reports an error when:
  - the page does not hold exactly the sections Level 1, 2 and 3, each with a piece table
    that places at least one skill;
  - a piece table has no Track column, or a Track cell says something the rule above does
    not know;
  - a skill or agent is placed twice, or placed but missing from skills/ or agents/;
  - a skill of skills/ or an agent of agents/ is placed in no level;
  - the page's "**Count**:" line disagrees with the tables on skills or agents per level;
  - runtime/levels.json is missing, unreadable, or differs from what the page says.

Usage:
  python runtime/levels.py            print the levels the page places
  python runtime/levels.py --write    regenerate runtime/levels.json from the page
  python runtime/levels.py --check    write nothing; exit 1 on any error above

Python 3.8+, standard library only.
"""

import argparse
import json
import os
import re
import sys

PAGE = "docs/ADOPTION-LEVELS.md"     # kit-relative, '/' in messages on every OS
DATA = "runtime/levels.json"
LEVELS = [1, 2, 3]
NOTE = ("Generated from docs/ADOPTION-LEVELS.md by: python runtime/levels.py --write. "
        "Do not edit by hand: the page is the source of record and kit_lint fails on drift. "
        "tracks: the skills and agents of a level that serve one track only (the Track column); "
        "a piece not listed there serves both tracks.")

LEVEL_RE = re.compile(r"^## Level ([0-9]+) - (.+?)\s*$")
SECTION_RE = re.compile(r"^## ")
PIECE_HEADER_RE = re.compile(r"^\|\s*Piece\s*\|")
SKILL_LINK_RE = re.compile(r"\]\(\.\./skills/([A-Za-z0-9._-]+)/SKILL\.md\)")
AGENT_LINK_RE = re.compile(r"\]\(\.\./agents/([A-Za-z0-9._-]+)\.md\)")
COUNT_RE = re.compile(r"(\d+) (skills|agents) \((\d+) / (\d+) / (\d+)\)")
CELL_SPLIT_RE = re.compile(r"(?<!\\)\|")
SEPARATOR_RE = re.compile(r"^\s*:?-+:?\s*$")
BOTH_RE = re.compile(r"^both\b")
MOSTLY_RE = re.compile(r"^(legacy|greenfield), mostly$")
ONE_TRACK_RE = re.compile(r"^(legacy|greenfield)(?: \(both from level ([0-9]+)\))?$")


def kit_root():
    return os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def read_text(path):
    with open(path, "r", encoding="utf-8", errors="replace") as handle:
        return handle.read()


def split_cells(line):
    """The cells of a markdown table row, without the outer pipes; an escaped pipe stays."""
    cells = CELL_SPLIT_RE.split(line.strip())
    if cells and not cells[0].strip():
        cells = cells[1:]
    if cells and not cells[-1].strip():
        cells = cells[:-1]
    return cells


def parse_track(cell):
    """A Track cell -> (track, both_from): ("both", None) for "both", "both (<note>)" and
    "<track>, mostly"; ("legacy" | "greenfield", None | N) for one track, N from
    "(both from level N)"; (None, None) when the cell says something else."""
    text = " ".join(cell.split())
    if BOTH_RE.match(text) or MOSTLY_RE.match(text):
        return "both", None
    match = ONE_TRACK_RE.match(text)
    if match:
        return match.group(1), (int(match.group(2)) if match.group(2) else None)
    return None, None


def parse_page(text):
    """Return (levels, errors). levels: [{"level", "name", "skills", "agents", "tracks"}] in
    page order, names in table order, tracks {name: {"track", ["both_from_level"]}} for the
    pieces of one track only; errors: what makes the page unusable as a source."""
    levels, errors = [], []
    current, in_table, tables, track_col = None, False, {}, None
    for line in text.splitlines():
        match = LEVEL_RE.match(line)
        if match:
            current = {"level": int(match.group(1)), "name": match.group(2), "skills": [], "agents": [],
                       "tracks": {}}
            levels.append(current)
            tables[current["level"]] = 0
            in_table = False
            continue
        if SECTION_RE.match(line):
            current, in_table = None, False
            continue
        if current is None:
            continue
        if PIECE_HEADER_RE.match(line):
            in_table = True
            tables[current["level"]] += 1
            header = [cell.strip() for cell in split_cells(line)]
            track_col = header.index("Track") if "Track" in header else None
            if track_col is None:
                errors.append("%s: the piece table of Level %d has no Track column" % (PAGE, current["level"]))
            continue
        if in_table:
            if not line.startswith("|"):
                in_table = False
                continue
            cells = split_cells(line)
            if cells and all(SEPARATOR_RE.match(cell) for cell in cells):
                continue
            first_cell = cells[0] if cells else ""
            skills = SKILL_LINK_RE.findall(first_cell)
            agents = AGENT_LINK_RE.findall(first_cell)
            current["skills"].extend(skills)
            current["agents"].extend(agents)
            if track_col is None:
                continue
            cell = cells[track_col].strip() if len(cells) > track_col else ""
            track, both_from = parse_track(cell)
            if track is None:
                errors.append("%s: Level %d: unknown Track '%s' in the row of %s (expected both, "
                              "both (<note>), legacy, greenfield, '<track>, mostly' or "
                              "'<track> (both from level N)')"
                              % (PAGE, current["level"], cell, first_cell.strip()[:60]))
                continue
            if both_from is not None and not current["level"] < both_from <= LEVELS[-1]:
                errors.append("%s: Level %d: Track '%s' - the level from which it serves both tracks "
                              "must be above %d and at most %d"
                              % (PAGE, current["level"], cell, current["level"], LEVELS[-1]))
                continue
            if track != "both":
                info = {"track": track}
                if both_from is not None:
                    info["both_from_level"] = both_from
                for name in skills + agents:
                    current["tracks"][name] = info

    found = [entry["level"] for entry in levels]
    if found != LEVELS:
        errors.append("%s: expected the sections '## Level 1 - ...', '## Level 2 - ...', '## Level 3 - ...' "
                      "in that order, found levels %s" % (PAGE, found or "none"))
    for entry in levels:
        if tables.get(entry["level"]) != 1:
            errors.append("%s: Level %d has %d piece tables (header '| Piece | ...'), expected 1"
                          % (PAGE, entry["level"], tables.get(entry["level"], 0)))
        elif not entry["skills"]:
            errors.append("%s: the piece table of Level %d places no skill" % (PAGE, entry["level"]))

    for kind in ("skills", "agents"):
        seen = {}
        for entry in levels:
            for name in entry[kind]:
                if name in seen:
                    where = ("twice in Level %d" % entry["level"] if seen[name] == entry["level"]
                             else "in Level %d and Level %d" % (seen[name], entry["level"]))
                    errors.append("%s: %s '%s' is placed %s (each piece sits in exactly one level)"
                                  % (PAGE, kind[:-1], name, where))
                else:
                    seen[name] = entry["level"]
    return levels, errors


def kit_pieces(root):
    """The skills and agents the kit ships, by name."""
    skills, agents = set(), set()
    skills_dir = os.path.join(root, "skills")
    if os.path.isdir(skills_dir):
        for name in os.listdir(skills_dir):
            if os.path.isfile(os.path.join(skills_dir, name, "SKILL.md")):
                skills.add(name)
    agents_dir = os.path.join(root, "agents")
    if os.path.isdir(agents_dir):
        for name in os.listdir(agents_dir):
            if name.endswith(".md") and os.path.isfile(os.path.join(agents_dir, name)):
                agents.add(name[:-3])
    return skills, agents


def check_tree(levels, root):
    """Every piece of the kit placed once, and nothing placed that the kit lacks."""
    errors = []
    skills, agents = kit_pieces(root)
    for kind, present in (("skills", skills), ("agents", agents)):
        placed = set()
        for entry in levels:
            placed.update(entry[kind])
        folder = "skills/<name>/SKILL.md" if kind == "skills" else "agents/<name>.md"
        for name in sorted(placed - present):
            errors.append("%s places %s '%s', which the kit does not have (%s)" % (PAGE, kind[:-1], name, folder))
        for name in sorted(present - placed):
            errors.append("%s '%s' is placed in no level: add it to the piece table of its level in %s"
                          % (kind[:-1], name, PAGE))
    return errors


def check_count(text, levels):
    """The "**Count**:" paragraph, when present, agrees with the tables (skills, agents)."""
    errors = []
    start = text.find("**Count**:")
    if start < 0:
        return errors
    end = text.find("\n\n", start)
    paragraph = " ".join(text[start:end if end >= 0 else len(text)].split())
    by_level = {entry["level"]: entry for entry in levels}
    for match in COUNT_RE.finditer(paragraph):
        kind = match.group(2)
        said = [int(match.group(i)) for i in (1, 3, 4, 5)]
        real = [len(by_level.get(n, {}).get(kind, [])) for n in LEVELS]
        real = [sum(real)] + real
        if said != real:
            errors.append("%s: the Count line says %d %s (%d / %d / %d), the tables place %d (%d / %d / %d)"
                          % tuple([PAGE] + said[:1] + [kind] + said[1:] + real))
    return errors


def build_data(levels):
    return {
        "note": NOTE,
        "source": PAGE,
        "levels": [{"level": entry["level"], "name": entry["name"],
                    "skills": sorted(set(entry["skills"])), "agents": sorted(set(entry["agents"])),
                    "tracks": {name: dict(entry["tracks"][name]) for name in sorted(entry["tracks"])}}
                   for entry in levels],
    }


def track_words(info):
    """{"track": "greenfield", "both_from_level": 2} -> 'greenfield (both from level 2)'."""
    if not isinstance(info, dict):
        return "both"
    words = str(info.get("track"))
    if info.get("both_from_level") is not None:
        words += " (both from level %s)" % info.get("both_from_level")
    return words


def render(data):
    return json.dumps(data, indent=2) + "\n"


def load_page(root):
    path = os.path.join(root, PAGE)
    if not os.path.isfile(path):
        return None, None, ["missing %s (the source of record of the levels)" % PAGE]
    text = read_text(path)
    levels, errors = parse_page(text)
    return text, levels, errors


def compare_data(expected, root):
    path = os.path.join(root, DATA)
    if not os.path.isfile(path):
        return ["missing %s: run python runtime/levels.py --write" % DATA]
    try:
        actual = json.loads(read_text(path))
    except ValueError as exc:
        return ["%s is not valid JSON (%s): run python runtime/levels.py --write" % (DATA, exc)]
    if actual == expected:
        return []
    errors = []
    old = {e.get("level"): e for e in actual.get("levels", []) if isinstance(e, dict)} if isinstance(actual, dict) else {}
    for entry in expected["levels"]:
        before = old.get(entry["level"], {})
        for kind in ("skills", "agents"):
            was, now = set(before.get(kind, [])), set(entry[kind])
            for name in sorted(now - was):
                errors.append("%s is stale: Level %d of the page places %s '%s', the data file does not"
                              % (DATA, entry["level"], kind[:-1], name))
            for name in sorted(was - now):
                errors.append("%s is stale: it puts %s '%s' in Level %d, the page does not"
                              % (DATA, kind[:-1], name, entry["level"]))
        was_tracks = before.get("tracks") if isinstance(before.get("tracks"), dict) else {}
        for name in sorted(set(was_tracks) | set(entry["tracks"])):
            if was_tracks.get(name) != entry["tracks"].get(name):
                errors.append("%s is stale: the page gives '%s' (Level %d) the track %s, the data file %s"
                              % (DATA, name, entry["level"], track_words(entry["tracks"].get(name)),
                                 track_words(was_tracks.get(name))))
    if not errors:
        errors.append("%s differs from the page (order, names or note edited by hand)" % DATA)
    errors.append("run python runtime/levels.py --write to regenerate %s from %s" % (DATA, PAGE))
    return errors


def plural(count, word):
    return "%d %s%s" % (count, word, "" if count == 1 else "s")


def describe(levels):
    parts = []
    for entry in levels:
        part = "L%d %s: %s, %s" % (entry["level"], entry["name"], plural(len(entry["skills"]), "skill"),
                                    plural(len(entry["agents"]), "agent"))
        if entry.get("tracks"):
            part += " (%d of one track)" % len(entry["tracks"])
        parts.append(part)
    return "; ".join(parts)


def check(root):
    """For kit_lint: (errors, note). Writes nothing."""
    text, levels, errors = load_page(root)
    if text is None:
        return errors, ""
    errors = errors + check_tree(levels, root) + check_count(text, levels)
    if levels and [e["level"] for e in levels] == LEVELS:
        errors += compare_data(build_data(levels), root)
    return errors, describe(levels)


def main(argv=None):
    parser = argparse.ArgumentParser(description="The adoption levels as data: derive runtime/levels.json "
                                                 "from docs/ADOPTION-LEVELS.md and check that they agree.")
    parser.add_argument("--root", default=kit_root(), help="kit root (default: the folder above runtime/)")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--check", action="store_true", help="write nothing; exit 1 on any drift")
    mode.add_argument("--write", action="store_true", help="regenerate runtime/levels.json from the page")
    args = parser.parse_args(argv)
    root = os.path.abspath(args.root)

    if args.write:
        text, levels, errors = load_page(root)
        if text is not None:
            errors = errors + check_tree(levels, root) + check_count(text, levels)
        if errors:
            for message in errors:
                print("ERROR [levels] %s" % message)
            print("levels: %s not written - fix the page first" % DATA)
            return 1
        with open(os.path.join(root, DATA), "w", encoding="utf-8", newline="\n") as handle:
            handle.write(render(build_data(levels)))
        print("levels: wrote %s (%s)" % (DATA, describe(levels)))
        return 0

    errors, note = check(root)
    if note:
        print("ok    [levels] %s" % note)
    for message in errors:
        print("ERROR [levels] %s" % message)
    if not args.check:
        _, levels, _ = load_page(root)
        for entry in levels or []:
            print("Level %d - %s" % (entry["level"], entry["name"]))
            print("  skills: %s" % ", ".join(sorted(entry["skills"])))
            print("  agents: %s" % (", ".join(sorted(entry["agents"])) or "-"))
            print("  one track: %s" % (", ".join("%s: %s" % (name, track_words(entry["tracks"][name]))
                                                 for name in sorted(entry["tracks"])) or "-"))
    print("levels: %d error(s)" % len(errors))
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
