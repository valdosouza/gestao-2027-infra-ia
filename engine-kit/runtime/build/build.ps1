# build.ps1 - registered build runner with a warnings audit (engine-kit runtime, build tools)
#
# Runs ONE build registered as data in a projects file (versioned in the case) with the
# machine's roots taken from ONE per-machine env file (never versioned). Writes the
# tool's log and a summary.json - every error, warning and hint with its code and
# file:line, the risky ones flagged, and a verdict CLEAN / SUFFICIENT / BROKEN - OUTSIDE
# every source tree. The build-analyst agent reads the summary and audits it (technique
# T70). Nothing here knows a language, a compiler or a case: the command, its arguments,
# the diagnostic formats (regular expressions) and the risky codes are all data.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Projects <case>\build\projects.json -List
#   powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1 -Projects <file> -Project <id> [-Line <line>]
#       [-Overlay <dir>] [-EnvFile <file>] [-DryRun]
#
# -Projects  the case's projects file (format: projects.example.json, README.md)
# -Project   the registered build to run; -Line picks its line when the id is registered
#            in more than one line
# -Overlay   a folder put FIRST on the search path, so its units win over the base ones of
#            the same name (a per-client overlay); only for builds with overlaySupported
# -EnvFile   the per-machine roots (default: build.env.json next to the projects file)
# -DryRun    resolves everything and prints the plan; runs nothing, writes nothing
#
# Exit codes: 0 compiled (verdict CLEAN or SUFFICIENT), 1 BROKEN, 2 usage or configuration
# error - nothing was built (no env file, unknown build, required path missing, output
# folder inside a source tree). The tool's own exit code is recorded in summary.json.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Projects,
    [string]$Project = '',
    [string]$Line = '',
    [string]$Overlay = '',
    [string]$EnvFile = '',
    [switch]$List,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$kitRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$defaultSuspect = '(?i)\b(error|warning|fatal)\b'
$defaultKindMap = @{ 'error' = 'error'; 'fatal' = 'error'; 'warning' = 'warning'; 'warn' = 'warning'; 'hint' = 'hint'; 'note' = 'hint'; 'info' = 'info' }

function Stop-Config([string]$Message) {
    Write-Host "build: $Message" -ForegroundColor Red
    exit 2
}

function Read-Json([string]$Path, [string]$What) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { Stop-Config "$What not found: $Path" }
    try { return (Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json) }
    catch { Stop-Config "$What is not valid JSON: $Path ($($_.Exception.Message))" }
}

function ConvertTo-Hash($Object) {
    $hash = @{}
    if ($null -ne $Object) { foreach ($p in $Object.PSObject.Properties) { $hash[$p.Name] = $p.Value } }
    return $hash
}

function Get-Prop($Object, [string]$Name) {
    if ($null -eq $Object) { return $null }
    $p = $Object.PSObject.Properties[$Name]
    if ($null -eq $p) { return $null }
    return $p.Value
}

# {name} -> value, repeated so a variable may use another one. Returns value, missing
# (undefined names) and empty (defined but empty) so the caller decides what is fatal.
function Expand-Text([string]$Text, [hashtable]$Vars) {
    $value = $Text
    $missing = New-Object System.Collections.Generic.List[string]
    $empty = New-Object System.Collections.Generic.List[string]
    for ($pass = 0; $pass -lt 8; $pass++) {
        $found = [regex]::Matches($value, '\{([A-Za-z_][A-Za-z0-9_.-]*)\}')
        $changed = $false
        foreach ($m in $found) {
            $name = $m.Groups[1].Value
            if ($Vars.ContainsKey($name)) {
                $v = [string]$Vars[$name]
                if ($v -eq '' -and -not $empty.Contains($name)) { $empty.Add($name) }
                $value = $value.Replace($m.Value, $v)
                $changed = $true
            } elseif (-not $missing.Contains($name)) { $missing.Add($name) }
        }
        if (-not $changed) { break }
    }
    return [pscustomobject]@{ value = $value; missing = @($missing); empty = @($empty) }
}

# A list entry starting with '?' is optional: dropped when one of its variables is empty.
# An undefined variable is always a configuration error.
function Expand-List($Items, [hashtable]$Vars, [string]$Where) {
    $out = New-Object System.Collections.Generic.List[string]
    foreach ($raw in @($Items)) {
        if ($null -eq $raw) { continue }
        $text = [string]$raw
        $optional = $text.StartsWith('?')
        if ($optional) { $text = $text.Substring(1) }
        $r = Expand-Text $text $Vars
        if ($r.missing.Count -gt 0) { Stop-Config ("$Where uses undefined variable(s) {" + ($r.missing -join '}, {') + "} in: $raw") }
        if ($optional -and $r.empty.Count -gt 0) { continue }
        $out.Add($r.value)
    }
    return , $out.ToArray()
}

function Expand-One([string]$Text, [hashtable]$Vars, [string]$Where) {
    $r = Expand-Text $Text $Vars
    if ($r.missing.Count -gt 0) { Stop-Config ("$Where uses undefined variable(s) {" + ($r.missing -join '}, {') + "}: $Text") }
    return $r.value
}

function Test-Inside([string]$Child, [string]$Parent) {
    if (-not $Child -or -not $Parent) { return $false }
    $sep = [IO.Path]::DirectorySeparatorChar
    $c = [IO.Path]::GetFullPath($Child).TrimEnd('\', '/') + $sep
    $p = [IO.Path]::GetFullPath($Parent).TrimEnd('\', '/') + $sep
    return $c.StartsWith($p, [StringComparison]::OrdinalIgnoreCase)
}

# Windows command-line quoting (the rules the C runtime uses to split arguments).
function ConvertTo-ArgumentString([string[]]$Items) {
    $parts = foreach ($a in $Items) {
        if ($a -eq '') { '""' }
        elseif ($a -notmatch '[\s"]') { $a }
        else {
            $sb = New-Object System.Text.StringBuilder
            [void]$sb.Append('"')
            $slashes = 0
            foreach ($ch in $a.ToCharArray()) {
                if ($ch -eq [char]'\') { $slashes++ }
                elseif ($ch -eq [char]'"') { [void]$sb.Append('\' * ($slashes * 2 + 1)); [void]$sb.Append('"'); $slashes = 0 }
                else { if ($slashes -gt 0) { [void]$sb.Append('\' * $slashes); $slashes = 0 }; [void]$sb.Append($ch) }
            }
            [void]$sb.Append('\' * ($slashes * 2))
            [void]$sb.Append('"')
            $sb.ToString()
        }
    }
    return (@($parts) -join ' ')
}

# ---------- registry ----------
$Projects = [IO.Path]::GetFullPath($Projects)
$reg = Read-Json $Projects 'projects file'
$lines = Get-Prop $reg 'lines'
if ($null -eq $lines) { Stop-Config "projects file has no 'lines' object: $Projects" }

if ($List) {
    foreach ($l in $lines.PSObject.Properties) {
        foreach ($p in (Get-Prop $l.Value 'projects').PSObject.Properties) {
            $d = Get-Prop $p.Value 'description'
            Write-Host ("{0,-12} {1,-24} {2}" -f $l.Name, $p.Name, $d)
        }
    }
    exit 0
}
if (-not $Project) { Stop-Config '-Project is required (or -List to see the registered builds)' }

$candidates = @()
foreach ($l in $lines.PSObject.Properties) {
    if ($Line -and $l.Name -ne $Line) { continue }
    $p = Get-Prop (Get-Prop $l.Value 'projects') $Project
    if ($null -ne $p) { $candidates += , @($l.Name, $l.Value, $p) }
}
if ($candidates.Count -eq 0) {
    if ($Line) { Stop-Config "build '$Project' is not registered in line '$Line' ($Projects)" }
    Stop-Config "build '$Project' is not registered ($Projects)"
}
if ($candidates.Count -gt 1) { Stop-Config ("build '$Project' is registered in several lines (" + (($candidates | ForEach-Object { $_[0] }) -join ', ') + '): pass -Line') }
$lineName = $candidates[0][0]
$lineDef = $candidates[0][1]
$prj = $candidates[0][2]

# ---------- per-machine env ----------
if (-not $EnvFile) { $EnvFile = Join-Path (Split-Path -Parent $Projects) 'build.env.json' }
$EnvFile = [IO.Path]::GetFullPath($EnvFile)
if (-not (Test-Path -LiteralPath $EnvFile -PathType Leaf)) {
    Stop-Config "no per-machine env file $EnvFile - copy build.env.example.json there, set this machine's roots, and keep it out of version control"
}
$envDef = Read-Json $EnvFile 'env file'
$roots = @{}
foreach ($p in (ConvertTo-Hash (Get-Prop $envDef 'roots')).GetEnumerator()) {
    $roots[$p.Key] = [Environment]::ExpandEnvironmentVariables([string]$p.Value)
}
$outRootRaw = Get-Prop $envDef 'outRoot'
if (-not $outRootRaw) { Stop-Config "env file has no outRoot (where logs and summaries go, outside every source tree): $EnvFile" }
$outRoot = [IO.Path]::GetFullPath([Environment]::ExpandEnvironmentVariables([string]$outRootRaw))

# ---------- variables: env roots < line < project < built-ins ----------
$safe = { param($s) ($s -replace '[\\/:*?"<>|]', '_') }
$outDir = Join-Path (Join-Path $outRoot (& $safe $lineName)) (& $safe $Project)
$stamp = Get-Date -Format 'yyyy-MM-dd_HHmmss'
$vars = @{}
foreach ($k in $roots.Keys) { $vars[$k] = $roots[$k] }
foreach ($p in (ConvertTo-Hash (Get-Prop $lineDef 'variables')).GetEnumerator()) { $vars[$p.Key] = [string]$p.Value }
foreach ($p in (ConvertTo-Hash (Get-Prop $prj 'variables')).GetEnumerator()) { $vars[$p.Key] = [string]$p.Value }
$vars['line'] = $lineName
$vars['project'] = $Project
$vars['out'] = $outDir
$vars['stamp'] = $stamp
$vars['overlay'] = ''
$vars['searchPath'] = ''
$vars['responseFile'] = ''

if ($Overlay) {
    if (-not (Get-Prop $prj 'overlaySupported')) { Stop-Config "build '$Project' does not take an overlay (overlaySupported is not true)" }
    if (-not (Test-Path -LiteralPath $Overlay -PathType Container)) { Stop-Config "overlay folder not found: $Overlay" }
    $vars['overlay'] = [IO.Path]::GetFullPath($Overlay)
}

$workdirRaw = Get-Prop $prj 'workdir'
$commandRaw = Get-Prop $prj 'command'
if (-not $workdirRaw -or -not $commandRaw) { Stop-Config "build '$Project' needs 'workdir' and 'command'" }
$workdir = [IO.Path]::GetFullPath((Expand-One ([string]$workdirRaw) $vars "workdir of '$Project'"))
$vars['workdir'] = $workdir
$command = Expand-One ([string]$commandRaw) $vars "command of '$Project'"

# ---------- output outside every source tree ----------
$guarded = @{ 'the workdir' = $workdir; 'the kit' = $kitRoot }
foreach ($k in $roots.Keys) { if ($roots[$k]) { $guarded["root '$k'"] = $roots[$k] } }
foreach ($g in $guarded.GetEnumerator()) {
    if (Test-Inside $outRoot $g.Value) { Stop-Config "outRoot $outRoot is inside $($g.Key) ($($g.Value)): build output never goes into a source tree" }
}

# ---------- required paths ----------
$missingPaths = @()
foreach ($r in (Expand-List (Get-Prop $prj 'requires') $vars "requires of '$Project'")) {
    if (-not (Test-Path -LiteralPath $r)) { $missingPaths += $r }
}
if (-not (Test-Path -LiteralPath $workdir -PathType Container)) { $missingPaths += $workdir }
if ($missingPaths.Count -gt 0) { Stop-Config ("required path(s) missing on this machine: " + ($missingPaths -join '; ')) }

# ---------- search path: overlay first, missing folders skipped and listed ----------
$searchDirs = New-Object System.Collections.Generic.List[string]
$skipped = New-Object System.Collections.Generic.List[string]
$sp = Get-Prop $prj 'searchPath'
if ($null -ne $sp) {
    $sep = Get-Prop $sp 'separator'
    if ($null -eq $sep) { $sep = ';' }
    $quote = [bool](Get-Prop $sp 'quote')
    $dirs = @()
    if ($Overlay) { $dirs += $vars['overlay'] }
    $expanded = Expand-List (Get-Prop $sp 'dirs') $vars "searchPath of '$Project'"
    $dirs += $expanded
    foreach ($d in $dirs) {
        if (-not $d) { continue }
        if (Test-Path -LiteralPath $d -PathType Container) { if (-not $searchDirs.Contains($d)) { $searchDirs.Add($d) } }
        elseif (-not $skipped.Contains($d)) { $skipped.Add($d) }
    }
    $vars['searchPath'] = (@($searchDirs | ForEach-Object { if ($quote -and $_ -match "[ $([regex]::Escape($sep))]") { '"' + $_ + '"' } else { $_ } }) -join $sep)
}

# ---------- response file (optional) ----------
$rspLines = @()
$rspFile = ''
if ($null -ne (Get-Prop $prj 'responseFile')) {
    $rspFile = Join-Path $outDir "$Project.rsp"
    $vars['responseFile'] = $rspFile
    $rspLines = Expand-List (Get-Prop $prj 'responseFile') $vars "responseFile of '$Project'"
    foreach ($l in $rspLines) { if ($l -match '[^\x00-\x7F]') { Stop-Config "responseFile line has non-ASCII characters (written as ASCII): $l" } }
}
$arguments = Expand-List (Get-Prop $prj 'args') $vars "args of '$Project'"

# ---------- anti-patch: arguments that silence diagnostics are recorded ----------
$silencerPatterns = @(Get-Prop $reg 'silencerPatterns') + @(Get-Prop $prj 'silencerPatterns') | Where-Object { $_ }
$silencers = @()
foreach ($a in (@($arguments) + @($rspLines))) {
    foreach ($pat in $silencerPatterns) { if ($a -match $pat) { $silencers += $a; break } }
}

# ---------- parsers and risky codes (data) ----------
$parserDefs = Get-Prop $reg 'parsers'
$parserNames = @(Get-Prop $prj 'parsers')
if ($parserNames.Count -eq 0 -or $null -eq $parserNames[0]) { $parserNames = @($parserDefs.PSObject.Properties | ForEach-Object { $_.Name }) }
$parsers = @()
foreach ($n in $parserNames) {
    $def = Get-Prop $parserDefs $n
    if ($null -eq $def) { Stop-Config "build '$Project' names parser '$n', not defined under 'parsers'" }
    $opts = [Text.RegularExpressions.RegexOptions]::None
    if (Get-Prop $def 'ignoreCase') { $opts = [Text.RegularExpressions.RegexOptions]::IgnoreCase }
    try { $rx = New-Object System.Text.RegularExpressions.Regex([string](Get-Prop $def 'regex'), $opts) }
    catch { Stop-Config "parser '$n' has an invalid regex: $($_.Exception.Message)" }
    $parsers += [pscustomobject]@{ name = $n; regex = $rx; kind = (Get-Prop $def 'kind') }
}
$kindMap = @{}
foreach ($k in $defaultKindMap.Keys) { $kindMap[$k] = $defaultKindMap[$k] }
foreach ($p in (ConvertTo-Hash (Get-Prop $reg 'kindMap')).GetEnumerator()) {
    if (@('error', 'warning', 'hint', 'info') -notcontains [string]$p.Value) { Stop-Config "kindMap '$($p.Key)' -> '$($p.Value)': the target must be error, warning, hint or info" }
    $kindMap[$p.Key.ToLowerInvariant()] = [string]$p.Value
}
$risky = [ordered]@{}
foreach ($src in @((Get-Prop $reg 'riskyCodes'), (Get-Prop $prj 'riskyCodes'))) {
    foreach ($p in (ConvertTo-Hash $src).GetEnumerator()) { $risky[$p.Key] = [string]$p.Value }
}
$suspect = Get-Prop $prj 'suspectPattern'
if (-not $suspect) { $suspect = Get-Prop $reg 'suspectPattern' }
if (-not $suspect) { $suspect = $defaultSuspect }

# ---------- plan ----------
$argString = ConvertTo-ArgumentString $arguments
Write-Host "build   : $lineName / $Project"
Write-Host "command : $command $argString"
Write-Host "workdir : $workdir"
Write-Host "out     : $outDir"
if ($Overlay) { Write-Host "overlay : $($vars['overlay'])" }
if ($skipped.Count -gt 0) { Write-Host ('skipped (missing on this machine): ' + ($skipped -join '; ')) -ForegroundColor Yellow }
foreach ($s in $silencers) { Write-Host "WARN silencer argument (a silenced diagnostic is a finding, never a fix): $s" -ForegroundColor Yellow }
if ($DryRun) {
    if ($rspFile) { Write-Host "rsp     : $rspFile"; foreach ($l in $rspLines) { Write-Host "          $l" } }
    Write-Host 'dry run - nothing run, nothing written'
    exit 0
}

# ---------- run ----------
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
if ($rspFile) { [IO.File]::WriteAllText($rspFile, (($rspLines -join "`r`n") + "`r`n"), [Text.Encoding]::ASCII) }
$logFile = Join-Path $outDir "$Project-$stamp.log"
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $command
$psi.Arguments = $argString
$psi.WorkingDirectory = $workdir
$psi.UseShellExecute = $false
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.CreateNoWindow = $true
$enc = Get-Prop $prj 'outputEncoding'
if ($enc) {
    try { if ([string]$enc -match '^\d+$') { $e = [Text.Encoding]::GetEncoding([int]$enc) } else { $e = [Text.Encoding]::GetEncoding([string]$enc) } }
    catch { Stop-Config "outputEncoding '$enc' is not a known code page or encoding name" }
    $psi.StandardOutputEncoding = $e; $psi.StandardErrorEncoding = $e
}
$proc = New-Object System.Diagnostics.Process
$proc.StartInfo = $psi
$sw = [Diagnostics.Stopwatch]::StartNew()
try { [void]$proc.Start() } catch { Stop-Config "cannot start '$command': $($_.Exception.Message)" }
$errTask = $proc.StandardError.ReadToEndAsync()
$stdout = $proc.StandardOutput.ReadToEnd()
$proc.WaitForExit()
$stderr = $errTask.Result
$sw.Stop()
$rc = $proc.ExitCode
$text = $stdout
if ($stderr) { if ($text -and -not $text.EndsWith("`n")) { $text += "`n" }; $text += $stderr }
[IO.File]::WriteAllText($logFile, $text, $utf8NoBom)

# ---------- parse ----------
$items = New-Object System.Collections.Generic.List[object]
$unparsed = New-Object System.Collections.Generic.List[string]
foreach ($raw in ($text -split "`r?`n")) {
    if (-not $raw.Trim()) { continue }
    $hit = $null
    foreach ($p in $parsers) { $m = $p.regex.Match($raw); if ($m.Success) { $hit = $p; break } }
    if ($null -eq $hit) { if ($raw -match $suspect) { $unparsed.Add($raw.Trim()) }; continue }
    $g = $m.Groups
    $rawKind = if ($g['kind'].Success) { $g['kind'].Value } elseif ($hit.kind) { [string]$hit.kind } else { 'warning' }
    $kind = $kindMap[$rawKind.Trim().ToLowerInvariant()]
    if (-not $kind) { $kind = 'warning' }
    $file = if ($g['file'].Success) { $g['file'].Value.Trim() } else { '' }
    $lineNo = $null; if ($g['line'].Success) { $lineNo = [int]$g['line'].Value }
    $col = $null; if ($g['column'].Success -and $g['column'].Value) { $col = [int]$g['column'].Value }
    $code = if ($g['code'].Success) { $g['code'].Value.Trim() } else { '' }
    $msg = if ($g['message'].Success) { $g['message'].Value.Trim() } else { $raw.Trim() }
    $isRisky = $false; $reason = ''
    if ($code -and $risky.Contains($code)) { $isRisky = $true; $reason = $risky[$code] }
    elseif ($kind -eq 'error') { $isRisky = $true; $reason = 'error: the build does not compile' }
    $loc = $file; if ($file -and $null -ne $lineNo) { $loc = "${file}:$lineNo" }
    $name = ''; if ($file) { try { $name = [IO.Path]::GetFileName($file) } catch { $name = $file } }
    $items.Add([pscustomobject][ordered]@{
        kind = $kind; code = $code; file = $file; name = $name; line = $lineNo; column = $col
        location = $loc; message = $msg; risky = $isRisky; riskReason = $reason; parser = $hit.name
    })
}

$count = { param($k) @($items | Where-Object { $_.kind -eq $k }).Count }
$nErr = & $count 'error'; $nWarn = & $count 'warning'; $nHint = & $count 'hint'; $nInfo = & $count 'info'
$nRisky = @($items | Where-Object { $_.risky }).Count
$byCode = @($items | Group-Object { if ($_.code) { $_.code } else { '(none)' } } | ForEach-Object {
        [pscustomobject][ordered]@{ code = $_.Name; kind = $_.Group[0].kind; count = $_.Count; risky = [bool]($_.Group | Where-Object { $_.risky }) }
    } | Sort-Object @{ Expression = 'count'; Descending = $true }, @{ Expression = 'code'; Descending = $false })

# ---------- verdict ----------
$reasons = @()
if ($rc -ne 0 -or $nErr -gt 0) {
    $verdict = 'BROKEN'
    if ($rc -ne 0) { $reasons += "the tool exited with $rc" }
    if ($nErr -gt 0) { $reasons += "$nErr error(s)" }
    if ($rc -ne 0 -and $nErr -eq 0) { $reasons += 'no error line was parsed: check the parsers against the log' }
} else {
    if ($nWarn -gt 0) { $reasons += "$nWarn warning(s)" }
    if ($nRisky -gt 0) { $reasons += "$nRisky risky item(s)" }
    if ($silencers.Count -gt 0) { $reasons += "$($silencers.Count) argument(s) silence diagnostics" }
    if ($unparsed.Count -gt 0) { $reasons += "$($unparsed.Count) line(s) look like diagnostics but no parser matched them" }
    if ($reasons.Count -eq 0) { $verdict = 'CLEAN'; $reasons += 'compiled; no warning, no risky item, nothing silenced, nothing unparsed' }
    else { $verdict = 'SUFFICIENT'; $reasons = @('compiled with latent defects to audit') + $reasons }
}

$summary = [pscustomobject][ordered]@{
    schema          = 1
    line            = $lineName
    project         = $Project
    description     = [string](Get-Prop $prj 'description')
    executed        = (Get-Date).ToString('yyyy-MM-ddTHH:mm:sszzz')
    seconds         = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    command         = $command
    arguments       = @($arguments)
    workdir         = $workdir
    overlay         = $vars['overlay']
    searchPath      = $searchDirs.ToArray()
    skippedDirs     = $skipped.ToArray()
    responseFile    = $rspFile
    silencers       = @($silencers)
    projectsFile    = $Projects
    envFile         = $EnvFile
    log             = $logFile
    exitCode        = $rc
    verdict         = $verdict
    verdictReasons  = @($reasons)
    counts          = [pscustomobject][ordered]@{ errors = $nErr; warnings = $nWarn; hints = $nHint; info = $nInfo; risky = $nRisky; unparsedSuspect = $unparsed.Count }
    byCode          = @($byCode)
    items           = $items.ToArray()
    unparsedSuspect = @($unparsed | Select-Object -First 20)
    riskyCodes      = $risky
}
$summaryFile = Join-Path $outDir "$Project-$stamp.summary.json"
[IO.File]::WriteAllText($summaryFile, ($summary | ConvertTo-Json -Depth 8), $utf8NoBom)

Write-Host ''
Write-Host ("build {0}: {1} - exit {2} in {3}s - {4} errors, {5} warnings, {6} hints, {7} risky" -f $Project, $verdict, $rc, $summary.seconds, $nErr, $nWarn, $nHint, $nRisky)
foreach ($b in $byCode) { Write-Host ("  {0,-10} {1,5}{2}" -f $b.code, $b.count, $(if ($b.risky) { '  risky' } else { '' })) }
if ($unparsed.Count -gt 0) { Write-Host "WARN $($unparsed.Count) unparsed line(s) look like diagnostics - see unparsedSuspect" -ForegroundColor Yellow }
Write-Host "log     : $logFile"
Write-Host "summary : $summaryFile"
if ($verdict -eq 'BROKEN') { exit 1 }
exit 0
