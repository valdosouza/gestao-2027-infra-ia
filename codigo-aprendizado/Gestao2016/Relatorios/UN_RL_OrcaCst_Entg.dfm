object RL_OrcaCst_Entg: TRL_OrcaCst_Entg
  Left = 188
  Top = -16
  Caption = 'Or'#231'amento de Venda/Servico'
  ClientHeight = 708
  ClientWidth = 1016
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
    Left = 48
    Top = 0
    Width = 1123
    Height = 794
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
      'QRSTRINGSBAND1')
    Functions.DATA = (
      '0'
      '0'
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
      50.000000000000000000
      2970.000000000000000000
      50.000000000000000000
      50.000000000000000000
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
    ReportTitle = 'Or'#231'amento de Venda/Servico'
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
    object QRBand2: TQRBand
      Left = 19
      Top = 124
      Width = 1085
      Height = 632
      Frame.Style = psDashDot
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        1672.166666666667000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object E_VLPeca: TQRLabel
        Left = 58
        Top = 304
        Width = 95
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          153.458333333333300000
          804.333333333333200000
          251.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_VLPeca'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel10: TQRLabel
        Left = 4
        Top = 64
        Width = 76
        Height = 18
        Size.Values = (
          47.625000000000000000
          10.583333333333330000
          169.333333333333300000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'APARELHO:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel12: TQRLabel
        Left = 4
        Top = 84
        Width = 52
        Height = 18
        Size.Values = (
          47.625000000000000000
          10.583333333333330000
          222.250000000000000000
          137.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'MARCA:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel11: TQRLabel
        Left = 4
        Top = 104
        Width = 61
        Height = 18
        Size.Values = (
          47.625000000000000000
          10.583333333333330000
          275.166666666666700000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'MODELO:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel13: TQRLabel
        Left = 4
        Top = 122
        Width = 225
        Height = 18
        Size.Values = (
          47.625000000000000000
          10.583333333333330000
          322.791666666666700000
          595.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DEFEITO RELATADO/OBSERVA'#199#195'O'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel15: TQRLabel
        Left = 4
        Top = 304
        Width = 50
        Height = 18
        Size.Values = (
          47.625000000000000000
          10.583333333333330000
          804.333333333333200000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'PECAS:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VLServico: TQRLabel
        Left = 230
        Top = 304
        Width = 84
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          608.541666666666800000
          804.333333333333200000
          222.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_VLServico'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel16: TQRLabel
        Left = 162
        Top = 304
        Width = 63
        Height = 18
        Size.Values = (
          47.625000000000000000
          428.625000000000000000
          804.333333333333200000
          166.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'SERVI'#199'O:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VLDesc: TQRLabel
        Left = 408
        Top = 304
        Width = 68
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          1079.500000000000000000
          804.333333333333200000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_VLDesc'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel17: TQRLabel
        Left = 327
        Top = 304
        Width = 77
        Height = 18
        Size.Values = (
          47.625000000000000000
          865.187500000000000000
          804.333333333333200000
          203.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DESCONTO:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel19: TQRLabel
        Left = 1
        Top = 333
        Width = 137
        Height = 18
        Size.Values = (
          47.625000000000000000
          2.645833333333333000
          881.062500000000000000
          362.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DATA DE CONSERTO:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_DataConserto: TQRLabel
        Left = 141
        Top = 333
        Width = 106
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          373.062500000000000000
          881.062500000000000000
          280.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_DataConserto'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel20: TQRLabel
        Left = 252
        Top = 333
        Width = 127
        Height = 18
        Size.Values = (
          47.625000000000000000
          666.750000000000000000
          881.062500000000000000
          336.020833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DATA DE ENTREGA:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_DataEntrega: TQRLabel
        Left = 383
        Top = 333
        Width = 95
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          1013.354166666667000000
          881.062500000000000000
          251.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_DataEntrega'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel22: TQRLabel
        Left = 247
        Top = 45
        Width = 122
        Height = 18
        Size.Values = (
          47.625000000000000000
          653.520833333333400000
          119.062500000000000000
          322.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DATA DE ENTRADA'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_DataEntrada_1: TQRLabel
        Left = 388
        Top = 47
        Width = 94
        Height = 17
        Size.Values = (
          44.979166666666670000
          1026.583333333333000000
          124.354166666666700000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_DataEntrada_1'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel28: TQRLabel
        Left = 2
        Top = 213
        Width = 475
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          563.562500000000000000
          1256.770833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'DEFEITO CONSTATADO'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_NomeEmpresa: TQRLabel
        Left = 112
        Top = 442
        Width = 362
        Height = 17
        Frame.DrawTop = True
        Size.Values = (
          44.979166666666670000
          296.333333333333400000
          1169.458333333333000000
          957.791666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_NomeEmpresa'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel4: TQRLabel
        Left = 1
        Top = 357
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          944.562500000000000000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'VALOR TOTAL:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VLTotal: TQRLabel
        Left = 1
        Top = 377
        Width = 93
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          997.479166666666900000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_VLTotal'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 2
        Top = 400
        Width = 473
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          1058.333333333333000000
          1251.479166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Garantia de 30 dias ap'#243's a data do conserto'
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
      object QRLabel3: TQRLabel
        Left = 3
        Top = 465
        Width = 470
        Height = 17
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          1230.312500000000000000
          1243.541666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
          '- - -'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRImage3: TQRImage
        Left = 10
        Top = 465
        Width = 24
        Height = 16
        Size.Values = (
          42.333333333333340000
          26.458333333333330000
          1230.312500000000000000
          63.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        AutoSize = True
        Stretch = True
      end
      object E_NomeCliente: TQRLabel
        Left = 109
        Top = 613
        Width = 362
        Height = 17
        Frame.DrawTop = True
        Size.Values = (
          44.979166666666670000
          288.395833333333400000
          1621.895833333333000000
          957.791666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_NomeCliente'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel7: TQRLabel
        Left = 1
        Top = 532
        Width = 471
        Height = 48
        Size.Values = (
          127.000000000000000000
          2.645833333333333000
          1407.583333333333000000
          1246.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Declaro estar recebendo materiais constantes nesta ordem segundo' +
          ' a situa'#231#227'o descrita na mesma. A garantia corresponde aos servi'#231 +
          'os executados num prazo de 30 dias.'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel8: TQRLabel
        Left = 220
        Top = 508
        Width = 123
        Height = 18
        Size.Values = (
          47.625000000000000000
          582.083333333333400000
          1344.083333333333000000
          325.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DATA DE ENTREGA'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_DataEntrega_2: TQRLabel
        Left = 351
        Top = 507
        Width = 123
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          1341.437500000000000000
          325.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_DataEntrega'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel14: TQRLabel
        Left = 292
        Top = 64
        Width = 62
        Height = 18
        Size.Values = (
          47.625000000000000000
          772.583333333333400000
          169.333333333333300000
          164.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'N'#218'MERO:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 1
        Top = 584
        Width = 69
        Height = 18
        Size.Values = (
          47.625000000000000000
          2.645833333333333000
          1545.166666666667000000
          182.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Situa'#231#227'o : '
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
      object E_Situacao: TQRLabel
        Left = 80
        Top = 584
        Width = 389
        Height = 17
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          1545.166666666667000000
          1029.229166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Situa'#231#227'o'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Marca: TQRLabel
        Left = 59
        Top = 85
        Width = 400
        Height = 17
        Size.Values = (
          44.979166666666670000
          156.104166666666700000
          224.895833333333300000
          1058.333333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Marca'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Modelo: TQRLabel
        Left = 69
        Top = 104
        Width = 400
        Height = 17
        Size.Values = (
          44.979166666666670000
          182.562500000000000000
          275.166666666666700000
          1058.333333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Modelo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_NumSerie: TQRLabel
        Left = 359
        Top = 64
        Width = 122
        Height = 17
        Size.Values = (
          44.979166666666670000
          949.854166666666800000
          169.333333333333300000
          322.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_NumeroAP'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Aparelho: TQRLabel
        Left = 82
        Top = 64
        Width = 209
        Height = 17
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          169.333333333333300000
          552.979166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Aparelho'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel1: TQRLabel
        Left = 0
        Top = 17
        Width = 484
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Size.Values = (
          63.500000000000000000
          0.000000000000000000
          44.979166666666670000
          1280.583333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel9: TQRLabel
        Left = 2
        Top = 20
        Width = 151
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          52.916666666666670000
          399.520833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Or'#231'amento de Conserto'
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
      object Lb_Numero_1: TQRLabel
        Left = 165
        Top = 19
        Width = 313
        Height = 20
        Size.Values = (
          52.916666666666660000
          436.562499999999900000
          50.270833333333330000
          828.145833333333200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0001/06'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object QRLabel5: TQRLabel
        Left = 0
        Top = 481
        Width = 471
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Size.Values = (
          63.500000000000000000
          0.000000000000000000
          1272.645833333333000000
          1246.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoSize = False
        Caption = ' '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel18: TQRLabel
        Left = 2
        Top = 485
        Width = 151
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          1283.229166666667000000
          399.520833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Or'#231'amento de Conserto'
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
      object Lb_Numero_2: TQRLabel
        Left = 165
        Top = 484
        Width = 301
        Height = 20
        Size.Values = (
          52.916666666666660000
          436.562499999999900000
          1280.583333333333000000
          796.395833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0001/06'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object MM_Relatado_1: TQRRichText
        Left = 4
        Top = 141
        Width = 474
        Height = 63
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          166.687500000000000000
          10.583333333333330000
          373.062500000000000000
          1254.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AutoStretch = True
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
      end
      object MM_Constatado: TQRRichText
        Left = 4
        Top = 235
        Width = 474
        Height = 63
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          166.687500000000000000
          10.583333333333330000
          621.770833333333400000
          1254.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AutoStretch = True
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
      end
    end
    object QRBand1: TQRBand
      Left = 19
      Top = 19
      Width = 1085
      Height = 105
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        277.812500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
    end
  end
  object qr_conserto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CONSERTO tb_conserto'
      '  LEFT OUTER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_conserto.CST_CODFOR)'
      '  INNER JOIN TB_SITUACAO tb_situacao'
      '  ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT)'
      'WHERE '
      '  (CST_CODPED=:PED_CODIGO)')
    Left = 683
    Top = 57
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object QR_COTACAO: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_COTACAO tb_cotacao'
      '  LEFT OUTER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP)'
      'WHERE(CTC_CODPED =:CTC_CODPED)')
    Left = 635
    Top = 89
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODPED'
        ParamType = ptUnknown
      end>
  end
end
