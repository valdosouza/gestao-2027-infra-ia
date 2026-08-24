object Fr_DadosCartaoEletronico: TFr_DadosCartaoEletronico
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Dados do Cart'#227'o'
  ClientHeight = 205
  ClientWidth = 284
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 136
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label29: TLabel
      Left = 5
      Top = 23
      Width = 111
      Height = 14
      Caption = 'Identifica'#231#227'o do Cart'#227'o'
      FocusControl = E_Identifica
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 5
      Top = 92
      Width = 41
      Height = 14
      Caption = 'Validade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label39: TLabel
      Left = 5
      Top = 58
      Width = 109
      Height = 14
      Caption = 'C'#243'digo de Autoriza'#231#227'o'
      FocusControl = E_Autoriza
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_BandeiraCartao: TLabel
      Left = 2
      Top = 2
      Width = 179
      Height = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'NOME DA BANDEIRA'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object E_Identifica: TEdit
      Left = 5
      Top = 37
      Width = 221
      Height = 21
      TabOrder = 0
    end
    object E_Autoriza: TEdit
      Left = 5
      Top = 72
      Width = 221
      Height = 21
      TabOrder = 1
    end
    object E_Validade: TMaskEdit
      Left = 5
      Top = 106
      Width = 96
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 136
    Width = 284
    Height = 69
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      284
      69)
    object SB_Confirmar: TSpeedButton
      Left = 192
      Top = 6
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
    end
  end
end
