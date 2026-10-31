# Editor adapters and MCP activation

**Scope**: method

Layer-2 tooling for three techniques of the method:

- **T01 - neutral rules, thin adapters.** `AGENTS.md` is the single source of truth; each AI
  tool gets only a thin mount point that points back to it, and each agent is one
  tool-neutral file from which per-editor stubs are generated.
- **T56 - MCP configuration per environment.** One canonical, secret-free, versioned model;
  one machine-local, never-versioned activation per editor; a merge that keeps local secrets.
- **T91 - tool allow-list per persona.** Every generated stub names its tools explicitly, so a
  client's tool cap can never drop the memory tools in silence.

Every path, name and key comes in as a parameter or from a data file. Nothing here carries
content from a case.

## Scripts and data files

| File | What it does | Inputs | Example |
|---|---|---|---|
| [`gen-agent-stubs.py`](gen-agent-stubs.py) | Generates thin agent stubs from a tool-neutral agents folder: Claude Code `.claude/agents/<name>.md`, VS Code Copilot `.github/agents/<name>.agent.md`. Neutral tool words mapped per editor in a data table; explicit allow-list per persona (T91); never rewrites a hand-made stub (only its `tools:` line); idempotent; `--check` writes nothing and exits 1 naming every stub that would change. Python 3.8+, stdlib only | `--kb-root` or `KB_ROOT`, `--target claude\|copilot\|all`, `--agents-dir` (default `agents`), `--config`, `--claude-out`, `--copilot-out`, `--link-root`, `--check` | `python runtime/adapters/gen-agent-stubs.py --kb-root <kb-root> --config <kb-root>/agent-stubs.json --check` |
| [`merge-mcp-config.js`](merge-mcp-config.js) | Merges the MCP model into one client config: only the servers map is touched, local secrets and local-only servers win, backup before writing, `{NAME}` placeholders resolved, `<CONFIGURE>` never written over a real value; `--format vscode` writes `servers` + `inputs` with `${input:...}` prompts. Node 18+, no dependencies | `<model.json> <client-config.json>`, `--format mcpServers\|vscode`, `--rules`, `--var NAME=VALUE` (else the environment), `--dry-run` | `node runtime/adapters/merge-mcp-config.js <kb-root>/mcp.windows.json <workspace>/.mcp.json --var KB_ROOT=<kb-root> --dry-run` |
| [`run-mcp-tool.js`](run-mcp-tool.js) | Smoke-tests one MCP server the way the client launches it (command, args, env and cwd from the client's own config): `tools/list` without a tool, `tools/call` with one. Never prints env values. Node 18+ | `--config <client-config.json>` (or `MCP_CONFIG`), `<server> [tool] [json-arguments]`, `--timeout` | `node runtime/adapters/run-mcp-tool.js --config <workspace>/.mcp.json filesystem` |
| [`setup-editor.ps1`](setup-editor.ps1) | Per-editor activation from the one model: merges it into the editor's activation file, warns when that file is tracked or not ignored by git/svn, refuses while the client is running (where the client rewrites its config), optionally refreshes that editor's agent stubs. PowerShell 5.1+ | `-Editor claude-code\|claude-desktop\|cursor\|vscode`, `-Model`, `-Target`, `-KbRoot`, `-Rules`, `-Var`, `-ClientProcess`, `-AgentStubs`, `-AgentsDir`, `-StubsConfig`, `-WhatIf` | `powershell -NoProfile -File runtime\adapters\setup-editor.ps1 -Editor vscode -Model <kb-root>\mcp.windows.json -Target <kb-root>\.vscode\mcp.json -KbRoot <kb-root> -WhatIf` |
| [`agent-stubs.example.json`](agent-stubs.example.json) | Example data file for the stub generator: folder layout, memory server and its tools, servers granted to every persona, per-agent defaults and extra tools, extra stub rules | copied into the case | - |
| [`mcp-merge-rules.example.json`](mcp-merge-rules.example.json) | Example server-specific merge rules: `argsWhenEnvSet` (add an auth flag once a token exists) and `retiredServers` (remove a server a decision retired) | copied into the case | - |
| [`mcp.model.template.json`](../../templates/mcp.model.template.json) | The model: three generic servers (filesystem, git, a tracker with a `<CONFIGURE>` token) | copied into the case as one profile per OS | - |

Typical activation targets (always passed as `-Target`): Claude Code `<workspace>/.mcp.json`;
Claude Desktop `<app-data>/Claude/claude_desktop_config.json`; Cursor `<home>/.cursor/mcp.json`
or `<workspace>/.cursor/mcp.json`; VS Code `<workspace>/.vscode/mcp.json`. Skills are linked by
[`sync-skills.ps1`](../sync-skills.ps1), not by these scripts.

## T01 - the adapter family

- `AGENTS.md` ([template](../../templates/AGENTS.template.md)) holds the rules. `CLAUDE.md`,
  `.cursorrules` and `.github/copilot-instructions.md` are mount points: the tool demands them
  at the workspace root, so they stay there, thin, pointing to `AGENTS.md`.
- One agent = one neutral file. Its stubs carry only a pointer to the rules, a pointer to the
  agent, the prepare-only line and the tool allow-list. Content never lives in a stub.
- A new tool joins in one task: its mount point, its line in the root inventory, its column in
  the tool-support matrix. A tool with no adapter still works by the manual path: "read
  `AGENTS.md` and follow it", then point it at the agent or skill file.

### Stub ownership (marker line)

| Marker in the stub | Behaviour |
|---|---|
| `<!-- stub: generated ... -->` | Owned by the generator: rewritten when it differs (line endings ignored, so a CRLF checkout is not a change) |
| `<!-- stub: hand-made -->` | Never rewritten; only its `tools:` line is kept equal to the persona's allow-list (line endings kept). A hand-made stub with no agent file (e.g. one pointing at a skill) takes its allow-list from its data-file entry |
| none | Foreign: reported, never touched. Delete it to let the generator recreate it, or mark it hand-made |

A generated stub whose agent file disappeared is reported as an orphan, never deleted.

## T91 - neutral tool vocabulary

| Word | Claude Code | VS Code Copilot |
|---|---|---|
| `read` | `Read, Grep, Glob` | `read/readFile, read/problems` |
| `search` | `Grep, Glob` | `search/*` built-ins (codebase, file, text, directory, usages, changes) |
| `edit` | `Edit, Write` | `edit/createFile, edit/createDirectory, edit/editFiles` |
| `terminal` | `Bash, PowerShell` | `execute/runInTerminal, execute/getTerminalOutput, read/terminalLastCommand` |
| `task` | `Agent` | `agent/runSubagent` |
| `browser` | the desktop app's built-in browser tools | `browser` |
| `web` | `WebFetch, WebSearch` | `web/fetch` |
| `todo` | none by default (map it in the data file) | `todo` |
| `memory` | `mcp__<server>__<tool>`, one per memory tool | `<server>/<tool>`, one per memory tool |
| server in `servers` | `mcp__<server>__*` | `<server>/*` |

Every persona gets `always` (default `read, search, memory`) plus its own front-matter `tools:`
plus its data-file `extra`, `servers` and `raw` ids. Claude stubs always end with `ToolSearch`
(deferred MCP tools must be loaded before use). The memory tools are named one by one, never
as a whole server: a memory server can expose hundreds of tools, and a client that caps the
tools per request drops the overflow without a warning. An unknown word is reported, not
dropped silently. A data file can override any word per editor (`vocabulary`).

## T56 - MCP activation rules

1. **The model is versioned; the activation is not.** The model (secret-free, placeholders)
   lives in the knowledge base. The activation file that a client reads is resolved for one
   machine - its paths, its executables, sometimes its secrets - and is never versioned. Why:
   a client that loads a workspace file as *project* configuration applies it to every
   developer who opens the workspace; one committed activation from one machine (another OS's
   paths, a different launcher) breaks the servers of everybody else, or leaks a secret.
   `setup-editor.ps1` warns when the activation file is tracked or not ignored.
2. **One profile per OS.** MCP `command`/`args`/`cwd` have no portable variable expansion, and
   operating systems need different launchers and path styles; keep one model per OS (e.g.
   `mcp.windows.json`, `mcp.posix.json`) and pass this machine's profile.
3. **Merge, never overwrite.** Only the servers map is touched (every other key is written back
   as read, including keys that differ only by case); model servers are added or updated;
   local-only servers and local-only env keys are kept; a `<CONFIGURE>` secret in the model
   never overwrites a real local value; other model values win (the model is canonical for
   non-secrets - kit decision EK#11); retired servers are removed only by an explicit rule; a timestamped backup is
   written before any change; an unchanged result writes nothing.
4. **Placeholders.** `{KB_ROOT}` and any `{NAME}` are resolved at activation from `--var`/`-Var`
   or the environment; an unresolved one aborts with nothing written. `${NAME}` is left to the
   client. `<CONFIGURE>` marks a secret: in VS Code it becomes a `${input:...}` prompt (asked
   once per session, never stored); other clients have no prompt, so the merge names each
   remaining `<CONFIGURE>` and the person fills it in the local file only.
5. **Client closed.** A client that keeps its config in memory writes it back while it runs and
   silently undoes the merge: run the activation with the client closed, from a plain terminal
   (inside an AI session, hand the command to the person).
6. **Prove it.** `run-mcp-tool.js` starts the server exactly as configured and lists or calls a
   tool; no secret is printed.

## Dropped as case-only

- Case agent names and their per-agent defaults, and the case's list of per-agent extra tools:
  now entries of the optional data file.
- The case's memory server and its five tool names, and the version-control and tracker
  servers granted to every persona: now `memory` and `servers` in the data file.
- The tracker-specific branch "add an auth flag when a token is set" and the deletion of one
  retired server by name: now rules in the merge-rules file.
- Hard-coded knowledge-base root, organization name and case server list of the MCP profiles;
  the case's working rules in the stub text (its gate numbers, its language rule).
- The discovery of one desktop client's config under a store-package folder (the config path is
  now a parameter), and the call into the case's skill sync from every setup script.
- The root symlink activation: a symlink cannot resolve placeholders and needed an elevated
  terminal; the activation is now a resolved, merged, machine-local file.

## Lineage

Distilled from one case, a multi-developer team knowledge base: two stub generators
(Claude Code and Copilot) merged into one, a Node merge and smoke test, and three per-editor
setup scripts merged into one. Fixes made on the way: the Claude stubs now keep the memory
tools (T91 held only for Copilot); YAML descriptions escape backslashes; a hand-made stub keeps
its line endings; the smoke test honours `cwd`, times out instead of hanging, answers server
pings and quotes arguments for `.cmd` launchers on Windows; the merge lets the model win for
non-secret values (only secrets stay local) and is a no-op when nothing changes.
