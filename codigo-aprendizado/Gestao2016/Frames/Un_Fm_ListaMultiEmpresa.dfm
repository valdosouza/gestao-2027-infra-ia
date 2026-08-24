inherited Fm_ListaMultiEmpresa: TFm_ListaMultiEmpresa
  Width = 555
  ExplicitWidth = 555
  inherited pnl_linha_1: TPanel
    Width = 555
    ExplicitWidth = 555
    inherited Sb_open: TSpeedButton
      Left = 531
      Visible = False
      ExplicitLeft = 531
    end
    inherited Dblcb_Lista: TDBLookupComboBox
      Width = 531
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_FANTASIA'
      ExplicitWidth = 531
    end
  end
  inherited pnl_top: TPanel
    Width = 555
    TabOrder = 2
    ExplicitWidth = 555
    inherited L_name_list: TLabel
      Left = 20
      Width = 147
      Margins.Left = 20
      Caption = 'Selecionar todas as Empresas'
      ExplicitLeft = 20
      ExplicitWidth = 147
    end
  end
  object chbx_Empresas: TCheckBox [2]
    Left = 3
    Top = 3
    Width = 15
    Height = 14
    TabOrder = 1
    OnClick = chbx_EmpresasClick
  end
  inherited Ds_Lista: TDataSource
    Left = 89
  end
  inherited Qr_Lista: TSTQuery
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT'
      'EMP_CODIGO,'
      'EMP_NOME,'
      'EMP_FANTASIA,'
      'EMP_CODVDOR,'
      'EMP_DT_FUNDA,'
      'EMP_MULTIPLICADOR,'
      'EMP_CONSUMIDOR'
      'FROM TB_EMPRESA'
      'WHERE (EMP_ATIVA = '#39'S'#39') and (EMP_TIPO = '#39'0'#39')')
    Left = 41
  end
end
