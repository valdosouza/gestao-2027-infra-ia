object Fr_ObtemCampo: TFr_ObtemCampo
  Left = 0
  Top = 0
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'CART'#195'O PR'#201'-PAGO'
  ClientHeight = 90
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object E_Numero: TEdit
    Left = 7
    Top = 7
    Width = 323
    Height = 31
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 64
    Top = 44
    Width = 130
    Height = 35
    Caption = '&OK'
    DoubleBuffered = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 44
    Width = 130
    Height = 35
    Caption = 'Cancela'
    DoubleBuffered = False
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
