unit Un_AlteraBoleto;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, QEdit_Setes, Vcl.ExtCtrls, Data.DB, STQuery, ControllerFinanceiro, ControllerBoletoBancario;

type
  TFr_AlteraBoleto = class(TForm)
    Panel1: TPanel;
    E_Dt_Vencimento: TDateTimePicker;
    Pnl_Botao: TPanel;
    Sb_Sair_0: TSpeedButton;
    Sb_Gravar: TSpeedButton;
    Label1: TLabel;
    Qr_Acao: TSTQuery;
    Label2: TLabel;
    E_ValorBoleto: TEdit_Setes;
    procedure Sb_GravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Financeiro : TControllerFinanceiro;
    Boleto : TControllerBoletoBancario;
    function Fc_ValidaGravaBoleto():Boolean;
    procedure AtualizaFinanceiro;
    procedure AtualizaBoleto;
    procedure IniciaVariaveis;
  end;

var
  Fr_AlteraBoleto: TFr_AlteraBoleto;

implementation

{$R *.dfm}

uses     Un_Msg, Un_DM, env;
procedure TFr_AlteraBoleto.AtualizaBoleto;
Begin
  with Boleto do
  Begin
    with Registro do
    Begin
      //Codigo := FieldByName('FIN_CODIGO').asInteger;
      DataVencimento := E_Dt_Vencimento.DateTime;
      Valor := StrToFloatDef(E_ValorBoleto.Text,0);
    End;
    AlteraVencimentoValor;
  End;

end;

procedure TFr_AlteraBoleto.AtualizaFinanceiro;
Begin
  with Financeiro do
  Begin
    with Registro do
    Begin
      //Codigo := FieldByName('FIN_CODIGO').asInteger;
      DataVencimento := E_Dt_Vencimento.DateTime;
      ValorParcela := StrToFloatDef(E_ValorBoleto.text,0);
    End;
    AlteraVencimentoValor;
  End;
end;

function TFr_AlteraBoleto.Fc_ValidaGravaBoleto():Boolean;
Begin
  Result := True;
  if StrToFloatDef(E_ValorBoleto.Text,0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Valor do boleto não pode ser 0,00 (Zero).' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  End;

  if (E_Dt_Vencimento.Date <= Date) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O vencimento não pode ser menor ou igual a data de hoje.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  End;

end;



procedure TFr_AlteraBoleto.FormCreate(Sender: TObject);
begin
  Financeiro := TControllerFinanceiro.create(Self);
  Boleto := TControllerBoletoBancario.create(Self);
end;

procedure TFr_AlteraBoleto.FormShow(Sender: TObject);
begin
  IniciaVariaveis;
end;

procedure TFr_AlteraBoleto.IniciaVariaveis;
begin
  E_Dt_Vencimento.DateTime := Boleto.Registro.DataVencimento;
  E_ValorBoleto.Text := FloatToStrF( Boleto.Registro.Valor ,ffGeneral,10,2);
end;

procedure TFr_AlteraBoleto.Sb_GravarClick(Sender: TObject);
begin
  if Fc_ValidaGravaBoleto then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja alterar Boleto com estes dados informados.' + EOLN + EOLN +
                       'Confirmar a alteração ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      AtualizaFinanceiro;
      AtualizaBoleto;
    end;

  end;
end;

procedure TFr_AlteraBoleto.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.
