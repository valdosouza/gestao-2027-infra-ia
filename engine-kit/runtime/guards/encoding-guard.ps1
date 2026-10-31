# encoding-guard.ps1 - charset guard for source files (engine-kit runtime, guards).
#
# Stops charset damage in the file types a project names (default: web assets):
#   1. invalid UTF-8 bytes (a file saved through an ANSI / cp1252 round-trip by an editor);
#   2. characters outside the project's allowed set written into source (policy "ascii":
#      em dash, box drawing, arrows, ellipsis - typically AI-written comments, and UI
#      strings that an ANSI save would corrupt);
#   3. at commit time, "charset-only" changes: changed lines that differ from the base
#      revision only by non-ASCII characters or their ASCII stand-ins - the symptom of an
#      editor that re-saved the file in another code page (the diff looks like comment
#      edits and no rule changed).
#
# Rule it enforces (a project adopts it by config): source is ASCII-only. Comments use
# '-', '--', '->', '...'; user-visible text uses the language's escape (HTML entities such
# as &mdash; &hellip; in markup, \u2014 / \u2026 escapes in script strings). Non-ASCII
# stays in documentation.
#
# Usage (CLI; plain text out, exit 1 when there is an alert, 0 = clean):
#   encoding-guard.ps1 -Paths f1.js,f2.css          -> every disallowed character of the files
#   encoding-guard.ps1 -Gate [-WcRoot <folder>]      -> files the next commit carries, compared
#                                                      with the base revision (git HEAD / svn BASE)
# Options: -Config <guards.json> (default: .engine-kit/guards.json found walking up from
#   -WcRoot or the first path; without one, built-in defaults), -Extensions, -Policy
#   ascii|utf8, -Allow U+XXXX[-U+YYYY], -MaxFindings, -Vcs git|svn (force the adapter).
# Hook use: hook.ps1 calls this script with -PassThru (returns the alert lines).
# Set ENCGUARD_DEBUG=1 for a step trace on stderr.

param(
    [string]$WcRoot = '',
    [string[]]$Paths = @(),
    [switch]$Gate,
    [string]$Config = '',
    [string[]]$Extensions = @(),
    [string]$Policy = '',
    [string[]]$Allow = @(),
    [int]$MaxFindings = 0,
    [string]$Vcs = '',
    [switch]$PassThru
)

$ErrorActionPreference = 'SilentlyContinue'
. (Join-Path $PSScriptRoot 'guard-common.ps1')
function Dbg([string]$m) { if ($env:ENCGUARD_DEBUG) { [Console]::Error.WriteLine(('[encguard {0:HH:mm:ss.fff}] {1}' -f (Get-Date), $m)) } }

# ---------------------------------------------------------------- settings
# precedence: explicit parameter > config file > built-in default
if (-not $Gate -and $Paths.Count -eq 0) {
    Write-Output 'usage: encoding-guard.ps1 -Paths <file>[,<file>] | -Gate [-WcRoot <folder>] [-Config <guards.json>]'
    exit 2
}
# with -File, "-Paths a,b" arrives as one string: split it (a path that exists as given is kept whole)
$Paths = @(foreach ($p in $Paths) { if (Test-Path -LiteralPath $p) { $p } else { $p -split ',' | ForEach-Object { $_.Trim() } } }) | Where-Object { $_ }
if ($Gate -and -not $WcRoot) { $WcRoot = (Get-Location).Path }

$section = $null
if (-not $Config) {
    $start = $WcRoot
    if (-not $start -and $Paths.Count -gt 0) { $start = $Paths[0] }
    $Config = Find-GuardConfig $start
}
if ($Config) {
    try { $section = Get-Cfg (Read-GuardConfig $Config) 'encoding' $null } catch { Dbg "config not readable: $Config" }
}
if ($Extensions.Count -eq 0) { $Extensions = @(Get-Cfg $section 'extensions' @('.css', '.js', '.htm', '.html', '.json')) }
$Extensions = @($Extensions | ForEach-Object { $_ -split ',' } | ForEach-Object { $e = $_.Trim().ToLowerInvariant(); if ($e -and -not $e.StartsWith('.')) { $e = '.' + $e }; $e } | Where-Object { $_ })
if (-not $Policy) { $Policy = [string](Get-Cfg $section 'policy' 'ascii') }
$Policy = $Policy.ToLowerInvariant()
if ($Policy -ne 'utf8') { $Policy = 'ascii' }
if ($Allow.Count -eq 0) { $Allow = @(Get-Cfg $section 'allow' @()) }
if ($MaxFindings -le 0) { $MaxFindings = [int](Get-Cfg $section 'maxFindings' 12) }
Dbg "config=$Config policy=$Policy ext=$($Extensions -join ' ') allow=$($Allow -join ' ')"

# allowed code points beyond ASCII: "U+00E9" or "U+00C0-U+00FF"
$allowRanges = @()
foreach ($a in ($Allow | ForEach-Object { $_ -split ',' })) {
    if ($a -match '^\s*U\+([0-9A-Fa-f]{4,6})\s*(-\s*U\+([0-9A-Fa-f]{4,6}))?\s*$') {
        $lo = [Convert]::ToInt32($Matches[1], 16)
        $hi = $lo
        if ($Matches[3]) { $hi = [Convert]::ToInt32($Matches[3], 16) }
        $allowRanges += , @($lo, $hi)
    }
}
function Test-Disallowed([int]$c) {
    if ($c -le 127) { return $false }
    foreach ($r in $allowRanges) { if ($c -ge $r[0] -and $c -le $r[1]) { return $false } }
    return $true
}

$strictUtf8 = New-Object System.Text.UTF8Encoding($false, $true)
$latin1     = [System.Text.Encoding]::GetEncoding(28591)

$replacement = @{
    0x2014 = '-';   0x2013 = '-';  0x2500 = '-';  0x2501 = '-';  0x2192 = '->'; 0x2190 = '<-';
    0x2026 = '...'; 0x00A0 = ' ';  0x2018 = "'";  0x2019 = "'";  0x201C = '"';  0x201D = '"';
    0x00D7 = 'x';   0x2248 = '~';  0x2022 = '*';  0x2264 = '<='; 0x2265 = '>='; 0x2260 = '<>';
    0xFEFF = '(remove the BOM)'
}

function In-Scope([string]$path) {
    return ($Extensions -contains [System.IO.Path]::GetExtension($path).ToLowerInvariant())
}

function Fold([string]$line) {
    # Drop everything a charset round-trip or an ASCII normalisation changes: non-ASCII,
    # the usual ASCII stand-ins and whitespace. Two lines with the same fold differ only in those.
    $sb = New-Object System.Text.StringBuilder
    foreach ($ch in $line.ToCharArray()) {
        if ([int]$ch -gt 127) { continue }
        if ('-.<>*~''"'.IndexOf($ch) -ge 0 -or [char]::IsWhiteSpace($ch)) { continue }
        [void]$sb.Append($ch)
    }
    return $sb.ToString()
}

function Test-NonAscii([string]$line) { return ($line -match '[^\x00-\x7F]') }

function Decode-Bytes([byte[]]$bytes) {
    $r = @{ Text = $null; Invalid = $false; InvalidLine = 0 }
    try { $r.Text = $strictUtf8.GetString($bytes) }
    catch {
        $r.Invalid = $true
        # locate the first invalid byte: binary search on the longest valid prefix.
        # [int] rounds half to even in PowerShell (93.5 -> 94) and the search would never converge: use Floor
        $lo = 0; $hi = $bytes.Length; $guard = 0
        while ($lo -lt $hi -and $guard -lt 64) {
            $guard++
            $mid = [int][Math]::Floor(($lo + $hi) / 2)
            try { [void]$strictUtf8.GetString($bytes, 0, $mid); $lo = $mid + 1 } catch { $hi = $mid }
        }
        $off = [Math]::Max(0, $lo - 1)
        $line = 1
        for ($i = 0; $i -lt $off -and $i -lt $bytes.Length; $i++) { if ($bytes[$i] -eq 10) { $line++ } }
        $r.InvalidLine = $line
        $r.Text = $latin1.GetString($bytes)
    }
    return $r
}

function Get-Context([string]$line) {
    $ctx = $line.Trim()
    if ($ctx.Length -gt 70) { $ctx = $ctx.Substring(0, 70) + '...' }
    return $ctx
}

function Get-DisallowedFindings([string]$text, [string]$label) {
    $out = @()
    if ($Policy -ne 'ascii') { return $out }
    $lines = $text -split "`n"
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i].TrimEnd("`r")
        foreach ($ch in $line.ToCharArray()) {
            $c = [int]$ch
            if (Test-Disallowed $c) {
                $sug = $replacement[$c]
                if (-not $sug) { $sug = '?' }
                $out += ("{0}:{1} U+{2:X4} -> '{3}'  | {4}" -f $label, ($i + 1), $c, $sug, (Get-Context $line))
                break   # one finding per line is enough
            }
        }
        if ($out.Count -ge $MaxFindings) { $out += ('{0}: ... more lines with disallowed characters' -f $label); break }
    }
    return $out
}

# ---------------------------------------------------------------- files to check
$vcsInfo = $null
$files = @()
if ($Gate) {
    $vcsInfo = Get-VcsInfo $WcRoot $Vcs
    if (-not $vcsInfo) {
        $msg = "encoding-guard: no git or svn working copy at $WcRoot - nothing to compare."
        if ($PassThru) { return @() }
        Write-Output $msg
        exit 0
    }
    $files = @(Get-VcsChangedFiles $vcsInfo $WcRoot @('modified', 'added', 'replaced'))
} else {
    $files = $Paths
}
Dbg ("files: " + ($files -join '; '))

# ---------------------------------------------------------------- analysis
$alerts = @()
foreach ($file in $files) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { continue }
    if (-not (In-Scope $file)) { continue }
    $leaf = Split-Path $file -Leaf

    $bytes = [System.IO.File]::ReadAllBytes($file)
    $dec = Decode-Bytes $bytes
    if ($dec.Invalid) {
        $alerts += ('{0}: NOT VALID UTF-8 (first bad byte on line {1}) - the file went through an ANSI/cp1252 save; restore the text from the base revision and keep the file UTF-8' -f $leaf, $dec.InvalidLine)
    }
    # a file that is not valid UTF-8 is reported as such; listing its Latin-1 fallback characters would be noise
    if ($dec.Invalid) { $findings = @() } else { $findings = @(Get-DisallowedFindings $dec.Text $leaf) }

    if (-not $Gate) {
        # edit hook or -Paths: every disallowed line of the file that was just written
        $alerts += $findings
        continue
    }

    # commit gate: compare with the base revision
    $baseBytes = Get-VcsBaseBytes $vcsInfo $file
    if ($null -eq $baseBytes) {
        # added file: everything in it is new
        $alerts += $findings
        continue
    }
    $baseDec = Decode-Bytes $baseBytes
    $wcLines   = @(Split-Lines $dec.Text)
    $baseLines = @(Split-Lines $baseDec.Text)
    $baseSet = New-Object 'System.Collections.Generic.HashSet[string]'
    foreach ($l in $baseLines) { [void]$baseSet.Add($l) }
    $wcSet = New-Object 'System.Collections.Generic.HashSet[string]'
    foreach ($l in $wcLines) { [void]$wcSet.Add($l) }

    # fold of every removed base line -> does one of those lines carry non-ASCII?
    $removedFold = @{}
    foreach ($l in $baseLines) {
        if ($wcSet.Contains($l)) { continue }
        $f = Fold $l
        $removedFold[$f] = ($removedFold[$f] -eq $true) -or (Test-NonAscii $l)
    }

    $newDisallowed = 0; $charsetOnly = 0; $samples = @()
    for ($i = 0; $i -lt $wcLines.Count; $i++) {
        $l = $wcLines[$i]
        if ($baseSet.Contains($l)) { continue }           # unchanged line
        if ($Policy -eq 'ascii') {
            $bad = $false
            foreach ($ch in $l.ToCharArray()) { if (Test-Disallowed ([int]$ch)) { $bad = $true; break } }
            if ($bad) {
                $newDisallowed++
                if ($samples.Count -lt 5) { $samples += ('    {0}:{1}  {2}' -f $leaf, ($i + 1), (Get-Context $l)) }
            }
        }
        $f = Fold $l
        # a removed base line folds to the same text and one side carries non-ASCII: only the
        # charset or its ASCII stand-ins changed (a whitespace-only or ASCII-only edit is not counted)
        if ($f.Length -gt 0 -and $removedFold.ContainsKey($f) -and ((Test-NonAscii $l) -or $removedFold[$f])) {
            $charsetOnly++
        }
    }
    if ($newDisallowed -gt 0) {
        $alerts += ('{0}: {1} changed line(s) introduce characters outside the allowed set (policy {2})' -f $leaf, $newDisallowed, $Policy)
        $alerts += $samples
    }
    if ($charsetOnly -gt 0) {
        $alerts += ('{0}: {1} charset-only line(s) - they differ from the base revision only by non-ASCII characters or their ASCII stand-ins. Intentional ASCII normalisation? Say so in the commit message; otherwise restore the base text.' -f $leaf, $charsetOnly)
    }
}
Dbg "alerts: $($alerts.Count)"

# ---------------------------------------------------------------- output
if ($PassThru) { return $alerts }   # unrolled: the caller collects the lines with @(...)
if ($alerts.Count -eq 0) {
    Write-Output 'encoding-guard: OK - no charset problems in the files checked.'
    exit 0
}
Write-Output ("ENCODING-GUARD: charset problem in source (policy $Policy).`n  " + ($alerts -join "`n  "))
exit 1
