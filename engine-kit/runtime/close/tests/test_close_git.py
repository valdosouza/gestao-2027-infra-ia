"""The close script on a throwaway git knowledge base: each check, warn-only by default,
--strict, the configuration contract and its refusals. Uses the kit's real registry and
memory tools (never a copy); validate-registry.ps1 runs only where PowerShell is present."""

import os
import unittest

from helpers import (DOC, LOG, Scratch, area, check, git_commit_all, git_init, have, lines, make_kb,
                     powershell, run_json, run_text, write)

SKIP_GIT = 'git is not on PATH: the close script is not exercised on this machine'


@unittest.skipUnless(have('git'), SKIP_GIT)
class GitBase(Scratch):
    def setUp(self):
        super().setUp()
        self.kb = git_init(make_kb(self.path('kb')))
        git_commit_all(self.kb)

    def run_close(self, *argv, **cfg):
        args = ['--root', self.kb]
        if cfg:
            args += ['--config', self.config(cfg)]
        return run_json(args + list(argv))


class Basics(GitBase):
    def test_a_clean_base_reports_every_check_and_exits_zero(self):
        code, r = self.run_close()
        self.assertEqual(code, 0)
        self.assertEqual(r['mode'], 'warn')
        self.assertEqual(r['vcs'], 'git')
        status = {c['name']: c['status'] for c in r['checks']}
        self.assertEqual(status['scope'], 'ok')
        self.assertEqual(status['test-gate'], 'ok')
        self.assertEqual(status['retired'], 'not configured')
        self.assertEqual(status['memory'], 'not configured')
        self.assertEqual(status['decisions'], 'ok')
        self.assertEqual(status['ledger'], 'ok')
        self.assertEqual(r['fix'], 0)

    def test_the_text_report_names_the_mode_and_the_checklist(self):
        code, out = run_text(['--root', self.kb])
        self.assertEqual(code, 0)
        self.assertIn('warn-only (EK#6)', out)
        self.assertIn('== exit checklist', out)
        self.assertIn('[ ] Card decision stated for every fact >= 0.8', out)

    def test_only_and_skip(self):
        code, r = self.run_close('--only', 'scope,retired')
        self.assertEqual(check(r, 'ledger')['status'], 'skipped')
        self.assertEqual(check(r, 'scope')['status'], 'ok')
        code, r = self.run_close('--skip', 'scope')
        self.assertEqual(check(r, 'scope')['status'], 'skipped')
        self.assertEqual(check(r, 'test-gate')['status'], 'ok')


class Scope(GitBase):
    def test_touched_documents_only(self):
        write(os.path.join(self.kb, 'OLD.md'), '# Old, no scope\n')
        git_commit_all(self.kb, 'an old document without a Scope line')
        write(area(self.kb, 'MEMORY', 'new.md'), '# New\n\nNo scope.\n')                        # new, none
        write(area(self.kb, 'INDEX.md'), '# S\n\n**Scope**: case\n**Scope**: method\n')        # modified, two
        write(area(self.kb, 'fenced.md'), '# F\n\n```\n**Scope**: method\n```\n')               # only in a fence
        write(area(self.kb, 'alias.md'), '# A\n\n**Escopo**: metodo\n')                         # aliases
        write(area(self.kb, 'tenant.md'), '# T\n\n**Scope**: acme - the case key\n')            # a case value
        write(area(self.kb, 'odd.md'), '# O\n\n**Scope**: company\n')                           # unknown
        write(os.path.join(self.kb, 'templates', 'X.template.md'), '# X\n')                     # excluded
        code, r = self.run_close('--only', 'scope', caseValues=['acme'])
        found = sorted(lines(r, 'scope', 'fix'))
        self.assertEqual(code, 0)
        self.assertEqual(len(found), 4, found)
        joined = '\n'.join(found)
        for rel in ('MEMORY/new.md', 'SHIPPING/INDEX.md', 'fenced.md', 'odd.md'):
            self.assertIn(rel, joined)
        self.assertNotIn('OLD.md', joined)
        self.assertIn("unknown Scope value 'company'", joined)
        self.assertIn('2 Scope lines', joined)

    def test_the_line_is_read_after_the_front_matter(self):
        claims = ''.join('  - claim: "claim %d"\n    status: fact\n    confidence: 0.9\n    evidence: "x.py:%d"\n'
                         % (n, n) for n in range(15))  # 60 lines of claims: the title falls past line 50
        front = '---\nproject: ORD\nsubject: SHIPPING\nconsolidated: false\nclaims:\n' + claims + '---\n'
        fm_lines = front.count('\n')
        write(area(self.kb, 'MEMORY', 'long-log.md'), front + '# Session log\n\n**Scope**: case\n\nBody.\n')
        write(area(self.kb, 'MEMORY', 'no-scope.md'), front + '# Session log\n\nBody.\n')
        write(area(self.kb, 'MEMORY', 'in-yaml.md'), front.replace('---\nproject', '---\n**Scope**: case\nproject')
              + '# Session log\n')  # inside the front matter: not the grep-able token
        write(area(self.kb, 'MEMORY', 'unclosed.md'), '---\nproject: ORD\n' + '\n' * 60 + '**Scope**: case\n')
        write(area(self.kb, 'MEMORY', 'bom.md'), '\ufeff' + front + '# Log\n\n**Scope**: case\n')
        write(area(self.kb, 'MEMORY', 'dots.md'), '---\nproject: ORD\n...\n# Log\n\n**Scope**: case\n')
        write(area(self.kb, 'MEMORY', 'short.md'), '---\nproject: ORD\n---\n# Log\n\n' + '\n' * 50
              + '**Scope**: case\n')  # the 50 lines are counted after the front matter, never more
        code, r = self.run_close('--only', 'scope')
        found = sorted(lines(r, 'scope', 'fix'))
        self.assertEqual(found, sorted([
            'no Scope line in the first 50 lines after the front matter (lines 1-%d): '
            'projects/orders/SUBJECT/SHIPPING/MEMORY/in-yaml.md' % (fm_lines + 1),
            'no Scope line in the first 50 lines after the front matter (lines 1-%d): '
            'projects/orders/SUBJECT/SHIPPING/MEMORY/no-scope.md' % fm_lines,
            'no Scope line in the first 50 lines after the front matter (lines 1-3): '
            'projects/orders/SUBJECT/SHIPPING/MEMORY/short.md',
            'no Scope line in the first 50 lines: projects/orders/SUBJECT/SHIPPING/MEMORY/unclosed.md']), found)
        import close
        long_front = '---\n' + 'k: v\n' * close.FRONT_MATTER_MAX + '---\n# Log\n\n**Scope**: case\n'
        write(area(self.kb, 'MEMORY', 'no-scope.md'), long_front)  # past the bound: read from the top
        code, r = self.run_close('--only', 'scope', checks={'scope': {'head': 600}})
        self.assertNotIn('no-scope.md', '\n'.join(lines(r, 'scope', 'fix')))
        self.assertEqual(close.front_matter_end(long_front.splitlines()), 0)

    def test_warn_only_strict_and_the_level(self):
        write(area(self.kb, 'MEMORY', 'new.md'), '# New\n')
        self.assertEqual(self.run_close('--only', 'scope')[0], 0)
        self.assertEqual(self.run_close('--only', 'scope', '--strict')[0], 1)
        self.assertEqual(self.run_close('--only', 'scope', mode='strict', decision='WS#7')[0], 1)
        code, r = self.run_close('--only', 'scope', '--strict', checks={'scope': {'level': 'warn'}})
        self.assertEqual((code, r['fix'], r['warn']), (0, 0, 1))
        code, out = run_text(['--root', self.kb, '--only', 'scope', '--strict'])
        self.assertIn('without "decision"', out)


class Unversioned(GitBase):
    def test_new_files_ignored_files_and_a_second_working_copy(self):
        write(area(self.kb, 'MEMORY', 'log.md'), DOC % 'log')
        write(os.path.join(self.kb, 'build.log'), 'x\n')
        write(os.path.join(self.kb, 'out', 'big.bin'), 'x\n')
        write(os.path.join(self.kb, '.gitignore'), 'out/\n')
        app = git_init(self.path('app'))
        write(os.path.join(app, 'README.txt'), 'app\n')
        git_commit_all(app)
        write(os.path.join(app, 'src', 'calc.py'), 'x = 1\n')
        cfg = {'workingCopies': [{'path': '.', 'label': 'kb'}, {'path': '../app', 'label': 'application'},
                                 {'path': '../gone', 'label': 'missing'}],
               'checks': {'unversioned': {'ignore': ['**/*.log']}}}
        code, r = self.run_close('--only', 'unversioned', **cfg)
        warns = '\n'.join(lines(r, 'unversioned', 'warn'))
        self.assertEqual(code, 0)
        self.assertIn('kb: not under version control: projects/orders/SUBJECT/SHIPPING/MEMORY/log.md', warns)
        self.assertIn('kb: not under version control: .gitignore', warns)
        self.assertIn('application: not under version control: src/calc.py', warns)
        self.assertIn('missing: working copy not found', warns)
        self.assertNotIn('build.log', warns)
        self.assertNotIn('big.bin', warns)
        self.assertIn('kb: add each one when it is created - git add <file>', lines(r, 'unversioned', 'note'))
        from helpers import sh
        sh(['git', '-C', self.kb, 'add', '.gitignore', 'projects'])
        code, r = self.run_close('--only', 'unversioned', **cfg)
        self.assertNotIn('kb: not', '\n'.join(lines(r, 'unversioned', 'warn')))

    def test_fix_and_tests_are_listed_apart(self):
        app = git_init(self.path('app'))
        write(os.path.join(app, 'src', 'calc.py'), 'x = 1\n')
        write(os.path.join(app, 'tests', 'test_calc.py'), 't\n')
        git_commit_all(app)
        write(os.path.join(app, 'src', 'calc.py'), 'x = 2\n')
        write(os.path.join(app, 'tests', 'test_calc.py'), 't2\n')
        cfg = {'workingCopies': [{'path': '../app', 'label': 'application'}],
               'checks': {'unversioned': {'testPaths': ['^tests/']}}}
        code, r = self.run_close('--only', 'unversioned', **cfg)
        notes = lines(r, 'unversioned', 'note')
        self.assertIn('application: 1 fix file(s) and 1 test file(s) pending - two commits, the fix first', notes)
        self.assertIn('  fix:   src/calc.py', notes)
        self.assertIn('  tests: tests/test_calc.py', notes)

    def test_generated_files_of_this_run_are_seen(self):
        write(area(self.kb, 'MEMORY', '2026-10-21-cr-123.md'), LOG % 1)
        code, r = self.run_close('--only', 'decisions,ledger,unversioned')
        warns = '\n'.join(lines(r, 'unversioned', 'warn'))
        self.assertIn('_REGISTRY/DECISIONS-INDEX.md', warns)
        self.assertIn('projects/orders/_REGISTRY/LEDGER.md', warns)


class TestGate(GitBase):
    def setUp(self):
        super().setUp()
        self.ticket = area(self.kb, 'TICKETS', 'CR-123')

    def test_closing_record_without_evidence_warns_and_never_blocks(self):
        write(os.path.join(self.ticket, 'CLOSE.md'), DOC % 'Close CR-123')
        code, r = self.run_close('--only', 'test-gate', '--strict')
        self.assertEqual(code, 0)
        self.assertIn('no test evidence', lines(r, 'test-gate', 'warn')[0])

    def test_not_run_here_index_row_and_exempt(self):
        write(os.path.join(self.ticket, 'CLOSE.md'), DOC % 'Close CR-123')
        write(os.path.join(self.ticket, 'TESTS', 'SUITE_main_2026-10-21.md'),
              DOC % 'Evidence' + '\nnot run here: <reason - the toolchain>\nnot run here: no runtime on this machine\n')
        index = os.path.join(self.kb, 'projects', 'orders', 'TESTSUITE', 'INDEX.md')
        write(index, DOC % 'Tested changes' + '\n| Change | Tests |\n|---|---|\n| CR-99 | t1 |\n')
        cfg = {'checks': {'test-gate': {'indexFiles': ['projects/orders/TESTSUITE/INDEX.md']}}}
        code, r = self.run_close('--only', 'test-gate', **cfg)
        warns = lines(r, 'test-gate', 'warn')
        self.assertEqual(len(warns), 2, warns)
        self.assertIn('suite not run here (no runtime on this machine)', warns[0])
        self.assertIn('no row for CR-123', warns[1])
        write(os.path.join(self.ticket, 'PLAN.md'), DOC % 'Plan' + '\n## Test plan\nexempt: <reason>\n')
        self.assertEqual(len(lines(self.run_close('--only', 'test-gate', **cfg)[1], 'test-gate', 'warn')), 2)
        write(os.path.join(self.ticket, 'PLAN.md'), DOC % 'Plan' + '\n## Test plan\nexempt: a per-client part with no suite\n')
        code, r = self.run_close('--only', 'test-gate', **cfg)
        self.assertEqual(len(lines(r, 'test-gate', 'warn')), 1)
        write(os.path.join(self.ticket, 'PLAN.md'), DOC % 'Plan')
        write(index, DOC % 'Tested changes' + '\n| Change | Tests |\n|---|---|\n| CR-123, CR-99 | t1 |\n')
        code, r = self.run_close('--only', 'test-gate', **cfg)
        self.assertEqual(len(lines(r, 'test-gate', 'warn')), 1)  # only the run that is owed

    def test_one_warning_per_evidence_file_however_often_the_line_is_repeated(self):
        write(os.path.join(self.ticket, 'CLOSE.md'), DOC % 'Close CR-123')
        write(os.path.join(self.ticket, 'TESTS', 'SUITE_main_2026-10-21.md'),
              DOC % 'Evidence' + '\n## 1. What was run\n\nnot run here: prepared patch - applied by the tester\n'
              '\n## 9. Verdict\n\n- `not run here: prepared patch - applied by the tester`\n')
        code, r = self.run_close('--only', 'test-gate')
        warns = lines(r, 'test-gate', 'warn')
        self.assertEqual(len(warns), 1, warns)
        self.assertIn('suite not run here (prepared patch - applied by the tester) - the run is owed', warns[0])
        write(os.path.join(self.ticket, 'TESTS', 'SUITE_main_2026-10-22.md'),
              DOC % 'Evidence' + '\nscreens not run here: no browser on this machine\n'
              'export not run here: no archiver on this machine\n')
        code, r = self.run_close('--only', 'test-gate')
        warns = lines(r, 'test-gate', 'warn')
        self.assertEqual(len(warns), 2, warns)  # one per evidence file, its parts on one line
        self.assertIn('(no browser on this machine; no archiver on this machine)', warns[1])

    def test_explicit_ticket_and_a_clean_one(self):
        write(os.path.join(self.ticket, 'TESTS', 'SUITE_main_2026-10-21.md'), DOC % 'Evidence' + '\nGreen.\n')
        git_commit_all(self.kb, 'closed earlier')
        code, r = self.run_close('--only', 'test-gate')
        self.assertIn('no work item being closed', lines(r, 'test-gate', 'ok')[0])
        code, r = self.run_close('--only', 'test-gate', '--ticket', self.ticket)
        self.assertEqual(check(r, 'test-gate')['status'], 'ok')
        self.assertIn('SUITE_main_2026-10-21.md', lines(r, 'test-gate', 'ok')[0])


class Retired(GitBase):
    CFG = {'checks': {'retired': {'locations': [
        {'spellings': ['R:\\old-share\\kb', '\\\\files01\\old-share\\kb'], 'instead': 'the KB working copy'}]}}}

    def test_every_spelling_in_normative_files_only(self):
        write(os.path.join(self.kb, 'AGENTS.md'), DOC % 'Rules' + '\nMemory lives in R:/old-share/kb/memory.\n')
        write(os.path.join(self.kb, 'skills', 'a', 'SKILL.md'), DOC % 'A' + '\nRead //files01/old-share/kb/x.\n')
        write(os.path.join(self.kb, '.claude', 'settings.json'), '{"allow": ["Read(R:\\\\old-share\\\\kb\\\\**)"]}\n')
        write(area(self.kb, 'INDEX.md'), DOC % 'S' + '\nThe old copy in R:\\old-share\\kb was retired in March.\n')
        write(area(self.kb, 'MEMORY', 'log.md'), DOC % 'log' + '\nI read R:\\old-share\\kb today.\n')
        write(os.path.join(self.kb, 'skills', 'old', 'SKILL.md'),
              '# Old\n\n**SUPERSEDED**: see skills/a\n\nR:\\old-share\\kb\n')
        cfg_path = os.path.join(self.kb, '.engine-kit', 'close.json')
        import json
        write(cfg_path, json.dumps(self.CFG))
        code, r = run_json(['--root', self.kb, '--only', 'retired'])
        found = '\n'.join(lines(r, 'retired', 'fix'))
        self.assertEqual(code, 0)
        self.assertEqual(check(r, 'retired')['fix'], 3, found)
        self.assertIn('AGENTS.md:7', found)
        self.assertIn('skills/a/SKILL.md:7', found)
        self.assertIn('.claude/settings.json:1', found)
        self.assertIn('instead: the KB working copy', found)
        for absent in ('INDEX.md', 'MEMORY/log.md', 'skills/old', 'close.json'):
            self.assertNotIn(absent, found)
        self.assertEqual(run_json(['--root', self.kb, '--only', 'retired', '--strict'])[0], 1)


class RegistryTools(GitBase):
    def test_a_citation_of_a_missing_decision_fails_and_dry_run_writes_nothing(self):
        write(area(self.kb, 'MEMORY', '2026-10-21-cr-123.md'), (LOG % 1).replace('ORD#1', 'ORD#9'))
        code, r = self.run_close('--only', 'decisions', '--dry-run')
        found = '\n'.join(lines(r, 'decisions', 'fix'))
        self.assertIn('ORD#9', found)
        self.assertFalse(os.path.exists(os.path.join(self.kb, '_REGISTRY', 'DECISIONS-INDEX.md')))
        self.assertEqual(self.run_close('--only', 'decisions', '--strict')[0], 1)
        self.assertTrue(os.path.exists(os.path.join(self.kb, '_REGISTRY', 'DECISIONS-INDEX.md')))

    def test_tenant_scope_needs_the_project_key(self):
        code, r = self.run_close('--only', 'registries', checks={'registries': {'validateRegistry': False}})
        self.assertTrue(any('--check-scope: not run' in t for t in lines(r, 'registries', 'note')))
        code, r = self.run_close('--only', 'registries', '--project', 'ORD',
                                 checks={'registries': {'validateRegistry': False}})
        self.assertTrue(any('--check-scope' in t for t in lines(r, 'registries', 'ok')))

    def test_without_a_projects_registry_the_tools_say_so(self):
        bare = git_init(make_kb(self.path('bare'), registry=False))
        code, r = run_json(['--root', bare, '--only', 'decisions,ledger'])
        self.assertEqual(check(r, 'decisions')['status'], 'not configured')
        self.assertEqual(check(r, 'ledger')['status'], 'not configured')

    def test_ledger_and_memory_index_with_the_consolidation_flag(self):
        for n in range(5):
            write(area(self.kb, 'MEMORY', '2026-10-%02d-session.md' % (n + 1)), LOG % n)
        db = self.path('runtime-area', 'memory-index.db')
        code, r = self.run_close('--only', 'ledger,memory', checks={'memory': {'db': db}})
        self.assertTrue(os.path.isfile(db))
        self.assertTrue(os.path.isfile(os.path.join(self.kb, 'projects', 'orders', '_REGISTRY', 'LEDGER.md')))
        flags = lines(r, 'memory', 'warn')
        self.assertEqual(len(flags), 1, flags)
        self.assertIn('ORD/SHIPPING: 5 logs', flags[0])
        self.assertIn('run the consolidation cycle', flags[0])
        code, r = self.run_close('--only', 'memory', '--dry-run', checks={'memory': {'db': db}})
        self.assertEqual(check(r, 'memory')['status'], 'skipped')

    def test_validate_registry_not_run_here_without_powershell(self):
        code, r = self.run_close('--only', 'registries',
                                 checks={'registries': {'powershell': 'no-such-shell-here', 'projectsCheck': False}})
        self.assertEqual(check(r, 'registries')['status'], 'not run here')
        self.assertIn('no PowerShell here (no-such-shell-here)', lines(r, 'registries', 'notrun')[0])

    @unittest.skipUnless(powershell(), 'PowerShell is not on PATH: validate-registry.ps1 is not exercised here')
    def test_validate_registry_drift_is_a_finding(self):
        write(os.path.join(self.kb, 'projects', 'orders', 'REGISTRY_SUBJECTS.md'),
              DOC % 'Subjects' + '\n| Subject | Path | Status |\n|---|---|---|\n'
              '| SHIPPING | SUBJECT/SHIPPING | documented |\n| BILLING | SUBJECT/BILLING | skeleton |\n')
        code, r = self.run_close('--only', 'registries', checks={'registries': {'projectsCheck': False}})
        found = '\n'.join(lines(r, 'registries', 'fix'))
        self.assertIn('validate-registry.ps1', found)
        self.assertIn('BILLING', found)


class Configuration(GitBase):
    def test_refusals_exit_two(self):
        bad_json = self.path('bad.json')
        write(bad_json, '{"mode": ')
        cases = [
            ['--config', bad_json],
            ['--config', self.path('missing.json')],
            ['--config', self.config({'checks': {'testGate': {}}})],
            ['--config', self.config({'mode': 'block'})],
            ['--config', self.config({'checks': {'scope': {'level': 'error'}}})],
            ['--config', self.config({'caseValues': 'acme'})],
            ['--config', self.config({'checks': {'unversioned': {'testPaths': ['(']}}})],
            ['--config', self.config({'checks': {'retired': {'locations': [{'spelling': 'x'}]}}})],
            ['--config', self.config({'workingCopies': [{'label': 'no path'}]})],
            ['--config', self.config({'svnClientIgnored': 'yes'})],
            ['--config', self.config({'workingCopies': [{'path': '.', 'svnClientIgnored': 1}]})],
            ['--only', 'scope,nonsense'],
        ]
        for extra in cases:
            code, out = run_text(['--root', self.kb] + extra)
            self.assertEqual(code, 2, (extra, out))
            self.assertIn('error:', out)
        self.assertEqual(run_text(['--root', self.path('nowhere')])[0], 2)

    def test_the_example_configuration_loads(self):
        import close
        from helpers import CLOSE_DIR
        cfg = close.load_config(os.path.join(CLOSE_DIR, 'close.example.json'))
        self.assertEqual(cfg['checks']['test-gate']['level'], 'warn')
        self.assertEqual(len(close.retired.rules_from_config(cfg['checks']['retired'])), 4)
        self.assertIs(cfg['svnClientIgnored'], False)
        self.assertEqual(cfg['level'], 3)
        self.assertEqual(len(close.checklist_items(cfg['checklist'], 1)), 4)
        self.assertIn('**/prompt_*-draft.md', cfg['checks']['scope']['frozen'])

    def test_svn_client_ignored_changes_nothing_on_git(self):
        with open(os.path.join(self.kb, '.git', 'info', 'exclude'), 'a', encoding='utf-8') as fh:
            fh.write('hidden-*.md\n')  # the client's own ignore list in git
        write(area(self.kb, 'hidden-1.md'), '# Hidden, no scope\n')
        for value in (False, True):
            code, r = self.run_close('--only', 'scope,unversioned', svnClientIgnored=value)
            self.assertEqual(r['svnClientIgnored'], value)
            everything = '\n'.join(lines(r, 'scope') + lines(r, 'unversioned'))
            self.assertNotIn('hidden-1.md', everything)
            self.assertNotIn('EK#17', everything)

    def test_notes_are_ignored_and_the_default_file_is_found(self):
        import json
        write(os.path.join(self.kb, '.engine-kit', 'close.json'),
              json.dumps({'_comment': 'x', 'checks': {'scope': {'_note': 'y', 'level': 'warn'}}}))
        write(area(self.kb, 'MEMORY', 'new.md'), '# New\n')
        code, r = run_json(['--root', self.kb, '--only', 'scope', '--strict'])
        self.assertEqual((code, r['fix'], r['warn']), (0, 0, 1))
        self.assertTrue(r['config'].endswith('close.json'))


class NoVcs(Scratch):
    def test_a_folder_outside_version_control(self):
        kb = make_kb(self.path('plain'), registry=False)
        code, r = run_json(['--root', kb, '--only', 'scope,test-gate,unversioned'])
        self.assertEqual(code, 0)
        self.assertEqual(check(r, 'scope')['status'], 'not run here')
        self.assertEqual(check(r, 'unversioned')['status'], 'not run here')
        self.assertEqual(check(r, 'test-gate')['status'], 'not run here')


if __name__ == '__main__':
    unittest.main()
