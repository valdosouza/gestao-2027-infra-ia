unit UN_RL_VendasProdutos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, QRExport;

type
  TRL_VendasProdutos = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRBand;
    QRLabel8: TQRLabel;
    QRGroup1: TQRGroup;
    QRDBText11: TQRDBText;
    RodapeSubGrupo: TQRBand;
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
    E_Qt_Total: TQRLabel;
    E_Vl_Total: TQRLabel;
    E_Descricao: TQRLabel;
    QRBand1: TQRBand;
    E_VL_TL_Total: TQRLabel;
    QRLabel2: TQRLabel;
    E_QT_TL_Total: TQRLabel;
    QRLabel4: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeSubGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Vl_Produto: Currency;
    It_Qt_Produto : Real;
    It_Vl_TL_Produto: Currency;
    It_Qt_TL_Produto : Real;

    procedure Pc_Busca;
  end;

var
  RL_VendasProdutos: TRL_VendasProdutos;

implementation

uses     Un_DM, UN_Imp_vENDAS, UN_Sistema, Mask;
{$R *.dfm}



procedure TRL_VendasProdutos.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  LC_REGIAO,Lc_Cliente,Lc_NomeCliente ,  Lc_Vendedor :Boolean;
begin
  Screen.Cursor:=crHourGlass;
  It_Vl_Produto := 0;
  It_Qt_Produto := 0;
  It_Vl_TL_Produto := 0;
  It_Vl_TL_Produto := 0;
  Qr_Produtos.Close;
  Qr_Produtos.SQL.Clear;

  Lc_SqlTxt:='SELECT NFL_DT_EMISSAO,NFL_NUMERO,tb_cliente.EMP_FANTASIA,NFL_VL_TL_NOTA, '+
          'ITF_CODPRO,ITF_QTDE,ITF_VL_UNIT,PRO_CODIGO, PRO_DESCRICAO, NFL_TIPO, PED_TIPO, '+
          '(ITF_QTDE* ITF_VL_UNIT) as ITV_SUBTOTAL                            '+
          'FROM TB_NOTA_FISCAL tb_nota_fiscal                                 '+
          '    INNER JOIN TB_EMPRESA tb_cliente                               '+
          '    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)         '+
          '    INNER JOIN TB_PEDIDO tb_pedido                                 '+
          '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)          '+
          '    INNER JOIN TB_ITENS_NFL tb_itens_nfl                           '+
          '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO)       '+
          '    INNER JOIN TB_PRODUTO tb_produto                               '+
          '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)           '+
          ' INNER JOIN tb_endereco tb_endereco                                '+
          ' ON (tb_endereco.end_codigo = tb_pedido.ped_codend)                '+
          'WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = ''1'')              ';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( NFL_CODMHA =:NFL_CODMHA ) ';

  if Fr_Imp_Vendas.DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;
  if Fr_Imp_Vendas.E_Empresa.Text ='' then Lc_NomeCliente := False else Lc_NomeCliente := True;
  if Fr_Imp_Vendas.DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;
  if Fr_Imp_Vendas.DBLCB_Regiao.Text ='' then LC_REGIAO := False else LC_REGIAO := True;  

  if LC_REGIAO then
  Begin
    Lc_SqlTxt := Lc_SqlTxt +'AND (END_REGIAO LIKE :END_REGIAO)';
  End;

  if Lc_Cliente then
  Begin
    Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_CODEMP =:NFL_CODEMP) ';
  End;

  if Lc_NomeCliente then
  begin
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) ) ';
  end;


  if Lc_vendedor then
  Begin
    if Fr_Imp_Vendas.Rb_Vend_Clliente.Checked then
      Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODVDOR =:PED_CODVDO) '
    else
      Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) '
  end;

  if Fr_Imp_Vendas.ChBx_Periodo.Checked then Lc_SqlTxt := Lc_SqlTxt + 'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex =0 then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO IS NULL) ';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex =1 then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO IS NOT NULL) ';

  Qr_Produtos.SQL.Add(Lc_SqlTxt + 'ORDER BY PRO_DESCRICAO, PRO_CODIGO ');

  if Lc_Cliente then
  begin
    Qr_Produtos.ParamByName('NFL_CODEMP').AsInteger :=  Fr_Imp_Vendas.DBLCB_Empresa.KeyValue;
  end;

  if Lc_NomeCliente then
    Qr_Produtos.ParamByName('EMP_NOME').AsString  :=  '%'+Fr_Imp_Vendas.E_Empresa.Text+'%';

  if Fr_Imp_Vendas.ChBx_Periodo.Checked then
  begin
    Qr_Produtos.ParamByName('DATAINI').AsDate := Fr_Imp_Vendas.E_Data_Ini.Date;
    Qr_Produtos.ParamByName('DATAFIM').AsDate := Fr_Imp_Vendas.E_Data_Fim.Date;
  end;

  if LC_REGIAO then
    Qr_Produtos.ParamByName('END_REGIAO').AsString:= '%' + Fr_Imp_Vendas.DBLCB_Regiao.Text + '%';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
  Begin
    Qr_Produtos.ParamByName('NFL_CODMHA').AsInteger :=  Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;
  End;

  Qr_Produtos.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_VendasProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_VendasProdutos:=nil;
end;

procedure TRL_VendasProdutos.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_VendasProdutos.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Vl_Produto := It_Vl_Produto + (Qr_Produtos.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Produtos.FieldByName('ITF_QTDE').AsFloat);
  It_Qt_Produto := It_Qt_Produto + (Qr_Produtos.FieldByName('ITF_QTDE').AsFloat); 
end;

procedure TRL_VendasProdutos.RodapeSubGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_Descricao.Caption := concat(
                          Qr_Produtos.FieldByName('PRO_CODIGO').AsString,
                          ' - ',
                          Qr_Produtos.FieldByName('PRO_DESCRICAO').AsString);
  E_Vl_Total.Caption := FloatToStrF(It_Vl_Produto,ffFixed,10,2);
  E_Qt_Total.Caption := FloatToStrF(It_Qt_Produto,ffFixed,10,2);
  It_Vl_TL_Produto := It_Vl_TL_Produto + It_Vl_Produto;
  It_Qt_TL_Produto := It_Qt_TL_Produto + It_Qt_Produto;
  It_Vl_Produto := 0;
  It_Qt_Produto := 0; 
end;

procedure TRL_VendasProdutos.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_VL_TL_Total.Caption := FloatToStrF(It_Vl_TL_Produto,ffFixed,10,2);
  E_QT_TL_Total.Caption := FloatToStrF(It_Qt_TL_Produto,ffFixed,10,2);
end;

end.
