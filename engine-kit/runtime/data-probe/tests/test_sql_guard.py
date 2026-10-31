"""Tests of sql_guard.check_read_only: reads accepted, writes refused, and comments, string
literals and quoted identifiers fooling it in neither direction - under declared lexical
options and with the options left unknown (checked both ways).

Run from runtime/data-probe: python -m unittest discover -s tests
"""

import os
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))

import sql_guard as g  # noqa: E402

# A plain engine: standard comments and quotes, nothing engine-specific.
PLAIN = {k: False for k in g.LEXICAL_OPTIONS}


def plain(**changes):
    out = dict(PLAIN)
    out.update(changes)
    return out


class Base(unittest.TestCase):
    def accepts(self, sql, lexical=PLAIN, **kw):
        v = g.check_read_only(sql, lexical, **kw)
        self.assertTrue(v.read_only, 'refused %r: %s' % (sql, v.reasons()))
        return v

    def refuses(self, sql, lexical=PLAIN, word=None, **kw):
        v = g.check_read_only(sql, lexical, **kw)
        self.assertFalse(v.read_only, 'accepted %r' % sql)
        if word:
            self.assertTrue(any(word in r for r in v.reasons()), '%r not in %s' % (word, v.reasons()))
        return v


class Reads(Base):
    def test_plain_reads(self):
        for sql in (
            'SELECT 1',
            'select * from orders where id = 3',
            'SELECT o.id, c.name FROM orders o JOIN customers c ON c.id = o.customer_id ORDER BY o.id DESC',
            'SELECT count(*) FROM orders GROUP BY status HAVING count(*) > 1',
            'WITH recent AS (SELECT * FROM orders WHERE placed > 5) SELECT * FROM recent',
            'WITH a AS (SELECT 1 AS x), b AS (SELECT x FROM a) SELECT * FROM b',
            'VALUES (1), (2)',
            'TABLE orders',
            '(SELECT 1) UNION (SELECT 2)',
            'EXPLAIN SELECT * FROM orders',
            'EXPLAIN ANALYZE SELECT * FROM orders',
            'SHOW TABLES',
            'DESCRIBE orders',
            'SELECT 1;',
            'SELECT 1; SELECT 2;;',
            '  \n SELECT 1 \n',
            'SELECT truncate(price, 2), replace(name, \'a\', \'b\') FROM orders',
            'SELECT TRUNCATE (1.5, 0)',
            'SELECT updated_at, deleted_flag, created_by, insert_count, setting FROM orders',
            'SELECT 1.5e10, 0x1F, 3',
        ):
            with self.subTest(sql=sql):
                self.accepts(sql)

    def test_statement_spans(self):
        v = self.accepts('SELECT 1;\n  SELECT 2 -- tail\n;')
        self.assertEqual(v.statements, [(0, 8), (12, 20)])
        self.assertEqual(g.split_statements('SELECT 1; SELECT 2', PLAIN), [(0, 8), (10, 18)])


class Writes(Base):
    def test_each_write_word(self):
        for sql, word in (
            ('INSERT INTO orders VALUES (1)', 'INSERT'),
            ('update orders set status = 1', 'UPDATE'),
            ('Delete From orders', 'DELETE'),
            ('MERGE INTO orders USING x ON 1 = 1 WHEN MATCHED THEN DELETE', 'MERGE'),
            ('CREATE TABLE t (x int)', 'CREATE'),
            ('ALTER TABLE orders ADD x int', 'ALTER'),
            ('DROP TABLE orders', 'DROP'),
            ('TRUNCATE TABLE orders', 'TRUNCATE'),
            ('TRUNCATE orders', 'TRUNCATE'),
            ('REPLACE INTO orders VALUES (1)', 'REPLACE'),
            ('GRANT SELECT ON orders TO someone', 'GRANT'),
            ('REVOKE SELECT ON orders FROM someone', 'REVOKE'),
            ('EXEC some_procedure', 'EXEC'),
            ('EXECUTE some_procedure', 'EXECUTE'),
            ('CALL some_procedure()', 'CALL'),
            ('SET x = 1', 'SET'),
            ('BEGIN', 'BEGIN'),
            ('COMMIT', 'COMMIT'),
            ('VACUUM', 'VACUUM'),
            ("ATTACH DATABASE 'other' AS o", 'ATTACH'),
        ):
            with self.subTest(sql=sql):
                self.refuses(sql, word=word)

    def test_not_a_read_statement(self):
        for sql, lead in (('PRAGMA user_version = 5', 'PRAGMA'), ('ANALYZE orders', 'ANALYZE'),
                          ('COPY orders TO stdout', 'COPY'), ('DECLARE x int', 'DECLARE'),
                          ('USE other', 'USE'), ('42', '42'), ('* FROM orders', '*')):
            with self.subTest(sql=sql):
                self.refuses(sql, word="starts with '%s'" % lead)

    def test_allow_leading_adds_a_read_word(self):
        self.refuses('PRAGMA table_info(orders)')
        self.accepts('PRAGMA table_info(orders)', allow_leading=['pragma'])
        # it never lifts a write word
        self.refuses('SET x = 1', allow_leading=['SET'], word="'SET'")

    def test_multi_statement(self):
        self.refuses('SELECT 1; DELETE FROM orders', word="'DELETE' in statement 2")
        self.refuses('SELECT 1;\nDROP TABLE orders;', word='DROP')
        self.refuses('SELECT 1; SELECT 2; ANALYZE orders', word="statement 3 starts with 'ANALYZE'")

    def test_second_statement_without_semicolon(self):
        # engines with optional terminators run both
        self.refuses('SELECT 1 DELETE FROM orders', word='DELETE')
        self.refuses('SELECT 1 SHUTDOWN', word='SHUTDOWN')
        self.refuses('SELECT 1 SET x = 1', word='SET')

    def test_batch_separator_line(self):
        self.accepts('SELECT 1\nGO\nSELECT 2\nGO 3\n')
        v = self.refuses('SELECT 1\nGO\nUSE other\n', word="statement 2 starts with 'USE'")
        self.assertEqual(v.findings[0].line, 3)
        self.assertEqual(len(self.accepts('SELECT 1\r\ngo\r\nSELECT 2').statements), 2)

    def test_writing_ctes(self):
        self.refuses('WITH gone AS (DELETE FROM orders RETURNING *) SELECT * FROM gone', word='DELETE')
        self.refuses('WITH c AS (SELECT id FROM orders) DELETE FROM orders WHERE id IN (SELECT id FROM c)', word='DELETE')
        self.refuses('WITH c AS (SELECT 1 AS x) INSERT INTO t SELECT x FROM c', word='INSERT')
        self.refuses('WITH c AS (SELECT 1) UPDATE orders SET status = 2', word='UPDATE')

    def test_reads_with_side_effects(self):
        self.refuses('SELECT * INTO orders_copy FROM orders', word='INTO')
        self.refuses('SELECT * FROM orders FOR UPDATE', word='UPDATE')
        self.refuses('EXPLAIN ANALYZE DELETE FROM orders', word='DELETE')
        self.refuses('SELECT * FROM orders LOCK IN SHARE MODE', word='LOCK')

    def test_digit_led_runs(self):
        self.refuses('SELECT 1DELETE FROM orders', word='DELETE')
        self.refuses('SELECT 1e1union SELECT 2; SELECT 1 1drop', word='DROP')

    def test_empty(self):
        for sql in ('', '   ', ';', '-- only a comment', '/* only */', None):
            with self.subTest(sql=sql):
                self.refuses(sql, word='no statement')


class CommentsAndLiteralsDoNotCauseRefusals(Base):
    def test_words_inside_comments_and_literals(self):
        for sql in (
            'SELECT 1 -- delete everything later',
            'SELECT 1 /* DROP TABLE orders; */',
            '/* update */ SELECT 1',
            "SELECT 'insert into orders' AS note",
            "SELECT 'it''s a delete' FROM orders",
            'SELECT "delete" FROM orders',
            'SELECT "a""update" FROM orders',
            "SELECT id FROM orders WHERE note LIKE '%; DROP TABLE x; --%'",
            "SELECT N'grant', X'00', E'x'",
        ):
            with self.subTest(sql=sql):
                self.accepts(sql)

    def test_engine_specific_quoting_when_declared(self):
        self.accepts('SELECT [delete] FROM [order details]', plain(bracket_identifiers=True))
        self.accepts('SELECT `update` FROM orders', plain(backtick_identifiers=True))
        self.accepts('SELECT $$ drop table x; $$, $tag$ delete $tag$', plain(dollar_quotes=True))
        self.accepts("SELECT 'it\\'s a delete'", plain(backslash_escapes=True))
        self.accepts("SELECT E'it\\'s a delete'", plain(escape_string_prefix=True))
        self.accepts('SELECT 1 # delete', plain(hash_comments=True))
        self.accepts('SELECT 1 /* outer /* inner */ delete */', plain(nested_block_comments=True))
        self.accepts('SELECT 1 --delete', plain(dash_comment_needs_space=False))


class CommentsAndLiteralsDoNotHideWrites(Base):
    def test_a_comment_marker_inside_a_literal(self):
        # the run that opens a comment inside a string does not comment out the rest
        self.refuses("SELECT '--', 1; DELETE FROM orders", word='DELETE')
        self.refuses("SELECT '/*'; DELETE FROM orders; SELECT '*/'", word='DELETE')
        self.refuses('SELECT "--"; DROP TABLE orders', word='DROP')

    def test_a_quote_inside_a_comment(self):
        self.refuses("SELECT 1 -- it's\nDELETE FROM orders", word='DELETE')
        self.refuses("SELECT 1 /* ' */ ; DELETE FROM orders; -- '", word='DELETE')

    def test_doubled_quotes(self):
        self.refuses("SELECT 'a''b'; DELETE FROM orders", word='DELETE')
        self.refuses("SELECT 'a'''; DELETE FROM orders", word='DELETE')

    def test_line_comment_ends_at_any_line_break(self):
        for brk in ('\n', '\r', '\r\n', ' ', '\x0b'):
            with self.subTest(brk=repr(brk)):
                self.refuses('SELECT 1 -- note' + brk + 'DELETE FROM orders', word='DELETE')

    def test_comment_between_words(self):
        self.refuses('SELECT 1;/**/DELETE/**/FROM orders', word='DELETE')

    def test_never_closed(self):
        self.refuses("SELECT 'open", word='string literal never closed')
        self.refuses('SELECT 1 /* open', word='block comment never closed')
        self.refuses('SELECT [open', plain(bracket_identifiers=True), word='quoted identifier never closed')
        self.refuses('SELECT $$ open', plain(dollar_quotes=True), word='dollar-quoted string never closed')

    def test_backslash(self):
        hide = "SELECT 'a\\'; DELETE FROM orders; --'"
        # an engine where the backslash escapes the quote sees one literal ...
        self.accepts(hide, plain(backslash_escapes=True))
        # ... one where it does not sees the DELETE ...
        self.refuses(hide, plain(backslash_escapes=False), word='DELETE')
        # ... and an undeclared engine is checked both ways
        v = self.refuses(hide, {}, word='DELETE')
        self.assertIn('backslash_escapes=false', ' '.join(v.reasons()))

    def test_escape_string_prefix(self):
        hide = "SELECT E'a\\'; DELETE FROM orders; --'"
        self.accepts(hide, plain(escape_string_prefix=True))
        self.refuses(hide, plain(escape_string_prefix=False), word='DELETE')
        self.refuses(hide, {}, word='DELETE')
        # an identifier ending in e is not a prefix
        self.refuses("SELECT name'a\\'; DELETE FROM orders; --'", plain(escape_string_prefix=True), word='DELETE')

    def test_nested_comments(self):
        hide = 'SELECT 1 /* /* */ DELETE FROM orders */'
        self.accepts(hide, plain(nested_block_comments=True))
        self.refuses(hide, plain(nested_block_comments=False), word='DELETE')
        self.refuses(hide, {}, word='DELETE')
        # the other direction: a nesting engine reads code where a flat lexing sees a literal
        flat_hides = "SELECT 1 /* /* */ ' */ DELETE FROM orders; -- '"
        self.refuses(flat_hides, plain(nested_block_comments=True), word='DELETE')
        self.refuses(flat_hides, {}, word='DELETE')

    def test_dash_comment_needs_space(self):
        hide = 'SELECT 1--x; DELETE FROM orders'
        self.accepts(hide, plain(dash_comment_needs_space=False))
        self.refuses(hide, plain(dash_comment_needs_space=True), word='DELETE')
        self.refuses(hide, {}, word='DELETE')
        self.accepts('SELECT 1 -- delete', plain(dash_comment_needs_space=True))

    def test_hash_comments(self):
        self.refuses('SELECT 1 # x\nDELETE FROM orders', plain(hash_comments=True), word='DELETE')
        self.refuses('SELECT 1 # delete', {}, word='DELETE')  # undeclared: refused, never accepted
        self.refuses('SELECT 1 # ; DELETE FROM orders', {}, word='DELETE')

    def test_executable_comments(self):
        hide = 'SELECT 1; /*!50000 DELETE FROM orders */'
        self.accepts(hide, plain(executable_comments=False))
        self.refuses(hide, plain(executable_comments=True), word='DELETE')
        self.refuses(hide, {}, word='DELETE')

    def test_dollar_quotes(self):
        hide = 'SELECT $$; DELETE FROM orders; $$'
        self.accepts(hide, plain(dollar_quotes=True))
        self.refuses(hide, plain(dollar_quotes=False), word='DELETE')
        self.refuses(hide, {}, word='DELETE')
        # a dollar inside an identifier opens nothing
        self.refuses('SELECT a$$; DELETE FROM orders; $$', plain(dollar_quotes=True), word='DELETE')

    def test_brackets_and_backticks(self):
        hide = 'SELECT [x; DELETE FROM orders; --]'
        self.accepts(hide, plain(bracket_identifiers=True))
        self.refuses(hide, {}, word='DELETE')
        self.refuses('SELECT [a--b] FROM t; DELETE FROM orders', {}, word='DELETE')
        self.refuses('SELECT `x; DROP TABLE orders; --`', {}, word='DROP')


class Options(unittest.TestCase):
    def test_unknown_option_is_an_error(self):
        with self.assertRaises(g.LexicalError):
            g.check_read_only('SELECT 1', {'nested': True})
        with self.assertRaises(g.LexicalError):
            g.check_read_only('SELECT 1', {'hash_comments': 'yes'})

    def test_notes_are_ignored(self):
        self.assertTrue(g.check_read_only('SELECT 1', {'_why': 'the engine nests comments',
                                                       'nested_block_comments': True}).read_only)

    def test_only_relevant_options_are_branched(self):
        self.assertEqual(g.check_read_only('SELECT 1', {}).variants, 1)
        self.assertEqual(g.check_read_only("SELECT 'a\\b' -- x", {}).variants, 8)  # backslash x2, dash
        self.assertEqual(g.check_read_only("SELECT 'a\\b'", plain()).variants, 1)

    def test_a_finding_in_every_variant_names_no_assumption(self):
        v = g.check_read_only('DELETE FROM orders -- \\', {})
        self.assertTrue(v.variants > 1)
        self.assertTrue(all(f.assumption == '' for f in v.findings))


if __name__ == '__main__':
    unittest.main()
