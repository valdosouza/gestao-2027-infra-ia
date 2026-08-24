object Fr_Imp_Ajuste: TFr_Imp_Ajuste
  Left = 440
  Top = 228
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Ajustes'
  ClientHeight = 261
  ClientWidth = 432
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
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_botao: TPanel
    Left = 0
    Top = 196
    Width = 432
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      432
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 349
      Top = 6
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - Esc'
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
      Left = 271
      Top = 6
      Width = 78
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
      Left = 193
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
  object Pnl_Parametros: TPanel
    Left = 0
    Top = 50
    Width = 432
    Height = 146
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      432
      146)
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
    object Label8: TLabel
      Left = 5
      Top = 42
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
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 78
      Top = 100
      Width = 347
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEmpresa
      ParentFont = False
      TabOrder = 6
      OnKeyDown = DBLCB_EmpresaKeyDown
    end
    object ChBx_Nome: TCheckBox
      Left = 79
      Top = 84
      Width = 121
      Height = 14
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
      TabOrder = 8
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 195
      Top = 84
      Width = 121
      Height = 14
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = ChBx_FantasiaClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 236
      Top = 56
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object E_Data_Fim: TDateTimePicker
      Left = 332
      Top = 56
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 4
    end
    object ChBx_Periodo: TCheckBox
      Left = 237
      Top = 42
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
      TabOrder = 10
      OnClick = ChBx_PeriodoClick
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 5
      Top = 100
      Width = 71
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = ''
      OnExit = E_BuscaCodigoExit
    end
    object CB_Tipo: TComboBox
      Left = 4
      Top = 57
      Width = 229
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        'Normal'
        'Detalhado')
    end
    object RG_Tipo: TRadioGroup
      Left = 3
      Top = 2
      Width = 248
      Height = 38
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
    object Rg_Operacao: TRadioGroup
      Left = 253
      Top = 2
      Width = 168
      Height = 38
      Caption = 'Tipo Opera'#231#227'o'
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Entrada'
        'Saida')
      ParentFont = False
      TabOrder = 1
    end
    object ChBx_Pendente: TCheckBox
      Left = 4
      Top = 126
      Width = 234
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Apenas documentos pendentes para retorno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
  end
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 432
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
      432
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
      Width = 420
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
    end
  end
end
