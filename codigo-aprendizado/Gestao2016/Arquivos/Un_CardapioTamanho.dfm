object Fr_CardapioTamanho: TFr_CardapioTamanho
  Left = 368
  Top = 253
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro de Tamanhos/Medidas'
  ClientHeight = 145
  ClientWidth = 405
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
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 78
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 51
      Height = 14
      Caption = 'Sequ'#234'ncia'
      FocusControl = E_Sequencia
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 63
      Top = 8
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      FocusControl = E_Descricao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 268
      Top = 8
      Width = 57
      Height = 14
      Caption = 'Abreviatura'
      FocusControl = E_Abreviatura
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Proporcao: TLabel
      Left = 341
      Top = 8
      Width = 50
      Height = 14
      Caption = 'Propor'#231#227'o'
      FocusControl = E_Proporcao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Sequencia: TEdit_Setes
      Left = 8
      Top = 24
      Width = 53
      Height = 22
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
      IsCodigo = True
    end
    object E_Descricao: TEdit
      Left = 62
      Top = 24
      Width = 204
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Abreviatura: TEdit
      Left = 268
      Top = 24
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
    end
    object E_Proporcao: TEdit_Setes
      Left = 339
      Top = 24
      Width = 59
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      Text = ''
    end
    object Chbx_Ativo: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 56
      Width = 395
      Height = 17
      Margins.Top = 1
      Align = alBottom
      Caption = 'Ativo'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 78
    Width = 405
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      405
      67)
    object SB_Gravar: TSpeedButton
      Left = 228
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
      Left = 313
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
      ExplicitLeft = 321
    end
  end
end
