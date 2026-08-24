object RL_PedidoVenda_6: TRL_PedidoVenda_6
  Left = 128
  Top = 23
  Caption = 'Pedido de Venda'
  ClientHeight = 830
  ClientWidth = 1142
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
    Left = 0
    Top = -114
    Width = 1111
    Height = 1572
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
      'BD_DETALHESTR'
      'QRSTRINGSBAND1')
    Functions.DATA = (
      '0'
      '0'
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
    ShowProgress = False
    SnapToGrid = True
    Units = Pixels
    Zoom = 140
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
    object Rodape: TQRBand
      Left = 40
      Top = 964
      Width = 1034
      Height = 56
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = RodapeBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1954.136904761905000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object e_Obs: TQRMemo
        Left = 4
        Top = 7
        Width = 1021
        Height = 29
        Size.Values = (
          54.806547619047620000
          7.559523809523811000
          13.229166666666670000
          1929.568452380952000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
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
    end
    object Bd_DetalheStr: TQRStringsBand
      Left = 40
      Top = 361
      Width = 1034
      Height = 29
      AlignToBottom = False
      BeforePrint = Bd_DetalheStrBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        54.806547619047620000
        1954.136904761905000000)
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
      PrintBefore = True
      object E_VL_Total_DEsconto: TQRMemo
        Left = 918
        Top = 1
        Width = 115
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          52.916666666666660000
          1735.666666666667000000
          2.645833333333333000
          216.958333333333400000)
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
      object E_Vl_Unit_Desconto: TQRMemo
        Left = 811
        Top = 1
        Width = 108
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          1531.937500000000000000
          2.645833333333333000
          203.729166666666700000)
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
        Left = 707
        Top = 1
        Width = 104
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          1336.145833333333000000
          2.645833333333333000
          195.791666666666700000)
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
      object E_Cd_Produto: TQRMemo
        Left = 0
        Top = 1
        Width = 129
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          0.000000000000000000
          2.645833333333333000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Descricao: TQRMemo
        Left = 129
        Top = 1
        Width = 391
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          243.416666666666700000
          2.645833333333333000
          738.187500000000000000)
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
        Left = 647
        Top = 1
        Width = 60
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          1222.375000000000000000
          2.645833333333333000
          113.770833333333300000)
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
      object E_Marca: TQRMemo
        Left = 519
        Top = 1
        Width = 127
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666660000
          981.604166666666800000
          2.645833333333333000
          240.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
    object QRBand1: TQRBand
      Left = 40
      Top = 185
      Width = 1034
      Height = 176
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        332.619047619047600000
        1954.136904761905000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object Label1: TLabel
        Left = 276
        Top = 32
        Width = 76
        Height = 16
        Caption = 'ITF_VL_UNIT'
      end
      object QRMemo6: TQRMemo
        Left = 918
        Top = 129
        Width = 115
        Height = 50
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          95.250000000000000000
          1735.666666666667000000
          243.416666666666700000
          216.958333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
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
      object QRMemo13: TQRMemo
        Left = 0
        Top = -1
        Width = 1033
        Height = 129
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          243.416666666666700000
          0.000000000000000000
          -2.645833333333333000
          1952.625000000000000000)
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
      object QRMemo7: TQRMemo
        Left = 811
        Top = 129
        Width = 108
        Height = 50
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          95.250000000000000000
          1531.937500000000000000
          243.416666666666700000
          203.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
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
      object QRMemo8: TQRMemo
        Left = 707
        Top = 129
        Width = 104
        Height = 50
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          95.250000000000000000
          1336.145833333333000000
          243.416666666666700000
          195.791666666666700000)
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
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo9: TQRMemo
        Left = 0
        Top = 129
        Width = 129
        Height = 50
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          95.250000000000000000
          0.000000000000000000
          243.416666666666700000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
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
      object QRLabel3: TQRLabel
        Left = 3
        Top = 3
        Width = 104
        Height = 24
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          5.291666666666667000
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
        Left = 3
        Top = 29
        Width = 104
        Height = 24
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          55.562500000000000000
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
        Left = 3
        Top = 52
        Width = 104
        Height = 24
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          97.895833333333340000
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
        Left = 3
        Top = 74
        Width = 104
        Height = 24
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          140.229166666666700000
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
        Left = 115
        Top = 29
        Width = 483
        Height = 24
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          55.562500000000000000
          912.812500000000000000)
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
        Left = 115
        Top = 3
        Width = 430
        Height = 24
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          5.291666666666667000
          812.270833333333400000)
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
        Left = 115
        Top = 52
        Width = 314
        Height = 24
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          97.895833333333340000
          592.666666666666800000)
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
        Left = 115
        Top = 74
        Width = 98
        Height = 24
        Size.Values = (
          45.357142857142860000
          217.336309523809500000
          139.851190476190500000
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
        Left = 648
        Top = 30
        Width = 91
        Height = 24
        Size.Values = (
          45.357142857142860000
          1224.642857142857000000
          56.696428571428570000
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
        Left = 507
        Top = 52
        Width = 207
        Height = 24
        Size.Values = (
          44.979166666666670000
          957.791666666666800000
          97.895833333333340000
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
        Left = 648
        Top = 74
        Width = 113
        Height = 24
        Size.Values = (
          45.357142857142860000
          1224.642857142857000000
          139.851190476190500000
          213.556547619047600000)
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
      object QRLabel8: TQRLabel
        Left = 599
        Top = 30
        Width = 49
        Height = 24
        Size.Values = (
          45.357142857142860000
          1132.038690476190000000
          56.696428571428570000
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
        Left = 429
        Top = 52
        Width = 76
        Height = 24
        Size.Values = (
          45.357142857142860000
          810.758928571428600000
          98.273809523809520000
          143.630952380952400000)
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
        Left = 512
        Top = 74
        Width = 134
        Height = 24
        Size.Values = (
          45.357142857142860000
          967.619047619047600000
          139.851190476190500000
          253.244047619047600000)
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
        Left = 807
        Top = 30
        Width = 52
        Height = 24
        Size.Values = (
          45.357142857142860000
          1525.133928571429000000
          56.696428571428570000
          98.273809523809520000)
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
        Left = 860
        Top = 28
        Width = 164
        Height = 24
        Size.Values = (
          44.979166666666670000
          1624.541666666667000000
          52.916666666666660000
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
        Left = 806
        Top = 52
        Width = 41
        Height = 24
        Size.Values = (
          45.357142857142860000
          1523.244047619048000000
          98.273809523809520000
          77.485119047619050000)
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
        Left = 860
        Top = 50
        Width = 164
        Height = 24
        Size.Values = (
          44.979166666666670000
          1624.541666666667000000
          95.250000000000000000
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
        Left = 806
        Top = 74
        Width = 36
        Height = 24
        Size.Values = (
          45.357142857142860000
          1523.244047619048000000
          139.851190476190500000
          68.035714285714290000)
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
        Left = 860
        Top = 73
        Width = 164
        Height = 24
        Size.Values = (
          44.979166666666670000
          1624.541666666667000000
          137.583333333333300000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '(41) 99999-9999'
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
        Left = 3
        Top = 98
        Width = 73
        Height = 24
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          185.208333333333300000
          137.583333333333300000)
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
        Left = 115
        Top = 98
        Width = 294
        Height = 24
        Size.Values = (
          44.979166666666670000
          216.958333333333400000
          185.208333333333300000
          555.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 720
        Top = 98
        Width = 94
        Height = 23
        Size.Values = (
          43.467261904761900000
          1360.714285714286000000
          185.208333333333300000
          177.648809523809500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Vendedor:'
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
      object Lb_Cli_Vendedor: TQRLabel
        Left = 816
        Top = 98
        Width = 207
        Height = 24
        Size.Values = (
          44.979166666666670000
          1542.520833333333000000
          185.208333333333300000
          391.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Vendedor'
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
        Left = 648
        Top = 3
        Width = 374
        Height = 24
        Size.Values = (
          44.979166666666670000
          1225.020833333333000000
          5.291666666666667000
          706.437500000000000000)
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
        Left = 549
        Top = 3
        Width = 98
        Height = 24
        Size.Values = (
          45.357142857142860000
          1037.544642857143000000
          5.669642857142857000
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
      object QRMemo15: TQRMemo
        Left = 129
        Top = 129
        Width = 391
        Height = 50
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          95.250000000000000000
          243.416666666666700000
          243.416666666666700000
          738.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
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
      object QRMemo16: TQRMemo
        Left = 647
        Top = 129
        Width = 60
        Height = 50
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          95.250000000000000000
          1222.375000000000000000
          243.416666666666700000
          113.770833333333300000)
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
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel23: TQRLabel
        Left = 718
        Top = 52
        Width = 31
        Height = 24
        Size.Values = (
          45.357142857142860000
          1356.934523809524000000
          98.273809523809520000
          58.586309523809520000)
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
        Left = 755
        Top = 52
        Width = 46
        Height = 24
        Size.Values = (
          44.979166666666670000
          1426.104166666667000000
          97.895833333333340000
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
      object Lb_Cli_Contato: TQRLabel
        Left = 491
        Top = 98
        Width = 224
        Height = 24
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          185.208333333333300000
          423.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Contato'
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
      object QRLabel46: TQRLabel
        Left = 414
        Top = 98
        Width = 76
        Height = 23
        Size.Values = (
          43.467261904761900000
          782.410714285714300000
          185.208333333333300000
          143.630952380952400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Contato:'
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
      object QRLabel18: TQRLabel
        Left = 818
        Top = 134
        Width = 95
        Height = 39
        Size.Values = (
          74.083333333333340000
          1545.166666666667000000
          254.000000000000000000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'V. Unit c/ Desconto'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel19: TQRLabel
        Left = 713
        Top = 141
        Width = 91
        Height = 24
        Size.Values = (
          44.979166666666670000
          1346.729166666667000000
          267.229166666666700000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'V. Unit'#225'rio'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel20: TQRLabel
        Left = 655
        Top = 141
        Width = 46
        Height = 24
        Size.Values = (
          44.979166666666670000
          1238.250000000000000000
          267.229166666666700000
          87.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRMemo57: TQRMemo
        Left = 519
        Top = 129
        Width = 127
        Height = 50
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          95.250000000000000000
          981.604166666666800000
          243.416666666666700000
          240.770833333333300000)
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
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel28: TQRLabel
        Left = 533
        Top = 141
        Width = 104
        Height = 24
        Size.Values = (
          44.979166666666670000
          1008.062500000000000000
          267.229166666666700000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Marca'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel29: TQRLabel
        Left = 6
        Top = 141
        Width = 116
        Height = 24
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          267.229166666666700000
          219.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'C'#243'd F'#225'brica'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel30: TQRLabel
        Left = 134
        Top = 141
        Width = 384
        Height = 24
        Size.Values = (
          44.979166666666670000
          254.000000000000000000
          267.229166666666700000
          724.958333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do produto'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel16: TQRLabel
        Left = 923
        Top = 134
        Width = 102
        Height = 39
        Size.Values = (
          74.083333333333340000
          1743.604166666667000000
          254.000000000000000000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'V. Total c/ Desconto'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    object QRBand2: TQRBand
      Left = 40
      Top = 37
      Width = 1034
      Height = 148
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        279.702380952381000000
        1954.136904761905000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object Img_Logo: TQRImage
        Left = 10
        Top = 6
        Width = 202
        Height = 137
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
        Left = 220
        Top = 3
        Width = 634
        Height = 24
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          5.291666666666667000
          1198.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'G'#202'NIO FERRAMENTAS LTDA ME'
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
        Left = 220
        Top = 25
        Width = 634
        Height = 24
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          47.625000000000000000
          1198.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
        Left = 220
        Top = 47
        Width = 634
        Height = 24
        Size.Values = (
          45.357142857142860000
          415.773809523809500000
          88.824404761904760000
          1198.184523809524000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'RUA DR. LEVY BUQUERA, 420 - S'#205'TIO CERCADO - 81910-190 - CURITIBA' +
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
        Left = 220
        Top = 73
        Width = 634
        Height = 24
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          137.583333333333300000
          1198.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'TELEVENDAS: (41) 3378-6200'
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
        Left = 220
        Top = 97
        Width = 634
        Height = 24
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          182.562500000000000000
          1198.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
        Left = 220
        Top = 120
        Width = 634
        Height = 24
        Size.Values = (
          44.979166666666670000
          415.395833333333400000
          227.541666666666700000
          1198.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object Lb_Cli_Pedido: TQRLabel
        Left = 862
        Top = 62
        Width = 164
        Height = 32
        Size.Values = (
          60.854166666666680000
          1629.833333333333000000
          116.416666666666700000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_CodigoPedido'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
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
    end
    object QRStringsBand1: TQRStringsBand
      Left = 40
      Top = 390
      Width = 1034
      Height = 574
      AlignToBottom = False
      BeforePrint = QRStringsBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        1084.791666666667000000
        1954.136904761905000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      Items.Strings = (
        '1')
      PrintBefore = False
      object E_Cheque_Pre: TQRMemo
        Left = 1
        Top = 513
        Width = 523
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          52.916666666666680000
          1.889880952380953000
          969.508928571428600000
          988.407738095238100000)
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
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Boletos_Vencer: TQRMemo
        Left = 1
        Top = 486
        Width = 523
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          918.482142857142900000
          988.407738095238100000)
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
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Slt_Anterior: TQRMemo
        Left = 1
        Top = 459
        Width = 523
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          867.455357142857100000
          988.407738095238100000)
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
        Lines.Strings = (
          ' ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_FormaPagto_16: TQRMemo
        Left = 281
        Top = 432
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          816.428571428571400000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRMemo11: TQRMemo
        Left = 521
        Top = 162
        Width = 512
        Height = 379
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          716.264880952380900000
          984.627976190476300000
          306.160714285714300000
          967.619047619047700000)
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
      object Lb: TQRLabel
        Left = 527
        Top = 185
        Width = 497
        Height = 18
        Size.Values = (
          34.017857142857150000
          995.967261904762000000
          349.627976190476200000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          '* Garantia: posto de atendimento na loja ferramentas durante o p' +
          'er'#237'odo de garantia'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel2: TQRLabel
        Left = 525
        Top = 375
        Width = 497
        Height = 20
        Size.Values = (
          37.797619047619050000
          992.187500000000000000
          708.705357142857100000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Prazo de entrega'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel1: TQRLabel
        Left = 531
        Top = 166
        Width = 493
        Height = 21
        Size.Values = (
          39.687500000000000000
          1003.526785714286000000
          313.720238095238100000
          931.711309523809500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'INFORMA'#199#213'ES IMPORTANTES'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel11: TQRLabel
        Left = 527
        Top = 202
        Width = 497
        Height = 34
        Size.Values = (
          64.255952380952380000
          995.967261904762000000
          381.755952380952400000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          '* Troca: somente para vendas efetuadas por telefone e internet p' +
          'or defeito de fabrica'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel14: TQRLabel
        Left = 527
        Top = 235
        Width = 497
        Height = 50
        Size.Values = (
          94.494047619047620000
          995.967261904762000000
          444.122023809523800000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          '* Troca / Devolu'#231#227'o: N'#227'o aceitamos troca / devolu'#231#245'es, exceto 7 ' +
          'dias depois da compra, exclusivamente e efetuadas por televendas' +
          ' e site que estejam em desacordo com o solicitado e documentado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel15: TQRLabel
        Left = 527
        Top = 285
        Width = 497
        Height = 17
        Size.Values = (
          32.127976190476190000
          995.967261904762000000
          538.616071428571500000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '* Pagamento: Este pedido n'#227'o '#233' v'#225'lido como recibo, nem quita'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel17: TQRLabel
        Left = 527
        Top = 303
        Width = 497
        Height = 34
        Size.Values = (
          64.255952380952380000
          995.967261904762000000
          572.633928571428500000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          '* Quita'#231#227'o deste pedido esta condicionado a compensa'#231#227'o de todos' +
          ' os eventuais  cheque / boletos utilizados como forma de pagamen' +
          'to'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel25: TQRLabel
        Left = 525
        Top = 415
        Width = 497
        Height = 20
        Size.Values = (
          37.797619047619050000
          992.187500000000000000
          784.300595238095400000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Garantia'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_PrazoEntrega: TQRLabel
        Left = 525
        Top = 394
        Width = 497
        Height = 22
        Size.Values = (
          41.577380952380950000
          992.187500000000000000
          744.613095238095400000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Prazo de Entrega'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object E_DadosGarantia: TQRLabel
        Left = 525
        Top = 434
        Width = 497
        Height = 23
        Size.Values = (
          43.467261904761910000
          992.187500000000000000
          820.208333333333500000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Garantia'
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
      object E_Data: TQRLabel
        Left = 526
        Top = 456
        Width = 497
        Height = 22
        Size.Values = (
          41.577380952380950000
          994.077380952380900000
          861.785714285714200000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Curitiba, xx de Setembro de 2008'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel49: TQRLabel
        Left = 530
        Top = 505
        Width = 241
        Height = 21
        Frame.DrawTop = True
        Size.Values = (
          39.687500000000000000
          1001.636904761905000000
          954.389880952380900000
          455.461309523809500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Ass. Cliente'
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
      object QRLabel50: TQRLabel
        Left = 786
        Top = 505
        Width = 239
        Height = 21
        Frame.DrawTop = True
        Size.Values = (
          39.687500000000000000
          1485.446428571429000000
          954.389880952380900000
          451.681547619047700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Ass. Vendedor'
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
      object QRMemo59: TQRMemo
        Left = 1
        Top = -1
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          -1.889880952380953000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' VENCIMENTO')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo60: TQRMemo
        Left = 129
        Top = -1
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          -1.889880952380953000
          289.151785714285700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' VALOR')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo61: TQRMemo
        Left = 281
        Top = -1
        Width = 238
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          -1.889880952380953000
          449.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' FORMA DE PAGAMENTO')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo62: TQRMemo
        Left = 521
        Top = -1
        Width = 349
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          984.627976190476300000
          -1.889880952380953000
          659.568452380952400000)
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
        Lines.Strings = (
          ' VALOR TOTAL')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_VL_SubTotal: TQRMemo
        Left = 907
        Top = -1
        Width = 127
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          51.026785714285720000
          1714.122023809524000000
          -1.889880952380953000
          240.014880952381000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0,00  ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Dt_Venc_1: TQRMemo
        Left = 1
        Top = 26
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          49.136904761904770000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_1: TQRMemo
        Left = 132
        Top = 26
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285710000
          249.464285714285700000
          49.136904761904760000
          289.151785714285700000)
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
      object E_FormaPagto_1: TQRMemo
        Left = 281
        Top = 26
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          49.136904761904770000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRMemo69: TQRMemo
        Left = 521
        Top = 26
        Width = 349
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          984.627976190476300000
          49.136904761904770000
          659.568452380952400000)
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
        Lines.Strings = (
          ' DESCONTO')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_VL_Desconto: TQRMemo
        Left = 907
        Top = 26
        Width = 127
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          51.026785714285720000
          1714.122023809524000000
          49.136904761904770000
          240.014880952381000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0,00  ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Dt_Venc_2: TQRMemo
        Left = 1
        Top = 53
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          100.163690476190500000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_2: TQRMemo
        Left = 129
        Top = 53
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          100.163690476190500000
          289.151785714285700000)
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
      object E_FormaPagto_2: TQRMemo
        Left = 281
        Top = 53
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          100.163690476190500000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRMemo74: TQRMemo
        Left = 521
        Top = 53
        Width = 349
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          984.627976190476300000
          100.163690476190500000
          659.568452380952400000)
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
        Lines.Strings = (
          ' CR'#201'DITO NA LOJA')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_VL_Credito_Loja: TQRMemo
        Left = 907
        Top = 53
        Width = 127
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          51.026785714285720000
          1714.122023809524000000
          100.163690476190500000
          240.014880952381000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0,00  ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Dt_Venc_3: TQRMemo
        Left = 1
        Top = 80
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          151.190476190476200000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_3: TQRMemo
        Left = 129
        Top = 80
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          151.190476190476200000
          289.151785714285700000)
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
      object E_FormaPagto_3: TQRMemo
        Left = 281
        Top = 80
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          151.190476190476200000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRMemo79: TQRMemo
        Left = 521
        Top = 80
        Width = 349
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          984.627976190476300000
          151.190476190476200000
          659.568452380952400000)
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
        Lines.Strings = (
          ' OUTRAS DESPESAS')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_VL_Outras_Despesas: TQRMemo
        Left = 907
        Top = 80
        Width = 127
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          51.026785714285720000
          1714.122023809524000000
          151.190476190476200000
          240.014880952381000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0,00  ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Dt_Venc_4: TQRMemo
        Left = 1
        Top = 108
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          204.107142857142800000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_4: TQRMemo
        Left = 129
        Top = 108
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          204.107142857142800000
          289.151785714285700000)
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
      object E_FormaPagto_4: TQRMemo
        Left = 281
        Top = 108
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          204.107142857142800000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRMemo84: TQRMemo
        Left = 521
        Top = 108
        Width = 349
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          984.627976190476300000
          204.107142857142800000
          659.568452380952400000)
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
        Lines.Strings = (
          ' FRETE')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Vl_Frete: TQRMemo
        Left = 907
        Top = 108
        Width = 127
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          51.026785714285720000
          1714.122023809524000000
          204.107142857142800000
          240.014880952381000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0,00  ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Dt_Venc_5: TQRMemo
        Left = 1
        Top = 135
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          255.133928571428500000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_5: TQRMemo
        Left = 129
        Top = 135
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          255.133928571428500000
          289.151785714285700000)
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
      object E_FormaPagto_5: TQRMemo
        Left = 281
        Top = 135
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          255.133928571428500000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object QRMemo89: TQRMemo
        Left = 521
        Top = 135
        Width = 351
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          984.627976190476300000
          255.133928571428500000
          663.348214285714300000)
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
        Lines.Strings = (
          ' VALOR TOTAL COM DESCONTO')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_VL_Total_C_Desconto: TQRMemo
        Left = 907
        Top = 135
        Width = 127
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          51.026785714285720000
          1714.122023809524000000
          255.133928571428500000
          240.014880952381000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0,00  ')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object E_Dt_Venc_6: TQRMemo
        Left = 1
        Top = 162
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          306.160714285714300000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_6: TQRMemo
        Left = 129
        Top = 162
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          306.160714285714300000
          289.151785714285700000)
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
      object E_FormaPagto_6: TQRMemo
        Left = 281
        Top = 162
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          306.160714285714300000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_7: TQRMemo
        Left = 1
        Top = 189
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          357.187500000000000000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_7: TQRMemo
        Left = 129
        Top = 189
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          357.187500000000000000
          289.151785714285700000)
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
      object E_FormaPagto_7: TQRMemo
        Left = 281
        Top = 189
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          357.187500000000000000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_8: TQRMemo
        Left = 1
        Top = 216
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          408.214285714285700000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_8: TQRMemo
        Left = 129
        Top = 216
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          408.214285714285700000
          289.151785714285700000)
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
      object E_FormaPagto_8: TQRMemo
        Left = 281
        Top = 216
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          408.214285714285700000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_9: TQRMemo
        Left = 1
        Top = 243
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          459.241071428571500000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_9: TQRMemo
        Left = 129
        Top = 243
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          459.241071428571500000
          289.151785714285700000)
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
      object E_FormaPagto_9: TQRMemo
        Left = 281
        Top = 243
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          459.241071428571500000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_10: TQRMemo
        Left = 1
        Top = 270
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          510.267857142857100000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_10: TQRMemo
        Left = 129
        Top = 270
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          510.267857142857100000
          289.151785714285700000)
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
      object E_FormaPagto_10: TQRMemo
        Left = 281
        Top = 270
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          510.267857142857100000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_11: TQRMemo
        Left = 1
        Top = 297
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          561.294642857142900000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_11: TQRMemo
        Left = 129
        Top = 297
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          561.294642857142900000
          289.151785714285700000)
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
      object E_FormaPagto_11: TQRMemo
        Left = 281
        Top = 297
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          561.294642857142900000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_12: TQRMemo
        Left = 1
        Top = 324
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          612.321428571428600000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_12: TQRMemo
        Left = 129
        Top = 324
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          612.321428571428600000
          289.151785714285700000)
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
      object E_FormaPagto_12: TQRMemo
        Left = 281
        Top = 324
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          612.321428571428600000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_13: TQRMemo
        Left = 1
        Top = 351
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          663.348214285714300000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_13: TQRMemo
        Left = 129
        Top = 351
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          663.348214285714300000
          289.151785714285700000)
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
      object E_FormaPagto_13: TQRMemo
        Left = 281
        Top = 351
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          663.348214285714300000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_14: TQRMemo
        Left = 1
        Top = 378
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          714.375000000000000000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_14: TQRMemo
        Left = 129
        Top = 378
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          714.375000000000000000
          289.151785714285700000)
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
      object E_FormaPagto_14: TQRMemo
        Left = 281
        Top = 378
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          714.375000000000000000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_15: TQRMemo
        Left = 1
        Top = 405
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          765.401785714285700000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_15: TQRMemo
        Left = 129
        Top = 405
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          765.401785714285700000
          289.151785714285700000)
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
      object E_FormaPagto_15: TQRMemo
        Left = 281
        Top = 405
        Width = 240
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          531.056547619047700000
          765.401785714285700000
          453.571428571428500000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object E_Dt_Venc_16: TQRMemo
        Left = 1
        Top = 432
        Width = 129
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1.889880952380953000
          816.428571428571400000
          243.794642857142800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
      object E_Vl_Parc_16: TQRMemo
        Left = 129
        Top = 432
        Width = 153
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          243.794642857142800000
          816.428571428571400000
          289.151785714285700000)
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
      object QRMemo2: TQRMemo
        Left = 869
        Top = -1
        Width = 36
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1642.306547619048000000
          -1.889880952380953000
          68.035714285714290000)
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
        Lines.Strings = (
          ' R$')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo3: TQRMemo
        Left = 869
        Top = 26
        Width = 38
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1642.306547619048000000
          49.136904761904770000
          71.815476190476190000)
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
        Lines.Strings = (
          ' R$')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo4: TQRMemo
        Left = 869
        Top = 53
        Width = 38
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1642.306547619048000000
          100.163690476190500000
          71.815476190476190000)
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
        Lines.Strings = (
          ' R$')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo5: TQRMemo
        Left = 869
        Top = 80
        Width = 38
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1642.306547619048000000
          151.190476190476200000
          71.815476190476190000)
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
        Lines.Strings = (
          ' R$')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo10: TQRMemo
        Left = 869
        Top = 108
        Width = 38
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1642.306547619048000000
          204.107142857142800000
          71.815476190476190000)
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
        Lines.Strings = (
          ' R$')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo12: TQRMemo
        Left = 869
        Top = 135
        Width = 38
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Size.Values = (
          51.026785714285720000
          1642.306547619048000000
          255.133928571428500000
          71.815476190476190000)
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
        Lines.Strings = (
          ' R$')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel21: TQRLabel
        Left = 527
        Top = 339
        Width = 497
        Height = 34
        Size.Values = (
          64.255952380952380000
          995.967261904762000000
          640.669642857142800000
          939.270833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          '* Confira sua mercadoria no ato da entrega, pois n'#227'o aceitamos r' +
          'eclama'#231#245'es posteriores quanto a composi'#231#245'es e estado da mercador' +
          'ia'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel6: TQRLabel
        Left = 1
        Top = 541
        Width = 1033
        Height = 35
        Frame.DrawLeft = True
        Size.Values = (
          66.145833333333340000
          1.889880952380953000
          1022.425595238095000000
          1952.247023809524000000)
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
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 16
      end
    end
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '   ITF_CODIGO, '
      '   ITF_CODPED,'
      '   ITF_CODPRO, '
      '   ITF_QTDE,  '
      '   ITF_VL_UNIT,'
      '   ITF_VL_DESC,'
      '   (ITF_QTDE * ITF_VL_UNIT)- ITF_VL_DESC  as ITF_VL_LINHA,'
      '   PRO_DESCRICAO, PRO_CODIGOFAB, MRC_DESCRICAO'
      'FROM  TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)  '
      '   LEFT OUTER JOIN TB_MARCA_PRODUTO tb_marcaproduto'
      '   ON  (tb_marcaproduto.MRC_CODIGO = Tb_produto.PRO_CODMRC)'
      'WHERE ITF_CODPED =:ITF_CODPED '
      '  ORDER BY PRO_DESCRICAO')
    Left = 448
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODPED'
        ParamType = ptUnknown
      end>
  end
  object DataSource1: TDataSource
    DataSet = Qr_Itens
    Left = 448
    Top = 504
  end
  object Qr_Ordem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PED_CODIGO,'
      
        'PED_NUMERO, PED_DATA, EMP_NOME, EMP_FANTASIA, EMP_CODIGO, END_EN' +
        'DER, END_CEP, END_FONE,  END_NUMERO, END_BAIRRO, END_CELULAR, CD' +
        'D_DESCRICAO,UFE_SIGLA,END_FAX,EMP_CNPJ, EMP_INSC_EST, EMP_EMAIL,' +
        ' CLB_NOME, PED_QT_PRODUTO, PED_VL_FRETE, PED_VL_DESCONTO, PED_VL' +
        '_PEDIDO, FPT_DESCRICAO, PED_PRAZO, ped_obs,PED_DT_ENTREGA, PED_V' +
        'L_ODESPESA, PED_VL_PRODUTO,END_CONTATO,PED_VL_CREDITO,PED_GARANT' +
        'IA, PED_ENTREGA'
      'FROM  TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      '   INNER JOIN TB_COLABORADOR tb_colaborador'
      '   ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)'
      '   INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG)'
      ' INNER JOIN tb_cidade tb_cidade'
      '   ON (tb_cidade.cdd_codigo = tb_endereco.end_codcdd)'
      ' INNER JOIN tb_uf tb_uf'
      '   ON (tb_uf.ufe_codigo = tb_endereco.end_codufe)'
      ''
      'WHERE (PED_CODIGO=:PED_CODIGO) '
      '')
    Left = 520
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Ordem: TDataSource
    DataSet = Qr_Ordem
    Left = 525
    Top = 521
  end
  object Qr_Parcelamento: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_PARCELAMENTO'
      '  LEFT OUTER JOIN TB_FORMAPAGTO'
      '  ON (FPT_CODIGO = PAR_CODFPT)'
      'WHERE PAR_CODPED=:PAR_CODPED'
      'ORDER BY PAR_PARCELA')
    Left = 508
    Top = 566
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PAR_CODPED'
        ParamType = ptUnknown
      end>
  end
end
