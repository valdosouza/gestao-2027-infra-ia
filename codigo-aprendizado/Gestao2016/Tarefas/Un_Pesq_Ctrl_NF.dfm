inherited Fr_Pesq_Ctrl_NF: TFr_Pesq_Ctrl_NF
  Caption = 'Controle de Sequencia de Notas Fiscais'
  ClientHeight = 539
  ClientWidth = 893
  ExplicitWidth = 899
  ExplicitHeight = 588
  PixelsPerInch = 96
  TextHeight = 13
  inherited GrB_Parametros: TGroupBox
    Width = 893
    ExplicitWidth = 893
    object Label1: TLabel
      Left = 639
      Top = 12
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 723
      Top = 12
      Width = 47
      Height = 14
      Caption = 'Data Final'
    end
    object Rg_Modelo: TRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 19
      Width = 206
      Height = 57
      Align = alLeft
      Caption = 'Modelos de Notas'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'NF-e Pr'#243'pria'
        'Nf-e Terceiro'
        'NFC-e'
        'Nota Bloco A1')
      TabOrder = 0
    end
    object Rg_Situacao: TRadioGroup
      AlignWithMargins = True
      Left = 217
      Top = 19
      Width = 262
      Height = 57
      Align = alLeft
      Caption = 'Situa'#231#227'o Nota Fiscal Eletr'#244'nica'
      Columns = 3
      ItemIndex = 5
      Items.Strings = (
        'Pendente'
        'Autorizadas'
        'Canceladas'
        'Inutilizada'
        'Denegada'
        'Todas')
      TabOrder = 1
    end
    object E_Data_Ini: TDateTimePicker
      Left = 638
      Top = 26
      Width = 81
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_Data_Fim: TDateTimePicker
      Left = 720
      Top = 26
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object Rg_MostrarChave: TRadioGroup
      AlignWithMargins = True
      Left = 485
      Top = 19
      Width = 148
      Height = 57
      Align = alLeft
      Caption = 'Mostrar chaves de acesso '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'SIM'
        'Todos'
        'N'#195#402'O')
      TabOrder = 4
    end
  end
  inherited Pnl_Resultado: TPanel
    Width = 893
    Height = 458
    ExplicitWidth = 893
    ExplicitHeight = 458
    inherited Grd_Pesquisa: TStringGrid
      Width = 788
      Height = 440
      ExplicitWidth = 788
      ExplicitHeight = 440
    end
    inherited pnl_botao: TPanel
      Left = 790
      Height = 440
      ExplicitLeft = 790
      ExplicitHeight = 440
      inherited Sb_Sair: TSpeedButton
        Top = 385
        ExplicitLeft = 734
        ExplicitTop = 399
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 330
        ExplicitLeft = 734
        ExplicitTop = 345
      end
      inherited SB_Buscar: TSpeedButton
        Top = 275
        ExplicitLeft = 734
        ExplicitTop = 291
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 220
        Visible = False
        ExplicitLeft = 734
        ExplicitTop = 237
      end
    end
  end
  inherited MnuBase: TMainMenu
    inherited arefas1: TMenuItem
      object ProcessarNFeprpria1: TMenuItem [0]
        Caption = 'Processar NF-e pr'#243'pria'
        OnClick = ProcessarNFeprpria1Click
      end
      object ProcessarNFeTerceiro1: TMenuItem [1]
        Caption = 'Processar NF-e Terceiro'
        OnClick = ProcessarNFeTerceiro1Click
      end
      object ProcessarNFCe1: TMenuItem [2]
        Caption = 'Processar NFC-e'
        OnClick = ProcessarNFCe1Click
      end
      object ProcessarNotaBlocoA11: TMenuItem [3]
        Caption = 'Processar Nota Bloco A1'
        OnClick = ProcessarNotaBlocoA11Click
      end
      object ApagarRegistrosparanovoProcessamento1: TMenuItem [4]
        Caption = 'Apagar registros para novo Processamento'
        OnClick = ApagarRegistrosparanovoProcessamento1Click
      end
    end
  end
  inherited Qr_Pesquisa: TSTQuery
    SQL.Strings = (
      'select'
      '  n.CD_EMISSOR,'
      '  e.EMP_NOME,'
      '  n.NUMERO,'
      '  n.MODELO ,'
      '  n.SERIE,'
      '  n.DT_RECORD,'
      '  n.TB_NOTA_FISCAL_ID,'
      '  n.CHAVE,'
      '  n.CD_SITUACAO,'
      '  n.OBSERVACAO,'
      '  n.tb_institution_id'
      'from TB_CTRL_NF n'
      '  inner join tb_empresa e'
      ' on (e.EMP_CODIGO = n.CD_EMISSOR)')
    object Qr_PesquisaCD_EMISSOR: TIntegerField
      Tag = -1
      FieldName = 'CD_EMISSOR'
      Origin = '"TB_CTRL_NF"."CD_EMISSOR"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PesquisaEMP_NOME: TStringField
      Tag = 200
      DisplayLabel = 'Emissor Nota'
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_PesquisaNUMERO: TStringField
      Tag = 70
      DisplayLabel = 'N'#186' Nota'
      FieldName = 'NUMERO'
      Origin = '"TB_CTRL_NF"."NUMERO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 10
    end
    object Qr_PesquisaMODELO: TStringField
      Tag = 60
      DisplayLabel = 'Modelo'
      FieldName = 'MODELO'
      Origin = '"TB_CTRL_NF"."MODELO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object Qr_PesquisaSERIE: TStringField
      Tag = 60
      DisplayLabel = 'S'#233'rie'
      FieldName = 'SERIE'
      Origin = '"TB_CTRL_NF"."SERIE"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object Qr_PesquisaDT_RECORD: TDateField
      Tag = 80
      DisplayLabel = 'Data'
      FieldName = 'DT_RECORD'
      Origin = '"TB_CTRL_NF"."DT_RECORD"'
    end
    object Qr_PesquisaTB_NOTA_FISCA_ID: TIntegerField
      Tag = -1
      FieldName = 'TB_NOTA_FISCAL_ID'
      Origin = '"TB_CTRL_NF"."TB_NOTA_FISCA_ID"'
      MinValue = -1
    end
    object Qr_PesquisaCHAVE: TStringField
      Tag = 300
      DisplayLabel = 'Chave de Acesso'
      FieldName = 'CHAVE'
      Origin = '"TB_CTRL_NF"."CHAVE"'
      Size = 50
    end
    object Qr_PesquisaCD_SITUACAO: TIntegerField
      Tag = -1
      FieldName = 'CD_SITUACAO'
      Origin = '"TB_CTRL_NF"."CD_SITUACAO"'
    end
    object Qr_PesquisaOBSERVACAO: TStringField
      Tag = 300
      FieldName = 'OBSERVACAO'
      Origin = '"TB_CTRL_NF"."OBSERVACAO"'
      Size = 100
    end
    object Qr_PesquisaTB_INSTITUTION_ID: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_CTRL_NF"."TB_INSTITUTION_ID"'
      Required = True
    end
  end
  object Qr_aux: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      '')
    Left = 120
    Top = 136
    object IntegerField1: TIntegerField
      Tag = -1
      FieldName = 'CD_EMISSOR'
      Origin = '"TB_CTRL_NF"."CD_EMISSOR"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IBStringField1: TStringField
      Tag = 200
      DisplayLabel = 'Emissor Nota'
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object IBStringField2: TStringField
      Tag = 70
      DisplayLabel = 'N'#186' Nota'
      FieldName = 'NUMERO'
      Origin = '"TB_CTRL_NF"."NUMERO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 10
    end
    object IBStringField3: TStringField
      Tag = 60
      DisplayLabel = 'Modelo'
      FieldName = 'MODELO'
      Origin = '"TB_CTRL_NF"."MODELO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object IBStringField4: TStringField
      Tag = 60
      DisplayLabel = 'S'#233'rie'
      FieldName = 'SERIE'
      Origin = '"TB_CTRL_NF"."SERIE"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object DateField1: TDateField
      Tag = 80
      DisplayLabel = 'Data'
      FieldName = 'DT_RECORD'
      Origin = '"TB_CTRL_NF"."DT_RECORD"'
    end
    object IntegerField2: TIntegerField
      Tag = -1
      FieldName = 'TB_NOTA_FISCAL_ID'
      Origin = '"TB_CTRL_NF"."TB_NOTA_FISCA_ID"'
      MinValue = -1
    end
    object IBStringField5: TStringField
      Tag = 300
      DisplayLabel = 'Chave de Acesso'
      FieldName = 'CHAVE'
      Origin = '"TB_CTRL_NF"."CHAVE"'
      Size = 50
    end
    object IntegerField3: TIntegerField
      Tag = -1
      FieldName = 'CD_SITUACAO'
      Origin = '"TB_CTRL_NF"."CD_SITUACAO"'
    end
    object IBStringField6: TStringField
      Tag = 300
      FieldName = 'OBSERVACAO'
      Origin = '"TB_CTRL_NF"."OBSERVACAO"'
      Size = 100
    end
    object IntegerField4: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_CTRL_NF"."TB_INSTITUTION_ID"'
      Required = True
    end
  end
end
