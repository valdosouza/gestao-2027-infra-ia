inherited RegReceipt: TRegReceipt
  Caption = 'Cadastro de Recibo'
  ClientHeight = 304
  ClientWidth = 698
  ExplicitWidth = 704
  ExplicitHeight = 353
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 244
    Width = 698
    Height = 60
    ExplicitTop = 244
    ExplicitWidth = 698
    ExplicitHeight = 60
    inherited SB_Inserir: TSpeedButton
      Left = -4
      Height = 50
      ExplicitLeft = 21
      ExplicitHeight = 50
    end
    inherited SB_Alterar: TSpeedButton
      Left = 100
      Height = 50
      ExplicitLeft = 125
      ExplicitHeight = 50
    end
    inherited SB_Excluir: TSpeedButton
      Left = 204
      Height = 50
      ExplicitLeft = 229
      ExplicitHeight = 50
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 412
      Height = 50
      ExplicitLeft = 437
      ExplicitHeight = 50
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 591
      Height = 50
      ExplicitLeft = 541
      ExplicitHeight = 50
    end
    inherited SB_Gravar: TSpeedButton
      Left = 308
      Height = 50
      ExplicitLeft = 333
      ExplicitHeight = 50
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 515
      Top = 5
      Width = 75
      Height = 50
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Imprimir - F11'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitLeft = 489
      ExplicitTop = 4
    end
  end
  inherited pnl_fundo: TPanel
    Width = 698
    Height = 244
    ExplicitWidth = 698
    ExplicitHeight = 244
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 694
      Height = 240
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Numero: TLabel
        Left = 4
        Top = 3
        Width = 48
        Height = 14
        Caption = 'N'#186' Recibo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Data: TLabel
        Left = 222
        Top = 5
        Width = 22
        Height = 14
        Caption = 'Data'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Emitente: TLabel
        Left = 7
        Top = 176
        Width = 96
        Height = 14
        Caption = 'Assinatura Emitente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Vl_Recibo: TLabel
        Left = 123
        Top = 3
        Width = 25
        Height = 14
        Caption = 'Valor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Sacado: TLabel
        Left = 5
        Top = 43
        Width = 55
        Height = 14
        Caption = 'Sacado de '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Referencia: TLabel
        Left = 5
        Top = 84
        Width = 57
        Height = 14
        Caption = 'Referente '#224
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Numero: TEdit
        Left = 4
        Top = 18
        Width = 113
        Height = 21
        TabOrder = 0
      end
      object E_Vl_Recibo: TEdit
        Left = 119
        Top = 18
        Width = 99
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
        OnExit = E_Vl_ReciboExit
      end
      object E_Emitente: TEdit
        Left = 4
        Top = 193
        Width = 677
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 5
      end
      object E_Sacado: TEdit
        Left = 4
        Top = 58
        Width = 677
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 3
      end
      object E_Referencia: TMemo
        Left = 4
        Top = 97
        Width = 677
        Height = 77
        TabOrder = 4
      end
      object E_Data: TDateTimePicker
        Left = 219
        Top = 18
        Width = 93
        Height = 22
        Date = 40527.438675127320000000
        Time = 40527.438675127320000000
        TabOrder = 2
      end
    end
  end
end
