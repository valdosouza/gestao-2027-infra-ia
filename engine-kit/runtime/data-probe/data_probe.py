#!/usr/bin/env python3
"""data_probe - run a read-only query against a configured database target; print capped rows.

The data step of a legacy assessment or a diagnosis (technique T94 of the engine-kit): what
the data says, without any chance of changing it. Python 3.8+, standard library only. The
database driver is pluggable and the kit installs none:

  sqlite  the sqlite3 module that ships with Python (opened read-only by URI)
  dbapi   any DB-API 2.0 module the case installed (named in the configuration)
  cli     the engine's own command-line client, SQL on its standard input

Before anything is sent, the text passes sql_guard.check_read_only (write, DDL and session
words refused; comments and literals fool it in neither direction). Then the session is
proven read-only once: the target's configured test write must be REFUSED by the database,
for the expected reason. Rows are capped. Credentials never appear on a command line or in
a file: they come from the environment (the child client inherits it; a DB-API connect
argument is read from a named variable) or from integrated authentication. Output files are
refused inside the kit.

Exit codes: 0 ran | 1 the database or the client failed | 2 usage or configuration error
| 3 refused by the read-only guard (nothing was sent) | 4 the session is not proven
read-only (the test write was accepted, or refused for another reason; no query ran).

Usage (contract: runtime/data-probe/README.md):
  python data_probe.py --config FILE --target NAME (--query SQL | --file FILE)
         [--max-rows N] [--format text|json|csv] [--out FILE] [--timeout S]
  python data_probe.py --check [--config FILE --target NAME] (--query SQL | --file FILE)
  python data_probe.py --prove --config FILE --target NAME
  python data_probe.py --allow-write --config FILE --target NAME ...   (disposable targets only)
"""

import argparse
import csv
import datetime
import decimal
import hashlib
import importlib
import io
import json
import os
import pathlib
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
if HERE not in sys.path:
    sys.path.insert(0, HERE)

import sql_guard  # noqa: E402

KIT_ROOT = os.path.dirname(os.path.dirname(HERE))

EXIT_OK, EXIT_DATABASE, EXIT_USAGE, EXIT_REFUSED, EXIT_NOT_PROVEN = 0, 1, 2, 3, 4
DEFAULT_MAX_ROWS = 200
DEFAULT_TIMEOUT = 120
DEFAULT_EXPECT = r'(?i)read[-_ ]?only'
ADAPTERS = ('sqlite', 'dbapi', 'cli')

# The sqlite adapter knows its engine; its lexical options and its test write are built in.
SQLITE_LEXICAL = {
    'nested_block_comments': False, 'backslash_escapes': False, 'escape_string_prefix': False,
    'dash_comment_needs_space': False, 'hash_comments': False, 'executable_comments': False,
    'dollar_quotes': False, 'bracket_identifiers': True, 'backtick_identifiers': True,
}
SQLITE_PROOF = {'statement': 'CREATE TABLE main.data_probe_read_only_check (x INTEGER)',
                'expect_error': DEFAULT_EXPECT}

SECRET_KEY_RE = re.compile(r'(?i)^(password|passwd|pwd|pass|passphrase|secret|client_secret|token|access_token|'
                           r'auth_token|api_?key|credentials?|private_?key)$')
SECRET_VALUE_RES = (re.compile(r'(?i)\b(password|passwd|pwd)\s*[=:]'),   # key=value connection strings
                    re.compile(r'://[^/\s:@]+:[^/\s@]+@'))                # user:password@ in a URL
ENV_NAME_RE = re.compile(r'^[A-Za-z_][A-Za-z0-9_]*$')


class UsageError(Exception):
    """Exit 2: the command line or the configuration is wrong."""


class DatabaseError(Exception):
    """Exit 1: the database or the client reported an error, or timed out."""


class NotProven(Exception):
    """Exit 4: the session could not be shown to be read-only."""


# ------------------------------------------------------------------ configuration

def inside_kit(path):
    try:
        return os.path.normcase(os.path.commonpath([os.path.abspath(path), KIT_ROOT])) == os.path.normcase(KIT_ROOT)
    except ValueError:  # another drive
        return False


def scan_secrets(value, where, problems, in_env_map=False):
    """Literal secrets in the configuration: a secret-named key with a value, or a string that
    carries one (password=..., user:password@host)."""
    if isinstance(value, dict):
        for key, item in value.items():
            path = '%s.%s' % (where, key)
            if key.startswith('_'):
                continue
            if not in_env_map and SECRET_KEY_RE.match(str(key)) and item not in (None, ''):
                problems.append('%s holds a secret' % path)
                continue
            scan_secrets(item, path, problems, in_env_map or key == 'connect_env')
    elif isinstance(value, list):
        for index, item in enumerate(value):
            scan_secrets(item, '%s[%d]' % (where, index), problems, in_env_map)
    elif isinstance(value, str) and not in_env_map:
        if any(rx.search(value) for rx in SECRET_VALUE_RES):
            problems.append('%s carries a secret in its text' % where)


def _positive_int(value, what):
    if isinstance(value, bool) or not isinstance(value, int) or value < 1:
        raise UsageError('%s must be a positive integer, not %r' % (what, value))
    return value


def validate_target(name, t):
    where = 'targets.%s' % name
    if not isinstance(t, dict):
        raise UsageError('%s must be an object' % where)
    problems = []
    scan_secrets(t, where, problems)
    if problems:
        raise UsageError('; '.join(problems) + ' - credentials come from the environment or from integrated '
                         'authentication, never from a file or a command line')
    adapter = t.get('adapter')
    if adapter not in ADAPTERS:
        raise UsageError('%s.adapter must be one of %s, not %r' % (where, ', '.join(ADAPTERS), adapter))
    if adapter == 'sqlite':
        if not isinstance(t.get('database'), str) or not t['database']:
            raise UsageError('%s.database must name the database file' % where)
        if t.get('open_mode', 'ro') not in ('ro', 'rw'):
            raise UsageError('%s.open_mode must be "ro" or "rw"' % where)
    elif adapter == 'dbapi':
        if not isinstance(t.get('module'), str) or not t['module']:
            raise UsageError('%s.module must name the DB-API module the case installed' % where)
        if not isinstance(t.get('connect', {}), dict):
            raise UsageError('%s.connect must be an object of connect() arguments' % where)
        env_map = t.get('connect_env', {})
        if not isinstance(env_map, dict) or not all(ENV_NAME_RE.match(str(v)) for v in env_map.values()):
            raise UsageError('%s.connect_env maps a connect() argument to the NAME of an environment variable' % where)
    else:
        command = t.get('command')
        if not isinstance(command, list) or not command or not all(isinstance(a, str) and a for a in command):
            raise UsageError('%s.command must be a non-empty list of strings (no shell)' % where)
        if t.get('input', 'stdin') not in ('stdin', 'file'):
            raise UsageError('%s.input must be "stdin" or "file"' % where)
        if t.get('input') == 'file' and not any('{file}' in a for a in command):
            raise UsageError('%s: input "file" needs a {file} placeholder in the command' % where)
        if t.get('output', 'raw') not in ('raw', 'csv', 'tsv'):
            raise UsageError('%s.output must be "raw", "csv" or "tsv"' % where)
    for key in ('session_prelude',):
        if key in t and not isinstance(t[key], str):
            raise UsageError('%s.%s must be a string' % (where, key))
    proof = t.get('read_only_proof')
    if proof is not None:
        if not isinstance(proof, dict) or not isinstance(proof.get('statement'), str) or not proof['statement'].strip():
            raise UsageError('%s.read_only_proof needs a "statement": a write that changes nothing even if it ran' % where)
        try:
            re.compile(proof.get('expect_error', DEFAULT_EXPECT))
        except re.error as exc:
            raise UsageError('%s.read_only_proof.expect_error is not a regular expression: %s' % (where, exc))
    try:
        sql_guard.normalise_lexical(t.get('lexical'))
    except sql_guard.LexicalError as exc:
        raise UsageError('%s.lexical: %s' % (where, exc))
    leads = t.get('allow_leading', [])
    if not isinstance(leads, list) or not all(isinstance(w, str) and re.match(r'^\w+$', w) for w in leads):
        raise UsageError('%s.allow_leading must be a list of single words' % where)
    if 'timeout_seconds' in t:
        _positive_int(t['timeout_seconds'], where + '.timeout_seconds')
    if not isinstance(t.get('disposable', False), bool):
        raise UsageError('%s.disposable must be true or false' % where)


def load_config(path):
    try:
        with open(path, 'r', encoding='utf-8-sig') as handle:
            data = json.load(handle)
    except (OSError, ValueError) as exc:
        raise UsageError('cannot read the configuration %s: %s' % (path, exc))
    if not isinstance(data, dict) or not isinstance(data.get('targets'), dict) or not data['targets']:
        raise UsageError('the configuration needs a non-empty "targets" object')
    if 'max_rows' in data:
        _positive_int(data['max_rows'], 'max_rows')
    if not isinstance(data.get('require_proof', False), bool):
        raise UsageError('require_proof must be true or false')
    for name, target in data['targets'].items():
        if not name.startswith('_'):
            validate_target(name, target)
    return data


def lexical_of(target):
    base = dict(SQLITE_LEXICAL) if target.get('adapter') == 'sqlite' else {}
    base.update({k: v for k, v in (target.get('lexical') or {}).items() if not k.startswith('_')})
    return base


# ------------------------------------------------------------------ adapters

def _first_lines(text, count=3):
    lines = [l.strip() for l in (text or '').splitlines() if l.strip()]
    return ' | '.join(lines[:count]) or '(no output)'


def _judge_refusal(message, expect):
    if re.search(expect, message or ''):
        return _first_lines(message, 1)
    raise NotProven('the test write failed for another reason than a read-only refusal: %s' % _first_lines(message))


class _DbapiLike(object):
    """Shared by the sqlite and dbapi adapters: one connection, statements one at a time."""

    error_types = (Exception,)

    def __init__(self, target, statements_of):
        self.target = target
        self.statements_of = statements_of
        self.conn = None

    def prelude(self):
        for statement in self.statements_of(self.target.get('session_prelude', '')):
            self._execute(statement)

    def _execute(self, statement):
        cur = self.conn.cursor()
        try:
            cur.execute(statement)
        except self.error_types as exc:
            raise DatabaseError(str(exc))
        return cur

    def prove(self, proof):
        cur = self.conn.cursor()
        try:
            self._before_proof(cur)
            cur.execute(proof['statement'])
        except self.error_types as exc:
            self._rollback()
            return _judge_refusal(str(exc), proof.get('expect_error', DEFAULT_EXPECT))
        self._rollback()
        raise NotProven('the database ACCEPTED the test write (rolled back): this session is not read-only')

    def _before_proof(self, cur):
        pass

    def _rollback(self):
        try:
            self.conn.rollback()
        except self.error_types:
            pass

    def run(self, text, max_rows):
        results = []
        for statement in self.statements_of(text):
            cur = self._execute(statement)
            if cur.description:
                columns = [d[0] for d in cur.description]
                try:
                    rows = cur.fetchmany(max_rows + 1)
                except self.error_types as exc:
                    raise DatabaseError(str(exc))
                results.append({'columns': columns, 'rows': [list(r) for r in rows[:max_rows]],
                                'truncated': len(rows) > max_rows})
            else:
                results.append({'columns': None, 'rows': [], 'truncated': False})
        return results

    def close(self, commit):
        if self.conn is None:
            return
        try:
            if commit:
                self.conn.commit()
            else:
                self._rollback()
        finally:
            self.conn.close()


class SqliteAdapter(_DbapiLike):
    def __init__(self, target, statements_of, write, timeout):
        super(SqliteAdapter, self).__init__(target, statements_of)
        import sqlite3
        self.error_types = (sqlite3.Error,)
        path = os.path.abspath(target['database'])
        mode = 'rw' if write or target.get('open_mode') == 'rw' else 'ro'
        if not os.path.isfile(path):
            raise DatabaseError('database file not found: %s' % path)
        uri = '%s?mode=%s' % (pathlib.Path(path).as_uri(), mode)
        try:
            self.conn = sqlite3.connect(uri, uri=True, timeout=timeout, isolation_level=None)
        except sqlite3.Error as exc:
            raise DatabaseError(str(exc))

    def _before_proof(self, cur):
        cur.execute('BEGIN')  # the test write, if accepted, is rolled back

    def _rollback(self):
        try:
            if self.conn.in_transaction:
                self.conn.execute('ROLLBACK')
        except self.error_types:
            pass

    def close(self, commit):
        try:
            if self.conn is not None and self.conn.in_transaction:
                self.conn.execute('COMMIT' if commit else 'ROLLBACK')
        finally:
            if self.conn is not None:
                self.conn.close()


class DbapiAdapter(_DbapiLike):
    def __init__(self, target, statements_of, write, timeout):
        super(DbapiAdapter, self).__init__(target, statements_of)
        try:
            module = importlib.import_module(target['module'])
        except ImportError as exc:
            raise UsageError('the DB-API module %r is not installed (%s): the case installs its driver, '
                             'the kit installs none' % (target['module'], exc))
        self.error_types = (getattr(module, 'Error', Exception),)
        kwargs = dict(target.get('connect') or {})
        for argument, variable in (target.get('connect_env') or {}).items():
            if variable not in os.environ:
                raise UsageError('environment variable %s is not set (connect argument %s)' % (variable, argument))
            kwargs[argument] = os.environ[variable]
        try:
            self.conn = module.connect(**kwargs)
        except Exception as exc:  # the driver's own error types differ
            raise DatabaseError('connect failed: %s' % exc)


class CliAdapter(object):
    """The engine's own client: one process per call, the SQL on its standard input (or in a
    temporary file), the environment inherited - never a secret on its command line."""

    def __init__(self, target, statements_of, write, timeout):
        self.target = target
        self.timeout = timeout
        self.encoding = target.get('encoding', 'utf-8')

    def _invoke(self, sql):
        command, temp, stdin = list(self.target['command']), None, sql
        if self.target.get('input') == 'file':
            handle, temp = tempfile.mkstemp(suffix='.sql', prefix='data-probe-')
            with os.fdopen(handle, 'w', encoding=self.encoding, newline='\n') as out:
                out.write(sql)
            command, stdin = [a.replace('{file}', temp) for a in command], ''
        try:
            done = subprocess.run(command, input=stdin.encode(self.encoding), stdout=subprocess.PIPE,
                                  stderr=subprocess.PIPE, timeout=self.timeout)
        except FileNotFoundError:
            raise UsageError('client not found: %s' % command[0])
        except subprocess.TimeoutExpired:
            raise DatabaseError('the client timed out after %d s' % self.timeout)
        finally:
            if temp:
                os.remove(temp)
        return (done.returncode, done.stdout.decode(self.encoding, 'replace'),
                done.stderr.decode(self.encoding, 'replace'))

    def _with_prelude(self, sql):
        prelude = self.target.get('session_prelude', '')
        return (prelude + '\n' + sql + '\n') if prelude else sql + '\n'

    def prelude(self):
        pass  # sent with every call

    def prove(self, proof):
        code, out, err = self._invoke(self._with_prelude(proof['statement']))
        expect, combined = proof.get('expect_error', DEFAULT_EXPECT), out + '\n' + err
        hits = [l.strip() for l in combined.splitlines() if re.search(expect, l)]
        if hits:
            return hits[0]
        if re.search(expect, combined):  # a pattern that spans lines
            return _first_lines(combined, 1)
        if code == 0:
            raise NotProven('the client ran the test write and showed no refusal: this session is not read-only (%s)'
                            % _first_lines(out + '\n' + err))
        raise NotProven('the test write failed for another reason than a read-only refusal (exit %d): %s'
                        % (code, _first_lines(err or out)))

    def run(self, text, max_rows):
        code, out, err = self._invoke(self._with_prelude(text))
        if code != 0:
            raise DatabaseError('the client exited with %d: %s' % (code, _first_lines(err or out, 5)))
        fmt = self.target.get('output', 'raw')
        if fmt == 'raw':
            lines = out.splitlines()
            return [{'columns': None, 'rows': [[l] for l in lines[:max_rows]], 'truncated': len(lines) > max_rows,
                     'raw': True}]
        rows = [r for r in csv.reader(io.StringIO(out), delimiter=',' if fmt == 'csv' else '\t') if r]
        if not rows:
            return [{'columns': None, 'rows': [], 'truncated': False}]
        body = rows[1:]
        return [{'columns': rows[0], 'rows': body[:max_rows], 'truncated': len(body) > max_rows}]

    def close(self, commit):
        pass


def open_adapter(target, write, timeout):
    lexical = lexical_of(target)

    def statements_of(text):
        return [text[a:b] for a, b in sql_guard.split_statements(text, lexical)] if text.strip() else []

    cls = {'sqlite': SqliteAdapter, 'dbapi': DbapiAdapter, 'cli': CliAdapter}[target['adapter']]
    return cls(target, statements_of, write, timeout)


# ------------------------------------------------------------------ output

def _plain(value):
    if value is None or isinstance(value, (bool, int, float, str)):
        return value
    if isinstance(value, (bytes, bytearray, memoryview)):
        return '0x' + bytes(value).hex()
    if isinstance(value, decimal.Decimal):
        return str(value)
    if isinstance(value, (datetime.date, datetime.time)):
        return value.isoformat()
    return str(value)


def _cell(value, width=60):
    text = 'NULL' if value is None else str(_plain(value))
    text = ' '.join(text.split()) if ('\n' in text or '\r' in text or '\t' in text) else text
    return text if len(text) <= width else text[:width - 3] + '...'


def render_text(report):
    lines = ['target: %s (%s) | read-only session: %s' % (report['target'], report['adapter'], report['session_line']),
             'query: sha256 %s | %d statement(s) | %s' % (report['query_sha256'][:16], report['statements'],
                                                          report['ran_at'])]
    for index, res in enumerate(report['results'], 1):
        shown = len(res['rows'])
        cap = (' shown - TRUNCATED at the cap of %d, more exist' % report['max_rows']) if res['truncated'] else ''
        if res.get('raw'):
            lines.append('-- result %d: %d line(s)%s' % (index, shown, cap))
            lines.extend(r[0] for r in res['rows'])
            continue
        if res['columns'] is None:
            lines.append('-- result %d: no result set' % index)
            continue
        lines.append('-- result %d: %d row(s)%s' % (index, shown, cap))
        table = [[_cell(c) for c in res['columns']]] + [[_cell(v) for v in row] for row in res['rows']]
        widths = [max(len(r[i]) if i < len(r) else 0 for r in table) for i in range(len(table[0]))]
        for number, row in enumerate(table):
            lines.append(' | '.join(c.ljust(widths[i]) for i, c in enumerate(row)).rstrip())
            if number == 0:
                lines.append('-+-'.join('-' * w for w in widths))
    return '\n'.join(lines) + '\n'


def render_json(report):
    out = {k: report[k] for k in ('target', 'adapter', 'ran_at', 'query_sha256', 'query_file', 'statements',
                                  'max_rows', 'write_allowed')}
    out['read_only_session'] = report['session']
    out['results'] = [{'result': i, 'columns': r['columns'], 'rows': [[_plain(v) for v in row] for row in r['rows']],
                       'rows_shown': len(r['rows']), 'truncated': r['truncated']}
                      for i, r in enumerate(report['results'], 1)]
    return json.dumps(out, indent=1, ensure_ascii=True) + '\n'


def render_csv(report):
    sets = [r for r in report['results'] if r['columns'] is not None]
    if len(sets) != 1:
        raise UsageError('csv takes exactly one result set (got %d): use --format json' % len(sets))
    buf = io.StringIO()
    writer = csv.writer(buf, lineterminator='\n')
    writer.writerow(sets[0]['columns'])
    for row in sets[0]['rows']:
        writer.writerow(['' if v is None else _plain(v) for v in row])
    return buf.getvalue()


# ------------------------------------------------------------------ main

def parse_args(argv):
    ap = argparse.ArgumentParser(description='Run a read-only query against a configured target; rows capped.')
    ap.add_argument('--config', help='the case configuration (JSON), kept outside the kit')
    ap.add_argument('--target', help='a target name from the configuration')
    src = ap.add_mutually_exclusive_group()
    src.add_argument('--query', help='the SQL text')
    src.add_argument('--file', help='a file holding the SQL text (keep it with the evidence)')
    mode = ap.add_mutually_exclusive_group()
    mode.add_argument('--check', action='store_true', help='only run the read-only guard; connect to nothing')
    mode.add_argument('--prove', action='store_true', help='only prove the session read-only (the test write)')
    mode.add_argument('--allow-write', action='store_true',
                      help='bypass the guard and the proof - only for a target marked "disposable": true')
    ap.add_argument('--max-rows', type=int, help='row cap per result (default: the configuration, else %d)' % DEFAULT_MAX_ROWS)
    ap.add_argument('--format', choices=('text', 'json', 'csv'), default='text')
    ap.add_argument('--out', help='write the result to this file (refused inside the kit)')
    ap.add_argument('--timeout', type=int, help='seconds (default: the target, else %d)' % DEFAULT_TIMEOUT)
    return ap.parse_args(argv)


def read_query(args):
    if args.query is not None:
        return args.query, None
    if args.file:
        try:
            with open(args.file, 'r', encoding='utf-8-sig') as handle:
                return handle.read(), os.path.abspath(args.file)
        except OSError as exc:
            raise UsageError('cannot read %s: %s' % (args.file, exc))
    raise UsageError('give the SQL with --query or --file')


def execute(args):
    config, target = None, None
    if args.config:
        config = load_config(args.config)
        if args.target:
            target = config['targets'].get(args.target)
            if target is None or args.target.startswith('_'):
                raise UsageError('no target %r in %s (targets: %s)' % (
                    args.target, args.config, ', '.join(n for n in config['targets'] if not n.startswith('_'))))
    if not args.check and target is None:
        raise UsageError('give --config and --target')
    if args.out and inside_kit(args.out):
        raise UsageError('--out %s is inside the kit; write case output elsewhere' % args.out)
    if args.max_rows is not None:
        _positive_int(args.max_rows, '--max-rows')
    if args.timeout is not None:
        _positive_int(args.timeout, '--timeout')

    if args.prove:
        text, query_file = '', None
    else:
        text, query_file = read_query(args)

    lexical = lexical_of(target) if target else {}
    leads = (target or {}).get('allow_leading', [])
    verdict = None
    if not args.allow_write and not args.prove:
        verdict = sql_guard.check_read_only(text, lexical, leads)
        if not verdict.read_only:
            print('REFUSED by the read-only guard - nothing was sent:', file=sys.stderr)
            for reason in verdict.reasons():
                print('  - ' + reason, file=sys.stderr)
            print('  (a write runs on a disposable copy with --allow-write, or is prepared for a human; '
                  'see runtime/data-probe/README.md)', file=sys.stderr)
            return EXIT_REFUSED
        if args.check:
            print('read-only: yes - %d statement(s), %d lexing(s) checked' % (len(verdict.statements), verdict.variants))
            return EXIT_OK

    if args.allow_write:
        if not target.get('disposable'):
            raise UsageError('--allow-write needs a target marked "disposable": true; a shared database is written '
                             'by a human with a prepared script (prepare-only)')
        print('WARNING: --allow-write - the read-only guard and the proof are bypassed on the disposable target %r'
              % args.target, file=sys.stderr)

    if args.format == 'csv' and verdict is not None and len(verdict.statements) != 1:
        raise UsageError('csv takes exactly one statement (got %d): use --format json' % len(verdict.statements))

    max_rows = args.max_rows or config.get('max_rows', DEFAULT_MAX_ROWS)
    timeout = args.timeout or target.get('timeout_seconds', DEFAULT_TIMEOUT)
    proof = target.get('read_only_proof') or (SQLITE_PROOF if target['adapter'] == 'sqlite' else None)
    if proof is None and not args.allow_write and (args.prove or config.get('require_proof')):
        raise UsageError('target %r has no read_only_proof (a write that changes nothing even if it ran, and the '
                         'refusal text expected)' % args.target)

    adapter = open_adapter(target, args.allow_write, timeout)
    committed = False
    try:
        if args.allow_write:
            session = {'proven': False, 'detail': 'not checked: writes allowed on a disposable target'}
        else:
            adapter.prelude()
            if proof is None:
                session = {'proven': False, 'detail': 'NOT PROVEN - no read_only_proof for this target'}
                print('WARNING: read-only session not proven: the target has no read_only_proof', file=sys.stderr)
            else:
                try:
                    refusal = adapter.prove(proof)
                except NotProven as exc:
                    print('NOT PROVEN: %s - no query was run' % exc, file=sys.stderr)
                    return EXIT_NOT_PROVEN
                session = {'proven': True, 'detail': 'the database refused the test write: %s' % refusal}
        if args.prove:
            print('read-only session of %r: proven - %s' % (args.target, session['detail']))
            return EXIT_OK
        results = adapter.run(text, max_rows)
        committed = bool(args.allow_write)
    finally:
        adapter.close(commit=committed)

    report = {
        'target': args.target, 'adapter': target['adapter'],
        'ran_at': datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0).isoformat(),
        'query_sha256': hashlib.sha256(text.encode('utf-8')).hexdigest(), 'query_file': query_file,
        'statements': len(verdict.statements) if verdict else len(results), 'max_rows': max_rows,
        'write_allowed': bool(args.allow_write), 'session': session,
        'session_line': ('proven - ' + session['detail']) if session['proven'] else session['detail'],
        'results': results,
    }
    body = {'text': render_text, 'json': render_json, 'csv': render_csv}[args.format](report)
    if args.out:
        folder = os.path.dirname(os.path.abspath(args.out))
        os.makedirs(folder, exist_ok=True)
        with open(args.out, 'w', encoding='utf-8', newline='\n') as handle:
            handle.write(body)
        truncated = sum(1 for r in report['results'] if r['truncated'])
        print('wrote %s - %d result(s), %d truncated at %d row(s)' % (args.out, len(results), truncated, max_rows))
    else:
        sys.stdout.write(body)
    return EXIT_OK


def main(argv=None):
    if hasattr(sys.stdout, 'reconfigure'):
        try:
            sys.stdout.reconfigure(errors='replace')
        except (ValueError, OSError):
            pass
    args = parse_args(argv)
    try:
        return execute(args)
    except UsageError as exc:
        print('error: %s' % exc, file=sys.stderr)
        return EXIT_USAGE
    except DatabaseError as exc:
        print('database error: %s' % exc, file=sys.stderr)
        return EXIT_DATABASE


if __name__ == '__main__':
    sys.exit(main())
