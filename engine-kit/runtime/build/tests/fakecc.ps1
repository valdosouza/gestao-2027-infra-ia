# fakecc.ps1 - a fake command-line compiler for test-build.ps1 (engine-kit runtime, build tools)
#
# Prints a fixed set of diagnostics per -Mode, in the three formats of projects.example.json
# (paren, bracket, bare), plus its working folder, its arguments and the lines of any
# @response file, so the test can check what build.ps1 passed. One line goes to stderr on
# purpose (the runner must read both streams).
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.

param([string]$Mode = 'clean', [Parameter(ValueFromRemainingArguments = $true)]$Rest)

Write-Output "fakecc 1.0 - mode $Mode"
Write-Output ("cwd=" + (Get-Location).ProviderPath)
foreach ($r in $Rest) {
    Write-Output "arg=$r"
    if ($r -like '@*') { foreach ($l in (Get-Content -LiteralPath $r.Substring(1))) { Write-Output "rsp=$l" } }
}
switch ($Mode) {
    'clean' { Write-Output '1200 lines compiled, 0 errors, 0 warnings.'; exit 0 }
    'warn' {
        Write-Output 'src\Totals.src(42) Warning: W101 Return value of function ''Total'' might be undefined'
        Write-Output 'src\Totals.src(57,9) Warning: W102 Variable ''x'' might not have been initialized'
        Write-Output '[acme-cc Warning] src\Lines.src(12): W105 Symbol ''OldRound'' is deprecated'
        Write-Output '[acme-cc Warning] src\Lines.src(80): W300 Comparison always evaluates to True'
        Write-Output 'src\Lines.src(90) Hint: H201 Value assigned to ''tmp'' never used'
        Write-Output 'src\Lines.src(91) Hint: H999 Private symbol declared but never used'
        [Console]::Error.WriteLine('src\Totals.src(60) Warning: W101 Return value of function ''Net'' might be undefined')
        Write-Output '1200 lines compiled, 0 errors, 5 warnings.'
        exit 0
    }
    'error' {
        Write-Output 'src\Totals.src(42) Warning: W101 Return value of function ''Total'' might be undefined'
        Write-Output 'src\Orders.src(30) Error: E500 Undeclared identifier ''z'''
        Write-Output 'Fatal: F900 Could not compile used unit ''Orders'''
        exit 1
    }
    'crash' { Write-Output 'Something odd happened: internal error in phase 3'; exit 3 }
    'unparsed' { Write-Output 'src/Lines.src:14:3: warning: shadowed variable [W400]'; exit 0 }
    'hintsonly' { Write-Output 'src\Lines.src(91) Hint: H999 Private symbol declared but never used'; exit 0 }
}
exit 0
