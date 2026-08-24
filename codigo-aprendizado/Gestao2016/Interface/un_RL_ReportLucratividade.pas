unit un_RL_ReportLucratividade;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, prmLucratividade, Un_DM, System.Math;

type
  TRL_ReportLucratividade = class(TRL_ReportList)
    Detalhe: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    FooterProduto: TQRBand;
    QRDBText1: TQRDBText;
    Lb_Vl_pis: TQRLabel;
    Lb_Vl_cofins: TQRLabel;
    Lb_Vl_Csocial: TQRLabel;
    Lb_Vl_Irpj: TQRLabel;
    Lb_Vl_Venda: TQRLabel;
    Lb_Vl_Comissao: TQRLabel;
    Lb_Vl_Custo: TQRLabel;
    Lb_Vl_Lucro: TQRLabel;
    LB_Aliq_Lcvtde: TQRLabel;
    Lb_Vl_Icms: TQRLabel;
    Grp_Produto: TQRGroup;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    Sumary: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Vl_tl_ICMS: TQRLabel;
    Lb_Vl_tl_Pis: TQRLabel;
    Lb_Vl_tl_Cofins: TQRLabel;
    Lb_Vl_tl_ContSocial: TQRLabel;
    Lb_Vl_tl_IRRF: TQRLabel;
    Lb_Vl_tl_Comissao: TQRLabel;
    Lb_Vl_tl_Custo: TQRLabel;
    Lb_Vl_tl_Venda: TQRLabel;
    Lb_Vl_tl_Lucro: TQRLabel;
    LB_Aliq_Tl_Lcvtde: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Vl_tl_Frete: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Vl_tl_sT: TQRLabel;
    QRLabel25: TQRLabel;
    Lb_Vl_tl_Outras: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    CONTSOCIAL: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Vl_tl_Seguro: TQRLabel;
    QRLabel27: TQRLabel;
    Lb_Vl_tl_faturamento: TQRLabel;
    procedure DetalheBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FooterProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SumaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
  protected
    TipoCalculo : String;
    ValorProdutoCom : Real;
    ValorProdutoSem : Real;
    ValorICMS : Real;
    QuantidadeProdutoCom : Real;
    QuantidadeProdutoSem : Real;

    ValorPis : Real;
    ValorCofins : Real;
    ValorCSocial : Real;
    ValorIRPJ : Real;
    ValorComissao : Real;
    ValorCusto : Real;
    ValorVendaItens : Real;
    ValorLucro : Real;
    AliqLucratividadeProduto:Real;

    ValorTotalICMS : Real;
    ValorTotalPis : Real;
    ValorTotalCofins : Real;
    ValorTotalCSocial : Real;
    ValorTotalIRPJ : Real;
    ValorTotalComissao : Real;
    ValorTotalCusto : Real;
    ValorTotalFrete : Real;
    ValorTotalOutras : Real;
    ValorTotalSeguro : Real;
    ValorTotalVendaItens : Real;
    ValortotalFaturamento : Real;
    ValorTotalLucro:Real ;
    AliqLucratividadeTotal:Real;

    ValorTotal : Real;
    procedure CalculoDetalhe;
    procedure PreencheDetalhe;
    procedure ZerarVariaveisDetalhe;
    procedure ZerarVariaveisGeral;

    procedure CalcularSumario;
    procedure PreencherSumario;

    function getValorFrete:Real;Virtual;
    function getValorOutrasDespesas:Real;Virtual;
    function getValorSeguros:Real;Virtual;

    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSqlCustomized;Virtual;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros;Override;
    procedure RePassarParametros(Qry:TSTQuery);

  public
    { Public declarations }
    MostraCusto : Boolean;
    Parametros : TParamLucratividade;
  end;

var
  RL_ReportLucratividade: TRL_ReportLucratividade;

implementation

{$R *.dfm}

uses     UN_Sistema;
procedure TRL_ReportLucratividade.CalcularSumario;
begin
  //ValorTotalICMS : Real;
  //ValorTotalPis : Real;
  //ValorTotalCofins : Real;
  //ValorTotalCSocial : Real;
  //ValorTotalIRPJ : Real;
  //ValorTotalComissao : Real;
  //ValorTotalCusto : Real;
  ValorTotalFrete := getValorFrete;
  ValorTotalOutras := getValorOutrasDespesas;
  ValorTotalSeguro := getValorSeguros;
  ValortotalFaturamento := ValorTotalVendaItens + ValorTotalFrete + ValorTotalOutras + ValorTotalSeguro;
  //ValorTotalLucro:Real ;
  if ( TipoCalculo = 'C' ) then
  BEGIN
    IF ValorTotalCusto > 0 THEN
      AliqLucratividadeTotal := (ValorTotalLucro / ValorTotalCusto)*100
    ELSE
      AliqLucratividadeTotal := (ValorTotalLucro / 1)*100;
  END
  else
  BEGIN
    IF ValorTotalVendaItens > 0 THEN
      AliqLucratividadeTotal := (ValorTotalLucro / ValorTotalVendaItens)*100
    ELSE
      AliqLucratividadeTotal := (ValorTotalLucro / 1)*100;
  END;

end;

procedure TRL_ReportLucratividade.CalculoDetalhe;
Var
  Lc_Vl_Imposto : Real;
begin
  ValorVendaItens            := (ValorProdutoCom + ValorProdutoSem);

  if (ValorICMS > 0) then
  Begin
    ValorTotalICMS        := ValorTotalICMS + ValorICMS
  End
  else
  Begin
    ValorICMS       := ValorProdutoCom * (DM.Qr_Impostos.FieldByname('IPT_ICMS').AsCurrency/100);
    ValorICMS       := RoundTo(ValorICMS,-2);
    ValorTotalICMS  := ValorTotalICMS + ValorICMS;
  End;

  ValorPis          := ValorProdutoCom * (DM.Qr_Impostos.FieldByname('IPT_PIS').AsCurrency/100);
  ValorPis          := RoundTo(ValorPis, -2);

  ValorCofins           := ValorProdutoCom * (DM.Qr_Impostos.FieldByname('IPT_COFINS').AsCurrency/100);
  ValorCofins           := RoundTo(ValorCofins, -2);

  ValorCSocial          := ValorProdutoCom * (DM.Qr_Impostos.FieldByname('IPT_CONT_SOCIAL').asFloat/100);
  ValorCSocial          := RoundTo(ValorCSocial, -2);

  ValorIRPJ           := ValorProdutoCom * (DM.Qr_Impostos.FieldByname('IPT_IRPJ').asFloat/100);
  ValorIRPJ           := RoundTo(ValorIRPJ, -2);

  Lc_Vl_Imposto :=  ValorICMS + ValorPis + ValorCofins + ValorCsocial + ValorIRPJ;

  ValorLucro  := ValorVendaItens - (Lc_Vl_Imposto + ValorComissao + ValorCusto);

  if ValorVendaITens = 0 then ValorVendaItens := 1;

  if ( TipoCalculo = 'C' ) then
  BEGIN
    IF ValorCusto > 0 THEN
      AliqLucratividadeProduto := (ValorLucro / ValorCusto)*100
    ELSE
      AliqLucratividadeProduto := (ValorLucro / 1)*100;
  END
  else
  BEGIN
    IF ValorVendaItens > 0 THEN
      AliqLucratividadeProduto := (ValorLucro / ValorVendaItens)*100
    ELSE
      AliqLucratividadeProduto := (ValorLucro / 1)*100;
  END;

  ValorTotalPis           := ValorTotalPis        + ValorPis;
  ValorTotalCofins        := ValorTotalCofins     + ValorCofins;
  ValorTotalCSocial       := ValorTotalCSocial    + ValorCSocial;
  ValorTotalIRPJ          := ValorTotalIRPJ       + ValorIRPJ;
  ValorTotalComissao      := ValorTotalComissao   + ValorComissao;
  ValorTotalCusto         := ValorTotalCusto      + ValorCUSTO;
  ValorTotalVendaItens    := ValorTotalVendaItens + ValorVendaItens;
  ValorTotalLucro         := ValorTotalLucro      + ValorLucro;
end;

procedure TRL_ReportLucratividade.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Venda_Item : Real;
begin
  with Qr_consulta do
  Begin
    Lc_Venda_Item := (FieldByName('LVD_VL_UNIT').AsCurrency  * FieldByName('LVD_QTDE').AsFloat) - FieldByName('LVD_VL_DESC').AsCurrency;
    Lc_Venda_Item :=  RoundTo(Lc_Venda_Item, -2);
    if FieldByName('LVD_NOTA').AsString<>'' then
    begin // � Nota
      ValorProdutoCom   := ValorProdutoCom   + Lc_Venda_Item;
      ValorComissao := ValorComissao + (Lc_Venda_Item * (FieldByName('LVD_ALIQ_COM').AsFloat/100));
      ValorCUSTO    := ValorCUSTO    + (FieldByName('LVD_QTDE').AsFloat   * FieldByName('LVD_VL_CUSTOREAL').AsCurrency);
      //verifica o calculo do ICMS
      ValorICMS     := FieldByName('LVD_ICMS').AsCurrency;
      //Caso não tenha icms no valor nas vendas e queira fazer um previa do imposto
      if (ValorICMS = 0) and (DM.Qr_Impostos.FieldByname('IPT_ICMS').AsCurrency >0) then
      Begin
        ValorICMS := ValorProdutoCom * (DM.Qr_Impostos.FieldByname('IPT_ICMS').AsCurrency/100);
        ValorICMS := RoundTo(ValorICMS,-2);
      End;

    end
    else
    Begin //Não � Nota
      ValorProdutoSem := ValorProdutoSem  + Lc_Venda_Item;
      ValorComissao   := ValorComissao + (Lc_Venda_Item * (FieldByName('LVD_ALIQ_COM').AsFloat/100));
      ValorCUSTO      := ValorCUSTO    + (FieldByName('LVD_QTDE').AsFloat   * FieldByName('LVD_VL_CUSTOREAL').AsCurrency);
    end;
  end;
end;

procedure TRL_ReportLucratividade.FooterProdutoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  CalculoDetalhe;
  PreencheDetalhe;
  ZerarVariaveisDetalhe;
end;

function TRL_ReportLucratividade.getValorFrete: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.add('SELECT SUM(VALOR) VALOR FROM ( ');
        SQL.Add(concat(
                  'select sum(ped_vl_frete) VALOR ',
                  'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
                  '  INNER JOIN TB_EMPRESA tb_cliente ',
                  '   ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
                  '   INNER JOIN TB_PEDIDO tb_pedido ',
                  '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
                  '   INNER JOIN TB_COLABORADOR ',
                  '   ON (CLB_CODIGO = PED_CODVDO) ',
                  '   INNER JOIN tb_endereco tb_endereco ',
                  '   ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '
          ));
        //Limpa algunas variaves da Consulta primaria
        //Parametros.TipoItem := '';
        WhereSqlCustomized;
        //define o frete para pedidos
        SQL.Add(WhereTxt + ' AND ( ( NFL_NUMERO =  '''') or  (NFL_NUMERO is null    ) ) ');

        SQL.Add(concat(
                    ' Union ',
                    'SELECT  sum(ICMS.icm_vl_frete) valor ',
                    'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
                    '  INNER JOIN TB_EMPRESA tb_cliente    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
                    '  INNER JOIN TB_PEDIDO tb_pedido    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
                    '  INNER JOIN tb_itens_nfl    ON (ITF_CODPED = PED_CODIGO) ',
                    '  INNER JOIN TB_PRODUTO    ON (PRO_CODIGO = ITF_CODPRO) ',
                    '  INNER JOIN tb_medida    ON (MED_CODIGO = PRO_CODMED) ',
                    '  INNER JOIN TB_MARCA_PRODUTO    ON (MRC_CODIGO = PRO_CODMRC) ',
                    '  INNER JOIN TB_COLABORADOR    ON (CLB_CODIGO = PED_CODVDO) ',
                    '  LEFT OUTER JOIN tb_itens_icms ICMS    ON (ICM_CODITF = ITF_CODIGO) ',
                    '  LEFT OUTER JOIN tb_itens_ipi IPI    ON (IPI.ipi_coditf = ITF_CODIGO) ',
                    '  INNER JOIN tb_endereco tb_endereco    ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '
          ));

        SQL.Add(WhereTxt + ' AND ( ( NFL_NUMERO <> '''') and (NFL_NUMERO is not null) ) ');
      SQL.Add(')');

      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;
end;

function TRL_ReportLucratividade.getValorOutrasDespesas: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.add('SELECT SUM(VALOR) VALOR FROM ( ');
        SQL.Add(concat(
                  'select sum(nfl_vl_desp_acess) VALOR ',
                  'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
                  '  INNER JOIN TB_EMPRESA tb_cliente ',
                  '   ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
                  '   INNER JOIN TB_PEDIDO tb_pedido ',
                  '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
                  '   INNER JOIN TB_COLABORADOR ',
                  '   ON (CLB_CODIGO = PED_CODVDO) ',
                  '   INNER JOIN tb_endereco tb_endereco ',
                  '   ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '
          ));
        //Limpa algunas variaves da Consulta primaria
        //Parametros.TipoItem := '';
        WhereSqlCustomized;
        //define o frete para pedidos
        SQL.Add(WhereTxt + ' AND ( ( NFL_NUMERO =  '''') or  (NFL_NUMERO is null    ) ) ');

        SQL.Add(concat(
                    ' Union ',
                    'SELECT  sum(ICMS.icm_vl_outras) valor ',
                    'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
                    '  INNER JOIN TB_EMPRESA tb_cliente    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
                    '  INNER JOIN TB_PEDIDO tb_pedido    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
                    '  INNER JOIN tb_itens_nfl    ON (ITF_CODPED = PED_CODIGO) ',
                    '  INNER JOIN TB_PRODUTO    ON (PRO_CODIGO = ITF_CODPRO) ',
                    '  INNER JOIN tb_medida    ON (MED_CODIGO = PRO_CODMED) ',
                    '  INNER JOIN TB_MARCA_PRODUTO    ON (MRC_CODIGO = PRO_CODMRC) ',
                    '  INNER JOIN TB_COLABORADOR    ON (CLB_CODIGO = PED_CODVDO) ',
                    '  LEFT OUTER JOIN tb_itens_icms ICMS    ON (ICM_CODITF = ITF_CODIGO) ',
                    '  LEFT OUTER JOIN tb_itens_ipi IPI    ON (IPI.ipi_coditf = ITF_CODIGO) ',
                    '  INNER JOIN tb_endereco tb_endereco    ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '
          ));

        SQL.Add(WhereTxt + ' AND ( ( NFL_NUMERO <> '''') and (NFL_NUMERO is not null) ) ');
      SQL.Add(')');

      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;

end;

function TRL_ReportLucratividade.getValorSeguros: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.add('SELECT SUM(VALOR) VALOR FROM ( ');
        SQL.Add(concat(
                  'select sum(nfl_vl_seguro) VALOR ',
                  'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
                  '  INNER JOIN TB_EMPRESA tb_cliente ',
                  '   ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
                  '   INNER JOIN TB_PEDIDO tb_pedido ',
                  '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
                  '   INNER JOIN TB_COLABORADOR ',
                  '   ON (CLB_CODIGO = PED_CODVDO) ',
                  '   INNER JOIN tb_endereco tb_endereco ',
                  '   ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '
          ));
        //Limpa algunas variaves da Consulta primaria
        //Parametros.TipoItem := '';
        WhereSqlCustomized;
        //define o frete para pedidos
        SQL.Add(WhereTxt + ' AND ( ( NFL_NUMERO =  '''') or  (NFL_NUMERO is null    ) ) ');

        SQL.Add(concat(
                    ' Union ',
                    'SELECT  sum(ICMS.icm_vl_seguro) valor ',
                    'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
                    '  INNER JOIN TB_EMPRESA tb_cliente    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
                    '  INNER JOIN TB_PEDIDO tb_pedido    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
                    '  INNER JOIN tb_itens_nfl    ON (ITF_CODPED = PED_CODIGO) ',
                    '  INNER JOIN TB_PRODUTO    ON (PRO_CODIGO = ITF_CODPRO) ',
                    '  INNER JOIN tb_medida    ON (MED_CODIGO = PRO_CODMED) ',
                    '  INNER JOIN TB_MARCA_PRODUTO    ON (MRC_CODIGO = PRO_CODMRC) ',
                    '  INNER JOIN TB_COLABORADOR    ON (CLB_CODIGO = PED_CODVDO) ',
                    '  LEFT OUTER JOIN tb_itens_icms ICMS    ON (ICM_CODITF = ITF_CODIGO) ',
                    '  LEFT OUTER JOIN tb_itens_ipi IPI    ON (IPI.ipi_coditf = ITF_CODIGO) ',
                    '  INNER JOIN tb_endereco tb_endereco    ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '
          ));

        SQL.Add(WhereTxt + ' AND ( ( NFL_NUMERO <> '''') and (NFL_NUMERO is not null) ) ');
      SQL.Add(')');

      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;


end;

procedure TRL_ReportLucratividade.IniciaVariaveis;
begin
  inherited;
  TipoCalculo := Fc_Tb_Geral('L','VDA_G_CALC_LCVDADE','');
  ZerarVariaveisGeral;
  ZerarVariaveisDetalhe;
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
  DM.Qr_Impostos.Active:=True;
end;

procedure TRL_ReportLucratividade.InnerJoinSql;
begin
  inherited;
  //InnerJoinTxt : String;
  InnerJoinTxt := concat(
          '    INNER JOIN TB_ITENS_NFL tb_itens_nfl ',
          '    ON  (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) ',
          '    INNER JOIN TB_EMPRESA tb_empresa ',
          '    ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) ',
          '    INNER JOIN TB_PRODUTO tb_produto ',
          '    ON  (tb_produto.pro_codigo = tb_itens_nfl.itf_codpro) '
  );
  if Parametros.CodigoGrupo > 0 then
  begin
    InnerJoinTxt := concat(
                    InnerJoinTxt,
                    '    INNER JOIN TB_GRUPOS Tb_grupos ',
                    '    ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '
    );
  end;

  if Parametros.CodigoSubGrupo > 0 then
  begin
    InnerJoinTxt := concat(
                    InnerJoinTxt,
                    '    INNER JOIN TB_SUBGRUPOS Tb_subgrupos ',
                    '    ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) '
    );
  end;

  if Parametros.CodigoMarca > 0 then
  begin
    InnerJoinTxt := concat(
                    InnerJoinTxt,
                    '    INNER JOIN TB_MARCA_PRODUTO tb_marcaproduto ',
                    '    ON  (tb_marcaproduto.MRC_CODIGO = tb_produto.PRO_CODMRC) '
    );
  end;

  InnerJoinTxt := concat(
                    InnerJoinTxt,
                    '    INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal ',
                    '    ON (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO) ',
                    '    LEFT OUTER JOIN TB_ITENS_ICMS ',
                    '    ON (ICM_CODITF = ITF_CODIGO) '                    
  );
end;

procedure TRL_ReportLucratividade.OrderBy;
begin
  inherited;
  OrderByTxt := ' ORDER BY PRO_DESCRICAO ';
end;

procedure TRL_ReportLucratividade.PassarParametros;
begin
  RePassarParametros(Qr_Consulta);
end;

procedure TRL_ReportLucratividade.PreencheDetalhe;
begin
  Lb_Vl_Venda.Caption     := FloatToStrF( ValorVendaItens ,ffNumber,10,2);
  Lb_Vl_Icms.Caption      := FloatToStrF( ValorICMS ,ffNumber,10,2);
  Lb_Vl_pis.Caption       := FloatToStrF( ValorPis ,ffNumber,10,2);
  Lb_Vl_cofins.Caption    := FloatToStrF( ValorCofins ,ffNumber,10,2);
  Lb_Vl_Csocial.Caption   := FloatToStrF( ValorCSocial ,ffNumber,10,2);
  Lb_Vl_Irpj.Caption      := FloatToStrF( ValorIRPJ ,ffNumber,10,2);
  Lb_Vl_Comissao.Caption  := FloatToStrF( ValorComissao ,ffNumber,10,2);
  Lb_Vl_Custo.Caption     := FloatToStrF( ValorCusto ,ffNumber,10,2);
  Lb_Vl_Lucro.Caption     := FloatToStrF( ValorLucro ,ffNumber,10,2);
  LB_Aliq_Lcvtde.Caption  := FloatToStrF( AliqLucratividadeProduto ,ffNumber,10,2)
end;


procedure TRL_ReportLucratividade.PreencherSumario;
begin
  Lb_Vl_tl_ICMS.Caption       := FloatToStrF( ValorTotalICMS,ffNumber,10,2);
  Lb_Vl_tl_Pis.Caption        := FloatToStrF( ValorTotalPis,ffNumber,10,2);
  Lb_Vl_tl_Cofins.Caption     := FloatToStrF( ValorTotalCofins,ffNumber,10,2);
  Lb_Vl_tl_ContSocial.Caption := FloatToStrF( ValorTotalCSocial,ffNumber,10,2);
  Lb_Vl_tl_IRRF.Caption       := FloatToStrF( ValorTotalIRPJ,ffNumber,10,2);

  Lb_Vl_tl_Comissao.Caption     := FloatToStrF( ValorTotalComissao,ffNumber,10,2);
  Lb_Vl_tl_Frete.Caption        := FloatToStrF( ValorTotalFrete,ffNumber,10,2);
  Lb_Vl_tl_Outras.Caption       := FloatToStrF( ValorTotalOutras,ffNumber,10,2);
  Lb_Vl_tl_Seguro.Caption       := FloatToStrF( ValorTotalSeguro,ffNumber,10,2);
  Lb_Vl_tl_faturamento.Caption  := FloatToStrF( ValortotalFaturamento,ffNumber,10,2);


  Lb_Vl_tl_Custo.Caption      := FloatToStrF( ValorTotalCusto,ffNumber,10,2);
  Lb_Vl_tl_Venda.Caption      := FloatToStrF( ValorTotalVendaItens,ffNumber,10,2);
  Lb_Vl_tl_Lucro.Caption      := FloatToStrF( ValorTotalLucro,ffNumber,10,2);
  LB_Aliq_Tl_Lcvtde.Caption   := FloatToStrF( AliqLucratividadeTotal,ffNumber,10,2);
end;

procedure TRL_ReportLucratividade.RePassarParametros(Qry: TSTQuery);
begin
  with Qry,Parametros do
  Begin
    If (NumeroDocumento <> '') then
    Begin
      ParamByName('NFL_NUMERO').AsString := NumeroDocumento;
    end
    else
    Begin
      if Periodo then
      begin
        ParamByName('DATAINI').AsDate:= DataInicial;
        ParamByName('DATAFIM').AsDate:= DataFinal;
      end;
      If (CodigoCliente > 0)  then
        ParamByName('NFL_CODEMP').AsInteger := CodigoCliente;
    end;
    if (CodigoEstabelecimento > 0) then
      ParamByName('NFL_CODMHA').AsInteger:= CodigoEstabelecimento;

    if (VendedorCliente > 0) then
      ParamByName('EMP_CODVDOR').AsInteger:= VendedorCliente;

    if (VendedorPedido > 0) then
      ParamByName('PED_CODVDO').AsInteger:= VendedorPedido;

    if CodigoGrupo > 0     then
      ParamByName('PRO_CODGRP').AsInteger:= CodigoGrupo;
    if CodigoSubGrupo > 0  then
      ParamByName('PRO_CODSBG').AsInteger:= CodigoSubGrupo;
    if Codigomarca > 0     then
      ParamByName('PRO_CODMRC').AsInteger:= CodigoMarca;
    if Length(Trim(DescricaoProduto)) > 0   then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(DescricaoProduto,1,98)+ '%';
  end;
end;

procedure TRL_ReportLucratividade.SelectSql;
begin
  inherited;
  // SelectTxt : String;
  SelectTxt := Concat(
              'SELECT  ''N'' LVD_SITUACAO, NFL_CODMHA LVD_CODMHA, PED_CODIGO LVD_CODIGO, ',
              ' '''' LVD_COTACAO,PED_NUMERO LVD_PEDIDO, NFL_DT_EMISSAO LVD_DT_EMISSAO, ',
              ' NFL_NUMERO LVD_NOTA, EMP_CODIGO LVD_CODCLI, EMP_NOME LVD_CLIENTE, ',
              ' ITF_CODPRO LVD_CODPRO, PRO_DESCRICAO LVD_PRODUTO, '+
              ' ITF_QTDE LVD_QTDE,ITF_VL_UNIT LVD_VL_UNIT, ITF_AQ_IPI LVD_ALIQ_IPI, ',
              ' ITF_AQ_COM LVD_ALIQ_COM, ITF_VL_CUSTO LVD_VL_CUSTOREAL, ',
              ' ITF_VL_DESC LVD_VL_DESC, (ICM_VL_NR + ICM_VL_ST) LVD_ICMS ',
              ' FROM TB_PEDIDO tb_pedido '
  );
end;

procedure TRL_ReportLucratividade.SumaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  CalcularSumario;
  PreencherSumario;
end;


procedure TRL_ReportLucratividade.WhereSql;
begin
  WhereSqlCustomized;
  WhereTxt := concat(
                WhereTxt,
                ' AND (ITF_SENTIDO = ''S'') '
  );
end;

procedure TRL_ReportLucratividade.WhereSqlCustomized;
begin
  with  Parametros do
  Begin
    //WhereTxt : String;
    WhereTxt := concat(
                  'WHERE (PED_TIPO = ''1'') ',
                  ' AND (NFL_STATUS = ''F'') '
    );

    if VendedorCliente >0 then
    WhereTxt := concat(
                   WhereTxt,
                   ' AND (EMP_CODVDOR =:EMP_CODVDOR)'
    );

    if Parametros.VendedorPedido >0 then
    WhereTxt := concat(
                   WhereTxt,
                  ' AND (PED_CODVDO =:PED_CODVDO)'
    );

    //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
    //Lc_Aux := Trim(Fc_codigosNegocio);

    if NumeroDocumento <> '' then
    Begin
      WhereTxt := concat(
                   WhereTxt,
                   ' AND ( (PED_NUMERO =:NFL_NUMERO) OR (NFL_NUMERO =:NFL_NUMERO) )'
      );
    End
    else
    Begin
      if Periodo then
        WhereTxt := concat(
                     WhereTxt,
                     ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '
        );
      if CodigoCliente > 0 then
        WhereTxt := concat(
                     WhereTxt,
                      'AND (NFL_CODEMP=:NFL_CODEMP) '
        );

    End;

    if CodigoEstabelecimento >0 then
      WhereTxt := concat(
                   WhereTxt,
                   'AND (NFL_CODMHA=:NFL_CODMHA) '
      );

    if CodigoGrupo >0 then
      WhereTxt := concat(
                   WhereTxt,
                   'AND (PRO_CODGRP =:PRO_CODGRP) '
      );

    if CodigoSubGrupo >0 then
      WhereTxt := concat(
                   WhereTxt,
                   'AND (PRO_CODSBG =:PRO_CODSBG) '
      );

    if CodigoSubGrupo >0 then
      WhereTxt := concat(
                   WhereTxt,
                   'AND (PRO_CODMRC =:PRO_CODMRC) '
      );

    if Length(Trim(DescricaoProduto)) > 0   then
      WhereTxt := concat(
                   WhereTxt,
                   'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) '
      );
  End;

end;

procedure TRL_ReportLucratividade.ZerarVariaveisDetalhe;
begin
  ValorProdutoCom          := 0;
  ValorProdutoSem          := 0;
  ValorICMS                := 0;
  QuantidadeProdutoCom     := 0;
  QuantidadeProdutoSem     := 0;
  ValorPis                 := 0;
  ValorCofins              := 0;
  ValorCSocial             := 0;
  ValorIRPJ                := 0;
  ValorComissao            := 0;
  ValorCusto               := 0;
  ValorVendaItens          := 0;
  ValorLucro               := 0;
  AliqLucratividadeProduto := 0;
end;

procedure TRL_ReportLucratividade.ZerarVariaveisGeral;
begin
  ValorTotalICMS         := 0;
  ValorTotalPis          := 0;
  ValorTotalCofins       := 0;
  ValorTotalCSocial      := 0;
  ValorTotalIRPJ         := 0;
  ValorTotalComissao     := 0;
  ValorTotalCusto        := 0;
  ValorTotalFrete        := 0;
  ValorTotalOutras       := 0;
  ValorTotalSeguro       := 0;
  ValorTotalVendaItens   := 0;
  ValortotalFaturamento  := 0;
  ValorTotalLucro        := 0;
  AliqLucratividadeTotal := 0;
end;

end.
