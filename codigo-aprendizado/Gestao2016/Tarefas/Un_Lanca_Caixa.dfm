object Fr_Lanca_Caixa: TFr_Lanca_Caixa
  Left = 395
  Top = 205
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Lan'#231'amento de Caixa'
  ClientHeight = 344
  ClientWidth = 461
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
  object Pg_Lanca_Banco: TPageControl
    Left = 0
    Top = 0
    Width = 461
    Height = 279
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
  end
  object Panel8: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 279
    Align = alClient
    Alignment = taRightJustify
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label4: TLabel
      Left = 11
      Top = 6
      Width = 74
      Height = 14
      Caption = 'Lan'#231'amento N'#186
      FocusControl = E_Lancamento
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 11
      Top = 186
      Width = 104
      Height = 14
      Caption = 'Hist'#243'rico Lan'#231'amento'
      FocusControl = E_Historico
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 250
      Top = 227
      Width = 37
      Height = 14
      Caption = 'Cr'#233'dito:'
      FocusControl = E_Credito
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 353
      Top = 227
      Width = 33
      Height = 14
      Caption = 'D'#233'bito:'
      FocusControl = E_Debito
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 112
      Top = 6
      Width = 84
      Height = 14
      Caption = 'Data Lan'#231'amento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Qtty_Caracter: TLabel
      Left = 312
      Top = 183
      Width = 140
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 caracter'
      FocusControl = E_Historico
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Lancamento: TEdit_Setes
      Left = 9
      Top = 20
      Width = 97
      Height = 21
      TabStop = False
      Color = clBtnFace
      DragMode = dmAutomatic
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object E_Historico: TEdit
      Left = 11
      Top = 203
      Width = 441
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = E_HistoricoChange
    end
    object E_Credito: TEdit_Setes
      Left = 245
      Top = 243
      Width = 102
      Height = 21
      Alignment = taRightJustify
      TabOrder = 2
      Text = ''
      OnExit = E_CreditoExit
    end
    object E_Debito: TEdit_Setes
      Left = 350
      Top = 243
      Width = 102
      Height = 21
      Alignment = taRightJustify
      TabOrder = 3
      Text = ''
      OnExit = E_DebitoExit
    end
    object E_Dt_Caixa: TMaskEdit
      Left = 110
      Top = 20
      Width = 88
      Height = 21
      Alignment = taCenter
      Color = clBtnFace
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 4
      Text = '  /  /    '
    end
    inline Fm_CentroCusto: TFm_CentroCusto
      Left = 8
      Top = 48
      Width = 450
      Height = 71
      TabOrder = 5
      TabStop = True
      ExplicitLeft = 8
      ExplicitTop = 48
      ExplicitHeight = 71
      inherited Grb_Cta_CentroCusto: TGroupBox
        Height = 71
        ExplicitHeight = 71
      end
    end
    inline Fm_CentroResultado: TFm_CentroResultado
      Left = 7
      Top = 113
      Width = 451
      Height = 63
      TabOrder = 6
      TabStop = True
      ExplicitLeft = 7
      ExplicitTop = 113
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 8
      Top = 225
      Width = 236
      Height = 42
      TabOrder = 7
      ExplicitLeft = 8
      ExplicitTop = 225
      ExplicitWidth = 236
      ExplicitHeight = 42
      inherited Lb_FormaPagamento: TLabel
        Width = 230
      end
      inherited pnl_Forma: TPanel
        Width = 236
        Height = 28
        ExplicitWidth = 236
        ExplicitHeight = 28
        inherited SB_FormaPag: TSpeedButton
          Left = 210
          Height = 25
          ExplicitLeft = 210
          ExplicitHeight = 28
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 201
          ExplicitWidth = 201
        end
      end
    end
  end
  object pnl_bottom: TPanel
    Left = 0
    Top = 279
    Width = 461
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object SB_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 377
      Top = 5
      Width = 79
      Height = 55
      Margins.Left = 1
      Align = alRight
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
      ExplicitLeft = 391
      ExplicitTop = 308
      ExplicitHeight = 54
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 296
      Top = 5
      Width = 79
      Height = 55
      Margins.Right = 1
      Align = alRight
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
      ExplicitTop = 6
    end
  end
end
