inherited RegTaxIcmsSn: TRegTaxIcmsSn
  Caption = 'Cadastro de Situa'#231#227'o do Simples Nacional '
  ClientHeight = 143
  ClientWidth = 673
  ExplicitWidth = 679
  ExplicitHeight = 192
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 79
    Width = 673
    ExplicitTop = 118
    ExplicitWidth = 553
    inherited SB_Inserir: TSpeedButton
      Left = 124
      ExplicitLeft = 4
    end
    inherited SB_Alterar: TSpeedButton
      Left = 228
      Width = 79
      ExplicitLeft = 106
      ExplicitTop = 5
      ExplicitWidth = 79
    end
    inherited SB_Excluir: TSpeedButton
      Left = 309
      Width = 91
      ExplicitLeft = 134
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 487
      Width = 83
      ExplicitLeft = 342
      ExplicitTop = 5
      ExplicitWidth = 83
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 572
      Width = 96
      ExplicitLeft = 457
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Gravar: TSpeedButton
      Left = 402
      Width = 83
      ExplicitLeft = 238
      ExplicitTop = 5
      ExplicitWidth = 83
    end
  end
  inherited pnl_fundo: TPanel
    Width = 673
    Height = 79
    ExplicitWidth = 553
    ExplicitHeight = 118
    object L_Codigo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Descricao: TLabel
      Left = 130
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
    object L_Grupo: TLabel
      Left = 75
      Top = 8
      Width = 30
      Height = 14
      Caption = 'Grupo'
      FocusControl = E_Grupo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Codigo: TEdit
      Left = 8
      Top = 24
      Width = 61
      Height = 22
      Color = clScrollBar
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Descricao: TEdit
      Left = 130
      Top = 24
      Width = 531
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 170
      ParentFont = False
      TabOrder = 1
    end
    object E_Grupo: TEdit
      Left = 75
      Top = 24
      Width = 54
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited MnuBase: TMainMenu
    Left = 80
    Top = 72
  end
end
