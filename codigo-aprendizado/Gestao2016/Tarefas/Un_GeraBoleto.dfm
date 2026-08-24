object Fr_GeraBoleto: TFr_GeraBoleto
  Left = 413
  Top = 190
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gera'#231#227'o de Boleto '
  ClientHeight = 249
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 768
    Height = 183
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 4
      Width = 187
      Height = 14
      Caption = 'Conta Banc'#225'ria - Carteira de Cobran'#231'a'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 42
      Width = 90
      Height = 14
      Caption = 'Instru'#231#227'o adicional'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_BoletoEletronico: TSpeedButton
      Left = 738
      Top = 17
      Width = 24
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_BoletoEletronicoClick
    end
    object Label13: TLabel
      Left = 110
      Top = 139
      Width = 72
      Height = 14
      Caption = 'Protestar T'#237'tulo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 495
      Top = 139
      Width = 55
      Height = 14
      Caption = 'Valor Tarifa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label_1: TLabel
      Left = 269
      Top = 139
      Width = 38
      Height = 14
      Caption = 'Nr Dias '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 335
      Top = 139
      Width = 46
      Height = 14
      Caption = 'Negativar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 429
      Top = 139
      Width = 38
      Height = 14
      Caption = 'Nr Dias '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object MM_Instrucoes: TMemo
      Left = 7
      Top = 57
      Width = 402
      Height = 80
      TabOrder = 0
    end
    object RG_Aceite: TRadioGroup
      Left = 6
      Top = 139
      Width = 99
      Height = 35
      Caption = 'Aceite'
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'SIM'
        'N'#195#402'O')
      ParentFont = False
      TabOrder = 2
    end
    object Cb_Protesto: TComboBox
      Left = 110
      Top = 153
      Width = 158
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = '0 -  Sem instru'#231#227'o'
      Items.Strings = (
        '0 -  Sem instru'#231#227'o'
        '1 - Protestar (Dias Corridos)'
        '2 - Protestar (Dias '#218'teis)'
        '3 - N'#227'o protestar')
    end
    object E_VL_Tarifa: TEdit_Setes
      Left = 494
      Top = 153
      Width = 85
      Height = 21
      Alignment = taRightJustify
      TabOrder = 7
      Text = ''
    end
    object GroupBox1: TGroupBox
      Left = 412
      Top = 43
      Width = 354
      Height = 94
      Caption = 'Instru'#231#245'es para pagamento'
      TabOrder = 1
      object Label11: TLabel
        Left = 264
        Top = 15
        Width = 46
        Height = 14
        Caption = 'Multa (%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 6
        Top = 14
        Width = 71
        Height = 14
        Caption = 'Juros /M'#234's(%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 91
        Top = 14
        Width = 63
        Height = 14
        Caption = 'Mora/Dia (%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 7
        Top = 51
        Width = 67
        Height = 14
        Caption = 'Desconto (%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 178
        Top = 14
        Width = 59
        Height = 14
        Caption = 'Mora M'#237'nima'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Tx_Multa: TEdit_Setes
        Left = 263
        Top = 29
        Width = 85
        Height = 21
        Alignment = taRightJustify
        TabOrder = 3
        Text = ''
      end
      object E_Tx_Juros: TEdit_Setes
        Left = 3
        Top = 29
        Width = 85
        Height = 21
        Alignment = taRightJustify
        TabOrder = 0
        Text = ''
      end
      object E_Tx_Mora: TEdit_Setes
        Left = 89
        Top = 29
        Width = 85
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
        Text = ''
      end
      object E_Tx_Descontos: TEdit_Setes
        Left = 3
        Top = 66
        Width = 85
        Height = 21
        Alignment = taRightJustify
        TabOrder = 4
        Text = ''
      end
      object E_VL_MORA_MIN: TEdit_Setes
        Left = 176
        Top = 29
        Width = 85
        Height = 21
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 2
        Text = ''
      end
      object E_Dt_Venc_Ate: TDateTimePicker
        Left = 91
        Top = 66
        Width = 89
        Height = 21
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 5
      end
      object ChBx_Desc_Ate: TCheckBox
        Left = 91
        Top = 52
        Width = 86
        Height = 12
        Caption = 'Desconto at'#233
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
    end
    object E_Dt_Vencimento: TDateTimePicker
      Left = 583
      Top = 153
      Width = 116
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 8
    end
    object ChBx_Dt_Vencimento: TCheckBox
      Left = 584
      Top = 139
      Width = 119
      Height = 12
      Caption = 'Data de Vencimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object DBLCB_CarteiraCobranca: TDBLookupComboBox
      Left = 8
      Top = 19
      Width = 724
      Height = 21
      KeyField = 'CTR_CODIGO'
      ListField = 'CTB_COMPLETO'
      ListSource = DM.Ds_Carteiras
      TabOrder = 10
      TabStop = False
      OnClick = DBLCB_CarteiraCobrancaClick
    end
    object E_Dias_Protesto: TEdit_Setes
      Left = 269
      Top = 153
      Width = 60
      Height = 21
      TabOrder = 4
      Text = ''
    end
    object CB_negativacao: TComboBox
      Left = 335
      Top = 153
      Width = 90
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 5
      Text = 'N'#195#402'O'
      Items.Strings = (
        'SIM'
        'N'#195#402'O')
    end
    object E_Dias_Negativacao: TEdit_Setes
      Left = 429
      Top = 153
      Width = 60
      Height = 21
      TabOrder = 6
      Text = ''
    end
  end
  object Pnl_Botao: TPanel
    Left = 0
    Top = 183
    Width = 768
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      768
      66)
    object Sb_Sair_0: TSpeedButton
      Left = 678
      Top = 7
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
    end
    object Sb_Gravar: TSpeedButton
      Left = 590
      Top = 6
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = Sb_GravarClick
    end
    object Chbx_Agrupar: TCheckBox
      Left = 5
      Top = 4
      Width = 274
      Height = 17
      Caption = 'Agrupar todos os valores selecionados em um boleto'
      TabOrder = 0
      OnClick = Chbx_AgruparClick
    end
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 378
    Top = 188
  end
  object Qr_Boleto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      'FIN_CODIGO,'
      'BLT_DT_VENCIMENTO,'
      'BLT_DATA,'
      'BLT_NUMERO,'
      'BLT_NOSSONUMERO,'
      'EPD_SIGLA,'
      'BLT_ACEITE,'
      'BLT_DT_PROCESSAMENTO,'
      'CTR_NUMERO,'
      'EMP_FANTASIA,'
      'EMP_CNPJ,'
      'END_ENDER,'
      'END_NUMERO,'
      'END_BAIRRO,'
      'CDD_DESCRICAO,'
      'UFE_SIGLA,'
      'END_CEP,'
      'BLE_LOCALPAG,'
      'BLT_VALOR,'
      'BLT_VL_MORA,'
      'BLT_VL_DESCONTO,'
      'BLT_TX_MULTA,'
      'BLE_INSTR_1,'
      'BLE_INSTR_2,'
      'BLT_INSTRUCOES,'
      'BLT_DT_PROTESTO'
      'from tb_boleto_bancario'
      '  INNER JOIN TB_FINANCEIRO'
      '  ON (tb_financeiro.fin_codqtc = Tb_boleto_bancario.blt_codqtc) '
      ''
      '  INNER JOIN tb_boleto_eletronico'
      
        '  ON (tb_boleto_eletronico.ble_codigo = tb_boleto_bancario.blt_c' +
        'odble)'
      '  INNER JOIN tb_carteira_cobranca'
      
        '  ON (tb_carteira_cobranca.ctr_codigo = tb_boleto_eletronico.ble' +
        '_codctr)'
      '  INNER JOIN tb_especie_doc'
      
        '  ON (tb_especie_doc.epd_codigo = tb_boleto_eletronico.ble_codep' +
        'd)'
      '  INNER JOIN tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = TB_BOLETO_bancario.BLT_CODEMP)'
      '  INNER JOIN tb_endereco'
      '  ON (tb_endereco.end_codemp = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      
        'WHERE ( (END_PRINCIPAL = '#39'S'#39') OR (END_TIPO = '#39'COBRAN'#199'A'#39')) AND (F' +
        'IN_CODIGO =:FIN_CODIGO)'
      '')
    Left = 442
    Top = 188
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_BoletoFIN_CODIGO: TIntegerField
      FieldName = 'FIN_CODIGO'
      Origin = 'TB_FINANCEIRO.FIN_CODIGO'
      Required = True
    end
    object Qr_BoletoBLT_DT_VENCIMENTO: TDateField
      FieldName = 'BLT_DT_VENCIMENTO'
      Origin = 'TB_BOLETO_BANCARIO.BLT_DT_VENCIMENTO'
    end
    object Qr_BoletoBLT_DATA: TDateField
      FieldName = 'BLT_DATA'
      Origin = 'TB_BOLETO_BANCARIO.BLT_DATA'
    end
    object Qr_BoletoBLT_NUMERO: TStringField
      FieldName = 'BLT_NUMERO'
      Origin = 'TB_BOLETO_BANCARIO.BLT_NUMERO'
      Size = 30
    end
    object Qr_BoletoBLT_NOSSONUMERO: TStringField
      FieldName = 'BLT_NOSSONUMERO'
      Origin = 'TB_BOLETO_BANCARIO.BLT_NOSSONUMERO'
      Size = 100
    end
    object Qr_BoletoEPD_SIGLA: TStringField
      FieldName = 'EPD_SIGLA'
      Origin = 'TB_ESPECIE_DOC.EPD_SIGLA'
      Size = 10
    end
    object Qr_BoletoBLT_ACEITE: TStringField
      FieldName = 'BLT_ACEITE'
      Origin = 'TB_BOLETO_BANCARIO.BLT_ACEITE'
      FixedChar = True
      Size = 1
    end
    object Qr_BoletoBLT_DT_PROCESSAMENTO: TDateField
      FieldName = 'BLT_DT_PROCESSAMENTO'
      Origin = 'TB_BOLETO_BANCARIO.BLT_DT_PROCESSAMENTO'
    end
    object Qr_BoletoCTR_NUMERO: TStringField
      FieldName = 'CTR_NUMERO'
      Origin = 'TB_CARTEIRA_COBRANCA.CTR_NUMERO'
      Size = 50
    end
    object Qr_BoletoEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'TB_EMPRESA.EMP_FANTASIA'
      Size = 100
    end
    object Qr_BoletoEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = 'TB_EMPRESA.EMP_CNPJ'
      Size = 14
    end
    object Qr_BoletoEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_BoletoEND_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'TB_ENDERECO.END_NUMERO'
      Size = 10
    end
    object Qr_BoletoEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 100
    end
    object Qr_BoletoCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_BoletoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_BoletoEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_BoletoBLE_LOCALPAG: TStringField
      FieldName = 'BLE_LOCALPAG'
      Origin = 'TB_BOLETO_ELETRONICO.BLE_LOCALPAG'
      Size = 60
    end
    object Qr_BoletoBLT_VALOR: TBCDField
      FieldName = 'BLT_VALOR'
      Origin = 'TB_BOLETO_BANCARIO.BLT_VALOR'
      Precision = 18
      Size = 2
    end
    object Qr_BoletoBLT_VL_MORA: TBCDField
      FieldName = 'BLT_VL_MORA'
      Origin = 'TB_BOLETO_BANCARIO.BLT_VL_MORA'
      Precision = 18
      Size = 2
    end
    object Qr_BoletoBLT_VL_DESCONTO: TBCDField
      FieldName = 'BLT_VL_DESCONTO'
      Origin = 'TB_BOLETO_BANCARIO.BLT_VL_DESCONTO'
      Precision = 18
      Size = 2
    end
    object Qr_BoletoBLT_TX_MULTA: TBCDField
      FieldName = 'BLT_TX_MULTA'
      Origin = 'TB_BOLETO_BANCARIO.BLT_TX_MULTA'
      Precision = 18
      Size = 2
    end
    object Qr_BoletoBLE_INSTR_1: TStringField
      FieldName = 'BLE_INSTR_1'
      Origin = 'TB_BOLETO_ELETRONICO.BLE_INSTR_1'
      Size = 60
    end
    object Qr_BoletoBLE_INSTR_2: TStringField
      FieldName = 'BLE_INSTR_2'
      Origin = 'TB_BOLETO_ELETRONICO.BLE_INSTR_2'
      Size = 60
    end
    object Qr_BoletoBLT_INSTRUCOES: TMemoField
      FieldName = 'BLT_INSTRUCOES'
      Origin = 'TB_BOLETO_BANCARIO.BLT_INSTRUCOES'
      BlobType = ftMemo
      Size = 8
    end
    object Qr_BoletoBLT_DT_PROTESTO: TDateField
      FieldName = 'BLT_DT_PROTESTO'
      Origin = 'TB_BOLETO_BANCARIO.BLT_DT_PROTESTO'
    end
  end
  object ACBrBoleto1: TACBrBoleto
    Banco.TamanhoMaximoNossoNum = 10
    Banco.TipoCobranca = cobNenhum
    Banco.LayoutVersaoArquivo = 0
    Banco.LayoutVersaoLote = 0
    Banco.CasasDecimaisMoraJuros = 2
    Cedente.TipoInscricao = pJuridica
    Cedente.IdentDistribuicao = tbBancoDistribui
    Cedente.PIX.TipoChavePIX = tchNenhuma
    Cedente.IntegradoraBoleto = tibNenhum
    NumeroArquivo = 0
    Configuracoes.Arquivos.LogNivel = logNenhum
    Configuracoes.WebService.SSLHttpLib = httpOpenSSL
    Configuracoes.WebService.StoreName = 'My'
    Configuracoes.WebService.Ambiente = tawsHomologacao
    Configuracoes.WebService.Operacao = tpInclui
    Configuracoes.WebService.VersaoDF = '1.2'
    Left = 224
    Top = 270
  end
end
