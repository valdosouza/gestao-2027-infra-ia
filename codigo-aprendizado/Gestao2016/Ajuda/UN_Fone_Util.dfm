object Fr_Fone_Util: TFr_Fone_Util
  Left = 444
  Top = 103
  Anchors = [akTop, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Telefones '#218'teis'
  ClientHeight = 491
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Tarefas
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 637
    Height = 491
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      637
      491)
    object SB_Inserir: TSpeedButton
      Left = 3
      Top = 431
      Width = 93
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 5
    end
    object SB_Alterar: TSpeedButton
      Left = 96
      Top = 431
      Width = 93
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 98
    end
    object SB_Excluir: TSpeedButton
      Left = 189
      Top = 431
      Width = 91
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 191
    end
    object SB_Gravar: TSpeedButton
      Left = 286
      Top = 432
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
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
      Left = 368
      Top = 431
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 370
    end
    object SB_Pesquisar: TSpeedButton
      Left = 456
      Top = 431
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Pesquisar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_PesquisarClick
      ExplicitLeft = 458
    end
    object Sb_Sair_0: TSpeedButton
      Left = 544
      Top = 431
      Width = 87
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
      ExplicitLeft = 546
    end
    object GroupBox1: TGroupBox
      Left = 4
      Top = 2
      Width = 631
      Height = 95
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label28: TLabel
        Left = 6
        Top = 48
        Width = 30
        Height = 14
        Caption = 'Nome '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SB_A: TSpeedButton
        Left = 4
        Top = 18
        Width = 23
        Height = 22
        Caption = 'A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_B: TSpeedButton
        Left = 28
        Top = 18
        Width = 23
        Height = 22
        Caption = 'B'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_C: TSpeedButton
        Left = 52
        Top = 18
        Width = 23
        Height = 22
        Caption = 'C'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_D: TSpeedButton
        Left = 76
        Top = 18
        Width = 23
        Height = 22
        Caption = 'D'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_E: TSpeedButton
        Left = 100
        Top = 18
        Width = 23
        Height = 22
        Caption = 'E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_F: TSpeedButton
        Left = 124
        Top = 18
        Width = 23
        Height = 22
        Caption = 'F'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_G: TSpeedButton
        Left = 148
        Top = 18
        Width = 23
        Height = 22
        Caption = 'G'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_H: TSpeedButton
        Left = 172
        Top = 18
        Width = 23
        Height = 22
        Caption = 'H'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_I: TSpeedButton
        Left = 196
        Top = 18
        Width = 23
        Height = 22
        Caption = 'I'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_J: TSpeedButton
        Left = 220
        Top = 18
        Width = 23
        Height = 22
        Caption = 'J'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_K: TSpeedButton
        Left = 244
        Top = 18
        Width = 23
        Height = 22
        Caption = 'K'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_L: TSpeedButton
        Left = 268
        Top = 18
        Width = 23
        Height = 22
        Caption = 'L'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_M: TSpeedButton
        Left = 292
        Top = 18
        Width = 23
        Height = 22
        Caption = 'M'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_N: TSpeedButton
        Left = 316
        Top = 18
        Width = 23
        Height = 22
        Caption = 'N'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_O: TSpeedButton
        Left = 340
        Top = 18
        Width = 23
        Height = 22
        Caption = 'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_P: TSpeedButton
        Left = 364
        Top = 18
        Width = 23
        Height = 22
        Caption = 'P'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_Q: TSpeedButton
        Left = 388
        Top = 18
        Width = 23
        Height = 22
        Caption = 'Q'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_R: TSpeedButton
        Left = 412
        Top = 18
        Width = 23
        Height = 22
        Caption = 'R'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_S: TSpeedButton
        Left = 436
        Top = 18
        Width = 23
        Height = 22
        Caption = 'S'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_T: TSpeedButton
        Left = 460
        Top = 18
        Width = 23
        Height = 22
        Caption = 'T'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_U: TSpeedButton
        Left = 484
        Top = 18
        Width = 23
        Height = 22
        Caption = 'U'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_V: TSpeedButton
        Left = 508
        Top = 18
        Width = 23
        Height = 22
        Caption = 'V'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_Z: TSpeedButton
        Left = 603
        Top = 18
        Width = 23
        Height = 22
        Caption = 'Z'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_Y: TSpeedButton
        Left = 556
        Top = 18
        Width = 23
        Height = 22
        Caption = 'Y'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object SB_X: TSpeedButton
        Left = 532
        Top = 18
        Width = 23
        Height = 22
        Caption = 'X'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object Sb_W: TSpeedButton
        Left = 580
        Top = 18
        Width = 23
        Height = 22
        Caption = 'W'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SB_AClick
      end
      object Label3: TLabel
        Left = 333
        Top = 48
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaContato: TEdit
        Left = 3
        Top = 64
        Width = 326
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 98
        ParentFont = False
        TabOrder = 0
        OnChange = E_BuscaContatoChange
      end
      object E_BuscaEmpresa: TEdit
        Left = 330
        Top = 64
        Width = 296
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 98
        ParentFont = False
        TabOrder = 1
        OnChange = E_BuscaContatoChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 4
      Top = 369
      Width = 629
      Height = 57
      Caption = 'Preencha os campos para Cadastro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label2: TLabel
        Left = 6
        Top = 13
        Width = 30
        Height = 14
        Caption = 'Nome '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 513
        Top = 13
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
      object Label1: TLabel
        Left = 366
        Top = 13
        Width = 20
        Height = 14
        Caption = 'Tipo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Numero: TEdit_Setes
        Left = 510
        Top = 28
        Width = 113
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
        IsFone = True
      end
      object Cb_Tipo: TComboBox
        Left = 364
        Top = 28
        Width = 144
        Height = 22
        Style = csDropDownList
        TabOrder = 1
        Items.Strings = (
          'RESIDENCIAL'
          'COMERCIAL'
          'FAX'
          'CELULAR'
          'PORTARIA'
          'ADMINISTRATIVO'
          '')
      end
      object E_Contato: TEdit
        Left = 4
        Top = 28
        Width = 358
        Height = 22
        TabOrder = 0
      end
    end
    object DBGrid1: TDBGrid
      Left = 7
      Top = 94
      Width = 628
      Height = 269
      DataSource = Ds_pesquisa
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CONTACT'
          Title.Caption = 'Contato'
          Width = 275
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KIND'
          Title.Caption = 'Tipo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FONE'
          Title.Caption = 'N'#250'mero'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_FANTASIA'
          Title.Caption = 'Apelido/Fantasia'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_NOME'
          Title.Caption = 'Nome/Raz'#227'o'
          Visible = True
        end>
    end
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    OnCalcFields = Qr_PesquisaCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT f.*, emp_nome, emp_fantasia '
      'FROM Tb_PHONE f '
      '  left outer join tb_empresa '
      '  on (emp_codigo = id)'
      'where  ( ID IS NOT NULL ) ')
    Left = 221
    Top = 163
    object Qr_PesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_PHONE"."ID"'
      Required = True
    end
    object Qr_PesquisaKIND: TStringField
      FieldName = 'KIND'
      Origin = '"TB_PHONE"."KIND"'
      Required = True
    end
    object Qr_PesquisaCONTACT: TStringField
      FieldName = 'CONTACT'
      Origin = '"TB_PHONE"."CONTACT"'
      Size = 100
    end
    object Qr_PesquisaNUMBER: TStringField
      FieldName = 'NUMBER'
      Origin = '"TB_PHONE"."NUMBER"'
    end
    object Qr_PesquisaADDRESS_KIND: TStringField
      FieldName = 'ADDRESS_KIND'
      Origin = '"TB_PHONE"."ADDRESS_KIND"'
    end
    object Qr_PesquisaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_PesquisaEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object Qr_PesquisaFONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'FONE'
      Calculated = True
    end
  end
  object Ds_pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 221
    Top = 219
  end
  object Mnu_Tarefas: TMainMenu
    Left = 424
    Top = 144
    object arefas1: TMenuItem
      Caption = 'Tarefas'
      object SincronizarcomCadastros1: TMenuItem
        Caption = 'Sincronizar com Cadastros '
        OnClick = SincronizarcomCadastros1Click
      end
    end
  end
end
