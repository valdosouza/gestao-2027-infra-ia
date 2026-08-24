object Fr_Imp_CtasPagar: TFr_Imp_CtasPagar
  Left = 447
  Top = 271
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Contas a Pagar'
  ClientHeight = 240
  ClientWidth = 427
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
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 427
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      427
      50)
    object chbx_Empresas: TCheckBox
      Left = 7
      Top = 8
      Width = 165
      Height = 14
      Caption = 'Selecionar todas as Empresas'
      TabOrder = 0
      OnClick = chbx_EmpresasClick
    end
    object Dblcb_Mha_Empresa: TDBLookupComboBox
      Left = 5
      Top = 24
      Width = 415
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 50
    Width = 427
    Height = 125
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label2: TLabel
      Left = 7
      Top = 82
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
    object Label3: TLabel
      Left = 5
      Top = 43
      Width = 88
      Height = 14
      Caption = 'Tipo/Classifica'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 237
      Top = 58
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Data_Fim: TDateTimePicker
      Left = 332
      Top = 58
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object ChBx_Periodo: TCheckBox
      Left = 238
      Top = 43
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
      TabOrder = 6
      OnClick = ChBx_PeriodoClick
    end
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 70
      Top = 97
      Width = 352
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaFornecedor
      ParentFont = False
      TabOrder = 5
      OnKeyDown = DBLCB_EmpresaKeyDown
    end
    object ChBx_Nome: TCheckBox
      Left = 71
      Top = 80
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
      TabOrder = 7
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 198
      Top = 80
      Width = 121
      Height = 17
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = ChBx_FantasiaClick
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 4
      Top = 97
      Width = 63
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
      OnExit = E_BuscaCodigoExit
    end
    object CB_Tipo: TComboBox
      Left = 4
      Top = 57
      Width = 229
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = 'VENCIMENTO'
      Items.Strings = (
        'VENCIMENTO')
    end
    object RG_Tipo: TRadioGroup
      Left = 2
      Top = 2
      Width = 423
      Height = 40
      Align = alTop
      Caption = '[ Tipo de Documento ]'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'A Vencer'
        'Vencidos'
        'Todos')
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
  end
  object TPanel
    Left = 0
    Top = 175
    Width = 427
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      427
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 342
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
      Left = 262
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
      Left = 184
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
  object Ds_Fornecedor: TDataSource
    DataSet = Qr_Fornece
    Left = 296
    Top = 11
  end
  object Qr_Fornece: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ForneceAfterOpen
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
    Left = 266
    Top = 14
  end
end
