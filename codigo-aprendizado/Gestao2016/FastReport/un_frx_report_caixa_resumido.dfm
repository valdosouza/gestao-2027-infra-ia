inherited Frx_report_caixa_resumido: TFrx_report_caixa_resumido
  Caption = 'Lan'#231'amento Caixa - Resumido'
  ClientWidth = 321
  ExplicitWidth = 337
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    PrintOptions.PrintMode = pmSplit
    ReportOptions.LastChange = 44146.822980381940000000
    ScriptText.Strings = (
      ''
      ''
      ''
      'begin'
      'end.')
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
      end
      item
        Name = 'usu_login'
        Value = ''
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 148.000000000000000000
      PaperSize = 256
      LeftMargin = 2.000000000000000000
      RightMargin = 2.000000000000000000
      Columns = 1
      ColumnWidth = 190.000000000000000000
      ColumnPositions.Strings = (
        '0')
      EndlessHeight = True
      inherited PageHeader1: TfrxPageHeader
        Width = 287.244280000000000000
        inherited lbTitulo: TfrxMemoView
          Width = 287.244280000000000000
          Height = 20.779530000000000000
          Memo.UTF8W = (
            '[Titulo]')
        end
        inherited Logo: TfrxPictureView
          Width = 13.936920000000000000
          Height = 17.070810000000000000
          Visible = False
        end
        inherited lbDocFiscal: TfrxMemoView
          Left = 3.259740000000000000
          Top = 16.220470000000000000
          Width = 279.685039370079000000
          Memo.UTF8W = (
            '[DocFiscal]')
        end
        inherited lbEndereco: TfrxMemoView
          Left = 3.259740000000000000
          Top = 35.220470000000000000
          Width = 279.685039370079000000
          Memo.UTF8W = (
            '[Endereco]')
        end
        inherited lbFones: TfrxMemoView
          Left = 3.259740000000000000
          Top = 53.220470000000010000
          Width = 279.685039370079000000
          Memo.UTF8W = (
            '[Fones]')
        end
        inherited lbWebSites: TfrxMemoView
          Left = 3.259740000000000000
          Top = 89.220470000000000000
          Width = 279.685039370079000000
          Memo.UTF8W = (
            '[website]')
        end
        inherited lbemail: TfrxMemoView
          Left = 3.259740000000000000
          Top = 71.220470000000000000
          Width = 279.685039370079000000
          Memo.UTF8W = (
            '[email]')
        end
        inherited lbNomeFantasia: TfrxMemoView
          Left = 3.000000000000000000
          Top = 3.779530000000001000
          Width = 279.685039370079000000
          Memo.UTF8W = (
            '[NomeFantasia]')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 457.323130000000000000
        Width = 287.244280000000000000
        inherited Memo41: TfrxMemoView
          Top = 2.220470000000034000
          Memo.UTF8W = (
            'Pagina N'#186)
        end
        inherited Memo42: TfrxMemoView
          Top = 2.000000000000057000
          Memo.UTF8W = (
            'Relat'#243'rio emitido em:')
        end
        inherited Memo1: TfrxMemoView
          Memo.UTF8W = (
            '[<Date>]  [<Time>]')
          Formats = <
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end>
        end
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            '[Page]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 283.464750000000000000
        Width = 287.244280000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object E_Descricao: TfrxMemoView
          Align = baLeft
          Top = 1.000000000000000000
          Width = 108.779530000000000000
          Height = 17.000000000000000000
          DataField = 'FPT_DESCRICAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."FPT_DESCRICAO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 204.921460000000000000
          Top = 1.000000000000000000
          Width = 82.322820000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."DEBITO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 120.118120000000000000
          Top = 1.000000000000000000
          Width = 81.023810000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."CREDITO"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 362.834880000000000000
        Width = 287.244280000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object e_Usuario: TfrxMemoView
          Align = baLeft
          Top = 41.574830000000020000
          Width = 282.637910000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[usu_login]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baRight
          Left = 201.141930000000000000
          Top = 20.787401574803080000
          Width = 86.102350000000000000
          Height = 13.228346456692900000
          AutoWidth = True
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."DEBITO">,MasterData1)]')
          ParentFont = False
          Formats = <
            item
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Align = baRight
          Left = 115.039580000000000000
          Top = 20.787401574803080000
          Width = 86.102350000000000000
          Height = 13.228346456692900000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."CREDITO">,MasterData1)]')
          ParentFont = False
          Formats = <
            item
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.787401574803080000
          Width = 105.826840000000000000
          Height = 13.228346456692900000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 207.874150000000000000
        Width = 287.244280000000000000
        object Memo6: TfrxMemoView
          Left = 2.000000000000000000
          Top = 5.000000000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lan'#231'amentos do Caixa')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 207.653680000000000000
          Top = 30.236240000000010000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'D'#233'bito')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 128.503937010000000000
          Top = 30.236240000000010000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Cr'#233'dito')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.236240000000010000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Formas de Pagamento')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Active = True
    SQL.Strings = (
      
        'SELECT FM.fpt_descricao,SUM(cx.mvf_vl_credito) CREDITO, SUM(cx.m' +
        'vf_vl_debito)DEBITO'
      ' FROM TB_MOVIM_FINANCEIRO cx'
      '  INNER JOIN TB_USUARIO us'
      '  ON (us.USU_CODIGO = cx.MVF_CODUSU)'
      '  INNER JOIN TB_FORMAPAGTO fm'
      '  ON (fm.FPT_CODIGO = cx.MVF_CODFPT)'
      'where cx.mvf_data >= '#39'07/01/2020'#39
      'GROUP BY 1')
  end
end
