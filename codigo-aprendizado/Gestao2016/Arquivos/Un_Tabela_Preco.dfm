inherited Fr_Tabela_Preco: TFr_Tabela_Preco
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Tabelas de Pre'#231'o'
  ClientHeight = 558
  ClientWidth = 527
  ExplicitWidth = 533
  ExplicitHeight = 607
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_fundo: TPanel [0]
    Left = 0
    Top = 141
    Width = 527
    Height = 355
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label2: TLabel
      Left = 434
      Top = 4
      Width = 41
      Height = 13
      Caption = 'Validade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 4
      Width = 28
      Height = 13
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 342
      Top = 4
      Width = 86
      Height = 13
      Caption = 'Margem de Lucro '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 40
      Width = 92
      Height = 13
      Caption = 'Margem Por Escala'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 103
      Top = 57
      Width = 402
      Height = 13
      Caption = 
        'Esta op'#231#227'o depende de uma Tabela '#224' Vista para que a escala acont' +
        'e'#231'a a partir dela'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 5
      Top = 17
      Width = 335
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Dt_Validade: TEdit
      Left = 432
      Top = 17
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_Mrg_Lucro: TEdit
      Left = 341
      Top = 17
      Width = 88
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Chbx_Principal: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 278
      Width = 517
      Height = 17
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      Caption = 
        'Tabela Principal - Nas listas de pre'#231'o ser'#225' exibida na primeira ' +
        'posi'#231#227'o.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chbx_mobile: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 297
      Width = 517
      Height = 17
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      Caption = 'Enviar Tabela para o dispositivo m'#243'vel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object Rg_Casas: TRadioGroup
      Left = 6
      Top = 215
      Width = 250
      Height = 42
      Caption = '[ Casas Decimais ]'
      Columns = 6
      ItemIndex = 0
      Items.Strings = (
        '0'
        '2'
        '3'
        '4'
        '5'
        '6')
      TabOrder = 6
    end
    object ChkBx_FormasPAgto: TCheckListBox
      Left = 262
      Top = 103
      Width = 253
      Height = 171
      Color = clCream
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Style = lbOwnerDrawFixed
      TabOrder = 7
    end
    object Panel1: TPanel
      Left = 262
      Top = 79
      Width = 252
      Height = 23
      Caption = 'Lista de Formas de Pagamento'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 8
    end
    object rdg_modalidade: TRadioGroup
      Left = 6
      Top = 124
      Width = 250
      Height = 42
      Caption = 'Modalidade:'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Vista '
        'Prazo'
        'Ambos')
      ParentFont = False
      TabOrder = 9
    end
    object rdg_Tipo_Cliente: TRadioGroup
      Left = 6
      Top = 81
      Width = 250
      Height = 42
      Caption = 'Tipo de Cliente'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Consumidor'
        'Revenda'
        'Ambos')
      ParentFont = False
      TabOrder = 10
    end
    object rG_lojista: TRadioGroup
      Left = 6
      Top = 167
      Width = 250
      Height = 42
      Caption = 'Lojista'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'SIM'
        'N'#227'o'
        'Tanto Faz')
      TabOrder = 11
    end
    object CHBX_Ativa: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 335
      Width = 517
      Height = 17
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      Caption = 'Tabela Ativa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object CHBX_Margem_Prioritaria: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 316
      Width = 517
      Height = 17
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      Caption = 
        'Atualizar o pre'#231'o dos produtos exclusivamente pela margem de luc' +
        'ro determinada nesta tabela '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object Pnl_Progresso: TPanel
      Left = 91
      Top = 129
      Width = 397
      Height = 41
      Caption = 'Pnl_Progresso'
      TabOrder = 5
      Visible = False
      object Gg_Progresso: TGauge
        Left = 1
        Top = 1
        Width = 395
        Height = 28
        Align = alTop
        Progress = 0
        ExplicitLeft = 0
        ExplicitTop = -4
      end
    end
    object E_Mrg_Via_Escala: TEdit
      Left = 6
      Top = 53
      Width = 93
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
  end
  object Pnl_Botao: TPanel [1]
    Left = 0
    Top = 496
    Width = 527
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Inserir: TSpeedButton
      AlignWithMargins = True
      Left = 40
      Top = 5
      Width = 77
      Height = 52
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
      OnClick = Sb_InserirClick
      ExplicitLeft = 44
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Alterar: TSpeedButton
      AlignWithMargins = True
      Left = 119
      Top = 5
      Width = 77
      Height = 52
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
      OnClick = Sb_AlterarClick
      ExplicitLeft = 105
      ExplicitHeight = 54
    end
    object Sb_Excluir: TSpeedButton
      AlignWithMargins = True
      Left = 198
      Top = 5
      Width = 79
      Height = 52
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
      OnClick = Sb_ExcluirClick
      ExplicitLeft = 182
      ExplicitHeight = 54
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 279
      Top = 5
      Width = 79
      Height = 52
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
      ExplicitLeft = 261
      ExplicitHeight = 54
    end
    object Sb_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 360
      Top = 5
      Width = 79
      Height = 52
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
      OnClick = Sb_CancelarClick
      ExplicitLeft = 359
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 441
      Top = 5
      Width = 81
      Height = 52
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
      ExplicitLeft = 419
      ExplicitHeight = 54
    end
  end
  object DBG_Tabela: TDBGrid [2]
    Left = 0
    Top = 0
    Width = 527
    Height = 141
    Align = alTop
    Color = clMoneyGreen
    DataSource = Ds_Pesquisa
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
        Width = 263
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TPR_MAR_LRC'
        Title.Caption = 'Margem'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TPR_VALIDADE'
        Title.Caption = 'Validade'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TPR_ATIVA'
        Title.Alignment = taCenter
        Title.Caption = 'Ativa'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 53
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    inherited arefas1: TMenuItem
      object AtualizaodePreodeVenda1: TMenuItem [0]
        Caption = 'Atualiza'#231#227'o de Pre'#231'o de Venda'
        OnClick = AtualizaodePreodeVenda1Click
      end
      object CorrigiDuplicidades1: TMenuItem [1]
        Caption = 'Corrigir Duplicidades'
        OnClick = CorrigiDuplicidades1Click
      end
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Cds_Pesquisa
    Left = 440
    Top = 328
  end
  object Cds_Pesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 440
    Top = 272
    object Cds_PesquisaTPR_CODIGO: TIntegerField
      FieldName = 'TPR_CODIGO'
      Origin = '"TB_TABELA_PRECO"."TPR_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_PesquisaTPR_CODEMP: TIntegerField
      FieldName = 'TPR_CODEMP'
      Origin = '"TB_TABELA_PRECO"."TPR_CODEMP"'
    end
    object Cds_PesquisaTPR_NOME: TWideStringField
      FieldName = 'TPR_NOME'
      Origin = '"TB_TABELA_PRECO"."TPR_NOME"'
      Size = 50
    end
    object Cds_PesquisaTPR_VALIDADE: TDateField
      FieldName = 'TPR_VALIDADE'
      Origin = '"TB_TABELA_PRECO"."TPR_VALIDADE"'
    end
    object Cds_PesquisaTPR_MODALIDADE: TWideStringField
      FieldName = 'TPR_MODALIDADE'
      Origin = '"TB_TABELA_PRECO"."TPR_MODALIDADE"'
      FixedChar = True
      Size = 1
    end
    object Cds_PesquisaTPR_MAR_LRC: TFMTBCDField
      FieldName = 'TPR_MAR_LRC'
      Origin = '"TB_TABELA_PRECO"."TPR_MAR_LRC"'
      Precision = 18
      Size = 6
    end
    object Cds_PesquisaTPR_PRINCIPAL: TWideStringField
      FieldName = 'TPR_PRINCIPAL'
      Origin = '"TB_TABELA_PRECO"."TPR_PRINCIPAL"'
      FixedChar = True
      Size = 1
    end
    object Cds_PesquisaTPR_MOBILE: TWideStringField
      FieldName = 'TPR_MOBILE'
      Origin = '"TB_TABELA_PRECO"."TPR_MOBILE"'
      FixedChar = True
      Size = 1
    end
    object Cds_PesquisaTPR_TIPO_CLIENTE: TWideStringField
      FieldName = 'TPR_TIPO_CLIENTE'
      Origin = '"TB_TABELA_PRECO"."TPR_TIPO_CLIENTE"'
      FixedChar = True
      Size = 1
    end
    object Cds_PesquisaTPR_CASA_DECIMAL: TIntegerField
      FieldName = 'TPR_CASA_DECIMAL'
      Origin = '"TB_TABELA_PRECO"."TPR_CASA_DECIMAL"'
    end
    object Cds_PesquisaTPR_LOJISTA: TWideStringField
      FieldName = 'TPR_LOJISTA'
      Origin = '"TB_TABELA_PRECO"."TPR_LOJISTA"'
      FixedChar = True
      Size = 1
    end
    object Cds_PesquisaTPR_ATIVA: TStringField
      FieldName = 'TPR_ATIVA'
    end
    object Cds_PesquisaTPR_MAR_PRIORITARIA: TStringField
      FieldName = 'TPR_MAR_PRIORITARIA'
      Size = 1
    end
    object Cds_PesquisaTPR_MAR_VIA_ESCALA: TFloatField
      FieldName = 'TPR_MAR_VIA_ESCALA'
    end
  end
end
