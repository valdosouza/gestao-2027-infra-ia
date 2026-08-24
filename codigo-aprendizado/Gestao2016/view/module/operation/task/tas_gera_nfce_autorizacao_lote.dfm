inherited TasGeraNfceAutorizacaoLote: TTasGeraNfceAutorizacaoLote
  Caption = 'TasGeraNfceAutorizacaoLote'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    ActivePage = tbs_Auto_Lote_Nfce
    object tbs_Auto_Lote_Nfce: TTabSheet
      Caption = 'Autoriza'#231#227'o Lote NFC-e'
      ImageIndex = 4
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 578
        Height = 65
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Lb_7_Inicio: TLabel
          Left = 198
          Top = 21
          Width = 53
          Height = 13
          Caption = 'Nota Inicial'
        end
        object Lb_7_Fim: TLabel
          Left = 283
          Top = 21
          Width = 48
          Height = 13
          Caption = 'Nota Final'
        end
        object Label36: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Opera'#231#245'es em Lote de Nota Fiscal Eletr'#244'nica '
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 320
        end
        object RG_7_Tipo_Pesquisa: TRadioGroup
          Left = 4
          Top = 22
          Width = 188
          Height = 37
          Caption = 'Tipo Pesquisa'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Numero N.F'
            'Data')
          TabOrder = 0
          OnClick = RG_7_Tipo_PesquisaClick
        end
        object Ed_7_Inicio: TMaskEdit
          Left = 197
          Top = 37
          Width = 80
          Height = 21
          TabOrder = 1
          Text = ''
        end
        object Ed_7_Fim: TMaskEdit
          Left = 280
          Top = 37
          Width = 80
          Height = 21
          TabOrder = 2
          Text = ''
        end
      end
      object Panel16: TPanel
        Left = 0
        Top = 568
        Width = 578
        Height = 64
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_Off_NFCe_Voltar: TSpeedButton
          AlignWithMargins = True
          Left = 491
          Top = 5
          Width = 82
          Height = 54
          Align = alRight
          Caption = 'Sair- Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Off_NFCe_VoltarClick
          ExplicitLeft = 496
          ExplicitTop = 6
        end
        object Sb_Off_NFCe_Confirmar: TSpeedButton
          AlignWithMargins = True
          Left = 403
          Top = 5
          Width = 82
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
          OnClick = Sb_Off_NFCe_ConfirmarClick
          ExplicitLeft = 417
          ExplicitTop = 6
        end
      end
      object Panel14: TPanel
        Left = 0
        Top = 65
        Width = 578
        Height = 503
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object Label31: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Acompanhamento processo'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 194
        end
        object MM_Auto_Lote_NFce: TMemo
          Left = 2
          Top = 18
          Width = 574
          Height = 483
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
    end
  end
  inherited Qr_lote: TSTQuery
    Left = 532
    Top = 320
  end
end
