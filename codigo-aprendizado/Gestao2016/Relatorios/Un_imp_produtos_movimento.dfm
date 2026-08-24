inherited Fr_imp_produtos_movimento: TFr_imp_produtos_movimento
  Caption = 'Tipos de Movimento de Estoque'
  ClientHeight = 386
  ClientWidth = 371
  Menu = nil
  ExplicitWidth = 377
  ExplicitHeight = 415
  PixelsPerInch = 96
  TextHeight = 13
  object Rg_Tipo: TRadioGroup [0]
    Left = 0
    Top = 0
    Width = 371
    Height = 320
    Align = alClient
    Caption = 'Tipos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Items.Strings = (
      'Toda a Movimenta'#231#227'o'
      'Vendas'
      'Compras '
      'Ajustes de Estoque'
      'Produ'#231#227'o - Materia Prima'
      'Produ'#231#227'o - Produto Acabado'
      'Extintores - Produtos de Consumo'
      'Lan'#231'amentos com os lotes'
      'Lan'#231'amentos Avulsos')
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 320
    Width = 371
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      371
      66)
    object SB_Confirmar: TSpeedButton
      Left = 178
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
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 503
    end
    object SB_Sair_0: TSpeedButton
      Left = 274
      Top = 6
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
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 336
  end
end
