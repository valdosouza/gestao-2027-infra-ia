object Fr_GeraNfe3x: TFr_GeraNfe3x
  Left = 405
  Top = 69
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Nota Fiscal Eletronica - Vendas'
  ClientHeight = 628
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pg_Principal: TPageControl
    Left = 0
    Top = 28
    Width = 586
    Height = 600
    Align = alClient
    TabOrder = 0
  end
  object Pnl_Validade: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 580
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Pnl_Cert_Validade: TPanel
      Left = 0
      Top = 0
      Width = 264
      Height = 22
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Validade do Certificado Digital'
      TabOrder = 0
    end
    object Pnl_Cert_Expira: TPanel
      Left = 264
      Top = 0
      Width = 316
      Height = 22
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'O certificado expira em 1 dia(s)'
      TabOrder = 1
    end
  end
  object ds_Nota: TDataSource
    DataSet = Qr_Nota
    Left = 699
    Top = 194
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT  '
      '   PED_CODIGO, '
      '   NFL_CODIGO, '
      '   NAT_DESCRICAO,'
      '   NFL_SERIE, '
      '   NAT_CFOP, '
      '   PED_NUMERO,'
      '   PED_indPres,'
      '   NFL_NUMERO, '
      '   NFL_VL_TL_NOTA,'
      '   EMP_CODIGO,  '
      '   EMP_CONSUMIDOR,'
      '   EMP_NOME, '
      '   EMP_FANTASIA,'
      '   EMP_CNPJ, '
      '   EMP_EMAIL,'
      '   END_ENDER,'
      '   END_BAIRRO,'
      '   END_CEP,  '
      '   CDD_IBGE, '
      '   CDD_DESCRICAO,'
      '   END_FONE, '
      '   END_CELULAR,'
      '   UFE_SIGLA, '
      '   UFE_CODIGO,'
      '   END_PAIS,  '
      '   EMP_INSC_EST, '
      '   NFL_DT_EMISSAO, '
      '   NFL_DT_SAIDA,  '
      '   NFL_BS_ICMS, '
      '   NFL_VL_ICMS, '
      '   NFL_BS_ICMS_SUBST, '
      '   NFL_VL_ICMS_SUBST, '
      '   NFL_VL_TL_PROD, '
      '   NFL_VL_FRETE,  '
      '   NFL_VL_SEGURO, '
      '   NFL_VL_DESP_ACESS, '
      '   NFL_VL_IPI,  '
      '   NFL_QT_PRODUTO, '
      '   NFL_ESPECIE,'
      '   NFL_MARCA, '
      '   NFL_PESO_BRUTO, '
      '   NFL_PESO_LIQ,   '
      '   CLB_NOME, '
      '   NFL_STATUS,'
      '   NFL_TIPO,  '
      '   PED_OBS,'
      '   NFL_VL_TL_SRV,'
      '   PED_VL_DESCONTO, '
      '   PED_DT_ALTERA, '
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
      '  PED_CODEND,'
      '  CLI_IND_IE_DEST'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal                           '
      '     INNER JOIN TB_PEDIDO tb_pedido                       '
      '     ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)   '
      '     INNER  JOIN TB_NATUREZA tb_natureza                  '
      '     ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) '
      '     INNER JOIN TB_EMPRESA tb_empresa'
      '     ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)  '
      '     INNER JOIN TB_CLIENTE tb_cliente'
      '     ON (tb_cliente.CLI_CODEMP = tb_empresa.EMP_CODIGO)  '
      '     INNER  JOIN TB_ENDERECO tb_endereco                  '
      '     ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '     INNER JOIN TB_CIDADE tb_cidade'
      '     ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '     INNER JOIN TB_UF tb_uf'
      '     ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '     INNER  JOIN TB_PAIS tb_pais'
      '     ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)   '
      '     LEFT OUTER  JOIN TB_COLABORADOR tb_colaborador'
      '     ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)   '
      '     INNER  JOIN tb_modal_frete tb_modal_frete'
      
        '     ON (tb_modal_frete.mdf_codigo = tb_nota_fiscal.nfl_cta_fret' +
        'e)'
      'WHERE (tb_nota_fiscal.NFL_NUMERO ='#39'1'#39')')
    Left = 700
    Top = 139
  end
  object Qr_Itens: TSTQuery
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
      '  PRO_SUB_TRIB,'
      '  PRO_ORIGEM,'
      '  PRO_DESCRICAO,  '
      '  MED_ABREVIATURA,'
      '  ITF_QTDE,'
      '  ITF_VL_UNIT,'
      '  ITF_VL_CUSTO,'
      '  ITF_CODPRO,'
      '  (ITF_QTDE* ITF_VL_UNIT) ITF_VL_SB_TOTAL, '
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
      
        'WHERE (ITF_CODNFL=:ITF_CODNFL) AND (ITF_OPER <> '#39'D'#39') AND (PRO_TI' +
        'PO <> '#39'S'#39')')
    Left = 790
    Top = 132
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODNFL'
        ParamType = ptUnknown
      end>
  end
  object Qr_IPI: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select IPI_CL_ENQD'
      '      ,IPI_CNPJ_PROD'
      '      ,IPI_CD_SELO'
      '      ,IPI_QT_SELO'
      '      ,IPI_CD_ENQD'
      '      ,IPI_VL_BC'
      '      ,IPI_AQ_NR'
      '      ,IPI_QT_UNID'
      '      ,IPI_VL_UNID'
      '      ,TBI_GRUPO'
      'from TB_ITENS_IPI tb_itens_ipi'
      '  INNER JOIN TB_TRIB_IPI tb_trib_ipi'
      '  ON(tb_trib_ipi.TBI_CODIGO = tb_itens_ipi.IPI_CODTBI)'
      'WHERE IPI_CODITF =:ITF_CODIGO')
    Left = 838
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_II: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '  IIP_VL_BASE'
      '  ,IIP_VL_DESP_AD'
      '  ,IIP_VL_II'
      '  ,IIP_VL_IOF'
      ' FROM TB_ITENS_II '
      'WHERE IIP_CODITF =:ITF_CODIGO')
    Left = 870
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Pis: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '  PIS_VL_BC'
      '  ,PIS_AQ_NR'
      '  ,PIS_VL_NR'
      '  ,PIS_QT_VDA'
      '  ,PIS_VL_AQ'
      '  ,TBP_GRUPO'
      'from TB_ITENS_PIS tb_itens_pis'
      '   INNER JOIN TB_TRIB_PIS tb_trib_pis'
      '   ON (tb_trib_pis.TBP_CODIGO = tb_itens_pis.PIS_CODTBP)'
      'WHERE PIS_CODITF =:ITF_CODIGO')
    Left = 902
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Cofins: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '       CFS_VL_BC'
      '      ,CFS_AQ_NR'
      '      ,CFS_VL_NR'
      '      ,CFS_QT_UNID'
      '      ,CFS_VL_AQ'
      '      ,TBC_GRUPO'
      'from TB_ITENS_CFS'
      '   INNER JOIN TB_TRIB_CFS tb_trib_cfs'
      '   ON (tb_trib_cfs.TBC_CODIGO = tb_itens_cfs.CFS_CODTBC)'
      'WHERE CFS_CODITF =:ITF_CODIGO')
    Left = 934
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Financeiro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '   FIN_CODPED,'
      '    FIN_NUMERO,'
      '    FIN_DT_VENCIMENTO,'
      '    FIN_VL_PARCELA,'
      '    FPT_TIPO_NFCE,'
      '    FPT_DESCRICAO, '
      '    FIN_DATA'
      'FROM TB_FINANCEIRO'
      '  INNER JOIN TB_FORMAPAGTO'
      '  ON (FIN_CODFPG = FPT_CODIGO)'
      'WHERE (FIN_CODNFL =:FIN_CODNFL)  ')
    Left = 731
    Top = 138
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODNFL'
        ParamType = ptUnknown
      end>
  end
  object Qr_Natureza: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_NATUREZA'
      'WHERE NAT_CFOP=:NAT_CFOP')
    Left = 822
    Top = 67
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NAT_CFOP'
        ParamType = ptUnknown
      end>
  end
  object Qr_Serie_Veiculo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select "TB_SERIE_VEICULO"."SRV_CODIGO"'
      '      ,"TB_SERIE_VEICULO"."SRV_CODITF"'
      '      ,"TB_SERIE_VEICULO"."SRV_TIPO_OPER"'
      '      ,"TB_SERIE_VEICULO"."SRV_CHASSI"'
      '      ,"TB_SERIE_VEICULO"."SRV_CODICOR"'
      '      ,"TB_SERIE_VEICULO"."SRV_DESC_COR"'
      '      ,"TB_SERIE_VEICULO"."SRV_POT_MOTOR"'
      '      ,"TB_SERIE_VEICULO"."SRV_CILINDRADA"'
      '      ,"TB_SERIE_VEICULO"."SRV_PESO_LIQ"'
      '      ,"TB_SERIE_VEICULO"."SRV_PESO_BRT"'
      '      ,"TB_SERIE_VEICULO"."SRV_SERIE"'
      '      ,"TB_SERIE_VEICULO"."SRV_TIPO_COMB"'
      '      ,"TB_SERIE_VEICULO"."SRV_NUM_MOTOR"'
      '      ,"TB_SERIE_VEICULO"."SRV_CMT"'
      '      ,"TB_SERIE_VEICULO"."SRV_DISTEIXO"'
      '      ,"TB_SERIE_VEICULO"."SRV_ANO_MOD"'
      '      ,"TB_SERIE_VEICULO"."SRV_ANO_FAB"'
      '      ,"TB_SERIE_VEICULO"."SRV_TIPO_PINTURA"'
      '      ,"TB_SERIE_VEICULO"."SRV_CODTPV"'
      '      ,"TB_SERIE_VEICULO"."SRV_CODEPV"'
      '      ,"TB_SERIE_VEICULO"."SRV_VIN"'
      '      ,"TB_SERIE_VEICULO"."SRV_COND_VEIC"'
      '      ,"TB_SERIE_VEICULO"."SRV_CODMOD"'
      '      ,"TB_SERIE_VEICULO"."SRV_CODCOR"'
      '      ,"TB_SERIE_VEICULO"."SRV_LOTA"'
      '      ,"TB_SERIE_VEICULO"."SRV_CODRTV"'
      'from "TB_SERIE_VEICULO"'
      'WHERE (SRV_CODITF=:SRV_CODITF)')
    Left = 660
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SRV_CODITF'
        ParamType = ptUnknown
      end>
  end
  object Qr_lote: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      '  ITF_CODIGO,'
      '  CE.cet_codpro,'
      '  cl.clt_numero,'
      ' CLT_CODIGO,'
      '  cl.clt_dt_vencimento,'
      '  ml.mlt_data,'
      '  MLT_QTDE'
      'FROM tb_itens_nfl i'
      '  inner join tb_ctrl_estoque ce'
      '  on (ce.cet_item_ctrl = i.itf_codigo)'
      '  inner join tb_movimento_lote ml'
      '  on (ml.mlt_codvcl = ce.cet_item_ctrl)'
      '  INNER JOIN tb_ctrl_lote cl'
      '  on (cl.clt_codigo = ml.mlt_codclt)'
      'where ITF_CODIGO =:ITF_CODIGO')
    Left = 548
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Serie_Produto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_SERIE_PRODUTO'
      'WHERE SRP_CODSAI=:SRP_CODSAI')
    Left = 611
    Top = 195
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SRP_CODSAI'
        ParamType = ptUnknown
      end>
  end
  object Qr_Observacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select DISTINCT'
      '  OBN_DETALHE'
      'from TB_OBS_NFE'
      'where OBN_CODNFL=:NFL_CODIGO AND OBN_TIPO=:OBN_TIPO')
    Left = 953
    Top = 229
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OBN_TIPO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Issqn: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '    ISS_VL_BC ,'
      '    ISS_AQ_NR,'
      '    ISS_VL_NR,'
      '    ISS_MUN_IBGE,'
      '    ISS_LST_SRV,'
      '    ISS_SIT_TRIB,'
      '    ISS_VL_PIS,'
      '    ISS_VL_CFS,'
      '    ISS_VL_RET'
      'from TB_ITENS_ISSQN'
      'WHERE ISS_CODITF =:ITF_CODIGO')
    Left = 878
    Top = 228
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Itens_ICMS_ST: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    ICM_MD_BC_ST,'
      '    ICM_AQ_RD_BC_ST,'
      '    ICM_MG_VA_ST,'
      '    ICM_VL_BC_ST,'
      '    ICM_AQ_ST,'
      '    ICM_AQ_RD_ST,'
      '    ICM_VL_ST,'
      '    ICM_VL_BC_ST_RET,'
      '    ICM_VL_ST_RET'
      'FROM TB_ITENS_ICMS'
      'WHERE (ICM_VL_BC_ST > 0)'
      'AND (ICM_MG_VA_ST > 0)'
      'AND (ICM_VL_ST > 0)'
      'AND (ICM_CODITF=:ITF_CODIGO)')
    Left = 638
    Top = 308
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_ItensDev: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPRO, '
      '  ITF_CODPED,'
      '  MED_ABREVIATURA,'
      '  PRO_CODIGOFAB,'
      '   PRO_TIPO,'
      '  PRO_DESCRICAO,'
      '  EMB_ABREVIATURA,'
      '  ITF_QTDE, '
      '  ITF_VL_UNIT,'
      '  ITF_ESTOQUE,'
      '  ITF_CODEST,'
      '  (ITF_QTDE * ITF_VL_UNIT) AS  ITF_SUBTOTAL,'
      '   ((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) ITF_VL_TOTAL,'
      '   ITF_AQ_COM,'
      '  ( (ITF_QTDE * ITF_VL_UNIT) * (ITF_AQ_COM/100)) ITF_VL_COM,'
      '   ITF_VL_DESC,'
      '     PRO_VL_CUSTOMED,'
      '  ITF_AQ_DESC,'
      '  ITF_AQ_IPI,'
      '  ITF_AQ_ICMS,'
      '  ITF_CODTPR,'
      'ITF_VL_CUSTO'
      'FROM TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   left join tb_embalagem tb_embalagem'
      '     on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      'WHERE (ITF_CODNFL = :NFL_CODIGO) and ITF_OPER = '#39'D'#39' '
      'AND tb_produto.pro_tipo <> '#39'S'#39)
    Left = 712
    Top = 328
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_ItensDev: TDataSource
    AutoEdit = False
    DataSet = Qr_ItensDev
    Left = 712
    Top = 384
  end
  object Qr_RetornoNFe: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    NFC_CODIGO,'
      '    NFC_LOTE,'
      '    NFC_SINCRONO,'
      '    NFC_TP_EMISSAO,'
      '    NFC_FORMATO,'
      '    NFC_IND_PRES,'
      '    NFC_CODSIT,'
      '    NFC_ARQUIVO,'
      '    NFC_MOTIVO,'
      '    EMP_NOME,'
      '    EMP_EMAIL,'
      '    NFL_DT_EMISSAO,'
      '   NFL_TIPO'
      'FROM TB_NOTA_FISCAL'
      '   INNER JOIN TB_EMPRESA'
      '  ON (EMP_CODIGO = NFL_CODEMP)'
      '   INNER JOIN TB_RETORNO_NFC'
      '   ON (NFL_CODIGO = NFC_CODNFL)'
      'WHERE NFL_CODIGO = :NFL_CODIGO')
    Left = 1012
    Top = 67
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_LoteNFC_e_OffLine: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select NFC_CODIGO, NFC_CODNFL'
      'from tb_retorno_nfc'
      'where nfc_tp_emissao = 9 and nfc_codsit = 0')
    Left = 644
    Top = 232
  end
  object Qr_FCP: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select *'
      'from TB_ICMS_FCP'
      'where TB_ITENS_NFL_ID=:ITENS_NFL_ID')
    Left = 822
    Top = 228
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITENS_NFL_ID'
        ParamType = ptUnknown
      end>
  end
  object Qr_DevolIpi: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select *'
      'from tb_devol_ipi di'
      'where di.tb_order_item_id =:order_item_id')
    Left = 798
    Top = 316
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'order_item_id'
        ParamType = ptUnknown
      end>
  end
  object Qr_LoteProduzido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      '  cl.clt_codpro,'
      '  cl.clt_numero,'
      '  cl.clt_dt_vencimento,'
      '  ml.mlt_data'
      'FROM tb_ctrl_lote cl'
      '  inner join tb_movimento_lote ml'
      '  on (ml.mlt_codclt = cl.CLT_CODIGO)'
      
        'where ( ml.MLT_TIPO = '#39'PRODU'#199#195'O P.A.'#39' )  AND (cl.CLT_CODIGO=:CLT' +
        '_CODIGO)')
    Left = 692
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CLT_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Icms: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      'ICM_CODIGO'
      '      ,ICM_CODNFL'
      '      ,ICM_CODITF'
      '      ,ICM_CODTBI_NR'
      '      ,ICM_CODTBI_SN'
      '      ,ICM_ORIGEM'
      '      ,ICM_MD_BC_NR'
      '      ,ICM_AQ_RD_BC_NR'
      '      ,ICM_VL_BC_NR'
      '      ,ICM_AQ_NR'
      '      ,ICM_AQ_RD_NR'
      '      ,ICM_VL_NR'
      '      ,ICM_MD_BC_ST'
      ''
      ''
      ''
      '      ,ICM_AQ_RD_BC_ST'
      '      ,ICM_MG_VA_ST'
      '      ,ICM_VL_BC_ST'
      '      ,ICM_AQ_ST'
      '      ,ICM_AQ_RD_ST'
      '      ,ICM_VL_ST'
      '      ,ICM_CODDSI'
      '      ,ICM_VL_BC_ST_RET'
      '      ,ICM_VL_ST_RET'
      '      ,ICM_PARTILHA'
      '      ,ICM_REPASSE'
      '      ,ICM_VL_BC_RET'
      '      ,ICM_VL_RET'
      '      ,ICM_AQ_CALC_CRED'
      '      ,ICM_VL_CRED_APRO'
      '      ,ICM_VL_FRETE'
      '      ,ICM_VL_SEGURO'
      '      ,ICM_VL_OUTRAS'
      '      ,ICM_CODNAT'
      '      ,ICM_DESTAQUE'
      '      ,ICM_CODOBS'
      '      , NAT_CFOP'
      '      ,NAT_RESUMIDO'
      '      ,TB_TRIB_ICMS_NR.TBI_GRUPO ICM_CST'
      '      ,TB_TRIB_ICMS_SN.TBI_GRUPO ICM_CSOSN'
      
        '      ,(ICM_VL_BC_NR * ((ICM_AQ_NR - ICM_AQ_RD_NR) ) /100) as to' +
        'tal'
      '     ,ICM_AQ_DIF'
      '     ,ICM_VL_DIF'
      ''
      'FROM   TB_ITENS_ICMS'
      '    INNER JOIN TB_NATUREZA'
      '    ON (NAT_CODIGO = ICM_CODNAT)'
      '   LEFT OUTER JOIN TB_TRIB_ICMS_NR'
      '   ON (TB_TRIB_ICMS_NR.TBI_CODIGO = TB_ITENS_ICMS.ICM_CODTBI_NR)'
      '   LEFT OUTER JOIN TB_TRIB_ICMS_SN'
      '   ON (TB_TRIB_ICMS_SN.TBI_CODIGO = TB_ITENS_ICMS.ICM_CODTBI_SN)'
      ''
      'WHERE ICM_CODITF =:ICM_CODITF')
    Left = 748
    Top = 228
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ICM_CODITF'
        ParamType = ptUnknown
        Value = 7422
      end>
  end
  object Qr_Combustivel: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select *'
      'from tb_nfe_itens_fuel n'
      'where n.tb_order_items_id =:tb_order_items_id')
    Left = 1020
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'tb_order_items_id'
        ParamType = ptUnknown
      end>
  end
  object Qr_Itens_RTR: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM tb_itens_rtr R'
      'WHERE R.itr_coditf =:itr_coditf')
    Left = 596
    Top = 420
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'itr_coditf'
        ParamType = ptUnknown
      end>
  end
  object Qr_RetornoNFCe: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    NFC_CODIGO,'
      '    NFC_LOTE,'
      '    NFC_SINCRONO,'
      '    NFC_TP_EMISSAO,'
      '    NFC_FORMATO,'
      '    NFC_IND_PRES,'
      '    NFC_CODSIT,'
      '    NFC_ARQUIVO,'
      '    NFC_MOTIVO,'
      '    EMP_NOME,'
      '    EMP_EMAIL,'
      '    NFL_DT_EMISSAO,'
      '   NFL_TIPO'
      'FROM TB_NOTA_FISCAL'
      '   INNER JOIN TB_EMPRESA'
      '  ON (EMP_CODIGO = NFL_CODEMP)'
      '   INNER JOIN TB_RETORNO_NFC'
      '   ON (NFL_CODIGO = NFC_CODNFL)'
      'WHERE NFL_CODIGO = :NFL_CODIGO')
    Left = 908
    Top = 67
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
