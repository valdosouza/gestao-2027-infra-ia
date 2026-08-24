inherited BaseDonwload: TBaseDonwload
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Processamento'
  ClientHeight = 61
  ClientWidth = 473
  Menu = nil
  ExplicitWidth = 479
  ExplicitHeight = 90
  DesignSize = (
    473
    61)
  PixelsPerInch = 96
  TextHeight = 13
  object Lb_Process: TLabel [0]
    Left = 3
    Top = 27
    Width = 80
    Height = 13
    Caption = 'Processo parado'
  end
  object GG_Progresso: TGauge [1]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 467
    Height = 23
    Align = alTop
    Progress = 0
  end
  object btn_process: TButton [2]
    Left = 267
    Top = 32
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = btn_processClick
  end
  object Btn_Fechar: TButton [3]
    Left = 368
    Top = 32
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Fechar'
    TabOrder = 1
    OnClick = Btn_FecharClick
  end
  inherited MnuBase: TMainMenu
    Left = 225
    Top = 14
  end
  object http_down: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    OnWork = http_downWork
    OnWorkBegin = http_downWorkBegin
    OnWorkEnd = http_downWorkEnd
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
    Left = 16
    Top = 9
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
    Left = 96
    Top = 9
  end
end
