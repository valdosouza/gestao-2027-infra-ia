object Fr_Img_Site_Produto: TFr_Img_Site_Produto
  Left = 186
  Top = 33
  Caption = 'Imagens do Produto'
  ClientHeight = 496
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 111
    Width = 790
    Height = 279
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object img_amostra: TImage
      Left = 2
      Top = 2
      Width = 786
      Height = 275
      Align = alClient
      Center = True
      ExplicitLeft = 4
      ExplicitTop = 40
    end
  end
  object Pnl_Navegacao: TPanel
    Left = 0
    Top = 390
    Width = 790
    Height = 42
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 6
      Width = 225
      Height = 33
      DataSource = Ds_Cadastro
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
      TabOrder = 0
      OnClick = DBNavigator1Click
    end
  end
  object pnl_botoes: TPanel
    Left = 0
    Top = 432
    Width = 790
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object SB_Inserir: TSpeedButton
      AlignWithMargins = True
      Left = 307
      Top = 5
      Width = 78
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Inserir - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_InserirClick
      ExplicitLeft = 318
    end
    object SB_Excluir: TSpeedButton
      AlignWithMargins = True
      Left = 467
      Top = 5
      Width = 78
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Excluir - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ExcluirClick
      ExplicitLeft = 475
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 547
      Top = 5
      Width = 78
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GravarClick
      ExplicitLeft = 559
      ExplicitTop = 6
    end
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 707
      Top = 5
      Width = 78
      Height = 54
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 710
    end
    object SB_Alterar: TSpeedButton
      AlignWithMargins = True
      Left = 387
      Top = 5
      Width = 78
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Alterar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_AlterarClick
      ExplicitLeft = 396
    end
    object SB_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 627
      Top = 5
      Width = 78
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 632
    end
  end
  object pnl_fundos: TPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 111
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object Sb_Carr_Imagem: TSpeedButton
      Left = 674
      Top = 16
      Width = 108
      Height = 27
      Caption = 'Carregar Imagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      NumGlyphs = 4
      ParentFont = False
      OnClick = Sb_Carr_ImagemClick
    end
    object Label34: TLabel
      Left = 6
      Top = 6
      Width = 197
      Height = 13
      Caption = 'Indique o Caminho da imagem do Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 242
      Top = 47
      Width = 119
      Height = 14
      Caption = 'link do Banner (opcional)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_PathIMG: TEdit
      Left = 5
      Top = 21
      Width = 664
      Height = 21
      TabOrder = 0
    end
    object E_link: TEdit
      Left = 237
      Top = 62
      Width = 543
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object Rg_ImageTarget: TRadioGroup
      Left = 5
      Top = 43
      Width = 228
      Height = 43
      Caption = 'Tipo da Imagem'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Normal'
        'Capa'
        'Banner')
      ParentFont = False
      TabOrder = 2
    end
    object ChBx_Redimensionar: TCheckBox
      Left = 4
      Top = 88
      Width = 230
      Height = 17
      Caption = 'Redimensionar para o tamanho 360 X 360'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object OpenDialogo: TOpenDialog
    Filter = 'JPeg|*.jpg'
    Left = 540
    Top = 41
  end
  object Qr_Cadastro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_CadastroAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * '
      'FROM TB_IMAGES'
      'WHERE table_id=:table_id')
    Left = 128
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'table_id'
        ParamType = ptUnknown
      end>
  end
  object Ds_Cadastro: TDataSource
    DataSet = Qr_Cadastro
    Left = 128
    Top = 125
  end
end
