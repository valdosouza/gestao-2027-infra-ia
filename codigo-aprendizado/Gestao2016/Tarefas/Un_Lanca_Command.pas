unit Un_Lanca_Command;

interface

uses
      Winapi.Windows, Messages, SysUtils, Classes, Variants, vcl.Graphics, vcl.Forms, Generics.Collections, Vcl.Controls, Data.DB, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, ACBrBase, Vcl.ActnList, System.Math, STQuery, Vcl.Imaging.jpeg, ControllerCommand, ControllerBase, Vcl.Menus, Actions, QEdit_Setes, ImageList, Vcl.ImgList, Un_Fm_ListaTabelaPreco, ACBrTEFD, ACBrTEFDClass, ACBrTEFDCliSiTef, ACBrPosPrinter, ControllerPedidoVDa, ControllerDskPromotion, ControllerCheckOutItems, ControllerEmpresa, itemVenda, Vcl.Dialogs, Generics.Defaults, DateUtils, TypInfo, GeneralPrint;

type

  TCustomGridAccess = class(TCustomGrid) end;

  TFr_Lanca_Command = class(TForm)
    Pnl_topo: TPanel;
    Timer1: TTimer;
    Img_Frente: TImage;
    Qr_PesqProduto: TSTQuery;
    Ac_Funcoes: TActionList;
    Ac_Gaveta: TAction;
    Mnu_Fiscal: TMainMenu;
    Pnl_Corpo: TPanel;
    Pnl_Corpo_Items: TPanel;
    Qr_Pedido: TSTQuery;
    E_M_Fisco: TMemo;
    popmenu: TPopupMenu;
    Cadastrodeproduto1: TMenuItem;
    Tarefas: TMenuItem;
    Sair2: TMenuItem;
    Liberacao: TAction;
    DadosNCM1: TMenuItem;
    Pnl_TabelaPreco: TPanel;
    Sb_Confirma_TabelaPreco: TButton;
    Sb_Cancela_TabelaPreco: TButton;
    Fm_ListaTabelaPreco: TFm_ListaTabelaPreco;
    OcultarBarradeTarefasWindows: TMenuItem;
    Grp_Totalizador: TPanel;
    Lb_Valor_Pedido: TLabel;
    StrGrd_Produtos: TStringGrid;
    Pnl_Lanca_Items: TPanel;
    Label31: TLabel;
    E_Qtde: TEdit_Setes;
    Label30: TLabel;
    E_BuscaCodigo: TEdit_Setes;
    Lb_Item_lancado: TLabel;
    Label14: TLabel;
    ImageList1: TImageList;
    E_Vl_Pedido: TPanel;
    MnuSalvarComanda: TMenuItem;
    MnuConsultarComanda: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    GoCodigoCliente: TAction;
    img_F10: TImage;
    pnl_F10: TPanel;
    Lb_F10: TLabel;
    Lb_Fechar: TLabel;
    pnl_F4: TPanel;
    img_F4: TImage;
    Lb_F4: TLabel;
    Lb_Salvar: TLabel;
    pnl_F6: TPanel;
    img_f6: TImage;
    Lb_F6: TLabel;
    Lb_Pesquisa: TLabel;
    Pnl_Cliente: TPanel;
    Label19: TLabel;
    E_Numero_Comanda: TEdit_Setes;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StrGrd_ProdutosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure StrGrd_ProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_BuscaCodigoEnter(Sender: TObject);
    procedure E_QtdeExit(Sender: TObject);
    procedure Cadastrodeproduto1Click(Sender: TObject);
    procedure E_BuscaCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure E_QtdeKeyPress(Sender: TObject; var Key: Char);
    procedure DadosNCM1Click(Sender: TObject);
    procedure E_Aq_DescontoKeyPress(Sender: TObject; var Key: Char);
    procedure E_Vl_DescontoKeyPress(Sender: TObject; var Key: Char);
    procedure GoCodigoClienteExecute(Sender: TObject);
    procedure E_QtdeEnter(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure E_Peso_LiquidoManualEnter(Sender: TObject);
    procedure E_Vl_UnitarioManualEnter(Sender: TObject);
    procedure E_VL_UnitarioEnter(Sender: TObject);
    procedure Sb_Cancela_TabelaPrecoClick(Sender: TObject);
    procedure Sb_Confirma_TabelaPrecoClick(Sender: TObject);
    procedure ControleElementos(Painel:Tpanel;Ativo:Boolean);
    procedure LiberacaoExecute(Sender: TObject);
    procedure OcultarBarradeTarefasWindowsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MnuSalvarComandaClick(Sender: TObject);
    procedure MnuConsultarComandaClick(Sender: TObject);
    procedure Lb_F6Click(Sender: TObject);
    procedure Lb_F10Click(Sender: TObject);
    procedure Lb_PesquisaClick(Sender: TObject);
    procedure E_Numero_ComandaKeyPress(Sender: TObject; var Key: Char);
    procedure E_Numero_ComandaEnter(Sender: TObject);
    procedure E_Numero_ComandaExit(Sender: TObject);
    procedure Lb_FecharClick(Sender: TObject);
    procedure img_f6Click(Sender: TObject);
    procedure Lb_F4Click(Sender: TObject);
    procedure Lb_SalvarClick(Sender: TObject);

  private
    { Private declarations }
    It_NFCe : Boolean;
    It_Ctrl_Estoque : Boolean;
    BalBarraCodigoProduto :Integer;
    BalBarraPrecoPeso : Integer;
    CodigoVendedor : Integer;
    fCancelado : Boolean ;
    It_Casa_Decimal : Integer;
    It_Cd_Cliente: Integer;
    It_Cd_Consumidor : Integer;
    procedure Pc_TeclaAtalhoF2();
    procedure Pc_TeclaAtalhoF3();
    procedure Pc_TeclaAtalhoF4();
    procedure Pc_TeclaAtalhoF5();
    procedure Pc_TeclaAtalhoF6();
    procedure Pc_TeclaAtalhoF7();
    procedure Pc_TeclaAtalhoF8();
    procedure Pc_TeclaAtalhoF9();
    procedure Pc_TeclaAtalhoF10();
    procedure Pc_TeclaAtalhoF11();
    procedure Pc_TeclaAtalhoF12();
    procedure Pc_TeclaAtalhoEscape();

    procedure AbrirTelaTabelaPreco;
    function ValidaTrocaTabela:Boolean;
    Procedure EscolheTabela;
    procedure TrocaTabela;
    //Controla as Promoções
   procedure DeletaItemDaGrade(Linha:Integer);
   procedure Pc_DefineCasaDecimal;
   Procedure OcultaBarraTarefas(Visivel: Boolean);
  protected
    //Controle de Promoção
    Promocao : TControllerDskPromotion;
    ListaPedidoItem : TListaItemVenda;
      Bitmap: TBitmap;
    procedure GuardaListaProdutos(ListaItem : TListaItemVenda;Promocao:String);
    Function EfetuaCopiaItem(ItemVenda : TItemVenda;Qtde:Real;TipoPreco:String):TItemVenda;
    procedure TratarRestoPromocao(QtdePromocao,QtdeTotal:Real;ListaItem : TListaItemVenda);

    procedure InitVariable;
    function validaNumeroComanda(pMsg:Boolean):Boolean;
    procedure Pc_Promocao(Promocao : String;QtdePromocao:Real;preco:Real);
    procedure OrdenarListaItems(Lista: TListaItemVenda);
    procedure EliminaItemDaGRid(Pc_strGrid: TStringGrid; Item: String);
  public
     { Public declarations }
    //Identificação do Cliente
    It_Cd_Endereco: Integer;


    It_Cd_FormaPagto : Integer;
    IT_Calc_automatico:string;
    //Controla o Tipo de Operação - PDV - CMD
    It_TP_Operacao: String;

    It_Usa_Balanca : boolean;
    It_Usa_ProdutoAvulso : Boolean;
    It_Cd_ProdutoAvulso : String;
    It_Usa_Cd_Fabrica : Boolean;
    //Impressão
    It_Usa_Imp_Checkout : Boolean;
    It_Tp_Impressao : Integer;
    It_Linha : Integer;
    It_Nr_Colunas : Integer;
    It_ColunaCentro : Integer;
    It_Traco : String;

    //Variaveis que controlam o Pedido

    Pedido: TControllerPedidoVda;
    It_NR_Pedido: Integer;
    It_Nr_Item: Integer;

    It_cd_Tabela: Integer;
    It_Vl_Produtos: Currency;
    It_Qt_Produtos: Real;

    //retorna como Faturamento ok
    procedure Pc_FormataTela;
    procedure Pc_MontaGrid;
    procedure Pc_FormataPanels;
    procedure Pc_PosicionaCliente;
    procedure Pc_IniciaVariaveis;
    procedure Pc_LimpaCampos;
    function Fc_ValidaPreencheProduto(Pc_Vl_Venda:Real):boolean;
    function FC_BuscarProduto(Pc_Codigo,Fc_Campo: string):Integer;
    procedure Pc_MostraBusca;
    procedure Pc_PreencheItensVenda(Pc_Cd_Produto:String;
                                    Pc_Cd_Fabrica:String;
                                    Pc_Descricao:String;
                                    Pc_Qtde:Real;
                                    Pc_Vl_Venda:Real;
                                    Pc_Abreviatura:String;
                                    Pc_VL_Custo:Real;
                                    Pc_NCM:String;
                                    Pc_Origem:String;
                                    Pc_Vl_Original:Real);

    procedure Pc_SomaProdutos;
    procedure Pc_Totalizador;

    procedure Pc_GeraPedido;
    procedure Pc_GeraItensPedido;




    Function Fc_validaExcluiCupom():Boolean;
    Function Fc_validaExcluiItemCupom():Boolean;
    procedure Pc_AbreTelaProdutoSemRegistro(Pc_Descricao,Pc_Unidade,Pc_VL_Unitario:String);
    procedure Pc_AbreTelaBalanca;
    procedure Pc_AbreTelaBalancaManual;
    procedure Pc_AbreTelaProdutoAvulso;
    function Fc_LancaItem:Boolean;
    procedure Pc_Imp_Abre_CupomNaoFiscal;
    procedure Pc_Imp_Item_CupomNaoFiscal;
    procedure Pc_Imp_Cancela_Item_CupomNaoFiscal(Pc_Item:Integer);
    Function Fc_StatusTecla (Key: integer): boolean;//função para desabilitar alt+f4
    procedure Pc_ImprimeItemCheckout;
    Function FC_Valida_ImpostoAproximado:boolean;

    procedure Pc_PreencheProdutoCodigoReduzido(Pc_Cd_Produto:String);
    procedure Pc_PreencheProdutoCodigoBarrasBalanca(Pc_Cd_Barras:String);
    procedure Pc_PreencheProdutoCodigoBarras(Pc_Cd_Barras:String);
    procedure ProdutoDifDeUm(Nr_Registro:Integer);

    //Função TEF
    procedure ImprimeComprovante(c:TStringList);
    Function ValidaItensNaLista:Boolean;
    //Comanda
    procedure SalvarCommand;
    procedure SalvaItemsComanda;
    procedure ConsultarCommand;
    function getPedidoByCommand(CommandID:String):Integer;
    function  CarregaItensCommand(PedidoID : Integer):Boolean;
    procedure limparTela;
  end;

var
  Fr_Lanca_Command: TFr_Lanca_Command;


implementation

uses     Un_DM, UN_Sistema, UN_MSG, Un_Funcoes, Un_CliResumo, Un_Fc_Sored_Procedures, StrUtils, Un_Pesq_Produto, Un_Cupom_Fiscal, Un_Regra_Negocio, Un_Produtos, Un_Nota_Fiscal, Un_Liberacao, Un_Imp_Mod_Impressao, RN_Permissao, RN_Estoque, RN_Financeiro, UN_NCM, RN_NotaFiscal, RN_FormaPagto, RN_Itens_Vda_Avulso, Un_Pesq_Empresa, RN_Crud, UN_TabelasEmListas, Un_Pesq_NF_Pro, RN_NotaFiscalConsumidor, RI_MovimentoFinanceiro, RN_NotaFiscalEletronica3X, Un_TEF_ObtemCampo, Un_TEF_ExibeMenu, BematechPrint, EpsonPrint, tblDskPromotion, tblCheckOutItems, Un_FrenteCaixaProdSemRegistro, Un_FrenteCaixaProdAvulso, Un_Principal, env, sea_promotion, un_imp_fechamento, Un_Command, sea_command, Un_FrenteCaixaPesoBalanca, Un_FrenteCaixaPesoManual;
{$R *.dfm}


{Frente de Caixa}

procedure DeleteGridRow(g: TCustomGrid; row: Integer);
begin
  TCustomGridAccess(g).DeleteRow(row);
end;



procedure TFr_Lanca_Command.Pc_DefineCasaDecimal;
Begin
  //Define casas decimais para as vendas
  case StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_VENDA','0'),0) of
    0:It_Casa_Decimal := 2;
    1:It_Casa_Decimal := 3;
    2:It_Casa_Decimal := 4;
    3:It_Casa_Decimal := 5;
    4:It_Casa_Decimal := 6;
  end;
end;



procedure TFr_Lanca_Command.Pc_GeraPedido;
begin
  with Pedido.registro do
  Begin
    Tipo:= 1;
    CodigoEstabelecimento := Gb_CodMha;
    Usuario:= Gb_Cd_Usuario;
    Data:= Gb_DataCaixa;
    Empresa:= It_Cd_Cliente;
    Vendedor:= Self.CodigoVendedor;
    FormaPagto:= It_Cd_FormaPagto;
    Prazo:= '000 - A VISTA';
    Endereco:= It_Cd_Endereco;
    QtdeProdutos:= It_Qt_Produtos;
    ValorProdutos:= StrToFloatDef(E_Vl_Pedido.Caption, 0);
    Faturado:= 'N';
    IndicaPresenca:= 1;
  end;
  Pedido.salva;
  //Define que cupom não precisa ter numero
  if (Pedido.registro.Numero = 0) then
    Pedido.nextNumber('T');

end;

procedure TFr_Lanca_Command.Pc_GeraItensPedido;
var
  I: Integer;
  Lc_Estoque : String;
  Lc_Cd_Item : Integer;
  ItemVenda : TItemVenda;
begin
  //Insere os itens de produto
  FreeAndNil(ListaPedidoItem);
  ListaPedidoItem := TListaItemVenda.create;
  for I := 1 to StrGrd_Produtos.RowCount - 1 do
  begin
    //Guarda os itens da Venda para o caso do usuario desistir do faturamento e
    // voltar para a tela de venda
    ItemVenda := TItemVenda.Create;
    ItemVenda.Produto       := StrToIntDef(   StrGrd_Produtos.Cells[2,  I],0);
    ItemVenda.Fabrica       :=                StrGrd_Produtos.Cells[3,  I];
    ItemVenda.Descricao     :=                StrGrd_Produtos.Cells[4,  I];
    ItemVenda.Quantidade    := StrToFloatDef( StrGrd_Produtos.Cells[5,  I],0);
    ItemVenda.ValorVenda    := StrToFloatDef( StrGrd_Produtos.Cells[6,  I],0);
    ItemVenda.Abreviatura   :=                StrGrd_Produtos.Cells[8,  I];
    ItemVenda.ValorCusto    := StrToFloatDef( StrGrd_Produtos.Cells[9,  I],0);
    ItemVenda.ItemPedido    :=   StrToIntDef( StrGrd_Produtos.Cells[10, I],0);
    ItemVenda.ncm           :=                StrGrd_Produtos.Cells[11, I];
    ItemVenda.Origem        :=                StrGrd_Produtos.Cells[12, I];
    ItemVenda.Promocao      :=                StrGrd_Produtos.Cells[13, I];
    ItemVenda.ValorOriginal := StrToFloatDef( StrGrd_Produtos.Cells[14, I],0);
    ItemVenda.QtdePromocao  := StrToFloatDef( StrGrd_Produtos.Cells[15, I],0);
    ItemVenda.PRecoPromocao := StrToFloatDef( StrGrd_Produtos.Cells[16, I],0);
    ListaPedidoItem.Add(ItemVenda);
  end;
end;

procedure TFr_Lanca_Command.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Try
    Lc_Form := TFr_Pesq_Produto.Create(Nil);
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    if (E_BuscaCodigo.Text <> '') then
      Lc_Form.E_BuscaCodigo.Text :=  E_BuscaCodigo.Text
    else
      Lc_Form.E_BuscaCodigo.Text := '';
    Lc_Form.ShowModal;
    //Depois que Fecha o Relatorio
    if Lc_Form.It_Visualizar then
    Begin
      IF (It_Usa_Cd_Fabrica)then
        E_BuscaCodigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGOFAB').AsString
      else
        E_BuscaCodigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      //if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus; - Comentado em 20/12/2016 - 23:55
      if Fc_LancaItem then
      Begin
        //totaliza os itens na tela
        Pc_SomaProdutos;
        Pc_Totalizador;
        Pc_ImprimeItemCheckout;
      End;
      //Limpa os campos
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  Finally
    FreeAndNil(Lc_Form) ;
  End;
end;

function TFr_Lanca_Command.Fc_ValidaPreencheProduto(Pc_Vl_Venda:Real):boolean;
Var
  Lc_Preco:String;
Begin
  Result := true;
  If It_NFCe then
  Begin
    if (trim(Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString) = '') or
       (Length(Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString) < 8) then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Código de NCM não preenchido ou incompleto.'+EOLN +
                     'Verifique antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      E_BuscaCodigo.Clear;
      Result := false;
      exit;
    end;
  end;

  IF (Pc_Vl_Venda =0)  then
  Begin
      MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                    'Este produto está com o preço Zerado.' + EOLN +
                    'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
      E_BuscaCodigo.Clear;
      Result := false;
      exit;
  end;
  if Trim(Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString)='' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O produto está com problemas em sua descrição.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;


function TFr_Lanca_Command.FC_BuscarProduto(Pc_Codigo,Fc_Campo: string):Integer;
var
  Lc_Sqltxt: string;
begin
  Screen.Cursor := crHourGlass;
  Lc_Sqltxt := 'SELECT DISTINCT '+
               'PRO_CODIGO, '+
               'PRO_CODIGOFAB, '+
               'PRO_ORIGEM, '+
               'PRO_CODIGOBAR, '+
               'PRO_CODIGOFOR, '+
               'PRO_CODIGONCM, '+
               'PRO_DESCRICAO, '+
               'PRO_VL_CUSTO, '+
               'MED_ABREVIATURA, '+
               'PRC_VL_VDA, '+
               'PRC_AQ_COM, '+
               'PRO_CAMPANHA '+
               'FROM TB_PRODUTO tb_produto '+
               '  INNER JOIN TB_PRECO tb_preco '+
               '  ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO) '+
               '  INNER JOIN tb_medida tb_medida '+
               '  ON (tb_medida.med_codigo = tb_produto.pro_codmed) '+
               'WHERE (PRO_ATIVO = ''S'') AND (PRC_CODTPR =:PRC_CODTPR) '+
               ' AND (PRO_TIPO <> ''S'') ';

  Lc_Sqltxt := Lc_Sqltxt + ' AND (' + Fc_Campo + ' =:' + Fc_Campo + ') ';

  Qr_PesqProduto.Close;
  Qr_PesqProduto.SQL.Clear;
  Qr_PesqProduto.SQL.Add(Lc_Sqltxt);
  Qr_PesqProduto.ParamByName(FC_CAMPO).AsString := Pc_Codigo;
  Qr_PesqProduto.ParamByName('PRC_CODTPR').AsInteger := It_Cd_Tabela;
  Qr_PesqProduto.Open;
  Qr_PesqProduto.FetchAll;
  Qr_PesqProduto.First;
  if Qr_PesqProduto.RecordCount > 0 then
  Begin
    if Qr_PesqProduto.FieldByName('PRO_CAMPANHA').AsString = 'S' then
    Begin
      Qr_PesqProduto.Close;
      Qr_PesqProduto.ParamByName(FC_CAMPO).AsString := Pc_Codigo;
      Qr_PesqProduto.ParamByName('PRC_CODTPR').AsInteger := 2;
      Qr_PesqProduto.Open;
      Qr_PesqProduto.FetchAll;
      Qr_PesqProduto.First;
    end;
    Result := Qr_PesqProduto.RecordCount;
  end
  else
  Begin
    Qr_PesqProduto.Close;
    Result := 0;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Lanca_Command.Pc_PreencheItensVenda(Pc_Cd_Produto:String;
                                              Pc_Cd_Fabrica:String;
                                              Pc_Descricao:String;
                                              Pc_Qtde:Real;
                                              Pc_Vl_Venda:Real;
                                              Pc_Abreviatura:String;
                                              Pc_VL_Custo:Real;
                                              Pc_NCM:String;
                                              Pc_Origem:String;
                                              Pc_Vl_Original:Real);
Var
  Lc_Aux: Real;
begin
  //Zera o Troco no primeiro lançamento de item em uma nova venda
  It_Nr_Item := It_Nr_Item + 1;
  with StrGrd_Produtos do
  Begin
    RowCount := It_Nr_Item + 1;
    Cells[0, It_Nr_Item] := '';
    Cells[1, It_Nr_Item] := StrZero(It_Nr_Item,3,0);
    Cells[2, It_Nr_Item] := Pc_Cd_Produto;
    Cells[3, It_Nr_Item] := Pc_Cd_Fabrica;
    Cells[4, It_Nr_Item] := Pc_Descricao;
    Cells[5, It_Nr_Item] := FloatToStrF(Pc_Qtde, ffFixed, 10, 3);
    Cells[6, It_Nr_Item] := FormatFloat('#0.00###', Pc_Vl_Venda);
      //FloatToStrF(Pc_Vl_Venda, ffFixed, 10, 2);
    Pc_Qtde := RoundTo(Pc_Qtde,-3);
    Lc_Aux := Pc_Vl_Venda * Pc_Qtde;
    Lc_Aux := RoundTo(Lc_Aux ,-2);
    Cells[7, It_Nr_Item] := FloatToStrF(Lc_Aux , ffFixed, 10, 2);
    Cells[8, It_Nr_Item] := Pc_Abreviatura;
    Cells[9, It_Nr_Item] := FloatToStrF(Pc_VL_Custo, ffGeneral, 10, 2);
    Cells[10, It_Nr_Item] := '0';
    Cells[11, It_Nr_Item] := Pc_NCM;
    Cells[12, It_Nr_Item] := Pc_Origem;
    Promocao.getbyProduct(StrToIntDef(Pc_Cd_Produto,0),Gb_CodMha);
    if Promocao.exist then
    Begin
      Cells[13,It_Nr_Item] := Promocao.Registro.Codigo.ToString;
      Cells[15,It_Nr_Item] := FloattoStr(Promocao.Registro.Quantidade);
      Cells[16,It_Nr_Item] := FormatFloat('#0.#####',Promocao.Registro.Preco);
          //FloattoStr(RoundTo(Promocao.Registro.Preco,-5));
    End
    else
    Begin
      Cells[13,It_Nr_Item] := '0';
      Cells[15,It_Nr_Item] := '0';
      Cells[16,It_Nr_Item] := '0';
    End;
    Cells[14, It_Nr_Item] := FloatToStrF(Pc_Vl_Original, ffFixed, 10, 2);
    E_Qtde.Text := '1';
    Row := StrGrd_Produtos.RowCount - 1;
    //Item Lançado
    Lb_Item_lancado.Caption := concat(
                                 Pc_Descricao, ' | ',
                                 FloatToStrF(Pc_Qtde, ffFixed, 10, 3), ' X ',
                                 FloatToStrF(Pc_Vl_Venda, ffFixed, 10, 2), ' = ',
                                 FloatToStrF(Pc_Vl_Venda * Pc_Qtde, ffFixed, 10, 2)
                                );
  End;
end;

procedure TFr_Lanca_Command.Pc_MontaGrid;
Begin

  with StrGrd_Produtos do
  Begin
    ColWidths[0] := 25;
    ColWidths[1] := 50;
    ColWidths[2] := -1;
    ColWidths[3] := 0;
    ColWidths[4] := 430;
    ColWidths[5] := 80;
    ColWidths[6] := 100;
    ColWidths[7] := 125;
    ColWidths[8] := -1;
    ColWidths[9] := -1;
    ColWidths[10] := -1;
    ColWidths[11] := -1;
    ColWidths[12] := -1;
    ColWidths[13] := -1;
    ColWidths[14] := -1;
    ColWidths[15] := -1;
    ColWidths[16] := -1;
    {//----------------------------
    ColWidths[0] := 20;
    ColWidths[1] := 50;
    ColWidths[2] := 50;
    ColWidths[3] := 0;
    ColWidths[4] := 430;
    ColWidths[5] := 80;
    ColWidths[6] := 100;
    ColWidths[7] := 120;
    ColWidths[8] := 100;
    ColWidths[9] := 100;
    ColWidths[10] := 100;
    ColWidths[11] := 100;
    ColWidths[12] := 100;
    ColWidths[13] := 100;
    ColWidths[14] := 100;
    ColWidths[15] := 100;
    ColWidths[16] := 100;
    //----------------------------}

    Cols[1].Add('Seq');
    Cols[2].Add('Cód. Produto');
    Cols[3].Add('Código');
    Cols[4].Add('Descrição');
    Cols[5].Add('Qtde');
    Cols[6].Add('Unitário');
    Cols[7].Add('Subtotal');
    Cols[8].Add('Abreviatura');
    Cols[9].Add('Vl. Custo');
    Cols[10].Add('Cd. Item');
    Cols[11].Add('ncm');
    Cols[12].Add('Origem');
    Cols[13].Add('TemPromoção');
    Cols[14].Add('ValorOriginal');
    Cols[15].Add('Qtde Promoção');
    Cols[16].Add('Preço Promoção');
  End;
End;

procedure TFr_Lanca_Command.Pc_FormataPanels;
Var
  Lc_top,lc_left : Integer;
BEgin
  //Posiciona o Panel de Tabela de Preço
  Pnl_TabelaPreco.Visible := False;
  Lc_top := trunc((Height - Pnl_TabelaPreco.Height)/2);
  lc_left := trunc((Width - Pnl_TabelaPreco.Width)/2);
  Pnl_TabelaPreco.Top := Lc_top;
  Pnl_TabelaPreco.Left := lc_left;
End;

procedure TFr_Lanca_Command.Pc_FormataTela;
Var
  LcTemPromocao : Boolean;
Begin
  //Oculta a barra de ferramenta
  Width := Screen.Width;
  Height := Screen.Height - 10;
  Pnl_Topo.Height := 131;
  OcultaBarraTarefas(Fc_Aq_Geral('L','CONTROLE DE FRENTE','OCULTABARRAWINDOWS','S') = 'S');

  LcTemPromocao := Promocao.tempromocao;
  Fc_BuscaImagemEmpresa(Img_Frente.Picture, 'FRENTECAIXA');
  Pc_LimpaStringGrid(StrGrd_Produtos);
  Pc_MontaGrid;
  if E_Numero_Comanda.CanFocus then E_Numero_Comanda.SetFocus;

  Pc_FormataPanels;

end;

procedure TFr_Lanca_Command.Pc_PosicionaCliente;
Var
  LcEmpresa : TControllerEmpresa;
Begin
  try
    LcEmpresa := TControllerEmpresa.Create(Self);
    LcEmpresa.Registro.Codigo := It_Cd_Cliente;
    LcEmpresa.getById;

    LcEmpresa.Endereco.Registro.CodigoEmpresa := It_Cd_Cliente;
    LcEmpresa.Endereco.getByEmpresa;
    if LcEmpresa.Endereco.exist then
    Begin
      It_Cd_Endereco := LcEmpresa.Endereco.Registro.Codigo;
    end
    else
    Begin
       MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                      'Este cliente está sem endereço ou ' + EOLN +
                      'como endereço incompleto.'+ EOLN +
                      'Verifique antes de continuar.' + EOLN,
                      ['OK'], [bEscape], mpErro);
    end;
  finally
    FReeAndNil(LcEmpresa);
  end;


{
Var
  LcEmpresa : TControllerEmpresa;
  LcNome : String;
Begin
  try
    E_Cd_Cliente.Text :=  StrZero(It_Cd_Cliente,4,0);
    LcEmpresa := TControllerEmpresa.Create(Self);
    LcEmpresa.Registro.Codigo := It_Cd_Cliente;
    LcEmpresa.getById;
    LcNome := LcEmpresa.Registro.ApelidoFantasia;
    if Length(Trim(LcNome))= 0 then
      LcNome := LcEmpresa.Registro.NomeRazaoSocial;

    E_Nome_Cliente.Text := LcNome;
    LcEmpresa.Endereco.Registro.CodigoEmpresa := It_Cd_Cliente;
    LcEmpresa.Endereco.getByEmpresa;
    if LcEmpresa.Endereco.exist then
    Begin
      It_Cd_Endereco := LcEmpresa.Endereco.Registro.Codigo;
    end
    else
    Begin
       MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                      'Este cliente está sem endereço ou ' + EOLN +
                      'como endereço incompleto.'+ EOLN +
                      'Verifique antes de continuar.' + EOLN,
                      ['OK'], [bEscape], mpErro);
    end;
  finally
    FreeAndNil(LcEmpresa)
  end;
  }
end;

procedure TFr_Lanca_Command.Pc_IniciaVariaveis;
Begin
  Pc_DefineCasaDecimal;

  It_NFCe := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_VDA_NFCE', 'N') = 'S');
  It_Ctrl_Estoque := (Fc_TB_Geral('L','FRT_VDA_EST_SEM_CTRL', 'N') = 'S');
  //Define o codigo do Vendedor
  pedido.Vendedor.Registro.Usuario := GB_Cd_Usuario;
  pedido.Vendedor.getByUsuario;
  CodigoVendedor := pedido.Vendedor.Registro.Codigo;

  It_Cd_Consumidor := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  It_Cd_Cliente := It_Cd_Consumidor;

  //Bloco do codigo de produto
  BalBarraCodigoProduto := StrToIntDef( Fc_Aq_Geral('L','BALANCA','BAL_BAR_CD_PRODUTO','6'),6);
  //Bloco do codigo de peso ou preco
  BalBarraPrecoPeso := StrToIntDef( Fc_Aq_Geral('L','BALANCA','BAL_BAR_PRECO_QTDE','6'),6);

  //Inicia a Variavel que autoriza fechar a tela
  It_Cd_FormaPagto := Fc_PegaParteFormaPgto('DINHEIRO');
  It_Cd_Tabela := StrToIntDef(Fc_Tb_Geral('L','FRT_G_PRECO_CONSUMIDOR','1'),1);
  //Identifica o Cliente na Tela;
  Pc_PosicionaCliente;

  //Peso Automatico se a unidade for KG
  IT_Calc_automatico:= Fc_Tb_Geral('L','FRENTE_CX_CALC_AUTO','');

  Application.ProcessMessages;
  //Ativa a Balanca
  It_Usa_Balanca := (Fc_Aq_Geral('L','BALANCA','BAL_P_ATIVACAO','') = 'S');

  //Verifica o uso do Produto avulso
  It_Usa_ProdutoAvulso := (Fc_Tb_Geral('L','FRT_PRODUTOAVULSO','N') = 'S');
  if It_Usa_ProdutoAvulso then
  Begin
    Pedido.Itens.Produto.getProdutoAvulso;
    if Pedido.Itens.Produto.exist then
      It_Cd_ProdutoAvulso := Pedido.Itens.Produto.Registro.Codigo.ToString()
    else
    Begin
      It_Usa_ProdutoAvulso := False;
      It_Cd_ProdutoAvulso := '0';
    End;
  End;
  //Faz a Busca por codigo de Fabrica
  It_Usa_Cd_Fabrica := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N') = 'S');
  //Utilizar sistemática de impressão item a item na leitura do produto no checkout
  It_Usa_Imp_Checkout := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_ITEM_CHECKOUT', 'N') = 'S');
  //Verifica se o Tipo de Impressão será matricial ou termica
  It_Tp_Impressao := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','1'),1);
  //Prepara o ESC/POS para usar a gaveta e outros
  AtivaESCPOS;
  //Ativa o TEF

End;

procedure TFr_Lanca_Command.Pc_Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
begin
  //Pedido
  Lc_Vl_Total := 0;
  Lc_Vl_aux := StrToFloatDef(E_Vl_Pedido.Caption, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_Vl_Pedido.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Desconto
  Lc_Vl_Total := Lc_Vl_Total - Lc_Vl_aux;
end;

procedure TFr_Lanca_Command.Pc_AbreTelaProdutoAvulso;
Var
  Form : TFr_FrenteCaixaProdAvulso;
Begin
  try
    Form := TFr_FrenteCaixaProdAvulso.Create(Self);
    Form.E_Qt_Avulso.Text := '1,00';
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Fc_BuscarProduto(It_Cd_ProdutoAvulso,'PRO_CODIGO');
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Form.E_Avl_Descricao.Text,
                            StrToFloatDef(Form.E_Qt_Avulso.Text,0),
                            StrToFloatDef(Form.E_Vl_Avulso.Text,0),
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Lanca_Command.Pc_AbreTelaProdutoSemRegistro(Pc_Descricao,Pc_Unidade,Pc_VL_Unitario:String);
Var
  Form : TFr_FrenteCaixaProdSemRegistro;
Begin
  try
    Form := TFr_FrenteCaixaProdSemRegistro.Create(Self);
    Form.E_Avl_Descricao.Text := Pc_Descricao;
    Form.E_Avl_Medida.Text := Pc_Unidade;
    Form.E_Avl_Vl_Unitario.Text := Pc_VL_Unitario;
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Form.E_Avl_Descricao.Text,
                            StrToFloatDef(Form.E_Avl_Qtde.Text,0),
                            StrToFloatDef(Form.E_Avl_Vl_Unitario.Text,0),
                            Form.E_Avl_Medida.Text,
                            0,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    End;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Lanca_Command.Pc_AbreTelaBalanca;
Var
  Form : TFr_FrenteCaixaPesoBalanca;
Begin
  try
    Form := TFr_FrenteCaixaPesoBalanca.Create(Self);
    Form.E_Vl_Unitario.Text := FloatToStrF(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,ffFixed,10,2);
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            StrToFloatDef(Form.E_Peso_Liquido.Caption,1),
                            StrToFloatDef(Form.E_Vl_Unitario.Text,0),
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    End;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Lanca_Command.Pc_AbreTelaBalancaManual;
Var
  Form : TFr_FrenteCaixaPesoManual;
Begin
  try
    Form := TFr_FrenteCaixaPesoManual.Create(Self);
    Form.E_Peso_LiquidoManual.Text := '0,00';
    Form.E_Vl_UnitarioManual.Text := FloatToStrF(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,ffFixed,10,2);
    Form.E_Vl_PesoManual.Caption := '0,00';
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            StrToFloatDef(Form.E_Peso_LiquidoManual.Text,1),
                            StrToFloatDef(Form.E_Vl_UnitarioManual.Text,0),
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);

      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Lanca_Command.Pc_PreencheProdutoCodigoReduzido(Pc_Cd_Produto:String);
Var
  Lc_Nr_Registro:Integer;
Begin
  IF It_Usa_Cd_Fabrica then
    Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGOFAB')
  else
    Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGO');
    
  if (Lc_Nr_Registro = 1) then
  begin
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      if (Upper(Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString) = 'KG')then
      Begin
        if It_Usa_Balanca then
          Pc_AbreTelaBalanca
        else
          Pc_AbreTelaBalancaManual;
      end
      else
      Begin
        Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                              Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                              Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                              StrToFloatDef(E_Qtde.Text,1),
                              Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                              Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                              Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                              Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                              Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                              Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
        Pc_Promocao(StrGrd_Produtos.Cells[13,It_Nr_Item],
                    StrToFloatDef(StrGrd_Produtos.Cells[15,It_Nr_Item],0),
                    StrToFloatDef(StrGrd_Produtos.Cells[16,It_Nr_Item],0));
        //totaliza os itens na tela
        Pc_SomaProdutos;
        Pc_Totalizador;
        Pc_ImprimeItemCheckout;
        //Limpa os campos
        if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
        E_BuscaCodigo.Clear;
      end;
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

procedure TFr_Lanca_Command.Pc_PreencheProdutoCodigoBarrasBalanca(Pc_Cd_Barras:String);
Var
  Lc_Cd_produto,Lc_Total : String;
  Lc_Peso : Real;
  Lc_Nr_Registro:Integer;

Begin
  Lc_Cd_produto := Copy(E_BuscaCodigo.Text,2,BalBarraCodigoProduto);
  Lc_Cd_produto := IntToStr( StrToIntDef(Lc_Cd_produto,0) );
  IF (It_Usa_Cd_Fabrica)then
    Lc_Nr_Registro := Fc_BuscarProduto(Lc_Cd_produto,'PRO_CODIGOFAB')
  else
    Lc_Nr_Registro := Fc_BuscarProduto(Lc_Cd_produto,'PRO_CODIGO');
  if (Lc_Nr_Registro = 1) then
  begin
    //SE O TIPO DE LEITURA É POR PESO ENTÃO O PRODUTO PRECISA TER PREÇO PARA CALCULAR
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      Lc_Total := Copy(E_BuscaCodigo.Text,BalBarraCodigoProduto + 2 ,BalBarraPrecoPeso );
      //Colocando a Virgula
      Lc_Total := Copy(Lc_Total,1,BalBarraPrecoPeso-2)+','+Copy(Lc_Total,BalBarraPrecoPeso-1,2);
      Lc_Peso := StrToFloatDEf(Lc_Total,1) / Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency;
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            Lc_Peso,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
      Pc_Promocao(StrGrd_Produtos.Cells[13,It_Nr_Item],
                  StrToFloatDef(StrGrd_Produtos.Cells[15,It_Nr_Item],0),
                  StrToFloatDef(StrGrd_Produtos.Cells[16,It_Nr_Item],0));
      //totaliza os itens na tela
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      //Limpa os campos
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

procedure TFr_Lanca_Command.Pc_PreencheProdutoCodigoBarras(Pc_Cd_Barras:String);
Var
  Lc_Nr_Registro:Integer;
Begin
  Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGOBAR');
  if (Lc_Nr_Registro = 1) then
  begin
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            StrToFloatDef(E_Qtde.Text,1),
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency);
      Pc_Promocao(StrGrd_Produtos.Cells[13,It_Nr_Item],
                  StrToFloatDef(StrGrd_Produtos.Cells[15,It_Nr_Item],0),
                  StrToFloatDef(StrGrd_Produtos.Cells[16,It_Nr_Item],0));
      //totaliza os itens na tela
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      //Limpa os campos
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

procedure TFr_Lanca_Command.ProdutoDifDeUm(Nr_Registro:Integer);
Begin
  if (Nr_Registro > 1) then
  begin
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    Pc_MostraBusca;
  end
  else
  Begin
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    ShowMessage('Produto Não encontrado');
  end;
end;

procedure TFr_Lanca_Command.MnuSalvarComandaClick(Sender: TObject);
begin
  Pc_TeclaAtalhoF4;
end;

procedure TFr_Lanca_Command.SalvaItemsComanda;
Var
  I : Integer;
  LcCmdItems : TControllerCheckOutItems;
begin
  try
    LcCmdItems := TControllerCheckOutItems.Create(Self);
    LcCmdItems.Registro.Estabelecimento := Gb_CodMha;
    LcCmdItems.Registro.Pedido          := Pedido.Registro.Codigo;
    //Apaga os itens da Comanda para reinserir
    LcCmdItems.deleteByOrder;
    //Insere os itens da Lista atualizada
    with LcCmdItems, StrGrd_Produtos do
    Begin
      for I := 1 to ( RowCount - 1 ) do
      begin
        Registro.Codigo          := StrToIntDef( Cells[1, I],0);
        Registro.Estabelecimento := Gb_CodMha;
        Registro.Pedido          := Pedido.Registro.Codigo;
        Registro.CodigoProduto   := StrToIntDef( Cells[2, I] ,0 );
        Registro.Unidade         := Cells[8, I];
        Registro.DescProduto     := Cells[4, I];
        Registro.Quantidade      := StrToFloatDef( Cells[5, I],0 );
        Registro.ValorUnitario   := StrToFloatDef( Cells[6, I],0 );
        Registro.CodigoFabrica   := Cells[3, I];
        Registro.PrecoCusto      := StrToFloatDef( Cells[9, I],0 );
        Registro.Ncm             := Cells[11, I];
        Registro.Origem          := Cells[12, I];
        Registro.PromoCodigo     := StrToIntDef( Cells[13,I],0);
        Registro.PromoQtde       := StrToFloatDef( Cells[15, I],0 );
        Registro.PromoPreco      := StrToFloatDef( Cells[16, I],0 );
        Registro.PromoOriginal   := StrToFloatDef( Cells[14, I],0 );
        LcCmdItems.insere;
      End;
    end;
  finally
    FreeAndNil(LcCmdItems);
  end;
end;

procedure TFr_Lanca_Command.SalvarCommand;
Var
  LcCmd : TControllerCommand;
  Form : TFr_Command;
begin
  try
    if Pedido.Registro.Codigo = 0 then
      Pc_GeraPedido;
    LcCmd := TControllerCommand.Create(Self);
    LcCmd.Registro.Estabelecimento := Gb_CodMha;
    LcCmd.Registro.Pedido := Pedido.Registro.Codigo;
    LcCmd.Registro.DataRegistro := Now;
    LcCmd.getbyKey;
    if not LcCmd.exist then
    Begin
      if validaNumeroComanda(False) then
      Begin
        LcCmd.Registro.Estabelecimento := Gb_CodMha;
        LcCmd.Registro.Pedido := Pedido.Registro.Codigo;
        LcCmd.Registro.DataRegistro := Now;
        LcCmd.Registro.Numero      := e_Numero_Comanda.Text;
        LcCmd.Registro.NomeCliente := '';
        LcCmd.Registro.Telefone    := '';
        LcCmd.insere;
      End
      else
      Begin
        try
          Form := TFr_Command.Create(Self);
          Form.Command := LcCmd;
          Form.ShowModal;
        finally
          FreeAndNil(Form);
        end;
      End;
    End;
    SalvaItemsComanda;
    limparTela;
  finally
    FreeAndNil(LcCmd);
  end;
end;


function TFr_Lanca_Command.Fc_LancaItem:Boolean;
begin
  Result := False;
  if Length(Trim(E_BuscaCodigo.Text)) > 0 then
  Begin
    Result := True;
    //Busca Pelo Codigo Reduzido
    if Length(Trim(E_BuscaCodigo.Text)) <= 6 then
    Begin
      Pc_PreencheProdutoCodigoReduzido(E_BuscaCodigo.Text);
      Result := False;
    end
    else
    Begin
      //VErifica se o codigo de barras é de balança
      if (Copy(E_BuscaCodigo.Text,1,1) = '2') and (Length(E_BuscaCodigo.Text)< 14) then
      Begin
        Pc_PreencheProdutoCodigoBarrasBalanca(E_BuscaCodigo.Text);
      end
      else
      Begin
        Pc_PreencheProdutoCodigoBarras(E_BuscaCodigo.Text);
      end;
    end;
  end;
end;

Function TFr_Lanca_Command.Fc_StatusTecla (Key: integer): boolean;//função para desabilitar alt+f4
begin
  Result := Odd (GetKeyState (Key)); //Result := se a tecla for pressionada
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF2();
Begin
 if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF3();
Begin
  If It_Usa_ProdutoAvulso then
  Begin
    Pc_AbreTelaProdutoAvulso;
  end
  else
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O uso de produto avulso no sistema não foi encontrado.'+EOLN+
                   'Verifique com o Administrador do Sistema.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF4();
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja salvar esta venda em uma Comanda'+EOLN+EOLN+
                     'Confirmar a operação ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  Begin
    SalvarCommand;
    if E_Numero_Comanda.CanFocus then E_Numero_Comanda.SetFocus;
  End;
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF5();
Begin
 if E_Numero_Comanda.CanFocus then E_Numero_Comanda.SetFocus;
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF6();
Begin
  Pc_MostraBusca;
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF7();
Begin

end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF8();
Begin

end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF9();
Begin

end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF10();
Begin
  Self.Close;
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoF11();
Begin
  if E_Qtde.CanFocus then E_Qtde.SetFocus;
  E_Qtde.Clear;
end;


procedure TFr_Lanca_Command.Pc_TeclaAtalhoF12();
Begin
  EscolheTabela;
end;

procedure TFr_Lanca_Command.Pc_TeclaAtalhoEscape();
Begin
  if Pnl_TabelaPreco.Visible then
  Begin
    Sb_Cancela_TabelaPrecoClick(Self);
    exit;
  end;
end;

procedure TFr_Lanca_Command.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2: Pc_TeclaAtalhoF2();
      VK_F3: Pc_TeclaAtalhoF3();
      VK_F4: Pc_TeclaAtalhoF4();
      VK_F5:Pc_TeclaAtalhoF5();
      VK_F6:Pc_TeclaAtalhoF6();
      VK_F7:Pc_TeclaAtalhoF7();
      VK_F8:Pc_TeclaAtalhoF8();
      VK_F9:Pc_TeclaAtalhoF9();
      VK_F10:Pc_TeclaAtalhoF10();
      VK_F11:Pc_TeclaAtalhoF11();
      VK_F12:Pc_TeclaAtalhoF12();
      VK_ESCAPE:Pc_TeclaAtalhoEscape();
    end;
  end;
end;

procedure TFr_Lanca_Command.Pc_SomaProdutos;
var
  Lc_I: Integer;
  Lc_Qtde : Real;
  Lc_Vl_Pedido : Real;
  Lc_VL_Original : real;
  Lc_VL_Venda : real;
  Lc_VL_Tl_Original : Real;
  Lc_Vl_Subtotal : Real;
begin
  Lc_Vl_Pedido := 0;
  It_Qt_Produtos := 0;
  Lc_VL_Tl_Original := 0;
  for Lc_I := 1 to StrGrd_Produtos.RowCount - 1 do
  begin
    Lc_Qtde := StrToFloatDef(StrGrd_Produtos.Cells[5, LC_I], 0);
    if (Lc_Qtde > 0) and (Lc_Qtde < 1) then
      It_Qt_Produtos := It_Qt_Produtos + 1
    else
      It_Qt_Produtos := It_Qt_Produtos + Lc_Qtde;
    Lc_Vl_Subtotal := StrToFloatDef(StrGrd_Produtos.Cells[7, LC_I],0);

    Lc_Vl_Pedido := Lc_Vl_Pedido + Lc_Vl_Subtotal;
    //Soma os Valores da Coluna Original para saber se houve economia
    //Se for Produto avulso não soma
    if not (It_Cd_ProdutoAvulso = StrGrd_Produtos.Cells[2, LC_I]) then
    Begin
      Lc_VL_Venda := StrToFloatDef(StrGrd_Produtos.Cells[6, LC_I], 0);
      Lc_VL_Original := StrToFloatDef(StrGrd_Produtos.Cells[14, LC_I], 0);
      //O Valor Original deve ser maior do que zero e maior do que o valor vendido
      if (Lc_VL_Original > 0 ) and (Lc_VL_Original > Lc_VL_Venda) then
        Lc_VL_Tl_Original := Lc_VL_Tl_Original + (Lc_VL_Original * Lc_Qtde);
    End;
  end;
  Lc_Vl_Pedido := Fc_ArredondarParaCima(Lc_Vl_Pedido,2);
  E_Vl_Pedido.Caption := FloatToStrF(Lc_Vl_Pedido,ffFixed,10,2);
end;

procedure TFr_Lanca_Command.Pc_LimpaCampos;
begin
  Pedido.clear;
  E_Vl_Pedido.Caption := '0,00';
  Lb_Item_lancado.Caption := 'Lançar item';
  E_Numero_Comanda.clear;
  It_Nr_Item := 0;
  FreeAndNil(ListaPedidoItem);
  ListaPedidoItem := TListaItemVenda.create;
end;


procedure TFr_Lanca_Command.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(ListaPedidoItem);
  OcultaBarraTarefas(False);
end;

procedure TFr_Lanca_Command.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //Valida Abertura
  if ValidaItensNaLista then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   '    Existe uma Comanda em Aberto.' + EOLN +
                   'Salve primeiro e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    canClose := False;
    exit;
  end;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Deseja realmente sair do Tela de Comandas ?' + EOLN + EOLN +
                      'Confirmar a saida ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao2) then
  begin
     canClose := False;
  end;
end;

procedure TFr_Lanca_Command.FormCreate(Sender: TObject);
begin
  InitVariable;
end;

procedure TFr_Lanca_Command.StrGrd_ProdutosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with StrGrd_Produtos do
  Begin
    if (arow > 0) and (acol > 0) then // testa se não é a primeira linha (fixa)
      if (odd(arow)) then
      begin // verifica se a linha impar
        Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := clCream;
      end
      else
      begin
        Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := clScrollBar;
      end;
    Canvas.FillRect(Rect); // redesenha a celula
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Cells[acol, arow]); // reimprime o texto.


    { Pega o texto da célula }
    Texto := Concat(Cells[acol, ARow], '  ');
    { Calcura largura e altura (em pontos) do texto }
    LarguraTexto := Canvas.TextWidth(Texto);
    AlturaTexto := Canvas.TextHeight(Texto);

    { Calcula a posição horizontal do início do texto }
    if (ACol = 2) or (ACol = 3) or (ACol = 4) then { Esquerda }
      X := Rect.Left + 2
    else if ACol = 1 then { Centro }
      X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
        LarguraTexto div 2
    else { Direita }
      X := Rect.Right - LarguraTexto - 2;

    { Calcula a posição vertical do início do texto para
      que seja impresso no centro (verticalmente) da célula }
    Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
      AlturaTexto div 2;

    { Pinta o texto }
//    Canvas.Font.Size := 14;
//    Canvas.Font.Style:= [fsBold];
    Canvas.TextRect(Rect, X, Y, Texto);

    if (arow > 0) and (trim(Texto) <> '')then
    Begin
      if (StrToIntDef(Cells[13,ARow],0) > 0) then
      Begin
        try
          Bitmap:=TBitmap.Create;
          if (Cells[6,ARow] = Cells[14,ARow] ) then
            ImageList1.GetBitmap(1,bitmap)
          else
            ImageList1.GetBitmap(0,bitmap);
          Canvas.StretchDraw(CellRect(0,ARow),Bitmap);
        finally
          FreeAndNil(Bitmap);
        End;
      end;
    End;

  End;
end;


procedure TFr_Lanca_Command.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_LimpaCampos;
end;

function TFr_Lanca_Command.getPedidoByCommand(CommandID:String): Integer;
Var
  LcCommand : TControllerCommand;
begin
  Try
    Result := 0;
    LcCommand := TControllerCommand.create(nil);
    LcCommand.Registro.Estabelecimento := Gb_CodMha;
    LcCommand.Registro.Numero := CommandID;
    LcCommand.getByComandaLivre;
    if LcCommand.exist then
      Result := LcCommand.Registro.Pedido;
  Finally
    FreeAndNil(LcCommand);
  End;
end;

procedure TFr_Lanca_Command.GuardaListaProdutos(ListaItem : TListaItemVenda;Promocao:String);
Var
  I,J :Integer;
  ItemVenda : TItemVenda;
  LcSomaItem : Real;
begin
  for I := 1 to (StrGrd_Produtos.RowCount - 1) do
  Begin
    //Se for da Promoção podemos alterar a aquantidade confomre a sma e o valor da prmoção
    if ( Promocao = StrGrd_Produtos.Cells[13,I] ) then
    Begin
      ItemVenda := TItemVenda.Create;
      ItemVenda.Produto       := StrToIntDef(StrGrd_Produtos.Cells[2, I],0);
      ItemVenda.ValorOriginal := StrToFloatDef(StrGrd_Produtos.Cells[14, I],0);
      ItemVenda.ValorCusto    := StrToFloatDef(StrGrd_Produtos.Cells[9, I],0);
      ItemVenda.Fabrica       := StrGrd_Produtos.Cells[3, I];
      ItemVenda.Descricao     := StrGrd_Produtos.Cells[4, I];
      ItemVenda.Quantidade    := StrToFloatDef(StrGrd_Produtos.Cells[5, I],0);
      ItemVenda.ValorVenda    := StrToFloatDef(StrGrd_Produtos.Cells[16, I],0);
      ItemVenda.ncm           := StrGrd_Produtos.Cells[11, I];
      ItemVenda.Abreviatura   := StrGrd_Produtos.Cells[8, I];
      ItemVenda.Promocao      := StrGrd_Produtos.Cells[13, I];
      ItemVenda.QtdePromocao  := StrToFloatDef(StrGrd_Produtos.Cells[15, I],0);
      ItemVenda.PRecoPromocao := StrToFloatDef(StrGrd_Produtos.Cells[16, I],0);
      //Soma a quantidade de todos os itens iguais a este
      LcSomaItem := 0;
      for J := 1 to (StrGrd_Produtos.RowCount - 1) do
      Begin
        if ( ItemVenda.Produto = StrToIntDef(StrGrd_Produtos.Cells[2,J],0) ) then
          LcSomaItem := LcSomaItem + StrToFloatDef(StrGrd_Produtos.Cells[5,J],0);
      End;
      //Accumula toda a quantidade em apenas um registro
      ItemVenda.Quantidade :=LcSomaItem;
      ListaItem.Add(ItemVenda);
      //Delata os Itens iguais da lista
      EliminaItemDaGRid(StrGrd_Produtos,ItemVenda.Produto.ToString);
      GuardaListaProdutos(ListaItem,Promocao);
    End;
  End;
end;

procedure TFr_Lanca_Command.img_f6Click(Sender: TObject);
begin
  Pc_TeclaAtalhoF10;
end;

Function TFr_Lanca_Command.FC_Valida_ImpostoAproximado:boolean;
var
  lc_obs : TMemo;
  Lc_Imp_Aprox :TStringList;
  Lc_I:Integer;
Begin
  Try
    Result:=true;
    Lc_obs := TMemo.Create(Self);
    Lc_obs.Visible := false;
    Lc_obs.Parent := self;
    Lc_Imp_Aprox := TStringList.Create;
    For Lc_I := 1 to StrGrd_Produtos.RowCount-1 do
    Begin
      Fc_ImpostoAproximado(Lc_Imp_Aprox,StrGrd_Produtos.cells[11,StrGrd_Produtos.Row],
                                          StrGrd_Produtos.cells[12,StrGrd_Produtos.Row]);

      if (StrToFloatDef(Lc_Imp_Aprox.Strings[3],0) = 0) then
      Begin
        Result := False;
        lc_obs.Lines.Add(StrGrd_Produtos.cells[2,StrGrd_Produtos.Row] + ' - ' + StrGrd_Produtos.cells[4,StrGrd_Produtos.Row]);
      end;
    end;

    If not Result then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Problemas com os as informações do Imposto CF. Lei 12.741/12.'+EOLN+EOLN+
                     lc_obs.Text,
                     ['OK'],[bEscape],mpAlerta);
    end;
  Finally
    FreeandNil(Lc_Imp_Aprox);
    FreeandNil(lc_obs);
  End;
end;




procedure TFr_Lanca_Command.EliminaItemDaGRid(Pc_strGrid: TStringGrid; Item: String);
var
   Lc_I, Lc_J: Integer;
   Lc_Lista: array of array of string;
   Lc_Linha: Integer;
begin
  Lc_Linha := 0;
  SetLength(Lc_Lista, Pc_strGrid.RowCount, Pc_strGrid.ColCount);

  //Guarda os dados difernetes do item
   for Lc_I := 1 to Pc_strGrid.RowCount - 1 do
   begin
      if ( Pc_strGrid.Cells[2,Lc_I] <> Item ) then
      begin
         Lc_Linha := Lc_Linha + 1;
         for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
            Lc_Lista[Lc_Linha, Lc_J] := Pc_strGrid.Cells[Lc_J, Lc_I];
      end;
   end;

  //Limpa a Matriz antes de incluir a diferenca
   for Lc_I := 1 to Pc_strGrid.RowCount - 1 do
      for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
         Pc_strGrid.Cells[Lc_J, Lc_I] := '';

   Pc_strGrid.RowCount := 2;
   It_Nr_Item := 0;
  //Grava novamente os dados que não foram marcados e que estão na matriz
   if (Lc_Linha > 0) then
   begin
      for Lc_I := 1 to Lc_Linha do
      begin
         Pc_strGrid.RowCount := Lc_I + 1;
         for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
            Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I, Lc_J];
      end;
      It_Nr_Item := Lc_Linha;
   end;
end;

procedure TFr_Lanca_Command.OrdenarListaItems(Lista: TListaItemVenda);
var
  comparison: TComparison<TItemVenda>;
  delegateComparer: TDelegatedComparer<TItemVenda>;
begin
  // método anonimo para ordenação crescente por ID
  comparison := function (const P1, P2: TItemVenda): Integer
    begin
      Result := - CompareValue(P1.Quantidade, P2.Quantidade);
    end;

  // método anonimo para ordenação decrescente por ID
  { comparison := function (const P1, P2: TPessoa): Integer
    begin
      Result := - CompareText(P1.Id, P2.Id);
    end; }

  // classe que implementa TComparer<T> e facilita o uso.
  // passe o método de comparação para o delegate!
  delegateComparer := TDelegatedComparer<TItemVenda>.Create(comparison);
  try
    // Usando método Sort da nossa lista passando nosso "ordenador"
    Lista.Sort(delegateComparer);
  finally
    FreeAndNil(delegateComparer);
  end;
end;

procedure TFr_Lanca_Command.Pc_Promocao(Promocao : String;QtdePromocao:Real; preco : REal);
Var
  LcSomaQtde : Real;
  I,J : Integer;
  LcSomaItem : Real;
  LcMaiorQTde : Real;
  LcIndxCopia : Integer;
Label
  Reinicia;
begin
  with StrGrd_Produtos do
  Begin
    if ( Promocao <> '0' ) then
    Begin
      //Recoloca o valor de venda Original para tratar o caso de Exclussão
      for I := 1 to (RowCount - 1) do
      Begin
        if ( Promocao = Cells[13,I] ) then
        Begin
          Cells[6, I] := Cells[14, I];
        End;
      End;
      //Faz a Soma para comparar com a quantidade da promoção
      LcSomaQtde := 0;
      for I := 1 to (RowCount - 1) do
      Begin
        if ( Promocao = Cells[13,I] ) then
        Begin
          LcSomaQtde := LcSomaQtde + StrToFloatDef(Cells[5,I],0);
        End;
      End;
      //Compara se atingiu a quantidade e faz a alteração de preço
      if ( LcSomaQtde >= QtdePromocao) then
      Begin
        //Guara dos regisros do produto
        FreeAndNil(ListaPedidoItem);
        ListaPedidoItem := TListaItemVenda.create;
        GuardaListaProdutos(ListaPedidoItem,Promocao);
        OrdenarListaItems(ListaPedidoItem);
        //Trata o resto que ficar fora da quantidade da promoção
        TratarRestoPromocao(QtdePromocao,LcSomaQtde,ListaPedidoItem);
        //Recolocar os itens excluidos agora com as quantidades somadas por produtos
        for I := 0 to ListaPedidoItem.Count - 1 do
        Begin
          Pc_PreencheItensVenda(ListaPedidoItem[I].Produto.ToString,
                                ListaPedidoItem[I].Fabrica,
                                ListaPedidoItem[I].Descricao,
                                ListaPedidoItem[I].Quantidade,
                                ListaPedidoItem[I].ValorVenda,
                                ListaPedidoItem[I].Abreviatura,
                                ListaPedidoItem[I].ValorCusto,
                                ListaPedidoItem[I].ncm,
                                ListaPedidoItem[I].Origem,
                                ListaPedidoItem[I].ValorOriginal);
        End;
        //Refez a numeração dos itens
        for I := 1 to It_Nr_Item do
          Cells[1, I] := StrZero(I,3,0);
      End;
    End;
  End;
end;

Function TFr_Lanca_Command.Fc_validaExcluiCupom():Boolean;
Var
  Lc_Form :TFr_Liberacao;
Begin
  Result := true;
  if (Trim(StrGrd_Produtos.Cells[2,1])='') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'Não há itens para Excluir.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if (not Gb_Liberado) or (Gb_Nivel = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'O Cancelamento do Cupom é permitido apenas para usuário Administrador.' + EOLN +
                   '        Solicite autorização e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    try
      Lc_Form := TFr_Liberacao.Create(Self);
      Lc_Form.Liberado := False;
      Lc_Form.It_Interface := 'Fr_FrenteCaixa';
      Lc_Form.It_Nome_Menu := 'Frente de Caixa';
      Lc_Form.It_Privilegio := 'AUTORIZAR';
      Lc_Form.ShowModal;
      Result := False;
      if Lc_Form.Liberado then
      Begin
        //Para bloquear o GbLiberado precisa ser usuario normal
        if (Gb_Liberado) and (Gb_Nivel = 0) then
        Begin
          Gb_Liberado := False;
          Result := True;
        end;
      End;
    finally
      freeAndNil(Lc_Form);
    end;
  end;
end;

Function TFr_Lanca_Command.Fc_validaExcluiItemCupom():Boolean;
var
  Lc_Form : TFr_Liberacao;

Begin
  Result := true;
  if It_Nr_Item <= 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'Não há itens para Excluir.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if Fc_HabilitaPermissao('Fr_FrenteCaixa','EXCLUIR','S') then
  Begin
    Result := True;
    exit;
  End;

  if (not Gb_Liberado) or (Gb_Nivel = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'O Cancelamento do Cupom é permitido apenas para usuário Administrador.' + EOLN +
                   '        Solicite autorização e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    try
      Lc_Form := TFr_Liberacao.Create(Self);
      Lc_Form.Liberado := False;
      Lc_Form.It_Interface := 'Fr_FrenteCaixa';
      Lc_Form.It_Nome_Menu := 'Frente de Caixa';
      Lc_Form.It_Privilegio := 'AUTORIZAR';
      Lc_Form.ShowModal;
      Result := False;
      if Lc_Form.Liberado then
      Begin
        //Para bloquear o GbLiberado precisa ser usuario normal
        if (Gb_Liberado) and (Gb_Nivel = 0) then
        Begin
          Gb_Liberado := False;
          Result := True;
        end;
      End;
    finally
      freeAndNil(Lc_Form);
    end;
  end;
end;

procedure TFr_Lanca_Command.StrGrd_ProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var
  LcPromocao : String;
  LcQtde : REal;
  PReco : Real;
begin
  if Shift = [] then
  Begin
    if Key = vk_delete then
    begin
      if Fc_validaExcluiItemCupom then
      begin
        Pc_Log_Sistema( Gb_CodMha,
                        GB_Cd_Usuario,
                        now,
                        'Frente de Caixa',
                        Pedido.Registro.Codigo,
                       'Exclusão do item de venda',
                       'Produto: ' + StrGrd_Produtos.Cells[3,StrGrd_Produtos.Row]+ ' - ' + StrGrd_Produtos.Cells[4,StrGrd_Produtos.Row]);
        IF (StrToIntDef(StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row],0) > 0) then
        BEgin
          Fc_ApagarRegistro('TB_ITENS_AVL',['IAV_CODITF'],[StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row]]);
          Pc_Delete_Estoque('P',0,StrToIntDef(StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row],0));
          Pedido.Itens.Registro.Codigo := StrToIntDef(StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row],0);
          Pedido.Itens.delete;
        end;
        if It_Usa_Imp_Checkout then
        Begin
          //Imprimindo produto cancelado
          Pc_Imp_Cancela_Item_CupomNaoFiscal(StrGrd_Produtos.Row);
        end;
        LcPromocao  := StrGrd_Produtos.Cells[13,StrGrd_Produtos.Row];
        LcQtde      := StrToFloatDef(StrGrd_Produtos.Cells[15,StrGrd_Produtos.Row],0);
        Preco       := StrToFloatDef(StrGrd_Produtos.Cells[16,StrGrd_Produtos.Row],0);
        DeletaItemDaGrade(StrGrd_Produtos.Row);
        Pc_Promocao(LcPromocao,LcQtde,Preco);
        Pc_SomaProdutos;
        Pc_Totalizador;
      end;
    end;
  end;
end;

procedure TFr_Lanca_Command.DeletaItemDaGrade(Linha:Integer);
Var
  I :Integer;
  LcItemVenda : TItemVenda;
  Lc_Aux : Real;
begin
  FreeAndNil(ListaPedidoItem);
  ListaPedidoItem := TListaItemVenda.create;
  with StrGrd_Produtos do
  Begin
    For I := 1 to RowCount -1 do
    Begin
      if I <> Linha then
      Begin
        LcItemVenda := TItemVenda.Create;
        LcItemVenda.Produto       :=  StrToIntDef(Cells[2, I],0);
        LcItemVenda.Fabrica       :=  Cells[3, I];
        LcItemVenda.Descricao     :=  Cells[4, I];
        LcItemVenda.Quantidade    :=  StrToFloatDef(Cells[5,I],0);
        LcItemVenda.ValorVenda    :=  StrToFloatDef(Cells[6, I],0);
        //7 e o subtotal
        LcItemVenda.Abreviatura   :=  Cells[8, I];
        LcItemVenda.ValorCusto    :=  StrToFloatDef(Cells[9, I],0);
        LcItemVenda.ItemPedido    :=  StrToIntDef(Cells[10, I],0);
        LcItemVenda.ncm           :=  Cells[11, I];
        LcItemVenda.Origem        :=  Cells[12, I];
        LcItemVenda.Promocao      :=  Cells[13, I];
        LcItemVenda.ValorOriginal :=  StrToFloatDef(Cells[14, I],0);
        LcItemVenda.QtdePromocao  :=  StrToFloatDef(Cells[15, I],0);
        LcItemVenda.PrecoPromocao :=  StrToFloatDef(Cells[16, I],0);
        ListaPedidoItem.Add(LcItemVenda);
      End;
    End;
    //Preenche a Lista
    It_Nr_Item := 0;
    Pc_LimpaStringGrid(StrGrd_Produtos);
    //Pc_MontaGrid;
    for I := 0 to ListaPedidoItem.Count - 1 do
    Begin
      It_Nr_Item := It_Nr_Item + 1;
      RowCount      := It_Nr_Item + 1;
      Cells[1,  It_Nr_Item]  := StrZero(It_Nr_Item,3,0);
      Cells[2,  It_Nr_Item]  := ListaPedidoItem[I].Produto.ToString;
      Cells[3,  It_Nr_Item]  := ListaPedidoItem[I].Fabrica;
      Cells[4,  It_Nr_Item]  := ListaPedidoItem[I].Descricao;
      Cells[5,  It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].Quantidade, ffFixed, 10, 3);
      Cells[6,  It_Nr_Item]  := FormatFloat('#0.00###',ListaPedidoItem[I].ValorVenda);
      Lc_Aux := ListaPedidoItem[I].ValorVenda * ListaPedidoItem[I].Quantidade;
      Lc_Aux := RoundTo(Lc_Aux ,-2);
      Cells[7,  It_Nr_Item]  := FloatToStrF(Lc_Aux, ffFixed, 10, 2);
      Cells[8,  It_Nr_Item]  := ListaPedidoItem[I].Abreviatura;
      Cells[9,  It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].ValorCusto, ffFixed, 10, 2);
      Cells[10, It_Nr_Item]  := ListaPedidoItem[I].ItemPedido.ToString;
      Cells[11, It_Nr_Item]  := ListaPedidoItem[I].ncm;
      Cells[12, It_Nr_Item]  := ListaPedidoItem[I].Origem;
      Cells[13, It_Nr_Item]  := ListaPedidoItem[I].Promocao;
      Cells[14, It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].ValorOriginal, ffFixed, 10, 2);
      Cells[15, It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].QtdePromocao, ffFixed, 10, 2);
      Cells[16, It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].PRecoPromocao, ffFixed, 10, 2);
    End;
  End;
End;

procedure TFr_Lanca_Command.E_BuscaCodigoEnter(Sender: TObject);
begin
  E_BuscaCodigo.Color := clYellow;
  E_BuscaCodigo.SelectAll;
end;

procedure TFr_Lanca_Command.E_BuscaCodigoExit(Sender: TObject);
begin
  E_BuscaCodigo.Color := clScrollBar;
end;

procedure TFr_Lanca_Command.E_QtdeEnter(Sender: TObject);
begin
  E_Qtde.Color := clYellow;
end;

procedure TFr_Lanca_Command.E_QtdeExit(Sender: TObject);
begin
  E_Qtde.Color := clScrollBar;
  if E_Qtde.Text = '' then
    E_Qtde.Text := '1';
end;


procedure TFr_Lanca_Command.Cadastrodeproduto1Click(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    if StrToIntDef(StrGrd_Produtos.Cells[2, StrGrd_Produtos.Row],0) > 0 then
    Begin
      try
        Lc_Form := TFr_Produtos.Create(Self);
        Lc_Form.Produto.Registro.Codigo := StrToIntDef(StrGrd_Produtos.Cells[2, StrGrd_Produtos.Row],0);
        Lc_Form.ShowModal;
      finally
        FreeAndNil( Lc_Form );
      end;
    end;
  end;
end;


function TFr_Lanca_Command.CarregaItensCommand( PedidoID: Integer): Boolean;
Var
  I : Integer;
  LcItems : TControllerCheckOutItems;
Begin
  if PedidoID > 0 then
  Begin
    Try
      pedido.Clear;
      with Pedido do
      begin
        Registro.CodigoEstabelecimento := Gb_CodMha;
        Registro.Codigo := PedidoID;
        getbyId;
        //CheckOut Controller
        LcItems := TControllerCheckOutItems.Create(Self);
        LcItems.Registro.Estabelecimento := Gb_CodMha;
        LcItems.Registro.Pedido := PedidoID;
        LcItems.getList;
        if LcItems.Lista.Count > 0 then
        Begin
          It_Nr_Item := 0;
          Pc_LimpaStringGrid(StrGrd_Produtos);
          with StrGrd_Produtos, itens do
          Begin
            for I := 0 to LcItems.Lista.Count - 1 do
            Begin
              Pc_PreencheItensVenda(LcItems.Lista[I].CodigoProduto.ToString,
                                    LcItems.Lista[I].CodigoFabrica,
                                    LcItems.Lista[I].DescProduto,
                                    LcItems.Lista[I].Quantidade,
                                    LcItems.Lista[I].ValorUnitario,
                                    LcItems.Lista[I].Unidade,
                                    LcItems.Lista[I].PrecoCusto,
                                    LcItems.Lista[I].ncm,
                                    LcItems.Lista[I].Origem,
                                    LcItems.Lista[I].ValorUnitario);
            End;
          End;
        End;
        E_Qtde.Text := '1';
        Pc_SomaProdutos;
        Pc_Totalizador;
      end;
    Finally
      freeAndNil(LcItems);
    End;
  End;
end;

procedure TFr_Lanca_Command.ControleElementos(Painel:Tpanel; Ativo:Boolean);
Begin
  StrGrd_Produtos.Enabled := Ativo;
  E_BuscaCodigo.Enabled := Ativo;
  E_Qtde.Enabled := Ativo;
  Painel.Visible := not Ativo;
  if Ativo then
    E_BuscaCodigo.SetFocus
  else
    Painel.BringToFront;
End;

procedure TFr_Lanca_Command.Sb_Cancela_TabelaPrecoClick(Sender: TObject);
begin
  Pnl_TabelaPreco.Visible := False;
  ControleElementos(Pnl_TabelaPreco,True);
end;


procedure TFr_Lanca_Command.Lb_PesquisaClick(Sender: TObject);
begin
  Pc_TeclaAtalhoF6;
end;

procedure TFr_Lanca_Command.Lb_SalvarClick(Sender: TObject);
begin
  Pc_TeclaAtalhoF4;
end;

procedure TFr_Lanca_Command.Lb_F10Click(Sender: TObject);
begin
  Pc_TeclaAtalhoF10;
end;

procedure TFr_Lanca_Command.Lb_F4Click(Sender: TObject);
begin
  Pc_TeclaAtalhoF4;
end;

procedure TFr_Lanca_Command.Lb_F6Click(Sender: TObject);
begin
 Pc_TeclaAtalhoF6
end;

procedure TFr_Lanca_Command.Lb_FecharClick(Sender: TObject);
begin
  Pc_TeclaAtalhoF10;
end;

procedure TFr_Lanca_Command.LiberacaoExecute(Sender: TObject);
Var
  Form : TFr_Liberacao;
begin
  Form := TFr_Liberacao.Create(Self);
  with Form do
  begin
    Liberado := False;
    It_Interface := 'Fr_FrenteCaixa';
    It_Nome_Menu := 'Frente de Caixa';
    It_Privilegio := 'AUTORIZAR';
    ShowModal;
  end;
  freeAndNil(Form);
end;


procedure TFr_Lanca_Command.limparTela;
begin
  Pc_LimpaStringGrid(StrGrd_Produtos);
  Pc_LimpaCampos;
  Pc_SomaProdutos;
  Pc_Totalizador;
end;

procedure TFr_Lanca_Command.OcultaBarraTarefas(Visivel: Boolean);
begin
  Pc_SetTaskBar(Self,Visivel);
  OcultarBarradeTarefasWindows.Checked := Visivel;
end;

procedure TFr_Lanca_Command.OcultarBarradeTarefasWindowsClick(Sender: TObject);
begin
  if OcultarBarradeTarefasWindows.Checked then
  Begin
    OcultaBarraTarefas(true);
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','OCULTABARRAWINDOWS','N');
  End
  else
  Begin
    OcultaBarraTarefas(False);
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','OCULTABARRAWINDOWS','S');
  End;
end;

procedure TFr_Lanca_Command.Pc_ImprimeItemCheckout;
Begin
  //Utilizar sistemática de impressão item a item na leitura do produto no checkout
  if It_Usa_Imp_Checkout then
  Begin
    //'Imprimindo produto ao incluir
    if It_Nr_Item = 1 then
    Begin
      Pc_Imp_Abre_CupomNaoFiscal;
      Pc_Imp_Item_CupomNaoFiscal;
    end
    else
    Begin
      Pc_Imp_Item_CupomNaoFiscal;
    end;
  end;
end;

procedure TFr_Lanca_Command.Pc_Imp_Abre_CupomNaoFiscal;
Var
  Lc_I : Integer;
  Lc_Imp: TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.Create(Nil);
    Lc_Imp.It_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
    if Trim(Lc_Imp.It_Porta) = '' then Lc_Imp.It_Porta := 'LPT1';
    Lc_Imp.It_FRow:=1;
    Lc_Imp.It_FCol:=1;
    It_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
    It_ColunaCentro := Trunc(It_Nr_Colunas/2);
    case It_Tp_Impressao of
      0:Begin
          //Gera novo Registro para o Pedido
          Pc_GeraPedido;
          //Desabilitar o Alt+F4
          RegisterHotkey(Self.Handle, 1, MOD_ALT , VK_f4);
          //Desabilitar o Ctrl+Alt+Del
          RegisterHotkey(Self.Handle, 2, MOD_CONTROL, MOD_ALT);
          Application.ProcessMessages;
          AssignFile(Lc_Imp.It_Arquivo,Lc_Imp.It_Porta);
          Rewrite(Lc_Imp.It_Arquivo);
          Lc_Imp.It_FRow:=1;
          Lc_Imp.It_FCol:=1;
          It_Linha := 1;
          //Define o tamanhho do Traço
          It_Traco := '';
          For Lc_I:= 1 to It_Nr_Colunas do
            It_Traco := It_Traco + '-';
          Pc_AtivaEstabelecimento;
          if Qr_Pedido.RecordCount > 0 then
          begin
            DM.Qr_Endereco.Active := False;
            DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_Pedido.FieldByname('PED_CODEMP').AsInteger;
            DM.Qr_Endereco.Active := true;
          end;
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString,It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('END_Numero').AsString,It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString,It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString),It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('N.: ' + IntToStr(self.It_NR_Pedido)  + '   ' + DateToStr(Date),It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(It_traco,It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('Descricao dos Produtos  ',It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('Qte    VL. Unitario                    Sub-Total',It_Nr_Colunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(It_traco,It_Nr_Colunas));
          CloseFile(Lc_Imp.It_Arquivo);
          //Finaliza o Cupom
          Lc_Imp.Pc_FinalizaCupom(0);
        end;
      1:Begin
          {with Fr_Principal.RdPrint_DP do
          Begin
            // Cabeçalho do Cupom...
            abrir;
            It_Linha := 1; // Linhas (deve ser 1 quando for CUPOM)
            TamanhoQteLinhas := 1;
            //Define o tamanhho do Traço
            It_Traco := '';
            For Lc_I:= 1 to It_Nr_Colunas do
              It_Traco := It_Traco + '-';

            FonteTamanhoPadrao := s20cpp; // Fonte Comprimido em 20 cpp
            Acentuacao := Transliterate;
            if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') = 'S') then
              OpcoesPreview.Preview := True
            else
              OpcoesPreview.Preview := False;
            Pc_AtivaEstabelecimento;

            if Qr_Pedido.RecordCount > 0 then
              begin
              DM.Qr_Endereco.Active := False;
              DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_Pedido.FieldByname('PED_CODEMP').AsInteger;
              DM.Qr_Endereco.Active := true;
              end;
            impc(01, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString, [comp17]);
            impc(02, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString, [comp17]);
            impc(03, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString, [comp17]);
            impc(04, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString, [comp17]);
            impc(05, It_ColunaCentro, fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString), [comp17]);
            imp(06, 01, 'Nº ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString + '   ' + Qr_Pedido.FieldByname('PED_DATA').AsString);

            imp(07, 01, It_traco);
            imp(08, 01, 'Descriçao dos Produtos  ');
            imp(09, 01, 'Qte    VL. Unitário                    Sub-Total');
            imp(10, 01, It_traco);
          end;}
        end;
    end;
  Finally
    FreeandNil(Lc_Imp);
  end;
end;

procedure TFr_Lanca_Command.Pc_Imp_Item_CupomNaoFiscal;
Var
  Lc_Imp: TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.Create(Nil);
    Lc_Imp.It_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
    if Trim(Lc_Imp.It_Porta) = '' then Lc_Imp.It_Porta := 'LPT1';
    case It_Tp_Impressao of
      0:Begin
          AssignFile(Lc_Imp.It_Arquivo,Lc_Imp.It_Porta);
          Rewrite(Lc_Imp.It_Arquivo);
          Lc_Imp.It_FRow:=1;
          Lc_Imp.It_FCol:=1;
          It_Linha := 1;
          //Descrição do Produto
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(Copy(StrGrd_Produtos.Cells[4, It_Nr_Item],1,It_Nr_Colunas),it_Nr_Colunas));
          //Quantidade
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(StrGrd_Produtos.Cells[5, It_Nr_Item],9));
          Lc_Imp.Pc_TextOutLC(It_Linha,11,Lc_Imp.Pc_AlinhaE( ' X ',3));
          //Valor Unitario
          Lc_Imp.Pc_TextOutLC(IT_Linha,15,Lc_Imp.Pc_AlinhaD(StrGrd_Produtos.Cells[6, It_Nr_Item],14));
          //Subtotal
          Lc_Imp.Pc_TextOutLC(It_Linha,34,Lc_Imp.Pc_AlinhaD(StrGrd_Produtos.Cells[7, It_Nr_Item],14));
          CloseFile(Lc_Imp.It_Arquivo);
          //Finaliza o Cupom
          Lc_Imp.Pc_FinalizaCupom(0);
        end;
      1:Begin
          {with Fr_Principal.RdPrint_DP do
          Begin
            //Descrição do Produto
            imp(It_linha, 01, Copy(StrGrd_Produtos.Cells[4, It_Nr_Item] ,1,It_Nr_Colunas));
            Inc(It_linha);
            //Quantidade
            imp(It_linha, 01, FormatFloat('#0.###', StrToFloatDef(StrGrd_Produtos.Cells[5, It_Nr_Item],0)));
            imp(It_linha, 08, ' X ');
            //Valor Unitario
            imp(It_linha, 11, FormatFloat('#0.###', StrToFloatDef(StrGrd_Produtos.Cells[6, It_Nr_Item],0)));
            //SubTotal
            impval(It_linha, 35, '###,###,##0.00', StrToFloatDef(StrGrd_Produtos.Cells[7, It_Nr_Item],0), []);
            IF It_linha > 70 THEN
            begin
              Novapagina;
              It_linha:=1;
            end
            else
            Begin
              inc(It_linha);
            end;
          end;}
        end;
    end;
  Finally
    FreeandNil(Lc_Imp);
  end;
end;

Procedure TFr_Lanca_Command.Pc_Imp_Cancela_Item_CupomNaoFiscal;
Var
  Lc_Valor : Real;
  Lc_Imp: TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.Create(Nil);
    Lc_Imp.It_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
    AssignFile(Lc_Imp.It_Arquivo,Lc_Imp.It_Porta);
    Rewrite(Lc_Imp.It_Arquivo);
    Lc_Imp.It_FRow:=1;
    Lc_Imp.It_FCol:=1;
    It_Linha := 1;
    //Descrição do Produto
    Inc(It_linha);
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(Copy(StrGrd_Produtos.Cells[4, It_Nr_Item],1,It_Nr_Colunas),it_Nr_Colunas - 12));
    //Mensagem de Cancelado
    Lc_Imp.Pc_TextOutLC(IT_Linha,it_Nr_Colunas - 11,Lc_Imp.Pc_AlinhaE('(CANCELADO)',9));
    //Quantidade
    Inc(It_linha);
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaD(StrGrd_Produtos.Cells[5, It_Nr_Item],9));
    Lc_Imp.Pc_TextOutLC(It_Linha,11,Lc_Imp.Pc_AlinhaE( ' X ',3));
    //Valor Unitario
    Lc_Valor := StrToFloatDef(StrGrd_Produtos.Cells[6, It_Nr_Item],0) * -1;
    Lc_Imp.Pc_TextOutLC(IT_Linha,15,Lc_Imp.Pc_AlinhaD(FloattoStrF(Lc_Valor,ffFixed,10,2),14));
    //Subtotal
    Lc_Valor := StrToFloatDef(StrGrd_Produtos.Cells[7, It_Nr_Item],0) * -1;
    Lc_Imp.Pc_TextOutLC(It_Linha,34,Lc_Imp.Pc_AlinhaD(FloattoStrF(Lc_Valor,ffFixed,10,2),14));
    CloseFile(Lc_Imp.It_Arquivo);
    //Finaliza o Cupom
    Lc_Imp.Pc_FinalizaCupom(0);
  finally
    FreeandNil(Lc_Imp);
  end;
end;

function TFr_Lanca_Command.validaNumeroComanda(pMsg:Boolean): Boolean;
begin
  REsult := True;
  if (Length(Trim(E_Numero_Comanda.Text)) <> 4) then
  Begin
    if pMsg then
    BEgin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Número de comanda deve ter pelo menos 4 dígitos.' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      E_Numero_Comanda.SetFocus;
    End;
    result := False;
    exit;
  end;
  if ( Copy(Trim(E_Numero_Comanda.Text),1,1) <>'0') then
  Begin
    if pMsg then
    BEgin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Número de comanda deve iniciar com dígito 0(zero).' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      E_Numero_Comanda.SetFocus;
    End;
    result := False;
    exit;
  end;

  if ( StrToIntDef(Trim(E_Numero_Comanda.Text),0) =0 ) then
  Begin
    if pMsg then
    BEgin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Número de comanda deve ser maior do que 0(zero).' + EOLN +
                     '  Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      E_Numero_Comanda.SetFocus;
    End;
    result := False;
    exit;
  end;
end;

procedure TFr_Lanca_Command.E_BuscaCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  Begin
    if validaNumeroComanda(True) then
      Fc_LancaItem;
  End;
end;

procedure TFr_Lanca_Command.E_Numero_ComandaEnter(Sender: TObject);
begin
  TEdit(Sender).Color := clYellow;
  TEdit(Sender).SelectAll;
end;

procedure TFr_Lanca_Command.E_Numero_ComandaExit(Sender: TObject);
begin
  TEdit_Setes(sender).Color := clWindow;
end;

procedure TFr_Lanca_Command.E_Numero_ComandaKeyPress(Sender: TObject;
  var Key: Char);
Var
  LcID : Integer;
begin
  if (Key = #13) then
  Begin
    if validaNumeroComanda(True) then
    Begin
      LcID := getPedidoByCommand( E_Numero_Comanda.Text );
      if LcID > 0 then
      BEgin
        CarregaItensCommand( LcID );
      End
      else
      Begin
        MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                       'Commanda não encontrada.' + EOLN +
                       'Uma nova comanda com este número será registrada.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Pc_LimpaStringGrid(StrGrd_Produtos);
        Pedido.clear;
        E_Vl_Pedido.Caption := '0,00';
        Lb_Item_lancado.Caption := 'Lançar item';
        It_Nr_Item := 0;
        FreeAndNil(ListaPedidoItem);
        ListaPedidoItem := TListaItemVenda.create;
        Pc_SomaProdutos;
        Pc_Totalizador;
      end;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    End;
  End;
end;

procedure TFr_Lanca_Command.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if not (ActiveControl is TEdit_Setes) then
    Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
  end;
end;

procedure TFr_Lanca_Command.E_QtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    E_BuscaCodigo.SetFocus;
end;

procedure TFr_Lanca_Command.DadosNCM1Click(Sender: TObject);
Var
  Lc_Form : TFr_ncm;
begin
  Try
    Lc_Form := TFr_ncm.Create(Self);
    Lc_Form.It_Cd_Ncm := StrGrd_Produtos.Cells[11, StrGrd_Produtos.row];
    Lc_Form.ShowModal;
    StrGrd_Produtos.Cells[11,StrGrd_Produtos.Row] := Lc_Form.It_Cd_Ncm;
  Finally
    freeAndNil(Lc_Form);
  End;
end;

procedure TFr_Lanca_Command.E_Peso_LiquidoManualEnter(Sender: TObject);
begin
  (Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_Lanca_Command.E_Aq_DescontoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Lanca_Command.E_Vl_DescontoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Lanca_Command.E_VL_UnitarioEnter(Sender: TObject);
begin
(Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_Lanca_Command.E_Vl_UnitarioManualEnter(Sender: TObject);
begin
(Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_Lanca_Command.AbrirTelaTabelaPreco;
Begin


End;

function TFr_Lanca_Command.ValidaItensNaLista: Boolean;
Var
  I : Integer;
begin
  Result := True;
  for I := 1 to StrGrd_Produtos.RowCount-1 do
  Begin
    if (StrGrd_Produtos.Cells[2,I]) = '' then
    Begin
      Result := False;
      break;
    End;
  End;
end;


function TFr_Lanca_Command.ValidaTrocaTabela:Boolean;
Begin
  Result := True;
  if ( Fm_ListaTabelaPreco.Dblcb_Lista.Text = '' ) then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe uma tabela válida.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result:=false;
    exit;
  End;
End;

Procedure TFr_Lanca_Command.EscolheTabela;
Begin
  ControleElementos(Pnl_TabelaPreco,false);
  Fm_ListaTabelaPreco.Listar(It_Cd_Tabela);
  Fm_ListaTabelaPreco.Dblcb_Lista.SetFocus;
  Application.ProcessMessages
End;

Function TFr_Lanca_Command.EfetuaCopiaItem(ItemVenda : TItemVenda;Qtde:Real;TipoPreco:String):TItemVenda;
Begin
  Result := TItemVenda.Create;
  with Result do
  Begin
    Produto         := ItemVenda.Produto;
    ValorOriginal   := ItemVenda.ValorOriginal;
    ValorCusto      := ItemVenda.ValorCusto;
    Fabrica         := ItemVenda.Fabrica;
    if TipoPreco = 'P' then
      ValorVenda      := ItemVenda.ValorVenda    //Promoção
    else
      ValorVenda      := ItemVenda.ValorOriginal; //Original
    Descricao       := ItemVenda.Descricao;
    ncm             := ItemVenda.ncm;
    Promocao        := ItemVenda.Promocao;
    Quantidade      := Qtde;
    Abreviatura     := ItemVenda.Abreviatura;
    Origem          := ItemVenda.Origem;
    ItemPedido      := ItemVenda.ItemPedido;
    QtdePromocao    := ItemVenda.QtdePromocao;
    PrecoPromocao   := ItemVenda.PrecoPromocao;
  End;
End;

procedure TFr_Lanca_Command.TratarRestoPromocao(QtdePromocao,QtdeTotal:Real;ListaItem: TListaItemVenda);
Var
  I : Integer;

  Dividendo : Real;
  Divisor   : Real;
  Quociente : Integer;
  Resto     : Real;
  //
  ListaTemp   : TListaItemVenda;
  SaldoPromocao : Real;
  SaldoItem   : Real;

begin
  ListaTemp := TListaItemVenda.create;
  //Para saber a quantiade de produtos que estaré na promoção
  Dividendo := QtdeTotal;
  Divisor := QtdePromocao;
  Quociente := Trunc(Dividendo / Divisor);
  SaldoPromocao := (Quociente * Divisor);
  //Verficar qual item tem a maior quantidade e quarda o Indice da lista
  for I := 0 to ListaItem.Count - 1 do
  Begin
    if ( SaldoPromocao > 0 ) then
    Begin
      // -2                     7            5
      SaldoItem := ListaItem[I].Quantidade - SaldoPromocao; //QtdePromocao;
      if (SaldoItem = 0 ) then
      Begin
        ListaTemp.add( EfetuaCopiaItem(ListaItem[I],ListaItem[I].Quantidade,'P') );
        SaldoPromocao := SaldoPromocao -  ListaItem[I].Quantidade;
      end
      else
      Begin
        if (SaldoItem < 0 ) then
        Begin
          // -2 = 3 - 5;
          ListaTemp.add( EfetuaCopiaItem(ListaItem[I],ListaItem[I].Quantidade,'P') );
          SaldoPromocao := SaldoPromocao -  ListaItem[I].Quantidade;
        end
        else
        Begin
          //2 = 7 - 5;
          Resto     := ListaItem[I].Quantidade - SaldoPromocao;
          ListaTemp.add( EfetuaCopiaItem(ListaItem[I],(ListaItem[I].Quantidade - Resto),'P') );
          SaldoPromocao := SaldoPromocao -  (ListaItem[I].Quantidade - Resto);
          if Resto > 0 then
          Begin
            if (Resto <= SaldoPromocao) and ( SaldoPromocao > 0 ) then
            Begin
              ListaTemp.add( EfetuaCopiaItem(ListaItem[I],Resto,'P') );
              SaldoPromocao := SaldoPromocao -  Resto;
            End
            else
            Begin
              ListaTemp.add( EfetuaCopiaItem(ListaItem[I],Resto,'N') );
            End;
          End;
        end;
      end;
    end
    else
    Begin
      //Esta Fora da Promoção
      ListaTemp.add( EfetuaCopiaItem(ListaItem[I],ListaItem[I].Quantidade,'N') );
    end;
  end;
  ListaItem.Clear;
  for I := 0 to ListaTemp.Count - 1 do
  Begin
      ListaItem.add(ListaTemp[I]);
  End;
end;

procedure TFr_Lanca_Command.TrocaTabela;
Var
  I : Integer;
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('SELECT PRC_VL_VDA '+
              'FROM TB_PRECO '+
              'WHERE (PRC_CODTPR =:PRC_CODTPR) '+
              ' AND ( PRC_CODPRO =:PRC_CODPRO) ');
    End;

    with StrGrd_Produtos do
    Begin
      for I := 1 to ( RowCount - 1 ) do
      Begin
        Lc_Qry.Active := False;
        Lc_Qry.ParamByName('PRC_CODTPR').AsInteger := It_cd_Tabela;
        Lc_Qry.ParamByName('PRC_CODPRO').AsInteger := StrToIntDef( Cells[2, I],0);
        Lc_Qry.Active := True;
        Lc_Qry.FetchAll;
        //Altera o valor Unitario
        Lc_Qtde := StrToFloatDef(Cells[5, I],0);
        Lc_Valor := Lc_Qry.FieldByName('PRC_VL_VDA').AsCurrency;
        Cells[6, I] := FormatFloat('#0.00###',Lc_Valor );
        Lc_Valor := Lc_Valor * Lc_Qtde;
        Lc_Valor := RoundTo( Lc_Valor, -2);
        Cells[7, I] := FloatToStrF(Lc_Valor, ffFixed, 10, 2);
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
End;

procedure TFr_Lanca_Command.Sb_Confirma_TabelaPrecoClick(Sender: TObject);
begin
  if ValidaTrocaTabela then
  Begin
    It_cd_Tabela := Fm_ListaTabelaPreco.Dblcb_Lista.KeyValue;
    TrocaTabela;
    Pc_SomaProdutos;
    Pc_Totalizador;
    ControleElementos(Pnl_TabelaPreco,True);
  End;
end;

procedure TFr_Lanca_Command.GoCodigoClienteExecute(Sender: TObject);
begin
//  E_Cd_Cliente.SetFocus;
end;

//============================== TEF=========================================
procedure TFr_Lanca_Command.ImprimeComprovante(c:TStringList);
VAR
  PrtGeneral : TGeneralPrint;
  I : Integer;
  Lc_Porta : String;
  Lcmodelo : Integer;
  Lc_Saltos : Integer;
Begin
  Lcmodelo := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL','1'),0);
  Lc_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
  Lc_Saltos := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'),2);
  if Lcmodelo = 1 then
  Begin
    PrtGeneral := TPrintGeneralFactory.criarPrint('EPSON - TM-T20');
    With PrtGeneral Do
    begin
      Porta := Lc_Porta;
      Iniciar;
      for I := 0 to c.Count - 1 do
        TextOutLC(1,1,c.Strings[I]);
      Saltar(Lc_Saltos);
      CortarPapel(0);
      Fechar;
    end;
    FreeAndNil(PrtGeneral);
  End
  else
  Begin
    try
      PrtGeneral := TPrintGeneralFactory.criarPrint('BEMATECH - MP4200');
      with  PrtGeneral do
      Begin
        case Lcmodelo of
          2:ModeloImpressora := 7;
          3:ModeloImpressora := 5;
          4:ModeloImpressora := 5;
          6:ModeloImpressora := 8;
        end;
        Porta := Lc_Porta;
        TamanhoMargem := 3;
        Iniciar;
        for I := 0 to c.Count - 1 do
          TextOutLC(1,1,c.Strings[I]);
        Saltar(Lc_Saltos);
        CortarPapel(0);
        Fechar;
      End;
    finally
      FreeAndNil(PrtGeneral);
    end;
  End

END;

procedure TFr_Lanca_Command.InitVariable;
begin
  Pedido    := TControllerPedidoVda.Create(Self);
  Promocao  := TControllerDskPromotion.Create(Self);
  ListaPedidoItem := TListaItemVenda.Create;
end;


procedure TFr_Lanca_Command.MnuConsultarComandaClick(Sender: TObject);
begin
  ConsultarCommand;
end;

procedure TFr_Lanca_Command.ConsultarCommand;
var
  Form :TSeaCommand;
begin
  try
    Form := TSeaCommand.Create(Self);
    Form.ShowModal;
    if Form.Visualizar then
    BEgin
      CarregaItensCommand(StrToIntDef(Form.Grd_Pesquisa.cells[4,Form.Grd_Pesquisa.Row],0));
    End;
  finally
    freeAndNil(Form);
  end;
end;


end.



