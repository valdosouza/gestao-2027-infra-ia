#!/usr/bin/env node
// merge-mcp-config.js - merge a canonical, secret-free MCP model into one client config
// (engine-kit runtime, technique T56). Node 18+, no dependencies.
//
// Usage:
//   node merge-mcp-config.js <model.json> <client-config.json>
//        [--format mcpServers|vscode] [--rules <rules.json>] [--var NAME=VALUE ...] [--dry-run]
//
//   --format mcpServers  (default) the "mcpServers" map used by Claude Code (.mcp.json),
//                        Claude Desktop and Cursor.
//   --format vscode      the VS Code shape: "servers" (each with "type") + "inputs"; every
//                        "<CONFIGURE>" secret becomes a ${input:<server>-<key>} prompt and an
//                        "inputs" entry (promptString, password), so no secret is ever written.
//   --rules FILE         server-specific merge rules (see mcp-merge-rules.example.json):
//                        "argsWhenEnvSet" and "retiredServers".
//   --var NAME=VALUE     value of a {NAME} placeholder (repeatable); otherwise read from the
//                        environment. ${NAME} (client-side expansion) is left alone.
//   --dry-run            print what would change and write nothing.
//
// Merge rules:
//   - ONLY the servers map (and, for vscode, "inputs") is touched; every other key of the
//     client config is written back unchanged (JSON.parse keeps case-duplicate keys that some
//     clients store, which PowerShell 5.1's ConvertFrom-Json rejects).
//   - every model server is added or updated; servers that exist only locally are kept.
//   - secrets: an env/headers value that is "<CONFIGURE>" in the model never overwrites a real
//     local value (local secrets win); env/headers keys that exist only locally are kept; every
//     other model value wins (the model is canonical for non-secrets).
//   - placeholders are resolved before the merge; an unresolved {NAME} aborts with nothing written.
//   - a timestamped backup (<config>.bak-<stamp>) is written before the file is changed; an
//     unchanged result writes nothing.
//   - any value still "<CONFIGURE>" is reported (name only): that server will not authenticate.
//   - no value of env, headers or a secret is ever printed - names only.
// Run it with the client CLOSED: some clients keep their config in memory and write it back.
// Exit codes: 0 done (or nothing to do), 1 error, 2 bad arguments.
"use strict";
const fs = require("fs");
const path = require("path");

const PLACEHOLDER = "<CONFIGURE>";
const SECRET_MAPS = ["env", "headers"];
const VSCODE_KEYS = ["type", "command", "args", "env", "envFile", "cwd", "url", "headers"];
const USAGE = "usage: node merge-mcp-config.js <model.json> <client-config.json> " +
  "[--format mcpServers|vscode] [--rules FILE] [--var NAME=VALUE ...] [--dry-run]";

function fail(msg, code) { console.error("ERROR  " + msg); process.exit(code || 1); }

// ---------------------------------------------------------------- arguments
const opts = { format: "mcpServers", rules: null, vars: {}, dryRun: false, positional: [] };
const argv = process.argv.slice(2);
for (let i = 0; i < argv.length; i++) {
  const a = argv[i];
  if (a === "--dry-run") opts.dryRun = true;
  else if (a === "--format") opts.format = argv[++i];
  else if (a === "--rules") opts.rules = argv[++i];
  else if (a === "--var") {
    const kv = argv[++i] || "";
    const eq = kv.indexOf("=");
    if (eq < 1) fail("--var needs NAME=VALUE", 2);
    opts.vars[kv.slice(0, eq)] = kv.slice(eq + 1);
  } else if (a === "-h" || a === "--help") { console.log(USAGE); process.exit(0); }
  else if (a.startsWith("--")) fail("unknown option " + a + "\n" + USAGE, 2);
  else opts.positional.push(a);
}
const [modelPath, configPath] = opts.positional;
if (!modelPath || !configPath || opts.positional.length > 2) fail(USAGE, 2);
if (!["mcpServers", "vscode"].includes(opts.format)) fail("--format must be mcpServers or vscode", 2);
const KEY = opts.format === "vscode" ? "servers" : "mcpServers";

// ---------------------------------------------------------------- helpers
function readJson(p, label) {
  let raw;
  try { raw = fs.readFileSync(p, "utf8"); } catch (e) { fail(label + " not readable: " + p); }
  const bom = raw.charCodeAt(0) === 0xfeff;
  if (bom) raw = raw.slice(1);
  try { return { data: JSON.parse(raw), bom, raw }; } catch (e) { fail(label + " is not valid JSON: " + p + " (" + e.message + ")"); }
}
const clone = (o) => JSON.parse(JSON.stringify(o));
const isReal = (v) => typeof v === "string" ? v.trim() !== "" && v !== PLACEHOLDER : v != null;
const isObj = (o) => o && typeof o === "object" && !Array.isArray(o);

function lookupVar(name, warned) {
  if (Object.prototype.hasOwnProperty.call(opts.vars, name)) return opts.vars[name];
  if (process.env[name]) return process.env[name];
  return undefined;
}

// {NAME} placeholders in every string of a server entry; ${NAME} is client-side expansion.
function resolve(value, where, missing, warned) {
  if (typeof value === "string") {
    return value.replace(/(?<!\$)\{([A-Z][A-Z0-9_]*)\}/g, (m, name) => {
      const v = lookupVar(name, warned);
      if (v === undefined) { missing.add(name + " (" + where + ")"); return m; }
      return v;
    });
  }
  if (Array.isArray(value)) return value.map((v) => resolve(v, where, missing, warned));
  if (isObj(value)) {
    const out = {};
    for (const [k, v] of Object.entries(value)) out[k] = resolve(v, where, missing, warned);
    return out;
  }
  return value;
}

function hasSequence(args, seq) {
  for (let i = 0; i + seq.length <= args.length; i++) {
    if (seq.every((s, j) => args[i + j] === s)) return true;
  }
  return false;
}

// ---------------------------------------------------------------- load
const model = readJson(modelPath, "model").data;
if (!isObj(model.mcpServers)) fail("model has no \"mcpServers\" object: " + modelPath);
let rules = { argsWhenEnvSet: [], retiredServers: [] };
if (opts.rules) rules = Object.assign(rules, readJson(opts.rules, "rules").data);

let config = {};
let bom = false;
let originalText = null;
const exists = fs.existsSync(configPath);
if (exists) {
  const r = readJson(configPath, "client config");
  if (!isObj(r.data)) fail("client config is not a JSON object: " + configPath);
  config = r.data;
  bom = r.bom;
  originalText = r.raw;
  if (opts.format === "mcpServers" && !config.mcpServers && config.servers) {
    console.log("WARN   the client config has \"servers\" and no \"mcpServers\": a VS Code file? (use --format vscode)");
  }
}
if (!isObj(config[KEY])) config[KEY] = {};
const local = config[KEY];

// ---------------------------------------------------------------- resolve placeholders
const missing = new Set();
const warned = new Set();
const servers = {};
for (const [name, canon] of Object.entries(model.mcpServers)) {
  servers[name] = { canon, resolved: resolve(clone(canon), name, missing, warned) };
}
if (missing.size) fail("unresolved placeholder(s), nothing written: " + [...missing].join(", ") +
  " - pass --var NAME=VALUE or set the environment variable");

// ---------------------------------------------------------------- merge
const plan = [];
const inputsWanted = [];
for (const [name, { canon, resolved }] of Object.entries(servers)) {
  let merged = resolved;
  if (opts.format === "vscode") {
    const entry = { type: merged.type || (merged.url ? "http" : "stdio") };
    const dropped = [];
    for (const [k, v] of Object.entries(merged)) {
      if (VSCODE_KEYS.includes(k)) entry[k] = v; else dropped.push(k);
    }
    if (dropped.length) plan.push(`note   ${name}: key(s) not in the VS Code format, not written: ${dropped.join(", ")}`);
    merged = entry;
  }
  const loc = local[name];
  for (const map of SECRET_MAPS) {
    const canonMap = isObj(canon[map]) ? canon[map] : {};
    const locMap = loc && isObj(loc[map]) ? loc[map] : {};
    if (opts.format === "vscode" && isObj(merged[map])) {
      for (const [k, v] of Object.entries(merged[map])) {
        if (v === PLACEHOLDER && !isReal(locMap[k])) {
          const id = (name + "-" + k).toLowerCase().replace(/_/g, "-");
          merged[map][k] = "${input:" + id + "}";
          inputsWanted.push({ id, type: "promptString", description: name + ": " + k, password: true });
        }
      }
    }
    for (const [k, lv] of Object.entries(locMap)) {
      if (!isObj(merged[map])) merged[map] = {};
      if (!(k in canonMap)) {
        merged[map][k] = lv;                       // local-only key: kept
      } else if (canonMap[k] === PLACEHOLDER) {
        if (isReal(lv)) { merged[map][k] = lv; plan.push(`keep   ${name}.${map}.${k}: local secret kept`); }
      } else if (JSON.stringify(merged[map][k]) !== JSON.stringify(lv)) {
        plan.push(`model  ${name}.${map}.${k}: model value replaces the local one`);
      }
    }
  }
  for (const rule of rules.argsWhenEnvSet || []) {
    if (rule.server !== name || !Array.isArray(rule.args) || !rule.args.length) continue;
    const v = merged.env && merged.env[rule.env];
    if (!isReal(v)) continue;
    merged.args = Array.isArray(merged.args) ? merged.args : [];
    if (!hasSequence(merged.args, rule.args) && !merged.args.includes(rule.args[0])) {
      merged.args.push(...rule.args);
      plan.push(`rule   ${name}: ${rule.env} is set, args += ${rule.args.join(" ")}`);
    }
  }
  const action = !loc ? "add" : JSON.stringify(loc) === JSON.stringify(merged) ? "same" : "update";
  plan.push(`${action.padEnd(6)} ${name}`);
  local[name] = merged;
}
for (const r of rules.retiredServers || []) {
  if (r && r.server && local[r.server] && !(r.server in servers)) {
    delete local[r.server];
    plan.push(`retire ${r.server}: ${r.reason || "retired by the merge rules"}`);
  }
}
for (const name of Object.keys(local)) {
  if (!(name in servers)) plan.push(`local  ${name}: not in the model, kept`);
}
if (opts.format === "vscode" && inputsWanted.length) {
  if (!Array.isArray(config.inputs)) config.inputs = [];
  const used = JSON.stringify(local);
  for (const inp of inputsWanted) {
    if (used.includes("${input:" + inp.id + "}") && !config.inputs.some((x) => x && x.id === inp.id)) {
      config.inputs.push(inp);
      plan.push(`input  ${inp.id}: prompted by the client, never stored`);
    }
  }
}
for (const [name, srv] of Object.entries(local)) {
  for (const map of SECRET_MAPS) {
    for (const [k, v] of Object.entries((srv && isObj(srv[map]) && srv[map]) || {})) {
      if (v === PLACEHOLDER) plan.push(`WARN   ${name}.${map}.${k} is still ${PLACEHOLDER}: the server will not authenticate - set it locally`);
    }
  }
  for (const a of (srv && Array.isArray(srv.args) && srv.args) || []) {
    if (a === PLACEHOLDER) plan.push(`WARN   ${name}.args holds ${PLACEHOLDER}: secrets belong in env, not in args`);
  }
}

// ---------------------------------------------------------------- write
const out = JSON.stringify(config, null, 2) + "\n";
const changed = !exists || originalText.replace(/\r\n/g, "\n") !== out;
for (const line of plan) console.log(line);
if (!changed) { console.log(`no change: ${configPath}`); process.exit(0); }
if (opts.dryRun) { console.log(`dry run: ${configPath} would be ${exists ? "updated (after a backup)" : "created"}; nothing written`); process.exit(0); }
if (exists) {
  const stamp = new Date().toISOString().replace(/[:T]/g, "-").slice(0, 19);
  let backup = `${configPath}.bak-${stamp}`;
  for (let n = 1; fs.existsSync(backup); n++) backup = `${configPath}.bak-${stamp}-${n}`;
  fs.copyFileSync(configPath, backup);
  console.log(`backup ${backup}`);
} else {
  fs.mkdirSync(path.dirname(path.resolve(configPath)), { recursive: true });
}
fs.writeFileSync(configPath, (bom ? "\ufeff" : "") + out, "utf8");
console.log(`merged ${Object.keys(servers).length} model server(s) into ${configPath} (${KEY}: ${Object.keys(local).join(", ")})`);
