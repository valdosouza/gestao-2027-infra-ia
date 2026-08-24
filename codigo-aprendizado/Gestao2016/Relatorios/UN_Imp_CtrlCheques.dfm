object Fr_Imp_CtrlCheques: TFr_Imp_CtrlCheques
  Left = 398
  Top = 157
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio Controle de Cheques'
  ClientHeight = 296
  ClientWidth = 616
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
  object TPanel
    Left = 0
    Top = 231
    Width = 616
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      616
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 531
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
      ExplicitLeft = 343
    end
    object SB_Imprimir: TSpeedButton
      Left = 457
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
      Left = 378
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
    Left = 185
    Top = 50
    Width = 431
    Height = 181
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label6: TLabel
      Left = 6
      Top = 6
      Width = 53
      Height = 13
      Caption = 'Ordena'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 237
      Top = 19
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 332
      Top = 19
      Width = 92
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 238
      Top = 4
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
      TabOrder = 3
      OnClick = ChBx_PeriodoClick
    end
    object CB_Ordena: TComboBox
      Left = 6
      Top = 20
      Width = 229
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'CLIENTE'
      Items.Strings = (
        'CLIENTE'
        'EMITENTE'
        'PR'#201'-DATADO')
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      Left = 3
      Top = 48
      Width = 423
      Height = 43
      TabOrder = 4
      ExplicitLeft = 3
      ExplicitTop = 48
      ExplicitWidth = 423
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 423
        ExplicitWidth = 423
        inherited Label2: TLabel
          Top = 0
          ExplicitTop = 0
        end
        inherited ChBx_Nome: TCheckBox
          Top = 0
          ExplicitTop = 0
        end
        inherited ChBx_Fantasia: TCheckBox
          Top = 0
          ExplicitTop = 0
        end
      end
      inherited pnl_02: TPanel
        Width = 423
        ExplicitWidth = 423
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 395
          ExplicitLeft = 398
          ExplicitTop = 17
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 370
          ExplicitLeft = 373
          ExplicitTop = 17
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          Width = 46
          ExplicitTop = 17
          ExplicitWidth = 46
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Left = 49
          Width = 319
          ExplicitLeft = 52
          ExplicitTop = 17
          ExplicitWidth = 321
        end
      end
    end
  end
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 616
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
      616
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
      Width = 604
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 50
    Width = 185
    Height = 181
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
    object Cb_Tipo: TListBox
      Left = 2
      Top = 19
      Width = 181
      Height = 160
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        'RELA'#199#195'O SIMPLES'
        'RASTREAR ORIGEM'
        'RASTREAR DESTINO'
        'RELA'#199#195'O ENVIO FORNECEDOR'
        'RELA'#199#195'O ENVIO AO BANCO'
        'DISPONIVEL NO CAIXA'
        'DEVOLVIDOS')
      TabOrder = 0
      OnClick = Cb_TipoClick
    end
  end
end
