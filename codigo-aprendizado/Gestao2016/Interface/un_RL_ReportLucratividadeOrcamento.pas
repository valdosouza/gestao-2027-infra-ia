unit un_RL_ReportLucratividadeOrcamento;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_RL_ReportLucratividade, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportLucratividadeOrcamento = class(TRL_ReportLucratividade)
  private
    { Private declarations }
  protected
    function getValorFrete:Real;Override;
    function getValorOutrasDespesas:Real;Override;
    function getValorSeguros:Real;Override;

    procedure IniciaVariaveis;Override;
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
  RL_ReportLucratividadeOrcamento: TRL_ReportLucratividadeOrcamento;

implementation

{$R *.dfm}

{ TRL_ReportLucratividadeOrcamento }

function TRL_ReportLucratividadeOrcamento.getValorFrete: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.Add(concat(
                'select sum(ctc_vl_frete) VALOR ',
                'FROM TB_COTACAO CT ',
                '  INNER JOIN TB_EMPRESA CL ',
                '   ON (CL.EMP_CODIGO = CT.CTC_CODEMP) ',
                '   INNER JOIN TB_COLABORADOR ',
                '   ON (CLB_CODIGO = CTC_CODVDO) '
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

function TRL_ReportLucratividadeOrcamento.getValorOutrasDespesas: Real;
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := Geral.GeraQuery;
    with LcQry do
    Begin
      SQL.Add(concat(
                'select sum(ctc_vl_adicional) VALOR ',
                'FROM TB_COTACAO CT ',
                '  INNER JOIN TB_EMPRESA CL ',
                '   ON (CL.EMP_CODIGO = CT.CTC_CODEMP) ',
                '   INNER JOIN TB_COLABORADOR ',
                '   ON (CLB_CODIGO = CTC_CODVDO) '
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

function TRL_ReportLucratividadeOrcamento.getValorSeguros: Real;
begin
  Result := 0;
end;

procedure TRL_ReportLucratividadeOrcamento.IniciaVariaveis;
begin
  inherited;

end;

procedure TRL_ReportLucratividadeOrcamento.InnerJoinSql;
begin
  inherited;
  //InnerJoinTxt : String;
  InnerJoinTxt := concat(
    '    INNER JOIN TB_ITENS_CTC tb_itens_ctc ',
    '    ON  (tb_itens_ctc.ICT_CODCTC = tb_cotacao.CTC_CODIGO) ',
    '    INNER JOIN TB_PRODUTO tb_produto ',
    '    ON  (tb_produto.pro_codigo = tb_itens_ctc.ICT_CODVCL) '
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


procedure TRL_ReportLucratividadeOrcamento.PassarParametros;
begin
  RePassarParametros(Qr_Consulta);
end;

procedure TRL_ReportLucratividadeOrcamento.RePassarParametros(Qry: TSTQuery);
begin
  with Qry,Parametros do
  Begin
    If (NumeroDocumento <> '') then
    Begin
      ParamByName('CTC_NUMERO').AsString := NumeroDocumento;
    end
    else
    Begin
      if Periodo then
      begin
        ParamByName('DATAINI').AsDate:= DataInicial;
        ParamByName('DATAFIM').AsDate:= DataFinal;
      end;
      If (CodigoCliente > 0)  then
        ParamByName('CTC_CODEMP').AsInteger := CodigoCliente;
    end;
    if (CodigoEstabelecimento > 0) then
      ParamByName('CTC_CODMHA').AsInteger:= CodigoEstabelecimento;

    if (VendedorCliente > 0) then
      ParamByName('EMP_CODVDOR').AsInteger:= VendedorCliente;

    if (VendedorPedido > 0) then
      ParamByName('CTC_CODVDO').AsInteger:= VendedorPedido;

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

procedure TRL_ReportLucratividadeOrcamento.SelectSql;
begin
  inherited;
  // SelectTxt : String;
  SelectTxt := Concat(
    'SELECT  ''C'' LVD_SITUACAO, CTC_CODMHA LVD_CODMHA, CTC_CODIGO LVD_CODIGO, CTC_NUMERO LVD_COTACAO,'''' LVD_PEDIDO, CTC_DATA LVD_DT_EMISSAO, '''' LVD_NOTA, ',
    '               CTC_CODEMP LVD_CODCLI, CTC_FANTASIA LVD_CLIENTE,ICT_CODVCL LVD_CODPRO, PRO_DESCRICAO LVD_PRODUTO, ',
    '               ICT_QTDE LVD_QTDE,ICT_VL_UNIT LVD_VL_UNIT, 0.00 LVD_ALIQ_IPI, 0.00 LVD_ALIQ_COM, ICT_VL_CUSTO LVD_VL_CUSTOREAL,ICT_VL_DESC LVD_VL_DESC ',
    ', (0) LVD_ICMS ',
    ' FROM TB_COTACAO tb_cotacao '
  );


end;

procedure TRL_ReportLucratividadeOrcamento.WhereSql;
begin
  WhereSqlCustomized;
  WhereTxt := concat(
                WhereTxt,
                'AND (ICT_TIPO = ''P'') '
  );

end;

procedure TRL_ReportLucratividadeOrcamento.WhereSqlCustomized;
begin
  with  Parametros do
  Begin
    //WhereTxt : String;
    WhereTxt := concat(
                  'WHERE (CTC_CODIGO IS NOT NULL) '
    );

    if VendedorCliente >0 then
    WhereTxt := concat(
                   WhereTxt,
                   ' AND (EMP_CODVDOR =:EMP_CODVDOR)'
    );

    if Parametros.VendedorPedido >0 then
    WhereTxt := concat(
                   WhereTxt,
                  ' AND (CTC_CODVDO =:CTC_CODVDO )'
    );

    //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
    //Lc_Aux := Trim(Fc_codigosNegocio);

    if NumeroDocumento <> '' then
    Begin
      WhereTxt := concat(
                   WhereTxt,
                   ' AND (CTC_NUMERO LIKE :CTC_NUMERO) '
      );
    End
    else
    Begin
      if Periodo then
        WhereTxt := concat(
                     WhereTxt,
                     ' AND (CTC_DATA BETWEEN :DATAINI AND :DATAFIM) '
        );
      if CodigoCliente > 0 then
        WhereTxt := concat(
                     WhereTxt,
                      ' AND (CTC_CODEMP=:CTC_CODEMP) '
        );

    End;

    if CodigoEstabelecimento >0 then
      WhereTxt := concat(
                   WhereTxt,
                   'AND (CTC_CODMHA=:CTC_CODMHA) '
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
