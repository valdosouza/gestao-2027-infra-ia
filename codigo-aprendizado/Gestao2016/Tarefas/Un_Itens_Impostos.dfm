inherited Fr_Itens_Impostos: TFr_Itens_Impostos
  Caption = 'Fr_Itens_Impostos'
  ClientHeight = 543
  ClientWidth = 773
  ExplicitWidth = 779
  ExplicitHeight = 591
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 479
    Width = 773
    ExplicitTop = 478
    ExplicitWidth = 773
    inherited SB_Inserir: TSpeedButton
      OnClick = nil
    end
    inherited SB_Alterar: TSpeedButton
      OnClick = nil
    end
    inherited SB_Excluir: TSpeedButton
      OnClick = nil
    end
    inherited SB_Cancelar: TSpeedButton
      OnClick = nil
    end
    inherited SB_Sair_0: TSpeedButton
      OnClick = nil
    end
    inherited SB_Gravar: TSpeedButton
      OnClick = nil
    end
  end
  inherited pnl_fundo: TPanel
    Width = 773
    Height = 479
    ExplicitTop = 513
    ExplicitWidth = 773
    ExplicitHeight = 478
    object Label5: TLabel
      Left = 302
      Top = 160
      Width = 66
      Height = 14
      Caption = 'Aliquota ICMS'
      FocusControl = E_Aq_ICMS
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 485
      Top = 160
      Width = 103
      Height = 14
      Caption = 'Redu'#231#227'o da Base em'
      FocusControl = E_Red_Base
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 376
      Top = 160
      Width = 92
      Height = 14
      Caption = 'Red na Aliquota em'
      FocusControl = E_Red_Aliq
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 5
      Top = 44
      Width = 206
      Height = 13
      Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria Normal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 300
      Top = 120
      Width = 213
      Height = 13
      Caption = 'Determina'#231#227'o da Base de C'#225'lculo - ICMS ST'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 8
      Top = 120
      Width = 196
      Height = 13
      Caption = 'Determina'#231#227'o da Base de C'#225'lculo - ICMS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 8
      Top = 160
      Width = 117
      Height = 13
      Caption = 'Motivo da Desonera'#231#227'o '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 6
      Top = 83
      Width = 288
      Height = 13
      Caption = 'CSOSN - C'#243'digo de Situa'#231#227'o da Opera'#231#227'o Simples Nacional'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Sit_Trib_ICMS: TSpeedButton
      Left = 575
      Top = 59
      Width = 23
      Height = 22
      Caption = '...'
    end
    object Sb_Sit_Trib_CSOSN: TSpeedButton
      Left = 575
      Top = 96
      Width = 23
      Height = 22
      Caption = '...'
    end
    object Sb_Modal_ICMS: TSpeedButton
      Left = 274
      Top = 135
      Width = 23
      Height = 22
      Caption = '...'
    end
    object Sb_Desoneracao: TSpeedButton
      Left = 274
      Top = 175
      Width = 23
      Height = 22
      Caption = '...'
    end
    object Sb_Modal_ICMS_St: TSpeedButton
      Left = 575
      Top = 135
      Width = 23
      Height = 22
      Caption = '...'
    end
    object Label28: TLabel
      Left = 8
      Top = 3
      Width = 106
      Height = 14
      Caption = 'Origem da Mercadoria'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 10
      Top = 334
      Width = 177
      Height = 14
      Anchors = [akLeft, akBottom]
      Caption = 'C.F.O.P. - Descri'#231#227'o Situa'#231#227'o Normal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SB_Natureza: TSpeedButton
      Left = 576
      Top = 349
      Width = 24
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Aq_ICMS: TEdit_Setes
      Left = 302
      Top = 176
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object E_Red_Base: TEdit_Setes
      Left = 483
      Top = 176
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
    object E_Red_Aliq: TEdit_Setes
      Left = 373
      Top = 176
      Width = 108
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object Dblcb_Situacao_tributaria: TDBLookupComboBox
      Left = 5
      Top = 60
      Width = 566
      Height = 21
      DataField = 'TRB_CODTBI_ICMS_NR'
      KeyField = 'TBI_CODIGO'
      ListField = 'DESCRICAO'
      TabOrder = 3
    end
    object Dblcb_Modal_ICMS_ST: TDBLookupComboBox
      Left = 300
      Top = 136
      Width = 271
      Height = 21
      DataField = 'TRB_CODMDB_ICMS_ST'
      KeyField = 'MDB_CODIGO'
      ListField = 'DESCRICAO'
      TabOrder = 4
    end
    object Dblcb_Modal_ICMS: TDBLookupComboBox
      Left = 8
      Top = 136
      Width = 266
      Height = 21
      DataField = 'TRB_CODMDB_ICMS_NR'
      KeyField = 'MDB_CODIGO'
      ListField = 'DESCRICAO'
      TabOrder = 5
    end
    object Dblcb_Desoneracao: TDBLookupComboBox
      Left = 8
      Top = 176
      Width = 266
      Height = 21
      DataField = 'TRB_CODDSI_ICMS'
      KeyField = 'DSI_CODIGO'
      ListField = 'DSI_DESCRICAO'
      TabOrder = 6
    end
    object Dblcb_Simples_Nacional: TDBLookupComboBox
      Left = 6
      Top = 98
      Width = 562
      Height = 21
      DataField = 'TRB_CODTBI_ICMS_SN'
      KeyField = 'TBI_CODIGO'
      ListField = 'DESCRICAO'
      TabOrder = 7
    end
    object Cb_Origem: TComboBox
      Left = 5
      Top = 18
      Width = 594
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Items.Strings = (
        '0 - Nacional, exceto as indicadas nos c'#243'digos 3, 4, 5 e 8;'
        
          '1 - Estrangeira - Importa'#231#227'o direta, exceto a indicada no c'#243'digo' +
          ' 6;'
        
          '2 - Estrangeira - Adquirida no mercado interno, exceto a indicad' +
          'a no c'#243'digo 7;'
        
          '3 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o super' +
          'ior a 40% e inferior ou igual a 70%;'
        
          '4 - Nacional, cuja prod. tenha sido feita em conf. os proc. prod' +
          'utivos b'#225'sicos conf as legisla'#231#245'es citadas nos Ajustes;'
        
          '5 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o infer' +
          'ior ou igual a 40%;'
        
          '6 - Estrangeira - Importa'#231#227'o direta, sem similar nacional,consta' +
          'nte em lista da CAMEX e g'#225's natural;'
        
          '7 - Estrangeira - Adquirida no mercado interno, sem similar naci' +
          'onal, constante lista CAMEX e g'#225's natural.'
        
          '8 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o super' +
          'ior a 70%;')
    end
    object PageControl1: TPageControl
      Left = 8
      Top = 249
      Width = 592
      Height = 82
      ActivePage = tbs_ipi
      TabOrder = 9
      object tbs_ipi: TTabSheet
        Caption = 'IPI'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 584
          Height = 54
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label8: TLabel
            Left = 479
            Top = 6
            Width = 67
            Height = 14
            Caption = 'Aliquota de IPI'
            FocusControl = E_Aq_IPI
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 5
            Top = 6
            Width = 170
            Height = 13
            Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Sit_Trib_IPI: TSpeedButton
            Left = 451
            Top = 22
            Width = 23
            Height = 22
            Caption = '...'
          end
          object E_Aq_IPI: TEdit_Setes
            Left = 477
            Top = 22
            Width = 100
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = ''
          end
          object Dblcb_Situacao_tributaria_IPI: TDBLookupComboBox
            Left = 5
            Top = 22
            Width = 443
            Height = 21
            DataField = 'TRB_CODTBI_IPI'
            KeyField = 'TBI_CODIGO'
            ListField = 'DESCRICAO'
            TabOrder = 0
          end
        end
      end
      object tbs_pis: TTabSheet
        Caption = 'PIS'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 584
          Height = 54
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label10: TLabel
            Left = 479
            Top = 6
            Width = 57
            Height = 14
            Caption = 'Aliquota PIS'
            FocusControl = E_Aq_Pis
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 5
            Top = 6
            Width = 170
            Height = 13
            Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Sit_Trib_PIS: TSpeedButton
            Left = 451
            Top = 22
            Width = 23
            Height = 22
            Caption = '...'
          end
          object E_Aq_Pis: TEdit_Setes
            Left = 477
            Top = 22
            Width = 100
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = ''
          end
          object Dblcb_Situacao_tributaria_PIS: TDBLookupComboBox
            Left = 5
            Top = 22
            Width = 443
            Height = 21
            DataField = 'TRB_CODTBI_PIS'
            KeyField = 'TBP_CODIGO'
            ListField = 'DESCRICAO'
            ListSource = DM.ds_trib_pis
            TabOrder = 0
          end
        end
      end
      object tbs_cofins: TTabSheet
        Caption = 'COFINS'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 584
          Height = 54
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label13: TLabel
            Left = 480
            Top = 6
            Width = 73
            Height = 14
            Caption = 'Aliquota Cofins'
            FocusControl = E_Aq_Cofins
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 5
            Top = 6
            Width = 170
            Height = 13
            Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Sit_Trib_CFS: TSpeedButton
            Left = 451
            Top = 22
            Width = 23
            Height = 22
            Caption = '...'
          end
          object E_Aq_Cofins: TEdit_Setes
            Left = 477
            Top = 22
            Width = 100
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = ''
          end
          object Dblcb_Situacao_tributaria_CFS: TDBLookupComboBox
            Left = 5
            Top = 22
            Width = 443
            Height = 21
            DataField = 'TRB_CODTBI_CFS'
            KeyField = 'TBC_CODIGO'
            ListField = 'DESCRICAO'
            TabOrder = 0
          end
        end
      end
      object tbs_outros: TTabSheet
        Caption = 'Outros'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 584
          Height = 54
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label12: TLabel
            Left = 9
            Top = 6
            Width = 41
            Height = 14
            Caption = 'Al'#237'q IRPJ'
            FocusControl = E_Aq_IRPJ
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 82
            Top = 6
            Width = 47
            Height = 14
            Caption = 'Al'#237'q CSLL'
            FocusControl = E_Aq_CSLL
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 154
            Top = 6
            Width = 89
            Height = 14
            Caption = 'Al'#237'quota Siscomex'
            FocusControl = E_Aq_Siscomex
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 261
            Top = 6
            Width = 31
            Height = 14
            Caption = 'Aliq I.I.'
            FocusControl = E_Aq_Tec
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 345
            Top = 6
            Width = 25
            Height = 14
            Caption = 'I.S.S.'
            FocusControl = E_Aq_ISS
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 424
            Top = 6
            Width = 89
            Height = 14
            Caption = 'Aliquota A.F.R.M.M'
            FocusControl = E_AQ_AFRMM
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Aq_IRPJ: TEdit_Setes
            Left = 7
            Top = 22
            Width = 72
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = ''
          end
          object E_Aq_CSLL: TEdit_Setes
            Left = 80
            Top = 22
            Width = 71
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = ''
          end
          object E_Aq_Siscomex: TEdit_Setes
            Left = 152
            Top = 22
            Width = 103
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = ''
          end
          object E_Aq_Tec: TEdit_Setes
            Left = 256
            Top = 22
            Width = 81
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object E_Aq_ISS: TEdit_Setes
            Left = 340
            Top = 22
            Width = 81
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Text = ''
          end
          object E_AQ_AFRMM: TEdit_Setes
            Left = 422
            Top = 22
            Width = 103
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
        end
      end
    end
    object DBLCB_Natureza: TDBLookupComboBox
      Left = 10
      Top = 350
      Width = 563
      Height = 21
      Anchors = [akLeft, akBottom]
      DataField = 'TRB_CODNAT'
      KeyField = 'NAT_CODIGO'
      ListField = 'CFOP'
      TabOrder = 10
    end
  end
  inherited MnuBase: TMainMenu
    Left = 288
    Top = 16
  end
end
