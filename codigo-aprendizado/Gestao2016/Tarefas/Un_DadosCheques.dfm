object Fr_DadosCheques: TFr_DadosCheques
  Left = 0
  Top = 0
  Caption = 'Dados do Cheque'
  ClientHeight = 205
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 413
    Height = 136
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object E_BandeiraCartao: TLabel
      Left = 2
      Top = 2
      Width = 196
      Height = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'DADOS DA 1'#186' CHEQUE'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label18: TLabel
      Left = 9
      Top = 23
      Width = 85
      Height = 14
      Caption = 'Nome do Emitente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 8
      Top = 59
      Width = 31
      Height = 14
      Caption = 'Banco'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 45
      Top = 59
      Width = 40
      Height = 14
      Caption = 'Ag'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 186
      Top = 59
      Width = 52
      Height = 14
      Caption = 'N'#186' Cheque'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 332
      Top = 59
      Width = 25
      Height = 14
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 247
      Top = 59
      Width = 54
      Height = 14
      Caption = 'Pr'#233'-Datado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 94
      Top = 59
      Width = 87
      Height = 14
      Caption = 'N'#186' conta-corrente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Banco: TEdit_Setes
      Left = 6
      Top = 73
      Width = 36
      Height = 21
      TabOrder = 1
      Text = ''
    end
    object E_Agencia: TEdit_Setes
      Left = 43
      Top = 73
      Width = 48
      Height = 21
      MaxLength = 7
      TabOrder = 2
      Text = ''
    end
    object E_NumChq: TEdit_Setes
      Left = 184
      Top = 73
      Width = 59
      Height = 21
      MaxLength = 7
      TabOrder = 4
      Text = ''
    end
    object E_VL_Cheque: TEdit_Setes
      Left = 327
      Top = 73
      Width = 81
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 6
      Text = ''
    end
    object E_ContaCorrente: TEdit_Setes
      Left = 92
      Top = 73
      Width = 91
      Height = 21
      MaxLength = 7
      TabOrder = 3
      Text = ''
    end
    object E_Data: TMaskEdit
      Left = 245
      Top = 73
      Width = 81
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 5
      Text = '  /  /    '
    end
    object Rg_TipoCheque: TRadioGroup
      Left = 5
      Top = 94
      Width = 135
      Height = 37
      Caption = 'Tipo Cheque'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Pr'#243'prio'
        'Terceiro')
      ParentFont = False
      TabOrder = 7
    end
    object E_Emitente: TEdit
      Left = 6
      Top = 37
      Width = 400
      Height = 21
      TabOrder = 0
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 136
    Width = 413
    Height = 69
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      413
      69)
    object SB_Confirmar: TSpeedButton
      Left = 316
      Top = 7
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
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
        77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
        07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 812
      ExplicitTop = 99
    end
  end
end
