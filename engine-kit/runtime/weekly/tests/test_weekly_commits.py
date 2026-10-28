"""Tests of weekly_commits.py: the window, the id patterns, and one author's commits read
from a throwaway git repository and a throwaway svn repository (file://). Every scratch
folder lives under the system temporary folder and is removed afterwards; nothing reads
or writes outside it. The svn tests are skipped, with the reason, when svn and svnadmin
are not on PATH.

Run from runtime/weekly: python -m unittest discover -s tests
"""

import contextlib
import datetime
import io
import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))

import weekly_commits as wc  # noqa: E402

UTC = datetime.timezone.utc
ORD = r'\b(ORD-\d+)\b'
WINDOW = ['--since', '2026-09-10', '--until', '2026-09-16']  # Thursday to Wednesday
SKIP_SVN = 'svn and svnadmin are not on PATH: the svn source is not exercised on this machine'


def have(*tools):
    return all(shutil.which(t) for t in tools)


def sh(cmd, cwd=None, env=None):
    full = dict(os.environ, GIT_CONFIG_NOSYSTEM='1', GIT_TERMINAL_PROMPT='0')
    full.update(env or {})
    p = subprocess.run(cmd, cwd=cwd, env=full, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p.returncode != 0:
        raise AssertionError('%s failed: %s %s' % (' '.join(cmd), p.stdout.decode('utf-8', 'replace'),
                                                   p.stderr.decode('utf-8', 'replace')))
    return p.stdout.decode('utf-8', 'replace')


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(body)


def run_cli(argv):
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
        code = wc.main(argv)
    return code, buf.getvalue()


class Scratch(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-weekly-')

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


# ---------------------------------------------------------------- pure functions

class Window(unittest.TestCase):
    def test_default_since_is_the_last_start_day_and_a_full_week_on_that_day(self):
        thursday = datetime.date(2026, 9, 17)
        self.assertEqual(wc.default_since('thursday', thursday), datetime.date(2026, 9, 10))
        self.assertEqual(wc.default_since('thursday', datetime.date(2026, 9, 21)), thursday)  # a Monday
        self.assertEqual(wc.default_since('monday', datetime.date(2026, 9, 16)), datetime.date(2026, 9, 14))

    def test_the_window_runs_from_local_midnight_to_the_midnight_after_until(self):
        tz = wc.parse_offset('-03:00')
        start, end = wc.window(datetime.date(2026, 9, 10), datetime.date(2026, 9, 16), tz)
        self.assertEqual(start.astimezone(UTC), datetime.datetime(2026, 9, 10, 3, 0, tzinfo=UTC))
        self.assertEqual(end.astimezone(UTC), datetime.datetime(2026, 9, 17, 3, 0, tzinfo=UTC))

    def test_offsets_and_dates_are_parsed_strictly(self):
        self.assertEqual(wc.parse_offset('+0530').utcoffset(None), datetime.timedelta(hours=5, minutes=30))
        with self.assertRaises(ValueError):
            wc.parse_offset('3')
        svn_date = wc.parse_when('2026-09-10T08:00:00.123456Z')
        git_date = wc.parse_when('2026-09-10T05:00:00-03:00')
        self.assertEqual(svn_date.replace(microsecond=0), git_date)


class Ids(unittest.TestCase):
    def test_group_one_or_the_whole_match_in_order_without_repeats(self):
        pats = wc.compile_patterns([ORD, r'#\d{4}'])
        self.assertEqual(wc.find_ids('ORD-12 and ORD-7, again ORD-12; see #1234', pats),
                         ['ORD-12', 'ORD-7', '#1234'])
        self.assertEqual(wc.find_ids('nothing here', pats), [])

    def test_a_bad_pattern_is_a_usage_error(self):
        code, out = run_cli(['--author', 'ann', '--repo', '.', '--id-pattern', '(unclosed'])
        self.assertEqual(code, 2)
        self.assertIn('--id-pattern', out)


# ---------------------------------------------------------------- git

class GitSource(Scratch):
    def setUp(self):
        super().setUp()
        self.repo = self.path('product')
        sh(['git', 'init', '-q', '-b', 'main', self.repo])
        sh(['git', '-C', self.repo, 'config', 'core.autocrlf', 'false'])
        sh(['git', '-C', self.repo, 'config', 'user.name', 'ann'])
        sh(['git', '-C', self.repo, 'config', 'user.email', 'ann@example.invalid'])
        self.sha = {}
        self.commit('before', 'ann', '2026-09-09T23:30:00+00:00', 'ORD-100 before the window')
        self.commit('fix', 'ann', '2026-09-10T08:00:00+00:00', 'ORD-101 fix rounding of refunds')
        self.commit('other', 'joanna', '2026-09-11T09:00:00+00:00', 'ORD-101 review fixes, thanks ann')
        self.commit('tidy', 'ann', '2026-09-11T10:00:00+00:00', 'tidy imports')
        self.commit('codes', 'ann', '2026-09-11T15:00:00+00:00', 'ORD-102 reason codes; see also ORD-101')
        self.commit('rebased', 'ann', '2026-09-12T09:00:00+00:00', 'ORD-106 rebased late',
                    author_date='2026-09-08T09:00:00+00:00')
        self.commit('after', 'ann', '2026-09-17T00:30:00+00:00', 'ORD-104 late on Wednesday at UTC-3')
        sh(['git', '-C', self.repo, 'checkout', '-q', '-b', 'feature'])
        self.commit('branch', 'ann', '2026-09-12T11:00:00+00:00', 'ORD-103 draft on a branch')
        sh(['git', '-C', self.repo, 'checkout', '-q', 'main'])
        write(os.path.join(self.repo, 'f.txt'), 'local change\n')
        stamp = '2026-09-12T12:00:00+00:00'
        sh(['git', '-C', self.repo, 'stash', '-q'], env={'GIT_AUTHOR_DATE': stamp, 'GIT_COMMITTER_DATE': stamp})

    def commit(self, key, who, when, message, author_date=None):
        write(os.path.join(self.repo, 'f.txt'), key + '\n')
        sh(['git', '-C', self.repo, 'add', '-A'])
        env = {'GIT_AUTHOR_NAME': who, 'GIT_AUTHOR_EMAIL': who + '@example.invalid',
               'GIT_COMMITTER_NAME': who, 'GIT_COMMITTER_EMAIL': who + '@example.invalid',
               'GIT_AUTHOR_DATE': author_date or when, 'GIT_COMMITTER_DATE': when}
        sh(['git', '-C', self.repo, 'commit', '-q', '-m', message], env=env)
        self.sha[key] = sh(['git', '-C', self.repo, 'rev-parse', 'HEAD']).strip()

    def found(self, *extra):
        out = self.path('out', 'week.json')
        code, text = run_cli(['--author', 'ann', '--repo', self.repo, '--id-pattern', ORD, '--json', out]
                             + WINDOW + list(extra))
        self.assertEqual(code, 0, text)
        with open(out, encoding='utf-8') as fh:
            return json.load(fh), text

    def test_the_author_field_and_each_commit_date_decide(self):
        data, text = self.found()
        revs = [c['rev'] for c in data['commits']]
        self.assertEqual(revs, [self.sha[k] for k in ('fix', 'tidy', 'codes', 'rebased', 'branch')])
        self.assertNotIn(self.sha['other'], revs)   # "joanna" contains "ann"; her message names ann too
        self.assertNotIn(self.sha['before'], revs)
        self.assertNotIn(self.sha['after'], revs)
        self.assertIn('source    product (git): 5 commit(s)', text)

    def test_items_group_the_commits_and_a_no_id_commit_gets_the_same_day_hint(self):
        data, text = self.found()
        self.assertEqual(data['items']['ORD-101'], [self.sha['fix'], self.sha['codes']])
        self.assertEqual(data['items']['ORD-103'], [self.sha['branch']])
        self.assertEqual(data['no_id'], [{'rev': self.sha['tidy'], 'source': 'product',
                                          'same_day_items': ['ORD-102', 'ORD-101']}])
        self.assertIn('[same day: ORD-102, ORD-101]', text)
        self.assertIn('[also: ORD-101]', text)

    def test_branches_count_and_stashes_do_not(self):
        data, _ = self.found()
        stash = sh(['git', '-C', self.repo, 'rev-parse', 'refs/stash']).strip()
        self.assertNotIn(stash, [c['rev'] for c in data['commits']])
        branch = [c for c in data['commits'] if c['rev'] == self.sha['branch']][0]
        self.assertEqual(branch['lines'], ['feature'])

    def test_a_ref_list_narrows_the_history(self):
        data, _ = self.found('--ref', 'main')
        self.assertNotIn(self.sha['branch'], [c['rev'] for c in data['commits']])

    def test_the_author_date_is_an_option(self):
        data, _ = self.found('--git-date', 'author')
        self.assertNotIn(self.sha['rebased'], [c['rev'] for c in data['commits']])

    def test_the_window_follows_the_person_offset(self):
        data, _ = self.found('--utc-offset', '-03:00')
        revs = [c['rev'] for c in data['commits']]
        self.assertIn(self.sha['after'], revs)       # 2026-09-16 21:30 at UTC-3
        self.assertNotIn(self.sha['before'], revs)   # 2026-09-09 20:30 at UTC-3
        late = [c for c in data['commits'] if c['rev'] == self.sha['after']][0]
        self.assertEqual(late['date'], '2026-09-16T21:30:00-03:00')

    def test_the_default_window_comes_from_the_week_start_and_today(self):
        code, text = run_cli(['--author', 'ann', '--repo', self.repo, '--today', '2026-09-17'])
        self.assertEqual(code, 0, text)
        self.assertIn('window: 2026-09-10 .. 2026-09-17', text)
        self.assertIn('no --id-pattern given', text)

    def test_an_unreadable_source_is_named_and_the_others_still_count(self):
        code, text = run_cli(['--author', 'ann', '--repo', self.repo, '--repo', self.path('missing'),
                              '--id-pattern', ORD] + WINDOW)
        self.assertEqual(code, 1)
        self.assertIn('NOT READ  %s' % self.path('missing'), text)
        self.assertIn('TOTAL 5 commit(s)', text)
        self.assertIn('1 source(s) not read', text)

    def test_usage_errors(self):
        self.assertEqual(run_cli(['--author', 'ann', '--repo', self.repo,
                                  '--since', '2026-09-16', '--until', '2026-09-10'])[0], 2)
        inside = os.path.join(wc.KIT_ROOT, 'week.json')
        code, text = run_cli(['--author', 'ann', '--repo', self.repo, '--json', inside] + WINDOW)
        self.assertEqual(code, 2)
        self.assertIn('inside the kit', text)
        self.assertFalse(os.path.exists(inside))


# ---------------------------------------------------------------- svn

def file_url(path):
    return 'file:///' + os.path.abspath(path).replace('\\', '/').lstrip('/')


@unittest.skipUnless(have('svn', 'svnadmin'), SKIP_SVN)
class SvnSource(Scratch):
    def setUp(self):
        super().setUp()
        server = self.path('server')
        sh(['svnadmin', 'create', server])
        if os.name == 'nt':  # allow svn:date to be set, so that each revision gets a fixed date
            write(os.path.join(server, 'hooks', 'pre-revprop-change.bat'), '@exit 0\r\n')
        else:
            hook = os.path.join(server, 'hooks', 'pre-revprop-change')
            write(hook, '#!/bin/sh\nexit 0\n')
            os.chmod(hook, 0o755)
        self.url = file_url(server)
        # r0 carries the creation time (today); dates must rise with the revision for svn's
        # date lookup, as they do in a real repository, so r0 moves before every commit below
        sh(['svn', 'propset', '--revprop', '-q', '--non-interactive', '-r', '0', 'svn:date',
            '2026-08-31T00:00:00.000000Z', self.url])
        self.wc = self.path('wc')
        sh(['svn', 'checkout', '-q', '--non-interactive', self.url, self.wc])
        self.rev = {}
        self.commit('layout', 'ann', '2026-09-01T10:00:00', 'trunk/f.txt', 'layout')
        self.commit('before', 'ann', '2026-09-09T20:00:00', 'trunk/f.txt', 'ORD-100 before the window')
        self.commit('helper', 'bob', '2026-09-10T09:00:00', 'trunk/f.txt', 'ORD-101 helped ann with refunds')
        self.commit('fix', 'ann', '2026-09-10T10:00:00', 'trunk/f.txt', 'ORD-101 fix rounding of refunds')
        self.commit('tidy', 'ann', '2026-09-10T11:00:00', 'trunk/g.txt', 'tidy imports')
        self.commit('anna', 'anna', '2026-09-11T09:00:00', 'branches/2.1/f.txt', 'ORD-105 port')
        self.commit('port', 'ann', '2026-09-12T09:00:00', 'branches/2.1/f.txt', 'ORD-102 port to 2.1')
        self.commit('after', 'ann', '2026-09-18T09:00:00', 'trunk/f.txt', 'ORD-104 after the window')

    def commit(self, key, who, when, rel, message):
        write(os.path.join(self.wc, rel), key + '\n')
        sh(['svn', 'add', '--force', '-q', '--non-interactive', self.wc])
        out = sh(['svn', 'commit', '--non-interactive', '-m', message, '--username', who, self.wc])
        rev = int([ln for ln in out.splitlines() if ln.startswith('Committed revision')][0].split()[-1].rstrip('.'))
        sh(['svn', 'propset', '--revprop', '-q', '--non-interactive', '-r', str(rev), 'svn:date',
            when + '.000000Z', self.url])
        sh(['svn', 'update', '-q', '--non-interactive', self.wc])
        self.rev[key] = 'r%d' % rev

    def found(self, repo, *extra):
        out = self.path('out', 'week.json')
        code, text = run_cli(['--author', 'ann', '--repo', repo, '--id-pattern', ORD, '--json', out]
                             + WINDOW + list(extra))
        self.assertEqual(code, 0, text)
        with open(out, encoding='utf-8') as fh:
            return json.load(fh), text

    def test_the_revision_before_the_window_and_other_authors_are_left_out(self):
        data, text = self.found(self.url)
        revs = [c['rev'] for c in data['commits']]
        self.assertEqual(revs, [self.rev['fix'], self.rev['tidy'], self.rev['port']])
        # svn resolves the start date to the 'before' revision, and --search 'ann' matches
        # bob's message and anna's name: only the author field and each date decide
        self.assertIn('source    server (svn): 3 commit(s)', text)

    def test_lines_items_and_the_no_id_hint(self):
        data, _ = self.found(self.url)
        by_rev = {c['rev']: c for c in data['commits']}
        self.assertEqual(by_rev[self.rev['port']]['lines'], ['branches/2.1'])
        self.assertEqual(by_rev[self.rev['fix']]['lines'], ['trunk'])
        self.assertEqual(data['items'], {'ORD-101': [self.rev['fix']], 'ORD-102': [self.rev['port']]})
        self.assertEqual(data['no_id'][0]['same_day_items'], ['ORD-101'])

    def test_a_working_copy_is_read_through_its_url(self):
        data, _ = self.found(self.wc)
        self.assertEqual([c['rev'] for c in data['commits']], [self.rev['fix'], self.rev['tidy'], self.rev['port']])

    def test_git_and_svn_sources_in_one_report(self):
        repo = self.path('git')
        sh(['git', 'init', '-q', '-b', 'main', repo])
        write(os.path.join(repo, 'a.txt'), 'a\n')
        sh(['git', '-C', repo, 'add', '-A'])
        stamp = '2026-09-11T08:00:00+00:00'
        sh(['git', '-C', repo, '-c', 'user.name=ann', '-c', 'user.email=ann@example.invalid', 'commit', '-q',
            '-m', 'ORD-101 test for the rounding'], env={'GIT_AUTHOR_DATE': stamp, 'GIT_COMMITTER_DATE': stamp})
        code, text = run_cli(['--author', 'ann', '--repo', self.url, '--repo', repo, '--id-pattern', ORD] + WINDOW)
        self.assertEqual(code, 0, text)
        self.assertIn('ORD-101  2 commit(s)', text)
        self.assertIn('TOTAL 4 commit(s)', text)


if __name__ == '__main__':
    unittest.main()
