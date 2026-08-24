object Fr_Fich_Fin_For: TFr_Fich_Fin_For
  Left = 288
  Top = 150
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsSingle
  Caption = 'Ficha Financeira de Fornecedores'
  ClientHeight = 574
  ClientWidth = 895
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object DBG_Pesquisa: TDBGrid
    Left = 0
    Top = 193
    Width = 895
    Height = 293
    Align = alClient
    Color = clCream
    DataSource = Ds_Mostra
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBG_PesquisaDrawColumnCell
    OnTitleClick = DBG_PesquisaTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NFL_DT_EMISSAO'
        Title.Caption = 'Data Emiss'#227'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_NUMERO'
        Title.Caption = 'Parcela'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFL_NUMERO'
        Title.Caption = 'N'#186' Nota'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_CODVDO'
        Title.Caption = 'Vendedor'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FPT_DESCRICAO'
        Title.Caption = 'Cobran'#231'a'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_DT_VENCIMENTO'
        Title.Caption = 'Vencimento'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_DT_PAGTO'
        Title.Caption = 'Data Pagto'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_VL_PARCELA'
        Title.Caption = 'Valor Parcela'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_VL_PAGO'
        Title.Caption = 'Valor Pago'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFL_VL_TL_NOTA'
        Title.Caption = 'Valor Nota'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_DIAS_ATRASO'
        Title.Caption = 'Dias Atraso'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIN_PRAZO'
        Title.Caption = 'Forma Pagamento'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMP_NOME'
        Title.Caption = 'Nome Fornecedor'
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 57
    Width = 895
    Height = 136
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object pnl_bottom: TPanel
      Left = 2
      Top = 72
      Width = 891
      Height = 62
      Align = alTop
      TabOrder = 0
      object Sb_Sair_0: TSpeedButton
        AlignWithMargins = True
        Left = 814
        Top = 4
        Width = 76
        Height = 54
        Margins.Left = 0
        Margins.Right = 0
        Align = alRight
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
        ExplicitLeft = 704
        ExplicitTop = 59
      end
      object SB_Buscar: TSpeedButton
        AlignWithMargins = True
        Left = 738
        Top = 4
        Width = 76
        Height = 54
        Margins.Left = 0
        Margins.Right = 0
        Align = alRight
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
        ExplicitLeft = 627
        ExplicitTop = 59
      end
      object Sb_Recibo: TSpeedButton
        AlignWithMargins = True
        Left = 662
        Top = 4
        Width = 76
        Height = 54
        Margins.Left = 0
        Margins.Right = 0
        Align = alRight
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
        ExplicitLeft = 550
        ExplicitTop = 59
      end
      object RG_Situacao: TRadioGroup
        Left = 1
        Top = 1
        Width = 282
        Height = 60
        Align = alLeft
        Caption = 'Situa'#231#227'o'
        Columns = 4
        ItemIndex = 1
        Items.Strings = (
          'A Vencer'
          'Vencidas'
          'Pagas'
          'Todas')
        TabOrder = 0
        OnClick = RG_SituacaoClick
      end
      object Rg_Data: TRadioGroup
        Left = 283
        Top = 1
        Width = 167
        Height = 60
        Align = alLeft
        Caption = 'Tipo de Data'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Vencimento'
          'Pagamento')
        TabOrder = 1
        OnClick = Rg_DataClick
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 16
      Width = 891
      Height = 56
      Align = alTop
      Caption = 'Panel2'
      TabOrder = 1
      DesignSize = (
        891
        56)
      object E_Data_Ini: TDateTimePicker
        Left = 9
        Top = 24
        Width = 79
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        Enabled = False
        TabOrder = 0
      end
      object E_Data_Fim: TDateTimePicker
        Left = 88
        Top = 24
        Width = 80
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        Enabled = False
        TabOrder = 1
      end
      object ChBx_Periodo: TCheckBox
        Left = 9
        Top = 7
        Width = 130
        Height = 12
        Caption = 'Data Inicial    Data Final'
        TabOrder = 2
        OnClick = ChBx_PeriodoClick
      end
      inline Fm_ListaFornecedores: TFm_ListaFornecedores
        Left = 168
        Top = 4
        Width = 628
        Height = 45
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        ExplicitLeft = 168
        ExplicitTop = 4
        ExplicitWidth = 628
        ExplicitHeight = 45
        inherited pnl_01: TPanel
          Width = 628
          ExplicitWidth = 628
          inherited ChBx_Nome: TCheckBox
            Left = 42
            ExplicitLeft = 42
            ExplicitTop = 1
            ExplicitHeight = 14
          end
          inherited ChBx_Fantasia: TCheckBox
            Left = 168
            ExplicitLeft = 168
            ExplicitTop = 1
            ExplicitHeight = 14
          end
        end
        inherited pnl_02: TPanel
          Width = 628
          ExplicitWidth = 628
          inherited Sb_Pesq_Empresa: TSpeedButton
            Left = 600
            ExplicitLeft = 600
            ExplicitHeight = 22
          end
          inherited SB_Empresas: TSpeedButton
            Left = 575
            ExplicitLeft = 575
          end
          inherited E_Cd_Empresa: TMaskEdit
            ExplicitLeft = 1
            ExplicitTop = 1
          end
          inherited DBLCB_Empresa: TDBLookupComboBox
            Width = 507
            ExplicitLeft = 66
            ExplicitTop = 1
            ExplicitWidth = 507
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 486
    Width = 895
    Height = 88
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object pnl_Totais: TPanel
      Left = 2
      Top = 2
      Width = 490
      Height = 84
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Lb_Vl_Vencer: TLabel
        Left = 192
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
      object Lb_Vl_Vencida: TLabel
        Left = 192
        Top = 25
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
        Left = 5
        Top = 25
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
        Left = 5
        Top = 3
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
      object Lb_Vl_Devedor: TLabel
        Left = 429
        Top = 3
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
        Left = 242
        Top = 3
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
      object Label2: TLabel
        Left = 242
        Top = 25
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
        Left = 429
        Top = 25
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
        Left = 242
        Top = 44
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
      object Lb_Vl_Saldo: TLabel
        Left = 429
        Top = 44
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
      object Label25: TLabel
        Left = 4
        Top = 44
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
      object Lb_Vl_Pago: TLabel
        Left = 192
        Top = 44
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
      object Label3: TLabel
        Left = 4
        Top = 64
        Width = 60
        Height = 16
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Vl_Total: TLabel
        Left = 192
        Top = 64
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
      object Label26: TLabel
        Left = 242
        Top = 64
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
      object Lb_Med_Atraso: TLabel
        Left = 429
        Top = 64
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
    end
    object Pnl_total_Especifico: TPanel
      Left = 492
      Top = 2
      Width = 401
      Height = 84
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object Label6: TLabel
        Left = 5
        Top = 49
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
        Left = 5
        Top = 34
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
        Left = 253
        Top = 34
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
        Left = 253
        Top = 49
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
      object Lb_Vl_Ult_Cpa: TLabel
        Left = 254
        Top = 2
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
        Left = 253
        Top = 18
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
        Left = 5
        Top = 18
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
        Left = 5
        Top = 2
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
      object Lb_Dt_Ult_Cpa: TLabel
        Left = 137
        Top = 2
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
        Left = 136
        Top = 18
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
        Left = 5
        Top = 64
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
        Left = 229
        Top = 64
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
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 895
    Height = 57
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 895
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 895
      ExplicitWidth = 895
      inherited Sb_open: TSpeedButton
        Left = 871
        ExplicitLeft = 871
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 871
        ExplicitWidth = 871
      end
    end
    inherited pnl_top: TPanel
      Width = 895
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
      
        'SELECT NFL_CODEMP, NFL_DT_EMISSAO, NFL_NUMERO, NFL_VL_TL_NOTA, P' +
        'ED_CODVDO, '
      
        'FIN_DT_VENCIMENTO, FIN_VL_PARCELA, FIN_VL_PAGO, FIN_DT_PAGTO, FI' +
        'N_NR_PARCELA, FIN_NUMERO, '
      '(FIN_DT_PAGTO - FIN_DT_VENCIMENTO)  FIN_DIAS_ATRASO, FIN_PRAZO ,'
      
        'FIN_BAIXA, PED_NUMERO, EMP_NOME, EMP_DT_CADASTRO, EMP_VL_CRED, F' +
        'PT_DESCRICAO,FIN_OPERACAO'
      'FROM TB_FINANCEIRO Tb_financeiro '
      '   INNER JOIN TB_NOTA_FISCAL Tb_nota_fiscal '
      '   ON  (Tb_financeiro.FIN_CODNFL = Tb_nota_fiscal.NFL_CODIGO) '
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON  (Tb_financeiro.FIN_CODEMP = Tb_empresa.EMP_CODIGO) '
      '   INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON  (tb_formapagto.FPT_CODIGO = Tb_financeiro.FIN_CODFPG) '
      '   LEFT OUTER JOIN TB_PEDIDO Tb_pedido '
      '   ON  (Tb_pedido.PED_CODIGO = Tb_nota_fiscal.NFL_CODPED) '
      'WHERE (NFL_CODIGO IS NOT NULL) ')
    Left = 328
    Top = 216
  end
  object PopupMenu1: TPopupMenu
    Left = 140
    Top = 195
    object DetalhesdoPediso1: TMenuItem
      Caption = 'Detalhes do Pedido'
    end
    object EditaObservao1: TMenuItem
      Caption = 'Edita Observa'#231#227'o'
      OnClick = EditaObservao1Click
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
      'SELECT'
      '  NFL_CODEMP,'
      '  NFL_DT_EMISSAO,'
      '  NFL_NUMERO,'
      '  NFL_VL_TL_NOTA,'
      '  PED_CODVDO,'
      '  FIN_DT_VENCIMENTO,'
      '  FIN_CODIGO,'
      '  FIN_VL_PARCELA,'
      '  FIN_VL_PAGO,'
      '  FIN_DT_PAGTO,'
      '  FIN_NR_PARCELA,'
      '  FIN_NUMERO,'
      '  (FIN_DT_PAGTO - FIN_DT_VENCIMENTO)'
      '  FIN_DIAS_ATRASO,'
      '  FIN_PRAZO ,'
      '  FIN_BAIXA,'
      '  PED_NUMERO,'
      '  EMP_NOME,'
      '  EMP_DT_CADASTRO,'
      '  EMP_VL_CRED,'
      '  FPT_DESCRICAO,'
      '  FIN_OPERACAO'
      'FROM'
      '  TB_FINANCEIRO Tb_financeiro'
      'INNER JOIN TB_NOTA_FISCAL Tb_nota_fiscal'
      'ON  (Tb_financeiro.FIN_CODNFL = Tb_nota_fiscal.NFL_CODIGO)'
      'INNER JOIN TB_EMPRESA tb_empresa'
      'ON  (Tb_financeiro.FIN_CODEMP = Tb_empresa.EMP_CODIGO)'
      'INNER JOIN TB_FORMAPAGTO tb_formapagto'
      'ON  (tb_formapagto.FPT_CODIGO = Tb_financeiro.FIN_CODFPG)'
      'LEFT OUTER JOIN TB_PEDIDO Tb_pedido'
      'ON  (Tb_pedido.PED_CODIGO = Tb_nota_fiscal.NFL_CODPED)'
      'WHERE'
      '  (NFL_CODIGO IS NOT NULL)')
    Left = 463
    Top = 267
  end
  object Ds_Mostra: TDataSource
    DataSet = Qr_Mostra
    Left = 464
    Top = 323
  end
end
