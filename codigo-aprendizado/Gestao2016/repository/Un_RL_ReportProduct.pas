unit Un_RL_ReportProduct;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, UN_Principal, env, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, prmProdutos;

type
  TRL_ReportProduct = class(TRL_ReportList)
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;
    procedure PreencherGrupo;Virtual;
    procedure PreencherDetalhe;Virtual;
    function Fc_Calc_Mrg_Valor():String;
  private
    { Private declarations }
  public
    { Public declarations }
    Parametros : TParamProdutos;
  end;

var
  RL_ReportProduct: TRL_ReportProduct;

implementation

{$R *.dfm}

uses     UN_Sistema, ControllerGeral, Un_DM;

{ TRL_ReportProduct }

procedure TRL_ReportProduct.IniciaVariaveis;
begin
  inherited;
  //
end;


procedure TRL_ReportProduct.SelectSql;
begin
  SelectTxt := 'SELECT pro.PRO_CODIGO,pro.PRO_CODIGOFAB,pro.PRO_CODIGOFOR,pro.PRO_DESCRICAO,              '+
                '  med.MED_DESCRICAO, PRO_DIVISOR, EMB_DESCRICAO, pro.PRO_CODGRP,grp.GRP_DESCRICAO,       '+
                '  pro.PRO_CODSBG,sbg.SBG_DESCRICAO, pro.PRO_CODIGONCM,pro.PRO_CEST, pro.pro_peso,mar.MRC_DESCRICAO,      '+
                '  pro.pro_vl_fabrica,pro.pro_vl_customed, pro.PRO_VL_CUSTO,pre.PRC_VL_VDA ,pre.PRC_MAR_LRC,'+
                '  pro.pro_comprimento, pro.pro_largura, pro.pro_altura,                      '+
                '  pro.PRO_CODIGOBAR,EST_QTDE,pro_est_neg, AVAILABLE,ADD_DAYS_AVAILABLE,PRO_ATIVO         '+
                ' FROM TB_PRODUTO pro                                                                    ';
end;

procedure TRL_ReportProduct.InnerJoinSql;
begin
  InnerJoinTxt := '  INNER JOIN TB_ESTOQUE est '+
                  '  ON (est.EST_CODPRO = pro.PRO_CODIGO) '+
                  '  INNER JOIN TB_GRUPOS grp '+
                  '  ON  (pro.PRO_CODGRP = grp.GRP_CODIGO) '+
                  '  INNER JOIN TB_SUBGRUPOS sbg '+
                  '  ON  (pro.PRO_CODSBG = sbg.SBG_CODIGO) '+
                  '  inner join tb_medida med '+
                  '  ON(med.med_codigo = pro.pro_codmed) '+
                  '  inner join tb_embalagem emb '+
                  '  ON(emb_codigo = pro.pro_codemb) '+
                  '  INNER JOIN TB_MARCA_PRODUTO mar '+
                  '  ON  (pro.PRO_CODMRC = mar.mrc_CODIGO) '+
                  '  INNER JOIN TB_PRECO PRE '+
                  '  ON (PRE.PRC_CODPRO = pro.PRO_CODIGO)' ;

  if (Parametros.CodigoEmpresa > 0 ) and ( Parametros.TipoEmpresa = '2' ) then
  Begin
    InnerJoinTxt := InnerJoinTxt +
                    '  INNER JOIN TB_PROD_FORN Tb_prod_forn  '+
                    '  ON  (Tb_prod_forn.PFR_CODPRO = pro.PRO_CODIGO) '+
                    '  INNER JOIN  TB_EMPRESA Tb_fornecedor '+
                    '  ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
  end;

  if Parametros.ComMovimentacao then
  Begin
    InnerJoinTxt := concat(
                    InnerJoinTxt +
                    '  INNER JOIN TB_ITENS_NFL ',
                    '  ON (ITF_CODPRO = PRO_CODIGO ) ',
                    '  INNER JOIN TB_CTRL_ESTOQUE CE ',
                    '  ON ( CET_ITEM_CTRL = ITF_CODIGO) '
    );
  End;

end;

procedure TRL_ReportProduct.WhereSql;
begin
  with Parametros do
  Begin
    WhereTxt := 'WHERE  ( (PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C'') ) ';



    if CodigoEstabelecimento > 0 then
      WhereTxt := WhereTxt + ' AND PRO_CODMHA = :PRO_CODMHA ';

    if (CodigoEstoque > 0 ) then
      WhereTxt := WhereTxt + ' AND EST_CODETS = :ETS_CODIGO ';

    if (CodigoGrupo > 0 ) then
      WhereTxt := WhereTxt + ' AND (PRO_CODGRP =:PRO_CODGRP) ';

    if (CodigosubGrupo > 0 ) then
      WhereTxt := WhereTxt + ' AND (PRO_CODSBG =:PRO_CODSBG) ';

    if (CodigoMarca > 0 ) then
      WhereTxt := WhereTxt + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

    if (CodigoEmpresa > 0) and (TipoEmpresa = '2' ) then
      WhereTxt := WhereTxt + ' AND (PFR_CODFOR =:PFR_CODFOR) ';

    if (DescricaoProduto <> '' ) then
      WhereTxt := WhereTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if EstoqueMinimo then
      WhereTxt := WhereTxt + ' AND ( (EST_QTDE < PRO_QTDE_MIN) AND (PRO_QTDE_MIN > 0) )';

    if EstoquePositivo then
      WhereTxt := WhereTxt + ' AND (EST_QTDE > 0)';

    if EstoqueNegativo then
      WhereTxt := WhereTxt + ' AND (EST_QTDE < 0)';

    if EstoqueZerado then
      WhereTxt := WhereTxt + ' AND (EST_QTDE = 0)';

    if not Inativos then
      WhereTxt := WhereTxt + ' AND (PRO_ATIVO = ''S'') ';

    if CodigoTabelaPreco > 0 then
      WhereTxt := WhereTxt + 'AND (PRC_CODTPR=:PRC_CODTPR) ';

    if InternetPublished then
      WhereTxt := WhereTxt +'AND ( PRO_INTERNET = ''S'' ) ';

    if Parametros.ComMovimentacao then
      WhereTxt := WhereTxt +'AND ( CET_DATA between :DATAINI AND :DATAFIM ) ' ;
  End;
end;

procedure TRL_ReportProduct.OrderBy;
begin
  inherited;
  OrderByTxt := OrderByTxt + Parametros.Ordenacao;

end;


procedure TRL_ReportProduct.PassarParametros;
begin
  inherited;
  with Qr_Consulta, Parametros do
  Begin
    if CodigoTabelaPreco > 0 then
      ParamByName('PRC_CODTPR').AsInteger:= CodigoTabelaPreco;

    if CodigoEstabelecimento > 0 then
      ParamByName('PRO_CODMHA').AsInteger:= CodigoEstabelecimento;

    if ( CodigoEstoque > 0 ) then
      ParamByName('ETS_CODIGO').AsInteger:= CodigoEstoque;

    if ( CodigoGrupo > 0 ) then
      ParamByName('PRO_CODGRP').AsInteger := CodigoGrupo;

    if ( CodigoSubGrupo > 0 ) then
      ParamByName('PRO_CODSBG').AsInteger:= CodigoSubGrupo;

    if ( CodigoMarca > 0 ) then
      ParamByName('PRO_CODMRC').AsInteger := CodigoMarca;

    if (CodigoEmpresa > 0) and (TipoEmpresa = '2') then
        ParamByName('PFR_CODFOR').AsInteger := CodigoEmpresa;

    if DescricaoProduto <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(DescricaoProduto,1,98) + '%';

    if Parametros.ComMovimentacao then
    bEGIN
      ParamByName('DATAINI').AsDateTime := DataInicial;
      ParamByName('DATAFIM').AsDateTime := DataFinal;
    end;
  end;
end;

procedure TRL_ReportProduct.PreencherGrupo;
begin
  //
end;

procedure TRL_ReportProduct.PreencherDetalhe;
begin
  //
end;

function TRL_ReportProduct.Fc_Calc_Mrg_Valor():String;
var
  Lc_Vl_Margem: Double;
  Lc_Vl_Venda: Double;
  Geral : TControllerGeral;
begin
  with Qr_consulta do
  Begin
    Lc_Vl_Margem:= 0;
    Lc_Vl_Venda := 0;
    if (fieldbyname('PRC_VL_VDA').asVariant <> null) then
    Begin
      Lc_Vl_Venda :=  fieldbyname('PRC_VL_VDA').AsCurrency;
      Geral := TControllerGeral.Create(Self);
      Geral.Registro.Campo := 'PRO_G_CALC_MRG_LUCRO';
      Geral.Registro.CodigoEstabelecimento := Gb_CodMha;
      Geral.getById;
      if ( Geral.Registro.Conteudo = '1') then
      Begin
        if Lc_Vl_Venda > 0 then
          Lc_Vl_Margem := (1-(fieldbyname('PRO_VL_CUSTO').AsCurrency / Lc_Vl_Venda))*100
        else
          Lc_Vl_Margem := (1-(fieldbyname('PRO_VL_CUSTO').AsCurrency / 1))*100;
      end
      else
      if ( Geral.Registro.Conteudo = '2') then
      Begin
        if fieldbyname('PRO_VL_CUSTO').AsCurrency > 0 then
          Lc_Vl_Margem := ((Lc_Vl_Venda - fieldbyname('PRO_VL_CUSTO').AsCurrency)/fieldbyname('PRO_VL_CUSTO').AsCurrency)*100
        else
          //Lc_Vl_Margem := ((Lc_Vl_Venda - fieldbyname('PRO_VL_CUSTO').AsFloat)/1)*100;
          Lc_Vl_Margem := 100;
      end;
      FreeAndNil(Geral);
    End;
    Result := FloatToStrF(Lc_Vl_Margem,ffFixed,4,2);
  End;
end;


end.
