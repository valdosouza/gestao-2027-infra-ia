inherited TasConfigConserto: TTasConfigConserto
  Caption = 'Configura'#231#227'o Conserto'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object ChBx_Valida_Mao_Obra: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 594
      Height = 17
      Align = alTop
      Caption = 'Validar o prenchimento do campo valor m'#227'o de obra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited MnuBase: TMainMenu
    Left = 104
    Top = 48
  end
end
