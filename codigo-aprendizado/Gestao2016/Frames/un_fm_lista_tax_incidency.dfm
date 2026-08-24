inherited FmListaTaxIncidency: TFmListaTaxIncidency
  inherited pnl_linha_1: TPanel
    inherited Dblcb_Lista: TDBLookupComboBox
      KeyField = 'ID'
      ListField = 'DESCRIPTION'
    end
  end
  inherited pnl_top: TPanel
    inherited L_name_list: TLabel
      Width = 488
      Height = 16
      Caption = 'Incid'#234'ncia de Impostos'
      ExplicitWidth = 109
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tb_taxes_incidency'
      'ORDER BY KIND')
  end
  inherited IBT_Listas: TSTTransaction
    Active = True
  end
end
