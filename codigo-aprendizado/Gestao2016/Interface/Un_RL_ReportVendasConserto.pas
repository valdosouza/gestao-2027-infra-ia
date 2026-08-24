unit Un_RL_ReportVendasConserto;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportVendasGeral, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportVendasConserto = class(TRL_ReportVendasGeral)
    procedure InnerJoinSql;Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportVendasConserto: TRL_ReportVendasConserto;

implementation

{$R *.dfm}

{ TRL_ReportVendasConserto }

procedure TRL_ReportVendasConserto.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := InnerJoinTxt +
                '  inner JOIN TB_CONSERTO  '+
                '  ON (CST_CODPED = ped_codigo)'+
                '  inner join tb_cotacao  '+
                '  on ( ctc_codped = cst_codped ) ';
end;

end.
