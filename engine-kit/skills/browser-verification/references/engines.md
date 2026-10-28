# Three engines, one spec (T41)

**Scope**: method

Part of [`browser-verification`](../SKILL.md). The [spec](spec-format.md) says *what* to
check; an engine is *how* the browser is driven. The verdict rules, the read-back rule and
the human login are the same in all three; only the mechanics differ. The report names
the engine used.

| # | Engine | Driven by | Best for | Login |
|---|---|---|---|---|
| 1 | **Built-in browser pane** of the desktop app | the agent, step by step, through the pane's tools | the first verification of a change: the agent sees the page, reads it and reasons about what it finds | the person logs in **in the pane**; the pane keeps its sign-ins between sessions |
| 2 | **The user's Chrome**, through the browser extension | the agent, step by step, in the person's real browser | an application where the person already has a session, or a check that needs the person's real profile | reuses the person's own session; the agent never logs in |
| 3 | **Headless runner** ([`runtime/browser/`](../../../runtime/browser/README.md)) | `run.mjs`, unattended, with Playwright | repeatable re-runs: the same spec after every correction, a regression sweep, a run nobody watches | once, with `--login`: a visible browser opens, the **person** logs in, the runner saves the session to a file outside every repository |

**Choosing.** Use the first that fits and is available; record the choice. An interactive
engine (1 or 2) for the first run of a new spec - it shows what the page really does, and
the spec is corrected from what it shows. The runner (3) once the spec is stable, for every
re-run. A spec that runs green in one engine and red in another is a finding about the
spec (a timing, a frame, a stale session), never a pass.

Tool names in this page are those of the desktop app and the extension at the time of
writing (2026-10); the method does not depend on them. In a session where the browser tools
are deferred, load the whole set in **one** tool search before the first browser step.

## How one spec maps to each engine

| Spec step | Interactive engines (1, 2) | Headless runner (3) |
|---|---|---|
| `navigate` | open `base + path` in the tab (in a shell page: load it into the frame the spec names, or follow the real menu path) | `page.goto`, or the innermost frame's `src` |
| `menu` | find each visible text in the page tree and click it; re-read the page after each click | clicks each text, waits for the frame body |
| locator | find the element in the accessibility tree (`read_page` / `find`) by role and name, label, placeholder, test id, id or text - **never** a coordinate guessed from a screenshot | the matching `getBy*` query |
| `click` | click the element by its reference; read the page again | `locator.click` |
| `fill` | set the form value (`form_input`) | `locator.fill` |
| `type_into`, `type`, `press` | click the field, then real keystrokes / key presses | keyboard typing and presses |
| `select` | set the option (`form_input`) | `selectOption` |
| `wait_for`, `wait_text` | re-read the page until it appears, within a bounded time | `waitFor`, with `--timeout` |
| `expect_value` | read the control's value from the page tree, or with a read-only script (`element.value`) | `inputValue` |
| `expect_text` | read the element's text (`read_page`, `get_page_text`) | `innerText` |
| `expect_count` | count the matches (`find`) | `count` |
| `expect_visible` / `expect_hidden` | read the page tree; re-read within a bounded time | `waitFor` visible / hidden |
| `expect_no_console_errors` | read the console errors (`read_console_messages`, errors only) **for this case's window**: note the last message before the case and judge only the newer ones | console and page-error events since the case started |
| `expect_no_failed_requests`, `expect_request` | read the network requests (`read_network_requests`) for this case's window; status 400 or more, or a network failure | response and request-failed events since the case started |
| `screenshot` | take one, save it under the evidence folder, **look at it before describing it** | `page.screenshot`, full page |
| `cleanup` | run it even after a FAIL; report what it could not remove | the same, each step on its own |

The verdict rules hold unchanged: a precondition that never appears before the first
action is `BLOCKED`; anything else that goes wrong is `FAIL`; the read-back is the literal
string read from the page, never the value typed.

## Engine 1 - the built-in browser pane

- **The login belongs to the pane.** A session is per browser profile: a login done in
  another browser does not reach the pane, and a second login elsewhere may end the
  pane's. If the pane is hidden, ask the person to open it and log in there; after a server
  restart, check whether the pane's session survived before the first case.
- **Read before acting, re-read after every change.** Element references die when the page
  re-renders; a reference from before a navigation is never reused.
- **The first click after a page reload is sometimes not delivered.** Read the state after
  every click; repeat the click only when nothing changed; never chain blind clicks across
  a reload.
- **Coordinates are a last resort.** A screenshot is scaled from the viewport, and the
  viewport changes when the pane is resized. When a click by reference is impossible,
  compute the position from the element's bounding rectangle (inside its frame), scaled by
  screenshot width / window width; scroll a wide container by script before clicking a
  column that is off screen.
- **Messages that slide in** (dialogs, toasts): wait until they have settled before reading
  their buttons; a dialog left open swallows the next click.
- **Storage is not fresh.** Unlike the runner's new context per run, the pane keeps local
  and session storage between cases and runs. Clear it only when a case needs a clean
  state, and say so in the report.
- **Frames.** The page tree walks same-origin frames, so the agent sees inside a shell
  page; the spec still names the frame chain, for the runner.

## Engine 2 - the user's Chrome through the extension

- **The person's browser, the person's session.** Open a **new tab** for the run; never act
  in the person's own tabs, never close a tab the agent did not open.
- Site permissions and any prompt of the extension are answered by the person.
- Everything said for engine 1 about reading, re-reading, coordinates and storage applies
  here too - with more care, because the storage is the person's real one: a case that
  would change data the person depends on runs elsewhere
  ([`disposable-proof`](../../disposable-proof/SKILL.md)).

## Engine 3 - the headless runner

- **Install once per machine, outside any repository**: Playwright is an optional peer of
  the runner and the runner never installs it. In the case this was distilled from, a
  suite installed inside a work item's folder put a dependency folder into the knowledge
  base; the rule became "one tooling folder per machine".
- **Login**: `node run.mjs --login --base <url> --ready <selector>` opens a visible browser;
  the person logs in; the runner waits for the login-ready selector (up to 10 minutes) and
  saves the session to `~/.engine-kit/browser/state.json` (or `--auth <file>`), warning if
  that folder is under version control. Every run loads it and checks the same selector
  before the first case: missing means exit `5`, "log in again", not a failed case.
- **Evidence**: one JSON line per case on the console, `run-<stamp>.json` in the evidence
  folder, a screenshot per `FAIL`, and with `--report <file.md>` a report the agent copies
  into the work item's report. Commands, flags and exit codes:
  [`runtime/browser/README.md`](../../../runtime/browser/README.md).
- **Watch one case**: `--headed --case TC-3`.
- **Fresh state**: every run starts a new browser context (the saved session aside), so
  storage left by a previous run does not leak in - but data saved on the **server** does:
  cleanup steps still matter.

## Native dialogs

`alert`, `confirm` and `prompt` stop a page until someone answers.

- **Headless runner**: dialogs are dismissed, so a `confirm` answers "cancel". A case whose
  path depends on accepting one is `manual` in the spec.
- **Interactive engines**: the pane cannot answer a native dialog. The workaround the case
  used: replace the dialog function on the loaded page only (for example `confirm`
  returning true), keep the click itself real, and **write the deviation in the report** -
  the verdict then covers the click and what follows, not the dialog's own text, which a
  person checks (`MANUAL`).

## Signals that a run is not testing what it should

| Signal | Likely cause | Do |
|---|---|---|
| The fix "does not work" right after a rebuild, yet the code is right | the browser kept the old script (a long cache lifetime under an unchanged version tag) | refresh the cached file, reload, and check a marker of the new code (a new function or constant) before the first case |
| A saved value is missing from the list on the same page | the list was built from data loaded before the save | navigate away and back (or reload) before reading it back |
| A screen opened directly behaves differently from the same screen reached through the menu | the parent page sets state the screen reads | follow the real path when the defect is about that path |
| A caret- or keystroke-dependent defect does not reproduce | `fill` sets the value at once | `type_into`: a click, then real keystrokes |
| A failed request on every case | the application probes an optional service | list it in `ignoreHosts` with the reason; never ignore a host the change uses |
| Green in one engine, red in another | a timing, a frame chain, a stale session, a cached script | investigate; never re-run until green |
