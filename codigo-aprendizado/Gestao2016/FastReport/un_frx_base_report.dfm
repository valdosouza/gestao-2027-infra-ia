object FrxBaseReport: TFrxBaseReport
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio Geral'
  ClientHeight = 152
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
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
    ReportOptions.LastChange = 44552.525616284720000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '  '
      'begin'
      'end.')
    OnBeforePrint = frxBaseBeforePrint
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
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 129.000000000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object lbTitulo: TfrxMemoView
          Align = baWidth
          Top = 111.000000000000000000
          Width = 718.110700000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 2.000000000000000000
          Memo.UTF8W = (
            '[Titulo]')
          ParentFont = False
        end
        object Logo: TfrxPictureView
          Left = 7.000000000000000000
          Top = 4.000000000000000000
          Width = 150.000000000000000000
          Height = 104.000000000000000000
          FileLink = 'C:\Modelos\Gestao2016\Bin\logo.jpg'
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object lbDocFiscal: TfrxMemoView
          Left = 162.000000000000000000
          Top = 20.000000000000000000
          Width = 539.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DocFiscal]')
          ParentFont = False
        end
        object lbEndereco: TfrxMemoView
          Left = 162.000000000000000000
          Top = 39.000000000000000000
          Width = 539.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[Endereco]')
          ParentFont = False
        end
        object lbFones: TfrxMemoView
          Left = 162.000000000000000000
          Top = 57.000000000000000000
          Width = 539.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[Fones]')
          ParentFont = False
        end
        object lbWebSites: TfrxMemoView
          Left = 162.000000000000000000
          Top = 93.000000000000000000
          Width = 539.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[website]')
          ParentFont = False
        end
        object lbemail: TfrxMemoView
          Left = 162.000000000000000000
          Top = 75.000000000000000000
          Width = 539.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[email]')
          ParentFont = False
        end
        object lbNomeFantasia: TfrxMemoView
          Left = 161.740260000000000000
          Width = 539.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NomeFantasia]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 23.000000000000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        object Memo41: TfrxMemoView
          Left = 596.503710000000000000
          Top = 2.220470000000006000
          Width = 64.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pagina N'#186)
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 4.000000000000000000
          Top = 2.000000000000000000
          Width = 139.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Relat'#243'rio emitido em:')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 151.181200000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[<Date>]  [<Time>]')
          Formats = <
            item
              Kind = fkDateTime
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          Left = 668.976810000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[Page]')
        end
      end
    end
  end
  object frxDBaseReport: TfrxDBDataset
    UserName = 'frxDBaseReport'
    CloseDataSource = False
    DataSet = Qr_Consulta
    BCDToCurrency = False
    Left = 112
    Top = 16
  end
  object Qr_Consulta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 200
    Top = 16
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
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 112
    Top = 64
  end
end
