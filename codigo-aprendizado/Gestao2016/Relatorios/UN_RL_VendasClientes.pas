unit UN_RL_VendasClientes;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, QRExport, StdCtrls, Mask, DBCtrls;

type
  TRL_VendasClientes = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRBand;
    QRLabel8: TQRLabel;
    QRDBText11: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    Qr_Produtos: TSTQuery;
    QRLabel9: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRBand1: TQRBand;
    E_VL_TL_Total: TQRLabel;
    QRLabel2: TQRLabel;
    E_QT_TL_Total: TQRLabel;
    QRLabel4: TQRLabel;
    Lb_Vl_Unit: TQRLabel;
    QRDBText1: TQRDBText;
    Qr_ProdutosEMP_NOME: TStringField;
    Qr_ProdutosITF_QT_TOTAL: TBCDField;
    Qr_ProdutosITF_VL_TOTAL: TBCDField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Vl_TL_Produto: Currency;
    It_Qt_TL_Produto : Real;

    procedure Pc_Busca;
  end;

var
  RL_VendasClientes: TRL_VendasClientes;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema, ComCtrls;
{$R *.dfm}



procedure TRL_VendasClientes.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_Subgrupo, Lc_Vendedor, Lc_Data, Lc_Empresa:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  It_Vl_TL_Produto := 0;
  It_Vl_TL_Produto := 0;
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;

  SqlTxt:='SELECT EMP_NOME, CAST(SUM(ITF_QTDE) AS NUMERIC(18, 3)) ITF_QT_TOTAL, CAST(SUM(ITF_VL_UNIT) AS NUMERIC(18, 3)) ITF_VL_TOTAL '+
          'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
          '    INNER JOIN TB_EMPRESA tb_cliente '+
          '    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
          '    INNER JOIN TB_PEDIDO tb_pedido '+
          '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED ) '+
          '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
          '    ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) '+
          '    INNER JOIN TB_PRODUTO tb_produto '+
          '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
          'WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = ''1'') ';

  if Fr_Imp_Produtos.DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
  if Fr_Imp_Produtos.DBLCB_SubGrupos.Text ='' then Lc_Subgrupo := False else Lc_Subgrupo := True;
  if Fr_Imp_Produtos.DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;
  if Fr_Imp_Produtos.DBLCB_Empresas.Text ='' then Lc_Empresa := False else Lc_Empresa := True;

  if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
  if Lc_Subgrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
  if Lc_Vendedor then SqlTxt := SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) ';
  if Lc_Empresa then SqlTxt := SqlTxt +'AND (PED_CODEMP =:PED_CODEMP) ';

  SqlTxt := SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  Qr_Produtos.SQL.Add(SqlTxt + ' GROUP BY EMP_NOME '+
                               ' ORDER BY EMP_NOME ');

  if Lc_Grupo    then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger := Fr_Imp_Produtos.DBLCB_Grupos.KeyValue;
  if Lc_Subgrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger := Fr_Imp_Produtos.DBLCB_SubGrupos.KeyValue;
  if Lc_Vendedor then Qr_Produtos.ParamByName('PED_CODVDO').AsInteger := Fr_Imp_Produtos.DBLCB_Vendedor.KeyValue;
  if Lc_Empresa  then Qr_Produtos.ParamByName('PED_CODEMP').AsInteger := Fr_Imp_Produtos.DBLCB_Empresas.KeyValue;
  
  Qr_Produtos.ParamByName('DATAINI').AsDate := Fr_Imp_Produtos.E_Data_Ini.Date;
  Qr_Produtos.ParamByName('DATAFIM').AsDate := Fr_Imp_Produtos.E_Data_Fim.Date;
  Qr_Produtos.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_VendasClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  RL_VendasClientes:=nil;
end;

procedure TRL_VendasClientes.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_VendasClientes.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if It_Qt_TL_Produto > 0 then
    E_VL_TL_Total.Caption := FloatToStrF(It_Vl_TL_Produto / It_Qt_TL_Produto,ffFixed,10,2)
  else
    E_VL_TL_Total.Caption := FloatToStrF(0,ffFixed,10,2);  
  E_QT_TL_Total.Caption := FloatToStrF(It_Qt_TL_Produto,ffFixed,10,2);
end;

procedure TRL_VendasClientes.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Vl_TL_Produto := It_Vl_TL_Produto +  Qr_ProdutosITF_VL_TOTAL.AsCurrency;
  It_Qt_TL_Produto := It_Qt_TL_Produto +  Qr_ProdutosITF_QT_TOTAL.AsCurrency;
  Lb_Vl_Unit.Caption := FloatToStrF(Qr_ProdutosITF_VL_TOTAL.AsCurrency / Qr_ProdutosITF_QT_TOTAL.AsCurrency,ffFixed,10,2);
end;

end.
