unit UN_TrocaSenha;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.Mask;

type
  TFr_TrocaSenha = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    SB_Confirma: TSpeedButton;
    SB_Cancela: TSpeedButton;
    Qr_MudaSenha: TSTQuery;
    E_SenhaAtual: TMaskEdit;
    E_SenhaNova: TMaskEdit;
    Label3: TLabel;
    E_ConfirmeSenhaNova: TMaskEdit;
    procedure SB_CancelaClick(Sender: TObject);
    procedure SB_ConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function Fc_Valida_Troca_Senha: Boolean;
  end;

var
  Fr_TrocaSenha: TFr_TrocaSenha;

implementation

uses     UN_Principal, env, Un_Msg, Un_DM, UN_Sistema, Un_Regra_Negocio, Md5;
{$R *.dfm}


procedure TFr_TrocaSenha.SB_CancelaClick(Sender: TObject);
begin
  Close;
end;

function TFr_TrocaSenha.Fc_Valida_Troca_Senha: Boolean;
Begin
  Result := True;
  If Trim(E_SenhaAtual.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor informe a senha atual.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_SenhaAtual.Setfocus;
    exit;
    end;

  if (MD5String(E_SenhaAtual.Text) <> Gb_Senha) then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Senha Atual Incorreta.'+EOLN+
                   'Verifique!!'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    E_SenhaAtual.Setfocus;
    exit;
    end;

  If Trim(E_SenhaNova.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor informe uma nova senha.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_SenhaNova.Setfocus;
    exit;
    end;
        
  If Trim(E_ConfirmeSenhaNova.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor informe uma confirmação da senha.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    E_ConfirmeSenhaNova.Setfocus;
    exit;
    end;

  if E_SenhaNova.Text <> E_ConfirmeSenhaNova.Text then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'A Confirmação da senha não confere.'+EOLN+
                     'Verifique a digitação  e tente novamente!!'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
    Result := False;
    E_ConfirmeSenhaNova.Setfocus;
    exit;
    end;
end;

procedure TFr_TrocaSenha.SB_ConfirmaClick(Sender: TObject);
begin
  if not Fc_Valida_Troca_Senha then exit;
  Qr_MudaSenha.Close;
  Qr_MudaSenha.ParamByName('USU_SENHA').AsString:=MD5String(E_SenhaNova.Text);
  Qr_MudaSenha.ParamByName('USU_CODIGO').AsInteger:=Gb_Cd_Usuario;
  Qr_MudaSenha.Active:=True;
  IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
  Gb_Senha := E_SenhaNova.Text;
  MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                 'Senha Alterado com Sucesso.'+EOLN,
                 ['OK'],[bEscape],mpAlerta);
  Close;
end;

procedure TFr_TrocaSenha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  Fr_TrocaSenha:=nil;
end;

end.
