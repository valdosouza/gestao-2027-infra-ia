object Fr_Crp_Itens: TFr_Crp_Itens
  Left = 294
  Top = 212
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Itens do Card'#225'pio'
  ClientHeight = 309
  ClientWidth = 682
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 243
    Width = 682
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      682
      66)
    object SB_Inserir: TSpeedButton
      Left = 227
      Top = 5
      Width = 75
      Height = 55
      Anchors = [akRight, akBottom]
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
    end
    object SB_Alterar: TSpeedButton
      Left = 302
      Top = 5
      Width = 75
      Height = 55
      Anchors = [akRight, akBottom]
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
    end
    object SB_Excluir: TSpeedButton
      Left = 377
      Top = 5
      Width = 75
      Height = 55
      Anchors = [akRight, akBottom]
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
    end
    object SB_Gravar: TSpeedButton
      Left = 452
      Top = 5
      Width = 75
      Height = 55
      Anchors = [akRight, akBottom]
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
    end
    object SB_Cancelar: TSpeedButton
      Left = 527
      Top = 5
      Width = 75
      Height = 55
      Anchors = [akRight, akBottom]
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
    end
    object Sb_Sair_0: TSpeedButton
      Left = 602
      Top = 5
      Width = 75
      Height = 55
      Anchors = [akRight, akBottom]
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
    end
  end
  object DBG_Produtos: TDBGrid
    Left = 0
    Top = 49
    Width = 682
    Height = 194
    Align = alClient
    Color = clMoneyGreen
    DataSource = Ds_Crp_Itens
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    Options = [dgTitles, dgColLines, dgRowSelect, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CPI_SEQUENCIA'
        Title.Caption = 'Ordem'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRO_DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 364
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MED_ABREVIATURA'
        Title.Caption = 'Und'
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPI_QTDE'
        Title.Caption = 'Qtde'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPI_VALOR'
        Title.Caption = 'Valor Extra'
        Width = 74
        Visible = True
      end>
  end
  object Pnl_Edicao: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 49
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object LB_Cnpj: TLabel
      Left = 534
      Top = 2
      Width = 55
      Height = 14
      Caption = 'Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 5
      Top = 2
      Width = 32
      Height = 14
      Caption = 'Ordem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 597
      Top = 3
      Width = 53
      Height = 14
      Caption = 'Valor Extra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Qtde: TEdit_Setes
      Left = 534
      Top = 17
      Width = 58
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 18
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object E_Sequencia: TEdit_Setes
      Left = 5
      Top = 17
      Width = 49
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
    object E_Vl_Extra: TEdit_Setes
      Left = 594
      Top = 17
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 18
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 53
      Top = 1
      Width = 480
      Height = 43
      TabOrder = 1
      ExplicitLeft = 53
      ExplicitTop = 1
      ExplicitWidth = 480
      inherited Label3: TLabel
        Left = 90
        ExplicitLeft = 90
      end
      inherited Sb_Produto: TSpeedButton
        Left = 451
        OnClick = Fm_ListaProdutosSb_ProdutoClick
        ExplicitLeft = 451
      end
      inherited E_Cd_Produto: TMaskEdit
        Width = 81
        ExplicitWidth = 81
      end
      inherited E_Busca_Produto: TEdit
        Left = 86
        ReadOnly = True
        ExplicitLeft = 86
      end
    end
  end
  object Qr_Crp_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AutoCalcFields = False
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      ' CPI_CODIGO,'
      '  CPI_SABOR,'
      '  CPI_SEQUENCIA,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  CPI_CODPRO,'
      '  CPI_QTDE,'
      '  CPI_VALOR,'
      '  CPI_TIPO,'
      '  CPI_CODGRP'
      'FROM TB_CRP_ITENS'
      '  INNER JOIN TB_PRODUTO'
      '  ON (PRO_CODIGO = CPI_CODPRO)'
      '  INNER JOIN TB_MEDIDA'
      ' ON (MED_CODIGO = PRO_CODMED)'
      'WHERE ( CPI_SABOR =:CPI_SABOR ) '
      'AND ( CPI_TIPO=:CPI_TIPO )'
      'AND ( CPI_CODGRP=:CPI_CODGRP )')
    Left = 156
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CPI_SABOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CPI_TIPO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CPI_CODGRP'
        ParamType = ptUnknown
      end>
  end
  object Ds_Crp_Itens: TDataSource
    AutoEdit = False
    DataSet = Qr_Crp_Itens
    Left = 128
    Top = 152
  end
end
