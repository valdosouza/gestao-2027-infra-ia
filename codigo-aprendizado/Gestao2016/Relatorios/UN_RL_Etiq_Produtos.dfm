object RL_Etiq_Produtos: TRL_Etiq_Produtos
  Left = 124
  Top = 183
  Caption = 'Etiquetas de C'#243'digo de barras para produtos'
  ClientHeight = 0
  ClientWidth = 120
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
    Top = 8
    Width = 794
    Height = 1123
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
      'QRSTRINGSBAND1'
      'QR_ETIQUETA')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 2
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      130.000000000000000000
      2970.000000000000000000
      130.000000000000000000
      2100.000000000000000000
      20.000000000000000000
      20.000000000000000000
      30.000000000000000000)
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
    ReportTitle = 'Etiquetas de C'#243'digo de barras para produtos'
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
    object Qr_Etiqueta: TQRStringsBand
      Left = 8
      Top = 49
      Width = 384
      Height = 168
      AlignToBottom = False
      BeforePrint = Qr_EtiquetaBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        444.500000000000000000
        1016.000000000000000000)
      PreCaluculateBandHeight = True
      KeepOnOnePage = False
      Master = Qrpt
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
      PrintBefore = True
    end
  end
  object Qr_MalaDireta: TSTQuery
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
      
        'SELECT EMP_CODIGO, EMP_TIPO, EMP_FANTASIA, EMP_NOME, EMP_DT_FUND' +
        'A, EMP_DT_CADASTRO, END_ENDER,'
      
        ' END_CONTATO, END_BAIRRO, END_CEP, CDD_DESCRICAO,UFE_SIGLA, END_' +
        'COMPLEM'
      'FROM TB_EMPRESA tb_empresa '
      '  INNER JOIN TB_ENDERECO tb_endereco '
      '  ON(tb_endereco.END_CODEMP =  tb_empresa.EMP_CODIGO)'
      '   INNER JOIN tb_cidade tb_cidade'
      '   ON (tb_cidade.cdd_codigo = tb_endereco.end_codcdd)'
      ' INNER JOIN tb_uf tb_uf'
      '   ON (tb_uf.ufe_codigo = tb_endereco.end_codufe)'
      ' ')
    Left = 296
    Top = 24
    object Qr_MalaDiretaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_MalaDiretaEMP_TIPO: TIntegerField
      FieldName = 'EMP_TIPO'
      Origin = 'TB_EMPRESA.EMP_TIPO'
      Required = True
    end
    object Qr_MalaDiretaEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'TB_EMPRESA.EMP_FANTASIA'
      Size = 100
    end
    object Qr_MalaDiretaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_MalaDiretaEMP_DT_FUNDA: TDateField
      FieldName = 'EMP_DT_FUNDA'
      Origin = 'TB_EMPRESA.EMP_DT_FUNDA'
    end
    object Qr_MalaDiretaEMP_DT_CADASTRO: TDateField
      FieldName = 'EMP_DT_CADASTRO'
      Origin = 'TB_EMPRESA.EMP_DT_CADASTRO'
    end
    object Qr_MalaDiretaEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_MalaDiretaEND_CONTATO: TStringField
      FieldName = 'END_CONTATO'
      Origin = 'TB_ENDERECO.END_CONTATO'
      Size = 100
    end
    object Qr_MalaDiretaEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 25
    end
    object Qr_MalaDiretaEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_MalaDiretaEND_COMPLEM: TStringField
      FieldName = 'END_COMPLEM'
      Origin = 'TB_ENDERECO.END_COMPLEM'
      Size = 25
    end
    object Qr_MalaDiretaCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_MalaDiretaUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
  end
end
