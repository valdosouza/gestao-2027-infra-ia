object RL_PedidoCompra_1: TRL_PedidoCompra_1
  Left = 1
  Top = 163
  Caption = 'Pedido de Compra'
  ClientHeight = 473
  ClientWidth = 842
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 0
    Top = 4
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Ordem
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'BD_DETALHESTR')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      70.000000000000000000
      2970.000000000000000000
      70.000000000000000000
      2100.000000000000000000
      75.000000000000000000
      70.000000000000000000
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
    ReportTitle = 'Pedido de Compra'
    ShowProgress = False
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
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object Cabecalho: TQRGroup
      Left = 28
      Top = 26
      Width = 739
      Height = 137
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        362.479166666666700000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Ordem.OVS_VIA'
      FooterBand = Rodape
      Master = Qrpt
      ReprintOnNewPage = False
      object QRShape6: TQRShape
        Left = 56
        Top = 114
        Width = 387
        Height = 23
        Frame.Color = clBtnHighlight
        Frame.Style = psClear
        Size.Values = (
          60.854166666666680000
          148.166666666666700000
          301.625000000000000000
          1023.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 0
        Top = 114
        Width = 57
        Height = 23
        Size.Values = (
          60.854166666666680000
          0.000000000000000000
          301.625000000000000000
          150.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 573
        Top = 114
        Width = 76
        Height = 23
        Size.Values = (
          60.854166666666680000
          1516.062500000000000000
          301.625000000000000000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 648
        Top = 114
        Width = 90
        Height = 23
        Size.Values = (
          60.854166666666680000
          1714.500000000000000000
          301.625000000000000000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape1: TQRShape
        Left = 516
        Top = 114
        Width = 58
        Height = 23
        Size.Values = (
          60.854166666666680000
          1365.250000000000000000
          301.625000000000000000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel18: TQRLabel
        Left = 652
        Top = 117
        Width = 82
        Height = 17
        Size.Values = (
          44.979166666666670000
          1725.083333333334000000
          309.562500000000000000
          216.958333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel19: TQRLabel
        Left = 576
        Top = 117
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          1524.000000000000000000
          309.562500000000000000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'V. Unit'#225'rio'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel20: TQRLabel
        Left = 519
        Top = 117
        Width = 51
        Height = 17
        Size.Values = (
          44.979166666666670000
          1373.187500000000000000
          309.562500000000000000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel16: TQRLabel
        Left = 63
        Top = 117
        Width = 369
        Height = 17
        Size.Values = (
          44.979166666666700000
          166.687500000000000000
          309.562500000000000000
          976.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Produto'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel15: TQRLabel
        Left = 5
        Top = 117
        Width = 48
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          309.562500000000000000
          127.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'C'#243'digo'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel3: TQRLabel
        Left = -1
        Top = 28
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          -2.645833333333333000
          74.083333333333330000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Fornecedor:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel4: TQRLabel
        Left = 8
        Top = 44
        Width = 69
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          116.416666666666700000
          182.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Endere'#231'o :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel5: TQRLabel
        Left = 29
        Top = 60
        Width = 48
        Height = 17
        Size.Values = (
          44.979166666666670000
          76.729166666666670000
          158.750000000000000000
          127.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Bairro :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel6: TQRLabel
        Left = 22
        Top = 76
        Width = 55
        Height = 17
        Size.Values = (
          44.979166666666670000
          58.208333333333330000
          201.083333333333300000
          145.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'C.N.P.J :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Endereco: TQRLabel
        Left = 80
        Top = 44
        Width = 345
        Height = 17
        Size.Values = (
          44.979166666666700000
          211.666666666667000000
          116.416666666667000000
          912.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Endereco'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Nome: TQRLabel
        Left = 80
        Top = 28
        Width = 325
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          74.083333333333340000
          859.895833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Nome'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_bairro: TQRLabel
        Left = 80
        Top = 60
        Width = 329
        Height = 17
        Size.Values = (
          44.979166666666700000
          211.666666666667000000
          158.750000000000000000
          870.479166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_bairro'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Cnpj: TQRLabel
        Left = 80
        Top = 76
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          201.083333333333300000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_Cnpj'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Codigo: TQRLabel
        Left = 465
        Top = 28
        Width = 84
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          74.083333333333330000
          222.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_Codigo'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_cep: TQRLabel
        Left = 465
        Top = 44
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          116.416666666666700000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_cep'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Cidade: TQRLabel
        Left = 465
        Top = 60
        Width = 102
        Height = 17
        Size.Values = (
          44.979166666666700000
          1230.312500000000000000
          158.750000000000000000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Cidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_IncEst: TQRLabel
        Left = 465
        Top = 76
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          201.083333333333300000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_IncEst'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
        Left = 407
        Top = 28
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          1076.854166666667000000
          74.083333333333330000
          142.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'C'#243'digo :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel8: TQRLabel
        Left = 426
        Top = 44
        Width = 35
        Height = 17
        Size.Values = (
          44.979166666666670000
          1127.125000000000000000
          116.416666666666700000
          92.604166666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'CEP :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel9: TQRLabel
        Left = 406
        Top = 60
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          1074.208333333333000000
          158.750000000000000000
          142.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Cidade :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel10: TQRLabel
        Left = 364
        Top = 76
        Width = 96
        Height = 17
        Size.Values = (
          44.979166666666670000
          963.083333333333300000
          201.083333333333300000
          254.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Insc. Estadual :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel12: TQRLabel
        Left = 578
        Top = 44
        Width = 37
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          116.416666666666700000
          97.895833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Fone:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_FoneC: TQRLabel
        Left = 616
        Top = 43
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          113.770833333333000000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '(41) 99999-9999'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel13: TQRLabel
        Left = 578
        Top = 60
        Width = 29
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          158.750000000000000000
          76.729166666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Fax:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Fax: TQRLabel
        Left = 616
        Top = 59
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          156.104166666667000000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Fax'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel34: TQRLabel
        Left = 578
        Top = 76
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          201.083333333333300000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cel:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Celular: TQRLabel
        Left = 616
        Top = 75
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          198.437500000000000000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Celular'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel36: TQRLabel
        Left = 32
        Top = 93
        Width = 45
        Height = 17
        Size.Values = (
          44.979166666666670000
          84.666666666666670000
          246.062500000000000000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'e-mail:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Cli_Email: TQRLabel
        Left = 80
        Top = 93
        Width = 77
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          246.062500000000000000
          203.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_Email'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel33: TQRLabel
        Left = 0
        Top = 2
        Width = 82
        Height = 23
        Size.Values = (
          60.854166666666680000
          0.000000000000000000
          5.291666666666667000
          216.958333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Compra:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 14
      end
      object Lb_Cli_Pedido: TQRLabel
        Left = 87
        Top = 2
        Width = 138
        Height = 23
        Size.Values = (
          60.854166666666680000
          230.187500000000000000
          5.291666666666667000
          365.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_CodigoPedido'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 14
      end
      object Lb_Cli_Data: TQRLabel
        Left = 465
        Top = 12
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          31.750000000000000000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Data'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel38: TQRLabel
        Left = 427
        Top = 12
        Width = 34
        Height = 17
        Size.Values = (
          44.979166666666670000
          1129.770833333333000000
          31.750000000000000000
          89.958333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Data:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRShape12: TQRShape
        Left = 442
        Top = 114
        Width = 75
        Height = 23
        Size.Values = (
          60.854166666666680000
          1169.458333333333000000
          301.625000000000000000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel11: TQRLabel
        Left = 455
        Top = 117
        Width = 51
        Height = 17
        Size.Values = (
          44.979166666666670000
          1203.854166666667000000
          309.562500000000000000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Local'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object Rodape: TQRBand
      Left = 28
      Top = 185
      Width = 739
      Height = 116
      Frame.DrawTop = True
      Frame.Style = psDot
      AlignToBottom = False
      BeforePrint = RodapeBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        306.916666666666700000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object Lb_NItens: TQRLabel
        Left = 616
        Top = 26
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          68.791666666666680000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_QItens: TQRLabel
        Left = 616
        Top = 42
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          111.125000000000000000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Desconto: TQRLabel
        Left = 616
        Top = 74
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          195.791666666666700000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel25: TQRLabel
        Left = 503
        Top = 26
        Width = 109
        Height = 17
        Size.Values = (
          44.979166666666670000
          1330.854166666667000000
          68.791666666666670000
          288.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'N'#250'mero de Itens:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel26: TQRLabel
        Left = 478
        Top = 42
        Width = 133
        Height = 17
        Size.Values = (
          44.979166666666670000
          1264.708333333333000000
          111.125000000000000000
          351.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Quantidade de Itens:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel27: TQRLabel
        Left = 548
        Top = 74
        Width = 63
        Height = 17
        Size.Values = (
          44.979166666666670000
          1449.916666666667000000
          195.791666666666700000
          166.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Desconto:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel28: TQRLabel
        Left = 556
        Top = 89
        Width = 55
        Height = 23
        Size.Values = (
          60.854166666666670000
          1471.083333333333000000
          235.479166666666700000
          145.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Total:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 14
      end
      object Lb_Total: TQRLabel
        Left = 616
        Top = 89
        Width = 117
        Height = 23
        Size.Values = (
          60.854166666666680000
          1629.833333333333000000
          235.479166666666700000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 14
      end
      object QRLabel31: TQRLabel
        Left = 6
        Top = 8
        Width = 168
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          21.166666666666670000
          444.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Condi'#231#245'es de Pagamento:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_TipoCob: TQRLabel
        Left = 176
        Top = 8
        Width = 556
        Height = 17
        Size.Values = (
          44.979166666666670000
          465.666666666666800000
          21.166666666666670000
          1471.083333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_TipoCob'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel1: TQRLabel
        Left = 577
        Top = 58
        Width = 34
        Height = 17
        Size.Values = (
          44.979166666666670000
          1526.645833333333000000
          153.458333333333300000
          89.958333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Frete'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Frete: TQRLabel
        Left = 616
        Top = 58
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          153.458333333333300000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel2: TQRLabel
        Left = 6
        Top = 25
        Width = 82
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          66.145833333333330000
          216.958333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Observa'#231#245'es'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRDBText1: TQRDBText
        Left = 7
        Top = 44
        Width = 450
        Height = 65
        Size.Values = (
          171.979166666666700000
          18.520833333333330000
          116.416666666666700000
          1190.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Ordem
        DataField = 'PED_OBS'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object Bd_DetalheStr: TQRStringsBand
      Left = 28
      Top = 163
      Width = 739
      Height = 22
      AlignToBottom = False
      BeforePrint = Bd_DetalheStrBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10')
      PrintBefore = False
      object QRShape11: TQRShape
        Left = 442
        Top = -1
        Width = 75
        Height = 23
        Size.Values = (
          60.854166666666680000
          1169.458333333333000000
          -2.645833333333333000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape4: TQRShape
        Left = 56
        Top = -1
        Width = 387
        Height = 23
        Frame.Color = clBtnHighlight
        Frame.Style = psClear
        Size.Values = (
          60.854166666666680000
          148.166666666666700000
          -2.645833333333333000
          1023.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Style = bsClear
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape9: TQRShape
        Left = 648
        Top = -1
        Width = 90
        Height = 23
        Size.Values = (
          60.854166666666680000
          1714.500000000000000000
          -2.645833333333333000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 573
        Top = -1
        Width = 76
        Height = 23
        Size.Values = (
          60.854166666666680000
          1516.062500000000000000
          -2.645833333333333000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape7: TQRShape
        Left = 516
        Top = -1
        Width = 58
        Height = 23
        Size.Values = (
          60.854166666666680000
          1365.250000000000000000
          -2.645833333333333000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 0
        Top = -1
        Width = 57
        Height = 23
        Size.Values = (
          60.854166666666680000
          0.000000000000000000
          -2.645833333333333000
          150.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object Lb_Codigo: TQRLabel
        Left = 5
        Top = 1
        Width = 48
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          2.645833333333333000
          127.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Item'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_DescricaoProduto: TQRLabel
        Left = 63
        Top = 1
        Width = 369
        Height = 17
        Size.Values = (
          44.979166666666670000
          166.687500000000000000
          2.645833333333333000
          976.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'C'#243'digo / Descri'#231#227'o do Produto'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Qtde: TQRLabel
        Left = 520
        Top = 1
        Width = 50
        Height = 17
        Size.Values = (
          44.979166666666670000
          1375.833333333333000000
          2.645833333333333000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Quantidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_VlUnit: TQRLabel
        Left = 577
        Top = 1
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          1526.645833333333000000
          2.645833333333333000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'V. Unit'#225'rio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_SubTotal: TQRLabel
        Left = 656
        Top = 1
        Width = 77
        Height = 17
        Size.Values = (
          44.979166666666670000
          1735.666666666667000000
          2.645833333333333000
          203.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Local: TQRLabel
        Left = 446
        Top = 1
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          1180.041666666667000000
          2.645833333333333000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Local'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
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
      'SELECT '
      
        'PED_NUMERO, PED_DATA, EMP_NOME, EMP_CODIGO, END_ENDER, END_CEP, ' +
        'END_FONE,  END_BAIRRO, END_CELULAR, CDD_DESCRICAO ,END_FAX,EMP_C' +
        'NPJ, EMP_INSC_EST, EMP_EMAIL,  PED_QT_PRODUTO, PED_VL_FRETE, PED' +
        '_VL_DESCONTO, PED_VL_PEDIDO, FPT_DESCRICAO, PED_PRAZO, ped_obs,P' +
        'ED_DT_ALTERA, PED_CODMHA, END_NUMERO'
      'FROM  TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (PED_CODIGO=:PED_CODIGO) ')
    Left = 384
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    AfterOpen = Qr_ItensAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '   ITF_CODIGO, '
      '   ITF_CODPED,'
      '   ITF_CODPRO, '
      '  PRO_CODIGOFAB,'
      '   ITF_QTDE,  '
      '   ITF_VL_UNIT,'
      '   PRO_CODIGOFOR,'
      '   ITF_QTDE * ITF_VL_UNIT as ITF_VL_LINHA,'
      '   PRO_DESCRICAO, PRO_LOCAL'
      'FROM  TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      'WHERE ITF_CODPED =:ITF_CODPED '
      'ORDER BY ITF_CODIGO'
      '  ')
    Left = 304
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODPED'
        ParamType = ptUnknown
      end>
  end
end
