"""vcs.py on throwaway working copies (EK#17): the svn client's global-ignores hides files by
default; svn_client_ignored=True lists them as unversioned while the repository's svn:ignore
and svn:global-ignores still apply; git is unaffected. has_commit: a folder whose first commit
is still to come (no HEAD, nothing under it committed, revision 0, unversioned or added
nodes) and one after its first commit, on git and svn. Every svn call runs with --config-dir
at a scratch folder whose global-ignores hides *.md, and git reads a scratch global config,
so this machine's own client configuration is never read. Everything happens under one
temporary folder (set TMP / TMPDIR to choose where). Skipped, with the reason, when svn and
svnadmin (or git) are not on PATH.

  cd runtime/registry
  python -m unittest discover -s tests
"""

import contextlib
import io
import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from unittest import mock

HERE = os.path.dirname(os.path.abspath(__file__))
REGISTRY = os.path.dirname(HERE)
if REGISTRY not in sys.path:
    sys.path.insert(0, REGISTRY)

import vcs  # noqa: E402

SKIP_SVN = 'svn and svnadmin are not on PATH: the svn adapter is not exercised on this machine'
SKIP_GIT = 'git is not on PATH: the git adapter is not exercised on this machine'


def have(*tools):
    return all(shutil.which(t) is not None for t in tools)


def sh(cmd, env=None):
    p = subprocess.run(cmd, env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p.returncode != 0:
        raise AssertionError('%s failed (%d): %s' % (' '.join(cmd), p.returncode,
                                                     p.stderr.decode('utf-8', 'replace')))
    return p.stdout.decode('utf-8', 'replace')


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(body)


def file_url(path):
    return 'file:///' + os.path.abspath(path).replace('\\', '/').lstrip('/')


class Scratch(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-vcs-')

    def tearDown(self):
        def retry(func, path, _):
            try:
                os.chmod(path, 0o700)  # git and svn keep read-only files
                func(path)
            except OSError:
                pass
        if sys.version_info >= (3, 12):
            shutil.rmtree(self.tmp, onexc=retry)
        else:
            shutil.rmtree(self.tmp, onerror=retry)

    def path(self, *parts):
        return os.path.join(self.tmp, *parts)

    def listed(self, root, **kw):
        return {(st, os.path.relpath(p, root).replace(os.sep, '/')) for st, p in vcs.changed_files(root, **kw)}

    def cli(self, *argv):
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
            code = vcs.main(list(argv))
        return code, buf.getvalue()


@unittest.skipUnless(have('svn', 'svnadmin'), SKIP_SVN)
class SvnClientIgnores(Scratch):
    """A client whose global-ignores hides every markdown file; a repository that ignores
    *.tmp and draft-*.md at its root (svn:ignore) and *.bak everywhere (svn:global-ignores)."""

    def setUp(self):
        super().setUp()
        self.client = self.path('svn-config')
        write(os.path.join(self.client, 'config'), '[miscellany]\nglobal-ignores = *.md\n')
        self.wc = self.path('wc')
        sh(['svnadmin', 'create', self.path('repo')])
        self.svn('checkout', '-q', file_url(self.path('repo')), self.wc)
        write(self.file('sub', 'keep.txt'), 'x\n')
        write(self.file('old.md'), '# Old\n')
        self.svn('add', '-q', self.file('sub'), self.file('old.md'))  # explicit targets: added though ignored
        self.svn('propset', '-q', 'svn:ignore', '*.tmp\ndraft-*.md', self.wc)
        self.svn('propset', '-q', 'svn:global-ignores', '*.bak', self.wc)
        self.svn('commit', '-q', '-m', 'base', '--username', 'tester', self.wc)
        write(self.file('old.md'), '# Old\n\nChanged.\n')
        for rel in ('a.md', 'sub/e.md', 'd.txt', 'b.tmp', 'draft-1.md', 'c.bak', 'sub/f.bak', 'newdir/h.md'):
            write(self.file(*rel.split('/')), rel + '\n')
        self.calls = []
        real = vcs._run

        def run(cmd):  # every svn call reads the scratch client configuration
            if cmd[0] == 'svn':
                cmd = cmd[:1] + ['--config-dir', self.client] + cmd[1:]
                self.calls.append(cmd)
            return real(cmd)
        patcher = mock.patch.object(vcs, '_run', run)
        patcher.start()
        self.addCleanup(patcher.stop)

    def svn(self, *args):
        return sh(['svn'] + list(args) + ['--non-interactive', '--config-dir', self.client])

    def file(self, *parts):
        return os.path.join(self.wc, *parts)

    def test_by_default_the_client_hides_its_files(self):
        self.assertEqual(self.listed(self.wc), {('M', 'old.md'), ('?', 'd.txt'), ('?', 'newdir/h.md')})
        self.assertNotIn('--config-option', self.calls[-1])  # the default command is unchanged

    def test_opt_in_lists_what_only_the_client_ignores(self):
        found = self.listed(self.wc, svn_client_ignored=True)
        self.assertEqual(found, {('M', 'old.md'), ('?', 'd.txt'), ('?', 'newdir/h.md'),
                                 ('?', 'a.md'), ('?', 'sub/e.md')})
        for rel in ('b.tmp', 'draft-1.md', 'c.bak', 'sub/f.bak'):  # the repository's own ignores
            self.assertNotIn(rel, {r for _, r in found})
        self.assertEqual(self.calls[-1][-3:-1], vcs.SVN_NO_CLIENT_IGNORES)

    def test_md_only_with_the_option(self):
        self.assertEqual({r for _, r in self.listed(self.wc, md_only=True)}, {'old.md', 'newdir/h.md'})
        self.assertEqual({r for _, r in self.listed(self.wc, md_only=True, svn_client_ignored=True)},
                         {'old.md', 'newdir/h.md', 'a.md', 'sub/e.md'})

    def test_the_registry_tools_take_the_flag_from_the_shared_arguments(self):
        import argparse
        import projects_check as pc
        ap = argparse.ArgumentParser()
        vcs.add_vcs_argument(ap)
        reg = mock.Mock(root=self.wc)
        _, off = pc.changed(reg, ap.parse_args([]), md_only=True)
        _, on = pc.changed(reg, ap.parse_args(['--svn-client-ignored']), md_only=True)
        rel = lambda entries: {os.path.relpath(p, self.wc).replace(os.sep, '/') for _, p in entries}
        self.assertNotIn('a.md', rel(off))
        self.assertEqual(rel(on) - rel(off), {'a.md', 'sub/e.md'})

    def test_cli(self):
        code, out = self.cli('--root', self.wc, '--md-only')
        self.assertEqual(code, 0)
        self.assertNotIn('? a.md', out)
        self.assertIn('svn: 2 changed file(s) under', out)
        code, out = self.cli('--root', self.wc, '--md-only', '--svn-client-ignored')
        self.assertEqual(code, 0)
        self.assertIn('? a.md', out.splitlines())
        self.assertIn('? sub/e.md', out.splitlines())
        self.assertIn('svn: 4 changed file(s) under', out)
        self.assertIn('(client global-ignores not applied)', out)


@unittest.skipUnless(have('git'), SKIP_GIT)
class GitUnaffected(Scratch):
    """A global excludes file (the client's own ignore list in git) that hides every markdown
    file: hidden with and without the option, which is svn only."""

    def setUp(self):
        super().setUp()
        excludes = self.path('git-excludes')
        write(excludes, '*.md\n')
        gitconfig = self.path('gitconfig')
        write(gitconfig, '[user]\n\tname = tester\n\temail = tester@example.invalid\n'
                         '[core]\n\tautocrlf = false\n\texcludesFile = %s\n' % excludes.replace('\\', '/'))
        patcher = mock.patch.dict(os.environ, {'GIT_CONFIG_GLOBAL': gitconfig, 'GIT_CONFIG_NOSYSTEM': '1',
                                               'GIT_TERMINAL_PROMPT': '0'})
        patcher.start()
        self.addCleanup(patcher.stop)
        self.wc = self.path('wc')
        sh(['git', 'init', '-q', self.wc])
        write(os.path.join(self.wc, 'base.txt'), 'x\n')
        sh(['git', '-C', self.wc, 'add', '-A'])
        sh(['git', '-C', self.wc, 'commit', '-q', '-m', 'base'])
        write(os.path.join(self.wc, 'a.md'), 'a\n')
        write(os.path.join(self.wc, 'd.txt'), 'd\n')

    def test_the_option_changes_nothing_on_git(self):
        expected = {('?', 'd.txt')}
        self.assertEqual(self.listed(self.wc), expected)
        self.assertEqual(self.listed(self.wc, svn_client_ignored=True), expected)
        code, out = self.cli('--root', self.wc, '--svn-client-ignored')
        self.assertEqual(code, 0)
        self.assertIn('git: 1 changed file(s) under', out)
        self.assertIn('(--svn-client-ignored has no effect on git)', out)


@unittest.skipUnless(have('git'), SKIP_GIT)
class GitFirstCommit(Scratch):
    """has_commit on git: no HEAD; HEAD but nothing under the folder; a commit under it."""

    def setUp(self):
        super().setUp()
        gitconfig = self.path('gitconfig')
        write(gitconfig, '[user]\n\tname = tester\n\temail = tester@example.invalid\n[core]\n\tautocrlf = false\n')
        patcher = mock.patch.dict(os.environ, {'GIT_CONFIG_GLOBAL': gitconfig, 'GIT_CONFIG_NOSYSTEM': '1',
                                               'GIT_TERMINAL_PROMPT': '0',
                                               'GIT_CEILING_DIRECTORIES': os.path.dirname(self.tmp)})
        patcher.start()
        self.addCleanup(patcher.stop)
        self.wc = self.path('wc')
        sh(['git', 'init', '-q', self.wc])
        write(os.path.join(self.wc, 'kb', 'a.md'), 'a\n')
        write(os.path.join(self.wc, 'top.txt'), 't\n')

    def test_the_first_commit_under_the_folder(self):
        kb = os.path.join(self.wc, 'kb')
        self.assertFalse(vcs.has_commit(self.wc))  # unborn branch
        self.assertFalse(vcs.has_commit(kb))
        sh(['git', '-C', self.wc, 'add', 'top.txt'])
        sh(['git', '-C', self.wc, 'commit', '-q', '-m', 'outside the folder'])
        self.assertTrue(vcs.has_commit(self.wc))
        self.assertFalse(vcs.has_commit(kb))  # HEAD exists, nothing under kb in it
        sh(['git', '-C', self.wc, 'add', 'kb'])
        self.assertFalse(vcs.has_commit(kb))  # added is not committed
        sh(['git', '-C', self.wc, 'commit', '-q', '-m', 'the folder'])
        self.assertTrue(vcs.has_commit(kb))
        self.assertRaises(vcs.VcsError, vcs.has_commit, self.path(), 'git')  # not a working copy


@unittest.skipUnless(have('svn', 'svnadmin'), SKIP_SVN)
class SvnFirstCommit(Scratch):
    """has_commit on svn: a checkout of an empty repository (revision 0), unversioned and added
    nodes, then a commit read before any update (the root stays at revision 0)."""

    def setUp(self):
        super().setUp()
        self.client = self.path('svn-config')
        write(os.path.join(self.client, 'config'), '[miscellany]\n')
        self.wc = self.path('wc')
        sh(['svnadmin', 'create', self.path('repo')])
        self.svn('checkout', '-q', file_url(self.path('repo')), self.wc)
        write(os.path.join(self.wc, 'kb', 'a.md'), 'a\n')
        write(os.path.join(self.wc, 'top.txt'), 't\n')
        real = vcs._run

        def run(cmd):
            return real(cmd[:1] + ['--config-dir', self.client] + cmd[1:] if cmd[0] == 'svn' else cmd)
        patcher = mock.patch.object(vcs, '_run', run)
        patcher.start()
        self.addCleanup(patcher.stop)

    def svn(self, *args):
        return sh(['svn'] + list(args) + ['--non-interactive', '--config-dir', self.client])

    def test_the_first_commit_under_the_folder(self):
        kb = os.path.join(self.wc, 'kb')
        self.assertFalse(vcs.has_commit(self.wc))  # revision 0, every child unversioned
        self.assertFalse(vcs.has_commit(kb))  # an unversioned folder
        self.svn('add', '-q', kb)
        self.assertFalse(vcs.has_commit(kb))  # added is not committed
        self.svn('add', '-q', os.path.join(self.wc, 'top.txt'))
        self.svn('commit', '-q', '-m', 'top only', '--username', 'tester', os.path.join(self.wc, 'top.txt'))
        self.assertTrue(vcs.has_commit(self.wc))  # no update: the root is still at revision 0
        self.assertFalse(vcs.has_commit(kb))
        self.svn('commit', '-q', '-m', 'the folder', '--username', 'tester', kb)
        self.assertTrue(vcs.has_commit(kb))


if __name__ == '__main__':
    unittest.main()
