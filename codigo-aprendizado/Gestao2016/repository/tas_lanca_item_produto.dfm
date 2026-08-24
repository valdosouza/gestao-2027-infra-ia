inherited TasLancaItemProdutos: TTasLancaItemProdutos
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Lan'#231'a Item'
  ClientHeight = 166
  ClientWidth = 543
  Menu = nil
  ExplicitWidth = 549
  ExplicitHeight = 195
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 543
    Height = 97
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 153
    object Label1: TLabel
      Left = 6
      Top = 46
      Width = 83
      Height = 13
      Caption = 'Nome do Produto'
      FocusControl = E_Produto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 7
      Top = 7
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = E_Cd_Produto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Cd_Produto: TEdit
      Left = 6
      Top = 23
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = E_Cd_ProdutoExit
    end
    object E_Produto: TEdit
      Left = 6
      Top = 61
      Width = 528
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnExit = E_ProdutoExit
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 97
    Width = 543
    Height = 69
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 202
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 460
      Top = 5
      Width = 78
      Height = 59
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair- Esc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 456
      ExplicitTop = 15
      ExplicitHeight = 54
    end
    object Sb_Pesquisar: TSpeedButton
      AlignWithMargins = True
      Left = 380
      Top = 5
      Width = 78
      Height = 59
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Pesquisar- F7'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_PesquisarClick
      ExplicitLeft = 378
      ExplicitTop = 15
      ExplicitHeight = 54
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 300
      Top = 5
      Width = 78
      Height = 59
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Gravar - F5'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GravarClick
      ExplicitLeft = 284
      ExplicitTop = 15
      ExplicitHeight = 54
    end
  end
  inherited MnuBase: TMainMenu
    Left = 160
    Top = 65520
  end
end
