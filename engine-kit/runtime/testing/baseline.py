#!/usr/bin/env python3
"""baseline.py - the per-machine, per-line baseline of a suite and the baseline-diff gate
(T38). The contract is skills/test-gate/references/baseline-diff.md; this module keeps it.

The baseline is the last suite result this machine recorded for a line, with every
failing test by qualified name, in <stateDir>/baseline.json (one state folder per line;
machine state, never versioned; written atomically, under no lock: the last complete
snapshot wins). Comparing a run with it splits the failures into
  new          failing now, not failing in the baseline (or unnamed)  -> blocks (block mode)
  pre-existing failing now and in the baseline -> recorded, with the revision and author it
               is red since, or the baseline run that first saw it red
  fixed        failing in the baseline, passing now
  not run      failing in the baseline, absent from this run: its part did not run here,
               or the results list every test (JUnit) and it is not among them - never a failure
No baseline for the line: every failure is new (`baseline: none on this machine`).
A run that is not a result (busy, missing-here, no-suite, not-run-here) is never a failure;
an invalid run (status error: a broken build, a timeout) is not evidence and blocks in
block mode.

Recording is refused unless the run is a result (passed / failed), came from a clean
working copy (no local change; unversioned files count unless ignoreUnversioned; no svn
mixed-revision or switched tree) whose revision is known, and the working copy is still
clean and at that revision when the record is written. A run over local changes would
pass the developer's own breakage off as pre-existing; the suite gate of a change never
records. A part that did not run here keeps its failures of the previous record.

Python 3.8+, standard library only.
"""

import json
import os
from datetime import datetime, timezone

from runner import RESULT_STATUSES, failing_by_part, unnamed_failures

BLOCKING_VERDICTS = ('new-failures', 'invalid-run')
RECORD_STATUS = {'passed': 'OK', 'failed': 'FAILED'}
NON_RESULT_VERDICTS = ('busy', 'missing-here', 'no-suite', 'not-run-here')


class BaselineError(Exception):
    """The baseline file cannot be read, or the run cannot become the baseline."""


def baseline_path(state_dir):
    return os.path.join(state_dir, 'baseline.json')


def load(state_dir):
    path = baseline_path(state_dir)
    if not os.path.exists(path):
        return None
    try:
        with open(path, 'r', encoding='utf-8') as fh:
            data = json.load(fh)
    except (OSError, ValueError) as exc:
        raise BaselineError('%s: unreadable (%s); delete it to start again' % (path, exc))
    if not isinstance(data, dict) or not isinstance(data.get('failing'), dict):
        raise BaselineError('%s: no "failing" map; delete it to start again' % path)
    return data


def for_line(baseline, line):
    """(baseline or None, why it was ignored): a baseline of another line never applies."""
    if baseline is None:
        return None, ''
    if line and baseline.get('line') and baseline['line'] != line:
        return None, 'the baseline in this state folder belongs to line %s, not %s: ignored' % (baseline['line'], line)
    return baseline, ''


def write_json_atomic(path, data):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    tmp = path + '.tmp'
    with open(tmp, 'w', encoding='utf-8', newline='\n') as fh:
        json.dump(data, fh, indent=2, sort_keys=True, ensure_ascii=True)
        fh.write('\n')
    os.replace(tmp, path)


def label(kind, rev):
    """How a revision is written: r<N> (svn), the first 12 characters of the commit (git)."""
    if rev in (None, ''):
        return '?'
    return 'r%s' % rev if kind == 'svn' else str(rev)[:12]


# ---------------------------------------------------------------- record

def refusals(result, current):
    """Why this run cannot become the baseline ([] = it can). current: the working
    copy's state now (vcsops.WorkingCopy.state())."""
    why = []
    if result.get('status') not in RESULT_STATUSES:
        why.append('the run is %s (%s): only a passed or failed run is a result'
                   % (result.get('status'), result.get('reason', '')))
    wc = result.get('wc')
    if not wc:
        why.append('the run carries no working-copy state (not a working copy?)')
        return why
    if not wc.get('revision'):
        why.append('the working-copy revision was unknown when the suite ran')
    if wc.get('dirty'):
        first = ', '.join('%s %s' % (s, p) for s, p in wc['dirty'][:5])
        why.append('the working copy had %d local change(s) when the suite ran: %s'
                   % (len(wc['dirty']), first))
    if wc.get('mixed'):
        why.append('the working copy was mixed-revision or switched when the suite ran (update it)')
    if current is not None:
        if current.get('revision') != wc.get('revision'):
            why.append('the working copy moved from %s to %s since the run'
                       % (wc.get('revision'), current.get('revision')))
        if current.get('dirty'):
            why.append('the working copy has %d local change(s) now' % len(current['dirty']))
    return why


def _part_ran(previous, part):
    """Did the previous record run this part? (a record without parts info: yes)"""
    parts = previous.get('parts') or {}
    if not parts or part not in parts:
        return True
    return parts[part].get('status') in RECORD_STATUS.values()


def build(result, previous, source, now=None, first_red_exact=False):
    """The new record. A failing test already in the previous record keeps its entry
    ('since' / 'seen'); a new one is 'seen' in this run, and gets 'since' (this commit and
    its author) only when first_red_exact: the previous record's commit is this commit's
    direct predecessor on the line and the test was not failing there. Otherwise the
    previous commit is kept as 'notRedAt'."""
    now = now or datetime.now(timezone.utc)
    wc = result['wc']
    kind = wc.get('kind', '')
    commit = {'id': wc.get('commit_id', ''), 'author': wc.get('commit_author', '')}
    here = {'revision': wc.get('revision'), 'source': source, 'time': result.get('finishedAt', '')}
    old = (previous or {}).get('failing', {})
    prev_commit = ((previous or {}).get('commit') or {}).get('id', '')
    failing = {}
    for name, part in sorted(failing_by_part(result).items()):
        if name in old:
            entry = dict(old[name])
            entry['part'] = part
        else:
            entry = {'part': part, 'since': None, 'seen': dict(here)}
            if previous is not None and _part_ran(previous, part) and prev_commit and prev_commit != commit['id']:
                if first_red_exact:
                    entry['since'] = {'revision': commit['id'], 'author': commit['author']}
                else:
                    entry['notRedAt'] = prev_commit
        failing[name] = entry
    skipped = set(p['name'] for p in result.get('notRunParts', []))
    for name, entry in old.items():
        if name not in failing and entry.get('part') in skipped:
            failing[name] = dict(entry)  # its part did not run here: the old failure stays
    parts = {}
    for p in result.get('parts', []):
        parts[p['name']] = {'status': RECORD_STATUS.get(p['status'], p['status']),
                            'found': p['counts'].get('found', 0), 'reason': p.get('reason', '')}
    return {'version': 2, 'suite': result.get('suite', ''), 'line': result.get('line', ''), 'vcs': kind,
            'revision': wc.get('revision'), 'commit': commit, 'time': result.get('finishedAt', ''),
            'recordedAt': now.isoformat(timespec='seconds'), 'source': source,
            'status': RECORD_STATUS[result['status']], 'found': result.get('counts', {}).get('found', 0),
            'parts': parts, 'failing': failing}


def record(state_dir, result, current, source='manual', now=None, first_red_exact=False):
    """Writes the baseline or raises BaselineError with every refusal."""
    why = refusals(result, current)
    if why:
        raise BaselineError('; '.join(why))
    try:
        previous, _ = for_line(load(state_dir), result.get('line', ''))
    except BaselineError:
        previous = None  # an unreadable baseline is replaced; its 'since' marks are lost
    data = build(result, previous, source, now, first_red_exact)
    write_json_atomic(baseline_path(state_dir), data)
    return data


# ---------------------------------------------------------------- compare

def compare(result, baseline, line=''):
    """The gate's reading of one run against the baseline (None = no baseline)."""
    baseline, ignored = for_line(baseline, line or result.get('line', ''))
    status = result.get('status')
    out = {'verdict': '', 'hasBaseline': baseline is not None, 'baselineIgnored': ignored,
           'new': [], 'preExisting': [], 'fixed': [], 'notRun': [], 'unnamed': 0,
           'status': status, 'reason': result.get('reason', ''), 'line': result.get('line', ''),
           'notRunParts': result.get('notRunParts', []), 'partial': bool(result.get('partial')),
           'baseline': None}
    if baseline is not None:
        out['baseline'] = {k: baseline.get(k) for k in ('line', 'vcs', 'revision', 'time', 'source', 'status')}
    if status in NON_RESULT_VERDICTS:
        out['verdict'] = status
        return out
    if status not in RESULT_STATUSES:
        out['verdict'] = 'invalid-run'
        return out
    kind = (baseline or {}).get('vcs', '')
    names = failing_by_part(result)
    base = (baseline or {}).get('failing', {})
    out['new'] = sorted(n for n in names if n not in base)
    out['preExisting'] = [{'test': n, 'part': names[n], 'since': since_text(base[n], kind)}
                          for n in sorted(names) if n in base]
    out['unnamed'] = unnamed_failures(result)
    skipped = set(p['name'] for p in result.get('notRunParts', []))
    part_ids = dict((p['name'], None if p.get('ids') is None else set(p['ids']))
                    for p in result.get('parts', []) if p['status'] in RESULT_STATUSES)
    top_ids = None if result.get('ids') is None else set(result['ids'])
    for n in sorted(base):
        if n in names:
            continue
        part = base[n].get('part')
        if part in skipped:
            out['notRun'].append(n)
            continue
        ids = part_ids[part] if part in part_ids else top_ids
        if ids is None or n in ids:
            out['fixed'].append(n)  # the results do not list passing tests: "no longer failing"
        else:
            out['notRun'].append(n)
    if out['new'] or out['unnamed']:
        out['verdict'] = 'new-failures'
    elif out['preExisting']:
        out['verdict'] = 'pre-existing-only'
    else:
        out['verdict'] = 'clean'
    return out


def gate_exit(cmp, mode):
    """warn (default, EK#6): always 0. block: 1 on new failures or an invalid run; 75 busy,
    76 missing here (no result: retry or update); 0 otherwise - not-run-here and no-suite
    are never a failure, an already-red suite with nothing new passes with a warning."""
    if mode != 'block':
        return 0
    v = cmp['verdict']
    if v in BLOCKING_VERDICTS:
        return 1
    return {'busy': 75, 'missing-here': 76}.get(v, 0)


def since_text(entry, kind):
    """`red since r97, P` or `red in the baseline run at r100, watcher, <time>`."""
    since = entry.get('since')
    if since and since.get('revision'):
        who = (', %s' % since['author']) if since.get('author') else ''
        return 'red since %s%s' % (label(kind, since['revision']), who)
    seen = entry.get('seen') or {}
    when = (seen.get('time') or '')[:16].replace('T', ' ')
    text = 'red in the baseline run at %s, %s%s' % (label(kind, seen.get('revision')), seen.get('source') or '?',
                                                  (', %s' % when) if when else '')
    if entry.get('notRedAt'):
        text += '; not red at %s' % label(kind, entry['notRedAt'])
    return text


def baseline_line(b):
    if b is None:
        return 'baseline: none on this machine (every failure counts as new)'
    when = (b.get('time') or '')[:16].replace('T', ' ')
    return 'baseline: %s at %s, %s, recorded by %s (run ended %s)' % (
        b.get('line') or '?', label(b.get('vcs'), b.get('revision')), b.get('status'), b.get('source') or '?', when)


def format_compare(cmp, mode):
    """The split, printed BEFORE the summary line (the caller prints the summary)."""
    tag = 'BLOCK' if gate_exit(cmp, mode) else 'WARN'
    v = cmp['verdict']
    reason = cmp['reason']
    if v == 'busy':
        return ['busy: %s - not a result; run again later' % reason, 'verdict: busy']
    if v == 'missing-here':
        return ['missing here: %s - not a result; update the working copy and run again' % reason,
                'verdict: missing-here']
    if v == 'no-suite':
        return ['skip: %s' % reason, 'verdict: no-suite']
    if v == 'not-run-here':
        return ['not run here: %s' % reason, 'verdict: not-run-here']
    if v == 'invalid-run':
        return ['%s invalid run: %s - not evidence; nothing can be said about the tests' % (tag, reason),
                'verdict: invalid-run']
    lines = []
    if cmp.get('baselineIgnored'):
        lines.append('note: %s' % cmp['baselineIgnored'])
    lines.append(baseline_line(cmp.get('baseline')))
    for p in cmp.get('notRunParts', []):
        lines.append('%s not run here: %s' % (p['name'], p['reason']))
    for p in cmp['preExisting']:
        lines.append('pre-existing: %s (%s)' % (p['test'], p['since']))
    for n in cmp['new']:
        lines.append('new: %s' % n)
    if cmp['unnamed']:
        lines.append('new: %d failure(s) without a name' % cmp['unnamed'])
    for n in cmp['fixed']:
        lines.append('no longer failing: %s' % n)
    for n in cmp['notRun']:
        lines.append('not run in this run (not a failure): %s' % n)
    if v == 'new-failures':
        count = len(cmp['new']) + cmp['unnamed']
        lines.append('%s %d new failure(s): stop - the owner decides (regression, or intended with the go recorded)'
                     % (tag, count))
    elif v == 'pre-existing-only':
        lines.append('WARN already red, nothing new: %d pre-existing failure(s) - whoever meets them fixes them '
                     'next, in a separate commit' % len(cmp['preExisting']))
    lines.append('verdict: %s' % v)
    return lines
