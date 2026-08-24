object Fr_Empresa: TFr_Empresa
  Left = 368
  Top = 100
  Anchors = [akTop, akBottom]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Empresa'
  ClientHeight = 528
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Menu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 204
    Width = 668
    Height = 259
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object PG_Informacoes: TPageControl
      Left = 2
      Top = 2
      Width = 664
      Height = 255
      ActivePage = TabSheet1
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object TabSheet3: TTabSheet
        Caption = 'Observa'#231#227'o'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pg_fiscal: TPageControl
          Left = 0
          Top = 0
          Width = 656
          Height = 224
          ActivePage = TabSheet6
          Align = alClient
          TabOrder = 0
          object TabSheet6: TTabSheet
            Caption = 'Geral'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Pnl_Observacao: TPanel
              Left = 0
              Top = 0
              Width = 648
              Height = 196
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object obs_Geral: TMemo
                Left = 2
                Top = 2
                Width = 644
                Height = 192
                Align = alClient
                MaxLength = 500
                TabOrder = 0
              end
            end
          end
          object TabSheet8: TTabSheet
            Caption = 'Observa'#231#227'o Fiscal'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Obs_Fiscal: TMemo
              Left = 0
              Top = 0
              Width = 648
              Height = 196
              Align = alClient
              MaxLength = 500
              TabOrder = 0
            end
          end
        end
      end
      object Contato: TTabSheet
        Caption = 'Contatos'
        ImageIndex = 2
        OnShow = ContatoShow
        object Pnl_Contato: TPanel
          Left = 0
          Top = 0
          Width = 656
          Height = 224
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            656
            224)
          object Sb_Exc_Contato: TSpeedButton
            Left = 198
            Top = 181
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
            OnClick = Sb_Exc_ContatoClick
            ExplicitTop = 168
          end
          object Sb_Alt_Contato: TSpeedButton
            Left = 101
            Top = 181
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
            OnClick = Sb_Alt_ContatoClick
            ExplicitTop = 168
          end
          object Sb_Ins_Contato: TSpeedButton
            Left = 7
            Top = 181
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
            OnClick = Sb_Ins_ContatoClick
            ExplicitTop = 168
          end
          object DBG_Socios: TDBGrid
            Left = 2
            Top = 2
            Width = 652
            Height = 175
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataSource = Ds_Contato
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'CTO_CODIGO'
                Title.Caption = 'C'#243'digo'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CTO_NOME'
                Title.Caption = 'Nome'
                Width = 327
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CRG_DESCRICAO'
                Title.Caption = 'Cargo'
                Width = 223
                Visible = True
              end>
          end
        end
      end
      object tbs_Endereco: TTabSheet
        Caption = 'Endere'#231'os'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Endereco: TPanel
          Left = 0
          Top = 0
          Width = 656
          Height = 181
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          OnEnter = Pnl_EnderecoEnter
          object Label16: TLabel
            Left = 6
            Top = 75
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
          object Label23: TLabel
            Left = 300
            Top = 3
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
          object Label18: TLabel
            Left = 6
            Top = 3
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
          object Sb_Cep: TSpeedButton
            Left = 67
            Top = 18
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
            OnClick = Sb_CepClick
          end
          object Label46: TLabel
            Left = 95
            Top = 2
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
          object Label47: TLabel
            Left = 354
            Top = 2
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
          object Label21: TLabel
            Left = 168
            Top = 75
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
          object Label49: TLabel
            Left = 463
            Top = 75
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
          object Label20: TLabel
            Left = 180
            Top = 111
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
            Left = 273
            Top = 111
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
          object Label13: TLabel
            Left = 368
            Top = 111
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
          object Label25: TLabel
            Left = 8
            Top = 111
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
            Left = 622
            Top = 18
            Width = 23
            Height = 22
            Caption = '...'
            OnClick = SB_Cad_cidadeClick
          end
          object Label50: TLabel
            Left = 462
            Top = 111
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
          object Label53: TLabel
            Left = 556
            Top = 111
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
          object Label15: TLabel
            Left = 6
            Top = 41
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
          object Label30: TLabel
            Left = 529
            Top = 41
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
            Left = 343
            Top = 41
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
          object Sb_Endereco: TSpeedButton
            Left = 317
            Top = 55
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
            OnClick = Sb_EnderecoClick
          end
          object E_Complemento: TMaskEdit
            Left = 6
            Top = 89
            Width = 159
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 25
            ParentFont = False
            TabOrder = 8
            Text = ''
          end
          object E_Bairro: TMaskEdit
            Left = 166
            Top = 89
            Width = 293
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 9
            Text = ''
          end
          object E_cep: TMaskEdit
            Left = 6
            Top = 17
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
            TabOrder = 0
            Text = ''
            OnExit = E_cepExit
          end
          object Dblcb_Pais: TDBLookupComboBox
            Left = 93
            Top = 18
            Width = 203
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
            TabOrder = 1
          end
          object DBLCB_Cidade: TDBLookupComboBox
            Left = 352
            Top = 18
            Width = 266
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
            TabOrder = 3
          end
          object E_Regiao: TMaskEdit
            Left = 461
            Top = 89
            Width = 183
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            Text = ''
          end
          object E_Fax: TEdit_Setes
            Left = 273
            Top = 126
            Width = 93
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            Text = ''
            IsFone = True
          end
          object E_Celular: TEdit_Setes
            Left = 368
            Top = 126
            Width = 93
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
            Text = ''
            IsFone = True
          end
          object E_Contato: TMaskEdit
            Left = 6
            Top = 126
            Width = 171
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 11
            Text = ''
          end
          object Chb_Principal: TCheckBox
            Left = 403
            Top = 41
            Width = 113
            Height = 13
            Caption = 'Endere'#231'o Principal '
            TabOrder = 17
          end
          object E_Fone_Coml: TEdit_Setes
            Left = 462
            Top = 126
            Width = 93
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
            Text = ''
            IsFone = True
          end
          object E_Fone_Port: TEdit_Setes
            Left = 556
            Top = 126
            Width = 93
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
            Text = ''
            IsFone = True
          end
          object E_Endereco: TMaskEdit
            Left = 6
            Top = 55
            Width = 307
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 4
            Text = ''
          end
          object E_CNPJ: TMaskEdit
            Left = 528
            Top = 55
            Width = 115
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
            TabOrder = 7
            Text = ''
          end
          object E_Numero: TMaskEdit
            Left = 341
            Top = 55
            Width = 58
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            Text = ''
          end
          object DBLCB_UF: TDBLookupComboBox
            Left = 299
            Top = 18
            Width = 51
            Height = 21
            KeyField = 'UFE_CODIGO'
            ListField = 'UFE_SIGLA'
            ListSource = DM.Ds_UF
            TabOrder = 2
          end
          object Cb_Tipo: TComboBox
            Left = 402
            Top = 55
            Width = 123
            Height = 21
            Style = csDropDownList
            TabOrder = 6
            Items.Strings = (
              'COMERCIAL'
              'RESIDENCIAL'
              'ENTREGA'
              'COBRAN'#199'A')
          end
          object E_Fone: TEdit_Setes
            Left = 178
            Top = 126
            Width = 93
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            Text = ''
            IsFone = True
          end
          object Chbx_Whatsup: TCheckBox
            Left = 369
            Top = 150
            Width = 237
            Height = 14
            Caption = 'O celular informado est'#225' usando o Whats'#39'up'
            TabOrder = 18
          end
        end
        object Pnl_Navegacao: TPanel
          Left = 0
          Top = 181
          Width = 656
          Height = 43
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Label32: TLabel
            Left = 529
            Top = 2
            Width = 125
            Height = 14
            Align = alTop
            Alignment = taRightJustify
            Caption = 'Navega'#231#227'o de Endere'#231'os'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object SB_Ins_Ender: TSpeedButton
            Left = 574
            Top = 16
            Width = 80
            Height = 25
            Align = alRight
            Caption = 'Endere'#231'os'
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
              000557777777777777750BBBBBBBBBBBBBB07F5555FFFFFFF5570BBBB0000000
              BBB07F5557777777FF570BBB077BBB770BB07F557755555775570BBBBBBBBBBB
              BBB07F5555FFFFFFF5570BBBB0000000BBB07F5557777777F5570BBBB0FFFFF0
              BBB07F5557FFFFF7F5570BBBB0000000BBB07F555777777755570BBBBBBBBBBB
              BBB07FFFFFFFFFFFFFF700000000000000007777777777777777500FFFFFFFFF
              F005577FF555FFFFF7755500FFF00000005555775FF7777777F5550F777FFFFF
              F055557F777FFF5557F5550000000FFF00555577777775FF77F5550777777000
              7055557FFFFFF777F7F555000000000000555577777777777755}
            NumGlyphs = 2
            ParentFont = False
            OnClick = SB_Ins_EnderClick
            ExplicitLeft = 580
            ExplicitTop = 18
          end
          object Sb_Next_end: TSpeedButton
            Left = 474
            Top = 16
            Width = 25
            Height = 25
            Hint = 'Pr'#243'ximo Endere'#231'o'
            Align = alRight
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
              33333FF3333333333333447333333333333377FFF33333333333744473333333
              333337773FF3333333333444447333333333373F773FF3333333334444447333
              33333373F3773FF3333333744444447333333337F333773FF333333444444444
              733333373F3333773FF333334444444444733FFF7FFFFFFF77FF999999999999
              999977777777777733773333CCCCCCCCCC3333337333333F7733333CCCCCCCCC
              33333337F3333F773333333CCCCCCC3333333337333F7733333333CCCCCC3333
              333333733F77333333333CCCCC333333333337FF7733333333333CCC33333333
              33333777333333333333CC333333333333337733333333333333}
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = Sb_Next_endClick
            ExplicitLeft = 472
            ExplicitHeight = 22
          end
          object Sb_Last_end: TSpeedButton
            Left = 524
            Top = 16
            Width = 25
            Height = 25
            Hint = #218'ltimo Endere'#231'o'
            Align = alRight
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333393333
              333333333337F3333333333333397333333333333337FF333333333333C94333
              3333333333737F333333333333C9473333333333337373F3333333333CC94433
              3333333337F7F7F3333333333CC94473333333333737F73F33333333CCC94443
              333333337F37F37F33333333CCC94447333333337337F373F333333CCCC94444
              33333337F337F337F333333CCCC94444733333373337F3373F3333CCCCC94444
              4333337F3337FF337F3333CCCCC94444473333733F7773FF73F33CCCCC393444
              443337F37737F773F7F33CCC33393374447337F73337F33737FFCCC333393333
              444377733337F333777FC3333339333337437333333733333373}
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = Sb_Last_endClick
            ExplicitLeft = 518
            ExplicitTop = 21
            ExplicitHeight = 22
          end
          object Sb_First_end: TSpeedButton
            Left = 449
            Top = 16
            Width = 25
            Height = 25
            Hint = 'Primeiro Endere'#231'o'
            Align = alRight
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003C3333339333
              337437FFF3337F3333F73CCC33339333344437773F337F33377733CCC3339337
              4447337F73FF7F3F337F33CCCCC3934444433373F7737F773373333CCCCC9444
              44733337F337773337F3333CCCCC9444443333373F337F3337333333CCCC9444
              473333337F337F337F333333CCCC94444333333373F37F33733333333CCC9444
              7333333337F37F37F33333333CCC944433333333373F7F373333333333CC9447
              33333333337F7F7F3333333333CC94433333333333737F7333333333333C9473
              33333333333737F333333333333C943333333333333737333333333333339733
              3333333333337F33333333333333933333333333333373333333}
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = Sb_First_endClick
            ExplicitLeft = 443
            ExplicitTop = 21
            ExplicitHeight = 22
          end
          object Sb_Prior_end: TSpeedButton
            Left = 499
            Top = 16
            Width = 25
            Height = 25
            Hint = 'Anterior Endere'#231'o'
            Align = alRight
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
              333333333333333333FF3333333333333744333333333333F773333333333337
              44473333333333F777F3333333333744444333333333F7733733333333374444
              4433333333F77333733333333744444447333333F7733337F333333744444444
              433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
              9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
              C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
              CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
              CCC333333333333777FF33333333333333CC3333333333333773}
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = Sb_Prior_endClick
            ExplicitLeft = 493
            ExplicitTop = 21
            ExplicitHeight = 22
          end
          object Sb_Exc_Ender: TSpeedButton
            Left = 549
            Top = 16
            Width = 25
            Height = 25
            Align = alRight
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              333333333333333333333333333333333333333FFF33FF333FFF339993370733
              999333777FF37FF377733339993000399933333777F777F77733333399970799
              93333333777F7377733333333999399933333333377737773333333333990993
              3333333333737F73333333333331013333333333333777FF3333333333910193
              333333333337773FF3333333399000993333333337377737FF33333399900099
              93333333773777377FF333399930003999333337773777F777FF339993370733
              9993337773337333777333333333333333333333333333333333333333333333
              3333333333333333333333333333333333333333333333333333}
            NumGlyphs = 2
            ParentFont = False
            OnClick = Sb_Exc_EnderClick
            ExplicitLeft = 548
            ExplicitTop = 17
            ExplicitHeight = 22
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Tributa'#231#227'o'
        ImageIndex = 6
        OnShow = TabSheet1Show
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Tributacao: TPanel
          Left = 0
          Top = 0
          Width = 424
          Height = 224
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            424
            224)
          object Label58: TLabel
            AlignWithMargins = True
            Left = 5
            Top = 76
            Width = 414
            Height = 14
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Indicador da Inscri'#231#227'o Estadual do Destinat'#225'rio'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 225
          end
          object Cb_Ind_IE_Dest: TComboBox
            AlignWithMargins = True
            Left = 5
            Top = 92
            Width = 414
            Height = 21
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = '1 - Contribuinte ICMS (informar a IE do destinat'#225'rio)'
            Items.Strings = (
              '1 - Contribuinte ICMS (informar a IE do destinat'#225'rio)'
              
                '2 - Contribuinte isento de Inscri'#231#227'o no cadastro de Contribuinte' +
                's do ICMS'
              
                '9 - N'#227'o Contribuinte, que pode ou n'#227'o possuir Inscri'#231#227'o Estadual' +
                ' no Cadastro de Contribuintes do ICMS')
          end
          object ChBx_Consumidor: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 3
            Width = 414
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Consumidor Final'
            TabOrder = 1
          end
          object ChBx_MicroEmpresa: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 22
            Width = 414
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Optante pelo Simples Nacional'
            TabOrder = 2
          end
          object Chbx_IgnoraST: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 41
            Width = 414
            Height = 33
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 
              'A marca'#231#227'o dos produtos Sujeitos '#224' Substitui'#231#227'o Tribut'#225'ria, ser'#225 +
              ' ignorada na emiss'#227'o da Nota'
            TabOrder = 3
            WordWrap = True
          end
          object ChBx_Ativa: TCheckBox
            Left = 321
            Top = 202
            Width = 97
            Height = 17
            Anchors = [akRight, akBottom]
            Caption = 'Empresa Ativa'
            TabOrder = 4
          end
        end
        object pnl_regra_tributacao: TPanel
          Left = 424
          Top = 0
          Width = 232
          Height = 224
          Align = alRight
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          DesignSize = (
            232
            224)
          object Lb_Tributacao_especifica: TLabel
            Left = 2
            Top = 2
            Width = 228
            Height = 23
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Regra de Tributa'#231#227'o Espec'#237'fica'
            Color = clNavy
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitLeft = -89
            ExplicitTop = 3
            ExplicitWidth = 274
          end
          object SB_Impostos: TSpeedButton
            Left = 118
            Top = 192
            Width = 108
            Height = 27
            Anchors = [akRight, akBottom]
            Caption = 'Impostos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            NumGlyphs = 4
            ParentFont = False
            OnClick = SB_ImpostosClick
            ExplicitLeft = 162
            ExplicitTop = 300
          end
          object DBG_Impostos: TDBGrid
            Left = 2
            Top = 25
            Width = 228
            Height = 163
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_Impostos
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'NAT_CFOP'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Title.Caption = 'C.F.O.P'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'UFE_SIGLA'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Title.Caption = 'UF'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 56
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TRB_CSOSN'
                Title.Caption = 'CSOSN'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Visible = True
              end>
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 463
    Width = 668
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      668
      65)
    object SB_Inserir: TSpeedButton
      Left = 110
      Top = 6
      Width = 91
      Height = 54
      Anchors = [akLeft, akBottom]
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
    end
    object SB_Alterar: TSpeedButton
      Left = 201
      Top = 6
      Width = 91
      Height = 54
      Anchors = [akLeft, akBottom]
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
    end
    object SB_Excluir: TSpeedButton
      Left = 292
      Top = 6
      Width = 93
      Height = 54
      Anchors = [akLeft, akBottom]
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
    end
    object SB_Gravar: TSpeedButton
      Left = 379
      Top = 6
      Width = 93
      Height = 54
      Anchors = [akLeft, akBottom]
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
      Left = 478
      Top = 6
      Width = 93
      Height = 54
      Anchors = [akLeft, akBottom]
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
      Left = 571
      Top = 6
      Width = 95
      Height = 54
      Anchors = [akLeft, akBottom]
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
  object Pnl_Cliente: TPanel
    Left = 0
    Top = 0
    Width = 668
    Height = 204
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label2: TLabel
      Left = 219
      Top = 5
      Width = 66
      Height = 14
      Caption = 'C.N.P.J / C.P.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 139
      Top = 5
      Width = 36
      Height = 14
      Caption = 'Pessoa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_IncEstadual: TLabel
      Left = 360
      Top = 5
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
    object Label5: TLabel
      Left = 61
      Top = 5
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
      Top = 49
      Width = 99
      Height = 14
      Caption = 'Nome / Raz'#227'o Social'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Fantasia: TLabel
      Left = 342
      Top = 49
      Width = 71
      Height = 14
      Caption = 'Nome Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 5
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 7
      Top = 125
      Width = 71
      Height = 14
      Caption = 'E-mail Principal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 339
      Top = 125
      Width = 99
      Height = 14
      Caption = 'Site na WEb (www)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Ramo: TLabel
      Left = 6
      Top = 87
      Width = 89
      Height = 14
      Caption = 'Ramo de Atividade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Data: TLabel
      Left = 567
      Top = 88
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
    object Lb_IncMunicipal: TLabel
      Left = 512
      Top = 5
      Width = 70
      Height = 14
      Caption = 'Insc. Municipal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_CNPJ: TSpeedButton
      Left = 334
      Top = 21
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_CNPJClick
    end
    object Sb_RamoAtividade: TSpeedButton
      Left = 540
      Top = 100
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_RamoAtividadeClick
    end
    object E_Nome: TEdit
      Left = 8
      Top = 63
      Width = 330
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnExit = E_NomeExit
    end
    object E_Fantasia: TEdit
      Left = 341
      Top = 63
      Width = 316
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object E_Insc_Est: TEdit
      Left = 363
      Top = 21
      Width = 148
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_Codigo: TEdit
      Left = 7
      Top = 20
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      Color = clMenu
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object CB_TpPessoa: TComboBox
      Left = 136
      Top = 20
      Width = 79
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'F'#205'SICA'
      OnExit = CB_TpPessoaExit
      Items.Strings = (
        'F'#205'SICA'
        'JUR'#205'DICA')
    end
    object E_Email: TEdit
      Left = 8
      Top = 139
      Width = 330
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object E_Site: TEdit
      Left = 341
      Top = 139
      Width = 316
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object E_Fundacao: TMaskEdit
      Left = 566
      Top = 101
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      EditMask = '##/##/####;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 9
      Text = '  /  /    '
      OnEnter = E_DataEnter
    end
    object E_Data: TDateTimePicker
      Left = 59
      Top = 20
      Width = 77
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_Insc_Mun: TEdit
      Left = 513
      Top = 21
      Width = 148
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object Dblcb_Ramo_Atividade: TDBLookupComboBox
      Left = 5
      Top = 101
      Width = 532
      Height = 21
      DataField = 'TB_RAMO_ATIVIDADE_ID'
      KeyField = 'ID'
      ListField = 'DESCRIPTION'
      ListSource = DM_ListaConsultas.Ds_ListaRamoAtividade
      TabOrder = 8
      OnKeyDown = Dblcb_Ramo_AtividadeKeyDown
    end
    object E_CpfCnpj: TMaskEdit
      Left = 221
      Top = 20
      Width = 114
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 3
      Text = ''
      OnExit = E_CpfCnpjExit
    end
    inline Fm_VendedorPedido: TFm_ListaColaboradores
      Left = 8
      Top = 161
      Width = 327
      Height = 36
      TabOrder = 12
      ExplicitLeft = 8
      ExplicitTop = 161
      ExplicitWidth = 327
      ExplicitHeight = 36
      inherited Label19: TLabel
        Width = 327
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 301
        Height = 19
        ExplicitLeft = 302
        ExplicitHeight = 19
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 298
        DataField = 'EMP_CODVDOR'
        ExplicitWidth = 298
      end
      inherited Qr_ListaVendedor: TSTQuery
        Transaction = DM.IB_Transacao
        UpdateTransaction = DM.IB_Transacao
      end
    end
  end
  object Menu: TMainMenu
    Left = 594
    Top = 265
    object Mnu_Tarefas: TMenuItem
      Caption = 'Tarefas'
      object ListasdeEmail1: TMenuItem
        Caption = 'Listas de Email'
        OnClick = ListasdeEmail1Click
      end
    end
  end
  object Qr_BuscaFone: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'select EMP_CODIGO, EMP_TIPO, EMP_NOME'
      'from tb_empresa'
      '    inner join tb_endereco'
      '    on (END_CODEMP = EMP_CODIGO)'
      
        'where (((tb_endereco.end_fone =:fone) and (tb_endereco.end_fone ' +
        'is not null) and (tb_endereco.end_fone <> '#39#39') )'
      
        '   or ((tb_endereco.end_fax  =:fone) and (tb_endereco.end_fax is' +
        ' not null)  and (tb_endereco.end_fax  <> '#39#39') )'
      
        '   or ((tb_endereco.end_celular =:fone) and (tb_endereco.end_cel' +
        'ular is not null)  and (tb_endereco.end_celular  <> '#39#39' ) )'
      
        '   or ((tb_endereco.END_PORTARIA  =:fone) and (tb_endereco.END_P' +
        'ORTARIA  is not null)  and (tb_endereco.END_PORTARIA   <> '#39#39' ) )'
      
        '   or ((tb_endereco.END_COMERCIAL  =:fone) and (tb_endereco.END_' +
        'COMERCIAL  is not null)  and (tb_endereco.END_COMERCIAL   <> '#39#39' ' +
        ') ))'
      'AND (EMP_CODIGO <>:EMP_CODIGO)')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 256
    Top = 96
    ParamData = <
      item
        Name = 'fone'
      end
      item
        Name = 'fone'
      end
      item
        Name = 'fone'
      end
      item
        Name = 'fone'
      end
      item
        Name = 'fone'
      end
      item
        Name = 'EMP_CODIGO'
      end>
  end
  object Qr_BuscaEmail: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'select EMP_CODIGO, EMP_TIPO, EMP_NOME'
      'from tb_empresa'
      'where tb_empresa.emp_email=:email'
      'AND (EMP_CODIGO <>:EMP_CODIGO)')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 328
    Top = 64
    ParamData = <
      item
        Name = 'email'
      end
      item
        Name = 'EMP_CODIGO'
      end>
  end
  object Qr_Contato: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT CTO_CODIGO, CTO_NOME, CTO_PRINCIPAL, CRG_DESCRICAO'
      'FROM TB_CONTATO tb_contato'
      '   LEFT OUTER JOIN TB_CARGO tb_cargo'
      '   ON (tb_cargo.CRG_CODIGO=tb_contato.CTO_CARGO)'
      'WHERE (CTO_CODEMP=:EMP_CODIGO)')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 461
    Top = 147
    ParamData = <
      item
        Name = 'EMP_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
  end
  object Ds_Contato: TDataSource
    DataSet = Qr_Contato
    Left = 461
    Top = 203
  end
  object Qr_Endereco: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
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
      '  END_PRINCIPAL,'
      
        '  tb_endereco.end_ender || '#39', '#39'|| tb_endereco.end_numero || '#39'  '#39 +
        ' || tb_endereco.end_complem  END_COMPLETO,'
      '  END_WHATSUP'
      'FROM TB_ENDERECO'
      '         INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)'
      'AND (END_PRINCIPAL <> '#39'I'#39')')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 541
    Top = 147
    ParamData = <
      item
        Name = 'EMP_CODIGO'
      end>
  end
  object Qr_Impostos: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    UpdateTransaction = DM.IBT_Consulta
    SQL.Strings = (
      
        ' SELECT TRB_CODIGO, NAT_CFOP, UFE_SIGLA, TRB_CONSUMIDOR,TRB_MICR' +
        'O, TRB_ORIGEM,  '
      
        ' ICMS_NR.TBI_GRUPO TRB_CST, ICMS_SN.TBI_GRUPO TRB_CSOSN, TRB_ST_' +
        'ICMS, TRB_AQ_ICMS, TRB_RD_AQ_ICMS,'
      ' TRB_RD_BS_ICMS,'
      ' OBS_DESCRICAO'
      ' FROM TB_TRIBUTACAO TRI'
      '   LEFT OUTER  JOIN TB_OBSERVACAO OBS'
      '   ON (OBS.OBS_CODIGO = TRI.TRB_CODOBS)'
      '   LEFT OUTER JOIN TB_UF UF'
      '   ON (UF.UFE_CODIGO = TRI.TRB_ESTADO)'
      '   LEFT OUTER JOIN TB_NATUREZA'
      '   ON (NAT_CODIGO = TRB_CODNAT)'
      ''
      '   LEFT OUTER JOIN TB_TRIB_ICMS_NR ICMS_NR'
      '  ON (ICMS_NR.TBI_CODIGO =TRB_CODTBI_ICMS_NR)'
      ''
      '   LEFT OUTER JOIN TB_TRIB_ICMS_SN ICMS_SN'
      '  ON (ICMS_SN.TBI_CODIGO =TRB_CODTBI_ICMS_SN)'
      ''
      ' WHERE (TRB_CODIGO IS NOT NULL)'
      ' and TRI.TRB_CODMHA = :TRB_CODMHA'
      ' and TRI.TRB_CODEMP = :TRB_CODEMP'
      'and TRI.TRB_CODEMP > 0')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 600
    Top = 144
    ParamData = <
      item
        Name = 'TRB_CODMHA'
      end
      item
        Name = 'TRB_CODEMP'
      end>
    object Qr_ImpostosTRB_CODIGO: TIntegerField
      FieldName = 'TRB_CODIGO'
      Origin = '"TB_TRIBUTACAO"."TRB_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ImpostosNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = '"TB_NATUREZA"."NAT_CFOP"'
      Size = 10
    end
    object Qr_ImpostosUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = '"TB_UF"."UFE_SIGLA"'
      FixedChar = True
      Size = 2
    end
    object Qr_ImpostosTRB_CONSUMIDOR: TStringField
      FieldName = 'TRB_CONSUMIDOR'
      Origin = '"TB_TRIBUTACAO"."TRB_CONSUMIDOR"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_MICRO: TStringField
      FieldName = 'TRB_MICRO'
      Origin = '"TB_TRIBUTACAO"."TRB_MICRO"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_ORIGEM: TStringField
      FieldName = 'TRB_ORIGEM'
      Origin = '"TB_TRIBUTACAO"."TRB_ORIGEM"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_CST: TStringField
      FieldName = 'TRB_CST'
      Origin = '"TB_TRIB_ICMS_NR"."TBI_GRUPO"'
      FixedChar = True
      Size = 2
    end
    object Qr_ImpostosTRB_CSOSN: TStringField
      FieldName = 'TRB_CSOSN'
      Origin = '"TB_TRIB_ICMS_SN"."TBI_GRUPO"'
      FixedChar = True
      Size = 3
    end
    object Qr_ImpostosTRB_ST_ICMS: TStringField
      FieldName = 'TRB_ST_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_ST_ICMS"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_AQ_ICMS: TBCDField
      FieldName = 'TRB_AQ_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ImpostosTRB_RD_AQ_ICMS: TBCDField
      FieldName = 'TRB_RD_AQ_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_RD_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ImpostosTRB_RD_BS_ICMS: TBCDField
      FieldName = 'TRB_RD_BS_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_RD_BS_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ImpostosOBS_DESCRICAO: TStringField
      FieldName = 'OBS_DESCRICAO'
      Origin = '"TB_OBSERVACAO"."OBS_DESCRICAO"'
      Size = 50
    end
  end
  object Ds_Impostos: TDataSource
    DataSet = Qr_Impostos
    Left = 600
    Top = 192
  end
end
