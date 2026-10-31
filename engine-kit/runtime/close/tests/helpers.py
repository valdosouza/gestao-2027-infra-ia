"""Shared helpers of the close script's tests: a scratch folder, throwaway git and svn
working copies, a small knowledge base, the CLI run in-process. Everything happens under
one temporary folder (set TMP / TMPDIR to choose where); nothing reads or writes outside it."""

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
CLOSE_DIR = os.path.dirname(HERE)
if CLOSE_DIR not in sys.path:
    sys.path.insert(0, CLOSE_DIR)

import close  # noqa: E402

GIT_ENV = {'GIT_CONFIG_NOSYSTEM': '1', 'GIT_TERMINAL_PROMPT': '0'}
DOC = '# %s\n\n**Scope**: case\n\nBody.\n'


def have(*tools):
    return all(shutil.which(t) is not None for t in tools)


def powershell():
    return close.find_powershell('')


def sh(cmd, cwd=None, check=True):
    env = dict(os.environ)
    env.update(GIT_ENV)
    p = subprocess.run(cmd, cwd=cwd, env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out = p.stdout.decode('utf-8', 'replace')
    if check and p.returncode != 0:
        raise AssertionError('%s failed (%d): %s %s' % (' '.join(cmd), p.returncode, out,
                                                      p.stderr.decode('utf-8', 'replace')))
    return out


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(body)


def file_url(path):
    return 'file:///' + os.path.abspath(path).replace('\\', '/').lstrip('/')


class Scratch(unittest.TestCase):
    """A test case with its own scratch folder, removed afterwards."""

    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-close-')

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

    def config(self, data, name='close.json'):
        path = self.path(name)
        write(path, json.dumps(data, indent=2))
        return path


def run_text(argv):
    """close.main in-process: (exit code, stdout + stderr)."""
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
        code = close.main(argv)
    return code, buf.getvalue()


def run_json(argv):
    """close.main --json in-process: (exit code, parsed result)."""
    code, out = run_text(list(argv) + ['--json'])
    return code, json.loads(out)


def check(result, name):
    return [c for c in result['checks'] if c['name'] == name][0]


def lines(result, name, kind=None):
    return [l['text'] for l in check(result, name)['lines'] if kind is None or l['kind'] == kind]


# ---------------------------------------------------------------- git and svn

def git_init(path):
    sh(['git', 'init', '-q', '-b', 'main', path])
    for key, value in (('user.name', 'tester'), ('user.email', 'tester@example.invalid'),
                       ('core.autocrlf', 'false')):
        sh(['git', '-C', path, 'config', key, value])
    return path


def git_commit_all(path, message='base'):
    sh(['git', '-C', path, 'add', '-A'])
    sh(['git', '-C', path, 'commit', '-q', '-m', message])


def svn(*args, **kw):
    return sh(['svn'] + list(args) + ['--non-interactive'], **kw)


def svn_checkout(repo_dir, wc):
    sh(['svnadmin', 'create', repo_dir])
    svn('checkout', '-q', file_url(repo_dir), wc)
    return wc


# ---------------------------------------------------------------- a small knowledge base

PROJECTS = """---
registry: projects
root_globs:
  - "projects/*"
scope_value: case
---
# Projects Registry - demo

**Scope**: case

| Key | Type | Name | Code tree | Path | Status |
|---|---|---|---|---|---|
| `WS` | workspace | the base | - | `.` | active |
| `ORD` | tenant | orders | - | `projects/orders` | active |
"""

REGISTER = """---
project: %s
---
# Decisions Register - %s

**Scope**: case

## Registered decisions

| # | Date | Decision | Why | Applies to |
|---|---|---|---|---|
| 1 | 2026-10-01 | **Partial shipments are allowed.** | the owner asked | - |
"""

LOG = """---
project: ORD
subject: SHIPPING
consolidated: false
claims:
  - claim: "a partial shipment keeps the order open"
    status: fact
    confidence: 0.9
    evidence: "orders/ship.py:40"
---
# Session log %d

**Scope**: case

Cites ORD#1.
"""


def make_kb(root, registry=True):
    """A knowledge base with a workspace and one project (ORD), area SHIPPING."""
    write(os.path.join(root, 'AGENTS.md'), DOC % 'Rules')
    write(os.path.join(root, 'projects', 'orders', 'SUBJECT', 'SHIPPING', 'INDEX.md'), DOC % 'Shipping')
    if registry:
        write(os.path.join(root, '_REGISTRY', 'PROJECTS.md'), PROJECTS)
        write(os.path.join(root, 'DECISIONS.md'), REGISTER % ('WS', 'workspace'))
        write(os.path.join(root, 'projects', 'orders', '_REGISTRY', 'DECISIONS.md'), REGISTER % ('ORD', 'orders'))
    return root


def area(root, *parts):
    return os.path.join(root, 'projects', 'orders', 'SUBJECT', 'SHIPPING', *parts)
