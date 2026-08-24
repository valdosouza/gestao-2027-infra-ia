unit un_frx_report_base_troca;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, prm_exchange_basis, frxExportXLS;

type
  TFrxReportBaseTroca = class(TFrxBaseReport)
  private
    { Private declarations }
  protected
    { Private declarations }
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure GroupBy;Override;
    procedure PassarParametros; Override;
  public
    { Public declarations }
    Parametros : TPrmExchangeBase;
  end;

var
  FrxReportBaseTroca: TFrxReportBaseTroca;

implementation

{$R *.dfm}

uses     UN_Sistema;

{ TFrxReportBaseTroca }

procedure TFrxReportBaseTroca.GroupBy;
begin
  inherited;
  GroupByTxt := 'group by 1,2,3,4,5 ';
end;

procedure TFrxReportBaseTroca.IniciaVariaveis;
begin
  inherited;
  Parametros := TPrmExchangeBase.create;
end;

procedure TFrxReportBaseTroca.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                  '   inner join tb_produto pr ',
                  '   on (pr.pro_codigo = eb.tb_product_id) ',
                  '   inner join tb_colaborador cl ',
                  '   on (cl.clb_codigo = eb.tb_salesman_id) ',
                  '   inner join tb_itens_nfl it ',
                  '   on (it.itf_codigo = eb.tb_order_item_id) ',
                  '   inner join tb_usuario us ',
                  '   on (us.usu_codigo = eb.tb_user_id) ',
                  '   left outer join tb_pedido pd ',
                  '   on (pd.PED_CODIGO = eb.TB_ORDER_ID) ',
                  '   inner join tb_empresa ep ',
                  '   on (ep.emp_codigo = pd.PED_CODEMP ) '
  );



end;

procedure TFrxReportBaseTroca.OrderBy;
begin
  inherited;
  OrderByTxt := ' ORDER BY  1, 2 ';
end;

procedure TFrxReportBaseTroca.PassarParametros;
begin
  inherited;
  with Qr_Consulta do
  Begin
    if Parametros.Estabelecimento > 0 then
      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;


    IF Parametros.Periodo then
    Begin
      ParamByName('DATAINI').AsDate := Parametros.DataInicial;
      ParamByName('DATAFIM').AsDate := Parametros.DataFinal
    end;

    if Parametros.CodProduto <> '' then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        ParamByName('PRO_CODIGO').AsString := Parametros.CodProduto;
      end
      else
      Begin
        ParamByName('PRO_CODIGO').AsString := '%' + Parametros.CodProduto + '%';
      end;
    end;

    if Parametros.DescProduto <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Parametros.DescProduto,1,98) + '%';

    if Parametros.GRupo > 0 then
      ParamByName('PRO_CODGRP').AsInteger := Parametros.GRupo;

    if Parametros.SubGRupo > 0 then
      ParamByName('PRO_CODSBG').AsInteger := Parametros.SubGRupo;

    if Parametros.Marca > 0 then
      ParamByName('PRO_CODMRC').AsInteger := Parametros.Marca;

    IF Parametros.CodCliente <> '' then
      ParamByName('TB_CUSTOMER_ID').AsString := Parametros.CodCliente;

    IF Parametros.DescCliente <> '' then
      ParamByName('EMP_NOME').AsString := '%' + Copy(Parametros.DescCliente,1,98) + '%';

    if Parametros.Vendedor > 0 then
      ParamByName('TB_SALESMAN_ID').AsInteger := Parametros.Vendedor;
  End;
end;

procedure TFrxReportBaseTroca.SelectSql;
begin
  {
  SelectTxt := concat(
                  'Select eb.tb_institution_id, eb.tb_order_id, eb.tb_order_item_id, eb.dt_in, eb.dt_out, ',
                  'pr.pro_descricao, ep.emp_nome, ep.emp_fantasia, cl.clb_nome, ',
                  'it.itf_qtde, it.itf_vl_unit, eb.price_tag, eb.weight_in, eb.weight_out, eb.note, ',
                  'us.usu_nome, (weight_out - weight_in) saldo, pd.PED_NUMERO, tb_customer_id ',
                  'from tb_exchange_basis eb '
               );
  }
  SelectTxt := concat(
                  'Select ',
                  ' TB_CUSTOMER_ID, ',
                  ' ep.emp_nome, ',
                  ' ep.emp_fantasia, ',
                  ' pd.PED_NUMERO, ',
                  ' PR.pro_descricao, ' ,
                  ' Max(eb.dt_in) DataEntrada, ',
                  ' Max(eb.dt_out) DataSaida, ',
                  ' sum(weight_out) PesoSaida, ',
                  ' sum(weight_in) PesoEntrada, ',
                  ' sum(weight_out - weight_in) saldo ',
                  'from tb_exchange_basis eb '
  );



end;

procedure TFrxReportBaseTroca.WhereSql;
begin
  inherited;
  WhereTxt := 'WHERE (eb.TB_INSTITUTION_ID >0 )  ';

  if ( parametros.Estabelecimento > 0 ) then
    WhereTxt := WhereTxt  + ' AND ( TB_INSTITUTION_ID=:TB_INSTITUTION_ID ) ' ;

  IF parametros.Periodo then
    WhereTxt := WhereTxt  + 'AND ( dt_OUT BETWEEN :DATAINI AND :DATAFIM) ';

  if parametros.CodProduto <> '' then
    Begin
    IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
    Begin
      If StrToIntDef(parametros.CodProduto,0) >0 then
      Begin
        WhereTxt := WhereTxt  + 'AND ( (PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
      end
      else
      begin
        WhereTxt := WhereTxt  + 'AND ( (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
      end;
    end
    else
    Begin
      If StrToIntDef(parametros.CodProduto,0) >0 then
      Begin
        WhereTxt := WhereTxt  + 'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
      end
      else
      begin
        WhereTxt := WhereTxt  + 'AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
      end;
    end;
  end;

  if parametros.DescProduto <> '' then
    WhereTxt := WhereTxt  + ' AND ( (PRO_DESCRICAO LIKE :PRO_DESCRICAO) or (IAV_DESCRICAO LIKE :PRO_DESCRICAO ) )';

  IF parametros.GRupo > 0 then
    WhereTxt := WhereTxt  + 'AND ( PRO_CODGRP =:PRO_CODGRP ) ';

  IF parametros.SubGRupo > 0 then
    WhereTxt := WhereTxt  + 'AND ( PRO_CODSBG =:PRO_CODSBG ) ';

  if parametros.Marca > 0 then
    WhereTxt := WhereTxt  + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

  IF parametros.CodCliente <> '' then
    WhereTxt := WhereTxt  + 'AND (TB_CUSTOMER_ID =:TB_CUSTOMER_ID) ';

  IF parametros.DescCliente <> '' then
    WhereTxt := WhereTxt  + 'AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE :EMP_NOME) )';

  IF parametros.Vendedor > 0 then
    WhereTxt := WhereTxt  + 'AND ( TB_SALESMAN_ID =:TB_SALESMAN_ID )';


end;

end.
