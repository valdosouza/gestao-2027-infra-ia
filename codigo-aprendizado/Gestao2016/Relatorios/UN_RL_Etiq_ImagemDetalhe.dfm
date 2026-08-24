object RL_Etiq_ImagemDetalhe: TRL_Etiq_ImagemDetalhe
  Left = 289
  Top = 181
  Caption = 'Relat'#243'rio de Etiquetas de Produtos '
  ClientHeight = 561
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 8
    Top = 0
    Width = 794
    Height = 1123
    ShowingPreview = True
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
      'QR_ETIQUETA'
      'QRSTRINGBAND')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    OnNeedData = QrptNeedData
    Options = []
    Page.Columns = 2
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      80.000000000000000000
      2970.000000000000000000
      80.000000000000000000
      2100.000000000000000000
      80.000000000000000000
      80.000000000000000000
      100.000000000000000000)
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
    ReportTitle = 'Etiqueta'
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
    StartNewPageInComposite = True
    object qrStringBand: TQRStringsBand
      Left = 30
      Top = 30
      Width = 348
      Height = 176
      AlignToBottom = False
      BeforePrint = qrStringBandBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        465.666666666666700000
        920.750000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      Items.Strings = (
        '1'
        '2')
      PrintBefore = False
      object QRShape: TQRShape
        Left = 3
        Top = 3
        Width = 288
        Height = 170
        Size.Values = (
          449.791666666666700000
          7.937500000000000000
          7.937500000000000000
          762.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object qrAplicacao: TQRMemo
        Left = 104
        Top = 5
        Width = 166
        Height = 164
        Size.Values = (
          433.916666666666700000
          275.166666666666700000
          13.229166666666670000
          439.208333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          
            'Chave (para uso somente com ferramentas manuais) com 2 dentes, p' +
            'ara porca guia do rolamento dos amortecedores dianteiros do Gol,' +
            ' Parati, Saveiro, Santana e Voyage. Sextavado externo de 19 mm. ' +
            'Torque de aperto da porca: 40 Nm. Aten'#231#227'o: jamais usar com chave' +
            ' pneum'#225'tica. Manual incluso.')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 6
      end
      object qrImagem: TQRImage
        Left = 6
        Top = 5
        Width = 94
        Height = 128
        Size.Values = (
          338.666666666666700000
          15.875000000000000000
          13.229166666666670000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Stretch = True
      end
      object qrValor: TQRLabel
        Left = 6
        Top = 134
        Width = 94
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          354.541666666666700000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'R$ 58,00 '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object qrMarca: TQRLabel
        Left = 6
        Top = 160
        Width = 94
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          423.333333333333300000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'RAVEN'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object qrNumFab_Sku: TQRLabel
        Left = 6
        Top = 147
        Width = 94
        Height = 11
        Size.Values = (
          29.104166666666670000
          15.875000000000000000
          388.937500000000000000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '113096 - 4466'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
    end
  end
  object Qr_Image: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT FIRST 1 EXTENSION, CONTENT, FILE_NAME from tb_images WHER' +
        'E TABLE_ID =:PRO_CODIGO')
    Left = 424
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
