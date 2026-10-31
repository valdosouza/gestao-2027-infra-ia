#!/usr/bin/env python3
"""runner.py - test-runner adapter of the testing group (engine-kit runtime).

Runs the case's configured test command(s) and reads their results; the commands
themselves (framework, build, runner script) are configuration, never assumed. A suite
has one part (the suite-level command) or several (`parts`: for example a back-end runner
and a front-end runner); each part has its own command, results and exit codes, and the
whole run holds one lock. Two result readers:

  junit  JUnit XML, the de-facto exchange format most runners can write (one file or a
         glob of files). Each <testcase> counts once: a <failure> child is an assertion
         failure, an <error> child an error, a <skipped> child a skip, else a pass.
  regex  configurable regular expressions over the command output (or a log file):
         counts (found / passed / failed / errors / skipped, group 1 of the last match)
         and the failing test names (group 1 of every match).

Status of a part, and of the run (T38, T76):
  passed        tests found, none failed
  failed        tests ran and at least one failed or errored
  error         not evidence: timeout, command not found, no or stale results file,
                zero tests found, counts that do not add up, a declared count that
                differs from the listed tests, a reconcile mismatch (before + added -
                replaced != found), a non-zero exit with no failing test
  busy          another run holds the lock, or the command's exit code is one the case
                marked "busy" - not a result
  not-run-here  a required program is not on PATH, or an exit code marked "cannot run on
                this machine" - not a result, never a fail
The run adds two that suite.py decides before running anything (the stale check):
  missing-here  the line's head has the suite, this working copy does not - not a result
  no-suite      the line has no suite at its head either - the gate writes `skip:`

The run: busy wins, then error; all parts not-run-here -> not-run-here; otherwise
failed / passed over the parts that ran, `partial` when some part did not run here.

Exit codes of a run (run_exit): 0 passed; the runner's own non-zero code when failed (1
when it gave 0 or a reserved code); 75 busy, 76 missing-here, 77 no-suite, 78
not-run-here, 79 error. 75-79 are never a suite result.

Python 3.8+, standard library only.
"""

import glob
import os
import re
import shutil
import signal
import subprocess
import time
import xml.etree.ElementTree as ET
from datetime import datetime, timezone

STATUSES = ('passed', 'failed', 'error', 'busy', 'not-run-here', 'missing-here', 'no-suite')
RESULT_STATUSES = ('passed', 'failed')
COUNT_KEYS = ('found', 'passed', 'failed', 'errors', 'skipped')
PART_KEYS = ('command', 'shell', 'cwd', 'env', 'timeoutSec', 'requires', 'results', 'exitCodes')
STALE_TOLERANCE = 2.0  # seconds of file-time granularity accepted on a fresh results file
EXIT = {'passed': 0, 'busy': 75, 'missing-here': 76, 'no-suite': 77, 'not-run-here': 78, 'error': 79}
RESERVED_EXITS = (75, 76, 77, 78, 79)
STATUS_WORD = {'passed': 'OK', 'failed': 'FAILED', 'error': 'ERROR', 'busy': 'BUSY',
               'not-run-here': 'NOT-RUN-HERE', 'missing-here': 'MISSING-HERE', 'no-suite': 'NO-SUITE'}


class ResultError(Exception):
    """The results cannot be read."""


# ---------------------------------------------------------------- result readers

def _declared_count(root):
    """The tests count the file itself declares, or None when it declares none."""
    if root.tag == 'testsuites':
        if root.get('tests') is not None:
            return int(root.get('tests'))
        suites = [s for s in root if s.tag == 'testsuite']
        if suites and all(s.get('tests') is not None for s in suites):
            return sum(int(s.get('tests')) for s in suites)
        return None
    if root.tag == 'testsuite' and root.get('tests') is not None:
        return int(root.get('tests'))
    return None


def parse_junit(paths):
    """Counts and names from one or more JUnit XML files. Test id: classname.name."""
    counts = dict.fromkeys(COUNT_KEYS, 0)
    failing, erroring, ids = [], [], []
    declared, declared_known = 0, True
    for path in paths:
        try:
            root = ET.parse(path).getroot()
        except (ET.ParseError, OSError) as exc:
            raise ResultError('%s: unreadable JUnit XML (%s)' % (path, exc))
        try:
            d = _declared_count(root)
        except ValueError:
            d = None
        if d is None:
            declared_known = False
        else:
            declared += d
        for case in root.iter('testcase'):
            name = case.get('name', '')
            cls = case.get('classname', '')
            tid = '%s.%s' % (cls, name) if cls else name
            ids.append(tid)
            counts['found'] += 1
            tags = set(child.tag for child in case)
            if 'error' in tags:
                counts['errors'] += 1
                erroring.append(tid)
            elif 'failure' in tags:
                counts['failed'] += 1
                failing.append(tid)
            elif 'skipped' in tags:
                counts['skipped'] += 1
            else:
                counts['passed'] += 1
    return {'counts': counts, 'failing': failing, 'erroring': erroring, 'ids': ids,
            'declared': declared if (paths and declared_known) else None}


def parse_regex(text, spec):
    """spec: {found, passed, failed, errors, skipped, failing, erroring} - each a regex;
    a count is group 1 of its last match; names are group 1 of every match."""
    counts = dict.fromkeys(COUNT_KEYS, 0)
    seen = set()
    for key in COUNT_KEYS:
        pat = spec.get(key)
        if not pat:
            continue
        found = re.findall(pat, text)
        if found:
            last = found[-1]
            counts[key] = int(last[0] if isinstance(last, tuple) else last)
            seen.add(key)
    if 'found' not in seen:
        counts['found'] = sum(counts[k] for k in ('passed', 'failed', 'errors', 'skipped'))

    def names(key):
        pat = spec.get(key)
        if not pat:
            return []
        return [m[0] if isinstance(m, tuple) else m for m in re.findall(pat, text)]
    # the output names failing tests only: which baseline failures did run is unknown (ids None)
    return {'counts': counts, 'failing': names('failing'), 'erroring': names('erroring'), 'ids': None,
            'declared': None}


# ---------------------------------------------------------------- lock and process

class FileLock:
    """An OS lock on a file, released by the OS when the process dies (no stale lock).
    The lock file stays: deleting it after release would race with the next owner."""

    def __init__(self, path):
        self.path = path
        self.fh = None

    def acquire(self, wait_sec=0):
        os.makedirs(os.path.dirname(self.path), exist_ok=True)
        deadline = time.monotonic() + max(0, wait_sec)
        while True:
            fh = open(self.path, 'a+b')
            try:
                if os.name == 'nt':
                    import msvcrt
                    fh.seek(0)
                    msvcrt.locking(fh.fileno(), msvcrt.LK_NBLCK, 1)
                else:
                    import fcntl
                    fcntl.flock(fh.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
                self.fh = fh
                return True
            except OSError:
                fh.close()
                if time.monotonic() >= deadline:
                    return False
                time.sleep(0.5)

    def release(self):
        if not self.fh:
            return
        try:
            if os.name == 'nt':
                import msvcrt
                self.fh.seek(0)
                msvcrt.locking(self.fh.fileno(), msvcrt.LK_UNLCK, 1)
            else:
                import fcntl
                fcntl.flock(self.fh.fileno(), fcntl.LOCK_UN)
        finally:
            self.fh.close()
            self.fh = None


def _kill_tree(proc):
    try:
        if os.name == 'nt':
            subprocess.run(['taskkill', '/F', '/T', '/PID', str(proc.pid)],
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        else:
            os.killpg(os.getpgid(proc.pid), signal.SIGKILL)
    except (OSError, ProcessLookupError):
        pass
    try:
        proc.kill()
    except OSError:
        pass


def run_command(command, cwd, env, timeout, log_path, shell=False, stdin_path=None):
    """Runs the command with stdin closed (or read from stdin_path), stdout+stderr into
    log_path; a timeout stops the whole process tree. Returns exit_code, timed_out,
    started, finished, start_error."""
    os.makedirs(os.path.dirname(os.path.abspath(log_path)), exist_ok=True)
    full_env = dict(os.environ)
    for k, v in (env or {}).items():
        full_env[str(k)] = os.path.expandvars(str(v))
    kwargs = {}
    if os.name == 'nt':
        kwargs['creationflags'] = subprocess.CREATE_NEW_PROCESS_GROUP
    else:
        kwargs['start_new_session'] = True
    started = time.time()
    result = {'exit_code': None, 'timed_out': False, 'started': started, 'finished': started, 'start_error': ''}
    stdin = open(stdin_path, 'rb') if stdin_path else subprocess.DEVNULL
    try:
        with open(log_path, 'wb') as log:
            try:
                proc = subprocess.Popen(command, cwd=cwd, env=full_env, stdin=stdin,
                                        stdout=log, stderr=subprocess.STDOUT, shell=shell, **kwargs)
            except (OSError, ValueError) as exc:
                result['start_error'] = 'cannot start the command: %s' % exc
                result['finished'] = time.time()
                return result
            _wait(proc, timeout, result)
    finally:
        if stdin_path:
            stdin.close()
    result['finished'] = time.time()
    return result


def _wait(proc, timeout, result):
    try:
        result['exit_code'] = proc.wait(timeout=timeout)
    except subprocess.TimeoutExpired:
        _kill_tree(proc)
        try:
            proc.wait(timeout=30)
        except subprocess.TimeoutExpired:
            pass
        result['exit_code'] = proc.returncode
        result['timed_out'] = True


# ---------------------------------------------------------------- evaluation

def _check(integrity, name, ok, detail, severity='error'):
    integrity.append({'check': name, 'ok': bool(ok), 'severity': severity, 'detail': detail})


def _results_files(pattern, cwd):
    if not os.path.isabs(pattern):
        pattern = os.path.join(cwd, pattern)
    return sorted(set(glob.glob(pattern, recursive=True)))


def reconcile_check(integrity, expected, found, name='reconcile'):
    want = int(expected.get('before', 0)) + int(expected.get('added', 0)) - int(expected.get('replaced', 0))
    _check(integrity, name, want == found,
           'before %s + added %s - replaced %s = %d, found %d'
           % (expected.get('before', 0), expected.get('added', 0), expected.get('replaced', 0), want, found))


def evaluate(parsed, exit_code, files=None, started=None, expected=None, check_declared=True):
    """Integrity checks over parsed results. Returns (status, reason, integrity)."""
    integrity = []
    c = parsed['counts']
    if files is not None and started is not None:
        stale = [f for f in files if os.path.getmtime(f) < started - STALE_TOLERANCE]
        _check(integrity, 'results-fresh', not stale,
               'results written by this run' if not stale else
               'results older than this run (an earlier run left them): %s' % ', '.join(stale))
    _check(integrity, 'tests-found', c['found'] > 0,
           '%d test(s) found' % c['found'] if c['found'] > 0 else
           'zero tests found: a run that finds no test is a failed run, whatever its exit code')
    total = c['passed'] + c['failed'] + c['errors'] + c['skipped']
    _check(integrity, 'counts-add-up', total == c['found'],
           'passed %d + failed %d + errors %d + skipped %d = %d, found %d'
           % (c['passed'], c['failed'], c['errors'], c['skipped'], total, c['found']))
    if check_declared and parsed.get('declared') is not None:
        _check(integrity, 'declared-count', parsed['declared'] == c['found'],
               'the results declare %d test(s) and list %d' % (parsed['declared'], c['found']))
    bad = c['failed'] + c['errors']
    if exit_code not in (None, 0) and bad == 0:
        _check(integrity, 'exit-code', False,
               'exit code %s with no failing test: the run broke outside the tests' % exit_code)
    elif exit_code == 0 and bad > 0:
        _check(integrity, 'exit-code', False,
               'exit code 0 with %d failing test(s): read the counts, never the exit code' % bad, 'warning')
    else:
        _check(integrity, 'exit-code', True, 'exit code %s agrees with the counts' % exit_code)
    names = set(parsed['failing']) | set(parsed['erroring'])
    if bad > len(names):
        _check(integrity, 'failures-named', False,
               '%d failing test(s) without a name: they count as new failures' % (bad - len(names)), 'warning')
    if expected:
        reconcile_check(integrity, expected, c['found'])
    errors = [i for i in integrity if not i['ok'] and i['severity'] == 'error']
    if errors:
        return 'error', errors[0]['detail'], integrity
    if bad:
        return 'failed', '%d of %d test(s) failed or errored' % (bad, c['found']), integrity
    return 'passed', '%d test(s) passed' % c['passed'], integrity


def red_check(result, expect_red):
    """T76: each expected-red test must fail by an assertion, in a run that is a result."""
    items = []
    failing = result.get('failing', [])
    erroring = result.get('erroring', [])

    def find(names, want):
        return [n for n in names if n == want or n.endswith('.' + want)]
    for want in expect_red:
        if result['status'] not in RESULT_STATUSES:
            items.append({'test': want, 'ok': False, 'detail': 'the run is %s, not evidence' % result['status']})
        elif find(failing, want):
            items.append({'test': want, 'ok': True, 'detail': 'red by an assertion'})
        elif find(erroring, want):
            items.append({'test': want, 'ok': False, 'detail': 'red by an error, not an assertion'})
        else:
            items.append({'test': want, 'ok': False, 'detail': 'not red in this run'})
    return {'ok': all(i['ok'] for i in items), 'items': items}


def _iso(ts):
    return datetime.fromtimestamp(ts, timezone.utc).isoformat(timespec='seconds')


# ---------------------------------------------------------------- parts

def parts_of(suite):
    """The parts of a resolved 'suite' section: each entry of suite['parts'] completed from
    the suite-level keys, or one part named after the suite."""
    base = {k: suite[k] for k in PART_KEYS if k in suite}
    raw = suite.get('parts') or [{'name': suite.get('name', 'suite')}]
    out = []
    for p in raw:
        part = dict(base)
        part.update(p)
        part.setdefault('name', suite.get('name', 'suite'))
        out.append(part)
    return out


def _log_for(log_path, name, many):
    if not many:
        return log_path
    stem, ext = os.path.splitext(log_path)
    return '%s.%s%s' % (stem, name, ext or '.log')


def _empty_part(part, log_path):
    return {'name': part['name'], 'status': 'error', 'reason': '', 'exitCode': None, 'timedOut': False,
            'command': part.get('command'), 'cwd': part.get('cwd'), 'log': os.path.abspath(log_path),
            'resultsFiles': [], 'counts': dict.fromkeys(COUNT_KEYS, 0), 'failing': [], 'erroring': [],
            'ids': None, 'integrity': []}


def run_part(part, log_path, expected=None):
    """One part, under the caller's lock. Returns the part's result dict."""
    out = _empty_part(part, log_path)
    missing = [p for p in part.get('requires', []) or [] if not shutil.which(str(p))]
    if missing:
        out['status'] = 'not-run-here'
        out['reason'] = '%s not on PATH (nothing run)' % ', '.join(missing)
        return out
    results = part.get('results', {})
    fmt = results.get('format', 'junit')
    run = run_command(part['command'], part['cwd'], part.get('env'), int(part.get('timeoutSec', 1800)),
                      log_path, bool(part.get('shell', False)))
    out['startedAt'] = _iso(run['started'])
    out['finishedAt'] = _iso(run['finished'])
    out['durationSec'] = round(run['finished'] - run['started'], 1)
    out['exitCode'] = run['exit_code']
    out['timedOut'] = run['timed_out']
    codes = part.get('exitCodes', {})
    if run['start_error']:
        out['reason'] = run['start_error']
    elif run['exit_code'] in codes.get('busy', []):
        out['status'] = 'busy'
        out['reason'] = 'exit code %s: the command reports busy (not a result)' % run['exit_code']
    elif run['exit_code'] in codes.get('notRunHere', []):
        out['status'] = 'not-run-here'
        out['reason'] = 'exit code %s: cannot run on this machine (not a result, never a fail)' % run['exit_code']
    elif run['timed_out']:
        out['reason'] = 'timed out after %s s' % part.get('timeoutSec', 1800)
    else:
        try:
            files = None
            if fmt == 'junit':
                files = _results_files(results.get('path', ''), part['cwd'])
                if not files:
                    raise ResultError('no results file matches %s' % results.get('path', ''))
                parsed = parse_junit(files)
            elif fmt == 'regex':
                if results.get('path'):
                    files = _results_files(results['path'], part['cwd'])
                    if not files:
                        raise ResultError('no results file matches %s' % results['path'])
                    chunks = []
                    for f in files:
                        with open(f, 'rb') as fh:
                            chunks.append(fh.read().decode('utf-8', 'replace'))
                    text = '\n'.join(chunks)
                else:
                    with open(log_path, 'rb') as fh:
                        text = fh.read().decode('utf-8', 'replace')
                parsed = parse_regex(text, results.get('regex', {}))
            else:
                raise ResultError('unknown results format %r' % fmt)
            out['resultsFiles'] = files or []
            status, reason, integrity = evaluate(parsed, run['exit_code'], files, run['started'], expected,
                                                 bool(results.get('checkDeclared', True)))
            out.update({'status': status, 'reason': reason, 'integrity': integrity,
                        'counts': parsed['counts'], 'failing': sorted(set(parsed['failing'])),
                        'erroring': sorted(set(parsed['erroring'])),
                        'ids': sorted(set(parsed['ids'])) if parsed['ids'] is not None else None})
        except ResultError as exc:
            out['reason'] = str(exc)
    return out


def base_result(suite, line, log_path, wc_state):
    return {'version': 2, 'suite': suite.get('name', ''), 'line': line or suite.get('name', ''),
            'status': 'error', 'reason': '', 'exitCode': None, 'partial': False, 'notRunParts': [],
            'parts': [], 'log': os.path.abspath(log_path), 'counts': dict.fromkeys(COUNT_KEYS, 0),
            'failing': [], 'erroring': [], 'ids': None, 'integrity': [], 'redCheck': None, 'wc': wc_state}


def not_a_result(suite, line, status, reason, log_path, wc_state=None):
    """A run that never started (busy, missing-here, no-suite): the result dict says why."""
    result = base_result(suite, line, log_path, wc_state)
    now = _iso(time.time())
    result.update({'status': status, 'reason': reason, 'startedAt': now, 'finishedAt': now})
    return result


def normalise_expected(expected):
    """None, a plain {before, added, replaced} (the total), or {'total': {...} | None,
    'parts': {name: {...}}} -> the last form (or None)."""
    if not expected:
        return None
    if 'total' in expected or 'parts' in expected:
        return {'total': expected.get('total'), 'parts': dict(expected.get('parts') or {})}
    return {'total': expected, 'parts': {}}


def _expected_for(expected, name, many):
    """What one part reconciles: its own entry, or the total when it is the only part."""
    if not expected:
        return None
    own = expected['parts'].get(name)
    if own:
        return own
    return None if many else expected['total']


def combine(result, parts, total_expected=None):
    """The run's status, counts and names from its parts (see the module docstring).
    total_expected: the whole run's reconcile, checked here when there are several parts."""
    many = len(parts) > 1
    result['parts'] = parts
    ran = [p for p in parts if p['status'] in RESULT_STATUSES]
    evidence = [p for p in parts if p['status'] in RESULT_STATUSES or p['status'] == 'error']
    not_run = [p for p in parts if p['status'] == 'not-run-here']
    integrity = []
    for p in parts:
        for i in p.get('integrity', []):
            item = dict(i)
            if many:
                item['part'] = p['name']
            integrity.append(item)
    counts = dict.fromkeys(COUNT_KEYS, 0)
    for p in evidence:
        for k in COUNT_KEYS:
            counts[k] += p['counts'].get(k, 0)
    total_check = []
    if many and total_expected:
        if not_run:
            _check(total_check, 'reconcile', False, 'part(s) %s did not run here: reconcile each part'
                   % ', '.join(p['name'] for p in not_run))
        else:
            reconcile_check(total_check, total_expected, counts['found'])
        integrity += total_check
    label = (lambda p: '%s: ' % p['name']) if many else (lambda p: '')

    def first(status):
        for p in parts:
            if p['status'] == status:
                return label(p) + p['reason']
        return ''
    if any(p['status'] == 'busy' for p in parts):
        status, reason = 'busy', first('busy')
    elif any(p['status'] == 'error' for p in parts):
        status, reason = 'error', first('error')
    elif not ran:
        status, reason = 'not-run-here', '; '.join(label(p) + p['reason'] for p in not_run)
    elif total_check and not total_check[0]['ok']:
        status, reason = 'error', total_check[0]['detail']
    elif any(p['status'] == 'failed' for p in ran):
        bad = counts['failed'] + counts['errors']
        status, reason = 'failed', '%d of %d test(s) failed or errored' % (bad, counts['found'])
    else:
        status, reason = 'passed', '%d test(s) passed' % counts['passed']
    exits = [p['exitCode'] for p in parts if p['exitCode'] not in (None, 0)]
    started = [p['startedAt'] for p in parts if p.get('startedAt')]
    finished = [p['finishedAt'] for p in parts if p.get('finishedAt')]
    ids_known = bool(ran) and all(p['ids'] is not None for p in ran)
    result.update({
        'status': status, 'reason': reason, 'counts': counts, 'integrity': integrity,
        'partial': bool(not_run) and status in RESULT_STATUSES,
        'notRunParts': [{'name': p['name'], 'reason': p['reason']} for p in not_run],
        'failing': sorted(set(n for p in evidence for n in p['failing'])),
        'erroring': sorted(set(n for p in evidence for n in p['erroring'])),
        'ids': sorted(set(n for p in ran for n in p['ids'])) if ids_known else None,
        'exitCode': exits[0] if exits else (0 if any(p['exitCode'] == 0 for p in parts) else None),
        'timedOut': any(p.get('timedOut') for p in parts),
        'startedAt': min(started) if started else _iso(time.time()),
        'finishedAt': max(finished) if finished else _iso(time.time()),
        'durationSec': round(sum(p.get('durationSec', 0) for p in parts), 1),
    })
    return result


def run_suite(suite, state_dir, log_path=None, expected=None, expect_red=(), wc_state=None, line=''):
    """suite: the resolved 'suite' section of the config (see README). Takes the per-line
    lock (busy after busyWaitSec, nothing run), runs every part, returns the result dict
    written as suite.json."""
    if not log_path:
        stamp = datetime.now(timezone.utc).strftime('%Y%m%d-%H%M%S-%f')
        log_path = os.path.join(state_dir, 'runs', stamp, 'suite.log')
    lock = FileLock(os.path.join(state_dir, 'suite.lock'))
    if not lock.acquire(int(suite.get('busyWaitSec', 0))):
        return not_a_result(suite, line, 'busy', 'another run of this suite holds %s' % lock.path, log_path, wc_state)
    parts = parts_of(suite)
    many = len(parts) > 1
    expected = normalise_expected(expected)
    try:
        done = [run_part(p, _log_for(log_path, p['name'], many), _expected_for(expected, p['name'], many))
                for p in parts]
    finally:
        lock.release()
    result = base_result(suite, line, log_path, wc_state)
    if many:
        result['log'] = os.path.dirname(os.path.abspath(log_path))
    combine(result, done, (expected or {}).get('total'))
    if expect_red:
        result['redCheck'] = red_check(result, expect_red)
    return result


def run_exit(result):
    """The exit code of a run (module docstring)."""
    status = result.get('status')
    if status == 'failed':
        code = result.get('exitCode')
        return code if code not in (None, 0) and code not in RESERVED_EXITS else 1
    return EXIT.get(status, EXIT['error'])


def failing_names(result):
    """Every failing test of a run, assertion failures and errors alike."""
    return sorted(set(result.get('failing', [])) | set(result.get('erroring', [])))


def failing_by_part(result):
    """{qualified name: part} over the parts that ran (a result without parts: part '')."""
    parts = result.get('parts')
    if not parts:
        return dict((n, '') for n in failing_names(result))
    out = {}
    for p in parts:
        if p['status'] not in RESULT_STATUSES:
            continue
        for n in sorted(set(p.get('failing', [])) | set(p.get('erroring', []))):
            out.setdefault(n, p['name'])
    return out


def unnamed_failures(result):
    c = result.get('counts', {})
    return max(0, c.get('failed', 0) + c.get('errors', 0) - len(failing_names(result)))


def summary_line(result):
    """`summary: <line> <STATUS> <passed>/<found> exit <code>` (+ the parts' own counts)."""
    c = result.get('counts', {})
    text = 'summary: %s %s %d/%d' % (result.get('line') or result.get('suite', ''),
                                     STATUS_WORD.get(result.get('status'), str(result.get('status')).upper()),
                                     c.get('passed', 0), c.get('found', 0))
    parts = result.get('parts') or []
    if len(parts) > 1:
        text += ' (%s)' % ', '.join(
            '%s %s %d/%d' % (p['name'], STATUS_WORD.get(p['status'], p['status']), p['counts']['passed'],
                             p['counts']['found']) for p in parts)
    return '%s exit %s' % (text, run_exit(result))
