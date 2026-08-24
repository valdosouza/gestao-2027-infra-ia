object Fr_Imp_Servico: TFr_Imp_Servico
  Left = 340
  Top = 177
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Servi'#231'os'
  ClientHeight = 370
  ClientWidth = 427
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
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 305
    Width = 427
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      427
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 342
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
    end
    object SB_Imprimir: TSpeedButton
      Left = 262
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
    end
    object Sb_Exportar: TSpeedButton
      Left = 184
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
  object Panel1: TPanel
    Left = 0
    Top = 50
    Width = 427
    Height = 255
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      427
      255)
    object Label2: TLabel
      Left = 8
      Top = 86
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
    object Label4: TLabel
      Left = 7
      Top = 46
      Width = 80
      Height = 14
      Caption = 'Tipo do Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Placa: TLabel
      Left = 8
      Top = 186
      Width = 89
      Height = 14
      Caption = 'Placa Inicial e Final'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Frota: TLabel
      Left = 129
      Top = 186
      Width = 88
      Height = 14
      Caption = 'Frota Inicial e Final'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 240
      Top = 60
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Data_Fim: TDateTimePicker
      Left = 333
      Top = 60
      Width = 91
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object ChBx_Periodo: TCheckBox
      Left = 240
      Top = 46
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
      TabOrder = 10
      OnClick = ChBx_PeriodoClick
    end
    object DBLCB_Empresa: TDBLookupComboBox
      Left = 72
      Top = 101
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
      Left = 73
      Top = 84
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
      TabOrder = 11
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 200
      Top = 84
      Width = 121
      Height = 17
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      OnClick = ChBx_FantasiaClick
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 5
      Top = 101
      Width = 65
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
    object GroupBox2: TGroupBox
      Left = 5
      Top = 124
      Width = 418
      Height = 61
      Caption = 'Nome do Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      object Rb_Vend_Clliente: TRadioButton
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
        OnKeyDown = DBLCB_VendedorKeyDown
      end
    end
    object Cb_Tipo: TComboBox
      Left = 5
      Top = 61
      Width = 231
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = Cb_TipoChange
      Items.Strings = (
        'Ve'#237'culos - Normal'
        'Ve'#237'culos - Detalhada'
        'Geral - Normal')
    end
    object RG_Tipo: TRadioGroup
      Left = 2
      Top = 2
      Width = 423
      Height = 41
      Align = alTop
      Caption = 'Sele'#231#227'o de Data'
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 1
      Items.Strings = (
        'Pedido'
        'Nota Fiscal')
      ParentFont = False
      TabOrder = 0
    end
    object E_PlacaINI: TMaskEdit
      Left = 5
      Top = 202
      Width = 56
      Height = 21
      TabOrder = 6
      Text = ''
    end
    object E_PlacaFIM: TMaskEdit
      Left = 66
      Top = 202
      Width = 58
      Height = 21
      TabOrder = 7
      Text = ''
    end
    object E_FrotaINI: TMaskEdit
      Left = 127
      Top = 202
      Width = 53
      Height = 21
      TabOrder = 8
      Text = ''
    end
    object E_FrotaFIM: TMaskEdit
      Left = 183
      Top = 202
      Width = 53
      Height = 21
      TabOrder = 9
      Text = ''
    end
    object chbx_Without_vehicle: TCheckBox
      Left = 6
      Top = 233
      Width = 377
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Mostrar todos os servi'#231'os independente do ve'#237'culo registrado'
      TabOrder = 14
    end
  end
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 427
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
      427
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
      Width = 415
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 312
    Top = 24
  end
end
