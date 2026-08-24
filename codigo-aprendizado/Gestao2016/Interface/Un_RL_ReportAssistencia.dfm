inherited RL_ReportAssistencia: TRL_ReportAssistencia
  Caption = 'Relatorio de Assist'#234'ncia'
  ClientHeight = 445
  ClientWidth = 831
  ExplicitWidth = 839
  ExplicitHeight = 472
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      70.000000000000000000
      75.000000000000000000
      0.000000000000000000)
    inherited PageHeader: TQRBand
      Size.Values = (
        341.312500000000000000
        1955.270833333333000000)
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
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      
        'SELECT  ASS_CODEMP, ASS_CODIGO, ASS_NUMERO, ASS_PEDIDO, ASS_PRAZ' +
        'O,'
      'EMP_NOME, '
      'EMP_FANTASIA, '
      'EMP_CODIGO, '
      'END_ENDER, '
      'END_NUMERO, '
      'END_CEP, '
      'END_FONE,  '
      'END_BAIRRO, '
      'END_CELULAR, '
      'CDD_DESCRICAO,'
      'UFE_SIGLA,'
      'END_FAX,'
      'EMP_CNPJ, '
      'EMP_INSC_EST, '
      'EMP_EMAIL'
      'FROM TB_ASSISTENCIA  tb_assistencia'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_assistencia.ASS_CODEMP)'
      '         INNER JOIN TB_ENDERECO tb_endereco'
      '         ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '         INNER JOIN TB_CIDADE'
      '         ON (TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '        ON (tb_uf.UFE_CODIGO = TB_ENDERECO.END_CODUFE)'
      'WHERE ASS_CODIGO=:ASS_CODIGO AND (END_PRINCIPAL = '#39'S'#39')')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ASS_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Itens_ass: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  IAS_CODIGO,'
      '  IAS_CODASS,'
      '  IAS_ETAPA,'
      '  IAS_DATA,'
      '  IAS_DESCRITIVO,'
      '  IAS_DT_PREVISTA,'
      '  IAS_VL_CLIENTE,'
      '  IAS_VL_CUSTO,'
      '  IAS_DT_REALIZADA,'
      '  IAS_CODSIT,'
      '  SIT_DESCRICAO'
      'FROM TB_ITENS_ASS tb_itens_ass'
      '   LEFT OUTER JOIN TB_SITUACAO tb_situacao'
      '   ON (tb_situacao.SIT_CODIGO = tb_itens_ass.IAS_CODSIT)'
      'WHERE IAS_CODASS=:ASS_CODIGO'
      'ORDER BY IAS_ETAPA')
    Left = 160
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ASS_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_Itens_assIAS_CODIGO: TIntegerField
      FieldName = 'IAS_CODIGO'
      Origin = 'TB_ITENS_ASS.IAS_CODIGO'
      Required = True
    end
    object Qr_Itens_assIAS_CODASS: TIntegerField
      FieldName = 'IAS_CODASS'
      Origin = 'TB_ITENS_ASS.IAS_CODASS'
      Required = True
    end
    object Qr_Itens_assIAS_ETAPA: TIntegerField
      FieldName = 'IAS_ETAPA'
      Origin = 'TB_ITENS_ASS.IAS_ETAPA'
    end
    object Qr_Itens_assIAS_DATA: TDateField
      FieldName = 'IAS_DATA'
      Origin = 'TB_ITENS_ASS.IAS_DATA'
    end
    object Qr_Itens_assIAS_DESCRITIVO: TMemoField
      FieldName = 'IAS_DESCRITIVO'
      Origin = 'TB_ITENS_ASS.IAS_DESCRITIVO'
      BlobType = ftMemo
      Size = 8
    end
    object Qr_Itens_assIAS_DT_PREVISTA: TDateField
      FieldName = 'IAS_DT_PREVISTA'
      Origin = 'TB_ITENS_ASS.IAS_DT_PREVISTA'
    end
    object Qr_Itens_assIAS_VL_CLIENTE: TBCDField
      FieldName = 'IAS_VL_CLIENTE'
      Origin = 'TB_ITENS_ASS.IAS_VL_CLIENTE'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_assIAS_VL_CUSTO: TBCDField
      FieldName = 'IAS_VL_CUSTO'
      Origin = 'TB_ITENS_ASS.IAS_VL_CUSTO'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_assIAS_DT_REALIZADA: TDateField
      FieldName = 'IAS_DT_REALIZADA'
      Origin = 'TB_ITENS_ASS.IAS_DT_REALIZADA'
    end
    object Qr_Itens_assIAS_CODSIT: TIntegerField
      FieldName = 'IAS_CODSIT'
      Origin = 'TB_ITENS_ASS.IAS_CODSIT'
    end
    object Qr_Itens_assSIT_DESCRICAO: TStringField
      FieldName = 'SIT_DESCRICAO'
      Origin = 'TB_SITUACAO.SIT_DESCRICAO'
      Size = 100
    end
  end
  object Ds_Consulta: TDataSource
    DataSet = Qr_Consulta
    Left = 53
    Top = 65
  end
end
