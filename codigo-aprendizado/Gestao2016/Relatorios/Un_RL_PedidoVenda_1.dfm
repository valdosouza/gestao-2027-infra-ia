object RL_PedidoVenda_1: TRL_PedidoVenda_1
  Left = 239
  Top = 31
  Caption = 'Pedido de Venda'
  ClientHeight = 614
  ClientWidth = 1026
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
    Width = 952
    Height = 1347
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
    ReportTitle = 'Pedido de Venda'
    ShowProgress = False
    SnapToGrid = False
    Units = Pixels
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
    object Grupo: TQRGroup
      Left = 34
      Top = 179
      Width = 886
      Height = 189
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        416.718750000000000000
        1953.506944444444000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Ordem.OVS_VIA'
      FooterBand = Rodape
      Master = Qrpt
      ReprintOnNewPage = False
      object QRMemo10: TQRMemo
        Left = 742
        Top = 161
        Width = 143
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          59.531250000000000000
          1636.006944444444000000
          354.982638888888900000
          315.295138888888900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo9: TQRMemo
        Left = 631
        Top = 161
        Width = 110
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          59.531250000000000000
          1391.267361111111000000
          354.982638888888900000
          242.534722222222200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo11: TQRMemo
        Left = 572
        Top = 161
        Width = 59
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          59.531250000000000000
          1261.180555555556000000
          354.982638888888900000
          130.086805555555600000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo8: TQRMemo
        Left = 472
        Top = 161
        Width = 99
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          59.531250000000000000
          1040.694444444445000000
          354.982638888888900000
          218.281250000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo7: TQRMemo
        Left = 69
        Top = 161
        Width = 403
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          59.531250000000000000
          152.135416666666700000
          354.982638888888900000
          888.559027777777800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRMemo6: TQRMemo
        Left = 0
        Top = 161
        Width = 68
        Height = 27
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          59.531250000000000000
          0.000000000000000000
          354.982638888888900000
          149.930555555555600000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clSilver
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRLabel18: TQRLabel
        Left = 748
        Top = 164
        Width = 128
        Height = 20
        Size.Values = (
          44.097222222222230000
          1649.236111111111000000
          361.597222222222300000
          282.222222222222200000)
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
        Left = 642
        Top = 163
        Width = 82
        Height = 20
        Size.Values = (
          44.097222222222220000
          1415.520833333333000000
          359.392361111111100000
          180.798611111111100000)
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
        Left = 475
        Top = 163
        Width = 90
        Height = 20
        Size.Values = (
          44.097222222222220000
          1047.309027777778000000
          359.392361111111100000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade'
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
        Left = 76
        Top = 164
        Width = 388
        Height = 20
        Size.Values = (
          44.097222222222230000
          167.569444444444400000
          361.597222222222300000
          855.486111111111200000)
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
        Left = 6
        Top = 164
        Width = 58
        Height = 20
        Size.Values = (
          44.097222222222230000
          13.229166666666670000
          361.597222222222300000
          127.881944444444500000)
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
        Left = 10
        Top = 34
        Width = 83
        Height = 22
        Size.Values = (
          48.506944444444440000
          22.048611111111110000
          74.965277777777790000
          183.003472222222200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 10
        Top = 53
        Width = 83
        Height = 22
        Size.Values = (
          48.506944444444440000
          22.048611111111110000
          116.857638888888900000
          183.003472222222200000)
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
        Left = 10
        Top = 72
        Width = 83
        Height = 22
        Size.Values = (
          48.506944444444440000
          22.048611111111110000
          158.750000000000000000
          183.003472222222200000)
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
      object Lb_CPFCNPJ: TQRLabel
        Left = 10
        Top = 91
        Width = 83
        Height = 22
        Size.Values = (
          48.506944444444440000
          22.048611111111110000
          200.642361111111100000
          183.003472222222200000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CPFCNPJ'
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
        Left = 96
        Top = 53
        Width = 414
        Height = 20
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
        Left = 96
        Top = 34
        Width = 391
        Height = 20
        Size.Values = (
          44.979166666666670000
          211.666666666666700000
          74.083333333333340000
          862.541666666666900000)
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
        Left = 96
        Top = 72
        Width = 395
        Height = 20
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
        Left = 96
        Top = 91
        Width = 84
        Height = 22
        Size.Values = (
          48.506944444444440000
          211.666666666666700000
          200.642361111111100000
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
      object Lb_Cli_cep: TQRLabel
        Left = 558
        Top = 53
        Width = 89
        Height = 22
        Size.Values = (
          48.506944444444440000
          1230.312500000000000000
          116.857638888888900000
          196.232638888888900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '81.770-090'
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
        Left = 558
        Top = 72
        Width = 323
        Height = 20
        Size.Values = (
          44.097222222222230000
          1230.312500000000000000
          158.750000000000000000
          712.170138888889100000)
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
        Left = 558
        Top = 91
        Width = 97
        Height = 22
        Size.Values = (
          48.506944444444440000
          1230.312500000000000000
          200.642361111111100000
          213.871527777777800000)
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
      object QRLabel8: TQRLabel
        Left = 511
        Top = 53
        Width = 42
        Height = 22
        Size.Values = (
          48.506944444444440000
          1126.684027777778000000
          116.857638888888900000
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
        Left = 462
        Top = 72
        Width = 90
        Height = 22
        Size.Values = (
          48.506944444444440000
          1018.645833333333000000
          158.750000000000000000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Cidade/UF :'
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
        Left = 437
        Top = 91
        Width = 115
        Height = 22
        Size.Values = (
          48.506944444444440000
          963.524305555555600000
          200.642361111111100000
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
        Left = 9
        Top = 135
        Width = 44
        Height = 22
        Size.Values = (
          48.506944444444440000
          19.843750000000000000
          297.656250000000000000
          97.013888888888890000)
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
        Left = 54
        Top = 134
        Width = 121
        Height = 20
        Size.Values = (
          44.097222222222230000
          119.062500000000000000
          295.451388888888900000
          266.788194444444400000)
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
        Left = 205
        Top = 136
        Width = 35
        Height = 22
        Size.Values = (
          48.506944444444440000
          451.996527777777800000
          299.861111111111100000
          77.170138888888890000)
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
        Left = 250
        Top = 135
        Width = 121
        Height = 20
        Size.Values = (
          44.097222222222230000
          551.215277777777700000
          297.656250000000000000
          266.788194444444400000)
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
        Left = 405
        Top = 136
        Width = 61
        Height = 22
        Size.Values = (
          48.506944444444440000
          892.968750000000000000
          299.861111111111100000
          134.496527777777800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Celular:'
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
        Left = 472
        Top = 136
        Width = 121
        Height = 20
        Size.Values = (
          44.097222222222230000
          1040.694444444445000000
          299.861111111111200000
          266.788194444444400000)
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
        Left = 10
        Top = 112
        Width = 83
        Height = 22
        Size.Values = (
          48.506944444444440000
          22.048611111111110000
          246.944444444444400000
          183.003472222222200000)
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
      object Lb_Cli_Email: TQRLabel
        Left = 96
        Top = 112
        Width = 92
        Height = 22
        Size.Values = (
          48.506944444444440000
          211.666666666666700000
          246.944444444444400000
          202.847222222222200000)
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
      object QRLabel48: TQRLabel
        Left = 473
        Top = 112
        Width = 80
        Height = 22
        Size.Values = (
          48.506944444444440000
          1042.899305555556000000
          246.944444444444400000
          176.388888888888900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
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
      object Lb_Cli_Vendedor: TQRLabel
        Left = 558
        Top = 112
        Width = 320
        Height = 20
        Size.Values = (
          44.979166666666700000
          1230.312500000000000000
          246.062500000000000000
          706.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
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
      object Lb_Pedido: TQRLabel
        Left = 10
        Top = 2
        Width = 101
        Height = 28
        Size.Values = (
          60.854166666666680000
          21.166666666666670000
          5.291666666666667000
          222.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Revis'#227'o:'
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
        Left = 114
        Top = 2
        Width = 166
        Height = 28
        Size.Values = (
          60.854166666666680000
          251.354166666666700000
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
        Left = 558
        Top = 16
        Width = 59
        Height = 22
        Size.Values = (
          48.506944444444440000
          1230.312500000000000000
          35.277777777777780000
          130.086805555555600000)
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
        Left = 514
        Top = 16
        Width = 41
        Height = 22
        Size.Values = (
          48.506944444444440000
          1133.298611111111000000
          35.277777777777780000
          90.399305555555560000)
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
      object QRLabel6: TQRLabel
        Left = 574
        Top = 163
        Width = 51
        Height = 20
        Size.Values = (
          44.097222222222230000
          1265.590277777778000000
          359.392361111111200000
          112.447916666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Emb.'
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
      Left = 34
      Top = 396
      Width = 886
      Height = 170
      Frame.Style = psDot
      AlignToBottom = False
      BeforePrint = RodapeBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        374.826388888888900000
        1953.506944444444000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object Lb_NItens: TQRLabel
        Left = 739
        Top = 31
        Width = 140
        Height = 20
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
        Left = 739
        Top = 50
        Width = 140
        Height = 20
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
        Left = 739
        Top = 113
        Width = 140
        Height = 20
        Size.Values = (
          44.097222222222230000
          1629.392361111111000000
          249.149305555555600000
          308.680555555555600000)
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
        Left = 566
        Top = 31
        Width = 170
        Height = 20
        Size.Values = (
          44.097222222222230000
          1247.951388888889000000
          68.350694444444440000
          374.826388888888800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 566
        Top = 50
        Width = 170
        Height = 22
        Size.Values = (
          48.506944444444440000
          1247.951388888889000000
          110.243055555555600000
          374.826388888888800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 566
        Top = 113
        Width = 170
        Height = 22
        Size.Values = (
          48.506944444444440000
          1247.951388888889000000
          249.149305555555600000
          374.826388888888800000)
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
        Left = 667
        Top = 131
        Width = 66
        Height = 28
        Size.Values = (
          61.736111111111110000
          1470.642361111111000000
          288.836805555555600000
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
        Left = 739
        Top = 131
        Width = 140
        Height = 28
        Size.Values = (
          61.736111111111120000
          1629.392361111111000000
          288.836805555555500000
          308.680555555555600000)
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
        Left = 7
        Top = 10
        Width = 202
        Height = 22
        Size.Values = (
          48.506944444444440000
          15.434027777777780000
          22.048611111111110000
          445.381944444444400000)
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
        Left = 211
        Top = 10
        Width = 667
        Height = 20
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
        Left = 566
        Top = 94
        Width = 170
        Height = 22
        Size.Values = (
          48.506944444444440000
          1247.951388888889000000
          207.256944444444400000
          374.826388888888800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
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
        Left = 739
        Top = 94
        Width = 140
        Height = 20
        Size.Values = (
          44.097222222222230000
          1629.392361111111000000
          207.256944444444400000
          308.680555555555600000)
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
        Left = 7
        Top = 30
        Width = 98
        Height = 22
        Size.Values = (
          48.506944444444440000
          15.434027777777780000
          66.145833333333330000
          216.076388888888900000)
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
        Left = 2
        Top = 49
        Width = 558
        Height = 17
        Size.Values = (
          37.482638888888890000
          4.409722222222222000
          108.038194444444400000
          1230.312500000000000000)
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
      object QRLabel7: TQRLabel
        Left = 566
        Top = 72
        Width = 170
        Height = 22
        Size.Values = (
          48.506944444444440000
          1247.951388888889000000
          158.750000000000000000
          374.826388888888800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'SUBTOTAL'
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
      object E_VL_sUBTOTAL: TQRLabel
        Left = 739
        Top = 72
        Width = 140
        Height = 20
        Size.Values = (
          44.097222222222230000
          1629.392361111111000000
          158.750000000000000000
          308.680555555555600000)
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
    object Bd_DetalheStr: TQRStringsBand
      Left = 34
      Top = 368
      Width = 886
      Height = 28
      AlignToBottom = False
      BeforePrint = Bd_DetalheStrBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        61.736111111111110000
        1953.506944444444000000)
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
      object QRMemo3: TQRMemo
        Left = 473
        Top = 0
        Width = 98
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          61.736111111111120000
          1042.899305555556000000
          0.000000000000000000
          216.076388888888900000)
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
      object QRMemo5: TQRMemo
        Left = 742
        Top = 0
        Width = 143
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          61.736111111111120000
          1636.006944444444000000
          0.000000000000000000
          315.295138888888900000)
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
      object QRMemo4: TQRMemo
        Left = 632
        Top = 0
        Width = 109
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          61.736111111111120000
          1393.472222222222000000
          0.000000000000000000
          240.329861111111100000)
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
      object QRMemo12: TQRMemo
        Left = 572
        Top = 0
        Width = 59
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          61.736111111111120000
          1261.180555555556000000
          0.000000000000000000
          130.086805555555600000)
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
      object QRMemo2: TQRMemo
        Left = 69
        Top = 0
        Width = 403
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          61.736111111111120000
          152.135416666666700000
          0.000000000000000000
          888.559027777777800000)
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
      object QRMemo1: TQRMemo
        Left = 0
        Top = 0
        Width = 68
        Height = 28
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          61.736111111111120000
          0.000000000000000000
          0.000000000000000000
          149.930555555555600000)
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
      object Lb_SubTotal: TQRLabel
        Left = 748
        Top = 4
        Width = 132
        Height = 20
        Size.Values = (
          44.097222222222230000
          1649.236111111111000000
          8.819444444444444000
          291.041666666666700000)
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
      object Lb_VlUnit: TQRLabel
        Left = 638
        Top = 4
        Width = 96
        Height = 20
        Size.Values = (
          44.097222222222230000
          1406.701388888889000000
          8.819444444444444000
          211.666666666666700000)
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
      object Lb_Qtde: TQRLabel
        Left = 483
        Top = 4
        Width = 80
        Height = 20
        Size.Values = (
          44.097222222222220000
          1064.947916666667000000
          8.819444444444444000
          176.388888888888900000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
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
      object Lb_DescricaoProduto: TQRLabel
        Left = 76
        Top = 4
        Width = 387
        Height = 20
        Size.Values = (
          44.097222222222230000
          167.569444444444400000
          8.819444444444444000
          853.281250000000000000)
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
      object Lb_Codigo: TQRLabel
        Left = 6
        Top = 4
        Width = 55
        Height = 20
        Size.Values = (
          44.097222222222230000
          13.229166666666670000
          8.819444444444444000
          121.267361111111100000)
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
      object lb_abreviatura: TQRLabel
        Left = 575
        Top = 4
        Width = 50
        Height = 20
        Size.Values = (
          44.097222222222230000
          1267.795138888889000000
          8.819444444444444000
          110.243055555555600000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'abreviatura'
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
    object Cabecalho: TQRBand
      Left = 34
      Top = 32
      Width = 886
      Height = 147
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        324.114583333333300000
        1953.506944444444000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
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
        'END_FONE,  END_BAIRRO, END_CELULAR, CDD_DESCRICAO,'
      
        'END_FAX,EMP_CNPJ, EMP_INSC_EST, EMP_EMAIL, CLB_NOME, PED_QT_PROD' +
        'UTO, PED_VL_FRETE, PED_VL_DESCONTO, PED_VL_PEDIDO, '
      
        'FPT_DESCRICAO, PED_PRAZO, ped_obs, PED_DT_ALTERA, PED_FATURADO, ' +
        'PED_CODMHA, END_NUMERO, UFE_SIGLA, PED_VL_PRODUTO,'
      'PED_CODIGO'
      'FROM  TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      '   LEFT OUTER JOIN TB_COLABORADOR tb_colaborador'
      '   ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)'
      '   LEFT OUTER JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (PED_CODIGO=:PED_CODIGO) AND(PED_CODMHA=:PED_CODMHA)')
    Left = 360
    Top = 136
    ParamData = <
      item
        DataType = ftString
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'PED_CODMHA'
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
      '   PRO_CODIGOFAB,'
      '   ITF_QTDE,  '
      '   ITF_VL_UNIT,'
      '   ITF_QTDE * ITF_VL_UNIT as ITF_VL_LINHA,'
      '   PRO_DESCRICAO,'
      '   EMB_ABREVIATURA'
      'FROM  TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_EMBALAGEM tb_embalagem'
      '   ON (tb_produto.PRO_CODEMB = tb_embalagem.EMB_CODIGO)'
      'WHERE ITF_CODPED =:ITF_CODPED  AND (ITF_OPER = '#39'V'#39')'
      'ORDER BY PRO_DESCRICAO '
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 312
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODPED'
        ParamType = ptUnknown
      end>
  end
  object DataSource1: TDataSource
    DataSet = Qr_Ordem
    Left = 408
    Top = 112
  end
end
