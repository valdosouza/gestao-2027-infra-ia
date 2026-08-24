inherited TasPrePaidCard: TTasPrePaidCard
  Caption = 'Cadastro de Cart'#227'o Pr'#233'-Pago'
  ClientHeight = 168
  ClientWidth = 619
  ExplicitWidth = 625
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 104
    Width = 619
    ExplicitTop = 104
    ExplicitWidth = 619
    inherited SB_Inserir: TSpeedButton
      Left = -8
      ExplicitLeft = -1
    end
    inherited SB_Alterar: TSpeedButton
      Left = 96
      ExplicitLeft = 101
    end
    inherited SB_Excluir: TSpeedButton
      Left = 200
      ExplicitLeft = 203
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 408
      ExplicitLeft = 407
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 512
      ExplicitLeft = 511
    end
    inherited SB_Gravar: TSpeedButton
      Left = 304
      ExplicitLeft = 305
    end
  end
  inherited pnl_fundo: TPanel
    Width = 619
    Height = 104
    ExplicitWidth = 619
    ExplicitHeight = 104
    object Label36: TLabel
      Left = 100
      Top = 4
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'N'#250'mero Cart'#227'o'
      FocusControl = E_Numero
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 2
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'Data'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 195
      Top = 4
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'Valor Cr'#233'dito'
      FocusControl = E_VL_Credito
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 287
      Top = 4
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'Valor D'#233'bito'
      FocusControl = E_VL_Debito
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 7
      Top = 50
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'Hist'#243'rico'
      FocusControl = E_Historico
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Numero: TEdit
      Left = 101
      Top = 21
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object E_Data: TDateTimePicker
      Left = 6
      Top = 21
      Width = 89
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 4
      TabStop = False
    end
    object E_VL_Credito: TMaskEdit
      Left = 195
      Top = 21
      Width = 88
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 9
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
    object E_VL_Debito: TMaskEdit
      Left = 289
      Top = 21
      Width = 88
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 9
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object E_Historico: TMaskEdit
      Left = 6
      Top = 69
      Width = 607
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object GroupBox1: TGroupBox
      Left = 407
      Top = 12
      Width = 185
      Height = 51
      Caption = 'Percentual de Acr'#233'scimo a  ceder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object E_Tx_Acrescimo: TMaskEdit
        Left = 41
        Top = 19
        Width = 88
        Height = 22
        Alignment = taCenter
        CharCase = ecUpperCase
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 9
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        Text = '0'
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 544
    Top = 48
  end
end
