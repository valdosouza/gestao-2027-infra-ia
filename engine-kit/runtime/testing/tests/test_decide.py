"""The pure rules: classification by path patterns, the grace period, the decision table."""

import unittest
from datetime import datetime, timezone

import helpers  # noqa: F401  (puts the testing folder on sys.path)
from decide import Facts, classify, decide, grace_deadline

TESTS = [r'^tests/', r'(?i)_test\.py$']
UNTESTABLE = [r'(?i)\.(md|png|txt)$', r'^docs/']
UTC = timezone.utc


class Classify(unittest.TestCase):
    def kind(self, *paths):
        return classify(list(paths), TESTS, UNTESTABLE).kind

    def test_code_only_is_a_fix(self):
        self.assertEqual(self.kind('src/calc.py'), 'fix')

    def test_test_paths_only_are_tests(self):
        self.assertEqual(self.kind('tests/test_calc.py', 'src/calc_test.py'), 'tests')

    def test_code_and_tests_are_mixed(self):
        self.assertEqual(self.kind('src/calc.py', 'tests/test_calc.py'), 'mixed')

    def test_untestable_only(self):
        self.assertEqual(self.kind('README.md', 'docs/guide.html', 'img/logo.PNG'), 'untestable')

    def test_no_path_is_untestable(self):
        self.assertEqual(self.kind(), 'untestable')

    def test_untestable_paths_do_not_make_a_fix_mixed(self):
        c = classify(['src/calc.py', 'CHANGES.md'], TESTS, UNTESTABLE)
        self.assertEqual((c.kind, c.code, c.untestable), ('fix', ['src/calc.py'], ['CHANGES.md']))

    def test_a_test_path_wins_over_an_untestable_pattern(self):
        c = classify(['tests/data/expected.txt'], TESTS, UNTESTABLE)
        self.assertEqual((c.kind, c.tests), ('tests', ['tests/data/expected.txt']))

    def test_backslashes_and_dot_slash_are_normalised(self):
        c = classify(['.\\tests\\test_calc.py', '/src/calc.py'], TESTS, UNTESTABLE)
        self.assertEqual((c.kind, c.tests, c.code), ('mixed', ['tests/test_calc.py'], ['src/calc.py']))

    def test_a_bad_pattern_names_itself(self):
        with self.assertRaises(Exception) as ctx:
            classify(['a'], ['('], [])
        self.assertIn("'('", str(ctx.exception))


class Grace(unittest.TestCase):
    def test_one_working_day_from_friday_is_monday(self):
        friday = datetime(2026, 10, 16, 10, 0, tzinfo=UTC)
        self.assertEqual(grace_deadline(friday, 1), datetime(2026, 10, 19, 10, 0, tzinfo=UTC))

    def test_a_weekday_commit_gets_the_next_weekday(self):
        tuesday = datetime(2026, 10, 13, 8, 0, tzinfo=UTC)
        self.assertEqual(grace_deadline(tuesday, 1), datetime(2026, 10, 14, 8, 0, tzinfo=UTC))

    def test_a_saturday_commit_waits_until_monday(self):
        saturday = datetime(2026, 10, 17, 9, 0, tzinfo=UTC)
        self.assertEqual(grace_deadline(saturday, 1), datetime(2026, 10, 19, 9, 0, tzinfo=UTC))

    def test_zero_days_is_no_grace(self):
        t = datetime(2026, 10, 13, 8, 0, tzinfo=UTC)
        self.assertEqual(grace_deadline(t, 0), t)

    def test_another_weekend(self):
        thursday = datetime(2026, 10, 15, 8, 0, tzinfo=UTC)  # Friday and Saturday off
        self.assertEqual(grace_deadline(thursday, 1, weekend_days=(4, 5)), datetime(2026, 10, 18, 8, 0, tzinfo=UTC))


COMMIT = datetime(2026, 10, 16, 10, 0, tzinfo=UTC)          # a Friday
IN_GRACE = datetime(2026, 10, 17, 12, 0, tzinfo=UTC)        # Saturday
AFTER_GRACE = datetime(2026, 10, 19, 10, 1, tzinfo=UTC)     # Monday, a minute after
BASE = dict(kind='fix', is_mine=True, covered=False, claim='none', pending_tests_in_wc=False,
            drafting=True, committed_at=COMMIT, now=AFTER_GRACE)

# (changes to BASE, expected action, run_suite, claim)
TABLE = [
    ({'kind': 'tests'}, 'skip-tests-only', False, False),
    ({'kind': 'untestable'}, 'skip-untestable', False, False),
    ({'kind': 'mixed'}, 'report-tests-present', True, False),
    ({'covered': True}, 'report-tests-present', True, False),
    ({'covered': True, 'is_mine': False}, 'skip-covered', True, False),
    ({'pending_tests_in_wc': True}, 'remind-author', True, False),
    ({'claim': 'other'}, 'skip-claimed', True, False),
    ({'claim': 'mine-done'}, 'skip-claimed', True, False),
    ({'claim': 'mine-open'}, 'continue-draft', True, False),
    ({'claim': 'mine-open', 'is_mine': False}, 'continue-draft', True, False),
    ({}, 'claim', True, True),
    ({'drafting': False}, 'report-uncovered', True, False),
    ({'is_mine': False, 'claim': 'other'}, 'skip-claimed', True, False),
    ({'is_mine': False, 'now': IN_GRACE}, 'wait-grace', False, False),
    ({'is_mine': False, 'now': IN_GRACE, 'pending_tests_in_wc': True}, 'wait-grace', False, False),
    ({'is_mine': False, 'now': IN_GRACE, 'drafting': False}, 'wait-grace', False, False),
    ({'is_mine': False}, 'claim', True, True),
    ({'is_mine': False, 'drafting': False}, 'report-uncovered', True, False),
    ({'now': IN_GRACE}, 'claim', True, True),  # an author's own watcher does not wait
    ({'kind': 'tests', 'claim': 'mine-open'}, 'skip-tests-only', False, False),
    ({'kind': 'mixed', 'is_mine': False, 'now': IN_GRACE}, 'report-tests-present', True, False),
]


class DecisionTable(unittest.TestCase):
    def test_table(self):
        for changes, action, run_suite, claim in TABLE:
            facts = dict(BASE)
            facts.update(changes)
            with self.subTest(changes=changes):
                d = decide(Facts(**facts))
                self.assertEqual((d.action, d.run_suite, d.claim), (action, run_suite, claim))
                self.assertTrue(d.reason)

    def test_wait_grace_says_until_when(self):
        facts = dict(BASE, is_mine=False, now=IN_GRACE)
        d = decide(Facts(**facts))
        self.assertEqual(d.wait_until, datetime(2026, 10, 19, 10, 0, tzinfo=UTC))

    def test_a_longer_grace_period(self):
        facts = dict(BASE, is_mine=False, now=AFTER_GRACE)
        self.assertEqual(decide(Facts(**facts), grace_working_days=2).action, 'wait-grace')

    def test_another_authors_fix_needs_the_times(self):
        with self.assertRaises(ValueError):
            decide(Facts(kind='fix', is_mine=False, drafting=True))

    def test_unknown_kind_and_claim_state_are_refused(self):
        with self.assertRaises(ValueError):
            decide(Facts(kind='docs'))
        with self.assertRaises(ValueError):
            decide(Facts(kind='fix', claim='maybe'))


if __name__ == '__main__':
    unittest.main()
