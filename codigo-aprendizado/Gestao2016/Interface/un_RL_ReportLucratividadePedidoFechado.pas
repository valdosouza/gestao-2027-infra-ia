unit un_RL_ReportLucratividadePedidoFechado;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_RL_ReportLucratividade, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportLucratividadePedidoFechado = class(TRL_ReportLucratividade)
  private
  protected
    function getValorFrete:Real;Override;
    function getValorOutrasDespesas:Real;Override;
    function getValorSeguros:Real;Override;

    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSqlCustomized;Override;
    procedure WhereSql;Override;
    procedure PassarParametros;Override;
    procedure RePassarParametros(Qry:TSTQuery);

  public
    { Public declarations }
  end;

var
  RL_ReportLucratividadePedidoFechado: TRL_ReportLucratividadePedidoFechado;

implementation

{$R *.dfm}

{ TRL_ReportLucratividadePedidoFechado }

function TRL_ReportLucratividadePedidoFechado.getValorFrete: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.Add(concat(
                'select sum(ped_vl_frete) VALOR ',
                'FROM TB_PEDIDO p ',
                '  INNER JOIN TB_NOTA_FISCAL n ',
                '  ON (n.NFL_CODPED = p.PED_CODIGO) ',
                '  INNER JOIN TB_EMPRESA c ',
                '  ON (c.EMP_CODIGO = p.PED_CODEMP) ',
                '  INNER JOIN TB_COLABORADOR ',
                '  ON (CLB_CODIGO = PED_CODVDO) ',
                '  INNER JOIN tb_endereco tb_endereco ',
                '  ON (tb_endereco.end_codigo = P.ped_codend) '
      ));
        //Limpa algunas variaves da Consulta primaria
        //Parametros.TipoItem := '';
      WhereSqlCustomized;
      SQL.Add(WhereTxt);
      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;

end;

function TRL_ReportLucratividadePedidoFechado.getValorOutrasDespesas: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.Add(concat(
                'select sum(PED_VL_ODESPESA) VALOR ',
                'FROM TB_PEDIDO p ',
                '  INNER JOIN TB_NOTA_FISCAL n ',
                '  ON (n.NFL_CODPED = p.PED_CODIGO) ',
                '  INNER JOIN TB_EMPRESA c ',
                '   ON (c.EMP_CODIGO = p.PED_CODEMP) ',
                '   INNER JOIN TB_COLABORADOR ',
                '   ON (CLB_CODIGO = PED_CODVDO) ',
                '   INNER JOIN tb_endereco tb_endereco ',
                '   ON (tb_endereco.end_codigo = P.ped_codend) '
      ));
        //Limpa algunas variaves da Consulta primaria
        //Parametros.TipoItem := '';
      WhereSqlCustomized;
      SQL.Add(WhereTxt);
      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;
end;

function TRL_ReportLucratividadePedidoFechado.getValorSeguros: Real;
begin
  Result := 0;
end;

procedure TRL_ReportLucratividadePedidoFechado.InnerJoinSql;
begin
  inherited;
  //InnerJoinTxt : String;
  InnerJoinTxt := concat(
    '    INNER JOIN TB_ITENS_NFL tb_itens_nfl ',
    '    ON  (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO) ',
    '    INNER JOIN TB_EMPRESA tb_empresa ',
    '    ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) ',
    '    INNER JOIN TB_PRODUTO tb_produto ',
    '    ON  (tb_produto.pro_codigo = tb_itens_nfl.itf_codpro) ',
    '    INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal ',
    '    ON (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO) '
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

end;


procedure TRL_ReportLucratividadePedidoFechado.PassarParametros;
begin
  RePassarParametros(Qr_Consulta);
end;

procedure TRL_ReportLucratividadePedidoFechado.RePassarParametros(
  Qry: TSTQuery);
begin
  with Qry,Parametros do
  Begin
    If (NumeroDocumento <> '') then
    Begin
      ParamByName('PED_NUMERO').AsString := NumeroDocumento;
    end
    else
    Begin
      if Periodo then
      begin
        ParamByName('DATAINI').AsDate:= DataInicial;
        ParamByName('DATAFIM').AsDate:= DataFinal;
      end;
      If (CodigoCliente > 0)  then
        ParamByName('PED_CODEMP').AsInteger := CodigoCliente;
    end;
    if (CodigoEstabelecimento > 0) then
      ParamByName('PED_CODMHA').AsInteger:= CodigoEstabelecimento;

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

procedure TRL_ReportLucratividadePedidoFechado.SelectSql;
begin
  inherited;
  // SelectTxt : String;
  SelectTxt := Concat(
    'SELECT ''N'' LVD_SITUACAO, NFL_CODMHA LVD_CODMHA, PED_CODIGO LVD_CODIGO, '''' LVD_COTACAO,PED_NUMERO LVD_PEDIDO, NFL_DT_EMISSAO LVD_DT_EMISSAO, NFL_NUMERO LVD_NOTA, ',
    '                EMP_CODIGO LVD_CODCLI, EMP_NOME LVD_CLIENTE,ITF_CODPRO LVD_CODPRO, PRO_DESCRICAO LVD_PRODUTO, ',
    '                ITF_QTDE LVD_QTDE,ITF_VL_UNIT LVD_VL_UNIT, ITF_AQ_IPI LVD_ALIQ_IPI, ITF_AQ_COM LVD_ALIQ_COM, ITF_VL_CUSTO LVD_VL_CUSTOREAL, ITF_VL_DESC LVD_VL_DESC ',
    ',(0) LVD_ICMS ',
    ' FROM TB_PEDIDO tb_pedido '
  );
end;

procedure TRL_ReportLucratividadePedidoFechado.WhereSql;
begin
  WhereSqlCustomized;
  WhereTxt := concat(
                WhereTxt,
                ' AND (ITF_SENTIDO = ''S'') '
  );
end;

procedure TRL_ReportLucratividadePedidoFechado.WhereSqlCustomized;
begin
  with  Parametros do
  Begin
    //WhereTxt : String;
    WhereTxt := concat(
                  'WHERE (PED_TIPO = ''1'') ',
                  ' AND (NFL_STATUS = ''F'') ',
                  ' and ( (NFL_NUMERO = '''') or (NFL_NUMERO is null) ) '
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
                   ' AND ( PED_NUMERO =:PED_NUMERO ) '
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
                      'AND (PED_CODEMP =:PED_CODEMP) '
        );

    End;

    if CodigoEstabelecimento >0 then
      WhereTxt := concat(
                   WhereTxt,
                   'AND (PED_CODMHA=:PED_CODMHA) '
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

end.
