#!/usr/bin/env python3
"""decisions_index.py - per-project decision registers and their generated index (engine-kit runtime, T22).

Every decision has a qualified id KEY#N: the namespace KEY is a row of the projects
registry (a project, or the workspace row whose register is the root register) and N
its number in that namespace's home register. A front that keeps its own register is a
row too. A decision lives in exactly one home register; its "Applies to" column lists
the other keys it binds. Numbers are permanent: never renumbered, never reused (kit
decision EK#4). The front-prefixed form D-KEYN is an alias of KEY#N.

Commands:
  python decisions_index.py [--root <kb-root>] [--out FILE] [--dry-run]
      read every register, check it and (re)write the generated cross-project index.
      Exit 1 on a duplicate number in a register, a row without an ISO date or an
      unknown key in "Applies to". Numbers missing from a register are listed as
      information only.
  python decisions_index.py --init KEY [--template FILE]
      create KEY's register from templates/DECISIONS.template.md (never overwrites).
  python decisions_index.py --check-touched [--vcs auto|git|svn]
      decision citations of the added/modified/unversioned markdown files: a cited
      KEY#N must exist in KEY's register (failure; a warning while KEY has no register
      yet). The front-prefixed alias D-KEYN is the same id as KEY#N and is checked the
      same way, for registered keys that do not end in a digit (D-ACME-2.17 would be
      ambiguous: write ACME-2.1#7). Q-KEYN (a question) and A-KEYN (an assumption) are
      not decisions and are never checked. A bare "decision N" in a project document
      must be in that project's register, "decision N (TAG)" in the register of the only
      key whose first segment is TAG (warnings); the plural "decisions N" is a count
      (a copied tool summary such as "decisions 17, 0 problems") and is not read.
      Root-level documents are not checked for bare numbers. A "next free ids" item (the resume block) names ids that do
      not exist yet and is never read: from a "Next free ids" label (at the start of a
      line, any case, after quote and list markers and bold; or mid-line, with a colon)
      to the end of its sentence - wrapped lines included - plus a "Reserved:" sentence
      right after it; inside a code span or a table cell the item also ends where the
      span or the cell does. The rest of that line is read like any other text.

Registers: decision_register for a project (default "{path}/_REGISTRY/DECISIONS.md")
and root_register for the workspace row (default "DECISIONS.md"), both configured in
the front matter of the projects registry (see projects_check.py) or with --register /
--root-register. A register is a markdown file whose decision tables have a header
starting with "#"; columns are found by name: "#", "Date", "Decision", "Applies to".
The title of a decision is its first **bold** text, else its first sentence.

Root: --root, else KB_ROOT.
Exit: 0 clean, 1 problems, 2 usage, configuration or VCS error.
Python 3.8+, standard library only.
"""

import argparse
import os
import re
import sys
from datetime import datetime

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import projects_check as pc  # noqa: E402  (sibling module: registry, front matter, VCS)
import vcs  # noqa: E402

DATE = re.compile(r'^\d{4}-\d{2}-\d{2}')
SEPARATOR = re.compile(r'^:?-{3,}:?$')
# A bare citation is the singular "decision N": the plural "decisions N" is a count (a tool
# summary copied into a document, "decisions 17, 0 problems"), never read as a citation.
BARE = re.compile(r'(?i)(?<![\w#-])decision\s+(\d+)\b(?:\s*\(([A-Za-z0-9.-]+)\))?')
SKIP_DIRS = {'_registry', '_index', '_archive', 'attachments', 'evidence'}
# "Next free ids" (the resume block, T30) lists ids that do not exist yet: never citations.
FREE_IDS_START = re.compile(r'(?i)^[\s>]*(?:(?:[-*+]|\d+[.)])\s+)?(?:\*\*|__)?\s*next\s+free\s+ids(?![a-z0-9])')
FREE_IDS_LABEL = re.compile(r'(?i)(?<![a-z0-9])next\s+free\s+ids\s*(?:\*\*|__)?\s*:')
NEW_BLOCK = re.compile(r'^[\s>]*(?:$|[-*+]\s|\d+[.)]\s|#|\||(?:\*\*|__)[^*_]+(?:\*\*|__)\s*:)')
SENTENCE_STOP = re.compile(r'[.!?][\'")\]*_`]*(?=\s|$)')  # a sentence ends: ". " or "." at the end
RESERVED = re.compile(r'(?i)\s*(?:\*\*|__)?\s*reserved\s*(?:\*\*|__)?\s*:')  # the item's second sentence
TEMPLATE = os.path.join(pc.TEMPLATES, 'DECISIONS.template.md')
TEMPLATE_NOTE = '> Template from the engine-kit'


# ---------------- registers ----------------

def plain(text):
    t = re.sub(r'`([^`]*)`', r'\1', text)
    t = t.replace('**', '').replace('\\|', '/')
    return re.sub(r'\s+', ' ', t).strip()


def title_of(decision):
    m = re.search(r'\*\*(.+?)\*\*', decision)
    t = plain(m.group(1) if m else decision.split('. ')[0])
    return (t[:137] + '...') if len(t) > 140 else t


def parse_register(path):
    """Rows of every decision table: [{n, date, title, applies, line}].

    A decision table starts at a header whose first cell is '#' and ends at the header
    of another table; blank lines and prose between rows do not end it (registers in
    use split their rows that way)."""
    rows, cols, previous, in_fence = [], None, None, False
    for number, line in enumerate(pc.read_lines(path), 1):
        if line.lstrip().startswith('```'):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        if not line.startswith('|'):
            previous = None
            continue
        cells = [c.strip() for c in pc.CELL_SPLIT.split(line.strip().strip('|'))]
        if cells and SEPARATOR.match(cells[0]):
            if previous and previous[0] != '#':
                cols = None  # the header of another kind of table
            continue
        previous = cells
        if cells and cells[0] == '#':
            cols = [c.lower() for c in cells]
            continue
        if cols is None or not cells or not re.match(r'^\d+$', cells[0]):
            continue

        def get(name):
            return cells[cols.index(name)] if name in cols and cols.index(name) < len(cells) else ''
        rows.append({'n': int(cells[0]), 'date': get('date'), 'title': title_of(get('decision')),
                     'applies': get('applies to'), 'line': number})
    return rows


def applies_keys(cell):
    return [x.strip('` ') for x in re.split(r'[,;]', cell) if x.strip('` -')]


def compress(nums):
    """[28, 29, 30, 35] -> '28-30, 35'."""
    out, i = [], 0
    while i < len(nums):
        j = i
        while j + 1 < len(nums) and nums[j + 1] == nums[j] + 1:
            j += 1
        out.append(str(nums[i]) if i == j else '%d-%d' % (nums[i], nums[j]))
        i = j + 1
    return ', '.join(out)


def load_registers(reg):
    """[(project row, register path, rows)] of the registers that exist."""
    out = []
    for pr in reg.projects:
        path = reg.decision_register(pr)
        if os.path.isfile(path):
            out.append((pr, path, parse_register(path)))
    return out


# ---------------- index ----------------

def build_index(reg, registers):
    """(index text, per-register counts, problems)."""
    problems, out_rows, counts = [], [], []
    for pr, path, rows in registers:
        seen = {}
        for r in rows:
            if r['n'] in seen:
                problems.append('%s: number %d appears twice (lines %d and %d)' % (pr['key'], r['n'], seen[r['n']], r['line']))
            else:
                seen[r['n']] = r['line']
            if not DATE.match(r['date']):
                problems.append('%s#%d: no ISO date (line %d)' % (pr['key'], r['n'], r['line']))
            for key in applies_keys(r['applies']):
                if key not in reg.by_key:
                    problems.append("%s#%d: unknown project key '%s' in Applies to" % (pr['key'], r['n'], key))
            out_rows.append((pr['key'], r))
        nums = sorted(seen)
        gaps = [i for i in range(1, nums[-1] + 1) if i not in seen] if nums else []
        counts.append((pr['key'], len(rows), reg.rel(path) or path, compress(gaps)))

    now = datetime.now().strftime('%Y-%m-%d %H:%M')
    lines = ['---', 'last_updated: %s' % now[:10], 'generated_by: decisions_index.py',
             'tags:', '  - registry', '  - decisions', '---',
             '# Decisions Index - every project', '',
             '**Scope**: %s' % reg.config['scope_value'], '',
             '> **GENERATED FILE - do not edit.** Rebuilt by `decisions_index.py` from the decision registers '
             'of the projects registry (the root register of the workspace row and one register per project). '
             'A decision lives in exactly one home register; cite it as `KEY#N`.',
             '> Generated %s.' % now, '',
             '| Project | Decisions | Register | Numbers not in the register (informational) |',
             '|---|---|---|---|']
    for key, n, home, gaps in counts:
        lines.append('| `%s` | %d | `%s` | %s |' % (key, n, home, gaps or '-'))
    lines += ['', '| ID | Date | Decision | Applies to |', '|---|---|---|---|']
    for key, r in out_rows:
        lines.append('| `%s#%d` | %s | %s | %s |' % (key, r['n'], r['date'][:10], r['title'], r['applies'] or '-'))
    return '\n'.join(lines) + '\n', counts, problems


def run_index(reg, args):
    target = reg.output('decisions_index', 'DECISIONS-INDEX.md')
    if pc.inside_kit(target):
        return pc.fail('the index is a case file: keep it outside the kit folder (%s)' % target)
    registers = load_registers(reg)
    text, counts, problems = build_index(reg, registers)
    if not args.dry_run:
        pc.write_text(target, text)
    for key, n, home, gaps in counts:
        print('  %-16s %3d decisions   %s%s' % (key, n, home, ('   (numbers not registered: %s)' % gaps) if gaps else ''))
    for p in problems:
        print('FIX  ', p)
    print('decisions index: %d decisions in %d register(s) -> %s%s - problems: %d'
          % (sum(c[1] for c in counts), len(counts), reg.rel(target) or target,
             ' (dry run)' if args.dry_run else '', len(problems)))
    return 1 if problems else 0


# ---------------- citations of touched documents ----------------

def citation_regex(keys):
    """KEY#N for the registered keys only (longest key first, so CORE-2#1 is not read as CORE#...)."""
    alternatives = '|'.join(re.escape(k) for k in sorted(keys, key=len, reverse=True))
    return re.compile(r'(?<![\w#-])(' + alternatives + r')#(\d+)\b')


def alias_regex(keys):
    """D-KEYN, the front-prefixed alias of KEY#N, for the registered keys that do not end in a
    digit (in D-ACME-2.17 the key and the number cannot be told apart). Only the D- prefix is a
    decision: Q-KEYN is a question and A-KEYN an assumption, so neither is matched."""
    usable = [k for k in keys if k and not k[-1].isdigit()]
    if not usable:
        return None
    alternatives = '|'.join(re.escape(k) for k in sorted(usable, key=len, reverse=True))
    return re.compile(r'(?<![\w#-])D-(' + alternatives + r')(\d+)\b')


def citations(text, qualified, alias):
    """[(key, number, label)] of the KEY#N and D-KEYN citations in text, in order of appearance."""
    found = []
    for m in qualified.finditer(text) if qualified else ():
        found.append((m.start(), m.group(1), int(m.group(2)), '%s#%s' % (m.group(1), m.group(2))))
    for m in alias.finditer(text) if alias else ():
        found.append((m.start(), m.group(1), int(m.group(2)), '%s (= %s#%s)' % (m.group(0), m.group(1), m.group(2))))
    return [(key, n, label) for _, key, n, label in sorted(found)]


def _item_end(line, pos, limit):
    """Where the "next free ids" item that runs from pos ends in line: (end, done). The item is
    one sentence, plus a "Reserved:" sentence right after it; it never passes limit (the end of
    the code span or table cell that holds the label). done is False when the sentence runs
    on to the next line (a wrapped item)."""
    while True:
        m = SENTENCE_STOP.search(line, pos, limit)
        if not m:
            return (limit, True) if limit < len(line) else (len(line), False)
        r = RESERVED.match(line, m.end(), limit)
        if not r:
            return m.end(), True
        pos = r.end()


def _container_end(line, at):
    """The end of the code span or the table cell that holds position at, else len(line)."""
    limit = len(line)
    if line[:at].count('`') % 2:  # inside a code span: it ends at the next backtick
        k = line.find('`', at)
        if k >= 0:
            limit = k
    if line.lstrip().startswith('|'):  # a table row: the cell ends at the next unescaped pipe
        m = re.compile(r'(?<!\\)\|').search(line, at)
        if m:
            limit = min(limit, m.start())
    return limit


def without_free_ids(lines):
    """The lines to read for citations, with every "next free ids" item blanked: from the
    label (at the start of a line, after quote and list markers and bold - the whole start
    blanked; or mid-line with a colon) to the end of its sentence, plus a "Reserved:"
    sentence right after it; inside a code span or a table cell, the item also ends where the
    span or the cell does. The rest of the line is kept and read. A wrapped item continues on
    the next lines until its sentence ends, a blank line, or a new block (list item, heading,
    table row, bold label)."""
    out, carry = [], False
    for line in lines:
        if carry and NEW_BLOCK.match(line):
            carry = False
        kept, pos = [], 0
        if carry:
            pos, done = _item_end(line, 0, len(line))
            carry = not done
        while not carry:
            m = FREE_IDS_START.match(line) if pos == 0 else None
            if m:
                start, after = 0, m.end()
            else:
                m = FREE_IDS_LABEL.search(line, pos)
                if not m:
                    kept.append(line[pos:])
                    break
                start, after = m.start(), m.end()
            kept.append(line[pos:start])
            pos, done = _item_end(line, after, _container_end(line, m.start()))
            carry = not done
        out.append(' '.join(k for k in kept if k))
    return out


def check_touched(reg, entries):
    """Decision citations of the touched markdown files: (warnings, failures)."""
    nums = {}
    skip_files = set()
    for pr in reg.projects:
        path = reg.decision_register(pr)
        skip_files.add(os.path.normcase(path))
        nums[pr['key']] = {r['n'] for r in parse_register(path)} if os.path.isfile(path) else set()
    skip_files.add(os.path.normcase(reg.output('decisions_index', 'DECISIONS-INDEX.md')))
    skip_names = {os.path.basename(reg.config['ledger']).lower(),
                  os.path.basename(reg.output('ledger_all', 'LEDGER-ALL.md')).lower()}
    short = {}
    for key in reg.by_key:
        short.setdefault(key.split('-')[0].upper(), []).append(key)
    qualified = citation_regex(reg.by_key) if reg.by_key else None
    alias = alias_regex(reg.by_key)
    ws = reg.workspace
    warns, fails = [], []
    for status, full in entries:
        rel = reg.rel(full)
        if status == 'D' or rel is None or not rel.lower().endswith('.md'):
            continue
        if os.path.normcase(full) in skip_files or os.path.basename(rel).lower() in skip_names \
                or any(p in SKIP_DIRS for p in rel.lower().split('/')[:-1]):
            continue
        home = reg.key_for_relpath(rel)  # '' for root-level documents
        try:
            text = '\n'.join(without_free_ids(pc.read_lines(full)))
        except OSError:
            continue
        for key, n, label in citations(text, qualified, alias):
            if n in nums[key]:
                continue
            if nums[key]:
                fails.append('%s is not in the register of %s: %s' % (label, key, rel))
            else:
                warns.append('%s: %s has no register or no decision yet: %s' % (label, key, rel))
        if not home:
            continue  # a bare "decision N" in a root-level document means the workspace register
        for m in BARE.finditer(text):
            n, tag = int(m.group(1)), (m.group(2) or '').upper()
            if tag in short and len(short[tag]) == 1:
                target = short[tag][0]
                if n not in nums[target]:
                    warns.append('"decision %d (%s)" is not in the register of %s: %s' % (n, tag, target, rel))
            elif not tag or tag not in short:
                if n in nums.get(home, set()):
                    continue
                if ws and n in nums.get(ws, set()):
                    warns.append('bare "decision %d" is not in the register of %s (found: %s#%d); write %s#%d: %s'
                                 % (n, home, ws, n, ws, n, rel))
                else:
                    warns.append('bare "decision %d" is not in the register of %s%s; write the qualified id: %s'
                                 % (n, home, (' nor in %s' % ws) if ws else '', rel))
    return list(dict.fromkeys(warns)), list(dict.fromkeys(fails))


def run_check_touched(reg, args):
    kind, entries = pc.changed(reg, args, md_only=True)
    warns, fails = check_touched(reg, entries)
    for w in warns[:25]:
        print('WARN ', w)
    if len(warns) > 25:
        print('WARN  ... %d more' % (len(warns) - 25))
    for f in fails:
        print('FIX  ', f)
    print('decision citations (%s): %d touched document(s), %d warning(s), %d failure(s)'
          % (kind, len(entries), len(warns), len(fails)))
    return 1 if fails else 0


# ---------------- init ----------------

def fill_template(text, pr, scope):
    out, skipping = [], False
    for line in text.splitlines():
        if line.startswith(TEMPLATE_NOTE):
            skipping = True
        if skipping:
            if line.startswith('>'):
                continue
            skipping = False
            if not line.strip():
                continue  # drop the blank line after the note too
        out.append(line)
    text = '\n'.join(out) + '\n'
    text = re.sub(r'\*\*Scope\*\*: <[^>]*>', '**Scope**: ' + scope, text)
    return (text.replace('<KEY>', pr['key'])
                .replace('<SHORT>', pr['key'].split('-')[0])
                .replace('<PROJECT-NAME>', pr['name'] or pr['key'])
                .replace('<YYYY-MM-DD>', datetime.now().strftime('%Y-%m-%d')))


def run_init(reg, args):
    pr = reg.by_key.get(args.init)
    if pr is None:
        print("unknown key '%s' (not a row of %s)" % (args.init, reg.path))
        return 2
    target = reg.decision_register(pr)
    if os.path.exists(target):
        print('register already exists:', target)
        return 1
    if pc.inside_kit(target):
        return pc.fail('a register is a case file: keep it outside the kit folder (%s)' % target)
    template = args.template or TEMPLATE
    if not os.path.isfile(template):
        return pc.fail('register template not found: %s' % template)
    pc.write_text(target, fill_template('\n'.join(pc.read_lines(template)), pr, reg.config['scope_value']))
    print('created', target)
    return 0


# ---------------- main ----------------

def main(argv=None):
    pc.reconfigure_streams()
    ap = argparse.ArgumentParser(description='Per-project decision registers -> generated cross-project index; '
                                             'citation check; register skeleton')
    pc.add_common_args(ap)
    ap.add_argument('--out', help='generated index (default: front matter decisions_index, '
                                  'else DECISIONS-INDEX.md next to the projects registry)')
    ap.add_argument('--register', help='register pattern of a project, KB-root relative ({path}, {key}); '
                                       'default: front matter decision_register')
    ap.add_argument('--root-register', help='register of the workspace row, KB-root relative '
                                            '(default: front matter root_register)')
    ap.add_argument('--dry-run', action='store_true', help='check and report, write nothing')
    ap.add_argument('--init', metavar='KEY', help="create KEY's register from the template (never overwrites)")
    ap.add_argument('--template', help='register template for --init (default: the kit\'s DECISIONS.template.md)')
    ap.add_argument('--check-touched', action='store_true',
                    help='check the decision citations (KEY#N, and the alias D-KEYN) of the '
                         'added/modified/unversioned markdown files')
    args = ap.parse_args(argv)
    try:
        reg = pc.registry_from_args(args, decision_register=args.register, root_register=args.root_register,
                                    decisions_index=os.path.abspath(args.out) if args.out else None)
    except pc.RegistryError as exc:
        return pc.fail(str(exc))
    if not reg.projects:
        print('the projects registry has no project rows: %s' % reg.path)
        return 1
    try:
        if args.check_touched:
            return run_check_touched(reg, args)
    except vcs.VcsError as exc:
        return pc.fail(str(exc))
    if args.init:
        return run_init(reg, args)
    return run_index(reg, args)


if __name__ == '__main__':
    sys.exit(main())
