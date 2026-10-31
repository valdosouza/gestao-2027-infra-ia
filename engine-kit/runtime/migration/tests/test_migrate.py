"""migrate.py: the dry run touches neither store, the body is never fixed, links follow the
manifest, collisions keep the target, apply is idempotent, problems are log lines, and the
tool refuses to write where it must not."""

import csv
import json
import os
import tempfile
import unittest

from helpers import (EXAMPLE_CONFIG, EXAMPLE_MANIFEST, PDF, REFUND, TAX_TARGET, TOOL, Scratch, fingerprint,
                     load_json, read, read_bytes, run, write)
import migrate
import migration_common as mc

ORDERS = 'projects/shop/SUBJECT/ORDERS'


class Base(Scratch):
    def migrate(self, *extra, manifest=None, config=EXAMPLE_CONFIG, staging=True):
        argv = ['--source', self.old, '--target', self.kb, '--manifest', manifest or self.clean_manifest(),
                '--date', '2026-04-01']
        if config:
            argv += ['--config', config]
        if staging and '--apply' not in extra:
            argv += ['--staging', self.path('staging')]
        if '--report-dir' not in extra:
            argv += ['--report-dir', self.path('report')]
        return run(migrate.main, argv + list(extra))

    def staged(self, rel):
        return os.path.join(self.path('staging'), *rel.split('/'))

    def log_rows(self, name='old-notes-2026-04-01'):
        with open(self.path('report', 'migration-log-%s.csv' % name), encoding='utf-8') as handle:
            return dict((r['source'], r) for r in csv.DictReader(handle))


class DryRun(Base):
    def test_the_shipped_example_lists_the_open_row_and_touches_no_store(self):
        before_old, before_kb = fingerprint(self.old), fingerprint(self.kb)
        code, out = self.migrate(manifest=EXAMPLE_MANIFEST)
        self.assertEqual(code, 1, out)
        self.assertEqual(fingerprint(self.old), before_old, 'the old store is only read')
        self.assertEqual(fingerprint(self.kb), before_kb, 'a dry run only reads the target')
        rows = self.log_rows()
        self.assertEqual(rows['notes/billing/open-questions.md']['status'], 'blocked')
        self.assertIn('no target', rows['notes/billing/open-questions.md']['problems'])
        self.assertEqual(rows['notes/orders/refund-rule.md']['status'], 'migrated')
        log = read(self.path('report', 'migration-log-old-notes-2026-04-01.md'))
        self.assertIn('**Scope**: case', log)
        self.assertIn('## 3. Blocking problems', log)
        self.assertIn('## 7. Spot-check sample', log)

    def test_a_clean_manifest_exits_0_and_stages_at_the_target_paths(self):
        code, out = self.migrate()
        self.assertEqual(code, 0, out)
        for rel in (ORDERS + '/KNOWLEDGE/refund-rule.md', ORDERS + '/MEMORY/2026-03-02-checkout-flow.md',
                    ORDERS + '/TICKETS/ORD-17/attachments/invoice-sample.pdf',
                    'projects/shop/HISTORY/old-notes-readme.md'):
            self.assertTrue(os.path.isfile(self.staged(rel)), rel)

    def test_the_default_staging_is_a_fresh_folder_outside_both_stores(self):
        saved = tempfile.tempdir
        tempfile.tempdir = self.path('system-temp')  # keep the default folder inside the scratch
        os.makedirs(tempfile.tempdir)
        try:
            code, out = self.migrate(staging=False)
        finally:
            tempfile.tempdir = saved
        self.assertEqual(code, 0, out)
        line = next(l for l in out.splitlines() if l.startswith('files written'))
        folder = line.split('-> ', 1)[1].strip()
        self.assertFalse(mc.inside(folder, self.old) or mc.inside(folder, self.kb) or mc.inside(folder, mc.KIT_ROOT))
        self.assertTrue(os.path.isfile(os.path.join(folder, *(ORDERS + '/KNOWLEDGE/refund-rule.md').split('/'))))


class NeverFixContent(Base):
    def test_the_body_stays_byte_for_byte_with_its_line_endings(self):
        self.assertEqual(self.migrate()[0], 0)
        staged = read_bytes(self.staged(ORDERS + '/KNOWLEDGE/refund-rule.md')).decode('utf-8')
        self.assertIn('\r\n', staged)
        self.assertNotIn('\r\r', staged)
        front, body = staged.split('---\r\n', 2)[1:]
        self.assertIn('origin: "old-notes:notes/orders/refund-rule.md"\r\n', front)
        self.assertIn('migrated: 2026-04-01\r\n', front)
        self.assertIn('kind: card\r\n', front)
        self.assertEqual(body.replace('\r\n**Scope**: case\r\n', '', 1), REFUND, 'only the Scope line was added')

    def test_existing_keys_are_never_changed(self):
        self.assertEqual(self.migrate()[0], 0)
        text = read(self.staged(ORDERS + '/MEMORY/2026-03-02-checkout-flow.md'))
        self.assertIn('title: Checkout flow\nvcs_revision: r120\nkind: note\n', text)
        self.assertEqual(text.count('kind:'), 1, 'the log profile adds no kind; the source kind stays')
        self.assertIn('consolidated: false', text)
        self.assertIn('author: dev-p', text)

    def test_the_scope_line_goes_after_the_title_once(self):
        self.assertEqual(self.migrate()[0], 0)
        text = read(self.staged(ORDERS + '/MEMORY/2026-03-02-checkout-flow.md'))
        self.assertIn('# Checkout flow\n\n**Scope**: case\n\nThe refund rule', text)
        write(os.path.join(self.old, 'notes', 'orders', 'refund-rule.md'), '# R\n\n**Scope**: method\n\nBody.\n')
        self.assertEqual(self.migrate('--staging', self.path('staging2'), staging=False)[0], 0)
        again = read(os.path.join(self.path('staging2'), *(ORDERS + '/KNOWLEDGE/refund-rule.md').split('/')))
        self.assertEqual(again.count('**Scope**'), 1)

    def test_a_binary_is_copied_as_it_is(self):
        self.assertEqual(self.migrate()[0], 0)
        self.assertEqual(read_bytes(self.staged(ORDERS + '/TICKETS/ORD-17/attachments/invoice-sample.pdf')), PDF)

    def test_a_bom_is_kept(self):
        write(os.path.join(self.old, 'notes', 'orders', 'refund-rule.md'), b'\xef\xbb\xbf# R\n\nBody.\n')
        self.assertEqual(self.migrate()[0], 0)
        self.assertTrue(read_bytes(self.staged(ORDERS + '/KNOWLEDGE/refund-rule.md')).startswith(b'\xef\xbb\xbf---\n'))

    def test_markdown_that_is_not_utf8_is_copied_byte_for_byte_with_a_note(self):
        raw = '# Caf\xe9\n'.encode('latin-1')
        write(os.path.join(self.old, 'notes', 'orders', 'refund-rule.md'), raw)
        self.assertEqual(self.migrate()[0], 0)
        self.assertEqual(read_bytes(self.staged(ORDERS + '/KNOWLEDGE/refund-rule.md')), raw)
        self.assertIn('not UTF-8', self.log_rows()['notes/orders/refund-rule.md']['problems'])


class Links(Base):
    def test_links_follow_the_manifest_and_dead_ones_are_listed(self):
        self.assertEqual(self.migrate()[0], 0)
        text = read(self.staged(ORDERS + '/MEMORY/2026-03-02-checkout-flow.md'))
        self.assertIn('[refund](../KNOWLEDGE/refund-rule.md#when)', text)
        self.assertIn('[[projects/shop/SUBJECT/BILLING/KNOWLEDGE/tax-rounding]]', text)
        self.assertIn('[gone](missing.md)', text, 'a dead link stays as written')
        self.assertIn('[site](https://example.com/x)', text)
        self.assertIn('[top](#checkout-flow)', text)
        self.assertIn('```text\n[not a link](refund-rule.md)\n```', text, 'fenced code is never rewritten')
        readme = read(self.staged('projects/shop/HISTORY/old-notes-readme.md'))
        self.assertIn('[checkout](../SUBJECT/ORDERS/MEMORY/2026-03-02-checkout-flow.md)', readme)
        row = self.log_rows()['notes/orders/checkout-flow.md']
        self.assertEqual(row['links_rewritten'], '2')
        self.assertIn('dead link (already broken in the old store): missing.md', row['problems'])

    def test_a_link_to_a_file_outside_the_manifest_is_listed(self):
        write(os.path.join(self.old, 'notes', 'orders', 'refund-rule.md'), '# R\n\nSee [todo](../../scratch/todo.txt).\n')
        self.assertEqual(self.migrate()[0], 0)
        self.assertIn('link to a file outside the manifest', self.log_rows()['notes/orders/refund-rule.md']['problems'])

    def test_rewrites_change_addresses_and_leftovers_block(self):
        self.assertEqual(self.migrate()[0], 0)
        text = read(self.staged(ORDERS + '/MEMORY/2026-03-02-checkout-flow.md'))
        self.assertIn('old-notes:notes/orders/checkout-flow.md', text)
        config = load_json(EXAMPLE_CONFIG)
        config['rewrites'] = []
        path = self.path('no-rewrite.json')
        write(path, json.dumps(config))
        code, out = self.migrate('--staging', self.path('staging2'), config=path, staging=False)
        self.assertEqual(code, 1, out)
        row = self.log_rows()['notes/orders/checkout-flow.md']
        self.assertEqual(row['status'], 'blocked')
        self.assertIn("leftover: 're:(?i)D:[\\\\/]+old-notes' x1", row['problems'])


class Collisions(Base):
    def test_the_target_body_wins_and_only_missing_keys_merge(self):
        self.assertEqual(self.migrate()[0], 0)
        text = read(self.staged('projects/shop/SUBJECT/BILLING/KNOWLEDGE/tax-rounding.md'))
        self.assertTrue(text.startswith('---\nid: K-BILLING-001\n'))
        self.assertIn('vcs_revision: r88\nvcs_author: dev-q\n', text, 'merge_keys vcs_* came from the source')
        self.assertIn('origin: "old-notes:notes/billing/tax-rounding.md"', text)
        self.assertIn('Kept body.', text)
        self.assertNotIn('Source body.', text)
        self.assertEqual(self.log_rows()['notes/billing/tax-rounding.md']['status'], 'merged')

    def test_a_differing_binary_collision_keeps_the_target(self):
        dest = os.path.join(self.kb, *(ORDERS + '/TICKETS/ORD-17/attachments/invoice-sample.pdf').split('/'))
        write(dest, b'other bytes')
        self.assertEqual(self.migrate()[0], 0)
        row = self.log_rows()['notes/orders/invoice-sample.pdf']
        self.assertEqual(row['status'], 'kept')
        self.assertIn('collision: the target exists and differs', row['problems'])
        self.assertFalse(os.path.exists(self.staged(ORDERS + '/TICKETS/ORD-17/attachments/invoice-sample.pdf')))


class Apply(Base):
    def test_apply_writes_into_the_target_never_deletes_and_is_idempotent(self):
        before_old, before_kb = fingerprint(self.old), fingerprint(self.kb)
        code, out = self.migrate('--apply')
        self.assertEqual(code, 0, out)
        after = fingerprint(self.kb)
        self.assertTrue(set(before_kb) <= set(after), 'nothing in the target disappears')
        self.assertEqual(len(after), len(before_kb) + 4)
        self.assertEqual(fingerprint(self.old), before_old)
        self.assertNotEqual(read(os.path.join(self.kb, 'projects', 'shop', 'SUBJECT', 'BILLING', 'KNOWLEDGE',
                                              'tax-rounding.md')), TAX_TARGET)
        code, out = self.migrate('--apply', '--report-dir', self.path('report2'))
        self.assertEqual(code, 0, out)
        self.assertIn('files written: 0', out)
        self.assertEqual(fingerprint(self.kb), after, 'a second apply changes nothing')

    def test_one_batch_at_a_time(self):
        code, out = self.migrate('--apply', '--batch', 'ORDERS')
        self.assertEqual(code, 0, out)
        rows = self.log_rows()
        self.assertEqual(rows['notes/orders/refund-rule.md']['status'], 'migrated')
        self.assertEqual(rows['notes/billing/tax-rounding.md']['status'], 'not selected')
        self.assertEqual(rows['README.md']['status'], 'not selected')
        self.assertFalse(os.path.exists(os.path.join(self.kb, 'projects', 'shop', 'HISTORY')))
        text = read(os.path.join(self.kb, *(ORDERS + '/MEMORY/2026-03-02-checkout-flow.md').split('/')))
        self.assertIn('[[projects/shop/SUBJECT/BILLING/KNOWLEDGE/tax-rounding]]', text,
                      'links point at where the other batches will land')

    def test_a_blocked_row_in_another_batch_does_not_fail_this_batch(self):
        code, out = self.migrate('--apply', '--batch', 'ORDERS', manifest=EXAMPLE_MANIFEST)
        self.assertEqual(code, 0, out)
        code, out = self.migrate('--apply', '--batch', 'BILLING', '--report-dir', self.path('r2'),
                                 manifest=EXAMPLE_MANIFEST)
        self.assertEqual(code, 1, out)


class Problems(Base):
    def test_every_unusable_row_is_blocked_and_listed(self):
        manifest = self.manifest([
            ('notes/orders/refund-rule.md', '../outside.md', 'A', 'card', ''),
            ('notes/orders/checkout-flow.md', 'C:/abs/checkout.md', 'A', 'log', ''),
            ('notes/billing/tax-rounding.md', 'x/same.md', 'A', 'card', ''),
            ('notes/billing/open-questions.md', 'x/SAME.md', 'A', 'log', ''),
            ('notes/orders/nothing-here.md', 'x/nothing.md', 'A', 'log', ''),
            ('notes/orders/refund-rule.md', 'x/again.md', 'A', 'card', ''),
            ('../escape.md', 'x/escape.md', 'A', 'log', ''),
        ])
        code, out = self.migrate(manifest=manifest, config=None)
        self.assertEqual(code, 1, out)
        rows = self.log_rows('migration-2026-04-01')
        problems = ' || '.join(r['problems'] for r in rows.values())
        for expected in ('unsafe target', 'duplicate target', 'missing source', 'duplicate source row',
                         'unsafe source'):
            self.assertIn(expected, problems)
        self.assertEqual(rows['notes/billing/open-questions.md']['status'], 'blocked',
                         'a target that differs only by case is a duplicate')
        self.assertTrue(os.path.isfile(self.staged('x/same.md')))

    def test_identical_copies_migrate_once_when_asked(self):
        write(os.path.join(self.old, 'notes', 'orders', 'refund-copy.md'), REFUND)
        manifest = self.manifest([
            ('notes/orders/refund-rule.md', ORDERS + '/KNOWLEDGE/refund-rule.md', 'A', 'card', ''),
            ('notes/orders/refund-copy.md', ORDERS + '/KNOWLEDGE/refund-copy.md', 'A', 'card', ''),
            ('README.md', 'HISTORY/readme.md', 'A', 'doc', ''),
        ])
        write(os.path.join(self.old, 'README.md'), '# R\n\n[copy](notes/orders/refund-copy.md)\n')
        config = load_json(EXAMPLE_CONFIG)
        config['dedupe_identical'] = True
        path = self.path('dedupe.json')
        write(path, json.dumps(config))
        code, out = self.migrate(manifest=manifest, config=path)
        self.assertEqual(code, 0, out)
        rows = self.log_rows()
        self.assertEqual(rows['notes/orders/refund-copy.md']['status'], 'duplicate')
        self.assertFalse(os.path.exists(self.staged(ORDERS + '/KNOWLEDGE/refund-copy.md')))
        self.assertIn('../' + ORDERS + '/KNOWLEDGE/refund-rule.md', read(self.staged('HISTORY/readme.md')))


class Refusals(Base):
    def expect_2(self, *extra, **kw):
        code, out = self.migrate(*extra, **kw)
        self.assertEqual(code, 2, out)
        return out

    def test_staging_inside_a_store_or_the_kit_is_refused(self):
        self.expect_2('--staging', os.path.join(self.old, 'stage'), staging=False)
        self.expect_2('--staging', os.path.join(self.kb, 'stage'), staging=False)
        self.expect_2('--staging', os.path.join(TOOL, 'stage'), staging=False)
        self.assertFalse(os.path.exists(os.path.join(TOOL, 'stage')))

    def test_a_report_inside_the_old_store_is_refused(self):
        self.expect_2('--report-dir', os.path.join(self.old, 'log'))

    def test_apply_into_the_kit_or_into_the_old_store_is_refused(self):
        code, out = run(migrate.main, ['--source', self.old, '--target', TOOL, '--manifest', self.clean_manifest(),
                                       '--apply', '--report-dir', self.path('r')])
        self.assertEqual(code, 2, out)
        code, out = run(migrate.main, ['--source', self.old, '--target', os.path.join(self.old, 'notes'),
                                       '--manifest', self.clean_manifest(), '--report-dir', self.path('r')])
        self.assertEqual(code, 2, out)

    def test_bad_arguments_are_usage_errors(self):
        self.expect_2('--batch', 'NOPE')
        self.expect_2('--date', '01/04/2026')
        bad = self.path('bad.csv')
        write(bad, 'from,to\nx,y\n')
        self.expect_2(manifest=bad)


class Static(unittest.TestCase):
    def test_the_tools_never_delete_rename_or_run_a_command(self):
        for name in ('migrate.py', 'retire_gate.py', 'migration_common.py'):
            text = read(os.path.join(TOOL, name))
            for call in ('os.remove', 'os.unlink', 'os.rmdir', 'shutil.rmtree', 'os.rename', 'os.replace',
                         'shutil.move', 'subprocess', 'os.system', 'os.popen'):
                self.assertNotIn(call, text, '%s uses %s' % (name, call))


if __name__ == '__main__':
    unittest.main()
