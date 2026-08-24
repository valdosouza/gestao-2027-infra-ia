object Fr_Imp_Notas: TFr_Imp_Notas
  Left = 359
  Top = 163
  BorderStyle = bsDialog
  Caption = 'Relat'#243'rio de Notas Fiscais'
  ClientHeight = 312
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 248
    Width = 613
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      613
      64)
    object Sb_Sair_0: TSpeedButton
      Left = 528
      Top = 5
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
      ExplicitLeft = 491
    end
    object SB_Imprimir: TSpeedButton
      Left = 447
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
      Left = 363
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
    Left = 182
    Top = 0
    Width = 431
    Height = 248
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      431
      248)
    object Gg_Progresso: TGauge
      Left = 6
      Top = 152
      Width = 419
      Height = 23
      Anchors = [akTop, akRight]
      Progress = 0
    end
    object Label2: TLabel
      Left = 7
      Top = 51
      Width = 54
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'C'#243'd Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 5
    end
    object Lb_Processamento: TLabel
      Left = 8
      Top = 136
      Width = 87
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Processamento....'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 73
      Top = 66
      Width = 352
      Height = 22
      Anchors = [akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEmpresa
      ParentFont = False
      TabOrder = 3
      OnKeyDown = DBLCB_EmpresaKeyDown
    end
    object ChBx_Nome: TCheckBox
      Left = 74
      Top = 49
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
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
      TabOrder = 4
      OnClick = ChBx_NomeClick
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 7
      Top = 66
      Width = 65
      Height = 22
      Anchors = [akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnExit = E_BuscaCodigoExit
    end
    object ChBx_Fantasia: TCheckBox
      Left = 192
      Top = 48
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = ChBx_FantasiaClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 239
      Top = 20
      Width = 92
      Height = 22
      Anchors = [akTop, akRight]
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 334
      Top = 20
      Width = 92
      Height = 22
      Anchors = [akTop, akRight]
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 240
      Top = 5
      Width = 178
      Height = 12
      Anchors = [akTop, akRight]
      Caption = 'Data Inicial         Data Final'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 6
      OnClick = ChBx_PeriodoClick
    end
    inline Fm_lista_cfop: TFm_lista_cfop
      AlignWithMargins = True
      Left = 6
      Top = 91
      Width = 415
      Height = 42
      Margins.Top = 0
      Margins.Bottom = 0
      TabOrder = 7
      ExplicitLeft = 6
      ExplicitTop = 91
      ExplicitWidth = 415
      ExplicitHeight = 42
      inherited pnl_linha_1: TPanel
        Width = 415
        ExplicitWidth = 415
        inherited Sb_open: TSpeedButton
          Left = 391
          ExplicitLeft = 417
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 391
          ExplicitWidth = 391
        end
      end
      inherited pnl_top: TPanel
        Width = 415
        ExplicitWidth = 415
        inherited Chbx_cfop: TCheckBox
          Visible = False
        end
      end
    end
    object ChBx_Lote_cancelada: TCheckBox
      Left = 5
      Top = 226
      Width = 244
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Gerar lote somente com notas canceladas '
      TabOrder = 8
      Visible = False
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 182
    Height = 248
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label11: TLabel
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
      Width = 178
      Height = 227
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 14
      Items.Strings = (
        'Nota de Compras'
        'Notas de Ajustes'
        'Notas de Vendas Geral'
        'Notas de Vendas NF-e '
        'Notas de Vendas NFC-e '
        'Notas Geral'
        'Notas Geral NF-e'
        'RESUMO CFOP'
        'FORMATO CORDILHEIRA'
        'LOTE NF-E'
        'LOTE NFC-E'
        'LOTE NF-E de TERCEIROS'
        'Gerencial NFE (Sebrae)'
        'LOTE NFS-E')
      TabOrder = 0
      OnClick = LBx_TipoRelatorioClick
    end
  end
  object Qr_Exporta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
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
      '   LEFT OUTER JOIN TB_UF tb_uf'
      '  on (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      ''
      'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM)'
      'AND (NFL_NUMERO <> '#39#39') AND (NFL_TIPO <> '#39'EM'#39')'
      'ORDER BY NFL_DT_EMISSAO,EMP_NOME')
    Left = 224
    Top = 106
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
  object Ftp_Cliente: TIdFTP
    OnWork = Ftp_ClienteWork
    OnWorkBegin = Ftp_ClienteWorkBegin
    OnWorkEnd = Ftp_ClienteWorkEnd
    IPVersion = Id_IPv4
    Host = 'setes.com.br'
    ConnectTimeout = 0
    TransferType = ftBinary
    Username = 'setes'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    ReadTimeout = 0
    Left = 72
    Top = 232
  end
end
