"""Shared helpers of the testing group's tests: scratch folders, throwaway git and svn
repositories, configuration files, the CLI run in-process. Everything happens under one
temporary folder; nothing reads or writes outside it."""

import contextlib
import io
import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
KIT_TESTING = os.path.dirname(HERE)
if KIT_TESTING not in sys.path:
    sys.path.insert(0, KIT_TESTING)

FAKE_SUITE = os.path.join(HERE, 'fake_suite.py')
FAKE_AGENT = os.path.join(HERE, 'fake_agent.py')
GIT_ENV = {'GIT_CONFIG_NOSYSTEM': '1', 'GIT_TERMINAL_PROMPT': '0'}


def have(*tools):
    return all(shutil.which(t) is not None for t in tools)


def sh(cmd, cwd=None, env=None, check=True, input_text=None):
    full = dict(os.environ)
    full.update(GIT_ENV)
    if env:
        full.update(env)
    p = subprocess.run(cmd, cwd=cwd, env=full, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                       input=input_text.encode('utf-8') if input_text is not None else None)
    out = p.stdout.decode('utf-8', 'replace')
    if check and p.returncode != 0:
        raise AssertionError('%s failed (%d): %s %s' % (' '.join(cmd), p.returncode, out,
                                                      p.stderr.decode('utf-8', 'replace')))
    return out


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(body)


def read(path):
    with open(path, 'r', encoding='utf-8') as fh:
        return fh.read()


def file_url(path):
    p = os.path.abspath(path).replace('\\', '/')
    return 'file:///' + p.lstrip('/')


class Scratch(unittest.TestCase):
    """A test case with its own scratch folder, removed afterwards."""

    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-testing-')

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


def cli(argv):
    """suite.main in-process: (exit code, stdout + stderr)."""
    import suite
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
        code = suite.main(argv)
    return code, buf.getvalue()


# ---------------------------------------------------------------- git

def git_server(root):
    sh(['git', 'init', '-q', '--bare', '-b', 'main', root])
    return root


def git_identity(repo, user):
    sh(['git', '-C', repo, 'config', 'user.name', user])
    sh(['git', '-C', repo, 'config', 'user.email', '%s@example.invalid' % user])
    sh(['git', '-C', repo, 'config', 'core.autocrlf', 'false'])
    return repo


def git_clone(url, dest, user):
    # autocrlf off from the first checkout: a machine-wide "true" would leave every file modified
    sh(['git', 'clone', '-q', '-c', 'core.autocrlf=false', url, dest])
    return git_identity(dest, user)


def git_init(dest, user):
    sh(['git', 'init', '-q', '-b', 'main', dest])
    return git_identity(dest, user)


def git_commit(repo, files, message, when=None, delete=()):
    """files: {relative path: content}; when: 'YYYY-MM-DDTHH:MM:SS+00:00'. Returns the sha."""
    for rel, body in files.items():
        write(os.path.join(repo, rel), body)
    for rel in delete:
        os.remove(os.path.join(repo, rel))
    sh(['git', '-C', repo, 'add', '-A'])
    env = {}
    if when:
        env = {'GIT_AUTHOR_DATE': when, 'GIT_COMMITTER_DATE': when}
    sh(['git', '-C', repo, 'commit', '-q', '-m', message], env=env)
    return sh(['git', '-C', repo, 'rev-parse', 'HEAD']).strip()


# ---------------------------------------------------------------- svn

def svn_repo(root):
    sh(['svnadmin', 'create', root])
    return file_url(root)


def svn(*args, **kw):
    return sh(['svn'] + list(args) + ['--non-interactive'], **kw)


def svn_commit(wc, files, message, user, delete=()):
    """Writes files, adds what is new, commits as user. Returns the new revision (int)."""
    for rel, body in files.items():
        write(os.path.join(wc, rel), body)
    svn('add', '--force', '--quiet', wc)
    for rel in delete:
        svn('delete', '--quiet', os.path.join(wc, rel))
    out = svn('commit', '-m', message, '--username', user, wc)
    svn('update', '--quiet', wc)
    return int([ln for ln in out.splitlines() if ln.startswith('Committed revision')][0].split()[-1].rstrip('.'))


# ---------------------------------------------------------------- configuration

def suite_spec(path, tests, out, **extra):
    spec = {'tests': tests, 'out': out}
    spec.update(extra)
    write(path, json.dumps(spec))
    return path


def fake_part(spec, results, **extra):
    part = {'command': [sys.executable, FAKE_SUITE, spec], 'results': {'format': 'junit', 'path': results}}
    part.update(extra)
    return part


def config(path, working_copy, state_dir, spec, results, suite_extra=None, **sections):
    cfg = {
        'workingCopy': working_copy,
        'stateDir': state_dir,
        'line': 'main',
        'suite': {'name': 'demo', 'command': [sys.executable, FAKE_SUITE, spec], 'cwd': '.',
                  'timeoutSec': 60, 'busyWaitSec': 0,
                  'results': {'format': 'junit', 'path': results},
                  'exitCodes': {'busy': [75], 'notRunHere': [78]}},
        'paths': {'tests': ['^tests/'], 'untestable': [r'\.md$']},
    }
    cfg['suite'].update(suite_extra or {})
    for k, v in sections.items():
        cfg[k] = v
    write(path, json.dumps(cfg, indent=2))
    return path


def agent_cfg(mode='good', **extra):
    a = {'command': [sys.executable, FAKE_AGENT, '{proposal}', '{rev}', mode], 'timeoutSec': 60}
    a.update(extra)
    return a
