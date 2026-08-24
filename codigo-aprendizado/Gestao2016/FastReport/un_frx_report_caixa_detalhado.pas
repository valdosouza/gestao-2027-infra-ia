unit un_frx_report_caixa_detalhado;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, prmCaixa, frxExportXLS;

type
  TFrx_report_caixa_detalhado = class(TFrxBaseReport)
  private
    { Private declarations }
  protected
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure GroupBy;Override;
    procedure PassarParametros; Override;
    procedure OrderBy;

  public
    { Public declarations }
    CodigoMovimento : Integer;
    Parametros : TParamCAixa;

  end;

var
  Frx_report_caixa_detalhado: TFrx_report_caixa_detalhado;

implementation

{$R *.dfm}

uses     UN_Sistema, UN_Principal, env;

{ TFrx_report_sangria }

procedure TFrx_report_caixa_detalhado.GroupBy;
begin

end;

procedure TFrx_report_caixa_detalhado.IniciaVariaveis;
begin
  inherited;
  TfrxReportPage(frxBase.Pages[1]).PaperWidth   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80'),80);
  TfrxReportPage(frxBase.Pages[1]).RightMargin  := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO', '0'),0);
  TfrxReportPage(frxBase.Pages[1]).LeftMargin   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO', '0'),0);
end;

procedure TFrx_report_caixa_detalhado.InnerJoinSql;
begin
  InnerJoinTxt := concat(
            '  INNER JOIN TB_USUARIO us ',
            '  ON (us.USU_CODIGO = cx.MVF_CODUSU) ',
            '  LEFT OUTER JOIN TB_FORMAPAGTO fm ',
            '  ON (fm.FPT_CODIGO = cx.MVF_CODFPT)'
  );

end;

procedure TFrx_report_caixa_detalhado.OrderBy;
begin
  OrderByTxt := Parametros.Ordenacao;
end;

procedure TFrx_report_caixa_detalhado.PassarParametros;
begin
  inherited;
  with Qr_Consulta, Parametros do
  Begin
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDate := DataInicial;
      ParamByName('DATAFIM').AsDate := DataFinal;
    End;

    if Usuario > 0 then
      ParamByName('MVF_CODUSU').AsInteger := Usuario;

    if CodigoEstabelecimento > 0 then
      ParamByName('MVF_CODMHA').AsInteger := CodigoEstabelecimento;

    if (Trim(Historico) <> '') then
      ParamByName('MVF_HISTORISCO').AsString:='%'+Historico+'%';

    if  ( Usuario > 0 ) then
      ParamByName('MVF_CODUSU').AsInteger:= Usuario;
  End;
end;

procedure TFrx_report_caixa_detalhado.SelectSql;
begin
  SelectTxt := concat(
             'SELECT cx.MVF_DATA, cx.MVF_HISTORISCO,cx.mvf_vl_credito, cx.mvf_vl_debito, us.USU_LOGIN ',
              'FROM TB_MOVIM_FINANCEIRO cx '
              );
end;

procedure TFrx_report_caixa_detalhado.WhereSql;
begin
  inherited;
  with Parametros do
  Begin
    WhereTxt := concat(
              'WHERE (MVF_CODCTB = 0) AND (MVF_CODMHA=:MVF_CODMHA) '
              );

    if TipoDocumento = 'CREDITO' then
      WhereTxt := concat(
                    WhereTxt,
                    'AND (MVF_VL_DEBITO =0 or MVF_VL_DEBITO IS NULL)'
      )
    else
    if Parametros.TipoDocumento = 'DEBITO' then
      WhereTxt := concat(
                    WhereTxt,
                    'AND (MVF_VL_CREDITO =0 or MVF_VL_CREDITO IS NULL)'
      );

    if (Trim(Historico) <> '') then
      WhereTxt := concat(
                    WhereTxt,
                    'AND (MVF_HISTORISCO LIKE :MVF_HISTORISCO) '
      );

    if Usuario > 0 then
      WhereTxt := concat(
                    WhereTxt,
                    'AND (MVF_CODUSU =:MVF_CODUSU) '
      );

    IF Periodo THEN
      WhereTxt := concat(
                    WhereTxt,
                    'AND (MVF_DATA BETWEEN :DATAINI AND :DATAFIM)  '
      );

  End;
end;

end.
