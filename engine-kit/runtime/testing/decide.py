#!/usr/bin/env python3
"""decide.py - the commit watcher's rules, pure (engine-kit runtime, testing group).

No I/O at all: facts come in, a decision goes out. Everything that reads a working copy,
a claims area or a clock lives in the callers (suite.py), so every rule here is a unit
test away from being proven (tests/test_decide.py).

  classify(paths, tests_patterns, untestable_patterns) -> Classification
      Each changed path (relative to the working copy, forward slashes) is a test path,
      an untestable path or code. The revision is
        fix         code changed, no test path
        tests       test paths only (never analysed; it may cover earlier fixes)
        mixed       code and tests in one revision
        untestable  nothing but untestable paths (or no path at all)
      Patterns are regular expressions (re.search), configuration of the case.

  decide(facts, grace_working_days=1, weekend_days=(5, 6)) -> Decision
      The watch action for one classified revision (table in README.md):
        skip-tests-only, skip-untestable, skip-covered, skip-claimed,
        report-tests-present, report-uncovered, remind-author,
        wait-grace, claim, continue-draft

  grace_deadline(committed_at, working_days, weekend_days) -> datetime

Python 3.8+, standard library only.
"""

import re
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List, Optional

KINDS = ('fix', 'tests', 'mixed', 'untestable')
CLAIM_STATES = ('none', 'mine-open', 'mine-done', 'other')
ACTIONS = ('skip-tests-only', 'skip-untestable', 'skip-covered', 'skip-claimed',
           'report-tests-present', 'report-uncovered', 'remind-author',
           'wait-grace', 'claim', 'continue-draft')


@dataclass
class Classification:
    kind: str
    code: List[str] = field(default_factory=list)
    tests: List[str] = field(default_factory=list)
    untestable: List[str] = field(default_factory=list)


@dataclass
class Facts:
    """What the caller found out about one revision. Times are timezone-aware."""
    kind: str
    is_mine: bool = False               # the revision's author is this machine's user
    covered: bool = False               # the suite's index of tested changes names this revision
    claim: str = 'none'                 # none | mine-open | mine-done | other
    pending_tests_in_wc: bool = False   # own fix: test files changed, uncommitted, here
    drafting: bool = False              # this machine runs the proposal agent
    committed_at: Optional[datetime] = None
    now: Optional[datetime] = None


@dataclass
class Decision:
    action: str
    run_suite: bool
    claim: bool
    reason: str
    wait_until: Optional[datetime] = None


def normalise_path(path):
    p = path.replace('\\', '/')
    while p.startswith('./'):
        p = p[2:]
    return p.lstrip('/')


def compile_patterns(patterns):
    """Strings -> compiled regexes; a bad pattern raises re.error naming it."""
    out = []
    for p in patterns or []:
        try:
            out.append(re.compile(p))
        except re.error as exc:
            raise re.error('bad pattern %r: %s' % (p, exc))
    return out


def _matches(path, patterns):
    for pat in patterns:
        if pat.search(path):
            return True
    return False


def classify(paths, tests_patterns, untestable_patterns):
    """Test paths win over untestable ones (a test data file with an untestable extension
    is still a test change); everything else is code."""
    tests_re = compile_patterns(tests_patterns)
    untestable_re = compile_patterns(untestable_patterns)
    c = Classification(kind='untestable')
    for raw in paths:
        p = normalise_path(raw)
        if not p:
            continue
        if _matches(p, tests_re):
            c.tests.append(p)
        elif _matches(p, untestable_re):
            c.untestable.append(p)
        else:
            c.code.append(p)
    if c.code and c.tests:
        c.kind = 'mixed'
    elif c.code:
        c.kind = 'fix'
    elif c.tests:
        c.kind = 'tests'
    return c


def grace_deadline(committed_at, working_days, weekend_days=(5, 6)):
    """committed_at plus N working days, same time of day; weekend_days are
    datetime.weekday() numbers (Monday 0 ... Sunday 6)."""
    if working_days < 0:
        raise ValueError('working_days must be >= 0')
    d = committed_at
    left = working_days
    while left > 0:
        d = d + timedelta(days=1)
        if d.weekday() not in weekend_days:
            left -= 1
    return d


def decide(facts, grace_working_days=1, weekend_days=(5, 6)):
    f = facts
    if f.kind not in KINDS:
        raise ValueError('unknown kind %r' % f.kind)
    if f.claim not in CLAIM_STATES:
        raise ValueError('unknown claim state %r' % f.claim)
    if f.kind == 'tests':
        return Decision('skip-tests-only', False, False, 'test-only revision: never analysed (it may cover earlier fixes)')
    if f.kind == 'untestable':
        return Decision('skip-untestable', False, False, 'only untestable paths')
    if f.kind == 'mixed':
        return Decision('report-tests-present', True, False, 'tests shipped with the fix in the same revision')
    # kind == fix
    if f.covered:
        if f.is_mine:
            return Decision('report-tests-present', True, False, 'the index of tested changes names this revision')
        return Decision('skip-covered', True, False, 'the index of tested changes names this revision')
    if f.claim == 'mine-open':
        return Decision('continue-draft', True, False, 'this machine holds the claim and no report is published yet')
    if f.is_mine:
        if f.pending_tests_in_wc:
            return Decision('remind-author', True, False, 'test files of this fix are pending in the working copy: commit them')
        if f.claim in ('other', 'mine-done'):
            return Decision('skip-claimed', True, False, 'claimed: by another watcher, or by this machine with its '
                                                         'report published')
        if f.drafting:
            return Decision('claim', True, True, 'own fix without tests')
        return Decision('report-uncovered', True, False, 'own fix without tests; drafting is off on this machine')
    if f.claim in ('other', 'mine-done'):
        return Decision('skip-claimed', True, False, 'claimed: by another watcher, or by this machine with its '
                                                     'report published')
    if f.committed_at is None or f.now is None:
        raise ValueError("another author's fix needs committed_at and now to judge the grace period")
    until = grace_deadline(f.committed_at, grace_working_days, weekend_days)
    if f.now < until:
        return Decision('wait-grace', False, False, 'inside the grace period: the author may still commit the tests', until)
    if f.drafting:
        return Decision('claim', True, True, 'no tests after the grace period')
    return Decision('report-uncovered', True, False, 'no tests after the grace period; drafting is off on this machine')
