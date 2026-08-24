inherited SeaNfProduct: TSeaNfProduct
  Caption = 'Pesquisa de Notas'
  ClientWidth = 793
  ExplicitWidth = 799
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited GrB_Parametros: TGroupBox
    Width = 793
    Height = 61
    ExplicitWidth = 793
    ExplicitHeight = 61
    object Label36: TLabel
      Left = 174
      Top = 15
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'Nota Fiscal'
      FocusControl = E_BuscaNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ChBx_Periodo: TCheckBox
      Left = 5
      Top = 15
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object E_Data_Ini: TDateTimePicker
      Left = 5
      Top = 30
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 87
      Top = 30
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_BuscaNota: TMaskEdit
      Left = 170
      Top = 30
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 9
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    inline Fm_VendedorPedido: TFm_ListaColaboradores
      Left = 250
      Top = 16
      Width = 245
      Height = 37
      TabOrder = 4
      ExplicitLeft = 250
      ExplicitTop = 16
      ExplicitWidth = 245
      ExplicitHeight = 37
      inherited Label19: TLabel
        Width = 245
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 219
        Height = 20
        ExplicitLeft = 219
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 213
        ExplicitWidth = 213
      end
    end
    object Rg_Modelo: TRadioGroup
      Left = 494
      Top = 16
      Width = 277
      Height = 39
      Caption = 'Tipo de Nota Fiscal'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'NF-e'
        'NFC-e'
        'Todas')
      TabOrder = 5
    end
  end
  inherited Pnl_Resultado: TPanel
    Top = 61
    Width = 793
    Height = 448
    ExplicitTop = 61
    ExplicitWidth = 793
    ExplicitHeight = 448
    object SB_Bl_Add_Tudo: TSpeedButton [1]
      Left = 5
      Top = 418
      Width = 109
      Height = 24
      Anchors = [akLeft, akBottom]
      Caption = 'Marcar todos'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_Bl_Add_TudoClick
    end
    object SB_Bl_Retirar_Tudo: TSpeedButton [2]
      Left = 114
      Top = 418
      Width = 109
      Height = 24
      Anchors = [akLeft, akBottom]
      Caption = 'Desmarcar todos'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333FFF33FF333FFF339993370733
        999333777FF37FF377733339993000399933333777F777F77733333399970799
        93333333777F7377733333333999399933333333377737773333333333990993
        3333333333737F73333333333331013333333333333777FF3333333333910193
        333333333337773FF3333333399000993333333337377737FF33333399900099
        93333333773777377FF333399930003999333337773777F777FF339993370733
        9993337773337333777333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_Bl_Retirar_TudoClick
    end
    inherited Grd_Pesquisa: TStringGrid
      Width = 688
      Height = 430
      ExplicitWidth = 688
      ExplicitHeight = 430
    end
    inherited pnl_botao: TPanel
      Left = 690
      Height = 430
      ExplicitLeft = 690
      ExplicitHeight = 430
      inherited Sb_Sair: TSpeedButton
        Top = 375
        ExplicitLeft = 3
        ExplicitTop = 355
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 320
        Caption = 'Confirmar - F8'
        ExplicitLeft = 3
        ExplicitTop = 300
      end
      inherited SB_Buscar: TSpeedButton
        Top = 265
        ExplicitLeft = 3
        ExplicitTop = 245
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 210
        Visible = False
        ExplicitLeft = 3
        ExplicitTop = 190
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 152
  end
  inherited Qr_Pesquisa: TSTQuery
    Left = 104
    Top = 144
    object Qr_PesquisaNFL_CODIGO: TIntegerField
      Tag = -1
      FieldName = 'NFL_CODIGO'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PesquisaPED_NUMERO: TIntegerField
      Tag = 71
      DisplayLabel = 'Pedido'
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_PesquisaNFL_NUMERO: TStringField
      Tag = 71
      DisplayLabel = 'Nota'
      FieldName = 'NFL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_NUMERO"'
      Size = 10
    end
    object Qr_PesquisaNFL_DT_EMISSAO: TDateField
      Tag = 74
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'NFL_DT_EMISSAO'
      Origin = '"TB_NOTA_FISCAL"."NFL_DT_EMISSAO"'
    end
    object Qr_PesquisaEMP_FANTASIA: TStringField
      Tag = 410
      DisplayLabel = 'FAntasia'
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object Qr_PesquisaEMP_NOME: TStringField
      Tag = 410
      DisplayLabel = 'Nome/Raz'#227'o Social'
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_PesquisaNFL_VL_TL_NOTA: TBCDField
      Tag = 111
      DisplayLabel = 'Valor '
      FieldName = 'NFL_VL_TL_NOTA'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_TL_NOTA"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaNFL_MODELO: TStringField
      Tag = -1
      DisplayLabel = 'Modelo'
      FieldName = 'NFL_MODELO'
      Origin = '"TB_NOTA_FISCAL"."NFL_MODELO"'
      Size = 2
    end
    object Qr_PesquisaNFL_SERIE: TStringField
      Tag = -1
      DisplayLabel = 'S'#233'rie'
      FieldName = 'NFL_SERIE'
      Origin = '"TB_NOTA_FISCAL"."NFL_SERIE"'
      Size = 10
    end
  end
end
