inherited Fr_InclusaoRapidaProduto: TFr_InclusaoRapidaProduto
  BorderIcons = [biSystemMenu]
  Caption = 'Inclus'#227'o R'#225'pida de Produtos'
  ClientHeight = 154
  ClientWidth = 673
  Menu = nil
  ExplicitWidth = 679
  ExplicitHeight = 183
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Prod_Sem_Registro: TPanel [0]
    Left = 0
    Top = 0
    Width = 673
    Height = 154
    Align = alClient
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitWidth = 672
    ExplicitHeight = 153
    object Label28: TLabel
      Left = 551
      Top = 56
      Width = 39
      Height = 19
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label37: TLabel
      Left = 11
      Top = 56
      Width = 77
      Height = 19
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 11
      Top = 6
      Width = 145
      Height = 19
      Caption = 'C'#243'dcódcódcódigo do produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_Avl_Subtotal: TPanel
      Left = 549
      Top = 78
      Width = 113
      Height = 25
      Alignment = taRightJustify
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = '0,00'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 4
    end
    object E_Avl_Descricao: TEdit
      Left = 7
      Top = 78
      Width = 536
      Height = 25
      TabStop = False
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
      CharCase = ecUpperCase
      Color = clBlack
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object Sb_Confirma: TButton
      Left = 416
      Top = 114
      Width = 122
      Height = 29
      Caption = '&Confirma - F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Sb_ConfirmaClick
    end
    object Sb_Cancela: TButton
      Left = 540
      Top = 114
      Width = 122
      Height = 29
      Caption = 'Cance&la - ESC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Sb_CancelaClick
    end
    object E_BuscaCodigo: TEdit
      Left = 6
      Top = 29
      Width = 232
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = E_BuscaCodigoExit
    end
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 192
  end
  object Qr_PesqProduto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '   PRO_CODIGO,'
      '   PRO_CODIGOFAB,'
      '  PRO_CODIGOBAR,'
      '   PRO_CODIGOFOR,'
      '  PRO_CODIGONCM,'
      '  PRO_ORIGEM,'
      '   PRO_DESCRICAO,'
      '   EST_QTDE,'
      '   PRO_VL_CUSTO,'
      '   MED_ABREVIATURA,'
      '   PRC_VL_VDA,'
      '   PRC_AQ_COM,'
      '   PRO_CAMPANHA'
      'FROM TB_PRODUTO tb_produto'
      '   INNER JOIN TB_PRECO tb_preco '
      '   ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO) '
      '   INNER JOIN TB_ESTOQUE tb_estoque'
      '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO)'
      '  INNER JOIN tb_medida tb_medida'
      '   ON (tb_medida.med_codigo = tb_produto.pro_codmed)'
      ''
      'WHERE (PRO_CODIGO IS NOT NULL) AND (PRC_CODTPR =:PRC_CODTPR)')
    Left = 272
    Top = 25
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRC_CODTPR'
        ParamType = ptUnknown
      end>
  end
end
