inherited TasGeraNfeSchemas: TTasGeraNfeSchemas
  Caption = 'Baixar Schemas da Nfe'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    ActivePage = tbs_Schemas
    object tbs_Schemas: TTabSheet
      Caption = 'tbs_Schemas'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 588
        Height = 510
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label19: TLabel
          Left = 2
          Top = 2
          Width = 400
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Atualizar os Arquivos Schemas que validam a Nota Fiscal'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object MM_Schema: TMemo
          Left = 2
          Top = 18
          Width = 584
          Height = 490
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 510
        Width = 588
        Height = 62
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_Schema_confirma: TSpeedButton
          AlignWithMargins = True
          Left = 413
          Top = 5
          Width = 82
          Height = 52
          Align = alRight
          Caption = 'Atualizar - F10'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 1
          OnClick = Sb_Schema_confirmaClick
          ExplicitTop = 6
        end
        object Sb_Schema_Volta: TSpeedButton
          AlignWithMargins = True
          Left = 501
          Top = 5
          Width = 82
          Height = 52
          Align = alRight
          Caption = 'Voltar - Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Schema_VoltaClick
          ExplicitLeft = 495
          ExplicitTop = 4
          ExplicitHeight = 54
        end
      end
    end
  end
  object http_down: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 192
    Top = 232
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 192
    Top = 302
  end
end
