<#
  instalar-firebird50.ps1 — instala o Firebird 5.0.4 x64 como instância NOMEADA "Firebird50" (porta 3055),
  lado a lado com o Firebird 2.5 (DefaultInstance, porta 3050), SEM mexer no 2.5 nem nos clientes do sistema.

  Escopo: setes (ambiente de dev NOTEVALDO). Doc: Infra-IA/Sincronizador/ambiente-dev-firebird-duplo.md

  Uso (qualquer PowerShell; o script pede o UAC sozinho):
      powershell -ExecutionPolicy Bypass -File .\instalar-firebird50.ps1
  Opcionais: -Installer <exe> -Port 3055 -Instance Firebird50 -SysdbaPassword masterkey -NoPause

  O que faz (idempotente — pode rodar de novo por cima):
    1. para o 2.5 só durante a instalação (o instalador recusa com outro servidor rodando)
    2. remove um serviço Firebird50 anterior, se existir
    3. instala silencioso com /FORCE, sem registrar serviço (UseApplicationTask) e sem copiar fbclient p/ o sistema
    4. encerra o "firebird.exe -a" que o instalador deixa rodando na 3050
    5. restaura a chave de registro x64 DefaultInstance para o 2.5
    6. firebird.conf: porta, Super, Legacy_Auth + WireCrypt Enabled (gds32 2.5 do Delphi conecta), IpcName próprio
    7. registra e inicia o serviço "Firebird Server - Firebird50" (automático)
    8. religa o 2.5
    9. cria SYSDBA no Legacy_UserManager e prova a conexão com os isql do 5.0 e do 2.5

  Pegadinhas já embutidas (ver doc §4): não usar /SP- nem /LOG em caminho longo (o instalador abre a tela de
  AJUDA e aborta); não usar Start-Process -Wait no instalador; instsvc do 5.0 não aceita -superserver.
  Se já existir security5.fdb na pasta, o instalador IGNORA -SysdbaPassword (vale a senha antiga).
#>
param(
  [string]$Installer      = 'D:\Modelos\Gestao2026\Firebird-5.0.4.1812-0-windows-x64.exe',
  [int]   $Port           = 3055,
  [string]$Instance       = 'Firebird50',
  [string]$SysdbaPassword = 'masterkey',
  [string]$Root           = 'C:\Program Files\Firebird\Firebird_5_0',
  [string]$Isql25         = 'C:\Program Files\Firebird\Firebird_2_5\bin\isql.exe',
  [switch]$NoPause
)
$ErrorActionPreference = 'Stop'

# --- auto-elevação ---------------------------------------------------------------------------------
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
  $argList = @('-NoProfile','-ExecutionPolicy','Bypass','-File',"`"$PSCommandPath`"",
               '-Installer',"`"$Installer`"",'-Port',$Port,'-Instance',$Instance,
               '-SysdbaPassword',$SysdbaPassword,'-Root',"`"$Root`"",'-Isql25',"`"$Isql25`"")
  if ($NoPause) { $argList += '-NoPause' }
  $p = Start-Process powershell.exe -ArgumentList $argList -Verb RunAs -Wait -PassThru
  exit $p.ExitCode
}

New-Item -ItemType Directory -Force 'C:\Temp' | Out-Null
$stamp = Get-Date -Format yyyyMMdd_HHmmss
Start-Transcript "C:\Temp\instalar-firebird50.$stamp.log" -Force

$svc25 = 'FirebirdServerDefaultInstance'
$svc50 = "FirebirdServer$Instance"
$reg   = 'HKLM:\SOFTWARE\Firebird Project\Firebird Server\Instances'
$ok = $false
$was25Running = $false
try {
  if (-not (Test-Path $Installer)) { throw "instalador não encontrado: $Installer" }

  $old25 = $null
  if (Test-Path $reg) { $old25 = (Get-ItemProperty $reg).DefaultInstance }
  Write-Host "[1/9] DefaultInstance x64 antes: $old25"

  $s25 = Get-Service $svc25 -ErrorAction SilentlyContinue
  $was25Running = ($s25 -ne $null) -and ($s25.Status -eq 'Running')
  if ($was25Running) {
    Write-Host '[2/9] parando Firebird 2.5 (só durante a instalação — o instalador exige)'
    Stop-Service $svc25 -Force
    $s25.WaitForStatus('Stopped', '00:00:30')
  } else { Write-Host '[2/9] Firebird 2.5 já estava parado/inexistente' }

  if ((Get-Service $svc50 -ErrorAction SilentlyContinue) -and (Test-Path "$Root\instsvc.exe")) {
    Write-Host "[3/9] removendo serviço anterior $svc50"
    & "$Root\instsvc.exe" stop -name $Instance
    & "$Root\instsvc.exe" remove -name $Instance
  } else { Write-Host '[3/9] sem serviço anterior' }

  Write-Host '[4/9] instalando Firebird 5.0.4 x64 (silencioso)'
  $log = 'C:\Temp\firebird50-setup.log'
  $instArgs = @('/VERYSILENT','/SUPPRESSMSGBOXES','/NORESTART','/FORCE','/LANG=en',
                '/COMPONENTS=ServerComponent,DevAdminComponent,ClientComponent',
                '/TASKS=UseSuperServerTask,UseApplicationTask',
                "/SYSDBAPASSWORD=$SysdbaPassword",
                "/LOG=$log")
  $p = Start-Process -FilePath $Installer -ArgumentList $instArgs -PassThru
  $p.WaitForExit()   # nunca -Wait: o firebird.exe -a filho (elevado) prenderia o -Wait para sempre
  Write-Host "      exit code do instalador: $($p.ExitCode)"
  if ($p.ExitCode -ne 0) { Get-Content $log -Tail 20; throw "instalador falhou (exit $($p.ExitCode)) — ver $log" }
  if (-not (Test-Path "$Root\firebird.exe")) { throw "firebird.exe não apareceu em $Root" }
  Get-Process firebird -ErrorAction SilentlyContinue | Where-Object { $_.Path -like "$Root*" } | ForEach-Object {
    Write-Host "      encerrando firebird.exe -a deixado pelo instalador (pid $($_.Id))"
    Stop-Process -Id $_.Id -Force
  }
  Start-Sleep 2

  if ($old25) {
    Write-Host '[5/9] restaurando DefaultInstance x64 para o 2.5 (o instalador sobrescreve; o 5.0 não precisa dela)'
    Set-ItemProperty $reg -Name DefaultInstance -Value $old25
  } else { Write-Host '[5/9] não havia DefaultInstance x64 antes — mantida a do instalador' }

  Write-Host '[6/9] configurando firebird.conf'
  $conf = "$Root\firebird.conf"
  Copy-Item $conf "$conf.bak_$stamp"
  $set = [ordered]@{
    RemoteServicePort = "$Port"
    ServerMode        = 'Super'
    AuthServer        = 'Srp256, Srp, Legacy_Auth'
    UserManager       = 'Srp, Legacy_UserManager'
    WireCrypt         = 'Enabled'
    IpcName           = $Instance.ToUpper()
  }
  $marker = "# --- Gestao2027 dev: instância $Instance lado a lado com o 2.5 (instalar-firebird50.ps1) ---"
  $lines = @(Get-Content $conf | Where-Object { $_ -ne $marker })
  foreach ($k in $set.Keys) {
    $lines = @($lines | ForEach-Object { if ($_ -match "^\s*$k\s*=") { "#$_" } else { $_ } })
  }
  $lines += ''
  $lines += $marker
  foreach ($k in $set.Keys) { $lines += "$k = $($set[$k])" }
  Set-Content $conf $lines -Encoding ASCII
  $lines | Where-Object { $_ -match '^\s*[A-Za-z]' } | ForEach-Object { Write-Host "      $_" }

  Write-Host "[7/9] registrando e iniciando o serviço $svc50"
  & "$Root\instsvc.exe" install -auto -name $Instance
  & "$Root\instsvc.exe" start -name $Instance

  if ($was25Running) { Write-Host '[8/9] religando Firebird 2.5'; Start-Service $svc25 }
  else { Write-Host '[8/9] 2.5 não estava rodando antes — deixado como estava' }

  Write-Host '[9/9] SYSDBA no Legacy_UserManager + prova de conexão'
  Start-Sleep 3
  $sql50 = "create or alter user SYSDBA password '$SysdbaPassword' using plugin Legacy_UserManager;`ncommit;`n" +
           "select rdb`$get_context('SYSTEM','ENGINE_VERSION') as engine_50 from rdb`$database;`nexit;`n"
  $sql50 | & "$Root\isql.exe" -user SYSDBA -password $SysdbaPassword -q "localhost/$Port`:employee"
  if (Test-Path $Isql25) {
    Write-Host '      cliente 2.5 (fbclient 2.5, Legacy_Auth) -> servidor 5.0:'
    "select rdb`$get_context('SYSTEM','ENGINE_VERSION') as engine_via_cliente_25 from rdb`$database;`nexit;`n" |
      & $Isql25 -user SYSDBA -password $SysdbaPassword -q "localhost/$Port`:employee"
  }
  Get-Service Firebird* | Format-Table Name, DisplayName, Status, StartType -AutoSize | Out-String | Write-Host
  netstat -ano | Select-String ":(3050|$Port)\s.*LISTENING" | ForEach-Object { Write-Host "      $_" }
  $ok = $true
} catch {
  Write-Host "ERRO: $($_.Exception.Message)" -ForegroundColor Red
  try { if ($was25Running) { Start-Service $svc25 } } catch {}
} finally {
  if ($ok) { Write-Host "RESULTADO: OK — Firebird 5.0 na porta $Port como serviço $svc50" } else { Write-Host 'RESULTADO: FALHOU' -ForegroundColor Red }
  Stop-Transcript
  if (-not $NoPause) { Read-Host 'Enter para fechar' | Out-Null }
}
if ($ok) { exit 0 } else { exit 1 }
