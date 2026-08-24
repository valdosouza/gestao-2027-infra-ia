object Rl_Saldo: TRl_Saldo
  Left = 189
  Top = 129
  Width = 832
  Height = 480
  HorzScrollBar.Range = 822
  HorzScrollBar.Style = ssHotTrack
  BorderStyle = bsSingle
  Caption = 'Relatorio de Saldo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 1
    Top = -1
    Width = 816
    Height = 1056
    ShowingPreview = False
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
    Page.PaperSize = Letter
    Page.Continuous = False
    Page.Values = (
      100.012500000000000000
      2794.000000000000000000
      100.012500000000000000
      2159.000000000000000000
      52.916666666666660000
      52.916666666666660000
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
    Units = Pixels
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
    object PageHeaderBand1: TQRBand
      Left = 20
      Top = 38
      Width = 776
      Height = 102
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        269.875000000000000000
        2053.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRLabel9: TQRLabel
        Left = 0
        Top = 83
        Width = 158
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          219.604166666666700000
          418.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Saldo: Contas '#224' Receber'
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
        Left = 0
        Top = 65
        Width = 736
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          171.979166666666700000
          1947.333333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 
          '________________________________________________________________' +
          '_________________________________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRBand1: TQRBand
      Left = 20
      Top = 140
      Width = 776
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
        2053.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRLabel3: TQRLabel
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
      object QRLabel13: TQRLabel
        Left = 429
        Top = 3
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          1135.062500000000000000
          7.937500000000000000
          296.333333333333300000)
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
      object QRLabel6: TQRLabel
        Left = 547
        Top = 3
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          1447.270833333333000000
          7.937500000000000000
          296.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Pago'
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
        Left = 662
        Top = 3
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          1751.541666666667000000
          7.937500000000000000
          296.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor Saldo'
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
      Left = 20
      Top = 166
      Width = 776
      Height = 22
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
        58.208333333333330000
        2053.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object E_EMPRESA: TQRLabel
        Left = 6
        Top = 1
        Width = 279
        Height = 17
        Size.Values = (
          44.979166666666700000
          15.875000000000000000
          2.645833333333330000
          738.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'E_EMPRESA'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object Lb_Vl_Parcela: TQRLabel
        Left = 432
        Top = 1
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          1143.000000000000000000
          2.645833333333333000
          296.333333333333300000)
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
      object QRLabel7: TQRLabel
        Left = 549
        Top = 1
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          1452.562500000000000000
          2.645833333333333000
          296.333333333333300000)
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
      object QRLabel4: TQRLabel
        Left = 661
        Top = 1
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          1748.895833333333000000
          2.645833333333333000
          296.333333333333300000)
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
    end
    object SubTotal: TQRBand
      Left = 20
      Top = 235
      Width = 776
      Height = 20
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
        52.916666666666670000
        2053.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRLabel18: TQRLabel
        Left = 521
        Top = 1
        Width = 99
        Height = 17
        Size.Values = (
          44.979166666666670000
          1378.479166666667000000
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
      object Lb_vl_Subtotal: TQRLabel
        Left = 656
        Top = 1
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1735.666666666667000000
          2.645833333333333000
          309.562500000000000000)
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
    end
    object Sumario: TQRBand
      Left = 20
      Top = 188
      Width = 776
      Height = 19
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
        50.270833333333330000
        2053.166666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel20: TQRLabel
        Left = 520
        Top = 1
        Width = 135
        Height = 17
        Size.Values = (
          44.979166666666670000
          1375.833333333333000000
          2.645833333333333000
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
      object Lb_vl_Total: TQRLabel
        Left = 656
        Top = 1
        Width = 117
        Height = 17
        Size.Values = (
          44.979166666666670000
          1735.666666666667000000
          2.645833333333333000
          309.562500000000000000)
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
    end
    object QRBand3: TQRBand
      Left = 20
      Top = 207
      Width = 776
      Height = 28
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        74.083333333333330000
        2053.166666666667000000)
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
        Left = 669
        Top = 7
        Width = 44
        Height = 17
        Size.Values = (
          44.979166666666700000
          1770.062500000000000000
          18.520833333333300000
          116.416666666667000000)
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
      object QRLabel22: TQRLabel
        Left = 601
        Top = 7
        Width = 64
        Height = 17
        Size.Values = (
          44.979166666666670000
          1590.145833333333000000
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
  end
  object Ds_CtasReceber: TDataSource
    DataSet = Qr_CtasReceber
    Left = 82
    Top = 39
  end
  object Qr_CtasReceber: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM VW_CTAS_RECEBER')
    Left = 80
    Top = 8
    object Qr_CtasReceberCTR_CODQTC: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_CODQTC'
      Origin = 'VW_CTAS_RECEBER.CTR_CODQTC'
      ReadOnly = True
    end
    object Qr_CtasReceberCTR_DT_VENCIMENTO: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_DT_VENCIMENTO'
      Origin = 'VW_CTAS_RECEBER.CTR_DT_VENCIMENTO'
      ReadOnly = True
    end
    object Qr_CtasReceberCTR_DT_PAGTO: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_DT_PAGTO'
      Origin = 'VW_CTAS_RECEBER.CTR_DT_PAGTO'
      ReadOnly = True
    end
    object Qr_CtasReceberCTR_CODEMP: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_CODEMP'
      Origin = 'VW_CTAS_RECEBER.CTR_CODEMP'
      ReadOnly = True
    end
    object Qr_CtasReceberCTR_NOME: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_NOME'
      Origin = 'VW_CTAS_RECEBER.CTR_NOME'
      ReadOnly = True
      Size = 100
    end
    object Qr_CtasReceberCTR_FANTASIA: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_FANTASIA'
      Origin = 'VW_CTAS_RECEBER.CTR_FANTASIA'
      ReadOnly = True
      Size = 100
    end
    object Qr_CtasReceberCTR_FONE: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_FONE'
      Origin = 'VW_CTAS_RECEBER.CTR_FONE'
      ReadOnly = True
      Size = 14
    end
    object Qr_CtasReceberCTR_NUMERO: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_NUMERO'
      Origin = 'VW_CTAS_RECEBER.CTR_NUMERO'
      ReadOnly = True
    end
    object Qr_CtasReceberCTR_NOMEEMITENTE: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_NOMEEMITENTE'
      Origin = 'VW_CTAS_RECEBER.CTR_NOMEEMITENTE'
      ReadOnly = True
      Size = 100
    end
    object Qr_CtasReceberCTR_VL_PARCELA: TBCDField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_VL_PARCELA'
      Origin = 'VW_CTAS_RECEBER.CTR_VL_PARCELA'
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object Qr_CtasReceberCTR_VL_PAGO: TBCDField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_VL_PAGO'
      Origin = 'VW_CTAS_RECEBER.CTR_VL_PAGO'
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object Qr_CtasReceberCTR_FORMAPAG: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_FORMAPAG'
      Origin = 'VW_CTAS_RECEBER.CTR_FORMAPAG'
      ReadOnly = True
    end
    object Qr_CtasReceberCTR_BAIXA: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_BAIXA'
      Origin = 'VW_CTAS_RECEBER.CTR_BAIXA'
      ReadOnly = True
      Size = 1
    end
    object Qr_CtasReceberCTR_OPERACAO: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'CTR_OPERACAO'
      Origin = 'VW_CTAS_RECEBER.CTR_OPERACAO'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
  end
  object Qr_Clientes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT EMP_CODIGO, EMP_FANTASIA, EMP_NOME, EMP_VL_CRED, EMP_DT_C' +
        'ADASTRO, END_FONE'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'WHERE EMP_CODIGO =:CTR_CODEMP'
      'ORDER BY EMP_FANTASIA')
    Left = 119
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CTR_CODEMP'
        ParamType = ptUnknown
        Size = 4
        Value = Null
      end>
    object Qr_ClientesEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_ClientesEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'TB_EMPRESA.EMP_FANTASIA'
      Size = 100
    end
    object Qr_ClientesEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_ClientesEMP_VL_CRED: TFloatField
      FieldName = 'EMP_VL_CRED'
      Origin = 'TB_EMPRESA.EMP_VL_CRED'
    end
    object Qr_ClientesEMP_DT_CADASTRO: TDateField
      FieldName = 'EMP_DT_CADASTRO'
      Origin = 'TB_EMPRESA.EMP_DT_CADASTRO'
    end
    object Qr_ClientesEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = 'TB_ENDERECO.END_FONE'
      Size = 14
    end
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT NFL_DT_EMISSAO, NFL_VL_TL_NOTA, NFL_CODIGO, PED_NUMERO, N' +
        'FL_NUMERO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '    INNER JOIN TB_FINANCEIRO tb_financeiro'
      '    ON (tb_financeiro.FIN_CODPED = tb_nota_fiscal.NFL_CODPED)'
      '    LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      'where FIN_CODQTC =:CTR_CODQTC')
    Left = 184
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CTR_CODQTC'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_NotaNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = 'TB_NOTA_FISCAL.NFL_DT_EMISSAO'
    end
    object Qr_NotaNFL_VL_TL_NOTA: TBCDField
      FieldName = 'NFL_VL_TL_NOTA'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_TL_NOTA'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = 'TB_NOTA_FISCAL.NFL_CODIGO'
      Required = True
    end
    object Qr_NotaPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_NotaNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = 'TB_NOTA_FISCAL.NFL_NUMERO'
      Size = 10
    end
  end
end
