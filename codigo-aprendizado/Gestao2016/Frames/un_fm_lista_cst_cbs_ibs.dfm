inherited FmListaCstCbsIbs: TFmListaCstCbsIbs
  inherited pnl_linha_1: TPanel
    inherited Dblcb_Lista: TDBLookupComboBox
      KeyField = 'CST'
      ListField = 'DESCRIPTION'
    end
  end
  inherited pnl_top: TPanel
    inherited L_name_list: TLabel
      Width = 488
      Height = 16
      Caption = 'Lista CST - CBS'
      ExplicitWidth = 77
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      
        'SELECT distinct ec.cst, (ec.cst || '#39' - '#39' || ec.cst_description) ' +
        'Description'
      'FROM tb_eclass ec'
      'order by ec.cst')
  end
end
