inherited RL_ReportList: TRL_ReportList
  ClientHeight = 448
  ClientWidth = 838
  ExplicitWidth = 854
  ExplicitHeight = 487
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
    object PageHeader: TQRBand
      Left = 26
      Top = 38
      Width = 739
      Height = 129
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        341.312500000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object E_Titulo: TQRLabel
        Left = 0
        Top = 111
        Width = 718
        Height = 17
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          1899.708333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoSize = False
        Caption = 'Titulo do Relatorio'
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
      object Img_Logo: TQRImage
        Left = 19
        Top = 20
        Width = 127
        Height = 73
        Size.Values = (
          193.145833333333300000
          50.270833333333330000
          52.916666666666660000
          336.020833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Stretch = True
      end
      object Lb_Emp_Nome: TQRLabel
        Left = 162
        Top = 2
        Width = 539
        Height = 17
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          5.291666666666667000
          1426.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'ALESSANDRA CRISTINA DOS SANTOS & CIA LTDA - ME'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_Doc: TQRLabel
        Left = 162
        Top = 20
        Width = 539
        Height = 17
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          52.916666666666660000
          1426.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CNPJ : 04.947.758/0001-92 - IE.: 903.93437-94'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_End: TQRLabel
        Left = 162
        Top = 39
        Width = 539
        Height = 17
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          103.187500000000000000
          1426.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Rua Dr. Levy Buquera, 420 - Sitio Cercado - 81910-190 - Curitiba' +
          ' - PR'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_Fones: TQRLabel
        Left = 162
        Top = 57
        Width = 539
        Height = 17
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          150.812500000000000000
          1426.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'TELEVENDAS: (41) 3378-6200 / 3528-2524 / 3379-2580'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_www: TQRLabel
        Left = 162
        Top = 93
        Width = 539
        Height = 17
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          246.062500000000000000
          1426.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'www.genioferramentas.com.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_email: TQRLabel
        Left = 162
        Top = 75
        Width = 539
        Height = 17
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          198.437500000000000000
          1426.104166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'vendas@genioferramentas.com.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
    end
  end
end
