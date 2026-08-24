object Fr_Fatura_Srv: TFr_Fatura_Srv
  Left = 398
  Top = 143
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Par'#226'metros de Gera'#231#227'o de Notas Fiscais - Faturamento'
  ClientHeight = 301
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
  PrintScale = poPrintToFit
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object E_M_Nota: TMemo
    Left = 680
    Top = 4
    Width = 465
    Height = 145
    TabOrder = 0
  end
  object E_M_Fisco: TMemo
    Left = 680
    Top = 156
    Width = 465
    Height = 145
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 234
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label9: TLabel
      Left = 11
      Top = 86
      Width = 100
      Height = 14
      Caption = 'Observa'#231#227'o da Nota'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 10
      Top = 3
      Width = 40
      Height = 14
      Caption = 'Emiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 342
      Top = 193
      Width = 90
      Height = 14
      Caption = 'Valor Total da Nota'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 6
      Top = 193
      Width = 97
      Height = 14
      Caption = 'Base C'#225'lculo do ISS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 119
      Top = 193
      Width = 59
      Height = 14
      Caption = 'Valor do ISS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 230
      Top = 193
      Width = 77
      Height = 14
      Caption = 'Valor ISS Retido'
      FocusControl = E_Vl_ISS_retido
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 155
      Top = 50
      Width = 135
      Height = 13
      Caption = '( Em Desenvolvimento )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_Obs: TMemo
      Left = 5
      Top = 100
      Width = 447
      Height = 92
      TabOrder = 0
    end
    object E_Dt_Emissao: TDateTimePicker
      Left = 6
      Top = 19
      Width = 78
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_AutorizacaoNFSe: TCheckBox
      Left = 5
      Top = 49
      Width = 150
      Height = 17
      Caption = 'Solicitar autoriza'#231#227'o NFS-e'
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
    object E_VL_Nota: TPanel
      Left = 341
      Top = 207
      Width = 110
      Height = 22
      Alignment = taRightJustify
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = '0,00'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 3
    end
    object E_Vl_ISS_retido: TEdit_Setes
      Left = 228
      Top = 207
      Width = 110
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '0,00'
    end
    object E_VL_ISS: TEdit_Setes
      Left = 116
      Top = 207
      Width = 110
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '0,00'
    end
    object E_VL_Bs_ISS: TEdit_Setes
      Left = 5
      Top = 207
      Width = 110
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = '0,00'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 234
    Width = 461
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    DesignSize = (
      461
      67)
    object SB_Confirmar: TSpeedButton
      Left = 275
      Top = 7
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
    end
    object SB_Sair_0: TSpeedButton
      Left = 365
      Top = 7
      Width = 89
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Fechar - ESC'
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
  end
  object PrintDialog1: TPrintDialog
    Left = 256
    Top = 8
  end
end
