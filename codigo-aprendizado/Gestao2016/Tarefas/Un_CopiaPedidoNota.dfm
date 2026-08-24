object Fr_CopiaPedidoNota: TFr_CopiaPedidoNota
  Left = 467
  Top = 217
  BorderIcons = [biMaximize]
  BorderStyle = bsSingle
  Caption = 'C'#243'pia de Pedidos e Notas'
  ClientHeight = 287
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_CopiaDoc: TPanel
    Left = 0
    Top = 0
    Width = 276
    Height = 287
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BorderStyle = bsSingle
    TabOrder = 0
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
    object Label1: TLabel
      Left = 6
      Top = 91
      Width = 106
      Height = 13
      Caption = 'Definir N'#250'mero Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Rg_TipoMovimentacao: TRadioGroup
      Left = 6
      Top = 3
      Width = 260
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
      Left = 6
      Top = 47
      Width = 139
      Height = 42
      Caption = 'Tipo de Documento'
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
      Width = 118
      Height = 21
      TabOrder = 2
      Text = ''
    end
    object E_Nr_Pedido: TEdit_Setes
      Left = 6
      Top = 107
      Width = 118
      Height = 21
      TabOrder = 3
      Text = ''
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 172
      Width = 262
      Height = 42
      Align = alBottom
      Caption = 'Alterar Valor Unitario de todos os itens na c'#243'pia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object Label2: TLabel
        Left = 239
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
        Left = 182
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
        Left = 82
        Top = 18
        Width = 71
        Height = 17
        Caption = 'Desconto'
        TabOrder = 2
      end
    end
    object PNL_bottom: TPanel
      Left = 2
      Top = 217
      Width = 268
      Height = 64
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 5
      object Sb_Can_CopiaDoc: TSpeedButton
        AlignWithMargins = True
        Left = 185
        Top = 5
        Width = 78
        Height = 54
        Margins.Left = 0
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
        OnClick = Sb_Can_CopiaDocClick
        ExplicitLeft = 181
        ExplicitTop = -13
      end
      object Sb_CopiaDoc: TSpeedButton
        AlignWithMargins = True
        Left = 107
        Top = 5
        Width = 78
        Height = 54
        Margins.Left = 0
        Margins.Right = 0
        Align = alRight
        Caption = 'Copiar - F5'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_CopiaDocClick
        ExplicitTop = 3
      end
    end
    inline Fm_ListaEstoques: TFm_ListaEstoques
      Left = 2
      Top = 133
      Width = 268
      Height = 36
      Align = alBottom
      TabOrder = 6
      ExplicitLeft = 2
      ExplicitTop = 133
      ExplicitWidth = 268
      inherited Label1: TLabel
        Width = 263
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 245
        ExplicitLeft = 245
      end
      inherited Dblcb_Estoque: TDBLookupComboBox
        Width = 233
        ExplicitWidth = 233
      end
      inherited ChBx_Estoques: TCheckBox
        Left = 162
        ExplicitLeft = 162
      end
    end
  end
end
