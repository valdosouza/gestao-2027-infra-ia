"""decisions_index.py --check-touched and the "next free ids" item: the resume block (T30)
lists the ids a session will take next - ids that do not exist yet - so that item is never
read as a citation, while everything else still is, the rest of the item's own line included
(its sentence and a "Reserved:" sentence after it are the item; a code span or a table cell
that holds the label ends it). A copied tool summary ("decisions 17, 0 problems") is a count,
not a bare citation, while a bare "decision 17" still warns. The parsing rule is tested on its own;
the command runs once on a throwaway git knowledge base (skipped, with the reason, when git
is not on PATH). Everything happens under one temporary folder (set TMP / TMPDIR to choose
where).

  cd runtime/registry
  python -m unittest discover -s tests
"""

import contextlib
import io
import os
import shutil
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
REGISTRY = os.path.dirname(HERE)
if REGISTRY not in sys.path:
    sys.path.insert(0, REGISTRY)

import decisions_index as di  # noqa: E402

SKIP_GIT = 'git is not on PATH: the citation check is not exercised on a working copy here'

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

REGISTER = """# Decisions Register - %s

**Scope**: case

| # | Date | Decision | Why | Applies to |
|---|---|---|---|---|
| 1 | 2026-10-01 | **Partial shipments are allowed.** | the owner asked | - |
"""


def kept(text):
    """The non-blank text left for the citation check."""
    return [line for line in di.without_free_ids(text.split('\n')) if line.strip()]


class FreeIdsLines(unittest.TestCase):
    def test_a_line_that_starts_with_the_label_is_not_read(self):
        for line in ('**Next free ids**: WS#6 - A-WS2 - Q-WS3. Reserved: none.',
                     'Next free ids: WS#6.',
                     'next free ids - WS#6.',
                     '- next free ids: WS#6, ORD#2.',
                     '3. __Next Free IDs__: WS#6.',
                     '> **Next free ids**: WS#6.'):
            self.assertEqual(kept(line), [], line)

    def test_a_mid_line_label_drops_its_sentence(self):
        out = kept('> My answers: A-WS1 yes, cites WS#1. Next free ids: WS#6, ORD#2.')
        self.assertEqual(out, ['> My answers: A-WS1 yes, cites WS#1. '])

    def test_the_rest_of_the_line_after_the_item_is_read(self):
        for line in ('**Next free ids**: WS#6. The refund rule follows ORD#7.',
                     'Next free ids: WS#6, ORD#2! The refund rule follows ORD#7.',
                     '> Resume. Next free ids: WS#6. The refund rule follows ORD#7.'):
            out = '\n'.join(kept(line))
            self.assertIn('The refund rule follows ORD#7.', out, line)
            self.assertNotIn('WS#6', out, line)

    def test_a_reserved_sentence_belongs_to_the_item(self):
        out = '\n'.join(kept('**Next free ids**: WS#6. Reserved: WS#7-WS#9 for session B. Then ORD#7 applies.'))
        for gone in ('WS#6', 'WS#7', 'WS#9'):
            self.assertNotIn(gone, out)
        self.assertIn('Then ORD#7 applies.', out)
        self.assertEqual(kept('**Next free ids**: WS#6. **Reserved**: none.'), [])

    def test_a_code_span_or_a_table_cell_holding_the_label_ends_the_item(self):
        row = ('| 18 | a scratch test: `**Next free ids**: WS#10 \u00b7 ORD#15` passed, the same `WS#10` '
               'on another line failed | re-check |')
        out = '\n'.join(kept(row))
        self.assertNotIn('ORD#15', out)
        self.assertIn('passed, the same `WS#10` on another line failed', out)
        out = '\n'.join(kept('| step | Next free ids: WS#10 | ORD#7 is cited in the next cell |'))
        self.assertNotIn('WS#10', out)
        self.assertIn('ORD#7 is cited in the next cell', out)
        out = '\n'.join(kept('The block says `Next free ids: WS#10.` and the plan cites ORD#7.'))
        self.assertNotIn('WS#10', out)
        self.assertIn('and the plan cites ORD#7.', out)

    def test_a_decimal_point_in_an_id_does_not_end_the_item(self):
        self.assertEqual(kept('**Next free ids**: ACME-2.1#7, ACME-2.1#8 (wrapped\nhere). Reserved: none.'), [])

    def test_a_wrapped_item_is_dropped_to_the_end_of_its_sentence(self):
        text = ('**Next free ids**: WS#6 and ORD#2 (written in full, because\n'
                'a reserved range follows: after WS#7 skip to WS#9) -\n'
                'Q-WS3. Reserved: none.\n'
                'This line cites WS#1 and is read.')
        self.assertEqual(kept(text), ['This line cites WS#1 and is read.'])

    def test_a_blank_line_or_a_new_block_ends_the_item(self):
        for after in ('\n\nWS#5 is cited.', '\n- WS#5 is cited.', '\n**Requests out**: WS#5 is cited.',
                      '\n## WS#5 is cited', '\n| WS#5 | cited |'):
            text = '**Next free ids**: WS#6 (no sentence end here' + after
            self.assertEqual(len([l for l in kept(text) if 'WS#5' in l]), 1, after)
            self.assertFalse(any('WS#6' in l for l in kept(text)), after)

    def test_other_lines_are_read_as_they_are(self):
        for line in ('The free ids of the register are listed below: WS#6.',
                     'Take the next id after WS#6.',
                     'Decision WS#6 is next.'):
            self.assertEqual(kept(line), [line])


def have(*tools):
    return all(shutil.which(t) is not None for t in tools)


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(body)


@unittest.skipUnless(have('git'), SKIP_GIT)
class CheckTouched(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-decisions-')
        self.kb = os.path.join(self.tmp, 'kb')
        env = dict(os.environ, GIT_CONFIG_NOSYSTEM='1', GIT_TERMINAL_PROMPT='0')
        subprocess.run(['git', 'init', '-q', self.kb], env=env, check=True,
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        write(os.path.join(self.kb, '_REGISTRY', 'PROJECTS.md'), PROJECTS)
        write(os.path.join(self.kb, 'DECISIONS.md'), REGISTER % 'workspace')
        write(os.path.join(self.kb, 'projects', 'orders', '_REGISTRY', 'DECISIONS.md'), REGISTER % 'orders')

    def tearDown(self):
        shutil.rmtree(self.tmp, ignore_errors=True)

    def run_check(self):
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
            code = di.main(['--root', self.kb, '--check-touched'])
        return code, buf.getvalue()

    def test_a_resume_block_passes_and_a_real_missing_citation_still_fails(self):
        prompt = os.path.join(self.kb, 'prompts', 'prompt_orders.md')
        block = ('# Front ORD\n\n**Scope**: case\n\nApplies WS#1 and ORD#1.\n\n'
                 '**Next free ids**: WS#2 - ORD#2 - Q-ORD4 (ORD#3 reserved for\n'
                 'the sibling session). Reserved: ORD#3.\n'
                 '**Requests out**: none.\n\n'
                 '> "Resume front ORD from section 12. My answers: Q-ORD1 yes. Next free ids: WS#2, ORD#2."\n')
        write(prompt, block)
        code, out = self.run_check()
        self.assertEqual(code, 0, out)
        self.assertNotIn('FIX', out)
        write(prompt, block + '\nThe refund rule follows ORD#7.\n')
        code, out = self.run_check()
        self.assertEqual(code, 1, out)
        self.assertIn('ORD#7 is not in the register of ORD', out)
        self.assertNotIn('ORD#2', out)
        self.assertNotIn('WS#2', out)

    def test_a_wrong_citation_on_the_line_of_the_label_still_fails(self):
        prompt = os.path.join(self.kb, 'prompts', 'prompt_orders.md')
        write(prompt, '# Front ORD\n\n**Scope**: case\n\n'
                      '> "My answers: Q-ORD1 yes. Next free ids: WS#2, ORD#2." The refund rule follows ORD#8.\n\n'
                      '| Step | What |\n|---|---|\n'
                      '| 1 | `**Next free ids**: WS#3 - ORD#4` passed, the same `WS#5` on another line failed |\n')
        code, out = self.run_check()
        self.assertEqual(code, 1, out)
        self.assertIn('ORD#8 is not in the register of ORD', out)
        self.assertIn('WS#5 is not in the register of WS', out)
        for skipped in ('WS#2', 'ORD#2', 'WS#3', 'ORD#4'):
            self.assertNotIn(skipped + ' ', out)

    def test_a_copied_tool_summary_is_a_count_and_a_bare_decision_is_still_read(self):
        close = os.path.join(self.kb, 'projects', 'orders', 'TICKETS', 'ORD-W1', 'CLOSE.md')
        body = ('# Close - ORD-W1\n\n**Scope**: case\n\nThis wave keeps decision 1.\n\n'
                'Close script: registries ok; decisions 17, 0 problems; Decisions 3 in the index.\n')
        write(close, body)
        code, out = self.run_check()
        self.assertEqual(code, 0, out)
        self.assertNotIn('WARN', out)
        write(close, body + '\nThe refund follows decision 17.\n')
        code, out = self.run_check()
        self.assertEqual(code, 0, out)  # a bare citation warns, never fails
        self.assertIn('bare "decision 17" is not in the register of ORD', out)
        self.assertNotIn('"decision 3"', out)


if __name__ == '__main__':
    unittest.main()
