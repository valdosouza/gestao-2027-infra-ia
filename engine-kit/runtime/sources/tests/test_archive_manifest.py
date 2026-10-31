"""Tests of archive_manifest.py on a fictional archive (a regulator's e-receipt specification).

Run: python -m unittest discover -s runtime/sources/tests
"""

import contextlib
import csv
import hashlib
import io
import os
import shutil
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
TOOL = os.path.dirname(HERE)
if TOOL not in sys.path:
    sys.path.insert(0, TOOL)
import archive_manifest as am  # noqa: E402


def run(*argv):
    with contextlib.redirect_stdout(io.StringIO()) as out:
        code = am.main(list(argv))
    return code, out.getvalue()


class ArchiveManifestTest(unittest.TestCase):

    def setUp(self):
        self.root = tempfile.mkdtemp(prefix="archive-")
        self.write("spec/tn-2026-03-v1-20.pdf", b"%PDF-1.7 fictional technical note")
        self.write("spec/tn-2026-03-v1-20.txt", b"R-12 production from 2027-03-01\n")
        self.write("notices/portal-notice-2026-11-02.txt", b"transcribed notice\n")
        self.write("bundles/schemas-v1-04.zip", b"PK fictional bundle")
        self.write("bundles/schemas-v1-04/receipt.xsd", b"<xs:schema/>")
        self.write("README.md", b"# Archive\n")
        self.manifest = os.path.join(self.root, "MANIFEST.csv")

    def tearDown(self):
        shutil.rmtree(self.root)

    def write(self, relpath, data):
        full = os.path.join(self.root, relpath)
        os.makedirs(os.path.dirname(full), exist_ok=True)
        with open(full, "wb") as handle:
            handle.write(data)

    def fill(self, relpath, **values):
        rows = am.load_manifest(self.manifest)
        rows[relpath].update(values)
        am.write_manifest(self.manifest, rows)

    def fill_all(self):
        self.fill("spec/tn-2026-03-v1-20.pdf", origin="https://regulator.example/tn", retrieved="2026-11-02")
        self.fill("spec/tn-2026-03-v1-20.txt", method="pdf-to-text, layout mode, UTF-8")
        self.fill("notices/portal-notice-2026-11-02.txt", origin="https://regulator.example/notices/3",
                  retrieved="2026-11-02")
        self.fill("bundles/schemas-v1-04.zip", origin="https://regulator.example/schemas", retrieved="2026-11-02")

    def test_record_then_verify_clean(self):
        code, _ = run("record", self.root, "--exclude", "bundles/*/*", "--date", "2026-11-02")
        self.assertEqual(code, 0)
        rows = am.load_manifest(self.manifest)
        self.assertEqual(sorted(rows), ["bundles/schemas-v1-04.zip", "notices/portal-notice-2026-11-02.txt",
                                        "spec/tn-2026-03-v1-20.pdf", "spec/tn-2026-03-v1-20.txt"])
        self.assertEqual(rows["spec/tn-2026-03-v1-20.pdf"]["text_copy"], "spec/tn-2026-03-v1-20.txt")
        self.assertEqual(rows["spec/tn-2026-03-v1-20.txt"]["kind"], "text")
        self.assertEqual(rows["notices/portal-notice-2026-11-02.txt"]["kind"], "transcription")
        code, out = run("verify", self.root, "--exclude", "bundles/*/*")
        self.assertEqual(code, 1)
        self.assertEqual(out.count("incomplete"), 4)
        self.fill_all()
        code, out = run("verify", self.root, "--exclude", "bundles/*/*")
        self.assertEqual(code, 0, out)

    def test_changed_file_is_reported_never_rehashed(self):
        run("record", self.root, "--exclude", "bundles/*/*")
        self.fill_all()
        before = am.load_manifest(self.manifest)["spec/tn-2026-03-v1-20.txt"]["sha256"]
        self.write("spec/tn-2026-03-v1-20.txt", b"regenerated in another mode\n")
        code, out = run("verify", self.root, "--exclude", "bundles/*/*")
        self.assertEqual(code, 1)
        self.assertIn("changed", out)
        self.assertIn("line citations", out)
        code, _ = run("record", self.root, "--exclude", "bundles/*/*")
        self.assertEqual(code, 1)
        self.assertEqual(am.load_manifest(self.manifest)["spec/tn-2026-03-v1-20.txt"]["sha256"], before)

    def test_line_ending_conversion_is_named(self):
        run("record", self.root, "--exclude", "bundles/*/*")
        self.fill_all()
        self.write("spec/tn-2026-03-v1-20.txt", b"R-12 production from 2027-03-01\r\n")
        code, out = run("verify", self.root, "--exclude", "bundles/*/*")
        self.assertEqual(code, 1)
        self.assertIn("line endings only", out)

    def test_missing_text_copy_unrecorded_and_missing(self):
        run("record", self.root, "--exclude", "bundles/*/*")
        self.fill_all()
        os.remove(os.path.join(self.root, "spec/tn-2026-03-v1-20.txt"))
        self.write("spec/tn-2026-04-v1-00.pdf", b"%PDF-1.7 a new note, not recorded")
        code, out = run("verify", self.root, "--exclude", "bundles/*/*")
        self.assertEqual(code, 1)
        self.assertIn("no-text-copy", out)
        self.assertIn("missing", out)
        self.assertIn("unrecorded", out)

    def test_publisher_hash(self):
        run("record", self.root, "--exclude", "bundles/*/*")
        self.fill_all()
        good = hashlib.sha512(b"PK fictional bundle").hexdigest()
        self.fill("bundles/schemas-v1-04.zip", publisher_hash="sha512:" + good)
        self.assertEqual(run("verify", self.root, "--exclude", "bundles/*/*")[0], 0)
        self.fill("bundles/schemas-v1-04.zip", publisher_hash="sha512:" + "0" * 128)
        code, out = run("verify", self.root, "--exclude", "bundles/*/*")
        self.assertEqual(code, 1)
        self.assertIn("publisher-mismatch", out)

    def test_manifest_is_lf_csv_with_header(self):
        run("record", self.root, "--exclude", "bundles/*/*")
        with open(self.manifest, "rb") as handle:
            data = handle.read()
        self.assertNotIn(b"\r\n", data)
        with open(self.manifest, "r", encoding="utf-8", newline="") as handle:
            self.assertEqual(next(csv.reader(handle)), am.COLUMNS)

    def test_usage_error(self):
        with contextlib.redirect_stderr(io.StringIO()):
            self.assertEqual(run("verify", os.path.join(self.root, "nope"))[0], 2)
            self.assertEqual(run("audit", self.root)[0], 2)


if __name__ == "__main__":
    unittest.main()
