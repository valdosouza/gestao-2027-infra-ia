inherited RegGroupMenu: TRegGroupMenu
  ClientHeight = 473
  ClientWidth = 569
  ExplicitWidth = 575
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 409
    Width = 569
    ExplicitTop = 409
    ExplicitWidth = 569
    inherited SB_Inserir: TSpeedButton
      Left = -11
      ExplicitLeft = -11
    end
    inherited SB_Alterar: TSpeedButton
      Left = 89
      ExplicitLeft = 89
    end
    inherited SB_Excluir: TSpeedButton
      Left = 187
      ExplicitLeft = 187
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 367
      ExplicitLeft = 367
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 467
      ExplicitLeft = 467
    end
    inherited SB_Gravar: TSpeedButton
      Left = 281
      ExplicitLeft = 281
    end
  end
  inherited pnl_fundo: TPanel
    Width = 569
    Height = 208
    ExplicitWidth = 569
    ExplicitHeight = 208
    object Lb_Desconto: TLabel [0]
      Left = 464
      Top = 5
      Width = 89
      Height = 13
      Caption = 'Desconto Especial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Sequencia: TLabel [1]
      Left = 403
      Top = 5
      Width = 51
      Height = 14
      Caption = 'Sequ'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBRG_Composicao: TRadioGroup [4]
      Left = 8
      Top = 45
      Width = 199
      Height = 56
      Caption = 'Estoque por Composi'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'N'#227'o Utilizar este Recurso'
        'Baixar somente os Itens')
      ParentFont = False
      TabOrder = 0
      OnClick = DBRG_ComposicaoClick
    end
    object DBRG_Interface: TRadioGroup [5]
      Left = 209
      Top = 45
      Width = 212
      Height = 56
      Caption = 'Controle de Interface'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Utilizar Lista Simples'
        'Utilizar Bot'#245'es com Imagem')
      ParentFont = False
      TabOrder = 1
    end
    object DBRG_Tamanhos: TRadioGroup [6]
      Left = 423
      Top = 45
      Width = 136
      Height = 56
      Caption = 'M'#250'ltiplos Tamanhos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Sim'
        'N'#227'o')
      ParentFont = False
      TabOrder = 2
    end
    inherited ChBx_Ativo: TCheckBox
      Top = 186
      Width = 559
      TabOrder = 3
      ExplicitTop = 186
      ExplicitWidth = 559
    end
    inherited E_Codigo: TEdit
      TabOrder = 4
    end
    inherited E_Descricao: TEdit
      Width = 324
      TabOrder = 5
      ExplicitWidth = 324
    end
    object Chbx_Ifood: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 167
      Width = 559
      Height = 17
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      Caption = 'Enviar registro de Categoria para o Ifood'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object ChBx_Propag_Tamanho: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 148
      Width = 559
      Height = 17
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      Caption = 
        'Propagar a cria'#231#227'o de produtos para cada tamanho criado, incluin' +
        'do atualiza'#231#227'o de valores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object ChBx_Agrupar_Abas: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 129
      Width = 559
      Height = 17
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      Caption = 'Mostrar os subgrupos em uma aba apenas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object ChBx_show_menu: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 108
      Width = 559
      Height = 17
      Margins.Top = 1
      Align = alBottom
      Caption = 'Mostrar no Atendimento Desktop'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object E_Vl_Desconto: TEdit
      Left = 468
      Top = 21
      Width = 92
      Height = 21
      TabOrder = 10
    end
    object E_Sequencia: TEdit
      Left = 403
      Top = 21
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
  end
  inherited pnlGrid: TPanel
    Top = 208
    Width = 569
    ExplicitTop = 208
    ExplicitWidth = 569
    inherited DBGrid1: TDBGrid
      Width = 559
    end
  end
  inherited cds_subgrupo: TClientDataSet
    Left = 160
    Top = 242
  end
  inherited ds_subgrupo: TDataSource
    Left = 160
    Top = 298
  end
end
