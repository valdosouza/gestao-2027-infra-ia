# build-memory-index.ps1 - no-Python fallback of memory_index.py (engine-kit runtime, layer 2)
#
# Builds a derived, rebuildable JSON index over the episodic memory logs
# (<base>\SUBJECT\<NAME>\MEMORY\*.md with claims front matter), or queries the logs
# directly. The markdown is the source of record; the JSON is a throw-away artifact.
#
# NOT at parity with memory_index.py, the canonical index - use that one whenever
# Python 3.8+ is available. This fallback indexes episodic logs ONLY. It does not
# index cards (SUBJECT\<NAME>\KNOWLEDGE\*.md), has no project dimension (no
# `project:` field, no project filter), no full-text search, no status or
# confidence filters, no claim types (type/agent are ignored), no card
# supersession and no separate stats command.
# The contract it does support:
#   build  -OutFile: JSON with totals, per-subject counts (flagged for consolidation
#          at >= 5 unconsolidated logs) and every log with its claims
#   query  -Entity / -Ticket / -Subject / -UnconsolidatedOnly (combinable), same
#          output lines as memory_index.py query
#
# Root: -Root, else $env:KB_ROOT.
# The root is scanned, never stored: the JSON holds relative paths ('/' separators).
# Keep -OutFile outside the kit folder (the index is a case artifact).
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.
#
# Usage:
#   build: powershell -NoProfile -File build-memory-index.ps1 -Root <kb-root> -OutFile <runtime-area>\memory-index.json
#   query: powershell -NoProfile -File build-memory-index.ps1 -Root <kb-root> -Entity <unit-or-term>
#          powershell -NoProfile -File build-memory-index.ps1 -Root <kb-root> -Ticket <id>
#          powershell -NoProfile -File build-memory-index.ps1 -Root <kb-root> -Subject <NAME> -UnconsolidatedOnly
# Exit codes: 0 = done, 2 = bad arguments.

[CmdletBinding()]
param(
    [string]$Root = '',
    [string]$OutFile = '',
    [string]$Entity = '',
    [string]$Ticket = '',
    [string]$Subject = '',
    [switch]$UnconsolidatedOnly
)

$ErrorActionPreference = 'Stop'
$FlagThreshold = 5
$SkipPattern = '(^|[\\/])(\.git|\.svn|\.hg|node_modules|__pycache__|\.obsidian|\.trash)[\\/]'
$LogPattern = '(^|[\\/])SUBJECT[\\/]([^\\/]+)[\\/]MEMORY[\\/][^\\/]+\.md$'

if (-not $Root) {
    if ($env:KB_ROOT) { $Root = $env:KB_ROOT }
}
if (-not $Root) { Write-Error 'no root: pass -Root or set the KB_ROOT environment variable' -ErrorAction Continue; exit 2 }
if (-not (Test-Path -LiteralPath $Root -PathType Container)) { Write-Error "root folder not found: $Root" -ErrorAction Continue; exit 2 }
$Root = (Resolve-Path -LiteralPath $Root).ProviderPath.TrimEnd('\', '/')

function Get-Value([string]$raw) {
    # quoted text as is; plain text without its trailing ' # comment'
    $raw = $raw.Trim()
    if ($raw.Length -gt 0 -and ($raw[0] -eq '"' -or $raw[0] -eq "'")) {
        $end = $raw.IndexOf($raw[0], 1)
        if ($end -gt 0) { return $raw.Substring(1, $end - 1) }
        return $raw.Substring(1)
    }
    return ($raw -replace '\s+#.*$', '').Trim()
}

function Get-Number([string]$text) {
    $n = 0.0
    $ok = [double]::TryParse(($text -replace ',', '.'), [System.Globalization.NumberStyles]::Float,
                             [System.Globalization.CultureInfo]::InvariantCulture, [ref]$n)
    if ($ok) { return $n }
    return $null
}

function Get-List($value) {
    if ($null -eq $value) { return @() }
    return @(@($value) | Where-Object { "$_" -ne '' })
}

function Read-FrontMatter([string[]]$lines) {
    # hashtable, or $null when there is no front matter (pre-schema log)
    if ($lines.Count -lt 2 -or $lines[0].Trim() -ne '---') { return $null }
    $fm = @{ claims = @() }
    $inClaims = $false
    $listKey = $null
    $claim = $null
    for ($i = 1; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ($line.Trim() -eq '---') { break }
        if ($inClaims) {
            if ($line -match '^\s+-\s+claim:\s*(.+)$') {
                if ($claim) { $fm.claims += $claim }
                $claim = @{ claim = (Get-Value $Matches[1]); status = ''; confidence = $null; evidence = '' }
                continue
            }
            if ($claim -and $line -match '^\s+(status|confidence|evidence):\s*(.+)$') {
                $k = $Matches[1]; $v = Get-Value $Matches[2]
                if ($k -eq 'confidence') { $claim[$k] = Get-Number $v } else { $claim[$k] = $v }
                continue
            }
        } elseif ($listKey) {
            if ($line -match '^\s+-\s+(.+)$') { $fm[$listKey] += @(Get-Value $Matches[1]); continue }
        }
        if ($line -match '^([A-Za-z_][A-Za-z0-9_-]*):\s*(.*)$') {
            if ($claim) { $fm.claims += $claim; $claim = $null }
            $inClaims = $false; $listKey = $null
            $k = $Matches[1]; $v = Get-Value $Matches[2]
            if ($k -eq 'claims') { $inClaims = $true; continue }
            if ($v -match '^\[(.*)\]$') {
                $fm[$k] = @($Matches[1] -split ',' | ForEach-Object { Get-Value $_ } | Where-Object { $_ })
            } elseif ($v -eq '') {
                $fm[$k] = @(); $listKey = $k     # a block list ("key:" then "  - item" lines) may follow
            } else {
                $fm[$k] = $v
            }
        }
    }
    if ($claim) { $fm.claims += $claim }
    return $fm
}

# ---- scan ------------------------------------------------------------------
$logs = @()
$files = Get-ChildItem -LiteralPath $Root -Recurse -Filter *.md -File -ErrorAction SilentlyContinue | Sort-Object FullName
foreach ($f in $files) {
    $rel = $f.FullName.Substring($Root.Length).TrimStart('\', '/')
    if ($rel -match $SkipPattern) { continue }
    if ($rel -notmatch $LogPattern) { continue }
    $subjectFromPath = $Matches[2]
    $rel = $rel -replace '\\', '/'
    $fm = Read-FrontMatter @(Get-Content -LiteralPath $f.FullName -Encoding UTF8)
    if ($null -eq $fm) {
        $logs += [pscustomobject]@{
            path = $rel; subject = $subjectFromPath; preSchema = $true; consolidated = $false
            version = ''; outcome = ''; tickets = @(); entities = @(); claims = @()
        }
        continue
    }
    $logs += [pscustomobject]@{
        path         = $rel
        subject      = $(if ("$($fm['subject'])") { "$($fm['subject'])" } else { $subjectFromPath })
        preSchema    = ($fm.claims.Count -eq 0)
        consolidated = ("$($fm['consolidated'])" -eq 'true')
        version      = "$($fm['version'])"
        outcome      = "$($fm['outcome'])"
        tickets      = @(Get-List $fm['tickets'])
        entities     = @(Get-List $fm['entities'])
        claims       = @($fm.claims | ForEach-Object { [pscustomobject]$_ })
    }
}

# ---- query mode --------------------------------------------------------------
if ($Entity -or $Ticket -or $Subject -or $UnconsolidatedOnly) {
    $hits = $logs
    if ($Subject) { $hits = @($hits | Where-Object { $_.subject -eq $Subject }) }
    if ($Ticket) { $hits = @($hits | Where-Object { $_.tickets -contains $Ticket }) }
    if ($Entity) {
        $pattern = [regex]::Escape($Entity)
        $hits = @($hits | Where-Object { (@($_.entities) -match $pattern).Count -gt 0 -or (@($_.claims | Where-Object { $_.claim -match $pattern })).Count -gt 0 })
    }
    if ($UnconsolidatedOnly) { $hits = @($hits | Where-Object { -not $_.consolidated }) }
    foreach ($h in $hits) {
        $flag = if ($h.consolidated) { 'consolidated' } else { 'UNCONSOLIDATED' }
        Write-Output ("`n== {0}  [{1}] [{2}]" -f $h.path, $h.subject, $flag)
        foreach ($c in $h.claims) {
            if ($Entity -and ($c.claim -notmatch [regex]::Escape($Entity))) { continue }
            Write-Output ('   - ({0} {1}) {2}' -f $c.status, $c.confidence, $c.claim)
        }
    }
    Write-Output ("`n{0} log(s) matched." -f @($hits).Count)
    exit 0
}

# ---- build mode --------------------------------------------------------------
if (-not $OutFile) { Write-Error 'pass -OutFile for a build (a runtime area outside the kit), or a query parameter' -ErrorAction Continue; exit 2 }
$outFull = [System.IO.Path]::GetFullPath($OutFile)
$kitRoot = [System.IO.Path]::GetFullPath((Split-Path $PSScriptRoot -Parent)).TrimEnd('\') + '\'
if ($outFull.StartsWith($kitRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    Write-Error "the index is a case artifact: keep -OutFile outside the kit folder ($kitRoot)" -ErrorAction Continue
    exit 2
}

$perSubject = [ordered]@{}
foreach ($g in ($logs | Group-Object subject | Sort-Object Name)) {
    $unc = @($g.Group | Where-Object { -not $_.consolidated }).Count
    $perSubject[$g.Name] = [ordered]@{ logs = $g.Count; unconsolidated = $unc; flagged = ($unc -ge $FlagThreshold) }
}
$index = [ordered]@{
    generated  = (Get-Date -Format s)
    totals     = [ordered]@{
        logs           = @($logs).Count
        claims         = @($logs | ForEach-Object { $_.claims } | Where-Object { $_ }).Count
        consolidated   = @($logs | Where-Object { $_.consolidated }).Count
        unconsolidated = @($logs | Where-Object { -not $_.consolidated }).Count
        preSchema      = @($logs | Where-Object { $_.preSchema }).Count
    }
    perSubject = $perSubject
    logs       = @($logs)
}
# the root is deliberately NOT stored: the artifact must stay builder-independent
$dir = Split-Path $outFull -Parent
if ($dir -and -not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
[System.IO.File]::WriteAllText($outFull, ($index | ConvertTo-Json -Depth 8), (New-Object System.Text.UTF8Encoding($false)))
Write-Output ('memory-index built: {0} logs, {1} claims -> {2}' -f $index.totals.logs, $index.totals.claims, $outFull)
foreach ($name in $perSubject.Keys) {
    $s = $perSubject[$name]
    $flag = if ($s.flagged) { "  << FLAG: consolidate this subject's memory" } else { '' }
    Write-Output ('  {0}: {1} logs, {2} unconsolidated{3}' -f $name, $s.logs, $s.unconsolidated, $flag)
}
exit 0
