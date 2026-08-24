object RL_PedidoCompra_2: TRL_PedidoCompra_2
  Left = 0
  Top = 217
  Caption = 'Pedido de Compra'
  ClientHeight = 468
  ClientWidth = 1140
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
    Top = 0
    Width = 1123
    Height = 794
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
      'QRLOOPBAND1'
      'BND_DETALHE')
    Functions.DATA = (
      '0'
      '0'
      #39#39
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
    PrintIfEmpty = True
    ReportTitle = 'Pedido de Compra'
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
    object QRBand1: TQRBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 223
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        590.020833333333300000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRMemo10: TQRMemo
        Left = 585
        Top = 199
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          1547.812500000000000000
          526.520833333333400000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo9: TQRMemo
        Left = 471
        Top = 199
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          1246.187500000000000000
          526.520833333333400000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo2: TQRMemo
        Left = 813
        Top = 199
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          2151.062500000000000000
          526.520833333333400000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo12: TQRMemo
        Left = 928
        Top = 199
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          2455.333333333333000000
          526.520833333333400000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo11: TQRMemo
        Left = 699
        Top = 199
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          1849.437500000000000000
          526.520833333333400000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo8: TQRMemo
        Left = 2
        Top = 199
        Width = 471
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          5.291666666666667000
          526.520833333333400000
          1246.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo7: TQRMemo
        Left = 553
        Top = 102
        Width = 491
        Height = 98
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          259.291666666666700000
          1463.145833333333000000
          269.875000000000000000
          1299.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo5: TQRMemo
        Left = 2
        Top = 102
        Width = 552
        Height = 98
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          259.291666666666700000
          5.291666666666667000
          269.875000000000000000
          1460.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo3: TQRMemo
        Left = 213
        Top = 2
        Width = 831
        Height = 101
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          267.229166666666700000
          563.562500000000000000
          5.291666666666667000
          2198.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo1: TQRMemo
        Left = 2
        Top = 2
        Width = 212
        Height = 101
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          267.229166666666700000
          5.291666666666667000
          5.291666666666667000
          560.916666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel63: TQRLabel
        Left = 839
        Top = 204
        Width = 63
        Height = 17
        Size.Values = (
          44.979166666666670000
          2219.854166666667000000
          539.750000000000000000
          166.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pre'#231'o Total'
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
      object Qr_Logo: TQRImage
        Left = 45
        Top = 4
        Width = 144
        Height = 94
        Size.Values = (
          248.708333333333300000
          119.062500000000000000
          10.583333333333330000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Center = True
        Stretch = True
      end
      object Lb_Emp_Razao: TQRLabel
        Left = 219
        Top = 5
        Width = 287
        Height = 17
        Size.Values = (
          44.979166666666670000
          579.437500000000000000
          13.229166666666670000
          759.354166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Merconet Rep. de Ve'#237'culos de Comununica'#231#227'o Ltda.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Emp_Endereco: TQRLabel
        Left = 219
        Top = 18
        Width = 259
        Height = 17
        Size.Values = (
          44.979166666666670000
          579.437500000000000000
          47.625000000000000000
          685.270833333333200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Rua Dep. At'#237'lio de Almeida Barobosa, 76 conj-01'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Emp_CepBairroCidadeUf: TQRLabel
        Left = 219
        Top = 32
        Width = 191
        Height = 17
        Size.Values = (
          44.979166666666670000
          579.437500000000000000
          84.666666666666680000
          505.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '82560-460 - Boa Vista - Curitiba - PR'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Emp_FoneFax: TQRLabel
        Left = 219
        Top = 46
        Width = 215
        Height = 17
        Size.Values = (
          44.979166666666670000
          579.437500000000000000
          121.708333333333300000
          568.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'FONE (41) 3257-9053 - FAX (41) 3357-8259'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Emp_Cnpj: TQRLabel
        Left = 219
        Top = 60
        Width = 132
        Height = 17
        Size.Values = (
          44.979166666666670000
          579.437500000000000000
          158.750000000000000000
          349.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'CNPJ: 81.070.617/0003-47'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Emp_InscEst: TQRLabel
        Left = 219
        Top = 73
        Width = 125
        Height = 17
        Size.Values = (
          44.979166666666670000
          579.437500000000000000
          193.145833333333300000
          330.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Inscr. Estadual: ISENTO'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Emp_Email: TQRLabel
        Left = 219
        Top = 87
        Width = 196
        Height = 17
        Size.Values = (
          44.979166666666670000
          579.437500000000000000
          230.187500000000000000
          518.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'E_Mail: merconet@merconet.srv.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel12: TQRLabel
        Left = 3477
        Top = 80
        Width = 91
        Height = 33
        Size.Values = (
          87.312500000000000000
          9199.562500000000000000
          211.666666666666700000
          240.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '005822'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 20
      end
      object QRLabel13: TQRLabel
        Left = 6
        Top = 106
        Width = 74
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          280.458333333333400000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'FORNECEDOR :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel14: TQRLabel
        Left = 6
        Top = 122
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          322.791666666666700000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'RAZ'#195'O SOCIAL :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel15: TQRLabel
        Left = 6
        Top = 138
        Width = 59
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          365.125000000000000000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'ENDERE'#199'O :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel16: TQRLabel
        Left = 6
        Top = 154
        Width = 95
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          407.458333333333400000
          251.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'CEP/MUNICIPIO/UF :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel18: TQRLabel
        Left = 6
        Top = 171
        Width = 32
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          452.437500000000000000
          84.666666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'CNPJ :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_Fantasia: TQRLabel
        Left = 101
        Top = 106
        Width = 252
        Height = 17
        Size.Values = (
          44.979166666666670000
          267.229166666666700000
          280.458333333333400000
          666.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Master Publicidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_Razao: TQRLabel
        Left = 101
        Top = 122
        Width = 252
        Height = 17
        Size.Values = (
          44.979166666666670000
          267.229166666666700000
          322.791666666666700000
          666.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Master Publicidade S/A'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_endereco: TQRLabel
        Left = 101
        Top = 138
        Width = 252
        Height = 17
        Size.Values = (
          44.979166666666670000
          267.229166666666700000
          365.125000000000000000
          666.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Av. Sete de Setembro, 4476 - 2'#186' Andar'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_cepcidadeUf: TQRLabel
        Left = 101
        Top = 154
        Width = 252
        Height = 17
        Size.Values = (
          44.979166666666670000
          267.229166666666700000
          407.458333333333400000
          666.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '80250-210 / Curitiba / PR'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_CNPJ: TQRLabel
        Left = 101
        Top = 171
        Width = 116
        Height = 17
        Size.Values = (
          44.979166666666670000
          267.229166666666700000
          452.437500000000000000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '04513101/0001-17'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel25: TQRLabel
        Left = 187
        Top = 171
        Width = 30
        Height = 17
        Size.Values = (
          44.979166666666670000
          494.770833333333400000
          452.437500000000000000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'I. Est.:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_InscEst: TQRLabel
        Left = 226
        Top = 171
        Width = 123
        Height = 17
        Size.Values = (
          44.979166666666670000
          597.958333333333400000
          452.437500000000000000
          325.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Isento'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel41: TQRLabel
        Left = 558
        Top = 106
        Width = 43
        Height = 17
        Size.Values = (
          44.979166666666670000
          1476.375000000000000000
          280.458333333333400000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'PEDIDO :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel42: TQRLabel
        Left = 558
        Top = 122
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          1476.375000000000000000
          322.791666666666700000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DATA PEDIDO :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel43: TQRLabel
        Left = 558
        Top = 138
        Width = 63
        Height = 17
        Size.Values = (
          44.979166666666670000
          1476.375000000000000000
          365.125000000000000000
          166.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'CONDI'#199#213'ES :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel44: TQRLabel
        Left = 558
        Top = 154
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          1476.375000000000000000
          407.458333333333400000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'TRANSPORTE :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Num_Ped: TQRLabel
        Left = 650
        Top = 106
        Width = 250
        Height = 17
        Size.Values = (
          44.979166666666670000
          1719.791666666667000000
          280.458333333333400000
          661.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Master Publicidade'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Dt_Pedido: TQRLabel
        Left = 650
        Top = 122
        Width = 250
        Height = 17
        Size.Values = (
          44.979166666666670000
          1719.791666666667000000
          322.791666666666700000
          661.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Master Publicidade S/A'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Condicoes: TQRLabel
        Left = 650
        Top = 138
        Width = 250
        Height = 17
        Size.Values = (
          44.979166666666670000
          1719.791666666667000000
          365.125000000000000000
          661.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Av. Sete de Setembro, 4476 - 2'#186' Andar'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Transporte: TQRLabel
        Left = 650
        Top = 154
        Width = 391
        Height = 17
        Size.Values = (
          44.979166666666670000
          1719.791666666667000000
          407.458333333333400000
          1034.520833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '80250-210 / Curitiba / PR'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel55: TQRLabel
        Left = 719
        Top = 204
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          1902.354166666667000000
          539.750000000000000000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Unit'#225'rio'
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
      object Lb_TipoPI: TQRLabel
        Left = 504
        Top = 204
        Width = 45
        Height = 17
        Size.Values = (
          44.979166666666670000
          1333.500000000000000000
          539.750000000000000000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Unidade'
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
      object QRLabel59: TQRLabel
        Left = 10
        Top = 204
        Width = 119
        Height = 17
        Size.Values = (
          44.979166666666670000
          26.458333333333330000
          539.750000000000000000
          314.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Descri'#231#227'o do Produto'
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
      object QRLabel61: TQRLabel
        Left = 609
        Top = 204
        Width = 63
        Height = 17
        Size.Values = (
          44.979166666666670000
          1611.312500000000000000
          539.750000000000000000
          166.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade'
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
      object QRLabel17: TQRLabel
        Left = 6
        Top = 186
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          492.125000000000000000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'FONE/FAX :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_Fone: TQRLabel
        Left = 101
        Top = 186
        Width = 167
        Height = 17
        Size.Values = (
          44.979166666666670000
          267.229166666666700000
          492.124999999999900000
          441.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '04513101/0001-17'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_Frd_Contato: TQRLabel
        Left = 362
        Top = 186
        Width = 166
        Height = 17
        Size.Values = (
          44.979166666666670000
          957.791666666666800000
          492.124999999999900000
          439.208333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Frd_Contato'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel9: TQRLabel
        Left = 270
        Top = 186
        Width = 47
        Height = 17
        Size.Values = (
          44.979166666666670000
          714.375000000000000000
          492.125000000000000000
          124.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'CONTATO:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLabel1: TQRLabel
        Left = 943
        Top = 204
        Width = 79
        Height = 17
        Size.Values = (
          44.979166666666670000
          2495.020833333333000000
          539.750000000000000000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Imposto'
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
      object QRLabel2: TQRLabel
        Left = 558
        Top = 171
        Width = 61
        Height = 17
        Size.Values = (
          44.979166666666670000
          1476.375000000000000000
          452.437500000000000000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'TIPO FRETE :'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object Lb_TipoFrete: TQRLabel
        Left = 650
        Top = 170
        Width = 391
        Height = 17
        Size.Values = (
          44.979166666666670000
          1719.791666666667000000
          449.791666666666700000
          1034.520833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CIF'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object Bnd_Detalhe: TQRStringsBand
      Left = 38
      Top = 261
      Width = 1047
      Height = 22
      AlignToBottom = False
      BeforePrint = Bnd_DetalheBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        2770.187500000000000000)
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
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16')
      PrintBefore = False
      object QRMemo20: TQRMemo
        Left = 471
        Top = -1
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          1246.187500000000000000
          -2.645833333333333000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo19: TQRMemo
        Left = 587
        Top = -1
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          1553.104166666667000000
          -2.645833333333333000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo22: TQRMemo
        Left = 813
        Top = -1
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          2151.062500000000000000
          -2.645833333333333000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo17: TQRMemo
        Left = 928
        Top = -1
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          2455.333333333333000000
          -2.645833333333333000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo18: TQRMemo
        Left = 699
        Top = -1
        Width = 116
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          1849.437500000000000000
          -2.645833333333333000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo21: TQRMemo
        Left = 2
        Top = -1
        Width = 471
        Height = 24
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          63.500000000000000000
          5.291666666666667000
          -2.645833333333333000
          1246.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object Lb_VL_SubTotal: TQRLabel
        Left = 816
        Top = 4
        Width = 109
        Height = 17
        Size.Values = (
          44.979166666666670000
          2159.000000000000000000
          10.583333333333330000
          288.395833333333400000)
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
      object Lb_Vl_Unit: TQRLabel
        Left = 701
        Top = 4
        Width = 109
        Height = 17
        Size.Values = (
          44.979166666666670000
          1854.729166666667000000
          10.583333333333330000
          288.395833333333400000)
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
      object Lb_Unidade: TQRLabel
        Left = 478
        Top = 4
        Width = 98
        Height = 17
        Size.Values = (
          44.979166666666670000
          1264.708333333333000000
          10.583333333333330000
          259.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Unidade'
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
      object Lb_Descricao: TQRLabel
        Left = 10
        Top = 4
        Width = 447
        Height = 17
        Size.Values = (
          44.979166666666670000
          26.458333333333330000
          10.583333333333330000
          1182.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Produto'
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
      object Lb_Qtde: TQRLabel
        Left = 592
        Top = 4
        Width = 105
        Height = 17
        Size.Values = (
          44.979166666666670000
          1566.333333333333000000
          10.583333333333330000
          277.812500000000000000)
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
      object Lb_Vl_SubImposto: TQRLabel
        Left = 931
        Top = 4
        Width = 109
        Height = 17
        Size.Values = (
          44.979166666666670000
          2463.270833333333000000
          10.583333333333330000
          288.395833333333400000)
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
    end
    object QRBand2: TQRBand
      Left = 38
      Top = 283
      Width = 1047
      Height = 140
      AlignToBottom = False
      BeforePrint = QRBand2BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        370.416666666666700000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRMemo23: TQRMemo
        Left = 551
        Top = 2
        Width = 493
        Height = 51
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          134.937500000000000000
          1457.854166666667000000
          5.291666666666667000
          1304.395833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Lines.Strings = (
          
            '  2) A n'#227'o impugna'#231#227'o deste pedido de compra no prazo de 48 hora' +
            's, representa a '
          '      aceita'#231#227'o de todas as condi'#231#245'es nele expressas.')
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object MM_Responsavel: TQRMemo
        Left = 551
        Top = 52
        Width = 212
        Height = 83
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          219.604166666666700000
          1457.854166666667000000
          137.583333333333300000
          560.916666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo24: TQRMemo
        Left = 2
        Top = 2
        Width = 552
        Height = 51
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          134.937500000000000000
          5.291666666666667000
          5.291666666666667000
          1460.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Lines.Strings = (
          
            '  1)Reservamos-nos o direito de considerar este pedido de compra' +
            ' sem efeito caso n'#227'o haja'
          
            '     assinatura do comprador ou as mercadorias venham em desacor' +
            'do ou fora do prazo '
          '     estipulado para entrega'
          '  ')
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object MM_Obs: TQRMemo
        Left = 2
        Top = 52
        Width = 552
        Height = 83
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          219.604166666666700000
          5.291666666666667000
          137.583333333333300000
          1460.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRMemo49: TQRMemo
        Left = 762
        Top = 52
        Width = 282
        Height = 83
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          219.604166666666700000
          2016.125000000000000000
          137.583333333333300000
          746.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel128: TQRLabel
        Left = 768
        Top = 56
        Width = 88
        Height = 17
        Size.Values = (
          44.979166666666670000
          2032.000000000000000000
          148.166666666666700000
          232.833333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Total do Pedido'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel129: TQRLabel
        Left = 768
        Top = 77
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          2032.000000000000000000
          203.729166666666700000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Total Impostos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel131: TQRLabel
        Left = 768
        Top = 118
        Width = 62
        Height = 17
        Size.Values = (
          44.979166666666670000
          2032.000000000000000000
          312.208333333333300000
          164.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_VL_Pedido: TQRLabel
        Left = 890
        Top = 56
        Width = 150
        Height = 17
        Size.Values = (
          44.979166666666670000
          2354.791666666667000000
          148.166666666666700000
          396.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_VL_Impostos: TQRLabel
        Left = 890
        Top = 78
        Width = 150
        Height = 17
        Size.Values = (
          44.979166666666670000
          2354.791666666667000000
          206.375000000000000000
          396.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_VL_Total: TQRLabel
        Left = 890
        Top = 118
        Width = 150
        Height = 17
        Size.Values = (
          44.979166666666670000
          2354.791666666667000000
          312.208333333333400000
          396.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object QRLabel7: TQRLabel
        Left = 556
        Top = 56
        Width = 147
        Height = 17
        Size.Values = (
          44.979166666666670000
          1471.083333333333000000
          148.166666666666700000
          388.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Assinatura do Comprador'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      object Lb_Responsavel: TQRLabel
        Left = 556
        Top = 118
        Width = 51
        Height = 17
        Size.Values = (
          44.979166666666670000
          1471.083333333333000000
          312.208333333333300000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Merconet'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
  end
  object Qr_Fornecedor: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (EMP_CODIGO=:EMP_CODIGO)')
    Left = 264
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Pedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_PEDIDO tb_pedido'
      '    LEFT OUTER JOIN TB_EMPRESA tb_transportadora'
      '   ON (tb_transportadora.EMP_CODIGO = tb_pedido.PED_CODTRP)'
      'WHERE (PED_TIPO = 2) AND (PED_CODIGO=:PED_CODIGO)')
    Left = 312
    Top = 16
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
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      ' ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  MED_DESCRICAO,'
      '  ITF_QTDE, '
      '  ITF_VL_UNIT,'
      '  (ITF_QTDE * ITF_VL_UNIT) AS ITF_VL_SUBTOTAL,'
      '  PRO_DESCRICAO,'
      '  ITF_AQ_IPI,'
      '  ITF_AQ_ICMS'
      'FROM TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO tb_produto'
      '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      '  INNER JOIN TB_MEDIDA tb_medida'
      '  ON (tb_medida.MED_CODIGO = PRO_CODMED)'
      'WHERE (ITF_CODPED=:ITF_CODPED)')
    Left = 357
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODPED'
        ParamType = ptUnknown
      end>
  end
end
