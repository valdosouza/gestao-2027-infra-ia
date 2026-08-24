inherited TasChangePriceByScale: TTasChangePriceByScale
  BorderIcons = [biSystemMenu]
  Caption = 'Alterar Pre'#231'o por Escala'
  ClientWidth = 496
  ExplicitWidth = 502
  PixelsPerInch = 96
  TextHeight = 13
  object DBG_Tabela: TDBGrid [0]
    Left = 0
    Top = 0
    Width = 496
    Height = 332
    Align = alClient
    Color = clWhite
    DataSource = Ds_Pesquisa
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBG_TabelaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'TPR_NOME'
        Title.Caption = 'Nome da Tabela'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 248
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TPR_MAR_VIA_ESCALA'
        Title.Caption = 'Margem Escala'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 97
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TPR_MODALIDADE'
        Title.Alignment = taCenter
        Title.Caption = 'Modalidade'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 72
        Visible = True
      end>
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 332
    Width = 496
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 306
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
      ExplicitLeft = 489
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 402
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
      OnDblClick = SB_Sair_0DblClick
      ExplicitTop = 6
    end
  end
  inherited MnuBase: TMainMenu
    Top = 48
  end
  object Cds_Pesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 136
    object Cds_PesquisaTPR_CODIGO: TIntegerField
      FieldName = 'TPR_CODIGO'
      Origin = '"TB_TABELA_PRECO"."TPR_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_PesquisaTPR_NOME: TWideStringField
      FieldName = 'TPR_NOME'
      Origin = '"TB_TABELA_PRECO"."TPR_NOME"'
      Size = 50
    end
    object Cds_PesquisaTPR_MODALIDADE: TWideStringField
      FieldName = 'TPR_MODALIDADE'
      Origin = '"TB_TABELA_PRECO"."TPR_MODALIDADE"'
      Size = 1
    end
    object Cds_PesquisaTPR_MAR_VIA_ESCALA: TBCDField
      FieldName = 'TPR_MAR_VIA_ESCALA'
      Origin = '"TB_TABELA_PRECO"."TPR_MAR_VIA_ESCALA"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Cds_PesquisaTPR_MAR_LRC: TFloatField
      FieldName = 'TPR_MAR_LRC'
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Cds_Pesquisa
    Left = 384
    Top = 184
  end
end
