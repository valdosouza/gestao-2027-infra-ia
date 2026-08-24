inherited TasStockTransfer: TTasStockTransfer
  Caption = 'Transfr'#234'ncia entre estoques'
  ClientHeight = 543
  ClientWidth = 1006
  ExplicitTop = -58
  ExplicitWidth = 1012
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_fundo: TPanel [0]
    Left = 0
    Top = 0
    Width = 1006
    Height = 543
    Align = alClient
    TabOrder = 0
    object Pnl_Botton: TPanel
      Left = 1
      Top = 475
      Width = 1004
      Height = 67
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object SB_Confirmar: TSpeedButton
        Left = 823
        Top = 2
        Width = 90
        Height = 63
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
        ExplicitLeft = 817
        ExplicitTop = 6
      end
      object SB_Sair_0: TSpeedButton
        Left = 913
        Top = 2
        Width = 89
        Height = 63
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
        ExplicitLeft = 919
        ExplicitTop = 6
      end
      object SB_Buscar: TSpeedButton
        Left = 731
        Top = 2
        Width = 92
        Height = 63
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alRight
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
        ExplicitLeft = 728
      end
    end
    object pnl_Origem: TPanel
      Left = 1
      Top = 1
      Width = 1004
      Height = 66
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object pnl_estoque_Origem: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 432
        Height = 66
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        TabOrder = 0
        object Lb_Titlle_Origem: TLabel
          Left = 1
          Top = 1
          Width = 430
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'ESTOQUE ORIGEM'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 98
        end
        inline Fm_ListaEstoques_Origem: TFm_ListaEstoques
          AlignWithMargins = True
          Left = 4
          Top = 17
          Width = 424
          Height = 44
          Align = alTop
          TabOrder = 0
          ExplicitLeft = 4
          ExplicitTop = 17
          ExplicitWidth = 424
          ExplicitHeight = 44
          inherited Label1: TLabel
            Width = 419
            Caption = 'Desri'#231#227'o do Estoque'
            ExplicitWidth = 100
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 401
            Height = 30
            ExplicitLeft = 398
            ExplicitHeight = 21
          end
          inherited Dblcb_Estoque: TDBLookupComboBox
            Width = 417
            ExplicitWidth = 417
          end
          inherited ChBx_Estoques: TCheckBox
            Left = 149
            Visible = False
            OnClick = nil
            ExplicitLeft = 149
          end
          inherited Qr_Estoques: TSTQuery
            Left = 47
            Top = 39
          end
          inherited Ds_Estoques: TDataSource
            Top = 40
          end
        end
      end
      object pnl_estoque_destino: TPanel
        AlignWithMargins = True
        Left = 435
        Top = 0
        Width = 432
        Height = 66
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        TabOrder = 1
        object Lb_Titlle_Destino: TLabel
          Left = 1
          Top = 1
          Width = 430
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'ESTOQUE ORIGEM'
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 98
        end
        inline Fm_ListaEstoques_Destino: TFm_ListaEstoques
          AlignWithMargins = True
          Left = 4
          Top = 17
          Width = 424
          Height = 49
          Align = alTop
          TabOrder = 0
          ExplicitLeft = 4
          ExplicitTop = 17
          ExplicitWidth = 424
          ExplicitHeight = 49
          inherited Label1: TLabel
            Width = 419
            Caption = 'Desri'#231#227'o do Estoque'
            ExplicitWidth = 100
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 401
            Height = 35
            ExplicitLeft = 398
            ExplicitHeight = 26
          end
          inherited Dblcb_Estoque: TDBLookupComboBox
            Width = 417
            ExplicitWidth = 417
          end
          inherited ChBx_Estoques: TCheckBox
            Left = 142
            Visible = False
            OnClick = nil
            ExplicitLeft = 142
          end
          inherited Qr_Estoques: TSTQuery
            Left = 47
            Top = 39
          end
          inherited Ds_Estoques: TDataSource
            Top = 40
          end
        end
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 168
      Width = 1004
      Height = 307
      TabStop = False
      Align = alClient
      DataSource = ds_estoque_origem
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyPress = DBGrid1KeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'PRO_CODIGO'
          ReadOnly = True
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_CODIGOFAB'
          ReadOnly = True
          Title.Caption = 'C'#243'digo Fabrica'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          ReadOnly = True
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 529
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORIGEM'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Origem'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESTINO'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Destino'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EST_TRANSF'
          Title.Alignment = taCenter
          Title.Caption = 'Transferir'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 83
          Visible = True
        end>
    end
    object GrBx_Pesquisa: TGroupBox
      Left = 1
      Top = 67
      Width = 1004
      Height = 101
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object Lb_Codigo: TLabel
        Left = 5
        Top = 14
        Width = 69
        Height = 14
        Caption = 'C'#243'digo Interno'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Descricao: TLabel
        Left = 306
        Top = 13
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 824
        Top = 14
        Width = 49
        Height = 14
        Caption = 'SubGrupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 633
        Top = 13
        Width = 30
        Height = 14
        Caption = 'Grupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object LBL_CD_BARRA: TLabel
        Left = 3
        Top = 58
        Width = 69
        Height = 14
        Caption = 'C'#243'digo Barras'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 162
        Top = 59
        Width = 30
        Height = 14
        Caption = 'Marca'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 153
        Top = 13
        Width = 72
        Height = 14
        Caption = 'C'#243'digo Fabrica'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaCodigo: TMaskEdit
        Left = 3
        Top = 28
        Width = 144
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 48
        ParentFont = False
        TabOrder = 0
        Text = ''
      end
      object E_BuscaDescricao: TMaskEdit
        Left = 301
        Top = 28
        Width = 330
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 100
        ParentFont = False
        TabOrder = 1
        Text = ''
      end
      object E_BuscaMarca: TMaskEdit
        Left = 161
        Top = 73
        Width = 161
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 48
        ParentFont = False
        TabOrder = 5
        Text = ''
      end
      object E_BuscaSubgrupo: TMaskEdit
        Left = 824
        Top = 28
        Width = 174
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 100
        ParentFont = False
        TabOrder = 4
        Text = ''
      end
      object E_BuscaGrupo: TMaskEdit
        Left = 633
        Top = 28
        Width = 187
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 100
        ParentFont = False
        TabOrder = 3
        Text = ''
      end
      object E_BuscaCodBarras: TEdit_Setes
        Left = 3
        Top = 73
        Width = 154
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 2
        Text = ''
      end
      object E_BuscaFabrica: TMaskEdit
        Left = 153
        Top = 28
        Width = 144
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 48
        ParentFont = False
        TabOrder = 6
        Text = ''
      end
      object Rg_Escolhidos: TRadioGroup
        Left = 328
        Top = 52
        Width = 241
        Height = 42
        Caption = 'Produtos a serem Transferidos'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'SIM'
          'N'#195#402'O'
          'TODOS')
        TabOrder = 7
        OnClick = SB_BuscarClick
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 16
    Top = 416
  end
  object cds_estoque: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    Left = 112
    Top = 160
    object cds_estoquePRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = '"TB_PRODUTO"."PRO_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_estoquePRO_CODIGOFAB: TWideStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object cds_estoquePRO_DESCRICAO: TWideStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object cds_estoqueORIGEM: TFMTBCDField
      FieldName = 'ORIGEM'
      Origin = '"TB_ESTOQUE"."EST_QTDE"'
      Precision = 18
      Size = 6
    end
    object cds_estoqueDESTINO: TFMTBCDField
      FieldName = 'DESTINO'
      Origin = '"TB_ESTOQUE"."EST_QTDE"'
      Precision = 18
      Size = 6
    end
    object cds_estoqueEST_TRANSF: TBCDField
      FieldName = 'EST_TRANSF'
      ProviderFlags = []
      OnChange = cds_estoqueEST_TRANSFChange
      Precision = 18
      Size = 1
    end
    object cds_estoquePRO_CODIGOBAR: TWideStringField
      FieldName = 'PRO_CODIGOBAR'
      Origin = '"TB_PRODUTO"."PRO_CODIGOBAR"'
    end
    object cds_estoqueGRP_DESCRICAO: TWideStringField
      FieldName = 'GRP_DESCRICAO'
      Origin = '"TB_GRUPOS"."GRP_DESCRICAO"'
      Size = 100
    end
    object cds_estoqueSBG_DESCRICAO: TWideStringField
      FieldName = 'SBG_DESCRICAO'
      Origin = '"TB_SUBGRUPOS"."SBG_DESCRICAO"'
      Size = 100
    end
    object cds_estoqueMRC_DESCRICAO: TWideStringField
      FieldName = 'MRC_DESCRICAO'
      Origin = '"TB_MARCA_PRODUTO"."MRC_DESCRICAO"'
      Size = 50
    end
    object cds_estoquePRO_VL_CUSTO: TFMTBCDField
      FieldName = 'PRO_VL_CUSTO'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
  end
  object qr_pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Crud
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT '
      '  PRO_CODIGO '
      ' ,PRO_CODIGOFAB '
      ' ,PRO_CODIGOBAR '
      ' ,PRO_DESCRICAO'
      ',PRO_VL_CUSTO'
      ' ,GRP_DESCRICAO '
      ' ,SBG_DESCRICAO '
      ' ,MRC_DESCRICAO'
      ' ,EO.est_qtde ORIGEM'
      ' ,ED.est_qtde DESTINO'
      ' ,0.0 EST_TRANSF'
      'FROM TB_PRODUTO P'
      '  INNER JOIN TB_GRUPOS Gp'
      '  ON (P.PRO_CODGRP = Gp.GRP_CODIGO)   '
      '  INNER JOIN TB_SUBGRUPOS SB'
      '  ON (P.PRO_CODSBG = SB.SBG_CODIGO) '
      '  left OUTER JOIN TB_MARCA_PRODUTO MR'
      '  ON (P.PRO_CODMRC = MR.MRC_CODIGO )'
      '  LEFT OUTER JOIN tb_estoque EO'
      '  ON (P.pro_codigo = EO.est_codpro)'
      '  LEFT OUTER JOIN tb_estoque ED'
      '  ON (P.pro_codigo = ED.est_codpro)'
      'WHERE (EO.est_qtde > 0 ) and ( p.pro_ativo = '#39'S'#39' )'
      'and  ( EO.est_codets = 1 )'
      'AND (( ED.est_codets = 2) )')
    Left = 273
    Top = 377
  end
  object DSP: TDataSetProvider
    DataSet = qr_pesquisa
    Left = 273
    Top = 329
  end
  object ds_estoque_origem: TDataSource
    DataSet = cds_estoque
    Left = 112
    Top = 216
  end
end
