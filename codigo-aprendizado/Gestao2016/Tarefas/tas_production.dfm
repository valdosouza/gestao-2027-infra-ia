inherited TasProduction: TTasProduction
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsSizeable
  Caption = 'Cadastro de Produ'#231#227'o'
  ClientHeight = 562
  ClientWidth = 816
  ExplicitWidth = 832
  ExplicitHeight = 621
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 498
    Width = 816
    ExplicitTop = 498
    ExplicitWidth = 816
    inherited SB_Inserir: TSpeedButton
      Left = 87
      ExplicitLeft = 157
    end
    inherited SB_Alterar: TSpeedButton
      Left = 191
      ExplicitLeft = 201
    end
    inherited SB_Excluir: TSpeedButton
      Left = 295
      ExplicitLeft = 306
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 503
      ExplicitLeft = 487
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 709
      ExplicitLeft = 662
    end
    inherited SB_Gravar: TSpeedButton
      Left = 399
      ExplicitLeft = 511
    end
    object Sb_Imp_Mp: TSpeedButton
      Left = 606
      Top = 2
      Width = 102
      Height = 60
      Align = alRight
      Caption = 'Imprimir - F9'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Imp_MpClick
      ExplicitLeft = 619
    end
  end
  inherited pnl_fundo: TPanel
    Width = 816
    Height = 49
    Align = alTop
    ExplicitWidth = 816
    ExplicitHeight = 49
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object Label2: TLabel
      Left = 133
      Top = 4
      Width = 44
      Height = 13
      Caption = 'Cadastro'
    end
    object Label3: TLabel
      Left = 220
      Top = 4
      Width = 39
      Height = 13
      Caption = 'Prevista'
    end
    object Label4: TLabel
      Left = 306
      Top = 3
      Width = 41
      Height = 13
      Caption = 'Situa'#231#227'o'
    end
    object E_Numero: TEdit
      Left = 7
      Top = 19
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object Dtp_Cadastro: TDateTimePicker
      Left = 131
      Top = 18
      Width = 85
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object Dtp_Prevista: TDateTimePicker
      Left = 218
      Top = 18
      Width = 85
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object Cb_Situacao: TComboBox
      Left = 305
      Top = 19
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Produzindo'
        'Finalizada')
    end
  end
  object pg_Geral: TPageControl [2]
    Left = 0
    Top = 49
    Width = 816
    Height = 449
    ActivePage = tbs_embalagem
    Align = alClient
    TabOrder = 2
    object tbs_Producao: TTabSheet
      Caption = 'Produ'#231#227'o'
      ImageIndex = 2
      object Pnl_Item_Produzir: TPanel
        Left = 0
        Top = 0
        Width = 808
        Height = 421
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label8: TLabel
          Left = 2
          Top = 2
          Width = 804
          Height = 14
          Align = alTop
          Alignment = taCenter
          Caption = 'DADOS DO ITEM A PRODUZIR'
          Color = clNavy
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 151
        end
        object Label5: TLabel
          Left = 521
          Top = 23
          Width = 107
          Height = 13
          Caption = 'Quantidade a Produzir'
        end
        inline Fm_ListaProdutos: TFm_ListaProdutos
          Left = 3
          Top = 22
          Width = 514
          Height = 43
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 22
          ExplicitWidth = 514
          inherited Sb_Produto: TSpeedButton
            Left = 487
            ExplicitLeft = 487
          end
          inherited E_Busca_Produto: TEdit
            Width = 382
            ExplicitWidth = 382
          end
        end
        object E_Qtde_Produzir: TEdit
          Left = 521
          Top = 38
          Width = 107
          Height = 21
          Alignment = taRightJustify
          TabOrder = 1
          OnExit = E_Qtde_ProduzirExit
        end
        object gbProducao: TGroupBox
          Left = 7
          Top = 60
          Width = 458
          Height = 57
          Caption = 'Produ'#231#227'o: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          DesignSize = (
            458
            57)
          object Label6: TLabel
            Left = 9
            Top = 15
            Width = 51
            Height = 13
            Caption = 'Data Inicio'
          end
          object Label11: TLabel
            Left = 100
            Top = 15
            Width = 48
            Height = 13
            Caption = 'Data Final'
          end
          object Label7: TLabel
            Left = 189
            Top = 15
            Width = 106
            Height = 13
            Caption = 'Quantidade Produzida'
          end
          object edDtInicio: TMaskEdit
            Left = 8
            Top = 29
            Width = 85
            Height = 21
            EditMask = '!99/99/0000;1;_'
            MaxLength = 10
            TabOrder = 0
            Text = '  /  /    '
          end
          object edDtFim: TMaskEdit
            Left = 98
            Top = 29
            Width = 85
            Height = 21
            EditMask = '!99/99/0000;1;_'
            MaxLength = 10
            TabOrder = 1
            Text = '  /  /    '
          end
          object E_Qtde_Produzida: TEdit
            Left = 187
            Top = 29
            Width = 121
            Height = 21
            Alignment = taRightJustify
            TabOrder = 2
          end
          object Sb_Info_Lote_PA: TButton
            Left = 324
            Top = 11
            Width = 131
            Height = 38
            Anchors = [akRight, akBottom]
            Caption = 'Lan'#231'a Produto Acabado'
            CommandLinkHint = 's'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = Sb_Info_Lote_PAClick
          end
        end
        inline Fm_ListaEstoquesMP: TFm_ListaEstoques
          Left = 2
          Top = 125
          Width = 260
          Height = 36
          TabOrder = 3
          ExplicitLeft = 2
          ExplicitTop = 125
          ExplicitWidth = 260
          inherited Label1: TLabel
            Width = 255
            Caption = 'Estoque de Mat'#233'ria Prima'
            ExplicitWidth = 121
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 237
            ExplicitLeft = 234
            ExplicitHeight = 13
          end
          inherited Dblcb_Estoque: TDBLookupComboBox
            Width = 253
            ExplicitWidth = 253
          end
          inherited ChBx_Estoques: TCheckBox
            Left = 155
            Top = -3
            Visible = False
            OnClick = nil
            ExplicitLeft = 155
            ExplicitTop = -3
          end
          inherited Qr_Estoques: TSTQuery
            Left = 143
            Top = 31
          end
          inherited Ds_Estoques: TDataSource
            Left = 111
            Top = 32
          end
        end
        inline Fm_ListaEstoquesPA: TFm_ListaEstoques
          Left = 262
          Top = 125
          Width = 260
          Height = 36
          TabOrder = 4
          ExplicitLeft = 262
          ExplicitTop = 125
          ExplicitWidth = 260
          inherited Label1: TLabel
            Width = 255
            Caption = 'Estoque de Produto Acabado'
            ExplicitWidth = 140
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 237
            ExplicitLeft = 234
            ExplicitHeight = 13
          end
          inherited Dblcb_Estoque: TDBLookupComboBox
            Width = 253
            ExplicitWidth = 253
          end
          inherited ChBx_Estoques: TCheckBox
            Left = 153
            Visible = False
            OnClick = nil
            ExplicitLeft = 153
          end
          inherited Ds_Estoques: TDataSource
            Left = 119
          end
        end
      end
    end
    object tsPrevisto: TTabSheet
      Caption = 'Consumo M'#225'teria Prima'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 818
      ExplicitHeight = 431
      object Pnl_MP_Lista: TPanel
        Left = 0
        Top = 0
        Width = 808
        Height = 333
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitWidth = 818
        ExplicitHeight = 343
        object DBG_MP: TDBGrid
          Left = 2
          Top = 2
          Width = 804
          Height = 329
          Align = alClient
          DataSource = ds_itemsMP
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = popMenuMP
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 437
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRE_QTDUNI'
              Title.Caption = 'Qtde Cons. Unit.'
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SUBTOTAL'
              Title.Caption = 'Consumo Total'
              Width = 93
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTDE_LOTE_INFO'
              Title.Caption = 'Qtde Lote Inf'
              Width = 76
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SUBTOTAL_CUSTO'
              Title.Caption = 'Valor de Custo'
              Visible = True
            end>
        end
      end
      object Pnl_MP_Botoes: TPanel
        Left = 0
        Top = 374
        Width = 808
        Height = 47
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        OnClick = Pnl_MP_BotoesClick
        ExplicitTop = 384
        ExplicitWidth = 818
        DesignSize = (
          808
          47)
        object Sb_Ins_MP: TSpeedButton
          Left = 3
          Top = 5
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Novo - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Ins_MPClick
          ExplicitLeft = 4
        end
        object Sb_Alt_MP: TSpeedButton
          Left = 133
          Top = 5
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Alt_MPClick
          ExplicitLeft = 135
        end
        object Sb_Exc_MP: TSpeedButton
          Left = 262
          Top = 5
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Excluir - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Exc_MPClick
          ExplicitLeft = 266
        end
        object Sb_Lote_MP: TSpeedButton
          Left = 392
          Top = 6
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Informar Lote - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Lote_MPClick
          ExplicitLeft = 398
        end
        object Sb_Gerar_MP: TSpeedButton
          Left = 528
          Top = 6
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Gerar M.P. - F8'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Gerar_MPClick
          ExplicitLeft = 535
        end
      end
      object Pnl_MP_Totalizador: TPanel
        Left = 0
        Top = 333
        Width = 808
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        ExplicitTop = 343
        ExplicitWidth = 818
        DesignSize = (
          808
          41)
        object Label9: TLabel
          Left = 709
          Top = 4
          Width = 77
          Height = 14
          Anchors = [akRight, akBottom]
          Caption = 'Custo Produ'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 719
        end
        object E_VL_Custo_Producao: TPanel
          Left = 708
          Top = 18
          Width = 93
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight, akBottom]
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Caption = '0,00'
          Color = clBlack
          Font.Charset = ANSI_CHARSET
          Font.Color = clLime
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Locked = True
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          ExplicitLeft = 718
        end
      end
    end
    object tbs_embalagem: TTabSheet
      Caption = 'Produto Acabado'
      ImageIndex = 2
      object Pnl_PA_Lista: TPanel
        Left = 0
        Top = 0
        Width = 808
        Height = 333
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object DBG_PA: TDBGrid
          Left = 2
          Top = 2
          Width = 804
          Height = 329
          Align = alClient
          DataSource = ds_itemsPA
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = popMenuPA
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 503
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ORL_QTDTOT'
              Title.Caption = 'Quantidade'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTDE_LOTE_INFO'
              Title.Caption = 'Qtde Lote Info'
              Visible = True
            end>
        end
      end
      object Pnl_PA_Botoes: TPanel
        Left = 0
        Top = 374
        Width = 808
        Height = 47
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        OnClick = Pnl_MP_BotoesClick
        DesignSize = (
          808
          47)
        object Sb_Ins_PA: TSpeedButton
          Left = 4
          Top = 5
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Novo - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Ins_PAClick
          ExplicitLeft = 5
        end
        object Sb_Alt_PA: TSpeedButton
          Left = 134
          Top = 5
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Alt_PAClick
          ExplicitLeft = 136
        end
        object Sb_Exc_PA: TSpeedButton
          Left = 263
          Top = 5
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Excluir - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Exc_PAClick
          ExplicitLeft = 267
        end
        object Sb_Lote_PA: TSpeedButton
          Left = 395
          Top = 5
          Width = 131
          Height = 38
          Anchors = [akBottom]
          Caption = 'Informar Lote - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Sb_Lote_PAClick
          ExplicitLeft = 401
        end
      end
      object Pnl_PA_totalizador: TPanel
        Left = 0
        Top = 333
        Width = 808
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 672
    Top = 8
  end
  object Qr_Lote_MP_Disponivel: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select pd.pro_descricao, cl.clt_codigo, cl.clt_numero, cl.clt_dt' +
        '_vencimento, cl.clt_qt_saldo'
      'from  tb_ctrl_lote cl'
      '    inner join tb_produto pd'
      '    on (pd.pro_codigo = cl.clt_codpro)'
      'where cl.clt_codpro=:materiaprima'
      '  and cl.clt_qt_saldo > 0'
      'order by cl.clt_dt_vencimento asc')
    Left = 540
    Top = 228
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'materiaprima'
        ParamType = ptUnknown
      end>
    object Qr_Lote_MP_DisponivelPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_Lote_MP_DisponivelCLT_CODIGO: TIntegerField
      FieldName = 'CLT_CODIGO'
      Origin = '"TB_CTRL_LOTE"."CLT_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_Lote_MP_DisponivelCLT_NUMERO: TStringField
      FieldName = 'CLT_NUMERO'
      Origin = '"TB_CTRL_LOTE"."CLT_NUMERO"'
      Size = 50
    end
    object Qr_Lote_MP_DisponivelCLT_DT_VENCIMENTO: TDateField
      FieldName = 'CLT_DT_VENCIMENTO'
      Origin = '"TB_CTRL_LOTE"."CLT_DT_VENCIMENTO"'
    end
    object Qr_Lote_MP_DisponivelCLT_QT_SALDO: TBCDField
      FieldName = 'CLT_QT_SALDO'
      Origin = '"TB_CTRL_LOTE"."CLT_QT_SALDO"'
      Precision = 18
      Size = 2
    end
  end
  object DSP_MP: TDataSetProvider
    Options = [poAllowCommandText, poRetainServerOrder, poUseQuoteChar]
    Left = 152
    Top = 152
  end
  object cds_itemsMP: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    Left = 152
    Top = 202
    object cds_itemsMPPRE_CODIGO: TIntegerField
      FieldName = 'PRE_CODIGO'
      Required = True
    end
    object cds_itemsMPPRE_CODORP: TIntegerField
      FieldName = 'PRE_CODORP'
      Required = True
    end
    object cds_itemsMPPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Required = True
    end
    object cds_itemsMPPRO_DESCRICAO: TWideStringField
      FieldName = 'PRO_DESCRICAO'
      Size = 100
    end
    object cds_itemsMPPRE_QTDUNI: TBCDField
      FieldName = 'PRE_QTDUNI'
      Required = True
      DisplayFormat = '0.00###'
      Precision = 10
      Size = 5
    end
    object cds_itemsMPQTDE_LOTE_INFO: TFMTBCDField
      FieldName = 'QTDE_LOTE_INFO'
      DisplayFormat = '0.00###'
      Precision = 18
      Size = 5
    end
    object cds_itemsMPSUBTOTAL_CUSTO: TFloatField
      FieldName = 'SUBTOTAL_CUSTO'
      DisplayFormat = '0.00###'
    end
    object cds_itemsMPSUBTOTAL: TFloatField
      FieldName = 'SUBTOTAL'
      DisplayFormat = '0.00#'
    end
  end
  object ds_itemsMP: TDataSource
    DataSet = cds_itemsMP
    Left = 152
    Top = 258
  end
  object Qr_Mp_Similar: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select pds.tb_product_id_similar, pd.PRO_DESCRICAO, cl.clt_dt_ve' +
        'ncimento, cl.clt_qt_saldo, pro_vl_custo'
      'from tb_ctrl_lote cl'
      '  inner join tb_product_similar pds'
      '  on  ( pds.tb_product_id_similar = cl.clt_codpro)'
      '  inner join tb_produto pd'
      '  on (pd.pro_codigo = pds.tb_product_id_similar)'
      
        'where pds.tb_product_id_master =:tb_product_id_master and cl.clt' +
        '_qt_saldo > 0'
      'order by cl.clt_dt_vencimento')
    Left = 708
    Top = 332
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'tb_product_id_master'
        ParamType = ptUnknown
      end>
    object Qr_Mp_SimilarTB_PRODUCT_ID_SIMILAR: TIntegerField
      FieldName = 'TB_PRODUCT_ID_SIMILAR'
      Origin = '"TB_PRODUCT_SIMILAR"."TB_PRODUCT_ID_SIMILAR"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_Mp_SimilarCLT_DT_VENCIMENTO: TDateField
      FieldName = 'CLT_DT_VENCIMENTO'
      Origin = '"TB_CTRL_LOTE"."CLT_DT_VENCIMENTO"'
    end
    object Qr_Mp_SimilarCLT_QT_SALDO: TBCDField
      FieldName = 'CLT_QT_SALDO'
      Origin = '"TB_CTRL_LOTE"."CLT_QT_SALDO"'
      Precision = 18
      Size = 2
    end
    object Qr_Mp_SimilarPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_Mp_SimilarPRO_VL_CUSTO: TFMTBCDField
      FieldName = 'PRO_VL_CUSTO'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
  end
  object cds_itemsPA: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP_PA'
    Left = 256
    Top = 202
    object cds_itemsPAORL_CODIGO: TIntegerField
      FieldName = 'ORL_CODIGO'
      Required = True
    end
    object cds_itemsPAORL_CODORP: TIntegerField
      FieldName = 'ORL_CODORP'
      Required = True
    end
    object cds_itemsPAPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Required = True
    end
    object cds_itemsPAPRO_DESCRICAO: TWideStringField
      FieldName = 'PRO_DESCRICAO'
      Size = 100
    end
    object cds_itemsPAORL_QTDTOT: TBCDField
      FieldName = 'ORL_QTDTOT'
      Precision = 18
      Size = 2
    end
    object cds_itemsPAQTDE_LOTE_INFO: TFMTBCDField
      FieldName = 'QTDE_LOTE_INFO'
      Precision = 18
      Size = 5
    end
  end
  object ds_itemsPA: TDataSource
    DataSet = cds_itemsPA
    Left = 256
    Top = 258
  end
  object DSP_PA: TDataSetProvider
    Options = [poAllowCommandText, poRetainServerOrder, poUseQuoteChar]
    Left = 256
    Top = 152
  end
  object popMenuMP: TPopupMenu
    Left = 432
    Top = 136
    object Informa1: TMenuItem
      Caption = 'Informa'#231#227'o de Lote'
      OnClick = Informa1Click
    end
  end
  object popMenuPA: TPopupMenu
    Left = 512
    Top = 136
    object MenuItem1: TMenuItem
      Caption = 'Informa'#231#227'o de Lote'
      OnClick = MenuItem1Click
    end
  end
end
