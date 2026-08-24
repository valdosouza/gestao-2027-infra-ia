object Fr_ConectaBanco: TFr_ConectaBanco
  Left = 449
  Top = 196
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Conex'#227'o ao Banco de Dados'
  ClientHeight = 116
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 437
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      437
      35)
    object Btn_Fechar: TButton
      Left = 271
      Top = 4
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = Btn_FecharClick
    end
    object Btn_Ap_5: TButton
      Left = 350
      Top = 4
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Aplicar'
      TabOrder = 1
      OnClick = Btn_Ap_5Click
    end
  end
  object Pn_Config: TPanel
    Left = 0
    Top = 0
    Width = 437
    Height = 81
    Align = alClient
    Anchors = [akTop, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 74
      Height = 13
      Caption = 'IP / Nome Host'
    end
    object Sb_Executa_Config: TSpeedButton
      Left = 410
      Top = 24
      Width = 21
      Height = 21
      Caption = '...'
      OnClick = Sb_Executa_ConfigClick
    end
    object Label2: TLabel
      Left = 120
      Top = 8
      Width = 90
      Height = 13
      Caption = 'Caminho do Banco'
    end
    object E_IP_Config: TEdit
      Left = 7
      Top = 24
      Width = 111
      Height = 21
      TabOrder = 0
    end
    object E_Caminho_Config: TEdit
      Left = 119
      Top = 24
      Width = 287
      Height = 21
      TabOrder = 1
    end
  end
  object Opd_Abrir: TOpenDialog
    Filter = 'Interbase|*.GDB|Firebird|*.FDB'
    Left = 260
    Top = 43
  end
  object IBD_Gestao: TSTDatabase
    DatabaseName = 'C:\Modelos\Gestao2002\Database\IBGCOM.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    Left = 22
    Top = 80
  end
end
