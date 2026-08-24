inherited RegGroup: TRegGroup
  Caption = ' Cadastro de Grupo e SubGrupo do Card'#225'pio'
  ClientHeight = 336
  ClientWidth = 579
  ExplicitWidth = 585
  ExplicitHeight = 385
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 272
    Width = 579
    ExplicitTop = 272
    ExplicitWidth = 579
    inherited SB_Inserir: TSpeedButton
      Left = -1
      Width = 98
      ExplicitLeft = 15
      ExplicitTop = 5
      ExplicitWidth = 98
    end
    inherited SB_Alterar: TSpeedButton
      Left = 99
      Width = 96
      ExplicitLeft = 121
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Excluir: TSpeedButton
      Left = 197
      Width = 92
      ExplicitLeft = 213
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 377
      Width = 98
      ExplicitLeft = 391
      ExplicitTop = 5
      ExplicitWidth = 98
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 477
      Width = 97
      ExplicitLeft = 482
      ExplicitTop = 5
      ExplicitWidth = 97
    end
    inherited SB_Gravar: TSpeedButton
      Left = 291
      Width = 84
      ExplicitLeft = 293
      ExplicitTop = 5
      ExplicitWidth = 84
    end
  end
  inherited pnl_fundo: TPanel
    Width = 579
    Height = 71
    ExplicitWidth = 579
    ExplicitHeight = 71
    object Lb_Codigo: TLabel
      Left = 9
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
    object Lb_Descricao: TLabel
      Left = 72
      Top = 5
      Width = 100
      Height = 14
      Caption = 'Descri'#231#227'o do Grupo '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ChBx_Ativo: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 49
      Width = 569
      Height = 17
      Margins.Top = 1
      Align = alBottom
      Caption = 'Ativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Codigo: TEdit
      Left = 8
      Top = 21
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Descricao: TEdit
      Left = 76
      Top = 21
      Width = 485
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
  end
  object pnlGrid: TPanel [2]
    Left = 0
    Top = 71
    Width = 579
    Height = 201
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      579
      201)
    object Sb_SubGrupos: TSpeedButton
      Left = 468
      Top = 168
      Width = 106
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = 'Editar Subgrupos'
      OnClick = Sb_SubGruposClick
    end
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 569
      Height = 161
      Align = alTop
      Color = clMoneyGreen
      DataSource = ds_subgrupo
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'descricao_subgrupo'
          Title.Caption = 'Rela'#231#227'o de subgrupos cadastrados'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 495
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Ativo'
          Visible = True
        end>
    end
  end
  inherited MnuBase: TMainMenu
    Left = 512
    Top = 128
  end
  object cds_subgrupo: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    Left = 136
    Top = 122
    object cds_subgrupocodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_subgrupodescricao: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'descricao'
    end
    object cds_subgrupodescricao_subgrupo: TStringField
      DisplayLabel = 'SubGrupo'
      FieldName = 'descricao_subgrupo'
    end
    object cds_subgrupoAtivo: TStringField
      FieldName = 'Ativo'
      Size = 1
    end
  end
  object ds_subgrupo: TDataSource
    DataSet = cds_subgrupo
    Left = 136
    Top = 170
  end
end
