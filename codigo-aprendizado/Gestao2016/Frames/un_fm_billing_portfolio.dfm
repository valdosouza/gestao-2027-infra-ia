inherited FmBillingPortfolio: TFmBillingPortfolio
  Height = 42
  ParentFont = False
  ExplicitHeight = 42
  inherited pnl_linha_1: TPanel
    inherited Sb_open: TSpeedButton
      OnClick = Sb_openClick
    end
    inherited Dblcb_Lista: TDBLookupComboBox
      KeyField = 'CTR_CODIGO'
      ListField = 'CTR_DESCRICAO'
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      'SELECT * '
      'FROM TB_CARTEIRA_COBRANCA '
      'WHERE CTR_CODBCO=:CTR_CODBCO ')
  end
end
