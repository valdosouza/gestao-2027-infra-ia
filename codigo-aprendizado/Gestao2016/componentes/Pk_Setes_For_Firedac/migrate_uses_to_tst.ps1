$Root = 'd:\Gestao2016'
$SkipParts = @('__history', '.svn', 'Pk_Setes_For_Firedac')
$RemoveExact = @(
    'IBX.IBQuery','IBQuery','IBX.IBTable','IBTable','IBX.IBDatabase','IBDatabase',
    'IBX.IBTransaction','IBTransaction','IBX.IBStoredProc','IBStoredProc',
    'IBX.IBScript','IBScript','IBX.IBSQL','IBSql','IBSQL'
)
$TypeUnitMap = @(
    @{ Pattern = '\bTSTWaitCursor\b'; Unit = 'STWaitCursor' },
    @{ Pattern = '\bTSTFBDriverLink\b'; Unit = 'STFBDriverLink' },
    @{ Pattern = '\bTSTSQL\b'; Unit = 'STSQL' },
    @{ Pattern = '\bTSTClientDataset\b'; Unit = 'STClientDataset' },
    @{ Pattern = '\bTSTScript\b'; Unit = 'STScript' },
    @{ Pattern = '\bTSTStoredProc\b'; Unit = 'STStoredProc' },
    @{ Pattern = '\bTSTDataSet\b'; Unit = 'STDataSet' },
    @{ Pattern = '\bTSTTable\b'; Unit = 'STTable' },
    @{ Pattern = '\bTSTTransaction\b'; Unit = 'STTransaction' },
    @{ Pattern = '\bTSTDatabase\b'; Unit = 'STDatabase' },
    @{ Pattern = '\bTSTQuery\b'; Unit = 'STQuery' }
)

function Should-Skip($path) {
    foreach ($part in $SkipParts) {
        if ($path -like "*\$part\*") { return $true }
    }
    return $false
}

function Split-Units($body) {
    $units = @()
    foreach ($part in ($body -split ',')) {
        $u = $part.Trim()
        if ($u) { $units += $u }
    }
    return $units
}

function Clean-Units($units, $keepIbFields) {
    $cleaned = @()
    foreach ($u in $units) {
        if ($RemoveExact -contains $u) { continue }
        if ($u -like 'FireDAC.*') { continue }
        if (-not $keepIbFields -and ($u -eq 'IBCustomDataSet' -or $u -eq 'IBX.IBCustomDataSet')) { continue }
        $cleaned += $u
    }
    return $cleaned
}

function Ensure-StUnits($units, $content) {
    $existing = @{}
    foreach ($u in $units) { $existing[$u] = $true }
    foreach ($map in $TypeUnitMap) {
        if ($content -match $map.Pattern) {
            if (-not $existing.ContainsKey($map.Unit)) {
                $units += $map.Unit
                $existing[$map.Unit] = $true
            }
        }
    }
    return $units
}

function Join-Units($units) {
    if ($units.Count -eq 0) { return '' }
    $line = '  '
    $lines = @()
    foreach ($u in $units) {
        $add = if ($line.Trim()) { ", $u" } else { $u }
        if (($line.Length + $add.Length) -gt 100 -and $line.Trim()) {
            $lines += ($line.TrimEnd(',') + ',')
            $line = "  $u"
        } else {
            $line += $add
        }
    }
    if ($line.Trim()) { $lines += $line }
    return ($lines -join "`r`n")
}

$changed = 0
Get-ChildItem -Path $Root -Filter '*.pas' -Recurse | ForEach-Object {
    if (Should-Skip $_.FullName) { return }
    $text = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::GetEncoding(28591))
    $original = $text
    $keepIbFields = $text -match '\bTIB\w+Field\b'

    $text = [regex]::Replace($text, '(?is)(\buses\b\s*)(.*?)(;)', {
        param($m)
        $units = Split-Units $m.Groups[2].Value
        $units = Clean-Units $units $keepIbFields
        $units = Ensure-StUnits $units $text
        if ($units.Count -eq 0) { return $m.Value }
        return $m.Groups[1].Value + (Join-Units $units) + $m.Groups[3].Value
    })

    if ($text -ne $original) {
        [System.IO.File]::WriteAllText($_.FullName, $text, [System.Text.Encoding]::GetEncoding(28591))
        $changed++
        Write-Host $_.FullName
    }
}
Write-Host "Updated $changed files"
