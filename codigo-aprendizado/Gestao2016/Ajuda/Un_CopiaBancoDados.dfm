inherited Fr_CopiaBancoDAdos: TFr_CopiaBancoDAdos
  BorderStyle = bsDialog
  Caption = 'Copia Banco Via SFtp'
  ClientHeight = 270
  ClientWidth = 525
  ExplicitWidth = 531
  ExplicitHeight = 319
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_botoes: TPanel [0]
    Left = 0
    Top = 207
    Width = 525
    Height = 63
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Copiar: TSpeedButton
      AlignWithMargins = True
      Left = 358
      Top = 5
      Width = 80
      Height = 53
      Margins.Right = 1
      Align = alRight
      Caption = 'Copiar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_CopiarClick
      ExplicitTop = 6
    end
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 440
      Top = 5
      Width = 80
      Height = 53
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 273
      ExplicitTop = 4
      ExplicitHeight = 54
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 525
    Height = 207
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Gg_Progresso: TGauge
      Left = 10
      Top = 170
      Width = 504
      Height = 26
      Progress = 0
    end
    object Lb_Processamento: TLabel
      Left = 10
      Top = 154
      Width = 93
      Height = 13
      Caption = 'Progresso da C'#243'pia'
    end
    object edHost: TLabeledEdit
      Left = 10
      Top = 24
      Width = 153
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'Host:'
      TabOrder = 0
      Text = '192.168.25.240'
    end
    object edPort: TLabeledEdit
      Left = 167
      Top = 24
      Width = 42
      Height = 21
      EditLabel.Width = 24
      EditLabel.Height = 13
      EditLabel.Caption = 'Port:'
      TabOrder = 1
      Text = '22'
    end
    object edUser: TLabeledEdit
      Left = 224
      Top = 24
      Width = 137
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Username:'
      TabOrder = 2
      Text = 'root'
    end
    object edPass: TLabeledEdit
      Left = 375
      Top = 24
      Width = 137
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Password:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = #8226
      TabOrder = 3
      Text = 'c@c@o2912'
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 51
      Width = 504
      Height = 48
      Caption = 'Diret'#243'rio e arquivo dob banco de dado de origem'
      TabOrder = 4
      object SpeedButton1: TSpeedButton
        Left = 478
        Top = 16
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object E_PathFileOrigem: TEdit
        Left = 8
        Top = 19
        Width = 464
        Height = 21
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 10
      Top = 105
      Width = 504
      Height = 48
      Caption = 'Diret'#243'rio de destino do banco de dados'
      TabOrder = 5
      object SpeedButton2: TSpeedButton
        Left = 478
        Top = 16
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton2Click
      end
      object E_PathDestino: TEdit
        Left = 8
        Top = 19
        Width = 464
        Height = 21
        TabOrder = 0
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 48
    Top = 0
  end
  object Opd_Arquivo: TOpenDialog
    Filter = 'Banco Interbase|*.GDB|Banco Firebird|*.FDB'
    Left = 216
    Top = 21
  end
end
