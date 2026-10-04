<#
  remover-firebird50.ps1 — remove a instância Firebird50 (5.0.4 x64) deixando a máquina só com o 2.5.

  ⚠️ NÃO usa o desinstalador do Inno (unins000.exe) de propósito: ele roda "instsvc remove" e "instreg remove"
     SEM nome de instância, ou seja, apagaria o serviço FirebirdServerDefaultInstance e a chave de registro
     DefaultInstance — que são do Firebird 2.5. Aqui a remoção é manual e cirúrgica.

  Escopo: setes (ambiente de dev NOTEVALDO). Doc: Infra-IA/Sincronizador/ambiente-dev-firebird-duplo.md
  Volta: Infra-IA/Sincronizador/scripts/firebird50/instalar-firebird50.ps1

  Uso (pede o UAC sozinho):
      powershell -ExecutionPolicy Bypass -File .\remover-firebird50.ps1
  Opcionais: -Instance Firebird50 -Root "C:\Program Files\Firebird\Firebird_5_0" -BackupDir <pasta> -NoPause

  O que faz:
    1. para e remove o serviço "Firebird Server - Firebird50" (por NOME de instância)
    2. encerra processos do 5.0 que ainda estejam vivos
    3. backup de firebird.conf / databases.conf / security5.fdb / firebird.log em <BackupDir>\<data>\
    4. apaga a pasta do 5.0
    5. apaga a entrada "Firebird 5.0.4 (x64)" de Programas e Recursos e o grupo do Menu Iniciar
  O que NÃO toca: serviço/pasta/registro/DLLs do 2.5; restos antigos 5.0.1 e 4.0 Win32 em Program Files (x86).
#>
param(
  [string]$Instance  = 'Firebird50',
  [string]$Root      = 'C:\Program Files\Firebird\Firebird_5_0',
  [string]$BackupDir = 'D:\Modelos\Gestao2026\Firebird50-backup',
  [switch]$NoPause
)
$ErrorActionPreference = 'Stop'

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
  $argList = @('-NoProfile','-ExecutionPolicy','Bypass','-File',"`"$PSCommandPath`"",
               '-Instance',$Instance,'-Root',"`"$Root`"",'-BackupDir',"`"$BackupDir`"")
  if ($NoPause) { $argList += '-NoPause' }
  $p = Start-Process powershell.exe -ArgumentList $argList -Verb RunAs -Wait -PassThru
  exit $p.ExitCode
}

New-Item -ItemType Directory -Force 'C:\Temp' | Out-Null
$stamp = Get-Date -Format yyyyMMdd_HHmmss
Start-Transcript "C:\Temp\remover-firebird50.$stamp.log" -Force

$svc25 = 'FirebirdServerDefaultInstance'
$svc50 = "FirebirdServer$Instance"
$reg   = 'HKLM:\SOFTWARE\Firebird Project\Firebird Server\Instances'
$ok = $false
try {
  if ($Root -notlike '*Firebird_5_0*') { throw "Root suspeito ($Root) — recusando apagar" }
  $reg25 = $null; if (Test-Path $reg) { $reg25 = (Get-ItemProperty $reg).DefaultInstance }
  Write-Host "DefaultInstance x64 (não será tocada): $reg25"

  if (Get-Service $svc50 -ErrorAction SilentlyContinue) {
    Write-Host "[1/5] parando e removendo o serviço $svc50"
    if (Test-Path "$Root\instsvc.exe") {
      & "$Root\instsvc.exe" stop -name $Instance
      & "$Root\instsvc.exe" remove -name $Instance
    } else {
      Stop-Service $svc50 -Force -ErrorAction SilentlyContinue
      sc.exe delete $svc50
    }
  } else { Write-Host "[1/5] serviço $svc50 não existe" }

  Write-Host '[2/5] encerrando processos do 5.0 ainda vivos'
  Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.Path -and ($_.Path -like "$Root*") } | ForEach-Object {
    Write-Host "      $($_.Name) (pid $($_.Id))"; Stop-Process -Id $_.Id -Force
  }
  Start-Sleep 2

  if (Test-Path $Root) {
    $bk = Join-Path $BackupDir $stamp
    Write-Host "[3/5] backup em $bk"
    New-Item -ItemType Directory -Force $bk | Out-Null
    foreach ($f in 'firebird.conf','databases.conf','security5.fdb','firebird.log','fbtrace.conf','replication.conf','plugins.conf') {
      if (Test-Path "$Root\$f") { Copy-Item "$Root\$f" $bk; Write-Host "      $f" }
    }
    Write-Host "[4/5] apagando $Root"
    Remove-Item $Root -Recurse -Force
  } else { Write-Host "[3/5][4/5] pasta $Root já não existe" }

  Write-Host '[5/5] limpando Programas e Recursos + Menu Iniciar do 5.0 (x64)'
  Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall' | ForEach-Object {
    $dn = (Get-ItemProperty $_.PSPath).DisplayName
    if ($dn -like 'Firebird 5.0.*(x64)') { Write-Host "      registro: $dn"; Remove-Item $_.PSPath -Recurse -Force }
  }
  $sm = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Firebird 5.0 (x64)'
  if (Test-Path $sm) { Remove-Item $sm -Recurse -Force; Write-Host "      menu: $sm" }

  Write-Host ''
  Write-Host '--- verificação ---'
  Get-Service Firebird* | Format-Table Name, DisplayName, Status, StartType -AutoSize | Out-String | Write-Host
  netstat -ano | Select-String ':305[0-9]\s.*LISTENING' | ForEach-Object { Write-Host "      $_" }
  if (Test-Path $reg) { Write-Host ("      DefaultInstance x64 agora: " + (Get-ItemProperty $reg).DefaultInstance) }
  Get-Item 'C:\Windows\System32\fbclient.dll','C:\Windows\System32\gds32.dll','C:\Windows\SysWOW64\gds32.dll' -ErrorAction SilentlyContinue |
    ForEach-Object { Write-Host "      $($_.FullName) = $($_.VersionInfo.FileVersion)" }
  $ok = $true
} catch {
  Write-Host "ERRO: $($_.Exception.Message)" -ForegroundColor Red
} finally {
  if ($ok) { Write-Host 'RESULTADO: OK — só o Firebird 2.5 permanece' } else { Write-Host 'RESULTADO: FALHOU' -ForegroundColor Red }
  Stop-Transcript
  if (-not $NoPause) { Read-Host 'Enter para fechar' | Out-Null }
}
if ($ok) { exit 0 } else { exit 1 }
