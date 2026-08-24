inherited Fm_ListaClientes: TFm_ListaClientes
  Width = 539
  ExplicitWidth = 539
  inherited pnl_01: TPanel
    Width = 539
    ExplicitWidth = 539
    inherited ChBx_Nome: TCheckBox
      Left = 42
      ExplicitLeft = 42
      ExplicitTop = 1
      ExplicitHeight = 14
    end
    inherited ChBx_Fantasia: TCheckBox
      Left = 168
      ExplicitLeft = 168
      ExplicitHeight = 14
    end
  end
  inherited pnl_02: TPanel
    Width = 539
    ExplicitWidth = 539
    inherited Sb_Pesq_Empresa: TSpeedButton
      Left = 511
      ExplicitLeft = 513
      ExplicitHeight = 23
    end
    inherited SB_Empresas: TSpeedButton
      Left = 486
      ExplicitLeft = 488
      ExplicitHeight = 23
    end
    inherited E_Cd_Empresa: TMaskEdit
      ExplicitLeft = 1
      ExplicitTop = 1
    end
    inherited DBLCB_Empresa: TDBLookupComboBox
      Width = 418
      ListSource = Ds_ListaEmpresa
      ExplicitLeft = 66
      ExplicitTop = 1
      ExplicitWidth = 418
    end
  end
  object Qr_ListaEmpresa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
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
    Left = 111
    Top = 51
  end
  object Ds_ListaEmpresa: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaEmpresa
    Left = 218
    Top = 47
  end
end
