inherited TasItemObs: TTasItemObs
  Caption = 'Detalhamento do Item'
  ClientHeight = 435
  ClientWidth = 856
  Menu = nil
  ExplicitWidth = 862
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 371
    Width = 856
    ExplicitTop = 371
    ExplicitWidth = 856
    inherited SB_Inserir: TSpeedButton
      Left = 3
      Width = 10
      Align = alLeft
      Visible = False
      ExplicitLeft = 3
      ExplicitTop = 5
      ExplicitWidth = 10
    end
    inherited SB_Alterar: TSpeedButton
      Left = 15
      Width = 10
      Align = alLeft
      Visible = False
      ExplicitLeft = 15
      ExplicitTop = 5
      ExplicitWidth = 10
    end
    inherited SB_Excluir: TSpeedButton
      Left = 27
      Width = 10
      Align = alLeft
      Visible = False
      ExplicitLeft = 27
      ExplicitTop = 5
      ExplicitWidth = 10
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 751
      ExplicitLeft = 751
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 39
      Width = 10
      Align = alLeft
      Visible = False
      ExplicitLeft = 39
      ExplicitTop = 5
      ExplicitWidth = 10
    end
    inherited SB_Gravar: TSpeedButton
      Left = 647
      ExplicitLeft = 647
    end
  end
  inherited pnl_fundo: TPanel
    Width = 856
    Height = 371
    ExplicitWidth = 856
    ExplicitHeight = 371
    object E_Detalhe: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 846
      Height = 361
      Align = alClient
      TabOrder = 0
    end
  end
  inherited MnuBase: TMainMenu
    Left = 56
    Top = 352
  end
end
