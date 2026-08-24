inherited frx_MovimFinanceiro: Tfrx_MovimFinanceiro
  Caption = 'Frx_MovimFinanceiro'
  ClientHeight = 184
  ClientWidth = 311
  ExplicitWidth = 327
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 44392.412585370370000000
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
        Value = ''
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        inherited lbTitulo: TfrxMemoView
          Memo.UTF8W = (
            '[Titulo]')
        end
        inherited lbDocFiscal: TfrxMemoView
          Memo.UTF8W = (
            '[DocFiscal]')
        end
        inherited lbEndereco: TfrxMemoView
          Memo.UTF8W = (
            '[Endereco]')
        end
        inherited lbFones: TfrxMemoView
          Memo.UTF8W = (
            '[Fones]')
        end
        inherited lbWebSites: TfrxMemoView
          Memo.UTF8W = (
            '[website]')
        end
        inherited lbemail: TfrxMemoView
          Memo.UTF8W = (
            '[email]')
        end
        inherited lbNomeFantasia: TfrxMemoView
          Memo.UTF8W = (
            '[NomeFantasia]')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 381.732530000000000000
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
            end>
        end
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            '[Page]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object frxDBaseReportCREDITO: TfrxMemoView
          Left = 560.881889763780000000
          Width = 151.181102362205000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."CREDITO"]')
          ParentFont = False
        end
        object frxDBaseReportDEBITO: TfrxMemoView
          Left = 400.629921259843000000
          Width = 151.181102362205000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."DEBITO"]')
          ParentFont = False
        end
        object frxDBaseReportFPT_DESCRICAO: TfrxMemoView
          Left = 3.779527559055120000
          Width = 393.070866141732000000
          Height = 18.897650000000000000
          DataField = 'FPT_DESCRICAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[frxDBaseReport."FPT_DESCRICAO"]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          Left = 560.881889760000000000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cr'#233'dito')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 404.409710000000000000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'D'#233'bito')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 298.582870000000000000
        Width = 718.110700000000000000
        object Memo4: TfrxMemoView
          Left = 400.630180000000000000
          Top = 3.779530000000022000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."DEBITO">,MasterData1)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 560.882148500000000000
          Top = 3.779530000000022000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."CREDITO">,MasterData1)]')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Active = True
    SQL.Strings = (
      
        'SELECT F.fpt_descricao, SUM(M.mvf_vl_credito) CREDITO, SUM(M.mvf' +
        '_vl_debito) DEBITO'
      'FROM tb_movim_financeiro m'
      '  INNER JOIN tb_formapagto F'
      '  ON (F.fpt_codigo = M.mvf_codfpt)'
      'WHERE M.mvf_data > '#39'12/01/2018'#39
      'GROUP BY 1'
      'HAVING (SUM(M.mvf_vl_credito) >0) or (SUM(M.mvf_vl_debito)>0)')
  end
end
