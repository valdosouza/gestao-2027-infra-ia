inherited TasFurnitureOS: TTasFurnitureOS
  Caption = 'Ordem de Servi'#231'o  - Moveleiro'
  ClientHeight = 660
  ClientWidth = 917
  ExplicitWidth = 923
  ExplicitHeight = 709
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 596
    Width = 917
    ExplicitTop = 596
    ExplicitWidth = 917
    inherited SB_Inserir: TSpeedButton
      ExplicitLeft = 297
    end
    inherited SB_Alterar: TSpeedButton
      ExplicitLeft = 393
    end
    inherited SB_Excluir: TSpeedButton
      ExplicitLeft = 501
    end
    inherited SB_Cancelar: TSpeedButton
      ExplicitLeft = 705
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 810
      ExplicitLeft = 809
    end
    inherited SB_Gravar: TSpeedButton
      ExplicitLeft = 597
    end
    object Sb_Imprimir: TSpeedButton
      Left = 707
      Top = 2
      Width = 102
      Height = 60
      Align = alRight
      Caption = 'Imprimir - F11'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ImprimirClick
      ExplicitLeft = 710
      ExplicitTop = 4
    end
  end
  inherited pnl_fundo: TPanel
    Width = 917
    Height = 596
    ExplicitWidth = 917
    ExplicitHeight = 596
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 94
      Height = 13
      Caption = 'M'#243'vel/Equipamento'
    end
    object Label2: TLabel
      Left = 11
      Top = 49
      Width = 29
      Height = 13
      Caption = 'Marca'
    end
    object Label3: TLabel
      Left = 341
      Top = 49
      Width = 34
      Height = 13
      Caption = 'Modelo'
    end
    object Label32: TLabel
      Left = 6
      Top = 92
      Width = 79
      Height = 14
      Caption = 'Defeito Relatado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label33: TLabel
      Left = 460
      Top = 89
      Width = 199
      Height = 14
      Caption = 'Defeito Constatado/Solu'#231#227'o Apresentada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 6
      Top = 178
      Width = 156
      Height = 14
      Caption = 'Servi'#231'o executado efetivamente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 461
      Top = 178
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
    object Label9: TLabel
      Left = 717
      Top = 306
      Width = 84
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = 'Data Atendimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label13: TLabel
      Left = 818
      Top = 305
      Width = 85
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = 'Hora Atendimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 341
      Top = 5
      Width = 45
      Height = 13
      Caption = 'Ambiente'
    end
    object Pg_Principal: TPageControl
      Left = 2
      Top = 328
      Width = 913
      Height = 266
      ActivePage = tbs_anotacao
      Align = alBottom
      TabOrder = 12
      object tbs_anotacao: TTabSheet
        Caption = 'Anota'#231#245'es'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Dbg_ListAnnotation: TDBGrid
          Left = 512
          Top = 0
          Width = 393
          Height = 238
          Align = alRight
          Color = clCream
          DataSource = Ds_Anotacao
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = Dbg_ListAnnotationDblClick
          Columns = <
            item
              Expanded = False
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'DT_RECORD'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Title.Caption = 'Data'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 88
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'REFERENCE'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Title.Caption = 'Refer'#234'ncia'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 291
              Visible = True
            end>
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 512
          Height = 238
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Pnl_Botao_Annotation: TPanel
            Left = 2
            Top = 188
            Width = 508
            Height = 48
            Align = alBottom
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Sb_Alt_Anotacao: TSpeedButton
              AlignWithMargins = True
              Left = 97
              Top = 5
              Width = 92
              Height = 38
              Margins.Left = 1
              Margins.Right = 1
              Align = alLeft
              Caption = 'Alterar'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial Narrow'
              Font.Style = []
              ParentFont = False
              OnClick = Sb_Alt_AnotacaoClick
              ExplicitLeft = 95
            end
            object Sb_Exc_Anotacao: TSpeedButton
              AlignWithMargins = True
              Left = 191
              Top = 5
              Width = 92
              Height = 38
              Margins.Left = 1
              Margins.Right = 1
              Align = alLeft
              Caption = 'Excluir'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial Narrow'
              Font.Style = []
              ParentFont = False
              OnClick = Sb_Exc_AnotacaoClick
              ExplicitLeft = 187
            end
            object Sb_Ins_Anotacao: TSpeedButton
              AlignWithMargins = True
              Left = 3
              Top = 5
              Width = 92
              Height = 38
              Margins.Left = 1
              Margins.Right = 1
              Align = alLeft
              Caption = 'Inserir'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial Narrow'
              Font.Style = []
              ParentFont = False
              OnClick = Sb_Ins_AnotacaoClick
            end
            object Sb_Grv_Anotacao: TSpeedButton
              AlignWithMargins = True
              Left = 285
              Top = 5
              Width = 92
              Height = 38
              Margins.Left = 1
              Margins.Right = 1
              Align = alLeft
              Caption = 'Gravar'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial Narrow'
              Font.Style = []
              ParentFont = False
              OnClick = Sb_Grv_AnotacaoClick
              ExplicitLeft = 279
            end
            object Sb_Can_Anotacao: TSpeedButton
              AlignWithMargins = True
              Left = 379
              Top = 5
              Width = 92
              Height = 38
              Margins.Left = 1
              Margins.Right = 1
              Align = alLeft
              Caption = 'Cancelar'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial Narrow'
              Font.Style = []
              ParentFont = False
              OnClick = Sb_Can_AnotacaoClick
              ExplicitLeft = 371
            end
          end
          object Pnl_Annotation: TPanel
            Left = 2
            Top = 2
            Width = 508
            Height = 186
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 1
            object Label10: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 3
              Width = 53
              Height = 14
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alTop
              Caption = 'Refer'#234'ncia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label11: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 43
              Width = 498
              Height = 12
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alTop
              AutoSize = False
              Caption = 'Anota'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 9
              ExplicitTop = 39
              ExplicitWidth = 60
            end
            object E_Ann_Reference: TEdit
              AlignWithMargins = True
              Left = 5
              Top = 19
              Width = 498
              Height = 22
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alTop
              CharCase = ecUpperCase
              Ctl3D = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
            end
            object E_Ann_Obs: TMemo
              AlignWithMargins = True
              Left = 5
              Top = 57
              Width = 498
              Height = 126
              Margins.Top = 1
              Margins.Bottom = 1
              Align = alClient
              TabOrder = 1
            end
          end
        end
      end
    end
    object CB_Equipment: TComboBox
      Left = 6
      Top = 22
      Width = 331
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object CB_Brand: TComboBox
      Left = 8
      Top = 65
      Width = 329
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object CB_Model: TComboBox
      Left = 341
      Top = 65
      Width = 333
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object MM_Relatado: TMemo
      Left = 6
      Top = 106
      Width = 450
      Height = 70
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object MM_Constatado: TMemo
      Left = 459
      Top = 106
      Width = 450
      Height = 70
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object MM_Executado: TMemo
      Left = 6
      Top = 194
      Width = 450
      Height = 70
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object MM_Note: TMemo
      Left = 461
      Top = 194
      Width = 450
      Height = 70
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    inline Fm_ListaSituacao: TFm_ListaSituacao
      Left = 7
      Top = 265
      Width = 448
      Height = 38
      TabOrder = 8
      ExplicitLeft = 7
      ExplicitTop = 265
      ExplicitWidth = 448
      ExplicitHeight = 38
      inherited Label14: TLabel
        Width = 448
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 422
        Height = 21
        ExplicitLeft = 423
        ExplicitHeight = 21
      end
      inherited DBLCB_Situacao: TDBLookupComboBox
        Width = 419
        OnExit = Fm_ListaSituacaoDBLCB_SituacaoExit
        ExplicitWidth = 419
      end
    end
    object E_Dt_Attendance: TMaskEdit
      Left = 717
      Top = 321
      Width = 93
      Height = 21
      Alignment = taCenter
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 10
      Text = '  /  /    '
    end
    inline Fm_ListaTecnico: TFm_ListaColaboradores
      Left = 462
      Top = 266
      Width = 449
      Height = 37
      TabOrder = 9
      ExplicitLeft = 462
      ExplicitTop = 266
      ExplicitWidth = 449
      ExplicitHeight = 37
      inherited Label19: TLabel
        Width = 449
        Caption = 'Nome do T'#233'cnico'
        ExplicitWidth = 83
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 423
        Height = 20
        ExplicitLeft = 188
        ExplicitHeight = 46
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 417
        ExplicitWidth = 417
      end
    end
    object E_Hr_Attendance: TMaskEdit
      Left = 818
      Top = 321
      Width = 86
      Height = 21
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      MaxLength = 5
      TabOrder = 11
      Text = '  :  '
    end
    object Cb_Environment: TComboBox
      Left = 341
      Top = 22
      Width = 333
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Top = 112
  end
  object Cds_Anotacao: TClientDataSet
    PersistDataPacket.Data = {
      C90000009619E0BD010000001800000007000000000003000000C90002494404
      00010004000000084944454E5449465901004A00000001000557494454480200
      02006400084C494E4B5F4944310400010000000000084C494E4B5F4944320400
      010000000000095245464552454E434501004A00000001000557494454480200
      0200C8000B4F42534552564154494F4E04004B00000002000753554254595045
      02004900070042696E617279000557494454480200020008000944545F524543
      4F524404000600000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 536
    Top = 440
    object Cds_AnotacaoID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_ANNOTATION"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_AnotacaoIDENTIFY: TWideStringField
      FieldName = 'IDENTIFY'
      Origin = '"TB_ANNOTATION"."IDENTIFY"'
      Size = 50
    end
    object Cds_AnotacaoLINK_ID1: TIntegerField
      FieldName = 'LINK_ID1'
      Origin = '"TB_ANNOTATION"."LINK_ID1"'
    end
    object Cds_AnotacaoLINK_ID2: TIntegerField
      FieldName = 'LINK_ID2'
      Origin = '"TB_ANNOTATION"."LINK_ID2"'
    end
    object Cds_AnotacaoREFERENCE: TWideStringField
      FieldName = 'REFERENCE'
      Origin = '"TB_ANNOTATION"."REFERENCE"'
      Size = 100
    end
    object Cds_AnotacaoOBSERVATION: TBlobField
      FieldName = 'OBSERVATION'
      Origin = '"TB_ANNOTATION"."OBSERVATION"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object Cds_AnotacaoDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = '"TB_ANNOTATION"."DT_RECORD"'
    end
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = DM.Qr_Crud
    Left = 528
    Top = 384
  end
  object Ds_Anotacao: TDataSource
    DataSet = Cds_Anotacao
    Left = 552
    Top = 504
  end
end
