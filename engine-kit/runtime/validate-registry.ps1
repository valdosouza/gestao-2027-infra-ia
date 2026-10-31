# validate-registry.ps1 - registry-vs-reality validator (engine-kit runtime, layer 2)
#
# Fails loudly when a curated registry diverges from the actual state of the
# knowledge base. A registry row that contradicts the disk is a bug.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.
#
# Checks:
#   1. Subjects registry (-SubjectsRegistry, default REGISTRY_SUBJECTS.md, from
#      templates/REGISTRY_SUBJECTS.template.md): every registered subject has a
#      <SubjectFolder>\<NAME>\ folder; every such folder is registered; a subject
#      whose status is `documented` has an INDEX.md that is not a placeholder
#      (-PlaceholderPattern). A row is | NAME | ... | status [notes] | with NAME in
#      UPPER_SNAKE; the status is the FIRST word of the last cell, so notes may
#      follow it ("skeleton - pipelines next").
#   2. Graphs registry (-GraphsRegistry, default REGISTRY_GRAPHS.md, from
#      templates/REGISTRY_GRAPHS.template.md): for every graph of the
#      "## Build Status" table, a dated row must have -GraphFile at the location
#      registered in the architecture table, an undated row must not, and the
#      location itself must exist. Locations are absolute or relative to -Root.
#   3. Scope lines (skip with -NoScope): every knowledge .md carries exactly one
#      Scope line in the first 50 lines after a YAML front matter (a front matter
#      opened on line 1 and closed within 500 lines; otherwise from the top - the same
#      window as runtime/close/close.py), outside fenced code blocks, with a known
#      value. Canonical token and values: `**Scope**: method | case | mixed`.
#      Accepted aliases: token `**Escopo**:`; values `metodo` (= method), `misto`
#      (= mixed) and every value passed in -CaseValues (a case names its own
#      value, e.g. its case key; it counts as `case`). A frozen source - a file
#      the method forbids editing: the owner's draft copied byte-identical, an
#      archived official source, any file whose line numbers are cited as ids -
#      carries no Scope line: -FrozenPattern (a regex over the root-relative path
#      with forward slashes) leaves it out and counts it apart. The default is the
#      frozen draft of the frame-greenfield skill (prompt_<front>-draft.md,
#      prompt_<front>-draft-2.md); '(?!)' turns it off.
#
# Where registries are found: every file named -SubjectsRegistry / -GraphsRegistry
# under -Root (down to -Depth levels, minus -ExcludePattern). The base a registry
# describes is the folder that holds it, or that folder's parent when it is a
# `_REGISTRY` folder (older layout: -SubjectsRegistry SUBJECTS.md -GraphsRegistry GRAPHS.md).
# -ExcludePattern is matched against the path relative to -Root.
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File validate-registry.ps1 -Root <kb-root>
#       [-CaseValues <key>[,<key>]] [-NoScope] [-SubjectsRegistry <file>] [-GraphsRegistry <file>]
#       [-SubjectFolder SUBJECT] [-GraphFile graph.json] [-ExcludePattern <regex>] [-Depth 6]
#       [-FrozenPattern <regex>]
# Exit codes: 0 = clean, 1 = drift found, 2 = bad arguments.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Root,
    [string]$SubjectsRegistry = 'REGISTRY_SUBJECTS.md',
    [string]$GraphsRegistry = 'REGISTRY_GRAPHS.md',
    [string]$SubjectFolder = 'SUBJECT',
    [string]$GraphFile = 'graph.json',
    [string]$PlaceholderPattern = 'To be populated',
    [string[]]$CaseValues = @(),
    [int]$Depth = 6,
    [switch]$NoScope,
    # VCS and tool folders, generated graph output (e.g. <tool>-out, <tool>-merged) and
    # the kit's own templates, whose Scope line is a placeholder by design.
    [string]$ExcludePattern = '[\\/](\.git|\.svn|\.hg|\.obsidian|\.trash|\.runtime|node_modules|__pycache__|cache)([\\/]|$)|[\\/]graph[^\\/]*-(out|merged)([\\/]|$)|\.template\.md$',
    # Frozen sources (check 3): never edited, so never marked; matched against the
    # root-relative path with forward slashes.
    [string]$FrozenPattern = '(^|/)prompt_[^/]*-draft(-[^/]*)?\.md$'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Root -PathType Container)) {
    Write-Host "ERROR  root folder not found: $Root" -ForegroundColor Red
    exit 2
}
$Root = (Resolve-Path -LiteralPath $Root).ProviderPath.TrimEnd('\', '/')
# with -File, "-CaseValues a,b" arrives as one string: split it
$CaseValues = @($CaseValues | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })

$drift = New-Object System.Collections.Generic.List[string]
function Add-Drift([string]$msg) { $script:drift.Add($msg); Write-Host "DRIFT  $msg" -ForegroundColor Red }
function Ok([string]$msg) { Write-Host "ok     $msg" -ForegroundColor DarkGreen }
function Note([string]$msg) { Write-Host "note   $msg" -ForegroundColor DarkGray }

function Get-Rel([string]$full) { return $full.Substring($Root.Length).TrimStart('\', '/') }
function Test-Excluded([string]$full) { return (('\' + (Get-Rel $full)) -match $ExcludePattern) }
function Read-Lines([string]$path, [int]$count = 0) {
    if ($count -gt 0) { return @(Get-Content -LiteralPath $path -Encoding UTF8 -TotalCount $count) }
    return @(Get-Content -LiteralPath $path -Encoding UTF8)
}
function Test-Fence([string]$line) { return ($line -match '^\s*(```|~~~)') }
# The Scope window: 50 lines after a YAML front matter (opened by --- on line 1, closed by
# --- or ... within 500 lines), else the first 50 lines; a long claims front matter never
# pushes the Scope line out of reach.
function Read-ScopeWindow([string]$path) {
    $lines = @(Read-Lines $path 551)
    $start = 0
    if ($lines.Count -gt 0 -and $lines[0].Trim() -eq '---') {
        for ($i = 1; $i -lt [Math]::Min($lines.Count, 501); $i++) {
            if ($lines[$i].Trim() -eq '---' -or $lines[$i].Trim() -eq '...') { $start = $i + 1; break }
        }
    }
    if ($start -ge $lines.Count) { return @() }
    $end = [Math]::Min($lines.Count, $start + 50) - 1
    return @($lines[$start..$end])
}
function Find-Registry([string]$name) {
    return @(Get-ChildItem -LiteralPath $Root -Recurse -Depth $Depth -Filter $name -File -ErrorAction SilentlyContinue |
             Where-Object { -not (Test-Excluded $_.FullName) })
}
function Get-BaseOf($reg) {
    $dir = $reg.DirectoryName
    if ((Split-Path $dir -Leaf) -eq '_REGISTRY') { return (Split-Path $dir -Parent) }
    return $dir
}
function Get-Label([string]$base) {
    $label = Get-Rel $base
    if (-not $label) { return '.' }
    return $label
}

# ---------- 1. subjects registry vs subject folders ----------
$subjectRegs = Find-Registry $SubjectsRegistry
if ($subjectRegs.Count -eq 0) { Note "no $SubjectsRegistry under the root (subjects check skipped)" }
foreach ($reg in $subjectRegs) {
    $base = Get-BaseOf $reg
    $label = Get-Label $base
    $subjectDir = Join-Path $base $SubjectFolder
    $before = $drift.Count

    $rows = @{}
    $fence = $false
    foreach ($line in (Read-Lines $reg.FullName)) {
        if (Test-Fence $line) { $fence = -not $fence; continue }
        if ($fence) { continue }
        # | NAME | path | units | status [notes] |   (-cmatch: the header row 'Subject' must not match)
        if ($line -cmatch '^\|\s*([A-Z][A-Z0-9_]+)\s*\|.*\|\s*([a-z-]+)\b[^|]*\|\s*$') {
            $rows[$Matches[1]] = $Matches[2]
        }
    }
    $folders = @()
    if (Test-Path -LiteralPath $subjectDir) { $folders = @((Get-ChildItem -LiteralPath $subjectDir -Directory).Name) }

    if ($rows.Count -eq 0 -and $folders.Count -eq 0) {
        Ok "$label - subjects registry empty and no $SubjectFolder folders (placeholder base)"
        continue
    }
    foreach ($name in $rows.Keys) {
        if ($folders -notcontains $name) { Add-Drift "$label - subject '$name' registered but $SubjectFolder\$name\ does not exist" }
    }
    foreach ($f in $folders) {
        if (-not $rows.ContainsKey($f)) { Add-Drift "$label - folder $SubjectFolder\$f\ exists but is not registered in $($reg.Name)" }
    }
    foreach ($name in $rows.Keys) {
        if ($rows[$name] -ne 'documented') { continue }
        $index = Join-Path $subjectDir "$name\INDEX.md"
        if (-not (Test-Path -LiteralPath $index)) { Add-Drift "$label - '$name' is 'documented' but has no INDEX.md"; continue }
        if (Select-String -LiteralPath $index -Pattern $PlaceholderPattern -Quiet) {
            Add-Drift "$label - '$name' is 'documented' but INDEX.md is still a placeholder ('$PlaceholderPattern')"
        }
    }
    if ($drift.Count -eq $before) { Ok "$label - $($reg.Name) matches $SubjectFolder\ ($($rows.Count) subjects)" }
}

# ---------- 2. graphs registry vs graph files on disk ----------
$graphRegs = Find-Registry $GraphsRegistry
if ($graphRegs.Count -eq 0) { Note "no $GraphsRegistry under the root (graphs check skipped)" }
foreach ($reg in $graphRegs) {
    $label = Get-Label (Get-BaseOf $reg)
    $content = Read-Lines $reg.FullName

    # architecture table: | `name` | source | `location` | rebuild | purpose |
    $locations = @{}
    $fence = $false
    foreach ($line in $content) {
        if (Test-Fence $line) { $fence = -not $fence; continue }
        if ($fence) { continue }
        if ($line -match '^\|\s*`([^`]+)`\s*\|[^|]*\|\s*`([^`]+)`\s*\|') { $locations[$Matches[1]] = $Matches[2] }
    }
    # Build Status table only: | `name` | last built | nodes | ... | notes |
    $inBuildStatus = $false
    $fence = $false
    foreach ($line in $content) {
        if (Test-Fence $line) { $fence = -not $fence; continue }
        if ($fence) { continue }
        if ($line -match '^##\s') { $inBuildStatus = ($line -match '^##\s*Build Status') }
        if (-not $inBuildStatus) { continue }
        if ($line -notmatch '^\|\s*`([^`]+)`\s*\|\s*([^|]*)\|') { continue }
        $name = $Matches[1]; $lastBuilt = $Matches[2].Trim()
        if (-not $locations.ContainsKey($name)) { Add-Drift "$label - graph '$name' has a Build Status row but no location in the architecture table"; continue }
        # graph binaries usually live OUTSIDE the knowledge base: absolute locations are normal
        $loc = $locations[$name]
        if (-not [System.IO.Path]::IsPathRooted($loc)) { $loc = Join-Path $Root $loc }
        $file = Join-Path $loc $GraphFile
        $claimsBuilt = ($lastBuilt -match '^\d{4}')   # a date means built; dash or blank means not built
        $existsOnDisk = Test-Path -LiteralPath $file
        if (-not (Test-Path -LiteralPath $loc)) {
            Add-Drift "$label - graph '$name': registered location '$($locations[$name])' does not exist"
        } elseif ($claimsBuilt -and -not $existsOnDisk) {
            Add-Drift "$label - graph '$name': registry says built $lastBuilt but there is no $GraphFile at '$($locations[$name])'"
        } elseif (-not $claimsBuilt -and $existsOnDisk) {
            $f = Get-Item -LiteralPath $file
            $mb = [math]::Round($f.Length / 1MB)
            Add-Drift "$label - graph '$name': registry says not built but $GraphFile exists ($mb MB, $($f.LastWriteTime.ToString('yyyy-MM-dd')))"
        } else {
            Ok "$label - graph '$name' status matches disk"
        }
    }
}

# ---------- 3. Scope line coverage ----------
if (-not $NoScope) {
    $scopeMap = @{ 'method' = 'method'; 'metodo' = 'method'; 'case' = 'case'; 'mixed' = 'mixed'; 'misto' = 'mixed' }
    foreach ($v in $CaseValues) { $scopeMap[$v.ToLowerInvariant()] = 'case' }
    $counts = @{ 'method' = 0; 'case' = 0; 'mixed' = 0 }
    $files = @(Get-ChildItem -LiteralPath $Root -Recurse -Filter *.md -File -ErrorAction SilentlyContinue |
               Where-Object { -not (Test-Excluded $_.FullName) })
    $marked = 0
    $frozen = 0
    foreach ($f in $files) {
        $rel = Get-Rel $f.FullName
        if ($FrozenPattern -and (($rel -replace '\\', '/') -match $FrozenPattern)) { $frozen++; continue }
        $values = @()
        $fence = $false
        foreach ($line in (Read-ScopeWindow $f.FullName)) {
            # a Scope line quoted inside a fenced code block (a template, a planned file) is not this doc's
            if (Test-Fence $line) { $fence = -not $fence; continue }
            if ($fence) { continue }
            if ($line -match '^\*\*(Scope|Escopo)\*\*:\s*(.*)$') {
                $word = ($Matches[2].Trim() -split '\s+')[0]
                $values += $word.Trim([char[]]'`*_.,;:()[]"''').ToLowerInvariant()
            }
        }
        if ($values.Count -eq 0) { Add-Drift "no Scope line: $rel"; continue }
        if ($values.Count -gt 1) { Add-Drift "multiple Scope lines: $rel"; continue }
        if (-not $scopeMap.ContainsKey($values[0])) { Add-Drift "unknown Scope value '$($values[0])': $rel"; continue }
        $marked++
        $counts[$scopeMap[$values[0]]]++
    }
    Ok ("Scope coverage: $marked/$($files.Count - $frozen) knowledge docs marked (method $($counts['method']), " +
        "case $($counts['case']), mixed $($counts['mixed'])); $frozen frozen source(s) left unmarked")
}

# ---------- verdict ----------
Write-Host ''
if ($drift.Count -gt 0) {
    Write-Host "$($drift.Count) drift finding(s). Registries must match reality - fix or flag them." -ForegroundColor Red
    exit 1
}
Write-Host 'Clean: all registries match reality.' -ForegroundColor Green
exit 0
