object Fr_Imp_Caixa: TFr_Imp_Caixa
  Left = 267
  Top = 174
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio do Caixa'
  ClientHeight = 239
  ClientWidth = 467
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
  object Panel1: TPanel
    Left = 0
    Top = 171
    Width = 467
    Height = 68
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      467
      68)
    object SB_Imprimir: TSpeedButton
      Left = 301
      Top = 9
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
      ExplicitLeft = 257
    end
    object Sb_Sair_0: TSpeedButton
      Left = 382
      Top = 9
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
      ExplicitLeft = 338
    end
    object Sb_Exportar: TSpeedButton
      Left = 222
      Top = 9
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
      ExplicitLeft = 178
    end
  end
  object Panel2: TPanel
    Left = 145
    Top = 0
    Width = 322
    Height = 171
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label3: TLabel
      Left = 5
      Top = 81
      Width = 127
      Height = 14
      Caption = 'Descri'#231#227'o dos Hist'#243'riscos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 5
      Top = 121
      Width = 37
      Height = 14
      Caption = 'Usu'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Historico: TEdit
      Left = 5
      Top = 97
      Width = 308
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object RG_Tipo: TRadioGroup
      Left = 2
      Top = 2
      Width = 318
      Height = 40
      Align = alTop
      Caption = 'Tipo de Documento'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'Cr'#233'ditos'
        'D'#233'bitos'
        'Todos')
      ParentFont = False
      TabOrder = 0
    end
    object DBLCB_Usuario: TDBLookupComboBox
      Left = 5
      Top = 136
      Width = 220
      Height = 21
      DataField = 'PED_CODVDO'
      KeyField = 'USU_CODIGO'
      ListField = 'USU_LOGIN'
      ListSource = Ds_Usuario
      TabOrder = 4
      OnKeyDown = DBLCB_UsuarioKeyDown
    end
    object E_Data_Ini: TDateTimePicker
      Left = 5
      Top = 58
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 100
      Top = 58
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 44
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
      TabOrder = 5
      OnClick = ChBx_PeriodoClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 145
    Height = 171
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
      Width = 141
      Height = 150
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        'RESUMIDO - A4'
        'DETALHADO - A4'
        'RESUMIDO  - CUPOM'
        'DETALHADO -  CUPOM')
      TabOrder = 0
    end
  end
  object Ds_Usuario: TDataSource
    DataSet = DM.Qr_ListaUsuario
    Left = 192
    Top = 160
  end
  object Composicao: TQRCompositeReport
    OnAddReports = ComposicaoAddReports
    Options = []
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.MemoryLimit = 1000000
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrinterSettings.Orientation = poPortrait
    PrinterSettings.PaperSize = Letter
    PageCount = 0
    Left = 376
    Top = 8
  end
end
