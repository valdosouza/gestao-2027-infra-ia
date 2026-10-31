# test-build.ps1 - plain PowerShell tests of build.ps1 (no Pester needed; engine-kit runtime, build tools)
#
# Everything happens inside one scratch folder: a fake code tree, a fake toolchain (fakecc.ps1,
# run through powershell.exe), a projects file and env files written by this script, and the
# output root. Nothing outside the scratch folder is touched. Each summary.json written is
# also checked against the key sets of summary.schema.json (top level, counts, byCode, items)
# and its verdict enum - a contract check that needs no JSON Schema library.
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File tests\test-build.ps1 [-Scratch <empty dir>] [-KeepScratch]
# -Scratch: an empty folder to work in, kept after the run (default: a new folder under the
#           temp folder, removed after the run).
# -KeepScratch: keep the default folder too (its summaries.txt lists every summary written).
# Exit 0 = every check passed, 1 = a check failed.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.

[CmdletBinding()]
param([string]$Scratch = '', [switch]$KeepScratch)

$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$buildDir = Split-Path -Parent $here
$Runner = Join-Path $buildDir 'build.ps1'
$schemaFile = Join-Path $buildDir 'summary.schema.json'

$ownScratch = -not $Scratch
if ($ownScratch) { $Scratch = Join-Path ([IO.Path]::GetTempPath()) ('build-test-' + [guid]::NewGuid().ToString('N').Substring(0, 8)) }
New-Item -ItemType Directory -Force -Path $Scratch | Out-Null
$S = (Resolve-Path -LiteralPath $Scratch).ProviderPath
$code = Join-Path $S 'code'; $tools = Join-Path $S 'tools'; $overlay = Join-Path $S 'overlay'; $out = Join-Path $S 'out'; $cfg = Join-Path $S 'cfg'
foreach ($d in @("$code\main\service", "$code\main\shared", "$code\release-2.1\service", $tools, $overlay, $cfg)) { New-Item -ItemType Directory -Force $d | Out-Null }
Copy-Item (Join-Path $here 'fakecc.ps1') $tools

# ---------- the registry under test ----------
$base = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', '{toolchainRoot}\fakecc.ps1', '-Mode', '{mode}')
function P($mode, $extra) {
    $p = [ordered]@{ description = "fake $mode"; workdir = '{tree}\service'; command = 'powershell.exe'; args = @($base); variables = @{ mode = $mode }; parsers = @('paren', 'bracket', 'bare') }
    if ($extra) { foreach ($k in $extra.Keys) { $p[$k] = $extra[$k] } }
    return $p
}
$warnExtra = @{ args = @($base + '@{responseFile}'); overlaySupported = $true; searchPath = @{ separator = ';'; dirs = @('{tree}\shared', '{tree}\missing') }; responseFile = @('-I{searchPath}', '--out={out}\bin') }
$reg = [ordered]@{
    schema = 1
    parsers = [ordered]@{
        paren = @{ regex = '^(?<file>[^(\r\n]+)\((?<line>\d+)(?:,(?<column>\d+))?\)\s+(?<kind>Warning|Hint|Error|Fatal):\s+(?<code>[A-Z]\d{3,4})?\s*(?<message>.*)$' }
        bracket = @{ regex = '^\[\S+ (?<kind>Warning|Hint|Error|Fatal)\]\s+(?<file>[^(]+)\((?<line>\d+)\):\s+(?<code>[A-Z]\d{3,4})?\s*(?<message>.*)$' }
        bare = @{ regex = '^(?<kind>Warning|Hint|Error|Fatal):\s+(?<code>[A-Z]\d{3,4})?\s*(?<message>.*)$' }
    }
    kindMap = @{ fatal = 'error' }
    riskyCodes = [ordered]@{ W101 = 'undefined result'; W102 = 'uninitialized'; H201 = 'unused value'; W105 = 'deprecated' }
    silencerPatterns = @('^--no-warn')
    lines = [ordered]@{
        main = [ordered]@{
            variables = @{ tree = '{codeRoot}\main' }
            projects = [ordered]@{
                'svc-clean' = (P 'clean' $null)
                'svc-warn' = (P 'warn' $warnExtra)
                'svc-error' = (P 'error' $null)
                'svc-crash' = (P 'crash' $null)
                'svc-unparsed' = (P 'unparsed' $null)
                'svc-silenced' = (P 'clean' @{ args = @($base + '--no-warn=W101') })
                'svc-hints' = (P 'hintsonly' $null)
                'svc-missing' = (P 'clean' @{ requires = @('{tree}\service\nothere.main') })
                'svc-dup' = (P 'clean' $null)
            }
        }
        '2.1' = [ordered]@{
            variables = @{ tree = '{codeRoot}\release-2.1' }
            projects = [ordered]@{ 'svc-dup' = (P 'clean' $null) }
        }
    }
}
$utf8NoBom = New-Object Text.UTF8Encoding($false)
$projects = Join-Path $cfg 'projects.json'
[IO.File]::WriteAllText($projects, ($reg | ConvertTo-Json -Depth 10), $utf8NoBom)
$envGood = Join-Path $cfg 'build.env.json'
[IO.File]::WriteAllText($envGood, (@{ roots = @{ codeRoot = $code; toolchainRoot = $tools }; outRoot = $out } | ConvertTo-Json -Depth 4), $utf8NoBom)
$envInside = Join-Path $cfg 'inside.env.json'
[IO.File]::WriteAllText($envInside, (@{ roots = @{ codeRoot = $code; toolchainRoot = $tools }; outRoot = "$code\out" } | ConvertTo-Json -Depth 4), $utf8NoBom)

# ---------- helpers ----------
$script:pass = 0; $script:fail = 0
function Check([bool]$c, [string]$name, [string]$detail = '') {
    if ($c) { $script:pass++; Write-Host "  PASS $name" -ForegroundColor DarkGreen } else { $script:fail++; Write-Host "  FAIL $name $detail" -ForegroundColor Red }
}
function Section([string]$Title) { Write-Host ''; Write-Host "== $Title" -ForegroundColor Cyan }
function Run([string[]]$a) {
    $ErrorActionPreference = 'Continue'
    $global:LASTOUT = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Runner @a 2>&1 | Out-String
    return $LASTEXITCODE
}
$script:summaries = @()
function Summary([string]$line, [string]$prj) {
    $f = Get-ChildItem -Path (Join-Path (Join-Path $out $line) $prj) -Filter '*.summary.json' -ErrorAction SilentlyContinue | Sort-Object LastWriteTime | Select-Object -Last 1
    if (-not $f) { return $null }
    $script:summaries += $f.FullName
    return (Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8 | ConvertFrom-Json)
}

# ---------- cases ----------
Section 'clean'
$rc = Run @('-Projects', $projects, '-Project', 'svc-clean')
$sm = Summary 'main' 'svc-clean'
Check ($rc -eq 0) 'exit 0' "rc=$rc"
Check ($sm.verdict -eq 'CLEAN') 'verdict CLEAN' $sm.verdict
Check (-not $sm.log.StartsWith($code, 'OrdinalIgnoreCase')) 'log outside the code root'
Check ((Get-Content -Raw $sm.log) -match [regex]::Escape("cwd=$code\main\service")) 'runs inside the workdir'

Section 'warn + overlay + response file'
$rc = Run @('-Projects', $projects, '-Project', 'svc-warn', '-Overlay', $overlay)
$sm = Summary 'main' 'svc-warn'
Check ($rc -eq 0) 'exit 0' "rc=$rc"
Check ($sm.verdict -eq 'SUFFICIENT') 'verdict SUFFICIENT' $sm.verdict
Check ($sm.counts.warnings -eq 5) 'five warnings (stderr included)' "$($sm.counts.warnings)"
Check ($sm.counts.hints -eq 2) 'two hints' "$($sm.counts.hints)"
Check ($sm.counts.risky -eq 5) 'five risky (W101 x2, W102, W105, H201)' "$($sm.counts.risky)"
$w300 = @($sm.items | Where-Object { $_.code -eq 'W300' })[0]
Check ($w300 -and -not $w300.risky) 'W300 not risky'
$w102 = @($sm.items | Where-Object { $_.code -eq 'W102' })[0]
Check ($w102.location -eq 'src\Totals.src:57' -and $w102.column -eq 9 -and $w102.risky) 'W102 file:line, column, risky' "$($w102.location) $($w102.column)"
$w105 = @($sm.items | Where-Object { $_.code -eq 'W105' })[0]
Check ($w105.parser -eq 'bracket' -and $w105.line -eq 12 -and $w105.name -eq 'Lines.src') 'bracket format parsed' "$($w105.parser) $($w105.line)"
$w101 = @($sm.byCode | Where-Object { $_.code -eq 'W101' })[0]
Check ($w101.count -eq 2 -and $w101.risky) 'byCode W101 = 2, risky'
Check ($sm.searchPath[0] -eq $overlay) 'overlay first on the search path' "$($sm.searchPath -join ';')"
Check (@($sm.skippedDirs).Count -eq 1 -and $sm.skippedDirs[0] -like '*\missing') 'missing folder skipped and listed'
Check ((Get-Content -Raw $sm.log) -match [regex]::Escape("rsp=-I$overlay;$code\main\shared`r")) 'response file carries the search path, overlay first, missing dir left out'
Check ($sm.responseFile -like "$out*") 'response file outside the tree'

Section 'error'
$rc = Run @('-Projects', $projects, '-Project', 'svc-error')
$sm = Summary 'main' 'svc-error'
Check ($rc -eq 1) 'exit 1' "rc=$rc"
Check ($sm.verdict -eq 'BROKEN' -and $sm.exitCode -eq 1) 'verdict BROKEN, tool exit recorded'
Check ($sm.counts.errors -eq 2) 'two errors (error + fatal)' "$($sm.counts.errors)"
$f900 = @($sm.items | Where-Object { $_.code -eq 'F900' })[0]
Check ($f900.file -eq '' -and $null -eq $f900.line -and $f900.risky) 'link-stage fatal without file is risky'

Section 'crash: non-zero exit, nothing parsed'
$rc = Run @('-Projects', $projects, '-Project', 'svc-crash')
$sm = Summary 'main' 'svc-crash'
Check ($rc -eq 1 -and $sm.verdict -eq 'BROKEN') 'BROKEN on exit code alone'
Check (($sm.verdictReasons -join ' ') -match 'no error line was parsed') 'says the parsers missed it'
Check ($sm.counts.unparsedSuspect -eq 1) 'unparsed suspect counted'

Section 'unparsed format'
$rc = Run @('-Projects', $projects, '-Project', 'svc-unparsed')
$sm = Summary 'main' 'svc-unparsed'
Check ($rc -eq 0 -and $sm.verdict -eq 'SUFFICIENT') 'never CLEAN with an unparsed diagnostic' $sm.verdict

Section 'silenced'
$rc = Run @('-Projects', $projects, '-Project', 'svc-silenced')
$sm = Summary 'main' 'svc-silenced'
Check ($sm.verdict -eq 'SUFFICIENT' -and @($sm.silencers).Count -eq 1) 'a silencer argument blocks CLEAN' $sm.verdict

Section 'hints only'
$rc = Run @('-Projects', $projects, '-Project', 'svc-hints')
$sm = Summary 'main' 'svc-hints'
Check ($sm.verdict -eq 'CLEAN' -and $sm.counts.hints -eq 1) 'a non-risky hint stays CLEAN' $sm.verdict

Section 'configuration errors -> exit 2'
$rc = Run @('-Projects', $projects, '-Project', 'svc-clean', '-EnvFile', $envInside)
Check ($rc -eq 2 -and $LASTOUT -match 'inside') 'outRoot inside a root refused' "rc=$rc"
Check (-not (Test-Path "$code\out")) 'nothing written inside the tree'
$rc = Run @('-Projects', $projects, '-Project', 'svc-clean', '-EnvFile', (Join-Path $cfg 'none.json'))
Check ($rc -eq 2 -and $LASTOUT -match 'per-machine env file') 'missing env file' "rc=$rc"
$rc = Run @('-Projects', $projects, '-Project', 'nope')
Check ($rc -eq 2) 'unknown build' "rc=$rc"
$rc = Run @('-Projects', $projects, '-Project', 'svc-dup')
Check ($rc -eq 2 -and $LASTOUT -match 'several lines') 'ambiguous id needs -Line' "rc=$rc"
$rc = Run @('-Projects', $projects, '-Project', 'svc-dup', '-Line', '2.1')
Check ($rc -eq 0 -and (Summary '2.1' 'svc-dup').verdict -eq 'CLEAN') '-Line picks the line'
$rc = Run @('-Projects', $projects, '-Project', 'svc-clean', '-Overlay', $overlay)
Check ($rc -eq 2 -and $LASTOUT -match 'overlay') 'overlay refused when not supported' "rc=$rc"
$rc = Run @('-Projects', $projects, '-Project', 'svc-missing')
Check ($rc -eq 2 -and $LASTOUT -match 'nothere') 'required path missing names it' "rc=$rc"

Section 'dry run and list'
$before = @(Get-ChildItem -Recurse $out -ErrorAction SilentlyContinue).Count
$rc = Run @('-Projects', $projects, '-Project', 'svc-warn', '-DryRun')
$after = @(Get-ChildItem -Recurse $out -ErrorAction SilentlyContinue).Count
Check ($rc -eq 0 -and $before -eq $after -and $LASTOUT -match 'dry run') 'dry run writes nothing' "rc=$rc $before/$after"
$rc = Run @('-Projects', $projects, '-List')
Check ($rc -eq 0 -and $LASTOUT -match 'svc-warn' -and $LASTOUT -match '2\.1') 'list'

Section 'every summary keeps the summary.schema.json contract (key sets, verdict)'
$schema = Get-Content -LiteralPath $schemaFile -Raw -Encoding UTF8 | ConvertFrom-Json
function Names($o) { if ($null -eq $o) { return @() }; return @($o.PSObject.Properties | ForEach-Object { $_.Name }) }
function Test-Keys($Object, $Def, [string]$Where) {
    $have = Names $Object
    $allowed = Names $Def.properties
    $missing = @($Def.required | Where-Object { $have -notcontains $_ })
    $extra = @($have | Where-Object { $allowed -notcontains $_ })
    if ($missing.Count -or $extra.Count) { return "$Where missing [$($missing -join ',')] extra [$($extra -join ',')]" }
    return ''
}
foreach ($file in ($script:summaries | Select-Object -Unique)) {
    $doc = Get-Content -LiteralPath $file -Raw -Encoding UTF8 | ConvertFrom-Json
    $problems = @()
    $problems += Test-Keys $doc $schema 'top'
    $problems += Test-Keys $doc.counts $schema.properties.counts 'counts'
    foreach ($b in @($doc.byCode)) { if ($null -ne $b) { $problems += Test-Keys $b $schema.properties.byCode.items 'byCode' } }
    foreach ($i in @($doc.items)) { if ($null -ne $i) { $problems += Test-Keys $i $schema.properties.items.items 'item' } }
    if (@($schema.properties.verdict.enum) -notcontains $doc.verdict) { $problems += "verdict '$($doc.verdict)' not in the enum" }
    $problems = @($problems | Where-Object { $_ })
    Check ($problems.Count -eq 0) ("contract " + (Split-Path -Leaf $file)) ($problems -join '; ')
}

$script:summaries | Select-Object -Unique | Set-Content -Path (Join-Path $S 'summaries.txt') -Encoding ASCII
Write-Host ''
Write-Host ("RESULT pass={0} fail={1}" -f $script:pass, $script:fail)
if ($KeepScratch -or -not $ownScratch) { Write-Host "scratch kept: $S" } else { Remove-Item -LiteralPath $S -Recurse -Force -ErrorAction SilentlyContinue }
if ($script:fail -gt 0) { exit 1 } else { exit 0 }
