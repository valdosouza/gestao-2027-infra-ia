inherited Frx_report_caixa_detalhado: TFrx_report_caixa_detalhado
  Caption = 'CAixa Detalhado'
  ClientWidth = 321
  ExplicitWidth = 337
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    PrintOptions.PrintMode = pmSplit
    ReportOptions.LastChange = 44148.500557199080000000
    ScriptText.Strings = (
      ''
      'begin'
      '      '
      '    '
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
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 148.000000000000000000
      PaperSize = 256
      LeftMargin = 0.000000000000000000
      RightMargin = 3.000000000000000000
      Columns = 1
      ColumnWidth = 190.000000000000000000
      ColumnPositions.Strings = (
        '0')
      EndlessHeight = True
      inherited PageHeader1: TfrxPageHeader
        Height = 131.779530000000000000
        Width = 291.023810000000000000
        inherited lbTitulo: TfrxMemoView
          Width = 291.023810000000000000
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
        Top = 464.882190000000000000
        Width = 291.023810000000000000
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
        Top = 287.244280000000000000
        Width = 291.023810000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object E_Descricao: TfrxMemoView
          Align = baLeft
          Top = 1.889763780000010000
          Width = 195.708720000000000000
          Height = 15.118110240000000000
          DataField = 'MVF_HISTORISCO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."MVF_HISTORISCO"]')
          ParentFont = False
        end
        object E_Valor: TfrxMemoView
          Align = baRight
          Left = 204.921460000000000000
          Top = 1.889763780000010000
          Width = 86.102350000000000000
          Height = 15.118110240000000000
          AutoWidth = True
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxDBaseReport."MVF_VL_CREDITO"> > 0,<frxDBaseReport."MVF_' +
              'VL_CREDITO">,<frxDBaseReport."MVF_VL_DEBITO">)]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 370.393940000000000000
        Width = 291.023810000000000000
        object Memo4: TfrxMemoView
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
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Usu'#225'rio : [frxDBaseReport."USU_LOGIN"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 177.637910000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[SUM(<frxDBaseReport."MVF_VL_CREDITO">,MasterData1) - SUM(<frxDB' +
              'aseReport."MVF_VL_DEBITO">,MasterData1)]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor total')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 211.653680000000000000
        Width = 291.023810000000000000
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
        object Lb_Valor: TfrxMemoView
          Align = baRight
          Left = 211.653680000000000000
          Top = 29.236240000000010000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Top = 29.236240000000010000
          Width = 196.535560000000000000
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
      
        'SELECT cx.MVF_DATA, cx.MVF_HISTORISCO,cx.mvf_vl_credito, cx.mvf_' +
        'vl_debito, us.USU_LOGIN'
      'from tb_movim_financeiro cx'
      '  INNER JOIN tb_usuario us'
      '  on (us.usu_codigo = cx.mvf_codusu)'
      'where cx.mvf_data >='#39'07/11/2020'#39)
  end
end
