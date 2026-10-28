"""The same doors on svn: a throwaway file:// repository with a developer and a watcher
checkout - revision paths relative to the line, the clean-copy rule (mixed revisions
included), red since r<N>, the stale check at HEAD, and the watcher's claim committed into
a claims folder. Skipped, with the reason, when svn and svnadmin are not on PATH."""

import json
import os
import unittest

from helpers import Scratch, agent_cfg, cli, config, have, read, suite_spec, svn, svn_commit, svn_repo, write
from vcsops import WorkingCopy

LATER = '2026-12-31T10:00:00+00:00'
SKIP_SVN = 'svn and svnadmin are not on PATH: the svn flow is not exercised on this machine'


@unittest.skipUnless(have('svn', 'svnadmin', 'svnversion'), SKIP_SVN)
class SvnFlow(Scratch):
    def setUp(self):
        super().setUp()
        self.url = svn_repo(self.path('repo'))
        svn('mkdir', '--parents', '-q', '-m', 'layout', self.url + '/trunk', '--username', 'P')
        self.dev = self.path('dev')
        svn('checkout', '-q', self.url + '/trunk', self.dev)
        self.start = svn_commit(self.dev, {'src/calc.py': 'x = 1\n', 'tests/marker.txt': 'suite\n'}, 'start', 'P')
        self.wc = self.path('wc')
        svn('checkout', '-q', self.url + '/trunk', self.wc)
        os.makedirs(self.path('out'))
        self.results = self.path('out', 'r.xml')
        self.spec({'calc.CalcTest.adds': 'pass'})
        self.cfg = config(self.path('testing.json'), 'wc', 'state', self.path('spec.json'), self.results,
                          {'marker': 'tests/marker.txt'}, me='W', machine='box-w',
                          claim={'svn': {'url': '^/claims/demo'}}, watch={'drafting': True},
                          agent=agent_cfg('good'))

    def spec(self, tests):
        suite_spec(self.path('spec.json'), tests, self.results)

    def run_cli(self, *argv):
        return cli(['--config', self.cfg] + list(argv))

    def test_revision_paths_are_relative_to_the_line(self):
        rev = svn_commit(self.dev, {'src/calc.py': 'x = 2\n', 'tests/test_calc.py': 't\n'}, 'fix and test', 'P')
        info = WorkingCopy(self.wc).revision_info(rev)
        self.assertEqual((info['label'], info['author'], info['paths']),
                         ('r%d' % rev, 'P', ['src/calc.py', 'tests/test_calc.py']))
        self.assertIn('r%d: mixed' % rev, self.run_cli('classify', '--rev', 'r%d' % rev)[1])

    def test_mixed_revisions_are_refused_and_red_since_names_the_revision(self):
        self.assertEqual(self.run_cli('baseline', 'record')[0], 0)
        rev = svn_commit(self.wc, {'src/calc.py': 'x = 3\n'}, 'break', 'W')  # svn_commit updates afterwards
        write(os.path.join(self.wc, 'src', 'calc.py'), 'x = 4\n')
        svn('commit', '-q', '-m', 'again', '--username', 'W', self.wc)       # now a mixed-revision tree
        code, out = self.run_cli('baseline', 'record')
        self.assertEqual(code, 1)
        self.assertIn('mixed-revision', out)
        svn('update', '-q', self.wc)
        self.spec({'calc.CalcTest.adds': 'fail'})
        self.assertEqual(self.run_cli('baseline', 'record')[0], 0)
        out = self.run_cli('baseline', 'show')[1]
        self.assertIn('failing: calc.CalcTest.adds (red in the baseline run at r%d, manual' % (rev + 1), out)
        self.assertIn('not red at r%d' % self.start, out)

    def test_red_since_after_a_direct_predecessor(self):
        self.assertEqual(self.run_cli('baseline', 'record', '--source', 'watcher')[0], 0)
        rev = svn_commit(self.dev, {'src/calc.py': 'x = 5\n'}, 'break', 'Q')
        svn('update', '-q', self.wc)
        self.spec({'calc.CalcTest.adds': 'fail'})
        self.assertEqual(self.run_cli('baseline', 'record', '--source', 'watcher')[0], 0)
        self.assertIn('pre-existing: calc.CalcTest.adds (red since r%d, Q)' % rev, self.run_cli('run')[1])

    def test_the_stale_check_asks_the_server(self):
        svn_commit(self.dev, {'suite2/run.txt': 'x\n'}, 'a second suite', 'P')
        stale = config(self.path('stale.json'), 'wc', 'state', self.path('spec.json'), self.results,
                       {'marker': 'suite2/run.txt'})
        code, out = cli(['--config', stale, 'run'])
        self.assertEqual(code, 76, out)
        none = config(self.path('none.json'), 'wc', 'state', self.path('spec.json'), self.results,
                      {'marker': 'nowhere/run.txt'})
        self.assertEqual(cli(['--config', none, 'run'])[0], 77)

    def test_the_watcher_claims_into_the_claims_folder(self):
        rev = svn_commit(self.dev, {'src/calc.py': 'x = 6\n'}, 'fix the sum', 'P')
        svn('update', '-q', self.wc)
        code, out = self.run_cli('watch', '--rev', 'r%d' % rev, '--now', LATER, '--claim')
        self.assertEqual(code, 0, out)
        self.assertIn('claim won', out)
        self.assertIn('proposal staged in', out)
        claim = svn('cat', '%s/claims/demo/r%d/CLAIM.md' % (self.url, rev))
        self.assertIn('- claimer: W', claim)
        staged = os.path.join(self.path('state', 'claims-wc'), 'r%d' % rev)
        self.assertIn('REPORT.md', os.listdir(staged))
        self.assertIn('svn commit -m "proposal r%d"' % rev, out)
        self.assertIn('# r%d by someone' % rev, read(os.path.join(staged, 'REPORT.md')))
        code, out = self.run_cli('claims')
        self.assertIn('r%d claimed by W (box-w) for P' % rev, out)
        with open(self.path('state', 'state.json'), encoding='utf-8') as fh:
            self.assertEqual(json.load(fh)['queue'], {})


if __name__ == '__main__':
    unittest.main()
