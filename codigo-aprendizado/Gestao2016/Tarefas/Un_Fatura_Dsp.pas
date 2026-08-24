unit Un_Fatura_Dsp;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, STStoredProc, StdCtrls, DBCtrls, Mask, ExtCtrls, STQuery, Printers, UN_NF, ComCtrls, Grids, System.Math, QEdit_Setes, STDatabase, AcbrBoleto, ACBrBoletoFCFortesFr, ControllerPedido, STTransaction;

type

   TFr_Fatura_Dsp = class(TForm)
      Qr_Acao: TSTQuery;
      PrintDialog1: TPrintDialog;
      Ds_Transportadora: TDataSource;
      Panel2: TPanel;
      Label9: TLabel;
      GroupBox1: TGroupBox;
      Label6: TLabel;
      E_Dt_Saida: TDateTimePicker;
      E_Dt_Emissao: TDateTimePicker;
      GroupBox5: TGroupBox;
      Sb_Transportadora: TSpeedButton;
      DBLCB_Transportadora: TDBLookupComboBox;
      E_Obs: TMemo;
      Panel1: TPanel;
    SB_Sair_0: TSpeedButton;
      Qr_Pedido: TSTQuery;
      Qr_Itens: TSTQuery;
      E_M_Nota: TMemo;
      E_M_Fisco: TMemo;
      Qr_PedidoPED_CODEMP: TIntegerField;
      Qr_PedidoPED_CODVDO: TIntegerField;
      Qr_PedidoEMP_CONSUMIDOR: TStringField;
      Qr_PedidoEMP_MICRO: TStringField;
      Qr_PedidoUFE_SIGLA: TStringField;
      Qr_PedidoUFE_CODIGO: TIntegerField;
      Qr_PedidoEMP_FABRICA: TStringField;
      Qr_PedidoEMP_SUB_TRIB: TStringField;
      Qr_Endereco: TSTQuery;
      Qr_EnderecoEND_CODIGO: TIntegerField;
      Qr_EnderecoEND_CODEMP: TIntegerField;
      Qr_EnderecoEND_CNPJ: TStringField;
      Qr_EnderecoEND_TIPO: TStringField;
      Qr_EnderecoEND_ENDER: TStringField;
      Qr_EnderecoEND_NUMERO: TStringField;
      Qr_EnderecoEND_COMPLEM: TStringField;
      Qr_EnderecoEND_BAIRRO: TStringField;
      Qr_EnderecoEND_CEP: TStringField;
      Qr_EnderecoEND_CODCDD: TIntegerField;
      Qr_EnderecoCDD_DESCRICAO: TStringField;
      Qr_EnderecoEND_REGIAO: TStringField;
      Qr_EnderecoEND_CODUFE: TIntegerField;
      Qr_EnderecoUFE_SIGLA: TStringField;
      Qr_EnderecoEND_CONTATO: TStringField;
      Qr_EnderecoEND_FONE: TStringField;
      Qr_EnderecoEND_FAX: TStringField;
      Qr_EnderecoEND_CELULAR: TStringField;
      Qr_EnderecoEND_PAIS: TIntegerField;
      Qr_PedidoPED_CODIGO: TIntegerField;
    Qr_PedidoEMP_CNPJ: TStringField;
    Qr_PedidoCDD_DESCRICAO: TStringField;
    Qr_PedidoEND_NUMERO: TStringField;
    Qr_PedidoEND_PAIS: TIntegerField;
    Qr_Nf_Eletronica: TSTQuery;
    Qr_PedidoEND_BAIRRO: TStringField;
    ChBx_AutorizacaoNFE: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS_St: TCheckBox;
    Panel4: TPanel;
    CkBx_Nota_Manual: TCheckBox;
    Qr_Tributacao: TSTQuery;
    Label2: TLabel;
    Label5: TLabel;
    Dblcb_Modal_Frete: TDBLookupComboBox;
    Ds_Moral_Frete: TDataSource;
    Qr_PedidoEMP_INSC_EST: TStringField;
    Qr_PedidoEND_ENDER: TStringField;
    Pg_Resumo: TPageControl;
    TabSheet1: TTabSheet;
    Panel5: TPanel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label1: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label39: TLabel;
    E_Vl_Bs_Icms_St: TEdit_Setes;
    E_Vl_Icms_St: TEdit_Setes;
    E_Vl_Seguro: TEdit_Setes;
    E_Vl_Outras: TEdit_Setes;
    E_VL_Produto: TPanel;
    E_VL_ICMS: TEdit_Setes;
    E_VL_Bs_ICMS: TEdit_Setes;
    E_VL_IPI: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
    E_VL_Nota: TPanel;
    E_Qt_Produto: TEdit_Setes;
    E_Especie: TEdit;
    E_PesoLiq: TEdit_Setes;
    E_PesoBruto: TEdit_Setes;
    E_PlacaVeiculo: TMaskEdit;
    E_RNTC: TEdit;
    E_Marca: TEdit;
    E_vol_Numero: TEdit;
    lb_Vl_desconto: TPanel;
    SB_Confirmar: TSpeedButton;
    IBT_Faturamento: TSTTransaction;
    Qr_PedidoEND_CEP: TStringField;
    Qr_PedidoPED_CODEND: TIntegerField;
    Qr_PedidoPED_VL_PEDIDO: TBCDField;
    Qr_PedidoPED_PRAZO: TStringField;
    Qr_PedidoPED_DATA: TDateField;
    Qr_PedidoPED_VL_PRODUTO: TBCDField;
    Qr_PedidoPED_VL_ODESPESA: TBCDField;
    Qr_PedidoPED_VL_IPI: TBCDField;
    Qr_PedidoPED_VL_FRETE: TBCDField;
    Qr_PedidoPED_VL_DESCONTO: TBCDField;
    Qr_PedidoPED_NUMERO: TIntegerField;
    Qr_PedidoPED_CODFPG: TIntegerField;
    Qr_PedidoEMP_NOME: TStringField;
    chbx_data_saida: TCheckBox;
    ChBx_NF_Informatizada: TCheckBox;
    E_Uf_Veiculo: TDBLookupComboBox;
    tbs_etiqueta: TTabSheet;
    Panel3: TPanel;
    Qr_Etiqueta: TSTQuery;
    Qr_EtiquetaCGE_CODIGO: TIntegerField;
    Qr_EtiquetaCGE_DESCRICAO: TStringField;
    Qr_EtiquetaCGE_PG_ALTURA: TBCDField;
    Qr_EtiquetaCGE_PG_LARGURA: TBCDField;
    Qr_EtiquetaCGE_SUPERIOR: TBCDField;
    Qr_EtiquetaCGE_INFERIOR: TBCDField;
    Qr_EtiquetaCGE_DIREITA: TBCDField;
    Qr_EtiquetaCGE_ESQUERA: TBCDField;
    Qr_EtiquetaCGE_ET_ALTURA: TBCDField;
    Qr_EtiquetaCGE_ET_LARGURA: TBCDField;
    Qr_EtiquetaCGE_DIS_COLUNA: TBCDField;
    Qr_EtiquetaCGE_TYPEFONTE: TStringField;
    Qr_EtiquetaCGE_SIZEFONTE: TIntegerField;
    Qr_EtiquetaCGE_PAGESIZE: TStringField;
    Qr_EtiquetaCGE_NR_COLUNA: TBCDField;
    Ds_Etiqueta: TDataSource;
    Qr_DestinatarioPedido: TSTQuery;
    Qr_DestinatarioPedidoPED_DATA: TDateField;
    Qr_DestinatarioPedidoPED_CODEMP: TIntegerField;
    Qr_DestinatarioPedidoPED_CODVDO: TIntegerField;
    Qr_DestinatarioPedidoCDD_DESCRICAO: TStringField;
    Qr_DestinatarioPedidoUFE_SIGLA: TStringField;
    Qr_DestinatarioPedidoEND_CEP: TStringField;
    Qr_DestinatarioPedidoEMP_NOME: TStringField;
    Qr_DestinatarioPedidoNFL_NUMERO: TStringField;
    GroupBox14: TGroupBox;
    E_PortaImpressao_dsp: TEdit;
    E_SaltoImpressao_dsp: TEdit_Setes;
      procedure SB_ConfirmarClick(Sender: TObject);
      procedure SB_Sair_0Click(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure Sb_TransportadoraClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormShow(Sender: TObject);
    procedure chbx_data_saidaClick(Sender: TObject);
    procedure E_Qt_ProdutoChange(Sender: TObject);

   private
    { Private declarations }
    PEdido : TControllerPedido;
    //Variveis para Controle do Emissor da nota
    It_Uf_Emissor : Integer;
    //codigo do Regime Tributario
    It_Cd_CRT : Integer;
    //Verifica se é usuario de Nfe
    It_Usa_Nfe : Boolean; 
    //Variveis para Calculo de tributação do ICMS
    It_CODTBI_ICMS_NR : Integer;
    It_CODTBI_ICMS_SN : Integer;
    It_Md_Bc_ICMS : String;
    It_Vl_Bc_ICMS: Currency;
    It_Aq_Nr_ICMS : Real;
    It_Aq_Rd_Nr_ICMS : Real;
    It_VL_Nr_ICMS: Currency;
    It_Md_Bc_St_ICMS : String;
    It_Aq_Rd_St_ICMS : Real;
    It_VL_Bc_St_ICMS: Currency;
    Gb_Aq_St_ICMS : Real;
    It_Vl_St_ICMS: Currency;
    It_Aq_Rd_BC_ICMS : Real;
    It_Aq_Rd_Bc_St_ICMS : Real;
    It_CodDsi_ICMS : Integer;
    It_VL_Bc_St_Ret_ICMS: Currency;
    It_VL_St_Ret_ICMS: Currency;
    It_Partilha : String;
    It_Repasse_ICMS : String;
    It_Vl_Bc_Ret_ICMS: Currency;
    It_Vl_Ret_ICMS: Currency;
    It_Aq_Calc_Cred_ICMS : Real;
    It_VL_Cred_Apro_ICms: Currency;
    It_VL_frete_Produto: Currency;
    It_Vl_Seguro_Produto: Currency;
    It_Vl_Outras_Produto: Currency;
    It_Cd_CFOP : Integer;
    It_Dest_ICMS : String;
    It_Cd_Observacao : Integer;
    It_Vl_Diferido: Currency;
    It_Contribuinte_ICMS : boolean;
    //Variveis para Calcular o Sub. tributaria
    It_Subst_Tributario : Boolean;

     //Variveis para Calculo de tributação do IPI
    It_CodTbI_IPI : Integer;
    It_Cl_Enqd_IPI : String;
    It_CNPJ_PROD_IPI : String;
    It_CD_SELO_IPI : String;
    It_QT_SELO_IPI : Real;
    It_CD_ENQD_IPI : String;
    It_VL_BC_IPI: Currency;
    It_AQ_NR_IPI : Real;
    It_QT_UNID_IPI : Real;
    It_VL_UNID_IPI: Currency;

     //Variveis para Calculo de tributação do PIS
    It_CodTbp_PIS : Integer;
    It_VL_BC_PIS: Currency;
    It_AQ_NR_PIS : Real;
    It_VL_NR_PIS: Currency;
    It_QT_VDA_PIS : Real;
    It_VL_AQ_PIS: Currency;

     //Variveis para Calculo de tributação do COFINS
    It_CODTBC_CFS : Integer;
    It_VL_BC_CFS: Currency;
    It_AQ_NR_CFS : Real;
    It_VL_NR_CFS: Currency;
    It_QT_UNID_CFS : Real;
    It_VL_AQ_CFS: Currency;

    //Totalizadores
    It_VL_TL_Produtos: Currency;
    It_Vl_TL_Frete: Currency;
    It_Vl_TL_Seguro: Currency;
    It_Vl_TL_Outras: Currency;
    It_VL_TL_IPI: Currency;
    It_Vl_TL_Pedido: Currency;
    It_VL_Tl_Desconto: Currency;
    It_Qt_TL_Produtos: Real;
    It_Vl_TL_NotaFiscal: Currency;

   public
    { Public declarations }
     //Variveis para Controle da nota Instanciada
    It_Cd_Nota : Integer;
    It_Nr_Nota: Integer;
    It_cd_empresa: Integer;
    It_Cd_Natureza : Integer;
    It_Cd_Pedido: Integer;
    It_Nr_Pedido: Integer;
    It_Etapa_Faturamento : Integer;
    It_Result_Fatura : Boolean;
    //Controle de Sequencias
      procedure Pc_AtivarTabela;
      procedure Pc_Faturar_Venda_Servico;
      procedure Pc_GravaUltimasConfiguracoes;
      function Fc_Faturar_Normal():Boolean;

      procedure Pc_Obs_NotaFiscal;
      procedure Pc_Obs_Financeira;
      procedure Pc_Obs_Manual;
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
      
      function Fc_ValidaFaturamento(): Boolean;
      procedure Pc_Totalizador;

      procedure Pc_SelecionaItensNota(Fc_Nr_Itens: Integer; Fc_Inicio: Integer; Fc_TP_Produto: string);
      procedure Pc_AtualizarItensNota;
      procedure Pc_CalculaTotalPedido;

      procedure Pc_CalculaTotalProduto;
      procedure Pc_Calcula_Impostos;
      procedure Pc_AtualizarItensICMS;
      procedure Pc_AtualizarItensIPI;
      procedure Pc_AtualizarItensPIS;
      procedure Pc_AtualizarItensCOFINS;
      function Fc_ConfirmaValores(): boolean;

      procedure Pc_Gera_NotaFiscal;

      function Fc_tributacao(Pc_Cd_Produto: Integer; Pc_St: string ; Pc_Origem:String; Pc_Finalidade:String;Pc_NCM:String): Integer;
      function Fc_SomaCreditoICMS(): Real;
      procedure Pc_Condicao_STDPRREV;
      procedure Pc_Condicao_STDPRCSD;
      procedure Pc_Condicao_STDPRREVREQ;
      procedure Pc_Condicao_NRDPRREV;
      procedure Pc_Condicao_NRDPRCSD;
      procedure Pc_Condicao_STFPRREV;
      procedure Pc_Condicao_STFPRCSD;
      procedure Pc_Condicao_NRFPRREV;
      procedure Pc_Condicao_NRFPRCSD;
      procedure Pc_Inicia_Variaveis;
      procedure Pc_FormataTela;
      procedure Pc_RollBack_Faturamento;
      procedure Pc_Atualiza_Itens_Devolucao;

      function Fc_VerificaEntregaDiferente(Pc_cd_cliente,Pc_cd_Pedido:Integer): Boolean;
      procedure Pc_ImagemBotao;
      procedure Pc_ImprimeEtiquetaVolume;
      function Fc_VerificaCarteiraCobranca:TStringList;
      procedure Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);
   end;

var
   Fr_Fatura_Dsp: TFr_Fatura_Dsp;

implementation


uses
Un_DM, Un_Msg, Un_Funcoes, UN_Empresa, UN_Sistema, Un_MinhaEmpresa, Un_GeraNFe, un_Padrao, Un_Fc_Sored_Procedures, Un_Regra_Negocio, Un_Transportadora, RN_NotaFiscalEletronica, UN_Principal, env, RN_Inventario, RN_Estoque, RN_NotaFiscal, Un_Rl_Etiq_Conferencia, Un_RL_Etiq_Transporte, un_conferente, Un_Imp_Mod_Impressao, RN_Financeiro, RN_BoletoEletronico, RN_Transportadora, RN_FormaPagto, RN_PlanoContas, RN_Permissao, un_geranfe_vda;

{$R *.dfm}

procedure TFr_Fatura_Dsp.Pc_RollBack_Faturamento;
Begin
  //Inicia o processo de retorno
  IBT_Faturamento.Active := True;
  if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;
  if not IBT_Faturamento.InTransaction then IBT_Faturamento.StartTransaction;

  if (It_Etapa_Faturamento >= 1) then Pc_ApagaImpostos(IBT_Faturamento,It_Cd_Nota);
  if (It_Etapa_Faturamento >= 2) then
    Begin
    Pc_ApagaNF(IBT_Faturamento,It_Cd_Nota);
    Pc_Apaga_conserto(IBT_Faturamento,It_cd_Pedido);
    end;
  if (It_Etapa_Faturamento >= 3) then Pc_ApagaObservacao(IBT_Faturamento,It_Cd_Nota);
  if (It_Etapa_Faturamento >= 6) then
    Begin
    Pc_ApagaComissaoFaturamento(IBT_Faturamento,It_cd_Pedido);
    Pc_ApagaVendedor(IBT_Faturamento,It_Cd_Nota);
    end;
  if (It_Etapa_Faturamento >= 8) then Pc_ApagaRetornoNFE(IBT_Faturamento,It_Cd_Nota);
  if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;  
end;

procedure TFr_Fatura_Dsp.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;



procedure TFr_Fatura_Dsp.Pc_ImprimeEtiquetaVolume;
Var
  Lc_Prin : TPrin;
  Lc_I : Integer;
  Lc_Linha : Integer;
  Lc_Porta : String;
begin
  if StrToIntDef(E_Qt_Produto.Text,0) > 0  then
    Begin
    Qr_DestinatarioPedido.Active := False;
    Qr_DestinatarioPedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
    Qr_DestinatarioPedido.Active := True;
    Lc_Prin:=TPrin.Create(application);
    With Lc_Prin Do
      begin

      Lc_Porta := E_PortaImpressao_dsp.Text;
      if Trim(Lc_Porta) = '' then Lc_Porta := 'LPT1';
      Initialize(Lc_Porta);
      Lc_Linha := 0;
      For Lc_I := 1 to StrToIntDef(E_Qt_Produto.Text,0) do
        Begin
        Expandido(True);
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,3,Copy(DM.Qr_MhaEmpresaEMP_FANTASIA.AsString,1,15));
        Expandido(False);
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,4,Copy('Volume  : ' + IntToStr(Lc_I) +'/'+ E_Qt_Produto.Text,1,30));
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,4,Copy('Cliente : ' + Qr_DestinatarioPedidoPED_CODEMP.AsString + ' NF: '+ Qr_DestinatarioPedidoNFL_NUMERO.AsString,1,30));
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,4,Copy('Represe : ' + Qr_DestinatarioPedidoPED_CODVDO.AsString,1,30));
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,4,Copy('Cidade  : ' + Qr_DestinatarioPedidoCDD_DESCRICAO.AsString + '-' + Qr_DestinatarioPedidoUFE_SIGLA.AsString,1,30));
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,4,Copy('Cep     : ' + Fc_MascaraCep(Qr_DestinatarioPedidoEND_CEP.AsString),1,30));
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,4,Copy(Qr_DestinatarioPedidoEMP_NOME.AsString,1,30));
        Lc_Linha := Lc_Linha + StrToIntDef(E_SaltoImpressao_dsp.Text,1);
        TextOutLC(Lc_Linha,1,'');
        end;
      end;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
  end;
end;

function TFr_Fatura_Dsp.Fc_VerificaCarteiraCobranca:TStringList;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  Result := TStringList.Create;
  Result.Clear;
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT BLE_CODIGO,BLE_CODCTB '+
            'FROM tb_boleto_eletronico boleto_eletronico ');
    Active := True;
    FetchAll;
    First;
    Result.Add(FieldByName('BLE_CODIGO').AsString);
    Result.Add(FieldByName('BLE_CODCTB').AsString);
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_Fatura_Dsp.Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);
var
  lc_qry:TSTQuery;
  sql_txt:String;
  Lc_Lista:TStringList;
  Lc_Cd_Boleto : Integer;
  Lc_Cd_Conta  : Integer;
  Lc_Imprimir : Boolean;
begin
  //Verifica se a forma de pagamento é boleto
  if (Qr_PedidoPED_CODFPG.AsInteger = Fc_PegaFormaPgto('BOLETO')) then
    Begin
    Lc_Lista := TStringList.Create;
    Lc_Lista := Fc_VerificaCarteiraCobranca;
    Lc_Cd_Boleto := StrToIntDef(Lc_Lista.Strings[0],0);
    Lc_Cd_Conta := StrToIntDef(Lc_Lista.Strings[1],0);
    if Lc_Cd_Boleto > 0 then
      Begin
      lc_qry := TSTQuery.Create(Application);
      with lc_qry do
        Begin
        Database:= DM.IBD_Gestao;
        Transaction:= DM.IB_Transacao;
        SQL.Clear;
        sql_txt:= ' select PED_NUMERO,FIN_NR_PARCELA,FIN_VL_PARCELA,FIN_CODQTC,FIN_DT_VENCIMENTO '+
                  ' FROM TB_FINANCEIRO '+
                  ' INNER JOIN TB_PEDIDO '+
                  ' ON (PED_CODIGO = FIN_CODPED) '+
                  ' WHERE FIN_CODPED =:PED_CODIGO '+
                  'ORDER BY FIN_NUMERO ';
        SQL.Add(sql_txt);
        ParamByName('PED_CODIGO').AsInteger:= Pc_Cd_Pedido;
        Open;
        FetchAll;
        First;
        //Grava o Boleto;
        while not eof do
          Begin
          Pc_GravaBoleto(0,
                         It_cd_empresa,
                         FieldByName('PED_NUMERO').ASString + FieldByName('FIN_NR_PARCELA').ASString,
                         Date,
                         Lc_Cd_Conta,//               Pc_CODCTB
                         'N',//               Pc_DESCONTO
                         0,//               Pc_TX_DESCONTO
                         'N',
                         FieldByName('FIN_VL_PARCELA').AsCurrency,
                         FieldByName('FIN_CODQTC').AsInteger,
                         0,//               Pc_VL_TARIFA:Real;
                         0,//               Pc_TX_MORA:Real;
                         Lc_Cd_Boleto, //   Pc_CODBLE
                         FieldByName('FIN_DT_VENCIMENTO').AsDateTime);
          Next;
          end;
        //Imprime o Boleto
        Lc_Imprimir := False;
        Fr_Principal.Boleto.ListadeBoletos.Clear;
        if not DirectoryExists(GbPathExe + 'imagem\') then
          CreateDir(GbPathExe + 'imagem\');
        Fr_Principal.Boleto.ACBrBoletoFC.DirLogo := GbPathExe + '\imagem\';
        Fr_Principal.Boleto.ACBrBoletoFC.Filtro := fiNenhum;
        Fr_Principal.Boleto.ACBrBoletoFC.NomeArquivo := '';
        if not FileExists(GbPathExe + 'imagem\'+StrZero(Fr_Principal.Boleto.Banco.Numero,3,0)+'.bmp') then
          Pc_BaixarLogoBanco(StrZero(Fr_Principal.Boleto.Banco.Numero,3,0));
        First;
        while not eof do
          Begin
          Lc_Imprimir := Fc_Gerar_Boleto_Sem_Registro(FieldByName('FIN_CODQTC').AsInteger);
          Next;
          end;
        if Lc_Imprimir then Fr_Principal.Boleto.Imprimir;
        end;
      end;
    end;
end;


procedure TFr_Fatura_Dsp.Pc_FormataTela;
Begin

  lb_Vl_desconto.ParentColor := False;
  lb_Vl_desconto.Color := clRed;
end;

procedure TFr_Fatura_Dsp.Pc_Inicia_Variaveis;
Begin
  Pg_Resumo.ActivePageIndex := 0;
  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Pedido.Active := True;
  Qr_Pedido.FetchAll;
  Qr_Pedido.First;

  Dblcb_Modal_Frete.KeyValue := DM.Qr_Modal_FreteMDF_CODIGO.AsInteger;
  It_Cd_Natureza := 0;
  //Define o Estado Emissor
  DM.Qr_MhaEmpresa.Active := True;
  DM.Qr_MhaEmpresa.First;
  DM.Qr_MhaEmpresa.Locate('EMP_CODIGO',Gb_CodMha,[]);
  It_Uf_Emissor := DM.Qr_MhaEmpresaUFE_CODIGO.AsInteger;
  //codigo Regime Tributario
  It_Cd_CRT := StrToIntDef(DM.Qr_MhaEmpresaEMP_CRT.AsString,3);

  //Tributação do ICMS pelo SIMPLES NACIONAL e CSOSN=101 (v.2.0)  //Controladores
  It_Aq_Calc_Cred_ICMS := StrToFloatDef(Fc_Tb_Geral('L','GRL_G_AQ_CRED_ICMS',''),0);

  //Outros Contraladores
  It_cd_empresa := Qr_PedidoPED_CODEMP.AsInteger;
  It_VL_TL_Frete   := Qr_PedidoPED_VL_FRETE.AsCurrency;
  E_VL_Frete.Text  := FloatToStrF(It_Vl_TL_Frete,ffFixed,10,2);
  if Qr_PedidoPED_VL_ODESPESA.AsCurrency > 0 then
    It_Vl_TL_Outras  := Qr_PedidoPED_VL_ODESPESA.AsCurrency
  else
    It_Vl_TL_Outras  := 0;
  E_Vl_Outras.Text := FloatToStrF(It_Vl_TL_Outras,ffFixed,10,2);
  It_VL_Tl_Desconto      := Qr_PedidoPED_VL_DESCONTO.AsCurrency;
  lb_Vl_desconto.Caption := FloatToStrF(It_VL_Tl_Desconto,ffFixed,10,2);

  It_VL_TL_Produtos    := Qr_PedidoPED_VL_PRODUTO.AsCurrency;
  E_VL_Produto.Caption := FloatToStrF(It_VL_TL_Produtos,ffFixed,10,2);

  It_Vl_TL_Pedido     := Qr_PedidoPED_VL_PEDIDO.AsCurrency;
  It_Vl_TL_NotaFiscal := Qr_PedidoPED_VL_PEDIDO.AsCurrency + Qr_PedidoPED_VL_ODESPESA.AsCurrency;
  E_VL_Nota.Caption   := FloatToStrF(It_Vl_TL_NotaFiscal,ffFixed,10,2);

  E_Dt_Emissao.Date := Date;
  E_Dt_Saida.Date := Date;
  E_Obs.Text := '';

  E_VL_Frete.Text:= FormatFloat('#,##0.00',It_Vl_TL_Frete);


  Dblcb_Modal_Frete.KeyValue := StrToIntDef(Fc_Tb_Geral('L', 'FAT_TIPOFRETE', '0'),0);

  E_PortaImpressao_dsp.Text := Fc_Tb_Geral('L', 'FAT_PATHETIQUETA', 'LPT1');
  E_SaltoImpressao_dsp.Text := Fc_Tb_Geral('L', 'FAT_SALTOETIQUETA', '1');
  
  DM.Qr_MhaEmpresa.Active:=FALSE;
  DM.Qr_MhaEmpresa.Active:=True;
  DM.Qr_MhaEmpresa.Locate('EMP_CODIGO',Gb_CodMha, [loCaseInsensitive,loPartialKey]);
  DBLCB_Transportadora.KeyValue := Fc_Preenche_Transportadora(It_cd_empresa);
       
end;

procedure TFr_Fatura_Dsp.Pc_CalculaTotalPedido;
begin
   Qr_Itens.First;
   It_Vl_TL_Pedido := 0;
   while not Qr_Itens.Eof do
   begin
      It_Vl_TL_Pedido := It_Vl_TL_Pedido + (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat);
      It_Vl_TL_Pedido := It_Vl_TL_Pedido - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
      Qr_Itens.Next;
   end;
end;

function TFr_Fatura_Dsp.Fc_tributacao(Pc_Cd_Produto: Integer; Pc_St: string; Pc_Origem:String; Pc_Finalidade:String;Pc_NCM:String): Integer;
var
  E_M_Fiscoervacao, Lc_Diferido: string;
  Lc_VL_Custo, Lc_Aliq_ICMS, Lc_Red_base: Real;
  Lc_CodObs: Integer;
  Lc_Lista : Variant;
begin
  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Pedido.Active := True;
  //Busca a Tributação
  Result := -1;
  Pc_AliquotasUF(Qr_Pedido.FieldByName('UFE_CODIGO').AsInteger,Pc_NCM,Qr_Pedido.FieldByname('EMP_MICRO').AsString);
  //Verifica se é contribuinte do ICMS
  It_Contribuinte_ICMS := (Length(Trim(Qr_PedidoEMP_INSC_EST.AsString))>0);  
  Qr_Tributacao.Active := False;
  Qr_Tributacao.ParamByName('TRB_CODMHA').AsInteger := Gb_CodMha;
  Qr_Tributacao.ParamByName('TRB_CODPRO').AsInteger := Pc_Cd_Produto;
  Qr_Tributacao.ParamByName('TRB_ORIGEM').AsString := Pc_Origem;
  Qr_Tributacao.ParamByName('NAT_SENTIDO').AsString := 'S';
  Qr_Tributacao.ParamByName('TRB_ST_ICMS').AsString := Pc_St;
  Qr_Tributacao.ParamByName('TRB_ESTADO').AsInteger := Qr_Pedido.FieldByName('UFE_CODIGO').AsInteger;
  Qr_Tributacao.ParamByName('TRB_CONSUMIDOR').AsString := Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString;
  Qr_Tributacao.ParamByName('TRB_MICRO').AsString := Qr_Pedido.FieldByname('EMP_MICRO').AsString;
  Qr_Tributacao.ParamByName('TRB_PRODUTO').AsString := Pc_Finalidade;
  Qr_Tributacao.Active := True;
  Qr_Tributacao.FetchAll;
  Qr_Tributacao.First;
  if Qr_Tributacao.RecordCount >= 1 then
    Begin
    if Qr_Tributacao.RecordCount > 1 then
      Begin
      Lc_Lista := VarArrayCreate([0, 1], varVariant);
      Lc_Lista[0] := Qr_Pedido.FieldByName('UFE_CODIGO').AsInteger;
      Lc_Lista[1] := Pc_Cd_Produto;
      if not (Qr_Tributacao.locate('TRB_ESTADO;TRB_CODPRO', Lc_Lista, [])) then
        if not (Qr_Tributacao.locate('TRB_ESTADO', Qr_Pedido.FieldByName('UFE_CODIGO').AsInteger, [])) then
          Qr_Tributacao.locate('TRB_CODPRO', Pc_Cd_Produto, []);
      end;
    //Se a pesquisa trazer um registro ainda assim precisamos saber se este registro
    //se refere ao estado do Paraná, caso contrario nega a regra.
    if (Qr_Pedido.FieldByName('UFE_CODIGO').AsInteger = DM.Qr_MhaEmpresaUFE_CODIGO.AsInteger) and
       (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger <> Qr_Pedido.FieldByName('UFE_CODIGO').AsInteger) then
      Begin
      Result := -1;
      exit;
      end;
    //Variveis para Calculo de tributação do ICMS
    It_CODTBI_ICMS_NR := Qr_Tributacao.FieldByName('TRB_CODTBI_ICMS_NR').AsInteger;
    It_CODTBI_ICMS_SN := Qr_Tributacao.FieldByName('TRB_CODTBI_ICMS_SN').AsInteger;
    It_Md_Bc_ICMS := Qr_Tributacao.FieldByName('TRB_CODMDB_ICMS_NR').AsString;
    It_Aq_Nr_ICMS := Qr_Tributacao.FieldByName('TRB_AQ_ICMS').AsCurrency;
    It_Md_Bc_St_ICMS := Qr_Tributacao.FieldByName('TRB_CODMDB_ICMS_ST').AsString;
    // Gb_Mg_VA_St_Icms := Qr_Tributacao.FieldByName('').Value;
    // It_Aq_Rd_St_ICMS := Qr_Tributacao.FieldByName('').Value;
    // It_VL_Bc_St_ICMS := Qr_Tributacao.FieldByName('').Value;
    // Gb_Aq_St_ICMS := Qr_Tributacao.FieldByName('').Value;
    // It_Vl_St_ICMS := Qr_Tributacao.FieldByName('').Value;
    It_Aq_Rd_BC_ICMS := Qr_Tributacao.FieldByName('TRB_RD_BS_ICMS').AsCurrency;
    // It_Aq_Rd_Bc_St_ICMS := Qr_Tributacao.FieldByName('').Value;
    It_CodDsi_ICMS := Qr_Tributacao.FieldByName('TRB_CODDSI_ICMS').AsInteger;
    // It_VL_Bc_St_Ret_ICMS := Qr_Tributacao.FieldByName('').Value;
    // It_VL_St_Ret_ICMS := Qr_Tributacao.FieldByName('').Value;
    // It_Partilha := Qr_Tributacao.FieldByName('').Value;
    // It_Repasse_ICMS := Qr_Tributacao.FieldByName('').Value;
    // It_Vl_Bc_Ret_ICMS := Qr_Tributacao.FieldByName('').Value;
    // It_Vl_Rev_ICMS := Qr_Tributacao.FieldByName('').Value;

    It_Cd_CFOP := Qr_Tributacao.FieldByName('TRB_CODNAT').AsInteger;
    It_Dest_ICMS := Qr_Tributacao.FieldByName('TRB_DESTAQUE').AsString;
    It_Cd_Observacao := Qr_Tributacao.FieldByName('TRB_CODOBS').AsInteger;

    //Variveis para Calculo de tributação do ICMS
    It_CodTbI_IPI := Qr_Tributacao.FieldByName('TRB_CODTBI_IPI').AsInteger;
    It_AQ_NR_IPI := Qr_Tributacao.FieldByName('TRB_AQ_IPI').AsCurrency;

     //Variveis para Calculo de tributação do PIS
    It_CodTbp_PIS := Qr_Tributacao.FieldByName('TRB_CODTBI_PIS').AsInteger;
    It_AQ_NR_PIS := Qr_Tributacao.FieldByName('TRB_AQ_PIS').AsCurrency;

     //Variveis para Calculo de tributação do COFINS
    It_CODTBC_CFS := Qr_Tributacao.FieldByName('TRB_CODTBI_CFS').AsInteger;
    It_AQ_NR_CFS := Qr_Tributacao.FieldByName('TRB_AQ_COFINS').AsCurrency;
    //Define se a operação é como Substituto Tributario
    It_Subst_Tributario := (Qr_Tributacao.FieldByName('TRB_SUB_TRI').AsString = 'S');    
    end
  else
    Begin
    Result := -1;
    exit;
    end;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'S') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger = It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'N') and (Qr_Tributacao.FieldByname('TRB_SUB_TRI').AsString = 'N') then
      Result := 0;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'S') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger = It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'S') then
      Result := 1;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'S') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger = It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'N') and (Qr_Tributacao.FieldByname('TRB_SUB_TRI').AsString = 'S') then
      Result := 2;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'N') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger = It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'N') then
      Result := 3;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'N') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger = It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'S') then
      Result := 4;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'S') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger <> It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'N') then
      Result := 5;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'S') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger <> It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'S') then
      Result := 6;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'N') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger <> It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'N') then
      Result := 7;

   if (Qr_Tributacao.FieldByName('TRB_ST_ICMS').AsString = 'N') and (Qr_Tributacao.FieldByName('TRB_ESTADO').AsInteger <> It_Uf_Emissor) and
      (Qr_Pedido.FieldByname('EMP_CONSUMIDOR').AsString = 'S') then
      Result := 8;
end;


procedure TFr_Fatura_Dsp.Pc_AtivarTabela;
begin
  DM.Qr_UF.Active := true;
  DM.Qr_ListaTransportadora.Active := true;
  DM.Qr_Modal_Frete.Active := true;
  Pc_ListarPlanoContas;
  Qr_Etiqueta.Active := True;
end;


//==============================================================================================================

procedure TFr_Fatura_Dsp.Pc_Totalizador;
var
   Lc_Qr_Acao: TSTQuery;
   Lc_Mtz_Itens: array of array of string;
   Lc_Nr_Itens, Lc_I: Integer;
   Lc_Qtde: Real;
   Lc_CodPro: Integer;
begin
  Lc_Qr_Acao := TSTQuery.Create(Application);
  Lc_Qr_Acao.Active := False;
  Lc_Qr_Acao.Database := DM.IBD_Gestao;
  Lc_Qr_Acao.Transaction := IBT_Faturamento;
  Lc_Qr_Acao.ForcedRefresh := True;

  //Valor da Base do ICMS
  Lc_Qr_Acao.Active := False;
  Lc_Qr_Acao.SQL.Clear;
  Lc_Qr_Acao.SQL.Add('SELECT CAST(COALESCE(SUM((ICM_VL_BC_NR)), 0) AS NUMERIC(18, 2)) AS ICM_SUBTOTAL ' +
                      'FROM TB_ITENS_ICMS ' +
                      'WHERE (ICM_CODNFL=:ICM_CODNFL) AND (ICM_DESTAQUE = ''S'') ');
  Lc_Qr_Acao.ParamByName('ICM_CODNFL').AsInteger := It_Cd_Nota;
  Lc_Qr_Acao.Active := True;
  It_Vl_Bc_ICMS := (Lc_Qr_Acao.FieldByName('ICM_SUBTOTAL').AsCurrency);
  E_VL_Bs_ICMS.Text := FloatToStrF(It_Vl_Bc_ICMS, ffFixed, 10, 2);

  //Valor do ICMS
  Lc_Qr_Acao.Active := False;
  Lc_Qr_Acao.SQL.Clear;
  Lc_Qr_Acao.SQL.Add('SELECT CAST(COALESCE(SUM(ICM_VL_BC_NR * ((ICM_AQ_NR - ICM_AQ_RD_NR)/100)), 0) AS NUMERIC(18, 2)) AS ICM_SUBTOTAL ' +
                     'FROM TB_ITENS_ICMS ' +
                     'WHERE (ICM_CODNFL=:ICM_CODNFL) AND (ICM_DESTAQUE = ''S'') ');
  Lc_Qr_Acao.ParamByName('ICM_CODNFL').AsInteger := It_Cd_Nota;
  Lc_Qr_Acao.Active := True;
  It_VL_Nr_ICMS := (Lc_Qr_Acao.FieldByName('ICM_SUBTOTAL').AsCurrency);
  E_VL_ICMS.Text := FloatToStrF(It_VL_Nr_ICMS, ffFixed, 10, 2);

  //Valor da Base do ICMS com Substituição Tributária
  Lc_Qr_Acao.Active := False;
  Lc_Qr_Acao.SQL.Clear;
  Lc_Qr_Acao.SQL.Add('SELECT CAST(COALESCE(SUM(ICM_VL_BC_ST), 0) AS NUMERIC(18, 2)) AS ICM_SUBTOTAL '+
                      ' FROM TB_ITENS_ICMS                        '+
                      ' WHERE (ICM_CODNFL=:ICM_CODNFL)            ');
  Lc_Qr_Acao.ParamByName('ICM_CODNFL').AsInteger := It_Cd_Nota;
  Lc_Qr_Acao.Active := True;
  It_VL_Bc_St_ICMS := Lc_Qr_Acao.FieldByName('ICM_SUBTOTAL').AsCurrency;
  E_Vl_Bs_Icms_St.Text := FloatToStrF(It_VL_Bc_St_ICMS, ffFixed, 10, 2);

  //Valor do ICMS com Substituição Tributária
  Lc_Qr_Acao.Active := False;
  Lc_Qr_Acao.SQL.Clear;
  Lc_Qr_Acao.SQL.Add('SELECT CAST(COALESCE(SUM(ICM_VL_ST), 0) AS NUMERIC(18, 2)) AS ICM_SUBTOTAL ' +
                     'FROM TB_ITENS_ICMS ' +
                     'WHERE (ICM_CODNFL=:ICM_CODNFL)');
  Lc_Qr_Acao.ParamByName('ICM_CODNFL').AsInteger := It_Cd_Nota;
  Lc_Qr_Acao.Active := True;
  It_Vl_St_ICMS := Lc_Qr_Acao.FieldByName('ICM_SUBTOTAL').AsCurrency;
  E_Vl_Icms_St.Text := FloatToStrF(It_Vl_St_ICMS, ffFixed, 10, 2);

  //Valor dos produtos
  Lc_Qr_Acao.Active := False;
  Lc_Qr_Acao.SQL.Clear;
  Lc_Qr_Acao.SQL.Add('SELECT CAST(COALESCE(SUM((ITF_QTDE * ITF_VL_UNIT)), 0) AS NUMERIC(18, 2)) AS ITF_SUBTOTAL ' +
                     'FROM TB_ITENS_NFL tb_itens_nfl' +
                     '  INNER JOIN TB_PRODUTO tb_produto ' +
                     '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) ' +
                     'WHERE (PRO_TIPO <> ''S'') AND (ITF_CODPED=:ITF_CODPED) '+
                     'AND (ITF_OPER = ''V'') ');
  Lc_Qr_Acao.ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
  Lc_Qr_Acao.Active := True;
  It_VL_TL_Produtos := Lc_Qr_Acao.FieldByName('ITF_SUBTOTAL').AsCurrency;
  E_VL_Produto.Caption := FloatToStrF(It_VL_TL_Produtos , ffFixed, 10, 2);

  //Valor do IPI
  Lc_Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Lc_Qr_Acao.SQL.Clear;
  Lc_Qr_Acao.SQL.Add('SELECT ((ITF_VL_UNIT * ITF_QTDE) * (IPI_AQ_NR/100))  AS IPI_SUBTOTAL ' +
                     'FROM TB_ITENS_IPI tb_itens_ipi ' +
                     '  INNER JOIN TB_ITENS_NFL tb_itens_nfl ' +
                     '  ON (tb_itens_nfl.ITF_CODIGO = tb_itens_ipi.IPI_CODITF) ' +
                     'WHERE (IPI_CODNFL=:IPI_CODNFL)');
  Lc_Qr_Acao.ParamByName('IPI_CODNFL').AsInteger := It_Cd_Nota;
  Lc_Qr_Acao.Active := True;
  Lc_Qr_Acao.FetchAll;
  Lc_Qr_Acao.First;
  It_VL_TL_IPI := 0;
  while not Lc_Qr_Acao.Eof do
    begin
    It_VL_TL_IPI := It_VL_TL_IPI + Lc_Qr_Acao.FieldByName('IPI_SUBTOTAL').AsCurrency;
    Lc_Qr_Acao.Next;
    end;
  E_VL_IPI.Text := FloatToStrF(It_VL_TL_IPI, ffFixed, 10, 2);

  It_Vl_TL_NotaFiscal := (It_VL_TL_Produtos  + It_VL_TL_IPI) - It_VL_Tl_Desconto + It_Vl_St_ICMS + It_Vl_TL_Frete + It_Vl_TL_Seguro + It_Vl_TL_Outras;
  E_VL_Nota.Caption := FloatToStrF(It_Vl_TL_NotaFiscal, ffFixed, 10, 2);
  FreeAndNil(Lc_Qr_Acao);   
end;

function TFr_Fatura_Dsp.Fc_VerificaEntregaDiferente(Pc_cd_cliente,Pc_cd_Pedido:Integer): Boolean;
var
  Lc_SqlTxt: String;
  Lc_Cd_Endereco, Lc_Cd_Entrega: Integer;
  Lc_qt_Endereco : Integer;
  Lc_DocFiscal : String;
begin
  Result := true;

  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.Sql.Clear;

  Lc_SqlTxt := 'SELECT                        '+
               '   END_CODIGO,                 '+
               '   END_PRINCIPAL              '+
               'FROM TB_ENDERECO EDD          '+
               'WHERE END_CODEMP =:END_CODEMP ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('END_CODEMP').AsInteger := Pc_cd_cliente;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  Lc_qt_Endereco := Qr_Acao.RecordCount;
  if Lc_qt_Endereco > 1 then
    Qr_Acao.Locate('END_PRINCIPAL','S',[]);
  Lc_Cd_Endereco := Qr_Acao.FieldByName('END_CODIGO').AsInteger;

  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.Sql.Clear;
  Lc_SqlTxt := '';
  Lc_SqlTxt := 'SELECT                                  '+
               '  END_CODIGO,                           '+
               '  END_CNPJ,                             '+
               '  EMP_PESSOA,                           '+
               '  PED_CODEND                            '+
               'FROM TB_ENDERECO EDD                    '+
               '  INNER JOIN TB_PEDIDO PED              '+
               '  ON (PED.PED_CODEND = EDD.END_CODIGO)  '+
               '  INNER JOIN TB_EMPRESA                 '+
               '  ON (EMP_CODIGO = PED.PED_CODEMP)      '+
               'WHERE PED.PED_CODIGO=:PED_CODIGO        ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;

  //Neste caso tem apenas um endereço e não precisa comparar
  if (Lc_qt_Endereco = 1) then
    Begin
    Result := true;
    Exit;
    end;
    
  Lc_Cd_Entrega  := Qr_Acao.FieldByName('PED_CODEND').AsInteger;

  If Lc_cd_Endereco <> Lc_cd_Entrega then
  Begin
    Lc_DocFiscal := ValidDocFiscal(Qr_Acao.FieldByName('END_CNPJ').AsString);
    if not (Lc_DocFiscal = OK) then
    Begin
      TMsgSetes.ErroCampo('Documento Fiscal',concat(Lc_DocFiscal,' para o endereço de entrega'));
      E_Cpf_CNPJ.SetFocus;
      Result := False;
      Exit;
    end;
  end;
end;

function TFr_Fatura_Dsp.fc_ValidaFaturamento(): Boolean;
Var
  Lc_Aux : String;
  Lc_Nr_Nota: Integer;

begin
  Result:=true;
  //Verifica Inventario
  if not Fc_ValidaDataPedido(E_Dt_Emissao.Date) then
    Begin
    Result := FAlse;
    E_Dt_Emissao.SetFocus;
    E_Dt_Emissao.Date := Date;
    Exit;
    end;

  if CkBx_Nota_Manual.Checked then
    Begin
    if not(InputQuery('Informar o Número da Nota Fiscal ', 'Número', Lc_Aux)) then
      Begin
      Result := False;
      exit;
      end;
    If trim(Lc_Aux) = '' then
      Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número da nota não foi informado !'+EOLN+
                     'Se escolheu informar manualmente digite um número'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
      end;
    if Fc_VerificaNumeroNota('P',0,Lc_Aux) then
      Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número de nota Informada já existe !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
      end;
    Lc_Aux     := Fc_RemoveCaracterInformado(Lc_Aux, '.');
    Lc_Aux     := Fc_RemoveCaracterInformado(Lc_Aux, ',');
    Lc_Aux     := Fc_RemoveCaracterInformado(Lc_Aux, '/');
    Lc_Aux     := Fc_RemoveCaracterInformado(Lc_Aux, '-');
    Lc_Aux     := Fc_RemoveCaracterInformado(Lc_Aux, ' ');
    It_Nr_Nota := StrToInt(Lc_Aux);
    end;

  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Pedido.Active := True;
  Qr_Pedido.FetchAll;
  Qr_Pedido.First;
  If ChBx_AutorizacaoNFE.Checked then
    begin


    if not Fc_VerificaEntregaDiferente(It_cd_empresa,It_Cd_Pedido) then
      Begin
      Result := False;
      exit;
      end;

    if (Dblcb_Modal_Frete.KeyValue = 0) then
      begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Modalidade de frete não foi preenchida.' + EOLN +
                   ' Favor preencher e tentar novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
      end;
  end;

  if (Fc_Tb_Geral('L','VDA_VALIDA_TRANSP_FAT','N') = 'S') then
    begin
    if (DBLCB_Transportadora.KeyValue <= 0) then
      begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Transportadora não escolhido.' + EOLN +
                   'Preenchar a Transportadora.' + EOLN,
                   ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
      end;
    end;


  //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
  Fc_AuditoriaEstoquePedido(It_Cd_Pedido,'N');

end;

procedure TFr_Fatura_Dsp.Pc_GravaUltimasConfiguracoes;
Begin
  If Trim(Dblcb_Modal_Frete.Text) <> '' then
    Fc_Tb_Geral('G', 'FAT_TIPOFRETE', IntToStr(Dblcb_Modal_Frete.KeyValue))
  else
    Fc_Tb_Geral('G', 'FAT_TIPOFRETE', '0');

  Fc_Tb_Geral('G', 'FAT_PATHETIQUETA', E_PortaImpressao_dsp.Text);    
  Fc_Tb_Geral('G', 'FAT_SALTOETIQUETA', E_SaltoImpressao_dsp.Text);

end;

procedure TFr_Fatura_Dsp.Pc_Faturar_Venda_Servico;
Begin
  It_Nr_Pedido := Qr_PedidoPED_NUMERO.AsInteger;
  Pc_Define_FormatoRegional;
  It_Result_Fatura := Fc_Faturar_Normal;
  if It_Result_Fatura then
  Begin
    //Gera o Financeiro
    Pc_GeraContasReceber(IBT_Faturamento,
                         E_Dt_Emissao.Date,
                         it_Cd_Pedido,
                         IntToStr(It_Nr_Pedido),
                         It_Cd_Nota,
                         StrZero(It_Nr_Nota,6,0),
                         It_cd_Empresa,
                         Qr_PedidoPED_CODFPG.AsInteger,
                         StrToIntDef(Copy(Qr_PedidoPED_PRAZO.AsString,1,3),1),
                         Qr_PedidoPED_PRAZO.AsString,
                         StrToFloatDef(E_VL_Nota.Caption,0));
    //Posiciona para o Cadastro da minha Empresa
    DM.Qr_MhaEmpresa.Active:=FALSE;
    DM.Qr_MhaEmpresa.Active:=True;
    DM.Qr_MhaEmpresa.First;
    DM.Qr_MhaEmpresa.Locate('EMP_CODIGO',Gb_CodMha, []);
    Pc_GravaUltimasConfiguracoes;
    Pc_ImprimeEtiquetaVolume;
    Pc_ImpressaoAutomaticaBoleto(It_Cd_Pedido);
    It_Cd_Pedido := 0;
    Fr_Conferente.It_Fatura_OK := True;
    Close;
  end;
end;

procedure TFr_Fatura_Dsp.SB_ConfirmarClick(Sender: TObject);
begin
  Try
    Self.Enabled := False;
    if fc_ValidaFaturamento then
      Pc_Faturar_Venda_Servico;
  Finally
    Self.Enabled := True;
  end;
end;

procedure TFr_Fatura_Dsp.SB_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Fatura_Dsp.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Fatura_Dsp.DBLCB_TransportadoraKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Transportadora.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Fatura_Dsp.FormCreate(Sender: TObject);
Var
  Lc_Nfe : boolean;
begin
  PEdido := TControllerPedido.create(Self);
  Pc_AtivarTabela;
  //CONFIGURAÇÕES DA NFE
  IF (Fc_VerificaFormularioDisponivel('Fr_GeraNFe')) then
    Begin
    ChBx_AutorizacaoNFE.Enabled := True;
    ChBx_AutorizacaoNFE.State := cbChecked;
    It_Usa_Nfe := True;
    ChBx_NF_Informatizada.State := cbUnchecked;
    ChBx_NF_Informatizada.Enabled := False;
    end
  else
    Begin
    ChBx_AutorizacaoNFE.Enabled := False;
    ChBx_AutorizacaoNFE.State := cbUnchecked;
    It_Usa_Nfe := False;
    ChBx_NF_Informatizada.State := cbUnchecked;
    ChBx_NF_Informatizada.Enabled := true;
    end;
end;


procedure TFr_Fatura_Dsp.Sb_TransportadoraClick(Sender: TObject);
begin
  if not Assigned(Fr_Transportadora)then (Application.CreateForm(TFr_Transportadora, Fr_Transportadora));
  Fr_Transportadora.ShowModal;
end;

procedure TFr_Fatura_Dsp.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F10: if SB_Confirmar.Enabled then
               SB_ConfirmarClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then
               SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Fatura_Dsp.FormShow(Sender: TObject);
var
  CanSelect: boolean;
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_Inicia_Variaveis;
  Pc_AtivarTabela;
end;

procedure TFr_Fatura_Dsp.Pc_SelecionaItensNota(Fc_Nr_Itens: Integer; Fc_Inicio: Integer; Fc_TP_Produto: string);
var
   Lc_SqlTxt: string;
begin
   Qr_Itens.Active := False;
   Qr_Itens.SQL.Clear;
   Lc_SqlTxt := 'SELECT ';
   if (fc_Nr_Itens > 0) then
      Lc_SqlTxt := Lc_SqlTxt + ' FIRST ' + IntToStr(Fc_Qt_ItensNota) + ' SKIP ' + IntToStr(Fc_Inicio);
   Lc_SqlTxt := Lc_SqlTxt +
      '  ITF_CODIGO, ITF_CODPED,  ITF_CODNFL,  ITF_CODPRO,  PRO_SUB_TRIB,   PRO_CODIGOFAB,   PRO_DESCRICAO,    '+
      '  ITF_QTDE, ITF_VL_UNIT, ITF_AQ_COM,  MED_ABREVIATURA, PRO_VL_CUSTOMED, ITF_AQ_DESC, ITF_VL_DESC,       '+
      '  ITF_AQ_COM, ITF_AQ_IPI, ITF_AQ_ICMS, ITF_CODEST, ITF_CODTPR, ITF_ESTOQUE, PRO_ORIGEM, PRO_CODIGONCM,  '+
      '  PRO_TRIBUTACAO, PRO_CODIGOBAR '+
      'FROM TB_ITENS_NFL Tb_itens_nfl '+
      '   INNER JOIN TB_PEDIDO Tb_pedido '+
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO) '+
      '   INNER JOIN TB_PRODUTO Tb_produto '+
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) '+
      '   INNER JOIN TB_MEDIDA tb_medida  '+
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (ITF_OPER = ''V'') ';                                                  
     if Fc_TP_Produto = 'S' then
       Lc_SqlTxt:=Lc_SqlTxt+ 'AND (PRO_TIPO = ''S'') '
     else
       Lc_SqlTxt:=Lc_SqlTxt+ 'AND (PRO_TIPO <> ''S'') ';

   Qr_Itens.SQL.Add(Lc_SqlTxt);
   Qr_Itens.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
   Qr_Itens.Active := True;
   Qr_Itens.FetchAll;
end;

procedure TFr_Fatura_Dsp.Pc_AtualizarItensNota;
var
  Lc_Despachar:String;
  Lc_Imp_Aprox :TStringList;  
begin
  //Atualiza os itens Primarios da nota
  Qr_Itens.First;
  Lc_Despachar :='S';
  Lc_Imp_Aprox := TStringList.Create;  
  while not Qr_Itens.Eof do
  begin
    Fc_ImpostoAproximado(Lc_Imp_Aprox,Qr_Itens.FieldByName('PRO_CODIGONCM').AsString,
                                         Qr_Itens.FieldByName('PRO_ORIGEM').AsString);    
    Fc_AtualizaItensNfl(IBT_Faturamento,
                        'E',
                        Qr_Itens.FieldByName('ITF_CODIGO').AsInteger,
                        It_Cd_Pedido,
                        It_Cd_Nota,
                        Qr_Itens.FieldByName('ITF_CODPRO').AsInteger,
                        Qr_Itens.FieldByName('ITF_QTDE').AsFloat,
                        Qr_Itens.FieldByName('PRO_VL_CUSTOMED').AsCurrency,
                        Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency,
                        Qr_Itens.FieldByName('ITF_AQ_DESC').AsFloat,
                        Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency,
                        Qr_Itens.FieldByName('ITF_AQ_COM').AsFloat,
                        'V',
                        Qr_Itens.FieldByName('ITF_ESTOQUE').AsString,
                        Lc_Despachar,
                        Qr_Itens.FieldByName('ITF_AQ_IPI').AsCurrency,
                        Qr_Itens.FieldByName('ITF_AQ_ICMS').AsCurrency,
                        Qr_Itens.FieldByName('ITF_CODEST').AsInteger,
                        Qr_Itens.FieldByName('ITF_CODTPR').AsInteger,
                        'S',
                        StrToFloatDef(Lc_Imp_Aprox.Strings[3],0));
    Qr_Itens.Next;
  end;
  FreeAndNil(Lc_Imp_Aprox);
end;

procedure TFr_Fatura_Dsp.Pc_CalculaTotalProduto;
begin
   Qr_Itens.First;
   It_Vl_TL_Pedido := 0;
   while not Qr_Itens.Eof do
   begin
      It_Vl_TL_Pedido := It_Vl_TL_Pedido + (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat);
      It_Vl_TL_Pedido := It_Vl_TL_Pedido - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
      Qr_Itens.Next;
   end;
end;

procedure TFr_Fatura_Dsp.Pc_Calcula_Impostos;
var
  Lc_Tx_Prop: Real;
  Lc_VL_frete : Real;
  Lc_Vl_Seguro :Real;
  Lc_Vl_Outras :Real;
  Lc_I, Lc_Nr_Registros : Integer;
begin
  Qr_Itens.FetchAll;
  Lc_Nr_Registros := Qr_Itens.RecordCount;
  Lc_VL_frete :=0;
  Lc_Vl_Seguro :=0;
  Lc_Vl_Outras :=0;
  Qr_Itens.First;
  For Lc_I := 1 to Lc_Nr_Registros do
    begin
    Pc_Limpa_Impostos_Pedidos(Qr_Itens.FieldByName('ITF_CODIGO').AsInteger);
    if (Lc_I < Lc_Nr_Registros) then
      Begin
      Lc_Tx_Prop := (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat);
      Lc_Tx_Prop := Lc_Tx_Prop / It_Vl_TL_Pedido;
      It_VL_frete_Produto := It_VL_TL_Frete * Lc_Tx_Prop;
      It_Vl_Seguro_Produto := It_Vl_TL_Seguro * Lc_Tx_Prop;
      It_Vl_Outras_Produto := It_Vl_TL_Outras * Lc_Tx_Prop;
      //Acumula o valor em variavel local
      Lc_VL_frete  := Lc_VL_frete + StrToFloatDef(FloatToStrf(It_VL_frete_Produto,ffFixed,10,2),0);
      Lc_Vl_Seguro := Lc_Vl_Seguro + StrToFloatDef(FloatToStrf(It_Vl_Seguro_Produto,ffFixed,10,2),0);
      Lc_Vl_Outras := Lc_Vl_Outras + StrToFloatDef(FloatToStrf(It_Vl_Outras_Produto,ffFixed,10,2),0);
      end
    else
      Begin
      It_VL_frete_Produto  := It_VL_TL_Frete  - Lc_VL_frete;
      It_Vl_Seguro_Produto := It_Vl_TL_Seguro - Lc_Vl_Seguro;
      It_Vl_Outras_Produto := It_Vl_TL_Outras - Lc_Vl_Outras;
      end;
    Pc_AtualizarItensICMS;
    Pc_AtualizarItensIPI;
    Pc_AtualizarItensPIS;
    Pc_AtualizarItensCOFINS;
    Qr_Itens.Next;
    end;
end;

procedure TFr_Fatura_Dsp.Pc_AtualizarItensICMS;
Begin
  case Fc_Tributacao(Qr_Itens.FieldByName('ITF_CODPRO').AsInteger,
                     Qr_Itens.FieldByName('PRO_SUB_TRIB').AsString,
                     Qr_Itens.FieldByName('PRO_ORIGEM').AsString,
                     Qr_Itens.FieldByName('PRO_TRIBUTACAO').AsString,
                     Qr_Itens.FieldByName('PRO_CODIGONCM').AsString) of
    0: Pc_Condicao_STDPRREV;
    1: Pc_Condicao_STDPRCSD;
    2: Pc_Condicao_STDPRREVREQ;
    3: Pc_Condicao_NRDPRREV;
    4: Pc_Condicao_NRDPRCSD;
    5: Pc_Condicao_STFPRREV;
    6: Pc_Condicao_STFPRCSD;
    7: Pc_Condicao_NRFPRREV;
    8: Pc_Condicao_NRFPRCSD;
  else
    begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não foi encontrada a tributação para o produto:' + EOLN +
                   Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString +' - ' + Qr_Itens.FieldByName('PRO_DESCRICAO').AsString + EOLN +
                   'Verfique as regras de Tributação e tente Novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    exit;
    end;
  end;
  //Calculo do Credito de ICMS do Simples Nacional
  It_VL_Cred_Apro_ICms := 0;
  if It_Aq_Calc_Cred_ICMS > 0 then
    It_VL_Cred_Apro_ICms := (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat) * (It_Aq_Calc_Cred_ICMS/100);

  if It_Cd_Natureza = 0 then It_Cd_Natureza := It_Cd_CFOP;
  Pc_AtualizaItensICMS(IBT_Faturamento,
                       0,
                       It_Cd_Nota,
                       Qr_Itens.FieldByName('ITF_CODIGO').AsInteger,
                       It_CODTBI_ICMS_NR,
                       It_CODTBI_ICMS_SN,
                       Qr_Itens.FieldByName('PRO_ORIGEM').AsString,
                       It_Md_Bc_ICMS,
                       It_Aq_Rd_BC_ICMS,
                       It_Vl_Bc_ICMS,
                       It_Aq_Nr_ICMS,
                       It_Aq_Rd_Nr_ICMS,
                       It_VL_Nr_ICMS,
                       It_Md_Bc_St_ICMS,
                       It_Aq_Rd_Bc_St_ICMS,
                       Gb_Mg_VA_St_Icms,
                       It_VL_Bc_St_ICMS,
                       Gb_Aq_St_ICMS,
                       It_Aq_Rd_St_ICMS,
                       It_Vl_St_ICMS,
                       It_CodDsi_ICMS,
                       It_VL_Bc_St_Ret_ICMS,
                       It_VL_St_Ret_ICMS,
                       It_Partilha,
                       It_Repasse_ICMS,
                       It_Vl_Bc_Ret_ICMS,
                       It_Vl_Ret_ICMS,
                       It_Aq_Calc_Cred_ICMS,
                       It_VL_Cred_Apro_ICms,
                       It_VL_frete_Produto,
                       It_Vl_Seguro_Produto,
                       It_Vl_Outras_Produto,
                       It_Cd_CFOP,
                       It_Dest_ICMS,
                       It_Cd_Observacao);
end;

procedure TFr_Fatura_Dsp.Pc_AtualizarItensIPI;
begin
  if (Qr_Itens.FieldByName('ITF_AQ_IPI').AsCurrency > 0) or (It_AQ_NR_IPI > 0)  then
    BEgin
    if (It_AQ_NR_IPI = 0)  then
      It_AQ_NR_IPI := Qr_Itens.FieldByName('ITF_AQ_IPI').AsCurrency;
    It_VL_BC_IPI := (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_QT_UNID_IPI := 0; //Qr_Itens.FieldByName('ITF_QTDE').AsFloat;
    It_VL_UNID_IPI := 0; //It_VL_BC_IPI * (It_AQ_NR_IPI/100);    
    Pc_AtualizaItensIPI(IBT_Faturamento,
                        'I',
                        0,                                            // IPI_CODIGO
                        It_Cd_Nota,                                   // IPI_CODNFL
                        Qr_Itens.FieldByName('ITF_CODIGO').AsInteger, // IPI_CODITF
                        It_CodTbI_IPI,                                // IPI_CODTBI
                        It_Cl_Enqd_IPI,                               // IPI_CL_ENQD
                        It_CNPJ_PROD_IPI,                             // IPI_CNPJ_PROD
                        It_CD_SELO_IPI,                               // IPI_CD_SELO
                        It_QT_SELO_IPI,                               // IPI_QT_SELO
                        It_CD_ENQD_IPI,                               // IPI_CD_ENQD
                        It_VL_BC_IPI,                                 // IPI_VL_BC
                        It_AQ_NR_IPI,                                 // IPI_AQ_NR
                        It_QT_UNID_IPI,                               // IPI_QT_UNID
                        It_VL_UNID_IPI);                              // IPI_VL_UNID
    end;
end;

procedure TFr_Fatura_Dsp.Pc_AtualizarItensPIS;
begin
  if It_AQ_NR_PIS > 0 then
    begin
    It_VL_BC_PIS := (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_NR_PIS := It_VL_BC_IPI * (It_AQ_NR_PIS / 100);
    Pc_AtualizaItensPIS(IBT_Faturamento,
                        'I',
                        0,                                                    // PIS_CODIGO
                        It_Cd_Nota,                                            // PIS_CODNFL
                        Qr_Itens.FieldByName('ITF_CODIGO').AsInteger,         // PIS_CODITF
                        It_CodTbp_PIS,                                        // PIS_CODTBP
                        It_VL_BC_PIS,                                         // PIS_VL_BC
                        It_AQ_NR_PIS,                                         // PIS_AQ_NR
                        It_VL_NR_PIS,                                         // PIS_VL_NR
                        It_QT_VDA_PIS,                                        // PIS_QT_VDA
                        It_VL_AQ_PIS);                                        // PIS_VL_AQ
   end;
end;

procedure TFr_Fatura_Dsp.Pc_AtualizarItensCOFINS;
begin
  if It_AQ_NR_CFS > 0 then
    begin
    It_VL_BC_CFS := (Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency * Qr_Itens.FieldByName('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_NR_CFS := It_VL_BC_CFS * (It_AQ_NR_CFS / 100);
    Pc_AtualizaItensCFS(IBT_Faturamento,
                        'I',
                        0,                                                    // CFS_CODIGO
                        It_Cd_Nota,                                            // CFS_CODNFL
                        Qr_Itens.FieldByName('ITF_CODIGO').AsInteger,         // CFS_CODITF
                        It_CODTBC_CFS,                                        // CFS_CODTBC
                        It_VL_BC_CFS,                                         // CFS_VL_BC
                        It_AQ_NR_CFS,                                         // CFS_AQ_NR
                        It_VL_NR_CFS,                                         // CFS_VL_NR
                        It_QT_UNID_CFS,                                       // CFS_QT_UNID
                        It_VL_AQ_CFS);                                       // CFS_VL_AQ
   end;
end;



function TFr_Fatura_Dsp.Fc_ConfirmaValores(): boolean;
begin
  If Pg_Resumo.ActivePageIndex <> 0 then Pg_Resumo.ActivePageIndex := 0;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Favor Conferir os valores totais da nota.' + EOLN + EOLN +
                      'Confirmar os Valores ?',
                      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
    result := True;
    end
  else
    begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Operação Abortada pelo Usuário.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
                   Result := False;
    end;
end;


procedure TFr_Fatura_Dsp.Pc_Obs_NotaFiscal;
Begin
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  if (fc_Tb_Geral('L','VDA_OBS_FINANCEIRA','S') ='S') then
    Pc_Obs_Financeira;
  Pc_Obs_Manual;
  Pc_Obs_Regra_Geral;
  if (It_Cd_CRT = 3) then
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
  if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
end;

procedure TFr_Fatura_Dsp.Pc_Obs_Financeira;
var
   Lc_I: Integer;
   Lc_Fim: Integer;
   lc_texto: string;
   Lc_Par: Boolean;
begin
  E_M_Nota.Clear;
  if Length(E_M_Nota.Text) > 0 then
    Begin
    Pc_Observacao(IBT_Faturamento,
                  'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'A',
                   E_M_Nota.Text);
    end;
end;

Procedure TFr_Fatura_Dsp.Pc_Obs_Manual;
Begin
  Pc_InfoRevendaVeiculos(E_Obs,It_Cd_Pedido);
  if Length(E_Obs.Text) > 0 then
    Begin
    Pc_Observacao(IBT_Faturamento,
                  'I',
                   0,
                   0,
                   It_Cd_Nota,
                  'M',
                  E_Obs.Text);
    end;
end;


Procedure TFr_Fatura_Dsp.Pc_Obs_Regra_Geral;
var
  Lc_SqlTxt : String;
  Lc_Texto: TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'SELECT DISTINCT OBS_CODIGO, OBS_DETALHES '+
               'FROM TB_OBSERVACAO tb_observacao         '+
               'WHERE (OBS_GERAL = ''2'')                '+
               ' AND (OBS_CODMHA =:OBS_CODMHA)           ';
  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  Qr_Acao.Active := True;
  Qr_Acao.First;
  while not Qr_Acao.Eof do
    begin
    Lc_Texto := TMemoryStream.Create;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    //Registra a Observação
    Pc_Observacao(IBT_Faturamento,
                  'I',
                  0,
                  0,
                  It_Cd_Nota,
                  'F',
                  E_M_Fisco.Text);
    FreeAndNil(Lc_Texto);
    Qr_Acao.Next;
    end;
end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST00;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select distinct                      '+
               '  OBS_DETALHES                        '+
               'FROM TB_ITENS_ICMS                   '+
               '  INNER JOIN TB_TRIB_ICMS_NR         '+
               '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
               '  INNER JOIN TB_OBSERVACAO           '+
               '  ON (OBS_CODIGO = ICM_CODOBS)       '+
               'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
               ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
               ' AND (TBI_GRUPO Like ''00'')        ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
 
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST10;
Var
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select                               '+
               '   CAST(COALESCE(SUM(ICM_VL_BC_ST), 0) AS NUMERIC(18, 2)) ICM_bASE        '+
               '  ,CAST(COALESCE(SUM(ICM_VL_ST), 0) AS NUMERIC(18, 2)) ICM_VALOR          '+
               '  ,OBS_DETALHES                      '+
               'FROM TB_ITENS_ICMS                   '+
               '  INNER JOIN TB_TRIB_ICMS_NR         '+
               '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
               '  INNER JOIN TB_OBSERVACAO           '+
               '  ON (OBS_CODIGO = ICM_CODOBS)       '+
               'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
               '  AND (TBI_GRUPO = ''10'')           '+
               ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
               'GROUP BY OBS_DETALHES                ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_vl_Bc_St := Qr_Acao.FieldByName('ICM_BASE').AsFloat;
    Lc_vl_St    := Qr_Acao.FieldByName('ICM_VALOR').AsCurrency;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&b', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 2&b representa o Segundo valor da Observação que é a valor
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
  
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);
end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST20;
Var
  Lc_Aq_Rd_bc : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
Begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select DISTINCT                      '+
               '   ICM_AQ_RD_BC_NR                   '+
               '  ,OBS_DETALHES                      '+
               'FROM TB_ITENS_ICMS                   '+
               '  INNER JOIN TB_TRIB_ICMS_NR         '+
               '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
               '  INNER JOIN TB_OBSERVACAO           '+
               '  ON (OBS_CODIGO = ICM_CODOBS)       '+
               'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
               '  AND (TBI_GRUPO = ''20'')           '+
               ' AND (OBS_CODMHA =:OBS_CODMHA)       ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Aq_Rd_bc := Qr_Acao.FieldByName('ICM_AQ_RD_BC_NR').AsFloat;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&v', FloatToStrF(Lc_Aq_Rd_bc,ffFixed,10,2), [rfreplaceAll]));

    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);
end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST30;
Var
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select                               '+
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
               'GROUP BY OBS_DETALHES                ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_vl_Bc_St := Qr_Acao.FieldByName('ICM_BASE').AsFloat;
    Lc_vl_St    := Qr_Acao.FieldByName('ICM_VALOR').AsCurrency;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 2&b representa o Segundo valor da Observação que é a valor
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
  
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST40;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select distinct                      '+
               '  OBS_DETALHES                        '+
               'FROM TB_ITENS_ICMS                   '+
               '  INNER JOIN TB_TRIB_ICMS_NR         '+
               '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
               '  INNER JOIN TB_OBSERVACAO           '+
               '  ON (OBS_CODIGO = ICM_CODOBS)       '+
               'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
               ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
               ' AND (TBI_GRUPO Like ''4%'')        ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
 
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST50;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select distinct                      '+
               '  OBS_DETALHES                       '+
               'FROM TB_ITENS_ICMS                   '+
               '  INNER JOIN TB_TRIB_ICMS_NR         '+
               '  ON (TBI_CODIGO = ICM_CODTBI_NR)    '+
               '  INNER JOIN TB_OBSERVACAO           '+
               '  ON (OBS_CODIGO = ICM_CODOBS)       '+
               'WHERE (ICM_CODNFL=:NFL_CODIGO)       '+
               ' AND (OBS_CODMHA =:OBS_CODMHA)       '+
               ' AND (TBI_GRUPO Like ''5%'')        ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
 
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST60;
Var
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select                               '+
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
               'GROUP BY OBS_DETALHES                ';

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_vl_Bc_St := Qr_Acao.FieldByName('ICM_BASE').AsFloat;
    Lc_vl_St    := Qr_Acao.FieldByName('ICM_VALOR').AsCurrency;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 2&b representa o Segundo valor da Observação que é a valor
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));

    
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
     if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST70;
Var
  Lc_Aq_rd_Bc_Nr : Real;
  Lc_vl_Bc_St : Real;
  Lc_vl_St : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_vl_Bc_St := Qr_Acao.FieldByName('ICM_BASE').AsFloat;
    Lc_vl_St    := Qr_Acao.FieldByName('ICM_VALOR').AsCurrency;
    Lc_Aq_rd_Bc_Nr := Qr_Acao.FieldByName('ICM_AQ_RD_BC_NR').AsFloat;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o primeiro valor da Observação que é a base de calculo
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 2&b representa o Segundo valor da Observação que é a valor
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 3&R representa o Terceiro Valor da Observação que é a Redução da Base de Calculo
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '3&v', FloatToStrF(Lc_vl_Bc_St,ffFixed,10,2), [rfreplaceAll]));

    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
     if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);
end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST80;
Begin

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CST90;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
 
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN101;
Var
  Lc_Aq : Real;
  Lc_VL : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Aq :=  StrToFloatDef(Fc_Tb_Geral('L','GRL_G_AQ_CRED_ICMS',''),0);
    Lc_VL := Qr_Acao.FieldByName('ICM_VL').AsCurrency;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o Primeiro valor da Observação que é a valor
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&v', FloatToStrF(Lc_VL,ffFixed,10,2), [rfreplaceAll]));

    // O simbolo 2&b representa o Segunda valor da Observação que é a Aliquota
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '2&v', FloatToStrF(Lc_Aq,ffFixed,10,2), [rfreplaceAll]));

 
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);
end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN102;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);

    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);
end;



procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN103;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);

    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN201;
Var
  Lc_vl_bc_st : Real;
  Lc_vl_st : Real;
  Lc_Aq : Real;
  Lc_VL : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'select distinct                      '+
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

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_vl_bc_st := Qr_Acao.FieldByName('ICM_bASE').AsFloat;
    Lc_vl_st := Qr_Acao.FieldByName('ICM_VALOR').AsCurrency;    
    Lc_Aq := Qr_Acao.FieldByName('ICM_AQ').AsFloat;
    Lc_VL := Qr_Acao.FieldByName('ICM_VL').AsCurrency;
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o primeiro valor da Observação que é a base
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&v', FloatToStrF(Lc_Aq,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 2&b representa o Segundo valor da Observação que é a valor do ICMS_sT
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '2&v', FloatToStrF(Lc_VL,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 1&b representa o Terceiro valor da Observação que é a Aliquota
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '3&v', FloatToStrF(Lc_Aq,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 2&b representa o Quarta valor da Observação que é a valor
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '4&v', FloatToStrF(Lc_VL,ffFixed,10,2), [rfreplaceAll]));
 
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
     if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN202;
Var
  Lc_vl_bc_st : Real;
  Lc_vl_st : Real;
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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

  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_vl_bc_st := Qr_Acao.FieldByName('ICM_bASE').AsFloat;
    Lc_vl_st := Qr_Acao.FieldByName('ICM_VALOR').AsCurrency;    
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    // O simbolo 1&b representa o primeiro valor da Observação que é a base
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '1&v', FloatToStrF(Lc_vl_bc_st,ffFixed,10,2), [rfreplaceAll]));
    // O simbolo 2&b representa o Segundo valor da Observação que é a valor do ICMS_sT
    E_M_Fisco.Text := (StringReplace(E_M_Fisco.Text, '2&v', FloatToStrF(Lc_vl_st,ffFixed,10,2), [rfreplaceAll]));
 
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN203;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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


  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN300;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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


  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin

    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN400;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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


  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin

    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN500;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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


  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin

    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);

end;

procedure TFr_Fatura_Dsp.Pc_Obs_CSOSN900;
Var
  Lc_SqlTxt : String;
  Lc_texto :TMemoryStream;
begin
  Lc_texto := TMemoryStream.Create;
  E_M_Fisco.Clear;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  Qr_Acao.SQL.Clear;
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


  Qr_Acao.SQL.Add(Lc_SqlTxt);
  Qr_Acao.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;  
  Qr_Acao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  Qr_Acao.First;
  IF (Qr_Acao.RecordCount > 0) THEN
    Begin
    Lc_Texto.LoadFromStream(Qr_Acao.CreateBlobStream(Qr_Acao.FieldByName('OBS_DETALHES'), bmRead));
    E_M_Fisco.Lines.LoadFromStream(Lc_Texto);
    //Registra a Observação
     Pc_Observacao(IBT_Faturamento,
                   'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'F',
                   E_M_Fisco.Text);
     if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    end;
  FreeAndNil(Lc_texto);
end;

procedure TFr_Fatura_Dsp.Pc_Gera_NotaFiscal;
var
  Lc_SerieNF: Integer;
  Lc_TpAmbiente: Integer;
  Lc_Transportadora : Integer;
  Lc_Data : String;
begin
  IF It_Usa_Nfe then
    Begin
    Qr_Nf_Eletronica.Active := False;
    Qr_Nf_Eletronica.ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
    Qr_Nf_Eletronica.Active := True;

    Lc_TpAmbiente := StrToIntDef(Qr_Nf_Eletronica.FieldByName('NFE_EMISSAO').AsString,0);
    If (Lc_TpAmbiente = 2) then
      Lc_SerieNF := 900
    else
      Lc_SerieNF := 1;
    end
  else
    Lc_SerieNF := 1;
  //Define a Transportadora
  if Trim(DBLCB_Transportadora.text) <> '' then
    Lc_Transportadora := DBLCB_Transportadora.KeyValue
  else
    Lc_Transportadora := 0;
 //Define Numero da Nota
  if not CkBx_Nota_Manual.Checked and ChBx_AutorizacaoNFE.Checked then
    It_Nr_Nota  := Fc_GeraNumeroNota;

  //Grava o retorno inicial desta nota para garantir sequencia da proxima nota gerada
  if ChBx_AutorizacaoNFE.Checked then
    Begin
    Pc_SalvaRetorno(DM.IBT_Generator,
                    0,
                    '',
                    StrZero(It_Nr_Nota,6,0),
                    StrZero(It_Nr_Nota,6,0),
                    '',
                    It_Cd_Nota);
    end;

 //Define Numero da Nota
  if not CkBx_Nota_Manual.Checked and ChBx_NF_Informatizada.Checked then
    It_Nr_Nota  := Fc_GeraNumeroNota;

  if chbx_data_saida.Checked then
    Lc_Data := DatetoStr(E_Dt_Saida.Date)
  else
    Lc_Data := '';
        
  //Gerar Nota Fiscal
  Pc_NotaFiscal(IBT_Faturamento,
                It_Cd_Nota,
                'SI',
                StrZero(It_Nr_Nota, 6,0),
                Lc_SerieNF,
                It_Cd_Natureza,
                IT_CD_Pedido,
                It_cd_Empresa,
                E_Dt_Emissao.Date,
                Lc_Data,
                time,
                StrToFloatDef(E_VL_Bs_ICMS.Text,0),
                StrToFloatDef(E_VL_ICMS.Text,0),
                StrToFloatDef(E_Vl_Bs_Icms_St.Text,0),
                StrToFloatDef(E_Vl_Icms_St.Text,0),
                StrToFloatDef(E_VL_Produto.Caption,0),
                StrToFloatDef(E_VL_Frete.Text,0),
                StrToFloatDef(E_Vl_Seguro.Text,0),
                StrToFloatDef(E_Vl_Outras.Text,0),
                StrToFloatDef(E_VL_IPI.Text,0),
                StrToFloatDef(E_VL_Nota.Caption,0),
                Lc_Transportadora,
                Dblcb_Modal_Frete.KeyValue,
                StrToFloatDef(E_Qt_Produto.Text,0),
                E_Especie.Text,
                E_Marca.Text,
                E_PesoBruto.Text,
                E_PesoLiq.Text,
                'N',
                '',
                'F',
                0,
                0,
                E_vol_Numero.Text,
                E_PlacaVeiculo.Text,
                E_Uf_Veiculo.Text,
                E_RNTC.Text,
                Gb_CodMha);
  if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
end;


function TFr_Fatura_Dsp.Fc_SomaCreditoICMS(): Real;
var
   Lc_Vl_Credito: Real;
   Lc_Aq_ICMS: Real;
begin
   Lc_Aq_ICMS := StrToFloatDef(Fc_Tb_Geral('L', 'GRL_G_AQ_CRED_ICMS', ''), 0);
   Lc_Vl_Credito := (It_Vl_TL_Pedido - It_VL_TL_Desconto) * (Lc_Aq_ICMS / 100);
   Result := Lc_Vl_Credito;
end;


procedure TFr_Fatura_Dsp.Pc_Condicao_STDPRREV;
begin
  if It_Subst_Tributario then
    begin
    //Calculo do icms da opereação propria
    It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
    if Chbx_SomaIPI_Bs_ICMS.Checked then
      begin
      It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
      It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
      It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
      end;

    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
    It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
    It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

    //calculo de icms de Substituição tributaria
    It_VL_Bc_St_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto ;
    if Chbx_SomaIPI_Bs_ICMS_St.Checked then
      begin
      It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
      It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
      It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_UNID_IPI;
      end;
    It_VL_Bc_St_ICMS := (It_VL_Bc_St_ICMS * (Gb_Mg_VA_St_Icms));
    It_Vl_St_ICMS    := It_VL_Bc_St_ICMS * (Gb_Aq_St_ICMS / 100);
    //Valor do Icms por substituição tributaria
    It_Vl_St_ICMS := It_Vl_St_ICMS - It_VL_Nr_ICMS;
    if It_Vl_St_ICMS <= 0 then
      Begin
      It_VL_Bc_St_ICMS := 0;
      It_Vl_St_ICMS    := 0;
      end;    
    end
  else
    begin
    It_Vl_Bc_ICMS := 0;
    It_VL_Nr_ICMS := 0;
    It_VL_Bc_St_ICMS := 0;
    It_VL_St_ICMS := 0;
    Gb_Mg_VA_St_Icms := 0;
    end;
end;

procedure TFr_Fatura_Dsp.Pc_Condicao_STDPRCSD;
begin
  {Não se Aplica
  c) Na saída para consumidor final, salvo se a operação for interestadual e o
  destinatário contribuinte do ICMS, uma vez que, como me referi no subitem acima,
  alguns Protocolos/Convênios que dispõe sobre o regime da Substituição Tributária
  atribuem a responsabilidade ao remetente em relação entrada para uso e consumo
  ou ativo imobilizado, ou seja, em relação ao diferencial de alíquotas.
  (No caso específico de lâmpadas os Estados de BA e PR não exigem a Substituição
  Tributária mesmo se o destinatário for contribuinte do ICMS);}
  It_Vl_Bc_ICMS := 0;
  It_VL_Nr_ICMS := 0;
  It_VL_Bc_St_ICMS := 0;
  It_VL_St_ICMS := 0;
  Gb_Mg_VA_St_Icms := 0;
end;

procedure TFr_Fatura_Dsp.Pc_Condicao_STDPRREVREQ;
begin
  //Calculo do icms da opereação propria
  It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
  if Chbx_SomaIPI_Bs_ICMS.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
    end;

  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
  It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
  It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

  //calculo de icms de Substituição tributaria
  It_VL_Bc_St_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
  It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto ;
  if Chbx_SomaIPI_Bs_ICMS_St.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_UNID_IPI;
    end;
  It_VL_Bc_St_ICMS := (It_VL_Bc_St_ICMS * (Gb_Mg_VA_St_Icms));
  It_Vl_St_ICMS    := It_VL_Bc_St_ICMS * (Gb_Aq_St_ICMS / 100);
  //Valor do Icms por substituição tributaria
  It_Vl_St_ICMS := It_Vl_St_ICMS - It_VL_Nr_ICMS;
  if It_Vl_St_ICMS <= 0 then
    Begin
    It_VL_Bc_St_ICMS := 0;
    It_Vl_St_ICMS    := 0;
    Gb_Mg_VA_St_Icms := 0;
    end;
end;

procedure TFr_Fatura_Dsp.Pc_Condicao_NRDPRREV;
begin
  //Calculo do icms da opereação propria
  It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
  if Chbx_SomaIPI_Bs_ICMS.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
    end;

  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
  It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
  It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

  //calculo de icms de Substituição tributaria
  It_VL_Bc_St_ICMS := 0;
  It_Vl_St_ICMS    := 0;
  Gb_Mg_VA_St_Icms :=0;
end;

procedure TFr_Fatura_Dsp.Pc_Condicao_NRDPRCSD;
begin
  //Calculo do icms da opereação propria
  It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
  if Chbx_SomaIPI_Bs_ICMS.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
    end;

  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
  It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
  It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

  //calculo de icms de Substituição tributaria
  It_VL_Bc_St_ICMS := 0;
  It_Vl_St_ICMS    := 0;
  Gb_Mg_VA_St_Icms := 0;
end;

procedure TFr_Fatura_Dsp.Pc_Condicao_STFPRREV;
begin
  //Calculo do icms da opereação propria
  It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
  if Chbx_SomaIPI_Bs_ICMS.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
    end;

  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
  It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
  It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

  //calculo de icms de Substituição tributaria
  It_VL_Bc_St_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat);
  It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto ;
  if Chbx_SomaIPI_Bs_ICMS_St.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_UNID_IPI;
    end;
  It_VL_Bc_St_ICMS := (It_VL_Bc_St_ICMS * (Gb_Mg_VA_St_Icms));
  It_Vl_St_ICMS    := It_VL_Bc_St_ICMS * (Gb_Aq_St_ICMS / 100);
  //Valor do Icms por substituição tributaria
  It_Vl_St_ICMS := It_Vl_St_ICMS - It_VL_Nr_ICMS;
  if It_Vl_St_ICMS <= 0 then
    Begin
    It_VL_Bc_St_ICMS := 0;
    It_Vl_St_ICMS    := 0;
    end;

end;

procedure TFr_Fatura_Dsp.Pc_Condicao_STFPRCSD;
begin
  {Ressalte-se que, nas operações interestaduais, em relação a algumas mercadorias,
  a sujeição ocorre, também, quanto àsentradas para uso e consumo ou ativo imobilizado
  desde que o destinatário das mercadorias seja contribuinte do ICMS e nestes casos não
  incidiré na operação a margem presumida, pré-definida pelo Governo, na base de cálculo
  do regime da ST. (Arts. 6º e 9º, parágrafo º, da Lei Complementar nº87/96)}

  //Verifica se o Consumidor é contribuinte do ICMS
  if It_Contribuinte_ICMS then exit;

  //Calculo do icms da opereação propria
  It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
  if Chbx_SomaIPI_Bs_ICMS.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
    end;

  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
  It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
  It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

  if (Qr_PedidoEMP_CONSUMIDOR.AsString) = 'N' then
    Begin
    //calculo de icms de Substituição tributaria
    It_VL_Bc_St_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto ;
    if Chbx_SomaIPI_Bs_ICMS_St.Checked then
      begin
      It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
      It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
      It_VL_Bc_St_ICMS := It_VL_Bc_St_ICMS + It_VL_UNID_IPI;
      end;
    It_VL_Bc_St_ICMS := (It_VL_Bc_St_ICMS * (Gb_Mg_VA_St_Icms));
    It_Vl_St_ICMS    := It_VL_Bc_St_ICMS * (Gb_Aq_St_ICMS / 100);
    //Valor do Icms por substituição tributaria
    It_Vl_St_ICMS := It_Vl_St_ICMS - It_VL_Nr_ICMS;

    if It_Vl_St_ICMS <= 0 then
      Begin
      It_VL_Bc_St_ICMS := 0;
      It_Vl_St_ICMS    := 0;
      Gb_Mg_VA_St_Icms := 0;
      end;
    end
  else
    Begin
    It_VL_Bc_St_ICMS := 0;
    It_Vl_St_ICMS    := 0;
    Gb_Mg_VA_St_Icms := 0;
    end;
end;

procedure TFr_Fatura_Dsp.Pc_Condicao_NRFPRREV;
begin
  //Calculo do icms da opereação propria
  It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
  if Chbx_SomaIPI_Bs_ICMS.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
    end;

  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
  It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
  It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

  //calculo de icms de Substituição tributaria
  It_VL_Bc_St_ICMS := 0;
  It_Vl_St_ICMS    := 0;
  Gb_Mg_VA_St_Icms := 0;
end;

procedure TFr_Fatura_Dsp.Pc_Condicao_NRFPRCSD;
begin
  //Calculo do icms da opereação propria
  It_Vl_Bc_ICMS := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.fieldByname('ITF_VL_DESC').AsCurrency;
  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_frete_Produto + It_Vl_Seguro_Produto + It_Vl_Outras_Produto;
  if Chbx_SomaIPI_Bs_ICMS.Checked then
    begin
    It_VL_UNID_IPI := (Qr_Itens.fieldByname('ITF_VL_UNIT').AsCurrency * Qr_Itens.fieldByname('ITF_QTDE').AsFloat) - Qr_Itens.FieldByName('ITF_VL_DESC').AsCurrency;
    It_VL_UNID_IPI := It_VL_UNID_IPI * (It_AQ_NR_IPI/100);
    It_Vl_Bc_ICMS := It_Vl_Bc_ICMS + It_VL_UNID_IPI;
    end;

  It_Vl_Bc_ICMS := It_Vl_Bc_ICMS  - (It_Vl_Bc_ICMS * (It_Aq_Rd_BC_ICMS / 100));
  It_VL_Nr_ICMS := It_Vl_Bc_ICMS * ((It_Aq_Nr_ICMS - It_Aq_Rd_Nr_ICMS) / 100);
  It_Vl_Diferido := It_Vl_Bc_ICMS * (It_Aq_Rd_Nr_ICMS / 100);

  //calculo de icms de Substituição tributaria
  It_VL_Bc_St_ICMS := 0;
  It_Vl_St_ICMS    := 0;
  Gb_Mg_VA_St_Icms := 0;
end;

function TFr_Fatura_Dsp.Fc_Faturar_Normal():Boolean;
Var
  Lc_Form : TFr_GeraNfe_vda;
begin
  Result := True;
  It_Etapa_Faturamento := 0;
  //Inicia o Faturamento
  try
    //Inicia a Transação
    IBT_Faturamento.Active := True;
    if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;
    if not IBT_Faturamento.InTransaction then IBT_Faturamento.StartTransaction;
    //Seleciona o Pedido
    Qr_Pedido.Active := False;
    Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
    Qr_Pedido.Active := True;
    Qr_Pedido.FetchAll;
    Qr_Pedido.First;

    //Valor do Frete
    It_Vl_TL_Frete := StrToFloatDef(E_VL_Frete.Text, 0);

    //Valor do Seguro
    It_Vl_TL_Seguro := StrToFloatDef(E_Vl_Seguro.Text, 0);

    //Valor das outras despesas
    It_Vl_TL_Outras := StrToFloatDef(E_Vl_Outras.Text, 0);

    Pc_SelecionaItensNota(0, 0, '');

    Pc_CalculaTotalPedido;

    It_Cd_Nota:= Fc_Generator('GN_NOTA_FISCAL','','NFL_CODIGO');

    if ChBx_AutorizacaoNFE.Checked OR ChBx_NF_Informatizada.Checked then
      begin
      It_Etapa_Faturamento := 1;
      Pc_Calcula_Impostos;
      end;
      
    Pc_Totalizador;
    if not Fc_ConfirmaValores then
      begin
      if IBT_Faturamento.InTransaction then IBT_Faturamento.Rollback;
      Pc_RollBack_Faturamento;
      Result := False;
      exit;
      end;
    It_Etapa_Faturamento := 2;
    Pc_Gera_NotaFiscal;
    It_Etapa_Faturamento := 3;
    Pc_Obs_NotaFiscal;

    //Atualização dos itens na nota
    It_Etapa_Faturamento := 5;
    Pc_SelecionaItensNota(0, 0, '');
    Pc_AtualizarItensNota;

    if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;

    Pedido.Registro.Codigo := It_Cd_Pedido;
    Pedido.Registro.Faturado := 'S';
    Pedido.alteraStatus;


    MensagemPadrao(MENSAGEM, TITULO_CONFIRMACAO + EOLN + EOLN +
                   'Faturamento realizado com Sucesso.' + EOLN+
                   'Número do Pedido : ' + InttoStr(It_Nr_Pedido) + EOLN+
                   'Número do Nota : ' + InttoStr(It_Nr_Nota) + EOLN,
                   ['OK'], [bEscape], mpConfirmacao);

    if ChBx_AutorizacaoNFE.Checked then
    begin
      try
        Lc_Form := TFr_GeraNfe_vda.Create(Self);
        TRy
          Lc_Form.It_Cd_Pedido      := It_Cd_Pedido;
          Lc_Form.It_cd_Cliente     := Pedido.Registro.Empresa;
          Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
          Lc_Form.It_Cd_Nota        := It_cd_Nota;
          Lc_Form.It_Nr_Nota        := It_Nr_nota;
          Lc_Form.It_Nf_Terceiro    := FAlse;
          Lc_Form.ValorRecebido     := 0;
          Lc_Form.ValorTroco        := 0;

          //Operação Normal
          Pc_CarregaDadosEmitente(true);
          Lc_Form.TipoOperacao := 'NF-e';
          Lc_Form.ShowModal;
        except
          on e:Exception do
            MensagemPadrao('NMensagem de erro', ATENCAO + EOLN + EOLN +
                           e.Message + EOLN +
                           'Informe ao Desenvolvedor do Sistema.' + EOLN,
                           ['OK'], [bEscape], mpErro);
        End;
      finally
        FreeAndNil(Lc_Form);
        SetWindowPos(Gb_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);
      end;
    end;

    if ChBx_NF_Informatizada.Checked then
    begin
      Pc_SalvaRetorno(IBT_Faturamento,
                      0,
                      '',
                      StrZero(It_Nr_Nota,6,0),
                      StrZero(It_Nr_Nota,6,0),
                      '',
                      It_Cd_Nota);
      if not Assigned(Fr_Imprime_Nota) then Application.CreateForm(TFr_Imprime_Nota, Fr_Imprime_Nota);
      Fr_Imprime_Nota.It_Cd_Nota := It_Cd_Nota;
      if Fr_Imprime_Nota.Fc_CarregaDadosDaNota('C',It_Cd_Nota) then
      if Fr_Imprime_Nota.Fc_ChamaImpressora then
        Fr_Imprime_Nota.PC_NotaImpressa;
      Fr_Imprime_Nota.Close;
    end;



  except
    if IBT_Faturamento.InTransaction then IBT_Faturamento.Rollback;
    Pc_RollBack_Faturamento;
    Result := False;
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Erro ao gerar Faturamento.' + EOLN +
                   'Verifique os dados do pedido.' + EOLN,
                   ['OK'], [bEscape], mpErro);

  end;
end;


procedure TFr_Fatura_Dsp.Pc_Atualiza_Itens_Devolucao;
Var
  Lc_Cd_Produto : Integer;
  lc_Qtde : Real;
  Lc_Qry : TSTQuery;
  Lc_Data : TDate;
  Lc_Qt_Rec : Integer;
  Lc_Vl_Dinheiro, Lc_Vl_Cheque, Lc_Vl_cartao, Lc_Vl_Credito, Lc_Vl_Devolucao : Real;
BEgin
  try
    Lc_Cd_Produto := StrToIntDef(Fc_Tb_Geral('L','GRL_G_PRO_CD_DEVOLUCAO',''),0);
    Lc_Qry := TSTQuery.Create(Application);
    with Lc_Qry do
      Begin
      Database := DM.IBD_Gestao;
      Transaction := IBT_Faturamento;
      ForcedRefresh := True;
      Close;
      SQL.Clear;
      SQL.Add('SELECT ITF_CODIGO, ITF_CODPRO, ITF_QTDE, ITF_VL_CUSTO, ITF_VL_UNIT, '+
                   'ITF_CODEST, ITF_CODTPR                                              '+
                   'FROM TB_ITENS_NFL '+
                   'WHERE (ITF_CODPED=:ITF_CODPED) AND (ITF_OPER=''D'') ') ;
      ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
      Active := True;
      FetchAll;
      First;
      Lc_Vl_Devolucao := 0;
      while  not Eof do
        begin
        Lc_Vl_Devolucao := Lc_Vl_Devolucao + (FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').AsFloat);
        Fc_AtualizaItensNfl(IBT_Faturamento,
                            'E',
                            FieldByName('ITF_CODIGO').AsInteger,
                            It_Cd_Pedido,
                            It_Cd_Nota,
                            FieldByName('ITF_CODPRO').AsInteger,
                            FieldByName('ITF_QTDE').AsFloat,
                            FieldByName('ITF_VL_CUSTO').AsCurrency,
                            FieldByName('ITF_VL_UNIT').AsCurrency,
                            0,
                            0,
                            0,
                            'D',
                            'S',
                            'S',
                            0,
                            0,
                            FieldByName('ITF_CODEST').AsInteger,
                            FieldByName('ITF_CODTPR').AsInteger,
                            'E',
                            0);
        Next;
        end;
      end;
  finally
    if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  end;
end;



Procedure TFr_Fatura_Dsp.chbx_data_saidaClick(Sender: TObject);
begin
  E_Dt_Saida.Enabled := chbx_data_saida.Checked;
end;

procedure TFr_Fatura_Dsp.E_Qt_ProdutoChange(Sender: TObject);
Var
  Lc_Ativa : boolean;
begin
  Lc_Ativa := (StrToFloatDef(E_Qt_Produto.Text,0) > 0);
  if Lc_Ativa then
    Begin
    E_Especie.Enabled := True;
    E_PesoBruto.Enabled := True;
    E_PesoLiq.Enabled := True;
    E_Marca.Enabled := True;
    E_Vol_Numero.Enabled := True;
    E_PesoLiq.Text := FloatToStrF(Fc_MostraPesoPedido(It_Cd_Pedido),ffFixed,10,2);
    E_PesoBruto.Text := E_PesoLiq.Text;
    end
  else
    Begin
    E_Especie.Enabled := False;
    E_PesoBruto.Enabled := False;
    E_PesoLiq.Enabled := False;
    E_Marca.Enabled := False;
    E_Vol_Numero.Enabled := False;
    // Zera os Campos
    E_PesoBruto.Clear;
    E_PesoLiq.Clear;
    E_Marca.Clear;
    E_Vol_Numero.Clear;    
    end;   


end;

end.


