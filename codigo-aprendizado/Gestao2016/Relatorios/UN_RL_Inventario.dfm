object RL_Inventario: TRL_Inventario
  Left = 189
  Top = 64
  Caption = 'Invent'#225'rio de Estoque'
  ClientHeight = 755
  ClientWidth = 1181
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 8
    Top = 8
    Width = 1123
    Height = 794
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Produtos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
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
    PrintIfEmpty = False
    ReportTitle = 'Invent'#225'rio de Estoque'
    ShowProgress = False
    SnapToGrid = True
    Units = Native
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
    object Bnd_Titulo: TQRBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 103
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        272.520833333333300000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRLabel1: TQRLabel
        Left = 0
        Top = 65
        Width = 1044
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          171.979166666666700000
          2762.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 
          '________________________________________________________________' +
          '________________________________________________________________' +
          '_____________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Titulo: TQRLabel
        Left = 0
        Top = 83
        Width = 257
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          219.604166666666700000
          679.979166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Invent'#225'rio do Estoque do Dia 01/01/0001'
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
    end
    object Bnd_Detalhe: TQRBand
      Left = 38
      Top = 231
      Width = 1047
      Height = 19
      AlignToBottom = False
      BeforePrint = Bnd_DetalheBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        50.270833333333330000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBText3: TQRDBText
        Left = 73
        Top = 1
        Width = 322
        Height = 15
        Size.Values = (
          39.687500000000000000
          193.145833333333300000
          2.645833333333333000
          851.958333333333200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_DESCRICAO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_CODPRODUTO: TQRDBText
        Left = 3
        Top = 1
        Width = 68
        Height = 15
        Size.Values = (
          39.687500000000000000
          7.937500000000000000
          2.645833333333333000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_CODIGO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_QT_ENT_CPA: TQRDBText
        Left = 402
        Top = 1
        Width = 49
        Height = 15
        Size.Values = (
          39.687500000000000000
          1063.625000000000000000
          2.645833333333333000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_QT_ENT_CPA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00##'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_VL_ENT_CPA: TQRDBText
        Left = 452
        Top = 1
        Width = 58
        Height = 15
        Size.Values = (
          39.687500000000000000
          1195.916666666667000000
          2.645833333333333000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_VL_ENT_CPA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_QT_ENT_OTR: TQRDBText
        Left = 517
        Top = 1
        Width = 45
        Height = 15
        Size.Values = (
          39.687500000000000000
          1367.895833333333000000
          2.645833333333333000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_QT_ENT_OTR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00##'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_VL_ENT_OTR: TQRDBText
        Left = 564
        Top = 1
        Width = 59
        Height = 15
        Size.Values = (
          39.687500000000000000
          1492.250000000000000000
          2.645833333333333000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_VL_ENT_OTR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_QT_SAI_VDA: TQRDBText
        Left = 630
        Top = 1
        Width = 46
        Height = 15
        Size.Values = (
          39.687500000000000000
          1666.875000000000000000
          2.645833333333333000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_QT_SAI_VDA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00##'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_VL_SAI_VDA: TQRDBText
        Left = 677
        Top = 1
        Width = 60
        Height = 15
        Size.Values = (
          39.687500000000000000
          1791.229166666667000000
          2.645833333333333000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_VL_SAI_VDA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_QT_SAI_OTR: TQRDBText
        Left = 743
        Top = 1
        Width = 46
        Height = 15
        Size.Values = (
          39.687500000000000000
          1965.854166666667000000
          2.645833333333333000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_QT_SAI_OTR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00##'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_VL_SAI_OTR: TQRDBText
        Left = 791
        Top = 1
        Width = 56
        Height = 15
        Size.Values = (
          39.687500000000000000
          2092.854166666667000000
          2.645833333333333000
          148.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_VL_SAI_OTR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_QT_ATUAL: TQRDBText
        Left = 854
        Top = 1
        Width = 47
        Height = 15
        Size.Values = (
          39.687500000000000000
          2259.541666666667000000
          2.645833333333333000
          124.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_QT_ATUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00##'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_VL_CUSTO: TQRDBText
        Left = 904
        Top = 1
        Width = 56
        Height = 15
        Size.Values = (
          39.687500000000000000
          2391.833333333333000000
          2.645833333333333000
          148.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_VL_CUSTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText4: TQRDBText
        Left = 966
        Top = 1
        Width = 76
        Height = 15
        Size.Values = (
          39.687500000000000000
          2555.875000000000000000
          2.645833333333333000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'IVT_SUBTOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Mask = '0.00'
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRShape7: TQRShape
        Left = 514
        Top = -1
        Width = 1
        Height = 21
        Size.Values = (
          55.562500000000000000
          1359.958333333333000000
          -2.645833333333333000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 627
        Top = -1
        Width = 1
        Height = 21
        Size.Values = (
          55.562500000000000000
          1658.937500000000000000
          -2.645833333333333000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 739
        Top = -1
        Width = 1
        Height = 21
        Size.Values = (
          55.562500000000000000
          1955.270833333333000000
          -2.645833333333333000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 850
        Top = -1
        Width = 1
        Height = 21
        Size.Values = (
          55.562500000000000000
          2248.958333333333000000
          -2.645833333333333000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 963
        Top = -1
        Width = 1
        Height = 21
        Size.Values = (
          55.562500000000000000
          2547.937500000000000000
          -2.645833333333333000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
    end
    object Bnd_Rodape: TQRBand
      Left = 38
      Top = 331
      Width = 1047
      Height = 28
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        74.083333333333330000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageFooter
      object QRSysData1: TQRSysData
        Left = -2
        Top = 7
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          -5.291666666666667000
          18.520833333333330000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDate
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
      object QRSysData2: TQRSysData
        Left = 667
        Top = 7
        Width = 46
        Height = 17
        Size.Values = (
          44.979166666666670000
          1764.770833333333000000
          18.520833333333330000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsPageNumber
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel18: TQRLabel
        Left = 85
        Top = 1
        Width = 59
        Height = 17
        Size.Values = (
          44.979166666666670000
          224.895833333333300000
          2.645833333333333000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagina N'#186
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel17: TQRLabel
        Left = 227
        Top = 7
        Width = 170
        Height = 17
        Size.Values = (
          44.979166666666670000
          600.604166666666700000
          18.520833333333330000
          449.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Numero Total de de Produtos'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRSysData3: TQRSysData
        Left = 153
        Top = 3
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          404.812500000000000000
          7.937500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDetailCount
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
    end
    object Bnd_Sumario: TQRBand
      Left = 38
      Top = 250
      Width = 1047
      Height = 81
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = Bnd_SumarioBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        214.312500000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = True
      KeepOnOnePage = True
      BandType = rbSummary
      object Label10: TQRLabel
        Left = 351
        Top = 24
        Width = 136
        Height = 17
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          63.500000000000000000
          359.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total das Vendas'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label1: TQRLabel
        Left = 7
        Top = 7
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          18.520833333333330000
          18.520833333333330000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade Total das Compras'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label2: TQRLabel
        Left = 7
        Top = 24
        Width = 144
        Height = 17
        Size.Values = (
          44.979166666666670000
          18.520833333333330000
          63.500000000000000000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total das Compras'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label3: TQRLabel
        Left = 7
        Top = 40
        Width = 216
        Height = 17
        Size.Values = (
          44.979166666666670000
          18.520833333333330000
          105.833333333333300000
          571.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade Total de Outras Entradas'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label4: TQRLabel
        Left = 7
        Top = 57
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          18.520833333333330000
          150.812500000000000000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total de Outras Entradas'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_QT_TL_ENT_CPA: TQRLabel
        Left = 229
        Top = 8
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          605.895833333333200000
          21.166666666666670000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VL_TL_ENT_CPA: TQRLabel
        Left = 229
        Top = 25
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          605.895833333333200000
          66.145833333333320000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_QT_TL_ENT_OTR: TQRLabel
        Left = 229
        Top = 41
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          605.895833333333200000
          108.479166666666700000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VL_TL_ENT_OTR: TQRLabel
        Left = 229
        Top = 58
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          605.895833333333200000
          153.458333333333300000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label9: TQRLabel
        Left = 351
        Top = 7
        Width = 172
        Height = 17
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          18.520833333333330000
          455.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade Total das Vendas'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label11: TQRLabel
        Left = 351
        Top = 40
        Width = 208
        Height = 17
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          105.833333333333300000
          550.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade Total de Outras  Saidas'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label12: TQRLabel
        Left = 351
        Top = 57
        Width = 168
        Height = 17
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          150.812500000000000000
          444.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total de Outras Saidas'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_QT_TL_SAI_VDA: TQRLabel
        Left = 573
        Top = 8
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1516.062500000000000000
          21.166666666666670000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VL_TL_SAI_VDA: TQRLabel
        Left = 573
        Top = 25
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1516.062500000000000000
          66.145833333333320000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_QT_TL_SAI_OTR: TQRLabel
        Left = 573
        Top = 41
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1516.062500000000000000
          108.479166666666700000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VL_TL_SAI_OTR: TQRLabel
        Left = 573
        Top = 58
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1516.062500000000000000
          153.458333333333300000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label17: TQRLabel
        Left = 705
        Top = 7
        Width = 207
        Height = 17
        Size.Values = (
          44.979166666666670000
          1865.312500000000000000
          18.520833333333330000
          547.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade Total  Atual no Estoque'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Label18: TQRLabel
        Left = 705
        Top = 24
        Width = 167
        Height = 17
        Size.Values = (
          44.979166666666670000
          1865.312500000000000000
          63.500000000000000000
          441.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total Atual no Estoque'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_QT_TL_SALDO: TQRLabel
        Left = 927
        Top = 8
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2452.687500000000000000
          21.166666666666670000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VL_TL_SALDO: TQRLabel
        Left = 927
        Top = 25
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2452.687500000000000000
          66.145833333333320000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object Bnd_parameter: TQRBand
      Left = 38
      Top = 359
      Width = 1047
      Height = 260
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        687.916666666666700000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel7: TQRLabel
        Left = 2
        Top = 2
        Width = 153
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          5.291666666666667000
          404.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Par'#226'metros de Consulta'
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
        Left = 2
        Top = 22
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          58.208333333333330000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tipo de Documento:'
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
      object QRLabel33: TQRLabel
        Left = 2
        Top = 38
        Width = 77
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          100.541666666666700000
          203.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data Inicial:'
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
      object QRLabel34: TQRLabel
        Left = 314
        Top = 38
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          830.791666666666700000
          100.541666666666700000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data Final:'
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
      object QRLabel35: TQRLabel
        Left = 2
        Top = 70
        Width = 110
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          185.208333333333300000
          291.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tabela de Pre'#231'o:'
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
      object QRLabel36: TQRLabel
        Left = 2
        Top = 55
        Width = 116
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          145.520833333333300000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome do Estoque:'
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
      object Lb_Tipo_Doc: TQRLabel
        Left = 133
        Top = 23
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          351.895833333333300000
          60.854166666666670000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
      object Lb_Estoque: TQRLabel
        Left = 122
        Top = 55
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          322.791666666666700000
          145.520833333333300000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
      object Lb_Data_Ini: TQRLabel
        Left = 81
        Top = 38
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          214.312500000000000000
          100.541666666666700000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '00/00/0000'
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
      object Lb_Tab_Preco: TQRLabel
        Left = 115
        Top = 72
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          304.270833333333300000
          190.500000000000000000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
      object QRLabel37: TQRLabel
        Left = 2
        Top = 152
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          402.166666666666700000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ordena'#231#227'o:'
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
      object Lb_Ordenacao: TQRLabel
        Left = 80
        Top = 153
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          404.812500000000000000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
        Left = 2
        Top = 167
        Width = 109
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          441.854166666666700000
          288.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Gerar Invent'#225'rio:'
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
      object Lb_Gerar_Invent: TQRLabel
        Left = 113
        Top = 167
        Width = 40
        Height = 17
        Size.Values = (
          44.979166666666670000
          298.979166666666700000
          441.854166666666700000
          105.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'branco'
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
      object QRLabel39: TQRLabel
        Left = 2
        Top = 72
        Width = 110
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          190.500000000000000000
          291.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tabela de Pre'#231'o:'
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
      object QRLabel40: TQRLabel
        Left = 2
        Top = 88
        Width = 105
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          232.833333333333300000
          277.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome do Grupo:'
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
      object Lb_Grupo: TQRLabel
        Left = 110
        Top = 88
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          291.041666666666700000
          232.833333333333300000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
      object QRLabel41: TQRLabel
        Left = 2
        Top = 104
        Width = 128
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          275.166666666666700000
          338.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome do Subgrupo:'
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
      object Lb_Subgrupo: TQRLabel
        Left = 132
        Top = 104
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          349.250000000000000000
          275.166666666666700000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
      object QRLabel42: TQRLabel
        Left = 2
        Top = 120
        Width = 105
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          317.500000000000000000
          277.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome da Marca:'
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
      object Lb_Marca: TQRLabel
        Left = 111
        Top = 120
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          293.687500000000000000
          317.500000000000000000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
      object QRLabel43: TQRLabel
        Left = 2
        Top = 136
        Width = 121
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          359.833333333333300000
          320.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome da Empresa:'
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
      object Lb_Empresa: TQRLabel
        Left = 125
        Top = 136
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          330.729166666666700000
          359.833333333333300000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Todos'
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
      object QRLabel45: TQRLabel
        Left = 1
        Top = 184
        Width = 106
        Height = 17
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          486.833333333333300000
          280.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Estoque M'#237'nimo:'
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
      object Lb_Estoq_Min: TQRLabel
        Left = 111
        Top = 184
        Width = 40
        Height = 17
        Size.Values = (
          44.979166666666670000
          293.687500000000000000
          486.833333333333300000
          105.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'branco'
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
      object QRLabel46: TQRLabel
        Left = 1
        Top = 200
        Width = 96
        Height = 17
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          529.166666666666700000
          254.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Saldo Positivo:'
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
      object Lb_Saldo_Positivo: TQRLabel
        Left = 100
        Top = 200
        Width = 40
        Height = 17
        Size.Values = (
          44.979166666666670000
          264.583333333333300000
          529.166666666666700000
          105.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'branco'
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
      object QRLabel47: TQRLabel
        Left = 1
        Top = 216
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          571.500000000000000000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Mostar Inativos:'
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
      object Lb_Inativos: TQRLabel
        Left = 102
        Top = 216
        Width = 40
        Height = 17
        Size.Values = (
          44.979166666666670000
          269.875000000000000000
          571.500000000000000000
          105.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'branco'
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
      object Lb_Data_Fim: TQRLabel
        Left = 386
        Top = 38
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          1021.291666666667000000
          100.541666666666700000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '00/00/0000'
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
    object grp_SubgRupo: TQRGroup
      Left = 38
      Top = 141
      Width = 1047
      Height = 90
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = Bnd_Detalhe
      Size.Values = (
        238.125000000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Produtos.SBG_DESCRICAO'
      Master = Qrpt
      ReprintOnNewPage = False
      object QRDBText2: TQRDBText
        Left = 64
        Top = 27
        Width = 983
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          169.333333333333300000
          71.437500000000000000
          2600.854166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'SBG_DESCRICAO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 3
        Top = 53
        Width = 41
        Height = 17
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          140.229166666666700000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'C'#243'digo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel3: TQRLabel
        Left = 74
        Top = 53
        Width = 323
        Height = 17
        Size.Values = (
          44.979166666666670000
          195.791666666666700000
          140.229166666666700000
          854.604166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Produto'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 402
        Top = 62
        Width = 49
        Height = 15
        Size.Values = (
          39.687500000000000000
          1063.625000000000000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel4: TQRLabel
        Left = 454
        Top = 62
        Width = 58
        Height = 15
        Size.Values = (
          39.687500000000000000
          1201.208333333333000000
          164.041666666666700000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel5: TQRLabel
        Left = 454
        Top = 62
        Width = 59
        Height = 15
        Size.Values = (
          39.687500000000000000
          1201.208333333333000000
          164.041666666666700000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel9: TQRLabel
        Left = 402
        Top = 62
        Width = 49
        Height = 15
        Size.Values = (
          39.687500000000000000
          1063.625000000000000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel10: TQRLabel
        Left = 402
        Top = 45
        Width = 111
        Height = 15
        Size.Values = (
          39.687500000000000000
          1063.625000000000000000
          119.062500000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Compra'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel11: TQRLabel
        Left = 515
        Top = 62
        Width = 49
        Height = 15
        Size.Values = (
          39.687500000000000000
          1362.604166666667000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel12: TQRLabel
        Left = 567
        Top = 62
        Width = 60
        Height = 15
        Size.Values = (
          39.687500000000000000
          1500.187500000000000000
          164.041666666666700000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel13: TQRLabel
        Left = 566
        Top = 62
        Width = 59
        Height = 15
        Size.Values = (
          39.687500000000000000
          1497.541666666667000000
          164.041666666666700000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel14: TQRLabel
        Left = 515
        Top = 62
        Width = 49
        Height = 15
        Size.Values = (
          39.687500000000000000
          1362.604166666667000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel15: TQRLabel
        Left = 515
        Top = 45
        Width = 111
        Height = 15
        Size.Values = (
          39.687500000000000000
          1362.604166666667000000
          119.062500000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Outras Entradas'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel16: TQRLabel
        Left = 627
        Top = 62
        Width = 49
        Height = 15
        Size.Values = (
          39.687500000000000000
          1658.937500000000000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel19: TQRLabel
        Left = 679
        Top = 62
        Width = 60
        Height = 17
        Size.Values = (
          44.979166666666670000
          1796.520833333334000000
          164.041666666666700000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel20: TQRLabel
        Left = 677
        Top = 62
        Width = 60
        Height = 15
        Size.Values = (
          39.687500000000000000
          1791.229166666667000000
          164.041666666666700000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel21: TQRLabel
        Left = 627
        Top = 62
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          1658.937500000000000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel22: TQRLabel
        Left = 627
        Top = 45
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666670000
          1658.937500000000000000
          119.062500000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Vendas'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel23: TQRLabel
        Left = 627
        Top = 62
        Width = 49
        Height = 15
        Size.Values = (
          39.687500000000000000
          1658.937500000000000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel24: TQRLabel
        Left = 679
        Top = 62
        Width = 60
        Height = 17
        Size.Values = (
          44.979166666666670000
          1796.520833333334000000
          164.041666666666700000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel25: TQRLabel
        Left = 790
        Top = 62
        Width = 60
        Height = 17
        Size.Values = (
          44.979166666666670000
          2090.208333333333000000
          164.041666666666700000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel26: TQRLabel
        Left = 739
        Top = 62
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          1955.270833333333000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel27: TQRLabel
        Left = 739
        Top = 45
        Width = 111
        Height = 15
        Size.Values = (
          39.687500000000000000
          1955.270833333333000000
          119.062500000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Outras Saidas'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel28: TQRLabel
        Left = 902
        Top = 62
        Width = 60
        Height = 17
        Size.Values = (
          44.979166666666670000
          2386.541666666667000000
          164.041666666666700000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel29: TQRLabel
        Left = 851
        Top = 62
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          2251.604166666667000000
          164.041666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel30: TQRLabel
        Left = 851
        Top = 45
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666670000
          2251.604166666667000000
          119.062500000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel31: TQRLabel
        Left = 963
        Top = 45
        Width = 79
        Height = 17
        Size.Values = (
          44.979166666666670000
          2547.937500000000000000
          119.062500000000000000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel32: TQRLabel
        Left = 963
        Top = 62
        Width = 79
        Height = 17
        Size.Values = (
          44.979166666666670000
          2547.937500000000000000
          164.041666666666700000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRShape1: TQRShape
        Left = 514
        Top = 45
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          1359.958333333333000000
          119.062500000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 627
        Top = 45
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          1658.937500000000000000
          119.062500000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 627
        Top = 45
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          1658.937500000000000000
          119.062500000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape4: TQRShape
        Left = 739
        Top = 45
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          1955.270833333333000000
          119.062500000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 850
        Top = 45
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          2248.958333333333000000
          119.062500000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 963
        Top = 45
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          2547.937500000000000000
          119.062500000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object E_Grupo: TQRDBText
        Left = 3
        Top = 4
        Width = 1040
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          10.583333333333330000
          2751.666666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'GRP_DESCRICAO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
  end
  object Qr_Produtos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '    PRO_CODIGO'
      '   ,PRO_DESCRICAO'
      '   ,GRP_DESCRICAO'
      '   ,GRP_CODIGO'
      '   ,SBG_CODIGO'
      '   ,SBG_DESCRICAO'
      '   ,IVT_CODIGO'
      '   ,IVT_DATA'
      '   ,IVT_CODPRO'
      '   ,IVT_QT_ANT'
      '   ,IVT_VL_CUSTO_ANT'
      '   ,IVT_QT_ENT_CPA'
      '   ,IVT_VL_ENT_CPA'
      '   ,IVT_QT_ENT_OTR'
      '   ,IVT_VL_ENT_OTR'
      '   ,IVT_QT_SAI_VDA'
      '   ,IVT_VL_SAI_VDA'
      '   ,IVT_QT_SAI_OTR'
      '   ,IVT_VL_SAI_OTR'
      '   ,IVT_QT_ATUAL'
      '   ,IVT_QT_AUTO'
      '   ,IVT_VL_CUSTO'
      '   ,CAST((IVT_VL_CUSTO * IVT_QT_ATUAL) AS NUMERIC(18, 6)) IVT_SUBTOTAL'
      'from  TB_PRODUTO tb_produto'
      '            INNER JOIN TB_INVENTARIO tb_inventario '
      
        '            ON (tb_inventario.IVT_CODPRO = tb_produto.PRO_CODIGO' +
        ') '
      '            INNER JOIN TB_GRUPOS Tb_grupos '
      '            ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '
      '            INNER JOIN TB_SUBGRUPOS Tb_subgrupos '
      
        '            ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO' +
        ') '
      '            LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn '
      
        '            ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO' +
        ') '
      '            LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor '
      
        '            ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_COD' +
        'IGO) '
      'WHERE IVT_CODIGO = 1'
      'ORDER BY GRP_DESCRICAO, SBG_DESCRICAO  ,PRO_DESCRICAO')
    Left = 40
    Top = 16
    object Qr_ProdutosPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = '"TB_PRODUTO"."PRO_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ProdutosPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ProdutosGRP_DESCRICAO: TStringField
      FieldName = 'GRP_DESCRICAO'
      Origin = '"TB_GRUPOS"."GRP_DESCRICAO"'
      Size = 100
    end
    object Qr_ProdutosGRP_CODIGO: TIntegerField
      FieldName = 'GRP_CODIGO'
      Origin = '"TB_GRUPOS"."GRP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ProdutosSBG_CODIGO: TIntegerField
      FieldName = 'SBG_CODIGO'
      Origin = '"TB_SUBGRUPOS"."SBG_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ProdutosSBG_DESCRICAO: TStringField
      FieldName = 'SBG_DESCRICAO'
      Origin = '"TB_SUBGRUPOS"."SBG_DESCRICAO"'
      Size = 100
    end
    object Qr_ProdutosIVT_CODIGO: TIntegerField
      FieldName = 'IVT_CODIGO'
      Origin = '"TB_INVENTARIO"."IVT_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ProdutosIVT_DATA: TDateField
      FieldName = 'IVT_DATA'
      Origin = '"TB_INVENTARIO"."IVT_DATA"'
      Required = True
    end
    object Qr_ProdutosIVT_CODPRO: TIntegerField
      FieldName = 'IVT_CODPRO'
      Origin = '"TB_INVENTARIO"."IVT_CODPRO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ProdutosIVT_QT_ANT: TBCDField
      FieldName = 'IVT_QT_ANT'
      Origin = '"TB_INVENTARIO"."IVT_QT_ANT"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_VL_CUSTO_ANT: TBCDField
      FieldName = 'IVT_VL_CUSTO_ANT'
      Origin = '"TB_INVENTARIO"."IVT_VL_CUSTO_ANT"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_QT_ENT_CPA: TBCDField
      FieldName = 'IVT_QT_ENT_CPA'
      Origin = '"TB_INVENTARIO"."IVT_QT_ENT_CPA"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_VL_ENT_CPA: TBCDField
      FieldName = 'IVT_VL_ENT_CPA'
      Origin = '"TB_INVENTARIO"."IVT_VL_ENT_CPA"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_QT_ENT_OTR: TBCDField
      FieldName = 'IVT_QT_ENT_OTR'
      Origin = '"TB_INVENTARIO"."IVT_QT_ENT_OTR"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_VL_ENT_OTR: TBCDField
      FieldName = 'IVT_VL_ENT_OTR'
      Origin = '"TB_INVENTARIO"."IVT_VL_ENT_OTR"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_QT_SAI_VDA: TBCDField
      FieldName = 'IVT_QT_SAI_VDA'
      Origin = '"TB_INVENTARIO"."IVT_QT_SAI_VDA"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_VL_SAI_VDA: TBCDField
      FieldName = 'IVT_VL_SAI_VDA'
      Origin = '"TB_INVENTARIO"."IVT_VL_SAI_VDA"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_QT_SAI_OTR: TBCDField
      FieldName = 'IVT_QT_SAI_OTR'
      Origin = '"TB_INVENTARIO"."IVT_QT_SAI_OTR"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_VL_SAI_OTR: TBCDField
      FieldName = 'IVT_VL_SAI_OTR'
      Origin = '"TB_INVENTARIO"."IVT_VL_SAI_OTR"'
      Precision = 18
      Size = 2
    end
    object Qr_ProdutosIVT_QT_ATUAL: TBCDField
      FieldName = 'IVT_QT_ATUAL'
      Origin = '"TB_INVENTARIO"."IVT_QT_ATUAL"'
      Precision = 18
      Size = 3
    end
    object Qr_ProdutosIVT_VL_CUSTO: TBCDField
      FieldName = 'IVT_VL_CUSTO'
      Origin = '"TB_INVENTARIO"."IVT_VL_CUSTO"'
      Precision = 18
      Size = 3
    end
    object Qr_ProdutosIVT_SUBTOTAL: TFMTBCDField
      FieldName = 'IVT_SUBTOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 6
    end
    object Qr_ProdutosIVT_QT_AUTO: TBCDField
      FieldName = 'IVT_QT_AUTO'
      Origin = '"TB_INVENTARIO"."IVT_QT_AUTO"'
      Precision = 18
      Size = 3
    end
  end
end
