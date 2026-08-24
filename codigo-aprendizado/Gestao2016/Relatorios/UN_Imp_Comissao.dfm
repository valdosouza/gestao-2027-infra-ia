object Fr_Imp_Comissao: TFr_Imp_Comissao
  Left = 525
  Top = 228
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Comiss'#227'o'
  ClientHeight = 249
  ClientWidth = 396
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
    Width = 396
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
      396
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
      Width = 384
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
    Width = 396
    Height = 134
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label4: TLabel
      Left = 6
      Top = 45
      Width = 80
      Height = 14
      Caption = 'Tipo do Relatorio'
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
      Width = 392
      Height = 41
      Align = alTop
      Caption = 'Tipo de Documento'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Pagas'
        'N'#227'o Pagas'
        'Todas')
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object CB_Tipo: TComboBox
      Left = 4
      Top = 60
      Width = 197
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'RESUMIDA'
      Items.Strings = (
        'RESUMIDA'
        'DETALHADA'
        'PREVIS'#195'O'
        'BAIXA NO FINANCEIRO'
        'VENDEDOR/CIDADE'
        'COMISS'#195'O - MODELO CUPOM')
    end
    object E_Data_Ini: TDateTimePicker
      Left = 205
      Top = 59
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Data_Fim: TDateTimePicker
      Left = 298
      Top = 59
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
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
      OnClick = ChBx_PeriodoClick
    end
    inline Fm_ListaColaborador: TFm_ListaColaboradores
      Left = 2
      Top = 93
      Width = 392
      Height = 39
      Align = alBottom
      TabOrder = 5
      ExplicitLeft = 2
      ExplicitTop = 93
      ExplicitWidth = 392
      ExplicitHeight = 39
      inherited Label19: TLabel
        Width = 392
        Caption = 'Colaborador'
        ExplicitWidth = 59
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 366
        Height = 22
        ExplicitLeft = 366
        ExplicitHeight = 22
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 363
        ExplicitWidth = 363
      end
    end
  end
  object TPanel
    Left = 0
    Top = 184
    Width = 396
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 311
      Top = 5
      Width = 80
      Height = 55
      Margins.Left = 1
      Align = alRight
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
      ExplicitLeft = 313
      ExplicitTop = 6
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 229
      Top = 5
      Width = 80
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
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
      ExplicitLeft = 225
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Exportar: TSpeedButton
      AlignWithMargins = True
      Left = 149
      Top = 5
      Width = 78
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
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
      ExplicitTop = 4
    end
  end
end
