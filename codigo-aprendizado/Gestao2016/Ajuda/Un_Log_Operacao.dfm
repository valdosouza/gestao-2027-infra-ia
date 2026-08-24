object Fr_Log_Operacao: TFr_Log_Operacao
  Left = 255
  Top = 62
  Anchors = [akTop, akBottom]
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Log de opera'#231#245'es no sistema'
  ClientHeight = 604
  ClientWidth = 851
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 0
    Top = 535
    Width = 851
    Height = 69
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      851
      69)
    object SB_Sair_0: TSpeedButton
      Left = 757
      Top = 10
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
    end
    object SB_Buscar: TSpeedButton
      Left = 668
      Top = 10
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
    object Sb_Exc_Todos: TSpeedButton
      Left = 547
      Top = 10
      Width = 120
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Excluir Todos'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Visible = False
      OnClick = Sb_Exc_TodosClick
    end
    object Sb_Exc_Visualizados: TSpeedButton
      Left = 425
      Top = 10
      Width = 120
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Excluir Visualizados'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Visible = False
      OnClick = Sb_Exc_VisualizadosClick
    end
  end
  object DBG_Pesquisa: TDBGrid
    Left = 0
    Top = 147
    Width = 851
    Height = 388
    Align = alClient
    Color = clCream
    DataSource = Ds_Produtos
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBG_PesquisaTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'LOG_TIMESTAMP'
        Title.Caption = 'Data e Hora'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOG_INTERFACE'
        Title.Caption = 'Nome da Tela'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOG_OPERACAO'
        Title.Caption = 'Opera'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 204
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOG_DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USU_LOGIN'
        Title.Caption = 'Usu'#225'rio'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end>
  end
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 851
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      851
      50)
    object chbx_Empresas: TCheckBox
      Left = 7
      Top = 8
      Width = 165
      Height = 14
      Caption = 'Selecionar todas as Empresas'
      TabOrder = 0
    end
    object Dblcb_Mha_Empresa: TDBLookupComboBox
      Left = 5
      Top = 24
      Width = 839
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 50
    Width = 851
    Height = 97
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      851
      97)
    object Label1: TLabel
      Left = 167
      Top = 18
      Width = 62
      Height = 14
      Anchors = [akLeft, akBottom]
      Caption = 'Nome da tela'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 430
      Top = 18
      Width = 48
      Height = 14
      Anchors = [akLeft, akBottom]
      Caption = 'Opera'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 694
      Top = 18
      Width = 37
      Height = 14
      Anchors = [akLeft, akBottom]
      Caption = 'Usu'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 6
      Top = 55
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object E_Data_Ini: TDateTimePicker
      Left = 4
      Top = 33
      Width = 80
      Height = 22
      Anchors = [akLeft, akBottom]
      Date = 39580.000000000000000000
      Time = 39580.000000000000000000
      Enabled = False
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 85
      Top = 33
      Width = 80
      Height = 22
      Anchors = [akLeft, akBottom]
      Date = 39580.999988425930000000
      Time = 39580.999988425930000000
      Enabled = False
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 4
      Top = 18
      Width = 128
      Height = 12
      TabStop = False
      Anchors = [akLeft, akBottom]
      Caption = 'Data Inicial   Data Final'
      TabOrder = 0
      OnClick = ChBx_PeriodoClick
    end
    object Cb_Busca_Interface: TComboBox
      Left = 166
      Top = 33
      Width = 262
      Height = 22
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      TabOrder = 3
      OnKeyDown = Cb_Busca_InterfaceKeyDown
    end
    object Cb_Busca_Operacao: TComboBox
      Left = 429
      Top = 33
      Width = 262
      Height = 22
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      TabOrder = 4
      OnKeyDown = Cb_Busca_OperacaoKeyDown
    end
    object Cb_Busca_Usuario: TComboBox
      Left = 693
      Top = 33
      Width = 151
      Height = 22
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      CharCase = ecUpperCase
      TabOrder = 5
      OnKeyDown = Cb_Busca_UsuarioKeyDown
    end
    object e_buscaDescricao: TEdit
      Left = 5
      Top = 69
      Width = 424
      Height = 22
      TabOrder = 6
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
      
        'select LOG_TIMESTAMP, LOG_INTERFACE, LOG_OPERACAO, LOG_DESCRICAO' +
        ', USU_LOGIN'
      'from tb_log_operacao'
      '   INNER JOIN tb_usuario'
      '   ON (tb_usuario.USU_CODIGO = tb_log_operacao.log_codusu)')
    Left = 696
    Top = 72
  end
  object Ds_Cliente: TDataSource
    Left = 744
    Top = 104
  end
  object Ds_Produtos: TDataSource
    DataSet = Qr_Pesquisa
    Left = 696
    Top = 144
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 784
    Top = 72
  end
end
