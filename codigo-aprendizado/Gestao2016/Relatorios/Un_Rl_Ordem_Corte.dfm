object Rl_Ordem_Corte: TRl_Ordem_Corte
  Left = 39
  Top = 159
  Caption = 'Or'#231'amento'
  ClientHeight = 514
  ClientWidth = 1134
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
    Top = -6
    Width = 1123
    Height = 794
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Itens
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'DETALHEVENDA'
      'QRSTRINGSBAND1')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
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
      Width = 1047
      Height = 78
      AlignToBottom = False
      BeforePrint = QRBand2BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        206.375000000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRMemo5: TQRMemo
        Left = 793
        Top = 56
        Width = 118
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333320000
          2098.145833333333000000
          148.166666666666700000
          312.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
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
      object Lb_Data: TQRLabel
        Left = 744
        Top = 4
        Width = 297
        Height = 17
        Size.Values = (
          44.979166666666670000
          1968.500000000000000000
          10.583333333333330000
          785.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Curitiba, 09 de Outubro de 2006'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Ordemcorte: TQRLabel
        Left = 0
        Top = -1
        Width = 633
        Height = 29
        Size.Values = (
          76.729166666666680000
          0.000000000000000000
          -2.645833333333333000
          1674.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Ordem de Produ'#231#227'o'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = 8
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 18
      end
      object QRMemo3: TQRMemo
        Left = 0
        Top = 56
        Width = 793
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333320000
          0.000000000000000000
          148.166666666666700000
          2098.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
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
      object QRMemo7: TQRMemo
        Left = 911
        Top = 56
        Width = 133
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333320000
          2410.354166666667000000
          148.166666666666700000
          351.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
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
      object QRLabel19: TQRLabel
        Left = 4
        Top = 59
        Width = 318
        Height = 16
        Size.Values = (
          42.333333333333330000
          10.583333333333330000
          156.104166666666700000
          841.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = ' Descri'#231#227'o do Produto'
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
      object QRLabel25: TQRLabel
        Left = 797
        Top = 59
        Width = 105
        Height = 17
        Size.Values = (
          44.979166666666670000
          2108.729166666667000000
          156.104166666666700000
          277.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'CONSUMO'
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
      object QRLabel27: TQRLabel
        Left = 916
        Top = 59
        Width = 121
        Height = 17
        Size.Values = (
          44.979166666666670000
          2423.583333333333000000
          156.104166666666700000
          320.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'SOMA'
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
      object QRLabel13: TQRLabel
        Left = 3020
        Top = 268
        Width = 29
        Height = 17
        Size.Values = (
          44.979166666666670000
          7990.416666666668000000
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
      object QRMemo15: TQRMemo
        Left = 0
        Top = 33
        Width = 1044
        Height = 23
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          60.854166666666680000
          0.000000000000000000
          87.312500000000000000
          2762.250000000000000000)
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
      object QRLabel1: TQRLabel
        Left = 2
        Top = 36
        Width = 55
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          95.250000000000000000
          145.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Cliente :'
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
      object Lb_Cli_Nome: TQRLabel
        Left = 58
        Top = 36
        Width = 465
        Height = 17
        Size.Values = (
          44.979166666666670000
          153.458333333333300000
          95.250000000000000000
          1230.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Nome'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Cli_Fantasia: TQRLabel
        Left = 602
        Top = 36
        Width = 438
        Height = 17
        Size.Values = (
          44.979166666666670000
          1592.791666666667000000
          95.250000000000000000
          1158.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Nome'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel7: TQRLabel
        Left = 531
        Top = 36
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          1404.937500000000000000
          95.250000000000000000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'FANTASIA:'
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
    end
    object DetalheVenda: TQRStringsBand
      Left = 38
      Top = 215
      Width = 1047
      Height = 57
      AlignToBottom = False
      BeforePrint = DetalheVendaBeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        150.812500000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      Items.Strings = (
        '1')
      PrintBefore = False
      object QRMemo1: TQRMemo
        Left = 0
        Top = 0
        Width = 436
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          0.000000000000000000
          0.000000000000000000
          1153.583333333333000000)
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
      object QRMemo8: TQRMemo
        Left = 793
        Top = 0
        Width = 118
        Height = 57
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          150.812500000000000000
          2098.145833333333000000
          0.000000000000000000
          312.208333333333300000)
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
      object QRMemo10: TQRMemo
        Left = 911
        Top = 0
        Width = 133
        Height = 57
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          150.812500000000000000
          2410.354166666667000000
          0.000000000000000000
          351.895833333333300000)
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
      object Lb_Produto: TQRLabel
        Left = 7
        Top = 1
        Width = 403
        Height = 16
        Size.Values = (
          42.333333333333330000
          18.520833333333330000
          2.645833333333333000
          1066.270833333333000000)
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
      object Lb_Consumo: TQRLabel
        Left = 798
        Top = 16
        Width = 105
        Height = 25
        Size.Values = (
          66.145833333333320000
          2111.375000000000000000
          42.333333333333330000
          277.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 16
      end
      object Lb_Quantidade: TQRLabel
        Left = 917
        Top = 18
        Width = 118
        Height = 25
        Size.Values = (
          66.145833333333320000
          2426.229166666667000000
          47.625000000000000000
          312.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 16
      end
      object QRMemo2: TQRMemo
        Left = 0
        Top = 19
        Width = 436
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          0.000000000000000000
          50.270833333333330000
          1153.583333333333000000)
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
      object QRMemo4: TQRMemo
        Left = 0
        Top = 38
        Width = 436
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          0.000000000000000000
          100.541666666666700000
          1153.583333333333000000)
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
      object Lb_Tecido: TQRLabel
        Left = 6
        Top = 21
        Width = 403
        Height = 16
        Size.Values = (
          42.333333333333330000
          15.875000000000000000
          55.562500000000000000
          1066.270833333333000000)
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
      object Lb_Cor: TQRLabel
        Left = 6
        Top = 39
        Width = 403
        Height = 16
        Size.Values = (
          42.333333333333330000
          15.875000000000000000
          103.187500000000000000
          1066.270833333333000000)
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
      object QRMemo12: TQRMemo
        Left = 436
        Top = 19
        Width = 51
        Height = 38
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          100.541666666666700000
          1153.583333333333000000
          50.270833333333330000
          134.937500000000000000)
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
      object QRMemo13: TQRMemo
        Left = 487
        Top = 19
        Width = 51
        Height = 38
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          100.541666666666700000
          1288.520833333333000000
          50.270833333333330000
          134.937500000000000000)
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
      object QRMemo14: TQRMemo
        Left = 538
        Top = 19
        Width = 51
        Height = 38
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          100.541666666666700000
          1423.458333333333000000
          50.270833333333330000
          134.937500000000000000)
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
      object QRMemo16: TQRMemo
        Left = 589
        Top = 19
        Width = 51
        Height = 38
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          100.541666666666700000
          1558.395833333333000000
          50.270833333333330000
          134.937500000000000000)
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
      object QRMemo17: TQRMemo
        Left = 640
        Top = 19
        Width = 51
        Height = 38
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          100.541666666666700000
          1693.333333333333000000
          50.270833333333330000
          134.937500000000000000)
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
      object QRMemo18: TQRMemo
        Left = 691
        Top = 19
        Width = 51
        Height = 38
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          100.541666666666700000
          1828.270833333333000000
          50.270833333333330000
          134.937500000000000000)
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
      object QRMemo19: TQRMemo
        Left = 742
        Top = 19
        Width = 51
        Height = 38
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          100.541666666666700000
          1963.208333333333000000
          50.270833333333330000
          134.937500000000000000)
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
      object QRMemo20: TQRMemo
        Left = 436
        Top = 0
        Width = 51
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1153.583333333333000000
          0.000000000000000000
          134.937500000000000000)
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
      object QRMemo21: TQRMemo
        Left = 487
        Top = 0
        Width = 51
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1288.520833333333000000
          0.000000000000000000
          134.937500000000000000)
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
      object QRMemo22: TQRMemo
        Left = 538
        Top = 0
        Width = 51
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1423.458333333333000000
          0.000000000000000000
          134.937500000000000000)
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
      object QRMemo23: TQRMemo
        Left = 589
        Top = 0
        Width = 51
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1558.395833333333000000
          0.000000000000000000
          134.937500000000000000)
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
      object QRMemo24: TQRMemo
        Left = 640
        Top = 0
        Width = 51
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1693.333333333333000000
          0.000000000000000000
          134.937500000000000000)
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
      object QRMemo25: TQRMemo
        Left = 691
        Top = 0
        Width = 51
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1828.270833333333000000
          0.000000000000000000
          134.937500000000000000)
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
      object QRMemo26: TQRMemo
        Left = 742
        Top = 0
        Width = 51
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1963.208333333333000000
          0.000000000000000000
          134.937500000000000000)
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
      object Lb_T01: TQRLabel
        Left = 439
        Top = 1
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333330000
          1161.520833333333000000
          2.645833333333333000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_T02: TQRLabel
        Left = 490
        Top = 1
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333330000
          1296.458333333333000000
          2.645833333333333000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_T03: TQRLabel
        Left = 543
        Top = 1
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333330000
          1436.687500000000000000
          2.645833333333333000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_T04: TQRLabel
        Left = 592
        Top = 1
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333330000
          1566.333333333333000000
          2.645833333333333000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_T05: TQRLabel
        Left = 643
        Top = 1
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333330000
          1701.270833333333000000
          2.645833333333333000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_T06: TQRLabel
        Left = 696
        Top = 1
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333330000
          1841.500000000000000000
          2.645833333333333000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_T07: TQRLabel
        Left = 746
        Top = 1
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333330000
          1973.791666666667000000
          2.645833333333333000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_QT07: TQRLabel
        Left = 746
        Top = 33
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666660000
          1973.791666666667000000
          87.312500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_QT06: TQRLabel
        Left = 696
        Top = 33
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666660000
          1841.500000000000000000
          87.312500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_QT05: TQRLabel
        Left = 643
        Top = 33
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666660000
          1701.270833333333000000
          87.312500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_QT04: TQRLabel
        Left = 592
        Top = 33
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666660000
          1566.333333333333000000
          87.312500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_QT03: TQRLabel
        Left = 543
        Top = 33
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666660000
          1436.687500000000000000
          87.312500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_QT02: TQRLabel
        Left = 490
        Top = 33
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666660000
          1296.458333333333000000
          87.312500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object Lb_QT01: TQRLabel
        Left = 439
        Top = 33
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666660000
          1161.520833333333000000
          87.312500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
    end
    object Bnd_Sumario: TQRBand
      Left = 38
      Top = 272
      Width = 1047
      Height = 138
      AlignToBottom = False
      BeforePrint = Bnd_SumarioBeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        365.125000000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRMemo11: TQRMemo
        Left = 0
        Top = -1
        Width = 1044
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          0.000000000000000000
          -2.645833333333333000
          2762.250000000000000000)
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
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel8: TQRLabel
        Left = 796
        Top = 4
        Width = 110
        Height = 20
        Size.Values = (
          52.916666666666670000
          2106.083333333333000000
          10.583333333333330000
          291.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'QTDE TOTAL:'
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
      object Lb_Qt_Geral: TQRLabel
        Left = 936
        Top = 4
        Width = 100
        Height = 20
        Size.Values = (
          52.916666666666660000
          2476.500000000000000000
          10.583333333333330000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
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
      object Lb_Obs: TQRMemo
        Left = 6
        Top = 43
        Width = 1035
        Height = 81
        Size.Values = (
          214.312500000000000000
          15.875000000000000000
          113.770833333333300000
          2738.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 5
        Top = 26
        Width = 333
        Height = 16
        Size.Values = (
          42.333333333333330000
          13.229166666666670000
          68.791666666666680000
          881.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Observa'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRLabel2: TQRLabel
        Left = 4
        Top = 2
        Width = 119
        Height = 16
        Size.Values = (
          42.333333333333330000
          10.583333333333330000
          5.291666666666667000
          314.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PRAZO DE ENTREGA'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_PrazoEntrega: TQRLabel
        Left = 127
        Top = 2
        Width = 271
        Height = 16
        Size.Values = (
          42.333333333333330000
          336.020833333333300000
          5.291666666666667000
          717.020833333333200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'prazo de entrega'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Img_Frente: TQRImage
        Left = 8
        Top = 80
        Width = 20
        Height = 20
        Size.Values = (
          52.916666666666670000
          21.166666666666670000
          211.666666666666700000
          52.916666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Visible = False
      end
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 99
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        261.937500000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
    end
  end
  object E_obsOrcamento: TMemo
    Left = 40
    Top = 8
    Width = 1033
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    Visible = False
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  ICT_CODIGO,'
      '  ICT_CODCTC,'
      '  ICT_CODPED,'
      '  ICT_CODVCL,'
      '  ICT_DESCRICAO,'
      '  ICT_TECIDO,'
      '  ICT_COR,'
      '  ICT_QTDE,'
      '  ICT_VL_CUSTO,'
      '  ICT_VL_UNIT,'
      '  ICT_MR_LUCRO,'
      '  (ICT_QTDE * ICT_VL_UNIT) AS ICT_VL_SUBTOTAL'
      'FROM TB_ITENS_CTC'
      'WHERE (ICT_CODCTC=:CTC_CODIGO)'
      'ORDER BY ICT_CODIGO'
      '')
    Left = 273
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Ordem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CTC_CODIGO, CTC_CODPED, PED_CODIGO,PED_NUMERO,'
      
        'CTC_NUMERO, CTC_DATA, EMP_NOME, EMP_FANTASIA, EMP_CODIGO, END_EN' +
        'DER, END_CEP, END_FONE,'
      
        ' END_BAIRRO, END_CELULAR, END_CIDADE,END_ESTADO,END_FAX,EMP_CNPJ' +
        ', EMP_NUMINSC, EMP_EMAIL,'
      
        ' CTC_QT_PRODUTO, CTC_VL_FRETE, CTC_VL_DESCONTO, CTC_VL_COTACAO, ' +
        ' CTC_PRAZO, CTC_OBS, CTC_PRZ_ENTREGA,CTC_OBS_CORTE'
      'FROM  TB_COTACAO tb_cotacao'
      '   LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_cotacao.CTC_CODPED)'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP)'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'WHERE (CTC_CODPED=:CTC_CODPED)')
    Left = 384
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODPED'
        ParamType = ptUnknown
      end>
  end
  object Qr_Tamanho: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_GRADETAMANHO'
      'WHERE (GRT_CODICT=:GRT_CODICT)')
    Left = 424
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GRT_CODICT'
        ParamType = ptUnknown
      end>
  end
  object Qr_Imagem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_IMG_PRODUTO'
      'WHERE IMG_CODPRO=:IMG_CODPRO')
    Left = 176
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IMG_CODPRO'
        ParamType = ptUnknown
      end>
  end
end
