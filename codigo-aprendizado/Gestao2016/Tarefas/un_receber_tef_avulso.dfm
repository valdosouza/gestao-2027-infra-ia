inherited Fr_receber_tef_avulso: TFr_receber_tef_avulso
  Caption = 'Recebimento TEF - Avulso'
  ClientHeight = 377
  ClientWidth = 570
  ExplicitWidth = 576
  ExplicitHeight = 406
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Geral: TPanel
    Width = 570
    Height = 312
    ExplicitWidth = 784
    ExplicitHeight = 312
    inherited Pnl_Caixa: TLabel
      Width = 566
    end
    inherited Lb_FormaPagto: TLabel
      Width = 566
    end
    inherited Pnl_Botao: TPanel
      Top = 244
      Width = 566
      ExplicitTop = 244
      ExplicitWidth = 780
      inherited Sb_Confirma: TSpeedButton
        Left = 237
        Anchors = [akRight, akBottom]
        ExplicitLeft = 500
      end
      inherited Sb_Cancelar: TSpeedButton
        Left = 402
        Anchors = [akRight, akBottom]
        Caption = 'Fechar - ESC'
        Glyph.Data = {
          B6080000424DB608000000000000360000002800000016000000200000000100
          18000000000080080000465C0000465C00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FD1EB1D92D40C83CB238FD049A3D888C5
          E7CBE6F5FDFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2B98D4129EDE3FC7E92EB6E416
          9FDE018CD70380CA3798D482C1E5CBE5F4FEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFC5E3F391CBEC90C9E990C9E992CBEA80C2E60E88CD4BD5EF68FFFF
          47EFFD4CE8F94CDBF23DC5E923AEE40D98DC0582CB3999D481BFE5CCE6F5FFFF
          FFFFFFFFFFFFB5DCF00687CE0089D80087D40087D40086D40087D40085CD5AE3
          F42FE6FC00CAF601CDF615D6F92DE1FC47E9FB54E6F74FD9F233BFEC129FE006
          85CE51ACDFDCEEF8FFFF2891D11BA6DE55DCEF54DDF154DEF156DFF247CFEC06
          8BCF59E3F327E3FB00CEF600CBF600C8F511DDFC04CCF70EC8F52BDAFA4DECFD
          66F3FB39C4E90192E25DB0DEFFFF1583CB41CCEB47EBFF2CDBFF2AD6FF29D5FF
          22C8F9038AD058E1F328E4FB00CFF700CDF601CBF61BE5FE0BD2F800BDF204C9
          F70ED6FA25D2F773FFFF20AEE5429ED5FFFF1989CC2FC1EB0ECAFF00A9EE0695
          D40C9CD40A98D30086CD58E0F329E6FB00D1F700CFF601CDF61AE5FE0BD2F800
          C0F30CD1F81AE3FD00B9F25BF3FE3ECBF147A0D7FFFF1989CC2CC0EC11CCFF00
          98E042BFBA75F1B260DEB6088CC955DEF32BE7FC00D2F700D0F601CEF61AE5FE
          0BD3F800C2F30CD1F81AE2FD00BAF252EDFD46D3F449A2D8FFFF1989CC2DC0EC
          11CCFF0099E140C4B375FBA161E7A8088DC754DCF22DE9FC00D3F700D1F701CF
          F61AE5FE0BD3F800C3F30CD1F81AE2FD00BBF251EDFD46D4F547A0D7FFFF1989
          CC2DC0EC11CCFF0199E231BBAB5EF0904EDF99068CC553DBF22FEBFC00D5F800
          D2F701D0F71AE5FE0BD4F900C4F40CD2F81AE2FD00BCF250EDFD47D4F444A0D7
          FFFF1989CC2DC0EC11CCFF019AE225B5A34AE77D3FD889048BC251DAF232ECFD
          00D6F800D4F801D2F71AE5FE0BD5F900C6F40CD3F81AE2FD00BEF34EEDFD47D4
          F4419DD7FFFF1989CC2DC0EC11CCFF029AE31BAE9D38DF6C30D279038BC050D8
          F134EDFD00DAFF00DAFF00D7FF1AE6FE0BD6F900C7F40CD4F81AE2FD00BFF34D
          EDFD47D4F33D9BD4FFFF1989CC2DC0EC11CCFF029AE30EA79420D5531BCA6300
          8BBC4FD6F132F0FE2BC6CB9F945B51B2A415E8FF0BD7F900C8F50CD5F91AE3FD
          00C0F34CECFD48D4F33B9AD5FFFF1989CC2DC0EC11CCFF0199E02BB4C264F1C0
          5DE7CA0B90CB4CD3EE30F3FFAC9049FF6800F07E183ED7D906DAFE00CAF50CD6
          F91AE3FD00C2F44AECFD48D4F33798D4FFFF1989CC2DC0EC11CCFF0099DE46BF
          E599FFFF88F8FF1293D249D1EC32F4FFB08B41FF8718FFD2875BD3C903DAFF00
          CBF50CD6F91AE3FD00C3F449ECFD48D4F23599D3FFFF1989CC2DC0EC11CCFF00
          99DE49BEE1A0FFFD90F6F71393D147CFEB36F4FF3BC0B9DD8F37C3D9AE2FE5F4
          08D9FB00CCF50CD7F91AE3FD00C4F448ECFD48D4F23196D3FFFF1989CC2DC0EC
          11CCFF0099DE56BEE0BCFFFCACF7F71994D244CDEA3EF3FE00E1FF15D1E10ECF
          E516E8FF0BDAFA00CEF60CD8F91AE4FD00C5F447EBFD48D4F22F95D3FFFF1989
          CC2DC0EC11CCFF0099DE66BFE1DCFFFCCAF8F72095D242CBEA40F4FE00DFFA00
          DFFF00DCFE1AE7FE0BDBFA00CFF60CD9F91AE4FD00C7F545EBFD49D4F22B93D1
          FFFF1989CC2DC0EC11CCFF0099DE73BEDFF8FFF8E4F8F42696D23FC9E942F6FF
          00E1FA00DEFA01DCF91AE7FE0BDCFA00D1F70CDAFA1AE4FD00C8F544EBFD49D4
          F12993D2FFFF1989CC2DC0EC11CCFF0099DF76BCD8FCFEE9E9F5E52896CF3DC7
          E844F7FF00E2FB00DFFA01DDF91AE7FE0BDCFA00D2F70CDAFA1AE4FD00C9F543
          EBFD49D3F12590D1FFFF1989CC2DC0EC11CCFF0099DF77BBD0FDFAD7ECF2D52A
          96CC3BC5E847F7FF00E3FB00E3FE00DFFC19E7FF0BDEFA00D3F70CDBFA1AE4FE
          00CAF541EBFD49D3F12390D0FFFF1989CC2DC0EC11CCFF0099E079B9C8FEF6C7
          EFEEC52C96C939C3E849F9FF00E5FB07DCEF00DBF40EE8FF00E1FF00DAFF00E0
          FF13E8FF00CDF940EBFD4AD3F01F8DCFFFFF1989CC2DC0EC11CCFF0099E07AB7
          C0FFF1B5F2EBB52E96C637C1E747FBFF14DAE2BC9D56BFB57DA3B98C77B7994C
          B4A73AC2BE2FD2D800CBF23DECFF4AD3F01D8DCFFFFF1989CC2DC0EC11CCFF00
          99E17CB5B7FFEDA4F6E8A53196C235BEE748FCFF1BD5D6EFA352FFFFE3FFF2CF
          FFE4BDFFD7AAFACB9CE4BF8CA39E6C44E7F146D4F3198BCDFFFF1989CC2DC0EC
          11CCFF0099E17CB3AFFFE893F8E4943496BE32BDE64AFCFF1CD6D6EFA251FFFF
          EEFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFDFA4634DDDDE44D5F5178ACFFFFF1989
          CC2DC0EC11CCFF009AE27BB0A7FFE67FFFE2803997B830BAE64DFDFF10E0E8B3
          A25FE5BC80FDC990FFD6A5FFE4C0FFF2DBFFFEF5DEA4644CDEDE44D5F41388CC
          FFFF1989CC2DC0EC11CCFF0099E1549EACEBD577E7D2783393B62FB8E551FCFF
          00ECFF00E4F51AD1D348C9BE5ABBA577B393A1B286C9B37DAF9A5F44E5EE46D4
          F31085CBFFFF1989CC2CC0EB0DC9FF03ABEE028DD22198C71E98C70585C92FB5
          E166FFFF16F0FE05EDFF00EBFF00EBFF00E7FF00DEFF00DFFE11DFF503CBEA33
          EBFE4DD5EF0D85CCFFFF1585CB3CCBEC2CDBFF14CBFF12C7FF0BC4FF0CC6FF03
          97DC179CD570FBFE73FFFF67FFFF63FFFF5DFEFF58FBFF51F7FF4DF6FF43F4FF
          38EDFF61FCFF4CD6F00B84CBFFFF2D91D12AB6E65EECF852E6F953E7FA53E7FA
          56E9FB2AB5E30081CA179FD735BCE345CBEA52D9F05DE4F464EBF76BF2FB71F9
          FE76FFFF7CFFFF7BFFFF32BCE50B84CBFFFFBEE0F20D8AD00A95DA0D96D70D95
          D70D95D70D96D70992D60088D20084D00082D00083D00083D00088D2058FD50C
          96D8129DDB19A2DC1EA6DC1BA3DA038DD52192D1FFFFFFFFFFDAECF79CCEED98
          C9E999CAEA99CAEA99CAEA99CCEA99CEEB99CEEB99CEEB99CEEB99CEEB99CDEB
          99CBEA99CAE98FC3E669B0DD419DD5208CCF2093D3A4D4ECFFFF}
        ExplicitLeft = 659
      end
    end
    inherited Grp_Pagamento: TGroupBox
      Top = 91
      Width = 566
      Height = 153
      ExplicitTop = 91
      ExplicitWidth = 780
      ExplicitHeight = 153
      inherited E_M_Fisco: TMemo
        Top = 77
        ExplicitTop = 77
      end
      inherited E_M_Nota: TMemo
        Top = 9
        ExplicitTop = 9
      end
      inherited GroupBox1: TGroupBox
        Left = 8
        Top = 81
        ExplicitLeft = 8
        ExplicitTop = 81
      end
    end
    inherited Scx_Parcela: TScrollBox
      Width = 566
      Height = 38
      ExplicitWidth = 780
      ExplicitHeight = 38
    end
  end
  object Pnl_TEF_Geral: TPanel [1]
    Left = 0
    Top = 312
    Width = 570
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 1
    ExplicitWidth = 784
    object Pnl_Msg_TEF: TPanel
      Left = 2
      Top = 2
      Width = 319
      Height = 61
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object lMensagemOperador: TLabel
        Left = 2
        Top = 2
        Width = 315
        Height = 57
        Align = alClient
        Alignment = taCenter
        Caption = 'lMensagemOperador'
        Color = clBtnFace
        ParentColor = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 343
      end
      object Label48: TLabel
        Left = 2
        Top = 1
        Width = 118
        Height = 13
        Caption = 'Mensagem Operador'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
    end
    object Panel3: TPanel
      Left = 426
      Top = 2
      Width = 142
      Height = 61
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 527
      ExplicitWidth = 255
      object mm_Tef: TMemo
        Left = 1
        Top = 1
        Width = 140
        Height = 59
        TabStop = False
        Align = alClient
        ReadOnly = True
        TabOrder = 0
        ExplicitWidth = 253
      end
    end
    object Panel4: TPanel
      Left = 321
      Top = 2
      Width = 105
      Height = 61
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      ExplicitLeft = 422
      object bCancelarResp: TButton
        Left = 5
        Top = 4
        Width = 92
        Height = 52
        Caption = 'Cancelar - TEF'
        TabOrder = 0
        Visible = False
        WordWrap = True
      end
    end
  end
  object TEF: TACBrTEFD
    Identificacao.NomeAplicacao = 'Gest'#227'o Setes'
    Identificacao.VersaoAplicacao = '2.016'
    Identificacao.SoftwareHouse = 'Setes'
    Identificacao.RazaoSocial = 'F.D.S - Desenvolvimento'
    MultiplosCartoes = True
    NumeroMaximoCartoes = 3
    AutoAtivarGP = False
    ExibirMsgAutenticacao = False
    AutoFinalizarCupom = False
    EsperaSTS = 7
    SuportaSaque = False
    SuportaDesconto = False
    TEFPayGo.AutoAtivarGP = False
    TEFPayGo.ArqTemp = 'C:\PAYGO\REQ\intpos.tmp'
    TEFPayGo.ArqReq = 'C:\PAYGO\REQ\intpos.001'
    TEFPayGo.ArqSTS = 'C:\PAYGO\RESP\intpos.sts'
    TEFPayGo.ArqResp = 'C:\PAYGO\RESP\intpos.001'
    TEFPayGoWeb.SuportaViasDiferenciadas = True
    TEFPayGoWeb.UtilizaSaldoTotalVoucher = False
    TEFPayGoWeb.ConfirmarTransacoesPendentes = True
    TEFPayGoWeb.PerguntarCartaoDigitadoAposCancelarLeitura = False
    TEFDial.ArqLOG = 'TEF_DIAL.log'
    TEFDial.Habilitado = True
    TEFDial.AutoAtivarGP = False
    TEFDial.ArqTemp = 'C:\TEF_DIAL\req\intpos.tmp'
    TEFDial.ArqReq = 'C:\TEF_DIAL\req\intpos.001'
    TEFDial.ArqSTS = 'C:\TEF_DIAL\resp\intpos.sts'
    TEFDial.ArqResp = 'C:\TEF_DIAL\resp\intpos.001'
    TEFDial.GPExeName = 'C:\TEF_DIAL\tef_dial.exe'
    TEFDisc.AutoAtivarGP = False
    TEFDisc.ArqTemp = 'C:\TEF_Disc\req\intpos.tmp'
    TEFDisc.ArqReq = 'C:\TEF_Disc\req\intpos.001'
    TEFDisc.ArqSTS = 'C:\TEF_Disc\resp\intpos.sts'
    TEFDisc.ArqResp = 'C:\TEF_Disc\resp\intpos.001'
    TEFDisc.GPExeName = 'C:\TEF_Disc\tef_Disc.exe'
    TEFHiper.AutoAtivarGP = False
    TEFHiper.ArqTemp = 'c:\HiperTEF\req\IntPos.tmp'
    TEFHiper.ArqReq = 'C:\HiperTEF\req\IntPos.001'
    TEFHiper.ArqSTS = 'C:\HiperTEF\resp\IntPos.sts'
    TEFHiper.ArqResp = 'C:\HiperTEF\resp\IntPos.001'
    TEFHiper.GPExeName = 'C:\HiperTEF\HiperTEF.exe'
    TEFCliSiTef.ArqLOG = 'CliSiTef.log'
    TEFCliSiTef.EnderecoIP = '127.0.0.1'
    TEFCliSiTef.CodigoLoja = '00000000'
    TEFCliSiTef.NumeroTerminal = 'SE000001'
    TEFCliSiTef.PortaPinPad = 8
    TEFCliSiTef.OnExibeMenu = ACBrTEFD1CliSiTefExibeMenu
    TEFCliSiTef.OnObtemCampo = ACBrTEFD1CliSiTefObtemCampo
    TEFCliSiTef.ExibirErroRetorno = True
    TEFVeSPague.ArqLOG = 'VeSPague.log'
    TEFVeSPague.Aplicacao = 'ACBr_TEFDDemo'
    TEFVeSPague.AplicacaoVersao = '1.0'
    TEFVeSPague.GPExeName = 'C:\VeSPague\Client\VeSPagueClient.bat'
    TEFVeSPague.GPExeParams = '189.115.24.32 65432'
    TEFVeSPague.EnderecoIP = 'localhost'
    TEFVeSPague.Porta = '60906'
    TEFVeSPague.TimeOut = 500
    TEFVeSPague.TemPendencias = False
    TEFVeSPague.TransacaoCRT = 'Cartao Vender'
    TEFVeSPague.TransacaoCHQ = 'Cheque Consultar'
    TEFVeSPague.TransacaoCNC = 'Administracao Cancelar'
    TEFVeSPague.TransacaoReImpressao = 'Administracao Reimprimir'
    TEFVeSPague.TransacaoPendente = 'Administracao Pendente'
    TEFGPU.AutoAtivarGP = False
    TEFGPU.ArqTemp = 'C:\TEF_GPU\req\intpos.tmp'
    TEFGPU.ArqReq = 'C:\TEF_GPU\req\intpos.001'
    TEFGPU.ArqSTS = 'C:\TEF_GPU\resp\intpos.sts'
    TEFGPU.ArqResp = 'C:\TEF_GPU\resp\intpos.001'
    TEFGPU.GPExeName = 'C:\TEF_GPU\GPU.exe'
    TEFBanese.ArqTemp = 'C:\bcard\req\pergunta.tmp'
    TEFBanese.ArqReq = 'C:\bcard\req\pergunta.txt'
    TEFBanese.ArqSTS = 'C:\bcard\resp\status.txt'
    TEFBanese.ArqResp = 'C:\bcard\resp\resposta.txt'
    TEFBanese.ArqRespBkp = 'C:\bcard\resposta.txt'
    TEFBanese.ArqRespMovBkp = 'C:\bcard\copiamovimento.txt'
    TEFAuttar.AutoAtivarGP = False
    TEFAuttar.ArqTemp = 'C:\Auttar_TefIP\req\intpos.tmp'
    TEFAuttar.ArqReq = 'C:\Auttar_TefIP\req\intpos.001'
    TEFAuttar.ArqSTS = 'C:\Auttar_TefIP\resp\intpos.sts'
    TEFAuttar.ArqResp = 'C:\Auttar_TefIP\resp\intpos.001'
    TEFAuttar.GPExeName = 'C:\Program Files (x86)\Auttar\IntegradorTEF-IP.exe'
    TEFGood.AutoAtivarGP = False
    TEFGood.ArqTemp = 'C:\good\gettemp.dat'
    TEFGood.ArqReq = 'C:\good\getreq.dat'
    TEFGood.ArqSTS = 'C:\good\getstat.dat'
    TEFGood.ArqResp = 'C:\good\getresp.dat'
    TEFGood.GPExeName = 'C:\good\GETGoodMed.exe'
    TEFFoxWin.AutoAtivarGP = False
    TEFFoxWin.ArqTemp = 'C:\FwTEF\req\intpos.tmp'
    TEFFoxWin.ArqReq = 'C:\FwTEF\req\intpos.001'
    TEFFoxWin.ArqSTS = 'C:\FwTEF\rsp\intpos.sts'
    TEFFoxWin.ArqResp = 'C:\FwTEF\rsp\intpos.001'
    TEFFoxWin.GPExeName = 'C:\FwTEF\bin\FwTEF.exe'
    TEFCliDTEF.ArqResp = ''
    TEFPetrocard.AutoAtivarGP = False
    TEFPetrocard.ArqTemp = 'C:\CardTech\req\intpos.tmp'
    TEFPetrocard.ArqReq = 'C:\CardTech\req\intpos.001'
    TEFPetrocard.ArqSTS = 'C:\CardTech\resp\intpos.sts'
    TEFPetrocard.ArqResp = 'C:\CardTech\resp\intpos.001'
    TEFPetrocard.GPExeName = 'C:\CardTech\sac.exe'
    TEFCrediShop.AutoAtivarGP = False
    TEFCrediShop.ArqTemp = 'C:\tef_cshp\req\intpos.tmp'
    TEFCrediShop.ArqReq = 'C:\tef_cshp\req\intpos.001'
    TEFCrediShop.ArqSTS = 'C:\tef_cshp\resp\intpos.sts'
    TEFCrediShop.ArqResp = 'C:\tef_cshp\resp\intpos.001'
    TEFCrediShop.GPExeName = 'C:\tef_cshp\vpos_tef.exe'
    TEFTicketCar.ArqTemp = 'C:\TCS\TX\INTTCS.tmp'
    TEFTicketCar.ArqReq = 'C:\TCS\TX\INTTCS.001'
    TEFTicketCar.ArqSTS = 'C:\TCS\RX\INTTCS.RET'
    TEFTicketCar.ArqResp = 'C:\TCS\RX\INTTCS.001'
    TEFTicketCar.GPExeName = 'C:\TCS\tcs.exe'
    TEFTicketCar.NumLoja = 0
    TEFTicketCar.NumCaixa = 0
    TEFTicketCar.AtualizaPrecos = False
    TEFConvCard.AutoAtivarGP = False
    TEFConvCard.ArqTemp = 'C:\ger_convenio\tx\crtsol.tmp'
    TEFConvCard.ArqReq = 'C:\ger_convenio\tx\crtsol.001'
    TEFConvCard.ArqSTS = 'C:\ger_convenio\rx\crtsol.ok'
    TEFConvCard.ArqResp = 'C:\ger_convenio\rx\crtsol.001'
    TEFConvCard.GPExeName = 'C:\ger_convcard\convcard.exe'
    TEFCliSiTefModular.AutoAtivarGP = False
    TEFCliSiTefModular.ArqTemp = 'C:\Client\req\intpos.tmp'
    TEFCliSiTefModular.ArqReq = 'C:\Client\req\intpos.001'
    TEFCliSiTefModular.ArqSTS = 'C:\Client\resp\intpos.sts'
    TEFCliSiTefModular.ArqResp = 'C:\Client\resp\intpos.001'
    TEFCliSiTefModular.GPExeName = 'C:\Client\ClientSiTef.exe'
    TEFDirecao.AutoAtivarGP = False
    TEFDirecao.ArqTemp = 'C:\TEF_DIAL\req\intpos.tmp'
    TEFDirecao.ArqReq = 'C:\TEF_DIAL\req\intpos.001'
    TEFDirecao.ArqSTS = 'C:\TEF_DIAL\resp\intpos.sts'
    TEFDirecao.ArqResp = 'C:\TEF_DIAL\resp\intpos.001'
    TEFDirecao.GPExeName = 'C:\DPOS8\Bin\GPDirecao.exe'
    TEFElgin.AutoAtivarGP = False
    TEFElgin.ArqTemp = 'C:\Cliente\req\intpos.tmp'
    TEFElgin.ArqReq = 'C:\Cliente\req\intpos.001'
    TEFElgin.ArqSTS = 'C:\Cliente\resp\intpos.sts'
    TEFElgin.ArqResp = 'C:\Cliente\resp\intpos.001'
    TEFElgin.GPExeName = 'C:\ELGIN\TEFPassivo\E1_TEFPay_Passivo.exe'
    OnAguardaResp = TEFAguardaResp
    OnExibeMsg = TEFExibeMsg
    OnBloqueiaMouseTeclado = TEFBloqueiaMouseTeclado
    OnComandaECF = TEFComandaECF
    OnComandaECFSubtotaliza = TEFComandaECFSubtotaliza
    OnComandaECFAbreVinculado = TEFComandaECFAbreVinculado
    OnComandaECFImprimeVia = TEFComandaECFImprimeVia
    OnInfoECF = TEFInfoECF
    OnAntesFinalizarRequisicao = TEFAntesFinalizarRequisicao
    OnDepoisConfirmarTransacoes = TEFDepoisConfirmarTransacoes
    Left = 32
    Top = 200
  end
end
