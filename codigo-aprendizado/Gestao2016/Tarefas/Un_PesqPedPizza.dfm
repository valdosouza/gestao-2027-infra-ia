object Fr_PesqPedPizza: TFr_PesqPedPizza
  Left = 357
  Top = 165
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Pesquisa Pedidos de Pizza'
  ClientHeight = 413
  ClientWidth = 766
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Dbg_Pesquisa: TDBGrid
    Left = 0
    Top = 50
    Width = 766
    Height = 296
    Align = alClient
    Color = clCream
    Ctl3D = True
    DataSource = Ds_Pesquisa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = Dbg_PesquisaDrawColumnCell
    OnTitleClick = Dbg_PesquisaTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PED_NUMERO'
        Title.Caption = 'Pedido'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_DATA'
        Title.Caption = 'Data'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TM_INICIO'
        Title.Caption = 'Hora'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMP_NOME'
        Title.Caption = 'Nome'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 308
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_VL_PEDIDO'
        Title.Caption = 'Valor Pedido'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_CODWEB'
        Visible = False
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 346
    Width = 766
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitWidth = 690
    object Sb_Confirma: TSpeedButton
      AlignWithMargins = True
      Left = 577
      Top = 5
      Width = 92
      Height = 57
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Confirma - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ConfirmaClick
      ExplicitLeft = 449
      ExplicitTop = 7
      ExplicitHeight = 54
    end
    object Sb_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 485
      Top = 5
      Width = 92
      Height = 57
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Pesquisar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_BuscarClick
      ExplicitLeft = 406
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 669
      Top = 5
      Width = 92
      Height = 57
      Margins.Left = 0
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
      ExplicitLeft = 542
      ExplicitTop = 7
      ExplicitHeight = 54
    end
    object Label1: TLabel
      Left = 4
      Top = 6
      Width = 244
      Height = 16
      Caption = 'Pedidos efetuados pelo App de Delivery'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 50
    Align = alTop
    TabOrder = 2
    object Rg_Situacao: TRadioGroup
      Left = 505
      Top = 1
      Width = 260
      Height = 48
      Align = alRight
      Caption = 'Situa'#231#227'o do Pedido'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Normal'
        'Faturado'
        'Excluido')
      ParentFont = False
      TabOrder = 0
      OnClick = Rg_SituacaoClick
      ExplicitLeft = 506
      ExplicitTop = 12
      ExplicitHeight = 40
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 504
      Height = 48
      Align = alClient
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 58
      ExplicitHeight = 764
      object E_BuscaDescricao: TMaskEdit
        Left = 2
        Top = 16
        Width = 500
        Height = 30
        Align = alClient
        CharCase = ecUpperCase
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 30
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        Text = ''
        ExplicitLeft = 6
        ExplicitTop = 29
        ExplicitWidth = 412
        ExplicitHeight = 21
      end
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Qr_Pesquisa
    Left = 182
    Top = 154
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT r.tm_inicio, p.PED_NUMERO, p.PED_CODIGO, '
      'p.PED_CODEMP,p.PED_DATA , DESCRICAO EMP_NOME, '
      'p.PED_VL_PEDIDO, p.PED_CODWEB'
      'FROM TB_PEDIDO p'
      '  INNER JOIN TB_EMPRESA e'
      '  ON (e.emp_codigo = p.ped_codemp)'
      '  INNER JOIN TB_RESTAURANTE r'
      '  ON (r.TB_PEDIDO_ID = p.PED_CODIGO )')
    Left = 184
    Top = 112
    object Qr_PesquisaPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_PesquisaPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PesquisaPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = '"TB_PEDIDO"."PED_CODEMP"'
      Required = True
    end
    object Qr_PesquisaPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = '"TB_PEDIDO"."PED_DATA"'
      Required = True
    end
    object Qr_PesquisaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_PesquisaPED_VL_PEDIDO: TBCDField
      FieldName = 'PED_VL_PEDIDO'
      Origin = '"TB_PEDIDO"."PED_VL_PEDIDO"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaTM_INICIO: TStringField
      FieldName = 'TM_INICIO'
      Origin = '"TB_RESTAURANTE"."TM_INICIO"'
      Size = 5
    end
    object Qr_PesquisaPED_CODWEB: TIntegerField
      FieldName = 'PED_CODWEB'
      Origin = '"TB_PEDIDO"."PED_CODWEB"'
    end
  end
  object IBT_Transacao: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 180
    Top = 65
  end
end
