object Fr_TEF_ExibeMenu: TFr_TEF_ExibeMenu
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'TEF'
  ClientHeight = 409
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 319
    Top = 50
    Width = 5
    Height = 309
    Align = alRight
    Visible = False
    ExplicitLeft = 237
    ExplicitHeight = 261
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 591
    Height = 50
    Align = alTop
    Caption = 'Panel1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 0
    Top = 50
    Width = 319
    Height = 309
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 24
    ParentFont = False
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 324
    Top = 50
    Width = 267
    Height = 309
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
    WordWrap = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 359
    Width = 591
    Height = 50
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      591
      50)
    object BitBtn1: TBitBtn
      Left = 96
      Top = 9
      Width = 130
      Height = 35
      Anchors = [akTop]
      Caption = '&OK'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 231
      Top = 9
      Width = 130
      Height = 35
      Anchors = [akTop]
      Caption = 'Cancela'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object BitBtn3: TBitBtn
      Left = 365
      Top = 9
      Width = 130
      Height = 35
      Anchors = [akTop]
      Caption = '&Tente Novamente'
      Kind = bkRetry
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
