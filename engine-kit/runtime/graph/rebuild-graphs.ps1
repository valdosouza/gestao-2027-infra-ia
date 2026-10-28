# rebuild-graphs.ps1 - registry-driven code-graph rebuild (engine-kit runtime, graph tools)
#
# Rebuilds every code graph registered in the knowledge base's graph registries
# (templates/REGISTRY_GRAPHS.template.md). The REGISTRY drives the job: no graph,
# variant or path is written in this script. Lesson behind it: a job with its own
# hardcoded list of graphs and a registry that agents read drift apart.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.
#
# What one run does (technique T07, "graph as instrument"):
#   1. Finds every -RegistryPattern file under -KbRoot and reads its Architecture
#      table (Graph | Kind | Location | Source | Pairs | Flags) and Build Status table.
#      Structural problems are logged as WARN and that graph is skipped (warn-only, EK#6).
#   2. Code working copies (the Source of each graph): reports clean/dirty. With
#      -UpdateCode a CLEAN copy is updated (svn update / git pull --ff-only); a dirty
#      copy is never touched - it is scanned as-is and the changes are logged.
#   3. Builds in order base -> overlay -> merged. base/overlay: the graph tool scans
#      Source. merged: merge_tree.py first syncs a persistent hardlink tree
#      (base + overlay, overlay wins, zero data copied) under -WorkRoot, then the tool
#      scans it. The tool runs with its output folder as working directory, so it never
#      writes into a source tree or the knowledge-base root. -ToolArgs shapes the call
#      ({source} {out} {flags}); Flags come from the registry row or -DefaultFlags.
#   4. -StampRegistry: writes Last Built (today) and, when cheaply available, Nodes /
#      Edges / Communities (read from the graph file with Python) into the Build Status
#      rows of the graphs built in this run. Skipped with a WARN when the registry file
#      has local modifications (a human's edit is never mixed with the job's stamp).
#      Lesson: Last Built went stale because nothing stamped it while freshness checks
#      read it.
#   5. -Commit (team profile, designated builder only): adds and commits ONLY the
#      registered graph output folders (cache and dated backup folders excluded,
#      -CommitExclude) plus, with -StampRegistry, each registry file this run stamped -
#      a registry is stamped only when it had no local modifications, so no human edit
#      rides along (kit decision EK#12). git commits locally (push is the builder's own
#      step); svn commits to the server. Never anything else in the working copy.
#
# Profiles (EK#5), declared per registry by its "**Profile**:" line:
#   solo  graphs live outside the versioned knowledge base (beside it, or in a folder inside
#         it that version control ignores - EK#27), rebuildable; nothing is committed.
#   team  graphs are versioned; ONE designated builder ("**Designated builder**:",
#         a machine name compared with -BuilderName) rebuilds and commits them;
#         everyone else receives them with a VCS update. On any other machine the
#         registry's graphs are skipped (pass -BuilderName to stand in for the builder).
#   A registry without a Profile line is treated as solo.
#
# Prepare-only by default: VCS writes happen only with -UpdateCode or -Commit.
# -DryRun (or -WhatIf) prints the plan - code state, merge and tool commands per graph,
# stamps and commit paths - and runs no tool, no VCS write, no file write.
# -CheckRegistry only cross-checks (structure, Last Built vs the graph file, Last Built
# vs the code's last change = freshness, graph files nobody registered, profile rules).
# -Register creates a daily scheduled task that runs this script with the same
# parameters (Windows; run it once on the designated builder, as that user).
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File rebuild-graphs.ps1 -KbRoot <kb-root>
#       [-CodeRoot <code-root>] [-DryRun | -CheckRegistry] [-UpdateCode] [-StampRegistry]
#       [-Commit] [-Register [-TaskName <name>] [-At 00:00]] [-LogDir <dir>] [-WorkRoot <dir>]
#       [-GraphTool <cli>] [-ToolArgs '{source} --out {out} {flags}'] [-ToolOutSubdir <name>]
#       [-DefaultFlags '--code-only'] [-MergeExclude <pattern>[,<pattern>]] [-BuilderName <name>]
# Paths: Location is absolute or relative to -KbRoot (same rule as validate-registry.ps1);
# Source is absolute or relative to -CodeRoot (or CODE_ROOT).
# Exit codes: 0 = done (warnings allowed), 1 = a build, stamp or commit failed, 2 = bad arguments.

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$KbRoot = $env:KB_ROOT,
    [string]$CodeRoot = $env:CODE_ROOT,
    [string]$RegistryPattern = 'REGISTRY_GRAPHS.md',
    [int]$Depth = 6,
    [string]$ExcludePattern = '[\\/](\.git|\.svn|\.hg|\.obsidian|\.trash|node_modules|__pycache__|cache)([\\/]|$)|[\\/]graph[^\\/]*-(out|merged)([\\/]|$)|\.template\.md$',
    [string]$GraphTool = 'graphify',
    [string]$ToolArgs = '{source} --out {out} {flags}',
    [string]$ToolOutSubdir = 'graphify-out',
    [string]$DefaultFlags = '--code-only',
    [string]$GraphFile = 'graph.json',
    [string]$Python = 'python',
    [string[]]$MergeExclude = @(),
    [string]$WorkRoot = '',
    [string]$LogDir = '',
    [string]$BuilderName = $env:COMPUTERNAME,
    [string]$CommitMessage = '',
    [string]$CommitExclude = '[\\/](cache|\d{4}-\d{2}-\d{2})([\\/]|$)',
    [string]$ToolLogPattern = 'wrote|error|fail|warn',
    [int]$CountMaxMB = 512,
    [switch]$DryRun,
    [switch]$CheckRegistry,
    [switch]$StampRegistry,
    [switch]$UpdateCode,
    [switch]$Commit,
    [switch]$Register,
    [string]$TaskName = 'Engine Kit Graph Rebuild',
    [string]$At = '00:00'
)

$ErrorActionPreference = 'Stop'
if ($WhatIfPreference) { $DryRun = [switch]$true }
$userArea = $env:LOCALAPPDATA
if (-not $userArea) { $userArea = [System.IO.Path]::GetTempPath() }
if (-not $WorkRoot) { $WorkRoot = Join-Path $userArea 'engine-kit\graph-work' }
if (-not $LogDir) { $LogDir = Join-Path $userArea 'engine-kit\graph-rebuild' }
if (-not $BuilderName) { $BuilderName = [Environment]::MachineName }
if (-not $CommitMessage) { $CommitMessage = "Graph rebuild $(Get-Date -Format 'yyyy-MM-dd') - designated builder job (registry-driven)" }
# with -File, "-MergeExclude a,b" arrives as one string: split it
$MergeExclude = @($MergeExclude | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })
$mergeScript = Join-Path $PSScriptRoot 'merge_tree.py'

# ---------- logging and native calls ----------
$script:logFile = $null
$script:warnCount = 0
function Write-Log([string]$level, [string]$msg) {
    $line = '{0}  {1,-5} {2}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $level, $msg
    if ($script:logFile) { Add-Content -LiteralPath $script:logFile -Value $line -Encoding UTF8 -WhatIf:$false }
    $color = 'Gray'
    switch ($level) { 'WARN' { $color = 'Yellow' } 'ERROR' { $color = 'Red' } 'PLAN' { $color = 'Cyan' } 'OK' { $color = 'Green' } }
    Write-Host $line -ForegroundColor $color
    if ($level -eq 'WARN') { $script:warnCount++ }
}

# Native tools run with ErrorActionPreference Continue and stderr merged: under 'Stop', a
# bare `tool 2>&1` turns every stderr line into a terminating error, and one benign
# warning from the graph tool would abort the whole job.
function Invoke-Native([string]$exe, [string[]]$argv, [string]$cwd = '') {
    $old = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    $pushed = $false
    $global:LASTEXITCODE = 0
    try {
        if ($cwd) { Push-Location -LiteralPath $cwd; $pushed = $true }
        $out = @(& $exe @argv 2>&1 | ForEach-Object { "$_" })
        $code = $global:LASTEXITCODE
    } catch {
        $out = @("$_"); $code = 127
    } finally {
        if ($pushed) { Pop-Location }
        $ErrorActionPreference = $old
    }
    if ($null -eq $code) { $code = 0 }
    return [pscustomobject]@{ Code = $code; Out = $out }
}
function Format-Command([string]$exe, [string[]]$argv) {
    $parts = @($exe) + @($argv | ForEach-Object { if ($_ -match '\s') { '"' + $_ + '"' } else { $_ } })
    return ($parts -join ' ')
}
function Test-Cmd([string]$name) { return [bool](Get-Command $name -ErrorAction SilentlyContinue) }

# ---------- paths ----------
function Get-FullPath([string]$p) { return [System.IO.Path]::GetFullPath($p).TrimEnd('\', '/') }
function Test-Inside([string]$child, [string]$parent) {
    $c = Get-FullPath $child; $p = Get-FullPath $parent
    return (($c -ieq $p) -or $c.StartsWith($p + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase))
}
function Resolve-Under([string]$base, [string]$value) {
    if ([System.IO.Path]::IsPathRooted($value)) { return (Get-FullPath $value) }
    if (-not $base) { return '' }
    return (Get-FullPath (Join-Path $base $value))
}
function Get-Rel([string]$full) {
    if (Test-Inside $full $KbRoot) { $r = $full.Substring($KbRoot.Length).TrimStart('\', '/'); if ($r) { return $r }; return '.' }
    return $full
}

# ---------- VCS adapter (git | svn | none), detected from the nearest metadata folder ----------
function Get-VcsRoot([string]$path) {
    $dir = $path
    while ($dir -and -not (Test-Path -LiteralPath $dir -PathType Container)) { $dir = Split-Path -Parent $dir }
    while ($dir) {
        if (Test-Path -LiteralPath (Join-Path $dir '.git')) { return [pscustomobject]@{ Vcs = 'git'; Root = $dir } }
        # svn 1.7+ keeps one .svn folder, with its wc.db, at the working-copy root
        if (Test-Path -LiteralPath (Join-Path $dir '.svn\wc.db') -PathType Leaf) { return [pscustomobject]@{ Vcs = 'svn'; Root = $dir } }
        $parent = Split-Path -Parent $dir
        if (-not $parent -or $parent -eq $dir) { break }
        $dir = $parent
    }
    return [pscustomobject]@{ Vcs = 'none'; Root = '' }
}
# True when version control ignores the path (EK#27: a solo runtime folder inside the base).
# git: check-ignore; svn: status shows "I" (svn:ignore) for the path. Unknown -> false.
function Test-VcsIgnored([string]$path) {
    $info = Get-VcsRoot $path
    if (-not (Test-VcsCli $info.Vcs)) { return $false }
    if ($info.Vcs -eq 'git') {
        return ((Invoke-Native 'git' @('-C', $info.Root, 'check-ignore', '-q', '--', $path)).Code -eq 0)
    }
    $r = Invoke-Native 'svn' @('status', '--depth', 'empty', $path)
    return ($r.Code -eq 0 -and @($r.Out | Where-Object { $_ -match '^I' }).Count -gt 0)
}
function Test-VcsCli([string]$vcs) {
    if ($vcs -eq 'git') { return (Test-Cmd 'git') }
    if ($vcs -eq 'svn') { return (Test-Cmd 'svn') }
    return $false
}
# Local modifications of tracked files (unversioned files do not count). A failing status
# call counts as dirty: when in doubt, do not update and do not stamp.
function Get-LocalChanges($info, [string]$path) {
    if (-not (Test-VcsCli $info.Vcs)) { return @("$($info.Vcs) CLI not on PATH: state unknown") }
    if ($info.Vcs -eq 'git') { $r = Invoke-Native 'git' @('-C', $info.Root, 'status', '--porcelain', '--untracked-files=no', '--', $path) }
    else { $r = Invoke-Native 'svn' @('status', '-q', $path) }
    if ($r.Code -ne 0) { return @("$($info.Vcs) status failed: " + ($r.Out -join ' ')) }
    return @($r.Out | Where-Object { $_ -and $_.Trim() })
}
function Get-LastChange($info, [string]$path) {
    if (-not (Test-VcsCli $info.Vcs)) { return '' }
    if ($info.Vcs -eq 'git') { $r = Invoke-Native 'git' @('-C', $info.Root, 'log', '-1', '--format=%cI', '--', $path) }
    else { $r = Invoke-Native 'svn' @('info', '--show-item', 'last-changed-date', $path) }
    $text = ($r.Out -join '').Trim()
    if ($r.Code -ne 0 -or $text -notmatch '^\d{4}-\d{2}-\d{2}') { return '' }
    return $text.Substring(0, 10)
}
function Update-WorkingCopy($info, [string]$path) {
    if ($info.Vcs -eq 'git') { return (Invoke-Native 'git' @('-C', $info.Root, 'pull', '--ff-only')) }
    return (Invoke-Native 'svn' @('update', $path, '--non-interactive'))
}

# ---------- registry parsing ----------
function Split-Cells([string]$line) {
    $t = $line.Trim()
    if ($t.StartsWith('|')) { $t = $t.Substring(1) }
    if ($t.EndsWith('|')) { $t = $t.Substring(0, $t.Length - 1) }
    return @($t -split '\|' | ForEach-Object { $_.Trim() })
}
function Get-CellValue([string]$cell) {
    $v = ("$cell").Trim().Trim('`').Trim()
    if ($v -eq '-') { return '' }
    return $v
}
function Get-Cell($cells, [int]$i) { if ($i -ge 0 -and $i -lt $cells.Count) { return $cells[$i] }; return '' }
function Find-Col($header, [string]$pattern) {
    for ($i = 0; $i -lt $header.Count; $i++) { if ($header[$i] -match $pattern) { return $i } }
    return -1
}
function Get-Tables([string[]]$lines) {
    $tables = New-Object System.Collections.Generic.List[object]
    $heading = ''; $fence = $false; $current = $null
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ($line -match '^\s*(```|~~~)') { $fence = -not $fence; $current = $null; continue }
        if ($fence) { continue }
        if ($line -match '^#{1,6}\s+(.*)$') { $heading = $Matches[1].Trim(); $current = $null; continue }
        if ($line -notmatch '^\s*\|') { $current = $null; continue }
        if ($null -eq $current) {
            $header = @(Split-Cells $line | ForEach-Object { $_.ToLowerInvariant() })
            $current = [pscustomobject]@{ Heading = $heading; Header = $header; Rows = (New-Object System.Collections.Generic.List[object]) }
            $tables.Add($current)
            continue
        }
        if ($line -match '^\s*\|[\s:|-]+\|\s*$') { continue }
        $current.Rows.Add([pscustomobject]@{ Index = $i; Cells = @(Split-Cells $line) })
    }
    return $tables
}

function Read-Registry($file) {
    $text = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $nl = "`n"
    if ($text.Contains("`r`n")) { $nl = "`r`n" }
    $reg = [pscustomobject]@{
        Path = $file.FullName; Name = $file.Name; Label = (Get-Rel $file.FullName)
        Lines = [string[]]($text -split "`r?`n"); Nl = $nl
        Profile = ''; Builder = ''; Builds = $true; CommitOk = $false; Stamped = $false
        Graphs = (New-Object System.Collections.Generic.List[object])
        Status = @{}; StatusCols = $null
    }
    $fence = $false
    foreach ($line in $reg.Lines) {
        if ($line -match '^\s*(```|~~~)') { $fence = -not $fence; continue }
        if ($fence) { continue }
        if (-not $reg.Profile -and $line -match '^\*\*Profile\*\*:\s*(\S*)') { $reg.Profile = $Matches[1].Trim('`*.,;').ToLowerInvariant() }
        if (-not $reg.Builder -and $line -match '^\*\*Designated builder\*\*:\s*(\S*)') { $reg.Builder = Get-CellValue $Matches[1] }
    }
    if ($reg.Builder -like '<*') { $reg.Builder = '' }

    $tables = Get-Tables $reg.Lines
    $arch = $tables | Where-Object { $_.Heading -notmatch '^Build Status' -and $_.Header.Count -gt 0 -and $_.Header[0] -match '^graph' -and (Find-Col $_.Header 'location') -ge 0 } | Select-Object -First 1
    $stat = $tables | Where-Object { $_.Heading -match '^Build Status' -and (Find-Col $_.Header '^last built') -ge 0 } | Select-Object -First 1

    if ($stat) {
        $reg.StatusCols = @{
            LastBuilt = (Find-Col $stat.Header '^last built'); Nodes = (Find-Col $stat.Header '^nodes')
            Edges = (Find-Col $stat.Header '^edges'); Communities = (Find-Col $stat.Header '^communit'); Notes = (Find-Col $stat.Header '^notes')
        }
        foreach ($row in $stat.Rows) {
            if ((Get-Cell $row.Cells 0) -match '^`([^`]+)`$') { $reg.Status[$Matches[1]] = $row }
        }
    }
    if (-not $arch) { return $reg }
    $col = @{
        Kind = (Find-Col $arch.Header '^kind'); Location = (Find-Col $arch.Header 'location'); Source = (Find-Col $arch.Header '^source')
        Pairs = (Find-Col $arch.Header '^pair'); Flags = (Find-Col $arch.Header '^flag')
    }
    foreach ($row in $arch.Rows) {
        $c = $row.Cells
        if ((Get-Cell $c 0) -notmatch '^`([^`]+)`$') { continue }
        $id = $Matches[1]
        $rawLoc = Get-Cell $c $col.Location
        $flags = Get-CellValue (Get-Cell $c $col.Flags)
        if ($col.Flags -lt 0 -or -not $flags) { $flags = $DefaultFlags }
        $pairIds = @()
        if ($col.Pairs -ge 0) { $pairIds = @(((Get-Cell $c $col.Pairs) -replace '`', '') -split '\+' | ForEach-Object { $_.Trim() } | Where-Object { $_ -and $_ -ne '-' }) }
        $g = [pscustomobject]@{
            Id = $id; Registry = $reg; Kind = (Get-CellValue (Get-Cell $c $col.Kind)).ToLowerInvariant()
            LocationRaw = $rawLoc; Location = ''; OutParent = ''
            SourceRaw = (Get-CellValue (Get-Cell $c $col.Source)); Source = ''
            PairIds = $pairIds; Base = $null; Overlay = $null
            Flags = @($flags -split '\s+' | Where-Object { $_ })
            Problems = (New-Object System.Collections.Generic.List[string])
            NoKindColumn = ($col.Kind -lt 0); DupOf = $null
            Built = $false; Failed = $false; Counts = $null
        }
        $loc = Get-CellValue $rawLoc
        if (-not $loc) { $g.Problems.Add('no Location') }
        else {
            if ($rawLoc -notmatch '^`[^`]+`$') { $g.Problems.Add('Location is not in backticks: validate-registry.ps1 cannot see it') }
            $g.Location = Resolve-Under $KbRoot $loc
            if (-not $ToolOutSubdir) { $g.OutParent = $g.Location }
            elseif ((Split-Path -Leaf $g.Location) -ieq $ToolOutSubdir) { $g.OutParent = Split-Path -Parent $g.Location }
            else { $g.Problems.Add("Location must end in '$ToolOutSubdir' (the folder the tool writes under its --out folder)") }
        }
        $reg.Graphs.Add($g)
    }
    return $reg
}

# ---------- structural cross-check (every run) ----------
# Pass 1 registry lines and each row on its own; pass 2 merged pairs (a pair may sit in
# another registry or in a later row); pass 3 report.
function Test-Structure($registries) {
    $all = @($registries | ForEach-Object { $_.Graphs } | ForEach-Object { $_ })
    $byId = @{}
    foreach ($g in $all) { if (-not $byId.ContainsKey($g.Id)) { $byId[$g.Id] = @() }; $byId[$g.Id] += $g }
    foreach ($id in $byId.Keys) {
        if ($byId[$id].Count -gt 1) { Write-Log 'WARN' ("graph id '$id' is registered " + $byId[$id].Count + ' times (' + (($byId[$id] | ForEach-Object { $_.Registry.Label }) -join ', ') + '): pairs resolve inside their own registry first') }
    }
    foreach ($reg in $registries) {
        $label = $reg.Label
        if (-not $reg.Profile) { Write-Log 'INFO' "$label - no **Profile** line: treated as solo (EK#5)"; $reg.Profile = 'solo' }
        elseif ($reg.Profile -notin @('solo', 'team')) { Write-Log 'WARN' "$label - Profile '$($reg.Profile)' is not solo or team: treated as solo"; $reg.Profile = 'solo' }
        if ($reg.Profile -eq 'team') {
            if (-not $reg.Builder) { Write-Log 'WARN' "$label - profile team but no **Designated builder**: graphs rebuild here, -Commit is refused" }
            elseif ($reg.Builder -ine $BuilderName) {
                $reg.Builds = $false
                Write-Log 'INFO' "$label - designated builder is '$($reg.Builder)', this machine is '$BuilderName': its graphs are not rebuilt here (receive them with a VCS update)"
            } else { $reg.CommitOk = $true }
        }
        if ($reg.Graphs.Count -eq 0) { Write-Log 'WARN' "$label - no Architecture table (Graph | Kind | Location | Source | Pairs | Flags) with graph rows"; continue }
        if (-not $reg.StatusCols) { Write-Log 'WARN' "$label - no Build Status table: nothing to stamp, freshness cannot be read" }
        if ($reg.Graphs[0].NoKindColumn) {
            Write-Log 'WARN' "$label - Architecture table has no Kind column (older template shape): add Kind, Source, Pairs and Flags (templates/REGISTRY_GRAPHS.template.md); its graphs are not rebuilt"
        }
        foreach ($g in $reg.Graphs) {
            if ($g.NoKindColumn) { $g.Problems.Add('no Kind column'); continue }
            if ($g.Kind -notin @('base', 'overlay', 'merged')) { $g.Problems.Add("Kind '$($g.Kind)' is not base, overlay or merged"); continue }
            if ($g.Kind -ne 'merged') {
                if (-not $g.SourceRaw) { $g.Problems.Add('no Source') }
                else {
                    $g.Source = Resolve-Under $CodeRoot $g.SourceRaw
                    if (-not $g.Source) { $g.Problems.Add('Source is relative and no -CodeRoot / CODE_ROOT is set') }
                    elseif ((Get-FullPath $g.Source) -ieq $KbRoot) { $g.Problems.Add('Source is the knowledge-base root itself') }
                }
            }
            if ($g.OutParent -and ((Get-FullPath $g.OutParent) -ieq $KbRoot)) { $g.Problems.Add('the tool would write at the knowledge-base root: give the graph its own folder') }
            if ($reg.StatusCols -and -not $reg.Status.ContainsKey($g.Id)) { Write-Log 'WARN' "$label - graph '$($g.Id)' has no Build Status row: Last Built cannot be stamped or read" }
        }
    }
    foreach ($g in @($all | Where-Object { $_.Kind -eq 'merged' -and -not $_.NoKindColumn })) {
        $pair = @()
        foreach ($pairId in $g.PairIds) {
            $hit = @($g.Registry.Graphs | Where-Object { $_.Id -eq $pairId })
            if ($hit.Count -eq 0 -and $byId.ContainsKey($pairId) -and $byId[$pairId].Count -eq 1) { $hit = $byId[$pairId] }
            if ($hit.Count -ne 1) { $g.Problems.Add("Pairs names '$pairId', which is not one registered graph"); continue }
            $pair += $hit[0]
        }
        $g.Base = @($pair | Where-Object { $_.Kind -eq 'base' }) | Select-Object -First 1
        $g.Overlay = @($pair | Where-Object { $_.Kind -eq 'overlay' }) | Select-Object -First 1
        if ($g.Problems.Count -gt 0) { continue }
        if ($g.PairIds.Count -ne 2 -or -not $g.Base -or -not $g.Overlay) {
            $g.Problems.Add('Pairs must name one base and one overlay graph (`base.graph` + `variant.overlay.graph`)')
        } elseif (-not $g.Base.Source -or -not $g.Overlay.Source) {
            $g.Problems.Add('a paired graph has no usable Source')
        }
    }
    foreach ($g in $all) {
        if (-not $g.Registry.Builds -or $g.Problems.Count -gt 0) { continue }
        foreach ($src in (Get-Sources $g)) {
            if (-not (Test-Path -LiteralPath $src -PathType Container)) { $g.Problems.Add("Source not found on this machine: $src") }
        }
    }
    foreach ($reg in $registries) {
        foreach ($g in $reg.Graphs) { foreach ($p in $g.Problems) { Write-Log 'WARN' "$($reg.Label) - graph '$($g.Id)': $p (not rebuilt)" } }
        foreach ($sid in $reg.Status.Keys) {
            if (-not @($reg.Graphs | Where-Object { $_.Id -eq $sid })) { Write-Log 'WARN' "$($reg.Label) - Build Status row '$sid' has no Architecture row" }
        }
    }
}

# ---------- full cross-check: stamps, freshness, orphans, profiles (-CheckRegistry, -DryRun) ----------
function Get-Sources($g) {
    if ($g.Kind -eq 'merged') { return @(@($g.Base, $g.Overlay) | Where-Object { $_ -and $_.Source } | ForEach-Object { $_.Source }) }
    if ($g.Source) { return @($g.Source) }
    return @()
}
function Test-Freshness($registries) {
    foreach ($reg in $registries) {
        foreach ($g in $reg.Graphs) {
            if (-not $g.Location) { continue }
            $tag = "$($reg.Label) - graph '$($g.Id)'"
            if ($reg.Profile -eq 'solo' -and (Test-Inside $g.Location $KbRoot) -and -not (Test-VcsIgnored $g.Location)) {
                Write-Log 'WARN' "$tag`: profile solo keeps derived artifacts outside the versioned knowledge base (EK#5, EK#27), but the location is inside it and not ignored by version control"
            }
            if ($reg.Profile -eq 'team' -and (Get-VcsRoot $g.Location).Vcs -eq 'none') {
                Write-Log 'WARN' "$tag`: profile team versions its graphs (EK#5), but the location is not under version control"
            }
            $row = $reg.Status[$g.Id]
            $lastBuilt = ''
            if ($row -and $reg.StatusCols.LastBuilt -ge 0) { $lastBuilt = Get-CellValue (Get-Cell $row.Cells $reg.StatusCols.LastBuilt) }
            $stamped = ($lastBuilt -match '^\d{4}-\d{2}-\d{2}')
            if ($stamped) { $lastBuilt = $lastBuilt.Substring(0, 10) }
            $file = Join-Path $g.Location $GraphFile
            $onDisk = Test-Path -LiteralPath $file
            $fileDate = ''
            if ($onDisk) { $fileDate = (Get-Item -LiteralPath $file).LastWriteTime.ToString('yyyy-MM-dd') }
            if ($stamped -and -not $onDisk) { Write-Log 'WARN' "$tag`: Last Built $lastBuilt but no $GraphFile at the location" }
            elseif (-not $stamped -and $onDisk) { Write-Log 'WARN' "$tag`: $GraphFile exists (written $fileDate) but Last Built is empty - stamp it (-StampRegistry)" }
            elseif ($stamped -and $fileDate -ne $lastBuilt) { Write-Log 'WARN' "$tag`: stamp stale - Last Built $lastBuilt, $GraphFile written $fileDate (rebuild with -StampRegistry)" }
            elseif ($stamped) { Write-Log 'OK' "$tag`: Last Built $lastBuilt matches $GraphFile" }
            if (-not $stamped) { continue }
            if ($g.Kind -eq 'merged' -and (-not $g.Base -or -not $g.Overlay)) { Write-Log 'INFO' "$tag`: pair unresolved - code freshness not checked"; continue }
            # freshness contract: Last Built vs the code's last change
            $latest = ''; $unknown = @()
            foreach ($src in (Get-Sources $g)) {
                if (-not (Test-Path -LiteralPath $src)) { $unknown += "$src (not on this machine)"; continue }
                $info = Get-VcsRoot $src
                if ($info.Vcs -eq 'none') { $unknown += "$src (no VCS)"; continue }
                $d = Get-LastChange $info $src
                if (-not $d) { $unknown += "$src (no $($info.Vcs) date)"; continue }
                if ($d -gt $latest) { $latest = $d }
                $dirty = @(Get-LocalChanges $info $src)
                if ($dirty.Count -gt 0) { Write-Log 'INFO' "$tag`: $src has $($dirty.Count) uncommitted change(s): a build scans them as-is" }
            }
            if ($unknown.Count -gt 0) { Write-Log 'INFO' ("$tag`: code last change unknown for " + ($unknown -join '; ')) }
            if ($latest -and $latest -gt $lastBuilt) {
                Write-Log 'WARN' "$tag`: graph-stale - code changed $latest, after the last build ${lastBuilt} - rebuild, or mark graph-derived evidence graph-stale"
            } elseif ($latest) { Write-Log 'OK' "$tag`: fresh - code last changed $latest, built $lastBuilt" }
        }
    }
    # graph files on disk that no registry row points to (the job and the registry drifted)
    $registered = @($registries | ForEach-Object { $_.Graphs } | Where-Object { $_.Location } | ForEach-Object { (Get-FullPath $_.Location).ToLowerInvariant() })
    $skip = '[\\/](\.git|\.svn|\.hg|node_modules)([\\/]|$)'
    $found = @(Get-ChildItem -LiteralPath $KbRoot -Recurse -Depth ($Depth + 3) -Filter $GraphFile -File -ErrorAction SilentlyContinue)
    foreach ($f in $found) {
        $rel = '\' + (Get-Rel $f.FullName)
        if ($rel -match $skip -or $rel -match $CommitExclude) { continue }
        if ($registered -notcontains (Get-FullPath $f.DirectoryName).ToLowerInvariant()) {
            Write-Log 'WARN' "orphan graph: $(Get-Rel $f.FullName) is on disk but no registry row points to its folder"
        }
    }
}

# ---------- build ----------
function Get-ToolArgv($g, [string]$scanDir) {
    $argv = New-Object System.Collections.Generic.List[string]
    foreach ($tok in @($ToolArgs -split '\s+' | Where-Object { $_ })) {
        if ($tok -eq '{source}') { $argv.Add($scanDir) }
        elseif ($tok -eq '{out}') { $argv.Add($g.OutParent) }
        elseif ($tok -eq '{flags}') { foreach ($f in $g.Flags) { $argv.Add($f) } }
        else { $argv.Add($tok) }
    }
    return ,($argv.ToArray())
}
# Counts read straight from the graph file (node-link JSON). Parsing it also proves the file
# is whole: a large graph written to a network share was once truncated silently.
$countCode = "import json,sys;g=json.load(open(sys.argv[1],encoding='utf-8'));n=g.get('nodes',[]) if isinstance(g,dict) else [];e=g.get('links',g.get('edges',[])) if isinstance(g,dict) else [];c=set(x.get('community') for x in n if isinstance(x,dict) and x.get('community') is not None);print(len(n),len(e),len(c) if c else '-')"
function Get-GraphCounts([string]$file) {
    if (-not $script:hasPython) { return [pscustomobject]@{ Ok = $true; Nodes = '-'; Edges = '-'; Communities = '-'; Note = 'python not on PATH: counts skipped' } }
    $mb = (Get-Item -LiteralPath $file).Length / 1MB
    if ($mb -gt $CountMaxMB) { return [pscustomobject]@{ Ok = $true; Nodes = '-'; Edges = '-'; Communities = '-'; Note = ("{0:N0} MB is over -CountMaxMB: counts skipped" -f $mb) } }
    $r = Invoke-Native $Python @('-c', $countCode, $file)
    $parts = @((($r.Out | Select-Object -Last 1) -as [string]) -split '\s+' | Where-Object { $_ })
    if ($r.Code -ne 0 -or $parts.Count -ne 3) { return [pscustomobject]@{ Ok = $false; Note = ('graph file is not valid JSON (truncated write?): ' + (($r.Out | Select-Object -Last 1) -as [string])) } }
    return [pscustomobject]@{ Ok = $true; Nodes = $parts[0]; Edges = $parts[1]; Communities = $parts[2]; Note = '' }
}
function Invoke-Build($g) {
    $tag = "[$($g.Kind)] $($g.Id)"
    $scanDir = $g.Source
    if ($g.Kind -eq 'merged') {
        $scanDir = Join-Path $WorkRoot ($g.Id -replace '[^A-Za-z0-9._-]', '_')
        $mArgv = @($mergeScript, $g.Base.Source, $g.Overlay.Source, $scanDir) + @($MergeExclude | ForEach-Object { '--exclude'; $_ })
        if ($DryRun) { Write-Log 'PLAN' ("    " + (Format-Command $Python $mArgv)) }
        else {
            if (-not $script:hasPython) { Write-Log 'ERROR' "$tag - python not on PATH (needed by merge_tree.py)"; return $false }
            $r = Invoke-Native $Python $mArgv
            $r.Out | Where-Object { $_ -match '^merge_tree:' } | ForEach-Object { Write-Log 'INFO' "    $_" }
            if ($r.Code -ne 0) { Write-Log 'ERROR' "$tag - merge_tree.py failed (exit $($r.Code))"; return $false }
        }
    }
    $argv = Get-ToolArgv $g $scanDir
    if ($DryRun) { Write-Log 'PLAN' ("    cd `"$($g.OutParent)`"; " + (Format-Command $GraphTool $argv)); return $true }
    New-Item -ItemType Directory -Force -Path $g.OutParent | Out-Null
    $r = Invoke-Native $GraphTool $argv $g.OutParent
    $shown = @($r.Out | Where-Object { $_ -match $ToolLogPattern })
    if ($shown.Count -eq 0) { $shown = @($r.Out | Select-Object -Last 3) }
    $shown | Select-Object -First 20 | ForEach-Object { Write-Log 'INFO' "    $_" }
    if ($r.Code -ne 0) { Write-Log 'ERROR' "$tag - graph tool failed (exit $($r.Code))"; return $false }
    $file = Join-Path $g.Location $GraphFile
    if (-not (Test-Path -LiteralPath $file)) { Write-Log 'ERROR' "$tag - the tool exited 0 but there is no $GraphFile at the registered location $($g.Location)"; return $false }
    $counts = Get-GraphCounts $file
    if (-not $counts.Ok) { Write-Log 'ERROR' "$tag - $($counts.Note)"; return $false }
    if ($counts.Note) { Write-Log 'INFO' "    $($counts.Note)" }
    $g.Counts = $counts
    Write-Log 'OK' "$tag - built: $($counts.Nodes) nodes, $($counts.Edges) edges, $($counts.Communities) communities"
    return $true
}

# ---------- stamp ----------
function Update-Stamps($reg) {
    $built = @($reg.Graphs | Where-Object { $_.Built })
    if ($built.Count -eq 0) { return $true }
    if (-not $reg.StatusCols) { Write-Log 'WARN' "$($reg.Label) - no Build Status table: not stamped"; return $true }
    $info = Get-VcsRoot $reg.Path
    if ($info.Vcs -ne 'none') {
        $changes = @(Get-LocalChanges $info $reg.Path)
        if ($changes.Count -gt 0) {
            Write-Log 'WARN' "$($reg.Label) has local modifications ($($changes[0].Trim())): Build Status NOT stamped - commit or revert them, then stamp again"
            return $true
        }
    }
    $date = Get-Date -Format 'yyyy-MM-dd'
    $cols = $reg.StatusCols
    $ids = @()
    foreach ($g in $built) {
        $row = $reg.Status[$g.Id]
        if (-not $row) { continue }
        $cells = New-Object System.Collections.Generic.List[string]
        foreach ($cell in $row.Cells) { $cells.Add($cell) }
        $width = @($cols.Values | Measure-Object -Maximum).Maximum
        while ($cells.Count -le $width) { $cells.Add('') }
        $cells[$cols.LastBuilt] = $date
        if ($cols.Nodes -ge 0) { $cells[$cols.Nodes] = "$($g.Counts.Nodes)" }
        if ($cols.Edges -ge 0) { $cells[$cols.Edges] = "$($g.Counts.Edges)" }
        if ($cols.Communities -ge 0) { $cells[$cols.Communities] = "$($g.Counts.Communities)" }
        if ($cols.Notes -ge 0 -and $cells[$cols.Notes] -eq 'Not yet built') { $cells[$cols.Notes] = '-' }
        $reg.Lines[$row.Index] = '| ' + ($cells -join ' | ') + ' |'
        $ids += $g.Id
    }
    if ($ids.Count -eq 0) { return $true }
    if ($DryRun) { Write-Log 'PLAN' "stamp $($reg.Label): Last Built $date + counts for $($ids -join ', ')"; $reg.Stamped = $true; return $true }
    try {
        [System.IO.File]::WriteAllText($reg.Path, ($reg.Lines -join $reg.Nl), (New-Object System.Text.UTF8Encoding($false)))
        Write-Log 'OK' "stamped $($reg.Label): Last Built $date for $($ids -join ', ')"
        $reg.Stamped = $true
        return $true
    } catch { Write-Log 'ERROR' "stamp $($reg.Label) failed: $_"; return $false }
}

# ---------- commit (team profile, designated builder): ONLY the graph output folders ----------
# ... plus the registry files this run stamped (EK#12): Update-Stamps writes a registry only
# when it had no local modifications, so committing it never carries a human's edit.
function Invoke-Commit($graphs, $registryFiles) {
    $ok = $true
    $groups = @{}
    foreach ($g in $graphs) {
        $info = Get-VcsRoot $g.Location
        if ($info.Vcs -eq 'none') { Write-Log 'WARN' "commit: $($g.Location) is not under version control - skipped"; continue }
        if (-not (Test-VcsCli $info.Vcs)) { Write-Log 'WARN' "commit: $($info.Vcs) CLI not on PATH - $($g.Location) skipped"; continue }
        $key = "$($info.Vcs)|$($info.Root)"
        if (-not $groups.ContainsKey($key)) { $groups[$key] = [pscustomobject]@{ Info = $info; Paths = @(); Registries = @() } }
        if ($groups[$key].Paths -notcontains $g.Location) { $groups[$key].Paths += $g.Location }
    }
    foreach ($rf in @($registryFiles)) {
        if (-not $rf) { continue }
        $info = Get-VcsRoot (Split-Path -Parent $rf)
        if ($info.Vcs -eq 'none') { Write-Log 'WARN' "commit: registry $rf is not under version control - its stamp stays local"; continue }
        if (-not (Test-VcsCli $info.Vcs)) { continue }
        $key = "$($info.Vcs)|$($info.Root)"
        if (-not $groups.ContainsKey($key)) { $groups[$key] = [pscustomobject]@{ Info = $info; Paths = @(); Registries = @() } }
        if ($groups[$key].Registries -notcontains $rf) { $groups[$key].Registries += $rf }
    }
    foreach ($grp in $groups.Values) {
        $info = $grp.Info; $paths = $grp.Paths; $regs = @($grp.Registries)
        $files = @()
        foreach ($p in $paths) {
            $files += @(Get-ChildItem -LiteralPath $p -Recurse -File -ErrorAction SilentlyContinue |
                Where-Object { ('\' + $_.FullName.Substring($p.Length).TrimStart('\', '/')) -notmatch $CommitExclude } | ForEach-Object { $_.FullName })
        }
        if ($DryRun) {
            $regNote = ''
            if ($regs.Count -gt 0) { $regNote = " + stamped registr$(if ($regs.Count -eq 1) { 'y' } else { 'ies' }) $($regs -join '; ')" }
            Write-Log 'PLAN' "commit ($($info.Vcs), $($info.Root)): $($files.Count) file(s) under $($paths -join '; ')$regNote - message '$CommitMessage'"
            continue
        }
        if ($info.Vcs -eq 'svn') {
            $noIgnore = @('--config-option', 'config:miscellany:global-ignores=')
            foreach ($p in $paths) { Invoke-Native 'svn' (@('add', '--force', '--parents', '--depth', 'empty') + $noIgnore + @($p)) | Out-Null }
            # explicit per-file adds with global-ignores neutralised: a client-side ignore list
            # (e.g. *.md) would otherwise keep the graph report out of the commit
            for ($i = 0; $i -lt $files.Count; $i += 50) {
                $batch = @($files[$i..([Math]::Min($i + 49, $files.Count - 1))])
                Invoke-Native 'svn' (@('add', '--force', '--parents') + $noIgnore + $batch) | Out-Null
            }
            # explicit targets at depth empty: the newly added parent folders up to the first
            # versioned one, and each changed item under the graph folders - nothing else
            $targets = New-Object System.Collections.Generic.List[string]
            foreach ($p in $paths) {
                $anc = Split-Path -Parent $p
                while ($anc -and ($anc -ine $info.Root) -and (Test-Inside $anc $info.Root)) {
                    $st = @((Invoke-Native 'svn' @('status', '--depth', 'empty', $anc)).Out | Where-Object { $_ })
                    if ($st.Count -eq 0 -or $st[0] -notmatch '^A') { break }
                    if (-not $targets.Contains($anc)) { $targets.Add($anc) }
                    $anc = Split-Path -Parent $anc
                }
                foreach ($line in (Invoke-Native 'svn' @('status', $p)).Out) {
                    if ($line -match '^!\s+(.+)$') { Invoke-Native 'svn' @('delete', '--force', $Matches[1].Trim()) | Out-Null }
                }
                foreach ($line in (Invoke-Native 'svn' @('status', $p)).Out) {
                    if ($line.Length -le 8) { continue }
                    if ('ADMR'.Contains([string]$line[0]) -or $line[1] -eq 'M') {
                        $item = $line.Substring(8).Trim()
                        if (-not $targets.Contains($item)) { $targets.Add($item) }
                    }
                }
            }
            foreach ($rf in $regs) {
                $st = @((Invoke-Native 'svn' @('status', '--depth', 'empty', $rf)).Out | Where-Object { $_ })
                if ($st.Count -gt 0 -and $st[0] -match '^M' -and -not $targets.Contains($rf)) { $targets.Add($rf) }
            }
            if ($targets.Count -eq 0) { Write-Log 'INFO' "commit (svn, $($info.Root)): nothing changed in the graph paths or stamped registries"; continue }
            $r = Invoke-Native 'svn' (@('commit', '--depth', 'empty', '-m', $CommitMessage, '--non-interactive') + $targets.ToArray())
        } else {
            # never 'git add -u' without a pathspec: it would stage every tracked change in the clone
            if ($paths.Count -gt 0) { Invoke-Native 'git' (@('-C', $info.Root, 'add', '-u', '--') + $paths) | Out-Null }
            for ($i = 0; $i -lt $files.Count; $i += 50) {
                $batch = @($files[$i..([Math]::Min($i + 49, $files.Count - 1))])
                Invoke-Native 'git' (@('-C', $info.Root, 'add', '-f', '--') + $batch) | Out-Null
            }
            foreach ($rf in $regs) { Invoke-Native 'git' @('-C', $info.Root, 'add', '--', $rf) | Out-Null }
            $spec = @($paths) + $regs
            if ($spec.Count -eq 0) { continue }
            $staged = Invoke-Native 'git' (@('-C', $info.Root, 'diff', '--cached', '--quiet', '--') + $spec)
            if ($staged.Code -eq 0) { Write-Log 'INFO' "commit (git, $($info.Root)): nothing changed in the graph paths or stamped registries"; continue }
            # a pathspec commit takes ONLY these paths, whatever else is staged in the repository
            $r = Invoke-Native 'git' (@('-C', $info.Root, 'commit', '-m', $CommitMessage, '--') + $spec)
        }
        $r.Out | Select-Object -Last 2 | ForEach-Object { Write-Log 'INFO' "    $_" }
        if ($r.Code -ne 0) { Write-Log 'ERROR' "commit ($($info.Vcs), $($info.Root)) failed (exit $($r.Code))"; $ok = $false }
        else {
            $note = ''
            if ($info.Vcs -eq 'git') { $note = ' - committed locally; pushing is the builder''s own step' }
            Write-Log 'OK' "commit ($($info.Vcs), $($info.Root)): scoped to $($paths.Count) graph path(s) and $($regs.Count) stamped registr$(if ($regs.Count -eq 1) { 'y' } else { 'ies' })$note"
        }
    }
    return $ok
}

# =====================================================================================
# main
# =====================================================================================
if (-not $KbRoot) { Write-Host 'ERROR  -KbRoot (or the KB_ROOT environment variable) is required' -ForegroundColor Red; exit 2 }
if (-not (Test-Path -LiteralPath $KbRoot -PathType Container)) { Write-Host "ERROR  knowledge-base root not found: $KbRoot" -ForegroundColor Red; exit 2 }
$KbRoot = Get-FullPath (Resolve-Path -LiteralPath $KbRoot).ProviderPath
if ($CodeRoot) { $CodeRoot = Get-FullPath $CodeRoot }
$WorkRoot = Get-FullPath $WorkRoot
if (Test-Inside $WorkRoot $KbRoot) { Write-Host "ERROR  -WorkRoot is inside the knowledge base: the merged work tree holds hardlinks to source files and must live outside it ($WorkRoot)" -ForegroundColor Red; exit 2 }
if ($ToolArgs -notmatch '\{source\}' -or $ToolArgs -notmatch '\{out\}') { Write-Host "ERROR  -ToolArgs must contain {source} and {out}: $ToolArgs" -ForegroundColor Red; exit 2 }
New-Item -ItemType Directory -Force -Path $LogDir -WhatIf:$false | Out-Null
$script:logFile = Join-Path $LogDir 'rebuild-graphs.log'

if ($Register) {
    $skipKeys = @('Register', 'DryRun', 'WhatIf', 'Confirm', 'CheckRegistry', 'TaskName', 'At', 'Verbose', 'Debug', 'KbRoot', 'CodeRoot')
    $parts = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', ('"' + $PSCommandPath + '"'), '-KbRoot', ('"' + $KbRoot + '"'))
    if ($CodeRoot) { $parts += @('-CodeRoot', ('"' + $CodeRoot + '"')) }
    foreach ($k in @($PSBoundParameters.Keys | Sort-Object)) {
        if ($skipKeys -contains $k) { continue }
        $v = $PSBoundParameters[$k]
        if ($v -is [System.Management.Automation.SwitchParameter]) { if ($v.IsPresent) { $parts += "-$k" }; continue }
        if ($v -is [array]) { $v = ($v -join ',') }
        $parts += @("-$k", ('"' + $v + '"'))
    }
    $argLine = $parts -join ' '
    if ($DryRun) { Write-Log 'PLAN' "register scheduled task '$TaskName' (daily $At, start when available, 3 h limit): powershell.exe $argLine"; exit 0 }
    $action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $argLine
    $trigger = New-ScheduledTaskTrigger -Daily -At $At
    $settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Hours 3)
    Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Settings $settings -Force | Out-Null
    Write-Log 'OK' "scheduled task '$TaskName' registered (daily $At): powershell.exe $argLine"
    exit 0
}

$mode = 'rebuild'
if ($CheckRegistry) { $mode = 'check' } elseif ($DryRun) { $mode = 'dry-run' }
Write-Log 'INFO' "===== graph rebuild ($mode) - kb $KbRoot - builder $BuilderName ====="
$script:hasPython = Test-Cmd $Python
$failed = 0
try {
    $regFiles = @(Get-ChildItem -LiteralPath $KbRoot -Recurse -Depth $Depth -Filter $RegistryPattern -File -ErrorAction SilentlyContinue |
        Where-Object { ('\' + (Get-Rel $_.FullName)) -notmatch $ExcludePattern })
    if ($regFiles.Count -eq 0) { Write-Log 'WARN' "no $RegistryPattern under $KbRoot - nothing to do"; exit 0 }
    $registries = @($regFiles | ForEach-Object { Read-Registry $_ })
    Test-Structure $registries
    $allGraphs = @($registries | ForEach-Object { $_.Graphs } | ForEach-Object { $_ })

    if ($CheckRegistry -or $DryRun) { Test-Freshness $registries }
    if ($CheckRegistry) {
        $verdict = 'match'
        if ($script:warnCount -gt 0) { $verdict = "$($script:warnCount) warning(s)" }
        Write-Log 'INFO' "registry check: $($registries.Count) registries, $($allGraphs.Count) graphs - $verdict (warn-only)"
        exit 0
    }

    $order = @{ 'base' = 0; 'overlay' = 1; 'merged' = 2 }
    $todo = @($allGraphs | Where-Object { $_.Registry.Builds -and $_.Problems.Count -eq 0 } | Sort-Object { $order[$_.Kind] })
    $seen = @{}
    foreach ($g in $todo) {
        $k = (Get-FullPath $g.Location).ToLowerInvariant()
        if ($seen.ContainsKey($k)) { $g.DupOf = $seen[$k]; Write-Log 'INFO' "$($g.Registry.Label) - graph '$($g.Id)' shares its location with '$($seen[$k].Id)': built once" }
        else { $seen[$k] = $g }
    }
    $build = @($todo | Where-Object { -not $_.DupOf })
    if ($build.Count -eq 0) { Write-Log 'INFO' 'nothing to rebuild on this machine'; exit 0 }
    if (-not (Test-Cmd $GraphTool)) {
        if (-not $DryRun) { Write-Log 'ERROR' "graph tool '$GraphTool' not on PATH (install-graph-tool.ps1)"; exit 1 }
        Write-Log 'WARN' "graph tool '$GraphTool' not on PATH (install-graph-tool.ps1)"
    }

    # team builder: bring the versioned graph folders current first (incoming wins - they are rebuilt next)
    $commitGraphs = @()
    if ($Commit) {
        foreach ($reg in $registries) {
            if (@($build | Where-Object { $_.Registry -eq $reg }).Count -eq 0) { continue }
            if ($reg.Profile -ne 'team') { Write-Log 'WARN' "$($reg.Label) - profile $($reg.Profile): graphs are not versioned, -Commit ignored for it (EK#5)"; continue }
            if (-not $reg.CommitOk) { Write-Log 'WARN' "$($reg.Label) - no designated builder declared: -Commit refused for it"; continue }
            $commitGraphs += @($todo | Where-Object { $_.Registry -eq $reg })
        }
        foreach ($g in @($commitGraphs | Where-Object { -not $_.DupOf })) {
            $info = Get-VcsRoot $g.Location
            if ($info.Vcs -ne 'svn' -or -not (Test-Path -LiteralPath $g.Location)) { continue }
            if ($DryRun) { Write-Log 'PLAN' "svn update $($g.Location) --accept theirs-full"; continue }
            $r = Invoke-Native 'svn' @('update', $g.Location, '--non-interactive', '--accept', 'theirs-full')
            Write-Log 'INFO' ("svn update graphs $($g.Id): " + (($r.Out | Select-Object -Last 1) -as [string]))
        }
        if (@($commitGraphs | Where-Object { (Get-VcsRoot $_.Location).Vcs -eq 'git' }).Count -gt 0) {
            Write-Log 'INFO' 'git: graph folders are not refreshed per path - keep the builder clone current before the job'
        }
    }

    # code working copies: update only when clean (with -UpdateCode); dirty = scan as-is
    $sources = @($build | ForEach-Object { Get-Sources $_ } | Sort-Object -Unique)
    foreach ($src in $sources) {
        $info = Get-VcsRoot $src
        if ($info.Vcs -eq 'none') { Write-Log 'INFO' "code $src - no VCS: scanned as-is"; continue }
        $scope = $src
        if ($info.Vcs -eq 'git') { $scope = $info.Root }   # git pull updates the whole repository
        $changes = @(Get-LocalChanges $info $scope)
        if ($changes.Count -gt 0) {
            Write-Log 'INFO' "code $src - $($info.Vcs), $($changes.Count) local modification(s): NOT updated, scanned as-is"
            $changes | Select-Object -First 5 | ForEach-Object { Write-Log 'INFO' "    $_" }
            continue
        }
        if (-not $UpdateCode) { Write-Log 'INFO' "code $src - $($info.Vcs), clean (pass -UpdateCode to update it first)"; continue }
        if ($DryRun) { Write-Log 'PLAN' "code $src - $($info.Vcs), clean: would update"; continue }
        $r = Update-WorkingCopy $info $src
        Write-Log 'INFO' ("code $src - $($info.Vcs) update: " + (($r.Out | Select-Object -Last 1) -as [string]))
        if ($r.Code -ne 0) { Write-Log 'WARN' "code $src - update failed (exit $($r.Code)): scanned as it is" }
    }

    foreach ($g in $build) {
        Write-Log $(if ($DryRun) { 'PLAN' } else { 'INFO' }) "[$($g.Kind)] $($g.Id) <- $(@(Get-Sources $g) -join ' + ')  ($($g.Registry.Label))"
        if (Invoke-Build $g) { $g.Built = $true } else { $g.Failed = $true; $failed++ }
    }
    foreach ($g in @($todo | Where-Object { $_.DupOf })) { $g.Built = $g.DupOf.Built; $g.Failed = $g.DupOf.Failed; $g.Counts = $g.DupOf.Counts }

    if ($StampRegistry) {
        foreach ($reg in $registries) {
            if ($DryRun) { foreach ($g in $reg.Graphs) { if ($g.Built -and -not $g.Counts) { $g.Counts = [pscustomobject]@{ Nodes = '<n>'; Edges = '<n>'; Communities = '<n>' } } } }
            if (-not (Update-Stamps $reg)) { $failed++ }
        }
    }
    if ($Commit) {
        $done = @($commitGraphs | Where-Object { $_.Built -and -not $_.DupOf })
        # EK#12: the registries stamped in this run (clean before the stamp) ride along
        $stampedRegs = @($registries | Where-Object { $_.Stamped -and $_.Profile -eq 'team' -and $_.CommitOk } | ForEach-Object { $_.Path })
        if ($done.Count -gt 0) { if (-not (Invoke-Commit $done $stampedRegs)) { $failed++ } }
        else { Write-Log 'INFO' 'commit: no graph eligible (team profile, designated builder, built in this run)' }
    }
    $builtCount = @($build | Where-Object { $_.Built }).Count
    if ($DryRun) { Write-Log 'INFO' "===== dry run: $($build.Count) graph(s) planned, $($script:warnCount) warning(s); nothing was run =====" ; exit 0 }
    Write-Log 'INFO' "===== graph rebuild finished: $builtCount built, $failed failure(s), $($script:warnCount) warning(s) ====="
    if ($failed -gt 0) { exit 1 }
    exit 0
} catch {
    Write-Log 'ERROR' "aborted: $_"
    exit 1
}
