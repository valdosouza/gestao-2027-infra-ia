inherited CadElectEquip: TCadElectEquip
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Equipamentos'
  ClientHeight = 295
  ClientWidth = 632
  ExplicitWidth = 638
  ExplicitHeight = 344
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 231
    Width = 632
    ExplicitTop = 231
    ExplicitWidth = 632
    inherited SB_Inserir: TSpeedButton
      Left = 5
      ExplicitLeft = 12
    end
    inherited SB_Alterar: TSpeedButton
      Left = 109
      ExplicitLeft = 108
    end
    inherited SB_Excluir: TSpeedButton
      Left = 213
      ExplicitLeft = 216
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 421
      ExplicitLeft = 420
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 525
      ExplicitLeft = 524
    end
    inherited SB_Gravar: TSpeedButton
      Left = 317
      ExplicitLeft = 318
    end
  end
  inherited pnl_fundo: TPanel
    Width = 632
    Height = 231
    ExplicitWidth = 632
    ExplicitHeight = 231
    object Label28: TLabel
      Left = 8
      Top = 47
      Width = 119
      Height = 14
      Caption = 'Dispositivo /Equipamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 321
      Top = 86
      Width = 34
      Height = 14
      Caption = 'Modelo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 8
      Top = 87
      Width = 30
      Height = 14
      Caption = 'Marca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 128
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 321
      Top = 128
      Width = 18
      Height = 14
      Caption = 'IMEI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 11
      Top = 167
      Width = 56
      Height = 14
      Caption = 'Acess'#243'rios'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 622
      Height = 43
      Align = alTop
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 622
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 622
        ExplicitWidth = 622
        inherited ChBx_Nome: TCheckBox
          Top = -2
          TabStop = False
          ExplicitTop = -2
        end
        inherited ChBx_Fantasia: TCheckBox
          Top = -2
          TabStop = False
          ExplicitLeft = 198
          ExplicitTop = -2
        end
      end
      inherited pnl_02: TPanel
        Width = 622
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 594
          ExplicitLeft = 543
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 569
          ExplicitLeft = 518
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 501
          ExplicitWidth = 493
        end
      end
    end
    object E_Serie: TEdit
      Left = 8
      Top = 144
      Width = 310
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_IMei: TEdit
      Left = 320
      Top = 144
      Width = 305
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_Accessories: TEdit
      Left = 10
      Top = 183
      Width = 617
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object CB_Device: TComboBox
      Left = 8
      Top = 63
      Width = 614
      Height = 21
      TabOrder = 4
    end
    object CB_Brand: TComboBox
      Left = 8
      Top = 103
      Width = 310
      Height = 21
      TabOrder = 5
    end
    object CB_Model: TComboBox
      Left = 320
      Top = 103
      Width = 305
      Height = 21
      TabOrder = 6
    end
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 184
  end
end
