unit un_frx_movim_financeiro;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, Data.DB, STQuery, frxExportCSV, frxClass, frxExportPDF, frxDBSet, prmMovimFinanceiro, frxExportXLS;

type
  Tfrx_MovimFinanceiro = class(TFrxBaseReport)
  private
    { Private declarations }
  protected
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure GroupBy;Override;
    procedure Having;Override;
    procedure PassarParametros; Override;
    procedure PreencherGrupo;Virtual;
    procedure PreencherDetalhe;Virtual;
    procedure OrderBy;
  public
    { Public declarations }
    Parametros : TParamMovimFinanceiro;
  end;

var
  frx_MovimFinanceiro: Tfrx_MovimFinanceiro;

implementation

{$R *.dfm}

uses     UN_Sistema;

{ TFrxBaseReport1 }

procedure Tfrx_MovimFinanceiro.GroupBy;
begin
  inherited;
  GroupByTxt := 'GROUP BY 1 ';

end;

procedure Tfrx_MovimFinanceiro.Having;
begin
  inherited;
  HavingTxt := 'HAVING (SUM(M.mvf_vl_credito) >0) or (SUM(M.mvf_vl_debito)>0)';
end;

procedure Tfrx_MovimFinanceiro.IniciaVariaveis;
begin
  inherited;
  //TfrxReportPage(frxBase.Pages[1]).PaperWidth := StrToFloatDef(Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80'),80);
  //TfrxReportPage(frxBase.Pages[1]).RightMargin  := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO', '0'),0);
  //TfrxReportPage(frxBase.Pages[1]).LeftMargin   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO', '0'),0);
  Parametros := TParamMovimFinanceiro.create;
end;

procedure Tfrx_MovimFinanceiro.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                '  INNER JOIN tb_formapagto F       ',
                '  ON (F.fpt_codigo = M.mvf_codfpt) '
  );

end;

procedure Tfrx_MovimFinanceiro.OrderBy;
begin

end;

procedure Tfrx_MovimFinanceiro.PassarParametros;
begin
  inherited;
  with Qr_Consulta  do
  Begin
    if Parametros.Periodo then
    Begin
      ParamByName('DATAINI').AsDate := Parametros.DataInicial;
      ParamByName('DATAFIM').AsDate := Parametros.DataFinal;
    End;

    if Parametros.Usuario > 0 then
      ParamByName('MVF_CODUSU').AsInteger := Parametros.Usuario;

    if Parametros.FormaPagto > 0 then
      ParamByName('MVF_CODFPT').AsInteger := Parametros.FormaPagto;

    if Parametros.CodigoEstabelecimento > 0 then
      ParamByName('MVF_CODMHA').AsInteger := Parametros.CodigoEstabelecimento;

  End;
end;

procedure Tfrx_MovimFinanceiro.PreencherDetalhe;
begin

end;

procedure Tfrx_MovimFinanceiro.PreencherGrupo;
begin

end;

procedure Tfrx_MovimFinanceiro.SelectSql;
begin
  inherited;
  SelectTxt := concat(
            'SELECT F.fpt_descricao, SUM(M.mvf_vl_credito) CREDITO, SUM(M.mvf_vl_debito) DEBITO ',
            'FROM tb_movim_financeiro m                                          '
  );
end;

procedure Tfrx_MovimFinanceiro.WhereSql;
begin
  inherited;
  WhereTxt := 'WHERE M.MVF_CODIGO IS NOT NULL ';

  if Parametros.Periodo then
  Begin
    WhereTxt := WhereTxt + ' and m.mvf_data between :dataIni and :Datafim ';
  End;

  if Parametros.Usuario > 0 then
    WhereTxt := WhereTxt + ' AND ( M.MVF_CODUSU = :MVF_CODUSU ) ';

  if Parametros.FormaPagto > 0 then
    WhereTxt := WhereTxt + ' AND ( M.MVF_CODFPT = :MVF_CODFPT ) ';

  if Parametros.CodigoEstabelecimento > 0 then
    WhereTxt := WhereTxt + ' AND ( M.MVF_CODMHA = :MVF_CODMHA ) ';

end;

end.
