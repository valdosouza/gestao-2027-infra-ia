unit Un_RL_Venda_Item;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, QRExport;

type
  TRL_Venda_Item = class(TForm)
    Qr_Vendas: TSTQuery;
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel8: TQRLabel;
    QRBand5: TQRBand;
    QRDBText9: TQRDBText;
    QRDBText11: TQRDBText;
    QRBand6: TQRBand;
    QRBand7: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_Nome_Emp: TQRLabel;
    Lb_Transportadora: TQRLabel;
    Lb_Tipo: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRBand2: TQRBand;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Vl_Unitario: TQRLabel;
    QRLabel2: TQRLabel;
    qr_soma: TSTQuery;
    lbl_particip: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    E_CustoMedio: TQRLabel;
    E_PrecoMedio: TQRLabel;
    QRLabel4: TQRLabel;
    E_ValorTotal: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Qr_VendasAfterOpen(DataSet: TDataSet);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand6BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qr_somaAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    ValorTotal : REal;
    PrmGrupo, PrmMinhaEmpresa, PrmEstoque, PrmPeriodo, PrmInternet, PrmSubGRupo, PrmMArca, PrmProduto, PrmEmpMovim, PrmEmpProduto, PrmVendedor : Boolean;
    Procedure VerificaParametros;
  public
    { Public declarations }

    procedure Pc_BuscarVendas;
    procedure Pc_BuscarProdutos;
    function SQLProdutoSemComposicao:String;
    function SQlProdutoComComposicao:String;
    function SQlSomaTotal:String;
    function SQlProdutoCriterios:String;
    Procedure PassaParametrosProdutos(Qry:TSTQuery);
    procedure Pc_ParametrosVendas;
    procedure Pc_ParametrosProdutos;
  end;

var
  RL_Venda_Item: TRL_Venda_Item;

implementation

uses     UN_Imp_Vendas, UN_DM, DBCtrls, UN_Sistema, ComCtrls, UN_Imp_Produtos, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}



procedure TRL_Venda_Item.Pc_BuscarVendas;
VaR
  Lc_SqlTxt,  Lc_SqlTxt_Soma:String;
  Lc_SqlCriterio : String;
  LC_REGIAO,  Lc_Cliente, Lc_NomeCliente , Lc_Vendedor, Lc_transportadora:Boolean;
  Lc_Aux : String;
begin
  Lc_SqlCriterio := '';
  Screen.Cursor:=crHourGlass;
  Qr_Vendas.Close;
  Qr_Vendas.SQL.Clear;

  qr_soma.Close;
  qr_soma.SQL.Clear;
  Lc_SqlTxt_Soma:='  SELECT  suM((ITF_VL_UNIT * ITF_QTDE)-ITF_VL_DESC) Total_valor '+
                  ' FROM TB_NOTA_FISCAL tb_nota_fiscal  '+
                  '     INNER JOIN TB_EMPRESA tb_empresa '+
                  '     ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                  '     INNER JOIN TB_PEDIDO tb_pedido  '+
                  '     ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  '     INNER JOIN TB_ITENS_NFL tb_itens_nfl  '+
                  '     ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
                  '     INNER JOIN TB_PRODUTO Tb_produto  '+
                  '     ON  (Tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
                  '     INNER JOIN TB_MEDIDA tb_medida '+
                  '     ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
                  '     INNER JOIN tb_endereco tb_endereco '+
                  '     ON (tb_endereco.end_codigo = tb_pedido.ped_codend)               '+
                  ' WHERE (NFL_CODIGO IS NOT NULL) '+
                  '  AND (NFL_TIPO = ''SI'') '+
                  '  AND (PED_TIPO = 1) '+
                  '  AND (NFL_STATUS = ''F'')  '+
                  '  AND (ITF_OPER = ''V'' ) ';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Lc_SqlTxt_Soma := Lc_SqlTxt_Soma + ' AND ( NFL_CODMHA =:NFL_CODMHA ) ';



  Lc_SqlTxt := 'SELECT DISTINCT '+
               ' PRO_DESCRICAO, '+
               ' SUM((ITF_VL_CUSTO * ITF_QTDE) - ITF_VL_DESC)  Custo_total, '+
               ' SUM((ITF_VL_UNIT  * ITF_QTDE) - ITF_VL_DESC)  Preco_Total, '+
               ' SUM(ITF_QTDE) TOTAL_QTD, '+
               ' suM((ITF_VL_UNIT*ITF_QTDE)-ITF_VL_DESC) Total_valor '+
               ' FROM TB_NOTA_FISCAL tb_nota_fiscal '+
               '     INNER JOIN TB_EMPRESA tb_empresa  '+
               '     ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)     '+
               '     INNER JOIN TB_PEDIDO tb_pedido '+
               '     ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)      '+
               '     INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
               '     ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO)   '+
               '     INNER JOIN TB_PRODUTO Tb_produto '+
               '     ON  (Tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)      '+
               '     INNER JOIN TB_MEDIDA tb_medida  '+
               '     ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
               '     INNER JOIN tb_endereco tb_endereco  '+
               '     ON (tb_endereco.end_codigo = tb_pedido.ped_codend)               '+
               ' WHERE (NFL_CODIGO IS NOT NULL) '+
               '  AND (NFL_TIPO = ''SI'') '+
               '  AND (PED_TIPO = 1) '+
               '  AND (NFL_STATUS = ''F'')  '+
               '  AND (ITF_OPER = ''V'' ) ';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( NFL_CODMHA =:NFL_CODMHA ) ';


    //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
    Lc_Aux := Trim(Fc_codigosNegocio);
    If Length(Lc_Aux) > 0 then
    begin
      Lc_SqlCriterio := Lc_SqlCriterio + 'AND ((PED_CODNEG NOT IN (' + Lc_Aux + ')) or (PED_CODNEG IS NULL))';
    end;

    if Fr_Imp_Vendas.DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;
    if Fr_Imp_Vendas.E_Empresa.Text ='' then Lc_NomeCliente := False else Lc_NomeCliente := True;
    if Fr_Imp_Vendas.DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;
    if Fr_Imp_Vendas.DBLCB_Transportadora.Text ='' then Lc_transportadora := False else Lc_transportadora := True;
    if Fr_Imp_Vendas.DBLCB_Regiao.Text ='' then LC_REGIAO := False else LC_REGIAO := True;

  if LC_REGIAO then
  begin
    Lc_SqlCriterio := Lc_SqlCriterio +' AND (END_REGIAO LIKE :END_REGIAO) ';
  end;

  if Lc_Cliente then
  begin
    Lc_SqlCriterio := Lc_SqlCriterio +'AND (NFL_CODEMP =:NFL_CODEMP) ';
  end;

  if Lc_NomeCliente then
  begin
    Lc_SqlCriterio := Lc_SqlCriterio + ' AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) ) ';
  end;

  if Lc_vendedor then
  Begin
    if Fr_Imp_Vendas.Rb_Vend_Clliente.Checked then
    Begin
      Lc_SqlCriterio := Lc_SqlCriterio +'AND (EMP_CODVDOR =:PED_CODVDO) ';
    end
    else
    Begin
      Lc_SqlCriterio := Lc_SqlCriterio +'AND (PED_CODVDO =:PED_CODVDO) ';
    end;
  end;

  if Lc_transportadora then
  begin
    Lc_SqlCriterio := Lc_SqlCriterio +'AND (NFL_CODTRP =:NFL_CODTRP) ';
  end;

  IF Fr_Imp_Vendas.ChBx_Periodo.Checked THEN
    Lc_SqlCriterio := Lc_SqlCriterio +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
  IF Fr_Imp_Vendas.ChBx_Periodo.Checked THEN
    Lc_SqlCriterio := Lc_SqlCriterio +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
  if Fr_Imp_Vendas.ChBx_InternetPublished.Checked then
    Lc_SqlCriterio := Lc_SqlCriterio + ' AND  (PRO_INTERNET = ''S'') ';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex =0 then
  begin
    Lc_SqlCriterio := Lc_SqlCriterio + 'AND ( (NFL_NUMERO ='''') or (NFL_NUMERO is null) ) ';
  end;

  if Fr_Imp_Vendas.RG_Tipo.ItemIndex =1 then
  begin
    Lc_SqlCriterio := Lc_SqlCriterio + 'AND ( (NFL_NUMERO <>'''') or (NFL_NUMERO is not null) )';
  end;

   Qr_Vendas.SQL.Add(Lc_SqlTxt + Lc_SqlCriterio + 'group by 1 order by 1      ');
   qr_soma.SQL.Add(Lc_SqlTxt_Soma + Lc_SqlCriterio );

  if LC_REGIAO then
    begin
    Qr_Vendas.ParamByName('END_REGIAO').AsString:= '%' + Fr_Imp_Vendas.DBLCB_Regiao.Text + '%';
    qr_soma.ParamByName('END_REGIAO').AsString:= '%' + Fr_Imp_Vendas.DBLCB_Regiao.Text + '%';
    end;    

  if Lc_Cliente then
  begin
    Qr_Vendas.ParamByName('NFL_CODEMP').AsInteger :=Fr_Imp_Vendas.DBLCB_Empresa.KeyValue;
    qr_soma.ParamByName('NFL_CODEMP').AsInteger :=Fr_Imp_Vendas.DBLCB_Empresa.KeyValue;
  end;

  if Lc_NomeCliente then
  begin
    Qr_Vendas.ParamByName('EMP_NOME').AsString  :=  concat('%', Fr_Imp_Vendas.E_Empresa.Text,'%');
    qr_soma.ParamByName('EMP_NOME').AsString    :=  concat('%' ,Fr_Imp_Vendas.E_Empresa.Text,'%');
  end;

  if Lc_Vendedor then
    begin
    Qr_Vendas.ParamByName('PED_CODVDO').AsInteger:=Fr_Imp_Vendas.DBLCB_Vendedor.KeyValue;
    qr_soma.ParamByName('PED_CODVDO').AsInteger:=Fr_Imp_Vendas.DBLCB_Vendedor.KeyValue;
    end;

  if Lc_transportadora then
    begin
    Qr_Vendas.ParamByName('NFL_CODTRP').AsInteger := Fr_Imp_Vendas.DBLCB_Transportadora.KeyValue;
    qr_soma.ParamByName('NFL_CODTRP').AsInteger := Fr_Imp_Vendas.DBLCB_Transportadora.KeyValue;
    end;

  IF Fr_Imp_Vendas.ChBx_Periodo.Checked THEN
    BEGIN
    Qr_Vendas.ParamByName('DATAINI').AsDate:=Fr_Imp_Vendas.E_Data_INI.Date;
    Qr_Vendas.ParamByName('DATAFIM').AsDate:=Fr_Imp_Vendas.E_Data_FIM.Date;
    qr_soma.ParamByName('DATAINI').AsDate:=Fr_Imp_Vendas.E_Data_INI.Date;
    qr_soma.ParamByName('DATAFIM').AsDate:=Fr_Imp_Vendas.E_Data_FIM.Date;
    END;

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
  Begin
    Qr_Vendas.ParamByName('NFL_CODMHA').AsInteger :=  Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;
    qr_soma.ParamByName('NFL_CODMHA').AsInteger   :=  Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;
  End;

  Qr_Vendas.Open;
  qr_soma.Open;
  Screen.Cursor:=crDefault;

end;

procedure TRL_Venda_Item.PassaParametrosProdutos(Qry:TSTQuery);
begin
  with Fr_Imp_Produtos,Qry do
  Begin
    if PrmMinhaEmpresa then
      ParamByName('PRO_CODMHA').AsInteger:= Gb_CodMha;

    if PrmEstoque then
      ParamByName('ETS_CODIGO').AsInteger:= Fm_ListaEstoques.DBLCB_Estoque.KeyValue;

    if PrmPeriodo then
    begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    end;

    if PrmGrupo then
      ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;

    if PrmSubGrupo then
      ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;

    if PrmMArca then
      ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;

    if PrmProduto then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricaoProduto.Text,1,98)+ '%';

    if PrmEmpMovim then
      ParamByName('NFL_CODEMP').AsInteger := DBLCB_Empresa.KeyValue;

    if PrmEmpProduto then
      ParamByName('PFR_CODFOR').AsInteger := DBLCB_Empresa.KeyValue;

    if PrmVendedor then
      ParamByName('PED_CODVDO').AsInteger := dblcb_Vendedor.KeyValue;
  end;
end;

procedure TRL_Venda_Item.Pc_BuscarProdutos;
begin
  Screen.Cursor:=crHourGlass;
  VerificaParametros;

  with qr_soma do
  Begin
    SQL.Clear;
    SQL.Add(concat(
            SQlSomaTotal
    ));
    PassaParametrosProdutos(qr_soma);
    Open;
  End;

  with Qr_Vendas do
  Begin
    SQL.Clear;
    SQL.Add(concat(
         'SELECT ',
         '  PRO_DESCRICAO, ',
         '  SUM( Custo_tl )  Custo_total, ',
         '  SUM( Preco_Tl )  Preco_Total, ',
         '  SUM( Qtde_tl )  TOTAL_QTD, ',
         '  suM( Valor_tl ) Total_valor ',
         'FROM( ',
            SQLProdutoSemComposicao,
            ' UNION ',
            SQLProdutoComComposicao,
         ') ',
         'GROUP BY 1 ',
         'ORDER BY 1 '
    ));
    PassaParametrosProdutos(Qr_Vendas);
    Open;
  End;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Venda_Item.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Venda_Item:=nil;
end;

procedure TRL_Venda_Item.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  if Assigned(Fr_Imp_Vendas) then Pc_BuscarVendas;
  if Assigned(Fr_Imp_Produtos) then Pc_BuscarProdutos;
  if Assigned(Fr_Imp_Vendas) then Pc_ParametrosVendas;
  if Assigned(Fr_Imp_Produtos) then Pc_ParametrosProdutos;
end;

procedure TRL_Venda_Item.qr_somaAfterOpen(DataSet: TDataSet);
begin
  (Qr_Soma.FieldByName('TOTAL_VALOR') as TNumericField).DisplayFormat  := '#,##0.00####';
end;

procedure TRL_Venda_Item.Qr_VendasAfterOpen(DataSet: TDataSet);
begin
  (Qr_Vendas.FieldByName('TOTAL_QTD') as TNumericField).DisplayFormat  := '#,##0.00####';
  (Qr_Vendas.FieldByName('TOTAL_VALOR') as TNumericField).DisplayFormat  := '#,##0.00####';
end;

function TRL_Venda_Item.SQlProdutoComComposicao: String;
begin
  REsult := Concat(
              'SELECT ',
              '  PRO_DESCRICAO, ',
              '  SUM((ITF_VL_CUSTO * ITF_QTDE) - ITF_VL_DESC)  Custo_tl, ',
              '  SUM((ITF_VL_UNIT  * ITF_QTDE) - ITF_VL_DESC)  Preco_Tl, ',
              '  SUM( ITF_QTDE * PPD.PPD_QTDE ) Qtde_tl, ',
              '  suM((ITF_VL_UNIT*ITF_QTDE)-ITF_VL_DESC) Valor_tl ',
              'FROM TB_ITENS_NFL I ',
              '  INNER JOIN tb_pedido PD ',
              '  ON (PD.PED_CODIGO = I.ITF_CODPED) ',
              '  INNER join tb_nota_fiscal NF ',
              '  on (NF.NFL_CODPED = PED_CODIGO) ',
              '  INNER JOIN tb_prod_prod PPD ',
              '  ON (PPD.ppd_codpro_m = I.ITF_CODPRO) ',
              '  INNER JOIN tb_produto PR ',
              '  ON (PR.PRO_CODIGO = PPD.ppd_codpro_d) ',
              '  INNER JOIN TB_MARCA_PRODUTO MC ',
              '  ON (MC.mrc_codigo = PR.pro_codmrc)',
              SQlProdutoCriterios,
              'GROUP BY 1 '
  );
end;

function TRL_Venda_Item.SQlProdutoCriterios: String;
Var
  Lc_Aux: String;
begin
  Result := concat(
              'WHERE (NFL_CODIGO IS NOT NULL) ',
              ' AND (NFL_TIPO = ''SI'') ',
              ' AND (PED_TIPO = 1)  ',
              ' AND ((NF.NFL_STATUS <> ''C'') or (NF.NFL_STATUS IS NULL)) ',
              ' AND ( I.itf_oper  = ''V'' ) ',
              ' AND (PRO_TIPO <> ''S'') '
  );

  //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
  Lc_Aux := Trim(Fc_codigosNegocio);
  If Length(Lc_Aux) > 0 then
    Result := concat(Result, ' AND ((PED_CODNEG NOT IN (' , Lc_Aux , ')) or (PED_CODNEG IS NULL))');

  if PrmMinhaEmpresa then
    Result := concat(Result,  ' AND (PRO_CODMHA =:PRO_CODMHA) ') ;

  if PrmEstoque then
    Result := concat(Result,' AND ITF_CODEST = :ETS_CODIGO ');

  if PrmPeriodo then
    Result := concat(Result, ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ');


  if PrmGrupo       then Result := concat(Result, ' AND (PRO_CODGRP =:PRO_CODGRP) ');
  if PrmSubGrupo    then Result := concat(Result, ' AND (PRO_CODSBG =:PRO_CODSBG) ');
  if Prmmarca       then Result := concat(Result, ' AND (PRO_CODMRC =:PRO_CODMRC) ');
  if PrmProduto     then Result := concat(Result, ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ');
  if PrmEmpMovim    then Result := concat(Result, ' AND (NFL_CODEMP =:NFL_CODEMP) ');
  if PrmEmpProduto  then Result := concat(Result, ' AND (PFR_CODFOR=:PFR_CODFOR) ');
  if PrmInternet    then Result := concat(Result, ' AND  (PRO_INTERNET = ''S'') ');

  if PrmVendedor  then
  Begin
    //if Rb_Vend_Cliente.Checked then
    //  Lc_SqlCriterio := Lc_SqlCriterio +' AND (tb_cliente.EMP_CODVDOR =:PED_CODVDO) '
    //else
    Result := concat(Result,' AND (PED_CODVDO =:PED_CODVDO) ');
  end;
  {
  if Lc_Emp_Produto then
    begin
    Lc_SqlCriterio := Lc_SqlCriterio + '    INNER JOIN TB_PROD_FORN Tb_prod_forn ' ;
    Lc_SqlCriterio := Lc_SqlCriterio + '    ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) ';
    Lc_SqlCriterio := Lc_SqlCriterio + '    INNER JOIN  TB_EMPRESA Tb_fornecedor ';
    Lc_SqlCriterio := Lc_SqlCriterio + '    ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
    end;
  }
end;

function TRL_Venda_Item.SQLProdutoSemComposicao: String;
begin
  Result := concat(
              'SELECT ',
              '  PRO_DESCRICAO, ',
              '  SUM((ITF_VL_CUSTO * ITF_QTDE) - ITF_VL_DESC)  Custo_tl, ',
              '  SUM((ITF_VL_UNIT  * ITF_QTDE) - ITF_VL_DESC)  Preco_Tl, ',
              '  SUM(ITF_QTDE) Qtde_tl, ',
              '  suM((ITF_VL_UNIT*ITF_QTDE)-ITF_VL_DESC) Valor_tl ',
              'from TB_ITENS_NFL I ',
              '  inner join tb_pedido PD ',
              '  on (I.ITF_CODPED = PD.PED_CODIGO) ',
              '  INNER join tb_nota_fiscal NF ',
              '  on (NF.NFL_CODPED = PD.PED_CODIGO) ',
              '  INNER JOIN TB_PRODUTO PR ',
              '  ON (PR.PRO_CODIGO = I.ITF_CODPRO ) ',
              '  INNER JOIN TB_MARCA_PRODUTO MC ',
              '  ON (MC.mrc_codigo = PR.pro_codmrc) '
  );
  Result := concat(
              Result,
              SQlProdutoCriterios,
              ' and ( pro_composicao =1 ) ',
              'GROUP BY 1 '
  );
end;

function TRL_Venda_Item.SQlSomaTotal: String;
begin
  REsult := concat(
            'SELECT  suM((ITF_VL_UNIT*ITF_QTDE)-ITF_VL_DESC) TOTAL_VALOR ',
            'from TB_ITENS_NFL I ',
            '  inner join tb_pedido PD ',
            '  on (I.ITF_CODPED = PD.PED_CODIGO) ',
            '  INNER join tb_nota_fiscal NF ',
            '  on (NF.NFL_CODPED = PD.PED_CODIGO) ',
            '  INNER JOIN TB_PRODUTO PR ',
            '  ON (PR.PRO_CODIGO = I.ITF_CODPRO ) ',
            '  INNER JOIN TB_MARCA_PRODUTO MC ',
            '  ON (MC.mrc_codigo = PR.pro_codmrc) ',
            SQlProdutoCriterios
  );
end;

procedure TRL_Venda_Item.VerificaParametros;
begin
  with Fr_Imp_Produtos do
  Begin
    if ( Trim(  Fm_LME.Dblcb_Lista.Text) = '' ) then PrmMinhaEmpresa    := False  else  PrmMinhaEmpresa        := True;
    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) = '' then PrmEstoque    := False  else  PrmEstoque        := True;
    PrmPeriodo := ChBx_Periodo.Checked;
    PrmInternet := ChBx_InternetPublished.Checked;
    if DBLCB_Grupos.Text      ='' then  PrmGrupo    := False  else  PrmGrupo        := True;
    if DBLCB_SubGrupos.Text   ='' then  PrmSubGrupo := False  else  PrmSubGrupo     := True;
    if DBLCB_Marca.Text       ='' then  Prmmarca    := False  else  Prmmarca        := True;
    if E_BuscaCodigoProduto.Text   ='' then  PrmProduto  := False  else  PrmProduto      := True;
    if ((Rb_Empresa.Checked)  and (DBLCB_Empresa.Text <> '')) then  PrmEmpMovim    := True else PrmEmpMovim := False;
    if ((Rb_Produto.Checked)  and (DBLCB_Empresa.Text <> '')) then  PrmEmpProduto  := True else PrmEmpProduto := False;
    if dblcb_Vendedor.Text    = '' then PrmVendedor := False  else  PrmVendedor     := True;
  End;
end;

procedure TRL_Venda_Item.Pc_ParametrosVendas;
begin
  with Fr_Imp_Vendas do
    begin
    // Verifica qual localização cliente
    case RG_Tipo.ItemIndex of
    0 : Lb_Tipo_Rl.Caption := 'Pedidos';
    1 : Lb_Tipo_Rl.Caption := 'Notas';
    2 : Lb_Tipo_Rl.Caption := 'Todos';
    end;
    // Verifica data solicitada
    if ChBx_Periodo.Checked then
      Begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
      end
    else
      Begin
      Lb_Data_Ini.Caption := '';
      Lb_Data_Fim.Caption := '';
      end;
    // Verifica o nome da Cidade
    if Trim(DBLCB_Transportadora.text) = '' then
      Lb_Transportadora.Caption := 'Todos'
    else
      Lb_Transportadora.Caption := DBLCB_Transportadora.Text;
    // Verifica o tipo dO Relatorio
    case LBx_TipoRelatorio.ItemIndex of
      0 : Lb_Tipo.Caption := 'Venda';
      1 : Lb_Tipo.Caption := 'Venda Detalhada';
      2 : Lb_Tipo.Caption := 'Venda por Item';
      3 : Lb_Tipo.Caption := 'Consertos';
      4 : Lb_Tipo.Caption := 'Arquivo N.F.';
    end;
    // Verificar o nome do Vendedor
    if trim(DBLCB_Vendedor.Text) = '' then
      Lb_Vendedor.Caption := 'Todos'
    else
      Lb_Vendedor.Caption := DBLCB_Vendedor.Text;
  end;
end;

procedure TRL_Venda_Item.Pc_ParametrosProdutos;
begin
  with Fr_Imp_Produtos do
    begin
    // Verifica qual localização cliente
    Lb_Tipo_Rl.Caption := 'Todos';

    // Verifica data solicitada
    if ChBx_Periodo.Checked then
      Begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
      end
    else
      Begin
      Lb_Data_Ini.Caption := '';
      Lb_Data_Fim.Caption := '';
      end;
    // Verifica o nome da Cidade
    Lb_Transportadora.Caption := 'Todos';
    Lb_Tipo.Caption := 'Venda por Item';
    // Verificar o nome do Vendedor
    if trim(DBLCB_Vendedor.Text) = '' then
      Lb_Vendedor.Caption := 'Todos'
    else
      Lb_Vendedor.Caption := DBLCB_Vendedor.Text;
  end;
end;

procedure TRL_Venda_Item.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  ValorTotal := 0;
end;

procedure TRL_Venda_Item.QRBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_CustoMedio.Caption:= FloatToStrF(Qr_Vendas.FieldByName('CUSTO_TOTAL').AsCurrency/Qr_Vendas.FieldByName('TOTAL_QTD').AsFloat,ffNumber,18,2);
  E_PrecoMedio.Caption:= FloatToStrF(Qr_Vendas.FieldByName('PRECO_TOTAL').AsCurrency/Qr_Vendas.FieldByName('TOTAL_QTD').AsFloat,ffNumber,18,2);
  lbl_particip.Caption:= FloatToStrF(((Qr_Vendas.FieldByName('TOTAL_VALOR').AsCurrency/qr_soma  .FieldByName('TOTAL_VALOR').AsCurrency)*100),ffNumber,18,1);
  ValorTotal := ValorTotal + Qr_Vendas.FieldByName('TOTAL_VALOR').AsCurrency;
end;

procedure TRL_Venda_Item.QRBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_ValorTotal.Caption := FloatToStrF(ValorTotal,ffNumber,10,2)
end;

end.


