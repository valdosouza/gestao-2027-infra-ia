object Fc_ImprimeNFE_c: TFc_ImprimeNFE_c
  Left = 192
  Top = 129
  Caption = 'Fc_ImprimeNFE_c'
  ClientHeight = 201
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    479
    201)
  PixelsPerInch = 96
  TextHeight = 13
  object SB_Imprimir: TSpeedButton
    Left = 288
    Top = 106
    Width = 80
    Height = 54
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir - F3'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Layout = blGlyphTop
    ParentFont = False
    OnClick = SB_ImprimirClick
    ExplicitLeft = 80
    ExplicitTop = 46
  end
  object Sb_Sair_0: TSpeedButton
    Left = 375
    Top = 106
    Width = 80
    Height = 54
    Anchors = [akRight, akBottom]
    Caption = 'Sair - ESC'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Layout = blGlyphTop
    ParentFont = False
    OnClick = Sb_Sair_0Click
    ExplicitLeft = 167
    ExplicitTop = 46
  end
  object Qr_Pedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  PED_CODIGO,'
      '  PED_CODEMP,'
      '  PED_CODVDO,'
      '  EMP_CONSUMIDOR,'
      '  EMP_NOME,'
      '  EMP_MICRO,'
      '  UFE_CODIGO,'
      '  UFE_SIGLA,'
      '  EMP_FABRICA,'
      '  EMP_SUB_TRIB,'
      '  EMP_INSC_EST,'
      '  EMP_CNPJ,'
      '  CDD_DESCRICAO,'
      '  END_NUMERO,'
      '  END_PAIS,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_ENDER,'
      ' ped_codend,'
      ' PED_VL_PEDIDO,'
      'PED_PRAZO,'
      'PED_DATA,'
      
        'PED_VL_SERVICO, PED_VL_PRODUTO, PED_VL_ODESPESA, PED_VL_IPI, PED' +
        '_VL_FRETE, PED_VL_DESCONTO, PED_NUMERO,PED_CODFPG, FPT_DESCRICAO'
      ''
      'FROM TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '   INNER JOIN TB_PAIS tb_pais'
      '   ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      '   INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON(tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG)'
      ''
      'WHERE (PED_CODIGO=:PED_CODIGO) ')
    Left = 21
    Top = 12
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_PedidoPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = 'TB_PEDIDO.PED_CODEMP'
      Required = True
    end
    object Qr_PedidoPED_CODVDO: TIntegerField
      FieldName = 'PED_CODVDO'
      Origin = 'TB_PEDIDO.PED_CODVDO'
      Required = True
    end
    object Qr_PedidoEMP_CONSUMIDOR: TStringField
      FieldName = 'EMP_CONSUMIDOR'
      Origin = 'TB_EMPRESA.EMP_CONSUMIDOR'
      Size = 1
    end
    object Qr_PedidoEMP_MICRO: TStringField
      FieldName = 'EMP_MICRO'
      Origin = 'TB_EMPRESA.EMP_MICRO'
      Size = 1
    end
    object Qr_PedidoUFE_CODIGO: TIntegerField
      FieldName = 'UFE_CODIGO'
      Origin = 'TB_UF.UFE_CODIGO'
      Required = True
    end
    object Qr_PedidoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_PedidoEMP_FABRICA: TStringField
      FieldName = 'EMP_FABRICA'
      Origin = 'TB_EMPRESA.EMP_FABRICA'
      FixedChar = True
      Size = 1
    end
    object Qr_PedidoEMP_SUB_TRIB: TStringField
      FieldName = 'EMP_SUB_TRIB'
      Origin = 'TB_EMPRESA.EMP_SUB_TRIB'
      FixedChar = True
      Size = 1
    end
    object Qr_PedidoPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = 'TB_PEDIDO.PED_CODIGO'
      Required = True
    end
    object Qr_PedidoEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = 'TB_EMPRESA.EMP_CNPJ'
      Required = True
      Size = 14
    end
    object Qr_PedidoCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_PedidoEND_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'TB_ENDERECO.END_NUMERO'
      Size = 10
    end
    object Qr_PedidoEND_PAIS: TIntegerField
      FieldName = 'END_PAIS'
      Origin = 'TB_ENDERECO.END_PAIS'
    end
    object Qr_PedidoEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 100
    end
    object Qr_PedidoEMP_INSC_EST: TStringField
      FieldName = 'EMP_INSC_EST'
      Origin = 'TB_EMPRESA.EMP_INSC_EST'
      Size = 30
    end
    object Qr_PedidoEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_PedidoEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_PedidoPED_CODEND: TIntegerField
      FieldName = 'PED_CODEND'
      Origin = 'TB_PEDIDO.PED_CODEND'
    end
    object Qr_PedidoPED_VL_PEDIDO: TBCDField
      FieldName = 'PED_VL_PEDIDO'
      Origin = 'TB_PEDIDO.PED_VL_PEDIDO'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_PRAZO: TStringField
      FieldName = 'PED_PRAZO'
      Origin = 'TB_PEDIDO.PED_PRAZO'
      Size = 200
    end
    object Qr_PedidoPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = 'TB_PEDIDO.PED_DATA'
      Required = True
    end
    object Qr_PedidoPED_VL_SERVICO: TBCDField
      FieldName = 'PED_VL_SERVICO'
      Origin = 'TB_PEDIDO.PED_VL_SERVICO'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_PRODUTO: TBCDField
      FieldName = 'PED_VL_PRODUTO'
      Origin = 'TB_PEDIDO.PED_VL_PRODUTO'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_ODESPESA: TBCDField
      FieldName = 'PED_VL_ODESPESA'
      Origin = 'TB_PEDIDO.PED_VL_ODESPESA'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_IPI: TBCDField
      FieldName = 'PED_VL_IPI'
      Origin = 'TB_PEDIDO.PED_VL_IPI'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_FRETE: TBCDField
      FieldName = 'PED_VL_FRETE'
      Origin = 'TB_PEDIDO.PED_VL_FRETE'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_DESCONTO: TBCDField
      FieldName = 'PED_VL_DESCONTO'
      Origin = 'TB_PEDIDO.PED_VL_DESCONTO'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_PedidoPED_CODFPG: TIntegerField
      FieldName = 'PED_CODFPG'
      Origin = 'TB_PEDIDO.PED_CODFPG'
      Required = True
    end
    object Qr_PedidoFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Origin = 'TB_FORMAPAGTO.FPT_DESCRICAO'
      Required = True
      Size = 51
    end
    object Qr_PedidoEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  EMB_ABREVIATURA,'
      '  PRO_CODIGONCM,'
      'PRO_ORIGEM,'
      '  ITF_QTDE, '
      '  ITF_VL_UNIT,'
      '  CAST((ITF_QTDE * ITF_VL_UNIT) AS DOUBLE PRECISION) AS  ITF_SUBTOTAL,'
      '  ITF_AQ_IPI,'
      '  ITF_ESTOQUE,'
      '  ITF_AQ_ICMS,'
      '  PRO_TRIBUTACAO'
      'FROM TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      
        '   inner JOIN tb_medida tb_medida ON tb_medida.med_codigo = tb_p' +
        'roduto.pro_codmed'
      
        '   LEFT JOIN tb_embalagem tb_embalagem ON tb_embalagem.emb_codig' +
        'o = tb_produto.pro_codemb'
      'WHERE (ITF_CODNFL = :NFL_CODIGO)'
      'ORDER BY PRO_DESCRICAO'
      ''
      '')
    Left = 61
    Top = 12
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = 'TB_ITENS_NFL.ITF_CODPRO'
    end
    object Qr_ItensPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = 'TB_PRODUTO.PRO_CODIGOFAB'
      Size = 50
    end
    object Qr_ItensPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_ItensMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = 'TB_MEDIDA.MED_ABREVIATURA'
      Size = 5
    end
    object Qr_ItensEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = 'TB_EMBALAGEM.EMB_ABREVIATURA'
      Size = 5
    end
    object Qr_ItensPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = 'TB_PRODUTO.PRO_CODIGONCM'
      Size = 50
    end
    object Qr_ItensPRO_ORIGEM: TStringField
      FieldName = 'PRO_ORIGEM'
      Origin = 'TB_PRODUTO.PRO_ORIGEM'
      Size = 1
    end
    object Qr_ItensITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = 'TB_ITENS_NFL.ITF_QTDE'
      Precision = 18
      Size = 3
    end
    object Qr_ItensITF_VL_UNIT: TFloatField
      FieldName = 'ITF_VL_UNIT'
      Origin = 'TB_ITENS_NFL.ITF_VL_UNIT'
    end
    object Qr_ItensITF_SUBTOTAL: TFloatField
      FieldName = 'ITF_SUBTOTAL'
    end
    object Qr_ItensITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = 'TB_ITENS_NFL.ITF_AQ_IPI'
      Precision = 18
      Size = 2
    end
    object Qr_ItensITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = 'TB_ITENS_NFL.ITF_ESTOQUE'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = 'TB_ITENS_NFL.ITF_AQ_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_ItensPRO_TRIBUTACAO: TStringField
      FieldName = 'PRO_TRIBUTACAO'
      Origin = 'TB_PRODUTO.PRO_TRIBUTACAO'
      FixedChar = True
      Size = 1
    end
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 93
    Top = 12
  end
  object Qr_Pgto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_FORMAPAGTO'
      'WHERE (FPT_FINALIDADE = 0) OR  (FPT_FINALIDADE = 3)'
      'ORDER BY FPT_CODIGO')
    Left = 141
    Top = 12
    object Qr_PgtoFPT_CODIGO: TIntegerField
      FieldName = 'FPT_CODIGO'
      Origin = 'TB_FORMAPAGTO.FPT_CODIGO'
      Required = True
    end
    object Qr_PgtoFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Origin = 'TB_FORMAPAGTO.FPT_DESCRICAO'
      Required = True
      Size = 51
    end
  end
  object Qr_Tributacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select TRB_CODIGO'
      '      ,TRB_CODPRO'
      '      ,TRB_ORIGEM'
      '      ,TRB_CODTBI_ICMS_NR'
      '      ,TRB_CODTBI_ICMS_SN'
      '      ,TRB_CODMDB_ICMS_NR'
      '      ,TRB_CODMDB_ICMS_ST'
      '      ,TRB_CODDSI_ICMS'
      '      ,TRB_AQ_ICMS'
      '      ,TRB_RD_AQ_ICMS'
      '      ,TRB_RD_BS_ICMS'
      '      ,TRB_CODTBI_IPI'
      '      ,TRB_AQ_IPI'
      '      ,TRB_CODTBI_PIS'
      '      ,TRB_AQ_PIS'
      '      ,TRB_CODTBI_CFS'
      '      ,TRB_AQ_COFINS'
      '      ,TRB_AQ_IRPJ'
      '      ,TRB_AQ_CSLL'
      '      ,TRB_AQ_SISCOMEX'
      '      ,TRB_AQ_II'
      '      ,TRB_ST_ICMS'
      '      ,TRB_CONSUMIDOR'
      '      ,TRB_MICRO'
      '      ,TRB_DIFERIDO'
      '      ,TRB_DESTAQUE'
      '      ,TRB_CODOBS'
      '      ,TRB_CODNAT'
      '      ,TRB_ESTADO'
      '      ,TRB_CODMHA'
      '      ,TRB_SUB_TRI'
      '      ,NAT_CODIGO'
      '      ,TRB_AQ_ISS'
      'from "TB_TRIBUTACAO"'
      '     INNER JOIN TB_NATUREZA tb_natureza'
      '     ON (tb_natureza.NAT_CODIGO = TRB_CODNAT)'
      'WHERE ( ( TRB_CODPRO =:TRB_CODPRO ) OR ( TRB_CODPRO = 0 ) )   '
      '   AND      ( TRB_ORIGEM =:TRB_ORIGEM ) '
      '   AND      ( TRB_ST_ICMS = :TRB_ST_ICMS )'
      
        '   AND      ( ( TRB_ESTADO = :TRB_ESTADO ) OR ( TRB_ESTADO = 0 )' +
        ' OR ( TRB_ESTADO IS NULL) ) '
      '   AND      ( TRB_CONSUMIDOR =:TRB_CONSUMIDOR ) '
      '   AND      ( TRB_MICRO =:TRB_MICRO ) '
      '   AND      ( TRB_CODMHA=:TRB_CODMHA ) '
      '   AND      ( NAT_SENTIDO =:NAT_SENTIDO ) '
      '   AND      ( TRB_PRODUTO =:TRB_PRODUTO)'
      ' ')
    Left = 69
    Top = 45
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TRB_CODPRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_ORIGEM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_ST_ICMS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_ESTADO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_CONSUMIDOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_MICRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_CODMHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NAT_SENTIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_PRODUTO'
        ParamType = ptUnknown
      end>
    object Qr_TributacaoTRB_CODIGO: TIntegerField
      FieldName = 'TRB_CODIGO'
      Origin = 'TB_TRIBUTACAO.TRB_CODIGO'
      Required = True
    end
    object Qr_TributacaoTRB_CODPRO: TIntegerField
      FieldName = 'TRB_CODPRO'
      Origin = 'TB_TRIBUTACAO.TRB_CODPRO'
      Required = True
    end
    object Qr_TributacaoTRB_ORIGEM: TStringField
      FieldName = 'TRB_ORIGEM'
      Origin = 'TB_TRIBUTACAO.TRB_ORIGEM'
      FixedChar = True
      Size = 1
    end
    object Qr_TributacaoTRB_CODTBI_ICMS_NR: TIntegerField
      FieldName = 'TRB_CODTBI_ICMS_NR'
      Origin = 'TB_TRIBUTACAO.TRB_CODTBI_ICMS_NR'
      Required = True
    end
    object Qr_TributacaoTRB_CODTBI_ICMS_SN: TIntegerField
      FieldName = 'TRB_CODTBI_ICMS_SN'
      Origin = 'TB_TRIBUTACAO.TRB_CODTBI_ICMS_SN'
      Required = True
    end
    object Qr_TributacaoTRB_CODMDB_ICMS_NR: TIntegerField
      FieldName = 'TRB_CODMDB_ICMS_NR'
      Origin = 'TB_TRIBUTACAO.TRB_CODMDB_ICMS_NR'
      Required = True
    end
    object Qr_TributacaoTRB_CODMDB_ICMS_ST: TIntegerField
      FieldName = 'TRB_CODMDB_ICMS_ST'
      Origin = 'TB_TRIBUTACAO.TRB_CODMDB_ICMS_ST'
      Required = True
    end
    object Qr_TributacaoTRB_CODDSI_ICMS: TIntegerField
      FieldName = 'TRB_CODDSI_ICMS'
      Origin = 'TB_TRIBUTACAO.TRB_CODDSI_ICMS'
      Required = True
    end
    object Qr_TributacaoTRB_AQ_ICMS: TBCDField
      FieldName = 'TRB_AQ_ICMS'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_RD_AQ_ICMS: TBCDField
      FieldName = 'TRB_RD_AQ_ICMS'
      Origin = 'TB_TRIBUTACAO.TRB_RD_AQ_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_RD_BS_ICMS: TBCDField
      FieldName = 'TRB_RD_BS_ICMS'
      Origin = 'TB_TRIBUTACAO.TRB_RD_BS_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_CODTBI_IPI: TIntegerField
      FieldName = 'TRB_CODTBI_IPI'
      Origin = 'TB_TRIBUTACAO.TRB_CODTBI_IPI'
      Required = True
    end
    object Qr_TributacaoTRB_AQ_IPI: TBCDField
      FieldName = 'TRB_AQ_IPI'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_IPI'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_CODTBI_PIS: TIntegerField
      FieldName = 'TRB_CODTBI_PIS'
      Origin = 'TB_TRIBUTACAO.TRB_CODTBI_PIS'
      Required = True
    end
    object Qr_TributacaoTRB_AQ_PIS: TBCDField
      FieldName = 'TRB_AQ_PIS'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_PIS'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_CODTBI_CFS: TIntegerField
      FieldName = 'TRB_CODTBI_CFS'
      Origin = 'TB_TRIBUTACAO.TRB_CODTBI_CFS'
      Required = True
    end
    object Qr_TributacaoTRB_AQ_COFINS: TBCDField
      FieldName = 'TRB_AQ_COFINS'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_COFINS'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_AQ_IRPJ: TBCDField
      FieldName = 'TRB_AQ_IRPJ'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_IRPJ'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_AQ_CSLL: TBCDField
      FieldName = 'TRB_AQ_CSLL'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_CSLL'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_AQ_II: TBCDField
      FieldName = 'TRB_AQ_II'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_II'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_ST_ICMS: TStringField
      FieldName = 'TRB_ST_ICMS'
      Origin = 'TB_TRIBUTACAO.TRB_ST_ICMS'
      FixedChar = True
      Size = 1
    end
    object Qr_TributacaoTRB_CONSUMIDOR: TStringField
      FieldName = 'TRB_CONSUMIDOR'
      Origin = 'TB_TRIBUTACAO.TRB_CONSUMIDOR'
      FixedChar = True
      Size = 1
    end
    object Qr_TributacaoTRB_MICRO: TStringField
      FieldName = 'TRB_MICRO'
      Origin = 'TB_TRIBUTACAO.TRB_MICRO'
      FixedChar = True
      Size = 1
    end
    object Qr_TributacaoTRB_DIFERIDO: TStringField
      FieldName = 'TRB_DIFERIDO'
      Origin = 'TB_TRIBUTACAO.TRB_DIFERIDO'
      FixedChar = True
      Size = 1
    end
    object Qr_TributacaoTRB_DESTAQUE: TStringField
      FieldName = 'TRB_DESTAQUE'
      Origin = 'TB_TRIBUTACAO.TRB_DESTAQUE'
      FixedChar = True
      Size = 1
    end
    object Qr_TributacaoTRB_CODOBS: TIntegerField
      FieldName = 'TRB_CODOBS'
      Origin = 'TB_TRIBUTACAO.TRB_CODOBS'
    end
    object Qr_TributacaoTRB_CODNAT: TIntegerField
      FieldName = 'TRB_CODNAT'
      Origin = 'TB_TRIBUTACAO.TRB_CODNAT'
      Required = True
    end
    object Qr_TributacaoTRB_ESTADO: TIntegerField
      FieldName = 'TRB_ESTADO'
      Origin = 'TB_TRIBUTACAO.TRB_ESTADO'
    end
    object Qr_TributacaoTRB_CODMHA: TIntegerField
      FieldName = 'TRB_CODMHA'
      Origin = 'TB_TRIBUTACAO.TRB_CODMHA'
    end
    object Qr_TributacaoTRB_SUB_TRI: TStringField
      FieldName = 'TRB_SUB_TRI'
      Origin = 'TB_TRIBUTACAO.TRB_SUB_TRI'
      Size = 1
    end
    object Qr_TributacaoNAT_CODIGO: TIntegerField
      FieldName = 'NAT_CODIGO'
      Origin = 'TB_NATUREZA.NAT_CODIGO'
      Required = True
    end
    object Qr_TributacaoTRB_AQ_ISS: TBCDField
      FieldName = 'TRB_AQ_ISS'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_ISS'
      Precision = 18
      Size = 2
    end
    object Qr_TributacaoTRB_AQ_SISCOMEX: TFloatField
      FieldName = 'TRB_AQ_SISCOMEX'
      Origin = 'TB_TRIBUTACAO.TRB_AQ_SISCOMEX'
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 236
    Top = 16
  end
  object Qr_Empresa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_CNPJ,'
      '  EMP_INSC_EST,'
      '  EMP_STCRED,'
      '  EMP_OBSERV,'
      '  EMP_DT_CADASTRO,'
      '  EMP_PESSOA,'
      '  EMP_CONSUMIDOR,'
      '  EMP_MICRO,'
      '  EMP_VL_CRED,'
      '  EMP_CODVDOR,'
      '  EMP_ML_DRT,'
      '  EMP_CODBCO,'
      '  EMP_AGENCIA,'
      '  EMP_CONTABCO,'
      '  EMP_EMAIL,'
      '  EMP_SITE,'
      '  EMP_RAM_ATIV,'
      '  EMP_DT_FUNDA,'
      '  EMP_CODTRANSP,'
      '  EMP_MULTIPLICADOR,'
      '  EMP_RED_CONTRATO,'
      '  EMP_FORMDATA,'
      '  EMP_RESP_TEC'
      'FROM TB_EMPRESA'
      '   WHERE (EMP_CODIGO =:EMP_CODIGO)')
    Left = 24
    Top = 46
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_EmpresaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_EmpresaEMP_TIPO: TIntegerField
      FieldName = 'EMP_TIPO'
      Origin = 'TB_EMPRESA.EMP_TIPO'
      Required = True
    end
    object Qr_EmpresaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_EmpresaEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'TB_EMPRESA.EMP_FANTASIA'
      Size = 100
    end
    object Qr_EmpresaEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = 'TB_EMPRESA.EMP_CNPJ'
      Size = 14
    end
    object Qr_EmpresaEMP_INSC_EST: TStringField
      FieldName = 'EMP_INSC_EST'
      Origin = 'TB_EMPRESA.EMP_INSC_EST'
      Size = 30
    end
    object Qr_EmpresaEMP_STCRED: TStringField
      FieldName = 'EMP_STCRED'
      Origin = 'TB_EMPRESA.EMP_STCRED'
      Size = 1
    end
    object Qr_EmpresaEMP_OBSERV: TStringField
      FieldName = 'EMP_OBSERV'
      Origin = 'TB_EMPRESA.EMP_OBSERV'
      Size = 500
    end
    object Qr_EmpresaEMP_DT_CADASTRO: TDateField
      FieldName = 'EMP_DT_CADASTRO'
      Origin = 'TB_EMPRESA.EMP_DT_CADASTRO'
    end
    object Qr_EmpresaEMP_PESSOA: TStringField
      FieldName = 'EMP_PESSOA'
      Origin = 'TB_EMPRESA.EMP_PESSOA'
      Size = 1
    end
    object Qr_EmpresaEMP_CONSUMIDOR: TStringField
      FieldName = 'EMP_CONSUMIDOR'
      Origin = 'TB_EMPRESA.EMP_CONSUMIDOR'
      Size = 1
    end
    object Qr_EmpresaEMP_MICRO: TStringField
      FieldName = 'EMP_MICRO'
      Origin = 'TB_EMPRESA.EMP_MICRO'
      Size = 1
    end
    object Qr_EmpresaEMP_VL_CRED: TFloatField
      FieldName = 'EMP_VL_CRED'
      Origin = 'TB_EMPRESA.EMP_VL_CRED'
    end
    object Qr_EmpresaEMP_CODVDOR: TIntegerField
      FieldName = 'EMP_CODVDOR'
      Origin = 'TB_EMPRESA.EMP_CODVDOR'
    end
    object Qr_EmpresaEMP_ML_DRT: TStringField
      FieldName = 'EMP_ML_DRT'
      Origin = 'TB_EMPRESA.EMP_ML_DRT'
      Size = 3
    end
    object Qr_EmpresaEMP_CODBCO: TStringField
      FieldName = 'EMP_CODBCO'
      Origin = 'TB_EMPRESA.EMP_CODBCO'
      Size = 5
    end
    object Qr_EmpresaEMP_AGENCIA: TStringField
      FieldName = 'EMP_AGENCIA'
      Origin = 'TB_EMPRESA.EMP_AGENCIA'
      Size = 14
    end
    object Qr_EmpresaEMP_CONTABCO: TStringField
      FieldName = 'EMP_CONTABCO'
      Origin = 'TB_EMPRESA.EMP_CONTABCO'
      Size = 14
    end
    object Qr_EmpresaEMP_EMAIL: TStringField
      FieldName = 'EMP_EMAIL'
      Origin = 'TB_EMPRESA.EMP_EMAIL'
      Size = 40
    end
    object Qr_EmpresaEMP_SITE: TStringField
      FieldName = 'EMP_SITE'
      Origin = 'TB_EMPRESA.EMP_SITE'
      Size = 40
    end
    object Qr_EmpresaEMP_RAM_ATIV: TStringField
      FieldName = 'EMP_RAM_ATIV'
      Origin = 'TB_EMPRESA.EMP_RAM_ATIV'
      Size = 100
    end
    object Qr_EmpresaEMP_DT_FUNDA: TDateField
      FieldName = 'EMP_DT_FUNDA'
      Origin = 'TB_EMPRESA.EMP_DT_FUNDA'
    end
    object Qr_EmpresaEMP_CODTRANSP: TIntegerField
      FieldName = 'EMP_CODTRANSP'
      Origin = 'TB_EMPRESA.EMP_CODTRANSP'
    end
    object Qr_EmpresaEMP_MULTIPLICADOR: TBCDField
      FieldName = 'EMP_MULTIPLICADOR'
      Origin = 'TB_EMPRESA.EMP_MULTIPLICADOR'
      Precision = 18
      Size = 2
    end
    object Qr_EmpresaEMP_RED_CONTRATO: TBCDField
      FieldName = 'EMP_RED_CONTRATO'
      Origin = 'TB_EMPRESA.EMP_RED_CONTRATO'
      Precision = 18
      Size = 2
    end
    object Qr_EmpresaEMP_FORMDATA: TStringField
      FieldName = 'EMP_FORMDATA'
      Origin = 'TB_EMPRESA.EMP_FORMDATA'
      Size = 10
    end
    object Qr_EmpresaEMP_RESP_TEC: TStringField
      FieldName = 'EMP_RESP_TEC'
      Origin = 'TB_EMPRESA.EMP_RESP_TEC'
      Size = 100
    end
  end
  object Qr_Endereco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  END_CODIGO,'
      '  END_CODEMP,'
      '  END_CNPJ,'
      '  END_TIPO,'
      '  END_ENDER,'
      '  END_NUMERO,'
      '  END_COMPLEM,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_CODCDD,'
      '  CDD_DESCRICAO,'
      '  END_REGIAO,'
      '  END_CODUFE,'
      '  UFE_SIGLA,'
      '  END_CONTATO,'
      '  END_FONE,'
      '  END_FAX,'
      '  END_CELULAR,'
      '  END_PAIS,'
      '  END_COMERCIAL,'
      '  END_PORTARIA,'
      '  END_PRINCIPAL'
      'FROM TB_ENDERECO'
      '         LEFT OUTER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         LEFT OUTER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)')
    Left = 110
    Top = 45
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_EnderecoEND_CODIGO: TIntegerField
      FieldName = 'END_CODIGO'
      Origin = 'TB_ENDERECO.END_CODIGO'
      Required = True
    end
    object Qr_EnderecoEND_CODEMP: TIntegerField
      FieldName = 'END_CODEMP'
      Origin = 'TB_ENDERECO.END_CODEMP'
    end
    object Qr_EnderecoEND_CNPJ: TStringField
      FieldName = 'END_CNPJ'
      Origin = 'TB_ENDERECO.END_CNPJ'
      Size = 14
    end
    object Qr_EnderecoEND_TIPO: TStringField
      FieldName = 'END_TIPO'
      Origin = 'TB_ENDERECO.END_TIPO'
      Size = 100
    end
    object Qr_EnderecoEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_EnderecoEND_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'TB_ENDERECO.END_NUMERO'
      Size = 10
    end
    object Qr_EnderecoEND_COMPLEM: TStringField
      FieldName = 'END_COMPLEM'
      Origin = 'TB_ENDERECO.END_COMPLEM'
      Size = 25
    end
    object Qr_EnderecoEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 100
    end
    object Qr_EnderecoEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_EnderecoEND_CODCDD: TIntegerField
      FieldName = 'END_CODCDD'
      Origin = 'TB_ENDERECO.END_CODCDD'
    end
    object Qr_EnderecoCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_EnderecoEND_REGIAO: TStringField
      FieldName = 'END_REGIAO'
      Origin = 'TB_ENDERECO.END_REGIAO'
      Size = 25
    end
    object Qr_EnderecoEND_CODUFE: TIntegerField
      FieldName = 'END_CODUFE'
      Origin = 'TB_ENDERECO.END_CODUFE'
    end
    object Qr_EnderecoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_EnderecoEND_CONTATO: TStringField
      FieldName = 'END_CONTATO'
      Origin = 'TB_ENDERECO.END_CONTATO'
      Size = 100
    end
    object Qr_EnderecoEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = 'TB_ENDERECO.END_FONE'
      Size = 14
    end
    object Qr_EnderecoEND_FAX: TStringField
      FieldName = 'END_FAX'
      Origin = 'TB_ENDERECO.END_FAX'
      Size = 14
    end
    object Qr_EnderecoEND_CELULAR: TStringField
      FieldName = 'END_CELULAR'
      Origin = 'TB_ENDERECO.END_CELULAR'
      Size = 14
    end
    object Qr_EnderecoEND_PAIS: TIntegerField
      FieldName = 'END_PAIS'
      Origin = 'TB_ENDERECO.END_PAIS'
    end
    object Qr_EnderecoEND_COMERCIAL: TStringField
      FieldName = 'END_COMERCIAL'
      Origin = 'TB_ENDERECO.END_COMERCIAL'
      Size = 14
    end
    object Qr_EnderecoEND_PORTARIA: TStringField
      FieldName = 'END_PORTARIA'
      Origin = 'TB_ENDERECO.END_PORTARIA'
      Size = 14
    end
    object Qr_EnderecoEND_PRINCIPAL: TStringField
      FieldName = 'END_PRINCIPAL'
      Origin = 'TB_ENDERECO.END_PRINCIPAL'
      Size = 1
    end
  end
  object Qr_nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_notaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT                                                       '
      '   PED_CODIGO,                                               '
      '   NFL_CODIGO,                                               '
      '   NAT_DESCRICAO,           '
      '  FPT_DESCRICAO,'
      '   NFL_SERIE,                                                '
      '   NAT_CFOP,                                                 '
      '   PED_NUMERO,                                               '
      '   NFL_NUMERO,                                               '
      '   NFL_VL_TL_NOTA,                                           '
      '   EMP_CODIGO,                                               '
      '   EMP_NOME,                                                 '
      '   EMP_FANTASIA,                                             '
      '   EMP_CNPJ,                                                 '
      '   EMP_EMAIL,'
      '   END_ENDER,                                                '
      '   END_BAIRRO,                                               '
      '   END_CEP,       '
      '   CDD_IBGE,                                           '
      '   CDD_DESCRICAO,                                               '
      '   END_FONE,                                                 '
      '   UFE_SIGLA,   '
      '   END_PAIS,                                            '
      '   EMP_INSC_EST,                                              '
      '   NFL_DT_EMISSAO,                                           '
      '   NFL_DT_SAIDA,                                             '
      '   NFL_BS_ICMS,                                              '
      '   NFL_VL_ICMS,                                              '
      '   NFL_BS_ICMS_SUBST,                                        '
      '   NFL_VL_ICMS_SUBST,                                        '
      '   NFL_VL_TL_PROD,                                           '
      '   NFL_VL_FRETE,                                             '
      '   NFL_VL_SEGURO,                                            '
      '   NFL_VL_DESP_ACESS,                                        '
      '   NFL_VL_IPI,                                               '
      '   NFL_QT_PRODUTO,                                           '
      '   NFL_ESPECIE,                                              '
      '   NFL_MARCA,                                                '
      '   NFL_PESO_BRUTO,                                           '
      '   NFL_PESO_LIQ,                                             '
      '   CLB_NOME,                                                 '
      '   NFL_STATUS,                                               '
      '   NFL_TIPO,                                                 '
      '   PED_OBS,                                                  '
      '   NFL_VL_TL_SRV,                                            '
      '   PED_VL_DESCONTO,                                          '
      '   PED_DT_ALTERA,                                            '
      '   PED_CODTRP,'
      '   END_NUMERO,'
      '   NFL_CODTRP,'
      '  NFL_VOL_NUMERO,'
      '  MDF_GRUPO,'
      '  NFL_PLC_VEICULO,'
      '  NFL_PLC_UF,'
      '  NFL_PLC_RNTC,'
      '  PAI_DESCRICAO,'
      '  PED_PRAZO,'
      '  PED_CODEND'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal                           '
      '     INNER JOIN TB_PEDIDO tb_pedido'
      '     ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)   '
      '     INNER  JOIN tb_formapagto tb_formapagto'
      '     ON (tb_formapagto.FPT_codigo = tb_pedido.PED_CODFPG)'
      ''
      '     INNER JOIN TB_EMPRESA tb_empresa'
      '     ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)  '
      '     LEFT OUTER  JOIN TB_NATUREZA tb_natureza                  '
      '     ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) '
      '     INNER  JOIN TB_ENDERECO tb_endereco                  '
      '     ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      '     INNER JOIN TB_CIDADE tb_cidade'
      '     ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '     INNER JOIN TB_UF tb_uf'
      '     ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '     LEFT OUTER  JOIN TB_COLABORADOR tb_colaborador'
      '     ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)   '
      '     INNER  JOIN TB_PAIS tb_pais'
      '     ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)   '
      '     INNER  JOIN tb_modal_frete tb_modal_frete'
      
        '     ON (tb_modal_frete.mdf_codigo = tb_nota_fiscal.nfl_cta_fret' +
        'e)'
      ''
      'WHERE (tb_nota_fiscal.NFL_NUMERO ='#39'1'#39')'
      '')
    Left = 184
    Top = 11
    object Qr_notaPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = 'TB_PEDIDO.PED_CODIGO'
      Required = True
    end
    object Qr_notaNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = 'TB_NOTA_FISCAL.NFL_CODIGO'
      Required = True
    end
    object Qr_notaNAT_DESCRICAO: TStringField
      FieldName = 'NAT_DESCRICAO'
      Origin = 'TB_NATUREZA.NAT_DESCRICAO'
      Size = 250
    end
    object Qr_notaNFL_SERIE: TStringField
      FieldName = 'NFL_SERIE'
      Origin = 'TB_NOTA_FISCAL.NFL_SERIE'
      Size = 10
    end
    object Qr_notaNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = 'TB_NATUREZA.NAT_CFOP'
      Size = 10
    end
    object Qr_notaPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_notaNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = 'TB_NOTA_FISCAL.NFL_NUMERO'
      Size = 10
    end
    object Qr_notaNFL_VL_TL_NOTA: TBCDField
      FieldName = 'NFL_VL_TL_NOTA'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_TL_NOTA'
      Precision = 18
      Size = 2
    end
    object Qr_notaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_notaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_notaEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'TB_EMPRESA.EMP_FANTASIA'
      Size = 100
    end
    object Qr_notaEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = 'TB_EMPRESA.EMP_CNPJ'
      Size = 14
    end
    object Qr_notaEMP_EMAIL: TStringField
      FieldName = 'EMP_EMAIL'
      Origin = 'TB_EMPRESA.EMP_EMAIL'
      Size = 40
    end
    object Qr_notaEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_notaEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 100
    end
    object Qr_notaEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_notaCDD_IBGE: TIntegerField
      FieldName = 'CDD_IBGE'
      Origin = 'TB_CIDADE.CDD_IBGE'
    end
    object Qr_notaCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_notaEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = 'TB_ENDERECO.END_FONE'
      Size = 14
    end
    object Qr_notaUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_notaEND_PAIS: TIntegerField
      FieldName = 'END_PAIS'
      Origin = 'TB_ENDERECO.END_PAIS'
    end
    object Qr_notaEMP_INSC_EST: TStringField
      FieldName = 'EMP_INSC_EST'
      Origin = 'TB_EMPRESA.EMP_INSC_EST'
      Size = 30
    end
    object Qr_notaNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = 'TB_NOTA_FISCAL.NFL_DT_EMISSAO'
    end
    object Qr_notaNFL_DT_SAIDA: TDateField
      FieldName = 'NFL_DT_SAIDA'
      Origin = 'TB_NOTA_FISCAL.NFL_DT_SAIDA'
    end
    object Qr_notaNFL_BS_ICMS: TBCDField
      FieldName = 'NFL_BS_ICMS'
      Origin = 'TB_NOTA_FISCAL.NFL_BS_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_VL_ICMS: TBCDField
      FieldName = 'NFL_VL_ICMS'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_BS_ICMS_SUBST: TBCDField
      FieldName = 'NFL_BS_ICMS_SUBST'
      Origin = 'TB_NOTA_FISCAL.NFL_BS_ICMS_SUBST'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_VL_ICMS_SUBST: TBCDField
      FieldName = 'NFL_VL_ICMS_SUBST'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_ICMS_SUBST'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_VL_TL_PROD: TBCDField
      FieldName = 'NFL_VL_TL_PROD'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_TL_PROD'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_VL_FRETE: TBCDField
      FieldName = 'NFL_VL_FRETE'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_FRETE'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_VL_SEGURO: TBCDField
      FieldName = 'NFL_VL_SEGURO'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_SEGURO'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_VL_DESP_ACESS: TBCDField
      FieldName = 'NFL_VL_DESP_ACESS'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_DESP_ACESS'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_VL_IPI: TBCDField
      FieldName = 'NFL_VL_IPI'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_IPI'
      Precision = 18
      Size = 2
    end
    object Qr_notaNFL_QT_PRODUTO: TBCDField
      FieldName = 'NFL_QT_PRODUTO'
      Origin = 'TB_NOTA_FISCAL.NFL_QT_PRODUTO'
      Precision = 18
      Size = 3
    end
    object Qr_notaNFL_ESPECIE: TStringField
      FieldName = 'NFL_ESPECIE'
      Origin = 'TB_NOTA_FISCAL.NFL_ESPECIE'
      Size = 10
    end
    object Qr_notaNFL_MARCA: TStringField
      FieldName = 'NFL_MARCA'
      Origin = 'TB_NOTA_FISCAL.NFL_MARCA'
      Size = 10
    end
    object Qr_notaNFL_PESO_BRUTO: TStringField
      FieldName = 'NFL_PESO_BRUTO'
      Origin = 'TB_NOTA_FISCAL.NFL_PESO_BRUTO'
      Size = 10
    end
    object Qr_notaNFL_PESO_LIQ: TStringField
      FieldName = 'NFL_PESO_LIQ'
      Origin = 'TB_NOTA_FISCAL.NFL_PESO_LIQ'
      Size = 10
    end
    object Qr_notaCLB_NOME: TStringField
      FieldName = 'CLB_NOME'
      Origin = 'TB_COLABORADOR.CLB_NOME'
      Size = 100
    end
    object Qr_notaNFL_STATUS: TStringField
      FieldName = 'NFL_STATUS'
      Origin = 'TB_NOTA_FISCAL.NFL_STATUS'
      Size = 1
    end
    object Qr_notaNFL_TIPO: TStringField
      FieldName = 'NFL_TIPO'
      Origin = 'TB_NOTA_FISCAL.NFL_TIPO'
      Size = 2
    end
    object Qr_notaPED_OBS: TBlobField
      FieldName = 'PED_OBS'
      Origin = 'TB_PEDIDO.PED_OBS'
      Size = 8
    end
    object Qr_notaNFL_VL_TL_SRV: TBCDField
      FieldName = 'NFL_VL_TL_SRV'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_TL_SRV'
      Precision = 18
      Size = 2
    end
    object Qr_notaPED_VL_DESCONTO: TBCDField
      FieldName = 'PED_VL_DESCONTO'
      Origin = 'TB_PEDIDO.PED_VL_DESCONTO'
      Precision = 18
      Size = 2
    end
    object Qr_notaPED_DT_ALTERA: TSQLTimeStampField
      FieldName = 'PED_DT_ALTERA'
      Origin = 'TB_PEDIDO.PED_DT_ALTERA'
    end
    object Qr_notaPED_CODTRP: TIntegerField
      FieldName = 'PED_CODTRP'
      Origin = 'TB_PEDIDO.PED_CODTRP'
    end
    object Qr_notaEND_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'TB_ENDERECO.END_NUMERO'
      Size = 10
    end
    object Qr_notaNFL_CODTRP: TIntegerField
      FieldName = 'NFL_CODTRP'
      Origin = 'TB_NOTA_FISCAL.NFL_CODTRP'
    end
    object Qr_notaNFL_VOL_NUMERO: TStringField
      FieldName = 'NFL_VOL_NUMERO'
      Origin = 'TB_NOTA_FISCAL.NFL_VOL_NUMERO'
      Size = 8
    end
    object Qr_notaMDF_GRUPO: TStringField
      FieldName = 'MDF_GRUPO'
      Origin = 'TB_MODAL_FRETE.MDF_GRUPO'
      FixedChar = True
      Size = 1
    end
    object Qr_notaNFL_PLC_VEICULO: TStringField
      FieldName = 'NFL_PLC_VEICULO'
      Origin = 'TB_NOTA_FISCAL.NFL_PLC_VEICULO'
      Size = 8
    end
    object Qr_notaNFL_PLC_UF: TStringField
      FieldName = 'NFL_PLC_UF'
      Origin = 'TB_NOTA_FISCAL.NFL_PLC_UF'
      Size = 2
    end
    object Qr_notaNFL_PLC_RNTC: TStringField
      FieldName = 'NFL_PLC_RNTC'
      Origin = 'TB_NOTA_FISCAL.NFL_PLC_RNTC'
    end
    object Qr_notaPAI_DESCRICAO: TStringField
      FieldName = 'PAI_DESCRICAO'
      Origin = 'TB_PAIS.PAI_DESCRICAO'
      Size = 60
    end
    object Qr_notaPED_PRAZO: TStringField
      FieldName = 'PED_PRAZO'
      Origin = 'TB_PEDIDO.PED_PRAZO'
      Size = 200
    end
    object Qr_notaPED_CODEND: TIntegerField
      FieldName = 'PED_CODEND'
      Origin = 'TB_PEDIDO.PED_CODEND'
    end
    object Qr_notaFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Origin = 'TB_FORMAPAGTO.FPT_DESCRICAO'
      Required = True
      Size = 51
    end
  end
  object Qr_Print_Texto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Print_TextoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_NF_INFORMATIZADA'
      'WHERE CFN_NOME = :CHAVE ')
    Left = 182
    Top = 50
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CHAVE'
        ParamType = ptUnknown
      end>
    object Qr_Print_TextoCFN_CODIGO: TIntegerField
      FieldName = 'CFN_CODIGO'
      Origin = 'TB_NF_INFORMATIZADA.CFN_CODIGO'
      Required = True
    end
    object Qr_Print_TextoCFN_NOME: TStringField
      FieldName = 'CFN_NOME'
      Origin = 'TB_NF_INFORMATIZADA.CFN_NOME'
      Size = 50
    end
    object Qr_Print_TextoCFN_DESCRICAO: TStringField
      FieldName = 'CFN_DESCRICAO'
      Origin = 'TB_NF_INFORMATIZADA.CFN_DESCRICAO'
      Size = 50
    end
    object Qr_Print_TextoCFN_TAMANHO: TIntegerField
      FieldName = 'CFN_TAMANHO'
      Origin = 'TB_NF_INFORMATIZADA.CFN_TAMANHO'
    end
    object Qr_Print_TextoCFN_LINHA: TIntegerField
      FieldName = 'CFN_LINHA'
      Origin = 'TB_NF_INFORMATIZADA.CFN_LINHA'
    end
    object Qr_Print_TextoCFN_COLUNA: TIntegerField
      FieldName = 'CFN_COLUNA'
      Origin = 'TB_NF_INFORMATIZADA.CFN_COLUNA'
    end
    object Qr_Print_TextoCFN_TP_PRINT: TIntegerField
      FieldName = 'CFN_TP_PRINT'
      Origin = 'TB_NF_INFORMATIZADA.CFN_TP_PRINT'
    end
    object Qr_Print_TextoCFN_TP_ALINHA: TIntegerField
      FieldName = 'CFN_TP_ALINHA'
      Origin = 'TB_NF_INFORMATIZADA.CFN_TP_ALINHA'
    end
    object Qr_Print_TextoCFN_CARACTER: TStringField
      FieldName = 'CFN_CARACTER'
      Origin = 'TB_NF_INFORMATIZADA.CFN_CARACTER'
      FixedChar = True
      Size = 1
    end
    object Qr_Print_TextoCFN_PRINT: TStringField
      FieldName = 'CFN_PRINT'
      Origin = 'TB_NF_INFORMATIZADA.CFN_PRINT'
      FixedChar = True
      Size = 1
    end
  end
  object Qr_ItensVda: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  ITF_CODIGO,'
      '  PRO_CODIGOFAB,'
      ' PRO_CODIGOBAR,'
      '  PRO_CODIGONCM,'
      '  PRO_DESCRICAO,  '
      '  MED_ABREVIATURA,'
      '  ITF_QTDE,'
      '  ITF_VL_UNIT,'
      '  ITF_VL_CUSTO,'
      '  ITF_CODPRO,'
      '  CAST((ITF_QTDE* ITF_VL_UNIT) AS DOUBLE PRECISION) ITF_VL_SB_TOTAL, '
      '  PRO_CODIGOFOR,'
      '  ITF_VL_DESC,'
      '  ITF_AQ_DESC,  '
      '  ITF_AQ_COM,'
      '  ITF_ESTOQUE,'
      '  ITF_AQ_IPI,'
      '  ITF_AQ_ICMS,'
      '  ITF_CODEST,'
      '  ITF_CODTPR,'
      '  PRO_DETALHES,'
      '  SRP.*'
      'FROM TB_ITENS_NFL INF'
      '   INNER JOIN TB_PRODUTO PRO'
      '   ON  (PRO.PRO_CODIGO = INF.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA MED'
      '   ON  (MED.MED_CODIGO = PRO.PRO_CODMED)'
      '   LEFT OUTER JOIN TB_SERIE_PRODUTO SRP'
      '   ON  (SRP.SRP_CODSAI = INF.ITF_CODNFL)'
      
        'WHERE (ITF_CODNFL=:NFL_CODIGO) AND (ITF_OPER <> '#39'D'#39') AND (PRO_TI' +
        'PO <> '#39'S'#39')'
      'ORDER BY PRO_CODIGOFAB')
    Left = 149
    Top = 53
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_ItensVdaITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = 'TB_ITENS_NFL.ITF_CODIGO'
      Required = True
    end
    object Qr_ItensVdaPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = 'TB_PRODUTO.PRO_CODIGOFAB'
      Size = 50
    end
    object Qr_ItensVdaPRO_CODIGOBAR: TStringField
      FieldName = 'PRO_CODIGOBAR'
      Origin = 'TB_PRODUTO.PRO_CODIGOBAR'
    end
    object Qr_ItensVdaPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = 'TB_PRODUTO.PRO_CODIGONCM'
      Size = 50
    end
    object Qr_ItensVdaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_ItensVdaMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = 'TB_MEDIDA.MED_ABREVIATURA'
      Size = 5
    end
    object Qr_ItensVdaITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = 'TB_ITENS_NFL.ITF_QTDE'
      Precision = 18
      Size = 3
    end
    object Qr_ItensVdaITF_VL_UNIT: TFloatField
      FieldName = 'ITF_VL_UNIT'
      Origin = 'TB_ITENS_NFL.ITF_VL_UNIT'
    end
    object Qr_ItensVdaITF_VL_CUSTO: TFloatField
      FieldName = 'ITF_VL_CUSTO'
      Origin = 'TB_ITENS_NFL.ITF_VL_CUSTO'
    end
    object Qr_ItensVdaITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = 'TB_ITENS_NFL.ITF_CODPRO'
    end
    object Qr_ItensVdaITF_VL_SB_TOTAL: TFloatField
      FieldName = 'ITF_VL_SB_TOTAL'
    end
    object Qr_ItensVdaPRO_CODIGOFOR: TStringField
      FieldName = 'PRO_CODIGOFOR'
      Origin = 'TB_PRODUTO.PRO_CODIGOFOR'
      Size = 50
    end
    object Qr_ItensVdaITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = 'TB_ITENS_NFL.ITF_VL_DESC'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = 'TB_ITENS_NFL.ITF_AQ_DESC'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = 'TB_ITENS_NFL.ITF_AQ_COM'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = 'TB_ITENS_NFL.ITF_ESTOQUE'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensVdaITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = 'TB_ITENS_NFL.ITF_AQ_IPI'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = 'TB_ITENS_NFL.ITF_AQ_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = 'TB_ITENS_NFL.ITF_CODEST'
    end
    object Qr_ItensVdaITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = 'TB_ITENS_NFL.ITF_CODTPR'
    end
    object Qr_ItensVdaPRO_DETALHES: TMemoField
      FieldName = 'PRO_DETALHES'
      Origin = 'TB_PRODUTO.PRO_DETALHES'
      BlobType = ftMemo
      Size = 8
    end
    object Qr_ItensVdaSRP_CODIGO: TIntegerField
      FieldName = 'SRP_CODIGO'
      Origin = 'TB_SERIE_PRODUTO.SRP_CODIGO'
    end
    object Qr_ItensVdaSRP_CODPRO: TIntegerField
      FieldName = 'SRP_CODPRO'
      Origin = 'TB_SERIE_PRODUTO.SRP_CODPRO'
    end
    object Qr_ItensVdaSRP_CODENT: TIntegerField
      FieldName = 'SRP_CODENT'
      Origin = 'TB_SERIE_PRODUTO.SRP_CODENT'
    end
    object Qr_ItensVdaSRP_CODSAI: TIntegerField
      FieldName = 'SRP_CODSAI'
      Origin = 'TB_SERIE_PRODUTO.SRP_CODSAI'
    end
    object Qr_ItensVdaSRP_NUMERO: TStringField
      FieldName = 'SRP_NUMERO'
      Origin = 'TB_SERIE_PRODUTO.SRP_NUMERO'
      Size = 50
    end
    object Qr_ItensVdaSRP_OPERACAO: TStringField
      FieldName = 'SRP_OPERACAO'
      Origin = 'TB_SERIE_PRODUTO.SRP_OPERACAO'
      Size = 1
    end
    object Qr_ItensVdaSRP_DISPON: TStringField
      FieldName = 'SRP_DISPON'
      Origin = 'TB_SERIE_PRODUTO.SRP_DISPON'
      Size = 1
    end
    object Qr_ItensVdaSRP_DESCRICAO: TMemoField
      FieldName = 'SRP_DESCRICAO'
      Origin = 'TB_SERIE_PRODUTO.SRP_DESCRICAO'
      BlobType = ftMemo
      Size = 8
    end
  end
end
