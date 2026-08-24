inherited Fr_Command: TFr_Command
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Comanda'
  ClientHeight = 309
  ClientWidth = 465
  Menu = nil
  ExplicitWidth = 471
  ExplicitHeight = 338
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 245
    Width = 465
    ExplicitTop = 245
    ExplicitWidth = 465
    inherited SB_Inserir: TSpeedButton
      Left = 144
      Visible = False
      ExplicitLeft = 383
    end
    inherited SB_Alterar: TSpeedButton
      Left = 221
      Visible = False
      ExplicitLeft = 460
    end
    inherited SB_Excluir: TSpeedButton
      Left = 298
      Visible = False
      ExplicitLeft = 537
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 85
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 86
      ExplicitTop = 5
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 379
      Visible = False
      ExplicitLeft = 379
    end
    inherited SB_Gravar: TSpeedButton
      Left = 0
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 0
    end
  end
  inherited pnl_fundo: TPanel
    Width = 465
    Height = 245
    ExplicitWidth = 465
    ExplicitHeight = 245
    object Label1: TLabel
      Left = 8
      Top = 6
      Width = 82
      Height = 19
      Caption = 'Data / Hora'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 62
      Width = 151
      Height = 19
      Caption = 'N'#250'mero da Comanda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 118
      Width = 118
      Height = 19
      Caption = 'Nome do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 174
      Width = 146
      Height = 19
      Caption = 'N'#250'mero do Telefone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object E_Dt_REcord: TEdit
      Left = 6
      Top = 28
      Width = 203
      Height = 31
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object e_Numero_Comanda: TEdit
      Left = 6
      Top = 84
      Width = 283
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Nome_Cliente: TEdit
      Left = 6
      Top = 140
      Width = 439
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Numero_Telefone: TEdit
      Left = 6
      Top = 196
      Width = 243
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited MnuBase: TMainMenu
    Left = 464
    Top = 8
  end
end
