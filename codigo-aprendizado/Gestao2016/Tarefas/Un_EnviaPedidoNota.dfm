object Fr_EnviaPedidoNota: TFr_EnviaPedidoNota
  Left = 467
  Top = 217
  BorderIcons = [biMaximize]
  BorderStyle = bsSingle
  Caption = 'Envia de Pedidos e Notas'
  ClientHeight = 205
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_CopiaDoc: TPanel
    Left = 0
    Top = 0
    Width = 264
    Height = 205
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BorderStyle = bsSingle
    TabOrder = 0
    DesignSize = (
      260
      201)
    object SB_Env_CopiaDoc: TSpeedButton
      Left = 81
      Top = 126
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Enviar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Env_CopiaDocClick
      ExplicitLeft = 97
      ExplicitTop = 142
    end
    object Sb_Can_CopiaDoc: TSpeedButton
      Left = 159
      Top = 126
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Can_CopiaDocClick
      ExplicitLeft = 175
      ExplicitTop = 142
    end
    object Label4: TLabel
      Left = 146
      Top = 50
      Width = 110
      Height = 13
      Caption = 'N'#250'mero do Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Rg_TipoMovimentacao: TRadioGroup
      Left = 4
      Top = 3
      Width = 252
      Height = 42
      Caption = 'Tipo de movimenta'#231#227'o'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Compra'
        'Venda'
        'Ajuste')
      ParentFont = False
      TabOrder = 0
    end
    object Rg_TipoDoc: TRadioGroup
      Left = 4
      Top = 47
      Width = 139
      Height = 42
      Caption = 'Tipo de movimenta'#231#227'o'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Pedido'
        'N. Fiscal')
      ParentFont = False
      TabOrder = 1
      OnClick = Rg_TipoDocClick
    end
    object E_Nr_Doc: TEdit_Setes
      Left = 146
      Top = 65
      Width = 109
      Height = 21
      TabOrder = 2
      Text = ''
    end
    object GroupBox1: TGroupBox
      Left = 4
      Top = 93
      Width = 251
      Height = 42
      Caption = 'Alterar Valor Unitario de todos os itens na c'#243'pia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object Label2: TLabel
        Left = 231
        Top = 17
        Width = 14
        Height = 20
        Caption = '%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object E_Tx_Altera_Unit: TEdit_Setes
        Left = 174
        Top = 15
        Width = 53
        Height = 21
        TabOrder = 0
        Text = ''
      end
      object Rb_Acrescimo: TRadioButton
        Left = 5
        Top = 18
        Width = 71
        Height = 17
        Caption = 'Acr'#233'scimo'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object Rb_Desconto: TRadioButton
        Left = 85
        Top = 17
        Width = 71
        Height = 17
        Caption = 'Desconto'
        TabOrder = 2
      end
    end
  end
  object IBD_BancoDestino: TSTDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    Left = 40
    Top = 96
  end
  object IB_Transacao: TSTTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    DefaultDatabase = IBD_BancoDestino
    Active = False
    Left = 38
    Top = 131
  end
end
