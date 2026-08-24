unit Un_Liberacao;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, ControllerUsuario, ControllerBase;

type
  TFr_Liberacao = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    CB_Usuario: TComboBox;
    E_Senha: TMaskEdit;
    SB_Confirma: TSpeedButton;
    SB_Cancela: TSpeedButton;
    pnl_login: TPanel;
    pnl_bottom: TPanel;
    Label3: TLabel;
    E_Card: TMaskEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_ConfirmaClick(Sender: TObject);
    procedure SB_CancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Pc_AutenticaUsuario;
    procedure Pc_AutenticaCartao;
  public
    { Public declarations }
    Liberado : Boolean;
    Usuario : TControllerUsuario;
    It_Interface,It_Nome_Menu,It_Privilegio:String;
    FLogOperacao,FLogDEscricao:String;

    procedure Pc_MontaUsuario;
    function Fc_Valida_Autenticacao: Boolean;

  end;

var
  Fr_Liberacao: TFr_Liberacao;

implementation

uses     Un_DM, UN_MSG, UN_Sistema, Un_Regra_Negocio, RN_Permissao, Md5, UN_Principal, env, Un_Fc_Sored_Procedures;
{$R *.dfm}

procedure TFr_Liberacao.Pc_MontaUsuario;
Var
  I : Integer;
begin
  usuario.getList;
  CB_Usuario.Items.Clear;
  CB_Usuario.Clear;
  for I := 0 to usuario.Lista.Count - 1 do
  BEgin
    CB_Usuario.Items.Add(usuario.Lista[I].Login);
  End;
end;

procedure TFr_Liberacao.Pc_AutenticaCartao;
begin
  usuario.Registro.CartaoAutorizacao := E_Card.Text;
  usuario.getByCard;
  if usuario.exist then
  Begin
    Gb_Liberado := True;
    Liberado:= True;
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Operação Liberada.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
    self.close;
  End
  else
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Número de Cartão Inválido.'+EOLN+
                   'Operação Negada.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Card.Clear;
    E_Card.SetFocus;
  end;
end;

procedure TFr_Liberacao.Pc_AutenticaUsuario;
var
  Lc_Autentica: String;
  Lc_Qry:TSTQuery;
  Lc_AutoClose : Boolean;
begin
  Try
    Lc_AutoClose := False;
    usuario.Registro.Login := CB_Usuario.Text;
    usuario.Registro.Senha := E_Senha.Text;
    usuario.Autentica;
    if usuario.exist then
    Begin
      if (usuario.Registro.nivel = '1') or
        (Fc_VerificaPermissao(It_Interface,It_Nome_Menu,It_Privilegio, usuario.Registro.Codigo,'S')) then
      Begin
        Gb_Liberado := True;
        MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                       'Operação Liberada.'+EOLN,
                        ['OK'],[bEscape],mpInformacao);
        Liberado:= True;
        Lc_AutoClose := True;
      end
      else
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Liberação Negada.'+EOLN,
                      ['OK'],[bEscape],mpErro);
        E_Senha.Clear;
        E_Senha.SetFocus;
      end;
    end
    else
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Senha ou Login Incorretos. Verifique'+EOLN,
                    ['OK'],[bEscape],mpErro);
      E_Senha.Clear;
      E_Senha.SetFocus;
    End;
  Finally
    if Lc_AutoClose then
      self.close;
  End;
end;

procedure TFr_Liberacao.FormCreate(Sender: TObject);
begin
  Usuario := TControllerUsuario.create(Self);
end;

procedure TFr_Liberacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_ESCAPE : SB_CancelaClick(Sender);
      VK_RETURN : SB_ConfirmaClick(Sender);
    end;
  end;
end;

procedure TFr_Liberacao.FormShow(Sender: TObject);
begin
  Pc_MontaUsuario
end;

function TFr_Liberacao.Fc_Valida_Autenticacao: Boolean;
Begin
  Result := True;
  If Trim(E_Card.Text) = '' then
  Begin
    If Trim(CB_Usuario.Text) = '' then
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Por Favor informe um usuário.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      CB_Usuario.Setfocus;
      exit;
    end;

    If Trim(E_Senha.Text) = '' then
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Por favor informe uma senha.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      self.BringToFront;
      E_Senha.Setfocus;
      exit;
    end;
  End;

end;

procedure TFr_Liberacao.SB_ConfirmaClick(Sender: TObject);
begin
  if Fc_Valida_Autenticacao then
  Begin
    If Length(Trim(E_Card.Text))>0 then
    Begin
      Pc_AutenticaCartao;
      if Usuario.exist then
      Begin
        Pc_Log_Sistema(Gb_CodMha,
                        Usuario.Registro.Codigo,
                        now,
                        'Liberação',
                        Usuario.Registro.Codigo,
                        FLogOperacao,
                        concat('Via Cartão - ', FLogDEscricao));
      End;
    End
    else
    Begin
      Pc_AutenticaUsuario;
      if Usuario.exist then
      Begin
        Pc_Log_Sistema(Gb_CodMha,
                        Usuario.Registro.Codigo,
                        now,
                        'Liberação',
                        Usuario.Registro.Codigo,
                        FLogOperacao,
                        concat('Via Senha - ', FLogDEscricao));
      End;
    End;
  end;
end;

procedure TFr_Liberacao.SB_CancelaClick(Sender: TObject);
begin
  Liberado := False;
  Close;
end;

end.
