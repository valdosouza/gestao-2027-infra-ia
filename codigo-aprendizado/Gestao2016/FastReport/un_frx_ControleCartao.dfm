inherited frx_ControleCartao: Tfrx_ControleCartao
  Caption = 'Controle de Cart'#227'o'
  ClientWidth = 384
  ExplicitWidth = 400
  ExplicitHeight = 191
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 43909.594247013890000000
    ScriptText.Strings = (
      'var'
      
        '  It_Repeticao : Integer;                                       ' +
        '       '
      '  It_Nr_Parcelas : Integer;'
      ''
      '                      '
      '  DataVencimento : String;                      '
      '  VL_Receber : Real;'
      '  Ordem : String;            '
      ''
      '  Parcelado : String;'
      '  Vl_Parcela : Real;'
      ''
      ''
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'Var'
      '  Lc_data : TDAteTime;'
      '  Lc_Vl_Receber : REal;'
      '  Lc_Vl_Parcela : Real;                            '
      'Begin'
      '  Lc_Data            := <frxDBaseReport."NFL_DT_EMISSAO"> ;'
      
        '  Lc_Data            := Lc_Data + (  <frxDBaseReport."CTE_PRZO_D' +
        'EBI"> * It_Repeticao);'
      '  DataVencimento               := DateToStr(Lc_Data) ;'
      '  if <frxDBaseReport."MVF_VL_FUTURO"> > 0 then'
      '    Lc_Vl_Parcela    := <frxDBaseReport."MVF_VL_FUTURO">'
      '  else'
      '    Lc_Vl_Parcela    := <frxDBaseReport."MVF_VL_CREDITO">;'
      
        '  Lc_Vl_Receber      := (Lc_Vl_Parcela * <frxDBaseReport."CTE_AL' +
        'IQ_CRED"> )/100;'
      '  Lc_Vl_Receber      := Lc_Vl_Parcela - Lc_Vl_Receber;'
      '  VL_Receber         := Lc_Vl_Receber;'
      ''
      '  '
      
        '  Ordem              := IntToStr(It_Repeticao) + '#39'/'#39' + IntToStr(' +
        'It_Nr_Parcelas);'
      ''
      '  Parcelado          := IntToStr(It_Nr_Parcelas);'
      '  Vl_Parcela         := Lc_Vl_Parcela;'
      '  inc(It_Repeticao);'
      'end;'
      ''
      'procedure Page1OnBeforePrint_inherited(Sender: TfrxComponent);'
      'begin'
      '    It_Repeticao := 1;'
      
        '    It_Nr_Parcelas := MasterData.Dataset.RecordCount            ' +
        '                                               '
      'end;'
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
        Name = 'Repeticao'
        Value = ''
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      Columns = 2
      ColumnWidth = 95.000000000000000000
      ColumnPositions.Strings = (
        '0'
        '95')
      OnBeforePrint = 'Page1OnBeforePrint_inherited'
      inherited PageHeader1: TfrxPageHeader
        Visible = False
        OnBeforePrint = 'PageHeader1OnBeforePrint_inherited'
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
        Top = 517.795610000000000000
        inherited Memo41: TfrxMemoView
          Top = 2.220469999999978000
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
      object MasterData: TfrxMasterData
        FillType = ftBrush
        Height = 249.448980000000000000
        Top = 207.874150000000000000
        Width = 359.055350000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        AllowSplit = True
        ColumnWidth = 19653.543307086600000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        KeepTogether = True
        RowCount = 0
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 359.055350000000000000
          Height = 249.448980000000000000
        end
        object E_NomeCliente: TfrxMemoView
          Left = 64.252010000000000000
          Top = 7.559059999999988000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DataField = 'NOMECLIENTE'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[frxDBaseReport."NOMECLIENTE"]')
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559059999999988000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Cliente')
        end
        object Memo4: TfrxMemoView
          Left = 234.330860000000000000
          Top = 3.779529999999994000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Data:')
        end
        object E_Data: TfrxMemoView
          Left = 275.905690000000000000
          Top = 3.779529999999994000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[DataVencimento]')
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000010000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Pedido:')
        end
        object E_Nr_Pedido: TfrxMemoView
          Left = 64.252010000000000000
          Top = 34.015770000000010000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PED_NUMERO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[frxDBaseReport."PED_NUMERO"]')
        end
        object Memo6: TfrxMemoView
          Left = 234.330860000000000000
          Top = 30.236240000000010000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Valor:')
        end
        object E_VL_Receber: TfrxMemoView
          Left = 283.464750000000000000
          Top = 30.236240000000010000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = cl3DDkShadow
          HAlign = haRight
          Memo.UTF8W = (
            '[VL_Receber]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 234.330860000000000000
          Top = 52.913419999999970000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Ordem')
        end
        object E_Ordem: TfrxMemoView
          Left = 287.244280000000000000
          Top = 52.913419999999970000
          Width = 68.031540000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Ordem]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 83.149660000000040000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Valor Total Venda:')
        end
        object E_VL_NotaFiscal: TfrxMemoView
          Left = 124.724490000000000000
          Top = 83.149660000000040000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'NFL_VL_TL_NOTA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = cl3DDkShadow
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_TL_NOTA"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 109.606370000000100000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Parcelando em: ')
        end
        object E_Parcelado: TfrxMemoView
          Left = 124.724490000000000000
          Top = 109.606370000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = cl3DDkShadow
          HAlign = haCenter
          Memo.UTF8W = (
            '[Parcelado]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 132.283550000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Valor parcela:')
        end
        object E_Vl_Parcela: TfrxMemoView
          Left = 124.724490000000000000
          Top = 132.283550000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = cl3DDkShadow
          HAlign = haRight
          Memo.UTF8W = (
            '[Vl_Parcela]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 3.779530000000000000
          Top = 170.078850000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Taxa do Cart'#227'o')
        end
        object E_Taxa_Cartao: TfrxMemoView
          Left = 124.724490000000000000
          Top = 170.078850000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'CTE_ALIQ_CRED'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = cl3DDkShadow
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."CTE_ALIQ_CRED"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 3.779530000000000000
          Top = 196.535560000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Lan'#231'a na C/C do Banco:')
        end
        object E_Banco: TfrxMemoView
          Left = 162.519790000000000000
          Top = 196.535560000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          DataField = 'NOMEBANCO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Fill.BackColor = cl3DDkShadow
          Memo.UTF8W = (
            '[frxDBaseReport."NOMEBANCO"]')
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 219.212740000000100000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Cart'#227'o')
        end
        object E_Cartao: TfrxMemoView
          Left = 68.031540000000000000
          Top = 219.212740000000100000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          DataField = 'CTE_DESCRICAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Fill.BackColor = cl3DDkShadow
          Memo.UTF8W = (
            '[frxDBaseReport."CTE_DESCRICAO"]')
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Transaction = DM.IBT_Report
    SQL.Strings = (
      'SELECT  DISTINCT'
      'c.EMP_NOME NOMECLIENTE,'
      'NFL_DT_EMISSAO,'
      'PED_NUMERO,'
      'CTE_DESCRICAO,'
      'CTE_PRZO_DEBI,'
      'NFL_VL_TL_NOTA,'
      'mf.mvf_vl_credito,'
      'mf.mvf_vl_debito,'
      'mf.mvf_vl_futuro,'
      'FIN_VL_PARCELA,'
      'fin_codfpg,'
      'CTE_ALIQ_CRED,'
      'banco.EMP_NOME NOMEBANCO,'
      'mf.mvf_codigo'
      'FROM tb_financeiro f'
      '   INNER JOIN tb_empresa c'
      '   on (c.emp_codigo = f.fin_codemp)'
      ''
      '   LEFT JOIN tb_pedido p'
      '   on (p.PED_CODIGO = f.FIN_CODPED)'
      ''
      '   INNER JOIN tb_nota_fiscal n'
      '   ON (n.nfl_codigo = f.FIN_CODNFL)'
      ''
      '   INNER JOIN tb_cartaoeletronico ce'
      '   ON (ce.cte_codfpt = f.fin_codfpg)'
      ''
      '   INNER JOIN tb_contabancaria cb'
      '   ON (cb.ctb_codigo = ce.cte_codctb)'
      ''
      '   INNER JOIN tb_empresa banco'
      '   on (banco.emp_codigo = cb.ctb_codbco)'
      ''
      '   inner join tb_movim_financeiro mf'
      '   on (mf.mvf_codqtc = f.fin_codqtc)'
      ''
      'where  ( FIN_CODQTC =:FIN_CODQTC )'
      'and ( FIN_CODIGO=:FIN_CODIGO )'
      'and  ( (mf.mvf_vl_futuro > 0 ) or (mf.mvf_vl_credito > 0 ) )'
      'order by mf.mvf_data asc , mf.mvf_vl_futuro desc')
    ParamData = <
      item
        DataType = ftWideString
        Name = 'FIN_CODQTC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FIN_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
