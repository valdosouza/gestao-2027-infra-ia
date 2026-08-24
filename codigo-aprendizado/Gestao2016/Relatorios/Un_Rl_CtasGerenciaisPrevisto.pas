unit Un_Rl_CtasGerenciaisPrevisto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, ExtCtrls, QuickRpt, QRCtrls, STQuery, StdCtrls, Grids;

type
  TRl_CtasGerenciaisPrevisto = class(TForm)
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
    Bnd_Detalhe: TQRStringsBand;
    E_Descricao: TQRLabel;
    E_Cd_Plano: TQRLabel;
    QRLabel5: TQRLabel;
    E_VL_Saldo: TQRLabel;
    QRBand1: TQRBand;
    E_VL_TL_Saldo: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    Label1: TQRLabel;
    Lb_ContaInicial: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Label2: TQRLabel;
    Lb_ContaFinal: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    Lc_Grade: TStringGrid;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bnd_DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_Vl_Conta: Currency;
  public
    { Public declarations }
    It_I : Integer;
    it_Linha : Integer;
    It_DataIni,It_DataFim:TDate;
    procedure Pc_Preparar;
    procedure Pc_Parametros;
  end;

var
  Rl_CtasGerenciaisPrevisto: TRl_CtasGerenciaisPrevisto;

implementation

uses     Un_DM, UN_Imp_CtasGerenciais, UN_Sistema, RN_PlanoContas, Un_Funcoes;

{$R *.dfm}

procedure TRl_CtasGerenciaisPrevisto.Pc_Parametros;
Begin
  with Fr_Imp_CtasGerenciais do
    Begin
    Lb_Tipo_Rl.Caption      := CB_Tipo.Text;
    Lb_Data_Ini.Caption     :=  DateToStr(E_Data_Ini.Date);
    Lb_Data_Fim.Caption     :=  DateToStr(E_Data_Fim.Date);
    Lb_ContaInicial.Caption := Fm_CentroCustoInicial.DBLCB_Plano.Text;
    Lb_ContaFinal.Caption   := Fm_CentroCustoFinal.DBLCB_Plano.Text;
    end;
end;

procedure TRl_CtasGerenciaisPrevisto.Pc_Preparar;
Var
  LC_I : Integer;
Begin
  Bnd_Detalhe.Items.Clear;
  For LC_I := 1 to Lc_Grade.RowCount do
    Bnd_Detalhe.Items.Add('');
  it_Linha := 0;
end;

procedure TRl_CtasGerenciaisPrevisto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
end;

procedure TRl_CtasGerenciaisPrevisto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  It_Vl_Conta := 0;
  Pc_Preparar;
  Pc_Parametros;
end;

procedure TRl_CtasGerenciaisPrevisto.Bnd_DetalheBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
Var
  Lc_Vl_Conta : Real;
  Lc_Valor : Real;
  Lc_Aux : String;
begin
  inc(it_Linha);

  Lc_Aux := Fc_RemoveCaracterInformado(Lc_Grade.Cells[3,it_Linha], ['.']);
  Lc_Vl_Conta := StrToFloatDef(Lc_Aux,0);

  E_Cd_Plano.Caption  := '  ' + Lc_Grade.Cells[1,it_Linha];

  Lc_Aux := Fc_RemoveCaracterInformado(Lc_Grade.Cells[3,it_Linha], ['.']);
  Lc_Valor := StrtoFloatDef(Lc_Aux,0);
  E_VL_Saldo.Caption  := FloatToStrF(Lc_Valor,ffNumber,10,2);

  if Lc_Grade.Cells[0,it_Linha] = 'S' then
  Begin
    E_Cd_Plano.Color := clScrollBar;
    E_Descricao.Caption := Lc_Grade.Cells[2,it_Linha];
    IF (Lc_Grade.Cells[4,it_Linha] = 'D') then
      It_Vl_Conta := It_Vl_Conta + Lc_Vl_Conta
    else
      It_Vl_Conta := It_Vl_Conta - Lc_Vl_Conta;
  end
  else
  Begin
    if Lc_Grade.Cells[0,it_Linha] = 'A' then
    Begin
      E_Cd_Plano.Color := clMenu;
      E_Descricao.Caption := '      ' + Lc_Grade.Cells[2,it_Linha];
    end
    else
    Begin
      E_Cd_Plano.Color := clWhite;
      E_Descricao.Caption := '            ' + Lc_Grade.Cells[2,it_Linha];
    end;
  end;
end;

procedure TRl_CtasGerenciaisPrevisto.QRBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_VL_TL_Saldo.Caption   := FloatToStrF(It_Vl_Conta,ffNumber,10,2);
end;

end.
