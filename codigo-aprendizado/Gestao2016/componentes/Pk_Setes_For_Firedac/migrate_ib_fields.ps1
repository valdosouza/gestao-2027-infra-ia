$Root = 'd:\Gestao2016'
$SkipParts = @('__history', '.svn', 'Pk_Setes_For_Firedac')

$FieldMap = @{
    'TIBStringField' = 'TStringField'
    'TIBBCDField' = 'TBCDField'
    'TIBIntegerField' = 'TIntegerField'
    'TIBSmallIntField' = 'TSmallintField'
    'TIBFloatField' = 'TFloatField'
    'TIBDateField' = 'TDateField'
    'TIBDateTimeField' = 'TDateTimeField'
    'TIBTimeField' = 'TTimeField'
    'TIBMemoField' = 'TMemoField'
    'TIBBlobField' = 'TBlobField'
    'TIBLargeIntField' = 'TLargeintField'
}

function Should-Skip($path) {
    foreach ($part in $SkipParts) {
        if ($path -like "*\$part\*") { return $true }
    }
    return $false
}

function Replace-IbFields($text) {
    foreach ($key in $FieldMap.Keys) {
        $text = $text.Replace($key, $FieldMap[$key])
    }
    return $text
}

function Remove-IbCustomFromUses($text) {
    return [regex]::Replace($text, '(?is)(\buses\b\s*)(.*?)(;)', {
        param($m)
        $units = @()
        foreach ($part in ($m.Groups[2].Value -split ',')) {
            $u = $part.Trim()
            if (-not $u) { continue }
            if ($u -eq 'IBCustomDataSet' -or $u -eq 'IBX.IBCustomDataSet') { continue }
            $units += $u
        }
        if ($units.Count -eq 0) { return $m.Value }
        $body = '  ' + ($units -join ', ')
        return $m.Groups[1].Value + $body + $m.Groups[3].Value
    })
}

$changed = 0
Get-ChildItem -Path $Root -Include '*.pas','*.dfm' -Recurse | ForEach-Object {
    if (Should-Skip $_.FullName) { return }
    $text = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::GetEncoding(28591))
    $original = $text
    $text = Replace-IbFields $text
    if ($_.Extension -eq '.pas') {
        $text = Remove-IbCustomFromUses $text
    }
    if ($text -ne $original) {
        [System.IO.File]::WriteAllText($_.FullName, $text, [System.Text.Encoding]::GetEncoding(28591))
        $changed++
    }
}
Write-Host "Updated $changed files"
