object Fr_Lanca_Banco: TFr_Lanca_Banco
  Left = 427
  Top = 110
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Lan'#231'amento Banc'#225'rio'
  ClientHeight = 461
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel8: TPanel
    Left = 0
    Top = 0
    Width = 464
    Height = 396
    Align = alClient
    Alignment = taRightJustify
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label4: TLabel
      Left = 10
      Top = 10
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
    object Label6: TLabel
      Left = 110
      Top = 11
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
    object Label8: TLabel
      Left = 10
      Top = 227
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
      Left = 253
      Top = 348
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
      Left = 356
      Top = 348
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
    object Label3: TLabel
      Left = 9
      Top = 268
      Width = 61
      Height = 14
      Caption = 'Data Original'
      FocusControl = E_Dt_Original
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 123
      Top = 268
      Width = 94
      Height = 14
      Caption = 'N'#250'mero Documento'
      FocusControl = E_Nr_Doc
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Qtty_Caracter: TLabel
      Left = 296
      Top = 228
      Width = 155
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
    object E_Lancamento: TEdit
      Left = 10
      Top = 25
      Width = 97
      Height = 21
      TabStop = False
      Color = clMenu
      DragMode = dmAutomatic
      Enabled = False
      TabOrder = 0
    end
    object E_Historico: TEdit
      Left = 10
      Top = 244
      Width = 443
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
      OnChange = E_HistoricoChange
    end
    object E_Credito: TEdit_Setes
      Left = 248
      Top = 364
      Width = 102
      Height = 21
      Alignment = taRightJustify
      TabOrder = 10
      Text = ''
      OnExit = E_CreditoExit
    end
    object E_Debito: TEdit_Setes
      Left = 353
      Top = 364
      Width = 103
      Height = 21
      Alignment = taRightJustify
      TabOrder = 11
      Text = ''
      OnExit = E_DebitoExit
    end
    object E_Dt_Original: TMaskEdit
      Left = 9
      Top = 283
      Width = 110
      Height = 21
      CharCase = ecUpperCase
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
    end
    object E_Nr_Doc: TEdit
      Left = 123
      Top = 283
      Width = 96
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 7
    end
    object E_Data: TDateTimePicker
      Left = 108
      Top = 25
      Width = 103
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    inline Fm_CentroCusto: TFm_CentroCusto
      Left = 8
      Top = 92
      Width = 450
      Height = 64
      TabOrder = 3
      TabStop = True
      ExplicitLeft = 8
      ExplicitTop = 92
      ExplicitHeight = 64
      inherited Grb_Cta_CentroCusto: TGroupBox
        Height = 64
        ExplicitHeight = 64
      end
    end
    inline Fm_CentroResultado: TFm_CentroResultado
      Left = 8
      Top = 156
      Width = 451
      Height = 66
      TabOrder = 4
      TabStop = True
      ExplicitLeft = 8
      ExplicitTop = 156
      ExplicitHeight = 66
      inherited Grb_Cta_Resultado: TGroupBox
        Height = 66
        ExplicitHeight = 66
      end
    end
    inline Fm_ListaHistoricoBancario: TFm_ListaHistoricoBancario
      Left = 7
      Top = 309
      Width = 450
      Height = 41
      TabOrder = 9
      TabStop = True
      ExplicitLeft = 7
      ExplicitTop = 309
      ExplicitWidth = 450
      inherited Label26: TLabel
        Width = 450
      end
      inherited Sb_Historico: TSpeedButton
        Left = 423
        ExplicitLeft = 423
      end
      inherited DBLCB_Historico: TDBLookupComboBox
        Width = 414
        OnKeyDown = nil
        ExplicitLeft = 3
        ExplicitWidth = 414
      end
    end
    inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
      Left = 7
      Top = 49
      Width = 452
      Height = 41
      TabOrder = 2
      TabStop = True
      ExplicitLeft = 7
      ExplicitTop = 49
      ExplicitWidth = 452
      ExplicitHeight = 41
      inherited L_ContaBancaria: TLabel
        Width = 452
      end
      inherited Sb_ContaBancaria: TSpeedButton
        Left = 425
        Height = 26
        ExplicitLeft = 425
        ExplicitTop = 17
        ExplicitHeight = 26
      end
      inherited DBLCB_ContaBancaria: TDBLookupComboBox
        Width = 416
        ExplicitWidth = 416
      end
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 218
      Top = 266
      Width = 241
      Height = 42
      TabOrder = 8
      TabStop = True
      ExplicitLeft = 218
      ExplicitTop = 266
      ExplicitWidth = 241
      ExplicitHeight = 42
      inherited Lb_FormaPagamento: TLabel
        Width = 235
      end
      inherited pnl_Forma: TPanel
        Width = 241
        Height = 28
        ExplicitWidth = 241
        ExplicitHeight = 28
        inherited SB_FormaPag: TSpeedButton
          Left = 215
          Height = 25
          ExplicitLeft = 214
          ExplicitHeight = 28
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 206
          ExplicitWidth = 206
        end
      end
    end
  end
  object pnl_Bottom: TPanel
    Left = 0
    Top = 396
    Width = 464
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 372
      Top = 5
      Width = 87
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
      Transparent = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 382
      ExplicitTop = 389
      ExplicitHeight = 54
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 283
      Top = 5
      Width = 87
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
      Transparent = False
      OnClick = SB_GravarClick
      ExplicitTop = 389
      ExplicitHeight = 54
    end
  end
  object Ds_ContaBancaria: TDataSource
    Left = 92
    Top = 403
  end
end
