object Fr_Fatura_Fin: TFr_Fatura_Fin
  Left = 408
  Top = 20
  BorderIcons = []
  Caption = 'Faturamento para o Financeiro'
  ClientHeight = 291
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Botao: TPanel
    Left = 0
    Top = 225
    Width = 533
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 438
      Top = 5
      Width = 90
      Height = 56
      Align = alRight
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
      ExplicitLeft = 443
      ExplicitTop = 6
    end
  end
  object Scx_Parcela: TScrollBox
    Left = 0
    Top = 59
    Width = 533
    Height = 54
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    Align = alClient
    TabOrder = 1
  end
  object Grp_Parcela: TGroupBox
    Left = 0
    Top = 0
    Width = 533
    Height = 59
    Align = alTop
    Caption = 'N'#250'meros Parcelas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Sb_Parcelar: TSpeedButton
      Left = 86
      Top = 17
      Width = 72
      Height = 22
      Caption = 'Parcelar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_ParcelarClick
    end
    object Sb_Vista: TSpeedButton
      Left = 159
      Top = 17
      Width = 72
      Height = 22
      Caption = #192' Vista - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_VistaClick
    end
    object E_Nr_PArcelas: TEdit_Setes
      Left = 5
      Top = 17
      Width = 75
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object Chbx_Entrada: TCheckBox
      Left = 239
      Top = 8
      Width = 204
      Height = 17
      Caption = 'Primeira Parcela com Entrada'
      TabOrder = 1
    end
    object ChBx_Duplicata: TCheckBox
      Left = 239
      Top = 39
      Width = 106
      Height = 17
      Caption = 'Imprimir Duplicata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object ChBx_Vl_ST: TCheckBox
      Left = 239
      Top = 23
      Width = 235
      Height = 17
      Caption = 'Incluir o Valor de S.T na 1'#186' Parcela'
      TabOrder = 3
      OnClick = ChBx_Vl_STClick
    end
  end
  object Grp_Pagamento: TGroupBox
    Left = 0
    Top = 113
    Width = 533
    Height = 112
    Align = alBottom
    Caption = ' Totalizador '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      533
      112)
    object Label9: TLabel
      Left = 361
      Top = 18
      Width = 74
      Height = 16
      Caption = 'DIFEREN'#199'A'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 363
      Top = 62
      Width = 115
      Height = 16
      Caption = 'VALOR DO TROCO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LB_TL_Informado: TLabel
      Left = 182
      Top = 18
      Width = 129
      Height = 16
      Caption = 'VALOR  INFORMADO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 18
      Width = 86
      Height = 16
      Caption = 'VALOR TOTAL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_NovaFormaPagto: TSpeedButton
      Left = 25
      Top = 65
      Width = 325
      Height = 38
      Anchors = [akLeft, akBottom]
      Caption = 'Incluir Forma de Pagamento - F2'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = Sb_NovaFormaPagtoClick
    end
    object E_Diferenca: TEdit_Setes
      Left = 358
      Top = 35
      Width = 161
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
    end
    object E_VL_Troco: TEdit_Setes
      Left = 358
      Top = 79
      Width = 161
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
    end
    object e_vl_informado: TEdit_Setes
      Left = 180
      Top = 35
      Width = 177
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '0,00'
    end
    object E_VL_Total: TEdit_Setes
      Left = 14
      Top = 35
      Width = 164
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = '0,00'
    end
  end
end
