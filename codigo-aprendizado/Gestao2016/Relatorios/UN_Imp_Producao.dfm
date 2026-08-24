object Fr_Imp_Producao: TFr_Imp_Producao
  Left = 250
  Top = 175
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Vendas'
  ClientHeight = 212
  ClientWidth = 385
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
  DesignSize = (
    385
    212)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 98
    Width = 82
    Height = 14
    Caption = 'Nome do Produto'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Sair_0: TSpeedButton
    Left = 300
    Top = 156
    Width = 80
    Height = 54
    Anchors = [akBottom]
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
    ExplicitLeft = 265
    ExplicitTop = 142
  end
  object SB_Imprimir: TSpeedButton
    Left = 211
    Top = 156
    Width = 80
    Height = 54
    Anchors = [akBottom]
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
    ExplicitLeft = 185
    ExplicitTop = 142
  end
  object Sb_Exportar: TSpeedButton
    Left = 124
    Top = 156
    Width = 78
    Height = 54
    Anchors = [akBottom]
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
    ExplicitLeft = 107
    ExplicitTop = 142
  end
  object RG_Tipo: TRadioGroup
    Left = 5
    Top = 2
    Width = 336
    Height = 52
    Caption = 'Tipo de Documento'
    Columns = 3
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Produto Acabado'
      'Materia Prima'
      'Todos')
    ParentFont = False
    TabOrder = 0
  end
  object DBLCB_Produto: TDBLookupComboBox
    Left = 7
    Top = 115
    Width = 333
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyField = 'PRO_CODIGO'
    ListField = 'PRO_DESCRICAO'
    ListSource = Ds_Produto
    ParentFont = False
    TabOrder = 3
    OnKeyDown = DBLCB_ProdutoKeyDown
  end
  object E_Data_Ini: TDateTimePicker
    Left = 9
    Top = 74
    Width = 86
    Height = 22
    Date = 39580.356281493060000000
    Time = 39580.356281493060000000
    TabOrder = 1
  end
  object E_Data_Fim: TDateTimePicker
    Left = 104
    Top = 74
    Width = 85
    Height = 22
    Date = 39580.356281493060000000
    Time = 39580.356281493060000000
    TabOrder = 2
  end
  object ChBx_Periodo: TCheckBox
    Left = 9
    Top = 59
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
    TabOrder = 4
  end
  object Ds_Produto: TDataSource
    Left = 262
    Top = 64
  end
end
