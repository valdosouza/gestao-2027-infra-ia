inherited Fr_Baixa_Cheques: TFr_Baixa_Cheques
  Left = 401
  Top = 197
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Controle de baixa de Cheques'
  ClientHeight = 323
  ClientWidth = 345
  Font.Name = 'MS Sans Serif'
  OldCreateOrder = False
  ExplicitWidth = 351
  ExplicitHeight = 372
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 345
    Height = 323
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      345
      323)
    object SB_Confirmar: TSpeedButton
      Left = 174
      Top = 263
      Width = 82
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Baixar - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
    end
    object Sb_Sair: TSpeedButton
      Left = 257
      Top = 263
      Width = 82
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_SairClick
    end
    object Rg_Escolha: TRadioGroup
      Left = 6
      Top = 4
      Width = 331
      Height = 246
      Caption = 'Escolha a Opera'#231'ao a Executar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Efetuar Dep'#243'sito em Banco a escolher'
        'Efetuar Desconto de Cheque com Financeira'
        'Efetuar Retorno de Cheque que foi Descontado'
        'Efetuar Registro de Devolu'#231#227'o de Cheque')
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited MnuBase: TMainMenu
    Left = 88
    Top = 65528
  end
end
