inherited RegCtrlCheque: TRegCtrlCheque
  Caption = 'RegCtrlCheque'
  ClientHeight = 575
  ClientWidth = 734
  ExplicitWidth = 740
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 511
    Width = 734
    ExplicitTop = 511
    ExplicitWidth = 734
    inherited SB_Inserir: TSpeedButton
      Left = 25
      ExplicitLeft = 25
    end
    inherited SB_Alterar: TSpeedButton
      Left = 129
      ExplicitLeft = 129
    end
    inherited SB_Excluir: TSpeedButton
      Left = 233
      ExplicitLeft = 233
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 441
      ExplicitLeft = 441
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 627
      ExplicitLeft = 627
    end
    inherited SB_Gravar: TSpeedButton
      Left = 337
      ExplicitLeft = 337
    end
    object SB_Baixar: TSpeedButton
      Left = 544
      Top = 2
      Width = 82
      Height = 60
      Align = alRight
      Caption = 'Baixar - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_BaixarClick
      ExplicitLeft = 681
      ExplicitTop = -6
    end
  end
  inherited pnl_fundo: TPanel
    Width = 734
    Height = 89
    Align = alTop
    ExplicitWidth = 734
    ExplicitHeight = 89
    object L_Emitente: TLabel
      Left = 289
      Top = 5
      Width = 41
      Height = 13
      Caption = 'Emitente'
      Color = clBtnFace
      FocusControl = E_Emitente
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_banco: TLabel
      Left = 8
      Top = 46
      Width = 31
      Height = 13
      Caption = 'Banco'
      Color = clBtnFace
      FocusControl = E_Banco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Agencia: TLabel
      Left = 49
      Top = 46
      Width = 39
      Height = 13
      Caption = 'Ag'#234'ncia'
      Color = clBtnFace
      FocusControl = E_Agencia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Cheque: TLabel
      Left = 191
      Top = 46
      Width = 37
      Height = 13
      Caption = 'Cheque'
      Color = clBtnFace
      FocusControl = E_Cheque
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Valor: TLabel
      Left = 251
      Top = 46
      Width = 24
      Height = 13
      Caption = 'Valor'
      Color = clBtnFace
      FocusControl = E_Valor
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Vl_Amor: TLabel
      Left = 377
      Top = 46
      Width = 79
      Height = 13
      Caption = 'Valor Amortizado'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Quitado: TLabel
      Left = 463
      Top = 47
      Width = 75
      Height = 13
      Caption = #218'ltima Quita'#231#227'o'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Codigo: TLabel
      Left = 8
      Top = 5
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      Color = clBtnFace
      FocusControl = E_Codigo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_PreDatado: TLabel
      Left = 205
      Top = 6
      Width = 54
      Height = 13
      Caption = 'Pr'#233' Datado'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Devolvido: TLabel
      Left = 326
      Top = 44
      Width = 47
      Height = 14
      Caption = 'Devolvido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Qt_Rec: TLabel
      Left = 543
      Top = 47
      Width = 73
      Height = 13
      Caption = 'V'#237'nculo Origem'
      Color = clBtnFace
      FocusControl = E_Qt_Rec
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Qt_Pag: TLabel
      Left = 633
      Top = 47
      Width = 76
      Height = 13
      Caption = 'V'#237'nculo Destino'
      Color = clBtnFace
      FocusControl = E_Qt_Pag
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_Conta: TLabel
      Left = 99
      Top = 46
      Width = 71
      Height = 13
      Caption = 'Conta Corrente'
      Color = clBtnFace
      FocusControl = E_Agencia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object E_Emitente: TEdit
      Left = 289
      Top = 21
      Width = 431
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object E_Banco: TEdit
      Left = 8
      Top = 61
      Width = 36
      Height = 21
      TabOrder = 1
    end
    object E_Agencia: TEdit
      Left = 46
      Top = 61
      Width = 48
      Height = 21
      TabOrder = 2
    end
    object E_Cheque: TEdit
      Left = 188
      Top = 61
      Width = 59
      Height = 21
      TabOrder = 3
    end
    object E_Valor: TEdit
      Left = 249
      Top = 61
      Width = 73
      Height = 21
      TabOrder = 4
    end
    object E_Codigo: TEdit
      Left = 8
      Top = 21
      Width = 52
      Height = 21
      Color = clMenu
      ReadOnly = True
      TabOrder = 5
    end
    object Rg_TipoCheque: TRadioGroup
      Left = 64
      Top = 3
      Width = 135
      Height = 37
      Caption = 'Tipo Cheque'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Pr'#243'prio'
        'Terceiro')
      ParentFont = False
      TabOrder = 6
    end
    object E_Vl_Amor: TEdit
      Left = 377
      Top = 61
      Width = 84
      Height = 21
      TabStop = False
      DragMode = dmAutomatic
      MaxLength = 10
      TabOrder = 7
    end
    object E_Qt_Rec: TEdit
      Left = 543
      Top = 61
      Width = 87
      Height = 21
      MaxLength = 10
      TabOrder = 8
    end
    object E_Qt_Pag: TEdit
      Left = 632
      Top = 61
      Width = 89
      Height = 21
      MaxLength = 10
      TabOrder = 9
    end
    object E_Quitado: TMaskEdit
      Left = 464
      Top = 61
      Width = 73
      Height = 21
      TabStop = False
      CharCase = ecUpperCase
      DragMode = dmAutomatic
      EditMask = '!##/##/####;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 10
      Text = '  /  /    '
    end
    object E_PreDatado: TDateTimePicker
      Left = 202
      Top = 21
      Width = 85
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 11
    end
    object E_Devolvido: TEdit
      Left = 325
      Top = 61
      Width = 49
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 12
    end
    object E_Conta: TEdit
      Left = 96
      Top = 61
      Width = 90
      Height = 21
      TabOrder = 13
    end
  end
  object DBG_ChqOrigem: TDBGrid [2]
    Left = 0
    Top = 89
    Width = 734
    Height = 160
    Align = alTop
    Color = clMoneyGreen
    DataSource = Ds_Origem
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBG_ChqOrigemDblClick
    Columns = <
      item
        Expanded = False
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'EMP_NOME'
        Title.Caption = 'Cliente'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 383
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_NUMERO'
        Title.Caption = 'Ordem n'#186
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_NR_PARCELA'
        Title.Caption = 'Parcela n'#186
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFL_NUMERO'
        Title.Caption = 'Nota Fiscal'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 95
        Visible = True
      end>
  end
  object Dbg_ChqDestino: TDBGrid [3]
    Left = 0
    Top = 249
    Width = 734
    Height = 262
    Align = alClient
    Color = clMoneyGreen
    DataSource = Ds_Destino
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = Dbg_ChqDestinoDblClick
    Columns = <
      item
        Expanded = False
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'EMP_NOME'
        Title.Caption = 'Fornecedor'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 381
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_NUMERO'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Parcela'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_NR_PARCELA'
        Title.Alignment = taCenter
        Title.Caption = 'Pagamento'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 86
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NFL_NUMERO'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Nota'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 92
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    inherited arefas1: TMenuItem
      object VincularOrigemdoCheque1: TMenuItem [0]
        Caption = 'Vincular Origem do Cheque'
        OnClick = VincularOrigemdoCheque1Click
      end
      object VincularDestinodoCheque1: TMenuItem [1]
        Caption = 'Vincular Destino do Cheque'
        OnClick = VincularDestinodoCheque1Click
      end
      object LanarValordoChequenoCaixa1: TMenuItem [2]
        Caption = 'Lan'#231'ar Valor do Cheque no Caixa'
        OnClick = LanarValordoChequenoCaixa1Click
      end
    end
  end
  object Qr_Origem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT '
      '  PED_NUMERO,'
      '  NFL_NUMERO,  '
      '  FIN_NR_PARCELA,'
      '  EMP_NOME,'
      '  EMP_CODIGO,'
      '  PED_CODIGO'
      'FROM TB_CHEQUES tb_cheques'
      '    INNER JOIN TB_FINANCEIRO tb_financeiro'
      '    ON (tb_financeiro.FIN_CODQTC = tb_cheques.CHQ_QT_REC)'
      '   INNER JOIN TB_EMPRESA Tb_empresa'
      '   ON  (Tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)  '
      '   LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      '   ON  (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '
      '   LEFT OUTER JOIN TB_NOTA_FISCAL tb_nota_fiscal'
      '   ON  (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '
      'WHERE'
      '   (CHQ_QT_REC=:CHQ_QT_REC) and (CHQ_QT_REC > 0)')
    Left = 256
    Top = 272
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CHQ_QT_REC'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_OrigemPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_OrigemNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_NUMERO"'
      Size = 10
    end
    object Qr_OrigemFIN_NR_PARCELA: TIntegerField
      FieldName = 'FIN_NR_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_NR_PARCELA"'
    end
    object Qr_OrigemEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_OrigemEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = '"TB_EMPRESA"."EMP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_OrigemPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object Qr_Destino: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT '
      '  FIN_NUMERO,'
      '  NFL_NUMERO,  '
      '  FIN_NR_PARCELA,'
      '  EMP_NOME,'
      '  EMP_CODIGO'
      'FROM TB_CHEQUES tb_cheques'
      '   INNER JOIN TB_EMPRESA Tb_empresa'
      '   ON  (Tb_empresa.EMP_CODIGO = tb_cheques.CHQ_CODFOR)  '
      '    LEFT OUTER JOIN TB_FINANCEIRO tb_financeiro'
      '    ON (tb_financeiro.FIN_CODQTC = tb_cheques.CHQ_QT_PAG)'
      '   LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      '   ON  (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '
      '   LEFT OUTER JOIN TB_NOTA_FISCAL tb_nota_fiscal'
      '   ON  (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '
      'WHERE'
      '   (CHQ_QT_PAG=:CHQ_QT_PAG) and (CHQ_QT_PAG > 0)')
    Left = 312
    Top = 280
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CHQ_QT_PAG'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_DestinoFIN_NUMERO: TStringField
      FieldName = 'FIN_NUMERO'
      Origin = '"TB_FINANCEIRO"."FIN_NUMERO"'
    end
    object Qr_DestinoNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_NUMERO"'
      Size = 10
    end
    object Qr_DestinoFIN_NR_PARCELA: TIntegerField
      FieldName = 'FIN_NR_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_NR_PARCELA"'
    end
    object Qr_DestinoEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_DestinoEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = '"TB_EMPRESA"."EMP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object Ds_Origem: TDataSource
    AutoEdit = False
    DataSet = Qr_Origem
    Left = 256
    Top = 328
  end
  object Ds_Destino: TDataSource
    AutoEdit = False
    DataSet = Qr_Destino
    Left = 312
    Top = 328
  end
end
