unit Un_RL_Nec_Compra;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery, Un_Regra_Negocio;

type
  TRL_Nec_Compra = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRGroup2: TQRGroup;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    E_CODPRODUTO: TQRDBText;
    QRDBText7: TQRDBText;
    RodapeSubGrupo: TQRBand;
    QRLabel7: TQRLabel;
    QRBand3: TQRBand;
    QRLabel8: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel10: TQRLabel;
    Qr_Produtos: TSTQuery;
    Qr_ProdutosPRO_CODIGO: TIntegerField;
    Qr_ProdutosPRO_DESCRICAO: TStringField;
    Qr_ProdutosPRO_QTDE: TBCDField;
    Qr_ProdutosPRO_QTDE_MIN: TBCDField;
    Qr_ProdutosPRO_CODGRP: TIntegerField;
    Qr_ProdutosPRO_CODSBG: TIntegerField;
    Qr_ProdutosPRO_VL_VENDA: TBCDField;
    Qr_ProdutosGRP_DESCRICAO: TStringField;
    Qr_ProdutosSBG_DESCRICAO: TStringField;
    Qr_ProdutosGRP_CODIGO: TIntegerField;
    Qr_ProdutosSBG_CODGRP: TIntegerField;
    Qr_ProdutosPRO_VL_CUSTO: TBCDField;
    Qr_ProdutosPRO_SUBTOTAL: TFloatField;
    Lb_Vl_SubTotal: TQRLabel;
    LB_Qt_SubTotal: TQRLabel;
    Lb_Qt_Total: TQRLabel;
    Lb_Vl_Total: TQRLabel;
    Qr_ProdutosPRO_CODIGOFAB: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeSubGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_VL_SubTotal: Currency;
    It_VL_Total: Currency;
    It_Qt_Total: Currency;
    It_Qt_SubTotal: Currency;
  procedure Pc_Busca;

  end;

var
  RL_Nec_Compra: TRL_Nec_Compra;

implementation

uses     Un_DM, UN_Imp_Produtos, UN_Sistema, ComCtrls;
{$R *.dfm}



procedure TRL_Nec_Compra.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo, Lc_Fornece:Boolean;
begin
  Screen.Cursor:=crHourGlass;

  It_VL_SubTotal := 0;
  It_VL_Total := 0;
  It_Qt_Total := 0;
  It_Qt_SubTotal := 0;
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;

  SqlTxt:='SELECT DISTINCT PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO,  PRO_QTDE, PRO_QTDE_MIN, PRO_CODGRP, PRO_CODSBG, PRO_VL_CUSTO, '+
          'PRO_VL_VENDA, GRP_DESCRICAO, SBG_DESCRICAO, GRP_CODIGO, SBG_CODGRP, (PRO_VL_CUSTO * PRO_QTDE) AS PRO_SUBTOTAL '+
          'FROM TB_PRODUTO Tb_produto '+
          '   INNER JOIN TB_GRUPOS Tb_grupos '+
          '   ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '+
          '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos '+
          '   ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) '+
          '   LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn '+
          '   ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) '+
          '   LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor '+
          '   ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) '+
          'WHERE (PRO_IMPRIME=''S'') AND ((PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'')) and (PRO_QTDE < 0) ';

  if Fr_Imp_Produtos.DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
  if Fr_Imp_Produtos.DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
  if Fr_Imp_Produtos.DBLCB_Empresas.Text ='' then Lc_Fornece := False else Lc_Fornece := True;

  if Fr_Imp_Produtos.ChBx_Est_Min.Checked then SqlTxt := SqlTxt + ' AND ( (EST_QTDE < PRO_QTDE_MIN) AND (PRO_QTDE_MIN > 0) )';
  if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
  if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
  if Lc_Fornece then SqlTxt := SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';

  if Fr_Imp_Produtos.ChBx_SemMov.Checked then
  Begin
    Fc_ProdutosVendidos(E_Data_Ini.Date,E_Data_Fim.Date);
    SqlTxt := SqlTxt + 'AND (PRO_QTDE > 0) AND (PRO_VENDA = ''N'') ';
  end;

  if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 0 then
    Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO')
  else
    if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 1 then
      Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB')
    else
      Qr_Produtos.SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO');
  if Lc_Grupo then Qr_Produtos.ParamByName('PRO_CODGRP').AsInteger:=Fr_Imp_Produtos.DBLCB_Grupos.KeyValue;
  if Lc_SubGrupo then Qr_Produtos.ParamByName('PRO_CODSBG').AsInteger:=Fr_Imp_Produtos.DBLCB_SubGrupos.KeyValue;
  if Lc_Fornece then Qr_Produtos.ParamByName('PFR_CODFOR').AsInteger:=Fr_Imp_Produtos.DBLCB_Empresas.KeyValue;

  Qr_Produtos.Open;
  Screen.Cursor:=crDefault;


end;

procedure TRL_Nec_Compra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  RL_Nec_Compra.Release;
  RL_Nec_Compra := nil;
end;

procedure TRL_Nec_Compra.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Qt_SubTotal := It_Qt_SubTotal + Qr_ProdutosPRO_QTDE.AsFloat;
  It_Vl_SubTotal := It_Vl_SubTotal + Qr_ProdutosPRO_SUBTOTAL.AsCurrency;
end;

procedure TRL_Nec_Compra.RodapeSubGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  LB_Qt_SubTotal.Caption := FloatToStrF(It_Qt_SubTotal,ffFixed,10,3);
  Lb_Vl_SubTotal.Caption := FloatToStrF(It_VL_SubTotal,ffFixed,10,3);
  It_Qt_Total := It_Qt_Total + It_Qt_SubTotal;
  It_Vl_Total := It_Vl_Total + It_VL_SubTotal;
  It_Qt_SubTotal := 0;
  It_VL_SubTotal := 0;
end;

procedure TRL_Nec_Compra.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LB_Qt_Total.Caption := FloatToStrF(It_Qt_Total,ffFixed,10,3);
  Lb_Vl_Total.Caption := FloatToStrF(It_VL_Total,ffFixed,10,3);

end;

procedure TRL_Nec_Compra.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Cab_Relatorio(Qrpt);
  if Fr_Imp_Produtos.CB_Ordena.ItemIndex = 1 then
    Begin
    E_CODPRODUTO.DataField := 'PRO_CODIGOFAB';
    end
  else
    BEgin
    E_CODPRODUTO.DataField := 'PRO_CODIGO';
    end;
  Pc_Busca;
end;

end.
