object Fr_Consumidor: TFr_Consumidor
  Left = 343
  Top = 190
  Anchors = [akBottom]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro do Consumidor'
  ClientHeight = 273
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 208
    Width = 493
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      493
      65)
    object SB_Confirmar: TSpeedButton
      Left = 300
      Top = 6
      Width = 93
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
    object Sb_Sair_0: TSpeedButton
      Left = 393
      Top = 6
      Width = 95
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
  end
  object Pnl_Cliente: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 208
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Lb_Nome: TLabel
      Left = 126
      Top = 44
      Width = 99
      Height = 14
      Caption = 'Nome / Raz'#227'o Social'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 7
      Top = 85
      Width = 71
      Height = 14
      Caption = 'E-mail Principal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Doc: TLabel
      Left = 7
      Top = 43
      Width = 24
      Height = 14
      Caption = 'C.P.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 7
      Top = 161
      Width = 64
      Height = 14
      Caption = 'Complemento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 7
      Top = 122
      Width = 25
      Height = 14
      Caption = 'C.E.P'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Cep: TSpeedButton
      Left = 70
      Top = 137
      Width = 23
      Height = 21
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
        FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
        9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      Margin = 0
      NumGlyphs = 2
      OnClick = Sb_CepClick
    end
    object Label21: TLabel
      Left = 198
      Top = 162
      Width = 29
      Height = 14
      Caption = 'Bairro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 95
      Top = 124
      Width = 271
      Height = 14
      Caption = 'Endere'#231'o (Somente se for o mesmo do Estado Emitente)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label44: TLabel
      Left = 432
      Top = 124
      Width = 37
      Height = 14
      Caption = 'N'#250'mero'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Endereco: TSpeedButton
      Left = 406
      Top = 138
      Width = 23
      Height = 21
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
        FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
        9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      Margin = 0
      NumGlyphs = 2
      OnClick = Sb_EnderecoClick
    end
    object Label3: TLabel
      Left = 9
      Top = 2
      Width = 222
      Height = 14
      Caption = 'Tipo Pessoa - (Para Alternar utilize a Tecla F2)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Nome: TEdit
      Left = 123
      Top = 58
      Width = 365
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
    object E_Email: TEdit
      Left = 7
      Top = 99
      Width = 481
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_CPF: TMaskEdit
      Left = 7
      Top = 59
      Width = 111
      Height = 21
      CharCase = ecUpperCase
      EditMask = '999.999.999-99;0'
      MaxLength = 14
      TabOrder = 1
      Text = ''
      OnExit = E_CPFExit
    end
    object E_Complemento: TMaskEdit
      Left = 7
      Top = 176
      Width = 185
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 25
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    object E_Bairro: TMaskEdit
      Left = 196
      Top = 176
      Width = 293
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 8
      Text = ''
    end
    object E_cep: TMaskEdit
      Left = 7
      Top = 136
      Width = 59
      Height = 22
      CharCase = ecUpperCase
      EditMask = '#####-###;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      TabOrder = 4
      Text = ''
      OnExit = E_cepExit
    end
    object E_Endereco: TMaskEdit
      Left = 95
      Top = 138
      Width = 307
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 5
      Text = ''
    end
    object E_Numero: TMaskEdit
      Left = 430
      Top = 138
      Width = 58
      Height = 22
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
    object CB_TpPessoa: TComboBox
      Left = 6
      Top = 17
      Width = 115
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'F'#205'SICA'
      OnChange = CB_TpPessoaChange
      Items.Strings = (
        'F'#205'SICA'
        'JUR'#205'DICA'
        'ESTRANGEIRO')
    end
  end
  object Qr_BuscaCliente: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      'emp_codigo,'
      'EMP_CNPJ,'
      'emp_nome,'
      'emp_email'
      'from tb_empresa'
      'where EMP_CNPJ=:EMP_CNPJ')
    Left = 264
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CNPJ'
        ParamType = ptUnknown
      end>
  end
  object Qr_BuscaEndereco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      'emp_codigo,'
      'EMP_CNPJ,'
      'emp_nome,'
      'emp_email'
      'from tb_empresa'
      'where EMP_CNPJ=:EMP_CNPJ')
    Left = 320
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CNPJ'
        ParamType = ptUnknown
      end>
  end
end
