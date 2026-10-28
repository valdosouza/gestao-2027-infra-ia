#!/usr/bin/env python3
"""close.py - the close script: the mechanical checks of a closing, in one call
(engine-kit runtime; techniques T45, T88 and T78).

The closing step of a work item (skill close-and-retain) writes the closing texts and runs
the retention chain; this script then checks what a machine can check, and reports:

  registries   registries vs reality: validate-registry.ps1 when PowerShell is present
               (otherwise "not run here"; level 3 only), and, when the base has a projects
               registry, projects_check.py (inventory, touched front matter, tenant scope)
  scope        one valid Scope line in every touched knowledge document, read in the first
               lines after a YAML front matter (a long front matter of claims never pushes
               it out of reach); a frozen source (never edited: the owner's draft, an
               archived source) is left unmarked, and so is a document byte-identical to one
               (the owner's original of the draft)
  test-gate    a work item being closed has its test evidence (or its skip line) and,
               where the case keeps an index of tested changes, its row or an exempt line
               (level 2 and above)
  retired      no normative file points at a retired location, in any spelling (T88)
  decisions    decisions_index.py --check-touched, then the generated index
  ledger       ledger_gen.py --changed --cross-index
  memory       memory_index.py build; a subject at 5+ unconsolidated logs is flagged
               (level 3)
  unversioned  no new file outside version control in any working copy of the change
               (T78); pending fix and test files listed as two groups. At level 1 the new
               files wait for the owner's release word: one note, not a warning per file;
               at every level, so do the files of a working copy with no first commit yet

The case's adoption level ("level": 1, 2 or 3; default 3, every check) leaves out the
pieces of a higher level (docs/ADOPTION-LEVELS.md) and the exit-checklist items of a
higher level.

It reuses the kit's tools and never copies them; git and svn are read through
runtime/registry/vcs.py. It writes nothing itself: the generated decisions index, ledgers
and memory index are written by those tools (--dry-run asks them not to).

On svn, a file that only the client's global-ignores hides is invisible to the scope and
unversioned checks unless "svnClientIgnored": true in the configuration (EK#17, off by
default; a working copy may override it); the repository's ignore properties always apply.

Warn-only by default (EK#6): findings are reported and the exit code stays 0. --strict, or
"mode": "strict" in the configuration (set by a numbered project decision), exits 1 when a
check whose level is "fix" has a finding.

Usage:
  python close.py [--root DIR] [--config FILE] [--strict] [--vcs auto|git|svn]
                  [--level 1|2|3] [--project KEY] [--ticket DIR]... [--only A,B] [--skip A,B]
                  [--dry-run] [--json] [--verbose]
Exit codes: 0 clean, or findings while warn-only; 1 a finding at level "fix" with
--strict; 2 usage or configuration error.

Python 3.8+, standard library only.
"""

import argparse
import copy
import glob
import json
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
RUNTIME = os.path.dirname(HERE)
REGISTRY = os.path.join(RUNTIME, 'registry')
for _path in (HERE, REGISTRY):
    if _path not in sys.path:
        sys.path.insert(0, _path)
import retired  # noqa: E402  (sibling module)
import vcs  # noqa: E402  (runtime/registry/vcs.py, the shared read-only adapter)

VALIDATE_REGISTRY = os.path.join(RUNTIME, 'validate-registry.ps1')
PROJECTS_CHECK = os.path.join(REGISTRY, 'projects_check.py')
DECISIONS_INDEX = os.path.join(REGISTRY, 'decisions_index.py')
LEDGER_GEN = os.path.join(REGISTRY, 'ledger_gen.py')
MEMORY_INDEX = os.path.join(RUNTIME, 'memory_index.py')

CHECKS = ('registries', 'scope', 'test-gate', 'retired', 'decisions', 'ledger', 'memory', 'unversioned')
TITLES = {
    'registries': 'registries vs reality',
    'scope': 'Scope line on touched knowledge documents',
    'test-gate': 'test evidence of the work items being closed',
    'retired': 'retired locations in normative files',
    'decisions': 'decision citations and the generated index',
    'ledger': 'generated ledgers',
    'memory': 'memory index and consolidation flags',
    'unversioned': 'new files under version control, fix and tests apart',
}
DEFAULT_CONFIG = os.path.join('.engine-kit', 'close.json')
TOOL_TIMEOUT = 1800  # seconds
FRONT_MATTER_MAX = 500  # lines; a longer or unclosed front matter is not skipped by the Scope check
SKIP_DIRS = {'.git', '.svn', '.hg', 'node_modules', '__pycache__'}
LEVELS = ('fix', 'warn')
ADOPTION_LEVELS = (1, 2, 3)  # docs/ADOPTION-LEVELS.md: 1 Essential, 2 Governed, 3 Scale
CHECK_LEVEL = {'test-gate': 2, 'memory': 3}  # the earliest level of each check; the others are level 1
VALIDATOR_LEVEL = 3  # validate-registry.ps1, the registry validator

DEFAULTS = {
    'version': 1,
    'mode': 'warn',
    'decision': '',
    'level': 3,
    'vcs': 'auto',
    'svnClientIgnored': False,
    'caseValues': [],
    'projects': '_REGISTRY/PROJECTS.md',
    'workingCopies': [{'path': '.', 'label': 'knowledge base'}],
    'checks': {
        'registries': {'level': 'fix', 'validateRegistry': True, 'scopeAll': False, 'args': [],
                       'powershell': '', 'projectsCheck': True},
        'scope': {'level': 'fix', 'head': 50,
                  'exclude': ['**/*.template.md', '**/attachments/**', '**/node_modules/**'],
                  # frozen sources: never edited, so never marked (scope-census); the default is the
                  # frozen draft of frame-greenfield, prompts/prompt_<front>-draft.md and -draft-2.md
                  'frozen': ['**/prompt_*-draft.md', '**/prompt_*-draft-*.md']},
        'test-gate': {'level': 'warn', 'tickets': '**/TICKETS/*', 'closingRecord': 'CLOSE.md',
                      'evidence': ['TESTS/SUITE_*.md'],
                      'exemptIn': ['PLAN.md', 'SPEC.md', 'TESTS/TEST_PLAN.md'], 'indexFiles': []},
        'retired': {'level': 'fix', 'locations': [], 'patterns': [], 'caseSensitive': False,
                    'allowLine': r'(?i)\b(retired|superseded|frozen|formerly|archived)\b',
                    'supersededHead': 10,
                    'normative': {
                        'include': ['AGENTS.md', 'CLAUDE.md', 'GEMINI.md', '.cursorrules', 'README.md',
                                    '**/INDEX.md', '**/_REGISTRY/*.md', '**/REGISTRY_*.md',
                                    '**/skills/**', '**/agents/**', '**/.cursor/**', '**/.github/**',
                                    '**/.claude/**', '**/.engine-kit/**'],
                        'exclude': ['**/node_modules/**', '**/_ARCHIVE/**', '**/HISTORY/**',
                                    '**/DECISIONS-INDEX.md', '**/LEDGER.md', '**/LEDGER-ALL.md']}},
        'decisions': {'level': 'fix'},
        'ledger': {'level': 'fix'},
        'memory': {'level': 'fix', 'db': ''},
        'unversioned': {'level': 'warn', 'ignore': [], 'testPaths': [], 'maxListed': 40},
    },
    # an item is a string (every level) or {"text": ..., "level": n} (printed from level n on)
    'checklist': [
        'New knowledge classified and placed (retain-knowledge)',
        {'level': 2, 'text': 'Episodic log written, claims with evidence (revision, work item, card id)'},
        {'level': 3, 'text': 'Card decision stated for every fact >= 0.8: new card / strengthened card / no card (why)'},
        'Owning index or registry row updated; root rules only if the workspace state changed',
        'Nothing obsolete left without a SUPERSEDED mark',
        {'level': 2, 'text': 'Closing record written; tracker text prepared (or written by the sanctioned protocol)'},
        {'level': 2, 'text': 'Every new file under version control; fix and tests prepared as two commits, '
                             'the fix first'},
        'Commit, push and tracker state are the human\'s, after the release word',
    ],
}


class ConfigError(Exception):
    """The configuration or the command line cannot be used (exit 2)."""


# ---------------------------------------------------------------- configuration

def _strip_notes(value):
    if isinstance(value, dict):
        return {k: _strip_notes(v) for k, v in value.items() if not str(k).startswith('_')}
    if isinstance(value, list):
        return [_strip_notes(v) for v in value]
    return value


def _merge(base, override, where):
    out = copy.deepcopy(base)
    for key, value in override.items():
        if key not in base:
            raise ConfigError('unknown key %s%s' % (where, key))
        default = base[key]
        if isinstance(default, dict):
            if not isinstance(value, dict):
                raise ConfigError('%s%s must be an object' % (where, key))
            out[key] = _merge(default, value, '%s%s.' % (where, key))
            continue
        if isinstance(default, list) and not isinstance(value, list):
            raise ConfigError('%s%s must be a list' % (where, key))
        if isinstance(default, bool) and not isinstance(value, bool):
            raise ConfigError('%s%s must be true or false' % (where, key))
        if isinstance(default, str) and not isinstance(value, str):
            raise ConfigError('%s%s must be a string' % (where, key))
        out[key] = value
    return out


def load_config(path):
    """The defaults, merged with the file at path (None = defaults only)."""
    cfg = copy.deepcopy(DEFAULTS)
    if path:
        try:
            with open(path, 'r', encoding='utf-8-sig') as fh:
                data = json.load(fh)
        except (OSError, ValueError) as exc:
            raise ConfigError('configuration %s: %s' % (path, exc))
        if not isinstance(data, dict):
            raise ConfigError('configuration %s: the top level must be an object' % path)
        cfg = _merge(cfg, _strip_notes(data), '')
    if cfg['mode'] not in ('warn', 'strict'):
        raise ConfigError('mode must be "warn" or "strict", not %r' % cfg['mode'])
    if type(cfg['level']) is not int or cfg['level'] not in ADOPTION_LEVELS:
        raise ConfigError('level must be 1, 2 or 3 (the adoption level), not %r' % (cfg['level'],))
    for item in cfg['checklist']:
        if isinstance(item, str) and item.strip():
            continue
        if (isinstance(item, dict) and set(item) <= {'text', 'level'} and isinstance(item.get('text'), str)
                and item['text'].strip() and type(item.get('level', 1)) is int
                and item.get('level', 1) in ADOPTION_LEVELS):
            continue
        raise ConfigError('checklist: each item is a text or {"text": "...", "level": 1|2|3}, not %r' % (item,))
    if cfg['vcs'] not in vcs.VCS_CHOICES:
        raise ConfigError('vcs must be one of %s' % ', '.join(vcs.VCS_CHOICES))
    for name, section in cfg['checks'].items():
        if section.get('level') not in LEVELS:
            raise ConfigError('checks.%s.level must be "fix" or "warn"' % name)
    for wc in cfg['workingCopies']:
        if not isinstance(wc, dict) or not wc.get('path'):
            raise ConfigError('workingCopies: each entry is an object with a "path"')
        if not isinstance(wc.get('svnClientIgnored', False), bool):
            raise ConfigError('workingCopies: "svnClientIgnored" must be true or false (%s)' % wc['path'])
    try:
        retired.rules_from_config(cfg['checks']['retired'])
        re.compile(cfg['checks']['retired']['allowLine'] or '(?!)')
        for rx in cfg['checks']['unversioned']['testPaths']:
            re.compile(rx)
    except (ValueError, re.error) as exc:
        raise ConfigError(str(exc))
    return cfg


# ---------------------------------------------------------------- small helpers

def glob_regex(pattern):
    """A path glob as a regex over forward-slash relative paths: ** any depth, * one name."""
    p = pattern.replace('\\', '/')
    out, i = '', 0
    while i < len(p):
        if p.startswith('**/', i):
            out, i = out + '(?:.*/)?', i + 3
        elif p.startswith('**', i):
            out, i = out + '.*', i + 2
        elif p[i] == '*':
            out, i = out + '[^/]*', i + 1
        elif p[i] == '?':
            out, i = out + '[^/]', i + 1
        else:
            out, i = out + re.escape(p[i]), i + 1
    return re.compile('^' + out + '$', re.IGNORECASE)


def matcher(patterns):
    compiled = [glob_regex(p) for p in patterns or []]
    return lambda rel: any(rx.match(rel) for rx in compiled)


def checklist_items(checklist, level):
    """The texts of the exit checklist that belong to the case's level and below."""
    out = []
    for item in checklist:
        if isinstance(item, str):
            out.append(item)
        elif item.get('level', 1) <= level:
            out.append(item['text'])
    return out


def rel_to(path, base):
    try:
        return os.path.relpath(path, base).replace(os.sep, '/')
    except ValueError:  # another drive
        return path.replace(os.sep, '/')


def read_lines(path):
    with open(path, 'r', encoding='utf-8', errors='replace') as fh:
        return fh.read().splitlines()


def front_matter_end(lines):
    """The number of lines of a YAML front matter at the top ('---' on the first line, closed by
    '---' or '...' within FRONT_MATTER_MAX lines), else 0."""
    if not lines or lines[0].lstrip('\ufeff').rstrip() != '---':
        return 0
    for i in range(1, min(len(lines), FRONT_MATTER_MAX)):
        if lines[i].rstrip() in ('---', '...'):
            return i + 1
    return 0


def scope_head(lines, head):
    """(the lines the Scope check reads, the front matter's length): the first `head` lines
    after the front matter - where the placement rule puts the line (scope-census) - else the
    first `head` lines of the document."""
    skip = front_matter_end(lines)
    return lines[skip:skip + head], skip


def read_bytes(path):
    try:
        with open(path, 'rb') as fh:
            return fh.read()
    except OSError:
        return None


def is_text(path):
    try:
        with open(path, 'rb') as fh:
            return b'\0' not in fh.read(8192)
    except OSError:
        return False


def find_powershell(preferred):
    if preferred:
        return shutil.which(preferred)
    names = ('powershell', 'pwsh') if os.name == 'nt' else ('pwsh',)
    for name in names:
        found = shutil.which(name)
        if found:
            return found
    return None


# ---------------------------------------------------------------- results

class Result(object):
    def __init__(self, name):
        self.name = name
        self.title = TITLES[name]
        self.lines = []        # (kind, text) in order: ok, fix, warn, note, notrun, na, skip
        self.output = []       # raw output of the tools, for --verbose and --json
        self.ran = False
        self.detail = ''       # shown after "ok" in the summary (a count the lines only note)

    def add(self, kind, text):
        self.lines.append((kind, text))

    def count(self, kind):
        return sum(1 for k, _ in self.lines if k == kind)

    @property
    def status(self):
        kinds = {k for k, _ in self.lines}
        if 'fix' in kinds or 'warn' in kinds:
            return 'findings'
        if self.ran or 'ok' in kinds:
            return 'ok'
        if 'notrun' in kinds:
            return 'not run here'
        if 'na' in kinds:
            return 'not configured'
        if 'skip' in kinds:
            return 'skipped'
        return 'ok'

    def as_dict(self):
        return {'name': self.name, 'title': self.title, 'status': self.status, 'detail': self.detail,
                'fix': self.count('fix'), 'warn': self.count('warn'),
                'lines': [{'kind': k, 'text': t} for k, t in self.lines], 'output': self.output}


TOOL_FIX = re.compile(r'^(?:FIX|DRIFT|ERROR|error:)\s*(.*)$')
TOOL_WARN = re.compile(r'^WARN\b\s*(.*)$')


class Close(object):
    def __init__(self, root, cfg, args, config_path):
        self.root = root
        self.cfg = cfg
        self.args = args
        self.config_path = config_path
        self.vcs_choice = args.vcs or cfg['vcs']
        self.level = args.level or cfg['level']
        self._changed = None
        self._changed_error = None
        self._twins = None

    # -- shared facts

    def kind(self):
        try:
            return vcs.detect(self.root, self.vcs_choice)
        except vcs.VcsError:
            return None

    def changed(self):
        """[(status, path)] under the root, deletions included; raises VcsError when the
        root cannot be read."""
        if self._changed is None and self._changed_error is None:
            try:
                self._changed = vcs.changed_files(self.root, self.vcs_choice, include_deleted=True,
                                                  svn_client_ignored=self.cfg['svnClientIgnored'])
            except vcs.VcsError as exc:
                self._changed_error = exc
        if self._changed_error is not None:
            raise self._changed_error
        return self._changed

    def frozen_twins(self):
        """{rel: frozen rel} - the markdown documents under the root, not frozen by a glob, whose
        bytes equal a frozen source's: the owner's original of a frozen copy (scope-census), frozen
        too wherever it sits. Found by size first, then by bytes; read once per run."""
        if self._twins is None:
            c = self.cfg['checks']['scope']
            frozen, excluded = matcher(c['frozen']), matcher(c['exclude'])
            sources, others = {}, []
            if c['frozen']:
                for dirpath, dirnames, filenames in os.walk(self.root):
                    dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
                    for name in sorted(filenames):
                        if not name.lower().endswith('.md'):
                            continue
                        full = os.path.join(dirpath, name)
                        rel = rel_to(full, self.root)
                        if excluded(rel):
                            continue
                        try:
                            size = os.path.getsize(full)
                        except OSError:
                            continue
                        if frozen(rel):
                            sources.setdefault(size, []).append((rel, full))
                        else:
                            others.append((rel, full, size))
            self._twins = {}
            for rel, full, size in others:
                if size not in sources:
                    continue
                body = read_bytes(full)
                for src_rel, src_full in sources[size]:
                    if body is not None and body == read_bytes(src_full):
                        self._twins[rel] = src_rel
                        break
        return self._twins

    def projects_file(self):
        path = os.path.join(self.root, self.cfg['projects'])
        return path if os.path.isfile(path) else None

    def vcs_args(self):
        args = ['--vcs', self.vcs_choice] if self.vcs_choice != 'auto' else []
        if self.cfg['svnClientIgnored'] and self.kind() == 'svn':
            args.append('--svn-client-ignored')  # EK#17: the registry tools see what the client hides
        return args

    def client_ignores_note(self, res, tool):
        """EK#17: say that the registry tool reads svn without the client's ignore list too."""
        if self.cfg['svnClientIgnored'] and self.kind() == 'svn':
            res.add('note', "%s: reads svn without the client's global-ignores (svnClientIgnored, EK#17)" % tool)

    def tool(self, res, label, cmd, level):
        """Run one kit tool; its FIX/DRIFT/ERROR lines become findings at `level`, its WARN
        lines warnings. Returns (exit code, output) or (None, '') when it could not start."""
        try:
            proc = subprocess.run(cmd, cwd=self.root, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                  timeout=TOOL_TIMEOUT)
        except FileNotFoundError:
            res.add('notrun', '%s: %s not found' % (label, cmd[0]))
            return None, ''
        except subprocess.TimeoutExpired:
            res.add(level, '%s: timed out after %d s' % (label, TOOL_TIMEOUT))
            return None, ''
        out = proc.stdout.decode('utf-8', 'replace')
        res.ran = True
        res.output.append({'tool': label, 'exit': proc.returncode, 'output': out})
        fixes = warns = 0
        for line in out.splitlines():
            text = line.strip()
            m = TOOL_FIX.match(text)
            if m:
                res.add(level, '%s: %s' % (label, m.group(1)))
                fixes += 1
                continue
            m = TOOL_WARN.match(text)
            if m:
                res.add('warn', '%s: %s' % (label, m.group(1)))
                warns += 1
        last = [l.strip() for l in out.splitlines() if l.strip()]
        summary = last[-1] if last else 'no output'
        if proc.returncode != 0 and not fixes:
            res.add(level, '%s: exit %d - %s' % (label, proc.returncode, summary))
        elif proc.returncode == 0 and not fixes and not warns:
            res.add('ok', '%s: %s' % (label, summary))
        return proc.returncode, out

    def python(self, script):
        return [sys.executable, script]

    # -- checks

    def check_registries(self, res, c):
        if c['validateRegistry'] and self.level < VALIDATOR_LEVEL:
            res.add('skip', 'validate-registry.ps1: level %d, skipped (the case is at level %d)'
                    % (VALIDATOR_LEVEL, self.level))
        elif c['validateRegistry']:
            ps = find_powershell(c['powershell'])
            if not ps:
                res.add('notrun', 'validate-registry.ps1: no PowerShell here (%s)'
                        % (c['powershell'] or ' or '.join(('powershell', 'pwsh') if os.name == 'nt' else ('pwsh',))))
            else:
                cmd = [ps, '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', VALIDATE_REGISTRY, '-Root', self.root]
                if not c['scopeAll']:
                    cmd.append('-NoScope')  # the scope check below answers for the touched documents
                else:  # the full sweep leaves the frozen sources (and their originals) unmarked too
                    frozen = [glob_regex(p).pattern for p in self.cfg['checks']['scope']['frozen']]
                    frozen += ['^%s$' % re.escape(rel) for rel in sorted(self.frozen_twins())]
                    cmd += ['-FrozenPattern', '|'.join('(?:%s)' % p for p in frozen) or '(?!)']
                if self.cfg['caseValues']:
                    cmd += ['-CaseValues', ','.join(self.cfg['caseValues'])]
                cmd += [str(a) for a in c['args']]
                self.tool(res, 'validate-registry.ps1', cmd, c['level'])
        if not c['projectsCheck']:
            return
        projects = self.projects_file()
        if not projects:
            res.add('na', 'projects_check.py: no projects registry at %s' % self.cfg['projects'])
            return
        base = self.python(PROJECTS_CHECK) + ['--root', self.root, '--projects', projects] + self.vcs_args()
        self.client_ignores_note(res, 'projects_check.py --check-touched')
        self.tool(res, 'projects_check.py', base, c['level'])
        self.tool(res, 'projects_check.py --check-touched', base + ['--check-touched'], c['level'])
        if self.args.project:
            self.tool(res, 'projects_check.py --check-scope', base + ['--check-scope', '--project', self.args.project],
                      c['level'])
        else:
            res.add('note', 'projects_check.py --check-scope: not run (give --project <KEY>, the work item\'s project)')

    def check_scope(self, res, c):
        try:
            entries = self.changed()
        except vcs.VcsError as exc:
            res.add('notrun', 'no touched documents can be listed: %s' % exc)
            return
        if self.cfg['svnClientIgnored'] and self.kind() == 'svn':
            res.add('note', "svn read without the client's global-ignores (svnClientIgnored, EK#17); "
                    "the repository's ignore properties still apply")
        excluded, frozen = matcher(c['exclude']), matcher(c['frozen'])
        values = {'method': 'method', 'metodo': 'method', 'case': 'case', 'mixed': 'mixed', 'misto': 'mixed'}
        for v in self.cfg['caseValues']:
            values[v.lower()] = 'case'
        scope_re = re.compile(r'^\*\*(Scope|Escopo)\*\*:\s*(.*)$')
        touched = [(st, p) for st, p in entries if st in 'AM?' and p.lower().endswith('.md')
                   and not excluded(rel_to(p, self.root))]
        docs, bad, twins = [], 0, 0
        for st, path in touched:
            rel = rel_to(path, self.root)
            if not frozen(rel):
                docs.append(path)
            elif st == 'M':  # a frozen source is never edited: its line numbers are ids, its bytes hashed
                res.add(c['level'], 'frozen source changed: %s - it is never edited; compare it with its '
                        'recorded hash and restore the original' % rel)
                bad += 1
            else:
                res.add('note', 'frozen source, never edited, no Scope line expected: %s' % rel)
        for path in docs:
            rel = rel_to(path, self.root)
            found, fence = [], False
            try:
                head, skipped = scope_head(read_lines(path), int(c['head']))
            except OSError as exc:
                res.add('note', 'not read: %s (%s)' % (rel, exc))
                continue
            for line in head:
                if re.match(r'^\s*(```|~~~)', line):
                    fence = not fence
                    continue
                m = None if fence else scope_re.match(line)
                if m:
                    word = (m.group(2).strip().split() or [''])[0]
                    found.append(word.strip('`*_.,;:()[]"\'').lower())
            if found and len(found) == 1 and found[0] in values:
                continue
            twin = self.frozen_twins().get(rel)
            if twin:  # byte-identical to a frozen source: its original (the owner's), never marked
                res.add('note', 'byte-identical to the frozen source %s (its original), never edited, '
                        'no Scope line expected: %s' % (twin, rel))
                twins += 1
                continue
            if not found and skipped:
                res.add(c['level'], 'no Scope line in the first %s lines after the front matter (lines 1-%d): %s'
                        % (c['head'], skipped, rel))
            elif not found:
                res.add(c['level'], 'no Scope line in the first %s lines: %s' % (c['head'], rel))
            elif len(found) > 1:
                res.add(c['level'], '%d Scope lines (one expected): %s' % (len(found), rel))
            else:
                res.add(c['level'], "unknown Scope value '%s': %s" % (found[0], rel))
            bad += 1
        res.ran = True
        if not bad:
            res.add('ok', '%d touched knowledge document(s), each with one Scope line' % (len(docs) - twins))

    def tickets(self, c):
        if self.args.ticket:
            out = []
            for t in self.args.ticket:
                path = t if os.path.isabs(t) else (os.path.abspath(t) if os.path.isdir(t) else os.path.join(self.root, t))
                out.append(os.path.normpath(path))
            return out
        in_tickets = glob_regex(c['tickets'])
        found = set()
        for st, path in self.changed():
            if st in 'AM?' and os.path.basename(path).lower() == c['closingRecord'].lower():
                folder = os.path.dirname(path)
                if in_tickets.match(rel_to(folder, self.root)):
                    found.add(folder)
        return sorted(found)

    def check_test_gate(self, res, c):
        try:
            tickets = self.tickets(c)
        except vcs.VcsError as exc:
            res.add('notrun', 'the work items being closed cannot be listed: %s (give --ticket)' % exc)
            return
        res.ran = True
        if not tickets:
            res.add('ok', 'no work item being closed (no touched %s under %s; or give --ticket)'
                    % (c['closingRecord'], c['tickets']))
            return
        for folder in tickets:
            rel = rel_to(folder, self.root)
            work_item = os.path.basename(folder)
            if not os.path.isdir(folder):
                res.add(c['level'], '%s: work item folder not found' % rel)
                continue
            before = len(res.lines)
            evidence = sorted({os.path.normpath(f) for pat in c['evidence']
                               for f in glob.glob(os.path.join(glob.escape(folder), pat), recursive=True)})
            if not evidence:
                res.add(c['level'], '%s: no test evidence (%s); a line without a suite still gets one, '
                        'with its "skip: <reason>" line' % (rel, ', '.join(c['evidence'])))
            for f in evidence:
                # one warning per evidence file: a filled template may repeat its section-1 line
                # in the verdict, and one owed run is one warning
                reasons = []
                for line in read_lines(f):
                    m = re.search(r'(?i)\bnot run here:\s*(.+)$', line)
                    if m and not m.group(1).strip().startswith('<'):
                        reason = m.group(1).strip().strip('`|').strip()
                        if reason.casefold() not in (r.casefold() for r in reasons):
                            reasons.append(reason)
                if reasons:
                    res.add('warn', '%s: suite not run here (%s) - the run is owed by a machine that can'
                            % (rel_to(f, self.root), '; '.join(reasons)))
            exempt = ''
            for name in c['exemptIn']:
                path = os.path.join(folder, name)
                if os.path.isfile(path):
                    for line in read_lines(path):
                        m = re.search(r'(?i)\bexempt:\s*(.+)$', line)
                        if m and not m.group(1).strip().startswith('<'):
                            exempt = m.group(1).strip()
                            break
                if exempt:
                    break
            for index in c['indexFiles']:
                if exempt:
                    break
                path = os.path.join(self.root, index)
                if not os.path.isfile(path):
                    res.add(c['level'], 'index of tested changes not found: %s' % index)
                    continue
                row = re.compile(r'^\s*\|.*(?<![\w-])%s(?![\w-])' % re.escape(work_item), re.MULTILINE)
                with open(path, 'r', encoding='utf-8', errors='replace') as fh:
                    if not row.search(fh.read()):
                        res.add(c['level'], '%s: no row for %s in %s and no "exempt:" line in the Test plan'
                                % (rel, work_item, index))
            if len(res.lines) == before:
                res.add('ok', '%s: evidence %s%s' % (rel, ', '.join(rel_to(f, folder) for f in evidence),
                                                     ('; exempt: ' + exempt) if exempt else ''))

    def normative_files(self, c):
        include, exclude = matcher(c['normative']['include']), matcher(c['normative']['exclude'])
        own = os.path.normcase(os.path.abspath(self.config_path)) if self.config_path else ''
        for dirpath, dirnames, filenames in os.walk(self.root):
            dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
            for name in sorted(filenames):
                full = os.path.join(dirpath, name)
                rel = rel_to(full, self.root)
                if include(rel) and not exclude(rel) and os.path.normcase(os.path.abspath(full)) != own:
                    yield full, rel

    def check_retired(self, res, c):
        rules = retired.rules_from_config(c)
        if not rules:
            res.add('na', 'no retired location configured (checks.retired.locations / patterns)')
            return
        allow = re.compile(c['allowLine']) if c['allowLine'] else None
        read = skipped = hits = 0
        for full, rel in self.normative_files(c):
            if not is_text(full):
                continue
            lines = read_lines(full)
            if retired.is_superseded(lines, int(c['supersededHead'])):
                skipped += 1
                continue
            read += 1
            for number, rule, line in retired.scan_text(lines, rules, allow):
                hits += 1
                excerpt = line.strip()
                res.add(c['level'], 'retired location in %s:%d: %s  (%s)'
                        % (rel, number, excerpt[:100] + ('...' if len(excerpt) > 100 else ''), rule.describe()))
        res.ran = True
        if not hits:
            res.add('ok', 'no normative file points at a retired location (%d file(s) read, %d superseded '
                    'skipped, %d rule(s))' % (read, skipped, len(rules)))

    def check_decisions(self, res, c):
        projects = self.projects_file()
        if not projects:
            res.add('na', 'decisions_index.py: no projects registry at %s' % self.cfg['projects'])
            return
        base = self.python(DECISIONS_INDEX) + ['--root', self.root, '--projects', projects] + self.vcs_args()
        self.client_ignores_note(res, 'decisions_index.py --check-touched')
        self.tool(res, 'decisions_index.py --check-touched', base + ['--check-touched'], c['level'])
        self.tool(res, 'decisions_index.py', base + (['--dry-run'] if self.args.dry_run else []), c['level'])

    def check_ledger(self, res, c):
        projects = self.projects_file()
        if not projects:
            res.add('na', 'ledger_gen.py: no projects registry at %s' % self.cfg['projects'])
            return
        cmd = self.python(LEDGER_GEN) + ['--root', self.root, '--projects', projects, '--changed', '--cross-index']
        self.client_ignores_note(res, 'ledger_gen.py --changed')
        self.tool(res, 'ledger_gen.py --changed', cmd + self.vcs_args() + (['--dry-run'] if self.args.dry_run else []),
                  c['level'])

    def check_memory(self, res, c):
        if not c['db']:
            res.add('na', 'memory_index.py: no index file configured (checks.memory.db, outside the kit)')
            return
        if self.args.dry_run:
            res.add('skip', 'memory_index.py build: not run (--dry-run)')
            return
        db = c['db'] if os.path.isabs(c['db']) else os.path.normpath(os.path.join(self.root, c['db']))
        cmd = self.python(MEMORY_INDEX) + ['build', '--root', self.root, '--db', db]
        if self.projects_file():
            cmd += ['--projects', self.projects_file()]
        code, out = self.tool(res, 'memory_index.py build', cmd, c['level'])
        for line in out.splitlines():
            if '<< FLAG' in line:
                res.add('warn', 'memory: %s - run the consolidation cycle (memory-engineering)'
                        % line.split('<<')[0].strip())

    def check_unversioned(self, res, c):
        ignored = matcher(c['ignore'])
        test_paths = [re.compile(rx) for rx in c['testPaths']]
        limit = int(c['maxListed'])
        for wc in self.cfg['workingCopies']:
            path = os.path.normpath(os.path.join(self.root, wc['path']))
            label = wc.get('label') or wc['path']
            client_ignored = wc.get('svnClientIgnored', self.cfg['svnClientIgnored'])
            if not os.path.isdir(path):
                res.add(c['level'], '%s: working copy not found: %s' % (label, path))
                continue
            try:
                kind = vcs.detect(path, wc.get('vcs') or self.vcs_choice)
                same = (os.path.normcase(path) == os.path.normcase(self.root) and kind == self.kind()
                        and client_ignored == self.cfg['svnClientIgnored'])
                entries = self.changed() if same else vcs.changed_files(path, kind, include_deleted=True,
                                                                         svn_client_ignored=client_ignored)
            except vcs.VcsError as exc:
                res.add('notrun', '%s: %s' % (label, exc))
                continue
            res.ran = True
            if client_ignored and kind == 'svn':
                res.add('note', "%s: read without the client's global-ignores (svnClientIgnored, EK#17)" % label)
            pending = [(st, rel_to(p, path)) for st, p in entries if not ignored(rel_to(p, path))]
            loose = [rel for st, rel in pending if st == '?']
            add = 'git add <file>' if kind == 'git' else 'svn add --parents <file>'
            first = False  # no first commit yet: every file waits for it, at every level
            if loose and not any(st == 'M' for st, _ in pending):  # a modified file was committed
                try:
                    first = not vcs.has_commit(path, kind)
                except vcs.VcsError as exc:
                    res.add('note', '%s: whether it has a first commit cannot be read (%s); the files are '
                            'listed as for a working copy that has one' % (label, exc))
            if first:
                # The first commit of a base (or of a new code tree) is prepared and waits for the owner's
                # release word, which the script cannot see: one note, not a warning per file.
                new = [rel for st, rel in pending if st in '?A']
                staged = len(new) - len(loose)
                res.add('note', "%s: no first commit yet - its first commit waits for the owner's release word: "
                        "%d file(s)%s; add them by path - %s - when created, or with that commit where the case "
                        "tied staging to the word; --verbose lists them"
                        % (label, len(new), (' (%d already added)' % staged) if staged else '', add))
                res.output.append({'tool': '%s: waiting for the first commit' % label, 'exit': 0,
                                   'output': '\n'.join(new)})
                res.detail = (res.detail + '; ' if res.detail else '') + (
                    '%s: first commit waits for the release word (%d file(s))' % (label, len(new)))
            elif loose and self.level < 2:
                # Level 1: prepare-only, no hand-over packaging yet (close-and-retain is level 2). The
                # new files wait for the owner's release word, which the script cannot see: one note.
                res.add('note', "%s: %d new file(s) not under version control wait for the owner's release "
                        "word (prepare-only, level 1): staged by path in the commit(s) prepared at the close - "
                        "%s; --verbose lists them" % (label, len(loose), add))
                res.output.append({'tool': '%s: not under version control' % label, 'exit': 0,
                                   'output': '\n'.join(loose)})
                res.detail = (res.detail + '; ' if res.detail else '') + '%s: %d new file(s) wait for the release word' % (
                    label, len(loose))
            elif loose:
                for rel in loose[:limit]:
                    res.add(c['level'], '%s: not under version control: %s' % (label, rel))
                if len(loose) > limit:
                    res.add(c['level'], '%s: ... and %d more file(s) not under version control'
                            % (label, len(loose) - limit))
                res.add('note', '%s: add each one when it is created - %s' % (label, add))
            else:
                res.add('ok', '%s (%s): nothing unversioned, %d pending change(s)' % (label, kind, len(pending)))
            if test_paths and pending:
                tests = [rel for st, rel in pending if any(rx.search(rel) for rx in test_paths)]
                fixes = [rel for st, rel in pending if rel not in tests]
                if tests and fixes:
                    res.add('note', '%s: %d fix file(s) and %d test file(s) pending - two commits, the fix first'
                            % (label, len(fixes), len(tests)))
                    res.add('note', '  fix:   %s' % ', '.join(fixes[:limit]) + (' ...' if len(fixes) > limit else ''))
                    res.add('note', '  tests: %s' % ', '.join(tests[:limit]) + (' ...' if len(tests) > limit else ''))

    def run(self, names):
        results = []
        for name in CHECKS:
            res = Result(name)
            results.append(res)
            if name not in names:
                res.add('skip', 'not run (--only / --skip)')
                continue
            need = CHECK_LEVEL.get(name, 1)
            if need > self.level:
                res.add('skip', 'level %d check, skipped (the case is at level %d)' % (need, self.level))
                continue
            if name == 'unversioned':  # read again: the tools above may have generated files
                self._changed = self._changed_error = None
            getattr(self, 'check_' + name.replace('-', '_'))(res, self.cfg['checks'][name])
        return results


# ---------------------------------------------------------------- report

LABELS = {'ok': 'ok    ', 'fix': 'FIX   ', 'warn': 'WARN  ', 'note': 'note  ', 'notrun': 'NOT RUN HERE',
          'na': 'n/a   ', 'skip': 'skip  '}


def print_report(close, results, strict, exit_code, verbose):
    kind = close.kind() or 'no git or svn working copy'
    mode = 'strict' if strict else 'warn-only (EK#6)'
    if strict and close.cfg['decision']:
        mode += ', by %s' % close.cfg['decision']
    print('close: %s (%s) - level %d - %s%s' % (close.root, kind, close.level, mode,
                                               ' - dry run' if close.args.dry_run else ''))
    for res in results:
        print('')
        print('== %s - %s' % (res.name, res.title))
        for k, text in res.lines:
            print('%s %s' % (LABELS[k], text))
        if verbose:
            for item in res.output:
                print('   --- %s (exit %s)' % (item['tool'], item['exit']))
                for line in item['output'].splitlines():
                    print('   | ' + line)
    fix = sum(r.count('fix') for r in results)
    warn = sum(r.count('warn') for r in results)
    print('')
    print('== summary')
    for res in results:
        detail = res.status
        if res.status == 'findings':
            detail = '%d to fix, %d warning(s)' % (res.count('fix'), res.count('warn'))
        elif res.status == 'ok' and res.detail:
            detail = 'ok - ' + res.detail
        print('  %-12s %s' % (res.name, detail))
    items = checklist_items(close.cfg['checklist'], close.level)
    if items:
        print('')
        print('== exit checklist (level %d) - by hand, ticked in the closing answer' % close.level)
        for item in items:
            print('  [ ] ' + item)
    print('')
    if strict:
        tail = 'strict: exit %d' % exit_code
    else:
        tail = 'warn-only (EK#6): exit 0; --strict exits 1 on an item to fix'
    print('close: %d item(s) to fix, %d warning(s) - %s' % (fix, warn, tail))
    if strict and not close.cfg['decision']:
        print('note: strict mode without "decision" in the configuration - a door turns blocking by a numbered '
              'project decision (EK#6)')


# ---------------------------------------------------------------- main

def parse_names(text):
    names = [n.strip() for n in (text or '').split(',') if n.strip()]
    unknown = [n for n in names if n not in CHECKS]
    if unknown:
        raise ConfigError('unknown check(s): %s (known: %s)' % (', '.join(unknown), ', '.join(CHECKS)))
    return names


def main(argv=None):
    ap = argparse.ArgumentParser(description='The mechanical checks of a closing, in one call (warn-only by default)')
    ap.add_argument('--root', default=os.environ.get('KB_ROOT') or '.',
                    help='knowledge-base root (default: $KB_ROOT, else the current folder)')
    ap.add_argument('--config', help='configuration file (default: <root>/%s when it exists)'
                    % DEFAULT_CONFIG.replace(os.sep, '/'))
    ap.add_argument('--strict', action='store_true', help='exit 1 when a check at level "fix" has a finding')
    ap.add_argument('--vcs', choices=vcs.VCS_CHOICES, default=None, help='version control (default: configuration, else auto)')
    ap.add_argument('--level', type=int, choices=ADOPTION_LEVELS, default=None,
                    help='adoption level of the case: the checks and checklist items of a higher level are left '
                         'out (default: configuration "level", else 3 - every check)')
    ap.add_argument('--project', help='project key of the work item (tenant scope check)')
    ap.add_argument('--ticket', action='append', default=[], help='work-item folder being closed (repeatable; '
                    'default: folders whose closing record is touched)')
    ap.add_argument('--only', help='comma-separated checks to run (%s)' % ', '.join(CHECKS))
    ap.add_argument('--skip', help='comma-separated checks to leave out')
    ap.add_argument('--dry-run', action='store_true', help='the tools write no generated file')
    ap.add_argument('--json', action='store_true', help='print the result as JSON')
    ap.add_argument('--verbose', action='store_true', help='also print each tool\'s full output')
    try:
        args = ap.parse_args(argv)
    except SystemExit as exc:
        return 2 if exc.code else 0
    if hasattr(sys.stdout, 'reconfigure'):
        try:
            sys.stdout.reconfigure(errors='backslashreplace')
        except (ValueError, OSError):
            pass
    try:
        root = os.path.abspath(args.root)
        if not os.path.isdir(root):
            raise ConfigError('root folder not found: %s' % root)
        config_path = args.config
        if config_path and not os.path.isfile(config_path):
            raise ConfigError('configuration not found: %s' % config_path)
        if not config_path and os.path.isfile(os.path.join(root, DEFAULT_CONFIG)):
            config_path = os.path.join(root, DEFAULT_CONFIG)
        cfg = load_config(config_path)
        names = parse_names(args.only) if args.only else list(CHECKS)
        for n in parse_names(args.skip):
            if n in names:
                names.remove(n)
    except ConfigError as exc:
        print('error: %s' % exc, file=sys.stderr)
        return 2
    close = Close(root, cfg, args, config_path)
    results = close.run(names)
    strict = args.strict or cfg['mode'] == 'strict'
    fix = sum(r.count('fix') for r in results)
    exit_code = 1 if strict and fix else 0
    if args.json:
        print(json.dumps({'root': root, 'vcs': close.kind(), 'config': config_path, 'mode': 'strict' if strict else 'warn',
                          'decision': cfg['decision'], 'level': close.level, 'dryRun': args.dry_run,
                          'svnClientIgnored': cfg['svnClientIgnored'],
                          'fix': fix, 'warn': sum(r.count('warn') for r in results), 'exit': exit_code,
                          'checks': [r.as_dict() for r in results],
                          'checklist': checklist_items(cfg['checklist'], close.level)}, indent=2))
    else:
        print_report(close, results, strict, exit_code, args.verbose)
    return exit_code


if __name__ == '__main__':
    sys.exit(main())
