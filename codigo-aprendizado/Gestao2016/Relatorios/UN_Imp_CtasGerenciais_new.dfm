object Fr_Imp_CtasGerenciais: TFr_Imp_CtasGerenciais
  Left = 376
  Top = 212
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Contas Gerenciais'
  ClientHeight = 453
  ClientWidth = 469
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
  object Panel1: TPanel
    Left = 0
    Top = 389
    Width = 469
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      469
      64)
    object SB_Imprimir: TSpeedButton
      Left = 315
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Imprimir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
    end
    object Sb_Sair_0: TSpeedButton
      Left = 384
      Top = 5
      Width = 80
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
      ExplicitLeft = 385
    end
    object Sb_Exportar: TSpeedButton
      Left = 231
      Top = 6
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Exportar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ExportarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 469
    Height = 105
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label4: TLabel
      Left = 4
      Top = 3
      Width = 80
      Height = 14
      Caption = 'Tipo de Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 290
      Top = 4
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 380
      Top = 4
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 290
      Top = 19
      Width = 87
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 378
      Top = 19
      Width = 83
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object CB_Tipo: TComboBox
      Left = 4
      Top = 19
      Width = 284
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'Plano de Contas Previsto - Financeiro'
      OnChange = CB_TipoChange
      Items.Strings = (
        'Plano de Contas Previsto - Financeiro'
        'Plano de Contas Realizado - Caixa/Banco'
        'Plano de Contas Previsto - Somente Excel')
    end
    object Rg_Tipo: TRadioGroup
      Left = 5
      Top = 42
      Width = 457
      Height = 40
      Caption = 'Tipo de Visualiza'#231#227'o'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Sint'#233'tico'
        'Anal'#237'tico'
        'Detalhado')
      ParentFont = False
      TabOrder = 3
    end
    object ChBx_MovimentoMensal: TCheckBox
      Left = 7
      Top = 83
      Width = 234
      Height = 17
      Caption = 'Mostrar apenas a movimenta'#231#227'o mensal'
      TabOrder = 4
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 337
    Width = 469
    Height = 52
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      469
      52)
    object Lb_Processo: TLabel
      Left = 9
      Top = 3
      Width = 75
      Height = 14
      Anchors = [akLeft, akBottom]
      Caption = 'Processamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 67
    end
    object Gg_Progresso: TGauge
      Left = 5
      Top = 19
      Width = 456
      Height = 27
      Anchors = [akLeft, akBottom]
      Progress = 0
      ExplicitTop = 83
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 162
    Width = 469
    Height = 175
    ActivePage = tbs_CentroCusto
    Align = alClient
    TabOrder = 3
    object tbs_CentroCusto: TTabSheet
      Caption = 'Centro de Custo'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object TPanel
        Left = 0
        Top = 0
        Width = 461
        Height = 147
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        inline Fm_CentroCustoInicial: TFm_CentroCusto
          Left = 3
          Top = 3
          Width = 450
          Height = 62
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 3
          inherited Grb_Cta_CentroCusto: TGroupBox
            Caption = 'Plano de Contas - Centro de Custo - Inicial'
            inherited DBLCB_Plano: TDBLookupComboBox
              Left = 70
              KeyField = 'PLC_CODPLANO'
              ExplicitLeft = 70
            end
          end
        end
        inline Fm_CentroCustoFinal: TFm_CentroCusto
          Left = 4
          Top = 72
          Width = 450
          Height = 62
          TabOrder = 1
          ExplicitLeft = 4
          ExplicitTop = 72
          inherited Grb_Cta_CentroCusto: TGroupBox
            Caption = 'Plano de Contas - Centro de Custo  - Final'
            inherited DBLCB_Plano: TDBLookupComboBox
              KeyField = 'PLC_CODPLANO'
            end
          end
        end
      end
    end
    object Tbs_CentroResultado: TTabSheet
      Caption = 'Contas de Resultado'
      ImageIndex = 1
      object TPanel
        Left = 0
        Top = 0
        Width = 461
        Height = 147
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        inline Fm_CentroResultadoInicial: TFm_CentroResultado
          Left = 2
          Top = 2
          Width = 451
          Height = 63
          TabOrder = 0
          TabStop = True
          ExplicitLeft = 2
          ExplicitTop = 2
          inherited Grb_Cta_Resultado: TGroupBox
            Caption = 'Plano de Contas - Resultado - Inicial'
            inherited DBLCB_Plano: TDBLookupComboBox
              KeyField = 'PLC_CODPLANO'
            end
          end
        end
        inline Fm_CentroResultadoFinal: TFm_CentroResultado
          Left = 3
          Top = 70
          Width = 451
          Height = 63
          TabOrder = 1
          TabStop = True
          ExplicitLeft = 3
          ExplicitTop = 70
          inherited Grb_Cta_Resultado: TGroupBox
            Caption = 'Plano de Contas - Resultado - Final'
            inherited DBLCB_Plano: TDBLookupComboBox
              KeyField = 'PLC_CODPLANO'
            end
          end
        end
      end
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 469
    Height = 57
    Align = alTop
    TabOrder = 4
    ExplicitWidth = 469
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 469
      ExplicitWidth = 469
      inherited Sb_open: TSpeedButton
        Left = 445
        ExplicitLeft = 445
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 445
        ExplicitWidth = 445
      end
    end
    inherited pnl_top: TPanel
      Width = 469
    end
  end
  object SaveDialogo: TSaveDialog
    Filter = 'Pasta de Trabalho do Microsoft Excel (*.xls)|*.xls'
    Left = 227
    Top = 343
  end
  object Qr_plano: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * '
      'FROM TB_PLANOCONTAS '
      'WHERE PLC_CODIGO IS NOT NULL ')
    Left = 16
    Top = 381
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 128
    Top = 381
  end
  object Qr_Movimento: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT CTG_DATA, CTG_TIPO, CTG_CONTA, CTG_HISTORISCO, CTG_VL_CRE' +
        'DITO, CTG_VL_DEBITO'
      'FROM VW_CTAS_GERENCIAIS'
      'WHERE CTG_DATA IS NOT NULL')
    Left = 72
    Top = 381
  end
  object Qr_Contas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM  tb_planocontas'
      'ORDER BY PLC_CODPLANO')
    Left = 16
    Top = 344
  end
end
