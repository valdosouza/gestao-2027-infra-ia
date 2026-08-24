inherited TasReceberDescontadaDevolucao: TTasReceberDescontadaDevolucao
  BorderIcons = [biSystemMenu]
  Caption = 'Devolu'#231#227'o de Duplicata Descontada'
  ClientHeight = 134
  ClientWidth = 376
  ExplicitWidth = 382
  ExplicitHeight = 183
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 67
    Width = 376
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 186
      Top = 5
      Width = 90
      Height = 57
      Align = alRight
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
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 282
      Top = 5
      Width = 89
      Height = 57
      Align = alRight
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
      ExplicitLeft = 402
      ExplicitTop = 6
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 0
    Width = 376
    Height = 67
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label14: TLabel
      Left = 7
      Top = 3
      Width = 64
      Height = 14
      Caption = 'Valor Original'
      FocusControl = E_VL_Original
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 188
      Top = 3
      Width = 76
      Height = 14
      Caption = 'Valor Opera'#231#227'o'
      FocusControl = E_VL_Original
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 279
      Top = 3
      Width = 62
      Height = 14
      Caption = 'Valor Liquido'
      FocusControl = E_VL_Liquido
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 96
      Top = 4
      Width = 74
      Height = 14
      Caption = 'Taxa Opera'#231#227'o'
      FocusControl = E_VL_Original
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_VL_Original: TEdit_Setes
      Left = 3
      Top = 19
      Width = 88
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object E_VL_Operacao: TEdit_Setes
      Left = 185
      Top = 19
      Width = 90
      Height = 21
      Alignment = taRightJustify
      TabOrder = 2
      Text = ''
      OnExit = E_VL_OperacaoExit
    end
    object E_VL_Liquido: TEdit_Setes
      Left = 277
      Top = 19
      Width = 90
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 3
      Text = ''
    end
    object E_Tx_Operacao: TEdit_Setes
      Left = 93
      Top = 19
      Width = 90
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      Text = ''
      OnExit = E_Tx_OperacaoExit
    end
  end
  inherited MnuBase: TMainMenu
    Left = 392
    Top = 65528
  end
end
