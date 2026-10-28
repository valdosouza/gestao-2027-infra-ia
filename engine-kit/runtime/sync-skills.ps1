# sync-skills.ps1 - links skill folders from layered sources into local discovery
# folders (engine-kit runtime, layer 2). Windows only.
#
# In Claude Code the kit installs as a plugin: that is the primary mechanism for the
# kit's own skills. This script covers the rest: project and case skill layers, and
# any tool that discovers skills in a local folder (e.g. ~\.claude\skills,
# ~\.cursor\skills).
#
# Mechanism: one directory junction per skill, <target>\<name> -> <winning source>\<name>.
# The tools read each skill IN PLACE: nothing is copied, so an edit made through the
# link lands in the source working copy (visible to its version control) instead of
# being lost on the next sync.
#
# Precedence: -Source lists the folders from lowest to highest precedence, normally
#   kit < project < case. A skill (a subfolder holding SKILL.md) in a later source
#   overrides the skill of the same name from an earlier source.
#
# Rules:
#   - The sources are the single source of truth. Never edit a skill anywhere else.
#   - Local-only entries of a target are never touched: real folders that are not a
#     synced skill name, and links that point outside every source.
#   - Nothing is deleted. A real folder that has the name of a synced skill (an old
#     copied mirror) is MOVED to <target-parent>\_pre-junction-backup\<date>\<target-leaf>\
#     (or under -BackupRoot) before the junction takes its place.
#   - A junction is removed with Directory.Delete, which removes the pointer only.
#     A link that points into a source but no longer wins (the skill was renamed,
#     removed or overridden) is stale and is removed that way.
#   - Optional: -AgentsSource links one whole agents folder at -AgentsTarget.
#
# Adoption level (optional; docs\ADOPTION-LEVELS.md): -Level 1|2|3 links only the kit
#   skills placed at that level and below (levels add up: 2 = 1 + 2). The lists come from
#   runtime\levels.json, generated from that page by runtime\levels.py; kit_lint fails
#   when the two disagree. Without -Level every skill of the sources is linked.
#   - Selection is by name, after precedence: an override keeps the level of the kit
#     skill it replaces; a project or case skill that no level places is linked at
#     every level.
#   - -Track legacy|greenfield (with -Level) also leaves out the kit skills that serve
#     only the other track - the other track's entry pieces (rule 5 of the page; the
#     "tracks" of levels.json, from the page's Track column). A skill marked "<track>
#     (both from level N)" serves both tracks from level N of the case. Without -Track the
#     pieces of both tracks are linked, with a warning.
#   - -Borrow links named skills of a higher level, or of the other track, anyway.
#     Borrowing is not moving up: each borrowed piece is a numbered decision of the case.
#   - Moving down removes the junctions of the skills above the level by the stale rule
#     above: pointers only, never a real folder, never a link that points outside the
#     sources.
#   - Agents are not split by level: -AgentsSource still links the whole folder (a link
#     to a single file needs elevation or Developer Mode on Windows, and a hard link
#     goes stale on the next update). The case's adoption line governs the agents, as
#     it does in the plugin.
#
# Windows note: directory junctions are NTFS reparse points. They need no elevation
# and no Developer Mode, but both the link and its target must be on local volumes
# (a junction cannot point to a network share). On macOS/Linux, reproduce the same
# layout with symbolic links (ln -s); this script does not run there.
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File sync-skills.ps1 `
#       -Source '<kit>\skills;<project>\skills;<case>\skills' `
#       -Target '<home>\.claude\skills;<home>\.cursor\skills' `
#       [-Level 1|2|3 [-Track legacy|greenfield] [-Borrow '<skill>;<skill>']] [-WhatIf]
#   From a PowerShell prompt, arrays work too:  .\sync-skills.ps1 -Source a,b,c -Target x
#   (with -File, separate several folders or skills with ';').
# -WhatIf prints every action and changes nothing (-Confirm asks before each one).
# Exit codes: 0 = done, 1 = error (e.g. -Level without a readable levels.json, -Track
#   with a levels.json that has no track data), 2 = bad arguments.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)][string[]]$Source,
    [Parameter(Mandatory = $true)][string[]]$Target,
    [string]$AgentsSource = '',
    [string]$AgentsTarget = '',
    [string]$BackupRoot = '',
    [int]$Level = 0,
    [string]$Track = '',
    [string[]]$Borrow = @()
)

$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Platform -ne [System.PlatformID]::Win32NT) {
    Write-Error 'sync-skills.ps1 uses NTFS junctions and runs on Windows only (use ln -s elsewhere)' -ErrorAction Continue
    exit 2
}
function Split-List([string[]]$items) {
    return @($items | ForEach-Object { $_ -split ';' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}
$Source = Split-List $Source
$Target = Split-List $Target
if ($AgentsSource -and -not $AgentsTarget) { Write-Error '-AgentsSource needs -AgentsTarget' -ErrorAction Continue; exit 2 }
$Borrow = Split-List $Borrow
if ($Level -lt 0 -or $Level -gt 3) { Write-Error '-Level is 1, 2 or 3 (omit it to link every skill)' -ErrorAction Continue; exit 2 }
if ($Borrow.Count -gt 0 -and $Level -eq 0) { Write-Error '-Borrow needs -Level (without it every skill is linked)' -ErrorAction Continue; exit 2 }
$Track = $Track.Trim().ToLowerInvariant()
if ($Track -and @('legacy', 'greenfield') -notcontains $Track) { Write-Error '-Track is legacy or greenfield (the track of the adoption line)' -ErrorAction Continue; exit 2 }
if ($Track -and $Level -eq 0) { Write-Error '-Track needs -Level (without it every skill is linked; -Level 3 -Track <track> for every level)' -ErrorAction Continue; exit 2 }

$Today = Get-Date -Format 'yyyy-MM-dd'
function Norm([string]$p) { return [System.IO.Path]::GetFullPath($p).TrimEnd('\').ToLowerInvariant() }
function Test-Entry([string]$p) {
    # true for a broken junction too (Test-Path follows the link and says false)
    return ([System.IO.Directory]::Exists($p) -or [System.IO.File]::Exists($p))
}
function Test-Link([string]$p) {
    # LinkType, not the ReparsePoint attribute: cloud-sync placeholders are reparse points too
    $i = Get-Item -LiteralPath $p -Force
    return ($i.LinkType -eq 'Junction' -or $i.LinkType -eq 'SymbolicLink')
}
function Get-LinkTarget([string]$p) {
    $t = (Get-Item -LiteralPath $p -Force).Target
    if ($t -is [array]) { $t = $t[0] }
    return [string]$t
}
function Remove-Link([string]$p) {
    if (-not (Test-Link $p)) { throw "not a link, refusing to remove: $p" }
    if ($PSCmdlet.ShouldProcess($p, 'remove junction (pointer only)')) {
        [System.IO.Directory]::Delete($p)
    }
}
function Move-Aside([string]$p, [string]$backupDir) {
    # move an old real copy out of the way; never delete it
    if (Test-Link $p) { throw "is a link, refusing to move: $p" }
    $dest = Join-Path $backupDir (Split-Path $p -Leaf)
    if (Test-Entry $dest) { $dest = $dest + '-' + (Get-Date -Format 'HHmmss') }
    if ($PSCmdlet.ShouldProcess($p, "move aside to $dest")) {
        New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
        Move-Item -LiteralPath $p -Destination $dest
        Write-Host "moved  $p -> $dest" -ForegroundColor DarkYellow
    }
}
function Set-Junction([string]$link, [string]$target, [string]$backupDir) {
    if (Test-Entry $link) {
        if (Test-Link $link) {
            if ((Norm (Get-LinkTarget $link)) -eq (Norm $target)) { return 'ok' }
            Remove-Link $link
        } else {
            Move-Aside $link $backupDir
        }
    }
    if ($PSCmdlet.ShouldProcess($link, "create junction -> $target")) {
        New-Item -ItemType Junction -Path $link -Target $target | Out-Null
        Write-Host "linked $link -> $target" -ForegroundColor DarkGreen
    }
    return 'linked'
}
function Get-BackupDir([string]$folder) {
    $leaf = Split-Path $folder -Leaf
    if ($BackupRoot) { return (Join-Path (Join-Path $BackupRoot $Today) $leaf) }
    return (Join-Path (Join-Path (Split-Path $folder -Parent) ('_pre-junction-backup\' + $Today)) $leaf)
}

# ---------- precedence: later sources override earlier ones, by skill name ----------
$winner = @{}      # skill name -> full path of the winning skill folder
$origin = @{}      # skill name -> source folder it came from
$order = New-Object System.Collections.Generic.List[string]
$sourceNorms = @()
foreach ($src in $Source) {
    if (-not (Test-Path -LiteralPath $src -PathType Container)) { Write-Host "skip   missing source: $src" -ForegroundColor DarkGray; continue }
    $srcFull = (Resolve-Path -LiteralPath $src).ProviderPath.TrimEnd('\')
    $sourceNorms += (Norm $srcFull)
    foreach ($d in (Get-ChildItem -LiteralPath $srcFull -Directory | Sort-Object Name)) {
        if (-not (Test-Path -LiteralPath (Join-Path $d.FullName 'SKILL.md'))) {
            Write-Host "skip   no SKILL.md: $($d.FullName)" -ForegroundColor DarkGray
            continue
        }
        if ($winner.ContainsKey($d.Name)) {
            Write-Host "over   $($d.Name): $srcFull overrides $($origin[$d.Name])" -ForegroundColor Cyan
        } else {
            $order.Add($d.Name)
        }
        $winner[$d.Name] = $d.FullName
        $origin[$d.Name] = $srcFull
    }
}
if ($sourceNorms.Count -eq 0) { Write-Error 'no source folder exists; nothing to link' -ErrorAction Continue; exit 2 }

# ---------- adoption level: keep the kit skills of this level and below ----------
# A skill left out here is no longer a winner, so its old junction (if any) is stale below.
if ($Level -gt 0) {
    $levelsPath = Join-Path $PSScriptRoot 'levels.json'
    $levelOf = @{}     # kit skill name -> its level
    $levelName = @{}   # level number -> name
    $trackOf = @{}     # kit skill name -> the one track it serves (absent: both tracks)
    $bothFrom = @{}    # kit skill name -> the case level from which it serves both tracks
    $hasTracks = $false
    try {
        $levelsData = Get-Content -LiteralPath $levelsPath -Raw -ErrorAction Stop | ConvertFrom-Json
        foreach ($l in @($levelsData.levels)) {
            $levelName[[int]$l.level] = [string]$l.name
            $names = @($l.skills | Where-Object { $_ } | ForEach-Object { [string]$_ })
            foreach ($n in $names) { $levelOf[$n] = [int]$l.level }
            if ($l.PSObject.Properties['tracks']) {
                $hasTracks = $true
                foreach ($p in @($l.tracks.PSObject.Properties)) {
                    if ($names -notcontains $p.Name) { continue }          # an agent: not linked by level
                    $trackOf[$p.Name] = ([string]$p.Value.track).ToLowerInvariant()
                    if ($p.Value.PSObject.Properties['both_from_level']) { $bothFrom[$p.Name] = [int]$p.Value.both_from_level }
                }
            }
        }
    } catch {
        Write-Error "-Level needs a readable $levelsPath (python runtime\levels.py --write): $($_.Exception.Message)" -ErrorAction Continue
        exit 1
    }
    if (-not $levelName.ContainsKey($Level) -or $levelOf.Count -eq 0) {
        Write-Error "$levelsPath places no skill at level $Level (python runtime\levels.py --check)" -ErrorAction Continue
        exit 1
    }
    if ($Track -and -not $hasTracks) {
        Write-Error "-Track needs the track data of $levelsPath (python runtime\levels.py --write)" -ErrorAction Continue
        exit 1
    }
    if (-not $Track -and $trackOf.Count -gt 0) {
        Write-Warning ('no -Track: the pieces of both tracks are linked, the other track''s entry pieces too ' +
                       '(pass -Track legacy|greenfield, the track of the adoption line)')
    }
    function Get-OffTrack([string]$n) {
        # the one track a skill serves when that is not the case's track at the case's level; '' otherwise
        if (-not $Track -or -not $trackOf.ContainsKey($n)) { return '' }
        if ($trackOf[$n] -eq $Track) { return '' }
        if ($bothFrom.ContainsKey($n) -and $Level -ge $bothFrom[$n]) { return '' }
        return $trackOf[$n]
    }
    foreach ($b in $Borrow) {
        if (-not $levelOf.ContainsKey($b)) { Write-Warning "borrow $($b): no level places it (a project or case skill is linked at every level)" }
        elseif ($levelOf[$b] -le $Level -and -not (Get-OffTrack $b)) { Write-Host "borrow $($b) is level $($levelOf[$b]): already on" -ForegroundColor DarkGray }
    }
    $kitSkills = Join-Path (Split-Path $PSScriptRoot -Parent) 'skills'
    $kept = New-Object System.Collections.Generic.List[string]
    $above = 0
    $otherTrack = 0
    foreach ($n in $order) {
        if (-not $levelOf.ContainsKey($n)) {
            if (Test-Path -LiteralPath (Join-Path (Join-Path $kitSkills $n) 'SKILL.md')) {
                Write-Warning "$($n) is a kit skill that no level places; linked (python runtime\levels.py --check)"
            } else {
                Write-Host "own    $($n): no level places it (a project or case skill), linked" -ForegroundColor DarkGray
            }
            $kept.Add($n)
            continue
        }
        $off = Get-OffTrack $n
        if ($levelOf[$n] -le $Level -and -not $off) {
            $kept.Add($n)
        } elseif ($Borrow -contains $n) {
            $why = if ($levelOf[$n] -gt $Level) { "level $($levelOf[$n])" } else { "track $off" }
            Write-Host "borrow $($n): $why, linked by a decision of the case" -ForegroundColor Cyan
            $kept.Add($n)
        } elseif ($levelOf[$n] -gt $Level) {
            Write-Host "level  $($n): level $($levelOf[$n]), above $Level - not linked" -ForegroundColor DarkGray
            [void]$winner.Remove($n)
            $above++
        } else {
            Write-Host "track  $($n): serves only the $off track at level $Level - not linked" -ForegroundColor DarkGray
            [void]$winner.Remove($n)
            $otherTrack++
        }
    }
    $order = $kept
    $trackText = if ($Track) { ", track $Track" } else { '' }
    $otherText = if ($Track) { ", $otherTrack of the other track left out" } else { '' }
    Write-Host "level  $Level ($($levelName[$Level])) and below$($trackText): $($order.Count) skill(s) to link, $above above the level left out$otherText" -ForegroundColor Cyan
}

$stats = @{ ok = 0; linked = 0; stale = 0 }

# ---------- skills: one junction per winning skill, in every target ----------
foreach ($dest in $Target) {
    $destFull = [System.IO.Path]::GetFullPath($dest).TrimEnd('\')
    $destNorm = Norm $destFull
    $overlaps = @($sourceNorms | Where-Object { $_ -eq $destNorm -or $_.StartsWith($destNorm + '\') -or $destNorm.StartsWith($_ + '\') })
    if ($overlaps.Count -gt 0) { Write-Warning "target overlaps a source, skipped: $destFull"; continue }
    if (-not (Test-Entry $destFull)) {
        if ($PSCmdlet.ShouldProcess($destFull, 'create target folder')) { New-Item -ItemType Directory -Force -Path $destFull | Out-Null }
    }
    $backupDir = Get-BackupDir $destFull
    foreach ($name in $order) {
        $r = Set-Junction (Join-Path $destFull $name) $winner[$name] $backupDir
        $stats[$r]++
    }
    # stale links: they point into a source, but their skill no longer wins under that name
    if (Test-Entry $destFull) {
        foreach ($e in (Get-ChildItem -LiteralPath $destFull -Directory -Force)) {
            if (-not (Test-Link $e.FullName)) { continue }                 # local-only real folder
            if ($winner.ContainsKey($e.Name)) { continue }                 # handled above
            $t = Norm (Get-LinkTarget $e.FullName)
            $intoSource = @($sourceNorms | Where-Object { $t.StartsWith($_ + '\') }).Count -gt 0
            if (-not $intoSource) { continue }                             # local-only link
            Write-Host "stale  $($e.FullName) -> $t" -ForegroundColor DarkYellow
            Remove-Link $e.FullName
            $stats.stale++
        }
    }
    Write-Host "ok     $destFull ($($order.Count) skills from $($sourceNorms.Count) source(s))" -ForegroundColor DarkGreen
}

# ---------- agents: one whole folder, optional ----------
if ($AgentsSource) {
    if (-not (Test-Path -LiteralPath $AgentsSource -PathType Container)) {
        Write-Warning "agents source not found, not linked: $AgentsSource"
    } else {
        $agentsSrcFull = (Resolve-Path -LiteralPath $AgentsSource).ProviderPath.TrimEnd('\')
        $agentsLink = [System.IO.Path]::GetFullPath($AgentsTarget).TrimEnd('\')
        $parent = Split-Path $agentsLink -Parent
        if (-not (Test-Entry $parent)) {
            if ($PSCmdlet.ShouldProcess($parent, 'create folder')) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
        }
        $backupDir = if ($BackupRoot) { Join-Path $BackupRoot $Today } else { Join-Path $parent ('_pre-junction-backup\' + $Today) }
        $r = Set-Junction $agentsLink $agentsSrcFull $backupDir
        $stats[$r]++
        Write-Host "ok     $agentsLink -> $agentsSrcFull" -ForegroundColor DarkGreen
        if ($Level -gt 0 -and $Level -lt 3) {
            Write-Host ("note   agents are not split by level: the whole folder is linked; the case's " +
                        'adoption line governs them, as in the plugin') -ForegroundColor DarkGray
        }
    }
}

$mode = if ($WhatIfPreference) { ' (WhatIf: nothing changed)' } else { '' }
Write-Host ("Done$mode. junctions ok: $($stats.ok), created: $($stats.linked), stale removed: $($stats.stale). " +
            'Local-only entries untouched; moved copies (if any) are under _pre-junction-backup.') -ForegroundColor Green
exit 0
