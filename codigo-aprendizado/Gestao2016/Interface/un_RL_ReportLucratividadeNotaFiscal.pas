unit un_RL_ReportLucratividadeNotaFiscal;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_RL_ReportLucratividade, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportLucratividadeNotaFiscal = class(TRL_ReportLucratividade)
  private
    { Private declarations }
  protected
    function getValorFrete:Real;Override;
    function getValorOutrasDespesas:Real;Override;
    function getValorSeguros:Real;Override;

    procedure SelectSql;Override;
    procedure WhereSqlCustomized;Override;
    procedure PassarParametros;Override;
    procedure RePassarParametros(Qry:TSTQuery);

  public
    { Public declarations }
  end;

var
  RL_ReportLucratividadeNotaFiscal: TRL_ReportLucratividadeNotaFiscal;

implementation

{$R *.dfm}

{ TRL_ReportLucratividadeNotaFiscal }

function TRL_ReportLucratividadeNotaFiscal.getValorFrete: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.Add(concat(
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
      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;
end;

function TRL_ReportLucratividadeNotaFiscal.getValorOutrasDespesas: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.Add(concat(
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
      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;


end;

function TRL_ReportLucratividadeNotaFiscal.getValorSeguros: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.Add(concat(
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
      RePassarParametros(LcQry);
      Active := True;
      First;
      Result := FieldByName('VALOR').AsCurrency;
    end;
  Finally
    Geral.FinalizaQuery(LcQry);
  End;
end;




procedure TRL_ReportLucratividadeNotaFiscal.PassarParametros;
begin
  inherited;

end;

procedure TRL_ReportLucratividadeNotaFiscal.RePassarParametros(Qry: TSTQuery);
begin

end;

procedure TRL_ReportLucratividadeNotaFiscal.SelectSql;
begin
  inherited;
  // SelectTxt : String;
  SelectTxt := Concat(
    'SELECT  ''N'' LVD_SITUACAO, NFL_CODMHA LVD_CODMHA, PED_CODIGO LVD_CODIGO, '''' LVD_COTACAO,PED_NUMERO LVD_PEDIDO, NFL_DT_EMISSAO LVD_DT_EMISSAO, NFL_NUMERO LVD_NOTA, ',
    '                EMP_CODIGO LVD_CODCLI, EMP_NOME LVD_CLIENTE,ITF_CODPRO LVD_CODPRO, PRO_DESCRICAO LVD_PRODUTO, ',
    '                ITF_QTDE LVD_QTDE,ITF_VL_UNIT LVD_VL_UNIT, ITF_AQ_IPI LVD_ALIQ_IPI, ITF_AQ_COM LVD_ALIQ_COM, ITF_VL_CUSTO LVD_VL_CUSTOREAL, ITF_VL_DESC LVD_VL_DESC, ',
    ' (ICM_VL_NR + ICM_VL_ST) LVD_ICMS ',
    ' FROM TB_PEDIDO tb_pedido '
  );
end;


procedure TRL_ReportLucratividadeNotaFiscal.WhereSqlCustomized;
begin
  with  Parametros do
  Begin
    //WhereTxt : String;
    WhereTxt := concat(
                  'WHERE (PED_TIPO = ''1'') ',
                  ' and ( (NFL_NUMERO <> '''') or (NFL_NUMERO is not null) ) ',
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
                   ' AND (NFL_NUMERO =:NFL_NUMERO) '
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

end.
