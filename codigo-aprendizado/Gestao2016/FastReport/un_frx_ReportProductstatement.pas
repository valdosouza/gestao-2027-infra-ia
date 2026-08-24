unit un_frx_ReportProductstatement;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, Data.DB, STQuery, frxExportCSV, frxClass, frxExportPDF, frxDBSet;

type
  Tfrx_ReportProductstatement = class(TFrxBaseReport)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frx_ReportProductstatement: Tfrx_ReportProductstatement;

implementation

{$R *.dfm}

end.
