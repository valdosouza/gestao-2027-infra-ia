#!/usr/bin/env python3
"""migrate.py - manifest-driven migration of a knowledge base (engine-kit runtime, T61).

Moves the files of an old store (a knowledge base, a parallel agent runtime, a former
share) into a new store, one manifest row per file, WITHOUT fixing content:

  - markdown rows: the body stays byte for byte (line endings and BOM included) except
    for three mechanical changes - relative links and wikilinks to other manifest rows
    point at their new place; the configured address rewrites (old roots, old prefixes);
    provenance keys added to the front matter (origin, migration date, ...) and a Scope
    line when the file has none. Existing front-matter keys are never changed.
  - copy rows (anything that is not markdown, or a kind with "transform": "copy"): the
    bytes as they are.
  - collisions (the target already exists): the target's body and keys win; only the
    keys it lacks are added (provenance, and source keys matching merge_keys).
  - every problem is a line of the migration log, never a silent fix: no target, a
    missing source, an unsafe or duplicate target, unresolved links, leftovers of the old
    store's addresses.

Default mode is the DRY RUN: files go to a fresh staging folder outside both stores, at
the same relative paths as in the target, for an owner to spot-check; the target is only
read. --apply writes into the target, optionally one batch at a time (--batch,
repeatable). Either way the tool never deletes or renames anything and runs no command:
committing is a human step, retiring the old store is retire_gate.py's job.

Usage:
  python migrate.py --source <old-root> --target <new-root> --manifest <manifest.csv>
                    [--config <migration.json>] [--staging DIR] [--report-dir DIR]
                    [--date YYYY-MM-DD] [--batch NAME ...] [--apply]

Exit codes: 0 every selected row migrated (or staged); 1 a selected row is blocked (a
leftover included); 2 usage, configuration, or a location the tool refuses to write.

Python 3.8+, standard library only.
"""

import argparse
import collections
import csv
import fnmatch
import os
import posixpath
import re
import sys
import tempfile
import time
from urllib.parse import unquote

HERE = os.path.dirname(os.path.abspath(__file__))
if HERE not in sys.path:
    sys.path.insert(0, HERE)
import migration_common as mc  # noqa: E402

FM_KEY = re.compile(r'^([A-Za-z_][A-Za-z0-9_-]*):(.*)$')
SCOPE_RE = re.compile(r'^\*\*(?:Scope|Escopo)\*\*:')
MD_LINK = re.compile(r'(\[[^\]]*\]\()([^)\s]+)((?:\s+"[^"]*")?\))')
WIKILINK = re.compile(r'\[\[([^\]|#]+?)(#[^\]|]*)?(\|[^\]]*)?\]\]')
SCHEME = re.compile(r'^[A-Za-z][A-Za-z0-9+.-]*:')
PLACEHOLDER = re.compile(r'\{(\w+)\}')
BOM = b'\xef\xbb\xbf'
STATUSES = ('migrated', 'merged', 'unchanged', 'kept', 'duplicate', 'blocked', 'not selected')
DIFFERS = 'collision: the target exists and differs'


# ---------------------------------------------------------------- text helpers

def decode(raw):
    """(lines, bom) or None when the bytes are not UTF-8. lines: [[content, terminator]],
    so that joining them gives back the exact text (CRLF, LF or mixed)."""
    bom = raw.startswith(BOM)
    try:
        text = (raw[3:] if bom else raw).decode('utf-8')
    except UnicodeDecodeError:
        return None
    parts = re.split(r'(\r\n|\n)', text)
    lines = [[parts[i], parts[i + 1] if i + 1 < len(parts) else ''] for i in range(0, len(parts), 2)]
    return lines, bom


def encode(lines, bom):
    data = ''.join(c + t for c, t in lines).encode('utf-8')
    return BOM + data if bom else data


def newline_of(lines):
    crlf = sum(1 for _, t in lines if t == '\r\n')
    lf = sum(1 for _, t in lines if t == '\n')
    return '\r\n' if crlf > lf else '\n'


def front_matter(lines):
    """(start, end) indexes of the two '---' fences, or None (also when it is not closed)."""
    if not lines or lines[0][0].strip() != '---':
        return None
    for index in range(1, len(lines)):
        if lines[index][0].strip() in ('---', '...'):
            return 0, index
    return None


def fm_entries(lines, fm):
    """[(key, [raw line contents])]: each top-level key with its continuation lines."""
    entries = []
    for content, _ in lines[fm[0] + 1:fm[1]]:
        match = FM_KEY.match(content)
        if match:
            entries.append((match.group(1), [content]))
        elif entries and (content.startswith((' ', '\t', '-')) or not content.strip()):
            entries[-1][1].append(content)
    return entries


def add_keys(lines, new, nl):
    """Insert the keys of new ([(key, [contents])]) that the front matter lacks, before its
    closing fence; create the block when the file has none. Returns the keys added."""
    fm = front_matter(lines)
    have = set(key for key, _ in fm_entries(lines, fm)) if fm else set()
    block, added = [], []
    for key, contents in new:
        if key in have or key in added:
            continue
        added.append(key)
        block.extend([c, nl] for c in contents)
    if block:
        if fm:
            lines[fm[1]:fm[1]] = block
        else:
            lines[0:0] = [['---', nl]] + block + [['---', nl]]
    return added


def fill(template, ctx):
    return PLACEHOLDER.sub(lambda m: ctx.get(m.group(1), m.group(0)), str(template))


def rel_link(target, from_dir):
    """The '/'-path of target as seen from the folder from_dir (both store-relative)."""
    t = target.split('/')
    f = from_dir.split('/') if from_dir else []
    i = 0
    while i < len(t) - 1 and i < len(f) and t[i] == f[i]:
        i += 1
    return '/'.join(['..'] * (len(f) - i) + t[i:])


def strip_md(path):
    return path[:-3] if path.lower().endswith('.md') else path


# ---------------------------------------------------------------- the migration

class Migration(object):
    def __init__(self, config, source_root, target_root, date, rows):
        self.config = config
        self.source_root = source_root
        self.target_root = target_root
        self.date = date
        self.rows = rows
        self.md_exts = set(e.lower() for e in config['markdown_extensions'])
        self.by_source = {}
        self.by_source_ci = {}
        self.by_stem = collections.defaultdict(list)
        self.unresolved = collections.Counter()
        self.leftover_res = []
        for pattern in config['leftovers']:
            if pattern.startswith('re:'):
                self.leftover_res.append((pattern, re.compile(pattern[3:])))
            else:
                self.leftover_res.append((pattern, re.compile(re.escape(pattern), re.IGNORECASE)))

    # -- validation ------------------------------------------------------------

    def validate(self):
        """Every row checked before anything is transformed; the rows sorted in run order."""
        order = dict((name, i) for i, name in enumerate(self.config['batch_order']))
        self.rows.sort(key=lambda r: (order.get(r.batch, len(order)), '' if r.batch in order else r.batch,
                                      r.target.lower(), r.line))
        targets, first_by_hash = {}, {}
        for row in self.rows:
            if not row.source:
                row.block('no source: the manifest row has no source path')
            elif not mc.rel_ok(row.source):
                row.block('unsafe source: absolute, above the store root or invalid: %s' % row.source)
            elif row.source in self.by_source:
                row.block('duplicate source row: first at manifest line %d' % self.by_source[row.source].line)
            else:
                self.by_source[row.source] = row
                self.by_source_ci.setdefault(row.source.lower(), row)
                stem = posixpath.splitext(posixpath.basename(row.source))[0].lower()
                self.by_stem[stem].append(row)
                if not os.path.isfile(self.src_path(row)):
                    row.block('missing source: %s is not a file of the old store' % row.source)
            if not row.target:
                row.block('no target: the owner decides where it goes (a decision round), never a guess')
            elif not mc.rel_ok(row.target):
                row.block('unsafe target: absolute, above the store root or invalid: %s' % row.target)
            else:
                key = row.target.lower()
                if key in targets:
                    row.block('duplicate target: also the target of manifest line %d' % targets[key].line)
                else:
                    targets[key] = row
                if mc.inside(self.dst_path(row, self.target_root), self.source_root):
                    row.block('target inside the old store: %s' % row.target)
        if self.config['dedupe_identical']:
            for row in sorted(self.rows, key=lambda r: r.line):  # the first copy in the manifest wins
                if row.blocked:
                    continue
                digest = mc.sha256_of(self.src_path(row))
                if digest in first_by_hash:
                    row.duplicate_of = first_by_hash[digest]
                    row.note_problem('identical copy: same bytes as %s, migrated once, there'
                                     % row.duplicate_of.source)
                else:
                    first_by_hash[digest] = row

    def src_path(self, row):
        return os.path.join(self.source_root, *row.source.split('/'))

    def dst_path(self, row, root):
        return os.path.join(root, *row.target.split('/'))

    def profile(self, row):
        prof = self.config['kinds'].get(row.kind) if row.kind else None
        if row.kind and prof is None:
            row.note_problem("kind without a profile: '%s', defaults used" % row.kind)
        prof = prof or {}
        ext = posixpath.splitext(row.source)[1].lower()
        transform = prof.get('transform') or ('markdown' if ext in self.md_exts else 'copy')
        scope = prof['scope_line'] if 'scope_line' in prof else self.config['scope_line']
        return transform, scope, prof.get('front_matter') or {}

    def ctx(self, row):
        return {'source': row.source, 'target': row.target, 'date': self.date, 'batch': row.batch,
                'kind': row.kind, 'source_name': self.config['source_name'], 'name': self.config['name']}

    # -- links -----------------------------------------------------------------

    def lookup(self, path):
        hit = self.by_source.get(path) or self.by_source_ci.get(path.lower())
        if hit is None and not posixpath.splitext(path)[1]:
            hit = self.by_source.get(path + '.md') or self.by_source_ci.get((path + '.md').lower())
        while hit is not None and hit.duplicate_of is not None:
            hit = hit.duplicate_of
        return hit

    def rewrite_md_link(self, row, raw, counter):
        if SCHEME.match(raw) or raw.startswith(('#', '/', '<')):
            return raw
        path, sep, anchor = raw.partition('#')
        if not path:
            return raw
        joined = posixpath.normpath(posixpath.join(posixpath.dirname(row.source), unquote(path)))
        if joined == '..' or joined.startswith('../'):
            return self.miss(row, raw, 'link above the old store root')
        hit = self.lookup(joined)
        if hit is None:
            if os.path.exists(os.path.join(self.source_root, *joined.split('/'))):
                return self.miss(row, raw, 'link to a file outside the manifest')
            return self.miss(row, raw, 'dead link (already broken in the old store)')
        if hit.blocked:
            return self.miss(row, raw, 'link to a blocked row (manifest line %d)' % hit.line)
        new = rel_link(hit.target, posixpath.dirname(row.target))
        if '%' in path or ' ' in new:
            new = new.replace(' ', '%20')
        new = new + sep + anchor
        if new != raw:
            counter[0] += 1
        return new

    def rewrite_wikilink(self, row, match, counter):
        name, anchor, alias = match.group(1), match.group(2) or '', match.group(3) or ''
        ref = mc.norm_rel(name.strip())
        hit = self.lookup(ref)
        if hit is None:
            joined = posixpath.normpath(posixpath.join(posixpath.dirname(row.source), ref))
            if not joined.startswith('..'):
                hit = self.lookup(joined)
        if hit is None:
            same_stem = self.by_stem.get(posixpath.splitext(posixpath.basename(ref))[0].lower(), [])
            if len(same_stem) == 1:
                hit = self.lookup(same_stem[0].source)
        if hit is None:
            return self.miss(row, match.group(0), 'unresolved wikilink')
        if hit.blocked:
            return self.miss(row, match.group(0), 'link to a blocked row (manifest line %d)' % hit.line)
        new = '[[' + strip_md(hit.target) + anchor + alias + ']]'
        if new != match.group(0):
            counter[0] += 1
        return new

    def miss(self, row, link, why):
        row.note_problem('%s: %s' % (why, link))
        self.unresolved[(link, why)] += 1
        return link

    # -- transforms ------------------------------------------------------------

    def rewrite_line(self, content, counter):
        for rule in self.config['rewrites']:
            if rule.get('regex'):
                content, n = re.subn(rule['find'], rule['replace'], content)
            else:
                n = content.count(rule['find'])
                content = content.replace(rule['find'], rule['replace'])
            counter[0] += n
        return content

    def transform_markdown(self, row, raw, scope, extra_keys):
        decoded = decode(raw)
        if decoded is None:
            row.note_problem('not UTF-8: copied byte for byte, no provenance and no link rewrite')
            return raw
        lines, bom = decoded
        nl = newline_of(lines)
        fm = front_matter(lines)
        if fm is None and lines and lines[0][0].strip() == '---':
            row.note_problem('front matter not closed: in the source; a new block is added above it')
        body_from = fm[1] + 1 if fm else 0
        links, rewrites = [0], [0]
        in_fence = False
        for index, line in enumerate(lines):
            content = self.rewrite_line(line[0], rewrites)
            if index >= body_from:
                if content.lstrip().startswith('```'):
                    in_fence = not in_fence
                elif not in_fence:
                    content = MD_LINK.sub(lambda m: m.group(1) + self.rewrite_md_link(row, m.group(2), links)
                                          + m.group(3), content)
                    content = WIKILINK.sub(lambda m: self.rewrite_wikilink(row, m, links), content)
            line[0] = content
        row.links_rewritten = links[0]
        if links[0]:
            row.actions.append('links +%d' % links[0])
        if rewrites[0]:
            row.actions.append('rewrites +%d' % rewrites[0])
        if scope and not any(SCOPE_RE.match(c.strip()) for c, _ in lines[body_from:body_from + 40]):
            first = next((i for i in range(body_from, len(lines)) if lines[i][0].strip()), None)
            if first is not None and lines[first][0].startswith('# '):
                if not lines[first][1]:
                    lines[first][1] = nl
                lines[first + 1:first + 1] = [['', nl], ['**Scope**: %s' % scope, nl]]
            else:
                at = body_from if first is None else first
                lines[at:at] = [['**Scope**: %s' % scope, nl], ['', nl]]
            row.actions.append('Scope line')
        keys = self.provenance_keys(row) + [(k, ['%s: %s' % (k, fill(v, self.ctx(row)))])
                                            for k, v in extra_keys.items()]
        added = add_keys(lines, keys, nl)
        if added:
            row.actions.append('front matter +' + ','.join(added))
        return encode(lines, bom)

    def provenance_keys(self, row):
        return [(k, ['%s: %s' % (k, fill(v, self.ctx(row)))]) for k, v in self.config['provenance'].items() if v]

    def merge_collision(self, row, raw_source, existing, transform):
        """The target already exists: its body and keys win; only missing keys are added."""
        row.collision = True
        row.existing = existing
        target_text = decode(existing)
        if transform == 'copy' or target_text is None:
            if existing != raw_source:
                row.note_problem(DIFFERS + '; the target is kept, the source is not copied')
            return existing
        lines, bom = target_text
        keys = self.provenance_keys(row)
        source_text = decode(raw_source)
        if self.config['merge_keys'] and source_text is not None:
            sfm = front_matter(source_text[0])
            if sfm:
                keys += [(key, contents) for key, contents in fm_entries(source_text[0], sfm)
                         if any(fnmatch.fnmatchcase(key, p) for p in self.config['merge_keys'])]
        added = add_keys(lines, keys, newline_of(lines))
        row.actions.append('collision: target body kept' + (', front matter +' + ','.join(added) if added else ''))
        return encode(lines, bom)

    def check_leftovers(self, row, data):
        try:
            text = data.decode('utf-8')
        except UnicodeDecodeError:
            return
        for label, regex in self.leftover_res:
            hits = len(regex.findall(text))
            if hits:
                row.block("leftover: '%s' x%d after the rewrites" % (label, hits))

    def build(self):
        for row in self.rows:
            if row.blocked or row.duplicate_of is not None:
                continue
            with open(self.src_path(row), 'rb') as handle:
                raw = handle.read()
            transform, scope, extra = self.profile(row)
            dest = self.dst_path(row, self.target_root)
            if os.path.isfile(dest):
                with open(dest, 'rb') as handle:
                    row.output = self.merge_collision(row, raw, handle.read(), transform)
            elif transform == 'markdown':
                row.output = self.transform_markdown(row, raw, scope, extra)
                self.check_leftovers(row, row.output)
            else:
                row.output = raw

    def status(self, row, selected):
        if row.blocked:
            return 'blocked'
        if row.duplicate_of is not None:
            return 'duplicate'
        if not selected:
            return 'not selected'
        if row.collision:
            if row.output == row.existing:
                return 'kept' if any(t.startswith(DIFFERS) for _, t in row.problems) else 'unchanged'
            return 'merged'
        return 'migrated'


# ---------------------------------------------------------------- report

def spot_sample(rows, k):
    """Deterministic and stratified: collisions, then one row per (batch, kind), then the rows
    with the most notes, then the rest - only rows that were written."""
    picked, seen = [], set()

    def take(row):
        if row.source not in seen and len(picked) < k and row.status in ('migrated', 'merged'):
            picked.append(row)
            seen.add(row.source)
    for row in rows:
        if row.collision:
            take(row)
    pairs = set()
    for row in rows:
        if (row.batch, row.kind) not in pairs:
            pairs.add((row.batch, row.kind))
            take(row)
    for row in sorted(rows, key=lambda r: -len(r.problems)):
        take(row)
    for row in rows:
        take(row)
    return picked


def cell(text):
    return str(text).replace('|', '\\|').replace('\n', ' ')


def code(text):
    return '`%s`' % cell(text) if text else '-'


def category(text):
    return text.split(':', 1)[0].strip()


def write_reports(manifest, mig, out_root, report_dir, mode):
    rows = mig.rows
    stamp = '%s-%s' % (mig.config['name'], mig.date)
    md_path = os.path.join(report_dir, 'migration-log-%s.md' % stamp)
    csv_path = os.path.join(report_dir, 'migration-log-%s.csv' % stamp)
    os.makedirs(report_dir, exist_ok=True)
    with open(csv_path, 'w', encoding='utf-8', newline='') as handle:
        out = csv.writer(handle, lineterminator='\n')
        out.writerow(['line', 'batch', 'kind', 'source', 'target', 'status', 'collision', 'links_rewritten',
                      'actions', 'problems', 'written_to'])
        for r in rows:
            out.writerow([r.line, r.batch, r.kind, r.source, r.target, r.status, 'yes' if r.collision else '',
                          r.links_rewritten, ' | '.join(r.actions),
                          ' | '.join('%s %s' % (level, text) for level, text in r.problems), r.written_to])
    count = collections.Counter(r.status for r in rows)
    L = ['# Migration log - %s - %s %s' % (mig.config['name'], mode, mig.date), '',
         '**Scope**: %s' % mig.config['scope_value'],
         '**Generated by**: `runtime/migration/migrate.py` of the engine kit - never edited by hand; run it again',
         '**Mode**: %s' % ('dry run - the target was only read; the files were staged for review' if mode == 'dry run'
                           else 'apply - written into the target working copy; nothing committed, nothing deleted'),
         '**Old store**: `%s`' % mig.source_root,
         '**Target**: `%s`' % mig.target_root,
         '**Manifest**: `%s`' % os.path.basename(manifest),
         '**Files written to**: `%s`' % out_root, '',
         '## 1. Totals', '', '| Measure | Value |', '|---|---|',
         '| Manifest rows | %d |' % len(rows)]
    L += ['| %s | %d |' % (s.capitalize(), count.get(s, 0)) for s in STATUSES]
    L += ['| Collisions with files already in the target | %d |' % sum(1 for r in rows if r.collision),
          '| Links rewritten | %d |' % sum(r.links_rewritten for r in rows),
          '| Unresolved links (distinct) | %d |' % len(mig.unresolved), '',
          '## 2. Batches (run order)', '',
          '| Batch | Rows | Migrated | Merged | Unchanged | Blocked | Not selected | Rows with notes |',
          '|---|---|---|---|---|---|---|---|']
    batches = collections.OrderedDict()
    for r in rows:
        batches.setdefault(r.batch or '-', []).append(r)
    for name, rs in batches.items():
        c = collections.Counter(r.status for r in rs)
        L.append('| %s | %d | %d | %d | %d | %d | %d | %d |' % (
            cell(name), len(rs), c['migrated'], c['merged'], c['unchanged'], c['blocked'], c['not selected'],
            sum(1 for r in rs if any(level == 'note' for level, _ in r.problems))))
    L += ['', '## 3. Blocking problems', '',
          'Fix the manifest or ask the owner (a decision round); never the content.', '']
    blocking = [(r, t) for r in rows for level, t in r.problems if level == 'block']
    if blocking:
        L += ['| Line | Source | Target | Problem |', '|---|---|---|---|']
        L += ['| %d | %s | %s | %s |' % (r.line, code(r.source), code(r.target), cell(t)) for r, t in blocking]
    else:
        L.append('- none')
    notes = collections.Counter(category(t) for r in rows for level, t in r.problems if level == 'note')
    L += ['', '## 4. Notes by kind', '', 'Listed for a later round; the migration does not act on them.', '']
    if notes:
        L += ['| Kind | Count |', '|---|---|'] + ['| %s | %d |' % (cell(k), n) for k, n in notes.most_common()]
    else:
        L.append('- none')
    L += ['', '## 5. Unresolved links', '', 'Left as written; pair them by hand or accept them as dead.', '']
    if mig.unresolved:
        L += ['| Link as written | Why | Occurrences |', '|---|---|---|']
        L += ['| `%s` | %s | %d |' % (cell(link), cell(why), n) for (link, why), n in mig.unresolved.most_common()]
    else:
        L.append('- none')
    L += ['', '## 6. Collisions (the target body is kept)', '']
    L += ['- `%s` <- `%s` (%s)' % (r.target, r.source, r.status) for r in rows if r.collision] or ['- none']
    sample = spot_sample(rows, int(mig.config['spot_check']))
    L += ['', '## 7. Spot-check sample (%d rows)' % len(sample), '',
          'Open each written file next to its source. Tick a row when the place, the front matter and '
          'the links are right and the body is unchanged.', '',
          '| Done | Batch | Kind | Source | Written as (under the folder above) | Notes |', '|---|---|---|---|---|---|']
    for r in sample:
        L.append('| [ ] | %s | %s | %s | %s | %s |' % (
            cell(r.batch or '-'), cell(r.kind or '-'), code(r.source), code(r.target),
            cell('; '.join(t for _, t in r.problems[:3]) or '-')))
    L += ['', 'Per-row detail: `%s`.' % os.path.basename(csv_path)]
    with open(md_path, 'w', encoding='utf-8', newline='\n') as handle:
        handle.write('\n'.join(L) + '\n')
    return md_path, csv_path


# ---------------------------------------------------------------- main

def fresh_folder(base, label):
    path = os.path.join(base, label)
    n = 1
    while os.path.exists(path):
        n += 1
        path = os.path.join(base, '%s-%d' % (label, n))
    return path


def fail(message):
    print('error: %s' % message, file=sys.stderr)
    return 2


def main(argv=None):
    ap = argparse.ArgumentParser(description='Manifest-driven knowledge-base migration (dry run by default)')
    ap.add_argument('--source', required=True, help='root of the old store (only read)')
    ap.add_argument('--target', required=True, help='root of the new store (only read in a dry run)')
    ap.add_argument('--manifest', required=True, help='CSV, one row per file of the old store')
    ap.add_argument('--config', help='JSON configuration (see migration.example.json)')
    ap.add_argument('--staging', help='dry-run output folder (default: a fresh folder under the system temp)')
    ap.add_argument('--report-dir', help='where the migration log goes (default: the staging folder)')
    ap.add_argument('--date', help='migration date written into the provenance (default: today)')
    ap.add_argument('--batch', action='append', default=[], help='write only this batch (repeatable)')
    ap.add_argument('--apply', action='store_true', help='write into the target instead of a staging folder')
    args = ap.parse_args(argv)

    try:
        config = mc.load_config(args.config)
        date = args.date or mc.today()
        if not mc.valid_date(date):
            raise mc.ConfigError('--date must be YYYY-MM-DD')
        source = os.path.abspath(args.source)
        target = os.path.abspath(args.target)
        if not os.path.isdir(source):
            raise mc.ConfigError('the old store %s is not a folder' % source)
        if args.apply and not os.path.isdir(target):
            raise mc.ConfigError('the target %s is not a folder' % target)
        if mc.inside(target, source):
            raise mc.ConfigError('the target %s lies inside the old store' % target)
        if args.apply and mc.inside(target, mc.KIT_ROOT):
            raise mc.ConfigError('the target %s is inside the kit folder: a migration never writes there' % target)
        rows = mc.load_manifest(args.manifest, config)
        if not rows:
            raise mc.ConfigError('the manifest %s has no rows' % args.manifest)
        unknown = set(args.batch) - set(r.batch for r in rows)
        if unknown:
            raise mc.ConfigError('--batch %s: no such batch in the manifest' % ', '.join(sorted(unknown)))
    except mc.ConfigError as exc:
        return fail(str(exc))

    label = '%s-%s-%s' % (config['name'], date, time.strftime('%H%M%S'))
    base = os.path.join(tempfile.gettempdir(), 'kb-migration')
    staging = None
    if not args.apply:
        staging = os.path.abspath(args.staging) if args.staging else fresh_folder(base, label)
        why = mc.guard_write(staging, [(source, 'the old store'), (target, 'the target'), mc.kit_guard()])
        if why:
            return fail('staging refused: ' + why)
    report_dir = os.path.abspath(args.report_dir) if args.report_dir else (
        staging or fresh_folder(base, label + '-apply'))
    why = mc.guard_write(report_dir, [(source, 'the old store'), mc.kit_guard()])
    if why:
        return fail('report folder refused: ' + why)

    mig = Migration(config, source, target, date, rows)
    mig.validate()
    mig.build()
    out_root = staging or target
    selected_batches = set(args.batch)
    written = 0
    for row in rows:
        selected = not selected_batches or row.batch in selected_batches
        row.status = mig.status(row, selected)
        if row.status not in ('migrated', 'merged'):
            continue
        dest = mig.dst_path(row, out_root)
        why = mc.guard_write(dest, [(source, 'the old store'), mc.kit_guard()])
        if why:
            row.block('write refused: ' + why)
            row.status = 'blocked'
            continue
        mc.write_bytes(dest, row.output)
        row.written_to = dest
        written += 1
    mode = 'apply' if args.apply else 'dry run'
    md_path, csv_path = write_reports(args.manifest, mig, out_root, report_dir, mode)
    counts = collections.Counter(r.status for r in rows)
    print('%s: %d row(s) - %s' % (mode.upper(), len(rows),
                                  ', '.join('%d %s' % (counts[s], s) for s in STATUSES if counts.get(s))))
    print('files written: %d -> %s' % (written, out_root))
    print('log: ' + md_path)
    print('csv: ' + csv_path)
    blocked = [r for r in rows if r.blocked and (not selected_batches or r.batch in selected_batches)]
    return 1 if blocked else 0


if __name__ == '__main__':
    sys.exit(main())
