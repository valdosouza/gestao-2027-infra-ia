object Fr_TEF_ObtemCampo: TFr_TEF_ObtemCampo
  Left = 0
  Top = 0
  Caption = 'TEF'
  ClientHeight = 164
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    509
    164)
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 72
    Width = 443
    Height = 31
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object BitBtn1: TBitBtn
    Left = 58
    Top = 119
    Width = 130
    Height = 35
    Anchors = [akTop]
    Caption = '&OK'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 193
    Top = 119
    Width = 130
    Height = 35
    Anchors = [akTop]
    Caption = 'Cancela'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn3: TBitBtn
    Left = 330
    Top = 119
    Width = 130
    Height = 35
    Anchors = [akTop]
    Caption = '&Voltar'
    Kind = bkRetry
    NumGlyphs = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 509
    Height = 50
    Align = alTop
    Caption = 'Panel1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
