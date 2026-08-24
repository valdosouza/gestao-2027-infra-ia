unit un_frx_ReportProducao;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, Data.DB, STQuery, frxExportCSV, frxExportPDF, frxDBSet, frxExportXLS;

type
  Tfrx_ReportProducao = class(TFrxBaseReport)
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frx_ReportProducao: Tfrx_ReportProducao;

implementation

{$R *.dfm}

{ Tfrx_ReportProducao }

procedure Tfrx_ReportProducao.IniciaVariaveis;
begin
  inherited;
  //
end;

procedure Tfrx_ReportProducao.InnerJoinSql;
begin
  inherited;
  //
end;

procedure Tfrx_ReportProducao.OrderBy;
begin
  inherited;
  //
end;

procedure Tfrx_ReportProducao.PassarParametros;
begin
  inherited;
  //
end;

procedure Tfrx_ReportProducao.SelectSql;
begin
  inherited;
  //
end;

procedure Tfrx_ReportProducao.WhereSql;
begin
  inherited;
  //
end;

end.
