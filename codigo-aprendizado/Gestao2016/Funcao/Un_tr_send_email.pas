unit Un_tr_send_email;

interface

uses
      Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, ACBrMail, types, ACBrBase, ExtCtrls, ControllerUsuario;

// Retorna o numero de threads de email ainda em execucao.
function EmailThreadsAtivos: Integer;

// Aguarda (com bombeamento de mensagens) ate todas as threads de email
// terminarem ou o timeout expirar. Chamar em finalizaProcessoAbertos.
procedure AguardaEmailThreads(TimeoutMs: Cardinal = 5000);

type
  // Classe base (abstrata) para threads de envio de email.
  // Centraliza o ciclo de vida da thread, a configuracao do TACBrMail
  // e o metodo que efetivamente envia (envia).
  // As classes filhas implementam apenas a particularidade do email:
  //   - preparar  : monta destino, assunto e remetente (pode usar Synchronize)
  //   - gerarCorpo: retorna o HTML do corpo
  TTRSendEmail = class(TThread)
  protected
    FAssunto    : String;
    FDestino    : TStringList;
    FAnexo      : TStringList;
    Id_Mail     : TACBrMail;
    FUltimoErro : String;
    FCtrlUsuario : TControllerUsuario;
    procedure configurarRemetenteAutomatico;
    function configurarRemetente: Boolean;
    // Hook do ACBrMail. Como UseThread=False, executa nesta thread,
    // em sequencia ao Send. Util para futuro log/auditoria.
    procedure AfterMailProcess(Sender: TObject); virtual;

    // Implementadas pelas filhas.
    // preparar: retorna False quando nao ha condicoes de enviar
    // (ex.: sem destinatario, sem configuracao de SMTP, etc).
    function preparar: Boolean; virtual; abstract;
    function gerarCorpo: String; virtual; abstract;

    function envia: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;

    property UltimoErro : String read FUltimoErro;
  end;

implementation

uses
      Windows, un_sistema;

{ Contador global de threads de email ativas }
var
  GEmailThreadsAtivos: Integer = 0;

function EmailThreadsAtivos: Integer;
begin
  Result := GEmailThreadsAtivos;
end;

procedure AguardaEmailThreads(TimeoutMs: Cardinal = 5000);
var
  LcDeadline: Cardinal;
begin
  LcDeadline := GetTickCount + TimeoutMs;
  while (GEmailThreadsAtivos > 0) and (GetTickCount < LcDeadline) do
  begin
    Application.ProcessMessages;
    Sleep(50);
  end;
end;

{ TTRSendEmail }

function TTRSendEmail.configurarRemetente: Boolean;
begin
  Result := False;
  if not FCtrlUsuario.exist then
    Exit;

  with Id_Mail do
  Begin
    From     := FCtrlUsuario.Registro.emailLogin;
    FromName := FCtrlUsuario.Registro.emailLabel;

    Host   := FCtrlUsuario.Registro.emailSMTP;
    Port   := FCtrlUsuario.Registro.emailPorta;
    SetSSL := (FCtrlUsuario.Registro.emailSSL = 'S');
    SetTLS := (FCtrlUsuario.Registro.emailAutenticacao = 'S');

    if Length(FCtrlUsuario.Registro.email) > 0 then
      Username := FCtrlUsuario.Registro.email
    else
      Username := FCtrlUsuario.Registro.emailLogin;
    Password := FCtrlUsuario.Registro.emailSenha;
  End;

  Result := True;
end;

procedure TTRSendEmail.configurarRemetenteAutomatico;
begin
  with Id_Mail do
  Begin
    From     := 'sistemanfe@setes.com.br';
    FromName := 'Sistema Setes - Envio Automatico';

    Host     := 'setes.com.br';
    SetSSL   := False;
    SetTLS   := True;
    Username := 'sistemanfe@setes.com.br';
    Password := 'Eqpm20mrdsncdJ16!';
    Port     := '587';
  End;

end;

constructor TTRSendEmail.Create;
begin
  inherited Create(True); // criada suspensa; o consumidor chama Start
  InterlockedIncrement(GEmailThreadsAtivos);
  FCtrlUsuario    := TControllerUsuario.Create(nil);
  Id_Mail := TACBrMail.Create(NIL);
  Id_Mail.OnAfterMailProcess := AfterMailProcess;
  // Send sincrono dentro desta thread; evita corrida com FreeOnTerminate
  // liberando Id_Mail enquanto a thread interna do ACBrMail ainda envia.
  Id_Mail.UseThread := False;
  FDestino    := TStringList.Create;
  FAnexo      := TStringList.Create;
  FUltimoErro := '';
  FreeOnTerminate := True;
end;

destructor TTRSendEmail.Destroy;
begin
  Id_Mail.Free;
  FAnexo.Free;
  FDestino.Free;
  FCtrlUsuario.Free;
  InterlockedDecrement(GEmailThreadsAtivos);
  inherited;
end;

procedure TTRSendEmail.AfterMailProcess(Sender: TObject);
begin
  // Ponto de extensao opcional para descendentes.
end;

procedure TTRSendEmail.Execute;
begin
  try
    if preparar then
      envia;
  except
    on E: Exception do
    Begin
      FUltimoErro := E.Message;
      OutputDebugString(PChar(Self.ClassName + ' erro: ' + E.Message));
    End;
  end;
end;

function TTRSendEmail.envia: Boolean;
var
  Lc_I   : Integer;
  Lc_Aux : String;
begin
  Result := False;

    if not Fc_PingConectadoSetes then
  Begin
    FUltimoErro := 'Sem conexao com a internet';
    Exit;
  End;

  if FDestino.Count = 0 then
  Begin
    FUltimoErro := 'Sem destinatario';
    Exit;
  End;

  with Id_Mail do
  begin
    for Lc_I := 0 to (FDestino.Count - 1) do
    Begin
      Lc_Aux := Trim(FDestino.Strings[Lc_I]);
      if Lc_Aux <> '' then
        AddAddress(Lc_Aux, Lc_Aux);
    End;
    Subject := FAssunto;
    IsHTML  := True;
    Body.Append(gerarCorpo);

    if (FAnexo.Count > 0) and (FAnexo.Strings[0] <> 'Sem anexo') then
    Begin
      for Lc_I := 0 to (FAnexo.Count - 1) do
      Begin
        if FileExists(FAnexo.Strings[Lc_I]) then
          AddAttachment(FAnexo.Strings[Lc_I], 'AddAttachment');
      End;
    End;
  end;

  try
    Id_Mail.Send();
    Result := True;
  except
    on E: Exception do
    Begin
      FUltimoErro := E.Message;
      OutputDebugString(PChar(Self.ClassName + ' erro: ' + E.Message));
      Result := False;
    End;
  end;
end;

end.
