unit un_frx_ReportProducaoMP;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_ReportProducao, frxClass, Data.DB, STQuery, frxExportCSV, frxExportPDF, frxDBSet, frxExportXLS;

type
  Tfrx_ReportProducaoMP = class(Tfrx_ReportProducao)
    Qr_ConsultaPA: TStringField;
    Qr_ConsultaMP: TStringField;
    Qr_ConsultaCLT_NUMERO: TStringField;
    Qr_ConsultaCLT_DT_VENCIMENTO: TDateField;
    Qr_ConsultaORP_DTCAD: TDateField;
    Qr_ConsultaPRO_CODIGO: TIntegerField;
    Qr_ConsultaORP_NUMERO: TStringField;
    Qr_ConsultaCONSTOTAL: TBCDField;
  private
    { Private declarations }
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;

  public
    { Public declarations }
    CodigoProducao : Integer;
  end;

var
  frx_ReportProducaoMP: Tfrx_ReportProducaoMP;

implementation

{$R *.dfm}

{ Tfrx_ReportProducaoMP }

procedure Tfrx_ReportProducaoMP.IniciaVariaveis;
begin
  inherited;
  //
end;

procedure Tfrx_ReportProducaoMP.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                   ' inner join tb_orp op ',
                   ' on (op.orp_codigo = opp.pre_codorp) ',
                   ' inner join tb_produto mp ',
                   ' on (mp.pro_codigo = opp.pre_codpro) ',
                   ' inner join tb_produto pa ',
                   ' on (pa.pro_codigo = op.orp_codpro) ',
                   ' inner join tb_movimento_lote ml ',
                   ' on ( opp.pre_codigo = ml.mlt_codvcl ) ',
                   ' inner join tb_ctrl_lote cl ',
                   ' on (cl.clt_codigo = ml.mlt_codclt) '
  );
end;

procedure Tfrx_ReportProducaoMP.OrderBy;
begin
  inherited;
  OrderByTxt := concat(
                'order by MP '
    );
end;

procedure Tfrx_ReportProducaoMP.PassarParametros;
begin
  with Qr_Consulta do
  Begin
    ParamByName('PRE_CODORP').AsInteger := CodigoProducao;
  End;
end;

procedure Tfrx_ReportProducaoMP.SelectSql;
begin
  inherited;
  SelectTxt := concat(
                  'SELECT op.orp_numero,op.orp_dtcad,pa.pro_codigo, pa.pro_descricao PA, mp.pro_descricao MP, ',
                  ' ml.mlt_qtde ConsTotal, ',
                  ' cl.clt_numero, cl.clt_dt_vencimento ',
                 'FROM TB_ORPPREV opp'
    );
end;

procedure Tfrx_ReportProducaoMP.WhereSql;
begin
  inherited;
  WhereTxt := Concat(
                  'WHERE opp.PRE_CODORP =:PRE_CODORP '
  );
end;

end.
