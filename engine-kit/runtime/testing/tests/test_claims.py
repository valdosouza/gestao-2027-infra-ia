"""First claim wins, through a VCS conflict: git (a claims branch, a non-forced push) and
svn (a commit into a claims folder). Throwaway repositories under a scratch folder."""

import os
import shlex
import unittest
from datetime import datetime, timezone

from helpers import Scratch, file_url, git_server, have, sh, svn, svn_repo, write
import claims as cl

WHEN = datetime(2026, 10, 21, 9, 0, tzinfo=timezone.utc)
SKIP_SVN = 'svn and svnadmin are not on PATH: the svn claims are not exercised on this machine'


class Text(unittest.TestCase):
    def test_claim_text_round_trip(self):
        body = cl.claim_text('r120', 'W', 'P', 'box-1', WHEN)
        self.assertEqual(cl.parse_claim(body), {'revision': 'r120', 'claimer': 'W', 'machine': 'box-1', 'for': 'P',
                                                'claimed': '2026-10-21T09:00:00+00:00'})

    def test_keys(self):
        self.assertEqual((cl.claim_key('svn', 120), cl.claim_key('git', 'abc')), ('r120', 'abc'))


@unittest.skipUnless(have('git'), 'git is not on PATH')
class GitClaimsTest(Scratch):
    def setUp(self):
        super().setUp()
        self.server = git_server(self.path('server.git'))

    def watcher(self, name):
        return cl.GitClaims(self.path(name), self.server, 'test-claims')

    def body(self, who, machine):
        return cl.claim_text('abc', who, 'P', machine, WHEN)

    def test_first_claim_wins_and_the_second_loses(self):
        a, b = self.watcher('a'), self.watcher('b')
        self.assertEqual(a.claim('abc', self.body('A', 'm-a'), 'claim abc', 'A', 'm-a')[0], 'won')
        outcome, detail = b.claim('abc', self.body('B', 'm-b'), 'claim abc', 'B', 'm-b')
        self.assertEqual((outcome, detail), ('lost', 'claimed by A'))
        held = b.read('abc')
        self.assertEqual((held['claimer'], held['has_report']), ('A', False))

    def test_a_repeated_claim_by_the_same_machine_is_won_again(self):
        a = self.watcher('a')
        a.claim('abc', self.body('A', 'm-a'), 'claim abc', 'A', 'm-a')
        self.assertEqual(a.claim('abc', self.body('A', 'm-a'), 'claim abc', 'A', 'm-a'),
                         ('won', 'already claimed by this machine'))

    def test_a_race_is_decided_by_the_rejected_push(self):
        a, b = self.watcher('a'), self.watcher('b')
        seen = []

        def b_first():
            seen.append(b.claim('abc', self.body('B', 'm-b'), 'claim abc', 'B', 'm-b')[0])
        outcome, detail = a.claim('abc', self.body('A', 'm-a'), 'claim abc', 'A', 'm-a', before_push=b_first)
        self.assertEqual((seen, outcome, detail), (['won'], 'lost', 'claimed by B'))

    def test_claims_of_other_revisions_do_not_conflict(self):
        a, b = self.watcher('a'), self.watcher('b')

        def b_other():
            b.claim('def', cl.claim_text('def', 'B', 'P', 'm-b', WHEN), 'claim def', 'B', 'm-b')
        self.assertEqual(a.claim('abc', self.body('A', 'm-a'), 'claim abc', 'A', 'm-a', before_push=b_other)[0], 'won')
        self.assertEqual(sorted(c['key'] for c in a.list()), ['abc', 'def'])

    def test_no_remote_is_failed_not_lost(self):
        bad = cl.GitClaims(self.path('c'), self.path('no-such-server.git'))
        self.assertEqual(bad.claim('abc', self.body('C', 'm-c'), 'claim abc', 'C', 'm-c')[0], 'failed')

    def test_a_published_report_is_seen(self):
        a = self.watcher('a')
        a.claim('abc', self.body('A', 'm-a'), 'claim abc', 'A', 'm-a')
        folder = a.prepare_folder('abc')
        write(os.path.join(folder, 'REPORT.md'), '# abc by P\n')
        who = {'GIT_AUTHOR_NAME': 'A', 'GIT_AUTHOR_EMAIL': 'a@example.invalid',
               'GIT_COMMITTER_NAME': 'A', 'GIT_COMMITTER_EMAIL': 'a@example.invalid'}
        for cmd in a.publish_commands('abc', 'abc'):  # what the human runs
            sh([t.strip('"') for t in shlex.split(cmd, posix=False)], env=who)
        self.assertTrue(self.watcher('b').read('abc')['has_report'])

    def test_claims_never_touch_the_code_branch(self):
        a = self.watcher('a')
        a.claim('abc', self.body('A', 'm-a'), 'claim abc', 'A', 'm-a')
        refs = sh(['git', '--git-dir', self.server, 'for-each-ref', '--format=%(refname)'])
        self.assertEqual(refs.split(), ['refs/heads/test-claims'])


@unittest.skipUnless(have('svn', 'svnadmin'), SKIP_SVN)
class SvnClaimsTest(Scratch):
    def setUp(self):
        super().setUp()
        self.url = svn_repo(self.path('repo')) + '/claims/demo'

    def watcher(self, name):
        return cl.SvnClaims(self.path(name), self.url)

    def body(self, who, machine):
        return cl.claim_text('r7', who, 'P', machine, WHEN)

    def test_first_claim_wins_and_the_second_loses(self):
        a, b = self.watcher('a'), self.watcher('b')
        self.assertEqual(a.claim('r7', self.body('A', 'm-a'), 'claim r7', 'A', 'm-a')[0], 'won')
        self.assertEqual(b.claim('r7', self.body('B', 'm-b'), 'claim r7', 'B', 'm-b'), ('lost', 'claimed by A'))
        self.assertEqual([c['key'] for c in b.list()], ['r7'])

    def test_a_race_is_decided_by_the_commit_conflict(self):
        a, b = self.watcher('a'), self.watcher('b')
        b.claim('r1', cl.claim_text('r1', 'B', 'P', 'm-b', WHEN), 'claim r1', 'B', 'm-b')  # the area exists
        seen = []

        def b_first():
            seen.append(b.claim('r7', self.body('B', 'm-b'), 'claim r7', 'B', 'm-b')[0])
        outcome, detail = a.claim('r7', self.body('A', 'm-a'), 'claim r7', 'A', 'm-a', before_commit=b_first)
        self.assertEqual((seen, outcome), (['won'], 'lost'))
        self.assertEqual(a.read('r7')['claimer'], 'B')
        self.assertFalse(os.path.exists(os.path.join(a.dir, 'r7', 'CLAIM.md')), 'the lost claim is discarded')

    def test_a_repeated_claim_is_idempotent_and_reports_are_seen(self):
        a = self.watcher('a')
        a.claim('r7', self.body('A', 'm-a'), 'claim r7', 'A', 'm-a')
        self.assertEqual(a.claim('r7', self.body('A', 'm-a'), 'claim r7', 'A', 'm-a')[0], 'won')
        folder = a.prepare_folder('r7')
        write(os.path.join(folder, 'REPORT.md'), '# r7 by P\n')
        svn('add', '--force', '--quiet', folder)
        svn('commit', '-q', '-m', 'proposal r7', folder)
        self.assertTrue(self.watcher('b').read('r7')['has_report'])

    def test_an_unreachable_server_is_failed(self):
        bad = cl.SvnClaims(self.path('c'), file_url(self.path('no-repo')) + '/claims')
        self.assertEqual(bad.claim('r7', self.body('C', 'm-c'), 'claim r7', 'C', 'm-c')[0], 'failed')


if __name__ == '__main__':
    unittest.main()
