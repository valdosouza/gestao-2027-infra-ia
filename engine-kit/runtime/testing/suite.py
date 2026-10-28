#!/usr/bin/env python3
"""suite.py - command line of the testing group (engine-kit runtime): run a suite with
evidence checks, keep the per-machine baseline and its gate, warn at commit time, and
watch revisions (classify, decide, claim, brief the proposal agent, check and stage its
proposal).

  python suite.py --config <testing.json> run [--out F] [--log F] [--expect-red ID]...
                                              [--before N|PART=N --added .. --replaced ..]
  python suite.py --config <f> baseline record [--result suite.json] [--source NAME]
  python suite.py --config <f> baseline compare [--result suite.json] [--json]
  python suite.py --config <f> baseline show
  python suite.py --config <f> precommit [--paths P ...] [--for REV ...] [--warn-only]
  python suite.py --config <f> classify (--rev R | --paths P ...)
  python suite.py --config <f> decide --rev R [--now ISO] [--json]
  python suite.py --config <f> watch (--rev R | --poll) [--claim] [--dry-run] [--now ISO]
  python suite.py --config <f> claims [--now ISO]
  python suite.py --config <f> proposal check --rev R [--dir D]

The configuration schema, the commands and their exit codes are in README.md. The only
repository write anywhere in this group is the claim, and only with --claim.

Python 3.8+, standard library only.
"""

import argparse
import copy
import json
import os
import re
import socket
import sys
from datetime import datetime, timedelta, timezone

HERE = os.path.dirname(os.path.abspath(__file__))
if HERE not in sys.path:
    sys.path.insert(0, HERE)

import baseline as bl  # noqa: E402
import claims as cl  # noqa: E402
import decide as dc  # noqa: E402
import proposal as pr  # noqa: E402
import runner as rn  # noqa: E402
from vcsops import VcsError, WorkingCopy, parse_time, run as vrun  # noqa: E402

DEFAULT_BLOCKED = (r'(?i)unauthori[sz]ed|authentication failed|not logged in|login required|invalid.api.key'
                   r'|\b401\b|\b403\b|insufficient.quota|usage.limit|rate.limit|\b429\b')
DEFAULTS = {
    'version': 1, 'line': '', 'workingCopy': '.', 'vcs': 'auto', 'me': '', 'machine': '', 'stateDir': '',
    'suite': {'name': 'suite', 'command': [], 'shell': False, 'cwd': '.', 'env': {}, 'timeoutSec': 1800,
              'requires': [], 'busyWaitSec': 300, 'marker': '', 'headRef': '',
              'results': {'format': 'junit', 'path': '', 'checkDeclared': True, 'regex': {}},
              'exitCodes': {'busy': [], 'notRunHere': []}, 'parts': []},
    'paths': {'tests': [], 'untestable': [], 'fixtures': []},
    'index': {'file': ''},
    'baseline': {'ignoreUnversioned': False},
    'gate': {'mode': 'warn'},
    'watch': {'ref': 'HEAD', 'fetchRemote': '', 'graceWorkingDays': 1, 'weekendDays': [5, 6],
              'drafting': False, 'maxDiffLines': 3000, 'retryMinutes': 30, 'blockedRetryMinutes': 60,
              'staleClaimDays': 7, 'suiteDocs': [], 'promptFile': ''},
    'claim': {'git': {'remote': 'origin', 'branch': 'test-claims'}, 'svn': {'url': ''}},
    'agent': {'command': [], 'stdin': False, 'timeoutSec': 2400, 'blockedPattern': DEFAULT_BLOCKED},
    'proposal': {'draftPattern': pr.DEFAULT_DRAFT_PATTERN, 'forbidden': list(pr.DEFAULT_FORBIDDEN)},
}
EXIT_WATCH_BUSY = 75


class ConfigError(Exception):
    pass


# ---------------------------------------------------------------- configuration

def _merge(base, over):
    out = copy.deepcopy(base)
    for k, v in (over or {}).items():
        if k.startswith('_'):
            continue
        if isinstance(v, dict) and isinstance(out.get(k), dict):
            out[k] = _merge(out[k], v)
        else:
            out[k] = copy.deepcopy(v)
    return out


def _read_json(path):
    try:
        with open(path, 'r', encoding='utf-8-sig') as fh:
            return json.load(fh)
    except (OSError, ValueError) as exc:
        raise ConfigError('%s: %s' % (path, exc))


def _inside(path, root):
    try:
        return os.path.normcase(os.path.commonpath([path, root])) == os.path.normcase(root)
    except ValueError:
        return False


def _safe(name):
    return re.sub(r'[^A-Za-z0-9_.-]+', '_', name).strip('_') or 'suite'


def load_config(path, me=None, state_dir=None):
    """Shared file <- <stateDir>/local.json (per machine) <- command line."""
    path = os.path.abspath(path)
    base = os.path.dirname(path)
    raw = _read_json(path)
    if not isinstance(raw, dict):
        raise ConfigError('%s: not a JSON object' % path)
    cfg = _merge(DEFAULTS, raw)
    s = cfg['suite']
    folder = s['name'] if not cfg['line'] else '%s-%s' % (s['name'], cfg['line'])
    sd = state_dir or cfg['stateDir'] or os.path.join('~', '.engine-kit', 'testing', _safe(folder))
    sd = os.path.abspath(os.path.join(base, os.path.expanduser(os.path.expandvars(sd))))
    local = os.path.join(sd, 'local.json')
    if os.path.exists(local):
        cfg = _merge(cfg, _read_json(local))
        s = cfg['suite']
    cfg['stateDir'] = sd
    if me:
        cfg['me'] = me
    cfg['line'] = cfg['line'] or s['name']
    cfg['machine'] = cfg['machine'] or socket.gethostname()
    cfg['configDir'] = base
    cfg['workingCopy'] = os.path.abspath(os.path.join(base, os.path.expandvars(cfg['workingCopy'])))
    s['cwd'] = os.path.abspath(os.path.join(cfg['workingCopy'], s['cwd']))
    shared = dict((k, s[k]) for k in rn.PART_KEYS)
    parts = []
    for p in s['parts'] or [{'name': s['name']}]:
        if not isinstance(p, dict):
            raise ConfigError('suite.parts: each part is an object with a "name"')
        part = _merge(shared, p)
        part['name'] = str(p.get('name', ''))
        part['cwd'] = os.path.abspath(os.path.join(cfg['workingCopy'], p.get('cwd', s['cwd'])))
        parts.append(part)
    s['parts'] = parts
    if cfg['index']['file']:
        cfg['index']['file'] = os.path.abspath(os.path.join(cfg['workingCopy'], cfg['index']['file']))
    w = cfg['watch']
    w['promptFile'] = os.path.abspath(os.path.join(base, w['promptFile'])) if w['promptFile'] \
        else os.path.join(HERE, 'watch.prompt.md')
    _validate(cfg)
    return cfg


def _validate(cfg):
    s = cfg['suite']
    names = [p['name'] for p in s['parts']]
    if len(set(names)) != len(names):
        raise ConfigError('suite.parts: two parts named alike (%s)' % ', '.join(names))
    for p in s['parts']:
        where = 'suite' if len(s['parts']) == 1 else 'suite.parts[%s]' % p['name']
        if not re.match(r'^[A-Za-z0-9_.-]+$', p['name']):
            raise ConfigError('%s: a name of letters, digits, "_", "." or "-"' % where)
        if not p['command'] or not isinstance(p['command'], (list, str)):
            raise ConfigError('%s.command: a non-empty list of arguments (or a string with shell true)' % where)
        if isinstance(p['command'], str) and not p['shell']:
            raise ConfigError('%s.command is a string: set shell to true, or give a list' % where)
        if not isinstance(p.get('requires', []), list):
            raise ConfigError('%s.requires: a list of program names' % where)
        r = p['results']
        if r.get('format', 'junit') not in ('junit', 'regex'):
            raise ConfigError('%s.results.format: junit or regex' % where)
        if r.get('format', 'junit') == 'junit' and not r.get('path'):
            raise ConfigError('%s.results.path: the JUnit XML file (or glob) the command writes' % where)
    if cfg['gate']['mode'] not in ('warn', 'block'):
        raise ConfigError('gate.mode: warn or block')
    if cfg['watch']['drafting'] and not cfg['agent']['command']:
        raise ConfigError('watch.drafting is true but agent.command is empty')
    if _inside(cfg['stateDir'], cfg['workingCopy']):
        raise ConfigError('stateDir %s is inside the working copy: it is machine state, keep it outside'
                          % cfg['stateDir'])
    for key in ('tests', 'untestable', 'fixtures'):
        try:
            dc.compile_patterns(cfg['paths'][key])
        except Exception as exc:
            raise ConfigError('paths.%s: %s' % (key, exc))
    try:
        re.compile(cfg['agent']['blockedPattern'] or '(?!)')
    except re.error as exc:
        raise ConfigError('agent.blockedPattern: %s' % exc)


def utc_now(arg=None):
    return parse_time(arg) if arg else datetime.now(timezone.utc)


def say(line):
    print(line)
    sys.stdout.flush()


def _rev(wc, value):
    return int(str(value).lstrip('rR')) if wc.kind == 'svn' else value


# ---------------------------------------------------------------- index of tested changes

REV_TOKEN = re.compile(r'^(r\d+|[0-9a-f]{7,40})$')


def read_index(path):
    """Rows of the suite's index of tested changes: [(revision tokens, file tokens)]. A row
    is any line naming a revision (r<N>, or 7 to 40 hex characters of a commit); its other
    tokens with a '/' or a '.' are the test files (paths relative to the working copy).
    Markdown table rows work: '|' and ',' separate tokens."""
    rows = []
    if not path or not os.path.exists(path):
        return rows
    with open(path, 'r', encoding='utf-8-sig') as fh:
        for line in fh:
            s = line.strip()
            if not s or s.startswith('#'):
                continue
            if not s.startswith('|'):
                s = s.split(' #', 1)[0]  # a trailing comment
            tokens = [t.strip('`*') for t in re.split(r'[\s|,;]+', s)]
            tokens = [t for t in tokens if t]
            revs = set(t for t in tokens if REV_TOKEN.match(t))
            if revs:
                files = set(dc.normalise_path(t) for t in tokens if t not in revs and ('/' in t or '.' in t))
                rows.append((revs, files))
    return rows


def index_covers(rows, kind, rev):
    rev = str(rev)
    for revs, _ in rows:
        for t in revs:
            if kind == 'svn' and t == 'r%s' % rev:
                return True
            if kind == 'git' and not t.startswith('r') and rev.startswith(t):
                return True
    return False


# ---------------------------------------------------------------- run and baseline

def _parse_counts(values, what):
    """--before N or --before PART=N (repeatable) -> (total or None, {part: N})."""
    total, parts = None, {}
    for v in values or []:
        name, _, num = v.rpartition('=')
        try:
            n = int(num)
        except ValueError:
            raise ConfigError('--%s %s: a number, or PART=number' % (what, v))
        if name:
            parts[name] = n
        else:
            total = n
    return total, parts


def expected_from(args):
    keys = ('before', 'added', 'replaced')
    got = dict((k, _parse_counts(getattr(args, k, None), k)) for k in keys)
    if all(got[k][0] is None and not got[k][1] for k in keys):
        return None
    total = None
    if got['before'][0] is not None:
        total = dict((k, got[k][0] or 0) for k in keys)
    parts = {}
    for name in set(n for k in keys for n in got[k][1]):
        parts[name] = dict((k, got[k][1].get(name, 0)) for k in keys)
    return {'total': total, 'parts': parts}


def stale_check(cfg, wc, marker):
    """The marker is not in the working copy: missing here, or no suite at all?"""
    where = cfg['workingCopy']
    if wc is None:
        return 'missing-here', ('the suite marker %s is not in %s, which is not a working copy: nothing can say '
                                'whether the line has a suite' % (marker, where))
    try:
        has = wc.head_has(marker, cfg['suite']['headRef'])
    except VcsError as exc:
        return 'missing-here', 'the suite marker %s is not here and the head of the line cannot be read (%s)' % (marker, exc)
    if has:
        return 'missing-here', 'the head of the line has %s, this working copy does not: update it' % marker
    return 'no-suite', 'the line has no suite (no %s here or at the head of the line)' % marker


def do_run(cfg, wc, out=None, log=None, expected=None, expect_red=()):
    state = None
    if wc is not None:
        try:
            state = wc.state(cfg['baseline']['ignoreUnversioned'])
        except VcsError as exc:
            say('note: working-copy state unknown (%s)' % exc)
    suite = copy.deepcopy(cfg['suite'])
    for p in suite['parts']:
        if isinstance(p['command'], list):
            p['command'] = [str(a).replace('{wc}', cfg['workingCopy']) for a in p['command']]
        else:
            p['command'] = p['command'].replace('{wc}', cfg['workingCopy'])
    if not log:
        stamp = datetime.now(timezone.utc).strftime('%Y%m%d-%H%M%S-%f')
        log = os.path.join(cfg['stateDir'], 'runs', stamp, 'suite.log')
    log = os.path.abspath(log)
    marker = suite['marker']
    if marker and not os.path.exists(os.path.join(cfg['workingCopy'], marker)):
        status, reason = stale_check(cfg, wc, marker)
        result = rn.not_a_result(suite, cfg['line'], status, reason, log, state)
    else:
        result = rn.run_suite(suite, cfg['stateDir'], log, expected, expect_red, state, cfg['line'])
    out = os.path.abspath(out or os.path.join(os.path.dirname(log), 'suite.json'))
    bl.write_json_atomic(out, result)
    result['_file'] = out
    return result


def print_details(result):
    """What precedes the split: integrity findings, the red check, where the evidence is."""
    for i in result.get('integrity', []):
        if not i['ok']:
            where = '%s/%s' % (i['part'], i['check']) if i.get('part') else i['check']
            say('%s [%s] %s' % ('ERROR' if i['severity'] == 'error' else 'warn', where, i['detail']))
    if result.get('redCheck'):
        for i in result['redCheck']['items']:
            say('red-check %s: %s - %s' % ('ok' if i['ok'] else 'FAIL', i['test'], i['detail']))
    logs = [p['log'] for p in result.get('parts', [])] or [result.get('log', '')]
    say('evidence: %s (log %s)' % (result.get('_file', ''), ', '.join(logs)))


def read_baseline(cfg):
    try:
        return bl.load(cfg['stateDir'])
    except bl.BaselineError as exc:
        say('note: %s - read as no baseline' % exc)
        return None


def report_split(cfg, result, mode):
    """Prints the split, then the summary; returns the comparison."""
    cmp = bl.compare(result, read_baseline(cfg), cfg['line'])
    for line in bl.format_compare(cmp, mode):
        say(line)
    say(rn.summary_line(result))
    return cmp


def cmd_run(cfg, wc, args):
    result = do_run(cfg, wc, args.out, args.log, expected_from(args), args.expect_red or ())
    print_details(result)
    report_split(cfg, result, 'warn')  # the suite gate reads the split; the run itself never records
    if args.expect_red:
        return 0 if result['redCheck']['ok'] and result['status'] == 'failed' else 1
    return rn.run_exit(result)


def _result_from(cfg, wc, path, quiet=False):
    if path:
        try:
            with open(path, 'r', encoding='utf-8') as fh:
                result = json.load(fh)
        except (OSError, ValueError) as exc:
            raise ConfigError('%s: %s' % (path, exc))
        if not isinstance(result, dict) or 'status' not in result:
            raise ConfigError('%s: not a suite.json written by `run`' % path)
        return result
    result = do_run(cfg, wc)
    if not quiet:
        print_details(result)
    return result


def first_red_exact(wc, previous, result):
    """Is the previous record's commit the direct predecessor of this run's commit?"""
    try:
        old = ((previous or {}).get('commit') or {}).get('id')
        new = (result.get('wc') or {}).get('commit_id')
        if not old or not new or str(old) == str(new):
            return False
        return [str(r) for r in wc.revisions_between(old, new)] == [str(new)]
    except (VcsError, ValueError):
        return False


def try_record(cfg, wc, result, source):
    if wc is None:
        return False, 'baseline not recorded: %s is not a working copy' % cfg['workingCopy']
    try:
        current = wc.state(cfg['baseline']['ignoreUnversioned'])
        previous, _ = bl.for_line(read_baseline(cfg), cfg['line'])
        data = bl.record(cfg['stateDir'], result, current, source,
                         first_red_exact=first_red_exact(wc, previous, result))
        return True, 'baseline recorded: %s at %s, %s, %d failing (by %s)' % (
            data['line'], bl.label(data['vcs'], data['revision']), data['status'], len(data['failing']), source)
    except (bl.BaselineError, VcsError) as exc:
        return False, 'baseline not recorded: %s' % exc


def cmd_baseline(cfg, wc, args):
    if args.action == 'show':
        data, ignored = bl.for_line(bl.load(cfg['stateDir']), cfg['line'])
        if ignored:
            say('note: %s' % ignored)
        if data is None:
            say('%s (%s)' % (bl.baseline_line(None), bl.baseline_path(cfg['stateDir'])))
            return 0
        say('%s, %d found, %d failing' % (bl.baseline_line(data), data.get('found', 0), len(data['failing'])))
        parts = data.get('parts') or {}
        many = len(parts) > 1
        for name, p in sorted(parts.items() if many else ()):
            say('part %s: %s%s' % (name, p.get('status'), (' - %s' % p['reason']) if p.get('reason') and
                                  p.get('status') not in ('OK', 'FAILED') else ''))
        for name in sorted(data['failing']):
            e = data['failing'][name]
            say('failing: %s%s (%s)' % (name, (' [%s]' % e['part']) if many and e.get('part') else '',
                                        bl.since_text(e, data.get('vcs'))))
        return 0
    result = _result_from(cfg, wc, args.result, quiet=args.json)
    if args.action == 'record':
        ok, msg = try_record(cfg, wc, result, args.source)
        say(msg)
        return 0 if ok else 1
    mode = cfg['gate']['mode']
    if args.json:
        cmp = bl.compare(result, read_baseline(cfg), cfg['line'])
        say(json.dumps(cmp, indent=2, sort_keys=True))
    else:
        cmp = report_split(cfg, result, mode)
    return bl.gate_exit(cmp, mode)


# ---------------------------------------------------------------- the commit door (warn-only)

def _matches(path, patterns):
    return any(p.search(path) for p in patterns)


def cmd_precommit(cfg, wc, args):
    if getattr(args, 'warn_only', False) and cfg['gate']['mode'] != 'warn':
        say('note: gate.mode is %s in the testing config; from the plugin hook the door stays warn-only '
            '(EK#14) - a blocking door is the project\'s own VCS hook' % cfg['gate']['mode'])
        cfg['gate']['mode'] = 'warn'
    p = cfg['paths']
    tests_re = dc.compile_patterns(p['tests'])
    dirty = []
    if wc is not None:
        dirty = [(s, path) for s, path in wc.state(False)['dirty']]
    if args.paths:
        paths = [dc.normalise_path(x) for x in args.paths]
    elif wc is not None:
        paths = [path for s, path in dirty if s != '?']
    else:
        raise ConfigError('precommit: no working copy - give the committed paths with --paths')
    c = dc.classify(paths, p['tests'], p['untestable'])
    warnings = []
    if c.kind == 'mixed':
        warnings.append('fix and tests in one commit: commit the fix first, then the tests in a separate commit')
    if c.kind == 'fix':
        pending = sorted(path for s, path in dirty if path not in paths and _matches(path, tests_re))
        if pending:
            warnings.append('the tests of this fix are pending in the working copy (%s): commit them next, '
                            'in a separate commit' % ', '.join(pending[:5]))
        else:
            warnings.append('a fix without tests: write its tests (or the Test plan\'s exempt line) and commit '
                            'them after the fix')
    fixtures_re = dc.compile_patterns(p['fixtures'])
    fixtures = [t for t in c.tests if fixtures_re and _matches(t, fixtures_re)]
    if fixtures and cfg['index']['file']:
        listed = set(f for _, files in read_index(cfg['index']['file']) for f in files)
        for f in fixtures:
            if f not in listed:
                warnings.append('%s has no row in the index of tested changes (%s)' % (f, cfg['index']['file']))
    for t in c.tests:
        full = os.path.join(cfg['workingCopy'], t)
        if os.path.isfile(full):
            with open(full, 'rb') as fh:
                hit = pr.machine_path_hit(fh.read().decode('utf-8', 'replace'), cfg['proposal']['forbidden'])
            if hit:
                warnings.append('%s reads a machine path (%s): take files relative to the test or from per-machine '
                                'configuration' % (t, hit))
    for rev in args.for_rev or []:
        if wc is None:
            break
        held = cl.open_claims(wc.kind, cfg['stateDir'], cfg['claim'], wc).read(cl.claim_key(wc.kind, _rev(wc, rev)))
        if held and not (held.get('claimer') == cfg['me'] and held.get('machine') == cfg['machine']):
            warnings.append('%s is claimed by %s (%s): promote that proposal rather than writing a second one'
                            % (rev, held.get('claimer'), held.get('machine')))
    say('precommit: %s commit, %d path(s), gate %s' % (c.kind, len(paths), cfg['gate']['mode']))
    for w in warnings:
        say('warn: %s' % w)
    if cfg['gate']['mode'] != 'block':
        say('suite not run at commit (warn-only, EK#6): the suite gate and the commit watcher run it')
        return 0
    result = do_run(cfg, wc)
    print_details(result)
    cmp = report_split(cfg, result, 'block')
    return bl.gate_exit(cmp, 'block')


# ---------------------------------------------------------------- watch

class Watch:
    def __init__(self, cfg, wc, now, claim_ok=False, dry_run=False):
        self.cfg, self.wc, self.now = cfg, wc, now
        self.claim_ok, self.dry_run = claim_ok, dry_run
        self.suite_result = None
        self._claims = None
        self.state_file = os.path.join(cfg['stateDir'], 'state.json')

    # --- facts
    def claims(self):
        if self._claims is None:
            self._claims = cl.open_claims(self.wc.kind, self.cfg['stateDir'], self.cfg['claim'], self.wc)
        return self._claims

    def key(self, info):
        return cl.claim_key(self.wc.kind, info['rev'])

    def covered(self, info):
        return index_covers(read_index(self.cfg['index']['file']), self.wc.kind, info['rev'])

    def claim_state(self, info):
        held = self.claims().read(self.key(info))
        if held is None:
            return 'none'
        mine = held.get('claimer') == self.cfg['me'] and held.get('machine') == self.cfg['machine']
        if mine:
            return 'mine-done' if held.get('has_report') else 'mine-open'
        return 'other'

    def pending_tests(self):
        st = self.wc.state(ignore_unversioned=False)
        pats = dc.compile_patterns(self.cfg['paths']['tests'])
        return any(_matches(path, pats) for _, path in st['dirty'])

    def facts(self, info, cls):
        f = dc.Facts(kind=cls.kind, is_mine=self.wc.is_author(info, self.cfg['me']),
                     drafting=bool(self.cfg['watch']['drafting']),
                     committed_at=info['committed_at'], now=self.now)
        if cls.kind == 'fix':
            f.covered = self.covered(info)
            f.claim = self.claim_state(info)
            if f.is_mine:
                f.pending_tests_in_wc = self.pending_tests()
        return f

    def decide(self, rev):
        info = self.wc.revision_info(rev)
        if info is None:
            return None, None, None
        p = self.cfg['paths']
        cls = dc.classify(info['paths'], p['tests'], p['untestable'])
        f = self.facts(info, cls)
        w = self.cfg['watch']
        d = dc.decide(f, int(w['graceWorkingDays']), tuple(w['weekendDays']))
        return info, cls, d

    # --- actions
    def log(self, line):
        say(line)
        if self.dry_run:
            return
        os.makedirs(self.cfg['stateDir'], exist_ok=True)
        with open(os.path.join(self.cfg['stateDir'], 'watch.log'), 'a', encoding='utf-8', newline='\n') as fh:
            fh.write('%s %s\n' % (self.now.isoformat(timespec='seconds'), line))

    def run_suite_once(self):
        """One run per watch process: the watcher never updates the working copy, so the
        result is the same for every revision of one poll. Records the baseline when clean."""
        if self.suite_result is None:
            result = do_run(self.cfg, self.wc)
            print_details(result)
            report_split(self.cfg, result, 'warn')
            if result['status'] in rn.RESULT_STATUSES:
                ok, msg = try_record(self.cfg, self.wc, result, 'watcher')
                self.log(msg)
            self.suite_result = result
        return self.suite_result

    def write_bundle(self, info, cls, suite_result):
        key = self.key(info)
        bundle, proposal_dir = pr.work_dirs(self.cfg['stateDir'], key)
        os.makedirs(bundle, exist_ok=True)
        os.makedirs(proposal_dir, exist_ok=True)
        rev_json = dict(info)
        rev_json['committed_at'] = info['committed_at'].isoformat()
        rev_json['classification'] = {'kind': cls.kind, 'code': cls.code, 'tests': cls.tests,
                                      'untestable': cls.untestable}
        bl.write_json_atomic(os.path.join(bundle, 'revision.json'), rev_json)
        bl.write_json_atomic(os.path.join(bundle, 'suite.json'),
                             suite_result or {'status': 'not run (dry run)'})
        diff = self.wc.diff(info['rev'])
        with open(os.path.join(bundle, 'diff.patch'), 'w', encoding='utf-8', newline='\n') as fh:
            fh.write(diff)
        lines = pr.count_diff_lines(diff)
        w = self.cfg['watch']
        wc_state = (suite_result or {}).get('wc') or {}
        with open(w['promptFile'], 'r', encoding='utf-8') as fh:
            template = fh.read()
        values = {'SUITE': self.cfg['suite']['name'], 'LINE': self.cfg['line'], 'REV_LABEL': info['label'],
                  'AUTHOR': info['author'], 'DATE': info['committed_at'].isoformat(timespec='seconds'),
                  'MESSAGE': info['message'].splitlines()[0] if info['message'] else '(none)',
                  'PATHS': '\n'.join('  - %s' % p for p in cls.code) or '  (none)',
                  'SKIPPED': '\n'.join('  - %s' % p for p in cls.untestable) or '  (none)',
                  'DIFF_LINES': lines, 'MAX_DIFF_LINES': w['maxDiffLines'],
                  'OVERSIZE': 'yes' if lines > int(w['maxDiffLines']) else 'no',
                  'BUNDLE_DIR': bundle.replace(os.sep, '/'), 'WORKING_COPY': self.wc.root.replace(os.sep, '/'),
                  'WC_REVISION': wc_state.get('revision') or 'unknown',
                  'SUITE_DOCS': ', '.join('`%s`' % d for d in w['suiteDocs']) or '(none configured)',
                  'PROPOSAL_DIR': proposal_dir.replace(os.sep, '/'),
                  'DRAFT_PATTERN': self.cfg['proposal']['draftPattern']}
        prompt_file = os.path.join(bundle, 'prompt.md')
        with open(prompt_file, 'w', encoding='utf-8', newline='\n') as fh:
            fh.write(pr.render_prompt(template, values))
        return bundle, proposal_dir, prompt_file

    def run_agent(self, info, bundle, proposal_dir, prompt_file):
        """(problems, blocked): blocked = the agent's output says it has no access or quota."""
        a = self.cfg['agent']
        settings = os.path.join(bundle, 'agent.settings.json')
        if any('{agent_settings}' in str(x) for x in a['command']):
            pr.write_agent_settings(settings, proposal_dir)
        cmd = pr.agent_command(a['command'], {'prompt': prompt_file, 'proposal': proposal_dir, 'bundle': bundle,
                                              'rev': info['label'], 'agent_settings': settings})
        agent_log = os.path.join(bundle, 'agent.log')
        before = self.wc.state(False)['dirty']
        run = rn.run_command(cmd, proposal_dir, {}, int(a['timeoutSec']), agent_log,
                             stdin_path=prompt_file if a['stdin'] else None)
        after = self.wc.state(False)['dirty']
        problems = []
        if run['start_error']:
            problems.append(run['start_error'])
        if run['timed_out']:
            problems.append('the agent timed out after %s s' % a['timeoutSec'])
        elif run['exit_code'] not in (None, 0):
            problems.append('the agent exited with code %s' % run['exit_code'])
        if after != before:
            changed = sorted(set(map(tuple, after)) ^ set(map(tuple, before)))
            problems.append('the agent changed the working copy: %s'
                            % ', '.join('%s %s' % c for c in changed[:5]))
        blocked = False
        if a['blockedPattern'] and os.path.exists(agent_log) and not run['timed_out']:
            with open(agent_log, 'rb') as fh:
                blocked = bool(re.search(a['blockedPattern'], fh.read().decode('utf-8', 'replace')))
        return problems, blocked

    def staged(self, info):
        try:
            return os.path.isfile(os.path.join(self.claims().folder(self.key(info)), 'REPORT.md'))
        except VcsError:
            return False

    def draft(self, info, cls):
        bundle, proposal_dir, prompt_file = self.write_bundle(info, cls, self.suite_result)
        if self.dry_run:
            self.log('%s: bundle and brief written to %s (dry run: no suite, claim or agent)' % (info['label'], bundle))
            return 'done', None
        stamp = self.now.strftime('%Y%m%d-%H%M%S')
        moved = pr.archive_attempt(proposal_dir, os.path.join(os.path.dirname(bundle), 'attempts'), stamp,
                                   os.path.join(bundle, 'agent.log'))
        if moved:
            self.log('%s: the earlier attempt moved to %s' % (info['label'], moved))
        problems, blocked = self.run_agent(info, bundle, proposal_dir, prompt_file)
        p = self.cfg['proposal']
        ok, files, reasons = pr.check_proposal(proposal_dir, {info['label'], str(info['rev'])},
                                               p['draftPattern'], p['forbidden'])
        if problems or not ok:
            self.log('%s: proposal not accepted: %s' % (info['label'], '; '.join(problems + reasons)))
            if blocked:
                minutes = int(self.cfg['watch']['blockedRetryMinutes'])
                self.log('%s: the agent reports no access or quota: retried in %d minutes' % (info['label'], minutes))
                return 'retry', self.now + timedelta(minutes=minutes)
            return 'retry', None
        key = self.key(info)
        target = self.claims().prepare_folder(key)
        pr.stage(proposal_dir, files, target)
        self.log('%s: proposal staged in %s - a human publishes it, then promotes or rejects it:' % (info['label'], target))
        for c in self.claims().publish_commands(key, info['label']):
            say('  %s' % c)
        return 'done', None

    def handle(self, rev):
        """('done' | 'deferred' | 'retry' | 'needs-claim', until or None)."""
        info, cls, d = self.decide(rev)
        if info is None:
            self.log('%s: not in this working copy, ignored' % rev)
            return 'done', None
        self.log('%s by %s: %s -> %s (%s)' % (info['label'], info['author'], cls.kind, d.action, d.reason))
        if d.action == 'wait-grace':
            return 'deferred', d.wait_until
        if d.action in ('skip-tests-only', 'skip-untestable'):
            return 'done', None
        if d.action == 'continue-draft' and self.staged(info):
            self.log('%s: a proposal is staged in %s, waiting for a human to publish it'
                     % (info['label'], self.claims().folder(self.key(info))))
            return 'done', None
        if d.run_suite and not self.dry_run:
            status = self.run_suite_once()['status']
            if status in ('busy', 'missing-here'):
                self.log('%s: suite %s (%s) - retried later' % (info['label'], status, self.suite_result['reason']))
                return 'retry', None
            if status == 'no-suite':
                self.log('%s: the line has no suite - not analysed' % info['label'])
                return 'done', None
        if d.action == 'claim':
            if self.dry_run:
                return self.draft(info, cls)
            if not self.claim_ok:
                self.log('%s: claim needed - run with --claim to take it' % info['label'])
                return 'needs-claim', None
            body = cl.claim_text(info['label'], self.cfg['me'], info['author'], self.cfg['machine'], self.now)
            outcome, detail = self.claims().claim(self.key(info), body, 'claim %s by %s for %s'
                                                  % (info['label'], self.cfg['me'], info['author']),
                                                  self.cfg['me'], self.cfg['machine'])
            self.log('%s: claim %s (%s)' % (info['label'], outcome, detail))
            if outcome == 'lost':
                return 'done', None
            if outcome != 'won':
                return 'retry', None
            return self.draft(info, cls)
        if d.action == 'continue-draft':
            return self.draft(info, cls)
        return 'done', None

    # --- state and polling
    def load_state(self):
        if os.path.exists(self.state_file):
            with open(self.state_file, 'r', encoding='utf-8') as fh:
                return json.load(fh)
        return {'last': None, 'queue': {}}

    def save_state(self, state):
        if not self.dry_run:
            bl.write_json_atomic(self.state_file, state)

    def apply(self, state, rev, outcome, until):
        q = state.setdefault('queue', {})
        k = str(rev)
        if outcome == 'done':
            q.pop(k, None)
            return
        if outcome == 'retry' and until is None:
            until = self.now + timedelta(minutes=int(self.cfg['watch']['retryMinutes']))
        q[k] = {'rev': rev, 'status': outcome, 'until': until.isoformat() if until else None}

    def one(self, rev):
        state = self.load_state()
        outcome, until = self.handle(rev)
        self.apply(state, rev, outcome, until)
        self.save_state(state)
        return 0

    def poll(self):
        w = self.cfg['watch']
        if w['fetchRemote'] and self.wc.kind == 'git':
            vrun(['git', '-C', self.wc.root, 'fetch', '-q', w['fetchRemote']])
        state = self.load_state()
        head = self.wc.head(w['ref'])
        if state.get('last') in (None, ''):
            state['last'] = head
            self.log('initialised at %s (no backfill)' % WorkingCopy.label(self.wc.kind, head))
            self.save_state(state)
            return 0
        due = []
        for k, item in sorted(state.get('queue', {}).items()):
            if item['status'] == 'needs-claim':
                if self.claim_ok:
                    due.append(item['rev'])
            elif not item.get('until') or parse_time(item['until']) <= self.now:
                due.append(item['rev'])
        new = [r for r in self.wc.revisions_after(state['last'], w['ref']) if str(r) not in state.get('queue', {})]
        failures = 0
        for rev in due + new:
            try:
                outcome, until = self.handle(rev)
            except (VcsError, OSError, ValueError) as exc:
                self.log('%s: FAILED, retried later: %s' % (rev, exc))
                outcome, until, failures = 'retry', None, failures + 1
            self.apply(state, rev, outcome, until)
            self.save_state(state)
        state['last'] = head
        self.save_state(state)
        return 1 if failures else 0


def cmd_watch(cfg, wc, args):
    w = Watch(cfg, wc, utc_now(args.now), claim_ok=args.claim, dry_run=args.dry_run)
    lock = None
    if not args.dry_run:
        lock = rn.FileLock(os.path.join(cfg['stateDir'], 'watch.lock'))
        if not lock.acquire(0):
            say('busy: another watch of line %s holds %s - nothing done; the next poll picks it up'
                % (cfg['line'], lock.path))
            return EXIT_WATCH_BUSY
    try:
        if args.poll:
            return w.poll()
        return w.one(_rev(wc, args.rev))
    finally:
        if lock is not None:
            lock.release()


def cmd_decide(cfg, wc, args):
    w = Watch(cfg, wc, utc_now(args.now), dry_run=True)
    info, cls, d = w.decide(_rev(wc, args.rev))
    if info is None:
        say('%s: not in this working copy' % args.rev)
        return 1
    out = {'revision': info['label'], 'author': info['author'], 'kind': cls.kind, 'action': d.action,
           'runSuite': d.run_suite, 'claim': d.claim, 'reason': d.reason,
           'waitUntil': d.wait_until.isoformat() if d.wait_until else None}
    say(json.dumps(out, indent=2) if args.json else
        '%(revision)s by %(author)s: %(kind)s -> %(action)s (%(reason)s)' % out)
    return 0


def cmd_classify(cfg, wc, args):
    if args.paths:
        paths, label = args.paths, 'paths'
    else:
        if wc is None:
            raise ConfigError('classify --rev needs a working copy')
        info = wc.revision_info(_rev(wc, args.rev))
        if info is None:
            say('%s: not in this working copy' % args.rev)
            return 1
        paths, label = info['paths'], info['label']
    c = dc.classify(paths, cfg['paths']['tests'], cfg['paths']['untestable'])
    say('%s: %s' % (label, c.kind))
    for group in ('code', 'tests', 'untestable'):
        for p in getattr(c, group):
            say('  %-10s %s' % (group, p))
    return 0


def cmd_claims(cfg, wc, args):
    now = utc_now(args.now)
    days = int(cfg['watch']['staleClaimDays'])
    rows = cl.open_claims(wc.kind, cfg['stateDir'], cfg['claim'], wc).list()
    for c in rows:
        stale = ''
        if not c.get('has_report') and c.get('claimed'):
            try:
                if now - parse_time(c['claimed']) >= timedelta(days=days):
                    stale = ' STALE'
            except ValueError:
                pass
        say('%s claimed by %s (%s) for %s at %s - report %s%s'
            % (c['key'], c['claimer'], c['machine'], c['for'], c['claimed'],
               'yes' if c.get('has_report') else 'no', stale))
    say('%d claim(s)' % len(rows))
    return 0


def cmd_proposal(cfg, wc, args):
    rev = _rev(wc, args.rev)
    info = wc.revision_info(rev)
    labels = {str(rev)} | ({info['label'], str(info['rev'])} if info else set())
    folder = args.dir or pr.work_dirs(cfg['stateDir'], cl.claim_key(wc.kind, info['rev'] if info else rev))[1]
    p = cfg['proposal']
    ok, files, reasons = pr.check_proposal(folder, labels, p['draftPattern'], p['forbidden'])
    for r in reasons:
        say('refused: %s' % r)
    say('%s: %s (%s)' % (folder, 'accepted' if ok else 'not accepted', ', '.join(files) or 'no file'))
    return 0 if ok else 1


# ---------------------------------------------------------------- main

def build_parser():
    ap = argparse.ArgumentParser(description='Suite runs, baseline gate, commit door and commit watcher '
                                             '(engine-kit runtime)')
    ap.add_argument('--config', required=True, help='testing.json of the suite and line')
    ap.add_argument('--me', help='this machine\'s VCS user (overrides the config)')
    ap.add_argument('--state-dir', help='per-machine state folder of the line (overrides the config)')
    sub = ap.add_subparsers(dest='command')
    sub.required = True

    r = sub.add_parser('run', help='run the suite, check its evidence, print the split against the baseline')
    r.add_argument('--out', help='where to write suite.json (default: beside the log)')
    r.add_argument('--log', help='where to write the command output')
    r.add_argument('--expect-red', action='append', metavar='TEST', help='must fail by an assertion (repeatable)')
    for name, what in (('before', 'tests found before the change'), ('added', 'tests the change adds'),
                       ('replaced', 'tests the change replaces or removes')):
        r.add_argument('--' + name, action='append', metavar='N|PART=N', help='%s (reconcile; repeatable per part)' % what)

    b = sub.add_parser('baseline', help='record, compare or show the baseline')
    b.add_argument('action', choices=('record', 'compare', 'show'))
    b.add_argument('--result', help='a suite.json from `run` (default: run the suite now)')
    b.add_argument('--source', default='manual', help='who records (record; the watcher writes "watcher")')
    b.add_argument('--json', action='store_true', help='compare: the comparison as JSON')

    k = sub.add_parser('precommit', help='the commit door: warnings (warn) or the gated suite run (block)')
    k.add_argument('--paths', nargs='+', help='the committed paths (default: the local changes)')
    k.add_argument('--for', dest='for_rev', action='append', metavar='REV',
                   help='the revision these tests cover: warn on someone else\'s claim (repeatable)')
    k.add_argument('--warn-only', action='store_true',
                   help='force gate.mode warn whatever the config says (the plugin hook, EK#14)')

    c = sub.add_parser('classify', help='classify a revision by its paths')
    g = c.add_mutually_exclusive_group(required=True)
    g.add_argument('--rev')
    g.add_argument('--paths', nargs='+')

    d = sub.add_parser('decide', help='print the watch decision for a revision (no action)')
    d.add_argument('--rev', required=True)
    d.add_argument('--now', help='ISO time to judge the grace period at (default: now)')
    d.add_argument('--json', action='store_true')

    w = sub.add_parser('watch', help='act on one revision or poll for new ones')
    g = w.add_mutually_exclusive_group(required=True)
    g.add_argument('--rev')
    g.add_argument('--poll', action='store_true')
    w.add_argument('--claim', action='store_true', help='allow the claim commit (the only VCS write)')
    w.add_argument('--dry-run', action='store_true', help='decide and write the brief; no suite, claim, agent or state')
    w.add_argument('--now')

    k = sub.add_parser('claims', help='list the claims and flag stale ones')
    k.add_argument('--now')

    p = sub.add_parser('proposal', help='check a proposal folder')
    p.add_argument('action', choices=('check',))
    p.add_argument('--rev', required=True)
    p.add_argument('--dir', help='the proposal folder (default: <stateDir>/work/<key>/proposal)')
    return ap


NEEDS_WC = ('decide', 'watch', 'claims', 'proposal')


def main(argv=None):
    args = build_parser().parse_args(argv)
    try:
        cfg = load_config(args.config, args.me, args.state_dir)
        wc = None
        try:
            wc = WorkingCopy(cfg['workingCopy'], cfg['vcs'])
        except VcsError as exc:
            if args.command in NEEDS_WC or (args.command == 'baseline' and args.action == 'record'):
                raise
            say('note: %s - the run carries no working-copy state' % exc)
        handlers = {'run': cmd_run, 'baseline': cmd_baseline, 'precommit': cmd_precommit, 'classify': cmd_classify,
                    'decide': cmd_decide, 'watch': cmd_watch, 'claims': cmd_claims, 'proposal': cmd_proposal}
        return handlers[args.command](cfg, wc, args)
    except (ConfigError, VcsError, bl.BaselineError) as exc:
        print('error: %s' % exc, file=sys.stderr)
        return 2


if __name__ == '__main__':
    sys.exit(main())
