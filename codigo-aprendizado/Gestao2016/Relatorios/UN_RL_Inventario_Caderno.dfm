object RL_Inventario_Caderno: TRL_Inventario_Caderno
  Left = 108
  Top = 179
  Caption = 'Invent'#225'rio de Estoque'
  ClientHeight = 742
  ClientWidth = 1088
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
    Width = 952
    Height = 1347
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
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      0.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      200.000000000000000000
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
    Zoom = 120
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
    object QRBand2: TQRBand
      Left = 91
      Top = 45
      Width = 816
      Height = 156
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        343.958333333333300000
        1799.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRLabel1: TQRLabel
        Left = 0
        Top = 112
        Width = 808
        Height = 20
        Size.Values = (
          44.097222222222220000
          0.000000000000000000
          246.944444444444400000
          1781.527777777778000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 
          '________________________________________________________________' +
          '________________________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Titulo: TQRLabel
        Left = 0
        Top = 133
        Width = 308
        Height = 20
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          679.979166666666700000)
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
    object Grp_Subgrupo: TQRGroup
      Left = 91
      Top = 201
      Width = 816
      Height = 54
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        119.062500000000000000
        1799.166666666667000000)
      PreCaluculateBandHeight = True
      KeepOnOnePage = False
      Expression = 'Qr_Produtos.SBG_DESCRICAO'
      FooterBand = Foot_subgrupo
      Master = Qrpt
      ReprintOnNewPage = True
      object QRShape6: TQRShape
        Left = 718
        Top = 14
        Width = 1
        Height = 38
        Size.Values = (
          84.666666666666680000
          1582.208333333333000000
          31.750000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 583
        Top = 14
        Width = 1
        Height = 38
        Size.Values = (
          84.666666666666680000
          1285.875000000000000000
          31.750000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel31: TQRLabel
        Left = 719
        Top = 14
        Width = 95
        Height = 20
        Size.Values = (
          44.979166666666670000
          1584.854166666667000000
          31.750000000000000000
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
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel30: TQRLabel
        Left = 584
        Top = 14
        Width = 130
        Height = 20
        Size.Values = (
          44.979166666666670000
          1288.520833333333000000
          31.750000000000000000
          285.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRDBText2: TQRDBText
        Left = 382
        Top = 1
        Width = 435
        Height = 16
        Frame.DrawBottom = True
        Size.Values = (
          35.277777777777780000
          842.256944444444400000
          2.204861111111111000
          959.114583333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'SBG_DESCRICAO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel2: TQRLabel
        Left = 5
        Top = 25
        Width = 41
        Height = 19
        Size.Values = (
          41.892361111111110000
          11.024305555555560000
          55.121527777777780000
          90.399305555555560000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'C'#243'digo'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel3: TQRLabel
        Left = 90
        Top = 25
        Width = 388
        Height = 20
        Size.Values = (
          44.979166666666670000
          198.437500000000000000
          55.562500000000000000
          854.604166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Produto'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel28: TQRLabel
        Left = 648
        Top = 35
        Width = 70
        Height = 20
        Size.Values = (
          44.979166666666670000
          1428.750000000000000000
          76.729166666666680000
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
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel29: TQRLabel
        Left = 584
        Top = 35
        Width = 59
        Height = 20
        Size.Values = (
          44.979166666666670000
          1288.520833333333000000
          76.729166666666680000
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
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel32: TQRLabel
        Left = 719
        Top = 35
        Width = 95
        Height = 20
        Size.Values = (
          44.979166666666670000
          1584.854166666667000000
          76.729166666666680000
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
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRDBText1: TQRDBText
        Left = 0
        Top = 1
        Width = 376
        Height = 16
        Frame.DrawBottom = True
        Size.Values = (
          35.277777777777780000
          0.000000000000000000
          2.204861111111111000
          829.027777777777800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'GRP_DESCRICAO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object QRBand4: TQRBand
      Left = 91
      Top = 615
      Width = 816
      Height = 23
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        50.711805555555560000
        1799.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageFooter
      object QRSysData1: TQRSysData
        Left = -2
        Top = 1
        Width = 66
        Height = 20
        Size.Values = (
          44.097222222222220000
          -4.409722222222222000
          2.204861111111111000
          145.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDate
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 8
      end
      object QRSysData2: TQRSysData
        Left = 755
        Top = 1
        Width = 23
        Height = 20
        Size.Values = (
          44.097222222222220000
          1664.670138888889000000
          2.204861111111111000
          50.711805555555560000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsPageNumber
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 8
      end
      object QRLabel18: TQRLabel
        Left = 678
        Top = 1
        Width = 58
        Height = 20
        Size.Values = (
          44.097222222222220000
          1494.895833333333000000
          2.204861111111111000
          127.881944444444400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagina N'#186
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
      object QRLabel17: TQRLabel
        Left = 272
        Top = 1
        Width = 168
        Height = 20
        Size.Values = (
          44.097222222222220000
          599.722222222222200000
          2.204861111111111000
          370.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Numero Total de de Produtos'
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
      object QRSysData3: TQRSysData
        Left = 443
        Top = 1
        Width = 37
        Height = 20
        Size.Values = (
          44.097222222222220000
          976.753472222222200000
          2.204861111111111000
          81.579861111111110000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDetailCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 8
      end
    end
    object QRBand3: TQRBand
      Left = 91
      Top = 297
      Width = 816
      Height = 318
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = QRBand3BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        701.145833333333300000
        1799.166666666667000000)
      PreCaluculateBandHeight = True
      KeepOnOnePage = True
      BandType = rbSummary
      object Label17: TQRLabel
        Left = 7
        Top = 1
        Width = 204
        Height = 18
        Size.Values = (
          39.687500000000000000
          15.434027777777780000
          2.204861111111111000
          449.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade Total  Atual no Estoque'
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
      object Label18: TQRLabel
        Left = 443
        Top = 1
        Width = 166
        Height = 18
        Size.Values = (
          39.687500000000000000
          976.753472222222200000
          2.204861111111111000
          366.006944444444400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total Atual no Estoque'
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
      object E_QT_TL_SALDO: TQRLabel
        Left = 215
        Top = 1
        Width = 161
        Height = 18
        Size.Values = (
          39.687500000000000000
          473.604166666666700000
          2.645833333333333000
          354.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
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
      object E_VL_TL_SALDO: TQRLabel
        Left = 614
        Top = 1
        Width = 194
        Height = 18
        Size.Values = (
          39.687500000000000000
          1354.666666666667000000
          2.645833333333333000
          428.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
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
      object QRLabel7: TQRLabel
        Left = 7
        Top = 19
        Width = 184
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          41.892361111111110000
          405.694444444444400000)
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
        Left = 7
        Top = 44
        Width = 155
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          97.013888888888890000
          341.753472222222200000)
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
        Left = 7
        Top = 65
        Width = 92
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          143.315972222222200000
          202.847222222222200000)
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
        Left = 382
        Top = 64
        Width = 84
        Height = 20
        Size.Values = (
          44.097222222222220000
          842.256944444444400000
          141.111111111111100000
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
        Left = 7
        Top = 102
        Width = 132
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          224.895833333333300000
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
        Left = 7
        Top = 84
        Width = 139
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          185.208333333333300000
          306.475694444444400000)
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
        Left = 164
        Top = 46
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          361.597222222222200000
          101.423611111111100000
          94.809027777777780000)
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
        Left = 151
        Top = 84
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          332.934027777777800000
          185.208333333333300000
          94.809027777777780000)
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
        Left = 102
        Top = 64
        Width = 78
        Height = 20
        Size.Values = (
          44.097222222222220000
          224.895833333333300000
          141.111111111111100000
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
        Left = 143
        Top = 103
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          315.295138888888900000
          227.100694444444400000
          94.809027777777780000)
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
        Left = 7
        Top = 200
        Width = 90
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          440.972222222222200000
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
        Left = 101
        Top = 202
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          222.690972222222200000
          445.381944444444400000
          94.809027777777780000)
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
        Left = 7
        Top = 218
        Width = 131
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          480.659722222222200000
          288.836805555555600000)
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
        Left = 140
        Top = 218
        Width = 48
        Height = 20
        Size.Values = (
          44.097222222222220000
          308.680555555555600000
          480.659722222222200000
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
        Left = 7
        Top = 103
        Width = 132
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          227.100694444444400000
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
        Left = 7
        Top = 124
        Width = 126
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          273.402777777777800000
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
        Left = 137
        Top = 124
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          302.065972222222200000
          273.402777777777800000
          94.809027777777780000)
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
        Left = 7
        Top = 143
        Width = 154
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          315.295138888888900000
          339.548611111111100000)
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
        Left = 163
        Top = 143
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          359.392361111111100000
          315.295138888888900000
          94.809027777777780000)
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
        Left = 7
        Top = 162
        Width = 126
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          357.187500000000000000
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
        Left = 138
        Top = 162
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          304.270833333333300000
          357.187500000000000000
          94.809027777777780000)
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
        Left = 7
        Top = 181
        Width = 145
        Height = 20
        Size.Values = (
          44.097222222222220000
          15.434027777777780000
          399.079861111111100000
          319.704861111111100000)
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
        Left = 155
        Top = 181
        Width = 43
        Height = 20
        Size.Values = (
          44.097222222222220000
          341.753472222222200000
          399.079861111111100000
          94.809027777777780000)
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
        Left = 6
        Top = 236
        Width = 127
        Height = 20
        Size.Values = (
          44.097222222222220000
          13.229166666666670000
          520.347222222222200000
          280.017361111111100000)
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
        Left = 138
        Top = 236
        Width = 48
        Height = 20
        Size.Values = (
          44.097222222222220000
          304.270833333333300000
          520.347222222222200000
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
        Left = 6
        Top = 256
        Width = 115
        Height = 20
        Size.Values = (
          44.097222222222220000
          13.229166666666670000
          564.444444444444400000
          253.559027777777800000)
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
        Left = 125
        Top = 256
        Width = 48
        Height = 20
        Size.Values = (
          44.097222222222220000
          275.607638888888900000
          564.444444444444400000
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
        Left = 6
        Top = 275
        Width = 120
        Height = 20
        Size.Values = (
          44.097222222222220000
          13.229166666666670000
          606.336805555555600000
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
        Left = 127
        Top = 275
        Width = 48
        Height = 20
        Size.Values = (
          44.097222222222220000
          280.017361111111100000
          606.336805555555600000
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
        Left = 468
        Top = 64
        Width = 78
        Height = 20
        Size.Values = (
          44.097222222222220000
          1031.875000000000000000
          141.111111111111100000
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
    object QRBand1: TQRBand
      Left = 91
      Top = 255
      Width = 816
      Height = 18
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        39.687500000000000000
        1799.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBText3: TQRDBText
        Left = 88
        Top = 0
        Width = 490
        Height = 18
        Size.Values = (
          39.687500000000000000
          193.145833333333300000
          0.000000000000000000
          1079.500000000000000000)
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
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object E_CODPRODUTO: TQRDBText
        Left = 5
        Top = 0
        Width = 77
        Height = 17
        Size.Values = (
          37.482638888888890000
          11.024305555555560000
          0.000000000000000000
          169.774305555555600000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_CODIGO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object E_QT_ATUAL: TQRDBText
        Left = 588
        Top = 0
        Width = 56
        Height = 18
        Size.Values = (
          39.687500000000000000
          1296.458333333333000000
          0.000000000000000000
          123.472222222222200000)
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
        Font.Height = -9
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
        FontSize = 7
      end
      object E_VL_CUSTO: TQRDBText
        Left = 648
        Top = 0
        Width = 65
        Height = 18
        Size.Values = (
          39.687500000000000000
          1428.750000000000000000
          0.000000000000000000
          142.875000000000000000)
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
        Font.Height = -9
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
        FontSize = 7
      end
      object QRDBText4: TQRDBText
        Left = 722
        Top = 0
        Width = 91
        Height = 18
        Size.Values = (
          39.687500000000000000
          1592.791666666667000000
          0.000000000000000000
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
        Font.Height = -9
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
        FontSize = 7
      end
      object QRShape11: TQRShape
        Left = 583
        Top = -1
        Width = 1
        Height = 25
        Size.Values = (
          55.562500000000000000
          1285.875000000000000000
          -2.645833333333333000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 717
        Top = -1
        Width = 1
        Height = 25
        Size.Values = (
          55.856481481481480000
          1581.620370370371000000
          -2.939814814814815000
          2.939814814814815000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
    end
    object Foot_subgrupo: TQRBand
      Left = 91
      Top = 273
      Width = 816
      Height = 24
      Frame.DrawTop = True
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        1799.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRExpr1: TQRExpr
        Left = 588
        Top = 1
        Width = 128
        Height = 18
        Size.Values = (
          39.687500000000000000
          1296.458333333333000000
          2.204861111111111000
          282.222222222222200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = False
        Transparent = False
        Expression = 'SUM(Qr_Produtos.IVT_QT_ATUAL)'
        Mask = '#,##0.00'
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRExpr2: TQRExpr
        Left = 719
        Top = 1
        Width = 90
        Height = 18
        Size.Values = (
          39.687500000000000000
          1585.295138888889000000
          2.204861111111111000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = False
        Transparent = False
        Expression = 'SUM(Qr_Produtos.IVT_SUBTOTAL)'
        Mask = '#,##0.00'
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLabel4: TQRLabel
        Left = 425
        Top = 1
        Width = 124
        Height = 18
        Size.Values = (
          39.687500000000000000
          937.065972222222200000
          2.204861111111111000
          273.402777777777800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Subtotal do Subgrupo'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
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
      
        ' SELECT PRO_CODIGO, PRO_DESCRICAO, GRP_DESCRICAO, GRP_CODIGO, SB' +
        'G_CODIGO, SBG_DESCRICAO, IVT_CODIGO, IVT_DATA, IVT_CODPRO, IVT_V' +
        'L_SAI_VDA,     '
      
        'IVT_QT_ANT, IVT_VL_CUSTO_ANT, IVT_QT_ENT_CPA, IVT_VL_ENT_CPA, IV' +
        'T_QT_ENT_OTR, IVT_VL_ENT_OTR, IVT_QT_SAI_VDA, IVT_QT_SAI_OTR, IV' +
        'T_VL_SAI_OTR, '
      
        'IVT_QT_ATUAL,IVT_VL_CUSTO  ,(IVT_VL_CUSTO * IVT_QT_ATUAL) IVT_SU' +
        'BTOTAL, IVT_QT_AUTO '
      'FROM TB_PRODUTO Tb_produto  '
      '  INNER JOIN TB_INVENTARIO tb_inventario '
      '  ON (tb_inventario.IVT_CODPRO = tb_produto.PRO_CODIGO) '
      '  INNER JOIN TB_GRUPOS Tb_grupos '
      '  ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '
      '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos '
      '  ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) '
      ' WHERE (IVT_DATA='#39'01/01/2022'#39')'
      'order by grp_descricao, sbg_descricao')
    Left = 40
    Top = 16
  end
end
