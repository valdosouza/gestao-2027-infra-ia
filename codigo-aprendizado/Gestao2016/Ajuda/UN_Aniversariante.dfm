object Fr_Aniversariantes: TFr_Aniversariantes
  Left = 205
  Top = 146
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Rela'#231#227'o de Aniversariantes'
  ClientHeight = 424
  ClientWidth = 793
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 793
    Height = 424
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      793
      424)
    object Label22: TLabel
      Left = 3
      Top = 64
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
      Left = 697
      Top = 311
      Width = 90
      Height = 54
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
    end
    object Sb_Sair_0: TSpeedButton
      Left = 697
      Top = 365
      Width = 90
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
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 789
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
      object Label27: TLabel
        Left = 8
        Top = 16
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 77
        Top = 16
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label29: TLabel
        Left = 147
        Top = 16
        Width = 77
        Height = 14
        Caption = 'Nome do Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaAniver: TEdit
        Left = 145
        Top = 32
        Width = 632
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object E_BuscaDataIni: TMaskEdit
        Left = 8
        Top = 32
        Width = 59
        Height = 22
        EditMask = '99/99;1;_'
        MaxLength = 5
        TabOrder = 0
        Text = '  /  '
      end
      object E_BuscaDataFim: TMaskEdit
        Left = 76
        Top = 32
        Width = 61
        Height = 22
        EditMask = '99/99;1;_'
        MaxLength = 5
        TabOrder = 1
        Text = '  /  '
      end
    end
    object ChBx_Dia: TCheckBox
      Left = 3
      Top = 401
      Width = 215
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'N'#227'o Mostrar esta tela Novamente  Hoje'
      TabOrder = 1
    end
    object DBGrid1: TDBGrid
      Left = -1
      Top = 78
      Width = 683
      Height = 317
      Anchors = [akTop, akBottom]
      Color = clCream
      DataSource = Ds_Pesquisa
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = DBGrid1TitleClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'EMP_ANIVER'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Anivers'#225'rio'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAZAO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Nome/Raz'#227'o Social'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 239
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FANTASIA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Nome Fantasia/Apelido'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 260
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CADASTRO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Cadastro'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 67
          Visible = True
        end>
    end
    object ChBx_Fisica: TCheckBox
      Left = 688
      Top = 78
      Width = 92
      Height = 17
      Caption = 'Pessoa F'#237'sica'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object ChBx_Juridica: TCheckBox
      Left = 688
      Top = 98
      Width = 97
      Height = 17
      Caption = 'Pessoa Jur'#237'dica'
      TabOrder = 4
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
      'SELECT'
      '    EMP_FANTASIA FANTASIA,'
      '    EMP_NOME RAZAO,'
      
        '    CAST (EXTRACT( MONTH FROM tb_empresa.EMP_DT_FUNDA)||'#39'/'#39'||  E' +
        'XTRACT( DAY FROM tb_empresa.EMP_DT_FUNDA  )||'#39'/1904'#39' AS DATE) EM' +
        'P_ANIVER,'
      '    EMP_DT_CADASTRO CADASTRO'
      'FROM TB_EMPRESA')
    Left = 213
    Top = 147
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 224
    Top = 280
  end
end
