#!/usr/bin/env python3
"""memory_index.py - derived, rebuildable memory index (engine-kit runtime, layer 2).

Indexes two markdown corpora of a knowledge base into SQLite (+ FTS5 when the
local sqlite3 has it). The markdown is the source of record; the .db is a
throw-away runtime artifact - delete it and rebuild at will:

  <base>/SUBJECT/<NAME>/MEMORY/*.md     episodic logs with claims front matter
  <base>/SUBJECT/<NAME>/KNOWLEDGE/*.md  atomic cards: one reusable rule per file (id K-...)

<base> is any folder under the root: a single knowledge base keeps SUBJECT/ at the
root; a multi-project base keeps one SUBJECT/ per project folder.

Commands:
  build  python memory_index.py build --db <file> [--root <kb-root>] [--projects <file>]
  query  python memory_index.py query --db <file> [--entity X] [--ticket N] [--subject S]
         [--project KEY] [--text "free text"] [--status fact] [--min-confidence 0.8]
         [--claim-type correction] [--unconsolidated] [--cards-only]
  stats  python memory_index.py stats --db <file>

Root: --root, else the KB_ROOT environment variable. The root is the builder's own checkout path: it is
scanned, never stored. The .db holds relative paths ('/' separators) only, so one
artifact is valid for every builder. Keep the .db outside the kit folder.

Project dimension: a document's project is its `project:` front matter when declared;
otherwise it is derived from its path - from the --projects table when given (rows
"| `KEY` | ... | `relative/path` |": first cell the key, last backticked cell the
folder relative to the root), else the folder that holds SUBJECT/ (relative to the
root; empty when SUBJECT/ sits at the root). A declared key that differs from the
--projects table is counted as a mismatch.

VCS provenance on cards is optional: `vcs_revision` (alias `svn_revision`).
A card is superseded when another card lists its id under `supersedes:` or when its
body carries a `**SUPERSEDED**` mark line (`**SUPERSEDED**: none` is not a mark); the
build reports a mark without a link, a link without a mark, a dangling id and a
duplicate id. A claim may carry `type:` (finding | correction | missed | wrong |
collision; finding when absent) and `agent:` (the agent or skill it is about).
Query results list live cards first (the quotable tier), then superseded cards, then
logs.

Python 3.8+, standard library only.
"""

import argparse
import os
import re
import sqlite3
import sys
from datetime import datetime

FLAG_THRESHOLD = 5  # consolidation trigger: unconsolidated logs per project/subject
CLAIM_KEYS = ('status', 'confidence', 'evidence', 'type', 'agent')
CLAIM_KEY_RE = re.compile(r'^\s+(%s):\s*(.+)$' % '|'.join(CLAIM_KEYS))
SUPERSEDED_MARK_RE = re.compile(r'^\*\*SUPERSEDED\*\*(?!:?\s*(?:none|-)\s*$)', re.IGNORECASE)
CARD_ID_RE = re.compile(r'\bK-[0-9A-Za-z][0-9A-Za-z_-]*[0-9A-Za-z]')
KIND_DIRS = {'MEMORY': 'log', 'KNOWLEDGE': 'card'}
DOC_DIR_RE = re.compile(r'^(?:(.*)[\\/])?SUBJECT[\\/]([^\\/]+)[\\/](MEMORY|KNOWLEDGE)$')
SKIP_DIRS = {'.git', '.svn', '.hg', 'node_modules', '__pycache__', '.obsidian', '.trash'}
KIT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# ---------------- front matter parsing ----------------

def _value(raw):
    """Scalar value: quoted text as is, plain text without its trailing ' # comment'."""
    raw = raw.strip()
    if raw[:1] in ('"', "'"):
        end = raw.find(raw[0], 1)
        if end > 0:
            return raw[1:end]
        return raw[1:]
    return re.sub(r'\s+#.*$', '', raw).strip()


def _to_float(text):
    try:
        return float(str(text).replace(',', '.'))
    except ValueError:
        return None


def _text(value):
    if isinstance(value, list):
        return ','.join(value)
    return '' if value is None else str(value)


def _as_list(value):
    if isinstance(value, list):
        return value
    if isinstance(value, str) and value:
        return [value]
    return []


def parse_front_matter(lines):
    """Return a dict (with a 'claims' list) or None when there is no front matter (pre-schema)."""
    if len(lines) < 2 or lines[0].strip() != '---':
        return None
    fm = {'claims': []}
    claim = None
    in_claims = False
    list_key = None
    for line in lines[1:]:
        if line.strip() == '---':
            break
        if in_claims:
            m = re.match(r'^\s+-\s+claim:\s*(.+)$', line)
            if m:
                if claim:
                    fm['claims'].append(claim)
                claim = {'claim': _value(m.group(1)), 'status': '', 'confidence': None, 'evidence': '',
                         'type': '', 'agent': ''}
                continue
            m = CLAIM_KEY_RE.match(line)
            if claim and m:
                key, value = m.group(1), _value(m.group(2))
                claim[key] = _to_float(value) if key == 'confidence' else value
                continue
        elif list_key:
            m = re.match(r'^\s+-\s+(.+)$', line)
            if m:
                fm[list_key].append(_value(m.group(1)))
                continue
        m = re.match(r'^([A-Za-z_][A-Za-z0-9_-]*):\s*(.*)$', line)
        if m:
            if claim:
                fm['claims'].append(claim)
                claim = None
            in_claims, list_key = False, None
            key, value = m.group(1), _value(m.group(2))
            if key == 'claims':
                in_claims = True
                continue
            inline = re.match(r'^\[(.*)\]$', value)
            if inline:
                fm[key] = [_value(x) for x in inline.group(1).split(',') if x.strip()]
            elif value == '':
                fm[key] = []          # a block list ("key:" then "  - item" lines) may follow
                list_key = key
            else:
                fm[key] = value
    if claim:
        fm['claims'].append(claim)
    return fm


def _body_start(lines):
    """Index of the first line after the front matter (0 when there is none)."""
    if lines and lines[0].strip() == '---':
        for i in range(1, len(lines)):
            if lines[i].strip() == '---':
                return i + 1
    return 0


def first_h1(lines):
    # the body's first H1: a full-line '# comment' inside the front matter is not a title
    for line in lines[_body_start(lines):]:
        if line.startswith('# '):
            return line[2:].strip()
    return ''


def superseded_mark(lines):
    """(marked, [card ids named on the mark lines]) from the body's **SUPERSEDED** lines."""
    marked, ids = False, []
    for line in lines[_body_start(lines):]:
        if SUPERSEDED_MARK_RE.match(line.strip()):
            marked = True
            ids += [i for i in CARD_ID_RE.findall(line) if i not in ids]
    return marked, ids


# ---------------- projects ----------------

def load_projects(path):
    """Rows '| `KEY` | ... | `relative/path` |' of a projects table -> [(key, path)]."""
    rows = []
    with open(path, encoding='utf-8', errors='replace') as handle:
        for line in handle:
            if not line.startswith('|'):
                continue
            cells = [c.strip() for c in line.strip().strip('|').split('|')]
            ticked = [c.strip('`') for c in cells if re.match(r'^`[^`]+`$', c)]
            if len(cells) < 2 or not re.match(r'^`[^`]+`$', cells[0]) or len(ticked) < 2:
                continue
            rows.append((ticked[0], ticked[-1].replace('\\', '/').strip('/')))
    return rows


def project_for(projects, rel):
    """Key of the project whose folder contains `rel` (longest prefix wins), or ''."""
    best, best_len = '', -1
    low = rel.lower()
    for key, folder in projects:
        prefix = folder.lower() + '/'
        if low.startswith(prefix) and len(prefix) > best_len:
            best, best_len = key, len(prefix)
    return best


# ---------------- scan ----------------

def scan(root, projects):
    docs = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
        m = DOC_DIR_RE.match(os.path.relpath(dirpath, root))
        if m is None:
            continue
        folder_project = (m.group(1) or '').replace('\\', '/')
        subject_dir, kind = m.group(2), KIND_DIRS[m.group(3)]
        for name in sorted(filenames):
            if not name.lower().endswith('.md'):
                continue
            full = os.path.join(dirpath, name)
            rel = os.path.relpath(full, root).replace('\\', '/')
            with open(full, encoding='utf-8', errors='replace') as handle:
                lines = handle.read().splitlines()
            fm = parse_front_matter(lines)
            if kind == 'card':
                # a card is one rule: its H1 is the claim; status and confidence come from the front matter
                fm = fm or {'claims': []}
                status = _text(fm.get('status')) or 'fact'
                evidence = 'card ' + (_text(fm.get('id')) or '?')
                revision = _text(fm.get('vcs_revision') or fm.get('svn_revision'))
                if revision:
                    evidence += '; rev ' + revision
                if _as_list(fm.get('tickets')):
                    evidence += '; tickets ' + ','.join(_as_list(fm.get('tickets')))
                marked, mark_ids = superseded_mark(lines)
                doc = {'kind': 'card', 'card_id': _text(fm.get('id')),
                       'pre_schema': 0 if fm.get('id') else 1,
                       'consolidated': 1,  # a card IS consolidated knowledge
                       'outcome': status,
                       'supersedes': [s for s in _as_list(fm.get('supersedes')) if s],
                       'marked': marked, 'mark_ids': mark_ids,
                       'claims': [{'claim': first_h1(lines) or name, 'status': status,
                                   'confidence': _to_float(fm['confidence']) if _text(fm.get('confidence')) else None,
                                   'evidence': evidence, 'type': 'finding', 'agent': ''}]}
            elif fm is None:
                doc = {'kind': 'log', 'card_id': '', 'pre_schema': 1, 'consolidated': 0,
                       'outcome': '', 'claims': []}
                fm = {}
            else:
                doc = {'kind': 'log', 'card_id': '',
                       'pre_schema': 0 if fm['claims'] else 1,
                       'consolidated': 1 if _text(fm.get('consolidated')).lower() == 'true' else 0,
                       'outcome': _text(fm.get('outcome')),
                       'claims': fm['claims']}
                for c in doc['claims']:
                    c['type'] = (c.get('type') or 'finding').lower()
            declared = _text(fm.get('project'))
            derived = project_for(projects, rel) if projects else folder_project
            doc.update({
                'path': rel,
                'subject': _text(fm.get('subject')) or subject_dir,
                'version': _text(fm.get('version')),
                'tickets': _as_list(fm.get('tickets')),
                'entities': _as_list(fm.get('entities')),
                'project': declared or derived,
                'project_declared': 1 if declared else 0,
                'project_mismatch': 1 if (projects and declared and derived and declared != derived) else 0,
            })
            docs.append(doc)
    return docs


def resolve_supersession(docs):
    """Set each document's 'superseded_by' (card ids, or '(marked)') and return the notes.

    Two signals: a newer card lists the id under `supersedes:`, or the card's own body
    carries a **SUPERSEDED** mark. Either one supersedes it; a missing half is a note."""
    cards = [d for d in docs if d['kind'] == 'card']
    by_id = {}
    for d in cards:
        if d['card_id']:
            by_id.setdefault(d['card_id'], []).append(d['path'])
    linked = {}
    notes = []
    for d in cards:
        for old in d['supersedes']:
            linked.setdefault(old, [])
            if d['card_id'] and d['card_id'] not in linked[old]:
                linked[old].append(d['card_id'])
            if old not in by_id:
                notes.append("dangling: %s lists %s under supersedes, and no card has that id" % (d['path'], old))
    for card_id, paths in sorted(by_id.items()):
        if len(paths) > 1:
            notes.append("duplicate id %s: %s" % (card_id, ', '.join(paths)))
    for d in docs:
        d['superseded_by'] = ''
        if d['kind'] != 'card':
            continue
        links = linked.get(d['card_id'], []) if d['card_id'] else []
        if links and not d['marked']:
            notes.append("no mark: %s is superseded by %s but has no **SUPERSEDED** line"
                         % (d['path'], ', '.join(links)))
        if d['marked'] and d['card_id'] and not links:
            notes.append("no link: %s is marked SUPERSEDED but no card lists %s under supersedes"
                         % (d['path'], d['card_id']))
        ids = links + [i for i in d['mark_ids'] if i not in links and i != d['card_id']]
        if links or d['marked']:
            d['superseded_by'] = ','.join(ids) or '(marked)'
    return notes


# ---------------- build ----------------

def _inside(path, folder):
    try:
        return os.path.commonpath([os.path.abspath(path), folder]) == folder
    except ValueError:  # different drives
        return False


def cmd_build(args):
    root = args.root or os.environ.get('KB_ROOT')
    if not root:
        return _fail("no root: pass --root or set the KB_ROOT environment variable")
    root = os.path.abspath(root)
    if not os.path.isdir(root):
        return _fail("root folder not found: %s" % root)
    if _inside(args.db, KIT_ROOT):
        return _fail("the index is a case artifact: keep --db outside the kit folder (%s)" % KIT_ROOT)
    projects = []
    if args.projects:
        if not os.path.isfile(args.projects):
            return _fail("projects table not found: %s" % args.projects)
        projects = load_projects(args.projects)

    docs = scan(root, projects)
    supersession_notes = resolve_supersession(docs)
    os.makedirs(os.path.dirname(os.path.abspath(args.db)), exist_ok=True)
    if os.path.exists(args.db):
        os.remove(args.db)  # disposable artifact: full rebuild
    con = sqlite3.connect(args.db)
    cur = con.cursor()
    cur.executescript("""
        CREATE TABLE meta(key TEXT PRIMARY KEY, value TEXT);
        CREATE TABLE logs(id INTEGER PRIMARY KEY, path TEXT UNIQUE, subject TEXT, kind TEXT,
                          card_id TEXT, version TEXT, outcome TEXT, consolidated INT, pre_schema INT,
                          project TEXT, project_declared INT, project_mismatch INT,
                          superseded_by TEXT);
        CREATE TABLE claims(id INTEGER PRIMARY KEY, log_id INT REFERENCES logs(id),
                            claim TEXT, status TEXT, confidence REAL, evidence TEXT,
                            type TEXT, agent TEXT);
        CREATE TABLE entities(log_id INT REFERENCES logs(id), entity TEXT);
        CREATE TABLE tickets(log_id INT REFERENCES logs(id), ticket TEXT);
        CREATE INDEX ix_entities ON entities(entity);
        CREATE INDEX ix_tickets ON tickets(ticket);
        CREATE INDEX ix_claims_log ON claims(log_id);
        CREATE INDEX ix_logs_kind ON logs(kind);
    """)
    fts = True
    try:
        cur.execute("CREATE VIRTUAL TABLE claims_fts USING fts5(claim, evidence, path)")
    except sqlite3.OperationalError:
        fts = False
    for d in docs:
        cur.execute("INSERT INTO logs(path,subject,kind,card_id,version,outcome,consolidated,pre_schema,"
                    "project,project_declared,project_mismatch,superseded_by) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
                    (d['path'], d['subject'], d['kind'], d['card_id'], d['version'], d['outcome'],
                     d['consolidated'], d['pre_schema'], d['project'], d['project_declared'],
                     d['project_mismatch'], d['superseded_by']))
        lid = cur.lastrowid
        for entity in d['entities']:
            cur.execute("INSERT INTO entities VALUES (?,?)", (lid, entity))
        for ticket in d['tickets']:
            cur.execute("INSERT INTO tickets VALUES (?,?)", (lid, str(ticket)))
        for c in d['claims']:
            cur.execute("INSERT INTO claims(log_id,claim,status,confidence,evidence,type,agent)"
                        " VALUES (?,?,?,?,?,?,?)",
                        (lid, c['claim'], c['status'], c['confidence'], c['evidence'],
                         c.get('type') or 'finding', c.get('agent') or ''))
            if fts:
                cur.execute("INSERT INTO claims_fts VALUES (?,?,?)", (c['claim'], c['evidence'], d['path']))
    # the root is deliberately NOT stored: it is the builder's own path, and the
    # artifact must stay builder-independent
    cur.execute("INSERT INTO meta VALUES ('generated',?)", (datetime.now().isoformat(timespec='seconds'),))
    cur.execute("INSERT INTO meta VALUES ('fts',?)", ('1' if fts else '0',))
    cur.execute("INSERT INTO meta VALUES ('projects',?)", ('table' if projects else 'folder',))
    con.commit()
    n_logs = sum(1 for d in docs if d['kind'] == 'log')
    n_cards = len(docs) - n_logs
    print("memory-index built: %d logs, %d cards, %d claims -> %s (fts=%s)"
          % (n_logs, n_cards, sum(len(d['claims']) for d in docs), args.db, 'on' if fts else 'off'))
    _print_stats(cur)
    _print_project_notes(cur)
    _print_card_notes(cur)
    for note in supersession_notes:
        print("    - " + note)
    con.close()
    return 0


# ---------------- stats ----------------

def _print_stats(cur):
    # per project AND subject: the same subject name can exist in several projects
    rows = cur.execute(
        "SELECT project, subject,"
        " SUM(CASE WHEN kind='log' THEN 1 ELSE 0 END),"
        " SUM(CASE WHEN kind='card' THEN 1 ELSE 0 END),"
        " SUM(CASE WHEN kind='log' AND consolidated=0 THEN 1 ELSE 0 END)"
        " FROM logs GROUP BY project, subject ORDER BY project, subject").fetchall()
    for project, subject, n_logs, n_cards, unconsolidated in rows:
        flag = "  << FLAG: consolidate this subject's memory" if (unconsolidated or 0) >= FLAG_THRESHOLD else ""
        print("  %s/%s: %d logs, %d cards, %d unconsolidated%s"
              % (project or '?', subject, n_logs or 0, n_cards or 0, unconsolidated or 0, flag))


def _print_project_notes(cur):
    total, declared, mismatch, none = cur.execute(
        "SELECT COUNT(*), SUM(project_declared), SUM(project_mismatch),"
        " SUM(CASE WHEN project='' OR project IS NULL THEN 1 ELSE 0 END) FROM logs").fetchone()
    print("  project front matter: %d of %d documents declare it (the rest use the path); "
          "%d mismatch the projects table; %d without a project"
          % (declared or 0, total or 0, mismatch or 0, none or 0))


def _has_card_columns(cur):
    """False for an index built before supersession and claim types were stored."""
    logs = [row[1] for row in cur.execute("PRAGMA table_info(logs)")]
    claims = [row[1] for row in cur.execute("PRAGMA table_info(claims)")]
    return 'superseded_by' in logs and 'type' in claims


def _print_card_notes(cur):
    if not _has_card_columns(cur):
        print("  note: this index was built by an older memory_index.py - rebuild it to see "
              "superseded cards and claim types")
        return
    live, superseded = cur.execute(
        "SELECT SUM(CASE WHEN superseded_by='' THEN 1 ELSE 0 END),"
        " SUM(CASE WHEN superseded_by<>'' THEN 1 ELSE 0 END) FROM logs WHERE kind='card'").fetchone()
    typed = cur.execute(
        "SELECT c.type, COUNT(*) FROM claims c JOIN logs l ON l.id=c.log_id"
        " WHERE l.kind='log' AND c.type<>'finding' GROUP BY c.type ORDER BY c.type").fetchall()
    print("  cards: %d live, %d superseded; typed claims in logs: %s"
          % (live or 0, superseded or 0,
             ', '.join('%s %d' % (t, n) for t, n in typed) if typed else 'none'))


def _open(db):
    if not os.path.isfile(db):
        return None
    return sqlite3.connect(db)


def cmd_stats(args):
    con = _open(args.db)
    if con is None:
        return _fail("index not found: %s (run build first)" % args.db)
    cur = con.cursor()
    generated = cur.execute("SELECT value FROM meta WHERE key='generated'").fetchone()
    print("generated: %s" % (generated[0] if generated else '?'))
    _print_stats(cur)
    _print_project_notes(cur)
    _print_card_notes(cur)
    con.close()
    return 0


# ---------------- query ----------------

def _find(cur, args, use_fts, card_columns=True):
    superseded = "l.superseded_by" if card_columns else "''"
    sql = ("SELECT DISTINCT l.id, l.path, l.subject || ' @' || COALESCE(NULLIF(l.project, ''), '?'),"
           " l.consolidated, l.kind, l.card_id, " + superseded + " FROM logs l"
           " LEFT JOIN entities e ON e.log_id=l.id"
           " LEFT JOIN tickets t ON t.log_id=l.id"
           " LEFT JOIN claims c ON c.log_id=l.id WHERE 1=1")
    params = []
    if args.subject:
        sql += " AND l.subject = ?"
        params.append(args.subject)
    if args.project:
        sql += " AND l.project = ?"
        params.append(args.project)
    if args.ticket:
        sql += " AND t.ticket = ?"
        params.append(str(args.ticket))
    if args.entity:
        sql += " AND (e.entity LIKE ? OR c.claim LIKE ?)"
        params += ["%" + args.entity + "%"] * 2
    if args.unconsolidated:
        sql += " AND l.consolidated = 0"
    if args.cards_only:
        sql += " AND l.kind = 'card'"
    if args.claim_type:
        sql += " AND c.type = ?"
        params.append(args.claim_type.lower())
    if args.text:
        if use_fts:
            sql += " AND l.path IN (SELECT path FROM claims_fts WHERE claims_fts MATCH ?)"
            params.append(args.text)
        else:
            sql += " AND c.claim LIKE ?"
            params.append("%" + args.text + "%")
    # live cards first (the quotable tier), then superseded cards, then logs by path
    sql += (" ORDER BY CASE WHEN l.kind = 'card' AND " + superseded + " = '' THEN 0"
            " WHEN l.kind = 'card' THEN 1 ELSE 2 END, l.path")
    return cur.execute(sql, params).fetchall()


def cmd_query(args):
    con = _open(args.db)
    if con is None:
        return _fail("index not found: %s (run build first)" % args.db)
    cur = con.cursor()
    fts_on = (cur.execute("SELECT value FROM meta WHERE key='fts'").fetchone() or ['0'])[0] == '1'
    card_columns = _has_card_columns(cur)
    if args.claim_type and not card_columns:
        con.close()
        return _fail("this index was built by an older memory_index.py and holds no claim types: run build again")
    try:
        hits = _find(cur, args, fts_on, card_columns)
    except sqlite3.OperationalError as exc:
        if not (fts_on and args.text):
            raise
        print("note: full-text syntax rejected (%s); falling back to a plain substring match" % exc)
        fts_on = False
        hits = _find(cur, args, False, card_columns)

    for lid, path, subject, consolidated, kind, card_id, superseded_by in hits:
        if kind == 'card' and superseded_by:
            by = '' if superseded_by == '(marked)' else ' by ' + superseded_by
            print("\n== CARD %s  %s  [%s]  SUPERSEDED%s" % (card_id, path, subject, by))
        elif kind == 'card':
            print("\n== CARD %s  %s  [%s]" % (card_id, path, subject))
        else:
            print("\n== %s  [%s] [%s]" % (path, subject, "consolidated" if consolidated else "UNCONSOLIDATED"))
        if card_columns:
            csql = "SELECT status, confidence, claim, type, agent FROM claims WHERE log_id=?"
        else:
            csql = "SELECT status, confidence, claim, 'finding', '' FROM claims WHERE log_id=?"
        cparams = [lid]
        if args.claim_type:
            csql += " AND type = ?"
            cparams.append(args.claim_type.lower())
        if args.min_confidence is not None:
            csql += " AND confidence >= ?"
            cparams.append(args.min_confidence)
        if args.status:
            csql += " AND status = ?"
            cparams.append(args.status)
        if args.entity and kind != 'card':
            csql += " AND claim LIKE ?"
            cparams.append("%" + args.entity + "%")
        if args.text and not fts_on:
            csql += " AND claim LIKE ?"
            cparams.append("%" + args.text + "%")
        for status, confidence, claim, claim_type, agent in cur.execute(csql, cparams):
            tag = ''
            if claim_type and claim_type != 'finding':
                tag = '[%s%s] ' % (claim_type, (' ' + agent) if agent else '')
            print("   - (%s %s) %s%s" % (status, confidence, tag, claim))
    n_cards = sum(1 for h in hits if h[4] == 'card')
    print("\n%d hit(s): %d card(s), %d log(s)." % (len(hits), n_cards, len(hits) - n_cards))
    con.close()
    return 0


# ---------------- main ----------------

def _fail(message):
    print("error: " + message, file=sys.stderr)
    return 2


def main(argv=None):
    for stream in (sys.stdout, sys.stderr):
        try:
            stream.reconfigure(errors='replace')  # claims may hold characters the console cannot show
        except AttributeError:
            pass
    ap = argparse.ArgumentParser(description="Derived memory index (source of record: markdown logs and cards)")
    sub = ap.add_subparsers(dest='cmd')
    sub.required = True
    b = sub.add_parser('build', help='rebuild the index from the markdown')
    b.add_argument('--root', dest='root',
                   help='knowledge base root (default: $KB_ROOT; never stored in the index)')
    b.add_argument('--db', required=True, help='index file to (re)create, outside the kit folder')
    b.add_argument('--projects', help="optional projects table ('| `KEY` | ... | `relative/path` |' rows)")
    b.set_defaults(fn=cmd_build)
    s = sub.add_parser('stats', help='logs, cards and unconsolidated logs per project/subject')
    s.add_argument('--db', required=True)
    s.set_defaults(fn=cmd_stats)
    q = sub.add_parser('query', help='before-action retrieval')
    q.add_argument('--db', required=True)
    q.add_argument('--entity', help='entity name or claim substring')
    q.add_argument('--ticket')
    q.add_argument('--subject')
    q.add_argument('--project')
    q.add_argument('--text', help='full-text search on claims (FTS5 syntax when available)')
    q.add_argument('--status', help='claim status, e.g. fact | inference | hypothesis')
    q.add_argument('--min-confidence', type=float)
    q.add_argument('--claim-type', help='claim type, e.g. correction | missed | wrong | collision | finding')
    q.add_argument('--unconsolidated', action='store_true')
    q.add_argument('--cards-only', action='store_true')
    q.set_defaults(fn=cmd_query)
    args = ap.parse_args(argv)
    return args.fn(args)


if __name__ == '__main__':
    sys.exit(main())
