# Browser runner - one spec, headless, literal read-back

**Scope**: method

The headless engine of the [`browser-verification`](../../skills/browser-verification/SKILL.md)
skill (technique T41). `run.mjs` executes one engine-agnostic spec (JSON) with Playwright
and records one verdict per case - **PASS, FAIL, BLOCKED or MANUAL** - with the literal
values read back from the page, the case's console errors and failed requests, and a
screenshot for every FAIL. The same spec runs unchanged in the built-in browser pane and in
the user's Chrome ([engines](../../skills/browser-verification/references/engines.md)).
**Login is a human step**: the runner never types, reads or stores a username or a
password. Node 18+, one file, no dependency of its own; Playwright is an optional peer.

## Files

| File | What it is |
|---|---|
| [`run.mjs`](run.mjs) | The runner: validates a spec (`--dry-run`, no browser), captures a human login (`--login`), runs the cases, writes the JSON report and, with `--report`, a markdown report |
| [`package.json`](package.json) | Name, `bin`, Node engine, Playwright as an **optional peer** (`>=1.40.0`), two scripts: `check` and `example:dry-run`. No dependencies |
| [`.gitignore`](.gitignore) | Guards a manual install here (`node_modules/`, `evidence/`, session files). The runner itself never writes in this folder |
| [`example/acme-orders.spec.json`](example/acme-orders.spec.json) | A complete spec (fictional work item `ORD-42`): two cases on the changed behaviour, a regression control, a manual case; reload before every read-back; cleanup on every saving case |
| [`example/index.html`](example/index.html) | The tiny static page the example runs against: order lines kept in the browser's local storage, so a reload reads back what was stored |

The spec format, key by key, agrees with the validator in `run.mjs`:
[spec-format.md](../../skills/browser-verification/references/spec-format.md).

## Install - Playwright, once, outside every repository

`--dry-run` needs nothing but Node. Every other mode needs Playwright, which the runner
**never installs**. Install it once per machine in a tooling folder that no repository
versions (never in the kit, never in a work item's folder):

```
mkdir <tools>/browser-runner
cd <tools>/browser-runner
npm init -y
npm install playwright
npx playwright install chromium
```

Then either run from that folder or point the runner at it:

```
PLAYWRIGHT_FROM=<tools>/browser-runner      (bash)
$env:PLAYWRIGHT_FROM = "<tools>\browser-runner"   (PowerShell)
```

The runner resolves `playwright` from `PLAYWRIGHT_FROM`, then the current folder, then its
own folder (`NODE_PATH` works too). Without it: exit `4` and these instructions. The
browser binaries must match the installed Playwright; when they are missing, Playwright's
own message names the command (`npx playwright install chromium`) and the runner exits `2`.

## Commands

```
node run.mjs --spec <spec.json> --dry-run
node run.mjs --login --base <url> --ready <selector> [--auth <file>]
node run.mjs --spec <spec.json> --base <url> [--out <folder>] [--report <file.md>]
node run.mjs --spec <spec.json> --serve <folder> --out <folder>
node run.mjs --spec <spec.json> --base <url> --headed --case TC-3
```

| Option | Meaning |
|---|---|
| `--spec <file>` | The spec. Required except for `--login` (which may still read `base`, `ready` and `data` from it) |
| `--dry-run` | Validate the spec and list its cases; no browser, no Playwright. Errors exit `2`; warnings are printed and exit `0` |
| `--login` | Open a **visible** browser on the base URL, wait for the person to log in, save the session ([below](#the-human-login)) |
| `--base <url>` | The application's base URL; overrides the spec's `base` (placeholders are filled from `data` and `--var`) |
| `--serve <folder>` | Serve a static folder on `127.0.0.1` (random port) and use it as the base URL - for the example and for static builds. Not with `--base` |
| `--ready <selector>` | The login-ready selector; overrides the spec's `ready` |
| `--out <folder>` | Evidence folder: screenshots and `run-<stamp>.json`. Default: `evidence/` next to the spec |
| `--report <file.md>` | Also write a markdown report shaped like the skill's [report template](../../skills/browser-verification/templates/BROWSER_REPORT.template.md) |
| `--auth <file>` | Session file to save (`--login`) or load (run). Default `~/.engine-kit/browser/state.json`; a run without it, and with no default file, runs with no session |
| `--case <id>` | Run one case |
| `--var NAME=VALUE` | Add or override a `data` value (repeatable); `--var BASE_URL=...` fills the base placeholder |
| `--browser chromium\|firefox\|webkit` | Browser engine (default `chromium`; the others need their binaries installed) |
| `--headed` | Show the browser while it runs |
| `--timeout <ms>` | Default wait for every action and wait step (default `15000`) |
| `--allow-host <host>` | Accept one more host besides localhost (repeatable) - only a registered test host, never production |

### Exit codes

| Code | Meaning | Report written? |
|---|---|---|
| `0` | every case PASS or MANUAL (dry run: no error) | yes |
| `1` | at least one FAIL | yes |
| `2` | bad arguments, an invalid spec, a refused host or path, or a runner error (including missing browser binaries) | no |
| `3` | no FAIL but at least one BLOCKED - or the base URL did not load at all ("is the server up? The runner never starts it") | yes, unless the base URL did not load |
| `4` | Playwright is not installed | no |
| `5` | not logged in: the login-ready selector was not found after loading the base URL | no |

## The human login

1. `node run.mjs --login --base <url> --ready "<selector>"` - the selector is an element
   that exists **only** after a successful login (a user menu, the shell page's content
   frame).
2. A visible browser opens on the base URL. **The person logs in there.** The runner
   prints that it never types credentials and waits up to 10 minutes for the selector.
3. When it appears, the runner saves the browser's storage state (cookies and local
   storage) to the session file and closes the browser. If it never appears: exit `5`,
   nothing saved.
4. Every later run loads that file and checks the same selector on the base URL before
   the first case. Missing means exit `5` and the exact `--login` command to run - not a
   failed case.

**Where the session file lives.** Default: `~/.engine-kit/browser/state.json`
(`%USERPROFILE%\.engine-kit\browser\state.json` on Windows) - in the home folder, outside
every repository. `--auth` may move it; when saving, the runner refuses a path inside the
kit and warns when the folder is under version control (a `.git` or `.svn` above it). It
is a **live
session**: never commit it, never copy it into a work item, delete it when the tests are
done.

## Where everything else goes

- **Nothing is ever written inside the kit.** The runner refuses (exit `2`) an output
  folder, a report or a session file inside it - which is why the kit's own example needs
  `--out <folder outside the kit>`.
- **Evidence**: `<out>/run-<yyyymmdd-hhmmss>.json` (the full run: engine, base URL, served
  folder, spec, session line, every case, summary, exit code), `<out>/<case id>.png` for
  each FAIL, `<out>/<name>.png` for each `screenshot` step.
- **Console**: one JSON object per case (`id`, `title`, `kind`, `mode`, `verdict`,
  `failedStep`, `error`, `readbacks` with `step`, `target`, `expected` and `actual`,
  `consoleErrors`, `failedRequests`, `evidence`, `cleanup`: `none | done | error`,
  `cleanupError`, `warnings`, `durationMs`, and `instructions` for a manual case), then one
  summary object (`summary`, `exitCode`, `report`, `markdown`).
- **Markdown report** (`--report`): run header, verdicts with literal read-backs, findings
  for FAIL and BLOCKED, the manual cases' instructions, console and network, cleanup, spec
  warnings, and the paste block for the closing text. Its Scope line is `case`: it belongs
  to the work item, not to the kit. The agent fills in the build under test.

**Hosts.** The base URL must be `http` or `https` on `localhost`, `127.0.0.1`, `[::1]` or a
`*.localhost` name, or on a host named with `--allow-host`. A `navigate` step to any other
host fails. There is no switch that accepts every host.

## The example

```
node run.mjs --spec example/acme-orders.spec.json --dry-run
node run.mjs --spec example/acme-orders.spec.json --serve example --out <folder outside the kit> --report <folder>/report.md
```

Expected: `TC-1`, `TC-2`, `TC-3` PASS, `TC-4` MANUAL, exit `0`. To see the spec catch a
regression, serve a copy of `example/` in which `parseQuantity` accepts decimals: `TC-2`
fails with the literal read-back `Line added`, a screenshot is taken, and `TC-3` still
counts exactly two lines - the proof that `TC-2`'s cleanup ran after its FAIL.

## Verification (2026-10-21)

What ran, on Windows with Node 22:

- `node --check run.mjs`; `--help`; the example's dry run (4 cases, 0 errors, 0 warnings,
  0 of 22 locators CSS).
- Negative dry runs on deliberately broken specs: invalid JSON, a non-object, empty
  `cases`, wrong top-level types, missing and duplicate ids, a bad `mode`, and one invalid
  form of every step and locator rule - each reported with its case and step, exit `2`;
  the five warnings (no regression control, no assertion, an assertion on typed text, no
  navigation first, a manual case without instructions), exit `0`.
- Argument and guard checks without a browser: unknown option, `--var` without `=`, a
  placeholder base, a non-local host, a non-http scheme, output, report and session paths
  inside the kit, a missing `--auth` file, an unknown `--case`, `--serve` with `--base`, a
  bad `--timeout`, `--login` without `--base` or `--ready` - exit `2`; Playwright missing -
  exit `4`.
- Real runs, headless: **not with Playwright itself** - none was installed on the machine
  and nothing was installed - but with patchright 1.63, an API-compatible Playwright fork
  already on disk, loaded through a scratch shim that also selected the installed full
  Chromium build. The example: 3 PASS, 1 MANUAL, exit `0`. A broken copy of the page:
  `TC-2` FAIL with screenshot, exit `1`, cleanup proven by `TC-3`. Scratch pages: frames
  and `menu`, every action step, `optional` cleanup, BLOCKED before the first action, FAIL
  on a missing action target, failed-request capture and `expect_request` with a status,
  not logged in (exit `5`), connection refused (exit `3`), a native `confirm` answered
  "cancel", `--login` against a local static server with the selector already present
  (session saved, VCS warning shown) and a run that loaded it.
- **Not proven**: the capture of a page script's own `console.error` and of uncaught
  exceptions. Under the fork neither arrived (it turns those events off to avoid bot
  detection); the browser's own "failed to load resource" entry was captured. The first
  run with Playwright itself should repeat the console case. Firefox and WebKit were not
  run; the human login was simulated by a page that was ready at once.

## What stayed in the case it came from

Distilled from one case's web-test runner (a single script with Playwright as a hard
dependency). Left there: the case's shell page and content-frame names, and the "logged
in" check hard-coded on them (now the `ready` selector, data); the URL formula and the
per-version port registry (the case's environment registry gives the base URL); the
menu labels, widget-library, grid and time-field notes (the generic part became the
signals table of the [engines reference](../../skills/browser-verification/references/engines.md));
a post-install step that downloaded a browser, and a session file kept inside the runner's
own folder (now: an optional peer, never installed by the runner, the session outside
every repository); a blanket "allow remote" switch (now one named host at a time); and the
case's own end-to-end suite, whose login helper read credentials from environment
variables (dropped: nothing here reads a credential).

Changes against the source runner: a validator that needs no browser (`--dry-run`), with
the typed-text and regression-control warnings; BLOCKED decided by the kind and position
of the failed step (the source matched words in the error message); every read-back kept
with its expected value (the source kept the last one); `placeholder` and `testid`
locators, locator-level frames, `optional` cleanup steps; visibility assertions that wait;
`--serve`, `--var`, `--report`, `--browser`; exit codes `3`, `4` and `5`; refusal to write
inside the kit.
