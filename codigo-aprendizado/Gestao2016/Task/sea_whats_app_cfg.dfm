inherited SeaWhatsAppCfg: TSeaWhatsAppCfg
  Caption = 'WhastApp Configura'#231#227'o'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 15
    Height = 488
    ExplicitTop = 15
    ExplicitHeight = 488
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 875
    end
    inherited DBG_Pesquisa: TDBGrid
      Height = 470
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'C'#243'digo'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TB_INSTITUTION_ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DESCRIPTION'
          Title.Caption = 'Descri'#231#227'o'
          Width = 602
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'URL_SEND'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TOKEN'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TOKEN_AUTH'
          Visible = False
        end>
    end
    inherited pnl_pesq_right: TPanel
      Height = 470
      ExplicitHeight = 470
      inherited Sb_Sair_0: TSpeedButton
        Top = 407
        ExplicitTop = 407
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 344
        ExplicitTop = 344
      end
      inherited SB_Buscar: TSpeedButton
        Top = 281
        ExplicitTop = 281
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 218
        ExplicitTop = 218
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Height = 6
    ExplicitHeight = 6
  end
  inherited MnuBase: TMainMenu
    Left = 72
    Top = 112
    inherited arefas1: TMenuItem
      object BaixaroSendWhatsApp1: TMenuItem [0]
        Caption = 'Baixar o SendWhatsApp'
        OnClick = BaixaroSendWhatsApp1Click
      end
      object CorrigirEnvioduplicado1: TMenuItem [1]
        Caption = 'Corrigir Envio duplicado'
        OnClick = CorrigirEnvioduplicado1Click
      end
    end
  end
  inherited cds_search: TClientDataSet
    ProviderName = ''
    object cds_searchID: TIntegerField
      DisplayLabel = 'Codigo'
      DisplayWidth = 21
      FieldName = 'ID'
      Origin = '"TB_WHATSAPP_CFG"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchTB_INSTITUTION_ID: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_WHATSAPP_CFG"."TB_INSTITUTION_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cds_searchDESCRIPTION: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 116
      FieldName = 'DESCRIPTION'
      Origin = '"TB_WHATSAPP_CFG"."DESCRIPTION"'
      Size = 100
    end
    object cds_searchURL_SEND: TWideStringField
      FieldName = 'URL_SEND'
      Origin = '"TB_WHATSAPP_CFG"."URL_SEND"'
      Visible = False
      Size = 255
    end
    object cds_searchTOKEN: TWideStringField
      FieldName = 'TOKEN'
      Origin = '"TB_WHATSAPP_CFG"."TOKEN"'
      Visible = False
      Size = 255
    end
    object cds_searchTOKEN_AUTH: TWideStringField
      FieldName = 'TOKEN_AUTH'
      Origin = '"TB_WHATSAPP_CFG"."TOKEN_AUTH"'
      Visible = False
      Size = 255
    end
  end
  inherited DSP: TDataSetProvider
    Top = 152
  end
end
