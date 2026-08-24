inherited LoteBaseTroca: TLoteBaseTroca
  BorderIcons = [biSystemMenu]
  Caption = 'LoteBaseTroca'
  ClientHeight = 162
  ExplicitHeight = 211
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 636
    Height = 91
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label10: TLabel
      Left = 107
      Top = 47
      Width = 64
      Height = 14
      Caption = 'Peso Entrada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 12
      Top = 47
      Width = 62
      Height = 14
      Caption = 'Data Entrada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Peso_Entrada: TEdit_Setes
      Left = 105
      Top = 62
      Width = 106
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      Text = ''
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 626
      Height = 43
      Align = alTop
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 626
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 626
        ExplicitWidth = 626
        inherited ChBx_Nome: TCheckBox
          Top = -2
          ExplicitTop = -2
        end
        inherited ChBx_Fantasia: TCheckBox
          Top = -2
          ExplicitLeft = 198
          ExplicitTop = -2
        end
      end
      inherited pnl_02: TPanel
        Width = 626
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 598
          ExplicitLeft = 543
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 573
          ExplicitLeft = 518
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 505
          ExplicitWidth = 497
        end
      end
    end
    object E_Data_Entrada: TDateTimePicker
      Left = 9
      Top = 62
      Width = 92
      Height = 21
      Date = 39488.445386284720000000
      Time = 39488.445386284720000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 91
    Width = 636
    Height = 71
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 446
      Top = 5
      Width = 90
      Height = 61
      Align = alRight
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 489
      ExplicitTop = 6
      ExplicitHeight = 57
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 542
      Top = 5
      Width = 89
      Height = 61
      Align = alRight
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 662
      ExplicitTop = 6
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 104
  end
end
