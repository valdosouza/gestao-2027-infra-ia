unit Un_Itens_Produto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask,
  STStoredProc, ComCtrls, Grids, DBGrids, STQuery, ActnList, QEdit_Setes,
  System.Math, ControllerItensNFL, Un_Fm_ListaEstoques, Actions,
  ControllerCtrlEstoque, Datasnap.DBClient, Un_fm_ListaTributacao,
  ControllerItensNflTributacao, ControllerItensCotacao, ControllerCliente,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TFr_Itens_Produto = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Qr_Servico: TSTQuery;
    AcaoMostra: TActionList;
    Action1: TAction;
    Qr_Preco_Qtde: TSTQuery;
    Action2: TAction;
    Ds_Tabela: TDataSource;
    Qr_Tabela: TSTQuery;
    DBG_Produtos: TDBGrid;
    ds_Items: TDataSource;
    pnl_botao_lista: TPanel;
    Sb_Exc_Produto: TBitBtn;
    Label8: TLabel;
    E_VL_Pedido: TPanel;
    Sb_Alt_Produto: TBitBtn;
    cds_items: TClientDataSet;
    cds_itemsITF_CODIGO: TIntegerField;
    cds_itemsITF_SEQUENCIA: TIntegerField;
    cds_itemsPRO_CODIGOFAB: TWideStringField;
    cds_itemsPRO_DESCRICAO: TWideStringField;
    cds_itemsMED_ABREVIATURA: TWideStringField;
    cds_itemsITF_QTDE: TBCDField;
    cds_itemsITF_VL_UNIT: TFMTBCDField;
    cds_itemsITF_VL_DESC: TBCDField;
    cds_itemsITF_VL_SUBTOTAL: TBCDField;
    cds_itemsITF_VL_TOTAL: TBCDField;
    cds_itemsITF_AQ_COM: TBCDField;
    cds_itemsITF_VL_IPI: TBCDField;
    cds_itemsTPR_NOME: TWideStringField;
    Pg_Main: TPageControl;
    tbs_item: TTabSheet;
    tbs_tributacao: TTabSheet;
    Fm_ListaEstoques: TFm_ListaEstoques;
    pnl_dados_items: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lb_Aq_com: TLabel;
    Lb_DescricaoProduto: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Lb_Largura: TLabel;
    Lb_Altura: TLabel;
    Lb_Nr_Pecas: TLabel;
    Label9: TLabel;
    E_CodPro: TEdit;
    E_Qt_Produto: TEdit_Setes;
    E_Vl_Unitario: TEdit_Setes;
    E_Aq_IPI: TEdit_Setes;
    E_Aq_Com: TEdit_Setes;
    E_Descricao: TEdit;
    E_Unidade: TEdit;
    E_VL_Desconto: TEdit_Setes;
    E_Aq_Desconto: TEdit_Setes;
    E_Aq_Icms: TEdit_Setes;
    E_VL_Produto: TPanel;
    E_Vl_SubTotal: TPanel;
    e_Largura: TEdit_Setes;
    E_Altura: TEdit_Setes;
    E_Nr_Peca: TEdit_Setes;
    Dblcb_Tabelas: TDBLookupComboBox;
    pnl_rodape: TPanel;
    SB_Gravar: TBitBtn;
    Sb_Pesquisar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    Sb_Limpar: TBitBtn;
    pnl_estoque: TPanel;
    Lb_Tipo: TLabel;
    Lb_CustoUnitario: TLabel;
    Sb_Corte: TSpeedButton;
    E_CustoUnitario: TEdit_Setes;
    E_Qtde_Disp: TPanel;
    Chbx_Estoque: TCheckBox;
    fm_ListaTributacao: Tfm_ListaTributacao;
    pnl_tributacao: TPanel;
    Label1: TLabel;
    chbx_do_not_set_financeiro: TCheckBox;
    Lb_Tipo_Regra: TLabel;
    LB_cst_csosn: TLabel;
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure E_Vl_UnitarioExit(Sender: TObject);
    procedure E_Qt_ProdutoExit(Sender: TObject);
    procedure E_Aq_IPIExit(Sender: TObject);
    procedure E_CodProExit(Sender: TObject);
    procedure E_DescricaoExit(Sender: TObject);
    procedure E_Vl_UnitarioEnter(Sender: TObject);
    procedure E_Qt_ProdutoEnter(Sender: TObject);
    procedure E_Aq_ComEnter(Sender: TObject);
    procedure E_CodProEnter(Sender: TObject);
    procedure E_DescricaoEnter(Sender: TObject);
    procedure E_Aq_DescontoExit(Sender: TObject);
    procedure E_VL_DescontoExit(Sender: TObject);
    procedure Qr_TabelaAfterOpen(DataSet: TDataSet);
    procedure Dblcb_TabelasClick(Sender: TObject);
    procedure E_CustoUnitarioExit(Sender: TObject);
    procedure Sb_LimparClick(Sender: TObject);
    procedure E_UnidadeEnter(Sender: TObject);
    procedure E_Aq_DescontoEnter(Sender: TObject);
    procedure E_VL_DescontoEnter(Sender: TObject);
    procedure E_Aq_IPIEnter(Sender: TObject);
    procedure E_Aq_IcmsEnter(Sender: TObject);
    procedure Sb_PesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Sb_CorteClick(Sender: TObject);
    procedure SB_GravarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Sb_Sair_0MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure E_AlturaExit(Sender: TObject);
    procedure e_LarguraExit(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sb_Exc_ProdutoClick(Sender: TObject);
    procedure DBG_ProdutosTitleClick(Column: TColumn);
    procedure DBG_ProdutosCellClick(Column: TColumn);
    procedure Action1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fm_ListaTributacaoDblcb_ListaClick(Sender: TObject);
    procedure tbs_tributacaoShow(Sender: TObject);
    procedure Pg_MainChange(Sender: TObject);
   private

    { Private declarations }

   protected

    CampoCusto : String;
    It_Casa_Decimal : String;
    It_Cd_Produto : Integer;
    Cliente : TControllerCliente;
    function PrecoUnitarioCompara(Pc_Cd_Tabela,Pc_Cd_Produto :Integer): String;
    procedure Pc_InsereServicoRelacionado(Pc_Codpro: Integer);Virtual;
    PROcedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Tabela :Integer; Pc_cd_Prod:String; Pc_Desc_prod:String);Virtual;
    procedure Pc_DefineCasaDecimalLocal;Virtual;
    function validaPreencheEstoque:Boolean;
    function validaPreenchePreco:Boolean;
    function validaPreencheCodigo:Boolean;
    function validaQuantidadePromocao:Boolean;
    function ValidacaoInicial:Boolean;
    function validaGravacao:Boolean;Virtual;
    function grava:boolean;Virtual;
    procedure verificatributacao; Virtual;
    procedure verificaBaseTroca; Virtual;
    procedure PreencheLabelTributacao;
    function SqlEspecifico:String;Virtual;
    procedure InsertItemns();virtual;
    procedure DeleteItems();Virtual;
    procedure SomaItems;
    procedure DefineValoresEspecificos(Pc_Cd_Tabela : Integer);Virtual;
    procedure Pc_PreencheTela(Pc_Codpro: string;
                              Pc_DESCRICAO: string;
                              Pc_VL_Venda: Real;
                              Pc_Custo: Real;
                              Pc_Unidade: string;
                              Pc_Aliq_Com: Real;
                              Pc_Qtde: Real;
                              Pc_Composicao:Integer;
                              Pc_Subs_Trib:String;
                              Pc_Vl_Base_Troca:Real);Virtual;
   public
    { Public declarations }

      ItensNFL : TControllerItensNFL;
      ItensCTC : TControllerItensCotacao;
      It_Pedido_Vda : Boolean;
      It_Pedido_Dev : Boolean;
      It_Pedido_Tro : Boolean;
      It_Cotacao_Vda : Boolean;
      It_Cotacao_Cmv : Boolean;
      It_Pedido_Cpa : Boolean;
      It_Pedido_Ajt : Boolean;

      it_pesq_produto:String; /// guarda o  q foi digitado na tela pesquisa produto
      It_MultiplicadorPreco: Currency;
      It_Pes_cod_barra:String;

      it_bt_pesquisa:Boolean;
      It_Dt_Operacao : Tdate;

      It_Inserir: Boolean;
      it_Cd_Empresa: integer;


      It_Disponivel: string;
      It_Cd_Vendedor:Integer;
      //TOTALIZADORES
      It_Vl_Campanha: Currency;
      It_Aliq_Comissao: Currency;
      It_Qt_Produto: Real;
      It_VL_Unitario: Currency;
      It_VL_Produto: Currency;
      It_Vl_Subtotal: Currency;
      //Controlar Tabelas de Preço
      it_Modalidade_preco:string;
      it_TipoCliente:string;
      //Controladores da Tributação
      Estado : Integer;
      Sentido : String;

      It_VL_bs_Icms: Currency;
      It_Aq_IPI: Real;
      It_Vl_IPI:Currency;
      It_Aq_icms: Real;
      It_Vl_Icms: Currency;
      It_StateChange: Integer;
      It_Composicao: Integer;
      CtrlEstoque : TControllerCtrlEstoque;
      Terminal : Integer;
      procedure Pc_Totalizador;Virtual;
      Function FC_Buscar(Pc_Tipo: char; Pc_Cd_Tabela:Integer; Pc_Codigo: string; Pc_Descricao: string):Integer;
      function FC_DefineTabela(Pc_Cd_Tabela : Integer):Integer;
      Procedure PC_Busca_Preco_Qtde(Pc_Cd_Tabela,Pc_Cd_Produto :Integer);
      Procedure PC_Verifica_Preco_Qtde(Pc_Cd_Tabela :Integer;Pc_Qt_Produto:Real);
      procedure Pc_MostraBusca;


      procedure Pc_MostraSaldo;virtual;
      function Fc_ProduraIPI(fc_cd_Produto: string): Real;

      procedure Pc_LimpaCampos;
//------------------------------------------------------------------------------
      procedure PosicaoCampoComissao;
      procedure Pc_FormataTela;Virtual;
      procedure Pc_IniciaVariaveis;Virtual;
      procedure Pc_InserirNovoItem;


      procedure Pc_InserecomposicaoVenda(Pc_Cd_Produto: Integer);
      procedure Pc_InserecomposicaoCotacao(Pc_Cd_Produto:Integer);


      function Fc_ExisteItemNoPedido(Pc_Tp_Operacao:String): Boolean;
      function Fc_ExisteItemNaCotacao(): Boolean;

      function Fc_Busca_Cod_barra(Pc_cod_barra:String): Integer;
      procedure Pc_StateChange(Pc_Tipo: integer);virtual;

      function Fc_Preco_Campanha(Fc_Cd_Produto : Integer):real;
      procedure Pc_Tabelas_Disponiveis(var Pc_Cd_Tabela:integer);//0 se a qtdade for = ou > do q a qtd tabela preco na promocao senao passa 2(se nao possui a quantidade minina a promocao nao e necessario mostra promocao
      Function  Fc_Aliquota_Comissao(fc_cd_vendedor, fc_Cd_TabelaPreco,Fc_Cd_Produto:Integer):Double;

      procedure Pc_CalculoMetroQuadrado;
      procedure LoadItems(Items:TSTQuery);Virtual;
      procedure editItems(CodigoItem: Integer);Virtual;
   end;

var
   Fr_Itens_Produto: TFr_Itens_Produto;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, Un_Pesq_Produto, Un_Fc_Sored_Procedures, Un_Liberacao, Un_Corte_Chapa, Un_Regra_Negocio, Un_WebService, RN_Compras, RN_Estoque, RN_Cotacao, Un_Cotacao, UN_Pedido_Vda, UN_Pedido_Cpa, UN_Pedido_Ajt, RN_Produto, RN_Lotes, UN_TabelasEmListas, Un_Itens_Produto_Vda, ControllerBase;
{$R *.dfm}


procedure TFr_Itens_Produto.Pc_Tabelas_Disponiveis(var Pc_Cd_Tabela:integer);
var
  Lc_SqlTxt: string;
  Lc_Modalidade: string;
begin
  Lc_Modalidade := UpperCase(it_Modalidade_preco);

  Lc_SqlTxt :=
    'SELECT TP.TPR_CODIGO, TP.TPR_NOME, TP.TPR_ATIVA, TP.TPR_PRINCIPAL, TP.TPR_MODALIDADE, TP.TPR_TIPO_CLIENTE ' + sLineBreak +
    'FROM TB_TABELA_PRECO TP ' + sLineBreak +
    'WHERE TP.TPR_ATIVA = ''S'' ';

  if Pc_Cd_Tabela = 2 then
    Lc_SqlTxt := Lc_SqlTxt + ' AND TP.TPR_CODIGO = :TPR_CODIGO '
  else
    Lc_SqlTxt := Lc_SqlTxt + ' AND TP.TPR_CODIGO <> :TPR_CODIGO ';

  if (Fc_Tb_Geral('L','VDA_G_CTRL_TABELA_X_PRAZO','') = 'S') then
  begin
    if Lc_Modalidade <> 'A' then
      Lc_SqlTxt := Lc_SqlTxt +
        ' AND (TP.TPR_MODALIDADE = :P_MODALIDADE OR TP.TPR_MODALIDADE = ''A'') ';
  end;

  if (Fc_Tb_Geral('L','VDA_G_CTRL_TB_TP_CLIENTE','N') = 'S') then
  begin
    Lc_SqlTxt := Lc_SqlTxt +
      ' AND (TP.TPR_TIPO_CLIENTE = :P_TIPOCLIENTE OR TP.TPR_TIPO_CLIENTE = ''A'') ';
  end;

  Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY TP.TPR_PRINCIPAL DESC ';

  Qr_Tabela.Close;
  Qr_Tabela.SQL.Text := Lc_SqlTxt;

    Qr_Tabela.ParamByName('TPR_CODIGO').AsInteger := 2; //sempre sera 2 que é a tabela de promocao. ou sera igual ou sera diferente

  if (Pos(':P_MODALIDADE', Lc_SqlTxt) > 0) then
    Qr_Tabela.ParamByName('P_MODALIDADE').AsString := Lc_Modalidade;

  if (Pos(':P_TIPOCLIENTE', Lc_SqlTxt) > 0) then
    Qr_Tabela.ParamByName('P_TIPOCLIENTE').AsString := it_TipoCliente;

  Qr_Tabela.Open;

  // Só define KeyValue se existir no dataset
  if not Qr_Tabela.IsEmpty then
  Begin
    if Pc_Cd_Tabela = 2 then
      Dblcb_Tabelas.KeyValue := 2
    else
      Pc_Cd_Tabela := Qr_Tabela.FieldByName('TPR_CODIGO').AsInteger;
    Dblcb_Tabelas.KeyValue := Pc_Cd_Tabela;
  End;

  // Ajusta de acordo com a Tabela do Cliente, se ela existir no dataset
  Cliente.Registro.Codigo := It_Cd_Empresa;
  Cliente.getById;
  if Cliente.exist and (Cliente.Registro.TabelaPreco > 0) then
  begin
    if not Qr_Tabela.Locate('TPR_CODIGO',
                            Cliente.Registro.TabelaPreco,
                            []) then
    begin
      // Opcional: reabrir incluindo a tabela do cliente,
      // ou manter o valor atual. Exemplo de fallback: nada.
    end
    else
      Dblcb_Tabelas.KeyValue := Cliente.Registro.TabelaPreco;
  end;
end;

function TFr_Itens_Produto.Fc_Preco_Campanha(Fc_Cd_Produto : Integer):real;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT PRC_VL_VDA,PRC_AQ_COM ' +
                  ' FROM TB_PRECO Tb_preco ' +
                  ' WHERE (PRC_CODPRO=:PRC_CODPRO) AND (PRC_CODTPR=:PRC_CODTPR) ';
      SQL.Add(Lc_SqlTxt);
      Active := False;
      ParamByName('PRC_CODPRO').AsInteger := fc_cd_Produto;
      ParamByName('PRC_CODTPR').AsInteger := 2;
      Active := True;
      FetchAll;
      First;
      if not IsEmpty then
      Begin
        It_Vl_Campanha := FieldByName('PRC_VL_VDA').AsCurrency;
      end
      else
      Begin
        It_Vl_Campanha := 0;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


function TFr_Itens_Produto.Fc_ProduraIPI(fc_cd_Produto: string): Real;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT TRB_AQ_IPI ' +
                   ' FROM TB_TRIBUTACAO Tb_tributacao ' +
                  ' WHERE (TRB_CODPRO=:PRO_CODIGO) and (TRB_CODMHA=:TRB_CODMHA) '+
                  'ORDER BY TRB_AQ_IPI  DESC ';
      SQL.Add(Lc_SqlTxt);
      Active := False;
      ParamByName('PRO_CODIGO').AsString := fc_cd_Produto;
      ParamByName('TRB_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      FetchAll;
      First;
      if not IsEmpty then
        Result := FieldByName('TRB_AQ_IPI').AsCurrency
      else
        Result := 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Itens_Produto.fm_ListaTributacaoDblcb_ListaClick(Sender: TObject);
begin
  PreencheLabelTributacao;
end;

function TFr_Itens_Produto.Fc_ExisteItemNoPedido(Pc_Tp_Operacao:String): Boolean;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
   Lc_Escolha: Integer;
  LcBase : TControllerBase;
begin
  Try
    Result := True;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt :=  'SELECT PRO_CODIGO, ITF_QTDE, ITF_CODIGO ' +
                    ' FROM TB_ITENS_NFL Tb_itens_nfl ' +
                    '    INNER JOIN TB_PRODUTO Tb_produto ' +
                    '    ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) ' +
                    ' WHERE PRO_CODIGO=:PRO_CODIGO AND (ITF_CODPED=:ITF_CODPED) and (ITF_OPER=:ITF_OPER) ';
      SQL.Add(Lc_SqlTxt);
      Active := False;
      ParamByName('ITF_OPER').AsString := Pc_Tp_Operacao;
      ParamByName('ITF_CODPED').AsInteger := ItensNFL.Registro.CodigoPedido;
      ParamByName('PRO_CODIGO').AsInteger := It_Cd_Produto;
      Active := True;
      FetchAll;
      First;
      if (RecordCount > 0) and (It_StateChange = 2) then
      Begin
         Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                       'O Produto ' + E_Descricao.Text + ' já está no relação.' + EOLN + EOLN +
                                       'O que deseja fazer ?',
                                       ['Atualizar', 'Inserir','Cancelar'], [bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
        case Lc_Escolha of
          0:Begin
              ItensNFL.Registro.Codigo := FieldByName('ITF_CODIGO').AsInteger;
              It_StateChange := 3;
              Lc_Qtde := StrToFloatDef(E_Qt_Produto.Text,1);
              E_Qt_Produto.Text := FloatToStrF(Lc_Qtde + FieldByName('ITF_QTDE').AsFloat, ffFixed, 10, 2);
              Result := true;
            end;
          1:Begin
              Result := True;
            end;
          2:Begin
              Result := False;
            end;
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function TFr_Itens_Produto.Fc_ExisteItemNaCotacao(): Boolean;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
   Lc_Escolha: Integer;
  LcBase : TControllerBase;
begin
  Try
    Result := True;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt :=  'SELECT PRO_CODIGO, ICT_QTDE, ICT_CODIGO ' +
                    ' FROM TB_ITENS_CTC Tb_itens_ctc ' +
                    '    INNER JOIN TB_PRODUTO Tb_produto ' +
                    '    ON  (Tb_produto.PRO_CODIGO = Tb_itens_ctc.ICT_CODVCL) ' +
                    ' WHERE PRO_CODIGO=:PRO_CODIGO AND (ICT_CODCTC=:ICT_CODCTC) ';
      SQL.Add(Lc_SqlTxt);
      Active := False;
      ParamByName('ICT_CODCTC').AsInteger := ItensCTC.Registro.Cotacao;
      ParamByName('PRO_CODIGO').AsInteger := It_Cd_Produto;
      Active := True;
      FetchAll;
      First;
      if (RecordCount > 0) and (It_StateChange = 2) then
        Begin
         Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                       'O Produto ' + E_Descricao.Text + ' já está no relação.' + EOLN + EOLN +
                                       'O que deseja fazer ?',
                                       ['Atualizar', 'Inserir','Cancelar'], [bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
         case Lc_Escolha of
            0:Begin
                ItensCTC.Registro.Codigo := FieldByName('ICT_CODIGO').AsInteger;
                It_StateChange := 3;
                Lc_Qtde := StrToFloatDef(E_Qt_Produto.Text,1);
                E_Qt_Produto.Text := FloatToStrF(Lc_Qtde + FieldByName('ICT_QTDE').AsFloat, ffFixed, 10, 2);
                Result := true;
              end;
            1:Begin
                Result := True;
              end;
            2:Begin
                Result := False;
              end;
          end;
        end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


function TFr_Itens_Produto.FC_Buscar(Pc_Tipo: char; Pc_Cd_Tabela:Integer; Pc_Codigo: string; Pc_Descricao: string):Integer;
var
   Lc_SqlTxt: string;
   Lc_Codigo: boolean;
   Lc_Descricao: boolean;
   Lc_CodigoInteiro: Integer;
   Lc_Barras: Integer;
Begin
  Lc_SqlTxt := '';
  It_Cd_Produto := 0;
  Screen.Cursor := crHourGlass;

  if Pc_Codigo = EmptyStr then    Lc_Codigo := False else  Lc_Codigo := True;
  if Pc_Descricao = EmptyStr then Lc_Descricao := False  else Lc_Descricao := True;

  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;

  Lc_SqlTxt :=  'SELECT '+
                '   PRO_CODIGO, '+
                '   PRO_CODIGOFAB, '+
                '   PRO_CODIGOFOR, '+
                '   PRO_CODIGOBAR, '+
                '   PRO_DESCRICAO, '+
                CampoCusto + ' PRO_VL_CUSTO,  '+
                '   MED_ABREVIATURA, '+
                '   PRO_CAMPANHA, '+
                '   PRO_ATIVO, '+
                '   PRO_COMPOSICAO, '+
                '   PRO_SUB_TRIB, '+
                '   CAST((COALESCE(PRO_VL_BASE_TROCA, 0) * COALESCE(PRO_PESO, 0)) AS NUMERIC(18, 2)) PRO_VL_BASE_TROCA '+
                'FROM TB_PRODUTO tb_produto  '+
                '   INNER JOIN TB_MEDIDA MED '+
                '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                '   INNER JOIN TB_ESTOQUE EST '+
                '   ON  (EST.EST_CODPRO = tb_produto.PRO_CODIGO)  '+
                'WHERE (PRO_CODIGO IS NOT NULL) AND (PRO_ATIVO = ''S'')  ';

  IF Trim(Fm_ListaEstoques.Dblcb_Estoque.Text)<>'' then
    Lc_SqlTxt :=  Lc_SqlTxt + 'AND (EST_CODETS =:EST_CODIGO) ';

  if Pc_Tipo = 'P' then
  Begin
    if Pc_Codigo = '' then    Lc_Codigo := False else  Lc_Codigo := True;
    Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);
    if Lc_Codigo THEN
    Begin
     //Verifica se é um numero ou se é alfa-numerico
     IF Lc_CodigoInteiro = 0 THEN
       Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))'
     else
       Lc_Sqltxt := Lc_Sqltxt + 'AND (PRO_CODIGO =:PRO_CODIGO) ';
    end;

    Lc_SqlTxt := Lc_SqlTxt + SqlEspecifico;

    if not GB_ProdCompartilha then   Lc_SqlTxt := Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';
  end
  else
  Begin
    Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);
    Lc_Barras := Length(Pc_Codigo);
    if Lc_Codigo THEN
      Begin
      //Verifica se a busca será pelo codigo Exato
      if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') then
        Begin
        //Verifica se é um numero ou se é alfa-numerico
        IF Lc_CodigoInteiro = 0 THEN
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))'
        else
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO))';
        end
      else
        Begin
        //Verifica se é um numero ou se é alfa-numerico
        IF Lc_CodigoInteiro = 0 THEN
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE:PRO_CODIGO))'
        else
           Lc_Sqltxt := Lc_Sqltxt + 'AND ((PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO))';
        end;
      end;

    if Lc_Descricao then   Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';


    Lc_SqlTxt := Lc_SqlTxt + SqlEspecifico;
    if not GB_ProdCompartilha  then   Lc_SqlTxt := Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';
  end;

  Qr_Pesquisa.SQL.Add(Lc_SqlTxt);

  //PASSAGEM de parametro

  IF Trim(Fm_ListaEstoques.Dblcb_Estoque.Text)<>'' then
    Qr_Pesquisa.ParamByName('EST_CODIGO').AsInteger := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;

  if Lc_Codigo THEN
    Begin
    //Verifica se a busca será pelo codigo Exato
    if (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') then
      Begin
      Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo;
      end
    else
      Begin
      if Pc_Tipo = 'P' then
        Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo
      else
        Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := '%' + Pc_Codigo + '%';
      end;
    end;

  if Lc_Descricao THEN  Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Pc_Descricao,1,98) + '%';
  if not GB_ProdCompartilha  then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result := Qr_Pesquisa.RecordCount;
  if Result = 1 THEN
    It_Cd_Produto := Qr_Pesquisa.FIELDBYNAME('PRO_CODIGO').AsInteger;
end;

function TFr_Itens_Produto.FC_DefineTabela(Pc_Cd_Tabela : Integer):Integer;
  procedure TabelaEscolhida;
  Begin
    Pc_Tabelas_Disponiveis(Pc_Cd_Tabela);
    Dblcb_Tabelas.KeyValue:=Pc_Cd_Tabela;
    Result := Pc_Cd_Tabela;
  end;

  procedure TabelaPromo;
  var
    Lc_Cd_Tabela : Integer;
  Begin
    Lc_Cd_Tabela := 2;
    Pc_Tabelas_Disponiveis( Lc_Cd_Tabela );
    Dblcb_Tabelas.KeyValue:= Lc_Cd_Tabela;
    Result := Lc_Cd_Tabela;
  end;

Begin
  if Qr_Pesquisa.Active then
  Begin
    if Qr_Pesquisa.RecordCount > 0 then
    Begin
      if (Qr_Pesquisa.FieldByName('PRO_CAMPANHA').AsString = 'S') then
        TabelaPromo
      else
        TabelaEscolhida;
    End
  End
  else
    TabelaEscolhida;

end;

Procedure TFr_Itens_Produto.PC_Verifica_Preco_Qtde(Pc_Cd_Tabela :Integer;Pc_Qt_Produto:Real);
Var
  Lc_Cd_Tabela : Integer;
Begin
  Qr_Preco_Qtde.Active := False;
  Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := It_Cd_Produto;
  Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := 2;
  Qr_Preco_Qtde.Active := True;
  Qr_Preco_Qtde.FetchAll;
  Qr_Preco_Qtde.First;
  if ((StrToFloatDef(E_Qt_Produto.Text,1))>=Qr_Preco_Qtde.FieldByName('PRC_QT_MIN').AsFloat)
    AND(Qr_Preco_Qtde.FieldByName('PRO_CAMPANHA').AsString = 'S') then
  Begin
    Lc_Cd_Tabela := 2;
    E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency);
    Pc_Tabelas_Disponiveis(Lc_Cd_Tabela);
    Dblcb_Tabelas.KeyValue:=Lc_Cd_Tabela;
  end
  else
  Begin
    Lc_Cd_Tabela := 0;
    Pc_Tabelas_Disponiveis( Lc_Cd_Tabela );
    Qr_Preco_Qtde.Active := False;
    Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := It_Cd_Produto;
    Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := Dblcb_Tabelas.KeyValue;
    Qr_Preco_Qtde.Active := True;
    Qr_Preco_Qtde.FetchAll;
    Qr_Preco_Qtde.First;
    E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency * It_MultiplicadorPreco);
  end;
end;

procedure TFr_Itens_Produto.Pg_MainChange(Sender: TObject);
begin
  If It_Cd_Produto = 0 then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Por favor defina o produto antes de acessar a Aba Tributação.' + EOLN+
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    Pg_Main.ActivePage := tbs_item;
    exit;
  End;
  PreencheLabelTributacao;
end;

procedure TFr_Itens_Produto.PosicaoCampoComissao;
begin
  if ((Fc_Tb_Geral('L','VDA_G_EDIT_AQ_COM','') = 'S')) then
  Begin
    E_VL_Produto.Width := 79;
    lb_Aq_com.Visible := true;
    e_Aq_com.Visible := true;
  end
  else
  Begin
    E_VL_Produto.Width := 133;
    lb_Aq_com.Visible := false;
    e_Aq_com.Visible := False;
  end;

end;

function TFr_Itens_Produto.PrecoUnitarioCompara(Pc_Cd_Tabela,Pc_Cd_Produto :Integer): String;
begin
  Qr_Preco_Qtde.Active := False;
  Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Produto;
  Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := Pc_Cd_Tabela;
  Qr_Preco_Qtde.Active := True;
  Qr_Preco_Qtde.FetchAll;
  result := FormatFloat(It_Casa_Decimal, Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency);
end;

procedure TFr_Itens_Produto.PreencheLabelTributacao;
begin
  if fm_ListaTributacao.Dblcb_Lista.Text <> '' then
  Begin
    LB_cst_csosn.Caption := concat('CST/CSOSN: ',fm_ListaTributacao.Qr_ListaCST_CSOSN.AsString);
    if fm_ListaTributacao.Qr_ListaTRB_CODPRO.AsInteger >0 then
      Lb_Tipo_Regra.Caption := Concat('Tipo Regra: Produto : ',fm_ListaTributacao.Qr_ListaPRO_DESCRICAO.AsString)
    else
      Lb_Tipo_Regra.Caption := 'Tipo Regra: Definida como Regra Geral';
  End
  else
  Begin
    LB_cst_csosn.Caption := 'CST/CSOSN: ';
    Lb_Tipo_Regra.Caption := 'Tipo Regra: ';
  End;

end;

Procedure TFr_Itens_Produto.PC_Busca_Preco_Qtde(Pc_Cd_Tabela,Pc_Cd_Produto :Integer);
Var
  Lc_VL_Poduto: Real;
  Lc_Qt_Poduto: Real;
  Lc_Aq_Com: Real;
Begin
  Qr_Preco_Qtde.Active := False;
  Qr_Preco_Qtde.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Produto;
  Qr_Preco_Qtde.ParamByName('PRC_CODTPR').AsInteger := Pc_Cd_Tabela;
  Qr_Preco_Qtde.Active := True;
  Qr_Preco_Qtde.FetchAll;
  Qr_Preco_Qtde.First;

end;


procedure TFr_Itens_Produto.Pc_PreencheTela(Pc_Codpro: string;
                                            Pc_DESCRICAO: string;
                                            Pc_VL_Venda: Real;
                                            Pc_Custo: Real;
                                            Pc_Unidade: string;
                                            Pc_Aliq_Com: Real;
                                            Pc_Qtde: Real;
                                            Pc_Composicao:Integer;
                                            Pc_Subs_Trib:String;
                                            Pc_Vl_Base_Troca:Real);
var
   Lc_Codigo: integer;
Begin
  if (It_StateChange = 2) then
  Begin
    E_CodPro.Text := Pc_Codpro;
    E_Descricao.Text := COPY(Pc_DESCRICAO,1,100);
  end;
  //Informa se o produto tem substitução ou não 
  if Pc_Subs_Trib = 'S' then
    Lb_DescricaoProduto.Caption := 'Descrição do Produto - PRODUTO SUJEITO A SUBSTITUIÇÃO TRIBUTÁRIA '
  else
    Lb_DescricaoProduto.Caption := 'Descrição do Produto ';

  It_Composicao := Pc_Composicao;
  E_Vl_Unitario.Text := formatFloat(It_Casa_Decimal,Pc_VL_Venda);
  if (StrToFloatDEf(E_Vl_Unitario.Text,0) = 0) then
  Begin
    E_Qt_Produto.Text := formatFloat('0.###', Pc_Qtde);
  end;
  E_Unidade.Text := Pc_Unidade;
  E_Aq_Com.Text := FloatToStrF(Pc_Aliq_Com, ffFixed, 10, 2);
  IF StrtoFloatDef(E_Aq_IPI.Text,0) = 0 THEN
  Begin
    It_Aq_IPI := Fc_ProduraIPI(Pc_Codpro);
    E_Aq_IPI.Text := FloatToStrF(It_Aq_IPI, ffFixed, 10, 2);
    //Quando tem IPI refaz o Calculo inverso do Valor Unitário
    if (It_Aq_IPI >0) then
    Begin
      Pc_VL_Venda := Pc_VL_Venda / (1 + (It_Aq_IPI/100));
      E_Vl_Unitario.Text := formatFloat(It_Casa_Decimal,Pc_VL_Venda);
    end;
  end;
  if Pc_Qtde = 0 then Pc_Qtde := 1;
  E_Qt_Produto.Text := formatFloat('#,##0.##',Pc_Qtde);
  E_CustoUnitario.Text := FloatToStrF(Pc_Custo, ffFixed, 14, 6);

  if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
  if (It_Pes_cod_barra = 'S') and E_Qt_Produto.CanFocus THEN
  if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
end;

procedure TFr_Itens_Produto.Pc_MostraSaldo;
Var
  Lc_Qtde : real;
begin
  E_Qtde_Disp.ParentColor := False;
  E_Qtde_Disp.ParentFont := False;
  Lb_Tipo.Font.Color := clGreen;
  E_Qtde_Disp.Color := clGreen;
  if (It_Cd_Produto > 0) then
    Lc_Qtde := Fc_SaldoEstoque(StrToIntDef(E_CodPro.Text,0),Fm_ListaEstoques.Dblcb_Estoque.KeyValue);
  if (Lc_Qtde <= 0) and (trim(E_CodPro.Text) <> '') then
  Begin
    Lb_Tipo.Font.Color := clRed;
    E_Qtde_Disp.Color := clRed;
  end;
  E_Qtde_Disp.Caption := formatFloat('0.##',Lc_Qtde );
end;

procedure TFr_Itens_Produto.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
  LcCodpro : String;
  LcCodTpr : Integer;
begin
  Try
    Lc_Form := TFr_Pesq_Produto.Create(nil);
    Lc_Form.CodigoPedido          := Self.ItensNFL.Registro.CodigoPedido;
    Lc_Form.CodigoCotacao         := Self.ItensCTC.Registro.Cotacao;
    Lc_Form.It_Cd_Empresa         := Self.it_Cd_Empresa;
    Lc_Form.It_Pedido_Vda         := Self.It_Pedido_Vda;
    Lc_Form.It_Pedido_Dev         := Self.It_Pedido_Dev;
    Lc_Form.It_Pedido_Tro         := Self.It_Pedido_Tro;
    Lc_Form.It_Pedido_Cpa         := Self.It_Pedido_Cpa;
    Lc_Form.It_Pedido_Ajt         := Self.It_Pedido_Ajt;
    Lc_Form.it_Modalidade_preco   := it_Modalidade_preco;
    Lc_Form.it_TipoCliente        := it_TipoCliente;
    Lc_Form.Pc_Tabelas_Disponiveis;
    Lc_Form.It_MultiplicadorPreco := It_MultiplicadorPreco;
    Lc_Form.E_BuscaCodigo.Text    := E_CodPro.Text;
    Lc_Form.E_BuscaDescricao.Text := E_Descricao.Text;


    Lc_Form.ShowModal;
    //Depois que Fecha o Relatorio
    if Lc_Form.It_Visualizar then
    Begin
      Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Lc_Form.Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
      Dblcb_Tabelas.KeyValue := Lc_Form.Dblcb_Tabelas.KeyValue;
      LcCodpro := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      LcCodTpr := Lc_Form.Dblcb_Tabelas.KeyValue;
      E_CodPro.Text:= LcCodpro;
      E_Descricao.Text:='';
      E_Vl_Unitario.Text := '0';
      Self.Pc_Tip_Busca('P',LcCodTpr,LcCodpro,'');
      Pc_MostraSaldo;
    end
    else
    Begin
      if E_CodPro.CanFocus then E_CodPro.SetFocus;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;


end;

procedure TFr_Itens_Produto.Pc_Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
  Lc_Qt_aux : Real;
  Lc_VL_IPI : Real;

begin
  Lc_Vl_Total := 0;
  //Quanatidade PRodutos
  Lc_Qt_aux := StrToFloatDef(E_Qt_Produto.Text,1);
  E_Qt_Produto.Text := FormatFloat('0.00#', Lc_Qt_aux);
  //Valor dos Produtos
  Lc_Vl_aux := StrToFloatDef(E_Vl_Unitario.Text, 0);
  //Valor Subtotal Do Produto
  Lc_Vl_aux := Lc_Vl_aux * Lc_Qt_aux ;
  Lc_Vl_aux := RoundTo( Lc_Vl_aux, -2);
  E_VL_Produto.Caption := FloatToStrF( Lc_Vl_aux, ffFixed, 10, 2);
  //Ipi
  Lc_Vl_aux := StrToFloatDef(E_Aq_IPI.Text, 0);
  Lc_VL_IPI := StrToFloatDef(E_VL_Produto.Caption, 0)  * (Lc_Vl_aux/100);
  E_Aq_IPI.Text := FloatToStrF(RoundTo( Lc_Vl_aux,-3), ffFixed, 10, 2);
  //Desconto
  Lc_Vl_aux := StrToFloatDef(E_VL_Desconto.Text, 0);
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Valor total
  Lc_Vl_aux := StrToFloatDef(E_VL_Produto.Caption,0);
  Lc_Vl_aux := Lc_Vl_aux + Lc_VL_IPI;
  Lc_Vl_aux := Lc_Vl_aux - StrToFloatDef(E_VL_Desconto.Text, 0);
  Lc_Vl_aux := RoundTo( Lc_Vl_aux, -2 );
  E_Vl_SubTotal.Caption := FloattoStrf(Lc_Vl_aux,ffFixed,10,2);

end;

procedure TFr_Itens_Produto.Pc_CalculoMetroQuadrado;
Var
  Lc_Altura : Real;
  Lc_Largura : Real;
  Lc_Nr_Pecas : Real;
  Resultado : Real;
Begin
  //Calulo divisor é de metro para milimetro
  if ( Fc_Tb_Geral('L','PRO_G_PRO_ITEMPEDMOD50','S') = 'S') then
  Begin
    Lc_Altura := Fc_ArredondamentoModCinco( StrtoFloatDef(E_Altura.Text,0) );
    Lc_Largura := Fc_ArredondamentoModCinco( StrtoFloatDef(E_Largura.Text,0) );
  End
  else
  Begin
    Lc_Altura := StrtoFloatDef(E_Altura.Text,0) ;
    Lc_Largura := StrtoFloatDef(E_Largura.Text,0) ;
  End;
  Lc_Nr_Pecas := StrtoFloatDef(E_Nr_Peca.Text,0) ;
  Resultado := Lc_Altura * Lc_Largura;
  Resultado := Resultado /1000000;
  Resultado := (Resultado * Lc_Nr_Pecas);
  E_Qt_Produto.Text := FloatToStrF(Resultado, ffFixed, 10,3);
End;

procedure TFr_Itens_Produto.Pc_LimpaCampos;
Var
  LcCodigoPedido : Integer;
  LcCodigoCotacao : Integer;
Begin
  //guardo o codigo do pedido
  LcCodigoPedido := ItensNFL.Registro.CodigoPedido;
  LcCodigoCotacao := ItensCTC.Registro.Pedido;
  //Limpa dados do objeto
  ItensNFL.clear;
  ItensCTC.clear;
  //REcoloca o codigo do pedido para inserir os proximos itens;
  ItensNFL.Registro.CodigoPedido := LcCodigoPedido;
  ItensCTC.Registro.Pedido := LcCodigoCotacao;
  It_Cd_Produto := 0;

  E_CodPro.Text := '';
  E_Descricao.Clear;
  E_Vl_Unitario.Text := '0,00';
  E_Qt_Produto.Text := '1';
  E_Vl_Produto.Caption := '0,00';
  E_Unidade.Clear;
  E_Aq_Com.Text := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  E_Aq_IPI.Text := '0,00';
  E_Aq_Icms.Text := '0,00';
  E_Vl_SubTotal.Caption := '0,00';
  E_Qtde_Disp.Caption := '0';
  E_CustoUnitario.Text := '0,00';
  E_Largura.Text := '0';
  E_Altura.Text := '0';
end;


procedure TFr_Itens_Produto.Pc_StateChange(Pc_Tipo: integer);
Begin
  It_StateChange := Pc_Tipo;
  case Pc_Tipo of
    2:Begin //Inserindo
        Fm_ListaEstoques.Dblcb_Estoque.Enabled := True;
        Dblcb_Tabelas.Enabled := True;
        E_CodPro.Enabled := True;
        E_Descricao.Enabled := True;
        E_Qt_Produto.Enabled := True;
        E_Aq_IPI.Enabled := True;
        SB_Gravar.Enabled := True;
        Sb_Pesquisar.Enabled := True;
        pnl_botao_lista.Visible := TRue;
        DBG_Produtos.Visible := TRue;
        Height := 650;
      end;
    3:Begin //Alterando
        Fm_ListaEstoques.Dblcb_Estoque.Enabled := True;
        Dblcb_Tabelas.Enabled := true;
        E_CodPro.Enabled := False;
        E_Descricao.Enabled := False;
        E_Qt_Produto.Enabled := True;
        E_Aq_IPI.Enabled := True;
        SB_Gravar.Enabled := True;
        Sb_Pesquisar.Enabled := True;
        pnl_botao_lista.Visible := False;
        DBG_Produtos.Visible := False;
        Height := 286;
      end;
   end;
end;




procedure TFr_Itens_Produto.Pc_InsereServicoRelacionado(Pc_Codpro: Integer);
var
   Lc_Oper_Reg: string;
Begin
  Screen.Cursor := crHourGlass;
  Qr_Servico.Active := False;
  Qr_Servico.ParamByName('PRO_CODIGO').AsInteger := Pc_Codpro;
  Qr_Servico.Active := True;
  Qr_Servico.FetchAll;
  Qr_Servico.RecordCount;
  Qr_Servico.First;
  while not Qr_Servico.Eof do
  Begin
    Fc_AtualizaItensNfl(DM.IB_Transacao,
                       'I',
                       0,
                       ItensNFL.Registro.CodigoPedido,
                       0,
                       Qr_Servico.FieldByname('PSI_CODSRV').AsInteger,
                       1,
                       Qr_Servico.FieldByname('PRC_VL_VDA').AsCurrency,
                       Qr_Servico.FieldByname('PRC_VL_VDA').AsCurrency,
                       StrToFloatDef(E_Aq_Desconto.Text,0),
                       StrToFloatDef(E_VL_Desconto.Text,0),
                       Qr_Servico.FieldByname('PRC_AQ_COM').AsFloat,
                       'V',
                       'S',
                       'N',
                       0,
                       0,
                       0,
                       0,
                       '',
                       0,
                       StrtoFloatDef(e_Largura.Text,0),
                       StrtoFloatDef(e_Altura.Text,0));
    Qr_Servico.Next;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Itens_Produto.Pc_InserecomposicaoVenda(Pc_Cd_Produto:Integer);
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  Lc_Vl_Unitario:real;
  Lc_Estoque : String;
  Lc_Cd_Item : Integer;
  LcBase : TControllerBase;
begin
  Try
    if Chbx_Estoque.Checked then Lc_Estoque := 'S' else Lc_Estoque := 'N';
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT '+
                    '   PRO_CODIGOFAB, '+
                    '   PRO_DESCRICAO, '+
                    '   PPD_QTDE, '+
                    '   PPD_CODPRO_D '+
                    'FROM TB_PRODUTO tb_produto '+
                    '   INNER JOIN TB_PROD_PROD tb_prod_prod '+
                    '   ON (tb_prod_prod.PPD_CODPRO_D = tb_produto.PRO_CODIGO) '+
                    'WHERE PPD_CODPRO_M=:PRO_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        First;
        while not Eof do
        Begin
          PC_Busca_Preco_Qtde(Dblcb_Tabelas.KeyValue,FieldByname('PPD_CODPRO_D').AsInteger);
          Lc_Vl_Unitario := Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency;
          Lc_Cd_Item := Fc_AtualizaItensNfl(DM.IB_Transacao,
                                            'I',
                                             0,
                                             ItensNFL.Registro.CodigoPedido,
                                              0,
                                              FieldByname('PPD_CODPRO_D').AsInteger,
                                              Lc_Qry.FieldByname('PPD_QTDE').AsFloat * (StrToFloatDef(E_Qt_Produto.Text,0)),
                                              0,
                                              Lc_Vl_Unitario,
                                              StrToFloatDef(E_Aq_Desconto.Text, 0),
                                              (Lc_Vl_Unitario * (StrToFloatDef(E_Aq_Desconto.Text, 0) / 100)),
                                              Fc_Aliquota_Comissao(It_Cd_Vendedor, Dblcb_Tabelas.KeyValue,It_Cd_Produto),
                                              'V',
                                              Lc_estoque,
                                              'S',
                                              0,
                                              0,
                                              Fm_ListaEstoques.Dblcb_Estoque.KeyValue,
                                              Dblcb_Tabelas.KeyValue,
                                              '',
                                              0,
                                             StrtoFloatDef(e_Largura.Text,0),
                                             StrtoFloatDef(e_Altura.Text,0));
          Pc_InsereServicoRelacionado(FieldByname('PPD_CODPRO_D').AsInteger);
          //Baixa simples produto a produto

          with CtrlEstoque.Registro do
          Begin
            Codigo      := 0;
            Vinculo     := 'P';
            Terminal    := Self.Terminal;
            Ordem       := ItensNFL.Registro.CodigoPedido;
            Item        := Lc_Cd_Item;
            Estoque     := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
            operacao    := 'S';
            Produto     := FieldByname('PPD_CODPRO_D').AsInteger;
            Quantidade  := StrToFloatDef(E_Qt_Produto.Text,0);
            Data        := It_Dt_Operacao;
            Tipo        := 'Venda';
            UpdateAt    := Now;
          End;
          CtrlEstoque.Registra;
          if (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') then
          Begin
            Pc_SeparacaoMercadoria(ItensNFL.Registro.CodigoPedido,
                                   Lc_Cd_Item,
                                   FieldByname('PPD_CODPRO_D').AsInteger,
                                   It_Dt_Operacao,
                                   StrToFloatdef(E_Qt_Produto.Text,1));
          end;
          //Atualiza estoque na internet
          if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
          Begin
            Case Gb_Cd_Wsr of
              2:Pc_Ws_Estoque('I',Fc_BuscaCodigoEstoqueProduto(Fm_ListaEstoques.Dblcb_Estoque.KeyValue,FieldByname('PPD_CODPRO_D').AsInteger));
            End;
          End;
          Next;
        end;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Itens_Produto.Pc_InserecomposicaoCotacao(Pc_Cd_Produto:Integer);
var
  Lc_SqlTxt: string;
  Lc_Vl_Unitario:real;
  Lc_Estoque : String;
  Lc_Cd_Item : Integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT '+
                    '   PRO_CODIGOFAB, '+
                    '   PRO_DESCRICAO, '+
                    '   PPD_QTDE, '+
                    '   PPD_CODPRO_D '+
                    'FROM TB_PRODUTO tb_produto '+
                    '   INNER JOIN TB_PROD_PROD tb_prod_prod '+
                    '   ON (tb_prod_prod.PPD_CODPRO_D = tb_produto.PRO_CODIGO) '+
                    'WHERE PPD_CODPRO_M=:PRO_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        First;
        while not Eof do
        Begin
          PC_Busca_Preco_Qtde(Dblcb_Tabelas.KeyValue,FieldByname('PPD_CODPRO_D').AsInteger);
          Lc_Vl_Unitario := Qr_Preco_Qtde.FieldByName('PRC_VL_VDA').AsCurrency;
          Fc_AtualizaItensCotacao(IntToStr( ItensCTC.Registro.Codigo ),
                                  IntToStr(ItensCTC.Registro.Cotacao),
                                  'P',
                                   FieldByname('PPD_CODPRO_D').AsString,
                                   FieldByname('PRO_DESCRICAO').AsString,
                                   FloatToStr(Lc_Qry.FieldByname('PPD_QTDE').AsFloat * (StrtoFloatDef(E_Qt_Produto.Text,1))),
                                   FieldByname('PRC_VL_VDA').AsString,
                                   'P',
                                   '0',
                                   E_VL_Desconto.Text,
                                   E_Aq_Desconto.Text,
                                   E_Aq_IPI.Text,
                                   E_Aq_Icms.Text,
                                   Fm_ListaEstoques.Dblcb_Estoque.KeyValue,
                                   Dblcb_Tabelas.KeyValue,
                                   Qr_Servico.FieldByname('PRO_VL_CUSTO').AsString,
                                   '',   //FC_MR_LUCRO,
                                   '',   //FC_ALIQ_CT_FINANCEIRO,
                                   '',   //FC_PRZ_PRATICADO,
                                   '',   //FC_VL_PRATICADO,
                                   '',   //FC_AQ_VENDEDOR,
                                   '',   //FC_TECIDO,
                                   '',   //FC_COR,
                                   IntToStr( ItensNFL.Registro.CodigoPedido ));
          Pc_InsereServicoRelacionado(FieldByname('PPD_CODPRO_D').AsInteger);
          Next;
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Itens_Produto.SB_GravarClick(Sender: TObject);
Begin
  if validaGravacao then
  Begin
    if grava then
    Begin
      verificatributacao;
      verificaBaseTroca;
      if (It_StateChange = 2) then
      Begin
        InsertItemns;
        SomaItems;
      End;
      if (It_StateChange = 3) then
      Begin
        Self.Close;
      End
      else
      Begin
        Pc_LimpaCampos;
        Pc_InserirNovoItem;
      End;
    End;
  end;
end;


procedure TFr_Itens_Produto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Cliente);
  FreeAndNil(CtrlEstoque);
  FreeAndNil(ItensNFL);
  FreeAndNil(ItensCTC);
end;

procedure TFr_Itens_Produto.FormCreate(Sender: TObject);
begin
  Cliente := TControllerCliente.create(Self);
  CtrlEstoque := TControllerCtrlEstoque.create(Self);
  ItensNFL := TControllerItensNFL.create(Self);
  ItensCTC := TControllerItensCotacao.create(Self);
end;

procedure TFr_Itens_Produto.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
Begin

  if shift = [] then
  Begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_F7: if SB_Pesquisar.Enabled then
                Begin
                it_bt_pesquisa:=true;
                if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
                Pc_MostraBusca;
                end;
      VK_F8: if Sb_Limpar.Enabled then  Sb_LimparClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Itens_Produto.FormKeyPress(Sender: TObject; var Key: Char);
Begin
   if (Key = #13) and not (ActiveControl is TDBMemo) then
   Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Itens_Produto.Sb_PesquisarClick(Sender: TObject);
Begin
  it_bt_pesquisa:=true;
  Pc_MostraBusca;
  fm_ListaTributacao.Listar;
end;

procedure TFr_Itens_Produto.Sb_Sair_0Click(Sender: TObject);
Begin
  Pc_LimpaCampos;
  close;
end;

procedure TFr_Itens_Produto.Pc_FormataTela;
Begin
  Pg_Main.ActivePage := tbs_item;
  if (Fc_Tb_Geral('L','PED_G_EST_AUTO','S') = 'S') then
  Begin
    if (ItensNFL.Registro.Estoque <> 'N') then
    Begin
      Chbx_Estoque.Checked :=true;
      Chbx_Estoque.Enabled:=false;
    end
    else
    Begin
      Chbx_Estoque.Checked :=False;
      Chbx_Estoque.Enabled:=true;
    end
  end
  else
  Begin
    if (StrToIntDef(Fc_Tb_Geral('L','PED_G_BAIXA_ESTOQUE','1'),1) = 2) then
      Begin
      Chbx_Estoque.Checked:=false;
      Chbx_Estoque.Enabled:=false;
      end
    else
      Begin
      if (ItensNFL.Registro.Estoque = 'S') OR (It_StateChange = 2) then
        Chbx_Estoque.Checked:=true
      else
        Chbx_Estoque.Checked:=false;
      Chbx_Estoque.Enabled:=true;
      end;
  end;
  //Sb_Corte.Visible := E_ALTURA.Visible;
  E_Vl_Unitario.ReadOnly := False;

  //mostrar campos para calculo de metro quadrado
  Lb_Nr_Pecas.Visible := ( Fc_Tb_Geral('L','PRO_G_PRO_ITEMPEDME2','S') = 'S');
  E_Nr_Peca.Visible := Lb_Nr_Pecas.Visible;
  Lb_Largura.Visible := Lb_Nr_Pecas.Visible;
  Lb_Largura.Visible := Lb_Nr_Pecas.Visible;
  E_Largura.Visible := Lb_Nr_Pecas.Visible;
  Lb_Altura.Visible := Lb_Nr_Pecas.Visible;
  E_Altura.Visible := Lb_Nr_Pecas.Visible;

  if E_CodPro.CanFocus then E_CodPro.SetFocus;
end;

procedure TFr_Itens_Produto.Pc_IniciaVariaveis;
var
  Lc_Cd_Tabela : Integer;
Begin
  if (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','C') = 'C') then
    CampoCusto := 'PRO_VL_CUSTO'
  else
    CampoCusto := 'PRO_VL_CUSTOMED';
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  case It_StateChange of
    2:Begin //Inserindo
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue:= Gb_Estoque;
        if E_CodPro.CanFocus then E_CodPro.SetFocus;
      end;
    3:Begin //Alterando
        if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
      end;
   end;

  It_Pes_cod_barra:= Fc_Tb_Geral('L','GRL_G_PES_COD_BARRA','');
  Pc_MostraSaldo;
  Pc_DefineCasaDecimalLocal;
  it_bt_pesquisa:=FALSE;
  Lc_Cd_Tabela := 0;
  Pc_Tabelas_Disponiveis( Lc_Cd_Tabela);
end;


procedure TFr_Itens_Produto.Pc_InserirNovoItem;
var
  Lc_Cd_Tabela : Integer;
Begin
  Qr_Pesquisa.Close;
  Lc_Cd_Tabela := 0;
  FC_DefineTabela(Lc_Cd_Tabela);
  Pc_StateChange(2);
  if E_CodPro.CanFocus then E_CodPro.SetFocus;
  E_CodPro.SelectAll;
end;

procedure TFr_Itens_Produto.Pc_DefineCasaDecimalLocal;
Begin
  It_Casa_Decimal := '0.00####'
end;

procedure TFr_Itens_Produto.E_Vl_UnitarioExit(Sender: TObject);
Begin
  E_Vl_Unitario.Text := FormatFloat(It_Casa_Decimal, StrToFloatDef(E_Vl_Unitario.Text, 0));
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto.E_Qt_ProdutoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  Lc_Valor := StrToFloatDef(E_Qt_Produto.Text, 0);
  if (Lc_Valor >= 100000) then Lc_Valor := 1;
  E_Qt_Produto.Text := FloatToStr(Lc_Valor);
  Pc_Totalizador;
end;

procedure TFr_Itens_Produto.E_Aq_IPIExit(Sender: TObject);
Begin
  if It_StateChange > 1 then
  Begin
    It_Aq_IPI := StrToFloatDef(E_Aq_IPI.Text, 0);
    E_Aq_IPI.Text := FloatToStrF(It_Aq_IPI, ffFixed, 10, 2);
    Pc_Totalizador;
  end;
end;

procedure TFr_Itens_Produto.E_CodProExit(Sender: TObject);
Begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if It_StateChange = 1 then  exit;

    if (E_CodPro.Text = '') THEN
    Begin
      if E_Descricao.CanFocus then E_Descricao.SetFocus;
      exit;
    end;

    if (IntToStr(It_Cd_Produto) <> E_CodPro.Text) then  E_Vl_Unitario.Text := '0,00';

    if (E_CodPro.Text <> '') then
      E_Descricao.Text:=''
    else
      if (IntToStr( It_Cd_Produto ) <> E_CodPro.Text) then  E_Vl_Unitario.Text := '0,00';

    if (E_CodPro.Text <> '') then
      E_Descricao.Text:='';

    if It_StateChange = 3 THEN
      pc_Tip_Busca('P', Dblcb_Tabelas.KeyValue, E_CodPro.text,'')
    else
      pc_Tip_Busca('B', Dblcb_Tabelas.KeyValue,E_CodPro.text,'');
    Pc_MostraSaldo;
  end;
end;

Procedure TFr_Itens_Produto.Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Tabela :Integer; Pc_cd_Prod:String; Pc_Desc_prod:String);
Var
   Lc_Nr_Itens : Integer;
   Lc_Cd_Tabela : Integer;
   Lc_Aliq_Comissao : Real;
Begin
  if (Pc_cd_Prod = '') and (Pc_Desc_prod = '') then exit;
  Lc_Nr_Itens:= Fc_Busca_Cod_barra(Pc_cd_Prod);
  if Lc_Nr_Itens > 1 then // houve duplicidade de codigo de barra
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Encontrado duplicidade de código de barra.' + EOLN +
                   'Verifique o cadastro e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
  end;
  if Lc_Nr_Itens = 0 then  Lc_Nr_Itens := FC_Buscar(Pc_Tipo, Pc_cd_Tabela,Pc_cd_Prod,Pc_Desc_prod);  // nao encontrou codigo de baarra pesquisa normal
  case Lc_Nr_Itens of
    0:Begin
        It_Inserir := False;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Produto não encontrado ou inativo.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        Pc_LimpaCampos;
        if E_CodPro.CanFocus then E_CodPro.SetFocus;
        exit;
      end;
    1:Begin
        //vERifICA SE O PRODUTO ESTA ATIVO
        if Qr_Pesquisa.FieldByName('PRO_ATIVO').AsString <> 'S' then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este produto não está inativo.'+EOLN+
                         'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          Screen.Cursor := crDefault;
          E_CodPro.Clear;
          exit;
        end;
        DefineValoresEspecificos(Pc_cd_Tabela);
        Pc_PreencheTela(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,
                        Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString,
                        ItensNFL.Registro.ValorUnitario,
                        Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency,
                        Qr_Pesquisa.FieldByName('MED_ABREVIATURA').AsString,
                        ItensNFL.Registro.AliqComissao,
                        ItensNFL.Registro.Quantidade,
                        StrToIntDef(Qr_Pesquisa.FieldByName('PRO_COMPOSICAO').AsString,1),
                        Qr_Pesquisa.FieldByName('PRO_SUB_TRIB').AsString,
                        Qr_Pesquisa.FieldByName('PRO_VL_BASE_TROCA').AsCurrency);
        Pc_Totalizador;
        It_Inserir:=True;
      end;
    else
      Pc_MostraBusca;
  end;
   Screen.Cursor := crDefault;
end;

procedure TFr_Itens_Produto.E_DescricaoExit(Sender: TObject);
Begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
  Begin
    if It_StateChange = 1 then
      exit;
    if (E_Descricao.Text = '') THEN
    Begin
      //Fez mais sentido dar foco no codigo...caso a descrição esteja vazia....não adianta colocar preço sem codigo ou descrição
      if Fm_ListaEstoques.Dblcb_Estoque.CanFocus then
        Fm_ListaEstoques.Dblcb_Estoque.SetFocus
      else
        if Dblcb_Tabelas.CanFocus then Dblcb_Tabelas.SetFocus;
      exit;
    end;
    Pc_Tip_Busca('B', Dblcb_Tabelas.KeyValue,'',Copy(E_Descricao.Text,1,50));
    Pc_MostraSaldo;
  end;
end;

procedure TFr_Itens_Produto.e_LarguraExit(Sender: TObject);
begin
  Pc_CalculoMetroQuadrado;
end;

procedure TFr_Itens_Produto.E_Vl_UnitarioEnter(Sender: TObject);
Begin
  E_Vl_Unitario.SelectAll;


end;

procedure TFr_Itens_Produto.E_Qt_ProdutoEnter(Sender: TObject);
Begin
  E_Qt_Produto.SelectAll;
end;

procedure TFr_Itens_Produto.E_AlturaExit(Sender: TObject);
begin
  Pc_CalculoMetroQuadrado;
end;

procedure TFr_Itens_Produto.E_Aq_ComEnter(Sender: TObject);
Begin
   E_Aq_Com.SelectAll;
end;

procedure TFr_Itens_Produto.E_CodProEnter(Sender: TObject);
Begin
  it_bt_pesquisa:=FALSE;
  E_CodPro.SelectAll;
end;

procedure TFr_Itens_Produto.E_DescricaoEnter(Sender: TObject);
Begin
 it_bt_pesquisa:=FALSE;
 E_CodPro.Text:='';
end;

procedure TFr_Itens_Produto.E_Aq_DescontoExit(Sender: TObject);
Var
  Lc_Aq_Desconto:Real;
  Lc_Vl_Produto : Real;
  Lc_Vl_Desconto : Real;
begin
  Lc_Vl_Produto := StrtoFloatDef(E_Vl_Unitario.Text,0) * StrtoFloatDef(E_Qt_Produto.Text,0);
  Lc_Aq_Desconto := StrToFloatDef(E_Aq_Desconto.Text,0);
  Lc_Vl_Desconto := Lc_Vl_Produto * (Lc_Aq_Desconto/100);
  E_VL_Desconto.Text := FloatToStrf(Lc_Vl_Desconto,ffFixed,10,2);
  if (Lc_Aq_Desconto < 0) then Lc_Aq_Desconto := 0;
  E_Aq_Desconto.Text := FloatToStrf(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Itens_Produto.E_VL_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Produto : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Produto := StrtoFloatDef(E_VL_Produto.Caption,0);
  Lc_VL_Desconto := StrtoFloatDef(E_VL_Desconto.Text,0);
  Lc_Aq_Desconto := (Lc_VL_Desconto / Lc_Vl_Produto) * 100;
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  if (Lc_Aq_Desconto < 0) then Lc_Aq_Desconto := 0;
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Itens_Produto.Qr_TabelaAfterOpen(DataSet: TDataSet);
Begin
  Qr_Tabela.FetchAll
end;

procedure TFr_Itens_Produto.Action1Execute(Sender: TObject);
begin
  if ( Gb_Nivel = 1 ) then
  Begin
    E_CustoUnitario.Visible := (not E_CustoUnitario.Visible);
    Lb_CustoUnitario.Visible := (not Lb_CustoUnitario.Visible);
    if E_CustoUnitario.Visible then
    Begin
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      now,
                      Self.Caption,
                      ItensNFL.Registro.Codigo,
                     'Visualização do Campo Custo',
                     E_Descricao.Text);

    End;
  End;
end;

procedure TFr_Itens_Produto.Action2Execute(Sender: TObject);
Var
  Lc_Form:TFr_Liberacao;
begin
  Try
    Lc_Form := TFr_Liberacao.Create(nil);
    Lc_Form.Liberado := False;
    Lc_Form.It_Interface := 'Fr_Pedido_Vda';
    Lc_Form.It_Nome_Menu := 'Pedido de Venda';
    Lc_Form.It_Privilegio := 'AUTORIZAR';
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Itens_Produto.DBG_ProdutosCellClick(Column: TColumn);
begin
  it_bt_pesquisa:=TRUE;
  if DBG_Produtos.CanFocus then DBG_Produtos.SetFocus;
end;

procedure TFr_Itens_Produto.DBG_ProdutosTitleClick(Column: TColumn);
var
  vIndice: string;
  vExiste: boolean;
begin
  if cds_items.Active then
  BEgin
    if cds_items.IndexFieldNames = Column.FieldName then
    begin
      vIndice := AnsiUpperCase(Column.FieldName);

      try
        cds_items.IndexDefs.Find(vIndice);
        vExiste := True;
      except
        vExiste := False;
      end;

      if not (vExiste) then
      begin
        with cds_items.IndexDefs.AddIndexDef do
        begin
          Name := vIndice;
          Fields := Column.FieldName;
          Options := [ixDescending];
        end;
      end;

      cds_items.IndexName := vIndice;
    end
    else
      cds_items.IndexFieldNames := Column.FieldName;
  End;
end;

procedure TFr_Itens_Produto.Dblcb_TabelasClick(Sender: TObject);
Begin
  if E_CodPro.Text <> '' then
  Begin
    pc_Tip_Busca('P', Dblcb_Tabelas.KeyValue, E_CodPro.text,'')
  End
  else
  Begin
    E_Descricao.Clear;
    E_Vl_Unitario.Text := '0,00';
  End;
end;

procedure TFr_Itens_Produto.DefineValoresEspecificos(Pc_Cd_Tabela : Integer);
begin
  ItensNFL.Registro.Quantidade := StrToFloatDef(E_Qt_Produto.Text,1);
  ItensNFL.Registro.CodigoTabela := FC_DefineTabela(Pc_cd_Tabela);
end;

procedure TFr_Itens_Produto.DeleteItems;
begin
  if StrToIntDef( cds_itemsITF_CODIGO.AsString,0) >0 then
  Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir o item '+E_Descricao.Text +' desta venda.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      ItensNFL.clear;
      ItensNFL.Registro.Codigo := cds_itemsITF_CODIGO.AsInteger;
      ItensNFL.delete;
      cds_items.Delete;
      SomaItems;
    End;
  End;

end;

procedure TFr_Itens_Produto.editItems(CodigoItem: Integer);
begin
  ItensNFL.Registro.Codigo := CodigoItem;
  ItensNFL.getById;
  It_Cd_Produto := ItensNFL.Registro.CodigoProduto;
  ItensNFL.Produto.Registro.Codigo := It_Cd_Produto;
  ItensNFL.Produto.getbyId;
  ItensNFL.Produto.Medida.Registro.Codigo := ItensNFL.Produto.Registro.MedidaComercial;

  E_CodPro.Text           := It_Cd_Produto.ToString();
  E_Descricao.Text        := ItensNFL.Produto.getDescricao;
  E_Vl_Unitario.Text      := FormatFloat(Gb_Casa_Dec_Venda , ItensNFL.Registro.ValorUnitario);
  E_Qt_Produto.Text       := FloatToStr(ItensNFL.Registro.Quantidade);
  ItensNFL.Produto.Medida.getbyId;
  E_Unidade.Text          := ItensNFL.Produto.Medida.Registro.Descricao;
  E_Aq_Com.Text           := FloatToStrF( ItensNFL.Registro.AliqComissao ,ffFixed,10,2);
  E_Aq_Desconto.Text      := FloatToStrF( ItensNFL.Registro.AliqDesconto ,ffFixed,10,2);
  E_VL_Desconto.Text      := FloatToStrF( ItensNFL.Registro.ValorDesconto ,ffFixed,10,2);
  E_CustoUnitario.Text    := FloatToStrF( ItensNFL.Registro.ValorCusto ,ffFixed,10,2);
  It_Aq_IPI               := ItensNFL.Registro.AliqIPI;
  E_Aq_IPI.Text           := FloatToStrF( ItensNFL.Registro.AliqIPI ,ffFixed,10,2);
  E_Aq_Icms.Text          := FloatToStrF(ItensNFL.Registro.AliqICMS , ffFixed, 10, 2);
  It_Aq_icms              := ItensNFL.Registro.AliqICMS;

  E_Largura.Text          := FloatToStrF(ItensNFL.Registro.Largura,ffFixed,10,0);
  E_Altura.Text           := FloatToStrF(ItensNFL.Registro.Altura,ffFixed,10,0);
  E_Nr_Peca.Text          := FloatToStrF( ItensNFL.Registro.NumeroPecas ,ffFixed,10,0);

  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue := ItensNFL.Registro.CodigoEstoque;
  Qr_Tabela.Active        := True;
  Dblcb_Tabelas.KeyValue  := ItensNFL.Registro.CodigoTabela;

  Chbx_Estoque.Checked  := (ItensNFL.Registro.Estoque ='S');
  //Tributacao
  ItensNFL.Tributacao.Registro.ItemOrdem := ItensNFL.Registro.Codigo;
  ItensNFL.Tributacao.getByKey;
  if ( ItensNFL.Tributacao.exist ) then
  Begin
    fm_ListaTributacao.Dblcb_Lista.KeyValue := ItensNFL.Tributacao.Registro.Tributacao;
    chbx_do_not_set_financeiro.Checked      := (ItensNFL.Tributacao.Registro.GeraFinanceiro = 'N');
  End;
end;

procedure TFr_Itens_Produto.E_CustoUnitarioExit(Sender: TObject);
var
   Lc_Valor: Real;
Begin
  Lc_Valor := StrToFloatDef(E_CustoUnitario.Text, 0);
  E_CustoUnitario.Text := FormatFloat(It_Casa_Decimal, StrToFloatDef(E_CustoUnitario.Text, 0));
  if Lc_Valor <= 0 then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O Valor Informado não é valido.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_CustoUnitario.CanFocus then E_CustoUnitario.SetFocus;
  end
  else
  Begin
    Pc_Totalizador;
  end;
end;

function TFr_Itens_Produto.Fc_Aliquota_comissao(fc_cd_vendedor,fc_Cd_TabelaPreco,Fc_Cd_Produto: Integer): Double;
var
  Lc_Aq_Com : Real;
  Lc_Tp_Com : String;
  lc_txt:String;
  RecebePorProduto : Boolean;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      lc_txt:= ' select CLB_AQ_COM_VDA, CLB_AQ_COM_SRV,  CLB_COM_VDA, CLB_COM_SRV,CLB_CALC_COM_VDA, CLB_CALC_COM_SRV '+
               ' from tb_colaborador '+
               'where  clb_codigo =:CLB_CODIGO ';
      SQL.Add(lc_txt);
      ParamByName('CLB_CODIGO').asinteger:= fc_cd_vendedor;
      Active:=True;
      //Pega a aliquota do cadastro do vendedor
      Lc_Aq_Com := FieldByname('CLB_AQ_COM_VDA').asFloat;
      //Verifica se ele recebera por produto
      RecebePorProduto := ( FieldByname('CLB_COM_VDA').asString = 'S');

      if RecebePorProduto then
      Begin
        Active := false;
        SQL.Clear;
        lc_txt:='';
        lc_txt:= ' select prc_aq_com, tb_produto.pro_tipo from tb_preco '+
                 ' inner join TB_PRODUTO TB_PRODUTO on (TB_PRODUTO.PRO_CODIGO = TB_PRECO.PRC_CODPRO) '+
                 ' where '+
                 ' PRC_CODPRO = :PRC_CODPRO '+
                 ' AND PRC_CODTPR =:PRC_CODTPR ';
        SQL.Add(lc_txt);
        ParamByName('PRC_CODPRO').AsInteger:=Fc_Cd_Produto;
        ParamByName('PRC_CODTPR').AsInteger:=fc_Cd_TabelaPreco;
        Active:=True;
        Lc_Aq_Com := Lc_Aq_Com + FieldByName('prc_aq_com').asfloat;
        Lc_Tp_Com := FieldByName('pro_tipo').AsString;
      End;
    End;
    Result:= Lc_Aq_Com;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Itens_Produto.Sb_LimparClick(Sender: TObject);
Begin
  Pc_LimpaCampos;
  if E_CodPro.CanFocus then E_CodPro.SetFocus;
end;


procedure TFr_Itens_Produto.E_UnidadeEnter(Sender: TObject);
Begin
 E_Unidade.SelectAll;
end;

procedure TFr_Itens_Produto.E_Aq_DescontoEnter(Sender: TObject);
Begin
 E_Aq_Desconto.SelectAll;
end;

procedure TFr_Itens_Produto.E_VL_DescontoEnter(Sender: TObject);
Begin
 E_VL_Desconto.SelectAll;
end;

procedure TFr_Itens_Produto.E_Aq_IPIEnter(Sender: TObject);
Begin
 E_Aq_IPI.SelectAll;
end;

procedure TFr_Itens_Produto.E_Aq_IcmsEnter(Sender: TObject);
Begin
 E_Aq_Icms.SelectAll;
end;



procedure TFr_Itens_Produto.Sb_PesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
Begin
  it_bt_pesquisa:=TRUE;
  if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
end;

function TFr_Itens_Produto.Fc_Busca_Cod_barra(Pc_cod_barra:String): integer;
var
   Lc_SqlTxt: string;
Begin
  Result:=0;// ja comeco como falso so fica verdadeiro se encontra codigo de barra
  if It_Pes_cod_barra <> 'S' then exit;
  Lc_SqlTxt:='';
  Qr_Pesquisa.Active:=FALSE;
  Qr_Pesquisa.SQL.Clear;

  Lc_SqlTxt :=  'SELECT  '+
                '  PRO_CODIGO,'+
                '  PRO_CODIGOFAB, '+
                '  PRO_CODIGOFOR, '+
                '  PRO_CODIGOBAR, '+
                '  PRO_DESCRICAO, '+
                '  PRO_VL_CUSTOMED PRO_VL_CUSTO , '+ //usar o custo medio pois a lucratividade melhor apurada desta forma
                '  MED_ABREVIATURA, '+
                '  PRO_CAMPANHA, '+
                '  PRO_COMPOSICAO, '+
                '  PRO_ATIVO, '+
                '  PRO_SUB_TRIB, '+
                '  CAST((COALESCE(PRO_VL_BASE_TROCA, 0) * COALESCE(PRO_PESO, 0)) AS NUMERIC(18, 2)) PRO_VL_BASE_TROCA '+
                'FROM TB_PRODUTO tb_produto '+
                '   INNER JOIN TB_MEDIDA MED '+
                '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                ' WHERE (PRO_CODIGO IS NOT NULL) '+
                ' AND (PRO_CODIGOBAR =:PRO_CODIGOBAR) ';
  if not GB_ProdCompartilha  then   Lc_SqlTxt:=Lc_SqlTxt+ 'AND PRO_CODMHA = :PRO_CODMHA';
  Qr_Pesquisa.SQL.Add(Lc_SqlTxt);

  Qr_Pesquisa.ParamByName('PRO_CODIGOBAR').AsString := Copy(Pc_cod_barra,1,20);
  if not GB_ProdCompartilha then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result:=Qr_Pesquisa.RecordCount;
  if Result = 1 THEN
    It_Cd_Produto := Qr_Pesquisa.FIELDBYNAME('PRO_CODIGO').ASInteger;
end;

procedure TFr_Itens_Produto.Sb_CorteClick(Sender: TObject);
Var
  Lc_Form : TFr_Corte_Chapa;
begin
  Try
    Lc_Form := TFr_Corte_Chapa.Create(nil);
    Lc_Form.It_Confirma := False;
    Lc_Form.ShowModal;
    if Lc_Form.It_Confirma then
    Begin
      E_Qt_Produto.Text := Lc_Form.StrGrd_Informacao.Cells[2,3];
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Itens_Produto.Sb_Exc_ProdutoClick(Sender: TObject);
begin
  DeleteItems;
end;

procedure TFr_Itens_Produto.SB_GravarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
Begin
  it_bt_pesquisa:=TRUE;
  if SB_Gravar.CanFocus then SB_Gravar.SetFocus;
end;

procedure TFr_Itens_Produto.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;


function TFr_Itens_Produto.grava:Boolean;
begin

end;

procedure TFr_Itens_Produto.InsertItemns;
Var
  Lc_VL_IPI : Real;
begin
  if not cds_items.Active then cds_items.CreateDataSet;
  cds_items.Append;
  cds_items.FieldByName('itf_sequencia').AsInteger  := ItensNFL.Registro.Sequencia;
  cds_items.FieldByName('PRO_CODIGOFAB').AsString   :=   ItensNFL.Produto.getField(ItensNFL.Registro.CodigoProduto,'PRO_CODIGOFAB');
  cds_items.FieldByName('pro_descricao').AsString   := E_Descricao.Text;
  cds_items.FieldByName('med_abreviatura').AsString := E_Unidade.Text;
  cds_items.FieldByName('itf_qtde').AsFloat         := ItensNFL.Registro.Quantidade;
  cds_items.FieldByName('itf_vl_unit').AsCurrency      := ItensNFL.Registro.ValorUnitario;
  cds_items.FieldByName('ITF_VL_DESC').AsCurrency      := ItensNFL.Registro.ValorDesconto;
  cds_items.FieldByName('ITF_VL_SUBTOTAL').AsCurrency  := StrToFloatDef(E_VL_Produto.Caption,0);
  cds_items.FieldByName('ITF_VL_TOTAL').AsCurrency     := StrToFloatDef(E_Vl_SubTotal.Caption,0);
  cds_items.FieldByName('ITF_AQ_COM').AsFloat       := ItensNFL.Registro.AliqComissao;
  Lc_VL_IPI := ((ItensNFL.Registro.ValorUnitario * ItensNFL.Registro.Quantidade) -ItensNFL.Registro.ValorDesconto);
  Lc_VL_IPI := (Lc_VL_IPI * ItensNFL.Registro.AliqIPI)/100;
  cds_items.FieldByName('ITF_VL_IPI').AsCurrency       := Lc_VL_IPI;
  cds_items.FieldByName('tpr_nome').AsString        := Dblcb_Tabelas.Text;
  cds_items.Post;
end;

procedure TFr_Itens_Produto.LoadItems(Items: TSTQuery);
Var
  LcValor : Real;
begin
  if not cds_items.Active then cds_items.CreateDataSet;
  cds_items.EmptyDataSet;
  LcValor := 0;
  Items.First;
  while not Items.Eof do
  Begin
    cds_items.Append;
    cds_items.FieldByName('itf_CODIGO').AsInteger     := Items.FieldByName('ITF_CODIGO').AsInteger;
    cds_items.FieldByName('itf_sequencia').AsInteger  := Items.FieldByName('itf_sequencia').AsInteger;
    cds_items.FieldByName('pro_codigofab').AsString   := Items.FieldByName('pro_codigofab').AsString;
    cds_items.FieldByName('pro_descricao').AsString   := Items.FieldByName('pro_descricao').AsString;
    cds_items.FieldByName('med_abreviatura').AsString := Items.FieldByName('med_abreviatura').AsString;
    cds_items.FieldByName('itf_qtde').AsFloat         := Items.FieldByName('itf_qtde').AsFloat;
    cds_items.FieldByName('itf_vl_unit').AsCurrency      := Items.FieldByName('itf_vl_unit').AsCurrency;
    cds_items.FieldByName('ITF_VL_DESC').AsCurrency      := Items.FieldByName('ITF_VL_DESC').AsCurrency;
    cds_items.FieldByName('ITF_VL_SUBTOTAL').AsCurrency  := Items.FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
    cds_items.FieldByName('ITF_VL_TOTAL').AsCurrency     := Items.FieldByName('ITF_VL_TOTAL').AsCurrency;
    cds_items.FieldByName('ITF_AQ_COM').AsFloat       := Items.FieldByName('ITF_AQ_COM').AsFloat;
    cds_items.FieldByName('ITF_VL_IPI').AsCurrency       := Items.FieldByName('ITF_VL_IPI').AsCurrency;
    cds_items.FieldByName('tpr_nome').AsString        := Items.FieldByName('tpr_nome').AsString;
    cds_items.Post;
    LcValor := LcValor  + cds_items.FieldByName('ITF_VL_TOTAL').AsCurrency;
    Items.Next;
  End;
  E_VL_Pedido.Caption := FloatToStrF(LcValor,ffFixed,10,2);

end;

procedure TFr_Itens_Produto.Sb_Sair_0MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Sair_0.CanFocus then Sb_Sair_0.SetFocus;
end;

procedure TFr_Itens_Produto.SomaItems;
Var
  LcValor : Real;
begin
  LcValor := 0;
  cds_items.First;
  while not cds_items.Eof do
  Begin
    LcValor := LcValor  + cds_items.FieldByName('ITF_VL_TOTAL').AsCurrency;
    cds_items.Next;
  End;
  E_VL_Pedido.Caption := FloatToStrF(LcValor,ffFixed,10,2);
end;

function TFr_Itens_Produto.SqlEspecifico: String;
begin
  REsult := ' and (PRO_TIPO <> ''S'') ';
end;

procedure TFr_Itens_Produto.tbs_tributacaoShow(Sender: TObject);
begin
  PreencheLabelTributacao;
end;

function TFr_Itens_Produto.ValidacaoInicial: Boolean;
begin
  Result := True;

  IF (Trim(E_Descricao.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Descrição do Produto É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_CodPro.CanFocus then E_CodPro.SetFocus;
    Result := False;
    exit;
  end;

  IF (Trim(E_Vl_Unitario.Text) = '') or (StrToFloatDef(E_Vl_Unitario.Text,0) <= 0) then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Valor Unitário É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
    Result := False;
    exit;
  end;

  IF (Trim(E_Qt_Produto.Text) = '') or (StrToFloatDef(E_Qt_Produto.Text,0) <= 0)then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Quantidade É Obrigatório e maior do que zero.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
    Result := False;
    exit;
  end;

  IF not Fc_ValidaEscalaUnidadeProduto(It_Cd_Produto ,StrToFloatDef(E_Qt_Produto.Text,0)) then
  Begin
    Result := False;
    exit;
  end;
end;

function TFr_Itens_Produto.validaGravacao: Boolean;
begin
  REsult := True;

end;

function TFr_Itens_Produto.validaPreencheCodigo: Boolean;
begin
  REsult := True;
  IF ( (Trim(E_CodPro.Text) = '') or (Trim(E_CodPro.Text) = '0') ) then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Código do Produto É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if E_CodPro.CanFocus then E_CodPro.SetFocus;
    Result := False;
    exit;
  end;

end;

function TFr_Itens_Produto.validaPreencheEstoque: Boolean;
begin
  Result := True;
  IF (Trim(Fm_ListaEstoques.Dblcb_Estoque.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Estoque é Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if Fm_ListaEstoques.Dblcb_Estoque.CanFocus then Fm_ListaEstoques.Dblcb_Estoque.SetFocus;
    Result := False;
    exit;
  end;
end;

function TFr_Itens_Produto.validaPreenchePreco: Boolean;
begin
  Result := True;
  IF (Trim(Dblcb_Tabelas.Text) = '') then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Campo Tabela de Preço É Obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    if Dblcb_Tabelas.CanFocus then Dblcb_Tabelas.SetFocus;
    Result := False;
    exit;
  end;
end;

function TFr_Itens_Produto.validaQuantidadePromocao: Boolean;
begin
  REsult := true;
  if (Fc_Tb_Geral('L','VDA_G_PROMOCAO_QUANTIDADE','S') = 'S') then
  Begin
    if (StrToFloatDef(E_Qt_Produto.Text,0) < (Fc_Valida_Itens_QtdMIn(StrToInt64Def(E_CodPro.Text,0),Dblcb_Tabelas.KeyValue))) then
    Begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' A quantidade informada inferior do que Permitida.' +  EOLN,
                     ['OK'], [bEscape], mpErro);
      if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
      Result := False;
      exit;
    end;
  end;
end;

procedure TFr_Itens_Produto.verificaBaseTroca;
begin
end;

procedure TFr_Itens_Produto.verificatributacao;
begin
  ItensNFL.Tributacao.Registro.ItemOrdem  := ItensNFL.Registro.Codigo;
  if ( fm_ListaTributacao.Dblcb_Lista.Text <> '' ) then
  Begin
    ItensNFL.Tributacao.Registro.Tributacao     := fm_ListaTributacao.Dblcb_Lista.KeyValue;
    ItensNFL.Tributacao.Registro.CFOP           := fm_ListaTributacao.Qr_ListaNAT_CFOP.AsString;
    if ( chbx_do_not_set_financeiro.Checked) then
      ItensNFL.Tributacao.Registro.GeraFinanceiro := 'N'
    else
      ItensNFL.Tributacao.Registro.GeraFinanceiro := 'S';
    ItensNFL.Tributacao.save;
  End
  else
    ItensNFL.Tributacao.delete;
end;

end.

