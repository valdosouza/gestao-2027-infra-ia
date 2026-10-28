"""ledger_gen.py and the documents at the root of an area: the analysis document of a legacy
assessment and its hypothesis register sit at <project>/SUBJECT/<AREA>/, beside the area's
INDEX.md, and the ledger lists them - the register by its fixed name, the analysis document
by a name containing "analysis" or by the register's analysis_document key (its name is in
the case's language). Everything happens under one temporary folder (set TMP / TMPDIR to
choose where).

  cd runtime/registry
  python -m unittest discover -s tests
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
REGISTRY = os.path.dirname(HERE)
if REGISTRY not in sys.path:
    sys.path.insert(0, REGISTRY)

import ledger_gen as lg  # noqa: E402

PROJECTS = """---
registry: projects
root_globs:
  - "projects/*"
---
# Projects Registry - demo

**Scope**: case

| Key | Type | Name | Code tree | Path | Status |
|---|---|---|---|---|---|
| `WS` | workspace | the base | - | `.` | active |
| `ORD` | tenant | orders | - | `projects/orders` | active |
"""

REGISTER = """---
project: ORD
subject: SHIPPING
analysis_document: %s
last_updated: 2026-10-20
---
# Hypotheses - partial shipments

**Scope**: case
"""

ANALYSIS = """---
project: ORD
subject: SHIPPING
version: "1.0"
last_updated: 2026-10-19
---
# Analysis of the legacy - partial shipments

**Scope**: case
"""

DOC = '# %s\n\n**Scope**: case\n'


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(body)


class AreaRoot(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-ledger-')
        self.kb = os.path.join(self.tmp, 'kb')
        self.project = os.path.join(self.kb, 'projects', 'orders')
        self.area = os.path.join(self.project, 'SUBJECT', 'SHIPPING')
        write(os.path.join(self.kb, '_REGISTRY', 'PROJECTS.md'), PROJECTS)
        write(os.path.join(self.area, 'INDEX.md'), DOC % 'SHIPPING - Subject Index')
        write(os.path.join(self.area, 'MEMORY', '2026-10-18-reading.md'), DOC % 'Session log')
        write(os.path.join(self.area, 'notes.md'), DOC % 'Loose notes')  # no kind: not ledgered

    def tearDown(self):
        shutil.rmtree(self.tmp, ignore_errors=True)

    def kinds_of(self, kinds=None):
        rows = lg.build_rows(self.project, 'SUBJECT', kinds or lg.load_kinds(''))
        return {r[6]: (r[3], r[0]) for r in rows}

    def test_the_analysis_document_named_by_the_register_and_the_register_are_ledgered(self):
        write(os.path.join(self.area, 'ANALISE.md'), ANALYSIS)  # a name in the case's language
        write(os.path.join(self.area, 'HYPOTHESES.md'), REGISTER % 'ANALISE.md')
        found = self.kinds_of()
        self.assertEqual(found['SUBJECT/SHIPPING/ANALISE'], ('analysis', '2026-10-19'))
        self.assertEqual(found['SUBJECT/SHIPPING/HYPOTHESES'], ('hypotheses', '2026-10-20'))
        self.assertEqual(found['SUBJECT/SHIPPING/MEMORY/2026-10-18-reading'][0], 'log')
        self.assertNotIn('SUBJECT/SHIPPING/INDEX', found)
        self.assertNotIn('SUBJECT/SHIPPING/notes', found)

    def test_a_markdown_link_and_a_name_with_analysis_both_work(self):
        write(os.path.join(self.area, 'shipping-analysis.md'), ANALYSIS)  # found by its name
        write(os.path.join(self.area, 'ESTUDO.md'), ANALYSIS)
        write(os.path.join(self.area, 'HYPOTHESES.md'), REGISTER % '"[ESTUDO.md](./ESTUDO.md#history)"')
        found = self.kinds_of()
        self.assertEqual(found['SUBJECT/SHIPPING/shipping-analysis'][0], 'analysis')
        self.assertEqual(found['SUBJECT/SHIPPING/ESTUDO'][0], 'analysis')
        write(os.path.join(self.area, 'HYPOTHESES.md'), REGISTER % '../OTHER/ESTUDO.md')  # not this area's root
        self.assertNotIn('SUBJECT/SHIPPING/ESTUDO', self.kinds_of())

    def test_a_case_names_its_own_area_files_and_links(self):
        write(os.path.join(self.area, 'notes.md'), DOC % 'Loose notes')
        write(os.path.join(self.area, 'ANALISE.md'), ANALYSIS)
        write(os.path.join(self.area, 'HYPOTHESES.md'), REGISTER % 'ANALISE.md')
        kinds_file = os.path.join(self.tmp, 'kinds.json')
        write(kinds_file, json.dumps({'area_files': [['notes.md', 'area-notes']], 'area_links': {}}))
        found = self.kinds_of(lg.load_kinds(kinds_file))
        self.assertEqual(found['SUBJECT/SHIPPING/notes'][0], 'area-notes')
        self.assertNotIn('SUBJECT/SHIPPING/ANALISE', found)
        self.assertNotIn('SUBJECT/SHIPPING/HYPOTHESES', found)
        for bad in ({'area_links': ['analysis_document']}, {'area_files': [['*.md']]}):
            write(kinds_file, json.dumps(bad))
            with self.assertRaises(ValueError):
                lg.load_kinds(kinds_file)

    def test_the_generated_ledger_lists_the_assessment(self):
        write(os.path.join(self.area, 'ANALISE.md'), ANALYSIS)
        write(os.path.join(self.area, 'HYPOTHESES.md'), REGISTER % 'ANALISE.md')
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
            code = lg.main(['--root', self.kb])
        self.assertEqual(code, 0, buf.getvalue())
        with open(os.path.join(self.project, '_REGISTRY', 'LEDGER.md'), encoding='utf-8') as fh:
            ledger = fh.read()
        self.assertIn('| 2026-10-19 | SHIPPING | analysis |  |  | [[SUBJECT/SHIPPING/ANALISE]] | '
                      'Analysis of the legacy - partial shipments |', ledger)
        self.assertIn('| hypotheses |', ledger)
        self.assertIn('3 entries', buf.getvalue())


if __name__ == '__main__':
    unittest.main()
