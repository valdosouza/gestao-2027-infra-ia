#!/usr/bin/env python3
"""retire_gate.py - the frozen-source retirement gate (engine-kit runtime, T89).

An old store (a former share, a parallel runtime, a superseded knowledge base) is frozen
but stays visible for a while - so people may still edit it. This gate decides when it
may be retired:

  snapshot   record the old store as frozen: size, modification time and SHA-256 of every
             file (editor and runtime state excluded). Run once; again only with --force.
  check      compare the old store now with the snapshot: added, modified, deleted files,
             each with its new location (the migration manifest row first, then the
             longest prefix of the configured old-to-new map, else "no mapping"), and the
             human ruling on it, if any. Content decides: a touched file with the same bytes
             is not drift.
  rule       record one human ruling on one drift item: import (the change was carried into
             the new store - say where) or discard (with the reason). The ruling holds for
             the item's current bytes: if the file changes again, the item opens again.

The gate is GREEN at zero drift, or when every drift item carries a current ruling. Then a
human retires the old store (read-only, a SUPERSEDED pointer) - the tool never does: it
never writes inside the old store and never deletes anything.

Usage:
  python retire_gate.py snapshot --old <old-root> --out <snapshot.json> [--config FILE]
                                 [--freeze-date YYYY-MM-DD] [--force]
  python retire_gate.py check --old <old-root> --snapshot <snapshot.json> [--config FILE]
                              [--manifest <manifest.csv>] [--rulings <rulings.json>]
                              [--report <report.md>] [--json <report.json>]
  python retire_gate.py rule --old <old-root> --snapshot <snapshot.json> --rulings <rulings.json>
                             --path <old-relative path> --ruling import|discard --by <name>
                             --reason <text> [--date YYYY-MM-DD] [--config FILE]

Exit codes: 0 snapshot written / gate green / ruling recorded; 1 drift without a current
ruling (check); 2 usage, configuration, or a location the tool refuses to write.

Python 3.8+, standard library only.
"""

import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
if HERE not in sys.path:
    sys.path.insert(0, HERE)
import migration_common as mc  # noqa: E402

RULINGS = ('import', 'discard')
CHANGES = ('added', 'modified', 'deleted')


# ---------------------------------------------------------------- scan and diff

def scan(root, retirement):
    """{relative path: {size, mtime, sha256}} of every file under root, exclusions applied."""
    skip_dirs = set(retirement['exclude_dirs'])
    skip_files = set(retirement['exclude_files'])
    files = {}
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(d for d in dirnames if d not in skip_dirs)
        for name in sorted(filenames):
            if name in skip_files:
                continue
            full = os.path.join(dirpath, name)
            rel = os.path.relpath(full, root).replace(os.sep, '/')
            stat = os.stat(full)
            files[rel] = {'size': stat.st_size, 'mtime': mc.utc_of(stat.st_mtime), 'sha256': mc.sha256_of(full)}
    return files


def drift(snapshot_files, now):
    items = []
    for rel in sorted(set(now) - set(snapshot_files)):
        items.append({'path': rel, 'change': 'added', 'sha256': now[rel]['sha256']})
    for rel in sorted(set(snapshot_files) & set(now)):
        if now[rel]['sha256'] != snapshot_files[rel]['sha256']:
            items.append({'path': rel, 'change': 'modified', 'sha256': now[rel]['sha256']})
    for rel in sorted(set(snapshot_files) - set(now)):
        items.append({'path': rel, 'change': 'deleted', 'sha256': None})
    return items


# ---------------------------------------------------------------- old-to-new map

class Mapper(object):
    """Exact rows of the migration manifest first, then the longest prefix of the map."""

    def __init__(self, config, manifest=None):
        self.exact = {}
        if manifest:
            for row in mc.load_manifest(manifest, config):
                if row.source:
                    self.exact[row.source.lower()] = row.target
        self.prefixes = sorted(((mc.norm_rel(r['from']), r['to']) for r in config['retirement']['map']),
                               key=lambda pair: -len(pair[0]))

    def new_location(self, rel):
        target = self.exact.get(rel.lower())
        if target:
            return target, 'manifest'
        if rel.lower() in self.exact:
            return None, 'manifest row without a target'
        for prefix, to in self.prefixes:
            if not prefix or rel.lower().startswith(prefix.lower().rstrip('/') + '/') or rel.lower() == prefix.lower():
                if to is None:
                    return None, 'no counterpart (dropped in the map)'
                tail = rel[len(prefix):].lstrip('/') if prefix else rel
                if not tail:
                    return mc.norm_rel(to), 'map'
                return (mc.norm_rel(to).rstrip('/') + '/' + tail).lstrip('/'), 'map'
        return None, 'no mapping - decide manually'


# ---------------------------------------------------------------- files

def load_json(path, what):
    try:
        with open(path, 'r', encoding='utf-8') as handle:
            return json.load(handle)
    except (OSError, ValueError) as exc:
        raise mc.ConfigError('cannot read the %s %s: %s' % (what, path, exc))


def write_json(path, data):
    mc.write_text(path, json.dumps(data, indent=1, sort_keys=False, ensure_ascii=False) + '\n')


def load_rulings(path):
    if not path or not os.path.isfile(path):
        return []
    data = load_json(path, 'rulings file')
    rulings = data.get('rulings') if isinstance(data, dict) else None
    if not isinstance(rulings, list):
        raise mc.ConfigError('the rulings file %s has no "rulings" list' % path)
    return rulings


def current_ruling(item, rulings):
    """(ruling, stale): the latest ruling on this path, and whether it is for other bytes."""
    found = None
    for entry in rulings:
        if entry.get('path') == item['path']:
            found = entry
    if found is None:
        return None, False
    stale = found.get('change') != item['change'] or found.get('sha256') != item['sha256']
    return found, stale


def guards(old_root):
    return [(old_root, 'the frozen old store'), mc.kit_guard()]


# ---------------------------------------------------------------- commands

def cmd_snapshot(args, config):
    out = os.path.abspath(args.out)
    why = mc.guard_write(out, guards(args.old))
    if why:
        raise mc.ConfigError('snapshot refused: ' + why)
    if os.path.exists(out) and not args.force:
        raise mc.ConfigError('%s exists: a snapshot is taken once; pass --force to take it again on purpose' % out)
    freeze = args.freeze_date or config['retirement']['freeze_date'] or ''
    if freeze and not mc.valid_date(freeze):
        raise mc.ConfigError('the freeze date must be YYYY-MM-DD')
    files = scan(args.old, config['retirement'])
    write_json(out, {'_comment': 'Frozen-store snapshot (engine-kit retire_gate.py). Never edit by hand.',
                     'taken': mc.utc_now(), 'root': args.old, 'freeze_date': freeze, 'files': files})
    print('snapshot written: %s (%d files)' % (out, len(files)))
    if freeze:
        late = sorted(rel for rel, meta in files.items() if meta['mtime'][:10] > freeze)
        mapper = Mapper(config, args.manifest)
        print('review once: %d file(s) changed after the freeze date %s (possible edits between the freeze '
              'and this snapshot):' % (len(late), freeze))
        for rel in late:
            where, how = mapper.new_location(rel)
            print('  %s -> %s' % (rel, where or how))
    return 0


def evaluate(args, config):
    snapshot = load_json(args.snapshot, 'snapshot')
    if not isinstance(snapshot, dict) or not isinstance(snapshot.get('files'), dict):
        raise mc.ConfigError('%s is not a snapshot of this tool' % args.snapshot)
    items = drift(snapshot['files'], scan(args.old, config['retirement']))
    return snapshot, items


def cmd_check(args, config):
    snapshot, items = evaluate(args, config)
    for path in (args.report, args.json):
        if path:
            why = mc.guard_write(os.path.abspath(path), guards(args.old))
            if why:
                raise mc.ConfigError('report refused: ' + why)
    rulings = load_rulings(args.rulings)
    mapper = Mapper(config, args.manifest)
    open_items, ruled = [], {'import': 0, 'discard': 0}
    for item in items:
        item['new_location'], item['mapping'] = mapper.new_location(item['path'])
        entry, stale = current_ruling(item, rulings)
        if entry is not None and not stale:
            item['ruling'] = entry
            ruled[entry.get('ruling')] = ruled.get(entry.get('ruling'), 0) + 1
        else:
            item['ruling'] = None
            item['state'] = 'changed again after its ruling' if entry is not None else 'no ruling'
            open_items.append(item)
    green = not open_items
    if not items:
        verdict = 'GREEN - zero drift since the snapshot: the old store may be retired'
    elif green:
        verdict = 'GREEN - every drift item ruled (%d import, %d discard): the old store may be retired' % (
            ruled.get('import', 0), ruled.get('discard', 0))
    else:
        verdict = 'OPEN - %d of %d drift item(s) without a current ruling' % (len(open_items), len(items))
    counts = dict((c, sum(1 for i in items if i['change'] == c)) for c in CHANGES)
    report = {'_comment': 'Drift of the frozen old store since its snapshot (engine-kit retire_gate.py). '
                          'Each item needs a human ruling: import or discard. Never edit by hand.',
              'checked': mc.utc_now(), 'snapshot_taken': snapshot.get('taken'), 'root': args.old,
              'verdict': verdict, 'counts': counts, 'items': items}
    if args.json:
        write_json(os.path.abspath(args.json), report)
    if args.report:
        mc.write_text(os.path.abspath(args.report), render(report, config))
    print('added: %(added)d  modified: %(modified)d  deleted: %(deleted)d' % counts)
    for item in open_items:
        print('  OPEN %-8s %s -> %s' % (item['change'].upper(), item['path'],
                                        item['new_location'] or item['mapping']))
    print(verdict)
    if not green:
        print('Each open item needs a human ruling (rule --ruling import|discard); agents prepare, humans decide.')
    return 0 if green else 1


def render(report, config):
    L = ['# Retirement gate - drift report', '',
         '**Scope**: %s' % config['scope_value'],
         '**Generated by**: `runtime/migration/retire_gate.py` of the engine kit - never edited by hand',
         '**Old store**: `%s`' % report['root'],
         '**Snapshot taken**: %s - **checked**: %s' % (report['snapshot_taken'], report['checked']),
         '**Verdict**: %s' % report['verdict'], '',
         '| Change | Old path | New location | Ruling |', '|---|---|---|---|']
    for item in report['items']:
        ruling = item['ruling']
        text = ('%s by %s on %s: %s' % (ruling.get('ruling'), ruling.get('by'), ruling.get('date'),
                                        ruling.get('reason', '')) if ruling else '**open** - ' + item['state'])
        L.append('| %s | `%s` | %s | %s |' % (item['change'], item['path'],
                                             '`%s`' % item['new_location'] if item['new_location']
                                             else item['mapping'], text.replace('|', '\\|')))
    if not report['items']:
        L.append('| - | - | - | zero drift |')
    L += ['', 'Retire the old store only on a GREEN verdict: make it read-only and leave a SUPERSEDED',
          'pointer to the new store - never delete it as part of the gate.']
    return '\n'.join(L) + '\n'


def cmd_rule(args, config):
    rulings_path = os.path.abspath(args.rulings)
    why = mc.guard_write(rulings_path, guards(args.old))
    if why:
        raise mc.ConfigError('rulings file refused: ' + why)
    if not args.by.strip() or not args.reason.strip():
        raise mc.ConfigError('a ruling needs --by (the person who decides) and --reason')
    date = args.date or mc.today()
    if not mc.valid_date(date):
        raise mc.ConfigError('--date must be YYYY-MM-DD')
    _, items = evaluate(args, config)
    path = mc.norm_rel(args.path)
    item = next((i for i in items if i['path'] == path), None)
    if item is None:
        raise mc.ConfigError('%s is not a drift item of the old store (nothing to rule)' % path)
    rulings = load_rulings(rulings_path)
    rulings.append({'path': path, 'change': item['change'], 'sha256': item['sha256'], 'ruling': args.ruling,
                    'by': args.by.strip(), 'date': date, 'reason': args.reason.strip()})
    write_json(rulings_path, {'_comment': 'Human rulings on drift items of a frozen old store (engine-kit '
                                          'retire_gate.py). Append-only: a later ruling on a path supersedes '
                                          'the earlier one.', 'rulings': rulings})
    print('ruling recorded: %s %s -> %s by %s' % (item['change'], path, args.ruling, args.by.strip()))
    return 0


def main(argv=None):
    ap = argparse.ArgumentParser(description='Frozen-source retirement gate: snapshot, drift check, human rulings')
    sub = ap.add_subparsers(dest='command')
    common = argparse.ArgumentParser(add_help=False)
    common.add_argument('--old', required=True, help='root of the frozen old store (never written)')
    common.add_argument('--config', help='JSON configuration (the "retirement" block of migration.example.json)')
    common.add_argument('--manifest', help='the migration manifest: exact old-to-new rows')
    s = sub.add_parser('snapshot', parents=[common], help='record the old store as frozen')
    s.add_argument('--out', required=True, help='snapshot file (outside the old store)')
    s.add_argument('--freeze-date', help='YYYY-MM-DD: list the files changed after it once')
    s.add_argument('--force', action='store_true', help='take the snapshot again on purpose')
    c = sub.add_parser('check', parents=[common], help='drift since the snapshot and the gate verdict')
    c.add_argument('--snapshot', required=True)
    c.add_argument('--rulings', help='rulings file (JSON)')
    c.add_argument('--report', help='write the drift report as markdown')
    c.add_argument('--json', help='write the drift report as JSON')
    r = sub.add_parser('rule', parents=[common], help='record a human ruling on one drift item')
    r.add_argument('--snapshot', required=True)
    r.add_argument('--rulings', required=True)
    r.add_argument('--path', required=True, help='the drift item, relative to the old store')
    r.add_argument('--ruling', required=True, choices=RULINGS)
    r.add_argument('--by', required=True, help='the person who rules')
    r.add_argument('--reason', required=True, help='import: where it went; discard: why')
    r.add_argument('--date', help='YYYY-MM-DD (default: today)')
    args = ap.parse_args(argv)
    if not args.command:
        ap.print_help()
        return 2
    try:
        config = mc.load_config(args.config)
        args.old = os.path.abspath(args.old)
        if not os.path.isdir(args.old):
            raise mc.ConfigError('the old store %s is not a folder' % args.old)
        handler = {'snapshot': cmd_snapshot, 'check': cmd_check, 'rule': cmd_rule}[args.command]
        return handler(args, config)
    except mc.ConfigError as exc:
        print('error: %s' % exc, file=sys.stderr)
        return 2


if __name__ == '__main__':
    sys.exit(main())
