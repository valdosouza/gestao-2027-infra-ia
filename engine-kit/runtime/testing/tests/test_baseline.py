"""The baseline record and the baseline-diff gate, against the contract in
skills/test-gate/references/baseline-diff.md."""

import json
import os
import unittest
from datetime import datetime, timezone

from helpers import Scratch
import baseline as bl

NOW = datetime(2026, 10, 21, 9, 0, tzinfo=timezone.utc)


def wc(rev='100', commit='100', author='P', dirty=(), mixed=False, kind='svn'):
    return {'kind': kind, 'revision': rev, 'commit_id': commit, 'commit_author': author,
            'dirty': [list(d) for d in dirty], 'mixed': mixed}


def part(name, status='failed', failing=(), erroring=(), found=10, ids='all', reason=''):
    bad = len(failing) + len(erroring)
    all_ids = None
    if ids == 'all':
        all_ids = sorted(set(failing) | set(erroring) | set('%s.ok%d' % (name, i) for i in range(found - bad)))
    elif ids is not None:
        all_ids = sorted(ids)
    return {'name': name, 'status': status, 'reason': reason, 'failing': sorted(failing), 'erroring': sorted(erroring),
            'ids': all_ids, 'counts': {'found': found, 'passed': found - bad, 'failed': len(failing),
                                       'errors': len(erroring), 'skipped': 0}}


def result(parts, status=None, state=None, line='main', unnamed=0):
    ran = [p for p in parts if p['status'] in ('passed', 'failed')]
    failing = sorted(set(n for p in ran for n in p['failing']))
    erroring = sorted(set(n for p in ran for n in p['erroring']))
    counts = {'found': sum(p['counts']['found'] for p in ran), 'failed': len(failing) + unnamed,
              'errors': len(erroring), 'passed': 0, 'skipped': 0}
    if status is None:
        status = 'failed' if failing or erroring or unnamed else 'passed'
    not_run = [{'name': p['name'], 'reason': p['reason']} for p in parts if p['status'] == 'not-run-here']
    ids = None if any(p['ids'] is None for p in ran) else sorted(set(n for p in ran for n in p['ids']))
    return {'suite': 'demo', 'line': line, 'status': status, 'reason': 'r', 'parts': parts, 'failing': failing,
            'erroring': erroring, 'ids': ids, 'counts': counts, 'notRunParts': not_run, 'partial': bool(not_run),
            'finishedAt': '2026-10-21T08:59:00+00:00', 'wc': state if state is not None else wc()}


class Refusals(unittest.TestCase):
    def test_a_clean_result_can_be_recorded(self):
        self.assertEqual(bl.refusals(result([part('a', failing=['M.F.t'])]), wc()), [])

    def test_non_results_are_refused(self):
        for status in ('busy', 'error', 'not-run-here', 'missing-here', 'no-suite'):
            why = bl.refusals(result([part('a')], status=status), wc())
            self.assertTrue(any('only a passed or failed run' in w for w in why), status)

    def test_local_changes_are_refused(self):
        why = bl.refusals(result([part('a')], state=wc(dirty=[('M', 'src/calc.py')])), wc())
        self.assertIn('1 local change(s) when the suite ran: M src/calc.py', why[0])

    def test_changes_made_after_the_run_are_refused(self):
        why = bl.refusals(result([part('a')]), wc(dirty=[('?', 'scratch.txt')]))
        self.assertIn('local change(s) now', why[0])

    def test_a_moved_working_copy_is_refused(self):
        why = bl.refusals(result([part('a')]), wc(rev='101'))
        self.assertIn('moved from 100 to 101', why[0])

    def test_mixed_revision_and_unknown_revision_are_refused(self):
        self.assertTrue(bl.refusals(result([part('a')], state=wc(mixed=True)), wc()))
        self.assertTrue(bl.refusals(result([part('a')], state=wc(rev='')), wc(rev='')))

    def test_no_working_copy_is_refused(self):
        r = result([part('a')])
        r['wc'] = None
        self.assertIn('not a working copy', bl.refusals(r, None)[0])


class Record(Scratch):
    def test_record_fields_match_the_contract(self):
        data = bl.record(self.path('s'), result([part('back', failing=['M.F.t'])]), wc(), 'watcher', NOW)
        for key in ('line', 'revision', 'time', 'source', 'status', 'failing'):
            self.assertIn(key, data)
        self.assertEqual((data['line'], data['revision'], data['source'], data['status']),
                         ('main', '100', 'watcher', 'FAILED'))
        self.assertEqual(data['time'], '2026-10-21T08:59:00+00:00')
        entry = data['failing']['M.F.t']
        self.assertEqual((entry['part'], entry['since'], entry['seen']['revision']), ('back', None, '100'))
        with open(bl.baseline_path(self.path('s')), encoding='utf-8') as fh:
            self.assertEqual(json.load(fh)['status'], 'FAILED')

    def test_a_green_run_records_ok(self):
        data = bl.record(self.path('s'), result([part('back', status='passed')]), wc(), 'watcher', NOW)
        self.assertEqual((data['status'], data['failing']), ('OK', {}))

    def test_refused_record_leaves_the_file_alone(self):
        with self.assertRaises(bl.BaselineError):
            bl.record(self.path('s'), result([part('a')], status='error'), wc(), 'watcher', NOW)
        self.assertFalse(os.path.exists(bl.baseline_path(self.path('s'))))

    def test_red_since_is_known_only_after_a_direct_predecessor(self):
        s = self.path('s')
        bl.record(s, result([part('back', status='passed')], state=wc('100', '100')), wc('100', '100'), 'watcher', NOW)
        exact = bl.record(s, result([part('back', failing=['M.F.t'])], state=wc('101', '101', 'Q')),
                          wc('101', '101'), 'watcher', NOW, first_red_exact=True)
        self.assertEqual(exact['failing']['M.F.t']['since'], {'revision': '101', 'author': 'Q'})
        self.assertEqual(bl.since_text(exact['failing']['M.F.t'], 'svn'), 'red since r101, Q')
        # the next record keeps where it started
        later = bl.record(s, result([part('back', failing=['M.F.t'])], state=wc('105', '105', 'Z')),
                          wc('105', '105'), 'watcher', NOW)
        self.assertEqual(later['failing']['M.F.t']['since'], {'revision': '101', 'author': 'Q'})

    def test_a_gap_keeps_the_last_green_revision_instead(self):
        s = self.path('s')
        bl.record(s, result([part('back', status='passed')], state=wc('100', '100')), wc('100', '100'), 'watcher', NOW)
        gap = bl.record(s, result([part('back', failing=['M.F.t'])], state=wc('104', '104', 'Q')),
                        wc('104', '104'), 'watcher', NOW, first_red_exact=False)
        e = gap['failing']['M.F.t']
        self.assertEqual((e['since'], e['notRedAt']), (None, '100'))
        self.assertEqual(bl.since_text(e, 'svn'),
                         'red in the baseline run at r104, watcher, 2026-10-21 08:59; not red at r100')

    def test_a_part_not_run_here_keeps_its_old_failures(self):
        s = self.path('s')
        bl.record(s, result([part('back', failing=['B.F.t']), part('front', failing=['F.F.t'])]), wc(), 'watcher', NOW)
        partial = result([part('back', failing=['B.F.t']),
                          part('front', status='not-run-here', found=0, ids=None, reason='node not on PATH')],
                         state=wc('101', '101'))
        data = bl.record(s, partial, wc('101', '101'), 'watcher', NOW)
        self.assertEqual(sorted(data['failing']), ['B.F.t', 'F.F.t'])
        self.assertEqual(data['parts']['front']['status'], 'not-run-here')

    def test_a_baseline_of_another_line_is_not_continued(self):
        s = self.path('s')
        bl.record(s, result([part('back', failing=['M.F.t'])], line='2.1'), wc(), 'watcher', NOW)
        data = bl.record(s, result([part('back', failing=['M.F.t'])], state=wc('101', '101')),
                         wc('101', '101'), 'watcher', NOW, first_red_exact=True)
        self.assertEqual(data['failing']['M.F.t']['seen']['revision'], '101')

    def test_an_unreadable_baseline_is_an_error_when_loaded(self):
        os.makedirs(self.path('s'))
        with open(bl.baseline_path(self.path('s')), 'w') as fh:
            fh.write('{not json')
        with self.assertRaises(bl.BaselineError):
            bl.load(self.path('s'))


class Compare(Scratch):
    def baseline(self, failing, line='main', parts=('back',)):
        r = result([part(p, failing=[n for n in failing if n.startswith(p[0].upper())]) for p in parts], line=line)
        return bl.build(r, None, 'watcher', NOW)

    def test_no_baseline_every_failure_is_new(self):
        cmp = bl.compare(result([part('back', failing=['B.F.t'])]), None)
        self.assertEqual((cmp['verdict'], cmp['new']), ('new-failures', ['B.F.t']))
        lines = bl.format_compare(cmp, 'warn')
        self.assertIn('baseline: none on this machine (every failure counts as new)', lines)
        self.assertIn('new: B.F.t', lines)

    def test_no_baseline_and_green_is_clean(self):
        self.assertEqual(bl.compare(result([part('back', status='passed')]), None)['verdict'], 'clean')

    def test_split_pre_existing_and_new(self):
        base = self.baseline(['B.F.old'])
        cmp = bl.compare(result([part('back', failing=['B.F.old', 'B.G.new'])]), base)
        self.assertEqual(cmp['verdict'], 'new-failures')
        self.assertEqual(cmp['new'], ['B.G.new'])
        lines = bl.format_compare(cmp, 'block')
        self.assertIn('pre-existing: B.F.old (red in the baseline run at r100, watcher, 2026-10-21 08:59)', lines)
        self.assertIn('new: B.G.new', lines)
        self.assertLess(lines.index('pre-existing: B.F.old (red in the baseline run at r100, watcher, 2026-10-21 08:59)'),
                        lines.index('verdict: new-failures'))
        self.assertTrue(any(ln.startswith('BLOCK 1 new failure(s)') for ln in lines))

    def test_already_red_nothing_new_passes_with_a_warning(self):
        cmp = bl.compare(result([part('back', failing=['B.F.old'])]), self.baseline(['B.F.old']))
        self.assertEqual((cmp['verdict'], bl.gate_exit(cmp, 'block')), ('pre-existing-only', 0))
        self.assertTrue(any(ln.startswith('WARN already red, nothing new') for ln in bl.format_compare(cmp, 'block')))

    def test_unnamed_failures_count_as_new(self):
        cmp = bl.compare(result([part('back', failing=['B.F.old'])], unnamed=2), self.baseline(['B.F.old']))
        self.assertEqual((cmp['verdict'], cmp['unnamed']), ('new-failures', 2))
        self.assertIn('new: 2 failure(s) without a name', bl.format_compare(cmp, 'warn'))

    def test_fixed_and_not_run_by_the_listed_ids(self):
        base = self.baseline(['B.F.fixed', 'B.F.gone'])
        r = result([part('back', status='passed', ids=['B.F.fixed', 'B.F.other'])])
        cmp = bl.compare(r, base)
        self.assertEqual((cmp['fixed'], cmp['notRun'], cmp['verdict']), (['B.F.fixed'], ['B.F.gone'], 'clean'))

    def test_without_ids_a_missing_failure_reads_as_no_longer_failing(self):
        cmp = bl.compare(result([part('back', status='passed', ids=None)]), self.baseline(['B.F.t']))
        self.assertEqual((cmp['fixed'], cmp['notRun']), (['B.F.t'], []))

    def test_a_part_not_run_here_is_never_a_failure(self):
        base = self.baseline(['B.F.t', 'F.F.t'], parts=('back', 'front'))
        r = result([part('back', failing=['B.F.t']),
                    part('front', status='not-run-here', found=0, ids=None, reason='node not on PATH')])
        cmp = bl.compare(r, base)
        self.assertEqual((cmp['verdict'], cmp['notRun']), ('pre-existing-only', ['F.F.t']))
        self.assertIn('front not run here: node not on PATH', bl.format_compare(cmp, 'warn'))

    def test_non_results_and_invalid_runs(self):
        for status, verdict, warn_exit, block_exit, first in (
                ('busy', 'busy', 0, 75, 'busy: r - not a result; run again later'),
                ('missing-here', 'missing-here', 0, 76, 'missing here: r - not a result; update the working copy and run again'),
                ('no-suite', 'no-suite', 0, 0, 'skip: r'),
                ('not-run-here', 'not-run-here', 0, 0, 'not run here: r'),
                ('error', 'invalid-run', 0, 1, 'BLOCK invalid run: r - not evidence; nothing can be said about the tests')):
            cmp = bl.compare(result([part('back')], status=status), self.baseline(['B.F.t']))
            self.assertEqual(cmp['verdict'], verdict)
            self.assertEqual((bl.gate_exit(cmp, 'warn'), bl.gate_exit(cmp, 'block')), (warn_exit, block_exit), status)
            self.assertEqual(bl.format_compare(cmp, 'block')[0], first)

    def test_warn_mode_never_fails(self):
        cmp = bl.compare(result([part('back', failing=['B.F.new'])]), None)
        self.assertEqual((bl.gate_exit(cmp, 'warn'), bl.gate_exit(cmp, 'block')), (0, 1))

    def test_a_baseline_of_another_line_is_ignored(self):
        cmp = bl.compare(result([part('back', failing=['B.F.t'])]), self.baseline(['B.F.t'], line='2.1'))
        self.assertEqual((cmp['verdict'], cmp['hasBaseline']), ('new-failures', False))
        self.assertIn('belongs to line 2.1', bl.format_compare(cmp, 'warn')[0])

    def test_red_since_text_with_git_labels(self):
        e = {'since': {'revision': 'a' * 40, 'author': 'P'}}
        self.assertEqual(bl.since_text(e, 'git'), 'red since %s, P' % ('a' * 12))


if __name__ == '__main__':
    unittest.main()
