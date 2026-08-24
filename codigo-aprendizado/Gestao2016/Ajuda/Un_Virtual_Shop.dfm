object Fr_Virtual_Shop: TFr_Virtual_Shop
  Left = 358
  Top = 84
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Loja Virtual'
  ClientHeight = 491
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Edicao: TPanel
    Left = 0
    Top = 0
    Width = 593
    Height = 423
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label54: TLabel
      Left = 5
      Top = 4
      Width = 121
      Height = 13
      Caption = 'WebServices dispon'#237'veis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label55: TLabel
      Left = 4
      Top = 41
      Width = 141
      Height = 13
      Caption = 'Caminho do WebService  - url'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label40: TLabel
      Left = 5
      Top = 155
      Width = 125
      Height = 13
      Caption = 'Nome da Tabela de Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label37: TLabel
      Left = 5
      Top = 116
      Width = 100
      Height = 13
      Caption = 'Diret'#243'rio de Imagens '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 5
      Top = 235
      Width = 175
      Height = 13
      Caption = 'ID - Identificador do Google Analytics'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 79
      Width = 64
      Height = 13
      Caption = 'T'#237'tulo do Site'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 162
      Top = 4
      Width = 93
      Height = 13
      Caption = 'Site na WEb (www)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 5
      Top = 275
      Width = 349
      Height = 13
      Caption = 
        'e-mail para controlar o pagamento eletronico - BCash (www.bchas.' +
        'com.br)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Cb_TipoWebservice: TComboBox
      Left = 4
      Top = 18
      Width = 156
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        'VirtueMart'
        'Solu'#231#227'o Setes'
        'Gest'#227'o 2013'
        'TrayCommerce')
    end
    object E_Path_WebService: TEdit
      Left = 5
      Top = 54
      Width = 580
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object DblCb_Tabela: TDBLookupComboBox
      Left = 5
      Top = 170
      Width = 580
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'TPR_CODIGO'
      ListField = 'TPR_NOME'
      ListSource = DM.Ds_Tabelas
      ParentFont = False
      TabOrder = 5
    end
    object E_Dir_Images: TEdit
      Left = 5
      Top = 131
      Width = 580
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object Chbx_Internet: TCheckBox
      Left = 4
      Top = 314
      Width = 481
      Height = 17
      Caption = 'Ativar Conex'#227'o com a Internet - Com'#233'cio Eletr'#244'nico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object chbx_Vitrine: TCheckBox
      Left = 3
      Top = 330
      Width = 481
      Height = 17
      Caption = 
        'Ativar apenas como uma vitrine para os produtos, mas sem efetuar' +
        ' venda pelo site'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object chbx_Dealer: TCheckBox
      Left = 4
      Top = 346
      Width = 481
      Height = 17
      Caption = 
        'Permiti a visualiza'#231#227'o de pre'#231'os e/ou compra apenas para revende' +
        'dores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object E_Id_Google_analytics: TEdit
      Left = 5
      Top = 250
      Width = 580
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object E_Titulo_Site: TEdit
      Left = 5
      Top = 94
      Width = 580
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object gbProxy: TGroupBox
      Left = 2
      Top = 363
      Width = 589
      Height = 58
      Align = alBottom
      Caption = 'Proxy'
      TabOrder = 12
      object Label10: TLabel
        Left = 8
        Top = 12
        Width = 22
        Height = 13
        Caption = 'Host'
      end
      object Label11: TLabel
        Left = 279
        Top = 12
        Width = 25
        Height = 13
        Caption = 'Porta'
      end
      object Label14: TLabel
        Left = 331
        Top = 12
        Width = 36
        Height = 13
        Caption = 'Usu'#225'rio'
      end
      object Label19: TLabel
        Left = 472
        Top = 12
        Width = 31
        Height = 13
        Caption = 'Senha'
      end
      object E_Proxy_Path: TEdit
        Left = 6
        Top = 28
        Width = 266
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_Proxy_Porta: TEdit
        Left = 276
        Top = 28
        Width = 36
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object E_Proxy_User: TEdit
        Left = 315
        Top = 28
        Width = 121
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object E_Proxy_Pws: TEdit
        Left = 439
        Top = 28
        Width = 142
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 3
      end
    end
    object E_Site: TEdit
      Left = 163
      Top = 17
      Width = 422
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object e_mail: TEdit
      Left = 5
      Top = 290
      Width = 580
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    inline Fm_ListaEstoques: TFm_ListaEstoques
      Left = 5
      Top = 198
      Width = 583
      Height = 36
      TabOrder = 6
      ExplicitLeft = 5
      ExplicitTop = 198
      ExplicitWidth = 583
      inherited Label1: TLabel
        Width = 578
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 560
        ExplicitLeft = 560
      end
      inherited Dblcb_Estoque: TDBLookupComboBox
        Width = 580
        ExplicitWidth = 580
      end
      inherited ChBx_Estoques: TCheckBox
        Top = -1
        Visible = False
        ExplicitTop = -1
      end
      inherited Qr_Estoques: TSTQuery
        Left = 55
        Top = 16
      end
      inherited Ds_Estoques: TDataSource
        Left = 95
        Top = 16
      end
    end
  end
  object Pnl_botao: TPanel
    Left = 0
    Top = 423
    Width = 593
    Height = 68
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      593
      68)
    object SB_Gravar: TSpeedButton
      Left = 307
      Top = 8
      Width = 93
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
      Left = 400
      Top = 8
      Width = 93
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
    end
    object Sb_Sair_0: TSpeedButton
      Left = 493
      Top = 8
      Width = 93
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
    object SB_Alterar: TSpeedButton
      Left = 217
      Top = 8
      Width = 90
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
    end
  end
  object Qr_Virtual_Shop: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select *'
      'from TB_INTERNET '
      'where'
      '  INT_CODMHA = :INT_CODMHA ')
    Left = 216
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'INT_CODMHA'
        ParamType = ptUnknown
      end>
  end
end
