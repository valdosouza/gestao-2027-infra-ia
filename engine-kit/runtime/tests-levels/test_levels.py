"""levels.py on a small synthetic kit: the page is the source of record, levels.json is
derived from it - the level of every skill and agent, and the track of those that serve one
track only (the Track column) - and every kind of drift is an error. Everything happens in
a temporary folder; the real kit is only read (structural tests of the real page).

Run: python -m unittest discover -s runtime/tests-levels -v
"""

import contextlib
import io
import json
import os
import shutil
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
RUNTIME = os.path.dirname(HERE)
KIT = os.path.dirname(RUNTIME)
if RUNTIME not in sys.path:
    sys.path.insert(0, RUNTIME)

import levels  # noqa: E402

PAGE = """# Adoption levels

**Scope**: method

## The three levels

| Level | When | What it turns on | Move up when |
|---|---|---|---|
| **1 Essential** | Day 1 | [`alpha`](../skills/alpha/SKILL.md) is mentioned here, not placed | - |

## Level 1 - Essential

| Practice | Pieces |
|---|---|
| A practice | [`alpha`](../skills/alpha/SKILL.md) |

| Piece | Kind | Core / situational - trigger | Track |
|---|---|---|---|
| [`alpha`](../skills/alpha/SKILL.md), [`beta`](../skills/beta/SKILL.md) | skills | core | both |
| [`scout`](../agents/scout.md) | agent | core | legacy |

## Level 2 - Governed

| Piece | Kind | Core / situational - trigger | Track |
|---|---|---|---|
| [`gamma`](../skills/gamma/SKILL.md) | skill | situational - with [`delta`](../skills/delta/SKILL.md) | both |
| [`builder`](../agents/builder.md) | agent | situational | both |

## Level 3 - Scale

| Piece | Kind | Core / situational - trigger | Track |
|---|---|---|---|
| [`delta`](../skills/delta/SKILL.md) | skill | core | both |

**Not in a level**: [`lint`](../runtime/lint.py).

**Count**: 4 skills (2 / 1 / 1), 2 agents (1 / 1 / 0), 3 templates (1 / 1 / 1) - each
placed once above.

## Moving up

Nothing here is placed: [`gamma`](../skills/gamma/SKILL.md).
"""

SKILLS = ["alpha", "beta", "gamma", "delta"]
AGENTS = ["scout", "builder"]

# The same page with every kind of Track cell: a note after both, one track, one track
# below a level, "<track>, mostly".
TRACK_ROWS = [
    ("| [`alpha`](../skills/alpha/SKILL.md), [`beta`](../skills/beta/SKILL.md) | skills | core | both |",
     "| [`alpha`](../skills/alpha/SKILL.md) | skill | core | both (legacy: a note) |\n"
     "| [`beta`](../skills/beta/SKILL.md) | skill | core (track entry) | greenfield (both from level 2) |"),
    ("| [`gamma`](../skills/gamma/SKILL.md) | skill | situational - with [`delta`](../skills/delta/SKILL.md) | both |",
     "| [`gamma`](../skills/gamma/SKILL.md) | skill | situational - with [`delta`](../skills/delta/SKILL.md) | legacy |"),
    ("| [`builder`](../agents/builder.md) | agent | situational | both |",
     "| [`builder`](../agents/builder.md) | agent | situational | legacy, mostly |"),
]


def track_page(page=PAGE):
    for old, new in TRACK_ROWS:
        assert old in page, old
        page = page.replace(old, new)
    return page


def run_cli(*args):
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        code = levels.main(list(args))
    return code, out.getvalue()


class SyntheticKit(unittest.TestCase):
    def setUp(self):
        self.root = tempfile.mkdtemp(prefix="levels-test-")
        self.addCleanup(shutil.rmtree, self.root, True)
        os.makedirs(os.path.join(self.root, "docs"))
        os.makedirs(os.path.join(self.root, "runtime"))
        os.makedirs(os.path.join(self.root, "agents"))
        for name in SKILLS:
            self.add_skill(name)
        for name in AGENTS:
            self.write("agents/%s.md" % name, "# %s\n" % name)
        self.write(levels.PAGE, PAGE)

    def write(self, rel, text):
        path = os.path.join(self.root, *rel.split("/"))
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w", encoding="utf-8", newline="\n") as handle:
            handle.write(text)

    def add_skill(self, name):
        self.write("skills/%s/SKILL.md" % name, "---\nname: %s\n---\n" % name)

    def page(self):
        with open(os.path.join(self.root, levels.PAGE), encoding="utf-8") as handle:
            return handle.read()

    def data(self):
        with open(os.path.join(self.root, levels.DATA), encoding="utf-8") as handle:
            return json.load(handle)

    def errors(self):
        return levels.check(self.root)[0]

    def write_data(self):
        code, out = run_cli("--root", self.root, "--write")
        self.assertEqual(code, 0, out)


class ParseAndWrite(SyntheticKit):
    def test_piece_tables_only_first_cell(self):
        parsed, errors = levels.parse_page(PAGE)
        self.assertEqual(errors, [])
        by = {e["level"]: e for e in parsed}
        self.assertEqual(by[1]["skills"], ["alpha", "beta"])
        self.assertEqual(by[1]["agents"], ["scout"])
        # 'delta' linked in a trigger cell of level 2 is not placed there
        self.assertEqual(by[2]["skills"], ["gamma"])
        self.assertEqual(by[3]["skills"], ["delta"])
        self.assertEqual(by[3]["agents"], [])
        self.assertEqual([e["name"] for e in parsed], ["Essential", "Governed", "Scale"])

    def test_write_then_check_is_clean(self):
        self.write_data()
        data = self.data()
        self.assertEqual([l["skills"] for l in data["levels"]], [["alpha", "beta"], ["gamma"], ["delta"]])
        self.assertEqual(data["source"], levels.PAGE)
        self.assertEqual(self.errors(), [])
        code, out = run_cli("--root", self.root, "--check")
        self.assertEqual(code, 0, out)

    def test_written_file_is_lf_and_ascii(self):
        self.write_data()
        with open(os.path.join(self.root, levels.DATA), "rb") as handle:
            raw = handle.read()
        self.assertNotIn(b"\r\n", raw)
        raw.decode("ascii")


class Tracks(SyntheticKit):
    def setUp(self):
        super().setUp()
        self.write(levels.PAGE, track_page())

    def test_parse_track_cells(self):
        self.assertEqual(levels.parse_track("both"), ("both", None))
        self.assertEqual(levels.parse_track(" both (team) "), ("both", None))
        self.assertEqual(levels.parse_track("legacy, mostly"), ("both", None))
        self.assertEqual(levels.parse_track("legacy"), ("legacy", None))
        self.assertEqual(levels.parse_track("greenfield (both from level 2)"), ("greenfield", 2))
        self.assertEqual(levels.parse_track("bothways"), (None, None))
        self.assertEqual(levels.parse_track("legacy first"), (None, None))
        self.assertEqual(levels.parse_track(""), (None, None))

    def test_tracks_parsed_and_written(self):
        parsed, errors = levels.parse_page(self.page())
        self.assertEqual(errors, [])
        by = {e["level"]: e for e in parsed}
        self.assertEqual(by[1]["tracks"], {"beta": {"track": "greenfield", "both_from_level": 2},
                                           "scout": {"track": "legacy"}})
        self.assertEqual(by[2]["tracks"], {"gamma": {"track": "legacy"}})
        self.assertEqual(by[3]["tracks"], {})
        self.write_data()
        self.assertEqual([l["tracks"] for l in self.data()["levels"]],
                         [by[1]["tracks"], by[2]["tracks"], {}])
        self.assertEqual(self.errors(), [])
        code, out = run_cli("--root", self.root)
        self.assertIn("one track: beta: greenfield (both from level 2), scout: legacy", out)

    def test_the_base_page_gives_tracks_too(self):
        self.write(levels.PAGE, PAGE)
        parsed, errors = levels.parse_page(PAGE)
        self.assertEqual(errors, [])
        self.assertEqual(parsed[0]["tracks"], {"scout": {"track": "legacy"}})

    def test_track_changed_without_write(self):
        self.write_data()
        self.write(levels.PAGE, self.page().replace(
            "| [`gamma`](../skills/gamma/SKILL.md) | skill | situational - with [`delta`](../skills/delta/SKILL.md) | legacy |",
            "| [`gamma`](../skills/gamma/SKILL.md) | skill | situational - with [`delta`](../skills/delta/SKILL.md) | greenfield |"))
        errors = self.errors()
        self.assertTrue(any("stale" in e and "'gamma'" in e and "track greenfield, the data file legacy" in e
                            for e in errors), errors)
        code, out = run_cli("--root", self.root, "--check")
        self.assertEqual(code, 1, out)

    def test_track_data_edited_by_hand(self):
        self.write_data()
        data = self.data()
        del data["levels"][0]["tracks"]["beta"]
        self.write(levels.DATA, json.dumps(data, indent=2) + "\n")
        errors = self.errors()
        self.assertTrue(any("'beta' (Level 1) the track greenfield (both from level 2), the data file both" in e
                            for e in errors), errors)

    def test_unknown_track_value(self):
        self.write(levels.PAGE, self.page().replace(
            "| [`delta`](../skills/delta/SKILL.md) | skill | core | both |",
            "| [`delta`](../skills/delta/SKILL.md) | skill | core | everyone |"))
        errors = self.errors()
        self.assertTrue(any("unknown Track 'everyone'" in e and "Level 3" in e for e in errors), errors)
        code, out = run_cli("--root", self.root, "--write")
        self.assertEqual(code, 1, out)

    def test_both_from_must_be_a_later_level(self):
        self.write(levels.PAGE, self.page().replace("greenfield (both from level 2)",
                                                    "greenfield (both from level 1)"))
        errors = self.errors()
        self.assertTrue(any("must be above 1" in e for e in errors), errors)

    def test_piece_table_without_track_column(self):
        page = self.page().replace(
            "| Piece | Kind | Core / situational - trigger | Track |\n|---|---|---|---|\n"
            "| [`delta`](../skills/delta/SKILL.md) | skill | core | both |",
            "| Piece | Kind | Core / situational - trigger |\n|---|---|---|\n"
            "| [`delta`](../skills/delta/SKILL.md) | skill | core |")
        self.assertNotEqual(page, self.page())
        self.write(levels.PAGE, page)
        errors = self.errors()
        self.assertTrue(any("piece table of Level 3 has no Track column" in e for e in errors), errors)


class Drift(SyntheticKit):
    def setUp(self):
        super().setUp()
        self.write_data()

    def test_missing_data_file(self):
        os.remove(os.path.join(self.root, levels.DATA))
        self.assertTrue(any("missing runtime/levels.json" in e for e in self.errors()))

    def test_page_moves_a_skill_without_write(self):
        page = self.page().replace(
            "| [`gamma`](../skills/gamma/SKILL.md) | skill | situational - with [`delta`](../skills/delta/SKILL.md) | both |\n",
            "")
        page = page.replace("[`beta`](../skills/beta/SKILL.md) | skills",
                            "[`beta`](../skills/beta/SKILL.md), [`gamma`](../skills/gamma/SKILL.md) | skills")
        page = page.replace("4 skills (2 / 1 / 1)", "4 skills (3 / 0 / 1)")
        self.write(levels.PAGE, page)
        errors = self.errors()
        self.assertTrue(any("stale" in e and "'gamma'" in e for e in errors), errors)
        self.assertTrue(any("piece table of Level 2 places no skill" in e for e in errors), errors)
        code, out = run_cli("--root", self.root, "--check")
        self.assertEqual(code, 1, out)

    def test_data_edited_by_hand(self):
        data = self.data()
        data["levels"][0]["skills"].append("delta")
        self.write(levels.DATA, json.dumps(data, indent=2) + "\n")
        errors = self.errors()
        self.assertTrue(any("it puts skill 'delta' in Level 1" in e for e in errors), errors)

    def test_unplaced_kit_skill(self):
        self.add_skill("epsilon")
        errors = self.errors()
        self.assertTrue(any("skill 'epsilon' is placed in no level" in e for e in errors), errors)

    def test_unplaced_kit_agent(self):
        self.write("agents/ghost.md", "# ghost\n")
        errors = self.errors()
        self.assertTrue(any("agent 'ghost' is placed in no level" in e for e in errors), errors)

    def test_placed_but_missing(self):
        shutil.rmtree(os.path.join(self.root, "skills", "delta"))
        errors = self.errors()
        self.assertTrue(any("places skill 'delta', which the kit does not have" in e for e in errors), errors)

    def test_placed_twice(self):
        page = self.page().replace("| [`delta`](../skills/delta/SKILL.md) | skill | core | both |",
                                   "| [`delta`](../skills/delta/SKILL.md), [`beta`](../skills/beta/SKILL.md) | skill | core | both |")
        self.write(levels.PAGE, page)
        errors = self.errors()
        self.assertTrue(any("'beta' is placed in Level 1 and Level 3" in e for e in errors), errors)

    def test_count_line_disagrees(self):
        self.write(levels.PAGE, self.page().replace("2 agents (1 / 1 / 0)", "2 agents (2 / 0 / 0)"))
        errors = self.errors()
        self.assertTrue(any("Count line says 2 agents (2 / 0 / 0)" in e for e in errors), errors)

    def test_missing_level_section(self):
        self.write(levels.PAGE, self.page().replace("## Level 3 - Scale", "## Level three"))
        errors = self.errors()
        self.assertTrue(any("found levels [1, 2]" in e for e in errors), errors)

    def test_write_refuses_an_inconsistent_page(self):
        self.add_skill("epsilon")
        before = self.data()
        code, out = run_cli("--root", self.root, "--write")
        self.assertEqual(code, 1, out)
        self.assertIn("not written", out)
        self.assertEqual(self.data(), before)


class RealPage(unittest.TestCase):
    def parsed(self):
        path = os.path.join(KIT, levels.PAGE)
        if not os.path.isfile(path):
            self.skipTest("no %s in this kit" % levels.PAGE)
        parsed, errors = levels.parse_page(levels.read_text(path))
        self.assertEqual(errors, [])
        return parsed

    def test_real_page_has_three_levels(self):
        parsed = self.parsed()
        self.assertEqual([e["level"] for e in parsed], [1, 2, 3])
        self.assertTrue(all(e["skills"] for e in parsed))

    def test_real_page_entry_pieces_by_track(self):
        tracks = {}
        for entry in self.parsed():
            tracks.update(entry["tracks"])
        if "assess-legacy-repo" not in tracks or "frame-greenfield" not in tracks:
            self.skipTest("this kit's page has no track entry pieces")
        self.assertEqual(tracks["assess-legacy-repo"]["track"], "legacy")
        self.assertEqual(tracks["frame-greenfield"]["track"], "greenfield")


if __name__ == "__main__":
    unittest.main()
