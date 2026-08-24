object Fr_NF_SRV: TFr_NF_SRV
  Left = 338
  Top = 15
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o - Nota Fiscal de Servi'#231'o Eletr'#244'nica de Servi'#231'os'
  ClientHeight = 557
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Operacao
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 713
    Height = 88
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 226
      Top = 3
      Width = 58
      Height = 14
      Caption = 'N'#250'mero N.F.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 6
      Top = 2
      Width = 80
      Height = 14
      Caption = 'Data da Emiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 55
      Top = 43
      Width = 63
      Height = 14
      Caption = 'Raz'#227'o Social'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 455
      Top = 43
      Width = 68
      Height = 14
      Caption = 'C.N.P.J / C.P.F.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 4
      Top = 43
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 112
      Top = 3
      Width = 71
      Height = 14
      Caption = 'Npumero R.P.S'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 306
      Top = 3
      Width = 85
      Height = 14
      Caption = 'N'#250'mero Protocolo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 455
      Top = 3
      Width = 106
      Height = 14
      Caption = 'C'#243'digo de Verifica'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Nota: TDBEdit
      Left = 225
      Top = 18
      Width = 77
      Height = 22
      DataField = 'NFS_NUMERO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_Dt_Emissao: TDBEdit
      Left = 5
      Top = 18
      Width = 104
      Height = 22
      DataField = 'NFL_DT_EMISSAO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
    end
    object E_RazaoSocial: TDBEdit
      Left = 53
      Top = 57
      Width = 397
      Height = 22
      DataField = 'EMP_NOME'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_Cnpj_CPf: TDBEdit
      Left = 454
      Top = 57
      Width = 152
      Height = 22
      DataField = 'EMP_CNPJ'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object E_CodCli: TDBEdit
      Left = 4
      Top = 57
      Width = 48
      Height = 22
      DataField = 'EMP_CODIGO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_RPS: TDBEdit
      Left = 111
      Top = 18
      Width = 112
      Height = 22
      DataField = 'RPS_NUMERO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_PROTOCOLO: TDBEdit
      Left = 304
      Top = 18
      Width = 148
      Height = 22
      DataField = 'RPS_PROTOCOLO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_COD_VERIF: TDBEdit
      Left = 454
      Top = 18
      Width = 150
      Height = 22
      DataField = 'NFS_COD_VERIF'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
  end
  object DBG_Produtos: TDBGrid
    Left = 0
    Top = 88
    Width = 713
    Height = 364
    Align = alClient
    Color = clMoneyGreen
    DataSource = Ds_ItensNota
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick]
    ParentFont = False
    PopupMenu = Pop_Produto
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PRO_CODIGOFAB'
        Title.Caption = 'Codigo'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRO_DESCRICAO'
        Title.Caption = 'Descri'#231#227'o dos Servi'#231'os'
        Width = 282
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_QTDE'
        Title.Caption = 'Qtde'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_VL_UNIT'
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_VL_DESC'
        Title.Caption = 'Desconto'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_VL_TOTAL'
        Title.Caption = 'Total'
        Width = 91
        Visible = True
      end>
  end
  object Panel3: TPanel
    Left = 0
    Top = 452
    Width = 713
    Height = 43
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label17: TLabel
      Left = 605
      Top = 3
      Width = 78
      Height = 12
      Caption = 'Valor Total da Nota'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_VL_Total: TEdit
      Left = 605
      Top = 16
      Width = 101
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 495
    Width = 713
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    DesignSize = (
      713
      62)
    object Sb_Sair_0: TSpeedButton
      Left = 616
      Top = 4
      Width = 92
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
      ExplicitLeft = 515
    end
  end
  object Qr_ItensNota: TSTQuery
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
      '  MED_ABREVIATURA,'
      '  PRO_CODIGOFAB,'
      '   PRO_CODIGONCM,'
      '  PRO_ORIGEM,'
      '   PRO_TIPO,'
      '  PRO_DESCRICAO,'
      '  PRO_SERIE,'
      '  ITF_QTDE, '
      '  ITF_VL_UNIT,'
      '  ITF_ESTOQUE,'
      '  ITF_OPER,'
      '  ITF_CODEST,'
      '  CAST(( ITF_QTDE * ITF_VL_UNIT) AS NUMERIC(18, 9)) AS  ITF_SUBTOTAL,'
      '  CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC  ) AS NUMERIC(18, 9)) ITF_VL_TOTAL,'
      '  ITF_AQ_COM,'
      '  CAST(( (ITF_QTDE * ITF_VL_UNIT) * (ITF_AQ_COM/100)) AS DOUBLE PRECISION) ITF_VL_COM,'
      '  ITF_VL_DESC,'
      '  PRO_VL_CUSTOMED,'
      '  ITF_AQ_DESC,'
      '  ITF_AQ_IPI,'
      '  ITF_AQ_ICMS,'
      '  ITF_CODTPR,'
      'ITF_VL_CUSTO,'
      'ITF_IMP_APROX'
      'FROM TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   LEFT OUTER join tb_itens_issqn'
      '   ON (ISS_CODITF = ITF_CODIGO)'
      'WHERE (ITF_CODNFL = :NFL_CODIGO) '
      'AND tb_produto.pro_tipo = '#39'S'#39)
    Left = 216
    Top = 400
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
        Value = 9399
      end>
    object Qr_ItensNotaITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensNotaITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensNotaMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensNotaPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensNotaPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = '"TB_PRODUTO"."PRO_CODIGONCM"'
      Size = 50
    end
    object Qr_ItensNotaPRO_ORIGEM: TStringField
      FieldName = 'PRO_ORIGEM'
      Origin = '"TB_PRODUTO"."PRO_ORIGEM"'
      Size = 1
    end
    object Qr_ItensNotaPRO_TIPO: TStringField
      FieldName = 'PRO_TIPO'
      Origin = '"TB_PRODUTO"."PRO_TIPO"'
      Size = 1
    end
    object Qr_ItensNotaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensNotaPRO_SERIE: TStringField
      FieldName = 'PRO_SERIE'
      Origin = '"TB_PRODUTO"."PRO_SERIE"'
      Size = 1
    end
    object Qr_ItensNotaITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 3
    end
    object Qr_ItensNotaITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensNotaITF_OPER: TStringField
      FieldName = 'ITF_OPER'
      Origin = '"TB_ITENS_NFL"."ITF_OPER"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensNotaITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensNotaITF_SUBTOTAL: TFMTBCDField
      FieldName = 'ITF_SUBTOTAL'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 9
    end
    object Qr_ItensNotaITF_VL_TOTAL: TFMTBCDField
      FieldName = 'ITF_VL_TOTAL'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 9
    end
    object Qr_ItensNotaITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_VL_COM: TFloatField
      FieldName = 'ITF_VL_COM'
      ProviderFlags = []
    end
    object Qr_ItensNotaITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensNotaITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_IMP_APROX: TBCDField
      FieldName = 'ITF_IMP_APROX'
      Origin = '"TB_ITENS_NFL"."ITF_IMP_APROX"'
      Precision = 18
      Size = 3
    end
  end
  object Ds_ItensNota: TDataSource
    AutoEdit = False
    DataSet = Qr_ItensNota
    Left = 208
    Top = 456
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '      PED_CODIGO, '
      '      NFL_CODIGO, '
      '      PED_CODFPG,'
      '      EMP_CODIGO, '
      '      EMP_NOME, '
      '      EMP_CNPJ, '
      '      NFL_DT_EMISSAO, '
      '      NFL_VL_TL_SRV,'
      '      RPS.NUMERO RPS_NUMERO,'
      '      NFS_NUMERO,'
      '     RPS.PROTOCOLO RPS_PROTOCOLO,'
      '     NFS_COD_VERIF'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '      INNER JOIN TB_PEDIDO tb_pedido'
      '      ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      ''
      '      INNER JOIN TB_EMPRESA tb_empresa'
      '      ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      ''
      '      LEFT OUTER JOIN TB_RETORNO_NFS'
      '     ON (NFS_CODNFL = NFL_CODIGO)'
      '      LEFT OUTER JOIN TB_RPS_NFSE RPS'
      '     ON (RPS.TB_NOTAFISCAL_ID = NFL_CODIGO)'
      ''
      'WHERE (NFL_CODIGO=:NFL_CODIGO)  '
      ''
      '')
    Left = 144
    Top = 400
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object DS_Nota: TDataSource
    AutoEdit = False
    DataSet = Qr_Nota
    Left = 144
    Top = 448
  end
  object Mnu_Operacao: TMainMenu
    Left = 169
    Top = 50
    object Mnu_Operacao_Tarefas: TMenuItem
      Caption = 'Tarefas'
      object Itm_CadastroDestinatrio: TMenuItem
        Caption = 'Cadastro Destinat'#225'rio'
        OnClick = Itm_CadastroDestinatrioClick
      end
      object Itm_Autorizar: TMenuItem
        Caption = 'Opera'#231#245'es NFS-e'
        OnClick = Itm_AutorizarClick
      end
      object AnexarXML1: TMenuItem
        Caption = 'Anexar XML'
        OnClick = AnexarXML1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
      end
    end
  end
  object Pop_Produto: TPopupMenu
    Left = 388
    Top = 164
    object CadastrodoProduto: TMenuItem
      Caption = 'Cadastro de Servi'#231'os'
      OnClick = CadastrodoProdutoClick
    end
  end
end
