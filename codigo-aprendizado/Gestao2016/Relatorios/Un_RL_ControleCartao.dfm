object RL_ControleCartao: TRL_ControleCartao
  Left = 46
  Top = 118
  Caption = 'Controle parcelas do Cart'#227'o'
  ClientHeight = 551
  ClientWidth = 1068
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 8
    Top = 24
    Width = 1123
    Height = 794
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Qr_Consulta
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
    Page.Columns = 2
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
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
    PrintIfEmpty = True
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
    object QR_Etiqueta: TQRBand
      Left = 38
      Top = 38
      Width = 523
      Height = 303
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = QR_EtiquetaBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        801.687500000000000000
        1383.770833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object Label1: TQRLabel
        Left = 4
        Top = 4
        Width = 60
        Height = 20
        Size.Values = (
          52.916666666666670000
          10.583333333333330000
          10.583333333333330000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cliente:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_NomeCliente: TQRLabel
        Left = 67
        Top = 4
        Width = 287
        Height = 19
        Size.Values = (
          50.270833333333330000
          177.270833333333300000
          10.583333333333330000
          759.354166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Nome do Cliente'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label3: TQRLabel
        Left = 365
        Top = 4
        Width = 42
        Height = 20
        Size.Values = (
          52.916666666666670000
          965.729166666666700000
          10.583333333333330000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Data: TQRLabel
        Left = 418
        Top = 2
        Width = 92
        Height = 19
        Size.Values = (
          50.270833333333330000
          1105.958333333333000000
          5.291666666666667000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '09/10/2013'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label5: TQRLabel
        Left = 4
        Top = 27
        Width = 61
        Height = 20
        Size.Values = (
          52.916666666666670000
          10.583333333333330000
          71.437500000000000000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pedido:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Nr_Pedido: TQRLabel
        Left = 67
        Top = 27
        Width = 287
        Height = 19
        Size.Values = (
          50.270833333333330000
          177.270833333333300000
          71.437500000000000000
          759.354166666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '000000'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label7: TQRLabel
        Left = 365
        Top = 27
        Width = 47
        Height = 20
        Size.Values = (
          52.916666666666670000
          965.729166666666700000
          71.437500000000000000
          124.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_VL_Receber: TQRLabel
        Left = 424
        Top = 27
        Width = 92
        Height = 19
        Size.Values = (
          50.270833333333330000
          1121.833333333333000000
          71.437500000000000000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '99.000,00'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label11: TQRLabel
        Left = 365
        Top = 51
        Width = 58
        Height = 20
        Size.Values = (
          52.916666666666670000
          965.729166666666700000
          134.937500000000000000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ordem:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Ordem: TQRLabel
        Left = 429
        Top = 52
        Width = 92
        Height = 19
        Size.Values = (
          50.270833333333330000
          1135.062500000000000000
          137.583333333333300000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '99.000,00'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label13: TQRLabel
        Left = 5
        Top = 105
        Width = 142
        Height = 20
        Size.Values = (
          52.916666666666670000
          13.229166666666670000
          277.812500000000000000
          375.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor Total Venda:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_VL_NotaFiscal: TQRLabel
        Left = 152
        Top = 105
        Width = 94
        Height = 19
        Size.Values = (
          50.270833333333330000
          402.166666666666600000
          277.812500000000000000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '100.000,00'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label15: TQRLabel
        Left = 6
        Top = 127
        Width = 125
        Height = 20
        Size.Values = (
          52.916666666666670000
          15.875000000000000000
          336.020833333333300000
          330.729166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Parcelando em: '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Parcelado: TQRLabel
        Left = 152
        Top = 127
        Width = 94
        Height = 19
        Size.Values = (
          50.270833333333330000
          402.166666666666600000
          336.020833333333400000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '60'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label19: TQRLabel
        Left = 5
        Top = 153
        Width = 107
        Height = 20
        Size.Values = (
          52.916666666666670000
          13.229166666666670000
          404.812500000000000000
          283.104166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Valor parcela:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Vl_Parcela: TQRLabel
        Left = 152
        Top = 149
        Width = 94
        Height = 19
        Size.Values = (
          50.270833333333330000
          402.166666666666600000
          394.229166666666700000
          248.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '100.000,00'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label21: TQRLabel
        Left = 6
        Top = 205
        Width = 123
        Height = 20
        Size.Values = (
          52.916666666666670000
          15.875000000000000000
          542.395833333333300000
          325.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Taxa do Cart'#227'o:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Taxa_Cartao: TQRLabel
        Left = 171
        Top = 208
        Width = 45
        Height = 19
        Size.Values = (
          50.270833333333330000
          452.437500000000000000
          550.333333333333400000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = '5%'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label23: TQRLabel
        Left = 2
        Top = 238
        Width = 187
        Height = 20
        Size.Values = (
          52.916666666666670000
          5.291666666666667000
          629.708333333333300000
          494.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Lan'#231'a na C/C do Banco:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Banco: TQRLabel
        Left = 171
        Top = 238
        Width = 339
        Height = 19
        Size.Values = (
          50.270833333333330000
          452.437500000000000000
          629.708333333333400000
          896.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Bradesco'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object Label25: TQRLabel
        Left = 2
        Top = 270
        Width = 52
        Height = 20
        Size.Values = (
          52.916666666666670000
          5.291666666666667000
          714.375000000000000000
          137.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cart'#227'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object E_Cartao: TQRLabel
        Left = 56
        Top = 270
        Width = 454
        Height = 19
        Size.Values = (
          50.270833333333330000
          148.166666666666700000
          714.375000000000000000
          1201.208333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Passsada - Presencial'
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
    end
  end
  object Qr_Consulta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT  DISTINCT'
      'c.EMP_NOME NOMECLIENTE,'
      'NFL_DT_EMISSAO,'
      'PED_NUMERO,'
      'CTE_DESCRICAO,'
      'CTE_PRZO_DEBI,'
      'NFL_VL_TL_NOTA,'
      'mf.mvf_vl_credito,'
      'mf.mvf_vl_debito,'
      'mf.mvf_vl_futuro,'
      'FIN_VL_PARCELA,'
      'fin_codfpg,'
      'CTE_ALIQ_CRED,'
      'banco.EMP_NOME NOMEBANCO,'
      'mf.mvf_codigo'
      'FROM tb_financeiro f'
      '   INNER JOIN tb_empresa c'
      '   on (c.emp_codigo = f.fin_codemp)'
      ''
      '   INNER JOIN tb_pedido p'
      '   on (p.PED_CODIGO = f.FIN_CODPED)'
      ''
      '   INNER JOIN tb_nota_fiscal n'
      '   ON (n.nfl_codigo = f.FIN_CODNFL)'
      ''
      '   INNER JOIN tb_cartaoeletronico ce'
      '   ON (ce.cte_codfpt = f.fin_codfpg)'
      ''
      '   INNER JOIN tb_contabancaria cb'
      '   ON (cb.ctb_codigo = ce.cte_codctb)'
      ''
      '   INNER JOIN tb_empresa banco'
      '   on (banco.emp_codigo = cb.ctb_codbco)'
      ''
      '   inner join tb_movim_financeiro mf'
      '   on (mf.mvf_codqtc = f.fin_codqtc)'
      ''
      'where  FIN_CODQTC =:FIN_CODQTC'
      'and  ( (mf.mvf_vl_futuro > 0 ) or (mf.mvf_vl_credito > 0 ) )'
      'order by mf.mvf_data asc , mf.mvf_vl_futuro desc')
    Left = 616
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODQTC'
        ParamType = ptUnknown
      end>
    object Qr_ConsultaNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_ConsultaNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = '"TB_NOTA_FISCAL"."NFL_DT_EMISSAO"'
    end
    object Qr_ConsultaPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_ConsultaCTE_DESCRICAO: TStringField
      FieldName = 'CTE_DESCRICAO'
      Origin = '"TB_CARTAOELETRONICO"."CTE_DESCRICAO"'
      Size = 100
    end
    object Qr_ConsultaCTE_PRZO_DEBI: TIntegerField
      FieldName = 'CTE_PRZO_DEBI'
      Origin = '"TB_CARTAOELETRONICO"."CTE_PRZO_DEBI"'
    end
    object Qr_ConsultaNFL_VL_TL_NOTA: TBCDField
      FieldName = 'NFL_VL_TL_NOTA'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_TL_NOTA"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaFIN_VL_PARCELA: TBCDField
      FieldName = 'FIN_VL_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PARCELA"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaCTE_ALIQ_CRED: TBCDField
      FieldName = 'CTE_ALIQ_CRED'
      Origin = '"TB_CARTAOELETRONICO"."CTE_ALIQ_CRED"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaNOMEBANCO: TStringField
      FieldName = 'NOMEBANCO'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_ConsultaMVF_VL_CREDITO: TBCDField
      FieldName = 'MVF_VL_CREDITO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_VL_CREDITO"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaMVF_VL_DEBITO: TBCDField
      FieldName = 'MVF_VL_DEBITO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_VL_DEBITO"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaMVF_VL_FUTURO: TBCDField
      FieldName = 'MVF_VL_FUTURO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_VL_FUTURO"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaFIN_CODFPG: TIntegerField
      FieldName = 'FIN_CODFPG'
      Origin = '"TB_FINANCEIRO"."FIN_CODFPG"'
    end
  end
end
