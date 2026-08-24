inherited RL_ReportProductSaldo: TRL_ReportProductSaldo
  Caption = 'Saldo de Estoque'
  ClientHeight = 464
  ClientWidth = 766
  ExplicitWidth = 782
  ExplicitHeight = 503
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
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
    inherited PageHeader: TQRBand
      Size.Values = (
        341.312500000000000000
        1955.270833333333000000)
      inherited E_Titulo: TQRLabel
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          1899.708333333333000000)
        FontSize = 10
      end
      inherited Img_Logo: TQRImage
        Size.Values = (
          275.166666666666700000
          18.520833333333330000
          10.583333333333330000
          396.875000000000000000)
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
    end
    object QRBand1: TQRBand
      Left = 26
      Top = 243
      Width = 739
      Height = 17
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        44.979166666666670000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object E_DescricaoProduto: TQRLabel
        Left = 106
        Top = 0
        Width = 364
        Height = 15
        Size.Values = (
          39.687500000000000000
          280.458333333333400000
          0.000000000000000000
          963.083333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'DescricaoProduto'
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
      object E_VL_total: TQRLabel
        Left = 647
        Top = 0
        Width = 85
        Height = 15
        Size.Values = (
          39.687500000000000000
          1711.854166666667000000
          0.000000000000000000
          224.895833333333300000)
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
      object E_VL_Custo: TQRLabel
        Left = 476
        Top = 0
        Width = 96
        Height = 15
        Size.Values = (
          39.687500000000000000
          1259.416666666667000000
          0.000000000000000000
          254.000000000000000000)
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
      object E_codigoProduto: TQRLabel
        Left = 3
        Top = 0
        Width = 100
        Height = 15
        Size.Values = (
          39.687500000000000000
          7.937500000000000000
          0.000000000000000000
          264.583333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '00000'
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
      object E_Quantidade: TQRLabel
        Left = 575
        Top = 0
        Width = 69
        Height = 15
        Size.Values = (
          39.687500000000000000
          1521.354166666667000000
          0.000000000000000000
          182.562500000000000000)
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
    object QRBand3: TQRBand
      Left = 26
      Top = 281
      Width = 739
      Height = 24
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = QRBand3BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel1: TQRLabel
        Left = 405
        Top = 2
        Width = 84
        Height = 17
        Size.Values = (
          44.979166666666670000
          1071.562500000000000000
          5.291666666666667000
          222.250000000000000000)
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
      object E_Qtde_Total: TQRLabel
        Left = 532
        Top = 2
        Width = 84
        Height = 17
        Size.Values = (
          44.979166666666670000
          1407.583333333333000000
          5.291666666666667000
          222.250000000000000000)
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
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Valor_Total: TQRLabel
        Left = 620
        Top = 2
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          1640.416666666667000000
          5.291666666666667000
          296.333333333333400000)
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
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object Ft_SubGrupo: TQRBand
      Left = 26
      Top = 260
      Width = 739
      Height = 21
      AlignToBottom = False
      BeforePrint = Ft_SubGrupoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        55.562500000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRLabel6: TQRLabel
        Left = 405
        Top = 2
        Width = 121
        Height = 17
        Size.Values = (
          44.979166666666670000
          1071.562500000000000000
          5.291666666666667000
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
      object E_Valor_SubTotal: TQRLabel
        Left = 647
        Top = 2
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1711.854166666667000000
          5.291666666666667000
          224.895833333333300000)
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
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object E_Qtde_SubTotal: TQRLabel
        Left = 575
        Top = 2
        Width = 69
        Height = 17
        Size.Values = (
          44.979166666666670000
          1521.354166666667000000
          5.291666666666667000
          182.562500000000000000)
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
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRGroup2: TQRGroup
      Left = 26
      Top = 167
      Width = 739
      Height = 27
      AlignToBottom = False
      BeforePrint = QRGroup2BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        71.437500000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Consulta.GRP_DESCRICAO'
      Master = Qrpt
      ReprintOnNewPage = True
      object E_Grupo: TQRLabel
        Left = 0
        Top = 6
        Width = 738
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          15.875000000000000000
          1952.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Grupo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRGroup3: TQRGroup
      Left = 26
      Top = 194
      Width = 739
      Height = 49
      AlignToBottom = False
      BeforePrint = QRGroup3BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        129.645833333333300000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Consulta.SBG_DESCRICAO'
      FooterBand = Ft_SubGrupo
      Master = Qrpt
      ReprintOnNewPage = True
      object E_Subgrupo: TQRLabel
        Left = 0
        Top = 0
        Width = 738
        Height = 17
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          0.000000000000000000
          1952.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Descri'#231#227'o do Subgrupo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 4
        Top = 26
        Width = 46
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          68.791666666666670000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'C'#243'digo'
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
        Left = 107
        Top = 26
        Width = 137
        Height = 17
        Size.Values = (
          44.979166666666670000
          283.104166666666700000
          68.791666666666670000
          362.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Descri'#231#227'o do Produto'
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
        Left = 476
        Top = 26
        Width = 96
        Height = 17
        Size.Values = (
          44.979166666666670000
          1259.416666666667000000
          68.791666666666680000
          254.000000000000000000)
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
      object QRLabel5: TQRLabel
        Left = 575
        Top = 26
        Width = 69
        Height = 17
        Size.Values = (
          44.979166666666670000
          1521.354166666667000000
          68.791666666666680000
          182.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Quantidade'
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
        Left = 647
        Top = 26
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1711.854166666667000000
          68.791666666666680000
          224.895833333333300000)
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
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
  end
end
