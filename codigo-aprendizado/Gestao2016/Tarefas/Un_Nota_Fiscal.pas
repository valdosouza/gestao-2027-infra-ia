unit Un_Nota_Fiscal;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ControllerCtrlLote, System.Math, ControllerRetornoNFe, Vcl.Menus, Vcl.DBCtrls, Vcl.ComCtrls, ControllerBase, ControllerPedido, System.AnsiStrings, STDatabase, STTransaction, Un_Pagar_Multipla;

type
  TFr_Nota_Fiscal = class(TForm)
    Qr_ItensNota: TSTQuery;
    Ds_ItensNota: TDataSource;
    Qr_Nota: TSTQuery;
    DS_Nota: TDataSource;
    Qr_Conserto: TSTQuery;
    Qr_ItensSrv: TSTQuery;
    Ds_FormaPgto: TDataSource;
    Qr_FPgto: TSTQuery;
    dst_ItensSrv: TDataSource;
    ds_conserto: TDataSource;
    Mnu_Operacao: TMainMenu;
    Mnu_Operacao_Tarefas: TMenuItem;
    Itm_Nfe_Operacao: TMenuItem;
    Itm_Nfe_Compl: TMenuItem;
    Itm_Carta_Correcao: TMenuItem;
    Itm_ImprimirPedido: TMenuItem;
    Itm_CadastroDestinatrio: TMenuItem;
    Qr_ItensDev: TSTQuery;
    Ds_ItensDev: TDataSource;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    AtualizarosCustos1: TMenuItem;
    CalcularaComisso1: TMenuItem;
    Pop_Produto: TPopupMenu;
    CadastrodoProduto: TMenuItem;
    AuditoriaEstoque1: TMenuItem;
    RegistraNmerodolote1: TMenuItem;
    CpiadePedidoNota1: TMenuItem;
    N5: TMenuItem;
    MnuLucratividade: TMenuItem;
    AnexarXML1: TMenuItem;
    Qr_FPgtoFIN_PRAZO: TStringField;
    Qr_FPgtoFIN_DT_VENCIMENTO: TDateField;
    Qr_FPgtoFIN_NUMERO: TStringField;
    Qr_FPgtoFIN_VL_PARCELA: TBCDField;
    Qr_FPgtoFIN_DT_PAGTO: TDateField;
    Qr_FPgtoFIN_VL_PAGO: TBCDField;
    Qr_FPgtoFIN_DT_BAIXA: TDateField;
    Qr_FPgtoFIN_TIPO: TStringField;
    Qr_FPgtoFIN_OPERACAO: TStringField;
    EnviaPedido1: TMenuItem;
    Qr_ItensNotaITF_CODIGO: TIntegerField;
    Qr_ItensNotaITF_CODPRO: TIntegerField;
    Qr_ItensNotaMED_ABREVIATURA: TStringField;
    Qr_ItensNotaPRO_CODIGOFAB: TStringField;
    Qr_ItensNotaPRO_CODIGONCM: TStringField;
    Qr_ItensNotaPRO_ORIGEM: TStringField;
    Qr_ItensNotaPRO_TIPO: TStringField;
    Qr_ItensNotaPRO_DESCRICAO: TStringField;
    Qr_ItensNotaPRO_SERIE: TStringField;
    Qr_ItensNotaEMB_ABREVIATURA: TStringField;
    Qr_ItensNotaITF_QTDE: TBCDField;
    Qr_ItensNotaITF_VL_UNIT: TFMTBCDField;
    Qr_ItensNotaITF_ESTOQUE: TStringField;
    Qr_ItensNotaITF_OPER: TStringField;
    Qr_ItensNotaITF_CODEST: TIntegerField;
    Qr_ItensNotaITF_AQ_COM: TBCDField;
    Qr_ItensNotaITF_VL_COM: TFloatField;
    Qr_ItensNotaITF_VL_DESC: TBCDField;
    Qr_ItensNotaPRO_VL_CUSTOMED: TFMTBCDField;
    Qr_ItensNotaITF_AQ_DESC: TBCDField;
    Qr_ItensNotaITF_AQ_IPI: TBCDField;
    Qr_ItensNotaITF_AQ_ICMS: TBCDField;
    Qr_ItensNotaITF_CODTPR: TIntegerField;
    Qr_ItensNotaITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensNotaITF_IMP_APROX: TBCDField;
    Qr_ItensSrvITF_CODIGO: TIntegerField;
    Qr_ItensSrvITF_CODPED: TIntegerField;
    Qr_ItensSrvITF_CODNFL: TIntegerField;
    Qr_ItensSrvITF_CODPRO: TIntegerField;
    Qr_ItensSrvPRO_DESCRICAO: TStringField;
    Qr_ItensSrvEMB_ABREVIATURA: TStringField;
    Qr_ItensSrvITF_QTDE: TBCDField;
    Qr_ItensSrvITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensSrvITF_VL_DESC: TBCDField;
    Qr_ItensSrvITF_VL_UNIT: TFMTBCDField;
    Qr_ItensSrvITF_AQ_COM: TBCDField;
    Qr_ItensSrvMED_ABREVIATURA: TStringField;
    Qr_ItensSrvITF_VL_SUBTOTAL: TFMTBCDField;
    Qr_ItensSrvITF_VL_TOTAL: TFMTBCDField;
    Qr_ItensDevITF_CODIGO: TIntegerField;
    Qr_ItensDevITF_CODPRO: TIntegerField;
    Qr_ItensDevITF_CODPED: TIntegerField;
    Qr_ItensDevMED_ABREVIATURA: TStringField;
    Qr_ItensDevPRO_CODIGOFAB: TStringField;
    Qr_ItensDevPRO_TIPO: TStringField;
    Qr_ItensDevPRO_DESCRICAO: TStringField;
    Qr_ItensDevEMB_ABREVIATURA: TStringField;
    Qr_ItensDevITF_QTDE: TBCDField;
    Qr_ItensDevITF_VL_UNIT: TFMTBCDField;
    Qr_ItensDevITF_ESTOQUE: TStringField;
    Qr_ItensDevITF_CODEST: TIntegerField;
    Qr_ItensDevITF_SUBTOTAL: TFMTBCDField;
    Qr_ItensDevITF_VL_TOTAL: TFMTBCDField;
    Qr_ItensDevITF_AQ_COM: TBCDField;
    Qr_ItensDevITF_VL_COM: TFloatField;
    Qr_ItensDevITF_VL_DESC: TBCDField;
    Qr_ItensDevPRO_VL_CUSTOMED: TFMTBCDField;
    Qr_ItensDevITF_AQ_DESC: TBCDField;
    Qr_ItensDevITF_AQ_IPI: TBCDField;
    Qr_ItensDevITF_AQ_ICMS: TBCDField;
    Qr_ItensDevITF_CODTPR: TIntegerField;
    Qr_ItensDevITF_VL_CUSTO: TFMTBCDField;
    Qr_NotaEMP_TIPO: TIntegerField;
    Qr_NotaNFL_CODMHA: TIntegerField;
    Qr_NotaPED_CODIGO: TIntegerField;
    Qr_NotaNFL_CODIGO: TIntegerField;
    Qr_NotaNFL_CODPED: TIntegerField;
    Qr_NotaPED_CODFPG: TIntegerField;
    Qr_NotaNAT_CODIGO: TIntegerField;
    Qr_NotaNAT_DESCRICAO: TStringField;
    Qr_NotaNAT_CFOP: TStringField;
    Qr_NotaPED_NUMERO: TIntegerField;
    Qr_NotaNFL_NUMERO: TStringField;
    Qr_NotaNFL_VL_TL_NOTA: TBCDField;
    Qr_NotaEMP_CODIGO: TIntegerField;
    Qr_NotaEMP_NOME: TStringField;
    Qr_NotaEMP_CNPJ: TStringField;
    Qr_NotaEND_ENDER: TStringField;
    Qr_NotaEND_BAIRRO: TStringField;
    Qr_NotaEND_CEP: TStringField;
    Qr_NotaEND_FONE: TStringField;
    Qr_NotaEMP_INSC_EST: TStringField;
    Qr_NotaEMP_EMAIL: TStringField;
    Qr_NotaNFL_DT_EMISSAO: TDateField;
    Qr_NotaNFL_DT_SAIDA: TDateField;
    Qr_NotaNFL_BS_ICMS: TBCDField;
    Qr_NotaNFL_VL_ICMS: TBCDField;
    Qr_NotaNFL_BS_ICMS_SUBST: TBCDField;
    Qr_NotaNFL_VL_ICMS_SUBST: TBCDField;
    Qr_NotaNFL_VL_TL_PROD: TBCDField;
    Qr_NotaNFL_VL_FRETE: TBCDField;
    Qr_NotaNFL_VL_SEGURO: TBCDField;
    Qr_NotaNFL_VL_DESP_ACESS: TBCDField;
    Qr_NotaNFL_VL_IPI: TBCDField;
    Qr_NotaNFL_QT_PRODUTO: TBCDField;
    Qr_NotaNFL_CODTRP: TIntegerField;
    Qr_NotaNFL_ESPECIE: TStringField;
    Qr_NotaNFL_MARCA: TStringField;
    Qr_NotaNFL_PESO_BRUTO: TStringField;
    Qr_NotaNFL_PESO_LIQ: TStringField;
    Qr_NotaNFL_VOL_NUMERO: TStringField;
    Qr_NotaCLB_NOME: TStringField;
    Qr_NotaNFL_STATUS: TStringField;
    Qr_NotaNFL_TIPO: TStringField;
    Qr_NotaPED_OBS: TBlobField;
    Qr_NotaNFL_VL_TL_SRV: TBCDField;
    Qr_NotaPED_VL_DESCONTO: TBCDField;
    Qr_NotaPED_DT_ALTERA: TSQLTimeStampField;
    Qr_NotaPED_CODTRP: TIntegerField;
    Qr_NotaNFE_CODSIT: TIntegerField;
    Qr_NotaPED_PRAZO: TStringField;
    Qr_NotaCDD_DESCRICAO: TStringField;
    Qr_NotaUFE_SIGLA: TStringField;
    Qr_NotaPED_TIPO: TIntegerField;
    pnl_corpo: TPanel;
    PG_Principal: TPageControl;
    Tbs_Produto: TTabSheet;
    Pnl_Produto: TPanel;
    Sb_Vend_Comissao: TSpeedButton;
    DBG_Produtos: TDBGrid;
    Tbs_Servico: TTabSheet;
    Pnl_Servico: TPanel;
    Sb_Servico: TSpeedButton;
    Sb_Tecnico: TSpeedButton;
    DBG_Servicos: TDBGrid;
    Tbs_Devolucao: TTabSheet;
    DBG_Devolucao: TDBGrid;
    Tbs_Conserto: TTabSheet;
    Panel2: TPanel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Lb_VL_Total: TLabel;
    Label24: TLabel;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    E_NumSerie: TDBEdit;
    db_aparelho: TDBEdit;
    db_marca: TDBEdit;
    db_modelo_conset: TDBEdit;
    MM_Acessorios: TDBMemo;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit1: TDBEdit;
    Pg_Totalizador: TPageControl;
    TabSheet2: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    E_Bs_Icms: TDBEdit;
    E_Vl_Icms: TDBEdit;
    E_Bs_Icms_St: TDBEdit;
    E_Vl_Icms_St: TDBEdit;
    E_Vl_frete: TDBEdit;
    E_Vl_Seguro: TDBEdit;
    E_Vl_Outras: TDBEdit;
    E_Vl_IPI: TDBEdit;
    E_VL_Produto: TDBEdit;
    E_VL_Nota: TDBEdit;
    E_Qtde: TDBEdit;
    E_Especie: TDBEdit;
    E_MArca: TDBEdit;
    E_Numero: TDBEdit;
    E_PesoBruto: TDBEdit;
    E_PesoLiquido: TDBEdit;
    Label40: TLabel;
    Label2: TLabel;
    Label43: TLabel;
    sb_obs_nfe: TSpeedButton;
    E_Ped_Obs: TDBMemo;
    E_Vendedor: TDBEdit;
    E_Prazo: TDBEdit;
    TabSheet1: TTabSheet;
    Dbg_Financeiro: TDBGrid;
    pnl_rodape: TPanel;
    Sb_Sair_0: TSpeedButton;
    Qr_NotaNFL_MODELO: TStringField;
    MnuCustoPedido: TMenuItem;
    AplicarLote1: TMenuItem;
    Qr_ItensNotaITF_VL_TOTAL: TFloatField;
    Qr_ItensNotaITF_VL_SUBTOTAL: TFloatField;
    Qr_ItensNotaITF_SEQUENCIA: TIntegerField;
    N2: TMenuItem;
    Acompanhamento1: TMenuItem;
    tbs_nota: TTabSheet;
    Panel4: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label38: TLabel;
    Label1: TLabel;
    Label39: TLabel;
    GroupBox2: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label5: TLabel;
    E_RazaoSocial: TDBEdit;
    E_Cnpj_CPf: TDBEdit;
    E_Endereco: TDBEdit;
    E_Bairro: TDBEdit;
    E_Cep: TDBEdit;
    E_Cidade: TDBEdit;
    E_Fone: TDBEdit;
    E_Estado: TDBEdit;
    E_Insc_Est: TDBEdit;
    E_CodCli: TDBEdit;
    E_Natureza: TDBEdit;
    E_Cfop: TDBEdit;
    E_Pedido: TDBEdit;
    E_Nota: TDBEdit;
    E_Vl_Total: TDBEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    E_Dt_Emissao: TDBEdit;
    E_Dt_Saida: TDBEdit;
    Pnl_Servico_Rodape: TPanel;
    Pnl_Produto_rodape: TPanel;
    Pg_Imposto: TPageControl;
    tbs_icms: TTabSheet;
    tbs_ipi: TTabSheet;
    tbs_pis: TTabSheet;
    tbs_cofins: TTabSheet;
    tbs_II: TTabSheet;
    DBGrid1: TDBGrid;
    Qr_Icms: TSTQuery;
    Ds_Icms: TDataSource;
    pnl_observacao: TPanel;
    tbs_dev_ajustes: TTabSheet;
    DBGrid2: TDBGrid;
    Qr_ItensDevAjuste: TSTQuery;
    Ds_ItensDevAjuste: TDataSource;
    Qr_ItensDevAjusteITF_CODIGO: TIntegerField;
    Qr_ItensDevAjusteITF_CODPRO: TIntegerField;
    Qr_ItensDevAjusteMED_ABREVIATURA: TStringField;
    Qr_ItensDevAjustePRO_CODIGOFAB: TStringField;
    Qr_ItensDevAjustePRO_DESCRICAO: TStringField;
    Qr_ItensDevAjusteITF_QTDE: TBCDField;
    Qr_ItensDevAjusteITF_SEQUENCIA: TIntegerField;
    Qr_ItensDevAjustePED_NUMERO: TIntegerField;
    RegistraNmerodeSrie1: TMenuItem;
    InformaoCombustivel1: TMenuItem;
    MnuAlterarVendedor: TMenuItem;
    Qr_NotaPED_CODVDO: TIntegerField;
    Qr_IcmsNAT_CFOP: TStringField;
    Qr_IcmsNAT_DESCRICAO: TStringField;
    Qr_IcmsICM_VL_BC_NR: TFMTBCDField;
    Qr_IcmsICM_AQ_NR: TBCDField;
    Qr_IcmsICM_VL_NR: TFMTBCDField;
    Qr_IcmsSET_FINANCIAL: TStringField;
    Qr_IcmsTEMFINANCEIRO: TStringField;
    IBT_Interface: TSTTransaction;
    Sb_Financeiro: TSpeedButton;
    procedure B_SFecharClick(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_ServicoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_TecnicoClick(Sender: TObject);
    procedure Itm_ImprimirPedidoClick(Sender: TObject);
    procedure Itm_Nfe_OperacaoClick(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure Tbs_ConsertoShow(Sender: TObject);
    procedure Itm_CadastroDestinatrioClick(Sender: TObject);
    procedure sb_obs_nfeClick(Sender: TObject);
    procedure Itm_Nfe_ComplClick(Sender: TObject);
    procedure AtualizarosCustos1Click(Sender: TObject);
    procedure CalcularaComisso1Click(Sender: TObject);
    procedure Dbg_FinanceiroDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Itm_Carta_CorrecaoClick(Sender: TObject);
    procedure Qr_ItensSrvAfterOpen(DataSet: TDataSet);
    procedure CadastrodoProdutoClick(Sender: TObject);
    procedure AuditoriaEstoque1Click(Sender: TObject);
    procedure RegistraNmerodolote1Click(Sender: TObject);
    procedure Tbs_ServicoShow(Sender: TObject);
    procedure Tbs_DevolucaoShow(Sender: TObject);
    procedure CpiadePedidoNota1Click(Sender: TObject);
    procedure MnuLucratividadeClick(Sender: TObject);
    procedure AnexarXML1Click(Sender: TObject);
    procedure EnviaPedido1Click(Sender: TObject);
    procedure MnuCustoPedidoClick(Sender: TObject);
    procedure AplicarLote1Click(Sender: TObject);
    procedure Qr_ItensNotaCalcFields(DataSet: TDataSet);
    procedure DBG_ProdutosTitleClick(Column: TColumn);
    procedure Acompanhamento1Click(Sender: TObject);
    procedure Qr_ItensNotaAfterScroll(DataSet: TDataSet);
    procedure tbs_dev_ajustesShow(Sender: TObject);
    procedure Qr_ItensDevAjusteAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure RegistraNmerodeSrie1Click(Sender: TObject);
    procedure InformaoCombustivel1Click(Sender: TObject);
    procedure MnuAlterarVendedorClick(Sender: TObject);
    procedure Qr_IcmsCalcFields(DataSet: TDataSet);
    procedure Sb_FinanceiroClick(Sender: TObject);
  private
    { Private declarations }
    function ValidaAlteraVendedor:Boolean;
    procedure AlterarVendedor;
    function Fc_ValidaAberturaCartaCorrecao: boolean;

    procedure Pc_AbrirConserto;
    procedure Pc_AbrirItensDevolucao;
    procedure Pc_AbrirItensDevolvidoAjuste;
    procedure Pc_AbrirItensICMS;
    procedure Pc_AbrirItensServico;
    procedure Pc_AbrirItensVenda;
    procedure Pc_AbrirNota;
    procedure AbrirContasReceber;
    procedure AbrirContasPagar;

    procedure AbrirOrdemServico;
    procedure AbrirOrdemServicoAutoCenter;
    procedure AbrirOrdemServicoExtintores;
    procedure AbrirOrdemServicoEletronicos;
    procedure AbrirOrdemServicoPetShop;
    procedure AbrirOrdemServicoMoveleiro;
    procedure AbrirOrdemServicoPrintShop;


    procedure ChamarGeraNFE_VDA;
    procedure ChamarGeraNFE_CPA;
    procedure ChamarGeraNFE_AJT;

    procedure LucratividadePedidoFechado;
    procedure LucratividadeNotaFiscal;
  public
    It_Cd_Nota : Integer;

    Function Fc_ValidaexistenciaNFe:Boolean;
    Procedure Pc_EstornaCustoCompra;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Nota_Fiscal: TFr_Nota_Fiscal;

implementation

uses
Un_DM, UN_MSG, UN_Sistema, UN_Receber_Multipla, Un_Clta_Csto, Un_Fich_Fin_Cli, Un_Tecnicos, Un_Fc_Sored_Procedures, un_Obs_nfe, Un_Nfe_Complementar, Un_Funcoes, Un_Imp_Mod_Impressao, Un_Fc_Comissao, Un_Regra_Negocio, reg_correction_letter, Un_Produtos, RN_Permissao, UN_Principal, env, RN_Inventario, RN_Estoque, Un_Ctrl_Lote_Entrada, Un_Ctrl_Lote_Saida, Un_CopiaPedidoNota, Un_Parcelamento, RN_NotaFiscalEletronica3X, RN_Cliente, RN_Empresa, RN_NotaFiscal, UN_TabelasEmListas, Un_EnviaPedidoNota, RN_Pedido, reg_custo_pedido, Un_Produto_Series, tas_nfe_itens_fuel, un_RL_ReportLucratividadeNotaFiscal, un_RL_ReportLucratividadePedidoFechado, prmLucratividade, RN_Compras, tas_furniture_os, tas_order_pet_shop, un_geranfe_ajt, tas_followup, tas_order_print_shop, un_geranfe_cpa, un_geranfe_vda, tas_order_elect_equip, Un_VehicleSo, sea_collaborator, ControllerFinanceiro;

{$R *.dfm}

Function TFr_Nota_Fiscal.Fc_ValidaexistenciaNFe:Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      IF Qr_Nota.FieldByName('NFL_MODELO').AsString = '55' then
      Begin
        sql.Add('select r.nfe_codigo '+
                'from tb_retorno_nfe r '+
                'where r.nfe_codnfl =:NFL_CODIGO' );
      End;
      IF Qr_Nota.FieldByName('NFL_MODELO').AsString = '65' then
      Begin
        sql.Add('select r.nfc_codigo '+
                'from tb_retorno_nfc r '+
                'where r.nfc_codnfl =:NFL_CODIGO ');
      End;
      ParamByName('NFL_CODIGO').AsInteger := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        Result := True;
      End
      else
      Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Este Registro não se refere a uma nota Fiscal Eletrônica'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
        Result := False;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
End;


procedure TFr_Nota_Fiscal.Pc_FormataTela;
Var
  Lc_X:Integer;
 Lc_Crt : Integer;
Begin
  PG_Principal.ActivePage := tbs_nota;
  Pg_Imposto.ActivePage := tbs_icms;
  Tbs_Servico.TabVisible := (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S');
  Tbs_Devolucao.TabVisible := (Fc_Tb_Geral('L','GRL_G_TAR_DEVOLUCAO','S') = 'S');
  Tbs_Conserto.TabVisible := (Fc_Tb_Geral('L','GRL_G_TAR_CONSERTO','S') = 'S');
end;

procedure TFr_Nota_Fiscal.B_SFecharClick(Sender: TObject);
begin
  Close;
end;

Procedure TFr_Nota_Fiscal.Pc_EstornaCustoCompra;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  if (Qr_Nota.FieldByName('PED_TIPO').AsInteger = 2) then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('UPDATE TB_PRODUTO SET '+
                'PRO_VL_CUSTO =PRO_VL_CUSTOANT, '+
                'PRO_VL_CUSTOMED = PRO_VL_CUSTOMEDANT '+
                'WHERE (PRO_CODIGO   =:PRO_CODIGO) ');

        Pc_AbrirItensVenda;
        Qr_ItensNota.First;
        while not Qr_ItensNota.Eof do
        Begin
          Active := False;
          ParamByName('PRO_CODIGO').AsInteger := Qr_ItensNota.FieldByName('ITF_CODPRO').AsInteger;
          ExecSQL;
          Qr_ItensNota.Next;
        end;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  end;
end;

procedure TFr_Nota_Fiscal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Nota_Fiscal.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Nota_Fiscal.FormCreate(Sender: TObject);
begin
  Pg_Imposto.ActivePage := tbs_icms;
end;

procedure TFr_Nota_Fiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    IF ( VK_Escape =  Key  ) then Sb_Sair_0Click(Sender);
end;

procedure TFr_Nota_Fiscal.Pc_AbrirNota;
Begin
  with Qr_Nota do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    ParamByName('NFL_CODIGO').AsInteger := It_cd_Nota;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Nota_Fiscal.Pc_AbrirConserto;
Begin
  with Qr_Conserto do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := It_cd_Nota;
    Active := True;
  End;
end;

procedure TFr_Nota_Fiscal.Pc_AbrirItensVenda;
Begin
  with Qr_ItensNota do
  Begin
    Active := False;
    ParamByName('NFL_CODIGO').AsInteger := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
    Active := True;
  End;
end;

procedure TFr_Nota_Fiscal.Pc_AbrirItensServico;
Begin
  with Qr_ItensSrv do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
    Active := True;
  End;
end;

procedure TFr_Nota_Fiscal.Pc_AbrirItensDevolucao;
Begin
  with Qr_ItensDev do
  Begin
    Active := False;
    ParamByName('NFL_CODIGO').AsInteger := It_cd_Nota;
    Active := True;
  End;
end;

procedure TFr_Nota_Fiscal.Pc_AbrirItensDevolvidoAjuste;
begin
  with Qr_ItensDevAjuste do
  Begin
    Active := False;
    ParamByName('NFL_CODIGO').AsInteger := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
    Active := True;
  End;

end;

procedure TFr_Nota_Fiscal.Pc_AbrirItensICMS;
begin
  with Qr_Icms do
  Begin
    Active := False;
    ParamByName('ITF_CODIGO').AsInteger := Qr_ItensNotaITF_CODIGO.AsInteger;
    Active := True;
  End;
end;

procedure TFr_Nota_Fiscal.Sb_ServicoClick(Sender: TObject);
begin
  AbrirOrdemServico;
end;

procedure TFr_Nota_Fiscal.Pc_IniciaVariaveis;
Begin
  Pc_AbrirNota;
  Pc_AbrirItensVenda;
end;

procedure TFr_Nota_Fiscal.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_IniciaVariaveis;
end;

procedure TFr_Nota_Fiscal.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin

    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Nota_Fiscal.Sb_TecnicoClick(Sender: TObject);
begin
  if not Assigned(Fr_Tecnicos) then Application.CreateForm(TFr_Tecnicos, Fr_Tecnicos);
  with Fr_Tecnicos do
  Begin
    It_Cd_Pedido := Qr_Nota.FieldByname('PED_CODIGO').AsInteger;
    It_Cd_Item := Qr_ItensSrv.FieldByname('ITF_CODIGO').AsInteger;
    if (Gb_Nivel = 0) then
    Begin
      Fr_Tecnicos.Height := 288;
      StrGrd_Tecnico.Enabled := False;
    end;
    ShowModal;
  end
end;

procedure TFr_Nota_Fiscal.Itm_ImprimirPedidoClick(Sender: TObject);
Var
  Lc_Imp: TimpModImpressao;
begin
  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Self.Enabled := False;
    if Fc_VerificaPermissao('Fr_Nota_Fiscal','Imprimir Nora Fiscal','IMPRIMIR',GB_Cd_Usuario,'S') then
    Begin
      Lc_Imp.Pc_Imp_Tipo(Qr_Nota.FieldByName('PED_TIPO').AsInteger,Qr_Nota.FieldByName('PED_CODIGO').AsInteger,Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);
    end;
  Finally
    FreeandNil(Lc_Imp);
    Self.Enabled := True;
  end;
end;

procedure TFr_Nota_Fiscal.Itm_Nfe_OperacaoClick(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Operações NFe','OPERAÇÕES NF-E',GB_Cd_Usuario,'S') then
  Begin
    case Qr_Nota.FieldByName('PED_TIPO').AsInteger of
      1:ChamarGeraNFE_VDA;
      2:ChamarGeraNFE_CPA;
      3:ChamarGeraNFE_AJT;
      else
      Begin
        ChamarGeraNFE_VDA;
      End;
    end;
    Pc_AbrirNota;
    if Qr_Nota.RecordCount > 0 then
      Pc_AbrirItensVenda
    else
      Close;
  End;
end;

procedure TFr_Nota_Fiscal.LucratividadeNotaFiscal;
Var
  Lc_Form : TRL_ReportLucratividadeNotaFiscal;
  Lc_Param : TParamLucratividade;
begin
  Try
    Lc_Form := TRL_ReportLucratividadeNotaFiscal.create(nil);
    Lc_Param := TParamLucratividade.Create;
    Lc_Param.Periodo := False;
    Lc_Param.NumeroDocumento := Qr_NotaNFL_NUMERO.AsString;
    Lc_Form.Parametros := Lc_Param;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - NOTA FISCAL';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Nota_Fiscal.LucratividadePedidoFechado;
Var
  Lc_Form : TRL_ReportLucratividadePedidoFEchado;
  Lc_Param : TParamLucratividade;
begin
  Try
    Lc_Form := TRL_ReportLucratividadePedidoFEchado.create(nil);
    Lc_Param := TParamLucratividade.Create;
    Lc_Param.Periodo := False;
    Lc_Param.NumeroDocumento := Qr_NotaPED_NUMERO.AsString;
    Lc_Form.Parametros := Lc_Param;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - PEDIDO FECHADO';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Nota_Fiscal.TabSheet1Show(Sender: TObject);
begin
  Qr_FPgto.Active     := True;
end;

procedure TFr_Nota_Fiscal.Tbs_ConsertoShow(Sender: TObject);
begin
  Pc_AbrirConserto;
end;

procedure TFr_Nota_Fiscal.InformaoCombustivel1Click(Sender: TObject);
Var
  Form : TTasNfeItensFuel;
begin
  try
    Form := TTasNfeItensFuel.create(nil);
    Form.CodigoRegistro := Qr_ItensNotaITF_CODIGO.AsInteger;
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;

end;

procedure TFr_Nota_Fiscal.Itm_CadastroDestinatrioClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Cadastro do Destinatário','CADASTRO DESTINATARIO',GB_Cd_Usuario,'S') then
  Begin
    Fc_AbreTelaEmpresa(Qr_Nota.FieldByName('EMP_CODIGO').AsInteger );
    Pc_AbrirNota;
    if Qr_Nota.RecordCount > 0 then
      Pc_AbrirItensVenda
    else
      Close;
  end;
end;

procedure TFr_Nota_Fiscal.sb_obs_nfeClick(Sender: TObject);
begin
  if not Assigned(fr_obs_nfe) then Application.CreateForm(tfr_obs_nfe,fr_obs_nfe);
  fr_obs_nfe.it_cd_nfl:=Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
  fr_obs_nfe.showmodal
end;

procedure TFr_Nota_Fiscal.Itm_Nfe_ComplClick(Sender: TObject);
var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  sql_txt:String;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Nota Fiscal Complementar','GERAR COMPLEMENTAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        sql_txt:= ' select * from tb_retorno_nfe '+
                ' where NFE_CODSIT = 2'+
                ' AND NFE_CODNFL =:NFE_CODNFL  ';
        Active:=FALSE;
        SQL.Clear;
        SQL.Add(sql_txt);
        ParamByName('NFE_CODNFL').AsInteger:=Qr_Nota.fieldbyname('NFL_CODIGO').AsInteger;
        Active:=TRUE;
        IF IsEmpty THEN
        Begin
          MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                         'Nota não autorizada.'+EOLN+
                         'Solicite a autorização e tente novamente.'+EOLN,
                         ['OK'],[bEscape],mpErro);
        end
        else
        Begin
          try
            Application.CreateForm(TFr_Complementar,Fr_Complementar);
            Fr_Complementar.It_Cd_Nota_Ant    := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
            Fr_Complementar.ShowModal;
          finally
            FreeAndNil(Fr_Complementar);
          end;
        end;
      end;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  END;
end;

procedure TFr_Nota_Fiscal.AbrirContasPagar;
Var
  Lc_form : TFr_Pagar_multipla;
begin
  if Fc_VerificaPermissao('Fr_Pagar_Multipla','Contas a Pagar','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_form := TFr_Pagar_multipla.create(self);
    try
      Lc_form.E_BuscaPedido.Text := Qr_Nota.FieldByName('PED_NUMERO').AsString;
      Lc_form.ChBx_Periodo.Checked := fALSE;
      Lc_form.Cb_Situacao.ItemIndex := 4;
      Lc_form.showModal;
    finally
      FreeAndNil(Lc_form);
    end;
  End;
end;

procedure TFr_Nota_Fiscal.AbrirContasReceber;
Var
  Lc_form : TFr_Receber_multipla;
begin
  if Fc_VerificaPermissao('Fr_Receber_Multipla','Contas a Receber','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_form := TFr_Receber_multipla.create(self);
    try
      Lc_form.E_BuscaPedido.Text := Qr_Nota.FieldByName('PED_NUMERO').AsString;
      Lc_form.ChBx_Periodo.Checked := fALSE;
      Lc_form.Cb_Situacao.ItemIndex := 4;
      Lc_form.showModal;
    finally
      FreeAndNil(Lc_form);
    end;
  End;

end;

procedure TFr_Nota_Fiscal.AbrirOrdemServico;
Var
  LcModulo : String;
begin
  LcModulo := Fc_Tb_Geral('L','OSR_G_TIPO_MODULO','AUTO CENTER');
  case AnsiIndexStr(LcModulo, ['AUTO CENTER','EXTINTORES','EQUIPAMENTOS ELETRÔNICOS','PET SHOP','MOVELEIRO','GRAFICA']) of
    0:AbrirOrdemServicoAutoCenter;
    1:AbrirOrdemServicoExtintores;
    2:AbrirOrdemServicoEletronicos;
    3:AbrirOrdemServicoPetShop;
    4:AbrirOrdemServicoMoveleiro;
    5:AbrirOrdemServicoPrintShop;
    else
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Nenhum módulo específico de serviço foi ativado' + EOLN + EOLN ,
                     ['OK'], [bEscape], mpAlerta);
    End;
  end;

end;

procedure TFr_Nota_Fiscal.AbrirOrdemServicoAutoCenter;
Var
  Lc_Form : TFr_VehicleSo;
begin
  TRy
    Lc_Form := TFr_VehicleSo.Create(nil);
    with Lc_Form do
    begin
      with OrdemServico do
      Begin
        Registro.CodigoEstabelecimento := Gb_Codmha;
        Registro.CodigoCotacao := 0;
        Registro.CodigoPedido := Qr_NotaNFL_CODPED.AsInteger;
        with Vehicle do
        Begin
          Registro.CodigoEmpresa := Qr_NotaEMP_CODIGO.AsInteger;
        End;
      End;
      ShowModal;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Nota_Fiscal.AbrirOrdemServicoEletronicos;
Var
  LcForm : TTasOrderElectEquip;
begin
  try
    LcForm := TTasOrderElectEquip.Create(nil);
    LcForm.Conserto.Registro.Codped := Qr_NotaNFL_CODPED.AsInteger;
    LcForm.Conserto.getByPedido;
    if LcForm.Conserto.exist then
      LcForm.CodigoRegistro := LcForm.Conserto.Registro.Codigo
    else
      LcForm.CodigoRegistro := 0;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;


procedure TFr_Nota_Fiscal.AbrirOrdemServicoExtintores;
begin
  ShowMessage('Módulo Desativado');
end;

procedure TFr_Nota_Fiscal.AbrirOrdemServicoMoveleiro;
Var
  LcForm : TTasFurnitureOS;
begin
  try
    LcForm := TTasFurnitureOS.Create(nil);
    LcForm.CodigoRegistro := Qr_NotaNFL_CODPED.AsInteger;
    LcForm.FurnitureOS.Registro.Pedido := Qr_NotaNFL_CODPED.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Nota_Fiscal.AbrirOrdemServicoPetShop;
Var
  LcForm : TTasOrderPetShop;
begin
  try
    LcForm := TTasOrderPetShop.Create(nil);
    LcForm.CodigoRegistro := Qr_NotaNFL_CODPED.AsInteger;
    LcForm.Cliente := Qr_NotaEMP_CODIGO.AsInteger;
    LcForm.Atendimento.Registro.Pedido := Qr_NotaNFL_CODPED.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;

end;

procedure TFr_Nota_Fiscal.AbrirOrdemServicoPrintShop;
Var
  LcForm : TTasOrderPrintShop;
begin
  try
    LcForm := TTasOrderPrintShop.Create(nil);
    LcForm.PrintShop.Registro.Ordem := Qr_NotaNFL_CODPED.AsInteger;
    LcForm.PrintShop.Registro.Estabelecimento := Qr_NotaNFL_CODMHA.AsInteger;
    LcForm.PrintShop.getByPedido;
    if LcForm.PrintShop.exist then
      LcForm.CodigoRegistro := LcForm.PrintShop.Registro.Codigo
    else
      LcForm.CodigoRegistro := 0;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Nota_Fiscal.Acompanhamento1Click(Sender: TObject);
Var
  Form : TTasFollowup;
begin
  try
    Form := TTasFollowup.Create(nil);
    Form.CodigoRegistro := Qr_NotaPED_CODIGO.AsInteger;
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;

end;

procedure TFr_Nota_Fiscal.AlterarVendedor;
Var
  Form : TSeaCollaborator;
  LcVendedor : Integer;
  Pedido : TControllerPedido;
begin
  LcVendedor := Qr_NotaPED_CODVDO.AsInteger;
  Form := TSeaCollaborator.Create(nil);
  Pedido := TControllerPedido.Create(nil);
  Try
    Form.ShowModal;
    IF (Form.cds_searchCodigo.asInteger <> LcVendedor) then
    Begin
      try
        Pc_Log_Sistema( Gb_CodMha,
                        GB_Cd_Usuario,
                        (Now),
                        'Nota Fiscal de Produtos',
                        GB_Cd_Usuario,
                        'Alteração do Vendedor', concat('alterado de',LcVendedor.ToString, ' para ', Form.cds_searchCodigo.asString  ));
        Pedido.Registro.Codigo := Qr_NotaPED_CODIGO.AsInteger;
        Pedido.getbyId;
        Pedido.Registro.Vendedor := Form.cds_searchCodigo.asInteger;
        Pedido.atualiza;
        //Atualiza a Comissão
        //Geração de Comissão no faturamento
        Pc_Construtor_Comissao(DM.IB_Transacao);
        Pc_DeletaComissao(DM.IB_Transacao, Pedido.Registro.Codigo,0);
        Pc_Deleta_Vdo_Pedido(DM.IB_Transacao, Pedido.Registro.Codigo,0,'');
        PreecheAliquotaZero(DM.IB_Transacao, Pedido.Registro.Codigo);
        Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Pedido.Registro.Codigo);
        if Fc_Tb_Geral('L','TP_COMISSAO','') ='F' then
        Begin
          Pc_Gerar_Comissao_Vda_Fat(DM.IB_Transacao, Pedido.Registro.Codigo);
          Pc_Gerar_Comissao_Srv_Fat(DM.IB_Transacao, Pedido.Registro.Codigo);
          Pc_Gerar_Comissao_Srv_Vdo_Fat(DM.IB_Transacao, Pedido.Registro.Codigo);
        end;
        Pc_AbrirNota;
        Pc_AbrirItensVenda;
        MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                       'Alteração do Vendedor e '+EOLN+
                       'A comissão foi recalculada com sucesso.'+EOLN,
                      ['OK'],[bEscape],mpInformacao);
      finally
        Pc_Destrutor_Comissao;
      end;
    End;
  Finally
    FreeAndNil(Form);
    FreeAndNil(Pedido);
  End;
end;

procedure TFr_Nota_Fiscal.AnexarXML1Click(Sender: TObject);
Var
  Lc_Tipo : Integer;
  Lc_Dialogo : TOpenDialog;
  Lc_Path : String;
  Lc_File : String;
  Lc_I: Integer;
  Lc_Result : Boolean;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja anexar um XML a este registro? ' + EOLN +
                     '     Confirmar a atualização ?'+EOLN ,
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    Lc_Dialogo := TOpenDialog.Create(self);
    // Allow only .dpr and .pas files to be selected
    Lc_Dialogo.Filter := 'Arquivos XML - NF-|*.xml';
    Lc_Dialogo.FilterIndex := 1;
    if Lc_Dialogo.execute then
    Begin
      Lc_File := Lc_Dialogo.FileName;
      Lc_Path := '';
      for Lc_I := Length(Lc_File) downto 1 do
      Begin
        if (Lc_File[Lc_I] = '\') and (Lc_Path = '') then Lc_Path := IntToStr(Lc_I);
      end;
      Lc_PAth := copy(Lc_File,1,StrToIntDef(Lc_Path,0));
      Lc_File := Copy(Lc_File,Length(Lc_Path)+1,( ( Length(Lc_File) - Length(Lc_Path) )));
      with Qr_Nota do
      Begin
        if (FieldByname('NFL_TIPO').AsString = 'SI') or (FieldByname('NFL_TIPO').AsString = 'EI') then
          Lc_tipo := 1
        else
          Lc_tipo := 3;
        Lc_Result := Fc_AnexarXmlNFe(Lc_Tipo,FieldByname('NFL_CODIGO').AsInteger,Lc_Path,Lc_File);
        if Lc_Result then
        Begin

          MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                         'Arquivo Anexado com sucesso.'+EOLN,
                          ['OK'],[bEscape],mpInformacao);
        End
        else
        Begin
          MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                         ' O arquivo não foi anexado.'+EOLN+
                         'Verifique e tente novamente.'+ EOLN,
                         ['OK'],[bEscape],mpInformacao);
        End;
      End;
    End;
    FreeAndNil(Lc_Dialogo);
  end;
end;

procedure TFr_Nota_Fiscal.AplicarLote1Click(Sender: TObject);
Var
  LcRes : Boolean;
  LcMsg : String;
  LcCtrlLote : TControllerCtrlLote;
begin
  try
    Self.Enabled := False;
      //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
    Fc_AuditoriaEstoquePedido( Qr_NotaPED_CODIGO.AsInteger,'S');
    LcCtrlLote := TControllerCtrlLote.Create(nil);
    LcRes := LcCtrlLote.AplicaLotePedido(Qr_NotaPED_CODIGO.AsInteger);
    if LcRes then
      LcMsg := 'Lote Aplicado devidamente conforme disponibilidade.'
    else
      LcMsg := 'Lote já aplicado anteriormente ou não há lote disponivel';
  finally
    FreeAndNil(LcCtrlLote);
    Self.Enabled := True;
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Processo Finalizado com Sucesso' + EOLN +
                   LcMsg + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_Nota_Fiscal.AtualizarosCustos1Click(Sender: TObject);
Var
  Lc_Tipo : Integer;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Atualizar Custos','ATUALIZAR CUSTO',GB_Cd_Usuario,'S') then
  Begin
    Lc_Tipo:= Qr_NotaPED_TIPO.AsInteger;
    if Lc_Tipo = 4 then Lc_Tipo := 1;
    case Lc_Tipo of
      1:BEgin
          if (MensagemPadrao(TITULO_CONFIRMACAO,
                             '   Esta operação vai atualizar o custo dos produtos deste Documento. ' + EOLN +
                             'Antes de continuar tenha certeza de que estes custos estão corretos.'+ EOLN +
                             '                      Confirmar a atualização ?',
                             [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
          begin
            Pc_Log_Sistema( Gb_CodMha,
                            GB_Cd_Usuario,
                            (Now),
                            'Nota Fiscal de venda',
                            Qr_NotaNFL_CODIGO.AsInteger,
                            'Atualização de Custo ', concat('Custos do Pedido de Venda ',Qr_NotaPED_NUMERO.AsString, ' foram atualizados') );
            Pc_Atualiza_Custo_venda(Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);
          end;
      End;
      2:BEgin
          if (MensagemPadrao(TITULO_CONFIRMACAO,
                             ' Esta operação vai atualizar os custos no cadastro dos produtos' + EOLN +
                             'Problemas de temporalidade podem afetar o cálculo de custo médio.'+ EOLN +
                             'É recomendável ter muito cuidado com a utilização deste recurso.'+ EOLN +
                             '                     Confirmar a atualização ?',
                             [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
          begin
            Pc_Log_Sistema( Gb_CodMha,
                            GB_Cd_Usuario,
                            (Now),
                            'Nota Fiscal de Compra',
                            Qr_NotaNFL_CODIGO.AsInteger,
                            'Atualização de Custo',concat('Custos dos produtos constantes no Pedido de compra ',Qr_NotaPED_NUMERO.AsString, ' foram recalculados') );
            Pc_AtualizaCustosProdutos(Qr_Nota.FieldByName('NFL_CODPED').AsInteger,'',false);
          end;
      End
    else
    Begin
      MensagemPadrao(MENSAGEM,'A L E R T A!.'+EOLN+EOLN+
                     'Pedidos de Ajuste não atualizam custos.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
    End;
    end;
  end;
end;

procedure TFr_Nota_Fiscal.CalcularaComisso1Click(Sender: TObject);
Var
  Lc_Cd_Pedido : Integer;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Recalcular Comissão','RECALCULAR COMISSÃO',GB_Cd_Usuario,'S') then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja recalcular a comissão do Pedido Nº '+ Qr_Nota.FieldByName('PED_NUMERO').AsString +'.'+EOLN+EOLN+
                       'Confirmar o recálculo ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
      //Geração de Comissão no faturamento
      Lc_Cd_Pedido := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
      Pc_Construtor_Comissao(DM.IB_Transacao);
      Pc_DeletaComissao(DM.IB_Transacao, Lc_Cd_Pedido,0);
      Pc_Deleta_Vdo_Pedido(DM.IB_Transacao, Lc_Cd_Pedido,0,'');
      PreecheAliquotaZero(DM.IB_Transacao, Lc_Cd_Pedido);
      Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Lc_Cd_Pedido);
      if Fc_Tb_Geral('L','TP_COMISSAO','') ='F' then
      Begin
        Pc_Gerar_Comissao_Vda_Fat(DM.IB_Transacao, Lc_Cd_Pedido);
        Pc_Gerar_Comissao_Srv_Fat(DM.IB_Transacao, Lc_Cd_Pedido);
        Pc_Gerar_Comissao_Srv_Vdo_Fat(DM.IB_Transacao, Lc_Cd_Pedido);
      end;
      Pc_Destrutor_Comissao;
      MensagemPadrao(MENSAGEM,'S U C E S S O !.'+EOLN+EOLN+
                     'A comissão foi recalculada com sucesso.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
    end;
  end;
end;

procedure TFr_Nota_Fiscal.ChamarGeraNFE_AJT;
Var
  Lc_Form : TFr_geranfe_Ajt;
begin
  try
    TRy
      Lc_Form := TFr_geranfe_Ajt.Create(Self);
      Lc_Form.It_Cd_Pedido      := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
      Lc_Form.It_cd_Cliente     := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
      Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
      Lc_Form.It_Cd_Nota        := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
      Lc_Form.It_Nr_Nota        := StrToIntDef(Qr_Nota.FieldByName('NFL_NUMERO').AsString,0);
      Lc_Form.It_Nf_Terceiro    := (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EE');
      Lc_Form.ValorRecebido     := 0;
      Lc_Form.ValorTroco        := 0;
      Lc_Form.Height            := 600 - 15;

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

procedure TFr_Nota_Fiscal.ChamarGeraNFE_CPA;
Var
  Lc_Form : TFr_geranfe_cpa;
begin
  try
    TRy
      Lc_Form := TFr_geranfe_cpa.Create(Self);
      Lc_Form.It_Cd_Pedido      := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
      Lc_Form.It_cd_Cliente     := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
      Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
      Lc_Form.It_Cd_Nota        := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
      Lc_Form.It_Nr_Nota        := StrToIntDef(Qr_Nota.FieldByName('NFL_NUMERO').AsString,0);
      Lc_Form.It_Nf_Terceiro    := (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EE');
      Lc_Form.ValorRecebido     := 0;
      Lc_Form.ValorTroco        := 0;
      Lc_Form.Height            := 600 - 15;

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

procedure TFr_Nota_Fiscal.ChamarGeraNFE_VDA;
Var
  Lc_Form : TFr_GeraNFe_vda;
begin
  try
    TRy
      Lc_Form := TFr_GeraNFe_vda.Create(Self);
      Lc_Form.It_Cd_Pedido      := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
      Lc_Form.It_cd_Cliente     := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
      Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
      Lc_Form.It_Cd_Nota        := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
      Lc_Form.It_Nr_Nota        := StrToIntDef(Qr_Nota.FieldByName('NFL_NUMERO').AsString,0);
      Lc_Form.It_Nf_Terceiro    := (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EE');
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

procedure TFr_Nota_Fiscal.Dbg_FinanceiroDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  with Ds_FormaPgto.DataSet do
    Begin
    if (((FieldByName('FIN_TIPO').AsString = 'RA') or (FieldByName('FIN_TIPO').AsString = 'RM')) and (FieldByName('FIN_OPERACAO').AsString = 'D')) or
       (((FieldByName('FIN_TIPO').AsString = 'PA') or (FieldByName('FIN_TIPO').AsString = 'PM')) and (FieldByName('FIN_OPERACAO').AsString = 'C')) then
      Dbg_Financeiro.Canvas.Font.Color := clRed;
    end;
  Dbg_Financeiro.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

function TFr_Nota_Fiscal.Fc_ValidaAberturaCartaCorrecao():boolean;
Begin
  Result := True;
  if not Fc_ValidaexistenciaNFe then
  Begin
    Result := False;
    exit;
  end;
end;

procedure TFr_Nota_Fiscal.DBG_ProdutosTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Produtos, Column);
end;

procedure TFr_Nota_Fiscal.Itm_Carta_CorrecaoClick(Sender: TObject);
Var
  Lc_Chave : String;
  Lc_Form : TRegCorrectionLetter;
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Gerar Carta de Correção','CARTA DE CORREÇÃO',GB_Cd_Usuario,'S') then
  Begin
    if Fc_ValidaAberturaCartaCorrecao then
    Begin
      Lc_Form := TRegCorrectionLetter.create(self);
      Try
        Lc_Form.CodigoNotaFiscal := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
        Lc_Chave := Fc_ChaveDanfe_XMl(Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);
        //Retiramos o Texto e a extensão XML
        Lc_Chave := Copy(Lc_Chave,1,(Length(Lc_Chave)-8));
        Lc_Form.ChaveXML := Lc_Chave;
        Lc_Form.ShowModal;
      Finally
        FreeAndNil( Lc_Form );
      End;
    end;
  END;
end;

procedure TFr_Nota_Fiscal.Qr_ItensSrvAfterOpen(DataSet: TDataSet);
begin
  Qr_ItensSrv.FetchAll;
  Sb_Tecnico.Enabled := (Qr_ItensSrv.RecordCount>0);
end;

procedure TFr_Nota_Fiscal.CadastrodoProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    try
      Lc_Form := TFr_Produtos.Create(nil);
      Lc_Form.Produto.Registro.Codigo := Qr_ItensNota.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Form.ShowModal;
    finally
      FreeAndNil( Lc_Form );
    end;
  end;
end;

procedure TFr_Nota_Fiscal.AuditoriaEstoque1Click(Sender: TObject);
begin
  if Fc_AuditoriaEstoquePedido(Qr_Nota.FieldByName('PED_CODIGO').AsInteger,'S') then
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Foi atualizado o estoque dos produtos deste documento .' + EOLN +
                   'Veja na conferência de movimentação.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'O movimento dos produtos deste documento já estão registrados no estoque.' + EOLN +
                   'Veja na conferência de movimentação.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end;
end;

procedure TFr_Nota_Fiscal.RegistraNmerodeSrie1Click(Sender: TObject);
begin
  if Qr_ItensNota.RecordCount > 0 then
  Begin
    if not Assigned(Fr_Produto_Serie) then
      Application.CreateForm(TFr_Produto_Serie, Fr_Produto_Serie);
    Fr_Produto_Serie.Faturado := True;
    if Copy(Qr_NotaNFL_TIPO.AsString,1,1) = 'E' then
    Begin
      Fr_Produto_Serie.Tag := 1
    End
    else
    Begin
      Fr_Produto_Serie.Tag := 2;
    End;
    Fr_Produto_Serie.It_cd_Item := Qr_ItensNota.fieldByname('ITF_CODIGO').AsInteger;
    Fr_Produto_Serie.It_cd_Produto := Qr_ItensNota.fieldByname('ITF_CODPRO').AsInteger;
    Fr_Produto_Serie.It_Qt_Produto := Qr_ItensNota.fieldByname('ITF_QTDE').AsFloat;
    Fr_Produto_Serie.ShowModal;
   End;
end;

procedure TFr_Nota_Fiscal.RegistraNmerodolote1Click(Sender: TObject);
var
  Lc_Escolha: Integer;
  Lc_Form:TForm;
  Lc_Tipo : String;
begin
  case Qr_Nota.FieldByName('PED_TIPO').AsInteger of
    1:Lc_Tipo := 'VENDA';
    2:Lc_Tipo := 'COMPRA';
    3:Lc_Tipo := 'AJUSTE';
  end;

  if (Copy(Qr_Nota.FieldByName('NFL_TIPO').AsString,1,1) = 'E') then
  Begin
    try
      Lc_Form := TForm.Create(Fr_Ctrl_Lote_Entrada);
      Application.CreateForm(TFr_Ctrl_Lote_Entrada, Lc_Form);
      TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Item := Qr_ItensNota.FieldByname('ITF_CODIGO').AsInteger;
      TFr_Ctrl_Lote_Entrada(Lc_Form).It_Tipo := Lc_Tipo;
      TFr_Ctrl_Lote_Entrada(Lc_Form).it_Cd_produto := Qr_ItensNota.FieldByname('ITF_CODPRO').AsInteger;
      TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Empresa := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
      TFr_Ctrl_Lote_Entrada(Lc_Form).It_Qtde_Lote := Qr_ItensNota.FieldByname('ITF_QTDE').AsFloat;
      TFr_Ctrl_Lote_Entrada(Lc_Form).ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end
  else
  Begin
    try
      Lc_Form := TForm.Create(Fr_Ctrl_Lote_Saida);
      Application.CreateForm(TFr_Ctrl_Lote_Saida, Lc_Form);
      TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Item := Qr_ItensNota.FieldByname('ITF_CODIGO').AsInteger;
      TFr_Ctrl_Lote_Saida(Lc_Form).It_Tipo := Lc_Tipo;
      TFr_Ctrl_Lote_Saida(Lc_Form).it_Cd_produto := Qr_ItensNota.FieldByname('ITF_CODPRO').AsInteger;
      TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Empresa := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
      TFr_Ctrl_Lote_Saida(Lc_Form).It_Qtde_Lote := Qr_ItensNota.FieldByname('ITF_QTDE').AsFloat;
      TFr_Ctrl_Lote_Saida(Lc_Form).ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;

procedure TFr_Nota_Fiscal.Sb_FinanceiroClick(Sender: TObject);
Var
  Lc_Financeiro : TControllerFinanceiro;
Begin
  Try
    Lc_Financeiro := TControllerFinanceiro.create(Nil);
    Lc_Financeiro.Registro.CodigoNota := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
    Lc_Financeiro.getByCodigoNF;
    if Lc_Financeiro.exist then
    Begin
      if Copy(Lc_Financeiro.Registro.TipoFinanceiro,1,1) = 'R' then //RA ou RM
        AbrirContasReceber
      else
        AbrirContasPagar;
    End
    else
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Não foi localizado financeiro para para este registro.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
    End;
  Finally
    FreeAndNil(Lc_Financeiro);
  End;


end;

procedure TFr_Nota_Fiscal.Qr_IcmsCalcFields(DataSet: TDataSet);
begin
  with Qr_Icms do
  Begin
    if ( FieldByName('SET_FINANCIAL').AsString = 'N' ) then
      FieldByName('TEMFINANCEIRO').AsString := 'N'
    else
      FieldByName('TEMFINANCEIRO').AsString := 'S';
  End;
end;

procedure TFr_Nota_Fiscal.Qr_ItensDevAjusteAfterScroll(DataSet: TDataSet);
begin
  if Qr_ItensDevAjuste.RecordCount > 0 then
  Begin
    Qr_ItensNota.First;
    Qr_ItensNota.Locate('ITF_CODIGO',Qr_ItensDevAjusteITF_CODIGO.AsInteger,[]);
  End;
end;

procedure TFr_Nota_Fiscal.Qr_ItensNotaAfterScroll(DataSet: TDataSet);
begin
  Pc_AbrirItensICMS
end;

procedure TFr_Nota_Fiscal.Qr_ItensNotaCalcFields(DataSet: TDataSet);
Var
  Lc_Aux : Real;
begin
  with Qr_ItensNota do
  Begin
    Lc_Aux := FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').AsFloat;
    Lc_Aux := RoundTo( Lc_Aux ,-2);
    FieldByName('ITF_VL_SUBTOTAL').AsCurrency := Lc_Aux;

    FieldByName('ITF_VL_TOTAL').AsCurrency :=
        FieldByName('ITF_VL_SUBTOTAL').AsCurrency - FieldByName('ITF_VL_DESC').AsCurrency;
  End;
end;

procedure TFr_Nota_Fiscal.EnviaPedido1Click(Sender: TObject);
begin
  if (trim(Fc_Tb_Geral('L','PED_G_BANCO_DESTINO', '')) <> '') then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja efetuar uma cópia de Pedido/Nota existente para outro Banco de Dados.'+EOLN+EOLN+
                       'Confirmar a Cópia ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
      Fc_EnviaPedidoNota(1);
    end;
  end
  else
  Begin
    MensagemPadrao(TITULO_CONFIRMACAO, ATENCAO + EOLN + EOLN +
                   'O Caminho do Banco de Destino não está configurado.' + EOLN + EOLN +
                   'Para Configurar vá no menu Administração - Configurações,' + EOLN +
                   'e dentro do módulo Configurações Gerais clique em Pedido(s) e informe o caminho do Banco de Destino.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_Nota_Fiscal.Tbs_ServicoShow(Sender: TObject);
begin
  Pc_AbrirItensServico;
end;

function TFr_Nota_Fiscal.ValidaAlteraVendedor: Boolean;
begin
  Result := True;
  {
  if ( Qr_NotaCLB_NOME.asstring = '' ) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não há vendedor informado neste pedido.' + EOLN + EOLN +
                   'Não é possivel alterar '  + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  End;
  }
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Alterar o Vendedor deste pedido? ' + EOLN +
                     '     Confirmar a alteração ?'+EOLN ,
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao2) then
  begin
    Result := False;
    Exit;
  end;
end;

procedure TFr_Nota_Fiscal.Tbs_DevolucaoShow(Sender: TObject);
begin
  Pc_AbrirItensDevolucao;
end;

procedure TFr_Nota_Fiscal.tbs_dev_ajustesShow(Sender: TObject);
begin
  Pc_AbrirItensDevolvidoAjuste;
end;

procedure TFr_Nota_Fiscal.CpiadePedidoNota1Click(Sender: TObject);
begin

  Fc_CopiaPedidoNota(Qr_NotaPED_TIPO.AsInteger);
end;

procedure TFr_Nota_Fiscal.MnuAlterarVendedorClick(Sender: TObject);
begin
  if ValidaAlteraVendedor then
    AlterarVendedor;
end;

procedure TFr_Nota_Fiscal.MnuCustoPedidoClick(Sender: TObject);
Var
  Form : TRegCustoPedido;
begin
  Form := TRegCustoPedido.Create(nil);
  Try
    Form.CodigoPedido := Qr_NotaPED_CODIGO.AsInteger;
    Form.ShowModal;
  Finally
    FreeAndNil( Form );
  End;
end;

procedure TFr_Nota_Fiscal.MnuLucratividadeClick(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Venda','LUCRATIVIDADE',GB_Cd_Usuario,'S') then
  Begin
    if (trim(Qr_NotaNFL_NUMERO.AsString) = '') then
    Begin
      LucratividadePedidoFechado;
    end
    else
    Begin
      LucratividadeNotaFiscal;
    end;
  End;
end;

end.



