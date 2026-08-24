object Fr_Info_Compra_Venda: TFr_Info_Compra_Venda
  Left = 469
  Top = 237
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'N'#250'mero do Pedido'
  ClientHeight = 94
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Fundo: TPanel
    Left = 0
    Top = 0
    Width = 303
    Height = 94
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      303
      94)
    object Label1: TLabel
      Left = 5
      Top = 4
      Width = 142
      Height = 13
      Caption = 'N'#250'mero do Pedido de Compra'
    end
    object Label2: TLabel
      Left = 151
      Top = 4
      Width = 110
      Height = 13
      Caption = 'C'#243'digo Item de Compra'
    end
    object Btn_Ok_5: TButton
      Left = 143
      Top = 63
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 0
      OnClick = Btn_Ok_5Click
    end
    object Btn_Cn_5: TButton
      Left = 222
      Top = 63
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = Btn_Cn_5Click
    end
    object chbx_Todos: TCheckBox
      Left = 5
      Top = 43
      Width = 291
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Aplicar este n'#250'mero a todos os itens do pedido de Venda'
      TabOrder = 2
    end
    object E_Nr_Pedido: TEdit
      Left = 3
      Top = 19
      Width = 142
      Height = 21
      MaxLength = 20
      TabOrder = 3
    end
    object E_Nr_Item_Pedido: TEdit
      Left = 150
      Top = 19
      Width = 145
      Height = 21
      MaxLength = 10
      TabOrder = 4
    end
  end
end
