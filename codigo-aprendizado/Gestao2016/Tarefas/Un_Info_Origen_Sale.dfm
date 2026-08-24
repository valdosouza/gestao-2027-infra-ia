object Fr_Info_Origen_Sale: TFr_Info_Origen_Sale
  Left = 268
  Top = 222
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Informe a origem desta venda'
  ClientHeight = 152
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Rg_Origens_Sale: TRadioGroup
    Left = 0
    Top = 0
    Width = 423
    Height = 90
    Align = alClient
    Caption = 'Como est'#225' venda se originou?'
    Items.Strings = (
      '1'
      '2'
      '3')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 90
    Width = 423
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      423
      62)
    object SB_Confirmar: TSpeedButton
      Left = 239
      Top = 5
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
    end
    object SB_Sair_0: TSpeedButton
      Left = 329
      Top = 5
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
    end
  end
  object Qr_Origen_Sale: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select *'
      'from tb_sale_origen'
      'WHERE (ID>0)'
      'ORDER BY'
      'rand();')
    Left = 128
    Top = 24
  end
end
