# -*- coding: latin-1 -*-
"""Scan .pas/.dfm for duplicate SQL SELECT fields (bare name collisions)."""
import re
import os
import json
from pathlib import Path
from collections import defaultdict

root = Path(r'd:\Gestao2016')
exts = {'.pas', '.dfm'}
skip_dirs = {'__history', '.svn', 'node_modules', '.git', '.cursor'}

IDENT = r'[A-Z][A-Z0-9_]*'
FIELD_TOKEN = re.compile(rf'\b({IDENT})(?:\.({IDENT}))?\b', re.IGNORECASE)


def unquote_line(line):
    line = line.strip()
    if not line:
        return ''
    if line[0] in ("'", '"'):
        if line.endswith("',"):
            return line[1:-2]
        if line.endswith('",'):
            return line[1:-2]
        if line.endswith(line[0]):
            return line[1:-1]
        return line[1:]
    return line


def concat_pascal_strings(text):
    """Merge adjacent Pascal string literals (+ optional whitespace)."""
    pattern = re.compile(
        r"'((?:[^']|'')*)'(?:\s*\+\s*'((?:[^']|'')*)')+",
        re.IGNORECASE | re.DOTALL,
    )

    def repl(m):
        full = m.group(0)
        parts = re.findall(r"'((?:[^']|'')*)'", full)
        return "'" + ''.join(p.replace("''", "'") for p in parts) + "'"

    return pattern.sub(repl, text)


def extract_sql_blocks(text):
    blocks = []
    text2 = concat_pascal_strings(text)

    for m in re.finditer(
        r"SQL\.Strings\s*=\s*\(\s*(.*?)\s*\)\s*(?:Left|Top|ParamData|end)",
        text2,
        re.DOTALL | re.IGNORECASE,
    ):
        raw = m.group(1)
        parts = []
        for line in raw.split('\n'):
            line = line.strip()
            if not line:
                continue
            if line.endswith("' +") or line.endswith('" +'):
                parts.append(unquote_line(line[:-2].strip()))
            else:
                parts.append(unquote_line(line))
        blocks.append(('SQL.Strings', ' '.join(parts)))

    for m in re.finditer(r"'([^']*SELECT[^']*)'", text2, re.IGNORECASE):
        blocks.append(('string', m.group(1)))

    for m in re.finditer(
        r"SQL\.Add\s*\(\s*concat\s*\((.*?)\)\s*\)",
        text2,
        re.DOTALL | re.IGNORECASE,
    ):
        inner = m.group(1)
        parts = re.findall(r"'((?:[^']|'')*)'", inner, re.DOTALL)
        if parts:
            sql = ''.join(p.replace("''", "'") for p in parts)
            if 'SELECT' in sql.upper():
                blocks.append(('SQL.Add.concat', sql))

    for m in re.finditer(r"SQL\.add\s*\(\s*'([^']*)'\s*\)", text2, re.IGNORECASE):
        s = m.group(1)
        if 'SELECT' in s.upper() or (blocks and 'SELECT' in blocks[-1][1].upper()):
            pass  # handled by accumulation below

  # sqltxt := 'SELECT ...' + '...'
    for m in re.finditer(
        r"(?:sqltxt|SqlTxt|Lc_SqlTxt|Lc_sqltxt|SQL)\s*:=\s*'([^']*(?:SELECT)[^']*)'",
        text2,
        re.IGNORECASE,
    ):
        blocks.append(('sqltxt', m.group(1)))

    return blocks


def get_select_clause(sql):
    sql_norm = re.sub(r'\s+', ' ', sql)
    m = re.search(
        r'\bSELECT\s+(?:DISTINCT\s+|ALL\s+)?(.+?)\s+FROM\b',
        sql_norm,
        re.IGNORECASE,
    )
    return m.group(1) if m else None


def split_select_parts(select_clause):
    parts = []
    depth = 0
    cur = []
    for ch in select_clause:
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        elif ch == ',' and depth == 0:
            parts.append(''.join(cur).strip())
            cur = []
            continue
        cur.append(ch)
    if cur:
        parts.append(''.join(cur).strip())
    return parts


SQL_KEYWORDS = {
    'SELECT', 'FROM', 'WHERE', 'JOIN', 'INNER', 'LEFT', 'RIGHT', 'OUTER',
    'ON', 'AND', 'OR', 'NOT', 'NULL', 'AS', 'DISTINCT', 'ALL', 'GROUP',
    'BY', 'ORDER', 'HAVING', 'UNION', 'CASE', 'WHEN', 'THEN', 'ELSE', 'END',
    'SUM', 'COUNT', 'AVG', 'MIN', 'MAX', 'COALESCE', 'CAST', 'SUBSTRING',
    'UPPER', 'LOWER', 'TRIM', 'EXTRACT', 'BETWEEN', 'IN', 'IS', 'LIKE',
    'TB', 'TRUE', 'FALSE',
}


def parse_select_item(part):
    part = part.strip()
    if not part:
        return None
    part_up = part.upper()

    as_m = re.search(r'\s+AS\s+(' + IDENT + r')\s*$', part_up)
    if as_m:
        alias = as_m.group(1)
        expr = part[: len(part) - (len(part_up) - as_m.start())].strip()
        return {
            'raw': part,
            'expr': expr,
            'result_name': alias,
            'explicit_alias': True,
        }

    # implicit alias: last identifier after closing paren or space
    # e.g. SUM(x) TOTAL, (a*b) VL, table.col
    implicit = re.search(r'\)\s+(' + IDENT + r')\s*$', part_up)
    if implicit:
        return {
            'raw': part,
            'expr': part,
            'result_name': implicit.group(1),
            'explicit_alias': True,
        }

    # bare table.column or column
    dot_m = re.search(r'(?:^|\s)(' + IDENT + r')\.(' + IDENT + r')\s*$', part_up)
    if dot_m:
        return {
            'raw': part,
            'expr': part,
            'result_name': dot_m.group(2),
            'explicit_alias': False,
            'table': dot_m.group(1),
        }

  # bare column
    bare = re.search(r'(?:^|\s)(' + IDENT + r')\s*$', part_up)
    if bare and bare.group(1) not in SQL_KEYWORDS:
        return {
            'raw': part,
            'expr': part,
            'result_name': bare.group(1),
            'explicit_alias': False,
        }

    # expression with trailing alias without AS: (expr) NAME handled above
    # fallback: last identifier token
    tokens = [t for t in FIELD_TOKEN.findall(part_up) if t[1] or t[0] not in SQL_KEYWORDS]
    if tokens:
        col = tokens[-1][1] or tokens[-1][0]
        return {
            'raw': part,
            'expr': part,
            'result_name': col,
            'explicit_alias': len(tokens) > 1,
        }
    return None


def analyze_sql(sql, filepath, block_type):
    issues = []
    sel = get_select_clause(sql)
    if not sel:
        return issues

    items = []
    for part in split_select_parts(sel):
        parsed = parse_select_item(part)
        if parsed:
            items.append(parsed)

    by_name = defaultdict(list)
    for it in items:
        by_name[it['result_name']].append(it)

    for name, occs in by_name.items():
        if len(occs) > 1:
            unaliased = [o for o in occs if not o['explicit_alias']]
            issues.append({
                'file': filepath,
                'block_type': block_type,
                'issue': 'duplicate_result_name',
                'field': name,
                'count': len(occs),
                'entries': [o['raw'] for o in occs],
                'remove_candidates': [o['raw'] for o in unaliased[1:]] if unaliased else [],
                'fireDAC_suffix': name + '1' if len(occs) == 2 else None,
            })

    # base + base1 pair (FireDAC auto-suffix)
    names = set(by_name.keys())
    for name in names:
        suff = name + '1'
        if suff in names:
            base_unaliased = [o for o in by_name[name] if not o['explicit_alias']]
            issues.append({
                'file': filepath,
                'block_type': block_type,
                'issue': 'base_and_suffix1',
                'base': name,
                'suffix': suff,
                'base_entries': [o['raw'] for o in by_name[name]],
                'suffix_entries': [o['raw'] for o in by_name[suff]],
                'remove_candidates': [o['raw'] for o in base_unaliased],
            })

    return issues


def analyze_file(path):
    try:
        text = path.read_text(encoding='latin-1', errors='replace')
    except OSError:
        return []
    rel = str(path.relative_to(root)).replace('\\', '/')
    issues = []
    for btype, sql in extract_sql_blocks(text):
        issues.extend(analyze_sql(sql, rel, btype))
    return issues


def main():
    all_issues = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in skip_dirs]
        for fn in filenames:
            if Path(fn).suffix.lower() in exts:
                all_issues.extend(analyze_file(Path(dirpath) / fn))

    seen = set()
    unique = []
    for iss in all_issues:
        key = json.dumps(iss, sort_keys=True)
        if key not in seen:
            seen.add(key)
            unique.append(iss)

    out_path = root / '_sql_dupes_report.json'
    out_path.write_text(json.dumps(unique, indent=2, ensure_ascii=False), encoding='utf-8')

    dups = [i for i in unique if i['issue'] == 'duplicate_result_name']
    b1 = [i for i in unique if i['issue'] == 'base_and_suffix1']

    print(f'Total unique issues: {len(unique)}')
    print(f'  duplicate result names: {len(dups)}')
    print(f'  base+suffix1 in SQL: {len(b1)}')
    print(f'Report: {out_path}')
    print()

    for iss in dups:
        print(f"FILE: {iss['file']} [{iss['block_type']}]")
        print(f"  FIELD: {iss['field']} x{iss['count']}")
        print(f"  entries: {iss['entries']}")
        if iss['remove_candidates']:
            print(f"  REMOVE (sem alias, manter 1a): {iss['remove_candidates']}")
        if iss.get('fireDAC_suffix'):
            print(f"  FireDAC geraria: {iss['field']} + {iss['fireDAC_suffix']}")
        print()

    for iss in b1:
        print(f"FILE: {iss['file']} [{iss['block_type']}]")
        print(f"  {iss['base']} + {iss['suffix']}")
        print(f"  REMOVE: {iss['remove_candidates']}")
        print()


if __name__ == '__main__':
    main()
