unit Un_RL_ReportOrder_10;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportOrder, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportOrder_10 = class(TRL_ReportOrder)
    Img_Logo: TQRImage;
    QRImage1: TQRImage;
    QRImage2: TQRImage;
    procedure cabecalho;override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportOrder_10: TRL_ReportOrder_10;

implementation

{$R *.dfm}

uses     Un_Regra_Negocio;

{ TRL_ReportOrder1 }

procedure TRL_ReportOrder_10.cabecalho;
begin
  inherited;
  Fc_BuscaImagemEmpresa(Img_logo.Picture, 'LOGO');
end;

end.
