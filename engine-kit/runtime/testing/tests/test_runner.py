"""The runner adapter: result readers, evidence checks, parts, the lock, statuses and exit codes."""

import os
import sys
import time
import unittest

from helpers import FAKE_SUITE, Scratch, suite_spec, write
import runner as rn


def junit(cases, declared=None):
    body = ''.join('<testcase classname="%s" name="%s">%s</testcase>' % (c, n, inner) for c, n, inner in cases)
    attr = '' if declared is False else ' tests="%d"' % (len(cases) if declared is None else declared)
    return '<testsuites%s><testsuite name="s">%s</testsuite></testsuites>' % (attr, body)


class Readers(Scratch):
    def test_junit_counts_names_and_ids(self):
        f = self.path('r.xml')
        write(f, junit([('Mod.Fix', 'a', ''), ('Mod.Fix', 'b', '<failure/>'), ('Mod.Fix', 'c', '<error/>'),
                        ('Mod.Fix', 'd', '<skipped/>')]))
        p = rn.parse_junit([f])
        self.assertEqual(p['counts'], {'found': 4, 'passed': 1, 'failed': 1, 'errors': 1, 'skipped': 1})
        self.assertEqual((p['failing'], p['erroring']), (['Mod.Fix.b'], ['Mod.Fix.c']))
        self.assertEqual(p['declared'], 4)
        self.assertIn('Mod.Fix.a', p['ids'])

    def test_qualified_names_keep_two_fixtures_apart(self):
        f = self.path('r.xml')
        write(f, junit([('One.Fix', 'row', '<failure/>'), ('Two.Fix', 'row', '')]))
        self.assertEqual(rn.parse_junit([f])['failing'], ['One.Fix.row'])

    def test_unreadable_junit_is_a_result_error(self):
        f = self.path('r.xml')
        write(f, '<testsuites')
        with self.assertRaises(rn.ResultError):
            rn.parse_junit([f])

    def test_regex_reader(self):
        text = 'run\nFAIL: A.b\nFAIL: A.c\nTests found: 5, passed: 3, failed: 2\n'
        spec = {'found': r'Tests found: (\d+)', 'passed': r'passed: (\d+)', 'failed': r'failed: (\d+)',
                'failing': r'FAIL: (\S+)'}
        p = rn.parse_regex(text, spec)
        self.assertEqual((p['counts']['found'], p['counts']['failed'], p['failing'], p['ids']),
                         (5, 2, ['A.b', 'A.c'], None))


class Evidence(unittest.TestCase):
    def parsed(self, found, passed, failed=0, errors=0, skipped=0, failing=(), declared=None):
        return {'counts': {'found': found, 'passed': passed, 'failed': failed, 'errors': errors, 'skipped': skipped},
                'failing': list(failing), 'erroring': [], 'ids': None, 'declared': declared}

    def test_zero_tests_found_is_not_green(self):
        status, reason, _ = rn.evaluate(self.parsed(0, 0), 0)
        self.assertEqual(status, 'error')
        self.assertIn('zero tests', reason)

    def test_counts_that_do_not_add_up(self):
        self.assertEqual(rn.evaluate(self.parsed(5, 3), 0)[0], 'error')

    def test_declared_count_differs(self):
        self.assertEqual(rn.evaluate(self.parsed(2, 2, declared=3), 0)[0], 'error')

    def test_non_zero_exit_without_failures_is_a_broken_run(self):
        status, reason, _ = rn.evaluate(self.parsed(2, 2), 3)
        self.assertEqual(status, 'error')
        self.assertIn('outside the tests', reason)

    def test_exit_zero_with_failures_is_still_red(self):
        status, _, integrity = rn.evaluate(self.parsed(2, 1, failed=1, failing=['A.b']), 0)
        self.assertEqual(status, 'failed')
        self.assertTrue(any(i['check'] == 'exit-code' and not i['ok'] for i in integrity))

    def test_unnamed_failures_warn(self):
        _, _, integrity = rn.evaluate(self.parsed(3, 1, failed=2, failing=['A.b']), 1)
        self.assertTrue(any(i['check'] == 'failures-named' and not i['ok'] for i in integrity))

    def test_reconcile(self):
        ok = rn.evaluate(self.parsed(12, 12), 0, expected={'before': 10, 'added': 3, 'replaced': 1})
        bad = rn.evaluate(self.parsed(11, 11), 0, expected={'before': 10, 'added': 3, 'replaced': 1})
        self.assertEqual((ok[0], bad[0]), ('passed', 'error'))
        self.assertIn('before 10 + added 3 - replaced 1 = 12, found 11', bad[1])

    def test_stale_results_file(self):
        import tempfile
        fd, f = tempfile.mkstemp()
        os.close(fd)
        try:
            old = time.time() - 100
            os.utime(f, (old, old))
            status, reason, _ = rn.evaluate(self.parsed(1, 1), 0, files=[f], started=time.time())
            self.assertEqual(status, 'error')
            self.assertIn('older than this run', reason)
        finally:
            os.remove(f)

    def test_red_check(self):
        result = {'status': 'failed', 'failing': ['M.F.a'], 'erroring': ['M.F.b']}
        rc = rn.red_check(result, ['F.a', 'M.F.b', 'M.F.c'])
        self.assertEqual([i['ok'] for i in rc['items']], [True, False, False])
        self.assertIn('error, not an assertion', rc['items'][1]['detail'])
        self.assertFalse(rn.red_check({'status': 'busy'}, ['M.F.a'])['ok'])


class RunSuite(Scratch):
    def suite(self, tests, name='demo', **spec_extra):
        os.makedirs(self.path('out'), exist_ok=True)
        out = self.path('out', '%s.xml' % name)
        spec = suite_spec(self.path('%s.json' % name), tests, out, **spec_extra)
        return {'name': name, 'command': [sys.executable, FAKE_SUITE, spec], 'cwd': self.tmp, 'timeoutSec': 60,
                'busyWaitSec': 0, 'results': {'format': 'junit', 'path': out},
                'exitCodes': {'busy': [75], 'notRunHere': [78]}}

    def run_it(self, suite, **kw):
        return rn.run_suite(suite, self.path('state'), self.path('logs', 'suite.log'), line='main', **kw)

    def test_green(self):
        r = self.run_it(self.suite({'A.x': 'pass', 'A.y': 'skip'}))
        self.assertEqual((r['status'], r['counts']['found'], rn.run_exit(r)), ('passed', 2, 0))
        self.assertEqual(rn.summary_line(r), 'summary: main OK 1/2 exit 0')

    def test_red_keeps_the_runners_own_exit_code(self):
        r = self.run_it(self.suite({'A.x': 'pass', 'A.y': 'fail'}, exit=3))
        self.assertEqual((r['status'], r['failing'], rn.run_exit(r)), ('failed', ['A.y'], 3))
        self.assertEqual(rn.summary_line(r), 'summary: main FAILED 1/2 exit 3')

    def test_red_with_a_reserved_or_zero_code_exits_1(self):
        self.assertEqual(rn.run_exit({'status': 'failed', 'exitCode': 0}), 1)
        self.assertEqual(rn.run_exit({'status': 'failed', 'exitCode': 78}), 1)

    def test_non_results_have_their_own_codes(self):
        for status, code in (('busy', 75), ('missing-here', 76), ('no-suite', 77), ('not-run-here', 78),
                             ('error', 79)):
            self.assertEqual(rn.run_exit({'status': status}), code)

    def test_no_results_file_is_an_invalid_run(self):
        r = self.run_it(self.suite({'A.x': 'pass'}, write=False))
        self.assertEqual(r['status'], 'error')
        self.assertIn('no results file', r['reason'])

    def test_command_not_found(self):
        s = self.suite({'A.x': 'pass'})
        s['command'] = ['no-such-program-for-the-kit-tests']
        r = self.run_it(s)
        self.assertEqual(r['status'], 'error')
        self.assertIn('cannot start', r['reason'])

    def test_timeout(self):
        s = self.suite({'A.x': 'pass'}, sleep=5)
        s['timeoutSec'] = 1
        r = self.run_it(s)
        self.assertEqual((r['status'], r['timedOut']), ('error', True))

    def test_busy_when_the_lock_is_held(self):
        lock = rn.FileLock(os.path.join(self.path('state'), 'suite.lock'))
        self.assertTrue(lock.acquire())
        try:
            marker = self.path('ran')
            r = self.run_it(self.suite({'A.x': 'pass'}, marker=marker))
            self.assertEqual(r['status'], 'busy')
            self.assertFalse(os.path.exists(marker), 'nothing may run while another run holds the lock')
        finally:
            lock.release()
        self.assertEqual(self.run_it(self.suite({'A.x': 'pass'}))['status'], 'passed')

    def test_exit_codes_marked_busy_and_not_run_here(self):
        self.assertEqual(self.run_it(self.suite({'A.x': 'pass'}, exit=75))['status'], 'busy')
        r = self.run_it(self.suite({'A.x': 'pass'}, exit=78))
        self.assertEqual((r['status'], rn.run_exit(r)), ('not-run-here', 78))

    def test_a_missing_requirement_is_not_run_here_and_runs_nothing(self):
        marker = self.path('ran')
        s = self.suite({'A.x': 'pass'}, marker=marker)
        s['requires'] = ['no-such-runtime-for-the-kit-tests']
        r = self.run_it(s)
        self.assertEqual(r['status'], 'not-run-here')
        self.assertIn('not on PATH', r['reason'])
        self.assertFalse(os.path.exists(marker))

    def test_parts_one_not_run_here_gives_a_partial_result(self):
        back = self.suite({'B.x': 'pass', 'B.y': 'fail'}, name='back')
        front = self.suite({'F.x': 'pass'}, name='front')
        front['requires'] = ['no-such-runtime-for-the-kit-tests']
        suite = {'name': 'demo', 'busyWaitSec': 0, 'parts': [dict(back, name='back'), dict(front, name='front')]}
        r = self.run_it(suite)
        self.assertEqual((r['status'], r['partial'], r['counts']['found']), ('failed', True, 2))
        self.assertEqual(r['notRunParts'][0]['name'], 'front')
        self.assertEqual(rn.failing_by_part(r), {'B.y': 'back'})
        self.assertEqual(rn.summary_line(r), 'summary: main FAILED 1/2 (back FAILED 1/2, front NOT-RUN-HERE 0/0) exit 1')
        self.assertTrue(os.path.exists(self.path('logs', 'suite.back.log')))

    def test_parts_reconcile_each_part(self):
        back = dict(self.suite({'B.x': 'pass', 'B.y': 'pass'}, name='back'), name='back')
        front = dict(self.suite({'F.x': 'pass'}, name='front'), name='front')
        suite = {'name': 'demo', 'busyWaitSec': 0, 'parts': [back, front]}
        ok = self.run_it(suite, expected={'total': {'before': 3}, 'parts': {'back': {'before': 1, 'added': 1}}})
        self.assertEqual(ok['status'], 'passed')
        bad = self.run_it(suite, expected={'parts': {'front': {'before': 2}}})
        self.assertEqual(bad['status'], 'error')
        self.assertIn('found 1', bad['reason'])

    def test_all_parts_not_run_here(self):
        a = dict(self.suite({'A.x': 'pass'}, name='a', exit=78), name='a')
        b = dict(self.suite({'B.x': 'pass'}, name='b', exit=78), name='b')
        r = self.run_it({'name': 'demo', 'busyWaitSec': 0, 'parts': [a, b]})
        self.assertEqual(r['status'], 'not-run-here')

    def test_an_invalid_part_makes_the_run_invalid(self):
        a = dict(self.suite({'A.x': 'pass'}, name='a'), name='a')
        b = dict(self.suite({}, name='b'), name='b')  # zero tests
        r = self.run_it({'name': 'demo', 'busyWaitSec': 0, 'parts': [a, b]})
        self.assertEqual(r['status'], 'error')
        self.assertTrue(r['reason'].startswith('b: zero tests'))

    def test_expect_red(self):
        r = self.run_it(self.suite({'A.x': 'fail', 'A.y': 'error'}), expect_red=['A.x', 'A.y'])
        self.assertEqual([i['ok'] for i in r['redCheck']['items']], [True, False])


if __name__ == '__main__':
    unittest.main()
