object Fr_Imp_Orcamento: TFr_Imp_Orcamento
  Left = 404
  Top = 166
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Or'#231'amentos'
  ClientHeight = 443
  ClientWidth = 613
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
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 9
    Top = 230
    Width = 3
    Height = 14
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 185
    Top = 48
    Width = 428
    Height = 330
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 86
      Width = 54
      Height = 14
      Caption = 'C'#243'd Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 62
      Top = 188
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 7
      Top = 189
      Width = 16
      Height = 14
      Caption = 'U.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RG_Tipo: TRadioGroup
      Left = 2
      Top = 2
      Width = 424
      Height = 43
      Align = alTop
      Caption = 'Tipo de Or'#231'amento'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'Aberto'
        'Fechado'
        'Todos')
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object E_Data_Ini: TDateTimePicker
      Left = 240
      Top = 60
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 333
      Top = 60
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 240
      Top = 46
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
      TabOrder = 8
      OnClick = ChBx_PeriodoClick
    end
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 72
      Top = 101
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
      Left = 73
      Top = 84
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
      Left = 200
      Top = 84
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
    object E_BuscaCodigo: TMaskEdit
      Left = 5
      Top = 101
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
    object GroupBox2: TGroupBox
      Left = 5
      Top = 124
      Width = 418
      Height = 61
      Caption = 'Nome do Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
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
        Left = 4
        Top = 33
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
    object DBLCB_CIDADE: TDBLookupComboBox
      Left = 59
      Top = 204
      Width = 363
      Height = 21
      KeyField = 'CDD_DESCRICAO'
      ListField = 'CDD_DESCRICAO'
      ListSource = DM.Ds_Cidades
      TabOrder = 7
    end
    object DBLCB_UF: TDBLookupComboBox
      Left = 6
      Top = 204
      Width = 51
      Height = 21
      KeyField = 'UFE_CODIGO'
      ListField = 'UFE_SIGLA'
      ListSource = DM.Ds_UF
      TabOrder = 6
    end
    inline Fm_ListaAuxiliarVenda: TFm_ListaColaboradores
      Left = 5
      Top = 230
      Width = 420
      Height = 36
      TabOrder = 11
      ExplicitLeft = 5
      ExplicitTop = 230
      ExplicitWidth = 420
      ExplicitHeight = 36
      inherited Label19: TLabel
        Width = 420
        Caption = 'Auxiliar Venda'
        ExplicitWidth = 70
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 394
        Height = 19
        ExplicitLeft = 199
        ExplicitHeight = 19
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 391
        ExplicitWidth = 391
      end
      inherited Qr_ListaVendedor: TSTQuery
        Transaction = DM.IB_Transacao
      end
    end
  end
  object TPanel
    Left = 0
    Top = 378
    Width = 613
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      613
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 528
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
    object SB_Imprimir: TSpeedButton
      Left = 448
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
    object Sb_Exportar: TSpeedButton
      Left = 370
      Top = 6
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 48
    Width = 185
    Height = 330
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
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
      Height = 309
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        'OR'#199'AMENTO GERAL'
        'OR'#199'AMENTO DETALHADO')
      TabOrder = 0
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 613
    Height = 48
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 613
    ExplicitHeight = 48
    inherited pnl_linha_1: TPanel
      Width = 613
      ExplicitWidth = 613
      inherited Sb_open: TSpeedButton
        Left = 589
        ExplicitLeft = 589
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 589
        ExplicitWidth = 589
      end
    end
    inherited pnl_top: TPanel
      Width = 613
    end
  end
  object Ds_Cliente: TDataSource
    Left = 232
    Top = 48
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
  object Qr_Cliente: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  EMP_CODIGO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA'
      'FROM TB_EMPRESA'
      'ORDER BY EMP_NOME')
    Left = 234
    Top = 65532
  end
end
