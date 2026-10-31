"""End-to-end tests of data_probe.py: the sqlite adapter against a throwaway database, the
dbapi adapter through the sqlite3 module, and the cli adapter through a fake client written
in Python. Every scratch file lives under the system temporary folder and is removed
afterwards; nothing reads or writes inside the kit or touches a real database.

Run from runtime/data-probe: python -m unittest discover -s tests
"""

import contextlib
import io
import json
import os
import shutil
import sqlite3
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))

import data_probe as dp  # noqa: E402

FAKE_CLIENT = r'''
import os, sys
sql = sys.stdin.read()
with open(os.environ["FAKE_CLIENT_LOG"], "a", encoding="utf-8") as log:
    log.write("ARGV " + " ".join(sys.argv[1:]) + "\n")
    log.write("ENV " + os.environ.get("FAKE_CLIENT_SECRET", "") + "\n")
    log.write("SQL " + sql.replace("\n", " ") + "\n")
mode = os.environ.get("FAKE_CLIENT_MODE", "readonly")
if "WHERE 1 = 0" in sql:
    if mode == "readonly":
        print("ERROR:  cannot execute UPDATE in a read-only transaction", file=sys.stderr)
        sys.exit(1)
    if mode == "accepts":
        print("UPDATE 0")
        sys.exit(0)
    print("ERROR:  relation orders does not exist", file=sys.stderr)
    sys.exit(1)
if "broken" in sql:
    print("ERROR:  syntax error at or near broken", file=sys.stderr)
    sys.exit(3)
print("id,name")
for i in range(1, 6):
    print("%d,item %d" % (i, i))
'''


def run_cli(argv):
    out, err = io.StringIO(), io.StringIO()
    with contextlib.redirect_stdout(out), contextlib.redirect_stderr(err):
        code = dp.main(argv)
    return code, out.getvalue(), err.getvalue()


class Scratch(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='data-probe-test-')
        self.addCleanup(shutil.rmtree, self.tmp, True)
        self.db = os.path.join(self.tmp, 'orders copy.db')  # a space in the path on purpose
        conn = sqlite3.connect(self.db)
        conn.execute('CREATE TABLE orders (id INTEGER PRIMARY KEY, status TEXT, note TEXT)')
        conn.executemany('INSERT INTO orders (status, note) VALUES (?, ?)',
                         [('open', 'first'), ('open', "it's -- not a comment"), ('closed', None),
                          ('open', 'fourth'), ('closed', 'fifth')])
        conn.commit()
        conn.close()
        self.scratch_db = os.path.join(self.tmp, 'scratch.db')
        shutil.copyfile(self.db, self.scratch_db)
        self.client = os.path.join(self.tmp, 'fake_client.py')
        with open(self.client, 'w', encoding='utf-8') as fh:
            fh.write(FAKE_CLIENT)
        self.log = os.path.join(self.tmp, 'client.log')
        os.environ['FAKE_CLIENT_LOG'] = self.log
        os.environ.pop('FAKE_CLIENT_MODE', None)
        self.addCleanup(os.environ.pop, 'FAKE_CLIENT_LOG', None)
        self.addCleanup(os.environ.pop, 'FAKE_CLIENT_MODE', None)
        self.config = self.write_config({
            'max_rows': 3,
            'targets': {
                'copy': {'adapter': 'sqlite', 'database': self.db},
                'writable': {'adapter': 'sqlite', 'database': self.db, 'open_mode': 'rw'},
                'scratch': {'adapter': 'sqlite', 'database': self.scratch_db, 'disposable': True},
                'driver': {'adapter': 'dbapi', 'module': 'sqlite3', 'connect_env': {'database': 'PROBE_TEST_DB'},
                           'session_prelude': 'PRAGMA query_only = ON',
                           'read_only_proof': {'statement': 'CREATE TABLE t_probe (x INTEGER)'}},
                'driver-unproven': {'adapter': 'dbapi', 'module': 'sqlite3', 'connect': {'database': self.db}},
                'client': {'adapter': 'cli', 'command': [sys.executable, self.client, '--csv'], 'output': 'csv',
                           'session_prelude': 'SET SESSION READ ONLY;',
                           'read_only_proof': {'statement': 'UPDATE orders SET status = status WHERE 1 = 0'}},
                'client-file': {'adapter': 'cli', 'command': [sys.executable, '-c',
                                'import sys; print(open(sys.argv[1]).read().strip())', '{file}'],
                                'input': 'file', 'output': 'raw'},
            },
        })

    def write_config(self, data, name='probe.json'):
        path = os.path.join(self.tmp, name)
        with open(path, 'w', encoding='utf-8') as fh:
            json.dump(data, fh)
        return path

    def count(self, db=None):
        conn = sqlite3.connect(db or self.db)
        try:
            return conn.execute('SELECT count(*) FROM orders').fetchone()[0]
        finally:
            conn.close()

    def tables(self):
        conn = sqlite3.connect(self.db)
        try:
            return sorted(r[0] for r in conn.execute("SELECT name FROM sqlite_master WHERE type = 'table'"))
        finally:
            conn.close()

    def probe(self, *argv):
        return run_cli(['--config', self.config] + list(argv))


class SqliteTarget(Scratch):
    def test_read_capped_and_proven(self):
        code, out, err = self.probe('--target', 'copy', '--query', 'SELECT id, status, note FROM orders ORDER BY id')
        self.assertEqual(code, 0, err)
        self.assertIn('read-only session: proven', out)
        self.assertIn('readonly', out)  # the database's own refusal text
        self.assertIn('3 row(s) shown - TRUNCATED at the cap of 3', out)
        self.assertIn("it's -- not a comment", out)
        self.assertNotIn('fourth', out)

    def test_max_rows_override_and_json(self):
        out_file = os.path.join(self.tmp, 'evidence', 'orders.json')
        code, out, err = self.probe('--target', 'copy', '--file', self.write_query('q.sql',
                                    'SELECT id FROM orders ORDER BY id; SELECT count(*) AS n FROM orders'),
                                    '--max-rows', '10', '--format', 'json', '--out', out_file)
        self.assertEqual(code, 0, err)
        with open(out_file, encoding='utf-8') as fh:
            data = json.load(fh)
        self.assertEqual([r['rows_shown'] for r in data['results']], [5, 1])
        self.assertEqual(data['results'][1]['rows'], [[5]])
        self.assertFalse(any(r['truncated'] for r in data['results']))
        self.assertTrue(data['read_only_session']['proven'])
        self.assertEqual(data['statements'], 2)
        self.assertEqual(len(data['query_sha256']), 64)
        self.assertTrue(data['query_file'].endswith('q.sql'))

    def write_query(self, name, sql):
        path = os.path.join(self.tmp, name)
        with open(path, 'w', encoding='utf-8') as fh:
            fh.write(sql)
        return path

    def test_csv_one_result(self):
        code, out, err = self.probe('--target', 'copy', '--query', 'SELECT id, note FROM orders WHERE id = 3',
                                    '--format', 'csv')
        self.assertEqual(code, 0, err)
        self.assertEqual(out, 'id,note\n3,\n')
        code, _, err = self.probe('--target', 'copy', '--query', 'SELECT 1; SELECT 2', '--format', 'csv')
        self.assertEqual(code, 2)
        self.assertIn('csv takes exactly one statement', err)

    def test_write_refused_before_connecting(self):
        code, _, err = self.probe('--target', 'copy', '--query', 'DELETE FROM orders')
        self.assertEqual(code, 3)
        self.assertIn('nothing was sent', err)
        self.assertEqual(self.count(), 5)
        # the guard runs before any connection: a missing database still yields 3, not 1
        missing = self.write_config({'targets': {'gone': {'adapter': 'sqlite', 'database': self.db + '.missing'}}}, 'm.json')
        code, _, _ = run_cli(['--config', missing, '--target', 'gone', '--query', 'DROP TABLE orders'])
        self.assertEqual(code, 3)

    def test_comment_marker_in_a_literal_does_not_hide_a_write(self):
        code, _, err = self.probe('--target', 'copy', '--query', "SELECT '--', 1; DELETE FROM orders")
        self.assertEqual(code, 3)
        self.assertIn("'DELETE' in statement 2", err)
        self.assertEqual(self.count(), 5)

    def test_writable_session_is_not_proven(self):
        code, out, err = self.probe('--target', 'writable', '--query', 'SELECT 1')
        self.assertEqual(code, 4)
        self.assertIn('ACCEPTED the test write', err)
        self.assertEqual(out, '')
        self.assertEqual(self.tables(), ['orders'])  # the accepted test write was rolled back

    def test_prove_only(self):
        code, out, err = self.probe('--prove', '--target', 'copy')
        self.assertEqual(code, 0, err)
        self.assertIn('proven', out)
        code, _, _ = self.probe('--prove', '--target', 'writable')
        self.assertEqual(code, 4)

    def test_database_error(self):
        code, _, err = self.probe('--target', 'copy', '--query', 'SELECT * FROM no_such_table')
        self.assertEqual(code, 1)
        self.assertIn('no such table', err)

    def test_allow_write_only_on_a_disposable_target(self):
        code, _, err = self.probe('--allow-write', '--target', 'copy', '--query', 'DELETE FROM orders')
        self.assertEqual(code, 2)
        self.assertIn('disposable', err)
        self.assertEqual(self.count(), 5)
        code, _, err = self.probe('--allow-write', '--target', 'scratch', '--query', 'DELETE FROM orders WHERE id = 1')
        self.assertEqual(code, 0, err)
        self.assertIn('bypassed', err)
        self.assertEqual(self.count(self.scratch_db), 4)
        self.assertEqual(self.count(), 5)


class DbapiTarget(Scratch):
    def test_connect_argument_from_the_environment(self):
        os.environ['PROBE_TEST_DB'] = self.db
        self.addCleanup(os.environ.pop, 'PROBE_TEST_DB', None)
        code, out, err = self.probe('--target', 'driver', '--query', 'SELECT count(*) AS n FROM orders')
        self.assertEqual(code, 0, err)
        self.assertIn('proven', out)
        self.assertIn('5', out)

    def test_missing_environment_variable(self):
        os.environ.pop('PROBE_TEST_DB', None)
        code, _, err = self.probe('--target', 'driver', '--query', 'SELECT 1')
        self.assertEqual(code, 2)
        self.assertIn('PROBE_TEST_DB is not set', err)

    def test_without_proof_it_warns(self):
        code, out, err = self.probe('--target', 'driver-unproven', '--query', 'SELECT 1 AS one')
        self.assertEqual(code, 0, err)
        self.assertIn('NOT PROVEN', out)
        self.assertIn('not proven', err)
        strict = self.write_config({'require_proof': True, 'targets': {
            'driver-unproven': {'adapter': 'dbapi', 'module': 'sqlite3', 'connect': {'database': self.db}}}}, 's.json')
        code, _, err = run_cli(['--config', strict, '--target', 'driver-unproven', '--query', 'SELECT 1'])
        self.assertEqual(code, 2)
        self.assertIn('no read_only_proof', err)

    def test_module_not_installed(self):
        cfg = self.write_config({'targets': {'x': {'adapter': 'dbapi', 'module': 'no_such_driver_module_xyz'}}}, 'x.json')
        code, _, err = run_cli(['--config', cfg, '--target', 'x', '--query', 'SELECT 1'])
        self.assertEqual(code, 2)
        self.assertIn('installs none', err)


class CliTarget(Scratch):
    def read_log(self):
        with open(self.log, encoding='utf-8') as fh:
            return fh.read()

    def test_csv_capped_sql_on_stdin_environment_inherited(self):
        os.environ['FAKE_CLIENT_SECRET'] = 'from-the-environment'
        self.addCleanup(os.environ.pop, 'FAKE_CLIENT_SECRET', None)
        code, out, err = self.probe('--target', 'client', '--query', 'SELECT id, name FROM items')
        self.assertEqual(code, 0, err)
        self.assertIn('read-only session: proven', out)
        self.assertIn('read-only transaction', out)
        self.assertIn('3 row(s) shown - TRUNCATED', out)
        self.assertNotIn('item 4', out)
        log = self.read_log()
        self.assertIn('ARGV --csv\n', log)  # the SQL never travels on the command line
        self.assertNotIn('SELECT', ''.join(l for l in log.splitlines() if l.startswith('ARGV')))
        self.assertIn('ENV from-the-environment', log)
        self.assertIn('SQL SET SESSION READ ONLY; SELECT id, name FROM items', log)  # the prelude goes first

    def test_proof_accepted_or_refused_for_another_reason(self):
        os.environ['FAKE_CLIENT_MODE'] = 'accepts'
        code, _, err = self.probe('--target', 'client', '--query', 'SELECT 1')
        self.assertEqual(code, 4)
        self.assertIn('showed no refusal', err)
        os.environ['FAKE_CLIENT_MODE'] = 'other-error'
        code, _, err = self.probe('--target', 'client', '--query', 'SELECT 1')
        self.assertEqual(code, 4)
        self.assertIn('another reason', err)
        self.assertNotIn('SQL SELECT 1', self.read_log())  # no query ran

    def test_client_error(self):
        code, _, err = self.probe('--target', 'client', '--query', 'SELECT broken')
        self.assertEqual(code, 1)
        self.assertIn('exited with 3', err)

    def test_sql_in_a_temporary_file(self):
        code, out, err = self.probe('--target', 'client-file', '--query', 'SELECT 42')
        self.assertEqual(code, 0, err)
        self.assertIn('SELECT 42', out)
        self.assertIn('NOT PROVEN', out)
        self.assertEqual([n for n in os.listdir(tempfile.gettempdir()) if n.startswith('data-probe-') and n.endswith('.sql')], [])


class Configuration(Scratch):
    def assert_config_error(self, target, text):
        cfg = self.write_config({'targets': {'t': target}}, 'bad.json')
        code, _, err = run_cli(['--config', cfg, '--target', 't', '--query', 'SELECT 1'])
        self.assertEqual(code, 2, err)
        self.assertIn(text, err)

    def test_secrets_are_refused(self):
        base = {'adapter': 'dbapi', 'module': 'sqlite3'}
        self.assert_config_error(dict(base, connect={'password': 'hunter2'}), 'targets.t.connect.password holds a secret')
        self.assert_config_error(dict(base, connect={'dsn': 'host=x user=y password=z'}), 'carries a secret')
        self.assert_config_error(dict(base, connect={'url': 'proto://user:pw@host/db'}), 'carries a secret')
        self.assert_config_error({'adapter': 'cli', 'command': ['client', '--pwd=abc']}, 'carries a secret')
        self.assert_config_error(dict(base, token='abc'), 'holds a secret')

    def test_bad_values(self):
        self.assert_config_error({'adapter': 'odbc'}, 'adapter must be one of')
        self.assert_config_error({'adapter': 'sqlite'}, 'database must name')
        self.assert_config_error({'adapter': 'cli', 'command': 'client --x'}, 'non-empty list')
        self.assert_config_error({'adapter': 'cli', 'command': ['c'], 'input': 'file'}, '{file} placeholder')
        self.assert_config_error({'adapter': 'sqlite', 'database': 'x', 'lexical': {'nested': True}}, 'unknown lexical')
        self.assert_config_error({'adapter': 'dbapi', 'module': 'm', 'connect_env': {'password': 'not a name'}},
                                 'NAME of an environment variable')
        self.assert_config_error({'adapter': 'sqlite', 'database': 'x', 'read_only_proof': {'statement': ''}},
                                 'read_only_proof needs')

    def test_unknown_target_and_missing_query(self):
        code, _, err = self.probe('--target', 'nope', '--query', 'SELECT 1')
        self.assertEqual(code, 2)
        self.assertIn("no target 'nope'", err)
        code, _, err = self.probe('--target', 'copy')
        self.assertEqual(code, 2)
        self.assertIn('--query or --file', err)

    def test_output_inside_the_kit_is_refused(self):
        inside = os.path.join(dp.KIT_ROOT, 'runtime', 'data-probe', 'out.json')
        code, _, err = self.probe('--target', 'copy', '--query', 'SELECT 1', '--out', inside)
        self.assertEqual(code, 2)
        self.assertIn('inside the kit', err)
        self.assertFalse(os.path.exists(inside))

    def test_the_example_configuration_is_valid(self):
        data = dp.load_config(os.path.join(os.path.dirname(HERE), 'data-probe.example.json'))
        self.assertEqual(sorted(data['targets']), ['orders-copy', 'orders-dbapi', 'orders-replica', 'orders-scratch'])


class CheckOnly(unittest.TestCase):
    def test_check_connects_to_nothing(self):
        self.assertEqual(run_cli(['--check', '--query', 'SELECT 1'])[0], 0)
        code, _, err = run_cli(['--check', '--query', 'UPDATE orders SET x = 1'])
        self.assertEqual(code, 3)
        self.assertIn('UPDATE', err)
        # undeclared engine: a backslash that could hide a write is refused
        self.assertEqual(run_cli(['--check', '--query', "SELECT 'a\\'; DELETE FROM t; --'"])[0], 3)


if __name__ == '__main__':
    unittest.main()
