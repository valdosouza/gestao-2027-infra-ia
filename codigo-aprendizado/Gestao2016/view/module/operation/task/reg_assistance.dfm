inherited RegAssistance: TRegAssistance
  Caption = 'Acompanhamento de Assist'#234'ncia T'#233'cnica'
  ClientHeight = 562
  ClientWidth = 785
  ExplicitWidth = 791
  ExplicitHeight = 611
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 498
    Width = 785
    ExplicitTop = 498
    ExplicitWidth = 785
    inherited SB_Inserir: TSpeedButton
      Left = 8
      Width = 95
      ExplicitLeft = 0
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Alterar: TSpeedButton
      Left = 105
      Width = 95
      ExplicitLeft = 98
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Excluir: TSpeedButton
      Left = 202
      Width = 95
      ExplicitLeft = 196
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 396
      Width = 95
      ExplicitLeft = 392
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 687
      Width = 95
      Margins.Right = 1
      ExplicitLeft = 686
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Gravar: TSpeedButton
      Left = 299
      Width = 95
      ExplicitLeft = 296
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 590
      Top = 5
      Width = 95
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Imprimir - F11'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitLeft = 589
    end
    object SB_Faturar: TSpeedButton
      AlignWithMargins = True
      Left = 493
      Top = 5
      Width = 95
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Faturar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_FaturarClick
      ExplicitTop = 4
    end
  end
  inherited pnl_fundo: TPanel
    Width = 785
    Height = 498
    ExplicitWidth = 785
    ExplicitHeight = 498
    object Pnl_Abertura: TPanel
      Left = 2
      Top = 2
      Width = 781
      Height = 50
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Prazo: TLabel
        Left = 691
        Top = 4
        Width = 28
        Height = 14
        Caption = 'Prazo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 9
        Top = 3
        Width = 44
        Height = 14
        Caption = 'N'#250'mero'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lb_Numero: TLabel
        Left = 6
        Top = 19
        Width = 58
        Height = 19
        Alignment = taCenter
        Caption = '0000/07'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object L_NumeroPedido: TLabel
        Left = 89
        Top = 3
        Width = 91
        Height = 14
        AutoSize = False
        Caption = 'N'#250'mero Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Prazo: TDateTimePicker
        Left = 688
        Top = 19
        Width = 87
        Height = 21
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 2
      end
      object E_Pedido: TEdit
        Left = 87
        Top = 19
        Width = 95
        Height = 21
        AutoSize = False
        TabOrder = 0
      end
      inline Fm_ListaClientes: TFm_ListaClientes
        Left = 183
        Top = 3
        Width = 502
        Height = 39
        TabOrder = 1
        ExplicitLeft = 183
        ExplicitTop = 3
        ExplicitWidth = 502
        inherited pnl_01: TPanel
          Width = 502
          ExplicitWidth = 502
        end
        inherited pnl_02: TPanel
          Width = 502
          ExplicitWidth = 502
          inherited Sb_Pesq_Empresa: TSpeedButton
            Left = 474
            ExplicitLeft = 474
          end
          inherited SB_Empresas: TSpeedButton
            Left = 449
            ExplicitLeft = 449
          end
          inherited DBLCB_Empresa: TDBLookupComboBox
            Width = 381
            ExplicitWidth = 381
          end
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 52
      Width = 781
      Height = 225
      Align = alTop
      Caption = 'Rela'#231#227'o das Etapas'
      TabOrder = 1
      object DBG_Produtos: TDBGrid
        Left = 2
        Top = 15
        Width = 777
        Height = 208
        Align = alClient
        Color = clMoneyGreen
        DataSource = ds_itens
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Lucida Console'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowSelect]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clNavy
        TitleFont.Height = -11
        TitleFont.Name = 'Arial'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IAS_ETAPA'
            Title.Caption = 'Etapa'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IAS_DATA'
            Title.Alignment = taCenter
            Title.Caption = 'Data'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SIT_DESCRICAO'
            Title.Caption = 'Situa'#231#227'o'
            Width = 352
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IAS_DT_PREVISTA'
            Title.Alignment = taCenter
            Title.Caption = 'Data Prevista'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IAS_DT_REALIZADA'
            Title.Alignment = taCenter
            Title.Caption = 'Data Realizada'
            Width = 100
            Visible = True
          end>
      end
    end
    object grp_etapas: TGroupBox
      Left = 2
      Top = 277
      Width = 781
      Height = 219
      Align = alClient
      Caption = 'Detalhamento da Assistencia'
      TabOrder = 2
      object L_Etapa: TLabel
        Left = 7
        Top = 16
        Width = 45
        Height = 14
        AutoSize = False
        Caption = 'Etapa N'#186
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_DataRegistro: TLabel
        Left = 59
        Top = 16
        Width = 65
        Height = 14
        Caption = 'Data Registro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_DataPrevista: TLabel
        Left = 148
        Top = 16
        Width = 64
        Height = 14
        Caption = 'Data Prevista'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 679
        Top = 16
        Width = 74
        Height = 14
        AutoSize = False
        Caption = 'Custo Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 584
        Top = 16
        Width = 74
        Height = 14
        AutoSize = False
        Caption = 'Custo Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 630
        Top = 168
        Width = 91
        Height = 14
        AutoSize = False
        Caption = 'Data Realizada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 8
        Top = 55
        Width = 223
        Height = 14
        Caption = 'Descreva Detalhadamento a a'#231#227'o desta Etapa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 726
        Top = 168
        Width = 26
        Height = 14
        Caption = 'Hora '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Etapa: TEdit
        Left = 5
        Top = 31
        Width = 49
        Height = 21
        TabStop = False
        AutoSize = False
        DragMode = dmAutomatic
        ReadOnly = True
        TabOrder = 0
      end
      object E_Dt_Registro: TDateTimePicker
        Left = 57
        Top = 31
        Width = 87
        Height = 21
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object E_Descritivo: TMemo
        Left = 4
        Top = 72
        Width = 774
        Height = 90
        TabOrder = 6
      end
      object E_Vl_Custo: TEdit
        Left = 676
        Top = 31
        Width = 98
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 5
      end
      object E_Vl_Cliente: TEdit
        Left = 582
        Top = 31
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 4
      end
      object E_Dt_Realizada: TMaskEdit
        Left = 628
        Top = 183
        Width = 94
        Height = 21
        AutoSize = False
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 7
        Text = '  /  /    '
      end
      object E_Dt_Prevista: TDateTimePicker
        Left = 144
        Top = 31
        Width = 87
        Height = 21
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 2
      end
      object E_Hr_Prevista: TEdit
        Left = 724
        Top = 183
        Width = 50
        Height = 21
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        Text = '00:00'
      end
      inline Fm_ListaSituacao: TFm_ListaSituacao
        Left = 234
        Top = 17
        Width = 347
        Height = 39
        TabOrder = 3
        ExplicitLeft = 234
        ExplicitTop = 17
        ExplicitWidth = 347
        inherited Label14: TLabel
          Width = 347
          Caption = 'Situa'#231#227'o'
          ExplicitWidth = 42
        end
        inherited Sb_Cadastro: TSpeedButton
          Left = 321
          ExplicitLeft = 326
        end
        inherited DBLCB_Situacao: TDBLookupComboBox
          Width = 318
          ExplicitWidth = 318
        end
      end
    end
  end
  object cds_itens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 146
    object cds_itensIAS_CODIGO: TIntegerField
      FieldName = 'IAS_CODIGO'
      Origin = 'TB_ITENS_ASS.IAS_CODIGO'
      Required = True
    end
    object cds_itensIAS_CODASS: TIntegerField
      FieldName = 'IAS_CODASS'
      Origin = 'TB_ITENS_ASS.IAS_CODASS'
      Required = True
    end
    object cds_itensIAS_ETAPA: TIntegerField
      FieldName = 'IAS_ETAPA'
      Origin = 'TB_ITENS_ASS.IAS_ETAPA'
    end
    object cds_itensIAS_DATA: TDateField
      FieldName = 'IAS_DATA'
      Origin = 'TB_ITENS_ASS.IAS_DATA'
    end
    object cds_itensIAS_DESCRITIVO: TMemoField
      FieldName = 'IAS_DESCRITIVO'
      Origin = 'TB_ITENS_ASS.IAS_DESCRITIVO'
      BlobType = ftMemo
      Size = 8
    end
    object cds_itensIAS_DT_PREVISTA: TDateField
      FieldName = 'IAS_DT_PREVISTA'
      Origin = 'TB_ITENS_ASS.IAS_DT_PREVISTA'
      EditMask = '!99/99/0000;1;_'
    end
    object cds_itensIAS_VL_CLIENTE: TBCDField
      FieldName = 'IAS_VL_CLIENTE'
      Origin = 'TB_ITENS_ASS.IAS_VL_CLIENTE'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object cds_itensIAS_VL_CUSTO: TBCDField
      FieldName = 'IAS_VL_CUSTO'
      Origin = 'TB_ITENS_ASS.IAS_VL_CUSTO'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object cds_itensIAS_DT_REALIZADA: TDateField
      FieldName = 'IAS_DT_REALIZADA'
      Origin = 'TB_ITENS_ASS.IAS_DT_REALIZADA'
      EditMask = '!##/##/####;1;_'
    end
    object cds_itensSIT_DESCRICAO: TStringField
      FieldName = 'SIT_DESCRICAO'
      Origin = 'TB_SITUACAO.SIT_DESCRICAO'
      Size = 100
    end
    object cds_itensIAS_CODSIT: TIntegerField
      FieldName = 'IAS_CODSIT'
      Origin = 'TB_ITENS_ASS.IAS_CODSIT'
    end
    object cds_itensIAS_HOUR: TStringField
      FieldName = 'IAS_HOUR'
      Origin = '"TB_ITENS_ASS"."IAS_HOUR"'
      Size = 5
    end
  end
  object ds_itens: TDataSource
    DataSet = cds_itens
    Left = 288
    Top = 202
  end
end
