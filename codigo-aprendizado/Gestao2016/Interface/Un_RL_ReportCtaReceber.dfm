inherited RL_ReportCtaReceber: TRL_ReportCtaReceber
  Caption = 'Relatorio de Contas a Receber'
  ClientHeight = 459
  ClientWidth = 847
  ExplicitWidth = 863
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      100.012500000000000000
      2970.000000000000000000
      100.012500000000000000
      2100.000000000000000000
      52.916666666666670000
      52.916666666666670000
      0.000000000000000000)
    Units = Pixels
    inherited PageHeader: TQRBand
      Left = 20
      Width = 754
      Height = 133
      Size.Values = (
        351.895833333333300000
        1994.958333333333000000)
      ExplicitLeft = 20
      ExplicitWidth = 754
      ExplicitHeight = 133
      inherited E_Titulo: TQRLabel
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          1899.708333333333000000)
        FontSize = 10
      end
      inherited Img_Logo: TQRImage
        Left = 7
        Top = 4
        Width = 150
        Height = 104
        Size.Values = (
          275.166666666666700000
          18.520833333333330000
          10.583333333333330000
          396.875000000000000000)
        ExplicitLeft = 7
        ExplicitTop = 4
        ExplicitWidth = 150
        ExplicitHeight = 104
      end
      inherited Lb_Emp_Nome: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          5.291666666666667000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Doc: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          52.916666666666660000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_End: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          103.187500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Fones: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          150.812500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_www: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          246.062500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_email: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          198.437500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
    end
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
    Left = 143
    Top = 16
    ParamData = <
      item
        DataType = ftInteger
        Name = 'FIN_CODEMP'
        ParamType = ptUnknown
        Size = 4
      end>
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
    Left = 224
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
end
