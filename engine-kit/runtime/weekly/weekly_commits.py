#!/usr/bin/env python3
"""weekly_commits.py - one author's commits in a week window, grouped by work item
(engine-kit runtime, the commit step of the weekly-report skill).

Reads git or svn history and nothing else (git log, svn log, svn info): it never
commits, updates, writes to a tracker or sends anything. Three rules the skill depends
on are enforced here, because each one failed silently in the case it came from:

  * The author FIELD is matched exactly (case-insensitive; git: the name or the email).
    `svn log --search` and `git log --author` also match other names that contain the
    text, and svn's search matches message text and paths too: they are pre-filters at
    most, never the filter.
  * Each commit is kept by its OWN date. svn resolves a date to the youngest revision
    before it, so a date range alone brings one revision from before the window.
  * Nothing is guessed. A commit whose message names no work item is listed as NO-ID,
    with the items of the same author's other commits of the same day as a hint; the
    person decides where it belongs.

Usage:
  python weekly_commits.py --author NAME [--author NAME2] --repo PATH|URL [--repo ...]
      [--vcs auto|git|svn] [--since YYYY-MM-DD] [--until YYYY-MM-DD]
      [--week-start thursday] [--today YYYY-MM-DD] [--utc-offset +HH:MM]
      [--id-pattern REGEX ...] [--git-date committer|author] [--ref REF ...]
      [--json FILE]

Window: --since to --until, both included, as local dates at --utc-offset (the commit
dates of git and svn are converted). Default --since: the most recent --week-start day
before --today (on that day itself, one week back); default --until: --today.
--id-pattern: a regular expression; its first group (or the whole match) is the work
item id. Repeat it for several id styles. Without one, every commit is NO-ID.
git: every branch, remote-tracking branch and tag (stashes and notes are not commits of
the work), or the --ref list; the date is the committer date unless --git-date author.
svn: a URL, or a working copy (its URL is logged); give the repository root to see every
branch.

Exit codes: 0 every source read; 1 at least one source could not be read (the others
are still reported and the unread ones are named); 2 usage error.

Python 3.8+, standard library only.
"""

import argparse
import datetime
import json
import os
import re
import subprocess
import sys
import xml.etree.ElementTree as ET

WEEKDAYS = ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')
SVN_URL_PREFIXES = ('svn://', 'svn+ssh://', 'http://', 'https://', 'file://')
TIMEOUT = 600  # seconds; a remote svn log over a busy week is slow
REC, FLD = '\x1e', '\x1f'
GIT_FORMAT = REC + FLD.join(['%H', '%an', '%ae', '%cI', '%aI', '%S', '%B']) + FLD
SVN_LINE_RE = re.compile(r'^/((?:[^/]+/)*?(?:trunk|branches/[^/]+|tags/[^/]+))(?:/|$)')
KIT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class SourceError(Exception):
    """A repository could not be read: not found, binary missing, command failed."""


# ---------------------------------------------------------------- window

def parse_offset(text):
    m = re.fullmatch(r'([+-])(\d{2}):?(\d{2})', text.strip())
    if not m or int(m.group(2)) > 23 or int(m.group(3)) > 59:
        raise ValueError('--utc-offset must look like +03:00 or -0300, not %r' % text)
    delta = datetime.timedelta(hours=int(m.group(2)), minutes=int(m.group(3)))
    return datetime.timezone(delta if m.group(1) == '+' else -delta)


def default_since(start_weekday, today):
    """The most recent start weekday before today; on that weekday itself, one week back."""
    target = WEEKDAYS.index(start_weekday.lower())
    back = (today.weekday() - target) % 7 or 7
    return today - datetime.timedelta(days=back)


def window(since, until, tz):
    """[start, end) as aware datetimes: local midnight of since to local midnight after until."""
    start = datetime.datetime.combine(since, datetime.time(0), tz)
    end = datetime.datetime.combine(until + datetime.timedelta(days=1), datetime.time(0), tz)
    return start, end


def parse_when(text):
    """An ISO 8601 instant from git (%cI) or svn (...Z, microseconds) -> aware datetime."""
    text = text.strip().replace('Z', '+00:00')
    m = re.match(r'^(.*T\d{2}:\d{2}:\d{2})(\.\d+)?([+-]\d{2}:\d{2})$', text)
    if not m:
        raise ValueError('unreadable date %r' % text)
    frac = (m.group(2) or '')[:7]  # fromisoformat (3.8) takes 3 or 6 digits
    if frac and len(frac) not in (4, 7):
        frac = frac.ljust(7, '0')
    return datetime.datetime.fromisoformat(m.group(1) + frac + m.group(3))


# ---------------------------------------------------------------- ids

def compile_patterns(patterns):
    compiled = []
    for p in patterns:
        try:
            compiled.append(re.compile(p))
        except re.error as exc:
            raise ValueError('--id-pattern %r: %s' % (p, exc))
    return compiled


def find_ids(message, patterns):
    """Work item ids in a message, in order of appearance per pattern, without repeats."""
    found = []
    for pat in patterns:
        for m in pat.finditer(message):
            value = next((g for g in m.groups() if g), None) if pat.groups else m.group(0)
            if value and value not in found:
                found.append(value)
    return found


# ---------------------------------------------------------------- sources

def _run(cmd):
    try:
        proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=TIMEOUT)
    except FileNotFoundError:
        raise SourceError('%s not found on PATH' % cmd[0])
    except subprocess.TimeoutExpired:
        raise SourceError('%s timed out after %d s' % (' '.join(cmd[:2]), TIMEOUT))
    if proc.returncode != 0:
        err = proc.stderr.decode('utf-8', 'replace').strip().splitlines()
        raise SourceError('%s failed: %s' % (' '.join(cmd[:2]), err[-1] if err else 'exit %d' % proc.returncode))
    return proc.stdout.decode('utf-8', 'replace')


def detect(repo, vcs='auto'):
    """'git' or 'svn': forced; an svn URL; or the nearest .git / .svn at or above the folder."""
    if vcs in ('git', 'svn'):
        return vcs
    if repo.lower().startswith(SVN_URL_PREFIXES):
        return 'svn'
    path = os.path.abspath(repo)
    if not os.path.isdir(path):
        raise SourceError('not a folder or an svn URL: %s' % repo)
    if os.path.isfile(os.path.join(path, 'HEAD')) and os.path.isdir(os.path.join(path, 'objects')):
        return 'git'  # a bare repository
    while True:
        if os.path.exists(os.path.join(path, '.git')):
            return 'git'
        if os.path.isdir(os.path.join(path, '.svn')):
            return 'svn'
        parent = os.path.dirname(path)
        if parent == path:
            raise SourceError('no git or svn working copy at or above %s' % repo)
        path = parent


def label_of(repo):
    return repo.rstrip('/\\').replace('\\', '/').rsplit('/', 1)[-1] or repo


def git_commits(repo, authors, start, end, date_kind='committer', refs=()):
    """Commits of the git repository whose author is one of `authors`, dated in [start, end)."""
    if not os.path.isdir(repo):
        raise SourceError('not a folder: %s' % repo)
    margin = (start - datetime.timedelta(days=2)).astimezone(datetime.timezone.utc)
    cmd = ['git', '-C', repo, '-c', 'core.quotepath=off', 'log', '--no-color', '--source',
           '--date-order', '--name-status', '--format=' + GIT_FORMAT,
           '--since=' + margin.strftime('%Y-%m-%dT%H:%M:%SZ')]  # a pre-filter; the date is checked below
    cmd += list(refs) if refs else ['--branches', '--remotes', '--tags']
    cmd.append('--')
    out = _run(cmd)
    wanted = {a.lower() for a in authors}
    commits = []
    for record in out.split(REC)[1:]:
        parts = record.split(FLD)
        if len(parts) < 7:
            continue
        sha, name, email, cdate, adate, source, body = parts[:7]
        if name.strip().lower() not in wanted and email.strip().lower() not in wanted:
            continue
        when = parse_when(adate if date_kind == 'author' else cdate)
        if not start <= when < end:
            continue
        paths = []
        for line in (parts[7] if len(parts) > 7 else '').splitlines():
            m = re.match(r'^([A-Z])\d*\t(.+)$', line)
            if m:
                paths.append([m.group(1), m.group(2).split('\t')[-1]])
        ref = re.sub(r'^refs/(heads|remotes|tags)/', '', source.strip())
        commits.append({'rev': sha, 'short': sha[:10], 'author': name.strip(), 'when': when,
                        'lines': [ref] if ref else [], 'paths': paths, 'message': body.strip()})
    return commits


def svn_target(repo):
    if repo.lower().startswith(SVN_URL_PREFIXES):
        return repo
    if not os.path.isdir(repo):
        raise SourceError('not a folder or an svn URL: %s' % repo)
    out = _run(['svn', 'info', '--xml', '--non-interactive', repo])
    try:
        url = ET.fromstring(out.encode('utf-8')).findtext('entry/url')
    except ET.ParseError as exc:
        raise SourceError('svn info --xml: unreadable output (%s)' % exc)
    if not url:
        raise SourceError('svn info gave no URL for %s' % repo)
    return url


def svn_lines(paths):
    lines = []
    for _, path in paths:
        m = SVN_LINE_RE.match(path or '')
        line = m.group(1) if m else (path or '/').strip('/').split('/', 1)[0]
        if line and line not in lines:
            lines.append(line)
    return lines


def svn_commits(repo, authors, start, end):
    """Revisions under the svn URL or working copy whose author is one of `authors`, dated in [start, end)."""
    target = svn_target(repo)

    def stamp(d):
        return d.astimezone(datetime.timezone.utc).strftime('{%Y-%m-%dT%H:%MZ}')

    cmd = ['svn', 'log', '--xml', '-v', '--non-interactive', '-r', '%s:%s' % (stamp(start), stamp(end))]
    if not any(ch in a for a in authors for ch in '*?[]\\'):
        for a in authors:  # a pre-filter only: it also matches messages, paths and longer names
            cmd += ['--search', a]
    out = _run(cmd + [target])
    try:
        tree = ET.fromstring(out.encode('utf-8'))
    except ET.ParseError as exc:
        raise SourceError('svn log --xml: unreadable output (%s)' % exc)
    wanted = {a.lower() for a in authors}
    commits = []
    for entry in tree.findall('logentry'):
        author = (entry.findtext('author') or '').strip()
        if author.lower() not in wanted or not entry.findtext('date'):
            continue
        when = parse_when(entry.findtext('date'))
        if not start <= when < end:
            continue  # the revision svn resolved for the start date is older than the window
        paths_el = entry.find('paths')
        paths = [[p.get('action', '?'), p.text or ''] for p in paths_el] if paths_el is not None else []
        rev = 'r' + entry.get('revision', '?')
        commits.append({'rev': rev, 'short': rev, 'author': author, 'when': when,
                        'lines': svn_lines(paths), 'paths': paths,
                        'message': (entry.findtext('msg') or '').strip()})
    return commits


# ---------------------------------------------------------------- report

def collect(args, start, end, patterns):
    sources, commits = [], []
    for repo in args.repo:
        src = {'repo': repo, 'label': label_of(repo), 'vcs': None, 'commits': 0, 'error': None}
        try:
            kind = detect(repo, args.vcs)
            src['vcs'] = kind
            found = (git_commits(repo, args.author, start, end, args.git_date, args.ref) if kind == 'git'
                     else svn_commits(repo, args.author, start, end))
        except SourceError as exc:
            src['error'] = str(exc)
            sources.append(src)
            continue
        for c in found:
            c['source'], c['vcs'] = src['label'], kind
            c['items'] = find_ids(c['message'], patterns)
        src['commits'] = len(found)
        sources.append(src)
        commits.extend(found)
    commits.sort(key=lambda c: (c['when'], c['source'], c['rev']))
    return sources, commits


def group(commits, tz):
    items, no_id = {}, []
    for c in commits:
        for i in c['items']:
            items.setdefault(i, []).append(c)
    by_day = {}
    for c in commits:
        by_day.setdefault(c['when'].astimezone(tz).date(), []).append(c)
    for c in commits:
        if not c['items']:
            same = []
            for other in by_day[c['when'].astimezone(tz).date()]:
                for i in other['items']:
                    if i not in same:
                        same.append(i)
            no_id.append((c, same))
    return items, no_id


def first_line(message):
    for line in message.splitlines():
        line = line.strip()
        if line and not line.lower().startswith(('http://', 'https://')):
            return line
    return '(no message)'


def commit_line(c, tz, note=''):
    when = c['when'].astimezone(tz).strftime('%Y-%m-%d %H:%M')
    lines = ','.join(c['lines'])[:24]
    return '  %-10s %s  %-12s %-24s %s%s' % (c['short'], when, c['source'][:12], lines,
                                            first_line(c['message'])[:90], note)


def as_json(args, since, until, tz, start, end, sources, commits, items, no_id):
    def one(c):
        return {'source': c['source'], 'vcs': c['vcs'], 'rev': c['rev'], 'author': c['author'],
                'date': c['when'].astimezone(tz).isoformat(), 'lines': c['lines'], 'paths': c['paths'],
                'items': c['items'], 'message': c['message']}
    return {
        'authors': args.author,
        'window': {'since': since.isoformat(), 'until': until.isoformat(), 'utc_offset': args.utc_offset,
                   'start': start.isoformat(), 'end_exclusive': end.isoformat()},
        'sources': sources,
        'commits': [one(c) for c in commits],
        'items': {i: [c['rev'] for c in cs] for i, cs in items.items()},
        'no_id': [{'rev': c['rev'], 'source': c['source'], 'same_day_items': same} for c, same in no_id],
    }


def inside_kit(path):
    try:
        return os.path.normcase(os.path.commonpath([os.path.abspath(path), KIT_ROOT])) == os.path.normcase(KIT_ROOT)
    except ValueError:  # another drive
        return False


def parse_args(argv):
    ap = argparse.ArgumentParser(description="One author's commits in a week window, grouped by work item (git or svn, read-only).")
    ap.add_argument('--author', action='append', required=True,
                    help='the VCS author (git: name or email), exact; repeat for several identities of one person')
    ap.add_argument('--repo', action='append', required=True, help='a git repository or working copy, an svn URL or working copy; repeatable')
    ap.add_argument('--vcs', choices=('auto', 'git', 'svn'), default='auto')
    ap.add_argument('--since', help='first day of the window, YYYY-MM-DD (default: the last --week-start day)')
    ap.add_argument('--until', help='last day of the window, YYYY-MM-DD, included (default: --today)')
    ap.add_argument('--week-start', default='thursday', choices=WEEKDAYS)
    ap.add_argument('--today', help='YYYY-MM-DD (default: the local date of this machine)')
    ap.add_argument('--utc-offset', default='+00:00', help="the person's offset, e.g. -03:00 (default +00:00)")
    ap.add_argument('--id-pattern', action='append', default=[], help='regular expression of a work item id; group 1 or the whole match')
    ap.add_argument('--git-date', choices=('committer', 'author'), default='committer')
    ap.add_argument('--ref', action='append', default=[], help='git: read these refs only (default: branches, remotes, tags)')
    ap.add_argument('--json', help='also write the result as JSON to this file (outside the kit)')
    return ap.parse_args(argv)


def main(argv=None):
    try:
        sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    except (AttributeError, ValueError):
        pass
    args = parse_args(argv)
    try:
        tz = parse_offset(args.utc_offset)
        today = datetime.date.fromisoformat(args.today) if args.today else datetime.date.today()
        since = datetime.date.fromisoformat(args.since) if args.since else default_since(args.week_start, today)
        until = datetime.date.fromisoformat(args.until) if args.until else today
        patterns = compile_patterns(args.id_pattern)
    except ValueError as exc:
        print('error: %s' % exc, file=sys.stderr)
        return 2
    if until < since:
        print('error: --until %s is before --since %s' % (until, since), file=sys.stderr)
        return 2
    if args.json and inside_kit(args.json):
        print('error: --json %s is inside the kit; write case output elsewhere' % args.json, file=sys.stderr)
        return 2
    start, end = window(since, until, tz)
    sources, commits = collect(args, start, end, patterns)
    items, no_id = group(commits, tz)

    print('author: %s | window: %s .. %s (both included, UTC%s)' % (', '.join(args.author), since, until, args.utc_offset))
    for s in sources:
        if s['error']:
            print('NOT READ  %s: %s' % (s['repo'], s['error']))
        else:
            print('source    %s (%s): %d commit(s)' % (s['label'], s['vcs'], s['commits']))
    if not patterns:
        print('note: no --id-pattern given, so no commit is grouped')
    for item, cs in items.items():
        print('\n%s  %d commit(s)' % (item, len(cs)))
        for c in cs:
            others = [i for i in c['items'] if i != item]
            print(commit_line(c, tz, '  [also: %s]' % ', '.join(others) if others else ''))
    if no_id:
        print('\nNO-ID  %d commit(s) - the message names no item; the person decides where each belongs' % len(no_id))
        for c, same in no_id:
            print(commit_line(c, tz, '  [same day: %s]' % ', '.join(same) if same else ''))
    print('\nTOTAL %d commit(s); %d item(s)%s; %d NO-ID; %d source(s) not read'
          % (len(commits), len(items), (': ' + ', '.join(items)) if items else '', len(no_id),
             sum(1 for s in sources if s['error'])))
    if args.json:
        data = as_json(args, since, until, tz, start, end, sources, commits, items, no_id)
        folder = os.path.dirname(os.path.abspath(args.json))
        os.makedirs(folder, exist_ok=True)
        with open(args.json, 'w', encoding='utf-8', newline='\n') as fh:
            json.dump(data, fh, indent=1, ensure_ascii=False)
            fh.write('\n')
        print('written: %s' % args.json)
    return 1 if any(s['error'] for s in sources) else 0


if __name__ == '__main__':
    sys.exit(main())
