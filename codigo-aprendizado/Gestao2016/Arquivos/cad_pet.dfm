inherited CadPet: TCadPet
  Caption = 'Cadastro do Pet'
  ClientHeight = 275
  ClientWidth = 635
  ExplicitWidth = 641
  ExplicitHeight = 324
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 211
    Width = 635
    ExplicitTop = 211
    ExplicitWidth = 635
    inherited SB_Inserir: TSpeedButton
      Left = 8
      ExplicitLeft = 8
    end
    inherited SB_Alterar: TSpeedButton
      Left = 112
      ExplicitLeft = 112
    end
    inherited SB_Excluir: TSpeedButton
      Left = 216
      ExplicitLeft = 216
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 424
      ExplicitLeft = 424
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 528
      ExplicitLeft = 528
    end
    inherited SB_Gravar: TSpeedButton
      Left = 320
      ExplicitLeft = 320
    end
  end
  inherited pnl_fundo: TPanel
    Width = 635
    Height = 211
    ExplicitWidth = 635
    ExplicitHeight = 211
    object Label1: TLabel
      Left = 9
      Top = 46
      Width = 60
      Height = 14
      Caption = 'Nome do Pet'
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
      Width = 40
      Height = 14
      Caption = 'Pelagem'
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
      Width = 25
      Height = 14
      Caption = 'Ra'#231'a'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 322
      Top = 46
      Width = 26
      Height = 14
      Caption = 'Idade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 9
      Top = 127
      Width = 17
      Height = 14
      Caption = 'Cor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 320
      Top = 127
      Width = 54
      Height = 14
      Caption = 'Frequ'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 11
      Top = 165
      Width = 44
      Height = 14
      Caption = 'Cadastro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Name: TEdit
      Left = 9
      Top = 62
      Width = 306
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object CB_Race: TComboBox
      Left = 8
      Top = 103
      Width = 310
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object CB_Hair: TComboBox
      Left = 320
      Top = 103
      Width = 305
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
    end
    object E_Age: TEdit
      Left = 322
      Top = 62
      Width = 39
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
    object Rg_Sexo: TRadioGroup
      Left = 367
      Top = 49
      Width = 138
      Height = 36
      Caption = 'Sexo'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'MACHO'
        'F'#202'MEA')
      TabOrder = 2
    end
    object Cb_Color: TComboBox
      Left = 9
      Top = 143
      Width = 310
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 6
    end
    object Rg_castrated: TRadioGroup
      Left = 511
      Top = 49
      Width = 114
      Height = 36
      Caption = 'Castrado'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 3
    end
    object Cb_attendance: TComboBox
      Left = 320
      Top = 143
      Width = 310
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 7
    end
    object E_Data: TDateTimePicker
      Left = 9
      Top = 180
      Width = 88
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 8
    end
    inline Fm_ListaClientes: TFm_ListaClientes
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 625
      Height = 43
      Align = alTop
      TabOrder = 9
      TabStop = True
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 625
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 625
        ExplicitWidth = 625
      end
      inherited pnl_02: TPanel
        Width = 625
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 597
          ExplicitLeft = 599
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 572
          ExplicitLeft = 574
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 504
          ExplicitWidth = 496
        end
      end
      inherited Qr_ListaEmpresa: TSTQuery
        Top = 19
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 32
    inherited arefas1: TMenuItem
      object ProcedimentosPeridicos1: TMenuItem [0]
        Caption = 'Procedimentos Peri'#243'dicos'
        OnClick = ProcedimentosPeridicos1Click
      end
      object Contatos1: TMenuItem [1]
        Caption = 'Contatos'
        OnClick = Contatos1Click
      end
    end
  end
end
