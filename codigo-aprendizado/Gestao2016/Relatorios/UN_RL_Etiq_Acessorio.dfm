object RL_Etiq_Acessorio: TRL_Etiq_Acessorio
  Left = 51
  Top = 31
  Caption = 'Etiquetas para Acess'#243'rios'
  ClientHeight = 460
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 8
    Top = 16
    Width = 794
    Height = 1123
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    DataSet = Etiqueta
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QR_ETIQUETA')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      '0')
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 4
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
    PrinterSettings.PrintMetaFile = True
    PrinterSettings.MemoryLimit = 1000000
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = True
    ReportTitle = 'Etiquetas para Acess'#243'rios'
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
    PrevInitialZoom = qrZoomToWidth
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object QR_Etiqueta: TQRLoopBand
      Left = 38
      Top = 38
      Width = 179
      Height = 49
      AlignToBottom = False
      BeforePrint = QR_EtiquetaBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        129.645833333333300000
        473.604166666666700000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = Qrpt
      PrintCount = 0
      PrintBefore = False
      object Lb_Ordem: TQRLabel
        Left = 2
        Top = 16
        Width = 174
        Height = 15
        Size.Values = (
          39.687500000000000000
          5.291666666666667000
          42.333333333333330000
          460.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = True
        AutoSize = False
        Caption = 'O.S : 00000/001'
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
  end
  object Etiqueta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  EXT_CODIGO,'
      '  EXT_CODORD,'
      '  EXT_CODEMP,'
      '  EMP_NOME,'
      '  END_ENDER,'
      '  EXT_CODPED,'
      '  EXT_CODTPE,'
      '  TPE_DESCRICAO,'
      '  EXT_DESCRICAO,'
      '  EXT_NUMERO,'
      '  EXT_DT_VISTORIA,'
      '  EXT_RECARREGADO,'
      '  EXT_PRX_RECARGA,'
      '  EXT_VENC_RETESTE,'
      '  EXT_OBS,'
      '  EXT_LOTE,'
      '  EXT_QTDE,'
      '  EXT_TIPO_MED,'
      '  EXT_IMPRIME'
      'FROM TB_VENC_EXTINTOR'
      '   INNER JOIN TB_EMPRESA Tb_empresa '
      '   ON  (Tb_empresa.EMP_CODIGO = Tb_venc_extintor.EXT_CODEMP) '
      '   INNER JOIN TB_TP_EXTINTOR Tb_tp_extintor '
      
        '   ON  (Tb_tp_Extintor.TPE_CODIGO = Tb_venc_extintor.EXT_CODTPE)' +
        ' '
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'WHERE  (EXT_IMPRIME=1) AND (EXT_TIPOETQ=:TIPOETQ)'
      'ORDER BY EXT_CODORD')
    Left = 376
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TIPOETQ'
        ParamType = ptUnknown
      end>
    object EtiquetaEXT_CODIGO: TIntegerField
      FieldName = 'EXT_CODIGO'
      Origin = 'TB_VENC_EXTINTOR.EXT_CODIGO'
      Required = True
    end
    object EtiquetaEXT_CODTPE: TIntegerField
      FieldName = 'EXT_CODTPE'
      Origin = 'TB_VENC_EXTINTOR.EXT_CODTPE'
    end
    object EtiquetaTPE_DESCRICAO: TStringField
      FieldName = 'TPE_DESCRICAO'
      Origin = 'TB_TP_EXTINTOR.TPE_DESCRICAO'
      Size = 10
    end
    object EtiquetaEXT_DESCRICAO: TStringField
      FieldName = 'EXT_DESCRICAO'
      Origin = 'TB_VENC_EXTINTOR.EXT_DESCRICAO'
      Size = 60
    end
    object EtiquetaEXT_NUMERO: TStringField
      FieldName = 'EXT_NUMERO'
      Origin = 'TB_VENC_EXTINTOR.EXT_NUMERO'
      Size = 30
    end
    object EtiquetaEXT_RECARREGADO: TDateField
      FieldName = 'EXT_RECARREGADO'
      Origin = 'TB_VENC_EXTINTOR.EXT_RECARREGADO'
    end
    object EtiquetaEXT_PRX_RECARGA: TDateField
      FieldName = 'EXT_PRX_RECARGA'
      Origin = 'TB_VENC_EXTINTOR.EXT_PRX_RECARGA'
    end
    object EtiquetaEXT_VENC_RETESTE: TDateField
      FieldName = 'EXT_VENC_RETESTE'
      Origin = 'TB_VENC_EXTINTOR.EXT_VENC_RETESTE'
    end
    object EtiquetaEXT_OBS: TStringField
      FieldName = 'EXT_OBS'
      Origin = 'TB_VENC_EXTINTOR.EXT_OBS'
      Size = 255
    end
    object EtiquetaEXT_LOTE: TStringField
      FieldName = 'EXT_LOTE'
      Origin = 'TB_VENC_EXTINTOR.EXT_LOTE'
    end
    object EtiquetaEXT_QTDE: TIntegerField
      FieldName = 'EXT_QTDE'
      Origin = 'TB_VENC_EXTINTOR.EXT_QTDE'
    end
    object EtiquetaEXT_TIPO_MED: TStringField
      FieldName = 'EXT_TIPO_MED'
      Origin = 'TB_VENC_EXTINTOR.EXT_TIPO_MED'
    end
    object EtiquetaEXT_IMPRIME: TStringField
      FieldName = 'EXT_IMPRIME'
      Origin = 'TB_VENC_EXTINTOR.EXT_IMPRIME'
      Size = 1
    end
    object EtiquetaEXT_CODORD: TIntegerField
      FieldName = 'EXT_CODORD'
      Origin = 'TB_VENC_EXTINTOR.EXT_CODORD'
      Required = True
    end
    object EtiquetaEXT_CODEMP: TIntegerField
      FieldName = 'EXT_CODEMP'
      Origin = 'TB_VENC_EXTINTOR.EXT_CODEMP'
    end
    object EtiquetaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object EtiquetaEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object EtiquetaEXT_CODPED: TIntegerField
      FieldName = 'EXT_CODPED'
      Origin = 'TB_VENC_EXTINTOR.EXT_CODPED'
    end
    object EtiquetaEXT_DT_VISTORIA: TDateField
      FieldName = 'EXT_DT_VISTORIA'
      Origin = 'TB_VENC_EXTINTOR.EXT_DT_VISTORIA'
    end
  end
  object QRTextFilter1: TQRTextFilter
    TextEncoding = DefaultEncoding
    Left = 472
    Top = 64
  end
end
