unit Un_RL_Report;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, QuickRpt, Printers, Data.DB, STQuery, ControllerGeral,
  IBX.IBCustomDataSet, IBX.IBQuery;

type
  TRL_Report = class(TForm)
    Qrpt: TQuickRep;
    Qr_Consulta: TSTQuery;

    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    Geral : TControllerGeral;

    SelectTxt : String;
    InnerJoinTxt : String;
    WhereTxt : String;
    UnionSelectTxt : String;
    UnionInnerJoinTxt : String;
    UnionWhereTxt : String;
    OrderByTxt : String;
    GroupByTxt : String;

    procedure DefineImpressora;Virtual;
    procedure IniciaVariaveis;Virtual;
    procedure FinalizaVariaveis;Virtual;
    procedure Cabecalho; Virtual;

    procedure SelectSql;Virtual;
    procedure IncrementarSQl; Virtual;
    procedure InnerJoinSql;Virtual;
    procedure WhereSql;Virtual;
    procedure OrderBy;Virtual;
    procedure GroupBy;Virtual;
    procedure PassarParametros; Virtual;
    procedure Rodape;Virtual;
    procedure PreencherDetalhe;Virtual;
  public
    { Public declarations }
    CodigoEstabelecimento : Integer;
    procedure Buscar; Virtual;
  end;

var
  RL_Report: TRL_Report;

implementation

{$R *.dfm}

uses     Un_DM, Un_Regra_Negocio, UnFunctions, UnGeraLog;

procedure TRL_Report.Buscar;
begin
  with Qr_Consulta do
  Begin
    IF Transaction.InTransaction then Transaction.Commit  else Transaction.StartTransaction;
    Active := False;
    sql.Clear;
    SelectTxt := '';
    InnerJoinTxt := '';
    WhereTxt := '';
    UnionSelectTxt := '';
    UnionInnerJoinTxt := '';
    UnionWhereTxt := '';
    OrderByTxt := '';
    SelectSql;
    InnerJoinSql;
    WhereSql;
    GroupBy;
    OrderBy;
    SQL.Add(SelectTxt);
    SQL.Add(InnerJoinTxt);
    SQL.Add(WhereTxt);
    if Trim(UnionSelectTxt) <> '' then
    Begin
      SQL.Add(' Union ');
      SQL.Add(UnionSelectTxt);
    End;
    if Trim(UnionInnerJoinTxt) <> '' then
      SQL.Add(UnionInnerJoinTxt);
    if Trim(UnionWhereTxt) <> ''     then
      SQL.Add(UnionWhereTxt);
    SQL.Add(GroupByTxt);
    SQL.Add(OrderByTxt);
    PassarParametros;
    try
      Active := True;
      First;
    Except on E: Exception do
      GeralogCrashlytics('TRL_Report',E.Message);
    end;
  End;
end;

procedure TRL_Report.Cabecalho;
begin
  //Será escrito em cada Relatorio herdeiro conforme o caso
end;

procedure TRL_Report.DefineImpressora;
begin
  Qrpt.ShowProgress := True;
  Qrpt.PrinterSettings.PrinterIndex := Printers.Printer.Printerindex;
//  RL_Report.PrinterSettings.ApplySettings();
end;

procedure TRL_Report.FinalizaVariaveis;
begin
  FreeAndNil(Geral);
end;

procedure TRL_Report.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizaVariaveis;
end;

procedure TRL_Report.IncrementarSQl;
begin
  //Será escrito em cada Relatorio herdeiro conforme o caso
end;

procedure TRL_Report.IniciaVariaveis;
begin
  //Será escrito em cada Relatorio herdeiro conforme o caso
  Geral := TControllerGeral.create(self);
  Pc_AtivaEstabelecimento;
end;

procedure TRL_Report.InnerJoinSql;
begin
  //
end;

procedure TRL_Report.OrderBy;
begin
  //
end;

procedure TRL_Report.GroupBy;
Begin
  //
End;

procedure TRL_Report.PassarParametros;
begin
  //Será escrito em cada Relatorio herdeiro conforme o caso

end;

procedure TRL_Report.PreencherDetalhe;
begin
  //Será escrito em cada Relatorio herdeiro conforme o caso
end;

procedure TRL_Report.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DefineImpressora;
  IniciaVariaveis;
  Buscar;
end;

procedure TRL_Report.Rodape;
begin
  //Será escrito em cada Relatorio herdeiro conforme o caso
end;

procedure TRL_Report.SelectSql;
begin
  //
end;

procedure TRL_Report.WhereSql;
begin
  //
end;

end.
