inherited frx_ReportCtaReceber: Tfrx_ReportCtaReceber
  Caption = 'frx_ReportCtaReceber'
  ClientWidth = 389
  ExplicitWidth = 405
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 43115.451594560200000000
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
        Value = ''
      end
      item
        Name = 'DocFiscal'
        Value = ''
      end
      item
        Name = 'Endereco'
        Value = ''
      end
      item
        Name = 'Fones'
        Value = ''
      end
      item
        Name = 'email'
        Value = ''
      end
      item
        Name = 'website'
        Value = ''
      end
      item
        Name = ' Footer'
        Value = Null
      end
      item
        Name = 'SumProduct'
        Value = ''
      end
      item
        Name = 'SumService'
        Value = ''
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        Height = 132.779530000000000000
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
        Top = 211.653680000000000000
        inherited Memo41: TfrxMemoView
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
    end
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      
        'SELECT FIN_CODQTC, FIN_DT_VENCIMENTO,FIN_DT_PAGTO,FIN_CODEMP, EM' +
        'P_NOME, EMP_FANTASIA,'
      
        'END_FONE, END_REGIAO, FIN_NUMERO,FIN_VL_PARCELA, FIN_VL_PAGO,FIN' +
        '_CODFPG,FIN_BAIXA,'
      
        'FIN_OPERACAO,FIN_CODMHA,FIN_CODPED, FIN_CODCHQ,FIN_CODNFL, FIN_T' +
        'IPO, FIN_SITUACAO,FIN_DT_REPROGRAMADA'
      'FROM TB_FINANCEIRO Tb_financeiro'
      '   INNER JOIN TB_EMPRESA Tb_empresa'
      '   ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP)'
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   LEFT OUTER JOIN TB_PEDIDO'
      '   ON (PED_CODIGO = FIN_CODPED)')
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  NFL_DT_EMISSAO,'
      '  NFL_VL_TL_NOTA,'
      '  NFL_CODIGO,'
      '  PED_NUMERO,'
      '  NFL_NUMERO,'
      '  FIN_CODMHA'
      'FROM'
      '  TB_NOTA_FISCAL tb_nota_fiscal'
      'INNER JOIN TB_FINANCEIRO tb_financeiro'
      'ON (tb_financeiro.FIN_CODPED = tb_nota_fiscal.NFL_CODPED)'
      '    AND (tb_financeiro.fin_codnfl = tb_nota_fiscal.nfl_codigo)'
      'LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      'ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      'WHERE'
      '  (FIN_CODQTC =:FIN_CODQTC) AND (FIN_CODMHA=:FIN_CODMHA)'
      '  AND  NFL_CODIGO = :NFL_CODIGO')
    Left = 344
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODQTC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FIN_CODMHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Clientes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  EMP_CODIGO,'
      '  EMP_FANTASIA,'
      '  EMP_NOME,'
      '  EMP_VL_CRED,'
      '  EMP_DT_CADASTRO,'
      '  END_FONE'
      'FROM'
      '  TB_EMPRESA tb_empresa'
      'INNER JOIN TB_ENDERECO tb_endereco'
      'ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'WHERE'
      '  EMP_CODIGO =:FIN_CODEMP'
      'ORDER BY'
      '  EMP_FANTASIA')
    Left = 263
    Top = 16
    ParamData = <
      item
        DataType = ftInteger
        Name = 'FIN_CODEMP'
        ParamType = ptUnknown
        Size = 4
      end>
  end
end
