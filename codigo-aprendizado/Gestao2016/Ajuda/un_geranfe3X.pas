unit un_geranfe3X;


interface

uses     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw, IniFiles, DB, STQuery, Grids, DBGrids, Menus, Mask, Printers, ACBrNFe, pcnConversao, ACBrNFeDANFEClass, pcnLeitor, ACBrNFeNotasFiscais, ACBrNFeWebServices, ACBrNFeDANFeRLClass, QuickRpt, System.StrUtils, FavoritoButtons, Gauges, XMLDoc, XMLIntf, System.Math, filectrl, Registry, WinINEt, ExtActns, ACBrNFeDANFeESCPOS, TypInfo, IdTCPConnection, IdTCPClient, IdHTTP, XSBuiltIns, blcksock, DBCtrls, Spin, QEdit_Setes, pcnConversaoNfe, ACBrPosPrinter, ACBrBase, ACBrDFe, ShellAPI, zlib, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, ACBrDFe.Conversao, Vcl.AppEvnts, ControllerArquivo, ControllerCtrlIcmsST, ACBrNFe.Classes, ControllerNOtaFiscal, ControllerCtrlLote, ControllerNfEletronica, ControllerFinanceiro, STDataSet,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  IBX.IBCustomDataSet, IBX.IBQuery;

type

  TFr_GeraNfe3x = class(TForm)
    pg_Principal: TPageControl;
    ds_Nota: TDataSource;
    Qr_Nota: TSTQuery;
    Qr_Itens: TSTQuery;
    Qr_IPI: TSTQuery;
    Qr_II: TSTQuery;
    Qr_Pis: TSTQuery;
    Qr_Cofins: TSTQuery;
    Qr_Financeiro: TSTQuery;
    Qr_Natureza: TSTQuery;
    Qr_Serie_Veiculo: TSTQuery;
    Qr_lote: TSTQuery;
    Qr_Serie_Produto: TSTQuery;
    Qr_Observacao: TSTQuery;
    Qr_Issqn: TSTQuery;
    Qr_Itens_ICMS_ST: TSTQuery;
    Qr_ItensDev: TSTQuery;
    Ds_ItensDev: TDataSource;
    Qr_RetornoNFe: TSTQuery;
    Qr_LoteNFC_e_OffLine: TSTQuery;
    Qr_FCP: TSTQuery;
    Pnl_Validade: TPanel;
    Pnl_Cert_Validade: TPanel;
    Pnl_Cert_Expira: TPanel;
    Qr_DevolIpi: TSTQuery;
    Qr_LoteProduzido: TSTQuery;
    Qr_Icms: TSTQuery;
    Qr_Combustivel: TSTQuery;
    Qr_Itens_RTR: TSTQuery;
    Qr_RetornoNFCe: TSTQuery;

    procedure FormShow(Sender: TObject);
    procedure Pc_atualiza_dadosnotafiscal(Pc_CodMha_Ant: Integer);
    procedure Pc_PathClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FNaoUtilizarCodigoBarras : Boolean;

    EditionState : String;
    CtrlICMSST : TControllerCtrlIcmsST;
    OcultaDuplicataPagVista : Boolean;
    informacaoSemBenefic : Boolean;
    function ValidateSaveNfeEletronica:Boolean;
    procedure SaveNfeEletronica;

    // Teclas de Atalho
    function getUnidadeTributavel(id:Integer) : String;
    procedure setFTipoOperacao(const Value: String);
  protected
    FNfConjugada: Boolean;
    Arquivo : TControllerArquivo;
    FTentativasChaveDuplicada : Integer;
    FTipoOperacao: String;
    FMotivoCancelamento: String;
    FNFEletronica : TControllerNfEletronica;
    It_Cd_Codmha: Integer;
    NotaFiscal : TControllerNOtaFiscal;
    CtrlLote : TControllerCtrlLote;
    Financeiro:TControllerFinanceiro;
    procedure FormataTela;Virtual;
    procedure CriarVariaveis;Virtual;
    procedure FinalizarVariaveis;Virtual;
    procedure ImagemBotao;Virtual;
    procedure IniciaVariaveis;Virtual;
    procedure TrataRetorno(var Pc_Cd_Retorno: Integer; pc_Memo: TMemo; OnLine:Boolean);Virtual;
    procedure ApagarPrePaid;
    procedure ApagarPayBAck;
    procedure MostraValidade(pValidade, pCert_Validade,pCert_Expira: TPanel);
    procedure Pc_AtivatTb_NF_Eletronica;
    function validaCancelaCarregarNota:Boolean;
    function validaCancelaInventario:Boolean;
    function validaCancelaFinanceiro:Boolean;
    function validaCancelaNotaServico:Boolean;
    procedure cancelaNotaComplementar;

    function ValidaCancelamentoNotas: Boolean; Virtual;
    function  validaCancelaLote:Boolean;
    function DeleteLote:boolean;
    function Fc_ValidaImpressaoNFe(Fc_Cd_Nota: Integer): Boolean;
    procedure ImprimeDuplicata;Virtual;
    procedure ConfirmaEnviaNFe(Path,FileXML,FilePDF:String;Validar:Boolean);Virtual;
    procedure ConfirmaEnviaBoleto;Virtual;
    procedure ConfirmaImprimeBoleto;Virtual;
    function CarregaComponenteNFE(Pc_Path,Pc_FileXMl:String):Boolean; virtual;
  public
    // Controla apenas NFC-e
    FVisualizaImpressao: Boolean;
    It_cd_Cliente: Integer;
    It_cd_Consumidor: Integer;
    It_Nf_Terceiro: Boolean;
    // Variaves Pre-existentes
    It_Cd_Pedido: Integer;
    It_Cd_Nota: Integer;
    It_Nr_Nota: Integer;
    It_Vl_Bs_Icms: Real;
    It_Vl_Icms: Real;
    // TAG de grupo de Valores Totais referentes ao ISSQN
    It_Tl_Iss_vServico: Real;
    It_Tl_Iss_vBC: Real;
    It_Tl_Iss_valor: Real;
    It_Tl_Iss_valor_Ret: Real;
    It_Tl_Iss_vPis: Real;
    It_Tl_Iss_vCofins: Real;
    // Impressao do cupom não fiscal
    ValorRecebido: Real;
    ValorTroco: Real;
    FMostraLote : Boolean;
    PreencheloteValid : Boolean;
    MostraRastreioCompleto : Boolean;
    //Serve para quando o retorno mostra chave já existente e autorizada
    ChaveDuplicada : String;
    // VALIDAÇÕES
    // OPERAÇÕES DA NOTA FISCAL ELETRÔNICA
    function InformarChaveAcesso:Integer;
    procedure PreencheDanfeIde(dfide:TIde;Oper_Consulta:Boolean);Virtual;

    procedure PagamentoAntecipado;

    procedure PreencheDanfeEmi(dfemi:TEmit;Oper_Consulta:Boolean);
    procedure PreencheDanfeDes(dfdes:TDest;Oper_Consulta:Boolean);
    procedure PreencheDanfeCasasDecimais;
    procedure PreencheDanfeItensProdServ(itens:Tprod; Item:Integer);
    function  PreencheDanfeProdInfoAdicLote(itens:Tprod; Item:Integer):String;
    function  PreencheDanfeProdInfoAdicFCP(itens:Tprod; Item:Integer):String;
    function  PreencheDanfeProdInfoAdicDifal(imposto:TImposto;Item:Integer):String;
    function  PreencheDanfeProdInfoAdicRTR(itens:Tprod; Item:Integer):String;
    function  PreencheDanfeProdInfoAdic(itens:Tprod; Item:Integer;imposto:TImposto):String;
    procedure PreencheDanfeImportacao(itens:Tprod);
    procedure PreencheDanfeVeiculosNovos(itens:Tprod);
    procedure PreencheDanfeCombustivel(itens:Tprod);
    procedure PreencheDanfeImpostoAproximado(imposto:TImposto);
    procedure PreencheDanfeImpostoRegimeNormal(imposto:TImposto);
    procedure PreencheDanfeImpostoSimplesNacional(imposto:TImposto);
    procedure PreencheDanfeICMS(imposto:TImposto);
    procedure PreencheDanfePartilhaFCP(Emit:TEmit;Ide:TIde;Dest:TDest;Prod:TProd;imposto:TImposto);

    procedure PreencheDanfeIPI(imposto:TImposto);
    procedure PreencheDanfeIPIDevolvido;
    procedure PreencheDanfeII(imposto:TImposto);
    procedure PreencheDanfePIS(imposto:TImposto);
    procedure PreencheDanfeCOFINS(imposto:TImposto);
    procedure PreencheDanfeISSQN(imposto:TImposto);
    procedure ImpostoSeletivo(imposto:TImposto);

    procedure ImpostoIBSCBS(imposto:TImposto);
    procedure ImpostoIBSCBS_IBS(imposto:TImposto);
    procedure ImpostoIBSCBS_IBS_UF(imposto:TImposto);
    procedure ImpostoIBSCBS_IBS_MUN(imposto:TImposto);
    procedure ImpostoIBSCBS_CBS(imposto:TImposto);
    procedure ImpostoIBSCBS_Tribregular(imposto:TImposto);


    procedure PreencheDanfeTotalizador;
    procedure PreencheDanfeTransportadora;
    procedure PreencheDanfeFormaPagto;
    procedure PreencheDanfeCobranca;
    procedure PreencheDanfeInfAdic;Virtual;
    procedure PreencheDanfeComercioExterior;
    procedure ConfigResponsabelTécnico;
    procedure PreencheResponsabelTécnico;
    procedure PreencheCNPJAutorizados;
    Function Pc_PreencheDadosDanfe(Pc_Oper_Consulta: Boolean):Boolean;
    Function Fc_Conferencia_Danfe(Pc_Path: String; Proc: TMemo;
      Pc_Oper_Consulta: Boolean): String;
    // Carrega dados
    function Fc_AtivaDadosDaNota(Pc_tipo: String; Pc_Valor: Integer): Boolean;
    procedure Pc_SelecionaItensNota(Pc_cd_Nota: Integer);
    // Auxiliares
    procedure Pc_IdentificaEntrega(Lc_Codigo: Integer;dfent:TEntrega);
    procedure Pc_Sql_Serie_Produto;
    function Fc_InfoSubTributariaItem(Fc_Cd_Item: Integer): String;
    procedure Pc_Atualiza_DataHora_NF(Pc_cd_Nota: Integer;DataHOra:TDAteTime);
    function Fc_ValidaConferencia(Fc_Cd_Nota: Integer): Boolean;
    Function Fc_AutorizaNFe(Fc_Cd_Pedido, Fc_Cd_Nota, Fc_Nr_Nota: Integer;
      Fc_Path, FC_FileXML: String): Integer;
    function Fc_ValidaConsultaNFe(Fc_Cd_Nota: Integer): Boolean;
    procedure Pc_PosicionaEstabelecimentoEmissor;
    procedure Pc_RetornaEstabelecimentoInicial;
    Function Fc_ValidaCancelamentoNFe(Fc_Cd_Nota: Integer): Boolean;
    function ValidaEnvioEmailNFe: Boolean;
    function ValidaEnviaWhatsApp:Boolean;
    procedure EnviaWhatsApp(Tipo,Path,FilePDF,FileXML:String);
    function Fc_AtivaRetornoNFe(Pc_cd_Nota: Integer): Integer;
    procedure CancelaCtrlIcmsST;
    procedure LimpaWebService;
    property TipoOperacao : String read FTipoOperacao write setFTipoOperacao;
  end;

var
  Fr_GeraNfe3x: TFr_GeraNfe3x;

implementation

uses
un_Padrao, un_MSG, UN_Sistema, Un_Nota_Fiscal, Un_Fc_Sored_Procedures, UN_Principal, env, Un_DM, Un_Regra_Negocio, Un_Funcoes, RN_NotaFiscalEletronica3X, RN_Permissao, RN_Pedido, Un_MultiEmpresa, Un_Doc_Fiscal_Referenciado, RN_NotaFiscalConsumidor, RN_Estados, RN_Inventario, RN_NotaFiscal, RN_Financeiro, UN_TabelasEmListas, Un_Imp_Mod_Impressao, Un_Trata_Excecao, WhatsApp, un_certificado, RN_Crud, ACBrDFeSSL, ACBrDFeOpenSSL, RN_Lotes, ControllerContador, ControllerInventario, ControllerTefMovimento, ControllerBase, ControllerMarcaProduto, ControllerGrupos, ControllerMedida, ControllerCtrlNF, ControllerProductUfBenef, ControllerPayBack, ControllerPrePaidcard, ControllerRetornoNFS, TrataXMLNFe;

const
  SELDIRHELP = 1000;

{$R *.dfm}


function TFr_GeraNfe3x.Fc_InfoSubTributariaItem(Fc_Cd_Item: Integer): String;
Begin
  with Qr_Itens_ICMS_ST do
  Begin
    Active := False;
    ParamByName('ITF_CODIGO').AsInteger := Fc_Cd_Item;
    Active := True;
    FetchAll;
    if (recordcount > 0) then
    Begin
      Result := 'MVA: ' + FloatToStrF
        (((FieldByName('ICM_MG_VA_ST').asfloat - 1) * 100), ffFixed,
        10, 2) + '%';
      Result := Result + ' | ' + 'BCST: R$ ' +
        FloatToStrF(FieldByName('ICM_VL_BC_ST').AsCurrency, ffFixed, 10, 2);
      Result := Result + ' | ' + 'ICMS ST: R$ ' +
        FloatToStrF(FieldByName('ICM_VL_ST').AsCurrency, ffFixed, 10, 2);
    end
    else
    Begin
      Result := '';
    end;
  end;
end;

procedure TFr_GeraNfe3x.Pc_Sql_Serie_Produto;
Var
  Lc_txtSql: String;
Begin
  Qr_Serie_Produto.Close;
  Qr_Serie_Produto.sql.Clear;
  Lc_txtSql := 'SELECT * FROM TB_SERIE_PRODUTO ';

  if Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SI' THEN
    Lc_txtSql := Lc_txtSql + 'WHERE SRP_CODSAI=:SRP_CODSAI  '

  else if (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EI') THEN
    Lc_txtSql := Lc_txtSql + 'WHERE SRP_CODENT=:SRP_CODENT  '
  else
    Lc_txtSql := Lc_txtSql + 'WHERE 1<>1  ';
  Qr_Serie_Produto.sql.Add(Lc_txtSql);
end;


function TFr_GeraNfe3x.Fc_ValidaConferencia(Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  if not Fc_VerificaPermissao('Fr_GeraNFe', 'Conferir Nota Fiscal', 'CONFERIR',
    GB_Cd_Usuario, 'S') then
  Begin
    Result := False;
    Exit;
  end;

  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Não foi possivel Carregar a nota.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if (Qr_itens.recordcount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                    'Este pedido não tem Produtos.' + EOLN +
                    'Não é possível emitir nota de Mercadorias.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;


  Lc_Verificacao := Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsInteger;
  if (Lc_Verificacao = 1) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Nota já enviada, porãm ainda não possue autorização.' + EOLN +
      'Solicite o retorno de autorização.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 2) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Nota já autorizada.' + EOLN + 'Verifique antes de continuar.' + EOLN,
      ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 3) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Nota Fiscal Cancelada.' + EOLN + 'Verifique antes de continuar.' + EOLN,
      ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 4) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Número de Nota Inutilizada.' + EOLN + 'Verifique antes de continuar.' +
      EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TFr_GeraNfe3x.Fc_AtivaDadosDaNota(Pc_tipo: String;
  Pc_Valor: Integer): Boolean;
var
  Lc_SqlTxt: String;
begin
  Qr_Nota.Close;
  Qr_Nota.sql.Clear;
  Lc_SqlTxt := concat(
            'SELECT DISTINCT PED_CODIGO, PED_TIPO, PED_indPres, NFL_CODIGO, ',
            '   NAT_DESCRICAO, NFL_SERIE, NAT_CFOP, PED_NUMERO, NFL_NUMERO, ',
            '   NFL_NFL_VINCULO,NFL_VL_TL_NOTA, EMP_CODIGO,EMP_CONSUMIDOR, ',
            '   EMP_NOME,EMP_FANTASIA,EMP_CNPJ,END_ENDER, END_BAIRRO,END_COMPLEM,',
            '   END_CEP, CDD_IBGE,CDD_DESCRICAO,END_FONE,END_CELULAR, UFE_SIGLA,UFE_CODIGO,',
            '   EMP_INSC_EST,EMP_EMAIL,NFL_DT_EMISSAO,NFL_FINALIDADE, ',
            '   NFL_DT_SAIDA, NFL_HR_SAIDA,NFL_BS_ICMS,NFL_VL_ICMS,NFL_BS_ICMS_SUBST,',
            '   NFL_VL_ICMS_SUBST,NFL_VL_TL_PROD, NFL_VL_FRETE,NFL_VL_SEGURO,',
            '   NFL_VL_DESP_ACESS, NFL_VL_IPI,NFL_VL_ISS,NFL_VL_ISS_RET,NFL_QT_PRODUTO, ',
            '   NFL_ESPECIE,NFL_MARCA,NFL_PESO_BRUTO,NFL_PESO_LIQ,CLB_NOME,NFL_STATUS,',
            '   NFL_TIPO,PED_OBS,NFL_VL_TL_SRV,PED_VL_DESCONTO,PED_DT_ALTERA,PED_CODTRP,',
            '   END_NUMERO, NFL_CODTRP,MDF_GRUPO,NFL_VOL_NUMERO, NFL_PLC_VEICULO,NFL_PLC_UF,',
            '   NFL_PLC_RNTC,PED_PRAZO,PAI_DESCRICAO,END_PAIS,PED_CODEND,EMP_IND_IE_DEST,',
            '   CDD_ISS_ALIQ,CLI_ISS_RET,CLI_ISS_EXIGIB,CLI_ISS_IND_INC_FISCAL,CLI_ISS_NR_PROCESSO, CLI_EMAIL_NF_AUTO ',
            'FROM TB_NOTA_FISCAL tb_nota_fiscal ',
            '   INNER JOIN TB_PEDIDO tb_pedido ',
            '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)  ',
            '   INNER JOIN TB_EMPRESA tb_empresa ',
            '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)  ',
            '   LEFT OUTER JOIN TB_CLIENTE tb_cliente  ',
            '   ON (tb_cliente.CLI_CODEMP = tb_empresa.EMP_CODIGO)  ',
            '   LEFT OUTER JOIN TB_NATUREZA tb_natureza                ' ,
            '   ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) ' ,
            '   INNER  JOIN TB_ENDERECO tb_endereco                     ' ,
            '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) ' ,
            '   INNER JOIN TB_CIDADE tb_cidade ' ,
            '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)      ' ,
            '   INNER JOIN TB_UF tb_uf  ' ,
            '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)          ' ,
            '   LEFT OUTER  JOIN TB_COLABORADOR tb_colaborador          ' ,
            '   ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)   ' ,
            '   INNER  JOIN TB_PAIS tb_pais  ' ,
            '   ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)        ' ,

            '   LEFT OUTER JOIN tb_modal_frete tb_modal_frete  ' ,
            '   ON (tb_modal_frete.mdf_GRUPO = tb_nota_fiscal.nfl_cta_frete)   ' ,

            '  WHERE (END_PRINCIPAL =''S'') ');

  if (Pc_tipo = 'C') then
    Lc_SqlTxt := Lc_SqlTxt + ' AND (tb_nota_fiscal.NFL_CODIGO =:NFL_CODIGO)'
  else
    Lc_SqlTxt := Lc_SqlTxt + ' AND (tb_nota_fiscal.NFL_NUMERO =:NFL_NUMERO)';

  Qr_Nota.sql.Add(Lc_SqlTxt);

  if (Pc_tipo = 'C') then
    Qr_Nota.ParamByName('NFL_CODIGO').AsInteger := Pc_Valor
  else
    Qr_Nota.ParamByName('NFL_NUMERO').AsInteger := Pc_Valor;

  Qr_Nota.Active := True;
  Qr_Nota.FetchAll;

  Result := (Qr_Nota.recordcount > 0);

  NotaFiscal.Registro.Codigo := qr_nota.FieldByName('NFL_CODIGO').AsInteger;
  NotaFiscal.getbyId;
end;



function TFr_GeraNfe3x.ValidaEnviaWhatsApp: Boolean;
begin
  Result := True;
  if (It_cd_Cliente = It_cd_Consumidor) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Não é possivel enviar para o cliente Consumidor.' +EOLN +
                   ' Para enviar é necessário ter o telefone no cadastro'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;

  if (Length(Qr_Nota.FieldByName('END_CELULAR').AsString) = 0) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' O Campo celular do cadastro não foi informado.' +EOLN +
                   ' Verifique para continuar'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;

  if (Length(Qr_Nota.FieldByName('END_CELULAR').AsString) <8) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' O Campo celular do cadastro parece estar incompleto.' +EOLN +
                   ' Verifique para continuar'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End

end;


function TFr_GeraNfe3x.ValidateSaveNfeEletronica: Boolean;
begin
  Result := True;
end;

function TFr_GeraNfe3x.validaCancelaInventario: Boolean;
Var
  Lc_Dt_Inventario: TDate;
  Lc_Dt_Prx_Inventario: TDate;
  Lc_Inventario : TControllerInventario;
begin
  try
    Lc_Inventario := TControllerInventario.create(Nil);
    Result := True;
    Lc_Dt_Inventario := 0;
    Lc_Dt_Prx_Inventario := 0;
    Pc_SelecionaItensNota(It_Cd_Nota);
    Qr_Itens.Active := True;
    Qr_Itens.First;
    while not Qr_Itens.Eof do
    Begin
      Lc_Inventario.CodigoProduto := Qr_Itens.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Inventario.CodigoEstoque := Gb_Estoque;
      Lc_Inventario.Estabelecimento := Gb_CodMha;
      Lc_Dt_Prx_Inventario := Lc_Inventario.UltimaDataInventarioProduto();
      if Lc_Dt_Inventario < Lc_Dt_Prx_Inventario then
        Lc_Dt_Inventario := Lc_Dt_Prx_Inventario;
      Qr_Itens.Next;
    end;
  finally
    FreeAndNil(Lc_Inventario);
  end;

  if Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsDateTime < Lc_Dt_Inventario then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Este documento não pode ser cancelado.' + EOLN +
                    'A data de emissão é menor do que o último inventário criado.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TFr_GeraNfe3x.validaCancelaLote: Boolean;
begin
  Result := True;
  Qr_Itens.Active := True;
  Qr_Itens.First;
  while not Qr_Itens.Eof do
  Begin
    CtrlLote.getLoteByVinculo( Qr_Itens.FieldByName('ITF_CODIGO').AsInteger );
    if CtrlLote.exist then
    Begin
      if CtrlLote.verificaLoteUsado then
      Begin
        Result := False;
        break;
      End;
    End;
    Qr_Itens.Next;
  end;

end;

function TFr_GeraNfe3x.ValidaCancelamentoNotas: Boolean;
begin
  Result := True;
  if not validaCancelaCarregarNota then
  Begin
    Result := False;
    Exit;
  end;

  if not Fc_VerificaPermissao('Fr_GeraNFe', 'Cancelar Nota Fiscal', 'CANCELAR',
    GB_Cd_Usuario, 'S') then
  Begin
    Result := False;
    Exit;
  end;

  // Verifica Inventario
  if not validaCancelaInventario then
  Begin
    Result := False;
    Exit;
  end;

  if not validaCancelaFinanceiro then
  Begin
    Result := False;
    Exit;
  end;

  if not validaCancelaNotaServico then
  Begin
    Result := False;
    Exit;
  end;

end;

function TFr_GeraNfe3x.validaCancelaNotaServico: Boolean;
Var
  Lc_Nfse : TControllerRetornoNFS;
  Lc_Nfse_Auto : Boolean;
begin
  Result := true;
  try
    Lc_Nfse := TControllerRetornoNFS.create(Self);
    Lc_Nfse.Registro.CodigoNotaFiscal := Qr_Nota.FieldByName('NFL_CODIGO').asInteger;
    Lc_Nfse.getAutorizada;

    if Lc_Nfse.Registro.CodigoSituacao <4 then
    Begin
      Lc_Nfse.Lote.Registro.CodigoNotaFiscal := Qr_Nota.FieldByName('NFL_CODIGO').asInteger;
      Lc_Nfse.Lote.deletebyNF;
      Lc_Nfse.Rps.Registro.CodigoNotaFiscal := Qr_Nota.FieldByName('NFL_CODIGO').asInteger;
      Lc_Nfse.Rps.deletebyNF;
      Lc_Nfse.Registro.CodigoNotaFiscal := Qr_Nota.FieldByName('NFL_CODIGO').asInteger;
      Lc_Nfse.deleteNfe;
    End
    else
    Begin
      if (Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsInteger = 0)  then
      Begin
        if Lc_Nfse.Registro.CodigoSituacao = 4 then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Existe um nota de Serviço Autorizada.' + EOLN +
                         'Por favor cancele esta nota antes de prosseguir.' + EOLN +
                         '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
        End;
        if Lc_Nfse.Registro.CodigoSituacao = 5 then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Existe um nota de Serviço Cancelada.' + EOLN +
                         'Não é possivel o cancelamento devido ao vinculo existente.' + EOLN +
                         '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
        End;
        Result := false;
      End;
    End;
  finally
    FreeAndNil(Lc_Nfse);
  end;
end;


Function TFr_GeraNfe3x.Fc_AutorizaNFe(Fc_Cd_Pedido, Fc_Cd_Nota,
  Fc_Nr_Nota: Integer; Fc_Path, FC_FileXML: String): Integer;
begin

end;

function TFr_GeraNfe3x.Fc_ValidaConsultaNFe(Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;

//  if not Fc_VerificaStatusServicoNfe(False) then
//  Begin
//    Result := False;
//    Exit;
//  end;


  if not Fc_VerificaPermissao('Fr_GeraNFe', 'Consultar Nota Fiscal',
    'CONSULTAR', GB_Cd_Usuario, 'S') then
  Begin
    Result := False;
    Exit;
  end;

  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Não foi possivel Carregar a Nota.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  Lc_Verificacao := StrToIntDef(Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsString,0);
  if (Lc_Verificacao = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Nota não enviada para autorização.' + EOLN +
      'Envie antes de tentar Consultar.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 4) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Número de Nota Inutilizada.' + EOLN +
      'Impossivel Consultar Nota inexistente.' + EOLN, ['OK'], [bEscape],
      mpAlerta);
    Result := False;
    Exit;
  end;

end;



Function TFr_GeraNfe3x.Fc_ValidaCancelamentoNFe(Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  Lc_Verificacao := StrToIntDef(Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsString,0);
  if (Lc_Verificacao = 0) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Não é possivel cancelar uma nota não enviada.' + EOLN +
                    '       Verifique e tente novamente.' + EOLN, ['OK'], [bEscape],
                    mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 1) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Esta nota foi envida, mas não foi autorizada ainda.' + EOLN +
                    'Faça consulta para pegar o retorno e tente novamente.' + EOLN, ['OK'],
                    [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 3) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Esta nota já está cancelada.' + EOLN + 'Verifique e tente novamente.' +
                    EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 4) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Número de Nota Inutilizada.' + EOLN + 'Verifique antes de continuar.' +
      EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  FMotivoCancelamento := '';
  if not(InputQuery('WebServices Cancelamento', 'Justificativa',
    FMotivoCancelamento)) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Justificativa de cancelamento deve ser informada' + EOLN +
      'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if Length(Trim(FMotivoCancelamento)) < 15 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Justificativa de cancelamento não' + EOLN +
      'pode ser inferior a 15 caracteres.' + EOLN +
      'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;
end;

procedure TFr_GeraNfe3x.Pc_Atualiza_DataHora_NF(Pc_cd_Nota: Integer;
  DataHOra: TDAteTime);
begin
  if DataHOra > 0 then
  BEgin
    with NotaFiscal do
    Begin
      Registro.Codigo := Pc_cd_Nota;
      Registro.DataEmissao := DataHOra;
      Registro.HoraSaida := DataHOra;
      updateDataHora;
    End;
  End;
end;

procedure TFr_GeraNfe3x.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizarVariaveis;
end;

procedure TFr_GeraNfe3x.FormCreate(Sender: TObject);
begin
  CriarVariaveis;
end;

procedure TFr_GeraNfe3x.Pc_SelecionaItensNota(Pc_cd_Nota: Integer);
Begin
  with Qr_Itens do
  Begin
    Close;
    sql.Clear;
    sql.Add(concat(
              'SELECT DISTINCT   ITF_SEQUENCIA, ITF_CODIGO, PRO_CODIGOFAB,PRO_COMPOSICAO, ' ,
              '  PRO_CODIGOBAR, PRO_CODIGOFOR, PRO_CODIGONCM,PRO_SERIE, ' ,
              '  PRO_SUB_TRIB,  PRO_CEST, PRO_ORIGEM, PRO_CODMRC,  ' ,
              '  PRO_DESCRICAO, ITF_QTDE,  mc.MED_ABREVIATURA,PRO_CODMED_TRIB,PRO_QTDE_TRIB, ',
              '  ITF_VL_UNIT,ITF_VL_CUSTO, ITF_CODPRO, ' ,
              '  (ITF_QTDE* ITF_VL_UNIT) ITF_VL_SB_TOTAL, ' ,
              '  ITF_VL_DESC, ITF_AQ_DESC, ITF_AQ_COM, ',
              '  ITF_ESTOQUE, ITF_AQ_IPI, ITF_AQ_ICMS, ',
              '  ITF_CODEST, ITF_CODTPR, ITF_COMPRA, ',
              '  ITF_ITEM_COMPRA, PRO_DETALHES,PRO_TIPO, ',
              '  ITF_OPER, ITF_IMP_APROX, IAV_UNIDADE,indEscala, ',
              '  IAV_DESCRICAO,SRP.* ',
              'FROM TB_ITENS_NFL INF ',
              '   INNER JOIN TB_PRODUTO PRO ',
              '   ON  (PRO.PRO_CODIGO = INF.ITF_CODPRO) ',

              '   INNER JOIN TB_MEDIDA mc ',
              '   ON  (mc.MED_CODIGO = PRO.PRO_CODMED) ',

              '   LEFT OUTER JOIN TB_SERIE_PRODUTO SRP ',
              '   ON  (SRP.SRP_CODSAI = INF.ITF_CODNFL) ',
              '   LEFT OUTER JOIN TB_ITENS_AVL ',
              '   ON (IAV_CODITF = ITF_CODIGO) ',
              'WHERE (ITF_CODNFL=:ITF_CODNFL) AND (ITF_OPER <> ''D'') '
    ));

    if not FNfConjugada then
      sql.Add(' AND (PRO_TIPO <> ''S'') ');
    sql.Add(' order by 1 ');
    ParamByName('ITF_CODNFL').AsInteger := Pc_cd_Nota;
    Active := True;
    FetchAll;
  end;
end;


Function TFr_GeraNfe3x.Fc_Conferencia_Danfe(Pc_Path: String; Proc: TMemo;
  Pc_Oper_Consulta: Boolean): String;
Var
  Lc_FileXML: String;
begin
  with Proc.Lines do
  Begin
    Clear;
    Proc.Update;
    Add('INICIANDO A OPERAÇÃO...');
    Proc.Update;
    Add('CARREGANDO OS DADOS DO EMITENTE...');
    Proc.Update;
    Pc_CarregaDadosEmitente(True);
    Add('CARREGANDO OS DADOS DO USUÁRIO...');
    Proc.Update;
    //Pc_AtivaDadosUsuarios;
    Add('SELECIONANDO A NOTA PARA A AUTORIZAÇÃO...');
    Proc.Update;
    Add('GERANDO O DANFE COM INFORMAÇÕES DA NOTA...');
    Proc.Update;
    Fr_Principal.Nfe.DANFE.Protocolo := '';
    if not Pc_PreencheDadosDanfe(Pc_Oper_Consulta) then
    Begin
      Exit;
    end;
    Add('SALVANDO O XML REFERENTE A NOTA...');
    Proc.Update;
    // Faz a gravação do XML no Banco de dados
    Fr_Principal.Nfe.NotasFiscais.Items[0].GerarXML;
    Lc_FileXML := Copy(Fr_Principal.Nfe.NotasFiscais.Items[0].Nfe.infNFe.ID,(Length(Fr_Principal.Nfe.NotasFiscais.Items[0].Nfe.infNFe.ID) - 44) + 1, 44) + '-NFe.xml';

    // Fr_Principal.Nfe.NotasFiscais.Items[0].GravarXML();
      Add('VALIDANDO O XML REFERENTE A NOTA...');
    Proc.Update;
    Try
      Fr_Principal.Nfe.NotasFiscais.GerarNFe;
      Fr_Principal.Nfe.NotasFiscais.GravarXML(concat(Pc_Path,'\',Lc_FileXML) );

      Fr_Principal.Nfe.NotasFiscais.Assinar;
      Fr_Principal.Nfe.NotasFiscais.Validar;
      Result := Lc_FileXML
    except
      on E: Exception do
      Begin
        Add(E.ClassName + ' Erro : ' + E.Message);
        Result := '';
        Add('Problemas ao gerar e/ou validar o arquivo XML...');
      end;
    end;
  end;
end;


procedure TFr_GeraNfe3x.PreencheDanfeIde(dfide:TIde;Oper_Consulta:Boolean);
var
  Lc_Ok : Boolean;
begin
  with dfide,Qr_Nota do
  Begin
    verProc := '2.0.1.6';
    // Qr_Nota.FieldByName('NFL_NUMERO').AsString;
    if (finNFe = fnAjuste) then
      natOp := '999 - Estorno de NF-e não cancelada no prazo legal'
    else
      natOp := Copy(FieldByName('NAT_DESCRICAO').AsString, 1, 60);

    nNF := It_Nr_Nota;

    //Caso o ccliente não informe chave pré existente
    if cNF = 0 then
      cNF := FieldByName('NFL_CODIGO').AsInteger;

   //Modelo sera prenchidos nos herdeiros
   serie := StrToIntDef(FieldByName('NFL_SERIE').AsString,1);

    cMunFG  := DM.Qr_Estabelecimento.FieldByName('CDD_IBGE').AsInteger;
    cUF     := DM.Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsInteger;

    tpEmis := StrToTpEmis(Lc_Ok,  IntToStr(StrToIntdef(DM.Qr_Nf_Eletronica.FieldByName('NFE_EMISSAO').AsString, 0) + 1));

    // Indica operação com Consumidor final E B01 N 1-1 1 0=Não; 1=Consumidor final;
    IF ( FieldByName('EMP_CONSUMIDOR').AsString = 'S') then
      indFinal := cfConsumidorFinal
    else
      indFinal := cfNao;

    indIntermed := iiOperacaoSemIntermediador;

    // 1=Operação interna; 2=Operação interestadual; 3=Operação com exterior.

    if ( FieldByName('PED_INDPRES').AsInteger = 1) and
       ( ( FieldByName('EMP_IND_IE_DEST').AsString = '1') or
         ( FieldByName('EMP_IND_IE_DEST').AsString = '9') ) and
         ( Qr_Nota.FieldByName('UFE_SIGLA').AsString <> DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString) then
    Begin

      idDest := doInterna;
    End
    else
    Begin
      if ( FieldByName('END_PAIS').AsInteger = 1058) then
      Begin
        if ( FieldByName('UFE_SIGLA').AsString = DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString) then
          idDest := doInterna
        else
          idDest := doInterestadual;
      end
      else
      Begin
        idDest := doExterior;
      end;
    End;

    if Gb_Reforma_Tributaria then
    Begin
      {
      cMunFGIBS := DM.Qr_Estabelecimento.FieldByName('CDD_IBGE').AsInteger;

      tpNFDebito := tdNenhum;
      tpNFCredito := tcNenhum;

      //RFT - Para administração pública direta e suas autarquias e fundações
             1=União
             2=Estado
             3=Distrito Federal
             4=Município
      gCompraGov.tpEnteGov := tcgEstados;
      //ide.gCompraGov.pRedutor
      gCompraGov.pRedutor := 5;
      //1=Fornecimento 2=Recebimento do pagamento, conforme fato gerador do IBS/CBS definido no Art. 10 § 2º
      gCompraGov.tpOperGov := togFornecimento;
      }
    End;

  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeEmi(dfemi:TEmit;Oper_Consulta:Boolean);
Var
  Lc_Aux : String;
  Lc_Ok : Boolean;
Begin
  with dfemi, DM.Qr_Estabelecimento do
  Begin
    CNPJCPF           := FieldByName('EMP_CNPJ').AsString;
    xNome             := Copy(  FieldByName('EMP_NOME').AsString, 1, 60);
    xFant             := Copy(  FieldByName('EMP_FANTASIA').AsString, 1, 60);
    EnderEmit.xLgr    := Copy(  FieldByName('END_ENDER').AsString, 1, 60);
    EnderEmit.nro     := FieldByName('END_NUMERO').AsString;
    EnderEmit.xCpl    := FieldByName('END_COMPLEM').AsString;
    EnderEmit.xBairro := FieldByName('END_BAIRRO').AsString;
    EnderEmit.cMun    := FieldByName('CDD_IBGE').AsInteger;
    EnderEmit.xMun    := FieldByName('CDD_DESCRICAO').AsString;
    EnderEmit.UF      := FieldByName('UFE_SIGLA').AsString;
    EnderEmit.CEP     := FieldByName('END_CEP').AsInteger;
    EnderEmit.cPais   := FieldByName('PAI_CODBACEN').AsInteger;
    EnderEmit.xPais   := FieldByName('PAI_DESCRICAO').AsString;
    EnderEmit.fone    := fc_MascaraFone( FieldByName('END_FONE').AsString );
    // Inscrição estadual
    Lc_Aux            := FieldByName('EMP_INSC_EST').AsString;
    Lc_Aux            := Fc_RemoveCaracterInformado(Lc_Aux, ['.', ',', '/', '-', ' ']);
    IE           := Lc_Aux;
    // Verifica se há valor de icms de substituição e se há registro de Inscrição de susbtituição exceto NFC-e
    if not(FTipoOperacao = 'NFC-e') then
    Begin
      if (Qr_Nota.FieldByName('NFL_VL_ICMS_SUBST').AsCurrency > 0) then
      Begin
        Lc_Aux := Fc_GetInscrSubstTributario(Qr_Nota.FieldByName('UFE_SIGLA').AsString);
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.', ',', '/', '-', ' ']);
        IEST := Lc_Aux;
      end;
    end;
    // Verifica se é nota Conjugada
    if FNfConjugada then
    Begin
      // Verifica se tem serviço na nota
      NotaFiscal.Registro.codigo := It_Cd_Nota;
      if  NotaFiscal.VerificaServico  then
      Begin
        // Inscrição munipal
        Lc_Aux := FieldByName('EMP_INSC_MUN').AsString;
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.', ',', '/', '-', ' ']);
        IM := Lc_Aux;
        // Campo CNAE fiscal
        CNAE := '4520001'; // 45.20-0-01
      end;
    end;
    CRT := StrToCRT(Lc_Ok, IntToStr(Gb_Cd_Crt));
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeDes(dfdes:TDest;Oper_Consulta:Boolean);
Begin
  with dfdes, Qr_Nota do
  Begin
    if (It_cd_Cliente <> It_cd_Consumidor) then
    Begin
      // Devido a pizzaria que tem cliente diferente mas pode não ter cpf.
      if Length(Trim( FieldByName('EMP_CNPJ').AsString)) > 0 then

        CNPJCPF := Qr_Nota.FieldByName('EMP_CNPJ').AsString;

      if ( Fc_Tb_Geral('L','NFE_SHOW_COD_DESTINATARIO','S') = 'S') then
        xNome := Copy( Concat(FieldByName('EMP_CODIGO').AsString,' - ',FieldByName('EMP_NOME').AsString), 1, 60)
      else
        xNome := Copy( FieldByName('EMP_NOME').AsString, 1, 60);


      if (   FTipoOperacao = 'NF-e') or
         ( ( FTipoOperacao = 'NFC-e') and ( Fr_Principal.Nfe.NotasFiscais[0].Nfe.Ide.indPres = pcEntregaDomicilio )  ) then
      Begin
        EnderDest.CEP     := StrToIntDef(FieldByName('END_CEP').AsString,80000000);
        EnderDest.cPais   := FieldByName('END_PAIS').AsInteger;
        EnderDest.xPais   := FieldByName('PAI_DESCRICAO').AsString;
        EnderDest.UF      := FieldByName('UFE_SIGLA').AsString;
        EnderDest.cMun    := FieldByName('CDD_IBGE').AsInteger;
        EnderDest.xMun    := FieldByName('CDD_DESCRICAO').AsString;
        EnderDest.xLgr    := FieldByName('END_ENDER').AsString;
        EnderDest.nro     := FieldByName('END_NUMERO').AsString;
        EnderDest.xCpl    := FieldByName('END_COMPLEM').AsString;
        EnderDest.xBairro := FieldByName('END_BAIRRO').AsString;
        EnderDest.fone    := fc_MascaraFone( FieldByName('END_FONE').AsString );
      end;

      if ( FieldByName('END_PAIS').AsInteger <> 1058) then
      Begin
        idEstrangeiro := Qr_Nota.FieldByName('EMP_INSC_EST').AsString;
      end;
    end;
    // Inscrição Estualdo Destinatario é apagada para verificação mais a frentes
    IE := '';
    if (FTipoOperacao = 'NFC-e') then
    begin
      indIEDest := inNaoContribuinte;
    end
    else
    Begin
      case StrToIntdef(Qr_Nota.FieldByName('EMP_IND_IE_DEST').AsString, 0) of
        1:Begin
            indIEDest := inContribuinte;
            IE := Qr_Nota.FieldByName('EMP_INSC_EST').AsString
          end;
        2:Begin
            indIEDest := inIsento;
          End;
        9:Begin
            indIEDest := inNaoContribuinte;
          End
        else
        Begin
          //Aqui vamos tentar corrigir o erro que tinha no tratamento destes dados...erro de indice x valor real
          if Length(Qr_Nota.FieldByName('EMP_CNPJ').AsString)>11 then
          bEGIN
            if Length(Qr_Nota.FieldByName('EMP_INSC_EST').AsString)>0 then
            Begin
              indIEDest := inContribuinte;
              IE := Qr_Nota.FieldByName('EMP_INSC_EST').AsString;
            End
            else
            Begin
              indIEDest := inNaoContribuinte;
            End;
          end
          ELSE
          bEGIN
            indIEDest := inNaoContribuinte;
          end;
        End
      end;
    end;
  End;
End;


procedure TFr_GeraNfe3x.PreencheCNPJAutorizados;
Var
  LcContador : TControllerContador;
  Lc_CNPj : String;
begin
  try
    LcContador := TControllerContador.create(nil);
    with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
    Begin
      Lc_CNPj := LcContador.getCNPJ;
      if (Lc_CNPj <> Dest.CNPJCPF) then
      Begin
        if Lc_CNPj <> '' then
          autXML.New.CNPJCPF := Lc_CNPj;
      End;
    End;
  finally
    FreeAndNil(LcContador);
  end;
end;

procedure TFr_GeraNfe3x.PreencheDanfeCasasDecimais;
Var
  Lc_Nr_CasaDecimal: Integer;
  Lc_Tam_CodPro: Integer;
  Lc_AuxInt: Integer;
  LcValor : Real;
BEgin
  with Qr_Itens do
  Begin
    First;
    Lc_Nr_CasaDecimal := 0;
    Fr_Principal.Nfe.DANFE.CasasDecimais.vUnCom := 2;
    while not Eof do
    begin
      LcValor := (FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').asfloat);
      Lc_Nr_CasaDecimal := Fc_NumeroCasaDecima(FloatToStrF(LcValor,ffFixed, 10, 6));
      if Lc_Nr_CasaDecimal > Fr_Principal.Nfe.DANFE.CasasDecimais.vUnCom then
        Fr_Principal.Nfe.DANFE.CasasDecimais.vUnCom := Lc_Nr_CasaDecimal;
      Next;
    end;
    // Define Quantas Casas Decimais para a Quantidade
    First;
    Lc_Nr_CasaDecimal := 0;
    Fr_Principal.Nfe.DANFE.CasasDecimais.qCom := 2;
    while not Eof do
    begin
      // Determina tamanho do campo codcódcódcódigo do produto
      Lc_AuxInt := Length(Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString) * 6;
      if (Lc_AuxInt > Lc_Tam_CodPro) then
        Lc_Tam_CodPro := Lc_AuxInt;
      Lc_Nr_CasaDecimal := Fc_NumeroCasaDecima(FloatToStrF( FieldByName('ITF_QTDE').asfloat, ffFixed, 10, 4));
      if Lc_Nr_CasaDecimal > Fr_Principal.Nfe.DANFE.CasasDecimais.qCom then
        Fr_Principal.Nfe.DANFE.CasasDecimais.qCom := Lc_Nr_CasaDecimal;
      Next;
    end;
    // Determina tamanho do campo codcódcódcódigo do produto
    First;
    Lc_Tam_CodPro := 43;
    while not Eof do
    begin
      // Determina tamanho do campo codcódcódcódigo do produto
      Lc_AuxInt := Length(Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString) * 6;
      if (Lc_AuxInt > Lc_Tam_CodPro) then
        Lc_Tam_CodPro := Lc_AuxInt;
      Next;
    end;
    Fr_Principal.Dfe_Fortes.LarguraCodProd := Lc_Tam_CodPro;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeItensProdServ(itens:Tprod; Item:Integer);
VAr
  Lc_Aux : String;
  Lc_Ok : Boolean;
  LcBenef : TControllerProductUfBenef;
  LcMarca : TControllerMarcaProduto;
  Lc_Valor : Real;
Begin
  with itens, Qr_Itens do
  Begin
    nItem := Item; // Número do item (1-990)
    CFOP := Qr_Icms.FieldByName('NAT_CFOP').AsString;
    cProd := FieldByName('PRO_CODIGOFAB').AsString;
    if Length(Trim( FieldByName('IAV_DESCRICAO').AsString)) > 0 then
      xProd := FieldByName('IAV_DESCRICAO').AsString
    else
      xProd := FieldByName('PRO_DESCRICAO').AsString;
    Lc_Aux := FieldByName('PRO_CODIGONCM').AsString;
    Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.', ',', '/', '-']);
    NCM := Lc_Aux;
    if not(FTipoOperacao = 'NFC-e') then
    Begin
      // Processo B2B - Para informar o numero do pedido de Compra
      if Trim( FieldByName('ITF_COMPRA').AsString) <> '' then
      Begin
        xPed      := FieldByName('ITF_COMPRA').AsString;
        nItemPed  := FieldByName('ITF_ITEM_COMPRA') .AsString;
      end;
    end;
    //Verifica se foi marcada a opção para não utilizar o codigo de Barras
    cEAN     := 'SEM GTIN';
    cEANTrib := 'SEM GTIN';
    if not FNaoUtilizarCodigoBarras then
    Begin
      // Verifica se o campo não é usado por Empresas do ramo de venda de Veiculos
      if not(Fc_Tb_Geral('L', 'PRO_G_LABEL_PRO', '') = 'S') then
      Begin
        // Verifica se tem o numero minimo de numeros do codigo de barras
        if (Length(Trim( FieldByName('PRO_CODIGOBAR').AsString))  >= 8) then
        Begin
          cEAN     := FieldByName('PRO_CODIGOBAR').AsString;
          cEANTrib := FieldByName('PRO_CODIGOBAR').AsString;
        end;
      end;
    End;

    // Campo CEST - Código Especificador da Substituição Tributária
    if (Trim( FieldByName('PRO_CEST').AsString) <> '') then
      CEST := FieldByName('PRO_CEST').AsString;
    // Unidade Comercial
    uCom := FieldByName('MED_ABREVIATURA').AsString;
    // Quantidade Comercial
    qCom := FieldByName('ITF_QTDE').asfloat;
    // Valor Unitário de comercialização
    vUnCom := FieldByName('ITF_VL_UNIT').AsCurrency;
    // Valor Total Bruto dos Produtos ou
    Lc_Valor := FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').AsFloat;
    Lc_Valor := RoundTo( Lc_Valor ,-2);

    vProd :=  StrToFloatDef(FloatToStrF( Lc_Valor, ffFixed, 10, 2),0);

    if ( StrtoIntDef( FieldByName('PRO_CODMED_TRIB').AsString,0)> 0 ) and
       ( FieldByName('PRO_QTDE_TRIB').asfloat > 0) then
    Begin
      // Unidade Tributável
      uTrib := getUnidadeTributavel(StrToIntDef( FieldByName('PRO_CODMED_TRIB').AsString,1));
      // Quantidade Tributável
      qTrib := FieldByName('ITF_QTDE').asfloat * FieldByName('PRO_QTDE_TRIB').asfloat;
      // Valor Unitário de tributação
      vUnTrib := FieldByName('ITF_VL_UNIT').AsCurrency / FieldByName('PRO_QTDE_TRIB').asfloat;
    End
    else
    Begin
      // Unidade Tributável
      uTrib := Qr_Itens.FieldByName('MED_ABREVIATURA').AsString;
      // Quantidade Tributável
      qTrib := Qr_Itens.FieldByName('ITF_QTDE').asfloat;
      // Valor Unitário de tributação
      vUnTrib := Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency;
    End;
    vDesc := Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    // Valor do Desconto
    vFrete := Qr_Icms.FieldByName('ICM_VL_FRETE').AsCurrency;
    vSeg := Qr_Icms.FieldByName('ICM_VL_SEGURO').AsCurrency;
    vOutro := Qr_Icms.FieldByName('ICM_VL_OUTRAS').AsCurrency;
    IF FieldByName('PRO_TIPO').AsString = 'S' then
      IndTot := StrToindTot(Lc_Ok, '0')
    else
      IndTot := StrToindTot(Lc_Ok, '1');

    indEscala := StrToIndEscala(lc_ok,Qr_Itens.FieldByName('indEscala').AsString);
    //Escala Relevante de produção
    if indEscala = ieNaoRelevante then
    Begin
      LcMarca := TControllerMarcaProduto.create(nil);
      try
        CNPJFab := LcMarca.GetCNPJFactory(Qr_Itens.FieldByName('PRO_CODMRC').AsInteger);
      finally
        FreeAndNil(LcMarca);
      end;

    End;
    //Codigo de Beneficio
    LcBenef := TControllerProductUfBenef.create(self);
    Try
      LcBenef.Registro.Produto  := Qr_Itens.FieldByName('ITF_CODPRO').AsInteger;
      LcBenef.Registro.estado   := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
      LcBenef.Registro.CST      := Qr_Icms.FieldByName('ICM_CST').AsString;
      LcBenef.getbyId;
      if LcBenef.exist then
        cBenef  := LcBenef.Registro.Beneficio
      else
        if informacaoSemBenefic then
          cBenef  := 'SEM CBENEF';
    Finally
      FreeAndNil(LcBenef);
    End;
    if Gb_Reforma_Tributaria then
    Begin
      {RFT
      // Indicador de fornecimento de bem móvel usado
      indBemMovelUsado := tieNenhum;

      // Valor total do Item, correspondente à sua participação no total da nota.
      // A soma dos itens deverá corresponder ao total da nota.



      Observação 1: Implementação Futura
      vItem := 100;
      }
    End;


  End;

End;
function  TFr_GeraNfe3x.PreencheDanfeProdInfoAdicLote(itens:Tprod; Item:Integer):String;
Begin
  Result := '';
  if FMostraLote then
  Begin
    // Informação de Lote
    Qr_lote.Active := False;
    Qr_lote.ParamByName('ITF_CODIGO').AsInteger :=  Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
    Qr_lote.Active := True;
    Qr_lote.FetchAll;
    Qr_lote.First;
    while not Qr_lote.Eof do
    Begin
      if PreencheLoteValid then
      Begin
        if MostraRastreioCompleto then
        Begin
          with itens.rastro.Add do
          Begin
            if MostraRastreioCompleto then
            Begin
              nLote :=  Qr_lote.FieldByName('CLT_NUMERO').AsString;
              dVal  :=  Qr_lote.FieldByName('clt_dt_vencimento').AsDateTime;
              Qr_LoteProduzido.Active := False;
              Qr_LoteProduzido.ParamByName('CLT_CODIGO').AsInteger := Qr_lote.FieldByName('CLT_CODIGO').AsInteger;
              Qr_LoteProduzido.Active := True;
              Qr_LoteProduzido.FetchAll;
              if ( Qr_LoteProduzido.RecordCount > 0 ) then
                dFab  :=  Qr_LoteProduzido.FieldByName('MLT_DATA').AsDateTime
              else
                dFab  :=  Qr_Lote.FieldByName('MLT_DATA').AsDateTime;
                qLote :=  Qr_lote.FieldByName('MLT_QTDE').AsFloat;
              cAgreg := '';
            End;
          end;
        end
        else
        Begin
          if (Qr_lote.Bof ) then
          Begin
            Result := concat(
                          Result,
                          'Lote/Validade(s): ',
                                Qr_lote.FieldByName('CLT_NUMERO').AsString,' | ',
                                Qr_lote.FieldByName('clt_dt_vencimento').AsString
                          );
          End
          else
          Begin
            Result := concat(
                          Result,
                          ' | ', Qr_lote.FieldByName('CLT_NUMERO').AsString,' | ',
                                Qr_lote.FieldByName('clt_dt_vencimento').AsString
                          );
          End;
        End;
      End
      else
      Begin
        if (Qr_lote.Bof ) then
        Begin
          Result := concat(
                        Result,
                        'Lote(s): ', Qr_lote.FieldByName('CLT_NUMERO').AsString
                        );
        End
        else
        Begin
          Result := concat(
                        Result,
                        ' | ', Qr_lote.FieldByName('CLT_NUMERO').AsString
                        );
        End;
      End;
      Qr_lote.Next;
    end;
  End;
End;

function TFr_GeraNfe3x.PreencheDanfeProdInfoAdicRTR(itens: Tprod;
  Item: Integer): String;
begin
  Result := '';
  Qr_Itens_RTR.Active := False;
  Qr_Itens_RTR.ParamByName('ITR_CODITF').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
  Qr_Itens_RTR.Active := True;
  Qr_Itens_RTR.FetchAll;
  Qr_Itens_RTR.First;
  while not Qr_Itens_RTR.eof do
  Begin
    if ((Qr_Itens.FieldByName('IAV_DESCRICAO').AsString <> Qr_Itens_RTR.FieldByname('ITR_DESCRICAO').asString)) then
      Result := concat(Result,Qr_Itens_RTR.FieldByname('ITR_DESCRICAO').asString,sLineBreak);
    Qr_Itens_RTR.Next;
  End;
end;

function TFr_GeraNfe3x.PreencheDanfeProdInfoAdicFCP(itens:Tprod; Item:Integer): String;
begin
  Result := '';
  // Abre a Tabela de ICMS - FCP
  Qr_FCP.Active := False;
  Qr_FCP.ParamByName('ITENS_NFL_ID').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
  Qr_FCP.Active := True;
  Qr_FCP.FetchAll;
  Qr_FCP.First;
  if Qr_fcp.recordCount > 0 then
  Begin
    REsult := Concat(
                'B.C.F.C.P : ',FloatToStrF(Qr_fcp.FieldByName('VBCFCP').asfloat,fffixed,10,2),' | ',
                '% F.C.P : ',FloatToStrF(Qr_fcp.FieldByName('PFCP').asfloat,fffixed,10,2),' | ',
                'V.F.C.P : ',FloatToStrF(Qr_fcp.FieldByName('VFCP').asfloat,fffixed,10,2)
                );
    if ( Qr_fcp.FieldByName('PFCPST').asfloat > 0 ) then
    Begin
     REsult := Concat(
                'B.C.F.C.P ST : ',FloatToStrF(Qr_fcp.FieldByName('VBCFCPST').asfloat,fffixed,10,2),' | ',
                '% F.C.P ST : ',FloatToStrF(Qr_fcp.FieldByName('PFCPST').asfloat,fffixed,10,2),' | ',
                'V.F.C.P ST : ',FloatToStrF(Qr_fcp.FieldByName('VFCPST').asfloat,fffixed,10,2)
                );
    End;
  End;
end;

function TFr_GeraNfe3x.PreencheDanfeProdInfoAdic(itens:Tprod; Item:Integer;imposto:TImposto):String;
Var
  LcRes : Boolean;
  LcItem : Integer;
Begin
  Result := '';
  // Observação do produto na Descrição da
  LcRes := (Fc_Tb_Geral('L', 'PRO_G_OBS_DESCRIC_NFE', 'S') = 'S');
  if LcRes then
    Result := concat(
                  Result,
                  Qr_Itens.FieldByName('PRO_DETALHES').AsString
                  );
  //Lote - preenchimento simples desvinculado com a tag de lote
  Result := concat(
                  Result,
                  PreencheDanfeProdInfoAdicLote(itens,Item)
                  );
  //Fundo de Combate a Pobreza
  Result := concat(
                  Result,
                  PreencheDanfeProdInfoAdicFCP(itens,Item)
                  );
  //Difal
  Result := concat(
                  Result,
                  PreencheDanfeProdInfoAdicDifal(imposto,Item)
                  );

  //Itens do Restaurante para detalhar o pedido
  Result := concat(
                  Result,
                  PreencheDanfeProdInfoAdicRTR(itens,Item)
                  );

  //IPI Devolvido
  LcItem := Fr_Principal.Nfe.NotasFiscais[0].NFe.Det.Count - 1;
  with Fr_Principal.Nfe.NotasFiscais[0].NFe.Det.Items[LcItem] do
  BEgin
    if (vIPIDevol > 0) then
    BEgin
      Result := concat(
                      Result,
                      ' | Aliq. IPI Devol. : ',FloatToStrF(pDevol,fffixed,10,2),
                      ' | Valor IPI Devol  : ',FloatToStrF(vIPIDevol,fffixed,10,2)
                );
    End;
  End;




  // Informação de Série do Produto
  Pc_Sql_Serie_Produto;
  Qr_Serie_Produto.Active := False;
  IF Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SI' THEN
    Qr_Serie_Produto.ParamByName('SRP_CODSAI').AsInteger :=  Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
  IF Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EI' THEN
    Qr_Serie_Produto.ParamByName('SRP_CODENT').AsInteger :=  Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
  Qr_Serie_Produto.Active := True;
  Qr_Serie_Produto.FetchAll;
  Qr_Serie_Produto.First;
  if Qr_Serie_Produto.recordcount > 0 then
  begin
    Result := concat(
                  Result,
                  Qr_Serie_Produto.FieldByName('SRP_DESCRICAO').AsString
              );
  end;

  //Detalhamento da ST.
  if (Fc_Tb_Geral('L', 'PRO_G_DET_ST_NFE', 'N') = 'S') then
  Begin
    Result := concat(
                  Result,
                  Fc_InfoSubTributariaItem(Qr_Itens.FieldByName('ITF_CODIGO').AsInteger)
              );
  end;
End;



function TFr_GeraNfe3x.PreencheDanfeProdInfoAdicDifal(imposto:TImposto;Item:Integer): String;
begin
  Result := '';
  if (imposto.ICMSUFDest.vICMSUFDest > 0 ) then
  Begin
    Result := concat('Total Difal: ' ,
                     FloatToStrf(imposto.ICMSUFDest.vBCUFDest,ffFixed,10,2),' X ',
                     FloatToStrf(imposto.ICMSUFDest.pICMSUFDest - imposto.ICMSUFDest.pICMSInter ,ffFixed,10,2),'% = ',
                     FloatToStrf(imposto.ICMSUFDest.vICMSUFDest,ffFixed,10,2)
    );
  End;
end;

procedure TFr_GeraNfe3x.PreencheDanfeImportacao(itens:Tprod);
Var
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  LcBase : TControllerBase;
Begin
  with itens do
  Begin
    Try
      LcBase := TcontrollerBase.create(nil);
      Lc_Qry_Aux := LcBase.GeraQuery;
      Lc_Qry := LcBase.GeraQuery;
      Lc_Qry.sql.Add(concat(
                      'Select  DIM_CODIGO,DIM_NUMERO, DIM_DIV, DIM_DATA,           ',
                      'DIM_LOCAL_DESEMB, UFE_SIGLA, DIM_DT_DESEMB, DIM_CODEXP      ',
                      'from TB_DEC_IMP                                             ',
                      '  inner join TB_UF                                          ',
                      '  ON (UFE_CODIGO = DIM_CODUFE)                              ',
                      'where DIM_CODITF = :DIM_CODITF                              '
                      ));
      Lc_Qry.ParamByName('DIM_CODITF').AsInteger :=  Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
      Lc_Qry.Active := True;
      Lc_Qry.FetchAll;
      Lc_Qry.First;
      if Lc_Qry.recordcount > 0 then
      Begin
        while not Lc_Qry.Eof do
        Begin
          with DI.Add do
          Begin
            nDi         := concat( Lc_Qry.FieldByName('DIM_NUMERO').AsString,
                           Lc_Qry.FieldByName('DIM_DIV').AsString
                        );
            dDi         := Lc_Qry.FieldByName('DIM_DATA').AsDateTime;
            xLocDesemb  := Lc_Qry.FieldByName('DIM_LOCAL_DESEMB').AsString;
            dDesemb     := Lc_Qry.FieldByName('DIM_DT_DESEMB').AsDateTime;
            UFDesemb    := Lc_Qry.FieldByName('UFE_SIGLA').AsString;
            cExportador := Lc_Qry.FieldByName('DIM_CODEXP').AsString;
            // Incluir as adições para cada DI
            Lc_Qry_Aux.SQL.Clear;
            Lc_Qry_Aux.sql.Add(concat(
                              'Select ADC_NUMERO, ADC_SEQUENCIA, ADC_CODFAB,      ',
                              'ADC_VL_DESC, ADC_PEDCPA, ADC_ITMCPA                ',
                              'from TB_ADIC_IMP                                   ',
                              'where ADC_CODDIM = :ADC_CODDIM                     '
                            ));
            Lc_Qry_Aux.ParamByName('ADC_CODDIM').AsInteger := Lc_Qry.FieldByName('DIM_CODIGO').AsInteger;
            Lc_Qry_Aux.Active := True;
            Lc_Qry_Aux.FetchAll;
            Lc_Qry_Aux.First;
            if Lc_Qry_Aux.RecordCount > 0 then
            Begin
              while not Lc_Qry_Aux.Eof do
              Begin
                with adi.Add do
                Begin
                  nAdicao     := StrToIntDef(Lc_Qry_Aux.FieldByName('ADC_NUMERO').AsString,0);
                  nSeqAdi     := StrToIntDef(Lc_Qry_Aux.FieldByName('ADC_SEQUENCIA').AsString,0);
                  cFabricante := Lc_Qry_Aux.FieldByName('ADC_CODFAB').AsString;
                  vDescDI     := StrToFloatDef( Lc_Qry_Aux.FieldByName('ADC_VL_DESC').asString,0);
                end;
                Lc_Qry_Aux.Next;
              end;
            End
            else
            Begin
              raise Exception.Create('Falta Adição na D.I');
            End;
          end;
          Lc_Qry.Next;
        end;
      end;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.FinalizaQuery(Lc_Qry_Aux);
      FreeAndNil(LcBase);
    End;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeVeiculosNovos(itens:Tprod);
Var
  Lc_Ok : Boolean;
Begin
  with itens,Qr_Serie_Veiculo do
  Begin
    Active := False;
    ParamByName('SRV_CODITF').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
    Active := True;
    FetchAll;
    First;
    if recordcount > 0 then
    Begin
      veicProd.tpOP     := StrTotpOP(Lc_Ok, FieldByName('SRV_TIPO_OPER').AsString);
      veicProd.chassi   := FieldByName('SRV_CHASSI').AsString;
      veicProd.cCor     := FieldByName('SRV_NUMCOR').AsString;                  // Código de cor de cada montadora
      veicProd.xCor     := FieldByName('SRV_DESCCOR').AsString;                 // Descrição da Cor
      veicProd.pot      := FieldByName('SRV_POTMOTOR').AsString; // Potencia do motor em Cavalo Vapor
      veicProd.Cilin    := FieldByName('SRV_CILINDRADA').AsString; // Clindradas
      veicProd.pesoB    := FieldByName('SRV_PESOBRT').AsString; // em toneladas - 4 casas decimais
      veicProd.pesoL    := FieldByName('SRV_PESOLIQ').AsString; // em toneladas - 4 casas decimais
      veicProd.nSerie   := FieldByName('SRV_SERIE').AsString; // Serial (série)
      veicProd.tpComb   := FieldByName('SRV_TPCOMB').AsString;
      veicProd.nMotor   := FieldByName('SRV_NMOTOR').AsString; // Numero do Motor
      veicProd.CMT      := FieldByName('SRV_POTCM3').AsString;
      // CMT-Capacidade Máxima de Tração - em Toneladas 4 casas decimais (v2.0)
      veicProd.dist     := FieldByName('SRV_DISTEIXO').AsString;
      // Distancia entre Eixos - em metros - 4 casas decimais
      veicProd.anoMod   := FieldByName('SRV_ANOMOD').AsInteger; // Ano Modelo de Fabricação
      veicProd.anoFab   := FieldByName('SRV_ANOFAB').AsInteger; // Ano de Fabricação
      veicProd.tpPint   := FieldByName('SRV_TPPINTURA').AsString; // Tipo de Pintura
      veicProd.tpVeic   := FieldByName('SRV_CODTPV').AsInteger; // Tipo de Veículo - Utilizar Tabela RENAVAM
      veicProd.espVeic  := FieldByName('SRV_CODEPV').AsInteger; // Utilizar Tabela RENAVAM
      veicProd.VIN      := FieldByName('SRV_VIN').AsString;
      // Informa-se o veículo tem VIN (chassi) remarcado. R-Remarcado N-Normal
      veicProd.condVeic := StrTocondVeic(Lc_Ok,FieldByName('SRV_COND_VEIC').AsString);
      veicProd.cMod     := FieldByName('SRV_CODMRMD').AsString; // Utilizar Tabela RENAVAM
      veicProd.cCor     := FieldByName('SRV_CODCOR').AsString;
      veicProd.lota     := FieldByName('SRV_LOTA').AsInteger;
      veicProd.tpRest   := FieldByName('SRV_CODRTV').AsInteger;
    end;
  End;
End;


procedure TFr_GeraNfe3x.PreencheResponsabelTécnico;
var
  Lc_Sigla : String;
begin
  ConfigResponsabelTécnico;
  with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
  Begin
    infRespTec.CNPJ := '07742094000113';
    infRespTec.xContato := 'Florisvaldo Domingues de Souza';
    infRespTec.email := 'valdo@setes.com.br';
    infRespTec.fone := '41999112072';
    Lc_Sigla := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
  End;
end;


procedure TFr_GeraNfe3x.PreencheDanfeImpostoAproximado(imposto:TImposto);
Var
  Lc_InformaTRibAprox: Boolean;
  Lc_Vl_BaseImpostoAprox: Real;
Begin
  with imposto,Qr_Itens do
  Begin
    Lc_InformaTRibAprox := (Fc_Tb_Geral('L', 'GRL_G_IMPOSTO_APROX', 'S') = 'S');
    if Lc_InformaTRibAprox then
    Begin
      if pos('VENDA', Upper(Qr_Nota.FieldByName('NAT_DESCRICAO').AsString)) > 0 then
      Begin
          Lc_Vl_BaseImpostoAprox := ((
                                      FieldByName('ITF_VL_UNIT').AsCurrency *
                                      FieldByName('ITF_QTDE').asfloat) -
                                      FieldByName('ITF_VL_DESC').AsCurrency);
          Lc_Vl_BaseImpostoAprox := roundTo(Lc_Vl_BaseImpostoAprox,-2);
          vTotTrib := (Lc_Vl_BaseImpostoAprox * FieldByName('ITF_IMP_APROX').asfloat) / 100;
          vTotTrib := roundTo(vTotTrib, -2);
      end;
    End;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeImpostoRegimeNormal(imposto:TImposto);
Var
  Lc_Ok : Boolean;
Begin
  with imposto, Qr_Icms do
  Begin
    // Define o Codigo de situação tributaria
    ICMS.CST      := StrToCSTICMS( FieldByName('ICM_CST').AsString);
    //Retenção do ICMS ST
    ICMS.vBCSTRet         := 0;
    ICMS.pST              := 0;
    ICMS.vICMSSubstituto  := 0;
    ICMS.vICMSSTRet       := 0;

    // Tributação do ICMS - 00 Tributada integralmente
    if ICMS.CST = cst00 then
    Begin
      ICMS.modBC  := StrTomodBC(Lc_Ok,FieldByName('ICM_MD_BC_NR').AsString);
      ICMS.vBC    := FieldByName('ICM_VL_BC_NR').AsCurrency;
      ICMS.pICMS  := FieldByName('ICM_AQ_NR').AsCurrency;
      ICMS.pRedBC := FieldByName('ICM_AQ_RD_NR').AsCurrency;
      ICMS.vICMS  := FieldByName('ICM_VL_NR').AsCurrency;
    end;
    // Tributação do ICMS - 10 - Tributada e com cobrança do ICMS por substituição tributária
    if ICMS.CST = cst10 then
    Begin
      // ICMS Normal
      ICMS.modBC  := StrTomodBC(Lc_Ok, FieldByName('ICM_MD_BC_NR').AsString);
      ICMS.vBC    := FieldByName('ICM_VL_BC_NR').AsCurrency;
      ICMS.pICMS  := FieldByName('ICM_AQ_NR').AsCurrency;
      ICMS.pRedBC := FieldByName('ICM_AQ_RD_NR').AsCurrency;
      ICMS.vICMS  := FieldByName('ICM_VL_NR').AsCurrency;
      // ICMS Normal S.T
      ICMS.modBCST  := StrTomodBCST(Lc_Ok, FieldByName('ICM_MD_BC_ST').AsString);
      ICMS.pMVAST   := ( FieldByName('ICM_MG_VA_ST').asfloat -1 ) *100;
      ICMS.pRedBCST := FieldByName('ICM_AQ_RD_BC_ST').asfloat;
      ICMS.vBCST    := FieldByName('ICM_VL_BC_ST').AsCurrency;
      ICMS.pICMSST  := FieldByName('ICM_AQ_ST').asfloat;
      ICMS.vICMSST  := FieldByName('ICM_VL_ST').AsCurrency;
    end;
    // Tributação do ICMS - 20 - Com redução de base de cálculo
    if ICMS.CST = cst20 then
    Begin
      ICMS.modBC  := StrTomodBC(Lc_Ok, FieldByName('ICM_MD_BC_NR').AsString);
      ICMS.vBC    := FieldByName('ICM_VL_BC_NR').AsCurrency;
      ICMS.pICMS  := FieldByName('ICM_AQ_NR').AsCurrency;
      ICMS.pRedBC := FieldByName('ICM_AQ_RD_NR').AsCurrency;
      ICMS.vICMS  := FieldByName('ICM_VL_NR').AsCurrency;
    end;
    // Tributação do ICMS - 30 - Isenta ou não tributada e com cobrança do ICMS por substituição tributária
    if ICMS.CST = cst30 then
    Begin
      // ICMS Normal S.T
      ICMS.modBCST  := StrTomodBCST(Lc_Ok, FieldByName('ICM_MD_BC_ST').AsString);
      ICMS.pMVAST   := ( FieldByName('ICM_MG_VA_ST').asfloat -1 ) *100;
      ICMS.pRedBCST := FieldByName('ICM_AQ_RD_BC_ST').asfloat;
      ICMS.vBCST    := FieldByName('ICM_VL_BC_ST').AsCurrency;
      ICMS.pICMSST  := FieldByName('ICM_AQ_ST').asfloat;
      ICMS.vICMSST  := FieldByName('ICM_VL_ST').AsCurrency;
    end;
    // Tributação do ICMS - 40 - Isenta 41 - Não tributada 50 - Suspensão
    if (ICMS.CST = cst40) or (ICMS.CST = cst41) or (ICMS.CST = cst50)
    then
    Begin
      if FieldByName('ICM_CODDSI').AsInteger > 0 then
      Begin
        ICMS.vICMS      := FieldByName('ICM_VL_NR').AsCurrency;
        ICMS.motDesICMS := StrTomotDesICMS(Lc_Ok, FieldByName('ICM_CODDSI').AsString);
      end;
    end;
    // Tributação do ICMS - 51 - Diferimento  A exigência do preenchimento das informações do ICMS diferido fica a critério de cada UF.
    if ICMS.CST = cst51 then
    Begin
      // ICMS Normal
      ICMS.modBC    := StrTomodBC(Lc_Ok,FieldByName('ICM_MD_BC_NR').AsString);
      ICMS.vBC      := FieldByName('ICM_VL_BC_NR').AsCurrency;
      ICMS.pICMS    := FieldByName('ICM_AQ_NR').AsCurrency;
      ICMS.vICMSOp  := ICMS.vBC * ( ICMS.pICMS  / 100);
      ICMS.vICMSOp  := RoundTo( ICMS.vICMSOp ,-2);
      ICMS.pDif     := FieldByName('ICM_AQ_DIF').asfloat;
      icms.vICMSDif := FieldByName('ICM_VL_DIF').AsCurrency;

      ICMS.vICMS    := FieldByName('ICM_VL_NR').AsCurrency;
      ICMS.vICMS    := RoundTo( ICMS.vICMS,-2);
      icms.vICMSSTRet := 0;
     end;
    // Tributação do ICMS - 60 - ICMS cobrado anteriormente por substituição tributária
    if ICMS.CST = cst60 then
    Begin
      ICMS.vBCSTRet := 0;
      ICMS.vICMSSTRet := 0;
          //desenvolvido em 07/05 e em 08/05 a receita revogou a liberação
          //ver implementação na tributação bloco onde verifica se existe tributação
          //ICMS.orig já preenchido em outro local
          CtrlICMSST.Registro.Estabelecimento := Gb_CodMha;
          CtrlICMSST.Registro.Destino :=  Qr_Icms.FieldByName('ICM_CODITF').asinteger;
          CtrlICMSST.GetByDestino;
          if CtrlICMSST.exist then
          Begin
            ICMS.vBCSTRet         := CtrlICMSST.Registro.ValorBaseSTRetido;
            ICMS.pST              := CtrlICMSST.Registro.AliqST;
            ICMS.vICMSSubstituto  := CtrlICMSST.Registro.ValorICMSSubstituto;
            ICMS.vICMSSTRet       := CtrlICMSST.Registro.ValorICMSSTRetido;
          End;

    end;
    // Tributação do ICMS - 70 - Com redução de base de cálculo e  cobrança do ICMS por substituição tributária
    if ICMS.CST = cst70 then
    Begin
      // ICMS Normal
      ICMS.modBC    := StrTomodBC(Lc_Ok, FieldByName('ICM_MD_BC_NR').AsString);
      ICMS.pRedBC   := FieldByName('ICM_AQ_RD_BC_NR').asfloat;
      ICMS.vBC      := FieldByName('ICM_VL_BC_NR').AsCurrency;
      ICMS.pICMS    := FieldByName('ICM_AQ_NR').AsCurrency;
      ICMS.pRedBC   := FieldByName('ICM_AQ_RD_NR').AsCurrency;
      ICMS.vICMS    := FieldByName('ICM_VL_NR').AsCurrency;
      // ICMS Normal S.T
      ICMS.modBCST  := StrTomodBCST(Lc_Ok, FieldByName('ICM_MD_BC_ST').AsString);
      ICMS.pMVAST   := ( FieldByName('ICM_MG_VA_ST').asfloat -1 ) *100;
      ICMS.pRedBCST := FieldByName('ICM_AQ_RD_BC_ST').asfloat;
      ICMS.vBCST    := FieldByName('ICM_VL_BC_ST').AsCurrency;
      ICMS.pICMSST  := FieldByName('ICM_AQ_ST').asfloat;
      ICMS.vICMSST  := FieldByName('ICM_VL_ST').AsCurrency;
    end;
    // Tributação do ICMS - 90 É Outros
    if ICMS.CST = cst90 then
    Begin
      // ICMS Normal
      ICMS.modBC  := StrTomodBC(Lc_Ok, FieldByName('ICM_MD_BC_NR').AsString);
      ICMS.pRedBC := FieldByName('ICM_AQ_RD_BC_NR').asfloat;
      ICMS.vBC    := FieldByName('ICM_VL_BC_NR').AsCurrency;
      ICMS.pICMS  := FieldByName('ICM_AQ_NR').AsCurrency;
      ICMS.pRedBC := FieldByName('ICM_AQ_RD_NR').AsCurrency;
      ICMS.vICMS  := FieldByName('ICM_VL_NR').AsCurrency;
      // ICMS Normal S.T
      ICMS.modBCST  := StrTomodBCST(Lc_Ok, FieldByName('ICM_MD_BC_ST').AsString);
      ICMS.pMVAST   := ( FieldByName('ICM_MG_VA_ST').asfloat -1 ) *100;
      ICMS.pRedBCST := FieldByName('ICM_AQ_RD_BC_ST').asfloat;
      ICMS.vBCST    := FieldByName('ICM_VL_BC_ST').AsCurrency;
      ICMS.pICMSST  := FieldByName('ICM_AQ_ST').asfloat;
      ICMS.vICMSST  := FieldByName('ICM_VL_ST').AsCurrency;
    end;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeImpostoSimplesNacional(imposto:TImposto);
Var
  Lc_Ok : Boolean;
  procedure ZeraValoresICMS;
  Begin
    with  Imposto do
    Begin
      ICMS.vBC      := 0;
      ICMS.pICMS    := 0;
      ICMS.pRedBC   := 0;
      ICMS.vICMS    := 0;
    End;
  End;
  procedure ZeraValoresST;
  Begin
    with  Imposto do
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
  with imposto, Qr_Icms do
  Begin
    // ICMS Normal
    ICMS.modBC  := StrTomodBC(Lc_Ok, FieldByName('ICM_MD_BC_NR').AsString);
    ICMS.pRedBC := FieldByName('ICM_AQ_RD_BC_NR').asfloat;
    ICMS.vBC    := FieldByName('ICM_VL_BC_NR').AsCurrency;
    ICMS.pICMS  := FieldByName('ICM_AQ_NR').AsCurrency;
    ICMS.pRedBC := FieldByName('ICM_AQ_RD_NR').AsCurrency;
    ICMS.vICMS  := FieldByName('ICM_VL_NR').AsCurrency;
    // ICMS Normal S.T
    ICMS.modBCST  := StrTomodBCST(Lc_Ok, FieldByName('ICM_MD_BC_ST').AsString);
    ICMS.pMVAST   := ( FieldByName('ICM_MG_VA_ST').asfloat -1 ) *100;
    ICMS.pRedBCST := FieldByName('ICM_AQ_RD_BC_ST').asfloat;
    ICMS.vBCST    := FieldByName('ICM_VL_BC_ST').AsCurrency;
    ICMS.pICMSST  := FieldByName('ICM_AQ_ST').asfloat;
    ICMS.vICMSST  := FieldByName('ICM_VL_ST').AsCurrency;
    ICMS.pCredSN := roundTo(FieldByName('ICM_AQ_CALC_CRED').asfloat, -2);
    //Retenção do ICMS ST
    ICMS.vBCSTRet         := 0;
    ICMS.pST              := 0;
    ICMS.vICMSSubstituto  := 0;
    ICMS.vICMSSTRet       := 0;

    // Alíquota aplicável de cálculo do crédito (Simples Nacional).
    ICMS.vCredICMSSN :=roundTo(FieldByName('ICM_VL_CRED_APRO').AsCurrency, -2);
    // Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)

    // Verifica se há tributação pelo Simples Nacional
    ICMS.CSOSN := StrToCSOSNIcms(Qr_Icms.FieldByName('ICM_CSOSN').AsString);
    // Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=101 (v.2.0)
    if (ICMS.CSOSN = csosn101) then
    Begin
      ZeraValoresST;
      exit;
    end;
    // Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=102, 103, 300
    if (ICMS.CSOSN = csosn102) or (ICMS.CSOSN = csosn103) or
      (ICMS.CSOSN = csosn300)  then
    Begin
      ZeraValoresST;
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;
    // Tributação do ICMS pelo SIMPLES NACIONAL e 400
    if (ICMS.CSOSN = csosn400) then
    Begin
      ZeraValoresST;
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;


    // 201- Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por Substituição Tributária v.2.0)
    if (ICMS.CSOSN = csosn201) then
    Begin
      //ICMS Normal S.T já calculada no inicio do processo
      //ICMS Normal - Zera os valores depois de feito o calculo
      ZeraValoresICMS;
      exit;
    end;
    // 202- Tributada pelo Simples Nacional sem permissão de  crédito e com cobrança do ICMS por Substituição Tributária
    // 203- Isenção do ICMS nos Simples Nacional para faixa de receita bruta e com cobrança do ICMS por Substituição Tributária  (v.2.0)
    if (ICMS.CSOSN = csosn202) OR (ICMS.CSOSN = csosn203) then
    Begin
      //ICMS Normal S.T já calculada no inicio do processo
      //ICMS Normal - Zera os valores depois de feito o calculo
      ZeraValoresICMS;
      //credito ICMS
      ICMS.pCredSN     := 0;
      ICMS.vCredICMSSN := 0;
      exit;
    end;
    // 500 É ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação (v.2.0)
    if (ICMS.CSOSN = csosn500) then
    Begin
      ZeraValoresST;
              //desenvolvido em 07/05 e em 08/05 a receita revogou a liberação
              //ver implementação na tributação bloco onde verifica se existe tributação
              //ICMS.orig já preenchido em outro local
              CtrlICMSST.Registro.Estabelecimento := Gb_CodMha;
              CtrlICMSST.Registro.Destino :=  Qr_Icms.FieldByName('ICM_CODITF').asinteger;
              CtrlICMSST.GetByDestino;
              if CtrlICMSST.exist then
              Begin
                ICMS.vBCSTRet         := CtrlICMSST.Registro.ValorBaseSTRetido;
                ICMS.pST              := CtrlICMSST.Registro.AliqST;
                ICMS.vICMSSubstituto  := CtrlICMSST.Registro.ValorICMSSubstituto;
                ICMS.vICMSSTRet       := CtrlICMSST.Registro.ValorICMSSTRetido;
              end;
      exit;
    end;
    // Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=900 (v2.0)
    if (ICMS.CSOSN = csosn900) then
    Begin
      exit;
    end;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeICMS(imposto:TImposto);
Var
  Lc_Ok : Boolean;
Begin
  with imposto do
  BEgin
    // Origem da Mercadoria
    ICMS.orig := StrToOrig( Qr_Icms.FieldByName('ICM_ORIGEM').AsString);
    // Codigo de Regime Tributario 1/2 - Simples nacional e 3 Regime normal
    ICMS.CST := cstVazio;
    if (Gb_Cd_Crt = 2) or (Gb_Cd_Crt = 3) then
      PreencheDanfeImpostoRegimeNormal(Imposto)
    else
      PreencheDanfeImpostoSimplesNacional(Imposto);
  End;
End;


procedure TFr_GeraNfe3x.PreencheDanfePartilhaFCP(Emit:TEmit;Ide:TIde;Dest:TDest;Prod:TProd;imposto:TImposto);
Var
  Lc_Aq_Icms_Partilha : Real;
Begin
  // Abre a Tabela de ICMS - FCP
  Qr_FCP.Active := False;
  Qr_FCP.ParamByName('ITENS_NFL_ID').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
  Qr_FCP.Active := True;
  Qr_FCP.FetchAll;
  Qr_FCP.First;
  with imposto do
  BEgin
    ICMSUFDest.pFCPUFDest   := 0;
    ICMSUFDest.vFCPUFDest   := 0;
    ICMSUFDest.vBCFCPUFDest := 0;
    ICMSUFDest.pICMSInterPart := 0;
    ICMSUFDest.vICMSUFDest    := 0;
    ICMSUFDest.vICMSUFRemet   := 0;

    // NA. Item / ICMS para a UF de Destino
    if ( Ide.modelo     =   55)                 and
       ( Ide.tpNF       =   tnSaida)            and
       ( Ide.idDest     =   doInterestadual)    and
       ( Ide.indFinal   =   cfConsumidorFinal)  and
       //( Dest.indIEDest =   inNaoContribuinte)  and aqui deve aceitar contribuinte e nao contribuinte
       ( Ide.finNFe     <>  fnDevolucao)       then
    Begin
      // Valor da BC do ICMS na UF de destino
      if ICMS.vBC > 0 then
        ICMSUFDest.vBCUFDest := ICMS.vBC
      else
       ICMSUFDest.vBCUFDest := (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
      //Aliquota Interestadual origem para destino que vem da Regra...
      ICMSUFDest.pICMSInter := ICMS.pICMS;
      // Alíquota interna da UF de destino
      DM.Qr_Uf_Mva_NCM.Active := False;
      DM.Qr_Uf_Mva_NCM.ParamByName('UFE_CODIGO').AsInteger := Qr_Nota.FieldByName('UFE_CODIGO').AsInteger;
      DM.Qr_Uf_Mva_NCM.Active := True;
      DM.Qr_Uf_Mva_NCM.First;
      ICMSUFDest.pICMSUFDest := DM.Qr_Uf_Mva_NCM.FieldByName('UFE_ALIQ_INTERNA').asfloat;
      //Caso seja do simples e não tenha na regra precisamos pegar do estado
      if ICMSUFDest.pICMSInter = 0 then
        ICMSUFDest.pICMSInter := DM.Qr_Uf_Mva_NCM.FieldByName('UFE_ALIQ_INT_EST').asfloat;
      // Calcula a Diferença  entre a alíquota interna do Estado destinatário e a alíquota interestadual;
      if (ICMSUFDest.pICMSUFDest > ICMSUFDest.pICMSInter) then
        Lc_Aq_Icms_Partilha := ICMSUFDest.pICMSUFDest - ICMSUFDest.pICMSInter
      else
        Lc_Aq_Icms_Partilha := ICMSUFDest.pICMSInter - ICMSUFDest.pICMSUFDest;

      // Percentual de ICMS Interestadual para a UF de destino: - 40% em 2016; - 60% em 2017; - 80% em 2018; - 100% a partir de 2019.
      ICMSUFDest.pICMSInterPart := 100.00;
      // Valor do ICMS Interestadual para a UF de destino
      ICMSUFDest.vICMSUFDest :=   ( (ICMSUFDest.vBCUFDest * Lc_Aq_Icms_Partilha) / 100) * 1;
      ICMSUFDest.vICMSUFDest := roundTo(ICMSUFDest.vICMSUFDest, -2);
      // Valor do ICMS Interestadual para a UF do remetente
      ICMSUFDest.vICMSUFRemet :=  ((ICMSUFDest.vBCUFDest * Lc_Aq_Icms_Partilha) / 100) * 0.0;
      ICMSUFDest.vICMSUFRemet := roundTo(  ICMSUFDest.vICMSUFRemet, -2 );

      //Se existe esse registro e por que passou por validacao na geracao dele
      if Qr_fcp.recordCount > 0 then
      Begin
        // Percentual do ICMS relativo ao Fundo de Combate à Pobreza (FCP) na UF de destino
        ICMSUFDest.pFCPUFDest   := Qr_fcp.FieldByName('PFCP').asfloat;
        // Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP) da UF de destino
        ICMSUFDest.vFCPUFDest   := Qr_fcp.FieldByName('VFCP').asfloat;
        ICMSUFDest.vBCFCPUFDest := Qr_fcp.FieldByName('VBCFCP').asfloat;
        //ICMS Normal
        ICMS.vBCFCP             := Qr_fcp.FieldByName('VBCFCP').asfloat;
        ICMS.pFCP               := Qr_fcp.FieldByName('PFCP').asfloat;
        ICMS.vFCP               := Qr_fcp.FieldByName('VFCP').asfloat;
        //ICMS ST
        ICMS.vBCFCPST           := Qr_fcp.FieldByName('VBCFCPST').asfloat;
        ICMS.pFCPST             := Qr_fcp.FieldByName('PFCPST').asfloat;
        ICMS.vFCPST             := Qr_fcp.FieldByName('VFCPST').asfloat;
      End;
    End;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeIPI(imposto:TImposto);
Var
  Lc_Ok : Boolean;
Begin
  with imposto, Qr_IPI do
  Begin
    // Define a Situação tributária do IPI COM ISENTA PARA NA SEQUENCIA FOR SETADA AS VARIAVEIS SE HOUVER
    Close;
    ParamByName('ITF_CODIGO').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
    Active := True;
    FetchAll;
    First;
    if not IsEmpty then
    begin
      // Define a Situação Tributaria do IPI
      IPI.CST := StrToCSTIPI(Lc_Ok, FieldByName('TBI_GRUPO').AsString);
      IPI.cEnq := '109';

      // Tabela a ser criada pela RFB, informar 999 enquanto a tabela não for criada
      if (IPI.CST = ipi00) or (IPI.CST = ipi49) or (IPI.CST = ipi50) or(IPI.CST = ipi99) then
      Begin
        if (FieldByName('IPI_AQ_NR').AsCurrency > 0) then
        Begin
          IPI.vBC   := FieldByName('IPI_VL_BC').AsCurrency;
          IPI.pIPI  := FieldByName('IPI_AQ_NR').AsCurrency;
          IPI.vIPI  := FieldByName('IPI_VL_UNID').AsCurrency;
          /// IPI.vBC * (IPI.pIPI/100);
        end
        else
        Begin
          IPI.qUnid := FieldByName('IPI_QT_UNID').AsCurrency;
          IPI.vUnid := FieldByName('IPI_VL_UNID').AsCurrency;
        end;
      END;
    end;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeIPIDevolvido;
VAr
  LcItem : Integer;
Begin
  Qr_DevolIpi.Active := False;
  Qr_DevolIpi.ParamByName('order_item_id').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
  Qr_DevolIpi.Active := True;
  Qr_DevolIpi.FetchAll;
  if Qr_DevolIpi.recordCount > 0 then
  Begin
    LcItem := Fr_Principal.Nfe.NotasFiscais[0].NFe.Det.Count - 1;
    with Fr_Principal.Nfe.NotasFiscais[0].NFe.Det.Items[LcItem] do
    BEgin
      pDevol    := Qr_DevolIpi.FieldByName('P_IPI').AsCurrency;
      vIPIDevol := Qr_DevolIpi.FieldByName('V_IPI').AsCurrency;
    End;
  End;
End;


procedure TFr_GeraNfe3x.PreencheDanfeII(imposto:TImposto);
BEgin
  with imposto, Qr_II do
  BEgin
    Close;
    ParamByName('ITF_CODIGO').AsInteger :=  Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
    Active := True;
    FetchAll;
    First;
    if not IsEmpty then
    begin
      II.vBC      := FieldByName('IIP_VL_BASE').AsCurrency;
      II.vDespAdu := FieldByName('IIP_VL_DESP_AD').AsCurrency;
      II.vII      := FieldByName('IIP_VL_II').AsCurrency;
      II.vIOF     := FieldByName('IIP_VL_IOF').AsCurrency;
    end;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfePIS(imposto:TImposto);
Var
  Lc_Ok : Boolean;
Begin
  WITH imposto,Qr_Pis  DO
  Begin
    // Define a Situação tributária do PISPIS COM ISENTA PARA NA SEQUENCIA FOR SETADA AS VARIAVEIS SE HOUVER
    PIS.CST := pis07;
    PIS.vBC := 0;
    PIS.pPIS := 0;
    PIS.vPIS := 0;

    // valores do PIS
    Close;
    ParamByName('ITF_CODIGO').AsInteger :=  Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
    Active := True;
    FetchAll;
    First;
    if not IsEmpty then
    begin
      // Define a Situação tributária do PISPIS
      PIS.CST := StrToCSTPIS( FieldByName('TBP_GRUPO').AsString);
      if (PIS.CST = pis01) OR (PIS.CST = pis02) then
      Begin
        PIS.vBC   := FieldByName('PIS_VL_BC').AsCurrency;
        PIS.pPIS  := FieldByName('PIS_AQ_NR').AsCurrency;
        PIS.vPIS  := FieldByName('PIS_VL_NR').AsCurrency;
      end;
      if (PIS.CST = pis03) then
      Begin
        PIS.qBCProd   := FieldByName('PIS_QT_VDA').AsCurrency;
        PIS.vAliqProd := FieldByName('PIS_VL_AQ').AsCurrency;
        PIS.vPIS      := FieldByName('PIS_VL_NR').AsCurrency;
      end;
      if (PIS.CST = pis99) then
      Begin
        if (FieldByName('PIS_VL_BC').AsCurrency > 0) then
        Begin
          PIS.vBC   := FieldByName('PIS_VL_BC').AsCurrency;
          PIS.pPIS  := FieldByName('PIS_AQ_NR').AsCurrency;
        end
        else
        Begin
          PIS.qBCProd   := FieldByName('PIS_QT_VDA').AsCurrency;
          PIS.vAliqProd := FieldByName('PIS_VL_AQ').AsCurrency;
        end;
      end
      else
      Begin
        PIS.vBC   := FieldByName('PIS_VL_BC').AsCurrency;
        PIS.pPIS  := FieldByName('PIS_AQ_NR').AsCurrency;
        PIS.vPIS  := FieldByName('PIS_VL_NR').AsCurrency;
      End;
    End;
  end;
end;

procedure TFr_GeraNfe3x.PreencheDanfeCOFINS(imposto:TImposto);
Var
  Lc_Ok : Boolean;
Begin
  WITH imposto,Qr_Pis  DO
  Begin
    // Define a Situação tributária do COFINS COM ISENTA PARA NA SEQUENCIA FOR SETADA AS VARIAVEIS SE HOUVER
    COFINS.CST := cof07;
    COFINS.vBC := 0;
    COFINS.pcofins := 0;
    COFINS.vCOFINS := 0;

    // valores do Cofins
    Qr_Cofins.Close;
    Qr_Cofins.ParamByName('ITF_CODIGO').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
    Qr_Cofins.Active := True;
    Qr_Cofins.FetchAll;
    Qr_Cofins.First;
    if not Qr_Cofins.IsEmpty then
    begin
      // Define a Situação tributária do COFINS
      COFINS.CST := StrToCSTCOFINS( Qr_Cofins.FieldByName('TBC_GRUPO').AsString);
      if (COFINS.CST = cof01) OR (COFINS.CST = cof02) then
      Begin
        COFINS.vBC := Qr_Cofins.FieldByName('CFS_VL_BC').AsCurrency;
        COFINS.pcofins := Qr_Cofins.FieldByName('CFS_AQ_NR').asfloat;
        COFINS.vCOFINS := Qr_Cofins.FieldByName('CFS_VL_NR').AsCurrency;
      end;
      if (COFINS.CST = cof03) then
      Begin
        COFINS.qBCProd := Qr_Cofins.FieldByName('CFS_QT_UNID').asfloat;
        COFINS.vAliqProd := Qr_Cofins.FieldByName('CFS_VL_AQ').AsCurrency;
        COFINS.vCOFINS := Qr_Cofins.FieldByName('CFS_VL_NR').AsCurrency;
      end;
      if (COFINS.CST = cof99) then
      Begin
        if (Qr_Pis.FieldByName('PIS_VL_BC').AsCurrency > 0) then
        Begin
          COFINS.vBC := Qr_Cofins.FieldByName('CFS_VL_BC').AsCurrency;
          COFINS.pcofins := Qr_Cofins.FieldByName('CFS_AQ_NR').asfloat;
        end
        else
        Begin
          COFINS.qBCProd := Qr_Cofins.FieldByName('CFS_QT_UNID').asfloat;
          COFINS.vAliqProd := Qr_Cofins.FieldByName('CFS_VL_AQ').AsCurrency;
        end;
        COFINS.vCOFINS := Qr_Cofins.FieldByName('CFS_VL_NR').AsCurrency;
      end
      else
      Begin
        COFINS.vBC := Qr_Cofins.FieldByName('CFS_VL_BC').AsCurrency;
        COFINS.pcofins := Qr_Cofins.FieldByName('CFS_AQ_NR').asfloat;
        COFINS.vCOFINS := Qr_Cofins.FieldByName('CFS_VL_NR').AsCurrency;
      End;
    end;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeISSQN(imposto:TImposto);
Var
  Lc_Ok : Boolean;
Begin
  WITH imposto,Qr_Pis  DO
  Begin
    if FNfConjugada then
    Begin
      // valores do ISSQN
      Qr_Issqn.Close;
      Qr_Issqn.ParamByName('ITF_CODIGO').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
      Qr_Issqn.Active := True;
      Qr_Issqn.FetchAll;
      Qr_Issqn.First;
      Imposto.ISSQN.cSitTrib := ISSQNcSitTribVazio;
      if not Qr_Issqn.IsEmpty then
      begin
        Imposto.ISSQN.vBC := Qr_Issqn.FieldByName('ISS_VL_BC').AsCurrency;
        Imposto.ISSQN.vDeducao := Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
        Imposto.ISSQN.vAliq := Qr_Issqn.FieldByName('ISS_AQ_NR').AsCurrency;
        Imposto.ISSQN.vISSQN := Qr_Issqn.FieldByName('ISS_VL_NR').AsCurrency;
        Imposto.ISSQN.cMunFG := Qr_Issqn.FieldByName('ISS_MUN_IBGE').AsInteger;
        Imposto.ISSQN.cListServ := Qr_Issqn.FieldByName('ISS_LST_SRV').AsString;
        Imposto.ISSQN.vISSRet := Qr_Issqn.FieldByName('ISS_VL_RET').AsCurrency;
        if Imposto.ISSQN.vISSRet > 0 then
          ISSQN.indISSRet := StrToindISSRet(Lc_Ok, '1')
        else
          ISSQN.indISSRet := StrToindISSRet(Lc_Ok, '2');
        ISSQN.indISS := StrToindISS(Lc_Ok,IntToStr(StrToIntdef(Qr_Nota.FieldByName('CLI_ISS_EXIGIB').AsString, 0) + 1));
        ISSQN.cServico := Qr_Itens.FieldByName('ITF_CODPRO').AsString;
        ISSQN.cMunFG := Qr_Nota.FieldByName('CDD_IBGE').AsInteger;

        ISSQN.cPais := Qr_Nota.FieldByName('END_PAIS').AsInteger;

        ISSQN.nProcesso := Qr_Nota.FieldByName('CLI_ISS_NR_PROCESSO').AsString;

        if (Qr_Nota.FieldByName('CLI_ISS_IND_INC_FISCAL').AsString = 'S') then
          ISSQN.indIncentivo := StrToindIncentivo( '1')
        else
          ISSQN.indIncentivo := StrToindIncentivo( '2');
      end;
    end;

  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeTotalizador;
Var
  Lc_I : Integer;
  Lc_Ok : Boolean;
Begin
  with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
  Begin
    Total.ICMSTot.vBC := 0;
    For Lc_I := 0 to (Det.Count - 1) do
    Begin
      with Total.ICMSTot do
      Begin
        vTotTrib      := vTotTrib     + Det.Items[Lc_I].Imposto.vTotTrib;

        vIPIDevol     := vIPIDevol    + Det.Items[Lc_I].vIPIDevol;

        IF Det.Items[Lc_I].Prod.IndTot = (StrToindTot(Lc_Ok, '1')) then
          vProd       := vProd        + Det.Items[Lc_I].Prod.vProd;
        vBC           := vBC          + Det.Items[Lc_I].Imposto.ICMS.vBC;
        vICMS         := vICMS        + Det.Items[Lc_I].Imposto.ICMS.vICMS;


        vBCST         := vBCST        + Det.Items[Lc_I].Imposto.ICMS.vBCST;
        vST           := vST          + Det.Items[Lc_I].Imposto.ICMS.vICMSST;

        vFCP          := vFCP         + Det.Items[Lc_I].Imposto.ICMS.vFCP;
        vFCPST        := vFCPST       + Det.Items[Lc_I].Imposto.ICMS.vFCPST;
        vFCPSTRet     := vFCPSTRet    + Det.Items[Lc_I].Imposto.ICMS.vFCPSTRet;

        vFCPUFDest    := vFCPUFDest   + Det.Items[Lc_I].Imposto.ICMSUFDest.vFCPUFDest;
        vICMSUFDest   := vICMSUFDest  + Det.Items[Lc_I].Imposto.ICMSUFDest.vICMSUFDest;
        vICMSUFRemet  := vICMSUFRemet + Det.Items[Lc_I].Imposto.ICMSUFDest.vICMSUFRemet;


        vDesc         := vDesc        + Det.Items[Lc_I].Prod.vDesc;
        vFrete        := vFrete       + Det.Items[Lc_I].Prod.vFrete;
        vSeg          := vSeg         + Det.Items[Lc_I].Prod.vSeg;
        vOutro        := vOutro       + Det.Items[Lc_I].Prod.vOutro;
        vII           := vII          + Det.Items[Lc_I].Imposto.II.vII;
        vIPI          := vIPI         + Det.Items[Lc_I].Imposto.IPI.vIPI;
        vPIS          := vPIS         + Det.Items[Lc_I].Imposto.PIS.vPIS;
        vCOFINS       := vCOFINS      + Det.Items[Lc_I].Imposto.COFINS.vCOFINS;
      End;
      if Gb_Reforma_Tributaria then
      Begin
       {RFT -
        //O grupo de valores totais da NF-e deve ser informado com o somatório do campo correspondente dos itens.
        O IS é "por fora", por isso seu valor deve ser adicionado ao valor total da NF}
        Total.ISTot.vIS                           := Total.ISTot.vIS                          + Det.Items[Lc_I].Imposto.ISel.vIS;

        //O grupo de valores totais da NF-e deve ser informado com o somatório do campo correspondente dos itens. O IBS e a CBS são "por fora", por isso seus valores devem ser adicionados ao valor total da NF
        with Total.IBSCBSTot do
        Begin
          vBCIBSCBS                 := vBCIBSCBS                + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.vBC;

          gIBS.vIBS                 := gIBS.vIBS                + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gTribRegular.vTribRegIBSUF;
          gIBS.vCredPres            := gIBS.vCredPres           + Det.Items[Lc_I].Imposto.IBSCBS.gCredPresOper.gIBSCredPres.vCredPres;
          gIBS.vCredPresCondSus     := gIBS.vCredPresCondSus    + Det.Items[Lc_I].Imposto.IBSCBS.gCredPresOper.gIBSCredPres.vCredPresCondSus;

          gIBS.gIBSUFTot.vDif       := gIBS.gIBSUFTot.vDif      + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.vDif;
          gIBS.gIBSUFTot.vDevTrib   := gIBS.gIBSUFTot.vDevTrib  + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSUF.gDevTrib.vDevTrib;
          gIBS.gIBSUFTot.vIBSUF     := gIBS.gIBSUFTot.vIBSUF    + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSUF.vIBSUF;

          gIBS.gIBSMunTot.vDif      := gIBS.gIBSMunTot.vDif     + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.vDif;
          gIBS.gIBSMunTot.vDevTrib  := gIBS.gIBSMunTot.vDevTrib + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSMun.gDevTrib.vDevTrib;
          gIBS.gIBSMunTot.vIBSMun   := gIBS.gIBSMunTot.vIBSMun  + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gIBSMun.vIBSMun;

          gCBS.vDif                 := gCBS.vDif                + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gCBS.gDif.vDif;
          gCBS.vDevTrib             := gCBS.vDevTrib            + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gCBS.gDevTrib.vDevTrib;
          gCBS.vCBS                 := gCBS.vCBS                + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBS.gCBS.vCBS;
          gCBS.vCredPres            := gCBS.vCredPres           + Det.Items[Lc_I].Imposto.IBSCBS.gCredPresOper.gCBSCredPres.vCredPres;
          gCBS.vCredPresCondSus     := gCBS.vCredPresCondSus    + Det.Items[Lc_I].Imposto.IBSCBS.gCredPresOper.gCBSCredPres.vCredPresCondSus;

          gMono.vIBSMono            := gMono.vIBSMono           + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoPadrao.vIBSMono;
          gMono.vIBSMono            := gMono.vCBSMono           + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoPadrao.vCBSMono;
          gMono.vIBSMonoReten       := gMono.vIBSMonoReten      + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoReten.vIBSMonoReten;
          gMono.vCBSMonoReten       := gMono.vCBSMonoReten      + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoReten.vCBSMonoReten;
          gMono.vIBSMonoRet         := gMono.vIBSMonoRet        + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoRet.vIBSMonoRet;
          gMono.vCBSMonoRet         := gMono.vCBSMonoRet        + Det.Items[Lc_I].Imposto.IBSCBS.gIBSCBSMono.gMonoRet.vCBSMonoRet;
        End;
      end;
      // Valor total da NF-e com IBS / CBS / IS
      Total.vNFTot := Total.IBSCBSTot.gIBS.vIBS + Total.IBSCBSTot.gCBS.vCBS + Total.ISTot.vIS ;
    End;

    // Verifica se a Nota É Conjugada
    if FNfConjugada then
    Begin
      Total.ISSQNtot.vServ := 0;
      Total.ISSQNtot.vBC := 0;
      Total.ISSQNtot.vISS := 0;
      Total.ISSQNtot.vISSRet := 0;
      Total.ISSQNtot.vDeducao := 0;
      For Lc_I := 0 to (Det.Count - 1) do
      Begin
        IF (Det.Items[Lc_I].Prod.IndTot = StrToindTot(Lc_Ok, '2')) then
        Begin
          Total.ISSQNtot.vServ    := Total.ISSQNtot.vServ + Det.Items[Lc_I].Imposto.ISSQN.vBC + Det.Items[Lc_I].Imposto.ISSQN.vDeducao;
          Total.ISSQNtot.vBC      := Total.ISSQNtot.vBC + Det.Items[Lc_I].Imposto.ISSQN.vBC;
          Total.ISSQNtot.vISS     := Total.ISSQNtot.vISS + Det.Items[Lc_I].Imposto.ISSQN.vISSQN;
          Total.ISSQNtot.vISSRet  := Total.ISSQNtot.vISSRet + Det.Items[Lc_I].Imposto.ISSQN.vISSRet;
          Total.ISSQNtot.vDeducao := Total.ISSQNtot.vDeducao + Det.Items[Lc_I].Imposto.ISSQN.vDeducao;
          Total.ISSQNtot.dCompet  := Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsDateTime;
        end;
      end;
    end;
    // Verifica esta parte quando tiver que somar o ICMS na nota Jetlink e serviço né conjugado
    IF (Fc_Tb_Geral('L', 'OSR_G_ATIVAR', 'N') = 'N') then
    Begin
      Total.ICMSTot.vNF := Qr_Nota.FieldByName('NFL_VL_TL_NOTA').AsCurrency
    end
    else
    Begin
      if (FNfConjugada) then
        Total.ICMSTot.vNF := Qr_Nota.FieldByName('NFL_VL_TL_NOTA').AsCurrency
      else
        Total.ICMSTot.vNF := (Total.ICMSTot.vST + Total.ICMSTot.vProd   +
                              Total.ICMSTot.vFrete + Total.ICMSTot.vSeg +
                              Total.ICMSTot.vOutro + Total.ICMSTot.vIPI +
                              Total.ICMSTot.vIPIDevol) - (Total.ICMSTot.vDesc);
    end;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeTransportadora;
Var
  Lc_Ok : Boolean;
  Lc_Aux : String;
Begin
  if (FTipoOperacao = 'NFC-e') then
  Begin
    with Fr_Principal.Nfe.NotasFiscais[0].Nfe.Transp, DM.Qr_Estabelecimento do
    Begin
      if (Qr_RetornoNFCe.FieldByName('NFC_IND_PRES').AsString = '1') then
      Begin
        modFrete := mfSemFrete
      End
      else
      Begin
        modFrete := mfContaEmitente;
        IF Length(Trim(FieldByName('EMP_CNPJ').AsString)) = 11 then
        Begin
          Transporta.CNPJCPF := FieldByName('EMP_CNPJ').AsString;
        end
        else
        Begin
          Transporta.CNPJCPF  := FieldByName('EMP_CNPJ').AsString;
          Transporta.IE       := FieldByName('EMP_INSC_EST').AsString;
        end;
        Transporta.xNome  := Copy(FieldByName('EMP_NOME').AsString, 1, 60);
        Transporta.xEnder := FieldByName('END_ENDER').AsString + ', '+ FieldByName('END_NUMERO').AsString;
        Transporta.xMun   := FieldByName('CDD_DESCRICAO').AsString;
        Transporta.UF     := UpperCase(FieldByName('UFE_SIGLA').AsString);
      end;
    End;
  end
  else
  Begin
    Pc_AtivaTransportadora(StrToIntDef(Qr_Nota.FieldByName('NFL_CODTRP').AsString,0));
    with Fr_Principal.Nfe.NotasFiscais[0].Nfe.Transp, DM.Qr_Transportadora do
    Begin
      if not IsEmpty then
      begin
        IF Length(Trim(FieldByName('EMP_CNPJ').AsString)) = 11 then
        Begin
          Transporta.CNPJCPF := FieldByName('EMP_CNPJ').AsString;
        end
        else
        Begin
          Transporta.CNPJCPF  := FieldByName('EMP_CNPJ').AsString;
          Transporta.IE       := FieldByName('EMP_INSC_EST').AsString;
        end;
        Transporta.xNome  := Copy(FieldByName('EMP_NOME').AsString, 1, 60);
        Transporta.xEnder := FieldByName('END_ENDER').AsString + ', '+ FieldByName('END_NUMERO').AsString;
        Transporta.xMun   := FieldByName('CDD_DESCRICAO').AsString;
        Transporta.UF     := UpperCase(FieldByName('UFE_SIGLA').AsString);
      end;

      modFrete := StrTomodFrete(Lc_Ok, Qr_Nota.FieldByName('MDF_GRUPO').AsString);

      if Trim(Qr_Nota.FieldByName('NFL_PLC_VEICULO').AsString) <> '' then
      begin
        Lc_Aux := Qr_Nota.FieldByName('NFL_PLC_VEICULO').AsString;
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.', ',', '/', '-', ' ']);
        veicTransp.placa  := Lc_Aux;
        veicTransp.UF     := UpperCase(Qr_Nota.FieldByName('NFL_PLC_UF').AsString);
        veicTransp.RNTC   := Qr_Nota.FieldByName('NFL_PLC_RNTC').AsString;
      end;

      if (StrToIntDef(Qr_Nota.FieldByName('NFL_QT_PRODUTO').AsString,0) > 0) then
      Begin
        with Vol.Add do
        begin
          qVol := StrToIntDef(Qr_Nota.FieldByName('NFL_QT_PRODUTO').AsString,0);
          esp := Qr_Nota.FieldByName('NFL_ESPECIE').AsString;
          marca := Qr_Nota.FieldByName('NFL_MARCA').AsString;
          if (StrToFloatDef(Qr_Nota.FieldByName('NFL_PESO_LIQ').AsString,0) > 0) then
            pesoL := StrToFloatDef(Qr_Nota.FieldByName('NFL_PESO_LIQ').AsString, 0);
          if (StrToFloatDef(Qr_Nota.FieldByName('NFL_PESO_BRUTO').AsString, 0)> 0) then
            pesoB := StrToFloatDef(Qr_Nota.FieldByName('NFL_PESO_BRUTO').AsString, 0);
          nVol := Qr_Nota.FieldByName('NFL_VOL_NUMERO').AsString;
          // Lacres.Add.nLacre := '';
        end;
      end;
    End;
  end;
End;

procedure TFr_GeraNfe3x.PreencheDanfeFormaPagto;
Var
  Lc_Ok : Boolean;
  lcSaldoTroco : REal;
  Lc_Tef : TControllerTefMovimento;
BEgin
  // Verifica se é uma NF de Saida
  with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
  Begin
    //Definição padrão
    if ( (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SI') or (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SC') ) then
      Ide.tpNF := tnSaida
    else
      Ide.tpNF := tnEntrada;
    with pag.Add do
    begin
      indPag  := ipNenhum;
      tPag    := fpSemPagamento;
      vPag    := 0;
      tpIntegra := tiNaoInformado;
    end;
    //Verifica se é uma saida e se forma de pagamento
    if ( Qr_Nota.FieldByName('PED_TIPO').AsString = '1') and
       ( (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SI') or (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SC') ) then
    Begin
      Ide.tpNF := tnSaida;
      pag.Clear;
      NotaFiscal.Registro.codigo := It_Cd_Nota;
      if NotaFiscal.VerificaServico and ( not FNfConjugada)  then
      Begin
        with pag.Add do
        begin
          if (Copy(Qr_Nota.FieldByName('PED_PRAZO').AsString, 1, 3) = '000')then
          Begin
            indPag := ipVista;
            tPag := fpDinheiro;
          End
          else
          Begin
            indPag := ipPrazo;
            tPag := fpDepositoBancario;
          End;
          if (NotaFiscal.valorFinanceiro - Qr_Nota.FieldByName('NFL_VL_TL_SRV').AsCurrency) <0  then
            vPag :=  Qr_Nota.FieldByName('NFL_VL_TL_PROD').AsCurrency -  NotaFiscal.ValorProdutoDesconto
          else
            vPag :=  NotaFiscal.valorFinanceiro - Qr_Nota.FieldByName('NFL_VL_TL_SRV').AsCurrency;
        end;
      end
      else
      Begin
        with pag.Add do
        Begin
          Qr_Financeiro.Active := False;
          Qr_Financeiro.ParamByName('FIN_CODNFL').AsInteger := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
          Qr_Financeiro.Active := True;
          Qr_Financeiro.FetchAll;
          Qr_Financeiro.First;
          if not Qr_Financeiro.IsEmpty then
          Begin
            lcSaldoTroco := ValorTroco;
            pag.Clear;
            while not Qr_Financeiro.Eof do
            Begin
               with pag.Add do // PAGAMENTOS apenas para NFC-e
              begin
                if (Qr_Financeiro.FieldByName('FIN_DT_VENCIMENTO').AsDatetime = Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsDateTime) then
                  indPag := ipVista
                else
                  indPag := ipPrazo;

                tPag := StrToFormaPagamento(Lc_Ok,Qr_Financeiro.FieldByName('FPT_TIPO_NFCE').AsString);
                if (Qr_Financeiro.FieldByName('FPT_TIPO_NFCE').AsString = '03') or
                   (Qr_Financeiro.FieldByName('FPT_TIPO_NFCE').AsString = '04') or
                   (Qr_Financeiro.FieldByName('FPT_TIPO_NFCE').AsString = '17') then
                Begin
                  Lc_Tef := TControllerTefMovimento.Create(Self);
                  Try
                    Lc_Tef.Registro.Estabelecimento := Gb_Codmha;
                    Lc_Tef.Registro.CodigoPedido :=  Qr_Financeiro.FieldByName('FIN_CODPED').AsInteger;
                    Lc_Tef.GetById;
                    if (Lc_Tef.exist) then
                    Begin
                      tpIntegra := tiPagIntegrado;
                      if (Pos('VISA',Upper(Lc_tef.registro.Rede))>0) then
                      Begin
                        tBand := bcVisa;
                      End
                      else
                      if (Pos('MASTERCARD',Upper(Lc_tef.registro.Rede))>0) then
                      Begin
                        tBand := bcMasterCard;
                      End
                      else
                      Begin
                        tBand := bcOutros;
                      End;
                      CNPJ := '04988631000111';
                      cAut := Lc_tef.registro.Nsu;
                    End
                    else
                    Begin
                      tpIntegra := tiPagNaoIntegrado;
                      tBand := bcOutros;
                    End;
                  Finally
                    FreeAndNil(Lc_Tef);
                  End;
                End
                else
                Begin
                  tpIntegra := tiNaoInformado;
                End;

                vPag := Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency;
                //altera o valor do pagamento em dinheiro para alinhar com o troco
                if (Pos('DINHEIRO',Trim(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString))>0) then
                Begin
                  if lcSaldoTroco > 0 then
                  BEgin
                    vPag := Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency + lcSaldoTroco;
                    lcSaldoTroco := 0;
                  End;
                End;
              end;
              Qr_Financeiro.Next;
            end;
            if ValorTroco > 0 then
            Begin
              pag.vTroco := ValorTroco;
            End;
          End
          else
          Begin
            indPag := ipVista;
            tPag := fpDinheiro;
            vPag :=  Qr_Nota.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
          End;
        End;
      end;
    End;
  End;
End;

procedure TFr_GeraNfe3x.PreencheDanfeCobranca;
Var
  Lc_Ok : Boolean;
  Lc_I : Integer;
BEgin
  Qr_Financeiro.Active := False;
  Qr_Financeiro.ParamByName('FIN_CODNFL').AsInteger := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
  Qr_Financeiro.Active := True;
  Qr_Financeiro.FetchAll;
  if Qr_Financeiro.recordCount = 0 then exit;

  // Verifica se é uma NF de Saida
  with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
  Begin
    if ( Qr_Nota.FieldByName('PED_TIPO').AsString = '1') and
       ( (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SI') or (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SC') ) then
    Begin
      Ide.tpNF := tnSaida;
      Cobr.Fat.nFat   := IntToStr(It_Nr_Nota);
      NotaFiscal.Registro.codigo := It_Cd_Nota;
      if NotaFiscal.VerificaServico and ( not FNfConjugada)  then
      Begin
        if(Qr_Financeiro.FieldByName('FIN_DT_VENCIMENTO').AsDateTime > Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsDateTime ) then
        Begin
          if (NotaFiscal.valorFinanceiro - Qr_Nota.FieldByName('NFL_VL_TL_SRV').AsCurrency) <0  then
            Cobr.Fat.vOrig  := Qr_Nota.FieldByName('NFL_VL_TL_PROD').AsCurrency - NotaFiscal.ValorProdutoDesconto
          else
            Cobr.Fat.vOrig  := NotaFiscal.valorFinanceiro - Qr_Nota.FieldByName('NFL_VL_TL_SRV').AsCurrency;
          Cobr.Fat.vLiq   := Cobr.Fat.vOrig;
          Cobr.Fat.vDesc  := 0;
          with Cobr.Dup.Add do
          Begin
            nDup  := StrZero(1,3,0);
            if Qr_Financeiro.RecordCount > 0 then
              dVenc := Qr_Financeiro.FieldByName('FIN_DT_VENCIMENTO').AsDateTime
            else
              dVenc := Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsDateTime;
            vDup  := Cobr.Fat.vOrig;
          End;
        end;
      End
      else
      Begin
        // Carregar as duplicatas -
        If (DM.Qr_Nf_Eletronica.FieldByName('NFE_DFE_DUP').AsString = 'S') then
        Begin
          if Qr_Financeiro.RecordCount > 0 then
          Begin
            //Se contiver mais de uma parcela informar deve colocar todas as parcelas incluse a vista
            if Qr_Financeiro.RecordCount > 1 then
            Begin
              Qr_Financeiro.First;
              Lc_I:= 0;
              while not Qr_Financeiro.Eof do
              Begin
                inc(Lc_I);
                with Cobr.Dup.Add do
                Begin
                  nDup  := StrZero(Lc_I,3,0);
                  dVenc := Qr_Financeiro.FieldByName('FIN_DT_VENCIMENTO').AsDateTime;
                  vDup  := Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency;

                  Cobr.Fat.vOrig  := Cobr.Fat.vOrig + Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency;
                  Cobr.Fat.vLiq   := Cobr.Fat.vLiq  + Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency;
                  Cobr.Fat.vDesc  := 0;
                end;
                Qr_Financeiro.Next;
              end;
            end
            else
            Begin
              //Com apenas uma parcela verificamos se se ela é avista e se deseja ocultar
              if(Qr_Financeiro.FieldByName('FIN_DT_VENCIMENTO').AsDateTime > Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsDateTime ) then
              BEgin
                with Cobr.Dup.Add do
                Begin
                  nDup  := StrZero(1,3,0);
                  dVenc := Qr_Financeiro.FieldByName('FIN_DT_VENCIMENTO').AsDateTime;
                  vDup  := Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency;
                  Cobr.Fat.vOrig  := Cobr.Fat.vOrig + Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency;
                  Cobr.Fat.vLiq   := Cobr.Fat.vLiq  + Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency;
                  Cobr.Fat.vDesc  := 0;
                end;
              End;
            End;
          End;
        end;
      End;
    end;
  End;

End;

procedure TFr_GeraNfe3x.PreencheDanfeInfAdic;
begin
End;

procedure TFr_GeraNfe3x.PreencheDanfeCombustivel(itens: Tprod);
Var
  Lc_Ok : Boolean;
Begin
  with itens,Qr_Combustivel do
  Begin
    Active := False;
    ParamByName('tb_order_items_id').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
    Active := True;
    FetchAll;
    First;
    if recordcount > 0 then
    Begin
      //FieldByName('TB_ORDER_ITEMS_ID').AsInteger
      comb.cProdANP := FieldByName('CODIF').AsInteger;
      //comb.pMixGN
      comb.descANP := FieldByName('DESCRIPTION').AsString;

//      comb.pGLP
//      comb.pGNn
//      comb.pGNi
//      comb.vPart
//      comb.CODIF

      comb.qTemp  := FieldByName('QTEMP').AsFloat;
      comb.UFcons := FieldByName('UFCONS').AsString;

//      comb.CIDE.qBCProd
//      comb.CIDE.vAliqProd
//      comb.CIDE.vCIDE
//      comb.ICMS.vBCICMS
//      comb.ICMS.vICMS
//      comb.ICMS.vBCICMSST
//      comb.ICMS.vICMSST
//      comb.ICMSInter.vBCICMSSTDest
//      comb.ICMSInter.vICMSSTDest
//      comb.ICMSCons.vBCICMSSTCons
//      comb.ICMSCons.vICMSSTCons
//      comb.ICMSCons.UFcons
//      comb.encerrante.nBico
//      comb.encerrante.nBomba
//      comb.encerrante.nTanque
//      comb.encerrante.vEncIni
//      comb.encerrante.vEncFin

    end;
  End;

end;

procedure TFr_GeraNfe3x.PreencheDanfeComercioExterior;
Begin
  with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
  Begin
    if (Copy(Det[0].Prod.CFOP, 1, 1) = '7') then // CFOP de Exportação (inicia por 7)
    Begin
      Pc_AtivaEstabelecimento;
      exporta.UFembarq      := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
      exporta.xLocEmbarq    := DM.Qr_Estabelecimento.FieldByName('CDD_DESCRICAO').AsString;
      exporta.UFSaidaPais   := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
      exporta.xLocExporta   := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
      exporta.xLocDespacho  := DM.Qr_Estabelecimento.FieldByName('CDD_DESCRICAO').AsString;

    end;
  End;
End;


function TFr_GeraNfe3x.Pc_PreencheDadosDanfe(Pc_Oper_Consulta: Boolean):Boolean;
Var
  Lc_Aux: String;
  Lc_Ok: Boolean;
  Lc_Obs: TMemo;
  Lc_Nr_Item: Integer;

  Lc_I: Integer;
  Lc_Aq_Icms_Partilha: Real;
Begin
  //Não aplicar o DisposeOf quando o create for Self
  CtrlICMSST := TControllerCtrlIcmsST.create(Self);
  REsult := True;
  Lc_Obs := TMemo.Create(self);
  Lc_Obs.Visible := False;
  Lc_Obs.Parent := self;
  Lc_Obs.Width := 600;
  // ========================== A - Dados da Nota Fiscal eletrônica =========================================
  // Componente está tratando
  // ========================== B - Identificação da Nota Fiscal eletrônica =================================

  Fr_Principal.Nfe.NotasFiscais.Clear;
  //Fr_Principal.Nfe.NotasFiscais[0].NFe.autXML
  with Fr_Principal.Nfe.NotasFiscais.Add.Nfe do
  begin

    infNFe.ID := IntToStr(It_Nr_Nota);
    PreencheDanfeIde(Ide,Pc_Oper_Consulta);
    // ========================== C - Identificação do Emitente da Nota Fiscal eletrônica =========================
    PreencheDanfeEmi(Emit,Pc_Oper_Consulta);
    // ========================== D - Identificação do Fisco Emitente da NF-e ===============================

    // ========================== E - Identificação do Destinatário da Nota Fiscal eletrônica =========================
    PreencheDanfeDes(Dest,Pc_Oper_Consulta);
    // ========================== F - Identificação do Local de Retirada ====================================

    // ========================== G - Identificação do Local de Entrega =====================================
    Pc_IdentificaEntrega( Qr_Nota.FieldByName('EMP_CODIGO').AsInteger,Entrega);
    // ========================== Definie quantas casas decimais ============================================
    Pc_SelecionaItensNota(Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);
    // Define Quantas Casas Decimais para o Valor
    PreencheDanfeCasasDecimais;
    // ========================== H - Detalhamento de Produtos e Serviços da NF-e ===========================

    // ========================== I - Produtos e Serviços da NF-e ===========================================
    Qr_Itens.First;
    Lc_Nr_Item := 0;
    while not Qr_Itens.Eof do
    begin
      with Det.Add do
      Begin
        // Abre a Tabela de ICMS
        Qr_Icms.Active := False;
        Qr_Icms.ParamByName('ICM_CODITF').AsInteger := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
        try
          Qr_Icms.Active := True;
        except
          Qr_Icms.Active := True;
        end;
        Qr_Icms.FetchAll;
        Qr_Icms.First;
        //Devolução do IPI
        PreencheDanfeIPIDevolvido;
        //Produtos
        Lc_Nr_Item := Lc_Nr_Item + 1;
        PreencheDanfeItensProdServ(Prod,Lc_Nr_Item);

        {FRT -  Referenciamento de item de outro Documento Fiscal Eletrônico - DF-e

        DFeReferenciado.chaveAcesso := '';
        DFeReferenciado.nItem := 1;}


        // ==========================  Tag da Declaração de Importação ==========================
        PreencheDanfeImportacao(Prod);
        // ==========================  J - Detalhamento Específico de Veículos novos ==========================
        PreencheDanfeVeiculosNovos(Prod);
        // ==========================  K - Detalhamento Específico de Medicamento e de matérias-primas farmacêuticas =========================

        // ==========================  L - Detalhamento Específico de Armamentos ==============================

        // ==========================  L1 - Detalhamento Específico de Combustíveis ===========================
        PreencheDanfeCombustivel(Prod);

        // ==========================  M - Tributos incidentes no Produto ou Serviço ==========================
        //Imposto Aproximado
        PreencheDanfeImpostoAproximado(Imposto);
        with Imposto do
        Begin
          if not Qr_Icms.IsEmpty then
          Begin
            // ========================== N - ICMS Normal e ST ==================================================
            if (Ide.finNFe = fnAjuste) then
              Ide.natOp := '999 Estorno de NF-e não cancelada no prazo legal'
            else
              Ide.natOp := Qr_Icms.FieldByName('NAT_RESUMIDO').AsString;
            PreencheDanfeICMS(imposto);
            //Grupo de Partilha do ICMS
            if (Gb_Cd_Crt = 2) or (Gb_Cd_Crt = 3) then
              PreencheDanfePartilhaFCP(Emit,Ide,Dest,Prod,imposto);

            // ========================== O - Imposto sobre Produtos Industrializados ===========================
            PreencheDanfeIPI(Imposto);
            // ========================== P - Imposto de Importação =============================================
            PreencheDanfeII(Imposto);
            // ========================== Q É PIS ===============================================================
            PreencheDanfePIS(Imposto);
            // ========================== R É PIS ST ============================================================

            // ========================== S É COFINS ============================================================
            PreencheDanfeCOFINS(Imposto);
            // ========================== T - COFINS ST =========================================================

            // ========================== U - ISSQN =============================================================
            PreencheDanfeISSQN(Imposto);
            //Grupo UB. Informações dos tributos IBS / CBS e Imposto Seletivo
            {Exceção: Não se aplica à NFe de devolução de mercadorias (tag: finNFe = 4) ou NFe complementar (tag: finfe = 2) que referencia NFe com data de emissão anterior a 2026.}
            if Gb_Reforma_Tributaria then
            Begin
              ImpostoSeletivo(Imposto);

              ImpostoIBSCBS(Imposto);
            End;
          end;
        end;
       //Informações Adicionais
        infAdProd := PreencheDanfeProdInfoAdic(Prod,Lc_Nr_Item,Imposto);

        Qr_Itens.Next;
      end;
    end;
    // ========================== V - Informações adicionais ============================================
    // tratado na tag I - Produtos e Serviços da NF-e
    // ========================== W - Valores Totais da NF-e ================================================
    PreencheDanfeTotalizador;
    // ======================s==== X - Informações do Transporte da NF-e =====================================
    PreencheDanfeTransportadora;
    // ========================== Y É Dados da Cobrança =====================================================
    PreencheDanfeFormaPagto;
    if not (TipoOperacao = 'NFC-e') then
      PreencheDanfeCobranca;

    // ========================== Z - Informações Adicionais da NF-e ========================================
    PreencheDanfeInfAdic;
    // ========================== ZA - Informações de Comércio Exterior =====================================
    PreencheDanfeComercioExterior;
    // ========================== ZB - Informações de Compras ===============================================

    // ========================== ZC - Informações do Registro de Aquisição de Cana =========================

    // ========================== ZZ - Informações da Assinatura Digital ====================================
    PreencheResponsabelTécnico;
    PreencheCNPJAutorizados;
  end;
end;

procedure TFr_GeraNfe3x.Pc_IdentificaEntrega(Lc_Codigo: Integer;dfent:TEntrega);
var
  Lc_SqlTxt: String;
  Lc_Cd_Endereco, Lc_Cd_Entrega: Integer;
  Lc_qt_Endereco: Integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TcontrollerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := concat(
                      'SELECT END_CODIGO, END_PRINCIPAL ',
                      'FROM TB_ENDERECO EDD             ',
                      ' WHERE END_CODEMP =:END_CODEMP   '
                      );
      sql.Add(Lc_SqlTxt);
      ParamByName('END_CODEMP').AsInteger := Lc_Codigo;
      Active := True;
      FetchAll;
      First;
      Lc_qt_Endereco := recordcount;
      if Lc_qt_Endereco > 1 then
        Locate('END_PRINCIPAL', 'S', []);
      Lc_Cd_Endereco := FieldByName('END_CODIGO').AsInteger;
      Lc_Codigo := It_Cd_Nota;

      Active := False;
      sql.Clear;
      Lc_SqlTxt := '';
      Lc_SqlTxt := concat(
                      'SELECT END_CODIGO, END_CNPJ,  END_ENDER, END_COMPLEM,     ',
                      'END_BAIRRO, END_CEP, CDD.CDD_DESCRICAO,CDD.CDD_IBGE,      ',
                      'UFE.UFE_SIGLA,END_NUMERO, PED_CODEND, EMP_NOME,EMP_EMAIL, ',
                      ' EMP_INSC_EST, PAI_CODBACEN,PAI_DESCRICAO,END_FONE        ',
                      ' FROM TB_ENDERECO EDD                                     ',
                      '  INNER JOIN TB_EMPRESA EP                                ',
                      '  ON (EP.EMP_CODIGO = EDD.END_CODEMP)                     ',
                      '  INNER JOIN TB_CIDADE CDD                                ',
                      '  ON (CDD.CDD_CODIGO = EDD.END_CODCDD)                    ',
                      '  INNER JOIN TB_UF UFE                                    ',
                      '  ON (UFE.UFE_CODIGO = EDD.END_CODUFE)                    ',

                      '  INNER JOIN TB_PAIS PA                                   ',
                      '  ON (PA.PAI_CODBACEN = EDD.END_PAIS)                     ',

                      '  INNER JOIN TB_PEDIDO PED                                ',
                      '  ON (PED.PED_CODEND = EDD.END_CODIGO)                    ',
                      '  INNER JOIN TB_NOTA_FISCAL NFL                           ',
                      '  ON (NFL.NFL_CODPED = PED.PED_CODIGO)                    ',
                      'WHERE NFL.NFL_CODIGO=:NFL_CODIGO                          '
                    );
      sql.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Lc_Codigo;
      Active := True;
      FetchAll;

      // Neste caso tem apenas um endereço e não precisa comparar
      if (Lc_qt_Endereco > 1) then
      Begin
        Lc_Cd_Entrega := FieldByName('PED_CODEND').AsInteger;

        If (Lc_Cd_Endereco <> Lc_Cd_Entrega) AND (Lc_Cd_Entrega > 0) then
        begin
          with dfent do
          begin
            xNome   := FieldByName('EMP_NOME').AsString;
            CNPJCPF := FieldByName('END_CNPJ').AsString;
            xLgr    := FieldByName('END_ENDER').AsString;
            nro     := FieldByName('END_NUMERO').AsString;
            xCpl    := FieldByName('END_COMPLEM').AsString;
            CEP     := FieldByName('END_CEP').AsInteger;
            xBairro := FieldByName('END_BAIRRO').AsString;
            cMun    := FieldByName('CDD_IBGE').AsInteger;
            xMun    := FieldByName('CDD_DESCRICAO').AsString;
            UF      := FieldByName('UFE_SIGLA').AsString;
            cPais   := FieldByName('PAI_CODBACEN').AsInteger;
            xPais   := FieldByName('PAI_DESCRICAO').AsString;
            fone    := FieldByName('END_FONE').AsString;
            Email   := FieldByName('EMP_EMAIL').AsString;
            IE      := FieldByName('EMP_INSC_EST').AsString;

          end;
        end;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


function TFr_GeraNfe3x.InformarChaveAcesso: Integer;
Var
  Lc_Form: TFr_Doc_Fiscal_Referenciado;
Begin
  Try
    Result := 0;
    Lc_Form := TFr_Doc_Fiscal_Referenciado.Create(self);
    Lc_Form.Caption := 'Informar Chave de Nota Pré-Existente';
    Lc_Form.Pg_Controle.Pages[1].TabVisible := False;
    Lc_Form.DocReferenciado := False;
    Lc_Form.ShowModal;
    Result := Lc_Form.CodigoChaveNotaFiscal;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;


procedure TFr_GeraNfe3x.IniciaVariaveis;
Begin
  FMostraLote              := ( Fc_Tb_Geral('L','NFE_MOSTRA_LOTE','S') = 'S');
  PreencheLoteValid       := ( Fc_Tb_Geral('L','NFE_PREENCHE_LOTE_VALID','S') = 'S');
  MostraRastreioCompleto  := ( Fc_Tb_Geral('L','NFE_SHOW_RASTREIO_COMPLETO','S') = 'S');
  informacaoSemBenefic    := ( Fc_Tb_Geral('L','PRO_G_SEM_BENEFIC','N') = 'S');
  FNaoUtilizarCodigoBarras := ( Fc_Tb_Geral('L','NFE_SEM_CODIGO_BARRAS','N') = 'S' );
  //Serve para quando o retorno mostra chave já existente e autorizada
  ChaveDuplicada          := '' ;
  OcultaDuplicataPagVista := ( Fc_Tb_Geral('L','NFE_OCUL_PAG_AVISTA','S') ='S');
  // Ajusta as configurações de SSL
  Pc_SSL2_TLS1;
  // Ativa os dados das configurações da Nfe
  Pc_AtivatTb_NF_Eletronica;
  Pc_AtivaConfiguracaoNFe;
  Pc_CarregaDadosEmitente(True);
  MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);
end;

procedure TFr_GeraNfe3x.FormataTela;
Var
  I :Integer;
Begin
  For I := 1 to pg_Principal.PageCount do pg_Principal.Pages[I-1].TabVisible:=False;

end;

procedure TFr_GeraNfe3x.FormShow(Sender: TObject);
begin
  ImagemBotao;
  FormataTela;
  IniciaVariaveis;
end;

function TFr_GeraNfe3x.getUnidadeTributavel(id:Integer): String;
Var
  LcMedida : TControllerMedida;
begin
  LcMedida := TControllerMedida.create(self);
  LcMedida.Registro.Codigo := id;
  LcMedida.getbyId;
  Result := LcMedida.Registro.Abreviatura;
end;

procedure TFr_GeraNfe3x.ImagemBotao;
Begin
end;

procedure TFr_GeraNfe3x.Pc_PosicionaEstabelecimentoEmissor;
Begin
  with Qr_RetornoNFe do
  Begin
    if (Gb_CodMha <> FieldByName('NFE_CODMHA').AsInteger) then
    Begin
      Gb_CodMha := FieldByName('NFE_CODMHA').AsInteger;
      Pc_DefineEmpresaAtiva(Gb_CodMha);
    End;
  end;
End;

procedure TFr_GeraNfe3x.Pc_RetornaEstabelecimentoInicial;
Begin
  if (Gb_CodMha <> It_Cd_Codmha) then
  Begin
    Gb_CodMha := It_Cd_Codmha;
    Pc_DefineEmpresaAtiva(Gb_CodMha);
  End;
End;


function TFr_GeraNfe3x.Fc_ValidaImpressaoNFe(Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  if Fc_VerificaNotaXMLCompra(Fc_Cd_Nota) > 0 then
  Begin
    //

  end
  else
  BEgin
    Lc_Verificacao := StrToIntDef(Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsString,0);
    if (Lc_Verificacao = 0) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
        'Nota não enviada para autorização.' + EOLN +
        'Autorize a Nota antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],
        mpAlerta);
      Result := False;
      Exit;
    end;

    if (Lc_Verificacao = 1) then
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
        'Nota enviada mas ainda não possue autorização.' + EOLN +
        'Consulte a Nota antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],
        mpAlerta);
      Result := False;
      Exit;
    end;

    if (Lc_Verificacao = 4) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
        'Número de Nota Inutilizada.' + EOLN +
        'Impossivel imprimir Nota inexistente.' + EOLN, ['OK'], [bEscape],
        mpAlerta);
      Result := False;
      Exit;
    end;
  end;
end;


procedure TFr_GeraNfe3x.FinalizarVariaveis;
begin
  FreeAndNil(CtrlLote);
  FreeAndNil(NotaFiscal);
  FreeAndNil(Financeiro);
  FreeAndNil(Arquivo);
  FreeAndNil(FNFEletronica);

end;



function TFr_GeraNfe3x.ValidaEnvioEmailNFe: Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  if not Fc_VerificaPermissao('Fr_GeraNFe', 'Enviar Email', 'ENVIA EMAIL',
    GB_Cd_Usuario, 'S') then
  Begin
    Result := False;
    Exit;
  end;

  Lc_Verificacao := StrToIntDef(Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsString,0);
  if (Lc_Verificacao = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Nota não enviada para autorização.' + EOLN +
      'Autorize a Nota antes de tentar enviar e-mail.' + EOLN, ['OK'],
      [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 1) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Nota enviada mas ainda não possue autorização.' + EOLN +
      'Consulte a Nota antes de tentar de tentar enviar e-mail.' + EOLN, ['OK'],
      [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 4) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Número de Nota Inutilizada.' + EOLN +
      'Impossivel enviar e-mail nota inexistente.' + EOLN, ['OK'], [bEscape],
      mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TFr_GeraNfe3x.Fc_AtivaRetornoNFe(Pc_cd_Nota: Integer): Integer;
Var
  Lc_SqlTxt: String;
begin
  with Qr_RetornoNFe do
  Begin
    Active := False;
    sql.Clear;
    Lc_SqlTxt := 'SELECT * ' +
                 'FROM TB_RETORNO_NFE tb_retorno_nfe ' +
                 'WHERE (NFE_CODNFL=:NFE_CODNFL) ';
    sql.Add(Lc_SqlTxt);
    ParamByName('NFE_CODNFL').AsInteger := Pc_cd_Nota;
    Active := True;
    FetchAll;
    if (StrToIntDef(FieldByName('NFE_CODSIT').AsString,0) = 3) or
       (StrToIntDef(FieldByName('NFE_CODSIT').AsString,0) = 5) then
      Fr_Principal.Dfe_Fortes.Cancelada := True
    else
      Fr_Principal.Dfe_Fortes.Cancelada := False;
    Result := StrToIntDef(FieldByName('NFE_CODSIT').AsString,0);
  end;
end;




procedure TFr_GeraNfe3x.Pc_atualiza_dadosnotafiscal(Pc_CodMha_Ant: Integer);
Begin
  with NotaFiscal.Registro do
  Begin
    CodigoEstabelecimento := Gb_CodMha;
    Codigo := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
    Numero:= StrZero(It_Nr_Nota, 6, 0);
    CodigoPedido := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
  End;
  NotaFiscal.AtualizaEstabelecimento(Pc_CodMha_Ant,Gb_Estoque);

end;


procedure TFr_GeraNfe3x.MostraValidade(pValidade, pCert_Validade,
  pCert_Expira: TPanel);
Var
  Lc_Date: TDate;
  Lc_Str_Date: String;
  Lc_Days_For: Integer;
  procedure errocertificado;
  BEgin
    // VAlidade
    pCert_Validade.Color := clBtnFace;
    pCert_Validade.Font.Color := clred;
    pCert_Validade.Caption := 'Não instalado/associado ao sistema';
    // Expira
    pCert_Expira.Color := clBtnFace;
    pCert_Expira.Font.Color := clGreen;
    pCert_Expira.Caption := 'Verifique!!!';
  End;

Begin
  IF (Trim(Fr_Principal.Nfe.Configuracoes.Certificados.NumeroSerie) <> '') or
     ( (Fr_Principal.Nfe.Configuracoes.Certificados.ArquivoPFX <> '') and
       FileExists(Fr_Principal.Nfe.Configuracoes.Certificados.ArquivoPFX) ) then
  Begin
    Try
      Lc_Date := Fr_Principal.Nfe.SSL.CertDataVenc;
      Lc_Str_Date := DateToStr(Lc_Date);
      Lc_Days_For := Round(Lc_Date - Date);
      if (Lc_Days_For <= 30) then
      Begin
        pCert_Validade.Color := clred;
        pCert_Validade.Font.Color := clBlack;
        pCert_Expira.Font.Color := clred;
      End
      else
      BEgin
        pCert_Validade.Color := clBtnFace;
        pCert_Validade.Font.Color := clBlack;
        pCert_Expira.Font.Color := clGreen;
      End;
      pCert_Validade.Caption := ' Validade do Certificado: ' + Lc_Str_Date;
      pCert_Expira.Caption := 'O Certificado expira em ' +
        IntToStr(Lc_Days_For) + ' dia(s)';
    Except
      errocertificado;
    End;
  End
  else
    errocertificado;
end;

procedure TFr_GeraNfe3x.SaveNfeEletronica;
begin
end;

function TFr_GeraNfe3x.validaCancelaCarregarNota: Boolean;
begin
  Result := True;
  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                    'Não foi possivel carregar a Nota.' + EOLN +
                    'Verifique se a nota já está cancelada.' + EOLN, ['OK'], [bEscape],
                    mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TFr_GeraNfe3x.validaCancelaFinanceiro: Boolean;
begin
  Result := true;
  financeiro.Registro.CodigoNota := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
  if financeiro.verificaBaixadobyNota then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   '   Não é possivel Cancelar esta nota.' + EOLN + EOLN +
                   'Financeiro acusa Pagamento(s) Baixado(s).', ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;
end;



procedure TFr_GeraNfe3x.Pc_PathClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(TEdit(Sender).Text) <= 0 then
    Dir := ExtractFileDir(Application.ExeName)
  else
    Dir := TEdit(Sender).Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP)
  then
    TEdit(Sender).Text := Dir;
end;

procedure TFr_GeraNfe3x.setFTipoOperacao(const Value: String);
begin
  FTipoOperacao := Value;
end;

procedure TFr_GeraNfe3x.TrataRetorno(var Pc_Cd_Retorno: Integer; pc_Memo: TMemo; OnLine: Boolean);
begin

end;

function TFr_GeraNfe3x.DeleteLote: boolean;
begin
  //Libera os Lotes //Excluindo os regsitros
  Qr_Itens.First;
  while not Qr_Itens.Eof do
  Begin
    CtrlLote.getLoteByVinculo( Qr_Itens.FieldByName('ITF_CODIGO').AsInteger );
    if CtrlLote.exist then
      CtrlLote.delete;
    Qr_Itens.Next;
  End;
end;


procedure TFr_GeraNfe3x.EnviaWhatsApp(Tipo,Path,FilePDF,FileXML:String);
Var
  LcW : TWhatsApp;
begin
  Try
    LcW := TWhatsApp.create(nil);
    LcW.Mensagem := concat('Ola, seu pedido foi realizado, Segue o PDF da '+ Tipo);
    LcW.ReceiverNumber := Qr_Nota.FieldByName('END_CELULAR').AsString;
    //Agora Envia o Anexo PDF
    LcW.Arquivo := concat(Path,'\',FilePDF);
    LcW.RegisterMessage;
    //Agora Envia o Anexo XML
    LcW.Mensagem := concat('Segue tambem XML da '+ Tipo);
    LcW.Arquivo := concat(Path,'\',FileXML);
    LcW.RegisterMessage;
    LcW.Send;
  finally
    FreeAndNil(LcW);
  end;

end;


procedure TFr_GeraNfe3x.LimpaWebService;
Begin
  with Fr_Principal.Nfe.WebServices do
  Begin
    Enviar.Clear;
    Retorno.Clear;
    Consulta.Clear;
    EnvioWebService.Clear;
  End;
End;



procedure TFr_GeraNfe3x.PagamentoAntecipado;
begin
  if Gb_Reforma_Tributaria then
  Begin
    with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
    Begin
      {RFT - Referência uma NF-e (modelo 55) emitida anteriormente, referente a pagamento antecipado}
      // with NotaF.NFe.Ide.gPagAntecipado.New do
      // refNFe := '12345678901234567890123456789012345678901234';
    End;
  End;
end;

procedure TFr_GeraNfe3x.Pc_AtivatTb_NF_Eletronica;
begin
  FNFEletronica.Registro.Estabelecimento := Gb_CodMha;
  FNFEletronica.getbyId;
end;

procedure TFr_GeraNfe3x.cancelaNotaComplementar;
begin

  Pc_ApagaObservacao( It_Cd_Nota);

  NotaFiscal.Pedido.Itens.ItensIcms.registro.Nota := It_Cd_Nota;
  NotaFiscal.Pedido.Itens.ItensIcms.deletebyNF;

  NotaFiscal.Pedido.Itens.ItensIpi.Registro.Nota := It_Cd_Nota;
  NotaFiscal.Pedido.Itens.ItensIpi.deletebyNF;

  NotaFiscal.Pedido.Itens.ItensPis.Registro.Nota := It_Cd_Nota;
  NotaFiscal.Pedido.Itens.ItensPis.deletebyNF;

  NotaFiscal.Pedido.Itens.ItensCofins.Registro.Nota := It_Cd_Nota;
  NotaFiscal.Pedido.Itens.ItensCofins.DeleteByNF;

  NotaFiscal.Pedido.Itens.ItensISSQN.Registro.Nota := It_Cd_Nota;
  NotaFiscal.Pedido.Itens.ItensISSQN.deleteByNF;

  NotaFiscal.Pedido.Itens.Ibscbs.Registro.Nota := It_Cd_Nota;
  NotaFiscal.Pedido.Itens.Ibscbs.deleteAllByNF;

  Pc_ApagaRetornoNFE( It_Cd_Nota);
  //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento

  Financeiro.Clear;
  Financeiro.Registro.CodigoNota := It_Cd_Nota;
  Financeiro.deleteByNota;

  NotaFiscal.Delete;
  Pc_apagaItensNfl_complementar(It_Cd_Nota);

end;

procedure TFr_GeraNfe3x.ImpostoIBSCBS(imposto: TImposto);
begin
  NotaFiscal.Pedido.Itens.Ibscbs.Registro.Nota := NotaFiscal.Registro.Codigo;
  NotaFiscal.Pedido.Itens.Ibscbs.Registro.ItemNF := Qr_Itens.FieldByName('ITF_CODIGO').AsInteger;
  NotaFiscal.Pedido.Itens.Ibscbs.getAll;
  if NotaFiscal.Pedido.Itens.Ibscbs.exist then
  Begin
    ImpostoIBSCBS_IBS(imposto);
    ImpostoIBSCBS_IBS_UF(imposto);
    ImpostoIBSCBS_IBS_MUN(imposto);
    ImpostoIBSCBS_CBS(imposto);
    ImpostoIBSCBS_Tribregular(imposto);
  End;
end;

procedure TFr_GeraNfe3x.ImpostoIBSCBS_CBS(imposto: TImposto);
begin
  //CBS
  with Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
  Begin
    gCBS.pCBS := CBS.Registro.Pcbs;
    gCBS.vCBS := CBS.Registro.Vcbs;
    //CBS - RED
    if CBS.Red.Registro.PREDALIQ > 0 then
    Begin
      gCBS.gRed.pRedAliq := CBS.Red.Registro.PREDALIQ;
      gCBS.gRed.pAliqEfet := CBS.Red.Registro.pAliqEfet;
    End;
    //CBS - DIF
    if CBS.Dif.Registro.PDIF > 0 then
    Begin
      gCBS.gDif.pDif := CBS.Dif.Registro.PDIF;
      gCBS.gDif.vDif := CBS.Dif.Registro.VDIF;
    End;
    //CBS - DEVTRIB
    if CBS.DevTrib.Registro.VDEVTRIB > 0 then
    Begin
      gCBS.gDevTrib.vDevTrib := CBS.DevTrib.Registro.VDEVTRIB;
    End;
  End;

end;

procedure TFr_GeraNfe3x.ImpostoIBSCBS_IBS(imposto: TImposto);
begin
  with imposto.IBSCBS, NotaFiscal.Pedido.Itens do
  Begin
    CST           := StrToCSTIBSCBS( Ibscbs.Registro.CST );
    cClassTrib    := Ibscbs.Registro.CLASSTRIB;
    gIBSCBS.vBC   := Ibscbs.Registro.VBC;
    gIBSCBS.vIBS  := Ibscbs.Registro.VIBS;
  End;
end;

procedure TFr_GeraNfe3x.ImpostoIBSCBS_IBS_MUN(imposto: TImposto);
begin
  //IBS - MUN
  with Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
  Begin
    gIBSMun.pIBSMun := IbsMun.Registro.Pibsmun;
    gIBSMun.vIBSMun := IbsMun.Registro.Vibsmun;
    //IBS - MUN - RED
    if IbsMun.Red.Registro.PREDALIQ > 0 then
    Begin
      gIBSMun.gRed.pRedAliq   := IbsMun.Red.Registro.PREDALIQ;
      gIBSMun.gRed.pAliqEfet  := IbsMun.Red.Registro.pAliqEfet;
    End;
    //IBS - MUN - DIF
    if IbsMun.Dif.Registro.PDIF > 0 then
    Begin
      gIBSMun.gDif.pDif := IbsMun.Dif.Registro.PDIF;
      gIBSMun.gDif.vDif := IbsMun.Dif.Registro.VDIF;
    End;
    //IBS - MUN - DEVTRIB
    if IbsMun.DevTrib.Registro.VDEVTRIB > 0 then
    Begin
      gIBSMun.gDevTrib.vDevTrib := IbsMun.DevTrib.Registro.VDEVTRIB;
    End;
  End;

end;

procedure TFr_GeraNfe3x.ImpostoIBSCBS_IBS_UF(imposto: TImposto);
begin
  //IBS - UF
  with Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
  Begin
    gIBSUF.pIBSUF := IbsUF.Registro.Pibsuf;
    gIBSUF.vIBSUF := IbsUF.Registro.Vibsuf;
    //IBS - UF - RED
    if IbsUF.Red.Registro.PREDALIQ > 0 then
    Begin
      gIBSUF.gRed.pRedAliq := IbsUF.Red.Registro.PREDALIQ;
      gIBSUF.gRed.pAliqEfet := IbsUF.Red.Registro.pAliqEfet;
    End;
    //IBS - UF - DIF
    if IbsUF.Dif.Registro.PDIF > 0 then
    Begin
      gIBSUF.gDif.pDif        := IbsUF.Dif.Registro.PDIF;
      IbsUF.Dif.Registro.VDIF := gIBSUF.gDif.vDif;
    End;
    //IBS - MUN - DEVTRIB
    if IbsUF.DevTrib.Registro.VDEVTRIB > 0 then
    Begin
      gIBSUF.gDevTrib.vDevTrib := IbsUF.DevTrib.Registro.VDEVTRIB;
    End;
  End;
end;

procedure TFr_GeraNfe3x.ImpostoIBSCBS_Tribregular(imposto: TImposto);
begin
  //Tribregular
  if NotaFiscal.Pedido.Itens.Ibscbs.Tribregular.exist then
  Begin
    with Imposto.IBSCBS.gIBSCBS,NotaFiscal.Pedido.Itens.Ibscbs do
    Begin
      if Tribregular.Registro.Cclasstribreg = '550001' then
      Begin

        gTribRegular.CSTReg             := StrToCSTIBSCBS( Tribregular.Registro.Cstreg  );
        gTribRegular.cClassTribReg      := Tribregular.Registro.Cclasstribreg;
        gTribRegular.pAliqEfetRegIBSUF  := Tribregular.Registro.Paliqefetregibsuf;
        gTribRegular.vTribRegIBSUF      := Tribregular.Registro.Vtribregibsuf;
        gTribRegular.Paliqefetregibsmun := Tribregular.Registro.Paliqefetregibsmun;
        gTribRegular.vTribRegIBSMun     := Tribregular.Registro.Vtribregibsmun;
        gTribRegular.pAliqEfetRegCBS    := Tribregular.Registro.Paliqefetregcbs;
        gTribRegular.Vtribregcbs        := Tribregular.Registro.Vtribregcbs;
      End;
    End;
  End;
end;

procedure TFr_GeraNfe3x.ImpostoSeletivo(imposto: TImposto);
begin
  {RFT -
  Imposto.ISel.CSTIS.cstis000;
  Imposto.ISel.cClassTribIS.ctis000001;
  //Valor da Base de cálculo do Imposto Seletivo (vBCIS) deve ser igual ao
  //somatório de:
  //(+) vProd (+) vServ (+) vFrete (+) vSeg (+) vOutro (+) vII
  //(-) vDesc (-) vPIS (-) vCOFINS (-) vICMS (-) vICMSUFDest (-) vFCP (-) vFCPUFDest (-) vICMSMono (-) vISSQN
  //Exceção 1: Não subtrair o valor do PIS por Substituição Tributária  (PIST/vPIS) quando compor o valor total da NF-e (seindSomaPISST=1);

  Imposto.ISel.vBCIS;
  Imposto.ISel.pIS;
  Imposto.ISel.pISEspec;
  Imposto.ISel.uTrib;
  Imposto.ISel.qTrib;
  Imposto.ISel.vIS;
  }
end;

procedure TFr_GeraNfe3x.ImprimeDuplicata;
begin

end;


function TFr_GeraNfe3x.CarregaComponenteNFE(Pc_Path,
  Pc_FileXMl: String): Boolean;
begin
  Result := True;

  //Carrega o XMl no Componente
  with fr_Principal do
  Begin
    try
      Nfe.NotasFiscais.Clear;
      Nfe.NotasFiscais.LoadFromFile(Pc_Path + '\' + Pc_FileXML);
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;

end;

procedure TFr_GeraNfe3x.ConfigResponsabelTécnico;
var
  Lc_Sigla : String;
begin
  Lc_Sigla := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;

  Case AnsiIndexStr(Lc_Sigla, ['PR']) of
    0:Begin
      if FNFEletronica.Registro.Ambiente = '0' then
      Begin
        Fr_Principal.Nfe.Configuracoes.RespTec.IdCSRT := 3;
        Fr_Principal.Nfe.Configuracoes.RespTec.CSRT := 'LXYONWCISU0KU8O846MHTLWFCY2BELBXEXU9';
      End
      else
      Begin
        Fr_Principal.Nfe.Configuracoes.RespTec.IdCSRT := 4;
        Fr_Principal.Nfe.Configuracoes.RespTec.CSRT := '261I60ZMIM2HA05UG2R6X6AD6YNIT9C8KJJ3';
      End;
    End;
  else
    Begin
      Fr_Principal.Nfe.Configuracoes.RespTec.IdCSRT := 0;
      Fr_Principal.Nfe.Configuracoes.RespTec.CSRT := '';
    End;
  End;

end;

procedure TFr_GeraNfe3x.ConfirmaEnviaBoleto;
begin

end;

procedure TFr_GeraNfe3x.ConfirmaEnviaNFe(Path,FileXML,FilePDF:String;Validar:Boolean);
Var
  Lc_Valido : Boolean;
begin
  Lc_Valido := True;
  //DEvido uma questão de temporal, a validação apos a autorização não é necessaria
  if Validar then
      Lc_Valido := ValidaEnvioEmailNFe;

  if Lc_Valido then
    Fc_EnviaEmailNfe(Qr_Nota.FieldByName('EMP_CODIGO').AsString,
                     Qr_Nota.FieldByName('NFL_CODTRP').AsString,
                      IntToStr(It_Nr_Nota),
                      Path,
                      FileXML,
                      FilePDF,'');

end;

procedure TFr_GeraNfe3x.ConfirmaImprimeBoleto;
begin

end;

procedure TFr_GeraNfe3x.CriarVariaveis;
begin
  // Ativa dados do Estabelecimento
  It_Cd_Codmha := Gb_CodMha;
  FNFEletronica := TControllerNfEletronica.Create(Self);
  CtrlLote      := TControllerCtrlLote.Create(Self);
  NotaFiscal    := TControllerNOtaFiscal.Create(self);
  Arquivo       := TControllerArquivo.Create(self);
  Financeiro    := TControllerFinanceiro.Create(self);
end;

procedure TFr_GeraNfe3x.ApagarPayBAck;
Var
  LcPayBack : TControllerPayBack;
begin
  try
    LcPayBack := TControllerPayBack.Create(nil);
    LcPayBack.Parametros.PayBack.Estabelecimento := Gb_CodMha;
    LcPayBack.Parametros.PayBack.Ordem := It_Cd_Pedido;
    LcPayBack.deleteByOrder;
  finally
    FreeAndNil(LcPayBack);
  end;
end;

procedure TFr_GeraNfe3x.ApagarPrePaid;
Var
  LcPrePAid : TControllerPrePaidCard;
begin
  try
    LcPrePAid := TControllerPrePaidCard.Create(nil);
    LcPrePAid.Parametros.PrePago.Estabelecimento := Gb_CodMha;
    LcPrePAid.Parametros.PrePago.Ordem := It_Cd_Pedido;
    LcPrePAid.deleteByOrder;
  finally
    FreeAndNil(LcPrePAid);
  end;
end;


procedure TFr_GeraNfe3x.CancelaCtrlIcmsST;
Var
  LcCtrlICMSST : TControllerCtrlIcmsST;
  Lc_Qry : TSTQuery;
begin
  Try
    LcCtrlICMSST := TControllerCtrlIcmsST.create(nil);
    Lc_Qry := LcCtrlICMSST.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT ITF_CODIGO FROM TB_ITENS_NFL WHERE ITF_CODNFL =:ITF_CODNFL ') ;
      ParamByName('ITF_CODNFL').AsInteger := It_Cd_Nota;
      Active := True;
      First;
      while not Lc_Qry.Eof do
      Begin
        LcCtrlICMSST.Registro.Estabelecimento := Gb_CodMha;
        LcCtrlICMSST.Registro.Origem := FieldByName('ITF_CODIGO').AsInteger;
        LcCtrlICMSST.deleteByOrigem;
        Next;
      End;
    End;
  Finally
    LcCtrlICMSST.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcCtrlICMSST);
  End;
end;

End.

