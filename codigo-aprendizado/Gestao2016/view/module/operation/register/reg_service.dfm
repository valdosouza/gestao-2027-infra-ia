inherited RegService: TRegService
  Caption = 'Cadastro de Servi'#231'os'
  ClientHeight = 358
  ClientWidth = 606
  ExplicitWidth = 612
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 294
    Width = 606
    ExplicitTop = 294
    ExplicitWidth = 606
    inherited SB_Inserir: TSpeedButton
      Left = 3
      ExplicitLeft = -21
    end
    inherited SB_Alterar: TSpeedButton
      Left = 107
      Width = 96
      ExplicitLeft = 101
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Excluir: TSpeedButton
      Left = 205
      Width = 96
      ExplicitLeft = 199
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 401
      Width = 96
      ExplicitLeft = 395
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 499
      ExplicitLeft = 499
    end
    inherited SB_Gravar: TSpeedButton
      Left = 303
      Width = 96
      ExplicitLeft = 297
      ExplicitTop = 5
      ExplicitWidth = 96
    end
  end
  inherited pnl_fundo: TPanel
    Width = 606
    Height = 294
    ExplicitWidth = 606
    ExplicitHeight = 294
    object L_Aq_Comissao: TLabel
      Left = 144
      Top = 84
      Width = 68
      Height = 14
      Caption = 'Aliq.Comiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Aq_Margem: TLabel
      Left = 325
      Top = 84
      Width = 85
      Height = 16
      AutoSize = False
      Caption = 'Margem de Lucro'
      FocusControl = E_Aq_Margem
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Codigo: TLabel
      Left = 9
      Top = 6
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
    object L_Descricao: TLabel
      Left = 116
      Top = 7
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
    object L_Medida: TLabel
      Left = 8
      Top = 85
      Width = 39
      Height = 14
      Caption = 'Unidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_PrecoCusto: TLabel
      Left = 234
      Top = 84
      Width = 73
      Height = 14
      Caption = 'Pre'#231'o de custo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Vl_Venda: TLabel
      Left = 417
      Top = 84
      Width = 86
      Height = 14
      Caption = 'Pre'#231'o de Venda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SB_Grupos: TSpeedButton
      Left = 567
      Top = 58
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_GruposClick
    end
    object Sb_Medida: TSpeedButton
      Left = 115
      Top = 99
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_MedidaClick
    end
    object L_Grupo: TLabel
      Left = 7
      Top = 43
      Width = 30
      Height = 14
      Caption = 'Grupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_SubGrupo: TLabel
      Left = 310
      Top = 44
      Width = 47
      Height = 14
      Caption = 'Subgrupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ChBx_ativo: TCheckBox
      Left = 2
      Top = 271
      Width = 602
      Height = 21
      Align = alBottom
      Caption = 'Este Servi'#231'o encontra-se ativo para qualquer transa'#231#227'o'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 10
    end
    object e_aq_comissao: TEdit_Setes
      Left = 144
      Top = 99
      Width = 88
      Height = 22
      Alignment = taRightJustify
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
    object E_Aq_Margem: TEdit_Setes
      Left = 324
      Top = 99
      Width = 90
      Height = 22
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    object E_Codigo: TEdit
      Left = 7
      Top = 20
      Width = 105
      Height = 22
      TabStop = False
      Color = clMenu
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object E_Descricao: TEdit
      Left = 116
      Top = 21
      Width = 476
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
    object E_PrecoCusto: TEdit_Setes
      Left = 234
      Top = 99
      Width = 88
      Height = 22
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = ''
    end
    object E_Vl_Venda: TEdit_Setes
      Left = 416
      Top = 99
      Width = 87
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = ''
    end
    object PageControl1: TPageControl
      Left = 2
      Top = 127
      Width = 602
      Height = 144
      ActivePage = tbs_Internet
      Align = alBottom
      TabOrder = 9
      object TabSheet1: TTabSheet
        Caption = 'Observa'#231#227'o'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object ME_Observ: TMemo
          Left = 0
          Top = 0
          Width = 594
          Height = 116
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object tbs_Internet: TTabSheet
        Caption = 'Internet'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 594
          Height = 116
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            594
            116)
          object L_Cadastro: TLabel
            Left = 5
            Top = 3
            Width = 217
            Height = 14
            Caption = 'Nome da Categoria na Internet - Vers'#227'o 2013'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Category: TSpeedButton
            Left = 351
            Top = 87
            Width = 91
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Editar Categorias'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            OnClick = Sb_CategoryClick
            ExplicitTop = 70
          end
          object Trw_Cadastro: TTreeView
            Left = 3
            Top = 16
            Width = 343
            Height = 95
            Anchors = [akLeft, akTop, akBottom]
            AutoExpand = True
            HideSelection = False
            Indent = 19
            MultiSelectStyle = []
            ReadOnly = True
            SortType = stText
            TabOrder = 0
          end
        end
      end
    end
    object DBLCB_Grupo: TDBLookupComboBox
      Left = 6
      Top = 57
      Width = 298
      Height = 22
      DataField = 'PRO_CODGRP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'GRP_CODIGO'
      ListField = 'GRP_DESCRICAO'
      ListSource = DM.Ds_Grupo
      ParentFont = False
      TabOrder = 2
    end
    object DBLCB_SubGrupo: TDBLookupComboBox
      Left = 308
      Top = 56
      Width = 253
      Height = 22
      DataField = 'PRO_CODSBG'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'SBG_CODIGO'
      ListField = 'SBG_DESCRICAO'
      ListSource = DM.Ds_SubGrupo
      ParentFont = False
      TabOrder = 3
    end
    object DBLCB_Medida: TDBLookupComboBox
      Left = 8
      Top = 99
      Width = 106
      Height = 22
      DataField = 'PRO_CODMED'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'MED_CODIGO'
      ListField = 'MED_ABREVIATURA'
      ListSource = DM_ListaConsultas.Ds_ListaMedida
      ParentFont = False
      TabOrder = 4
    end
  end
  object memCategory: TClientDataSet
    Left = 136
    Top = 176
    object memCategorycodigo: TIntegerField
      FieldName = 'codigo'
    end
    object memCategorydescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
    object memCategoryposicao: TStringField
      FieldName = 'posicao'
      Size = 40
    end
  end
end
