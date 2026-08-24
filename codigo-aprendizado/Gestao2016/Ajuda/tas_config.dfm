inherited TasConfig: TTasConfig
  Caption = 'Configura'#231#227'o'
  ClientHeight = 397
  ClientWidth = 604
  ExplicitWidth = 610
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  object Panel6: TPanel [0]
    Left = 0
    Top = 362
    Width = 604
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Btn_OK: TButton
      AlignWithMargins = True
      Left = 368
      Top = 3
      Width = 79
      Height = 29
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'OK'
      TabOrder = 0
      OnClick = Btn_OKClick
    end
    object Btn_Cn: TButton
      AlignWithMargins = True
      Left = 447
      Top = 3
      Width = 75
      Height = 29
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = Btn_CnClick
    end
    object Btn_Ap: TButton
      AlignWithMargins = True
      Left = 522
      Top = 3
      Width = 79
      Height = 29
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Aplicar'
      TabOrder = 2
      OnClick = Btn_ApClick
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 604
    Height = 362
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
  end
  inherited MnuBase: TMainMenu
    Left = 88
    Top = 32
  end
end
