"""The configuration contract: the shipped example loads, parts inherit the suite-level
keys, a machine's local.json wins, the index of tested changes is read, reconcile flags."""

import argparse
import json
import os
import unittest

from helpers import KIT_TESTING, Scratch, write
import suite

EXAMPLE = os.path.join(KIT_TESTING, 'testing.example.json')


class Config(Scratch):
    def test_the_example_loads_with_two_parts(self):
        cfg = suite.load_config(EXAMPLE, state_dir=self.path('state'))
        s = cfg['suite']
        self.assertEqual([p['name'] for p in s['parts']], ['back', 'front'])
        self.assertEqual(cfg['line'], '2.1')
        self.assertEqual(cfg['gate']['mode'], 'warn', 'the example ships warn-only (EK#6)')
        self.assertFalse(cfg['watch']['drafting'], 'drafting is a per-machine choice')
        front = s['parts'][1]
        self.assertEqual((front['results']['format'], front['timeoutSec'], front['requires']), ('junit', 1800, ['node']))
        self.assertTrue(os.path.isabs(front['cwd']))

    def test_local_json_wins_per_machine(self):
        write(self.path('wc', 'x.txt'), 'x')
        path = self.path('testing.json')
        write(path, json.dumps({'workingCopy': 'wc', 'stateDir': 'state',
                                'suite': {'command': ['run'], 'results': {'path': 'r.xml'}}}))
        write(self.path('state', 'local.json'), json.dumps({'me': 'W', 'watch': {'drafting': True},
                                                            'agent': {'command': ['agent']}}))
        cfg = suite.load_config(path)
        self.assertEqual((cfg['me'], cfg['watch']['drafting'], cfg['line']), ('W', True, 'suite'))
        self.assertEqual(suite.load_config(path, me='Z')['me'], 'Z')

    def test_the_default_state_folder_is_per_suite_and_line(self):
        path = self.path('testing.json')
        write(path, json.dumps({'line': 'release/2.1', 'suite': {'name': 'orders', 'command': ['run'],
                                                                 'results': {'path': 'r.xml'}}}))
        cfg = suite.load_config(path)
        self.assertTrue(cfg['stateDir'].endswith(os.path.join('.engine-kit', 'testing', 'orders-release_2.1')))


class Index(Scratch):
    def test_rows_in_plain_text_and_markdown(self):
        write(self.path('INDEX.md'), '\n'.join([
            '# Index of tested changes',
            '| Revision | Tests | Status |',
            '|---|---|---|',
            '| r120, r121 | `tests/back/test_totals.py` | covered |',
            'r130 tests/back/test_tax.py  # promoted from a proposal',
            'abcdef1 tests/front/cart.test.js',
            '| r140 | - | rejected: needs a live printer |',
            '# a heading or comment line that names r99 is not a row',
            'r150 tests/back/test_fees.py  # r98 in a trailing comment is not a row',
        ]))
        rows = suite.read_index(self.path('INDEX.md'))
        self.assertTrue(suite.index_covers(rows, 'svn', 121))
        self.assertTrue(suite.index_covers(rows, 'svn', 140))
        self.assertFalse(suite.index_covers(rows, 'svn', 12))
        self.assertFalse(suite.index_covers(rows, 'svn', 99))
        self.assertFalse(suite.index_covers(rows, 'svn', 98))
        self.assertTrue(suite.index_covers(rows, 'git', 'abcdef1234567890'))
        files = set(f for _, fs in rows for f in fs)
        self.assertIn('tests/back/test_totals.py', files)
        self.assertIn('tests/front/cart.test.js', files)

    def test_no_index(self):
        self.assertEqual(suite.read_index(''), [])


class Reconcile(unittest.TestCase):
    def args(self, before=None, added=None, replaced=None):
        return argparse.Namespace(before=before, added=added, replaced=replaced)

    def test_total_and_per_part(self):
        self.assertIsNone(suite.expected_from(self.args()))
        self.assertEqual(suite.expected_from(self.args(['10'], ['2'])),
                         {'total': {'before': 10, 'added': 2, 'replaced': 0}, 'parts': {}})
        e = suite.expected_from(self.args(['back=10', 'front=4'], ['back=1']))
        self.assertEqual(e['parts'], {'back': {'before': 10, 'added': 1, 'replaced': 0},
                                      'front': {'before': 4, 'added': 0, 'replaced': 0}})
        with self.assertRaises(suite.ConfigError):
            suite.expected_from(self.args(['ten']))


if __name__ == '__main__':
    unittest.main()
