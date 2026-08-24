#!/usr/bin/env python3
"""Remove IBX/FireDAC component units from Delphi uses clauses; keep ST* units."""

import re
import sys
from pathlib import Path

ROOT = Path(r"d:\Gestao2016")
SKIP_PARTS = {"__history", ".svn", "Pk_Setes_For_Firedac"}

REMOVE_EXACT = {
    "IBX.IBQuery", "IBQuery",
    "IBX.IBTable", "IBTable",
    "IBX.IBDatabase", "IBDatabase",
    "IBX.IBTransaction", "IBTransaction",
    "IBX.IBStoredProc", "IBStoredProc",
    "IBX.IBScript", "IBScript",
    "IBX.IBSQL", "IBSql", "IBSQL",
}

IB_FIELD_RE = re.compile(r"\bTIB\w+Field\b")

TYPE_UNIT_MAP = [
    (re.compile(r"\bTSTWaitCursor\b"), "STWaitCursor"),
    (re.compile(r"\bTSTFBDriverLink\b"), "STFBDriverLink"),
    (re.compile(r"\bTSTSQL\b"), "STSQL"),
    (re.compile(r"\bTSTClientDataset\b"), "STClientDataset"),
    (re.compile(r"\bTSTScript\b"), "STScript"),
    (re.compile(r"\bTSTStoredProc\b"), "STStoredProc"),
    (re.compile(r"\bTSTDataSet\b"), "STDataSet"),
    (re.compile(r"\bTSTTable\b"), "STTable"),
    (re.compile(r"\bTSTTransaction\b"), "STTransaction"),
    (re.compile(r"\bTSTDatabase\b"), "STDatabase"),
    (re.compile(r"\bTSTQuery\b"), "STQuery"),
]


def should_skip(path: Path) -> bool:
    return any(part in SKIP_PARTS for part in path.parts)


def split_units(uses_body: str) -> list[str]:
    units = []
    for part in uses_body.split(","):
        unit = part.strip()
        if unit:
            units.append(unit)
    return units


def join_units(units: list[str]) -> str:
    if not units:
        return ""
    lines = []
    current = "  "
    for unit in units:
        addition = unit if not current.strip() else ", " + unit
        if len(current) + len(addition) > 100 and current.strip():
            lines.append(current.rstrip() + ",")
            current = "  " + unit
        else:
            current += addition
    if current.strip():
        lines.append(current)
    return "\n".join(lines)


def clean_units(units: list[str], keep_ib_fields: bool) -> list[str]:
    cleaned = []
    for unit in units:
        if unit in REMOVE_EXACT:
            continue
        if unit.startswith("FireDAC."):
            continue
        if not keep_ib_fields and unit in {"IBCustomDataSet", "IBX.IBCustomDataSet"}:
            continue
        cleaned.append(unit)
    return cleaned


def ensure_st_units(units: list[str], content: str) -> list[str]:
    existing = set(units)
    for pattern, unit_name in TYPE_UNIT_MAP:
        if pattern.search(content) and unit_name not in existing:
            units.append(unit_name)
            existing.add(unit_name)
    return units


def process_uses_section(match: re.Match, content: str) -> str:
    prefix = match.group(1)
    body = match.group(2)
    suffix = match.group(3)
    keep_ib_fields = bool(IB_FIELD_RE.search(content))
    units = split_units(body)
    units = clean_units(units, keep_ib_fields)
    units = ensure_st_units(units, content)
    if not units:
        return match.group(0)
    return prefix + join_units(units) + suffix


def process_file(path: Path) -> bool:
    text = path.read_text(encoding="latin-1")
    original = text

    uses_pattern = re.compile(
        r"(\buses\b\s*)([\s\S]*?)(;)",
        re.IGNORECASE,
    )

    def replacer(match: re.Match) -> str:
        return process_uses_section(match, text)

    text = uses_pattern.sub(replacer, text)

    if text != original:
        path.write_text(text, encoding="latin-1", newline="\r\n")
        return True
    return False


def main() -> int:
    changed = []
    for path in ROOT.rglob("*.pas"):
        if should_skip(path):
            continue
        if process_file(path):
            changed.append(path)

    print(f"Updated {len(changed)} files")
    for path in changed[:30]:
        print(f"  {path.relative_to(ROOT)}")
    if len(changed) > 30:
        print(f"  ... and {len(changed) - 30} more")
    return 0


if __name__ == "__main__":
    sys.exit(main())
