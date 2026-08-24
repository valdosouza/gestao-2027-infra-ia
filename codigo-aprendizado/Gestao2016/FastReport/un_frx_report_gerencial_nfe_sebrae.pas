unit un_frx_report_gerencial_nfe_sebrae;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, prmNotas, frxExportPDF, Data.DB, STQuery, frxDBSet, ControllerNotaFiscal, frxExportXLS;

type
  TFrxReportGerencialNfeSebrae = class(TFrxBaseReport)
  private
    { Private declarations }
    NotaFiscal : TControllerNotaFiscal;
  protected
    { Private declarations }
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;

  public
    { Public declarations }
    Parametros: TParamNotas;
    procedure Totalizadores;
  end;

var
  FrxReportGerencialNfeSebrae: TFrxReportGerencialNfeSebrae;

implementation

{$R *.dfm}

{ TFrxReportGerencialNfeSebrae }

procedure TFrxReportGerencialNfeSebrae.IniciaVariaveis;
begin
  inherited;

end;

procedure TFrxReportGerencialNfeSebrae.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                   'INNER JOIN tb_retorno_nfe nfe ',
                   'on (nfe.nfe_codnfl = nf.nfl_codigo) '
  );

end;

procedure TFrxReportGerencialNfeSebrae.OrderBy;
begin
  OrderByTxt := 'Order by  nfe.nfe_codsit, NF.nfl_numero,NFL_DT_EMISSAO ';
end;

procedure TFrxReportGerencialNfeSebrae.PassarParametros;
begin
  with Qr_Consulta, Parametros do
  Begin
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDate := DataInicial;
      ParamByName('DATAFIM').AsDate := DataFinal;
    End;
    if CodigoEmpresa > 0 then
      ParamByName('NFL_CODEMP').AsInteger := CodigoEmpresa;
    if CodigoCFOP > 0 then
      ParamByName('NFL_CODNAT').AsInteger := CodigoCFOP;
    if CodigoEstabelecimento > 0 then
      ParamByName('NFL_CODMHA').AsInteger := CodigoEstabelecimento;
  end;

end;

procedure TFrxReportGerencialNfeSebrae.SelectSql;
begin
  inherited;
  SelectTxt := concat(
                  'SELECT NF.nfl_numero, NF.nfl_serie, NF.nfl_dt_emissao, NF.nfl_vl_tl_prod, NF.nfl_vl_icms_subst, ',
                  'NF.nfl_vl_frete, NF.nfl_vl_seguro, NF.nfl_vl_ipi, NF.nfl_vl_desp_acess, ',
                  '0 NFL_VL_DESCONTO, NF.nfl_vl_tl_nota, NF.nfl_bs_icms, NF.nfl_vl_icms, ',
                  ' NF.nfl_tipo, nfe.nfe_codsit, nfe.nfe_motivo,nf.nfl_vl_tl_srv, NFL_MODELO ',
                  'FROM tb_nota_fiscal NF '
               );

end;

procedure TFrxReportGerencialNfeSebrae.Totalizadores;
begin
  Try
    NotaFiscal := TControllerNotaFiscal.Create(nil);
    NotaFiscal.Periodo := Parametros.Periodo;
    NotaFiscal.DataInicial := Parametros.DataInicial;
    NotaFiscal.DataFinal := Parametros.DataFinal;
    frxBase.Variables['ValoTotalCofins'] := QuotedStr( FloatToStrF(NotaFiscal.ValoTotalCofins,ffNumber,10,2) );
    frxBase.Variables['ValoTotalII'] := QuotedStr( FloatToStrF(NotaFiscal.ValoTotalII,ffNumber,10,2) );
    frxBase.Variables['ValorTotalPisST'] := QuotedStr( FloatToStrF(NotaFiscal.ValorTotalPisST,ffNumber,10,2) );
    frxBase.Variables['ValorTotalPis'] := QuotedStr( FloatToStrF(NotaFiscal.ValorTotalPis,ffNumber,10,2) );
    frxBase.Variables['ValorTotalCofinsST'] := QuotedStr( FloatToStrF(NotaFiscal.ValorTotalCofinsST,ffNumber,10,2) );
    frxBase.Variables['ValorTotalDesconto'] := QuotedStr( FloatToStrF(NotaFiscal.ValorTotalDesconto,ffNumber,10,2) );
  Finally
    FreeAndNil(NotaFiscal);
  End;

end;

procedure TFrxReportGerencialNfeSebrae.WhereSql;
begin
  with parametros do
  Begin
    WhereTxt := 'WHERE ( nfe.nfe_codsit >= 2 ) ';
    if Periodo then WhereTxt := WhereTxt + ' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';
    if CodigoEmpresa > 0 then WhereTxt := WhereTxt + ' AND (NFL_CODEMP =:NFL_CODEMP) ';
    if CodigoCFOP > 0 then WhereTxt := WhereTxt + ' AND (NFL_CODNAT =:NFL_CODNAT) ';
    if CodigoEstabelecimento > 0 then WhereTxt := WhereTxt + ' AND ( NFL_CODMHA=:NFL_CODMHA ) ';
  End;

end;

end.
