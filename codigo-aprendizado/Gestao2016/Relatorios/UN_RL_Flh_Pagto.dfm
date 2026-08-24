object RL_Flh_Pagto: TRL_Flh_Pagto
  Left = 96
  Top = 184
  Caption = 'Pedido de Venda'
  ClientHeight = 442
  ClientWidth = 853
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
    Left = 8
    Top = -2
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Folha
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
      Top = 26
      Width = 739
      Height = 78
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        206.375000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Folha.FPT_CODCLB'
      FooterBand = Rodape
      Master = Qrpt
      ReprintOnNewPage = False
      object QRShape6: TQRShape
        Left = 79
        Top = 55
        Width = 418
        Height = 23
        Frame.Color = clBtnHighlight
        Frame.Style = psClear
        Size.Values = (
          60.854166666666680000
          209.020833333333300000
          145.520833333333300000
          1105.958333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 0
        Top = 55
        Width = 80
        Height = 23
        Size.Values = (
          60.854166666666680000
          0.000000000000000000
          145.520833333333300000
          211.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape8: TQRShape
        Left = 496
        Top = 55
        Width = 122
        Height = 23
        Size.Values = (
          60.854166666666680000
          1312.333333333333000000
          145.520833333333300000
          322.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 617
        Top = 55
        Width = 122
        Height = 23
        Size.Values = (
          60.854166666666680000
          1632.479166666667000000
          145.520833333333300000
          322.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clSilver
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel18: TQRLabel
        Left = 623
        Top = 58
        Width = 106
        Height = 17
        Size.Values = (
          44.979166666666670000
          1648.354166666667000000
          153.458333333333300000
          280.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Vencimentos'
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
        Left = 529
        Top = 58
        Width = 59
        Height = 17
        Size.Values = (
          44.979166666666670000
          1399.645833333333000000
          153.458333333333300000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Desconto'
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
        Left = 83
        Top = 58
        Width = 369
        Height = 17
        Size.Values = (
          44.979166666666670000
          219.604166666666700000
          153.458333333333300000
          976.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Evento / Lan'#231'amento'
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
        Left = 5
        Top = 58
        Width = 48
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          153.458333333333300000
          127.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Data'
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
        Left = 6
        Top = 28
        Width = 84
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          74.083333333333320000
          222.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Colaborador:'
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
      object Lb_Clb_Nome: TQRLabel
        Left = 92
        Top = 28
        Width = 505
        Height = 17
        Size.Values = (
          44.979166666666670000
          243.416666666666700000
          74.083333333333340000
          1336.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Clb_Nome'
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
      object QRLabel33: TQRLabel
        Left = 8
        Top = 2
        Width = 110
        Height = 23
        Size.Values = (
          60.854166666666680000
          21.166666666666670000
          5.291666666666667000
          291.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Refer'#234'ncia:'
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
      object Lb_Referencia: TQRLabel
        Left = 126
        Top = 2
        Width = 138
        Height = 23
        Size.Values = (
          60.854166666666680000
          333.375000000000000000
          5.291666666666667000
          365.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Referencia'
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
    end
    object Rodape: TQRBand
      Left = 28
      Top = 126
      Width = 739
      Height = 116
      Frame.Style = psDot
      AlignToBottom = False
      BeforePrint = RodapeBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        306.916666666666700000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object Lb_TL_Vencimento: TQRLabel
        Left = 616
        Top = 2
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          5.291666666666667000
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
      object Lb_TL_Desconto: TQRLabel
        Left = 616
        Top = 18
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          47.625000000000000000
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
        Left = 466
        Top = 2
        Width = 146
        Height = 17
        Size.Values = (
          44.979166666666670000
          1232.958333333333000000
          5.291666666666667000
          386.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Total Dos Vencimentos'
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
        Left = 484
        Top = 18
        Width = 127
        Height = 17
        Size.Values = (
          44.979166666666670000
          1280.583333333333000000
          47.625000000000000000
          336.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Total dos Descontos'
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
        Left = 8
        Top = 93
        Width = 729
        Height = 20
        Size.Values = (
          52.916666666666660000
          21.166666666666670000
          246.062500000000000000
          1928.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          '____/____/________    - Assinatura: ____________________________' +
          '_________________________________________'
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
        Left = 526
        Top = 34
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1391.708333333333000000
          89.958333333333320000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Total Liquido'
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
      object Lb_VL_Liquido: TQRLabel
        Left = 616
        Top = 34
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          89.958333333333340000
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
      object QRLabel2: TQRLabel
        Left = 6
        Top = 57
        Width = 490
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          150.812500000000000000
          1296.458333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'DECLARO TER RECEBIDO A IMPORT'#194'NCIA LIQUIDA DESCRITA NESTE RECIBO'
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
      Left = 28
      Top = 104
      Width = 739
      Height = 22
      AlignToBottom = False
      BeforePrint = Bd_DetalheStrBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        1955.270833333333000000)
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
      object QRShape4: TQRShape
        Left = 79
        Top = -1
        Width = 418
        Height = 23
        Frame.Color = clBtnHighlight
        Frame.Style = psClear
        Size.Values = (
          60.854166666666680000
          209.020833333333300000
          -2.645833333333333000
          1105.958333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Style = bsClear
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape9: TQRShape
        Left = 617
        Top = -1
        Width = 122
        Height = 23
        Size.Values = (
          60.854166666666680000
          1632.479166666667000000
          -2.645833333333333000
          322.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 496
        Top = -1
        Width = 122
        Height = 23
        Size.Values = (
          60.854166666666680000
          1312.333333333333000000
          -2.645833333333333000
          322.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 0
        Top = -1
        Width = 80
        Height = 23
        Size.Values = (
          60.854166666666680000
          0.000000000000000000
          -2.645833333333333000
          211.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object Lb_Data: TQRLabel
        Left = 3
        Top = 1
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          2.645833333333333000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Data'
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
      object Lb_Evento: TQRLabel
        Left = 86
        Top = 1
        Width = 369
        Height = 17
        Size.Values = (
          44.979166666666670000
          227.541666666666700000
          2.645833333333333000
          976.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Evento / Lan'#231'amento'
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
      object Lb_VL_Desconto: TQRLabel
        Left = 532
        Top = 1
        Width = 82
        Height = 17
        Size.Values = (
          44.979166666666670000
          1407.583333333333000000
          2.645833333333333000
          216.958333333333400000)
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
      object Lb_VL_Vencimento: TQRLabel
        Left = 623
        Top = 1
        Width = 110
        Height = 17
        Size.Values = (
          44.979166666666670000
          1648.354166666667000000
          2.645833333333333000
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
    end
  end
  object Qr_Folha: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_FOLHAPAGTO Tb_flhpagto'
      '   INNER JOIN TB_COLABORADOR tb_colaborador'
      '   ON (tb_colaborador.CLB_CODIGO = Tb_flhpagto.FPT_CODCLB)'
      'WHERE (FPT_CODCLB=:FPT_CODCLB) AND'
      '(FPT_MES=:FPT_MES) AND (FPT_ANO=:FPT_ANO)'
      'AND (CLB_CODMHA=:CLB_CODMHA)')
    Left = 360
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FPT_CODCLB'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPT_MES'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPT_ANO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CLB_CODMHA'
        ParamType = ptUnknown
      end>
  end
end
