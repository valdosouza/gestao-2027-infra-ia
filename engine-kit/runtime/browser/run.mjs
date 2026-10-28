#!/usr/bin/env node
// run.mjs - the headless engine of the browser-verification skill. It executes one
// engine-agnostic spec (JSON) with Playwright and records one verdict per case - PASS,
// FAIL, BLOCKED or MANUAL - with the literal values read back from the page.
// Node 18+. Playwright is an OPTIONAL peer dependency: --dry-run validates a spec without
// it; every other mode prints how to install it and exits 4.
//
// Usage:
//   node run.mjs --spec <spec.json> --dry-run
//   node run.mjs --login --base <url> --ready <selector> [--auth <file>]
//   node run.mjs --spec <spec.json> (--base <url> | --serve <folder>) [--ready <selector>]
//                [--out <folder>] [--report <file.md>] [--auth <file>] [--case <id>]
//                [--browser chromium|firefox|webkit] [--headed] [--timeout <ms>]
//                [--allow-host <host>] [--var NAME=VALUE]
//
// Login is a human step: --login opens a visible browser, the PERSON logs in, the runner
// waits for the login-ready selector and saves the session (storage state) to a local
// file outside every repository. The runner never types, reads or stores a username or a
// password. A run loads that session and checks the same selector before the first case.
//
// Exit codes: 0 every case PASS or MANUAL; 1 at least one FAIL; 3 no FAIL but at least
// one BLOCKED (or the base URL did not load); 2 bad arguments, an invalid spec or a runner
// error; 4 Playwright missing; 5 not logged in (the login-ready selector never appeared).
//
// Spec format: skills/browser-verification/references/spec-format.md

import { createRequire } from 'node:module'
import { createReadStream, existsSync, mkdirSync, readFileSync, statSync, writeFileSync } from 'node:fs'
import { createServer } from 'node:http'
import { homedir } from 'node:os'
import { basename, dirname, extname, join, normalize, resolve, sep } from 'node:path'
import { fileURLToPath } from 'node:url'

const RUNNER_VERSION = '0.1.0'
const here = dirname(fileURLToPath(import.meta.url))
const KIT_ROOT = resolve(here, '..', '..')
const IS_KIT = existsSync(join(KIT_ROOT, '.claude-plugin', 'plugin.json')) && existsSync(join(KIT_ROOT, 'runtime', 'kit_lint.py'))
const DEFAULT_AUTH = join(homedir(), '.engine-kit', 'browser', 'state.json')
const LOGIN_WAIT_MS = 10 * 60 * 1000
const EXIT = { OK: 0, FAIL: 1, USAGE: 2, BLOCKED: 3, NO_PLAYWRIGHT: 4, NOT_LOGGED_IN: 5 }
const USAGE = [
  'usage:',
  '  node run.mjs --spec <spec.json> --dry-run',
  '  node run.mjs --login --base <url> --ready <selector> [--auth <file>]',
  '  node run.mjs --spec <spec.json> (--base <url> | --serve <folder>) [--ready <selector>]',
  '               [--out <folder>] [--report <file.md>] [--auth <file>] [--case <id>]',
  '               [--browser chromium|firefox|webkit] [--headed] [--timeout <ms>]',
  '               [--allow-host <host>] [--var NAME=VALUE]'
].join('\n')

// ---------- spec vocabulary ----------
const LOCATOR_KEYS = ['role', 'label', 'placeholder', 'testid', 'id', 'text', 'css']
const PRECONDITION_STEPS = new Set(['navigate', 'menu', 'wait_for', 'wait_text'])
const ACTION_STEPS = new Set(['click', 'fill', 'type_into', 'type', 'press', 'select'])
const OTHER_STEPS = new Set(['wait_ms', 'screenshot'])
const ASSERT_STEPS = new Set(['expect_value', 'expect_text', 'expect_visible', 'expect_hidden', 'expect_count',
  'expect_no_console_errors', 'expect_no_failed_requests', 'expect_request'])
const LOCATOR_STEPS = new Set(['click', 'fill', 'type_into', 'select', 'wait_for',
  'expect_value', 'expect_text', 'expect_visible', 'expect_hidden', 'expect_count'])
const ALL_STEPS = new Set([...PRECONDITION_STEPS, ...ACTION_STEPS, ...OTHER_STEPS, ...ASSERT_STEPS])
const STEP_MODIFIERS = new Set(['frame', 'modifiers', 'optional', 'note'])
const KEY_NAMES = { ctrl: 'Control', control: 'Control', shift: 'Shift', alt: 'Alt', cmd: 'Meta', meta: 'Meta',
  enter: 'Enter', tab: 'Tab', esc: 'Escape', escape: 'Escape', backspace: 'Backspace', delete: 'Delete',
  up: 'ArrowUp', down: 'ArrowDown', left: 'ArrowLeft', right: 'ArrowRight', home: 'Home', end: 'End' }

// ---------- small helpers ----------
function die(msg, code = EXIT.USAGE) { console.error('ERROR  ' + msg); process.exit(code) }
const isStrArray = (a) => Array.isArray(a) && a.every((x) => typeof x === 'string' && x)
const isFrame = (f) => (typeof f === 'string' && f !== '') || (isStrArray(f) && f.length > 0)
const frameChain = (f) => (Array.isArray(f) ? f : f ? [f] : [])
const firstLine = (s) => String(s ?? '').split('\n')[0].trim()
const safeName = (s) => String(s).replace(/[^A-Za-z0-9._-]/g, '_')
const keyName = (k) => k.split('+').map((p) => KEY_NAMES[p.toLowerCase()] ?? p).join('+')
const camel = (flag) => flag.replace(/^--?/, '').replace(/-([a-z])/g, (m, c) => c.toUpperCase())
const pad = (s, n) => String(s).padEnd(n)
const placeholderLeft = (s) => /\{[A-Za-z_][A-Za-z0-9_]*\}/.test(String(s))

function stepKind(st) {
  if (!st || typeof st !== 'object' || Array.isArray(st)) return null
  const keys = Object.keys(st).filter((k) => !STEP_MODIFIERS.has(k))
  return keys.length === 1 ? keys[0] : null
}

function substitute(s, values) {
  if (typeof s !== 'string') return s
  return s.replace(/\{([A-Za-z_][A-Za-z0-9_]*)\}/g, (m, k) => (Object.prototype.hasOwnProperty.call(values, k) ? String(values[k]) : m))
}

function describe(l) {
  if (l == null) return ''
  if (typeof l === 'string') return 'css=' + l
  const kind = LOCATOR_KEYS.find((k) => l[k] != null) ?? 'css'
  let s = kind + '=' + l[kind]
  if (kind === 'role' && l.name != null) s += ' name="' + l.name + '"'
  if (l.nth != null) s += ' nth=' + l.nth
  if (l.frame != null) s += ' frame=' + JSON.stringify(l.frame)
  return s
}

function locKey(l) {
  if (typeof l === 'string') return JSON.stringify({ css: l })
  const o = {}
  for (const k of ['role', 'name', ...LOCATOR_KEYS.slice(1), 'nth', 'frame']) if (l && l[k] != null) o[k] = l[k]
  return JSON.stringify(o)
}

const norm = (p) => (process.platform === 'win32' ? resolve(p).toLowerCase() : resolve(p))
function insideKit(p) {
  if (!IS_KIT) return false
  const k = norm(KIT_ROOT), t = norm(p)
  return t === k || t.startsWith(k + sep)
}
function guardWrite(p, flag) {
  if (insideKit(p)) die(flag + ' points inside the engine kit (' + KIT_ROOT + '); generated files are written outside the kit')
}
function underVcs(p) {
  let d = resolve(p)
  for (;;) {
    if (existsSync(join(d, '.git')) || existsSync(join(d, '.svn'))) return d
    const up = dirname(d)
    if (up === d) return null
    d = up
  }
}

const LOCAL_HOSTS = new Set(['localhost', '127.0.0.1', '[::1]', '::1'])
function hostAllowed(url, allowHosts) {
  const h = url.hostname.toLowerCase()
  return LOCAL_HOSTS.has(h) || h.endsWith('.localhost') || allowHosts.includes(h)
}
function checkBase(base, allowHosts) {
  let u
  try { u = new URL(base) } catch { die('the base URL is not a valid URL: ' + base) }
  if (!/^https?:$/.test(u.protocol)) die('the base URL must be http or https: ' + base)
  if (!hostAllowed(u, allowHosts)) {
    die('refusing host "' + u.hostname + '": only localhost, or a host you name with --allow-host after checking that it is a registered development or test host (never production)')
  }
  return u
}

// ---------- arguments ----------
function parseArgs(argv) {
  const o = { vars: {}, allowHosts: [] }
  const takesValue = new Set(['--spec', '--base', '--serve', '--ready', '--out', '--report', '--auth', '--case',
    '--browser', '--timeout', '--allow-host', '--var'])
  const flags = new Set(['--dry-run', '--login', '--headed', '--help', '-h'])
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i]
    if (flags.has(a)) { o[a === '-h' ? 'help' : camel(a)] = true; continue }
    if (!takesValue.has(a)) die('unknown option ' + a + '\n' + USAGE)
    const v = argv[++i]
    if (v === undefined) die(a + ' needs a value\n' + USAGE)
    if (a === '--var') {
      const eq = v.indexOf('=')
      if (eq < 1) die('--var needs NAME=VALUE')
      o.vars[v.slice(0, eq)] = v.slice(eq + 1)
    } else if (a === '--allow-host') o.allowHosts.push(v.toLowerCase())
    else o[camel(a)] = v
  }
  return o
}

// ---------- spec validation (no browser needed) ----------
function locatorError(l) {
  if (typeof l === 'string') return l ? null : 'empty css selector'
  if (!l || typeof l !== 'object' || Array.isArray(l)) return 'needs a locator (an object, or a css string)'
  const kinds = LOCATOR_KEYS.filter((k) => l[k] != null)
  if (!kinds.length) return 'a locator needs one of ' + LOCATOR_KEYS.join(', ')
  if (kinds.length > 1) return 'a locator takes one of ' + LOCATOR_KEYS.join(', ') + '; found ' + kinds.join(' + ')
  if (typeof l[kinds[0]] !== 'string' || !l[kinds[0]]) return '"' + kinds[0] + '" must be a non-empty string'
  if (l.name != null && kinds[0] !== 'role') return '"name" goes with "role"'
  if (l.name != null && typeof l.name !== 'string') return '"name" must be a string'
  if (l.nth != null && !(Number.isInteger(l.nth) && l.nth >= 0)) return '"nth" must be a whole number'
  if (l.frame != null && l.frame !== 'top' && !isFrame(l.frame)) return '"frame" must be "top", a selector or an array of selectors'
  return null
}

function checkStep(st, where, errors) {
  if (!st || typeof st !== 'object' || Array.isArray(st)) { errors.push(where + ': a step must be an object'); return null }
  const keys = Object.keys(st).filter((k) => !STEP_MODIFIERS.has(k))
  if (keys.length !== 1) { errors.push(where + ': a step has exactly one action key; found ' + (keys.join(', ') || 'none')); return null }
  const k = keys[0], v = st[k]
  if (!ALL_STEPS.has(k)) { errors.push(where + ': unknown step "' + k + '"'); return null }
  const need = (ok, msg) => { if (!ok) errors.push(where + ' (' + k + '): ' + msg) }
  let css = 0
  if (LOCATOR_STEPS.has(k)) {
    const e = locatorError(v)
    if (e) errors.push(where + ' (' + k + '): ' + e)
    else if (typeof v === 'string' || v.css != null) css = 1
  }
  switch (k) {
    case 'navigate': need(typeof v === 'string' && v !== '', 'needs a path or a URL'); break
    case 'menu': need(isStrArray(v) && v.length > 0, 'needs an array of visible texts'); break
    case 'fill': case 'type_into': need(v && typeof v.value === 'string', 'needs "value" (a string)'); break
    case 'type': need(typeof v === 'string', 'needs a string'); break
    case 'press': need(typeof v === 'string' && v !== '', 'needs a key name'); break
    case 'select': need(v && typeof v.option === 'string', 'needs "option" (a string)'); break
    case 'wait_text': need(typeof v === 'string' && v !== '', 'needs a text'); break
    case 'wait_ms': need(Number.isFinite(v) && v >= 0 && v <= 60000, 'needs milliseconds between 0 and 60000'); break
    case 'screenshot': need(typeof v === 'string' && /^[A-Za-z0-9._-]+$/.test(v), 'needs a file name made of letters, digits, dot, dash or underscore'); break
    case 'expect_value': need(v && typeof v.equals === 'string', 'needs "equals" (a string)'); break
    case 'expect_text': need(v && (typeof v.equals === 'string' || typeof v.contains === 'string'), 'needs "equals" or "contains" (a string)'); break
    case 'expect_count': need(v && Number.isInteger(v.equals) && v.equals >= 0, 'needs "equals" (a whole number)'); break
    case 'expect_request':
      need(v && typeof v.url_contains === 'string' && v.url_contains !== '', 'needs "url_contains"')
      need(!v || v.status == null || Number.isInteger(v.status), '"status" must be a whole number'); break
    case 'expect_no_console_errors': case 'expect_no_failed_requests': need(v === true, 'takes true'); break
    default: break
  }
  if (st.frame != null) need(st.frame === 'top' || isFrame(st.frame), '"frame" must be "top", a selector or an array of selectors')
  if (st.modifiers != null) need(k === 'click' && typeof st.modifiers === 'string', '"modifiers" applies to click only ("ctrl", "shift+alt")')
  if (st.optional != null) need(st.optional === true && LOCATOR_STEPS.has(k), '"optional": true applies to a step with a locator (skipped when nothing matches)')
  return { locs: LOCATOR_STEPS.has(k) ? 1 : 0, css }
}

// "Never assert text you typed": an expect_* on the element this case just typed into,
// expecting the very string typed, proves nothing. Reset by navigate/menu (a reload reads
// the stored value back, which is evidence).
function typedValueWarnings(steps) {
  const out = []
  let typed = new Map(), focus = null
  for (const [i, st] of (steps ?? []).entries()) {
    const k = stepKind(st), v = st && k ? st[k] : undefined
    if (k === 'navigate' || k === 'menu') { typed = new Map(); focus = null; continue }
    if (k === 'click') { focus = locKey(v); continue }
    if ((k === 'fill' || k === 'type_into') && v) { focus = locKey(v); typed.set(focus, String(v.value)); continue }
    if (k === 'type' && focus) { typed.set(focus, (typed.get(focus) ?? '') + String(v)); continue }
    if ((k === 'expect_value' || k === 'expect_text') && v) {
      const want = v.equals ?? v.contains
      const key = locKey(v)
      if (want != null && typed.has(key) && typed.get(key) === want) {
        out.push('step ' + (i + 1) + ' expects "' + want + '", the value this case typed into the same element - read it back from where it is stored (after a reload, from the saved record)')
      }
    }
  }
  return out
}

function validateSpec(spec) {
  const errors = [], warnings = [], notes = []
  if (!spec || typeof spec !== 'object' || Array.isArray(spec)) return { errors: ['the spec is not a JSON object'], warnings, notes }
  if (!Array.isArray(spec.cases) || spec.cases.length === 0) errors.push('"cases" must be a non-empty array')
  if (spec.frame != null && !isFrame(spec.frame)) errors.push('"frame" must be a selector or an array of selectors')
  if (spec.data != null && (typeof spec.data !== 'object' || Array.isArray(spec.data))) errors.push('"data" must be an object of named values')
  if (spec.ignoreHosts != null && !isStrArray(spec.ignoreHosts)) errors.push('"ignoreHosts" must be an array of strings')
  if (spec.ready != null && (typeof spec.ready !== 'string' || !spec.ready)) errors.push('"ready" must be a selector string')
  if (spec.base != null && typeof spec.base !== 'string') errors.push('"base" must be a string (keep a placeholder such as {BASE_URL})')
  const ids = new Set()
  let controls = 0, locs = 0, css = 0
  for (const [n, c] of (Array.isArray(spec.cases) ? spec.cases : []).entries()) {
    const where = 'case ' + (c && typeof c.id === 'string' && c.id ? c.id : '#' + (n + 1))
    if (!c || typeof c !== 'object' || Array.isArray(c)) { errors.push(where + ': not an object'); continue }
    if (typeof c.id !== 'string' || !c.id) errors.push(where + ': "id" is required')
    else if (ids.has(c.id)) errors.push(where + ': duplicate id')
    else ids.add(c.id)
    const mode = c.mode ?? 'auto'
    if (mode !== 'auto' && mode !== 'manual') errors.push(where + ': "mode" must be auto or manual')
    if (c.kind === 'regression-control') controls++
    if (mode === 'manual') {
      if (!isStrArray(c.instructions) || c.instructions.length === 0) warnings.push(where + ': a manual case lists its "instructions" for the tester')
      continue
    }
    if (!Array.isArray(c.steps) || c.steps.length === 0) { errors.push(where + ': "steps" must be a non-empty array'); continue }
    for (const [i, st] of c.steps.entries()) {
      const r = checkStep(st, where + ' step ' + (i + 1), errors)
      if (r) { locs += r.locs; css += r.css }
      if (st && st.optional) errors.push(where + ' step ' + (i + 1) + ': "optional" is for cleanup steps only')
    }
    if (c.cleanup != null) {
      if (!Array.isArray(c.cleanup)) errors.push(where + ': "cleanup" must be an array')
      else for (const [i, st] of c.cleanup.entries()) {
        const r = checkStep(st, where + ' cleanup ' + (i + 1), errors)
        if (r) { locs += r.locs; css += r.css }
      }
    }
    const first = stepKind(c.steps[0])
    if (first && first !== 'navigate' && first !== 'menu') warnings.push(where + ': does not start with navigate or menu, so it depends on where the previous case ended')
    if (!c.steps.some((s) => ASSERT_STEPS.has(stepKind(s)))) warnings.push(where + ': has no expect_* step, so it can never FAIL on a wrong result')
    for (const w of typedValueWarnings(c.steps)) warnings.push(where + ': ' + w)
  }
  if (!controls) warnings.push('no case has "kind": "regression-control" - add the unchanged behaviour the change must not break')
  if (locs) notes.push(css + ' of ' + locs + ' locator(s) are css (semantic first: role, label, placeholder, testid, id, text)')
  return { errors, warnings, notes }
}

// ---------- Playwright (optional peer dependency) ----------
function loadPlaywright() {
  const roots = [process.env.PLAYWRIGHT_FROM, process.cwd(), here].filter(Boolean)
  for (const root of roots) {
    const req = createRequire(join(resolve(root), 'noop.js'))
    let mod
    try { mod = req('playwright') } catch (e) {
      if (e && e.code === 'MODULE_NOT_FOUND' && String(e.message).includes("'playwright'")) continue
      throw e
    }
    let version = 'unknown'
    try { version = req('playwright/package.json').version } catch { /* exports may hide it */ }
    return { pw: mod, version }
  }
  console.error([
    'Playwright is not installed. It is an optional peer dependency of this runner, and the',
    'runner never installs anything. Install it yourself, once, in a tooling folder outside',
    'any repository you version:',
    '  npm install playwright',
    '  npx playwright install chromium',
    'then run from that folder, or set PLAYWRIGHT_FROM to it (NODE_PATH works too).',
    'Without Playwright, --dry-run still validates a spec, and the built-in browser or the',
    'browser extension can execute the same spec (skills/browser-verification).'
  ].join('\n'))
  process.exit(EXIT.NO_PLAYWRIGHT)
}

function browserType(pw, name) {
  const n = name ?? 'chromium'
  if (!['chromium', 'firefox', 'webkit'].includes(n)) die('--browser must be chromium, firefox or webkit')
  if (!pw[n]) die('this Playwright has no ' + n)
  return { type: pw[n], name: n }
}

// ---------- static server for --serve (example pages, static builds) ----------
const MIME = { '.html': 'text/html; charset=utf-8', '.htm': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8',
  '.mjs': 'text/javascript; charset=utf-8', '.css': 'text/css; charset=utf-8', '.json': 'application/json; charset=utf-8',
  '.svg': 'image/svg+xml', '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.gif': 'image/gif',
  '.ico': 'image/x-icon', '.txt': 'text/plain; charset=utf-8' }

function serveFolder(dir) {
  const root = resolve(dir)
  let ok = false
  try { ok = statSync(root).isDirectory() } catch { ok = false }
  if (!ok) die('--serve needs a folder: ' + dir)
  const server = createServer((req, res) => {
    if (req.method !== 'GET' && req.method !== 'HEAD') { res.writeHead(405); res.end(); return }
    let file
    try { file = normalize(join(root, decodeURIComponent(new URL(req.url, 'http://127.0.0.1').pathname))) } catch { res.writeHead(400); res.end(); return }
    if (file !== root && !file.startsWith(root + sep)) { res.writeHead(403); res.end(); return }
    let st = null
    try { st = statSync(file); if (st.isDirectory()) { file = join(file, 'index.html'); st = statSync(file) } } catch { st = null }
    if (!st || !st.isFile()) { res.writeHead(404, { 'content-type': 'text/plain' }); res.end('not found'); return }
    res.writeHead(200, { 'content-type': MIME[extname(file).toLowerCase()] ?? 'application/octet-stream', 'content-length': st.size, 'cache-control': 'no-store' })
    if (req.method === 'HEAD') { res.end(); return }
    createReadStream(file).pipe(res)
  })
  return new Promise((done, fail) => { server.once('error', fail); server.listen(0, '127.0.0.1', () => done(server)) })
}

// ---------- step executor ----------
function makeExecutor({ page, spec, values, consoleLog, requestLog, outDir, base, allowHosts }) {
  const sub = (s) => substitute(s, values)
  // Evidence names the element actually located: placeholders filled in.
  const shown = (l) => describe(typeof l === 'string' ? sub(l)
    : Object.fromEntries(Object.entries(l).map(([k, x]) => [k, typeof x === 'string' ? sub(x) : x])))
  const defaultChain = frameChain(spec.frame)
  const chainOf = (f) => (f === 'top' ? [] : f != null ? frameChain(f) : defaultChain)
  const scope = (f) => chainOf(f).reduce((acc, sel) => acc.frameLocator(sel), page)
  const ignoreHosts = spec.ignoreHosts ?? []
  const failedSince = (t0) => requestLog.filter((x) => x.t >= t0 && (x.status === 'failed' || x.status >= 400) && !ignoreHosts.some((h) => x.url.includes(h)))
  const assertion = (msg) => Object.assign(new Error(msg), { assertion: true })

  function locate(l, frameOverride, all) {
    if (typeof l === 'string') l = { css: l }
    const s = scope(l.frame ?? frameOverride)
    let r
    if (l.role) r = s.getByRole(l.role, l.name != null ? { name: sub(l.name), exact: l.exact ?? false } : {})
    else if (l.label) r = s.getByLabel(sub(l.label), { exact: l.exact ?? false })
    else if (l.placeholder) r = s.getByPlaceholder(sub(l.placeholder), { exact: l.exact ?? false })
    else if (l.testid) r = s.getByTestId(sub(l.testid))
    else if (l.id) r = s.locator('[id="' + sub(l.id).replace(/\\/g, '\\\\').replace(/"/g, '\\"') + '"]')
    else if (l.text) r = s.getByText(sub(l.text), { exact: l.exact ?? true })
    else r = s.locator(sub(l.css))
    if (all) return r
    return l.nth != null ? r.nth(l.nth) : r.first()
  }

  function check(state, kind, target, expected, actual, ok) {
    state.readbacks.push({ step: kind, target: target ? shown(target) : null, expected, actual })
    if (!ok) throw assertion(kind + (target ? ' ' + shown(target) : '') + ': expected ' + expected + ', read back "' + actual + '"')
  }

  async function navigate(path, f) {
    const target = sub(path)
    const url = new URL(target, base)
    if (!hostAllowed(url, allowHosts) && url.host !== new URL(base).host) throw new Error('navigate refused: ' + url.host + ' is neither the base host nor an allowed host')
    const chain = chainOf(f)
    if (!chain.length) { await page.goto(url.href); return }
    const parent = chain.slice(0, -1).reduce((acc, sel) => acc.frameLocator(sel), page)
    await parent.locator(chain[chain.length - 1]).first().evaluate((el, u) => { el.src = u }, url.href)
    await page.waitForTimeout(300)
    await scope(f).locator('body').waitFor()
  }

  async function step(st, state) {
    const k = stepKind(st), v = st[k]
    if (st.optional && LOCATOR_STEPS.has(k) && (await locate(v, st.frame, true).count()) === 0) return 'skipped'
    switch (k) {
      case 'navigate': return navigate(v, st.frame)
      case 'menu':
        for (const item of v) { await scope(st.frame ?? 'top').getByText(sub(item), { exact: true }).first().click(); await page.waitForTimeout(300) }
        await scope().locator('body').waitFor(); return
      case 'click': return locate(v, st.frame).click(st.modifiers ? { modifiers: st.modifiers.split('+').map(keyName) } : {})
      case 'fill': return locate(v, st.frame).fill(sub(v.value))
      case 'type_into': await locate(v, st.frame).click(); return page.keyboard.type(sub(v.value))
      case 'type': return page.keyboard.type(sub(v))
      case 'press': return page.keyboard.press(keyName(v))
      case 'select': return locate(v, st.frame).selectOption(sub(v.option))
      case 'wait_for': return locate(v, st.frame).waitFor()
      case 'wait_text': return scope(st.frame).getByText(sub(v)).first().waitFor()
      case 'wait_ms': return page.waitForTimeout(v)
      case 'screenshot': {
        const p = join(outDir, safeName(v) + '.png')
        await page.screenshot({ path: p, fullPage: true }); state.evidence.push(p); return
      }
      case 'expect_value': {
        const a = (await locate(v, st.frame).inputValue()).trim(), want = sub(v.equals)
        return check(state, k, v, want, a, a === want)
      }
      case 'expect_text': {
        const a = (await locate(v, st.frame).innerText()).trim()
        if (v.equals != null) check(state, k, v, sub(v.equals), a, a === sub(v.equals))
        if (v.contains != null) check(state, k, v, 'contains ' + sub(v.contains), a, a.includes(sub(v.contains)))
        return
      }
      case 'expect_visible': {
        let vis = true
        try { await locate(v, st.frame).waitFor({ state: 'visible' }) } catch { vis = false }
        return check(state, k, v, 'visible', vis ? 'visible' : 'not visible', vis)
      }
      case 'expect_hidden': {
        let hidden = true
        try { await locate(v, st.frame).waitFor({ state: 'hidden' }) } catch { hidden = false }
        return check(state, k, v, 'hidden', hidden ? 'hidden' : 'visible', hidden)
      }
      case 'expect_count': {
        const n = await locate(v, st.frame, true).count()
        return check(state, k, v, String(v.equals), String(n), n === v.equals)
      }
      case 'expect_no_console_errors': {
        const e = consoleLog.filter((x) => x.t >= state.t0).map((x) => x.text)
        return check(state, k, null, 'no console error', e.length ? e.join(' | ') : 'none', e.length === 0)
      }
      case 'expect_no_failed_requests': {
        const e = failedSince(state.t0).map((x) => x.status + ' ' + x.url)
        return check(state, k, null, 'no failed request', e.length ? e.join(' | ') : 'none', e.length === 0)
      }
      case 'expect_request': {
        const want = sub(v.url_contains)
        const r = requestLog.find((x) => x.t >= state.t0 && x.url.includes(want) && (v.status == null || x.status === v.status))
        return check(state, k, null, 'a request containing ' + want + (v.status != null ? ' with status ' + v.status : ''), r ? r.status + ' ' + r.url : 'none', !!r)
      }
      default: throw new Error('unknown step: ' + k)
    }
  }

  async function runCase(c) {
    const out = { id: c.id, title: c.title ?? '', kind: c.kind ?? null, mode: c.mode ?? 'auto', verdict: 'PASS',
      failedStep: null, error: null, readbacks: [], consoleErrors: [], failedRequests: [], evidence: [],
      cleanup: 'none', cleanupError: null, warnings: typedValueWarnings(c.steps), durationMs: 0 }
    if (out.mode === 'manual') { out.verdict = 'MANUAL'; out.instructions = c.instructions ?? []; return out }
    const t0 = Date.now()
    const state = { t0, readbacks: out.readbacks, evidence: out.evidence }
    let acted = false
    for (const [i, st] of c.steps.entries()) {
      const k = stepKind(st)
      try {
        if (ACTION_STEPS.has(k)) acted = true
        await step(st, state)
      } catch (e) {
        // Before the first action, a precondition that never appears is BLOCKED; from the
        // first action on, and for every action or assertion, a failure is FAIL.
        out.verdict = PRECONDITION_STEPS.has(k) && !acted && !e.assertion ? 'BLOCKED' : 'FAIL'
        out.failedStep = { index: i + 1, step: k, target: LOCATOR_STEPS.has(k) ? shown(st[k]) : (typeof st[k] === 'string' ? sub(st[k]) : null) }
        out.error = firstLine(e.message)
        if (out.verdict === 'FAIL') {
          const p = join(outDir, safeName(c.id) + '.png')
          try { await page.screenshot({ path: p, fullPage: true }); out.evidence.push(p) } catch { /* the page may be gone */ }
        }
        break
      }
    }
    if (Array.isArray(c.cleanup) && c.cleanup.length) {
      out.cleanup = 'done'
      const cstate = { t0, readbacks: [], evidence: out.evidence }
      for (const st of c.cleanup) {
        try { await step(st, cstate) } catch (e) {
          out.cleanup = 'error'
          out.cleanupError = (out.cleanupError ? out.cleanupError + ' | ' : '') + stepKind(st) + ': ' + firstLine(e.message)
        }
      }
    }
    out.consoleErrors = consoleLog.filter((x) => x.t >= t0).map((x) => x.text)
    out.failedRequests = failedSince(t0).map((x) => x.status + ' ' + x.url + (x.failure ? ' (' + x.failure + ')' : ''))
    out.durationMs = Date.now() - t0
    return out
  }

  return { runCase }
}

// ---------- reports ----------
function stamp(d) {
  const z = (n) => String(n).padStart(2, '0')
  return d.getFullYear() + z(d.getMonth() + 1) + z(d.getDate()) + '-' + z(d.getHours()) + z(d.getMinutes()) + z(d.getSeconds())
}
const md = (s) => String(s ?? '').replace(/\r?\n/g, ' ').replace(/\|/g, '\\|').replace(/`/g, "'")

function markdownReport(r) {
  const day = r.started.slice(0, 10)
  const L = []
  L.push('# Runner report - ' + md(r.title ?? 'spec') + ' - ' + day, '')
  L.push('**Scope**: case', '')
  L.push('Written by the headless runner of the browser-verification skill. The agent copies the', 'verdicts into the test report and fills the build under test.', '')
  L.push('## Run header', '', '| Item | Value |', '|---|---|')
  L.push('| Engine | ' + md(r.engine) + ' |')
  L.push('| Base URL | `' + md(r.base) + '`' + (r.served ? ' (served from `' + md(r.served) + '`)' : '') + ' |')
  L.push('| Spec | `' + md(r.spec) + '` |')
  L.push('| Login-ready selector | ' + (r.ready ? '`' + md(r.ready) + '`' : 'none') + ' |')
  L.push('| Session | ' + md(r.session) + ' |')
  L.push('| Started / finished | ' + r.started + ' / ' + r.finished + ' |')
  L.push('| Build under test | <revision + locally modified files - filled by the agent> |', '')
  L.push('## Verdicts', '', '| Case | Kind | Verdict | Read back (literal) | Expected | Evidence |', '|---|---|---|---|---|---|')
  for (const c of r.cases) {
    const rb = c.readbacks.filter((x) => x.target)
    const read = rb.length ? rb.map((x) => '`' + md(x.actual) + '` in ' + md(x.target)).join('; ') : '-'
    const exp = rb.length ? rb.map((x) => '`' + md(x.expected) + '`').join('; ') : '-'
    const ev = [c.evidence.map((p) => '`' + md(basename(p)) + '`').join(', '),
      c.consoleErrors.length ? c.consoleErrors.length + ' console error(s)' : 'console clean',
      c.failedRequests.length ? c.failedRequests.length + ' failed request(s)' : 'network clean'].filter(Boolean).join('; ')
    L.push('| ' + md(c.id) + ' | ' + md(c.kind ?? '-') + ' | ' + c.verdict + ' | ' + read + ' | ' + exp + ' | ' + (c.mode === 'manual' ? 'handed to a tester' : ev) + ' |')
  }
  L.push('')
  const bad = r.cases.filter((c) => c.verdict === 'FAIL' || c.verdict === 'BLOCKED')
  L.push('## Findings (FAIL / BLOCKED only)', '')
  if (!bad.length) L.push('None.', '')
  for (const c of bad) {
    L.push('### ' + md(c.id) + ' - ' + c.verdict + ' - ' + md(c.title), '')
    if (c.failedStep) L.push('- **Step**: ' + c.failedStep.index + ' `' + c.failedStep.step + '`' + (c.failedStep.target ? ' on `' + md(c.failedStep.target) + '`' : ''))
    L.push('- **Observed**: ' + md(c.error))
    for (const x of c.readbacks) L.push('- **Read back**: `' + md(x.actual) + '`' + (x.target ? ' in ' + md(x.target) : '') + ' (expected `' + md(x.expected) + '`)')
    L.push('')
  }
  const manual = r.cases.filter((c) => c.verdict === 'MANUAL')
  if (manual.length) {
    L.push('## Manual cases (handed to a tester)', '')
    for (const c of manual) {
      L.push('### ' + md(c.id) + ' - ' + md(c.title), '')
      for (const line of c.instructions ?? []) L.push('- ' + md(line))
      if (!(c.instructions ?? []).length) L.push('- (the spec lists no instructions)')
      L.push('')
    }
  }
  L.push('## Console / network', '')
  const cons = r.cases.filter((c) => c.consoleErrors.length), net = r.cases.filter((c) => c.failedRequests.length)
  L.push('- Console errors: ' + (cons.length ? cons.map((c) => md(c.id) + ': ' + c.consoleErrors.map(md).join(' / ')).join('; ') : 'none'))
  L.push('- Failed requests: ' + (net.length ? net.map((c) => md(c.id) + ': ' + c.failedRequests.map(md).join(' / ')).join('; ') : 'none'), '')
  L.push('## Cleanup', '')
  for (const c of r.cases) if (c.cleanup !== 'none') L.push('- ' + md(c.id) + ': ' + c.cleanup + (c.cleanupError ? ' - ' + md(c.cleanupError) : ''))
  if (!r.cases.some((c) => c.cleanup !== 'none')) L.push('- No case had a cleanup.')
  const warned = r.cases.filter((c) => c.warnings.length)
  if (warned.length) {
    L.push('', '## Spec warnings', '')
    for (const c of warned) for (const w of c.warnings) L.push('- ' + md(c.id) + ': ' + md(w))
  }
  L.push('', '## Paste block for closing', '', '```')
  L.push('**Test focus** (verified ' + day + ', headless runner, <build under test>)')
  for (const c of r.cases) {
    const rb = c.readbacks.filter((x) => x.target)
    const lit = rb.length ? ': read back `' + rb.map((x) => x.actual.replace(/\r?\n/g, ' ')).join('`, `') + '`' : ''
    L.push('- ' + c.id + ' ' + c.verdict + ' - ' + (c.title ?? '').replace(/\r?\n/g, ' ') + lit)
  }
  L.push('```', '')
  return L.join('\n')
}

// ---------- modes ----------
function dryRun(spec, specPath, o) {
  if (!spec) die('--dry-run needs --spec <file>')
  const { errors, warnings, notes } = validateSpec(spec)
  console.log('spec   ' + specPath)
  console.log('base   ' + (o.base ?? spec.base ?? '(none)') + '   ready ' + (o.ready ?? spec.ready ?? '(none)') + '   frame ' + JSON.stringify(spec.frame ?? null))
  for (const c of Array.isArray(spec.cases) ? spec.cases : []) {
    if (!c || typeof c !== 'object') continue
    const steps = Array.isArray(c.steps) ? c.steps.length : 0, cleanup = Array.isArray(c.cleanup) ? c.cleanup.length : 0
    console.log('case   ' + pad(c.id ?? '?', 8) + ' ' + pad(c.mode ?? 'auto', 7) + ' ' + pad(c.kind ?? '-', 19) + ' ' + pad(steps + ' step(s), ' + cleanup + ' cleanup', 22) + ' ' + (c.title ?? ''))
  }
  for (const n of notes) console.log('note   ' + n)
  for (const w of warnings) console.log('WARN   ' + w)
  for (const e of errors) console.log('ERROR  ' + e)
  console.log('dry run: ' + errors.length + ' error(s), ' + warnings.length + ' warning(s); no browser was opened')
  return errors.length ? EXIT.USAGE : EXIT.OK
}

async function login(spec, o) {
  const values = { ...(spec && spec.data ? spec.data : {}), ...o.vars }
  const base = substitute(o.base ?? (spec ? spec.base : undefined), values)
  if (!base || placeholderLeft(base)) die('--login needs --base <url>')
  checkBase(base, o.allowHosts)
  const ready = o.ready ?? (spec ? spec.ready : undefined)
  if (!ready) die('--login needs --ready <selector>: an element that exists only after a successful login')
  const authPath = resolve(o.auth ?? DEFAULT_AUTH)
  guardWrite(authPath, '--auth')
  const vcs = underVcs(dirname(authPath))
  if (vcs) console.error('WARN   the session file will be inside a version-controlled folder (' + vcs + '): keep it ignored and never commit it')
  const { pw, version } = loadPlaywright()
  const engine = browserType(pw, o.browser)
  const browser = await engine.type.launch({ headless: false })
  try {
    const ctx = await browser.newContext()
    const page = await ctx.newPage()
    await page.goto(base)
    console.log('A browser window is open on ' + base + '. Log in there yourself - the runner never types credentials.')
    console.log('Waiting up to ' + LOGIN_WAIT_MS / 60000 + ' minutes for the login-ready selector ' + ready + ' ...')
    try { await page.locator(ready).first().waitFor({ state: 'attached', timeout: LOGIN_WAIT_MS }) } catch {
      console.error('ERROR  the login-ready selector never appeared; nothing was saved')
      return EXIT.NOT_LOGGED_IN
    }
    mkdirSync(dirname(authPath), { recursive: true })
    await ctx.storageState({ path: authPath })
    console.log('Session saved to ' + authPath + ' (Playwright ' + version + ', ' + engine.name + ').')
    console.log('It is a live session: keep it out of every repository and delete it when the tests are done.')
    return EXIT.OK
  } finally {
    await browser.close()
  }
}

async function run(spec, specPath, o) {
  const { errors, warnings } = validateSpec(spec)
  if (errors.length) {
    for (const e of errors) console.error('ERROR  ' + e)
    die('the spec is invalid (' + errors.length + ' error(s)); --dry-run lists them without a browser')
  }
  for (const w of warnings) console.error('WARN   ' + w)
  const values = { ...(spec.data ?? {}), ...o.vars }
  const cases = spec.cases.filter((c) => !o.case || c.id === o.case)
  if (!cases.length) die('no case with id "' + o.case + '"')
  if (o.serve && o.base) die('use --base or --serve, not both')
  let base = null
  if (!o.serve) {
    base = substitute(o.base ?? spec.base, values)
    if (!base || placeholderLeft(base)) die('a base URL is required: --base <url> or --serve <folder> (the spec keeps the placeholder ' + (spec.base ?? '{BASE_URL}') + ')')
    checkBase(base, o.allowHosts)
  }
  const outDir = resolve(o.out ?? join(dirname(specPath), 'evidence'))
  if (insideKit(outDir)) die('the output folder ' + outDir + ' is inside the engine kit; pass --out <folder outside the kit>')
  if (o.report) guardWrite(resolve(o.report), '--report')
  const authPath = resolve(o.auth ?? DEFAULT_AUTH)
  if (o.auth && !existsSync(authPath)) die('--auth file not found: ' + authPath)
  const ready = o.ready ?? spec.ready ?? null
  const timeout = o.timeout != null ? Number(o.timeout) : 15000
  if (!Number.isFinite(timeout) || timeout <= 0) die('--timeout needs milliseconds')
  const { pw, version } = loadPlaywright()
  const engine = browserType(pw, o.browser)
  let server = null
  if (o.serve) {
    server = await serveFolder(o.serve)
    base = 'http://127.0.0.1:' + server.address().port + '/'
  }
  mkdirSync(outDir, { recursive: true })
  const session = existsSync(authPath) ? 'storage state loaded from ' + authPath : 'none'
  const started = new Date()
  const results = []
  let browser = null
  try {
    browser = await engine.type.launch({ headless: !o.headed })
    const ctx = await browser.newContext(existsSync(authPath) ? { storageState: authPath } : {})
    const page = await ctx.newPage()
    page.setDefaultTimeout(timeout)
    const consoleLog = [], requestLog = []
    page.on('console', (m) => { if (m.type() === 'error') consoleLog.push({ t: Date.now(), text: m.text() }) })
    page.on('pageerror', (e) => consoleLog.push({ t: Date.now(), text: 'uncaught: ' + e.message }))
    page.on('requestfailed', (r) => requestLog.push({ t: Date.now(), url: r.url(), status: 'failed', failure: (r.failure() || {}).errorText || '' }))
    page.on('response', (r) => requestLog.push({ t: Date.now(), url: r.url(), status: r.status() }))
    try { await page.goto(base) } catch (e) {
      console.error('ERROR  ' + base + ' did not load (' + firstLine(e.message) + '). Is the server up? The runner never starts it.')
      return EXIT.BLOCKED
    }
    if (ready) {
      try { await page.locator(ready).first().waitFor({ state: 'attached', timeout }) } catch {
        console.error('ERROR  not logged in: the login-ready selector ' + ready + ' was not found on ' + page.url() + '.')
        console.error('       The login is a human step: node run.mjs --login --base ' + base + ' --ready "' + ready + '"')
        return EXIT.NOT_LOGGED_IN
      }
    }
    const ex = makeExecutor({ page, spec, values, consoleLog, requestLog, outDir, base, allowHosts: o.allowHosts })
    for (const c of cases) {
      const r = await ex.runCase(c)
      results.push(r)
      console.log(JSON.stringify(r))
    }
  } finally {
    if (browser) await browser.close()
    if (server) server.close()
  }
  const summary = { PASS: 0, FAIL: 0, BLOCKED: 0, MANUAL: 0 }
  for (const r of results) summary[r.verdict]++
  const exitCode = summary.FAIL ? EXIT.FAIL : summary.BLOCKED ? EXIT.BLOCKED : EXIT.OK
  const report = { runner: 'engine-kit browser runner ' + RUNNER_VERSION,
    engine: 'headless runner (Playwright ' + version + ', ' + engine.name + (o.headed ? ', headed' : '') + ')',
    started: started.toISOString(), finished: new Date().toISOString(), base, served: o.serve ? resolve(o.serve) : null,
    spec: specPath, title: spec.title ?? null, ready, session, cases: results, summary, exitCode }
  const jsonPath = join(outDir, 'run-' + stamp(started) + '.json')
  writeFileSync(jsonPath, JSON.stringify(report, null, 2) + '\n')
  let mdPath = null
  if (o.report) {
    mdPath = resolve(o.report)
    mkdirSync(dirname(mdPath), { recursive: true })
    writeFileSync(mdPath, markdownReport(report))
  }
  console.log(JSON.stringify({ summary, exitCode, report: jsonPath, markdown: mdPath }))
  return exitCode
}

async function main() {
  const o = parseArgs(process.argv.slice(2))
  if (o.help) { console.log(USAGE); return EXIT.OK }
  let spec = null, specPath = null
  if (o.spec) {
    specPath = resolve(o.spec)
    let text
    try { text = readFileSync(specPath, 'utf8') } catch { die('cannot read the spec: ' + specPath) }
    try { spec = JSON.parse(text.replace(/^\uFEFF/, '')) } catch (e) { die('the spec is not valid JSON: ' + firstLine(e.message)) }
  }
  if (o.dryRun) return dryRun(spec, specPath, o)
  if (o.login) return login(spec, o)
  if (!spec) die('--spec <file> is required\n' + USAGE)
  return run(spec, specPath, o)
}

main().then((code) => process.exit(code ?? EXIT.OK), (e) => {
  console.error('ERROR  runner error: ' + (e && e.stack ? e.stack : e))
  process.exit(EXIT.USAGE)
})
