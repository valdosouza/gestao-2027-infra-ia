unit Un_RL_ReportChequeSimples;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, Un_RL_ReportCheque;

type
  TRL_ReportChequeSimples = class(TRL_ReportCheque)
    Detalhe: TQRBand;
    e_Nr_Banco: TQRLabel;
    E_Agencia: TQRLabel;
    E_Nr_Cheque: TQRLabel;
    E_Emitente: TQRLabel;
    E_Valor: TQRLabel;
    E_Data: TQRLabel;
    QRBand1: TQRBand;
    QRLabel11: TQRLabel;
    E_ValorTotal: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel4: TQRLabel;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure PreencherDetalhe;Override;
    procedure Rodape;Override;
    procedure DetalheBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    ValorTotal : Real;
  public
    { Public declarations }

  end;

var
  RL_ReportChequeSimples: TRL_ReportChequeSimples;

implementation

{$R *.dfm}

procedure TRL_ReportChequeSimples.SelectSql;
begin
  SelectTxt := 'SELECT '+
               '   CHQ_CODIGO, '+
               '   CHQ_EMITENTE, '+
               '   CHQ_NR_BANCO, '+
               '   CHQ_AGENCIA, '+
               '   CHQ_NUMERO, '+
               '   CHQ_VALOR, '+
               '   CHQ_DATA, '+
               '   CHQ_DEVOLVIDO, '+
               '   CHQ_DT_QUITACAO, '+
               '   CHQ_TIPO, '+
               '   CHQ_ESTADO, '+
               '   CHQ_RETORNO, '+
               '   CHQ_VL_AMORT, '+
               '   CHQ_QT_REC, '+
               '   CHQ_QT_PAG, '+
               '   CHQ_CODFOR, '+
               '   CHQ_CONTA '+
               'FROM TB_CHEQUES ';
end;




procedure TRL_ReportChequeSimples.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencherDetalhe;
end;

procedure TRL_ReportChequeSimples.IniciaVariaveis;
begin
  inherited;
  ValorTotal := 0;
end;



procedure TRL_ReportChequeSimples.PreencherDetalhe;
begin
  with Qr_Consulta do
  Begin
    E_Nr_Banco.Caption := FieldByName('CHQ_NR_BANCO').AsString;
    E_Agencia.Caption := FieldByName('CHQ_AGENCIA').AsString;
    E_Nr_Cheque.Caption := FieldByName('CHQ_NUMERO').AsString;
    E_Emitente.Caption := FieldByName('CHQ_EMITENTE').AsString;
    E_Valor.Caption := FloatToStrF( FieldByName('CHQ_VALOR').AsCurrency, ffNumber, 10,2);
    ValorTotal := ValorTotal + FieldByName('CHQ_VALOR').AsCurrency;
    E_Data.Caption := FieldByName('CHQ_DATA').AsString;
  End;
end;

procedure TRL_ReportChequeSimples.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Rodape;

end;

procedure TRL_ReportChequeSimples.Rodape;
begin
  E_ValorTotal.Caption := FloatToStrF(ValorTotal, ffNumber,10,2);
end;



end.
