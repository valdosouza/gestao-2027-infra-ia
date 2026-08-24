unit Un_Rl_CtasGerenciaisRealizado;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, ExtCtrls, QuickRpt, QRCtrls, STQuery, StdCtrls, Grids;

type
  TRl_CtasGerenciaisRealizado = class(TForm)
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    Bnd_Detalhe: TQRStringsBand;
    E_Descricao: TQRLabel;
    E_Vl_Credito: TQRLabel;
    E_VL_Debito: TQRLabel;
    E_Cd_Plano: TQRLabel;
    QRLabel5: TQRLabel;
    E_VL_Saldo: TQRLabel;
    QRBand1: TQRBand;
    QRLabel14: TQRLabel;
    Lb_ContaInicial: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Label2: TQRLabel;
    Lb_ContaFinal: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    Label1: TQRLabel;
    Lc_Grade: TStringGrid;
    SaldoAnterior: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bnd_DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_I : Integer;
    it_Linha : Integer;
    It_DataIni,It_DataFim:TDate;
    procedure Pc_Preparar;
    procedure Pc_Parametros;
  end;

var
  Rl_CtasGerenciaisRealizado: TRl_CtasGerenciaisRealizado;

implementation

uses     Un_DM, UN_Imp_CtasGerenciais, UN_Sistema, RN_PlanoContas, Un_Funcoes;

{$R *.dfm}

procedure TRl_CtasGerenciaisRealizado.Pc_Preparar;
Var
  LC_I : Integer;
Begin
  Bnd_Detalhe.Items.Clear;
  For LC_I := 1 to Lc_Grade.RowCount do
    Bnd_Detalhe.Items.Add('');
  it_Linha := 0;
end;


procedure TRl_CtasGerenciaisRealizado.Pc_Parametros;
Begin
  with Fr_Imp_CtasGerenciais do
    Begin
    Lb_Tipo_Rl.Caption      := CB_Tipo.Text;
    Lb_Data_Ini.Caption     :=  DateToStr(E_Data_Ini.Date);
    Lb_Data_Fim.Caption     :=  DateToStr(E_Data_Fim.Date);
    Lb_ContaInicial.Caption := Fm_CentroResultadoInicial.DBLCB_Plano.Text;
    Lb_ContaFinal.Caption   := Fm_CentroResultadoFinal.DBLCB_Plano.Text;
    end;
end;

procedure TRl_CtasGerenciaisRealizado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
end;

procedure TRl_CtasGerenciaisRealizado.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Preparar;
  Pc_Parametros;
end;

procedure TRl_CtasGerenciaisRealizado.Bnd_DetalheBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
Var
  Lc_Vl_Credito : Real;
  Lc_Vl_Debito : Real;
  Lc_Aux : String;
  Lc_valor : Real;
  Lc_Vl_Anterior : Real;
begin
  inc(it_Linha);
  E_Cd_Plano.Caption := '  ' + Lc_Grade.Cells[1,it_Linha];
  E_Vl_Debito.Caption  := '0,00';
  E_Vl_Credito.Caption  := '0,00';
  //SINTETICO
  if Lc_Grade.Cells[0,it_Linha] = 'S' then
  Begin
    E_Cd_Plano.Color := clGray;
    E_Descricao.Caption := Lc_Grade.Cells[2,it_Linha];
  end
  else
  //ANALITICO
  Begin
    if Lc_Grade.Cells[0,it_Linha] = 'A' then
    Begin
      E_Cd_Plano.Color := clSilver;
      E_Descricao.Caption := '      ' + Lc_Grade.Cells[2,it_Linha];
    end
    else
    Begin
      E_Cd_Plano.Color := clWhite;
      E_Descricao.Caption := '            ' + Lc_Grade.Cells[2,it_Linha];
    end;
  end;

  if Lc_Grade.Cells[6,it_Linha] = 'R' then
  Begin
    Lc_Aux := Fc_RemoveCaracterInformado(Lc_Grade.Cells[8,It_Linha], ['.']);
    Lc_valor := StrToFloatDEf(Lc_Aux,0);
    SaldoAnterior.Caption := FloatToStrF(lc_valor,ffNumber,10,2);
    Lc_Vl_Anterior := lc_valor;
  End
  else
  Begin
    Lc_Vl_Anterior := 0;
    SaldoAnterior.Caption := '';
  End;



  Lc_Aux := Fc_RemoveCaracterInformado(Lc_Grade.Cells[3,It_Linha], ['.']);
  Lc_valor := StrToFloatDEf(Lc_Aux,0);
  if ( Lc_valor > 0 ) then
  begin
    E_Vl_Credito.Caption  := FloatToStrF(lc_valor,ffNumber,10,2);
  end;

  Lc_Aux := Fc_RemoveCaracterInformado(Lc_Grade.Cells[4,It_Linha], ['.']);
  Lc_valor := StrToFloatDEf(Lc_Aux,0);
  if ( Lc_valor > 0 ) then
  begin
    E_Vl_Debito.Caption  := FloatToStrF(lc_valor,ffNumber,10,2);
  end;

  Lc_Aux := Fc_RemoveCaracterInformado(Lc_Grade.Cells[5,It_Linha], ['.']);
  Lc_valor := StrToFloatDEf(Lc_Aux,0);
  E_VL_Saldo.Caption    := FloatToStrF(lc_valor + Lc_Vl_Anterior,ffNumber,10,2);
end;
end.
