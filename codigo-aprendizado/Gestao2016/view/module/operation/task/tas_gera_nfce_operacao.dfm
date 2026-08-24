inherited TasGeraNfceOperacao: TTasGeraNfceOperacao
  Caption = 'Consulta Lote NFCE'
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    ActivePage = tbs_Operacao
    inherited tbs_NFC_e: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 578
      ExplicitHeight = 632
    end
    object tbs_Operacao: TTabSheet
      Caption = 'Opera'#231#245'es NFC-e'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 578
        Height = 570
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label15: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Opera'#231#245'es em Lote de Nota Fiscal de Consumidor Eletr'#244'nica '
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 428
        end
        object Lb_3_Inicio: TLabel
          Left = 197
          Top = 22
          Width = 53
          Height = 13
          Caption = 'Nota Inicial'
        end
        object Lb_3_Fim: TLabel
          Left = 286
          Top = 22
          Width = 48
          Height = 13
          Caption = 'Nota Final'
        end
        object Label29: TLabel
          Left = 265
          Top = 77
          Width = 284
          Height = 13
          Caption = 'As notas ser'#227'o consultadas antes desta opera'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RG_3_Tipo_Pesquisa: TRadioGroup
          Left = 3
          Top = 24
          Width = 188
          Height = 37
          Caption = 'Tipo Pesquisa'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Numero N.F'
            'Data')
          TabOrder = 0
          OnClick = RG_3_Tipo_PesquisaClick
        end
        object Chbx_Pendente: TCheckBox
          Left = 4
          Top = 59
          Width = 127
          Height = 17
          Caption = 'Somente as Pendentes'
          TabOrder = 1
        end
        object Chbx_pend_Numerada: TCheckBox
          Left = 4
          Top = 77
          Width = 258
          Height = 13
          Caption = 'Cancelar as vendas numeradas n'#227'o autorizadas - '
          TabOrder = 2
        end
        object Chbx_pend_Branco: TCheckBox
          Left = 4
          Top = 93
          Width = 288
          Height = 13
          Caption = 'Cancelar as vendas n'#227'o numeradas e n'#227'o autorizadas.'
          TabOrder = 3
        end
        object Chbx_Sem_Sucesso: TCheckBox
          Left = 4
          Top = 112
          Width = 564
          Height = 13
          Caption = 
            'Consultar N'#250'mero de Notas que n'#227'o aparecem no sistema como proce' +
            'ssos finalizados com sucesso'
          TabOrder = 4
          OnClick = Chbx_Sem_SucessoClick
        end
        object Ed_3_Inicio: TMaskEdit
          Left = 197
          Top = 37
          Width = 80
          Height = 21
          TabOrder = 6
          Text = ''
        end
        object Ed_3_Fim: TMaskEdit
          Left = 284
          Top = 37
          Width = 80
          Height = 21
          TabOrder = 5
          Text = ''
        end
        object MM_Operacao: TMemo
          Left = 2
          Top = 131
          Width = 574
          Height = 437
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Ctl3D = False
          Lines.Strings = (
            '')
          ParentCtl3D = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 7
          WantReturns = False
          WantTabs = True
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 570
        Width = 578
        Height = 62
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_Confirmar: TSpeedButton
          AlignWithMargins = True
          Left = 403
          Top = 5
          Width = 82
          Height = 52
          Align = alRight
          Caption = 'Executar - F10'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 1
          OnClick = Sb_ConfirmarClick
          ExplicitLeft = 801
          ExplicitTop = 4
        end
        object Sb_operacao_sair: TSpeedButton
          AlignWithMargins = True
          Left = 491
          Top = 5
          Width = 82
          Height = 52
          Align = alRight
          Caption = 'Sair - Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_operacao_sairClick
          ExplicitLeft = 511
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_CriarChaveAcesse: TSpeedButton
          Left = 2
          Top = 2
          Width = 82
          Height = 58
          Align = alLeft
          Caption = 'Cria Chave'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 1
          OnClick = Sb_CriarChaveAcesseClick
          ExplicitLeft = 5
          ExplicitTop = 3
          ExplicitHeight = 54
        end
      end
    end
  end
  inherited Qr_lote: TSTQuery
    Top = 280
  end
end
