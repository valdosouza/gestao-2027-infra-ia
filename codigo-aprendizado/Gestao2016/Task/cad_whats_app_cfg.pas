unit cad_whats_app_cfg;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, ControllerWhatsAppCFG;

type
  TCadWhatsAppCfg = class(TBaseRegistry)
    Label38: TLabel;
    Label4: TLabel;
    Label39: TLabel;
    Label56: TLabel;
    Chbx_Whats_Ativar: TCheckBox;
    E_Whats_url_token_auth: TEdit;
    E_Whats_url_token: TEdit;
    E_Whats_url_send: TEdit;
    E_Whats_Description: TEdit;
  private
    FWhatsAppCFG : TControllerWhatsAppCFG;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

  public
    { Public declarations }
  end;

var
  CadWhatsAppCfg: TCadWhatsAppCfg;

implementation

{$R *.dfm}

uses     UN_Sistema, Un_Msg, UN_Principal, env;

{ TTasWhatsAppCfg }

procedure TCadWhatsAppCfg.Cancel;
begin
  inherited;
end;

procedure TCadWhatsAppCfg.Change;
begin
  inherited;

end;

procedure TCadWhatsAppCfg.ClearAllFields;
begin
  inherited;
  Chbx_Whats_Ativar.Checked := ( Fc_Tb_Geral('L','WTA_LC_ATIVO','N') = 'S');
end;

procedure TCadWhatsAppCfg.CriarVariaveis;
begin
  inherited;
  FWhatsAppCFG := TControllerWhatsAppCFG.create(Self);
end;

procedure TCadWhatsAppCfg.Delete;
begin
  FWhatsAppCFG.delete;
end;


procedure TCadWhatsAppCfg.IniciaVariaveis;
begin
  if (CodigoRegistro > 0 ) then
  Begin
    FWhatsAppCFG.Registro.Codigo := Self.CodigoRegistro;
    FWhatsAppCFG.Registro.Estabelecimento := Gb_codmha;
    FWhatsAppCFG.getById;
  End;
  inherited;
end;

procedure TCadWhatsAppCfg.Insert;
begin
  inherited;
  ClearAllFields;
  if (CodigoRegistro = 0) then
    E_Whats_Description.SetFocus
  else
    E_Whats_Description.SetFocus
end;

procedure TCadWhatsAppCfg.Save;
begin
  with FWhatsAppCFG do
  Begin
    Registro.Estabelecimento := Gb_CodMha;
    Registro.Descricao  := E_Whats_Description.Text;
    Registro.urlSend    := E_Whats_url_send.Text;
    Registro.Token      := E_Whats_url_token.Text;
    Registro.TokenAuth  := E_Whats_url_token_auth.Text;
  End;
  FWhatsAppCFG.salva;
  if Chbx_Whats_Ativar.Checked then Fc_Tb_Geral('G','WTA_LC_ATIVO','S') else Fc_Tb_Geral('G','WTA_LC_ATIVO','N');
end;

procedure TCadWhatsAppCfg.ShowData;
begin
  with FWhatsAppCFG do
  Begin
    E_Whats_Description.Text    := Registro.Descricao;
    E_Whats_url_send.Text    := Registro.urlSend;
    E_Whats_url_token.Text       := Registro.Token;
    E_Whats_url_token_auth.Text  := Registro.TokenAuth
  End;
  Chbx_Whats_Ativar.Checked := ( Fc_Tb_Geral('L','WTA_LC_ATIVO','N') = 'S');
end;

procedure TCadWhatsAppCfg.ShowNoData;
begin
  ClearAllFields;
end;

function TCadWhatsAppCfg.ValidaInsert: boolean;
begin
  Result := True;
end;

function TCadWhatsAppCfg.ValidateCancel: boolean;
begin
  REsult := True;
end;

function TCadWhatsAppCfg.ValidateChange: boolean;
begin
  Result := True;
end;

function TCadWhatsAppCfg.ValidateDelete: boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TCadWhatsAppCfg.ValidateSave: boolean;
begin
  REsult := True;
  if Trim( E_Whats_Description.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo Descrição é obrigadorio.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Whats_Description.SetFocus;
    Exit;
  end;

  if Trim( E_Whats_url_send.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo URL de Envio é obrigadorio.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Whats_url_send.SetFocus;
    Exit;
  end;

  if Trim( E_Whats_url_token.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo token é obrigadorio.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Whats_url_token.SetFocus;
    Exit;
  end;

  if Trim( E_Whats_url_token_auth.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Campo token de autoeticação é obrigadorio.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Whats_url_token_auth.SetFocus;
    Exit;
  end;

end;

end.
