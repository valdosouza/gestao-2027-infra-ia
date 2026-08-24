inherited TasDelivery: TTasDelivery
  Caption = 'Delivery'
  ClientHeight = 309
  ClientWidth = 699
  ExplicitWidth = 705
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 245
    Width = 699
    ExplicitTop = 245
    ExplicitWidth = 699
    inherited SB_Inserir: TSpeedButton
      Left = 85
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 85
      ExplicitTop = 5
    end
    inherited SB_Alterar: TSpeedButton
      Left = 187
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 187
      ExplicitTop = 5
    end
    inherited SB_Excluir: TSpeedButton
      Left = 289
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 289
      ExplicitTop = 5
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 493
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 493
      ExplicitTop = 5
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 595
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 595
      ExplicitTop = 5
    end
    inherited SB_Gravar: TSpeedButton
      Left = 391
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 391
      ExplicitTop = 5
    end
  end
  inherited pnl_fundo: TPanel
    Width = 699
    Height = 245
    ExplicitWidth = 699
    ExplicitHeight = 245
    object Lb_bairro: TLabel
      Left = 5
      Top = 84
      Width = 36
      Height = 16
      Caption = 'Bairro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Telefone: TLabel
      Left = 5
      Top = 3
      Width = 57
      Height = 16
      Caption = 'Telefone '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Cliente: TLabel
      Left = 89
      Top = 3
      Width = 100
      Height = 16
      Caption = 'Nome do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Lb_Cep: TLabel
      Left = 617
      Top = 3
      Width = 27
      Height = 16
      Caption = 'CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lb_endereco: TLabel
      Left = 5
      Top = 44
      Width = 59
      Height = 16
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lb_compl: TLabel
      Left = 445
      Top = 44
      Width = 84
      Height = 16
      Caption = 'Complemento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lb_numero: TLabel
      Left = 377
      Top = 44
      Width = 48
      Height = 16
      Caption = 'N'#250'mero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lb_ObsCliente: TLabel
      Left = 6
      Top = 132
      Width = 145
      Height = 16
      Caption = 'Observa'#231#245'es do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Cep: TSpeedButton
      Left = 667
      Top = 20
      Width = 23
      Height = 21
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
        FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
        9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      Margin = 0
      NumGlyphs = 2
      OnClick = Sb_CepClick
    end
    object Sb_Cliente: TSpeedButton
      Left = 575
      Top = 19
      Width = 23
      Height = 21
      Caption = '...'
      Layout = blGlyphTop
      Margin = 0
      NumGlyphs = 2
      OnClick = Sb_ClienteClick
    end
    object Sb_Endereco: TSpeedButton
      Left = 353
      Top = 61
      Width = 23
      Height = 21
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
        FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
        9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      Margin = 0
      NumGlyphs = 2
    end
    object Label2: TLabel
      Left = 609
      Top = 85
      Width = 82
      Height = 16
      Caption = 'Valor Entrega'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Nome: TEdit
      Left = 87
      Top = 19
      Width = 483
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Endereco: TEdit
      Left = 5
      Top = 60
      Width = 347
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_Compl: TEdit
      Left = 446
      Top = 60
      Width = 246
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_Bairro: TEdit
      Left = 5
      Top = 101
      Width = 349
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object E_CEP: TMaskEdit
      Left = 597
      Top = 19
      Width = 69
      Height = 24
      CharCase = ecUpperCase
      EditMask = '00000-000;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnExit = E_CEPExit
    end
    object E_Numero: TEdit
      Left = 377
      Top = 60
      Width = 68
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_Telefone: TEdit_Setes
      Left = 6
      Top = 19
      Width = 80
      Height = 24
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnEnter = E_TelefoneEnter
      OnExit = E_TelefoneExit
      IsFone = True
    end
    object E_Obs: TMemo
      Left = 2
      Top = 154
      Width = 695
      Height = 89
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 8
    end
    object E_Vl_Entrega: TEdit_Setes
      Left = 610
      Top = 104
      Width = 83
      Height = 21
      Alignment = taRightJustify
      TabOrder = 7
      Text = ''
    end
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 152
  end
end
