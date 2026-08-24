object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 632
  Width = 1333
  object IBD_Gestao: TSTDatabase
    DatabaseName = 'NOTEVALDO/3050:D:\Modelos\Cliente\database\IBGCOM.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'lc_ctype=WIN1252'
      'password=masterkey'
      'DriverID=FB'
      'Database=NOTEVALDO/3050:D:\Modelos\Cliente\database\IBGCOM.FDB')
    LoginPrompt = False
    ServerType = 'IBServer'
    BeforeDisconnect = IBD_GestaoBeforeDisconnect
    Left = 36
    Top = 6
  end
  object IB_Transacao: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 36
    Top = 113
  end
  object Qr_Cargo: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_CargoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CARGO'
      'ORDER BY CRG_DESCRICAO')
    Left = 1031
    Top = 70
  end
  object Qr_Grupo: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_GrupoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TB_GRUPOS'
      'where GRP_COMPOSICAO IS NULL'
      'ORDER BY GRP_DESCRICAO')
    Left = 487
    Top = 6
  end
  object Qr_SubGrupo: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_SubGrupoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_SUBGRUPOS'
      'WHERE'
      '    SBG_CODGRP =:GRP_CODIGO '
      
        'AND (  (SBG_ATIVO = '#39'S'#39' ) OR (SBG_ATIVO = '#39#39') OR (SBG_ATIVO IS N' +
        'ULL))'
      'ORDER BY SBG_DESCRICAO')
    Left = 570
    Top = 6
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GRP_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_Grupo: TDataSource
    DataSet = Qr_Grupo
    Left = 487
    Top = 55
  end
  object Ds_SubGrupo: TDataSource
    DataSet = Qr_SubGrupo
    Left = 570
    Top = 55
  end
  object Qr_Observacao: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ObservacaoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * '
      'FROM TB_OBSERVACAO'
      'WHERE OBS_CODMHA =:OBS_CODMHA'
      'ORDER BY OBS_DESCRICAO')
    Left = 919
    Top = 70
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OBS_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Empresas: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_EmpresasAfterOpen
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
      'WHERE EMP_ATIVA = '#39'S'#39
      'ORDER BY EMP_NOME')
    Left = 825
    Top = 127
  end
  object Qr_Prazo: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_PrazoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_PRAZO'
      'ORDER BY PRZ_PRAZO')
    Left = 1024
    Top = 124
  end
  object Qr_Endereco: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_EnderecoAfterOpen
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
      '  END_PRINCIPAL,'
      
        '  tb_endereco.end_ender || '#39', '#39'|| tb_endereco.end_numero || '#39'  '#39 +
        ' || coalesce(tb_endereco.end_complem,'#39#39')   END_COMPLETO,'
      '  END_WHATSUP'
      'FROM TB_ENDERECO'
      '         INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)'
      'order by END_PRINCIPAL desc')
    Left = 341
    Top = 107
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Impostos: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_IMPOSTOS')
    Left = 1029
    Top = 4
  end
  object Qr_Colaborador: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ColaboradorAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_COLABORADOR'
      'WHERE (CLB_DEMISSAO IS NULL)'
      'Order By CLB_NOME')
    Left = 570
    Top = 107
  end
  object Qr_MarcaVeiculo: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_MarcaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MARCA_VEICULO'
      'ORDER BY MRC_DESCRICAO')
    Left = 661
    Top = 107
  end
  object Qr_Modelo: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ModeloAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MODELO'
      'WHERE (MOD_CODMRC=:MRC_CODIGO)'
      'ORDER BY MOD_DESCRICAO')
    Left = 341
    Top = 6
    ParamData = <
      item
        DataType = ftInteger
        Name = 'MRC_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_MarcaVeiculo: TDataSource
    AutoEdit = False
    DataSet = Qr_MarcaVeiculo
    Left = 661
    Top = 161
  end
  object Ds_Modelo: TDataSource
    DataSet = Qr_Modelo
    Left = 341
    Top = 55
  end
  object Qr_Tp_Veiculo: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Tp_VeiculoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_TP_VEICULO'
      'ORDER BY TPV_DESCRICAO')
    Left = 666
    Top = 220
  end
  object Qr_MarcaProduto: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_MarcaProdutoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MARCA_PRODUTO'
      'ORDER BY MRC_DESCRICAO')
    Left = 249
    Top = 115
  end
  object Qr_ListaUsuario: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ListaUsuarioAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_USUARIO'
      'WHERE USU_ATIVO = '#39'S'#39
      'ORDER BY USU_NOME')
    Left = 1113
    Top = 126
  end
  object Qr_Cartao: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_CartaoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * '
      'FROM TB_CARTAOELETRONICO'
      'ORDER BY CTE_DESCRICAO')
    Left = 815
    Top = 8
  end
  object Qr_Situacao: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_SituacaoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_SITUACAO'
      'WHERE SIT_MODULO=:SIT_MODULO'
      'ORDER BY SIT_DESCRICAO')
    Left = 823
    Top = 238
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SIT_MODULO'
        ParamType = ptUnknown
      end>
  end
  object Qr_UF: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_UFAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_UF'
      'Order By UFE_SIGLA')
    Left = 733
    Top = 119
  end
  object IBT_Estoque: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 36
    Top = 169
  end
  object Qr_Pais: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_PaisAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'PAI_CODBACEN,'
      'PAI_DESCRICAO'
      'from TB_PAIS'
      'ORDER BY PAI_DESCRICAO')
    Left = 733
    Top = 6
  end
  object Qr_Cidades: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_CidadesAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TB_CIDADE'
      'WHERE CDD_UF=:UFE_SIGLA'
      'ORDER BY CDD_DESCRICAO')
    Left = 733
    Top = 222
    ParamData = <
      item
        DataType = ftFixedWideChar
        Name = 'UFE_SIGLA'
        ParamType = ptUnknown
        Size = 6
      end>
  end
  object Ds_UF: TDataSource
    DataSet = Qr_UF
    Left = 733
    Top = 163
  end
  object Ds_Cidades: TDataSource
    DataSet = Qr_Cidades
    Left = 733
    Top = 267
  end
  object ds_Pais: TDataSource
    DataSet = Qr_Pais
    Left = 733
    Top = 51
  end
  object Qr_Estoques: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_EstoquesAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT ETS_CODMHA, ETS_CODIGO, ETS_DESCRICAO, ETS_PRINCIPAL'
      'FROM TB_ESTOQUES'
      'WHERE'
      'ETS_CODMHA = :ETS_CODMHA'
      'ORDER BY ETS_PRINCIPAL DESC, ETS_DESCRICAO ASC'
      '')
    Left = 412
    Top = 107
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ETS_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Ds_Estoques: TDataSource
    DataSet = Qr_Estoques
    Left = 412
    Top = 161
  end
  object Ds_Tabelas: TDataSource
    DataSet = Qr_Tabelas
    Left = 661
    Top = 63
  end
  object Qr_Impressora: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ImpressoraAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_IMPRESSORA')
    Left = 407
    Top = 376
  end
  object IBT_Financeiro: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 36
    Top = 225
  end
  object Qr_Embalagem: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    AfterOpen = Qr_EmbalagemAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_embalagem')
    Left = 412
    Top = 218
  end
  object Ds_Embalagem: TDataSource
    DataSet = Qr_Embalagem
    Left = 412
    Top = 269
  end
  object Ds_marcaProduto: TDataSource
    DataSet = Qr_MarcaProduto
    Left = 249
    Top = 161
  end
  object Qr_Nvl_Manut: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_NVL_MANUT')
    Left = 858
    Top = 347
  end
  object Qr_Filtra_CFOP: TSTQuery
    Database = IBD_Gestao
    Transaction = IBT_Listas
    ForcedRefresh = True
    AfterOpen = Qr_Filtra_CFOPAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'NAT_CODIGO,'
      'NAT_CFOP,'
      'NAT_DESCRICAO,'
      'NAT_CFOP || '#39' - '#39' || NAT_DESCRICAO CFOP,'
      'NAT_RESUMIDO'
      'FROM TB_NATUREZA'
      'WHERE NAT_ATIVO = '#39'S'#39
      '  AND NAT_SENTIDO =:NAT_SENTIDO'
      '  AND NAT_ALCADA=:NAT_ALCADA'
      'ORDER BY NAT_CFOP')
    Left = 929
    Top = 246
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NAT_SENTIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NAT_ALCADA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Modal_Frete: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Modal_FreteAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '   MDF_CODIGO,'
      '  MDF_GRUPO'
      '  ,MDF_GRUPO || '#39' - '#39' || MDF_DESCRICAO DESCRICAO'
      'from "TB_MODAL_FRETE"'
      'WHERE MDF_CODIGO > 0'
      'order by'
      '"TB_MODAL_FRETE"."MDF_CODIGO"')
    Left = 821
    Top = 72
  end
  object IBT_Atualiza: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 36
    Top = 57
  end
  object IBT_Consulta: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 36
    Top = 396
  end
  object Qr_Color: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ColorAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select id , description'
      'from tb_color'
      'Order By description')
    Left = 412
    Top = 6
  end
  object Ds_Color: TDataSource
    DataSet = Qr_Color
    Left = 412
    Top = 55
  end
  object Qr_ImagenBotao: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT OPF_IMAGEM  '
      'FROM TB_OPER_INTERFACE '
      'WHERE OPF_DESCRICAO =:OPF_DESCRICAO ')
    Left = 1112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OPF_DESCRICAO'
        ParamType = ptUnknown
      end>
  end
  object IBT_Generator: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'no_rec_version'
      'wait')
    Left = 36
    Top = 337
  end
  object qr_trib_pis: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT TBP_CODIGO, TBP_GRUPO,'
      'TBP_GRUPO || '#39' - '#39' || TBP_DESCRICAO DESCRICAO'
      'FROM TB_TRIB_PIS'
      ''
      '')
    Left = 487
    Top = 107
  end
  object ds_trib_pis: TDataSource
    DataSet = qr_trib_pis
    Left = 487
    Top = 161
  end
  object Qr_Uf_Mva_NCM: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Uf_Mva_NCMAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT UFE_CODIGO, UFE_ALIQ_INTERNA, UFE_SIGLA, UFE_MR_VL_AGREGA' +
        'DO, MUN_CODIGONCM, MUN_MR_VL_AGREGADO, UFE_ALIQ_INT_EST,UFE_TX_F' +
        'CP'
      'FROM TB_UF'
      '  LEFT OUTER JOIN TB_MVA_UF_NCM '
      '  ON (MUN_CODUFE = UFE_CODIGO)'
      'WHERE UFE_CODIGO=:UFE_CODIGO'
      'Order By UFE_SIGLA')
    Left = 1114
    Top = 68
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UFE_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Especie_Doc_Cobranca: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Especie_Doc_CobrancaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select *'
      'from TB_ESPECIE_DOC '
      'ORDER BY EPD_DESCRICAO')
    Left = 927
    Top = 123
  end
  object Qr_Carteira_Cobranca: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Carteira_CobrancaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CARTEIRA_COBRANCA'
      'WHERE CTR_CODBCO=:CTR_CODBCO')
    Left = 913
    Top = 3
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTR_CODBCO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Negocio: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_NegocioAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_NEGOCIO'
      'ORDER BY NEG_DESCRICAO')
    Left = 335
    Top = 218
  end
  object Ds_Negocio: TDataSource
    DataSet = Qr_Negocio
    Left = 336
    Top = 283
  end
  object Qr_Revestimento: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_RevestimentoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select '
      '  RVT_CODIGO,'
      '  RVT_DESCRICAO'
      'from TB_REVESTIMENTO '
      'ORDER BY   RVT_DESCRICAO')
    Left = 249
    Top = 218
  end
  object Ds_Revestimento: TDataSource
    AutoEdit = False
    DataSet = Qr_Revestimento
    Left = 249
    Top = 269
  end
  object qr_category: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_GrupoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * '
      'FROM TB_CATEGORY '
      'ORDER BY POSIT_LEVEL')
    Left = 570
    Top = 224
  end
  object ds_category: TDataSource
    DataSet = qr_category
    Left = 573
    Top = 277
  end
  object Qr_Carteiras: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_CarteirasAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT CTB_CODIGO, EMP_NUMBCO, EMP_FANTASIA, CTB_AGENCIA,  CTB_A' +
        'G_DV, CTB_CONTA,CTB_CC_DV,'
      
        '(EMP_NUMBCO || '#39' - '#39' || EMP_FANTASIA || '#39' | AG: '#39' || CTB_AGENCIA' +
        ' || '#39' | CC: '#39' || CTB_CONTA || '#39'-'#39' || CTB_CC_DV || '#39'-'#39' || CTR_DES' +
        'CRICAO) CTB_COMPLETO,'
      'tb_boleto_eletronico.ble_aceite,'
      'tb_carteira_cobranca.CTR_CODIGO,'
      'tb_carteira_cobranca.CTR_NUMERO,'
      'tb_boleto_eletronico.BLE_CODIGO,'
      'tb_boleto_eletronico.BLE_TX_DESCONTO, '
      'tb_boleto_eletronico.BLE_TX_JUROS, '
      'tb_boleto_eletronico.BLE_TX_MORA, '
      'tb_boleto_eletronico.BLE_VL_MORA_MIN,'
      'tb_boleto_eletronico.BLE_TX_MULTA,'
      'tb_boleto_eletronico.BLE_PROTESTO,'
      'tb_boleto_eletronico.BLE_VL_TARIFA,'
      'tb_boleto_eletronico.ble_localpag,'
      'tb_boleto_eletronico.ble_instrucoes,'
      'tb_boleto_eletronico.ble_instr_1,'
      'tb_boleto_eletronico.ble_instr_2,'
      'CTR_TIPO_EMISSAO,'
      'BLE_DIAS_PROTESTO,'
      'BLE_DIAS_NEGATIVACAO,'
      'BLE_NEGATIVACAO'
      ''
      'FROM TB_BOLETO_ELETRONICO tb_boleto_eletronico'
      '  INNER JOIN TB_CONTABANCARIA tb_contabancaria'
      
        '  ON (tb_boleto_eletronico.BLE_CODCTB = tb_contabancaria.ctb_cod' +
        'igo)'
      '  INNER JOIN TB_EMPRESA tb_banco'
      '  ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO )'
      '  INNER JOIN tb_carteira_cobranca tb_carteira_cobranca'
      
        '  ON (tb_carteira_cobranca.ctr_codigo = tb_boleto_eletronico.ble' +
        '_codctr)'
      ''
      ''
      'WHERE (CTB_CODMHA=:CTB_CODMHA)')
    Left = 490
    Top = 228
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTB_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Ds_Carteiras: TDataSource
    AutoEdit = False
    DataSet = Qr_Carteiras
    Left = 488
    Top = 272
  end
  object Ds_Endereco: TDataSource
    AutoEdit = False
    DataSet = Qr_Endereco
    Left = 341
    Top = 161
  end
  object Qr_Estabelecimento: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '    EMP_CODIGO,'
      '    EMP_NOME,'
      '    EMP_FANTASIA,'
      '    EMP_PESSOA,'
      '    EMP_CNPJ,'
      '    EMP_INSC_EST,'
      '    EMP_INSC_MUN,'
      '    EMP_SUB_TRIB,'
      '    EMP_CRT,'
      '    END_CEP,'
      '    END_ENDER,'
      '    END_NUMERO, '
      '    END_BAIRRO,'
      '    END_FONE,'
      '    END_FAX,'
      '    END_CELULAR,'
      '   END_COMERCIAL,'
      '   END_PORTARIA,'
      '   END_CONTATO ,'
      '    END_COMPLEM,'
      '    EMP_EMAIL,'
      '    EMP_SITE,'
      '    EMP_CREA,'
      '    EMP_NUMINSC_SUBS,'
      '    CDD_IBGE,'
      '    END_CODCDD,'
      '    CDD_DESCRICAO,'
      '    END_CODUFE,'
      '    UFE_SIGLA,'
      '    UFE_CODIGO,'
      '   END_PAIS,'
      '    PAI_CODBACEN,'
      '    PAI_DESCRICAO  ,'
      'EMP_RESP_TEC,'
      'EMP_RESPONSAVEL,'
      '  EMP_TIP_FAT'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '  INNER JOIN TB_PAIS tb_pais'
      '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      'WHERE (EMP_TIPO = 0) AND (END_PRINCIPAL = '#39'S'#39') AND '
      '  (EMP_CODIGO=:EMP_CODIGO)')
    Left = 1119
    Top = 187
    ParamData = <
      item
        DataType = ftInteger
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Nf_Eletronica: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '   NFE_CODEMP'
      '   ,NFE_AMBIENTE'
      '   ,NFE_EMISSAO'
      '   ,NFE_CERTIFICADO'
      '   ,NFE_REPOSITORIO'
      '   ,NFE_REPOSITORIO_NFCE'
      '   ,NFE_DFE_VISUALIZAR'
      '   ,NFE_DFE_ORIENTACAO'
      '   ,NFE_DFE_FAT'
      '   ,NFE_DFE_DUP'
      '   ,NFE_DFE_TIPO'
      '   ,NFE_EMAIL_CONTADOR'
      '   ,NFE_COPIA_EMAIL'
      '   ,NFE_IDTOKEN'
      '   ,NFE_TOKEN'
      '   ,NFE_POS_CANH'
      '  ,NFE_VERSAO'
      'from TB_NF_ELETRONICA'
      'WHERE NFE_CODEMP=:EMP_CODIGO')
    Left = 1023
    Top = 181
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Colaborador: TDataSource
    DataSet = Qr_Colaborador
    Left = 570
    Top = 161
  end
  object IBT_GeneratorBcoDestino: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'no_rec_version'
      'wait')
    Left = 36
    Top = 281
  end
  object Qr_GeneratorBcoDestino: TSTQuery
    Database = IBD_Gestao
    Transaction = IBT_Generator
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 1047
    Top = 380
  end
  object IBT_ConsultaBcoDestino: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 140
    Top = 241
  end
  object Qr_Acao_EstoqueBcoDestino: TSTQuery
    Database = IBD_Gestao
    Transaction = IBT_Estoque
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT (LCB_VLCREDIT- LCB_VLDEBITO) AS LCB_SLDANT'
      'FROM TB_LANCABANC')
    Left = 1053
    Top = 503
  end
  object Qr_Insere_EstoqueBcoDestino: TSTQuery
    Database = IBD_Gestao
    Transaction = IBT_Estoque
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'INSERT INTO TB_CTRL_ESTOQUE( '
      '  "CET_VINCULO" '
      ', "CET_CONTROLE" '
      ', "CET_ITEM_CTRL" '
      ', "CET_CODETS" '
      ', "CET_OPERACAO" '
      ', "CET_CODPRO" '
      ', "CET_QTDE" '
      ', "CET_DATA") '
      'values( '
      '  :"CET_VINCULO" '
      ', :"CET_CONTROLE" '
      ', :"CET_ITEM_CTRL" '
      ', :"CET_CODETS" '
      ', :"CET_OPERACAO" '
      ', :"CET_CODPRO" '
      ', :"CET_QTDE" '
      ', :"CET_DATA")')
    Left = 1049
    Top = 439
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CET_VINCULO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CET_CONTROLE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CET_ITEM_CTRL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CET_CODETS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CET_OPERACAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CET_CODPRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CET_QTDE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CET_DATA'
        ParamType = ptUnknown
      end>
  end
  object IBT_EstoqueBcoDestino: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 140
    Top = 345
  end
  object Qr_Transportadora: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '    EMP_CODIGO,'
      '    EMP_NOME,'
      '    EMP_FANTASIA,'
      '    EMP_CNPJ,'
      '    EMP_INSC_EST,'
      '    END_CEP,'
      '    END_ENDER,'
      '    END_NUMERO, '
      '    END_BAIRRO,'
      '    CDD_IBGE,'
      '    CDD_DESCRICAO,'
      '    UFE_SIGLA,'
      '    PAI_CODBACEN,'
      '    PAI_DESCRICAO ,'
      '   EMP_EMAIL,'
      '  CDD_IBGE'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '  INNER JOIN TB_PAIS tb_pais'
      '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      'WHERE (END_PRINCIPAL = '#39'S'#39') AND '
      '  (EMP_CODIGO=:EMP_CODIGO)'
      '')
    Left = 823
    Top = 182
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Natureza: TDataSource
    DataSet = Qr_Filtra_CFOP
    Left = 929
    Top = 295
  end
  object Qr_Tabelas: TSTQuery
    Database = IBD_Gestao
    Transaction = IB_Transacao
    AfterOpen = Qr_TabelasAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select  * from TB_TABELA_PRECO'
      'ORDER BY TPR_NOME')
    Left = 661
    Top = 6
  end
  object Qr_Crud: TSTQuery
    Database = IBD_Gestao
    Transaction = IBT_Crud
    ForcedRefresh = True
    AutoCalcFields = False
    AfterOpen = Qr_Filtra_CFOPAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_FCP_UF_NCM'
      'WHERE    TB_STATE_ID = :TB_STATE_ID ')
    Left = 1033
    Top = 246
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TB_STATE_ID'
        ParamType = ptUnknown
      end>
  end
  object IBT_Faturamento: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 142
    Top = 115
  end
  object IBT_Crud: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 1036
    Top = 297
  end
  object Ds_TPV_Veiculo: TDataSource
    AutoEdit = False
    DataSet = Qr_Tp_Veiculo
    Left = 664
    Top = 277
  end
  object IBT_Listas: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 140
    Top = 292
  end
  object IBD_Servidor: TSTDatabase
    DatabaseName = 'NOTEVALDO/3050:D:\Modelos\SpaceSound\Database\Dados.fdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252'
      'DriverID=FB'
      'Database=NOTEVALDO/3050:D:\Modelos\SpaceSound\Database\Dados.fdb')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 144
    Top = 8
  end
  object IBT_Servidor: TSTTransaction
    DefaultDatabase = IBD_Servidor
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 140
    Top = 57
  end
  object IBT_Report: TSTTransaction
    DefaultDatabase = IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 140
    Top = 185
  end
  object Ds_Impressora: TDataSource
    AutoEdit = False
    DataSet = Qr_Impressora
    Left = 416
    Top = 432
  end
end
