object RL_PedidoVenda_10: TRL_PedidoVenda_10
  Left = 336
  Top = 26
  Caption = 'Pedido'
  ClientHeight = 708
  ClientWidth = 828
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Pedido
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'BD_DETALHESTR'
      'STRB_SERVICO'
      'STRB_PRODUTO')
    Functions.DATA = (
      '0'
      '0'
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
    ReportTitle = 'Relat'#243'rio de Servi'#231'o'
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
      Top = 159
      Width = 739
      Height = 116
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        306.916666666666700000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Ordem.OVS_VIA'
      FooterBand = Rodape
      Master = Qrpt
      ReprintOnNewPage = False
      object QRShape20: TQRShape
        Left = 2
        Top = 4
        Width = 735
        Height = 114
        Size.Values = (
          301.625000000000000000
          5.291666666666667000
          10.583333333333330000
          1944.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel3: TQRLabel
        Left = 23
        Top = 32
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          60.854166666666670000
          84.666666666666670000
          142.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Cliente :'
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
        Top = 48
        Width = 69
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          127.000000000000000000
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
        Top = 80
        Width = 48
        Height = 17
        Size.Values = (
          44.979166666666670000
          76.729166666666670000
          211.666666666666700000
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
      object Lb_CNPJ: TQRLabel
        Left = 26
        Top = 96
        Width = 51
        Height = 17
        Size.Values = (
          44.979166666666670000
          68.791666666666670000
          254.000000000000000000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'C.N.P.J:'
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
        Top = 48
        Width = 345
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          127.000000000000000000
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
        Top = 32
        Width = 324
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          84.666666666666680000
          857.250000000000000000)
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
        Top = 80
        Width = 329
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          211.666666666666700000
          870.479166666666800000)
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
        Top = 96
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          254.000000000000000000
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
        Top = 32
        Width = 84
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          84.666666666666670000
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
        Top = 48
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          127.000000000000000000
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
        Top = 80
        Width = 102
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          211.666666666666700000
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
        Top = 96
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          254.000000000000000000
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
        Top = 32
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          1076.854166666667000000
          84.666666666666670000
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
        Top = 48
        Width = 35
        Height = 17
        Size.Values = (
          44.979166666666670000
          1127.125000000000000000
          127.000000000000000000
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
        Top = 80
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          1074.208333333333000000
          211.666666666666700000
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
      object Lb_Ie: TQRLabel
        Left = 364
        Top = 96
        Width = 96
        Height = 17
        Size.Values = (
          44.979166666666670000
          963.083333333333300000
          254.000000000000000000
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
        Top = 48
        Width = 38
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          127.000000000000000000
          100.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Coml:'
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
        Top = 47
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          124.354166666666700000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_FoneC'
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
        Top = 64
        Width = 29
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          169.333333333333300000
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
        Top = 63
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          166.687500000000000000
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
      object QRLabel34: TQRLabel
        Left = 578
        Top = 80
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          211.666666666666700000
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
        Top = 79
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          209.020833333333300000
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
      object Lb_Titulo: TQRLabel
        Left = 8
        Top = 9
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          23.812500000000000000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PEDIDO N'#186
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
      object Lb_Cli_Pedido: TQRLabel
        Left = 82
        Top = 9
        Width = 142
        Height = 17
        Size.Values = (
          44.979166666666670000
          216.958333333333300000
          23.812500000000000000
          375.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_CodigoPedido'
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
      object Lb_Cli_Data: TQRLabel
        Left = 586
        Top = 9
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          1550.458333333333000000
          23.812500000000000000
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
        Left = 548
        Top = 9
        Width = 34
        Height = 17
        Size.Values = (
          44.979166666666670000
          1449.916666666667000000
          23.812500000000000000
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
      object QRLabel10: TQRLabel
        Left = 11
        Top = 64
        Width = 66
        Height = 17
        Size.Values = (
          44.979166666666670000
          29.104166666666670000
          169.333333333333300000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Complem.'
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
      object Lb_Cli_Complemento: TQRLabel
        Left = 80
        Top = 64
        Width = 329
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          169.333333333333300000
          870.479166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Complemento'
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
      object QRLabel14: TQRLabel
        Left = 410
        Top = 64
        Width = 50
        Height = 17
        Size.Values = (
          44.979166666666670000
          1084.791666666667000000
          169.333333333333300000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Contato'
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
      object Lb_Cli_Contato: TQRLabel
        Left = 465
        Top = 64
        Width = 102
        Height = 17
        Size.Values = (
          44.979166666666670000
          1230.312500000000000000
          169.333333333333300000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Contato'
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
    end
    object Rodape: TQRBand
      Left = 28
      Top = 320
      Width = 739
      Height = 173
      Frame.Style = psDot
      AlignToBottom = False
      BeforePrint = RodapeBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        457.729166666666700000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRLabel21: TQRLabel
        Left = 135
        Top = 9
        Width = 99
        Height = 17
        Size.Values = (
          44.979166666666670000
          357.187500000000000000
          23.812500000000000000
          261.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_Vendedor'
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
      object Shp_Rodape: TQRShape
        Left = 2
        Top = 4
        Width = 735
        Height = 165
        Size.Values = (
          436.562500000000000000
          5.291666666666667000
          10.583333333333330000
          1944.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object Lb_Vl_Servico: TQRLabel
        Left = 616
        Top = 24
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          63.500000000000000000
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
      object Lb_Vl_Pecas: TQRLabel
        Left = 616
        Top = 40
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          105.833333333333300000
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
      object Lb_Vl_Desconto: TQRLabel
        Left = 616
        Top = 88
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          232.833333333333300000
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
        Left = 520
        Top = 24
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1375.833333333333000000
          63.500000000000000000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Servi'#231'o:'
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
        Left = 520
        Top = 40
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1375.833333333333000000
          105.833333333333300000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Pe'#231'as:'
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
        Left = 520
        Top = 88
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1375.833333333333000000
          232.833333333333300000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 520
        Top = 103
        Width = 93
        Height = 23
        Size.Values = (
          60.854166666666670000
          1375.833333333333000000
          272.520833333333300000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total Geral:'
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
      object Lb_Vl_Total: TQRLabel
        Left = 616
        Top = 103
        Width = 117
        Height = 23
        Size.Values = (
          60.854166666666670000
          1629.833333333333000000
          272.520833333333300000
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
        Top = 6
        Width = 168
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          15.875000000000000000
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
        Top = 6
        Width = 556
        Height = 17
        Size.Values = (
          44.979166666666670000
          465.666666666666700000
          15.875000000000000000
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
        Left = 520
        Top = 72
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1375.833333333333000000
          190.500000000000000000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal:'
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
      object Lb_Vl_SubTotal: TQRLabel
        Left = 616
        Top = 72
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          190.500000000000000000
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
      object E_Assinatura: TQRLabel
        Left = 293
        Top = 146
        Width = 398
        Height = 17
        Frame.DrawTop = True
        Size.Values = (
          44.979166666666670000
          775.229166666666700000
          386.291666666666700000
          1053.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Assinatura'
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
      object Lb_LocalData: TQRLabel
        Left = 13
        Top = 146
        Width = 256
        Height = 17
        Size.Values = (
          44.979166666666670000
          34.395833333333330000
          386.291666666666700000
          677.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_LocalData'
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
      object Lb_Vendedor: TQRLabel
        Left = 5
        Top = 95
        Width = 67
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          251.354166666666700000
          177.270833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Vendedor:'
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
      object E_Vendedor: TQRLabel
        Left = 77
        Top = 95
        Width = 411
        Height = 17
        Size.Values = (
          44.979166666666670000
          203.729166666666700000
          251.354166666666700000
          1087.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'NNome do Vendedor'
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
      object QRLabel6: TQRLabel
        Left = 6
        Top = 23
        Width = 82
        Height = 18
        Size.Values = (
          47.625000000000000000
          15.875000000000000000
          60.854166666666670000
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
      object E_Obs: TQRMemo
        Left = 6
        Top = 41
        Width = 491
        Height = 51
        Size.Values = (
          134.937500000000000000
          15.875000000000000000
          108.479166666666700000
          1299.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRLabel2: TQRLabel
        Left = 520
        Top = 56
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1375.833333333333000000
          148.166666666666700000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Frete:'
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
      object Lb_Vl_Frete: TQRLabel
        Left = 616
        Top = 56
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          148.166666666666700000
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
    end
    object StrB_Servico: TQRStringsBand
      Left = 28
      Top = 275
      Width = 739
      Height = 22
      AlignToBottom = False
      BeforePrint = StrB_ServicoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      PrintBefore = False
      object QRShape6: TQRShape
        Left = 90
        Top = 1
        Width = 527
        Height = 23
        Frame.Color = clBtnHighlight
        Frame.Style = psClear
        Size.Values = (
          60.854166666666680000
          238.125000000000000000
          2.645833333333333000
          1394.354166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Style = bsClear
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 2
        Top = 1
        Width = 89
        Height = 23
        Size.Values = (
          60.854166666666680000
          5.291666666666667000
          2.645833333333333000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 617
        Top = 1
        Width = 120
        Height = 23
        Size.Values = (
          60.854166666666680000
          1632.479166666667000000
          2.645833333333333000
          317.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object Lb_SubVl_Srv: TQRLabel
        Left = 623
        Top = 4
        Width = 106
        Height = 17
        Size.Values = (
          44.979166666666670000
          1648.354166666667000000
          10.583333333333330000
          280.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
        Color = clWhite
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
      object Lb_Descricao_Srv: TQRLabel
        Left = 95
        Top = 4
        Width = 365
        Height = 17
        Size.Values = (
          44.979166666666670000
          251.354166666666700000
          10.583333333333330000
          965.729166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Servi'#231'os'
        Color = clWhite
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
      object Lb_Cd_Servico: TQRLabel
        Left = 5
        Top = 4
        Width = 82
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          10.583333333333330000
          216.958333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'C'#243'digo'
        Color = clWhite
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
    object StrB_Produto: TQRStringsBand
      Left = 28
      Top = 297
      Width = 739
      Height = 23
      AlignToBottom = False
      BeforePrint = StrB_ProdutoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        60.854166666666670000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      PrintBefore = False
      object QRShape15: TQRShape
        Left = 90
        Top = 1
        Width = 383
        Height = 23
        Frame.Color = clBtnHighlight
        Frame.Style = psClear
        Size.Values = (
          60.854166666666680000
          238.125000000000000000
          2.645833333333333000
          1013.354166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Style = bsClear
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 2
        Top = 1
        Width = 89
        Height = 23
        Size.Values = (
          60.854166666666680000
          5.291666666666667000
          2.645833333333333000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape7: TQRShape
        Left = 526
        Top = 1
        Width = 92
        Height = 23
        Size.Values = (
          60.854166666666680000
          1391.708333333333000000
          2.645833333333333000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape9: TQRShape
        Left = 617
        Top = 1
        Width = 120
        Height = 23
        Size.Values = (
          60.854166666666680000
          1632.479166666667000000
          2.645833333333333000
          317.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 472
        Top = 1
        Width = 55
        Height = 23
        Size.Values = (
          60.854166666666680000
          1248.833333333333000000
          2.645833333333333000
          145.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object Lb_SubVl_Pro: TQRLabel
        Left = 623
        Top = 4
        Width = 107
        Height = 17
        Size.Values = (
          44.979166666666670000
          1648.354166666667000000
          10.583333333333330000
          283.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
        Color = clWhite
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
      object Lb_VlUnit_Pro: TQRLabel
        Left = 535
        Top = 4
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          1415.520833333333000000
          10.583333333333330000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'V. Unit'#225'rio'
        Color = clWhite
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
      object Lb_Qtde_Pro: TQRLabel
        Left = 481
        Top = 4
        Width = 42
        Height = 17
        Size.Values = (
          44.979166666666670000
          1272.645833333333000000
          10.583333333333330000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
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
      object Lb_Codigo_Pro: TQRLabel
        Left = 5
        Top = 4
        Width = 82
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          10.583333333333330000
          216.958333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Cd. Produto'
        Color = clWhite
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
      object Lb_Descricao_Pro: TQRLabel
        Left = 93
        Top = 4
        Width = 369
        Height = 17
        Size.Values = (
          44.979166666666670000
          246.062500000000000000
          10.583333333333330000
          976.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Produto'
        Color = clWhite
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
    object bnd_cabecalho: TQRBand
      Left = 28
      Top = 26
      Width = 739
      Height = 133
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        351.895833333333300000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
    end
  end
  object Qr_ItensSrv: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  PRO_CODIGO,'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_DESCRICAO,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '  (ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      'WHERE (ITF_CODPED =:ITF_CODPED) AND (PRO_TIPO = '#39'S'#39')'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    Left = 649
    Top = 544
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODPED'
        ParamType = ptUnknown
      end>
  end
  object Qr_ItensPro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '  PRO_CODIGOFOR,'
      '  (ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      'WHERE (ITF_CODPED =:ITF_CODPED) AND (PRO_TIPO = '#39'P'#39')'
      'ORDER BY PRO_DESCRICAO')
    Left = 577
    Top = 552
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODPED'
        ParamType = ptUnknown
      end>
    object Qr_ItensProITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensProITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensProITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
      Required = True
    end
    object Qr_ItensProITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensProPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensProPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensProITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensProITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensProITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensProITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensProMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensProPRO_CODIGOFOR: TStringField
      FieldName = 'PRO_CODIGOFOR'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFOR"'
      Size = 50
    end
    object Qr_ItensProITF_VL_SUBTOTAL: TFMTBCDField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_SUBTOTAL'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 9
      Calculated = True
    end
  end
  object Qr_Pedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'EMP_NOME,'
      'PED_CODEMP,'
      'EMP_CODIGO,'
      'PED_CODIGO,'
      'END_ENDER,'
      'END_NUMERO,'
      'END_COMPLEM,'
      'END_CONTATO,'
      'END_CEP,'
      'END_FONE,'
      'END_BAIRRO,'
      'CDD_DESCRICAO,'
      'END_FAX,'
      'EMP_CNPJ,'
      'EMP_INSC_EST,'
      'END_CELULAR,'
      'FPT_DESCRICAO,'
      'PED_PRAZO,'
      'PED_VL_PEDIDO,'
      'PED_OBS,'
      'CLB_NOME,'
      'PED_NUMERO,'
      'PED_FATURADO,'
      'PED_DATA,'
      'PED_DT_ALTERA,'
      'PED_VL_FRETE,'
      'UFE_SIGLA ,'
      'PED_VL_DESCONTO'
      ''
      'FROM TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      '  INNER JOIN tb_cidade tb_cidade'
      '  ON (tb_cidade.cdd_codigo = tb_endereco.end_codcdd)'
      '  INNER JOIN tb_uf tb_uf'
      '  ON (tb_uf.ufe_codigo = tb_endereco.end_codufe)'
      ''
      '  INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '  ON (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG)'
      '  LEFT OUTER JOIN TB_COLABORADOR tb_colaborador'
      '  ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)'
      '  LEFT OUTER JOIN TB_COTACAO tb_cotacao'
      '  ON (tb_cotacao.CTC_CODPED = tb_pedido.PED_CODIGO)'
      '   WHERE(PED_CODIGO =:PED_CODIGO)')
    Left = 512
    Top = 552
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
