inherited Frx_report_sangria: TFrx_report_sangria
  Caption = 'Sangria'
  ClientWidth = 321
  ExplicitWidth = 337
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    PrintOptions.PrintMode = pmSplit
    ReportOptions.LastChange = 44124.512833530100000000
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
          Top = 53.220470000000000000
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
          Top = 3.779530000000000000
          Width = 279.685039370000000000
          Memo.UTF8W = (
            '[NomeFantasia]')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 438.425480000000000000
        Width = 287.244280000000000000
        inherited Memo41: TfrxMemoView
          Top = 2.220470000000030000
          Memo.UTF8W = (
            'Pagina N'#186)
        end
        inherited Memo42: TfrxMemoView
          Top = 2.000000000000060000
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
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
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
        Height = 22.677180000000000000
        Top = 260.787570000000000000
        Width = 287.244280000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object E_Descricao: TfrxMemoView
          Align = baLeft
          Top = 2.000000000000000000
          Width = 195.708720000000000000
          Height = 17.000000000000000000
          DataField = 'MVF_HISTORISCO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."MVF_HISTORISCO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 201.141930000000000000
          Width = 86.102350000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataField = 'MVF_VL_DEBITO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."MVF_VL_DEBITO"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 343.937230000000000000
        Width = 287.244280000000000000
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 41.574830000000000000
          Width = 282.637910000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Usu'#225'rio : [frxDBaseReport."USU_LOGIN"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 30.236240000000000000
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
            'Retirada/Sangria do Caixa')
          ParentFont = False
        end
      end
    end
  end
  inherited frxDBaseReport: TfrxDBDataset
    CloseDataSource = True
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      
        'select mv.mvf_data, mv.mvf_historisco, mv.mvf_vl_debito, us.usu_' +
        'login'
      'from tb_movim_financeiro mv'
      '  INNER JOIN tb_usuario us'
      '  on (us.usu_codigo = mv.mvf_codusu)'
      'where mv.mvf_codigo =:mvf_codigo')
    ParamData = <
      item
        DataType = ftWideString
        Name = 'mvf_codigo'
        ParamType = ptUnknown
      end>
  end
end
