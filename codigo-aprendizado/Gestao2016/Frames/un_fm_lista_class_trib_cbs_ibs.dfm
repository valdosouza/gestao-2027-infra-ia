inherited FmListaClassTribIbsCbs: TFmListaClassTribIbsCbs
  inherited pnl_linha_1: TPanel
    inherited Dblcb_Lista: TDBLookupComboBox
      KeyField = 'CLASSE'
      ListField = 'DESCRIPTION'
    end
  end
  inherited pnl_top: TPanel
    inherited L_name_list: TLabel
      Width = 185
      Caption = 'Lista de Classifica'#231#227'o Tribut'#225'ria - CBS'
      ExplicitWidth = 185
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      
        'SELECT distinct ec.classe, (ec.classe || '#39' - '#39' || ec.class_name)' +
        ' DESCRIPTION'
      'FROM tb_eclass ec'
      'order by ec.classe')
  end
end
