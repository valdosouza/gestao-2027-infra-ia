unit Un_DadosCartaoEletronica;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TFr_DadosCartaoEletronico = class(TForm)
    Panel5: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    Label39: TLabel;
    E_BandeiraCartao: TLabel;
    E_Identifica: TEdit;
    E_Autoriza: TEdit;
    Panel6: TPanel;
    SB_Confirmar: TSpeedButton;
    E_Validade: TMaskEdit;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function ValidaGravacao:Boolean;
    procedure Gravar;
  public
    { Public declarations }
    It_Confirma : Boolean;
    CodigoCartao : Integer;
    NumeroParcelas : Integer;
    CodigoQuitacao : Integer;
  end;

var
  Fr_DadosCartaoEletronico: TFr_DadosCartaoEletronico;

implementation

{$R *.dfm}

uses     Un_Msg, ControllerCartao, UN_Sistema, UN_Principal, env;

function TFr_DadosCartaoEletronico.ValidaGravacao:Boolean;
Begin
  Result := True;
  if Trim(E_Identifica.Text) = ''  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe a Identificação do cartão.'+EOLN+
                   'Este campo deve ser preenchido.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if E_Identifica.CanFocus then E_Identifica.SetFocus;
    exit;
  end;

  if Trim(E_Autoriza.Text) = ''  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe o código de autorização do cartão.'+EOLN+
                   'Este campo deve ser preenchido.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if E_Autoriza.CanFocus then E_Autoriza.SetFocus;
    exit;
  end;

  if Trim(E_Validade.Text) = ''  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe o código de autorização do cartão.'+EOLN+
                   'Este campo deve ser preenchido.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if E_Autoriza.CanFocus then E_Autoriza.SetFocus;
    exit;
  end;
end;

procedure TFr_DadosCartaoEletronico.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not It_Confirma then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor utilize o botão confirmar para continuar.',
                  ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_DadosCartaoEletronico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F10  : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
    end;
  end;
end;

procedure TFr_DadosCartaoEletronico.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_DadosCartaoEletronico.Gravar;
Var
  Lc_Cartao : TControllerCartao;
Begin
  Try
    Lc_Cartao := TControllerCartao.Create(nil);
    with Lc_Cartao.Registro do
    Begin
      Estabelecimento := Gb_CodMha;
      Identificacao := E_Identifica.Text;
      Autorizacao := E_Autoriza.Text;
      Validade := StrtoDateDef(E_Validade.Text,Date);
      CodigoCartao := Self.CodigoCartao;
      NumeroParcela := Self.NumeroParcelas;
      CodigoQuitacaoRec := Self.CodigoQuitacao;
      CodigoQuitacaoPag := 0;
    End;
   Lc_Cartao.Insere;
  Finally
    FreeAndNil(Lc_Cartao);
  End;
end;

procedure TFr_DadosCartaoEletronico.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    Gravar;
    It_Confirma := True;
    Close;
  end;
end;

end.
