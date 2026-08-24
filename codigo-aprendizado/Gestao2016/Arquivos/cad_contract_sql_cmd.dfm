inherited CadContractSqlCmd: TCadContractSqlCmd
  BorderIcons = [biSystemMenu]
  Caption = 'Contrato - Selea'#231#227'o de Dados  - SQL'
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 636
    Height = 332
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 2
      Width = 301
      Height = 13
      Align = alTop
      Caption = 'Informe o Comando SQL para a sele'#231#227'o dos dados do contrato'
    end
    object E_SQL: TMemo
      Left = 2
      Top = 15
      Width = 632
      Height = 315
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 332
    Width = 636
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 446
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
      ExplicitTop = 4
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 542
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
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
  end
  inherited MnuBase: TMainMenu
    Left = 88
    Top = 32
  end
end
