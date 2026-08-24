inherited cadCargo: TcadCargo
  Caption = 'Cadastro de Cargo'
  ClientHeight = 133
  ClientWidth = 626
  ExplicitWidth = 632
  ExplicitHeight = 182
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 69
    Width = 626
    ExplicitTop = 69
    ExplicitWidth = 626
    inherited SB_Inserir: TSpeedButton
      Left = -1
      ExplicitLeft = 6
    end
    inherited SB_Alterar: TSpeedButton
      Left = 103
      ExplicitLeft = 102
    end
    inherited SB_Excluir: TSpeedButton
      Left = 207
      ExplicitLeft = 210
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 415
      ExplicitLeft = 414
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 519
      ExplicitLeft = 518
    end
    inherited SB_Gravar: TSpeedButton
      Left = 311
      ExplicitLeft = 318
    end
  end
  inherited pnl_fundo: TPanel
    Width = 626
    Height = 69
    ExplicitWidth = 626
    ExplicitHeight = 69
    object Label1: TLabel
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
    object Label2: TLabel
      Left = 57
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
    object E_Codigo: TEdit
      Left = 8
      Top = 24
      Width = 49
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
      Left = 58
      Top = 24
      Width = 491
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
  end
  inherited MnuBase: TMainMenu
    Left = 80
    Top = 32
  end
end
