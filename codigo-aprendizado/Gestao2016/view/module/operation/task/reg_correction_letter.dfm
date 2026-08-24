inherited RegCorrectionLetter: TRegCorrectionLetter
  Caption = 'Carta de Corre'#231#227'o'
  ClientHeight = 452
  ClientWidth = 762
  ExplicitWidth = 768
  ExplicitHeight = 501
  PixelsPerInch = 96
  TextHeight = 13
  object Lb_DetalhesPedido: TLabel [0]
    Left = 0
    Top = 0
    Width = 762
    Height = 20
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    BiDiMode = bdLeftToRight
    Caption = 'LISTA DE CORRE'#199#213'ES EFETUADAS'
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentColor = False
    ParentFont = False
    Transparent = False
    ExplicitLeft = 4
    ExplicitTop = 10
    ExplicitWidth = 758
  end
  inherited pnl_botao: TPanel
    Top = 388
    Width = 762
    ExplicitTop = 388
    ExplicitWidth = 762
    inherited SB_Inserir: TSpeedButton
      Left = 9
      Width = 80
      ExplicitLeft = 150
      ExplicitTop = 5
      ExplicitWidth = 80
    end
    inherited SB_Alterar: TSpeedButton
      Left = 91
      Width = 80
      ExplicitLeft = 232
      ExplicitTop = 5
      ExplicitWidth = 80
    end
    inherited SB_Excluir: TSpeedButton
      Left = 173
      Width = 80
      ExplicitLeft = 314
      ExplicitTop = 5
      ExplicitWidth = 80
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 337
      Width = 80
      ExplicitLeft = 478
      ExplicitTop = 5
      ExplicitWidth = 80
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 677
      Width = 80
      ExplicitLeft = 677
      ExplicitTop = 5
      ExplicitWidth = 80
    end
    inherited SB_Gravar: TSpeedButton
      Left = 255
      Width = 80
      ExplicitLeft = 396
      ExplicitTop = 5
      ExplicitWidth = 80
    end
    object Sb_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 421
      Top = 5
      Width = 80
      Height = 54
      Align = alRight
      Caption = 'Confirmar - F9'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 10
      OnClick = Sb_ConfirmarClick
      ExplicitLeft = 568
      ExplicitTop = 2
      ExplicitHeight = 60
    end
    object Sb_Enviar: TSpeedButton
      AlignWithMargins = True
      Left = 507
      Top = 5
      Width = 80
      Height = 54
      Align = alRight
      Caption = 'Enviar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 1
      OnClick = Sb_EnviarClick
      ExplicitLeft = 645
      ExplicitTop = 2
      ExplicitHeight = 60
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 593
      Top = 5
      Width = 80
      Height = 54
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
      OnClick = SB_ImprimirClick
      ExplicitLeft = 722
      ExplicitTop = 2
      ExplicitHeight = 60
    end
  end
  inherited pnl_fundo: TPanel
    Top = 201
    Width = 762
    Height = 187
    ExplicitTop = 201
    ExplicitWidth = 762
    ExplicitHeight = 187
    object Label1: TLabel
      Left = 2
      Top = 2
      Width = 758
      Height = 13
      Align = alTop
      Caption = 
        'Detalhe da Corre'#231#227'o | M'#237'nimo de 15 caracteres | Digita'#231#227'o em Lin' +
        'ha | Ex: No Campo "X" onde se l'#234'  "texto errado, leia-se "Texto ' +
        'correto"'
      FocusControl = E_Detalhe
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 650
    end
    object E_Detalhe: TMemo
      Left = 2
      Top = 15
      Width = 758
      Height = 170
      Align = alClient
      TabOrder = 0
    end
  end
  object DBG_Pesquisa: TDBGrid [3]
    Left = 0
    Top = 20
    Width = 762
    Height = 181
    Align = alTop
    Color = clCream
    DataSource = Ds_Qr_Correcao
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
    Columns = <
      item
        Expanded = False
        FieldName = 'CCE_CODIGO'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFL_DT_EMISSAO'
        Title.Caption = 'Data Nota'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFL_NUMERO'
        Title.Caption = 'Nota Fiscal'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CCE_DATA'
        Title.Caption = 'Data Corre'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CCE_RESUMO'
        Title.Caption = 'Detalhe'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 346
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CCE_MOTIVO'
        Title.Caption = 'Resposta'
        Visible = True
      end>
  end
  object Pnl_EnviaCarta: TPanel [4]
    Left = 66
    Top = 60
    Width = 493
    Height = 283
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    Visible = False
    object Label2: TLabel
      Left = 2
      Top = 2
      Width = 489
      Height = 20
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Envio da Carta de Corre'#231#227'o'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      Transparent = False
      ExplicitTop = 225
    end
    object Sb_FechaEnvio: TButton
      Left = 413
      Top = 251
      Width = 75
      Height = 25
      Caption = 'Fechar'
      Enabled = False
      TabOrder = 0
      OnClick = Sb_FechaEnvioClick
    end
    object PageControl1: TPageControl
      Left = 2
      Top = 22
      Width = 489
      Height = 226
      ActivePage = TabSheet2
      Align = alTop
      TabOrder = 1
      object TabSheet2: TTabSheet
        Caption = 'Acompanhamento'
        ImageIndex = 1
        object MM_Acompanhamento: TMemo
          Left = 0
          Top = 0
          Width = 481
          Height = 198
          Align = alClient
          Ctl3D = False
          Lines.Strings = (
            '')
          ParentCtl3D = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          WantReturns = False
          WantTabs = True
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Processamento'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 477
        ExplicitHeight = 0
        object WBResposta: TWebBrowser
          Left = 0
          Top = 0
          Width = 481
          Height = 198
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 494
          ExplicitHeight = 222
          ControlData = {
            4C000000B6310000771400000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Receita'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 477
        ExplicitHeight = 0
        object MemoResp: TMemo
          Left = 0
          Top = 0
          Width = 481
          Height = 198
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 477
        end
      end
    end
  end
  object Qr_Carta_Correcao: TSTQuery
    AfterOpen = Qr_Carta_CorrecaoAfterOpen
    AfterScroll = Qr_Carta_CorrecaoAfterScroll
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'Select '
      'N.nfl_codigo,'
      'C.CCE_CODIGO,'
      'N.NFL_DT_EMISSAO, '
      'N.NFL_NUMERO, '
      'C.CCE_DATA, '
      
        'CAST(substring(C.CCE_DETALHE from 1 for 30)  as varchar(30))  CC' +
        'E_RESUMO,'
      'C.CCE_DETALHE,'
      'C.CCE_CODSIT,'
      'C.CCE_CHAVE,'
      'C.CCE_CODUFE,'
      'C.CCE_MOTIVO,'
      'EP.EMP_EMAIL,'
      'N.NFL_CODTRP,'
      'C.CCE_SEQUENCIA,'
      'C.CCE_PROTOCOLO, '
      'C.CCE_DT_PROTOCOLO,'
      'ED.end_celular'
      'from TB_CARTA_CORRECAO C'
      '  INNER JOIN TB_NOTA_FISCAL N'
      '  ON (N.NFL_CODIGO = C.CCE_CODNFL)'
      '  INNER JOIN TB_PEDIDO P'
      '  ON (P.ped_codigo = N.nfl_codped)'
      '  INNER JOIN TB_EMPRESA EP'
      '  ON (EP.EMP_CODIGO = N.NFL_CODEMP)'
      '  INNER JOIN TB_ENDERECO ED'
      '  ON (ED.end_codigo = P.ped_codend)'
      'where'
      '  C.CCE_CODNFL = :NFL_CODIGO'
      'ORDER BY C.CCE_CODIGO, C.CCE_SEQUENCIA')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 328
    Top = 161
    ParamData = <
      item
        Name = 'NFL_CODIGO'
      end>
  end
  object Ds_Qr_Correcao: TDataSource
    DataSet = Qr_Carta_Correcao
    Left = 328
    Top = 217
  end
end
