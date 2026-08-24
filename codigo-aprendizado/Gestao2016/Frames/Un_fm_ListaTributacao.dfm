object fm_ListaTributacao: Tfm_ListaTributacao
  Left = 0
  Top = 0
  Width = 606
  Height = 42
  TabOrder = 0
  object Label1: TLabel
    AlignWithMargins = True
    Left = 5
    Top = 0
    Width = 601
    Height = 14
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Regra de Tributa'#231#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 98
  end
  object Dblcb_Lista: TDBLookupComboBox
    AlignWithMargins = True
    Left = 3
    Top = 17
    Width = 600
    Height = 21
    Align = alTop
    KeyField = 'TRB_CODIGO'
    ListField = 'CFOP_COMPLETE'
    ListSource = Ds_Lista
    TabOrder = 0
    OnKeyDown = Dblcb_ListaKeyDown
  end
  object Qr_Lista: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Listas
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  tb.trb_codigo,'
      '  tb.trb_codpro,'
      '  pd.pro_descricao,'
      
        '  (select TBI_GRUPO || '#39' - '#39' || TBI_DESCRICAO DESCRICAO from TB_' +
        'TRIB_ICMS_NR where TBI_CODIGO = TB.trb_codtbi_icms_nr) cst_CSOSN' +
        ','
      '  CASE '
      
        '    WHEN tb.trb_codpro > 0 THEN nt.nat_cfop || '#39' - '#39' || nt.nat_d' +
        'escricao || '#39' | '#39' || CAST(tb.trb_codpro AS VARCHAR(20)) || '#39' - '#39 +
        ' || pd.pro_descricao'
      '    ELSE nt.nat_cfop || '#39' - '#39' || nt.nat_descricao'
      '  END AS CFOP_COMPLETE,'
      '  nt.nat_cfop'
      'FROM tb_tributacao tb'
      'INNER JOIN tb_natureza nt ON nt.nat_codigo = tb.trb_codnat'
      'LEFT OUTER JOIN tb_produto pd ON pd.pro_codigo = tb.trb_codpro')
    Left = 87
    Top = 24
    object Qr_ListaTRB_CODIGO: TIntegerField
      FieldName = 'TRB_CODIGO'
      Origin = '"TB_TRIBUTACAO"."TRB_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ListaTRB_CODPRO: TIntegerField
      FieldName = 'TRB_CODPRO'
      Origin = '"TB_TRIBUTACAO"."TRB_CODPRO"'
      Required = True
    end
    object Qr_ListaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ListaCST_CSOSN: TStringField
      FieldName = 'CST_CSOSN'
      ProviderFlags = []
      Size = 105
    end
    object Qr_ListaCFOP_COMPLETE: TStringField
      FieldName = 'CFOP_COMPLETE'
      ProviderFlags = []
      Size = 394
    end
    object Qr_ListaNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = '"TB_NATUREZA"."NAT_CFOP"'
      Size = 10
    end
  end
  object Ds_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 144
    Top = 24
  end
end
