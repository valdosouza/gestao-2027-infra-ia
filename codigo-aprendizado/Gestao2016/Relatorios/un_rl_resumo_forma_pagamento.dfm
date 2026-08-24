object Rl_RESUMO_FORMA_Pagto: TRl_RESUMO_FORMA_Pagto
  Left = 301
  Top = 107
  Caption = 'Resumo Forma de Pagamento'
  ClientHeight = 548
  ClientWidth = 948
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
    Left = 9
    Top = 8
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_CtasReceber
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
      100.012500000000000000
      2970.000000000000000000
      100.012500000000000000
      2100.000000000000000000
      26.458333333333330000
      26.458333333333330000
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
    ReportTitle = 'Resumo Forma de Pagamento'
    ShowProgress = False
    SnapToGrid = True
    Units = Pixels
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
      Left = 10
      Top = 38
      Width = 774
      Height = 120
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        317.500000000000000000
        2047.875000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRLabel5: TQRLabel
        Left = 0
        Top = 102
        Width = 113
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          269.875000000000000000
          298.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Contas '#224' Receber'
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
        Left = 0
        Top = 84
        Width = 778
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          222.250000000000000000
          2058.458333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 
          '________________________________________________________________' +
          '_______________________________________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRBand4: TQRBand
      Left = 10
      Top = 158
      Width = 774
      Height = 26
      AlignToBottom = False
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = True
      ParentFont = False
      Size.Values = (
        68.791666666666670000
        2047.875000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRLabel14: TQRLabel
        Left = 6
        Top = 3
        Width = 279
        Height = 17
        Size.Values = (
          44.979166666666700000
          15.875000000000000000
          7.937500000000000000
          738.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cliente'
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
      object QRLabel50: TQRLabel
        Left = 5
        Top = 3
        Width = 279
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          7.937500000000000000
          738.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Forma de Pagamento'
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
    object Grupo1: TQRGroup
      Left = 10
      Top = 184
      Width = 774
      Height = 23
      Frame.DrawTop = True
      Frame.DrawBottom = True
      AlignToBottom = False
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
        60.854166666666670000
        2047.875000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_CtasReceber.FPT_DESCRICAO'
      FooterBand = QRBand6
      Master = Qrpt
      ReprintOnNewPage = False
      object QRExpr5: TQRExpr
        Left = 639
        Top = 32
        Width = 44
        Height = 17
        Size.Values = (
          44.979166666666670000
          1690.687500000000000000
          84.666666666666680000
          116.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRDBText2: TQRDBText
        Left = 8
        Top = 4
        Width = 303
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          10.583333333333330000
          801.687500000000100000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_CtasReceber
        DataField = 'FPT_DESCRICAO'
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
      object QRLabel15: TQRLabel
        Left = 1020
        Top = 3
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          2698.750000000000000000
          7.937500000000000000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Parcela'
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
      object QRDBText4: TQRDBText
        Left = 8
        Top = 4
        Width = 303
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          10.583333333333330000
          801.687500000000100000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_CtasReceber
        DataField = 'FPT_DESCRICAO'
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
      object QRLabel1: TQRLabel
        Left = 624
        Top = 3
        Width = 148
        Height = 17
        Size.Values = (
          44.979166666666670000
          1651.000000000000000000
          7.937500000000000000
          391.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor'
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
    object QRBand5: TQRBand
      Left = 10
      Top = 207
      Width = 774
      Height = 22
      Frame.DrawBottom = True
      Frame.Style = psDot
      AlignToBottom = False
      BeforePrint = DetalheBeforePrint
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
        58.208333333333330000
        2047.875000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRLabel28: TQRLabel
        Left = 938
        Top = 1
        Width = 77
        Height = 17
        Size.Values = (
          44.979166666666670000
          2481.791666666667000000
          2.645833333333333000
          203.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Vencimento'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel29: TQRLabel
        Left = 824
        Top = 1
        Width = 106
        Height = 17
        Size.Values = (
          44.979166666666670000
          2180.166666666667000000
          2.645833333333333000
          280.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'E_Pedido'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel30: TQRLabel
        Left = 1020
        Top = 1
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          2698.750000000000000000
          2.645833333333333000
          193.145833333333300000)
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
        FontSize = 8
      end
      object lbl_operacao: TQRLabel
        Left = 32
        Top = 3
        Width = 429
        Height = 15
        Size.Values = (
          39.687500000000000000
          84.666666666666680000
          7.937500000000000000
          1135.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LBL_OPERACAO'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText5: TQRDBText
        Left = 623
        Top = 4
        Width = 147
        Height = 15
        Size.Values = (
          39.687500000000000000
          1648.354166666667000000
          10.583333333333330000
          388.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_CtasReceber
        DataField = 'SUM'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    object QRBand6: TQRBand
      Left = 10
      Top = 229
      Width = 774
      Height = 63
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = QRBand6BeforePrint
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
        166.687500000000000000
        2047.875000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRLabel31: TQRLabel
        Left = 813
        Top = 1
        Width = 99
        Height = 17
        Size.Values = (
          44.979166666666670000
          2151.062500000000000000
          2.645833333333333000
          261.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor da D'#237'vida'
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
      object QRLabel32: TQRLabel
        Left = 976
        Top = 1
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          2582.333333333333000000
          2.645833333333333000
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
        Left = 456
        Top = 3
        Width = 148
        Height = 17
        Size.Values = (
          44.979166666666670000
          1206.500000000000000000
          7.937500000000000000
          391.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo:'
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
      object lbl_saldo: TQRLabel
        Left = 624
        Top = 3
        Width = 148
        Height = 17
        Size.Values = (
          44.979166666666670000
          1651.000000000000000000
          7.937500000000000000
          391.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo:'
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
    object QRBand7: TQRBand
      Left = 10
      Top = 292
      Width = 774
      Height = 129
      Frame.DrawTop = True
      AlignToBottom = False
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
        341.312500000000000000
        2047.875000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel33: TQRLabel
        Left = 813
        Top = 5
        Width = 135
        Height = 17
        Size.Values = (
          44.979166666666670000
          2151.062500000000000000
          13.229166666666670000
          357.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total da D'#237'vida'
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
        Left = 977
        Top = 5
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          2584.979166666667000000
          13.229166666666670000
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
      object QRLabel35: TQRLabel
        Left = 4
        Top = 5
        Width = 153
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          13.229166666666670000
          404.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Par'#226'metros da Consulta'
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
        Left = 4
        Top = 47
        Width = 77
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          124.354166666666700000
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
      object QRLabel37: TQRLabel
        Left = 180
        Top = 47
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          476.250000000000000000
          124.354166666666700000
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
      object QRLabel38: TQRLabel
        Left = 4
        Top = 63
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          166.687500000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome do Cliente:'
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
      object Lb_Data_Ini: TQRLabel
        Left = 84
        Top = 48
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          222.250000000000000000
          127.000000000000000000
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
      object Lb_Data_Fim: TQRLabel
        Left = 253
        Top = 49
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          669.395833333333300000
          129.645833333333300000
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
      object Lb_Cliente: TQRLabel
        Left = 121
        Top = 63
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          320.145833333333300000
          166.687500000000000000
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
        Left = 4
        Top = 30
        Width = 129
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          79.375000000000000000
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
      object Lb_Tipo_Doc: TQRLabel
        Left = 132
        Top = 30
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          349.250000000000000000
          79.375000000000000000
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
      object QRLabel44: TQRLabel
        Left = 4
        Top = 106
        Width = 88
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          280.458333333333300000
          232.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Classifica'#231#227'o:'
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
      object Lb_Tipo_Rl: TQRLabel
        Left = 96
        Top = 106
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          254.000000000000000000
          280.458333333333300000
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
      object lb_form_pagto: TQRLabel
        Left = 150
        Top = 83
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          396.875000000000000000
          219.604166666666700000
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
      object QRLabel47: TQRLabel
        Left = 4
        Top = 83
        Width = 143
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          219.604166666666700000
          378.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Forma de Pagamento:'
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
    object QRBand8: TQRBand
      Left = 10
      Top = 421
      Width = 774
      Height = 28
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        74.083333333333330000
        2047.875000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageFooter
      object QRSysData3: TQRSysData
        Left = 150
        Top = 7
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          396.875000000000000000
          18.520833333333330000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDateTime
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
      object QRSysData4: TQRSysData
        Left = 1010
        Top = 7
        Width = 44
        Height = 17
        Size.Values = (
          44.979166666666670000
          2672.291666666667000000
          18.520833333333330000
          116.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Data = qrsPageNumber
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel48: TQRLabel
        Left = 942
        Top = 7
        Width = 64
        Height = 17
        Size.Values = (
          44.979166666666670000
          2492.375000000000000000
          18.520833333333330000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagina N'#186
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
      object QRLabel49: TQRLabel
        Left = 8
        Top = 8
        Width = 139
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          21.166666666666670000
          367.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Relat'#243'rio emitido em:'
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
  end
  object Qr_CtasReceber: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT sum(FIN_VL_parcela),FPT_DESCRICAO,fin_operacao'
      ' FROM TB_FINANCEIRO tb_financeiro'
      
        '   INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal                     ' +
        '             '
      
        '   ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)    ' +
        '             '
      ''
      
        '   INNER JOIN TB_EMPRESA Tb_empresa                             ' +
        '             '
      
        '   ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP)       ' +
        '             '
      ''
      
        '   LEFT OUTER JOIN TB_PEDIDO tb_pedido                          ' +
        '             '
      
        '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED )        ' +
        '             '
      ''
      
        '   LEFT JOIN TB_ENDERECO tb_endereco                            ' +
        '             '
      
        '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)          ' +
        '             '
      ''
      
        '    INNER JOIN TB_FORMAPAGTO tb_formapagto                      ' +
        '             '
      
        '    ON (tb_formapagto.FPT_CODIGO = tb_financeiro.FIN_CODFPG)    ' +
        '             '
      ''
      
        '    LEFT OUTER JOIN TB_BOLETO tb_boleto                         ' +
        '             '
      
        '    ON (tb_boleto.BLT_CODQTC = tb_financeiro.FIN_CODQTC)        ' +
        '             '
      ''
      
        '    LEFT OUTER JOIN TB_CONTABANCARIA tb_contabancaria           ' +
        '             '
      
        '    ON (tb_contabancaria.CTB_CODIGO = tb_boleto.BLT_CODCTB)     ' +
        '             '
      ''
      
        '    LEFT OUTER JOIN TB_EMPRESA tb_banco                         ' +
        '             '
      
        '    ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO)      ' +
        '             '
      
        ' WHERE((FIN_TIPO = '#39'RA'#39') OR (FIN_TIPO = '#39'RM'#39')) AND (END_PRINCIPA' +
        'L = '#39'S'#39') AND (FIN_CODMHA=:FIN_CODMHA)'
      ' group by  FPT_DESCRICAO,fin_operacao'
      'ORDER BY FPT_DESCRICAO'
      '')
    Left = 146
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODMHA'
        ParamType = ptUnknown
      end>
    object Qr_CtasReceberFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Origin = 'TB_FORMAPAGTO.FPT_DESCRICAO'
      Required = True
      Size = 51
    end
    object Qr_CtasReceberFIN_OPERACAO: TStringField
      FieldName = 'FIN_OPERACAO'
      Origin = 'TB_FINANCEIRO.FIN_OPERACAO'
      FixedChar = True
      Size = 1
    end
    object Qr_CtasReceberSUM: TBCDField
      FieldName = 'SUM'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
  end
end
