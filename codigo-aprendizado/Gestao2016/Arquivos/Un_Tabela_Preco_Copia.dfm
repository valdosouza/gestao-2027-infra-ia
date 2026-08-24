inherited Fr_Tabela_Preco_Copia: TFr_Tabela_Preco_Copia
  Caption = 'Op'#231#245'es para C'#243'pia de Tabela'
  ClientHeight = 117
  ClientWidth = 505
  ExplicitWidth = 511
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 505
    Height = 117
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      505
      117)
    object Label4: TLabel
      Left = 263
      Top = 39
      Width = 94
      Height = 13
      Caption = 'Taxa de Refer'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    inline Fm_ListaTabelaPreco: TFm_ListaTabelaPreco
      Left = 2
      Top = 2
      Width = 501
      Height = 36
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 501
      ExplicitHeight = 36
      inherited Sb_Preco: TSpeedButton
        Left = 474
        ExplicitLeft = 478
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 472
        ExplicitWidth = 472
      end
    end
    object Rg_Tipo: TRadioGroup
      Left = 5
      Top = 40
      Width = 257
      Height = 37
      Caption = ' Tipo Opera'#231#227'o '
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Nenhum'
        'Acrescimo'
        'Desconto')
      ParentFont = False
      TabOrder = 1
    end
    object E_Aliquota: TMaskEdit
      Left = 263
      Top = 53
      Width = 112
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0'
    end
    object Button1: TButton
      Left = 257
      Top = 86
      Width = 120
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Copiar'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 377
      Top = 86
      Width = 120
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Continuar Sem Copiar'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object STQuery1: TSTQuery
    ForcedRefresh = False
    Left = 40
    Top = 80
  end
end
