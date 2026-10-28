#!/usr/bin/env python3
"""vcsops.py - read-only git / svn adapter of the testing group (engine-kit runtime).

The same approach as runtime/registry/vcs.py and runtime/guards/guard-common.ps1: the kind
of working copy is detected by walking up to the nearest `.git` (file or folder) or `.svn`
folder (or forced), every command is a plain git / svn read, svn always runs with
--non-interactive and git with GIT_TERMINAL_PROMPT=0, so a scheduled run never waits for
a password. Nothing in this module writes to a repository or a working copy; the only
write of the testing group is the claim, in claims.py.

  WorkingCopy(root, vcs='auto')
    .state(ignore_unversioned)  -> {revision, commit_id, commit_author, dirty, mixed}
    .revision_info(rev)         -> {rev, label, author, email, committed_at, message, paths}
    .revisions_after(last, ref) -> [rev, ...] oldest first
    .revisions_between(old, new)-> [rev, ...] oldest first
    .head(ref)                  -> rev
    .head_has(path, ref)        -> bool: the line's head has that path (the stale check)
    .diff(rev)                  -> unified diff of that revision under the working copy
    .is_author(info, me)        -> bool

Paths are relative to the working-copy root given (not to the repository top), with
forward slashes; a changed path outside it is dropped.

Python 3.8+, standard library only.
"""

import os
import re
import shutil
import subprocess
import xml.etree.ElementTree as ET
from datetime import datetime, timezone
from urllib.parse import quote, unquote

TIMEOUT = 600  # seconds; a large svn working copy is slow to stat


class VcsError(Exception):
    """The working copy cannot be read: no VCS found, binary missing, command failed."""


def run(cmd, cwd=None, input_bytes=None, env=None, timeout=TIMEOUT):
    """(exit code, stdout bytes, stderr text). Raises VcsError only when the program
    cannot start or times out; the caller judges the exit code."""
    full_env = dict(os.environ)
    full_env['GIT_TERMINAL_PROMPT'] = '0'
    if env:
        full_env.update(env)
    try:
        proc = subprocess.run(cmd, cwd=cwd, input=input_bytes, stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE, env=full_env, timeout=timeout)
    except FileNotFoundError:
        raise VcsError('%s not found on PATH' % cmd[0])
    except subprocess.TimeoutExpired:
        raise VcsError('%s timed out after %d s' % (' '.join(cmd[:3]), timeout))
    return proc.returncode, proc.stdout, proc.stderr.decode('utf-8', 'replace')


def run_ok(cmd, cwd=None, input_bytes=None, env=None, timeout=TIMEOUT):
    code, out, err = run(cmd, cwd, input_bytes, env, timeout)
    lines = [ln for ln in err.strip().splitlines() if ln.strip()]
    # svn on a folder outside a working copy only warns (W155007) and exits 0
    if code != 0 or any('W155007' in ln for ln in lines):
        raise VcsError('%s failed: %s' % (' '.join(cmd[:4]), lines[0] if lines else 'exit %d' % code))
    return out


def text(data):
    return data.decode('utf-8', 'replace')


def detect(root, vcs='auto'):
    """'git' or 'svn': forced, or the nearest .git / .svn at or above root."""
    if vcs in ('git', 'svn'):
        return vcs
    path = os.path.abspath(root)
    while True:
        if os.path.exists(os.path.join(path, '.git')):
            return 'git'
        if os.path.isdir(os.path.join(path, '.svn')):
            return 'svn'
        parent = os.path.dirname(path)
        if parent == path:
            raise VcsError('no git or svn working copy at or above %s' % root)
        path = parent


def parse_time(value):
    """ISO 8601 from git (%cI) or svn (...Z, microseconds) -> aware UTC datetime."""
    v = value.strip()
    if v.endswith('Z'):
        v = v[:-1] + '+00:00'
    if '.' in v:  # Python 3.8 accepts at most 6 fraction digits
        head, rest = v.split('.', 1)
        digits = ''
        while rest and rest[0].isdigit():
            digits, rest = digits + rest[0], rest[1:]
        v = head + '.' + (digits + '000000')[:6] + rest
    dt = datetime.fromisoformat(v)
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    return dt.astimezone(timezone.utc)


class WorkingCopy:
    def __init__(self, root, vcs='auto'):
        self.root = os.path.abspath(root)
        if not os.path.isdir(self.root):
            raise VcsError('working copy %s does not exist' % self.root)
        self.kind = detect(self.root, vcs)
        if self.kind == 'git':
            self.top = os.path.abspath(text(run_ok(['git', '-C', self.root, 'rev-parse', '--show-toplevel'])).strip())
            self.prefix = text(run_ok(['git', '-C', self.root, 'rev-parse', '--show-prefix'])).strip()
        else:
            info = self._svn_info(self.root)
            self.url = info['url']
            self.repo_root = info['repo_root']
            self.repo_path = info['repo_path']

    # ---------------- helpers ----------------

    def git(self, *args, **kw):
        return run_ok(['git', '-C', self.root] + list(args), **kw)

    def svn(self, *args, **kw):
        return run_ok(['svn'] + list(args) + ['--non-interactive'], **kw)

    def _svn_info(self, target):
        out = self.svn('info', '--xml', target)
        try:
            entry = ET.fromstring(out).find('entry')
        except ET.ParseError as exc:
            raise VcsError('svn info --xml: unreadable output (%s)' % exc)
        if entry is None:
            raise VcsError('svn info: no entry for %s' % target)
        commit = entry.find('commit')
        author = commit.findtext('author', '') if commit is not None else ''
        rel = entry.findtext('relative-url', '')
        return {'revision': entry.get('revision', ''), 'url': entry.findtext('url', ''),
                'repo_root': entry.findtext('repository/root', ''),
                'repo_path': unquote(rel[1:] if rel.startswith('^') else rel).rstrip('/'),
                'commit_id': commit.get('revision', '') if commit is not None else '',
                'commit_author': author}

    def to_rel(self, path):
        """A VCS path (git: repository-top relative; svn: repository absolute) ->
        working-copy relative, or None when it lies outside the working copy."""
        if self.kind == 'git':
            p = path.replace('\\', '/')
            if not p.startswith(self.prefix):
                return None
            return p[len(self.prefix):]
        base = self.repo_path + '/'
        if path == self.repo_path:
            return ''
        if not path.startswith(base):
            return None
        return path[len(base):]

    @staticmethod
    def label(kind, rev):
        return 'r%s' % rev if kind == 'svn' else str(rev)[:12]

    # ---------------- state of the working copy ----------------

    def state(self, ignore_unversioned=False):
        """revision: what the tree is at (git HEAD, svn BASE of the root);
        commit_id / commit_author: the newest commit the tree reflects (git HEAD,
        svn last-changed revision of the root); dirty: [(status, path)] with status
        A M D ? (C = conflict); mixed: svn mixed-revision or switched tree (None when
        svnversion is not available; always False for git)."""
        if self.kind == 'git':
            code, out, _ = run(['git', '-C', self.root, 'rev-parse', '--verify', '-q', 'HEAD^{commit}'])
            head = text(out).strip() if code == 0 else ''
            author = ''
            if head:
                author = text(self.git('show', '-s', '--format=%an', head)).strip()
            untracked = '--untracked-files=no' if ignore_unversioned else '--untracked-files=all'
            out = self.git('status', '--porcelain=v1', '-z', untracked, '--', '.')
            dirty = []
            items = out.split(b'\0')
            i = 0
            while i < len(items):
                rec = items[i]
                i += 1
                if len(rec) < 4:
                    continue
                xy = rec[:2].decode('ascii', 'replace')
                path = text(rec[3:])
                if xy[0] in 'RC':
                    i += 1
                if xy == '!!':
                    continue
                rel = self.to_rel(path)
                if rel is None:
                    continue
                st = '?' if xy == '??' else ('C' if 'U' in xy or xy in ('AA', 'DD') else
                                              ('D' if 'D' in xy else ('A' if 'A' in xy else 'M')))
                dirty.append((st, rel))
            return {'kind': 'git', 'revision': head, 'commit_id': head, 'commit_author': author,
                    'dirty': sorted(dirty), 'mixed': False}
        info = self._svn_info(self.root)
        out = self.svn('status', '--xml', self.root)
        try:
            tree = ET.fromstring(out)
        except ET.ParseError as exc:
            raise VcsError('svn status --xml: unreadable output (%s)' % exc)
        items = {'added': 'A', 'replaced': 'A', 'modified': 'M', 'deleted': 'D', 'missing': 'D',
                 'conflicted': 'C', 'obstructed': 'C', 'incomplete': 'C', 'unversioned': '?'}
        dirty = []
        for entry in tree.iter('entry'):
            wc = entry.find('wc-status')
            if wc is None:
                continue
            st = items.get(wc.get('item', ''), '')
            if not st and wc.get('props') in ('modified', 'conflicted'):
                st = 'M'
            if wc.get('tree-conflicted') == 'true':
                st = 'C'
            if not st or (st == '?' and ignore_unversioned):
                continue
            path = entry.get('path', '')
            full = path if os.path.isabs(path) else os.path.join(self.root, path)
            rel = os.path.relpath(full, self.root).replace(os.sep, '/')
            dirty.append((st, '' if rel == '.' else rel))
        mixed = None
        if shutil.which('svnversion'):
            code, vout, _ = run(['svnversion', '-n', self.root])
            if code == 0:
                v = text(vout).strip()
                mixed = (':' in v) or ('S' in v)
        return {'kind': 'svn', 'revision': info['revision'], 'commit_id': info['commit_id'],
                'commit_author': info['commit_author'], 'dirty': sorted(dirty), 'mixed': mixed}

    # ---------------- revisions ----------------

    def head(self, ref='HEAD'):
        if self.kind == 'git':
            return text(self.git('rev-parse', '--verify', ref + '^{commit}')).strip()
        info = self._svn_info(self.url)
        return info['commit_id']

    def revisions_after(self, last, ref='HEAD'):
        """Revisions that reached ref after last, oldest first (git: first-parent line)."""
        if self.kind == 'git':
            out = text(self.git('rev-list', '--reverse', '--first-parent', '%s..%s' % (last, ref)))
            return [ln.strip() for ln in out.splitlines() if ln.strip()]
        head = int(self.head())
        if int(last) >= head:
            return []
        out = self.svn('log', '--xml', '-q', '-r', '%d:%d' % (int(last) + 1, head), self.url)
        tree = ET.fromstring(out)
        return sorted(int(e.get('revision')) for e in tree.iter('logentry'))

    def revision_info(self, rev):
        """None when the revision does not touch this working copy (svn) or does not exist."""
        if self.kind == 'git':
            code, out, _ = run(['git', '-C', self.root, 'show', '-s',
                                '--format=%H%x00%P%x00%an%x00%ae%x00%cI%x00%B', str(rev)])
            if code != 0:
                return None
            parts = text(out).split('\0', 5)
            sha, parents, author, email, when, message = parts[0].strip(), parts[1].split(), parts[2], parts[3], parts[4], parts[5]
            if parents:
                raw = self.git('diff', '--name-only', '-z', '--no-renames', parents[0], sha)
            else:
                raw = self.git('diff-tree', '--root', '--no-commit-id', '--name-only', '-r', '-z', sha)
            paths = []
            for p in text(raw).split('\0'):
                rel = self.to_rel(p) if p else None
                if rel:
                    paths.append(rel)
            return {'rev': sha, 'label': self.label('git', sha), 'author': author, 'email': email,
                    'committed_at': parse_time(when), 'message': message.strip(), 'paths': sorted(paths),
                    'parent': parents[0] if parents else ''}
        code, out, err = run(['svn', 'log', '--xml', '-v', '-r', str(int(rev)), self.url, '--non-interactive'])
        if code != 0:
            return None
        entry = ET.fromstring(out).find('logentry')
        if entry is None:
            return None
        paths = []
        for p in entry.iter('path'):
            rel = self.to_rel(p.text or '')
            if rel:
                paths.append(rel)
        return {'rev': int(rev), 'label': self.label('svn', rev), 'author': entry.findtext('author', ''),
                'email': '', 'committed_at': parse_time(entry.findtext('date', '')),
                'message': (entry.findtext('msg', '') or '').strip(), 'paths': sorted(paths), 'parent': ''}

    def revisions_between(self, old, new):
        """Revisions of the line after old up to new, oldest first (git: first-parent;
        svn: the revisions that touch this working copy's URL)."""
        if self.kind == 'git':
            out = text(self.git('rev-list', '--reverse', '--first-parent', '%s..%s' % (old, new)))
            return [ln.strip() for ln in out.splitlines() if ln.strip()]
        if int(new) <= int(old):
            return []
        out = self.svn('log', '--xml', '-q', '-r', '%d:%d' % (int(old) + 1, int(new)), self.url)
        return sorted(int(e.get('revision')) for e in ET.fromstring(out).iter('logentry'))

    def head_has(self, rel_path, ref=''):
        """Does the line's head have rel_path (relative to this working copy)? The stale
        check before concluding "no suite". git: ref (default the current branch's
        upstream) as last fetched - nothing is fetched here; svn: the line URL at HEAD, a
        server read. Raises VcsError when the head cannot be read."""
        rel = rel_path.replace('\\', '/').strip('/')
        if self.kind == 'git':
            ref = ref or '@{upstream}'
            code, out, err = run(['git', '-C', self.root, 'rev-parse', '--verify', '-q', ref + '^{commit}'])
            if code != 0:
                raise VcsError('cannot read the head %s of the line (set suite.headRef)' % ref)
            sha = text(out).strip()
            code, _, _ = run(['git', '-C', self.root, 'cat-file', '-e', '%s:%s%s' % (sha, self.prefix, rel)])
            return code == 0
        url = '%s/%s' % (self.url.rstrip('/'), quote(rel))
        code, _, err = run(['svn', 'ls', '--depth', 'empty', url, '--non-interactive'])
        if code == 0:
            return True
        if re.search(r'E200009|E170000|W160013|E160013|non-existent|not found', err, re.I):
            return False
        raise VcsError('svn ls %s failed: %s' % (url, (err.strip().splitlines() or ['exit %d' % code])[0]))

    def diff(self, rev):
        if self.kind == 'git':
            info = self.revision_info(rev)
            if info is None:
                raise VcsError('no revision %s' % rev)
            if info['parent']:
                return text(self.git('diff', '--no-color', '--no-ext-diff', info['parent'], info['rev'], '--', '.'))
            return text(self.git('show', '--format=', '--no-color', '--no-ext-diff', info['rev'], '--', '.'))
        return text(self.svn('diff', '--internal-diff', '-c', str(int(rev)), self.url))

    def is_author(self, info, me):
        if not me:
            return False
        me = me.strip().lower()
        return me in (info.get('author', '').strip().lower(), info.get('email', '').strip().lower())
