unit Un_Rl_CtasGerenciaisPrevistoDet;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, ExtCtrls, QuickRpt, QRCtrls, STQuery, StdCtrls, Grids;

type
  TRl_CtasGerenciaisPrevistoDet = class(TForm)
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
  Rl_CtasGerenciaisPrevistoDet: TRl_CtasGerenciaisPrevistoDet;

implementation

uses     Un_DM, UN_Imp_CtasGerenciais, UN_Sistema, RN_PlanoContas;

{$R *.dfm}

procedure TRl_CtasGerenciaisPrevistoDet.Pc_Parametros;
Begin
  with Fr_Imp_CtasGerenciais do
    Begin
    Lb_Tipo_Rl.Caption      := CB_Tipo.Text;
    Lb_Data_Ini.Caption     :=  DateToStr(E_Data_Ini.Date);
    Lb_Data_Fim.Caption     :=  DateToStr(E_Data_Fim.Date);
    Lb_ContaInicial.Caption := DBLCB_Plc_I.Text;
    Lb_ContaFinal.Caption   :=   DBLCB_Plc_F.Text;
    end;
end;

procedure TRl_CtasGerenciaisPrevistoDet.Pc_Preparar;
Var
  LC_I : Integer;
Begin
  Bnd_Detalhe.Items.Clear;
  For LC_I := 1 to Lc_Grade.RowCount - 1 do
    Bnd_Detalhe.Items.Add('');
  it_Linha := 0;
end;

procedure TRl_CtasGerenciaisPrevistoDet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
end;

procedure TRl_CtasGerenciaisPrevistoDet.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  It_Vl_Conta := 0;
  Pc_Preparar;
  Pc_Parametros;
end;

procedure TRl_CtasGerenciaisPrevistoDet.Bnd_DetalheBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
Var
  Lc_Vl_Conta : Real;
begin
  inc(it_Linha);
  E_Cd_Plano.Caption := '  ' + Lc_Grade.Cells[1,it_Linha];
  Lc_Vl_Conta := StrToFloatDef(Lc_Grade.Cells[3,it_Linha],0);
  E_VL_Saldo.Caption := Lc_Grade.Cells[3,it_Linha];

  if Lc_Grade.Cells[0,it_Linha] = 'S' then
    Begin
    E_Cd_Plano.Color := clSilver;
    E_Descricao.Caption := Lc_Grade.Cells[2,it_Linha];
    end
  else
    Begin
    E_Cd_Plano.Color := clWhite;
    E_Descricao.Caption := '      ' + Lc_Grade.Cells[2,it_Linha];
    It_Vl_Conta := It_Vl_Conta + Lc_Vl_Conta
    end;
end;

procedure TRl_CtasGerenciaisPrevistoDet.QRBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_VL_TL_Saldo.Caption   := FloatToStrF(It_Vl_Conta,ffFixed,10,2);
end;

end.
