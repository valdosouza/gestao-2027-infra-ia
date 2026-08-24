object RL_Nec_Compra: TRL_Nec_Compra
  Left = 191
  Top = 174
  Caption = 'Necessidade de Compra'
  ClientHeight = 541
  ClientWidth = 792
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
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Produtos
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
    PrintIfEmpty = False
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
    PreviewDefaultSaveType = stPDF
    PreviewLeft = 0
    PreviewTop = 0
    object QRBand2: TQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 103
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        272.520833333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRLabel1: TQRLabel
        Left = 0
        Top = 66
        Width = 715
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          174.625000000000000000
          1891.770833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 
          '________________________________________________________________' +
          '______________________________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel10: TQRLabel
        Left = 0
        Top = 84
        Width = 201
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          222.250000000000000000
          531.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Necessidade de Compra'
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
    object QRGroup1: TQRGroup
      Left = 38
      Top = 141
      Width = 718
      Height = 26
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        68.791666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Produtos.GRP_DESCRICAO'
      Master = Qrpt
      ReprintOnNewPage = True
      object QRDBText1: TQRDBText
        Left = 0
        Top = 5
        Width = 741
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666700000
          0.000000000000000000
          13.229166666666700000
          1960.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'GRP_DESCRICAO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRGroup2: TQRGroup
      Left = 38
      Top = 167
      Width = 718
      Height = 49
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        129.645833333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Produtos.SBG_DESCRICAO'
      FooterBand = RodapeSubGrupo
      Master = Qrpt
      ReprintOnNewPage = True
      object QRDBText2: TQRDBText
        Left = 46
        Top = 0
        Width = 693
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666700000
          121.708333333333000000
          0.000000000000000000
          1833.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'SBG_DESCRICAO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 48
        Top = 26
        Width = 41
        Height = 17
        Size.Values = (
          44.979166666666670000
          127.000000000000000000
          68.791666666666680000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'C'#243'digo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel3: TQRLabel
        Left = 146
        Top = 26
        Width = 126
        Height = 17
        Size.Values = (
          44.979166666666670000
          386.291666666666700000
          68.791666666666680000
          333.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Descri'#231#227'o do Produto'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel4: TQRLabel
        Left = 559
        Top = 26
        Width = 69
        Height = 17
        Size.Values = (
          44.979166666666670000
          1479.020833333333000000
          68.791666666666680000
          182.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Quantidade'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 631
        Top = 26
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666700000
          1669.520833333330000000
          68.791666666666700000
          224.895833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 474
        Top = 26
        Width = 83
        Height = 17
        Size.Values = (
          44.979166666666670000
          1254.125000000000000000
          68.791666666666680000
          219.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Custo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 216
      Width = 718
      Height = 21
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = QRGroup2
      Size.Values = (
        55.562500000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBText3: TQRDBText
        Left = 143
        Top = 1
        Width = 327
        Height = 17
        Size.Values = (
          44.979166666666670000
          378.354166666666700000
          2.645833333333333000
          865.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_DESCRICAO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 631
        Top = 1
        Width = 83
        Height = 17
        Size.Values = (
          44.979166666666670000
          1669.520833333333000000
          2.645833333333333000
          219.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_SUBTOTAL'
        Mask = '#,##0.000'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText5: TQRDBText
        Left = 559
        Top = 1
        Width = 68
        Height = 17
        Size.Values = (
          44.979166666666670000
          1479.020833333333000000
          2.645833333333333000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_QTDE'
        Mask = '#,##0.000'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_CODPRODUTO: TQRDBText
        Left = 48
        Top = 1
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          127.000000000000000000
          2.645833333333333000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_CODIGOFAB'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText7: TQRDBText
        Left = 473
        Top = 1
        Width = 83
        Height = 17
        Size.Values = (
          44.979166666666670000
          1251.479166666667000000
          2.645833333333333000
          219.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Produtos
        DataField = 'PRO_VL_CUSTO'
        Mask = '#,##0.000'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object RodapeSubGrupo: TQRBand
      Left = 38
      Top = 237
      Width = 718
      Height = 22
      AlignToBottom = False
      BeforePrint = RodapeSubGrupoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRLabel7: TQRLabel
        Left = 312
        Top = 3
        Width = 121
        Height = 17
        Size.Values = (
          44.979166666666670000
          825.500000000000100000
          7.937500000000000000
          320.145833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotais'
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
      object Lb_Vl_SubTotal: TQRLabel
        Left = 622
        Top = 1
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1645.708333333333000000
          2.645833333333333000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Vl_SubTotal'
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
      object LB_Qt_SubTotal: TQRLabel
        Left = 535
        Top = 1
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1415.520833333333000000
          2.645833333333333000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'QRLabel9'
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
    object QRBand3: TQRBand
      Left = 38
      Top = 259
      Width = 718
      Height = 27
      AlignToBottom = False
      BeforePrint = QRBand3BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        71.437500000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel8: TQRLabel
        Left = 312
        Top = 3
        Width = 121
        Height = 17
        Size.Values = (
          44.979166666666670000
          825.500000000000100000
          7.937500000000000000
          320.145833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total Geral'
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
      object Lb_Qt_Total: TQRLabel
        Left = 535
        Top = 1
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1415.520833333333000000
          2.645833333333333000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Qt_Total'
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
      object Lb_Vl_Total: TQRLabel
        Left = 622
        Top = 1
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1645.708333333333000000
          2.645833333333333000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_SubTotal'
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
    object QRBand4: TQRBand
      Left = 38
      Top = 286
      Width = 718
      Height = 28
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        74.083333333333330000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageFooter
      object QRSysData1: TQRSysData
        Left = -2
        Top = 7
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          -5.291666666666667000
          18.520833333333330000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDate
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
      object QRSysData2: TQRSysData
        Left = 667
        Top = 7
        Width = 46
        Height = 17
        Size.Values = (
          44.979166666666670000
          1764.770833333333000000
          18.520833333333330000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsPageNumber
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel18: TQRLabel
        Left = 592
        Top = 7
        Width = 59
        Height = 17
        Size.Values = (
          44.979166666666670000
          1566.333333333333000000
          18.520833333333330000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pagina N'#186
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel17: TQRLabel
        Left = 227
        Top = 7
        Width = 170
        Height = 17
        Size.Values = (
          44.979166666666670000
          600.604166666666800000
          18.520833333333330000
          449.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Numero Total de de Produtos'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRSysData3: TQRSysData
        Left = 406
        Top = 7
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          1074.208333333333000000
          18.520833333333330000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDetailCount
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 10
      end
    end
  end
  object Qr_Produtos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT DISTINCT PRO_CODIGO, PRO_CODIGOFAB,  PRO_DESCRICAO,  PRO_' +
        'QTDE, PRO_QTDE_MIN, PRO_CODGRP, PRO_CODSBG, PRO_VL_CUSTO,'
      
        'PRO_VL_VENDA, GRP_DESCRICAO, SBG_DESCRICAO, GRP_CODIGO, SBG_CODG' +
        'RP, CAST((PRO_VL_CUSTO * PRO_QTDE) AS DOUBLE PRECISION) AS PRO_SUBTOTAL'
      'FROM TB_PRODUTO Tb_produto'
      '   INNER JOIN TB_GRUPOS Tb_grupos'
      '   ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO)'
      '   INNER JOIN TB_SUBGRUPOS Tb_subgrupos'
      '   ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO)'
      '   LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn'
      '   ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO)'
      '   LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor'
      '   ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO)')
    Left = 40
    Top = 16
    object Qr_ProdutosPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = 'TB_PRODUTO.PRO_CODIGO'
      Required = True
    end
    object Qr_ProdutosPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_ProdutosPRO_QTDE: TBCDField
      FieldName = 'PRO_QTDE'
      Origin = 'TB_PRODUTO.PRO_QTDE'
      Precision = 18
      Size = 3
    end
    object Qr_ProdutosPRO_QTDE_MIN: TBCDField
      FieldName = 'PRO_QTDE_MIN'
      Origin = 'TB_PRODUTO.PRO_QTDE_MIN'
      Precision = 18
      Size = 3
    end
    object Qr_ProdutosPRO_CODGRP: TIntegerField
      FieldName = 'PRO_CODGRP'
      Origin = 'TB_PRODUTO.PRO_CODGRP'
    end
    object Qr_ProdutosPRO_CODSBG: TIntegerField
      FieldName = 'PRO_CODSBG'
      Origin = 'TB_PRODUTO.PRO_CODSBG'
    end
    object Qr_ProdutosPRO_VL_VENDA: TBCDField
      FieldName = 'PRO_VL_VENDA'
      Origin = 'TB_PRODUTO.PRO_VL_VENDA'
      DisplayFormat = '0.000'
      Precision = 18
      Size = 3
    end
    object Qr_ProdutosGRP_DESCRICAO: TStringField
      FieldName = 'GRP_DESCRICAO'
      Origin = 'TB_GRUPOS.GRP_DESCRICAO'
      Size = 100
    end
    object Qr_ProdutosSBG_DESCRICAO: TStringField
      FieldName = 'SBG_DESCRICAO'
      Origin = 'TB_SUBGRUPOS.SBG_DESCRICAO'
      Size = 100
    end
    object Qr_ProdutosGRP_CODIGO: TIntegerField
      FieldName = 'GRP_CODIGO'
      Origin = 'TB_GRUPOS.GRP_CODIGO'
      Required = True
    end
    object Qr_ProdutosSBG_CODGRP: TIntegerField
      FieldName = 'SBG_CODGRP'
      Origin = 'TB_SUBGRUPOS.SBG_CODGRP'
    end
    object Qr_ProdutosPRO_VL_CUSTO: TBCDField
      FieldName = 'PRO_VL_CUSTO'
      Origin = 'TB_PRODUTO.PRO_VL_CUSTO'
      DisplayFormat = '0.000'
      Precision = 18
      Size = 4
    end
    object Qr_ProdutosPRO_SUBTOTAL: TFloatField
      FieldName = 'PRO_SUBTOTAL'
      DisplayFormat = '0.000'
    end
    object Qr_ProdutosPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = 'TB_PRODUTO.PRO_CODIGOFAB'
      Size = 50
    end
  end
end
