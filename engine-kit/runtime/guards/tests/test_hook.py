"""The guards hook end to end: launch.sh -> hook.ps1, fed the hook JSON that a PreToolUse
Bash / PowerShell commit or a PostToolUse edit sends, in throwaway git and svn working
copies. The commit door (EK#14): opted in, not opted in, a non-commit command, Python
absent, a testing config in block mode, a disabled door, a folder move in the command;
and the two guards still answering as before (edit and commit, warn and ask).

  cd runtime/guards
  python -m unittest discover -s tests

Needs sh (Git Bash on Windows), PowerShell (powershell.exe or pwsh) and git; the svn cases
need svn and svnadmin and are skipped without them. Everything happens in one temporary
folder. ENGINEKIT_GUARDS_DEBUG=1 makes hook.ps1 trace on stderr, so an empty stderr proves
that launch.sh ended the event without starting PowerShell.
"""

import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
GUARDS = os.path.dirname(HERE)
KIT = os.path.dirname(os.path.dirname(GUARDS))
LAUNCH = os.path.join(GUARDS, 'launch.sh')
FAKE_SUITE = os.path.join(KIT, 'runtime', 'testing', 'tests', 'fake_suite.py')
SH = shutil.which('sh')
PS = shutil.which('powershell.exe') or shutil.which('pwsh')
GIT_ENV = {'GIT_CONFIG_NOSYSTEM': '1', 'GIT_TERMINAL_PROMPT': '0'}
PYTHONS = ('python', 'python3', 'py', 'python.exe', 'python3.exe', 'py.exe')
EM_DASH = '\u2014'


def have(*tools):
    return all(shutil.which(t) is not None for t in tools)


def run(cmd, cwd=None):
    env = dict(os.environ)
    env.update(GIT_ENV)
    p = subprocess.run(cmd, cwd=cwd, env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p.returncode != 0:
        raise AssertionError('%s failed (%d): %s %s' % (' '.join(cmd), p.returncode,
                                                      p.stdout.decode('utf-8', 'replace'),
                                                      p.stderr.decode('utf-8', 'replace')))
    return p.stdout.decode('utf-8', 'replace')


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(body)


def write_json(path, obj):
    write(path, json.dumps(obj, indent=2) + '\n')


def file_url(path):
    return 'file:///' + os.path.abspath(path).replace('\\', '/').lstrip('/')


@unittest.skipUnless(SH and PS and have('git'), 'needs sh, PowerShell (powershell.exe or pwsh) and git on PATH')
class Hook(unittest.TestCase):

    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-guards-')
        self.marker = self.path('suite-ran')
        write_json(self.path('spec.json'), {'tests': {'calc.CalcTest.adds': 'pass'}, 'out': self.path('r.xml'),
                                            'marker': self.marker})

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

    # ------------------------------------------------------------ helpers
    def path(self, *parts):
        return os.path.join(self.tmp, *parts)

    def write_testing_cfg(self, wc, name='testing.json', **extra):
        cfg = {
            'line': 'main', 'workingCopy': '..', 'stateDir': self.path('state-' + os.path.basename(wc)),
            'suite': {'name': 'calc', 'command': [sys.executable, FAKE_SUITE, self.path('spec.json')],
                      'results': {'format': 'junit', 'path': self.path('r.xml')}},
            'paths': {'tests': ['^tests/'], 'untestable': [r'\.md$', r'^\.engine-kit/'],
                      'fixtures': [r'^tests/test_[^/]+\.py$']},
            'index': {'file': 'tests/INDEX.md'},
        }
        cfg.update(extra)
        write_json(os.path.join(wc, '.engine-kit', name), cfg)

    def project_files(self, wc, guards):
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 1\n')
        write(os.path.join(wc, 'tests', 'INDEX.md'), '# Tested changes\n')
        if guards is not None:
            write_json(os.path.join(wc, '.engine-kit', 'guards.json'), guards)
            self.write_testing_cfg(wc)

    def git_wc(self, name='git-wc', guards=None):
        wc = self.path(name)
        os.makedirs(wc)
        run(['git', 'init', '-q', '-b', 'main', wc])
        run(['git', '-C', wc, 'config', 'user.name', 'P'])
        run(['git', '-C', wc, 'config', 'user.email', 'p@example.invalid'])
        run(['git', '-C', wc, 'config', 'core.autocrlf', 'false'])
        self.project_files(wc, guards)
        run(['git', '-C', wc, 'add', '-A'])
        run(['git', '-C', wc, 'commit', '-q', '-m', 'start'])
        return wc

    def svn_wc(self, guards):
        repo = self.path('svn-repo')
        run(['svnadmin', 'create', repo])
        wc = self.path('svn-wc')
        run(['svn', 'checkout', '-q', file_url(repo), wc])
        self.project_files(wc, guards)
        run(['svn', 'add', '-q', '--force', wc])
        run(['svn', 'commit', '-q', '-m', 'start', wc])
        run(['svn', 'update', '-q', wc])
        return wc

    def launch(self, mode, tag, payload, path=None):
        env = dict(os.environ)
        env.update(GIT_ENV)
        env['ENGINEKIT_GUARDS_DEBUG'] = '1'
        if path is not None:
            env['PATH'] = path
        p = subprocess.run([SH, LAUNCH, mode, tag], input=json.dumps(payload).encode('utf-8'), env=env,
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=180)
        return p.returncode, p.stdout.decode('utf-8', 'replace'), p.stderr.decode('utf-8', 'replace')

    def commit(self, command, cwd, tool='Bash', mode='commit', path=None):
        payload = {'session_id': 'f00d-0001', 'transcript_path': self.path('t.jsonl'), 'cwd': cwd,
                   'permission_mode': 'default', 'hook_event_name': 'PreToolUse', 'tool_name': tool,
                   'tool_input': {'command': command, 'description': 'commit the change'},
                   'tool_use_id': 'toolu_01'}
        return self.launch(mode, tool.lower(), payload, path)

    def edit(self, file, cwd):
        payload = {'session_id': 'f00d-0001', 'transcript_path': self.path('t.jsonl'), 'cwd': cwd,
                   'hook_event_name': 'PostToolUse', 'tool_name': 'Write',
                   'tool_input': {'file_path': file, 'content': '...'}, 'tool_response': {'success': True}}
        return self.launch('post', 'edit', payload)

    def answer(self, result):
        code, out, err = result
        self.assertEqual(code, 0, err)
        self.assertTrue(out.strip(), 'expected a hook answer; stderr: %s' % err)
        return json.loads(out)

    def assertSilent(self, result, started):
        code, out, err = result
        self.assertEqual(code, 0, err)
        self.assertEqual(out, '', 'expected no hook answer')
        if started:
            self.assertIn('[guards', err, 'expected hook.ps1 to start (and say nothing)')
        else:
            self.assertNotIn('[guards', err, 'launch.sh should end this event without PowerShell')

    def assertWarnOnly(self, a, event='PreToolUse'):
        h = a['hookSpecificOutput']
        self.assertEqual(h['hookEventName'], event)
        self.assertNotIn('permissionDecision', h)
        self.assertIn(a['systemMessage'].split('\n')[0], h['additionalContext'])

    # ------------------------------------------------------------ the commit door, git
    def test_opted_in_git_commit_gets_the_door_warnings_and_goes_ahead(self):
        wc = self.git_wc(guards={'commitDoor': {'config': '.engine-kit/testing.json'}})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 2\n')
        write(os.path.join(wc, 'tests', 'test_calc.py'), 'DATA = "C:\\\\data\\\\calc.csv"\n')
        run(['git', '-C', wc, 'add', 'tests/test_calc.py'])
        a = self.answer(self.commit('git add -A && git commit -m "fix the total"', wc))
        self.assertWarnOnly(a)
        msg = a['systemMessage']
        self.assertIn('COMMIT-DOOR: the commit door of the project\'s suite has warnings', msg)
        self.assertIn('precommit: mixed commit, 2 path(s), gate warn', msg)
        self.assertIn('warn: fix and tests in one commit', msg)
        self.assertIn('warn: tests/test_calc.py has no row in the index of tested changes', msg)
        self.assertIn('warn: tests/test_calc.py reads a machine path', msg)
        self.assertTrue(msg.endswith('(warn-only: the commit goes ahead)'), msg)
        self.assertIn('never blocks from the plugin hook', a['hookSpecificOutput']['additionalContext'])
        self.assertFalse(os.path.exists(self.marker), 'warn-only: the suite does not run at commit')

    def test_powershell_tool_commit_gets_the_door_too(self):
        wc = self.git_wc(guards={'commitDoor': {}})  # config defaults to .engine-kit/testing.json
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 3\n')
        a = self.answer(self.commit('git commit -am fix', wc, tool='PowerShell'))
        self.assertWarnOnly(a)
        self.assertIn('warn: a fix without tests', a['systemMessage'])

    def test_a_block_testing_config_stays_warn_only_from_the_hook(self):
        wc = self.git_wc(guards={'commitDoor': {'config': '.engine-kit/block.json'}})
        self.write_testing_cfg(wc, 'block.json', gate={'mode': 'block'})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 4\n')
        a = self.answer(self.commit('git commit -am fix', wc))
        self.assertWarnOnly(a)
        self.assertIn('note: gate.mode is block in the testing config; from the plugin hook the door stays '
                      'warn-only', a['systemMessage'])
        self.assertIn('warn: a fix without tests', a['systemMessage'])
        self.assertFalse(os.path.exists(self.marker), 'the hook never runs the suite, even in block mode')

    def test_cd_into_an_opted_in_project_is_followed(self):
        wc = self.git_wc(guards={'commitDoor': {}})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 5\n')
        os.makedirs(self.path('elsewhere'))
        a = self.answer(self.commit('cd "%s" && git commit -am fix' % wc, self.path('elsewhere')))
        self.assertIn('warn: a fix without tests', a['systemMessage'])

    def test_a_broken_testing_config_is_one_warning(self):
        wc = self.git_wc(guards={'commitDoor': {'config': '.engine-kit/missing.json'}})
        a = self.answer(self.commit('git commit -am fix', wc))
        self.assertWarnOnly(a)
        self.assertIn("COMMIT-DOOR: commitDoor.config '.engine-kit/missing.json' not found", a['systemMessage'])
        write(os.path.join(wc, '.engine-kit', 'testing.json'), '{"suite": {}}\n')
        write_json(os.path.join(wc, '.engine-kit', 'guards.json'), {'commitDoor': {}})
        a = self.answer(self.commit('git commit -am fix', wc))
        self.assertIn('COMMIT-DOOR: the door could not run (exit 2)', a['systemMessage'])
        self.assertIn('error: suite.command', a['systemMessage'])

    # ------------------------------------------------------------ silence and cost
    def test_not_opted_in_is_silent_and_powershell_never_starts(self):
        wc = self.git_wc(guards=None)
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 6\n')
        self.assertSilent(self.commit('git commit -am fix', wc), started=False)
        self.assertSilent(self.commit('git commit -am fix', wc, tool='PowerShell'), started=False)
        self.assertSilent(self.edit(os.path.join(wc, 'src', 'calc.py'), wc), started=False)

    def test_a_folder_move_starts_powershell_which_finds_nothing(self):
        wc = self.git_wc(guards=None)
        self.assertSilent(self.commit('cd "%s" && git commit -am fix' % wc, wc), started=True)

    def test_a_disabled_or_absent_door_is_silent(self):
        wc = self.git_wc(guards={'commitDoor': {'enabled': False}})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 7\n')
        self.assertSilent(self.commit('git commit -am fix', wc), started=True)
        write_json(os.path.join(wc, '.engine-kit', 'guards.json'), {'commitGate': 'warn'})
        self.assertSilent(self.commit('git commit -am fix', wc), started=True)

    def test_a_non_commit_command_ends_in_launch_sh(self):
        wc = self.git_wc(guards={'commitDoor': {}})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 8\n')
        self.assertSilent(self.commit('git status --short', wc), started=False)
        self.assertSilent(self.commit('Get-ChildItem', wc, tool='PowerShell'), started=False)
        self.assertSilent(self.commit('svn info', wc, mode='ci'), started=False)

    def test_an_edit_in_a_door_only_project_ends_in_launch_sh(self):
        wc = self.git_wc(guards={'commitDoor': {}})
        self.assertSilent(self.edit(os.path.join(wc, 'src', 'calc.py'), wc), started=False)

    def test_python_absent_is_one_not_run_here_line(self):
        dirs = []
        for tool in (SH, shutil.which('cat'), PS):
            d = os.path.dirname(tool)
            if d not in dirs:
                dirs.append(d)
        for d in dirs:
            for name in PYTHONS:
                if os.path.exists(os.path.join(d, name)):
                    self.skipTest('%s holds %s: cannot hide Python from the hook here' % (d, name))
        wc = self.git_wc(guards={'commitDoor': {}})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 9\n')
        a = self.answer(self.commit('git commit -am fix', wc, path=os.pathsep.join(dirs)))
        self.assertWarnOnly(a)
        self.assertEqual(a['systemMessage'], 'COMMIT-DOOR: not run here - no Python 3.8+ on PATH '
                         '(python3, python, py -3); the commit goes ahead.\n(warn-only: the commit goes ahead)')

    # ------------------------------------------------------------ the commit door, svn
    @unittest.skipUnless(have('svn', 'svnadmin'), 'svn and svnadmin are not on PATH')
    def test_opted_in_svn_commit_and_ci_get_the_door_warnings(self):
        wc = self.svn_wc(guards={'commitDoor': {}})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 10\n')
        for command, mode in (('svn commit -m "fix the total"', 'commit'), ('svn ci -m fix', 'ci')):
            a = self.answer(self.commit(command, wc, mode=mode))
            self.assertWarnOnly(a)
            self.assertIn('precommit: fix commit, 1 path(s), gate warn', a['systemMessage'])
            self.assertIn('warn: a fix without tests', a['systemMessage'])
        os.makedirs(self.path('plain'))
        self.assertSilent(self.commit('svn commit -m x', self.path('plain')), started=False)

    # ------------------------------------------------------------ the guards (regression)
    def test_guards_still_answer_at_edit_and_commit(self):
        wc = self.git_wc(guards={'encoding': {'extensions': ['.js']}, 'revert': {'recentDays': 60},
                                 'commitDoor': {}})
        write(os.path.join(wc, 'src', 'keep.js'), 'var a = 1;\nvar b = 2;\nvar c = 3;\n')
        run(['git', '-C', wc, 'add', '-A'])
        run(['git', '-C', wc, 'commit', '-q', '-m', 'keep'])
        bad = os.path.join(wc, 'src', 'bad.js')
        write(bad, 'var t = "a %s b";\n' % EM_DASH)
        a = self.answer(self.edit(bad, wc))
        self.assertWarnOnly(a, 'PostToolUse')
        self.assertIn('ENCODING-GUARD', a['systemMessage'])
        run(['git', '-C', wc, 'add', 'src/bad.js'])
        write(os.path.join(wc, 'src', 'keep.js'), 'var a = 1;\nvar c = 3;\n')
        a = self.answer(self.commit('git commit -am change', wc))
        self.assertWarnOnly(a)
        msg = a['systemMessage']
        for head in ('ENCODING-GUARD', 'REVERT-GUARD', 'COMMIT-DOOR'):
            self.assertIn(head, msg)
        self.assertIn('a project that wants a confirmation sets "commitGate": "ask"', msg)

    def test_ask_answers_guard_findings_only(self):
        wc = self.git_wc(guards={'commitGate': 'ask', 'encoding': {'extensions': ['.js']}, 'commitDoor': {}})
        write(os.path.join(wc, 'src', 'calc.py'), 'x = 11\n')
        a = self.answer(self.commit('git commit -am fix', wc))
        self.assertWarnOnly(a)  # the door alone never asks
        write(os.path.join(wc, 'src', 'bad.js'), 'var t = "%s";\n' % EM_DASH)
        run(['git', '-C', wc, 'add', 'src/bad.js'])
        a = self.answer(self.commit('git commit -am fix', wc))
        h = a['hookSpecificOutput']
        self.assertEqual(h['permissionDecision'], 'ask')
        self.assertIn('ENCODING-GUARD', h['permissionDecisionReason'])
        self.assertIn('COMMIT-DOOR', h['permissionDecisionReason'])


if __name__ == '__main__':
    unittest.main()
