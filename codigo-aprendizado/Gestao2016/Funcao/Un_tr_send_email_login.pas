unit Un_tr_send_email_login;

interface

uses
      Classes, SysUtils, Un_tr_send_email;

type
  // Envio de email de notificacao de login (sucesso ou tentativa).
  // Usa o SMTP do proprio usuario configurado em FCtrlUsuario.
  TTRSendEmailLogin = class(TTRSendEmail)
  private
    FUsuario     : String;
    FAutenticado : Boolean;
  protected
    function preparar: Boolean; override;
    function gerarCorpo: String; override;
  public
    constructor Create;
    destructor Destroy; override;

    property Usuario     : String  read FUsuario     write FUsuario;
    property Autenticado : Boolean read FAutenticado write FAutenticado;
  end;

implementation

uses
      Un_Funcoes;

{ TTRSendEmailLogin }

constructor TTRSendEmailLogin.Create;
begin
  inherited Create;
end;

destructor TTRSendEmailLogin.Destroy;
begin
  inherited;
end;

function TTRSendEmailLogin.preparar: Boolean;
var
  LcOk : Boolean;
begin
  LcOk := False;

  // getByLogin acessa o banco -> precisa rodar na thread principal.
  Synchronize(
    procedure
    begin
      with FCtrlUsuario do
      Begin
        Registro.Login := FUsuario;
        getByLogin;
      End;
      LcOk := FCtrlUsuario.exist
        and (FCtrlUsuario.Registro.emailSMTP   <> '')
        and (FCtrlUsuario.Registro.email       <> '')
        and (FCtrlUsuario.Registro.emailPorta  <> '')
        and (FCtrlUsuario.Registro.emailLogin  <> '')
        and (FCtrlUsuario.Registro.emailSenha  <> '')
        and (FCtrlUsuario.Registro.NotificarPorEmail = 'S');
    end
  );

  if not LcOk then
  Begin
    Result := False;
    Exit;
  End;

  if FAutenticado then
    FAssunto := 'Login Efetuado no Sistema Setes'
  else
    FAssunto := 'Tentativa de Login Sistema Setes';

  FDestino.Clear;
  FDestino.Add(Trim(FCtrlUsuario.Registro.emailLogin));
  FAnexo.Clear;
  FAnexo.Add('Sem anexo');

  Result := configurarRemetente;
end;


function TTRSendEmailLogin.gerarCorpo: String;
begin
  Result := concat(
                 '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> ',
                 '<html> ',
                 '<head> ',
                 '  <meta content="text/html; charset=ISO-8859-1" ',
                 ' http-equiv="content-type"> ',
                 '  <title>Tentativa de Login</title> ',
                 '</head> ',
                 '<body> ',
                 '<table style="text-align: left; width: 605px; height: 116px;"  ',
                 ' border="1" cellpadding="0" cellspacing="0"> ',
                 '  <tbody> ',
                 '    <tr> ',
                 '      <td style="width: 159px;">Data&nbsp;</td> ',
                 '      <td style="width: 10px;">:</td> ',
                 '      <td style="width: 790px;">' , DateTimeToStr(Now) ,'</td> ',
                 '    </tr> ',
                 '    <tr> ',
                 '      <td style="width: 159px;">Nome do Usuario</td> ',
                 '      <td style="width: 10px;">:</td>  ',
                 '      <td style="width: 790px;">', FUsuario + '</td> ',
                 '    </tr>  ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Nome do Computador</td> ',
                 '      <td style="width: 10px;">:</td> ',
                 '      <td style="width: 790px;">' , Fc_NomeComputador ,'</td> ',
                 '    </tr> ',

                 '  </tbody> ',
                 '</table> ',
                 '</body> ',
                 '</html> '
  );
end;

end.
