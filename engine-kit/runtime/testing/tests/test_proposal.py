"""The proposal folder: the report's shape, what may be in the folder, the brief, attempts."""

import json
import os
import unittest

from helpers import Scratch, read, write
import proposal as pr

LABELS = {'r120', '120'}


def report(label='r120', skip=(), empty=()):
    body = '# %s by P\none-line summary\n\n' % label
    for s in pr.REPORT_SECTIONS:
        if s in skip:
            continue
        body += '## %s\n%s\n\n' % (s, '' if s in empty else 'none, because nothing here')
    return body


class Report(unittest.TestCase):
    def test_a_complete_report_passes(self):
        self.assertEqual(pr.check_report(report(), LABELS), [])

    def test_the_title_names_the_revision(self):
        self.assertIn('names r121', pr.check_report(report('r121'), LABELS)[0])
        self.assertIn('no title', pr.check_report('no title\n', LABELS)[0])

    def test_every_section_is_present_and_not_empty(self):
        self.assertIn('lacks the section "Case rows"', pr.check_report(report(skip=['Case rows']), LABELS)[0])
        self.assertIn('"Draft" is empty', pr.check_report(report(empty=['Draft']), LABELS)[0])


class Folder(Scratch):
    def folder(self, files):
        d = self.path('proposal')
        os.makedirs(d, exist_ok=True)
        for name, body in files.items():
            write(os.path.join(d, name), body)
        return d

    def test_report_and_drafts_are_accepted(self):
        ok, files, reasons = pr.check_proposal(self.folder({'REPORT.md': report(), 'calc_test.draft.py': 'x = 1\n'}),
                                               LABELS)
        self.assertEqual((ok, files, reasons), (True, ['REPORT.md', 'calc_test.draft.py'], []))

    def test_a_missing_report_is_refused(self):
        ok, _, reasons = pr.check_proposal(self.folder({'calc_test.draft.py': 'x = 1\n'}), LABELS)
        self.assertFalse(ok)
        self.assertIn('REPORT.md missing', reasons)

    def test_stray_files_and_folders_are_refused(self):
        d = self.folder({'REPORT.md': report(), 'notes.txt': 'x', 'plan.draft.md': 'x'})
        os.makedirs(os.path.join(d, 'sub'))
        ok, _, reasons = pr.check_proposal(d, LABELS)
        self.assertFalse(ok)
        self.assertEqual(sorted(reasons), ['unexpected file notes.txt', 'unexpected file plan.draft.md',
                                           'unexpected folder sub'])

    def test_a_draft_that_reads_a_machine_path_is_refused(self):
        for body in ('open("C:\\\\work\\\\data.csv")', "path = '/home/dev/data.csv'", 'D:/suite/x'):
            d = self.folder({'REPORT.md': report(), 'calc_test.draft.py': body})
            ok, _, reasons = pr.check_proposal(d, LABELS)
            self.assertFalse(ok, body)
            self.assertIn('reads a machine path', reasons[0])

    def test_relative_paths_and_urls_are_fine(self):
        d = self.folder({'REPORT.md': report(), 'calc_test.draft.py': 'open("tests/data/x.csv")\n# http://a/b\n'})
        self.assertTrue(pr.check_proposal(d, LABELS)[0])

    def test_no_folder(self):
        self.assertFalse(pr.check_proposal(self.path('none'), LABELS)[0])

    def test_stage_copies_the_accepted_files(self):
        src = self.folder({'REPORT.md': report(), 'a.draft.py': 'x'})
        out = pr.stage(src, ['REPORT.md', 'a.draft.py'], self.path('claims', 'r120'))
        self.assertEqual(len(out), 2)
        self.assertEqual(read(os.path.join(self.path('claims', 'r120'), 'a.draft.py')), 'x')

    def test_an_earlier_attempt_is_moved_aside(self):
        d = self.folder({'REPORT.md': 'old', 'notes.txt': 'stray'})
        write(self.path('agent.log'), 'log')
        moved = pr.archive_attempt(d, self.path('attempts'), '20261021-090000', self.path('agent.log'))
        self.assertEqual(os.listdir(d), [])
        self.assertEqual(sorted(os.listdir(moved)), ['REPORT.md', 'agent.log', 'notes.txt'])
        self.assertEqual(pr.archive_attempt(d, self.path('attempts'), 'x'), '')


class Brief(Scratch):
    def test_render_drops_the_scope_line_and_fills_every_key(self):
        here = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        with open(os.path.join(here, 'watch.prompt.md'), encoding='utf-8') as fh:
            template = fh.read()
        keys = sorted(set(k for k in __import__('re').findall(r'\{([A-Z_]+)\}', template)))
        body = pr.render_prompt(template, dict((k, 'v') for k in keys))
        self.assertNotIn('**Scope**', body)
        self.assertNotRegex(body, r'\{[A-Z_]+\}')
        self.assertIn('LINE', keys)

    def test_count_diff_lines(self):
        diff = '--- a/x\n+++ b/x\n@@ -1 +1 @@\n-old\n+new\n context\n'
        self.assertEqual(pr.count_diff_lines(diff), 2)

    def test_agent_command_and_settings(self):
        cmd = pr.agent_command(['agent', '--out', '{proposal}', '--settings', '{agent_settings}', '{rev}'],
                               {'proposal': 'P', 'agent_settings': 'S', 'rev': 'r1'})
        self.assertEqual(cmd, ['agent', '--out', 'P', '--settings', 'S', 'r1'])
        path = pr.write_agent_settings(self.path('b', 'agent.settings.json'), self.path('proposal'))
        with open(path, encoding='utf-8') as fh:
            perms = json.load(fh)['permissions']
        self.assertEqual(perms['deny'], ['Bash'])
        scope = '//' + self.path('proposal').replace(os.sep, '/').lstrip('/') + '/**'
        self.assertIn('Write(%s)' % scope, perms['allow'])
        self.assertNotIn('Write', perms['allow'])


if __name__ == '__main__':
    unittest.main()
