"""sql_guard - prove that a SQL text only reads, before it is sent anywhere.

Pure functions; Python 3.8+, standard library only; no connection, no file, no network.

    check_read_only(text, lexical=None, allow_leading=()) -> Verdict
    split_statements(text, lexical=None) -> [(start, end), ...]

A text is accepted only when EVERY lexing the guard considers finds

  1. at least one statement (statements end at ';' and at a line holding only GO);
  2. every statement starting with a read word - SELECT, WITH, VALUES, TABLE, SHOW,
     EXPLAIN, DESCRIBE, DESC - or a word the case adds with allow_leading;
  3. no write, DDL, rights, execution, transaction or session word ANYWHERE outside
     comments, string literals and quoted identifiers (WRITE_WORDS; TRUNCATE and REPLACE
     only when they are not a function call) - a writing CTE, SELECT ... INTO,
     SELECT ... FOR UPDATE and a second statement with no ';' before it are caught here;
  4. no comment, string literal or quoted identifier left open.

Database engines lex SQL differently (do block comments nest? does a backslash escape a
quote? is '#' a comment? ...). Each difference is a lexical option (LEXICAL_OPTIONS). An
option the caller does not declare is checked BOTH ways, so that a construct one engine
reads as a comment or a literal cannot hide a write from the guard; declaring the target
engine's options removes the refusals that the unknown options cause. Options that cannot
change the lexing of the given text are not branched on.

What no keyword guard can see - a function that writes, SQL inside a string handed to
dynamic execution or to a remote server - is the read-only session's job: the guard is the
first line, the session (proven by a write it refuses) is the second.
"""

import bisect
import collections
import itertools
import re

LEXICAL_OPTIONS = (
    'nested_block_comments',     # /* a /* b */ c */ is one comment
    'backslash_escapes',         # a backslash escapes the next character inside '...' and "..."
    'escape_string_prefix',      # E'...' (an E right before the quote) takes backslash escapes
    'dash_comment_needs_space',  # -- starts a comment only when whitespace or a control character follows
    'hash_comments',             # # starts a line comment
    'executable_comments',       # the body of /*! ... */ is code, not a comment
    'dollar_quotes',             # $tag$ ... $tag$ is a string literal
    'bracket_identifiers',       # [ ... ] is a quoted identifier
    'backtick_identifiers',      # ` ... ` is a quoted identifier
)

READ_LEADS = frozenset(('SELECT', 'WITH', 'VALUES', 'TABLE', 'SHOW', 'EXPLAIN', 'DESCRIBE', 'DESC'))

WRITE_WORDS = frozenset((
    # data
    'INSERT', 'UPDATE', 'DELETE', 'MERGE', 'UPSERT', 'INTO',
    # schema
    'CREATE', 'ALTER', 'DROP', 'RENAME',
    # rights
    'GRANT', 'REVOKE', 'DENY',
    # code execution
    'EXEC', 'EXECUTE', 'CALL',
    # transaction and session state
    'BEGIN', 'COMMIT', 'ROLLBACK', 'SAVEPOINT', 'SET',
    # engine maintenance, files, server control
    'ATTACH', 'DETACH', 'VACUUM', 'REINDEX', 'LOCK', 'BACKUP', 'RESTORE', 'DBCC', 'KILL',
    'SHUTDOWN', 'CHECKPOINT', 'RECONFIGURE', 'ENABLE', 'DISABLE', 'WRITETEXT', 'UPDATETEXT',
))

# A write when used as a statement, a harmless function when "(" follows.
FUNCTION_OR_WRITE = frozenset(('TRUNCATE', 'REPLACE'))

# Text that must be present for an option to change the lexing at all.
_TRIGGERS = {
    'nested_block_comments': lambda t: t.count('/*') >= 2,
    'backslash_escapes': lambda t: '\\' in t,
    'escape_string_prefix': lambda t: '\\' in t,
    'dash_comment_needs_space': lambda t: '--' in t,
    'hash_comments': lambda t: '#' in t,
    'executable_comments': lambda t: '/*!' in t,
    'dollar_quotes': lambda t: '$' in t,
    'bracket_identifiers': lambda t: '[' in t,
    'backtick_identifiers': lambda t: '`' in t,
}

_WORD_RE = re.compile(r'\w+')
_LETTERS_RE = re.compile(r'[^\W\d]+')
_DOLLAR_RE = re.compile(r'\$([^\W\d]\w*)?\$')
_GO_LINE_RE = re.compile(r'(?i)\s*GO(\s+\d+)?\s*$')
# Every character some engine ends a line comment with: ending earlier only shows more code.
_LINE_BREAKS = '\n\r\x0b\x0c\x1c\x1d\x1e\x85  '

Token = collections.namedtuple('Token', 'kind value start end')   # kind: word literal semi lparen other
Finding = collections.namedtuple('Finding', 'message line assumption')


class Verdict(collections.namedtuple('Verdict', 'read_only findings statements variants')):
    """read_only: bool; findings: [Finding]; statements: [(start, end)] of the declared lexing;
    variants: how many lexings were checked."""

    def reasons(self):
        out = []
        for f in self.findings:
            text = '%s (line %d)' % (f.message, f.line) if f.line else f.message
            if f.assumption:
                text += ' - when ' + f.assumption
            out.append(text)
        return out


class LexicalError(ValueError):
    """An unknown lexical option or a value that is not true, false or null."""


def normalise_lexical(lexical):
    """{option: True | False | None}; a missing option is None (unknown)."""
    lexical = dict(lexical or {})
    unknown = sorted(k for k in lexical if k not in LEXICAL_OPTIONS and not k.startswith('_'))
    if unknown:
        raise LexicalError('unknown lexical option(s): %s (known: %s)' % (', '.join(unknown), ', '.join(LEXICAL_OPTIONS)))
    out = {}
    for name in LEXICAL_OPTIONS:
        value = lexical.get(name)
        if value not in (True, False, None):
            raise LexicalError('lexical option %s must be true, false or null, not %r' % (name, value))
        out[name] = value
    return out


# ------------------------------------------------------------------ lexing

def _line_end(text, i):
    n = len(text)
    while i < n and text[i] not in _LINE_BREAKS:
        i += 1
    return i


def _block_comment_end(text, i, nested):
    """Index just after the comment opened at i, or -1 when it never closes."""
    depth, j, n = 1, i + 2, len(text)
    while j < n:
        if text.startswith('*/', j):
            depth -= 1
            j += 2
            if depth == 0 or not nested:
                return j
            continue
        if nested and text.startswith('/*', j):
            depth += 1
            j += 2
            continue
        j += 1
    return -1


def _quoted_end(text, i, close, backslash):
    """Index just after the quoted run opened at i (doubling the closer escapes it)."""
    j, n = i + 1, len(text)
    while j < n:
        c = text[j]
        if backslash and c == '\\':
            j += 2
            continue
        if c == close:
            if j + 1 < n and text[j + 1] == close:
                j += 2
                continue
            return j + 1
        j += 1
    return -1


def _is_ident_char(c):
    return c.isalnum() or c == '_'


def _lex(text, opt):
    """Tokens of the code, and the errors (message, offset) of runs left open."""
    tokens, errors = [], []
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        if c.isspace():
            i += 1
            continue
        if c == '-' and text.startswith('--', i):
            follower = text[i + 2] if i + 2 < n else ' '
            if not opt['dash_comment_needs_space'] or follower.isspace() or ord(follower) < 32:
                i = _line_end(text, i)
                continue
        if c == '#' and opt['hash_comments']:
            i = _line_end(text, i)
            continue
        if c == '/' and text.startswith('/*', i):
            if opt['executable_comments'] and text.startswith('/*!', i):
                j = i + 3
                while j < n and text[j].isdigit():
                    j += 1
                i = j  # the body is code; its closing */ lexes as two harmless characters
                continue
            end = _block_comment_end(text, i, opt['nested_block_comments'])
            if end < 0:
                errors.append(('block comment never closed', i))
                break
            i = end
            continue
        closer, backslash = None, False
        if c == "'":
            closer = "'"
            prefixed = (i > 0 and text[i - 1] in 'eE' and (i < 2 or not _is_ident_char(text[i - 2])))
            backslash = opt['backslash_escapes'] or (opt['escape_string_prefix'] and prefixed)
        elif c == '"':
            closer, backslash = '"', opt['backslash_escapes']
        elif c == '[' and opt['bracket_identifiers']:
            closer = ']'
        elif c == '`' and opt['backtick_identifiers']:
            closer = '`'
        if closer:
            end = _quoted_end(text, i, closer, backslash)
            if end < 0:
                errors.append(('%s never closed' % ('string literal' if c in '\'"' else 'quoted identifier'), i))
                break
            tokens.append(Token('literal', text[i:end], i, end))
            i = end
            continue
        if c == '$' and opt['dollar_quotes'] and not (i > 0 and _is_ident_char(text[i - 1])):
            m = _DOLLAR_RE.match(text, i)
            if m:
                close_at = text.find(m.group(0), m.end())
                if close_at < 0:
                    errors.append(('dollar-quoted string never closed', i))
                    break
                end = close_at + len(m.group(0))
                tokens.append(Token('literal', text[i:end], i, end))
                i = end
                continue
        m = _WORD_RE.match(text, i)
        if m:
            tokens.append(Token('word', m.group(0), i, m.end()))
            i = m.end()
            continue
        kind = {';': 'semi', '(': 'lparen'}.get(c, 'other')
        tokens.append(Token(kind, c, i, i + 1))
        i += 1
    return tokens, errors


def _statements(text, tokens):
    """Split the tokens at ';' and at a line holding only GO (a client batch separator)."""
    out, current, skip_until = [], [], -1
    for tok in tokens:
        if tok.start < skip_until:  # the count of "GO 5" belongs to the separator line
            continue
        if tok.kind == 'semi':
            if current:
                out.append(current)
            current = []
            continue
        if tok.kind == 'word' and tok.value.upper() == 'GO':
            start = text.rfind('\n', 0, tok.start) + 1
            stop = text.find('\n', tok.end)
            stop = len(text) if stop < 0 else stop
            if _GO_LINE_RE.match(text[start:stop]):
                if current:
                    out.append(current)
                current, skip_until = [], stop
                continue
        current.append(tok)
    if current:
        out.append(current)
    return out


def _candidate_words(tok):
    """The words a keyword check looks at: the token, and inside a run that starts with a digit
    (1DELETE, 1e1union) every run of letters, because some engines split there."""
    yield tok.value.upper()
    if tok.value[0].isdigit():
        for m in _LETTERS_RE.finditer(tok.value):
            yield m.group(0).upper()


def _check_variant(text, opt, leads, line_of):
    tokens, errors = _lex(text, opt)
    findings = [(message, line_of(offset)) for message, offset in errors]
    statements = _statements(text, tokens)
    if not statements and not errors:
        findings.append(('no statement to run', 0))
    for number, stmt in enumerate(statements, 1):
        lead = next((t for t in stmt if t.kind != 'lparen'), None)
        if lead is None or lead.kind != 'word' or lead.value.upper() not in leads:
            shown = lead.value if lead is not None else '('
            findings.append(("statement %d starts with '%s', not a read word" % (number, shown[:30]),
                             line_of(lead.start if lead is not None else stmt[0].start)))
        for index, tok in enumerate(stmt):
            if tok.kind != 'word':
                continue
            for word in _candidate_words(tok):
                if word in WRITE_WORDS:
                    findings.append(("write or session word '%s' in statement %d" % (word, number), line_of(tok.start)))
                elif word in FUNCTION_OR_WRITE:
                    after = stmt[index + 1] if index + 1 < len(stmt) else None
                    if after is None or after.kind != 'lparen':
                        findings.append(("write word '%s' in statement %d" % (word, number), line_of(tok.start)))
    spans = [(s[0].start, s[-1].end) for s in statements]
    return findings, spans


def _variants(text, lexical):
    unknown = [k for k in LEXICAL_OPTIONS if lexical[k] is None and _TRIGGERS[k](text)]
    base = {k: bool(v) for k, v in lexical.items()}
    for values in itertools.product((False, True), repeat=len(unknown)):
        opt = dict(base)
        opt.update(zip(unknown, values))
        assumed = ', '.join('%s=%s' % (k, str(v).lower()) for k, v in zip(unknown, values))
        yield opt, assumed


def _line_index(text):
    starts = [0] + [m.end() for m in re.finditer('\n', text)]
    return lambda offset: bisect.bisect_right(starts, offset)


def check_read_only(text, lexical=None, allow_leading=()):
    """Verdict on a SQL text: read_only is True only when every lexing finds a read."""
    text = text or ''
    lexical = normalise_lexical(lexical)
    leads = READ_LEADS | frozenset(w.upper() for w in allow_leading)
    line_of = _line_index(text)
    where = collections.OrderedDict()  # (message, line) -> the assumptions under which it was found
    declared_spans, count = None, 0
    for opt, assumed in _variants(text, lexical):
        count += 1
        variant_findings, spans = _check_variant(text, opt, leads, line_of)
        if declared_spans is None:  # the first variant: every unknown option false
            declared_spans = spans
        for key in variant_findings:
            assumptions = where.setdefault(key, [])
            if assumed not in assumptions:
                assumptions.append(assumed)
    findings = [Finding(message, line, '' if len(assumed) == count else assumed[0])
                for (message, line), assumed in where.items()]
    return Verdict(not findings, findings, declared_spans or [], count)


def split_statements(text, lexical=None):
    """Statement spans (start, end) under the declared options (unknown options taken as false).
    Used to send a checked text one statement at a time; it decides nothing about safety."""
    lexical = normalise_lexical(lexical)
    opt = {k: bool(v) for k, v in lexical.items()}
    tokens, _ = _lex(text, opt)
    return [(s[0].start, s[-1].end) for s in _statements(text, tokens)]
