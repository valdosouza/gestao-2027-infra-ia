object Fr_Clta_Csto: TFr_Clta_Csto
  Left = 270
  Top = 93
  Anchors = [akTop, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Consulta Consertos'
  ClientHeight = 572
  ClientWidth = 836
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Cb_Situacao: TComboBox
    Left = 448
    Top = 304
    Width = 145
    Height = 21
    TabOrder = 0
    OnChange = Cb_SituacaoChange
    OnExit = Cb_SituacaoExit
    Items.Strings = (
      'SITUA'#199#195'O 1'
      'SITUA'#199#195'O 2'
      'SITUA'#199#195'O 3')
  end
  object StrGrd_Conserto: TStringGrid
    Left = 0
    Top = 196
    Width = 836
    Height = 308
    Align = alClient
    Color = clCream
    ColCount = 11
    DefaultColWidth = 40
    DefaultRowHeight = 18
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goRowSelect]
    ParentFont = False
    PopupMenu = PopMenu
    TabOrder = 1
    OnDblClick = StrGrd_ConsertoDblClick
    ColWidths = (
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40)
    RowHeights = (
      18
      18)
  end
  object Panel1: TPanel
    Left = 0
    Top = 504
    Width = 836
    Height = 68
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object SB_Visualizar: TSpeedButton
      AlignWithMargins = True
      Left = 673
      Top = 3
      Width = 80
      Height = 62
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Visualizar - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 12
      OnClick = SB_VisualizarClick
      ExplicitTop = 4
    end
    object Sb_Inserir: TSpeedButton
      AlignWithMargins = True
      Left = 513
      Top = 3
      Width = 80
      Height = 62
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Inserir - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 12
      OnClick = Sb_InserirClick
      ExplicitTop = 4
    end
    object SB_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 593
      Top = 3
      Width = 80
      Height = 62
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Buscar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_BuscarClick
      ExplicitLeft = 588
      ExplicitTop = 5
      ExplicitHeight = 56
    end
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 753
      Top = 3
      Width = 80
      Height = 62
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 751
      ExplicitTop = 4
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 57
    Width = 836
    Height = 139
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label4: TLabel
      Left = 10
      Top = 55
      Width = 90
      Height = 14
      Caption = 'IR Para Or'#231'amento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 133
      Top = 58
      Width = 126
      Height = 14
      Caption = 'Aparelho / Marca / Modelo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 645
      Top = 58
      Width = 65
      Height = 14
      Caption = 'N'#250'mero S'#233'rie'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 188
      Top = 15
      Width = 64
      Height = 14
      Caption = 'C'#243'd Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Pesq_Cliente: TSpeedButton
      Left = 807
      Top = 32
      Width = 23
      Height = 22
      Glyph.Data = {
        E6010000424DE60100000000000036000000280000000C0000000C0000000100
        180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF285A9F626F8DFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2963AC7EE3FA18
        79DEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF296CBA7FE3FA
        177FE4C9D5E9FFFFFFFFFFFFFFFFFFF7F6F7E6E5E6FFFFFFFFFFFF447DC57EE3
        FA177FE4C9D8ECFFFFFFFFFFFFEFEEEF66574AFBDCACFFEECDC0C8A6483C489C
        A1B62372CBC9DBF1FFFFFFFFFFFFFFFFFF8D734FF5BC91FFD8B6FFEED2FFF9E0
        FFFEF0463C49FFFFFFFFFFFFFFFFFFFFFFFF8F8792E1A87DDDA479FFD7B5FFED
        D4FFF7E1FFFDEDCCD6C0FFFFFFFFFFFFFFFFFFFFFFFF7C6A78DAA176DAA176FD
        C498FFEFE0FFEED6FFF4DAFFF2CFD6D5D8FFFFFFFFFFFFFFFFFF827788D0976C
        FFE1CBFFF9F5FFCBA3FFE4CBFFE7CDFFECC2F1F1F2FFFFFFFFFFFFFFFFFFDFDC
        E0BF8656FCC398FFE5D2FBC297ECB388FFC99E8C8171FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF9C929FBF8857D69D72DBA277EAB186AB976FE9E8EBFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE4E0E49D91A0A1939DA69FABFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      OnClick = Sb_Pesq_ClienteClick
    end
    object E_Orcamento: TMaskEdit
      Left = 8
      Top = 71
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
      OnExit = E_OrcamentoExit
    end
    object E_ApMarMod: TMaskEdit
      Left = 131
      Top = 71
      Width = 510
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = ''
    end
    object E_Serie: TMaskEdit
      Left = 643
      Top = 71
      Width = 186
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = ''
    end
    object E_Data_Ini: TDateTimePicker
      Left = 9
      Top = 32
      Width = 85
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 94
      Top = 32
      Width = 88
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 9
      Top = 15
      Width = 152
      Height = 16
      Caption = 'Data Inicial      Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = ChBx_PeriodoClick
    end
    object E_Busca_Cd_Empresa: TMaskEdit
      Left = 185
      Top = 32
      Width = 98
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnExit = E_Busca_Cd_EmpresaExit
    end
    object ChBx_Nome: TCheckBox
      Left = 285
      Top = 15
      Width = 121
      Height = 17
      TabStop = False
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 8
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 412
      Top = 15
      Width = 121
      Height = 17
      TabStop = False
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = ChBx_FantasiaClick
    end
    object Cb_Busca_Empresa: TComboBox
      Left = 286
      Top = 32
      Width = 519
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 3
    end
    inline Fm_ListaSituacao: TFm_ListaSituacao
      Left = 7
      Top = 94
      Width = 357
      Height = 39
      TabOrder = 10
      ExplicitLeft = 7
      ExplicitTop = 94
      inherited Sb_Cadastro: TSpeedButton
        OnClick = nil
      end
      inherited DBLCB_Situacao: TDBLookupComboBox
        Height = 22
        OnKeyDown = Fm_ListaSituacaoDBLCB_SituacaoKeyDown
        ExplicitHeight = 22
      end
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 836
    Height = 57
    Align = alTop
    TabOrder = 4
    ExplicitWidth = 836
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 836
      ExplicitWidth = 836
      inherited Sb_open: TSpeedButton
        Left = 812
        ExplicitLeft = 812
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 812
        ExplicitWidth = 812
      end
    end
    inherited pnl_top: TPanel
      Width = 836
    end
  end
  object Ds_Vendas: TDataSource
    DataSet = Qr_Conserto
    Left = 182
    Top = 166
  end
  object Qr_Conserto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ConsertoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  CST_CODIGO, '
      '   CTC_CODIGO,'
      '  CST_CODSIT, '
      '   CST_CODPED,'
      '  NFL_CODIGO,'
      '   CTC_NUMERO,'
      '   PED_NUMERO,'
      '   CTC_DATA,'
      '   PED_DATA,'
      '  PED_CODEMP,'
      '  CTC_CODEMP,'
      '   EMP_NOME,'
      '   EMP_FANTASIA,'
      '  CTC_FANTASIA,'
      '  END_FONE,'
      '  END_CELULAR,'
      '  SIT_DESCRICAO,'
      '  CTC_VL_COTACAO,'
      '  PED_VL_PEDIDO,'
      '  CST_APARELHO'
      'FROM TB_PEDIDO Tb_pedido'
      '   INNER JOIN TB_COTACAO tb_cotacao'
      '   ON  (tb_cotacao.CTC_CODPED = Tb_pedido.PED_CODIGO)  '
      '   LEFT OUTER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '
      '   ON  (tb_nota_Fiscal.NFL_CODPED = tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_CONSERTO tb_conserto'
      '  ON (tb_conserto.CST_CODPED = tb_pedido.PED_CODIGO) '
      '   LEFT OUTER JOIN TB_EMPRESA Tb_empresa'
      '   ON  (Tb_empresa.EMP_CODIGO = Tb_cotacao.CTC_CODEMP)  '
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_SITUACAO tb_situacao'
      '   ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT)'
      '   ')
    Left = 184
    Top = 136
  end
  object Qr_Clientes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT EMP_CODIGO, EMP_FANTASIA, EMP_NOME'
      'FROM TB_EMPRESA'
      'ORDER BY EMP_FANTASIA')
    Left = 223
    Top = 136
  end
  object PopMenu: TPopupMenu
    Left = 368
    Top = 232
    object NovoConserto1: TMenuItem
      Caption = 'Novo Conserto'
    end
  end
  object MainMenu: TMainMenu
    Left = 584
    Top = 280
    object arefas1: TMenuItem
      Caption = 'Tarefas'
      object Configuraes1: TMenuItem
        Caption = 'Configura'#231#245'es'
        OnClick = Configuraes1Click
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
end
