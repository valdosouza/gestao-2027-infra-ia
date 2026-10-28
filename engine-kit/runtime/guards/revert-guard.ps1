# revert-guard.ps1 - recent-code removal guard (engine-kit runtime, guards).
#
# Detects when a local working-copy change REMOVES lines whose origin revision is recent
# (inside the blame window) - a likely accidental revert of someone else's fix - and says
# so AT FIX TIME, not after the commit and not in CI. Origin of the technique: a change
# for one ticket silently undid the fix of another, committed days before; QA found it
# weeks later.
#
# How: diff against the base revision (git HEAD / svn BASE) -> line numbers of the removed
# lines -> blame of the base revision -> origin revision, author and date of each removed
# line -> alert when that date is within -RecentDays. The ticket id, when the project
# configures a regex, is taken from the origin revision's commit message.
#
# Usage (CLI; plain text out, exit 1 when there is an alert, 0 = clean):
#   revert-guard.ps1 -Paths f1.js,f2.cs           -> analyse the given files
#   revert-guard.ps1 -Gate [-WcRoot <folder>]      -> every modified file the next commit carries
# Options: -Config <guards.json> (default: .engine-kit/guards.json found walking up from
#   -WcRoot or the first path; without one, built-in defaults), -RecentDays, -TicketRegex,
#   -Vcs git|svn (force the adapter).
# Hook use: hook.ps1 calls this script with -PassThru (returns the alert lines).
# Set REVERTGUARD_DEBUG=1 to trace the resolved working copy and files on stderr.

param(
    [int]$RecentDays = 0,
    [string]$TicketRegex = $null,
    [string]$WcRoot = '',
    [string[]]$Paths = @(),
    [switch]$Gate,
    [string]$Config = '',
    [string]$Vcs = '',
    [switch]$PassThru
)

$ErrorActionPreference = 'SilentlyContinue'
. (Join-Path $PSScriptRoot 'guard-common.ps1')
function Dbg([string]$m) { if ($env:REVERTGUARD_DEBUG) { [Console]::Error.WriteLine(('[revertguard {0:HH:mm:ss.fff}] {1}' -f (Get-Date), $m)) } }

if (-not $Gate -and $Paths.Count -eq 0) {
    Write-Output 'usage: revert-guard.ps1 -Paths <file>[,<file>] | -Gate [-WcRoot <folder>] [-Config <guards.json>]'
    exit 2
}
# with -File, "-Paths a,b" arrives as one string: split it (a path that exists as given is kept whole)
$Paths = @(foreach ($p in $Paths) { if (Test-Path -LiteralPath $p) { $p } else { $p -split ',' | ForEach-Object { $_.Trim() } } }) | Where-Object { $_ }
if ($Gate -and -not $WcRoot) { $WcRoot = (Get-Location).Path }

# precedence: explicit parameter > config file > built-in default
$section = $null
if (-not $Config) {
    $start = $WcRoot
    if (-not $start -and $Paths.Count -gt 0) { $start = $Paths[0] }
    $Config = Find-GuardConfig $start
}
if ($Config) {
    try { $section = Get-Cfg (Read-GuardConfig $Config) 'revert' $null } catch { Dbg "config not readable: $Config" }
}
if ($RecentDays -le 0) { $RecentDays = [int](Get-Cfg $section 'recentDays' 60) }
if (-not $PSBoundParameters.ContainsKey('TicketRegex')) { $TicketRegex = [string](Get-Cfg $section 'ticketRegex' '') }
$ticketRe = $null
if ($TicketRegex) {
    try { $ticketRe = New-Object System.Text.RegularExpressions.Regex($TicketRegex) } catch { Dbg "bad ticketRegex: $TicketRegex" }
}
Dbg "config=$Config recentDays=$RecentDays ticketRegex=$TicketRegex"

# ---------------------------------------------------------------- files to check
$files = @()
$gateVcs = $null
if ($Gate) {
    $gateVcs = Get-VcsInfo $WcRoot $Vcs
    Dbg "gate root: $WcRoot -> $(if ($gateVcs) { $gateVcs.Kind + ' ' + $gateVcs.Root } else { 'no working copy' })"
    if ($gateVcs) { $files = @(Get-VcsChangedFiles $gateVcs $WcRoot @('modified', 'replaced')) }
} else {
    $files = $Paths
}
Dbg ("files: " + ($files -join '; '))

# ---------------------------------------------------------------- analysis
$cutoff = (Get-Date).AddDays(-$RecentDays)
$msgCache = @{}
$alerts = @()

foreach ($file in $files) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { continue }
    $vcsInfo = $gateVcs
    if (-not $vcsInfo) { $vcsInfo = Get-VcsInfo $file $Vcs }
    if (-not $vcsInfo) { continue }                       # not inside a working copy

    $removed = @(Get-VcsRemovedLines $vcsInfo $file)
    Dbg "$file : $($removed.Count) removed line(s)"
    if ($removed.Count -eq 0) { continue }               # pure additions: nothing to watch

    $origins = Get-VcsLineOrigins $vcsInfo $file $removed
    $byRev = @{}
    foreach ($n in $removed) {
        if (-not $origins.ContainsKey($n)) { continue }
        $o = $origins[$n]
        if (-not $byRev.ContainsKey($o.Rev)) { $byRev[$o.Rev] = @{ Origin = $o; Count = 0 } }
        $byRev[$o.Rev].Count++
    }

    foreach ($rev in $byRev.Keys) {
        $o = $byRev[$rev].Origin
        if (-not $o.Date -or $o.Date -lt $cutoff) { continue }
        $ticket = ''
        if ($ticketRe) {
            $key = $vcsInfo.Kind + ':' + $rev
            if (-not $msgCache.ContainsKey($key)) { $msgCache[$key] = Get-VcsMessage $vcsInfo $file $rev }
            $m = $ticketRe.Match($msgCache[$key])
            if ($m.Success) {
                $t = $m.Value
                if ($m.Groups.Count -gt 1 -and $m.Groups[1].Success) { $t = $m.Groups[1].Value }
                $ticket = "ticket $t, "
            }
        }
        $days = [int][Math]::Floor(((Get-Date) - $o.Date).TotalDays)
        $alerts += ('{0}: removing {1} line(s) from {2} ({3}{4}, {5}, {6} day(s) ago)' -f `
            (Split-Path $file -Leaf), $byRev[$rev].Count, $o.Label, $ticket, $o.Author, $o.Date.ToString('yyyy-MM-dd'), $days)
    }
}
Dbg "alerts: $($alerts.Count)"

# ---------------------------------------------------------------- output
if ($PassThru) { return $alerts }   # unrolled: the caller collects the lines with @(...)
if ($alerts.Count -eq 0) {
    Write-Output 'revert-guard: OK - no removal of recently committed code detected.'
    exit 0
}
Write-Output ("REVERT-GUARD: your change removes recently committed code - confirm the intention before proceeding.`n  " + ($alerts -join "`n  "))
exit 1
