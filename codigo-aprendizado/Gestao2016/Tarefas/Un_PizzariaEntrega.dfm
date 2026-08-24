object Fr_PizzariaEntrega: TFr_PizzariaEntrega
  Left = 219
  Top = 121
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Controle de Entregas e Retornos'
  ClientHeight = 422
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StrGrd_Entrega: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 68
    Width = 976
    Height = 281
    Align = alClient
    Color = clCream
    ColCount = 17
    DefaultColWidth = 40
    DefaultRowHeight = 18
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = StrGrd_EntregaClick
    OnDrawCell = StrGrd_EntregaDrawCell
    ColWidths = (
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40)
    RowHeights = (
      18
      18)
  end
  object Pnl_Entrega: TPanel
    Left = 240
    Top = 144
    Width = 417
    Height = 121
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Pnl_Entrega'
    TabOrder = 1
    Visible = False
    DesignSize = (
      417
      121)
    object Label53: TLabel
      Left = 2
      Top = 2
      Width = 413
      Height = 24
      Align = alTop
      Caption = 'Troca de Motoboy'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 169
    end
    object Label5: TLabel
      Left = 5
      Top = 29
      Width = 41
      Height = 14
      Caption = 'Motoboy'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object dblcb_MudaMotoboy: TDBLookupComboBox
      Left = 4
      Top = 45
      Width = 408
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'CLB_CODIGO'
      ListField = 'CLB_NOME'
      ListSource = DM_ListaConsultas.DS_ListaMotoboy
      ParentFont = False
      TabOrder = 0
      OnKeyDown = DBLCB_Busca_MotoboyKeyDown
    end
    object Sb_confirma: TButton
      Left = 167
      Top = 84
      Width = 122
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = '&Confirma - F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Sb_confirmaClick
    end
    object Sb_cancela: TButton
      Left = 289
      Top = 84
      Width = 122
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Cance&la - ESC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Sb_cancelaClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 982
    Height = 65
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 2
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 888
      Height = 57
      Align = alClient
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label27: TLabel
        Left = 8
        Top = 16
        Width = 41
        Height = 14
        Caption = 'Telefone'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 99
        Top = 16
        Width = 32
        Height = 14
        Caption = 'Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label29: TLabel
        Left = 402
        Top = 16
        Width = 41
        Height = 14
        Caption = 'Motoboy'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaFone: TEdit
        Left = 5
        Top = 32
        Width = 89
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_BuscaCliente: TEdit
        Left = 95
        Top = 32
        Width = 303
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object DBLCB_Busca_Motoboy: TDBLookupComboBox
        Left = 400
        Top = 32
        Width = 297
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        KeyField = 'CLB_CODIGO'
        ListField = 'CLB_NOME'
        ListSource = DM_ListaConsultas.DS_ListaMotoboy
        ParentFont = False
        TabOrder = 2
        OnKeyDown = DBLCB_Busca_MotoboyKeyDown
      end
      object Chbx_Faturado: TCheckBox
        Left = 697
        Top = 12
        Width = 170
        Height = 17
        Caption = 'Somente pedido faturado'
        TabOrder = 3
      end
    end
    object Rg_Situacao: TRadioGroup
      AlignWithMargins = True
      Left = 898
      Top = 4
      Width = 80
      Height = 57
      Align = alRight
      Caption = 'Situa'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Entregar'
        'Retorno')
      ParentFont = False
      TabOrder = 1
      OnClick = Rg_SituacaoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 352
    Width = 982
    Height = 70
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object Sb_liberar: TSpeedButton
      AlignWithMargins = True
      Left = 609
      Top = 5
      Width = 92
      Height = 60
      Margins.Right = 0
      Align = alRight
      Caption = 'Liberar - F2'
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F77777FFF333333009999900
        3333333777777777FF33330998FFF899033333777333F3777FF33099FFFCFFF9
        903337773337333777F3309FFFFFFFCF9033377333F3337377FF098FF0FFFFFF
        890377F3373F3333377F09FFFF0FFFFFF90377F3F373FFFFF77F09FCFFF90000
        F90377F733377777377F09FFFFFFFFFFF90377F333333333377F098FFFFFFFFF
        890377FF3F33333F3773309FCFFFFFCF9033377F7333F37377F33099FFFCFFF9
        90333777FF37F3377733330998FCF899033333777FF7FF777333333009999900
        3333333777777777333333333000003333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 14
      OnClick = Sb_liberarClick
      ExplicitLeft = 602
      ExplicitTop = 227
      ExplicitHeight = 54
    end
    object Sb_Retorno: TSpeedButton
      AlignWithMargins = True
      Left = 701
      Top = 5
      Width = 92
      Height = 60
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Retorno - F3'
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
        FFF07F3FF3FF3FFF3FF70F00F00F000F00F07F773773777377370FFFFFFFFFFF
        FFF07F3FF3FF33FFFFF70F00F00FF00000F07F773773377777F70FEEEEEFF0F9
        FCF07F33333337F7F7F70FFFFFFFF0F9FCF07F3FFFF337F737F70F0000FFF0FF
        FCF07F7777F337F337370F0000FFF0FFFFF07F777733373333370FFFFFFFFFFF
        FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
        C880733777777777733700000000000000007777777777777777333333333333
        3333333333333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 14
      OnClick = Sb_RetornoClick
      ExplicitLeft = 694
      ExplicitTop = 227
      ExplicitHeight = 54
    end
    object Sb_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 793
      Top = 5
      Width = 92
      Height = 60
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Pesquisar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_BuscarClick
      ExplicitLeft = 780
      ExplicitTop = 227
      ExplicitHeight = 54
    end
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 885
      Top = 5
      Width = 92
      Height = 60
      Margins.Left = 0
      Align = alRight
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 864
      ExplicitTop = 227
      ExplicitHeight = 54
    end
    object GroupBox2: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 598
      Height = 60
      Align = alClient
      Caption = 'Dados para Libera'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 8
        Top = 15
        Width = 86
        Height = 13
        Caption = 'Valor Selecionado'
      end
      object Label1: TLabel
        Left = 101
        Top = 15
        Width = 70
        Height = 13
        Caption = 'Valor do Troco'
      end
      object Label3: TLabel
        Left = 194
        Top = 15
        Width = 77
        Height = 13
        Caption = 'Valor '#224' Receber'
      end
      object Label4: TLabel
        Left = 287
        Top = 15
        Width = 41
        Height = 14
        Caption = 'Motoboy'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Vl_Selecionado: TEdit_Setes
        Left = 6
        Top = 30
        Width = 90
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '0,00'
      end
      object E_VL_Troco: TEdit_Setes
        Left = 99
        Top = 30
        Width = 90
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = '0,00'
      end
      object E_VL_Receber: TEdit_Setes
        Left = 192
        Top = 30
        Width = 90
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '0,00'
      end
      object DBLCB_Motoboy: TDBLookupComboBox
        Left = 285
        Top = 30
        Width = 297
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'CLB_CODIGO'
        ListField = 'CLB_NOME'
        ListSource = DM_ListaConsultas.DS_ListaMotoboy
        ParentFont = False
        TabOrder = 3
        OnKeyDown = DBLCB_MotoboyKeyDown
      end
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Qr_Pesquisa
    Left = 150
    Top = 146
  end
  object Qr_Pesquisa: TSTQuery
    OnCalcFields = Qr_PesquisaCalcFields
    Connection = DM.IBD_Gestao
    Transaction = IBT_Entrega
    UpdateTransaction = IBT_Entrega
    SQL.Strings = (
      
        'SELECT DISTINCT PED_CODIGO, PEd_DATA, PED_NUMERO, EMP_CODIGO, EM' +
        'P_NOME, PEG_CODMOT, CLB_NOME, PED_VL_PEDIDO,  '
      
        'PEG_TM_PEDIDO, PEG_TM_SAIDA, PEG_TM_FINAL, PED_VL_FRETE, VALUE_C' +
        'HANGE, VALUE_RECIVED, END_FONE'
      'FROM TB_PIZ_ENTREGA '
      '  INNER JOIN TB_PEDIDO '
      '  ON (PED_CODIGO = PEG_CODPED) '
      '  INNER JOIN TB_EMPRESA '
      '  ON (EMP_CODIGO = PED_CODEMP) '
      '  INNER JOIN TB_ENDERECO '
      '  ON (END_CODIGO = PED_CODEND) '
      '  LEFT OUTER JOIN TB_COLABORADOR tb_colaborador '
      '  ON (CLB_CODIGO = PEG_CODMOT) '
      '  INNER JOIN TB_RESTAURANTE '
      '  ON (TB_PEDIDO_ID = PED_CODIGO)'
      'WHERE (PED_FATURADO <> '#39'A'#39')'
      ' AND (PED_TIPO = 1) '
      ' AND (PED_TP_CONTATO = 0) '
      ' AND (PED_DATA =:PED_DATA) '
      ' AND (END_PRINCIPAL = '#39'S'#39')')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 144
    Top = 112
    ParamData = <
      item
        Name = 'PED_DATA'
      end>
    object Qr_PesquisaPED_CODIGO: TIntegerField
      Tag = -1
      FieldName = 'PED_CODIGO'
      Origin = 'TB_PEDIDO.PED_CODIGO'
      Required = True
    end
    object Qr_PesquisaPED_NUMERO: TIntegerField
      Tag = 50
      DisplayLabel = 'Pedido'
      FieldName = 'PED_NUMERO'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_PesquisaEMP_CODIGO: TIntegerField
      Tag = -1
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_PesquisaEMP_NOME: TStringField
      Tag = 200
      DisplayLabel = 'Cliente'
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_PesquisaPEG_CODMOT: TIntegerField
      Tag = -1
      FieldName = 'PEG_CODMOT'
      Origin = 'TB_PIZ_ENTREGA.PEG_CODMOT'
      Required = True
    end
    object Qr_PesquisaCLB_NOME: TStringField
      Tag = 200
      DisplayLabel = 'Motoboy'
      FieldName = 'CLB_NOME'
      Origin = 'TB_COLABORADOR.CLB_NOME'
      Size = 100
    end
    object Qr_PesquisaPED_VL_PEDIDO: TBCDField
      Tag = 75
      DisplayLabel = 'Valor Pedido'
      FieldName = 'PED_VL_PEDIDO'
      Origin = 'TB_PEDIDO.PED_VL_PEDIDO'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaVALUE_RECIVED: TBCDField
      Tag = 75
      DisplayLabel = 'Valor Receber'
      FieldName = 'VALUE_RECIVED'
      Origin = '"TB_RESTAURANTE"."VALUE_RECIVED"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaVALUE_CHANGE: TBCDField
      Tag = 75
      DisplayLabel = 'Valor Troco'
      FieldName = 'VALUE_CHANGE'
      Origin = '"TB_RESTAURANTE"."VALUE_CHANGE"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaPEG_TM_PEDIDO: TStringField
      Tag = 70
      Alignment = taCenter
      DisplayLabel = 'Hora Pedido'
      FieldName = 'PEG_TM_PEDIDO'
      Origin = 'TB_PIZ_ENTREGA.PEG_TM_PEDIDO'
      Size = 5
    end
    object Qr_PesquisaPEG_TM_SAIDA: TStringField
      Tag = 60
      Alignment = taCenter
      DisplayLabel = 'Hora Saida'
      FieldName = 'PEG_TM_SAIDA'
      Origin = 'TB_PIZ_ENTREGA.PEG_TM_SAIDA'
      Size = 5
    end
    object Qr_PesquisaPEG_DURACAO: TStringField
      Tag = 50
      Alignment = taCenter
      DisplayLabel = 'Dura'#231#227'o'
      FieldKind = fkCalculated
      FieldName = 'PEG_DURACAO'
      Size = 5
      Calculated = True
    end
    object Qr_PesquisaPED_DATA: TDateField
      Tag = -1
      FieldName = 'PED_DATA'
      Origin = 'TB_PEDIDO.PED_DATA'
      Required = True
    end
    object Qr_PesquisaPED_VL_FRETE: TBCDField
      Tag = -1
      FieldName = 'PED_VL_FRETE'
      Origin = 'TB_PEDIDO.PED_VL_FRETE'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaPEG_TM_FINAL: TStringField
      FieldName = 'PEG_TM_FINAL'
      Origin = '"TB_PIZ_ENTREGA"."PEG_TM_FINAL"'
      Size = 5
    end
    object Qr_PesquisaEND_FONE: TStringField
      Tag = 75
      DisplayLabel = 'Telefone'
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
  end
  object IBT_Entrega: TSTTransaction
    Connection = DM.IBD_Gestao
    DefaultDatabase = DM.IBD_Gestao
    Active = False
    Left = 98
    Top = 112
  end
  object PopupMenu1: TPopupMenu
    Left = 208
    Top = 192
    object AlterarMotoboy1: TMenuItem
      Caption = 'Alterar Motoboy'
      OnClick = AlterarMotoboy1Click
    end
  end
end
