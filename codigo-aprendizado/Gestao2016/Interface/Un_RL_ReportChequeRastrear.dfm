inherited RL_ReportChequeRastrear: TRL_ReportChequeRastrear
  Caption = 'RL_ReportChequeRastrear'
  ClientHeight = 520
  ClientWidth = 850
  ExplicitWidth = 866
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'BND_FINANCEIRO'
      'BND_CHEQUE')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      '0'
      '0')
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
        415.395833333333300000
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
    object Grupo1: TQRGroup
      Left = 26
      Top = 195
      Width = 739
      Height = 36
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = Grupo1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        95.250000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_Quitacao.FIN_CODQTC'
      Master = Qrpt
      ReprintOnNewPage = False
      object QRLabel13: TQRLabel
        Left = 3
        Top = 1
        Width = 497
        Height = 17
        Size.Values = (
          44.979166666666700000
          7.937500000000000000
          2.645833333333330000
          1314.979166666670000000)
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
      object E_Nome_Cliente: TQRLabel
        Left = 3
        Top = 17
        Width = 698
        Height = 17
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          44.979166666666670000
          1846.791666666667000000)
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
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object Bnd_Financeiro: TQRLoopBand
      Left = 26
      Top = 231
      Width = 739
      Height = 22
      AfterPrint = Bnd_FinanceiroAfterPrint
      AlignToBottom = False
      BeforePrint = Bnd_FinanceiroBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      PrintCount = 0
      PrintBefore = False
      object Lb_Pedido: TQRLabel
        Left = 306
        Top = 2
        Width = 64
        Height = 17
        Size.Values = (
          44.979166666666670000
          809.625000000000000000
          5.291666666666667000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        Caption = 'N'#176' Pedido'
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
        Left = 373
        Top = 2
        Width = 71
        Height = 17
        Size.Values = (
          44.979166666666670000
          986.895833333333300000
          5.291666666666667000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
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
      object Lb_Parcela: TQRLabel
        Left = 447
        Top = 2
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          1182.687500000000000000
          5.291666666666667000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'N'#176' Parcela'
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
      object Lb_Valor: TQRLabel
        Left = 635
        Top = 2
        Width = 79
        Height = 17
        Size.Values = (
          44.979166666666670000
          1680.104166666667000000
          5.291666666666667000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor '
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
      object Lb_Dt_Pagto: TQRLabel
        Left = 539
        Top = 2
        Width = 90
        Height = 17
        Size.Values = (
          44.979166666666670000
          1426.104166666667000000
          5.291666666666667000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Data Pagto'
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
    object Bnd_Cheque: TQRLoopBand
      Left = 26
      Top = 253
      Width = 739
      Height = 20
      AfterPrint = Bnd_ChequeAfterPrint
      AlignToBottom = False
      BeforePrint = Bnd_ChequeBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      PrintCount = 0
      PrintBefore = False
      object Lb_Data: TQRLabel
        Left = 91
        Top = 1
        Width = 76
        Height = 17
        Size.Values = (
          44.979166666666670000
          240.770833333333300000
          2.645833333333333000
          201.083333333333300000)
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
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Emitente: TQRLabel
        Left = 169
        Top = 1
        Width = 286
        Height = 17
        Size.Values = (
          44.979166666666670000
          447.145833333333400000
          2.645833333333333000
          756.708333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Emitente'
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
      object Lb_Banco: TQRLabel
        Left = 459
        Top = 1
        Width = 48
        Height = 17
        Size.Values = (
          44.979166666666670000
          1214.437500000000000000
          2.645833333333333000
          127.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Banco'
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
      object Lb_Agencia: TQRLabel
        Left = 509
        Top = 1
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          1346.729166666667000000
          2.645833333333333000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Ag'#234'ncia'
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
      object Lb_Cheque: TQRLabel
        Left = 562
        Top = 1
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          1486.958333333333000000
          2.645833333333333000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'N'#186' Cheque'
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
      object Lb_Chq_Valor: TQRLabel
        Left = 636
        Top = 1
        Width = 80
        Height = 17
        Size.Values = (
          44.979166666666670000
          1682.750000000000000000
          2.645833333333333000
          211.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
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
  end
  object Qr_Financeiro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '   EMP_NOME,'
      '  EMP_FANTASIA,'
      '   PED_NUMERO,'
      '   NFL_NUMERO,'
      '   FIN_NR_PARCELA,'
      '   FIN_VL_PARCELA,'
      '   FIN_DT_PAGTO'
      'FROM TB_FINANCEIRO tb_financeiro'
      '    INNER JOIN TB_EMPRESA tb_empresa'
      '    ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)'
      '    LEFT OUTER JOIN TB_NOTA_FISCAL tb_nota_fiscal'
      '    ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)'
      '    LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      '    ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED)'
      'WHERE (FIN_CODQTC =:FIN_CODQTC)')
    Left = 136
    Top = 12
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODQTC'
        ParamType = ptUnknown
      end>
  end
  object Qr_Cheque: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '   CHQ_NR_BANCO, '
      '   CHQ_AGENCIA, '
      '   CHQ_NUMERO, '
      '   CHQ_EMITENTE, '
      '   CHQ_VALOR, '
      '   CHQ_DATA, '
      '    CHQ_DEVOLVIDO'
      'FROM TB_CHEQUES Tb_cheques'
      '  WHERE (CHQ_QT_REC=:FIN_CODQTC)')
    Left = 200
    Top = 12
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODQTC'
        ParamType = ptUnknown
      end>
  end
end
