unit un_frx_ReportVendasFormaPagto;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, Data.DB, STQuery, frxExportCSV, frxExportPDF, frxDBSet, prmVendas, frxExportXLS;

type
  Tfrx_ReportVendasFormaPagto = class(TFrxBaseReport)
  private
    { Private declarations }
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure GroupBy;Override;
    procedure PassarParametros; Override;
    procedure PreencherGrupo;Virtual;
    procedure PreencherDetalhe;Virtual;
    procedure OrderBy;
  public
    { Public declarations }
    Parametros : TParamVendas;
  end;

var
  frx_ReportVendasFormaPagto: Tfrx_ReportVendasFormaPagto;

implementation

{$R *.dfm}

uses     UN_Sistema;

{ Tfrx_ReportVendasFormaPagto }

procedure Tfrx_ReportVendasFormaPagto.GroupBy;
begin
end;

procedure Tfrx_ReportVendasFormaPagto.IniciaVariaveis;
Begin
  inherited;
  TfrxReportPage(frxBase.Pages[1]).PaperWidth := StrToFloatDef(Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80'),80);
  TfrxReportPage(frxBase.Pages[1]).RightMargin  := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO', '0'),0);
  TfrxReportPage(frxBase.Pages[1]).LeftMargin   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO', '0'),0);
end;

procedure Tfrx_ReportVendasFormaPagto.InnerJoinSql;
begin

end;

procedure Tfrx_ReportVendasFormaPagto.OrderBy;
begin
  inherited;

end;

procedure Tfrx_ReportVendasFormaPagto.PassarParametros;
begin
  with Qr_Consulta do
  Begin
    if Parametros.Periodo then
    Begin
      ParamByName('DATAINI').AsDate := Parametros.DataInicial;
      ParamByName('DATAFIM').AsDate := Parametros.DataFinal;
    End;

    if Parametros.CodigoVendedorPedido > 0 then
      ParamByName('PED_CODVDO').AsInteger := Parametros.CodigoVendedorPedido;

    if Parametros.CodigoEstabelecimento > 0 then
      ParamByName('FIN_CODMHA').AsInteger := Parametros.CodigoEstabelecimento;
  end;
end;

procedure Tfrx_ReportVendasFormaPagto.PreencherDetalhe;
begin

end;

procedure Tfrx_ReportVendasFormaPagto.PreencherGrupo;
begin

end;

procedure Tfrx_ReportVendasFormaPagto.SelectSql;
begin

  SelectTxt := concat(
                'select fpt_descricao, sum(ValorTotal) ValorTotal ',
                'from ',
                '(select fp.fpt_descricao, sum(fN.fin_vl_parcela) ValorTotal ',
                'from tb_nota_fiscal nf ',
                '    inner join tb_financeiro fn ',
                '    on ( fn.fin_codnfl = nf.nfl_codigo ) ',
                '    inner join tb_pedido pd ',
                '    on (pd.PED_CODIGO = nf.NFL_CODPED) ',
                '    inner join tb_formapagto fp ',
                '    on (fp.fpt_codigo = fn.fin_codfpg) ',
                'where  ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'') ) ',
                ' AND ( fn.fin_baixa = ''N'') '
                );

  if Parametros.Periodo then
  Begin
    SelectTxt := concat(SelectTxt, ' and nf.nfl_dt_emissao between :DATAINI and :DATAFIM ');
  End;

  if Parametros.CodigoVendedorPedido > 0 then
    SelectTxt := concat(SelectTxt,' AND ( PED_CODVDO = :PED_CODVDO ) ');

  if Parametros.CodigoEstabelecimento > 0 then
    SelectTxt := concat(SelectTxt,' AND ( FIN_CODMHA = :FIN_CODMHA ) ');


  SelectTxt := Concat(
                SelectTxt,
                ' group by 1 ',
                ' UNION ',
                ' select fp.fpt_descricao, sum(fn.fin_vl_pago) ValorTotal ',
                ' from tb_nota_fiscal nf ',
                '    inner join tb_financeiro fn ',
                '    on ( fn.fin_codnfl = nf.nfl_codigo ) ',
                '    inner join tb_pedido pd ',
                '    on (pd.PED_CODIGO = nf.NFL_CODPED) ',
                '    inner join tb_formapagto fp ',
                '    on (fp.fpt_codigo = fn.fin_codfpg) ',
                'where ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'') ) ',
                ' AND ( fn.fin_baixa = ''S'') '
                );

  if Parametros.Periodo then
  Begin
    SelectTxt := concat(SelectTxt, ' and nf.nfl_dt_emissao between :DATAINI and :DATAFIM ');
  End;

  if Parametros.CodigoVendedorPedido > 0 then
    SelectTxt := SelectTxt + ' AND ( PED_CODVDO = :PED_CODVDO ) ';

  if Parametros.CodigoEstabelecimento > 0 then
    SelectTxt := SelectTxt + ' AND ( FIN_CODMHA = :FIN_CODMHA ) ';

  SelectTxt := concat(
                SelectTxt,
                'group by 1 ',
                ') ',
                'group by 1 '
                );

end;


procedure Tfrx_ReportVendasFormaPagto.WhereSql;
begin

end;

end.
