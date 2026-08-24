object RL_Etiq_MalaDireta: TRL_Etiq_MalaDireta
  Left = 314
  Top = 150
  Caption = 'Etiqueta para Mala-Direta'
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
    DataSet = Qr_MalaDireta
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
    object Qr_Etiqueta: TQRBand
      Left = 8
      Top = 49
      Width = 384
      Height = 160
      AlignToBottom = False
      BeforePrint = Qr_EtiquetaBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        423.333333333333300000
        1016.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRLabel1: TQRLabel
        Left = 0
        Top = 4
        Width = 58
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          10.583333333333330000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoStretch = True
        Caption = 'QRLabel1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
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
      object Lb_Nome: TQRLabel
        Left = 0
        Top = 2
        Width = 188
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          5.291666666666667000
          497.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoStretch = True
        Caption = 'Setes Gest'#227'o Computacional '
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
      object Lb_Endereco: TQRLabel
        Left = 0
        Top = 16
        Width = 146
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          42.333333333333330000
          386.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoStretch = True
        Caption = 'Rua Henrique Schuta, 35'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Cep: TQRLabel
        Left = 0
        Top = 47
        Width = 92
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          124.354166666666700000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoStretch = True
        Caption = 'Cep: 81130-060'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Compl_bairro: TQRLabel
        Left = 0
        Top = 31
        Width = 89
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          82.020833333333330000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoStretch = True
        Caption = 'CURITIBA - PR'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Impresso: TQRLabel
        Left = 0
        Top = 66
        Width = 98
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          174.625000000000000000
          259.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        AutoStretch = True
        Caption = 'I M P R E S S O'
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
        'A, EMP_DT_CADASTRO, END_ENDER,  END_CONTATO, END_BAIRRO, END_CEP' +
        ', CDD_DESCRICAO, UFE_SIGLA, END_COMPLEM, END_NUMERO'
      'FROM TB_EMPRESA tb_empresa '
      '  INNER JOIN TB_ENDERECO tb_endereco '
      '  ON(tb_endereco.END_CODEMP =  tb_empresa.EMP_CODIGO) '
      '  INNER JOIN TB_CIDADE TB_CIDADE'
      ' ON TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD'
      
        ' INNER JOIN tb_uf TB_uf  ON tb_uf.ufe_codigo = TB_ENDERECO.end_c' +
        'odufe ')
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
      Size = 100
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
    object Qr_MalaDiretaEND_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'TB_ENDERECO.END_NUMERO'
      Size = 10
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
