unit Un_RL_ReportChequeDisponivelCaixa;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportChequeSimples, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportChequeDisponivelCaixa = class(TRL_ReportChequeSimples)
    procedure WhereSql;Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportChequeDisponivelCaixa: TRL_ReportChequeDisponivelCaixa;

implementation

{$R *.dfm}

procedure TRL_ReportChequeDisponivelCaixa.WhereSql;
begin
  inherited;
  WhereTxt := WhereTxt + ' AND ( (CHQ_QT_PAG IS NULL) OR (CHQ_QT_PAG = 0) )  ';
end;

end.
