# setup-editor.ps1 - activates the canonical MCP model for ONE editor on THIS machine
# (engine-kit runtime, technique T56), and optionally refreshes that editor's agent stubs (T01/T91).
#
# One script for every editor: the editors differ only in where their activation file lives
# and in its JSON shape, so both are parameters/data here instead of three near-copies.
#
#   -Editor claude-code     <workspace>\.mcp.json                (mcpServers; project servers)
#   -Editor claude-desktop  <client config dir>\claude_desktop_config.json   (mcpServers)
#   -Editor cursor          <home>\.cursor\mcp.json  or  <workspace>\.cursor\mcp.json  (mcpServers)
#   -Editor vscode          <workspace>\.vscode\mcp.json         (servers + inputs)
# Every path is a parameter: -Model, -Target, -KbRoot, -Rules, -AgentsDir, -StubsConfig.
#
# The T56 rules this script applies:
#   - The MODEL is versioned: secret-free, with {KB_ROOT}-style placeholders and <CONFIGURE>
#     secrets. Keep ONE PROFILE PER OS when commands or paths differ (e.g. mcp.windows.json,
#     mcp.posix.json) - MCP command/args/cwd have no portable variable expansion, so one file
#     cannot serve two operating systems. Pass the profile of this OS as -Model.
#   - The ACTIVATION file (-Target) is machine-local and NEVER versioned. A committed activation
#     carries one machine's resolved paths, executables and sometimes secrets to every other
#     machine; a client that loads it as project configuration then fails (or leaks) for
#     everyone else. This script warns when -Target is tracked or not ignored (warn-only).
#   - The merge touches only the servers map, keeps local secrets and local-only servers,
#     backs the file up first and resolves the placeholders (merge-mcp-config.js).
#   - Placeholders become prompts: for VS Code every <CONFIGURE> becomes a ${input:...} prompt
#     (asked once per session, never stored). Other clients have no prompt: the merge reports
#     each <CONFIGURE> by name, and you fill it in the local file only.
#   - Edit with the client CLOSED: a client that keeps its config in memory writes it back while
#     it runs and silently undoes the merge. -ClientProcess names the process to refuse on
#     (default: 'claude' for claude-desktop; '' disables the check).
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File setup-editor.ps1 -Editor vscode `
#       -Model '<kb-root>\tools\mcp\mcp.windows.json' -Target '<kb-root>\.vscode\mcp.json' `
#       -KbRoot '<kb-root>' [-Rules <rules.json>] [-Var 'TRACKER_ORG=<org>'] `
#       [-AgentStubs [-AgentsDir agents] [-StubsConfig <agent-stubs.json>]] [-WhatIf]
# -WhatIf runs the merge as --dry-run and the stub generator as --check: nothing is written.
# Requires node (18+) on PATH; -AgentStubs also needs python (3.8+).
# Exit codes: 0 done, 1 error, 2 bad arguments.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)][ValidateSet('claude-code', 'claude-desktop', 'cursor', 'vscode')][string]$Editor,
    [Parameter(Mandatory = $true)][string]$Model,
    [Parameter(Mandatory = $true)][string]$Target,
    [string]$KbRoot = '',
    [string]$Rules = '',
    [string[]]$Var = @(),
    [string]$ClientProcess = $null,
    [switch]$AgentStubs,
    [string]$AgentsDir = '',
    [string]$StubsConfig = ''
)

$ErrorActionPreference = 'Stop'
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$MergeJs = Join-Path $Here 'merge-mcp-config.js'
$StubsPy = Join-Path $Here 'gen-agent-stubs.py'

function Fail([string]$msg, [int]$code = 1) { Write-Error $msg -ErrorAction Continue; exit $code }

# ---------- arguments ----------
if (-not (Test-Path -LiteralPath $Model -PathType Leaf)) { Fail "model not found: $Model" 2 }
if ($Rules -and -not (Test-Path -LiteralPath $Rules -PathType Leaf)) { Fail "rules file not found: $Rules" 2 }
if (-not $KbRoot) {
    if ($env:KB_ROOT) { $KbRoot = $env:KB_ROOT }
}
if ($KbRoot -and -not (Test-Path -LiteralPath $KbRoot -PathType Container)) { Fail "knowledge-base root not found: $KbRoot" 2 }
if ($null -eq $PSBoundParameters['ClientProcess']) {
    $ClientProcess = if ($Editor -eq 'claude-desktop') { 'claude' } else { '' }
}
$Format = if ($Editor -eq 'vscode') { 'vscode' } else { 'mcpServers' }
$TargetFull = [System.IO.Path]::GetFullPath($Target)

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) { Fail 'node not found on PATH (Node.js 18+ is required for the merge)' }

$apply = $PSCmdlet.ShouldProcess($TargetFull, "merge MCP model $Model ($Editor, $Format)")

# ---------- client must be closed (it would write its in-memory config back) ----------
if ($apply -and $ClientProcess) {
    if (Get-Process -Name $ClientProcess -ErrorAction SilentlyContinue) {
        Fail ("'$ClientProcess' is running. Quit the client completely (tray icon included), then run this " +
              'script from a plain terminal; inside an AI session, hand the command to the person. Nothing was changed.')
    }
}

# ---------- 1. merge the model into the activation file ----------
$nodeArgs = @($MergeJs, $Model, $TargetFull, '--format', $Format)
if ($Rules) { $nodeArgs += @('--rules', $Rules) }
if ($KbRoot) { $nodeArgs += @('--var', ('KB_ROOT=' + [System.IO.Path]::GetFullPath($KbRoot).TrimEnd('\', '/'))) }
foreach ($v in $Var) { foreach ($p in ($v -split ';')) { if ($p.Trim()) { $nodeArgs += @('--var', $p.Trim()) } } }
if (-not $apply) { $nodeArgs += '--dry-run' }
& $node.Source @nodeArgs
if ($LASTEXITCODE -ne 0) { Fail "MCP merge failed (exit $LASTEXITCODE, see above); the activation file is unchanged." }

# ---------- 2. the activation file must stay unversioned (warn-only) ----------
function Test-Unversioned([string]$file) {
    # PS 5.1 turns a native command's redirected stderr into a terminating error under 'Stop'
    $ErrorActionPreference = 'Continue'
    $dir = Split-Path -Parent $file
    $probe = $dir
    while ($probe) {
        if (Test-Path -LiteralPath (Join-Path $probe '.git')) {
            $git = Get-Command git -ErrorAction SilentlyContinue
            if (-not $git) { return }
            & $git.Source -C $dir ls-files --error-unmatch -- $file 2>$null | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Warning "activation file is TRACKED by git: $file - untrack it (git rm --cached) and ignore it; a versioned activation breaks every other machine."
                return
            }
            & $git.Source -C $dir check-ignore -q -- $file 2>$null
            if ($LASTEXITCODE -ne 0) { Write-Warning "activation file is not git-ignored: $file - add it to .gitignore before the next commit." }
            else { Write-Host "ok     activation file is ignored by git" -ForegroundColor DarkGreen }
            return
        }
        if (Test-Path -LiteralPath (Join-Path $probe '.svn')) {
            $svn = Get-Command svn -ErrorAction SilentlyContinue
            if (-not $svn) { return }
            # -v lists unmodified versioned items too; --no-ignore shows ignored ones as 'I'
            $st = [string](& $svn.Source status -v --no-ignore --depth empty -- $file 2>$null | Select-Object -First 1)
            if (-not $st) { return }
            switch ($st.Substring(0, 1)) {
                '?' { Write-Warning "activation file is not svn:ignored: $file - add it to svn:ignore of its folder." }
                'I' { Write-Host 'ok     activation file is ignored by svn' -ForegroundColor DarkGreen }
                default { Write-Warning "activation file is VERSIONED in svn: $file - remove it from version control and ignore it." }
            }
            return
        }
        $parent = Split-Path -Parent $probe
        if ($parent -eq $probe) { break }
        $probe = $parent
    }
}
if (Test-Path -LiteralPath (Split-Path -Parent $TargetFull)) { Test-Unversioned $TargetFull }

# ---------- 3. optional: this editor's agent stubs ----------
if ($AgentStubs) {
    $stubTarget = switch ($Editor) { 'claude-code' { 'claude' } 'vscode' { 'copilot' } default { '' } }
    if (-not $stubTarget) {
        Write-Host "note   -AgentStubs: $Editor has no generated agent stubs (Claude Code and VS Code only)" -ForegroundColor DarkGray
    } elseif (-not $KbRoot) {
        Write-Warning '-AgentStubs needs -KbRoot (or KB_ROOT): stubs skipped.'
    } else {
        $py = Get-Command python -ErrorAction SilentlyContinue
        if (-not $py) { $py = Get-Command python3 -ErrorAction SilentlyContinue }
        if (-not $py) {
            Write-Warning 'python not found: agent stubs skipped (run gen-agent-stubs.py later).'
        } else {
            $pyArgs = @($StubsPy, '--kb-root', $KbRoot, '--target', $stubTarget)
            if ($AgentsDir) { $pyArgs += @('--agents-dir', $AgentsDir) }
            if ($StubsConfig) { $pyArgs += @('--config', $StubsConfig) }
            if (-not $apply) { $pyArgs += '--check' }
            & $py.Source @pyArgs
            if ($LASTEXITCODE -ne 0 -and $apply) { Write-Warning 'gen-agent-stubs.py reported a problem (see above).' }
        }
    }
}

# ---------- next step for this editor ----------
$next = switch ($Editor) {
    'claude-code'    { 'open the workspace in Claude Code and approve the project MCP servers when asked' }
    'claude-desktop' { 'start the client again' }
    'cursor'         { 'restart Cursor (or reload its MCP servers)' }
    'vscode'         { 'open the workspace in VS Code; servers start on first use and ask each ${input} once per session' }
}
$mode = if ($apply) { '' } else { ' (WhatIf: nothing written)' }
Write-Host "Done$mode. Next: $next. Skills are linked separately (sync-skills.ps1)." -ForegroundColor Green
exit 0
