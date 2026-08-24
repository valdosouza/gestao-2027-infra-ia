inherited CadPetContact: TCadPetContact
  Caption = 'Cadastros de Contatos do Pet'
  ClientWidth = 728
  ExplicitWidth = 734
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Width = 728
    ExplicitWidth = 728
    inherited SB_Inserir: TSpeedButton
      Left = 101
      ExplicitLeft = 101
    end
    inherited SB_Alterar: TSpeedButton
      Left = 205
      ExplicitLeft = 205
    end
    inherited SB_Excluir: TSpeedButton
      Left = 309
      ExplicitLeft = 309
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 517
      ExplicitLeft = 517
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 621
      ExplicitLeft = 621
    end
    inherited SB_Gravar: TSpeedButton
      Left = 413
      ExplicitLeft = 413
    end
  end
  inherited pnl_fundo: TPanel
    Width = 728
    Height = 89
    Align = alTop
    ExplicitWidth = 728
    ExplicitHeight = 89
    object Label1: TLabel
      Left = 6
      Top = 2
      Width = 82
      Height = 14
      Caption = 'Nome do Contato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 41
      Width = 93
      Height = 14
      Caption = 'Endere'#231'o Completo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 497
      Top = 2
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
    object E_Name: TEdit
      Left = 6
      Top = 18
      Width = 485
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
    object E_Address: TEdit
      Left = 6
      Top = 57
      Width = 717
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_Fone: TEdit_Setes
      Left = 497
      Top = 18
      Width = 109
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
      IsFone = True
    end
    object Rg_emergency: TRadioGroup
      Left = 609
      Top = 4
      Width = 114
      Height = 36
      Caption = 'Emerg'#234'ncia'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'SIM'
        'N'#195#402'O')
      TabOrder = 2
    end
  end
  object Dbg_ListAnnotation: TDBGrid [2]
    Left = 0
    Top = 89
    Width = 728
    Height = 262
    Align = alClient
    Color = clCream
    DataSource = Ds_contacts
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = Dbg_ListAnnotationDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME'
        Width = 453
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMERGENCY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADDRESS'
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    Left = 80
    Top = 32
  end
  object Cds_contacts: TClientDataSet
    PersistDataPacket.Data = {
      A60100009619E0BD010000001800000006000000000003000000A60102494404
      00010004000100064F524947494E0200498016002254425F5045545F434F4E54
      414354222E22494422000954425F5045545F49440400010004000100064F5249
      47494E020049801D002254425F5045545F434F4E54414354222E2254425F5045
      545F49442200044E414D4501004A000000020005574944544802000200C80006
      4F524947494E0200498018002254425F5045545F434F4E54414354222E224E41
      4D452200074144445245535301004A000000020005574944544802000200C800
      064F524947494E020049801B002254425F5045545F434F4E54414354222E2241
      44445245535322000550484F4E4501004A000000020005574944544802000200
      C800064F524947494E0200498019002254425F5045545F434F4E54414354222E
      2250484F4E45220009454D455247454E435901004A0000000300075355425459
      5045020049000A0046697865644368617200055749445448020002000200064F
      524947494E020049801D002254425F5045545F434F4E54414354222E22454D45
      5247454E435922000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 120
    object Cds_contactsID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_PET_CONTACT"."ID"'
      Required = True
      Visible = False
    end
    object Cds_contactsTB_PET_ID: TIntegerField
      FieldName = 'TB_PET_ID'
      Origin = '"TB_PET_CONTACT"."TB_PET_ID"'
      Required = True
      Visible = False
    end
    object Cds_contactsNAME: TWideStringField
      DisplayLabel = 'Nome Contato'
      DisplayWidth = 85
      FieldName = 'NAME'
      Origin = '"TB_PET_CONTACT"."NAME"'
      Size = 100
    end
    object Cds_contactsPHONE: TWideStringField
      DisplayLabel = 'Fone'
      DisplayWidth = 37
      FieldName = 'PHONE'
      Origin = '"TB_PET_CONTACT"."PHONE"'
      Size = 100
    end
    object Cds_contactsEMERGENCY: TWideStringField
      DisplayLabel = 'Emerg'#234'ncia'
      DisplayWidth = 12
      FieldName = 'EMERGENCY'
      Origin = '"TB_PET_CONTACT"."EMERGENCY"'
      FixedChar = True
      Size = 1
    end
    object Cds_contactsADDRESS: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 120
      FieldName = 'ADDRESS'
      Origin = '"TB_PET_CONTACT"."ADDRESS"'
      Size = 100
    end
  end
  object Ds_contacts: TDataSource
    DataSet = Cds_contacts
    Left = 472
    Top = 178
  end
end
