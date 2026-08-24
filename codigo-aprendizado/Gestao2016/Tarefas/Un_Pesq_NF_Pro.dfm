inherited Fr_Pesq_NF_Pro: TFr_Pesq_NF_Pro
  Caption = 'Pesquisar Notas Fiscal de Produtos'
  ClientWidth = 1066
  ExplicitWidth = 1082
  ExplicitHeight = 719
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    Width = 1066
    Height = 200
    ExplicitWidth = 1066
    ExplicitHeight = 200
    inherited E_BuscaRazao: TMaskEdit
      Width = 520
      TabOrder = 5
      ExplicitWidth = 520
    end
    inherited E_BuscaObs: TMaskEdit
      TabOrder = 12
    end
    inherited E_Data_Fim: TDateTimePicker
      Left = 86
      ExplicitLeft = 86
    end
    inherited E_BuscaBairro: TMaskEdit
      TabOrder = 6
    end
    inherited E_BuscaRegiao: TMaskEdit
      TabOrder = 7
    end
    inherited E_BuscaEstado: TMaskEdit
      BevelOuter = bvNone
      TabOrder = 8
    end
    inherited E_BuscaCidade: TMaskEdit
      TabOrder = 9
    end
    inherited E_BuscaFone: TEdit_Setes
      Width = 134
      TabOrder = 10
      ExplicitWidth = 134
    end
    inherited Dblcb_BuscaVendedor: TDBLookupComboBox
      TabOrder = 11
    end
    inherited RG_Tipo_Operacao: TRadioGroup
      Left = 966
      Top = 91
      Width = 97
      Enabled = True
      ItemIndex = 2
      ExplicitLeft = 966
      ExplicitTop = 91
      ExplicitWidth = 97
    end
    inherited E_BuscaPedido: TMaskEdit
      TabOrder = 3
    end
    inherited E_BuscaEmpresa: TEdit
      TabOrder = 4
    end
    inherited Rg_Sit_Nfe: TRadioGroup
      Width = 634
      Columns = 6
      ItemIndex = 5
      Items.Strings = (
        'Pendentes'
        'Enviadas'
        'Autorizadas'
        'Canceladas'
        'Denegada'
        'Todas')
      ExplicitWidth = 634
    end
    inherited Rg_Tipo_Nota: TGroupBox
      Left = 966
      Width = 97
      TabOrder = 20
      ExplicitLeft = 966
      ExplicitWidth = 97
      inherited ChBx_Vendas: TCheckBox
        Top = 14
        ExplicitTop = 14
      end
      inherited ChBx_Compras: TCheckBox
        Top = 34
        ExplicitTop = 34
      end
    end
    inherited E_BuscaSerie: TMaskEdit
      TabOrder = 13
    end
    inherited ChBx_Venda_Numerada: TCheckBox
      TabOrder = 22
    end
    inherited Fm_lista_cfop: TFm_lista_cfop
      inherited pnl_top: TPanel
        inherited L_name_list: TLabel
          Width = 359
          Height = 16
        end
      end
    end
    object Rg_Modelo: TRadioGroup
      Left = 643
      Top = 135
      Width = 317
      Height = 39
      Caption = 'Tipo de Nota Fiscal'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'NF-e'
        'NFC-e'
        'Todas')
      TabOrder = 19
      OnClick = Rg_ModeloClick
    end
  end
  inherited Panel4: TPanel
    Top = 257
    Width = 1066
    Height = 423
    ExplicitTop = 257
    ExplicitWidth = 1066
    ExplicitHeight = 423
    inherited Panel1: TPanel
      Left = 964
      Height = 419
      ExplicitLeft = 964
      ExplicitHeight = 419
      inherited SB_Buscar: TSpeedButton
        Top = 254
        ExplicitLeft = 912
        ExplicitTop = 281
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 308
        ExplicitLeft = 919
        ExplicitTop = 294
      end
      inherited SB_Sair_0: TSpeedButton
        Top = 362
        ExplicitLeft = 6
        ExplicitTop = 348
      end
      inherited Lb_TotalVendas: TLabel
        ExplicitLeft = 908
        ExplicitWidth = 95
      end
      inherited E_TotalVenda: TLabel
        ExplicitLeft = 908
        ExplicitWidth = 95
      end
      inherited Lb_NumeroVendas: TLabel
        ExplicitLeft = 908
        ExplicitWidth = 95
      end
      inherited E_NumeroVendas: TLabel
        ExplicitLeft = 908
        ExplicitWidth = 95
      end
      inherited Lb_TicketMedia: TLabel
        ExplicitLeft = 908
        ExplicitWidth = 95
      end
      inherited E_TicketMedia: TLabel
        ExplicitLeft = 908
        ExplicitWidth = 95
      end
    end
    inherited Pg_Resultado: TPageControl
      Width = 962
      Height = 419
      ActivePage = tbs_resultado
      ExplicitWidth = 962
      ExplicitHeight = 419
      inherited tbs_resultado: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 954
        ExplicitHeight = 391
        inherited DBG_Pesquisa: TDBGrid
          Width = 954
          Height = 391
        end
      end
      inherited tbs_resumo: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 954
        ExplicitHeight = 391
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 954
          Height = 391
          Align = alClient
          DataSource = Ds_Res_Hora
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
  end
  inherited Fm_LME: TFm_ListaMultiEmpresa
    Width = 1066
    ExplicitWidth = 1066
    inherited pnl_linha_1: TPanel
      Width = 1066
      ExplicitWidth = 1066
      inherited Sb_open: TSpeedButton
        Left = 1042
        ExplicitLeft = 1042
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 1042
        ExplicitWidth = 1042
      end
    end
    inherited pnl_top: TPanel
      Width = 1066
      ExplicitWidth = 1066
      inherited L_name_list: TLabel
        Width = 1043
        Height = 16
      end
    end
  end
  inherited Ds_Pesquisa: TDataSource
    Left = 453
    Top = 163
  end
  inherited Qr_Pesquisa: TSTQuery
    SQL.Strings = (
      'SELECT NFL_CODIGO, PED_NUMERO, NFL_NUMERO, NFL_DT_EMISSAO,'
      
        'EMP_FANTASIA,NFL_HR_SAIDA, EMP_NOME,NFL_VL_TL_NOTA,NFL_MODELO, N' +
        'FL_SERIE,PED_CODVDO'
      'FROM TB_NOTA_FISCAL Tb_nota_fiscal'
      '  INNER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      '  INNER JOIN TB_PEDIDO tb_pedido'
      '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)')
    Left = 448
    Top = 120
  end
  object Qr_Res_Hora: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Listas
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT extract(HOUR FROM nfl_hr_saida) Hora, sum(n.nfl_vl_tl_not' +
        'a) TotalVenda ,count(n.nfl_codigo) QtdeVenda,  avg(n.nfl_vl_tl_n' +
        'ota) TicketMedio'
      'FROM tb_nota_fiscal n'
      'where (nfl_hr_saida is not null)'
      'GROUP BY extract(HOUR FROM nfl_hr_saida)')
    Left = 568
    Top = 112
    object Qr_Res_HoraHORA: TSmallintField
      Alignment = taCenter
      DisplayLabel = 'Hora'
      DisplayWidth = 12
      FieldName = 'HORA'
      ProviderFlags = []
      DisplayFormat = '00'
    end
    object Qr_Res_HoraTOTALVENDA: TBCDField
      DisplayLabel = 'Total de Vendas'
      DisplayWidth = 24
      FieldName = 'TOTALVENDA'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Res_HoraQTDEVENDA: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'N'#250'mero de Vendas'
      DisplayWidth = 20
      FieldName = 'QTDEVENDA'
      ProviderFlags = []
    end
    object Qr_Res_HoraTICKETMEDIO: TBCDField
      DisplayLabel = 'Ticket M'#233'dio'
      DisplayWidth = 18
      FieldName = 'TICKETMEDIO'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object Ds_Res_Hora: TDataSource
    DataSet = Qr_Res_Hora
    Left = 573
    Top = 163
  end
end
