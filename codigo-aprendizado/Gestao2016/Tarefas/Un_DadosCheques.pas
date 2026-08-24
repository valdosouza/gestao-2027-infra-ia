unit Un_DadosCheques;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFr_DadosCheques = class(TForm)
    Panel5: TPanel;
    E_BandeiraCartao: TLabel;
    Panel6: TPanel;
    SB_Confirmar: TSpeedButton;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    E_Banco: TEdit_Setes;
    E_Agencia: TEdit_Setes;
    E_NumChq: TEdit_Setes;
    E_VL_Cheque: TEdit_Setes;
    E_ContaCorrente: TEdit_Setes;
    E_Data: TMaskEdit;
    Rg_TipoCheque: TRadioGroup;
    E_Emitente: TEdit;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    procedure GravaDadosTemporarios;
    procedure LeituraDadosTemporarios;
    function ValidaGravacao:Boolean;
    procedure Gravar;
  public
    { Public declarations }
    It_Confirma : Boolean;
    CodigoQuitacao : Integer;
    CodigoPedido : Integer;
  end;

var
  Fr_DadosCheques: TFr_DadosCheques;

implementation

{$R *.dfm}

uses     Un_Msg, UN_Sistema, ControllerCheque, Un_Funcoes, UN_Principal, env;

function TFr_DadosCheques.ValidaGravacao:Boolean;
Begin
  Result := True;
  if trim(E_Emitente.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo emitente.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Emitente.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Banco.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo número do Banco.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Banco.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Agencia.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo agência.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Agencia.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_NumChq.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo número do cheque.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_NumChq.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_VL_Cheque.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo valor do cheque.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_VL_Cheque.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_ContaCorrente.Text) <> '' then
  begin
    if not Fc_VerificaDuplicacaoCheque(0,E_Banco.Text,E_Agencia.Text,E_ContaCorrente.Text,E_NumChq.Text) then
    Begin
      Result := False;
      exit;
    end;
  end;
end;




procedure TFr_DadosCheques.FormCloseQuery(Sender: TObject;
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

procedure TFr_DadosCheques.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F10  : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
    end;
  end;
end;

procedure TFr_DadosCheques.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_DadosCheques.FormShow(Sender: TObject);
begin
  LeituraDadosTemporarios;
  E_Emitente.SelectAll;
end;

procedure TFr_DadosCheques.Gravar;
Var
  Lc_Cheque : TControllerCheque;
Begin
  Try
    Lc_Cheque := TControllerCheque.Create(nil);
    with Lc_Cheque.Registro do
    Begin
      Codigo := 0;
      Emitente := E_Emitente.Text;
      NumeroBanco := StrToIntDef(E_Banco.Text,1);
      Agencia := E_Agencia.Text;
      Numero := E_NumChq.Text;
      Valor := StrtoFloatDef(E_VL_Cheque.Text,0);
      Data := StrToDateDef(E_Data.Text,Date);
      Devolvido := 'N';
      if Rg_TipoCheque.ItemIndex = 0 then
        Tipo := 'P'
      else
        Tipo := 'T';
      Estado := 'N';
      ValorAmortizado := 0;
      QuitacaoRecebimento := Self.CodigoQuitacao;
      QuitacaoPagamento := 0;
      CodigoFornecedor := 0;
      ContaCorrente := E_ContaCorrente.Text;
      CodigoEstabelecimento := Gb_CodMha;
    End;
    Lc_Cheque.salva;
  Finally
    FreeAndNil( Lc_Cheque );
  End;

end;

procedure TFr_DadosCheques.GravaDadosTemporarios;
Begin
  Fc_Aq_Geral('G','DADOSCHEQUES','EMITENTE',E_Emitente.Text);
  Fc_Aq_Geral('G','DADOSCHEQUES','BANCO',E_Banco.Text);
  Fc_Aq_Geral('G','DADOSCHEQUES','AGENICA',E_Agencia.Text);
  Fc_Aq_Geral('G','DADOSCHEQUES','CONTA',E_ContaCorrente.Text);
  Fc_Aq_Geral('G','DADOSCHEQUES','NUMERO',E_NumChq.Text);
  Fc_Aq_Geral('G','DADOSCHEQUES','PEDIDO',IntToStr(CodigoPedido));
End;

procedure TFr_DadosCheques.LeituraDadosTemporarios;
Var
  Lc_CodigoPedido : Integer;
  Lc_Numero : Integer;
Begin
  Lc_CodigoPedido := StrToIntDef(Fc_Aq_Geral('L','DADOSCHEQUES','PEDIDO','0'),0);
  if (Lc_CodigoPedido > 0 ) and (Lc_CodigoPedido = CodigoPedido) then
  Begin
    E_Emitente.Text       := Fc_Aq_Geral('L','DADOSCHEQUES','EMITENTE','');
    E_Banco.Text          := Fc_Aq_Geral('L','DADOSCHEQUES','BANCO','');
    E_Agencia.Text        := Fc_Aq_Geral('L','DADOSCHEQUES','AGENICA','');
    E_ContaCorrente.Text  := Fc_Aq_Geral('L','DADOSCHEQUES','CONTA','');
    //Acrescenta 1 no numero do cheque
    Lc_Numero := StrToIntDef(Fc_Aq_Geral('L','DADOSCHEQUES','NUMERO','0'),0);
    Lc_Numero := Lc_Numero + 1;
    E_NumChq.Text         := StrZero(Lc_Numero, 6, 0);
  End;
End;

procedure TFr_DadosCheques.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    Gravar;
    It_Confirma := True;
    GravaDadosTemporarios;
    Close;
  end;
end;

end.
