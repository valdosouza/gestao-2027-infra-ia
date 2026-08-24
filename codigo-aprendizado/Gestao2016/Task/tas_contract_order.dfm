inherited TasContractOrder: TTasContractOrder
  Caption = 'Gera'#231#227'o de Contratos'
  ClientHeight = 155
  ClientWidth = 644
  ExplicitWidth = 650
  ExplicitHeight = 204
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 91
    Width = 644
    ExplicitTop = 91
    ExplicitWidth = 644
    inherited SB_Inserir: TSpeedButton
      Left = 17
      ExplicitLeft = 18
    end
    inherited SB_Alterar: TSpeedButton
      Left = 121
      ExplicitLeft = 122
    end
    inherited SB_Excluir: TSpeedButton
      Left = 225
      ExplicitLeft = 226
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 433
      ExplicitLeft = 434
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 537
      ExplicitLeft = 533
      ExplicitTop = 0
    end
    inherited SB_Gravar: TSpeedButton
      Left = 329
      ExplicitLeft = 330
    end
  end
  inherited pnl_fundo: TPanel
    Width = 644
    Height = 91
    ExplicitWidth = 644
    ExplicitHeight = 91
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 84
      Height = 14
      Align = alTop
      Caption = 'T'#237'tulo do Contrato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 5
      Top = 49
      Width = 201
      Height = 33
      Caption = 'Editar do Contato'
      OnClick = SpeedButton1Click
    end
    object Label2: TLabel
      Left = 513
      Top = 48
      Width = 77
      Height = 14
      Caption = #218'ltima Altera'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Tittle: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 23
      Width = 634
      Height = 22
      Margins.Top = 1
      Margins.Bottom = 1
      TabStop = False
      Align = alTop
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'NENHUM CONTRATO GERADO'
    end
    object E_Last_Update: TEdit
      Left = 514
      Top = 64
      Width = 121
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 1
      Text = 'E_Last_Update'
    end
  end
  inherited MnuBase: TMainMenu
    Left = 128
    Top = 16
  end
end
