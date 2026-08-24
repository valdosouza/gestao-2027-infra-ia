unit un_rl_etiq_BobinaTermica;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, Data.DB, STQuery, frxExportCSV, frxExportPDF, frxDBSet;

type
  Trl_etiq_BobinaTermica = class(TForm)
    frxBase: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rl_etiq_BobinaTermica: Trl_etiq_BobinaTermica;

implementation

{$R *.dfm}

end.
