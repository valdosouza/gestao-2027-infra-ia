object Fr_FormaPagto: TFr_FormaPagto
  Left = 311
  Top = 264
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Cadastro de Formas de Pagto'
  ClientHeight = 511
  ClientWidth = 582
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_FormaPagto: TPageControl
    Left = 0
    Top = 0
    Width = 582
    Height = 511
    ActivePage = TabSheet1
    Align = alClient
    Anchors = [akTop, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pnl_Fundo: TPanel
        Left = 0
        Top = 0
        Width = 574
        Height = 419
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 33
          Height = 14
          Caption = 'C'#243'digo'
          FocusControl = E_Codigo
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 61
          Top = 8
          Width = 49
          Height = 14
          Caption = 'Descri'#231#227'o'
          FocusControl = E_Descricao
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 447
          Top = 8
          Width = 104
          Height = 14
          Caption = 'Parcelamento M'#225'ximo'
          FocusControl = E_Parcelamento
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Codigo: TEdit
          Left = 4
          Top = 24
          Width = 54
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object E_Descricao: TEdit
          Left = 59
          Top = 24
          Width = 385
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object E_Parcelamento: TEdit
          Left = 447
          Top = 24
          Width = 106
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object Pg_Geral: TPageControl
          Left = 2
          Top = 51
          Width = 570
          Height = 366
          ActivePage = tbs_Detail
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 3
          object tbs_Detail: TTabSheet
            Caption = 'Detalhes'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label3: TLabel
              Left = 8
              Top = 193
              Width = 90
              Height = 13
              Caption = 'C'#243'digo para NFC-e'
            end
            object Chbx_Bloquear: TCheckBox
              AlignWithMargins = True
              Left = 3
              Top = 263
              Width = 556
              Height = 17
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alBottom
              Caption = 'N'#227'o mostra pra cliente bloqueado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object Rg_finalidade: TRadioGroup
              Left = 5
              Top = 5
              Width = 361
              Height = 40
              Caption = 'Utiliza'#231#227'o da Forma de Pagamento'
              Columns = 4
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemIndex = 3
              Items.Strings = (
                'Caixa'
                'Banco'
                'Nenhum'
                'Ambos')
              ParentFont = False
              TabOrder = 1
            end
            object Chbx_Libera_sem_credito: TCheckBox
              AlignWithMargins = True
              Left = 3
              Top = 244
              Width = 556
              Height = 17
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alBottom
              Caption = 'Liberar mesmo sem limite de cr'#233'dito'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object CB_Tipo_NFCe: TComboBox
              Left = 8
              Top = 209
              Width = 551
              Height = 21
              Style = csDropDownList
              TabOrder = 3
              Items.Strings = (
                '01 - Dinheiro'
                '02 - Cheque'
                '03 - Cart'#227'o de Cr'#233'dito'
                '04 - Cart'#227'o de D'#233'bito'
                '05 - Cart'#227'o da Loja (Private Label)'
                '10 - Vale Alimenta'#231#227'o'
                '11 - Vale Refei'#231#227'o'
                '12 - Vale Presente'
                '13 - Vale Combust'#237'vel'
                '14 - Duplicata Mercantil'
                '15 - Boleto Banc'#225'rio'
                '16 - Dep'#243'sito Banc'#225'rio'
                '17 - Pagamento Instant'#226'neo (PIX) - Din'#226'mico'
                '18 - Transfer'#234'ncia banc'#225'ria, Carteira Digital'
                '19 - Programa de fidelidade, Cashback, Cr'#233'dito Virtual'
                '20 - Pagamento Instant'#226'neo (PIX) - Est'#225'tico'
                '21 - Cr'#233'dito em Loja'
                
                  '22 - Pagamento Eletr'#244'nico n'#227'o Informado - falha de hardware do s' +
                  'istema emissor'
                '90 - Sem Pagamento'
                '99 - Outros')
            end
            inline Fm_CentroCusto: TFm_CentroCusto
              Left = 5
              Top = 50
              Width = 450
              Height = 71
              TabOrder = 4
              ExplicitLeft = 5
              ExplicitTop = 50
              ExplicitHeight = 71
              inherited Grb_Cta_CentroCusto: TGroupBox
                Height = 71
                ExplicitHeight = 71
                inherited E_Codigo_Plano: TEdit_Setes
                  TabStop = False
                end
              end
            end
            inline Fm_CentroResultado: TFm_CentroResultado
              Left = 6
              Top = 120
              Width = 451
              Height = 71
              TabOrder = 5
              TabStop = True
              ExplicitLeft = 6
              ExplicitTop = 120
              ExplicitHeight = 71
              inherited Grb_Cta_Resultado: TGroupBox
                Height = 71
                ExplicitHeight = 71
                inherited E_Codigo_Plano: TEdit_Setes
                  TabStop = False
                end
              end
            end
            object Chbx_Ativo: TCheckBox
              AlignWithMargins = True
              Left = 3
              Top = 320
              Width = 556
              Height = 17
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alBottom
              Caption = 'Registro Ativo'
              TabOrder = 6
            end
            object Chbx_Show_Delivery: TCheckBox
              AlignWithMargins = True
              Left = 3
              Top = 301
              Width = 556
              Height = 17
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alBottom
              Caption = 'Mostrar no Aplicativo Delivery'
              TabOrder = 7
            end
            object Chbx_TEF: TCheckBox
              AlignWithMargins = True
              Left = 3
              Top = 282
              Width = 556
              Height = 17
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alBottom
              Caption = 'Habilitar TEF'
              TabOrder = 8
            end
          end
          object tbs_intermediator: TTabSheet
            Caption = 'Intermediador'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Panel1: TPanel
              Left = 0
              Top = 0
              Width = 562
              Height = 338
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object Label5: TLabel
                Left = 7
                Top = 42
                Width = 244
                Height = 14
                Caption = 'Nome ou Identifica'#231#227'o do Usuario no Intermediador'
                FocusControl = E_Interm_Usuario
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 8
                Top = 3
                Width = 33
                Height = 14
                Caption = 'C.N.P.J'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object E_Interm_Usuario: TEdit
                Left = 7
                Top = 58
                Width = 385
                Height = 22
                CharCase = ecUpperCase
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object E_Interm_CNPJ: TMaskEdit
                Left = 7
                Top = 18
                Width = 129
                Height = 22
                CharCase = ecUpperCase
                EditMask = '99.999.999/9999-99;0'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 18
                ParentFont = False
                TabOrder = 0
                Text = ''
              end
            end
          end
        end
      end
      object pnl_botoes: TPanel
        Left = 0
        Top = 419
        Width = 574
        Height = 64
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object SB_Inserir: TSpeedButton
          AlignWithMargins = True
          Left = 11
          Top = 5
          Width = 78
          Height = 54
          Margins.Left = 1
          Margins.Right = 1
          Align = alRight
          Caption = 'Inserir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_InserirClick
          ExplicitTop = 4
        end
        object SB_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 91
          Top = 5
          Width = 78
          Height = 54
          Margins.Left = 1
          Margins.Right = 1
          Align = alRight
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_AlterarClick
          ExplicitLeft = 89
          ExplicitTop = 4
        end
        object SB_Excluir: TSpeedButton
          AlignWithMargins = True
          Left = 171
          Top = 5
          Width = 78
          Height = 54
          Margins.Left = 1
          Margins.Right = 1
          Align = alRight
          Caption = 'Excluir - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_ExcluirClick
          ExplicitLeft = 167
          ExplicitTop = 4
        end
        object SB_Gravar: TSpeedButton
          AlignWithMargins = True
          Left = 251
          Top = 5
          Width = 78
          Height = 54
          Margins.Left = 1
          Margins.Right = 1
          Align = alRight
          Caption = 'Gravar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_GravarClick
          ExplicitLeft = 245
          ExplicitTop = 4
        end
        object SB_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 331
          Top = 5
          Width = 78
          Height = 54
          Margins.Left = 1
          Margins.Right = 1
          Align = alRight
          Caption = 'Cancelar - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_CancelarClick
          ExplicitLeft = 323
          ExplicitTop = 4
        end
        object Sb_Pesquisar: TSpeedButton
          AlignWithMargins = True
          Left = 411
          Top = 5
          Width = 78
          Height = 54
          Margins.Left = 1
          Margins.Right = 1
          Align = alRight
          Caption = 'Pesquisar- F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_PesquisarClick
          ExplicitLeft = 401
          ExplicitTop = 4
        end
        object Sb_Sair_0: TSpeedButton
          AlignWithMargins = True
          Left = 491
          Top = 5
          Width = 78
          Height = 54
          Margins.Left = 1
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
          ExplicitLeft = 479
          ExplicitTop = 4
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        574
        483)
      object Label22: TLabel
        Left = 2
        Top = 66
        Width = 116
        Height = 14
        Caption = 'Resultado da pesquisa :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SB_Buscar: TSpeedButton
        Left = 480
        Top = 319
        Width = 92
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
        ExplicitLeft = 466
        ExplicitTop = 124
      end
      object SB_Visualizar: TSpeedButton
        Left = 480
        Top = 373
        Width = 92
        Height = 54
        Anchors = [akRight, akBottom]
        Caption = 'Visualizar - F8'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_VisualizarClick
        ExplicitLeft = 466
        ExplicitTop = 178
      end
      object SB_Cadastrar: TSpeedButton
        Left = 480
        Top = 265
        Width = 92
        Height = 54
        Anchors = [akRight, akBottom]
        Caption = 'Cadastrar - F2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_CadastrarClick
        ExplicitLeft = 466
        ExplicitTop = 70
      end
      object Sb_Sair_1: TSpeedButton
        Left = 480
        Top = 427
        Width = 92
        Height = 54
        Anchors = [akRight, akBottom]
        Caption = 'Sair- Esc'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Sair_1Click
        ExplicitLeft = 466
        ExplicitTop = 232
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 574
        Height = 65
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label28: TLabel
          Left = 10
          Top = 16
          Width = 49
          Height = 14
          Caption = 'Descri'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BuscaDescricao: TEdit
          Left = 6
          Top = 32
          Width = 546
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
      end
      object DBGrid2: TDBGrid
        Left = 8
        Top = 68
        Width = 460
        Height = 413
        Anchors = [akTop, akBottom]
        Color = clCream
        DataSource = Ds_Pesquisa
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = SB_VisualizarClick
        OnTitleClick = DBGrid2TitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'FPT_CODIGO'
            Title.Caption = 'C'#243'digo'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FPT_DESCRICAO'
            Title.Caption = 'Prazos'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Style = []
            Width = 366
            Visible = True
          end>
      end
      object ChBx_BuscaInativo: TCheckBox
        Left = 468
        Top = 71
        Width = 88
        Height = 17
        Caption = 'Inativos'
        TabOrder = 2
      end
    end
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * '
      'FROM TB_FORMAPAGTO')
    Left = 520
    Top = 160
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 520
    Top = 208
  end
end
