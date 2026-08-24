inherited Fm_lista_cfop: TFm_lista_cfop
  Height = 44
  ExplicitHeight = 44
  inherited pnl_linha_1: TPanel
    inherited Sb_open: TSpeedButton
      OnClick = Sb_openClick
    end
    inherited Dblcb_Lista: TDBLookupComboBox
      KeyField = 'NAT_CODIGO'
      ListField = 'CFOP'
    end
  end
  inherited pnl_top: TPanel
    inherited L_name_list: TLabel
      Left = 23
      Width = 144
      Margins.Left = 0
      Caption = 'Informe o C.F.O.P. - Descri'#231#227'o'
      ExplicitLeft = 23
      ExplicitWidth = 144
    end
    object Chbx_cfop: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 1
      Width = 17
      Height = 18
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alLeft
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = Chbx_cfopClick
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      'SELECT '
      'NAT_CODIGO,'
      'NAT_CFOP,'
      'NAT_DESCRICAO,'
      'NAT_CFOP || '#39' - '#39' || NAT_DESCRICAO CFOP,'
      'NAT_RESUMIDO'
      'FROM TB_NATUREZA'
      'WHERE NAT_ATIVO = '#39'S'#39
      '  AND NAT_SENTIDO =:NAT_SENTIDO'
      '  AND NAT_ALCADA=:NAT_ALCADA'
      'ORDER BY NAT_CFOP')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NAT_SENTIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NAT_ALCADA'
        ParamType = ptUnknown
      end>
  end
end
