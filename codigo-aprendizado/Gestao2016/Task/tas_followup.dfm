inherited TasFollowup: TTasFollowup
  Caption = 'Acompanhamento'
  ClientHeight = 557
  ClientWidth = 799
  ExplicitWidth = 805
  ExplicitHeight = 606
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 493
    Width = 799
    ExplicitTop = 493
    ExplicitWidth = 799
    inherited SB_Inserir: TSpeedButton
      Left = 172
      ExplicitLeft = 189
    end
    inherited SB_Alterar: TSpeedButton
      Left = 276
      ExplicitLeft = 276
    end
    inherited SB_Excluir: TSpeedButton
      Left = 380
      ExplicitLeft = 380
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 588
      ExplicitLeft = 588
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 692
      ExplicitLeft = 692
    end
    inherited SB_Gravar: TSpeedButton
      Left = 484
      ExplicitLeft = 495
    end
  end
  inherited pnl_fundo: TPanel
    Width = 799
    Height = 493
    ExplicitWidth = 799
    ExplicitHeight = 493
    object Pnl_Body: TPanel
      Left = 2
      Top = 2
      Width = 795
      Height = 300
      Align = alClient
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 793
        Height = 298
        Align = alClient
        DataSource = Ds_Pesquisa
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DT_FORECAST'
            Title.Caption = 'Data Prevista'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DT_DONE'
            Title.Caption = 'Data Realizada'
            Width = 99
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DETAIL'
            Title.Caption = 'Detalhe'
            Width = 515
            Visible = True
          end>
      end
    end
    object pnl_Botton: TPanel
      Left = 2
      Top = 302
      Width = 795
      Height = 189
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        795
        189)
      object Label36: TLabel
        Left = 6
        Top = 3
        Width = 99
        Height = 13
        Anchors = [akTop]
        AutoSize = False
        Caption = 'Data Prevista'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 46
        Width = 789
        Height = 13
        Margins.Bottom = 0
        Align = alBottom
        AutoSize = False
        Caption = 'Detalhes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitTop = 56
      end
      object Dtp_Prevista: TDateTimePicker
        Left = 5
        Top = 16
        Width = 100
        Height = 22
        Anchors = [akTop]
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 0
      end
      object Dtp_Conclusao: TDateTimePicker
        Left = 689
        Top = 25
        Width = 100
        Height = 22
        Anchors = [akTop]
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
        Visible = False
      end
      object E_Obs: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 62
        Width = 789
        Height = 124
        Align = alBottom
        Lines.Strings = (
          'Memo1')
        TabOrder = 2
      end
      object ChBx_Conclusao: TCheckBox
        Left = 689
        Top = 6
        Width = 100
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Etapa Conclu'#237'da'
        TabOrder = 3
        OnClick = ChBx_ConclusaoClick
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 616
    Top = 336
  end
  object Cds_Pesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 152
    object Cds_PesquisaTB_INSTITUTION_ID: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_FOLLOWUP"."TB_INSTITUTION_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_PesquisaTERMINAL: TIntegerField
      FieldName = 'TERMINAL'
      Origin = '"TB_FOLLOWUP"."TERMINAL"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_PesquisaTB_ORDER_ID: TIntegerField
      FieldName = 'TB_ORDER_ID'
      Origin = '"TB_FOLLOWUP"."TB_ORDER_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_PesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_FOLLOWUP"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_PesquisaPROCESS: TWideStringField
      FieldName = 'PROCESS'
      Origin = '"TB_FOLLOWUP"."PROCESS"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object Cds_PesquisaDT_RECORD: TDateTimeField
      FieldName = 'DT_RECORD'
      Origin = '"TB_FOLLOWUP"."DT_RECORD"'
    end
    object Cds_PesquisaDT_FORECAST: TDateField
      FieldName = 'DT_FORECAST'
      Origin = '"TB_FOLLOWUP"."DT_FORECAST"'
    end
    object Cds_PesquisaDETAIL: TBlobField
      FieldName = 'DETAIL'
      Origin = '"TB_FOLLOWUP"."DETAIL"'
      ProviderFlags = [pfInUpdate]
      OnGetText = Cds_PesquisaDETAILGetText
      Size = 8
    end
    object Cds_PesquisaDONE: TWideStringField
      FieldName = 'DONE'
      Origin = '"TB_FOLLOWUP"."DONE"'
      FixedChar = True
      Size = 1
    end
    object Cds_PesquisaDT_DONE: TStringField
      FieldName = 'DT_DONE'
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Cds_Pesquisa
    Left = 408
    Top = 208
  end
end
