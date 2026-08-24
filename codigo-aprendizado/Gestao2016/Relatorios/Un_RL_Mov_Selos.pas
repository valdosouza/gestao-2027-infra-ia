unit Un_RL_Mov_Selos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, STQuery, ExtCtrls, QuickRpt, QRCtrls;

type
  TRL_Mov_Selos = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QR_Logo: TQRImage;
    TitleBand1: TQRBand;
    Qr_Fantasia: TQRLabel;
    QR_Nome: TQRLabel;
    QR_Endereco: TQRLabel;
    Qr_Informacao: TQRLabel;
    Qr_Titulo: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Busca;
  end;

var
  RL_Mov_Selos: TRL_Mov_Selos;

implementation

uses     Un_DM, UN_Sistema;
{$R *.dfm}

{ TRL_Mov_Selos }

procedure TRL_Mov_Selos.Pc_Busca;
begin
//
end;

procedure TRL_Mov_Selos.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Qr_Titulo.Caption := Qr_Titulo.Caption + ' '+ DateToStr(Fr_Imp_Selos.E_Data_Ini.Date) + ' A ' + DateToStr(Fr_Imp_Selos.E_Data_fim.Date);
end;

procedure TRL_Mov_Selos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := caFree;
  RL_Mov_Selos := nil;
end;

procedure TRL_Mov_Selos.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
end;

end.
