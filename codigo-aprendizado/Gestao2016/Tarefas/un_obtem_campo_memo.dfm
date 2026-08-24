object Fr_ObtemCampoMemo: TFr_ObtemCampoMemo
  Left = 0
  Top = 0
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'OBSERVA'#199#195'O'
  ClientHeight = 181
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    480
    181)
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 208
    Top = 142
    Width = 130
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    DoubleBuffered = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 344
    Top = 142
    Width = 130
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = 'Cancela'
    DoubleBuffered = False
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object E_Observacao: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 474
    Height = 134
    Align = alTop
    TabOrder = 2
  end
end
