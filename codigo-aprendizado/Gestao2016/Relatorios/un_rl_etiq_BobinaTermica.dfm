object rl_etiq_BobinaTermica: Trl_etiq_BobinaTermica
  Left = 0
  Top = 0
  Caption = 'Etiqueta em Bobina T'#233'rmica'
  ClientHeight = 135
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxBase: TfrxReport
    Version = '5.3.16'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43076.475621412000000000
    ReportOptions.LastChange = 45019.745019178240000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '                                                '
      'begin'
      
        '  Page1.PaperWidth := <SizePage>;                               ' +
        '                                              '
      'end.')
    OnStartReport = 'frxBaseOnStartReport'
    Left = 32
    Top = 16
    Datasets = <>
    Variables = <
      item
        Name = ' CabecalhoEmpresa'
        Value = Null
      end
      item
        Name = 'Produto'
        Value = Null
      end
      item
        Name = 'Barras'
        Value = Null
      end
      item
        Name = 'Preco'
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
        Value = ''
      end
      item
        Name = 'SizePage'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 70.000000000000000000
      PaperSize = 256
      LeftMargin = 2.000000000000000000
      RightMargin = 2.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 190.000000000000000000
      ColumnPositions.Strings = (
        '0')
      EndlessHeight = True
      OnBeforePrint = 'Page1OnBeforePrint'
      OnManualBuild = 'Page1OnManualBuild'
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 158.740260000000000000
        Top = 18.897650000000000000
        Width = 287.244280000000000000
        object E_Produto: TfrxMemoView
          Left = 5.000000000000000000
          Top = 14.220470000000000000
          Width = 279.685220000000000000
          Height = 26.456710000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[Produto]')
          ParentFont = False
          WordWrap = False
        end
        object E_Barras: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.456710000000000000
          Width = 283.464750000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[Barras]')
          ParentFont = False
        end
        object E_VL_Preco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 283.464750000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -37
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Preco]')
          ParentFont = False
        end
        object e_data: TfrxMemoView
          Left = 3.779530000000000000
          Top = 109.606370000000000000
          Width = 283.464750000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dataprint]')
          ParentFont = False
        end
      end
    end
  end
end
