inherited TasOwnFleetOs: TTasOwnFleetOs
  Caption = 'Registro de manuten'#231#227'o de frota pr'#243'pria'
  ClientWidth = 647
  ExplicitWidth = 653
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Width = 647
    ExplicitWidth = 647
    inherited SB_Inserir: TSpeedButton
      Left = 20
      ExplicitLeft = 20
    end
    inherited SB_Alterar: TSpeedButton
      Left = 124
      ExplicitLeft = 124
    end
    inherited SB_Excluir: TSpeedButton
      Left = 228
      ExplicitLeft = 228
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 436
      ExplicitLeft = 436
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 540
      ExplicitLeft = 540
    end
    inherited SB_Gravar: TSpeedButton
      Left = 332
      ExplicitLeft = 332
    end
  end
  inherited pnl_fundo: TPanel
    Width = 647
    ExplicitWidth = 647
    object Label4: TLabel
      Left = 11
      Top = 3
      Width = 64
      Height = 14
      Caption = 'Placa Ve'#237'culo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 551
      Top = 3
      Width = 64
      Height = 14
      Caption = 'Kilometragem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton2: TSpeedButton
      Left = 83
      Top = 19
      Width = 23
      Height = 21
      Caption = '...'
      OnClick = SpeedButton2Click
    end
    object Label1: TLabel
      Left = 112
      Top = 3
      Width = 22
      Height = 14
      Caption = 'Data'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 9
      Top = 43
      Width = 60
      Height = 14
      Caption = 'Observa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 209
      Top = 3
      Width = 67
      Height = 14
      Caption = 'Marca/Modelo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Placa: TMaskEdit
      Left = 7
      Top = 19
      Width = 74
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      Text = ''
      OnExit = E_PlacaExit
    end
    object E_Km: TEdit
      Left = 550
      Top = 19
      Width = 94
      Height = 21
      Color = clHighlightText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Data: TDateTimePicker
      Left = 112
      Top = 19
      Width = 90
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Obs: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 62
      Width = 637
      Height = 284
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_Marca_Modelo: TEdit
      Left = 205
      Top = 19
      Width = 342
      Height = 21
      Color = clHighlightText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  inherited MnuBase: TMainMenu
    Left = 48
    Top = 104
  end
end
