inherited FrxReportBaseTroca: TFrxReportBaseTroca
  Caption = 'Relat'#243'rio de Base de Troca'
  ClientWidth = 349
  ExplicitWidth = 365
  ExplicitHeight = 191
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 44699.605258379630000000
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
      inherited PageHeader1: TfrxPageHeader
        Height = 144.118120000000000000
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
          Top = 57.000000000000000000
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
        Top = 411.968770000000000000
        inherited Memo41: TfrxMemoView
          Top = 2.220469999999980000
          Memo.UTF8W = (
            'Pagina N'#186)
        end
        inherited Memo42: TfrxMemoView
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
        Height = 18.897650000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object frxDBaseReportDT_OUT: TfrxMemoView
          Left = 3.779527560000000000
          Width = 83.149606299212600000
          Height = 15.118120000000000000
          DataField = 'DATASAIDA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."DATASAIDA"]')
          ParentFont = False
        end
        object frxDBaseReportPED_NUMERO: TfrxMemoView
          Left = 88.062982360000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DataField = 'PED_NUMERO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PED_NUMERO"]')
          ParentFont = False
        end
        object frxDBaseReportWEIGHT_OUT: TfrxMemoView
          Left = 383.244094488189000000
          Width = 73.322834650000000000
          Height = 15.118120000000000000
          DataField = 'PESOSAIDA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PESOSAIDA"]')
          ParentFont = False
        end
        object frxDBaseReportWEIGHT_IN: TfrxMemoView
          Left = 459.590551181102400000
          Width = 84.661417320000000000
          Height = 15.118120000000000000
          DataField = 'PESOENTRADA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PESOENTRADA"]')
          ParentFont = False
        end
        object frxDBaseReportDT_IN: TfrxMemoView
          Left = 546.897637795275600000
          Width = 82.015748030000000000
          Height = 15.118120000000000000
          DataField = 'DATAENTRADA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."DATAENTRADA"]')
          ParentFont = False
        end
        object frxDBaseReportSALDO: TfrxMemoView
          Left = 631.181102362204700000
          Width = 84.661417320000000000
          Height = 15.118120000000000000
          DataField = 'SALDO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."SALDO"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 164.409424410000000000
          Width = 216.944960000000000000
          Height = 15.118120000000000000
          DataField = 'PRO_DESCRICAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PRO_DESCRICAO"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Description = 'Data de Vencimento'
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 222.992270000000000000
        Width = 718.110700000000000000
        Condition = 'frxDBaseReport."TB_CUSTOMER_ID"'
        object Memo3: TfrxMemoView
          Left = 3.559060000000000000
          Width = 494.291590000000000000
          Height = 20.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBaseReport."EMP_FANTASIA"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 40.795300000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 88.062982360000000000
          Top = 22.677180000000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#186' Pedido')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 546.897637795275600000
          Top = 22.677180000000000000
          Width = 82.015748030000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Entrada')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 459.590551181102400000
          Top = 22.677180000000000000
          Width = 84.661417320000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Entrada')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779527560000000000
          Top = 22.677180000000000000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Sa'#237'da')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 383.244094488189000000
          Top = 22.677180000000000000
          Width = 73.322834650000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Sa'#237'da')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 631.181102362204700000
          Top = 22.677180000000000000
          Width = 84.661417320000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Saldo')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 164.409424410000000000
          Top = 22.677180000000000000
          Width = 133.795300000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 328.819110000000000000
        Width = 718.110700000000000000
        object Memo5: TfrxMemoView
          Left = 619.842920000000000000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."SALDO">,MasterData1)]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 510.236550000000000000
          Width = 89.574817800000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Saldo Total')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      'Select'
      'ep.emp_nome,'
      'ep.emp_fantasia,'
      'pd.PED_NUMERO,'
      'PR.pro_descricao,'
      'Max(eb.dt_in) DataEntrada,'
      'Max(eb.dt_out) DataSaida,'
      'sum(weight_out) PesoSaida,'
      'sum(weight_in) PesoEntrada,'
      'sum(weight_out - weight_in) saldo'
      'from tb_exchange_basis eb '
      '   inner join tb_produto pr '
      '   on (pr.pro_codigo = eb.tb_product_id) '
      '   inner join tb_empresa ep '
      '   on (ep.emp_codigo = eb.tb_customer_id) '
      '   inner join tb_colaborador cl '
      '   on (cl.clb_codigo = eb.tb_salesman_id) '
      '   inner join tb_itens_nfl it '
      '   on (it.itf_codigo = eb.tb_order_item_id) '
      '   inner join tb_usuario us '
      '   on (us.usu_codigo = eb.tb_user_id) '
      '   left outer join tb_pedido pd '
      '   on (pd.PED_CODIGO = eb.TB_ORDER_ID) '
      'WHERE (eb.TB_INSTITUTION_ID >0 )'
      'group by 1,2,3,4'
      'order by emp_fantasia')
  end
end
