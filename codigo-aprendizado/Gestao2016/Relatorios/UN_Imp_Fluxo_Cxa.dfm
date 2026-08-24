object Fr_Imp_Fluxo_Cxa: TFr_Imp_Fluxo_Cxa
  Left = 427
  Top = 288
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Fluxo de Caixa'
  ClientHeight = 170
  ClientWidth = 462
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
  object TPanel
    Left = 0
    Top = 105
    Width = 462
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      462
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 377
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
      Left = 291
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
      Left = 219
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
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 462
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      462
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
      Width = 450
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
    Width = 462
    Height = 55
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label3: TLabel
      Left = 6
      Top = 4
      Width = 80
      Height = 14
      Caption = 'Tipo do Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 238
      Top = 19
      Width = 85
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 326
      Top = 19
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 239
      Top = 4
      Width = 161
      Height = 13
      Caption = 'Data Inicial      Data Final'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = ChBx_PeriodoClick
    end
    object CB_Tipo: TComboBox
      Left = 5
      Top = 19
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
      TabOrder = 3
      Text = 'REAL PROGRAMADO'
      Items.Strings = (
        'REAL PROGRAMADO'
        'SIMULADO A REALIZAR')
    end
  end
end
