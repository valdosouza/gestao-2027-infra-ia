unit Un_RL_ReportVendas;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, prmVendas, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, UN_Principal, env;

type
  TRL_ReportVendas = class(TRL_ReportList)
  private
    { Private declarations }
  protected
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros;Override;
    procedure RePassarParametros(Qry:TSTQuery);
    procedure PreencherGrupo;Virtual;
    procedure PreencherDetalhe;Virtual;

    function getValorFrete:Real;
    function getValorOutrasDespesas:Real;
    function getValorSeguros:Real;
  public
    { Public declarations }
    MostraCusto : Boolean;
    Parametros : TParamVendas;
  end;

var
  RL_ReportVendas: TRL_ReportVendas;

implementation

{$R *.dfm}

uses     ControllerGeral, UN_Sistema, Un_DM;
procedure TRL_ReportVendas.SelectSql;
begin
  SelectTxt :=
  Concat('SELECT DISTINCT NFL_CODIGO,NFL_DT_EMISSAO, PED_NUMERO, NFL_NUMERO, ',
         'tb_cliente.EMP_NOME, tb_cliente.EMP_CNPJ, NFL_VL_TL_NOTA, ',
         'PRO_CODIGOFAB, PRO_DESCRICAO, ITF_QTDE, ITF_VL_UNIT, ',
         'ITF_VL_DESC, ITF_CODIGO,ITF_CODNFL,ITF_CODPRO MED_ABREVIATURA, ',
         'ITF_AQ_COM, (ITF_VL_CUSTO * ITF_QTDE) AS NFL_VL_CUSTO,  ',
         'ICMS.icm_vl_nr, ICMS.icm_vl_st, ICMS.icm_vl_frete,ICMS.icm_vl_outras, ',
         'IPI.ipi_vl_bc, IPI.ipi_aq_nr, IPI.ipi_vl_unid, ',
         ' ((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) ITF_SUBTOTAL, ',
         ' MRC_DESCRICAO, CLB_NOME, ITF_VL_CUSTO, PED_OBS ',
         'FROM TB_NOTA_FISCAL tb_nota_fiscal ');
end;

function TRL_ReportVendas.GetValorFrete: Real;
Var
  LcQry : TSTQuery;
  LcGeral : TControllerGeral;
begin
  Try
    LcGeral := TControllerGeral.Create(nil);
    LcQry := LcGeral.GeraQuery;
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
        Parametros.TipoItem := '';
        WhereSql;
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
    LcGeral.FinalizaQuery(LcQry);
    FreeAndNil(LcGeral);
  End;
end;

function TRL_ReportVendas.getValorOutrasDespesas: Real;
Var
  LcQry : TSTQuery;
  LcGeral : TControllerGeral;
begin
  Try
    LcGeral := TControllerGeral.Create(nil);
    LcQry := LcGeral.GeraQuery;
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
        Parametros.TipoItem := '';
        WhereSql;
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
    LcGeral.FinalizaQuery(LcQry);
    FreeAndNil(LcGeral);
  End;

end;

function TRL_ReportVendas.getValorSeguros: Real;
Var
  LcQry : TSTQuery;
  LcGeral : TControllerGeral;
begin
  Try
    LcGeral := TControllerGeral.Create(nil);
    LcQry := LcGeral.GeraQuery;
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
        Parametros.TipoItem := '';
        WhereSql;
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
    LcGeral.FinalizaQuery(LcQry);
    FreeAndNil(LcGeral);
  End;

end;

procedure TRL_ReportVendas.IniciaVariaveis;
Var
  Geral : TControllerGeral;
begin
  inherited;
  Try
    Geral := TControllerGeral.Create(nil);
    Geral.Registro.CodigoEstabelecimento := Gb_CodMha;
    Geral.Registro.Campo := 'VDA_CUSTO_REL_VDA';
    Geral.getById;
    MostraCusto := (Geral.Registro.Conteudo = 'S');

  Finally
    FreeAndNil(Geral);
  End;
end;

procedure TRL_ReportVendas.InnerJoinSql;
begin
  InnerJoinTxt :=
  concat('  INNER JOIN TB_EMPRESA tb_cliente ',
         '   ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ',
         '   INNER JOIN TB_PEDIDO tb_pedido ',
         '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) ',
         '   INNER JOIN tb_itens_nfl ',
         '   ON (ITF_CODPED = PED_CODIGO) ',
         '   INNER JOIN TB_PRODUTO ',
         '   ON (PRO_CODIGO = ITF_CODPRO) ',
         '   INNER JOIN tb_medida ',
         '   ON (MED_CODIGO = PRO_CODMED) ',
         '   INNER JOIN TB_MARCA_PRODUTO ',
         '   ON (MRC_CODIGO = PRO_CODMRC) ',
         '   INNER JOIN TB_COLABORADOR ',
         '   ON (CLB_CODIGO = PED_CODVDO) ',
         '   LEFT OUTER JOIN tb_itens_icms ICMS ',
         '   ON (ICM_CODITF = ITF_CODIGO) ',
         '   LEFT OUTER JOIN tb_itens_ipi IPI ',
         '   ON (IPI.ipi_coditf = ITF_CODIGO) ',
         '   INNER JOIN tb_endereco tb_endereco ',
         '   ON (tb_endereco.end_codigo = tb_pedido.ped_codend) ');

  if ( Parametros.CodigoTransportadora > 0) then
  Begin
    InnerJoinTxt := InnerJoinTxt +
                  '   INNER JOIN TB_EMPRESA tb_transportadora '+
                  '   ON (tb_transportadora.EMP_CODIGO = tb_nota_fiscal.NFL_CODTRP) ';
  End;
end;

procedure TRL_ReportVendas.WhereSql;
begin
  with Parametros do
  Begin
    WhereTxt := 'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') '+
                ' AND (PED_TIPO = 1) AND (NFL_STATUS = ''F'')    ';

    case TipoDocumento of
      0:WhereTxt := WhereTxt + ' AND ( ( NFL_NUMERO =  '''') or  (NFL_NUMERO is null    ) ) ';
      1:WhereTxt := WhereTxt + ' AND ( ( NFL_NUMERO <> '''') and (NFL_NUMERO is not null) ) ';
    end;

    if Periodo then
      WhereTxt := WhereTxt + ' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';

    if CodigoCliente > 0 then
      WhereTxt := WhereTxt + ' AND (NFL_CODEMP = :NFL_CODEMP) ';

    if (Trim(NomeCliente) <> '') then
      WhereTxt := WhereTxt + ' AND ( (tb_cliente.EMP_NOME LIKE :EMP_NOME) OR (tb_cliente.EMP_FANTASIA LIKE :EMP_NOME) ) ';

    if CodigoTransportadora > 0 then
      WhereTxt := WhereTxt + ' AND ( NFL_CODTRP = :NFL_CODTRP ) ';

    if CodigoVendedorCliente > 0 then
      WhereTxt := WhereTxt + ' AND ( tb_cliente.EMP_CODVDOR = :EMP_CODVDOR ) ';

    if CodigoVendedorPedido > 0 then
      WhereTxt := WhereTxt + ' AND ( PED_CODVDO = :PED_CODVDO ) ';

    if (Trim(NomeDaRegiao) <> '') then
      WhereTxt := WhereTxt + ' AND ( END_REGIAO LIKE :END_REGIAO ) ';

    if CodigoEstabelecimento > 0 then
      WhereTxt := WhereTxt + ' AND ( NFL_CODMHA = :NFL_CODMHA ) ';

    if ( Trim(TipoItem) <> '' ) then
      WhereTxt := WhereTxt + ' AND ( ITF_OPER = :ITF_OPER ) ';
  End;
end;

procedure TRL_ReportVendas.OrderBy;
begin
  inherited;
  OrderByTxt := OrderByTxt + ' ORDER BY  NFL_DT_EMISSAO, NFL_NUMERO,PED_NUMERO, tb_cliente.EMP_FANTASIA ';
end;

procedure TRL_ReportVendas.PassarParametros;
begin
  RePassarParametros(Qr_Consulta);
end;


procedure TRL_ReportVendas.PreencherDetalhe;
begin
  //
end;

procedure TRL_ReportVendas.PreencherGrupo;
begin
  //
end;

procedure TRL_ReportVendas.RePassarParametros(Qry:TSTQuery);
begin
  with Qry, Parametros do
  Begin
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDatetime := DataInicial;
      ParamByName('DATAFIM').AsDatetime := DataFinal;
    End;
    if CodigoCliente > 0 then
      ParamByName('NFL_CODEMP').AsInteger := CodigoCliente;

    if (Trim(NomeCliente) <> '') then
      ParamByName('EMP_NOME').AsString := NomeCliente + '%';

    if CodigoTransportadora > 0 then
      ParamByName('NFL_CODTRP').AsInteger := CodigoTransportadora;

    if CodigoVendedorCliente > 0 then
      ParamByName('EMP_CODVDOR').AsInteger := CodigoVendedorCliente;

    if CodigoVendedorPedido > 0 then
      ParamByName('PED_CODVDO').AsInteger := CodigoVendedorPedido;

    if (Trim(NomeDaRegiao) <> '') then
      ParamByName('END_REGIAO').AsString := NomeDaRegiao;

    if CodigoEstabelecimento > 0 then
      ParamByName('NFL_CODMHA').AsInteger := CodigoEstabelecimento;

    if ( Trim(TipoItem) <> '' ) then
      ParamByName('ITF_OPER').AsString := TipoItem;
  end;
end;

end.
