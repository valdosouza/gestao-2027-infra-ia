inherited TasNfeItensFuel: TTasNfeItensFuel
  BorderIcons = [biSystemMenu]
  Caption = 'Dados sobre combustivel'
  ClientHeight = 127
  ClientWidth = 485
  ExplicitWidth = 491
  ExplicitHeight = 176
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Fundo: TPanel [0]
    Left = 0
    Top = 0
    Width = 485
    Height = 63
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 2
      Width = 61
      Height = 13
      Caption = 'Produto ANP'
    end
    object Label2: TLabel
      Left = 132
      Top = 2
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 399
      Top = 2
      Width = 40
      Height = 13
      Caption = 'UF Cons'
    end
    object Label4: TLabel
      Left = 324
      Top = 2
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object E_CodANP: TEdit
      Left = 5
      Top = 18
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object E_Description: TEdit
      Left = 132
      Top = 18
      Width = 189
      Height = 21
      TabOrder = 1
    end
    object DBLCB_UF: TDBLookupComboBox
      Left = 399
      Top = 18
      Width = 76
      Height = 21
      KeyField = 'UFE_SIGLA'
      ListField = 'UFE_SIGLA'
      ListSource = DM.Ds_UF
      TabOrder = 3
    end
    object E_Qtde: TEdit
      Left = 324
      Top = 18
      Width = 69
      Height = 21
      TabOrder = 2
    end
  end
  object pnl_botao: TPanel [1]
    Left = 0
    Top = 63
    Width = 485
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 378
      Top = 5
      Width = 102
      Height = 54
      Align = alRight
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 696
      ExplicitTop = 6
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 270
      Top = 5
      Width = 102
      Height = 54
      Align = alRight
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GravarClick
      ExplicitLeft = 594
      ExplicitTop = 6
    end
    object SB_Excluir: TSpeedButton
      Left = 165
      Top = 2
      Width = 102
      Height = 60
      Align = alRight
      Caption = 'Excluir - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ExcluirClick
      ExplicitLeft = 95
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
end
