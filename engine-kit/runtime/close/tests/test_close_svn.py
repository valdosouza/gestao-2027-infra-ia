"""The same checks on svn: a throwaway file:// repository and its checkout as the knowledge
base - touched documents and their Scope line, files left unversioned, an svn:ignore'd file,
fix and tests listed apart, the decisions and ledger tools through the svn adapter; a
checkout with no first commit yet (one note) and after its first commit (a warning per file);
and a client whose global-ignores hides every markdown file, with "svnClientIgnored" off and
on (EK#17). Skipped, with the reason, when svn and svnadmin are not on PATH."""

import os
import unittest
from unittest import mock

from helpers import (DOC, LOG, Scratch, area, check, have, lines, make_kb, run_json, run_text, svn, svn_checkout,
                     write)
import close  # noqa: E402  (on sys.path through helpers)

SKIP_SVN = 'svn and svnadmin are not on PATH: the svn flow is not exercised on this machine'


@unittest.skipUnless(have('svn', 'svnadmin'), SKIP_SVN)
class SvnClose(Scratch):
    def setUp(self):
        super().setUp()
        self.kb = svn_checkout(self.path('repo'), self.path('kb'))
        make_kb(self.kb)
        svn('add', '--force', '--quiet', self.kb)
        svn('commit', '-q', '-m', 'base', '--username', 'tester', self.kb)

    def test_scope_and_unversioned_files(self):
        write(area(self.kb, 'MEMORY', 'added.md'), '# Added, no scope\n')
        svn('add', '--parents', '--quiet', area(self.kb, 'MEMORY', 'added.md'))
        write(area(self.kb, 'MEMORY', 'loose.md'), DOC % 'loose')
        write(area(self.kb, 'INDEX.md'), '# S\n\nNo scope any more.\n')
        code, r = run_json(['--root', self.kb, '--only', 'scope,unversioned'])
        self.assertEqual(code, 0)
        self.assertEqual(r['vcs'], 'svn')
        found = '\n'.join(lines(r, 'scope', 'fix'))
        self.assertIn('MEMORY/added.md', found)
        self.assertIn('SHIPPING/INDEX.md', found)
        self.assertNotIn('loose.md', found)
        warns = '\n'.join(lines(r, 'unversioned', 'warn'))
        self.assertIn('not under version control: projects/orders/SUBJECT/SHIPPING/MEMORY/loose.md', warns)
        self.assertNotIn('added.md', warns)
        self.assertIn('knowledge base: add each one when it is created - svn add --parents <file>',
                      lines(r, 'unversioned', 'note'))
        self.assertEqual(run_json(['--root', self.kb, '--only', 'scope,unversioned', '--strict'])[0], 1)

    def test_an_ignored_file_and_a_new_folder(self):
        svn('propset', '-q', 'svn:ignore', '*.tmp', self.kb)
        write(os.path.join(self.kb, 'scratch.tmp'), 'x\n')
        write(os.path.join(self.kb, 'newfolder', 'a.txt'), 'a\n')
        write(os.path.join(self.kb, 'newfolder', 'deep', 'b.txt'), 'b\n')
        code, r = run_json(['--root', self.kb, '--only', 'unversioned'])
        warns = '\n'.join(lines(r, 'unversioned', 'warn'))
        self.assertNotIn('scratch.tmp', warns)
        self.assertIn('newfolder/a.txt', warns)
        self.assertIn('newfolder/deep/b.txt', warns)

    def test_fix_and_tests_apart_in_a_second_working_copy(self):
        app = svn_checkout(self.path('app-repo'), self.path('app'))
        write(os.path.join(app, 'src', 'calc.py'), 'x = 1\n')
        write(os.path.join(app, 'tests', 'test_calc.py'), 't\n')
        svn('add', '--force', '--quiet', app)
        cfg = self.config({'workingCopies': [{'path': '../app', 'label': 'application'}],
                           'checks': {'unversioned': {'testPaths': ['^tests/']}}})
        code, r = run_json(['--root', self.kb, '--config', cfg, '--only', 'unversioned'])
        notes = lines(r, 'unversioned', 'note')
        self.assertIn('application: 1 fix file(s) and 1 test file(s) pending - two commits, the fix first', notes)
        self.assertIn('  fix:   src/calc.py', notes)
        self.assertIn('  tests: tests/test_calc.py', notes)

    def test_registry_tools_read_svn(self):
        write(area(self.kb, 'MEMORY', '2026-10-21-cr-123.md'), (LOG % 1).replace('ORD#1', 'ORD#9'))
        code, r = run_json(['--root', self.kb, '--only', 'decisions,ledger'])
        self.assertIn('ORD#9', '\n'.join(lines(r, 'decisions', 'fix')))
        self.assertEqual(check(r, 'ledger')['status'], 'ok')
        self.assertTrue(os.path.isfile(os.path.join(self.kb, 'projects', 'orders', '_REGISTRY', 'LEDGER.md')))


@unittest.skipUnless(have('svn', 'svnadmin'), SKIP_SVN)
class SvnFirstCommit(Scratch):
    """A checkout of an empty repository (revision 0) whose files are all unversioned or added:
    the first commit waits for the owner's release word - one note at every level; once a first
    commit exists (even before an update), a warning per file again from level 2."""

    NOTE = "knowledge base: no first commit yet - its first commit waits for the owner's release word: "

    def setUp(self):
        super().setUp()
        self.kb = svn_checkout(self.path('repo'), self.path('kb'))
        make_kb(self.kb)

    def unversioned(self, level):
        return run_json(['--root', self.kb, '--only', 'unversioned', '--level', level])

    def test_one_note_while_nothing_is_committed(self):
        for level in ('1', '2', '3'):
            code, r = self.unversioned(level)
            self.assertEqual((code, r['warn']), (0, 0), lines(r, 'unversioned'))
            notes = lines(r, 'unversioned', 'note')
            self.assertEqual(len(notes), 1, notes)
            self.assertTrue(notes[0].startswith(self.NOTE + '5 file(s); add them by path - svn add --parents <file>'), notes[0])
            self.assertIn('svn add --parents <file>', notes[0])
        svn('add', '--parents', '--quiet', os.path.join(self.kb, 'AGENTS.md'))
        code, r = self.unversioned('2')
        self.assertEqual(r['warn'], 0)
        self.assertIn(self.NOTE + '5 file(s) (1 already added)', lines(r, 'unversioned', 'note')[0])

    def test_a_warning_per_file_after_the_first_commit_without_an_update(self):
        svn('add', '--force', '--quiet', self.kb)
        svn('commit', '-q', '-m', 'the first commit', '--username', 'tester', self.kb)  # the root stays at r0
        write(area(self.kb, 'MEMORY', 'new.md'), DOC % 'new')
        code, r = self.unversioned('2')
        self.assertEqual(lines(r, 'unversioned', 'warn'),
                         ['knowledge base: not under version control: projects/orders/SUBJECT/SHIPPING/MEMORY/new.md'])
        self.assertFalse(any('first commit' in n for n in lines(r, 'unversioned', 'note')))


@unittest.skipUnless(have('svn', 'svnadmin'), SKIP_SVN)
class SvnClientIgnores(Scratch):
    """EK#17. The close script's svn reads use a scratch client configuration (--config-dir)
    whose global-ignores hides every markdown file; the repository ignores draft-*.md in the
    area (svn:ignore). A new document without a Scope line sits in a versioned folder, where
    only the client hides it."""

    LOOSE = 'projects/orders/SUBJECT/SHIPPING/loose.md'

    def setUp(self):
        super().setUp()
        self.client = self.path('svn-config')
        write(os.path.join(self.client, 'config'), '[miscellany]\nglobal-ignores = *.md\n')
        self.kb = svn_checkout(self.path('repo'), self.path('kb'))
        make_kb(self.kb)
        svn('add', '--force', '--no-ignore', '--quiet', self.kb)
        svn('propset', '-q', 'svn:ignore', 'draft-*.md', area(self.kb))
        svn('commit', '-q', '-m', 'base', '--username', 'tester', self.kb)
        write(area(self.kb, 'loose.md'), '# Loose, no scope\n')
        write(area(self.kb, 'draft-1.md'), '# Draft, no scope\n')
        real = close.vcs._run

        def run(cmd):
            return real(cmd[:1] + ['--config-dir', self.client] + cmd[1:] if cmd[0] == 'svn' else cmd)
        patcher = mock.patch.object(close.vcs, '_run', run)
        patcher.start()
        self.addCleanup(patcher.stop)

    def close_json(self, *argv, **cfg):
        args = ['--root', self.kb] + (['--config', self.config(cfg)] if cfg else [])
        return run_json(args + list(argv))

    def test_by_default_a_file_the_client_hides_is_invisible(self):
        code, r = self.close_json('--only', 'scope,unversioned', '--strict')
        self.assertEqual(code, 0)
        self.assertFalse(r['svnClientIgnored'])
        everything = '\n'.join(lines(r, 'scope') + lines(r, 'unversioned'))
        self.assertNotIn('loose.md', everything)
        self.assertNotIn('EK#17', everything)
        self.assertIn('knowledge base (svn): nothing unversioned, 0 pending change(s)', lines(r, 'unversioned', 'ok'))

    def test_opt_in_shows_it_and_the_repository_ignores_still_apply(self):
        code, r = self.close_json('--only', 'scope,unversioned', svnClientIgnored=True)
        self.assertEqual(code, 0)
        self.assertTrue(r['svnClientIgnored'])
        self.assertEqual(lines(r, 'scope', 'fix'), ['no Scope line in the first 50 lines: ' + self.LOOSE])
        self.assertEqual(lines(r, 'unversioned', 'warn'), ['knowledge base: not under version control: ' + self.LOOSE])
        self.assertIn("svn read without the client's global-ignores (svnClientIgnored, EK#17); "
                      "the repository's ignore properties still apply", lines(r, 'scope', 'note'))
        self.assertIn("knowledge base: read without the client's global-ignores (svnClientIgnored, EK#17)",
                      lines(r, 'unversioned', 'note'))
        self.assertNotIn('draft-1.md', '\n'.join(lines(r, 'scope') + lines(r, 'unversioned')))
        self.assertEqual(self.close_json('--only', 'scope', '--strict', svnClientIgnored=True)[0], 1)

    def test_a_working_copy_sets_its_own_value(self):
        app = svn_checkout(self.path('app-repo'), self.path('app'))
        write(os.path.join(app, 'base.txt'), 'x\n')  # a first commit: from now on a warning per file
        svn('add', '--quiet', os.path.join(app, 'base.txt'))
        svn('commit', '-q', '-m', 'base', '--username', 'tester', app)
        write(os.path.join(app, 'notes.md'), '# Notes\n')
        # the root's own entry turns it on: the scope check (top level, off) still cannot see loose.md
        code, r = self.close_json('--only', 'scope,unversioned', workingCopies=[
            {'path': '.', 'label': 'knowledge base', 'svnClientIgnored': True},
            {'path': '../app', 'label': 'application'}])
        self.assertNotIn('loose.md', '\n'.join(lines(r, 'scope')))
        self.assertEqual(lines(r, 'unversioned', 'warn'), ['knowledge base: not under version control: ' + self.LOOSE])
        self.assertIn('application (svn): nothing unversioned, 0 pending change(s)', lines(r, 'unversioned', 'ok'))
        # on at the top, off for the application
        code, r = self.close_json('--only', 'scope,unversioned', svnClientIgnored=True, workingCopies=[
            {'path': '.', 'label': 'knowledge base'},
            {'path': '../app', 'label': 'application', 'svnClientIgnored': False}])
        self.assertIn('no Scope line in the first 50 lines: ' + self.LOOSE, lines(r, 'scope', 'fix'))
        self.assertEqual(lines(r, 'unversioned', 'warn'), ['knowledge base: not under version control: ' + self.LOOSE])
        self.assertIn('application (svn): nothing unversioned, 0 pending change(s)', lines(r, 'unversioned', 'ok'))
        # on for both
        code, r = self.close_json('--only', 'unversioned', svnClientIgnored=True, workingCopies=[
            {'path': '.', 'label': 'knowledge base'}, {'path': '../app', 'label': 'application'}])
        self.assertIn('application: not under version control: notes.md', lines(r, 'unversioned', 'warn'))

    def test_the_registry_tools_say_how_they_read(self):
        note = "decisions_index.py --check-touched: reads svn without the client's global-ignores"
        code, r = self.close_json('--only', 'decisions,ledger', svnClientIgnored=True)
        self.assertTrue(any(n.startswith(note) for n in lines(r, 'decisions', 'note')))
        self.assertTrue(any(n.startswith('ledger_gen.py --changed: reads svn') for n in lines(r, 'ledger', 'note')))
        code, r = self.close_json('--only', 'decisions,ledger')
        self.assertFalse(any('svnClientIgnored' in n for n in lines(r, 'decisions') + lines(r, 'ledger')))

    def test_the_text_report(self):
        code, out = run_text(['--root', self.kb, '--config', self.config({'svnClientIgnored': True}),
                              '--only', 'unversioned'])
        self.assertEqual(code, 0)
        self.assertIn('WARN   knowledge base: not under version control: ' + self.LOOSE, out)


if __name__ == '__main__':
    unittest.main()
