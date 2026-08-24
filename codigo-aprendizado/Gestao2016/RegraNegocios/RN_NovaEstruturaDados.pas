unit RN_NovaEstruturaDados;

interface

Uses     System.SysUtils, System.Classes, System.IOUtils, ControllerBase, STQuery, STScript, Un_DM, IdHTTP, ControllerContador, ControllerIfoodOrder, Vcl.Dialogs;

TYPE

  TNED = Class(TComponent)
  private
    Version : Integer;
    http_down: TIdHTTP;

    function existTriguer(Trigger : String):Boolean;
    function existDomain(Domain : String):Boolean;
    function existTable(Tabela : String):Boolean;
    function existField(Tabela,campo : String):Boolean;
    function existGenerator(Gerador : String):Boolean;
    function getSizeFieldLenght(dominio,size:String):boolean;
    procedure ExecSqlScriptFromFile(FileName :String);

    function setVersion: Boolean;
    function geraSequenciaTB_CRP_ITENS:Boolean;
    function PreecheGrupoTB_CRP_ITENS:Boolean;

    function ExisteChavePrimaria(TableName: string): Boolean;
    function ChavePrimariaContemCampo(TableName, Campo: string): Boolean;
    procedure execAlteracaoPK_TB_IBSCBS_Link(const TableName: string);

    procedure execAlteracaoTB_COLABORADOR_PRIMARYKEY;
    procedure execAlteracaoTB_CRP_ITENS;
    procedure execAlteracaoTB_NFE_ITENS_FUEL;
    procedure execAlteracaoTB_CONTADOR;
    procedure execAlteracaoTB_ITENS_NFL_TRIBUTACAO;
    procedure execAlteracaoPRO_VL_BASE_TROCA;
    procedure execAlteracaoMED_ATIVO;
    procedure execAlteracaoTB_EXCHANGE_BASIS;
    procedure execAlteracaoNFL_IMP_XML;
    procedure execAlteracaoCTC_EMUSO;
    procedure execAlteracaoSBG_ATIVO;
    procedure execAlteracaoDATEIN;
    procedure execAlteracaoDATAOUT;
    procedure execAlteracaoTB_COMMAND;
    procedure execAlteracaoGROUPED;
    procedure execAlteracaoPK_TB_INVENTARIODelete;
    procedure execAlteracaoPK_TB_CUSTOpeDIDODelete;
    procedure execAlteracaoTB_ELECT_EQUIP;
    procedure execAlteracaoGN_ELECT_EQUIP;
    procedure execAlteracaoGN_PRODUCT_VARIANT;
    procedure execAlteracaoGN_PRODUCT_VARIANT_SKU;
    procedure execAlteracaoTB_PRODUCT_VARIANT;
    procedure execAlteracaoTB_PRODUCT_VARIANT_SKU;

    procedure execAlteracaoCREATEDOMAININTERIRO;
    procedure execAlteracaoCREATEDOMAINOBSERVACAO;
    procedure execAlteracaoCREATEDOMAINDESCRICAO1;
    procedure execAlteracaoCREATEDOMAINDESCRICAO2;
    procedure execAlteracaoCREATEDOMAINDESCRICAO5;
    procedure execAlteracaoCREATEDOMAINDESCRICAO7;
    procedure execAlteracaoCREATEDOMAINDESCRICAO15;
    procedure execAlteracaoCREATEDOMAINDESCRICAO100;
    procedure execAlteracaoCREATEDOMAINDESCRICAO200;
    procedure execAlteracaoCREATEDOMAINDESCRICAO500;
    procedure execAlteracaoCREATEDOMAINDESCRICAO150;
    procedure execAlteracaoCREATEDOMAINDESCRICAO20;
    procedure execAlteracaoCREATEDOMAINDESCRICAO10;
    procedure execAlteracaoCREATEDOMAINDESCRICAO25;
    procedure execAlteracaoCREATEDOMAINDESCRICAO50;
    procedure execAlteracaoCREATEDOMAINDATA;
    procedure execAlteracaoCREATEDOMAINHORA;
    procedure execAlteracaoCREATEDOMAINDATAEHORA;
    procedure execAlteracaoCREATEDOMAINCODIGO;
    procedure execAlteracaoCREATEDOMAINNUMERIC103;
    procedure execAlteracaoCREATEDOMAINNUMERIC102;
    procedure execAlteracaoCREATEDOMAINNUMERIC106;
    procedure execAlteracaoCREATEDOMAINNUMERIC146;
    procedure execAlteracaoCREATEDOMAINDESCRICAO1200;
    procedure execAlteracaoCREATEDOMAINDESCRICAO255;

    procedure execAlteracaoCREATEDOMAINDescricao_3;
    procedure execAlteracaoCREATEDOMAINNumeric154;


    procedure execAlteracaoTB_CONSERTOADDCST_ACESSORIO;
    procedure execAlteracaoTB_CONSERTOADDCST_RELATADO;
    procedure execAlteracaoTB_CONSERTOADDCST_CONSTATADO;

    procedure execAlteracaoTB_CONSERTOADDSERIE;
    procedure execAlteracaoTB_CONSERTOADDIMEI;
    procedure execAlteracaoTB_CONSERTOADDNOTE;
    procedure execAlteracaoTB_CONSERTOADDEXECUTADO;
    procedure execAlteracaoTB_CONSERTOADDDT_FORECAST;
    procedure execAlteracaoTB_PRODUTOPRO_SEND_WEB;
    procedure execAlteracaoModuloPetSHop;
    procedure ExecVAloresFloatNulos;
    PROCEDURE execAlteracaoTB_CONSERTOADDTB_COLABORADOR_ID;
    procedure execAlteracaoTB_CONSERTOBLOB;
    procedure execAlteracaoEmpFAntasia;
    procedure execAlteracaoTB_GESTAO_WEB;
    procedure execAlteracaoTB_LOJA_TRAY;
    procedure execAlteracaoTB_LOJA_TRAY_ORDER;
    procedure execAlteracaoTB_MEDIDAMED_SEQUENCIA;
    procedure execAlteracaoTB_SINCRONIA;
    procedure execAlteracaoGN_SINCRONIA;
    procedure execAlteracaoTG_SINCRONIA;
    procedure execAlteracaoTB_SINCRONIAADDSRC_LOG;
    procedure execAlteracaoTB_TERMINAL;
    procedure execAlteracaoGN_TERMINAL;

    procedure execAlteracaoTB_CONSERTO_HR_CONSERTO;
    procedure execAlteracaoTB_CONSERTO_HR_ENTREGA;
    procedure execAlteracaoTB_CONSERTO_HR_FORECAST;
    procedure execAlteracaoTB_PEDIDOPED_HORA;
    procedure execAlteracaoUpdatePED_HORA;

    procedure execAlteracaoTB_FORMA_PAGTO_FPT_TEF;
    procedure execAlteracaoTB_PAY_TYPE_HAS_INTERM;
    procedure execAlteracaoTB_GRUPOGRP_ATIVO;
    procedure execAlteracaoTB_USUARIOUSU_NIVEL;
    procedure execAlteracaoTB_FORMAPAGTOFPT_APP_DELIVERY;


    procedure execAlteracaoTB_PRODUTOPRO_DT_VENCIMENTO;

    procedure execAlteracaotb_tabela_precoTPR_MAR_VIA_ESCALA;
    procedure execAlteracaoTB_FINANCEIROFIN_AUTORIZADO;
    procedure execAlteracaoTB_GRUPGRP_SHOW_MENU;
    procedure execAlteracaoTB_CTRL_LOTECLT_ESTOQUE;
    procedure execAlteracaoTB_CTRL_LOTECLT_CODEST;
    procedure execAlteracaoTB_PRODUTOPRO_VL_CUSTO_LAST;
    procedure execAlteracaoTB_TRIBUTACAOTRB_CODEMP;
    procedure execAlteracaoTB_KIND_LUCRATIVIDADE;
    procedure execAlteracaoTB_SCHEDULE;
    procedure execAlteracaoTB_LUCRATIVIDADE;
    procedure execAlteracaoTB_PRODUTOPRO_IAT;
    procedure execAlteracaoTB_PAF_REG_A2;
    procedure execAlteracaoTB_PAF_REG_E2;
    procedure execAlteracaoTB_PAF_CTRL;
    procedure execAlteracaoTB_PAY_BACK;
    procedure execAlteracaoTB_COTACAOCTC_CODVDO_AUX;
    procedure execAlteracaoTB_RETAGUARDA;
    procedure execAlteracaoTB_RETAGUARDA_SYNC;
    procedure execAlteracaoDropTB_RETAGUARDA_SYNC_DT_UPDATE;
    procedure execAlteracaoDropTB_RETAGUARDA_SYNC_TM_UPDATE;
    procedure execAlteracaoTB_RETAGUARDA_SYNC_SYN_TIME;
    procedure execDropTrigguerTG_RETORNO_NFC;
    procedure execAlteracaoTB_PEDIDOPED_TERMINAL;
    PROCEDURE execAlteracaoTB_CLIENTECLI_CODTPR;
    procedure execAlteracaoTB_FURNITURE_OS;
    procedure execAlteracaoTB_CONTRACT;
    procedure execAlteracaoTB_CONTRACT_ORDER;
    procedure execAlteracaoTB_CONTRACT_CHAVES;
    procedure execAlteracaoTB_CTRL_ESTOQUE_ZERADO;
    procedure execAlteracaoGN_CTRL_ESTOQUE_ZERADO;
    procedure execAlteracaoSIT_COLOR;
    procedure execalteracaoTB_RETAGUARDA_WEB;
    procedure execalteracaoTB_RETAGUARDA_WEB_SYNC;
    procedure execalteracaoTB_USUARIO_USU_NOTIFICA;
    procedure execalteracaoTB_USUARIO_USU_AUTH_CARD;
    //IFOOD
    procedure execalteracaoTB_IFOOD;
    procedure execalteracaoTB_IFOOD_CUSTOMER;
    procedure execalteracaoTB_IFOOD_DELIVERY;
    procedure execalteracaoTB_IFOOD_EVENTS;
    procedure execalteracaoTB_IFOOD_ORDER;
    procedure execalteracaoTB_IFOOD_ORDER_BENEFITS;
    procedure execalteracaoTB_IFOOD_ORDER_ITEMS;
    procedure execalteracaoTB_IFOOD_ORDER_ITEMS_OPTIONS;
    procedure execalteracaoTB_IFOOD_ORDER_PAYMENT;
    procedure execalteracaoTB_IFOOD_ORDER_TOTAL;
    procedure execalteracaoTB_CLIENTE_FROM_EXTERIOR;
    procedure execalteracaoTB_PEDIDO_FROM_EXTERIOR;
    procedure execalteracaoTB_GRUPOSIFOOD;
    procedure execalteracaoTB_GRUPOSIFOOD_CD;

    procedure execalteracaoTB_PAY_BACK_EXPIRED;
    procedure execalteracaoTB_IFOOD_DELIVERYCOMPLEMENT;
    procedure execalteracaoTB_IFOOD_DELIVERYREFERENCE;
    procedure execalteracaoTB_IFOODAUTHORIZATION_CODE;
    procedure execalteracaoTB_IMPRESSORAIMP_MODELO;
    procedure execalteracaoTB_IFOODKIND_RECORD_ORDER;
    procedure execalteracaoTB_IFOOD_ORDERID_SETES;
    procedure execalteracaoTB_ITENS_RTR;
    procedure execAlteracaoTB_PROMOCAODT_EXPIRATION;
    procedure execAlteracaoTB_INTERFACEIFC_CODPRJ;
    procedure execalteracaoTB_ITENS_OBS;

    procedure execalteracaoTB_NFS_ELETRONICANFS_LAYOUT;
    procedure execalteracaoTB_NFS_ELETRONICANFS_VERSAO;

    procedure execalteracaoTB_BOLETO_BANCARIOBLT_DT_NEGATIVACAO;
    procedure execalteracaoTB_BOLETO_BANCARIOBLT_DIAS_NEGATIVACAO;
    procedure execalteracaoTB_BOLETO_BANCARIOBLE_NEGATIVACAO;
    procedure execalteracaoTB_BOLETO_BANCARIOBLE_DIAS_NEGATIVACAO;
    procedure execalteracaoTB_WHATSAPP_CFG;
    procedure execalteracaoTB_PRINT_SHOP_OS;
    procedure execalteracaoTB_PRE_PAID_CARD;
    procedure execalteracaoTB_PAY_BACKTB_CUSTOMER_ID;
    procedure execalteracaoTB_OWN_FLEET_OS;
    procedure execalteracaoTB_PAYBACKSTATUS;
    procedure execalteracaoTB_PAYBACKDT_EXPIRE;
	  procedure execAlteracaoTB_SEND_WHATSAPP;
	  procedure execalteracaoTB_PRODUTOPRO_QTDE_MIN_AUTO_REPO;
    procedure execAlteracaoTB_NOTIFICATION;
    procedure execAlteracaoTB_ITENS_ICMSICM_BCFCPST;
    procedure execAlteracaoTB_ITENS_ICMSICM_PFCPST;
    procedure execAlteracaoTB_ITENS_ICMSICM_VFCPST;
    PROCEDURE execalteracaoTB_TEF_MOVIMENTO;
    procedure execalteracaoTB_TributacaoTRB_AQ_DIF;
    procedure execalteracaoTB_ITENS_ICMSICM_AQ_DIF;
    procedure execalteracaoTB_ITENS_ICMSICM_VL_DIF;
    //18/08/2025
    procedure execalteracaotbTaxes;
    procedure execalteracaotbTaxesCSB;
    procedure execalteracaotbTaxesIbsUf;
    procedure execalteracaotbTaxesIbsMun;
    procedure execalteracaotbTaxesIncidency;
    procedure execalteracaotbEClass;
    //19/08/2025
    procedure execalteracaoTB_IBSCBS;
    procedure execalteracaoTB_IBSCBS_DIF;
    procedure execalteracaoTB_IBSCBS_RED;
    procedure execalteracaoTB_IBSCBS_DEVTRIB;
    procedure execalteracaoTB_IBS_UF;
    procedure execalteracaoTB_IBS_MUN;
    procedure execalteracaoTB_CBS;
    procedure execalteracaoTB_IBSCBS_TRIBREGULAR;
    procedure execalteracaoTB_IBSCBS_IBSCREDPRES;
    procedure execalteracaoTB_IBSCBS_CREDPRES;
    procedure execalteracaoTB_IBSCBS_TRIBCOMPRA_GOV;
    procedure execalteracaoTB_IBSCBS_MONO;
    procedure execalteracaoTB_IBSCBS_TRANSFCRED;
    procedure execalteracaoTB_IBSCBS_CREDPRES_IBSZFM;
    procedure execalteracaoTB_IMP_SELETIVO;
    procedure execAlteracaoTB_NFE_EVENTONVT_AUTOR;
    procedure execAlteracaoTB_TRIBUTACAOTB_TAXES_ID;
    //03/11/2025
    procedure TB_NFS_ELETRONICANFS_FORMATODISCR;
    procedure TB_NFS_ELETRONICANFS_CODIGONBS;
    procedure AjustarIndicadorInscricaoEstadual;
  public
    Base : TControllerBase;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BaixaCEST;

    procedure RunScript(Script: String);
    //procedure RunScriptFile(PathExe,FileName:String);
    procedure Pesquisa_NCM_CEST(Pc_Pes:TSTQuery;Pc_Sql,Pc_Sql_Criterio,Pc_NCM :String);
    procedure Update_NCM_CEST(Pc_Upd:TSTQuery;Pc_Cd_Produto:Integer;Pc_Cest:String);
    procedure updateCEST;
    procedure updateIndEscala;
    procedure RecriarTB_CTRL_ESTOQUE;

    procedure execAlteracao;

  End;

implementation

uses     UN_Sistema, env;
procedure TNED.AjustarIndicadorInscricaoEstadual;
var
  Lc_PathFile : String;
  Script: TSTScript;
begin
  Lc_PathFile := concat(GbPathExe, 'IndicadorIE.txt');
  if FileExists(Lc_PathFile) then
  Begin
    Script := base.GeraScript;
    try
      // Deixe o próprio script controlar transações (se o arquivo tiver COMMIT)
      Script.Script.Append('UPDATE TB_EMPRESA SET EMP_IND_IE_DEST = 1 WHERE EMP_PESSOA = ''J''  and ( emp_insc_est IS NOT NULL)  and (EMP_IND_IE_DEST <> ''2''); ');
      Script.Script.Append('UPDATE TB_EMPRESA SET EMP_IND_IE_DEST = 2 WHERE EMP_PESSOA = ''J''  and ( (emp_insc_est IS NULL) or (emp_insc_est = '''')) and (EMP_IND_IE_DEST <> ''2''); ');
      Script.Script.Append('UPDATE TB_EMPRESA SET EMP_IND_IE_DEST = 9 WHERE EMP_PESSOA <> ''J'' AND  (EMP_IND_IE_DEST <> ''2''); ');
      Script.Script.Append(concat(
                          'UPDATE TB_CLIENTE C ',
                          'SET CLI_IND_IE_DEST = ( ',
                          '  SELECT EMP_IND_IE_DEST ',
                          '  FROM TB_EMPRESA E ',
                          '  WHERE E.EMP_CODIGO = C.CLI_CODEMP ',
                          '); '
      ));
      Script.ExecuteAll;
    finally
      base.FinalizaISQL(Script);
      DeleteFile(Lc_PathFile);
    end;
  end;
end;

procedure TNED.BaixaCEST;
var
  Lc_Arquivo : String;
  Lc_Path : String;
  Lc_DwnFile: TFileStream;
begin
  Lc_Arquivo := 'scriptcest.zip';
  if FileExists(concat(GbPathExe,'temp\', Lc_Arquivo)) then
    DeleteFile(pchar( concat(GbPathExe,'temp\', Lc_Arquivo)));

  if not FileExists(concat(GbPathExe + 'imagem\',Lc_Arquivo)) then
      Pc_BaixarArquivosSite('Gestao2016',Lc_Arquivo,'temp\');
end;

constructor TNED.Create;
begin
  inherited;
  Version := 44024;
  http_down := TIdHTTP.Create(nil);
  Base := TControllerBase.create(nil);
end;


destructor TNED.Destroy;
begin
  FreeAndNil(http_down);

  FreeAndNil(Base);
  inherited;
end;

procedure TNED.execAlteracao;
Var
  LcAux : String;

begin
  Try
    execAlteracaoCREATEDOMAINNUMERIC146;
    
    //criação de Dominios
    execAlteracaoCREATEDOMAININTERIRO;
    execAlteracaoCREATEDOMAINOBSERVACAO;
    execAlteracaoCREATEDOMAINDESCRICAO1;
    execAlteracaoCREATEDOMAINDESCRICAO2;
    execAlteracaoCREATEDOMAINDESCRICAO5;
    execAlteracaoCREATEDOMAINDESCRICAO7;
    execAlteracaoCREATEDOMAINDESCRICAO15;
    execAlteracaoCREATEDOMAINDESCRICAO100;
    execAlteracaoCREATEDOMAINDESCRICAO10;
    execAlteracaoCREATEDOMAINDESCRICAO20;
    execAlteracaoCREATEDOMAINDESCRICAO25;
    execAlteracaoCREATEDOMAINDESCRICAO50;
    execAlteracaoCREATEDOMAINDESCRICAO200;
    execAlteracaoCREATEDOMAINDESCRICAO500;
    execAlteracaoCREATEDOMAINDESCRICAO150;
    execAlteracaoCREATEDOMAINDESCRICAO1200;
    execAlteracaoCREATEDOMAINDESCRICAO255;
    execAlteracaoCREATEDOMAINDescricao_3;
    execAlteracaoCREATEDOMAINNumeric154;

    execAlteracaoCREATEDOMAINDATA;
    execAlteracaoCREATEDOMAINHORA;
    execAlteracaoCREATEDOMAINDATAEHORA;
    execAlteracaoCREATEDOMAINCODIGO;
    execAlteracaoCREATEDOMAINNUMERIC103;
    execAlteracaoCREATEDOMAINNUMERIC102;
    execAlteracaoCREATEDOMAINNUMERIC106;


    //Lembar que este codigo foi feito depois de muitos outros - 29/06/2024
    execAlteracaoTB_COLABORADOR_PRIMARYKEY;
    execAlteracaoTB_CRP_ITENS;
    execAlteracaoTB_NFE_ITENS_FUEL;
    execAlteracaoTB_CONTADOR;
    execAlteracaoTB_ITENS_NFL_TRIBUTACAO;
    execAlteracaoPRO_VL_BASE_TROCA;
    execAlteracaoMED_ATIVO;
    execAlteracaoTB_EXCHANGE_BASIS;
    execAlteracaoNFL_IMP_XML;
    execAlteracaoCTC_EMUSO;
    execAlteracaoSBG_ATIVO;
    execAlteracaoDATEIN;
    execAlteracaoDATAOUT;
    execAlteracaoTB_COMMAND;
    execAlteracaoGROUPED;
    execAlteracaoPK_TB_INVENTARIODelete;
    execAlteracaoPK_TB_CUSTOpeDIDODelete;
    execAlteracaoTB_ELECT_EQUIP;
    execAlteracaoGN_ELECT_EQUIP;
    execAlteracaoGN_PRODUCT_VARIANT;
    execAlteracaoGN_PRODUCT_VARIANT_SKU;
    execAlteracaoTB_PRODUCT_VARIANT;
    execAlteracaoTB_PRODUCT_VARIANT_SKU;

    execAlteracaoTB_CONSERTOADDCST_ACESSORIO;
    execAlteracaoTB_CONSERTOADDCST_RELATADO;
    execAlteracaoTB_CONSERTOADDCST_CONSTATADO;

    execAlteracaoTB_CONSERTOADDSERIE;
    execAlteracaoTB_CONSERTOADDIMEI;
    execAlteracaoTB_CONSERTOADDNOTE;
    execAlteracaoTB_CONSERTOADDEXECUTADO;

    execAlteracaoTB_CONSERTOADDDT_FORECAST;
    execAlteracaoTB_PRODUTOPRO_SEND_WEB;
    execAlteracaoModuloPetSHop;
    ExecVAloresFloatNulos;
    execAlteracaoTB_CONSERTOADDTB_COLABORADOR_ID;
    //TODO: Rod - Bug - Firebird 5
    //antesexecAlteracaoTB_CONSERTOBLOB;
    execAlteracaoEmpFAntasia;
    execAlteracaoTB_GESTAO_WEB;
    execAlteracaoTB_LOJA_TRAY;
    execAlteracaoTB_LOJA_TRAY_ORDER;
    execAlteracaoTB_MEDIDAMED_SEQUENCIA;
    execAlteracaoTB_SINCRONIA;
    execAlteracaoGN_SINCRONIA;
    execAlteracaoTG_SINCRONIA;
    execAlteracaoTB_SINCRONIAADDSRC_LOG;
    execAlteracaoTB_TERMINAL;
    execAlteracaoGN_TERMINAL;
    execAlteracaoTB_CONSERTO_HR_CONSERTO;
    execAlteracaoTB_CONSERTO_HR_ENTREGA;
    execAlteracaoTB_CONSERTO_HR_FORECAST;
    execAlteracaoTB_PEDIDOPED_HORA;
    execAlteracaoUpdatePED_HORA;
    execAlteracaoTB_FORMA_PAGTO_FPT_TEF;
    execAlteracaoTB_PAY_TYPE_HAS_INTERM;
    execAlteracaoTB_GRUPOGRP_ATIVO;
    execAlteracaotb_tabela_precoTPR_MAR_VIA_ESCALA;
    execAlteracaoTB_FINANCEIROFIN_AUTORIZADO;

    execAlteracaoTB_USUARIOUSU_NIVEL;
    execAlteracaoTB_FORMAPAGTOFPT_APP_DELIVERY;

    execAlteracaoTB_PRODUTOPRO_DT_VENCIMENTO;

    execAlteracaoTB_GRUPGRP_SHOW_MENU;
    execAlteracaoTB_CTRL_LOTECLT_ESTOQUE;
    execAlteracaoTB_CTRL_LOTECLT_CODEST;
    execAlteracaoTB_PRODUTOPRO_VL_CUSTO_LAST;
    execAlteracaoTB_TRIBUTACAOTRB_CODEMP;
    execAlteracaoTB_KIND_LUCRATIVIDADE;
    execAlteracaoTB_SCHEDULE;
    execAlteracaoTB_LUCRATIVIDADE;
    execAlteracaoTB_PRODUTOPRO_IAT;
    execAlteracaoTB_PAF_REG_A2;
    execAlteracaoTB_PAF_REG_E2;
    execAlteracaoTB_PAF_CTRL;
    execAlteracaoTB_PAY_BACK;
    execAlteracaoTB_COTACAOCTC_CODVDO_AUX;
    execAlteracaoTB_RETAGUARDA;
    execAlteracaoTB_RETAGUARDA_SYNC;
    //29/12/2022
    execAlteracaoDropTB_RETAGUARDA_SYNC_DT_UPDATE;
    execAlteracaoDropTB_RETAGUARDA_SYNC_TM_UPDATE;
    execAlteracaoTB_RETAGUARDA_SYNC_SYN_TIME;
    execDropTrigguerTG_RETORNO_NFC;
    execAlteracaoTB_CLIENTECLI_CODTPR;
    execAlteracaoTB_FURNITURE_OS;
    execAlteracaoTB_CONTRACT;
    execAlteracaoTB_CONTRACT_ORDER;
    execAlteracaoTB_CONTRACT_CHAVES;
    execAlteracaoGN_CTRL_ESTOQUE_ZERADO;
    execAlteracaoTB_CTRL_ESTOQUE_ZERADO;
    execAlteracaoSIT_COLOR;
    execalteracaoTB_RETAGUARDA_WEB;
    execalteracaoTB_RETAGUARDA_WEB_SYNC;
    execalteracaoTB_USUARIO_USU_NOTIFICA;
    execalteracaoTB_USUARIO_USU_AUTH_CARD;
    //iFOOD
    execalteracaoTB_IFOOD;
    execalteracaoTB_IFOOD_CUSTOMER;
    execalteracaoTB_IFOOD_DELIVERY;
    execalteracaoTB_IFOOD_EVENTS;
    execalteracaoTB_IFOOD_ORDER;
    execalteracaoTB_IFOOD_ORDER_BENEFITS;
    execalteracaoTB_IFOOD_ORDER_ITEMS;
    execalteracaoTB_IFOOD_ORDER_ITEMS_OPTIONS;
    execalteracaoTB_IFOOD_ORDER_PAYMENT;
    execalteracaoTB_IFOOD_ORDER_TOTAL;
    execalteracaoTB_CLIENTE_FROM_EXTERIOR;
    execalteracaoTB_PEDIDO_FROM_EXTERIOR;
    execalteracaoTB_GRUPOSIFOOD;
    execalteracaoTB_GRUPOSIFOOD_CD;
    execalteracaoTB_PAY_BACK_EXPIRED;
    execalteracaoTB_IFOOD_DELIVERYCOMPLEMENT;
    execalteracaoTB_IFOOD_DELIVERYREFERENCE;
    execalteracaoTB_IFOODAUTHORIZATION_CODE;
    execalteracaoTB_IMPRESSORAIMP_MODELO;
    execalteracaoTB_IFOODKIND_RECORD_ORDER;
    execalteracaoTB_IFOOD_ORDERID_SETES;
    execalteracaoTB_ITENS_RTR;
    execAlteracaoTB_PROMOCAODT_EXPIRATION;
    execAlteracaoTB_INTERFACEIFC_CODPRJ;
    execalteracaoTB_ITENS_OBS;

    execalteracaoTB_NFS_ELETRONICANFS_LAYOUT;
    execalteracaoTB_NFS_ELETRONICANFS_VERSAO;


    execalteracaoTB_BOLETO_BANCARIOBLT_DT_NEGATIVACAO;
    execalteracaoTB_BOLETO_BANCARIOBLT_DIAS_NEGATIVACAO;
    execalteracaoTB_BOLETO_BANCARIOBLE_NEGATIVACAO;
    execalteracaoTB_BOLETO_BANCARIOBLE_DIAS_NEGATIVACAO;
    execalteracaoTB_WHATSAPP_CFG;
    execalteracaoTB_PRINT_SHOP_OS;
    execalteracaoTB_PRE_PAID_CARD;
    execalteracaoTB_PAY_BACKTB_CUSTOMER_ID;
    execalteracaoTB_OWN_FLEET_OS;
    execalteracaoTB_PAYBACKSTATUS;
    execalteracaoTB_PAYBACKDT_EXPIRE;
    //14-08-2024
    execalteracaoTB_PRODUTOPRO_QTDE_MIN_AUTO_REPO;
    //15-08-2024
    execAlteracaoTB_SEND_WHATSAPP;
    //19-08/2024
    execAlteracaoTB_NOTIFICATION;
    //29/08/2024
    execAlteracaoTB_ITENS_ICMSICM_BCFCPST;
    execAlteracaoTB_ITENS_ICMSICM_PFCPST;
    execAlteracaoTB_ITENS_ICMSICM_VFCPST;
    //06/01/2025
    execalteracaoTB_TEF_MOVIMENTO;
    //06/03/2025
    execalteracaoTB_TributacaoTRB_AQ_DIF;
    execalteracaoTB_ITENS_ICMSICM_AQ_DIF;
    execalteracaoTB_ITENS_ICMSICM_VL_DIF;
    //18/08/2025
    execalteracaotbTaxes;
    execalteracaotbTaxesCSB;
    execalteracaotbTaxesIbsUf;
    execalteracaotbTaxesIbsMun;
    execalteracaotbTaxesIncidency;
    execalteracaotbEClass;
    //19/08/2025
    execalteracaoTB_IBSCBS;
    execalteracaoTB_IBSCBS_DIF;
    execalteracaoTB_IBSCBS_RED;
    execalteracaoTB_IBSCBS_DEVTRIB;
    execalteracaoTB_IBS_UF;
    execalteracaoTB_IBS_MUN;
    execalteracaoTB_CBS;
    execalteracaoTB_IBSCBS_TRIBREGULAR;
    execalteracaoTB_IBSCBS_IBSCREDPRES;
    execalteracaoTB_IBSCBS_CREDPRES;
    execalteracaoTB_IBSCBS_TRIBCOMPRA_GOV;
    execalteracaoTB_IBSCBS_MONO;
    execalteracaoTB_IBSCBS_TRANSFCRED;
    execalteracaoTB_IBSCBS_CREDPRES_IBSZFM;
    //execalteracaoTB_IMP_SELETIVO; aguardar pois nao temos a tabela de base e a implementacao sera para 2027
    //20/08/2025
    execAlteracaoTB_NFE_EVENTONVT_AUTOR;
    execAlteracaoTB_TRIBUTACAOTB_TAXES_ID;

    ExecSqlScriptFromFile('RELATION_FIELDS.sql');

    ExecSqlScriptFromFile('TaxesIncidency.sql');
    ExecSqlScriptFromFile('tb_eclass.sql');
    ExecSqlScriptFromFile('TB_EVENTO_NFE.sql');
    ExecSqlScriptFromFile('tb_nfe_evento.sql');
    ExecSqlScriptFromFile('RELATION_FIELDS_NFS_MOTIVO.sql');
    ExecSqlScriptFromFile('NFS_CD_SRV_LLC.sql');
    ExecSqlScriptFromFile('NFS_COD_VERIF.sql');
    //03/11/2025
    TB_NFS_ELETRONICANFS_FORMATODISCR;
    TB_NFS_ELETRONICANFS_CODIGONBS;
    //19/02/2025
    ExecSqlScriptFromFile('NUMERODI.sql');
    //14/04/20026
    AjustarIndicadorInscricaoEstadual;
  Except
    //DEu errado volta um dia para tentar rodar novamente
    //Fc_Tb_Geral('G','NED_SEQUENCIA',IntToStr(Version-1));
  End;
end;


procedure TNED.execAlteracaoCREATEDOMAINCODIGO;
begin
  if not existDomain('Codigo') then
  Begin
    RunScript('CREATE DOMAIN "Codigo" AS INTEGER NOT NULL;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDATA;
begin
  if not existDomain('Data') then
  Begin
    RunScript('CREATE DOMAIN "Data" AS DATE;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDATAEHORA;
begin
  if not existDomain('DataeHora') then
  Begin
    RunScript('CREATE DOMAIN "DataeHora" AS TIMESTAMP;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO5;
begin
  if not existDomain('Descricao_5') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_5" AS VARCHAR(5) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO1;
begin
  if not existDomain('Descricao_1') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_1" AS VARCHAR(1) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO10;
begin
  if not existDomain('Descricao_10') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_10" AS VARCHAR(10) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO100;
begin
  if not existDomain('Descricao_100') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_100" AS VARCHAR(100) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO1200;
begin
  if not existDomain('Descricao_1200') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_1200" AS VARCHAR(1200) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO15;
begin
  if not existDomain('Descricao_15') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_15" AS VARCHAR(15) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO150;
begin
  if not existDomain('Descricao_150') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_150" AS VARCHAR(150) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO2;
begin
  if not existDomain('Descricao_2') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_2" AS VARCHAR(2) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO20;
begin
  if not existDomain('Descricao_20') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_20" AS VARCHAR(20) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO200;
begin
  if not existDomain('Descricao_200') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_200" AS VARCHAR(200) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO25;
begin
  if not existDomain('Descricao_25') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_25" AS VARCHAR(25) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO255;
begin
  if not existDomain('Descricao_255') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_255" AS VARCHAR(255) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO50;
begin
  if not existDomain('Descricao_50') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_50" AS VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO500;
begin
  if not existDomain('Descricao_500') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_500" AS VARCHAR(500) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDESCRICAO7;
begin
  if not existDomain('Descricao_7') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_7" AS VARCHAR(7) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINDescricao_3;
begin
  if not existDomain('Descricao_3') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_3" AS VARCHAR(3) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINHORA;
begin
  if not existDomain('Hora') then
  Begin
    RunScript('CREATE DOMAIN "Hora" AS TIME;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAININTERIRO;
begin
  if not existDomain('inteiro') then
  Begin
    RunScript('CREATE DOMAIN "Inteiro" AS INTEGER;');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINNUMERIC102;
begin
  if not existDomain('Numeric102') then
  Begin
    RunScript('CREATE DOMAIN "Numeric102" AS NUMERIC(10,2);');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINNUMERIC103;
begin
  if not existDomain('Numeric103') then
  Begin
    RunScript('CREATE DOMAIN "Numeric103" AS NUMERIC(10,3);');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINNUMERIC106;
begin
  if not existDomain('Numeric106') then
  Begin
    RunScript('CREATE DOMAIN "Numeric106" AS NUMERIC(10,6);');
  End;
end;

procedure TNED.execAlteracaoCREATEDOMAINNUMERIC146;
begin
  if not existDomain('Numeric146') then
  Begin
    RunScript('CREATE DOMAIN "Numeric146" AS NUMERIC(14,6);');
  End;

end;

procedure TNED.execAlteracaoCREATEDOMAINNumeric154;
begin
  if not existDomain('Numeric154') then
  Begin
    RunScript('CREATE DOMAIN "Numeric154" AS NUMERIC(15,4);');
  End;
end;


procedure TNED.execAlteracaoCREATEDOMAINOBSERVACAO;
begin
  if not existDomain('observacao') then
  Begin
    RunScript('CREATE DOMAIN "Observacao" AS BLOB SUB_TYPE 0 SEGMENT SIZE 80;');
  End;

end;

procedure TNED.execAlteracaoCTC_EMUSO;
begin
  if not existField('TB_COTACAO','CTC_EMUSO') then
  Begin
    RunScript('ALTER TABLE TB_COTACAO ADD CTC_EMUSO VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoDATAOUT;
begin
  if not existField('TB_EXCHANGE_BASIS','DT_OUT') then
  Begin
    RunScript('ALTER TABLE TB_EXCHANGE_BASIS ADD DT_OUT  DATE;');
  End;

end;

procedure TNED.execAlteracaoDATEIN;
begin
  if not existField('TB_EXCHANGE_BASIS','DT_IN') then
  Begin
    RunScript('ALTER TABLE TB_EXCHANGE_BASIS ADD DT_IN  DATE;');
  End;

end;

procedure TNED.execAlteracaoDropTB_RETAGUARDA_SYNC_DT_UPDATE;
begin
  if existField('TB_RETAGUARDA_SYNC','DT_UPDATE') then
  Begin
    RunScript('ALTER TABLE TB_RETAGUARDA_SYNC DROP DT_UPDATE;');
  End;

end;

procedure TNED.execAlteracaoDropTB_RETAGUARDA_SYNC_TM_UPDATE;
begin
  if existField('TB_RETAGUARDA_SYNC','TM_UPDATE') then
  Begin
    RunScript('ALTER TABLE TB_RETAGUARDA_SYNC DROP TM_UPDATE;');
  End;

end;

procedure TNED.execAlteracaoEmpFAntasia;
begin
  RunScript(concat(
              'UPDATE tb_empresa SET ',
              'emp_fantasia = emp_nome ',
              'where ( (emp_fantasia is null) or (emp_fantasia = '''')) '
  ));

end;


procedure TNED.execAlteracaoGN_CTRL_ESTOQUE_ZERADO;
begin
  if not existGenerator('GN_CTRL_ESTOQUE_ZERADO') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_CTRL_ESTOQUE_ZERADO;');
  end;

end;

procedure TNED.execAlteracaoGN_ELECT_EQUIP;
begin
  if not existGenerator('GN_ELECT_EQUIP') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_ELECT_EQUIP;');
  end;
end;

procedure TNED.execAlteracaoGN_PRODUCT_VARIANT;
begin
  if not existGenerator('GN_PRODUCT_VARIANT') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_PRODUCT_VARIANT;');
  end;
end;

procedure TNED.execAlteracaoGN_PRODUCT_VARIANT_SKU;
begin
  if not existGenerator('GN_PRODUCT_VARIANT_SKU') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_PRODUCT_VARIANT_SKU;');
  end;

end;

procedure TNED.execAlteracaoGN_SINCRONIA;
begin
  if not existGenerator('GN_SINCRONIA') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_SINCRONIA;');
  end;

end;

procedure TNED.execAlteracaoGN_TERMINAL;
begin
  if not existGenerator('GN_TERMINAL') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_TERMINAL;');
  end;
end;

procedure TNED.execAlteracaoGROUPED;
begin
  if not existField('TB_COMMAND','GROUPED') then
  Begin
    RunScript('ALTER TABLE TB_COMMAND ADD GROUPED INTEGER;');
  End;
end;

procedure TNED.execAlteracaoMED_ATIVO;
begin
  if not existField('TB_MEDIDA','MED_ATIVO') then
  Begin
    RunScript('ALTER TABLE TB_MEDIDA ADD MED_ATIVO CHAR(1);');
  End;

end;

procedure TNED.execAlteracaoModuloPetSHop;
begin
  if not existGenerator('GN_PET') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_PET;');
  end;

  if not existTabela('TB_PET') then
  BEgin
    RunScript( concat(
                'CREATE TABLE TB_PET ( ',
                '    ID              INTEGER NOT NULL, ',
                '    DT_RECORD       DATE, ',
                '    NAME            VARCHAR(100) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    AGE             INTEGER, ',
                '    RACE            VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    HAIR            VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    COLOR           VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    GENDER          CHAR(1), ',
                '    TB_CUSTOMER_ID  INTEGER NOT NULL, ',
                '    CASTRATED       CHAR(1), ',
                '    ATTENDANCE      VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR); '
    ));
  End;

  if not existTabela('TB_PET_ORDER') then
  BEgin
    RunScript( concat(
                'CREATE TABLE TB_PET_ORDER ( ',
                '    TB_PEDIDO_ID   INTEGER NOT NULL, ',
                '    TB_PET_ID      INTEGER NOT NULL, ',
                '    ENTRANCE_DATE  DATE, ',
                '    ENTRANCE_TIME  VARCHAR(5), ',
                '    FORECAST_DATE  DATE, ',
                '    FORECAST_TIME  VARCHAR(5), ',
                '    EXIT_DATE      DATE, ',
                '    EXIT_TIME      VARCHAR(5), ',
                '    NOTE           BLOB SUB_TYPE 0 SEGMENT SIZE 80); '
    ));
  end;

  if not existGenerator('GN_PET_DEADLINE') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_PET_DEADLINE;');
  end;

  if not existTabela('TB_PET_DEADLINE') then
  BEgin
    RunScript( concat(
                'CREATE TABLE TB_PET_DEADLINE( ',
                '    ID INTEGER NOT NULL, ',
                '    TB_PET_ID INTEGER NOT NULL, ',
                '    DESCRIPTION VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    INITIAL_DATE DATE, ',
                '    FINAL_DATE DATE); '
    ));

  End;

  if not existGenerator('GN_PET_CONTACT') then
  BEgin
    RunScript( 'CREATE GENERATOR GN_PET_CONTACT;');
  end;

  if not existTabela('TB_PET_CONTACT') then
  BEgin
    RunScript( concat(
                'CREATE TABLE TB_PET_CONTACT( ',
                '    ID INTEGER NOT NULL, ',
                '    TB_PET_ID INTEGER NOT NULL, ',
                '    NAME VARCHAR(100) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    ADDRESS VARCHAR(100) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    PHONE  VARCHAR(100) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    EMERGENCY CHAR(1)); '
    ));

  End;

end;

procedure TNED.execAlteracaoNFL_IMP_XML;
begin
  if not existField('TB_NOTA_FISCAL','NFL_IMP_XML') then
  Begin
    RunScript('ALTER TABLE TB_NOTA_FISCAL ADD NFL_IMP_XML CHAR(1);');
  End;
end;

procedure TNED.execAlteracaoPK_TB_CUSTOpeDIDODelete;
var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(CONCAT(
                'select ',
                '    ix.rdb$index_name as index_name, ',
                '    sg.rdb$field_name as field_name, ',
                '    rc.RDB$CONSTRAINT_NAME as constraint_name ',
                'from ',
                '    rdb$indices ix ',
                '    left join rdb$index_segments sg on ix.rdb$index_name = sg.rdb$index_name ',
                '    left join rdb$relation_constraints rc on rc.rdb$index_name = ix.rdb$index_name ',
                'where ',
                '    rc.rdb$constraint_type = :TYPE ',
                '    AND rc.rdb$relation_name = :TABLE ',
                '    AND sg.rdb$field_name = :FIELD '
      ));
      ParamByName('TYPE').AsString  := 'PRIMARY KEY';
      ParamByName('TABLE').AsString := 'TB_CUSTO_PEDIDO';
      ParamByName('FIELD').AsString := 'CTP_CODPED';
      Active := True;
      FetchAll;
      if ( recordCount = 0 ) then
      Begin
        Active := False;
        ParamByName('TYPE').AsString  := 'PRIMARY KEY';
        ParamByName('TABLE').AsString := 'TB_CUSTO_PEDIDO';
        ParamByName('FIELD').AsString := 'CTP_CODIGO';
        Active := True;
        FetchAll;
        RunScript(concat(
                      'ALTER TABLE TB_CUSTO_PEDIDO DROP CONSTRAINT ',
                      FieldByName('constraint_name').AsString
        ));
        RunScript(concat(
                    'alter table TB_CUSTO_PEDIDO ',
                    'add constraint PK_TB_CUSTO_PEDIDO ',
                    'primary key (CTP_CODIGO,CTP_CODPED) '
        ));

      End;
    End;
  finally
    Base.FinalizaQuery(Lc_Qry);
  end;

end;

procedure TNED.execAlteracaoPK_TB_INVENTARIODelete;
var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(CONCAT(
                'select ',
                '    ix.rdb$index_name as index_name, ',
                '    sg.rdb$field_name as field_name, ',
                '    rc.rdb$relation_name as table_name ',
                'from ',
                '    rdb$indices ix ',
                '    left join rdb$index_segments sg on ix.rdb$index_name = sg.rdb$index_name ',
                '    left join rdb$relation_constraints rc on rc.rdb$index_name = ix.rdb$index_name ',
                'where ',
                '    rc.rdb$constraint_type = :TYPE ',
                '    AND rc.rdb$relation_name = :TABLE ',
                '    AND sg.rdb$field_name = :FIELD '
      ));
      ParamByName('TYPE').AsString  := 'PRIMARY KEY';
      ParamByName('TABLE').AsString := 'TB_INVENTARIO';
      ParamByName('FIELD').AsString := 'IVT_CODIGO';
      Active := True;
      FetchAll;
      if ( recordCount > 0 ) then
      Begin
        RunScript(concat(
                      'update RDB$RELATION_FIELDS set ',
                      'RDB$NULL_FLAG = 1 ',
                      'where (RDB$FIELD_NAME = ''IVT_DATA'') and ',
                      '(RDB$RELATION_NAME = ''TB_INVENTARIO'') '
        ));
        RunScript('ALTER TABLE TB_INVENTARIO DROP CONSTRAINT PK_TB_INVENTARIO;');
        RunScript(concat(
                    'alter table TB_INVENTARIO ',
                    'add constraint PK_TB_INVENTARIO ',
                    'primary key (IVT_DATA,IVT_CODETS,IVT_CODPRO,IVT_CODMHA) '
        ));

      End;
    End;
  finally
    Base.FinalizaQuery(Lc_Qry);
  end;
end;

procedure TNED.execAlteracaoPRO_VL_BASE_TROCA;
begin
  if not existField('TB_PRODUTO','PRO_VL_BASE_TROCA') then
  Begin
    RunScript( 'ALTER TABLE TB_PRODUTO ADD PRO_VL_BASE_TROCA     NUMERIC(10,6);');
  End;

end;

procedure TNED.execAlteracaoSBG_ATIVO;
begin
  if not existField('TB_SUBGRUPOS','SBG_ATIVO') then
  Begin
    RunScript('ALTER TABLE TB_SUBGRUPOS ADD  SBG_ATIVO CHAR(1);');
  End;

end;

procedure TNED.execAlteracaoSIT_COLOR;
begin
  if not existField('TB_SITUACAO','SIT_COLOR') then
  Begin
    RunScript('ALTER TABLE TB_SITUACAO ADD SIT_COLOR "Descricao_20"; ');
  End;
end;

procedure TNED.execalteracaotbEClass;
begin
  if not existTable('TB_ECLASS') then
  Begin
      RunScript(concat(
        'CREATE TABLE TB_ECLASS ( ',
        '    CST                    "Descricao_3" NOT NULL, ',
        '    CST_DESCRIPTION        "Descricao_100", ',
        '    CLASSE                 "Descricao_10"  NOT NULL , ',
        '    CLASS_NAME             "Descricao_150", ',
        '    CLASSTRIB_DESCRIPTION  "Observacao", ',
        '    ESSAY                  "Observacao", ',
        '    LC_214_25              "Descricao_50", ',
        '    RATE_TYPE              "Descricao_50", ',
        '    PREDIBS                "Numeric102", ',
        '    PREDCBS                "Numeric102", ',
        '    IND_REDUTORBC          "Descricao_1", ',
        '    IND_GTRIBREGULAR       "Inteiro" , ',
        '    IND_CREDPRES           "Inteiro" , ',
        '    IND_MONO               "Inteiro" , ',
        '    IND_MONORETEN          "Inteiro" , ',
        '    IND_MONORET            "Inteiro" , ',
        '    IND_MONODIF            "Inteiro" , ',
        '    CREDIT_FOR             "Descricao_500" , ',
        '    DINIVIG                "Data" , ',
        '    DFIMVIG                "Data" , ',
        '    UPDATE_DATE            "Data" ); '
      ));
      RunScript('ALTER TABLE TB_ECLASS ADD CONSTRAINT PK_TB_ECLASS PRIMARY KEY (CST, CLASSE);');

      ExecSqlScriptFromFile('tb_eclass.sql');
  End;
end;

procedure TNED.execalteracaotbTaxes;
begin
  if not existTable('TB_TAXES') then
  Begin
      RunScript(concat(
        'CREATE TABLE TB_TAXES ( ',
        '    ID                     "Codigo" , ',
        '    TB_INSTITUTION_ID      "Codigo" , ',
        '    DESCRIPTION            "Descricao_100" , ',
        '    TB_TAXES_INCIDENCY_ID  "Codigo", ',
        '    CST                    "Descricao_100", ',
        '    CLASSTRIB              "Descricao_10" ); '
      ));
      RunScript('ALTER TABLE TB_TAXES ADD PRIMARY KEY (ID,TB_INSTITUTION_ID);');
  End;

end;

procedure TNED.execalteracaotbTaxesCSB;
begin
  if not existTable('TB_TAXES_CBS') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_TAXES_CBS ( ',
          '    TB_TAXES_ID  "Codigo", ',
          '    ALIQUOTA     "Numeric103" , ',
          '    ALIQ_RED     "Numeric103" , ',
          '    ALIQ_EFE     "Numeric103" , ',
          '    ALIQ_DIF     "Numeric103"); '
      ));
      RunScript('ALTER TABLE TB_TAXES_CBS ADD PRIMARY KEY (TB_TAXES_ID);');
  End;
end;

procedure TNED.execalteracaotbTaxesIbsMun;
begin
  if not existTable('TB_TAXES_IBS_MUN') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_TAXES_IBS_MUN ( ',
          '    TB_TAXES_ID  "Codigo", ',
          '    ALIQUOTA     "Numeric103", ',
          '    ALIQ_RED     "Numeric103", ',
          '    ALIQ_EFE     "Numeric103", ',
          '    ALIQ_DIF     "Numeric103"); '
      ));
      RunScript('ALTER TABLE TB_TAXES_IBS_MUN ADD CONSTRAINT PK_TB_TAXES_IBS_MUN PRIMARY KEY (TB_TAXES_ID);');
  End;

end;

procedure TNED.execalteracaotbTaxesIbsUf;
begin
  if not existTable('TB_TAXES_IBS_UF') then
  Begin
      RunScript(concat(
              'CREATE TABLE TB_TAXES_IBS_UF ( ',
              '   TB_TAXES_ID  "Codigo", ',
              '   ALIQUOTA         "Numeric103", ',
              '   ALIQ_RED         "Numeric103", ',
              '   ALIQ_EFE         "Numeric103", ',
              '   ALIQ_DIF         "Numeric103"); '
      ));
      RunScript('ALTER TABLE TB_TAXES_IBS_UF ADD CONSTRAINT PK_TB_TAXES_IBS_UF PRIMARY KEY (TB_TAXES_ID);');
  End;

end;

procedure TNED.execalteracaotbTaxesIncidency;
begin
  if not existTable('TB_TAXES_INCIDENCY') then
  Begin
      RunScript(concat(
                'CREATE TABLE TB_TAXES_INCIDENCY( ',
                '  ID "Codigo", ',
                '  KIND "Descricao_50", ',
                '  DESCRIPTION "Descricao_100", ',
                '  GROUP_TRIB "Descricao_50"); '
      ));
      RunScript('ALTER TABLE TB_TAXES_INCIDENCY ADD PRIMARY KEY (ID);');

      ExecSqlScriptFromFile('TaxesIncidency.sql');
  End;

end;

procedure TNED.execalteracaoTB_BOLETO_BANCARIOBLE_DIAS_NEGATIVACAO;
begin
  if not existField('TB_BOLETO_BANCARIO','BLT_DT_NEGATIVACAO') then
  Begin
    RunScript('ALTER TABLE TB_BOLETO_BANCARIO ADD BLT_DT_NEGATIVACAO   DATE;');
  End;

end;

procedure TNED.execalteracaoTB_BOLETO_BANCARIOBLE_NEGATIVACAO;
begin
  if not existField('TB_BOLETO_ELETRONICO','BLE_NEGATIVACAO') then
  Begin
    RunScript('ALTER TABLE TB_BOLETO_ELETRONICO ADD BLE_NEGATIVACAO  CHAR(3);');
  End;

end;

procedure TNED.execalteracaoTB_BOLETO_BANCARIOBLT_DIAS_NEGATIVACAO;
begin
  if not existField('TB_BOLETO_BANCARIO','BLT_DIAS_NEGATIVACAO') then
  Begin
    RunScript('ALTER TABLE TB_BOLETO_BANCARIO ADD BLT_DIAS_NEGATIVACAO INTEGER;');
  End;

end;

procedure TNED.execalteracaoTB_BOLETO_BANCARIOBLT_DT_NEGATIVACAO;
begin
  if not existField('TB_BOLETO_ELETRONICO','BLE_DIAS_NEGATIVACAO') then
  Begin
    RunScript('ALTER TABLE TB_BOLETO_ELETRONICO ADD BLE_DIAS_NEGATIVACAO INTEGER;');
  End;

end;

procedure TNED.execalteracaoTB_CBS;
begin
  if not existTable('TB_CBS') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_CBS ( ',
          '    ID "Codigo" PRIMARY KEY, ',
          '    TB_IBSCBS_ID "Codigo", ',
          '    PCBS "Numeric154", ',
          '    VCBS "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;

end;

procedure TNED.execAlteracaoTB_CONSERTOADDCST_ACESSORIO;
begin
  if not existField('TB_CONSERTO','CST_ACESSORIO') then
  Begin
    RunScript('ALTER TABLE TB_CONSERTO ADD CST_ACESSORIO      "Observacao"; ');
  End;
end;

procedure TNED.execAlteracaoTB_CONSERTOADDCST_CONSTATADO;
begin
  if not existField('TB_CONSERTO','CST_CONSTATADO') then
  Begin
    RunScript('ALTER TABLE TB_CONSERTO ADD CST_CONSTATADO     "Observacao";');
  End;

end;

procedure TNED.execAlteracaoTB_CONSERTOADDCST_RELATADO;
begin
  if not existField('TB_CONSERTO','CST_RELATADO') then
  Begin
    RunScript('ALTER TABLE TB_CONSERTO ADD CST_RELATADO       "Observacao";');
  End;
end;

procedure TNED.execAlteracaoTB_CONSERTOADDDT_FORECAST;
begin
  if not existField('TB_CONSERTO','DT_FORECAST') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD DT_FORECAST DATE;');
  End;
end;

procedure TNED.execAlteracaoTB_CONSERTOADDEXECUTADO;
begin
  if not existField('TB_CONSERTO','EXECUTADO') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD  EXECUTADO VARCHAR(255) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoTB_CONSERTOADDIMEI;
begin
  if not existField('TB_CONSERTO','IMEI') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD  IMEI VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;
end;

procedure TNED.execAlteracaoTB_CONSERTOADDNOTE;
begin
  if not existField('TB_CONSERTO','NOTE') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD  NOTE VARCHAR(255) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoTB_CONSERTOADDSERIE;
begin
  if not existField('TB_CONSERTO','SERIE') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD  SERIE VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

end;

procedure TNED.execAlteracaoTB_CONSERTOADDTB_COLABORADOR_ID;
begin
  if not existField('TB_CONSERTO','TB_COLABORADOR_ID') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD TB_COLABORADOR_ID INTEGER;');
  End;


end;

procedure TNED.execAlteracaoTB_CONSERTOBLOB;
begin
  if not (existTabelaCampoDominio('TB_CONSERTO','CST_ACESSORIO','Observacao')) then
  Begin
    RunScript(concat(
                'update RDB$RELATION_FIELDS set ',
                'RDB$FIELD_SOURCE = ''Observacao'' ',
                'where (RDB$FIELD_NAME = ''CST_ACESSORIO'') and ',
                '(RDB$RELATION_NAME = ''TB_CONSERTO'') '
    ));

  End;

  if not (existTabelaCampoDominio('TB_CONSERTO','CST_RELATADO','Observacao')) then
  Begin
    RunScript(concat(
                'update RDB$RELATION_FIELDS set ',
                'RDB$FIELD_SOURCE = ''Observacao''  ',
                'where (RDB$FIELD_NAME = ''CST_RELATADO'') and ',
                '(RDB$RELATION_NAME = ''TB_CONSERTO'') '
    ));

  End;

  if not (existTabelaCampoDominio('TB_CONSERTO','CST_CONSTATADO','Observacao')) then
  Begin
    RunScript(concat(
                'update RDB$RELATION_FIELDS set ',
                'RDB$FIELD_SOURCE = ''Observacao'' ',
                'where (RDB$FIELD_NAME = ''CST_CONSTATADO'') and ',
                '(RDB$RELATION_NAME = ''TB_CONSERTO'') '
    ));
  End;

  if not (existTabelaCampoDominio('TB_CONSERTO','NOTE','Observacao')) then
  Begin
    RunScript(concat(
                'update RDB$RELATION_FIELDS set ',
                'RDB$FIELD_SOURCE = ''Observacao'', ',
                'RDB$COLLATION_ID = -1 ',
                'where (RDB$FIELD_NAME = ''NOTE'') and ',
                '(RDB$RELATION_NAME = ''TB_CONSERTO'') '
    ));
  End;

  if not (existTabelaCampoDominio('TB_CONSERTO','EXECUTADO','Observacao')) then
  Begin
    RunScript(concat(
                'update RDB$RELATION_FIELDS set ',
                'RDB$FIELD_SOURCE = ''Observacao'', ',
                'RDB$COLLATION_ID = -1 ',
                'where (RDB$FIELD_NAME = ''EXECUTADO'') and ',
                '(RDB$RELATION_NAME = ''TB_CONSERTO'') '
    ));
  End;
end;

procedure TNED.execAlteracaoTB_CONSERTO_HR_CONSERTO;
begin
  if not existField('TB_CONSERTO','HR_CONSERTO') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD HR_CONSERTO TIME;' );
  End;
end;

procedure TNED.execAlteracaoTB_CONSERTO_HR_ENTREGA;
begin
  if not existField('TB_CONSERTO','HR_ENTREGA') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD HR_ENTREGA  TIME;' );
  End;

end;

procedure TNED.execAlteracaoTB_CONSERTO_HR_FORECAST;
begin
  if not existField('TB_CONSERTO','HR_FORECAST') then
  Begin
    RunScript( 'ALTER TABLE TB_CONSERTO ADD HR_FORECAST TIME;' );
  End;

end;

procedure TNED.execAlteracaoTB_CONTADOR;
Var
  LcContabilidade : TControllerContador;
begin
  if not existTabela('TB_CONTADOR') then
  Begin
    RunScript( concat('CREATE TABLE TB_CONTADOR ( ',
                    'CON_CODEMP  INTEGER NOT NULL, ',
                    'CON_ATIVO   CHAR(1) ) '
            ));
    RunScript( 'ALTER TABLE TB_CONTADOR ADD CONSTRAINT PK_TB_CONTADOR PRIMARY KEY (CON_CODEMP);');
    RunScript( 'ALTER TABLE TB_CONTADOR ADD CONSTRAINT FK_TB_CONTADOR_1 FOREIGN KEY (CON_CODEMP) REFERENCES TB_EMPRESA (EMP_CODIGO);');

    try
      LcContabilidade := TControllerContador.create(nil);
      LcContabilidade.getRegistroEmpresa;
      if LcContabilidade.exist then
      Begin
        LcContabilidade.Registro.Codigo := LcContabilidade.Empresa.Registro.Codigo;
        LcContabilidade.Registro.Ativo := 'S';
        LcContabilidade.salva;
      End;

    finally
      FreeAndNil(LcContabilidade);
    end;
  End;

end;

procedure TNED.execAlteracaoTB_CONTRACT;
begin
  if not existTabela('TB_CONTRACT') then
  Begin
    RunScript(concat(
                'create table TB_CONTRACT ( ',
                '  ID "Codigo", ',
                '  TB_INSTITUTION_ID "Codigo", ',
                '  KIND "Descricao_25", ',
                '  TITTLE "Descricao_100", ',
                '  SQLCMD "Observacao", ',
                '  CONTENTS "Observacao"); '
    ));

  End;
  if NOT existGenerator('GN_CONTRACT') then
  Begin
    RunScript('CREATE GENERATOR GN_CONTRACT;');
  End;
end;

procedure TNED.execAlteracaoTB_CONTRACT_CHAVES;
begin
  if not existTabela('TB_CONTRACT_CHAVES') then
  Begin
    RunScript(concat(
                'create table TB_CONTRACT_CHAVES ( ',
                '  ID "Codigo", ',
                '  TB_CONTRACT_ID "Codigo", ',
                '  CHAVE VARCHAR(100), ',
                '  FIELD VARCHAR(100)); '
    ));
    RunScript('CREATE GENERATOR GN_CONTRACT_CHAVES;');
  End;

end;

procedure TNED.execAlteracaoTB_CONTRACT_ORDER;
begin
  if not existTabela('TB_CONTRACT_ORDER') then
  Begin
    RunScript(concat(
                'create table TB_CONTRACT_ORDER ( ',
                '  TB_PEDIDO_ID "Codigo", ',
                '  TB_CONTRACT_ID "Codigo", ',
                '  TITTLE "Descricao_100", ',
                '  CONTENTS "Observacao", ',
                '  LAST_UPDATE "DataeHora");'
    ));
  End;
end;

procedure TNED.execAlteracaoTB_COTACAOCTC_CODVDO_AUX;
begin
  if not existField('TB_COTACAO','CTC_CODVDO_AUX') then
  Begin
    RunScript('ALTER TABLE TB_COTACAO ADD CTC_CODVDO_AUX INTEGER;');
  End;

end;


procedure TNED.execAlteracaoTB_CRP_ITENS;
begin
  if existTabela('TB_CRP_ITENS') then
  Begin
    if not existField('TB_CRP_ITENS','CPI_CODIGO') Then
    BEgin
      RunScript('ALTER TABLE TB_CRP_ITENS ADD CPI_CODIGO INTEGER;');
    end;
    if not existGenerator('GN_CRP_ITENS') then
    BEgin
      RunScript( 'CREATE SEQUENCE  GN_CRP_ITENS');
    end;
    if not existField('TB_CRP_ITENS','CPI_CODGRP') Then
    BEgin
      RunScript( 'ALTER TABLE TB_CRP_ITENS ADD CPI_CODGRP INTEGER;');
    end;

    geraSequenciaTB_CRP_ITENS;
    PreecheGrupoTB_CRP_ITENS;

  End;

end;

procedure TNED.execAlteracaoTB_CTRL_LOTECLT_ESTOQUE;
begin
  if not existField('TB_CTRL_LOTE','CLT_ESTOQUE') then
  Begin
    RunScript( 'ALTER TABLE TB_CTRL_LOTE ADD CLT_ESTOQUE CHAR(1);' );
  end;

end;

procedure TNED.execAlteracaoTB_ELECT_EQUIP;
begin
  if not existTabela('TB_ELECT_EQUIP') then
  Begin
    RunScript(concat(
                'CREATE TABLE TB_ELECT_EQUIP ( ',
                '    ID              INTEGER NOT NULL, ',
                '    TB_CUSTOMER_ID  INTEGER NOT NULL, ',
                '    DEVICE          VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    BRAND           VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    MODEL           VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    SERIE           VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    IMEI            VARCHAR(50) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '    ACCESSORIES     VARCHAR(255) CHARACTER SET WIN1252 COLLATE WIN_PTBR ); '
    ));
    RunScript('ALTER TABLE TB_ELECT_EQUIP ADD CONSTRAINT PK_TB_ELECT_EQUIP PRIMARY KEY (ID);');
    RunScript('ALTER TABLE TB_ELECT_EQUIP ADD CONSTRAINT FK_TB_ELECT_EQUIP_1 FOREIGN KEY (TB_CUSTOMER_ID) REFERENCES TB_EMPRESA (EMP_CODIGO);');
  End;
end;

procedure TNED.execAlteracaoTB_EXCHANGE_BASIS;
Var
  LcAux : String;
begin
  if not existTabela('TB_EXCHANGE_BASIS') then
  Begin
    LcAux := concat(
                'CREATE TABLE TB_EXCHANGE_BASIS ( ',
                '    TB_INSTITUTION_ID  INTEGER NOT NULL, ',
                '    TB_ORDER_ID        INTEGER NOT NULL, ',
                '    TB_ORDER_ITEM_ID   INTEGER NOT NULL, ',
                '    TB_USER_ID         INTEGER, ',
                '    TB_CUSTOMER_ID     INTEGER, ',
                '    TB_SALESMAN_ID     INTEGER, ',
                '    TB_PRODUCT_ID      INTEGER, ',
                '    DT_RECORD          DATE, ',
                '    PRICE_TAG          NUMERIC(10,6), ',
                '    DT_IN              DATE, ',
                '    WEIGHT_IN          NUMERIC(10,3), ',
                '    DT_OUT             DATE, ',
                '    WEIGHT_OUT         NUMERIC(10,3), ',
                '    NOTE               VARCHAR(255)); '
    );
    RunScript(LcAux);
    LcAux := 'ALTER TABLE TB_EXCHANGE_BASIS ADD CONSTRAINT PK_TB_EXCHANGE_BASIS PRIMARY KEY (TB_INSTITUTION_ID, TB_ORDER_ID, TB_ORDER_ITEM_ID);';
    RunScript(LcAux);

    LcAux := 'CREATE INDEX TB_EXCHANGE_BASIS_IDX1 ON TB_EXCHANGE_BASIS (TB_INSTITUTION_ID);';
    RunScript(LcAux);
    LcAux := 'CREATE INDEX TB_EXCHANGE_BASIS_IDX2 ON TB_EXCHANGE_BASIS (TB_ORDER_ID);';
    RunScript(LcAux);
    LcAux := 'CREATE INDEX TB_EXCHANGE_BASIS_IDX3 ON TB_EXCHANGE_BASIS (TB_ORDER_ITEM_ID);';
    RunScript(LcAux);
    LcAux := 'CREATE INDEX TB_EXCHANGE_BASIS_IDX4 ON TB_EXCHANGE_BASIS (TB_USER_ID);';
    RunScript(LcAux);
    LcAux := 'CREATE INDEX TB_EXCHANGE_BASIS_IDX5 ON TB_EXCHANGE_BASIS (TB_CUSTOMER_ID);';
    RunScript(LcAux);
    LcAux := 'CREATE INDEX TB_EXCHANGE_BASIS_IDX6 ON TB_EXCHANGE_BASIS (TB_PRODUCT_ID);';
    RunScript(LcAux);
    LcAux := 'CREATE INDEX TB_EXCHANGE_BASIS_IDX7 ON TB_EXCHANGE_BASIS (DT_RECORD);';
    RunScript(LcAux);

  End;

end;

procedure TNED.execAlteracaoTB_FINANCEIROFIN_AUTORIZADO;
begin
  if not existField('TB_FINANCEIRO','FIN_AUTORIZADO') then
  Begin
    RunScript( 'ALTER TABLE TB_FINANCEIRO ADD FIN_AUTORIZADO CHAR(1);' );
    RunScript( 'UPDATE TB_FINANCEIRO SET FIN_AUTORIZADO = ''S'' WHERE FIN_AUTORIZADO is NULL;');
  End;
end;

procedure TNED.execAlteracaoTB_FORMAPAGTOFPT_APP_DELIVERY;
begin
  if not existField('TB_FORMAPAGTO','FPT_APP_DELIVERY') then
  Begin
    RunScript( 'ALTER TABLE TB_FORMAPAGTO ADD FPT_APP_DELIVERY  CHAR(1) DEFAULT ''N'';' );
  End;
end;

procedure TNED.execAlteracaoTB_FORMA_PAGTO_FPT_TEF;
begin
  if not existField('TB_FORMAPAGTO','FPT_TEF') then
  Begin
    RunScript( 'alter table tb_formapagto add  FPT_TEF CHAR(1) DEFAULT ''N'';' );
  End;

end;

procedure TNED.execAlteracaoTB_FURNITURE_OS;
begin
  if not existTabeLA('TB_FURNITURE_OS') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_FURNITURE_OS ( ',
                '    TB_ORDER_ID        "Codigo", ',
                '    EQUIPMENT          "Descricao_100", ',
                '    ENVIRONMENT        "Descricao_100", ',
                '    BRAND              "Descricao_100", ',
                '    MODEL              "Descricao_100", ',
                '    REPORTED           "Observacao", ',
                '    "FOUND"            "Observacao", ',
                '    EXECUTED           "Observacao", ',
                '    NOTE               "Observacao", ',
                '    DT_ATTENDANCE      "Data", ',
                '    HR_ATTENDANCE      "Hora", ',
                '    TB_COLABORADOR_ID  "Inteiro", ',
                '    TB_SITUACAO_ID     "Inteiro"); '
    ));
    RunScript('ALTER TABLE TB_FURNITURE_OS ADD CONSTRAINT PK_TB_FURNITURE_OS PRIMARY KEY (TB_ORDER_ID);');
  End;

end;


procedure TNED.execAlteracaoTB_GESTAO_WEB;
begin
  if not existTabeLA('TB_GESTAO_WEB') then
  Begin
    RunScript( concat(
            'CREATE TABLE TB_GESTAO_WEB ( ',
            '    TABELA  VARCHAR(50) NOT NULL, ',
            '    ID      INTEGER NOT NULL, ',
            '    WEB_ID  INTEGER );'
    ));
    RunScript( concat('ALTER TABLE TB_GESTAO_WEB ADD PRIMARY KEY (TABELA, ID);'));
  End;
end;

procedure TNED.execAlteracaoTB_GRUPGRP_SHOW_MENU;
begin
  if not existField('TB_GRUPOS','GRP_SHOW_MENU') then
  Begin
    RunScript( 'ALTER TABLE TB_GRUPOS ADD GRP_SHOW_MENU CHAR(1);' );
  end;

end;

procedure TNED.execAlteracaoTB_GRUPOGRP_ATIVO;
begin
  if not existField('TB_GRUPOS','GRP_ATIVO') then
  Begin
    RunScript( 'ALTER TABLE TB_GRUPOS ADD GRP_ATIVO CHAR(1);' );
  end;

end;

procedure TNED.execalteracaoTB_GRUPOSIFOOD;
begin
  if not existField('TB_GRUPOS','IFOOD') then
  Begin
    RunScript( 'ALTER TABLE TB_GRUPOS ADD IFOOD CHAR(1);' );
  end;

end;

procedure TNED.execalteracaoTB_GRUPOSIFOOD_CD;
begin
  if not existField('TB_GRUPOS','IFOOD_CD') then
  Begin
    RunScript( 'ALTER TABLE TB_GRUPOS ADD IFOOD_CD VARCHAR(50);' );
  end;
end;



procedure TNED.execalteracaoTB_IBSCBS;
begin
  if not existTable('TB_IBSCBS') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS ( ',
          '    ID "Codigo" PRIMARY KEY, ',
          '    CODNFL "Codigo", ',
          '    CODITF "Codigo", ',
          '    CST "Descricao_10", ',
          '    CLASSTRIB "Descricao_10", ',
          '    VBC "Numeric154", ',
          '    VIBS "Numeric154" ); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBSCBS_CREDPRES;
begin
  if not existTable('TB_IBSCBS_CREDPRES') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_CREDPRES ( ',
          '    TB_IBSCBS_ID "Codigo" PRIMARY KEY, ',
          '    CCREDPRESP "Descricao_10", ',
          '    PCREDPRES  "Numeric154", ',
          '    VCREDPRES  "Numeric154", ',
          '    VCREDPRESCONDSUS "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBSCBS_CREDPRES_IBSZFM;
begin
  if not existTable('TB_IBSCBS_CREDPRES_IBSZFM') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_CREDPRES_IBSZFM ( ',
          '    TB_IBSCBS_ID "Codigo" PRIMARY KEY, ',
          '    TCPBENSCONSUMOFINAL "Descricao_10", ',
          '    VCREDPRESIBSZFM "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBSCBS_DEVTRIB;
begin
  if not existTable('TB_IBSCBS_DEVTRIB') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_DEVTRIB ( ',
          '    LINK_ID "Codigo", ',
          '    LINK_KIND "Descricao_20" NOT NULL, ',
          '    TB_IBSCBS_ID "Codigo" , ',
          '    VDEVTRIB  "Numeric154" ); '
      ));
  End;
  execAlteracaoPK_TB_IBSCBS_Link('TB_IBSCBS_DEVTRIB');
end;

procedure TNED.execalteracaoTB_IBSCBS_DIF;
begin
  if not existTable('TB_IBSCBS_DIF') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_DIF ( ',
          '    LINK_ID "Codigo", ',
          '    LINK_KIND "Descricao_20" NOT NULL, ',
          '    TB_IBSCBS_ID "Codigo" , ',
          '    PDIF  "Numeric154", ',
          '    VDIF "Numeric154" ); '
      ));
  End;
  execAlteracaoPK_TB_IBSCBS_Link('TB_IBSCBS_DIF');
end;

procedure TNED.execalteracaoTB_IBSCBS_MONO;
begin
  if not existTable('TB_IBSCBS_MONO') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_MONO ( ',
          '    TB_IBSCBS_ID "Codigo" PRIMARY KEY, ',
          '    QBCMONO "Numeric154", ',
          '    ADREMIBS "Numeric154", ',
          '    ADREMCBS "Numeric154", ',
          '    VIBSMONO "Numeric154", ',
          '    VCBSMONO "Numeric154", ',
          '    QBCMONORETEN "Numeric154", ',
          '    ADREMIBSRETEN "Numeric154", ',
          '    VIBSMONORETEN "Numeric154", ',
          '    ADREMCBSRETEN "Numeric154", ',
          '    VCBSMONORETEN "Numeric154", ',
          '    QBCMONORET "Numeric154", ',
          '    ADREMIBSRET "Numeric154", ',
          '    VIBSMONORET "Numeric154", ',
          '    ADREMCBSRET "Numeric154", ',
          '    VCBSMONORET "Numeric154", ',
          '    PDIFIBS "Numeric154", ',
          '    VIBSMONODIF "Numeric154", ',
          '    PDIFCBS "Numeric154", ',
          '    VCBSMONODIF "Numeric154", ',
          '    VTOTIBSMONOITEM "Numeric154", ',
          '    VTOTCBSMONOITEM "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBSCBS_RED;
begin
  if not existTable('TB_IBSCBS_RED') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_RED ( ',
          '    LINK_ID "Codigo", ',
          '    LINK_KIND "Descricao_20" NOT NULL, ',
          '    TB_IBSCBS_ID "Codigo" , ',
          '    PREDALIQ  "Numeric154", ',
          '    PALIQEFET "Numeric154" ); '
      ));
  End;
  execAlteracaoPK_TB_IBSCBS_Link('TB_IBSCBS_RED');
end;

procedure TNED.execalteracaoTB_IBSCBS_IBSCREDPRES;
begin
  if not existTable('TB_IBSCBS_IBSCREDPRES') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_IBSCREDPRES ( ',
          '    TB_IBSCBS_ID "Codigo" PRIMARY KEY, ',
          '    CCREDPRES "Descricao_10", ',
          '    PCREDPRES "Numeric154", ',
          '    VCREDPRES "Numeric154", ',
          '    VCREDPRESCONDSUS "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBS_MUN;
begin
  if not existTable('TB_IBS_MUN') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBS_MUN ( ',
          '    ID "Codigo" PRIMARY KEY, ',
          '    TB_IBSCBS_ID "Codigo", ',
          '    PIBSMUN "Numeric154", ',
          '    PDIF "Numeric154", ',
          '    VDIF "Numeric154", ',
          '    VDEVTRIB "Numeric154", ',
          '    PREDALIQ "Numeric154", ',
          '    PALIQEFET "Numeric154", ',
          '    VIBSMUN "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBS_UF;
begin
  if not existTable('TB_IBS_UF') then
  Begin
      RunScript(concat(
            'CREATE TABLE TB_IBS_UF ( ',
            '    ID "Codigo" PRIMARY KEY, ',
            '    TB_IBSCBS_ID "Codigo", ',
            '    PIBSUF "Numeric154", ',
            '    GDIF "Numeric154", ',
            '    VDEVTRIB "Numeric154", ',
            '    GRED "Numeric154", ',
            '    VIBSUF "Numeric154", ',
            '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBSCBS_TRANSFCRED;
begin
  if not existTable('TB_IBSCBS_TRANSFCRED') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_TRANSFCRED ( ',
          '    TB_IBSCBS_ID "Codigo" PRIMARY KEY, ',
          '    VIBS "Numeric154", ',
          '    VCBS "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBSCBS_TRIBCOMPRA_GOV;
begin
  if not existTable('TB_IBSCBS_TRIBCOMPRA_GOV') then
  Begin
      RunScript(concat(
        'CREATE TABLE TB_IBSCBS_TRIBCOMPRA_GOV ( ',
        '    TB_IBSCBS_ID "Codigo" PRIMARY KEY, ',
        '    PALIQIBSUF "Numeric154", ',
        '    VTRIBIBSUF "Numeric154", ',
        '    PALIQIBSMUN "Numeric154", ',
        '    VTRIBIBSMUN "Numeric154", ',
        '    PALIQCBS "Numeric154", ',
        '    VTRIBCBS "Numeric154", ',
        '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IBSCBS_TRIBREGULAR;
begin
  if not existTable('TB_IBSCBS_TRIBREGULAR') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IBSCBS_TRIBREGULAR ( ',
          '    TB_IBSCBS_ID "Codigo" PRIMARY KEY, ',
          '    CSTREG "Descricao_10", ',
          '    CCLASSTRIBREG "Descricao_10", ',
          '    PALIQEFETREGIBSUF "Numeric154", ',
          '    VTRIBREGIBSUF "Numeric154", ',
          '    PALIQEFETREGIBSMUN "Numeric154", ',
          '    VTRIBREGIBSMUN "Numeric154", ',
          '    PALIQEFETREGCBS "Numeric154", ',
          '    VTRIBREGCBS "Numeric154", ',
          '    FOREIGN KEY (TB_IBSCBS_ID) REFERENCES TB_IBSCBS(ID)); '
      ));
  End;
end;

procedure TNED.execalteracaoTB_IFOOD;
begin
  if not existTable('TB_IFOOD') then
  Begin
    RunScript( concat(
      'CREATE TABLE TB_IFOOD ( ',
      '    CLIENT_ID          "Descricao_50" NOT NULL, ',
      '    CLIENT_SECRET      "Descricao_200", ',
      '    CLIENT_USERNAME    "Descricao_50", ',
      '    CLIENT_PASSWORD    "Descricao_50", ',
      '    SH_ID              "Descricao_50", ',
      '    REFRESH_TOKEN      "Descricao_500", ',
      '    MERCHANT_ID        "Descricao_50", ',
      '    TB_INSTITUTION_ID  "Codigo"      ); '
    ));
    RunScript('ALTER TABLE TB_IFOOD ADD CONSTRAINT PK_TB_IFOOD PRIMARY KEY (CLIENT_ID);');
  End;
end;

procedure TNED.execalteracaoTB_IFOODAUTHORIZATION_CODE;
begin
  if not existField('TB_IFOOD','AUTHORIZATION_CODE') then
  Begin
    RunScript('ALTER TABLE TB_IFOOD ADD AUTHORIZATION_CODE "Descricao_20";');
  End;

end;

procedure TNED.execalteracaoTB_IFOOD_ORDERID_SETES;
Var
  Lc_Ifood : TControllerIfoodOrder;
begin
  if not existField('TB_IFOOD_ORDER','ID_SETES') then
  Begin
    RunScript('ALTER TABLE tb_ifood_order add ID_SETES "Codigo";');
    RunScript('CREATE INDEX TB_IFOOD_ORDER_IDX1 ON TB_IFOOD_ORDER (ID_SETES);');
    try
      Lc_Ifood := TControllerIfoodOrder.Create(Self);
      Lc_Ifood.SetInitID_SETES;
    finally
      FreeAndNil(Lc_Ifood);
    end;
  End;

end;

procedure TNED.execalteracaoTB_IFOODKIND_RECORD_ORDER;
begin
  if not existField('TB_IFOOD','KIND_RECORD_ORDER') then
  Begin
    RunScript('ALTER TABLE tb_ifood ADD KIND_RECORD_ORDER "Descricao_10";');
  End;

end;

procedure TNED.execalteracaoTB_IFOOD_CUSTOMER;
begin
  if not existTable('TB_IFOOD_CUSTOMER') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_CUSTOMER ( ',
        '    TB_IFOOD_ORDER_ID     VARCHAR(50) NOT NULL, ',
        '    ID                    "Descricao_50", ',
        '    NAME                  "Descricao_100", ',
        '    PHONENUMBER           "Descricao_20", ',
        '    LOCALIZER             "Descricao_20", ',
        '    LOCALIZEREXPIRATION   "DataeHora", ',
        '    ORDERCOUNTONMERCHANT  "Inteiro", ',
        '    DOCUMENTNUMBER        "Descricao_20" ); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_CUSTOMER ADD PRIMARY KEY (TB_IFOOD_ORDER_ID);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_DELIVERY;
begin
  if not existTable('TB_IFOOD_DELIVERY') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_DELIVERY ( ',
        '    TB_IFOOD_ORDER_ID  "Descricao_50" NOT NULL, ',
        '    MODE               "Descricao_20", ',
        '    DELIVEREDBY        "Descricao_20", ',
        '    DELIVERYDATETIME   "DataeHora", ',
        '    STREETNAME         "Descricao_100", ',
        '    STREETNUMBER       "Descricao_10", ',
        '    FORMATTEDADDRESS   "Descricao_150", ',
        '    NEIGHBORHOOD       "Descricao_50", ',
        '    POSTALCODE         "Descricao_10", ',
        '    CITY               "Descricao_100", ',
        '    STATE              "Descricao_2", ',
        '    COUNTRY            "Descricao_50", ',
        '    OBSERVATIONS       "Observacao"); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_DELIVERY ADD PRIMARY KEY (TB_IFOOD_ORDER_ID);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_DELIVERYCOMPLEMENT;
begin
  if not existField('TB_IFOOD_DELIVERY','COMPLEMENT') then
  Begin
    RunScript('ALTER TABLE TB_IFOOD_DELIVERY ADD COMPLEMENT "Descricao_50";');
  End;


end;

procedure TNED.execalteracaoTB_IFOOD_DELIVERYREFERENCE;
begin
  if not existField('TB_IFOOD_DELIVERY','REFERENCE') then
  Begin
    RunScript('ALTER TABLE TB_IFOOD_DELIVERY ADD REFERENCE "Descricao_50";');
  End;

end;

procedure TNED.execalteracaoTB_IFOOD_EVENTS;
begin
  if not existTable('TB_IFOOD_EVENTS') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_EVENTS ( ',
        '    TB_INSTITUTION_ID  "Codigo", ',
        '    TB_IFOOD_ORDER_ID  "Descricao_50" NOT NULL, ',
        '    TYPE_EVENT         "Descricao_50" NOT NULL, ',
        '    EVENT_ID           "Descricao_50" NOT NULL); '
    ));

    RunScript('ALTER TABLE TB_IFOOD_EVENTS ADD CONSTRAINT PK_TB_IFOOD_EVENTS PRIMARY KEY (TB_INSTITUTION_ID, TB_IFOOD_ORDER_ID, TYPE_EVENT);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_ORDER;
begin
  if not existTable('TB_IFOOD_ORDER') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_ORDER ( ',
        '    ID                     "Descricao_50" NOT NULL, ',
        '    ORDERTYPE              "Descricao_20", ',
        '    ORDERTIMING            "Descricao_20", ',
        '    DISPLAYID              "Descricao_10", ',
        '    CREATEDAT              "DataeHora", ',
        '    PREPARATIONSTART       "DataeHora", ',
        '    SALESCHANNEL           "Descricao_10", ',
        '    STATUS                 "Descricao_50", ',
        '    STATUS_TM              "DataeHora", ',
        '    CREATEDATLOCAL         "DataeHora", ',
        '    EXTRA_INFO             "Observacao", ',
        '    DELIVERYDATETIME       "DataeHora", ',
        '    DELIVERYDATETIMESTART  "DataeHora", ',
        '    DELIVERYDATETIMEEND    "DataeHora"); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_ORDER ADD PRIMARY KEY (ID);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_ORDER_BENEFITS;
begin
  if not existTable('TB_IFOOD_ORDER_BENEFITS') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_ORDER_BENEFITS ( ',
        '    TB_IFOOD_ORDER_ID  "Descricao_50" NOT NULL, ',
        '    TARGET             "Descricao_10", ',
        '    TOTAL_VALUE        "Numeric102", ',
        '    IFOOD_VALUE        "Numeric102", ',
        '    MERCHANT_VALUE     "Numeric102", ',
        '    SPONSORSHIP        "Descricao_10" NOT NULL ); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_ORDER_BENEFITS ADD CONSTRAINT PK_TB_IFOOD_ORDER_BENEFITS PRIMARY KEY (TB_IFOOD_ORDER_ID, SPONSORSHIP);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_ORDER_ITEMS;
begin
  if not existTable('TB_IFOOD_ORDER_ITEMS') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_ORDER_ITEMS ( ',
        '    TB_IFOOD_ORDER_ID  "Descricao_50" NOT NULL, ',
        '    ID                 "Codigo", ',
        '    INDEX_             "Inteiro", ',
        '    NAME               "Descricao_100", ',
        '    EXTERNALCODE       "Inteiro", ',
        '    UNIT               "Descricao_5", ',
        '    QUANTITY           "Numeric103", ',
        '    UNITPRICE          "Numeric106", ',
        '    OPTIONPRICE        "Numeric106", ',
        '    TOTALPRICE         "Numeric106", ',
        '    OBSERVATIONS       "Descricao_100"); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_ORDER_ITEMS ADD CONSTRAINT PK_TB_IFOOD_ORDER_ITEMS PRIMARY KEY (TB_IFOOD_ORDER_ID, ID);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_ORDER_ITEMS_OPTIONS;
begin
  if not existTable('TB_IFOOD_ORDER_ITEMS_OPTIONS') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_ORDER_ITEMS_OPTIONS ( ',
        '    TB_IFOOD_ORDER_ID        "Descricao_50" NOT NULL, ',
        '    TB_IFOOD_ORDER_ITEMS_ID  "Codigo", ',
        '    ID                       "Codigo", ',
        '    INDEX_                   "Inteiro", ',
        '    NAME                     "Descricao_100", ',
        '    EXTERNALCODE             "Inteiro", ',
        '    UNIT                     "Descricao_5", ',
        '    QUANTITY                 "Numeric103", ',
        '    UNITPRICE                "Numeric106", ',
        '    ADDITION                 "Numeric106", ',
        '    PRICE                    "Numeric106"); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_ORDER_ITEMS_OPTIONS ADD CONSTRAINT PK_TB_IFOOD_ORDER_ITEMS_OPTIONS PRIMARY KEY (TB_IFOOD_ORDER_ID, TB_IFOOD_ORDER_ITEMS_ID, ID);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_ORDER_PAYMENT;
begin
  if not existTable('TB_IFOOD_ORDER_PAYMENT') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_ORDER_PAYMENT ( ',
        '    TB_IFOOD_ORDER_ID  "Descricao_50" NOT NULL, ',
        '    ID                 "Codigo", ',
        '    METHOD             "Descricao_50", ',
        '    TYPE_              "Descricao_50", ',
        '    CODE               "Descricao_50", ',
        '    VALUE_             "Numeric102", ',
        '    PREPAID            "Descricao_1", ',
        '    COLLETOR           "Descricao_25", ',
        '    CARD_BRAND         "Descricao_25", ',
        '    CARD_DESCRIPTION   "Descricao_25", ',
        '    CHANGEFOR          "Numeric102", ',
        '    CHANGEVALUE        "Numeric102", ',
        '    PENDING            "Numeric102"); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_ORDER_PAYMENT ADD CONSTRAINT PK_TB_IFOOD_ORDER_PAYMENT PRIMARY KEY (TB_IFOOD_ORDER_ID, ID);');
  End;
end;

procedure TNED.execalteracaoTB_IFOOD_ORDER_TOTAL;
begin
  if not existTable('TB_IFOOD_ORDER_TOTAL') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_IFOOD_ORDER_TOTAL ( ',
        '    TB_IFOOD_ORDER_ID  VARCHAR(50) NOT NULL, ',
        '    SUBTOTAL           "Numeric102", ',
        '    DELIVERYFEE        "Numeric102", ',
        '    TOTALBENEFITS      "Numeric102", ',
        '    TOTALPRICE         "Numeric102", ',
        '    ADDITIONALFEES     "Numeric102", ',
        '    PENDINGVALUE       "Numeric102", ',
        '    PREPAIDVALUE       "Numeric102"); '
    ));
    RunScript('ALTER TABLE TB_IFOOD_ORDER_TOTAL ADD CONSTRAINT PK_TB_IFOOD_ORDER_TOTAL PRIMARY KEY (TB_IFOOD_ORDER_ID);');
  End;
end;

procedure TNED.execalteracaoTB_IMPRESSORAIMP_MODELO;
begin
  if not existField('TB_IMPRESSORA','IMP_MODELO') then
  Begin
    RunScript('ALTER TABLE tb_impressora ADD IMP_MODELO "Descricao_20";');
  End;

end;

procedure TNED.execalteracaoTB_IMP_SELETIVO;
begin
  if not existTable('TB_IMP_SELETIVO') then
  Begin
      RunScript(concat(
          'CREATE TABLE TB_IMP_SELETIVO ( ',
          '  ID "Codigo" PRIMARY KEY, ',
          '  CODNFL "Inteiro", ',
          '  CODITF "Inteiro", ',
          '  CST           "Descricao_10", ',
          '  CCLASSTRIB    "Descricao_10", ',
          '  VBCIS         "Numeric154", ',
          '  PIS           "Numeric154", ',
          '  PISESPEC      "Numeric154", ',
          '  UTRIB         "Numeric154", ',
          '  QTRIB         "Numeric154", ',
          '  VIS           "Numeric154"); '
      ));
  End;
end;

procedure TNED.execAlteracaoTB_INTERFACEIFC_CODPRJ;
begin
  if not existField('TB_INTERFACE','IFC_CODPRJ') then
  Begin
    RunScript('ALTER TABLE TB_INTERFACE ADD IFC_CODPRJ INTEGER;');
  End;
end;

procedure TNED.execalteracaoTB_ITENS_ICMSICM_AQ_DIF;
begin
  if not existField('TB_ITENS_ICMS','ICM_AQ_DIF') then
  Begin
    RunScript( 'alter TABLE TB_ITENS_ICMS ADD ICM_AQ_DIF "Numeric102";' );
  End;

end;

procedure TNED.execAlteracaoTB_ITENS_ICMSICM_BCFCPST;
begin
  if not existField('TB_ITENS_ICMS','ICM_BCFCPST') then
  Begin
    RunScript('ALTER TABLE TB_ITENS_ICMS ADD ICM_BCFCPST "Numeric102";');
  End;

end;

procedure TNED.execAlteracaoTB_ITENS_ICMSICM_PFCPST;
begin
  if not existField('TB_ITENS_ICMS','ICM_PFCPST') then
  Begin
    RunScript('ALTER TABLE TB_ITENS_ICMS ADD ICM_PFCPST "Numeric102";');
  End;

end;

procedure TNED.execAlteracaoTB_ITENS_ICMSICM_VFCPST;
begin
  if not existField('TB_ITENS_ICMS','ICM_VFCPST') then
  Begin
    RunScript('ALTER TABLE TB_ITENS_ICMS ADD ICM_VFCPST "Numeric102";');
  End;

end;

procedure TNED.execalteracaoTB_ITENS_ICMSICM_VL_DIF;
begin
  if not existField('TB_ITENS_ICMS','ICM_VL_DIF') then
  Begin
    RunScript( 'alter TABLE TB_ITENS_ICMS ADD ICM_VL_DIF "Numeric102";' );
  End;

end;

procedure TNED.execAlteracaoTB_ITENS_NFL_TRIBUTACAO;
begin
  if not existTabela('TB_ITENS_NFL_TRIBUTACAO') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_ITENS_NFL_TRIBUTACAO ( ',
                '    TB_ORDER_ITENS_ID  INTEGER NOT NULL, ',
                '    TB_TAX_RULER_ID    INTEGER NOT NULL, ',
                '  CFOP VARCHAR(10), ',
                '  SET_FINANCIAL CHAR(1)); '
    ));

    RunScript( 'ALTER TABLE TB_ITENS_NFL_TRIBUTACAO ADD CONSTRAINT PK_TB_ITENS_NFL_TRIBUTACAO PRIMARY KEY (TB_ORDER_ITENS_ID, TB_TAX_RULER_ID);');
  End;

end;

procedure TNED.execalteracaoTB_ITENS_OBS;
begin
  if not existTabeLA('TB_ITENS_OBS') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_ITENS_OBS ( ',
                '    TB_ITENS_CTC_ID  INTEGER NOT NULL, ',
                '    TB_ITENS_NFL_ID  INTEGER NOT NULL, ',
                '    DETAIL   BLOB SUB_TYPE 1 SEGMENT SIZE 80 CHARACTER SET WIN1252 COLLATE WIN_PTBR ',
                '); '
            ));
    RunScript( concat('CREATE INDEX TB_ITENS_OBS_IDX1 ON TB_ITENS_OBS (TB_ITENS_CTC_ID);'));
  End;

end;

procedure TNED.execalteracaoTB_ITENS_RTR;
begin
  if not existTabeLA('TB_ITENS_RTR') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_ITENS_RTR ( ',
                '    ITR_CODITF     INTEGER NOT NULL , ',
                '    ITR_NR_ITEM    INTEGER NOT NULL , ',
                '    ITR_DESCRICAO  VARCHAR(100) , ',
                '    ITR_QTDE       NUMERIC(10,3) , ',
                '    ITR_VL_UNIT    NUMERIC(10,6) , ',
                '    ITR_OBS        VARCHAR(255) , ',
                '    ITR_CODGRC     INTEGER, ',
                '    ITR_CODSBG     INTEGER , ',
                '    ITR_CORTESIA   VARCHAR(1));'

            ));
    RunScript( concat('CREATE INDEX TB_ITENS_RTR_IDX1 ON TB_ITENS_RTR (ITR_CODITF, ITR_NR_ITEM);'));
  End;

end;

procedure TNED.execAlteracaoTB_KIND_LUCRATIVIDADE;
begin
  if not existTabeLA('TB_KIND_LUCRATIVIDADE') then
  Begin
    RunScript( concat(
                  'CREATE TABLE TB_KIND_LUCRATIVIDADE( ',
                  '  ID integer not null primary key, ',
                  '  DESCRIPTION VARCHAR(100) CHARACTER SET WIN1252 COLLATE WIN_PTBR); '
            ));
  End;
end;

procedure TNED.execAlteracaoTB_LOJA_TRAY;
begin
  if not existTabeLA('TB_LOJA_TRAY') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_LOJA_TRAY ( ',
                '    TABELA  VARCHAR(50) NOT NULL, ',
                '    ID      INTEGER NOT NULL, ',
                '    WEB_ID  INTEGER); '
            ));
    RunScript( concat('ALTER TABLE TB_LOJA_TRAY ADD CONSTRAINT PK_TB_LOJA_TRAY PRIMARY KEY (TABELA, ID);'));
  End;

end;

procedure TNED.execAlteracaoTB_LOJA_TRAY_ORDER;
begin
  if not existTabeLA('TB_LOJA_TRAY_ORDER') then
  Begin
    RunScript( concat(
                  'CREATE TABLE TB_LOJA_TRAY_ORDER ( ',
                  '    ID              INTEGER NOT NULL, ',
                  '    STATUS          VARCHAR(50), ',
                  '    DT_RECORD       DATE, ',
                  '    CUSTOMER_ID     INTEGER, ',
                  '    PARTIAL_TOTAL   NUMERIC(10,2), ',
                  '    TAXES           NUMERIC(10,2), ',
                  '    DISCOUNT        NUMERIC(10,2), ',
                  '    SHIPMENT        VARCHAR(50), ',
                  '    SHIPMENT_VALUE  NUMERIC(10,2), ',
                  '    DT_SHIPMENT     DATE, ',
                  '    PAYMENT_FORM    VARCHAR(50), ',
                  '    TOTAL_VALUE     NUMERIC(10,2), ',
                  '    DT_PAYMENT      DATE, ',
                  '    MODIFIED        TIMESTAMP); '
            ));
  End;
end;

procedure TNED.execAlteracaoTB_LUCRATIVIDADE;
begin
  if not existTabeLA('TB_LUCRATIVIDADE') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_LUCRATIVIDADE( ',
                '  TB_ITENSNLF_ID integer NOT NULL, ',
                '  TB_PEDIDO_ID   integer NOT NULL, ',
                '  TB_KIND_LUCRATIVIDADE_ID integer NOT NULL, ',
                '  OPERATION VARCHAR(10) CHARACTER SET WIN1252 COLLATE WIN_PTBR, ',
                '  CURRENT_VALUE NUMERIC(10,2) ); '
            ));
    RunScript('ALTER TABLE TB_LUCRATIVIDADE ADD CONSTRAINT PK_TB_LUCRATIVIDADE PRIMARY KEY (TB_ITENSNLF_ID, TB_PEDIDO_ID, TB_KIND_LUCRATIVIDADE_ID);');
  End;
end;

procedure TNED.execAlteracaoTB_MEDIDAMED_SEQUENCIA;
begin
  if not existField('TB_MEDIDA','MED_SEQUENCIA') then
  Begin
    RunScript('ALTER TABLE TB_MEDIDA ADD MED_SEQUENCIA  INTEGER;');
  End;

end;

procedure TNED.execAlteracaoTB_CTRL_ESTOQUE_ZERADO;
begin
  if not existTabela('TB_CTRL_ESTOQUE_ZERADO') then
  Begin
    RunScript(concat(
                'CREATE TABLE TB_CTRL_ESTOQUE_ZERADO ( ',
                '    ID             "Codigo", ',
                '    DT_RECORD      "DataeHora", ',
                '    TB_ESTOQUE_ID  "Codigo", ',
                '    TB_PRODUCT_ID  "Codigo", ',
                '    BALANCE_FOUND  "Numeric103"); '
    ));
    RunScript('ALTER TABLE TB_CTRL_ESTOQUE_ZERADO ADD CONSTRAINT PK_TB_CTRL_ESTOQUE_ZERADO PRIMARY KEY (ID);');
    RunScript('ALTER TABLE TB_CTRL_ESTOQUE_ZERADO ADD CONSTRAINT FK_TB_CTRL_ESTOQUE_ZERADO_1 FOREIGN KEY (TB_PRODUCT_ID) REFERENCES TB_PRODUTO (PRO_CODIGO);');
    RunScript('ALTER TABLE TB_CTRL_ESTOQUE_ZERADO ADD CONSTRAINT FK_TB_CTRL_ESTOQUE_ZERADO_2 FOREIGN KEY (TB_ESTOQUE_ID) REFERENCES TB_ESTOQUE (EST_CODIGO);');
  End;
end;

procedure TNED.execAlteracaoTB_CTRL_LOTECLT_CODEST;
begin
  if not existField('TB_CTRL_LOTE','CLT_CODEST') then
  Begin
    RunScript( 'ALTER TABLE TB_CTRL_LOTE  ADD CLT_CODEST INTEGER;' );

    RunScript( concat('update  tb_ctrl_lote set ',
                      'CLT_CODEST =1 ',
                      'WHERE CLT_CODIGO IN ( ',
                      'select CL.clt_codigo ',
                      'FROM TB_CTRL_LOTE CL ',
                      ' INNER JOIN tb_movimento_lote ml  ON (cl.clt_codigo = ml.mlt_codclt) ',
                      'WHERE  cl.clt_estoque = ''S'' AND ML.mlt_sentido = ''E'' ) '
    ));
    RunScript( concat('update  tb_ctrl_lote set ',
                      'CLT_CODEST = 0 ',
                      'WHERE CLT_CODEST is null '
    ));
  End;
end;

procedure TNED.execAlteracaoTB_NFE_EVENTONVT_AUTOR;
begin
  if not existField('TB_NFE_EVENTO','NVT_AUTOR') then
  Begin
    RunScript('ALTER TABLE TB_NFE_EVENTO ADD NVT_AUTOR "Descricao_50";');
  End;
end;

procedure TNED.execAlteracaoTB_NFE_ITENS_FUEL;
begin
  if not existTabela('TB_NFE_ITENS_FUEL') then
  Begin
    RunScript( concat('CREATE TABLE TB_NFE_ITENS_FUEL ( ',
                    'TB_ORDER_ITEMS_ID  INTEGER NOT NULL, ',
                    'CODIF              VARCHAR(30), ',
                    'QTEMP              NUMERIC(10,4), ',
                    'UFCONS             VARCHAR(2), ',
                    'DESCRIPTION        VARCHAR(50) );'
    ));
    RunScript('ALTER TABLE TB_NFE_ITENS_FUEL ADD CONSTRAINT PK_TB_NFE_ITENS_FUEL PRIMARY KEY (TB_ORDER_ITEMS_ID);');
  End;
end;

procedure TNED.execalteracaoTB_NFS_ELETRONICANFS_LAYOUT;
begin
  if not existField('TB_NFS_ELETRONICA','NFS_LAYOUT') then
  Begin
    RunScript('ALTER TABLE tb_nfs_eletronica ADD NFS_LAYOUT VARCHAR(20);');
  End;
end;

procedure TNED.execalteracaoTB_NFS_ELETRONICANFS_VERSAO;
begin
  if not existField('TB_NFS_ELETRONICA','NFS_VERSAO') then
  Begin
    RunScript('ALTER TABLE tb_nfs_eletronica ADD NFS_VERSAO VARCHAR(20);');
  End;
end;

procedure TNED.execAlteracaoTB_NOTIFICATION;
begin
  if not existTabeLA('TB_NOTIFICATION') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_NOTIFICATION( ',
                '    TB_INSTITUTION_ID "Codigo", ',
                '    ID "Codigo", ',
                '    CATEGORY "Descricao_25", ',
                '    COLOR "Descricao_20", ',
                '    NOTE "Observacao", ',
                '    ACTIVE "Descricao_1", ',
                '    CREATED_AT "DataeHora", ',
                '    UPDATED_AT "DataeHora") '
            ));
    RunScript('ALTER TABLE TB_NOTIFICATION ADD CONSTRAINT PK_TB_NOTIFICATION PRIMARY KEY (TB_INSTITUTION_ID, ID);');
    RunScript('CREATE SEQUENCE GN_NOTIFICATION;');
  End;
end;

procedure TNED.execalteracaoTB_OWN_FLEET_OS;
begin
  if not existTable('TB_OWN_FLEET_OS') then
  Begin
    RunScript( concat(
              'CREATE TABLE TB_OWN_FLEET_OS ( ',
              '    TB_INSTITUTION_ID  "Codigo", ',
              '    ID       "Codigo", ',
              '    TB_VEHICLE_ID      "Descricao_7" NOT NULL, ',
              '    DT_RECORD "Data", ',
              '    KM "Descricao_15", ',
              '    OBS               "Observacao" );'
    ));
    RunScript('ALTER TABLE TB_OWN_FLEET_OS ADD CONSTRAINT PK_TB_OWN_FLEET_OS PRIMARY KEY (TB_INSTITUTION_ID, ID);');
  End;

end;

procedure TNED.execAlteracaoTB_PAF_CTRL;
begin
  if not existTabeLA('TB_PAF_CTRL') then
  Begin
    RunScript( concat(
                  'CREATE TABLE TB_PAF_CTRL( ',
                  '  DT_RECORD DATE not null primary key, ',
                  '  TS_OPENING timestamp, ',
                  '  USER_ID_OPENING integer, ',
                  '  STATUS CHAR(1), ',
                  '  HAS_STATEMENT CHAR(1), ',
                  '  USER_ID_CLOSURE integer, ',
                  '  TS_CLOSURE timestamp); '
            ));
  End;

end;

procedure TNED.execAlteracaoTB_PAF_REG_A2;
begin
  if not existTabeLA('TB_PAF_REG_A2') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_PAF_REG_A2( ',
                '  DT_RECORD   DATE NOT NULL, ',
                '  PAYMENT_DESC     VARCHAR(51) CHARACTER SET WIN1252 NOT NULL COLLATE WIN_PTBR, ',
                '  ID_KIND_DOC  CHAR(1) NOT NULL, ',
                '  TOTAL_VALUE NUMERIC(10,2), ',
                '  CUSTOMER_DOC VARCHAR(14), ',
                '  DOC_NUMBER VARCHAR(10)); '
            ));
    RunScript('ALTER TABLE TB_PAF_REG_A2 ADD CONSTRAINT PK_TB_PAF_REG_A2 PRIMARY KEY (DT_RECORD, PAYMENT_DESC, ID_KIND_DOC);');
  End;

end;

procedure TNED.execAlteracaoTB_PAF_REG_E2;
begin
  if not existTabeLA('TB_PAF_REG_E2') then
  Begin
    RunScript( concat(
                  'CREATE TABLE TB_PAF_REG_E2 ( ',
                  '    TB_PRODUCT_ID     INTEGER NOT NULL, ',
                  '    TB_STOCK_LIST_ID  INTEGER NOT NULL, ',
                  '    DT_RECORD         DATE NOT NULL, ',
                  '    QUANTITY          NUMERIC(10,3)); '
            ));
    RunScript('ALTER TABLE TB_PAF_REG_E2 ADD CONSTRAINT PK_TB_PAF_REG_E2 PRIMARY KEY (TB_PRODUCT_ID, TB_STOCK_LIST_ID, DT_RECORD);');
  End;
end;

procedure TNED.execalteracaoTB_PAYBACKDT_EXPIRE;
begin
  if not existField('TB_PAY_BACK','DT_EXPIRE') then
  Begin
    RunScript('ALTER TABLE TB_PAY_BACK ADD DT_EXPIRE "Data";');
  End;

end;

procedure TNED.execalteracaoTB_PAYBACKSTATUS;
begin
  if not existField('TB_PAY_BACK','STATUS') then
  Begin
    RunScript('ALTER TABLE TB_PAY_BACK ADD STATUS "Descricao_10";');
  End;

end;

procedure TNED.execAlteracaoTB_PAY_BACK;
begin
  if not existTabeLA('TB_PAY_BACK') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_PAY_BACK ( ',
        '    ID                 INTEGER NOT NULL, ',
        '    TB_INSTITUTION_ID  INTEGER NOT NULL, ',
        '    TERMINAL           INTEGER NOT NULL, ',
        '    TB_CUSTOMER_ID     INTEGER NOT NULL, ',
        '    DT_RECORD          DATE DEFAULT NULL, ',
        '    CREDIT_VALUE       NUMERIC(10,2), ',
        '    DEBIT_VALUE        NUMERIC(10,2), ',
        '    HISTORY            VARCHAR(100), ',
        '    TB_ORDER_ID        INTEGER, ',
        '    CREATED_AT         TIMESTAMP, ',
        '    UPDATED_AT         TIMESTAMP);'
    ));
    RunScript('ALTER TABLE TB_PAY_BACK ADD PRIMARY KEY (ID, TB_INSTITUTION_ID, TERMINAL);');
  End;

end;

procedure TNED.execalteracaoTB_PAY_BACKTB_CUSTOMER_ID;
begin
  if not existField('TB_PAY_BACK_EXPIRED','TB_CUSTOMER_ID') then
  Begin
    RunScript('ALTER TABLE TB_PAY_BACK_EXPIRED ADD TB_CUSTOMER_ID "Inteiro";');
  End;

end;

procedure TNED.execalteracaoTB_PAY_BACK_EXPIRED;
begin
  if not existTable('TB_PAY_BACK_EXPIRED') then
  Begin
    RunScript( concat(
        'CREATE TABLE TB_PAY_BACK_EXPIRED ( ',
        '    TB_INSTITUTION_ID  "Codigo", ',
        '    TB_PAY_BACK_ID      "Codigo", ',
        '    TERMINAL           "Codigo", ',
        '    DT_RECORD          "Data", ',
        '    VALUE_EXPIRED      "Numeric102", ',
        '    CREATED_AT         "DataeHora", ',
        '    UPDATED_AT          "DataeHora"); '
    ));
    RunScript('ALTER TABLE TB_PAY_BACK_EXPIRED ADD CONSTRAINT PK_TB_PAY_BACK_EXPIRED PRIMARY KEY (TB_INSTITUTION_ID, TB_PAY_BACK_ID, TERMINAL);');
  End;

end;

procedure TNED.execAlteracaoTB_PAY_TYPE_HAS_INTERM;
begin
  if not existTabela('TB_PAY_TYPE_HAS_INTERM') then
  Begin
    RunScript(concat(
                'create TABLE TB_PAY_TYPE_HAS_INTERM( ',
                '    TB_PAYMENT_TYPE_ID integer NOT NULL, ',
                '    FISCAL_DOC VARCHAR(20), ',
                '    USER_IDENTIFIER VARCHAR(50)); '
    ));
    RunScript(concat(
                'alter table TB_PAY_TYPE_HAS_INTERM ',
                'add constraint FK_TB_PAY_TYPE_HAS_INTERM_1 ',
                'foreign key (TB_PAYMENT_TYPE_ID) ',
                'references TB_FORMAPAGTO(FPT_CODIGO); '
    ));
  End;

end;

procedure TNED.execAlteracaoTB_PEDIDOPED_HORA;
begin
  if not existField('TB_PEDIDO','PED_HORA') then
  Begin
    RunScript( 'ALTER TABLE TB_PEDIDO ADD PED_HORA TIME;' );
  End;
end;

procedure TNED.execAlteracaoTB_PEDIDOPED_TERMINAL;
begin
  if not existField('TB_PEDIDO','PED_TERMINAL') then
  Begin
    RunScript('ALTER TABLE TB_PEDIDO ADD PED_TERMINAL INTEGER DEFAULT 0 NOT NULL;');
    RunScript('UPDATE TB_PEDIDO SET PED_TERMINAL = 0;');
  End
  else
  Begin
    RunScript('UPDATE TB_PEDIDO SET PED_TERMINAL = 0;');
    RunScript(concat(
              'update RDB$RELATION_FIELDS set ',
              'RDB$NULL_FLAG = 1 ',
              'where (RDB$FIELD_NAME = ''PED_TERMINAL'') and ',
              '(RDB$RELATION_NAME = ''TB_PEDIDO'') '
    ));
  End;


end;

procedure TNED.execalteracaoTB_PEDIDO_FROM_EXTERIOR;
begin
  if not existTable('TB_PEDIDO_FROM_EXTERIOR') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_PEDIDO_FROM_EXTERIOR ( '+
                '    KIND           "Descricao_50" NOT NULL, '+
                '    ID_EXTERIOR    "Descricao_50" NOT NULL, '+
                '    TB_PEDIDO_ID  "Codigo");'
    ));
    RunScript('ALTER TABLE TB_PEDIDO_FROM_EXTERIOR ADD CONSTRAINT PK_TB_PED_FROM_EXTR PRIMARY KEY (KIND, ID_EXTERIOR);');
  End;

end;

procedure TNED.execalteracaoTB_PRE_PAID_CARD;
begin
  if not existTable('TB_PRE_PAID_CARD') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_PRE_PAID_CARD ( ',
                '    ID                 INTEGER NOT NULL, ',
                '    TB_INSTITUTION_ID  INTEGER NOT NULL, ',
                '    TERMINAL           INTEGER NOT NULL, ',
                '    NUMBER             INTEGER NOT NULL, ',
                '    DT_RECORD          DATE DEFAULT NULL, ',
                '    CREDIT_VALUE       NUMERIC(10,2), ',
                '    DEBIT_VALUE        NUMERIC(10,2), ',
                '    HISTORY            VARCHAR(100), ',
                '    TB_ORDER_ID        INTEGER, ',
                '    CREATED_AT         TIMESTAMP, ',
                '    UPDATED_AT         TIMESTAMP ); '

    ));
    RunScript('ALTER TABLE TB_PRE_PAID_CARD ADD PRIMARY KEY (ID, TB_INSTITUTION_ID, TERMINAL);');
  End;

end;

procedure TNED.execalteracaoTB_PRINT_SHOP_OS;
begin
  if not existTable('TB_PRINT_SHOP_OS') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_PRINT_SHOP_OS ( ',
                '    ID                  INTEGER NOT NULL, ',
                '    TB_INSTITUTION_ID   INTEGER NOT NULL, ',
                '    TB_ORDER_ID         INTEGER NOT NULL, ',
                '    NUMBER              "Descricao_25", ',
                '    MATERIAL            "Descricao_50", ',
                '    MANUFACTURER        "Descricao_50", ',
                '    KNIFE               "Descricao_50", ',
                '    MATERIAL_SUPPLIED   "Descricao_50", ',
                '    MATERIAL_USED       "Descricao_50", ',
                '    EQUIPMENT           "Descricao_100", ',
                '    SERVICES            "Observacao", ',
                '    OUTSOURCED_SERVICE  "Observacao", ',
                '    FINISHING           "Observacao", ',
                '    NOTE                "Observacao", ',
                '    TB_SITUATION_ID     INTEGER, ',
                '    TB_COLLABORATOR_ID  INTEGER, ',
                '    DT_FORECAST         DATE, ',
                '    HR_FORECAST         TIME, ',
                '    DT_FINAL            DATE, ',
                '    HR_FINAL            TIME, ',
                '    DT_DELIVERY         DATE, ',
                '    HR_DELIVERY         TIME); '

    ));
    RunScript('ALTER TABLE TB_PRINT_SHOP_OS ADD CONSTRAINT PK_TB_PRINT_SHOP_OS PRIMARY KEY (ID, TB_INSTITUTION_ID);');
    RunScript('ALTER TABLE TB_PRINT_SHOP_OS ADD CONSTRAINT FK_TB_PRINT_SHOP_OS_1 FOREIGN KEY (TB_ORDER_ID) REFERENCES TB_PEDIDO (PED_CODIGO);');
    RunScript('ALTER TABLE TB_PRINT_SHOP_OS ADD CONSTRAINT FK_TB_PRINT_SHOP_OS_2 FOREIGN KEY (TB_SITUATION_ID) REFERENCES TB_SITUACAO (SIT_CODIGO);');
    RunScript('ALTER TABLE TB_PRINT_SHOP_OS ADD CONSTRAINT FK_TB_PRINT_SHOP_OS_3 FOREIGN KEY (TB_COLLABORATOR_ID) REFERENCES TB_COLABORADOR (CLB_CODIGO);');
  End;

end;

procedure TNED.execAlteracaoTB_PRODUCT_VARIANT;
Var
  LcAux : String;
begin
  if not existTabela('TB_PRODUCT_VARIANT') then
  Begin
    LcAux := concat(
                'CREATE TABLE TB_PRODUCT_VARIANT ( ',
                'ID             INTEGER NOT NULL, ',
                'TB_PRODUCT_ID  INTEGER NOT NULL, ',
                'QUANTITY       NUMERIC(10,6), ',
                'AVAILABLE      CHAR(1)); '
    );
    RunScript(LcAux);
    LcAux := 'ALTER TABLE TB_PRODUCT_VARIANT ADD CONSTRAINT PK_TB_PRODUCT_VARIANT PRIMARY KEY (ID);';
    RunScript(LcAux);

    LcAux := 'ALTER TABLE TB_PRODUCT_VARIANT ADD CONSTRAINT FK_TB_PRODUCT_VARIANT_1 FOREIGN KEY (TB_PRODUCT_ID) REFERENCES TB_PRODUTO (PRO_CODIGO);';
    RunScript(LcAux);

  End;

end;

procedure TNED.execAlteracaoTB_PRODUCT_VARIANT_SKU;
Var
  LcAux : String;
begin
  if not existTabela('TB_PRODUCT_VARIANT_SKU') then
  Begin
    LcAux := concat(
                'CREATE TABLE TB_PRODUCT_VARIANT_SKU ( ',
                '    ID                     INTEGER NOT NULL, ',
                '    TB_PRODUCT_VARIANT_ID  INTEGER NOT NULL, ',
                '    TAMANHO                VARCHAR(10), ',
                '    COR                    VARCHAR(10), ',
                '    QUANTITY               NUMERIC(10,6), ',
                '    PRICE_TAG              NUMERIC(14,6)); '
    );
    RunScript(LcAux);
    LcAux := 'ALTER TABLE TB_PRODUCT_VARIANT_SKU ADD CONSTRAINT PK_TB_PRODUCT_VARIANT_SKU PRIMARY KEY (ID, TB_PRODUCT_VARIANT_ID);';
    RunScript(LcAux);

    LcAux := 'ALTER TABLE TB_PRODUCT_VARIANT_SKU ADD CONSTRAINT FK_TB_PRODUCT_VARIANT_SKU_1 FOREIGN KEY (TB_PRODUCT_VARIANT_ID) REFERENCES TB_PRODUCT_VARIANT (ID);';
    RunScript(LcAux);
  End;
end;

procedure TNED.execAlteracaoTB_PRODUTOPRO_DT_VENCIMENTO;
begin
  if not existField('TB_PRODUTO','PRO_DT_VENCIMENTO') then
  Begin
    RunScript('ALTER TABLE TB_PRODUTO ADD PRO_DT_VENCIMENTO   DATE;');
  End;

end;

procedure TNED.execAlteracaoTB_PRODUTOPRO_IAT;
begin
  if not existField('TB_PRODUTO','PRO_IAT') then
  Begin
    RunScript( 'ALTER TABLE TB_PRODUTO ADD PRO_IAT CHAR(1);' );
    RunScript( 'UPDATE TB_PRODUTO SET PRO_IAT = ''A'';'  );
  End;
end;

procedure TNED.execalteracaoTB_PRODUTOPRO_QTDE_MIN_AUTO_REPO;
begin
  if not existField('TB_PRODUTO','PRO_QTDE_MIN_AUTO_REPO') then
  Begin
    RunScript('ALTER TABLE TB_PRODUTO ADD PRO_QTDE_MIN_AUTO_REPO "Numeric146";');
  End;

end;

procedure TNED.execAlteracaoTB_PRODUTOPRO_SEND_WEB;
begin
  if not existField('TB_PRODUTO','PRO_SEND_WEB') then
  Begin
    RunScript(' ALTER TABLE TB_PRODUTO ADD PRO_SEND_WEB CHAR(1);');
    RunScript(' UPDATE TB_PRODUTO SET PRO_SEND_WEB = PRO_INTERNET WHERE PRO_SEND_WEB IS NULL;');
  End;

end;

procedure TNED.execAlteracaoTB_PRODUTOPRO_VL_CUSTO_LAST;
begin
  if not existField('TB_PRODUTO','PRO_VL_CUSTO_LAST') then
  Begin
    RunScript( 'ALTER TABLE TB_PRODUTO ADD PRO_VL_CUSTO_LAST NUMERIC(10,6);' );
  End;
end;

procedure TNED.execAlteracaoTB_PROMOCAODT_EXPIRATION;
begin
  if not existField('TB_PROMOTION','DT_EXPIRATION') then
  Begin
    RunScript('ALTER TABLE TB_PROMOTION ADD DT_EXPIRATION DATE;');
  End;

end;

procedure TNED.execAlteracaoTB_RETAGUARDA;
begin
  if not existTabeLA('TB_RETAGUARDA') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_RETAGUARDA( ',
                '    ID INTEGER NOT null primary KEY, ',
                '    ATIVO CHAR(1), ',
                '    PATH_BD VARCHAR(100), ',
                '    TERMINAL integer NOT NULL) '
            ));
  End;
end;

procedure TNED.execAlteracaoTB_RETAGUARDA_SYNC;
begin
  if not existTabeLA('TB_RETAGUARDA_SYNC') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_RETAGUARDA_SYNC( ',
                '    ID         "Descricao_100" NOT NULL, ',
                '    DT_UPDATE  "Data", ',
                '    TM_UPDATE  "Hora", ',
                '    WAY        CHAR(1) NOT NULL) '
            ));
    RunScript('ALTER TABLE TB_RETAGUARDA_SYNC ADD CONSTRAINT PK_TB_RETAGUARDA_SYNC PRIMARY KEY (ID, WAY);');
  End;

end;

procedure TNED.execAlteracaoTB_RETAGUARDA_SYNC_SYN_TIME;
begin
  if NOT existField('TB_RETAGUARDA_SYNC','SYN_TIME') then
  Begin
    RunScript('alter table tb_retaguarda_sync add SYN_TIME TIMESTAMP;');
  End;

end;

procedure TNED.execalteracaoTB_RETAGUARDA_WEB;
begin
  if not existTabeLA('TB_RETAGUARDA_WEB') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_RETAGUARDA_WEB ( ',
                '    ID        INTEGER NOT NULL, ',
                '    ATIVO     CHAR(1), ',
                '    SERVER_DB    VARCHAR(100), ',
                '    PORTA_DB     VARCHAR(10), ',
                '    PATH_DB   VARCHAR(100), ',
                '    USER_NAME VARCHAR(100), ',
                '    USER_PHRASE VARCHAR(100), ',
                '    TERMINAL  INTEGER NOT NULL); '
            ));
    RunScript('ALTER TABLE TB_RETAGUARDA_WEB ADD PRIMARY KEY (ID);');
  End;

end;

procedure TNED.execalteracaoTB_RETAGUARDA_WEB_SYNC;
begin
  if not existTabeLA('TB_RETAGUARDA_WEB') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_RETAGUARDA_WEB_SYNC ( ',
                '    ID        "Descricao_100" NOT NULL, ',
                '    WAY       "Descricao_1" NOT NULL, ',
                '    SYN_TIME  TIMESTAMP); '
            ));
    RunScript('ALTER TABLE TB_RETAGUARDA_WEB_SYNC ADD CONSTRAINT PK_TB_RETAGUARDA_SYNC PRIMARY KEY (ID, WAY);');
  End;

end;

procedure TNED.execAlteracaoTB_SCHEDULE;
begin
  if not existTabeLA('TB_SCHEDULE') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_SCHEDULE ( ',
                '  ID                 INTEGER NOT NULL, ',
                '  TB_INSTITUTION_ID  INTEGER NOT NULL, ',
                '  DT_RECORD          DATE, ',
                '  TM_RECORD          TIME, ',
                '  DURATION           CHAR(8), ',
                '  KIND               CHAR(1), ',
                '  CLERK_ID           INTEGER NOT NULL, ',
                '  TB_PHONE_ID        INTEGER NOT NULL, ',
                '  SERVED             VARCHAR(100), ',
                '  TB_USER_ID         INTEGER NOT NULL, ',
                '  NOTE               BLOB SUB_TYPE 0 SEGMENT SIZE 80, ',
                '  TB_SITUATION_ID    INTEGER); '
            ));
  End;
end;

procedure TNED.execAlteracaoTB_SEND_WHATSAPP;
begin
  if not existTabeLA('TB_SEND_WHATSAPP') then
  Begin
    RunScript( concat(
          'CREATE TABLE TB_SEND_WHATSAPP ( ',
          '    TB_INSTITUTION_ID  "Codigo" , ',
          '    ID                 "Codigo", ',
          '    NOTE               "Observacao", ',
          '    NUMBER_SEND        "Descricao_20", ',
          '    PATH_FILE          "Descricao_500", ',
          '    HR_SENT            "DataeHora", ',
          '    STATUS             "Descricao_50"); '
            ));
    RunScript('ALTER TABLE TB_SEND_WHATSAPP ADD CONSTRAINT PK_TB_SEND_WHATSAPP PRIMARY KEY (TB_INSTITUTION_ID, ID);');
    RunScript('CREATE SEQUENCE GN_SEND_WHATSAPP;');
  End;

end;

procedure TNED.execAlteracaoTB_SINCRONIA;
begin
  if not existTabeLA('TB_SINCRONIA') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_SINCRONIA ( ',
                '    SRC_CODIGO    INTEGER NOT NULL, ',
                '    SRC_TABELA    VARCHAR(30), ',
                '    SRC_CHAVE     VARCHAR(30), ',
                '    SRC_OPER      CHAR(1), ',
                '    SRC_TIME      TIMESTAMP, ',
                '    SRC_REGISTRO  INTEGER); '
    ));
    RunScript( concat('ALTER TABLE TB_SINCRONIA ADD CONSTRAINT PK_TB_SINCRONIA PRIMARY KEY (SRC_CODIGO);'));
  End;

end;

procedure TNED.execAlteracaoTB_SINCRONIAADDSRC_LOG;
begin
  if not existField('TB_SINCRONIA','SRC_LOG') then
  Begin
    RunScript('ALTER TABLE TB_SINCRONIA ADD SRC_LOG VARCHAR(255);');
  End;

end;

procedure TNED.execAlteracaotb_tabela_precoTPR_MAR_VIA_ESCALA;
begin
  if not existField('TB_TABELA_PRECO','TPR_MAR_VIA_ESCALA') then
  Begin
    RunScript('ALTER TABLE tb_tabela_preco ADD TPR_MAR_VIA_ESCALA NUMERIC(10,2);');
  End;

end;

procedure TNED.execalteracaoTB_TEF_MOVIMENTO;
begin
  if not existTabeLA('TB_TEF_MOVIMENTO') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_TEF_MOVIMENTO ( ',
                '    TB_PEDIDO_ID       INTEGER NOT NULL, ',
                '    TB_INSTITUTION_ID  INTEGER NOT NULL, ',
                '    PARCELA            INTEGER NOT NULL, ',
                '    CRT_ID             INTEGER, ',
                '    DOC_VINC           VARCHAR(50), ',
                '    VALOR_TOTAL        DECIMAL(10,2), ',
                '    REDE               VARCHAR(50), ',
                '    NSU                VARCHAR(50), ',
                '    DATAHORA           TIMESTAMP, ',
                '    INSTITUICAO        INTEGER, ',
                '    CAMPO11            VARCHAR(100), ',
                '    STATUS             CHAR(1), ',
                '    TB_USER_ID         INTEGER, ',
                '    UPDATE_AT          TIMESTAMP); '
            ));
    RunScript('CREATE INDEX TB_TEF_MOVIMENTO_IDX1 ON TB_TEF_MOVIMENTO (TB_PEDIDO_ID);');
    RunScript('CREATE INDEX TB_TEF_MOVIMENTO_IDX2 ON TB_TEF_MOVIMENTO (TB_INSTITUTION_ID);');
    RunScript('CREATE INDEX TB_TEF_MOVIMENTO_IDX3 ON TB_TEF_MOVIMENTO (TB_USER_ID);');
    RunScript('CREATE INDEX TB_TEF_MOVIMENTO_IDX4 ON TB_TEF_MOVIMENTO (CRT_ID);');
  End;

end;

procedure TNED.execAlteracaoTB_TERMINAL;
begin
  if not existTabela('TB_TERMINAL') then
  Begin
    RunScript(concat(
                'CREATE TABLE TB_TERMINAL ( ',
                '    ID             INTEGER NOT NULL, ',
                '    DESCRIPTION    VARCHAR(35), ',
                '    PATH_SERVER    VARCHAR(100), ',
                '    PATH_DATABASE  VARCHAR(100)); '
    ));
    RunScript('ALTER TABLE TB_TERMINAL ADD CONSTRAINT PK_TB_TERMINAL PRIMARY KEY (ID);');
  End;

end;

procedure TNED.execAlteracaoTB_TRIBUTACAOTB_TAXES_ID;
begin
  if not existField('TB_TRIBUTACAO','TB_TAXES_ID') then
  Begin
    RunScript( 'alter TABLE tb_tributacao ADD TB_TAXES_ID "Inteiro";' );
  End;

end;

procedure TNED.execalteracaoTB_TributacaoTRB_AQ_DIF;
begin
  if not existField('TB_TRIBUTACAO','TRB_AQ_DIF') then
  Begin
    RunScript( 'alter TABLE tb_tributacao ADD TRB_AQ_DIF "Numeric102";' );
  End;
end;

procedure TNED.execAlteracaoTB_TRIBUTACAOTRB_CODEMP;
begin
  if not existField('TB_TRIBUTACAO','TRB_CODEMP') then
  Begin
    RunScript( 'ALTER TABLE TB_TRIBUTACAO ADD TRB_CODEMP INTEGER;' );
    RunScript( 'UPDATE TB_TRIBUTACAO SET TRB_CODEMP = 0;' );
  End;

end;

procedure TNED.execAlteracaoTB_USUARIOUSU_NIVEL;
begin
  if existField('TB_USUARIO','USU_NIVEL') then
  Begin
    RunScript( 'ALTER TABLE TB_USUARIO ALTER USU_NIVEL TO USU_LEVEL;' );
  end;
end;


procedure TNED.execalteracaoTB_USUARIO_USU_AUTH_CARD;
begin
  if not existField('TB_USUARIO','USU_AUTH_CARD') then
  Begin
    RunScript('ALTER TABLE TB_USUARIO ADD USU_AUTH_CARD "Descricao_1";');
  End;

end;

procedure TNED.execalteracaoTB_USUARIO_USU_NOTIFICA;
begin
  if not existField('TB_USUARIO','USU_NOTIFICA') then
  Begin
    RunScript('ALTER TABLE TB_USUARIO ADD USU_NOTIFICA "Descricao_1";');
  End;

end;

procedure TNED.execalteracaoTB_WHATSAPP_CFG;
begin
  if not existTable('TB_WHATSAPP_CFG') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_WHATSAPP_CFG ( ',
                '    ID INTEGER NOT NULL, ',
                '    TB_INSTITUTION_ID INTEGER NOT NULL, ',
                '    DESCRIPTION VARCHAR(100), ',
                '    URL_SEND VARCHAR(255), ',
                '    TOKEN VARCHAR(255), ',
                '    TOKEN_AUTH VARCHAR(255)) '
    ));
    RunScript('ALTER TABLE TB_WHATSAPP_CFG ADD CONSTRAINT PK_TB_WHATSAPP_CFG PRIMARY KEY (ID, TB_INSTITUTION_ID);');
  End;
end;

procedure TNED.execAlteracaoTB_CLIENTECLI_CODTPR;
begin
  if not existField('TB_CLIENTE','CLI_CODTPR') then
  Begin
    RunScript('ALTER TABLE TB_CLIENTE ADD CLI_CODTPR INTEGER;');
  End;

end;

procedure TNED.execalteracaoTB_CLIENTE_FROM_EXTERIOR;
begin
  if not existTable('TB_CLIENTE_FROM_EXTERIOR') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_CLIENTE_FROM_EXTERIOR ( ',
                '    KIND           "Descricao_50" NOT NULL , ',
                '    ID_EXTERIOR    "Descricao_50" NOT NULL , ',
                '    TB_CLIENTE_ID  "Codigo" );'
    ));
    RunScript('ALTER TABLE TB_CLIENTE_FROM_EXTERIOR ADD CONSTRAINT PK_TB_CLI_FROM_EXTR PRIMARY KEY (KIND, ID_EXTERIOR);');
  End;

end;

procedure TNED.execAlteracaoTB_COLABORADOR_PRIMARYKEY;
begin
  if NOT ExisteChavePrimaria('TB_COLABORADOR') then
  Begin
    RunScript( concat(
                'alter table TB_COLABORADOR ',
                'add constraint PK_TB_COLABORADOR ',
                'primary key (CLB_CODIGO)'
    ));
  End;
end;

procedure TNED.execAlteracaoTB_COMMAND;
begin
  if not existTable('TB_COMMAND') then
  Begin
    RunScript( concat(
                'CREATE TABLE TB_COMMAND ( ',
                '    TB_INSTITUTION_ID  INTEGER NOT NULL, ',
                '    TB_ORDER_ID        INTEGER NOT NULL, ',
                '    DT_RECORD          TIMESTAMP, ',
                '    CONTROL_ID         VARCHAR(15), ',
                '    CONTROL_NAME       VARCHAR(50), ',
                '    CONTROL_PHONE      VARCHAR(150), ',
                '    GROUPED            INTEGER); '
    ));

    RunScript( 'ALTER TABLE TB_COMMAND ADD CONSTRAINT PK_TB_COMMAND PRIMARY KEY (TB_INSTITUTION_ID, TB_ORDER_ID);');
    RunScript( 'CREATE INDEX TB_COMMAND_IDX1 ON TB_COMMAND (CONTROL_ID);');
    RunScript( 'CREATE INDEX TB_COMMAND_IDX2 ON TB_COMMAND (DT_RECORD);');
    RunScript( 'CREATE INDEX TB_COMMAND_IDX3 ON TB_COMMAND (CONTROL_ID);');
    RunScript( 'CREATE INDEX TB_COMMAND_IDX4 ON TB_COMMAND (CONTROL_NAME);');
    RunScript( 'CREATE INDEX TB_COMMAND_IDX5 ON TB_COMMAND (CONTROL_PHONE);');
  End;
end;

procedure TNED.execAlteracaoTG_SINCRONIA;
begin
  if not existTriguer('TG_SINCRONIA') then
  Begin
    RunScript( concat(
                'CREATE OR ALTER TRIGGER TG_SINCRONIA FOR TB_SINCRONIA ',
                'ACTIVE BEFORE INSERT POSITION 0 ',
                'AS BEGIN NEW.SRC_CODIGO = GEN_ID(GN_SINCRONIA, 1); END '
    ));
  End;
end;

procedure TNED.execAlteracaoUpdatePED_HORA;
begin
  RunScript( concat(
              'update tb_pedido p set ',
              'p.ped_hora = cast(p.ped_dt_altera as Time) ',
              'where p.ped_hora is null '
  ) );
end;

procedure TNED.execDropTrigguerTG_RETORNO_NFC;
begin
  if existTriguer('TG_RETORNO_NFC') then
  Begin
    RunScript( 'DROP TRIGGER TG_RETORNO_NFC;');
  End;
end;

procedure TNED.ExecSqlScriptFromFile(FileName :String);
var
  Script: TSTScript;
  Src: string;
  Lc_PathFile : String;
begin
  Lc_PathFile := concat(GbPathExe, FileName);
  if FileExists(Lc_PathFile) then
  Begin
    try
      Src := TFile.ReadAllText(Lc_PathFile); // fallback (ANSI/Windows-1252)
    except
      Src := TFile.ReadAllText(Lc_PathFile, TEncoding.UTF8);
    end;

    Script := base.GeraScript;
    try
      // Deixe o próprio script controlar transações (se o arquivo tiver COMMIT)
      Script.Script.Append(Src);
      Script.ExecuteAll;
    finally
      base.FinalizaISQL(Script);
      DeleteFile(Lc_PathFile);
    end;
  end;
end;

procedure TNED.ExecVAloresFloatNulos;
begin
  RunScript( 'update tb_produto set pro_vl_customed = 0 where pro_vl_customed is null;' );
  RunScript( 'update tb_produto set pro_vl_custo = 0 where pro_vl_custo is null;' );
end;

function TNED.existDomain(Domain: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select RDB$FIELD_NAME ',
                'from RDB$FIELDS ',
                'where upper(RDB$FIELD_NAME) = :DOMAIN '
        ));
      ParamByName('DOMAIN').AsString := UpperCase(Domain);
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

function TNED.ExisteChavePrimaria(TableName: string): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
            'SELECT RDB$CONSTRAINT_NAME ',
            'FROM RDB$RELATION_CONSTRAINTS ',
            'WHERE RDB$RELATION_NAME = :TableName ',
            'AND RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'''
      ));
      ParamByName('TableName').AsString := UpperCase(TableName);
      active := true;
      Fetchall;
      Result := (RecordCount > 0);
    End;
  finally
    Base.FinalizaQuery(Lc_Qry);
  end;
end;

function TNED.ChavePrimariaContemCampo(TableName, Campo: string): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := False;
  if not existTable(TableName) then
    Exit;
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
            'SELECT 1 ',
            'FROM RDB$RELATION_CONSTRAINTS RC ',
            'INNER JOIN RDB$INDEX_SEGMENTS SEG ON SEG.RDB$INDEX_NAME = RC.RDB$INDEX_NAME ',
            'WHERE RC.RDB$RELATION_NAME = :TableName ',
            'AND RC.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ',
            'AND TRIM(SEG.RDB$FIELD_NAME) = :Campo '
      ));
      ParamByName('TableName').AsString := UpperCase(TableName);
      ParamByName('Campo').AsString := UpperCase(Campo);
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);
    End;
  finally
    Base.FinalizaQuery(Lc_Qry);
  end;
end;

procedure TNED.execAlteracaoPK_TB_IBSCBS_Link(const TableName: string);
const
  C_PK_FIELDS = 'LINK_ID, LINK_KIND, TB_IBSCBS_ID';
var
  LcPk: string;
begin
  if not existTable(TableName) then
    Exit;

  if ChavePrimariaContemCampo(TableName, 'TB_IBSCBS_ID') then
    Exit;

  LcPk := 'PK_' + TableName;

  if existTable('TB_CBS') then
    RunScript(concat(
        'UPDATE ', TableName, ' SET LINK_KIND = ''CBS'' ',
        'WHERE LINK_KIND = ''MUN'' ',
        'AND LINK_ID IN (SELECT ID FROM TB_CBS) '
    ));

  if not existField(TableName, 'TB_IBSCBS_ID') then
    RunScript('ALTER TABLE ' + TableName + ' ADD TB_IBSCBS_ID "Codigo";');

  if ExisteChavePrimaria(TableName) then
    RunScript('ALTER TABLE ' + TableName + ' DROP CONSTRAINT ' + LcPk + ';');

  RunScript('ALTER TABLE ' + TableName + ' ADD CONSTRAINT ' + LcPk +
            ' PRIMARY KEY (' + C_PK_FIELDS + ');');
end;

function TNED.existField(Tabela, campo: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'select 1 ',
                'from rdb$relation_fields ',
                'where RDB$RELATION_FIELDS.rdb$relation_name =:TABELA AND ',
                'RDB$RELATION_FIELDS.RDB$FIELD_NAME =:CAMPO '
        ));
      ParamByName('TABELA').AsString := Tabela;
      ParamByName('CAMPO').AsString := campo;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

function TNED.existGenerator(Gerador: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select rdb$generator_name from rdb$generatorS ',
                'where rdb$generator_name = :nomedogenerator '
      ));
      ParamByName('nomedogenerator').AsString := Gerador;
      Active := True;
      FetchAll;
      result := (recordCount > 0);

    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

function TNED.existTable(Tabela: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
              'select rdb$relation_name ',
              'from rdb$relations ',
              'where rdb$view_blr is null ',
              'and (rdb$system_flag is null or rdb$system_flag = 0) ',
              ' and (rdb$relation_name=:rdb$relation_name); '
      ));
      ParamByName('rdb$relation_name').AsString := Tabela;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;

end;

function TNED.existTriguer(Trigger: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT RDB$TRIGGER_NAME ',
                'FROM RDB$TRIGGERS ',
                'where RDB$TRIGGER_NAME =:Trigger '
        ));
      ParamByName('Trigger').AsString := Trigger;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

function TNED.geraSequenciaTB_CRP_ITENS: Boolean;
var
  Lc_Qry : TSTQuery;
  Lc_Upt: TSTQuery;
  Lc_aux :String;
  Lc_ItensId : Integer;
begin
  try
    Lc_Upt := Base.GeraQuery;
    with Lc_Upt do
    Begin
      SQL.Clear;
      SQL.Add('UPDATE TB_CRP_ITENS SET CPI_CODIGO =:CPI_CODIGO WHERE (CPI_SABOR = :CPI_SABOR) AND (CPI_CODPRO =:CPI_CODPRO);  ' );
    end;
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CPI_SABOR,CPI_CODPRO FROM  TB_CRP_ITENS  WHERE (CPI_CODIGO IS NULL) or (CPI_CODIGO = 0)  ' );
      active := True;
    end;
    Lc_ItensId := 0;
    Lc_Qry.First;
    while not Lc_Qry.eof do
    Begin
      Lc_Upt.close;
      Lc_ItensId := Lc_ItensId + 1;
      Lc_Upt.paramByName('CPI_CODIGO').AsInteger  := Lc_ItensId;
      Lc_Upt.paramByName('CPI_SABOR').AsString    := Lc_Qry.FieldByName('CPI_SABOR').AsString;
      Lc_Upt.paramByName('CPI_CODPRO').AsInteger  := Lc_Qry.FieldByName('CPI_CODPRO').AsInteger;
      if not Lc_Upt.Transaction.InTransaction then Lc_Upt.Transaction.StartTransaction;
      Lc_Upt.ExecSQL;
      if Lc_Upt.Transaction.InTransaction then Lc_Upt.Transaction.commit;
      Lc_Qry.Next;
    End;
    RunScript(concat('set generator GN_CRP_ITENS TO ',Lc_ItensId.ToString,';'));
  finally
    Base.FinalizaQuery(Lc_Qry);
    Base.FinalizaQuery(Lc_Upt);
  end;
end;


function TNED.getSizeFieldLenght(dominio,size: String): boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select RDB$FIELD_LENGTH ',
                'from RDB$FIELDS ',
                'where RDB$FIELD_NAME =:FIELD_NAME ',
                ' and RDB$FIELD_LENGTH =:FIELD_LENGTH '
        ));
      ParamByName('FIELD_NAME').AsString := dominio;
      ParamByName('FIELD_LENGTH').AsString := size;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;

end;

procedure TNED.RunScript(Script: String);
var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      try
        SQL.Clear;
        SQL.Add(Script);
        Prepare;
        ExecSQL;
        if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Commit;
      EXCEPT
        if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Rollback;
      END;
    end;
  finally
    Base.FinalizaQuery(Lc_Qry);
  end;
end;

{
procedure TNED.RunScriptFile(PathExe, FileName: String);
var
  Lc_Qry : TSTQuery;
  f:TextFile;
  linha:String;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      AssignFile(f,PathExe + FileName);
      Reset(f); //abre o arquivo para leitura;
      While not eof(f) do
      begin
        Readln(f,linha);
        try
          Lc_Qry.SQL.Add(linha);
          Lc_Qry.Prepare;
          Lc_Qry.ExecSQL;
          if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Commit;
        EXCEPT
          if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Rollback;
        END;
      end;
    End;
  finally
    Base.FinalizaQuery(Lc_Qry);
    Closefile(f);
  end;
end;
 }


function TNED.setVersion: Boolean;
begin

end;

procedure TNED.TB_NFS_ELETRONICANFS_CODIGONBS;
begin
  if not existField('TB_NFS_ELETRONICA','NFS_CODIGONBS') then
  Begin
    RunScript( 'alter TABLE TB_NFS_ELETRONICA ADD NFS_CODIGONBS "Descricao_20";' );
  End;
end;

procedure TNED.TB_NFS_ELETRONICANFS_FORMATODISCR;
begin
  if not existField('TB_NFS_ELETRONICA','NFS_FORMATODISCR') then
  Begin
    RunScript( 'alter TABLE TB_NFS_ELETRONICA ADD NFS_FORMATODISCR "Descricao_20";' );
  End;
end;

procedure TNED.Pesquisa_NCM_CEST(Pc_Pes:TSTQuery;Pc_Sql,Pc_Sql_Criterio,Pc_NCM :String);
Begin
  with Pc_Pes do
  Begin
    Active := FAlse;
    sql.Clear;
    sql.Add(Pc_Sql);
    sql.Add(Pc_Sql_Criterio);
    if Length(Pc_NCM) = 8 then
      ParamByName('NCM').AsString := Pc_NCM
    else
      ParamByName('NCM').AsString := Pc_NCM  +'%';
    Active := True;
    FetchAll;
    IF Transaction.InTransaction then Transaction.CommitRetaining;
  end;
end;

function TNED.PreecheGrupoTB_CRP_ITENS: Boolean;
var
  Lc_Qry : TSTQuery;
  Lc_aux :String;
  Lc_ItensId : Integer;
  Lc_CodigoGrupo : Integer;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CPI_SABOR FROM  TB_CRP_ITENS c where c.cpi_codgrp is null ' );
      active := True;
    end;
    Lc_Qry.FetchAll;
    if Lc_Qry.RecordCount > 0 then
    Begin
      with Lc_Qry do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(concat(
                  'SELECT GRP_CODIGO ',
                  'FROM tb_grupos ',
                  'WHERE ( GRP_INTERFACE IS NOT NULL ) ',
                  'AND (GRP_DESCRICAO = ''PIZZA'') '
        ));
        active := True;
      end;
      Lc_Qry.FetchAll;
      if Lc_Qry.RecordCount > 0 then
      Begin
        Lc_CodigoGrupo := Lc_Qry.FieldByName('GRP_CODIGO').asInteger;
        with Lc_Qry do
        Begin
          SQL.Clear;
          SQL.Add('UPDATE TB_CRP_ITENS SET CPI_CODGRP =:CPI_CODGRP ' );
          Parambyname('CPI_CODGRP').AsInteger := Lc_CodigoGrupo;
          ExecSQL;
        end;
      End;
    End;
  finally
    Base.FinalizaQuery(Lc_Qry);
  end;
end;

procedure TNED.Update_NCM_CEST(Pc_Upd:TSTQuery;Pc_Cd_Produto:Integer;Pc_Cest:String);
Begin
  with Pc_Upd do
  Begin
    Active := FAlse;
    ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
    ParamByName('CEST').AsString := Pc_Cest;
    try
      ExecSQL;
    except
      ShowMessage('Produto: ' + InttoStr(pc_cd_Produto) + ' - CEST: ' + pc_Cest);
    end;
    IF Transaction.InTransaction then Transaction.CommitRetaining;
  end;
end;

procedure TNED.updateCEST;
Var
  Lc_Sql : String;
  Lc_Sql_Criterio : String;
  Lc_Qry : TSTQuery;
  Lc_Pes : TSTQuery;
  Lc_Upd : TSTQuery;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT PRO_CODIGO, PRO_CODIGONCM '+
              'FROM TB_PRODUTO '+
              'WHERE (PRO_ATIVO = ''S'') '+
              ' AND (PRO_TIPO <> ''S'') ');
      Active := True;
      First;
      //Pesquisa o CEST
      Lc_Pes := Base.GeraQuery;
      Lc_Sql := 'select CEST from tb_cest ';
      //Atualiza
      Lc_Upd :=  Base.GeraQuery;
      Lc_Upd.SQL.Clear;
      Lc_Upd.SQL.Add('UPDATE TB_PRODUTO SET '+
                     'PRO_CEST =:CEST '+
                     'WHERE PRO_CODIGO=:PRO_CODIGO ');

      while not Lc_Qry.Eof do
      Begin
        //Pesquisa com 8 Digitos
        Pesquisa_NCM_CEST(Lc_Pes,Lc_Sql,' where ncm =:NCM  ',Lc_Qry.FieldByname('PRO_CODIGONCM').AsString);
        if Lc_Pes.recordCount > 0 then
        Begin
          Update_NCM_CEST(Lc_Upd,Lc_Qry.FieldByName('PRO_CODIGO').AsInteger,Lc_Pes.FieldByName('CEST').AsString);
        end
        else
        Begin
          //Pesquisa com 7 digitos
          Pesquisa_NCM_CEST(Lc_Pes,Lc_Sql,' where ncm like :NCM  ',Copy(Lc_Qry.FieldByname('PRO_CODIGONCM').AsString,1,7));
          if Lc_Pes.recordCount > 0 then
          Begin
            Update_NCM_CEST(Lc_Upd,Lc_Qry.FieldByName('PRO_CODIGO').AsInteger,Lc_Pes.FieldByName('CEST').AsString);
          end
          else
          Begin
            //Pesquisa com 6 digitos
            Pesquisa_NCM_CEST(Lc_Pes,Lc_Sql,' where ncm like :NCM  ',Copy(Lc_Qry.FieldByname('PRO_CODIGONCM').AsString,1,6));
            if Lc_Pes.recordCount > 0 then
            Begin
              Update_NCM_CEST(Lc_Upd,Lc_Qry.FieldByName('PRO_CODIGO').AsInteger,Lc_Pes.FieldByName('CEST').AsString);
            end
            else
            Begin
              //Pesquisa com 5 digitos
              Pesquisa_NCM_CEST(Lc_Pes,Lc_Sql,' where ncm like :NCM  ',Copy(Lc_Qry.FieldByname('PRO_CODIGONCM').AsString,1,5));
              if Lc_Pes.recordCount > 0 then
              Begin
                Update_NCM_CEST(Lc_Upd,Lc_Qry.FieldByName('PRO_CODIGO').AsInteger,Lc_Pes.FieldByName('CEST').AsString);
              end
              else
              Begin
                //Pesquisa com 4 digitos
                Pesquisa_NCM_CEST(Lc_Pes,Lc_Sql,' where ncm like :NCM  ',Copy(Lc_Qry.FieldByname('PRO_CODIGONCM').AsString,1,4));
                if Lc_Pes.recordCount > 0 then
                Begin
                  Update_NCM_CEST(Lc_Upd,Lc_Qry.FieldByName('PRO_CODIGO').AsInteger,Lc_Pes.FieldByName('CEST').AsString);
                end
                else
                Begin
                  //Pesquisa com 3 digitos
                  Pesquisa_NCM_CEST(Lc_Pes,Lc_Sql,' where ncm like :NCM  ',Copy(Lc_Qry.FieldByname('PRO_CODIGONCM').AsString,1,3));
                  if Lc_Pes.recordCount > 0 then
                  Begin
                    Update_NCM_CEST(Lc_Upd,Lc_Qry.FieldByName('PRO_CODIGO').AsInteger,Lc_Pes.FieldByName('CEST').AsString);
                  end
                  else
                  Begin
                    //Pesquisa com 2 digitos
                    Pesquisa_NCM_CEST(Lc_Pes,Lc_Sql,' where ncm like :NCM  ',Copy(Lc_Qry.FieldByname('PRO_CODIGONCM').AsString,1,2));
                    if Lc_Pes.recordCount > 0 then
                    Begin
                      Update_NCM_CEST(Lc_Upd,Lc_Qry.FieldByName('PRO_CODIGO').AsInteger,Lc_Pes.FieldByName('CEST').AsString);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        Lc_Qry.next;
      end;
    End;
  finally
    Base.FinalizaQuery(Lc_Qry);
    Base.FinalizaQuery(Lc_Pes);
    Base.FinalizaQuery(Lc_Upd);
  end;
end;

procedure TNED.RecriarTB_CTRL_ESTOQUE;
BEGIN
              RunScript('DROP TRIGGER TG_ESTOQUE_DELETE; ');
              RunScript('DROP TRIGGER TG_ESTOQUE_INSERT; ');
              RunScript('DROP TRIGGER TG_ESTOQUE_UPDATE; ');
              RunScript('DROP TABLE TB_CTRL_ESTOQUE; ');
              RunScript(concat(
              'CREATE TABLE TB_CTRL_ESTOQUE ( ',
              '    CET_CODIGO     INTEGER NOT NULL, ',
              '    CET_TERMINAL   INTEGER NOT NULL, ',
              '    CET_VINCULO    CHAR(1) NOT NULL, ',
              '    CET_CONTROLE   INTEGER, ',
              '    CET_ITEM_CTRL  INTEGER, ',
              '    CET_CODETS     INTEGER, ',
              '    CET_OPERACAO   CHAR(1), ',
              '    CET_CODPRO     INTEGER, ',
              '    CET_QTDE       NUMERIC(10,3), ',
              '    CET_DATA       DATE, ',
              '    UPDATE_AT      TIMESTAMP, ',
              '    CET_TIPO       VARCHAR(25) ); '
              ));
              RunScript('ALTER TABLE TB_CTRL_ESTOQUE ADD CONSTRAINT PK_TB_CTRL_ESTOQUE PRIMARY KEY (CET_CODIGO, CET_TERMINAL); ');
              RunScript('ALTER TABLE TB_CTRL_ESTOQUE ADD CONSTRAINT FK_TB_CTRL_ESTOQUE_1 FOREIGN KEY (CET_CODETS) REFERENCES TB_ESTOQUES (ETS_CODIGO); ');
              RunScript('ALTER TABLE TB_CTRL_ESTOQUE ADD CONSTRAINT FK_TB_CTRL_ESTOQUE_2 FOREIGN KEY (CET_CODPRO) REFERENCES TB_PRODUTO (PRO_CODIGO); ');
              RunScript('CREATE INDEX TB_CTRL_ESTOQUE_IDX1 ON TB_CTRL_ESTOQUE (CET_VINCULO); ');
              RunScript('CREATE INDEX TB_CTRL_ESTOQUE_IDX2 ON TB_CTRL_ESTOQUE (CET_CONTROLE); ');
              RunScript('CREATE INDEX TB_CTRL_ESTOQUE_IDX3 ON TB_CTRL_ESTOQUE (CET_ITEM_CTRL); ');
              RunScript('CREATE INDEX TB_CTRL_ESTOQUE_IDX5 ON TB_CTRL_ESTOQUE (CET_OPERACAO); ');
              RunScript('CREATE INDEX TB_CTRL_ESTOQUE_IDX7 ON TB_CTRL_ESTOQUE (CET_DATA); ');

              RunScript(concat(
              'CREATE OR ALTER TRIGGER TG_ESTOQUE_DELETE FOR TB_CTRL_ESTOQUE ',
              'ACTIVE AFTER DELETE POSITION 0 ',
              'AS ',
              'begin ',
              '  if (OLD.cet_operacao = ''E'') then ',
              '  Begin ',
              '    UPDATE tb_estoque SET ',
              '        EST_QTDE = EST_QTDE - OLD.cet_qtde ',
              '    WHERE EST_CODPRO = OLD.cet_codpro AND EST_CODETS = OLD.cet_codets; ',
              '  end ',
              '  else ',
              '  Begin ',
              '    UPDATE tb_estoque SET ',
              '        EST_QTDE = EST_QTDE + OLD.cet_qtde ',
              '    WHERE EST_CODPRO = OLD.cet_codpro AND EST_CODETS = OLD.cet_codets; ',
              '  end ',
              'end '
              ));

              RunScript(concat(
              'CREATE OR ALTER TRIGGER TG_ESTOQUE_INSERT FOR TB_CTRL_ESTOQUE ',
              'ACTIVE AFTER INSERT POSITION 0 ',
              'AS ',
              'begin ',
              '  if (NEW.cet_operacao = ''E'') then ',
              '  Begin ',
              '    UPDATE tb_estoque SET ',
              '        EST_QTDE = EST_QTDE + NEW.cet_qtde ',
              '    WHERE EST_CODPRO = NEW.cet_codpro AND EST_CODETS = NEW.cet_codets; ',
              '  end ',
              '  else ',
              '  Begin ',
              '    UPDATE tb_estoque SET ',
              '        EST_QTDE = EST_QTDE - NEW.cet_qtde ',
              '    WHERE EST_CODPRO = NEW.cet_codpro AND EST_CODETS = NEW.cet_codets; ',
              '  end ',
              'end '
              ));

              RunScript(concat(
              'CREATE OR ALTER TRIGGER TG_ESTOQUE_UPDATE FOR TB_CTRL_ESTOQUE ',
              'ACTIVE BEFORE UPDATE POSITION 0 ',
              'AS ',
              'begin ',
              '    if (OLD.cet_operacao = ''E'') then ',
              '    Begin ',
              '        UPDATE tb_estoque SET ',
              '            EST_QTDE = EST_QTDE - OLD.cet_qtde ',
              '        WHERE EST_CODPRO = OLD.cet_codpro ',
              '            AND EST_CODETS = OLD.cet_codets; ',
              '        UPDATE tb_estoque SET ',
              '            EST_QTDE = EST_QTDE + New.cet_qtde ',
              '        WHERE EST_CODPRO = New.cet_codpro ',
              '            AND EST_CODETS = New.cet_codets; ',
              '    end ',
              '    else ',
              '    Begin ',
              '        UPDATE tb_estoque SET ',
              '            EST_QTDE = EST_QTDE + OLD.cet_qtde ',
              '        WHERE EST_CODPRO = OLD.cet_codpro ',
              '            AND EST_CODETS = OLD.cet_codets; ',
              '        UPDATE tb_estoque SET ',
              '            EST_QTDE = EST_QTDE - New.cet_qtde ',
              '        WHERE EST_CODPRO = New.cet_codpro ',
              '            AND EST_CODETS = New.cet_codets; ',
              '    end ',
              'end '
              ));

end;

procedure TNED.updateIndEscala;
var
  Lc_Qry : TSTQuery;
  LcCrit : String;
begin
  try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'select p.pro_codigo,c.anexo_xxvii ',
                'from tb_produto p ',
                '  inner join tb_cest c ',
                '  on (p.pro_cest = c.cest) ',
                'where (c.anexo_xxvii =''Fabricados em escala industrial não relevante'') '
      ));
      Active := true;
      FetchAll;
      if recordcount > 0 then
      Begin
        First;
        while not eof do
        Begin
          if bof then
            LcCrit := concat('(',FieldByName('pro_codigo').asString)
          else
            LcCrit := concat(LcCrit,',',FieldByName('pro_codigo').asString);
          next;
        End;
        LcCrit := concat(LcCrit,')');
        //Atualiza o cadastro
        Close;
        SQL.Clear;
        SQL.Add(concat(
                  'update tb_produto p set p.indescala = ''N'' where p.pro_codigo in ',LcCrit));
        Prepare;
        ExecSQL;
      End;
    end;
  finally
    Base.FinalizaQuery( Lc_Qry);
  end;


end;


end.

