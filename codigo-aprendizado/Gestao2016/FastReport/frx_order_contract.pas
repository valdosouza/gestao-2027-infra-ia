unit frx_order_contract;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxExportPDF, frxDBSet, Data.DB, STQuery, QuickRpt, grimgctrl, Vcl.ExtCtrls, frxExportHTML;

type
  TFrxOrderContract = class(TForm)
    frxBase: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    Qr_Consulta: TSTQuery;
    frxDBaseReport: TfrxDBDataset;
    frxHTMLExport1: TfrxHTMLExport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrxOrderContract: TFrxOrderContract;

implementation

{$R *.dfm}

end.
