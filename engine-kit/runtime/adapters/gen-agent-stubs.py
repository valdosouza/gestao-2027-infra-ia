#!/usr/bin/env python3
"""gen-agent-stubs - thin per-editor agent stubs from one tool-neutral agents folder.

Every agent is ONE tool-neutral markdown file (default <kb-root>/agents/<name>.md) whose
front matter declares its tools in a neutral vocabulary:

    ---
    name: "Docs Writer"
    description: "Use when ..."
    tools: [read, search, edit, memory]
    argument-hint: "Which module?"
    ---

For each editor this script writes a thin stub that points back to AGENTS.md and to the
agent file (technique T01: the neutral file is the truth, adapters only point to it):

    claude   -> <kb-root>/.claude/agents/<name>.md        (Claude Code subagent)
    copilot  -> <kb-root>/.github/agents/<name>.agent.md  (VS Code Copilot custom agent)

Tool allow-list per persona (technique T91): every stub carries an explicit `tools:` list
mapped from the neutral words through the EDITORS table below. A client with a tool cap
(VS Code Copilot drops tools past its per-request limit, silently) then never loses the
memory tools: they are named one by one, never as a whole large server.

Stub ownership, read from a marker line in the stub:
    <!-- stub: generated ... -->  owned by this script: rewritten whenever it differs
    <!-- stub: hand-made ... -->  never rewritten; only its `tools:` line is kept equal to
                                  the persona's allow-list (T91 holds for hand-made stubs too)
    no marker                     foreign: reported, never touched (delete it to let the
                                  script recreate it, or mark it hand-made)
A hand-made stub with no agent file (e.g. one that points at a skill) still gets its
allow-list, from its entry in the data file.

Case-specific content (agent defaults, memory server, MCP servers granted to every
persona, extra stub rules, folder layout) lives in an optional JSON data file (--config);
see agent-stubs.example.json next to this script. Nothing case-specific lives here.

Usage:
  python gen-agent-stubs.py --kb-root <kb-root> [--target claude|copilot|all]
         [--agents-dir agents] [--config <data.json>] [--claude-out DIR] [--copilot-out DIR]
         [--link-root <root-as-seen-by-the-editor>] [--check]

  --kb-root     default: KB_ROOT.
  --link-root   write absolute pointers (<link-root>/AGENTS.md) instead of workspace-
                relative ones; needed when the stubs are linked into a user-level folder
                (e.g. by sync-skills.ps1) and used outside the knowledge-base workspace.
  --check       writes nothing; exit 1 if any stub would be created or changed.
Idempotent: a second run reports 0 changes. Exit codes: 0 ok, 1 changes in --check mode
or an error, 2 bad arguments. Python 3.8+, standard library only.
"""
import argparse
import glob
import io
import json
import os
import re
import sys

# ---------------------------------------------------------------- editor data table
# Neutral vocabulary -> editor tool ids. A data file can override or extend any entry
# ("vocabulary": {"claude": {"todo": ["TodoWrite"]}}). "memory" and MCP servers are
# filled from the data file ("memory", "servers").
CLAUDE_BROWSER = [
    # built-in browser pane of the Claude desktop app
    "mcp__Claude_Browser__navigate", "mcp__Claude_Browser__preview_start", "mcp__Claude_Browser__read_page",
    "mcp__Claude_Browser__find", "mcp__Claude_Browser__get_page_text", "mcp__Claude_Browser__computer",
    "mcp__Claude_Browser__form_input", "mcp__Claude_Browser__read_console_messages",
    "mcp__Claude_Browser__read_network_requests", "mcp__Claude_Browser__javascript_tool",
    "mcp__Claude_Browser__tabs_context", "mcp__Claude_Browser__browser_batch",
]
EDITORS = {
    "claude": {
        "label": "Claude Code",
        "out": ".claude/agents",
        "suffix": ".md",
        "vocab": {
            "read": ["Read", "Grep", "Glob"],
            "search": ["Grep", "Glob"],
            "edit": ["Edit", "Write"],
            "terminal": ["Bash", "PowerShell"],
            "task": ["Agent"],
            "browser": CLAUDE_BROWSER,
            "web": ["WebFetch", "WebSearch"],
            "todo": [],            # not every build exposes a todo tool; map it in the data file
            "memory": [],          # from the data file: one entry per memory tool
        },
        "mcp_tool": "mcp__{server}__{tool}",
        "mcp_server": "mcp__{server}__*",
        "append": ["ToolSearch"],  # deferred MCP tools must be loaded before use
        "tools_style": "csv",
    },
    "copilot": {
        "label": "Copilot",
        "out": ".github/agents",
        "suffix": ".agent.md",
        "vocab": {
            "read": ["read/readFile", "read/problems"],
            "search": ["search/codebase", "search/fileSearch", "search/textSearch", "search/listDirectory",
                       "search/usages", "search/changes"],
            "edit": ["edit/createFile", "edit/createDirectory", "edit/editFiles"],
            "terminal": ["execute/runInTerminal", "execute/getTerminalOutput", "read/terminalLastCommand"],
            "task": ["agent/runSubagent"],
            "browser": ["browser"],
            "web": ["web/fetch"],
            "todo": ["todo"],
            "memory": [],
        },
        "mcp_tool": "{server}/{tool}",
        "mcp_server": "{server}/*",
        "append": [],
        "tools_style": "list",
    },
}
DEFAULT_ALWAYS = ["read", "search", "memory"]
DEFAULT_RULES = [
    "Prepare-only: never commit, merge, deploy or write to an external system (tracker, chat, "
    "mail); prepare the text or the command, and the human executes it.",
    "Keep the gates and the never-do list of the rules file; when the two files disagree, the "
    "rules file wins and the disagreement is reported.",
]
CLAUDE_RULES = ["Load deferred MCP tools with `ToolSearch` before calling them."]
SKIP_FILES = {"readme.md", "index.md"}
MARKER_RE = re.compile(r"<!--\s*stub:\s*(generated|hand-made)\b")
GENERATED_MARKER = ('<!-- stub: generated by gen-agent-stubs.py (to keep hand edits in this file, '
                    'change "generated" to "hand-made") -->')


def warn(msg):
    sys.stderr.write("WARN   " + msg + "\n")


def die(msg, code=2):
    sys.stderr.write("ERROR  " + msg + "\n")
    sys.exit(code)


# ---------------------------------------------------------------- reading
def read_text(path):
    # newline="" keeps CRLF as is: a hand-made stub keeps its own line endings
    with io.open(path, encoding="utf-8-sig", newline="") as handle:
        return handle.read()


def parse_front(text):
    """Flat key: value front matter; supports quoted values and > / | block scalars."""
    m = re.match(r"^---\r?\n(.*?)\r?\n---", text, re.S)
    if not m:
        return {}
    fm, lines, i = {}, m.group(1).splitlines(), 0
    while i < len(lines):
        mm = re.match(r"^([A-Za-z_-]+):\s*(.*)$", lines[i])
        i += 1
        if not mm:
            continue
        key, val = mm.group(1), mm.group(2).strip()
        if val in (">", "|", ">-", "|-"):
            block = []
            while i < len(lines) and (lines[i].startswith((" ", "\t")) or not lines[i].strip()):
                block.append(lines[i].strip())
                i += 1
            val = " ".join(b for b in block if b)
        elif len(val) >= 2 and val[0] == val[-1] and val[0] in "\"'":
            val = val[1:-1]
        fm[key] = val
    return fm


def scope_of(text):
    m = re.search(r"\*\*Scope\*\*:\s*(\w+)", text)
    return m.group(1) if m else "mixed"


def first_paragraph(text):
    body = re.sub(r"^---\r?\n.*?\r?\n---\r?\n", "", text, count=1, flags=re.S)
    for para in re.split(r"\r?\n\s*\r?\n", body):
        p = para.strip()
        if p and not p.startswith(("#", "**", "<!--", ">", "|", "-", "```")):
            return re.sub(r"\s+", " ", p)[:240]
    return ""


def yaml_quote(value):
    value = re.sub(r"\s+", " ", value).strip()
    return '"' + value.replace("\\", "\\\\").replace('"', "'") + '"'


# ---------------------------------------------------------------- configuration
def load_config(path):
    if not path:
        return {}
    if not os.path.isfile(path):
        die("data file not found: %s" % path)
    try:
        data = json.loads(read_text(path))
    except ValueError as exc:
        die("data file is not valid JSON: %s (%s)" % (path, exc))
    if not isinstance(data, dict):
        die("data file must hold a JSON object: %s" % path)
    return data


def editor_table(cfg, editor):
    table = dict(EDITORS[editor])
    vocab = {k: list(v) for k, v in table["vocab"].items()}
    for word, ids in (cfg.get("vocabulary", {}).get(editor, {}) or {}).items():
        vocab[word] = list(ids)
    mem = cfg.get("memory") or {}
    if mem.get("server") and mem.get("tools"):
        vocab["memory"] = [table["mcp_tool"].format(server=mem["server"], tool=t) for t in mem["tools"]]
    table["vocab"] = vocab
    return table


def allow_list(editor, table, words, servers, raw):
    out, unknown = [], []

    def add(item):
        if item and item not in out:
            out.append(item)

    for word in words:
        if word not in table["vocab"]:
            unknown.append(word)
            continue
        for item in table["vocab"][word]:
            add(item)
    for server in servers:
        add(table["mcp_server"].format(server=server))
    for item in raw:
        add(item)
    for item in table["append"]:
        add(item)
    return out, unknown


def tools_line(table, tools):
    if table["tools_style"] == "csv":
        return "tools: " + ", ".join(tools)
    return "tools: [" + ", ".join("'%s'" % t for t in tools) + "]"


# ---------------------------------------------------------------- stub text
def pointer(editor, kb_root, link_root, stub_dir, rel_target):
    rel_target = rel_target.replace("\\", "/")
    if link_root:
        target = link_root.rstrip("/\\").replace("\\", "/") + "/" + rel_target
        return ("#file:" + target) if editor == "copilot" else ("`" + target + "`")
    if editor == "copilot":
        rel = os.path.relpath(os.path.join(kb_root, rel_target), stub_dir).replace("\\", "/")
        return "[%s](%s)" % (rel_target, rel)
    return "`" + rel_target + "`"


def render(editor, table, slug, meta, tools, rules_ptr, agent_ptr, extra_rules):
    title = meta.get("name") or slug.replace("-", " ").title()
    rules = list(DEFAULT_RULES) + (CLAUDE_RULES if editor == "claude" else []) + list(extra_rules)
    lines = ["---", "name: " + slug, "description: " + yaml_quote(meta.get("description", "")),
             tools_line(table, tools)]
    if editor == "claude":
        lines.append("model: inherit")
    lines += ["---", GENERATED_MARKER, "**Scope**: " + meta.get("scope", "mixed"), "",
              "# %s (%s stub)" % (title, table["label"]), "",
              "Thin adapter: the agent itself is the tool-neutral file below. Read both files first and",
              "follow them literally. Nothing agent-specific lives in this stub; the agent file is the",
              "single source of truth and the next run of `gen-agent-stubs.py` rewrites this stub.", "",
              "- **Rules:** " + rules_ptr,
              "- **Agent:** " + agent_ptr, "",
              "Working rules for every stub:"]
    lines += ["- " + r for r in rules]
    hint = meta.get("argument-hint", "")
    if editor == "copilot":
        lines += ["", "Usage: `@%s` in Copilot Chat with the knowledge base open as the workspace." % slug]
    if hint:
        lines += ["", "First question the agent asks: " + hint]
    return "\n".join(lines) + "\n"


def refresh_tools(data, want):
    """Return the hand-made stub with its tools: line set to `want` (EOL kept), or None."""
    eol = "\r\n" if "\r\n" in data else "\n"
    lines = data.split(eol)
    if not lines or lines[0].strip() != "---" or "---" not in [l.strip() for l in lines[1:]]:
        return None
    end = 1 + [l.strip() for l in lines[1:]].index("---")
    for i in range(1, end):
        if lines[i].startswith("tools:"):
            if lines[i] == want:
                return data
            lines[i] = want
            return eol.join(lines)
    at = next((i for i in range(1, end) if lines[i].startswith("description:")), end - 1)
    lines.insert(at + 1, want)
    return eol.join(lines)


def write(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with io.open(path, "w", encoding="utf-8", newline="") as handle:
        handle.write(text)


# ---------------------------------------------------------------- main
def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--kb-root", dest="kb_root", default=None)
    ap.add_argument("--target", choices=["claude", "copilot", "all"], default="all")
    ap.add_argument("--agents-dir", default=None)
    ap.add_argument("--config", default=None)
    ap.add_argument("--claude-out", default=None)
    ap.add_argument("--copilot-out", default=None)
    ap.add_argument("--link-root", default=None)
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args(argv)

    kb_root = args.kb_root or os.environ.get("KB_ROOT")
    if not kb_root:
        die("no knowledge-base root: pass --kb-root or set KB_ROOT")
    kb_root = os.path.abspath(kb_root)
    if not os.path.isdir(kb_root):
        die("knowledge-base root not found: %s" % kb_root)

    cfg = load_config(args.config)

    def under_root(value, default):
        value = value or default
        return os.path.normpath(value if os.path.isabs(value) else os.path.join(kb_root, value))

    agents_dir = under_root(args.agents_dir or cfg.get("agents_dir"), "agents")
    if not os.path.isdir(agents_dir):
        die("agents folder not found: %s (use --agents-dir)" % agents_dir)
    rules_rel = cfg.get("rules_file", "AGENTS.md")
    if not os.path.isfile(os.path.join(kb_root, rules_rel)):
        warn("rules file not found under the root: %s (the stubs point to it anyway)" % rules_rel)
    always = cfg.get("always", DEFAULT_ALWAYS)
    servers_all = cfg.get("servers", [])
    agent_cfg = cfg.get("agents", {}) or {}
    extra_rules = cfg.get("stub_rules", [])
    outs = {"claude": args.claude_out or cfg.get("claude_out"), "copilot": args.copilot_out or cfg.get("copilot_out")}
    editors = ["claude", "copilot"] if args.target == "all" else [args.target]

    agents = {}
    for path in sorted(glob.glob(os.path.join(agents_dir, "*.md"))):
        name = os.path.basename(path)
        if name.lower() in SKIP_FILES or name.startswith("_"):
            continue
        agents[name[:-3]] = path

    changes, warnings = [], 0
    mem = cfg.get("memory") or {}
    if "memory" in always and not (mem.get("server") and mem.get("tools")):
        print("note   no memory server in the data file: the word 'memory' maps to no tool")

    def persona(slug, fm):
        c = agent_cfg.get(slug, {}) or {}
        words = list(always) + re.findall(r"[a-z]+", fm.get("tools", c.get("tools", "")) or "") + list(c.get("extra", []))
        return words, list(servers_all) + list(c.get("servers", [])), c

    for editor in editors:
        table = editor_table(cfg, editor)
        out_dir = under_root(outs[editor], table["out"])
        rel_agents = os.path.relpath(agents_dir, kb_root).replace("\\", "/")
        if rel_agents.startswith(".."):
            warn("agents folder is outside the root; pointers use its relative path %s" % rel_agents)
        seen = set()
        for slug, path in agents.items():
            text = read_text(path)
            fm = parse_front(text)
            words, servers, c = persona(slug, fm)
            meta = {k: v for k, v in c.items() if k in ("name", "description", "argument-hint") and v}
            meta.update({k: v for k, v in fm.items() if v})
            if not meta.get("description"):
                meta["description"] = first_paragraph(text)
            meta["scope"] = scope_of(text)
            tools, unknown = allow_list(editor, table, words, servers, (c.get("raw", {}) or {}).get(editor, []))
            for u in unknown:
                warn("%s: unknown tool word '%s' (not in the %s vocabulary) - not mapped" % (slug, u, editor))
                warnings += 1
            stub = os.path.join(out_dir, slug + table["suffix"])
            seen.add(os.path.normcase(stub))
            stub_dir = os.path.dirname(stub)
            body = render(editor, table, slug, meta, tools,
                          pointer(editor, kb_root, args.link_root, stub_dir, rules_rel),
                          pointer(editor, kb_root, args.link_root, stub_dir, rel_agents + "/" + slug + ".md"),
                          extra_rules)
            current = read_text(stub) if os.path.exists(stub) else None
            if current is None:
                changes.append(("create", editor, slug, stub, body))
                continue
            marker = MARKER_RE.search(current)
            if not marker:
                warn("%s %s: no stub marker - foreign file, left untouched: %s" % (editor, slug, stub))
                warnings += 1
            elif marker.group(1) == "hand-made":
                new = refresh_tools(current, tools_line(table, tools))
                if new is None:
                    warn("%s %s: hand-made stub without front matter, left untouched" % (editor, slug))
                    warnings += 1
                elif new != current:
                    changes.append(("tools", editor, slug, stub, new))
            elif current.replace("\r\n", "\n") != body:
                # compared without CR: a checkout that converts to CRLF is not a change
                changes.append(("update", editor, slug, stub, body))
        # stubs with no agent file: hand-made ones keep their allow-list, generated ones are orphans
        if os.path.isdir(out_dir):
            for stub in sorted(glob.glob(os.path.join(out_dir, "*" + table["suffix"]))):
                if os.path.normcase(stub) in seen:
                    continue
                if editor == "claude" and stub.endswith(".agent.md"):
                    continue
                slug = os.path.basename(stub)[: -len(table["suffix"])]
                current = read_text(stub)
                marker = MARKER_RE.search(current)
                if marker and marker.group(1) == "hand-made":
                    words, servers, c = persona(slug, {})
                    tools, _ = allow_list(editor, table, words, servers, (c.get("raw", {}) or {}).get(editor, []))
                    new = refresh_tools(current, tools_line(table, tools))
                    if new is not None and new != current:
                        changes.append(("tools", editor, slug, stub, new))
                elif marker:
                    warn("%s %s: generated stub without an agent file (orphan) - not deleted: %s" % (editor, slug, stub))
                    warnings += 1

    for kind, editor, slug, stub, text in changes:
        print("%-7s%-8s %s" % (kind, editor, slug))
        if not args.check:
            write(stub, text)
    verb = " would be made" if args.check else ""
    print("agent stubs: %d change(s)%s, %d warning(s) [%s; %d agent(s) in %s]"
          % (len(changes), verb, warnings, ", ".join(editors), len(agents), agents_dir))
    return 1 if (args.check and changes) else 0


if __name__ == "__main__":
    sys.exit(main())
