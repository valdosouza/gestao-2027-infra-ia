inherited TasMdfeOperacoes: TTasMdfeOperacoes
  Caption = 'TasMdfeOperacoes'
  ClientHeight = 465
  ClientWidth = 598
  ExplicitWidth = 604
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Mdfe: TPanel [0]
    Left = 0
    Top = 28
    Width = 598
    Height = 347
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Lb_titulo_mdfeoperacoes: TLabel
      Left = 2
      Top = 2
      Width = 594
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 
        'Acompanhamento da Opera'#231#227'o com Manifesto Eletr'#244'nico de Documento' +
        's Fiscais'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 564
    end
    object MM_Acompanhamento: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 21
      Width = 588
      Height = 321
      Align = alClient
      Ctl3D = False
      Lines.Strings = (
        '')
      ParentCtl3D = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
      WantTabs = True
    end
    object E_Obs: TMemo
      Left = 898
      Top = 382
      Width = 447
      Height = 69
      TabOrder = 1
    end
  end
  object pnl_buttom: TPanel [1]
    Left = 0
    Top = 400
    Width = 598
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Transmitir: TSpeedButton
      AlignWithMargins = True
      Left = 102
      Top = 5
      Width = 82
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Transmitir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_TransmitirClick
      ExplicitLeft = 199
      ExplicitTop = 6
    end
    object Sb_Encerrar: TSpeedButton
      AlignWithMargins = True
      Left = 20
      Top = 5
      Width = 82
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Encerrar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_EncerrarClick
      ExplicitLeft = 3
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_sair: TSpeedButton
      AlignWithMargins = True
      Left = 512
      Top = 5
      Width = 82
      Height = 55
      Margins.Left = 0
      Margins.Right = 2
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
      OnClick = Sb_sairClick
      ExplicitLeft = 610
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Envia_Email: TSpeedButton
      AlignWithMargins = True
      Left = 430
      Top = 5
      Width = 82
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'e-mail - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 1
      OnClick = Sb_Envia_EmailClick
      ExplicitLeft = 416
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 348
      Top = 5
      Width = 82
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Imprimir - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ImprimirClick
      ExplicitLeft = 441
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Consultar: TSpeedButton
      AlignWithMargins = True
      Left = 184
      Top = 5
      Width = 82
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Consultar - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_ConsultarClick
      ExplicitLeft = 281
      ExplicitTop = 6
    end
    object Sb_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 266
      Top = 5
      Width = 82
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Cancelar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_CancelarClick
      ExplicitLeft = 359
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object Pnl_Validade: TPanel [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 592
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Pnl_Cert_Validade: TPanel
      Left = 0
      Top = 0
      Width = 345
      Height = 22
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Validade do Certificado Digital'
      TabOrder = 0
    end
    object Pnl_Cert_Expira: TPanel
      Left = 345
      Top = 0
      Width = 247
      Height = 22
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'O certificado expira em 1 dia(s)'
      TabOrder = 1
    end
  end
  object pnl_option: TPanel [3]
    Left = 0
    Top = 375
    Width = 598
    Height = 25
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object ChBx_forca_cosulta: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 588
      Height = 17
      Align = alTop
      Caption = 
        'For'#231'ar consulta (Precisa ter certeza de que o documento foi auto' +
        'rizado)'
      TabOrder = 0
    end
  end
  inherited MnuBase: TMainMenu
    Left = 96
    Top = 48
  end
  object ACBrMDFe1: TACBrMDFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 296
    Top = 116
  end
end
