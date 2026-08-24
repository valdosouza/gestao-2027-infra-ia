unit Un_RL_ReportChequeEnvioBanco;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportChequeSimples, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportChequeEnvioBanco = class(TRL_ReportChequeSimples)
    procedure WhereSql;Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportChequeEnvioBanco: TRL_ReportChequeEnvioBanco;

implementation

{$R *.dfm}

procedure TRL_ReportChequeEnvioBanco.WhereSql;
begin
  inherited;
  WhereTxt := WhereTxt + ' AND ( chq_estado = ''B'') ';
end;

end.
