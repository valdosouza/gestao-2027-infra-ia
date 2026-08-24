unit UN_RL_Vda_Total_Produto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Vda_Total_Produto = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    DetalheVenda: TQRBand;
    QRBand4: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Vendas: TSTQuery;
    QRLabel8: TQRLabel;
    Ftr_Data: TQRBand;
    Grp_Data: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    E_Sub_Total_Produtos: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Vl_Custo: TQRLabel;
    E_Sub_Total_Notas: TQRLabel;
    E_VL_Produto: TQRLabel;
    E_Vl_Notas: TQRLabel;
    QRLabel10: TQRLabel;
    E_Total_Produtos: TQRLabel;
    QRLabel13: TQRLabel;
    E_Total_Notas: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Qr_VendasAfterOpen(DataSet: TDataSet);
    procedure Ftr_DataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    It_SubTotal_Produtos,It_SubTotal_Notas:Real;
    It_Total_Produtos,It_Total_Notas:Real;
  public
    { Public declarations }
    It_Cd_Estabelecimento:Integer;
    It_Cd_Pedido : Integer;
    It_PedidoAberto : boolean;
    It_PedidoFechado : boolean;
    It_NotaFiscal : boolean;
    It_PedidoNota : boolean;
    It_Periodo : Boolean;
    It_Dt_Inicio : TDate;
    It_Dt_Fim : TDate;
    It_Cd_Cliente : Integer;
    It_Nm_Cliente : String;
    it_Cd_VendedorCliente : Integer;
    it_Cd_VendedorPedido : Integer;
    It_End_Regiao :String;
    It_OrdenaNome : String;
    procedure Pc_Busca;
    procedure Pc_Parametros;
  end;

var
  RL_Vda_Total_Produto: TRL_Vda_Total_Produto;

implementation

uses      Un_DM, UN_Sistema, ComCtrls, StdCtrls, Un_Regra_Negocio, RN_Transportadora;
{$R *.dfm}



procedure TRL_Vda_Total_Produto.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  Lc_Aux : String;
  LC_REGIAO,Lc_Cliente, Lc_Vendedor, Lc_transportadora:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Vendas.Close;
  Qr_Vendas.SQL.Clear;

  Lc_SqlTxt :=  'SELECT DISTINCT NFL_CODIGO,PED_CODIGO, NFL_DT_EMISSAO,PED_NUMERO,PED_VL_DESCONTO,NFL_NUMERO, tb_empresa.EMP_NOME, '+
                'NFL_VL_TL_NOTA, NFL_VL_TL_PROD,NFL_VL_FRETE, NFL_VL_ICMS_SUBST, NFL_VL_DESP_ACESS, NFL_VL_SEGURO '+
                'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                '    INNER JOIN TB_EMPRESA tb_empresa '+
                '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                '    INNER JOIN TB_PEDIDO tb_pedido '+
                '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                '    INNER JOIN tb_endereco tb_endereco '+
                '    ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '+
                'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') AND (PED_TIPO = 1) AND (NFL_STATUS = ''F'')    ';

  if (It_Cd_Estabelecimento > 0) then
    Begin
    Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end;
    //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
    Lc_Aux := Trim(Fc_codigosNegocio);
    If Length(Lc_Aux) > 0 then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ((PED_CODNEG NOT IN (' + Lc_Aux + ')) or (PED_CODNEG IS NULL))';

  if It_Periodo then
    Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  if (Trim(It_End_Regiao) <> '') then Lc_SqlTxt := Lc_SqlTxt +'AND (END_REGIAO LIKE :END_REGIAO)';
  if It_Cd_Cliente >0 then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';

  if it_Cd_VendedorCliente > 0 then
    Lc_SqlTxt := Lc_SqlTxt +'AND (tb_empresa.EMP_CODVDOR =:EMP_CODVDOR) ';

  if (it_Cd_Vendedorpedido > 0) then
    Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) ';


  if It_PedidoFechado then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO ='''') or (NFL_NUMERO is null) ) ';
  if It_NotaFiscal then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO <>'''') or (NFL_NUMERO is not null) ) ';

  if (It_OrdenaNome = 'N') then
    Qr_Vendas.SQL.Add(Lc_SqlTxt +'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, tb_empresa.EMP_NOME ')
  else
    Qr_Vendas.SQL.Add(Lc_SqlTxt +'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, tb_empresa.EMP_FANTASIA ');

  if (It_Cd_Cliente >0) then Qr_Vendas.ParamByName('NFL_CODEMP').AsInteger:= It_Cd_Cliente;
  if it_Cd_VendedorCliente>0 then Qr_Vendas.ParamByName('EMP_CODVDOR').AsInteger:= it_Cd_VendedorCliente;
  if it_Cd_VendedorPedido>0 then Qr_Vendas.ParamByName('PED_CODVDO').AsInteger:= it_Cd_VendedorPedido;

  if (Trim(It_End_Regiao)<>'') then Qr_Vendas.ParamByName('END_REGIAO').AsString:= '%' + It_End_Regiao + '%';

  if It_Periodo then
    begin
    Qr_Vendas.ParamByName('DATAINI').AsDate := It_Dt_Inicio;
    Qr_Vendas.ParamByName('DATAFIM').AsDate := It_Dt_Fim;
    end;

  if (It_Cd_Estabelecimento >0) then Qr_Vendas.ParamByName('NFL_CODMHA').AsInteger := It_Cd_Estabelecimento;
  Qr_Vendas.Active := True;
  Qr_Vendas.FetchAll;
  Qr_Vendas.RecordCount;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Vda_Total_Produto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Vda_Total_Produto:=nil;
end;

procedure TRL_Vda_Total_Produto.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Vl_Custo : Real;
begin
  with Qr_Vendas do
  Begin
    //Produtos
    E_VL_Produto.Caption := FloatToStrF(FieldByName('NFL_VL_TL_PROD').AsCurrency,ffFixed,10,2);
    It_SubTotal_Produtos := It_SubTotal_Produtos + FieldByName('NFL_VL_TL_PROD').AsCurrency;
    It_Total_Produtos := It_Total_Produtos + FieldByName('NFL_VL_TL_PROD').AsCurrency;
    //Notas
    E_Vl_Notas.Caption := FloatToStrF(FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffFixed,10,2);
    It_SubTotal_Notas := It_SubTotal_Notas + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
    It_Total_Notas := It_Total_Notas + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
  end;
end;

procedure TRL_Vda_Total_Produto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_AtivaEstabelecimento;
  Pc_Cab_Relatorio(Qrpt);
  It_SubTotal_Produtos := 0;
  It_SubTotal_Notas := 0;
  It_Total_Produtos := 0;
  It_Total_Notas    := 0;
  Pc_Busca;
end;

procedure TRL_Vda_Total_Produto.Qr_VendasAfterOpen(DataSet: TDataSet);
begin
  Qr_Vendas.FetchAll;
  (Qr_Vendas.FieldByName('NFL_VL_TL_NOTA') as TNumericField).DisplayFormat  := '#,##0.00';
  (Qr_Vendas.FieldByName('PED_VL_DESCONTO') as TNumericField).DisplayFormat    := '#,##0.00';
end;

procedure TRL_Vda_Total_Produto.Pc_Parametros;
begin

end;

procedure TRL_Vda_Total_Produto.Ftr_DataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Produtos
  E_Sub_Total_Produtos.Caption := FloatToStrF(It_SubTotal_Produtos,ffFixed,10,2);
  It_SubTotal_Produtos := 0;
  //Notas
  E_Sub_Total_Notas.Caption := FloatToStrF(It_SubTotal_Notas,ffFixed,10,2);
  It_SubTotal_Notas := 0;
end;

procedure TRL_Vda_Total_Produto.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Produtos
  E_Total_Produtos.Caption := FloatToStrF(It_Total_Produtos,ffFixed,10,2);
  It_Total_Produtos := 0;
  //Notas
  E_Total_Notas.Caption := FloatToStrF(It_Total_Notas,ffFixed,10,2);
  It_Total_Notas := 0;
end;

end.
