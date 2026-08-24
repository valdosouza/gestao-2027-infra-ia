inherited SeaContract: TSeaContract
  Caption = 'Pesquisa Contratos'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 63
    Height = 440
    ExplicitTop = 63
    ExplicitHeight = 440
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 116
    end
    inherited DBG_Pesquisa: TDBGrid
      Height = 422
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TB_INSTITUTION_ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TITTLE'
          Title.Caption = 'T'#237'tulo do Contrato'
          Width = 536
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KIND'
          Title.Caption = 'Tipo do Contrato'
          Width = 181
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Height = 422
      ExplicitHeight = 422
      inherited Sb_Sair_0: TSpeedButton
        Top = 359
        ExplicitTop = 359
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 296
        ExplicitTop = 296
      end
      inherited SB_Buscar: TSpeedButton
        Top = 233
        ExplicitTop = 233
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 170
        ExplicitTop = 170
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Height = 54
    ExplicitHeight = 54
    object Label1: TLabel
      Left = 4
      Top = 1
      Width = 84
      Height = 14
      Caption = 'T'#237'tulo do Contrato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 589
      Top = 1
      Width = 79
      Height = 14
      Caption = 'Tipo do Contrato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Tittle: TEdit
      Left = 4
      Top = 17
      Width = 582
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object CB_Kind: TComboBox
      Left = 589
      Top = 17
      Width = 285
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 72
    Top = 40
  end
end
