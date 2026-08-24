object Fr_Base_Produtos: TFr_Base_Produtos
  Left = 315
  Top = 256
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Itens da Ficha t'#233'cnica'
  ClientHeight = 155
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 155
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      652
      155)
    object Label1: TLabel
      Left = 6
      Top = 46
      Width = 83
      Height = 13
      Caption = 'Nome do Produto'
      FocusControl = E_Produto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 7
      Top = 7
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = E_CodPro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 536
      Top = 47
      Width = 66
      Height = 13
      Caption = 'Cons. Unit'#225'rio'
      FocusControl = E_Cons_Unitario
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SB_Gravar: TBitBtn
      Left = 410
      Top = 96
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F5'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 3
      OnClick = SB_GravarClick
    end
    object Sb_Pesquisar: TBitBtn
      Left = 488
      Top = 96
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Pesquisar- F7'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 4
      OnClick = Sb_PesquisarClick
      OnMouseMove = Sb_PesquisarMouseMove
    end
    object Sb_Sair_0: TBitBtn
      Left = 566
      Top = 96
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- Esc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 5
      OnClick = Sb_Sair_0Click
    end
    object E_CodPro: TEdit
      Left = 6
      Top = 23
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = E_CodProEnter
      OnExit = E_CodProExit
    end
    object E_Produto: TEdit
      Left = 6
      Top = 61
      Width = 528
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnEnter = E_ProdutoEner
      OnExit = E_ProdutoExit
    end
    object E_Cons_Unitario: TEdit_Setes
      Left = 534
      Top = 61
      Width = 109
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
      OnEnter = E_Cons_UnitarioEnter
      OnExit = E_Cons_UnitarioExit
    end
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        ' SELECT DISTINCT PRO_CODIGO, PRO_CODIGOFAB, PRO_CODIGOFOR, PRO_D' +
        'ESCRICAO, EST_QTDE,PRO_VL_CUSTO,    '
      
        ' PRO_VL_CUSTOMED,MED_ABREVIATURA, SBG_DESCRICAO,  PRO_CAMPANHA, ' +
        'PRO_ATIVO'
      
        ' FROM TB_PRODUTO tb_produto                                     ' +
        '               '
      
        '   INNER JOIN TB_SUBGRUPOS tb_subgrupos  ON (tb_produto.PRO_CODS' +
        'BG = tb_subgrupos.SBG_CODIGO)        '
      
        '   INNER JOIN tb_estoque tb_estoque  ON (tb_estoque.est_codpro =' +
        ' tb_produto.pro_codigo)'
      
        '   INNER JOIN tb_estoqueS tb_estoques ON (tb_estoques.ets_codigo' +
        ' = tb_estoque.est_codets'
      
        '                                          and tb_estoques.ets_pr' +
        'incipal = '#39'S'#39')'
      
        '   inner JOIN tb_medida tb_medida ON tb_medida.med_codigo = tb_p' +
        'roduto.pro_codmed'
      
        'WHERE (PRO_CODIGO IS NOT NULL) and (PRO_TIPO =:PRO_TIPO)        ' +
        '                                     '
      '')
    Left = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_TIPO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 352
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PRO_CODIGOFOR, ITF_QTDE, ITF_CODIGO'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      'WHERE PRO_CODIGO=:PRO_CODIGO AND '
      '  (ITF_CODPED=:ITF_CODPED)')
    Left = 384
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ITF_CODPED'
        ParamType = ptUnknown
      end>
  end
  object Qr_Tamanho: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_GRADETAMANHO'
      'WHERE (GRT_CODICT=:GRT_CODICT)')
    Left = 424
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GRT_CODICT'
        ParamType = ptUnknown
      end>
  end
end
