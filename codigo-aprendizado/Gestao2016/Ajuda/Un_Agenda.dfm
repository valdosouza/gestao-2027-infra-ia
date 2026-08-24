object Fr_Agenda: TFr_Agenda
  Left = 297
  Top = 47
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Agenda de Compromissos Gerais'
  ClientHeight = 610
  ClientWidth = 847
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Calendar: TPanel
    Left = 231
    Top = 0
    Width = 616
    Height = 610
    Align = alClient
    Caption = 'Pnl_Calendar'
    TabOrder = 0
    object Pg_Agenda: TPageControl
      Left = 1
      Top = 1
      Width = 614
      Height = 544
      ActivePage = TabSheet1
      Align = alClient
      MultiLine = True
      TabOrder = 0
      TabPosition = tpRight
      object TabSheet1: TTabSheet
        Caption = '               Di'#225'rios               '
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 586
          Height = 303
          Align = alTop
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 0
          object Label1: TLabel
            Left = 0
            Top = 0
            Width = 582
            Height = 42
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 600
          end
          object Lb_Hoje: TLabel
            Left = 9
            Top = 5
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Lb_Compr_hoje: TLabel
            Left = 10
            Top = 19
            Width = 93
            Height = 13
            Caption = '(1) Compromisso'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_hoje: TStringGrid
            Left = 0
            Top = 42
            Width = 582
            Height = 257
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            TabOrder = 0
            OnDblClick = StrGrd_hojeDblClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 303
          Width = 586
          Height = 233
          Align = alClient
          BevelInner = bvSpace
          BevelOuter = bvSpace
          BorderStyle = bsSingle
          TabOrder = 1
          object Label6: TLabel
            Left = 2
            Top = 2
            Width = 578
            Height = 42
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 601
          end
          object Lb_Compr_Amanha: TLabel
            Left = 9
            Top = 21
            Width = 93
            Height = 13
            Caption = '(1) Compromisso'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Lb_amanha: TLabel
            Left = 8
            Top = 7
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_Amanha: TStringGrid
            Left = 2
            Top = 44
            Width = 578
            Height = 183
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            TabOrder = 0
            OnDblClick = StrGrd_AmanhaDblClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = '               Semanais               '
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 304
          Height = 175
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 0
          object Label7: TLabel
            Left = 0
            Top = 0
            Width = 300
            Height = 22
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Lb_SG: TLabel
            Left = 5
            Top = 3
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_SG: TStringGrid
            Left = 0
            Top = 22
            Width = 300
            Height = 149
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ScrollBars = ssNone
            TabOrder = 0
            OnDblClick = StrGrd_SGDblClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
        object Panel5: TPanel
          Left = 0
          Top = 352
          Width = 304
          Height = 175
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 1
          object Label9: TLabel
            Left = 0
            Top = 0
            Width = 300
            Height = 22
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Lb_SX: TLabel
            Left = 5
            Top = 3
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_SX: TStringGrid
            Left = 0
            Top = 22
            Width = 300
            Height = 149
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ScrollBars = ssNone
            TabOrder = 0
            OnClick = StrGrd_SXClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 177
          Width = 304
          Height = 175
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 2
          object Label11: TLabel
            Left = 0
            Top = 0
            Width = 300
            Height = 22
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Lb_QR: TLabel
            Left = 5
            Top = 3
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_QR: TStringGrid
            Left = 0
            Top = 22
            Width = 300
            Height = 149
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ScrollBars = ssNone
            TabOrder = 0
            OnClick = StrGrd_QRClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
        object Panel7: TPanel
          Left = 304
          Top = 352
          Width = 304
          Height = 89
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 3
          object Label13: TLabel
            Left = 0
            Top = 0
            Width = 300
            Height = 22
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Lb_SB: TLabel
            Left = 5
            Top = 3
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_SB: TStringGrid
            Left = 0
            Top = 22
            Width = 300
            Height = 63
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ScrollBars = ssNone
            TabOrder = 0
            OnClick = StrGrd_SBClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
        object Panel8: TPanel
          Left = 304
          Top = 0
          Width = 304
          Height = 175
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 4
          object Label15: TLabel
            Left = 0
            Top = 0
            Width = 300
            Height = 22
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Lb_TC: TLabel
            Left = 5
            Top = 3
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_TC: TStringGrid
            Left = 0
            Top = 22
            Width = 300
            Height = 149
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ScrollBars = ssNone
            TabOrder = 0
            OnDblClick = StrGrd_TCDblClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
        object Panel9: TPanel
          Left = 304
          Top = 177
          Width = 304
          Height = 175
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 5
          object Label17: TLabel
            Left = 0
            Top = 0
            Width = 300
            Height = 22
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Lb_QT: TLabel
            Left = 5
            Top = 3
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_QT: TStringGrid
            Left = 0
            Top = 22
            Width = 300
            Height = 149
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ScrollBars = ssNone
            TabOrder = 0
            OnClick = StrGrd_QTClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
        object Panel10: TPanel
          Left = 304
          Top = 443
          Width = 304
          Height = 84
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 6
          object Label19: TLabel
            Left = 0
            Top = 0
            Width = 300
            Height = 22
            Align = alTop
            AutoSize = False
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object Lb_DM: TLabel
            Left = 5
            Top = 3
            Width = 176
            Height = 13
            Caption = 'S'#225'bado, 12 de janeiro de 2008'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object StrGrd_DM: TStringGrid
            Left = 0
            Top = 22
            Width = 300
            Height = 58
            Align = alClient
            Color = clCream
            ColCount = 9
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ScrollBars = ssNone
            TabOrder = 0
            OnClick = StrGrd_DMClick
            ColWidths = (
              40
              40
              40
              40
              40
              40
              40
              40
              40)
            RowHeights = (
              18
              18)
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = '       Pesquisa       '
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label22: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 64
          Width = 580
          Height = 14
          Align = alTop
          Caption = 'Resultado da pesquisa :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 116
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 580
          Height = 55
          Align = alTop
          Caption = ' Digite sua op'#231#227'o de busca '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label5: TLabel
            Left = 165
            Top = 12
            Width = 132
            Height = 14
            Caption = 'Descri'#231#227'o do Compromisso'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 443
            Top = 12
            Width = 70
            Height = 14
            Caption = 'Para o usu'#225'rio'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 88
            Top = 12
            Width = 47
            Height = 14
            Caption = 'Data Final'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 7
            Top = 12
            Width = 51
            Height = 14
            Caption = 'Data Inicial'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Compromisso: TMaskEdit
            Left = 164
            Top = 26
            Width = 275
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = ''
          end
          object E_Usuario: TMaskEdit
            Left = 442
            Top = 26
            Width = 158
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object E_Data_Fim: TDateTimePicker
            Left = 83
            Top = 26
            Width = 80
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            TabOrder = 1
          end
          object E_Data_Ini: TDateTimePicker
            Left = 4
            Top = 26
            Width = 78
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            TabOrder = 0
          end
        end
        object StrGrd_Pesquisa: TStringGrid
          AlignWithMargins = True
          Left = 3
          Top = 84
          Width = 580
          Height = 385
          Align = alClient
          Color = clCream
          ColCount = 9
          DefaultColWidth = 40
          DefaultRowHeight = 18
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goRowSelect]
          TabOrder = 1
          OnDblClick = StrGrd_PesquisaDblClick
          ColWidths = (
            40
            40
            40
            40
            40
            40
            40
            40
            40)
          RowHeights = (
            18
            18)
        end
        object pnl_Pesquisa_Bottom: TPanel
          Left = 0
          Top = 472
          Width = 586
          Height = 64
          Align = alBottom
          TabOrder = 2
          object SB_Visualizar: TSpeedButton
            AlignWithMargins = True
            Left = 392
            Top = 4
            Width = 92
            Height = 56
            Align = alRight
            Caption = 'Visualizar - F8'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_VisualizarClick
            ExplicitLeft = 510
            ExplicitTop = 472
            ExplicitHeight = 54
          end
          object SB_Buscar: TSpeedButton
            AlignWithMargins = True
            Left = 490
            Top = 4
            Width = 92
            Height = 56
            Align = alRight
            Caption = 'Buscar - F7'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_BuscarClick
            ExplicitLeft = 772
            ExplicitTop = -15
            ExplicitHeight = 62
          end
        end
      end
    end
    object pnl_calendar_Bottom: TPanel
      Left = 1
      Top = 545
      Width = 614
      Height = 64
      Align = alBottom
      TabOrder = 1
      object Sb_Sair_0: TSpeedButton
        AlignWithMargins = True
        Left = 518
        Top = 4
        Width = 92
        Height = 56
        Align = alRight
        Caption = 'Sair- Esc'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Sair_0Click
        ExplicitLeft = 704
        ExplicitTop = 543
        ExplicitHeight = 54
      end
      object SB_Inserir: TSpeedButton
        AlignWithMargins = True
        Left = 420
        Top = 4
        Width = 92
        Height = 56
        Align = alRight
        Caption = 'Agendar - F2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_InserirClick
        ExplicitLeft = 612
        ExplicitTop = 543
        ExplicitHeight = 54
      end
    end
  end
  object Mcd_Principal: TMonthCalendar
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 225
    Height = 604
    Align = alLeft
    AutoSize = True
    CalColors.TitleBackColor = clInfoText
    CalColors.TitleTextColor = clRed
    CalColors.MonthBackColor = clWindow
    Date = 39115.777814594910000000
    FirstDayOfWeek = dowMonday
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ShowToday = False
    TabOrder = 1
    OnClick = Mcd_PrincipalClick
  end
  object Qr_Agenda: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_AGENDA'
      'WHERE AGD_DIA=:AGD_DIA'
      'ORDER BY AGD_HORA')
    Left = 404
    Top = 174
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AGD_DIA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 500
    Top = 198
  end
end
