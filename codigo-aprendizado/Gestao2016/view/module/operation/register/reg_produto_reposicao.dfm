inherited RegProdutoReposicao: TRegProdutoReposicao
  BorderIcons = []
  Caption = 'Reposi'#231'ao autom'#225'tica'
  ClientHeight = 157
  ClientWidth = 581
  ExplicitWidth = 587
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel [0]
    Left = 0
    Top = 0
    Width = 581
    Height = 92
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object L_Descricao: TLabel
      Left = 89
      Top = 4
      Width = 111
      Height = 13
      Caption = 'Descri'#231#227'o da opera'#231#227'o'
      FocusControl = E_Descricao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object L_pacote_grande: TLabel
      Left = 8
      Top = 45
      Width = 72
      Height = 13
      Caption = 'Pacote Grande'
      FocusControl = E_pacote_grande
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object L_CodPro: TLabel
      Left = 9
      Top = 4
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = E_Descricao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object L_pacote_pequeno: TLabel
      Left = 101
      Top = 45
      Width = 80
      Height = 13
      Caption = 'Pacote Pequeno'
      FocusControl = E_pacote_pequeno
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object L_Metodo: TLabel
      Left = 194
      Top = 45
      Width = 36
      Height = 13
      Caption = 'M'#233'todo'
      FocusControl = E_pacote_pequeno
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 87
      Top = 19
      Width = 487
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_pacote_grande: TEdit_Setes
      Left = 7
      Top = 59
      Width = 90
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnEnter = E_pacote_grandeEnter
    end
    object E_CodPro: TEdit
      Left = 6
      Top = 19
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = E_CodProEnter
    end
    object E_pacote_pequeno: TEdit_Setes
      Left = 100
      Top = 59
      Width = 90
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
      OnEnter = E_pacote_pequenoEnter
    end
    object CB_METODO: TComboBox
      Left = 192
      Top = 59
      Width = 145
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 4
      Text = 'NEGATIVO'
      Items.Strings = (
        'NEGATIVO'
        'CASCATA'
        'SORTIDO')
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 92
    Width = 581
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 340
      Top = 5
      Width = 78
      Height = 55
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
      ExplicitLeft = 338
      ExplicitTop = 6
    end
    object Sb_Pesquisar: TSpeedButton
      AlignWithMargins = True
      Left = 420
      Top = 5
      Width = 78
      Height = 55
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
      ExplicitLeft = 418
      ExplicitTop = 6
    end
    object Sb_Sair: TSpeedButton
      AlignWithMargins = True
      Left = 500
      Top = 5
      Width = 78
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Sair- Esc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_SairClick
      ExplicitLeft = 581
    end
  end
  inherited MnuBase: TMainMenu
    Left = 112
    Top = 104
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Estoque
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 184
    Top = 104
  end
  object Cds_reposicao: TClientDataSet
    Left = 297
    Top = 105
    object Cds_reposicaoPPD_CODPRO_M: TIntegerField
      FieldName = 'PPD_CODPRO_M'
    end
    object Cds_reposicaoPPD_CODPRO_D: TIntegerField
      FieldName = 'PPD_CODPRO_D'
    end
    object Cds_reposicaoPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Size = 50
    end
    object Cds_reposicaoPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Size = 100
    end
    object Cds_reposicaoPPD_QTDE: TFloatField
      FieldName = 'PPD_QTDE'
    end
    object Cds_reposicaoPPD_METODO: TStringField
      FieldName = 'PPD_METODO'
    end
    object Cds_reposicaoPPD_QTDE_USED: TFloatField
      FieldName = 'PPD_QTDE_USED'
    end
  end
end
