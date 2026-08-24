inherited CfgPayBack: TCfgPayBack
  Caption = 'Configura'#231#227'o PAYBACK'
  ClientHeight = 261
  ClientWidth = 335
  ExplicitWidth = 341
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 335
    Height = 223
    ExplicitTop = -1
    ExplicitWidth = 335
    ExplicitHeight = 223
    object Label1: TLabel
      Left = 6
      Top = 1
      Width = 109
      Height = 13
      Caption = 'Taxa de PAYBACK (%)'
    end
    object Label2: TLabel
      Left = 6
      Top = 43
      Width = 132
      Height = 13
      Caption = 'Valor M'#237'nimo para Utiliza'#231#227'o'
    end
    object Label3: TLabel
      Left = 6
      Top = 90
      Width = 138
      Height = 13
      Caption = 'Titulo do Programa PAYBACK'
    end
    object Label4: TLabel
      Left = 6
      Top = 135
      Width = 82
      Height = 13
      Caption = 'Dias para Expirar'
    end
    object E_Tx_Payback: TEdit
      Left = 6
      Top = 16
      Width = 132
      Height = 21
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0,00'
    end
    object E_VL_Minimo: TEdit
      Left = 6
      Top = 62
      Width = 132
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      Text = '0,00'
    end
    object E_Titulo_Payback: TEdit
      Left = 6
      Top = 109
      Width = 307
      Height = 21
      TabOrder = 2
      Text = 'PROGRAMA PAYBACK'
    end
    object E_Dias_Expired: TEdit
      Left = 6
      Top = 150
      Width = 132
      Height = 21
      Alignment = taRightJustify
      TabOrder = 3
      Text = '0'
    end
    object Chbx_ImprimirCredito: TCheckBox
      Left = 6
      Top = 177
      Width = 283
      Height = 17
      Caption = 'Imprimir cr'#233'ditos na impress'#227'o no cupom'
      TabOrder = 4
    end
  end
  inherited Panel2: TPanel
    Top = 223
    Width = 335
    ExplicitTop = 223
    ExplicitWidth = 335
    inherited Btn_Ok_12: TButton
      Left = 30
      ExplicitLeft = 30
    end
    inherited Btn_Cn_12: TButton
      Left = 130
      ExplicitLeft = 130
    end
    inherited Btn_AP_12: TButton
      Left = 230
      ExplicitLeft = 230
    end
  end
  inherited MnuBase: TMainMenu
    Left = 376
  end
end
