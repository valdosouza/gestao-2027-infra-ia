inherited TasMdfe: TTasMdfe
  Caption = 'Manisfeto Eletr'#244'nico'
  ClientHeight = 573
  ClientWidth = 774
  ExplicitWidth = 780
  ExplicitHeight = 617
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 509
    Width = 774
    ExplicitTop = 509
    ExplicitWidth = 774
    inherited SB_Inserir: TSpeedButton
      Left = 147
      ExplicitLeft = 256
    end
    inherited SB_Alterar: TSpeedButton
      Left = 251
      ExplicitLeft = 358
    end
    inherited SB_Excluir: TSpeedButton
      Left = 355
      ExplicitLeft = 460
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 563
      ExplicitLeft = 664
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 667
      ExplicitLeft = 768
    end
    inherited SB_Gravar: TSpeedButton
      Left = 459
      ExplicitLeft = 515
    end
  end
  inherited pnl_fundo: TPanel
    Width = 774
    Height = 509
    ExplicitWidth = 774
    ExplicitHeight = 509
    object pg_geral: TPageControl
      Left = 2
      Top = 2
      Width = 770
      Height = 505
      ActivePage = tbs_mdfe_road
      Align = alClient
      TabOrder = 0
      object tbs_mdfe: TTabSheet
        Caption = 'MDFE'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnl_mdfe: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 477
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object modelo: TLabel
            Left = 4
            Top = 4
            Width = 34
            Height = 13
            Caption = 'Modelo'
          end
          object serie: TLabel
            Left = 57
            Top = 4
            Width = 24
            Height = 13
            Caption = 'S'#233'rie'
          end
          object numero: TLabel
            Left = 108
            Top = 4
            Width = 37
            Height = 13
            Caption = 'Numero'
          end
          object dt_emissao: TLabel
            Left = 192
            Top = 4
            Width = 114
            Height = 13
            Caption = 'Data e Hora de Emiss'#227'o'
          end
          object dt_viagem: TLabel
            Left = 322
            Top = 4
            Width = 153
            Height = 13
            Caption = 'Data e Hora de Inicio de Viagem'
          end
          object modalidade: TLabel
            Left = 376
            Top = 42
            Width = 54
            Height = 13
            Caption = 'Modalidade'
          end
          object tipo_transp: TLabel
            Left = 268
            Top = 42
            Width = 107
            Height = 13
            Caption = 'Tipo de Transportador'
          end
          object tipo_EMIT: TLabel
            Left = 109
            Top = 42
            Width = 80
            Height = 13
            Caption = 'Tipo de Emitente'
          end
          object E_modelo: TEdit
            Left = 4
            Top = 19
            Width = 47
            Height = 21
            TabStop = False
            ReadOnly = True
            TabOrder = 0
          end
          object E_serie: TEdit
            Left = 54
            Top = 19
            Width = 45
            Height = 21
            TabOrder = 1
          end
          object E_numero: TEdit
            Left = 108
            Top = 19
            Width = 78
            Height = 21
            TabOrder = 2
          end
          object Cb_modalidade: TComboBox
            Left = 376
            Top = 57
            Width = 111
            Height = 21
            Style = csDropDownList
            TabOrder = 8
            Items.Strings = (
              'Rodovi'#225'rio'
              'Aquavi'#225'rio')
          end
          object Cb_tipo_de_transportador: TComboBox
            Left = 268
            Top = 57
            Width = 107
            Height = 21
            Style = csDropDownList
            TabOrder = 6
            Items.Strings = (
              ''
              'ETC'
              'TAC'
              'CTC')
          end
          object Cb_tipo_de_Emitente: TComboBox
            Left = 105
            Top = 57
            Width = 163
            Height = 21
            Style = csDropDownList
            TabOrder = 5
            Items.Strings = (
              'Prestador de Servi'#231'o de Transporte'
              'N'#227'o Prestador de Servi'#231'o de Transporte')
          end
          inline Fm_Listauf_mdfe: TFm_ListaEstados
            Left = 2
            Top = 42
            Width = 98
            Height = 38
            TabOrder = 7
            ExplicitLeft = 2
            ExplicitTop = 42
            ExplicitWidth = 98
            ExplicitHeight = 38
            inherited pnl_linha_1: TPanel
              Width = 98
              ExplicitWidth = 98
              inherited Sb_open: TSpeedButton
                Left = 74
                ExplicitLeft = 74
              end
              inherited Dblcb_Lista: TDBLookupComboBox
                Width = 74
                ExplicitWidth = 74
              end
            end
            inherited pnl_top: TPanel
              Width = 98
            end
          end
          object Dtp_Emissao: TDateTimePicker
            Left = 193
            Top = 20
            Width = 124
            Height = 21
            Date = 39580.000000000000000000
            Time = 39580.000000000000000000
            TabOrder = 3
          end
          object Dtp_Viagem: TDateTimePicker
            Left = 322
            Top = 19
            Width = 164
            Height = 21
            Date = 39580.000000000000000000
            Time = 39580.000000000000000000
            TabOrder = 4
          end
          object Grp_Totalizadores: TGroupBox
            Left = 5
            Top = 82
            Width = 481
            Height = 122
            Caption = 'Totalizadores'
            TabOrder = 9
            object Valor_total_mercadoria: TLabel
              Left = 3
              Top = 45
              Width = 217
              Height = 13
              Caption = 'Valor total da mercadoria/carga transportada'
            end
            object Quantidade_total_NFE: TLabel
              Left = 3
              Top = 18
              Width = 250
              Height = 13
              Caption = 'Quantidade total de NF-e relacionadas no Manifesto'
            end
            object Unidade_Medida_Carga: TLabel
              Left = 3
              Top = 69
              Width = 389
              Height = 13
              Caption = 
                'Codigo da unidade de medida do Peso Bruto da Carga / Mercadoria ' +
                'Transportada'
            end
            object Peso_Bruto_Total: TLabel
              Left = 3
              Top = 95
              Width = 257
              Height = 13
              Caption = 'Peso Bruto Total da Carga / Mercadoria Transportada'
            end
            object E_Qtde_Nfe: TEdit
              Left = 397
              Top = 15
              Width = 78
              Height = 21
              TabStop = False
              ReadOnly = True
              TabOrder = 2
            end
            object E_Peso_Total: TEdit
              Left = 397
              Top = 92
              Width = 78
              Height = 21
              TabOrder = 1
            end
            object Cb_Medida_Peso: TComboBox
              Left = 397
              Top = 66
              Width = 80
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              Items.Strings = (
                'KG'
                'TON')
            end
            object E_Valor_Total_Mercadoria: TEdit_Setes
              Left = 397
              Top = 40
              Width = 79
              Height = 22
              TabStop = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              Text = ''
              OnExit = E_Valor_Total_MercadoriaExit
            end
          end
          object Grp_Observacoes: TGroupBox
            Left = 5
            Top = 204
            Width = 481
            Height = 233
            Caption = 'Observa'#231#245'es'
            TabOrder = 10
            object info_fisco: TLabel
              Left = 5
              Top = 15
              Width = 211
              Height = 13
              Caption = 'Informa'#231#245'es adicionais de interesse do fisco'
            end
            object info_contribuinte: TLabel
              Left = 5
              Top = 121
              Width = 278
              Height = 13
              Caption = 'Informa'#231#245'es complementares de interesse do contribuinte'
            end
            object M_info_fisco: TMemo
              Left = 3
              Top = 31
              Width = 475
              Height = 89
              TabOrder = 0
            end
            object M_info_contribuinte: TMemo
              Left = 3
              Top = 136
              Width = 475
              Height = 89
              TabOrder = 1
            end
          end
        end
      end
      object tbs_mdfe_road: TTabSheet
        Caption = 'INFORMA'#199#213'ES DO CARREGAMENTO'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnl_mdfe_road: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 477
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object RNTRC: TLabel
            Left = 386
            Top = 1
            Width = 34
            Height = 13
            Caption = 'RNTRC'
          end
          object CodigoPorto: TLabel
            Left = 482
            Top = 1
            Width = 162
            Height = 13
            Caption = 'C'#243'digo de Agendamento do Porto'
          end
          object PlacaVeiculo: TLabel
            Left = 5
            Top = 4
            Width = 64
            Height = 14
            Caption = 'Placa Ve'#237'culo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Placa: TSpeedButton
            Left = 77
            Top = 20
            Width = 23
            Height = 21
            Caption = '...'
            OnClick = Sb_PlacaClick
          end
          object DescricaoVeiculo: TLabel
            Left = 111
            Top = 4
            Width = 97
            Height = 13
            Caption = 'Descri'#231#227'o do veiculo'
          end
          object E_codigo_agendamento_porto: TEdit
            Left = 474
            Top = 20
            Width = 271
            Height = 21
            TabOrder = 0
          end
          object E_rntrc: TEdit
            Left = 377
            Top = 20
            Width = 98
            Height = 21
            TabOrder = 1
          end
          object E_Placa: TMaskEdit
            Left = 1
            Top = 20
            Width = 74
            Height = 21
            TabOrder = 2
            Text = ''
            OnExit = E_PlacaExit
          end
          object E_MarcaModelo: TEdit
            Left = 106
            Top = 20
            Width = 271
            Height = 21
            ReadOnly = True
            TabOrder = 3
          end
          object Grp_Conductor: TGroupBox
            Left = 1
            Top = 42
            Width = 420
            Height = 145
            Caption = 'Condutor  ( 10 no max'#237'mo )'
            TabOrder = 4
            object Bt_inc_Condutor: TButton
              Left = 5
              Top = 114
              Width = 75
              Height = 25
              Caption = 'Incluir'
              TabOrder = 0
              OnClick = Bt_inc_CondutorClick
            end
            object Bt_exc_Condutor: TButton
              Left = 86
              Top = 114
              Width = 75
              Height = 25
              Caption = 'Excluir'
              TabOrder = 1
              OnClick = Bt_exc_CondutorClick
            end
            object Dbg_conductor: TDBGrid
              Left = 5
              Top = 14
              Width = 407
              Height = 97
              DataSource = ds_Conductor
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              TabOrder = 2
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CLB_NOME'
                  Title.Caption = 'Nome'
                  Width = 218
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CLB_CPF'
                  Title.Caption = 'CPF'
                  Width = 123
                  Visible = True
                end>
            end
          end
          object Grp_local_load: TGroupBox
            Left = 4
            Top = 187
            Width = 286
            Height = 281
            Caption = 'Local de Carregamento'
            TabOrder = 5
            object Grp_city_load: TGroupBox
              Left = 13
              Top = 60
              Width = 264
              Height = 183
              Caption = 'Munic'#237'pio ( 50 no max'#237'mo )'
              TabOrder = 0
            end
            object Dbg_city_load: TDBGrid
              Left = 21
              Top = 75
              Width = 248
              Height = 159
              DataSource = ds_load_local
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CDD_DESCRICAO'
                  Title.Caption = 'Cidade'
                  Width = 172
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UFE_SIGLA'
                  Title.Caption = 'Estado'
                  Width = 40
                  Visible = True
                end>
            end
            object Bt_ins_loadlocal: TButton
              Left = 29
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Incluir'
              TabOrder = 2
              OnClick = Bt_ins_loadlocalClick
            end
            object Bt_exc_loadlocal: TButton
              Left = 110
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Excluir'
              TabOrder = 3
              OnClick = Bt_exc_loadlocalClick
            end
            inline Fm_Listauf_load_local: TFm_ListaEstados
              Left = 15
              Top = 16
              Width = 98
              Height = 38
              TabOrder = 4
              ExplicitLeft = 15
              ExplicitTop = 16
              ExplicitWidth = 98
              ExplicitHeight = 38
              inherited pnl_linha_1: TPanel
                Width = 98
                ExplicitWidth = 98
                inherited Sb_open: TSpeedButton
                  Left = 74
                  ExplicitLeft = 74
                end
                inherited Dblcb_Lista: TDBLookupComboBox
                  Width = 74
                  ExplicitWidth = 74
                end
              end
              inherited pnl_top: TPanel
                Width = 98
              end
            end
            inline Fm_lista_cidades_load_local: TFmListaCidades
              Left = 114
              Top = 16
              Width = 140
              Height = 45
              TabOrder = 5
              ExplicitLeft = 114
              ExplicitTop = 16
              ExplicitHeight = 45
              inherited Qr_Cidade: TSTQuery
                Top = 44
              end
              inherited Ds_Cidade: TDataSource
                Top = 45
              end
            end
          end
          object Grp_route: TGroupBox
            Left = 289
            Top = 187
            Width = 180
            Height = 281
            Caption = 'UF do Percurso'
            TabOrder = 6
            object Grp_uf_route: TGroupBox
              Left = 8
              Top = 60
              Width = 165
              Height = 183
              Caption = 'UF'#39's ( 25 no max'#237'mo )'
              TabOrder = 0
            end
            object Dbg_uf_route: TDBGrid
              Left = 7
              Top = 84
              Width = 151
              Height = 159
              DataSource = ds_state_route
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'UFE_SIGLA'
                  Title.Caption = 'Estado'
                  Width = 126
                  Visible = True
                end>
            end
            object Bt_ins_uf_route: TButton
              Left = 16
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Incluir'
              TabOrder = 2
              OnClick = Bt_ins_uf_routeClick
            end
            object Bt_exc_uf_route: TButton
              Left = 98
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Excluir'
              TabOrder = 3
              OnClick = Bt_exc_uf_routeClick
            end
            inline Fm_Listauf_Route: TFm_ListaEstados
              Left = 9
              Top = 16
              Width = 98
              Height = 38
              TabOrder = 4
              ExplicitLeft = 9
              ExplicitTop = 16
              ExplicitWidth = 98
              ExplicitHeight = 38
              inherited pnl_linha_1: TPanel
                Width = 98
                ExplicitWidth = 98
                inherited Sb_open: TSpeedButton
                  Left = 74
                  ExplicitLeft = 74
                end
                inherited Dblcb_Lista: TDBLookupComboBox
                  Width = 74
                  ExplicitWidth = 74
                end
              end
              inherited pnl_top: TPanel
                Width = 98
              end
            end
          end
          object Grp_local_unload: TGroupBox
            Left = 468
            Top = 187
            Width = 286
            Height = 281
            Caption = 'Local de Descarregamento'
            TabOrder = 7
            object Grp_city_unload: TGroupBox
              Left = 13
              Top = 60
              Width = 264
              Height = 183
              Caption = 'Munic'#237'pio ( 50 no max'#237'mo )'
              TabOrder = 0
            end
            object Dbg_city_unload: TDBGrid
              Left = 21
              Top = 75
              Width = 248
              Height = 159
              DataSource = ds_unload_local
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CDD_DESCRICAO'
                  Title.Caption = 'Cidade'
                  Width = 172
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UFE_SIGLA'
                  Title.Caption = 'Estado'
                  Width = 40
                  Visible = True
                end>
            end
            object Bt_ins_unloadlocal: TButton
              Left = 29
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Incluir'
              TabOrder = 2
              OnClick = Bt_ins_unloadlocalClick
            end
            object Bt_exc_unloadlocal: TButton
              Left = 110
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Excluir'
              TabOrder = 3
              OnClick = Bt_exc_unloadlocalClick
            end
            inline Fm_Listauf_Unload_local: TFm_ListaEstados
              Left = 16
              Top = 16
              Width = 98
              Height = 38
              TabOrder = 4
              ExplicitLeft = 16
              ExplicitTop = 16
              ExplicitWidth = 98
              ExplicitHeight = 38
              inherited pnl_linha_1: TPanel
                Width = 98
                ExplicitWidth = 98
                inherited Sb_open: TSpeedButton
                  Left = 74
                  ExplicitLeft = 74
                end
                inherited Dblcb_Lista: TDBLookupComboBox
                  Width = 74
                  ExplicitWidth = 74
                end
              end
              inherited pnl_top: TPanel
                Width = 98
              end
            end
            inline Fm_lista_cidades_unload_local: TFmListaCidades
              Left = 115
              Top = 16
              Width = 140
              Height = 45
              TabOrder = 5
              ExplicitLeft = 115
              ExplicitTop = 16
              ExplicitHeight = 45
            end
          end
        end
      end
      object tbs_mdfe_cte_nfe: TTabSheet
        Caption = 'INFORMA'#199#213'ES NFE'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnl_mdfe_nfe: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 477
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Grp_Nfe: TGroupBox
            Left = -6
            Top = 0
            Width = 626
            Height = 241
            Caption = 'NFE'
            TabOrder = 0
            object GroupBox6: TGroupBox
              Left = 10
              Top = 13
              Width = 613
              Height = 187
              Caption = ' ( 10 no max'#237'mo )'
              TabOrder = 0
            end
            object Dbg_nfe: TDBGrid
              Left = 13
              Top = 28
              Width = 608
              Height = 167
              DataSource = ds_nfe
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'NFE_NOTA_INI'
                  Title.Caption = 'N'#250'mero'
                  Width = 74
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NFE_ARQUIVO'
                  Title.Caption = 'Chave'
                  Width = 466
                  Visible = True
                end
                item
                  Expanded = False
                  Visible = True
                end>
            end
            object Bt_inc_Nfe: TButton
              Left = 13
              Top = 206
              Width = 75
              Height = 25
              Caption = 'Incluir'
              TabOrder = 2
              OnClick = Bt_inc_NfeClick
            end
            object Bt_exc_Nfe: TButton
              Left = 94
              Top = 206
              Width = 75
              Height = 25
              Caption = 'Excluir'
              TabOrder = 3
              OnClick = Bt_exc_NfeClick
            end
          end
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 544
    Top = 40
    inherited arefas1: TMenuItem
      object Configuraes1: TMenuItem [0]
        Caption = 'Configura'#231#245'es'
        OnClick = Configuraes1Click
      end
      object OperaesMDFe1: TMenuItem [1]
        Caption = 'Opera'#231#245'es MDF-e'
        OnClick = OperaesMDFe1Click
      end
    end
  end
  object STQuery1: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      'NFE_CODNFL,'
      'NFE_NOTA_INI,'
      'NFE_ARQUIVO,'
      'N.nfl_vl_tl_nota'
      'FROM tb_nota_fiscal N'
      '  INNER JOIN tb_retorno_nfe R'
      '  ON (R.nfe_codnfl = N.nfl_codigo)')
    Left = 718
    Top = 42
  end
  object cds_load_local: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 696
    Top = 114
    object cds_load_localUFE_CODIGO: TIntegerField
      FieldName = 'UFE_CODIGO'
      Required = True
    end
    object cds_load_localUFE_SIGLA: TWideStringField
      FieldName = 'UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object cds_load_localCDD_CODIGO: TIntegerField
      FieldName = 'CDD_CODIGO'
      Required = True
    end
    object cds_load_localCDD_DESCRICAO: TWideStringField
      FieldName = 'CDD_DESCRICAO'
      Size = 60
    end
  end
  object ds_load_local: TDataSource
    DataSet = cds_load_local
    Left = 768
    Top = 114
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = STQuery1
    Left = 790
    Top = 42
  end
  object cds_state_route: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 688
    Top = 178
    object cds_state_routeTB_STATE_ID: TIntegerField
      FieldName = 'TB_STATE_ID'
      Origin = '"TB_MDFE_STATE_ROUTE"."TB_STATE_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_state_routeUFE_SIGLA: TWideStringField
      FieldName = 'UFE_SIGLA'
      Origin = '"TB_UF"."UFE_SIGLA"'
      Size = 2
    end
  end
  object ds_state_route: TDataSource
    DataSet = cds_state_route
    Left = 696
    Top = 242
  end
  object ds_unload_local: TDataSource
    DataSet = cds_unload_local
    Left = 784
    Top = 242
  end
  object cds_unload_local: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 776
    Top = 178
    object cds_unload_localUFE_CODIGO: TIntegerField
      FieldName = 'UFE_CODIGO'
      Origin = '"TB_UF"."UFE_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_unload_localUFE_SIGLA: TWideStringField
      FieldName = 'UFE_SIGLA'
      Origin = '"TB_UF"."UFE_SIGLA"'
      Size = 2
    end
    object cds_unload_localCDD_CODIGO: TIntegerField
      FieldName = 'CDD_CODIGO'
      Origin = '"TB_CIDADE"."CDD_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_unload_localCDD_DESCRICAO: TWideStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = '"TB_CIDADE"."CDD_DESCRICAO"'
      Size = 60
    end
  end
  object cds_conductor: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CLB_CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CLB_NOME'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CLB_CPF'
        DataType = ftWideString
        Size = 14
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 696
    Top = 306
    object cds_conductorCLB_CODIGO: TIntegerField
      FieldName = 'CLB_CODIGO'
      Origin = '"TB_COLABORADOR"."CLB_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_conductorCLB_NOME: TWideStringField
      FieldName = 'CLB_NOME'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 100
    end
    object cds_conductorCLB_CPF: TWideStringField
      FieldName = 'CLB_CPF'
      Origin = '"TB_COLABORADOR"."CLB_CPF"'
      Size = 14
    end
  end
  object ds_Conductor: TDataSource
    DataSet = cds_conductor
    Left = 784
    Top = 306
  end
  object cds_nfe: TClientDataSet
    PersistDataPacket.Data = {
      A00000009619E0BD010000001800000004000000000003000000A0000A4E4645
      5F434F444E464C04000100040000000C4E46455F4E4F54415F494E4901004A00
      000001000557494454480200020014000B4E46455F4152515549564F02004A00
      0000010005574944544802000200FE010E4E464C5F564C5F544C5F4E4F54410B
      0005000000020008444543494D414C5302000200020005574944544802000200
      12000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NFE_CODNFL'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NFE_NOTA_INI'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'NFE_ARQUIVO'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'NFL_VL_TL_NOTA'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 688
    Top = 378
    object cds_nfeNFE_CODNFL: TIntegerField
      FieldName = 'NFE_CODNFL'
      Required = True
    end
    object cds_nfeNFE_NOTA_INI: TWideStringField
      FieldName = 'NFE_NOTA_INI'
      Size = 10
    end
    object cds_nfeNFE_ARQUIVO: TWideStringField
      FieldName = 'NFE_ARQUIVO'
      Size = 255
    end
    object cds_nfeNFL_VL_TL_NOTA: TBCDField
      FieldName = 'NFL_VL_TL_NOTA'
      Precision = 18
      Size = 2
    end
  end
  object ds_nfe: TDataSource
    DataSet = cds_nfe
    Left = 768
    Top = 378
  end
end
