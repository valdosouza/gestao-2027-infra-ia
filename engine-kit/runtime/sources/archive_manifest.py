#!/usr/bin/env python3
"""archive_manifest.py - the manifest of an official-source archive (engine-kit, T13).

An official-source archive keeps every norm the system must obey (a law, a regulation, a
technical specification, a vendor contract) as the file that was published, a text copy
beside it, and one manifest row with its size and SHA-256. Line citations point into the
text copy, so the text copy is hashed too: if it is regenerated, the citations may move.

  record  add a row for every archived file that has none: kind, size, SHA-256 and, for a
          document that needs a text copy, the text copy expected beside it. Rows already
          there keep every column. A row whose file changed is NOT re-hashed: it is
          reported, because an archived norm is never replaced in place - a new version
          is a new file with a row of its own.
  verify  report what does not match: changed, missing, unrecorded, a document without
          its text copy, provenance not filled in, a publisher hash that does not match.

Kinds: `source` (a published file), `text` (the text copy of a source beside it, same
name, .txt), `transcription` (a .txt with no source beside it - a web page read and
transcribed). Required columns a person fills in after `record`: `origin` and `retrieved`
for sources and transcriptions, `method` (the extraction command and mode) for text copies.
`publisher_hash` is optional, `<algorithm>:<hex>` as the publisher printed it (for example
`sha512:4f0c...`); `verify` recomputes it.

Usage:
  python archive_manifest.py record <archive-root> [--manifest FILE] [--exclude GLOB ...]
                                    [--needs-text .pdf,.docx,...] [--date YYYY-MM-DD]
  python archive_manifest.py verify <archive-root> [--manifest FILE] [--exclude GLOB ...]
                                    [--needs-text .pdf,.docx,...]

The manifest defaults to <archive-root>/MANIFEST.csv; markdown files (the archive's README,
the checks file) and the manifest itself are not archived content and are skipped.
--exclude takes a glob on the archive-relative path with forward slashes (for example
`bundles/*/*` for the extracted copy of a bundle that is itself archived).

Exit codes: 0 nothing to report (record: manifest written); 1 findings (record: a recorded
file changed and was left as it was); 2 usage.

Python 3.8+, standard library only. It never deletes, renames or edits an archived file.
"""

import argparse
import csv
import datetime
import fnmatch
import hashlib
import os
import sys

COLUMNS = ["file", "kind", "bytes", "sha256", "text_copy", "title", "origin", "retrieved",
           "method", "publisher_hash", "recorded"]
DEFAULT_NEEDS_TEXT = ".pdf,.doc,.docx,.odt,.rtf,.xls,.xlsx,.ods,.htm,.html"
MANIFEST_NAME = "MANIFEST.csv"
CHUNK = 1024 * 1024


def file_hash(path, algorithm="sha256"):
    digest = hashlib.new(algorithm)
    with open(path, "rb") as handle:
        for block in iter(lambda: handle.read(CHUNK), b""):
            digest.update(block)
    return digest.hexdigest()


def parse_exts(text):
    exts = set()
    for item in text.split(","):
        item = item.strip().lower()
        if item:
            exts.add(item if item.startswith(".") else "." + item)
    return exts


def scan(root, manifest_path, excludes, needs_text):
    """{relative posix path: kind} of every archived file under root."""
    manifest_abs = os.path.normcase(os.path.abspath(manifest_path))
    found = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(d for d in dirnames if not d.startswith("."))
        for name in sorted(filenames):
            full = os.path.join(dirpath, name)
            if os.path.normcase(os.path.abspath(full)) == manifest_abs:
                continue
            if name.lower().endswith(".md") or name.startswith("."):
                continue
            relpath = os.path.relpath(full, root).replace(os.sep, "/")
            if any(fnmatch.fnmatch(relpath, pattern) for pattern in excludes):
                continue
            found.append(relpath)
    documents = {os.path.splitext(p)[0] for p in found if os.path.splitext(p)[1].lower() in needs_text}
    kinds = {}
    for relpath in found:
        stem, ext = os.path.splitext(relpath)
        if ext.lower() == ".txt":
            kinds[relpath] = "text" if stem in documents else "transcription"
        else:
            kinds[relpath] = "source"
    return kinds


def expected_text_copy(relpath, kind, needs_text):
    if kind != "source":
        return ""
    stem, ext = os.path.splitext(relpath)
    return stem + ".txt" if ext.lower() in needs_text else ""


def load_manifest(path):
    if not os.path.isfile(path):
        return {}
    with open(path, "r", encoding="utf-8", newline="") as handle:
        rows = {}
        for row in csv.DictReader(handle):
            row = {column: (row.get(column) or "").strip() for column in COLUMNS}
            if row["file"]:
                rows[row["file"]] = row
        return rows


def write_manifest(path, rows):
    with open(path, "w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=COLUMNS, lineterminator="\n")
        writer.writeheader()
        for key in sorted(rows):
            writer.writerow(rows[key])


def check_publisher_hash(full, value):
    """None when it matches, else the finding text."""
    if ":" not in value:
        return "publisher hash '%s' is not <algorithm>:<hex>" % value
    algorithm, expected = value.split(":", 1)
    algorithm = algorithm.strip().lower().replace("-", "")
    if algorithm not in hashlib.algorithms_available:
        return "unknown hash algorithm '%s'" % algorithm
    actual = file_hash(full, algorithm)
    if actual.lower() != expected.strip().lower():
        return "%s is %s, the publisher printed %s" % (algorithm, actual, expected.strip())
    return None


def line_endings_only(full, recorded):
    """True when the file matches the recorded hash once CRLF/LF are converted back."""
    with open(full, "rb") as handle:
        data = handle.read()
    for variant in (data.replace(b"\r\n", b"\n"), data.replace(b"\r\n", b"\n").replace(b"\n", b"\r\n")):
        if variant != data and hashlib.sha256(variant).hexdigest() == recorded:
            return True
    return False


def compare(root, rows):
    """Findings on files already in the manifest: changed or missing."""
    findings = []
    for relpath in sorted(rows):
        row = rows[relpath]
        full = os.path.join(root, relpath)
        if not os.path.isfile(full):
            findings.append(("missing", relpath, "in the manifest, not on disk"))
            continue
        size = str(os.path.getsize(full))
        digest = file_hash(full)
        if size != row["bytes"] or digest != row["sha256"]:
            note = "bytes %s -> %s, sha256 %s -> %s" % (row["bytes"], size, row["sha256"][:16], digest[:16])
            if line_endings_only(full, row["sha256"]):
                note += "; line endings only - a checkout converted them: mark the archive binary in the VCS"
            elif row["kind"] == "text":
                note += "; line citations into it may have moved"
            findings.append(("changed", relpath, note))
    return findings


def record(root, manifest_path, excludes, needs_text, date):
    rows = load_manifest(manifest_path)
    kinds = scan(root, manifest_path, excludes, needs_text)
    findings = compare(root, rows)
    added = []
    for relpath, kind in sorted(kinds.items()):
        if relpath in rows:
            continue
        full = os.path.join(root, relpath)
        row = {column: "" for column in COLUMNS}
        row.update(file=relpath, kind=kind, bytes=str(os.path.getsize(full)),
                   sha256=file_hash(full), text_copy=expected_text_copy(relpath, kind, needs_text),
                   recorded=date)
        rows[relpath] = row
        added.append(relpath)
    write_manifest(manifest_path, rows)
    return added, findings


def verify(root, manifest_path, excludes, needs_text):
    rows = load_manifest(manifest_path)
    kinds = scan(root, manifest_path, excludes, needs_text)
    findings = compare(root, rows)
    for relpath in sorted(kinds):
        if relpath not in rows:
            findings.append(("unrecorded", relpath, "on disk, no manifest row (run record)"))
    for relpath in sorted(rows):
        row = rows[relpath]
        full = os.path.join(root, relpath)
        text_copy = row["text_copy"] or expected_text_copy(relpath, row["kind"], needs_text)
        if row["kind"] == "source" and text_copy and not os.path.isfile(os.path.join(root, text_copy)):
            findings.append(("no-text-copy", relpath, "expected beside it: %s" % text_copy))
        required = ("method",) if row["kind"] == "text" else ("origin", "retrieved")
        empty = [column for column in required if not row[column]]
        if empty:
            findings.append(("incomplete", relpath, "fill in: %s" % ", ".join(empty)))
        if row["publisher_hash"] and os.path.isfile(full):
            problem = check_publisher_hash(full, row["publisher_hash"])
            if problem:
                findings.append(("publisher-mismatch", relpath, problem))
    return findings


def print_findings(findings):
    for kind, relpath, note in findings:
        print("%-19s %s  (%s)" % (kind, relpath, note))


def main(argv=None):
    parser = argparse.ArgumentParser(description="Record or verify the manifest of an official-source archive.")
    parser.add_argument("action", choices=("record", "verify"))
    parser.add_argument("root", help="the archive folder")
    parser.add_argument("--manifest", help="manifest CSV (default: <root>/%s)" % MANIFEST_NAME)
    parser.add_argument("--exclude", action="append", default=[], help="glob on the archive-relative path; repeatable")
    parser.add_argument("--needs-text", default=DEFAULT_NEEDS_TEXT,
                        help="extensions that need a text copy beside them (default: %s)" % DEFAULT_NEEDS_TEXT)
    parser.add_argument("--date", default=datetime.date.today().isoformat(), help="the recorded date of new rows")
    try:
        args = parser.parse_args(argv)
    except SystemExit as exc:
        return 2 if exc.code else 0
    if not os.path.isdir(args.root):
        print("error: %s is not a folder" % args.root, file=sys.stderr)
        return 2
    manifest_path = args.manifest or os.path.join(args.root, MANIFEST_NAME)
    needs_text = parse_exts(args.needs_text)
    if args.action == "record":
        added, findings = record(args.root, manifest_path, args.exclude, needs_text, args.date)
        for relpath in added:
            print("recorded            %s" % relpath)
        print_findings(findings)
        print("%d row(s) added to %s; fill in origin and retrieved (sources, transcriptions) and "
              "method (text copies), then run verify." % (len(added), manifest_path))
        return 1 if any(kind == "changed" for kind, _, _ in findings) else 0
    findings = verify(args.root, manifest_path, args.exclude, needs_text)
    print_findings(findings)
    print("%d finding(s)" % len(findings))
    return 1 if findings else 0


if __name__ == "__main__":
    sys.exit(main())
