object Fr_Imp_ExtratoBancario: TFr_Imp_ExtratoBancario
  Left = 765
  Top = 174
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Extrato Banc'#225'rio'
  ClientHeight = 271
  ClientWidth = 434
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
    Top = 206
    Width = 434
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitTop = 207
    ExplicitWidth = 432
    DesignSize = (
      434
      65)
    object SB_Imprimir: TSpeedButton
      Left = 269
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
      ExplicitLeft = 264
    end
    object Sb_Sair_0: TSpeedButton
      Left = 349
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
      ExplicitLeft = 344
    end
    object Sb_Exportar: TSpeedButton
      Left = 191
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
      ExplicitLeft = 186
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 434
    Height = 206
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitWidth = 432
    ExplicitHeight = 207
    object RG_Data: TRadioGroup
      Left = 2
      Top = 43
      Width = 430
      Height = 40
      Align = alTop
      Caption = 'Datas do Extrato'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Diario'
        'Semanal'
        'Mensal')
      ParentFont = False
      TabOrder = 1
      TabStop = True
      OnClick = RG_DataClick
      ExplicitWidth = 428
    end
    object E_Data_Ini: TDateTimePicker
      Left = 238
      Top = 100
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object E_Data_Fim: TDateTimePicker
      Left = 333
      Top = 100
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 4
    end
    object ChBx_Periodo: TCheckBox
      Left = 239
      Top = 86
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
      TabOrder = 2
    end
    object Rg_Tipo: TRadioGroup
      Left = 2
      Top = 2
      Width = 430
      Height = 41
      Align = alTop
      Caption = 'Tipo de Documento'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Cr'#233'ditos'
        'D'#233'bitos'
        'Todos')
      ParentFont = False
      TabOrder = 0
      TabStop = True
      ExplicitWidth = 428
    end
    inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
      Left = 2
      Top = 163
      Width = 430
      Height = 41
      Align = alBottom
      TabOrder = 5
      ExplicitLeft = 3
      ExplicitTop = 160
      ExplicitWidth = 553
      ExplicitHeight = 41
      inherited L_ContaBancaria: TLabel
        Width = 430
      end
      inherited Sb_ContaBancaria: TSpeedButton
        Left = 403
        Height = 26
        ExplicitLeft = 403
      end
      inherited DBLCB_ContaBancaria: TDBLookupComboBox
        Width = 394
        Anchors = [akLeft, akTop, akRight]
        ExplicitWidth = 424
      end
    end
    inline Fm_ListaUsuario: TFm_ListaUsuarios
      Left = 2
      Top = 125
      Width = 430
      Height = 38
      Align = alBottom
      TabOrder = 6
      Visible = False
      ExplicitLeft = 4
      ExplicitTop = 117
      ExplicitWidth = 430
      ExplicitHeight = 38
      inherited Label19: TLabel
        Width = 37
        Caption = 'Usu'#225'rio'
        ExplicitWidth = 37
      end
      inherited Sb_Medida: TSpeedButton
        Left = 400
        Visible = False
        ExplicitLeft = 342
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 425
        ExplicitWidth = 425
      end
      inherited Qr_Lista: TSTQuery
        Top = 47
      end
      inherited DS_Lista: TDataSource
        Left = 124
        Top = 50
      end
    end
  end
  object Ds_Usuario: TDataSource
    DataSet = DM.Qr_ListaUsuario
    Left = 168
    Top = 112
  end
end
