object Fr_Imp_Eventos: TFr_Imp_Eventos
  Left = 340
  Top = 229
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Eventos da Folha'
  ClientHeight = 249
  ClientWidth = 398
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
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 398
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
      398
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
      Width = 386
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
    Width = 398
    Height = 134
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label3: TLabel
      Left = 6
      Top = 83
      Width = 92
      Height = 14
      Caption = 'Nome do Vendedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 205
      Top = 59
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 298
      Top = 59
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 208
      Top = 45
      Width = 178
      Height = 12
      Caption = 'Data Inicial       Data Final'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object Dblcb_Vendedor: TDBLookupComboBox
      Left = 3
      Top = 103
      Width = 390
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
      TabOrder = 3
      OnKeyDown = Dblcb_VendedorKeyDown
    end
    object RG_Tipo: TRadioGroup
      Left = 2
      Top = 2
      Width = 394
      Height = 40
      Align = alTop
      Caption = 'Tipo de Evento'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Cr'#233'dito'
        'D'#233'bito'
        'Todas')
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
  end
  object TPanel
    Left = 0
    Top = 184
    Width = 398
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      398
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 313
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
      Left = 233
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
      Left = 155
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
  object Ds_Colaborador: TDataSource
    DataSet = DM.Qr_Colaborador
    Left = 248
    Top = 112
  end
end
