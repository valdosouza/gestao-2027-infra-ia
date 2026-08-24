object FormQrCode: TFormQrCode
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Permitir o escaneamento do QrCode'
  ClientHeight = 239
  ClientWidth = 351
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pQRCode: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 345
    Height = 183
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object imgQRCode: TImage
      Left = 1
      Top = 1
      Width = 343
      Height = 181
      Align = alClient
      Center = True
      Proportional = True
      Stretch = True
      ExplicitWidth = 327
      ExplicitHeight = 100
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 192
    Width = 345
    Height = 44
    Align = alBottom
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      345
      44)
    object btOk: TBitBtn
      Left = 116
      Top = 0
      Width = 100
      Height = 35
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btOkClick
    end
  end
  object ACBrAbecsPinPad1: TACBrAbecsPinPad
    Left = 232
    Top = 96
  end
end
