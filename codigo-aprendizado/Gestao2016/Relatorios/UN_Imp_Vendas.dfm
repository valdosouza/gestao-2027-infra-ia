object Fr_Imp_Vendas: TFr_Imp_Vendas
  Left = 300
  Top = 91
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Faturamento'
  ClientHeight = 500
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 435
    Width = 623
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitTop = 425
    object Sb_Sair_0: TSpeedButton
      Left = 541
      Top = 2
      Width = 80
      Height = 61
      Align = alRight
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 529
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Imprimir: TSpeedButton
      Left = 461
      Top = 2
      Width = 80
      Height = 61
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
      ExplicitLeft = 452
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Exportar: TSpeedButton
      Left = 383
      Top = 2
      Width = 78
      Height = 61
      Align = alRight
      Caption = 'Exportar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ExportarClick
      ExplicitLeft = 373
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 185
    Height = 378
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitHeight = 368
    object Label4: TLabel
      Left = 4
      Top = 3
      Width = 80
      Height = 14
      Caption = 'Tipo de Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LBx_TipoRelatorio: TListBox
      Left = 2
      Top = 19
      Width = 181
      Height = 357
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        'VENDA NORMAL'
        'VENDA DETALHADA'
        'VENDA POR ITEM'
        'GERAL CLIENTE'
        'GERAL CLIENTE ANUAL'
        'PRODUTO'
        'CONSERTOS'
        'PEDIDO PENDENTES'
        'VENDA - TOTAL PRODUTOS'
        'VENDA RESUMIDA CLIENTE'
        'TROCAS NAS VENDAS'
        'DEVOLU'#199#195'O NAS VENDAS'
        'VENDA X CUSTO UNICO')
      TabOrder = 0
      OnClick = LBx_TipoRelatorioClick
      ExplicitHeight = 347
    end
  end
  object PageControl1: TPageControl
    Left = 185
    Top = 57
    Width = 438
    Height = 378
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    ExplicitHeight = 368
    object TabSheet1: TTabSheet
      Caption = 'Par'#226'metros'
      ExplicitHeight = 340
      object Pnl_Parametro: TPanel
        Left = 0
        Top = 0
        Width = 430
        Height = 350
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 340
        object Label3: TLabel
          Left = 4
          Top = 159
          Width = 75
          Height = 14
          Caption = 'Transportadora'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 6
          Top = 122
          Width = 205
          Height = 14
          Caption = 'Se preferir digite parte do nome do Cliente '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Processo: TLabel
          Left = 5
          Top = 302
          Width = 413
          Height = 14
          AutoSize = False
          Caption = 'Processamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Gg_Progresso: TGauge
          Left = 4
          Top = 317
          Width = 412
          Height = 25
          Progress = 0
        end
        object Label9: TLabel
          Left = 7
          Top = 257
          Width = 33
          Height = 14
          Caption = 'Regi'#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 8
          Top = 84
          Width = 33
          Height = 14
          Caption = 'C'#243'digo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBLCB_Empresa: TDBLookupComboBox
          Left = 73
          Top = 99
          Width = 352
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'EMP_CODIGO'
          ListField = 'EMP_NOME'
          ListSource = DM_ListaConsultas.Ds_ListaCliente
          ParentFont = False
          TabOrder = 4
          OnKeyDown = DBLCB_EmpresaKeyDown
        end
        object ChBx_Nome: TCheckBox
          Left = 72
          Top = 82
          Width = 121
          Height = 17
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 9
          OnClick = ChBx_NomeClick
        end
        object ChBx_Fantasia: TCheckBox
          Left = 199
          Top = 82
          Width = 121
          Height = 17
          Caption = 'Apelido/Fantasia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnClick = ChBx_FantasiaClick
        end
        object DBLCB_Transportadora: TDBLookupComboBox
          Left = 5
          Top = 175
          Width = 419
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'EMP_CODIGO'
          ListField = 'EMP_NOME'
          ListSource = DM_ListaConsultas.Ds_ListaTransportadora
          ParentFont = False
          TabOrder = 6
          OnKeyDown = DBLCB_TransportadoraKeyDown
        end
        object E_Empresa: TEdit
          Left = 5
          Top = 137
          Width = 417
          Height = 21
          TabOrder = 5
        end
        object DBLCB_Regiao: TDBLookupComboBox
          Left = 4
          Top = 272
          Width = 242
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'END_REGIAO'
          ListField = 'END_REGIAO'
          ListSource = Ds_Regiao
          ParentFont = False
          TabOrder = 8
          OnKeyDown = DBLCB_RegiaoKeyDown
        end
        object GroupBox2: TGroupBox
          Left = 5
          Top = 198
          Width = 418
          Height = 61
          Caption = 'Nome do Vendedor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          object Rb_Vend_Clliente: TRadioButton
            Left = 5
            Top = 15
            Width = 114
            Height = 17
            Caption = 'Cadastro do Cliente'
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object Rb_Vend_Pedido: TRadioButton
            Left = 141
            Top = 16
            Width = 131
            Height = 17
            Caption = 'Registrado no Pedido'
            TabOrder = 1
          end
          object DBLCB_Vendedor: TDBLookupComboBox
            Left = 3
            Top = 31
            Width = 408
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'CLB_CODIGO'
            ListField = 'CLB_NOME'
            ListSource = DM_ListaConsultas.DS_ListaVendedor
            ParentFont = False
            TabOrder = 2
            TabStop = False
            OnKeyDown = DBLCB_VendedorKeyDown
          end
        end
        object E_BuscaCodigo: TMaskEdit
          Left = 5
          Top = 99
          Width = 65
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = ''
          OnExit = E_BuscaCodigoExit
        end
        object ChBx_Periodo: TCheckBox
          Left = 6
          Top = 41
          Width = 178
          Height = 12
          Caption = 'Data Inicial         Data Final'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 11
          OnClick = ChBx_PeriodoClick
        end
        object RG_Tipo: TRadioGroup
          Left = 2
          Top = 2
          Width = 426
          Height = 38
          Align = alTop
          Caption = 'Tipo de Documento'
          Columns = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Pedidos'
            'Notas'
            'Todos')
          ParentFont = False
          TabOrder = 0
        end
        object E_Data_Ini: TDateTimePicker
          Left = 5
          Top = 55
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 1
        end
        object E_Data_Fim: TDateTimePicker
          Left = 100
          Top = 55
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Outros Par'#226'metros'
      ImageIndex = 1
      ExplicitHeight = 340
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 430
        Height = 350
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 340
        object ChBx_InternetPublished: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 420
          Height = 17
          Align = alTop
          Caption = 'Apenas produtos publicados na Internet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitTop = 3
          ExplicitWidth = 300
        end
        object Chbx_obs_field: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 28
          Width = 420
          Height = 17
          Align = alTop
          Caption = 'Mostrar campo observa'#231#227'o no relatorio de venda detalhada'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ExplicitTop = 3
          ExplicitWidth = 300
        end
      end
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 623
    Height = 57
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 623
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 623
      ExplicitWidth = 623
      inherited Sb_open: TSpeedButton
        Left = 599
        ExplicitLeft = 599
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 599
        ExplicitWidth = 599
      end
    end
    inherited pnl_top: TPanel
      Width = 623
      ExplicitWidth = 623
      inherited L_name_list: TLabel
        Width = 600
        Height = 16
      end
    end
  end
  object Qr_Exporta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  NFL_TIPO, '
      '  NFL_DT_EMISSAO, '
      '  NFL_NUMERO, '
      '  EMP_NOME, '
      '  EMP_CNPJ, '
      '  EMP_INSC_EST, '
      '  UFE_SIGLA, '
      '  NFL_BS_ICMS, '
      '  NFL_VL_ICMS, '
      '  NFL_VL_IPI, '
      '  NFL_VL_TL_PROD, '
      '  NFL_VL_TL_NOTA'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM)'
      'AND (NFL_NUMERO <> '#39#39') AND (NFL_TIPO <> '#39'EM'#39')'
      'ORDER BY NFL_DT_EMISSAO,EMP_NOME')
    Left = 320
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATAINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATAFIM'
        ParamType = ptUnknown
      end>
  end
  object Qr_Transportadora: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_CNPJ,'
      '  EMP_INSC_EST,'
      '  EMP_STCRED,'
      '  EMP_OBSERV,'
      '  EMP_DT_CADASTRO,'
      '  EMP_PESSOA,'
      '  EMP_CONSUMIDOR,'
      '  EMP_MICRO,'
      '  EMP_VL_CRED,'
      '  EMP_CODVDOR,'
      '  EMP_ML_DRT,'
      '  EMP_CODBCO,'
      '  EMP_AGENCIA,'
      '  EMP_CONTABCO,'
      '  EMP_EMAIL,'
      '  EMP_SITE,'
      '  EMP_RAM_ATIV,'
      '  EMP_DT_FUNDA,'
      '  EMP_CODTRANSP,'
      '  EMP_MULTIPLICADOR,'
      '  END_ENDER,'
      
        '  END_BAIRRO, END_CEP, CDD_DESCRICAO, END_COMPLEM, UFE_SIGLA, EN' +
        'D_FONE, END_FAX, END_TIPO,'
      '  EMP_RED_CONTRATO'
      'FROM TB_EMPRESA'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '    ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (EMP_TIPO = 3)'
      'ORDER BY EMP_FANTASIA')
    Left = 159
    Top = 3
  end
  object Ds_Regiao: TDataSource
    DataSet = Qr_Regiao
    Left = 211
    Top = 443
  end
  object Qr_Regiao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT END_REGIAO'
      'FROM TB_EMPRESA'
      '   INNER JOIN TB_ENDERECO'
      '   ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO)'
      'WHERE (EMP_TIPO=:EMP_TIPO)'
      'AND END_REGIAO <> '#39#39
      'ORDER BY END_REGIAO')
    Left = 210
    Top = 403
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_TIPO'
        ParamType = ptUnknown
      end>
  end
  object PrintDialog1: TPrintDialog
    Left = 128
    Top = 424
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 40
    Top = 416
  end
end
