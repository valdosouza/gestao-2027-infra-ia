unit Un_RL_ReportCheque;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, prmCheques;

type
  TRL_ReportCheque = class(TRL_ReportList)
    procedure IniciaVariaveis;Override;
    procedure PassarParametros; Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;

    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Parametros :TParamCheques;

  end;

var
  RL_ReportCheque: TRL_ReportCheque;

implementation

{$R *.dfm}

{ TRL_ReporCheque }

procedure TRL_ReportCheque.IniciaVariaveis;
begin
  inherited;
  with Parametros do
  Begin
    if (CampoOrdenacao = 'CLIENTE') then
      CampoOrdenacao := 'EMP_NOME';
    if (CampoOrdenacao = 'EMITENTE') then
      CampoOrdenacao := 'CHQ_EMITENTE';
    if (CampoOrdenacao = 'PRÉ-DATADO') then
      CampoOrdenacao := 'CHQ_DATA';
  End;
end;

procedure TRL_ReportCheque.OrderBy;
begin
  OrderByTxt := ' ORDER BY ' + Parametros.CampoOrdenacao ;
end;

procedure TRL_ReportCheque.PassarParametros;
begin
  with Qr_Consulta, Parametros do
  Begin
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDate := DataInicial;
      ParamByName('DATAFIM').AsDate := DataFinal;
    End;
    if CodigoEmpresa > 0 then
      ParamByName('CODEMPRESA').AsInteger := CodigoEmpresa;
    if CodigoEstabelecimento > 0 then
      ParamByName('CODESTABELECIMENTO').AsInteger := CodigoEstabelecimento;
  end;
end;

procedure TRL_ReportCheque.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  IniciaVariaveis;
end;

procedure TRL_ReportCheque.WhereSql;
begin
  WhereTxt := 'where (CHQ_CODIGO IS NOT NULL) ';
  with Parametros do
  Begin
    if Periodo then WhereTxt := WhereTxt + ' AND CHQ_DATA BETWEEN :DATAINI AND :DATAFIM ';
    if CodigoEmpresa > 0 then WhereTxt := WhereTxt + ' AND (FIN_CODEMP =:CODEMPRESA) ';
    if CodigoEstabelecimento > 0 then WhereTxt := WhereTxt + ' AND ( CHQ_CODMHA=:CODESTABELECIMENTO ) ';
  End;

end;

end.
