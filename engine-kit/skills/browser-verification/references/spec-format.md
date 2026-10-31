# The browser spec format (T41)

**Scope**: method

Part of [`browser-verification`](../SKILL.md). One JSON file per change, normally
`TESTS/BROWSER_SPEC.json` in the change's folder. The same file is executed by an agent
driving the built-in browser pane or the user's Chrome, and by the headless runner
[`runtime/browser/run.mjs`](../../../runtime/browser/run.mjs), whose validator is the
authority for this page: `node run.mjs --spec <file> --dry-run` checks a spec without a
browser and without Playwright. Keep the spec literal - no scripting, no conditionals, no
loops. A case that needs logic is a `manual` case.

A complete, working example: [acme-orders.spec.json](../../../runtime/browser/example/acme-orders.spec.json),
run against the page next to it.

## Top level

| Key | Type | Required | Meaning |
|---|---|---|---|
| `cases` | array of cases | **yes**, non-empty | executed in order; a `BLOCKED` or `FAIL` case does not stop the run |
| `title` | string | no | the change in one line; heads the runner's report |
| `base` | string | no | the application's base URL. Keep a placeholder (`{BASE_URL}`) in the versioned spec; `--base`, `--var BASE_URL=...` or `--serve` gives the real one. A base still holding a placeholder at run time is an error |
| `ready` | selector string | no | the **login-ready selector**: an element on the top page that exists only after a successful login (or, for a public page, once the application has rendered). `--ready` overrides it |
| `frame` | selector, or array of selectors | no | the default **frame chain** when screens load inside a shell page: every locator and every `navigate` is resolved inside it unless a step or a locator says otherwise |
| `data` | object of named values | no | values the steps reference as `{name}`; `--var NAME=VALUE` adds or overrides one at run time |
| `ignoreHosts` | array of strings | no | URL fragments whose failed requests are known optional probes; they never count for `expect_no_failed_requests` and are left out of the case's failed-request list. Name each one with its reason in the report; never ignore a host the change uses |

Any other top-level key (for example `work_item`) is carried for the reader and ignored by
the runner.

**Placeholders.** `{name}` (letters, digits, underscore) is replaced by the value of that
name in `data`, then `--var`. It works in `base`, in every locator string (`name`, `label`,
`placeholder`, `testid`, `id`, `text`, `css`), in `navigate`, `menu`, `fill` /
`type_into` values, `type`, `select` options, `wait_text`, the `equals` / `contains` of
`expect_value` and `expect_text`, and `expect_request`'s `url_contains`. It does not apply
to `press` keys, the `role` itself, `frame` selectors or numbers. An unknown name stays as
written. The evidence shows the substituted value (`testid=qty-Widget`, not `qty-{item}`).

## Case

| Key | Type | Meaning |
|---|---|---|
| `id` | string, **required**, unique | `TC-1`, `TC-2`, ... - keep the numbering of the change's test plan |
| `title` | string | what the case proves, in one line |
| `kind` | string | free label recorded with the verdict. `fix` for the changed behaviour; **`regression-control`** for the unchanged behaviour the change must not break - the validator warns when no case has it |
| `mode` | `auto` (default) or `manual` | `manual` is recorded as `MANUAL` and handed to a person; its `steps` are not run |
| `instructions` | array of strings | for a `manual` case: the exact steps and the expected result for the tester (a warning when missing) |
| `steps` | array of steps, **required** for `auto`, non-empty | run in order; the first failure ends the case |
| `cleanup` | array of steps | **always** run after `steps`, even after `FAIL` or `BLOCKED`. Each cleanup step is tried on its own; an error is recorded (`cleanup: error` and the message) and never changes the verdict |

Validator warnings (they do not stop a run, but each one is read and either fixed or
explained in the report):

- the first step is not `navigate` or `menu`, so the case depends on where the previous
  one ended;
- the case has no `expect_*` step, so it can never `FAIL` on a wrong result;
- an `expect_value` or `expect_text` expects the very string the same case typed into the
  same element, with no `navigate` or `menu` in between - **never assert text you typed**:
  reload and read it back from where it is stored;
- no case in the spec is a `regression-control`.

## Step

A step is an object with **exactly one action key** and any of four modifiers:

| Modifier | Applies to | Meaning |
|---|---|---|
| `frame` | any step | `"top"` to leave the default frame chain for this step, or another selector / chain |
| `modifiers` | `click` only | keys held during the click: `"ctrl"`, `"shift+alt"` |
| `optional` | **cleanup** steps that take a locator | `true`: the step is skipped when nothing matches (a cleanup that deletes "the line I added" when the case failed before adding it). In `steps` it is an error |
| `note` | any step | free text for the reader; ignored by the runner |

### Locator

Used by `click`, `fill`, `type_into`, `select`, `wait_for` and the element assertions. A
locator is an object with **exactly one** of the keys below - semantic first, so the same
spec survives a restyling - or a plain string, which is read as `css`.

| Key | Finds | Matching |
|---|---|---|
| `role` (+ `name`) | an element by its accessible role and, optionally, its accessible name: `{"role": "button", "name": "Save"}` | `name` matches a substring, case-insensitive, unless `"exact": true` |
| `label` | a form control by its label text (a `<label>`, `aria-label`, `aria-labelledby`) | substring, case-insensitive, unless `"exact": true` |
| `placeholder` | an input by its placeholder | substring, case-insensitive, unless `"exact": true` |
| `testid` | the element whose `data-testid` equals the value | exact |
| `id` | the element whose `id` equals the value (any characters) | exact |
| `text` | an element by its visible text | the whole text, trimmed, case-sensitive; `"exact": false` makes it a case-insensitive substring |
| `css` | a CSS selector - **last resort** | as the selector says |

Locator modifiers: `name` (with `role` only), `exact` (boolean), `nth` (a whole number,
0-based, when several elements match; default: the first), `frame` (`"top"`, a selector or
a chain; it wins over the step's `frame`). The dry run counts the CSS locators: a spec
that is mostly CSS breaks at the first restyling.

### Preconditions

A failure here **before the first action** of the case makes it `BLOCKED` - the screen,
the data or the server was not there, which says nothing about the change. From the first
action on, the same failure is a `FAIL`.

| Step | Effect |
|---|---|
| `{"navigate": "orders.html"}` | load the path, resolved against the base URL (a full URL is used as it is, but only on the base host, localhost or an allowed host). Inside a frame chain it sets the innermost frame's `src` and waits for its body |
| `{"menu": ["Orders", "New order"]}` | click each visible text (whole text, exact) in turn on the top page (or in the step's `frame`), then wait for the body of the default frame chain (or of the page) |
| `{"wait_for": <locator>}` | wait until the element is visible |
| `{"wait_text": "Saved"}` | wait until a visible text containing it (case-insensitive) appears |

### Actions

| Step | Effect |
|---|---|
| `{"click": <locator>}` | click it; `"modifiers": "ctrl"` holds keys |
| `{"fill": {<locator>, "value": "7"}}` | clear the field and set the value (fires input and change) |
| `{"type_into": {<locator>, "value": "520"}}` | click the field, then type key by key - needed when the behaviour depends on the caret or on key events |
| `{"type": "abc"}` | type into whatever has the focus |
| `{"press": "Enter"}` | press a key or a chord: `Enter`, `Tab`, `Escape`, `ctrl+a`, `shift+Tab`. Short names `ctrl`, `control`, `shift`, `alt`, `cmd`, `meta`, `enter`, `tab`, `esc`, `escape`, `backspace`, `delete`, `up`, `down`, `left`, `right`, `home`, `end` (any case); any other name is passed through (`F5`, `PageDown`, `a`) |
| `{"select": {<locator>, "option": "gram"}}` | choose an option of a `<select>` by its value or its visible label |

### Other steps

| Step | Effect |
|---|---|
| `{"wait_ms": 300}` | wait a fixed time, 0 to 60000 ms. The last resort: wait for an element (`wait_for`), a text (`wait_text`) or a request instead |
| `{"screenshot": "TC-1-after-save"}` | save `<evidence folder>/<name>.png`, full page. Name: letters, digits, dot, dash, underscore. Take one for a visual case; a `FAIL` takes its own (`<case id>.png`) |

### Assertions

Every assertion records a **read-back**: the step, the element, the expected value and
the literal value read from the page. A failed assertion is always `FAIL`.

| Step | Passes when | Waits? |
|---|---|---|
| `{"expect_value": {<locator>, "equals": "5:20"}}` | the control's current value (input, textarea, select), trimmed, equals the string | for the element, then reads once |
| `{"expect_text": {<locator>, "equals": "Saved"}}` | the element's rendered text, trimmed, equals the string. `"contains"` instead (or as well) checks a substring, case-sensitive | for the element, then reads once |
| `{"expect_visible": <locator>}` | the element becomes visible | yes, up to the timeout |
| `{"expect_hidden": <locator>}` | the element is hidden **or absent** | yes, up to the timeout |
| `{"expect_count": {<locator>, "equals": 2}}` | the number of matching elements (`nth` ignored) equals the number | **no** - counts at once; put a `wait_for` or `expect_visible` first when the list loads late |
| `{"expect_no_console_errors": true}` | no console error and no uncaught page exception since the case started | no |
| `{"expect_no_failed_requests": true}` | no request since the case started failed at the network level or answered 400 or more, apart from `ignoreHosts` | no |
| `{"expect_request": {"url_contains": "/orders", "status": 201}}` | a request whose URL contains the text was answered with that status since the case started. Without `status`, any request whose URL contains the text counts, **even one that failed** - give the status when the answer matters | **no** - put it after a step that proves the answer arrived (`wait_text`, `wait_for`) |

Even without the console and network assertions, the runner records each case's console
errors and failed requests with its verdict; the report shows them.

**Where to read back.** The value is evidence only where the application **stored** it:
after a reload (`navigate` again), on the record reopened, in the list rebuilt from the
store, or in the answer of the save request (`expect_request` with its status). A value
read from the field the case just typed into proves only that typing works.

## Verdicts

| Verdict | When |
|---|---|
| `PASS` | every step ran and every assertion held |
| `FAIL` | an assertion did not hold, or an action - or a precondition after the first action - could not be done (its target never appeared) |
| `BLOCKED` | a precondition (`navigate`, `menu`, `wait_for`, `wait_text`) could not be done **before the first action** |
| `MANUAL` | `"mode": "manual"` |

The runner's exit code sums the run: `0` every case `PASS` or `MANUAL`, `1` at least one
`FAIL`, `3` no `FAIL` but at least one `BLOCKED`; the other codes are in the
[runner's README](../../../runtime/browser/README.md#exit-codes).

## Limits (what the format cannot express)

- **Native dialogs** (`alert`, `confirm`, `prompt`): the headless runner dismisses them,
  so a `confirm` answers "cancel". A case whose path goes through one is `manual`, or runs
  in an interactive engine with the workaround the
  [engines reference](engines.md#native-dialogs) describes.
- **Files, printing, downloads, e-mail, touch gestures, a second browser window**: `manual`.
- **Waiting for a request**: there is no "wait for request" step; wait for what the
  answer changes on the page.
- **Data setup outside the page** (a database row, a server flag): out of the spec; the
  case lists it as a precondition, and a missing one makes the case `BLOCKED`.
