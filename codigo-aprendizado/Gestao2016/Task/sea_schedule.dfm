inherited SeaSchedule: TSeaSchedule
  BorderIcons = [biSystemMenu]
  Caption = 'Pesquisa Agenda'
  ClientHeight = 586
  ClientWidth = 1015
  ExplicitWidth = 1021
  ExplicitHeight = 635
  PixelsPerInch = 96
  TextHeight = 13
  object Mcd_Principal: TMonthCalendar [0]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 225
    Height = 580
    Align = alLeft
    AutoSize = True
    CalColors.TitleBackColor = clInfoText
    CalColors.TitleTextColor = clRed
    CalColors.MonthBackColor = clWindow
    Date = 39115.693527245370000000
    FirstDayOfWeek = dowMonday
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ShowToday = False
    TabOrder = 0
    OnClick = Mcd_PrincipalClick
  end
  object Pnl_Fundos: TPanel [1]
    Left = 231
    Top = 0
    Width = 784
    Height = 586
    Align = alClient
    Caption = 'Pnl_Fundos'
    TabOrder = 1
    object pg_main: TPageControl
      Left = 1
      Top = 49
      Width = 690
      Height = 536
      ActivePage = tbs_diaria
      Align = alClient
      TabOrder = 0
      object tbs_diaria: TTabSheet
        Caption = 'Agenda Individual'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object dbg_agenda: TDBGrid
          Left = 0
          Top = 0
          Width = 682
          Height = 508
          Align = alClient
          DataSource = ds_agenda
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'TM_RECORD'
              Title.Caption = 'Hor'#225'rio'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERVED'
              Title.Caption = 'Cliente'
              Width = 355
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PHONE'
              Title.Caption = 'Telefone'
              Width = 104
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SIT_DESCRICAO'
              Title.Caption = 'Situa'#231#227'o'
              Width = 122
              Visible = True
            end>
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Pesquisa Geral'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Pesquisa: TPanel
          Left = 0
          Top = 0
          Width = 682
          Height = 508
          Align = alClient
          TabOrder = 0
          object Lb_ResultadoPesquisa: TLabel
            Left = 0
            Top = 0
            Width = 3
            Height = 13
          end
          object DBG_Pesquisa: TDBGrid
            Left = 1
            Top = 49
            Width = 680
            Height = 458
            Align = alClient
            DataSource = ds_search
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'DT_RECORD'
                Title.Caption = 'Data'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TM_RECORD'
                Title.Caption = 'Hora'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DURATION'
                Title.Caption = 'Dura'#231#227'o'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SERVED'
                Title.Caption = 'Cliente'
                Width = 296
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PHONE'
                Title.Caption = 'Telefone'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CLB_NOME'
                Title.Caption = 'Atendente'
                Width = 202
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SIT_DESCRICAO'
                Title.Caption = 'Situa'#231#227'o'
                Width = 158
                Visible = True
              end>
          end
          object Panel1: TPanel
            Left = 1
            Top = 1
            Width = 680
            Height = 48
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Label42: TLabel
              Left = 179
              Top = 4
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 275
              Top = 2
              Width = 77
              Height = 14
              Caption = 'Nome do Cliente'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object ChBx_Periodo: TCheckBox
              Left = 6
              Top = 2
              Width = 128
              Height = 12
              Caption = 'Data Inicial    Data Final'
              Checked = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              State = cbChecked
              TabOrder = 0
            end
            object E_Data_Fim: TDateTimePicker
              Left = 90
              Top = 19
              Width = 82
              Height = 22
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              TabOrder = 1
            end
            object E_Data_Ini: TDateTimePicker
              Left = 5
              Top = 19
              Width = 79
              Height = 22
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              TabOrder = 2
            end
            object E_BuscaFone: TEdit_Setes
              Left = 177
              Top = 19
              Width = 93
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Text = ''
              IsFone = True
            end
            object E_Busca_Cliente: TEdit
              Left = 273
              Top = 19
              Width = 283
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
          end
        end
      end
    end
    object Pnl_Parametros: TPanel
      Left = 1
      Top = 1
      Width = 782
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      inline Fm_ListaAtendente: TFm_ListaColaboradores
        Left = 6
        Top = 5
        Width = 315
        Height = 36
        TabOrder = 0
        ExplicitLeft = 6
        ExplicitTop = 5
        ExplicitWidth = 315
        ExplicitHeight = 36
        inherited Label19: TLabel
          Width = 315
          Caption = 'Atendente'
          ExplicitWidth = 50
        end
        inherited Sb_Cadastro: TSpeedButton
          Left = 289
          Height = 19
          ExplicitLeft = 285
          ExplicitHeight = 17
        end
        inherited Dblcb_Vendedor: TDBLookupComboBox
          Width = 286
          ExplicitWidth = 286
        end
      end
    end
    object pnl_pesq_right: TPanel
      Left = 691
      Top = 49
      Width = 92
      Height = 536
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object Sb_Sair_0: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 473
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Fechar - ESC'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Sair_0Click
        ExplicitLeft = -8
        ExplicitTop = 321
        ExplicitWidth = 92
      end
      object SB_Visualizar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 410
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Visualizar - F8'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_VisualizarClick
        ExplicitLeft = 835
        ExplicitTop = 312
        ExplicitWidth = 92
      end
      object SB_Buscar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 347
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Buscar - F7'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_BuscarClick
        ExplicitLeft = 835
        ExplicitTop = 252
        ExplicitWidth = 92
      end
      object SB_Cadastrar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 284
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Cadastrar - F2'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_CadastrarClick
        ExplicitLeft = 835
        ExplicitTop = 192
        ExplicitWidth = 92
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 1024
    Top = 96
  end
  object DSP: TDataSetProvider
    DataSet = DM.Qr_Crud
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 40
    Top = 280
  end
  object cds_search: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    Left = 40
    Top = 322
  end
  object ds_search: TDataSource
    DataSet = cds_search
    Left = 40
    Top = 378
  end
  object cds_agenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 330
    object cds_agendaID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_SCHEDULE"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_agendaTM_RECORD: TWideStringField
      FieldName = 'TM_RECORD'
      Origin = '"TB_SCHEDULE"."TM_RECORD"'
      FixedChar = True
      Size = 5
    end
    object cds_agendaDURATION: TWideStringField
      FieldName = 'DURATION'
      Origin = '"TB_SCHEDULE"."DURATION"'
      FixedChar = True
      Size = 5
    end
    object cds_agendaPHONE: TWideStringField
      FieldName = 'PHONE'
      Origin = '"TB_SCHEDULE"."PHONE"'
      Required = True
    end
    object cds_agendaSERVED: TWideStringField
      FieldName = 'SERVED'
      Origin = '"TB_SCHEDULE"."SERVED"'
      Size = 100
    end
    object cds_agendaSIT_DESCRICAO: TWideStringField
      FieldName = 'SIT_DESCRICAO'
      Origin = '"TB_SITUACAO"."SIT_DESCRICAO"'
      Size = 100
    end
  end
  object ds_agenda: TDataSource
    DataSet = cds_agenda
    Left = 440
    Top = 410
  end
end
