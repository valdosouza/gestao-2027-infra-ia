inherited Fm_ListaEstados: TFm_ListaEstados
  Width = 196
  Height = 40
  ExplicitWidth = 196
  ExplicitHeight = 40
  inherited pnl_linha_1: TPanel
    Top = 17
    Width = 196
    ExplicitTop = 17
    ExplicitWidth = 196
    inherited Sb_open: TSpeedButton
      Left = 172
      OnClick = Sb_openClick
      ExplicitLeft = 172
    end
    inherited Dblcb_Lista: TDBLookupComboBox
      Width = 172
      KeyField = 'UFE_CODIGO'
      ListField = 'UFE_SIGLA'
      ExplicitWidth = 172
    end
  end
  inherited pnl_top: TPanel
    Width = 196
    Height = 17
    ExplicitWidth = 196
    ExplicitHeight = 17
    inherited L_name_list: TLabel
      Width = 39
      Caption = 'Estados'
      ExplicitWidth = 39
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      'SELECT * '
      'FROM TB_UF'
      'Order By UFE_SIGLA')
  end
end
