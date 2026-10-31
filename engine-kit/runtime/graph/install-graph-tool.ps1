# install-graph-tool.ps1 - pinned install of the external code-graph tool (engine-kit runtime, graph tools)
#
# The graph tool stays an EXTERNAL dependency: it is not vendored into the kit or into the
# knowledge base. This script installs exactly what requirements.txt pins (technique T90):
#   - every requirement line must be an exact pin (name==version, optional [extras]); a
#     range, a wildcard, a bare name or "latest" is refused. Raising the pin is a decision
#     recorded in the case, followed by a rebuild of every registered graph.
#   - language extras are added with -Extras, never by loosening the pin.
#   - after the install, the CLI found on PATH must report the pinned version: a second
#     Python earlier on PATH can hide the one that was just installed.
#   - it NEVER runs the tool's own set-up commands (init, install, hook install,
#     <assistant> install): they write agent rule sections, hooks or skills into the folder
#     or profile they run in, and at the knowledge-base root they would rewrite the base's
#     own rules. A case that wants that integration tries it in a scratch project, reviews
#     the diff and ports what it keeps by hand.
#   - the user PATH is changed only with -AddToUserPath; by default only this session's.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File install-graph-tool.ps1
#       [-Requirements <file>] [-Extras <name>[,<name>]] [-Python python]
#       [-ToolCommand graphify] [-AddToUserPath] [-DryRun]
# Exit codes: 0 = installed and verified, 1 = install or verification failed,
#             2 = refused (unpinned requirement, missing file, no Python).

[CmdletBinding()]
param(
    [string]$Requirements = '',
    [string[]]$Extras = @(),
    [string]$Python = 'python',
    [string]$ToolCommand = 'graphify',
    [switch]$AddToUserPath,
    [switch]$DryRun
)

# native tools (pip) write warnings to stderr: exit codes are checked explicitly instead
$ErrorActionPreference = 'Continue'
function Say([string]$level, [string]$msg) {
    $color = 'Gray'
    switch ($level) { 'WARN' { $color = 'Yellow' } 'ERROR' { $color = 'Red' } 'OK' { $color = 'Green' } 'PLAN' { $color = 'Cyan' } }
    Write-Host ('{0,-5} {1}' -f $level, $msg) -ForegroundColor $color
}
# PS 5.1 leaves $PSScriptRoot empty inside param defaults: resolve the default here
if (-not $Requirements) { $Requirements = Join-Path $PSScriptRoot 'requirements.txt' }
# with -File, "-Extras a,b" arrives as one string: split it
$Extras = @($Extras | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })

# ---------- 1. the pin ----------
if (-not (Test-Path -LiteralPath $Requirements -PathType Leaf)) { Say 'ERROR' "requirements file not found: $Requirements"; exit 2 }
$pinRe = '^([A-Za-z0-9][A-Za-z0-9._-]*)(\[([A-Za-z0-9._, -]+)\])?\s*==\s*([0-9][0-9A-Za-z.+!-]*)\s*$'
$specs = @()
$refused = 0
foreach ($raw in (Get-Content -LiteralPath $Requirements -Encoding UTF8)) {
    $line = ($raw -replace '#.*$', '').Trim()
    if (-not $line) { continue }
    if ($line -notmatch $pinRe) { Say 'ERROR' "not an exact pin (name==version): '$line'"; $refused++; continue }
    $name = $Matches[1]; $version = $Matches[4]
    $all = @()
    if ($Matches[3]) { $all += @($Matches[3] -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }) }
    if ($specs.Count -eq 0) { $all += $Extras }   # extras belong to the graph tool, the first requirement
    $all = @($all | Sort-Object -Unique)
    $spec = $name
    if ($all.Count -gt 0) { $spec += '[' + ($all -join ',') + ']' }
    $spec += "==$version"
    $specs += [pscustomobject]@{ Name = $name; Version = $version; Spec = $spec }
}
if ($refused -gt 0) { Say 'ERROR' "$refused unpinned requirement(s): refused. Pin the exact version; raising it is a decision."; exit 2 }
if ($specs.Count -eq 0) { Say 'ERROR' "no requirement in $Requirements"; exit 2 }
$tool = $specs[0]
Say 'INFO' ("pinned: " + (($specs | ForEach-Object { $_.Spec }) -join ' '))

# ---------- 2. Python ----------
$py = Get-Command $Python -ErrorAction SilentlyContinue
if (-not $py) { Say 'ERROR' "'$Python' not found on PATH"; exit 2 }
if ($py.Source -match '\\WindowsApps\\') {
    Say 'WARN' "'$Python' resolves to an app-execution alias ($($py.Source)). A store-packaged Python once killed a graph tool's worker pool on every file in a real case; if the build fails that way, install a regular Python."
}

# ---------- 3. install ----------
$pipArgs = @('-m', 'pip', 'install') + @($specs | ForEach-Object { $_.Spec })
if ($DryRun) {
    Say 'PLAN' ("$Python " + ($pipArgs -join ' '))
    Say 'PLAN' "verify: $ToolCommand --version reports $($tool.Version)"
    exit 0
}
& $Python @pipArgs
if ($LASTEXITCODE -ne 0) { Say 'ERROR' "pip failed (exit $LASTEXITCODE)"; exit 1 }

# the interpreter's scripts folder holds the CLI: this session always, the user PATH on request
$scripts = (& $Python -c "import sysconfig; print(sysconfig.get_path('scripts'))" | Select-Object -Last 1)
if ($scripts -and (Test-Path -LiteralPath $scripts) -and (($env:PATH -split ';') -notcontains $scripts)) {
    $env:PATH = "$scripts;$env:PATH"
    if ($AddToUserPath) {
        $userPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
        if ((($userPath -split ';') -notcontains $scripts)) {
            [Environment]::SetEnvironmentVariable('PATH', ($userPath.TrimEnd(';') + ";$scripts"), 'User')
            Say 'INFO' "user PATH: added $scripts"
        }
    } else {
        Say 'INFO' "this session's PATH: added $scripts (pass -AddToUserPath to keep it)"
    }
}

# ---------- 4. verify: the CLI on PATH is the pinned one ----------
$cli = Get-Command $ToolCommand -ErrorAction SilentlyContinue
if (-not $cli) { Say 'ERROR' "'$ToolCommand' is not callable after the install (scripts folder: $scripts)"; exit 1 }
$reported = (& $ToolCommand --version 2>&1 | ForEach-Object { "$_" }) -join ' '
if ($reported -notmatch ('(^|[^0-9.])' + [regex]::Escape($tool.Version) + '([^0-9.]|$)')) {
    Say 'ERROR' "'$ToolCommand' on PATH ($($cli.Source)) reports '$reported', not the pinned $($tool.Version): another installation comes first on PATH"
    exit 1
}
Say 'OK' "$ToolCommand $($tool.Version) installed and first on PATH ($($cli.Source))"
Say 'INFO' "never run '$ToolCommand install', 'init' or 'hook install' at the knowledge-base root (T90)"
exit 0
