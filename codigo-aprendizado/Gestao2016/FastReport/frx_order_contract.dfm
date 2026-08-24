object FrxOrderContract: TFrxOrderContract
  Left = 0
  Top = 0
  Caption = 'Contrato'
  ClientHeight = 193
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxBase: TfrxReport
    Version = '5.3.16'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43076.475621412000000000
    ReportOptions.LastChange = 44621.651515196800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '  '
      'begin'
      'end.')
    OnStartReport = 'frxBaseOnStartReport'
    Left = 32
    Top = 16
    Datasets = <
      item
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
      end>
    Variables = <
      item
        Name = ' CabecalhoEmpresa'
        Value = Null
      end
      item
        Name = 'NomeFantasia'
        Value = Null
      end
      item
        Name = 'DocFiscal'
        Value = Null
      end
      item
        Name = 'Endereco'
        Value = Null
      end
      item
        Name = 'Fones'
        Value = Null
      end
      item
        Name = 'email'
        Value = Null
      end
      item
        Name = 'website'
        Value = Null
      end
      item
        Name = 'Titulo'
        Value = Null
      end
      item
        Name = ' Footer'
        Value = Null
      end
      item
        Name = 'SumProduct'
        Value = Null
      end
      item
        Name = 'SumService'
        Value = Null
      end
      item
        Name = ' General'
        Value = Null
      end
      item
        Name = 'StrConnection'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        Stretched = True
        object Memo1: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          AllowExpressions = False
          AllowHTMLTags = True
          DataField = 'CONTENTS'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[frxDBaseReport."CONTENTS"]')
          WordBreak = True
        end
      end
    end
  end
  object frxPDFExport1: TfrxPDFExport
    FileName = 'relatorio.pdf'
    UseFileCache = True
    DefaultPath = 'c:\Sistema\'
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Compressed = False
    OpenAfterExport = True
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'Setes'
    Subject = 'Relat'#243'rio'
    ProtectionFlags = []
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 32
    Top = 64
  end
  object Qr_Consulta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select tb_pedido_id, contents'
      'from TB_CONTRACT_ORDER'
      'where TB_PEDIDO_ID = 6742')
    Left = 200
    Top = 16
  end
  object frxDBaseReport: TfrxDBDataset
    UserName = 'frxDBaseReport'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CONTENTS=CONTENTS')
    DataSet = Qr_Consulta
    BCDToCurrency = False
    Left = 112
    Top = 16
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 112
    Top = 72
  end
end
