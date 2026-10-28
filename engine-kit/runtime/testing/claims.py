#!/usr/bin/env python3
"""claims.py - first claim wins, through a VCS conflict (T75). The ONLY repository write
of the testing group, and suite.py runs it only behind the explicit --claim switch.

A claim is a folder named after the revision with one file, CLAIM.md, committed to a
shared claims area. Two watchers that claim the same revision race; the VCS lets one
commit in and refuses the other, so exactly one wins:

  git  an orphan branch (default `test-claims`) on the shared remote, one folder per
       revision. The commit is built with plumbing in a private per-machine clone
       (<stateDir>/claims-wc: never the developer's working copy) on top of the tip just
       fetched, and pushed WITHOUT force. A rejected push (someone pushed first) means:
       fetch again; if the revision's CLAIM.md is there now, the claim is lost; if not
       (another revision was claimed), build again on the new tip and push again.
       Why a branch: claims never enter the history of the code lines (on a busy line
       they were a third of the log in the case this comes from), and a non-forced push
       is atomic on every git server.
  svn  a folder URL (e.g. ^/claims/<suite>); a sparse checkout in <stateDir>/claims-wc;
       `svn add` + `svn commit` of the revision's folder. The second commit fails with
       "already exists" / "out of date" (E160020, E155011, E160024, E160028): lost.

Either way, anything else (no network, no credentials, a server hook) is `failed`, to
be retried: it is not someone else's claim. A claim already held by this claimer and
machine answers `won` again (idempotent), so a lost connection after a successful push
or commit never strands a revision.

Proposal folder in the claims area (README.md, "Claim and proposal"):
  <key>/CLAIM.md   committed by the claim
  <key>/REPORT.md  and draft files: staged here by suite.py, published by a human
where <key> is r<N> for svn and the full commit id for git.

Python 3.8+, standard library only.
"""

import os
import re
import shutil
import socket
import tempfile
from datetime import datetime, timezone
from urllib.parse import unquote

from vcsops import VcsError, run, run_ok, text

CONFLICT_SVN = re.compile(r'E160020|E155011|E160024|E160028|E160042|already exists|out of date', re.I)
CLAIM_FIELDS = ('revision', 'claimer', 'machine', 'for', 'claimed')


def claim_key(kind, rev):
    return 'r%s' % rev if kind == 'svn' else str(rev)


def claim_text(rev_label, claimer, author, machine=None, when=None):
    when = when or datetime.now(timezone.utc)
    machine = machine or socket.gethostname()
    return ('# Claim %s\n\n- revision: %s\n- claimer: %s\n- machine: %s\n- for: %s\n- claimed: %s\n'
            % (rev_label, rev_label, claimer, machine, author, when.isoformat(timespec='seconds')))


def parse_claim(body):
    c = dict.fromkeys(CLAIM_FIELDS, '')
    for m in re.finditer(r'(?m)^- (revision|claimer|machine|for|claimed): *(.*?)\s*$', body):
        c[m.group(1)] = m.group(2)
    return c


def _is_mine(claim, claimer, machine):
    return claim.get('claimer') == claimer and claim.get('machine') == (machine or socket.gethostname())


# ---------------------------------------------------------------- git

class GitClaims:
    kind = 'git'

    def __init__(self, state_dir, remote_url, branch='test-claims'):
        self.dir = os.path.join(state_dir, 'claims-wc')
        self.url = remote_url
        self.branch = branch
        self.tracking = 'refs/remotes/origin/%s' % branch

    def _git(self, *args, **kw):
        return run_ok(['git', '-C', self.dir] + list(args), **kw)

    def _ensure(self):
        if not os.path.isdir(os.path.join(self.dir, '.git')):
            os.makedirs(self.dir, exist_ok=True)
            run_ok(['git', 'init', '-q', self.dir])
            self._git('remote', 'add', 'origin', self.url)
        else:
            code, out, _ = run(['git', '-C', self.dir, 'remote', 'get-url', 'origin'])
            if code != 0:
                self._git('remote', 'add', 'origin', self.url)
            elif text(out).strip() != self.url:
                self._git('remote', 'set-url', 'origin', self.url)

    def fetch(self):
        """The tip of the claims branch on the remote, or '' when it does not exist yet."""
        self._ensure()
        code, _, err = run(['git', '-C', self.dir, 'fetch', '-q', '--no-tags', 'origin',
                            '+refs/heads/%s:%s' % (self.branch, self.tracking)])
        if code != 0:
            if re.search(r"couldn't find remote ref|could not find remote ref", err, re.I):
                run(['git', '-C', self.dir, 'update-ref', '-d', self.tracking])
                return ''
            raise VcsError('git fetch of %s failed: %s' % (self.branch, err.strip().splitlines()[:1]))
        return text(self._git('rev-parse', self.tracking)).strip()

    def _exists(self, tip, path):
        if not tip:
            return False
        code, _, _ = run(['git', '-C', self.dir, 'cat-file', '-e', '%s:%s' % (tip, path)])
        return code == 0

    def _show(self, tip, path):
        return text(self._git('show', '%s:%s' % (tip, path)))

    def read(self, key, tip=None):
        """{claim fields..., has_report} or None. Fetches unless tip is given."""
        tip = self.fetch() if tip is None else tip
        if not self._exists(tip, key + '/CLAIM.md'):
            return None
        c = parse_claim(self._show(tip, key + '/CLAIM.md'))
        c['has_report'] = self._exists(tip, key + '/REPORT.md')
        return c

    def list(self):
        tip = self.fetch()
        if not tip:
            return []
        names = text(self._git('ls-tree', '-r', '--name-only', tip)).splitlines()
        keys = sorted(set(n.split('/', 1)[0] for n in names if n.endswith('/CLAIM.md')))
        out = []
        for k in keys:
            c = self.read(k, tip)
            c['key'] = k
            out.append(c)
        return out

    def _identity_env(self, claimer):
        env = {}
        code, out, _ = run(['git', '-C', self.dir, 'config', 'user.name'])
        if code != 0 or not text(out).strip():
            env['GIT_AUTHOR_NAME'] = env['GIT_COMMITTER_NAME'] = claimer or 'test-watcher'
        code, out, _ = run(['git', '-C', self.dir, 'config', 'user.email'])
        if code != 0 or not text(out).strip():
            env['GIT_AUTHOR_EMAIL'] = env['GIT_COMMITTER_EMAIL'] = '%s@claims.invalid' % (claimer or 'test-watcher')
        return env

    def _build(self, tip, key, body, message, claimer):
        fd, index = tempfile.mkstemp(prefix='claim-index-')
        os.close(fd)
        os.remove(index)  # git wants to create the index itself
        env = {'GIT_INDEX_FILE': index}
        try:
            if tip:
                self._git('read-tree', tip, env=env)
            else:
                self._git('read-tree', '--empty', env=env)
            blob = text(self._git('hash-object', '-w', '--stdin', input_bytes=body.encode('utf-8'))).strip()
            self._git('update-index', '--add', '--cacheinfo', '100644,%s,%s/CLAIM.md' % (blob, key), env=env)
            tree = text(self._git('write-tree', env=env)).strip()
        finally:
            if os.path.exists(index):
                os.remove(index)
        args = ['commit-tree', tree, '-m', message]
        if tip:
            args[2:2] = ['-p', tip]
        return text(self._git(*args, env=self._identity_env(claimer))).strip()

    def claim(self, key, body, message, claimer, machine=None, before_push=None, attempts=5):
        """'won' | 'lost' | 'failed', detail. before_push: a test seam called once,
        between building the commit and pushing it."""
        try:
            for _ in range(attempts):
                tip = self.fetch()
                held = self.read(key, tip)
                if held is not None:
                    if _is_mine(held, claimer, machine):
                        return 'won', 'already claimed by this machine'
                    return 'lost', 'claimed by %s' % held.get('claimer')
                commit = self._build(tip, key, body, message, claimer)
                if before_push is not None:
                    hook, before_push = before_push, None
                    hook()
                code, out, err = run(['git', '-C', self.dir, 'push', '--porcelain', 'origin',
                                      '%s:refs/heads/%s' % (commit, self.branch)])
                said = text(out) + '\n' + err
                if code == 0:
                    self._git('update-ref', self.tracking, commit)
                    run(['git', '-C', self.dir, 'checkout', '-q', '-B', self.branch, commit])
                    return 'won', 'pushed %s' % commit[:12]
                if '[remote rejected]' in said or not re.search(r'\[rejected\]|non-fast-forward|fetch first', said):
                    return 'failed', 'push refused: %s' % (err.strip().splitlines() or ['exit %d' % code])[-1]
                # rejected: someone pushed first - fetch again and look
            return 'failed', 'the claims branch kept moving; retry later'
        except VcsError as exc:
            return 'failed', str(exc)

    def folder(self, key):
        return os.path.join(self.dir, key)

    def prepare_folder(self, key):
        """A working tree of the current tip, for staging a proposal (local only)."""
        tip = self.fetch()
        if tip:
            run(['git', '-C', self.dir, 'checkout', '-q', '-B', self.branch, tip])
        os.makedirs(self.folder(key), exist_ok=True)
        return self.folder(key)

    def publish_commands(self, key, rev_label):
        d = self.dir
        return ['git -C "%s" add "%s"' % (d, key),
                'git -C "%s" commit -m "proposal %s"' % (d, rev_label),
                'git -C "%s" pull --rebase origin %s' % (d, self.branch),
                'git -C "%s" push origin HEAD:refs/heads/%s' % (d, self.branch)]


# ---------------------------------------------------------------- svn

class SvnClaims:
    kind = 'svn'

    def __init__(self, state_dir, url):
        self.dir = os.path.join(state_dir, 'claims-wc')
        self.url = url.rstrip('/')

    @staticmethod
    def _svn(*args, **kw):
        return run_ok(['svn'] + list(args) + ['--non-interactive'], **kw)

    @staticmethod
    def _not_found(err):
        return re.search(r'E200009|E170000|W170000|W160013|E160013|non-existent|not found', err, re.I)

    def _exists(self, url):
        code, _, err = run(['svn', 'info', url, '--non-interactive'])
        if code == 0:
            return True
        if self._not_found(err):
            return False
        raise VcsError('svn info %s failed: %s' % (url, err.strip().splitlines()[:1]))

    def read(self, key):
        code, out, err = run(['svn', 'cat', '%s/%s/CLAIM.md' % (self.url, key), '--non-interactive'])
        if code != 0:
            if self._not_found(err):
                return None
            raise VcsError('svn cat failed: %s' % err.strip().splitlines()[:1])
        c = parse_claim(text(out))
        c['has_report'] = self._exists('%s/%s/REPORT.md' % (self.url, key))
        return c

    def list(self):
        code, out, err = run(['svn', 'ls', '-R', self.url, '--non-interactive'])
        if code != 0:
            if self._not_found(err):
                return []
            raise VcsError('svn ls failed: %s' % err.strip().splitlines()[:1])
        names = [ln.strip() for ln in text(out).splitlines()]
        keys = sorted(set(n.split('/', 1)[0] for n in names if n.endswith('/CLAIM.md')))
        files = set(names)
        out_list = []
        for k in keys:
            code, body, _ = run(['svn', 'cat', '%s/%s/CLAIM.md' % (self.url, k), '--non-interactive'])
            c = parse_claim(text(body)) if code == 0 else dict.fromkeys(CLAIM_FIELDS, '')
            c['has_report'] = (k + '/REPORT.md') in files
            c['key'] = k
            out_list.append(c)
        return out_list

    def _checkout(self, create=False):
        """The private sparse checkout of the claims URL; create=True makes the URL on the
        server first when it does not exist (part of the first claim's write)."""
        if os.path.isdir(os.path.join(self.dir, '.svn')):
            code, out, _ = run(['svn', 'info', '--show-item', 'url', self.dir, '--non-interactive'])
            if code == 0 and unquote(text(out).strip().rstrip('/')) == unquote(self.url):
                self._svn('update', '--quiet', self.dir)
                return self.dir
            shutil.rmtree(self.dir)
        if create and not self._exists(self.url):
            self._svn('mkdir', '--parents', '-m', 'claims area', self.url)
        os.makedirs(os.path.dirname(self.dir), exist_ok=True)
        self._svn('checkout', '--quiet', '--depth', 'empty', self.url, self.dir)
        return self.dir

    def claim(self, key, body, message, claimer, machine=None, before_commit=None):
        folder = None
        try:
            held = self.read(key)
            if held is not None:
                if _is_mine(held, claimer, machine):
                    return 'won', 'already claimed by this machine'
                return 'lost', 'claimed by %s' % held.get('claimer')
            self._checkout(create=True)
            folder = os.path.join(self.dir, key)
            if os.path.exists(folder):
                shutil.rmtree(folder)
            os.makedirs(folder)
            with open(os.path.join(folder, 'CLAIM.md'), 'w', encoding='utf-8', newline='\n') as fh:
                fh.write(body)
            self._svn('add', '--quiet', folder)
            if before_commit is not None:
                before_commit()
            code, _, err = run(['svn', 'commit', '--quiet', '-m', message, folder, '--non-interactive'])
            if code == 0:
                return 'won', 'committed %s/CLAIM.md' % key
            self._discard(folder)
            if CONFLICT_SVN.search(err):
                return 'lost', 'another claim was committed first (%s)' % err.strip().splitlines()[0]
            return 'failed', err.strip().splitlines()[0] if err.strip() else 'svn commit exit %d' % code
        except VcsError as exc:
            if folder:
                self._discard(folder)
            return 'failed', str(exc)

    def _discard(self, folder):
        run(['svn', 'revert', '--quiet', '-R', folder, '--non-interactive'])
        if os.path.exists(folder):
            shutil.rmtree(folder, ignore_errors=True)

    def folder(self, key):
        return os.path.join(self.dir, key)

    def prepare_folder(self, key):
        self._checkout()
        run_ok(['svn', 'update', '--quiet', '--set-depth', 'infinity', self.folder(key), '--non-interactive'])
        os.makedirs(self.folder(key), exist_ok=True)
        return self.folder(key)

    def publish_commands(self, key, rev_label):
        f = self.folder(key)
        return ['svn add --force "%s"' % f, 'svn commit -m "proposal %s" "%s"' % (rev_label, f)]


def open_claims(kind, state_dir, cfg_claim, wc=None):
    """The claims area of the configuration ('claim' section); wc resolves a git remote
    name to its URL and an svn ^/ URL to an absolute one."""
    if kind == 'git':
        g = cfg_claim.get('git', {})
        remote = g.get('remote', 'origin')
        url = remote
        if wc is not None and '/' not in remote and '\\' not in remote and ':' not in remote:
            url = text(run_ok(['git', '-C', wc.root, 'remote', 'get-url', remote])).strip()
        return GitClaims(state_dir, url, g.get('branch', 'test-claims'))
    s = cfg_claim.get('svn', {})
    url = s.get('url', '')
    if not url:
        raise VcsError('claim.svn.url is not configured')
    if url.startswith('^/'):
        if wc is None:
            raise VcsError('a ^/ claims URL needs the working copy to resolve it')
        url = wc.repo_root.rstrip('/') + url[1:]
    return SvnClaims(state_dir, url)
