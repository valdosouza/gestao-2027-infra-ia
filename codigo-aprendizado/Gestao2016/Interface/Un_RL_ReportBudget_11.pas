unit Un_RL_ReportBudget_11;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportBudget, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportBudget_11 = class(TRL_ReportBudget)
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportBudget_11: TRL_ReportBudget_11;

implementation

{$R *.dfm}

{ TRL_ReportBudget_11 }



procedure TRL_ReportBudget_11.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  //  inherited;
  with Qr_Pedido do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
  End;
end;

end.
