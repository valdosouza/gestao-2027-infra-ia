object Fr_Doc_Fiscal_Referenciado: TFr_Doc_Fiscal_Referenciado
  Left = 335
  Top = 257
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Documento Fiscal Referenciado'
  ClientHeight = 236
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Controle: TPageControl
    Left = 0
    Top = 0
    Width = 442
    Height = 174
    ActivePage = tbs_chave
    Align = alClient
    TabOrder = 0
    object tbs_chave: TTabSheet
      Caption = 'Chave de acesso da NF-e'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 434
        Height = 146
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          Left = 7
          Top = 5
          Width = 37
          Height = 13
          Caption = 'N'#250'mero'
        end
        object E_Chave_Nfe: TEdit_Setes
          Left = 7
          Top = 19
          Width = 418
          Height = 21
          TabOrder = 0
          Text = ''
        end
      end
    end
    object tbs_dados: TTabSheet
      Caption = 'Informa'#231#227'o Manual'
      ImageIndex = 1
      OnShow = tbs_dadosShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnl_dados: TPanel
        Left = 0
        Top = 0
        Width = 434
        Height = 146
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 141
        object Label23: TLabel
          Left = 5
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
        object Label2: TLabel
          Left = 71
          Top = 3
          Width = 95
          Height = 14
          Caption = 'Ano e M'#234's Emiss'#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 181
          Top = 5
          Width = 110
          Height = 13
          Caption = 'CPF/CNPJ do emitente'
        end
        object Label4: TLabel
          Left = 5
          Top = 45
          Width = 138
          Height = 13
          Caption = 'Modelo do Documento Fiscal'
        end
        object Label5: TLabel
          Left = 150
          Top = 45
          Width = 127
          Height = 13
          Caption = 'S'#233'rie do Documento Fiscal'
        end
        object Label6: TLabel
          Left = 286
          Top = 45
          Width = 108
          Height = 13
          Caption = 'N'#250'mero da Nota Fiscal'
        end
        object Label7: TLabel
          Left = 319
          Top = 4
          Width = 87
          Height = 13
          Caption = 'Inscri'#231#227'o Estadual'
        end
        object Label8: TLabel
          Left = 5
          Top = 81
          Width = 186
          Height = 13
          Caption = 'Chave de Acesso da CT -Referenciada'
        end
        object DBLCB_UF: TDBLookupComboBox
          Left = 5
          Top = 18
          Width = 59
          Height = 21
          KeyField = 'UFE_CODIGO'
          ListField = 'UFE_SIGLA'
          ListSource = DM.Ds_UF
          TabOrder = 0
        end
        object E_Ano_Mes: TMaskEdit
          Left = 67
          Top = 19
          Width = 107
          Height = 21
          Alignment = taCenter
          EditMask = '00/00;0;_'
          MaxLength = 5
          TabOrder = 1
          Text = ''
        end
        object E_CNPJ: TMaskEdit
          Left = 178
          Top = 19
          Width = 135
          Height = 21
          TabOrder = 2
          Text = ''
        end
        object E_Modelo: TEdit
          Left = 5
          Top = 60
          Width = 140
          Height = 21
          TabOrder = 4
        end
        object E_Serie: TEdit
          Left = 149
          Top = 60
          Width = 134
          Height = 21
          TabOrder = 5
        end
        object E_Numero: TEdit
          Left = 286
          Top = 60
          Width = 142
          Height = 21
          TabOrder = 6
        end
        object e_InscriEstadual: TMaskEdit
          Left = 316
          Top = 18
          Width = 112
          Height = 21
          TabOrder = 3
          Text = ''
        end
        object E_Chave_CT: TEdit_Setes
          Left = 5
          Top = 95
          Width = 422
          Height = 21
          TabOrder = 7
          Text = ''
        end
        object ChBx_NFProd: TCheckBox
          Left = 8
          Top = 120
          Width = 201
          Height = 17
          Caption = 'Nota Fiscal de Produtor'
          TabOrder = 8
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 174
    Width = 442
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      442
      62)
    object SB_Confirmar: TSpeedButton
      Left = 250
      Top = 2
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
    end
    object SB_Cancelar: TSpeedButton
      Left = 346
      Top = 2
      Width = 90
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
      Transparent = False
      OnClick = SB_CancelarClick
    end
  end
end
