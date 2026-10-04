# Ambiente de dev — Firebird 2.5 e 5.0 lado a lado (NOTEVALDO)

**Status**: ✅ PROCEDIMENTO SCRIPTADO e PROVADO em 2026-10-03 (remover → instalar → remover, ciclo completo). Estado atual da máquina: **só o 2.5** (5.0 removido a pedido do Valdo durante os testes de migração 2.5→5.0; volta em ~20 s com o script de instalação)
**Origem**: sessão Claude Code de 2026-10-02 ("configurar este computador com duas versões servidoras do Firebird")
**Referências**: `prompt_construcao_banco_cliente.md` (DDL do bootstrap precisa valer em Firebird 2.5 E 5.0),
`roteiro-implantacao-cliente.md`, `D:\Modelos\fb5\` (bancos de teste em ODS 13)
**Escopo**: setes

> Por quê: o bootstrap do Sincronizador (`DM.EnsureSincronia`) gera DDL que tem de rodar em clientes com
> Firebird 2.5 e com Firebird 5.0. Sem os dois servidores na máquina de dev, só uma das sintaxes é testada.

## 0. Scripts (2026-10-03) — `Infra-IA/Sincronizador/scripts/firebird50/`

| Script | O que faz | Uso |
|---|---|---|
| `instalar-firebird50.ps1` | Instala o 5.0.4 x64 do `D:\Modelos\Gestao2026\Firebird-5.0.4.1812-0-windows-x64.exe` como instância `Firebird50` na 3055, configura o conf, registra o serviço, cria o SYSDBA legado e PROVA a conexão com os isql do 5.0 e do 2.5. Idempotente. | `powershell -ExecutionPolicy Bypass -File .\instalar-firebird50.ps1` (pede UAC sozinho; `-NoPause` p/ automação) |
| `remover-firebird50.ps1` | Remove a instância 5.0 deixando SÓ o 2.5: para/remove o serviço por nome, backup de conf+security5.fdb+log em `D:\Modelos\Gestao2026\Firebird50-backup\<data>\`, apaga a pasta, a entrada de Programas e Recursos e o Menu Iniciar. **Nunca usa o `unins000.exe`** (ele rodaria `instsvc remove`/`instreg remove` sem nome e apagaria o serviço e o registro do 2.5). | idem |

Ciclo provado em 2026-10-03: remover (7 s) → instalar (20 s, 9 passos, engine 5.0.4 pelos dois clientes) → remover.
Os dois scripts param o 2.5 só o tempo necessário (instalação) — o Gestão desktop aberto perde a conexão nesse momento.
Logs: `C:\Temp\instalar-firebird50.<data>.log`, `C:\Temp\remover-firebird50.<data>.log`, `C:\Temp\firebird50-setup.log` (Inno).
⚠️ Scripts salvos em **UTF-8 com BOM** — sem o BOM o PowerShell 5.1 lê o travessão (—) como aspas tipográficas e o parse quebra.

## 1. Estado final (quando o 5.0 está instalado)

| Versão | Pasta | Serviço Windows | Porta | Modo | Cliente no sistema |
|---|---|---|---|---|---|
| 2.5.1.26351 x64 | `C:\Program Files\Firebird\Firebird_2_5` | `FirebirdServerDefaultInstance` ("Firebird Server - DefaultInstance") | **3050** | SuperServer (`-m`) | `System32\fbclient.dll` + `gds32.dll` 2.5.1; `SysWOW64\gds32.dll` 2.5.1 (é o que o Delphi 32 bits usa) |
| 5.0.4.1812 x64 | `C:\Program Files\Firebird\Firebird_5_0` | `FirebirdServerFirebird50` ("Firebird Server - Firebird50") | **3055** | Super | NÃO copiado para o sistema (de propósito — ver §3) |

Strings de conexão:

```
localhost/3050:<caminho>.fdb      → Firebird 2.5
localhost/3055:<caminho>.fdb      → Firebird 5.0  (ex.: localhost/3055:employee)
```

`firebird.conf` do 5.0 (bloco acrescentado no fim; backup `firebird.conf.bak_<data>` ao lado):

```
RemoteServicePort = 3055
ServerMode = Super
AuthServer = Srp256, Srp, Legacy_Auth
UserManager = Srp, Legacy_UserManager
WireCrypt = Enabled
IpcName = FIREBIRD50
```

- `Legacy_Auth` + `WireCrypt = Enabled` + SYSDBA criado também no `Legacy_UserManager` → o cliente 2.5
  (gds32/fbclient 2.5.1 que o Delphi usa) conecta no 5.0. Provado: `isql` do 2.5 contra `localhost/3055:employee`
  devolveu engine `5.0.4`.
- `IpcName = FIREBIRD50`: sem isso o 5.0 loga `XNET error ... CreateMutex failed` no start, porque o 2.5 já
  usa o nome local padrão `FIREBIRD`. Só afeta conexão local sem `localhost/porta:`; TCP funcionava mesmo assim.
- SYSDBA do 5.0: senha padrão de instalação (`masterkey`, a mesma convenção do dev) nos dois plugins (Srp e Legacy).

## 2. Resíduos pré-existentes (deixados como estavam)

- `C:\Program Files (x86)\Firebird\Firebird_5_0` = Firebird **5.0.1 Win32** instalado em 2024-12-30, sem serviço,
  conf já apontava para a porta 3055 (tentativa anterior). O registro `HKLM\SOFTWARE\WOW6432Node\Firebird Project\
  Firebird Server\Instances\DefaultInstance` aponta para ele — ferramentas 32 bits que leem o registro vão
  "ver" essa pasta. Candidato a desinstalar (entrada "Firebird 5.0.1.1469 (Win32)" em Programas e Recursos);
  decisão do Valdo.
- `C:\Program Files (x86)\Firebird\Firebird_4_0` = resto de um 4.0.4 Win32 (sem desinstalador, sem registro;
  conf na porta 3060; log com erros XNET de dez/2024). Pode ser apagado à mão.
- `SysWOW64\fbclient.dll` é 4.0.4 (32 bits) — veio dessa instalação antiga. Não foi mexido.

## 3. Decisões do procedimento (por que foi feito assim)

1. **Instância NOMEADA, não DefaultInstance**: o instalador gráfico do 5.0 registra o serviço com o MESMO nome
   do 2.5 (`FirebirdServerDefaultInstance`) — colidiria. Por isso o instalador rodou com
   `/TASKS=UseSuperServerTask,UseApplicationTask` (instala arquivos, não registra serviço) e o serviço foi
   criado depois com `instsvc install -auto -name Firebird50`.
2. **Sem copiar cliente para o sistema** (`CopyFbClientToSysTask` fora): o `System32\fbclient.dll` 2.5.1 e os
   `gds32.dll` ficam intactos — o Gestão desktop/Sincronizador continuam falando com o 2.5 como antes.
3. **Chave de registro x64 `DefaultInstance` restaurada para o 2.5** depois da instalação (o instalador a
   sobrescreve com o 5.0; o 5.0 não precisa dela — acha a raiz pelo próprio exe).
4. **Porta 3055** = a que já estava configurada no 5.0.1 x86 (intenção anterior do Valdo), mantida.

## 4. Pegadinhas do instalador (Inno Setup do Firebird 5.0.4) — reter

- **Tela de "ajuda" em vez de instalar**: com `/SP-` e/ou `/LOG=<caminho longo em AppData\...>` o
  `InitializeSetup` interpretou a linha de comando como pedido de HELP e abortou (`InitializeSetup returned
  False`, exit 1), SEM dizer o motivo no modo silencioso. Funcionou com `/LOG=C:\Temp\...` curto e sem `/SP-`.
- **O motivo do abort só aparece no log do Inno quando a caixa de diálogo não é suprimida** (`Message box (OK): ...`).
  Para diagnosticar, rodar sem `/VERYSILENT /SUPPRESSMSGBOXES` e ler o `/LOG`.
- **`/FORCE` é obrigatório** com outro Firebird instalado (senão a análise de ambiente recusa).
- **Servidor 2.5 tem de estar PARADO** durante a instalação ("An existing Firebird v2.1 or later Server is
  running") — e isso derruba a conexão do Gestão desktop aberto; avisar antes.
- **O instalador termina rodando `firebird.exe -a`** (modo aplicação, porta 3050 do conf padrão) mesmo sem
  `AutoStartTask`; o processo nasce ELEVADO e `Start-Process -Wait` fica preso nele. Matar com PowerShell
  elevado (`Stop-Process`), só então configurar a porta e registrar o serviço.
- **`instsvc` do 5.0 não aceita `-superserver`** (o modo vem do `ServerMode` do conf): `instsvc install -auto -name <inst>`.
- `instsvc.exe` e o instalador exigem administrador (UAC); tudo foi feito com `Start-Process -Verb RunAs`.

## 5. Comandos úteis

```powershell
# estado
Get-Service Firebird* | Format-Table Name, Status, StartType
netstat -ano | Select-String ':305[05]\s.*LISTENING'

# testar cada servidor
& 'C:\Program Files\Firebird\Firebird_5_0\isql.exe' -user SYSDBA -password masterkey localhost/3055:employee
& 'C:\Program Files\Firebird\Firebird_2_5\bin\isql.exe' -user SYSDBA -password masterkey "localhost/3050:C:\Program Files\Firebird\Firebird_2_5\examples\empbuild\employee.fdb"

# parar/iniciar (admin)
Stop-Service FirebirdServerFirebird50 ; Start-Service FirebirdServerFirebird50

# remover a instância do 5.0 se um dia for preciso (admin)
& 'C:\Program Files\Firebird\Firebird_5_0\instsvc.exe' stop -name Firebird50
& 'C:\Program Files\Firebird\Firebird_5_0\instsvc.exe' remove -name Firebird50
```

Logs da instalação ficaram em `C:\Temp\fb5-setup.log` (Inno), `C:\Temp\fb5-instsvc.log`, `C:\Temp\fb5-ipc.log`.
