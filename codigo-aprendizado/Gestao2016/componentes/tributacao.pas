unit tributacao;

interface

uses
      SysUtils, StdCtrls, Classes, STQuery, STDatabase, Variants, Graphics, un_msg, System.Math, ACBrValidador, ACBrRFD, ACBrECF, ACBrDevice, ACBrNFeDANFEClass, ACBrNFe.Classes, ACBrNFe, ACBrNFPws, ACBrSocket, ACBrIBPTax, pcnConversao, Controls, ControllerProduto, ControllerNotaFiscal, ControllerIcmsFCP, ControllerDevolIPI, ACBrUtil, ControllerCtrlIcmsST, Un_DM, TblCtrlIcmsST, cad_fat_ctrl_icms_st, RN_NotaFiscal, ControllerProductUfBenef, ControllerEstabelecimento, ControllerGeral, ControllerItensNFLTributacao, pcnConversaoNFe, ControllerTaxes, ACBrDFe.Conversao;

type
  ttributacao = class(TComponent)

  private
    { Private declarations }
    procedure Pc_DefineDestinatario(Pc_Nfe:TNFe);
    procedure Pc_DefineRemetente(Pc_Nfe:TNFe);
    procedure Pc_DefineCasasDecimais;
    Procedure Pc_PreencheEnderecoiEntrega(Fc_Entrega:TEntrega;Fc_cd_Empresa: Integer);

    Procedure Pc_RegimeTributarioNormal(Pc_Prod:TProd; Pc_Imposto:TImposto);
    Procedure Pc_InformaRegimeTributarioNormalManual(Pc_Prod:TProd;Pc_Imposto:TImposto);
    Procedure Pc_RegimeTributarioSimplesNacional(Pc_Prod:TProd;Pc_Imposto:TImposto);
    Procedure Pc_InformaRegimeTributarioSimplesNacionalManual(Pc_Prod:TProd;Pc_Imposto:TImposto);
    function tributaFCP(ncm:String):Real;
    procedure CalculoFundoCombatePobreza(Pc_Prod:TProd;Pc_Imposto:TImposto);

    // -----------------------------------------------------------------------
    // Funções centralizadas para cálculo da base de ICMS
    // Centraliza em único lugar as regras de composição da base,
    // evitando duplicação nas procedures de cada regime tributário.
    // -----------------------------------------------------------------------

    // Regra de inclusão do IPI na base ICMS - art. 155 §2º XI CF / art. 13 §2º LC 87/96:
    //   O IPI NÃO integra a base ICMS apenas quando os 3 requisitos são atendidos
    //   SIMULTANEAMENTE:
    //     1. Operação entre contribuintes  (It_Contribuinte_ICMS = True)
    //     2. Mercadoria para industrialização(4) ou produção(2) (TRB_PRODUTO in [2,4])
    //     3. Fato gerador de ambos os impostos  (vIPI > 0)
    //   Nos demais casos (consumidor final, uso/consumo, ativo imobilizado, etc.)
    //   o IPI deve compor a base.
    //   Retorna vIPI quando deve compor, 0 quando a exceção se aplica.
    function Fn_IPIIntegraNaBaseICMS(vIPI: Real): Real;

    // Base ICMS normal:
    //   VlProd  = (VL_UNIT * QTDE) - DESC  (valor líquido do item)
    //   PctRed  = % redução da base (TRB_RD_BS_ICMS), 0 se não houver
    //   vIPI    = valor do IPI do item - a função aplica Fn_IPIIntegraNaBaseICMS internamente
    //   vFrete  = valor do frete a incluir na base (0 se não aplicável)
    //   vSeg    = Pc_Prod.vSeg
    //   vOutro  = Pc_Prod.vOutro


    function Fn_CalcBaseICMS(PctRed, vIPI, vFrete: Real): Real;

    // Base ICMS ST - fórmula completa por MVA (Lei Kandir / RICMS):
    //   Para ST, o IPI SEMPRE compõe a base (ao contrário do ICMS próprio).
    //   Base ST = (VlProd + vIPI + vFrete + vSeg + vOutro) × (1 - PctRed/100) × pMVA
    //
    //   VlProd  = (VL_UNIT * QTDE) - DESC   (valor líquido do item)
    //   vIPI    = Pc_Imposto.IPI.vIPI        (IPI sempre entra na base ST)
    //   vFrete  = Pc_Prod.vFrete
    //   vSeg    = Pc_Prod.vSeg
    //   vOutro  = Pc_Prod.vOutro
    //   PctRed  = % redução da base ST (0 se não houver)
    //   pMVA    = fator MVA (MargemValorAgregado)
    function Fn_CalcBaseICMSST(vIPI, vFrete, vSeg, vOutro, PctRed, pMVA: Real): Real;

    Procedure Pc_DefineIPI(Pc_Prod:Tprod; Pc_Imposto:TImposto);
    Procedure Pc_DefineII(Pc_Imposto:TImposto);
    Procedure Pc_DefinePIS(Pc_Imposto:TImposto);
    Procedure Pc_DefineCOFINS(Pc_Imposto:TImposto);
    Procedure Pc_DefineISSQN(Pc_Imposto:TImposto);

    Procedure Pc_DefineIBSCBS(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCBS_IBS_Base(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCBS_IBS_Valor(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCBS_IBS_UF(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCBS_IBS_MUN(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCBS_CBS(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCBS_Tribregular(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCredPres(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineCBSCredPres(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineTribCompraGov(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefineIBSCBSMono(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_DefinegTransfCred(Pc_Prod:TProd;Pc_Imposto:TImposto);

    Procedure Pc_DefineISel(Pc_Imposto:TImposto);

    Procedure Pc_SomaValorBaseICMS(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorICMS(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorBaseICMSST(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorICMSST(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorProduto(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorFrete(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorSeguro(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorDesconto(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorII (Pc_Nfe:TNFe);
    Procedure Pc_SomaValorIPI(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorPIS (Pc_Nfe:TNFe);
    Procedure Pc_SomaValorCFS(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorOutros(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorISSQN(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorAproximImposto(Pc_Nfe:TNFe);
    Procedure Pc_SomaValorTotalNota(Pc_Nfe:TNFe);
    procedure Pc_SomaValorIBSCBS(Pc_Nfe:TNFe);
    procedure Pc_DadosdoTransporte(Pc_Nfe:TNFe);



    procedure Pc_Busca_Obs(Fc_Grupo:String);
    Procedure Pc_Obs_Regra_Geral;
    procedure Pc_Obs_CST00;
    procedure Pc_Obs_CST10;
    procedure Pc_Obs_CST20;
    procedure Pc_Obs_CST30;
    procedure Pc_Obs_CST40;
    procedure Pc_Obs_CST50;
    procedure Pc_Obs_CST60;
    procedure Pc_Obs_CST70;
    procedure Pc_Obs_CST80;
    procedure Pc_Obs_CST90;
    procedure Pc_Obs_CSOSN101;
    procedure Pc_Obs_CSOSN102;
    procedure Pc_Obs_CSOSN103;
    procedure Pc_Obs_CSOSN201;
    procedure Pc_Obs_CSOSN202;
    procedure Pc_Obs_CSOSN203;
    procedure Pc_Obs_CSOSN300;
    procedure Pc_Obs_CSOSN400;
    procedure Pc_Obs_CSOSN500;
    procedure Pc_Obs_CSOSN900;
    procedure Pc_Obs_ISSQN;
    procedure Fc_Obs_ImpostoAproximado;
    procedure Pc_InfoRevendaVeiculos(Pc_Lista: TMemo;Pc_Cd_Pedido:integer);
    procedure Pc_AtualizarItensNota;
    procedure Pc_AtualizarItensICMS(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizarItensIPI(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizarItensPIS(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizarItensCOFINS(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizarItensISSQN(Pc_Item:TDetCollectionItem);
    procedure Pc_ControleRastreioICMSST(Pc_Item:TDetCollectionItem);

    procedure Pc_AtualizaIBSCBS(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizaIBSCBS_IBS(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizaIBSCBS_IBS_UF(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizaIBSCBS_IBS_MUN(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizaIBSCBS_CBS(Pc_Item:TDetCollectionItem);
    procedure Pc_AtualizaIBSCBS_Tribregular(Pc_Item:TDetCollectionItem);
  protected
    { Protected declarations }
    //ICMS ST
    MargemValorAgregado : Real;
    FNaoUtilizarCodigoBarras : Boolean;
    It_aliq_Interna_ST_Icms : Real;
    It_aliq_Interna_NR_Icms : Real;
    It_Tx_Imp_Aprox: TStringList;
    //Variveis para Calculo de tributação do ISS
    It_CODTRIBUT : String;
    It_CODSRV116 : String;
    It_AQ_NR_ISS : Real;
    //Controle de Mensagens
    It_M_Fisco : TStringList;
    //Controla a Mensagem especifica para a Retenção da ST
    It_M_REtencaoST : TStringList;
    //Codigo de Beneficio Fiscal;
    It_M_CodBeficioFiscal : TStringList;
    //codigo do Regime Tributario

    //Verifica se é usuario de Nfe
    It_Usa_Nfe : Boolean;
    //Casas decimais
    It_Casa_Decimal : Integer;

    FIpiDevol : TControllerDevolIPI;
    FTaxes : TControllerTaxes;

    // Valor líquido do item: (VL_UNIT × QTDE) - DESC
    // Calculado uma única vez por item e compartilhado por todas as funções
    // de cálculo de base de ICMS / ICMS-ST do item corrente.
    //--------------------------------------------------------------------------------------------------------------------------------------
    FValorMercadoria : Real;
    procedure CalculaValorMercadoria;
    //--------------------------------------------------------------------------------------------------------------------------------------

    procedure Pc_Abrir_Aliquota_UF_ST(codiogNCM:String);
    procedure Pc_Aliquota_UF_ST;
    procedure Pc_Aliquota_UF_NR;

    function Fc_Valida_Itens_Nota():Boolean;
    function Fc_Valida_CNPJ (Fc_Numero,Fc_Tipo : string) : Boolean;
    function Fc_Valida_CPF (Fc_Numero,Fc_Tipo : string) : Boolean;
    function Fc_Valida_Insc_Estadual(Fc_Numero,Fc_Estado,Fc_Tipo:String): Boolean;
    function Fc_Valida_Dados_Emitente_NFE(): Boolean;
    function Fc_Valida_Dados_Destinatario_NFE(): Boolean;
    Function Fc_ValidaCep(Fc_cep:String):Boolean;
    procedure Pc_DefineCasaDecimal;
    function Fc_Tb_Geral(Fc_CAmpo: string; Fc_Conteudo: string): string;
    Function VerificaBeneficioICMS():Boolean;
  public
    { Public declarations }
    It_Cd_CFOP : iNTEGER;
    It_Cd_Natureza : Integer;
    NotaFiscal : TControllerNotaFiscal;
    Produto : TControllerProduto;
    ICMSFCP :TControllerIcmsFCP;
    TributacaoDireta : TControllerItensNFLTributacao;

    Estabelecimento : TControllerEstabelecimento;
    Config : TControllerGeral;

    ST_Retido : TControllerCtrlIcmsST;
    CodBenef : TControllerProductUfBenef;

    Qr_ItensPedido : TSTQuery;
    Qr_Tributacao : TSTQuery;
    Qr_Uf_Mva_NCM : TSTQuery;
    Qr_Uf_ICMS_NR : TSTQuery;
    Qr_Uf_FCP_NCM : TSTQuery;
    Qr_Observacao : TSTQuery;

    It_Nfe: TACBrNFe;
    //Informa o banco de dados
    It_Tipo_OPer : String;
    It_Sentido : String;
    It_RevendaCarro : boolean;
    It_NatCFOP : String;
    It_Nf_conjugada : Boolean;
    It_ECF : Boolean;
    It_ValidaListaNCM : Boolean;

    //ICMS Permissão de Credito Simples Nacional
    It_Aq_Cred_Icms : REal;
    It_Contribuinte_ICMS : boolean;
    //Variveis para Calcular o Sub. tributaria
    It_Subst_Tributario : Boolean;

    //Repassados da Interface
    It_Decreto108352014 : Boolean;
    it_SomaIPI_Bs_ICMS : Boolean;
    It_SomaIPI_Bs_ICMS_St : Boolean;
    UtilizarMvaOrginal : Boolean;
    It_SomaICMSNaNota : Boolean;
    It_AutorizacaoNFE : Boolean;
    It_AutorizacaoNFCE : Boolean;
    It_AutorizacaoNFSE : Boolean;
    It_Dist_Icms_NR : Boolean;
    It_Dist_Icms_ST : Boolean;
    It_Dist_IPI : Boolean;
    It_Qt_Produto:REal;
    It_Especie : String;
    It_Marca : String;
    It_PesoBruto : String;
    It_PesoLiquido : String;
    It_Volume : String;
    It_PlacaVeiculo : String;
    It_Uf_Veiculo : String;
    It_RNTC  : String;
    It_Despachar : String;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Fc_tributacao():boolean;
    function Fc_DefineTributacao():Integer;

    procedure Pc_Gera_NotaFiscal;
    procedure Pc_AtualizarItens;

    procedure Pc_Obs_NotaFiscal(Pc_Obs:TMemo);
    procedure Pc_Obs_NFC_E(Pc_Obs:String);
    procedure Pc_Obs_NF_Servico(Pc_Obs:TMemo);
    procedure CriaSqlTributacao(RegraDireta:Boolean);
    procedure Pc_CriaConsultas;

    procedure Pc_Pedido;
    procedure AbrirITens;
    function Fc_Valida():Boolean;
    function Fc_ValidaUsoNCM():Boolean;
    procedure Pc_CalculaIcmsRegra(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_InformaIcmsManual(Pc_Prod:TProd;Pc_Imposto:TImposto);
    procedure Pc_PreencheDadosDanfe;

  published
    { Published declarations }
    //Informa o banco de dados
  end;

procedure Register;

implementation

uses     DB, DateUtils, Un_Funcoes, un_Padrao, env;
procedure Register;
begin
  RegisterComponents('Setes', [ttributacao]);
end;

procedure ttributacao.CalculaValorMercadoria;
begin
  FValorMercadoria := (Qr_ItensPedido.FieldByName('ITF_VL_UNIT').AsCurrency
                       * Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat)
                       - Qr_ItensPedido.FieldByName('ITF_VL_DESC').AsCurrency;
end;

procedure ttributacao.CalculoFundoCombatePobreza(Pc_Prod:TProd;Pc_Imposto: TImposto);
Var
  LcAliqFcp : Real;
  Lc_Ok : Boolean;
begin
  with Pc_Imposto do
  Begin
    //ICMS FCP
    ICMS.vBCFCP      := 0;

    ICMS.pFCP        := 0;
    ICMS.vFCP        := 0;
    ICMS.vBCFCPST    := 0;
    ICMS.pFCPST      := 0;
    ICMS.vFCPST      := 0;
    ICMS.pST         := 0;
    ICMS.vBCFCPSTRet := 0;
    ICMS.pFCPSTRet   := 0;
    ICMS.vFCPSTRet   := 0;

    LcAliqFcp := tributaFCP(Qr_ItensPedido.FieldByname('PRO_CODIGONCM').AsString);

    if ( LcAliqFcp > 0 ) then

    Begin

      if ( ( It_Nfe.NotasFiscais[0].NFe.Ide.idDest = doInterna             )   and
           ( NotaFiscal.Pedido.Empresa.Registro.ConsumidorFinal = 'S'        )   and
           ( Qr_ItensPedido.FieldByname('PRO_SUB_TRIB').AsString = 'N'     ) ) or

         ( ( Qr_ItensPedido.FieldByname('PRO_SUB_TRIB').AsString = 'S'     )   and
           ( It_Nfe.NotasFiscais[0].NFe.Ide.idDest = doInterna             ) )  or

         ( ( It_Nfe.NotasFiscais[0].NFe.Ide.idDest = doInterestadual       )   and
           ( NotaFiscal.Pedido.Empresa.Registro.ConsumidorFinal = 'S'        )   and
           ( It_Nfe.NotasFiscais[0].NFe.Dest.indIEDest = inNaoContribuinte ) ) then
      Begin
        icms.CST    := StrToCSTICMS(Qr_Tributacao.FieldByName('CST_ICMS').AsString);
        icms.CSOSN  := StrToCSOSNIcms
        (Qr_Tributacao.FieldByName('CSOSN_ICMS').AsString);


        if (icms.CST = cst00) or
           (icms.CST = cst10) or
           (icms.CST = cst20) or
           (icms.CST = cst51) or
           (icms.CST = cst70) or
           (icms.CST = cst90) or
           ( icms.CSOSN = csosn101 ) or
           ( icms.CSOSN = csosn102 ) or
           ( icms.CSOSN = csosn103 ) or
           ( icms.CSOSN = csosn900 ) then
        Begin
          //fundo de combate a probreza - ICMS
          ICMS.vBCFCP   :=  FValorMercadoria;
          ICMS.vBCFCP   :=  RoundTo(ICMS.vBCFCP,-2);
          ICMS.pFCP     := LcAliqFcp;
          ICMS.vFCP     := (ICMS.vBCFCP *  (ICMS.pFCP / 100) );
          ICMS.vFCP     := roundTo(ICMS.vFCP,-2);
        end;
        if ( Qr_ItensPedido.FieldByname('PRO_SUB_TRIB').AsString = 'S'     ) then
        Begin
          if ( icms.CST   = cst10    ) or
             ( icms.CST   = cst30    ) or
             ( icms.CST   = cst70    ) or
             ( icms.CST   = cst90    ) or
             ( icms.CSOSN = csosn201 ) or
             ( icms.CSOSN = csosn202 ) or
             ( icms.CSOSN = csosn203 ) or
             ( icms.CSOSN = csosn900 ) then
          begin
            //fundo de combate a probreza - Mesma base do ICMS ST
            ICMS.vBCFCPST := FValorMercadoria;
            ICMS.vBCFCPST := ICMS.vBCFCPST + Pc_Imposto.IPI.vIPI +  Pc_Prod.vFrete;// + Pc_Prod.vSeg + Pc_Prod.vOutro ;
            ICMS.vBCFCPST :=  ICMS.vBCFCPST * MargemValorAgregado;
            ICMS.vBCFCPST :=  RoundTo(ICMS.vBCFCPST,-2);
            ICMS.pFCPST   :=  LcAliqFcp;
            ICMS.vFCPST   :=  (ICMS.vBCFCPST *  (ICMS.pFCPST / 100) );
            ICMS.vFCPST   :=  roundTo(ICMS.vFCPST,-2);
          End;
          if ( icms.CST   = cst60    ) or
             ( icms.CSOSN = csosn500 ) then
          begin
            ICMS.vBCFCPSTRet := 0;
            ICMS.pFCPSTRet   := 0;
            ICMS.vFCPSTRet   := 0;
          end;
        End;
      End;
    End;
  End;
end;

constructor ttributacao.Create(AOwner: TComponent);
begin
  inherited;
  Estabelecimento := TControllerEstabelecimento.create(Self);

  Config := TControllerGeral.create(Self);

  NotaFiscal := TControllerNotaFiscal.Create(Self);

  TributacaoDireta := TControllerItensNFLTributacao.Create(Self);

  Produto := TControllerProduto.Create(Self);

  ICMSFCP := TControllerIcmsFCP.Create(Self);

  ST_Retido := TControllerCtrlIcmsST.Create(Self);

  CodBenef := TControllerProductUfBenef.Create(Self);

  FIpiDevol := TControllerDevolIPI.Create(Self);

  Qr_ItensPedido := NotaFiscal.GeraQuery;
  Qr_Tributacao := NotaFiscal.GeraQuery;
  Qr_Uf_Mva_NCM := NotaFiscal.GeraQuery;
  Qr_Uf_ICMS_NR := NotaFiscal.GeraQuery;
  Qr_Uf_FCP_NCM:= NotaFiscal.GeraQuery;
  Qr_Observacao := NotaFiscal.GeraQuery;

  //Nota Fiscal
  It_Nfe := TACBrNFe.Create(nil);
  It_Nfe.NotasFiscais.Clear;
  It_Nfe.NotasFiscais.Add;
  //Cria o Controle Fiscal Memo
  It_M_Fisco := TStringList.Create();
  It_M_REtencaoST := TStringList.Create();
  It_M_CodBeficioFiscal := TStringList.Create();
  It_Tx_Imp_Aprox := TStringList.Create;

  FTaxes  := TControllerTaxes.create(Self);

  {Receita desativou por enquanto -  07/05/2019
    verificar o objeto CtrlIcmsST que com o disposeof em dois lugares  - ver passagem por referenia}

end;

destructor ttributacao.Destroy;
begin
  NotaFiscal.FinalizaQuery(Qr_ItensPedido);
  NotaFiscal.FinalizaQuery(Qr_Tributacao);
  NotaFiscal.FinalizaQuery(Qr_Uf_Mva_NCM);
  NotaFiscal.FinalizaQuery(Qr_Uf_ICMS_NR);
  NotaFiscal.FinalizaQuery(Qr_Uf_FCP_NCM);
  NotaFiscal.FinalizaQuery(Qr_Observacao);

  FreeAndNil( Estabelecimento );
  FreeAndNil( NotaFiscal );
  FreeAndNil( Config );
  FreeAndNil( It_Nfe );
  FreeAndNil( It_M_Fisco );
  FreeAndNil( It_M_REtencaoST );
  FreeAndNil( It_M_CodBeficioFiscal );
  FreeAndNil( It_Tx_Imp_Aprox );
  FreeAndNil( TributacaoDireta );
  FreeAndNil( Produto );
  FreeAndNil( ICMSFCP );
  FreeAndNil( ST_Retido );
  FreeAndNil( CodBenef );
  FreeAndNil( FIpiDevol );
  FreeAndNil( FTaxes );
  inherited;
end;

procedure ttributacao.CriaSqlTributacao(RegraDireta:Boolean);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_Tributacao do
  Begin
    //CachedUpdates := True;
    close;
    Sql.Clear;
    Sql.add('select TRB_CODIGO '+
            ',TRB_CODPRO '+
            ',TRB_CODEMP '+
            ',TRB_ORIGEM '+
            ',tb_trib_icms_nr.tbi_grupo CST_ICMS '+
            ',tb_trib_icms_nr.tbi_codigo cst_CODIGO '+
            ',tb_mod_det_bc_icms.MDB_GRUPO MODAL_ICMS_NR '+
            ',tb_trib_icms_sn.tbi_grupo CSOSN_ICMS '+
            ',tb_trib_icms_sn.tbi_CODIGO CSOSN_CODIGO '+
            ',tb_mod_det_bc_icms_ST.MDB_GRUPO MODAL_ICMS_ST '+
            ',TRB_CODDSI_ICMS '+
            ',TRB_AQ_ICMS '+
            ',TRB_RD_AQ_ICMS '+
            ',TRB_RD_BS_ICMS '+
            ',tb_trib_ipi.tbi_grupo CST_IPI '+
            ',tb_trib_ipi.tbi_CODIGO CST_CODIGO_IPI '+
            ',TRB_AQ_IPI '+
            ',tb_trib_pis.tbp_grupo CST_PIS '+
            ',tb_trib_pis.tbp_CODIGO CST_CODIGO_PIS '+
            ',TRB_AQ_PIS '+
            ',tb_trib_cfs.tbc_grupo CST_COFINS '+
            ',tb_trib_cfs.tbc_CODIGO CST_CODIGO_CFS '+
            ',TRB_AQ_COFINS '+
            ',TRB_AQ_IRPJ '+
            ',TRB_AQ_CSLL '+
            ',TRB_AQ_SISCOMEX '+
            ',TRB_AQ_II '+
            ',TRB_ST_ICMS '+
            ',TRB_CONSUMIDOR '+
            ',TRB_MICRO '+
            ',TRB_DIFERIDO '+
            ',TRB_DESTAQUE '+
            ',TRB_CODOBS '+
            ',TRB_CODNAT '+
            ',TRB_ESTADO '+
            ',TRB_CODMHA '+
            ',TRB_SUB_TRI '+
            ',NAT_CODIGO '+
            ',NAT_DESCRICAO '+
            ',TRB_AQ_ISS '+
            ',NAT_CFOP '+
            ',NAT_RESUMIDO '+
            ',TRB_CODIGONCM '+
            ',TRB_RD_BS_ICMS_ST '+
            ',TRB_PRODUTO '+
            ',TRB_SENTIDO '+
            ',TRB_AQ_DIF '+
            ',TB_TAXES_ID '+
            'from "TB_TRIBUTACAO" '+
            '    INNER JOIN TB_NATUREZA nat '+
            '    ON (nat.NAT_CODIGO = TRB_CODNAT) '+
            '    LEFT outer JOIN tb_trib_icms_nr '+
            '    ON (tb_trib_icms_nr.tbi_codigo = tb_tributacao.trb_codtbi_icms_nr) '+
            '    LEFT outer JOIN tb_trib_icms_sn '+
            '    ON (tb_trib_icms_sn.tbi_codigo = tb_tributacao.trb_codtbi_icms_sn) '+
            '    LEFT outer JOIN tb_trib_ipi '+
            '    ON (tb_trib_ipi.tbi_codigo = tb_tributacao.trb_codtbi_ipi) '+
            '    LEFT outer JOIN tb_trib_pis '+
            '    ON (tb_trib_pis.tbp_codigo = tb_tributacao.trb_codtbi_pis) '+
            '    LEFT outer JOIN tb_trib_cfs '+
            '    ON (tb_trib_cfs.tbc_codigo = tb_tributacao.trb_codtbi_cfs) '+
            '    LEFT outer JOIN tb_mod_det_bc_icms '+
            '    ON (tb_mod_det_bc_icms.mdb_codigo = tb_tributacao.TRB_CODMDB_ICMS_NR) '+
            '    LEFT outer JOIN tb_mod_det_bc_icms_st '+
            '    ON (tb_mod_det_bc_icms_st.mdb_codigo = tb_tributacao.trb_codmdb_icms_st) ');
     if RegraDireta then
     Begin
       Sql.add('WHERE ( TRB_CODIGO =:TRB_CODIGO ) ');
     End
     else
     Begin
       Sql.add('WHERE   ( ( TRB_CODPRO =:TRB_CODPRO ) OR ( TRB_CODPRO = 0 ) ) '+
               ' AND ( ( TRB_CODEMP =:TRB_CODEMP ) OR ( TRB_CODEMP = 0 ) )    '+
               '   AND ( ( TRB_CODIGONCM =:TRB_CODIGONCM) OR (TRB_CODIGONCM IS NULL) OR (TRB_CODIGONCM = '''') ) '+
               '   AND   ( TRB_ORIGEM =:TRB_ORIGEM ) '+
               '   AND   ( TRB_ST_ICMS = :TRB_ST_ICMS ) '+
               '   AND   ( TRB_CONSUMIDOR =:TRB_CONSUMIDOR ) '+
               '   AND   ( TRB_MICRO =:TRB_MICRO ) '+
               '   AND   ( TRB_CODMHA=:TRB_CODMHA ) '+
               '   AND   ( NAT_SENTIDO =:NAT_SENTIDO ) '+
               '   AND   ( TRB_PRODUTO =:TRB_PRODUTO) ');
      if It_Cd_Natureza > 0 then
        Sql.add(' AND  ( NAT_CODIGO =:NAT_CODIGO )' );


      if ( NotaFiscal.Pedido.Empresa.Endereco.Registro.CodigoEstado = Estabelecimento.Endereco.Registro.CodigoEstado ) then
        Sql.add(' AND (TRB_ESTADO =:TRB_ESTADO) ')
      else
        Sql.add(' AND ( (TRB_ESTADO =:TRB_ESTADO) or (TRB_ESTADO = 0) OR (TRB_ESTADO IS NULL) ) ');
      Sql.add(' Order By TRB_CODIGONCM DESC ');
     End;
  end;
end;

function ttributacao.Fc_Tb_Geral(Fc_CAmpo: string; Fc_Conteudo: string): string;
begin
  Config.clear;
  Config.Registro.CodigoEstabelecimento := Estabelecimento.Registro.Codigo;
  Config.Registro.Campo := Fc_CAmpo;
  Config.Registro.Conteudo := Fc_Conteudo;
  Config.getById;
  if not Config.exist then Config.salva;
  Result := Config.Registro.Conteudo;
end;

Function ttributacao.VerificaBeneficioICMS():Boolean;
Begin
  Result := False;
  if Qr_Tributacao.RecordCount > 0 then
  Begin
    if ( Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency > 0 ) or
       ( Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency > 0 ) then
    Begin
      Result := True;
    End;
  End;
End;

procedure ttributacao.Pc_CriaConsultas;
Var
  Lc_SqlTxt : String;
Begin
  Estabelecimento.getAll;
  NotaFiscal.Pedido.getAll;

  with Qr_Uf_Mva_NCM do
  Begin
    close;
    Sql.Clear;
    Sql.Add(concat(
            'SELECT UFE_CODIGO,  MUN_ALIQ_INTERNA, MUN_CODIGONCM, ',
            'MUN_MR_VL_AGREGADO,UFE_SIGLA,MUN_MVA_AJUSTADO ',
            'FROM TB_UF ',
            '  INNER JOIN TB_MVA_UF_NCM ',
            '  ON (MUN_CODUFE = UFE_CODIGO) ',
            'WHERE ( UFE_CODIGO=:UFE_CODIGO )  ',
            ' AND  ( MUN_CODMHA=:MUN_CODMHA ) ',
            ' AND  ( MUN_CODIGONCM=:MUN_CODIGONCM ) ',
            'Order By UFE_SIGLA '
            ));
  end;
  //Verifica as aliquotas interna dos proprio estado

  with Qr_Uf_ICMS_NR do
  Begin
    close;
    Sql.Clear;
    Sql.Add('SELECT UFE_CODIGO,MUN_CODIGONCM, MUN_ALIQ_INTERNA '+
            'FROM TB_UF '+
            '  INNER JOIN TB_MVA_UF_NCM '+
            '  ON (MUN_CODUFE = UFE_CODIGO) '+
            'WHERE UFE_CODIGO=:UFE_CODIGO '+
            ' AND (MUN_CODIGONCM =:MUN_CODIGONCM) OR ( (MUN_CODUFE=:UFE_CODIGO) AND (MUN_CODMHA=:MUN_CODMHA) )'+
            'Order By UFE_SIGLA ');
  end;
  //Selecio a lista de Aliquotas do estado para o FCP
  with Qr_Uf_FCP_NCM do
  Begin
    close;
    Sql.Clear;
    sql.Add(concat(
             'SELECT NCM, ALIQUOTA ',
             'FROM TB_FCP_UF_NCM ',
             'WHERE ( TB_STATE_ID=:TB_STATE_ID ) ',
             'ORDER BY NCM '
    ));
  End;

  //Seleciona a Observação que vai na nota

  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    Sql.Add('select distinct  '+
            '  OBS_DETALHES   '+
            'FROM TB_ITENS_ICMS '+
            '  INNER JOIN TB_TRIB_ICMS_NR '+
            '  ON (TBI_CODIGO = ICM_CODTBI_NR) '+
            '  INNER JOIN TB_OBSERVACAO '+
            '  ON (OBS_CODIGO = ICM_CODOBS) '+
            'WHERE (ICM_CODNFL=:NFL_CODIGO)'+
            ' AND (OBS_CODMHA =:OBS_CODMHA) '+
            ' AND (TBI_GRUPO Like :TBI_GRUPO)');
  end;
  //Seleciona os dados do Pedido -- Usando controller

  //Seleciona os dados dos Itens do  Pedido

  with Qr_ItensPedido do
  Begin
    close;
    Sql.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT '+
                  '  PED_TIPO, '+
                  '  ITF_CODIGO, '+
                  '  ITF_CODPED, '+
                  '  PRO_CODIGOFAB, '+
                  '  PRO_CODIGOBAR, '+
                  '  PRO_CODIGOFOR, '+
                  '  PRO_CODIGONCM, '+
                  '  PRO_CEST, '+
                  '  PRO_ORIGEM, '+
                  '  PRO_DESCRICAO, '+
                  '  MED_ABREVIATURA, '+
                  '  ITF_QTDE, '+
                  '  ITF_VL_UNIT, '+
                  '  ITF_VL_CUSTO, '+
                  '  ITF_CODPRO, '+
                  '  (ITF_QTDE* ITF_VL_UNIT) ITF_VL_SB_TOTAL, '+
                  '  ITF_VL_DESC, '+
                  '  ITF_AQ_DESC, '+
                  '  ITF_AQ_COM, '+
                  '  ITF_ESTOQUE, '+
                  '  ITF_AQ_IPI, '+
                  '  ITF_AQ_ICMS, '+
                  '  ITF_CODEST, '+
                  '  ITF_CODTPR, '+
                  '  ITF_COMPRA, '+
                  '  ITF_ITEM_COMPRA, '+
                  '  PRO_DETALHES, '+
                  '  PRO_TIPO, '+
                  '  ITF_OPER, '+
                  '  ITF_IMP_APROX, '+
                  '  PRO_SUB_TRIB, '+
                  '  PRO_TRIBUTACAO, '+
                  '  PRO_VL_CUSTOMED, '+
                  '  ITF_DESPACHO, '+
                  '  PRO_SERIE, '+
                  '  PRO_EST_NEG, '+
                  '  SRP.* '+
                  'FROM TB_ITENS_NFL INF '+
                  '   INNER JOIN TB_PEDIDO '+
                  '   ON (PED_CODIGO = ITF_CODPED) '+
                  '   INNER JOIN TB_PRODUTO PRO '+
                  '   ON  (PRO.PRO_CODIGO = INF.ITF_CODPRO) '+
                  '   INNER JOIN TB_MEDIDA MED '+
                  '   ON  (MED.MED_CODIGO = PRO.PRO_CODMED) '+
                  '   LEFT OUTER JOIN TB_SERIE_PRODUTO SRP '+
                  '   ON  (SRP.SRP_CODSAI = INF.ITF_CODNFL) '+
                  'WHERE (ITF_CODPED=:PED_CODIGO) AND (ITF_OPER <> ''D'') AND (ITF_OPER <> ''T'') ';

    //Este componenente vai fazer todo o calculo com produtos e serviços
    //Vou alterar somente no momento de fazer o xml para enviar para a receita
    if It_ECF then
    Begin
      if ( Fc_Tb_Geral('OSR_G_SERVICO_ECF','S') = 'N') then
        Lc_SqlTxt:=Lc_SqlTxt+ ' AND (PRO_TIPO <> ''S'') ';
    end;

    Sql.Add(Lc_SqlTxt);
    ParamByName('PED_CODIGO').AsInteger := NotaFiscal.Registro.CodigoPedido;
  end;

end;

procedure ttributacao.Pc_Aliquota_UF_ST();
Var
  Lc_aliq_Interna_NR_Icms : Real;
  Lc_aliq_Interna_ST_Icms : Real;
begin
  Pc_Abrir_Aliquota_UF_ST(Qr_ItensPedido.FieldByName('PRO_CODIGONCM').AsString);

  It_aliq_Interna_ST_Icms := Qr_Uf_Mva_NCM.FieldByName('MUN_ALIQ_INTERNA').AsFloat;
  //Verifica se precisamos pegar o MVA de um NCM especifico
  MargemValorAgregado := Qr_Uf_Mva_NCM.FieldByName('MUN_MR_VL_AGREGADO').AsCurrency;
  if (Qr_Uf_Mva_NCM.FieldByName('MUN_ALIQ_INTERNA').AsFloat > 0) then
    It_aliq_Interna_St_Icms := Qr_Uf_Mva_NCM.FieldByName('MUN_ALIQ_INTERNA').AsFloat;

  if not UtilizarMvaOrginal then
  Begin
    Lc_aliq_Interna_NR_Icms := It_aliq_Interna_NR_Icms;
    Lc_aliq_Interna_ST_Icms := It_aliq_Interna_ST_Icms;
    MargemValorAgregado := 0;
    if (Qr_Tributacao.Active ) then
    Begin
      //Margem de Valor Agregado
      //Observar não so as aliquotas mas a carga tributaria real do ICMS Próprio e o ICMS do Destino
      Lc_aliq_Interna_NR_Icms := (It_aliq_Interna_NR_Icms - ( (It_aliq_Interna_NR_Icms * Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency)/100) );
      Lc_aliq_Interna_NR_Icms := RoundTO(Lc_aliq_Interna_NR_Icms,-2);
      //Verifica se a redução da base será propagada para o calculo da base da ST
      if (Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS_ST').AsString = 'S') then
      Begin
        Lc_aliq_Interna_ST_Icms := (It_aliq_Interna_ST_Icms - ( (It_aliq_Interna_ST_Icms * Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency)/100) );
        Lc_aliq_Interna_ST_Icms := RoundTO(Lc_aliq_Interna_ST_Icms,-2);
      End;
      //MVA ajustada = [(1+ MVA ST original) x (1 - ALQ inter) / (1- ALQ intra)] -1
      //TRansformada no Excel =((B8 * (1-C8)) / (1-D8))
      MargemValorAgregado := Qr_Uf_Mva_NCM.FieldByName('MUN_MR_VL_AGREGADO').AsCurrency;
      MargemValorAgregado := ( ( MargemValorAgregado * (100 - Lc_aliq_Interna_NR_Icms)) / (100 - Lc_aliq_Interna_ST_Icms)) ;
      MargemValorAgregado := RoundTO(MargemValorAgregado,-4);
    End;
  End;
  //Caso seja empesa optante pelo Simples deixar 50% da aliquota
  if NotaFiscal.Pedido.Empresa.Registro.OptantePeloSimples = 'S' then
  Begin
    if (MargemValorAgregado > 0) then
    Begin
      if (Fc_Tb_Geral('GRL_G_DECRETO108352014','N') = 'S') then
      Begin
        //Verifica se o Estado é de Santa Catarina
        if (Qr_Uf_Mva_NCM.FieldByName('UFE_SIGLA').AsString = 'SC') then
        Begin
          MargemValorAgregado := ((MargemValorAgregado - 1) * 0.3) + 1;
        end
        else
        Begin
          if (Lc_aliq_Interna_ST_Icms < 18) or (VerificaBeneficioICMS) then
          Begin
            MargemValorAgregado := ((MargemValorAgregado - 1) * 0.5) + 1;
          end
          else
          Begin
            MargemValorAgregado := ((MargemValorAgregado - 1) * 0.3) + 1;
          end;
        end;
      end;
    end;
  end;
end;

procedure ttributacao.Pc_Abrir_Aliquota_UF_ST(codiogNCM:String);
begin
  Qr_Uf_Mva_NCM.Active := False;
  Qr_Uf_Mva_NCM.ParamByName('UFE_CODIGO').AsInteger := NotaFiscal.Pedido.Empresa.Endereco.Registro.CodigoEstado;
  Qr_Uf_Mva_NCM.ParamByName('MUN_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
  Qr_Uf_Mva_NCM.ParamByName('MUN_CODIGONCM').AsString := codiogNCM;
  Qr_Uf_Mva_NCM.Active := True;
  Qr_Uf_Mva_NCM.First;
end;

procedure ttributacao.Pc_Aliquota_UF_NR;
Var
  LcCST_ST : Boolean;
begin
  //Verifica se o CST e de cobrança de ST por que precisamos da aliquota interna de ICMS para o Calculo do ICMS Proprio
  LcCST_ST := ( Qr_Tributacao.FieldByName('CSOSN_ICMS').AsString = '201' ) or
              ( Qr_Tributacao.FieldByName('CSOSN_ICMS').AsString = '202' ) or
              ( Qr_Tributacao.FieldByName('CSOSN_ICMS').AsString = '203' );



  if  ( ( It_aliq_Interna_NR_Icms = 0 ) and  LcCST_ST ) then
  Begin
    Qr_Uf_ICMS_NR.Active := False;
    Qr_Uf_ICMS_NR.ParamByName('UFE_CODIGO').AsInteger := Estabelecimento.Endereco.Registro.CodigoEstado;
    //estava usando o qr_pedido por conlifto entre estados, pelo pedido utilizo
    //Qr_Pedido.FieldByName('UFE_CODIGO').AsInteger;
    //Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsInteger;
    Qr_Uf_ICMS_NR.ParamByName('MUN_CODIGONCM').AsString := Qr_ItensPedido.FieldByName('PRO_CODIGONCM').AsString;
    Qr_Uf_ICMS_NR.ParamByName('MUN_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    Qr_Uf_ICMS_NR.Active := True;
    Qr_Uf_ICMS_NR.First;
    if Qr_Uf_ICMS_NR.RecordCount > 0 then
    Begin
      if (Qr_Uf_ICMS_NR.FieldByName('MUN_ALIQ_INTERNA').AsFloat > 0) then
        It_aliq_Interna_NR_Icms := Qr_Uf_ICMS_NR.FieldByName('MUN_ALIQ_INTERNA').AsFloat;
    end;
  end;
end;





procedure ttributacao.Pc_Pedido;
Begin
  AbrirITens;
end;

procedure ttributacao.AbrirITens;
BEgin
  Qr_ItensPedido.Active := False;
  Qr_ItensPedido.ParamByName('PED_CODIGO').AsInteger := NotaFiscal.Registro.CodigoPedido;
  Qr_ItensPedido.Active := True;
  Qr_ItensPedido.FetchAll;
end;

function ttributacao.Fc_tributacao():boolean;
Var
  Lc_Sub_Trib : String;
begin
  REsult := FAlse;
  //Verifica se é contribuinte do ICMS
  It_Contribuinte_ICMS := NotaFiscal.Pedido.Empresa.Registro.IndicadorInscricaoEstadual = '1';

  TributacaoDireta.Registro.ItemOrdem := Qr_ItensPedido.FieldByname('ITF_CODIGO').AsInteger;
  TributacaoDireta.getByKey;
  if TributacaoDireta.exist then
  BEgin
    CriaSqlTributacao(true);
    with Qr_Tributacao do
    Begin
      Active := False;
      ParamByName('TRB_CODIGO').AsInteger     := TributacaoDireta.Registro.Tributacao;
      Active := True;
      FetchAll;
      First;
      Result := (RecordCount > 0);
    End;
  end
  else
  Begin
    CriaSqlTributacao(false);
    //Busca a Tributação
    //Neste Momento o sistema verifica se o cliente ignorar a S.T do Produto
    Lc_Sub_Trib := Qr_ItensPedido.FieldByname('PRO_SUB_TRIB').AsString;
    if (Lc_Sub_Trib = 'S') then
    Begin
      if NotaFiscal.Pedido.Empresa.Registro.IgnorarCalculoST = 'S' then
        Lc_Sub_Trib :='N';
    end;

    with Qr_Tributacao do
    Begin
      Active := False;
      ParamByName('TRB_CODMHA').AsInteger     := NotaFiscal.Registro.CodigoEstabelecimento;
      ParamByName('TRB_CODPRO').AsInteger     := Qr_ItensPedido.FieldByname('ITF_CODPRO').AsInteger;
      ParamByName('TRB_CODEMP').AsInteger     := NotaFiscal.Pedido.Empresa.Registro.Codigo;
      ParamByName('TRB_CODIGONCM').AsString   := Qr_ItensPedido.FieldByname('PRO_CODIGONCM').AsString;
      ParamByName('TRB_ORIGEM').AsString      := Qr_ItensPedido.FieldByname('PRO_ORIGEM').AsString;
      ParamByName('NAT_SENTIDO').AsString     := It_Sentido;
      if It_Cd_Natureza > 0 then
      Begin
        //Por ser Ajuste de Estoque informar o CFOP e finalidade de tributação  =0
        ParamByName('NAT_CODIGO').AsInteger   := It_Cd_Natureza;
        ParamByName('TRB_PRODUTO').AsString   := '0';
      end
      else
      Begin
        ParamByName('TRB_PRODUTO').AsString   := Qr_ItensPedido.FieldByname('PRO_TRIBUTACAO').AsString;
      end;
      ParamByName('TRB_ST_ICMS').AsString     := Lc_Sub_Trib;
      //Se indicador de Presenca for 1 e o cliente for nao contribuinte, podemos fazer operacao de cliente domiciliado em outro estado para como operacao interna
      if ( NotaFiscal.Pedido.Registro.IndicaPresenca = 1 ) and
         ( ( NotaFiscal.Pedido.Empresa.Registro.IndicadorInscricaoEstadual = '1' ) or
           ( NotaFiscal.Pedido.Empresa.Registro.IndicadorInscricaoEstadual = '9' ) ) and
         ( NotaFiscal.Pedido.Empresa.Endereco.registro.CodigoEstado <> Estabelecimento.Endereco.Registro.CodigoEstado)  then
      Begin
        ParamByName('TRB_ESTADO').AsInteger     := Estabelecimento.Endereco.Registro.CodigoEstado;
      End
      else
      Begin
        ParamByName('TRB_ESTADO').AsInteger     := NotaFiscal.Pedido.Empresa.Endereco.registro.CodigoEstado;

      End;
      ParamByName('TRB_CONSUMIDOR').AsString  := NotaFiscal.Pedido.Empresa.Registro.ConsumidorFinal;
      ParamByName('TRB_MICRO').AsString       := NotaFiscal.Pedido.Empresa.Registro.OptantePeloSimples;

      Active := True;
      FetchAll;
      First;
      Result := (RecordCount > 0);
    End;
  end;
end;

function ttributacao.Fc_DefineTributacao():Integer;
Var
  Lc_Lista : Variant;
  Lc_Uf_Emissor : Integer;
Begin
  Result := 0;
  It_NatCFOP := '';
  if Qr_Tributacao.RecordCount > 1 then
  Begin
    if not (Qr_Tributacao.locate('TRB_CODEMP', NotaFiscal.Pedido.Empresa.Registro.Codigo, [])) then
    Begin
      Lc_Lista := VarArrayCreate([0, 1], varVariant);
      Lc_Lista[0] := NotaFiscal.Pedido.Endereco.Registro.CodigoEstado;
      Lc_Lista[1] := Qr_ItensPedido.FieldBYName('ITF_CODPRO').AsInteger;

      if not (Qr_Tributacao.locate('TRB_ESTADO;TRB_CODPRO', Lc_Lista, [])) then
        if not (Qr_Tributacao.locate('TRB_ESTADO', NotaFiscal.Pedido.Endereco.Registro.CodigoEstado, [])) then
          Qr_Tributacao.locate('TRB_CODPRO', NotaFiscal.Pedido.Endereco.Registro.CodigoEstado, []);
    End;
  end;
  if Qr_Tributacao.RecordCount > 0 then
  Begin
     //Define a aliquota de Tributação pela Regra
    It_aliq_Interna_NR_Icms := Qr_Tributacao.FieldByName('TRB_AQ_ICMS').AsCurrency;
    //Nesta função verificamos se o NCM tem uma aliquota interna diferente da definida na regra e trocamos
    Pc_Aliquota_UF_NR;
    Pc_Aliquota_UF_ST;
    //Se a pesquisa trazer um registro ainda assim precisamos saber se este registro
    //se refere ao estado do Paraná, caso contrario nega a regra.
    if (NotaFiscal.Pedido.Endereco.Registro.CodigoEstado = Estabelecimento.Endereco.Registro.CodigoEstado ) and
       (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger <> NotaFiscal.Pedido.Endereco.Registro.CodigoEstado) then
    Begin
      Result := -1;
      exit;
    end;
    //Variveis para Calculo de tributação do ICMS

    //Variveis para Calculo de tributação do ISS
    case StrToIntDef(Fc_Tb_Geral('OSR_G_NFSE_TRIB','0'),0) of
      0:It_CODTRIBUT := 'N';
      1:It_CODTRIBUT := 'S';
      2:It_CODTRIBUT := 'R';
      3:It_CODTRIBUT := 'I';
    end;
    It_CODSRV116 := Fc_Tb_Geral('OSR_G_NFSE_CL116','');
    It_AQ_NR_ISS := Qr_Tributacao.FieldByName('TRB_AQ_ISS').AsCurrency;
    //Define se a operação é como Substituto Tributario
    It_Subst_Tributario := (Qr_Tributacao.FieldByName('TRB_SUB_TRI').AsString = 'S');
    if not Qr_Tributacao.Active then Qr_Tributacao.Active := True;
    It_NatCFOP := Qr_Tributacao.FieldByName('NAT_CFOP').AsString;

  End;

end;

function ttributacao.Fc_Valida():Boolean;
BEgin
  Result := True;
  FNaoUtilizarCodigoBarras :=  ( Fc_Tb_Geral('NFE_SEM_CODIGO_BARRAS','N') = 'S' );
  Pc_Pedido;
  if (Estabelecimento.Registro.IndicadorInscricaoEstadual = '1') then
  Begin

    IF It_AutorizacaoNFE then
    Begin
      if NOT Fc_Valida_Dados_Emitente_NFE then
      Begin
        Result := False;
        exit;
      end;

      if not It_AutorizacaoNFCE then
      Begin
        if NOT Fc_Valida_Dados_Destinatario_NFE then
        Begin
          Result := False;
          exit;
        end;
      end;

      if NOT Fc_Valida_Itens_Nota then
      Begin
        Result := False;
        exit;
      end;

      if NOT Fc_ValidaUsoNCM then
      Begin
        Result := False;
        exit;
      end;
    end;
  End;
end;

procedure ttributacao.Pc_Gera_NotaFiscal;
begin
  with It_Nfe.NotasFiscais[0].NFe, NotaFiscal.Registro do
  Begin
    CodigoEstabelecimento := NotaFiscal.Registro.CodigoEstabelecimento;
    if It_Sentido = 'S' then
    Begin
      Tipo := 'SI';
    end
    else
    Begin
      if It_AutorizacaoNFE then
        Tipo := 'EI'
      else
        Tipo := 'EE';
    end;
//    Numero := StrZero(It_Nr_Nota, 6,0);
    //serie
    IF It_Usa_Nfe then
    Begin
      If (Estabelecimento.GetTipoEmissao = 2) then
        Serie := '900'
      else
        Serie := Fc_Tb_Geral('NFE_SERIE','1');
    end
    else
    Begin
      Serie := Fc_Tb_Geral('NFE_SERIE','1');
    end;
    if Trim(Serie) = '' then
      Serie := '1';

    CodigoPedido        := NotaFiscal.Registro.CodigoPedido;
    CodigoEmpresa       := NotaFiscal.Pedido.Registro.Empresa;
    HoraSaida           := time;
    ValorBaseICMS       := Total.ICMSTot.vBC;
    ValorICMS           := Total.ICMSTot.vICMS;
    ValorBaseICMSST     := Total.ICMSTot.vBCST;
    ValorICMSST         := Total.ICMSTot.vST;
    ValorProdutos       := Total.ICMSTot.vProd;
    ValorFrete          := Total.ICMSTot.vFrete;
    ValorSeguro         := Total.ICMSTot.vseg;
    ValorOutrasDespesas := Total.ICMSTot.vOutro;
    ValorIPI            := Total.ICMSTot.vIPI;
            {
            Total.ISTot.vIS := 100;

            Total.IBSCBSTot.vBCIBSCBS := 100;

            Total.IBSCBSTot.gIBS.vIBS := 100;
            Total.IBSCBSTot.gIBS.vCredPres := 100;
            Total.IBSCBSTot.gIBS.vCredPresCondSus := 100;

            Total.IBSCBSTot.gIBS.gIBSUFTot.vDif := 100;
            Total.IBSCBSTot.gIBS.gIBSUFTot.vDevTrib := 100;
            Total.IBSCBSTot.gIBS.gIBSUFTot.vIBSUF := 100;

            Total.IBSCBSTot.gIBS.gIBSMunTot.vDif := 100;
            Total.IBSCBSTot.gIBS.gIBSMunTot.vDevTrib := 100;
            Total.IBSCBSTot.gIBS.gIBSMunTot.vIBSMun := 100;

            Total.IBSCBSTot.gCBS.vDif := 100;
            Total.IBSCBSTot.gCBS.vDevTrib := 100;
            Total.IBSCBSTot.gCBS.vCBS := 100;
            Total.IBSCBSTot.gCBS.vCredPres := 100;
            Total.IBSCBSTot.gCBS.vCredPresCondSus := 100;

            Total.IBSCBSTot.gMono.vIBSMono := 100;
            Total.IBSCBSTot.gMono.vCBSMono := 100;
            Total.IBSCBSTot.gMono.vIBSMonoReten := 100;
            Total.IBSCBSTot.gMono.vCBSMonoReten := 100;
            Total.IBSCBSTot.gMono.vIBSMonoRet := 100;
            Total.IBSCBSTot.gMono.vCBSMonoRet := 100;

            // Valor total da NF-e com IBS / CBS / IS
            Total.vNFTot := 100;
            }

    //Soma o ICMS no valor total da Nota
    if It_SomaICMSNaNota then
      Total.ICMSTot.vNF := Total.ICMSTot.vNF + Total.ICMSTot.vICMS;
    ValorNota           := Total.ICMSTot.vNF;
    QtdeProdutos        := It_Qt_Produto;
    Especie             := It_Especie;
    Marca               := It_Marca;
    PesoBruto           := It_PesoBruto;
    PesoLiquido         := It_PesoLiquido;
    ControlaRetorno     := 'N';
    NotaVinculada       := '';
    Situacao            := 'F';
    ValorServico        := Total.ISSQNtot.vServ;
    ValorISS            := Total.ISSQNtot.vISS;
    NumeroVolume        := It_Volume;
    PlacaVeiculo        := It_PlacaVeiculo;
    EstadoVeiculo       := It_Uf_Veiculo;
    RNTC                := It_RNTC;
    CFOP                := CFOP;
    ValorISSRetido      := Total.ISSQNtot.vISSRet;
    if It_AutorizacaoNFCE then
      Modelo            := '65'
    else
      Modelo            := '55';
    CodigoCFOP          := It_Cd_CFOP;

    NotaFiscal.insere;
  end;
end;


function ttributacao.Fc_Valida_Itens_Nota():Boolean;
Var
  Lc_Tp_Cliente : String;
  Lc_Tp_tributa : String;
  Lc_Aux:String;
  Lc_ValidaEANGTIN : TACBrValidador;
  LcNatCompara : String;
  LCAchouTributacao : Boolean;
  LcChecaSTRET : Integer;
  LcSeq :Integer;
  CadFatCtrlIcmsST : TCadFatCtrlIcmsST;
  Lc_Produto : Integer;
Begin
  //valida Itens da Nota
  Result := true;
  It_M_Fisco.Clear;
  It_M_REtencaoST.Clear;
  It_M_CodBeficioFiscal.Clear;
  LcSeq := 0;
  CadFatCtrlIcmsST := TCadFatCtrlIcmsST.Create(nil);
  CadFatCtrlIcmsST.ResetCalculos;
  CadFatCtrlIcmsST.Estabelecimento := Estabelecimento.Registro.Codigo;
  if not Qr_ItensPedido.Active then Qr_ItensPedido.Active := True;
  with Qr_ItensPedido do
  Begin
    first;
    while not Eof do
    begin
      LCAchouTributacao := Fc_Tributacao;
      IF not LCAchouTributacao then
      Begin
        It_M_Fisco.Add(FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString);
        //Monta a mensagem para produtos com Substituição tributária
        if (FieldByName('PRO_SUB_TRIB').AsString <> 'S') then
          It_M_Fisco.Add('      ' + 'Este produto não está sob o regime de Substituição tributária.')
        else
          It_M_Fisco.Add('      ' + 'Este produto está sob o regime de Substituição tributária.');
        //Monta a Mensagem para a Finalidade de Tributação
        if Trim(FieldByName('PRO_TRIBUTACAO').AsString) = '' then
          It_M_Fisco.Add('      ' + 'Finalidade para a tributação não foi definido.')
        else
        Begin
          case StrToIntDef(FieldByName('PRO_TRIBUTACAO').AsString,0) of
            0:Lc_Tp_tributa := 'Não foi definido.';
            1:Lc_Tp_tributa := 'Revenda.';
            2:Lc_Tp_tributa := 'Produção.';
            3:Lc_Tp_tributa := 'Consignado.';
            4:Lc_Tp_tributa := 'Industrialização.';
            5:Lc_Tp_tributa := 'Consumo Interno.';
            6:Lc_Tp_tributa := 'Prestação de Serviço.';
          end;
          It_M_Fisco.Add('      ' + 'Finalidade para a tributação está como '+ Lc_Tp_tributa +'.');
        end;
        //Monta a Mensagem para a origem da Mercadoria
        case StrToIntDef(FieldByName('PRO_ORIGEM').AsString,0) of
          0:It_M_Fisco.Add('      ' + ' 0 - Nacional, exceto as indicadas nos igos 3, 4, 5 e 8.');
          1:It_M_Fisco.Add('      ' + ' 1 - Estrangeira - Importação direta, exceto a indicada no código 6.');
          2:It_M_Fisco.Add('      ' + ' 2 - Estrangeira - Adquirida no mercado interno, exceto a indicada no código 7.');
          3:It_M_Fisco.Add('      ' + ' 3 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 40% e inferior ou igual a 70%.');
          4:It_M_Fisco.Add('      ' + ' 4 - Nacional, cuja prod. tenha sido feita em conf. os proc. produtivos básicos conf as legislações citadas nos Ajustes.');
          5:It_M_Fisco.Add('      ' + ' 5 - Nacional, mercadoria ou bem com Conteúdo de Importação inferior ou igual a 40%.');
          6:It_M_Fisco.Add('      ' + ' 6 - Estrangeira - Importação direta, sem similar nacional,constante em lista da CAMEX e gás natural.');
          7:It_M_Fisco.Add('      ' + ' 7 - Estrangeira - Adquirida no mercado interno, sem similar nacional, constante lista CAMEX e gás natural.');
          8:It_M_Fisco.Add('      ' + ' 8 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 70%.');
        end;
        //Pede verificação do CFOP em Relação a operação
        It_M_Fisco.Add('');
        It_M_Fisco.Add('Verifique se o CFOP utilizado é o correto para operação de ' + Lc_Tp_tributa);
        It_M_Fisco.Add('Verifique se o CFOP utilizado é o correto para estado do ' + NotaFiscal.Pedido.Endereco.Uf.Registro.Sigla);
      end;
      {desenvolvido em 07/05 e em 08/05 a receita revogou a liberação
      ver prenchido da tag no preenchimentoDanfe  }
      IF LCAchouTributacao then
      Begin
        Fc_DefineTributacao;
        //******************************************************************************************************************
        //Verifica se os produtos tem ST retido para o caso de CSOSN500/CST60
        //if It_Contribuinte_ICMS then
        if Qr_Tributacao.FieldByName('TRB_PRODUTO').AsString <> '' then
          Lc_Produto := StrToIntDef(Trim(Qr_Tributacao.FieldByName('TRB_PRODUTO').AsString), 0)
        else
          Lc_Produto := 0;


        if (NotaFiscal.Pedido.Empresa.Registro.ConsumidorFinal <> 'S') and                                                //bonificação, se aparecer outros casos repensar
           ( (Lc_Produto > 0 ) or (Qr_Tributacao.FieldByName('NAT_CFOP').AsString = '5910') ) and
           (Qr_Tributacao.FieldByName('TRB_SENTIDO').AsString <> 'E' ) then
        Begin
          if (Qr_Tributacao.FieldByName('CST_ICMS').AsString = '60') or (Qr_Tributacao.FieldByName('CSOSN_ICMS').AsString = '500') then
          Begin
            //ICMS.orig já preenchido em outro local
            ST_Retido.Clear;
            ST_Retido.Registro.Estabelecimento := NotaFiscal.Registro.CodigoEstabelecimento;
            ST_Retido.Registro.Destino :=  FieldByName('ITF_CODIGO').AsInteger;
            ST_Retido.GetByDestino;
            if ( not ST_Retido.exist ) then
            Begin
              ST_Retido.Clear;
              ST_Retido.Registro.Estabelecimento := NotaFiscal.Registro.CodigoEstabelecimento;
              ST_Retido.Registro.Produto :=  FieldByName('ITF_CODPRO').AsInteger;
              LcChecaSTRET := ST_Retido.ChecarQtdeDisp;
              if (TRunc(FieldByName('ITF_QTDE').AsFloat)) > LcChecaSTRET then
              Begin
                It_M_REtencaoST.Add('Mostra');
                with CadFatCtrlIcmsST do
                Begin
                  cds_produtos.Append;
                  cds_produtosncm.AsString              := FieldByName('PRO_CODIGONCM').AsString;
                  cds_produtosPRO_CODIGO.AsInteger      := FieldByName('ITF_CODPRO').AsInteger;
                  cds_produtosPRO_DESCRICAO.AsString    := FieldByName('PRO_DESCRICAO').AsString;
                  cds_produtosVLVENDA.asfloat           := FValorMercadoria;
                  cds_produtosITF_DESTINO_ID.AsInteger  := FieldByName('ITF_CODIGO').AsInteger;
                  //cds_produtosMVA.AsFloat             := 0;
                  cds_produtosQTDE.AsInteger            := FieldByName('ITF_QTDE').AsInteger;
                  //cds_produtosVBCSTRET.AsFloat        := 0;
                  cds_produtos.Post;
                End;
              end;
            End;
          End;
        End;
        //****************************************************************************************************************
        //Verifica codigo de Beneficio fiscal  Se CST de ICMS = (20, 30, 40, 41, 50, 70 ou 90):
        if (Qr_Tributacao.FieldByName('CST_ICMS').AsString = '20') or
           (Qr_Tributacao.FieldByName('CST_ICMS').AsString = '30') or
           (Qr_Tributacao.FieldByName('CST_ICMS').AsString = '40') or
           (Qr_Tributacao.FieldByName('CST_ICMS').AsString = '50') or
           (Qr_Tributacao.FieldByName('CST_ICMS').AsString = '70') or
           ( (Qr_Tributacao.FieldByName('CST_ICMS').AsString = '90') AND
              VerificaBeneficioICMS ) then
        Begin
          CodBenef.Registro.Produto := FieldByName('ITF_CODPRO').AsInteger;
          CodBenef.Registro.Estado  :=  NotaFiscal.Pedido.Endereco.Uf.Registro.Sigla;
          CodBenef.Registro.CST     :=  Qr_Tributacao.FieldByName('CST_ICMS').AsString;
          CodBenef.getbyId;
          if not CodBenef.exist then
          Begin
              It_M_CodBeficioFiscal.Add(concat('CST: ',Qr_Tributacao.FieldByName('CST_ICMS').AsString,
                                               ' | PRODUTO: ', FieldByName('ITF_CODPRO').AsString, ' - ' , FieldByName('PRO_DESCRICAO').AsString));
          End
          Else
          Begin
            if Length( CodBenef.Registro.Beneficio ) < 8 then
              It_M_CodBeficioFiscal.Add(concat('TAMANHO CÓDIGO ERRADO | PRODUTO: ',
                                                FieldByName('ITF_CODPRO').AsString, ' - ' , FieldByName('PRO_DESCRICAO').AsString));

          End;
        End;
      End;
      Next;
    end;

    if (Length(It_M_Fisco.Text) >0 ) then
    Begin
      It_M_Fisco.Add('');
      It_M_Fisco.Add('Existe regra para estes critérios relacionado ao destinatário?');
      //Mostra o Estado do cliente
      It_M_Fisco.Add('       1º Para o estado do '+ NotaFiscal.Pedido.Endereco.Uf.Registro.Sigla);
      //Monta a mensagem para tipo do Cliente consumidor / Revenda
      if NotaFiscal.Pedido.Empresa.Registro.ConsumidorFinal = 'S' then
        Lc_Tp_Cliente := 'Consumidor'
      else
        Lc_Tp_Cliente := 'Revenda';
      It_M_Fisco.Add('       º Para destinatário do tipo ' + Lc_Tp_Cliente);

      //Monta a mensagem Cliente micro empresa ou não
      if NotaFiscal.Pedido.Empresa.Registro.OptantePeloSimples = 'S' then
        It_M_Fisco.Add('       3º Este destinatário está marcado como Optante pelo simples.')
      else
        It_M_Fisco.Add('       3º Este destinatário não está marcado como Optante pelo simples.');

      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Regra de Tributação não encontrada para os seguintes Produtos.' + EOLN + EOLN +
                      It_M_Fisco.Text + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);

      Result := False;
      exit;
    end;
    //Mensagem para o caso de não ter codigo de Benefócio Fiscal

    if (Length(It_M_CodBeficioFiscal.Text) >0 ) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Verifique o Código de Beneficio Fiscal para os itens:' + EOLN + EOLN +
                      It_M_CodBeficioFiscal.Text + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);

      //Result := False;
      //exit;
    end;



    //Mensagem se os produtos tem ST retido para o caso de CSOSN500/CST60
    if (Length(It_M_REtencaoST.Text) >0 ) then
    Begin
      CadFatCtrlIcmsST.ShowModal;
      Result := False;
    End
    else
    Begin
      CadFatCtrlIcmsST.Close;
    End;
    FreeAndNil(CadFatCtrlIcmsST);
    //vERIFICA O ncm
    It_M_Fisco.Clear;
    First;
    if not Qr_Tributacao.Active then Qr_Tributacao.Active := True;
    LcNatCompara := Qr_Tributacao.FieldByName('NAT_CFOP').AsString;
    while not Eof do
    begin
      if (FieldByName('PRO_TIPO').AsString <> 'S') and  (LcNatCompara <> '5206')  and ( LcNatCompara <> '6206' ) then
      Begin
        Lc_Aux := TRIM(FieldByName('PRO_CODIGONCM').AsString);
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-']);
        if (Lc_Aux = '') or (Length(Lc_Aux)<>8) or (Lc_Aux = '00000000') then
          It_M_Fisco.Add(FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString);
      end;
      Next;
    end;
    if (Length(It_M_Fisco.Text) >0 ) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Verificar o Cód. Class. Fiscal(NCM) dos seguintes produtos.' + EOLN +
                     'Falta de preenchimento ou não contém 8 digitos.' + EOLN +
                      It_M_Fisco.Text + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;
    //VERIFICA O CEST
    {
    It_M_Fisco.Clear;
    First;
    while not Eof do
    begin
      if (FieldByName('PRO_SUB_TRIB').AsString = 'S') then
      Begin
        Lc_Aux := TRIM(FieldByName('PRO_CEST').AsString);
        if (Lc_Aux = '') or (Length(Lc_Aux)<>6) or (Lc_Aux = '0000000') then
          It_M_Fisco.Add(FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString);
      end;
      Next;
    end;
    if (Length(It_M_Fisco.Text) >0 ) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Verificar o Código especificador da S.T dos seguintes produtos.' + EOLN +
                     'Falta de preenchimento ou não contém 7 digitos.' + EOLN +
                      It_M_Fisco.Text + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;
    }
    //valida o Preenchimento do Unidade Comercial
    It_M_Fisco.Clear;
    First;
    while not Eof do
    begin
      if (TRIM(FieldByName('MED_ABREVIATURA').AsString) = '') then
        It_M_Fisco.Add(FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString);
      Next;
    end;
    if (Length(It_M_Fisco.Text) >0 ) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Verificar o campo unidade dos seguintes produtos.' + EOLN +
                     'Falta de preenchimento.' + EOLN +
                      It_M_Fisco.Text + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;

    //valida o Preenchimento do Código de Barras - Exceto quando for revenda de veiculos
    if not FNaoUtilizarCodigoBarras then
    Begin
      if (Fc_Tb_Geral('PRO_G_LABEL_PRO','')='N') then
      Begin
        It_M_Fisco.Clear;
        First;
        while not Eof do
        begin
          if (TRIM(FieldByName('PRO_CODIGOBAR').AsString) <> '') and
            ((Length(Trim(FieldByName('PRO_CODIGOBAR').AsString))<8) or (Length(Trim(FieldByName('PRO_CODIGOBAR').AsString))>14)) then
            It_M_Fisco.Add(FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString);
          Next;
        end;
        if (Length(It_M_Fisco.Text) >0 ) then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Verificar o Cód. de barras dos seguintes produtos.' + EOLN +
                         'O número de digitos deve estar entre 8 e 14.' + EOLN +
                          It_M_Fisco.Text + EOLN +
                         'Verifique e tente novamente.' + EOLN,
                         ['OK'], [bEscape], mpErro);
          Result := False;
          exit;
        end;
        Try
          //Valida o codigo de barras calculado
          Lc_ValidaEANGTIN  := TACBrValidador.Create(nil);
          Lc_ValidaEANGTIN.TipoDocto := docGTIN;
          It_M_Fisco.Clear;
          First;
          while not Eof do
          begin
            if (TRIM(FieldByName('PRO_CODIGOBAR').AsString) <> '') AND (FieldByName('PRO_CODIGOBAR').AsString <> 'SEM GTIN') then
            BEgin
              Lc_ValidaEANGTIN.Documento := TRIM(FieldByName('PRO_CODIGOBAR').AsString);
              if not Lc_ValidaEANGTIN.Validar then
                It_M_Fisco.Add(FieldByName('ITF_CODPRO').AsString + ' - ' + FieldByName('PRO_DESCRICAO').AsString);
            end;
            Next;
          end;
        Finally
          FreeAndNil(Lc_ValidaEANGTIN);
        End;
        if (Length(It_M_Fisco.Text) >0 ) then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Verificar o Cód. de barras dos seguintes produtos.' + EOLN +
                         'O código EAN/GTIN está incorreto.' + EOLN +
                          It_M_Fisco.Text + EOLN +
                         'Verifique e tente novamente.' + EOLN,
                         ['OK'], [bEscape], mpErro);
          Result := False;
          exit;
        end;
      end;
    End;

    IF (Qr_ItensPedido.FieldByName('ITF_VL_UNIT').AsCurrency  = 0) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Este produto está com o preço Zerado.' + EOLN +
                    'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
      Result := false;
      exit;
    end;

    if Trim(FieldByName('PRO_DESCRICAO').AsString)='' then
    begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'O produto está com problemas em sua descrição.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
    end;
  end;

end;



function ttributacao.Fc_Valida_CNPJ (Fc_Numero,Fc_Tipo : string) : Boolean;
Var
  Lc_Valida:TACBrValidador;
Begin
  Try
    Result := True;
    Lc_Valida := TACBrValidador.Create(nil);
    with Lc_Valida do
    Begin
      TipoDocto := docCNPJ;
      IgnorarChar := './-';
      Documento := Fc_Numero;

      if not Validar then
        Begin
        Result := False;
        MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                       'Número do C.N.P.J do ' + Fc_Tipo + ' é inválido.'+EOLN+
                       'Verifique antes de Continuar' + EOLN,
                       ['OK'],[bEscape],mpAlerta);
        end;
    end;
  Finally
    FreeAndNil(Lc_Valida);
  End;

end;

function ttributacao.Fc_Valida_CPF (Fc_Numero,Fc_Tipo : string) : Boolean;
Var
  Lc_Valida:TACBrValidador;
Begin
  Result := True;
  if (Fc_Numero = '00000000000') then
  Begin
    Result := True;
    Exit;
  end;
  Try
    Lc_Valida := TACBrValidador.Create(nil);
    with Lc_Valida do
    Begin
      TipoDocto := docCPF;
      IgnorarChar := './-';
      Documento := Fc_Numero;

      if not Validar then
        Begin
        Result := False;
        MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                       'Número do C.P.F do ' + Fc_Tipo + ' é inválido.'+EOLN+
                       'Verifique antes de Continuar' + EOLN,
                       ['OK'],[bEscape],mpAlerta);
        end;
    end;
  Finally
    FreeAndNil(Lc_Valida);
  End;
end;

function  ttributacao.Fc_Valida_Insc_Estadual(Fc_Numero,Fc_Estado,Fc_Tipo:String): Boolean;
Var
  Lc_Val_Insc_Est:TACBrValidador;
Begin
  Result := True;
  if (UpperCase(Fc_Numero) = 'ISENTO') OR (UpperCase(Fc_Numero) = 'ISENTA')  then
  BEgin
    Result := False;
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Informação de Isento(a) não deve ser colocado no campo de Inscrição.'+EOLN+
                   'Verifique campo Indicador da Inscrição Estadual do Destinatário' + EOLN,
                   ['OK'],[bEscape],mpAlerta);
    exit;
  end;

  if (Trim(Fc_Numero) = '') and (Fc_Tipo = 'Emitente')then
  Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Inscrição Estadual do ' + Fc_Tipo + ' é inválida.'+EOLN+
                     'Verifique antes de Continuar' + EOLN,
                     ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if (Trim(Fc_Numero) <> '') then
  Begin
    Try
      Lc_Val_Insc_Est := TACBrValidador.Create(nil);
      Lc_Val_Insc_Est.TipoDocto := docInscEst;
      Lc_Val_Insc_Est.IgnorarChar := './-';
      Lc_Val_Insc_Est.Documento := Fc_Numero;
      Lc_Val_Insc_Est.Complemento := Fc_Estado;
      if not Lc_Val_Insc_Est.Validar then
      Begin
        Result := False;
        MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                       'Inscrição Estadual do ' + Fc_Tipo + ' é inválida.'+EOLN+
                       'Verifique antes de Continuar' + EOLN,
                       ['OK'],[bEscape],mpAlerta);
      end;
    Finally
      FreeAndNil(Lc_Val_Insc_Est);
    End;
  end;
end;

function  ttributacao.Fc_Valida_Dados_Emitente_NFE(): Boolean;
Var
  Lc_Aux : String;
Begin
  Result := true;
  with Estabelecimento do
  Begin
    if not Fc_Valida_CNPJ(Estabelecimento.Registro.CpfCNPJ,'Emitente') then
    begin
      Result := False;
      exit;
    end;

    //Valida Inscrição do Emitente
    if not Fc_Valida_Insc_Estadual(Estabelecimento.Registro.InscricaoEstadual, Estabelecimento.Endereco.Uf.Registro.Sigla , 'Emitente') then
    begin
      Result := False;
      exit;
    end;

    //Valida Cidade do IBGE e se o endereço está completo
    if (Length(Estabelecimento.Endereco.Cidade.Registro.Descricao) = 0) then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Cidade IBGE Emitente não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;

    //Valida o numero predial do endereco do emitente
    if (Length(Estabelecimento.Endereco.Registro.NumeroPredial) = 0) then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Número predial do Emitente não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;


    //Valida o numero predial do endereco do emitente

    if (Length(Estabelecimento.Endereco.Registro.Bairro ) = 0) then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Nome do Bairro do Emitente não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;


    //Valida telefone

    if (trim(Estabelecimento.Endereco.Registro.Fone ) <> '') and (Length(trim(Estabelecimento.Endereco.Registro.Fone)) < 10) then

    begin

      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Telefone do Emitente incompleto !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;

  end;

end;

function ttributacao.Fc_Valida_Dados_Destinatario_NFE(): Boolean;
Var
  lc_aux :String;
Begin
  Result := true;
  with NotaFiscal.Pedido do
  Begin
    if Endereco.Registro.CodigoPais = 1058 then
    Begin
      //valida O cnpj do Destinario
      Lc_Aux := Empresa.Registro.CpfCNPJ;
      If (Length(Lc_Aux) = 14) then
      Begin
        if not Fc_Valida_CNPJ(Lc_Aux,'Destinatário') then
        begin
          Result := False;
          exit;
        end;

        //Valida Inscrição do Destinatario
        if not Fc_Valida_Insc_Estadual( Empresa.Registro.InscricaoEstadual, Endereco.Uf.Registro.Sigla, 'Destinatário') then
        begin
          Result := False;
          exit;
        end;
      end
      else
      Begin
        if not Fc_Valida_CPF(Lc_Aux,'Destinatário') then
        begin
          Result := False;
          exit;
          end;
      end;

      //Valida Cidade do IBGE e se o endereço está completo
      if (Length( Endereco.Cidade.Registro.Descricao) = 0) then
        begin
        MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                       'Cidade IBGE Destinatário não encontrado !'+EOLN+
                       'Verifique e tente novamente'+EOLN,
                       ['OK'],[bEscape],mpErro);
        Result := False;
        exit;
        end;
      end;
    //Valida o CEP
    IF not Fc_ValidaCep(Endereco.Registro.Cep ) then
    begin
      Result := False;
      exit;
    end;

    //Valida o numero predial do endereco do Destinatario
    if (Length( Endereco.Registro.Logradouro ) = 0) then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Endereço do Destinatário não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;

    //Valida o numero predial do endereco do Destinatario
    if (Length( Endereco.Registro.NumeroPredial ) = 0) then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Número predial do Destinatário não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;

    //Valida o bairro  do emitente
    if (Endereco.Registro.Bairro = '') then
      begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Bairro do Destinatário não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
      end;


  //Valida telefone


    if ( not NotaFiscal.pedido.endereco.ValidateFone ) then

    begin

      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Telefone do Destinatário incompleto !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;

  end;

end;
Function ttributacao.Fc_ValidaCep(Fc_cep:String):Boolean;
BEGIN
  Result:=true;
  if (Fc_cep= '') or (Length(Fc_cep) < 8) OR (Fc_cep= '00000000')  then
  begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' Endereço de Entrega com CEP incompleto.' + EOLN +
                     ' Preencha o CEP e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpErro);
    Result:=false;
  end;
END;

function ttributacao.Fc_ValidaUsoNCM: Boolean;
Var
  Lc_Qry : TSTQuery;
  I : Integer;
Begin
  //valida Itens da Nota
  Result := true;
  if It_ValidaListaNCM then
  Begin
    try
      Lc_Qry := NotaFiscal.GeraQuery;
      with Lc_Qry do
      Begin
        close;
        Sql.Clear;
        Sql.Add(concat('SELECT DISTINCT ',
                       '  PRO_CODIGONCM ',
                       'FROM TB_ITENS_NFL INF ',
                       '   INNER JOIN TB_PRODUTO PRO ',
                       '   ON  (PRO.PRO_CODIGO = INF.ITF_CODPRO) ',
                       'WHERE (ITF_CODPED=:PED_CODIGO) ',
                       ' AND (ITF_OPER <> ''D'') ',
                       ' AND (ITF_OPER <> ''T'') ',
                       ' AND (PRO_SUB_TRIB = ''S'') '
        ));

        ParamByName('PED_CODIGO').AsInteger := NotaFiscal.Registro.CodigoPedido;
        Active := True;
        FetchAll;
        It_M_Fisco.Clear;
        first;
        I := 0;
        while not Eof do
        begin
          Qr_Uf_Mva_NCM.Active := False;
          Qr_Uf_Mva_NCM.ParamByName('UFE_CODIGO').AsInteger := NotaFiscal.Pedido.Endereco.Registro.CodigoEstado;
          Qr_Uf_Mva_NCM.ParamByName('MUN_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
          Qr_Uf_Mva_NCM.ParamByName('MUN_CODIGONCM').AsString := FieldByName('PRO_CODIGONCM').AsString;
          Qr_Uf_Mva_NCM.Active := True;
          Qr_Uf_Mva_NCM.First;
          if Qr_Uf_Mva_NCM.RecordCount = 0 then
          Begin
            inc(I);
            It_M_Fisco.Add(concat(intToStr(I), 'º -  ' , FieldByName('PRO_CODIGONCM').AsString));
          end;
          Next;
        end;

        if (Length(It_M_Fisco.Text) >0 ) then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Os seguintes NCM(s) não constam na lista do estado de destino.' + EOLN + EOLN +
                          It_M_Fisco.Text + EOLN +
                         'Verifique!.' + EOLN,
                         ['OK'], [bEscape], mpAlerta);
          Result := False;
          exit;
        end;
      end;
    finally
      NotaFiscal.FinalizaQuery(Lc_Qry);
    end;
  End;
end;

procedure ttributacao.Pc_DefineCasaDecimal;
Begin
  if It_Sentido = 'S' then
  Begin
    //Define casas decimais para as vendas
    case StrToIntDef(Fc_Tb_Geral('PRO_CASA_DEC_VENDA','0'),0) of
      0:It_Casa_Decimal := 2;
      1:It_Casa_Decimal := 3;
      2:It_Casa_Decimal := 4;
      3:It_Casa_Decimal := 5;
      4:It_Casa_Decimal := 6;
    end;
  end
  else
  Begin
    //Define casas decimais para as vendas
    case StrToIntDef(Fc_Tb_Geral('PRO_CASA_DEC_COMPRA','0'),0) of
      0:It_Casa_Decimal := 2;
      1:It_Casa_Decimal := 3;
      2:It_Casa_Decimal := 4;
      3:It_Casa_Decimal := 5;
      4:It_Casa_Decimal := 6;
    end;
  end;

end;

procedure ttributacao.Pc_CalculaIcmsRegra(Pc_Prod:TProd;Pc_Imposto:TImposto);
Begin
  with Pc_Imposto do
  Begin
    {========================== N - ICMS Normal e ST ===============================================}
    It_Tx_Imp_Aprox.Clear;
    Fc_ImpostoAproximado(It_Tx_Imp_Aprox,Qr_ItensPedido.FieldByName('PRO_CODIGONCM').AsString,Qr_ItensPedido.FieldByName('PRO_ORIGEM').AsString);
    vTotTrib := StrToFloatDef(It_Tx_Imp_Aprox.Strings[3],0);

    //Se indicador de Presenca for 1 e o cliente for nao contribuinte, podemos fazer operacao de cliente domiciliado em outro estado para como operacao interna
    if ( NotaFiscal.Pedido.Registro.IndicaPresenca = 1 ) and
       ( NotaFiscal.Pedido.Empresa.Registro.IndicadorInscricaoEstadual = '9' )  then
    Begin
      It_Nfe.NotasFiscais[0].NFe.Ide.idDest := doInterna;
    End
    else
    Begin
      if ( NotaFiscal.Pedido.Endereco.Pais.Registro.Codigo = 1058) then
      Begin
        if (NotaFiscal.Pedido.Endereco.Uf.Registro.Sigla =  Estabelecimento.Endereco.Uf.Registro.Sigla ) or It_AutorizacaoNFCE then
          It_Nfe.NotasFiscais[0].NFe.Ide.idDest := doInterna
        else
          It_Nfe.NotasFiscais[0].NFe.Ide.idDest := doInterestadual;
      end
      else
      Begin
        It_Nfe.NotasFiscais[0].NFe.Ide.idDest := doExterior;
        It_Nfe.NotasFiscais[0].NFe.Dest.idEstrangeiro := NotaFiscal.Pedido.Empresa.Registro.InscricaoEstadual;
      end;
    End;

    if ( It_AutorizacaoNFCE ) then
    begin
      It_Nfe.NotasFiscais[0].NFe.Dest.indIEDest := inNaoContribuinte;
    end
    else
    Begin
      case StrToIntdef(NotaFiscal.Pedido.Empresa.Registro.IndicadorInscricaoEstadual, 1) of
        1:
          Begin
            It_Nfe.NotasFiscais[0].NFe.Dest.indIEDest := inContribuinte;
            It_Nfe.NotasFiscais[0].NFe.Dest.IE := NotaFiscal.Pedido.Empresa.Registro.InscricaoEstadual
          end;
        2:It_Nfe.NotasFiscais[0].NFe.Dest.indIEDest := inIsento;
        9:It_Nfe.NotasFiscais[0].NFe.Dest.indIEDest := inNaoContribuinte;
      else
        It_Nfe.NotasFiscais[0].NFe.Dest.indIEDest := inIsento;
      end;
    end;
    //Codigo de Regime Tributario 1/2 - Simples nacional e 3 Regime normal
    ICMS.CST:= cstVazio;
    //Informar este antes para incluir o eventual valor na ST
    CalculoFundoCombatePobreza(Pc_Prod, Pc_Imposto);
    if (Estabelecimento.Registro.CodigoRegimeTributario = 3) or ( Estabelecimento.Registro.CodigoRegimeTributario = 2) then
      Pc_RegimeTributarioNormal(Pc_Prod, Pc_Imposto)
    else
      Pc_RegimeTributarioSimplesNacional(Pc_Prod, Pc_Imposto);


  end;
end;

procedure ttributacao.Pc_ControleRastreioICMSST(Pc_Item:TDetCollectionItem);
vAR
  I : Integer;
  LcQtde : Integer;
  LCItem : TCtrlIcmsST;
  Lc_ST_retida : TControllerCtrlIcmsST;
begin
  IF (Pc_Item.Imposto.ICMS.CST = cst60 ) OR (Pc_Item.Imposto.ICMS.CSOSN = csosn500 ) then
  Begin
    if (NotaFiscal.Pedido.Empresa.Registro.ConsumidorFinal <> 'S') and
       //(Qr_Tributacao.FieldByName('TRB_PRODUTO').AsInteger > 0 ) and retirado em 09/06/2022 por não saber por que este criterio
       (Qr_Tributacao.FieldByName('TRB_SENTIDO').AsString <> 'E' ) then
    begin
      TRy
        Lc_ST_retida := TControllerCtrlIcmsST.Create(nil);
        with Qr_ItensPedido do
        Begin
          Lc_ST_retida.Registro.Estabelecimento := NotaFiscal.Registro.CodigoEstabelecimento;
          Lc_ST_retida.Registro.Produto := FieldByName('ITF_CODPRO').AsInteger;
          Lc_ST_retida.Registro.Destino := FieldByName('ITF_CODIGO').AsInteger;
          Lc_ST_retida.GetListByProduto;
          LcQtde :=  Trunc(Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat);
          for I := 1 to LcQtde do
          Begin
            if (Lc_ST_retida.Lista.Count >= I) then
            Begin
              LCItem := Lc_ST_retida.Lista[I-1];
              Lc_ST_retida.Registro.Estabelecimento     := LCItem.Estabelecimento;
              Lc_ST_retida.Registro.Codigo              := LCItem.Codigo;
              Lc_ST_retida.Registro.Origem              := LCItem.Origem;
              Lc_ST_retida.Registro.Produto             := LCItem.Produto;
              Lc_ST_retida.Registro.ValorBaseSTRetido   := LCItem.ValorBaseSTRetido;
              Lc_ST_retida.Registro.AliqST              := LCItem.AliqST;
              Lc_ST_retida.Registro.ValorICMSSubstituto := LCItem.ValorICMSSubstituto;
              Lc_ST_retida.Registro.ValorICMSSTRetido   := LCItem.ValorICMSSTRetido;
              Lc_ST_retida.Registro.Destino             := FieldByName('ITF_CODIGO').AsInteger;
              Lc_ST_retida.atualiza;
            End;
          End;
        End;
      Finally
        Lc_ST_retida.DisposeOf;
      End;
    End;
  End;
end;

procedure TTRIBUTACAO.Pc_InformaIcmsManual(Pc_Prod:TProd;Pc_Imposto:TImposto);
Begin
  with Pc_Imposto do
  Begin
    //Codigo de Regime Tributario 1/2 - Simples nacional e 3 Regime normal
    ICMS.CST:= cstVazio;
    if (Estabelecimento.Registro.CodigoRegimeTributario = 3) or ( Estabelecimento.Registro.CodigoRegimeTributario = 2) then
      Pc_InformaRegimeTributarioNormalManual(Pc_Prod, Pc_Imposto)
    else
      Pc_InformaRegimeTributarioSimplesNacionalManual(Pc_Prod, Pc_Imposto);

  end;
end;


procedure ttributacao.Pc_PreencheDadosDanfe;
Var
  Lc_Aux : String;
  Lc_Cfop : String;
  Lc_Nr_Item : integer;
  Lc_Vl_BaseImpostoAprox:REal;
  Lc_Vl_Pedido : Real;
  Lc_Tx_Prop : Real;
  Lc_VL_Bs_Icms : Real;
  Lc_VL_Icms : Real;
  Lc_Aq_Icms : Real;
  Lc_VL_Bs_IcmsST : Real;
  Lc_VL_IcmsST : Real;
  Lc_VL_Bs_IPI : Real;
  Lc_VL_IPI : Real;
  Lc_Vl_Frete :Real;
  Lc_Vl_Seguro :Real;
  Lc_Vl_Outro :Real;
  Lc_Contador : Integer;
  Lc_Ok : Boolean;
  LC_VL : REal;

  LcStrTotal : String;
  LcFloTotal : Real;
  Lc_auxVisual : Real;
Begin
  Lc_Aq_Icms := 0;
  Pc_DefineCasaDecimal;
  Lc_Vl_Pedido := NotaFiscal.Pedido.valortotalitens;
  It_Contribuinte_ICMS := NotaFiscal.Pedido.Empresa.Registro.IndicadorInscricaoEstadual = '1';
  //Faz a validação do primeiro item da lista
  Qr_ItensPedido.First;
  Fc_tributacao;
  Fc_DefineTributacao;
  Qr_Uf_FCP_NCM.Active := False;
  Qr_Uf_FCP_NCM.ParamByName('TB_STATE_ID').AsInteger := NotaFiscal.Pedido.Endereco.Registro.CodigoEstado;
  Qr_Uf_FCP_NCM.Active := True;
  Qr_Uf_FCP_NCM.FetchAll;
  {========================== B - Identificação da Nota Fiscal eletrônica ==================================}

  with It_Nfe.NotasFiscais[0].NFe do
  begin
    //Limpa os itens
    Det.Clear;
    infNFe.ID     := '000001';
    Ide.natOp     := copy(Qr_Tributacao.FieldByName('NAT_DESCRICAO').AsString,1,60);
    Ide.nNF       := 1;
    Ide.cNF       := 1;
    Ide.modelo    := 55;
    Ide.serie     := 1;
    if (ide.tpEmis <> teNormal) then
       Begin
       ide.dhCont    := now;
       Ide.xJust   := 'Parada do servidor da Receita Estadual do Parana';
       end;
    Ide.dEmi      := NotaFiscal.Pedido.Registro.Data;
    Ide.dSaiEnt   := NotaFiscal.Pedido.Registro.Data;
    //Ide.hSaiEnt   :=
    Ide.verProc   := '2.0.0.2';
    Ide.cMunFG    := Estabelecimento.Endereco.Cidade.Registro.IBGE;
    Ide.cUF       := Estabelecimento.Endereco.Registro.CodigoEstado;
    {RFT - Informar o município de ocorrência do fato gerador do IBS / CBS. Campo preenchido somente quando "indPres = 5 (Operação presencial, fora do estabelecimento)", e não tiver endereço do destinatário (Grupo: E05) ou local de entrega (Grupo: G01}
    //Ide.cMunFGIBS

    {========================== C - Identificação do Emitente da Nota Fiscal eletrônica ====================}
     // Pc_DefineRemetente(It_Nfe.NotasFiscais[0].NFe);
    {========================== D - Identificação do Fisco Emitente da NF-e ================================}
    {========================== E - Identificação do Destinatário da Nota Fiscal eletrônica ================}
     // Pc_DefineDestinatario(It_Nfe.NotasFiscais[0].NFe);
    {========================== F - Identificação do Local de Retirada =====================================}
    {========================== G - Identificação do Local de Entrega ======================================}
    //  Pc_PreencheEnderecoiEntrega(Entrega,Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger);
    {========================== Definie quantas casas decimais =============================================}
    //Pc_DefineCasasDecimais;
    {========================== H - Detalhamento de Produtos e Serviços da NF-e ============================}
    {========================== I - Produtos e Serviços da NF-e ============================================}
    //Calculo o devolcução do IPI

    FIpiDevol.Registro.Ordem := NotaFiscal.Registro.CodigoPedido;
    It_Nfe.NotasFiscais[0].NFe.Total.ICMSTot.vIPIDevol := FIpiDevol.GetValorTotal;

    Lc_VL_Icms := 0;
    Lc_VL_Bs_Icms := 0;
    with Qr_ItensPedido do
    Begin
      Lc_Vl_Frete := 0;
      Lc_Vl_Seguro := 0;
      Lc_Vl_Outro := 0;
      Lc_Contador := 0;
      First;
      Lc_Nr_Item := 0;
      First;
      while not Eof do
      begin
        with Det.add do
        Begin
          Lc_Contador := Lc_Contador + 1;
          Fc_tributacao;
          Fc_DefineTributacao;
          Lc_Nr_Item := Lc_Nr_Item + 1;
          Prod.nItem    := Lc_Nr_Item;                                                                 // Número do item (1-990)
          Prod.cProd    := FieldByName('PRO_CODIGOFAB').AsString;                             // Códcódcódcódigo do produto ou serviço < Preencher com CFOP, caso se trate de itens não relacionados com mercadorias/produto e que o contribuinte não possua codificação
          Prod.xProd    := FieldByName('PRO_DESCRICAO').AsString;
          Lc_Aux        := FieldByName('PRO_CODIGONCM').AsString;
          Lc_Aux        := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-']);
          Prod.NCM      := Lc_Aux;
          Prod.uCom    := FieldByName('MED_ABREVIATURA').AsString;              // Unidade Comercial
          Prod.uTrib   := FieldByName('MED_ABREVIATURA').AsString;              // Unidade Tributável

          Prod.vDesc   := FieldByName('ITF_VL_DESC').AsCurrency;                   // Valor do Desconto
          Prod.qCom    := FieldByName('ITF_QTDE').AsFloat;          // Quantidade Comercial
          Prod.vUnCom  := FieldByName('ITF_VL_UNIT').AsCurrency;       // Valor Unitário de comercialização

          CalculaValorMercadoria;

          LcFloTotal   := FieldByName('ITF_QTDE').AsFloat * FieldByName('ITF_VL_UNIT').AsCurrency;
          LcFloTotal   := RoundTo( LcFloTotal  ,-2);

          LcStrTotal   := FloatToStrF( LcFloTotal ,ffFixed, 10,2);
          Prod.vProd   := StrToFloatDef(LcStrTotal,0);

          Prod.qTrib   := Prod.qCom;                                            // Quantidade Tributável
          Prod.vUnTrib  := Prod.vUnCom                       ;                   // Valor Unitário de tributação
          Prod.CEST     := FieldByName('PRO_CEST').AsString;
          IF FieldByName('PRO_TIPO').AsString = 'S' then
            Prod.IndTot := StrToindTot(Lc_Ok,'0')
          else
            Prod.IndTot := StrToindTot(Lc_Ok,'1');
          //fAZ A DIVISÃO DE VALORES DE FRETES/SEGURO/OUTRAS
          Lc_Tx_Prop := (Prod.vUnCom * Prod.qCom) - Prod.vDesc;
          Lc_Tx_Prop := Fc_ArredondarParaBaixo((Lc_Tx_Prop / Lc_Vl_Pedido),4,True);
          if (Lc_Contador < RecordCount) then
          Begin
            //Valor do Frete
            Prod.vFrete := Fc_ArredondarParaBaixo(Total.ICMSTot.vFrete * Lc_Tx_Prop,2,False);
            Lc_Vl_Frete := Lc_Vl_Frete + Prod.vFrete;
            //Valor do Seguro
            Prod.vSeg := Fc_ArredondarParaBaixo(Total.ICMSTot.vSeg * Lc_Tx_Prop,2,False);
            Lc_Vl_Seguro := Lc_Vl_Seguro + Prod.vSeg;
            //Valor do Outros
            Prod.vOutro := Fc_ArredondarParaBaixo(Total.ICMSTot.vOutro * Lc_Tx_Prop,2,False);
            Lc_Vl_Outro := Lc_Vl_Outro + Prod.vOutro;
          end
          else
          Begin
            //Valor do Frete
            Prod.vFrete := Total.ICMSTot.vFrete - Lc_Vl_Frete;
            //Valor do Seguro
            Prod.vSeg := Total.ICMSTot.vSeg - Lc_Vl_Seguro;
            //Valor do Outros
            Prod.vOutro := Total.ICMSTot.vOutro - Lc_Vl_Outro;
          end;
          {==========================  Tag da Declaração de Importação =====================================}
          {==========================  J - Detalhamento Específico de Veículos novos =======================}
          {==========================  K - Det Esp. de Medic e de mat-primas farm ==========================}
          {==========================  L - Detalhamento Específico de Armamentos ===========================}
          {==========================  L1 - Detalhamento Específico de Combustíveis ========================}
          {==========================  M - Tributos incidentes no Produto ou Serviço =======================}

          {========================== O - Imposto sobre Produtos Industrializados ========================}
          //O IPI precisa ser calculado antes do ICMS para eventuais calculos de BS ST
          LC_VL :=0;
          //Se não distribui o calculo e feito pela regra ou pelo preenchimento do ITF_aq_ipi
          Pc_DefineIPI(Prod,Imposto);
          if It_Dist_IPI then
          Begin
            //Dstribui o IPI
            if (Lc_Contador < RecordCount) then
            Begin
              //Valor da Base IPI
              Imposto.IPI.vBC := FValorMercadoria;
              Imposto.IPI.vBC := Roundto(Imposto.IPI.vBC,-2);
              Lc_VL_Bs_IPI := Lc_VL_Bs_IPI + Imposto.IPI.vBC;
              //Valor do IPI
              Imposto.IPI.vIPI := Total.ICMSTot.vIPI * Lc_Tx_Prop;
              Imposto.IPI.vIPI := Roundto(Imposto.IPI.vIPI ,-2);

              Lc_VL_IPI := Lc_VL_IPI + Imposto.IPI.vIPI;
            end
            else
            Begin
              //Valor da Base IPI
              Imposto.IPI.vBC  := Lc_Vl_Pedido -  Lc_VL_Bs_IPI;
              //Valor do IPI
              Imposto.IPI.vIPI := Total.ICMSTot.vIPI - Lc_VL_IPI;
            end;
            imposto.IPI.pIPI := (Imposto.IPI.vIPI / Imposto.IPI.vBC) * 100;
          end;

          {========================== N - ICMS Normal e ST ===============================================}
          IF (It_Cd_CFOP = 0) and It_AutorizacaoNFE then
            It_Cd_CFOP := Qr_Tributacao.FieldByName('NAT_CODIGO').AsInteger;
          //Origem da Mercadoria
          case StrToIntDef(Qr_Tributacao.FieldByName('TRB_ORIGEM').AsString,0) OF
            0:Imposto.ICMS.orig := oeNacional;
            1:Imposto.ICMS.orig := oeEstrangeiraImportacaoDireta;
            2:Imposto.ICMS.orig := oeEstrangeiraAdquiridaBrasil;
          end;

          if It_Dist_Icms_NR or It_Dist_Icms_ST then
          Begin
            //Dstribui o ICMS Normal
            if (Lc_Contador < RecordCount) then
            Begin
              //Valor da Base ICMS -
              Imposto.ICMS.vBC := Total.ICMSTot.vBC * Lc_Tx_Prop;
              Imposto.ICMS.vBC := RoundTO(Imposto.ICMS.vBC,-2);
              Lc_VL_Bs_Icms := Lc_VL_Bs_Icms + Imposto.ICMS.vBC;
              //Aliquota do ICMS = VL ICMS / BC
              if (Total.ICMSTot.vICMS > 0) and (Imposto.ICMS.vBC > 0)  then
              Begin
                Lc_Aq_Icms := Total.ICMSTot.vICMS * Lc_Tx_Prop;
                Lc_Aq_Icms := (Lc_Aq_Icms / Imposto.ICMS.vBC)*100;
                Lc_Aq_Icms := RoundTO(Lc_Aq_Icms ,-2);
              End;
              if Lc_Aq_Icms > 0 then
                Imposto.ICMS.pICMS := Lc_Aq_Icms
              else
                Imposto.ICMS.pICMS := 0;
              //Valor do ICMS - Redefine o valor do ICMS com a Aliquota calculada
              Imposto.ICMS.vICMS := (Imposto.ICMS.vBC * Imposto.ICMS.pICMS) / 100;
              Imposto.ICMS.vICMS := RoundTO(Imposto.ICMS.vICMS ,-2);
              Lc_VL_Icms := Lc_VL_Icms + Imposto.ICMS.vICMS;
              Lc_Aq_Icms := Imposto.ICMS.vICMS;
            end
            else
            Begin
              //Valor da Base ICMS
              Imposto.ICMS.vBC  := Total.ICMSTot.vBC - Lc_VL_Bs_Icms;
              Imposto.ICMS.vBC  := RoundTO(Imposto.ICMS.vBC,-2);
              //Valor do ICMS
              Lc_auxVisual := Total.ICMSTot.vICMS;
              Imposto.ICMS.vICMS := Total.ICMSTot.vICMS - Lc_VL_Icms;
              Imposto.ICMS.vICMS := RoundTO( Imposto.ICMS.vICMS,-2);
              //Aliquota do ICMS
              if (Total.ICMSTot.vICMS > 0) and (Imposto.ICMS.vBC > 0)  then
              Begin
                Lc_Aq_Icms := (Imposto.ICMS.vICMS / Imposto.ICMS.vBC)*100;
                Lc_Aq_Icms := RoundTO( Lc_Aq_Icms ,-2);
              End;
              if Lc_Aq_Icms > 0 then
                Imposto.ICMS.pICMS := Lc_Aq_Icms
              else
                Imposto.ICMS.pICMS := 0;
              //Redefine o valor do ICMS com a Aliquota calculada
              //recalculando a aliquota não chega no valor correto....vamos ver se passa....10/02/2022
              //Imposto.ICMS.vICMS := (Imposto.ICMS.vBC * Imposto.ICMS.pICMS) / 100;
              //Imposto.ICMS.vICMS := RoundTO( Imposto.ICMS.vICMS,-2);
            end;
            if It_Dist_Icms_ST then
            Begin
              //Dstribui o ICMS ST
              if (Lc_Contador < RecordCount) then
              Begin
                //Valor da Base ICMS ST
                Imposto.ICMS.vBCST := Total.ICMSTot.vBCST * Lc_Tx_Prop;
                Imposto.ICMS.vBCST := RoundTo( Imposto.ICMS.vBCST,-2);
                Lc_VL_Bs_IcmsST := Lc_VL_Bs_IcmsST + Imposto.ICMS.vBCST;
                //Valor do ICMS
                Imposto.ICMS.vICMSST := Total.ICMSTot.vST * Lc_Tx_Prop;
                Imposto.ICMS.vICMSST := RoundTo( Imposto.ICMS.vICMSST,-2);
                Lc_VL_IcmsST := Lc_VL_IcmsST + Imposto.ICMS.vICMSST;
              end
              else
              Begin
                //Valor da Base ICMS ST
                Imposto.ICMS.vBCST  := Total.ICMSTot.vBCST - Lc_VL_Bs_IcmsST;
                //Valor do ICMS ST
                Imposto.ICMS.vICMSST := Total.ICMSTot.vST - Lc_VL_IcmsST;
              end;
              //Verifica se precisamos pegar o MVA de um NCM especifico
              Pc_Abrir_Aliquota_UF_ST(FieldByName('PRO_CODIGONCM').AsString);
              if (Qr_Uf_Mva_NCM.FieldByName('MUN_MR_VL_AGREGADO').AsCurrency > 0) then
              Begin
                MargemValorAgregado := Qr_Uf_Mva_NCM.FieldByName('MUN_MR_VL_AGREGADO').AsCurrency;
              End
              else
              Begin
                if MargemValorAgregado = 0 then
                Begin
                  MargemValorAgregado := (Prod.vProd / Imposto.ICMS.vBCST);
                  MargemValorAgregado := RoundTo(MargemValorAgregado,-3) + 1;
                End;
              End;
              Imposto.ICMS.pMVAST := MargemValorAgregado;
            end;
          end
          else
          Begin

            if FieldByName('ITF_AQ_ICMS').AsCurrency = 0 then
              Pc_CalculaIcmsRegra(Prod, Imposto)
            else
              Pc_InformaIcmsManual(Prod, Imposto);
          end;

          {========================== P - Imposto de Importação ==========================================}
          Pc_DefineII(Imposto);
          {========================== Q É PIS ============================================================}
          Pc_DefinePIS(Imposto);
          {========================== R É PIS ST =========================================================}
          {========================== S É COFINS =========================================================}
          Pc_DefineCOFINS(Imposto);
          {========================== T - COFINS ST ======================================================}
          {========================== U - ISSQN ==========================================================}
          IF Qr_ItensPedido.FieldByName('PRO_TIPO').AsString = 'S' then
          Begin
            Pc_DefineISSQN(Imposto);
          end;
          if Gb_Reforma_Tributaria then
            Pc_DefineIBSCBS(Prod, Imposto);
        end;
        Qr_ItensPedido.next;
      end;
    end;

    {========================== V - Informações adicionais =================================================}
     //tratado na tag I - Produtos e Serviços da NF-e

    {========================== W - Valores Totais da NF-e =================================================}

    // TAG de grupo de Valores Totais referentes ao ICMS
    if It_AutorizacaoNFE OR It_Dist_Icms_NR OR It_Dist_Icms_ST OR It_Dist_IPI then
    BEgin
      Pc_SomaValorBaseICMS(It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorICMS(It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorBaseICMSST(It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorICMSST(It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorII (It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorIPI(It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorPIS(It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorCFS(It_Nfe.NotasFiscais[0].NFe);
      Pc_SomaValorIBSCBS(It_Nfe.NotasFiscais[0].NFe);
    end;
    Pc_SomaValorISSQN(It_Nfe.NotasFiscais[0].NFe);
    Pc_SomaValorProduto(It_Nfe.NotasFiscais[0].NFe);
    Pc_SomaValorFrete(It_Nfe.NotasFiscais[0].NFe);
    Pc_SomaValorSeguro(It_Nfe.NotasFiscais[0].NFe);
    Pc_SomaValorDesconto(It_Nfe.NotasFiscais[0].NFe);
    Pc_SomaValorOutros(It_Nfe.NotasFiscais[0].NFe);
    Pc_SomaValorAproximImposto(It_Nfe.NotasFiscais[0].NFe);
    Pc_SomaValorTotalNota(It_Nfe.NotasFiscais[0].NFe);

    {========================== X - Informações do Transporte da NF-e ======================================}
    //Pc_DadosdoTransporte(It_Nfe.NotasFiscais[0].NFe);
    {========================== Y É Dados da Cobrança ======================================================}
    {========================== Z - Informações Adicionais da NF-e =========================================}
    {========================== ZA - Informações de Comércio Exterior ======================================}
    {========================== ZB - Informações de Compras ================================================}
    {========================== ZC - Informações do Registro de Aquisição de Cana ==========================}
    {========================== ZZ - Informações da Assinatura Digital =====================================}
  end;
end;

Procedure ttributacao.Pc_PreencheEnderecoiEntrega(Fc_Entrega:TEntrega;Fc_cd_Empresa: Integer);
begin
  //Neste caso tem apenas um endereço e não precisa comparar
  with Fc_Entrega, NotaFiscal.Pedido do
  Begin
    if Empresa.Endereco.Registro.Codigo <> Endereco.Registro.Codigo then
    Begin
      CNPJCPF := Empresa.Registro.CpfCNPJ;
      xLgr    := Endereco.Registro.Logradouro;
      nro     := Endereco.Registro.NumeroPredial;
      xCpl    := Endereco.Registro.Complemento;
      xBairro := Endereco.Registro.Bairro;
      cMun    := Endereco.Cidade.Registro.IBGE;
      xMun    := Endereco.Cidade.Registro.Descricao;
      UF      := Endereco.Uf.Registro.Sigla;
    End;
  end;
end;

// =============================================================================
// Fn_IPIIntegraNaBaseICMS  -  Regra: art. 155 §2º XI CF / art. 13 §2º LC 87/96
//   O IPI NÃO integra a base ICMS somente quando os 3 requisitos são atendidos
//   SIMULTANEAMENTE:
//     1. Operação entre contribuintes       (It_Contribuinte_ICMS = True)
//     2. Mercadoria para produção(2) ou
//        industrialização(4)                (TRB_PRODUTO in [2, 4])
//     3. Fato gerador de ambos os impostos  (vIPI > 0)
//   Em qualquer outro caso o IPI deve compor a base (consumidor final,
//   uso/consumo, ativo imobilizado, operações sem IPI, etc.).
//   Retorna: vIPI quando deve compor a base  |  0 quando a exceção se aplica.
// =============================================================================
function ttributacao.Fn_IPIIntegraNaBaseICMS(vIPI: Real): Real;
var
  Lc_Produto: Integer;
begin
  //Finalidade Revenda ou Industrializacao
  if Qr_Tributacao.FieldByName('TRB_PRODUTO').AsString <> '' then
    Lc_Produto := StrToIntDef(Trim(Qr_Tributacao.FieldByName('TRB_PRODUTO').AsString), 0)
  else
    Lc_Produto := 0;

  // Exceção: os 3 requisitos precisam ser atendidos ao mesmo tempo
  if It_Contribuinte_ICMS
     and (Lc_Produto in [2, 4])
     and (vIPI > 0) then
    Result := 0          // IPI não compõe a base ICMS
  else
    Result := vIPI;      // IPI integra a base ICMS
end;

// =============================================================================
// Fn_CalcBaseICMS
//   Calcula a base de cálculo do ICMS normal centralizando a regra:
//     Base = (VlProd + Fn_IPIIntegraNaBaseICMS(vIPI) + vFrete) - redução%
//   Parâmetros:
//     VlProd : valor líquido do item  (VL_UNIT * QTDE) - DESC
//     PctRed : percentual de redução da base  (ex: 30 para 30%). 0 = sem redução.
//     vIPI   : valor bruto do IPI do item - inclusão decidida por Fn_IPIIntegraNaBaseICMS
//     vFrete : valor do frete a compor a base. 0 se não aplicável.
// =============================================================================
function ttributacao.Fn_CalcBaseICMS(PctRed, vIPI, vFrete: Real): Real;
var
  Lc_Base: Real;
begin
  Lc_Base := FValorMercadoria + Fn_IPIIntegraNaBaseICMS(vIPI) + vFrete;
  if PctRed > 0 then
    Lc_Base := Lc_Base - (Lc_Base * (PctRed / 100));
  Result := RoundTo(Lc_Base, -2);
end;

// =============================================================================
// Fn_CalcBaseICMSST
//   Fórmula completa da base do ICMS-ST por MVA (Lei Kandir / RICMS):
//     Base ST = (VlProd + vIPI + vFrete + vSeg + vOutro) × (1 - PctRed/100) × pMVA
//
//   Para ICMS-ST o IPI SEMPRE compõe a base (ao contrário do ICMS próprio
//   onde existe a exceção constitucional art. 155 §2º XI CF).
//   A legislação determina que todos os encargos transferíveis ao adquirente
//   (IPI, frete, seguro, outras despesas) integrem a base antes da MVA.
//
//   Parâmetros:
//     VlProd  : valor líquido do item  (VL_UNIT * QTDE) - DESC
//     vIPI    : Pc_Imposto.IPI.vIPI   (sempre entra na base ST)
//     vFrete  : Pc_Prod.vFrete
//     vSeg    : Pc_Prod.vSeg
//     vOutro  : Pc_Prod.vOutro
//     PctRed  : % redução da base ST (0 = sem redução)
//     pMVA    : fator MVA (MargemValorAgregado)
// =============================================================================
function ttributacao.Fn_CalcBaseICMSST(vIPI, vFrete, vSeg, vOutro, PctRed, pMVA: Real): Real;
var
  Lc_Base: Real;
begin
  Lc_Base := FValorMercadoria + vIPI + vFrete + vSeg + vOutro;
  if PctRed > 0 then
    Lc_Base := Lc_Base - (Lc_Base * (PctRed / 100));
  Lc_Base := Lc_Base * pMVA;
  Result := RoundTo(Lc_Base, -2);
end;

Procedure ttributacao.Pc_RegimeTributarioNormal(Pc_Prod:TProd;Pc_Imposto:TImposto);
Var
  Lc_Ok : Boolean;
BEgin
  with Pc_Imposto do
  Begin
    //Zera os valores
    //Limpa as Variaveis
    ICMS.vBC      := 0;
    ICMS.pICMS    := 0;
    ICMS.pRedBC   := 0;
    ICMS.vICMS    := 0;
    //ICMS Normal S.T
    ICMS.pMVAST   := 0;
    ICMS.pRedBCST := 0;
    ICMS.vBCST    := 0;
    ICMS.pICMSST  := 0;
    ICMS.vICMSST  := 0;
    ICMS.orig  := StrToOrig(Qr_ItensPedido.FieldByName('PRO_ORIGEM').AsString);
    ICMS.CST   := StrToCSTICMS(Qr_Tributacao.FieldByName('CST_ICMS').AsString);
    ICMS.modBC := StrTomodBC(Lc_OK,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);



    //Tributação do ICMS - 00 Tributada integralmente
    if ICMS.CST = cst00 then
    Begin
      ICMS.vBC    := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
      ICMS.pICMS  := It_aliq_Interna_NR_Icms;
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vICMS  := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
      Exit;
    end;
    //Tributação do ICMS - 10 - Tributada e com cobrança do ICMS por substituição tributária
    if ICMS.CST = cst10 then
    Begin
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal
        ICMS.modBC    := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
        ICMS.vBC      := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
        ICMS.pICMS    := It_aliq_Interna_NR_Icms;
        ICMS.pRedBC   := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
        ICMS.vICMS    := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
        //ICMS Normal S.T - IPI sempre integra a base ST (Lei Kandir)
        ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
        ICMS.pMVAST   := MargemValorAgregado;
        ICMS.pRedBCST := 0;
        ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, 0, ICMS.pMVAST);
        ICMS.pICMSST := It_aliq_Interna_St_Icms;
        ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
      end;
      Exit;
    end;
    //Tributação do ICMS - 20 - Com redução de base de cálculo
    if ICMS.CST = cst20 then
    Begin
      ICMS.modBC  := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
      ICMS.vBC    := Fn_CalcBaseICMS(Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency, IPI.vIPI, 0);
      ICMS.pICMS  := It_aliq_Interna_NR_Icms;
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vICMS  := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
      Exit;
    end;
    // Tributação do ICMS - 30 - Isenta ou não tributada e com cobrança do ICMS por substituição tributária
    if ICMS.CST = cst30 then
    Begin
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal (temporário para base do ST - zerado no final conforme isenção)
        ICMS.modBC    := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
        ICMS.vBC      := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
        ICMS.pICMS    := It_aliq_Interna_NR_Icms;
        ICMS.pRedBC   := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
        ICMS.vICMS    := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
        //ICMS S.T - IPI sempre integra a base ST (Lei Kandir)
        ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
        ICMS.pMVAST   := MargemValorAgregado;
        ICMS.pRedBCST := 0;
        if Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS_ST').AsString = 'S' then
          ICMS.pRedBCST := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
        ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, ICMS.pRedBCST, ICMS.pMVAST);
        ICMS.pICMSST := It_aliq_Interna_St_Icms;
        ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
        //Zera o ICMS Normal conforme isenção
        ICMS.vBC    := 0;
        ICMS.pICMS  := 0;
        ICMS.pRedBC := 0;
        ICMS.vICMS  := 0;
      end;
      Exit;
    end;
    // Tributação do ICMS - 40 - Isenta 41 - Não tributada 50 - Suspensão
    if (ICMS.CST = cst40) or (ICMS.CST = cst41) or (ICMS.CST = cst50) then
    Begin
      Exit;
    end;
    //Tributação do ICMS - 51 - Diferimento  A exigência do preenchimento das informações do ICMS diferido fica a critério de cada UF.
    if ICMS.CST = cst51 then
    Begin
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal - base inclui frete (+ Pc_Prod.vSeg + Pc_Prod.vOutro quando necessário)
        ICMS.modBC   := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
        ICMS.vBC     := Fn_CalcBaseICMS(0, IPI.vIPI, Pc_Prod.vFrete);
        ICMS.pICMS   := It_aliq_Interna_NR_Icms;
        ICMS.vICMSOp := ICMS.vBC * (ICMS.pICMS / 100);

        ICMS.pRedBC  := Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency;
        ICMS.pDif    := Qr_Tributacao.FieldByName('TRB_AQ_DIF').AsCurrency;

        icms.vICMSDif := ICMS.pDif * (ICMS.pICMS / 100);
        icms.vICMSDif := ICMS.vBC * (icms.vICMSDif / 100);
        ICMS.vICMSDif := RoundTo(ICMS.vICMSDif, -2);

        ICMS.vICMS    := RoundTo((ICMS.vBC * (ICMS.pICMS / 100)) - icms.vICMSDif, -2);
        //ICMS ST Retido
        ICMS.vICMSSTRet := 0
      end;
      Exit;
    end;
    //Tributação do ICMS - 60 - ICMS cobrado anteriormente por substituição tributária
    if ICMS.CST = cst60 then
    Begin
      ICMS.vBCSTRet   := 0;
      ICMS.vICMSSTRet := 0;
      Exit;
    end;
    //Tributação do ICMS - 70 - Com redução de base de cálculo e cobrança do ICMS por substituição tributária
    if ICMS.CST = cst70 then
    Begin
      //ICMS Normal
      ICMS.modBC  := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vBC    := Fn_CalcBaseICMS(Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency, IPI.vIPI, 0);
      ICMS.pICMS  := It_aliq_Interna_NR_Icms;
      ICMS.vICMS  := RoundTo(ICMS.vBC * (ICMS.pICMS / 100), -2);
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal S.T - IPI sempre integra a base ST (Lei Kandir)
        ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
        ICMS.pMVAST   := MargemValorAgregado;
        ICMS.pRedBCST := 0;
        if Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS_ST').AsString = 'S' then
          ICMS.pRedBCST := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
        ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, ICMS.pRedBCST, ICMS.pMVAST);
        ICMS.pICMSST := It_aliq_Interna_St_Icms;
        ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
      end;
      Exit;
    end;
    //Tributação do ICMS - 90 É Outros
    if ICMS.CST = cst90 then
    Begin
      //ICMS Normal
      ICMS.modBC  := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
      ICMS.vBC    := Fn_CalcBaseICMS(Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency, IPI.vIPI, 0);
      ICMS.pICMS  := It_aliq_Interna_NR_Icms;
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vICMS  := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
      Exit;
    end;
  end;
end;

Procedure ttributacao.Pc_InformaRegimeTributarioNormalManual(Pc_Prod:TProd;Pc_Imposto:TImposto);
Var
  Lc_Ok : Boolean;
BEgin
  with Pc_Imposto do
  Begin
    //Zera os valores
    //Limpa as Variaveis
    ICMS.vBC      := 0;
    ICMS.pICMS    := 0;
    ICMS.pRedBC   := 0;
    ICMS.vICMS    := 0;
    //ICMS Normal S.T
    ICMS.pMVAST   := 0;
    ICMS.pRedBCST := 0;
    ICMS.vBCST    := 0;
    ICMS.pICMSST  := 0;
    ICMS.vICMSST  := 0;
    ICMS.orig  := StrToOrig(Qr_ItensPedido.FieldByName('PRO_ORIGEM').AsString);
    ICMS.CST   := StrToCSTICMS(Qr_Tributacao.FieldByName('CST_ICMS').AsString);
    ICMS.modBC := StrTomodBC(Lc_OK,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);


    //Tributação do ICMS - 00 Tributada integralmente
    if ICMS.CST = cst00 then
    Begin
      ICMS.vBC    := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
      ICMS.pICMS  := Qr_ItensPedido.FieldByName('ITF_AQ_ICMS').AsCurrency;
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vICMS  := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
      Exit;
    end;
    //Tributação do ICMS - 10 - Tributada e com cobrança do ICMS por substituição tributária
    if ICMS.CST = cst10 then
    Begin
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal
        ICMS.modBC    := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
        ICMS.vBC      := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
        ICMS.pICMS    := Qr_ItensPedido.FieldByName('ITF_AQ_ICMS').AsCurrency;
        ICMS.pRedBC   := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
        ICMS.vICMS    := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
        //ICMS Normal S.T - IPI sempre integra a base ST (Lei Kandir)
        ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
        ICMS.pMVAST   := MargemValorAgregado;
        ICMS.pRedBCST := 0;
        ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, 0, ICMS.pMVAST);
        ICMS.pICMSST := It_aliq_Interna_St_Icms;
        ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
      end;
      Exit;
    end;
    //Tributação do ICMS - 20 - Com redução de base de cálculo
    if ICMS.CST = cst20 then
    Begin
      ICMS.modBC  := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
      ICMS.vBC    := Fn_CalcBaseICMS(Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency, IPI.vIPI, 0);
      ICMS.pICMS  := Qr_ItensPedido.FieldByName('ITF_AQ_ICMS').AsCurrency;
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vICMS  := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
      Exit;
    end;
    // Tributação do ICMS - 30 - Isenta ou não tributada e com cobrança do ICMS por substituição tributária
    if ICMS.CST = cst30 then
    Begin
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal (temporário para base do ST - zerado no final conforme isenção)
        ICMS.modBC    := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
        ICMS.vBC      := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
        ICMS.pICMS    := Qr_ItensPedido.FieldByName('ITF_AQ_ICMS').AsCurrency;
        ICMS.pRedBC   := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
        ICMS.vICMS    := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
        //ICMS S.T - IPI sempre integra a base ST (Lei Kandir)
        ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
        ICMS.pMVAST   := MargemValorAgregado;
        ICMS.pRedBCST := 0;
        ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, 0, ICMS.pMVAST);
        ICMS.pICMSST := It_aliq_Interna_St_Icms;
        ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
        //Zera o ICMS Normal conforme isenção
        ICMS.vBC    := 0;
        ICMS.pICMS  := 0;
        ICMS.pRedBC := 0;
        ICMS.vICMS  := 0;
      end;
      Exit;
    end;
    // Tributação do ICMS - 40 - Isenta 41 - Não tributada 50 - Suspensão
    if (ICMS.CST = cst40) or (ICMS.CST = cst41) or (ICMS.CST = cst50) then
    Begin
      Exit;
    end;
    //Tributação do ICMS - 51 - Diferimento  A exigência do preenchimento das informações do ICMS diferido fica a critério de cada UF.
    if ICMS.CST = cst51 then
    Begin
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal - base sem frete na versão manual
        ICMS.modBC   := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
        ICMS.vBC     := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
        ICMS.pICMS   := It_aliq_Interna_NR_Icms;
        ICMS.vICMSOp := ICMS.vBC * (ICMS.pICMS / 100);

        ICMS.pRedBC  := Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency;
        ICMS.pDif    := Qr_Tributacao.FieldByName('TRB_AQ_DIF').AsCurrency;

        icms.vICMSDif := ICMS.pDif * (ICMS.pICMS / 100);
        icms.vICMSDif := ICMS.vBC * (icms.vICMSDif / 100);
        ICMS.vICMSDif := RoundTo(ICMS.vICMSDif, -2);

        ICMS.vICMS    := RoundTo((ICMS.vBC * (ICMS.pICMS / 100)) - icms.vICMSDif, -2);
        //ICMS ST Retido
        ICMS.vICMSSTRet := 0
      end;
      Exit;
    end;
    //Tributação do ICMS - 60 - ICMS cobrado anteriormente por substituição tributária
    if ICMS.CST = cst60 then
    Begin
      ICMS.vBCSTRet   := 0;
      ICMS.vICMSSTRet := 0;
      Exit;
    end;
    //Tributação do ICMS - 70 - Com redução de base de cálculo e cobrança do ICMS por substituição tributária
    if ICMS.CST = cst70 then
    Begin
      //ICMS Normal
      ICMS.modBC  := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vBC    := Fn_CalcBaseICMS(Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency, IPI.vIPI, 0);
      ICMS.pICMS  := Qr_ItensPedido.FieldByName('ITF_AQ_ICMS').AsCurrency;
      ICMS.vICMS  := RoundTo(ICMS.vBC * (ICMS.pICMS / 100), -2);
      if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
      Begin
        //ICMS Normal S.T - IPI sempre integra a base ST (Lei Kandir)
        ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
        ICMS.pMVAST   := MargemValorAgregado;
        ICMS.pRedBCST := 0;
        ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, 0, ICMS.pMVAST);
        ICMS.pICMSST := It_aliq_Interna_St_Icms;
        ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
      end;
      Exit;
    end;
    //Tributação do ICMS - 90 É Outros
    if ICMS.CST = cst90 then
    Begin
      //ICMS Normal
      ICMS.modBC  := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
      ICMS.vBC    := Fn_CalcBaseICMS(0, IPI.vIPI, 0);
      ICMS.pICMS  := Qr_ItensPedido.FieldByName('ITF_AQ_ICMS').AsCurrency;
      ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
      ICMS.vICMS  := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
      Exit;
    end;
  end;
end;


Procedure ttributacao.Pc_RegimeTributarioSimplesNacional(Pc_Prod:TProd;Pc_Imposto:TImposto);
Var
  Lc_Ok : Boolean;
  procedure ZeraValoresICMS;
  Begin
    with  Pc_Imposto do
    Begin
      ICMS.vBC      := 0;
      ICMS.pICMS    := 0;
      ICMS.pRedBC   := 0;
      ICMS.vICMS    := 0;
    End;
  End;
  procedure ZeraValoresST;
  Begin
    with  Pc_Imposto do
    Begin
      ICMS.pMVAST   := 0;
      ICMS.pRedBCST := 0;
      ICMS.vBCST    := 0;
      ICMS.pICMSST  := 0;
      ICMS.vICMSST  := 0;
      ICMS.vBCSTRet := 0;
      ICMS.vICMSSTRet := 0;
    End;
  End;
Begin

  with  Pc_Imposto do
  Begin
    //Verifica se há tributação pelo Simples Nacional
    //Base do ICMS ST = (Valor do produto + Valor do IPI + Frete + Seguro + Outras Despesas Acessórias - Descontos) * (1+(%MVA / 100))
    ICMS.CSOSN := StrToCSOSNIcms(Qr_Tributacao.FieldByName('CSOSN_ICMS').AsString);
    ICMS.modBC := StrTomodBC(Lc_OK,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);

    ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency;


    // Base ICMS Simples: inclui IPI e frete, aplica redução percentual
    ICMS.vBC     := Fn_CalcBaseICMS(ICMS.pRedBC, Pc_Imposto.IPI.vIPI, Pc_Prod.vFrete);
    ICMS.pICMS   := It_aliq_Interna_NR_Icms;
    ICMS.vICMSOp := ICMS.vBC * (ICMS.pICMS / 100);

    ICMS.pDif     := Qr_Tributacao.FieldByName('TRB_AQ_DIF').AsCurrency;
    icms.vICMSDif := 0;
    if Qr_Tributacao.FieldByName('TRB_CONSUMIDOR').AsString = 'N' then
    Begin
      icms.vICMSDif := ICMS.pDif * (ICMS.pICMS / 100);
      icms.vICMSDif := ICMS.vBC * (icms.vICMSDif / 100);
      ICMS.vICMSDif := RoundTo(ICMS.vICMSDif, -2);
    end;

    ICMS.vICMS    := RoundTo((ICMS.vBC * (ICMS.pICMS / 100)) - icms.vICMSDif, -2);
    //ICMS ST Retido
    ICMS.vICMSSTRet := 0;

    //ICMS S.T - IPI sempre integra a base ST (Lei Kandir)
    //  Base ST = (VlProd + IPI + Frete + Seguro + Outras) × (1 - Red%) × MVA
    ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
    ICMS.pMVAST   := MargemValorAgregado;
    ICMS.pRedBCST := 0;
    if Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS_ST').AsString = 'S' then
      ICMS.pRedBCST := Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency;
    ICMS.vBCST := Fn_CalcBaseICMSST(Pc_Imposto.IPI.vIPI,
                                     Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro,
                                     ICMS.pRedBCST, ICMS.pMVAST);

    ICMS.pICMSST := It_aliq_Interna_St_Icms;
    ICMS.vICMSST := (ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS;
    //Adiciona o valor do fundo de combate a pobreza
    ICMS.vICMSST := RoundTo(ICMS.vICMSST + pc_imposto.ICMS.vFCPST, -2);
    //credito ICMS
    ICMS.pCredSN     := RoundTo(It_Aq_Cred_Icms, -2); //Alíquota aplicável de cálculo do crédito (Simples Nacional).
    ICMS.vCredICMSSN := RoundTo((FValorMercadoria * It_Aq_Cred_Icms) / 100, -2); //Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)
    //TRIBUTADA PELO SIMPLES NACIONAL COM PERMISSÃO DE CRÉDITO
    if (ICMS.CSOSN = csosn101) then
    Begin
      ZeraValoresICMS;
      ZeraValoresST;
      exit;
    end;
    //Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=102, 103, 300 ou 400 (v.2.0)
    if (ICMS.CSOSN = csosn102) or (ICMS.CSOSN = csosn103) or
       (ICMS.CSOSN = csosn300) then
    Begin
      ZeraValoresICMS;
      ZeraValoresST;
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;
    //Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=102, 103, 300 ou 400 (v.2.0)
    if ( ICMS.CSOSN = csosn400) then
    Begin
      ZeraValoresST;
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;


    //201- Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por Substituição Tributária v.2.0)
    if (ICMS.CSOSN = csosn201) then
    Begin
      //ICMS Normal S.T já calculada no inicio do processo
      //ICMS Normal - Zera os valores depois de feito o calculo
      ZeraValoresICMS;
      exit;
    end;
    //202- Tributada pelo Simples Nacional sem permissão de  crédito e com cobrança do ICMS por Substituição Tributária
    //203- Isenção do ICMS nos Simples Nacional para faixa de receita bruta e com cobrança do ICMS por Substituição Tributária  (v.2.0)
    if (ICMS.CSOSN = csosn202) OR (ICMS.CSOSN = csosn203)then
    Begin
      //ICMS Normal S.T já calculada no inicio do processo
      //ICMS Normal - Zera os valores depois de feito o calculo
      ZeraValoresICMS;
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;
    //500 É ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação (v.2.0)
    if (ICMS.CSOSN = csosn500) then
    Begin
      ZeraValoresICMS;
      ZeraValoresST;
      exit;
    end;
    //Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=900 (v2.0)
    if (ICMS.CSOSN = csosn900) then
    Begin
      if Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString <> 'S' then
        ZeraValoresST;
      exit;
    end;
  end;
end;


Procedure ttributacao.Pc_InformaRegimeTributarioSimplesNacionalManual(Pc_Prod:TProd;Pc_Imposto:TImposto);
Var
  Lc_Ok : Boolean;
Begin
  with  Pc_Imposto do
  Begin
    //Verifica se há tributação pelo Simples Nacional
    ICMS.CSOSN := StrToCSOSNIcms(Qr_Tributacao.FieldByName('CSOSN_ICMS').AsString);
    ICMS.modBC := StrTomodBC(Lc_OK,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);


    ICMS.vBC    := Fn_CalcBaseICMS(Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency, IPI.vIPI, 0);
    ICMS.pICMS  := Qr_ItensPedido.FieldByName('ITF_AQ_ICMS').AsCurrency;
    ICMS.pRedBC := Qr_Tributacao.FieldByName('TRB_RD_AQ_ICMS').AsCurrency;
    ICMS.vICMS  := RoundTo(ICMS.vBC * ((ICMS.pICMS - ICMS.pRedBC) / 100), -2);
    //credito ICMS
    ICMS.pCredSN     := RoundTo(It_Aq_Cred_Icms, -2); //Alíquota aplicável de cálculo do crédito (Simples Nacional).
    ICMS.vCredICMSSN := RoundTo((FValorMercadoria * It_Aq_Cred_Icms) / 100, -2); //Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)
    //TRIBUTADA PELO SIMPLES NACIONAL COM PERMISSÃO DE CRÉDITO
    if (ICMS.CSOSN = csosn101) then
    Begin
      exit;
    end;
    //Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=102, 103, 300 ou 400 (v.2.0)
    if (ICMS.CSOSN = csosn102) or (ICMS.CSOSN = csosn103) or
       (ICMS.CSOSN = csosn300) or (ICMS.CSOSN = csosn400) then
    Begin
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;
    //201- Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por Substituição Tributária v.2.0)
    if (ICMS.CSOSN = csosn201) then
    Begin
      //ICMS Normal S.T - IPI sempre integra a base ST (Lei Kandir)
      ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
      ICMS.pMVAST   := MargemValorAgregado;
      ICMS.pRedBCST := 0;
      ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, 0, ICMS.pMVAST);
      ICMS.pICMSST := It_aliq_Interna_St_Icms;
      ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
      //ICMS Normal - Zera os valores depois de feito o cálculo
      ICMS.vBC    := 0;
      ICMS.pICMS  := 0;
      ICMS.pRedBC := 0;
      ICMS.vICMS  := 0;
      exit;
    end;
    //202- Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS por Substituição Tributária
    //203- Isenção do ICMS nos Simples Nacional para faixa de receita bruta e com cobrança do ICMS por Substituição Tributária  (v.2.0)
    if (ICMS.CSOSN = csosn202) OR (ICMS.CSOSN = csosn203) then
    Begin
      //ICMS Normal S.T - IPI sempre integra a base ST (Lei Kandir)
      ICMS.modBCST  := StrTomodBCST(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString);
      ICMS.pMVAST   := MargemValorAgregado;
      ICMS.pRedBCST := 0;
      ICMS.vBCST   := Fn_CalcBaseICMSST(IPI.vIPI, Pc_Prod.vFrete, Pc_Prod.vSeg, Pc_Prod.vOutro, 0, ICMS.pMVAST);
      ICMS.pICMSST := It_aliq_Interna_St_Icms;
      ICMS.vICMSST := RoundTo((ICMS.vBCST * (ICMS.pICMSST / 100)) - ICMS.vICMS, -2);
      //ICMS Normal - Zera os valores depois de feito o cálculo
      ICMS.vBC    := 0;
      ICMS.pICMS  := 0;
      ICMS.pRedBC := 0;
      ICMS.vICMS  := 0;
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;
    //500 É ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação (v.2.0)
    if (ICMS.CSOSN = csosn500) then
    Begin
      ICMS.pMVAST     := 0;
      ICMS.pRedBCST   := 0;
      ICMS.vBCST      := 0;
      ICMS.pICMSST    := 0;
      ICMS.vICMSST    := 0;
      ICMS.vBCSTRet   := 0;
      ICMS.vICMSSTRet := 0;
      exit;
    end;
    //Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=900 (v2.0)
    if (ICMS.CSOSN = csosn900) then
    Begin
      exit;
    end;
  end;
end;

Procedure ttributacao.Pc_DefineIPI(Pc_Prod:Tprod; Pc_Imposto:TImposto);
Var
  Lc_Ok:Boolean;
Begin
  with Pc_Imposto do
  Begin
    if Trim(Qr_Tributacao.FieldByName('CST_IPI').AsString) <> '' then
    Begin
      IPI.CST := StrToCSTIPI(Lc_Ok, Qr_Tributacao.FieldByName('CST_IPI').AsString);
      IPI.cEnq := '999';   //Tabela a ser criada pela RFB, informar 999 enquanto a tabela não for criada
      if (IPI.CST = ipi00) or (IPI.CST = ipi49) or (IPI.CST = ipi50) or (IPI.CST = ipi99) then
      Begin
        IPI.vBC  := FValorMercadoria;

        IPI.vBC  := IPI.vBC + Pc_Prod.vFrete; //+ Pc_Prod.vSeg + Pc_Prod.vOutro ; precisamos avaliar se podemos incluir os restante

        IPI.vBC  := RoundTo(IPI.vBC,-2);
        if (Qr_Tributacao.FieldByName('TRB_AQ_IPI').AsCurrency > 0) then
          IPI.pIPI := Qr_Tributacao.FieldByName('TRB_AQ_IPI').AsCurrency
        else
          IPI.pIPI := Qr_ItensPedido.FieldByName('ITF_AQ_IPI').AsCurrency;
        IPI.vIPI   := IPI.vBC * (IPI.pIPI/100);
        IPI.vIPI  := RoundTo(IPI.vIPI,-2);
      end
    END;
  end;
end;

procedure ttributacao.Pc_DefineIBSCBS(Pc_Prod:TProd;Pc_Imposto: TImposto);
begin
  FTaxes.Registro.Institution := Gb_CodMha;
  FTaxes.Registro.ID          := Qr_Tributacao.FieldByName('TB_TAXES_ID').AsInteger;
  FTaxes.getByKey;
  if FTaxes.exist then
  Begin
    with Pc_Imposto.IBSCBS do
    Begin
      CST := StrToCSTIBSCBS(Copy(FTaxes.Registro.cst,1,3));
      cClassTrib := FTaxes.Registro.classtrib;
    End;

    Pc_DefineIBSCBS_IBS_Base(Pc_Prod, Pc_Imposto);

    Pc_DefineIBSCredPres(Pc_Prod, Pc_Imposto);
    Pc_DefineCBSCredPres(Pc_Prod, Pc_Imposto);
    Pc_DefineTribCompraGov(Pc_Prod, Pc_Imposto);
    Pc_DefineIBSCBSMono(Pc_Prod, Pc_Imposto);
    Pc_DefinegTransfCred(Pc_Prod, Pc_Imposto);

    Pc_DefineIBSCBS_IBS_MUN(Pc_Prod, Pc_Imposto);
    Pc_DefineIBSCBS_IBS_UF(Pc_Prod, Pc_Imposto);
    Pc_DefineIBSCBS_CBS(Pc_Prod, Pc_Imposto);
    Pc_DefineIBSCBS_Tribregular(Pc_Prod, Pc_Imposto);

    Pc_DefineIBSCBS_IBS_valor(Pc_Prod, Pc_Imposto);
  End;
end;

procedure ttributacao.Pc_DefineIBSCBSMono(Pc_Prod: TProd; Pc_Imposto: TImposto);
begin
  {RFT - Grupo de Informações do IBS e CBS em operações com imposto monofásico
  with Imposto.IBSCBS.gIBSCBSMono do
  Begin
    //nformar a BC quantidade conforme unidade de medida estabelecida na legislação para o produto
    qBCMono;
    adRemIBS;
    adRemCBS;
    //O valor do imposto é obtido pela multiplicação da alíquota ad rem pela quantidade do produto conforme unidade de medida estabelecida na legislação
    vIBSMono;
    //O valor do imposto é obtido pela multiplicação da alíquota ad rem pela quantidade do produto conforme unidade de medida estabelecida na legislação.
    vCBSMono;

    //Uso em operações com combustíveis derivados de petróleo (Gasolina A) [ou *Óleo Diesel A*] para retenção do imposto sobre o biocombustível a ser misturado. Art. 178 da LC 214/2025.
    //Informar a BC sujeita a retenção em quantidade conforme unidade de medida estabelecida na legislação para o produto
    qBCMonoReten;
    adRemIBSReten;
    //Valor do IBS com retenção, a ser somado ao valor de IBS a ser recolhido.
    vIBSMonoReten;
    adRemCBSReten;
    //Valor da CBS com retenção, a ser somado ao valor de CBS a ser recolhido.
    vCBSMonoReten;

    //Tributação monofásica própria sobre combustíveis cobrada anteriormente
    //Informar a BC do IBS em quantidade conforme unidade de medida estabelecida na legislação
    qBCMonoRet;
    //Alíquota ad rem do IBS, estabelecida na legislação para o produto
    adRemIBSRet;
    //O valor do IBS é obtido pela multiplicação da alíquota ad rem pela quantidade do produto conforme unidade de medida estabelecida na legislaçã
    vIBSMonoRet;
    //Alíquota ad rem da CBS, estabelecida na legislação para o produto
    adRemCBSRet;
    //O valor da CBS é obtido pela multiplicação da alíquota ad rem pela quantidade do produto conforme unidade de medida estabelecida na legislação
    vCBSMonoRet;
    //Operações com diferimento, aplicado aos biocombustíveis. Exemplo: operação do produtor de biocombustível (usina).
    //A ser aplicado em vIBSMono
    pDifIBS;
    //A ser deduzido do valor do IBS
    vIBSMonoDif;
    //A ser aplicado em vCBSMono
    pDifCBS;
    //A ser deduzido do valor da CBS
    vCBSMonoDif;
    vTotIBSMonoItem;
    vTotCBSMonoItem;
  End; }

end;

procedure ttributacao.Pc_DefineIBSCBS_CBS(Pc_Prod:TProd;Pc_Imposto:TImposto);
begin
  {RFT - Grupo de Informações da CBS  }
  with Pc_Imposto.IBSCBS.gIBSCBS.gCBS do
  Begin
    //Alíquota da CBS (tag: pCBS) deve ser igual a 0,9% para documento com data de emissão no ano de 2026. Art. 346 da LC 214/2025.
     pCBS := FTaxes.CBS.Registro.aliquota;

    //Se informado grupo do Diferimento (gCBS/gDif): - Valor do Diferimento (vDif) deverá ser resultante da Base de Cálculo x Percentual da CBS x Percentual do Diferimento (vBC x pCBS x pDif)
    //Observação: Aceitar uma tolerância de 0,01 a mais ou a menos.
    if (FTaxes.CBS.Registro.aliq_dif > 0) then
    Begin
      gDif.pDif := FTaxes.CBS.Registro.aliq_dif;
      gDif.vDif := 0;
      if pCBS > 0 then
      Begin
        gDif.vDif := (Pc_Imposto.IBSCBS.gIBSCBS.vBC * (pCBS / 100) * (gDif.pDif / 100));
        gDif.vDif := RoundTo(gDif.vDif, -2);
      End;
    End;
    //Grupo usado para registrar a devolução de tributos no fornecimento de energia elétrica, água, esgoto, gás natural e em outras hipóteses definidas no regulamento
    gDevTrib.vDevTrib := 0;

    gRed.pRedAliq :=  FTaxes.CBS.Registro.aliq_red;

    //Alíquota efetiva, após aplicação da redução de alíquota, incluindo o gCompraGov/pRedutor, se houver.
    //pAliqEfet = pCBS *(1 - pRedAliq)*(1 - tag: gCompraGov/pRedutor)
    gRed.pAliqEfet :=  FTaxes.CBS.Registro.aliq_efe;
    gRed.pAliqEfet := pCBS * (1 - gRed.pRedAliq/100);
    gRed.pAliqEfet := RoundTo(gRed.pAliqEfet, -4);
    {Se informado grupo CBS (gCBS): - Valor da CBS (vCBS) deverá ser resultante da Base de Cálculo x Alíquota (vBC [tag: gIBSCBS/vBC] x pCBS) - vDif - vDevTrib
     Observação 1: Aceitar uma tolerância de 0,01 a mais ou a menos.
     Observação 2: Em caso de preenchimento do grupo de redução (pRed) a alíquota utilizada deverá ser a tag Alíquota Efetiva (pAliqEfet).
     - Valor da CBS (vCBS) deverá ser resultante da Base de Cálculo x Alíquota (vBC [tag: gIBSCBS/vBC] x gRed/pAliqEfet) - vDif - vDevTrib
     Observação 3: Conforme cClass escolhido o valor do crédito presumido (vCredPres) deve ser subtraído do total da CBS.
     Se grupo gRed preenchido: vCBS = gRed/pAliqEfet * vBC (UB16) Senão: vCBS = pCBS * vBC
     Alíquota no cadastro é em percentual (ex: 5, 18, 0,9) portanto divide por 100 no cálculo.}
    if (gRed.pAliqEfet>0) then
    Begin
      vCBS :=  ( Pc_Imposto.IBSCBS.gIBSCBS.vBC * (gRed.pAliqEfet / 100) ) - gDif.vDif - gDevTrib.vDevTrib;
      vCBS := RoundTo(vCBS, -2);
    End;
  End;

end;

procedure ttributacao.Pc_DefineIBSCBS_IBS_Base(Pc_Prod:TProd;Pc_Imposto:TImposto);
begin
  //CST IBS/CBS
  with Pc_Imposto.IBSCBS.gIBSCBS do
  Begin
    //Valor da Base de cálculo do IBS e CBS (gIBSCBS/vBC) deve ser igual ao
    //somatório de:
    //(+) vProd (+) vServ (+) vFrete (+) vSeg (+) vOutro (+) vII
    //(-) vDesc (-) vPIS (-) vCOFINS (-) vICMS (-) vICMSUFDest (-) vFCP (-) vFCPUFDest (-) vICMSMono (-) vISSQN (+) vIS
    //Exceção 1: Não subtrair o valor do PIS por Substituição Tributária (PIST/vPIS) quando compor o valor total da NF-e (se indSomaPISST=1);
    vBC :=   Pc_Prod.vProd
             + Pc_Prod.vSeg
             + Pc_Prod.vOutro
             + Pc_Imposto.II.vII
             - Pc_Prod.vDesc
             - Pc_Imposto.PIS.vPIS
             - Pc_Imposto.COFINS.vCOFINS
             - Pc_Imposto.ICMS.vICMS
             - Pc_Imposto.ICMS.vicms
             - Pc_imposto.ICMSUFDest.vICMSUFDest
             - Pc_Imposto.ICMS.vFCp
             - Pc_Imposto.ICMSUFDest.vFCPUFDest
             //- vICMSMono
             - Pc_Imposto.ISSQN.vISSQN
             + Pc_Imposto.ISel.vIS;
    vBC := RoundTo(vBC, -2);

  End;

end;

procedure ttributacao.Pc_DefineIBSCBS_IBS_MUN(Pc_Prod:TProd;Pc_Imposto:TImposto);
begin
  {RFT - Grupo de Informações do IBS para o município
   Alíquota do IBS do município (tag: pIBSMun) deve ser igual a 0 para documento com data de emissão no ano de 2026. Art. 344 da LC 214/2025
   Alíquota do IBS do município (tag: pIBSMun) deve ser igual a 0,05% para documento com data de emissão nos anos de 2027 e 2028. Art. 344 da LC 214/2025
   Alíquota vigente do IBS do Município }
  with Pc_Imposto.IBSCBS.gIBSCBS.gIBSMun do
  Begin
    pIBSMun := FTaxes.IBS_Mun.Registro.aliquota;

    //Grupo de Informações do Diferimento
    if FTaxes.IBS_Mun.Registro.aliq_dif > 0 then
    Begin
      gDif.pDif := FTaxes.IBS_Mun.Registro.aliq_dif;
      gDif.vDif := 0;
      if pIBSMun > 0 then
      Begin
        gDif.vDif := Pc_Imposto.IBSCBS.gIBSCBS.vBC * (pIBSMun / 100) * (gDif.pDif / 100);
        gDif.vDif := RoundTo(gDif.vDif, -2);
      End;
    End;

    {RFT - Grupo usado para registrar a devolução de tributos no fornecimento de energia elétrica, água, esgoto, gás natural e em outras hipóteses definidas no regulamento
    Valor do tributo devolvido ("cashback" de desconto na Fatura)}
    gDevTrib.vDevTrib := 0;

    gRed.pRedAliq   := FTaxes.IBS_MUN.Registro.aliq_red;

    {RFT - Grupo de informações da redução da alíquota
    Alíquota efetiva, após aplicação da redução de alíquota, incluindo o gCompraGov/pRedutor, se houver.
    pAliqEfet = pIBSMun *(1 - pRedAliq)*(1 - tag: gCompraGov/pRedutor)
    Se grupo gRed preenchido: vIBSMun = gRed/pAliqEfet * vBC (UB16) Senão: vIBSMun = pIBSMun * vBC}
    gRed.pAliqEfet :=  FTaxes.IBS_Mun.Registro.aliq_efe;
    gRed.pAliqEfet := pIBSMun * (1 - gRed.pRedAliq/100);
    gRed.pAliqEfet := RoundTo(gRed.pAliqEfet, -4);

    {Se informado grupo IBS de competência do Município (gIBSMun):
    - Valor do IBS (vIBSMun) deverá ser resultante da Base de Cálculo x Alíquota (vBC [tag: gIBSCBS/vBC] x pIBSMun) - vDif - vDevTrib
    Observação 1: Aceitar uma tolerância de 0,01 a mais ou a menos.
    Observação 2: Em caso de preenchimento do grupo de redução (pRed) a alíquota utilizada deverá ser a tag Alíquota Efetiva (pAliqEfet).
    - Valor do IBS (vIBSMun) deverá ser resultante da Base de Cálculo x Alíquota (vBC [tag: gIBSCBS/vBC] x pAliqEfet [tag:gRed/pAliqEfet]) - vDif - vDevTrib
    Observação 3: Conforme cClass escolhido o valor do crédito presumido (vCredPres) deve ser subtraído do total do IBS.
      vIBSMun;
    Alíquota no cadastro é em percentual (ex: 0,05, 5) portanto divide por 100 no cálculo.}
    if (gRed.pAliqEfet >0) then
    bEGIN
      vIBSMun         := ( Pc_Imposto.IBSCBS.gIBSCBS.vBC * (gRed.pAliqEfet / 100) ) - gDif.vDif - gDevTrib.vDevTrib;
      vIBSMun := RoundTo(vIBSMun, -2);
    end;
  End;
end;

procedure ttributacao.Pc_DefineIBSCBS_IBS_UF(Pc_Prod:TProd;Pc_Imposto:TImposto);
begin
  with Pc_Imposto.IBSCBS.gIBSCBS.gIBSUF do
  Begin
    //Alíquota do IBS da UF (tag: pIBSUF) deve ser igual a 0,1% para documento com data de emissão no ano de 2026. Art. 343 da LC 214/25
    //Alíquota do IBS da UF (tag: pIBSUF) deve ser igual a: - 0,05% para documento com data de emissão nos anos de 2027 e 2028. Art. 344 da LC 214/25.
    pIBSUF := FTaxes.IBS_UF.Registro.aliquota;
    //Se informado grupo do Diferimento (gIBSUF/gDif): -
    //Valor do Diferimento (vDif) deverá ser resultante da Base de Cálculo x Percentual do IBS da UF x Percentual do Diferimento (vBC x pIBSUF x pDif)
    //Nota: Aceitar uma tolerância de 0,01 a mais ou a menos
    if FTaxes.IBS_UF.Registro.aliq_dif > 0 then
    Begin
      gDif.pDif := FTaxes.IBS_UF.Registro.aliq_dif;
      gDif.vDif := 0;
      if pIBSUF >0  then
      Begin
        gDif.vDif := Pc_Imposto.IBSCBS.gIBSCBS.vBC * (pIBSUF / 100) * (gDif.pDif / 100);
        gDif.vDif := RoundTo(gDif.vDif, -2);
      End;
    End;


    //RFT - Grupo usado para registrar a devolução de tributos no fornecimento de energia elétrica, água, esgoto, gás natural e em outras hipóteses definidas no regulamento.
    gDevTrib.vDevTrib := 0;

    gRed.pRedAliq   := FTaxes.IBS_UF.Registro.aliq_red;

    gRed.pAliqEfet :=  FTaxes.IBS_UF.Registro.aliq_efe;
    gRed.pAliqEfet := pIBSUF * (1 - gRed.pRedAliq/100);
    gRed.pAliqEfet := RoundTo(gRed.pAliqEfet, -4);

    {RFT -
    Se informado grupo de Redução de Alíquota (gCBS/gRed)
    Valor da alíquota efetiva (pAliqEfet) deve ser igual a aplicação da redução da alíquota da CBS (pRedAliq) na alíquota da CBS (pCBS).
    Exemplo: Redução de 40% na alíquota:
    Alíquota vigente (A): 10%
    Redução na alíquota (R): 40%
    Redutor de compras governamentais (RG): 5%
    Alíquota Efetiva (E): E = A * (1 - R)*(1-RG)
                      E = 10 * (1 - 0,4) *(1-0,05) = 5,7
    Alíquota efetiva, após aplicação da redução de alíquota, incluindo o gCompraGov/pRedutor, se houver.
    pAliqEfet = pIBSUF*(1 - pRedAliq)*(1 - tag:  gCompraGov/pRedutor)

    RFT - Se grupo gRed preenchido: vIBSUF = gRed/pAliqEfet * vBC (UB16) Senão: vIBSUF = pIBSUF * vBC
    Alíquota no cadastro é em percentual (ex: 0,1, 5) portanto divide por 100 no cálculo.}
    if (gRed.pAliqEfet > 0) then
    Begin
      vIBSUF :=  ( Pc_Imposto.IBSCBS.gIBSCBS.vBC * (gRed.pAliqEfet / 100) ) - gDif.vDif - gDevTrib.vDevTrib;
      vIBSUF := RoundTo(vIBSUF, -2);
    End;
  End;
end;

procedure ttributacao.Pc_DefineIBSCBS_IBS_Valor(Pc_Prod: TProd;
  Pc_Imposto: TImposto);
begin
  //CST IBS/CBS
  with Pc_Imposto.IBSCBS.gIBSCBS do
  Begin
    vIBS := gIBSUF.vIBSUF + gIBSMun.vIBSMun;
    vIBS := RoundTo(vIBS, -2);
  End;
end;

procedure ttributacao.Pc_DefineIBSCBS_Tribregular(Pc_Prod:TProd;Pc_Imposto:TImposto);
begin
  {RFT -  Grupo de informações da Tributação Regular. Informar como seria a tributação caso não cumprida a condição resolutória/suspensiva.
          Exemplo 1: Art. 445, §4 da LC 214/2025.
          Operações com ZFM e ALC.
          Exemplo 2: Operações com suspensão do tributo.}
  with Pc_Imposto.IBSCBS.gIBSCBS.gTribRegular do
    Begin
      CSTReg              :=  Pc_Imposto.IBSCBS.CST;
      cClassTribReg       :=  Pc_Imposto.IBSCBS.cClassTrib;
      pAliqEfetRegIBSUF   :=  Pc_Imposto.IBSCBS.gIBSCBS.gIBSUF.pIBSUF;
      vTribRegIBSUF       :=  Pc_Imposto.IBSCBS.gIBSCBS.gIBSUF.vIBSUF;
      pAliqEfetRegIBSMun  :=  Pc_Imposto.IBSCBS.gIBSCBS.gIBSMun.pIBSMun;
      vTribRegIBSMun      :=  Pc_Imposto.IBSCBS.gIBSCBS.gIBSMun.vIBSMun;
      pAliqEfetRegCBS     :=  Pc_Imposto.IBSCBS.gIBSCBS.gCBS.pCBS;
      vTribRegCBS         :=  Pc_Imposto.IBSCBS.gIBSCBS.gCBS.vCBS;
    End;

end;

procedure ttributacao.Pc_DefineIBSCredPres(Pc_Prod: TProd;
  Pc_Imposto: TImposto);
begin
  {RFT - Grupo de Informações do Crédito Presumido do IBS, quando aproveitado pelo emitente do documento }
  {
  with Imposto.IBSCBS.gIBSCBS.gIBSCredPres do
  Begin
    //Utilizar tabela cCredPres (Anexo IV).
    //Exemplos:
    //1 - Aquisição de Produtor Rural não contribuinte.
    //2 - Tomador de serviço de transporte de TAC PF não contrib.
    //3 - Aquisição de pessoa física com destino a reciclagem.
    //4 - Aquisição de bens móveis de PF não contrib. para revenda (veículos / brechó).
    //5 - Regime opcional para cooperativa
    cCredPres.cp01;
    pCredPres;
    vCredPres;
    //Valor do Crédito Presumido Condição Suspensiva. Preencher apenas para cCredPres com indicação de Condição Suspensiva
    vCredPresCondSus;
  End;
  }

end;

Procedure ttributacao.Pc_DefineII(Pc_Imposto:TImposto);
Begin
  with Pc_Imposto do
  Begin
    if Qr_Tributacao.FieldByName('TRB_AQ_II').AsFloat > 0 then
    Begin
      II.vBc       := FValorMercadoria;
      II.vBc       := RoundTo(II.vBc,-2);
      II.vDespAdu  := 0;
      II.vII       := (II.vBc * (Qr_Tributacao.FieldByName('TRB_AQ_II').AsFloat)/100);
      II.vII       := RoundTo(II.vII,-2);
      II.vIOF      := 0;
    end;
  end;
end;

Procedure ttributacao.Pc_DefinePIS(Pc_Imposto:TImposto);
Var
  Lc_Ok :Boolean;
  LcValorBase : REal;
BEgin
  with Pc_Imposto do
  Begin
    PIS.CST  := pis07;
    PIS.vBC   := 0;
    PIS.pPIS  := 0;
    PIS.vPIS  := 0;
    if (Qr_Tributacao.FieldByName('TRB_AQ_PIS').AsCurrency > 0) or (Qr_Tributacao.FieldByName('CST_PIS').AsString <> '') then
    Begin
      //Define a Situação tributária do PISPIS
      PIS.CST  := StrToCSTPIS( Qr_Tributacao.FieldByName('CST_PIS').AsString);
      LcValorBase := FValorMercadoria;
      LcValorBase := Roundto(LcValorBase,-2);
      if (PIS.CST = pis01) OR (PIS.CST = pis02) then
      Begin
        PIS.vBC   := LcValorBase;
        PIS.pPIS  := Qr_Tributacao.FieldByName('TRB_AQ_PIS').AsCurrency;
        PIS.vPIS  := PIS.vBC * (PIS.pPIS / 100);
        PIS.vPIS  := RoundTo(PIS.vPIS,-2);
      end
      else
      Begin
        if (PIS.CST = pis03) then
        Begin
          PIS.qBCProd   := (Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat);
          PIS.vAliqProd := Qr_ItensPedido.FieldByName('ITF_VL_UNIT').AsCurrency;
        end
        else
        Begin
          if (PIS.CST = pis99) then
          Begin
            PIS.vBC   := LcValorBase;
            if (PIS.vBC > 0) then
            Begin
              PIS.pPIS  := Qr_Tributacao.FieldByName('TRB_AQ_PIS').AsCurrency
            end
            else
            Begin
              PIS.qBCProd   := (Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat);
              PIS.vAliqProd := Qr_ItensPedido.FieldByName('ITF_VL_UNIT').AsCurrency;
            end;
          end
          else
          Begin
            PIS.vBC   := LcValorBase;
            PIS.pPIS  := Qr_Tributacao.FieldByName('TRB_AQ_PIS').AsCurrency;
            PIS.vPIS  := PIS.vBC * (PIS.pPIS / 100);
            PIS.vPIS  := RoundTo(PIS.vPIS,-2);
          End;
        End;
      End;
    end;
  end;
end;

Procedure ttributacao.Pc_DefineCOFINS(Pc_Imposto:TImposto);
Var
  Lc_Ok :Boolean;
  LcValorBase : REal;
BEgin
  with Pc_Imposto do
  Begin
    //Define a Situação tributária do COFINS COM ISENTA PARA NA SEQUENCIA FOR SETADA AS VARIAVEIS SE HOUVER
    COFINS.CST     := cof07;
    COFINS.vBC     := 0;
    COFINS.pcofins := 0;
    COFINS.vCOFINS := 0;
    if ( Qr_Tributacao.FieldByName('TRB_AQ_COFINS').AsCurrency > 0 ) or ( Qr_Tributacao.FieldByName('CST_COFINS').AsString <> '') then
    Begin
      //Define a Situação tributária do COFINS
      COFINS.CST   := StrToCSTCOFINS(Qr_Tributacao.FieldByName('CST_COFINS').AsString);
      LcValorBase := FValorMercadoria;
      LcValorBase := Roundto(LcValorBase,-2);
      if (COFINS.CST = cof01) OR (COFINS.CST = cof02) then
      Begin
        COFINS.vBC     := LcValorBase;
        COFINS.pcofins := Qr_Tributacao.FieldByName('TRB_AQ_COFINS').AsCurrency;
        COFINS.vCOFINS := COFINS.vBC * (COFINS.pcofins / 100);
        COFINS.vCOFINS := RoundTo(COFINS.vCOFINS,-2);
      end
      else
      Begin
        if (COFINS.CST = cof03) then
        Begin
          COFINS.qBCProd   := Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat;
          COFINS.vAliqProd := Qr_ItensPedido.FieldByName('ITF_VL_UNIT').AsCurrency;
        end
        else
        Begin
          if (COFINS.CST = cof99) then
          Begin
            COFINS.vBC     := LcValorBase;
            if (COFINS.vBC > 0) then
            Begin
              COFINS.pcofins := Qr_Tributacao.FieldByName('TRB_AQ_COFINS').AsCurrency;
              COFINS.vCOFINS := COFINS.vBC * (COFINS.pcofins / 100);
              COFINS.vCOFINS := RoundTo(COFINS.vCOFINS,-2);
            end
            else
            Begin
              COFINS.qBCProd   := Qr_ItensPedido.FieldByName('ITF_QTDE').AsFloat;
              COFINS.vAliqProd := Qr_ItensPedido.FieldByName('ITF_VL_UNIT').AsCurrency;
            end;
          end
          else
          Begin
            COFINS.vBC     := LcValorBase;
            COFINS.pcofins := Qr_Tributacao.FieldByName('TRB_AQ_COFINS').AsCurrency;
            COFINS.vCOFINS := COFINS.vBC * (COFINS.pcofins / 100);
            COFINS.vCOFINS := RoundTo(COFINS.vCOFINS,-2);
          End;
        End;
      End;
    end;
  end;
end;

procedure ttributacao.Pc_DefineISel(Pc_Imposto: TImposto);
begin
  {
  Pc_Imposto.ISel.CSTIS.cstis000;
  Pc_Imposto.ISel.cClassTribIS.ctis000001;
  Pc_Imposto.ISel.vBCIS;
  Pc_Imposto.ISel.pIS;
  Pc_Imposto.ISel.pISEspec;
  Pc_Imposto.ISel.uTrib;
  Pc_Imposto.ISel.qTrib;
  Pc_Imposto.ISel.vIS;
  }
end;

Procedure ttributacao.Pc_DefineISSQN(Pc_Imposto:TImposto);
Var
  Lc_Ok:Boolean;
BEgin
  with Pc_Imposto do
  BEgin
    ICMS.orig     := StrToOrig(Qr_ItensPedido.FieldByName('PRO_ORIGEM').AsString);
    ICMS.CST      := StrToCSTICMS(Qr_Tributacao.FieldByName('CST_ICMS').AsString);
    ICMS.modBC    := StrTomodBC(Lc_Ok,Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString);
    ISSQN.vBC     := FValorMercadoria;
    ICMS.vBC      := ICMS.vBC - (ICMS.vBC * (Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency / 100));
    ISSQN.vBC     := RoundTo(ISSQN.vBC,-2);
    ISSQN.vDeducao  := Qr_ItensPedido.FieldByName('ITF_VL_DESC').AsCurrency;
    ISSQN.vAliq     := NotaFiscal.Pedido.Endereco.Cidade.Registro.AliqISS;

    ISSQN.vISSQN := (ISSQN.vBC * ISSQN.vAliq ) /100;

    //Alterado para arrendondar 2 vasas para atender o Barela no dia 24/05/2018

    ISSQN.vISSQN := RoundTo(ISSQN.vISSQN,-2);

    ISSQN.cMunFG := Estabelecimento.Endereco.Cidade.Registro.IBGE;

    ISSQN.cListServ := It_CODSRV116;


    if ( NotaFiscal.pedido.cliente.Registro.issretido = 'S') then

    Begin

      ISSQN.indISSRet := StrToindISSRet(Lc_Ok,'1');

      ISSQN.vISSRet := ISSQN.vISSQN;

    end

    else

    Begin

      ISSQN.indISSRet := StrToindISSRet(Lc_Ok,'2');

      ISSQN.vISSRet := 0;

    end;

    ISSQN.vOutro := 0; //Outras REtenções

    ISSQN.vDescIncond := 0;

    ISSQN.vDescCond := 0;

    //1=Exigível, 2=Não incidência; 3=Isenção; 4=Exportação; 5=Imunidade; 6=Exigibilidade Suspensa por Decisão Judicial; 7=Exigibilidade Suspensa por Processo Administrativo;

    ISSQN.indISS := StrToindISS(Lc_Ok,IntToStr(StrToIntDef( NotaFiscal.pedido.cliente.Registro.IssExigibilidade,0) + 1));

    ISSQN.cServico := Qr_ItensPedido.FieldByName('ITF_CODPRO').Asstring;

    ISSQN.cMunFG :=  NotaFiscal.pedido.Endereco.cidade.Registro.ibge;

    ISSQN.cPais :=   NotaFiscal.pedido.endereco.Pais.Registro.bacen;

    ISSQN.nProcesso := NotaFiscal.pedido.cliente.Registro.IssNumeroProcesso;

    if ( NotaFiscal.pedido.Cliente.Registro.IssIncentivoFiscal = 'S') then

      ISSQN.indIncentivo := TindIncentivo.iiSim

    else

      ISSQN.indIncentivo := TindIncentivo.iiNao;

  end;

end;

Procedure ttributacao.Pc_SomaValorBaseICMS(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vBC := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vBC := Total.ICMSTot.vBC + RoundTo(Det.Items[Lc_I].Imposto.ICMS.vBC,-2);

    end;

  end;
end;

procedure ttributacao.Pc_SomaValorIBSCBS(Pc_Nfe: TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe.Total.IBSCBSTot do
  BEgin
    vBCIBSCBS              := 0;
    gIBS.gIBSUFTot.vDif       := 0;
    gIBS.gIBSUFTot.vDevTrib   := 0;
    gIBS.gIBSUFTot.vIBSUF     := 0;

    gIBS.gIBSMunTot.vDif      := 0;
    gIBS.gIBSMunTot.vDevTrib  := 0;
    gIBS.gIBSMunTot.vIBSMun   := 0;

    gIBS.vIBS                 := 0;
    gIBS.vCredPres            := 0;
    gIBS.vCredPresCondSus     := 0;

    gCBS.vDif                 := 0;
    gCBS.vDevTrib             := 0;
    gCBS.vCBS                 := 0;
    gCBS.vCredPres            := 0;
    gCBS.vCredPresCondSus     := 0;

    gMono.vIBSMono            := 0;
    gMono.vCBSMono            := 0;
    gMono.vIBSMonoReten       := 0;
    gMono.vCBSMonoReten       := 0;
    gMono.vIBSMonoRet         := 0;
    gMono.vCBSMonoRet         := 0;

    For Lc_I:= 0 to (Pc_Nfe.Det.Count - 1) do
    Begin
      vBCIBSCBS              := vBCIBSCBS + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.vBC, -2);

      gIBS.gIBSUFTot.vDif     := gIBS.gIBSUFTot.vDif + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.vDif, -2);
      gIBS.gIBSUFTot.vDevTrib := gIBS.gIBSUFTot.vDevTrib + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSUF.gDevTrib.vDevTrib, -2);
      gIBS.gIBSUFTot.vIBSUF   := gIBS.gIBSUFTot.vIBSUF + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSUF.vIBSUF, -2);

      gIBS.gIBSMunTot.vDif     := gIBS.gIBSMunTot.vDif + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.vDif, -2);
      gIBS.gIBSMunTot.vDevTrib := gIBS.gIBSMunTot.vDevTrib + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSMun.gDevTrib.vDevTrib, -2);
      gIBS.gIBSMunTot.vIBSMun  := gIBS.gIBSMunTot.vIBSMun + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSMun.vIBSMun, -2);

      gIBS.vIBS := gIBS.vIBS + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.vIBS, -2);

      gCBS.vDif             := gCBS.vDif + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gCBS.gDif.vDif, -2);
      gCBS.vDevTrib         := gCBS.vDevTrib + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gCBS.gDevTrib.vDevTrib, -2);
      gCBS.vCBS := gCBS.vCBS + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gCBS.vCBS, -2);

      gMono.vIBSMono       := gMono.vIBSMono      + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoPadrao.vIBSMono, -2);
      gMono.vCBSMono       := gMono.vCBSMono      + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoPadrao.vCBSMono, -2);
      gMono.vIBSMonoReten  := gMono.vIBSMonoReten + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoReten.vIBSMonoReten, -2);
      gMono.vCBSMonoReten  := gMono.vCBSMonoReten + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoReten.vCBSMonoReten, -2);
      gMono.vIBSMonoRet    := gMono.vIBSMonoRet   + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoRet.vIBSMonoRet, -2);
      gMono.vCBSMonoRet    := gMono.vCBSMonoRet   + RoundTo(Pc_Nfe.Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoRet.vCBSMonoRet, -2);
    End;
  end;

end;

Procedure ttributacao.Pc_SomaValorICMS(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vICMS := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vICMS := Total.ICMSTot.vICMS + Det.Items[Lc_I].Imposto.ICMS.vICMS;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorBaseICMSST(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vBCST := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vBCST := Total.ICMSTot.vBCST + Det.Items[Lc_I].Imposto.ICMS.vBCST;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorICMSST(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vST := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vST := Total.ICMSTot.vST + Det.Items[Lc_I].Imposto.ICMS.vICMSST;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorProduto(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
  lc_ok : Boolean;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vProd := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      IF (Det.Items[Lc_I].Prod.IndTot = StrToindTot(lc_ok,'1')) then

      Begin

        Total.ICMSTot.vProd := Total.ICMSTot.vProd + Det.Items[Lc_I].Prod.vProd ;

      End;


    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorFrete(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vFrete := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vFrete := Total.ICMSTot.vFrete + Det.Items[Lc_I].Prod.vFrete;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorSeguro(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vSeg := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vSeg := Total.ICMSTot.vSeg + Det.Items[Lc_I].Prod.vSeg;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorDesconto(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vDesc := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vDesc := Total.ICMSTot.vDesc + Det.Items[Lc_I].Prod.vDesc;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorII (Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vII := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vII := Total.ICMSTot.vII + Det.Items[Lc_I].imposto.II.vII;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorIPI(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vIPI := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vIPI := Total.ICMSTot.vIPI + Det.Items[Lc_I].imposto.IPI.vIPI;

    end;

  end;

end;

Procedure ttributacao.Pc_SomaValorPIS (Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vPIS := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vPIS := Total.ICMSTot.vPIS + Det.Items[Lc_I].imposto.PIS.vPIS;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorCFS(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vCOFINS := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vCOFINS := Total.ICMSTot.vCOFINS + Det.Items[Lc_I].imposto.COFINS.vCOFINS;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorOutros(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vOutro := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vOutro := Total.ICMSTot.vOutro + Det.Items[Lc_I].Prod.vOutro;

    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorISSQN(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
  lc_ok: Boolean;
Begin
  with Pc_Nfe do
  BEgin
    Total.ISSQNtot.vServ := 0;
    Total.ISSQNtot.vBC := 0;
    Total.ISSQNtot.vISS := 0;
    Total.ISSQNtot.vISSRet :=0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      IF (Det.Items[Lc_I].Prod.IndTot = StrToindTot(lc_ok,'2')) then

      Begin

        Total.ISSQNtot.vServ := Total.ISSQNtot.vServ + Det.Items[Lc_I].imposto.ISSQN.vBc + Det.Items[Lc_I].imposto.ISSQN.vDeducao;

        Total.ISSQNtot.vDeducao := Total.ISSQNtot.vDeducao + Det.Items[Lc_I].imposto.ISSQN.vDeducao;

        Total.ISSQNtot.vBC := Total.ISSQNtot.vBC + Det.Items[Lc_I].imposto.ISSQN.vBc;

        Total.ISSQNtot.vISS := Total.ISSQNtot.vISS + Det.Items[Lc_I].imposto.ISSQN.vISSQN;
        Total.ISSQNtot.vISSRet := Total.ISSQNtot.vISSRet + Det.Items[Lc_I].imposto.ISSQN.vISSRet;
      end;
    end;

  end;
end;

Procedure ttributacao.Pc_SomaValorAproximImposto(Pc_Nfe:TNFe);
Var
  Lc_I:Integer;
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vTotTrib := 0;
    For Lc_I:= 0 to (Det.Count - 1) do

    Begin

      Total.ICMSTot.vTotTrib := Total.ICMSTot.vTotTrib + Det.Items[Lc_I].Imposto.vTotTrib;

    end;

  end;
end;



Procedure ttributacao.Pc_SomaValorTotalNota(Pc_Nfe:TNFe);
Begin
  with Pc_Nfe do
  BEgin
    Total.ICMSTot.vNF := (Total.ICMSTot.vST +
                          Total.ICMSTot.vProd +
                          Total.ICMSTot.vFrete +
                          Total.ICMSTot.vSeg +
                          Total.ICMSTot.vOutro +
                          Total.ICMSTot.vIPI +
                          Total.ISSQNtot.vServ +
                          Total.ICMSTot.vIPIDevol) -
                          Total.ICMSTot.vDesc; 
  end;
end;


function ttributacao.tributaFCP(ncm: String): Real;
Var
  LcTam : Integer;
  LcSubNCM : String;
  LcCompara:String;
begin
  //variavel NCM vem completa por que vem do produto
  //variavel FieldByName('NCM').AsString vem da tabela FCP
  Result := 0;
  with Qr_Uf_FCP_NCM do
  Begin
    first;
    while not eof do
    BEgin
      LcCompara := FieldByName('NCM').AsString;
      LcTam := Length( LcCompara );
      LcSubNCM := Copy(NCM,1,LcTam);
      if ( LcCompara = LcSubNCM ) then
      Begin
        Result := FieldByName('ALIQUOTA').AsFloat;
        Break;
      End;
      next;
    End;
  End;
end;

procedure ttributacao.Pc_DadosdoTransporte(Pc_Nfe:TNFe);
Begin

end;

procedure ttributacao.Pc_DefineRemetente(Pc_Nfe:TNFe);
Var
Lc_Aux :String;
Lc_Ok : Boolean;
BEgin
  with Pc_Nfe, Estabelecimento do
  Begin
    Emit.CNPJCPF           := Registro.CpfCNPJ;
    Emit.xNome             := copy( Registro.NomeRazaoSocial,1,60);
    Emit.xFant             := copy( Registro.ApelidoFantasia,1,60);
    Emit.EnderEmit.xLgr    := Copy( Endereco.Registro.Logradouro,1,60);
    Emit.EnderEmit.nro     := Endereco.Registro.NumeroPredial;
    Emit.EnderEmit.xCpl    := Endereco.Registro.Complemento;
    Emit.EnderEmit.xBairro := Endereco.Registro.Bairro;
    Emit.EnderEmit.cMun    := Endereco.Cidade.Registro.IBGE;
    Emit.EnderEmit.xMun    := Endereco.Cidade.Registro.Descricao;
    Emit.EnderEmit.UF      := Endereco.Uf.Registro.Sigla;
    Emit.EnderEmit.CEP     := Endereco.Registro.Cep.ToInteger;
    Emit.enderEmit.cPais   := Endereco.Pais.Registro.Bacen;
    Emit.enderEmit.xPais   := Endereco.Pais.Registro.Descricao;
    Emit.EnderEmit.fone    := Endereco.Registro.Fone;
    //Inscrição estadual
    Lc_Aux                 := Registro.InscricaoEstadual;
    Lc_Aux                 := Fc_RemoveCaracterInformado(Lc_Aux,  ['.',',','/','-']);
    Emit.IE                := Lc_Aux;
    //Verifica se é nota Conjugada
    Emit.CRT := StrToCRT(Lc_Ok,IntToStr( Estabelecimento.Registro.CodigoRegimeTributario ) );

  end;

end;

procedure ttributacao.Pc_DefineTribCompraGov(Pc_Prod: TProd;
  Pc_Imposto: TImposto);
begin
  {RFT - Grupo de informações da composição do valor do IBS e da CBS em compras governamentais
  with Imposto.IBSCBS.gIBSCBS.gTribCompraGov do
  Begin
    pAliqIBSUF;
    //Valor que seria devido a UF, sem aplicação do Art. 473. da LC 214/2025
    vTribIBSUF;
    pAliqIBSMun;
    //Valor que seria devido ao município, sem aplicação do Art. 473. da LC 214/2025
    vTribIBSMun;
    pAliqCBS;
    //Valor que seria devido a CBS, sem aplicação do Art. 473. da LC 214/2025
    vTribCBS;
  End;}

end;

procedure ttributacao.Pc_DefineDestinatario(Pc_Nfe:TNFe);
BEgin
  with Pc_Nfe, NotaFiscal.pedido do
  Begin
    Dest.CNPJCPF           := Empresa.Registro.CpfCNPJ;
    Dest.EnderDest.CEP     := Endereco.Registro.Cep.ToInteger;
    Dest.EnderDest.cMun    := Endereco.Cidade.Registro.IBGE;
    Dest.EnderDest.UF      := Endereco.Uf.Registro.Sigla;

    case StrToIntDef(Empresa.Registro.IndicadorInscricaoEstadual,1) of
      1:Dest.indIEDest := inContribuinte;
      2:Dest.indIEDest := inIsento;
      9:Dest.indIEDest := inNaoContribuinte;
    else
      Dest.indIEDest := inContribuinte;
    end;

    if Length( Empresa.Registro.CpfCNPJ) > 11 then
      Dest.IE := TRIM(Empresa.Registro.InscricaoEstadual )
    else
      Dest.IE              := '';
    Dest.EnderDest.xLgr    := Endereco.Registro.Logradouro;
    Dest.EnderDest.nro     := Endereco.Registro.NumeroPredial;
    Dest.EnderDest.xBairro := Endereco.Registro.Bairro;
    Dest.EnderDest.xMun    := Endereco.Cidade.Registro.Descricao;
    Dest.EnderDest.Fone    := Endereco.Registro.Fone;
    Dest.EnderDest.xCpl    := Endereco.Registro.Complemento;
    Dest.xNome             := Copy(Empresa.Registro.Codigo.ToString + ' - ' + Empresa.Registro.NomeRazaoSocial ,1,60);
    Dest.EnderDest.cPais   := Endereco.Pais.Registro.Bacen;
    Dest.EnderDest.xPais   := Endereco.Pais.Registro.Descricao;
  end;
End;

procedure ttributacao.Pc_DefinegTransfCred(Pc_Prod: TProd;
  Pc_Imposto: TImposto);
begin
  {RFT -  Transferências de Crédito
  with Imposto.IBSCBS.gTransfCred do
  Begin
    vIBS
    vCBS
  End;}

  {RFT - Informações do crédito presumido de IBS para fornecimentos a partir da ZFM
  with Imposto.IBSCBS.gCredPresIBSZFM.tpCredPresIBSZFM do
  Begin
    //Classificação conforme percentuais definidos no art. 450, § 1º, da LC 214/25 para o cálculo do crédito presumido:
    //0 - Sem Crédito Presumido
    //1 - Bens de consumo final (55%)
    //2 - Bens de capital (75%)
    //3 - Bens intermediários (90,25%)
    //4 - Bens de informática e outros definidos em legislação (100%)
    tcpBensConsumoFinal;
    //É obrigatório para nota de crédito com tpNFCredito = 02 - Apropriação de crédito presumido de IBS sobre o saldo devedor na ZFM (art. 450, § 1º, LC 214/25)
    //Vedado para documentos que não sejam nota de crédito com tpNFCredito = 02 - Apropriação de crédito presumido de IBS sobre o saldo devedor na ZFM (art. 450, § 1º, LC 214/25)
    vCredPresIBSZFM;
  End;}
end;

procedure ttributacao.Pc_DefineCasasDecimais;
Var
  Lc_Nr_CasaDecimal : Integer;
  LcValor : Real;
BEgin
  //Define Quantas Casas Decimais para o Valor
  Qr_ItensPedido.First;
  Lc_Nr_CasaDecimal := 0;
  It_Nfe.DANFE.CasasDecimais.vUnCom := 2;
  with Qr_ItensPedido do
  Begin
    while not Eof do
    begin
      LcValor := (FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').asfloat);
      Lc_Nr_CasaDecimal := Fc_NumeroCasaDecima(FloatToStrF(LcValor,ffFixed,10,6));
      if Lc_Nr_CasaDecimal > It_Nfe.DANFE.CasasDecimais.vUnCom then
        It_Nfe.DANFE.CasasDecimais.vUnCom := Lc_Nr_CasaDecimal;
      Next;
    end;
    It_Nfe.DANFE.CasasDecimais.vUnCom := Lc_Nr_CasaDecimal;
    //Define Quantas Casas Decimais para a Quantidade
    First;
    Lc_Nr_CasaDecimal := 0;
    It_Nfe.DANFE.CasasDecimais.qCom := 2;
    while not Eof do
    begin
      Lc_Nr_CasaDecimal := Fc_NumeroCasaDecima(FloatToStrF(FieldByName('ITF_QTDE').AsFloat,ffFixed,10,4));
      if Lc_Nr_CasaDecimal > It_Nfe.DANFE.CasasDecimais.qCom then
        It_Nfe.DANFE.CasasDecimais.qCom := Lc_Nr_CasaDecimal;
      Next;
    end;
  End;
end;

procedure ttributacao.Pc_DefineCBSCredPres(Pc_Prod: TProd;
  Pc_Imposto: TImposto);
begin
  {RFT - Grupo de Informações do Crédito Presumido da CBS, quando aproveitado pelo emitente do documento
  with Imposto.IBSCBS.gIBSCBS.gCBSCredPres do
  Begin
    //Utilizar tabela cCredPres (Anexo IV).
    //Exemplos:
    //1 - Aquisição de Produtor Rural não contribuinte.
    //2 - Tomador de serviço de transporte de TAC PF não contrib.
    //3 - Aquisição de pessoa física com destino a   reciclagem.
    //4 - Aquisição de bens móveis de PF não contrib. para revenda (veículos / brechó).
    //5 - Regime opcional para cooperativa.
    cCredPres.cp01;
    pCredPres;
    vCredPres;
    //Valor do Crédito Presumido Condição Suspensiva. Preencher apenas para cCredPres com indicação de Condição Suspensiva.
    vCredPresCondSus;
  End;}

end;

procedure ttributacao.Pc_Busca_Obs(Fc_Grupo:String);
begin
  with Qr_Observacao do
  Begin
    Active := False;
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    ParamByName('TBI_GRUPO').AsString := Fc_Grupo;
    Active := True;
  END;
end;


procedure ttributacao.Pc_Obs_NotaFiscal(Pc_Obs:TMemo);
Begin
  Pc_InfoRevendaVeiculos(Pc_Obs,NotaFiscal.Registro.CodigoPedido);
  if Length(Trim(Pc_Obs.Text)) > 0 then
  Begin
    //Registra a Observação
    with NotaFiscal.Observacoes do
    Begin
      Registro.Codigo   := 0;
      Registro.ItemNota := 0;
      Registro.Nota     := NotaFiscal.Registro.Codigo;
      Registro.Tipo     := 'M';
      Registro.Conteudo := Pc_Obs.Text;
    End;
    NotaFiscal.Observacoes.insert;
  end;
  IF Qr_Tributacao.RecordCount > 0 then
  Begin
    if ( Fc_Tb_Geral('GRL_G_IMPOSTO_APROX','S') = 'S') then
    Begin
      if pos('VENDA',UpperCase(Qr_Tributacao.FieldByName('NAT_DESCRICAO').AsString))>0 then
        Fc_Obs_ImpostoAproximado();
    End;

    //Observação Fiscal
    Pc_Obs_Regra_Geral;
    if (Estabelecimento.Registro.CodigoRegimeTributario = 3) or (Estabelecimento.Registro.CodigoRegimeTributario = 2) then
    Begin
      Pc_Obs_CST00;
      Pc_Obs_CST10;
      Pc_Obs_CST20;
      Pc_Obs_CST30;
      Pc_Obs_CST40;
      Pc_Obs_CST50;
      Pc_Obs_CST60;
      Pc_Obs_CST70;
      Pc_Obs_CST80;
      Pc_Obs_CST90;
    end
    else
    Begin
      Pc_Obs_CSOSN101;
      Pc_Obs_CSOSN102;
      Pc_Obs_CSOSN103;
      Pc_Obs_CSOSN201;
      Pc_Obs_CSOSN202;
      Pc_Obs_CSOSN203;
      Pc_Obs_CSOSN300;
      Pc_Obs_CSOSN400;
      Pc_Obs_CSOSN500;
      Pc_Obs_CSOSN900;
    end;
    Pc_Obs_ISSQN;
  end;
end;

procedure ttributacao.Pc_Obs_NFC_E(Pc_Obs: String);
begin
  if Length(Trim(Pc_Obs)) > 0 then
  Begin
    //Registra a Observação
    with NotaFiscal.Observacoes do
    Begin
      Registro.Codigo   := 0;
      Registro.ItemNota := 0;
      Registro.Nota     := NotaFiscal.Registro.Codigo;
      Registro.Tipo     := 'M';
      Registro.Conteudo := Pc_Obs;
    End;
    NotaFiscal.Observacoes.insert;
  end;
end;

procedure ttributacao.Pc_Obs_NF_Servico(Pc_Obs:TMemo);
Begin
  if Length(Trim(Pc_Obs.Text)) > 0 then
  Begin
    //Registra a Observação
    with NotaFiscal.Observacoes do
    Begin
      Registro.Codigo   := 0;
      Registro.ItemNota := 0;
      Registro.Nota     := NotaFiscal.Registro.Codigo;
      Registro.Tipo     := 'S';
      Registro.Conteudo := Pc_Obs.Text;
    End;
    NotaFiscal.Observacoes.insert;
  end;
End;

Procedure ttributacao.Pc_Obs_Regra_Geral;
begin
  It_M_Fisco.Clear;
  With Qr_Observacao do
  Begin
    Active := False;
    IF not Transaction.InTransaction then Transaction.StartTransaction;
    close;
    Sql.Clear;
    SQL.Add('SELECT DISTINCT OBS_CODIGO, OBS_DETALHES '+
            'FROM TB_OBSERVACAO tb_observacao '+
            'WHERE (OBS_GERAL = ''2'')  '+
            ' AND (OBS_CODMHA =:OBS_CODMHA)  ');
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    Active := True;
    First;

    while not Eof do
    begin
      It_M_Fisco.Text := RetiraEnter(FieldByName('OBS_DETALHES').AsString);
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
      Next;
    end;
  End;
end;

procedure ttributacao.Pc_Obs_CST00;
begin
  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    SQL.Add('select distinct  '+
            '  OBS_DETALHES   '+
            'FROM TB_ITENS_ICMS '+
            '  INNER JOIN TB_TRIB_ICMS_NR         '+
            '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
            '  INNER JOIN TB_OBSERVACAO           '+
            '  ON (OBS_CODIGO = ICM_CODOBS)       '+
            'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
            ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
            ' AND (TBI_GRUPO Like ''00'') ');

    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Clear;
      It_M_Fisco.Text := RetiraEnter(FieldByName('OBS_DETALHES').AsString);
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CST10;
Var
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    SQL.Add('select '+
             '   CAST(COALESCE(SUM(ICM_VL_BC_ST), 0) AS NUMERIC(18, 2)) ICM_bASE '+
             '  ,CAST(COALESCE(SUM(ICM_VL_ST), 0) AS NUMERIC(18, 2)) ICM_VALOR '+
             '  ,OBS_DETALHES '+
             'FROM TB_ITENS_ICMS '+
             '  INNER JOIN TB_TRIB_ICMS_NR '+
             '  ON (TBI_CODIGO = ICM_CODTBI_NR) '+
             '  INNER JOIN TB_OBSERVACAO '+
             '  ON (OBS_CODIGO = ICM_CODOBS) '+
             'WHERE (ICM_CODNFL=:NFL_CODIGO) '+
             '  AND (TBI_GRUPO = ''10'') '+
             ' AND (OBS_CODMHA =:OBS_CODMHA) '+
             'GROUP BY OBS_DETALHES ');

    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_vl_Bc_St := FieldByName('ICM_BASE').AsFloat;
      Lc_vl_St    := FieldByName('ICM_VALOR').AsCurrency;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
      // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&b', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 2&b representa o Segundo valor da Observação que é a valor
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_St,ffFixed,10,2), [rfreplaceAll]));
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;

end;

procedure ttributacao.Pc_Obs_CST20;
Var
  Lc_Aq_Rd_bc : Real;
  Lc_SqlTxt : String;
Begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    SQL.Add('select DISTINCT                      '+
             '   ICM_AQ_RD_BC_NR                   '+
             '  ,OBS_DETALHES                      '+
             'FROM TB_ITENS_ICMS                   '+
             '  INNER JOIN TB_TRIB_ICMS_NR         '+
             '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
             '  INNER JOIN TB_OBSERVACAO           '+
             '  ON (OBS_CODIGO = ICM_CODOBS)       '+
             'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
             '  AND (TBI_GRUPO = ''20'')           '+
             ' AND (OBS_CODMHA =:OBS_CODMHA)       ');

    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_Aq_Rd_bc := FieldByName('ICM_AQ_RD_BC_NR').AsFloat;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_Aq_Rd_bc,ffFixed,10,2), [rfreplaceAll]));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CST30;
Var
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
begin
  IT_M_Fisco.Clear;
  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    SQL.Add('select                               '+
             '   CAST(COALESCE(SUM(ICM_VL_BC_ST), 0) AS NUMERIC(18, 2)) ICM_bASE        '+
             '  ,CAST(COALESCE(SUM(ICM_VL_ST), 0) AS NUMERIC(18, 2)) ICM_VALOR          '+
             '  ,OBS_DETALHES                      '+
             'FROM TB_ITENS_ICMS                   '+
             '  INNER JOIN TB_TRIB_ICMS_NR         '+
             '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
             '  INNER JOIN TB_OBSERVACAO           '+
             '  ON (OBS_CODIGO = ICM_CODOBS)       '+
             'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
             '  AND (TBI_GRUPO = ''30'')           '+
             ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
             'GROUP BY OBS_DETALHES                ');

    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_vl_Bc_St := FieldByName('ICM_BASE').AsFloat;
      Lc_vl_St    := FieldByName('ICM_VALOR').AsCurrency;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 2&b representa o Segundo valor da Observação que é a valor
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_St,ffFixed,10,2), [rfreplaceAll]));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CST40;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    SQL.Add('select distinct                      '+
             '  OBS_DETALHES                        '+
             'FROM TB_ITENS_ICMS                   '+
             '  INNER JOIN TB_TRIB_ICMS_NR         '+
             '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
             '  INNER JOIN TB_OBSERVACAO           '+
             '  ON (OBS_CODIGO = ICM_CODOBS)       '+
             'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
             ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
             ' AND (TBI_GRUPO Like ''4%'')        ');

    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
        //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CST50;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    SQL.Add('select distinct                      '+
             '  OBS_DETALHES                       '+
             'FROM TB_ITENS_ICMS                   '+
             '  INNER JOIN TB_TRIB_ICMS_NR         '+
             '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
             '  INNER JOIN TB_OBSERVACAO           '+
             '  ON (OBS_CODIGO = ICM_CODOBS)       '+
             'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
             ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
             ' AND (TBI_GRUPO Like ''5%'')        ');

    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CST60;
Var
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  Begin
    close;
    Sql.Clear;
    SQL.Add('select '+
             '   CAST(COALESCE(SUM(ICM_VL_BC_ST_RET), 0) AS NUMERIC(18, 2)) ICM_bASE    '+
             '  ,CAST(COALESCE(SUM(ICM_VL_ST_RET), 0) AS NUMERIC(18, 2)) ICM_VALOR      '+
             '  ,OBS_DETALHES                      '+
             'FROM TB_ITENS_ICMS                   '+
             '  INNER JOIN TB_TRIB_ICMS_NR         '+
             '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
             '  INNER JOIN TB_OBSERVACAO           '+
             '  ON (OBS_CODIGO = ICM_CODOBS)       '+
             'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
             ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
             ' AND (TBI_GRUPO Like ''6%'')         '+
             'GROUP BY OBS_DETALHES                ');
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_vl_Bc_St := FieldByName('ICM_BASE').AsFloat;
      Lc_vl_St    := FieldByName('ICM_VALOR').AsCurrency;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 2&b representa o Segundo valor da Observação que é a valor
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_St,ffFixed,10,2), [rfreplaceAll]));
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CST70;
Var
  Lc_Aq_rd_Bc_Nr : Real;
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  Begin
    IF not Transaction.InTransaction then Transaction.StartTransaction;
    close;
    Sql.Clear;
    Lc_SqlTxt := 'select                               '+
                 '   CAST(COALESCE(SUM(ICM_VL_BC_ST_RET), 0) AS NUMERIC(18, 2)) ICM_bASE    '+
                 '  ,CAST(COALESCE(SUM(ICM_VL_ST_RET), 0) AS NUMERIC(18, 2)) ICM_VALOR      '+
                 '  ,OBS_DETALHES                      '+
                 '  ,ICM_AQ_RD_BC_NR                   '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_NR         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO Like ''7%'')         '+
                 'GROUP BY OBS_DETALHES, ICM_AQ_RD_BC_NR ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_vl_Bc_St := FieldByName('ICM_BASE').AsFloat;
      Lc_vl_St    := FieldByName('ICM_VALOR').AsCurrency;
      Lc_Aq_rd_Bc_Nr := FieldByName('ICM_AQ_RD_BC_NR').AsFloat;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
      // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 2&b representa o Segundo valor da Observação que é a valor
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_St,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 3&R representa o Terceiro Valor da Observação que é a Redução da Base de Calculo
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '3&v', FloatToStrF(Lc_Aq_rd_Bc_Nr,ffFixed,10,2), [rfreplaceAll]));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CST80;
Begin

end;

procedure ttributacao.Pc_Obs_CST90;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 '  OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_NR         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO Like ''9%'')         ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN101;
Var
  Lc_Aq : Real;
  Lc_VL : Real;
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    IF not Transaction.InTransaction then Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 '  CAST(COALESCE(SUM(ICM_AQ_CALC_CRED), 0) AS DOUBLE PRECISION) ICM_AQ       '+
                 ' ,CAST(COALESCE(SUM(ICM_VL_CRED_APRO), 0) AS NUMERIC(18, 2)) ICM_VL       '+
                 ' ,OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''101'')           '+
                 'GROUP BY OBS_DETALHES                ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_Aq := StrToFloatDef(Fc_Tb_Geral('GRL_G_AQ_CRED_ICMS',''),0);
      Lc_VL := FieldByName('ICM_VL').AsCurrency;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      // O simbolo 1&b representa o Primeiro valor da Observação que é a valor
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_VL,ffFixed,10,2), [rfreplaceAll]));

      // O simbolo 2&b representa o Segunda valor da Observação que é a Aliquota
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_Aq,ffFixed,10,2), [rfreplaceAll]));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN102;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    IF not Transaction.InTransaction then Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 '  OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''102'')           ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
        //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;



procedure ttributacao.Pc_Obs_CSOSN103;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    IF not Transaction.InTransaction then Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 '  OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''103'')           ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN201;
Var
  Lc_vl_bc_st : Real;
  Lc_vl_st : Real;
  Lc_Aq : Real;
  Lc_VL : Real;
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    IF not Transaction.InTransaction then Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct  '+
                 '  CAST(COALESCE(SUM(ICM_VL_BC_ST), 0) AS NUMERIC(18, 2)) ICM_bASE        '+
                 ' ,CAST(COALESCE(SUM(ICM_VL_ST), 0) AS NUMERIC(18, 2)) ICM_VALOR          '+
                 ' ,CAST(COALESCE(SUM(ICM_AQ_CALC_CRED), 0) AS DOUBLE PRECISION) ICM_AQ      '+
                 ' ,CAST(COALESCE(SUM(ICM_VL_CRED_APRO), 0) AS NUMERIC(18, 2)) ICM_VL       '+
                 ' ,OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''201'')           '+
                 'GROUP BY OBS_DETALHES                ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_Aq := StrToFloatDef(Fc_Tb_Geral('GRL_G_AQ_CRED_ICMS',''),0);
      Lc_VL := FieldByName('ICM_VL').AsCurrency;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      // O simbolo 1&b representa o Primeiro valor da Observação que é a valor
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_VL,ffFixed,10,2), [rfreplaceAll]));

      // O simbolo 2&b representa o Segunda valor da Observação que é a Aliquota
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_Aq,ffFixed,10,2), [rfreplaceAll]));
      Lc_vl_bc_st := FieldByName('ICM_bASE').AsFloat;
      Lc_vl_st := FieldByName('ICM_VALOR').AsCurrency;
      Lc_Aq := FieldByName('ICM_AQ').AsFloat;
      Lc_VL := FieldByName('ICM_VL').AsCurrency;
      // O simbolo 1&b representa o primeiro valor da Observação que é a base
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_bc_st,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 2&b representa o Segundo valor da Observação que é a valor do ICMS_sT
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_st,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 1&b representa o Terceiro valor da Observação que é a Aliquota
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '3&v', FloatToStrF(Lc_Aq,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 2&b representa o Quarta valor da Observação que é a valor
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '4&v', FloatToStrF(Lc_VL,ffFixed,10,2), [rfreplaceAll]));
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;

end;

procedure ttributacao.Pc_Obs_CSOSN202;
Var
  Lc_vl_bc_st : Real;
  Lc_vl_st : Real;
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    IF not Transaction.InTransaction then Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 '  CAST(COALESCE(SUM(ICM_VL_BC_ST), 0) AS NUMERIC(18, 2)) ICM_bASE        '+
                 ' ,CAST(COALESCE(SUM(ICM_VL_ST), 0) AS NUMERIC(18, 2)) ICM_VALOR          '+
                 ' ,OBS_DETALHES                      '+
                 'FROM TB_ITENS_ICMS                  '+
                 '  INNER JOIN TB_TRIB_ICMS_SN        '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)   '+
                 '  INNER JOIN TB_OBSERVACAO          '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)      '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)      '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)      '+
                 ' AND (TBI_GRUPO = ''202'')          '+
                 'GROUP BY OBS_DETALHES               ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      Lc_vl_bc_st := FieldByName('ICM_bASE').AsFloat;
      Lc_vl_st := FieldByName('ICM_VALOR').AsCurrency;
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
      // O simbolo 1&b representa o primeiro valor da Observação que é a base
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_bc_st,ffFixed,10,2), [rfreplaceAll]));
      // O simbolo 2&b representa o Segundo valor da Observação que é a valor do ICMS_sT
      It_M_Fisco.Text := (StringReplace(It_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_st,ffFixed,10,2), [rfreplaceAll]));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN203;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 ' OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''203'')           ';


    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN300;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 ' OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''300'')           ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN400;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 ' OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''400'')           ';


    SQL.Add(Lc_SqlTxt);
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN500;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
  IF not Transaction.InTransaction then Transaction.StartTransaction;
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 ' OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''500'')           ';


    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;

procedure ttributacao.Pc_Obs_CSOSN900;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select distinct                      '+
                 ' OBS_DETALHES                       '+
                 'FROM TB_ITENS_ICMS                   '+
                 '  INNER JOIN TB_TRIB_ICMS_SN         '+
                 '  ON (TBI_CODIGO = ICM_CODTBI_SN)    '+
                 '  INNER JOIN TB_OBSERVACAO           '+
                 '  ON (OBS_CODIGO = ICM_CODOBS)       '+
                 'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
                 ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
                 ' AND (TBI_GRUPO = ''900'')           ';


    SQL.Add(Lc_SqlTxt);
    ParamByName('OBS_CODMHA').AsInteger := NotaFiscal.Registro.CodigoEstabelecimento;
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (RecordCount > 0) THEN
    Begin
      It_M_Fisco.Add(RetiraEnter(FieldByName('OBS_DETALHES').AsString));

      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'F';
        Registro.Conteudo := RetiraEnter(It_M_Fisco.Text);
      End;
      NotaFiscal.Observacoes.insert;
    end;
  end;
end;


procedure ttributacao.Pc_Obs_ISSQN;
Var
  Lc_SqlTxt : String;
begin
  It_M_Fisco.Clear;
  with Qr_Observacao do
  begin
    Close;
    SQL.Clear;
    Lc_SqlTxt := 'select CAST(COALESCE(SUM(iss_vl_ret), 0) AS NUMERIC(18, 2)) valor '+
                 ' from tb_itens_issqn '+
                 ' where tb_itens_issqn.iss_codnfl =:NFL_CODIGO ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
    IF (FieldByName('valor').AsCurrency > 0) THEN
    Begin
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'A';
        Registro.Conteudo := 'Valor do ISSQN retido/Substituto Tributário: R$ ' + FloatToStrF(FieldByName('valor').AsCurrency,ffFixed,10,2);
      End;
    end;
  end;
end;

procedure ttributacao.Fc_Obs_ImpostoAproximado;
Var
  Lc_Qry:TSTQuery;
  Lc_Campo : String;
  Lc_Vl_Produto:Real;
  Lc_Vl_Base : Real;
  Lc_Imp_Aprox : TStringList;

  Lc_Tx_Imp_Nacional : real;
  Lc_Tx_Imp_Estadual : real;
  Lc_Tx_Imp_Municipal : real;

  Lc_Vl_Imp_Nacional : real;
  Lc_Vl_Imp_Estadual : real;
  Lc_Vl_Imp_Municipal : real;
  Lc_Obs : String;
Begin
  TRy
    Lc_Imp_Aprox := TStringList.Create;
    Lc_Qry := NotaFiscal.GeraQuery;
    with Lc_Qry do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('select ITF_VL_UNIT, ITF_QTDE, ITF_VL_DESC,PRO_CODIGONCM,PRO_ORIGEM '+
              'FROM TB_NOTA_FISCAL '+
              '  INNER JOIN tb_itens_nfl '+
              '  ON (ITF_CODNFL = NFL_CODIGO) '+
              '  INNER JOIN TB_PRODUTO '+
              '  ON (PRO_CODIGO = ITF_CODPRO) '+
              'WHERE NFL_CODIGO =:NFL_CODIGO ');
      ParamByName('NFL_CODIGO').AsInteger := NotaFiscal.Registro.Codigo;
      Active := True;
      First;
      Lc_Vl_Produto := 0;

      Lc_Vl_Base := 0;

      Lc_Tx_Imp_Nacional := 0;
      Lc_Tx_Imp_Estadual := 0;
      Lc_Tx_Imp_Municipal := 0;

      Lc_Vl_Imp_Nacional := 0;
      Lc_Vl_Imp_Estadual := 0;
      Lc_Vl_Imp_Municipal := 0;


      while not eof do
      Begin
        Lc_Imp_Aprox.Clear;
        Fc_ImpostoAproximado(Lc_Imp_Aprox,FieldByName('PRO_CODIGONCM').AsString,
                                             FieldByName('PRO_ORIGEM').AsString);
        Lc_Tx_Imp_Nacional  := StrToFloatDef(Lc_Imp_Aprox.Strings[0],0);
        Lc_Tx_Imp_Estadual  := StrToFloatDef(Lc_Imp_Aprox.Strings[1],0);
        Lc_Tx_Imp_Municipal := StrToFloatDef(Lc_Imp_Aprox.Strings[2],0);

        Lc_Vl_Base := FValorMercadoria;
        Lc_Vl_Base := RoundTo(Lc_Vl_Base,-2);
        Lc_Vl_Produto := Lc_Vl_Produto + Lc_Vl_Base;

        Lc_Vl_Imp_Nacional  := Lc_Vl_Imp_Nacional + (Lc_Vl_Base * (Lc_Tx_Imp_Nacional / 100));
        Lc_Vl_Imp_Estadual  := Lc_Vl_Imp_Estadual + (Lc_Vl_Base * (Lc_Tx_Imp_Estadual / 100));
        Lc_Vl_Imp_Municipal := Lc_Vl_Imp_Municipal + (Lc_Vl_Base * (Lc_Tx_Imp_Municipal / 100));

        next;
      end;
    end;

    //Verifica a media dos impostos
    Lc_Tx_Imp_Nacional  := (Lc_Vl_Imp_Nacional / Lc_Vl_Produto);
    Lc_Tx_Imp_Nacional  := (RoundTo(Lc_Tx_Imp_Nacional,-4))*100;
    Lc_Tx_Imp_Estadual  := (Lc_Vl_Imp_Estadual / Lc_Vl_Produto);
    Lc_Tx_Imp_Estadual  := (RoundTo(Lc_Tx_Imp_Estadual,-4))*100;
    Lc_Tx_Imp_Municipal := (Lc_Vl_Imp_Municipal / Lc_Vl_Produto);
    Lc_Tx_Imp_Municipal := (RoundTo(Lc_Tx_Imp_Municipal,-4))*100;

    //Registra a Observação
    Lc_Obs := '';
    if (Lc_Vl_Imp_Nacional > 0) then
    Begin
      Lc_Obs := 'Valor aprox Imp. Nacional R$ ' + FloatToStrF(Lc_Vl_Imp_Nacional,ffFixed,10,2) + ' ('+ FloatToStrF(Lc_Tx_Imp_Nacional,ffFixed,10,2) +')%'
    end;
    if (Lc_Vl_Imp_Estadual > 0) then
    Begin
      Lc_Obs := Lc_Obs + '| Imp. Estadual R$ ' + FloatToStrF(Lc_Vl_Imp_Estadual,ffFixed,10,2) + ' ('+ FloatToStrF(Lc_Tx_Imp_Estadual,ffFixed,10,2) +')%'
    end;
    if (Lc_Vl_Imp_Municipal > 0) then
    Begin
      Lc_Obs := Lc_Obs + '| Imp. Municipal R$ ' + FloatToStrF(Lc_Vl_Imp_Municipal,ffFixed,10,2) + ' ('+ FloatToStrF(Lc_Tx_Imp_Municipal,ffFixed,10,2) +')%'
    end;


    if (Trim(Lc_Obs)<> '') then
    Begin
      //Registra a Observação
      with NotaFiscal.Observacoes do
      Begin
        Registro.Codigo   := 0;
        Registro.ItemNota := 0;
        Registro.Nota     := NotaFiscal.Registro.Codigo;
        Registro.Tipo     := 'A';
        Registro.Conteudo := Lc_Obs;
      End;
      NotaFiscal.Observacoes.insert;
    end;
  Finally
    NotaFiscal.FinalizaQuery(Lc_Qry);
    Lc_Imp_Aprox.disposeOf;
  End;
end;

procedure ttributacao.Pc_InfoRevendaVeiculos(Pc_Lista: TMemo;Pc_Cd_Pedido:integer);
var
  Lc_I: Integer;
  Lc_Qry: TSTQuery;
begin
  if(Fc_Tb_Geral('PRO_G_LABEL_PRO','')= 'S') then
  begin
    Try
      Lc_Qry := NotaFiscal.GeraQuery;
      with Lc_Qry do
      BEgin
        Close;
        SQL.Clear;
        SQL.Add('SELECT DISTINCT PRO_CODIGOFAB AS PRO_CHASSI,          '+
                'PRO_CODIGOBAR AS PRO_PLACA, PRO_CODIGOFOR AS PRO_RENAVAN '+
                '  FROM TB_ITENS_NFL ITF                               '+
                '     INNER JOIN TB_PRODUTO PRO                        '+
                '     ON (PRO.PRO_CODIGO = ITF.ITF_CODPRO)             '+
                'WHERE ITF_CODPED=:ITF_CODPED                          ');
        ParamByName('ITF_CODPED').AsInteger := Pc_Cd_Pedido;
        Active := True;
        First;
        if RecordCount > 0 then
        begin
          if FieldByName('PRO_CHASSI').AsString <> '' then
            Pc_Lista.Lines.Add('  CHASSIS: '+ FieldByName('PRO_CHASSI').AsString);

          if FieldByName('PRO_PLACA').AsString <> '' then
            Pc_Lista.Lines.Add('  PLACA: '+ FieldByName('PRO_PLACA').AsString);

          if FieldByName('PRO_RENAVAN').AsString <> '' then
            Pc_Lista.Lines.Add('  RENAVAN: '+ FieldByName('PRO_RENAVAN').AsString);
        end;
      end;
    Finally
      NotaFiscal.FinalizaQuery(Lc_Qry);
    End;
  end;
end;



procedure ttributacao.Pc_AtualizaIBSCBS(Pc_Item: TDetCollectionItem);
begin
  if It_AutorizacaoNFE then
  Begin
    Pc_AtualizaIBSCBS_IBS(Pc_Item);
    Pc_AtualizaIBSCBS_IBS_UF(Pc_Item);
    Pc_AtualizaIBSCBS_IBS_MUN(Pc_Item);
    Pc_AtualizaIBSCBS_CBS(Pc_Item);
    Pc_AtualizaIBSCBS_Tribregular(Pc_Item);
  End;
end;

procedure ttributacao.Pc_AtualizaIBSCBS_CBS(Pc_Item: TDetCollectionItem);
begin
  //CBS
  with Pc_Item.Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
  Begin
    CBS.Registro.Codigo    := 0;
    CBS.Registro.IbscbsId  := Registro.Codigo;
    CBS.Registro.Pcbs      := gCBS.pCBS;
    CBS.Registro.Vcbs      := gCBS.vCBS;
    CBS.insert;
    //CBS - RED
    CBS.Red.Registro.LinkID    := CBS.Registro.Codigo;
    CBS.Red.Registro.Tipo      := 'CBS';
    CBS.Red.Registro.IBSCBS_ID := Registro.Codigo;
    CBS.Red.Registro.PREDALIQ  := gCBS.gRed.pRedAliq;
    CBS.Red.Registro.pAliqEfet := gCBS.gRed.pAliqEfet;
    CBS.Red.insert;
    //CBS - DIF
    CBS.Dif.Registro.LinkID     := CBS.Registro.Codigo;
    CBS.Dif.Registro.Tipo       := 'CBS';
    CBS.Dif.Registro.IBSCBS_ID  := Registro.Codigo;
    CBS.Dif.Registro.PDIF       := gCBS.gDif.pDif;
    CBS.Dif.Registro.VDIF       := gCBS.gDif.vDif;
    CBS.Dif.insert;
    //CBS - DEVTRIB
    CBS.DevTrib.Registro.LinkID    := CBS.Registro.Codigo;
    CBS.DevTrib.Registro.Tipo      := 'CBS';
    CBS.DevTrib.Registro.IBSCBS_ID := Registro.Codigo;
    CBS.DevTrib.Registro.VDEVTRIB  := gCBS.gDevTrib.vDevTrib;
    CBS.DevTrib.insert;
  End;

end;

procedure ttributacao.Pc_AtualizaIBSCBS_IBS(Pc_Item: TDetCollectionItem);
begin
  with Pc_Item,Qr_ItensPedido,NotaFiscal.Pedido.Itens do
  Begin
    //IBSCBS
    with Imposto.IBSCBS do
    Begin
      Ibscbs.Registro.Codigo    := 0;
      Ibscbs.Registro.Nota      := NotaFiscal.Registro.Codigo;
      Ibscbs.Registro.ItemNF    := FieldByName('ITF_CODIGO').AsInteger;
      Ibscbs.Registro.CST       := CSTIBSCBSToStr(CST);
      Ibscbs.Registro.CLASSTRIB := cClassTrib;
      Ibscbs.Registro.VBC       := gIBSCBS.vBC;
      Ibscbs.Registro.VIBS      := gIBSCBS.vIBS;
      Ibscbs.insert;
    End;
  End;

end;

procedure ttributacao.Pc_AtualizaIBSCBS_IBS_MUN(Pc_Item: TDetCollectionItem);
begin
  //IBS - MUN
  with Pc_Item.Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
  Begin
    IbsMun.Registro.Codigo    := 0;
    IbsMun.Registro.IbscbsId  := Registro.Codigo;
    IbsMun.Registro.Pibsmun   := gIBSMun.pIBSMun;
    IbsMun.Registro.Vibsmun   := gIBSMun.vIBSMun;
    IbsMun.insert;
    //IBS - MUN - RED
    IbsMun.Red.Registro.LinkID    := IbsMun.Registro.Codigo;
    IbsMun.Red.Registro.Tipo      := 'MUN';
    IbsMun.Red.Registro.IBSCBS_ID := Registro.Codigo;
    IbsMun.Red.Registro.PREDALIQ  := gIBSMun.gRed.pRedAliq;
    IbsMun.Red.Registro.pAliqEfet := gIBSMun.gRed.pAliqEfet;
    IbsMun.Red.insert;
    //IBS - MUN - DIF
    IbsMun.Dif.Registro.LinkID     := IbsMun.Registro.Codigo;
    IbsMun.Dif.Registro.Tipo       := 'MUN';
    IbsMun.Dif.Registro.IBSCBS_ID  := Registro.Codigo;
    IbsMun.Dif.Registro.PDIF       := gIBSMun.gDif.pDif;
    IbsMun.Dif.Registro.VDIF       := gIBSMun.gDif.vDif;
    IbsMun.Dif.insert;
    //IBS - MUN - DEVTRIB
    IbsMun.DevTrib.Registro.LinkID    := IbsMun.Registro.Codigo;
    IbsMun.DevTrib.Registro.Tipo      := 'MUN';
    IbsMun.DevTrib.Registro.IBSCBS_ID := Registro.Codigo;
    IbsMun.DevTrib.Registro.VDEVTRIB  := gIBSMun.gDevTrib.vDevTrib;
    IbsMun.DevTrib.insert;
  End;

end;

procedure ttributacao.Pc_AtualizaIBSCBS_IBS_UF(Pc_Item: TDetCollectionItem);
begin
  //IBS - UF
  with Pc_Item.Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
  Begin
    IbsUF.Registro.Codigo    := 0;
    IbsUF.Registro.IbscbsId  := Registro.Codigo;
    IbsUF.Registro.Pibsuf    := gIBSUF.pIBSUF;
    IbsUF.Registro.Vibsuf    := gIBSUF.vIBSUF;
    IbsUF.insert;
    //IBS - UF - RED
    IbsUF.Red.Registro.LinkID    := IbsUF.Registro.Codigo;
    IbsUF.Red.Registro.Tipo      := 'UF';
    IbsUF.Red.Registro.IBSCBS_ID := Registro.Codigo;
    IbsUF.Red.Registro.PREDALIQ  := gIBSUF.gRed.pRedAliq;
    IbsUF.Red.Registro.pAliqEfet := gIBSUF.gRed.pAliqEfet;
    IbsUF.Red.insert;
    //IBS - UF - DIF
    IbsUF.Dif.Registro.LinkID     := IbsUF.Registro.Codigo;
    IbsUF.Dif.Registro.Tipo       := 'UF';
    IbsUF.Dif.Registro.IBSCBS_ID  := Registro.Codigo;
    IbsUF.Dif.Registro.PDIF       := gIBSUF.gDif.pDif;
    IbsUF.Dif.Registro.VDIF       := gIBSUF.gDif.vDif;
    IbsUF.Dif.insert;
    //IBS - MUN - DEVTRIB
    IbsUF.DevTrib.Registro.LinkID    := IbsUF.Registro.Codigo;
    IbsUF.DevTrib.Registro.Tipo      := 'UF';
    IbsUF.DevTrib.Registro.IBSCBS_ID := Registro.Codigo;
    IbsUF.DevTrib.Registro.VDEVTRIB  := gIBSUF.gDevTrib.vDevTrib;
    IbsUF.DevTrib.insert;
  End;

end;

procedure ttributacao.Pc_AtualizaIBSCBS_Tribregular(
  Pc_Item: TDetCollectionItem);
begin
  //Tribregular
  with Pc_Item.Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
  Begin
    if gTribRegular.cClassTribReg = '550001' then
    Begin
      Tribregular.Registro.IbscbsId            := Registro.Codigo;
      Tribregular.Registro.Cstreg              := CSTIBSCBSToStr( gTribRegular.CSTReg );
      Tribregular.Registro.Cclasstribreg       := gTribRegular.cClassTribReg;
      Tribregular.Registro.Paliqefetregibsuf   := gTribRegular.pAliqEfetRegIBSUF;
      Tribregular.Registro.Vtribregibsuf       := gTribRegular.vTribRegIBSUF;
      Tribregular.Registro.Paliqefetregibsmun  := gTribRegular.Paliqefetregibsmun;
      Tribregular.Registro.Vtribregibsmun      := gTribRegular.vTribRegIBSMun;
      Tribregular.Registro.Paliqefetregcbs     := gTribRegular.pAliqEfetRegCBS;
      Tribregular.Registro.Vtribregcbs         := gTribRegular.Vtribregcbs;
      Tribregular.insert;
    End;
  End;

end;

procedure ttributacao.Pc_AtualizarItens;
Var
  Lc_I :Integer;
begin
  with Qr_ItensPedido do
  Begin
    First;
    Lc_I := 0;
    while not Eof do
    Begin
      if ( Estabelecimento.Registro.IndicadorInscricaoEstadual = '1') then
      Begin
        Fc_tributacao;
        Fc_DefineTributacao;
      End;
      Pc_AtualizarItensNota;
      if ( Estabelecimento.Registro.IndicadorInscricaoEstadual = '1') then
      Begin
        Pc_AtualizarItensICMS(It_Nfe.NotasFiscais[0].NFe.Det[Lc_I]);
        Pc_AtualizarItensIPI(It_Nfe.NotasFiscais[0].NFe.Det[Lc_I]);
        Pc_AtualizarItensPIS(It_Nfe.NotasFiscais[0].NFe.Det[Lc_I]);
        Pc_AtualizarItensCOFINS(It_Nfe.NotasFiscais[0].NFe.Det[Lc_I]);

        Pc_ControleRastreioICMSST(It_Nfe.NotasFiscais[0].NFe.Det[Lc_I]);

        Pc_AtualizaIBSCBS(It_Nfe.NotasFiscais[0].NFe.Det[Lc_I]);
      End;
      Pc_AtualizarItensISSQN(It_Nfe.NotasFiscais[0].NFe.Det[Lc_I]);
      next;
      inc(Lc_I);
    end;
  End;
end;

procedure ttributacao.Pc_AtualizarItensNota;
Var
  Lc_Custo: Real;
begin
  with Qr_ItensPedido do
  Begin
    IF FieldByName('ITF_OPER').AsString = 'C' then
    Begin
      if (FieldByName('ITF_VL_CUSTO').AsCurrency = 0) then
        Lc_Custo := FieldByName('PRO_VL_CUSTOMED').AsCurrency
      else
        Lc_Custo := FieldByName('ITF_VL_CUSTO').AsCurrency;

      IF (Lc_Custo = 0) or (FieldByName('ITF_VL_CUSTO').AsCurrency < FieldByName('ITF_VL_UNIT').AsCurrency) then
        lc_custo := FieldByName('ITF_VL_UNIT').AsCurrency;

    end
    else
    Begin
      if ( FieldByName('ITF_VL_CUSTO').AsCurrency <= FieldByName('PRO_VL_CUSTOMED').AsCurrency ) then
        lc_custo := FieldByName('PRO_VL_CUSTOMED').AsCurrency
      else
        Lc_Custo := FieldByName('ITF_VL_CUSTO').AsCurrency;
    end;

    Fc_ImpostoAproximado(It_Tx_Imp_Aprox,FieldByName('PRO_CODIGONCM').AsString,FieldByName('PRO_ORIGEM').AsString);

    NotaFiscal.Pedido.Itens.Registro.Codigo            := FieldByName('ITF_CODIGO').AsInteger;
    NotaFiscal.Pedido.Itens.Registro.CodigoNota        := NotaFiscal.Registro.Codigo;
    NotaFiscal.Pedido.Itens.Registro.ValorCusto        := Lc_Custo;
    NotaFiscal.Pedido.Itens.Registro.Sentido           := It_Sentido;
    NotaFiscal.Pedido.Itens.Registro.ImpostoAproximado := StrToFloatDef(It_Tx_Imp_Aprox.Strings[3],0);
    NotaFiscal.Pedido.Itens.atualizaFaturamento;
  end;
end;

procedure ttributacao.Pc_AtualizarItensICMS(Pc_Item:TDetCollectionItem);
begin
  if It_AutorizacaoNFE then
  Begin
    //Atualiza os itens Primarios da nota
    with Pc_Item,Qr_ItensPedido,NotaFiscal.Pedido.Itens do
    Begin
      ItensIcms.Registro.codigo             := 0;
      ItensIcms.Registro.Nota               := NotaFiscal.Registro.Codigo;
      ItensIcms.Registro.ItemNota           := FieldByName('ITF_CODIGO').AsInteger;
      ItensIcms.Registro.CST                := Qr_Tributacao.FieldByName('cst_CODIGO').AsInteger;
      ItensIcms.Registro.CSOSN              := Qr_Tributacao.FieldByName('CSOSN_CODIGO').AsInteger;
      ItensIcms.Registro.Origem             := FieldByName('PRO_ORIGEM').AsString;
      ItensIcms.Registro.Determinacao       := Qr_Tributacao.FieldByName('MODAL_ICMS_NR').AsString;
      ItensIcms.Registro.AliqRedBase        := Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency;
      ItensIcms.Registro.ValorBase          := RoundTo(Imposto.ICMS.vBC,-2);
      ItensIcms.Registro.Aliquota           := Imposto.ICMS.pICMS;
      ItensIcms.Registro.AliquotaReduzida   := Imposto.ICMS.pDif;
      ItensIcms.Registro.AliqRedBase        := Imposto.ICMS.pRedBC;
      ItensIcms.Registro.Valor              := Imposto.ICMS.vICMS;
      ItensIcms.Registro.DeterminacaoBaseST := Qr_Tributacao.FieldByName('MODAL_ICMS_ST').AsString;
      ItensIcms.Registro.AliqRedBaseST      := Imposto.ICMS.pRedBCST;
      ItensIcms.Registro.MVA                := Imposto.ICMS.pMVAST;
      ItensIcms.Registro.ValorBaseST        := Imposto.ICMS.vBCST;
      ItensIcms.Registro.AliquotaST         := Imposto.ICMS.pICMSST;
      ItensIcms.Registro.AliquotaDiferido   := Imposto.ICMS.pDif;
      ItensIcms.Registro.ValorDiferido      := Imposto.ICMS.vICMSDif;
      ItensIcms.Registro.AliqRedST          := 0;
      ItensIcms.Registro.ValorST            := Imposto.ICMS.vICMSST;
      ItensIcms.Registro.Desoneracao        := 0;
      ItensIcms.Registro.VAlorBaseSTRetido  := 0;
      ItensIcms.Registro.ValorSTRetido      := 0;
      ItensIcms.Registro.Partilha           := '';
      ItensIcms.Registro.Repasse            := '';
      ItensIcms.Registro.BaseICMSRetido     := 0;
      ItensIcms.Registro.ValorICMSRetido    := 0;
      ItensIcms.Registro.AliqCalcCred       := Imposto.ICMS.pCredSN;
      ItensIcms.Registro.CreditoAprox       := Imposto.ICMS.vCredICMSSN;
      ItensIcms.Registro.ValorFrete         := Prod.vFrete;
      ItensIcms.Registro.Seguro             := Prod.vSeg;
      ItensIcms.Registro.OutrasDespesas     := Prod.vOutro;
      ItensIcms.Registro.CFOP               := Qr_Tributacao.FieldByName('NAT_CODIGO').AsInteger;
      ItensIcms.Registro.Destacar           := Qr_Tributacao.FieldByName('TRB_DESTAQUE').AsString;
      ItensIcms.Registro.Observacao         := Qr_Tributacao.FieldByName('TRB_CODOBS').AsInteger;
      ItensIcms.insere;
      //Fundo de combate a pobreza
      icmsfcp.Clear;

      if (Estabelecimento.Registro.CodigoRegimeTributario = 3) or ( Estabelecimento.Registro.CodigoRegimeTributario = 2) then
      Begin
        if (Imposto.ICMS.vFCP > 0) or ( Imposto.ICMS.vFCPST > 0) or (Imposto.ICMS.vFCPSTRet >0 )  then
        Begin
          icmsfcp.Registro.Codigo             := FieldByName('ITF_CODIGO').AsInteger;
          icmsfcp.Registro.NotaFiscal         := NotaFiscal.Registro.Codigo;
          icmsfcp.Registro.BaseCalculo        := Imposto.ICMS.vBCFCP;
          icmsfcp.Registro.Percentual         := Imposto.ICMS.pFCP;
          icmsfcp.Registro.Valor              := Imposto.ICMS.vFCP;
          icmsfcp.Registro.BaseCalculoST      := Imposto.ICMS.vBCFCPST;
          icmsfcp.Registro.PercentualST       := Imposto.ICMS.pFCPST;
          icmsfcp.Registro.ValorST            := Imposto.ICMS.vFCPST;
          icmsfcp.Registro.AliqSupConsumidor  := Imposto.ICMS.pST;
          icmsfcp.Registro.BaseCalculoSTRET   := Imposto.ICMS.vBCFCPSTRet;
          icmsfcp.Registro.PercentualSTRET    := Imposto.ICMS.pFCPSTRet;
          icmsfcp.Registro.ValorSTRET         := Imposto.ICMS.vFCPSTRet;
          icmsfcp.salva;
        End;
      End;
    end;
  End;
end;

procedure ttributacao.Pc_AtualizarItensIPI(Pc_Item:TDetCollectionItem);
Var
  Lc_I :Integer;
begin
  if It_AutorizacaoNFE then
  Begin
    //Atualiza os itens Primarios da nota
    with Pc_Item,Qr_ItensPedido,NotaFiscal.Pedido.Itens do
    Begin
      if (Trim(CSTIPIToStr(imposto.IPI.CST)) <> '') then
      Begin
        ItensIpi.Registro.Codigo       := 0;
        ItensIpi.Registro.Nota         := NotaFiscal.Registro.Codigo;
        ItensIpi.Registro.ItemNota     := FieldByName('ITF_CODIGO').AsInteger;
        ItensIpi.Registro.CST          := Qr_Tributacao.FieldByName('CST_CODIGO_IPI').AsInteger;
        ItensIpi.Registro.ClassEnqu    := '';
        ItensIpi.Registro.CNPJProdutor := '';
        ItensIpi.Registro.CodigoSelo   := '';
        ItensIpi.Registro.QtdeSelo     := 0;
        ItensIpi.Registro.CodigoEnqu   := '';
        ItensIpi.Registro.ValorBase    := imposto.IPI.vBC;
        ItensIpi.Registro.Aliquota     := imposto.IPI.pIPI;
        ItensIpi.Registro.QtdeUnid     := 0;
        ItensIpi.Registro.ValorUnid    := imposto.IPI.vIPI;
        ItensIpi.insere;
      end;
    end;
  End;
end;

procedure ttributacao.Pc_AtualizarItensPIS(Pc_Item:TDetCollectionItem);
Var
  Lc_I :Integer;
begin
  if It_AutorizacaoNFE then
  Begin
    //Atualiza os itens Primarios da nota
    with Pc_Item,Qr_ItensPedido,NotaFiscal.Pedido.Itens do
    Begin
      if (imposto.PIS.vBC > 0) then
      Begin
        ItensPis.Registro.Codigo        := 0;
        ItensPis.Registro.Nota          := NotaFiscal.Registro.Codigo;
        ItensPis.Registro.ItemNota      := FieldByName('ITF_CODIGO').AsInteger;
        ItensPis.Registro.CST           := Qr_Tributacao.FieldByName('CST_CODIGO_PIS').AsInteger;
        ItensPis.Registro.ValorBase     := imposto.PIS.vBC;
        ItensPis.Registro.Aliquota      := imposto.PIS.pPIS;
        ItensPis.Registro.Valor         := imposto.PIS.vPIS;
        ItensPis.Registro.QtdeVenda     := 0;
        ItensPis.Registro.ValorAliquota := 0;
        ItensPis.insere;
      end;
    end;
  End;
end;

procedure ttributacao.Pc_AtualizarItensCOFINS(Pc_Item:TDetCollectionItem);
Var
  Lc_I :Integer;
begin
  if It_AutorizacaoNFE then
  Begin
    //Atualiza os itens Primarios da nota
    with Pc_Item,Qr_ItensPedido,NotaFiscal.Pedido.Itens do
    Begin
      if Imposto.COFINS.vBC > 0 then
      Begin
        ItensCofins.Registro.Codigo        := 0;
        ItensCofins.Registro.Nota          := NotaFiscal.Registro.Codigo;
        ItensCofins.Registro.ItemNota      := FieldByName('ITF_CODIGO').AsInteger;
        ItensCofins.Registro.CST           := Qr_Tributacao.FieldByName('CST_CODIGO_CFS').AsInteger;
        ItensCofins.Registro.ValorBase     := Imposto.COFINS.vBC;
        ItensCofins.Registro.Aliquota      := Imposto.COFINS.pCOFINS;
        ItensCofins.Registro.Valor         := Imposto.COFINS.vCOFINS;
        ItensCofins.Registro.QtdeVenda     := 0;
        ItensCofins.Registro.ValorAliquota := 0;
        ItensCofins.insere;
      end;
    end;
  End;
end;

procedure ttributacao.Pc_AtualizarItensISSQN(Pc_Item:TDetCollectionItem);
Var
  Lc_I :Integer;
begin


  if It_AutorizacaoNFE then
  Begin
    //Atualiza os itens Primarios da nota
    with Pc_Item,NotaFiscal.Pedido.Itens do
    Begin
      if (Pc_Item.Imposto.ISSQN.vBC > 0) then
      Begin
        ItensISSQN.Registro.Codigo             := 0;
        ItensISSQN.Registro.nota               := NotaFiscal.Registro.Codigo;
        ItensISSQN.Registro.ITemNota           := Qr_ItensPedido.FieldByName('ITF_CODIGO').AsInteger;
        ItensISSQN.Registro.VAlorBase          := Pc_Item.Imposto.ISSQN.vBC;
        ItensISSQN.Registro.Aliquota           := Pc_Item.Imposto.ISSQN.vAliq;
        ItensISSQN.Registro.Valor              := Pc_Item.Imposto.ISSQN.vISSQN;
        ItensISSQN.Registro.IBGE               := Pc_Item.Imposto.ISSQN.cMunFG;
        ItensISSQN.Registro.ListaLLC           := It_CODSRV116;
        ItensISSQN.Registro.SituacaoTributaria := 'N';
        ItensISSQN.Registro.ValorPIS           := 0;
        ItensISSQN.Registro.ValorCofins        := 0;
        ItensISSQN.Registro.VAlorREtido        := Pc_Item.Imposto.ISSQN.vISSRet;
        ItensISSQN.insere;
      end;
    end;
  End;
end;

end.
