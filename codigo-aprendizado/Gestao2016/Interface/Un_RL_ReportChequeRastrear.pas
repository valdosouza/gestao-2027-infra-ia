unit Un_RL_ReportChequeRastrear;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportCheque, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportChequeRastrear = class(TRL_ReportCheque)
    Grupo1: TQRGroup;
    QRLabel13: TQRLabel;
    Bnd_Financeiro: TQRLoopBand;
    Lb_Pedido: TQRLabel;
    Lb_Nota: TQRLabel;
    Lb_Parcela: TQRLabel;
    Lb_Valor: TQRLabel;
    Lb_Dt_Pagto: TQRLabel;
    Bnd_Cheque: TQRLoopBand;
    Lb_Data: TQRLabel;
    Lb_Emitente: TQRLabel;
    Lb_Banco: TQRLabel;
    Lb_Agencia: TQRLabel;
    Lb_Cheque: TQRLabel;
    Lb_Chq_Valor: TQRLabel;
    Qr_Financeiro: TSTQuery;
    Qr_Cheque: TSTQuery;
    E_Nome_Cliente: TQRLabel;
    procedure Bnd_FinanceiroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Bnd_ChequeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Grupo1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Bnd_FinanceiroAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure Bnd_ChequeAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
  private
    { Private declarations }
    It_Nr_Financeiro : Integer;
    It_Nr_Cheque : Integer;
    procedure PreparaItensGrupo;
    procedure PreencheFinanceiro;
    procedure PreencheCheque;

  public
    { Public declarations }
  end;

var
  RL_ReportChequeRastrear: TRL_ReportChequeRastrear;

implementation

{$R *.dfm}

{ TRL_ReportChequeOrigem }





procedure TRL_ReportChequeRastrear.Bnd_ChequeAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Bnd_Cheque.PrintCount := 0
end;

procedure TRL_ReportChequeRastrear.Bnd_ChequeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if not Qr_Cheque.Eof then
  Begin
    PreencheCheque;
    if It_Nr_Cheque > 0 then Qr_Cheque.Next;
    inc(It_Nr_Cheque);
  end
  else
    Bnd_Cheque.PrintCount := 0;
end;

procedure TRL_ReportChequeRastrear.Bnd_FinanceiroAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Bnd_Financeiro.PrintCount := 0
end;

procedure TRL_ReportChequeRastrear.Bnd_FinanceiroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if not Qr_Financeiro.Eof then
  Begin
    PreencheFinanceiro;
    if It_Nr_Financeiro > 0 then Qr_Financeiro.Next;
    inc(It_Nr_Financeiro);
  end;
end;



procedure TRL_ReportChequeRastrear.Grupo1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreparaItensGrupo;
  E_Nome_Cliente.Caption := Qr_Financeiro.FieldByName('EMP_NOME').AsString;
end;

procedure TRL_ReportChequeRastrear.PreencheCheque;
begin
  if It_Nr_Cheque = 0 then
  Begin
    Lb_Data.Font.Style := [fsBold];
    Lb_Data.Caption := 'Data';
    Lb_Emitente.Font.Style := [fsBold];
    Lb_Emitente.Caption := 'Emitente';
    Lb_Banco.Font.Style := [fsBold];
    Lb_Banco.Caption := 'Banco';
    Lb_Agencia.Font.Style := [fsBold];
    Lb_Agencia.Caption := 'Agência';
    Lb_Cheque.Font.Style := [fsBold];
    Lb_Cheque.Caption := 'Nº Cheque';
    Lb_Chq_Valor.Alignment := taCenter;
    Lb_Chq_Valor.Font.Style := [fsBold];
    Lb_Chq_Valor.Caption := 'Valor';
  end
  else
  Begin
    //Bnd_Cheque.Items.Add(Qr_ChequeCHQ_NUMERO.AsString);
    Lb_Data.Font.Style := [];
    Lb_Data.Caption := Qr_Cheque.FieldByName('CHQ_DATA').AsString;
    Lb_Emitente.Font.Style := [];
    Lb_Emitente.Caption := Qr_Cheque.FieldByName('CHQ_EMITENTE').AsString;
    Lb_Banco.Font.Style := [];
    Lb_Banco.Caption := Qr_Cheque.FieldByName('CHQ_NR_BANCO').AsString;
    Lb_Agencia.Font.Style := [];
    Lb_Agencia.Caption := Qr_Cheque.FieldByName('CHQ_AGENCIA').AsString;
    Lb_Cheque.Font.Style := [];
    Lb_Cheque.Caption := Qr_Cheque.FieldByName('CHQ_NUMERO').AsString;
    Lb_Chq_Valor.Alignment := taRightJustify;
    Lb_Chq_Valor.Font.Style := [];
    Lb_Chq_Valor.Caption := FloatToStrF(Qr_Cheque.FieldByName('CHQ_VALOR').AsCurrency,ffFixed,10,2)
  end;
end;

procedure TRL_ReportChequeRastrear.PreencheFinanceiro;
begin
  if It_Nr_Financeiro = 0 then
  Begin
    Lb_Pedido.Font.Style := [fsBold];
    Lb_Pedido.Caption := 'Nº Pedido';
    Lb_Nota.Font.Style := [fsBold];
    Lb_Nota.Caption := 'Nota Fiscal';
    Lb_Parcela.Font.Style := [fsBold];
    Lb_Parcela.Caption := 'Nº Parcela';
    Lb_Dt_Pagto.Font.Style := [fsBold];
    Lb_Dt_Pagto.Caption := 'Data Pagto';
    Lb_Valor.Alignment := taCenter;
    Lb_Valor.Font.Style := [fsBold];
    Lb_Valor.Caption := 'Valor';
  end
  else
  Begin
    Lb_Pedido.Font.Style := [];
    Lb_Pedido.Caption := Qr_Financeiro.FieldByName('PED_NUMERO').AsString;
    Lb_Nota.Font.Style := [];
    Lb_Nota.Caption := Qr_Financeiro.FieldByName('NFL_NUMERO').AsString;
    Lb_Parcela.Font.Style := [];
    Lb_Parcela.Caption := Qr_Financeiro.FieldByName('FIN_NR_PARCELA').AsString;
    Lb_Dt_Pagto.Font.Style := [];
    Lb_Dt_Pagto.Caption := Qr_Financeiro.FieldByName('FIN_DT_PAGTO').AsString;
    Lb_Valor.Alignment := taRightJustify;
    Lb_Valor.Font.Style := [];
    Lb_Valor.Caption := FloatToStrF(Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2)
  end;
end;

procedure TRL_ReportChequeRastrear.PreparaItensGrupo;
Var
  LC_I : Integer;
begin
  // Cheques relacionados
  with Qr_Financeiro do
  Begin
    Active := False;
    ParamByName('CODQUITACAO').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
    Active := True;
    First;
    Bnd_Financeiro.PrintCount :=0;
    LC_I := 0;
    while not Eof do
    Begin
     inc(LC_I);
      Next;
    end;
    Bnd_Financeiro.PrintCount :=   LC_I +1 ;
    First;
    It_Nr_Financeiro := 0;
  End;

  // Cheques relacionados
  with Qr_Cheque do
  Begin
    Active := False;
    ParamByName('CODQUITACAO').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
    Active := True;
    First;
    Bnd_Cheque.PrintCount :=0;
    LC_I := 0;
    while not Eof do
    Begin
      inc(LC_I);
      Next;
    end;
    Bnd_Cheque.PrintCount :=   LC_I + 1;
    First;
    It_Nr_Cheque := 0;
  End;

end;


end.
