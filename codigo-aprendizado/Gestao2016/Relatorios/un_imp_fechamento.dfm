inherited Fr_Imp_Fechamento: TFr_Imp_Fechamento
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Fechamentos'
  ClientHeight = 254
  ClientWidth = 568
  ExplicitWidth = 574
  ExplicitHeight = 303
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel [0]
    Left = 0
    Top = 189
    Width = 568
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      568
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 483
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 529
    end
    object SB_Imprimir: TSpeedButton
      Left = 414
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Imprimir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
    end
    object Sb_Exportar: TSpeedButton
      Left = 330
      Top = 6
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Exportar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Visible = False
      ExplicitLeft = 157
    end
  end
  object Pnl_Parametro: TPanel [1]
    Left = 192
    Top = 0
    Width = 376
    Height = 189
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    inline Fm_Usuario: TFm_ListaUsuarios
      Left = 2
      Top = 47
      Width = 372
      Height = 38
      Align = alTop
      TabOrder = 0
      Visible = False
      ExplicitLeft = 2
      ExplicitTop = 47
      ExplicitWidth = 372
      ExplicitHeight = 38
      inherited Label19: TLabel
        Width = 37
        Caption = 'Usu'#225'rio'
        ExplicitWidth = 37
      end
      inherited Sb_Medida: TSpeedButton
        Left = 342
        ExplicitLeft = 342
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 340
        ExplicitWidth = 340
      end
      inherited Qr_Lista: TSTQuery
        Top = 47
      end
      inherited DS_Lista: TDataSource
        Left = 124
        Top = 50
      end
    end
    object Pnl_Data: TPanel
      Left = 2
      Top = 2
      Width = 372
      Height = 45
      Align = alTop
      TabOrder = 1
      object ChBx_Periodo: TCheckBox
        Left = 6
        Top = 5
        Width = 178
        Height = 12
        Caption = 'Data Inicial         Data Final'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object E_Data_Ini: TDateTimePicker
        Left = 5
        Top = 19
        Width = 92
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object E_Data_Fim: TDateTimePicker
        Left = 100
        Top = 19
        Width = 92
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 2
      end
    end
    inline Fm_Vendedor: TFm_ListaColaboradores
      Left = 2
      Top = 85
      Width = 372
      Height = 37
      Align = alTop
      TabOrder = 2
      ExplicitLeft = 2
      ExplicitTop = 85
      ExplicitWidth = 372
      ExplicitHeight = 37
      inherited Label19: TLabel
        Width = 372
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 346
        Height = 20
        ExplicitLeft = 342
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 340
        ExplicitWidth = 340
      end
      inherited Qr_ListaVendedor: TSTQuery
        Top = 41
      end
      inherited DS_ListaVendedor: TDataSource
        Top = 38
      end
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 192
    Height = 189
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label4: TLabel
      Left = 4
      Top = 3
      Width = 80
      Height = 14
      Caption = 'Tipo de Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LBx_TipoRelatorio: TListBox
      Left = 2
      Top = 19
      Width = 188
      Height = 168
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        'VENDAS / FORMA DE PAGAMENTO'
        'MOVIMENTO / FORMA DE PAGAMENTO'
        'BANDEIRAS TEF')
      TabOrder = 0
      OnClick = LBx_TipoRelatorioClick
    end
  end
  inherited MnuBase: TMainMenu
    Left = 384
    Top = 0
  end
end
