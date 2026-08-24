unit un_frx_report_sangria;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, frxExportXLS;

type
  TFrx_report_sangria = class(TFrxBaseReport)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodigoMovimento : Integer;
    procedure IniciaVariaveis;Override;

  end;

var
  Frx_report_sangria: TFrx_report_sangria;

implementation

{$R *.dfm}

uses     UN_Sistema;

{ TFrx_report_sangria }

procedure TFrx_report_sangria.FormCreate(Sender: TObject);
begin
//  inherited;

end;

procedure TFrx_report_sangria.IniciaVariaveis;
begin
  inherited;
  TfrxReportPage(frxBase.Pages[1]).PaperWidth := StrToFloatDef(Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80'),80);
  TfrxReportPage(frxBase.Pages[1]).RightMargin  := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO', '0'),0);
  TfrxReportPage(frxBase.Pages[1]).LeftMargin   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO', '0'),0);
  with Qr_Consulta do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    ParamByName('MVF_CODIGO').AsInteger := CodigoMovimento;
    Active := True;
    FetchAll;
  End;
end;

end.
