object Fr_Imp_CtasReceber: TFr_Imp_CtasReceber
  Left = 410
  Top = 166
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Contas a Receber'
  ClientHeight = 379
  ClientWidth = 637
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
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 637
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      637
      50)
    object chbx_Empresas: TCheckBox
      Left = 7
      Top = 8
      Width = 165
      Height = 14
      Caption = 'Selecionar todas as Empresas'
      TabOrder = 0
      OnClick = chbx_EmpresasClick
    end
    object Dblcb_Mha_Empresa: TDBLookupComboBox
      Left = 5
      Top = 24
      Width = 625
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 209
    Top = 50
    Width = 428
    Height = 264
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label2: TLabel
      Left = 7
      Top = 123
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
    object E_Data_Ini: TDateTimePicker
      Left = 237
      Top = 99
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Data_Fim: TDateTimePicker
      Left = 332
      Top = 99
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object ChBx_Periodo: TCheckBox
      Left = 238
      Top = 84
      Width = 178
      Height = 12
      Caption = 'Data Inicial         Data Final'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 6
      OnClick = ChBx_PeriodoClick
    end
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 70
      Top = 138
      Width = 352
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
      TabOrder = 5
      OnKeyDown = DBLCB_EmpresaKeyDown
    end
    object ChBx_Nome: TCheckBox
      Left = 71
      Top = 121
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
      TabOrder = 7
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 198
      Top = 121
      Width = 121
      Height = 17
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = ChBx_FantasiaClick
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 4
      Top = 138
      Width = 63
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
      OnExit = E_BuscaCodigoExit
    end
    object RG_Tipo: TRadioGroup
      Left = 2
      Top = 2
      Width = 424
      Height = 40
      Align = alTop
      Caption = '[ Tipo de Documento ]'
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'A Vencer'
        'Vencidos'
        'Todos')
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object RG_Conta: TRadioGroup
      Left = 2
      Top = 42
      Width = 424
      Height = 40
      Align = alTop
      Caption = '[ Tipo Conta ]'
      Columns = 4
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 3
      Items.Strings = (
        'Normais'
        'Destinadas'
        'Descontadas'
        'Todas ')
      ParentFont = False
      TabOrder = 1
    end
    object GroupBox2: TGroupBox
      Left = 5
      Top = 198
      Width = 418
      Height = 61
      Caption = 'Nome do Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      object Rb_Vend_Cliente: TRadioButton
        Left = 5
        Top = 15
        Width = 114
        Height = 17
        Caption = 'Cadastro do Cliente'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object Rb_Vend_Pedido: TRadioButton
        Left = 141
        Top = 16
        Width = 131
        Height = 17
        Caption = 'Registrado no Pedido'
        TabOrder = 1
      end
      object DBLCB_Vendedor: TDBLookupComboBox
        Left = 4
        Top = 33
        Width = 408
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
        TabOrder = 2
        TabStop = False
      end
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 2
      Top = 160
      Width = 194
      Height = 42
      TabOrder = 10
      ExplicitLeft = 2
      ExplicitTop = 160
      ExplicitWidth = 194
      ExplicitHeight = 42
      inherited Lb_FormaPagamento: TLabel
        Width = 188
      end
      inherited pnl_Forma: TPanel
        Width = 194
        Height = 28
        ExplicitWidth = 194
        ExplicitHeight = 28
        inherited SB_FormaPag: TSpeedButton
          Left = 168
          Height = 25
          ExplicitLeft = 171
          ExplicitHeight = 28
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 159
          ExplicitWidth = 159
        end
      end
    end
  end
  object TPanel
    Left = 0
    Top = 314
    Width = 637
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      637
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 552
      Top = 6
      Width = 80
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
      ExplicitLeft = 342
    end
    object SB_Imprimir: TSpeedButton
      Left = 472
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 262
    end
    object Sb_Exportar: TSpeedButton
      Left = 394
      Top = 6
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 50
    Width = 209
    Height = 264
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object Label4: TLabel
      Left = 4
      Top = 3
      Width = 80
      Height = 14
      Caption = 'Tipo de Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LBx_TipoRelatorio: TListBox
      Left = 2
      Top = 19
      Width = 205
      Height = 243
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        'VENCIMENTO'
        'CLIENTE'
        'PRODUTOS'
        'PRODUTOS RESUMIDO'
        'PRANCHETA'
        'FORMA PAGTO'
        'RESUMO SALDO'
        'FORMA DE PAGAMENTO RESUMIDO')
      TabOrder = 0
      OnClick = LBx_TipoRelatorioClick
    end
  end
  object Ds_Cliente: TDataSource
    DataSet = DM.Qr_Empresas
    Left = 16
    Top = 320
  end
  object Qr_Empresa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_EmpresaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME'
      'FROM TB_EMPRESA'
      '  WHERE (EMP_TIPO = :EMP_TIPO)'
      'ORDER BY EMP_FANTASIA')
    Left = 112
    Top = 323
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_TIPO'
        ParamType = ptUnknown
      end>
  end
end
