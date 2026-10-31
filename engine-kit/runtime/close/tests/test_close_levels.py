"""The close script's adoption level ("level" 1, 2 or 3; default 3) and the frozen-source
class of the scope check, on a throwaway git knowledge base. A level leaves out the checks,
the registry validator and the exit-checklist items of a higher level, and at level 1 the
unversioned files are one note (they wait for the owner's release word); at every level, so
are the files of a working copy with no first commit yet; a frozen source (never edited: the
owner's draft, an archived source) is left unmarked, and a change to it is a finding."""

import os
import unittest

from helpers import (DOC, Scratch, check, git_commit_all, git_init, have, lines, make_kb, powershell,
                     run_json, run_text, write)

SKIP_GIT = 'git is not on PATH: the close script is not exercised on this machine'
DRAFT = 'rough notes - the orders app\n\npartial shipments, maybe\n'  # no title, no Scope: frozen as received


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


class Level(GitBase):
    def test_the_default_is_level_three_and_runs_every_check(self):
        code, r = self.run_close()
        self.assertEqual(r['level'], 3)
        self.assertFalse(any('level' in l for c in r['checks'] for l in lines(r, c['name'], 'skip')))
        self.assertEqual(len(r['checklist']), 8)
        self.assertIn('Card decision stated for every fact >= 0.8: new card / strengthened card / no card (why)',
                      r['checklist'])

    def test_level_one_leaves_out_the_higher_checks_and_the_validator(self):
        code, r = self.run_close(level=1)
        self.assertEqual((code, r['level']), (0, 1))
        self.assertEqual(lines(r, 'test-gate', 'skip'), ['level 2 check, skipped (the case is at level 1)'])
        self.assertEqual(lines(r, 'memory', 'skip'), ['level 3 check, skipped (the case is at level 1)'])
        self.assertIn('validate-registry.ps1: level 3, skipped (the case is at level 1)', lines(r, 'registries', 'skip'))
        self.assertFalse(any(o['tool'] == 'validate-registry.ps1' for o in check(r, 'registries')['output']))
        self.assertEqual(check(r, 'registries')['status'], 'ok')  # projects_check.py still runs (level 1)
        self.assertEqual(check(r, 'scope')['status'], 'ok')

    def test_level_two_runs_the_test_gate_but_not_the_memory_index(self):
        code, r = self.run_close(level=2)
        self.assertEqual(check(r, 'test-gate')['status'], 'ok')
        self.assertEqual(lines(r, 'memory', 'skip'), ['level 3 check, skipped (the case is at level 2)'])
        self.assertIn('validate-registry.ps1: level 3, skipped (the case is at level 2)', lines(r, 'registries', 'skip'))

    def test_the_checklist_lists_only_the_items_of_the_level(self):
        code, r = self.run_close(level=1)
        joined = '\n'.join(r['checklist'])
        self.assertEqual(len(r['checklist']), 4, r['checklist'])
        for absent in ('Episodic log', 'Card decision', 'Closing record', 'fix and tests'):
            self.assertNotIn(absent, joined)
        self.assertIn('after the release word', joined)
        code, r = self.run_close(level=2)
        joined = '\n'.join(r['checklist'])
        self.assertEqual(len(r['checklist']), 7, r['checklist'])
        self.assertIn('Episodic log', joined)
        self.assertIn('Closing record', joined)
        self.assertNotIn('Card decision', joined)
        cfg = self.config({'level': 1, 'checklist': ['Always', {'text': 'From two', 'level': 2}]})
        code, out = run_text(['--root', self.kb, '--config', cfg])
        self.assertIn('== exit checklist (level 1)', out)
        self.assertIn('[ ] Always', out)
        self.assertNotIn('From two', out)
        self.assertIn('level 1 - warn-only (EK#6)', out)

    def test_level_one_notes_the_unversioned_files_once(self):
        for n in range(3):
            write(os.path.join(self.kb, 'notes', 'n%d.md' % n), DOC % n)
        code, r = self.run_close('--only', 'unversioned', level=1)
        self.assertEqual(r['warn'], 0)
        notes = lines(r, 'unversioned', 'note')
        self.assertEqual(len(notes), 1, notes)
        self.assertIn("knowledge base: 3 new file(s) not under version control wait for the owner's release word",
                      notes[0])
        self.assertIn('git add <file>', notes[0])
        listed = [o['output'] for o in check(r, 'unversioned')['output']]
        self.assertEqual(listed, ['notes/n0.md\nnotes/n1.md\nnotes/n2.md'])
        self.assertIn('wait for the release word', check(r, 'unversioned')['detail'])
        code, out = run_text(['--root', self.kb, '--only', 'unversioned', '--level', '1', '--verbose'])
        self.assertIn('ok - knowledge base: 3 new file(s) wait for the release word', out)
        self.assertIn('   | notes/n1.md', out)
        code, r = self.run_close('--only', 'unversioned', level=2)  # level 2: one warning per file, as before
        self.assertEqual(r['warn'], 3)

    def test_the_command_line_level_wins_over_the_configuration(self):
        code, r = self.run_close('--level', '2', level=1)
        self.assertEqual(r['level'], 2)
        code, r = run_json(['--root', self.kb, '--level', '1'])
        self.assertEqual(r['level'], 1)
        self.assertEqual(run_text(['--root', self.kb, '--level', '4'])[0], 2)

    def test_a_level_that_is_not_one_two_or_three_is_refused(self):
        for value in (0, 4, '1', True, 2.0):
            code, out = run_text(['--root', self.kb, '--config', self.config({'level': value})])
            self.assertEqual(code, 2, (value, out))
            self.assertIn('level must be 1, 2 or 3', out)
        for item in ('', 5, {'text': 'x', 'level': 4}, {'text': ''}, {'level': 2}, {'text': 'x', 'when': 2}):
            code, out = run_text(['--root', self.kb, '--config', self.config({'checklist': [item]})])
            self.assertEqual(code, 2, (item, out))
            self.assertIn('checklist:', out)


@unittest.skipUnless(have('git'), SKIP_GIT)
class FirstCommit(Scratch):
    """A working copy with no commit yet: its first commit waits for the owner's release word, so
    its files are one note at every level; once a first commit exists, a warning per file again
    from level 2 (exit tests: a base whose first commit was tied to the release word, and a new
    code tree holding a red that waits for its go)."""

    NOTE = "knowledge base: no first commit yet - its first commit waits for the owner's release word: "

    def setUp(self):
        super().setUp()
        self.kb = git_init(make_kb(self.path('kb')))  # git init, nothing committed: no HEAD

    def unversioned(self, *argv, **cfg):
        args = ['--root', self.kb, '--only', 'unversioned'] + list(argv)
        if cfg:
            args += ['--config', self.config(cfg)]
        return run_json(args)

    def test_one_note_at_every_level_while_there_is_no_commit(self):
        for level in ('1', '2', '3'):
            code, r = self.unversioned('--level', level)
            self.assertEqual((code, r['warn'], r['fix']), (0, 0, 0), lines(r, 'unversioned'))
            notes = lines(r, 'unversioned', 'note')
            self.assertEqual(len(notes), 1, notes)
            self.assertTrue(notes[0].startswith(self.NOTE + '5 file(s); add them by path - git add <file> - when created'), notes[0])
            self.assertIn('git add <file>', notes[0])
            self.assertEqual(check(r, 'unversioned')['status'], 'ok')
            self.assertIn('knowledge base: first commit waits for the release word (5 file(s))',
                          check(r, 'unversioned')['detail'])
            listed = check(r, 'unversioned')['output'][0]['output'].splitlines()
            self.assertEqual(len(listed), 5)
            self.assertIn('_REGISTRY/PROJECTS.md', listed)
        from helpers import sh
        sh(['git', '-C', self.kb, 'add', 'AGENTS.md'])  # staging by path before the word changes nothing
        code, r = self.unversioned('--level', '2')
        self.assertEqual(r['warn'], 0)
        self.assertIn(self.NOTE + '5 file(s) (1 already added); add them by path', lines(r, 'unversioned', 'note')[0])

    def test_a_warning_per_file_once_the_first_commit_exists(self):
        git_commit_all(self.kb, 'the first commit, after the release word')
        write(os.path.join(self.kb, 'notes', 'new.md'), DOC % 'new')
        code, r = self.unversioned('--level', '2')
        self.assertEqual(lines(r, 'unversioned', 'warn'), ['knowledge base: not under version control: notes/new.md'])
        self.assertFalse(any('first commit' in n for n in lines(r, 'unversioned', 'note')))
        code, r = self.unversioned('--level', '1')  # level 1 keeps its own note
        self.assertIn("1 new file(s) not under version control wait for the owner's release word",
                      lines(r, 'unversioned', 'note')[0])

    def test_a_base_folder_inside_a_repository_with_commits(self):
        outer = git_init(self.path('outer'))
        write(os.path.join(outer, 'README.txt'), 'x\n')
        git_commit_all(outer)
        kb = make_kb(os.path.join(outer, 'kb'))  # HEAD exists, nothing under the base was committed
        code, r = run_json(['--root', kb, '--only', 'unversioned', '--level', '2'])
        self.assertEqual(r['warn'], 0, lines(r, 'unversioned'))
        self.assertTrue(lines(r, 'unversioned', 'note')[0].startswith(self.NOTE + '5 file(s)'))

    def test_a_new_code_tree_beside_a_committed_base(self):
        git_commit_all(self.kb)
        write(os.path.join(self.kb, 'notes', 'new.md'), DOC % 'new')
        app = git_init(self.path('app'))  # the code tree's own repository, no commit yet: a red waits
        write(os.path.join(app, 'src', 'calc.py'), 'def total():\n    return None\n')
        write(os.path.join(app, 'tests', 'test_calc.py'), 'assert total() == 3\n')
        code, r = self.unversioned('--level', '2', workingCopies=[
            {'path': '.', 'label': 'knowledge base'}, {'path': '../app', 'label': 'application'}],
            checks={'unversioned': {'testPaths': ['^tests/']}})
        self.assertEqual(lines(r, 'unversioned', 'warn'), ['knowledge base: not under version control: notes/new.md'])
        notes = lines(r, 'unversioned', 'note')
        self.assertIn("application: no first commit yet - its first commit waits for the owner's release word: "
                      "2 file(s); add them by path - git add <file> - when created, or with that commit where the case "
                      "tied staging to the word; "
                      "--verbose lists them", notes)
        self.assertIn('application: 1 fix file(s) and 1 test file(s) pending - two commits, the fix first', notes)
        self.assertIn('application: first commit waits for the release word (2 file(s))',
                      check(r, 'unversioned')['detail'])


class Frozen(GitBase):
    def test_the_frozen_draft_gets_no_finding_and_is_noted(self):
        write(os.path.join(self.kb, 'prompts', 'prompt_orders-draft.md'), DRAFT)
        write(os.path.join(self.kb, 'prompts', 'prompt_orders-draft-2.md'), DRAFT)
        write(os.path.join(self.kb, 'prompts', 'prompt_orders.md'), '# Front ORD\n\nNo scope yet.\n')
        code, r = self.run_close('--only', 'scope')
        fixes = lines(r, 'scope', 'fix')
        self.assertEqual(fixes, ['no Scope line in the first 50 lines: prompts/prompt_orders.md'])
        notes = lines(r, 'scope', 'note')
        self.assertIn('frozen source, never edited, no Scope line expected: prompts/prompt_orders-draft.md', notes)
        self.assertIn('frozen source, never edited, no Scope line expected: prompts/prompt_orders-draft-2.md', notes)

    def test_a_case_declares_its_own_frozen_sources_and_can_turn_the_default_off(self):
        write(os.path.join(self.kb, 'owner-notes.md'), DRAFT)
        write(os.path.join(self.kb, 'prompts', 'prompt_orders-draft.md'), DRAFT)
        code, r = self.run_close('--only', 'scope', checks={'scope': {'frozen': [
            '**/prompt_*-draft.md', '**/prompt_*-draft-*.md', 'owner-notes.md']}})
        self.assertEqual(check(r, 'scope')['fix'], 0, lines(r, 'scope'))
        self.assertEqual(len(lines(r, 'scope', 'note')), 2)
        code, r = self.run_close('--only', 'scope', checks={'scope': {'frozen': []}})
        self.assertEqual(check(r, 'scope')['fix'], 2, lines(r, 'scope'))

    def test_a_changed_frozen_source_is_a_finding(self):
        draft = os.path.join(self.kb, 'prompts', 'prompt_orders-draft.md')
        write(draft, DRAFT)
        git_commit_all(self.kb, 'the frozen draft')
        write(draft, DRAFT + 'an edit\n')
        code, r = self.run_close('--only', 'scope', '--strict')
        self.assertEqual(code, 1)
        self.assertIn('frozen source changed: prompts/prompt_orders-draft.md - it is never edited',
                      lines(r, 'scope', 'fix')[0])

    def test_the_owners_original_is_frozen_by_its_bytes(self):
        draft = os.path.join(self.kb, 'prompts', 'prompt_orders-draft.md')
        write(draft, DRAFT)
        git_commit_all(self.kb, 'the frozen copy')  # the copy needs not be touched to be found
        write(os.path.join(self.kb, 'owner-draft.md'), DRAFT)  # the owner's original, at the root
        write(os.path.join(self.kb, 'HISTORY', 'owner-draft.md'), DRAFT)  # moved or copied: the same bytes
        write(os.path.join(self.kb, 'owner-answer.md'), 'yes to every recommendation\n')  # the case lists it
        code, r = self.run_close('--only', 'scope')
        self.assertEqual(lines(r, 'scope', 'fix'), ['no Scope line in the first 50 lines: owner-answer.md'])
        notes = lines(r, 'scope', 'note')
        for rel in ('owner-draft.md', 'HISTORY/owner-draft.md'):
            self.assertIn('byte-identical to the frozen source prompts/prompt_orders-draft.md (its original), '
                          'never edited, no Scope line expected: %s' % rel, notes)
        code, r = self.run_close('--only', 'scope', checks={'scope': {'frozen': [
            '**/prompt_*-draft.md', '**/prompt_*-draft-*.md', 'owner-answer.md']}})
        self.assertEqual(check(r, 'scope')['fix'], 0, lines(r, 'scope'))
        self.assertEqual(len(lines(r, 'scope', 'note')), 3)
        write(os.path.join(self.kb, 'owner-draft.md'), DRAFT + 'the owner edits the original\n')
        code, r = self.run_close('--only', 'scope')  # no longer the original: a document of its own
        self.assertIn('no Scope line in the first 50 lines: owner-draft.md', lines(r, 'scope', 'fix'))
        code, r = self.run_close('--only', 'scope', checks={'scope': {'frozen': []}})  # no frozen source, no twin
        self.assertEqual(check(r, 'scope')['fix'], 3, lines(r, 'scope'))

    def test_a_document_with_its_scope_line_is_never_read_as_a_twin(self):
        write(os.path.join(self.kb, 'prompts', 'prompt_orders-draft.md'), DOC % 'Draft')
        write(os.path.join(self.kb, 'notes.md'), DOC % 'Draft')
        code, r = self.run_close('--only', 'scope')
        self.assertEqual(check(r, 'scope')['status'], 'ok', lines(r, 'scope'))
        self.assertIn('1 touched knowledge document(s), each with one Scope line', lines(r, 'scope', 'ok'))

    @unittest.skipUnless(powershell(), 'PowerShell is not on PATH: validate-registry.ps1 is not exercised here')
    def test_the_validator_sweep_leaves_the_frozen_sources_out(self):
        write(os.path.join(self.kb, 'prompts', 'prompt_orders-draft.md'), DRAFT)
        write(os.path.join(self.kb, 'owner-notes.md'), DRAFT + 'notes of their own\n')
        write(os.path.join(self.kb, 'owner-draft.md'), DRAFT)  # the original: left out with its copy
        sweep = {'registries': {'scopeAll': True, 'projectsCheck': False}}
        code, r = self.run_close('--only', 'registries', checks=sweep)
        found = '\n'.join(lines(r, 'registries', 'fix'))
        self.assertIn('owner-notes.md', found)
        self.assertNotIn('prompt_orders-draft.md', found)
        self.assertNotIn('owner-draft.md', found)
        sweep['scope'] = {'frozen': ['**/prompt_*-draft.md', 'owner-notes.md']}
        code, r = self.run_close('--only', 'registries', checks=sweep)
        self.assertEqual(check(r, 'registries')['fix'], 0, lines(r, 'registries'))
        self.assertIn('3 frozen source(s) left unmarked', check(r, 'registries')['output'][0]['output'])


if __name__ == '__main__':
    unittest.main()
