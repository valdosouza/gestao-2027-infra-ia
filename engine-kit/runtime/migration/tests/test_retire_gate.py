"""retire_gate.py: a snapshot is taken once, drift is decided by content, every drift item
carries its new location, a ruling holds only for the bytes it ruled on, the gate is green
at zero drift or when everything is ruled, and the old store is never written."""

import json
import os
import time
import unittest

from helpers import EXAMPLE_CONFIG, EXAMPLE_MANIFEST, TOOL, Scratch, fingerprint, load_json, read, run, write
import retire_gate


class Gate(Scratch):
    def setUp(self):
        Scratch.setUp(self)
        self.snap = self.path('gate', 'snapshot.json')
        self.rulings = self.path('gate', 'rulings.json')
        write(os.path.join(self.old, '.obsidian', 'workspace.json'), '{}')
        write(os.path.join(self.old, '.git', 'HEAD'), 'ref: refs/heads/main\n')
        code, out = self.gate('snapshot', '--out', self.snap)
        self.assertEqual(code, 0, out)
        self.frozen = fingerprint(self.old)

    def gate(self, command, *extra):
        argv = [command, '--old', self.old, '--config', EXAMPLE_CONFIG, '--manifest', EXAMPLE_MANIFEST]
        return run(retire_gate.main, argv + list(extra))

    def check(self, *extra):
        return self.gate('check', '--snapshot', self.snap, '--rulings', self.rulings,
                         '--json', self.path('gate', 'report.json'), '--report', self.path('gate', 'report.md'),
                         *extra)

    def rule(self, rel, ruling, reason='checked by the owner'):
        return self.gate('rule', '--snapshot', self.snap, '--rulings', self.rulings, '--path', rel,
                         '--ruling', ruling, '--by', 'owner-a', '--reason', reason, '--date', '2026-04-20')

    def items(self):
        return dict((i['path'], i) for i in load_json(self.path('gate', 'report.json'))['items'])

    def drift(self):
        write(os.path.join(self.old, 'notes', 'orders', 'refund-rule.md'), '# Refunds changed after the freeze\n')
        write(os.path.join(self.old, 'notes', 'billing', 'late-note.md'), '# Written after the freeze\n')
        write(os.path.join(self.old, 'scratch', 'later.txt'), 'scratch\n')
        write(os.path.join(self.old, 'loose.md'), '# Loose\n')
        os.remove(os.path.join(self.old, 'notes', 'billing', 'open-questions.md'))


class Snapshot(Gate):
    def test_zero_drift_is_green(self):
        code, out = self.check()
        self.assertEqual(code, 0, out)
        self.assertIn('GREEN - zero drift', out)
        report = read(self.path('gate', 'report.md'))
        self.assertIn('**Scope**: case', report)
        self.assertIn('zero drift', report)

    def test_a_touched_file_with_the_same_bytes_is_not_drift(self):
        path = os.path.join(self.old, 'README.md')
        later = time.time() + 3600
        os.utime(path, (later, later))
        self.assertEqual(self.check()[0], 0)

    def test_editor_and_runtime_state_is_excluded(self):
        write(os.path.join(self.old, '.obsidian', 'workspace.json'), '{"changed": true}')
        write(os.path.join(self.old, '.git', 'index'), 'x')
        self.assertEqual(self.check()[0], 0)
        self.assertFalse(any(k.startswith(('.git/', '.obsidian/')) for k in load_json(self.snap)['files']))

    def test_a_snapshot_is_taken_once_unless_forced(self):
        code, out = self.gate('snapshot', '--out', self.snap)
        self.assertEqual(code, 2, out)
        self.assertIn('--force', out)
        self.assertEqual(self.gate('snapshot', '--out', self.snap, '--force')[0], 0)

    def test_the_freeze_date_lists_late_files_once(self):
        old_time = time.mktime((2026, 3, 1, 12, 0, 0, 0, 0, -1))
        for dirpath, _, files in os.walk(self.old):
            for name in files:
                os.utime(os.path.join(dirpath, name), (old_time, old_time))
        late = os.path.join(self.old, 'notes', 'orders', 'refund-rule.md')
        stamp = time.mktime((2026, 4, 10, 12, 0, 0, 0, 0, -1))
        os.utime(late, (stamp, stamp))
        code, out = self.gate('snapshot', '--out', self.path('gate', 'second.json'))
        self.assertEqual(code, 0, out)
        self.assertIn('review once: 1 file(s) changed after the freeze date 2026-03-31', out)
        self.assertIn('notes/orders/refund-rule.md -> projects/shop/SUBJECT/ORDERS/KNOWLEDGE/refund-rule.md', out)


class Drift(Gate):
    def test_each_drift_item_carries_its_new_location(self):
        self.drift()
        code, out = self.check()
        self.assertEqual(code, 1, out)
        self.assertIn('OPEN - 5 of 5', out)
        items = self.items()
        self.assertEqual(items['notes/orders/refund-rule.md']['change'], 'modified')
        self.assertEqual(items['notes/orders/refund-rule.md']['new_location'],
                         'projects/shop/SUBJECT/ORDERS/KNOWLEDGE/refund-rule.md')
        self.assertEqual(items['notes/orders/refund-rule.md']['mapping'], 'manifest')
        self.assertEqual(items['notes/billing/late-note.md']['new_location'],
                         'projects/shop/SUBJECT/BILLING/MEMORY/late-note.md')
        self.assertIsNone(items['scratch/later.txt']['new_location'])
        self.assertIn('dropped', items['scratch/later.txt']['mapping'])
        self.assertEqual(items['loose.md']['new_location'], 'projects/shop/HISTORY/loose.md')
        self.assertEqual(items['notes/billing/open-questions.md']['change'], 'deleted')
        self.assertEqual(items['notes/billing/open-questions.md']['mapping'], 'manifest row without a target')

    def test_rulings_on_every_item_turn_the_gate_green(self):
        self.drift()
        for rel, ruling in (('notes/orders/refund-rule.md', 'import'), ('notes/billing/late-note.md', 'import'),
                            ('scratch/later.txt', 'discard'), ('loose.md', 'discard'),
                            ('notes/billing/open-questions.md', 'discard')):
            code, out = self.rule(rel, ruling)
            self.assertEqual(code, 0, out)
        code, out = self.check()
        self.assertEqual(code, 0, out)
        self.assertIn('GREEN - every drift item ruled (2 import, 3 discard)', out)
        self.assertIn('import by owner-a on 2026-04-20', read(self.path('gate', 'report.md')))

    def test_a_ruled_item_that_changes_again_opens_again(self):
        self.drift()
        for rel in self.items_after_check():
            self.assertEqual(self.rule(rel, 'discard')[0], 0)
        self.assertEqual(self.check()[0], 0)
        write(os.path.join(self.old, 'loose.md'), '# Loose, edited once more\n')
        code, out = self.check()
        self.assertEqual(code, 1, out)
        self.assertEqual(self.items()['loose.md']['state'], 'changed again after its ruling')

    def items_after_check(self):
        self.check()
        return list(self.items())

    def test_only_a_drift_item_can_be_ruled_and_a_ruling_names_who_and_why(self):
        code, out = self.rule('README.md', 'discard')
        self.assertEqual(code, 2, out)
        self.assertIn('not a drift item', out)
        self.drift()
        code, out = self.gate('rule', '--snapshot', self.snap, '--rulings', self.rulings, '--path', 'loose.md',
                              '--ruling', 'discard', '--by', 'owner-a')
        self.assertEqual(code, 2, out)
        code, out = self.gate('rule', '--snapshot', self.snap, '--rulings', self.rulings, '--path', 'loose.md',
                              '--ruling', 'keep', '--by', 'owner-a', '--reason', 'x')
        self.assertEqual(code, 2, out)
        code, out = self.rule('loose.md', 'discard', reason='   ')
        self.assertEqual(code, 2, out)


class NeverWritesTheOldStore(Gate):
    def test_outputs_inside_the_old_store_or_the_kit_are_refused(self):
        code, out = self.gate('snapshot', '--out', os.path.join(self.old, 'snap.json'))
        self.assertEqual(code, 2, out)
        code, out = self.gate('snapshot', '--out', os.path.join(TOOL, 'snap.json'))
        self.assertEqual(code, 2, out)
        self.assertFalse(os.path.exists(os.path.join(TOOL, 'snap.json')))
        code, out = self.gate('check', '--snapshot', self.snap, '--report', os.path.join(self.old, 'r.md'))
        self.assertEqual(code, 2, out)
        self.drift()
        code, out = self.gate('rule', '--snapshot', self.snap, '--rulings', os.path.join(self.old, 'r.json'),
                              '--path', 'loose.md', '--ruling', 'discard', '--by', 'a', '--reason', 'b')
        self.assertEqual(code, 2, out)

    def test_no_command_writes_inside_the_old_store(self):
        self.check()
        self.assertEqual(fingerprint(self.old), self.frozen)
        write(os.path.join(self.old, 'loose.md'), '# Loose\n')
        changed = fingerprint(self.old)
        self.check()
        self.rule('loose.md', 'import', reason='imported as projects/shop/HISTORY/loose.md')
        self.check()
        self.assertEqual(fingerprint(self.old), changed)

    def test_a_file_that_is_not_a_snapshot_is_a_usage_error(self):
        bad = self.path('gate', 'bad.json')
        write(bad, json.dumps({'something': 'else'}))
        code, out = self.gate('check', '--snapshot', bad)
        self.assertEqual(code, 2, out)


if __name__ == '__main__':
    unittest.main()
