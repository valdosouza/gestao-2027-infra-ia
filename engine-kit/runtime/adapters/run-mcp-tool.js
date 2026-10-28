#!/usr/bin/env node
// run-mcp-tool.js - smoke-test one MCP server (and optionally one tool) exactly the way a
// client launches it: command, args, env and cwd come from the client's own config file.
// Node 18+, no dependencies. stdio servers only (newline-delimited JSON-RPC).
//
// Usage:
//   node run-mcp-tool.js --config <client-config.json> <server> [tool] [json-arguments]
//        [--timeout <ms>]
//   e.g. node run-mcp-tool.js --config <workspace>/.mcp.json filesystem
//        node run-mcp-tool.js --config <workspace>/.mcp.json tracker list_projects "{}"
//
//   --config   the client config to read (no machine path is guessed); MCP_CONFIG is the
//              fallback. Both shapes work: "mcpServers" (Claude Code, Claude Desktop, Cursor)
//              and "servers" (VS Code).
//   no tool    initialize + tools/list: prints the tool names (a server-level smoke test).
//   tool       initialize + tools/call: prints the tool's text result.
//   --timeout  milliseconds to wait for each reply (default 60000).
//
// Secrets: env values are passed to the child process only; nothing from env is printed.
// A value still "<CONFIGURE>", "${input:...}" or "{NAME}" is reported by key name: the
// server will most likely not start or not authenticate.
// Exit codes: 0 ok, 1 server/tool failure or timeout, 2 bad arguments or config.
"use strict";
const fs = require("fs");
const path = require("path");
const { spawn } = require("child_process");

const USAGE = "usage: node run-mcp-tool.js --config <client-config.json> <server> [tool] [json-arguments] [--timeout ms]";
function fail(msg, code) { console.error("ERROR  " + msg); process.exit(code || 1); }

let configPath = process.env.MCP_CONFIG || "";
let timeoutMs = 60000;
const pos = [];
const argv = process.argv.slice(2);
for (let i = 0; i < argv.length; i++) {
  const a = argv[i];
  if (a === "--config") configPath = argv[++i] || "";
  else if (a === "--timeout") timeoutMs = parseInt(argv[++i], 10);
  else if (a === "-h" || a === "--help") { console.log(USAGE); process.exit(0); }
  else if (a.startsWith("--")) fail("unknown option " + a + "\n" + USAGE, 2);
  else pos.push(a);
}
const [serverName, toolName, argJson] = pos;
if (!configPath || !serverName || pos.length > 3) fail(USAGE, 2);
if (!(timeoutMs > 0)) fail("--timeout must be a positive number of milliseconds", 2);

// ---------------------------------------------------------------- config
let raw;
try { raw = fs.readFileSync(configPath, "utf8"); } catch (e) { fail("config not readable: " + configPath, 2); }
if (raw.charCodeAt(0) === 0xfeff) raw = raw.slice(1);
let cfg;
try { cfg = JSON.parse(raw); } catch (e) { fail("config is not valid JSON: " + configPath + " (" + e.message + ")", 2); }
const map = cfg.mcpServers || cfg.servers || {};
const srv = map[serverName];
if (!srv) fail(`server '${serverName}' not in ${configPath}; servers: ${Object.keys(map).join(", ") || "(none)"}`, 2);
if (!srv.command) fail(`server '${serverName}' has no command (remote servers are not supported by this smoke test)`, 2);
let toolArgs = {};
if (argJson) { try { toolArgs = JSON.parse(argJson); } catch (e) { fail("json-arguments is not valid JSON: " + e.message, 2); } }

const unresolved = /^<CONFIGURE>$|\$\{input:|(?<!\$)\{[A-Z][A-Z0-9_]*\}/;
for (const [k, v] of Object.entries(srv.env || {})) {
  if (typeof v === "string" && unresolved.test(v)) console.error(`[client] WARN env ${k} is not resolved for a direct launch`);
}
for (const a of [srv.command].concat(srv.args || [], srv.cwd || [])) {
  if (typeof a === "string" && unresolved.test(a)) console.error("[client] WARN command/args/cwd hold an unresolved placeholder");
}

// ---------------------------------------------------------------- launch
// Windows: a .cmd/.bat launcher (npx, uvx) needs cmd.exe; every argument is quoted so that
// characters such as < > & | in an argument (e.g. a version range) are not read as redirections.
function resolveWin(cmd) {
  const exts = (process.env.PATHEXT || ".COM;.EXE;.BAT;.CMD").toLowerCase().split(";").filter(Boolean);
  const hasDir = /[\\/]/.test(cmd);
  const dirs = hasDir ? [""] : [""].concat((process.env.PATH || "").split(";").filter(Boolean));
  for (const dir of dirs) {
    for (const ext of path.extname(cmd) ? [""] : exts) {
      const p = path.join(dir, cmd + ext);
      try { if (fs.statSync(p).isFile()) return p; } catch (e) { /* next */ }
    }
  }
  return cmd;
}
const quoteCmd = (s) => (s === "" || /[\s"&|<>^()%!,;=]/.test(s)) ? '"' + String(s).replace(/"/g, '""') + '"' : s;

let file = srv.command;
let args = (srv.args || []).map(String);
let useShell = false;
if (process.platform === "win32") {
  file = resolveWin(srv.command);
  if (/\.(cmd|bat)$/i.test(file)) {
    useShell = true;
    file = quoteCmd(file);
    args = args.map(quoteCmd);
  }
}
const env = Object.assign({}, process.env, srv.env || {});
const child = spawn(file, args, { env, cwd: srv.cwd || undefined, shell: useShell, windowsHide: true });

let buf = "";
const pending = new Map();
let nextId = 1;
let finished = false;
function finish(code) {
  if (finished) return;
  finished = true;
  try { child.stdin.end(); } catch (e) { /* closed */ }
  try { child.kill(); } catch (e) { /* gone */ }
  process.exit(code);
}
function send(method, params, expectReply) {
  const msg = { jsonrpc: "2.0", method, params };
  if (expectReply) msg.id = nextId++;
  child.stdin.write(JSON.stringify(msg) + "\n");
  if (!expectReply) return Promise.resolve();
  return new Promise((res, rej) => {
    const timer = setTimeout(() => { pending.delete(msg.id); rej(new Error(`${method}: no reply in ${timeoutMs} ms`)); }, timeoutMs);
    pending.set(msg.id, { res: (v) => { clearTimeout(timer); res(v); }, rej: (e) => { clearTimeout(timer); rej(e); } });
  });
}
child.stdout.on("data", (d) => {
  buf += d.toString();
  let i;
  while ((i = buf.indexOf("\n")) >= 0) {
    const line = buf.slice(0, i).trim();
    buf = buf.slice(i + 1);
    if (!line) continue;
    let j;
    try { j = JSON.parse(line); } catch (e) { continue; }
    if (j.method && j.id != null) {
      // a request from the server: answer ping, decline anything else
      const reply = j.method === "ping" ? { jsonrpc: "2.0", id: j.id, result: {} }
        : { jsonrpc: "2.0", id: j.id, error: { code: -32601, message: "not supported by run-mcp-tool" } };
      child.stdin.write(JSON.stringify(reply) + "\n");
    } else if (j.id != null && pending.has(j.id)) {
      const p = pending.get(j.id);
      pending.delete(j.id);
      if (j.error) p.rej(new Error(JSON.stringify(j.error))); else p.res(j.result);
    }
  }
});
child.stderr.on("data", (d) => process.stderr.write("[server] " + d.toString().slice(0, 300)));
child.on("error", (e) => { console.error(`ERROR  cannot start '${srv.command}': ${e.code || e.message}`); finish(1); });
child.on("exit", (c) => { if (!finished) { console.error(`ERROR  server exited with code ${c}`); finish(1); } });

(async () => {
  const init = await send("initialize", { protocolVersion: "2024-11-05", capabilities: {}, clientInfo: { name: "run-mcp-tool", version: "1" } }, true);
  const info = init && init.serverInfo ? `${init.serverInfo.name} ${init.serverInfo.version || ""}`.trim() : "?";
  console.error(`[client] connected to ${info} (protocol ${init && init.protocolVersion})`);
  await send("notifications/initialized", {}, false);
  const t0 = Date.now();
  if (!toolName) {
    const list = await send("tools/list", {}, true);
    const tools = (list && list.tools) || [];
    console.error(`[client] tools/list in ${Date.now() - t0} ms: ${tools.length} tool(s)`);
    for (const t of tools) console.log(t.name);
    finish(0);
    return;
  }
  const result = await send("tools/call", { name: toolName, arguments: toolArgs }, true);
  console.error(`[client] tools/call ${toolName} in ${Date.now() - t0} ms${result.isError ? " (isError)" : ""}`);
  for (const c of result.content || []) {
    if (c.type === "text") console.log(c.text); else console.log(`[${c.type}]`);
  }
  finish(result.isError ? 1 : 0);
})().catch((e) => { console.error("ERROR  " + e.message); finish(1); });
