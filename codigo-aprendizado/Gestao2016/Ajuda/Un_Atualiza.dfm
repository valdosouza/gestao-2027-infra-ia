object Fr_Atualiza: TFr_Atualiza
  Left = 0
  Top = 0
  Caption = 'Atualiza'#231#227'o e Ajustes'
  ClientHeight = 432
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 766
    Height = 368
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object tbs_migracao: TTabSheet
      Caption = 'Migra'#231#227'o'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 758
        Height = 340
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 748
          Height = 13
          Align = alTop
          Caption = 'Informar o local do Novo Banco de dados'
          ExplicitWidth = 197
        end
        object Sb_migracao: TSpeedButton
          Left = 8
          Top = 83
          Width = 113
          Height = 33
          Caption = 'Executar Migra'#231#227'o'
          OnClick = Sb_migracaoClick
        end
        object pnl_migracao_Local_banco: TPanel
          Left = 2
          Top = 21
          Width = 754
          Height = 29
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Sb_migracao_Local_banco: TSpeedButton
            AlignWithMargins = True
            Left = 728
            Top = 3
            Width = 23
            Height = 23
            Align = alRight
            Caption = '...'
            ExplicitLeft = 440
            ExplicitTop = 19
            ExplicitHeight = 22
          end
          object E_migracao_Local_banco: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 719
            Height = 23
            Align = alClient
            TabOrder = 0
            Text = 'NOTEVALDO/3050:D:\Modelos\SpaceSound\Database\Dados.fdb'
            ExplicitHeight = 21
          end
        end
        object Cb_TipoBancoDados: TComboBox
          Left = 8
          Top = 56
          Width = 489
          Height = 21
          Style = csDropDownList
          ItemIndex = 13
          TabOrder = 1
          Text = 'ALEGRITOS'
          OnChange = Cb_TipoBancoDadosChange
          Items.Strings = (
            'Sistema Gest'#227'o Antigo'
            'Sistema GDOOR'
            'Sistema Gest'#227'o -> Gest'#227'o - Compara Produtos'
            'ODBC Produtos - Produtos para TB_Produto'
            'Pantera - Somente produto com Tabela integrada via Scrip'
            'Sistema WinSic'
            'TB_PROD_MIGRA(DESCRICAO/EAN/CODIGO/PRECO)'
            'TB_PRO_SIST_UNICO'
            'MigraXML_TO_XML_gestao'
            'Excelent'
            'Uniplus'
            'Louren'#231'o'
            'Tecno - SpaceSound'
            'ALEGRITOS')
        end
      end
    end
    object tbs_produtos: TTabSheet
      Caption = 'Produtos'
      ImageIndex = 1
      OnShow = tbs_produtosShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 758
        Height = 340
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object SpeedButton27: TSpeedButton
          Left = 8
          Top = 141
          Width = 201
          Height = 36
          Caption = 'Ajustar Duplicados na Tabela de Preco'
          OnClick = SpeedButton27Click
        end
        object SpeedButton2: TSpeedButton
          Left = 8
          Top = 183
          Width = 201
          Height = 36
          Caption = 'Exportar Imagens para o Servidor (Tray)'
          OnClick = SpeedButton2Click
        end
        object Sb_ReordenaProduto: TButton
          Left = 8
          Top = 16
          Width = 201
          Height = 25
          Caption = 'Reordenar Sequencia Produtos'
          TabOrder = 0
          OnClick = Sb_ReordenaProdutoClick
        end
        object Sb_AjustaGenerator: TButton
          Left = 8
          Top = 79
          Width = 201
          Height = 25
          Caption = 'Ajustar os Generator'
          TabOrder = 1
          OnClick = Sb_AjustaGeneratorClick
        end
        object Sb_VincularTabelaPreco: TButton
          Left = 8
          Top = 47
          Width = 201
          Height = 25
          Caption = 'Vincular TAbela de Pre'#231'o'
          TabOrder = 2
          OnClick = Sb_VincularTabelaPrecoClick
        end
        object Sb_GrupoToCategoria: TButton
          Left = 8
          Top = 110
          Width = 201
          Height = 25
          Caption = 'Migrar Grupo para Catetoria'
          TabOrder = 3
          OnClick = Sb_GrupoToCategoriaClick
        end
        object Pnl_Invent_movimentacao: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 266
          Width = 748
          Height = 69
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 4
          object Label3: TLabel
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 738
            Height = 13
            Align = alTop
            Caption = 'Recontagem/Auditoria por data'
            ExplicitWidth = 151
          end
          object SpeedButton1: TSpeedButton
            Left = 489
            Top = 24
            Width = 201
            Height = 36
            Caption = 'Processar Recontagem'
            OnClick = SpeedButton1Click
          end
          object Chbx_Inventario_Movimento: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 24
            Width = 738
            Height = 12
            Align = alTop
            Caption = 'Data Inicial             Data Final'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object E_Dt_Inicio_Movimento: TDateTimePicker
            Left = 7
            Top = 40
            Width = 100
            Height = 22
            Date = 39580.000000000000000000
            Time = 39580.000000000000000000
            TabOrder = 1
          end
          object E_Dt_Fim_Movimento: TDateTimePicker
            Left = 111
            Top = 40
            Width = 100
            Height = 22
            Date = 39580.999988425930000000
            Time = 39580.999988425930000000
            TabOrder = 2
          end
          inline Fm_ListaEstoques: TFm_ListaEstoques
            Left = 217
            Top = 9
            Width = 260
            Height = 36
            TabOrder = 3
            ExplicitLeft = 217
            ExplicitTop = 9
            ExplicitWidth = 260
            inherited Label1: TLabel
              Width = 255
            end
            inherited Sb_Cadastro: TSpeedButton
              Left = 237
              ExplicitLeft = 234
              ExplicitHeight = 13
            end
            inherited Dblcb_Estoque: TDBLookupComboBox
              Width = 225
              ExplicitWidth = 225
            end
            inherited ChBx_Estoques: TCheckBox
              Left = 154
              OnClick = nil
              ExplicitLeft = 154
            end
            inherited Qr_Estoques: TSTQuery
              Transaction = DM.IBT_Consulta
              UpdateTransaction = DM.IBT_Consulta
            end
          end
        end
        object Button2: TButton
          Left = 215
          Top = 16
          Width = 201
          Height = 25
          Caption = 'Atualizar o Ultimo custo de Compra '
          TabOrder = 5
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 215
          Top = 47
          Width = 201
          Height = 25
          Caption = 'Insere ICMS nos itens de Venda'
          TabOrder = 6
          OnClick = Button3Click
        end
      end
    end
    object tbs_ler_arquivo_Diretorio: TTabSheet
      Caption = 'Ler Arquivos Diretorio'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 758
        Height = 41
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Panel7'
        TabOrder = 0
        object SpeedButton3: TSpeedButton
          Left = 527
          Top = 13
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SpeedButton3Click
        end
        object E_PathDiretorio: TEdit
          Left = 8
          Top = 8
          Width = 513
          Height = 21
          TabOrder = 0
          Text = 'E_PathDiretorio'
        end
        object Button57: TButton
          Left = 8
          Top = 345
          Width = 201
          Height = 25
          Caption = 'Importar xml PARA TB_ARQUIVOS'
          TabOrder = 1
        end
        object E_Dt_Ini_Ler_Arquivo: TDateTimePicker
          Left = 214
          Top = 346
          Width = 94
          Height = 21
          Date = 42186.830458981480000000
          Time = 42186.830458981480000000
          TabOrder = 2
        end
        object E_Dt_Fim_Ler_Arquivo: TDateTimePicker
          Left = 311
          Top = 346
          Width = 93
          Height = 21
          Date = 42216.830523182870000000
          Time = 42216.830523182870000000
          TabOrder = 3
        end
      end
      object MM_ListaArquivos: TMemo
        Left = 0
        Top = 41
        Width = 758
        Height = 299
        Align = alClient
        Lines.Strings = (
          'MM_ListaArquivos')
        TabOrder = 1
      end
    end
    object tbs_financeiro: TTabSheet
      Caption = 'Financeiro'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Left = 2
        Top = 0
        Width = 53
        Height = 13
        Caption = 'Data Inicial'
      end
      object Label6: TLabel
        Left = 106
        Top = 0
        Width = 48
        Height = 13
        Caption = 'Data Final'
      end
      object BitBtn2: TBitBtn
        Left = 3
        Top = 43
        Width = 145
        Height = 37
        Caption = 'Gerar Contas a Receber'
        TabOrder = 0
        OnClick = BitBtn2Click
      end
      object E_Dt_Inicial_R: TDateTimePicker
        Left = 2
        Top = 16
        Width = 97
        Height = 21
        Date = 40455.653572604170000000
        Time = 40455.653572604170000000
        TabOrder = 1
      end
      object E_Dt_Final_R: TDateTimePicker
        Left = 106
        Top = 16
        Width = 97
        Height = 21
        Date = 40455.653572604170000000
        Time = 40455.653572604170000000
        TabOrder = 2
      end
    end
    object tbs_pizzaria: TTabSheet
      Caption = 'Pizzaria'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Sb_Clone_Pizza_Calzone: TBitBtn
        Left = 3
        Top = 3
        Width = 145
        Height = 37
        Caption = 'Clonar Pizza para Calzone'
        TabOrder = 0
        OnClick = Sb_Clone_Pizza_CalzoneClick
      end
    end
    object tbs_payback: TTabSheet
      Caption = 'PayBack'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Button1: TButton
        Left = 3
        Top = 3
        Width = 201
        Height = 25
        Caption = 'Coloca data de Vencimento do PayBack'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button4: TButton
        Left = 3
        Top = 57
        Width = 201
        Height = 25
        Caption = 'Registra utiliza'#231#227'o de cr'#233'dito'
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 3
        Top = 88
        Width = 201
        Height = 25
        Caption = 'Registra cr'#233'dito expirado'
        TabOrder = 2
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 3
        Top = 30
        Width = 201
        Height = 25
        Caption = 'Corrigir conceito de cr'#233'dito estornado'
        TabOrder = 3
        OnClick = Button6Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Button7: TButton
        Left = 11
        Top = 11
        Width = 201
        Height = 25
        Caption = 'Atualizar E_Class'
        TabOrder = 0
        OnClick = Button7Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 368
    Width = 766
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Sair_0: TSpeedButton
      Left = 669
      Top = 2
      Width = 95
      Height = 60
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
      ExplicitLeft = 671
    end
    object gg_progresso: TGauge
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 647
      Height = 40
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Progress = 0
      ExplicitLeft = 0
      ExplicitTop = -702
      ExplicitWidth = 100
      ExplicitHeight = 766
    end
  end
  object Qr_Produto: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    UpdateTransaction = DM.IBT_Consulta
    SQL.Strings = (
      '--Pedido de venda n'#227'o faturado'
      
        'SELECT DISTINCT PRO_CODIGO, it.itf_codest EST_CODETS, PRO_COMPOS' +
        'ICAO'
      'FROM tb_itens_nfl it'
      '    inner join TB_pedido pd'
      '    on (pd.ped_codigo = it.itf_codped)'
      '    INNER JOIN TB_PRODUTO pr'
      '    on (pr.pro_codigo = it.itf_codpro)'
      'WHERE pd.ped_faturado = '#39'N'#39' and pd.ped_tipo = 1'
      'and PD.ped_data BETWEEN :DATAINI AND :DATAFIM'
      'AND it.itf_estoque = '#39'S'#39
      'and it.itf_codest =:EST_CODIGO'
      'union'
      '--Todos pedidos aturado'
      
        'SELECT DISTINCT PRO_CODIGO, it.itf_codest EST_CODETS, PRO_COMPOS' +
        'ICAO'
      'FROM tb_itens_nfl it'
      '    inner join TB_pedido pd'
      '    on (pd.ped_codigo = it.itf_codped)'
      '    inner join tb_nota_fiscal nf'
      '    on (nf.nfl_codped = PD.ped_codigo)'
      '    INNER JOIN TB_PRODUTO pr'
      '    on (pr.pro_codigo = it.itf_codpro)'
      'WHERE nf.nfl_status = '#39'F'#39
      'and NF.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM'
      'AND it.itf_estoque = '#39'S'#39
      'and it.itf_codest =:EST_CODIGO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 144
    Top = 229
    ParamData = <
      item
        Name = 'DATAINI'
      end
      item
        Name = 'DATAFIM'
      end
      item
        Name = 'EST_CODIGO'
      end
      item
        Name = 'DATAINI'
      end
      item
        Name = 'DATAFIM'
      end
      item
        Name = 'EST_CODIGO'
      end>
  end
  object DBUniplus: TSQLConnection
    DriverName = 'PostgreSQL'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=PostgreSQL'
      'HostName=127.0.0.1'
      'Database=postgres'
      'User_Name=postgres'
      'Password=Sucesso!')
    Left = 44
    Top = 208
  end
  object Qr_UniPlus_Produto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'SELECT id,dataalteracao, codigo, ean, inativo, nome,  tipo,  uni' +
        'dademedida, preco,lucrobruto,  peso, observacao,'
      'precocusto,customedio, quantidademinima, ncm,  cest'
      'FROM public.produto'
      'where inativo = 0'
      'and tipo = '#39'P'#39)
    SQLConnection = DBUniplus
    Left = 44
    Top = 328
    object Qr_UniPlus_Produtoid: TLargeintField
      FieldName = 'id'
    end
    object Qr_UniPlus_Produtodataalteracao: TSQLTimeStampField
      FieldName = 'dataalteracao'
    end
    object Qr_UniPlus_Produtocodigo: TWideStringField
      FieldName = 'codigo'
    end
    object Qr_UniPlus_Produtoean: TWideStringField
      FieldName = 'ean'
    end
    object Qr_UniPlus_Produtoinativo: TSmallintField
      FieldName = 'inativo'
    end
    object Qr_UniPlus_Produtonome: TWideStringField
      FieldName = 'nome'
      Size = 120
    end
    object Qr_UniPlus_Produtotipo: TWideStringField
      FieldName = 'tipo'
      FixedChar = True
      Size = 1
    end
    object Qr_UniPlus_Produtopreco: TFMTBCDField
      FieldName = 'preco'
      Precision = 15
      Size = 6
    end
    object Qr_UniPlus_Produtolucrobruto: TBCDField
      FieldName = 'lucrobruto'
      Precision = 12
      Size = 2
    end
    object Qr_UniPlus_Produtopeso: TBCDField
      FieldName = 'peso'
      Precision = 12
      Size = 3
    end
    object Qr_UniPlus_Produtoobservacao: TWideMemoField
      FieldName = 'observacao'
      BlobType = ftWideMemo
    end
    object Qr_UniPlus_Produtoprecocusto: TFMTBCDField
      FieldName = 'precocusto'
      Precision = 15
      Size = 6
    end
    object Qr_UniPlus_Produtocustomedio: TFMTBCDField
      FieldName = 'customedio'
      Precision = 15
      Size = 6
    end
    object Qr_UniPlus_Produtoquantidademinima: TFMTBCDField
      FieldName = 'quantidademinima'
      Precision = 15
      Size = 6
    end
    object Qr_UniPlus_Produtoncm: TWideStringField
      FieldName = 'ncm'
      Size = 10
    end
    object Qr_UniPlus_Produtocest: TWideStringField
      FieldName = 'cest'
      Size = 10
    end
    object Qr_UniPlus_Produtounidademedida: TWideStringField
      FieldName = 'unidademedida'
      Origin = 'unidademedida'
      Size = 6
    end
  end
  object SQLConnection1: TSQLConnection
    Left = 236
    Top = 160
  end
  object Qr_prod_xls: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    UpdateTransaction = DM.IBT_Consulta
    SQL.Strings = (
      'select *'
      'from prod_xls')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 224
    Top = 229
    object Qr_prod_xlsCODIGO_PROD: TStringField
      FieldName = 'CODIGO_PROD'
      Origin = '"PROD_XLS"."CODIGO_PROD"'
      Required = True
      Size = 15
    end
    object Qr_prod_xlsCODFORN_PROD: TIntegerField
      FieldName = 'CODFORN_PROD'
      Origin = '"PROD_XLS"."CODFORN_PROD"'
      Required = True
    end
    object Qr_prod_xlsCODMARCA_PROD: TFloatField
      FieldName = 'CODMARCA_PROD'
      Origin = '"PROD_XLS"."CODMARCA_PROD"'
    end
    object Qr_prod_xlsUNIDADE_PROD: TStringField
      FieldName = 'UNIDADE_PROD'
      Origin = '"PROD_XLS"."UNIDADE_PROD"'
      Size = 3
    end
    object Qr_prod_xlsCODCATEG_PROD: TFloatField
      FieldName = 'CODCATEG_PROD'
      Origin = '"PROD_XLS"."CODCATEG_PROD"'
    end
    object Qr_prod_xlsDESCRICAO_PROD: TStringField
      FieldName = 'DESCRICAO_PROD'
      Origin = '"PROD_XLS"."DESCRICAO_PROD"'
      Size = 100
    end
    object Qr_prod_xlsPRECOPADRAO_PROD: TFloatField
      FieldName = 'PRECOPADRAO_PROD'
      Origin = '"PROD_XLS"."PRECOPADRAO_PROD"'
    end
    object Qr_prod_xlsPRECOCUSTO_PROD: TFloatField
      FieldName = 'PRECOCUSTO_PROD'
      Origin = '"PROD_XLS"."PRECOCUSTO_PROD"'
    end
    object Qr_prod_xlsREFERENCIA_PROD: TStringField
      FieldName = 'REFERENCIA_PROD'
      Origin = '"PROD_XLS"."REFERENCIA_PROD"'
    end
    object Qr_prod_xlsTRIBUTACAO_PROD: TStringField
      FieldName = 'TRIBUTACAO_PROD'
      Origin = '"PROD_XLS"."TRIBUTACAO_PROD"'
      Size = 10
    end
    object Qr_prod_xlsLUCRO_PROD: TFloatField
      FieldName = 'LUCRO_PROD'
      Origin = '"PROD_XLS"."LUCRO_PROD"'
    end
    object Qr_prod_xlsPRECOVISTA_PROD: TFloatField
      FieldName = 'PRECOVISTA_PROD'
      Origin = '"PROD_XLS"."PRECOVISTA_PROD"'
    end
    object Qr_prod_xlsPRECOPRAZO_PROD: TFloatField
      FieldName = 'PRECOPRAZO_PROD'
      Origin = '"PROD_XLS"."PRECOPRAZO_PROD"'
    end
    object Qr_prod_xlsFIS_NCM_PROD: TStringField
      FieldName = 'FIS_NCM_PROD'
      Origin = '"PROD_XLS"."FIS_NCM_PROD"'
      Size = 10
    end
    object Qr_prod_xlsCEST: TStringField
      FieldName = 'CEST'
      Origin = '"PROD_XLS"."CEST"'
      Size = 10
    end
  end
  object Qr_Pessoa_tecno: TSTQuery
    Connection = DM.IBD_Servidor
    Transaction = DM.IBT_Servidor
    UpdateTransaction = DM.IBT_Servidor
    SQL.Strings = (
      'select psa.*, lcl.nome cidade, UF.sigla '
      'from PESSOA psa '
      '   LEFT OUTER JOIN LOCALIDADE LCL '
      '  ON (LCL.ID = PSA.localidade_id) '
      '   left outer join UF '
      '   ON (UF.id = LCL.uf_id) '
      'where psa.cpf_cnpj is not null ')
    ForcedRefresh = False
    Database = DM.IBD_Servidor
    BufferChunks = 1000
    ParamCheck = True
    Left = 492
    Top = 120
    object Qr_Pessoa_tecnoID: TIntegerField
      FieldName = 'ID'
      Origin = '"PESSOA"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_Pessoa_tecnoUUID: TStringField
      FieldName = 'UUID'
      Origin = '"PESSOA"."UUID"'
      Required = True
      Size = 36
    end
    object Qr_Pessoa_tecnoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = '"PESSOA"."CODIGO"'
      Required = True
    end
    object Qr_Pessoa_tecnoNOME: TStringField
      FieldName = 'NOME'
      Origin = '"PESSOA"."NOME"'
      Required = True
      Size = 50
    end
    object Qr_Pessoa_tecnoNOMEUSUAL: TStringField
      FieldName = 'NOMEUSUAL'
      Origin = '"PESSOA"."NOMEUSUAL"'
      Size = 50
    end
    object Qr_Pessoa_tecnoTIPOPESSOA: TSmallintField
      FieldName = 'TIPOPESSOA'
      Origin = '"PESSOA"."TIPOPESSOA"'
      Required = True
    end
    object Qr_Pessoa_tecnoCPF_CNPJ: TStringField
      FieldName = 'CPF_CNPJ'
      Origin = '"PESSOA"."CPF_CNPJ"'
      Size = 15
    end
    object Qr_Pessoa_tecnoIDESTRANGEIRO: TStringField
      FieldName = 'IDESTRANGEIRO'
      Origin = '"PESSOA"."IDESTRANGEIRO"'
    end
    object Qr_Pessoa_tecnoINDICADORIE: TSmallintField
      FieldName = 'INDICADORIE'
      Origin = '"PESSOA"."INDICADORIE"'
      Required = True
    end
    object Qr_Pessoa_tecnoIE: TStringField
      FieldName = 'IE'
      Origin = '"PESSOA"."IE"'
    end
    object Qr_Pessoa_tecnoIM: TStringField
      FieldName = 'IM'
      Origin = '"PESSOA"."IM"'
      Size = 15
    end
    object Qr_Pessoa_tecnoDATAINICIO: TDateField
      FieldName = 'DATAINICIO'
      Origin = '"PESSOA"."DATAINICIO"'
    end
    object Qr_Pessoa_tecnoGRUPOPESSOA_ID: TSmallintField
      FieldName = 'GRUPOPESSOA_ID'
      Origin = '"PESSOA"."GRUPOPESSOA_ID"'
    end
    object Qr_Pessoa_tecnoLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = '"PESSOA"."LOGRADOURO"'
      Size = 40
    end
    object Qr_Pessoa_tecnoNUMIMOVEL: TStringField
      FieldName = 'NUMIMOVEL'
      Origin = '"PESSOA"."NUMIMOVEL"'
      Size = 6
    end
    object Qr_Pessoa_tecnoCOMPENDERECO: TStringField
      FieldName = 'COMPENDERECO'
      Origin = '"PESSOA"."COMPENDERECO"'
    end
    object Qr_Pessoa_tecnoBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = '"PESSOA"."BAIRRO"'
      Size = 40
    end
    object Qr_Pessoa_tecnoCEP: TStringField
      FieldName = 'CEP'
      Origin = '"PESSOA"."CEP"'
      Size = 10
    end
    object Qr_Pessoa_tecnoLOCALIDADE_ID: TIntegerField
      FieldName = 'LOCALIDADE_ID'
      Origin = '"PESSOA"."LOCALIDADE_ID"'
    end
    object Qr_Pessoa_tecnoVENDEDOR: TSmallintField
      FieldName = 'VENDEDOR'
      Origin = '"PESSOA"."VENDEDOR"'
    end
    object Qr_Pessoa_tecnoCLIENTE: TSmallintField
      FieldName = 'CLIENTE'
      Origin = '"PESSOA"."CLIENTE"'
    end
    object Qr_Pessoa_tecnoFORNECEDOR: TSmallintField
      FieldName = 'FORNECEDOR'
      Origin = '"PESSOA"."FORNECEDOR"'
    end
    object Qr_Pessoa_tecnoTRANSPORTADOR: TSmallintField
      FieldName = 'TRANSPORTADOR'
      Origin = '"PESSOA"."TRANSPORTADOR"'
    end
    object Qr_Pessoa_tecnoAVISO: TStringField
      FieldName = 'AVISO'
      Origin = '"PESSOA"."AVISO"'
      Size = 200
    end
    object Qr_Pessoa_tecnoOBS: TWideMemoField
      FieldName = 'OBS'
      Origin = '"PESSOA"."OBS"'
      ProviderFlags = [pfInUpdate]
      BlobType = ftWideMemo
      Size = 8
    end
    object Qr_Pessoa_tecnoDATACAD: TDateField
      FieldName = 'DATACAD'
      Origin = '"PESSOA"."DATACAD"'
      Required = True
    end
    object Qr_Pessoa_tecnoTELEFONE: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'TELEFONE'
      Origin = '"PESSOA"."TELEFONE"'
      ProviderFlags = []
      ReadOnly = True
    end
    object Qr_Pessoa_tecnoEMAIL: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'EMAIL'
      Origin = '"PESSOA"."EMAIL"'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object Qr_Pessoa_tecnoSUFRAMA: TStringField
      FieldName = 'SUFRAMA'
      Origin = '"PESSOA"."SUFRAMA"'
      Size = 9
    end
    object Qr_Pessoa_tecnoBACKUPCODIGO: TIntegerField
      FieldName = 'BACKUPCODIGO'
      Origin = '"PESSOA"."BACKUPCODIGO"'
    end
    object Qr_Pessoa_tecnoMIGRACAOVENDEDOR: TSmallintField
      FieldName = 'MIGRACAOVENDEDOR'
      Origin = '"PESSOA"."MIGRACAOVENDEDOR"'
    end
    object Qr_Pessoa_tecnoMIGRACAOFORNECEDOR: TSmallintField
      FieldName = 'MIGRACAOFORNECEDOR'
      Origin = '"PESSOA"."MIGRACAOFORNECEDOR"'
    end
    object Qr_Pessoa_tecnoMIGRACAOTELEFONE: TSmallintField
      FieldName = 'MIGRACAOTELEFONE'
      Origin = '"PESSOA"."MIGRACAOTELEFONE"'
    end
    object Qr_Pessoa_tecnoCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = '"LOCALIDADE"."NOME"'
      Size = 40
    end
    object Qr_Pessoa_tecnoSIGLA: TStringField
      FieldName = 'SIGLA'
      Origin = '"UF"."SIGLA"'
      Size = 5
    end
  end
  object Qr_Image: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT i.*'
      'FROM TB_IMAGES i'
      '  INNER JOIN TB_PRODUTO P'
      '  on (P.pro_codigo = I.table_id)'
      '    AND (KIND = '#39'product'#39')'
      'WHERE p.pro_ativo = '#39'S'#39
      'and p.pro_internet = '#39'S'#39
      'and p.pro_send_web = '#39'S'#39)
    ForcedRefresh = False
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 316
    Top = 120
  end
  object DbSnack: TSQLConnection
    DriverName = 'PostgreSQL'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=PostgreSQL'
      'HostName=127.0.0.1'
      'Database=Alegrito'
      'User_Name=postgres'
      'Password=Sucesso!')
    Left = 372
    Top = 232
  end
  object Qr_Snack_Clientes: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT *'
      'FROM CLIENTES')
    SQLConnection = DbSnack
    Left = 372
    Top = 280
    object Qr_Snack_Clientescod_cli: TWideStringField
      FieldName = 'cod_cli'
      FixedChar = True
      Size = 4
    end
    object Qr_Snack_Clientesgrp_cli: TWideStringField
      FieldName = 'grp_cli'
      FixedChar = True
      Size = 3
    end
    object Qr_Snack_Clientescliente: TWideStringField
      FieldName = 'cliente'
      FixedChar = True
      Size = 60
    end
    object Qr_Snack_Clientesbairro: TWideStringField
      FieldName = 'bairro'
      FixedChar = True
      Size = 60
    end
    object Qr_Snack_Clientescep: TWideStringField
      FieldName = 'cep'
      FixedChar = True
      Size = 8
    end
    object Qr_Snack_Clientesfone: TWideStringField
      FieldName = 'fone'
      FixedChar = True
      Size = 14
    end
    object Qr_Snack_Clientesramal: TWideStringField
      FieldName = 'ramal'
      FixedChar = True
      Size = 5
    end
    object Qr_Snack_Clientesfax: TWideStringField
      FieldName = 'fax'
      FixedChar = True
      Size = 14
    end
    object Qr_Snack_Clientescontato: TWideStringField
      FieldName = 'contato'
      FixedChar = True
    end
    object Qr_Snack_Clientese_bairro: TWideStringField
      FieldName = 'e_bairro'
      FixedChar = True
      Size = 60
    end
    object Qr_Snack_Clientese_cep: TWideStringField
      FieldName = 'e_cep'
      FixedChar = True
      Size = 8
    end
    object Qr_Snack_Clientese_fone: TWideStringField
      FieldName = 'e_fone'
      FixedChar = True
      Size = 14
    end
    object Qr_Snack_Clientese_ramal: TWideStringField
      FieldName = 'e_ramal'
      FixedChar = True
      Size = 5
    end
    object Qr_Snack_Clientese_fax: TWideStringField
      FieldName = 'e_fax'
      FixedChar = True
      Size = 14
    end
    object Qr_Snack_Clientese_contato: TWideStringField
      FieldName = 'e_contato'
      FixedChar = True
    end
    object Qr_Snack_Clientescnpj: TBCDField
      FieldName = 'cnpj'
      Precision = 14
      Size = 0
    end
    object Qr_Snack_Clientesinsc_est: TWideStringField
      FieldName = 'insc_est'
      FixedChar = True
    end
    object Qr_Snack_Clientesdesconto: TFloatField
      FieldName = 'desconto'
    end
    object Qr_Snack_Clientescod_rep: TWideStringField
      FieldName = 'cod_rep'
      FixedChar = True
      Size = 3
    end
    object Qr_Snack_Clientescred_total: TBCDField
      FieldName = 'cred_total'
      Precision = 14
      Size = 2
    end
    object Qr_Snack_Clientesatraso_max: TIntegerField
      FieldName = 'atraso_max'
    end
    object Qr_Snack_Clientesnegra: TSmallintField
      FieldName = 'negra'
    end
    object Qr_Snack_Clienteshistorico: TWideMemoField
      FieldName = 'historico'
      BlobType = ftWideMemo
    end
    object Qr_Snack_Clientesnome_fantasia: TWideStringField
      FieldName = 'nome_fantasia'
      FixedChar = True
      Size = 40
    end
    object Qr_Snack_Clientescod_municipio: TWideStringField
      FieldName = 'cod_municipio'
      FixedChar = True
      Size = 7
    end
    object Qr_Snack_Clienteslogradouro: TWideStringField
      FieldName = 'logradouro'
      Size = 60
    end
    object Qr_Snack_Clientesnumero: TWideStringField
      FieldName = 'numero'
    end
    object Qr_Snack_Clientescomplemento: TWideStringField
      FieldName = 'complemento'
      Size = 40
    end
    object Qr_Snack_Clientese_logradouro: TWideStringField
      FieldName = 'e_logradouro'
      Size = 60
    end
    object Qr_Snack_Clientese_numero: TWideStringField
      FieldName = 'e_numero'
    end
    object Qr_Snack_Clientese_complemento: TWideStringField
      FieldName = 'e_complemento'
      Size = 40
    end
    object Qr_Snack_Clientese_cod_municipio: TWideStringField
      FieldName = 'e_cod_municipio'
      FixedChar = True
      Size = 7
    end
    object Qr_Snack_Clientesemail: TWideStringField
      FieldName = 'email'
      Size = 100
    end
    object Qr_Snack_Clientestipo_cliente: TSmallintField
      FieldName = 'tipo_cliente'
    end
    object Qr_Snack_Clientestipo_pessoa: TSmallintField
      FieldName = 'tipo_pessoa'
    end
  end
  object Qr_Snack_Produtos: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT *'
      'FROM produtos')
    SQLConnection = DbSnack
    Left = 460
    Top = 280
    object Qr_Snack_Produtosfilial: TWideStringField
      FieldName = 'filial'
      Origin = 'filial'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      FixedChar = True
      Size = 3
    end
    object Qr_Snack_Produtoscod_pro: TWideStringField
      FieldName = 'cod_pro'
      Origin = 'cod_pro'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      FixedChar = True
    end
    object Qr_Snack_Produtosgrp_pro: TWideStringField
      FieldName = 'grp_pro'
      Origin = 'grp_pro'
      FixedChar = True
      Size = 3
    end
    object Qr_Snack_Produtosdescricao: TWideStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 120
    end
    object Qr_Snack_Produtosunidade: TWideStringField
      FieldName = 'unidade'
      Origin = 'unidade'
      FixedChar = True
      Size = 2
    end
    object Qr_Snack_Produtosprec_venda: TBCDField
      FieldName = 'prec_venda'
      Origin = 'prec_venda'
      Precision = 14
      Size = 2
    end
    object Qr_Snack_Produtosprec_medio: TBCDField
      FieldName = 'prec_medio'
      Origin = 'prec_medio'
      Precision = 14
      Size = 2
    end
    object Qr_Snack_Produtosprec_custo: TBCDField
      FieldName = 'prec_custo'
      Origin = 'prec_custo'
      Precision = 14
      Size = 2
    end
    object Qr_Snack_Produtosmoeda: TWideStringField
      FieldName = 'moeda'
      Origin = 'moeda'
      FixedChar = True
      Size = 3
    end
    object Qr_Snack_Produtosipi: TFloatField
      FieldName = 'ipi'
      Origin = 'ipi'
    end
    object Qr_Snack_Produtosremarque: TIntegerField
      FieldName = 'remarque'
      Origin = 'remarque'
    end
    object Qr_Snack_Produtosult_remarq: TDateField
      FieldName = 'ult_remarq'
      Origin = 'ult_remarq'
    end
    object Qr_Snack_Produtoscomissao: TFloatField
      FieldName = 'comissao'
      Origin = 'comissao'
    end
    object Qr_Snack_Produtosult_sai: TDateField
      FieldName = 'ult_sai'
      Origin = 'ult_sai'
    end
    object Qr_Snack_Produtosult_cli: TWideStringField
      FieldName = 'ult_cli'
      Origin = 'ult_cli'
      FixedChar = True
      Size = 4
    end
    object Qr_Snack_Produtosult_ent: TDateField
      FieldName = 'ult_ent'
      Origin = 'ult_ent'
    end
    object Qr_Snack_Produtosult_for: TWideStringField
      FieldName = 'ult_for'
      Origin = 'ult_for'
      FixedChar = True
      Size = 4
    end
    object Qr_Snack_Produtoslocal: TWideStringField
      FieldName = 'local'
      Origin = '"local"'
      FixedChar = True
      Size = 10
    end
    object Qr_Snack_Produtosestoque: TFloatField
      FieldName = 'estoque'
      Origin = 'estoque'
    end
    object Qr_Snack_Produtoscod_ncm: TWideStringField
      FieldName = 'cod_ncm'
      Origin = 'cod_ncm'
      Size = 8
    end
    object Qr_Snack_Produtosstatus_exclusao: TSmallintField
      FieldName = 'status_exclusao'
      Origin = 'status_exclusao'
    end
    object Qr_Snack_Produtosdata_status_exclusao: TSQLTimeStampField
      FieldName = 'data_status_exclusao'
      Origin = 'data_status_exclusao'
    end
    object Qr_Snack_Produtosnat_op_venda: TIntegerField
      FieldName = 'nat_op_venda'
      Origin = 'nat_op_venda'
    end
    object Qr_Snack_Produtosnat_op_devolucao: TIntegerField
      FieldName = 'nat_op_devolucao'
      Origin = 'nat_op_devolucao'
    end
    object Qr_Snack_Produtosaliq_icms: TFloatField
      FieldName = 'aliq_icms'
      Origin = 'aliq_icms'
    end
    object Qr_Snack_Produtosreduc_bc_icms: TFloatField
      FieldName = 'reduc_bc_icms'
      Origin = 'reduc_bc_icms'
    end
    object Qr_Snack_Produtosiva_st: TFloatField
      FieldName = 'iva_st'
      Origin = 'iva_st'
    end
    object Qr_Snack_Produtoscst: TWideStringField
      FieldName = 'cst'
      Origin = 'cst'
      FixedChar = True
      Size = 3
    end
    object Qr_Snack_Produtoscod_ean: TWideStringField
      FieldName = 'cod_ean'
      Origin = 'cod_ean'
    end
    object Qr_Snack_Produtoscest: TWideStringField
      FieldName = 'cest'
      Origin = 'cest'
      Size = 7
    end
    object Qr_Snack_Produtostipo_fiscal: TSmallintField
      FieldName = 'tipo_fiscal'
      Origin = 'tipo_fiscal'
    end
  end
  object AScript: TSTScript
    SQLScripts = <>
    Transaction = DM.IBT_Crud
    Params = <>
    Macros = <>
    Left = 588
    Top = 136
  end
end
