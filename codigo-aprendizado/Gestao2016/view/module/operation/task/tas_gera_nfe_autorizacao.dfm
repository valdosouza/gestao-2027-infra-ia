inherited TasGeraNfeAutorizacao: TTasGeraNfeAutorizacao
  Caption = 'TasGeraNfeAutorizacao'
  ClientHeight = 552
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    Height = 524
    ActivePage = tbs_NF_e
    ExplicitHeight = 524
    object tbs_NF_e: TTabSheet
      Caption = 'Nfe'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 431
        Width = 578
        Height = 65
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Sb_NF_Autorizar: TSpeedButton
          AlignWithMargins = True
          Left = 84
          Top = 3
          Width = 82
          Height = 59
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Caption = 'Autorizar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NF_AutorizarClick
          ExplicitTop = 4
        end
        object Sb_NF_Conferir: TSpeedButton
          AlignWithMargins = True
          Left = 2
          Top = 3
          Width = 82
          Height = 59
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Caption = 'Conferir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NF_ConferirClick
          ExplicitLeft = 5
          ExplicitTop = 4
        end
        object Sb_NF_sair: TSpeedButton
          AlignWithMargins = True
          Left = 494
          Top = 3
          Width = 82
          Height = 59
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Caption = 'Sair- Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_NF_sairClick
          ExplicitTop = 4
        end
        object Sb_NF_Envia: TSpeedButton
          AlignWithMargins = True
          Left = 412
          Top = 3
          Width = 82
          Height = 59
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Caption = 'Enviar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 1
          OnClick = Sb_NF_EnviaClick
          ExplicitTop = 4
        end
        object Sb_NF_Imprimir: TSpeedButton
          AlignWithMargins = True
          Left = 330
          Top = 3
          Width = 82
          Height = 59
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Caption = 'Imprimir - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_NF_ImprimirClick
          ExplicitLeft = 334
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_NF_Consultar: TSpeedButton
          AlignWithMargins = True
          Left = 166
          Top = 3
          Width = 82
          Height = 59
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Caption = 'Consultar - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NF_ConsultarClick
          ExplicitTop = 4
        end
        object Sb_NF_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 248
          Top = 3
          Width = 82
          Height = 59
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Caption = 'Cancelar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NF_CancelarClick
          ExplicitTop = 4
        end
      end
      object pnl_NF_e: TPanel
        Left = 0
        Top = 0
        Width = 578
        Height = 431
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Lb_titulo: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Acompanhamento da Opera'#231#227'o com Nota Fiscal Eletr'#244'nica'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 410
        end
        object MM_Acompanhamento: TMemo
          Left = 2
          Top = 18
          Width = 574
          Height = 320
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
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
        object E_Obs: TMemo
          Left = 898
          Top = 382
          Width = 447
          Height = 69
          TabOrder = 1
        end
        object CkBx_Nota_Manual: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 341
          Width = 568
          Height = 17
          Align = alTop
          Caption = 'Informar o N'#250'mero da Nota Manualmente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ChBx_NF_Referenciada: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 361
          Width = 568
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 1
          Align = alTop
          Caption = 
            'Informar chave de Acesso da nota Fiscal Referencia ( Casos Espec' +
            #237'ficos )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ChBx_NF_PreExistente: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 380
          Width = 568
          Height = 17
          Margins.Top = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 'Informar chave de Acesso para Nota pr'#233' existente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = ChBx_NF_PreExistenteClick
        end
        object ChBx_Otimiza_obs: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 399
          Width = 568
          Height = 17
          Margins.Top = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 
            'Otimizar o uso do campo observa'#231#227'o, suprimindo espa'#231'os duplos e ' +
            'linhas n'#227'o completas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
    end
  end
end
