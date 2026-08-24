object Fr_Imp_Duplicatas: TFr_Imp_Duplicatas
  Left = 334
  Top = 165
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsDialog
  Caption = 'Relat'#243'rio de Duplicatas'
  ClientHeight = 338
  ClientWidth = 438
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 273
    Width = 438
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitTop = 249
    ExplicitWidth = 430
    DesignSize = (
      438
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 353
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
      ExplicitLeft = 345
    end
    object SB_Imprimir: TSpeedButton
      Left = 273
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
      ExplicitLeft = 265
    end
    object Sb_Exportar: TSpeedButton
      Left = 195
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
      ExplicitLeft = 187
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 50
    Width = 438
    Height = 223
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitWidth = 430
    ExplicitHeight = 199
    object Label2: TLabel
      Left = 8
      Top = 156
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
      Left = 194
      Top = 112
      Width = 59
      Height = 14
      Caption = 'N'#186' Duplicata'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RG_Tipo: TRadioGroup
      Left = 2
      Top = 4
      Width = 265
      Height = 50
      Caption = 'Tipo de Documento'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Baixadas'
        'Abertas'
        'Todas')
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object RG_Financeiro: TRadioGroup
      Left = 270
      Top = 4
      Width = 155
      Height = 50
      Caption = 'Financeiro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Contas '#224' Receber'
        'Contas '#224' Pagar')
      ParentFont = False
      TabOrder = 1
      TabStop = True
      OnClick = RG_FinanceiroClick
    end
    object Rg_TipoOperacao: TRadioGroup
      Left = 2
      Top = 56
      Width = 266
      Height = 50
      Caption = 'Tipo de Opera'#231#227'o'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Creditos'
        'Debitos'
        'Todos')
      ParentFont = False
      TabOrder = 2
      TabStop = True
    end
    object Rg_Datas: TRadioGroup
      Left = 271
      Top = 56
      Width = 155
      Height = 50
      Caption = 'Datas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Vencimento'
        'Pagamento')
      ParentFont = False
      TabOrder = 3
      TabStop = True
    end
    object E_Data_Ini: TDateTimePicker
      Left = 8
      Top = 126
      Width = 94
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 4
    end
    object E_Data_Fim: TDateTimePicker
      Left = 104
      Top = 126
      Width = 89
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 5
    end
    object ChBx_Periodo: TCheckBox
      Left = 8
      Top = 110
      Width = 161
      Height = 14
      Caption = 'Data Inicial         Data Final'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 9
      OnClick = ChBx_PeriodoClick
    end
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 71
      Top = 171
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
      TabOrder = 8
      OnKeyDown = DBLCB_EmpresaKeyDown
    end
    object ChBx_Nome: TCheckBox
      Left = 72
      Top = 154
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
      TabOrder = 10
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 199
      Top = 154
      Width = 121
      Height = 17
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = ChBx_FantasiaClick
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 5
      Top = 171
      Width = 63
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = ''
      OnExit = E_BuscaCodigoExit
    end
    object E_BuscaFinanceiro: TEdit
      Left = 194
      Top = 126
      Width = 96
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object Chbx_mostrar_creditos_Manuais: TCheckBox
      Left = 11
      Top = 199
      Width = 242
      Height = 14
      Caption = 'Mostrar somente os cr'#233'ditos manuais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      OnClick = ChBx_PeriodoClick
    end
  end
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 438
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 430
    DesignSize = (
      438
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
      Width = 426
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
      ExplicitWidth = 418
    end
  end
  object Qr_Cliente: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ClienteAfterOpen
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
    Left = 346
    Top = 162
  end
  object Ds_Cliente: TDataSource
    DataSet = Qr_Cliente
    Left = 304
    Top = 164
  end
end
