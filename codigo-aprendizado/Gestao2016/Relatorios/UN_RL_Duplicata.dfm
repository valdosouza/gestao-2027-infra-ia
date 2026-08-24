object Fr_RL_Duplicata: TFr_RL_Duplicata
  Left = -4
  Top = -4
  Caption = 'Fr_RL_Duplicata'
  ClientHeight = 732
  ClientWidth = 1352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 0
    Top = -184
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Duplicata
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
      110.000000000000000000
      2970.000000000000000000
      110.000000000000000000
      2100.000000000000000000
      70.000000000000000000
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
    ReportTitle = 'Duplicatas'
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
    object QRBand1: TQRBand
      Left = 26
      Top = 42
      Width = 741
      Height = 999
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = True
      Size.Values = (
        2643.187500000000000000
        1960.562500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRShape18: TQRShape
        Left = 6
        Top = 527
        Width = 346
        Height = 137
        Size.Values = (
          362.479166666666700000
          15.875000000000000000
          1394.354166666667000000
          915.458333333333200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape17: TQRShape
        Left = 351
        Top = 527
        Width = 383
        Height = 137
        Size.Values = (
          362.479166666666700000
          928.687500000000000000
          1394.354166666667000000
          1013.354166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object LB_Fone2: TQRLabel
        Left = 165
        Top = 636
        Width = 182
        Height = 17
        Size.Values = (
          44.979166666666670000
          436.562499999999900000
          1682.750000000000000000
          481.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Rua Eng. Benedito M. da Silva, 247'
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
      object QRShape1: TQRShape
        Left = 93
        Top = 249
        Width = 642
        Height = 154
        Size.Values = (
          407.458333333333000000
          246.062500000000000000
          658.812500000000000000
          1698.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 236
        Top = 364
        Width = 499
        Height = 39
        Size.Values = (
          103.187500000000000000
          624.416666666667000000
          963.083333333333000000
          1320.270833333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 93
        Top = 364
        Width = 144
        Height = 39
        Size.Values = (
          103.187500000000000000
          246.062500000000000000
          963.083333333333000000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape9: TQRShape
        Left = 93
        Top = 404
        Width = 642
        Height = 73
        Size.Values = (
          193.145833333333000000
          246.062500000000000000
          1068.916666666670000000
          1698.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 350
        Top = 16
        Width = 383
        Height = 137
        Size.Values = (
          362.479166666666700000
          926.041666666666800000
          42.333333333333340000
          1013.354166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape7: TQRShape
        Left = 5
        Top = 16
        Width = 346
        Height = 137
        Size.Values = (
          362.479166666666700000
          13.229166666666670000
          42.333333333333340000
          915.458333333333200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape6: TQRShape
        Left = 5
        Top = 154
        Width = 121
        Height = 56
        Size.Values = (
          148.166666666667000000
          13.229166666666700000
          407.458333333333000000
          320.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 350
        Top = 154
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          926.041666666667000000
          407.458333333333000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape4: TQRShape
        Left = 235
        Top = 154
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          621.770833333333000000
          407.458333333333000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 120
        Top = 154
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          317.500000000000000000
          407.458333333333000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 465
        Top = 154
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          1230.312500000000000000
          407.458333333333000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRRichText9: TQRRichText
        Left = 122
        Top = 156
        Width = 111
        Height = 34
        Size.Values = (
          89.958333333333300000
          322.791666666667000000
          412.750000000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Valor total da '
          'venda')
      end
      object QRRichText10: TQRRichText
        Left = 238
        Top = 156
        Width = 110
        Height = 37
        Size.Values = (
          97.895833333333300000
          629.708333333333000000
          412.750000000000000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Fatura/Duplicata   '
          'Valor R$')
      end
      object QRRichText11: TQRRichText
        Left = 353
        Top = 156
        Width = 110
        Height = 37
        Size.Values = (
          97.895833333333300000
          933.979166666667000000
          412.750000000000000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Duplicata/ No. '
          'De ordem')
      end
      object QRRichText12: TQRRichText
        Left = 467
        Top = 156
        Width = 112
        Height = 35
        Size.Values = (
          92.604166666666700000
          1235.604166666670000000
          412.750000000000000000
          296.333333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Vencimento')
      end
      object E_Firma: TQRRichText
        Left = 96
        Top = 407
        Width = 634
        Height = 41
        Size.Values = (
          108.479166666667000000
          254.000000000000000000
          1076.854166666670000000
          1677.458333333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Reconhe'#231'o(emos) '
          'a exatid'#227'o desta '
          'Duplicata de '
          'Presta'#231#227'o de '
          'Servi'#231'os/Venda '
          'Mercantil na '
          'import'#226'ncia acima '
          'que pagarei(emos) '
          'a In'#234's Alc'#226'ntara '
          'Silva - ME, ou '#224' sua '
          'ordem na pra'#231'a e '
          'vencimentos acima '
          'indicados')
      end
      object QRLabel1: TQRLabel
        Left = 97
        Top = 252
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          666.750000000000000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Sacado'
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
      object E_NomeCliente: TQRLabel
        Left = 238
        Top = 252
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          666.750000000000000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRLabel3: TQRLabel
        Left = 97
        Top = 270
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          714.375000000000000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endere'#231'o'
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
      object E_Endereco: TQRLabel
        Left = 238
        Top = 270
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          714.375000000000000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Endereco'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 97
        Top = 288
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          762.000000000000000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Municipio'
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
      object E_Cidade: TQRLabel
        Left = 238
        Top = 288
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          762.000000000000000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Cidade'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel7: TQRLabel
        Left = 97
        Top = 307
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          812.270833333333000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Estado'
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
      object E_Estado: TQRLabel
        Left = 238
        Top = 307
        Width = 238
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          812.270833333333000000
          629.708333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Estado'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel9: TQRLabel
        Left = 477
        Top = 307
        Width = 47
        Height = 17
        Size.Values = (
          44.979166666666700000
          1262.062500000000000000
          812.270833333333000000
          124.354166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'C.E.P.'
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
      object E_Cep: TQRLabel
        Left = 528
        Top = 307
        Width = 204
        Height = 17
        Size.Values = (
          44.979166666666700000
          1397.000000000000000000
          812.270833333333000000
          539.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Cep'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel11: TQRLabel
        Left = 97
        Top = 325
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          859.895833333333000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pra'#231'a de Pgto'
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
      object E_PracaPAgto: TQRLabel
        Left = 238
        Top = 325
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          859.895833333333000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_PracaPAgto'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel13: TQRLabel
        Left = 97
        Top = 343
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          907.520833333333000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CNPJ/MF N'#186
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
      object E_CNPJ: TQRLabel
        Left = 238
        Top = 343
        Width = 207
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          907.520833333333000000
          547.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_CNPJ'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel15: TQRLabel
        Left = 448
        Top = 343
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666700000
          1185.333333333330000000
          907.520833333333000000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Insc. Estadual/RG:'
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
      object E_IncEstadual: TQRLabel
        Left = 582
        Top = 343
        Width = 149
        Height = 17
        Size.Values = (
          44.979166666666700000
          1539.875000000000000000
          907.520833333333000000
          394.229166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_IncEstadual'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_DataEmissao: TQRLabel
        Left = 491
        Top = 126
        Width = 99
        Height = 17
        Size.Values = (
          44.979166666666670000
          1299.104166666667000000
          333.375000000000000000
          261.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_DataEmissao'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel18: TQRLabel
        Left = 100
        Top = 366
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666700000
          264.583333333333000000
          968.375000000000000000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Por'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel18Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel20: TQRLabel
        Left = 100
        Top = 382
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666700000
          264.583333333333000000
          1010.708333333330000000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Extenso'
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
      object QRRichText8: TQRRichText
        Left = 7
        Top = 156
        Width = 111
        Height = 31
        Size.Values = (
          82.020833333333300000
          18.520833333333300000
          412.750000000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Fatura no.')
      end
      object E_Aliq_Valor_Limite_1: TQRLabel
        Left = 5
        Top = 212
        Width = 577
        Height = 17
        Size.Values = (
          44.979166666666700000
          13.229166666666700000
          560.916666666667000000
          1526.645833333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Desconto de                                                   % ' +
          'Sobre R$                          At'#233
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Condicao_1: TQRLabel
        Left = 5
        Top = 230
        Width = 577
        Height = 17
        Size.Values = (
          44.979166666666700000
          13.229166666666700000
          608.541666666667000000
          1526.645833333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Condi'#231#245'es Especiais:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Razao1: TQRLabel
        Left = 361
        Top = 30
        Width = 361
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          79.375000000000000000
          955.145833333333500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'IN'#202'S ALCANTRA SILVA - ME'
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
        Left = 96
        Top = 454
        Width = 634
        Height = 17
        Size.Values = (
          44.979166666666700000
          254.000000000000000000
          1201.208333333330000000
          1677.458333333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'EM ___/___/______                 ASSINATURA DO SACADO__________' +
          '____________________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRShape12: TQRShape
        Left = 582
        Top = 154
        Width = 153
        Height = 90
        Size.Values = (
          238.125000000000000000
          1539.875000000000000000
          407.458333333333000000
          404.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel12: TQRLabel
        Left = 586
        Top = 156
        Width = 144
        Height = 41
        Size.Values = (
          108.479166666667000000
          1550.458333333330000000
          412.750000000000000000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Para Uso da Institui'#231#227'o Financeira'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRImage2: TQRImage
        Left = 5
        Top = 249
        Width = 86
        Height = 228
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          603.250000000000000000
          13.229166666666700000
          658.812500000000000000
          227.541666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
      end
      object E_ValorExtenso: TQRLabel
        Left = 239
        Top = 367
        Width = 492
        Height = 34
        Size.Values = (
          89.958333333333300000
          632.354166666667000000
          971.020833333333000000
          1301.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 
          'X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-' +
          'X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-' +
          'X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-'
        Color = clWhite
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VL_Venda: TQRLabel
        Left = 122
        Top = 190
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666700000
          322.791666666667000000
          502.708333333333000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_VL_Venda'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Vl_Dup: TQRLabel
        Left = 238
        Top = 190
        Width = 110
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          502.708333333333000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Vl_Dup'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Dup_Os: TQRLabel
        Left = 353
        Top = 190
        Width = 110
        Height = 17
        Size.Values = (
          44.979166666666700000
          933.979166666667000000
          502.708333333333000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Dup_Os'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Vencim: TQRLabel
        Left = 467
        Top = 190
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666700000
          1235.604166666670000000
          502.708333333333000000
          296.333333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Vencim'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Fatura: TQRLabel
        Left = 7
        Top = 190
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666700000
          18.520833333333300000
          502.708333333333000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Fatura'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRShape13: TQRShape
        Left = 93
        Top = 761
        Width = 642
        Height = 154
        Size.Values = (
          407.458333333333000000
          246.062500000000000000
          2013.479166666670000000
          1698.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 236
        Top = 876
        Width = 499
        Height = 39
        Size.Values = (
          103.187500000000000000
          624.416666666667000000
          2317.750000000000000000
          1320.270833333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 93
        Top = 876
        Width = 144
        Height = 39
        Size.Values = (
          103.187500000000000000
          246.062500000000000000
          2317.750000000000000000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape16: TQRShape
        Left = 93
        Top = 916
        Width = 642
        Height = 73
        Size.Values = (
          193.145833333333000000
          246.062500000000000000
          2423.583333333330000000
          1698.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 5
        Top = 666
        Width = 121
        Height = 56
        Size.Values = (
          148.166666666667000000
          13.229166666666700000
          1762.125000000000000000
          320.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape20: TQRShape
        Left = 350
        Top = 666
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          926.041666666667000000
          1762.125000000000000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape21: TQRShape
        Left = 235
        Top = 666
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          621.770833333333000000
          1762.125000000000000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape22: TQRShape
        Left = 120
        Top = 666
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          317.500000000000000000
          1762.125000000000000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape23: TQRShape
        Left = 465
        Top = 666
        Width = 116
        Height = 56
        Size.Values = (
          148.166666666667000000
          1230.312500000000000000
          1762.125000000000000000
          306.916666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRRichText14: TQRRichText
        Left = 122
        Top = 668
        Width = 111
        Height = 34
        Size.Values = (
          89.958333333333300000
          322.791666666667000000
          1767.416666666670000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Valor total da '
          'venda')
      end
      object QRRichText15: TQRRichText
        Left = 238
        Top = 668
        Width = 110
        Height = 37
        Size.Values = (
          97.895833333333300000
          629.708333333333000000
          1767.416666666670000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Fatura/Duplicata   '
          'Valor R$')
      end
      object QRRichText16: TQRRichText
        Left = 353
        Top = 668
        Width = 110
        Height = 37
        Size.Values = (
          97.895833333333300000
          933.979166666667000000
          1767.416666666670000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Duplicata/ No. '
          'De ordem')
      end
      object QRRichText17: TQRRichText
        Left = 467
        Top = 668
        Width = 112
        Height = 35
        Size.Values = (
          92.604166666666700000
          1235.604166666670000000
          1767.416666666670000000
          296.333333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Vencimento')
      end
      object E_Firma_2: TQRRichText
        Left = 96
        Top = 919
        Width = 637
        Height = 42
        Size.Values = (
          111.125000000000000000
          254.000000000000000000
          2431.520833333333000000
          1685.395833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Reconhe'#231'o(emos) '
          'a exatid'#227'o desta '
          'Duplicata de '
          'Presta'#231#227'o de '
          'Servi'#231'os/Venda '
          'Mercantil na '
          'import'#226'ncia acima '
          'que pagarei(emos) '
          'a In'#234's Alc'#226'ntara '
          'Silva - ME, ou '#224' sua '
          'ordem na pra'#231'a e '
          'vencimentos acima '
          'indicados')
      end
      object QRLabel14: TQRLabel
        Left = 97
        Top = 764
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          2021.416666666670000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Sacado'
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
      object E_NomeCliente_2: TQRLabel
        Left = 238
        Top = 764
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          2021.416666666670000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRLabel19: TQRLabel
        Left = 97
        Top = 782
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          2069.041666666670000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endere'#231'o'
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
      object E_Endereco_2: TQRLabel
        Left = 238
        Top = 782
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          2069.041666666670000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Endereco'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel22: TQRLabel
        Left = 97
        Top = 800
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          2116.666666666670000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Municipio'
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
      object E_Cidade_2: TQRLabel
        Left = 238
        Top = 800
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          2116.666666666670000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Cidade'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel24: TQRLabel
        Left = 97
        Top = 819
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          2166.937500000000000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Estado'
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
      object E_Estado_2: TQRLabel
        Left = 238
        Top = 819
        Width = 238
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          2166.937500000000000000
          629.708333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Estado'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel26: TQRLabel
        Left = 477
        Top = 819
        Width = 47
        Height = 17
        Size.Values = (
          44.979166666666700000
          1262.062500000000000000
          2166.937500000000000000
          124.354166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'C.E.P.'
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
      object E_Cep_2: TQRLabel
        Left = 528
        Top = 819
        Width = 204
        Height = 17
        Size.Values = (
          44.979166666666700000
          1397.000000000000000000
          2166.937500000000000000
          539.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Cep'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel28: TQRLabel
        Left = 97
        Top = 837
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          2214.562500000000000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pra'#231'a de Pgto'
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
      object E_PracaPAgto_2: TQRLabel
        Left = 238
        Top = 837
        Width = 494
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          2214.562500000000000000
          1307.041666666670000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_PracaPAgto'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel30: TQRLabel
        Left = 97
        Top = 855
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666700000
          256.645833333333000000
          2262.187500000000000000
          373.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CNPJ/MF N'#186
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
      object E_CNPJ_2: TQRLabel
        Left = 238
        Top = 855
        Width = 207
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          2262.187500000000000000
          547.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_CNPJ'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel32: TQRLabel
        Left = 448
        Top = 855
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666700000
          1185.333333333330000000
          2262.187500000000000000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Insc. Estadual/RG:'
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
      object E_IncEstadual_2: TQRLabel
        Left = 582
        Top = 855
        Width = 149
        Height = 17
        Size.Values = (
          44.979166666666700000
          1539.875000000000000000
          2262.187500000000000000
          394.229166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_IncEstadual'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel35: TQRLabel
        Left = 100
        Top = 878
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666700000
          264.583333333333000000
          2323.041666666670000000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Por'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        OnPrint = QRLabel35Print
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel36: TQRLabel
        Left = 100
        Top = 894
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666700000
          264.583333333333000000
          2365.375000000000000000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Extenso'
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
      object QRRichText19: TQRRichText
        Left = 7
        Top = 668
        Width = 111
        Height = 31
        Size.Values = (
          82.020833333333300000
          18.520833333333300000
          1767.416666666670000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HiresExport = False
        Transparent = False
        Lines.Strings = (
          'Fatura no.')
      end
      object E_Aliq_Valor_Limite_2: TQRLabel
        Left = 5
        Top = 724
        Width = 577
        Height = 17
        Size.Values = (
          44.979166666666700000
          13.229166666666700000
          1915.583333333330000000
          1526.645833333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Desconto de                                                   % ' +
          'Sobre R$                          At'#233
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Condicao_2: TQRLabel
        Left = 5
        Top = 742
        Width = 577
        Height = 17
        Size.Values = (
          44.979166666666700000
          13.229166666666700000
          1963.208333333330000000
          1526.645833333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Condi'#231#245'es Especiais:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel41: TQRLabel
        Left = 96
        Top = 966
        Width = 634
        Height = 17
        Size.Values = (
          44.979166666666700000
          254.000000000000000000
          2555.875000000000000000
          1677.458333333330000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'EM ___/___/______                 ASSINATURA DO SACADO__________' +
          '____________________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRShape24: TQRShape
        Left = 582
        Top = 666
        Width = 153
        Height = 90
        Size.Values = (
          238.125000000000000000
          1539.875000000000000000
          1762.125000000000000000
          404.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel42: TQRLabel
        Left = 586
        Top = 668
        Width = 144
        Height = 41
        Size.Values = (
          108.479166666667000000
          1550.458333333330000000
          1767.416666666670000000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Para Uso da Institui'#231#227'o Financeira'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRImage4: TQRImage
        Left = 5
        Top = 761
        Width = 86
        Height = 228
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          603.250000000000000000
          13.229166666666700000
          2013.479166666670000000
          227.541666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
      end
      object E_ValorExtenso_2: TQRLabel
        Left = 239
        Top = 879
        Width = 492
        Height = 34
        Size.Values = (
          89.958333333333300000
          632.354166666667000000
          2325.687500000000000000
          1301.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 
          'X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-' +
          'X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-' +
          'X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-'
        Color = clWhite
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_VL_Venda_2: TQRLabel
        Left = 122
        Top = 702
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666700000
          322.791666666667000000
          1857.375000000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_VL_Venda'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Vl_Dup_2: TQRLabel
        Left = 238
        Top = 702
        Width = 110
        Height = 17
        Size.Values = (
          44.979166666666700000
          629.708333333333000000
          1857.375000000000000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Vl_Dup'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Dup_Os_2: TQRLabel
        Left = 353
        Top = 702
        Width = 110
        Height = 17
        Size.Values = (
          44.979166666666700000
          933.979166666667000000
          1857.375000000000000000
          291.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Dup_Os'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Vencim_2: TQRLabel
        Left = 467
        Top = 702
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666700000
          1235.604166666670000000
          1857.375000000000000000
          296.333333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Vencim'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Fatura_2: TQRLabel
        Left = 7
        Top = 702
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666700000
          18.520833333333300000
          1857.375000000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Fatura'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_endereco_1: TQRLabel
        Left = 361
        Top = 50
        Width = 361
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          132.291666666666700000
          955.145833333333500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Rua Eng. Benedito M. da Silva, 247'
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
      object Lb_CepCidUF1: TQRLabel
        Left = 361
        Top = 69
        Width = 361
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          182.562500000000000000
          955.145833333333500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CEP 80430-200 - CURITIBA - PR'
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
      object Lb_CNPJ1: TQRLabel
        Left = 431
        Top = 88
        Width = 290
        Height = 17
        Size.Values = (
          44.979166666666670000
          1140.354166666667000000
          232.833333333333400000
          767.291666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '03987095/0001-77'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel17: TQRLabel
        Left = 361
        Top = 88
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          232.833333333333400000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CNPJ(MF):'
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
      object QRLabel21: TQRLabel
        Left = 361
        Top = 107
        Width = 30
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          283.104166666666700000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'I.E.:'
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
      object Lb_InscEstad1: TQRLabel
        Left = 391
        Top = 107
        Width = 330
        Height = 17
        Size.Values = (
          44.979166666666670000
          1034.520833333333000000
          283.104166666666700000
          873.124999999999900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '90231849-63'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object LB_Fone1: TQRLabel
        Left = 164
        Top = 130
        Width = 182
        Height = 17
        Size.Values = (
          44.979166666666670000
          433.916666666666800000
          343.958333333333400000
          481.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Rua Eng. Benedito M. da Silva, 247'
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
      object logotipo: TQRImage
        Left = 24
        Top = 20
        Width = 306
        Height = 95
        Size.Values = (
          251.354166666666700000
          63.500000000000000000
          52.916666666666660000
          809.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Stretch = True
      end
      object QRLabel8: TQRLabel
        Left = 361
        Top = 126
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          333.375000000000000000
          341.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'DATA DA EMISS'#195'O:'
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
        Left = 9
        Top = 566
        Width = 336
        Height = 38
        Size.Values = (
          100.541666666666700000
          23.812500000000000000
          1497.541666666667000000
          889.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '2'#186' VIA'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 24
      end
      object E_DataEmissao_2: TQRLabel
        Left = 491
        Top = 638
        Width = 97
        Height = 17
        Size.Values = (
          44.979166666666670000
          1299.104166666667000000
          1688.041666666667000000
          256.645833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_DataEmissao'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Razao2: TQRLabel
        Left = 361
        Top = 542
        Width = 368
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          1434.041666666667000000
          973.666666666666900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'IN'#202'S ALCANTRA SILVA - ME'
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
      object Lb_endereco_2: TQRLabel
        Left = 361
        Top = 562
        Width = 368
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          1486.958333333333000000
          973.666666666666900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Rua Eng. Benedito M. da Silva, 247'
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
      object Lb_CepCidUF2: TQRLabel
        Left = 361
        Top = 581
        Width = 368
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          1537.229166666667000000
          973.666666666666900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CEP 80430-200 - CURITIBA - PR'
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
      object Lb_CNPJ2: TQRLabel
        Left = 431
        Top = 600
        Width = 297
        Height = 17
        Size.Values = (
          44.979166666666670000
          1140.354166666667000000
          1587.500000000000000000
          785.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '03987095/0001-77'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel29: TQRLabel
        Left = 361
        Top = 600
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          1587.500000000000000000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CNPJ(MF):'
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
      object QRLabel31: TQRLabel
        Left = 361
        Top = 619
        Width = 28
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          1637.770833333333000000
          74.083333333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'I.E.:'
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
      object Lb_InscEstad2: TQRLabel
        Left = 391
        Top = 619
        Width = 337
        Height = 17
        Size.Values = (
          44.979166666666670000
          1034.520833333333000000
          1637.770833333333000000
          891.645833333333200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '90231849-63'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel34: TQRLabel
        Left = 361
        Top = 638
        Width = 127
        Height = 17
        Size.Values = (
          44.979166666666670000
          955.145833333333500000
          1688.041666666667000000
          336.020833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'DATA DA EMISS'#195'O:'
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
  end
  object Qr_Duplicata: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT DISTINCT FIN_CODIGO, FIN_BAIXA, FIN_SITUACAO, FIN_CODEMP,' +
        ' NFL_NUMERO, PED_NUMERO, FIN_NUMERO,  FIN_DT_VENCIMENTO, EMP_FAN' +
        'TASIA,FIN_VL_PARCELA, FIN_CODQTC, FIN_CODFPG, PED_CODIGO, NFL_CO' +
        'DIGO, EMP_CNPJ, NFL_VL_TL_NOTA, EMP_NOME,'
      '  FIN_DT_LIMIT_DESC,'
      '  FIN_ALIQ_DESC,'
      '  FIN_COND_ESPECIAIS,'
      '  EMP_INSC_EST, END_NUMERO,'
      '  END_ENDER,'
      '  END_BAIRRO,'
      '  END_FONE,'
      '  END_FAX,'
      '  CDD_DESCRICAO,'
      '  UFE_SIGLA,'
      '  END_CEP'
      'FROM TB_FINANCEIRO tb_financeiro'
      '    INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal'
      '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)'
      ''
      '    INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED)'
      ''
      '    INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)'
      ''
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON END_CODIGO = PED_CODEND'
      ''
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      ''
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      
        'WHERE ((FIN_TIPO = '#39'RA'#39') OR (FIN_TIPO = '#39'RM'#39')) AND  (FIN_CODNFL ' +
        '=:FIN_CODNFL) '
      '')
    Left = 144
    Top = 10
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODNFL'
        ParamType = ptUnknown
      end>
  end
end
