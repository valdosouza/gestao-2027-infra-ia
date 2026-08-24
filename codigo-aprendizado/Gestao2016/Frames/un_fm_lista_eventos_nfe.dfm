inherited FmListaEventosNfe: TFmListaEventosNfe
  inherited pnl_linha_1: TPanel
    inherited Sb_open: TSpeedButton
      Visible = False
    end
    inherited Dblcb_Lista: TDBLookupComboBox
      KeyField = 'NVT_CODIGO'
      ListField = 'NVT_DESCRICAO'
      ExplicitTop = 3
    end
  end
  inherited pnl_top: TPanel
    inherited L_name_list: TLabel
      Width = 488
      Height = 16
      Caption = 'Informe o tipo do evento'
      ExplicitWidth = 116
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      'SELECT *'
      'FROM TB_NFE_EVENTO'
      'ORDER BY NVT_DESCRICAO')
  end
end
