inherited CfgAssistance: TCfgAssistance
  BorderIcons = [biSystemMenu]
  Caption = 'Assist'#234'ncia - Configura'#231#227'o'
  ClientHeight = 120
  ClientWidth = 494
  ExplicitWidth = 500
  ExplicitHeight = 169
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel [0]
    Left = 0
    Top = 0
    Width = 494
    Height = 120
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      494
      120)
    object Label16: TLabel
      Left = 2
      Top = 2
      Width = 490
      Height = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'Configura'#231#245'es Locais'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      ExplicitWidth = 174
    end
    object Label17: TLabel
      Left = 7
      Top = 24
      Width = 108
      Height = 14
      Caption = 'Modelos de Impress'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Cbx_ModeloImpressao: TComboBox
      Left = 7
      Top = 39
      Width = 463
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'MODELO 1  - GENIO'
      Items.Strings = (
        'MODELO 1  - GENIO'
        'MODELO 2  - BALAN'#199'AS PINHAIS')
    end
    object Btn_Ok_Local: TButton
      Left = 254
      Top = 89
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 1
      OnClick = Btn_Ok_LocalClick
    end
    object Btn_Cn_Local: TButton
      Left = 333
      Top = 89
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 2
    end
    object Btn_Ap_Local: TButton
      Left = 408
      Top = 89
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Aplicar'
      TabOrder = 3
      OnClick = Btn_Ap_LocalClick
    end
  end
end
