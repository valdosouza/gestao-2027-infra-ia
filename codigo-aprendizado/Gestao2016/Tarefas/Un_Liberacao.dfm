object Fr_Liberacao: TFr_Liberacao
  Left = 498
  Top = 280
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Libera'#231#227'o'
  ClientHeight = 184
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_bottom: TPanel
    Left = 0
    Top = 143
    Width = 277
    Height = 41
    Align = alBottom
    TabOrder = 0
    object SB_Confirma: TSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 81
      Height = 33
      Align = alLeft
      Caption = 'Confirma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = '@Arial Unicode MS'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_ConfirmaClick
      ExplicitTop = 6
    end
    object SB_Cancela: TSpeedButton
      AlignWithMargins = True
      Left = 91
      Top = 4
      Width = 79
      Height = 33
      Align = alLeft
      Caption = 'Cancela'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = '@Arial Unicode MS'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000666666666666661F66666666666666668F66000066661F66666666666666
        668F6666666666660000666111F6666661F666666888F6666668F66600006661
        11F666661F6666666888F666668F666600006666111F66611F66666666888F66
        688F6666000066666111F611F6666666666888F688F66666000066666611111F
        66666666666688888F66666600006666666111F66666666666666888F6666666
        000066666611111F66666666666688888F666666000066666111F61F66666666
        666888F68F66666600006661111F66611F66666668888F66688F666600006611
        11F6666611F666668888F6666688F66600006611F6666666611F666688F66666
        66688F6600006666666666666666666666666666666666660000666666666666
        6666666666666666666666660000666666666666666666666666666666666666
        0000}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_CancelaClick
      ExplicitTop = 6
    end
  end
  object pnl_login: TPanel
    Left = 0
    Top = 0
    Width = 277
    Height = 143
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 26
      Height = 15
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Login'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = '@Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 31
      Height = 15
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Senha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = '@Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 89
      Width = 166
      Height = 15
      Margins.Top = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Ou Utilize o cart'#227'o de Autoriza'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = '@Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object CB_Usuario: TComboBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 267
      Height = 21
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      CharCase = ecUpperCase
      TabOrder = 0
      Text = 'CB_USUARIO'
    end
    object E_Senha: TMaskEdit
      AlignWithMargins = True
      Left = 5
      Top = 56
      Width = 267
      Height = 23
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = '@Arial Unicode MS'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
      Text = ''
    end
    object E_Card: TMaskEdit
      AlignWithMargins = True
      Left = 5
      Top = 104
      Width = 267
      Height = 23
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = '@Arial Unicode MS'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 2
      Text = ''
    end
  end
end
