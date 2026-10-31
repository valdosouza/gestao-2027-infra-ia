"""sync-skills.ps1 -Level and -Track on Windows: the kit's real skills/ (read only, through
junctions) plus a scratch case layer, linked into a scratch target - never a real discovery
folder. Level 1, then 2, then back to 1; an override by name; -Borrow; -Track for each
track, moving between tracks and levels, a piece that serves both tracks from a later
level, borrowing the other track's piece, an override keeping its track; a hand-made folder
and a link outside the sources left alone; -WhatIf changes nothing; bad arguments; a
missing levels.json, and one without track data. Skipped where Windows PowerShell or NTFS
junctions are not available.

Run: python -m unittest discover -s runtime/tests-levels -v
"""

import json
import os
import shutil
import stat
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
RUNTIME = os.path.dirname(HERE)
KIT = os.path.dirname(RUNTIME)
SYNC = os.path.join(RUNTIME, "sync-skills.ps1")
KIT_SKILLS = os.path.join(KIT, "skills")
POWERSHELL = shutil.which("powershell.exe") or shutil.which("powershell")
SKIP = "needs Windows PowerShell and NTFS junctions"


def is_junction(path):
    try:
        st = os.lstat(path)
    except OSError:
        return False
    attrs = getattr(st, "st_file_attributes", 0)
    return bool(attrs & getattr(stat, "FILE_ATTRIBUTE_REPARSE_POINT", 0x400))


def junctions(folder):
    return {name for name in os.listdir(folder) if is_junction(os.path.join(folder, name))}


def remove_tree(path):
    """Remove the scratch tree; junctions first, as pointers, so nothing behind them is touched."""
    for dirpath, dirnames, _ in os.walk(path, topdown=True):
        for name in list(dirnames):
            full = os.path.join(dirpath, name)
            if is_junction(full):
                os.rmdir(full)
                dirnames.remove(name)
    shutil.rmtree(path, ignore_errors=True)


def load_levels():
    with open(os.path.join(RUNTIME, "levels.json"), encoding="utf-8") as handle:
        return json.load(handle)


def level_skills(level):
    return {s for entry in load_levels()["levels"] if entry["level"] <= level for s in entry["skills"]}


def data_track(data, name):
    for entry in data["levels"]:
        info = entry.get("tracks", {}).get(name)
        if name in entry["skills"] and info:
            return info
    return None


def on_track(name, level, track):
    """Rule 5 of the page, written again here: a skill the data gives one track serves only
    that track, or both tracks from its both_from_level."""
    info = data_track(load_levels(), name)
    if track is None or info is None:
        return True
    both_from = info.get("both_from_level")
    return info["track"] == track or (both_from is not None and level >= both_from)


def kit_skill_names():
    return {n for n in os.listdir(KIT_SKILLS) if os.path.isfile(os.path.join(KIT_SKILLS, n, "SKILL.md"))}


@unittest.skipUnless(sys.platform == "win32" and POWERSHELL, SKIP)
class SyncLevels(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix="sync-levels-")
        self.addCleanup(remove_tree, self.tmp)
        self.case = os.path.join(self.tmp, "case", "skills")
        self.target = os.path.join(self.tmp, "target", "skills")
        for name, text in (("decision-rounds", "case override, level 1"),
                           ("change-gate", "case override, level 2"),
                           ("acme-orders", "case-own skill")):
            os.makedirs(os.path.join(self.case, name))
            with open(os.path.join(self.case, name, "SKILL.md"), "w", encoding="ascii") as handle:
                handle.write("---\nname: %s\ndescription: Use when - %s\n---\n" % (name, text))
        os.makedirs(os.path.join(self.target, "my-notes"))
        with open(os.path.join(self.target, "my-notes", "notes.md"), "w", encoding="ascii") as handle:
            handle.write("hand-made\n")
        outside = os.path.join(self.tmp, "elsewhere", "outside-skill")
        os.makedirs(outside)
        self.outside = outside
        self.run_ps(["-Command", "New-Item -ItemType Junction -Path '%s' -Target '%s' | Out-Null"
                     % (os.path.join(self.target, "hand-link"), outside)], expect=0)
        self.kit_before = kit_skill_names()

    def run_ps(self, args, expect=None):
        p = subprocess.run([POWERSHELL, "-NoProfile", "-NonInteractive", "-ExecutionPolicy", "Bypass"] + args,
                           stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        out = p.stdout.decode("utf-8", "replace")
        if expect is not None:
            self.assertEqual(p.returncode, expect, out)
        return p.returncode, out

    def sync(self, *extra, script=SYNC, expect=0):
        return self.run_ps(["-File", script, "-Source", "%s;%s" % (KIT_SKILLS, self.case),
                            "-Target", self.target, "-BackupRoot", os.path.join(self.tmp, "backup")] + list(extra),
                           expect=expect)

    def expected(self, level, borrow=(), track=None):
        kit = kit_skill_names()
        placed = level_skills(3)
        keep = {n for n in kit if n not in placed or n in borrow
                or (n in level_skills(level) and on_track(n, level, track))}
        return keep | {"acme-orders", "hand-link"} | ({"change-gate"} if level >= 2 else set())

    def assert_untouched(self):
        self.assertTrue(os.path.isfile(os.path.join(self.target, "my-notes", "notes.md")))
        self.assertFalse(is_junction(os.path.join(self.target, "my-notes")))
        self.assertTrue(os.path.samefile(os.path.join(self.target, "hand-link"), self.outside))
        self.assertEqual(kit_skill_names(), self.kit_before)
        for name in ("decision-rounds", "change-gate", "acme-orders"):
            self.assertTrue(os.path.isfile(os.path.join(self.case, name, "SKILL.md")))
        self.assertFalse(os.path.exists(os.path.join(self.tmp, "backup")))

    def assert_override(self, name):
        self.assertTrue(os.path.samefile(os.path.join(self.target, name), os.path.join(self.case, name)))

    def test_up_and_down(self):
        _, out = self.sync("-Level", "1", "-WhatIf")
        self.assertIn("WhatIf: nothing changed", out)
        self.assertEqual(junctions(self.target), {"hand-link"})

        self.sync("-Level", "1")
        self.assertEqual(junctions(self.target), self.expected(1))
        self.assert_override("decision-rounds")
        self.assert_untouched()

        self.sync("-Level", "2")
        self.assertEqual(junctions(self.target), self.expected(2))
        self.assert_override("change-gate")
        self.assert_untouched()

        _, out = self.sync("-Level", "1")
        self.assertEqual(junctions(self.target), self.expected(1))
        self.assertIn("stale removed: %d" % len(self.expected(2) - self.expected(1)), out)
        self.assert_untouched()

    def test_borrow_then_drop(self):
        self.sync("-Level", "1", "-Borrow", "browser-verification")
        self.assertEqual(junctions(self.target), self.expected(1, borrow=("browser-verification",)))
        self.sync("-Level", "1")
        self.assertEqual(junctions(self.target), self.expected(1))
        self.assert_untouched()

    def test_every_skill_then_level_one(self):
        self.sync()
        self.assertEqual(len(junctions(self.target)), len(kit_skill_names() | {"acme-orders", "hand-link"}))
        self.sync("-Level", "1")
        self.assertEqual(junctions(self.target), self.expected(1))
        self.assert_untouched()

    def test_bad_arguments(self):
        self.sync("-Level", "4", expect=2)
        self.sync("-Borrow", "fences", expect=2)
        self.sync("-Level", "1", "-Track", "both", expect=2)
        self.sync("-Track", "legacy", expect=2)
        self.assertEqual(junctions(self.target), {"hand-link"})

    def test_track_leaves_out_the_other_entry(self):
        _, out = self.sync("-Level", "1")
        self.assertIn("no -Track", out)
        self.assertTrue({"assess-legacy-repo", "frame-greenfield"} <= junctions(self.target))

        _, out = self.sync("-Level", "1", "-Track", "legacy")
        self.assertNotIn("no -Track", out)
        linked = junctions(self.target)
        self.assertEqual(linked, self.expected(1, track="legacy"))
        self.assertIn("assess-legacy-repo", linked)
        self.assertNotIn("frame-greenfield", linked)
        self.assertIn("stale removed: %d" % len(self.expected(1) - self.expected(1, track="legacy")), out)
        self.assert_untouched()

        self.sync("-Level", "2", "-Track", "legacy")
        self.assertEqual(junctions(self.target), self.expected(2, track="legacy"))
        self.assert_override("change-gate")

        self.sync("-Level", "2", "-Track", "greenfield")
        linked = junctions(self.target)
        self.assertEqual(linked, self.expected(2, track="greenfield"))
        self.assertIn("frame-greenfield", linked)
        self.assertNotIn("assess-legacy-repo", linked)

        self.sync("-Level", "1", "-Track", "greenfield")
        self.assertEqual(junctions(self.target), self.expected(1, track="greenfield"))
        self.assert_untouched()

    def test_both_from_a_later_level(self):
        # The real page has no "(both from level N)" piece since EK#25, so the case is built
        # in a copy: a level-1 greenfield entry skill made "both from level 2".
        alone = os.path.join(self.tmp, "copy-both", "runtime")
        os.makedirs(alone)
        shutil.copy(SYNC, alone)
        data = load_levels()
        level1 = data["levels"][0]
        name, info = sorted((n, i) for n, i in level1.get("tracks", {}).items()
                            if n in level1["skills"] and i.get("track") == "greenfield")[0]
        info["both_from_level"] = 2
        with open(os.path.join(alone, "levels.json"), "w", encoding="utf-8") as handle:
            json.dump(data, handle, indent=2)
        script = os.path.join(alone, "sync-skills.ps1")
        self.sync("-Level", "1", "-Track", "legacy", script=script)
        self.assertNotIn(name, junctions(self.target))
        self.sync("-Level", "2", "-Track", "legacy", script=script)
        self.assertIn(name, junctions(self.target))
        self.assert_untouched()

    def test_track_borrow_and_override(self):
        _, out = self.sync("-Level", "1", "-Track", "legacy", "-Borrow", "frame-greenfield")
        self.assertIn("borrow frame-greenfield: track greenfield", out)
        self.assertEqual(junctions(self.target), self.expected(1, borrow=("frame-greenfield",), track="legacy"))
        os.makedirs(os.path.join(self.case, "frame-greenfield"))
        with open(os.path.join(self.case, "frame-greenfield", "SKILL.md"), "w", encoding="ascii") as handle:
            handle.write("---\nname: frame-greenfield\ndescription: Use when - case override\n---\n")
        self.sync("-Level", "1", "-Track", "legacy")
        self.assertNotIn("frame-greenfield", junctions(self.target))
        self.sync("-Level", "1", "-Track", "greenfield")
        self.assert_override("frame-greenfield")

    def test_track_without_track_data(self):
        alone = os.path.join(self.tmp, "copy", "runtime")
        os.makedirs(alone)
        shutil.copy(SYNC, alone)
        data = load_levels()
        for entry in data["levels"]:
            entry.pop("tracks", None)
        with open(os.path.join(alone, "levels.json"), "w", encoding="utf-8") as handle:
            json.dump(data, handle, indent=2)
        script = os.path.join(alone, "sync-skills.ps1")
        self.sync("-Level", "1", "-Track", "legacy", script=script, expect=1)
        self.assertEqual(junctions(self.target), {"hand-link"})
        self.sync("-Level", "1", script=script)
        self.assertEqual(junctions(self.target), self.expected(1))

    def test_missing_levels_file(self):
        alone = os.path.join(self.tmp, "copy", "runtime")
        os.makedirs(alone)
        shutil.copy(SYNC, alone)
        self.sync("-Level", "1", script=os.path.join(alone, "sync-skills.ps1"), expect=1)
        self.assertEqual(junctions(self.target), {"hand-link"})


if __name__ == "__main__":
    unittest.main()
