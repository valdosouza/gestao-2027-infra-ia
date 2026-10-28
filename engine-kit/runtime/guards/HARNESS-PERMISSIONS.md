# Harness permissions - the "ask list"

**Scope**: method

**Technique**: T29, prepare-only for the irreversible (maturity `proven`: two cases). The
written rule lives in the case's `AGENTS.md`; this page is its executable twin.

## The rule

The agent **prepares** every irreversible or outward operation - the commit message, the
merge, the deploy command, the text of a tracker or pull-request comment - and a human
**executes or confirms** it. A written rule alone depends on the agent remembering it in
a long session. The harness can hold the same line mechanically: put those operations in
the permissions **ask** list, so each one stops at a confirmation prompt whatever the
agent intended.

What belongs on the list:

| Kind | Examples |
|---|---|
| Version control writes that leave the machine or rewrite history | commit, push, merge, tag, branch copy on the server |
| Tracker writes | work item update, comment, link, state change |
| Code-host writes | pull request create / update / comment / review thread |
| Anything that publishes or sends | release, deploy, package publish, message to a person |

Reads stay free (status, diff, log, queries, work item reads): the list is short on
purpose, so a prompt still means something.

## Neutral example (`.claude/settings.json` of the project, versioned)

```json
{
  "permissions": {
    "ask": [
      "Bash(git commit *)",
      "Bash(git push *)",
      "Bash(git merge *)",
      "Bash(git tag *)",
      "Bash(svn commit *)",
      "Bash(svn ci *)",
      "Bash(svn copy *)",
      "PowerShell(git commit *)",
      "PowerShell(git push *)",
      "PowerShell(svn commit *)",
      "mcp__<tracker>__<work-item-write-tool>",
      "mcp__<tracker>__<work-item-comment-tool>",
      "mcp__<code-host>__<pull-request-write-tool>",
      "mcp__<code-host>__<pull-request-thread-write-tool>"
    ]
  }
}
```

Replace the `mcp__...` placeholders with the full names of the WRITE tools of the
servers the project uses (one rule per tool; `mcp__<server>__*` would also put every read
behind a prompt).

## How Claude Code applies it (checked against its permissions docs, 2026-10)

- Rules are evaluated deny, then ask, then allow; a matching ask rule prompts even when a
  narrower allow rule also matches.
- A Bash rule is checked against each subcommand of a compound command, so
  `cd <dir> && git push` still prompts. `Bash(git commit *)` also matches a bare
  `git commit`.
- A PreToolUse hook that answers `allow` does not bypass an ask rule.
- It is **not a security boundary**: `git -C . push` or `sh -c 'git push'` do not match
  `Bash(git push *)`. The list catches the form the agent normally writes; the written rule
  still applies to every other form.
- `bypassPermissions` mode skips the prompts. A project that needs the list to hold
  always sets `permissions.disableBypassPermissionsMode` to `"disable"` (best in managed
  settings).

## Relation to the guards

The ask list is **unconditional** (every push prompts). The guards' `"commitGate": "ask"`
([README](README.md)) is **conditional**: it prompts only when a guard has a finding. A
project can use either or both. Other harnesses: map the same list to the tool's own
approval or command allow/deny settings; where a tool has none, the written rule carries
the whole weight and the session must say so.
