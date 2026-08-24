inherited frx_ReportProductstatement: Tfrx_ReportProductstatement
  Caption = 'Movimento de Produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 43607.966254652800000000
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      inherited PageHeader1: TfrxPageHeader
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        inherited lbTitulo: TfrxMemoView
          Width = 1046.929810000000000000
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
        Width = 1046.929810000000000000
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
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 207.874150000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBaseReport."PRO_CODIGO"'
        StartNewPage = True
        object Memo3: TfrxMemoView
          Left = 26.456710000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBaseReport."CET_CODPRO"]')
        end
        object Memo4: TfrxMemoView
          Left = 158.740260000000000000
          Top = 3.779529999999994000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBaseReport."PRO_DESCRICAO"]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 253.228510000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object Memo5: TfrxMemoView
          Left = 18.897650000000000000
          Top = 3.779529999999994000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBaseReport."CET_QTDE"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 298.582870000000000000
        Width = 1046.929810000000000000
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Active = True
    SQL.Strings = (
      
        'SELECT DISTINCT PRO_CODIGO , CET_DATA, PRO_DESCRICAO, CET_OPERAC' +
        'AO, CET_CODPRO,'
      
        'ITF_CODIGO, PED_NUMERO,  tb_cliente.EMP_FANTASIA, CET_QTDE,ITF_V' +
        'L_UNIT,'
      
        'PED_TIPO,tb_cliente.EMP_nome, (CET_QTDE * ITF_VL_UNIT) as ITV_SU' +
        'BTOTAL,'
      'PRO_VL_CUSTOMED,PED_CODIGO'
      'FROM TB_PEDIDO tb_pedido'
      'INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      'ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO)'
      'INNER JOIN tb_ctrl_estoque ce'
      'ON (ce.cet_item_ctrl = tb_itens_nfl.itf_codigo)'
      'INNER JOIN TB_PRODUTO tb_produto'
      'ON (tb_produto.PRO_CODIGO = ce.cet_CODPRO)'
      'INNER JOIN TB_EMPRESA tb_cliente'
      'ON (tb_cliente.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      'INNER JOIN TB_ESTOQUE tb_estoque'
      'ON (tb_estoque.EST_CODPRO = ce.CET_CODPRO)'
      'INNER JOIN TB_ESTOQUES tb_estoques'
      'ON (tb_estoques.ETS_CODIGO = tb_estoque.EST_CODETS)'
      'WHERE (PED_CODIGO IS NOT NULL)'
      'and ce.cet_vinculo = '#39'P'#39
      'AND (CET_DATA BETWEEN '#39'12/01/2018'#39' AND '#39'12/31/9999'#39')'
      'AND (PED_CODMHA =27)'
      'AND ITF_CODEST = 1'
      
        'Union SELECT DISTINCT pd.PRO_CODIGO,CET_DATA, PRO_DESCRICAO, CET' +
        '_OPERACAO, CET_CODPRO, PRE_CODIGO,'
      
        'ORP_NUMERO PED_NUMERO, '#39'Produ'#231#227'o - Mat'#233'ria Prima'#39' EMP_FANTASIA, ' +
        'CET_QTDE, pd.pro_vl_custo as ITF_VL_UNIT ,'
      
        '4 PED_TIPO, '#39'Produ'#231#227'o - Mat'#233'ria Prima'#39' EMP_nome, (orpma.pre_qtdu' +
        'ni * pd.pro_vl_custo ) as ITV_SUBTOTAL,'
      'pd.PRO_VL_CUSTOMED, ORP_CODIGO PED_CODIGO'
      'FROM TB_ORP orp'
      'INNER JOIN tb_orpprev orpma'
      'ON (orpma.pre_codorp = orp.orp_codigo)'
      'INNER JOIN tb_ctrl_estoque ce'
      'ON (ce.cet_item_ctrl = orpma.pre_codigo)'
      'INNER JOIN TB_PRODUTO pd'
      'ON (pd.PRO_CODIGO = orpma.PRE_codpro)'
      'WHERE (ORP_CODIGO IS NOT NULL)'
      'and ce.cet_vinculo = '#39'M'#39
      'AND (CET_DATA BETWEEN '#39'12/01/2018'#39' AND '#39'12/31/9999'#39')'
      'AND CET_CODETS = 1'
      'AND (ORP_CODMHA =27)'
      
        'Union SELECT DISTINCT pd.PRO_CODIGO,CET_DATA, PRO_DESCRICAO, CET' +
        '_OPERACAO, CET_CODPRO, ORP_CODIGO, ORP_NUMERO  PED_NUMERO,'
      
        #39'Produ'#231#227'o - Produto Acabado'#39' EMP_FANTASIA,  CET_QTDE, pd.pro_vl_' +
        'custo as ITF_VL_UNIT , 5 PED_TIPO,'
      
        #39'Produ'#231#227'o - Produto Acabado'#39' EMP_nome,  (orppa.ORL_QTDTOT * pd.p' +
        'ro_vl_custo ) as ITV_SUBTOTAL,'
      'pd.PRO_VL_CUSTOMED, ORP_CODIGO PED_CODIGO'
      'FROM TB_ORP orp'
      'INNER JOIN tb_orpreal orppa'
      'ON (orppa.orl_codorp = orp.orp_codigo)'
      'INNER JOIN tb_ctrl_estoque ce'
      'ON (ce.cet_item_ctrl = orppa.orl_codigo)'
      'INNER JOIN TB_PRODUTO pd'
      'ON (pd.PRO_CODIGO = orppa.ORL_codpro)'
      'WHERE (ORP_CODIGO IS NOT NULL)'
      'and ce.cet_vinculo = '#39'O'#39
      'AND (CET_DATA BETWEEN '#39'12/01/2018'#39' AND '#39'12/31/9999'#39')'
      'AND CET_CODETS = 1'
      'AND (ORP_CODMHA =27)'
      'ORDER BY 1 , 2, 3, 4')
  end
end
