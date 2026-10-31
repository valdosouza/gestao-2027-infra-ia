#!/usr/bin/env python3
"""projects_check.py - project inventory validator (engine-kit runtime, T87 and T86).

A knowledge base (KB) holds one or more projects: folders with their own subjects,
registers and decisions. The projects registry is their single inventory: a markdown
file (default <kb-root>/_REGISTRY/PROJECTS.md) with one table row per project and the
configuration of the registry tools in its front matter. This script keeps that
inventory honest and guards tenant isolation. It is also the library imported by
decisions_index.py and ledger_gen.py (registry, front matter, project keys).

Commands:
  python projects_check.py [--root <kb-root>] [--root-glob GLOB ...] [--write]
      inventory, both ways: every project root found by the root globs has a row and
      every row points at a real folder; a duplicate key or folder fails. --write also
      rewrites the "registers present" block between the GENERATED markers.
  python projects_check.py --check-touched [--enforce-from YYYY-MM-DD]
      every added/modified/unversioned document in a project-scoped folder
      (<subject_dir>/<NAME>/<MEMORY|KNOWLEDGE|PIPELINES|TICKETS>/...) declares
      `project:` in its front matter, with the key of the folder it sits in. A missing
      or unknown key warns, and fails from the enforce-from date on (T87); a key that
      contradicts the folder always fails. A modified document without front matter is
      pre-schema and skipped (migrated lazily).
  python projects_check.py --check-scope [--project KEY]
      with --project: fails when the change set touches a tenant project other than KEY
      (a tenant is a row whose Type is listed in tenant_types; other projects, such as
      shared code, may be touched by any change) (T86). Without --project: a warning
      when several tenant projects are touched at once.

The change set is the working copy's pending changes (git or svn; see vcs.py and
--vcs auto|git|svn). Nothing is ever committed, added or reverted.

Registry table: the first table whose header has a `Key` column and a `Path...` column
(optional: `Type`, `Name`, `Code tree`); one row per project with the key in backticks
and the folder relative to paths_base (default: the KB root). The row whose folder is
the KB root itself (`.`) is the workspace: its decisions live in the root register.
Without such a header the memory_index.py form is read: first cell the key, last
backticked cell the folder.

Configuration: the front matter of the registry (keys in DEFAULTS below; README.md);
command-line options win. Relative values are relative to the KB root.
Root: --root, else KB_ROOT.
Exit: 0 clean, 1 drift or failure, 2 usage, configuration or VCS error.
Python 3.8+, standard library only.
"""

import argparse
import fnmatch
import glob
import os
import re
import sys
from datetime import date

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import vcs  # noqa: E402  (sibling module)

KIT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
TEMPLATES = os.path.join(KIT_ROOT, 'templates')
BEGIN = '<!-- BEGIN GENERATED -->'
END = '<!-- END GENERATED -->'
SKIP_DIRS = {'.git', '.svn', '.hg', 'node_modules', '__pycache__', '.obsidian', '.trash'}
TOUCHED_SKIP_DIRS = {'attachments', 'evidence', '_archive'}
TICKET_FOLDER = 'TICKETS'  # only for the ownership hint of --check-scope without --project
CELL_SPLIT = re.compile(r'(?<!\\)\|')
KEY_CELL = re.compile(r'^`([^`]+)`$')
ISO_DAY = re.compile(r'^\d{4}-\d{2}-\d{2}$')

# Every configuration key with its default. A list key accepts an inline or block list.
DEFAULTS = {
    'root_globs': [],                                   # globs of project-root folders (KB-root relative)
    'paths_base': '.',                                  # folder the Path cells are relative to
    'subject_dir': 'SUBJECT',                           # holds <NAME>/MEMORY, KNOWLEDGE, TICKETS, ...
    'project_scoped': ['MEMORY', 'KNOWLEDGE', 'PIPELINES', 'SETTINGS', 'TICKETS'],  # folders whose docs need `project:`
    'enforce_from': '',                                 # YYYY-MM-DD: a missing `project:` fails from then on
    'tenant_types': ['tenant', 'customer'],             # Types isolated from each other (--check-scope)
    'scope_exempt': ['*/_REGISTRY/*', '*/_INDEX/*', '*/graphs/*', '*/~$*', '*.db'],  # never count for scope
    'decision_register': '{path}/_REGISTRY/DECISIONS.md',  # register of a project ({path}, {key})
    'root_register': 'DECISIONS.md',                    # register of the workspace row
    'decisions_index': '',                              # generated index (default: next to the registry)
    'ledger': '{path}/_REGISTRY/LEDGER.md',             # generated ledger of a project ({path}, {key})
    'ledger_all': '',                                   # cross-project ledger (default: next to the registry)
    'ledger_kinds': '',                                 # JSON kinds map of ledger_gen.py (default: built in)
    'registers': ['_REGISTRY/LEDGER.md', 'REGISTRY_SUBJECTS.md', 'REGISTRY_GRAPHS.md'],  # --write columns
    'scope_value': 'case',                              # Scope written into generated files and new registers
}


class RegistryError(Exception):
    """The projects registry or its configuration cannot be used."""


# ---------------- small helpers (shared) ----------------

def fail(message):
    print('error: ' + message, file=sys.stderr)
    return 2


def reconfigure_streams():
    for stream in (sys.stdout, sys.stderr):
        try:
            stream.reconfigure(errors='replace')  # titles may hold characters the console cannot show
        except AttributeError:
            pass


def read_lines(path, limit=None):
    """Lines of a text file (UTF-8, BOM dropped); the first `limit` lines only when given."""
    with open(path, encoding='utf-8-sig', errors='replace') as handle:
        if limit is None:
            return handle.read().splitlines()
        lines = []
        for line in handle:
            if len(lines) >= limit:
                break
            lines.append(line.rstrip('\r\n'))
        return lines


def write_text(path, text):
    os.makedirs(os.path.dirname(os.path.abspath(path)), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as handle:
        handle.write(text)


def inside_kit(path):
    """True when path is inside the kit folder (generated case files never go there)."""
    try:
        common = os.path.commonpath([os.path.abspath(path), KIT_ROOT])
    except ValueError:  # different drives
        return False
    return os.path.normcase(common) == os.path.normcase(KIT_ROOT)


def _value(raw):
    """Scalar value: quoted text as is, plain text without its trailing ' # comment'."""
    raw = raw.strip()
    if raw[:1] in ('"', "'"):
        end = raw.find(raw[0], 1)
        return raw[1:end] if end > 0 else raw[1:]
    return re.sub(r'\s+#.*$', '', raw).strip()


def parse_front_matter(lines):
    """Front matter as a dict (scalars, inline [a, b] lists, block lists), or None when absent."""
    if len(lines) < 2 or lines[0].strip() != '---':
        return None
    fm, list_key = {}, None
    for line in lines[1:]:
        if line.strip() == '---':
            break
        if list_key is not None:
            m = re.match(r'^\s*-\s+(.*)$', line)
            if m:
                fm[list_key].append(_value(m.group(1)))
                continue
        m = re.match(r'^([A-Za-z_][A-Za-z0-9_-]*):\s*(.*)$', line)
        if not m:
            continue
        list_key = None
        key, raw = m.group(1), m.group(2).strip()
        if raw == '' or raw.startswith('#'):
            fm[key] = []  # a block list ("key:" then "  - item" lines) may follow
            list_key = key
            continue
        value = _value(raw)
        inline = re.match(r'^\[(.*)\]$', value) if raw[:1] not in ('"', "'") else None
        fm[key] = [_value(x) for x in inline.group(1).split(',') if x.strip()] if inline else value
    return fm


def first_h1(lines):
    for line in lines:
        if line.startswith('# '):
            return line[2:].strip()
    return ''


def declared_project(path):
    """(has front matter, value of `project:` or '')."""
    try:
        fm = parse_front_matter(read_lines(path, 200))
    except OSError:
        return True, ''
    if fm is None:
        return False, ''
    value = fm.get('project')
    if isinstance(value, list):
        value = value[0] if value else ''
    return True, (value or '').strip()


# ---------------- registry ----------------

def _row(key, ptype, name, code_tree, path_cell, number, base):
    raw = path_cell.strip().strip('`').strip().replace('\\', '/') or '.'
    rel = os.path.normpath(os.path.join(base, raw)).replace('\\', '/')
    return {'key': key, 'type': ptype.strip('` '), 'name': name, 'code_tree': code_tree.strip('` '),
            'path': rel, 'line': number}


def parse_projects_table(lines, base='.'):
    """Project rows: [{key, type, name, code_tree, path (KB-root relative, '/'), line}]."""
    rows, legacy, cols, in_fence = [], [], None, False
    for number, line in enumerate(lines, 1):
        if line.lstrip().startswith('```'):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        if not line.startswith('|'):
            cols = None
            continue
        cells = [c.strip() for c in CELL_SPLIT.split(line.strip().strip('|'))]
        low = [c.lower() for c in cells]
        if low and low[0] == 'key' and any(c.startswith('path') for c in low):
            cols = low
            continue
        m = KEY_CELL.match(cells[0]) if cells else None
        if not m:
            continue
        if cols is not None:
            def get(prefix):
                for i, col in enumerate(cols):
                    if col.startswith(prefix) and i < len(cells):
                        return cells[i]
                return ''
            rows.append(_row(m.group(1), get('type'), get('name'), get('code tree'), get('path'), number, base))
        else:
            ticked = [c for c in cells if KEY_CELL.match(c)]
            if len(ticked) >= 2:
                legacy.append(_row(m.group(1), '', '', '', ticked[-1], number, base))
    return rows if rows else legacy


class Registry(object):
    """The projects registry of one KB: rows, configuration and path helpers."""

    def __init__(self, root, path, config, projects):
        self.root = root
        self.path = path
        self.config = config
        self.projects = projects
        self.by_key = {}
        for pr in projects:
            self.by_key.setdefault(pr['key'], pr)
        workspace = [p for p in projects if p['path'] == '.']
        self.workspace = workspace[0]['key'] if workspace else ''
        self.subject_dir = config['subject_dir']

    def abs(self, pr):
        return os.path.normpath(os.path.join(self.root, pr['path']))

    def rel(self, full):
        """Path relative to the KB root with '/' separators, or None when outside it."""
        try:
            rel = os.path.relpath(os.path.abspath(full), self.root)
        except ValueError:
            return None
        if rel == '..' or rel.startswith('..' + os.sep):
            return None
        return rel.replace(os.sep, '/')

    def fill(self, pattern, pr=None):
        """Absolute path of a configured pattern: {key} and {path} of pr, KB-root relative."""
        text = pattern
        if pr is not None:
            key = pr['key'] or pr['path'].replace('/', '_')
            text = text.replace('{key}', key).replace('{path}', pr['path'])
        return os.path.normpath(os.path.join(self.root, text))

    def decision_register(self, pr):
        name = 'root_register' if pr['path'] == '.' else 'decision_register'
        return self.fill(self.config[name], pr)

    def output(self, name, default_basename):
        """A generated cross-project file: configured, else next to the projects registry."""
        if self.config.get(name):
            return self.fill(self.config[name])
        return os.path.join(os.path.dirname(self.path), default_basename)

    def key_for_relpath(self, rel, include_workspace=False):
        """Key of the project whose folder holds `rel` (longest folder wins), or ''."""
        low = rel.replace('\\', '/').lower()
        best, best_len = '', -1
        for pr in self.projects:
            if pr['path'] == '.':
                continue
            prefix = pr['path'].lower() + '/'
            if low.startswith(prefix) and len(prefix) > best_len:
                best, best_len = pr['key'], len(prefix)
        return best or (self.workspace if include_workspace else '')

    def is_tenant(self, key):
        pr = self.by_key.get(key)
        return bool(pr) and pr['type'].lower() in [t.lower() for t in self.config['tenant_types']]

    def discover_roots(self, globs=None):
        """[(glob, [folder relative to the KB root])] of the root globs."""
        out = []
        for pattern in (self.config['root_globs'] if globs is None else globs):
            hits = []
            for full in sorted(glob.glob(os.path.join(self.root, pattern), recursive=True)):
                rel = self.rel(full)
                if rel and os.path.isdir(full) and not any(p in SKIP_DIRS for p in rel.split('/')):
                    hits.append(rel)
            out.append((pattern, hits))
        return out

    def scope_exempt(self, rel):
        target = '/' + rel.lower()
        return any(fnmatch.fnmatchcase(target, p.lower()) for p in self.config['scope_exempt'])


def load_registry(root, projects_file=None, overrides=None, required=True):
    root = os.path.abspath(root)
    path = os.path.abspath(projects_file) if projects_file else os.path.join(root, '_REGISTRY', 'PROJECTS.md')
    lines = []
    if os.path.isfile(path):
        lines = read_lines(path)
    elif required:
        raise RegistryError('projects registry not found: %s (pass --projects, or create it from '
                            'templates/REGISTRY_PROJECTS.template.md)' % path)
    fm = parse_front_matter(lines) or {}
    config = dict(DEFAULTS)
    for key, default in DEFAULTS.items():
        if key not in fm:
            continue
        value = fm[key]
        if isinstance(default, list):
            config[key] = value if isinstance(value, list) else [value]
        elif not isinstance(value, list):
            config[key] = value
    for key, value in (overrides or {}).items():
        if value not in (None, '', []):
            config[key] = value
    return Registry(root, path, config, parse_projects_table(lines, config['paths_base']))


def add_common_args(ap):
    ap.add_argument('--root', '--kb-root', dest='root',
                    help='knowledge-base root (default: $KB_ROOT)')
    ap.add_argument('--projects', help='projects registry (default: <kb-root>/_REGISTRY/PROJECTS.md)')
    ap.add_argument('--paths-base', help='folder the registry Path cells are relative to, KB-root relative '
                                         '(default: front matter paths_base, else the KB root)')
    vcs.add_vcs_argument(ap)


def resolve_root(value):
    root = value or os.environ.get('KB_ROOT')
    if not root:
        raise RegistryError('no root: pass --root or set the KB_ROOT environment variable')
    root = os.path.abspath(root)
    if not os.path.isdir(root):
        raise RegistryError('root folder not found: %s' % root)
    return root


def registry_from_args(args, required=True, **overrides):
    overrides['paths_base'] = args.paths_base
    return load_registry(resolve_root(args.root), args.projects, overrides, required)


def changed(reg, args, **options):
    """(vcs kind, [(status, absolute path)]) of the KB's working copy."""
    kind = vcs.detect(reg.root, args.vcs)
    options.setdefault('svn_client_ignored', getattr(args, 'svn_client_ignored', False))
    return kind, vcs.changed_files(reg.root, kind, **options)


# ---------------- inventory ----------------

def check_inventory(reg):
    """(warnings, problems) of the registry against the folders."""
    warns, problems = [], []
    keys = [p['key'] for p in reg.projects]
    for key in sorted(set(keys)):
        if keys.count(key) > 1:
            problems.append('duplicate key %s' % key)
    folders = {}
    for pr in reg.projects:
        folders.setdefault(pr['path'].lower(), []).append(pr['key'])
    for folder, owners in sorted(folders.items()):
        if len(owners) > 1:
            problems.append('rows %s point at the same folder: %s' % (', '.join(owners), folder))
    if not reg.config['root_globs']:
        warns.append('no root_globs (front matter or --root-glob): the folder -> row direction is not checked')
    for pattern, hits in reg.discover_roots():
        if not hits:
            warns.append("root glob '%s' matches no folder" % pattern)
        for rel in hits:
            if rel.lower() not in folders:
                problems.append('project root without a row in the registry: %s' % rel)
    for pr in reg.projects:
        if pr['path'] != '.' and not os.path.isdir(reg.abs(pr)):
            problems.append('row %s points at a missing folder: %s' % (pr['key'], pr['path']))
    return warns, problems


def generated_block(reg):
    regs = reg.config['registers']
    names = [os.path.splitext(os.path.basename(r))[0] for r in regs]
    lines = ['| Key | Subjects | Decisions | ' + ' | '.join(names) + ' |',
             '|---|---|---|' + '---|' * len(names)]
    for pr in reg.projects:
        base = reg.abs(pr)
        subjects = os.path.join(base, reg.subject_dir)
        n = len([d for d in os.listdir(subjects) if os.path.isdir(os.path.join(subjects, d))]) \
            if os.path.isdir(subjects) else 0
        cells = ['yes' if os.path.isfile(reg.decision_register(pr)) else '-']
        cells += ['yes' if os.path.isfile(os.path.join(base, r)) else '-' for r in regs]
        lines.append('| `%s` | %d | %s |' % (pr['key'], n, ' | '.join(cells)))
    return '\n'.join(lines)


def run_inventory(reg, args):
    warns, problems = check_inventory(reg)
    for pr in reg.projects:
        print('  %-16s %-10s %s' % (pr['key'], pr['type'] or '-', pr['path']))
    if args.write:
        if inside_kit(reg.path):
            problems.append('the registry is inside the kit folder: --write refused')
        else:
            text = '\n'.join(read_lines(reg.path)) + '\n'
            if BEGIN in text and END in text:
                head, rest = text.split(BEGIN, 1)
                text = head + BEGIN + '\n' + generated_block(reg) + '\n' + END + rest.split(END, 1)[1]
                write_text(reg.path, text)
                print('generated block rewritten')
            else:
                problems.append('the registry has no %s / %s markers' % (BEGIN, END))
    for w in warns:
        print('WARN ', w)
    for p in problems:
        print('FIX  ', p)
    print('projects: %d - %d warning(s), %d problem(s)' % (len(reg.projects), len(warns), len(problems)))
    return 1 if problems else 0


# ---------------- touched documents (T87) ----------------

def _is_scoped(reg, rel):
    parts = rel.lower().split('/')
    if any(p in TOUCHED_SKIP_DIRS for p in parts):
        return False
    scoped = {s.lower() for s in reg.config['project_scoped']}
    subject = reg.subject_dir.lower()
    return any(parts[i] == subject and parts[i + 2] in scoped for i in range(len(parts) - 3))


def check_touched(reg, entries, strict):
    """`project:` front matter of the touched documents: (warnings, failures)."""
    generated = {os.path.basename(reg.config['ledger']).lower(), 'ledger.md'}
    warns, fails = [], []
    for status, full in entries:
        rel = reg.rel(full)
        if status == 'D' or rel is None or not rel.lower().endswith('.md') or not _is_scoped(reg, rel):
            continue
        if os.path.basename(rel).lower() in generated:
            continue
        derived = reg.key_for_relpath(rel, include_workspace=True)
        has_fm, declared = declared_project(full)
        if not has_fm and status == 'M':
            continue  # pre-schema document touched: migrated lazily
        if not declared:
            (fails if strict else warns).append('no `project:` in front matter (expected %s): %s' % (derived or '?', rel))
        elif declared not in reg.by_key:
            (fails if strict else warns).append('unknown project key `%s` (expected %s): %s' % (declared, derived or '?', rel))
        elif derived and declared != derived:
            fails.append('`project: %s` does not match the folder (%s): %s' % (declared, derived, rel))
    return warns, fails


def run_check_touched(reg, args):
    enforce_from = reg.config['enforce_from']
    if enforce_from and not ISO_DAY.match(enforce_from):
        return fail("enforce_from must be YYYY-MM-DD, not '%s'" % enforce_from)
    strict = bool(enforce_from) and date.today().isoformat() >= enforce_from
    kind, entries = changed(reg, args, md_only=True)
    warns, fails = check_touched(reg, entries, strict)
    for w in warns:
        print('WARN ', w)
    for f in fails:
        print('FIX  ', f)
    if strict:
        mode = 'ENFORCED since %s' % enforce_from
    elif enforce_from:
        mode = 'warn-only until %s' % enforce_from
    else:
        mode = 'warn-only, no enforce_from date'
    print('project front matter (%s, %s): %d touched document(s), %d warning(s), %d failure(s)'
          % (mode, kind, len(entries), len(warns), len(fails)))
    return 1 if fails else 0


# ---------------- tenant scope (T86) ----------------

def check_scope(reg, entries, project=None):
    """Files touched per project: (warnings, failures, {key: [rel]})."""
    touched = {}
    for _status, full in entries:
        rel = reg.rel(full)
        if rel is None or reg.scope_exempt(rel):
            continue
        key = reg.key_for_relpath(rel)
        if key:
            touched.setdefault(key, []).append(rel)
    tenants = sorted(k for k in touched if reg.is_tenant(k))
    warns, fails = [], []
    if project:
        if project not in reg.by_key:
            return [], ['unknown project key `%s` (not a row of %s)' % (project, reg.path)], touched
        for key in tenants:
            if key != project:
                fails.append('%d touched file(s) in tenant project %s, but the change belongs to %s: %s'
                             % (len(touched[key]), key, project, touched[key][0]))
    elif len(tenants) > 1:
        marker = '/%s/' % TICKET_FOLDER.lower()
        owners = [k for k in tenants if any(marker in f.lower() for f in touched[k])]
        warns.append('several tenant projects touched in one change: '
                     + ', '.join('%s (%d)' % (k, len(touched[k])) for k in tenants)
                     + ('; ticket folders only in %s' % ', '.join(owners) if owners else '')
                     + ' - pass --project KEY to make this a check')
    return warns, fails, touched


def run_check_scope(reg, args):
    kind, entries = changed(reg, args, include_deleted=True)  # a deletion touches a project too
    warns, fails, touched = check_scope(reg, entries, args.project or None)
    for w in warns:
        print('WARN ', w)
    for f in fails:
        print('FIX  ', f)
    summary = ', '.join('%s (%d)' % (k, len(v)) for k, v in sorted(touched.items())) or 'no project files'
    print('project scope (%s): touched %s - %d warning(s), %d failure(s)' % (kind, summary, len(warns), len(fails)))
    return 1 if fails else 0


# ---------------- main ----------------

def main(argv=None):
    reconfigure_streams()
    ap = argparse.ArgumentParser(description='Project inventory validator: registry rows <-> project roots, '
                                             '`project:` front matter of touched documents, tenant scope')
    add_common_args(ap)
    ap.add_argument('--root-glob', action='append', default=[], metavar='GLOB',
                    help='project-root glob relative to the KB root (repeatable; replaces root_globs)')
    ap.add_argument('--write', action='store_true', help='rewrite the generated "registers present" block')
    ap.add_argument('--check-touched', action='store_true',
                    help='`project:` front matter of the added/modified/unversioned project-scoped documents')
    ap.add_argument('--check-scope', action='store_true',
                    help='the change set touches no tenant project other than --project')
    ap.add_argument('--project', default='', help='key of the project the change belongs to (--check-scope)')
    ap.add_argument('--enforce-from', metavar='YYYY-MM-DD',
                    help='from this day a missing or unknown `project:` fails (default: front matter enforce_from)')
    args = ap.parse_args(argv)
    try:
        reg = registry_from_args(args, root_globs=args.root_glob, enforce_from=args.enforce_from)
    except RegistryError as exc:
        return fail(str(exc))
    if not reg.projects:
        print('the projects registry has no project rows: %s' % reg.path)
        return 1
    try:
        if args.check_scope:
            return run_check_scope(reg, args)
        if args.check_touched:
            return run_check_touched(reg, args)
    except vcs.VcsError as exc:
        return fail(str(exc))
    return run_inventory(reg, args)


if __name__ == '__main__':
    sys.exit(main())
