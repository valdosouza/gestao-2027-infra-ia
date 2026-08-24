inherited RL_ReportVendasCustoUnico: TRL_ReportVendasCustoUnico
  Caption = 'Relat'#243'rio de Vendas X Custo'
  ClientHeight = 341
  ClientWidth = 793
  ExplicitWidth = 809
  ExplicitHeight = 379
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Left = 8
    Top = 8
    Functions.DATA = (
      '0'
      '0'
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
    ExplicitTop = 8
    inherited PageHeader: TQRBand
      Height = 154
      Size.Values = (
        407.458333333333300000
        1955.270833333333000000)
      ExplicitHeight = 154
      inherited E_Titulo: TQRLabel
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          1899.708333333333000000)
        FontSize = 10
      end
      inherited Img_Logo: TQRImage
        Left = 7
        Top = 4
        Width = 150
        Height = 104
        Size.Values = (
          275.166666666666700000
          18.520833333333330000
          10.583333333333330000
          396.875000000000000000)
        ExplicitLeft = 7
        ExplicitTop = 4
        ExplicitWidth = 150
        ExplicitHeight = 104
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
      object Lb_Cliente: TQRLabel
        Left = 204
        Top = 134
        Width = 315
        Height = 17
        Size.Values = (
          44.979166666666670000
          539.750000000000000000
          354.541666666666700000
          833.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Cliente'
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
      object Lb_Nota: TQRLabel
        Left = 130
        Top = 134
        Width = 71
        Height = 17
        Size.Values = (
          44.979166666666670000
          343.958333333333400000
          354.541666666666700000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nota Fiscal'
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
      object Lb_Pedido: TQRLabel
        Left = 65
        Top = 134
        Width = 64
        Height = 17
        Size.Values = (
          44.979166666666670000
          171.979166666666700000
          354.541666666666700000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'N'#186' Pedido'
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
      object Lb_Data: TQRLabel
        Left = 4
        Top = 134
        Width = 59
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          354.541666666666700000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Emiss'#227'o'
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
      object Lb_VL_Venda: TQRLabel
        Left = 533
        Top = 134
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1410.229166666667000000
          354.541666666666700000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Venda'
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
      object QRLabel1: TQRLabel
        Left = 636
        Top = 134
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1682.750000000000000000
          354.541666666666700000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Custo'
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
    object Sumario: TQRBand
      Left = 26
      Top = 211
      Width = 739
      Height = 66
      AlignToBottom = False
      BeforePrint = SumarioBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        174.625000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object Lb_Sbt_Vendas: TQRLabel
        Left = 527
        Top = 5
        Width = 103
        Height = 17
        Size.Values = (
          44.979166666666670000
          1394.354166666667000000
          13.229166666666670000
          272.520833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Venda'
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
      object E_VL_TL_Vendas: TQRLabel
        Left = 635
        Top = 5
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1680.104166666667000000
          13.229166666666670000
          264.583333333333400000)
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
      object Lb_Vl_Desconto: TQRLabel
        Left = 527
        Top = 23
        Width = 103
        Height = 17
        Size.Values = (
          44.979166666666670000
          1394.354166666667000000
          60.854166666666680000
          272.520833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Custo'
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
      object E_VL_TL_Custo: TQRLabel
        Left = 635
        Top = 23
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1680.104166666667000000
          60.854166666666680000
          264.583333333333400000)
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
      object QRLabel2: TQRLabel
        Left = 527
        Top = 42
        Width = 103
        Height = 17
        Size.Values = (
          44.979166666666670000
          1394.354166666667000000
          111.125000000000000000
          272.520833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo'
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
      object E_VL_TL_Saldo: TQRLabel
        Left = 635
        Top = 42
        Width = 100
        Height = 17
        Size.Values = (
          44.979166666666670000
          1680.104166666667000000
          111.125000000000000000
          264.583333333333400000)
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
    object Grp_Pedido: TQRGroup
      Left = 26
      Top = 192
      Width = 739
      Height = 0
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = Ftr_Dia
      Size.Values = (
        0.000000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Consulta.NFL_DT_EMISSAO'
      FooterBand = Ftr_Dia
      Master = Qrpt
      ReprintOnNewPage = False
    end
    object Grp_Dia: TQRGroup
      Left = 26
      Top = 192
      Width = 739
      Height = 0
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = Ftr_Pedido
      Size.Values = (
        0.000000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Consulta.PED_NUMERO'
      FooterBand = Ftr_Pedido
      Master = Qrpt
      ReprintOnNewPage = False
    end
    object DetalheVenda: TQRBand
      Left = 26
      Top = 192
      Width = 739
      Height = 0
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
        0.000000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
    end
    object Ftr_Pedido: TQRBand
      Left = 26
      Top = 192
      Width = 739
      Height = 19
      AlignToBottom = False
      BeforePrint = Ftr_PedidoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = Grp_Pedido
      Size.Values = (
        50.270833333333330000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object E_VL_Custo: TQRLabel
        Left = 636
        Top = 2
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          1682.750000000000000000
          5.291666666666667000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
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
      object E_Vl_Venda: TQRLabel
        Left = 533
        Top = 2
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          1410.229166666667000000
          5.291666666666667000
          264.583333333333400000)
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
      object E_Data: TQRLabel
        Left = 4
        Top = 2
        Width = 59
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          5.291666666666667000
          156.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '99/99/9999'
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
      object E_Pedido: TQRLabel
        Left = 65
        Top = 2
        Width = 64
        Height = 15
        Size.Values = (
          39.687500000000000000
          171.979166666666700000
          5.291666666666667000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Pedido'
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
      object E_Nota: TQRLabel
        Left = 130
        Top = 2
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          343.958333333333400000
          5.291666666666667000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nota'
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
      object E_Cliente: TQRLabel
        Left = 204
        Top = 2
        Width = 315
        Height = 15
        Size.Values = (
          39.687500000000000000
          539.750000000000000000
          5.291666666666667000
          833.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cliente'
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
    object Ftr_Dia: TQRBand
      Left = 26
      Top = 211
      Width = 739
      Height = 0
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        0.000000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
    end
  end
end
