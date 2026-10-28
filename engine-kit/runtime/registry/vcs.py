#!/usr/bin/env python3
"""vcs.py - tiny version-control adapter of the registry tools (engine-kit runtime).

It answers one question: which files under a folder have pending changes in the
working copy? Git and svn are supported. The kind of working copy is detected by
walking up from the folder to the nearest `.git` (file or folder) or `.svn` folder,
or forced with `--vcs git|svn`. Read-only: it runs `git status` / `svn status` (and
`git rev-parse`, `git ls-tree`) and nothing else - it never commits, adds, updates or reverts.

  detect(root, vcs='auto')  -> 'git' | 'svn'   (VcsError when neither is found)
  changed_files(root, vcs='auto', md_only=False, include_deleted=False,
                svn_client_ignored=False)
      -> sorted [(status, absolute path)] of the files under root, status one of
         A  added (also copied, renamed-to, replaced, intent-to-add)
         M  modified (content, properties, type change, conflict)
         ?  unversioned (an unversioned folder is expanded into its files)
         D  deleted or missing - only with include_deleted=True (the file is gone)
  has_commit(root, vcs='auto') -> bool
      False while nothing under root was ever committed (git: no HEAD, or no file under
      root in HEAD; svn: no node under root with a commit revision above 0 - every one
      unversioned or added): the first commit is still to come

Ignored files are never listed. On svn that includes what the CLIENT ignores: the
`global-ignores` of the user's svn configuration (or svn's built-in list when it sets
none). svn_client_ignored=True (EK#17, opt-in, off by default) runs svn status with that
list emptied, so a file only the client hides is listed as `?`; a file the REPOSITORY
ignores (`svn:ignore`, `svn:global-ignores`) stays hidden. Git is unaffected: `git status
--ignored` cannot tell the repository's `.gitignore` from the client's own excludes.

CLI (to see what the tools see):
  python vcs.py [--root <folder>] [--vcs auto|git|svn] [--md-only] [--deleted]
                [--svn-client-ignored]

Python 3.8+, standard library only.
"""

import argparse
import os
import subprocess
import sys
import xml.etree.ElementTree as ET

VCS_CHOICES = ('auto', 'git', 'svn')
TIMEOUT = 300  # seconds; a large svn working copy is slow to stat
SKIP_DIRS = {'.git', '.svn', '.hg'}
SVN_ITEMS = {'unversioned': '?', 'added': 'A', 'replaced': 'A', 'modified': 'M',
             'conflicted': 'M', 'merged': 'M', 'deleted': 'D', 'missing': 'D'}
# empties the client's ignore list for one call; the repository's ignore properties still apply
SVN_NO_CLIENT_IGNORES = ['--config-option', 'config:miscellany:global-ignores=']


class VcsError(Exception):
    """The working copy cannot be read: no VCS found, binary missing, command failed."""


def add_vcs_argument(parser):
    parser.add_argument('--vcs', choices=VCS_CHOICES, default='auto',
                        help='version control of the working copy (default: auto-detect)')
    parser.add_argument('--svn-client-ignored', action='store_true',
                        help="svn: also list, as unversioned, files that only the client's global-ignores "
                             'hides (EK#17); the repository\'s ignore properties still apply. No effect on git')


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


def _run(cmd):
    try:
        proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=TIMEOUT)
    except FileNotFoundError:
        raise VcsError('%s not found on PATH' % cmd[0])
    except subprocess.TimeoutExpired:
        raise VcsError('%s timed out after %d s' % (' '.join(cmd[:2]), TIMEOUT))
    message = proc.stderr.decode('utf-8', 'replace').strip().splitlines()
    # svn status on a folder outside a working copy only warns (W155007) and exits 0
    if proc.returncode != 0 or any('W155007' in line for line in message):
        raise VcsError('%s failed: %s' % (' '.join(cmd[:3]), message[0] if message else 'exit %d' % proc.returncode))
    return proc.stdout


# ---------------- git ----------------

def _git_status(xy):
    """Porcelain XY code -> A | M | ? | D ('' to ignore)."""
    if xy == '??':
        return '?'
    if xy == '!!':
        return ''
    if 'D' in xy:
        return 'D'
    if xy[0] in 'ARC' or xy[1] == 'A':
        return 'A'
    return 'M'


def _git_changes(root):
    # porcelain paths are relative to the repository top; the prefix maps them back to root
    prefix = _run(['git', '-C', root, 'rev-parse', '--show-prefix']).decode('utf-8', 'replace').strip()
    out = _run(['git', '-C', root, 'status', '--porcelain=v1', '-z', '--untracked-files=all', '--', '.'])
    items = out.split(b'\0')
    entries, i = [], 0
    while i < len(items):
        record = items[i]
        i += 1
        if len(record) < 4:
            continue
        xy = record[:2].decode('ascii', 'replace')
        path = record[3:].decode('utf-8', 'replace')
        if xy[0] in 'RC':
            i += 1  # with -z the original path follows the new one
        status = _git_status(xy)
        if not status or not path.startswith(prefix):
            continue
        entries.append((status, os.path.normpath(os.path.join(root, path[len(prefix):]))))
    return entries


# ---------------- svn ----------------

def _svn_changes(root, client_ignored=False):
    cmd = ['svn', 'status', '--xml', '--ignore-externals']
    if client_ignored:
        cmd += SVN_NO_CLIENT_IGNORES
    out = _run(cmd + [root])
    try:
        tree = ET.fromstring(out)
    except ET.ParseError as exc:
        raise VcsError('svn status --xml: unreadable output (%s)' % exc)
    entries = []
    for entry in tree.iter('entry'):
        wc = entry.find('wc-status')
        if wc is None:
            continue
        status = SVN_ITEMS.get(wc.get('item', ''), '')
        if not status and wc.get('props') in ('modified', 'conflicted'):
            status = 'M'
        if not status:
            continue  # normal, external, ignored, incomplete, obstructed
        path = entry.get('path', '')
        entries.append((status, os.path.normpath(path if os.path.isabs(path) else os.path.join(root, path))))
    return entries


# ---------------- public ----------------

def _inside(path, root):
    try:
        return os.path.normcase(os.path.commonpath([path, root])) == os.path.normcase(root)
    except ValueError:  # different drives
        return False


def _git_has_commit(root):
    try:
        proc = subprocess.run(['git', '-C', root, 'rev-parse', '--verify', '-q', 'HEAD'],
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=TIMEOUT)
    except FileNotFoundError:
        raise VcsError('git not found on PATH')
    except subprocess.TimeoutExpired:
        raise VcsError('git rev-parse timed out after %d s' % TIMEOUT)
    if proc.returncode == 1 and not proc.stdout.strip():
        return False  # an unborn branch: no commit at all
    if proc.returncode != 0:
        message = proc.stderr.decode('utf-8', 'replace').strip().splitlines()
        raise VcsError('git rev-parse failed: %s' % (message[0] if message else 'exit %d' % proc.returncode))
    # the root's own entries in HEAD (paths relative to -C): none while nothing under it was committed
    return bool(_run(['git', '-C', root, 'ls-tree', '--name-only', 'HEAD', '--', '.']).strip())


def _svn_has_commit(root):
    # the root and its immediate children are enough: a committed file has committed parents
    # up to the root's child; a fresh checkout of an empty repository sits at revision 0
    out = _run(['svn', 'status', '--xml', '--verbose', '--depth', 'immediates', '--ignore-externals', root])
    try:
        tree = ET.fromstring(out)
    except ET.ParseError as exc:
        raise VcsError('svn status --xml: unreadable output (%s)' % exc)
    for commit in tree.iter('commit'):
        try:
            if int(commit.get('revision', '0')) > 0:
                return True
        except ValueError:
            continue
    return False


def has_commit(root, vcs='auto'):
    """False while nothing under root was ever committed - the first commit is still to come:
    git, no HEAD or no file under root in HEAD; svn, no node under root with a commit revision
    above 0 (every one unversioned or added). Raises VcsError when it cannot be read."""
    root = os.path.abspath(root)
    kind = detect(root, vcs)
    return _git_has_commit(root) if kind == 'git' else _svn_has_commit(root)


def changed_files(root, vcs='auto', md_only=False, include_deleted=False, svn_client_ignored=False):
    """Sorted [(status, absolute path)] of the files under root with pending changes.
    svn_client_ignored=True (svn only, EK#17): also list, as '?', the files that only the
    client's global-ignores hides."""
    root = os.path.abspath(root)
    kind = detect(root, vcs)
    raw = _git_changes(root) if kind == 'git' else _svn_changes(root, svn_client_ignored)
    found = {}
    for status, full in raw:
        if not _inside(full, root):
            continue
        if status == 'D':
            if include_deleted:
                found[full] = 'D'
            continue
        if os.path.isdir(full):
            if status == '?':  # svn reports an unversioned folder once: expand it
                for dirpath, dirnames, filenames in os.walk(full):
                    dirnames[:] = [d for d in dirnames if d not in SKIP_DIRS]
                    for name in filenames:
                        found.setdefault(os.path.join(dirpath, name), '?')
            continue  # an added or modified folder lists its files separately
        if os.path.isfile(full):
            found.setdefault(full, status)
    return [(status, path) for path, status in sorted(found.items())
            if not md_only or path.lower().endswith('.md')]


def main(argv=None):
    ap = argparse.ArgumentParser(description='List the pending changes of a git or svn working copy (read-only)')
    ap.add_argument('--root', default=os.environ.get('KB_ROOT') or '.',
                    help='folder to inspect (default: $KB_ROOT, else the current folder)')
    add_vcs_argument(ap)
    ap.add_argument('--md-only', action='store_true', help='markdown files only')
    ap.add_argument('--deleted', action='store_true', help='include deleted and missing files')
    args = ap.parse_args(argv)
    root = os.path.abspath(args.root)
    try:
        kind = detect(root, args.vcs)
        entries = changed_files(root, kind, args.md_only, args.deleted, args.svn_client_ignored)
    except VcsError as exc:
        print('error: %s' % exc, file=sys.stderr)
        return 2
    for status, full in entries:
        print('%s %s' % (status, os.path.relpath(full, root).replace(os.sep, '/')))
    note = ''
    if args.svn_client_ignored:
        note = (' (client global-ignores not applied)' if kind == 'svn'
                else ' (--svn-client-ignored has no effect on git)')
    print('%s: %d changed file(s) under %s%s' % (kind, len(entries), root, note))
    return 0


if __name__ == '__main__':
    sys.exit(main())
