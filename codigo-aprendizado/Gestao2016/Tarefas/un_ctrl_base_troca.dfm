object Fr_Ctrl_base_troca: TFr_Ctrl_base_troca
  Left = 222
  Top = 34
  Anchors = [akTop, akBottom]
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Controle de vendas '#224' base de troca'
  ClientHeight = 702
  ClientWidth = 1017
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 60
    Width = 1011
    Height = 144
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object E_Data_Ini: TDateTimePicker
      Left = 8
      Top = 31
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 92
      Top = 31
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 11
      Top = 16
      Width = 128
      Height = 12
      TabStop = False
      Caption = 'Data Inicial   Data Final'
      TabOrder = 0
      OnClick = ChBx_PeriodoClick
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 173
      Top = 16
      Width = 679
      Height = 43
      TabOrder = 3
      TabStop = True
      ExplicitLeft = 173
      ExplicitTop = 16
      ExplicitWidth = 679
      inherited Sb_Produto: TSpeedButton
        Left = 652
        ExplicitLeft = 609
      end
      inherited E_Busca_Produto: TEdit
        Width = 547
        ExplicitWidth = 547
      end
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      Left = 4
      Top = 98
      Width = 668
      Height = 43
      TabOrder = 6
      TabStop = True
      ExplicitLeft = 4
      ExplicitTop = 98
      ExplicitWidth = 668
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 668
        ExplicitWidth = 668
        inherited ChBx_Nome: TCheckBox
          Top = -2
          OnClick = Fm_ListaEmpresasChBx_NomeClick
          ExplicitTop = -2
        end
        inherited ChBx_Fantasia: TCheckBox
          Top = -2
          OnClick = Fm_ListaEmpresasChBx_FantasiaClick
          ExplicitLeft = 198
          ExplicitTop = -2
        end
      end
      inherited pnl_02: TPanel
        Width = 668
        ExplicitWidth = 668
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 640
          ExplicitLeft = 543
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 615
          ExplicitLeft = 518
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 547
          ExplicitWidth = 539
        end
      end
    end
    inline Fm_ListaMarca_Produto: TFm_ListaMarcaProduto
      Left = 678
      Top = 57
      Width = 334
      Height = 35
      TabOrder = 5
      TabStop = True
      ExplicitLeft = 678
      ExplicitTop = 57
      ExplicitWidth = 334
      ExplicitHeight = 35
      inherited Label32: TLabel
        Width = 30
        Caption = 'Marca'
        ExplicitWidth = 30
      end
      inherited Sb_Recipiente_Fabricante_3: TSpeedButton
        Left = 309
        ExplicitLeft = 309
      end
      inherited Dblcb_Marca: TDBLookupComboBox
        Width = 308
        ExplicitWidth = 308
      end
      inherited Qr_ListaMarca: TSTQuery
        Top = 36
      end
      inherited Ds_ListaMarca: TDataSource
        Top = 34
      end
    end
    inline Fm_ListaGrupoSubGrupo: TFm_ListaGrupoSubGrupo
      Left = 4
      Top = 55
      Width = 670
      Height = 42
      TabOrder = 4
      TabStop = True
      ExplicitLeft = 4
      ExplicitTop = 55
      ExplicitWidth = 670
      ExplicitHeight = 42
      inherited Label13: TLabel
        Left = 329
        Top = 1
        ExplicitLeft = 329
        ExplicitTop = 1
      end
      inherited SB_Grupos: TSpeedButton
        Left = 645
        Top = 14
        ExplicitLeft = 645
        ExplicitTop = 14
      end
      inherited DBLCB_Grupo: TDBLookupComboBox
        Width = 318
        ExplicitWidth = 318
      end
      inherited DBLCB_SubGrupo: TDBLookupComboBox
        Left = 326
        Top = 15
        Width = 316
        ExplicitLeft = 326
        ExplicitTop = 15
        ExplicitWidth = 316
      end
      inherited Qr_Grupo: TSTQuery
        Top = 43
      end
      inherited Qr_SubGrupo: TSTQuery
        Top = 43
      end
      inherited Ds_Grupo: TDataSource
        Top = 92
      end
      inherited Ds_SubGrupo: TDataSource
        Top = 92
      end
    end
    inline Fm_ListaVendedores: TFm_ListaColaboradores
      Left = 676
      Top = 100
      Width = 334
      Height = 36
      TabOrder = 7
      TabStop = True
      ExplicitLeft = 676
      ExplicitTop = 100
      ExplicitWidth = 334
      ExplicitHeight = 36
      inherited Label19: TLabel
        Width = 334
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 308
        Height = 19
        ExplicitLeft = 285
        ExplicitHeight = 17
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 302
        ExplicitWidth = 302
      end
    end
  end
  object GroupBox2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 630
    Width = 1011
    Height = 69
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 918
      Top = 5
      Width = 88
      Height = 59
      Margins.Left = 0
      Align = alRight
      Caption = 'Sair- ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 766
      ExplicitTop = 6
      ExplicitHeight = 61
    end
    object SB_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 830
      Top = 5
      Width = 88
      Height = 59
      Margins.Left = 0
      Margins.Right = 0
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
      ExplicitTop = 0
    end
    object SB_Alterar: TSpeedButton
      AlignWithMargins = True
      Left = 739
      Top = 5
      Width = 88
      Height = 59
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
      ExplicitTop = 0
    end
    object Sb_Lote: TSpeedButton
      AlignWithMargins = True
      Left = 645
      Top = 5
      Width = 88
      Height = 59
      Align = alRight
      Caption = 'Lote - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_LoteClick
      ExplicitLeft = 739
      ExplicitTop = 0
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 562
      Top = 5
      Width = 80
      Height = 59
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Imprimir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitLeft = 602
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 559
    Width = 1011
    Height = 65
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object GroupBox5: TGroupBox
      AlignWithMargins = True
      Left = 719
      Top = 3
      Width = 289
      Height = 59
      Align = alRight
      Caption = 'Totalizador de Peso'
      TabOrder = 0
      DesignSize = (
        289
        59)
      object Label10: TLabel
        Left = 7
        Top = 17
        Width = 37
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Entrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 16
      end
      object Label11: TLabel
        Left = 92
        Top = 17
        Width = 27
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Sa'#237'da'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 16
      end
      object Label13: TLabel
        Left = 189
        Top = 17
        Width = 27
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Saldo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 16
      end
      object E_Peso_Entrada: TEdit_Setes
        Left = 5
        Top = 32
        Width = 81
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        ReadOnly = True
        TabOrder = 0
        Text = ''
      end
      object E_Peso_Saida: TEdit_Setes
        Left = 92
        Top = 32
        Width = 92
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        ReadOnly = True
        TabOrder = 1
        Text = ''
      end
      object E_Peso_Saldo: TEdit_Setes
        Left = 189
        Top = 31
        Width = 88
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        ReadOnly = True
        TabOrder = 2
        Text = ''
      end
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 1017
    Height = 57
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 1017
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 1017
      ExplicitWidth = 1017
      inherited Sb_open: TSpeedButton
        Left = 993
        ExplicitLeft = 993
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 993
        ExplicitWidth = 993
      end
    end
    inherited pnl_top: TPanel
      Width = 1017
    end
  end
  object Pg_Resultado: TPageControl
    Left = 0
    Top = 207
    Width = 1017
    Height = 349
    ActivePage = tbs_pedido
    Align = alClient
    TabOrder = 4
    object tbs_pedido: TTabSheet
      Caption = 'Pedido'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Dbg_Exchange: TDBGrid
        Left = 0
        Top = 0
        Width = 1009
        Height = 321
        Align = alClient
        Color = clCream
        DataSource = Ds_Exchange
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnTitleClick = Dbg_ExchangeTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PED_NUMERO'
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRO_DESCRICAO'
            Title.Caption = 'Produto'
            Width = 346
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DT_OUT'
            Width = 70
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'WEIGHT_OUT'
            Title.Caption = 'Peso Saida'
            Width = 85
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DT_IN'
            Width = 70
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'WEIGHT_IN'
            Title.Caption = 'Peso de Entrada'
            Width = 85
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'SALDO'
            Title.Caption = 'Saldo'
            Width = 94
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMP_NOME'
            Title.Caption = 'Nome/Raz'#227'o Social'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITF_QTDE'
            Title.Caption = 'Quantidade'
            Width = 62
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMP_FANTASIA'
            Title.Caption = 'Apelido/Fantasia'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLB_NOME'
            Title.Caption = 'Vendedor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITF_VL_UNIT'
            Title.Caption = 'Valor Unit'#225'rio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRICE_TAG'
            Title.Caption = 'Pre'#231'o Troca'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USU_NOME'
            Visible = True
          end>
      end
    end
  end
  object Qr_Exchange: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'Select eb.tb_institution_id, eb.tb_order_id, eb.tb_order_item_id' +
        ', eb.dt_in, eb.dt_out, pr.pro_descricao, ep.emp_nome, ep.emp_fan' +
        'tasia, cl.clb_nome,'
      
        'it.itf_qtde, it.itf_vl_unit, eb.price_tag, eb.weight_in, eb.weig' +
        'ht_out, eb.note,'
      'us.usu_nome , (weight_out - weight_in) saldo, pd.PED_NUMERO'
      'from tb_exchange_basis eb'
      '   inner join tb_produto pr'
      '   on (pr.pro_codigo = eb.tb_product_id)'
      '   inner join tb_empresa ep'
      '   on (ep.emp_codigo = eb.tb_customer_id)'
      '   inner join tb_colaborador cl'
      '   on (cl.clb_codigo = eb.tb_salesman_id)'
      '   inner join tb_itens_nfl it'
      '   on (it.itf_codigo = eb.tb_order_item_id)'
      '   inner join tb_usuario us'
      '   on (us.usu_codigo = eb.tb_user_id)'
      '   left outer join tb_pedido pd '
      '  on (pd.PED_CODIGO = eb.TB_ORDER_ID) ')
    Left = 408
    Top = 256
    object Qr_ExchangeTB_INSTITUTION_ID: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_EXCHANGE_BASIS"."TB_INSTITUTION_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ExchangeTB_ORDER_ID: TIntegerField
      FieldName = 'TB_ORDER_ID'
      Origin = '"TB_EXCHANGE_BASIS"."TB_ORDER_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ExchangeTB_ORDER_ITEM_ID: TIntegerField
      FieldName = 'TB_ORDER_ITEM_ID'
      Origin = '"TB_EXCHANGE_BASIS"."TB_ORDER_ITEM_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ExchangePRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ExchangeEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_ExchangeEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object Qr_ExchangeCLB_NOME: TStringField
      FieldName = 'CLB_NOME'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 100
    end
    object Qr_ExchangeITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ExchangeITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object Qr_ExchangePRICE_TAG: TFMTBCDField
      FieldName = 'PRICE_TAG'
      Origin = '"TB_EXCHANGE_BASIS"."PRICE_TAG"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object Qr_ExchangeDT_OUT: TDateField
      DisplayLabel = 'Data Sa'#237'da'
      FieldName = 'DT_OUT'
      Origin = '"TB_EXCHANGE_BASIS"."DT_OUT"'
    end
    object Qr_ExchangeWEIGHT_OUT: TBCDField
      FieldName = 'WEIGHT_OUT'
      Origin = '"TB_EXCHANGE_BASIS"."WEIGHT_OUT"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 3
    end
    object Qr_ExchangeDT_IN: TDateField
      DisplayLabel = 'Data Entrada'
      FieldName = 'DT_IN'
      Origin = '"TB_EXCHANGE_BASIS"."DT_IN"'
    end
    object Qr_ExchangeWEIGHT_IN: TBCDField
      FieldName = 'WEIGHT_IN'
      Origin = '"TB_EXCHANGE_BASIS"."WEIGHT_IN"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 3
    end
    object Qr_ExchangeNOTE: TStringField
      FieldName = 'NOTE'
      Origin = '"TB_EXCHANGE_BASIS"."NOTE"'
      Size = 255
    end
    object Qr_ExchangeUSU_NOME: TStringField
      FieldName = 'USU_NOME'
      Origin = '"TB_USUARIO"."USU_NOME"'
      Size = 100
    end
    object Qr_ExchangeSALDO: TBCDField
      FieldName = 'SALDO'
      ProviderFlags = []
      DisplayFormat = '0.00'
      Precision = 18
      Size = 3
    end
    object Qr_ExchangePED_NUMERO: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
  end
  object Ds_Exchange: TDataSource
    DataSet = Qr_Exchange
    Left = 408
    Top = 312
  end
  object MainMenu: TMainMenu
    Left = 80
    Top = 288
    object arefas1: TMenuItem
      Caption = 'Tarefas'
      object AjustaPreo1: TMenuItem
        Caption = 'Ajusta Pre'#231'o'
        OnClick = AjustaPreo1Click
      end
    end
  end
end
