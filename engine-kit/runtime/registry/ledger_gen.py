#!/usr/bin/env python3
"""ledger_gen.py - generated "what was archived when" ledgers (engine-kit runtime, T04).

One ledger per project and one cross-project view, rebuilt from the documents
themselves, so they cannot drift: never edit them by hand, fix the source document and
regenerate. A row per document under <project>/<subject_dir>/<NAME>/ whose folder the
kinds map names (logs, cards, pipelines, rules, plans, ticket documents...), and per
document at the root of the area that the kinds map names by file name (area_files) or
that another area-root document names in a front matter key (area_links): the analysis
document of a legacy assessment and its hypothesis register, by default.

Date of a row: the first ISO date in the front matter keys of the kinds map (default:
date, last_updated, review_date, generated, migrated), else the first YYYY-MM-DD in the
file name, else the file's modification time - marked with `~`.

Commands:
  python ledger_gen.py [--root <kb-root>] [--dry-run]       every project + the cross view
  python ledger_gen.py --project KEY [--project PATH ...]  only these projects (key or folder)
  python ledger_gen.py --changed [--vcs auto|git|svn]      only the projects with pending
                                                           changes under their subject folder
  python ledger_gen.py --index-only                        only the cross-project view
  (add --cross-index to a selective run to rewrite the cross view as well)

Projects: the rows of the projects registry whose folder holds the subject folder,
plus the folders matched by the root globs (a folder without a row is ledgered as
"?" with a warning). Without a registry: the root globs, else the KB root itself.

Outputs (front matter of the projects registry, or the options; never inside the kit):
  ledger      per-project pattern, KB-root relative or absolute ({path}, {key});
              default "{path}/_REGISTRY/LEDGER.md"
  ledger_all  cross view; default LEDGER-ALL.md next to the projects registry
For the solo profile (kit decisions EK#5, EK#27) point both at the runtime area, outside the
versioned knowledge base (beside it, or an ignored folder inside it).

Kinds map (--kinds FILE or front matter ledger_kinds; JSON, every key optional, each
one replaces the built-in value - see DEFAULT_KINDS and README.md).

Root: --root, else KB_ROOT.
Exit: 0 done, 2 usage, configuration or VCS error.
Python 3.8+, standard library only.
"""

import argparse
import fnmatch
import json
import os
import re
import sys
from datetime import datetime

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import projects_check as pc  # noqa: E402  (sibling module: registry, front matter, VCS)
import vcs  # noqa: E402

DEFAULT_KINDS = {
    'folders': {'MEMORY': 'log', 'KNOWLEDGE': 'card', 'PIPELINES': 'pipeline', 'RULES': 'rule',
                'PLANS': 'plan', 'PLAN': 'plan'},
    'ticket_folder': 'TICKETS',                       # <subject>/TICKETS/<ID>/...: the ID joins Ticket(s)
    'ticket_subfolders': {'REVIEW': 'ticket-review', 'TESTS': 'ticket-test'},
    'ticket_files': [['*analysis*', 'ticket-analysis'], ['*worklog*', 'ticket-worklog']],  # first match wins
    'ticket_default': 'ticket-doc',
    # documents at the root of <subject>/<NAME>/: by file name (first match wins), then named by
    # another area-root document's front matter key (the hypothesis register's analysis_document);
    # any other area-root file (the area's INDEX.md...) is not ledgered
    'area_files': [['hypotheses.md', 'hypotheses'], ['*analysis*', 'analysis']],
    'area_links': {'analysis_document': 'analysis'},
    'date_keys': ['date', 'last_updated', 'review_date', 'generated', 'migrated'],
    'skip_dirs': ['attachments', 'evidence', '.obsidian'],
    'skip_files': ['INDEX.md'],
}
DAY = re.compile(r'(\d{4}-\d{2}-\d{2})')
FOOTNOTE = '`~` after a date = taken from the file modification time (no date in front matter or file name).'


# ---------------- configuration ----------------

def load_kinds(path):
    kinds = json.loads(json.dumps(DEFAULT_KINDS))  # deep copy
    if not path:
        return kinds
    with open(path, encoding='utf-8-sig') as handle:
        data = json.load(handle)
    if not isinstance(data, dict):
        raise ValueError('the kinds map must be a JSON object')
    unknown = sorted(set(data) - set(DEFAULT_KINDS))
    if unknown:
        raise ValueError('unknown key(s) in the kinds map: %s' % ', '.join(unknown))
    kinds.update(data)
    if not isinstance(kinds['area_links'], dict):
        raise ValueError('area_links must be an object {"front matter key": "kind"}')
    if not all(isinstance(p, list) and len(p) == 2 for p in kinds['area_files']):
        raise ValueError('area_files must be a list of ["file-name glob", "kind"] pairs')
    return kinds


# ---------------- rows ----------------

def link_target(value):
    """The file a front matter value points to: a plain relative path or a markdown link,
    without its anchor; '' when there is none."""
    if not isinstance(value, str):
        return ''
    m = re.search(r'\]\(([^)]*)\)', value)
    target = (m.group(1) if m else value).strip().strip('<>').split('#')[0].strip()
    return target.replace('\\', '/')


def area_links(area_dir, filenames, kinds):
    """{file name (lower case): kind} of the area-root documents that another area-root
    document names in one of the kinds map's area_links front matter keys."""
    out = {}
    if not kinds['area_links']:
        return out
    for name in filenames:
        if not name.lower().endswith('.md'):
            continue
        try:
            fm = pc.parse_front_matter(pc.read_lines(os.path.join(area_dir, name), 200)) or {}
        except OSError:
            continue
        for key, kind in kinds['area_links'].items():
            target = os.path.normpath(link_target(fm.get(key)) or '.').replace(os.sep, '/')
            if target not in ('.', '') and '/' not in target:  # a sibling at the area root
                out.setdefault(target.lower(), kind)
    return out


def classify(parts, kinds, linked=None):
    """(kind, ticket id) of a document; parts = the path after <subject_dir>/<NAME>/;
    linked = the area-root names another area-root document links (area_links)."""
    if not parts:
        return '', ''
    if len(parts) == 1:  # at the root of the area: by file name, then by a link
        name = parts[0].lower()
        for pattern, kind in kinds['area_files']:
            if fnmatch.fnmatchcase(name, pattern.lower()):
                return kind, ''
        return (linked or {}).get(name, ''), ''
    head = parts[0].upper()
    folders = {k.upper(): v for k, v in kinds['folders'].items()}
    if head in folders:
        return folders[head], ''
    if head == kinds['ticket_folder'].upper() and len(parts) >= 3:
        tid = parts[1]
        sub = parts[2].upper() if len(parts) > 3 else ''
        subs = {k.upper(): v for k, v in kinds['ticket_subfolders'].items()}
        if sub in subs:
            return subs[sub], tid
        name = parts[-1].lower()
        for pattern, kind in kinds['ticket_files']:
            if fnmatch.fnmatchcase(name, pattern.lower()):
                return kind, tid
        return kinds['ticket_default'], tid
    return '', ''


def date_of(fm, name, full, date_keys):
    for key in date_keys:
        value = fm.get(key)
        if isinstance(value, str):
            m = DAY.search(value)
            if m:
                return m.group(1), ''
    m = DAY.search(name)
    if m:
        return m.group(1), ''
    return datetime.fromtimestamp(os.path.getmtime(full)).strftime('%Y-%m-%d'), '~'


def _list(value):
    if isinstance(value, list):
        return [str(v) for v in value if str(v)]
    return [str(value)] if value else []


def build_rows(project_dir, subject_dir, kinds):
    """[(date, approx, subject, kind, card id, tickets, link, summary)], newest first."""
    rows = []
    subject_root = os.path.join(project_dir, subject_dir)
    skip_dirs = {d.lower() for d in kinds['skip_dirs']} | {d.lower() for d in pc.SKIP_DIRS}
    skip_files = [f.lower() for f in kinds['skip_files']]
    for dirpath, dirnames, filenames in os.walk(subject_root):
        dirnames[:] = sorted(d for d in dirnames if d.lower() not in skip_dirs)
        at_area_root = os.path.dirname(os.path.relpath(dirpath, subject_root)) == ''
        linked = area_links(dirpath, filenames, kinds) if at_area_root and dirpath != subject_root else {}
        for name in sorted(filenames):
            low = name.lower()
            if not low.endswith('.md') or any(fnmatch.fnmatchcase(low, p) for p in skip_files):
                continue
            full = os.path.join(dirpath, name)
            rel = os.path.relpath(full, subject_root).replace(os.sep, '/')
            parts = rel.split('/')
            kind, tid = classify(parts[1:], kinds, linked)
            if not kind:
                continue
            lines = pc.read_lines(full)
            fm = pc.parse_front_matter(lines) or {}
            day, approx = date_of(fm, name, full, kinds['date_keys'])
            tickets = _list(fm.get('tickets')) or _list(fm.get('ticket'))
            if tid and tid not in tickets:
                tickets = [tid] + tickets
            title = fm.get('title') if isinstance(fm.get('title'), str) else ''
            summary = re.sub(r'\s+', ' ', title or pc.first_h1(lines) or name).strip().replace('|', '/')
            if len(summary) > 110:
                summary = summary[:107] + '...'
            card_id = fm.get('id', '') if kind == 'card' and isinstance(fm.get('id'), str) else ''
            link = subject_dir + '/' + rel[:-3]
            rows.append((day, approx, parts[0], kind, card_id, ', '.join(tickets), link, summary))
    rows.sort(key=lambda r: (r[0], r[6]), reverse=True)
    return rows


# ---------------- render ----------------

def render(pr, label, rows, generated, scope):
    n_logs = sum(1 for r in rows if r[3] == 'log')
    n_cards = sum(1 for r in rows if r[3] == 'card')
    n_tickets = sum(1 for r in rows if r[3].startswith('ticket'))
    fm = ['---', 'last_updated: %s' % generated[:10], 'generated_by: ledger_gen.py']
    if pr['key']:
        fm += ['project: %s' % pr['key'], 'project_type: %s' % (pr['type'] or '-')]
    fm += ['tags:', '  - registry', '  - ledger', '---']
    title = '%s (%s)' % (pr['key'], label) if pr['key'] else label
    out = fm + ['# Ledger - %s' % title, '',
                '**Scope**: %s' % scope, '',
                '> **GENERATED FILE - do not edit.** Rebuilt by `ledger_gen.py` from the front matter of every',
                '> document of this project that the kinds map lists (logs, cards, ticket documents, pipelines,',
                '> rules, plans, analysis documents and their hypothesis registers). Fix the source document,',
                '> then regenerate.',
                '> Generated %s - %d entries: %d logs, %d cards, %d ticket docs.'
                % (generated, len(rows), n_logs, n_cards, n_tickets),
                '', '| Date | Subject | Kind | Card | Ticket(s) | Document | Summary |', '|---|---|---|---|---|---|---|']
    for day, approx, subject, kind, card_id, tickets, link, summary in rows:
        out.append('| %s%s | %s | %s | %s | %s | [[%s]] | %s |' % (day, approx, subject, kind, card_id, tickets, link, summary))
    out += ['', FOOTNOTE]
    return '\n'.join(out) + '\n'


def write_cross_index(reg, roots, kinds, generated, dry_run):
    """Every project's rows in one table with a Project column; day-level timestamp to limit churn."""
    allrows, per_project = [], []
    for pr in roots:
        rows = build_rows(reg.abs(pr), reg.subject_dir, kinds)
        key = pr['key'] or '?'
        per_project.append((key, len(rows)))
        prefix = '' if pr['path'] == '.' else pr['path'] + '/'
        for day, approx, subject, kind, card_id, tickets, link, summary in rows:
            allrows.append((day, approx, key, subject, kind, card_id, tickets, prefix + link, summary))
    allrows.sort(key=lambda r: (r[0], r[2], r[7]), reverse=True)
    target = reg.output('ledger_all', 'LEDGER-ALL.md')
    if pc.inside_kit(target):
        raise ValueError('the cross-project ledger is a case file: keep it outside the kit folder (%s)' % target)
    out = ['---', 'last_updated: %s' % generated[:10], 'generated_by: ledger_gen.py --cross-index',
           'tags:', '  - index', '  - ledger', '---', '# Ledger - every project', '',
           '**Scope**: %s' % reg.config['scope_value'], '',
           '> **GENERATED FILE - do not edit.** One row per ledgered document of every project, newest first, '
           'with its project key (the projects registry). The per-project ledgers stay the working registers; '
           'this is the cross-project view.',
           '> Generated %s - %d entries in %d project(s): %s.'
           % (generated[:10], len(allrows), len(per_project), ', '.join('%s %d' % (k, n) for k, n in per_project if n) or '-'),
           '', '| Date | Project | Subject | Kind | Card | Ticket(s) | Document | Summary |', '|---|---|---|---|---|---|---|---|']
    for day, approx, key, subject, kind, card_id, tickets, link, summary in allrows:
        out.append('| %s%s | %s | %s | %s | %s | %s | [[%s]] | %s |'
                   % (day, approx, key, subject, kind, card_id, tickets, link, summary))
    out += ['', FOOTNOTE]
    if not dry_run:
        pc.write_text(target, '\n'.join(out) + '\n')
    print('  %scross-project ledger: %s: %d entries' % ('(dry) ' if dry_run else '', reg.rel(target) or target, len(allrows)))


# ---------------- selection ----------------

def project_roots(reg):
    """Project rows (and unregistered root-glob folders, key '') that hold the subject folder."""
    out, seen = [], set()
    for pr in reg.projects:
        if pr['path'].lower() not in seen and os.path.isdir(os.path.join(reg.abs(pr), reg.subject_dir)):
            out.append(pr)
            seen.add(pr['path'].lower())
    for _pattern, hits in reg.discover_roots():
        for rel in hits:
            pr = {'key': '', 'type': '', 'name': '', 'path': rel}
            if rel.lower() not in seen and os.path.isdir(os.path.join(reg.abs(pr), reg.subject_dir)):
                out.append(pr)
                seen.add(rel.lower())
    if not out and not reg.projects and os.path.isdir(os.path.join(reg.root, reg.subject_dir)):
        out.append({'key': '', 'type': '', 'name': '', 'path': '.'})
    return out


def changed_roots(reg, roots, args):
    """Projects with pending changes (added, modified, unversioned, deleted) under their subject folder."""
    _kind, entries = pc.changed(reg, args, include_deleted=True)
    hits = []
    for pr in roots:
        prefix = ('' if pr['path'] == '.' else pr['path'].lower() + '/') + reg.subject_dir.lower() + '/'
        for _status, full in entries:
            rel = reg.rel(full)
            if rel and rel.lower().startswith(prefix):
                hits.append(pr)
                break
    return hits


# ---------------- main ----------------

def main(argv=None):
    pc.reconfigure_streams()
    ap = argparse.ArgumentParser(description='Generated "what was archived when" ledger per project + cross-project view')
    pc.add_common_args(ap)
    ap.add_argument('--root-glob', action='append', default=[], metavar='GLOB',
                    help='project-root glob relative to the KB root (repeatable; replaces root_globs)')
    ap.add_argument('--kinds', help='JSON kinds map (default: front matter ledger_kinds, else built in)')
    ap.add_argument('--ledger', help='per-project ledger pattern, KB-root relative or absolute ({path}, {key})')
    ap.add_argument('--ledger-all', help='cross-project ledger file')
    ap.add_argument('--project', action='append', default=[], help='project key or folder; repeatable')
    ap.add_argument('--changed', action='store_true', help='only projects with pending changes under the subject folder')
    ap.add_argument('--cross-index', action='store_true', help='also rewrite the cross view on a selective run')
    ap.add_argument('--index-only', action='store_true', help='only the cross-project view')
    ap.add_argument('--dry-run', action='store_true', help='report, write nothing')
    args = ap.parse_args(argv)
    try:
        reg = pc.registry_from_args(args, required=False, root_globs=args.root_glob, ledger=args.ledger,
                                    ledger_all=os.path.abspath(args.ledger_all) if args.ledger_all else None,
                                    ledger_kinds=os.path.abspath(args.kinds) if args.kinds else None)
        kinds_file = reg.fill(reg.config['ledger_kinds']) if reg.config['ledger_kinds'] else ''
        kinds = load_kinds(kinds_file)
    except pc.RegistryError as exc:
        return pc.fail(str(exc))
    except (OSError, ValueError) as exc:
        return pc.fail('kinds map: %s' % exc)
    if not os.path.isfile(reg.path):
        print('note: no projects registry at %s: projects come from the root globs or the KB root' % reg.path)

    generated = datetime.now().strftime('%Y-%m-%d %H:%M')
    roots = project_roots(reg)
    try:
        if args.index_only:
            write_cross_index(reg, roots, kinds, generated, args.dry_run)
            return 0
        selected = roots
        if args.project or args.changed:
            selected = []
            for want in args.project:
                norm = want.replace('\\', '/').strip('/').lower()
                hit = [pr for pr in roots if pr['key'].lower() == want.lower() or pr['path'].lower() == norm]
                if not hit:
                    print("unknown project '%s' (no registry row or root folder with a %s folder)" % (want, reg.subject_dir))
                    return 2
                if hit[0] not in selected:
                    selected.append(hit[0])
            if args.changed:
                selected += [pr for pr in changed_roots(reg, roots, args) if pr not in selected]
            if not selected:
                print('ledger: no project selected (nothing pending under %s)' % reg.subject_dir)
                return 0
        total = 0
        for pr in selected:
            rows = build_rows(reg.abs(pr), reg.subject_dir, kinds)
            if not rows:
                continue
            if not pr['key']:
                print('  WARN project root without a row in the registry: %s' % pr['path'])
            target = reg.fill(reg.config['ledger'], pr)
            if pc.inside_kit(target):
                return pc.fail('a ledger is a case file: keep it outside the kit folder (%s)' % target)
            text = render(pr, pr['path'], rows, generated, reg.config['scope_value'])
            if not args.dry_run:
                pc.write_text(target, text)
            total += len(rows)
            print('  %s%-16s %s: %d entries' % ('(dry) ' if args.dry_run else '', pr['key'] or '?',
                                                reg.rel(target) or target, len(rows)))
        print('ledger: %d entries across %d project(s)' % (total, len(selected)))
        if args.cross_index or selected == roots:
            write_cross_index(reg, roots, kinds, generated, args.dry_run)
    except vcs.VcsError as exc:
        return pc.fail(str(exc))
    except ValueError as exc:
        return pc.fail(str(exc))
    return 0


if __name__ == '__main__':
    sys.exit(main())
