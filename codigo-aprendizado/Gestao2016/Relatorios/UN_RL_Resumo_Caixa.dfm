object RL_Resumo_Caixa: TRL_Resumo_Caixa
  Left = 310
  Top = 229
  Caption = 'Resumo do Caixa'
  ClientHeight = 462
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 8
    Top = 1
    Width = 816
    Height = 1056
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Movimentacao
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
      100.000000000000000000
      2794.000000000000000000
      100.000000000000000000
      2159.000000000000000000
      75.000000000000000000
      75.000000000000000000
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
    ReportTitle = 'Resumo do Caixa'
    ShowProgress = False
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
    object QRBand1: TQRBand
      Left = 28
      Top = 38
      Width = 759
      Height = 107
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        283.104166666666700000
        2008.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object E_Titulo_Relatorio: TQRLabel
        Left = 0
        Top = 83
        Width = 457
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          219.604166666666700000
          1209.145833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Lan'#231'amentos do Caixa'
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
        Width = 750
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          171.979166666666700000
          1984.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 
          '________________________________________________________________' +
          '___________________________________________'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Usuario: TQRLabel
        Left = 494
        Top = 85
        Width = 94
        Height = 17
        Size.Values = (
          44.979166666666670000
          1307.041666666667000000
          224.895833333333300000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome Usu'#225'rio:'
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
      object E_Usuario: TQRLabel
        Left = 592
        Top = 85
        Width = 162
        Height = 17
        Size.Values = (
          44.979166666666670000
          1566.333333333333000000
          224.895833333333300000
          428.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Valdo'
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
    object QRGroup1: TQRGroup
      Left = 28
      Top = 145
      Width = 759
      Height = 27
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
        71.437500000000000000
        2008.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'Qr_LancCaixa.MVF_DATA'
      FooterBand = RodapeDiario
      Master = Qrpt
      ReprintOnNewPage = False
      object QRLabel4: TQRLabel
        Left = 3
        Top = 4
        Width = 343
        Height = 17
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          10.583333333333330000
          907.520833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Forma de Pagamento'
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
      object QRLabel7: TQRLabel
        Left = 621
        Top = 4
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          1643.062500000000000000
          10.583333333333330000
          346.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Valor '
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
        Left = 485
        Top = 4
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          1283.229166666667000000
          10.583333333333330000
          346.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Movimenta'#231#227'o'
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
      object QRLabel3: TQRLabel
        Left = 351
        Top = 4
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          10.583333333333330000
          346.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo Anterior'
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
    object Detalhe: TQRBand
      Left = 28
      Top = 172
      Width = 759
      Height = 19
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
        50.270833333333330000
        2008.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBText1: TQRDBText
        Left = 3
        Top = 1
        Width = 342
        Height = 17
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          2.645833333333333000
          904.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Movimentacao
        DataField = 'FPT_DESCRICAO'
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText3: TQRDBText
        Left = 485
        Top = 1
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          1283.229166666667000000
          2.645833333333333000
          346.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = Qr_Movimentacao
        DataField = 'MVF_VALOR'
        Mask = '0.00####'
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_VL_Saldo_Ant: TQRLabel
        Left = 351
        Top = 1
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          2.645833333333333000
          346.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Saldo Anterior'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object E_Vl_Saldo_Atual: TQRLabel
        Left = 621
        Top = 1
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          1643.062500000000000000
          2.645833333333333000
          346.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Movimenta'#231#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    object RodapeDiario: TQRBand
      Left = 28
      Top = 191
      Width = 759
      Height = 30
      AlignToBottom = False
      BeforePrint = RodapeDiarioBeforePrint
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
        79.375000000000000000
        2008.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object Lb_VL_Sld_Atual: TQRLabel
        Left = 621
        Top = 5
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          1643.062500000000000000
          13.229166666666670000
          346.604166666666700000)
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
      object QRLabel17: TQRLabel
        Left = 267
        Top = 5
        Width = 75
        Height = 17
        Size.Values = (
          44.979166666666670000
          706.437500000000000000
          13.229166666666670000
          198.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Saldo Atual'
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
      object Lb_VL_Movimentacao: TQRLabel
        Left = 485
        Top = 5
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          1283.229166666667000000
          13.229166666666670000
          346.604166666666700000)
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
      object Lb_VL_Sld_Ant: TQRLabel
        Left = 351
        Top = 5
        Width = 131
        Height = 17
        Size.Values = (
          44.979166666666670000
          928.687500000000000000
          13.229166666666670000
          346.604166666666700000)
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
    end
  end
  object Qr_Movimentacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT MVF_CODFPT, fpt_descricao, CAST(SUM (MVF_VL_CREDITO - MV' +
        'F_VL_DEBITO) AS NUMERIC(18, 2)) as MVF_VALOR'
      'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro'
      '  LEFT JOIN tb_formapagto'
      '  ON (tb_formapagto.fpt_codigo = tb_movim_financeiro.mvf_codfpt)'
      'WHERE (MVF_CODCTB = 0)'
      'AND (MVF_CODMHA =:MVF_CODMHA)'
      'GROUP BY MVF_CODFPT,fpt_descricao')
    Left = 80
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MVF_CODMHA'
        ParamType = ptUnknown
      end>
    object Qr_MovimentacaoFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Origin = 'TB_FORMAPAGTO.FPT_DESCRICAO'
      Size = 51
    end
    object Qr_MovimentacaoMVF_CODFPT: TIntegerField
      FieldName = 'MVF_CODFPT'
      Origin = 'TB_MOVIM_FINANCEIRO.MVF_CODFPT'
    end
    object Qr_MovimentacaoMVF_VALOR: TBCDField
      FieldName = 'MVF_VALOR'
      Precision = 18
      Size = 2
    end
  end
end
