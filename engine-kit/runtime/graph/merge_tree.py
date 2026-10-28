#!/usr/bin/env python3
"""merge_tree - incremental hardlink overlay tree (engine-kit runtime, graph tools).

Builds the MERGED work tree that a code indexer scans for a product customised per
variant: BASE + OVERLAY -> WORK. An overlay file wins over the base file with the
same relative path, the way a compiler search path picks the unit a variant
overrode. No data is copied: every file in WORK is a hardlink to the real source
file (same volume required; across volumes it falls back to a real copy).

Incremental and self-healing:
  unchanged file (WORK already links the same inode)  -> kept, zero cost
  file edited in place (same inode)                   -> kept: the link already shows it
  file replaced (a VCS update writes a new inode)     -> relinked
  winner changed (an overlay file added or removed)   -> relinked
  file gone from both sources                         -> removed from WORK
  VCS metadata and excluded names                     -> never enter WORK

WORK is read-only territory for scanners: writing into a file there writes into the
real source through the shared inode. WORK is persistent (that is the optimisation)
and owned by this script: a marker file sits NEXT to it (WORK + ".merge_tree", outside
the tree, so the scanner never sees it), and an existing non-empty WORK without its
marker is refused, because the prune pass deletes every file that is in neither
source. WORK may not overlap BASE or OVERLAY for the same reason.

On a case-insensitive file system two spellings of one path are one file: the
overlay spelling wins, and the comparison is done on the normalised path.

Usage:
  python merge_tree.py BASE OVERLAY WORK [--exclude PATTERN ...] [--no-default-excludes]

  --exclude PATTERN        file or folder NAME pattern (fnmatch) kept out of WORK;
                           repeatable; added to the defaults
  --no-default-excludes    drop the default VCS/tool names (see DEFAULT_EXCLUDES)

Exit codes: 0 = done, 1 = some files could not be linked or copied,
2 = bad arguments or refused (overlapping trees, foreign folder).
Python 3.8+, standard library only.
"""

import argparse
import fnmatch
import os
import shutil
import sys

DEFAULT_EXCLUDES = (".git", ".svn", ".hg", ".bzr", "CVS", "__pycache__")
MARKER_SUFFIX = ".merge_tree"
MARKER_TEXT = (
    "Marks the folder of the same name as a merge_tree work tree. Every file there is a\n"
    "hardlink to a real source file: never edit or write into it. That folder is safe to\n"
    "delete; the next run rebuilds it.\n"
)


def full(path):
    return os.path.normcase(os.path.abspath(path))


def is_inside(child, parent):
    child, parent = full(child), full(parent).rstrip("\\/")
    return child == parent or child.startswith(parent + os.sep)


def is_excluded(name, patterns):
    return any(fnmatch.fnmatch(name, pattern) for pattern in patterns)


def walk_files(root, patterns):
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if not is_excluded(d, patterns)]
        for name in filenames:
            if not is_excluded(name, patterns):
                path = os.path.join(dirpath, name)
                yield os.path.relpath(path, root), path


def desired_tree(base, overlay, patterns):
    """normalised relative path -> (relative path, source file); the overlay wins."""
    desired = {}
    overrides = 0
    for index, tree in enumerate((base, overlay)):
        for rel, path in walk_files(tree, patterns):
            key = os.path.normcase(rel)
            if index == 1 and key in desired:
                overrides += 1
            desired[key] = (rel, path)
    return desired, overrides


def claim_work(work):
    """Create WORK, or accept it only when it is empty or has its marker next to it."""
    marker = work + MARKER_SUFFIX
    if os.path.isdir(work):
        if not os.path.exists(marker) and os.listdir(work):
            return ("WORK exists, is not empty and was not created by merge_tree (no marker "
                    "%s): refusing, the prune pass would delete its files" % marker)
    else:
        os.makedirs(work)
    if not os.path.exists(marker):
        with open(marker, "w", encoding="ascii", newline="\n") as handle:
            handle.write(MARKER_TEXT)
    return None


def sync(base, overlay, work, patterns):
    desired, overrides = desired_tree(base, overlay, patterns)
    work_dev = os.stat(work).st_dev
    kept = linked = relinked = copied = removed = 0
    errors = []

    for rel, src in desired.values():
        dst = os.path.join(work, rel)
        try:
            s = os.stat(src)
            if os.path.lexists(dst):
                d = os.stat(dst)
                if (d.st_ino, d.st_dev) == (s.st_ino, s.st_dev):
                    kept += 1
                    continue
                # cross-volume copy from an earlier run: same size and mtime means unchanged
                if (s.st_dev != work_dev and d.st_nlink == 1 and d.st_size == s.st_size
                        and int(d.st_mtime) == int(s.st_mtime)):
                    kept += 1
                    continue
                os.remove(dst)
                relinked += 1
            else:
                os.makedirs(os.path.dirname(dst), exist_ok=True)
                linked += 1
            try:
                os.link(src, dst)
            except OSError:
                shutil.copy2(src, dst)
                copied += 1
        except OSError as exc:
            errors.append("%s: %s" % (rel, exc))

    # prune: anything in WORK that is in neither source (excluded names included)
    for dirpath, _dirnames, filenames in os.walk(work):
        for name in filenames:
            path = os.path.join(dirpath, name)
            rel = os.path.relpath(path, work)
            if os.path.normcase(rel) in desired:
                continue
            try:
                os.remove(path)
                removed += 1
            except OSError as exc:
                errors.append("%s: %s" % (rel, exc))
    for dirpath, _dirnames, _filenames in os.walk(work, topdown=False):
        if dirpath != work and not os.listdir(dirpath):
            os.rmdir(dirpath)

    print("merge_tree: %d unchanged, %d new links, %d relinked, %d removed, "
          "%d cross-volume copies -> %s" % (kept, linked, relinked, removed, copied, work))
    print("merge_tree: %d files in the merged tree (overlay wins on %d)" % (len(desired), overrides))
    for line in errors[:10]:
        print("merge_tree: ERROR %s" % line)
    if len(errors) > 10:
        print("merge_tree: ERROR ... %d more" % (len(errors) - 10))
    return 1 if errors else 0


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Incremental hardlink overlay tree: BASE + OVERLAY -> WORK (overlay wins).")
    parser.add_argument("base", help="base source tree")
    parser.add_argument("overlay", help="overlay source tree (wins on the same relative path)")
    parser.add_argument("work", help="persistent merged work tree (owned by this script)")
    parser.add_argument("--exclude", action="append", default=[], metavar="PATTERN",
                        help="file or folder name pattern kept out of WORK (repeatable)")
    parser.add_argument("--no-default-excludes", action="store_true",
                        help="do not exclude %s" % ", ".join(DEFAULT_EXCLUDES))
    args = parser.parse_args(argv)

    for label, path in (("BASE", args.base), ("OVERLAY", args.overlay)):
        if not os.path.isdir(path):
            print("merge_tree: ERROR %s is not a folder: %s" % (label, path))
            return 2
    for label, path in (("BASE", args.base), ("OVERLAY", args.overlay)):
        if is_inside(args.work, path) or is_inside(path, args.work):
            print("merge_tree: ERROR WORK and %s overlap (%s / %s): refusing" % (label, args.work, path))
            return 2

    patterns = list(args.exclude)
    if not args.no_default_excludes:
        patterns.extend(DEFAULT_EXCLUDES)

    work = os.path.abspath(args.work).rstrip("\\/")
    problem = claim_work(work)
    if problem:
        print("merge_tree: ERROR " + problem)
        return 2
    return sync(os.path.abspath(args.base), os.path.abspath(args.overlay), work, patterns)


if __name__ == "__main__":
    sys.exit(main())
