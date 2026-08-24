inherited DctCtrlCheque: TDctCtrlCheque
  Caption = 'Descontar Cheque'
  ClientHeight = 517
  ExplicitWidth = 642
  ExplicitHeight = 566
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 636
    Height = 451
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 398
    DesignSize = (
      636
      451)
    object SB_Add_Tudo_Descontar: TSpeedButton
      Left = 412
      Top = 421
      Width = 109
      Height = 24
      Anchors = [akRight, akBottom]
      Caption = 'Marcar todos'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
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
      OnClick = SB_Add_Tudo_DescontarClick
      ExplicitTop = 368
    end
    object SB_Retirar_Tudo_Descontar: TSpeedButton
      Left = 522
      Top = 421
      Width = 107
      Height = 24
      Anchors = [akRight, akBottom]
      Caption = 'Desmarcar todos'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333FFF33FF333FFF339993370733
        999333777FF37FF377733339993000399933333777F777F77733333399970799
        93333333777F7377733333333999399933333333377737773333333333990993
        3333333333737F73333333333331013333333333333777FF3333333333910193
        333333333337773FF3333333399000993333333337377737FF33333399900099
        93333333773777377FF333399930003999333337773777F777FF339993370733
        9993337773337333777333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_Retirar_Tudo_DescontarClick
      ExplicitTop = 368
    end
    object ChLBx_Descontar: TCheckListBox
      Left = 6
      Top = 13
      Width = 621
      Height = 385
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitHeight = 435
    end
    inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
      Left = 6
      Top = 404
      Width = 415
      Height = 41
      Anchors = [akRight, akBottom]
      TabOrder = 1
      ExplicitLeft = 6
      ExplicitTop = 454
      ExplicitWidth = 415
      ExplicitHeight = 41
      inherited L_ContaBancaria: TLabel
        Width = 415
      end
      inherited Sb_ContaBancaria: TSpeedButton
        Left = 388
        Height = 26
        ExplicitLeft = 443
        ExplicitTop = 15
        ExplicitHeight = 26
      end
      inherited DBLCB_ContaBancaria: TDBLookupComboBox
        Width = 379
        ExplicitWidth = 431
      end
    end
  end
  object pnl_bottom: TPanel [1]
    Left = 0
    Top = 451
    Width = 636
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 398
    object Sb_Sair: TSpeedButton
      Left = 552
      Top = 2
      Width = 82
      Height = 62
      Align = alRight
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
      ExplicitLeft = 548
      ExplicitTop = 12
      ExplicitHeight = 54
    end
    object Sb_Descontar: TSpeedButton
      Left = 470
      Top = 2
      Width = 82
      Height = 62
      Align = alRight
      Caption = 'Baixar - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_DescontarClick
      ExplicitLeft = 384
      ExplicitTop = 12
      ExplicitHeight = 54
    end
  end
end
