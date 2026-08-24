object Fr_Fich_Fin_Cli: TFr_Fich_Fin_Cli
  Left = 230
  Top = 91
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Ficha Financeira de Clientes'
  ClientHeight = 543
  ClientWidth = 777
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object StrGrd_Ficha: TStringGrid
    Left = 0
    Top = 177
    Width = 777
    Height = 263
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
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDblClick = StrGrd_FichaDblClick
    OnDrawCell = StrGrd_FichaDrawCell
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 57
    Width = 777
    Height = 120
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      777
      120)
    object Sb_Sair_0: TSpeedButton
      Left = 694
      Top = 58
      Width = 78
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
      ExplicitTop = 59
    end
    object SB_Buscar: TSpeedButton
      Left = 615
      Top = 58
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Buscar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_BuscarClick
      ExplicitTop = 59
    end
    object Sb_Recibo: TSpeedButton
      Left = 531
      Top = 60
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Recibo - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ReciboClick
    end
    object RG_Situacao: TRadioGroup
      Left = 5
      Top = 66
      Width = 284
      Height = 46
      Caption = 'Situa'#231#227'o'
      Columns = 4
      ItemIndex = 1
      Items.Strings = (
        'A Vencer'
        'Vencidas'
        'Pagas'
        'Todas')
      TabOrder = 2
      OnClick = RG_SituacaoClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 6
      Top = 31
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 85
      Top = 31
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 8
      Top = 16
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      TabOrder = 3
      OnClick = ChBx_PeriodoClick
    end
    object Rg_Data: TRadioGroup
      Left = 292
      Top = 66
      Width = 167
      Height = 46
      Caption = 'Tipo de Data'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Vencimento'
        'Pagamento')
      TabOrder = 4
      OnClick = Rg_DataClick
    end
    inline Fm_ListaClientes: TFm_ListaClientes
      Left = 167
      Top = 11
      Width = 607
      Height = 45
      TabOrder = 5
      ExplicitLeft = 167
      ExplicitTop = 11
      ExplicitWidth = 607
      ExplicitHeight = 45
      inherited pnl_01: TPanel
        Width = 607
        ExplicitWidth = 607
      end
      inherited pnl_02: TPanel
        Width = 607
        ExplicitWidth = 607
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 579
          ExplicitLeft = 413
          ExplicitHeight = 18
        end
        inherited SB_Empresas: TSpeedButton
          Left = 554
          ExplicitLeft = 388
          ExplicitHeight = 18
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 486
          ExplicitWidth = 478
        end
      end
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 777
    Height = 57
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 777
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 777
      ExplicitWidth = 777
      inherited Sb_open: TSpeedButton
        Left = 753
        ExplicitLeft = 753
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 753
        ExplicitWidth = 753
      end
    end
    inherited pnl_top: TPanel
      Width = 777
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 440
    Width = 777
    Height = 103
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object pnl_Totais: TPanel
      Left = 2
      Top = 2
      Width = 526
      Height = 99
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Label6: TLabel
        Left = 6
        Top = 4
        Width = 98
        Height = 16
        Caption = 'Limite de Cr'#233'dito'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 6
        Top = 24
        Width = 101
        Height = 16
        Caption = 'Compras a Prazo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Prazo: TLabel
        Left = 236
        Top = 24
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Credito: TLabel
        Left = 236
        Top = 4
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Vencer: TLabel
        Left = 460
        Top = 4
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Vencida: TLabel
        Left = 460
        Top = 24
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 273
        Top = 24
        Width = 53
        Height = 16
        Caption = 'Vencidas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 273
        Top = 4
        Width = 52
        Height = 16
        Caption = 'A Vencer'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Pago: TLabel
        Left = 236
        Top = 43
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Devedor: TLabel
        Left = 460
        Top = 43
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 273
        Top = 43
        Width = 83
        Height = 16
        Caption = 'Saldo Devedor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 6
        Top = 43
        Width = 37
        Height = 16
        Caption = 'Pagas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 6
        Top = 62
        Width = 120
        Height = 16
        Caption = 'Cheques Pr'#233'-Datado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 6
        Top = 80
        Width = 108
        Height = 16
        Caption = 'Cheques Devolvido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Chq_pre: TLabel
        Left = 235
        Top = 61
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Chq_Dev: TLabel
        Left = 235
        Top = 80
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 273
        Top = 61
        Width = 75
        Height = 16
        Caption = 'Saldo Credor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Credor: TLabel
        Left = 460
        Top = 61
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 273
        Top = 79
        Width = 64
        Height = 16
        Caption = 'Saldo Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Total: TLabel
        Left = 460
        Top = 79
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Pnl_total_Especifico: TPanel
      Left = 528
      Top = 2
      Width = 247
      Height = 99
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object Lb_Vl_Ult_Cpa: TLabel
        Left = 208
        Top = 3
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Maior_Cpa: TLabel
        Left = 208
        Top = 23
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Med_Atraso: TLabel
        Left = 208
        Top = 42
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 4
        Top = 23
        Width = 81
        Height = 16
        Caption = 'Maior Compra'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 4
        Top = 3
        Width = 86
        Height = 16
        Caption = #218'ltima Compra'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 4
        Top = 42
        Width = 76
        Height = 16
        Caption = 'M'#233'dia Atraso'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Dt_Ult_Cpa: TLabel
        Left = 135
        Top = 3
        Width = 50
        Height = 16
        Alignment = taRightJustify
        Caption = '00/00/00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Dt_Maior_Cpa: TLabel
        Left = 135
        Top = 23
        Width = 50
        Height = 16
        Alignment = taRightJustify
        Caption = '00/00/00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 3
        Top = 60
        Width = 101
        Height = 16
        Caption = 'Data de Cadastro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Dt_Cadastro: TLabel
        Left = 183
        Top = 62
        Width = 50
        Height = 16
        Alignment = taRightJustify
        Caption = '00/00/00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object Qr_Ficha: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  FIN_CODQTC, '
      '  FIN_DT_VENCIMENTO, '
      '  FIN_DT_PAGTO, '
      '  FIN_CODEMP, '
      '  EMP_NOME, '
      '  EMP_FANTASIA, '
      '  EMP_VL_CRED,'
      '  EMP_DT_CADASTRO,'
      '  END_FONE, '
      '  END_REGIAO, '
      '  FIN_NUMERO,'
      '  EMP_NOME   as NOMEEMITENTE,'
      '  FIN_VL_PARCELA, '
      '  FIN_VL_PAGO, '
      '  FIN_CODFPG, '
      '  FIN_BAIXA, '
      '  FIN_OPERACAO, '
      '  FIN_CODMHA, '
      '  FIN_CODPED,'
      '  FIN_DATA,'
      '  NFL_VL_TL_NOTA,'
      '  FIN_CODNFL,'
      '  PED_NUMERO,'
      '  FIN_CODIGO'
      'FROM '
      '  TB_FINANCEIRO Tb_financeiro'
      'INNER JOIN TB_EMPRESA Tb_empresa'
      'ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP)'
      'INNER JOIN TB_ENDERECO tb_endereco'
      'ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'INNER JOIN tb_nota_fiscal tb_nota_fiscal'
      'ON (tb_nota_fiscal.nfl_codigo = tb_financeiro.fin_codnfl)'
      'left outer JOIN tb_pedido tb_pedido'
      'ON (tb_pedido.ped_codigo = tb_nota_fiscal.nfl_codped)'
      'WHERE'
      
        '  ((FIN_TIPO = '#39'RA'#39') OR (FIN_TIPO = '#39'RM'#39')) AND (END_TIPO = '#39'PRIN' +
        'CIPAL'#39')')
    Left = 256
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    Left = 140
    Top = 195
    object DetalhesdoPediso1: TMenuItem
      Caption = 'Detalhes'
    end
  end
  object Qr_Mostra: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  FIN_CODQTC, '
      '  FIN_DT_VENCIMENTO, '
      '  FIN_DT_PAGTO, '
      '  FIN_CODEMP, '
      '  EMP_NOME, '
      '  EMP_FANTASIA, '
      '  END_FONE, '
      '  END_REGIAO, '
      '  FIN_NUMERO,'
      '  EMP_NOME   as NOMEEMITENTE,'
      '  FIN_VL_PARCELA, '
      '  FIN_VL_PAGO, '
      '  FIN_CODFPG, '
      '  FIN_BAIXA, '
      '  FIN_OPERACAO, '
      '  FIN_CODMHA, '
      '  FIN_CODPED,'
      '  FIN_DATA,'
      '  NFL_VL_TL_NOTA,'
      '  FIN_CODNFL,'
      '  PED_NUMERO,'
      'FIN_CODIGO'
      'FROM '
      '  TB_FINANCEIRO Tb_financeiro'
      'INNER JOIN TB_EMPRESA Tb_empresa'
      'ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP)'
      'INNER JOIN TB_ENDERECO tb_endereco'
      'ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'INNER JOIN tb_nota_fiscal tb_nota_fiscal'
      'ON (tb_nota_fiscal.nfl_codigo = tb_financeiro.fin_codnfl)'
      'left outer JOIN tb_pedido tb_pedido'
      'ON (tb_pedido.ped_codigo = tb_nota_fiscal.nfl_codped)'
      'WHERE'
      
        '  ((FIN_TIPO = '#39'RA'#39') OR (FIN_TIPO = '#39'RM'#39')) AND (END_TIPO = '#39'PRIN' +
        'CIPAL'#39')')
    Left = 392
    Top = 216
  end
  object Ds_Mostra: TDataSource
    DataSet = Qr_Mostra
    Left = 392
    Top = 248
  end
  object Qr_Conserto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CST_CODIGO'
      'FROM TB_CONSERTO tb_conserto'
      '  LEFT OUTER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_conserto.CST_CODFOR)'
      '  INNER JOIN TB_SITUACAO tb_situacao'
      '  ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT)'
      'WHERE '
      '  (CST_CODPED=:PED_CODIGO)')
    Left = 468
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
end
