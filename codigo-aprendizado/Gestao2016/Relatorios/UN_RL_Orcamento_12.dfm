object RL_Orcamento_13: TRL_Orcamento_13
  Left = 207
  Top = 360
  Caption = 'Or'#231'amento'
  ClientHeight = 532
  ClientWidth = 958
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
    Width = 952
    Height = 1347
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
    ShowProgress = False
    SnapToGrid = True
    Units = MM
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
      Left = 45
      Top = 184
      Width = 861
      Height = 189
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        416.718750000000000000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object Lb_Data: TQRLabel
        Left = 499
        Top = 1
        Width = 356
        Height = 20
        Size.Values = (
          44.979166666666670000
          1100.666666666667000000
          2.645833333333333000
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
      object Lb_Orcamento: TQRLabel
        Left = 10
        Top = 19
        Width = 760
        Height = 35
        Size.Values = (
          76.729166666666680000
          21.166666666666670000
          42.333333333333340000
          1674.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Or'#231'amento N'#176
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
      object QRPDFShape5: TQRMemo
        Left = 0
        Top = 59
        Width = 860
        Height = 109
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          240.770833333333300000
          0.000000000000000000
          129.645833333333300000
          1897.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel1: TQRLabel
        Left = 4
        Top = 64
        Width = 94
        Height = 20
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          140.229166666666700000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Cliente:'
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
        Left = 4
        Top = 83
        Width = 94
        Height = 20
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          182.562500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 4
        Top = 102
        Width = 94
        Height = 20
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          224.895833333333300000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 4
        Top = 121
        Width = 94
        Height = 20
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          267.229166666666700000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 95
        Top = 83
        Width = 414
        Height = 20
        Size.Values = (
          44.979166666666670000
          209.020833333333300000
          182.562500000000000000
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
        Left = 100
        Top = 64
        Width = 390
        Height = 20
        Size.Values = (
          44.979166666666670000
          219.604166666666700000
          140.229166666666700000
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
        Left = 95
        Top = 102
        Width = 395
        Height = 20
        Size.Values = (
          44.979166666666670000
          209.020833333333300000
          224.895833333333300000
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
      object Lb_Cli_cnpj: TQRLabel
        Left = 95
        Top = 121
        Width = 338
        Height = 20
        Size.Values = (
          44.979166666666670000
          209.020833333333300000
          267.229166666666700000
          746.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_cnpj'
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
        Left = 557
        Top = 64
        Width = 97
        Height = 20
        Size.Values = (
          44.979166666666670000
          1227.666666666667000000
          140.229166666666700000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 557
        Top = 83
        Width = 77
        Height = 20
        Size.Values = (
          44.979166666666670000
          1227.666666666667000000
          182.562500000000000000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
      object Lb_Cli_cidade: TQRLabel
        Left = 557
        Top = 102
        Width = 122
        Height = 20
        Size.Values = (
          44.979166666666670000
          1227.666666666667000000
          224.895833333333300000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_cidade'
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
      object Lb_Cli_ie: TQRLabel
        Left = 557
        Top = 121
        Width = 122
        Height = 20
        Size.Values = (
          44.979166666666670000
          1227.666666666667000000
          267.229166666666700000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_ie'
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
        Left = 487
        Top = 64
        Width = 65
        Height = 20
        Size.Values = (
          44.097222222222230000
          1073.767361111111000000
          141.111111111111100000
          143.315972222222200000)
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
      object QRLabel9: TQRLabel
        Left = 510
        Top = 83
        Width = 42
        Height = 20
        Size.Values = (
          44.097222222222230000
          1124.479166666667000000
          183.003472222222200000
          92.604166666666680000)
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
      object QRLabel10: TQRLabel
        Left = 486
        Top = 102
        Width = 65
        Height = 20
        Size.Values = (
          44.097222222222230000
          1071.562500000000000000
          224.895833333333300000
          143.315972222222200000)
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
      object QRLabel11: TQRLabel
        Left = 436
        Top = 121
        Width = 115
        Height = 20
        Size.Values = (
          44.097222222222230000
          961.319444444444500000
          266.788194444444400000
          253.559027777777800000)
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
        Left = 692
        Top = 83
        Width = 44
        Height = 20
        Size.Values = (
          44.097222222222230000
          1525.763888888889000000
          183.003472222222200000
          97.013888888888880000)
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
      object Lb_Cli_Fone: TQRLabel
        Left = 738
        Top = 82
        Width = 116
        Height = 20
        Size.Values = (
          44.979166666666670000
          1627.187500000000000000
          179.916666666666700000
          256.645833333333400000)
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
        Left = 692
        Top = 102
        Width = 35
        Height = 20
        Size.Values = (
          44.097222222222230000
          1525.763888888889000000
          224.895833333333300000
          77.170138888888900000)
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
      object Lb_Cli_fax: TQRLabel
        Left = 738
        Top = 101
        Width = 116
        Height = 20
        Size.Values = (
          44.979166666666670000
          1627.187500000000000000
          222.250000000000000000
          256.645833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_fax'
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
        Left = 692
        Top = 121
        Width = 31
        Height = 20
        Size.Values = (
          44.097222222222230000
          1525.763888888889000000
          266.788194444444400000
          68.350694444444440000)
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
      object Lb_Cli_celular: TQRLabel
        Left = 738
        Top = 120
        Width = 116
        Height = 20
        Size.Values = (
          44.979166666666670000
          1627.187500000000000000
          264.583333333333400000
          256.645833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_celular'
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
        Left = 5
        Top = 142
        Width = 94
        Height = 20
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          312.208333333333400000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
      object Lb_Cli_email: TQRLabel
        Left = 96
        Top = 142
        Width = 358
        Height = 20
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          312.208333333333400000
          788.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_email'
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
      object QRMemo1: TQRMemo
        Left = 0
        Top = 168
        Width = 560
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          0.000000000000000000
          370.416666666666700000
          1234.722222222222000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' C'#243'd F'#225'brica / Descri'#231#227'o do Produto / Marca')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo4: TQRMemo
        Left = 559
        Top = 168
        Width = 98
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          1232.517361111111000000
          370.416666666666700000
          216.076388888888900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' Quantidade')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo8: TQRMemo
        Left = 656
        Top = 168
        Width = 97
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          1446.388888888889000000
          370.416666666666700000
          213.871527777777800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' V. Unit'#225'rio')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo9: TQRMemo
        Left = 752
        Top = 168
        Width = 108
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          52.916666666666660000
          1658.055555555556000000
          370.416666666666700000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          '  SubTotal')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
    end
    object Bd_DetalheStr: TQRStringsBand
      Left = 45
      Top = 373
      Width = 861
      Height = 25
      AlignToBottom = False
      BeforePrint = Bd_DetalheStrBeforePrint
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
        55.121527777777780000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      Items.Strings = (
        '1')
      PrintBefore = False
      object E_Descricao: TQRMemo
        Left = 0
        Top = 1
        Width = 560
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          0.000000000000000000
          2.204861111111111000
          1234.722222222222000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Qtde: TQRMemo
        Left = 559
        Top = 1
        Width = 98
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          1232.517361111111000000
          2.204861111111111000
          216.076388888888900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_VL_Unitario: TQRMemo
        Left = 656
        Top = 1
        Width = 97
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          1446.388888888889000000
          2.204861111111111000
          213.871527777777800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Vl_Unit_Total: TQRMemo
        Left = 752
        Top = 1
        Width = 108
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          52.916666666666660000
          1658.055555555556000000
          2.204861111111111000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
    end
    object QRBand4: TQRBand
      Left = 45
      Top = 398
      Width = 861
      Height = 107
      AlignToBottom = False
      BeforePrint = QRBand4BeforePrint
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
        235.920138888888900000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRMemo11: TQRMemo
        Left = 0
        Top = 0
        Width = 860
        Height = 29
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          0.000000000000000000
          0.000000000000000000
          1897.062500000000000000)
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
        Left = 547
        Top = 4
        Width = 150
        Height = 28
        Size.Values = (
          60.854166666666680000
          1206.500000000000000000
          7.937500000000000000
          330.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'TOTAL GERAL:'
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
      object Lb_Vl_Geral: TQRLabel
        Left = 701
        Top = 4
        Width = 157
        Height = 28
        Size.Values = (
          60.854166666666680000
          1545.166666666667000000
          7.937500000000000000
          346.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'R$ 999.000,00'
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
      object QRLabel3: TQRLabel
        Left = 5
        Top = 61
        Width = 400
        Height = 19
        Size.Values = (
          42.333333333333330000
          10.583333333333330000
          134.937500000000000000
          881.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Observa'#231#245'es'
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
      object Lb_Obs: TQRMemo
        Left = 0
        Top = 82
        Width = 47
        Height = 23
        Size.Values = (
          50.711805555555560000
          0.000000000000000000
          180.798611111111100000
          103.628472222222200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoStretch = True
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object LB_TextoDesconto: TQRLabel
        Left = 5
        Top = 4
        Width = 245
        Height = 28
        Size.Values = (
          60.854166666666680000
          10.583333333333330000
          7.937500000000000000
          539.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'DESCONTO CONCEDIDO:'
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
      object LB_VL_Desconto: TQRLabel
        Left = 252
        Top = 4
        Width = 103
        Height = 28
        Size.Values = (
          60.854166666666680000
          555.625000000000000000
          7.937500000000000000
          227.541666666666700000)
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
      object QRMemo2: TQRMemo
        Left = 1
        Top = 28
        Width = 860
        Height = 35
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          76.729166666666680000
          2.645833333333333000
          60.854166666666680000
          1897.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
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
      object QRLabel2: TQRLabel
        Left = 6
        Top = 31
        Width = 851
        Height = 30
        Size.Values = (
          66.145833333333320000
          13.229166666666670000
          68.791666666666680000
          1875.895833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'FRETE, MONTAGEM E INSTALA'#199#195'O POR CONTA DO CLIENTE'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
    end
    object QRBand3: TQRBand
      Left = 45
      Top = 45
      Width = 861
      Height = 139
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        306.475694444444400000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object Img_Logo: TQRImage
        Left = 8
        Top = 5
        Width = 173
        Height = 118
        Size.Values = (
          259.291666666666700000
          18.520833333333330000
          10.583333333333330000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Stretch = True
      end
      object Lb_Emp_Nome: TQRLabel
        Left = 188
        Top = 2
        Width = 562
        Height = 20
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          5.291666666666667000
          1238.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'ALESSANDRA CRISTINA DOS SANTOS & CIA LTDA - ME'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
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
      object Lb_Emp_Doc: TQRLabel
        Left = 188
        Top = 22
        Width = 562
        Height = 20
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          47.625000000000000000
          1238.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'CNPJ : 04.947.758/0001-92 - IE.: 903.93437-94'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
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
      object Lb_Emp_End: TQRLabel
        Left = 188
        Top = 54
        Width = 562
        Height = 20
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          119.062500000000000000
          1238.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Rua Dr. Levy Buquera, 420 - Sitio Cercado - 81910-190 - Curitiba' +
          ' - PR'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
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
      object Lb_Emp_Fones: TQRLabel
        Left = 188
        Top = 72
        Width = 562
        Height = 20
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          158.750000000000000000
          1238.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'TELEVENDAS: (41) 3378-6200 / 3528-2524 / 3379-2580'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
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
      object Lb_Emp_www: TQRLabel
        Left = 188
        Top = 89
        Width = 562
        Height = 20
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          195.791666666666700000
          1238.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'www.genioferramentas.com.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
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
      object Lb_Emp_email: TQRLabel
        Left = 188
        Top = 107
        Width = 562
        Height = 20
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          235.479166666666700000
          1238.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'vendas@genioferramentas.com.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
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
    end
    object ChildBand1: TQRChildBand
      Left = 45
      Top = 505
      Width = 861
      Height = 48
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1898.385416666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = QRBand4
      PrintOrder = cboAfterParent
      object Lb_Usuario: TQRLabel
        Left = 112
        Top = 16
        Width = 145
        Height = 20
        Frame.DrawTop = True
        Size.Values = (
          44.097222222222230000
          246.944444444444500000
          35.277777777777780000
          319.704861111111100000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valdo de Souza'
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
      object Lb_Assinatura: TQRLabel
        Left = 529
        Top = 15
        Width = 260
        Height = 20
        Frame.DrawTop = True
        Size.Values = (
          44.097222222222230000
          1166.371527777778000000
          33.072916666666670000
          573.263888888888900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Assinatura do Cliente'
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
    end
  end
  object QRPDFFilter1: TQRPDFFilter
    Tag = 1
    CompressionOn = False
    TextEncoding = ASCIIEncoding
    Codepage = '1252'
    SuppressDateTime = False
    Left = 612
    Top = 37
  end
  object Qr_Cotacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  CTC_CODIGO,'
      'CTC_NUMERO,'
      'CTC_DATA,'
      'CTC_FANTASIA,'
      'CTC_PRAZO,'
      ' CTC_VL_CUSTO, '
      ' CTC_VL_COTACAO, '
      ' CTC_VL_DESCONTO, '
      'CTC_VL_FRETE,'
      'CTC_OBS,'
      'EMP_CODIGO,'
      'EMP_NOME,'
      'EMP_FANTASIA,'
      'EMP_CNPJ,'
      'EMP_INSC_EST,'
      'EMP_EMAIL,'
      'END_ENDER,'
      'END_NUMERO,'
      'END_CEP,'
      'END_BAIRRO,'
      'END_FONE,'
      'END_FAX,'
      'END_CELULAR,'
      'CDD_DESCRICAO,'
      'UFE_SIGLA'
      'FROM TB_COTACAO tb_cotacao'
      '  LEFT OUTER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP)'
      '  LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_empresa.EMP_CODIGO = tb_endereco.END_CODEMP)'
      ''
      '  LEFT OUTER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  LEFT OUTER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      ''
      'WHERE(CTC_CODPED =:CTC_CODPED)')
    Left = 352
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODPED'
        ParamType = ptUnknown
      end>
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
      '  ICT_TIPO,'
      '  ICT_CODVCL,'
      '  ICT_DESCRICAO,'
      '  ICT_QTDE,'
      '  ICT_VL_UNIT,'
      '  (ICT_QTDE * ICT_VL_UNIT) AS ICT_VL_SUBTOTAL'
      'FROM TB_ITENS_CTC'
      'WHERE (ICT_CODCTC=:CTC_CODIGO)'
      'ORDER BY ICT_CODIGO'
      '')
    Left = 321
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Produto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PRO_CODIGOFAB, MRC_DESCRICAO'
      'FROM  TB_PRODUTO Tb_produto'
      '   LEFT OUTER JOIN TB_MARCA_PRODUTO tb_marcaproduto'
      '   ON  (tb_marcaproduto.MRC_CODIGO = Tb_produto.PRO_CODMRC)'
      'WHERE PRO_CODIGO=:PRO_CODIGO')
    Left = 393
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
