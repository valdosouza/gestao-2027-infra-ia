inherited CadWhatsAppCfg: TCadWhatsAppCfg
  Caption = 'Cadastros de Urls para envio via WhatsApp'
  ClientHeight = 311
  ClientWidth = 999
  ExplicitWidth = 1005
  ExplicitHeight = 360
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 247
    Width = 999
    ExplicitTop = 247
    ExplicitWidth = 999
    inherited SB_Inserir: TSpeedButton
      Left = 372
      ExplicitLeft = 372
    end
    inherited SB_Alterar: TSpeedButton
      Left = 476
      ExplicitLeft = 476
    end
    inherited SB_Excluir: TSpeedButton
      Left = 580
      ExplicitLeft = 580
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 788
      ExplicitLeft = 788
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 892
      ExplicitLeft = 892
    end
    inherited SB_Gravar: TSpeedButton
      Left = 684
      ExplicitLeft = 684
    end
  end
  inherited pnl_fundo: TPanel
    Width = 999
    Height = 247
    ExplicitWidth = 999
    ExplicitHeight = 247
    object Label38: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 173
      Width = 99
      Height = 13
      Align = alTop
      Caption = 'Token autentica'#231#227'o '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 127
      Width = 210
      Height = 13
      Align = alTop
      Caption = 'Token para ser enviado com a URL - Bearer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label39: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 81
      Width = 75
      Height = 13
      Align = alTop
      Caption = 'URL para envio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label56: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 35
      Width = 109
      Height = 13
      Align = alTop
      Caption = 'Descri'#231#227'o do EndPoint'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Chbx_Whats_Ativar: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 989
      Height = 17
      Margins.Bottom = 10
      Align = alTop
      Caption = 
        'Ativar o uso da API do WhatsApp - Essa Marca'#231#227'o serve para todas' +
        ' as URLs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_Whats_url_token_auth: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 192
      Width = 989
      Height = 21
      Align = alTop
      TabOrder = 3
    end
    object E_Whats_url_token: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 146
      Width = 989
      Height = 21
      Align = alTop
      TabOrder = 2
    end
    object E_Whats_url_send: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 100
      Width = 989
      Height = 21
      Align = alTop
      TabOrder = 1
    end
    object E_Whats_Description: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 54
      Width = 989
      Height = 21
      Align = alTop
      TabOrder = 0
    end
  end
  inherited MnuBase: TMainMenu
    Left = 88
    Top = 216
  end
end
