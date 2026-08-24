inherited Fr_Baixa_Dup_Desc: TFr_Baixa_Dup_Desc
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa de Duplicatas Descontadas'
  ClientHeight = 159
  ClientWidth = 519
  ExplicitWidth = 525
  ExplicitHeight = 207
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel [0]
    Left = 0
    Top = 0
    Width = 519
    Height = 91
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      519
      91)
    object Label10: TLabel
      Left = 7
      Top = 4
      Width = 51
      Height = 14
      Caption = 'N'#186' Parcela'
      FocusControl = E_N_Parcela
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 108
      Top = 4
      Width = 25
      Height = 14
      Caption = 'Valor'
      FocusControl = E_Vl_Pagar
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 414
      Top = 4
      Width = 56
      Height = 14
      Caption = 'Vencimento'
      FocusControl = E_Vencimento
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 8
      Top = 44
      Width = 27
      Height = 14
      Caption = 'Juros'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 212
      Top = 47
      Width = 46
      Height = 14
      Caption = 'Desconto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 415
      Top = 45
      Width = 52
      Height = 14
      Caption = 'Valor Pago'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 313
      Top = 44
      Width = 52
      Height = 14
      Caption = 'Data Pagto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 111
      Top = 44
      Width = 24
      Height = 14
      Caption = 'Mora'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_N_Parcela: TEdit_Setes
      Left = 6
      Top = 20
      Width = 100
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 4
      Text = ''
    end
    object E_Vl_Pagar: TEdit_Setes
      Left = 108
      Top = 20
      Width = 100
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 5
      Text = ''
    end
    object E_Vencimento: TEdit_Setes
      Left = 415
      Top = 20
      Width = 100
      Height = 21
      TabStop = False
      Alignment = taCenter
      MaxLength = 10
      ReadOnly = True
      TabOrder = 6
      Text = ''
    end
    object E_Valor_Pago: TEdit_Setes
      Left = 415
      Top = 60
      Width = 100
      Height = 21
      Alignment = taRightJustify
      TabOrder = 3
      Text = '0,00'
    end
    object E_Juros: TEdit_Setes
      Left = 7
      Top = 60
      Width = 100
      Height = 21
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0,00'
      OnExit = E_JurosExit
    end
    object E_Mora: TEdit_Setes
      Left = 108
      Top = 60
      Width = 100
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      Text = '0,00'
      OnExit = E_MoraExit
    end
    object E_Desconto: TEdit_Setes
      Left = 209
      Top = 60
      Width = 100
      Height = 21
      Alignment = taRightJustify
      TabOrder = 2
      Text = '0,00'
      OnExit = E_DescontoExit
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 207
      Top = 3
      Width = 206
      Height = 42
      TabOrder = 7
      ExplicitLeft = 207
      ExplicitTop = 3
      ExplicitWidth = 206
      ExplicitHeight = 42
      inherited Lb_FormaPagamento: TLabel
        Width = 200
      end
      inherited pnl_Forma: TPanel
        Width = 206
        Height = 28
        ExplicitWidth = 206
        ExplicitHeight = 28
        inherited SB_FormaPag: TSpeedButton
          Left = 180
          Height = 25
          ExplicitLeft = 209
          ExplicitTop = 17
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 171
          DropDownRows = 0
          ReadOnly = True
          TabStop = False
          ExplicitWidth = 200
        end
      end
    end
    object E_Data_Pagto: TDateTimePicker
      Left = 310
      Top = 60
      Width = 105
      Height = 22
      Anchors = [akTop, akRight]
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 8
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 91
    Width = 519
    Height = 68
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      519
      68)
    object Sb_Sair_0: TSpeedButton
      Left = 427
      Top = 6
      Width = 88
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
      ExplicitLeft = 371
    end
    object SB_Confirmar: TSpeedButton
      Left = 338
      Top = 6
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Confirma - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 282
    end
  end
  inherited MnuBase: TMainMenu
    Left = 72
    Top = 56
  end
end
