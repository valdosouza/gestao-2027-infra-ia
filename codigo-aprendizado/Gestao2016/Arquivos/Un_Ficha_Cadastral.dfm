object Fr_Ficha_Cadastral: TFr_Ficha_Cadastral
  Left = 403
  Top = 51
  Anchors = [akTop, akBottom]
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Cadastro de Ficha Cadastral'
  ClientHeight = 493
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNavy
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Ficha_Cadastral: TPageControl
    Left = 0
    Top = 0
    Width = 792
    Height = 493
    ActivePage = tbs_cadastro
    Align = alClient
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    object tbs_cadastro: TTabSheet
      Caption = 'tbs_cadastro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pn_Botoes: TPanel
        Left = 0
        Top = 403
        Width = 784
        Height = 62
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          784
          62)
        object SB_Gravar: TSpeedButton
          Left = 523
          Top = 4
          Width = 83
          Height = 54
          Anchors = [akBottom]
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
        end
        object SB_Cancelar: TSpeedButton
          Left = 607
          Top = 4
          Width = 83
          Height = 54
          Anchors = [akBottom]
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
        end
        object Sb_Sair_0: TSpeedButton
          Left = 691
          Top = 4
          Width = 83
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
          OnClick = Sb_Sair_0Click
        end
      end
      object Pg_Geral: TPageControl
        Left = 0
        Top = 0
        Width = 784
        Height = 403
        ActivePage = Tbs_DadosGerais
        Align = alClient
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MultiLine = True
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 1
        object Tbs_DadosGerais: TTabSheet
          Caption = 'Dados Gerais'
          ImageIndex = 8
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Dados_Gerais: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label2: TLabel
              Left = 108
              Top = 3
              Width = 24
              Height = 14
              Caption = 'C.P.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Lb_IncEstadual: TLabel
              Left = 248
              Top = 3
              Width = 18
              Height = 14
              Caption = 'R.G'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label5: TLabel
              Left = 7
              Top = 3
              Width = 44
              Height = 14
              Caption = 'Cadastro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label8: TLabel
              Left = 7
              Top = 41
              Width = 27
              Height = 14
              Caption = 'Nome'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label14: TLabel
              Left = 399
              Top = 3
              Width = 62
              Height = 14
              Caption = 'Org .Emissor'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label15: TLabel
              Left = 520
              Top = 3
              Width = 65
              Height = 14
              Caption = 'Data Emiss'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 623
              Top = 3
              Width = 81
              Height = 14
              Caption = 'Data Nascimento'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 428
              Top = 41
              Width = 67
              Height = 14
              Caption = 'Nacionalidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label21: TLabel
              Left = 601
              Top = 41
              Width = 60
              Height = 14
              Caption = 'Naturalidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label23: TLabel
              Left = 414
              Top = 308
              Width = 66
              Height = 14
              Caption = 'Reside desde'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label24: TLabel
              Left = 7
              Top = 308
              Width = 53
              Height = 14
              Caption = 'Resid'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label114: TLabel
              Left = 7
              Top = 121
              Width = 62
              Height = 14
              Caption = 'Escolaridade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label115: TLabel
              Left = 248
              Top = 121
              Width = 59
              Height = 14
              Caption = 'Nome do Pai'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label116: TLabel
              Left = 509
              Top = 121
              Width = 65
              Height = 14
              Caption = 'Nome da M'#227'e'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label6: TLabel
              Left = 7
              Top = 234
              Width = 64
              Height = 14
              Caption = 'Complemento'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label117: TLabel
              Left = 354
              Top = 160
              Width = 16
              Height = 14
              Caption = 'U.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label118: TLabel
              Left = 7
              Top = 160
              Width = 25
              Height = 14
              Caption = 'C.E.P'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Dg_Cep: TSpeedButton
              Left = 72
              Top = 175
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Dg_CepClick
            end
            object Label119: TLabel
              Left = 95
              Top = 160
              Width = 20
              Height = 14
              Caption = 'Pa'#237's'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label120: TLabel
              Left = 410
              Top = 160
              Width = 33
              Height = 14
              Caption = 'Cidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label121: TLabel
              Left = 237
              Top = 234
              Width = 29
              Height = 14
              Caption = 'Bairro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label122: TLabel
              Left = 509
              Top = 234
              Width = 33
              Height = 14
              Caption = 'Regi'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label123: TLabel
              Left = 327
              Top = 271
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label124: TLabel
              Left = 420
              Top = 271
              Width = 48
              Height = 14
              Caption = 'Fax/Outro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label125: TLabel
              Left = 507
              Top = 271
              Width = 33
              Height = 14
              Caption = 'Celular'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label126: TLabel
              Left = 7
              Top = 271
              Width = 67
              Height = 14
              Caption = 'Nome Contato'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object SB_Cad_cidade: TSpeedButton
              Left = 744
              Top = 174
              Width = 23
              Height = 22
              Caption = '...'
            end
            object Label127: TLabel
              Left = 594
              Top = 271
              Width = 47
              Height = 14
              Caption = 'Comercial'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label128: TLabel
              Left = 683
              Top = 271
              Width = 37
              Height = 14
              Caption = 'Portaria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label129: TLabel
              Left = 7
              Top = 198
              Width = 46
              Height = 14
              Caption = 'Endere'#231'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label130: TLabel
              Left = 658
              Top = 198
              Width = 80
              Height = 14
              Caption = 'C.N.P.J - Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label131: TLabel
              Left = 474
              Top = 198
              Width = 37
              Height = 14
              Caption = 'N'#250'mero'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Dg_Endereco: TSpeedButton
              Left = 446
              Top = 212
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Dg_EnderecoClick
            end
            object Label3: TLabel
              Left = 476
              Top = 83
              Width = 28
              Height = 14
              Caption = 'e-mail'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Dg_Data: TDateTimePicker
              Left = 6
              Top = 18
              Width = 98
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 0
            end
            object E_Dg_cpf: TMaskEdit
              Left = 105
              Top = 18
              Width = 137
              Height = 22
              BiDiMode = bdLeftToRight
              EditMask = '999.999.999-99;0'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
              Text = ''
            end
            object E_Dg_Rg: TEdit
              Left = 246
              Top = 18
              Width = 148
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 2
            end
            object E_Dg_Org_Emissao: TEdit
              Left = 396
              Top = 18
              Width = 118
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 3
            end
            object E_Dg_Dt_Rg_Emissao: TDateTimePicker
              Left = 518
              Top = 18
              Width = 100
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 4
            end
            object E_Dg_Dt_Nascimento: TDateTimePicker
              Left = 620
              Top = 18
              Width = 100
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 5
            end
            object E_Dg_Nome: TEdit
              Left = 7
              Top = 56
              Width = 417
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 6
            end
            object E_Dg_Nacionalidade: TEdit
              Left = 425
              Top = 56
              Width = 173
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 7
            end
            object E_Dg_Naturalidade: TEdit
              Left = 600
              Top = 56
              Width = 170
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 8
            end
            object E_Dg_Residencia: TEdit
              Left = 7
              Top = 323
              Width = 402
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 32
            end
            object E_Dg_NomePai: TEdit
              Left = 246
              Top = 136
              Width = 260
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 13
            end
            object E_Dg_Escolaridade: TEdit
              Left = 7
              Top = 136
              Width = 236
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 12
            end
            object E_Dg_NomeMae: TEdit
              Left = 508
              Top = 136
              Width = 260
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 15
            end
            object E_Dg_Compl_Endereco: TEdit
              Left = 7
              Top = 248
              Width = 226
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 25
              ParentFont = False
              TabOrder = 23
            end
            object E_Dg_Bairro: TEdit
              Left = 235
              Top = 248
              Width = 270
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              TabOrder = 24
            end
            object Dblcb_Dg_Pais: TDBLookupComboBox
              Left = 98
              Top = 175
              Width = 249
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'PAI_CODBACEN'
              ListField = 'PAI_DESCRICAO'
              ListSource = DM.ds_Pais
              ParentFont = False
              TabOrder = 16
            end
            object DBLCB_Dg_Cidade: TDBLookupComboBox
              Left = 408
              Top = 175
              Width = 333
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'CDD_CODIGO'
              ListField = 'CDD_DESCRICAO'
              ListSource = DM.Ds_Cidades
              ParentFont = False
              TabOrder = 18
            end
            object E_Dg_Regiao: TEdit
              Left = 507
              Top = 248
              Width = 264
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 25
            end
            object E_Dg_Fax: TMaskEdit
              Left = 415
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 28
              Text = ''
            end
            object E_Dg_Fone: TMaskEdit
              Left = 325
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 27
              Text = ''
            end
            object E_Dg_Celular: TMaskEdit
              Left = 504
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 29
              Text = ''
            end
            object E_Dg_Contato: TEdit
              Left = 7
              Top = 286
              Width = 316
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 26
            end
            object Chb_Dg_Principal: TCheckBox
              Left = 534
              Top = 198
              Width = 113
              Height = 13
              Caption = 'Endere'#231'o Principal '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 35
            end
            object E_Dg_Fone_Comercial: TMaskEdit
              Left = 593
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 30
              Text = ''
            end
            object E_Dg_Fone_Portaria: TMaskEdit
              Left = 682
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 31
              Text = ''
            end
            object E_Dg_Endereco: TEdit
              Left = 7
              Top = 212
              Width = 434
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 19
            end
            object E_Dg_Cnpj_Entrega: TMaskEdit
              Left = 657
              Top = 212
              Width = 113
              Height = 22
              CharCase = ecUpperCase
              EditMask = '##.###.###/####-##;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 18
              ParentFont = False
              TabOrder = 22
              Text = ''
            end
            object E_Dg_Nr_Endereco: TEdit
              Left = 472
              Top = 212
              Width = 58
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 20
            end
            object DBLCB_Dg_Estado: TDBLookupComboBox
              Left = 350
              Top = 175
              Width = 58
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'UFE_CODIGO'
              ListField = 'UFE_SIGLA'
              ListSource = DM.Ds_UF
              ParentFont = False
              TabOrder = 17
            end
            object Cb_Dg_Tipo_Endereco: TComboBox
              Left = 533
              Top = 212
              Width = 123
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemIndex = 0
              ParentFont = False
              TabOrder = 21
              Text = 'COMERCIAL'
              Items.Strings = (
                'COMERCIAL'
                'RESIDENCIAL'
                'ENTREGA'
                'COBRAN'#199'A')
            end
            object Rg_Dg_EstadoCivil: TRadioGroup
              Left = 8
              Top = 80
              Width = 306
              Height = 42
              Caption = 'Estado Civil'
              Columns = 4
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemIndex = 0
              Items.Strings = (
                'Solteiro'
                'Casado'
                'Divorciado'
                'Viuvo')
              ParentFont = False
              TabOrder = 9
            end
            object Rg_Dg_Sexo: TRadioGroup
              Left = 317
              Top = 80
              Width = 153
              Height = 42
              Caption = 'Sexo'
              Columns = 2
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemIndex = 0
              Items.Strings = (
                'Feminino'
                'Masculino')
              ParentFont = False
              TabOrder = 10
            end
            object Rg_Dg_SituacaoImovel: TRadioGroup
              Left = 518
              Top = 310
              Width = 254
              Height = 39
              Caption = 'Situa'#231#227'o do Im'#243'vel'
              Columns = 3
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Items.Strings = (
                'Quitado'
                'Financiado'
                'Alugado')
              ParentFont = False
              TabOrder = 34
            end
            object E_Dg_Dt_Reside_Desde: TEdit
              Left = 411
              Top = 323
              Width = 103
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 33
            end
            object E_Dg_Email: TEdit
              Left = 474
              Top = 98
              Width = 295
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecLowerCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 11
            end
            object E_Dg_cep: TMaskEdit
              Left = 7
              Top = 175
              Width = 62
              Height = 22
              CharCase = ecUpperCase
              EditMask = '#####-###;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 9
              ParentFont = False
              TabOrder = 14
              Text = ''
              OnExit = E_Dg_cepExit
            end
          end
        end
        object Tbs_DadosProfissionais: TTabSheet
          Caption = 'Dados Profissionais'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Dados_Profissionais: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label27: TLabel
              Left = 169
              Top = 7
              Width = 87
              Height = 13
              Caption = 'Classe Profissional'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label29: TLabel
              Left = 374
              Top = 7
              Width = 44
              Height = 13
              Caption = 'Atividade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label30: TLabel
              Left = 570
              Top = 7
              Width = 43
              Height = 13
              Caption = 'Profiss'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label32: TLabel
              Left = 7
              Top = 46
              Width = 69
              Height = 13
              Caption = 'S'#225'lario/Renda'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label18: TLabel
              Left = 128
              Top = 46
              Width = 62
              Height = 13
              Caption = 'Dt. Admiss'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label33: TLabel
              Left = 228
              Top = 46
              Width = 59
              Height = 13
              Caption = 'N'#186' Beneficio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label40: TLabel
              Left = 388
              Top = 120
              Width = 84
              Height = 13
              Caption = 'Faturamento/M'#234's'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label41: TLabel
              Left = 432
              Top = 46
              Width = 67
              Height = 13
              Caption = 'Outros Pagtos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label42: TLabel
              Left = 534
              Top = 46
              Width = 24
              Height = 13
              Caption = 'Valor'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label48: TLabel
              Left = 516
              Top = 123
              Width = 49
              Height = 13
              Caption = 'Capital (%)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label49: TLabel
              Left = 641
              Top = 125
              Width = 61
              Height = 13
              Caption = 'S'#243'cio Desde'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object SpeedButton2: TSpeedButton
              Left = 744
              Top = 175
              Width = 23
              Height = 22
              Caption = '...'
            end
            object Label43: TLabel
              Left = 481
              Top = 83
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
            object Label44: TLabel
              Left = 621
              Top = 83
              Width = 67
              Height = 14
              Caption = 'Insc. Estadual'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label47: TLabel
              Left = 7
              Top = 82
              Width = 155
              Height = 14
              Caption = 'Nome da Empresa - Empregador'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label135: TLabel
              Left = 291
              Top = 124
              Width = 73
              Height = 14
              Caption = 'Data Funda'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label46: TLabel
              Left = 7
              Top = 122
              Width = 84
              Height = 14
              Caption = 'Natureza Jur'#237'dica'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label9: TLabel
              Left = 7
              Top = 235
              Width = 64
              Height = 14
              Caption = 'Complemento'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label10: TLabel
              Left = 354
              Top = 161
              Width = 16
              Height = 14
              Caption = 'U.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label11: TLabel
              Left = 7
              Top = 161
              Width = 25
              Height = 14
              Caption = 'C.E.P'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Dp_Cep: TSpeedButton
              Left = 67
              Top = 176
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Dp_CepClick
            end
            object Label12: TLabel
              Left = 95
              Top = 161
              Width = 20
              Height = 14
              Caption = 'Pa'#237's'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label17: TLabel
              Left = 410
              Top = 161
              Width = 33
              Height = 14
              Caption = 'Cidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label19: TLabel
              Left = 237
              Top = 235
              Width = 29
              Height = 14
              Caption = 'Bairro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label20: TLabel
              Left = 509
              Top = 235
              Width = 33
              Height = 14
              Caption = 'Regi'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label25: TLabel
              Left = 328
              Top = 272
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label26: TLabel
              Left = 418
              Top = 272
              Width = 48
              Height = 14
              Caption = 'Fax/Outro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label31: TLabel
              Left = 507
              Top = 272
              Width = 33
              Height = 14
              Caption = 'Celular'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label34: TLabel
              Left = 7
              Top = 272
              Width = 67
              Height = 14
              Caption = 'Nome Contato'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label35: TLabel
              Left = 594
              Top = 272
              Width = 47
              Height = 14
              Caption = 'Comercial'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label36: TLabel
              Left = 683
              Top = 272
              Width = 37
              Height = 14
              Caption = 'Portaria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label37: TLabel
              Left = 7
              Top = 199
              Width = 46
              Height = 14
              Caption = 'Endere'#231'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label38: TLabel
              Left = 658
              Top = 199
              Width = 80
              Height = 14
              Caption = 'C.N.P.J - Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label39: TLabel
              Left = 474
              Top = 199
              Width = 37
              Height = 14
              Caption = 'N'#250'mero'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Dp_Endereco: TSpeedButton
              Left = 446
              Top = 213
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Dp_EnderecoClick
            end
            object Label57: TLabel
              Left = 328
              Top = 311
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label147: TLabel
              Left = 7
              Top = 311
              Width = 89
              Height = 14
              Caption = 'Nome do Contador'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label148: TLabel
              Left = 419
              Top = 311
              Width = 48
              Height = 14
              Caption = 'Fax/Outro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label149: TLabel
              Left = 508
              Top = 311
              Width = 33
              Height = 14
              Caption = 'Celular'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Dp_Classe_Prof: TEdit
              Left = 168
              Top = 22
              Width = 202
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object E_Dp_Atividade: TEdit
              Left = 373
              Top = 22
              Width = 192
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object E_Dp_Profissao: TEdit
              Left = 569
              Top = 22
              Width = 199
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object E_Dp_VL_Renda: TEdit_Setes
              Left = 7
              Top = 60
              Width = 115
              Height = 21
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              Text = ''
              OnExit = E_Dp_VL_RendaExit
            end
            object E_Dp_VL_Outros: TEdit_Setes
              Left = 429
              Top = 60
              Width = 95
              Height = 21
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              Text = ''
              OnExit = E_Dp_VL_OutrosExit
            end
            object E_Dp_Nr_Beneficio: TEdit
              Left = 227
              Top = 60
              Width = 199
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object E_Dp_Dt_Admissao: TDateTimePicker
              Left = 125
              Top = 60
              Width = 101
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 5
            end
            object E_Dp_CNPJ_Empregador: TMaskEdit
              Left = 478
              Top = 98
              Width = 137
              Height = 22
              BiDiMode = bdLeftToRight
              EditMask = '99.999.999/9999-99;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 18
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 10
              Text = ''
            end
            object E_Dp_Insc_Est_Empregador: TEdit
              Left = 619
              Top = 98
              Width = 148
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 11
            end
            object E_Dp_Faturamento: TEdit_Setes
              Left = 389
              Top = 139
              Width = 123
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 14
              Text = ''
              OnExit = E_Dp_FaturamentoExit
            end
            object E_Dp_Empregador: TEdit
              Left = 7
              Top = 98
              Width = 468
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 9
            end
            object E_Dp_Capital: TEdit_Setes
              Left = 514
              Top = 139
              Width = 123
              Height = 22
              Alignment = taRightJustify
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 15
              Text = ''
            end
            object E_Dp_Natureza_Juridica: TEdit
              Left = 7
              Top = 139
              Width = 278
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 12
            end
            object Rg_Dp_Tp_Trabalho: TRadioGroup
              Left = 6
              Top = 3
              Width = 160
              Height = 42
              Caption = 'Tipo Empresa'
              Columns = 2
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemIndex = 0
              Items.Strings = (
                'Formal'
                'Informal')
              ParentFont = False
              TabOrder = 0
            end
            object E_Dp_Compl_Endereco: TEdit
              Left = 7
              Top = 249
              Width = 226
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 25
              ParentFont = False
              TabOrder = 24
            end
            object E_Dp_Bairro: TEdit
              Left = 235
              Top = 249
              Width = 270
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              TabOrder = 25
            end
            object Dblcb_Dp_Pais: TDBLookupComboBox
              Left = 93
              Top = 175
              Width = 255
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'PAI_CODBACEN'
              ListField = 'PAI_DESCRICAO'
              ListSource = DM.ds_Pais
              ParentFont = False
              TabOrder = 17
            end
            object DBLCB_Dp_Cidade: TDBLookupComboBox
              Left = 408
              Top = 175
              Width = 333
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'CDD_CODIGO'
              ListField = 'CDD_DESCRICAO'
              ListSource = DM.Ds_Cidades
              ParentFont = False
              TabOrder = 19
            end
            object E_Dp_Regiao: TEdit
              Left = 507
              Top = 249
              Width = 264
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 26
            end
            object E_Dp_Fax: TMaskEdit
              Left = 415
              Top = 287
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 29
              Text = ''
            end
            object E_Dp_Fone: TMaskEdit
              Left = 325
              Top = 287
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 28
              Text = ''
            end
            object E_Dp_Celular: TMaskEdit
              Left = 504
              Top = 287
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 30
              Text = ''
            end
            object E_Dp_Contato: TEdit
              Left = 7
              Top = 287
              Width = 316
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 27
            end
            object Chb_Dp_Principal: TCheckBox
              Left = 534
              Top = 199
              Width = 113
              Height = 13
              Caption = 'Endere'#231'o Principal '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 37
            end
            object E_Dp_Fone_Comercial: TMaskEdit
              Left = 593
              Top = 287
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 31
              Text = ''
            end
            object E_Dp_Fone_Portaria: TMaskEdit
              Left = 682
              Top = 287
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 32
              Text = ''
            end
            object E_Dp_Endereco: TEdit
              Left = 7
              Top = 213
              Width = 434
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 20
            end
            object E_Dp_Cnpj_Entrega: TMaskEdit
              Left = 657
              Top = 213
              Width = 113
              Height = 22
              CharCase = ecUpperCase
              EditMask = '##.###.###/####-##;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 18
              ParentFont = False
              TabOrder = 23
              Text = ''
            end
            object E_Dp_Nr_Endereco: TEdit
              Left = 472
              Top = 213
              Width = 58
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 21
            end
            object DBLCB_Dp_Estado: TDBLookupComboBox
              Left = 350
              Top = 175
              Width = 58
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'UFE_CODIGO'
              ListField = 'UFE_SIGLA'
              ListSource = DM.Ds_UF
              ParentFont = False
              TabOrder = 18
            end
            object Cb_Dp_Tipo_Endereco: TComboBox
              Left = 533
              Top = 213
              Width = 123
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemIndex = 0
              ParentFont = False
              TabOrder = 22
              Text = 'COMERCIAL'
              Items.Strings = (
                'COMERCIAL'
                'RESIDENCIAL'
                'ENTREGA'
                'COBRAN'#199'A')
            end
            object E_Dp_Valor: TEdit_Setes
              Left = 528
              Top = 60
              Width = 96
              Height = 21
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              Text = ''
              OnExit = E_Dp_ValorExit
            end
            object E_Dp_Ctdr_Fone: TMaskEdit
              Left = 325
              Top = 326
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 34
              Text = ''
            end
            object E_Dp_Ctdr_Nome: TEdit
              Left = 7
              Top = 326
              Width = 316
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 33
            end
            object E_Dp_Ctdr_Fax: TMaskEdit
              Left = 416
              Top = 326
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 35
              Text = ''
            end
            object E_Dp_Ctdr_Celular: TMaskEdit
              Left = 505
              Top = 326
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 36
              Text = ''
            end
            object E_Dp_Dt_Funda_Empregador: TMaskEdit
              Left = 288
              Top = 139
              Width = 98
              Height = 22
              EditMask = '!99/99/0000;1;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 13
              Text = '  /  /    '
            end
            object E_Dp_Dt_Socio_Desde: TMaskEdit
              Left = 640
              Top = 139
              Width = 98
              Height = 22
              EditMask = '!99/99/0000;1;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 16
              Text = '  /  /    '
            end
            object E_Dp_Cep: TMaskEdit
              Left = 7
              Top = 175
              Width = 59
              Height = 22
              CharCase = ecUpperCase
              EditMask = '#####-###;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 9
              ParentFont = False
              TabOrder = 38
              Text = ''
              OnExit = E_Dg_cepExit
            end
          end
        end
        object Tbs_Conjuge: TTabSheet
          Caption = 'Dados C'#244'njuge'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Conjuge: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label50: TLabel
              Left = 10
              Top = 3
              Width = 24
              Height = 14
              Caption = 'C.P.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label132: TLabel
              Left = 150
              Top = 3
              Width = 21
              Height = 14
              Caption = 'R.G.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label134: TLabel
              Left = 7
              Top = 41
              Width = 27
              Height = 14
              Caption = 'Nome'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label137: TLabel
              Left = 301
              Top = 3
              Width = 62
              Height = 14
              Caption = 'Org .Emissor'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label138: TLabel
              Left = 422
              Top = 3
              Width = 65
              Height = 14
              Caption = 'Data Emiss'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label139: TLabel
              Left = 525
              Top = 3
              Width = 81
              Height = 14
              Caption = 'Data Nascimento'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label140: TLabel
              Left = 428
              Top = 41
              Width = 67
              Height = 14
              Caption = 'Nacionalidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label141: TLabel
              Left = 601
              Top = 41
              Width = 60
              Height = 14
              Caption = 'Naturalidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Cg_Cidade: TSpeedButton
              Left = 744
              Top = 172
              Width = 23
              Height = 22
              Caption = '...'
            end
            object Label81: TLabel
              Left = 7
              Top = 232
              Width = 64
              Height = 14
              Caption = 'Complemento'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label82: TLabel
              Left = 354
              Top = 158
              Width = 16
              Height = 14
              Caption = 'U.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label83: TLabel
              Left = 7
              Top = 158
              Width = 25
              Height = 14
              Caption = 'C.E.P'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Cg_Cep: TSpeedButton
              Left = 67
              Top = 173
              Width = 22
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Cg_CepClick
            end
            object Label84: TLabel
              Left = 95
              Top = 158
              Width = 20
              Height = 14
              Caption = 'Pa'#237's'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label85: TLabel
              Left = 410
              Top = 158
              Width = 33
              Height = 14
              Caption = 'Cidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label86: TLabel
              Left = 237
              Top = 232
              Width = 29
              Height = 14
              Caption = 'Bairro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label92: TLabel
              Left = 509
              Top = 232
              Width = 33
              Height = 14
              Caption = 'Regi'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label95: TLabel
              Left = 343
              Top = 269
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label97: TLabel
              Left = 424
              Top = 269
              Width = 48
              Height = 14
              Caption = 'Fax/Outro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label98: TLabel
              Left = 507
              Top = 269
              Width = 33
              Height = 14
              Caption = 'Celular'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label99: TLabel
              Left = 7
              Top = 269
              Width = 67
              Height = 14
              Caption = 'Nome Contato'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label100: TLabel
              Left = 594
              Top = 269
              Width = 47
              Height = 14
              Caption = 'Comercial'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label103: TLabel
              Left = 683
              Top = 269
              Width = 37
              Height = 14
              Caption = 'Portaria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label104: TLabel
              Left = 7
              Top = 196
              Width = 46
              Height = 14
              Caption = 'Endere'#231'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label105: TLabel
              Left = 658
              Top = 196
              Width = 80
              Height = 14
              Caption = 'C.N.P.J - Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label106: TLabel
              Left = 474
              Top = 196
              Width = 37
              Height = 14
              Caption = 'N'#250'mero'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Cg_Endereco: TSpeedButton
              Left = 446
              Top = 210
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Cg_EnderecoClick
            end
            object Label53: TLabel
              Left = 546
              Top = 82
              Width = 46
              Height = 14
              Caption = 'Profiss'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label54: TLabel
              Left = 698
              Top = 119
              Width = 71
              Height = 14
              Caption = 'Valor da renda'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label55: TLabel
              Left = 7
              Top = 80
              Width = 83
              Height = 14
              Caption = 'Correspond'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label56: TLabel
              Left = 280
              Top = 80
              Width = 28
              Height = 14
              Caption = 'e-mail'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label7: TLabel
              Left = 431
              Top = 119
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
            object Label28: TLabel
              Left = 547
              Top = 119
              Width = 67
              Height = 14
              Caption = 'Insc. Estadual'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label113: TLabel
              Left = 7
              Top = 119
              Width = 155
              Height = 14
              Caption = 'Nome da Empresa - Empregador'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Cg_Rg: TEdit
              Left = 148
              Top = 18
              Width = 147
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
            end
            object E_Cg_Org_Emissao: TEdit
              Left = 298
              Top = 18
              Width = 117
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 2
            end
            object E_Cg_Dt_Rg_Emissao: TDateTimePicker
              Left = 420
              Top = 18
              Width = 99
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 3
            end
            object E_Cg_Dt_Nascimento: TDateTimePicker
              Left = 522
              Top = 18
              Width = 99
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 4
            end
            object E_Cg_Nome: TEdit
              Left = 7
              Top = 56
              Width = 416
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 5
            end
            object E_Cg_Nacionalidade: TEdit
              Left = 425
              Top = 56
              Width = 172
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 6
            end
            object E_Cg_Compl_Endereco: TEdit
              Left = 7
              Top = 246
              Width = 226
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 25
              ParentFont = False
              TabOrder = 23
            end
            object E_Cg_Bairro: TEdit
              Left = 235
              Top = 246
              Width = 270
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              TabOrder = 24
            end
            object E_Cg_Cep: TMaskEdit
              Left = 7
              Top = 172
              Width = 59
              Height = 22
              EditMask = '#####-###;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 9
              ParentFont = False
              TabOrder = 15
              Text = ''
            end
            object Dblcb_Cg_Pais: TDBLookupComboBox
              Left = 93
              Top = 172
              Width = 255
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'PAI_CODBACEN'
              ListField = 'PAI_DESCRICAO'
              ListSource = DM.ds_Pais
              ParentFont = False
              TabOrder = 16
            end
            object DBLCB_Cg_Cidade: TDBLookupComboBox
              Left = 408
              Top = 172
              Width = 333
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'CDD_CODIGO'
              ListField = 'CDD_DESCRICAO'
              ListSource = DM.Ds_Cidades
              ParentFont = False
              TabOrder = 18
            end
            object E_Cg_Regiao: TEdit
              Left = 507
              Top = 246
              Width = 264
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 25
            end
            object E_Cg_Fax: TMaskEdit
              Left = 411
              Top = 284
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 28
              Text = ''
            end
            object E_Cg_Fone: TMaskEdit
              Left = 321
              Top = 284
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 27
              Text = ''
            end
            object E_Cg_Celular: TMaskEdit
              Left = 502
              Top = 284
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 29
              Text = ''
            end
            object E_Cg_Contato: TEdit
              Left = 7
              Top = 284
              Width = 312
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 26
            end
            object Chb_Cg_Principal: TCheckBox
              Left = 534
              Top = 196
              Width = 113
              Height = 13
              Caption = 'Endere'#231'o Principal '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 32
            end
            object E_Cg_Fone_Comercial: TMaskEdit
              Left = 592
              Top = 284
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 30
              Text = ''
            end
            object E_Cg_Fone_Portaria: TMaskEdit
              Left = 682
              Top = 284
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 31
              Text = ''
            end
            object E_Cg_Endereco: TEdit
              Left = 7
              Top = 210
              Width = 434
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 19
            end
            object E_Cg_Cnpj_Entrega: TMaskEdit
              Left = 657
              Top = 210
              Width = 113
              Height = 22
              CharCase = ecUpperCase
              EditMask = '##.###.###/####-##;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 18
              ParentFont = False
              TabOrder = 22
              Text = ''
            end
            object E_Cg_Nr_Endereco: TEdit
              Left = 472
              Top = 210
              Width = 58
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 20
            end
            object DBLCB_Cg_Estado: TDBLookupComboBox
              Left = 350
              Top = 172
              Width = 58
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'UFE_CODIGO'
              ListField = 'UFE_SIGLA'
              ListSource = DM.Ds_UF
              ParentFont = False
              TabOrder = 17
            end
            object Cb_Cg_Tipo_Endereco: TComboBox
              Left = 533
              Top = 210
              Width = 123
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemIndex = 0
              ParentFont = False
              TabOrder = 21
              Text = 'COMERCIAL'
              Items.Strings = (
                'COMERCIAL'
                'RESIDENCIAL'
                'ENTREGA'
                'COBRAN'#199'A')
            end
            object E_Cg_Naturalidade: TEdit
              Left = 600
              Top = 56
              Width = 169
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 7
            end
            object E_Cg_CPF: TMaskEdit
              Left = 8
              Top = 18
              Width = 137
              Height = 22
              EditMask = '000.000.000-00;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 0
              Text = ''
            end
            object E_Cg_Profissao: TEdit
              Left = 537
              Top = 95
              Width = 231
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 10
            end
            object E_Cg_Vl_Renda: TEdit_Setes
              Left = 697
              Top = 134
              Width = 74
              Height = 22
              Alignment = taRightJustify
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 14
              Text = ''
              OnExit = E_Cg_Vl_RendaExit
            end
            object E_Cg_Correspondencia: TEdit
              Left = 7
              Top = 95
              Width = 265
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 8
            end
            object E_Cg_Email: TEdit
              Left = 277
              Top = 95
              Width = 258
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecLowerCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 9
            end
            object E_Cg_Cnpj_Empregador: TMaskEdit
              Left = 428
              Top = 134
              Width = 115
              Height = 22
              BiDiMode = bdLeftToRight
              EditMask = '99.999.999/9999-99;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 18
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 12
              Text = ''
            end
            object E_Cg_Insc_Est_Empregador: TEdit
              Left = 545
              Top = 134
              Width = 148
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 13
            end
            object E_Cg_Empregador: TEdit
              Left = 7
              Top = 134
              Width = 418
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 11
            end
          end
        end
        object Tbs_Dependentes: TTabSheet
          Caption = 'Dependentes'
          ImageIndex = 2
          OnShow = Tbs_DependentesShow
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Dependentes: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              776
              357)
            object Label51: TLabel
              Left = 8
              Top = 4
              Width = 28
              Height = 13
              Caption = 'Nome'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label52: TLabel
              Left = 618
              Top = 4
              Width = 95
              Height = 13
              Caption = 'Grau de Parentesco'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Ins_Dependente: TSpeedButton
              Left = 5
              Top = 315
              Width = 94
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Novo - F2'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Ins_DependenteClick
            end
            object Sb_Alt_Dependente: TSpeedButton
              Left = 99
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Alterar - F3'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Alt_DependenteClick
            end
            object Sb_Exc_Dependente: TSpeedButton
              Left = 196
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Excluir - F4'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Exc_DependenteClick
            end
            object Sb_Grv_Dependente: TSpeedButton
              Left = 296
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Gravar - F5'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Grv_DependenteClick
            end
            object Sb_Can_Dependente: TSpeedButton
              Left = 393
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Cancelar - F6'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Can_DependenteClick
            end
            object E_Dpt_Nome: TEdit
              Left = 6
              Top = 19
              Width = 608
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 0
            end
            object E_Dpt_Parentesco: TEdit
              Left = 616
              Top = 19
              Width = 153
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
            end
            object Dbg_Dependentes: TDBGrid
              Left = 4
              Top = 45
              Width = 766
              Height = 267
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_Dependentes
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 2
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'DPT_NOME'
                  Title.Caption = 'Nome'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DPT_PARENTESCO'
                  Title.Caption = 'Grau de Parentesco'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 208
                  Visible = True
                end>
            end
          end
        end
        object Tbs_Avalista: TTabSheet
          Caption = '      Dados Avalista       '
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Avalista: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label58: TLabel
              Left = 10
              Top = 3
              Width = 24
              Height = 14
              Caption = 'C.P.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label59: TLabel
              Left = 150
              Top = 3
              Width = 18
              Height = 14
              Caption = 'R.G'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label60: TLabel
              Left = 7
              Top = 41
              Width = 27
              Height = 14
              Caption = 'Nome'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label61: TLabel
              Left = 301
              Top = 3
              Width = 62
              Height = 14
              Caption = 'Org .Emissor'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label62: TLabel
              Left = 415
              Top = 3
              Width = 65
              Height = 14
              Caption = 'Data Emiss'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label63: TLabel
              Left = 517
              Top = 3
              Width = 81
              Height = 14
              Caption = 'Data Nascimento'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label64: TLabel
              Left = 428
              Top = 41
              Width = 67
              Height = 14
              Caption = 'Nacionalidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label65: TLabel
              Left = 601
              Top = 41
              Width = 60
              Height = 14
              Caption = 'Naturalidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label68: TLabel
              Left = 7
              Top = 234
              Width = 64
              Height = 14
              Caption = 'Complemento'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label69: TLabel
              Left = 354
              Top = 160
              Width = 16
              Height = 14
              Caption = 'U.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label70: TLabel
              Left = 7
              Top = 160
              Width = 25
              Height = 14
              Caption = 'C.E.P'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Da_Cep: TSpeedButton
              Left = 67
              Top = 175
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Da_CepClick
            end
            object Label107: TLabel
              Left = 95
              Top = 160
              Width = 20
              Height = 14
              Caption = 'Pa'#237's'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label108: TLabel
              Left = 410
              Top = 160
              Width = 33
              Height = 14
              Caption = 'Cidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label109: TLabel
              Left = 237
              Top = 234
              Width = 29
              Height = 14
              Caption = 'Bairro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label110: TLabel
              Left = 509
              Top = 234
              Width = 33
              Height = 14
              Caption = 'Regi'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label111: TLabel
              Left = 343
              Top = 271
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label112: TLabel
              Left = 424
              Top = 271
              Width = 48
              Height = 14
              Caption = 'Fax/Outro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label133: TLabel
              Left = 507
              Top = 271
              Width = 33
              Height = 14
              Caption = 'Celular'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label136: TLabel
              Left = 7
              Top = 271
              Width = 67
              Height = 14
              Caption = 'Nome Contato'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object SB_Da_cidade: TSpeedButton
              Left = 744
              Top = 174
              Width = 23
              Height = 22
              Caption = '...'
            end
            object Label142: TLabel
              Left = 594
              Top = 271
              Width = 47
              Height = 14
              Caption = 'Comercial'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label143: TLabel
              Left = 683
              Top = 271
              Width = 37
              Height = 14
              Caption = 'Portaria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label144: TLabel
              Left = 7
              Top = 198
              Width = 46
              Height = 14
              Caption = 'Endere'#231'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label145: TLabel
              Left = 658
              Top = 198
              Width = 80
              Height = 14
              Caption = 'C.N.P.J - Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label146: TLabel
              Left = 474
              Top = 198
              Width = 37
              Height = 14
              Caption = 'N'#250'mero'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Da_Endereco: TSpeedButton
              Left = 446
              Top = 212
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_Da_EnderecoClick
            end
            object Label13: TLabel
              Left = 546
              Top = 82
              Width = 46
              Height = 14
              Caption = 'Profiss'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label150: TLabel
              Left = 698
              Top = 119
              Width = 71
              Height = 14
              Caption = 'Valor da renda'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label151: TLabel
              Left = 7
              Top = 80
              Width = 83
              Height = 14
              Caption = 'Correspond'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label152: TLabel
              Left = 280
              Top = 80
              Width = 28
              Height = 14
              Caption = 'e-mail'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label153: TLabel
              Left = 431
              Top = 119
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
            object Label154: TLabel
              Left = 547
              Top = 119
              Width = 67
              Height = 14
              Caption = 'Insc. Estadual'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label155: TLabel
              Left = 7
              Top = 119
              Width = 155
              Height = 14
              Caption = 'Nome da Empresa - Empregador'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Da_Rg: TEdit
              Left = 148
              Top = 18
              Width = 146
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
            end
            object E_Da_Org_Emissao: TEdit
              Left = 290
              Top = 18
              Width = 120
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 2
            end
            object E_Da_Dt_Rg_Emissao: TDateTimePicker
              Left = 412
              Top = 18
              Width = 98
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 3
            end
            object E_Da_Dt_Nascimento: TDateTimePicker
              Left = 514
              Top = 18
              Width = 98
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 4
            end
            object E_Da_Nome: TEdit
              Left = 7
              Top = 56
              Width = 415
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 5
            end
            object E_Da_Naturalidade: TEdit
              Left = 600
              Top = 56
              Width = 168
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 7
            end
            object E_Da_Compl_Endereco: TEdit
              Left = 7
              Top = 248
              Width = 226
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 25
              ParentFont = False
              TabOrder = 23
            end
            object E_Da_Bairro: TEdit
              Left = 235
              Top = 248
              Width = 270
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              TabOrder = 24
            end
            object E_Da_Cep: TMaskEdit
              Left = 7
              Top = 174
              Width = 59
              Height = 22
              CharCase = ecUpperCase
              EditMask = '#####-###;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 9
              ParentFont = False
              TabOrder = 15
              Text = ''
            end
            object Dblcb_Da_Pais: TDBLookupComboBox
              Left = 93
              Top = 174
              Width = 255
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'PAI_CODBACEN'
              ListField = 'PAI_DESCRICAO'
              ListSource = DM.ds_Pais
              ParentFont = False
              TabOrder = 16
            end
            object DBLCB_Da_Cidade: TDBLookupComboBox
              Left = 408
              Top = 174
              Width = 333
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'CDD_CODIGO'
              ListField = 'CDD_DESCRICAO'
              ListSource = DM.Ds_Cidades
              ParentFont = False
              TabOrder = 18
            end
            object E_Da_Regiao: TEdit
              Left = 507
              Top = 248
              Width = 264
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 25
            end
            object E_Da_Fax: TMaskEdit
              Left = 415
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 28
              Text = ''
            end
            object E_Da_Fone: TMaskEdit
              Left = 324
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 27
              Text = ''
            end
            object E_Da_Celular: TMaskEdit
              Left = 504
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 29
              Text = ''
            end
            object E_Da_Contato: TEdit
              Left = 7
              Top = 286
              Width = 314
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 26
            end
            object Chb_Da_Principal: TCheckBox
              Left = 534
              Top = 198
              Width = 113
              Height = 13
              Caption = 'Endere'#231'o Principal '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 32
            end
            object E_Da_Fone_Comercial: TMaskEdit
              Left = 593
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 30
              Text = ''
            end
            object E_Da_Fone_Portaria: TMaskEdit
              Left = 682
              Top = 286
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 31
              Text = ''
            end
            object E_Da_Endereco: TEdit
              Left = 7
              Top = 212
              Width = 434
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 19
            end
            object E_Da_Cnpj_Entrega: TMaskEdit
              Left = 657
              Top = 212
              Width = 113
              Height = 22
              CharCase = ecUpperCase
              EditMask = '##.###.###/####-##;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 18
              ParentFont = False
              TabOrder = 22
              Text = ''
            end
            object E_Da_Nr_Endereco: TEdit
              Left = 472
              Top = 212
              Width = 58
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 20
            end
            object DBLCB_Da_Estado: TDBLookupComboBox
              Left = 350
              Top = 174
              Width = 58
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'UFE_CODIGO'
              ListField = 'UFE_SIGLA'
              ListSource = DM.Ds_UF
              ParentFont = False
              TabOrder = 17
            end
            object Cb_Da_Tipo_Endereco: TComboBox
              Left = 533
              Top = 212
              Width = 123
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemIndex = 0
              ParentFont = False
              TabOrder = 21
              Text = 'COMERCIAL'
              Items.Strings = (
                'COMERCIAL'
                'RESIDENCIAL'
                'ENTREGA'
                'COBRAN'#199'A')
            end
            object E_Da_Nacionalidade: TEdit
              Left = 425
              Top = 56
              Width = 171
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 6
            end
            object E_Da_Profissao: TEdit
              Left = 537
              Top = 95
              Width = 231
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 10
            end
            object E_Da_Vl_Renda: TEdit_Setes
              Left = 697
              Top = 134
              Width = 72
              Height = 22
              Alignment = taRightJustify
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 14
              Text = ''
            end
            object E_Da_Correspondencia: TEdit
              Left = 7
              Top = 95
              Width = 263
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 8
            end
            object E_Da_Email: TEdit
              Left = 277
              Top = 95
              Width = 258
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecLowerCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 9
            end
            object E_Da_Cnpj_Empregador: TMaskEdit
              Left = 428
              Top = 134
              Width = 113
              Height = 22
              BiDiMode = bdLeftToRight
              EditMask = '99.999.999/9999-99;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 18
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 12
              Text = ''
            end
            object E_Da_Insc_Est_Empregador: TEdit
              Left = 545
              Top = 134
              Width = 148
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 13
            end
            object E_Da_Empregador: TEdit
              Left = 7
              Top = 134
              Width = 418
              Height = 22
              BiDiMode = bdLeftToRight
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 11
            end
            object E_Da_CPF: TMaskEdit
              Left = 8
              Top = 18
              Width = 137
              Height = 22
              EditMask = '000.000.000-00;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 0
              Text = ''
            end
          end
        end
        object Tbs_RefBancaria: TTabSheet
          Caption = 'Refer'#234'ncia Banc'#225'ria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImageIndex = 5
          ParentFont = False
          OnShow = Tbs_RefBancariaShow
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Ref_Bancaria: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              776
              357)
            object Label66: TLabel
              Left = 153
              Top = 4
              Width = 86
              Height = 14
              Caption = 'N'#250'mero do Banco'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label67: TLabel
              Left = 251
              Top = 4
              Width = 79
              Height = 14
              Caption = 'N'#250'mero Ag'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label96: TLabel
              Left = 346
              Top = 4
              Width = 83
              Height = 14
              Caption = 'N'#250'mero da Conta'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label101: TLabel
              Left = 464
              Top = 4
              Width = 65
              Height = 14
              Caption = 'Cliente desde'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label102: TLabel
              Left = 550
              Top = 4
              Width = 92
              Height = 14
              Caption = 'N'#250'mero do Cheque'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Ins_Ref_Bancaria: TSpeedButton
              Left = 5
              Top = 315
              Width = 94
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Novo - F2'
              Flat = True
              Transparent = False
              OnClick = Sb_Ins_Ref_BancariaClick
            end
            object Sb_Alt_Ref_Bancaria: TSpeedButton
              Left = 99
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Alterar - F3'
              Flat = True
              Transparent = False
              OnClick = Sb_Alt_Ref_BancariaClick
            end
            object Sb_Exc_Ref_Bancaria: TSpeedButton
              Left = 196
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Excluir - F4'
              Flat = True
              Transparent = False
              OnClick = Sb_Exc_Ref_BancariaClick
            end
            object Sb_Grv_Ref_Bancaria: TSpeedButton
              Left = 296
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Gravar - F5'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Grv_Ref_BancariaClick
            end
            object Sb_Can_Ref_Bancaria: TSpeedButton
              Left = 393
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Cancelar - F6'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Can_Ref_BancariaClick
            end
            object E_Rb_Banco: TEdit
              Left = 150
              Top = 19
              Width = 95
              Height = 22
              BiDiMode = bdLeftToRight
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 3
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
            end
            object E_Rb_Agencia: TEdit
              Left = 249
              Top = 19
              Width = 93
              Height = 22
              BiDiMode = bdLeftToRight
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 8
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 2
            end
            object E_Rb_Conta: TEdit
              Left = 343
              Top = 19
              Width = 116
              Height = 22
              BiDiMode = bdLeftToRight
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 10
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 3
            end
            object E_Rb_Nr_Cheques: TEdit
              Left = 547
              Top = 19
              Width = 224
              Height = 22
              BiDiMode = bdLeftToRight
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 30
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 5
            end
            object Dbg_Refer_Bancaria: TDBGrid
              Left = 4
              Top = 46
              Width = 766
              Height = 266
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_Ref_Bancaria
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 6
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'RFB_BANCO'
                  Title.Caption = 'Banco'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFB_AGENCIA'
                  Title.Caption = 'Ag'#234'ncia'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 73
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFB_CONTA'
                  Title.Caption = 'Conta'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 154
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFB_DT_ABERTURA'
                  Title.Caption = 'Cliente desde'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 118
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFB_NR_CHEQUE'
                  Title.Caption = 'N'#186' Cheque'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 307
                  Visible = True
                end>
            end
            object Rg_Rb_Tipo_Conta: TRadioGroup
              Left = 5
              Top = 2
              Width = 142
              Height = 41
              Caption = 'Tipo Conta'
              Columns = 2
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Items.Strings = (
                'Comum'
                'Especial')
              ParentFont = False
              TabOrder = 0
            end
            object E_Rb_Dt_Abertura: TDateTimePicker
              Left = 462
              Top = 19
              Width = 83
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 4
            end
          end
        end
        object Tbs_RefPessoal: TTabSheet
          Caption = 'Refr'#234'ncia Pessoal'
          ImageIndex = 8
          OnShow = Tbs_RefPessoalShow
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Ref_Pessoal: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              776
              357)
            object Label91: TLabel
              Left = 8
              Top = 4
              Width = 28
              Height = 13
              Caption = 'Nome'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label93: TLabel
              Left = 250
              Top = 4
              Width = 44
              Height = 13
              Caption = 'Afinidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label94: TLabel
              Left = 376
              Top = 4
              Width = 42
              Height = 13
              Caption = 'Telefone'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Ins_Ref_Pessoal: TSpeedButton
              Left = 5
              Top = 315
              Width = 94
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Novo - F2'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Ins_Ref_PessoalClick
            end
            object Sb_Alt_Ref_Pessoal: TSpeedButton
              Left = 99
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Alterar - F3'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Alt_Ref_PessoalClick
            end
            object Sb_Exc_Ref_Pessoal: TSpeedButton
              Left = 196
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Excluir - F4'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Exc_Ref_PessoalClick
            end
            object Label87: TLabel
              Left = 519
              Top = 4
              Width = 33
              Height = 14
              Caption = 'Cidade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Grv_Ref_Pessoal: TSpeedButton
              Left = 296
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Gravar - F5'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Grv_Ref_PessoalClick
            end
            object Sb_Can_Ref_Pessoal: TSpeedButton
              Left = 393
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Cancelar - F6'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Can_Ref_PessoalClick
            end
            object Label156: TLabel
              Left = 462
              Top = 4
              Width = 16
              Height = 14
              Caption = 'U.F'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Rp_Nome: TEdit
              Left = 6
              Top = 19
              Width = 240
              Height = 22
              BiDiMode = bdLeftToRight
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 0
            end
            object E_Rp_Afinidade: TEdit
              Left = 248
              Top = 19
              Width = 119
              Height = 22
              BiDiMode = bdLeftToRight
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
            end
            object DBLCB_Rp_Cidade: TDBLookupComboBox
              Left = 517
              Top = 19
              Width = 255
              Height = 22
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'CDD_CODIGO'
              ListField = 'CDD_DESCRICAO'
              ListSource = DM.Ds_Cidades
              ParentFont = False
              TabOrder = 4
            end
            object E_Rp_Fone: TMaskEdit
              Left = 369
              Top = 19
              Width = 86
              Height = 22
              CharCase = ecUpperCase
              Enabled = False
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 2
              Text = ''
            end
            object Dbg_Refer_Pessoal: TDBGrid
              Left = 4
              Top = 45
              Width = 766
              Height = 267
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_Ref_Pessoal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 5
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'RFP_NOME'
                  Title.Caption = 'Nome'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFP_AFINIDADE'
                  Title.Caption = 'Afinidade'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 117
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFP_FONE'
                  Title.Caption = 'Fone'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 92
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UFE_SIGLA'
                  Title.Caption = 'U.F.'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 34
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CDD_DESCRICAO'
                  Title.Caption = 'Cidade'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 245
                  Visible = True
                end>
            end
            object DBLCB_Rp_Estado: TDBLookupComboBox
              Left = 458
              Top = 19
              Width = 58
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'UFE_CODIGO'
              ListField = 'UFE_SIGLA'
              ListSource = DM.Ds_UF
              ParentFont = False
              TabOrder = 3
            end
          end
        end
        object Tbs_RefComercial: TTabSheet
          Caption = 'Refer'#234'ncia Comercial'
          ImageIndex = 6
          OnShow = Tbs_RefComercialShow
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Ref_Comercial: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              776
              357)
            object Label78: TLabel
              Left = 8
              Top = 4
              Width = 28
              Height = 13
              Caption = 'Nome'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label80: TLabel
              Left = 686
              Top = 4
              Width = 31
              Height = 13
              Caption = 'Desde'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Ins_Ref_Comercial: TSpeedButton
              Left = 5
              Top = 315
              Width = 94
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Novo - F2'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Ins_Ref_ComercialClick
            end
            object Sb_Alt_Ref_Comercial: TSpeedButton
              Left = 99
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Alterar - F3'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Alt_Ref_ComercialClick
            end
            object Sb_Exc_Ref_Comercial: TSpeedButton
              Left = 196
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Excluir - F4'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Exc_Ref_ComercialClick
            end
            object Label88: TLabel
              Left = 432
              Top = 4
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label89: TLabel
              Left = 513
              Top = 4
              Width = 48
              Height = 14
              Caption = 'Fax/Outro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label90: TLabel
              Left = 596
              Top = 4
              Width = 33
              Height = 14
              Caption = 'Celular'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Grv_Ref_Comercial: TSpeedButton
              Left = 296
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Gravar - F5'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Grv_Ref_ComercialClick
            end
            object Sb_Can_Ref_Comercial: TSpeedButton
              Left = 393
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Cancelar - F6'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Can_Ref_ComercialClick
            end
            object E_Rc_Nome: TEdit
              Left = 6
              Top = 19
              Width = 421
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 0
            end
            object E_Rc_Fax: TMaskEdit
              Left = 513
              Top = 19
              Width = 84
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 2
              Text = ''
            end
            object E_Rc_Fone: TMaskEdit
              Left = 429
              Top = 19
              Width = 84
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 1
              Text = ''
            end
            object E_Rc_Celular: TMaskEdit
              Left = 597
              Top = 19
              Width = 85
              Height = 22
              CharCase = ecUpperCase
              EditMask = '!\(##\) ####-####;0;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 3
              Text = ''
            end
            object Dbg_Refer_Comercial: TDBGrid
              Left = 4
              Top = 45
              Width = 766
              Height = 267
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_Ref_Comercial
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 5
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'RFC_NOME'
                  Title.Caption = 'Nome'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFC_FONE'
                  Title.Caption = 'Fone'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 81
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFC_FAX'
                  Title.Caption = 'Fax'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 81
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFC_CELULAR'
                  Title.Caption = 'Celular'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 84
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'RFC_DT_DESDE'
                  Title.Caption = 'Desde'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end>
            end
            object E_Rc_Dt_Desde: TDateTimePicker
              Left = 684
              Top = 18
              Width = 83
              Height = 22
              BiDiMode = bdLeftToRight
              Date = 39580.356281493060000000
              Time = 39580.356281493060000000
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 4
            end
          end
        end
        object Tbs_BemGarantia: TTabSheet
          Caption = 'Bem em Garantia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImageIndex = 7
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          OnShow = Tbs_BemGarantiaShow
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Bem_Garantia: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            BiDiMode = bdLeftToRight
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBiDiMode = False
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              776
              357)
            object Sb_Ins_Bem_Garantia: TSpeedButton
              Left = 5
              Top = 315
              Width = 94
              Height = 38
              Anchors = [akLeft, akBottom]
              BiDiMode = bdLeftToRight
              Caption = 'Novo - F2'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ParentBiDiMode = False
              OnClick = Sb_Ins_Bem_GarantiaClick
            end
            object Sb_Alt_Bem_Garantia: TSpeedButton
              Left = 99
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Alterar - F3'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              OnClick = Sb_Alt_Bem_GarantiaClick
            end
            object Sb_Exc_Bem_Garantia: TSpeedButton
              Left = 196
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Excluir - F4'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              OnClick = Sb_Exc_Bem_GarantiaClick
            end
            object Label45: TLabel
              Left = 6
              Top = 4
              Width = 21
              Height = 13
              Caption = 'Bem'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label71: TLabel
              Left = 254
              Top = 4
              Width = 41
              Height = 13
              Caption = 'Valor R$'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label72: TLabel
              Left = 360
              Top = 4
              Width = 55
              Height = 13
              Caption = 'Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label73: TLabel
              Left = 530
              Top = 4
              Width = 92
              Height = 13
              Caption = 'Refer'#234'ncia/Modelo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Grv_Bem_Garantia: TSpeedButton
              Left = 296
              Top = 315
              Width = 97
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Gravar - F5'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Grv_Bem_GarantiaClick
            end
            object Sb_Can_Bem_Garantia: TSpeedButton
              Left = 393
              Top = 315
              Width = 100
              Height = 38
              Anchors = [akLeft, akBottom]
              Caption = 'Cancelar - F6'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
              OnClick = Sb_Can_Bem_GarantiaClick
            end
            object E_Bg_Documento: TEdit
              Left = 358
              Top = 19
              Width = 168
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 2
            end
            object E_Bg_Referencia: TEdit
              Left = 528
              Top = 19
              Width = 241
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 3
            end
            object E_Bg_Descricao: TEdit
              Left = 4
              Top = 19
              Width = 245
              Height = 22
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 0
            end
            object E_Bg_Valor: TEdit_Setes
              Left = 251
              Top = 19
              Width = 105
              Height = 22
              Alignment = taRightJustify
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
              Text = ''
              OnExit = E_Bg_ValorExit
            end
            object Dbg_BemGarantia: TDBGrid
              Left = 4
              Top = 45
              Width = 766
              Height = 267
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_BemGarantia
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 4
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'FBG_DESCRICAO'
                  Title.Caption = 'Descri'#231#227'o'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FBG_VALOR'
                  Title.Caption = 'Valor'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 86
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FBG_TP_DOC'
                  Title.Caption = 'Tipo do Documento'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FBG_REFERENCIA'
                  Title.Caption = 'Refer'#234'ncia'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 197
                  Visible = True
                end>
            end
          end
        end
        object Tbs_FormaPagto: TTabSheet
          Caption = 'Formas de Pagamentos'
          ImageIndex = 9
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Forma_Pagto: TPanel
            Left = 0
            Top = 0
            Width = 776
            Height = 357
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label4: TLabel
              Left = 4
              Top = 3
              Width = 80
              Height = 14
              Caption = 'Valor da Compra'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label74: TLabel
              Left = 119
              Top = 3
              Width = 42
              Height = 14
              Caption = 'Parcelas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label75: TLabel
              Left = 665
              Top = 3
              Width = 66
              Height = 14
              Caption = 'Valor da Taxa'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label76: TLabel
              Left = 4
              Top = 41
              Width = 47
              Height = 14
              Caption = 'Vendedor'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label77: TLabel
              Left = 408
              Top = 41
              Width = 76
              Height = 14
              Caption = 'N'#250'mero da N. F.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label79: TLabel
              Left = 520
              Top = 41
              Width = 62
              Height = 14
              Caption = 'Data Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label22: TLabel
              Left = 296
              Top = 41
              Width = 87
              Height = 14
              Caption = 'N'#250'mero do Pedido'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label157: TLabel
              Left = 9
              Top = 124
              Width = 66
              Height = 14
              Caption = 'Observa'#231#245'es'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Fp_Vl_Compra: TEdit_Setes
              Left = 4
              Top = 17
              Width = 109
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 25
              ParentFont = False
              TabOrder = 0
              Text = ''
              OnExit = E_Fp_Vl_CompraExit
            end
            object E_Fp_Parcelamento: TEdit
              Left = 117
              Top = 17
              Width = 544
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              TabOrder = 1
            end
            object E_Fp_VL_Taxa: TEdit_Setes
              Left = 664
              Top = 17
              Width = 105
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              Text = ''
              OnExit = E_Fp_VL_TaxaExit
            end
            object DBLCB_Fp_Vendedor: TDBLookupComboBox
              Left = 4
              Top = 55
              Width = 290
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'CLB_CODIGO'
              ListField = 'CLB_NOME'
              ListSource = DM_ListaConsultas.DS_ListaVendedor
              ParentFont = False
              TabOrder = 3
            end
            object E_Fp_Nota_Fiscal: TEdit
              Left = 408
              Top = 55
              Width = 109
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 25
              ParentFont = False
              TabOrder = 5
            end
            object Rg_FP_SituacaoFicha: TRadioGroup
              Left = 6
              Top = 80
              Width = 250
              Height = 42
              Caption = 'Situa'#231#227'o da Ficha'
              Columns = 3
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Items.Strings = (
                'Avalia'#231#227'o'
                'Aprovado'
                'Reprovado')
              ParentFont = False
              TabOrder = 7
            end
            object Rg_Fp_TipoFicha: TRadioGroup
              Left = 258
              Top = 80
              Width = 185
              Height = 42
              Caption = 'Tipo da Ficha'
              Columns = 2
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Items.Strings = (
                'Pedido'
                'Or'#231'amento')
              ParentFont = False
              TabOrder = 8
            end
            object E_Fp_Pedido: TEdit
              Left = 296
              Top = 55
              Width = 109
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 25
              ParentFont = False
              TabOrder = 4
            end
            object E_Fp_Dt_Entrega: TMaskEdit
              Left = 520
              Top = 56
              Width = 72
              Height = 22
              EditMask = '!99/99/0000;1;_'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 6
              Text = '  /  /    '
            end
            object E_Fp_Obs: TMemo
              Left = 2
              Top = 138
              Width = 772
              Height = 217
              Align = alBottom
              Anchors = [akLeft, akTop, akRight, akBottom]
              Lines.Strings = (
                'E_Fp_Obs')
              TabOrder = 9
            end
          end
        end
      end
    end
  end
  object Qr_DadosGerais: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      ' FCT_DATA, '
      '  EMP_CNPJ,'
      '  EMP_INSC_EST,'
      '  PFS_RG_ORG_EMISSAO,'
      '  PFS_RG_DT_EMISSAO,'
      '  emp.emp_dt_funda,'
      '  emp.emp_nome,'
      '  PFS_NACIONALIDADE,'
      '  PFS_NATURALIDADE,'
      '  PFS_EST_CIVIL,'
      '  PFS_SEXO,'
      '  EMP_EMAIL,'
      '  PFS_ESCOLARIDADE,'
      '  PFS_NOME_PAI,'
      '  PFS_NOME_MAE,'
      '  PFS_RESIDENCIA,'
      '  PFS_SIT_RESIDENCIA, '
      '  PFS_TEMPO_RESIDENCIA,'
      '  PFS_CORRESPONDENCIA,'
      '  FCT_CODIGO,'
      '  FCT_CODEMP,'
      '  FCT_CONJUGE,'
      '  FCT_AVALISTA,'
      '  FCT_NR_PEDIDO,'
      '  FCT_VL_COMPRA,'
      '  FCT_PARCELAS,'
      '  FCT_VL_TAXA,'
      '  FCT_CODVDO,'
      '  FCT_NR_NOTA,'
      '  FCT_DT_ENTREGA,'
      '  FCT_SIT_FICHA,'
      '  FCT_TP_FICHA,'
      '  FCT_OBS'
      'FROM tb_empresa EMP'
      '   left outer join tb_ficha_cadastral FCH'
      '   ON (EMP.emp_codigo = FCH.fct_codemp)'
      '   left outer join  tb_pessoa_fisica PSF'
      '   ON (PSF.pfs_codemp = EMP.emp_codigo)')
    Left = 60
    Top = 426
  end
  object Qr_Endereco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  END_CODIGO,'
      '  END_CODEMP,'
      '  END_CNPJ,'
      '  END_TIPO,'
      '  END_ENDER,'
      '  END_NUMERO,'
      '  END_COMPLEM,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_CODCDD,'
      '  CDD_DESCRICAO,'
      '  END_REGIAO,'
      '  END_CODUFE,'
      '  UFE_SIGLA,'
      '  END_CONTATO,'
      '  END_FONE,'
      '  END_FAX,'
      '  END_CELULAR,'
      '  END_PAIS,'
      '  END_COMERCIAL,'
      '  END_PORTARIA,'
      '  END_PRINCIPAL'
      'FROM TB_ENDERECO'
      '         LEFT OUTER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         LEFT OUTER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)')
    Left = 94
    Top = 426
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Gravacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 27
    Top = 426
  end
  object Qr_DadosProfissionais: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      '  FCP_CODEMP'
      ', EMP_NOME'
      ', EMP_CNPJ'
      ', EMP_INSC_EST'
      ', EMP_DT_FUNDA'
      ', FCP_TP_TRABALHO'
      ', FCP_CLASSE'
      ', FCP_ATIVIDADE'
      ', FCP_PROFISSAO'
      ', FCP_VL_RENDA'
      ', FCP_VL_OUTROS'
      ', FCP_VALOR'
      ', FCP_DT_ADMISSAO'
      ', FCP_NR_BENEFICIO'
      ', FCP_CODEPG'
      ', FCP_EPG_NAT_JUR'
      ', FCP_EPG_FATURAMENTO'
      ', FCP_EPG_CAPITAL'
      ', FCP_EPG_DT_SOCIO'
      ', FCP_CTDR_NOME'
      ', FCP_CTDR_FONE'
      ', FCP_CTDR_FAX'
      ', FCP_CTDR_CELULAR'
      'from tb_ficha_profissional FCP'
      '   LEFT OUTER JOIN tb_empresa tb_empregador'
      '   On (tb_empregador.emp_codigo = FCP.fcp_codepg)')
    Left = 164
    Top = 426
  end
  object Qr_DadosConjuge: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select  CJG.EMP_CNPJ,  CJG.EMP_INSC_EST,  CJG.emp_dt_funda, CJG.' +
        'EMP_NOME, CJG.EMP_EMAIL,PFS_RG_ORG_EMISSAO,  PFS_RG_DT_EMISSAO,'
      
        'PFS_NACIONALIDADE,  PFS_NATURALIDADE,  FCP.fcp_profissao, FCP.fc' +
        'p_vl_renda, PFS_CORRESPONDENCIA, FCP_CODEPG,'
      
        'EPR.emp_nome EPR_NOME,EPR.emp_cnpj EPR_CNPJ,EPR.emp_insc_est EPR' +
        '_INSC_EST'
      'FROM tb_empresa CJG'
      ' LEFT OUTER join  tb_pessoa_fisica PSF'
      ' ON (PSF.pfs_codemp = CJG.emp_codigo)'
      ' LEFT OUTER join  tb_ficha_profissional FCP'
      ' ON (FCP.fcp_codemp = CJG.emp_codigo)'
      ' LEFT OUTER JOIN tb_empresa EPR'
      ' ON (EPR.emp_codigo = FCP.fcp_codepg)'
      ''
      'WHERE (CJG.emp_codigo=:EMP_CODIGO)')
    Left = 204
    Top = 426
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_DadosAvalista: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select  AVA.EMP_CNPJ,  AVA.EMP_INSC_EST,  AVA.emp_dt_funda, AVA.' +
        'EMP_NOME, AVA.EMP_EMAIL,PFS_RG_ORG_EMISSAO,  PFS_RG_DT_EMISSAO,'
      
        'PFS_NACIONALIDADE,  PFS_NATURALIDADE,  FCP.fcp_profissao, FCP.fc' +
        'p_vl_renda, PFS_CORRESPONDENCIA, FCP_CODEPG,'
      
        'EPR.emp_nome EPR_NOME,EPR.emp_cnpj EPR_CNPJ,EPR.emp_insc_est EPR' +
        '_INSC_EST'
      'FROM tb_empresa AVA'
      ' LEFT OUTER join  tb_pessoa_fisica PSF'
      ' ON (PSF.pfs_codemp = AVA.emp_codigo)'
      ' LEFT OUTER join  tb_ficha_profissional FCP'
      ' ON (FCP.fcp_codemp = AVA.emp_codigo)'
      ' LEFT OUTER JOIN tb_empresa EPR'
      ' ON (EPR.emp_codigo = FCP.fcp_codepg)'
      ''
      'WHERE (AVA.emp_codigo=:EMP_CODIGO)')
    Left = 244
    Top = 426
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Dependentes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  DPT_CODIGO,'
      '  DPT_CODEMP,'
      '  DPT_NOME,'
      '  DPT_PARENTESCO'
      'FROM TB_DEPENDENTE'
      'WHERE DPT_CODEMP=:EMP_CODIGO')
    Left = 284
    Top = 426
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Dependentes: TDataSource
    DataSet = Qr_Dependentes
    Left = 284
    Top = 456
  end
  object Qr_Ref_Bancaria: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  RFB_CODIGO,'
      '  RFB_CODEMP,'
      '  RFB_BANCO,'
      '  RFB_AGENCIA,'
      '  RFB_CONTA,'
      '  RFB_DT_ABERTURA,'
      '  RFB_NR_CHEQUE,'
      '  RFB_TP_CONTA'
      'FROM TB_REFER_BANCARIA'
      'WHERE RFB_CODEMP=:EMP_CODIGO')
    Left = 316
    Top = 426
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Ref_Bancaria: TDataSource
    DataSet = Qr_Ref_Bancaria
    Left = 316
    Top = 456
  end
  object Qr_Ref_Pessoal: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  RFP_CODIGO,'
      '  RFP_CODEMP,'
      '  RFP_NOME,'
      '  RFP_AFINIDADE,'
      '  RFP_FONE,'
      '  RFP_CODUFE,'
      '  UFE_SIGLA,'
      '  RFP_CODCDD,'
      '  CDD_DESCRICAO'
      'FROM TB_REFER_PESSOAL'
      '   INNER JOIN TB_UF'
      '  ON (UFE_CODIGO = RFP_CODUFE)'
      '   INNER JOIN TB_CIDADE'
      '   ON (CDD_CODIGO = RFP_CODCDD)'
      'WHERE RFP_CODEMP=:EMP_CODIGO')
    Left = 351
    Top = 426
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Ref_Pessoal: TDataSource
    DataSet = Qr_Ref_Pessoal
    Left = 351
    Top = 456
  end
  object Qr_Ref_Comercial: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  RFC_CODIGO,'
      '  RFC_CODEMP,'
      '  RFC_NOME,'
      '  RFC_FONE,'
      '  RFC_FAX,'
      '  RFC_CELULAR,'
      '  RFC_DT_DESDE'
      'FROM TB_REFER_COMERCIAL'
      'WHERE RFC_CODEMP=:EMP_CODIGO')
    Left = 383
    Top = 426
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Ref_Comercial: TDataSource
    DataSet = Qr_Ref_Comercial
    Left = 383
    Top = 456
  end
  object Qr_BemGarantia: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  "FBG_CODIGO"'
      ', "FBG_CODFCT"'
      ', "FBG_DESCRICAO"'
      ', "FBG_VALOR"'
      ', "FBG_TP_DOC"'
      ', "FBG_REFERENCIA"'
      'from "TB_FICHA_BEM_GARANTIA"'
      'WHERE FBG_CODFCT=:FCT_CODIGO')
    Left = 423
    Top = 418
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FCT_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_BemGarantia: TDataSource
    DataSet = Qr_BemGarantia
    Left = 415
    Top = 456
  end
end
