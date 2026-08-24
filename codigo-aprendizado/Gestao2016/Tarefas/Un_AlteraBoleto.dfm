object Fr_AlteraBoleto: TFr_AlteraBoleto
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Alterar dados do Boleto'
  ClientHeight = 122
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 226
    Height = 56
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitWidth = 539
    ExplicitHeight = 201
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 81
      Height = 14
      Caption = 'Data Vencimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 124
      Top = 4
      Width = 58
      Height = 14
      Caption = 'Valor Boleto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Dt_Vencimento: TDateTimePicker
      Left = 5
      Top = 19
      Width = 114
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_ValorBoleto: TEdit_Setes
      Left = 121
      Top = 19
      Width = 98
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      Text = ''
    end
  end
  object Pnl_Botao: TPanel
    Left = 0
    Top = 56
    Width = 226
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 201
    ExplicitWidth = 539
    DesignSize = (
      226
      66)
    object Sb_Sair_0: TSpeedButton
      Left = 136
      Top = 7
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 678
    end
    object Sb_Gravar: TSpeedButton
      Left = 51
      Top = 7
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = Sb_GravarClick
      ExplicitLeft = 593
    end
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 410
    Top = 140
  end
end
