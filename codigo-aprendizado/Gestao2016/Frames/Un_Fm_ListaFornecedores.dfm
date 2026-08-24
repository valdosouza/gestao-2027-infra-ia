inherited Fm_ListaFornecedores: TFm_ListaFornecedores
  Width = 442
  ExplicitWidth = 442
  inherited pnl_01: TPanel
    Width = 442
    ExplicitWidth = 442
    inherited ChBx_Nome: TCheckBox
      Left = 87
      ExplicitLeft = 87
    end
    inherited ChBx_Fantasia: TCheckBox
      Left = 213
      ExplicitLeft = 213
      ExplicitTop = 3
    end
  end
  inherited pnl_02: TPanel
    Width = 442
    ExplicitWidth = 442
    inherited Sb_Pesq_Empresa: TSpeedButton
      Left = 414
      ExplicitLeft = 415
      ExplicitTop = 1
      ExplicitHeight = 23
    end
    inherited SB_Empresas: TSpeedButton
      Left = 389
      ExplicitLeft = 389
    end
    inherited DBLCB_Empresa: TDBLookupComboBox
      Width = 321
      ListSource = Ds_ListaEmpresa
      ExplicitWidth = 321
    end
  end
  object Qr_ListaEmpresa: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_EMAIL,'
      '  EMP_CODVDOR,'
      '  EMP_MULTIPLICADOR,'
      '  EMP_DT_CADASTRO,'
      '  EMP_VL_CRED,'
      '  EMP_FORMDATA,'
      '  EMP_FORMDATA_E,'
      '  EMP_FORMDATA_C'
      'FROM TB_EMPRESA'
      'ORDER BY EMP_NOME')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 1
    Top = 51
  end
  object Ds_ListaEmpresa: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaEmpresa
    Left = 108
    Top = 47
  end
end
