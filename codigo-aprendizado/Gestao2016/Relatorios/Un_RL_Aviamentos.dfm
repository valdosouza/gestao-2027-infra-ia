object RL_Aviamentos: TRL_Aviamentos
  Left = 222
  Top = 145
  Caption = 'Aviamentos e Tecidos'
  ClientHeight = 531
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 6
    Top = 2
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'STRBND_CBC_AVIAMENTO'
      'STRBND_CBC_MAOOBRA'
      'STRBND_MAOOBRA'
      'QRSTRINGSBAND1'
      'STRBND_AVIAMENTOS'
      'STRBND_DESPVENDA')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39
      #39#39
      #39#39
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
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
    PrintIfEmpty = True
    ReportTitle = 'valdo'
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsMaximized
    PreviewWidth = 500
    PreviewHeight = 500
    PrevShowThumbs = False
    PrevShowSearch = False
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stPDF
    PreviewLeft = 0
    PreviewTop = 0
    object QRBand2: TQRBand
      Left = 38
      Top = 137
      Width = 718
      Height = 97
      AlignToBottom = False
      BeforePrint = QRBand2BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        256.645833333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRMemo69: TQRMemo
        Left = 0
        Top = 1
        Width = 717
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333320000
          0.000000000000000000
          2.645833333333333000
          1897.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel13: TQRLabel
        Left = 3022
        Top = 268
        Width = 29
        Height = 17
        Size.Values = (
          44.979166666666670000
          7995.708333333332000000
          709.083333333333200000
          76.729166666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Fax:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel63: TQRLabel
        Left = 4
        Top = 2
        Width = 708
        Height = 20
        Size.Values = (
          52.916666666666670000
          10.583333333333330000
          5.291666666666667000
          1873.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'AVIAMENTOS E TECIDOS'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object QRMemo70: TQRMemo
        Left = 436
        Top = 71
        Width = 90
        Height = 26
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          68.791666666666680000
          1153.583333333333000000
          187.854166666666700000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo72: TQRMemo
        Left = 526
        Top = 71
        Width = 89
        Height = 26
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          68.791666666666680000
          1391.708333333333000000
          187.854166666666700000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo75: TQRMemo
        Left = 615
        Top = 71
        Width = 102
        Height = 26
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          68.791666666666680000
          1627.187500000000000000
          187.854166666666700000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel64: TQRLabel
        Left = 440
        Top = 78
        Width = 79
        Height = 13
        Size.Values = (
          34.395833333333330000
          1164.166666666667000000
          206.375000000000000000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Unidade Padr'#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRMemo77: TQRMemo
        Left = 45
        Top = 71
        Width = 391
        Height = 26
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          68.791666666666680000
          119.062500000000000000
          187.854166666666700000
          1034.520833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo78: TQRMemo
        Left = 0
        Top = 71
        Width = 45
        Height = 26
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          68.791666666666680000
          0.000000000000000000
          187.854166666666700000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel78: TQRLabel
        Left = 6
        Top = 75
        Width = 28
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          198.437500000000000000
          74.083333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Itens'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRLabel79: TQRLabel
        Left = 48
        Top = 75
        Width = 305
        Height = 17
        Size.Values = (
          44.979166666666670000
          127.000000000000000000
          198.437500000000000000
          806.979166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRLabel1: TQRLabel
        Left = 528
        Top = 78
        Width = 79
        Height = 13
        Size.Values = (
          34.395833333333330000
          1397.000000000000000000
          206.375000000000000000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Quant. Unit'#225'ria'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel2: TQRLabel
        Left = 624
        Top = 78
        Width = 79
        Height = 13
        Size.Values = (
          34.395833333333330000
          1651.000000000000000000
          206.375000000000000000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Consumo Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel3: TQRLabel
        Left = 4
        Top = 42
        Width = 71
        Height = 20
        Size.Values = (
          52.916666666666670000
          10.583333333333330000
          111.125000000000000000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Produto: '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Descricao: TQRLabel
        Left = 78
        Top = 42
        Width = 635
        Height = 20
        Size.Values = (
          52.916666666666670000
          206.375000000000000000
          111.125000000000000000
          1680.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Produto'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 99
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        261.937500000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
    end
    object StrBnd_Aviamentos: TQRStringsBand
      Left = 38
      Top = 234
      Width = 718
      Height = 19
      AlignToBottom = False
      BeforePrint = StrBnd_AviamentosBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        50.270833333333330000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      PrintBefore = False
      object QRMemo29: TQRMemo
        Left = 436
        Top = 0
        Width = 90
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1153.583333333333000000
          0.000000000000000000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo31: TQRMemo
        Left = 526
        Top = 0
        Width = 89
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1391.708333333333000000
          0.000000000000000000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo34: TQRMemo
        Left = 615
        Top = 0
        Width = 102
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1627.187500000000000000
          0.000000000000000000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object Lb_Avi_Unid: TQRLabel
        Left = 443
        Top = 1
        Width = 74
        Height = 15
        Size.Values = (
          39.687500000000000000
          1172.104166666667000000
          2.645833333333333000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Padr'#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRMemo36: TQRMemo
        Left = 45
        Top = 0
        Width = 391
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          119.062500000000000000
          0.000000000000000000
          1034.520833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo37: TQRMemo
        Left = 0
        Top = 0
        Width = 45
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          0.000000000000000000
          0.000000000000000000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object Lb_Avi_Con_Unit: TQRLabel
        Left = 530
        Top = 1
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          1402.291666666667000000
          2.645833333333333000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Unit'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object Lb_Avi_Cons_Total: TQRLabel
        Left = 620
        Top = 1
        Width = 89
        Height = 15
        Size.Values = (
          39.687500000000000000
          1640.416666666667000000
          2.645833333333333000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object Lb_Avi_Item: TQRLabel
        Left = 6
        Top = 1
        Width = 24
        Height = 15
        Size.Values = (
          39.687500000000000000
          15.875000000000000000
          2.645833333333333000
          63.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Itens'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object Lb_Avi_Descricao: TQRLabel
        Left = 48
        Top = 1
        Width = 305
        Height = 15
        Size.Values = (
          39.687500000000000000
          127.000000000000000000
          2.645833333333333000
          806.979166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    object QRBand3: TQRBand
      Left = 38
      Top = 253
      Width = 718
      Height = 30
      AlignToBottom = False
      BeforePrint = QRBand3BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        79.375000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRMemo45: TQRMemo
        Left = 615
        Top = 1
        Width = 102
        Height = 26
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          68.791666666666680000
          1627.187500000000000000
          2.645833333333333000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo47: TQRMemo
        Left = 0
        Top = 1
        Width = 615
        Height = 26
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          68.791666666666680000
          0.000000000000000000
          2.645833333333333000
          1627.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel37: TQRLabel
        Left = 5
        Top = 4
        Width = 188
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          10.583333333333330000
          497.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'TOTAL - AVIAMENTOS E TECIDOS'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Tl_Av_Vl_Total: TQRLabel
        Left = 622
        Top = 5
        Width = 88
        Height = 17
        Size.Values = (
          44.979166666666670000
          1645.708333333333000000
          13.229166666666670000
          232.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
  end
  object Qr_Aviamentos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  FTC_CODIGO,'
      '  FTC_CODICT,'
      '  FTC_CODITF,'
      '  FTC_TIPO,'
      '  FTC_CODVCL,'
      '  FTC_DESC_INSUMO,'
      '  FTC_UND,'
      '  FTC_VL_UNIT,'
      '  FTC_CS_UNIT'
      'FROM TB_FICHA_TECNICA'
      'where FTC_TIPO = '#39'A'#39' AND FTC_CODICT=:FTC_CODICT')
    Left = 156
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FTC_CODICT'
        ParamType = ptUnknown
      end>
    object Qr_AviamentosFTC_CODIGO: TIntegerField
      FieldName = 'FTC_CODIGO'
      Origin = 'TB_FICHA_TECNICA.FTC_CODIGO'
      Required = True
    end
    object Qr_AviamentosFTC_CODICT: TIntegerField
      FieldName = 'FTC_CODICT'
      Origin = 'TB_FICHA_TECNICA.FTC_CODICT'
    end
    object Qr_AviamentosFTC_CODITF: TIntegerField
      FieldName = 'FTC_CODITF'
      Origin = 'TB_FICHA_TECNICA.FTC_CODITF'
    end
    object Qr_AviamentosFTC_TIPO: TStringField
      FieldName = 'FTC_TIPO'
      Origin = 'TB_FICHA_TECNICA.FTC_TIPO'
      FixedChar = True
      Size = 1
    end
    object Qr_AviamentosFTC_CODVCL: TIntegerField
      FieldName = 'FTC_CODVCL'
      Origin = 'TB_FICHA_TECNICA.FTC_CODVCL'
    end
    object Qr_AviamentosFTC_DESC_INSUMO: TStringField
      FieldName = 'FTC_DESC_INSUMO'
      Origin = 'TB_FICHA_TECNICA.FTC_DESC_INSUMO'
      Size = 100
    end
    object Qr_AviamentosFTC_UND: TStringField
      FieldName = 'FTC_UND'
      Origin = 'TB_FICHA_TECNICA.FTC_UND'
      Size = 3
    end
    object Qr_AviamentosFTC_VL_UNIT: TFloatField
      FieldName = 'FTC_VL_UNIT'
      Origin = 'TB_FICHA_TECNICA.FTC_VL_UNIT'
    end
    object Qr_AviamentosFTC_CS_UNIT: TFloatField
      FieldName = 'FTC_CS_UNIT'
      Origin = 'TB_FICHA_TECNICA.FTC_CS_UNIT'
    end
  end
  object Qr_Ordem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CTC_CODIGO,'
      
        'CTC_NUMERO, CTC_DATA, EMP_NOME, EMP_FANTASIA, EMP_CODIGO, END_EN' +
        'DER, END_CEP, END_FONE,  END_BAIRRO, END_CELULAR,'
      
        'CDD_DESCRICAO,ufe_SIGLA,END_FAX,EMP_CNPJ, EMP_INSC_EST, EMP_EMAI' +
        'L,'
      'CTC_QT_PRODUTO, CTC_VL_FRETE, CTC_VL_DESCONTO, CTC_VL_COTACAO,'
      'CTC_PRAZO, CTC_OBS, CTC_PRZ_ENTREGA'
      'FROM  TB_COTACAO tb_cotacao'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP)'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      ' INNER JOIN tb_cidade tb_cidade'
      '   ON (tb_cidade.cdd_codigo = tb_endereco.end_codcdd)'
      ' INNER JOIN tb_uf tb_uf'
      '   ON (tb_uf.ufe_codigo = tb_endereco.end_codufe)'
      'WHERE (CTC_CODIGO=:CTC_CODIGO) ')
    Left = 384
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_OrdemCTC_CODIGO: TIntegerField
      FieldName = 'CTC_CODIGO'
      Origin = 'TB_COTACAO.CTC_CODIGO'
      Required = True
    end
    object Qr_OrdemCTC_NUMERO: TStringField
      FieldName = 'CTC_NUMERO'
      Origin = 'TB_COTACAO.CTC_NUMERO'
    end
    object Qr_OrdemCTC_DATA: TDateField
      FieldName = 'CTC_DATA'
      Origin = 'TB_COTACAO.CTC_DATA'
      Required = True
    end
    object Qr_OrdemEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_OrdemEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'TB_EMPRESA.EMP_FANTASIA'
      Size = 100
    end
    object Qr_OrdemEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_OrdemEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_OrdemEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_OrdemEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = 'TB_ENDERECO.END_FONE'
      Size = 14
    end
    object Qr_OrdemEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 25
    end
    object Qr_OrdemEND_CELULAR: TStringField
      FieldName = 'END_CELULAR'
      Origin = 'TB_ENDERECO.END_CELULAR'
      Size = 14
    end
    object Qr_OrdemEND_FAX: TStringField
      FieldName = 'END_FAX'
      Origin = 'TB_ENDERECO.END_FAX'
      Size = 14
    end
    object Qr_OrdemEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = 'TB_EMPRESA.EMP_CNPJ'
      Required = True
      Size = 14
    end
    object Qr_OrdemCTC_QT_PRODUTO: TBCDField
      FieldName = 'CTC_QT_PRODUTO'
      Origin = 'TB_COTACAO.CTC_QT_PRODUTO'
      Precision = 18
      Size = 2
    end
    object Qr_OrdemCTC_VL_FRETE: TBCDField
      FieldName = 'CTC_VL_FRETE'
      Origin = 'TB_COTACAO.CTC_VL_FRETE'
      Precision = 18
      Size = 2
    end
    object Qr_OrdemCTC_VL_DESCONTO: TBCDField
      FieldName = 'CTC_VL_DESCONTO'
      Origin = 'TB_COTACAO.CTC_VL_DESCONTO'
      Precision = 18
      Size = 2
    end
    object Qr_OrdemCTC_VL_COTACAO: TBCDField
      FieldName = 'CTC_VL_COTACAO'
      Origin = 'TB_COTACAO.CTC_VL_COTACAO'
      Precision = 18
      Size = 2
    end
    object Qr_OrdemCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_OrdemUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_OrdemCTC_PRAZO: TStringField
      FieldName = 'CTC_PRAZO'
      Origin = 'TB_COTACAO.CTC_PRAZO'
      Size = 100
    end
    object Qr_OrdemCTC_PRZ_ENTREGA: TStringField
      FieldName = 'CTC_PRZ_ENTREGA'
      Origin = 'TB_COTACAO.CTC_PRZ_ENTREGA'
      Size = 30
    end
    object Qr_OrdemCTC_OBS: TBlobField
      FieldName = 'CTC_OBS'
      Origin = 'TB_COTACAO.CTC_OBS'
      Size = 8
    end
    object Qr_OrdemEMP_INSC_EST: TStringField
      FieldName = 'EMP_INSC_EST'
      Origin = 'TB_EMPRESA.EMP_INSC_EST'
      Size = 30
    end
    object Qr_OrdemEMP_EMAIL: TStringField
      FieldName = 'EMP_EMAIL'
      Origin = 'TB_EMPRESA.EMP_EMAIL'
      Size = 40
    end
  end
end
