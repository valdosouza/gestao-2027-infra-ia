object Fr_Fin_Baixado: TFr_Fin_Baixado
  Left = 343
  Top = 185
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Detalhe Financeiro'
  ClientHeight = 311
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Cartao: TPanel
    Left = 0
    Top = 91
    Width = 462
    Height = 150
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    Visible = False
    object DBG_CARTAO: TDBGrid
      Left = 3
      Top = 4
      Width = 454
      Height = 141
      Color = clMoneyGreen
      DataSource = Ds_Cartao
      Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CTE_DESCRICAO'
          Title.Caption = 'Bandeira'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 243
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BLT_CONTA'
          Title.Caption = 'Conta'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 158
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CRT_AUTORIZA'
          Title.Caption = 'Autoriza'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CRT_IDETIFICA'
          Title.Caption = 'Identifica'#231'ao'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CRT_PARCELA'
          Title.Caption = 'Parcelas'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CRT_VALIDADE'
          Title.Caption = 'Validade'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 85
          Visible = True
        end>
    end
  end
  object Pnl_Boleto: TPanel
    Left = 0
    Top = 91
    Width = 462
    Height = 150
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    Visible = False
    object DBG_Boleto: TDBGrid
      Left = 3
      Top = 4
      Width = 454
      Height = 141
      Color = clMoneyGreen
      DataSource = Ds_Boleto
      Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'BLT_DATA'
          Title.Caption = 'Data'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BLT_NUMERO'
          Title.Caption = 'N'#186' Boleto'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BLT_CONTA'
          Title.Caption = 'Banco Conta'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 155
          Visible = True
        end>
    end
  end
  object Pnl_Cheque: TPanel
    Left = 0
    Top = 91
    Width = 462
    Height = 150
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    Visible = False
    object Label35: TLabel
      Left = 278
      Top = 186
      Width = 88
      Height = 14
      Caption = 'Total em Cheques:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Mostracheque: TDBGrid
      Left = 2
      Top = 3
      Width = 456
      Height = 141
      TabStop = False
      Color = clMoneyGreen
      DataSource = Ds_Cheque
      Options = [dgAlwaysShowEditor, dgTitles, dgColLines, dgTabs, dgMultiSelect]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CHQ_DATA'
          Title.Caption = 'Data'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_EMITENTE'
          Title.Caption = 'Emitente'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 156
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_NR_BANCO'
          Title.Caption = 'Banco'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CHQ_AGENCIA'
          Title.Caption = 'Ag'#234'ncia'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CHQ_NUMERO'
          Title.Caption = 'N'#186' Cheque'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_VALOR'
          Title.Caption = 'Valor'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 89
          Visible = True
        end>
    end
    object E_vl_Cheque: TEdit
      Left = 378
      Top = 182
      Width = 80
      Height = 21
      Color = clBtnFace
      TabOrder = 1
      Text = '0,00'
    end
  end
  object Panel1: TPanel
    Left = -1
    Top = 241
    Width = 463
    Height = 68
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 370
      Top = 5
      Width = 88
      Height = 58
      Align = alRight
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
      ExplicitLeft = 372
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 88
      Height = 58
      Margins.Right = 0
      Align = alLeft
      Caption = 'Cancelar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = -1
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Comissao: TSpeedButton
      AlignWithMargins = True
      Left = 93
      Top = 5
      Width = 88
      Height = 58
      Margins.Left = 0
      Margins.Right = 0
      Align = alLeft
      Caption = 'Comiss'#227'o - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ComissaoClick
      ExplicitLeft = 90
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Cartao: TSpeedButton
      AlignWithMargins = True
      Left = 181
      Top = 5
      Width = 88
      Height = 58
      Margins.Left = 0
      Margins.Right = 0
      Align = alLeft
      Caption = 'Cart'#227'o - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_CartaoClick
      ExplicitLeft = 188
      ExplicitTop = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 1
    Width = 463
    Height = 90
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Enabled = False
    TabOrder = 1
    object Label10: TLabel
      Left = 7
      Top = 4
      Width = 51
      Height = 14
      Caption = 'N'#186' Parcela'
      FocusControl = E_N_Parcela
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 104
      Top = 4
      Width = 25
      Height = 14
      Caption = 'Valor'
      FocusControl = E_Vl_Pagar
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 192
      Top = 4
      Width = 56
      Height = 14
      Caption = 'Vencimento'
      FocusControl = E_Vencimento
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 8
      Top = 44
      Width = 27
      Height = 14
      Caption = 'Juros'
      FocusControl = E_Juros
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 185
      Top = 44
      Width = 46
      Height = 14
      Caption = 'Desconto'
      FocusControl = E_Desconto
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 310
      Top = 45
      Width = 52
      Height = 14
      Caption = 'Valor Pago'
      FocusControl = E_Valor_Pago
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 342
      Top = 5
      Width = 101
      Height = 14
      Caption = 'Forma de Pagamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 268
      Top = 4
      Width = 52
      Height = 14
      Caption = 'Data Pagto'
      FocusControl = E_Data_Pagto
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 97
      Top = 44
      Width = 24
      Height = 14
      Caption = 'Mora'
      FocusControl = E_Juros
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_N_Parcela: TDBEdit
      Left = 7
      Top = 20
      Width = 93
      Height = 21
      DataField = 'FIN_NUMERO'
      DataSource = Ds_Financeiro
      Enabled = False
      TabOrder = 0
    end
    object E_Vl_Pagar: TDBEdit
      Left = 103
      Top = 20
      Width = 85
      Height = 21
      DataField = 'FIN_VL_PARCELA'
      DataSource = Ds_Financeiro
      TabOrder = 1
    end
    object E_Vencimento: TDBEdit
      Left = 191
      Top = 20
      Width = 71
      Height = 21
      DataField = 'FIN_DT_VENCIMENTO'
      DataSource = Ds_Financeiro
      MaxLength = 10
      TabOrder = 2
    end
    object E_Juros: TDBEdit
      Left = 6
      Top = 60
      Width = 85
      Height = 21
      DataField = 'FIN_VL_JUROS'
      DataSource = Ds_Financeiro
      TabOrder = 4
    end
    object E_Desconto: TDBEdit
      Left = 184
      Top = 60
      Width = 122
      Height = 21
      DataField = 'FIN_VL_DESCONTO'
      DataSource = Ds_Financeiro
      TabOrder = 6
    end
    object E_Valor_Pago: TDBEdit
      Left = 308
      Top = 60
      Width = 149
      Height = 21
      DataField = 'FIN_VL_PAGO'
      DataSource = Ds_Financeiro
      TabOrder = 7
    end
    object E_Data_Pagto: TDBEdit
      Left = 266
      Top = 20
      Width = 73
      Height = 21
      DataField = 'FIN_DT_PAGTO'
      DataSource = Ds_Financeiro
      MaxLength = 10
      TabOrder = 3
    end
    object E_Mora: TDBEdit
      Left = 95
      Top = 60
      Width = 85
      Height = 21
      DataField = 'FIN_VL_MORA'
      DataSource = Ds_Financeiro
      TabOrder = 5
    end
    object E_FormaPagto: TDBEdit
      Left = 342
      Top = 20
      Width = 115
      Height = 21
      DataField = 'FPT_DESCRICAO'
      DataSource = Ds_Financeiro
      TabOrder = 8
    end
  end
  object Ds_Financeiro: TDataSource
    DataSet = Qr_Financeiro
    Left = 160
    Top = 175
  end
  object Qr_Cheque: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  CHQ_CODIGO,'
      '  CHQ_EMITENTE,'
      '  CHQ_NR_BANCO,'
      '  CHQ_AGENCIA,'
      '  CHQ_NUMERO,'
      '  CHQ_VALOR,'
      '  CHQ_DATA,'
      '  CHQ_DEVOLVIDO,'
      '  CHQ_DT_QUITACAO,'
      '  CHQ_TIPO,'
      '  CHQ_ESTADO,'
      '  CHQ_RETORNO,'
      '  CHQ_QT_REC'
      'FROM TB_CHEQUES'
      'WHERE (CHQ_QT_PAG=:CHQ_QT_REC)')
    Left = 248
    Top = 127
    ParamData = <
      item
        DataType = ftString
        Name = 'CHQ_QT_REC'
        ParamType = ptUnknown
        Value = '19'
      end>
  end
  object Ds_Cheque: TDataSource
    DataSet = Qr_Cheque
    Left = 248
    Top = 175
  end
  object Qr_Boleto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '    BLT_CODIGO, '
      '    BLT_DATA,'
      '    Tb_Cliente.EMP_NOME,'
      '    BLT_NUMERO, '
      
        '   (tb_banco.EMP_NOME || '#39' / '#39' || CTB_AGENCIA || '#39' / '#39' || CTB_CO' +
        'NTA)  AS BLT_CONTA'
      'FROM  TB_BOLETO Tb_boleto'
      '   INNER JOIN TB_EMPRESA Tb_Cliente'
      '   ON  (Tb_Cliente.EMP_CODIGO = Tb_Boleto.BLT_CODEMP)  '
      '   INNER JOIN TB_CONTABANCARIA Tb_contabancaria'
      '   ON  (Tb_contabancaria.CTB_CODIGO = Tb_Boleto.BLT_CODCTB) '
      '   INNER JOIN TB_EMPRESA tb_banco'
      '   ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO) '
      'WHERE'
      '   BLT_CODQTC =:BLT_CODQTC')
    Left = 288
    Top = 127
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'BLT_CODQTC'
        ParamType = ptUnknown
      end>
  end
  object Ds_Boleto: TDataSource
    DataSet = Qr_Boleto
    Left = 288
    Top = 175
  end
  object Qr_Financeiro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_FinanceiroAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT DISTINCT FIN_CODIGO, FIN_BAIXA, FIN_SITUACAO, EMP_CODIGO,' +
        ' NFL_NUMERO, PED_NUMERO, FIN_NUMERO,  FIN_DT_VENCIMENTO, EMP_FAN' +
        'TASIA,FIN_VL_PARCELA, FIN_CODQTC, FIN_CODFPG, FIN_DT_PAGTO, FPT_' +
        'DESCRICAO, FIN_VL_JUROS, FIN_VL_MORA, FIN_VL_DESCONTO, FIN_VL_PA' +
        'GO, FIN_CODPED'
      'FROM TB_FINANCEIRO tb_financeiro'
      '    LEFT OUTER JOIN TB_NOTA_FISCAL tb_nota_Fiscal'
      '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)'
      '    LEFT OUTER  JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED)'
      '    INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)'
      '    LEFT OUTER  JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON (tb_formapagto.FPT_CODIGO = tb_financeiro.FIN_CODFPG)'
      'WHERE (FIN_CODIGO=:FIN_CODIGO)')
    Left = 160
    Top = 143
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 376
    Top = 122
  end
  object Qr_Cartao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  CRT_CODIGO, '
      '  CTE_DESCRICAO,'
      '  CRT_AUTORIZA,'
      '  CRT_IDETIFICA, CRT_PARCELA, CRT_VALIDADE,'
      
        '  (EMP_NOME || '#39' / '#39' || CTB_AGENCIA || '#39' / '#39' || CTB_CONTA)  AS B' +
        'LT_CONTA'
      'FROM  TB_CARTAO Tb_cartao'
      '   INNER JOIN TB_CARTAOELETRONICO tb_cartaoeletronico'
      '   ON  (tb_cartaoeletronico.CTE_CODIGO = Tb_cartao.CRT_CODCTE)'
      '   INNER JOIN TB_CONTABANCARIA Tb_contabancaria'
      
        '   ON  (Tb_contabancaria.CTB_CODIGO = tb_cartaoeletronico.CTE_CO' +
        'DCTB) '
      '   INNER JOIN TB_EMPRESA tb_banco'
      '   ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO) '
      'WHERE'
      '   CRT_CODQT_REC =:CRT_CODQT_REC')
    Left = 320
    Top = 135
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CRT_CODQT_REC'
        ParamType = ptUnknown
      end>
  end
  object Ds_Cartao: TDataSource
    DataSet = Qr_Cartao
    Left = 320
    Top = 175
  end
end
