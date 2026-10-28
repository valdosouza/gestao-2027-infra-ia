"""suite.py end to end on a throwaway git server with two clones (a developer and a
watcher), the fake suite and the fake agent: configuration, run, baseline record /
compare / show, the stale check, the commit door, classify, decide, watch, claims and
the proposal check."""

import json
import os
import sys
import unittest

from helpers import (Scratch, agent_cfg, cli, config, git_clone, git_commit, git_server, have, read, sh,
                     suite_spec, write)
import runner as rn

FIX_AT = '2026-10-12T10:00:00+00:00'      # a Monday
IN_GRACE = '2026-10-12T12:00:00+00:00'
AFTER_GRACE = '2026-10-14T10:00:00+00:00'
GREEN = {'calc.CalcTest.adds': 'pass', 'calc.CalcTest.subtracts': 'pass'}
ONE_RED = {'calc.CalcTest.adds': 'pass', 'calc.CalcTest.subtracts': 'fail'}
TWO_RED = {'calc.CalcTest.adds': 'fail', 'calc.CalcTest.subtracts': 'fail'}


@unittest.skipUnless(have('git'), 'git is not on PATH')
class Cli(Scratch):
    def setUp(self):
        super().setUp()
        self.server = git_server(self.path('server.git'))
        self.dev = git_clone(self.server, self.path('dev'), 'P')
        git_commit(self.dev, {'src/calc.py': 'x = 1\n', 'tests/marker.txt': 'suite\n', 'README.md': 'demo\n'},
                   'start', '2026-10-01T10:00:00+00:00')
        sh(['git', '-C', self.dev, 'push', '-q', 'origin', 'main'])
        self.wc = git_clone(self.server, self.path('wc'), 'W')
        os.makedirs(self.path('out'))
        self.results = self.path('out', 'r.xml')
        self.spec(GREEN)
        self.cfg = self.config()

    # ------------------------------------------------------------ helpers
    def spec(self, tests, **extra):
        return suite_spec(self.path('spec.json'), tests, self.results, **extra)

    def config(self, name='testing.json', state='state', suite_extra=None, **sections):
        sections.setdefault('me', 'W')
        sections.setdefault('machine', 'box-w')
        sections.setdefault('paths', {'tests': ['^tests/'], 'untestable': [r'\.md$'], 'fixtures': [r'^tests/test_.*\.py$']})
        return config(self.path(name), 'wc', state, self.path('spec.json'), self.results, suite_extra, **sections)

    def run_cli(self, *argv, cfg=None):
        return cli(['--config', cfg or self.cfg] + list(argv))

    def dev_commit(self, files, message='change', when=FIX_AT, delete=()):
        sha = git_commit(self.dev, files, message, when, delete)
        sh(['git', '-C', self.dev, 'push', '-q', 'origin', 'main'])
        return sha

    def pull(self):
        sh(['git', '-C', self.wc, 'pull', '-q', '--ff-only'])

    def watch_cfg(self, agent='good', drafting=True, **extra):
        watch = {'drafting': drafting, 'graceWorkingDays': 1}
        watch.update(extra)
        return self.config('watch.json', watch=watch, agent=agent_cfg(agent) if isinstance(agent, str) else agent)

    def state(self, state='state'):
        with open(self.path(state, 'state.json'), encoding='utf-8') as fh:
            return json.load(fh)

    # ------------------------------------------------------------ configuration
    def test_a_state_folder_inside_the_working_copy_is_refused(self):
        bad = config(self.path('bad.json'), 'wc', 'wc/.state', self.path('spec.json'), self.results)
        code, out = self.run_cli('run', cfg=bad)
        self.assertEqual(code, 2)
        self.assertIn('inside the working copy', out)

    def test_configuration_errors_name_the_key(self):
        cases = [({'paths': {'tests': ['(']}}, "paths.tests: bad pattern '('"),
                 ({'gate': {'mode': 'strict'}}, 'gate.mode'),
                 ({'watch': {'drafting': True}}, 'agent.command is empty')]
        for sections, words in cases:
            path = config(self.path('bad.json'), 'wc', 'state', self.path('spec.json'), self.results, **sections)
            code, out = self.run_cli('run', cfg=path)
            self.assertEqual(code, 2, sections)
            self.assertIn(words, out)
        twins = config(self.path('bad.json'), 'wc', 'state', self.path('spec.json'), self.results,
                       {'parts': [{'name': 'a'}, {'name': 'a'}]})
        self.assertIn('two parts named alike', self.run_cli('run', cfg=twins)[1])
        text = config(self.path('bad.json'), 'wc', 'state', self.path('spec.json'), self.results,
                      {'command': 'python x.py'})
        self.assertIn('set shell to true', self.run_cli('run', cfg=text)[1])

    # ------------------------------------------------------------ run and the baseline
    def test_run_prints_the_split_before_the_summary(self):
        self.spec(ONE_RED, exit=4)
        code, out = self.run_cli('run')
        lines = out.strip().splitlines()
        self.assertEqual(code, 4, out)  # the runner's own red code
        self.assertIn('baseline: none on this machine (every failure counts as new)', lines)
        self.assertIn('new: calc.CalcTest.subtracts', lines)
        self.assertEqual(lines[-1], 'summary: main FAILED 1/2 exit 4')
        self.assertFalse(os.path.exists(self.path('state', 'baseline.json')), 'run never records the baseline')

    def test_run_writes_its_evidence_where_asked(self):
        code, out = self.run_cli('run', '--out', self.path('ev', 'suite.json'), '--log', self.path('ev', 'suite.log'),
                                 '--before', '1', '--added', '1')
        self.assertEqual(code, 0, out)
        with open(self.path('ev', 'suite.json'), encoding='utf-8') as fh:
            data = json.load(fh)
        self.assertEqual((data['status'], data['wc']['dirty']), ('passed', []))
        code, out = self.run_cli('run', '--before', '5')
        self.assertEqual(code, 79)
        self.assertIn('ERROR [reconcile] before 5 + added 0 - replaced 0 = 5, found 2', out)

    def test_expect_red(self):
        self.spec(ONE_RED)
        self.assertEqual(self.run_cli('run', '--expect-red', 'CalcTest.subtracts')[0], 0)
        self.assertEqual(self.run_cli('run', '--expect-red', 'CalcTest.adds')[0], 1)

    def test_the_baseline_is_recorded_only_from_a_clean_working_copy(self):
        write(os.path.join(self.wc, 'src', 'calc.py'), 'x = 2\n')
        code, out = self.run_cli('baseline', 'record')
        self.assertEqual(code, 1)
        self.assertIn('local change(s) when the suite ran: M src/calc.py', out)
        sh(['git', '-C', self.wc, 'checkout', '-q', '--', '.'])
        write(os.path.join(self.wc, 'notes.txt'), 'unversioned\n')
        self.assertIn('? notes.txt', self.run_cli('baseline', 'record')[1])
        os.remove(os.path.join(self.wc, 'notes.txt'))
        code, out = self.run_cli('baseline', 'record')
        self.assertEqual(code, 0, out)
        self.assertIn('baseline recorded: main at', out)

    def test_a_result_from_an_older_tree_is_refused(self):
        self.run_cli('run', '--out', self.path('ev', 'suite.json'))
        self.dev_commit({'src/calc.py': 'x = 3\n'})
        self.pull()
        code, out = self.run_cli('baseline', 'record', '--result', self.path('ev', 'suite.json'))
        self.assertEqual(code, 1)
        self.assertIn('moved from', out)

    def test_compare_splits_and_the_block_mode_refuses_new_failures(self):
        self.spec(ONE_RED)
        self.assertEqual(self.run_cli('baseline', 'record', '--source', 'watcher')[0], 0)
        block = self.config('block.json', gate={'mode': 'block'})
        code, out = self.run_cli('baseline', 'compare', cfg=block)
        self.assertEqual(code, 0, out)
        self.assertIn('WARN already red, nothing new: 1 pre-existing failure(s)', out)
        self.spec(TWO_RED)
        code, out = self.run_cli('baseline', 'compare', cfg=block)
        self.assertEqual(code, 1, out)
        lines = out.strip().splitlines()
        pre = [ln for ln in lines if ln.startswith('pre-existing: calc.CalcTest.subtracts (red in the baseline run at ')]
        self.assertEqual(len(pre), 1, out)
        self.assertIn('new: calc.CalcTest.adds', lines)
        self.assertEqual(lines[-1], 'summary: main FAILED 0/2 exit 1')
        self.assertLess(lines.index(pre[0]), len(lines) - 1)
        self.assertEqual(self.run_cli('baseline', 'compare')[0], 0, 'warn mode never fails')
        code, out = self.run_cli('baseline', 'compare', '--json', cfg=block)
        self.assertEqual((code, json.loads(out)['new']), (1, ['calc.CalcTest.adds']))

    def test_red_since_names_the_revision_and_its_author(self):
        self.assertEqual(self.run_cli('baseline', 'record', '--source', 'watcher')[0], 0)
        q = git_clone(self.server, self.path('q'), 'Q')
        broke = git_commit(q, {'src/calc.py': 'x = 4\n'}, 'break', FIX_AT)
        sh(['git', '-C', q, 'push', '-q', 'origin', 'main'])
        self.pull()
        self.spec(ONE_RED)
        self.assertEqual(self.run_cli('baseline', 'record', '--source', 'watcher')[0], 0)
        code, out = self.run_cli('baseline', 'show')
        self.assertIn('failing: calc.CalcTest.subtracts (red since %s, Q)' % broke[:12], out)
        self.spec(ONE_RED)
        code, out = self.run_cli('run')
        self.assertIn('pre-existing: calc.CalcTest.subtracts (red since %s, Q)' % broke[:12], out)

    def test_two_revisions_at_once_do_not_blame_the_last_one(self):
        self.run_cli('baseline', 'record')
        self.dev_commit({'src/calc.py': 'x = 5\n'})
        last = self.dev_commit({'src/other.py': 'y = 1\n'})
        self.pull()
        self.spec(ONE_RED)
        self.run_cli('baseline', 'record')
        out = self.run_cli('baseline', 'show')[1]
        self.assertIn('red in the baseline run at %s, manual' % last[:12], out)
        self.assertIn('; not red at ', out)

    def test_baseline_show_without_a_baseline(self):
        code, out = self.run_cli('baseline', 'show')
        self.assertEqual(code, 0)
        self.assertIn('baseline: none on this machine', out)

    # ------------------------------------------------------------ the stale check
    def test_the_suite_missing_here_but_at_the_head_is_not_a_result(self):
        self.dev_commit({'suite2/run.txt': 'new suite\n'})
        sh(['git', '-C', self.wc, 'fetch', '-q'])
        cfg = self.config('stale.json', suite_extra={'marker': 'suite2/run.txt'})
        code, out = self.run_cli('run', cfg=cfg)
        self.assertEqual(code, 76, out)
        self.assertIn('missing here: the head of the line has suite2/run.txt', out)
        self.assertIn('summary: main MISSING-HERE 0/0 exit 76', out)
        self.pull()
        self.assertEqual(self.run_cli('run', cfg=cfg)[0], 0)

    def test_no_suite_anywhere_is_a_skip(self):
        cfg = self.config('none.json', suite_extra={'marker': 'nowhere/run.txt'})
        code, out = self.run_cli('run', cfg=cfg)
        self.assertEqual(code, 77, out)
        self.assertIn('skip: the line has no suite', out)

    def test_not_a_working_copy(self):
        os.makedirs(self.path('plain'))
        cfg = config(self.path('plain.json'), 'plain', 'state-plain', self.path('spec.json'), self.results)
        code, out = self.run_cli('run', cfg=cfg)
        self.assertEqual(code, 0, out)
        self.assertIn('the run carries no working-copy state', out)
        self.assertEqual(self.run_cli('baseline', 'record', cfg=cfg)[0], 2)
        marked = config(self.path('plain2.json'), 'plain', 'state-plain', self.path('spec.json'), self.results,
                        {'marker': 'tests/marker.txt'})
        self.assertEqual(self.run_cli('run', cfg=marked)[0], 76, 'unknown is never a silent skip')

    def test_a_part_not_run_here(self):
        back = suite_spec(self.path('back.json'), ONE_RED, self.path('out', 'back.xml'))
        parts = [{'name': 'back', 'command': [sys.executable, os.path.join(os.path.dirname(__file__), 'fake_suite.py'), back],
                  'results': {'path': self.path('out', 'back.xml')}},
                 {'name': 'front', 'requires': ['no-such-runtime-for-the-kit-tests']}]
        cfg = self.config('parts.json', suite_extra={'parts': parts})
        code, out = self.run_cli('run', cfg=cfg)
        self.assertEqual(code, 1, out)
        self.assertIn('front not run here: no-such-runtime-for-the-kit-tests not on PATH (nothing run)', out)
        self.assertIn('summary: main FAILED 1/2 (back FAILED 1/2, front NOT-RUN-HERE 0/0) exit 1', out)
        self.assertEqual(self.run_cli('baseline', 'record', cfg=cfg)[0], 0)
        self.assertIn('part front: not-run-here', self.run_cli('baseline', 'show', cfg=cfg)[1])

    # ------------------------------------------------------------ the commit door
    def test_precommit_warns_and_never_runs_the_suite_in_warn_mode(self):
        marker = self.path('suite-ran')
        self.spec(GREEN, marker=marker)
        write(os.path.join(self.wc, 'src', 'calc.py'), 'x = 9\n')
        code, out = self.run_cli('precommit')
        self.assertEqual(code, 0, out)
        self.assertIn('precommit: fix commit, 1 path(s), gate warn', out)
        self.assertIn("warn: a fix without tests", out)
        self.assertFalse(os.path.exists(marker), 'warn-only: the suite does not run at commit')
        code, out = self.run_cli('precommit', '--paths', 'src/calc.py', 'tests/test_calc.py')
        self.assertIn('warn: fix and tests in one commit', out)

    def test_precommit_fixture_rows_machine_paths_and_claims(self):
        write(os.path.join(self.wc, 'tests', 'test_calc.py'), 'DATA = "C:\\\\data\\\\calc.csv"\n')
        write(self.path('index.md'), '| Revision | Tests |\n|---|---|\n| r1 | tests/test_other.py |\n')
        cfg = self.config('door.json', index={'file': self.path('index.md')})
        code, out = self.run_cli('precommit', '--paths', 'tests/test_calc.py', cfg=cfg)
        self.assertEqual(code, 0)
        self.assertIn('warn: tests/test_calc.py has no row in the index of tested changes', out)
        self.assertIn('warn: tests/test_calc.py reads a machine path (C:\\\\data\\\\calc.csv)', out)
        sha = self.dev_commit({'src/calc.py': 'x = 7\n'})
        import claims as cl
        other = cl.GitClaims(self.path('other-state'), self.server)
        other.claim(sha, cl.claim_text(sha[:12], 'X', 'P', 'box-x'), 'claim', 'X', 'box-x')
        out = self.run_cli('precommit', '--paths', 'tests/test_calc.py', '--for', sha, cfg=cfg)[1]
        self.assertIn('is claimed by X (box-x): promote that proposal', out)

    def test_precommit_in_block_mode_runs_the_suite_and_refuses_new_failures(self):
        self.spec(ONE_RED)
        block = self.config('block.json', gate={'mode': 'block'})
        write(os.path.join(self.wc, 'src', 'calc.py'), 'x = 9\n')
        code, out = self.run_cli('precommit', cfg=block)
        self.assertEqual(code, 1, out)
        self.assertIn('BLOCK 1 new failure(s)', out)

    # ------------------------------------------------------------ classify and decide
    def test_classify(self):
        code, out = self.run_cli('classify', '--paths', 'src/a.py', 'tests/test_a.py', 'notes.md')
        self.assertEqual(out.splitlines()[0], 'paths: mixed')
        sha = self.dev_commit({'tests/test_calc.py': 'def test(): pass\n'})
        self.pull()
        self.assertIn('%s: tests' % sha[:12], self.run_cli('classify', '--rev', sha)[1])

    def test_decide_grace_then_claim(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'}, 'fix')
        self.pull()
        cfg = self.watch_cfg()
        code, out = self.run_cli('decide', '--rev', sha, '--now', IN_GRACE, '--json', cfg=cfg)
        d = json.loads(out)
        self.assertEqual((d['kind'], d['action'], d['waitUntil']), ('fix', 'wait-grace', '2026-10-13T10:00:00+00:00'))
        self.assertIn('-> claim (no tests after the grace period)',
                      self.run_cli('decide', '--rev', sha, '--now', AFTER_GRACE, cfg=cfg)[1])
        off = self.watch_cfg(drafting=False, agent={})
        self.assertIn('report-uncovered', self.run_cli('decide', '--rev', sha, '--now', AFTER_GRACE, cfg=off)[1])
        write(self.path('index.md'), '%s tests/test_calc.py\n' % sha[:8])
        covered = self.config('cov.json', index={'file': self.path('index.md')})
        self.assertIn('skip-covered', self.run_cli('decide', '--rev', sha, '--now', AFTER_GRACE, cfg=covered)[1])

    # ------------------------------------------------------------ watch
    def test_watch_claims_drafts_stages_and_a_second_watcher_skips(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'}, 'fix the sum')
        self.pull()
        cfg = self.watch_cfg()
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim', cfg=cfg)
        self.assertEqual(code, 0, out)
        self.assertIn('claim won', out)
        self.assertIn('baseline recorded', out)
        self.assertIn('proposal staged in', out)
        staged = os.path.join(self.path('state', 'claims-wc'), sha)
        self.assertEqual(sorted(os.listdir(staged)), ['CLAIM.md', 'REPORT.md', 'calc_test.draft.py'])
        prompt = read(self.path('state', 'work', sha, 'bundle', 'prompt.md'))
        self.assertIn('fix the sum', prompt)
        self.assertNotRegex(prompt, r'\{[A-Z_]+\}')
        self.assertEqual(self.state()['queue'], {})
        # the same watcher again: the proposal waits for a human, the agent does not run again
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim', cfg=cfg)
        self.assertIn('-> continue-draft', out)
        self.assertIn('waiting for a human to publish it', out)
        # another watcher sees the claim
        other = self.config('other.json', state='state-x', me='X', machine='box-x',
                            watch={'drafting': True}, agent=agent_cfg('good'))
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim', cfg=other)
        self.assertIn('-> skip-claimed', out)
        code, out = self.run_cli('claims', '--now', '2026-10-30T00:00:00+00:00', cfg=cfg)
        self.assertIn('%s claimed by W (box-w) for P' % sha, out)
        self.assertIn('report no STALE', out)
        code, out = self.run_cli('proposal', 'check', '--rev', sha, cfg=cfg)
        self.assertEqual(code, 0, out)
        self.assertIn('accepted (REPORT.md, calc_test.draft.py)', out)

    def test_watch_without_the_claim_switch_writes_nothing_to_the_repository(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'})
        self.pull()
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, cfg=self.watch_cfg())
        self.assertIn('claim needed - run with --claim to take it', out)
        self.assertEqual(self.state()['queue'][sha]['status'], 'needs-claim')
        refs = sh(['git', '--git-dir', self.server, 'for-each-ref', '--format=%(refname)'])
        self.assertNotIn('test-claims', refs)

    def test_watch_dry_run_writes_only_the_brief(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'})
        self.pull()
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--dry-run', cfg=self.watch_cfg())
        self.assertEqual(code, 0, out)
        self.assertIn('dry run: no suite, claim or agent', out)
        self.assertTrue(os.path.exists(self.path('state', 'work', sha, 'bundle', 'prompt.md')))
        self.assertFalse(os.path.exists(self.path('state', 'state.json')))
        self.assertFalse(os.path.exists(self.path('state', 'baseline.json')))

    def test_watch_poll(self):
        cfg = self.watch_cfg(drafting=False, agent={})
        code, out = self.run_cli('watch', '--poll', '--now', AFTER_GRACE, cfg=cfg)
        self.assertIn('initialised at', out)
        tests_only = self.dev_commit({'tests/test_calc.py': 'def test(): pass\n'})
        fix = self.dev_commit({'src/calc.py': 'x = 2\n'})
        sh(['git', '-C', self.wc, 'fetch', '-q'])
        cfg = self.watch_cfg(drafting=False, agent={}, ref='origin/main')
        code, out = self.run_cli('watch', '--poll', '--now', IN_GRACE, cfg=cfg)
        self.assertEqual(code, 0, out)
        self.assertIn('%s by P: tests -> skip-tests-only' % tests_only[:12], out)
        self.assertIn('%s by P: fix -> wait-grace' % fix[:12], out)
        self.assertEqual(self.state()['queue'][fix]['status'], 'deferred')
        code, out = self.run_cli('watch', '--poll', '--now', AFTER_GRACE, cfg=cfg)
        self.assertIn('%s by P: fix -> report-uncovered' % fix[:12], out)
        self.assertEqual(self.state()['queue'], {})

    def test_a_stray_file_is_refused_then_the_next_attempt_starts_clean(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'})
        self.pull()
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim',
                                 cfg=self.watch_cfg('stray-file'))
        self.assertIn('proposal not accepted: unexpected file notes.txt', out)
        self.assertEqual(self.state()['queue'][sha]['status'], 'retry')
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim', cfg=self.watch_cfg('good'))
        self.assertIn('-> continue-draft', out)
        self.assertIn('the earlier attempt moved to', out)
        self.assertIn('proposal staged in', out)

    def test_an_agent_that_writes_the_working_copy_is_refused(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'})
        self.pull()
        mode = 'touch-wc=%s' % os.path.join(self.wc, 'src', 'calc.py')
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim', cfg=self.watch_cfg(mode))
        self.assertIn('the agent changed the working copy: M src/calc.py', out)

    def test_an_agent_without_access_is_retried_later(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'})
        self.pull()
        agent = {'command': [sys.executable, '-c', 'print("error 429: rate limit reached"); raise SystemExit(1)']}
        code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim', cfg=self.watch_cfg(agent))
        self.assertIn('the agent exited with code 1', out)
        self.assertIn('no access or quota: retried in 60 minutes', out)
        self.assertEqual(self.state()['queue'][sha]['until'], '2026-10-14T11:00:00+00:00')

    def test_a_busy_suite_defers_the_revision(self):
        sha = self.dev_commit({'src/calc.py': 'x = 2\n'})
        self.pull()
        lock = rn.FileLock(self.path('state', 'suite.lock'))
        self.assertTrue(lock.acquire())
        try:
            code, out = self.run_cli('watch', '--rev', sha, '--now', AFTER_GRACE, '--claim', cfg=self.watch_cfg())
        finally:
            lock.release()
        self.assertIn('suite busy', out)
        self.assertEqual(self.state()['queue'][sha]['status'], 'retry')
        refs = sh(['git', '--git-dir', self.server, 'for-each-ref', '--format=%(refname)'])
        self.assertNotIn('test-claims', refs, 'no claim while the suite is busy')

    def test_a_second_watch_of_the_line_is_busy(self):
        lock = rn.FileLock(self.path('state', 'watch.lock'))
        self.assertTrue(lock.acquire())
        try:
            code, out = self.run_cli('watch', '--poll', cfg=self.watch_cfg())
        finally:
            lock.release()
        self.assertEqual(code, 75, out)


if __name__ == '__main__':
    unittest.main()
