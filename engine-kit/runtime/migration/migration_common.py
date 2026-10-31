#!/usr/bin/env python3
"""migration_common.py - shared pieces of the migration tools (engine-kit runtime).

Used by migrate.py (the manifest-driven migration, T61) and retire_gate.py (the
frozen-source retirement gate, T89):

  load_config(path)            -> the configuration with every default filled in
  load_manifest(path, config)  -> [Row]; the column names come from the configuration
  inside(path, root)           -> True when path is root or below it
  guard_write(path, ...)       -> None, or the reason why a tool must not write there
  rel_ok(path)                 -> True for a safe store-relative path (no '..', no drive)
  sha256_of(path), utc_now(), today()

Nothing here runs a command or touches version control. Python 3.8+, standard library only.
"""

import copy
import csv
import datetime
import hashlib
import json
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
KIT_ROOT = os.path.dirname(os.path.dirname(HERE))

DEFAULTS = {
    'name': 'migration',
    'source_name': 'old',
    'scope_value': 'case',
    'columns': {'source': 'source', 'target': 'target', 'batch': 'batch', 'kind': 'kind', 'note': 'note'},
    'batch_order': [],
    'markdown_extensions': ['.md', '.markdown'],
    'scope_line': None,
    'provenance': {'origin': '"{source_name}:{source}"', 'migrated': '{date}'},
    'kinds': {},
    'merge_keys': [],
    'rewrites': [],
    'leftovers': [],
    'dedupe_identical': False,
    'spot_check': 20,
    'retirement': {
        'map': [],
        'freeze_date': '',
        'exclude_dirs': ['.git', '.svn', '.hg', '.obsidian', '.trash', 'node_modules', '__pycache__'],
        'exclude_files': ['Thumbs.db', 'desktop.ini', '.DS_Store'],
    },
}
KIND_KEYS = {'transform', 'scope_line', 'front_matter'}
TRANSFORMS = ('markdown', 'copy')
UNSAFE_CHARS = re.compile(r'[<>:"|?*\x00-\x1f]')


class ConfigError(Exception):
    """The configuration or the manifest cannot be used as given."""


class Row(object):
    """One manifest row: where a file of the old store goes in the new one."""

    def __init__(self, line, source, target, batch, kind, note, extra):
        self.line = line            # line number in the manifest (header = 1)
        self.source = source        # store-relative, '/' separators
        self.target = target
        self.batch = batch
        self.kind = kind
        self.note = note
        self.extra = extra          # the other columns, as read
        self.problems = []          # [(level, 'category: detail')], level 'block' or 'note'
        self.actions = []
        self.status = ''
        self.collision = False
        self.existing = None        # bytes of the target when it already exists
        self.duplicate_of = None    # the row holding the same bytes (dedupe_identical)
        self.links_rewritten = 0
        self.output = None          # bytes to write, when the row migrates
        self.written_to = ''

    @property
    def blocked(self):
        return any(level == 'block' for level, _ in self.problems)

    def block(self, text):
        self.problems.append(('block', text))

    def note_problem(self, text):
        self.problems.append(('note', text))


def _merge(base, extra):
    out = copy.deepcopy(base)
    for key, value in extra.items():
        if key.startswith('_'):
            continue
        if isinstance(value, dict) and isinstance(out.get(key), dict) and key != 'kinds':
            out[key] = _merge(out[key], value)
        else:
            out[key] = copy.deepcopy(value)
    return out


def load_config(path=None):
    """The configuration as a dict, defaults filled in; keys starting with '_' are notes."""
    raw = {}
    if path:
        try:
            with open(path, 'r', encoding='utf-8') as handle:
                raw = json.load(handle)
        except (OSError, ValueError) as exc:
            raise ConfigError('cannot read the configuration %s: %s' % (path, exc))
        if not isinstance(raw, dict):
            raise ConfigError('the configuration must be a JSON object')
    config = _merge(DEFAULTS, raw)
    for name, profile in config['kinds'].items():
        if not isinstance(profile, dict):
            raise ConfigError('kinds.%s must be an object' % name)
        unknown = set(k for k in profile if not k.startswith('_')) - KIND_KEYS
        if unknown:
            raise ConfigError('kinds.%s: unknown key(s) %s' % (name, ', '.join(sorted(unknown))))
        if profile.get('transform', 'markdown') not in TRANSFORMS:
            raise ConfigError('kinds.%s.transform must be one of %s' % (name, ', '.join(TRANSFORMS)))
    for index, rule in enumerate(config['rewrites']):
        if not isinstance(rule, dict) or 'find' not in rule or 'replace' not in rule:
            raise ConfigError('rewrites[%d] needs "find" and "replace"' % index)
        if rule.get('regex'):
            try:
                re.compile(rule['find'])
            except re.error as exc:
                raise ConfigError('rewrites[%d]: bad regular expression: %s' % (index, exc))
    for pattern in config['leftovers']:
        if pattern.startswith('re:'):
            try:
                re.compile(pattern[3:])
            except re.error as exc:
                raise ConfigError('leftovers: bad regular expression %r: %s' % (pattern, exc))
    for index, rule in enumerate(config['retirement']['map']):
        if not isinstance(rule, dict) or 'from' not in rule or 'to' not in rule:
            raise ConfigError('retirement.map[%d] needs "from" and "to" (to may be null)' % index)
    return config


def norm_rel(path):
    """Store-relative path with '/' separators and no leading './'."""
    path = (path or '').strip().replace('\\', '/')
    while path.startswith('./'):
        path = path[2:]
    return path


def rel_ok(path):
    """A safe store-relative path: not empty, not absolute, never above the store root."""
    if not path or path.startswith('/') or re.match(r'^[A-Za-z]:', path) or path.startswith('//'):
        return False
    parts = path.split('/')
    if any(p in ('', '.', '..') for p in parts):
        return False
    return not UNSAFE_CHARS.search(path)


def load_manifest(path, config):
    """[Row] in file order. Raises ConfigError on a missing source or target column."""
    cols = config['columns']
    try:
        with open(path, 'r', encoding='utf-8-sig', newline='') as handle:
            reader = csv.DictReader(handle)
            header = reader.fieldnames or []
            for key in ('source', 'target'):
                if cols[key] not in header:
                    raise ConfigError('manifest %s has no "%s" column (columns.%s)' % (path, cols[key], key))
            rows = []
            for number, record in enumerate(reader, 2):
                if not any((v or '').strip() for v in record.values() if isinstance(v, str)):
                    continue
                get = lambda key: (record.get(cols.get(key, ''), '') or '').strip()
                known = set(cols.values())
                extra = dict((k, v) for k, v in record.items() if k not in known and k is not None)
                rows.append(Row(number, norm_rel(get('source')), norm_rel(get('target')),
                                get('batch'), get('kind'), get('note'), extra))
    except OSError as exc:
        raise ConfigError('cannot read the manifest %s: %s' % (path, exc))
    return rows


def inside(path, root):
    """True when path is root itself or lies below it (case-insensitive where the OS is)."""
    try:
        common = os.path.commonpath([os.path.abspath(path), os.path.abspath(root)])
    except ValueError:  # different drives
        return False
    return os.path.normcase(common) == os.path.normcase(os.path.abspath(root))


def guard_write(path, forbidden):
    """None when path may be written; else the reason. forbidden: [(root, label)]."""
    for root, label in forbidden:
        if root and inside(path, root):
            return '%s is inside %s (%s)' % (path, label, root)
    return None


def kit_guard():
    return (KIT_ROOT, 'the kit folder')


def sha256_of(path):
    digest = hashlib.sha256()
    with open(path, 'rb') as handle:
        for block in iter(lambda: handle.read(1 << 16), b''):
            digest.update(block)
    return digest.hexdigest()


def utc_now():
    return datetime.datetime.now(datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')


def utc_of(timestamp):
    return datetime.datetime.fromtimestamp(timestamp, datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')


def today():
    return datetime.date.today().isoformat()


def valid_date(text):
    return bool(re.match(r'^\d{4}-\d{2}-\d{2}$', text or ''))


def write_bytes(path, data):
    folder = os.path.dirname(path)
    if folder:
        os.makedirs(folder, exist_ok=True)
    with open(path, 'wb') as handle:
        handle.write(data)


def write_text(path, text):
    write_bytes(path, text.encode('utf-8'))
