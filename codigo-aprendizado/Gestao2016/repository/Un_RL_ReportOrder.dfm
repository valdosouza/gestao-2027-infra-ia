inherited RL_ReportOrder: TRL_ReportOrder
  ClientHeight = 568
  ClientWidth = 927
  ExplicitWidth = 935
  ExplicitHeight = 595
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Left = 8
    DataSet = Qr_Pedido
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'STRB_PRODUTO'
      'STRB_SERVICO')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      70.000000000000000000
      75.000000000000000000
      0.000000000000000000)
    ExplicitLeft = 8
    object QrbRodape: TQRBand
      Left = 26
      Top = 294
      Width = 739
      Height = 155
      Frame.Style = psDot
      AlignToBottom = False
      BeforePrint = QrbRodapeBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        410.104166666666700000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel21: TQRLabel
        Left = 135
        Top = 7
        Width = 99
        Height = 17
        Size.Values = (
          44.979166666666670000
          357.187500000000000000
          18.520833333333330000
          261.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
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
      object QRShape11: TQRShape
        Left = 2
        Top = 0
        Width = 735
        Height = 149
        Size.Values = (
          394.229166666666700000
          5.291666666666667000
          0.000000000000000000
          1944.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object Lb_Vl_Pecas: TQRLabel
        Left = 616
        Top = 38
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          100.541666666667000000
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
      object Lb_Vl_Desconto: TQRLabel
        Left = 616
        Top = 70
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          185.208333333333000000
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
      object QRLabel26: TQRLabel
        Left = 523
        Top = 38
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1383.770833333333000000
          100.541666666666700000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Pe'#231'as:'
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
        Left = 522
        Top = 70
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1381.125000000000000000
          185.208333333333300000
          246.062500000000000000)
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
        Left = 520
        Top = 85
        Width = 93
        Height = 23
        Size.Values = (
          60.854166666666680000
          1375.833333333333000000
          224.895833333333300000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Total Geral:'
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
      object Lb_Vl_Total: TQRLabel
        Left = 616
        Top = 85
        Width = 117
        Height = 23
        Size.Values = (
          60.854166666666680000
          1629.833333333333000000
          224.895833333333300000
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
        Left = 6
        Top = 4
        Width = 168
        Height = 17
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          10.583333333333330000
          444.500000000000000000)
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
        Left = 176
        Top = 4
        Width = 556
        Height = 17
        Size.Values = (
          44.979166666666700000
          465.666666666667000000
          10.583333333333300000
          1471.083333333330000000)
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
      object QRLabel16: TQRLabel
        Left = 523
        Top = 54
        Width = 93
        Height = 17
        Size.Values = (
          44.979166666666670000
          1383.770833333333000000
          142.875000000000000000
          246.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal:'
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
        Left = 616
        Top = 54
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          142.875000000000000000
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
      object Lb_Assinatura: TQRLabel
        Left = 293
        Top = 128
        Width = 398
        Height = 17
        Frame.DrawTop = True
        Size.Values = (
          44.979166666666670000
          775.229166666666800000
          338.666666666666700000
          1053.041666666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Assinatura'
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
      object Lb_LocalData: TQRLabel
        Left = 13
        Top = 128
        Width = 256
        Height = 17
        Size.Values = (
          44.979166666666670000
          34.395833333333340000
          338.666666666666700000
          677.333333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_LocalData'
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
      object QRLabel17: TQRLabel
        Left = 5
        Top = 93
        Width = 67
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          246.062500000000000000
          177.270833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
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
      object Lb_NomeVendedor: TQRLabel
        Left = 77
        Top = 93
        Width = 411
        Height = 17
        Size.Values = (
          44.979166666666670000
          203.729166666666700000
          246.062500000000000000
          1087.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'NNome do Vendedor'
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
      object QRLabel18: TQRLabel
        Left = 6
        Top = 21
        Width = 82
        Height = 18
        Size.Values = (
          47.625000000000000000
          15.875000000000000000
          55.562500000000000000
          216.958333333333300000)
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
        Left = 6
        Top = 39
        Width = 491
        Height = 51
        Size.Values = (
          134.937500000000000000
          15.875000000000000000
          103.187500000000000000
          1299.104166666667000000)
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
      object Lb_Vl_Servico: TQRLabel
        Left = 616
        Top = 22
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          58.208333333333300000
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
      object QRLabel1: TQRLabel
        Left = 518
        Top = 22
        Width = 97
        Height = 17
        Size.Values = (
          44.979166666666670000
          1370.541666666667000000
          58.208333333333340000
          256.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Servi'#231'os:'
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
    object Titulo: TQRBand
      Left = 26
      Top = 38
      Width = 739
      Height = 141
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        373.062500000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
    end
    object Grp_Cliente: TQRGroup
      Left = 26
      Top = 179
      Width = 739
      Height = 92
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        243.416666666666700000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Ordem.OVS_VIA'
      Master = Qrpt
      ReprintOnNewPage = False
      object QRShape20: TQRShape
        Left = 2
        Top = 4
        Width = 735
        Height = 88
        Size.Values = (
          232.833333333333400000
          5.291666666666667000
          10.583333333333330000
          1944.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel3: TQRLabel
        Left = 30
        Top = 6
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          79.375000000000000000
          15.875000000000000000
          142.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
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
        Left = 15
        Top = 22
        Width = 69
        Height = 17
        Size.Values = (
          44.979166666666670000
          39.687500000000000000
          58.208333333333330000
          182.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
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
        Left = 36
        Top = 54
        Width = 48
        Height = 17
        Size.Values = (
          44.979166666666670000
          95.250000000000000000
          142.875000000000000000
          127.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
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
      object Lb_CNPJ: TQRLabel
        Left = 33
        Top = 70
        Width = 51
        Height = 17
        Size.Values = (
          44.979166666666670000
          87.312500000000000000
          185.208333333333300000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'C.N.P.J:'
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
        Left = 87
        Top = 22
        Width = 345
        Height = 17
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          58.208333333333340000
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
        Left = 84
        Top = 8
        Width = 324
        Height = 17
        Size.Values = (
          44.979166666666670000
          222.250000000000000000
          21.166666666666670000
          857.250000000000000000)
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
        Left = 87
        Top = 54
        Width = 329
        Height = 17
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          142.875000000000000000
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
      object Lb_Cli_Cnpj: TQRLabel
        Left = 87
        Top = 70
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          185.208333333333300000
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
      object Lb_Cli_Codigo: TQRLabel
        Left = 472
        Top = 6
        Width = 84
        Height = 17
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          15.875000000000000000
          222.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
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
        Left = 472
        Top = 22
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          58.208333333333330000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
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
      object Lb_Cli_Cidade: TQRLabel
        Left = 472
        Top = 54
        Width = 102
        Height = 17
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          142.875000000000000000
          269.875000000000000000)
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
        Left = 472
        Top = 70
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          185.208333333333300000
          214.312500000000000000)
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
      object QRLabel7: TQRLabel
        Left = 414
        Top = 6
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          1095.375000000000000000
          15.875000000000000000
          142.875000000000000000)
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
      object QRLabel8: TQRLabel
        Left = 433
        Top = 22
        Width = 35
        Height = 17
        Size.Values = (
          44.979166666666670000
          1145.645833333333000000
          58.208333333333330000
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
        Left = 413
        Top = 54
        Width = 54
        Height = 17
        Size.Values = (
          44.979166666666670000
          1092.729166666667000000
          142.875000000000000000
          142.875000000000000000)
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
      object Lb_Ie: TQRLabel
        Left = 371
        Top = 70
        Width = 96
        Height = 17
        Size.Values = (
          44.979166666666670000
          981.604166666666700000
          185.208333333333300000
          254.000000000000000000)
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
        Left = 578
        Top = 22
        Width = 38
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          58.208333333333330000
          100.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Coml:'
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
        Left = 616
        Top = 21
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          55.562500000000000000
          309.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_FoneC'
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
        Left = 578
        Top = 38
        Width = 29
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          100.541666666666700000
          76.729166666666670000)
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
        Left = 616
        Top = 37
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          97.895833333333340000
          309.562500000000000000)
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
      object QRLabel34: TQRLabel
        Left = 578
        Top = 54
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          142.875000000000000000
          68.791666666666670000)
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
      object Lb_Cli_Celular: TQRLabel
        Left = 616
        Top = 53
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          140.229166666666700000
          309.562500000000000000)
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
      object QRLabel10: TQRLabel
        Left = 18
        Top = 38
        Width = 66
        Height = 17
        Size.Values = (
          44.979166666666670000
          47.625000000000000000
          100.541666666666700000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Complem.'
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
      object Lb_Cli_Complemento: TQRLabel
        Left = 87
        Top = 38
        Width = 329
        Height = 17
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          100.541666666666700000
          870.479166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Complemento'
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
      object QRLabel14: TQRLabel
        Left = 417
        Top = 38
        Width = 50
        Height = 17
        Size.Values = (
          44.979166666666670000
          1103.312500000000000000
          100.541666666666700000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Contato'
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
      object Lb_Cli_Contato: TQRLabel
        Left = 472
        Top = 38
        Width = 102
        Height = 17
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          100.541666666666700000
          269.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lb_Cli_Contato'
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
    object StrB_Produto: TQRStringsBand
      Left = 26
      Top = 271
      Width = 739
      Height = 23
      AlignToBottom = False
      BeforePrint = StrB_ProdutoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        60.854166666666680000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      PrintBefore = False
      object QRShape15: TQRShape
        Left = 90
        Top = 1
        Width = 383
        Height = 23
        Frame.Color = clBtnHighlight
        Frame.Style = psClear
        Size.Values = (
          60.854166666666680000
          238.125000000000000000
          2.645833333333333000
          1013.354166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Style = bsClear
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape5: TQRShape
        Left = 2
        Top = 1
        Width = 89
        Height = 23
        Size.Values = (
          60.854166666666680000
          5.291666666666667000
          2.645833333333333000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape7: TQRShape
        Left = 526
        Top = 1
        Width = 92
        Height = 23
        Size.Values = (
          60.854166666666680000
          1391.708333333333000000
          2.645833333333333000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape9: TQRShape
        Left = 617
        Top = 1
        Width = 120
        Height = 23
        Size.Values = (
          60.854166666666680000
          1632.479166666667000000
          2.645833333333333000
          317.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 472
        Top = 1
        Width = 55
        Height = 23
        Size.Values = (
          60.854166666666680000
          1248.833333333333000000
          2.645833333333333000
          145.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Brush.Color = clBtnHighlight
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object Lb_SubVl_Pro: TQRLabel
        Left = 623
        Top = 4
        Width = 107
        Height = 17
        Size.Values = (
          44.979166666666670000
          1648.354166666667000000
          10.583333333333330000
          283.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'SubTotal'
        Color = clWhite
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
      object Lb_VlUnit_Pro: TQRLabel
        Left = 535
        Top = 4
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          1415.520833333333000000
          10.583333333333330000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'V. Unit'#225'rio'
        Color = clWhite
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
      object Lb_Qtde_Pro: TQRLabel
        Left = 481
        Top = 4
        Width = 42
        Height = 17
        Size.Values = (
          44.979166666666670000
          1272.645833333333000000
          10.583333333333330000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Qtde'
        Color = clWhite
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
      object Lb_Codigo_Pro: TQRLabel
        Left = 5
        Top = 4
        Width = 82
        Height = 17
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          10.583333333333330000
          216.958333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Cd. Produto'
        Color = clWhite
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
      object Lb_Descricao_Pro: TQRLabel
        Left = 93
        Top = 4
        Width = 369
        Height = 17
        Size.Values = (
          44.979166666666670000
          246.062500000000000000
          10.583333333333330000
          976.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Produto'
        Color = clWhite
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
  end
  object Qr_Pedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'EMP_NOME,'
      'CTC_FANTASIA,'
      'ctc_codemp,'
      'END_ENDER,'
      'END_NUMERO,'
      'END_COMPLEM,'
      'END_CONTATO,'
      'END_CEP,'
      'END_FONE,'
      'END_BAIRRO,'
      'CDD_DESCRICAO,'
      'END_FAX,'
      'EMP_CNPJ,'
      'EMP_INSC_EST,'
      'END_CELULAR,'
      'FPT_DESCRICAO,'
      'CTC_PRAZO PRAZO,'
      'CTC_OBS OBS,'
      'CLB_NOME,'
      'CTC_NUMERO,'
      'CTC_DATA'
      'UFE_SIGLA ,'
      'CTC_VL_DESCONTO'
      ''
      'FROM TB_COTACAO ctc'
      '   INNER JOIN TB_EMPRESA emp'
      '  ON (emp.EMP_CODIGO = ctc.CTC_CODEMP)'
      ''
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = emp.EMP_CODIGO)'
      ''
      '  INNER JOIN tb_cidade tb_cidade'
      '  ON (tb_cidade.cdd_codigo = tb_endereco.end_codcdd)'
      ''
      '  INNER JOIN tb_uf tb_uf'
      '  ON (tb_uf.ufe_codigo = tb_endereco.end_codufe)'
      ''
      '  INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '  ON (tb_formapagto.FPT_CODIGO = ctc.CTC_CODFPG)'
      ''
      '  INNER JOIN TB_COLABORADOR tb_colaborador'
      '  ON (tb_colaborador.CLB_CODIGO = ctc.CTC_CODVDO)'
      ''
      'WHERE(CTC_CODPED =:PED_CODIGO)')
    Left = 208
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_ItensPro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO DETALHE,'
      '  ITF_CODPED CODIGO,'
      '  ITF_CODNFL CODIGONOTA,'
      '  ITF_CODPRO CODIGOPRODUTO,'
      '  PRO_CODIGOFAB,'
      ' PRO_TIPO TIPO,'
      '  PRO_DESCRICAO DESC_PRODUTO,'
      '  ITF_QTDE QTDE,'
      '  ITF_VL_CUSTO CUSTO,'
      '  ITF_VL_UNIT VL_UNIT,'
      '  ITF_AQ_COM AQ_COM,'
      '  ITF_VL_DESC VL_DESC,'
      '  MED_ABREVIATURA MEDIDA,'
      '  PRO_CODIGOFOR,'
      '  (ITF_QTDE * ITF_VL_UNIT) SUBTOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = '#39'P'#39')'
      'ORDER BY PRO_DESCRICAO')
    Left = 353
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
