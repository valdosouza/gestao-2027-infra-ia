unit Un_RL_MapaCargaFinanceiro;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QRCtrls, QuickRpt, ExtCtrls, jpeg, StdCtrls;

type
  TRL_MapaCargaFinanceiro = class(TForm)
    Qrpt: TQuickRep;
    Titulo: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel8: TQRLabel;
    Qr_MapaCarga: TSTQuery;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    E_VL_Total: TQRLabel;
    E_Qtde_Vendas: TQRLabel;
    E_Med_Positivacao: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    QtdeVendas : Integer;
    ValorTotal : Real;
  public
    { Public declarations }
    procedure Pc_Buscar;
  end;

var
  RL_MapaCargaFinanceiro: TRL_MapaCargaFinanceiro;

implementation

uses     UN_Sistema, UN_Imp_MapaCarga;
{$R *.dfm}
procedure TRL_MapaCargaFinanceiro.Pc_Buscar;
Var
  SqlTxt : String;
  Lc_I : Integer;
  Lc_Str_Inclui : String;
Begin
  Screen.Cursor := crHourGlass;
  Qr_MapaCarga.Active := False;
  Qr_MapaCarga.SQL.Clear;
  sqltxt := 'SELECT PED_DATA, PED_CODIGO, PED_NUMERO, EMP_NOME, '+
            'CLB_NOME, PED_VL_PEDIDO,  PED_CODVDO '+
            'FROM TB_PEDIDO tb_pedido '+
            '   LEFT OUTER JOIN  TB_NOTA_FISCAL tb_nota_fiscal'+
            '   ON  (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            '   INNER JOIN TB_EMPRESA tb_empresa '+
            '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
            '   INNER JOIN TB_COLABORADOR Tb_colaborador '+
            '   ON  (Tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) ';

  Lc_Str_Inclui := 'WHERE (PED_TIPO = 1) AND (PED_CODIGO IN (';
  with Fr_Imp_MapaCarga do
    Begin
    For Lc_I := 1 to StrGrd_Pedido.RowCount -1 do
      if StrGrd_Pedido.Cells[1,Lc_I] <> '' then
        if Lc_I = 1 then
          Lc_Str_Inclui := Lc_Str_Inclui + StrGrd_Pedido.Cells[1,lc_i]
        else
          Lc_Str_Inclui := Lc_Str_Inclui + ','+StrGrd_Pedido.Cells[1,lc_i];
      end;
  Lc_Str_Inclui := Lc_Str_Inclui +')) ';

  SqlTxt :=   SqlTxt + Lc_Str_Inclui + ' ORDER BY EMP_NOME ';

  Qr_MapaCarga.SQL.Add(SqlTxt);
  Qr_MapaCarga.Active := TRUE;
  Screen.Cursor := crDefault;

end;
procedure TRL_MapaCargaFinanceiro.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Inc(QtdeVendas);
  ValorTotal := ValorTotal + Qr_MapaCarga.FieldByName('PED_VL_PEDIDO').AsCurrency;
end;

procedure TRL_MapaCargaFinanceiro.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_VL_Total.Caption        := FloatToStrF(ValorTotal,ffNumber,10,2);
  E_Qtde_Vendas.Caption     := FloatToStrF(QtdeVendas,ffNumber,10,2);
  E_Med_Positivacao.Caption := FloatToStrF(ValorTotal / QtdeVendas,ffNumber,10,2);
end;

procedure TRL_MapaCargaFinanceiro.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  QtdeVendas := 0;
  ValorTotal := 0;
  Pc_Buscar;
end;

procedure TRL_MapaCargaFinanceiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_MapaCargaFinanceiro:=nil;
end;

end.
