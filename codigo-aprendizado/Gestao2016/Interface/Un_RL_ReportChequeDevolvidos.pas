unit Un_RL_ReportChequeDevolvidos;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportChequeSimples, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportChequeDevolvidos = class(TRL_ReportChequeSimples)
    procedure WhereSql;Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportChequeDevolvidos: TRL_ReportChequeDevolvidos;

implementation

{$R *.dfm}

procedure TRL_ReportChequeDevolvidos.WhereSql;
begin
  inherited;
  WhereTxt := WhereTxt + ' AND ( CHQ_DEVOLVIDO = ''S'' )  ';
end;

end.
