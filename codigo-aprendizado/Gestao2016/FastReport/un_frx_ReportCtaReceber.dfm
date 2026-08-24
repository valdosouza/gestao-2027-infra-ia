inherited frx_ReportCtaReceber: Tfrx_ReportCtaReceber
  Caption = 'frx_ReportCtaReceber'
  ClientWidth = 291
  ExplicitWidth = 307
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 43161.697661585640000000
    ScriptText.Strings = (
      ''
      '      '
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
        inherited Memo41: TfrxMemoView
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
    end
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      
        'SELECT FIN_CODQTC, FIN_DT_VENCIMENTO,FIN_DT_PAGTO,FIN_CODEMP, EM' +
        'P_NOME, EMP_FANTASIA,'
      
        ' END_FONE, END_REGIAO, FIN_NUMERO,FIN_VL_PARCELA, FIN_VL_PAGO,FI' +
        'N_CODFPG,FIN_BAIXA,nf.nfl_dt_emissao,'
      
        ' FIN_OPERACAO,FIN_CODMHA,FIN_CODPED, FIN_CODCHQ,FIN_CODNFL, FIN_' +
        'TIPO, FIN_SITUACAO,FIN_DT_REPROGRAMADA'
      ' FROM TB_FINANCEIRO fn'
      '    INNER JOIN tb_nota_fiscal nf'
      '    on (nf.nfl_codigo = fn.fin_codnfl)'
      '    INNER JOIN TB_EMPRESA ep'
      '    ON  (ep.EMP_CODIGO = fn.FIN_CODEMP)'
      '    INNER JOIN TB_PEDIDO  pd'
      '    ON (pd.PED_CODIGO = fn.FIN_CODPED)'
      '    INNER JOIN TB_ENDERECO ed'
      '    ON (eD.END_CODIGO = PD.ped_codend)'
      'UNION'
      
        'SELECT FIN_CODQTC, FIN_DT_VENCIMENTO,FIN_DT_PAGTO,FIN_CODEMP, EM' +
        'P_NOME, EMP_FANTASIA,'
      
        ' END_FONE, END_REGIAO, FIN_NUMERO,FIN_VL_PARCELA, FIN_VL_PAGO,FI' +
        'N_CODFPG,FIN_BAIXA,nf.nfl_dt_emissao,'
      
        ' FIN_OPERACAO,FIN_CODMHA,FIN_CODPED, FIN_CODCHQ,FIN_CODNFL, FIN_' +
        'TIPO, FIN_SITUACAO,FIN_DT_REPROGRAMADA'
      ' FROM TB_FINANCEIRO fn'
      '    INNER JOIN tb_nota_fiscal nf'
      '    on (nf.nfl_codigo = fn.fin_codnfl)'
      '    INNER JOIN TB_EMPRESA ep'
      '    ON  (ep.EMP_CODIGO = fn.FIN_CODEMP)'
      '    INNER JOIN TB_ENDERECO ed'
      '    ON (eD.end_codemp = fn.fin_codemp)'
      'where ed.end_principal = '#39'S'#39' AND FN.fin_codped = 0')
  end
end
