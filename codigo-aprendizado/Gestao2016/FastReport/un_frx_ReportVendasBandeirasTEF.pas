unit un_frx_ReportVendasBandeirasTEF;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, prmVendas, frxExportXLS;

type
  Tfrx_ReportVendasBandeirasTEF = class(TFrxBaseReport)
  private
  protected
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
  frx_ReportVendasBandeirasTEF: Tfrx_ReportVendasBandeirasTEF;

implementation

{$R *.dfm}

uses     UN_Sistema;
{ Tfrx_ReportVendasBandeirasTEF }

procedure Tfrx_ReportVendasBandeirasTEF.GroupBy;
begin
  GroupByTxt := 'group by 1 ';
end;

procedure Tfrx_ReportVendasBandeirasTEF.IniciaVariaveis;
begin
  inherited;
  TfrxReportPage(frxBase.Pages[1]).PaperWidth := StrToFloatDef(Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80'),80);
  TfrxReportPage(frxBase.Pages[1]).RightMargin  := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO', '0'),0);
  TfrxReportPage(frxBase.Pages[1]).LeftMargin   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO', '0'),0);

end;

procedure Tfrx_ReportVendasBandeirasTEF.InnerJoinSql;
begin
  InnerJoinTxt := concat(
                '    inner join tb_financeiro fn ',
                '    on ( fn.fin_codnfl = nf.nfl_codigo ) ',
                '    inner join tb_pedido pd ',
                '    on (pd.PED_CODIGO = nf.NFL_CODPED) ',
                '    inner join tb_tef_movimento tef ',
                '    on (tef.tb_pedido_id = pd.ped_codigo) ',
                '        and (tef.tb_institution_id = pd.ped_codmha) '
  );
end;

procedure Tfrx_ReportVendasBandeirasTEF.OrderBy;
begin
  OrderByTxt := 'Order By tef.rede ';
end;

procedure Tfrx_ReportVendasBandeirasTEF.PassarParametros;
Begin
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

procedure Tfrx_ReportVendasBandeirasTEF.PreencherDetalhe;
begin

end;

procedure Tfrx_ReportVendasBandeirasTEF.PreencherGrupo;
begin

end;

procedure Tfrx_ReportVendasBandeirasTEF.SelectSql;
begin
  SelectTxt := concat(
                'select tef.rede, sum(tef.valor_total) ValorTotal ',
                'from tb_nota_fiscal nf '
                );
end;

procedure Tfrx_ReportVendasBandeirasTEF.WhereSql;
begin
  WhereTxt := 'where tef.rede is not null ';

  if Parametros.Periodo then
  Begin
  WhereTxt := concat(
                 WhereTxt,
                ' and nf.nfl_dt_emissao between :DATAINI and :DATAFIM '
  );

  End;

  if Parametros.CodigoVendedorPedido > 0 then
      WhereTxt := concat(
                    WhereTxt,
                    'AND ( PED_CODVDO = :PED_CODVDO )  '
      );


  if Parametros.CodigoEstabelecimento > 0 then
      WhereTxt := concat(
                    WhereTxt,
                    ' AND ( FIN_CODMHA = :FIN_CODMHA )  '
      );
end;

end.
