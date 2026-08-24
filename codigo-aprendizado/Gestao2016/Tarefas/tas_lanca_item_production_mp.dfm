inherited TasLancaItemProductionMP: TTasLancaItemProductionMP
  Caption = 'Lan'#231'amento de Mat'#233'ria Prima utilizada'
  ClientWidth = 652
  ExplicitWidth = 658
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 652
    ExplicitWidth = 652
    object Label10: TLabel [2]
      Left = 538
      Top = 46
      Width = 66
      Height = 13
      Caption = 'Cons. Unit'#225'rio'
      FocusControl = E_Cons_Unitario
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Cons_Unitario: TEdit_Setes
      Left = 536
      Top = 60
      Width = 109
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
  end
  inherited Panel2: TPanel
    Width = 652
    ExplicitWidth = 652
    inherited Sb_Sair_0: TSpeedButton
      Left = 566
      ExplicitLeft = 566
    end
    inherited Sb_Pesquisar: TSpeedButton
      Left = 488
      ExplicitLeft = 488
    end
    inherited SB_Gravar: TSpeedButton
      Left = 410
      ExplicitLeft = 410
    end
  end
end
