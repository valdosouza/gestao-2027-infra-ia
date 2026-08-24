object Fr_Imp_Empresa: TFr_Imp_Empresa
  Left = 374
  Top = 136
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Empresas'
  ClientHeight = 466
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 435
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitTop = 411
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 352
      Top = 5
      Width = 78
      Height = 56
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair - Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 351
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 272
      Top = 5
      Width = 78
      Height = 56
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Imprimir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitTop = 6
    end
    object Sb_Exportar: TSpeedButton
      AlignWithMargins = True
      Left = 192
      Top = 5
      Width = 78
      Height = 56
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Exportar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ExportarClick
      ExplicitTop = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 400
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitHeight = 411
    object Label7: TLabel
      Left = 6
      Top = 159
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 118
      Width = 29
      Height = 14
      Caption = 'Bairro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 83
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 80
      Height = 14
      Caption = 'Tipo de Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 308
      Top = 3
      Width = 62
      Height = 14
      Caption = 'Tipo relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 44
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 198
      Width = 89
      Height = 14
      Caption = 'Ramo de Atividade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 210
      Top = 290
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 305
      Top = 289
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBLCB_Vendedor: TDBLookupComboBox
      Left = 6
      Top = 175
      Width = 420
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'CLB_CODIGO'
      ListField = 'CLB_NOME'
      ListSource = DM_ListaConsultas.DS_ListaVendedor
      ParentFont = False
      TabOrder = 6
      OnKeyDown = DBLCB_VendedorKeyDown
    end
    object DBLCB_Bairro: TDBLookupComboBox
      Left = 5
      Top = 135
      Width = 420
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'END_BAIRRO'
      ListField = 'END_BAIRRO'
      ListSource = Ds_Bairro
      ParentFont = False
      TabOrder = 5
      OnKeyDown = DBLCB_BairroKeyDown
    end
    object DBLCB_CIDADE: TDBLookupComboBox
      Left = 5
      Top = 97
      Width = 420
      Height = 21
      KeyField = 'CDD_DESCRICAO'
      ListField = 'CDD_DESCRICAO'
      ListSource = Ds_Cidade
      TabOrder = 4
      OnKeyDown = DBLCB_CIDADEKeyDown
    end
    object Cb_Empresa: TComboBox
      Left = 7
      Top = 20
      Width = 297
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnExit = Cb_EmpresaExit
      Items.Strings = (
        'Minha Empresa'
        'Clientes'
        'Fornecedores'
        'Transportadoras')
    end
    object Rg_Localidade: TRadioGroup
      Left = 6
      Top = 240
      Width = 193
      Height = 73
      Caption = 'Localiza'#231#227'o do Cliente'
      ItemIndex = 0
      Items.Strings = (
        'Apenas Com endere'#231'o'
        'Apenas Sem endere'#231'o'
        'Tanto Faz')
      TabOrder = 8
    end
    object Cb_Tipo: TComboBox
      Left = 305
      Top = 20
      Width = 117
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      OnChange = Cb_TipoChange
      Items.Strings = (
        '')
    end
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 74
      Top = 60
      Width = 353
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaCliente
      ParentFont = False
      TabOrder = 3
      OnKeyDown = DBLCB_EmpresaKeyDown
    end
    object ChBx_Nome: TCheckBox
      Left = 75
      Top = 42
      Width = 121
      Height = 17
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
      TabOrder = 9
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 199
      Top = 42
      Width = 121
      Height = 17
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = ChBx_FantasiaClick
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 5
      Top = 59
      Width = 63
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnKeyDown = E_BuscaCodigoKeyDown
    end
    object Dblcb_RamoAtividade: TDBLookupComboBox
      Left = 5
      Top = 215
      Width = 420
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'ID'
      ListField = 'DESCRIPTION'
      ListSource = DM_ListaConsultas.Ds_ListaRamoAtividade
      ParentFont = False
      TabOrder = 7
      OnKeyDown = DBLCB_BairroKeyDown
    end
    object Chbx_UltimaCompra: TCheckBox
      Left = 7
      Top = 314
      Width = 191
      Height = 17
      Caption = 'Mostrar a data da '#250'ltima compra'
      TabOrder = 11
      OnClick = Chbx_UltimaCompraClick
    end
    object ChBx_email: TCheckBox
      Left = 6
      Top = 330
      Width = 163
      Height = 17
      Caption = 'Somente Cliente com e-mail'
      TabOrder = 12
    end
    object Pnl_Progresso: TPanel
      Left = 2
      Top = 356
      Width = 431
      Height = 42
      Align = alBottom
      TabOrder = 13
      Visible = False
      ExplicitTop = 367
      object Gg_Progresso: TGauge
        Left = 1
        Top = 1
        Width = 429
        Height = 23
        Align = alTop
        Progress = 0
        ExplicitWidth = 423
      end
      object Lb_Processamento: TLabel
        Left = 3
        Top = 26
        Width = 84
        Height = 14
        Caption = 'Processamento...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object rg_Movimentacao: TRadioGroup
      Left = 205
      Top = 243
      Width = 222
      Height = 46
      Caption = 'Com Movimenta'#231#227'o'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Tanto faz')
      TabOrder = 14
      OnClick = rg_MovimentacaoClick
    end
    object E_Data_Fim: TDateTimePicker
      Left = 302
      Top = 305
      Width = 86
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 15
    end
    object E_Data_Ini: TDateTimePicker
      Left = 210
      Top = 305
      Width = 87
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 16
    end
  end
  object Qr_Bairro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_BairroAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT END_BAIRRO'
      'FROM TB_EMPRESA'
      '   INNER JOIN TB_ENDERECO'
      '   ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO)'
      'WHERE (EMP_TIPO=:EMP_TIPO)'
      'ORDER BY END_BAIRRO')
    Left = 106
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_TIPO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Bairro: TDataSource
    DataSet = Qr_Bairro
    Left = 99
    Top = 184
  end
  object Qr_Cidade: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_CidadeAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT CDD_DESCRICAO '
      'FROM TB_EMPRESA'
      '   INNER JOIN TB_ENDERECO'
      '   ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE'
      '   ON (TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD)'
      'WHERE (EMP_TIPO=:EMP_TIPO)'
      'ORDER BY CDD_DESCRICAO')
    Left = 50
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_TIPO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Cidade: TDataSource
    DataSet = Qr_Cidade
    Left = 43
    Top = 184
  end
end
