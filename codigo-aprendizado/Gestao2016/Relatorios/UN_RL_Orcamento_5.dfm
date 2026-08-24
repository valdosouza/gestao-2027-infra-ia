object RL_Orcamento_5: TRL_Orcamento_5
  Left = -4
  Top = -4
  Caption = 'Or'#231'amento'
  ClientHeight = 708
  ClientWidth = 1352
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
    Top = 10
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
      'DETALHEVENDA')
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
    ReportTitle = 'Or'#231'amento'
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
      Left = 38
      Top = 137
      Width = 1047
      Height = 153
      AlignToBottom = False
      BeforePrint = QRBand2BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        404.812500000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object Label1: TLabel
        Left = 499
        Top = 66
        Width = 76
        Height = 16
        Caption = 'ITF_VL_UNIT'
      end
      object QRMemo5: TQRMemo
        Left = 792
        Top = 131
        Width = 82
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333340000
          2095.500000000000000000
          346.604166666666700000
          216.958333333333400000)
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
      object Lb_Orcamento: TQRLabel
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
      object QRMemo3: TQRMemo
        Left = 0
        Top = 131
        Width = 793
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333340000
          0.000000000000000000
          346.604166666666700000
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
      object QRMemo6: TQRMemo
        Left = 874
        Top = 131
        Width = 81
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333340000
          2312.458333333333000000
          346.604166666666700000
          214.312500000000000000)
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
        Left = 954
        Top = 131
        Width = 91
        Height = 22
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          58.208333333333340000
          2524.125000000000000000
          346.604166666666700000
          240.770833333333300000)
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
        Top = 134
        Width = 318
        Height = 16
        Size.Values = (
          42.333333333333340000
          10.583333333333330000
          354.541666666666700000
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
        Left = 798
        Top = 134
        Width = 66
        Height = 17
        Size.Values = (
          44.979166666666670000
          2111.375000000000000000
          354.541666666666700000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Quantidade'
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
      object QRLabel26: TQRLabel
        Left = 882
        Top = 134
        Width = 59
        Height = 17
        Size.Values = (
          44.979166666666670000
          2333.625000000000000000
          354.541666666666700000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'V. Unit'#225'rio'
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
        Left = 983
        Top = 134
        Width = 51
        Height = 17
        Size.Values = (
          44.979166666666670000
          2600.854166666667000000
          354.541666666666700000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
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
      object QRMemo15: TQRMemo
        Left = 0
        Top = 33
        Width = 1045
        Height = 98
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          259.291666666666700000
          0.000000000000000000
          87.312500000000000000
          2764.895833333333000000)
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
        Width = 74
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          95.250000000000000000
          195.791666666666700000)
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
      object QRLabel4: TQRLabel
        Left = 2
        Top = 55
        Width = 74
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          145.520833333333300000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Endere'#231'o :'
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
      object QRLabel5: TQRLabel
        Left = 2
        Top = 71
        Width = 74
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          187.854166666666700000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Bairro :'
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
      object Lb_CPFCNPJ: TQRLabel
        Left = 2
        Top = 87
        Width = 74
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          230.187500000000000000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CPFCNPJ'
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
      object Lb_Cli_Endereco: TQRLabel
        Left = 82
        Top = 55
        Width = 447
        Height = 17
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          145.520833333333300000
          1182.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Endereco'
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
      object Lb_Cli_Nome: TQRLabel
        Left = 82
        Top = 36
        Width = 445
        Height = 17
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          95.250000000000000000
          1177.395833333333000000)
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
      object Lb_Cli_bairro: TQRLabel
        Left = 82
        Top = 71
        Width = 443
        Height = 17
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          187.854166666666700000
          1172.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_bairro'
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
      object Lb_Cli_Cnpj: TQRLabel
        Left = 82
        Top = 87
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          216.958333333333300000
          230.187500000000000000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_Cnpj'
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
      object Lb_Cli_cep: TQRLabel
        Left = 566
        Top = 55
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          1497.541666666667000000
          145.520833333333300000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_cep'
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
      object Lb_Cli_Cidade: TQRLabel
        Left = 585
        Top = 71
        Width = 148
        Height = 17
        Size.Values = (
          44.979166666666670000
          1547.812500000000000000
          187.854166666666700000
          391.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Cidade'
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
      object Lb_Cli_IncEst: TQRLabel
        Left = 626
        Top = 87
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          1656.291666666667000000
          230.187500000000000000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_IncEst'
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
      object QRLabel6: TQRLabel
        Left = 531
        Top = 55
        Width = 35
        Height = 17
        Size.Values = (
          44.979166666666670000
          1404.937500000000000000
          145.520833333333300000
          92.604166666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'CEP :'
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
      object QRLabel9: TQRLabel
        Left = 531
        Top = 71
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          1404.937500000000000000
          187.854166666666700000
          142.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Cidade :'
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
      object QRLabel10: TQRLabel
        Left = 531
        Top = 87
        Width = 96
        Height = 17
        Size.Values = (
          44.979166666666670000
          1404.937500000000000000
          230.187500000000000000
          254.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Insc. Estadual :'
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
      object QRLabel12: TQRLabel
        Left = 679
        Top = 55
        Width = 37
        Height = 17
        Size.Values = (
          44.979166666666670000
          1796.520833333333000000
          145.520833333333300000
          97.895833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Fone:'
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
      object Lb_Cli_FoneC: TQRLabel
        Left = 717
        Top = 54
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1897.062500000000000000
          142.875000000000000000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_FoneC'
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
      object QRLabel13: TQRLabel
        Left = 3020
        Top = 268
        Width = 29
        Height = 17
        Size.Values = (
          44.979166666666670000
          7990.416666666668000000
          709.083333333333400000
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
      object Lb_Cli_Fax: TQRLabel
        Left = 837
        Top = 70
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          2214.562500000000000000
          185.208333333333300000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Fax'
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
      object QRLabel34: TQRLabel
        Left = 739
        Top = 87
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          1955.270833333333000000
          230.187500000000000000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cel:'
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
      object Lb_Cli_Celular: TQRLabel
        Left = 777
        Top = 86
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          2055.812500000000000000
          227.541666666666700000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Celular'
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
      object QRLabel36: TQRLabel
        Left = 2
        Top = 104
        Width = 74
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          275.166666666666700000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'e-mail:'
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
      object Lb_Cli_Email: TQRLabel
        Left = 82
        Top = 104
        Width = 77
        Height = 17
        Size.Values = (
          44.979166666666670000
          216.958333333333300000
          275.166666666666700000
          203.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lb_Cli_Email'
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
      object QRLabel48: TQRLabel
        Left = 530
        Top = 105
        Width = 58
        Height = 17
        Size.Values = (
          44.979166666666670000
          1402.291666666667000000
          277.812500000000000000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Contato :'
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
      object Lb_Emp_Contato: TQRLabel
        Left = 585
        Top = 105
        Width = 267
        Height = 17
        Size.Values = (
          44.979166666666670000
          1547.812500000000000000
          277.812500000000000000
          706.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Emp_Contato'
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
      object QRLabel23: TQRLabel
        Left = 736
        Top = 71
        Width = 22
        Height = 17
        Size.Values = (
          44.979166666666670000
          1947.333333333333000000
          187.854166666666700000
          58.208333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'UF:'
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
      object Lb_Cli_UF: TQRLabel
        Left = 762
        Top = 71
        Width = 33
        Height = 17
        Size.Values = (
          44.979166666666670000
          2016.125000000000000000
          187.854166666666700000
          87.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_UF'
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
    end
    object DetalheVenda: TQRStringsBand
      Left = 38
      Top = 290
      Width = 1047
      Height = 65
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
        171.979166666666700000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Width = 82
        Height = 65
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          171.979166666666700000
          2098.145833333333000000
          0.000000000000000000
          216.958333333333400000)
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
      object QRMemo9: TQRMemo
        Left = 874
        Top = 0
        Width = 80
        Height = 65
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          171.979166666666700000
          2312.458333333333000000
          0.000000000000000000
          211.666666666666700000)
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
      object QRMemo10: TQRMemo
        Left = 953
        Top = 0
        Width = 91
        Height = 65
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          171.979166666666700000
          2521.479166666667000000
          0.000000000000000000
          240.770833333333300000)
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
      object Lb_Produto: TQRLabel
        Left = 7
        Top = 1
        Width = 403
        Height = 17
        Size.Values = (
          44.979166666666670000
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
      object Lb_Quantidade: TQRLabel
        Left = 798
        Top = 23
        Width = 71
        Height = 17
        Size.Values = (
          44.979166666666670000
          2111.375000000000000000
          60.854166666666680000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Quantidade'
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
      object Lb_Vl_Unitario: TQRLabel
        Left = 880
        Top = 23
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          2328.333333333333000000
          60.854166666666680000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Unit'#225'rio'
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
      object Lb_Vl_Subtotal: TQRLabel
        Left = 960
        Top = 23
        Width = 80
        Height = 17
        Size.Values = (
          44.979166666666670000
          2540.000000000000000000
          60.854166666666680000
          211.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
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
      object QRMemo2: TQRMemo
        Left = 0
        Top = 21
        Width = 436
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
          0.000000000000000000
          55.562500000000000000
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
        Top = 42
        Width = 436
        Height = 23
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          60.854166666666680000
          0.000000000000000000
          111.125000000000000000
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
        Top = 25
        Width = 403
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          66.145833333333340000
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
        Top = 46
        Width = 403
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          121.708333333333300000
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
        Top = 21
        Width = 51
        Height = 44
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          116.416666666666700000
          1153.583333333333000000
          55.562500000000000000
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
        Top = 21
        Width = 51
        Height = 44
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          116.416666666666700000
          1288.520833333333000000
          55.562500000000000000
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
        Top = 21
        Width = 51
        Height = 44
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          116.416666666666700000
          1423.458333333333000000
          55.562500000000000000
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
        Top = 21
        Width = 51
        Height = 44
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          116.416666666666700000
          1558.395833333333000000
          55.562500000000000000
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
        Top = 21
        Width = 51
        Height = 44
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          116.416666666666700000
          1693.333333333333000000
          55.562500000000000000
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
        Top = 21
        Width = 51
        Height = 44
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          116.416666666666700000
          1828.270833333333000000
          55.562500000000000000
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
        Top = 21
        Width = 51
        Height = 44
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          116.416666666666700000
          1963.208333333333000000
          55.562500000000000000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Height = 21
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          55.562500000000000000
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
        Top = 2
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333340000
          1161.520833333333000000
          5.291666666666667000
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
        Top = 2
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333340000
          1296.458333333333000000
          5.291666666666667000
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
        Top = 2
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333340000
          1436.687500000000000000
          5.291666666666667000
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
        Top = 2
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333340000
          1566.333333333333000000
          5.291666666666667000
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
        Top = 2
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333340000
          1701.270833333333000000
          5.291666666666667000
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
        Top = 2
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333340000
          1841.500000000000000000
          5.291666666666667000
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
        Top = 2
        Width = 42
        Height = 16
        Size.Values = (
          42.333333333333340000
          1973.791666666667000000
          5.291666666666667000
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
    object QRBand4: TQRBand
      Left = 38
      Top = 355
      Width = 1047
      Height = 205
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
        542.395833333333300000
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
        Left = 790
        Top = 4
        Width = 125
        Height = 20
        Size.Values = (
          52.916666666666660000
          2090.208333333333000000
          10.583333333333330000
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
      object Lb_Usuario: TQRLabel
        Left = 8
        Top = 182
        Width = 121
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          481.541666666666700000
          320.145833333333400000)
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
      object Lb_Validade: TQRLabel
        Left = 163
        Top = 35
        Width = 326
        Height = 16
        Size.Values = (
          42.333333333333340000
          431.270833333333400000
          92.604166666666680000
          862.541666666666900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'VALIDADE DA PROPOSTA:'
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
        Left = 441
        Top = 181
        Width = 217
        Height = 17
        Frame.DrawTop = True
        Size.Values = (
          44.979166666666670000
          1166.812500000000000000
          478.895833333333400000
          574.145833333333400000)
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
      object QRLabel2: TQRLabel
        Left = 5
        Top = 35
        Width = 152
        Height = 16
        Size.Values = (
          42.333333333333340000
          13.229166666666670000
          92.604166666666680000
          402.166666666666600000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'VALIDADE DA PROPOSTA:'
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
      object QRLabel3: TQRLabel
        Left = 4
        Top = 54
        Width = 333
        Height = 16
        Size.Values = (
          42.333333333333340000
          10.583333333333330000
          142.875000000000000000
          881.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Formas de Pagamento / Observa'#231#227'o'
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
        Left = 4
        Top = 72
        Width = 1037
        Height = 89
        Size.Values = (
          235.479166666666700000
          10.583333333333330000
          190.500000000000000000
          2743.729166666667000000)
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
      object LB_TextoDesconto: TQRLabel
        Left = 4
        Top = 4
        Width = 204
        Height = 23
        Size.Values = (
          60.854166666666680000
          10.583333333333330000
          10.583333333333330000
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
        Left = 210
        Top = 4
        Width = 86
        Height = 23
        Size.Values = (
          60.854166666666680000
          555.625000000000000000
          10.583333333333330000
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
    Left = 48
    Top = 49
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
    Top = 24
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
      
        'SELECT PED_CODIGO, PED_NUMERO, CTC_CODIGO, CTC_FANTASIA, CTC_COD' +
        'EMP,'
      
        'CTC_NUMERO, CTC_DATA,   CTC_QT_PRODUTO, CTC_VL_FRETE, CTC_VL_DES' +
        'CONTO, CTC_VL_COTACAO,'
      
        'CTC_PRAZO, CTC_OBS, CTC_PRZ_ENTREGA,CTC_CONTATOEMPRESA,CTC_EMAIL' +
        '_E'
      'FROM  TB_COTACAO tb_cotacao'
      '    LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_cotacao.CTC_CODPED)'
      'WHERE (CTC_CODPED=:CTC_CODPED) ')
    Left = 384
    Top = 8
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
  object Qr_Cliente: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT  EMP_NOME, EMP_FANTASIA, EMP_CODIGO, END_ENDER, END_CEP, ' +
        'END_FONE,  END_BAIRRO, END_CELULAR, CDD_DESCRICAO,UFE_SIGLA,END_' +
        'FAX,EMP_CNPJ, EMP_INSC_EST, EMP_EMAIL,END_NUMERO'
      'FROM  TB_EMPRESA tb_empresa'
      '         INNER JOIN TB_ENDERECO tb_endereco'
      '         ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '         INNER JOIN TB_CIDADE'
      '         ON (TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '        ON (tb_uf.UFE_CODIGO = TB_ENDERECO.END_CODUFE)'
      'WHERE (EMP_CODIGO=:EMP_CODIGO) ')
    Left = 472
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
