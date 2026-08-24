object TasNotification: TTasNotification
  Left = 0
  Top = 0
  ParentCustomHint = False
  Align = alClient
  AlphaBlendValue = 200
  BiDiMode = bdLeftToRight
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Notifica'#231#245'es'
  ClientHeight = 122
  ClientWidth = 278
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Rg_Status: TRadioGroup
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 272
    Height = 46
    Align = alTop
    Caption = 'Situa'#231#227'o das notifica'#231#245'es'
    Columns = 3
    ItemIndex = 1
    Items.Strings = (
      'Lidas'
      'N'#227'o lidas'
      'Todas')
    TabOrder = 0
    OnClick = Rg_StatusClick
  end
  object Scx_Lista: TScrollBox
    AlignWithMargins = True
    Left = 3
    Top = 55
    Width = 272
    Height = 64
    ParentCustomHint = False
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    BorderStyle = bsNone
    DoubleBuffered = False
    Color = clWhite
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object Tm_Search: TTimer
    Enabled = False
    Interval = 50000
    OnTimer = Tm_SearchTimer
    Left = 226
    Top = 56
  end
end
