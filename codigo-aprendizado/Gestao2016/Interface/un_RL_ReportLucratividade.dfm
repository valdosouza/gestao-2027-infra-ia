inherited RL_ReportLucratividade: TRL_ReportLucratividade
  Caption = ''
  ClientHeight = 742
  ClientWidth = 1214
  ExplicitWidth = 1230
  ExplicitHeight = 781
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Width = 1123
    Height = 794
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Orientation = poLandscape
    Page.Values = (
      100.012500000000000000
      2100.000000000000000000
      100.038958333333300000
      2970.000000000000000000
      50.006250000000000000
      50.006250000000000000
      0.000000000000000000)
    Units = Pixels
    ExplicitWidth = 1123
    ExplicitHeight = 794
    inherited PageHeader: TQRBand
      Left = 19
      Width = 1085
      Height = 153
      Size.Values = (
        404.812500000000000000
        2870.729166666667000000)
      ExplicitLeft = 19
      ExplicitWidth = 1085
      ExplicitHeight = 153
      inherited E_Titulo: TQRLabel
        Width = 1082
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          2862.791666666667000000)
        FontSize = 10
        ExplicitWidth = 1082
      end
      inherited Img_Logo: TQRImage
        Size.Values = (
          193.145833333333300000
          50.270833333333330000
          52.916666666666660000
          336.020833333333400000)
      end
      inherited Lb_Emp_Nome: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          5.291666666666667000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Doc: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          52.916666666666660000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_End: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          103.187500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Fones: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          150.812500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_www: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          246.062500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_email: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          198.437500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      object QRLabel1: TQRLabel
        Left = 282
        Top = 133
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          746.125000000000000000
          351.895833333333300000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'ICMS'
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
      object QRLabel2: TQRLabel
        Left = 357
        Top = 133
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          944.562500000000000000
          351.895833333333300000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'PIS'
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
      object QRLabel3: TQRLabel
        Left = 432
        Top = 133
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          1143.000000000000000000
          351.895833333333300000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'COFINS'
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
      object CONTSOCIAL: TQRLabel
        Left = 507
        Top = 133
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          1341.437500000000000000
          351.895833333333300000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'C. SOCIAL'
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
        Left = 582
        Top = 133
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          1539.875000000000000000
          351.895833333333300000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'IRPJ'
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
        Left = 743
        Top = 133
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1965.854166666667000000
          351.895833333333300000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'P. CUSTO'
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
      object QRLabel7: TQRLabel
        Left = 840
        Top = 133
        Width = 102
        Height = 17
        Size.Values = (
          44.979166666666670000
          2222.500000000000000000
          351.895833333333300000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'P. VENDA'
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
      object QRLabel8: TQRLabel
        Left = 945
        Top = 133
        Width = 87
        Height = 17
        Size.Values = (
          44.979166666666670000
          2500.312500000000000000
          351.895833333333300000
          230.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'LUCRO'
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
        Left = 1037
        Top = 133
        Width = 43
        Height = 17
        Size.Values = (
          44.979166666666670000
          2743.729166666667000000
          351.895833333333300000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '%'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel19: TQRLabel
        Left = 657
        Top = 132
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1738.312500000000000000
          349.250000000000000000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'COMISSAO'
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
    object Detalhe: TQRBand
      Left = 19
      Top = 191
      Width = 1085
      Height = 0
      HelpContext = 15
      AlignToBottom = False
      BeforePrint = DetalheBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        0.000000000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBText2: TQRDBText
        Left = 6
        Top = 4
        Width = 275
        Height = 17
        Size.Values = (
          44.979166666666700000
          15.875000000000000000
          10.583333333333300000
          727.604166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Consulta
        DataField = 'LVD_DESCRICAOPRODUTO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText3: TQRDBText
        Left = 294
        Top = 4
        Width = 51
        Height = 17
        Size.Values = (
          44.979166666666700000
          777.875000000000000000
          10.583333333333300000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Consulta
        DataField = 'LVD_QTDE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 350
        Top = 4
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666700000
          926.041666666667000000
          10.583333333333300000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Consulta
        DataField = 'LVD_VLUNITV'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText5: TQRDBText
        Left = 430
        Top = 4
        Width = 83
        Height = 17
        Size.Values = (
          44.979166666666700000
          1137.708333333330000000
          10.583333333333300000
          219.604166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Consulta
        DataField = 'LVD_TOTALLINHA'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object FooterProduto: TQRBand
      Left = 19
      Top = 191
      Width = 1085
      Height = 20
      AlignToBottom = False
      BeforePrint = FooterProdutoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRDBText1: TQRDBText
        Left = 1
        Top = 2
        Width = 275
        Height = 17
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          5.291666666666667000
          727.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Consulta
        DataField = 'LVD_PRODUTO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Vl_pis: TQRLabel
        Left = 357
        Top = 2
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          944.562500000000000000
          5.291666666666667000
          198.437500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_cofins: TQRLabel
        Left = 432
        Top = 2
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          1143.000000000000000000
          5.291666666666667000
          198.437500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_Csocial: TQRLabel
        Left = 507
        Top = 2
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          1341.437500000000000000
          5.291666666666667000
          198.437500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_Irpj: TQRLabel
        Left = 582
        Top = 2
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          1539.875000000000000000
          5.291666666666667000
          198.437500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_Venda: TQRLabel
        Left = 840
        Top = 2
        Width = 102
        Height = 17
        Size.Values = (
          44.979166666666670000
          2222.500000000000000000
          5.291666666666667000
          269.875000000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_Comissao: TQRLabel
        Left = 657
        Top = 2
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1738.312500000000000000
          5.291666666666667000
          224.895833333333300000)
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
        FontSize = 10
      end
      object Lb_Vl_Custo: TQRLabel
        Left = 743
        Top = 2
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1965.854166666667000000
          5.291666666666667000
          246.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_Lucro: TQRLabel
        Left = 945
        Top = 2
        Width = 87
        Height = 17
        Size.Values = (
          44.979166666666670000
          2500.312500000000000000
          5.291666666666667000
          230.187500000000000000)
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
        FontSize = 10
      end
      object LB_Aliq_Lcvtde: TQRLabel
        Left = 1037
        Top = 2
        Width = 43
        Height = 17
        Size.Values = (
          44.979166666666670000
          2743.729166666667000000
          5.291666666666667000
          113.770833333333300000)
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
        FontSize = 10
      end
      object Lb_Vl_Icms: TQRLabel
        Left = 282
        Top = 2
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          746.125000000000000000
          5.291666666666667000
          198.437500000000000000)
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
        FontSize = 10
      end
    end
    object Grp_Produto: TQRGroup
      Left = 19
      Top = 191
      Width = 1085
      Height = 0
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        0.000000000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Consulta.LVD_CODPRO'
      FooterBand = FooterProduto
      Master = Qrpt
      ReprintOnNewPage = False
    end
    object QRBand3: TQRBand
      Left = 19
      Top = 344
      Width = 1085
      Height = 28
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        74.083333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageFooter
      object QRSysData1: TQRSysData
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
      object QRSysData2: TQRSysData
        Left = 1028
        Top = 7
        Width = 45
        Height = 17
        Size.Values = (
          44.979166666666700000
          2719.916666666670000000
          18.520833333333300000
          119.062500000000000000)
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
      object QRLabel21: TQRLabel
        Left = 961
        Top = 7
        Width = 64
        Height = 17
        Size.Values = (
          44.979166666666670000
          2542.645833333333000000
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
      object QRLabel23: TQRLabel
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
    object Sumary: TQRBand
      Left = 19
      Top = 211
      Width = 1085
      Height = 133
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = SumaryBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        351.895833333333300000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel10: TQRLabel
        Left = 8
        Top = 26
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          68.791666666666670000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total do Pis'
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
        Left = 8
        Top = 46
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          121.708333333333300000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total do Cofins'
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
        Left = 8
        Top = 65
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          171.979166666666700000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor total Da Cont. Social'
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
      object QRLabel13: TQRLabel
        Left = 8
        Top = 84
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          222.250000000000000000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Do IRPJ'
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
      object QRLabel14: TQRLabel
        Left = 751
        Top = 26
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1987.020833333333000000
          68.791666666666670000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Pre'#231'o de Venda'
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
      object QRLabel15: TQRLabel
        Left = 751
        Top = 6
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1987.020833333333000000
          15.875000000000000000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Pre'#231'o Custo'
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
      object QRLabel16: TQRLabel
        Left = 751
        Top = 46
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1987.020833333333000000
          121.708333333333300000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Lucro'
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
      object QRLabel17: TQRLabel
        Left = 751
        Top = 65
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1987.020833333333000000
          171.979166666666700000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lucratividade %'
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
      object QRLabel18: TQRLabel
        Left = 8
        Top = 6
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          15.875000000000000000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total do ICMS'
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
      object QRLabel20: TQRLabel
        Left = 378
        Top = 6
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1000.125000000000000000
          15.875000000000000000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Da Comiss'#227'o'
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
      object Lb_Vl_tl_ICMS: TQRLabel
        Left = 191
        Top = 6
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          505.354166666666700000
          15.875000000000000000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_Pis: TQRLabel
        Left = 191
        Top = 26
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          505.354166666666700000
          68.791666666666670000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_Cofins: TQRLabel
        Left = 191
        Top = 46
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          505.354166666666700000
          121.708333333333300000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_ContSocial: TQRLabel
        Left = 191
        Top = 65
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          505.354166666666700000
          171.979166666666700000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_IRRF: TQRLabel
        Left = 191
        Top = 84
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          505.354166666666700000
          222.250000000000000000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_Comissao: TQRLabel
        Left = 560
        Top = 6
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          1481.666666666667000000
          15.875000000000000000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_Custo: TQRLabel
        Left = 934
        Top = 6
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          2471.208333333333000000
          15.875000000000000000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_Venda: TQRLabel
        Left = 934
        Top = 26
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          2471.208333333333000000
          68.791666666666670000
          373.062500000000000000)
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
        FontSize = 10
      end
      object Lb_Vl_tl_Lucro: TQRLabel
        Left = 934
        Top = 46
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          2471.208333333333000000
          121.708333333333300000
          373.062500000000000000)
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
        FontSize = 10
      end
      object LB_Aliq_Tl_Lcvtde: TQRLabel
        Left = 934
        Top = 65
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          2471.208333333333000000
          171.979166666666700000
          373.062500000000000000)
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
        FontSize = 10
      end
      object QRLabel22: TQRLabel
        Left = 378
        Top = 26
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1000.125000000000000000
          68.791666666666670000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total de Frete '
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
      object Lb_Vl_tl_Frete: TQRLabel
        Left = 560
        Top = 26
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          1481.666666666667000000
          68.791666666666670000
          373.062500000000000000)
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
        FontSize = 10
      end
      object QRLabel24: TQRLabel
        Left = 8
        Top = 104
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          275.166666666666700000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total de S.T'
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
      object Lb_Vl_tl_sT: TQRLabel
        Left = 191
        Top = 104
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          505.354166666666700000
          275.166666666666700000
          373.062500000000000000)
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
        FontSize = 10
      end
      object QRLabel25: TQRLabel
        Left = 378
        Top = 46
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1000.125000000000000000
          121.708333333333300000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Outras Despesas'
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
      object Lb_Vl_tl_Outras: TQRLabel
        Left = 560
        Top = 46
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          1481.666666666667000000
          121.708333333333300000
          373.062500000000000000)
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
        FontSize = 10
      end
      object QRLabel9: TQRLabel
        Left = 378
        Top = 65
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1000.125000000000000000
          171.979166666666700000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Seguros'
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
      object Lb_Vl_tl_Seguro: TQRLabel
        Left = 560
        Top = 65
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          1481.666666666667000000
          171.979166666666700000
          373.062500000000000000)
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
        FontSize = 10
      end
      object QRLabel27: TQRLabel
        Left = 378
        Top = 84
        Width = 180
        Height = 17
        Size.Values = (
          44.979166666666670000
          1000.125000000000000000
          222.250000000000000000
          476.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Total Faturamento'
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
      object Lb_Vl_tl_faturamento: TQRLabel
        Left = 560
        Top = 84
        Width = 141
        Height = 17
        Size.Values = (
          44.979166666666670000
          1481.666666666667000000
          222.250000000000000000
          373.062500000000000000)
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
        FontSize = 10
      end
    end
  end
end
