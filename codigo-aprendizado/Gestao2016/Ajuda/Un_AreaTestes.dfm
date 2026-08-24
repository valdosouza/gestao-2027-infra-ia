object Fr_AreaTestes: TFr_AreaTestes
  Left = 406
  Top = 169
  BorderStyle = bsSingle
  Caption = #193'rea de testes'
  ClientHeight = 225
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 225
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      430
      225)
    object Label4: TLabel
      Left = 5
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
    object Sb_Sair_0: TSpeedButton
      Left = 345
      Top = 165
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
      Left = 265
      Top = 165
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
      Left = 181
      Top = 164
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
    object Lb_Progresso: TLabel
      Left = 4
      Top = 120
      Width = 155
      Height = 14
      Caption = 'Acompanhamento do Progresso'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Gg_Progresso: TGauge
      Left = 4
      Top = 136
      Width = 419
      Height = 22
      Progress = 0
      Visible = False
    end
    object Label1: TLabel
      Left = 7
      Top = 43
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
    object Label2: TLabel
      Left = 6
      Top = 83
      Width = 110
      Height = 14
      Caption = 'Infoma'#231#245'es no Gr'#225'fico'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object CB_Tipo: TComboBox
      Left = 2
      Top = 18
      Width = 230
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = CB_TipoChange
      Items.Strings = (
        'RELAT'#211'RIO DE VENDAS DI'#193'RIAS'
        'RESUMO DE VENDAS DA SEMANA'
        'RELATORIO DE RECEBIMENTOS'
        'RELATORIO DE CAIXA'
        'GRAFICO'
        'FECHAMENTO MENSAL'
        'VENDAS E RECEBIMENTOS DI'#193'RIOS')
    end
    object ChBx_Periodo: TCheckBox
      Left = 238
      Top = 4
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
      TabOrder = 1
      OnClick = ChBx_PeriodoClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 237
      Top = 18
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Data_Fim: TDateTimePicker
      Left = 332
      Top = 18
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object DBLCB_Vendedor: TDBLookupComboBox
      Left = 4
      Top = 58
      Width = 420
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'CLB_CODIGO'
      ListField = 'CLB_NOME'
      ParentFont = False
      TabOrder = 4
      TabStop = False
    end
    object ChBx_Formatacao: TCheckBox
      Left = 4
      Top = 205
      Width = 109
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Sem Formata'#231#227'o'
      TabOrder = 5
    end
    object Cb_Info_Grafico: TComboBox
      Left = 4
      Top = 97
      Width = 420
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = '1 - Sem Legenda - Descri'#231#227'o e Percentual'
      Items.Strings = (
        '1 - Sem Legenda - Descri'#231#227'o e Percentual'
        '2 - Com Legenda no Topo - Percentual'
        '3 - Com legenda no rodap'#233' - Sem valores'
        '4 - Sem Legenda - Descri'#231#227'o e Valor'
        '5 - Sem Legenda - Descri'#231#227'o'
        '6 - Com Legenda - Percentual'
        '7 - Com Legenda - Sem Valores')
    end
  end
  object MainMenu1: TMainMenu
    Left = 88
    Top = 152
    object arefas1: TMenuItem
      Caption = 'Tarefas'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes1Click
      end
    end
  end
end
