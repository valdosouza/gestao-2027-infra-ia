inherited RegTaxIcmsNr: TRegTaxIcmsNr
  Caption = 'Cadastro de Situa'#231#245'es Tribut'#225'rias'
  ClientHeight = 132
  ClientWidth = 714
  ExplicitWidth = 720
  ExplicitHeight = 181
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 68
    Width = 714
    ExplicitTop = 111
    ExplicitWidth = 562
    inherited SB_Inserir: TSpeedButton
      Left = 155
      ExplicitLeft = 3
    end
    inherited SB_Alterar: TSpeedButton
      Left = 259
      Width = 86
      ExplicitLeft = 91
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Excluir: TSpeedButton
      Left = 347
      Width = 86
      ExplicitLeft = 179
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 523
      Width = 82
      ExplicitLeft = 351
      ExplicitTop = 5
      ExplicitWidth = 82
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 607
      ExplicitLeft = 455
    end
    inherited SB_Gravar: TSpeedButton
      Left = 435
      Width = 86
      ExplicitLeft = 267
      ExplicitTop = 5
      ExplicitWidth = 86
    end
  end
  inherited pnl_fundo: TPanel
    Width = 714
    Height = 68
    ExplicitWidth = 562
    ExplicitHeight = 111
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
      Left = 158
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
      Left = 83
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
      Width = 69
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
      Left = 159
      Top = 24
      Width = 542
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 1
    end
    object E_Grupo: TEdit
      Left = 83
      Top = 24
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited MnuBase: TMainMenu
    Left = 48
    Top = 136
  end
end
