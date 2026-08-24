object Rl_Etiq_Conferencia: TRl_Etiq_Conferencia
  Left = 403
  Top = 168
  Caption = 'Etiqueta para Envio no Tranporte'
  ClientHeight = 657
  ClientWidth = 1107
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
  PixelsPerInch = 96
  TextHeight = 13
  object Qrpt: TQuickRep
    Left = 0
    Top = 0
    Width = 416
    Height = 132
    ShowingPreview = False
    BeforePrint = QrptBeforePrint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QR_ETIQUETA'
      'QRSTRINGSBAND1')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    OnNeedData = QrptNeedData
    Options = []
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = Custom
    Page.Continuous = False
    Page.Values = (
      0.000000000000000000
      350.000000000000000000
      0.000000000000000000
      1100.000000000000000000
      10.000000000000000000
      0.000000000000000000
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
    ReportTitle = 'Etiqueta para Mala-Direta'
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
  end
  object Qr_DestinatarioPedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    Constraints = <
      item
        FromDictionary = True
      end>
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'PED_DATA, '
      'PED_CODEMP, '
      'PED_CODVDO,'
      'CDD_DESCRICAO , '
      'UFE_SIGLA, '
      'END_CEP, '
      'EMP_NOME,'
      'NFL_NUMERO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '      INNER JOIN TB_PEDIDO tb_pedido'
      '      ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      ''
      '      INNER  JOIN TB_ENDERECO tb_endereco'
      '      ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      ''
      '      INNER JOIN TB_CIDADE tb_cidade'
      '      ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      ''
      '      INNER JOIN TB_UF tb_uf'
      '      ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      ''
      '      INNER JOIN TB_EMPRESA tb_empresa'
      '      ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      ''
      ''
      'WHERE (NFL_CODIGO=:NFL_CODIGO)')
    Left = 288
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_DestinatarioPedidoPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = 'TB_PEDIDO.PED_DATA'
      Required = True
    end
    object Qr_DestinatarioPedidoPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = 'TB_PEDIDO.PED_CODEMP'
      Required = True
    end
    object Qr_DestinatarioPedidoPED_CODVDO: TIntegerField
      FieldName = 'PED_CODVDO'
      Origin = 'TB_PEDIDO.PED_CODVDO'
      Required = True
    end
    object Qr_DestinatarioPedidoCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_DestinatarioPedidoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_DestinatarioPedidoEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_DestinatarioPedidoEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_DestinatarioPedidoNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = 'TB_NOTA_FISCAL.NFL_NUMERO'
      Size = 10
    end
  end
  object Qr_Etiqueta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  CGE_CODIGO,'
      '  CGE_DESCRICAO,'
      '  CGE_PG_ALTURA,'
      '  CGE_PG_LARGURA,'
      '  CGE_SUPERIOR,'
      '  CGE_INFERIOR,'
      '  CGE_DIREITA,'
      '  CGE_ESQUERA,'
      '  CGE_ET_ALTURA,'
      '  CGE_ET_LARGURA,'
      '  CGE_DIS_COLUNA,'
      '  CGE_TYPEFONTE,'
      '  CGE_SIZEFONTE,'
      '  CGE_PAGESIZE,'
      '  CGE_NR_COLUNA'
      'FROM TB_CFG_ETIQUETA'
      'WHERE CGE_CODIGO=:CGE_CODIGO')
    Left = 352
    Top = 25
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CGE_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_EtiquetaCGE_CODIGO: TIntegerField
      FieldName = 'CGE_CODIGO'
      Origin = 'TB_CFG_ETIQUETA.CGE_CODIGO'
    end
    object Qr_EtiquetaCGE_DESCRICAO: TStringField
      FieldName = 'CGE_DESCRICAO'
      Origin = 'TB_CFG_ETIQUETA.CGE_DESCRICAO'
      Size = 100
    end
    object Qr_EtiquetaCGE_PG_ALTURA: TBCDField
      FieldName = 'CGE_PG_ALTURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_PG_ALTURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_PG_LARGURA: TBCDField
      FieldName = 'CGE_PG_LARGURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_PG_LARGURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_SUPERIOR: TBCDField
      FieldName = 'CGE_SUPERIOR'
      Origin = 'TB_CFG_ETIQUETA.CGE_SUPERIOR'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_INFERIOR: TBCDField
      FieldName = 'CGE_INFERIOR'
      Origin = 'TB_CFG_ETIQUETA.CGE_INFERIOR'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_DIREITA: TBCDField
      FieldName = 'CGE_DIREITA'
      Origin = 'TB_CFG_ETIQUETA.CGE_DIREITA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_ESQUERA: TBCDField
      FieldName = 'CGE_ESQUERA'
      Origin = 'TB_CFG_ETIQUETA.CGE_ESQUERA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_ET_ALTURA: TBCDField
      FieldName = 'CGE_ET_ALTURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_ET_ALTURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_ET_LARGURA: TBCDField
      FieldName = 'CGE_ET_LARGURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_ET_LARGURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_DIS_COLUNA: TBCDField
      FieldName = 'CGE_DIS_COLUNA'
      Origin = 'TB_CFG_ETIQUETA.CGE_DIS_COLUNA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_TYPEFONTE: TStringField
      FieldName = 'CGE_TYPEFONTE'
      Origin = 'TB_CFG_ETIQUETA.CGE_TYPEFONTE'
      Size = 40
    end
    object Qr_EtiquetaCGE_SIZEFONTE: TIntegerField
      FieldName = 'CGE_SIZEFONTE'
      Origin = 'TB_CFG_ETIQUETA.CGE_SIZEFONTE'
    end
    object Qr_EtiquetaCGE_PAGESIZE: TStringField
      FieldName = 'CGE_PAGESIZE'
      Origin = 'TB_CFG_ETIQUETA.CGE_PAGESIZE'
      Size = 15
    end
    object Qr_EtiquetaCGE_NR_COLUNA: TBCDField
      FieldName = 'CGE_NR_COLUNA'
      Origin = 'TB_CFG_ETIQUETA.CGE_NR_COLUNA'
      Precision = 18
      Size = 2
    end
  end
end
