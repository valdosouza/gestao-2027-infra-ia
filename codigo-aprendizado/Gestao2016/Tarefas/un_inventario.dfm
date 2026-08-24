inherited Fr_Inventario: TFr_Inventario
  BorderIcons = [biSystemMenu]
  Caption = 'Invent'#225'rio - Recontagem do Estoque'
  ClientHeight = 298
  ClientWidth = 516
  ExplicitWidth = 522
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel [0]
    Left = 0
    Top = 0
    Width = 516
    Height = 231
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 106
    object Label1: TLabel
      Left = 9
      Top = 47
      Width = 91
      Height = 13
      Caption = 'Data do Invent'#225'rio'
    end
    object Label2: TLabel
      Left = 8
      Top = 3
      Width = 51
      Height = 13
      Caption = 'Data Inicio'
    end
    object Label3: TLabel
      Left = 108
      Top = 4
      Width = 51
      Height = 13
      Caption = 'Data  Final'
    end
    object E_Data: TDateTimePicker
      Left = 7
      Top = 62
      Width = 106
      Height = 22
      Date = 39580.000000000000000000
      Time = 39580.000000000000000000
      TabOrder = 3
    end
    inline Fm_ListaEstoques: TFm_ListaEstoques
      Left = 206
      Top = 5
      Width = 286
      Height = 36
      TabOrder = 2
      TabStop = True
      ExplicitLeft = 206
      ExplicitTop = 5
      ExplicitWidth = 286
      inherited Label1: TLabel
        Width = 281
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 263
        ExplicitLeft = 263
      end
      inherited Dblcb_Estoque: TDBLookupComboBox
        Width = 251
        ExplicitWidth = 251
      end
      inherited ChBx_Estoques: TCheckBox
        Left = 180
        Visible = False
        OnClick = nil
        ExplicitLeft = 180
      end
      inherited Qr_Estoques: TSTQuery
        Left = 55
      end
    end
    object E_Data_Ini: TDateTimePicker
      Left = 6
      Top = 19
      Width = 95
      Height = 22
      Date = 39580.000000000000000000
      Time = 39580.000000000000000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 108
      Top = 19
      Width = 95
      Height = 22
      Date = 39580.999988425930000000
      Time = 39580.999988425930000000
      TabOrder = 1
    end
  end
  object pnl_botao: TPanel [1]
    Left = 0
    Top = 231
    Width = 516
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 106
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 326
      Top = 5
      Width = 90
      Height = 57
      Align = alRight
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 489
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 422
      Top = 5
      Width = 89
      Height = 57
      Align = alRight
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
    object Pnl_Progresso: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 301
      Height = 43
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object Gg_Progresso: TGauge
        Left = 0
        Top = 0
        Width = 301
        Height = 23
        Align = alTop
        Progress = 0
        ExplicitTop = 1
        ExplicitWidth = 480
      end
      object Lb_Processamento: TLabel
        Left = 3
        Top = 26
        Width = 84
        Height = 14
        Caption = 'Processamento...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 488
    Top = 16
  end
end
