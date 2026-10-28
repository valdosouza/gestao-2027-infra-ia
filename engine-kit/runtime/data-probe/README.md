# Data probe - read-only queries against a live database, rows capped

**Scope**: method

The data step of the [`assess-legacy-repo`](../../skills/assess-legacy-repo/SKILL.md) skill and
of any diagnosis that needs to see what a database holds (technique **T94**): one query
runner that **cannot change the data**. It refuses write, DDL and session words before
anything is sent, proves the session read-only by a write the database itself refuses,
caps the rows, never handles a stored credential and never writes inside the kit. Python
3.8+, standard library only. The database driver is pluggable and **the kit installs
none**: the engine's own command-line client, a DB-API module the case installed, or the
`sqlite3` module that ships with Python.

**Maturity**: the rule is `proven` - two cases ran it (case two through a query runner
that refused write keywords and capped rows, case zero as a read-only database session in
its prepare-only rules); the tool comes from one case, where it served a single database
engine. This runner is a vendor-neutral rewrite of that tool: it has run only against its
own tests (a throwaway `sqlite3` database and a fake client). The first case that points
it at a real engine records what it saw ([maturity](../../docs/MATURITY.md)).

## Files

| File | What it is |
|---|---|
| [`data_probe.py`](data_probe.py) | The command line: configuration, the guard, the read-only proof, the three adapters, the output |
| [`sql_guard.py`](sql_guard.py) | The read-only guard as a pure function (`check_read_only`, `split_statements`): no connection, no file |
| [`data-probe.example.json`](data-probe.example.json) | The configuration, filled with a fictional orders system |
| [`tests/`](tests/test_sql_guard.py) | `python -m unittest discover -s tests` from this folder: the guard ([`test_sql_guard.py`](tests/test_sql_guard.py)) and end to end ([`test_data_probe.py`](tests/test_data_probe.py)) - a throwaway `sqlite3` database, the `sqlite3` module as a DB-API driver, and a fake command-line client written in Python |

## Commands

```text
python data_probe.py --config FILE --target NAME (--query SQL | --file FILE)
       [--max-rows N] [--format text|json|csv] [--out FILE] [--timeout S]
python data_probe.py --check [--config FILE --target NAME] (--query SQL | --file FILE)
python data_probe.py --prove --config FILE --target NAME
python data_probe.py --allow-write --config FILE --target NAME (--query SQL | --file FILE)
```

| Option | Default | Meaning |
|---|---|---|
| `--config` | required, except with `--check` | The case's configuration (below). It lives outside the kit, with the case's notes |
| `--target` | required, except with `--check` | A target of the configuration |
| `--query` / `--file` | one of them | The SQL text. Prefer `--file` and keep the file with the evidence: the result cites its hash |
| `--check` | - | Run the guard only and connect to nothing. With a target, its lexical options are used; without, every option is unknown |
| `--prove` | - | Prove the session read-only (the test write below) and stop |
| `--max-rows` | `max_rows` of the configuration, else 200 | The cap per result. The runner fetches one row more than the cap to say whether more exist; it never counts them |
| `--format` | `text` | `text` (a table), `json` (the result with its metadata), `csv` (one result set only) |
| `--out` | stdout | Write the result to a file. **Refused inside the kit** |
| `--timeout` | the target's `timeout_seconds`, else 120 | Seconds, for the client process and for the `sqlite3` lock wait |
| `--allow-write` | - | Bypass the guard and the proof - **only on a target marked `"disposable": true`**; on any other target it is a configuration error |

Exit codes:

| Code | Meaning |
|---|---|
| `0` | Ran; every result printed (a capped one says `TRUNCATED`) |
| `1` | The database or the client failed (connection, query error, time-out) |
| `2` | Usage or configuration error: unknown target, a secret in the configuration, `--out` inside the kit, `--allow-write` on a target that is not disposable, a missing environment variable, a driver module that is not installed |
| `3` | **Refused by the read-only guard - nothing was sent.** Each reason is printed with its statement and line |
| `4` | **The session is not proven read-only** - the test write was accepted (and rolled back), or failed for another reason than a read-only refusal. No query ran |

Example (fictional): how many orders are still open, on the read replica, as evidence for a
hypothesis:

```text
python data_probe.py --config ../acme-notes/data-probe.json --target orders-replica \
    --file ../acme-kb/SUBJECT/ORDERS/EVIDENCE/H-004-open-orders.sql --format json \
    --out ../acme-kb/SUBJECT/ORDERS/EVIDENCE/H-004-open-orders.json
```

```text
target: orders-replica (cli) | read-only session: proven - the database refused the test write: ERROR: cannot execute UPDATE in a read-only transaction
query: sha256 4ddf0dec68072331 | 1 statement(s) | 2026-10-21T17:45:53+00:00
-- result 1: 2 row(s)
status | n
-------+----
open   | 12
closed | 418
```

## The rule, in tool form

A probe of a live database is safe only with all three layers; each one covers what the
others cannot see.

1. **The guard** ([`sql_guard.py`](sql_guard.py)) - before anything is sent. A text passes
   only when every statement starts with a read word (`SELECT`, `WITH`, `VALUES`, `TABLE`,
   `SHOW`, `EXPLAIN`, `DESCRIBE`, `DESC`, plus the target's `allow_leading`) and no write,
   DDL, rights, execution, transaction or session word appears anywhere outside comments,
   string literals and quoted identifiers (`INSERT`, `UPDATE`, `DELETE`, `MERGE`, `INTO`,
   `CREATE`, `ALTER`, `DROP`, `GRANT`, `EXEC`, `CALL`, `SET`, `BEGIN`, `COMMIT`, `LOCK`, ...;
   `TRUNCATE` and `REPLACE` unless they are a function call). So a writing CTE,
   `SELECT ... INTO`, `SELECT ... FOR UPDATE` and a second statement with no `;` before it
   are refused. Comments and literals fool it in **neither direction**: a keyword inside
   them is not a refusal, and a comment marker inside a literal (`'--'`) cannot comment out
   a write that follows. Statements end at `;` and at a line holding only `GO`.
2. **The read-only session, proven once by a write the database refuses** - before the
   query. The target's `session_prelude` makes the session read-only (an engine setting, a
   read-only login, a read-only connection option); then the target's `read_only_proof`
   statement - a write that would change nothing even if it ran, such as an `UPDATE`
   matching no row - must fail **with the expected refusal** (`expect_error`, default
   `read-only` in any spelling). Accepted, or failed for another reason (a typo, a missing
   table, no connection): exit 4 and no query runs - the same rule as a test that must fail
   for the right reason. The `sqlite` adapter opens the file read-only by URI and has a
   built-in proof. The same rule for a person or an agent working without this tool:
   [`change-gate`, prepare-only, database sessions](../../skills/change-gate/references/prepare-only.md#4-database-sessions-are-read-only).
3. **The row cap** - on every result, so that an exploratory query cannot flood the
   context or the network. Cap at the source too (a `LIMIT` or `TOP`, or the client's own
   flag): a command-line client returns everything before the runner cuts.

What no keyword guard can see is the session's job: a function that writes (a sequence
advanced by a read, a user function with side effects), SQL inside a string handed to
dynamic execution or to a remote server. That is why the proof is not optional in spirit:
without a `read_only_proof` the runner still runs, warns on stderr and writes
`NOT PROVEN` in the result (warn-only by default, [EK#6](../../DECISIONS.md)); a case makes
it mandatory with `"require_proof": true`.

**Credentials.** Never on a command line, never in a file. The `cli` adapter starts the
client with no shell, sends the SQL on its standard input (or in a temporary file that is
deleted afterwards), and lets it inherit the environment - so the client's own credential
variable or integrated authentication works. The `dbapi` adapter reads a secret connect
argument from the environment variable named in `connect_env`. The configuration is
scanned when it loads: a secret-named key with a value (`password`, `pwd`, `secret`,
`token`, `api_key`, ...), a `password=` in a connection string or a `user:password@` in a
URL is exit 2.

## Configuration contract

JSON, kept by the case outside the kit. Keys starting with `_` are notes.

| Key | Default | Meaning |
|---|---|---|
| `targets` | required | Name -> target (below) |
| `max_rows` | 200 | The default cap |
| `require_proof` | `false` | `true`: a target without `read_only_proof` is a configuration error |

Every target:

| Key | Default | Meaning |
|---|---|---|
| `adapter` | required | `sqlite`, `dbapi` or `cli` |
| `session_prelude` | none | SQL sent first in every session (trusted configuration: the guard does not check it). Makes the session read-only |
| `read_only_proof` | none (`sqlite`: built in) | `{"statement": "<a write that changes nothing>", "expect_error": "<regular expression of the refusal>"}` |
| `lexical` | all unknown (`sqlite`: declared) | The engine's lexical options (below) |
| `allow_leading` | `[]` | More words a read statement may start with, for an engine's own read commands. A case decision; it never lifts a write word |
| `disposable` | `false` | `true` only for a throwaway copy: the one kind of target `--allow-write` accepts |
| `timeout_seconds` | 120 | Seconds |

Per adapter:

| Adapter | Keys | How it connects |
|---|---|---|
| `sqlite` | `database` (the file), `open_mode` (`ro`, or `rw` - which the proof then catches) | `sqlite3`, URI `mode=ro`; transactions rolled back |
| `dbapi` | `module` (importable name), `connect` (non-secret arguments), `connect_env` (argument -> environment variable name) | `module.connect(**arguments)`; one statement at a time; rolled back at the end, never committed |
| `cli` | `command` (a list, no shell), `input` (`stdin` or `file` with a `{file}` placeholder), `output` (`raw`, `csv`, `tsv`), `encoding` | One client process per call; `csv`/`tsv` output is parsed (first row = header) and capped by rows; `raw` output is capped by lines, the client's own headers included |

**Lexical options.** Engines lex SQL differently; each difference that could hide a write
is an option. An option the target does not declare is checked **both ways** (only when
the text contains its trigger), so the unknown costs refusals, never a hidden write;
declaring the engine's options removes those refusals.

| Option | When true |
|---|---|
| `nested_block_comments` | `/* a /* b */ c */` is one comment |
| `backslash_escapes` | a backslash escapes the next character in `'...'` and `"..."` |
| `escape_string_prefix` | `E'...'` takes backslash escapes |
| `dash_comment_needs_space` | `--` opens a comment only when whitespace follows |
| `hash_comments` | `#` opens a line comment |
| `executable_comments` | the body of `/*! ... */` is code |
| `dollar_quotes` | `$tag$ ... $tag$` is a string literal |
| `bracket_identifiers` | `[ ... ]` is a quoted identifier |
| `backtick_identifiers` | `` ` ... ` `` is a quoted identifier |

A lexical form the guard does not know (another quoting style, another comment style) can
only make it refuse more; a refusal on a legitimate read is fixed by declaring the engine's
options, by quoting an identifier that happens to be a keyword, or by `allow_leading` -
never by `--allow-write`.

## Writing on purpose

Writes to a shared database are prepared for a human, never run by this tool
([prepare-only](../../skills/change-gate/references/prepare-only.md)). `--allow-write` exists for
a **disposable copy** - a rehearsal of a script or a seed
([`disposable-proof`](../../skills/disposable-proof/SKILL.md)): the target must say
`"disposable": true`, the runner prints a warning, skips the guard, the prelude and the
proof, and commits.

## The result as evidence

A probe result is evidence like a `file:line`: cite the query file, its sha256 (in the
result), the date, the target and the session line - for example
`H-004: 12 open orders - EVIDENCE/H-004-open-orders.sql (sha256 4ddf0dec...), orders-replica, 2026-10-21, session proven`.
Never select secrets or personal data the question does not need; keep the result where
the case keeps its evidence, never in the kit.

## What stayed in the case

The source tool was bound to one database engine, its driver, its batch separator and its
integrated-authentication connection string; its guard stripped comments but not string
literals, so a literal could both cause a false refusal and hide a write behind a comment
marker. The engine, the server names, the logins and the queries stay in the cases; the
kit keeps the rule, the guard (rewritten to read literals and comments together, for any
engine) and the three adapters.
