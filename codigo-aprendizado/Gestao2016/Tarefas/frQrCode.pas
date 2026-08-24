unit frQrCode;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, ACBrDelphiZXingQRCode, ACBrBase, ACBrAbecsPinPad, Vcl.Imaging.pngimage, System.Math;

type
  TFormQrCode = class(TForm)
    pQRCode: TPanel;
    imgQRCode: TImage;
    Panel1: TPanel;
    btOk: TBitBtn;
    ACBrAbecsPinPad1: TACBrAbecsPinPad;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    procedure SendQRCodePinPad;
    procedure ActivatePinPad;
    procedure MediaLoad;
  public
    { Public declarations }
    Dados: String;
  end;

var
  FormQrCode: TFormQrCode;

implementation

{$R *.dfm}

uses     UN_Sistema;

procedure TFormQrCode.btOkClick(Sender: TObject);
begin
  if ( Fc_Aq_Geral('L','TEF','TEF_QRCODE_PIX_PINPAD','N') = 'S') then
    ACBrAbecsPinPad1.DSP();//Limpar a tela
    //ACBrAbecsPinPad1.DSP('Setes', 'Aguardando...');
end;

procedure TFormQrCode.FormShow(Sender: TObject);
Var
  QRCode: TDelphiZXingQRCode;
  QRCodeBitmap: TBitmap;
  Row, Column: Integer;
begin
  QRCode := TDelphiZXingQRCode.Create;
  QRCodeBitmap := TBitmap.Create;
  try
    QRCode.Encoding  := qrUTF8NoBOM;
    QRCode.QuietZone := 2;
    QRCode.Data      := widestring(Dados);

    QRCodeBitmap.Width  := QRCode.Columns;
    QRCodeBitmap.Height := QRCode.Rows;

    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack
        else
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
      end;
    end;

    imgQRCode.Picture.Bitmap.Assign(QRCodeBitmap);

    if ( Fc_Aq_Geral('L','TEF','TEF_QRCODE_PIX_PINPAD','N') = 'S') then
      SendQRCodePinPad;
  finally
    QRCode.Free;
    QRCodeBitmap.Free;
  end;
end;

procedure TFormQrCode.ActivatePinPad;
begin
  ACBrAbecsPinPad1.Port := concat('COM',Fc_Aq_Geral('L','TEF','TEF_PORTA_PINPAD','1'));
  ACBrAbecsPinPad1.IsEnabled := True;
end;

procedure TFormQrCode.SendQRCodePinPad;
begin
  ActivatePinPad;
  MediaLoad;
end;

procedure TFormQrCode.MediaLoad;
var
  ms: TMemoryStream;
  png: TPngImage;
  qrsize: Integer;
begin
  ms := TMemoryStream.Create;
  png := TPngImage.Create;
  try
    qrsize := min( ACBrAbecsPinPad1.PinPadCapabilities.DisplayGraphicPixels.Cols,
                   ACBrAbecsPinPad1.PinPadCapabilities.DisplayGraphicPixels.Rows) - 20;
    png.Assign(imgQRCode.Picture.Bitmap);
    png.Resize(qrsize, qrsize);
    png.Canvas.StretchDraw(png.Canvas.ClipRect, imgQRCode.Picture.Bitmap);
    png.SaveToStream(ms);
    imgQRCode.Picture.Assign(png);
    ACBrAbecsPinPad1.LoadMedia('QRCODE01', ms, mtPNG);
    ACBrAbecsPinPad1.DSI('QRCODE01');
  finally
    ms.Free;
    png.Free;
  end;
end;

{procedure TFormQrCode.MediaLoad;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    imgQRCode.Picture.Graphic.SaveToStream(ms);
    ACBrAbecsPinPad1.LoadMedia('QRCODE01', ms, TACBrAbecsPinPadMediaType(0));
    ACBrAbecsPinPad1.DSI('QRCODE01');
  finally
    ms.Free;
  end;
end;  }

end.
