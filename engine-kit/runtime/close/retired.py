#!/usr/bin/env python3
r"""retired.py - the retired-location guard of the close script (engine-kit runtime, T88).

A retired location (an old share, an old tool folder, a per-user folder) must not be
pointed at by a normative file: a rules file, a skill, an agent, an index, a registry.
The locations are data - the `retired` section of the close configuration - written once
each; this module turns every one into a pattern that also matches its other spellings:

  drive letter  R:\old-share\kb  R:/old-share/kb  R:\\old-share\\kb (escaped in code or JSON)
                /r/old-share/kb (a POSIX shell)  /mnt/r/old-share/kb  file:///R:/old-share/kb
  UNC           \\files01\old-share  //files01/old-share  \\\\files01\\old-share
  any path      separators in any mix and repetition; letters in any case (unless
                caseSensitive); a trailing separator in the entry means "inside it"

A UNC name and a drive letter are two spellings of one share that no tool can derive from
each other: list both in the entry. `patterns` takes raw regular expressions for anything
else (an old host name, an old tool name).

  rules_from_config(section)                 -> [Rule]  (ValueError on a bad entry)
  spelling_regex(text, case_sensitive=False) -> compiled pattern
  scan_text(lines, rules, allow=None)        -> [(line number, Rule, line)]
  is_superseded(lines, head=10)              -> bool: the file says SUPERSEDED near its top

Python 3.8+, standard library only.
"""

import re

SEP = r'[\\/]+'
END = r'(?![\w-])'
URL_RE = re.compile(r'^[A-Za-z][A-Za-z0-9+.-]+://')
DRIVE_RE = re.compile(r'^([A-Za-z]):$')
SUPERSEDED_RE = re.compile(r'\bSUPERSEDED\b')


class Rule(object):
    """One retired location (all its spellings) or one raw pattern."""

    def __init__(self, label, regexes, instead='', why=''):
        self.label = label
        self.regexes = regexes
        self.instead = instead
        self.why = why

    def search(self, line):
        return any(rx.search(line) for rx in self.regexes)

    def describe(self):
        parts = [self.label]
        if self.why:
            parts.append(self.why)
        if self.instead:
            parts.append('instead: ' + self.instead)
        return '; '.join(parts)


def _join(segments):
    return SEP.join(re.escape(s) for s in segments)


def spelling_regex(text, case_sensitive=False):
    """A pattern for one written location that also matches its other spellings."""
    s = (text or '').strip()
    if not s:
        raise ValueError('empty retired location')
    flags = 0 if case_sensitive else re.IGNORECASE
    if URL_RE.match(s):
        return re.compile(re.escape(s.rstrip('/')) + END, flags)
    trailing = s[-1] in '\\/'
    unc = len(s) > 2 and s[0] in '\\/' and s[1] in '\\/'
    segments = [x for x in re.split(r'[\\/]+', s) if x]
    if not segments:
        raise ValueError('retired location without a name: %r' % text)
    drive = DRIVE_RE.match(segments[0])
    if unc:
        # \\server\share, //server/share, \\\\server\\share, file://server/share
        body = r'(?<![\w.])[\\/]{2,}' + _join(segments)
        rest = True
    elif drive:
        letter = '[%s%s]' % (drive.group(1).lower(), drive.group(1).upper())
        tail = _join(segments[1:])
        rest = bool(segments[1:])
        if rest:
            windows = r'(?<!\w)' + letter + ':' + SEP + tail
            posix = r'(?<![\w.~-])/(?:mnt/|cygdrive/)?' + letter + SEP + tail
        else:  # a whole drive: only when a separator follows, "R:" alone is prose
            windows = r'(?<!\w)' + letter + r':(?=[\\/])'
            posix = r'(?<![\w.~-])/(?:mnt/|cygdrive/)?' + letter + r'(?=[\\/])'
        body = '(?:%s|%s)' % (windows, posix)
    else:
        lead = SEP if s[0] in '\\/' else ''
        body = r'(?<![\w.-])' + lead + _join(segments)
        rest = True
    if rest:
        body += SEP if trailing else END
    return re.compile(body, flags)


def _entry_fields(entry, kind):
    if isinstance(entry, str):
        return [entry], '', ''
    if not isinstance(entry, dict):
        raise ValueError('retired %s: each entry is a string or an object, not %r' % (kind, entry))
    unknown = [k for k in entry if not k.startswith('_') and k not in ('spellings', 'location', 'regex', 'instead', 'why')]
    if unknown:
        raise ValueError('retired %s: unknown key(s) %s' % (kind, ', '.join(sorted(unknown))))
    values = entry.get('regex' if kind == 'patterns' else 'spellings') or []
    if kind == 'locations' and entry.get('location'):
        values = [entry['location']] + list(values)
    if isinstance(values, str):
        values = [values]
    if not values:
        raise ValueError('retired %s: an entry without %s' % (kind, 'regex' if kind == 'patterns' else 'spellings'))
    return list(values), str(entry.get('instead') or ''), str(entry.get('why') or '')


def rules_from_config(section):
    """[Rule] from the `retired` section: locations (spellings expanded) and raw patterns."""
    section = section or {}
    case_sensitive = bool(section.get('caseSensitive', False))
    rules = []
    for entry in section.get('locations') or []:
        values, instead, why = _entry_fields(entry, 'locations')
        regexes = [spelling_regex(v, case_sensitive) for v in values]
        rules.append(Rule(values[0], regexes, instead, why))
    for entry in section.get('patterns') or []:
        values, instead, why = _entry_fields(entry, 'patterns')
        try:
            regexes = [re.compile(v, 0 if case_sensitive else re.IGNORECASE) for v in values]
        except re.error as exc:
            raise ValueError('retired patterns: %r is not a valid regular expression (%s)' % (values, exc))
        rules.append(Rule('pattern ' + values[0], regexes, instead, why))
    return rules


def scan_text(lines, rules, allow=None):
    """[(line number, Rule, line)]: one hit per rule and line; lines matching allow are skipped."""
    hits = []
    for number, line in enumerate(lines, 1):
        if allow is not None and allow.search(line):
            continue
        for rule in rules:
            if rule.search(line):
                hits.append((number, rule, line))
    return hits


def is_superseded(lines, head=10):
    """True when the file declares itself SUPERSEDED in its first `head` lines (kept for history)."""
    return any(SUPERSEDED_RE.search(line) for line in lines[:head])
