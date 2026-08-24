object Fr_CardapioProduto: TFr_CardapioProduto
  Left = 383
  Top = 259
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Produtos no Card'#225'pio'
  ClientHeight = 175
  ClientWidth = 706
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
  object Panel2: TPanel
    Left = 0
    Top = 108
    Width = 706
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      706
      67)
    object SB_Gravar: TSpeedButton
      Left = 523
      Top = 6
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GravarClick
    end
    object SB_Cancelar: TSpeedButton
      Left = 614
      Top = 6
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 442
    end
  end
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 706
    Height = 108
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label2: TLabel
      Left = 300
      Top = 3
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object Label39: TLabel
      Left = 5
      Top = 4
      Width = 119
      Height = 14
      Caption = 'C'#243'd. Class. Fiscal (NCM)'
      FocusControl = E_CodClasfiscal
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Classificacao: TSpeedButton
      Left = 123
      Top = 18
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_ClassificacaoClick
    end
    object Label43: TLabel
      Left = 147
      Top = 4
      Width = 121
      Height = 14
      Caption = 'C'#243'digo Especificador S.T'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 271
      Top = 18
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object Label1: TLabel
      Left = 8
      Top = 42
      Width = 127
      Height = 14
      Caption = 'Finalidade para Tributa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 297
      Top = 18
      Width = 401
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object E_CodClasfiscal: TEdit_Setes
      Left = 5
      Top = 18
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object E_CESt: TEdit_Setes
      Left = 149
      Top = 18
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
    object Cb_Finalid_Tributa: TComboBox
      Left = 5
      Top = 58
      Width = 135
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = '1 - Revenda'
      Items.Strings = (
        '1 - Revenda'
        '2 - Produ'#231#227'o'
        '3 - Consignado'
        '4 - Industrializa'#231#227'o'
        '5 - Consumo Interno'
        '6 - Presta'#231#227'o de Servi'#231'o'
        '7 - Ativo Imobilizado')
    end
    object RG_SUBTRIB: TRadioGroup
      Left = 146
      Top = 40
      Width = 124
      Height = 40
      Caption = 'Substitui'#231#227'o Tribut'#225'ria'
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'SIM'
        'N'#195#402'O')
      ParentFont = False
      TabOrder = 4
    end
    inline Fm_ListaUnidades: TFm_ListaUnidades
      Left = 271
      Top = 42
      Width = 243
      Height = 38
      TabOrder = 5
      ExplicitLeft = 271
      ExplicitTop = 42
      inherited Label19: TLabel
        Width = 91
        Caption = 'Unidade de Medida'
        ExplicitWidth = 91
      end
      inherited Sb_Medida: TSpeedButton
        OnClick = Fm_ListaUnidadesSb_MedidaClick
      end
      inherited DBLCB_Medida: TDBLookupComboBox
        ListField = 'MED_DESCRICAO'
      end
    end
    object ChBx_ativo: TCheckBox
      Left = 5
      Top = 82
      Width = 297
      Height = 17
      Caption = 'Este Produto encontra-se ativo para qualquer transa'#231#227'o'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 6
    end
  end
end
