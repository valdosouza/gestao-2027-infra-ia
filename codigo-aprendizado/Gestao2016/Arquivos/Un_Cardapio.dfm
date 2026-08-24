object Fr_Cardapio: TFr_Cardapio
  Left = 396
  Top = 111
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Card'#225'pio'
  ClientHeight = 492
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Cardapio: TPageControl
    Left = 0
    Top = 0
    Width = 657
    Height = 492
    ActivePage = tbs_Cadastro
    Align = alClient
    TabOrder = 0
    object tbs_Cadastro: TTabSheet
      Caption = 'Cadastro'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnl_botoes: TPanel
        Left = 0
        Top = 400
        Width = 649
        Height = 64
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          649
          64)
        object Sb_Pesquisar: TSpeedButton
          Left = 485
          Top = 5
          Width = 78
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Pesquisar- F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_PesquisarClick
        end
        object Sb_Sair_0: TSpeedButton
          Left = 564
          Top = 5
          Width = 78
          Height = 54
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
        object SB_Inserir: TSpeedButton
          Left = 406
          Top = 5
          Width = 78
          Height = 54
          Anchors = [akBottom]
          Caption = 'Tipos - F2'
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
      end
      object Pg_Tipo: TPageControl
        Left = 0
        Top = 0
        Width = 649
        Height = 400
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object tbs_Pesquisa: TTabSheet
      Caption = 'Pesquisa'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        649
        464)
      object Label22: TLabel
        Left = 2
        Top = 66
        Width = 116
        Height = 14
        Caption = 'Resultado da pesquisa :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SB_Buscar: TSpeedButton
        Left = 555
        Top = 298
        Width = 92
        Height = 54
        Anchors = [akRight, akBottom]
        Caption = 'Buscar - F7'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_BuscarClick
      end
      object SB_Visualizar: TSpeedButton
        Left = 555
        Top = 352
        Width = 92
        Height = 54
        Anchors = [akRight, akBottom]
        Caption = 'Visualizar - F8'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_VisualizarClick
      end
      object Sb_Sair_1: TSpeedButton
        Left = 555
        Top = 406
        Width = 92
        Height = 54
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
        OnClick = Sb_Sair_1Click
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 649
        Height = 61
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label28: TLabel
          Left = 9
          Top = 16
          Width = 104
          Height = 14
          Caption = 'Descri'#231#227'o do produto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BuscaDescricao: TEdit
          Left = 9
          Top = 32
          Width = 640
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
      object DBG_Pesquisa: TDBGrid
        Left = 1
        Top = 80
        Width = 547
        Height = 384
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clCream
        DataSource = Ds_Pesquisa
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'PRO_DESCRICAO'
            Title.Caption = 'Produto'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SBG_DESCRICAO'
            Title.Caption = 'Tipos'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Style = []
            Width = 265
            Visible = True
          end>
      end
    end
  end
  object Qr_Grupos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT GRP_CODIGO, GRP_DESCRICAO, SBG_CODIGO, SBG_DESCRICAO, GRP' +
        '_COMPOSICAO, GRP_INTERFACE, GRP_TAMANHOS,GRP_PROG_TAM'
      'from TB_GRUPOS tb_grupos '
      '  INNER JOIN TB_SUBGRUPOS tb_subgrupos '
      '  ON (tb_grupos.GRP_CODIGO = tb_subgrupos.SBG_CODGRP) '
      ' where GRP_CODIGO = :GRP_CODIGO'
      'AND GRP_ATIVO = '#39'S'#39
      'AND SBG_ATIVO = '#39'S'#39
      'ORDER BY GRP_DESCRICAO')
    Left = 160
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GRP_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_GruposGRP_CODIGO: TIntegerField
      FieldName = 'GRP_CODIGO'
      Origin = 'TB_GRUPOS.GRP_CODIGO'
      Required = True
    end
    object Qr_GruposGRP_DESCRICAO: TStringField
      FieldName = 'GRP_DESCRICAO'
      Origin = 'TB_GRUPOS.GRP_DESCRICAO'
      Size = 100
    end
    object Qr_GruposSBG_CODIGO: TIntegerField
      FieldName = 'SBG_CODIGO'
      Origin = 'TB_SUBGRUPOS.SBG_CODIGO'
      Required = True
    end
    object Qr_GruposSBG_DESCRICAO: TStringField
      FieldName = 'SBG_DESCRICAO'
      Origin = 'TB_SUBGRUPOS.SBG_DESCRICAO'
      Size = 100
    end
    object Qr_GruposGRP_COMPOSICAO: TStringField
      FieldName = 'GRP_COMPOSICAO'
      Origin = 'TB_GRUPOS.GRP_COMPOSICAO'
      FixedChar = True
      Size = 1
    end
    object Qr_GruposGRP_INTERFACE: TStringField
      FieldName = 'GRP_INTERFACE'
      Origin = 'TB_GRUPOS.GRP_INTERFACE'
      FixedChar = True
      Size = 1
    end
    object Qr_GruposGRP_TAMANHOS: TStringField
      FieldName = 'GRP_TAMANHOS'
      Origin = 'TB_GRUPOS.GRP_TAMANHOS'
      FixedChar = True
      Size = 1
    end
    object Qr_GruposGRP_PROG_TAM: TStringField
      FieldName = 'GRP_PROG_TAM'
      Origin = 'TB_GRUPOS.GRP_PROG_TAM'
      FixedChar = True
      Size = 1
    end
  end
  object Qr_AtualizaPreco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE TB_PRECO SET'
      'PRC_VL_VDA =:PRC_VL_VDA'
      'WHERE PRC_CODIGO = ('
      'SELECT PRC_CODIGO'
      'FROM TB_PRECO'
      '  INNER JOIN TB_PRODUTO'
      '  ON (PRO_CODIGO = PRC_CODPRO)'
      '  INNER JOIN TB_MEDIDA'
      '  ON (PRO_CODMED = MED_CODIGO)'
      'WHERE (PRO_DESCRICAO =:PRO_DESCRICAO)'
      '  AND (PRO_CODMED =:MED_CODIGO)'
      '  AND (PRO_CODSBG =:SBG_CODIGO)'
      '  AND (PRC_CODTPR =:TPR_CODIGO)'
      ' )')
    Left = 428
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRC_VL_VDA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PRO_DESCRICAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SBG_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TPR_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT PRO_DESCRICAO, SBG_CODIGO, SBG_DESCRICAO'
      'FROM TB_PRODUTO tb_produto'
      '  INNER JOIN TB_GRUPOS'
      '  ON (GRP_CODIGO = PRO_CODGRP)'
      '  INNER JOIN TB_SUBGRUPOS'
      '  ON (SBG_CODIGO = PRO_CODSBG)'
      '')
    Left = 468
    Top = 32
    object Qr_PesquisaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_PesquisaSBG_DESCRICAO: TStringField
      FieldName = 'SBG_DESCRICAO'
      Origin = 'TB_SUBGRUPOS.SBG_DESCRICAO'
      Size = 100
    end
    object Qr_PesquisaSBG_CODIGO: TIntegerField
      FieldName = 'SBG_CODIGO'
      Origin = 'TB_SUBGRUPOS.SBG_CODIGO'
      Required = True
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Qr_Pesquisa
    Left = 476
    Top = 88
  end
  object Qr_Botao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'update or insert into "TB_ITENS_BTN"("IBT_CODBTN", "IBT_CODPRO",' +
        ' "IBT_SEQUENCIA") '
      'values(:"IBT_CODBTN", :"IBT_CODPRO", :"IBT_SEQUENCIA")'
      'MATCHING (IBT_CODPRO)')
    Left = 540
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IBT_CODBTN'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IBT_CODPRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IBT_SEQUENCIA'
        ParamType = ptUnknown
      end>
  end
end
