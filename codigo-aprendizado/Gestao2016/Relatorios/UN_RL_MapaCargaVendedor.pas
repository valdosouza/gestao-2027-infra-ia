unit UN_RL_MapaCargaVendedor;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, QRCtrls, QuickRpt, ExtCtrls, jpeg, StdCtrls;

type
  TRL_MapaCargaVendedor = class(TForm)
    Qrpt: TQuickRep;
    Qrp_Vendedor: TQRGroup;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    Qrp_Produto: TQRGroup;
    Titulo: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    Ft_Vendedor: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr2: TQRExpr;
    QRBand1: TQRBand;
    QRDBText4: TQRDBText;
    QR_Vendas: TQRExpr;
    Qr_Desconto: TQRExpr;
    Grp_Produto: TQRBand;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    Qr_Total: TQRExpr;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRExpr3: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel8: TQRLabel;
    Qr_MapaCarga: TSTQuery;
    QRLabel7: TQRLabel;
    QRExpr4: TQRExpr;
    QRLabel10: TQRLabel;
    QRExpr5: TQRExpr;
    QRLabel11: TQRLabel;
    QRDBText1: TQRDBText;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Grp_ProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_Linha : integer;
  public
    { Public declarations }
    procedure Pc_Buscar;
  end;

var
  RL_MapaCargaVendedor: TRL_MapaCargaVendedor;

implementation

uses     UN_Sistema, UN_Imp_MapaCarga;
{$R *.dfm}
procedure TRL_MapaCargaVendedor.Pc_Buscar;
Var
  SqlTxt : String;
  Lc_I : Integer;
  Lc_Str_Inclui : String;
Begin
  Screen.Cursor := crHourGlass;
  Qr_MapaCarga.Active := False;
  Qr_MapaCarga.SQL.Clear;
  sqltxt := 'SELECT PED_DATA, PED_CODIGO, PED_NUMERO, EMP_FANTASIA,EMB_ABREVIATURA, '+
            'CLB_NOME, PED_VL_PEDIDO, PRO_DESCRICAO,ITF_QTDE, ITF_VL_UNIT, PED_CODVDO '+
            'FROM TB_PEDIDO tb_pedido '+
            '   INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
            '   ON  (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) '+
            '   INNER JOIN TB_PRODUTO tb_produto '+
            '   ON  (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
            '   LEFT OUTER JOIN  TB_NOTA_FISCAL tb_nota_fiscal'+
            '   ON  (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
            '   INNER JOIN TB_EMPRESA tb_empresa '+
            '   ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
            '   INNER JOIN TB_COLABORADOR Tb_colaborador '+
            '   ON  (Tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) '+
            '      INNER JOIN TB_EMBALAGEM tb_embalagem                '+
            '      ON (tb_produto.PRO_CODEMB = tb_embalagem.EMB_CODIGO) ';


  Lc_Str_Inclui := 'WHERE (PED_CODIGO IN (';
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

  SqlTxt :=   SqlTxt + Lc_Str_Inclui + 'ORDER BY CLB_NOME, PRO_DESCRICAO ';

  Qr_MapaCarga.SQL.Add(SqlTxt);
  Qr_MapaCarga.Active := TRUE;
  Screen.Cursor := crDefault;

end;
procedure TRL_MapaCargaVendedor.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  It_Linha := 0;
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Buscar;
end;

procedure TRL_MapaCargaVendedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_MapaCargaVendedor:=nil;
end;

procedure TRL_MapaCargaVendedor.Grp_ProdutoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inc(It_Linha);
  if (It_Linha mod 2) = 0 then Grp_Produto.Color := clSilver else Grp_Produto.Color := clWhite;

end;

end.
